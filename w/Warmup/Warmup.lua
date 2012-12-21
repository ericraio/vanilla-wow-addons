local inittime, initmem, initgc = GetTime(), gcinfo()

Warmup = {
--	gcalerts = true,

	myname = "!!Warmup",

	inittime = inittime,
	initmem = initmem,
	initgc = initgc,

	lasttime = inittime,
	lastmem = initmem,
	lastgc = initgc,

	longesttime = 0,
	biggestmem = 0,
	totalmem = 0,

	timethresh = 1.0,
	timethresh2 = 0.5,
	timethresh3 = 0.1,

	memthresh = 1000,
	memthresh2 = 500,
	memthresh3 = 100,

	green = "|cff80ff80",
	yellow = "|cffffff80",
	orange = "|cffff8000",
	red = "|cffff0000",
}
inittime, initmem, initgc = nil, nil, nil


function Warmup:PutOut(txt, color, time, mem)
	local outstr = ((not time) and string.format("%s%s (%d KiB)", color, txt, mem))
		or (not mem and string.format("%.3f sec | %s%s", time, color, txt))
		or string.format("%.3f sec | %s%s (%d KiB)", time, color, txt, mem)

	self.frame:AddMessage(outstr)
	self.myframe:AddMessage(outstr)
end


function Warmup:PutOutAO(ao)
	local gc = (ao.gc and " |cffff80ff-GC-") or ""
	local tc = (ao.time >= Warmup.timethresh and self.red) or (ao.time >= Warmup.timethresh2 and self.orange) or (ao.time >= Warmup.timethresh3 and self.yellow) or self.green
	local mc = (ao.mem >= Warmup.memthresh and self.red) or (ao.mem >= Warmup.memthresh2 and self.orange) or (ao.mem >= Warmup.memthresh3 and self.yellow) or self.green
	local outstr = string.format("%s%.3f sec|r | %s (%s%d KiB|r)%s", tc, ao.time, ao.name, mc, ao.mem, gc)

	self.myframe:AddMessage(outstr)
end


function Warmup:OnLoad()
	tinsert(UISpecialFrames,"WarmupOutputFrame")

	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("ADDON_LOADED")

	self.WoW_ReloadUI = ReloadUI
	ReloadUI = function ()
		Warmup.reloading = true
		Warmup.WoW_ReloadUI()
	end

	self.WoW_LoadAddOn = LoadAddOn
	LoadAddOn = function (addon)
		Warmup.lasttime = GetTime()
		Warmup.lastmem, Warmup.lastgc = gcinfo()
		return Warmup.WoW_LoadAddOn(addon)
	end

	self:SetEventTable()
	for i,ev in pairs(self.events) do this:RegisterEvent(ev) end

	self.eventvals = {}
end


function Warmup:Init()
	if not WarmupSV then WarmupSV = {} end
	self.sv = WarmupSV
	self.sv.addoninfo = {}

	self.myframe = getglobal("WarmupChatFrame")
	self.frame = getglobal("ChatFrame2")
	for i=1,GetNumAddOns() do
		if IsAddOnLoaded(i) then
			if GetAddOnInfo(i) ~= self.myname then
				self.frame:AddMessage("Addon loaded before Warmup: ".. GetAddOnInfo(i))
				self.myframe:AddMessage("Addon loaded before Warmup: ".. GetAddOnInfo(i))
			end
		end
	end

	self.myframe:SetScript("OnMouseWheel", function ()
		if arg1 > 0 then this:ScrollUp()
		elseif arg1 < 0 then
			if IsShiftKeyDown() then this:ScrollToBottom()
			else this:ScrollDown() end
		end
	end)
	self.myframe:EnableMouseWheel(1)

end


function Warmup:OnUpdate()
	if self.gcalerts then
		local mem, gc = gcinfo()

		if (Warmup.gc and gc ~= Warmup.gc) then
			local outstr = string.format("GC fired | mem %d --> %d | threshold %d --> %d", Warmup.mem, mem, Warmup.gc, gc)
			Warmup.frame:AddMessage(outstr)
			self.myframe:AddMessage(outstr)
		end

		self.mem, self.gc = mem, gc
	end
end


function Warmup:DumpEvents()
	local sortt = {}
	for ev,val in pairs(self.eventvals) do table.insert(sortt, ev) end

	table.sort(sortt, function (a,b) return a<b end)

	for i,ev in pairs(sortt) do
		self.myframe:AddMessage(string.format(self.red.."%d|r | %s%s|r", Warmup.eventvals[ev], self.green, ev))
	end
end


function Warmup:OnEvent()
	if self.eventvals then self.eventvals[event] = (self.eventvals[event] or 0) + 1 end

	if (event == "ADDON_LOADED") then self:ADDON_LOADED()
	elseif (event == "VARIABLES_LOADED") then self:VARIABLES_LOADED()
	elseif (event == "PLAYER_LOGIN") then self:PLAYER_LOGIN()
	elseif (event == "PLAYER_ENTERING_WORLD") then self:PLAYER_ENTERING_WORLD()
	elseif (event == "PLAYER_LEAVING_WORLD") then self:PLAYER_LEAVING_WORLD()
	elseif (event == "PLAYER_LOGOUT") then self:PLAYER_LOGOUT() end
end


function Warmup:ADDON_LOADED()
	local addontime, addonmem, addongc = GetTime(), gcinfo()
	local diff = addonmem - self.lastmem
	local hadgc

	if not self.myframe then self:Init() end

	local aoinfo = {
		name = arg1,
		time = addontime - self.lasttime,
		mem = addonmem - self.lastmem,
	}

	-- When LUA performs a GC it sets the new threshold to the new memory use * 1.25
	-- so we can figure out how much memory was freed!

	if addongc ~= self.lastgc then
		diff = addonmem - (addongc/1.25) + self.lastgc - self.lastmem
		hadgc = true
		aoinfo.mem = addonmem - (addongc/1.25) + self.lastgc - self.lastmem;
		aoinfo.gc = true
	end

	self:PutOutAO(aoinfo)
	table.insert(self.sv.addoninfo, aoinfo)

	if (addontime - self.lasttime) > self.longesttime then
		self.longesttime = addontime - Warmup.lasttime
		self.longestaddon = arg1
	end
	if (diff) > self.biggestmem then
		self.biggestmem = diff
		self.biggestaddon = arg1
	end
	self.totalmem = Warmup.totalmem + diff
	self.lasttime, self.lastmem, self.lastgc = addontime, addonmem, addongc
end


function Warmup:VARIABLES_LOADED()
	self.varsloadtime = GetTime()
	if self.sv.time then
		self:PutOut("ReloadUI", self.green, self.inittime - self.sv.time)
	end
	self:PutOut("Addon Loadup", self.green, self.varsloadtime - self.inittime, self.lastmem - self.initmem)

	self:PutOut("Longest addon: ".. self.longestaddon, self.yellow, self.longesttime)
	self:PutOut("Biggest addon: ".. self.biggestaddon, self.yellow, nil, self.biggestmem)

	this:RegisterEvent("PLAYER_LOGIN")
	this:UnregisterEvent("VARIABLES_LOADED")

	SlashCmdList["RELOADTIME"] = function() ReloadUI() end
	SLASH_RELOADTIME1 = "/rlt"

	SlashCmdList["WARMUP"] = function (msg) Warmup:Slash(msg) end
	SLASH_WARMUP1 = "/wu"
	SLASH_WARMUP2 = "/warmup"
end


function Warmup:PLAYER_LOGIN()
	self.logging = true
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
end


function Warmup:PLAYER_ENTERING_WORLD()
	if self.inittime and self.logging then
		local entrytime = GetTime()

		self:PutOut("World entry", self.green, entrytime - self.varsloadtime)

		if self.sv.time then self:PutOut("Total time", self.green, entrytime - self.sv.time)
		else self:PutOut("Total time", self.green, entrytime - Warmup.inittime) end

		self.sv.time = nil
		self.varsloadtime = nil
	elseif self.sv.time then
		self:PutOut("Zoning", self.green, GetTime() - self.sv.time)
		self.sv.time = nil
	end
	self.logging = nil
	this:UnregisterEvent("PLAYER_LOGIN")
	this:UnregisterEvent("PLAYER_LOGOUT")
	this:UnregisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_LEAVING_WORLD")

	for i,ev in pairs(Warmup.events) do this:UnregisterEvent(ev) end

	self:DumpEvents()
	self.events = nil
	self.eventvals = nil
end


function Warmup:PLAYER_LEAVING_WORLD()
	self.sv.time = GetTime()
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_LOGOUT")
	this:UnregisterEvent("PLAYER_LEAVING_WORLD")

	self:SetEventTable()

	for i,ev in pairs(Warmup.events) do this:RegisterEvent(ev) end

	self.eventvals = {}
end


function Warmup:PLAYER_LOGOUT()
	if not self.reloading then self.sv.time = nil end
end




function Warmup:Slash(msg)
	if (WarmupOutputFrame:IsVisible()) then WarmupOutputFrame:Hide()
	else WarmupOutputFrame:Show() end
end


function Warmup:SetEventTable()
	self.events = {
		"ACTIONBAR_HIDEGRID",
		"ACTIONBAR_PAGE_CHANGED",
		"ACTIONBAR_SHOWGRID",
		"ACTIONBAR_SLOT_CHANGED",
		"ACTIONBAR_UPDATE_COOLDOWN",
		"ACTIONBAR_UPDATE_STATE",
		"ACTIONBAR_UPDATE_USABLE",
		"AREA_SPIRIT_HEALER_IN_RANGE",
		"AREA_SPIRIT_HEALER_OUT_OF_RANGE",
		"AUCTION_BIDDER_LIST_UPDATE",
		"AUCTION_HOUSE_CLOSED",
		"AUCTION_HOUSE_SHOW",
		"AUCTION_ITEM_LIST_UPDATE",
		"AUCTION_OWNED_LIST_UPDATE",
		"AUTOEQUIP_BIND_CONFIRM",
		"AUTOFOLLOW_BEGIN",
		"AUTOFOLLOW_END",
		"BAG_CLOSED",
		"BAG_OPEN",
		"BAG_UPDATE",
		"BAG_UPDATE_COOLDOWN",
		"BANKFRAME_CLOSED",
		"BANKFRAME_OPENED",
		"BATTLEFIELDS_CLOSED",
		"BATTLEFIELDS_SHOW",
		"BILLING_NAG_DIALOG",
		"BIND_ENCHANT",
		"CANCEL_LOOT_ROLL",
		"CHARACTER_LIST_UPDATE",
		"CHARACTER_POINTS_CHANGED",
		"CHAT_MSG",
		"CHAT_MSG_AFK",
		"CHAT_MSG_BG_SYSTEM_ALLIANCE",
		"CHAT_MSG_BG_SYSTEM_HORDE",
		"CHAT_MSG_BG_SYSTEM_NEUTRAL",
		"CHAT_MSG_CHANNEL",
		"CHAT_MSG_CHANNEL_JOIN",
		"CHAT_MSG_CHANNEL_LEAVE",
		"CHAT_MSG_CHANNEL_LIST",
		"CHAT_MSG_CHANNEL_NOTICE",
		"CHAT_MSG_CHANNEL_NOTICE_USER",
		"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES",
		"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES",
		"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
		"CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES",
		"CHAT_MSG_COMBAT_ERROR",
		"CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS",
		"CHAT_MSG_COMBAT_FRIENDLYPLAYER_MISSES",
		"CHAT_MSG_COMBAT_FRIENDLY_DEATH",
		"CHAT_MSG_COMBAT_HONOR_GAIN",
		"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
		"CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES",
		"CHAT_MSG_COMBAT_HOSTILE_DEATH",
		"CHAT_MSG_COMBAT_MISC_INFO",
		"CHAT_MSG_COMBAT_PARTY_HITS",
		"CHAT_MSG_COMBAT_PARTY_MISSES",
		"CHAT_MSG_COMBAT_PET_HITS",
		"CHAT_MSG_COMBAT_PET_MISSES",
		"CHAT_MSG_COMBAT_SELF_HITS",
		"CHAT_MSG_COMBAT_SELF_MISSES",
		"CHAT_MSG_COMBAT_XP_GAIN",
		"CHAT_MSG_DND",
		"CHAT_MSG_EMOTE",
		"CHAT_MSG_GUILD",
		"CHAT_MSG_IGNORED",
		"CHAT_MSG_LOOT",
		"CHAT_MSG_MONSTER_EMOTE",
		"CHAT_MSG_MONSTER_SAY",
		"CHAT_MSG_MONSTER_WHISPER",
		"CHAT_MSG_MONSTER_YELL",
		"CHAT_MSG_OFFICER",
		"CHAT_MSG_PARTY",
		"CHAT_MSG_RAID",
		"CHAT_MSG_SAY",
		"CHAT_MSG_SKILL",
		"CHAT_MSG_SPELL_AURA_GONE_OTHER",
		"CHAT_MSG_SPELL_AURA_GONE_SELF",
		"CHAT_MSG_SPELL_BREAK_AURA",
		"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE",
		"CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF",
		"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
		"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS",
		"CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF",
		"CHAT_MSG_SPELL_FAILED_LOCALPLAYER",
		"CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF",
		"CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
		"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_ITEM_ENCHANTMENTS",
		"CHAT_MSG_SPELL_PARTY_BUFF",
		"CHAT_MSG_SPELL_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE",
		"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",
		"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
		"CHAT_MSG_SPELL_PET_BUFF",
		"CHAT_MSG_SPELL_PET_DAMAGE",
		"CHAT_MSG_SPELL_SELF_BUFF",
		"CHAT_MSG_SPELL_SELF_DAMAGE",
		"CHAT_MSG_SPELL_TRADESKILLS",
		"CHAT_MSG_SYSTEM",
		"CHAT_MSG_TEXT_EMOTE",
		"CHAT_MSG_WHISPER",
		"CHAT_MSG_WHISPER_INFORM",
		"CHAT_MSG_YELL",
		"CINEMATIC_START",
		"CINEMATIC_STOP",
		"CLEAR_TOOLTIP",
		"CLOSE_INBOX_ITEM",
		"CLOSE_TABARD_FRAME",
		"CLOSE_WORLD_MAP",
		"CONFIRM_BINDER",
		"CONFIRM_LOOT_ROLL",
		"CONFIRM_PET_UNLEARN",
		"CONFIRM_SUMMON",
		"CONFIRM_TALENT_WIPE",
		"CONFIRM_XP_LOSS",
		"CORPSE_IN_INSTANCE",
		"CORPSE_IN_RANGE",
		"CORPSE_OUT_OF_RANGE",
		"CRAFT_CLOSE",
		"CRAFT_SHOW",
		"CRAFT_UPDATE",
		"CURRENT_SPELL_CAST_CHANGED",
		"CURSOR_UPDATE",
		"CVAR_UPDATE",
		"DELETE_ITEM_CONFIRM",
		"DISPLAY_SIZE_CHANGED",
		"DUEL_FINISHED",
		"DUEL_INBOUNDS",
		"DUEL_OUTOFBOUNDS",
		"DUEL_REQUESTED",
		"EQUIP_BIND_CONFIRM",
		"EXECUTE_CHAT_LINE",
		"FRIENDLIST_SHOW",
		"FRIENDLIST_UPDATE",
		"GOSSIP_CLOSED",
		"GOSSIP_ENTER_CODE",
		"GOSSIP_SHOW",
		"GUILD_INVITE_CANCEL",
		"GUILD_INVITE_REQUEST",
		"GUILD_MOTD",
		"GUILD_REGISTRAR_CLOSED",
		"GUILD_REGISTRAR_SHOW",
		"GUILD_ROSTER_SHOW",
		"GUILD_ROSTER_UPDATE",
		"IGNORELIST_UPDATE",
		"IGR_BILLING_NAG_DIALOG",
		"INSTANCE_BOOT_START",
		"INSTANCE_BOOT_STOP",
		"ITEM_LOCK_CHANGED",
		"ITEM_PUSH",
		"ITEM_TEXT_BEGIN",
		"ITEM_TEXT_CLOSED",
		"ITEM_TEXT_READY",
		"ITEM_TEXT_TRANSLATION",
		"LANGUAGE_LIST_CHANGED",
		"LEARNED_SPELL_IN_TAB",
		"LOCALPLAYER_PET_RENAMED",
		"LOGOUT_CANCEL",
		"LOOT_BIND_CONFIRM",
		"LOOT_CLOSED",
		"LOOT_OPENED",
		"LOOT_SLOT_CLEARED",
		"MAIL_CLOSED",
		"MAIL_FAILED",
		"MAIL_INBOX_UPDATE",
		"MAIL_SEND_INFO_UPDATE",
		"MAIL_SEND_SUCCESS",
		"MAIL_SHOW",
		"MEETINGSTONE_CHANGED",
		"MEMORY_EXHAUSTED",
		"MEMORY_RECOVERED",
		"MERCHANT_CLOSED",
		"MERCHANT_SHOW",
		"MERCHANT_UPDATE",
		"MINIMAP_PING",
		"MINIMAP_UPDATE_ZOOM",
		"MINIMAP_ZONE_CHANGED",
		"MIRROR_TIMER_PAUSE",
		"MIRROR_TIMER_START",
		"MIRROR_TIMER_STOP",
		"NEW_AUCTION_UPDATE",
		"OPEN_MASTER_LOOT_LIST",
		"OPEN_TABARD_FRAME",
		"PARTY_INVITE_CANCEL",
		"PARTY_INVITE_REQUEST",
		"PARTY_LEADER_CHANGED",
		"PARTY_LOOT_METHOD_CHANGED",
		"PARTY_MEMBERS_CHANGED",
		"PARTY_MEMBER_DISABLE",
		"PARTY_MEMBER_ENABLE",
		"PETITION_CLOSED",
		"PETITION_SHOW",
		"PET_ATTACK_START",
		"PET_ATTACK_STOP",
		"PET_BAR_HIDEGRID",
		"PET_BAR_SHOWGRID",
		"PET_BAR_UPDATE",
		"PET_BAR_UPDATE_COOLDOWN",
		"PET_STABLE_CLOSED",
		"PET_STABLE_SHOW",
		"PET_STABLE_UPDATE",
		"PET_STABLE_UPDATE_PAPERDOLL",
		"PET_UI_CLOSE",
		"PET_UI_UPDATE",
		"PLAYERBANKBAGSLOTS_CHANGED",
		"PLAYERBANKSLOTS_CHANGED",
		"PLAYER_ALIVE",
		"PLAYER_AURAS_CHANGED",
		"PLAYER_CAMPING",
		"PLAYER_COMBO_POINTS",
		"PLAYER_CONTROL_GAINED",
		"PLAYER_CONTROL_LOST",
		"PLAYER_DAMAGE_DONE_MODS",
		"PLAYER_DEAD",
		"PLAYER_FARSIGHT_FOCUS_CHANGED",
		"PLAYER_ENTER_COMBAT",
		"PLAYER_FLAGS_CHANGED",
		"PLAYER_GUILD_UPDATE",
		"PLAYER_LEAVE_COMBAT",
		"PLAYER_LEVEL_UP",
		"PLAYER_LOGIN",
		"PLAYER_LOGOUT",
		"PLAYER_MONEY",
		"PLAYER_PET_CHANGED",
		"PLAYER_PVP_KILLS_CHANGED",
		"PLAYER_PVP_RANK_CHANGED",
		"PLAYER_PVPLEVEL_CHANGED",
		"PLAYER_QUITING",
		"PLAYER_REGEN_DISABLED",
		"PLAYER_REGEN_ENABLED",
		"PLAYER_SKINNED",
		"PLAYER_TARGET_CHANGED",
		"PLAYER_TRADE_MONEY",
		"PLAYER_UNGHOST",
		"PLAYER_UPDATE_RESTING",
		"PLAYER_XP_UPDATE",
		"PLAYTIME_CHANGED",
		"QUEST_ACCEPT_CONFIRM",
		"QUEST_COMPLETE",
		"QUEST_DETAIL",
		"QUEST_FINISHED",
		"QUEST_GREETING",
		"QUEST_ITEM_UPDATE",
		"QUEST_LOG_UPDATE",
		"QUEST_PROGRESS",
		"RAID_ROSTER_UPDATE",
		"REPLACE_ENCHANT",
		"RESURRECT_REQUEST",
		"SCREENSHOT_FAILED",
		"SCREENSHOT_SUCCEEDED",
		"SELECT_FIRST_CHARACTER",
		"SELECT_LAST_CHARACTER",
		"SEND_MAIL_COD_CHANGED",
		"SEND_MAIL_MONEY_CHANGED",
		"SHOW_COMPARE_TOOLTIP",
		"SKILL_LINES_CHANGED",
		"SPELLCAST_CHANNEL_START",
		"SPELLCAST_CHANNEL_UPDATE",
		"SPELLCAST_DELAYED",
		"SPELLCAST_FAILED",
		"SPELLCAST_INTERRUPTED",
		"SPELLCAST_START",
		"SPELLCAST_STOP",
		"SPELLS_CHANGED",
		"SPELL_UPDATE_COOLDOWN",
		"SPELL_UPDATE_USABLE",
		"START_AUTOREPEAT_SPELL",
		"START_LOOT_ROLL",
		"STOP_AUTOREPEAT_SPELL",
		"SUGGEST_REALM",
		"SYSMSG",
		"TABARD_CANSAVE_CHANGED",
		"TABARD_SAVE_PENDING",
		"TAXIMAP_CLOSED",
		"TAXIMAP_OPENED",
		"TIME_PLAYED_MSG",
		"TOOLTIP_ADD_MONEY",
		"TOOLTIP_ANCHOR_DEFAULT",
		"TRADE_ACCEPT_UPDATE",
		"TRADE_CLOSED",
		"TRADE_MONEY_CHANGED",
		"TRADE_PLAYER_ITEM_CHANGED",
		"TRADE_REPLACE_ENCHANT",
		"TRADE_REQUEST",
		"TRADE_REQUEST_CANCEL",
		"TRADE_SHOW",
		"TRADE_SKILL_CLOSE",
		"TRADE_SKILL_SHOW",
		"TRADE_SKILL_UPDATE",
		"TRADE_TARGET_ITEM_CHANGED",
		"TRADE_UPDATE",
		"TRAINER_CLOSED",
		"TRAINER_SHOW",
		"TRAINER_UPDATE",
		"TUTORIAL_TRIGGER",
		"UI_ERROR_MESSAGE",
		"UI_INFO_MESSAGE",
		"UNIT_ATTACK",
		"UNIT_ATTACK_POWER",
		"UNIT_ATTACK_SPEED",
		"UNIT_AURA",
		"UNIT_AURASTATE",
		"UNIT_CLASSIFICATION_CHANGED",
		"UNIT_COMBAT",
		"UNIT_COMBO_POINTS",
		"UNIT_DAMAGE",
		"UNIT_DEFENSE",
		"UNIT_DISPLAYPOWER",
		"UNIT_DYNAMIC_FLAGS",
		"UNIT_ENERGY",
		"UNIT_FACTION",
		"UNIT_FLAGS",
		"UNIT_FOCUS",
		"UNIT_HAPPINESS",
		"UNIT_HEALTH",
		"UNIT_INVENTORY_CHANGED",
		"UNIT_LEVEL",
		"UNIT_LOYALTY",
		"UNIT_MANA",
		"UNIT_MAXENERGY",
		"UNIT_MAXFOCUS",
		"UNIT_MAXHAPPINESS",
		"UNIT_MAXHEALTH",
		"UNIT_MAXMANA",
		"UNIT_MAXRAGE",
		"UNIT_MODEL_CHANGED",
		"UNIT_NAME_UPDATE",
		"UNIT_PET",
		"UNIT_PET_EXPERIENCE",
		"UNIT_PET_TRAINING_POINTS",
		"UNIT_PORTRAIT_UPDATE",
		"UNIT_PVP_UPDATE",
		"UNIT_QUEST_LOG_CHANGED",
		"UNIT_RAGE",
		"UNIT_RANGEDDAMAGE",
		"UNIT_RANGED_ATTACK_POWER",
		"UNIT_RESISTANCES",
		"UNIT_SPELLMISS",
		"UNIT_STATS",
		"UPDATE_BATTLEFIELD_SCORE",
		"UPDATE_BATTLEFIELD_STATUS",
		"UPDATE_BINDINGS",
		"UPDATE_BONUS_ACTIONBAR",
		"UPDATE_CHAT_COLOR",
		"UPDATE_CHAT_WINDOWS",
		"UPDATE_EXHAUSTION",
		"UPDATE_FACTION",
		"UPDATE_GM_STATUS",
		"UPDATE_INVENTORY_ALERTS",
		"UPDATE_MACROS",
		"UPDATE_MASTER_LOOT_LIST",
		"UPDATE_MOUSEOVER_UNIT",
		"UPDATE_PENDING_MAIL",
		"UPDATE_SELECTED_CHARACTER",
		"UPDATE_SHAPESHIFT_FORMS",
		"UPDATE_TICKET",
		"UPDATE_TRADESKILL_RECAST",
		"UPDATE_WORLD_STATES",
		"USE_BIND_CONFIRM",
		"VARIABLES_LOADED",
		"WHO_LIST_UPDATE",
		"WORLD_MAP_NAME_UPDATE",
		"WORLD_MAP_UPDATE",
		"ZONE_CHANGED",
		"ZONE_CHANGED_INDOORS",
		"ZONE_CHANGED_NEW_AREA",
		"ZONE_UNDER_ATTACK",
	}
end
