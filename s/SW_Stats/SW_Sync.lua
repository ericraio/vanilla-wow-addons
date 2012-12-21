--[[
	The SW Sync Channel
	
]]--

SW_SyncPassiveMode = false;

SW_SyncMsgs = {};

SW_S_DetailsSynced = {};
SW_S_HealedSynced = {};

--1.5 added deathcounter to sync
SW_DCSynced = {};

--1.5.1 added decurse count syncing
SW_DecurseCSynced = {};

-- holds "lost" mana info
SW_ManaAfterDrop = {0,0,0};

SW_SyncSessionID = 1;

SW_SyncChanID = 0;
-- var that hold info if we are leaving the SyncChannel
SW_SyncLeavingChannel = false;

-- used to see if the person is still there
SW_LITimerDead = 300;

-- 1.42 added timeframe in which to accept session id updates without a RE
-- (joining a running channel)
SW_SessIDTimerThresh = 210 ; -- in this imeframe we will have at least an LI once
SW_SessIDTimer = time();

-- 1.5.3 increased val buffer from 3% to 10%
SW_ValBuffer = 10 -- % this is used to check if somebody else needs to post info even though this was a self info (user dropped)
SW_DecurseBuffer = 3; --same as above but not as % 

-- time in seconds to assume the person in the channel has "up to date" info 
-- eg he drops and reconnects checked in SW_SyncSend
SW_SyncKeepTime = 300;

SW_S_LastManaSent = {0,0,0};

-- 1.5 added, used to stop sending unneeded messages on relogging
SW_StartupTime = time();
SW_SyncIgnoreNil = 120;

SW_Sync_MsgTrack = {};

--[[ The sync Queue
	So we dont have to think about timing record length etc
	only thing to consider is that one single message may not be larger then 255 chars
	but we use short strings here anyways
]]--


SW_SyncQueue =
{
	first = 1,
	last =	0,
	maxBlockLen = 255, 
	sep = '"',
	sepLen = 1,
	queue = {},
	clearing = false,
	itemSep = '~',
	
	PushSWInfo = function (self, infType, vals)
		if self.clearing then return false; end
		if SW_Settings["SYNCLastChan"] == nil then return; end
		if SW_SyncChanID == 0 then return; end
		
		local tmpVal;
		local outStr = infType.." ";
		local valLen =0;
		local ident = SW_SyncPepper[infType];
		local sCount=0;
		local iCount=0;
		if vals == nil then
			vals = { math.random(100) };
		end
		
		valLen = table.getn(vals);
		for i,v in ipairs(vals) do
			tmpVal = tonumber(v);
			if tmpVal == nil then
				sCount = sCount + 1;
				
			else
				iCount = iCount + 1;
				ident = ident + tmpVal;
				
				
			end
			outStr = outStr..v;
			if i ~= valLen then
				outStr = outStr..self.itemSep
			end
		end
			
		
		tmpVal = math.floor(math.sqrt(ident * string.len(SW_Settings["SYNCLastChan"]))) * 1000;
		ident = math.floor(1000 * math.sqrt(ident * string.len(SW_Settings["SYNCLastChan"])));
		
		self:PushVal(SW_SyncSessionID.." "..(ident-tmpVal).." "..sCount.." "..iCount.." "..outStr);
		--self:PushVal(SW_SyncSessionID.." "..outStr);
	end,
	PushVal = function (self, val)
		if string.len(val) > self.maxBlockLen or self.clearing then return false; end
		local last = self.last + 1;
		self.last = last;
		self.queue[last] = val;
		return true;
	end,
	PopStack = function (self)
		if self.clearing then return nil; end
		
		local last = self.last;
		if self.first > last then return nil; end
		local val = self.queue[last];
		self.queue[last] = nil;
		self.last = last - 1;
		return val;
	end,
	Pop = function (self)
		if self.clearing then return nil; end
		local first = self.first;
		if first > self.last then return nil; end
		local val = self.queue[first];
		self.queue[first] = nil;
		self.first = first + 1;
		return val;
	end,
	HasData = function (self)
		if self.clearing then return false; end
		return not (self.first > self.last);
	end,
	Clear = function (self)
		self.clearing = true;
		for i=self.first, self.last do 
			self.queue[i] = nil;
			self.first = i + 1;
		end
		self.clearing = false;
	end,
	PopBlock = function (self)
		if self.clearing then return nil; end
		local first = self.first;
		if first > self.last then return nil; end
		local sepsLen = self.sepLen;
		local pos = first;
		local len = string.len(self.queue[first]);
		while self.queue[pos + 1] and len + string.len(self.queue[pos + 1]) + sepsLen < self.maxBlockLen do
			pos = pos + 1;
			sepsLen = sepsLen + self.sepLen;
			len = len + string.len(self.queue[pos]);
		end
		local val = table.concat(self.queue, self.sep, first, pos);
		for i=first, pos do 
			self.queue[i] = nil;
			self.first = i + 1;
		end
		return val;
	end,
	-- to lazy wouldn't work if + is a sep in the queue not using %
	-- because this goes through chat and the profanity filter could alter the str and add a %
	EncStr = function (self, str)
		local sOut = string.gsub(str, "([%"..self.sep.."%"..self.itemSep.."%+%|])", 
			function(c)
				return string.format ("+%02X", string.byte(c)) 
			end);
		return sOut;
	end,
	DecStr = function (self, str)
		local sOut = string.gsub (str, "%+(%x%x)", 
			function(h) 
				return string.char(tonumber(h,16)) 
			end);
		return sOut;
	end,
	
};

function SW_SyncSend()
	-- this only happens when logging out and comeing back in or when leaving sync channel
	if SW_SyncChanID ~= 0 and SW_Settings["SYNCLastAction"] ~= nil and time() - SW_Settings["SYNCLastAction"]  > SW_SyncKeepTime then
		-- are we still in this channel?
		id, _ = GetChannelName(SW_Settings["SYNCLastChan"]); 
		if id == 0 then
			SW_SyncChanID = 0;
			SW_Settings["SYNCLastChan"] = nil;
			if SW_S_DetailsSynced[SW_SELF_STRING] ~= nil then
				SW_S_DetailsSynced[SW_SELF_STRING]["LI"] = nil;
			end
			return;
		end
		-- if we get here we are still in the channel and need a reset
		SW_printStr("Reset in SyncSend");
		SW_SessIDTimer = time();
		SW_SyncReset(1);
		return;
	end
	if SW_SyncChanID == 0 and SW_Settings["SYNCLastChan"] ~= nil then
		SW_SyncChanID, _ = GetChannelName(SW_Settings["SYNCLastChan"]);
	end
	
	local toSend = SW_SyncQueue:PopBlock();
	if toSend ~= nil then
		if SW_SyncChanID ~= 0 then
			SendChatMessage(toSend, "CHANNEL", nil, SW_SyncChanID);
		end
	end
	if SW_SyncLeavingChannel then
		SW_SyncLeavingChannel = false;
		SW_SyncChanID = 0;
		LeaveChannelByName(SW_Settings["SYNCLastChan"]);
		SW_Settings["SYNCLastChan"] = nil;
		SW_Settings["SYNARP"] = nil;
		SW_BarFrame1_Title_SyncIcon:Hide();
	end
end
-- used to un/compress ints that are being sent
-- not sure about WOW but looking at utf  im assuming we have only the lower 127 chars available for 1 byte storage
-- minus the lower 32 that are special chars - minus " " (space) - '"' (doublequote) which we want to use
-- DOH and dont use \ .. escape codes 
-- DOH what about pipe??

-- taking it out atm its making more problems than doing good
--[[
SW_SyncInt = {
	digits = {},
	rev = {},
	base = 10;
	Init = function(self, base)
		--[[
		self.base = base;
		self.digits = {};
		self.rev = {};
		for i=0,9 do self.digits[i] = string.char(48+i) end
		for i=10,71 do self.digits[i] = string.char(55+i) end -- dont add 127 (DEL)
		for i=72,84 do self.digits[i] = string.char(119-i) end --go back in the table from before "0" and stop before '"'
		self.digits[85] = "!";
		for i=86,92 do self.digits[i] = string.char(150-i) end
		--]]
		self.base = base;
		self.rev = {};
		self.digits = {"1","2","3","4","5","6","7","8","9",
		  "A","B","C","D","E","F","G","H","I","J",
		  "K","L","M","N","O","P","Q","R","S","T",
		  "U","V","W","X","Y","Z","a","b","c","d",
		  "e","f","g","h","i","j","k","l","m","n",
		  "o","p","q","r","s","t","u","v","w","x",
		  "y","z","!","#","$","%","&","(",")",
		  "*","+","-",".","/",":",";","<","=",">",
		  "?","@","^","_","{","}",
		};
		 --"y","z","!","#","$","%","&","'","(",")",
		--"?","@","[","]","^","_","{","}","~",
		
		self.digits[0] = "0";
		
		for i,v in ipairs(self.digits) do 
			self.rev[v] = i;
		end
		self.rev[ self.digits[0] ] = 0;
	end,
	
	Enc = function(self, number)
		local s = "";
		local remainder = 0;
		repeat
			remainder = math.mod(number,self.base);
			s = self.digits[remainder]..s;
			number = (number-remainder)/self.base;
		until number==0
		return s;	
	end,
	Dec = function(self, number)
		local num = 0;
		local sLen = string.len(number);
		for i=1,sLen do
			num = num + (self.rev[string.sub(number,i,i)]  * self.base ^ (sLen - i));
		end
		return num;	
	end,
};
]]--

-- reset 
-- 1.4.2 changed this it will only reset yourself if your A or L
-- and others will check if the sender is A or L
-- 1.5.beta.1 added a "force self reset" for completion on a reset vote
function SW_SyncReset(newSessID, issuedBy, selfForce)

	if newSessID ~= nil then 
		if issuedBy ~= nil then
			-- 1.5.3 very ralrely some events don't fire
			-- if sombody has an A or is L might not be known so added this
			-- drawback: somebody with A might have started RE, then had A revoked milliseconds after he sent the msg
			-- oh hell can't catch em all
			SW_RebuildFriendList();
		end
		if (issuedBy == nil and (time()-SW_SessIDTimer) < SW_SessIDTimerThresh) 
		or (issuedBy ~= nil and SW_Friends[issuedBy] ~= nil and SW_Friends[issuedBy].Rank > 0) then
			SW_SyncQueue.clearing = true;
			SW_ResetInfo(); 
			SW_S_DetailsSynced = {};
			SW_S_HealedSynced = {};
			SW_DCSynced = {};
			SW_ManaAfterDrop = {0,0,0};
			SW_SyncSessionID = tonumber(newSessID);
			SW_Settings["SYNCLastAction"] = time();
			SW_SyncQueue:Clear();
		end
	
	else
		if SW_Friends[SW_SELF_STRING].Rank > 0 or selfForce then
			SW_SyncQueue.clearing = true;
			SW_ResetInfo(); 
			SW_S_DetailsSynced = {};
			SW_S_HealedSynced = {};	
			SW_DCSynced = {};
			SW_ManaAfterDrop = {0,0,0};
			SW_SyncQueue:Clear();
			SW_SyncSessionID = SW_SyncSessionID + 1;
		end
		if SW_Friends[SW_SELF_STRING].Rank > 0 and (not selfForce) then
			SW_SyncQueue:PushSWInfo("RE");
		end
	end
	
	
end



--[[ 1.5 added this
	The old way wouldnt leave the channel and join a new one in the same funccall
--]]
local SW_PendingJoinInfo = {
	newChan = nil,
	isPassive = nil,
}
--[[ 
	if isPassive == true that person wont send sync msgs
	but can listen
	TODO testing 1.5.3 I noticed some messages do get sent - these are sent through "catch" functions when we 
	send data on a recieved data event, because these are so few not sure if a change is needed
--]]
function SW_SyncJoin(chanName, isPassive)
	if tonumber(chanName) then
		return;
	end
	local retName;
	local id;
	local oldSynarp;
	
	if chanName == nil then return; end
	SW_Timed_Calls:StopJoinChanPending();
	SW_Timed_Calls:StopCheckChan();
	--Stop the pump sending messages
	SW_SyncChanID = 0;
	
	oldSynarp = SW_Settings["SYNARP"];
	SW_Settings["SYNARP"] = nil;
	if SW_Settings["SYNCLastChan"] ~= nil then
		if SW_Settings["SYNCLastChan"] == chanName then
			-- are we still in this channel?
			id, _ = GetChannelName(chanName);
			if id ~= 0 then
				if SW_Settings["SYNCLastAction"] ~= nil and time() - SW_Settings["SYNCLastAction"]  < SW_SyncKeepTime then
					-- if we get here it was just a repost, for new members to join this chan
					SW_SyncChanID = id;
					SW_Settings["SYNARP"] = oldSynarp;
					return
				else 
					SW_printStr("Reset on Join LA:"..SW_Settings["SYNCLastAction"].." NOW:"..time());
				end
			end
		else
			SW_SyncQueue.clearing = true;
			--SW_DumpResultList(GetChannelList());
			LeaveChannelByName(SW_Settings["SYNCLastChan"]);			
		end
	end
	--SW_DumpResultList(GetChannelList());
	-- 1.5 leaving and joining while already in 10 channels where 1 is swtats didnt work.
	SW_PendingJoinInfo.newChan = chanName;
	SW_PendingJoinInfo.isPassive = isPassive;
	SW_Timed_Calls:StartJoinChanPending();
	
end
function SW_SyncJoinPending()
	local chanName = SW_PendingJoinInfo.newChan;
	if chanName == nil then return; end
	
	if SW_PendingJoinInfo.isPassive then
		SW_SyncPassiveMode = isPassive;
	end
	
	SW_SyncQueue.clearing = true;
	_, retName = JoinChannelByName(chanName);
	id, _ = GetChannelName(chanName);
	if id ~= 0 then
		SW_Settings["SYNCLastChan"] = chanName;
		SW_SessIDTimer = time();
		SW_SyncReset(1);
		SW_Settings["SYNCLastAction"] = time();
	else
		-- we werent able to join the chan
		SW_printStr(SW_SYNC_CHAN_FAIL..chanName, 1);
		SW_Settings["SYNCLastChan"] = nil;
	end	
	
	SW_SyncChanID = id;
	SW_PendingJoinInfo.newChan = nil;
	SW_PendingJoinInfo.isPassive = nil;
	SW_Timed_Calls:StartCheckChan();
end
function SW_SyncJoinedCheck()
	local chanName = SW_Settings["SYNCLastChan"];
	if chanName == nil then 
		return; 
	end
	if SW_SyncCheckInChan(chanName) then
		SW_printStr(SW_SYNC_CHAN_JOIN..chanName, 1);
		local sf =getglobal("SW_BarSyncFrame");
		-- refresh sync frame
		if sf:IsVisible() then
			sf:Hide()
			sf:Show()
		end
		-- be sure we arent paused
		SW_ToggleRunning(true);
		-- 1.5.3 show the sync icon
		SW_BarFrame1_Title_SyncIcon:Show();
		
	else
		SW_printStr(SW_SYNC_CHAN_FAIL..chanName, 1);
	end
end
function SW_SyncCheckInChan(chanName)
	local function Check(...)
		local i = 1;
		
		while arg[i] ~= nil do
			if arg[i] == chanName then return true; end
			i = i + 1;
		end
		return false;
	end
	if Check(GetChannelList()) then
		return true;
	else
		SW_SyncChanID = 0;
		SW_Settings["SYNCLastChan"] = nil;
		SW_Settings["SYNARP"] = nil;
		SW_BarFrame1_Title_SyncIcon:Hide();
		if chanName then
			SW_printStr("SW_SyncCheckInChan:False "..chanName);
		else
			SW_printStr("SW_SyncCheckInChan:False Name:NIL");
		end
		--SW_printStr(debugstack());
		return false;
	end 
end
function SW_SyncCheckMsgForChan(msg, who)
	local chan;
	
	_,_,chan = string.find(msg, SW_SYNC_CHAN_REGEX);
	
	if chan ~= nil and who~= nil and chan ~= SW_Settings["SYNCLastChan"] then
		StaticPopupDialogs["SW_JoinCheck"]["SW_toChan"] = chan;
		StaticPopupDialogs["SW_JoinCheck"]["SW_postedBy"] = who;
		StaticPopupDialogs["SW_JoinCheck"]["text"] = string.format(SW_SYNC_JOINCHECK_FROM, chan, who).."\n"..SW_SYNC_JOINCHECK_INFO;
		StaticPopup_Show ("SW_JoinCheck");

	end
end

function SW_SyncSplitMsg(msg)
	
  local t = {};
  local function helper(line) table.insert(t, line); end
  helper((string.gsub(msg, "(.-)%"..SW_SyncQueue.sep, helper)))
  
  return t
end

function SW_SyncCheckAlive()
	local now = time();
	for k,v in pairs(SW_S_DetailsSynced) do
		if v["LI"] ~= nil then
			if now - v["LI"] > SW_LITimerDead then
				v["LI"] = nil;
			end
		end
	end
	
	if SW_SyncPassiveMode then return; end
	if SW_S_DetailsSynced[SW_SELF_STRING] == nil or
		SW_S_DetailsSynced[SW_SELF_STRING]["LI"] == nil or
		time() - SW_S_DetailsSynced[SW_SELF_STRING]["LI"] > (SW_LITimerDead - 200) then
		
		SW_SyncQueue:PushSWInfo("LI");
	end
end
function SW_SyncHandleMsg(msg, from)
	local pre;
	
	--[[ this will inject even more wrong people if sombody is drunk.. (S->Sh) but
		most of the times people use filters, group, evergroup npc etc
		so these drop out anyways in the display
		but a lot of the info is most likely valid
		also this will suppress most unexpected ident msgs if somebody is drunk
	--]]
	if SLURRED_SPEECH ~= nil then
		_,_,pre = string.find(msg, SW_DrunkRegEx)
		if pre ~= nil then
			--SW_printStr(msg.."==>"..pre);
			msg = pre;
		end
	end
	local msgs = SW_SyncSplitMsg(msg);
	SW_Settings["SYNCLastAction"] = time();
	local v1,vx,vs,vi,v2,v3,vals,ident, tmpInt, iCount, sCount;
	--handels a single Sync Msg
	for __,oneLine in ipairs(msgs) do
		_,_,v1,vx,vs,vi,v2,v3 = string.find(oneLine, "^(%d+) (%d+) (%d+) (%d+) (.-) (.+)");
		--_,_,v1,v2,v3 = string.find(oneLine, "^(%d+) (.-) (.+)");
		if v1==nil or vx==nil or vs==nil or vi==nil or v2==nil or v3==nil then -- another wierd one that happens very rarely
			-- hmm this could happen if somebody types normal chat messages into the SyncChannel
			SW_printStr("SW_SyncHandleMsg NIL value FROM: "..from.." in Msg:");
			SW_printStr(oneLine);
			return;
		end
		vx = tonumber(vx);
		vs = tonumber(vs);
		vi = tonumber(vi);
		
		vals = {};
		for info in string.gfind(v3, "[^~]+") do
			table.insert(vals,info); 
		end
		if table.getn(vals) ~= vs+vi then
			SW_printStr("SW_SyncHandleMsg unexpected argument count FROM: "..from.." in Msg:");
			SW_printStr(oneLine);
			return;
		end
		
		ident = SW_SyncPepper[v2];
		if ident == nil then
			SW_printStr("SW_SyncHandleMsg unexpected type FROM: "..from.." in Msg:");
			SW_printStr(oneLine);
			return;
		end
		sCount=0;
		iCount=0;
		for i,v in ipairs(vals) do
			tmpInt = tonumber(v);
			if tmpInt == nil then
				sCount = sCount+1;
			else
				iCount=iCount+1;
				vals[i] = tmpInt;
				ident = ident + tmpInt;
			end
		end
		
		if sCount ~= vs or iCount ~= vi then
			SW_printStr("SW_SyncHandleMsg type missmatch FROM: "..from.." in Msg:");
			SW_printStr(oneLine);
			return;
		end
		-- can happen while leaving channel
		if SW_Settings["SYNCLastChan"] == nil then
			return;
		end
		tmpInt = math.floor(math.sqrt(ident * string.len(SW_Settings["SYNCLastChan"]))) * 1000;
		ident = math.floor(1000 * math.sqrt(ident * string.len(SW_Settings["SYNCLastChan"])));
		if ident-tmpInt ~= vx then
			SW_printStr("SW_SyncHandleMsg unexpected ident FROM: "..from.." in Msg:");
			SW_printStr(oneLine);
			return;
		end
		
		-- ignore "old" messages
		if tonumber(v1) < SW_SyncSessionID then 
			
			return; 
		end 
		-- 1.4.2 chganged reset logic 
		if tonumber(v1) > SW_SyncSessionID then
			if v2 == "RE" then
				SW_SyncReset(v1, from);
			else
				SW_SyncReset(v1);
			end
		else
			if SW_S_DetailsSynced[from] == nil then
				SW_S_DetailsSynced[from] = {};
			end
			SW_S_DetailsSynced[from]["LI"] = time();
			if v2 ~= "RE" then -- if == and RE we issued it and already did reset
				if SW_SyncMsgs[v2] ~= nil then
					SW_SyncMsgs[v2](vals, from);
				end
			end
		end
		
	end
end

function SW_GetValPair(name, subItem, S)
	if S == nil then return nil; end
	if S[name] == nil then --[[SW_printStr("NILCRAP "..name.." "..subItem);--]]  return 0,0; end
	if S[name][subItem] == nil then return 0,0; end
	
	 return S[name][subItem][1],S[name][subItem][2];
end
function SW_SetValPair(name, subItem, S, v1, v2)
	if S == nil then return nil; end
	if S[name] == nil then S[name]={}; end
	if S[name][subItem] == nil then S[name][subItem] = {}; end
	S[name][subItem][1] = v1;
	S[name][subItem][2] = v2;
end
function SW_GetVal(name, subItem, S)
	if S == nil then return nil; end
	if S[name] == nil then return 0; end
	if S[name][subItem] == nil then return 0; end
	
	 return S[name][subItem];
end
function SW_SetVal(name, subItem, S, v)
	if S == nil then return nil; end
	if S[name] == nil then S[name]={}; end
	
	S[name][subItem] = v; 
	
end
function SW_SyncDo()
	if SW_Settings["SYNCLastChan"] == nil and SW_SyncChanID ==0 then
		return; 
	end
	if not SW_SyncCheckInChan(SW_Settings["SYNCLastChan"]) then
		return;
	end
	if SW_SyncPassiveMode then return; end
	
	SW_SyncDoOne(SW_SELF_STRING, true);
	SW_SyncDoHeal(SW_SELF_STRING, true);
	SW_SyncDoMana();
	
	local SW_SyncP = 0;
	
	local rnd;
	local peerCount =0;
	for k,v in pairs(SW_S_DetailsSynced) do
		if SW_S_DetailsSynced[k]["LI"] ~= nil then
			peerCount = peerCount +1;
		end
	end
	--auto% when to sync 
	if peerCount > 5 then
		SW_SyncP = math.ceil( (100 / peerCount) / 2 );
	else 
		-- nonsense to post when alone but i use it for testing
		SW_SyncP = 10;
	end
	
	for k,v in pairs(SW_S_Details) do
		rnd = math.random(100);
		
		if k ~= SW_SELF_STRING and rnd <= SW_SyncP then
			if SW_S_DetailsSynced[k] == nil then
				SW_SyncDoOne(k, false);
			else
				if SW_S_DetailsSynced[k]["LI"] == nil then
					SW_SyncDoOne(k, false);
				end
			end
		end
	end
	for k,v in pairs(SW_S_Healed) do
		rnd = math.random(100);
		if k ~= SW_SELF_STRING and rnd <= SW_SyncP then
			if SW_S_HealedSynced[k] == nil then
				SW_SyncDoHeal(k, false);
			else
				-- only tracking "alive" in SW_S_DetailsSynced
				if SW_S_DetailsSynced[k] == nil or SW_S_DetailsSynced[k]["LI"] == nil then
					SW_SyncDoHeal(k, false);
				end
			end
		end
	end
	for k,v in pairs(SW_PetInfo["PET_OWNER"]) do
		rnd = math.random(100);
		
		if rnd <= SW_SyncP or (v["currentOwners"] and v["currentOwners"][SW_SELF_STRING]) then
			SW_SyncDoOnePet(k);
		end
	end
	for k,v in pairs(SW_PetInfo["OWNER_PET"]) do
		rnd = math.random(100);
		
		if rnd <= SW_SyncP or k == SW_SELF_STRING then
			SW_SyncDoOnePetOwner(k);
		end
	end
	for k,v in pairs(SW_S_SpellInfo) do
		rnd = math.random(100);
		if rnd <= SW_SyncP or k == SW_SELF_STRING then
			SW_SyncDoOneDecurseCount(k);
		end
	end
end

-- only do self
function SW_SyncDoMana()
	if SW_S_ManaUsage ~= nil and SW_S_ManaUsage[SW_SELF_STRING] ~= nil then
		
		local v = SW_S_ManaUsage[SW_SELF_STRING];
		if v[1] > 0 or v[2] > 0 then
		    if SW_S_LastManaSent[1] < v[1] or SW_S_LastManaSent[2] < v[2] or SW_S_LastManaSent[3] < v[3] then 
				SW_S_LastManaSent[1] = v[1];
				SW_S_LastManaSent[2] = v[2];
				SW_S_LastManaSent[3] = v[3];
				SW_SyncQueue:PushSWInfo("MI", {SW_ManaAfterDrop[1] + v[1],SW_ManaAfterDrop[2] + v[2],SW_ManaAfterDrop[3] + v[3]});
			end
		end
	end
end
function SW_SyncDoHeal(name, isSelf)
	local hi = SW_S_Healed[name];
	if hi == nil then return; end
	
	local hiSync = SW_S_HealedSynced[name];
	if hiSync == nil and time() - SW_StartupTime  < SW_SyncIgnoreNil then
		return;
	end
	for k,v in hi do 
		if hiSync == nil or hiSync[k] == nil or v > hiSync[k] then
			if isSelf then
				SW_SyncQueue:PushSWInfo("HIS", {k, v});
			else
				SW_SyncQueue:PushSWInfo("HIO", {name, k, v});
			end	
		end
	end
end

function SW_SyncDoOne(name, isSelf)
	local doneDmg, doneHeal = SW_GetValPair(name, SW_PRINT_ITEM_TOTAL_DONE, SW_S_Details);
	local gotDmg, gotHeal = SW_GetValPair(name, SW_PRINT_ITEM_RECIEVED, SW_S_Details);
	local doneDmgS, doneHealS = SW_GetValPair(name, SW_PRINT_ITEM_TOTAL_DONE, SW_S_DetailsSynced);
	local gotDmgS, gotHealS = SW_GetValPair(name, SW_PRINT_ITEM_RECIEVED, SW_S_DetailsSynced);

	SW_SyncDoOneDeathCount(name);
	
	if doneDmg > doneDmgS or doneHeal > doneHealS or
		gotDmg > gotDmgS or gotHeal > gotHealS then
		if isSelf then
			SW_SyncQueue:PushSWInfo("SI", {doneDmg, doneHeal, gotDmg, gotHeal});
		else
			if time() - SW_StartupTime  < SW_SyncIgnoreNil then
				if doneDmgS == 0 and doneHealS == 0 and gotDmgS == 0 and gotHealS == 0 then
					return;
				end
			end
			SW_SyncQueue:PushSWInfo("OI", {name, doneDmg, doneHeal, gotDmg, gotHeal});
		end
	end
end
function SW_SyncDoOneDeathCount(name)
	local syDeaths = SW_DCSynced[name];
	if syDeaths == nil then
		syDeaths = 0;
	end
	if time() - SW_StartupTime  < SW_SyncIgnoreNil then
		if syDeaths == 0 then
			return;
		end
	end
	local tmpVal = SW_S_Details[name];
	if tmpVal ~= nil and tmpVal[SW_PRINT_ITEM_DEATHS] ~= nil then
		tmpVal = tmpVal[SW_PRINT_ITEM_DEATHS];
		if tmpVal > syDeaths then
			SW_SyncQueue:PushSWInfo("DC", {name, tmpVal, math.random(100)});
		end
	end
end
function SW_SyncDeathCount(data, from)
	local name, newDC, id = unpack(data);
	local syDeaths = SW_DCSynced[name];
	if syDeaths == nil or newDC > syDeaths then
		SW_DCSynced[name] = newDC;	
	end
	syDeaths = SW_DCSynced[name];
	local tmpVal = SW_S_Details[name];
	if tmpVal ~= nil then
		if tmpVal[SW_PRINT_ITEM_DEATHS] == nil or tmpVal[SW_PRINT_ITEM_DEATHS] < syDeaths then
			tmpVal[SW_PRINT_ITEM_DEATHS] = syDeaths;
		end
	end
	
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("Info from "..from.." for DeathCount of "..name..": "..newDC);
	end
end
function SW_SyncDoOneDecurseCount(name)
	local syDecs = SW_DecurseCSynced[name];
	if syDecs == nil then
		syDecs = 0;
	end
	
	if time() - SW_StartupTime  < SW_SyncIgnoreNil then
		if syDecs == 0 then
			return;
		end
	end
	
	local tmpVal = SW_S_SpellInfo[name];
	if tmpVal ~= nil and tmpVal[SW_DECURSEDUMMY] ~= nil and tmpVal[SW_DECURSEDUMMY]["total"] ~= nil then
		tmpVal = tmpVal[SW_DECURSEDUMMY]["total"];
		if tmpVal~=nil and tmpVal > syDecs then
			SW_SyncQueue:PushSWInfo("DCC", {name, tmpVal, math.random(100)});
		end
	end
	
end
function SW_SyncDecurseCount(data, from)
	local name, newDCC, id = unpack(data);
	local syDecs = SW_DecurseCSynced[name];
	if syDecs == nil or newDCC > syDecs then
		SW_DecurseCSynced[name] = newDCC;	
	end
	syDecs = SW_DecurseCSynced[name];
	local tmpVal;
	if SW_S_SpellInfo[name] == nil then
		SW_S_SpellInfo[name] = {};
	end
	if SW_S_SpellInfo[name][SW_DECURSEDUMMY] == nil then
		SW_S_SpellInfo[name][SW_DECURSEDUMMY] = {};
	end
	tmpVal = SW_S_SpellInfo[name][SW_DECURSEDUMMY];
	if tmpVal["total"] == nil then
		tmpVal["total"] = 0;
	end
	
	if tmpVal["total"] < syDecs then
		tmpVal["total"] = syDecs;
	end
	
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("Info from "..from.." for DecurseCount of "..name..": "..newDCC);
	end
end

function SW_SyncDoOnePetOwner(name)
	local doneDmg, doneHeal = SW_GetValPair(name, SW_PRINT_ITEM_TOTAL_DONE, SW_PetInfo["OWNER_PET"]);
	local gotDmg, gotHeal = SW_GetValPair(name, SW_PRINT_ITEM_RECIEVED, SW_PetInfo["OWNER_PET"]);
	local doneDmgS, doneHealS = SW_GetValPair(SW_PETOWNER..name, SW_PRINT_ITEM_TOTAL_DONE, SW_S_DetailsSynced);
	local gotDmgS, gotHealS = SW_GetValPair(SW_PETOWNER..name, SW_PRINT_ITEM_RECIEVED, SW_S_DetailsSynced);

	if doneDmg > doneDmgS or doneHeal > doneHealS or
		gotDmg > gotDmgS or gotHeal > gotHealS then
		if time() - SW_StartupTime  < SW_SyncIgnoreNil then
			if doneDmgS == 0 and doneHealS == 0 and gotDmgS == 0 and gotHealS == 0 then
				return;
			end
		end
		SW_SyncQueue:PushSWInfo("PO", {name, doneDmg, doneHeal, gotDmg, gotHeal});
	end
end

function SW_SyncDoOnePet(name)
	local doneDmg, doneHeal = SW_GetValPair(name, SW_PRINT_ITEM_TOTAL_DONE, SW_PetInfo["PET_OWNER"]);
	local gotDmg, gotHeal = SW_GetValPair(name, SW_PRINT_ITEM_RECIEVED, SW_PetInfo["PET_OWNER"]);
	local doneDmgS, doneHealS = SW_GetValPair(SW_PET..name, SW_PRINT_ITEM_TOTAL_DONE, SW_S_DetailsSynced);
	local gotDmgS, gotHealS = SW_GetValPair(SW_PET..name, SW_PRINT_ITEM_RECIEVED, SW_S_DetailsSynced);

	if doneDmg > doneDmgS or doneHeal > doneHealS or
		gotDmg > gotDmgS or gotHeal > gotHealS then
		if time() - SW_StartupTime  < SW_SyncIgnoreNil then
			if doneDmgS == 0 and doneHealS == 0 and gotDmgS == 0 and gotHealS == 0 then
				return;
			end
		end
		SW_SyncQueue:PushSWInfo("PI", {name, doneDmg, doneHeal, gotDmg, gotHeal});
	end
end
function SW_SyncPetOwner(data, from)
local name, doneDmgS, doneHealS, gotDmgS, gotHealS = unpack(data);
	local syncName = SW_PETOWNER..name;
	
	
	local doneDmg, doneHeal = SW_GetValPair(name, SW_PRINT_ITEM_TOTAL_DONE, SW_PetInfo["OWNER_PET"]);
	local gotDmg, gotHeal = SW_GetValPair(name, SW_PRINT_ITEM_RECIEVED, SW_PetInfo["OWNER_PET"]);
	
	local doneDmgSync, doneHealSync = SW_GetValPair(syncName, SW_PRINT_ITEM_TOTAL_DONE, SW_S_DetailsSynced);
	local gotDmgSync, gotHealSync = SW_GetValPair(syncName, SW_PRINT_ITEM_RECIEVED, SW_S_DetailsSynced);
	
	
	
	if doneDmgS > doneDmgSync or doneHealS > doneHealSync then
		SW_SetValPair(syncName, SW_PRINT_ITEM_TOTAL_DONE, SW_S_DetailsSynced, doneDmgS, doneHealS);
	end
	if gotDmgS > gotDmgSync or gotHealS > gotHealSync then
		SW_SetValPair(syncName, SW_PRINT_ITEM_RECIEVED, SW_S_DetailsSynced, gotDmgS, gotHealS);
	end
	
	local v1, v2;
	if doneDmgS > doneDmg then v1 = doneDmgS; else v1 = doneDmg; end
	if doneHealS > doneHeal then v2 = doneHealS; else v2 = doneHeal; end
	SW_SetValPair(name, SW_PRINT_ITEM_TOTAL_DONE, SW_PetInfo["OWNER_PET"], v1, v2);
	
	if gotDmgS > gotDmg then v1 = gotDmgS; else v1 = gotDmg; end
	if gotHealS > gotHeal then v2 = gotHealS; else v2 = gotHeal; end
	SW_SetValPair(name, SW_PRINT_ITEM_RECIEVED, SW_PetInfo["OWNER_PET"], v1, v2);
	
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("Info from "..from.." for PETOWNER "..name.." "..doneDmgS.." "..doneHealS.." "..gotDmgS.." "..gotHealS);
	end
	
end

function SW_SyncPetInfo(data, from)
	local name, doneDmgS, doneHealS, gotDmgS, gotHealS = unpack(data);
	local syncName = SW_PET..name;
	
	
	local doneDmg, doneHeal = SW_GetValPair(name, SW_PRINT_ITEM_TOTAL_DONE, SW_PetInfo["PET_OWNER"]);
	local gotDmg, gotHeal = SW_GetValPair(name, SW_PRINT_ITEM_RECIEVED, SW_PetInfo["PET_OWNER"]);
	
	local doneDmgSync, doneHealSync = SW_GetValPair(syncName, SW_PRINT_ITEM_TOTAL_DONE, SW_S_DetailsSynced);
	local gotDmgSync, gotHealSync = SW_GetValPair(syncName, SW_PRINT_ITEM_RECIEVED, SW_S_DetailsSynced);
	
	
	
	if doneDmgS > doneDmgSync or doneHealS > doneHealSync then
		SW_SetValPair(syncName, SW_PRINT_ITEM_TOTAL_DONE, SW_S_DetailsSynced, doneDmgS, doneHealS);
	end
	if gotDmgS > gotDmgSync or gotHealS > gotHealSync then
		SW_SetValPair(syncName, SW_PRINT_ITEM_RECIEVED, SW_S_DetailsSynced, gotDmgS, gotHealS);
	end
	
	local v1, v2;
	if doneDmgS > doneDmg then v1 = doneDmgS; else v1 = doneDmg; end
	if doneHealS > doneHeal then v2 = doneHealS; else v2 = doneHeal; end
	SW_SetValPair(name, SW_PRINT_ITEM_TOTAL_DONE, SW_PetInfo["PET_OWNER"], v1, v2);
	
	if gotDmgS > gotDmg then v1 = gotDmgS; else v1 = gotDmg; end
	if gotHealS > gotHeal then v2 = gotHealS; else v2 = gotHeal; end
	SW_SetValPair(name, SW_PRINT_ITEM_RECIEVED, SW_PetInfo["PET_OWNER"], v1, v2);
	
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("Info from "..from.." for PET "..name.." "..doneDmgS.." "..doneHealS.." "..gotDmgS.." "..gotHealS);
	end
	
end

function SW_SyncBasicInfo(data, from, isSelf)
	local doneDmgS, doneHealS, gotDmgS, gotHealS = unpack(data);
	local isSelfStr ="";
	local buffedDmg, buffedHeal;
	
	if from == nil then 
		SW_Event_Channel:AddMessage("From:NIL");
		return;
	end
	if isSelf then
		isSelfStr = " IsSelf ";
	else
		isSelfStr = " IsOther ";
	end
	if doneDmgS == nil then
		SW_Event_Channel:AddMessage("From:"..from..isSelfStr.."doneDmgS == NIL: "..data);
		return;
	elseif doneHealS == nil then
		SW_Event_Channel:AddMessage("From:"..from..isSelfStr.."doneHealS == NIL: "..data);
		return;
	elseif gotDmgS == nil then
		SW_Event_Channel:AddMessage("From:"..from..isSelfStr.."gotDmgS == NIL: "..data);
		return;
	elseif gotHealS == nil then
		SW_Event_Channel:AddMessage("From:"..from..isSelfStr.."gotHealS == NIL: "..data);
		return;
	end
	
	local doneDmg, doneHeal = SW_GetValPair(from, SW_PRINT_ITEM_TOTAL_DONE, SW_S_Details);
	local gotDmg, gotHeal = SW_GetValPair(from, SW_PRINT_ITEM_RECIEVED, SW_S_Details);
	--check here if somebody came back after a "reset" (he was disconnected to long)
	if isSelf and from ~= SW_SELF_STRING and (doneDmgS < doneDmg or doneHealS < doneHeal ) then
		-- this will trigger a message from every player with the addon installed
		-- maybe find a better way (but this doesnt happen on a regular basis)
		-- also the first few "ticks" of selfinfo are lost but ist very little compared to total stats
		-- and maybe somebody else even got those msgs and we ar totally correct
		--RC5 Changed this.. generated a LOT of chat spam only issue an update like this if its heihger then SW_ValBuffer %
		-- could happen because of the chat send delay + chat delay, somebody sent info
		-- that was correct but it arrived 2 seconds later and this would trigger this aswell

		buffedDmg = ((doneDmgS/100) * SW_ValBuffer) + doneDmgS;
		buffedHeal = ((doneHealS/100) * SW_ValBuffer) + doneHealS;
		if buffedDmg < doneDmg or buffedHeal < doneHeal then
			if not SW_SyncPassiveMode then
				--1.5.3 after a reset this would generate unneded msgs
				-- added a delta val buffer depending on the level
				if SW_Friends[from] ~= nil and SW_Friends[from]["L"] ~= nil and SW_Friends[from]["L"] > 0 then
					local minVal = SW_Friends[from]["L"] * 100;
					if ((doneDmgS + minVal) < doneDmg) or ((doneHealS + minVal) < doneHeal) then
						SW_SyncQueue:PushSWInfo("OI", {from, doneDmg, doneHeal, gotDmg, gotHeal});
					end
				else
					-- still have this here for sync to work as expected for people that aren't grouped
					SW_SyncQueue:PushSWInfo("OI", {from, doneDmg, doneHeal, gotDmg, gotHeal});
				end
			end
		end
		return;
	end
	
	local doneDmgSync, doneHealSync = SW_GetValPair(from, SW_PRINT_ITEM_TOTAL_DONE, SW_S_DetailsSynced);
	local gotDmgSync, gotHealSync = SW_GetValPair(from, SW_PRINT_ITEM_RECIEVED, SW_S_DetailsSynced);
	
	local topDelta =0;
	if isSelf and (doneDmgSync > 0) then
		topDelta = doneDmgS - doneDmgSync;
		if SW_Sync_MsgTrack[from]["TOPDELTAD"] < topDelta then
			SW_Sync_MsgTrack[from]["TOPDELTAD"] = topDelta;
		end
	end
	if isSelf and (doneHealSync > 0) then
		topDelta = doneHealS - doneHealSync;
		if SW_Sync_MsgTrack[from]["TOPDELTAH"] < topDelta then
			SW_Sync_MsgTrack[from]["TOPDELTAH"] = topDelta;
		end
	end
	
	--0.98 no need to update lower info in synced
	if doneDmgS > doneDmgSync or doneHealS > doneHealSync then
		SW_SetValPair(from, SW_PRINT_ITEM_TOTAL_DONE, SW_S_DetailsSynced, doneDmgS, doneHealS);
	end
	if gotDmgS > gotDmgSync or gotHealS > gotHealSync then
		SW_SetValPair(from, SW_PRINT_ITEM_RECIEVED, SW_S_DetailsSynced, gotDmgS, gotHealS);
	end
	
	local v1, v2, sIInced=false;
	if doneDmgS > doneDmg then 
		v1 = doneDmgS; 
		if isSelf then
			SW_Sync_MsgTrack[from]["SI_WAS_NEEDED"] = SW_Sync_MsgTrack[from]["SI_WAS_NEEDED"] + 1;
			sIInced=true;
		end
	else 
		v1 = doneDmg; 
	end
	if doneHealS > doneHeal then 
		v2 = doneHealS; 
		if isSelf and (not sIInced) then
			SW_Sync_MsgTrack[from]["SI_WAS_NEEDED"] = SW_Sync_MsgTrack[from]["SI_WAS_NEEDED"] + 1;
			sIInced=true;
		end
	else 
		v2 = doneHeal; 
	end
	
	SW_SetValPair(from, SW_PRINT_ITEM_TOTAL_DONE, SW_S_Details, v1, v2);
	
	if gotDmgS > gotDmg then v1 = gotDmgS; else v1 = gotDmg; end
	if gotHealS > gotHeal then v2 = gotHealS; else v2 = gotHeal; end
	
	-- 1.5.3 raid per second 
	-- an SI with dmg is valid 
	if isSelf and (doneDmgS > doneDmg) then
		SW_RPS:validEvent();
	end
	SW_SetValPair(from, SW_PRINT_ITEM_RECIEVED, SW_S_Details, v1, v2);
	
	if SW_Settings["EI_ShowSync"] ~= nil then
		if isSelf then
			SW_Event_Channel:AddMessage("SelfInfo for "..from.." "..doneDmgS.." "..doneHealS.." "..gotDmgS.." "..gotHealS);
		else
			SW_Event_Channel:AddMessage("Info for "..from.." "..doneDmgS.." "..doneHealS.." "..gotDmgS.." "..gotHealS);
		end
	end
	
end

function SW_checkSIOI()
	local vals = {};
	for k, v in pairs (SW_Sync_MsgTrack) do
		if v["OI_UPDATE_SI"] > 0 then
			table.insert(vals, {k, v["OI_UPDATE_SI"]});
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);	
	return vals;
end
function SW_checkSINeeded()
	local vals = {};
	for k, v in pairs (SW_Sync_MsgTrack) do
		if v["SI_WAS_NEEDED"] > 0 then
			table.insert(vals, {k, v["SI_WAS_NEEDED"]});
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);	
	return vals;
end
function SW_updateMsgTrack(from, isOI, data)
	if SW_Sync_MsgTrack[from] == nil then
		SW_Sync_MsgTrack[from] = {["OI"] = 0, ["SI"] = 0, ["OI_UPDATE_SI"] = 0, ["SI_WAS_NEEDED"] = 0, ["TOPDELTAD"] = 0, ["TOPDELTAH"] = 0};
	end
	if isOI then
		if SW_S_DetailsSynced[ data[1] ] and SW_S_DetailsSynced[ data[1] ]["LI"] ~= nil then
			SW_Sync_MsgTrack[from]["OI_UPDATE_SI"] = SW_Sync_MsgTrack[from]["OI_UPDATE_SI"] + 1;
		else
			SW_Sync_MsgTrack[from]["OI"] = SW_Sync_MsgTrack[from]["OI"] + 1;
		end
	else
		SW_Sync_MsgTrack[from]["SI"] = SW_Sync_MsgTrack[from]["SI"] + 1;
	end	
end
function SW_SyncSelfInfo(data, from)
	SW_updateMsgTrack(from, false, data);
	SW_SyncBasicInfo(data, from, true);
end
function SW_SyncOtherInfo(data, from)
	--local _,_,nameFrom, restData = string.find(data, "^~(.-)~ (.+)");
	--SW_SyncBasicInfo(restData, nameFrom, false);
	SW_updateMsgTrack(from, true, data);
	
	local name = data[1];
	table.remove(data, 1);
	SW_SyncBasicInfo(data, name, false);
end
function SW_SyncSendARP(allow)
	if UnitInRaid("player") and not (IsRaidLeader() or IsRaidOfficer()) then
		return;
	end
	if allow then
		SW_SyncQueue:PushSWInfo("ARP", {"true", math.random(100)});
	else
		SW_SyncQueue:PushSWInfo("ARP", {"false", math.random(100)});
	end
end
function SW_SyncAllowReport(data, from)
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("Allow Report "..data[1].." from "..from);
	end
	if data[1] == "true" then
		SW_Settings["SYNARP"] = true;
	else
		SW_Settings["SYNARP"] = nil;
	end
end
function SW_SyncManaInfo(data, from)
	if from ~= SW_SELF_STRING then
		if SW_S_ManaUsage[from] ~= nil then
			if data[3] < SW_S_ManaUsage[from][3] then
				--the sender dropped, alt+f4d etc.
				-- this isn't time critical and we don't want a huge spam when somebody comes back
				-- so just make it a 20% chance
				local rnd = math.random(100);
				if rnd < 20 then
					local mu = SW_S_ManaUsage[from];
					SW_SyncQueue:PushSWInfo("MIO", {from, mu[1], mu[2], mu[3]});
				end
			else
				SW_S_ManaUsage[from] = {unpack(data)};
			end
		else
			SW_S_ManaUsage[from] = {unpack(data)};
		end
	end
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("ManaInfo from "..from.." "..data[1].." "..data[2].." "..data[3]);
	end
end

function SW_SyncManaInfoOther(data, from)
	
	--this happens when we posten a self mana info and somebody in the SyncChannel 
	-- had a higher value stored, we dropped or alt+f4'd etc
	if data[1] == SW_SELF_STRING then
		local tp, m1, m2, m3 = unpack(data);
		local m1o, m2o, m3o = unpack(SW_ManaAfterDrop);
		if m3 > m3o then
			SW_ManaAfterDrop = {m1,m2,m3};
		end
	end
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("ManaInfoOther from "..from.." for "..data[1].." "..data[2].." "..data[3].." "..data[4]);
	end
	
end
function SW_SyncAlive(data, from)
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("LI from "..from);
	end
	
	-- nothing really to do here
end

-- 0.98 heal info details (who healed who)
function SW_SyncHealInfo(healer, healTarget, amount, isSelf)
	
	healed = SW_GetVal(healer, healTarget, SW_S_Healed);
	healedSync = SW_GetVal(healer, healTarget, SW_S_HealedSynced);
	
	--the person posting self info dropped
	if isSelf and healer ~= SW_SELF_STRING and amount < healed then
		--SW_SyncQueue:Push(SW_SyncSessionID.." HIO ~"..healer.."~ ~"..healTarget.."~ "..healed);
		if ((amount/100) * SW_ValBuffer) + amount < healed then
			SW_SyncQueue:PushSWInfo("HIO", {healer, healTarget, healed});
		end
		return;
	end
	
	if amount > healedSync then
		SW_SetVal(healer, healTarget, SW_S_HealedSynced, amount);
	end
	if healed < amount then
		SW_SetVal(healer, healTarget, SW_S_Healed, amount);
	end
	if SW_Settings["EI_ShowSync"] ~= nil then
		if isSelf then
			SW_Event_Channel:AddMessage("SelfInfo "..healer.." healed "..healTarget.." "..amount);
		else
			SW_Event_Channel:AddMessage("Info "..healer.." healed "..healTarget.." "..amount);
		end
	end
end
function SW_SyncSendLeave()
	if SW_Settings["SYNCLastChan"] ~= nil then
		SW_SyncQueue:Clear();
		SW_SyncQueue:PushSWInfo("LS");
		SW_SyncLeavingChannel = true;
	end
end
function SW_SyncHealInfoOther(data, from)
	local nameFrom, nameTo, amount = unpack(data);
	
	SW_SyncHealInfo(nameFrom, nameTo, amount, false);
end
function SW_SyncHealInfoSelf(data, from)
	local nameTo, amount = unpack(data);
	SW_SyncHealInfo(from, nameTo, amount, true);
end
function SW_SyncRequestFullSync()
	--SW_SyncQueue:Push(SW_SyncSessionID.." FS "..SW_SyncSessionID);
	SW_SyncQueue:PushSWInfo("FS");
end
--0.98b added full sync 
--1.5 removed the console sommand to acces this
-- it's just nbot needed in the current form
function SW_SyncFullSync(nop, from)
	-- A full sync.. never ever do in fight.....
	if from == SW_SELF_STRING then
		--this works but not sure if i want it
		-- idea is that the requestor sends out all his info
		SW_S_DetailsSynced = {};
		SW_S_HealedSynced = {};
	end
	for k,v in pairs(SW_S_Details) do 
		if k == SW_SELF_STRING then
			SW_SyncDoOne(k, true);
		else
			SW_SyncDoOne(k, false);
		end
	end
	for k,v in pairs(SW_S_Healed) do 
		if k == SW_SELF_STRING then
			SW_SyncDoHeal(k, true);
		else
			SW_SyncDoHeal(k, false);
		end
	end
end
function SW_SyncLeave(data, from)
	if SW_S_DetailsSynced[from] ~= nil then
		SW_S_DetailsSynced[from]["LI"] = nil; 
	end
end

function SW_SyncSendRSU(skillName)
	SW_SyncQueue:PushSWInfo("RSU", {skillName, math.random(100)});
end
function SW_SyncRequestSkillUsage(data, from)
	
	if SW_S_SpellInfo[SW_SELF_STRING] ~= nil and SW_S_SpellInfo[SW_SELF_STRING][ data[1] ] ~= nil then
		SW_SyncQueue:PushSWInfo("SU", {data[1], SW_S_SpellInfo[SW_SELF_STRING][ data[1] ][1], math.random(100)});
	end
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("Request Skill Usage from "..from.." for Skill "..data[1]);
	end
end

function SW_SyncSkillUsage(data, from)
	SW_printStr("["..date("%X").."] "..LIGHTYELLOW_FONT_COLOR_CODE..from..FONT_COLOR_CODE_CLOSE.." "..data[1]..":"..RED_FONT_COLOR_CODE..data[2]..FONT_COLOR_CODE_CLOSE);
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("Skill Usage  "..from.." for Skill "..data[1]..":"..data[2]);
	end
end

-- added 1.4 version check stuff  
function SW_SyncSendRSV()
	SW_SyncQueue:PushSWInfo("RSV", {math.random(100)});
end
function SW_SyncRequestVersionCheck(data, from)

	SW_SyncQueue:PushSWInfo("SV", {SW_VERSION, GetLocale(), math.random(100)});
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("Request Version info from "..from);
	end
end
function SW_SyncVersionCheck(data, from)
	if data[2] ~= nil and tonumber(data[2]) then
		SW_printStr("["..date("%X").."] "..from.." "..RED_FONT_COLOR_CODE..data[1]..FONT_COLOR_CODE_CLOSE);
	else
		SW_printStr("["..date("%X").."] "..from.." "..RED_FONT_COLOR_CODE..data[1]..FONT_COLOR_CODE_CLOSE.." ("..data[2]..")");
	end
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("V  "..from..": "..data[1].." "..data[2]);
	end
end
-- added 1.4 kicking people from the sync chan
-- usefull if somebody left the raid/group and is still playing
function SW_SyncKick(data, from)
	if SW_Settings["EI_ShowSync"] ~= nil then
		SW_Event_Channel:AddMessage("KICK from "..from.." for: "..data[1]);
	end
	SW_printStr("["..date("%X").."] KICK from "..from.." for:"..RED_FONT_COLOR_CODE..data[1]..FONT_COLOR_CODE_CLOSE);
	if data[1] == SW_SELF_STRING then
		SW_SyncSendLeave();
	end
end
function SW_SendSyncKick(who)
	SW_SyncQueue:PushSWInfo("KI", {who, math.random(100)});
end

function SW_SyncGetLIs()
	local out = {};
	local SW_PC = 0;
	
	for k,v in pairs(SW_S_DetailsSynced) do
		if SW_S_DetailsSynced[k]["LI"] ~= nil then
			SW_PC = SW_PC +1;
			out[k] = 1;
		end
	end
	out["SW_PC"] = SW_PC;
	return out;
end

function SW_SyncInit()
	-- use "base 89"
	-- had nil problems usinglower base to see if it fixes that
	-- turned off compression alltogether for now
	--SW_SyncInt:Init(84);
	
	SW_SyncMsgs ={
		["RE"] = SW_SyncReset,
		["OI"] = SW_SyncOtherInfo,
		["SI"] = SW_SyncSelfInfo,
		["LI"] = SW_SyncAlive,
		["HIO"] = SW_SyncHealInfoOther,
		["HIS"] = SW_SyncHealInfoSelf,
		["FS"] = SW_SyncFullSync,
		["LS"] = SW_SyncLeave,
		["MI"] = SW_SyncManaInfo,
		["MIO"] = SW_SyncManaInfoOther,
		["ARP"] = SW_SyncAllowReport,
		["RSU"] = SW_SyncRequestSkillUsage,
		["SU"] = SW_SyncSkillUsage,
		["RSV"] = SW_SyncRequestVersionCheck,
		["SV"] = SW_SyncVersionCheck,
		["KI"] = SW_SyncKick,
		["PI"] = SW_SyncPetInfo,
		["PO"] = SW_SyncPetOwner,
		["DC"] = SW_SyncDeathCount,
		["IV"] = SW_SyncIssuedVote,
		["IVA"] = SW_SyncIssuedVoteAnswer,
		["VA"] = SW_SyncVoteAnswer,
		["DCC"] = SW_SyncDecurseCount,
		
	};
	SW_SyncPepper ={
		["RE"] = 3985,
		["OI"] = 9724,
		["SI"] = 9967,
		["LI"] = 5391,
		["HIO"] = 8549,
		["HIS"] = 3941,
		["FS"] = 7105,
		["LS"] = 6418,
		["MI"] = 8256,
		["MIO"] = 9601,
		["ARP"] = 4215,
		["RSU"] = 1098,
		["SU"] = 7209,
		["RSV"] = 5780,
		["SV"] = 3009,
		["KI"] = 6105,
		["PI"] = 2193,
		["PO"] = 6623,
		["DC"] = 1043,
		["IV"] = 8312,
		["IVA"] = 3104,
		["VA"] = 8858,
		["DCC"] = 5103,
	};
	
end