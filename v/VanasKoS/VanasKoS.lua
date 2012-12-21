--[[----------------------------------------------------------------------
		VanasKoS - Kill on Sight Management
------------------------------------------------------------------------]]

local DEFAULT_OPTIONS = {
		notifyVisual = TRUE,
		notifyChatframe = TRUE,
		enableWarnFrame = TRUE,
		NotifyTimerInterval = 60,
		playSound = TRUE
	};

local ScheduledActions = { };
local timeElapsed = 0;
local notifyAllowed = TRUE;

local nearbyKos = { };
local nearbyEnemys = { };
local nearbyFriendly = { };

local initialized = nil;

VanasKoS = AceAddon:new({
	name = VANASKOS.NAME,
  version = VANASKOS.VERSION,
  releaseDate = "06-15-2006",
  aceCompatible = "102",
  author    = "Vane of EU-Aegwynn",
  email     = "boredvana@gmail.com",
  website   = "http//www.curse-gaming.com",
  category  = "others",
  db        = AceDatabase:new("VanasKoSDB"),
  defaults  = DEFAULT_OPTIONS,
  cmd       = AceChatCmd:new(VANASKOS.COMMANDS, VANASKOS.CMD_OPTIONS),
});

--[[----------------------------------------------------------------------
  ACE Functions
------------------------------------------------------------------------]]
function VanasKoS:Initialize()
	self.GetOpt = function(var) return self.db:get(self.profilePath, var); end
	self.SetOpt = function(var, val) self.db:set(self.profilePath, var, val); end
	self.TogOpt = function(var) return self.db:toggle(self.profilePath, var); end
	self.TogMsg = function(text, val) self.cmd:status(text, val, VANASKOS.MAP_ONOFF_COLOR); end
end

function VanasKoS:Enable()
	-- Mouseover, Targetchanges
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");

	-- Chat Messages
	self:RegisterEvent("CHAT_MSG_HOSTILEPLAYER_BUFF", "ChatCombatMessageHandlerEnemy");
	self:RegisterEvent("CHAT_MSG_HOSTILEPLAYER_DAMAGE", "ChatCombatMessageHandlerEnemy");
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS", "ChatCombatMessageHandlerEnemy");
	self:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES", "ChatCombatMessageHandlerEnemy");
	self:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF", "ChatCombatMessageHandlerEnemy");
	self:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE", "ChatCombatMessageHandlerEnemy");
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS", "ChatCombatMessageHandlerEnemy");
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE", "ChatCombatMessageHandlerEnemy");

	-- Chat Messages Friendly - to gather messages & friendly targets
	self:RegisterEvent("CHAT_MSG_FRIENDLYPLAYER_BUFF", "ChatCombatMessageHandlerFriendly");
	self:RegisterEvent("CHAT_MSG_FRIENDLYPLAYER_DAMAGE", "ChatCombatMessageHandlerFriendly");
	self:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS", "ChatCombatMessageHandlerFriendly");
	self:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES", "ChatCombatMessageHandlerFriendly");
	self:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF", "ChatCombatMessageHandlerFriendly");
	self:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE", "ChatCombatMessageHandlerFriendly");
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS", "ChatCombatMessageHandlerFriendly");
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE", "ChatCombatMessageHandlerFriendly");

	-- say, emotes
	self:RegisterEvent("CHAT_MSG_SAY", "ChatMessageAndEmoteHandler");
	self:RegisterEvent("CHAT_MSG_EMOTE", "ChatMessageAndEmoteHandler");
	self:RegisterEvent("CHAT_MSG_TEXT_EMOTE", "ChatMessageAndEmoteHandler");
	
	if(self.GetOpt("enableWarnFrame")) then
		VanasKoS_WarnFrame:Show();
	else
		VanasKoS_WarnFrame:Hide();
	end
end

function VanasKoS:Disable()
	-- Mouseover, Targetchanges
	self:UnregisterEvent("UPDATE_MOUSEOVER_UNIT");
	self:UnregisterEvent("PLAYER_TARGET_CHANGED");

	-- Chat Messages
	self:UnregisterEvent("CHAT_MSG_HOSTILEPLAYER_BUFF");
	self:UnregisterEvent("CHAT_MSG_HOSTILEPLAYER_DAMAGE");
	self:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");
	self:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES");
	self:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	self:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	self:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	self:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");

	-- Chat Messages Friendly - to gather messages & friendly targets
	self:UnregisterEvent("CHAT_MSG_FRIENDLYPLAYER_BUFF");
	self:UnregisterEvent("CHAT_MSG_FRIENDLYPLAYER_DAMAGE");
	self:UnregisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS");
	self:UnregisterEvent("CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES");
	self:UnregisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
	self:UnregisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
	self:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
	self:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");

	-- say, emotes
	self:UnregisterEvent("CHAT_MSG_SAY");
	self:UnregisterEvent("CHAT_MSG_EMOTE");
	self:UnregisterEvent("CHAT_MSG_TEXT_EMOTE");

	VanasKoS_WarnFrame:Hide();
end

--[[----------------------------------------------------------------------
  Main Functions
------------------------------------------------------------------------]]
function VanasKoS:OnUpdate()
	if(getn(ScheduledActions) == 0) then
		VanasKoS_CoreFrame:Hide();
		return nil;
	end
	timeElapsed = timeElapsed + arg1;
	if(timeElapsed >= 0.1 ) then
		timeElapsed = timeElapsed - 0.1;
		local currTime = GetTime();
		for k,v in ScheduledActions do
			if (currTime >= v[2]) then
				tremove(ScheduledActions, k);
				if(type(v[1]) == "function") then
					v[1](v[3]);
				else
					getglobal(v[1])(v[3]);
				end
			end
		end
	end
end

function VanasKoS:ScheduleAction(nameOrFunction, timeUntilExecution, optParam)
	tinsert(ScheduledActions, { nameOrFunction, GetTime()+timeUntilExecution, optParam });
	VanasKoS_CoreFrame:Show();
end

function VanasKoS:UnscheduleAction(nameOrFunction, optParam)
	for k,v in ScheduledActions do
		if( v[1] == name and ( not optParam or v[3] == optParam ) ) then
			tremove(ScheduledActions, k);
		end
	end
end

function VanasKoS:Tooltip_AddMessage(msg)
	GameTooltip:AddLine(msg);

	-- resize
	local newWidth = 0;
	local numlines = GameTooltip:NumLines();
	GameTooltip:SetHeight((numlines*16) + 20);

	for i = 1, numlines do
        local checkText = getglobal("GameTooltipTextLeft"..i);
        if (checkText and ((checkText:GetWidth() + 24) > newWidth)) then
                newWidth = (checkText:GetWidth() + 24);
        end
	end
	GameTooltip:SetWidth(newWidth);
end

function VanasKoS:IsKoSPlayer(name)
	if(name == nil) then
		return nil;
	end

	local result = self.db:get({"koslist", GetRealmName(), "players", string.lower(name)}, "reason");

	if(result == nil or result == "") then
		return nil;
	else
		return result;
	end
end

function VanasKoS:IsKoSGuild(name)
	if(name == nil) then
		return nil;
	end

	local result = self.db:get({"koslist", GetRealmName(), "guilds", string.lower(name)}, "reason");

	if(result == nil or result == "") then
		return nil;
	else
		return result;
	end
end

function VanasKoS:NotifyKoS(name, guild)
	if (notifyAllowed ~= TRUE) then
		return nil;
	end

	notifyAllowed = FALSE
	-- Reallow Notifies in NotifyTimeInterval Time
	self:ScheduleAction(function() notifyAllowed = TRUE end, self.GetOpt("NotifyTimerInterval"));

	local msg = "";
	msg = "Player: " .. name;
	if(self:IsKoSPlayer(name)) then
		msg = msg .. " (" .. self:IsKoSPlayer(name) .. ")";
	end
	if(guild) then
		msg = msg .. " <" .. guild .. ">";
	end
	if(self:IsKoSGuild(guild)) then
		msg = msg .. " (" .. self:IsKoSGuild(guild) .. ")";
	end

	if(self.GetOpt("notifyVisual")) then
		UIErrorsFrame:AddMessage("KoS: " .. msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
	end
	if(self.GetOpt("notifyChatframe")) then
		self.cmd:msg(msg);
	end
	if(self.GetOpt("playSound")) then
		PlaySound("igBonusBarOpen");
	end
end

function VanasKoS:ListKoS()
	self.cmd:msg(format(VANASKOS_TEXT_KOS_LIST_FOR_REALM, GetRealmName()));

	-- Get KoS Players
	local players = self.db:get({"koslist", GetRealmName()}, "players");
	DEFAULT_CHAT_FRAME:AddMessage(VANASKOS_TEXT_PLAYERS_COLON);
	if(players ~= nil) then
    for index, value in players do
      DEFAULT_CHAT_FRAME:AddMessage("          " .. index .. " (" .. value.reason .. ")");
    end
	end

	-- Get KoS Guilds
	local guilds = self.db:get({"koslist", GetRealmName()}, "guilds");
	DEFAULT_CHAT_FRAME:AddMessage(VANASKOS_TEXT_GUILDS_COLON);
	if(guilds ~= nil) then
    for index, value in guilds do
      DEFAULT_CHAT_FRAME:AddMessage("          " .. index .. " (" .. value.reason .. ")");
    end
	end
end

function VanasKoS:UpdateKoSDB(name, guild, level, class, race)
	if(self:IsKoSPlayer(name)) then
		self.db:set({"koslist", GetRealmName(), "players", string.lower(name)}, "displayname", name);
		self.db:set({"koslist", GetRealmName(), "players", string.lower(name)}, "guild", guild);
		self.db:set({"koslist", GetRealmName(), "players", string.lower(name)}, "level", level);
		self.db:set({"koslist", GetRealmName(), "players", string.lower(name)}, "class", class);
		self.db:set({"koslist", GetRealmName(), "players", string.lower(name)}, "race", race);
		self:UpdateKoSLastSeen(name);
		self:GUIOnUpdate();
	end
	if(self:IsKoSGuild(guild)) then
		self.db:set({"koslist", GetRealmName(), "guilds", string.lower(guild)}, "displayname", guild);
		self:GUIOnUpdate();
	end
end

function VanasKoS:UpdateKoSLastSeen(name)
	if(self:IsKoSPlayer(name)) then
		self.db:set({"koslist", GetRealmName(), "players", string.lower(name)}, "lastseen", time());
	end
end

--[[----------------------------------------------------------------------
  Chat Command Handlers
------------------------------------------------------------------------]]
function VanasKoS:AddKoSPlayer(args)
	local reason = "";

	if (string.find(args, "reason") ~= nil) then
		reason = string.sub(args, string.find(args, "reason") + 7, string.len(args));
		args = string.sub(args, 0, string.find(args, " ") - 1);
	end

	self:AddKoSPlayerR(args, reason);
end

function VanasKoS:AddKoSPlayerR(player, reason)
	if(reason == "") then
		reason = VANASKOS.TEXT_REASON_UNKNOWN;
	end
	self.db:set({"koslist", GetRealmName(), "players", string.lower(player)}, "reason", reason);
	self.cmd:result(format(VANASKOS_TEXT_PLAYER_ADDED, player, reason));
end

function VanasKoS:AddKoSGuild(args)
	local reason = "";

	if (string.find(args, "reason") ~= nil) then
		reason = string.sub(args, string.find(args, "reason") + 7, string.len(args));
		args = string.sub(args, 0, string.find(args, "reason") - 2);
	else
		reason = "";
	end

	self:AddKoSGuildR(args, reason);
end

function VanasKoS:AddKoSGuildR(name, reason)
	if(reason == "") then
		reason = VANASKOS.TEXT_REASON_UNKNOWN;
	end
	self.db:set({"koslist", GetRealmName(), "guilds", string.lower(name)}, "reason", reason);

	self.cmd:result(format(VANASKOS_TEXT_GUILD_ADDED, name, reason));
end

function VanasKoS:RemoveKoSPlayer(name)
	if(name == nil) then
		return nil;
	end;
	self.db:set({"koslist", GetRealmName(), "players"}, string.lower(name));
	self.cmd:result(format(VANASKOS_TEXT_PLAYER_REMOVED, name));
end

function VanasKoS:RemoveKoSGuild(name)
	if(name == nil) then
		return nil;
	end;
	self.db:set({"koslist", GetRealmName(), "guilds"}, string.lower(name));
	self.cmd:result(format(VANASKOS_TEXT_GUILD_REMOVED, name));
end

function VanasKoS:ResetKoSList()
	self.db:set({"koslist", GetRealmName()}, "players");
	self.db:set({"koslist", GetRealmName()}, "guilds");
	self.cmd:result(format(VANASKOS_TEXT_LIST_PURGED, GetRealmName()));
end

--[[----------------------------------------------------------------------
	Import Functions
------------------------------------------------------------------------]]

function VanasKoS:ImportKoSListFromUBotD()
	if(ubdKos == nil) then
		self.cmd:result(VANASKOS_TEXT_UBOTD_IMPORT_FAILED);
		return nil;
	end
	if(ubdKos.kos == nil) then
		self.cmd:result(VANASKOS_TEXT_UBOTD_IMPORT_FAILED);
		return nil;
	end
	for index, value in ubdKos.kos do
		if(value.notes == "Unk") then
			self:AddKoSPlayer(index);
			self.cmd:result(index .. " " .. VANASKOS_TEXT_IMPORTED .. ".");
		else
			self:AddKoSPlayer(index .. " reason " .. value.notes);
			self.cmd:result(index .. " (" .. value.notes .. ") " .. VANASKOS_TEXT_IMPORTED .. ".");
		end
  end
	self.cmd:result(VANASKOS_TEXT_UBOTD_IMPORT_SUCCESS);
end

--[[----------------------------------------------------------------------
	Configuration Commands
------------------------------------------------------------------------]]
function VanasKoS:ToggleNotifyVisual()
	self.TogMsg(VANASKOS_TEXT_NOTIFY_UPPER, self.TogOpt("notifyVisual"));
end

function VanasKoS:ToggleWarnFrame()
	self.TogMsg(VANASKOS_TEXT_WARN_FRAME, self.TogOpt("enableWarnFrame"));

	if(VanasKoS_WarnFrame:IsVisible() and not self.GetOpt("enableWarnFrame")) then
		VanasKoS_WarnFrame:Hide();
	end
	if(not VanasKoS_WarnFrame:IsVisible() and self.GetOpt("enableWarnFrame")) then
		VanasKoS_WarnFrame:Show();
	end
end

function VanasKoS:ToggleNotifyChatframe()
	self.TogMsg(VANASKOS_TEXT_NOTIFY_CHATFRAME, self.TogOpt("notifyChatframe"));
end

function VanasKoS:ToggleNotifySound()
	self.TogMsg(VANASKOS_TEXT_PLAY_SOUND, self.TogOpt("playSound"));
end

function VanasKoS:ConfigSetNotificationInterval(args)
	if(tonumber(args) == self.GetOpt("NotifyTimerInterval")) then
		return nil;
	end
	self.SetOpt("NotifyTimerInterval", tonumber(args));
	self.cmd:status(VANASKOS_TEXT_NOTIFY_INTERVAL, self.GetOpt("NotifyTimerInterval"));
end

function VanasKoS:Report()
	self.cmd:report({
		{text = VANASKOS_TEXT_NOTIFY_UPPER, val = self.GetOpt("notifyVisual"), map = VANASKOS.MAP_ONOFF_COLOR},
		{text = VANASKOS_TEXT_NOTIFY_CHATFRAME, val = self.GetOpt("notifyChatframe"), map = VANASKOS.MAP_ONOFF_COLOR},
		{text = VANASKOS_TEXT_PLAY_SOUND, val = self.GetOpt("playSound"), map = VANASKOS.MAP_ONOFF_COLOR},
		{text = VANASKOS_TEXT_WARN_FRAME, val = self.GetOpt("enableWarnFrame"), map = VANASKOS.MAP_ONOFF_COLOR},
		{text = VANASKOS_TEXT_NOTIFY_INTERVAL, val = self.GetOpt("NotifyTimerInterval"), map = nil}
	});
end

--[[----------------------------------------------------------------------
	Event Handlers
------------------------------------------------------------------------]]
function VanasKoS:UPDATE_MOUSEOVER_UNIT()
	if(UnitIsPlayer("mouseover")) then
		local name = UnitName("mouseover");
		local guild = GetGuildInfo("mouseover");

		self:UpdateKoSDB(name, guild, UnitLevel("mouseover"), UnitClass("mouseover"), UnitRace("mouseover"));
		
		if(self:IsKoSPlayer(name)) then
			self:GUIWarnFrameAddPlayer(name, "kos");
			self:Tooltip_AddMessage(VANASKOS_TEXT_KOS .. " " .. self:IsKoSPlayer(name));
      if(self:IsKoSGuild(guild)) then
        self:Tooltip_AddMessage(VANASKOS_TEXT_KOS_GUILD .. " " .. self:IsKoSGuild(guild));
      end
			self:NotifyKoS(name, guild);
		else
      if(self:IsKoSGuild(guild)) then
				self:GUIWarnFrameAddPlayer(name, "kos");
        self:Tooltip_AddMessage(VANASKOS_TEXT_KOS_GUILD .. " " .. self:IsKoSGuild(guild));
        self:NotifyKoS(name, guild);
      end
    end
	end
end

function VanasKoS:PLAYER_TARGET_CHANGED()
	if(UnitIsPlayer("target")) then
		local name = UnitName("target");
    local guild = GetGuildInfo("target");

  	self:UpdateKoSDB(name, guild, UnitLevel("target"), UnitClass("target"), UnitRace("target"));
		if(self:IsKoSPlayer(name)) then
      TargetFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTexture:GetAlpha());
      TargetFrameTexture:SetVertexColor(1.0, 200.0, 1.0, TargetFrameTexture:GetAlpha());
			TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
			self:NotifyKoS(name, guild);
			self:GUIWarnFrameAddPlayer(name, "kos");
    elseif(self:IsKoSGuild(guild)) then
      TargetFrameTexture:SetVertexColor(1.0, 200.0, 1.0, TargetFrameTexture:GetAlpha());
			TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
      TargetFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTexture:GetAlpha());
      self:GUIWarnFrameAddPlayer(name, "kos");
    end
	else
		TargetFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTexture:GetAlpha());
	end
end

function VanasKoS:ChatMessageAndEmoteHandler()
	if(self:IsKoSPlayer(arg2)) then
		self:NotifyKoS(arg2, nil);
	end
end

function VanasKoS:ChatCombatMessageHandlerFriendly()
	self:ChatCombatMessageHandler("friendly");
end

function VanasKoS:ChatCombatMessageHandlerEnemy()
	self:ChatCombatMessageHandler("enemy");
end

function VanasKoS:GetPlayerOfChatCombatMessage(message)
  for index, value in VANASKOS.TargetMatch do
    local s, e;
    local results = {};
    s, e, results[0], results[1], results[2], results[3], results[4] = string.find(arg1, value.pattern);
    if(results[value.patternname] ~= nil) then
    	return results[value.patternname];
    end
  end
  return nil;
end

function VanasKoS:ChatCombatMessageHandler(faction)
  if(arg1) then
  	local name = self:GetPlayerOfChatCombatMessage(arg1);
  	if(name == nil) then
  		return nil;
  	end
    if(self:IsKoSPlayer(name)) then
			self:UpdateKoSLastSeen();
      self:NotifyKoS(name, nil);
      self:GUIWarnFrameAddPlayer(name, "kos");
    end
    if(faction == "enemy") then
      self:GUIWarnFrameAddPlayer(name, "enemy");
    end
    if(faction == "friendly") then
      self:GUIWarnFrameAddPlayer(name, "friendly");
    end
  end
end

--[[----------------------------------------------------------------------
		GUI Functions
------------------------------------------------------------------------]]

VANASKOS.selectedEntry = nil;


function VanasKoS:ToggleMenu()
	if(VanasKoSFrame:IsVisible()) then
		VanasKoSFrame:Hide();
	else
		VanasKoSFrame:Show();
	end
end

local VANASKOSFRAME_SUBFRAMES = { "VanasKoSPlayersListFrame", "VanasKoSGuildsListFrame", "VanasKoSConfigurationFrame", "VanasKoSAboutFrame" };
function VanasKoS:GUIFrame_ShowSubFrame(frameName)
	for index, value in VANASKOSFRAME_SUBFRAMES do
		if(value == frameName) then
			getglobal(value):Show();
		else
			getglobal(value):Hide();
		end
	end
end

function VanasKoS:GUIShowChangeDialog()
	local dialog = nil;
	if(VANASKOS.selectedEntry) then
		dialog = StaticPopup_Show("VANASKOS_CHANGE_ENTRY");
		local name = self:GUIGetSelectedEntryName();
		local reason = "";
		if(VanasKoSFrame.showPlayersList) then
			reason = self.db:get({"koslist", GetRealmName(), "players", string.lower(name)}, "reason");
		else
			reason = self.db:get({"koslist", GetRealmName(), "guilds", string.lower(name)}, "reason");
		end
		getglobal(dialog:GetName() .. "EditBox"):SetText(reason);
	end
end

function VanasKoS:GUIChangeKoSReason(reason)
		local name = self:GUIGetSelectedEntryName();
		if(VanasKoSFrame.showPlayersList) then
			self.db:set({"koslist", GetRealmName(), "players", string.lower(name)}, "reason", reason);
		else
			self.db:set({"koslist", GetRealmName(), "guilds", string.lower(name)}, "reason", reason);
		end
		self:GUIScrollUpdate();
end

function VanasKoS:GUIGetSelectedEntryName()
	if(VANASKOS.selectedEntry) then
			local listVar = nil;
			local listIndex = 1;
			
			if(not self.db.initialized) then
				return nil;
			end
			
			if(VanasKoSFrame.showPlayersList) then
				listVar = self.db:get({"koslist", GetRealmName()}, "players");
			else
				listVar = self.db:get({"koslist", GetRealmName()}, "guilds");
			end

			if(listVar == nil) then
				self:GUIHideButtons(1, 10);
				return nil;
			end

			for k,v in listVar do
				if(listIndex == VANASKOS.selectedEntry) then
					return k;
				end
				listIndex = listIndex + 1;
			end

	end
	return nil;
end

function VanasKoS:GUIRemoveDialog()
	if(VanasKoSFrame.showPlayersList) then
		self:RemoveKoSPlayer(VanasKoS:GUIGetSelectedEntryName());
	else
		self:RemoveKoSGuild(VanasKoS:GUIGetSelectedEntryName());
	end
	self:GUIScrollUpdate()
end

function VanasKoS:GUIListButton_OnClick(button)
	if(button == "LeftButton") then
		VANASKOS.selectedEntry = this:GetID();
		self:GUIScrollUpdate();
	end
end

function VanasKoS:GUIHideButtons(minimum, maximum)
	for i=minimum,maximum,1 do
		local button = getglobal("VanasKoSListFrameListButton" .. i);
		if(button ~= nil) then
			button:Hide();
		end
	end
end

function VanasKoS:GUIShowButtons(minimum, maximum)
	for i=minimum,maximum,1 do
		local button = getglobal("VanasKoSListFrameListButton" .. i);
		button:Show();
	end
end

function VanasKoS:GUIScrollUpdate()
	local listOffset = FauxScrollFrame_GetOffset(VanasKoSListScrollFrame);
	local listVar = nil;
	local listIndex = 1;
	local buttonIndex = 1;
	
	if(not self.db.initialized) then
		return nil;
	end
	
	if(VanasKoSFrame.showPlayersList) then
		listVar = self.db:get({"koslist", GetRealmName()}, "players");
	else
		listVar = self.db:get({"koslist", GetRealmName()}, "guilds");
	end

	if(listVar == nil) then
		VANASKOS.selectedEntry = nil;
		self:GUIHideButtons(1, 10);
		return nil;
	end

	for k,v in listVar do
 		if((listIndex-1) < listOffset) then
		else
			if(buttonIndex <= 10) then
				local buttonText1 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "ButtonTextName");
				local buttonText2 = getglobal("VanasKoSListFrameListButton" ..  buttonIndex .. "ButtonTextReason");
				local button = getglobal("VanasKoSListFrameListButton" .. buttonIndex);
				
				if(v.displayname and VanasKoSFrame.showPlayersList) then
					buttonText1:SetText(v.displayname .. VANASKOS_COLOR_WHITE .."  Level " .. v.level .. " " .. v.race .. " " .. v.class .. VANASKOS_COLOR_END);
				else
					if(v.displayname and not VanasKoSFrame.showPlayersList) then
						buttonText1:SetText(v.displayname);
					else
						buttonText1:SetText(string.Capitalize(k));
					end
				end
				if(v.lastseen and VanasKoSFrame.showPlayersList) then
					buttonText2:SetText(string.Capitalize(v.reason) .. " (" .. VANASKOS_TEXT_LAST_SEEN .. " " .. SecondsToTime(time() - v.lastseen) .. "ago)");
				else
					buttonText2:SetText(string.Capitalize(v.reason));
				end
				button:SetID(listIndex);
				button:Show();
				
				if(listIndex == VANASKOS.selectedEntry) then
					button:LockHighlight();
				else
					button:UnlockHighlight();
				end
				buttonIndex = buttonIndex + 1;
			end
		end
		listIndex = listIndex + 1;
	end
	
	if(listIndex <= 10) then
		self:GUIHideButtons(listIndex, 10);
	end
	
	if(listIndex == 1) then
		VANASKOS.selectedEntry = nil;
	else
		if(VANASKOS.selectedEntry == nil) then
			VANASKOS.selectedEntry = 1;
			self:GUIScrollUpdate();
		end
		if(VANASKOS.selectedEntry >= listIndex) then
			VANASKOS.selectedEntry = 1;
			self:GUIScrollUpdate();
		end
	end

	-- 34 = Hoehe VanasKoSListFrameListButtonTemplate
	-- scrollframe, maxnum, to_display, height
	FauxScrollFrame_Update(VanasKoSListScrollFrame, listIndex-1, 10, 34);
end

function VanasKoS_GUIOnScroll()
	VanasKoS:GUIScrollUpdate();
end

function VanasKoS:GUIOnUpdate()
	if(not VanasKoSFrame:IsVisible()) then
		return nil;
	end
	if(VanasKoSFrame.selectedTab == 1) then
		VanasKoSFrameTopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft");
		VanasKoSFrameTopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight");
		VanasKoSFrameBottomLeft:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-BotLeft");
		VanasKoSFrameBottomRight:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-BotRight");
		VanasKoSListFrame:Show();
		
		if(VanasKoSFrame.showPlayersList) then
			self:GUIFrame_ShowSubFrame("VanasKoSPlayersListFrame");
			VanasKoSFrameTitleText:SetText(VANASKOS.NAME .. " - " .. VANASKOS_TEXT_PLAYER_LIST);
			self:GUIScrollUpdate();
		else
			self:GUIFrame_ShowSubFrame("VanasKoSGuildsListFrame");
			VanasKoSFrameTitleText:SetText(VANASKOS.NAME .. " - " .. VANASKOS_TEXT_GUILDS_LIST);
			self:GUIScrollUpdate();
		end
	end
	if(VanasKoSFrame.selectedTab == 2) then
		VanasKoSFrameTopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft");
		VanasKoSFrameTopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight");
		VanasKoSFrameBottomLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomLeft");
		VanasKoSFrameBottomRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomRight");
		VanasKoSListFrame:Hide();
		self:GUIFrame_ShowSubFrame("VanasKoSConfigurationFrame");
		VanasKoSFrameTitleText:SetText(VANASKOS.NAME .. " - " .. VANASKOS_TEXT_CONFIGURATION);
	end
	if(VanasKoSFrame.selectedTab == 3) then
		VanasKoSFrameTopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft");
		VanasKoSFrameTopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight");
		VanasKoSFrameBottomLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomLeft");
		VanasKoSFrameBottomRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomRight");
		VanasKoSListFrame:Hide();
		self:GUIFrame_ShowSubFrame("VanasKoSAboutFrame");
		VanasKoSFrameTitleText:SetText(VANASKOS.NAME .. " - " .. VANASKOS_TEXT_ABOUT);
	end
end

function VanasKoS_GUIWarnFrameRemovePlayer(name)
	VanasKoS:GUIWarnFrameRemovePlayer(name);
end

function VanasKoS:GUIWarnFrameRemovePlayer(name)
	for k,v in nearbyKos do
		if(v[1] == name) then
			tremove(nearbyKos, k);
		end
	end
	for k,v in nearbyEnemys do
		if(v[1] == name) then
			tremove(nearbyEnemys, k);
		end
	end
	for k,v in nearbyFriendly do
		if(v[1] == name) then
			tremove(nearbyFriendly, k);
		end
	end

	VanasKoS:GUIUpdateWarnFrame();
end

function VanasKoS:GUIWarnFrameAddPlayer(name, faction)
	if(name == VANASKOS.TEXT_UNKNOWN_ENTITY) then
		return nil;
	end

	self:GUIWarnFrameRemovePlayer(name)
	if(faction == "kos") then
		tinsert(nearbyKos, { name, faction });
		self:UnscheduleAction("VanasKoS_GUIWarnFrameRemovePlayer", name);
		self:ScheduleAction("VanasKoS_GUIWarnFrameRemovePlayer", self.GetOpt("NotifyTimerInterval"), name);
		VanasKoS:GUIUpdateWarnFrame();

		return nil;
	end
	if(faction == "enemy") then
		tinsert(nearbyEnemys, { name, faction });
	end
	if(faction == "friendly") then
		tinsert(nearbyFriendly, { name, faction });
	end

	self:UnscheduleAction("VanasKoS_GUIWarnFrameRemovePlayer", name);
	self:ScheduleAction("VanasKoS_GUIWarnFrameRemovePlayer", 10, name);
	VanasKoS:GUIUpdateWarnFrame();
end

function VanasKoS:GUIDebugShowTables()
	self.cmd:msg("showtables");
	-- kos
	for k, v in nearbyKos do
		self.cmd:msg(v[1]);
	end

	-- enemy but not kos
	for k, v in nearbyEnemys do
		self.cmd:msg(v[1]);
	end

	-- friendly players
	for k, v in nearbyFriendly do
		self.cmd:msg(v[1]);
	end
end

function VanasKoS:GUIUpdateWarnFrame()
	-- +1, because it doesn't count you
	if( (getn(nearbyKos)+getn(nearbyEnemys)) > (getn(nearbyFriendly)+1)) then
		VanasKoS_WarnFrame:SetBackdropColor(1.0, 0.0, 0.0, 0.5);
	end
	if( (getn(nearbyKos)+getn(nearbyEnemys)) < (getn(nearbyFriendly)+1)) then
		VanasKoS_WarnFrame:SetBackdropColor(0.0, 1.0, 0.0, 0.5);
	end
	if( getn(nearbyKos)+getn(nearbyEnemys) == 0 or (getn(nearbyKos)+getn(nearbyEnemys) == (getn(nearbyFriendly)+1)) ) then
		VanasKoS_WarnFrame:SetBackdropColor(0.5, 0.5, 1.0, 0.5);
	end

	local counter = 0;

	-- kos
	for k, v in nearbyKos do
		if (counter < 5) then
			getglobal("VanasKoS_WarnFrameText" .. counter):SetTextColor(1.0, 0.0, 1.0);
			getglobal("VanasKoS_WarnFrameText" .. counter):SetText(v[1]);
			counter = counter + 1;
		end
	end

	-- enemy but not kos
	for k, v in nearbyEnemys do
		if (counter < 5) then
			getglobal("VanasKoS_WarnFrameText" .. counter):SetTextColor(1.0, 0.0, 0.0);
			getglobal("VanasKoS_WarnFrameText" .. counter):SetText(v[1]);
			counter = counter + 1;
		end
	end

	-- friendly players
	for k, v in nearbyFriendly do
		if (counter < 5) then
			getglobal("VanasKoS_WarnFrameText" .. counter):SetTextColor(0.0, 1.0, 0.0);
			getglobal("VanasKoS_WarnFrameText" .. counter):SetText(v[1]);
			counter = counter + 1;
		end
	end

	if(counter < 5) then
		for i=counter, 5, 1 do
			getglobal("VanasKoS_WarnFrameText" .. counter):SetText("");
		end
	end

end

function VanasKoS:GUIUpdateConfigurationFrame()
	if(VanasKoSConfigNotifyInterval:GetText() ~= "") then
		self:ConfigSetNotificationInterval(VanasKoSConfigNotifyInterval:GetText());
	end
	VanasKoSConfigVisual:SetChecked(self.GetOpt("notifyVisual"));
	VanasKoSConfigChatFrame:SetChecked(self.GetOpt("notifyChatframe"));
	VanasKoSConfigWarnFrame:SetChecked(self.GetOpt("enableWarnFrame"))
	VanasKoSConfigPlaySound:SetChecked(self.GetOpt("playSound"));
	if(self.GetOpt("NotifyTimerInterval") == nil) then
		VanasKoSConfigNotifyInterval:SetText("0");
	else
		VanasKoSConfigNotifyInterval:SetText(self.GetOpt("NotifyTimerInterval"));
	end
	
end

function string.Capitalize( str )
    return string.upper( string.sub( str, 1, 1 ) )..string.sub( str, 2 )
end


VanasKoS:RegisterForLoad();
