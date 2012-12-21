--
-- MI2_Events.lua
--
-- Handlers for all WoW events that MobInfo subscribes to. This includes
-- the main MobInfo OnEvent handler called "MI2_OnEvent()". Event handling
-- is based on a global table of event handlers called "MI2_EventHandlers[]".
-- For each event that MobInfo supports the corresponding handler function
-- is available in the table.
--
-- (this is code restructering work in progress, it has not yet been completed ... )
--


-- global variable holding all current target data for entire MobInfo2 AddOn
MI2_Target = {}
MI2_LastTargetIdx = nil
MI2_CurContinent = 0
MI2_CurZone = 0

-- miscellaneous other event related global vairables 
MI2_IsNonMobLoot = nil

-- local table holding all event handler functions
local MI2_EventHandlers = { }
local MI2_GT_OnShow_Orig
local MI2_Scan_SelfBuff


-----------------------------------------------------------------------------
-- MI2_CheckForSeparateMobHealth()
--
-- Detect the presence of separate MobHelath AddOns and disable the internal
-- MobHealth functionality if found
-----------------------------------------------------------------------------
local function MI2_CheckForSeparateMobHealth()
	if  MobHealth_OnLoad  then
		if  MobInfoConfig.DisableHealth ~= 2  then
			MobInfoConfig.DisableHealth = 2
			UIErrorsFrame:AddMessage( MI_TXT_MH_DISABLED, 0.0, 1.0, 1.0, 1.0, 20 )
		end
		MI2_MobHealthFrame:Hide()
	else
		if  MobInfoConfig.DisableHealth ~= 0  then
			MobInfoConfig.DisableHealth = 0
		end
	end
end  -- MI2_CheckForSeparateMobHealth


-----------------------------------------------------------------------------
-- MI2_MobInfo_Initialize()
--
-- main global initialization function, this is called as the handler
-- for the "VARIABLES_LOADED" event
-----------------------------------------------------------------------------
local function MI2_MobInfo_Initialize()

	-- initialize "MobInfoConfig" data structure (main MobInfo config options)
	MI2_InitOptions()

	-- register with all AddOn managers that MobInfo attempts to support
	-- currently that is: myAddons, KHAOS (mainly for Cosmos), EARTH (originally for Cosmos)
	MI2_RegisterWithAddonManagers()

	-- check for presence of separate interferring MobHealth AddOn
	-- initialize built-in MobHealth if not disabled
	MI2_CheckForSeparateMobHealth()
	if  MobInfoConfig.DisableHealth < 2  then
		MI2_MobHealth_SetPos()
	end

	-- ensure that MobHealthFrame get set correctly (if we have to set it for compatibility)
	if  MobHealthFrame == "MI2"  then
		MobHealthFrame = MI2_MobHealthFrame
	end

	-- setup a confirmation dialog for critical configuration options
	StaticPopupDialogs["MOBINFO_CONFIRMATION"] = {
		button1 = TEXT(OKAY),
		button2 = TEXT(CANCEL),
		showAlert = 1,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		interruptCinematic = 1
	}

	-- cleanup for all databases
	MI2_CleanupDatabases()

	-- obtain player name and realm name
	local charName = GetCVar( "realmName" )..':'..UnitName("player")
	if not MI2_CharTable[charName] then
		MI2_CharTable.charCount = MI2_CharTable.charCount + 1
		MI2_CharTable[charName] = "c"..MI2_CharTable.charCount
	end
	MI2_PlayerName = MI2_CharTable[charName]

	-- load the MobInfo item sell price table
	MI2_BuildSellPriceTable()
	-- setup event handling for the entire AddOn (MobInfo and MobHealth)
	MI2_UpdateMobInfoState()
	-- initialize slash commands processing
	MI2_SlashInit()
	-- build cross reference table for fast item tooltips
	MI2_BuildXRefItemTable()


	-- hook into OnShow for game tooltip
	MI2_GT_OnShow_Orig = GameTooltip:GetScript("OnShow")
	GameTooltip:SetScript( "OnShow", MI2_GameTooltip_OnShow )

	-- from this point onward process events
	MI2_InitializeEventTable()

	if not (myAddOnsFrame_Register or EarthFeature_AddButton or Khaos) then
		chattext("MobInfo-2  v"..miVersionNo.."  Loaded,  "..mifontGreen.."enter /mi2 or /mobinfo2 for help")
	end
end -- MI2_MobInfo_Initialize()


-----------------------------------------------------------------------------
-- MI2_EventSelfBuff()
--
-- event handler for the WoW "CHAT_MSG_SPELL_SELF_BUFF" event
-- This event is called for lots of miscellaneous reasons. The reason I
-- subscribe to it is to detect the opening of chest loot or collecting
-- loot (chests, barrels, mining, herbs)
-----------------------------------------------------------------------------
local function MI2_EventSelfBuff()
	if MI2_Debug > 0 then chattext("M2DBG: event="..event..", a1="..(arg1 or "<nil>")..", a2="..(arg2 or "<nil>") ) end
	local s,e, lootAction, lootType = string.find( arg1, MI2_Scan_SelfBuff )

	-- set global flag that a non Mob loot window is being opened
	if lootAction and lootType then
		MI2_IsNonMobLoot = true
	end
end -- MI2_EventSelfBuff()


-----------------------------------------------------------------------------
-- MI2_EventUnitCombat()
--
-- Event handler for the "UNIT_COMBAT" event. This handler will
-- accumulate all damage done to the current target, and will record all
-- damage done to the player by the current target.
-----------------------------------------------------------------------------
local function MI2_EventUnitCombat()
	if arg1 == "target" then
		if MI2_Target.index then
			if arg2 ~= "HEAL" and arg4 > 0 then
				MI2_Target.tempDamage = MI2_Target.tempDamage + arg4
			end
		end
	elseif arg1 == "player" then
		if arg3 ~= "CRITICAL" and MI2_Target.mobIndex then -- observed: MI2_Target can be NIL
			MI2_RecordDamage( MI2_Target.mobIndex, tonumber(arg4) )
		end
	end
end  -- MI2_EventUnitCombat()


-----------------------------------------------------------------------------
-- MI2_EventUnitHealth()
--
-- Event handler for the "UNIT_HEALTH" event. This handler will
-- process health number that WoW gives us for the current target. Combining
-- the health value with the damage done to the current target and with the
-- current health percentage of the target allows us to calculate the PPP
-- value (Point Per Percent) for the current target. The PPP value can then
-- be used to calculate a health value from a given health percentage.
--
-- new feature : overkill protection : skip damage values that are
-- higher then remaining health
--
-- if health value has changed update game tooltip
-----------------------------------------------------------------------------
local function MI2_EventUnitHealth()
	local healthUpdated = false

	if arg1 == "target" then
		local health = UnitHealth("target")
		MI2_Target.unitHealth = health

		if health > 0 and MI2_Target.index then
			-- calculate and sum up change in health percentage, skip negative changes (ie. target heals)
			local change = MI2_Target.lastPercent - health
			if change > 0 and MI2_Target.tempDamage > 0 then
				MI2_Target.totalDamage = MI2_Target.totalDamage + MI2_Target.tempDamage
				MI2_Target.totalPercent = MI2_Target.totalPercent + change
				MI2_Target.lastPercent = health
				MI2_Target.tempDamage = 0
			elseif change < 0 then
				MI2_Target.lastPercent = health
				MI2_Target.tempDamage = 0
			end
			-- update DB immediately for new Mobs to support other AddOns
			if MI2_Target.totalPercent < 90 then
				MI2_SaveTargetHealthData() 
			end
			healthUpdated = true
			if MI2_Debug > 1 then chattext("M2DBG: UNIT_HEALTH: chng="..change..", h="..health..", HP="..MI2_Target.curHealth.."/"..MI2_Target.maxHealth..", totHP="..MI2_Target.totalDamage..", totP="..MI2_Target.totalPercent ) end
		end

		-- recalculate current health and update health display
		MI2_CalculateHealth( MobInfoConfig.StableMax == 0 or MI2_Target.totalPercent < 90 )
		MobHealth_Display( )
	end

	-- update health and mana shown in MobInfo tooltip
	if GameTooltip:IsShown() then
		MI2_UpdateTooltipHealthMana( MI2_Target.curHealth, MI2_Target.maxHealth )
	end
end -- MI2_EventUnitHealth()


-----------------------------------------------------------------------------
-- MI2_EventUnitMana()
--
-- Event handler for the "UNIT_MANA" event.
-- This handler will
-----------------------------------------------------------------------------
local function MI2_EventUnitMana()
	if arg1 == "target" then
		-- recalculate current health and update health display
		MI2_Target.unitHealth = UnitHealth("target")
		MI2_CalculateHealth()
		MobHealth_Display( )
	end

	-- update health and mana shown in MobInfo tooltip
	if GameTooltip:IsShown() then
		MI2_UpdateTooltipHealthMana()
	end
end -- MI2_EventUnitMana()


-----------------------------------------------------------------------------
-- MI2_OnTargetChanged()
--
-- Event handler for the "PLAYER_TARGET_CHANGED" event. This handler will
-- fill the global variable "MI2_Target" with all the data that MobInfo2
-- needs to know about the current target.
-----------------------------------------------------------------------------
local function MI2_OnTargetChanged()
	local name = UnitName("target")
	local level = UnitLevel("target")
	local maxHealth = UnitHealthMax("target")

	-- process table monitoring current targets
	MI2_ProcessTargetTable()
	MI2_IsNonMobLoot = false -- to reset non Mob loot detection

	-- previous target post processing: update targets HP in database,
	-- remember last targets mob index, update DPS if recorded
	if  MI2_Target.mobIndex then
		MI2_SaveTargetHealthData()
		MI2_LastTargetIdx = MI2_Target.mobIndex
		if MI2_Target.FightStartTime then
			MI2_RecordDps( MI2_Target.mobIndex, MI2_Target.FightEndTime - MI2_Target.FightStartTime, MI2_Target.FightDamage )
		end
	end

	if name and level and maxHealth == 100
			and (UnitCanAttack("player","target") or UnitIsPlayer("target")) then
		MI2_Target = { name=name, level=level, tempDamage=0, maxHealth=100 }
		MI2_Target.class = UnitClass("target")
		MI2_Target.lastPercent = UnitHealth("target")

		-- set index to either player or mob and store matching health database
		if  UnitIsPlayer("target")  then
			MI2_Target.index = name
			MI2_Target.healthDB = MobHealthPlayerDB
		else
			MI2_Target.index = name..":"..level
			MI2_Target.healthDB = MobHealthDB
			MI2_Target.mobIndex = MI2_Target.index
			MI2_NewMobTarget( MI2_Target.index )
		end

		-- health calculation and health tracking initialisation
		local pts, pct = MI2_GetHealthData( MI2_Target.healthDB, MI2_Target.index )
		MI2_Target.totalDamage = pts
		MI2_Target.totalPercent = pct
	else
		MI2_Target = { totalPercent = 0, maxHealth=maxHealth }
	end

	-- update mob health display with health for new target
	MI2_Target.unitHealth = UnitHealth("target")
	MI2_CalculateHealth( true )
	MobHealth_Display()

	-- update options dialog if shown
    if  frmMIConfig:IsVisible()  then
		MI2_DbOptionsFrameOnShow()
	end

	if MI2_Debug > 0 then if MI2_Target then chattext( "M2DBG: new target: idx=["..(MI2_Target.index or "nil").."], last=["..(MI2_LastTargetIdx or "nil").."]" )
	else chattext( "M2DBG: new target: idx=[nil], last=["..(MI2_LastTargetIdx or "nil").."]" ) end end
end  -- MI2_OnTargetChanged()


-----------------------------------------------------------------------------
-- MI2_EventZoneChanged()
--
-- event handler for the WoW "CHAT_MSG_SPELL_SELF_BUFF" event
-- This event is called for lots of miscellaneous reasons. The reason I
-- subscribe to it is to detect the opening of chest loot or collecting
-- loot (chests, barrels, mining, herbs)
-----------------------------------------------------------------------------
local function MI2_EventZoneChanged()
	SetMapToCurrentZone();
	local continent = GetCurrentMapContinent()
	if continent > 0 then
		MI2_CurContinent = continent
	end
	local zone = GetCurrentMapZone()
	if zone > 0 then
		MI2_CurZone = zone
	end

	-- track globally unknown zones (ie. mainly instance names)
	local zoneName = GetZoneText()
	if zone == 0 and zoneName ~= "" then
		if not MI2_ZoneTable[zoneName] then
			MI2_ZoneTable.cnt = MI2_ZoneTable.cnt + 1
			MI2_ZoneTable[zoneName] = 100 + MI2_ZoneTable.cnt
		end
		MI2_CurZone = MI2_ZoneTable[zoneName]
		MI2_Zones[MI2_CurContinent][MI2_CurZone] = zoneName
	end
end -- MI2_EventZoneChanged()


-----------------------------------------------------------------------------
-- MI2_Player_Login()
--
-- register the GameTooltip:OnShow event at player login time. This ensures
-- that MobInfo is the (hopefully) last AddOn to hook into this event.
-----------------------------------------------------------------------------
local function MI2_Player_Login()
--	MI2_GT_OnShow_Orig = GameTooltip:GetScript("OnShow")
--	GameTooltip:SetScript( "OnShow", MI2_GameTooltip_OnShow )

	-- create list of all zones for Mob location tracking
	local continentNames = { GetMapContinents() }
	local count = 0
	MI2_Zones = { [0] = { [0]="" } }
	for idx,val in continentNames do
		count = count + 1
		MI2_Zones[count] = { GetMapZones(count) }
	end
	
	-- add instance zones stored in MI2_ZoneTable to zone table
	for idx,val in MI2_ZoneTable do
		if idx ~= "cnt" then
			MI2_Zones[0][val] = idx
			MI2_Zones[1][val] = idx
			MI2_Zones[2][val] = idx
		end
	end

	MI2_EventZoneChanged()

	-- import TipBuddy Mob location data into the MobInfo database
	MI2_ImportLocationsFromMI2B()
end -- MI2_Player_Login()


-----------------------------------------------------------------------------
-- MI2_GameTooltip_OnShow
--
-- OnShow event handler for the GameTooltip frame
-- This handler will :
--   * call the original handler which it replaces
--   * if a valid Mob is hovered display the corresponding MobInfo data
--   * if a known item is hovered add the corresponding item data
-----------------------------------------------------------------------------
function MI2_GameTooltip_OnShow( )
	MI2_HealthLine, MI2_ManaLine = nil, nil

	-- check if mobinfo tooltip extensions are enabled and check for keypress mode
	if MobInfoConfig.DisableMobInfo == 0 and (MobInfoConfig.KeypressMode == 0
			or MobInfoConfig.KeypressMode == 1 and IsAltKeyDown())  then
		local firstline = getglobal("GameTooltipTextLeft1");

		if  UnitCreatureType("mouseover") and UnitIsFriend("player","mouseover") == nil then
			-- add mob data to mob tooltip (show abbreviated location)
			MI2_BuildMobInfoTooltip( UnitName("mouseover"), UnitLevel("mouseover"), nil )
			GameTooltip:Show()
		elseif firstline and MobInfoConfig.ItemTooltip == 1 and UnitClass("mouseover") == nil then
			-- add item loot info to item tooltip
			if MI2_BuildItemDataTooltip( firstline:GetText() ) then
				GameTooltip:Show()
			end
		end
	end

	-- call original WoW event for GameTooltip:OnShow()
	if MI2_GT_OnShow_Orig then
		MI2_GT_OnShow_Orig(event)
	end
end -- MI2_GameTooltip_OnShow()


-----------------------------------------------------------------------------
-- MI2_InitializeEventTable()
--
-- Initialize the event handler table according to the current MobInfo
-- config options settings.
-----------------------------------------------------------------------------
function MI2_InitializeEventTable()
	MI2_EventHandlers = {}

	MI2_EventHandlers["VARIABLES_LOADED"] = MI2_MobInfo_Initialize
	MI2_EventHandlers["PLAYER_LOGIN"] = MI2_Player_Login
	MI2_EventHandlers["PLAYER_TARGET_CHANGED"] = MI2_OnTargetChanged
	MI2_EventHandlers["CHAT_MSG_COMBAT_XP_GAIN"] = MI2x_EventCreatureDiesXP
	MI2_EventHandlers["CHAT_MSG_COMBAT_HOSTILE_DEATH"] = MI2x_CreatureDiesHostile
	MI2_EventHandlers["CHAT_MSG_SPELL_SELF_BUFF"] = MI2_EventSelfBuff -- for treasure/collect loot detection
	MI2_EventHandlers["LOOT_OPENED"] = MI2_EventLootOpened
	MI2_EventHandlers["LOOT_CLOSED"] = MI2_EventLootClosed
	MI2_EventHandlers["LOOT_SLOT_CLEARED"] = MI2_EventLootSlotCleared
	MI2_EventHandlers["UNIT_COMBAT"] = MI2_EventUnitCombat
	MI2_EventHandlers["UNIT_HEALTH"] = MI2_EventUnitHealth
	MI2_EventHandlers["UNIT_MANA"] = MI2_EventUnitMana
	MI2_EventHandlers["ZONE_CHANGED_NEW_AREA"] = MI2_EventZoneChanged
	MI2_EventHandlers["ZONE_CHANGED_INDOORS"] = MI2_EventZoneChanged

	-- DPS events only needed when char data recording is enabled		
	if MobInfoConfig.SaveCharData == 1 then
		MI2_EventHandlers["CHAT_MSG_COMBAT_SELF_HITS"] = MI2_EventSelfMelee
		MI2_EventHandlers["CHAT_MSG_SPELL_SELF_DAMAGE"] = MI2_EventSelfSpell
		MI2_EventHandlers["CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"] = MI2_EventSpellPeriodic
		MI2_EventHandlers["CHAT_MSG_COMBAT_PET_HITS"] = MI2_EventSelfPet
		MI2_EventHandlers["CHAT_MSG_SPELL_PET_DAMAGE"] = MI2_EventSelfPet
	end

	-- register event handlers for tooltip (if active)
	if MobInfoConfig.DisableMobInfo == 0 then
		if MI2_Debug > 0 then chattext( "M2DBG: UpdateMobInfoState: MobInfo enabled" ) end
	end

	-- register event handlers for MobHealth (if active)
	if MobInfoConfig.DisableHealth == 0 then
		if MI2_Debug > 0 then chattext( "M2DBG: UpdateMobInfoState: MobHealth enabled" ) end
	end
end -- MI2_InitializeEventTable()


-----------------------------------------------------------------------------
-- MI2_OnEvent()
--
-- MobInfo main event handler function, gets called for all registered events
-- uses table of event handlers which gets initialised in "OnLoad"
-----------------------------------------------------------------------------
function MI2_OnEvent( event )	
	if event then
		-- debug output section for testing/debugging
		if MI2_Debug > 2 then
			chattext("M2DBG: event="..event..", a1="..(arg1 or "<nil>")..", a2="..(arg2 or "<nil>")..", a3="..(arg3 or "<nil>")..", a4="..(arg4 or "<nil>"))
		end

		-- call event handler function for event
		if  MI2_EventHandlers[event]  then
			MI2_EventHandlers[event]()
			return 0
		else
			if MI2_Debug > 0 then
				chattext("M2DBG: unknown event="..event..", a1="..(arg1 or "<nil>")..", a2="..(arg2 or "<nil>")..", a3="..(arg3 or "<nil>")..", a4="..(arg4 or "<nil>"))
			end
		end
	end
end -- MI2_OnEvent


-----------------------------------------------------------------------------
-- MI2_OnLoad()
--
-- register all events that we want to receive and process, build table
-- of event handler functions for easy processing of events in "OnEvent"
-----------------------------------------------------------------------------
function MI2_OnLoad()
	-- register all events that we want to catch and process
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_LOGIN")
	this:RegisterEvent("PLAYER_TARGET_CHANGED")
	this:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN")
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS")
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
	this:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS")
	this:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE")
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")
	this:RegisterEvent("UNIT_COMBAT")
	this:RegisterEvent("UNIT_HEALTH")
	this:RegisterEvent("UNIT_MANA")
	this:RegisterEvent("LOOT_OPENED")
	this:RegisterEvent("LOOT_CLOSED")
	this:RegisterEvent("LOOT_SLOT_CLEARED")
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	this:RegisterEvent("ZONE_CHANGED_INDOORS")

	-- only react to VARIABLES_LOADED until event has fired
	MI2_EventHandlers = { VARIABLES_LOADED = MI2_MobInfo_Initialize }

	-- prepare for importing external database data
	MI2_PrepareForImport()

	-- create chat event scan strings from global WoW constants
	MI2_Scan_SelfBuff = string.gsub( SIMPLEPERFORMSELFOTHER, "(%%s)", "%(%.%+%)" )
	MI2_Scan_SelfBuff = string.gsub( MI2_Scan_SelfBuff, "(%%%d$s)", "%(%.%+%)")

	-- set some stuff that is needed (only) for improved compatibility
	-- to other AddOns wanting to use MobHealth info
	if  not MobHealth_OnEvent  then
		if MI2_Debug > 0 then chattext( "M2DBG: setting up compatibility variables" ) end
		MobHealthFrame = "MI2"
		MobHealth_OnEvent = MI2_OnEvent
	end

	if MI2_Debug > 0 then chattext( "M2DBG: MobInfo_OnLoad: all events registered" ) end
end -- MI2_OnLoad()
