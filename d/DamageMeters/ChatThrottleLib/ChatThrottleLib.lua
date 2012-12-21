--
-- ChatThrottleLib by Mikk
--
-- Manages AddOn chat output to keep player from getting kicked off.
--
-- ChatThrottleLib.SendChatMessage/.SendAddonMessage functions that accept 
-- a Priority ("BULK", "NORMAL", "ALERT") as well as prefix for SendChatMessage.
--
-- Priorities get an equal share of available bandwidth when fully loaded.
-- Communication channels are separated on extension+chattype+destination and
-- get round-robinned. (Destination only matters for whispers and channels,
-- obviously)
--
-- Will install hooks for SendChatMessage and SendAdd[Oo]nMessage to measure
-- bandwidth bypassing the library and use less bandwidth itself.
--
--
-- Fully embeddable library. Just copy this file into your addon directory,
-- add it to the .toc, and it's done.
--
-- Can run as a standalone addon also, but, really, just embed it! :-)
--

local CTL_VERSION = 11

local MAX_CPS = 1000			-- 2000 seems to be safe if NOTHING ELSE is happening. let's call it 1000.
local MSG_OVERHEAD = 40		-- Guesstimate overhead for sending a message; source+dest+chattype+protocolstuff

local BURST = 8000				-- WoW's server buffer seems to be about 32KB. Let's use 25% of it for our lib.

local MIN_FPS = 20					-- Reduce output CPS to half (and don't burst) if FPS drops below this value

if(ChatThrottleLib and ChatThrottleLib.version>=CTL_VERSION) then
	-- There's already a newer (or same) version loaded. Buh-bye.
	return;
end



if(not ChatThrottleLib) then
	ChatThrottleLib = {}
end

ChatThrottleLib.version=CTL_VERSION;


-----------------------------------------------------------------------
-- Double-linked ring implementation

local Ring = {}
local RingMeta = { __index=Ring }

function Ring:New()
	local ret = {}
	setmetatable(ret, RingMeta)
	return ret;
end

function Ring:Add(obj)	-- Append at the "far end" of the ring (aka just before the current position)
	if(self.pos) then
		obj.prev = self.pos.prev;
		obj.prev.next = obj;
		obj.next = self.pos;
		obj.next.prev = obj;
	else
		obj.next = obj;
		obj.prev = obj;
		self.pos = obj;
	end
end

function Ring:Remove(obj)
	obj.next.prev = obj.prev;
	obj.prev.next = obj.next;
	if(self.pos == obj) then
		self.pos = obj.next;
		if(self.pos == obj) then
			self.pos = nil;
		end
	end
end



-----------------------------------------------------------------------
-- Recycling bin for pipes (kept in a linked list because that's 
-- how they're worked with in the rotating rings; just reusing members)

ChatThrottleLib.PipeBin = { count=0 }

function ChatThrottleLib.PipeBin:Put(pipe)
	for i=getn(pipe),1,-1 do
		tremove(pipe, i);
	end
	pipe.prev = nil;
	pipe.next = self.list;
	self.list = pipe;
	self.count = self.count+1;
end

function ChatThrottleLib.PipeBin:Get()
	if(self.list) then
		local ret = self.list;
		self.list = ret.next;
		ret.next=nil;
		self.count = self.count - 1;
		return ret;
	end
	return {};
end

function ChatThrottleLib.PipeBin:Tidy()
	if(self.count < 25) then
		return;
	end
		
	if(self.count > 100) then
		n=self.count-90;
	else
		n=10;
	end
	for i=2,n do
		self.list = self.list.next;
	end
	local delme = self.list;
	self.list = self.list.next;
	delme.next = nil;
end




-----------------------------------------------------------------------
-- Recycling bin for messages

ChatThrottleLib.MsgBin = {}

function ChatThrottleLib.MsgBin:Put(msg)
	msg.text = nil;
	tinsert(self, msg);
end

function ChatThrottleLib.MsgBin:Get()
	local ret = tremove(self, getn(self));
	if(ret) then return ret; end
	return {};
end

function ChatThrottleLib.MsgBin:Tidy()
	if(getn(self)<50) then
		return;
	end
	if(getn(self)>150) then	 -- "can't happen" but ...
		for n=getn(self),120,-1 do
			tremove(self,n);
		end
	else
		for n=getn(self),getn(self)-20,-1 do
			tremove(self,n);
		end
	end
end


-----------------------------------------------------------------------
-- ChatThrottleLib:Init
-- Initialize queues, set up frame for OnUpdate, etc


function ChatThrottleLib:Init()	
	
	-- Set up queues
	if(not self.Prio) then
		self.Prio = {}
		self.Prio["ALERT"] = { ByName={}, Ring = Ring:New(), avail=0 };
		self.Prio["NORMAL"] = { ByName={}, Ring = Ring:New(), avail=0 };
		self.Prio["BULK"] = { ByName={}, Ring = Ring:New(), avail=0 };
	end
	
	-- v4: total send counters per priority
	for _,Prio in self.Prio do
		Prio.nTotalSent = Prio.nTotalSent or 0;
	end
	
	self.avail = self.avail or 0;							-- v5
	self.nTotalSent = self.nTotalSent or 0;		-- v5

	
	-- Set up a frame to get OnUpdate events
	if(not self.Frame) then
		self.Frame = CreateFrame("Frame");
		self.Frame:Hide();
	end
	self.Frame.Show = self.Frame.Show; -- cache for speed
	self.Frame.Hide = self.Frame.Hide; -- cache for speed
	self.Frame:SetScript("OnUpdate", self.OnUpdate);
	self.Frame:SetScript("OnEvent", self.OnEvent);	-- v11: Monitor P_E_W so we can throttle hard for a few seconds
	self.Frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	self.OnUpdateDelay=0;
	self.LastAvailUpdate=GetTime();
	self.HardThrottlingBeginTime=GetTime();	-- v11: Throttle hard for a few seconds after startup
	
	-- Hook SendChatMessage and SendAddonMessage so we can measure unpiped traffic and avoid overloads (v7)
	if(not self.ORIG_SendChatMessage) then
		--SendChatMessage
		self.ORIG_SendChatMessage = SendChatMessage;
		SendChatMessage = function(a1,a2,a3,a4) return ChatThrottleLib.Hook_SendChatMessage(a1,a2,a3,a4); end
		--SendAdd[Oo]nMessage
		if(SendAddonMessage or SendAddOnMessage) then -- v10: don't pretend like it doesn't exist if it doesn't!
			self.ORIG_SendAddonMessage = SendAddonMessage or SendAddOnMessage;
			SendAddonMessage = function(a1,a2,a3) return ChatThrottleLib.Hook_SendAddonMessage(a1,a2,a3); end
			if(SendAddOnMessage) then		-- in case Slouken changes his mind...
				SendAddOnMessage = SendAddonMessage;
			end
		end
	end
	self.nBypass = 0;
end


-----------------------------------------------------------------------
-- ChatThrottleLib.Hook_SendChatMessage / .Hook_SendAddonMessage
function ChatThrottleLib.Hook_SendChatMessage(text, chattype, language, destination)
	local self = ChatThrottleLib;
	local size = strlen(text or "") + strlen(chattype or "") + strlen(destination or "") + 40;
	self.avail = self.avail - size;
	self.nBypass = self.nBypass + size;
	return self.ORIG_SendChatMessage(text, chattype, language, destination);
end
function ChatThrottleLib.Hook_SendAddonMessage(prefix, text, chattype)
	local self = ChatThrottleLib;
	local size = strlen(text or "") + strlen(chattype or "") + strlen(prefix or "") + 40;
	self.avail = self.avail - size;
	self.nBypass = self.nBypass + size;
	return self.ORIG_SendAddonMessage(prefix, text, chattype);
end



-----------------------------------------------------------------------
-- ChatThrottleLib:UpdateAvail
-- Update self.avail with how much bandwidth is currently available

function ChatThrottleLib:UpdateAvail()
	local now = GetTime();
	local newavail = MAX_CPS * (now-self.LastAvailUpdate);

	if(now - self.HardThrottlingBeginTime < 5) then
		-- First 5 seconds after startup/zoning: VERY hard clamping to avoid irritating the server rate limiter, it seems very cranky then
		self.avail = min(self.avail + (newavail*0.1), MAX_CPS*0.5);
	elseif(GetFramerate()<MIN_FPS) then		-- GetFrameRate call takes ~0.002 secs
		newavail = newavail * 0.5;
		self.avail = min(MAX_CPS, self.avail + newavail);
		self.bChoking = true;		-- just for stats
	else
		self.avail = min(BURST, self.avail + newavail);
		self.bChoking = false;
	end
	
	self.avail = max(self.avail, 0-(MAX_CPS*2));	-- Can go negative when someone is eating bandwidth past the lib. but we refuse to stay silent for more than 2 seconds; if they can do it, we can.
	self.LastAvailUpdate = now;
	
	return self.avail;
end


-----------------------------------------------------------------------
-- Despooling logic

function ChatThrottleLib:Despool(Prio)
	local ring = Prio.Ring;
	while(ring.pos and Prio.avail>ring.pos[1].nSize) do
		local msg = tremove(Prio.Ring.pos, 1);
		if(not Prio.Ring.pos[1]) then
			local pipe = Prio.Ring.pos;
			Prio.Ring:Remove(pipe);
			Prio.ByName[pipe.name] = nil;
			self.PipeBin:Put(pipe);
		else
			Prio.Ring.pos = Prio.Ring.pos.next;
		end
		Prio.avail = Prio.avail - msg.nSize;
		msg.f(msg[1], msg[2], msg[3], msg[4]);
		Prio.nTotalSent = Prio.nTotalSent + msg.nSize;
		self.MsgBin:Put(msg);
	end
end


function ChatThrottleLib:OnEvent()
	-- v11: We know that the rate limiter is touchy after login. Assume that it's touch after zoning, too.
	self = ChatThrottleLib;
	if(event == "PLAYER_ENTERING_WORLD") then
		self.HardThrottlingBeginTime=GetTime();	-- Throttle hard for a few seconds after zoning
		self.avail = 0;
	end
end


function ChatThrottleLib:OnUpdate()
	self = ChatThrottleLib;
	
	self.OnUpdateDelay = self.OnUpdateDelay + arg1;
	if(self.OnUpdateDelay < 0.08) then
		return;
	end
	self.OnUpdateDelay = 0;
	
	self:UpdateAvail();
	
	if(self.avail<0) then
		return; -- argh. some bastard is spewing stuff past the lib. just bail early to save cpu.
	end

	-- See how many of or priorities have queued messages
	local n=0;
	for prioname,Prio in pairs(self.Prio) do
		if(Prio.Ring.pos or Prio.avail<0) then 
			n=n+1; 
		end
	end
	
	-- Anything queued still?
	if(n<1) then
		-- Nope. Move spillover bandwidth to global availability gauge and clear self.bQueueing
		for prioname,Prio in pairs(self.Prio) do
			self.avail = self.avail + Prio.avail;
			Prio.avail = 0;
		end
		self.bQueueing = false;
		self.Frame:Hide();
		return;
	end
	
	-- There's stuff queued. Hand out available bandwidth to priorities as needed and despool their queues
	local avail= self.avail/n;
	self.avail = 0;
	
	for prioname,Prio in pairs(self.Prio) do
		if(Prio.Ring.pos or Prio.avail<0) then
			Prio.avail = Prio.avail + avail;
			if(Prio.Ring.pos and Prio.avail>Prio.Ring.pos[1].nSize) then
				self:Despool(Prio);
			end
		end
	end

	-- Expire recycled tables if needed	
	self.MsgBin:Tidy();
	self.PipeBin:Tidy();
end




-----------------------------------------------------------------------
-- Spooling logic


function ChatThrottleLib:Enqueue(prioname, pipename, msg)
	local Prio = self.Prio[prioname];
	local pipe = Prio.ByName[pipename];
	if(not pipe) then
		self.Frame:Show();
		pipe = self.PipeBin:Get();
		pipe.name = pipename;
		Prio.ByName[pipename] = pipe;
		Prio.Ring:Add(pipe);
	end
	
	tinsert(pipe, msg);
	
	self.bQueueing = true;
end



function ChatThrottleLib:SendChatMessage(prio, prefix,   text, chattype, language, destination)
	if(not (self and prio and text and self.Prio[prio] ) ) then
		error('Usage: ChatThrottleLib:SendChatMessage("{BULK||NORMAL||ALERT}", "prefix" or nil, "text"[, "chattype"[, "language"[, "destination"]]]', 0);
	end
	
	prefix = prefix or tostring(this);		-- each frame gets its own queue if prefix is not given
	
	local nSize = strlen(text) + MSG_OVERHEAD;
	
	-- Check if there's room in the global available bandwidth gauge to send directly
	if(not self.bQueueing and nSize < self:UpdateAvail()) then
		self.avail = self.avail - nSize;
		self.ORIG_SendChatMessage(text, chattype, language, destination);
		self.Prio[prio].nTotalSent = self.Prio[prio].nTotalSent + nSize;
		return;
	end
	
	-- Message needs to be queued
	msg=self.MsgBin:Get();
	msg.f=self.ORIG_SendChatMessage
	msg[1]=text;
	msg[2]=chattype or "SAY";
	msg[3]=language;
	msg[4]=destination;
	msg.n = 4
	msg.nSize = nSize;

	self:Enqueue(prio, string.format("%s/%s/%s", prefix, chattype, destination or ""), msg);
end


function ChatThrottleLib:SendAddonMessage(prio,   prefix, text, chattype)
	if(not (self and prio and prefix and text and chattype and self.Prio[prio] ) ) then
		error('Usage: ChatThrottleLib:SendAddonMessage("{BULK||NORMAL||ALERT}", "prefix", "text", "chattype")', 0);
	end
	
	local nSize = strlen(prefix) + 1 + strlen(text) + MSG_OVERHEAD;
	
	-- Check if there's room in the global available bandwidth gauge to send directly
	if(not self.bQueueing and nSize < self:UpdateAvail()) then
		self.avail = self.avail - nSize;
		self.ORIG_SendAddonMessage(prefix, text, chattype);
		self.Prio[prio].nTotalSent = self.Prio[prio].nTotalSent + nSize;
		return;
	end
	
	-- Message needs to be queued
	msg=self.MsgBin:Get();
	msg.f=self.ORIG_SendAddonMessage;
	msg[1]=prefix;
	msg[2]=text;
	msg[3]=chattype;
	msg.n = 3
	msg.nSize = nSize;
	
	self:Enqueue(prio, string.format("%s/%s", prefix, chattype), msg);
end




-----------------------------------------------------------------------
-- Get the ball rolling!

ChatThrottleLib:Init();

--[[ WoWBench debugging snippet
if(WOWB_VER) then
	local function SayTimer()
		print("SAY: "..GetTime().." "..arg1);
	end
	ChatThrottleLib.Frame:SetScript("OnEvent", SayTimer);
	ChatThrottleLib.Frame:RegisterEvent("CHAT_MSG_SAY");
end
]]


