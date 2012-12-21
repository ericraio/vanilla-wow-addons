--
-- MI2_Slash.lua
--
-- Handle all slash commands and the actions performed by slash commands.
-- All option dialog settings use slash commands for performing their
-- actions.
--

miVersionNo = ' 2.97'

miVersion = mifontYellow..'MobInfo-2 Version '..miVersionNo..mifontGreen..' http://www.dizzarian.com/forums/viewforum.php?f=16'
miPatchNotes = mifontYellow..
  'MobInfo-2 Version '..miVersionNo..'\n'..
  '  ver 2.97\n'..
  '    - updated to comply with newest WoW version 1.11\n'..
  '    - show items on search options page in correct item color\n'..
  '    - search options page again shows result list size\n'..
  '    - fixed bug in search for Mobs that drop a certain item\n\n'..
  '  ver 2.96\n'..
  '    - new feature: store health value obtained through Beast Lore in health database\n'..
  '    - new feature: added chinese translation submitted by Andyca Chiou\n'..
  '    - fixed nil error for items with legendary and artifact rarity\n\n'..
  '  ver 2.95\n'..
  '    - bugfix release : fixes wrong max health display\n\n'..
  '  ver 2.94\n'..
  '    - huge update of MobInfo vendor sell price table (over 1000 new prices)\n'..
  '    - DropRate conversion now supports LootLink databases\n'..
  '    - fixed: DropRate conversion nil bug "Mobinfo2.lua Line: 383"\n'..
  '    - fixed bug where health was displayed wrong after using "BeastLore" on Mob\n\n'..
  '  ver 2.93\n'..
  '    - new feature: implemented DropRate database converter from NakorNH\n'..
  '    - bugfix: correctly import locations for mobs in instances\n'..
  '    - added new items (loot from Silithus) to MobInfo item price table\n'..
  '    - several new skinning loot items added to skinning loot detection table\n\n'..
  '  ver 2.92\n'..
  '    - new feature: you can choose to import only unknown (ie. new) Mobs\n'..
  '    - improved item colors in Mob tooltip for better readability\n'..
  '    - fixed all health/mana updating issues for unit frame and tooltip\n'..
  '    - fixed max health not increasing correctly for group member targets\n\n'..
  '  ver 2.91\n'..
  '    - new feature: importing of externally supplied MobInfo databases\n'..
  '    - new feature: option to delete all Mobs shown in search result\n'..
  '    - added Turtle Scales to skinning loot detection table\n'..
  '    - show all "green hills of Strangle" pages on one tooltip line\n'..
  '    - item list on search page: show all items if item name field is empty\n'..
  '    - fixed: mob name search errors on special chars\n'..
  '    - fixed: correct independant show/hide of basic loot items\n\n'..
  '  ver 2.90\n'..
  '    - added separate tooltip option for cloth and skinning loot\n'..
  '    - show drop percentages for items in Mob tooltip\n'..
  '    - calculate skinning loot percantage based on skinned counter\n'..
  '    - rearranged tooltips options page\n'..
  '    - new skinning loot support for Shiny Fish Scales and Red Whelp Scales\n\n'..
  '  For all previous patch notes and to report bugs please visit http://www.dizzarian.com/forums/viewforum.php?f=16'


local MI2_DeleteMode = ""


-- Configs
function MI2_SlashAction_Default()
	MobInfoConfig.ShowClass = 1
	MobInfoConfig.ShowHealth = 1
    MobInfoConfig.ShowMana = 0
	MobInfoConfig.ShowDamage = 1
	MobInfoConfig.ShowKills = 0
	MobInfoConfig.ShowLoots = 1
	MobInfoConfig.ShowEmpty = 0
	MobInfoConfig.ShowXp = 1
	MobInfoConfig.ShowNo2lev = 1
	MobInfoConfig.ShowQuality = 1
	MobInfoConfig.ShowCloth = 1
	MobInfoConfig.ShowCoin = 0
	MobInfoConfig.ShowIV = 0
	MobInfoConfig.ShowTotal = 1
	MobInfoConfig.ShowCombined = 0
	MobInfoConfig.ShowItems = 1
	MobInfoConfig.ShowLocation = 1
	MobInfoConfig.ShowClothSkin = 1
end

function MI2_SlashAction_AllOn()
    MobInfoConfig.ShowClass = 1
    MobInfoConfig.ShowHealth = 1
    MobInfoConfig.ShowMana = 1
    MobInfoConfig.ShowKills = 1
    MobInfoConfig.ShowDamage = 1
    MobInfoConfig.ShowXp = 1
    MobInfoConfig.ShowNo2lev = 1
    MobInfoConfig.ShowLoots = 1
    MobInfoConfig.ShowEmpty = 1
    MobInfoConfig.ShowCoin = 1
    MobInfoConfig.ShowIV = 1
    MobInfoConfig.ShowTotal = 1
    MobInfoConfig.ShowQuality = 1
    MobInfoConfig.ShowCloth = 1
    MobInfoConfig.ShowCombined = 1
    MobInfoConfig.ShowItems = 1
	MobInfoConfig.ShowLocation = 1
	MobInfoConfig.ShowClothSkin = 1
end

function MI2_SlashAction_AllOff()
    MobInfoConfig.ShowClass = 0
    MobInfoConfig.ShowHealth = 0
    MobInfoConfig.ShowMana = 0
    MobInfoConfig.ShowKills = 0
    MobInfoConfig.ShowDamage = 0
    MobInfoConfig.ShowXp = 0
    MobInfoConfig.ShowNo2lev = 0
    MobInfoConfig.ShowLoots = 0
    MobInfoConfig.ShowEmpty = 0
    MobInfoConfig.ShowCoin = 0
    MobInfoConfig.ShowIV = 0
    MobInfoConfig.ShowTotal = 0
    MobInfoConfig.ShowQuality = 0
    MobInfoConfig.ShowCloth = 0
    MobInfoConfig.ShowCombined = 0
    MobInfoConfig.ShowItems = 0
	MobInfoConfig.ShowLocation = 0
	MobInfoConfig.ShowClothSkin = 0
end

function MI2_SlashAction_Minimal()
    MobInfoConfig.ShowClass = 1
    MobInfoConfig.ShowHealth = 1
    MobInfoConfig.ShowMana = 0
    MobInfoConfig.ShowKills = 0
    MobInfoConfig.ShowDamage = 0
    MobInfoConfig.ShowXp = 0
    MobInfoConfig.ShowNo2lev = 1
    MobInfoConfig.ShowLoots = 0
    MobInfoConfig.ShowEmpty = 0
    MobInfoConfig.ShowCoin = 0
    MobInfoConfig.ShowIV = 0
    MobInfoConfig.ShowTotal = 1
    MobInfoConfig.ShowQuality = 0
    MobInfoConfig.ShowCloth = 0
    MobInfoConfig.ShowCombined = 0
    MobInfoConfig.ShowItems = 0
	MobInfoConfig.ShowLocation = 0
	MobInfoConfig.ShowClothSkin = 0
end


-----------------------------------------------------------------------------
-- MI2_RegisterWithAddonManagers()
--
-- Register MobInfo with the KHAOS AddOn manager. This is a very simple
-- registration that merely creates a button to open the MobInfo options
-- dialog.
--
-- Register MobInfo with the myAddons manager.
--
-- Register with the EARTH AddOn manager.
-----------------------------------------------------------------------------
function MI2_RegisterWithAddonManagers()

	-- register with myAddons manager
	if ( myAddOnsFrame_Register ) then
		local mobInfo2Details = {
		name = "MobInfo2",
		version = miVersionNo,
		author = "Skeeve & Dizzarian",
		website = "http://www.dizzarian.com/forums/viewforum.php?f=16",
		category = MYADDONS_CATEGORY_OTHERS,
		optionsframe = "frmMIConfig"
		}
		myAddOnsFrame_Register( mobInfo2Details )
	end

	-- register with EARTH manager (mainly for Cosmos support)
	if EarthFeature_AddButton then
		EarthFeature_AddButton(
			{
				id = "MobInfo2",
				name = "MobInfo2",
				subtext = "v"..miVersionNo,
				tooltip = MI_DESCRIPTION,
				icon = "Interface\\AddOns\\MobInfo2\\MobInfoIcon",
				callback = function(state) MI2_SlashParse( "", false ) end,
				test = nil
			}
		)
	
	-- register with KHAOS (only if EARTH not found)
	elseif Khaos then
		Khaos.registerOptionSet(
			"tooltip",
			{
				id = "MobInfo2OptionSet",
				text = "MobInfo 2",
				helptext = MI_DESCRIPTION,
				difficulty = 1,
				callback = function(state) end,
				default = true,
				options = {
					{
						id = "MobInfo2OptionsHeader",
						type = K_HEADER,
						difficulty = 1,
						text = MI_TXT_WELCOME,
						helptext = MI_DESCRIPTION
					},
					{
						id = "MobInfo2OptionsButton",
						type = K_BUTTON,
						difficulty = 1,
						text = MI_TXT_CONFIG_TITLE,
						helptext = "",
						callback = function(state) MI2_SlashParse( "", false ) end,
						feedback = function(state) end,
						setup = { buttonText = MI_TXT_OPEN }
					}
				}
			}
		)
	end
end  -- MI2_RegisterWithAddonManagers()


-----------------------------------------------------------------------------
-- MI2_SlashAction_ClearTarget()
--
-- Clear MobInfo and MobHealth data for current target.
-----------------------------------------------------------------------------
function MI2_SlashAction_ClearTarget()
	local index = MI2_Target.mobIndex
	if index then
		MI2_MobHealth_ClearTargetData()
		MI2_DeleteMobData( index )
		MI2_DbOptionsFrameOnShow()
		ClearTarget()
		chattext( "data for "..mifontGreen..index..mifontWhite.." has been cleared" )
	end
end  -- MI2_SlashAction_ClearTarget()


-----------------------------------------------------------------------------
-- MI2_Slash_ClearAllConfirmed()
--
-- Clear-All-Confirmation-Handler : Clear entire contents of MobInfo and
-- MobHealth databases.
-----------------------------------------------------------------------------
function MI2_Slash_ClearAllConfirmed()

	if MI2_DeleteMode == "MobDb" then
		MobInfoDB = {}
		MI2_ItemNameTable = {}
		MobInfoDB["DatabaseVersion:0"] = { ver = MI2_DB_VERSION }
		MI2_CharTable = {}
		MI2_CharTable.charCount = 0
	elseif MI2_DeleteMode == "HealthDb" then
		MI2_MobHealth_Reset()
	elseif MI2_DeleteMode == "PlayerDb" then
		MobHealthPlayerDB = {}
	end
	chattext( "<MobInfo> database deleted" )
	MI2_DbOptionsFrameOnShow()
end  -- MI2_Slash_ClearAllConfirmed()


-----------------------------------------------------------------------------
-- MI2_SlashAction_ClearHealthDb()
--
-- Clear entire contents of MobInfo and MobHealth databases.
-- Ask for confirmation before performing the clear operation.
-----------------------------------------------------------------------------
function MI2_SlashAction_ClearHealthDb()
	StaticPopupDialogs["MOBINFO_CONFIRMATION"].text = MI_TXT_CLR_ALL_CONFIRM.."'"..MI2_OPTIONS[this:GetName()].help.."' ?"
	StaticPopupDialogs["MOBINFO_CONFIRMATION"].OnAccept = MI2_Slash_ClearAllConfirmed
	MI2_DeleteMode = "HealthDb"
	local dialog = StaticPopup_Show( "MOBINFO_CONFIRMATION", "")
end  -- MI2_SlashAction_ClearHealthDb()


-----------------------------------------------------------------------------
-- MI2_SlashAction_ClearPlayerDb()
--
-- Clear entire contents of MobInfo and MobHealth databases.
-- Ask for confirmation before performing the clear operation.
-----------------------------------------------------------------------------
function MI2_SlashAction_ClearPlayerDb()
	StaticPopupDialogs["MOBINFO_CONFIRMATION"].text = MI_TXT_CLR_ALL_CONFIRM.."'"..MI2_OPTIONS[this:GetName()].help.."' ?"
	StaticPopupDialogs["MOBINFO_CONFIRMATION"].OnAccept = MI2_Slash_ClearAllConfirmed
	MI2_DeleteMode = "PlayerDb"
	local dialog = StaticPopup_Show( "MOBINFO_CONFIRMATION", "")
end  -- MI2_SlashAction_ClearPlayerDb()


-----------------------------------------------------------------------------
-- MI2_SlashAction_ClearMobDb()
--
-- Clear entire contents of MobInfo and MobHealth databases.
-- Ask for confirmation before performing the clear operation.
-----------------------------------------------------------------------------
function MI2_SlashAction_ClearMobDb()
	StaticPopupDialogs["MOBINFO_CONFIRMATION"].text = MI_TXT_CLR_ALL_CONFIRM.."'"..MI2_OPTIONS[this:GetName()].help.."' ?"
	StaticPopupDialogs["MOBINFO_CONFIRMATION"].OnAccept = MI2_Slash_ClearAllConfirmed
	MI2_DeleteMode = "MobDb"
	local dialog = StaticPopup_Show( "MOBINFO_CONFIRMATION", "")
end  -- MI2_SlashAction_ClearMobDb()


-----------------------------------------------------------------------------
-- MI2_Slash_TrimDownConfirmed()
--
-- Trim down the contents of the mob info database by removing all data
-- that is not set as being recorded. This function is called when the
-- user confirms the delete confirmation.
-----------------------------------------------------------------------------
function MI2_Slash_TrimDownConfirmed()
	MobInfoDB["DatabaseVersion:0"] = nil

	-- loop through database and check each record
	-- remove all fields within the record where recording of the field is disabled
	for idx, mobInfo in MobInfoDB do
		if  MobInfoConfig.SaveBasicInfo == 0 then
			mobInfo.bi = nil
		end
		if  MobInfoConfig.SaveQualityData == 0 then
			mobInfo.qi = nil
		end
		if  MobInfoConfig.SaveLocation == 0 then
			mobInfo.ml = nil
		end
		if  MobInfoConfig.SaveItems == 0 then
			mobInfo.il = nil
		end
		if  MobInfoConfig.SaveCharData == 0 then
			MI2_RemoveCharData( mobInfo )
		end
	end

	if  MobInfoConfig.SaveItems == 0 then
		MI2_ItemNameTable = {}
	end

	-- char table can be deleted when not saving char specific data
	if  MobInfoConfig.SaveCharData == 0 then
		MI2_CharTable = { charCount = 0 }
	end

	-- force a cleanup after trimming down
	MobInfoDB["DatabaseVersion:0"] = { ver = MI2_DB_VERSION - 1 }
	MI2_CleanupDatabases()

	MI2_DbOptionsFrameOnShow()
end -- MI2_Slash_TrimDownConfirmed()


-----------------------------------------------------------------------------
-- MI2_SlashAction_TrimDownMobData()
--
-- Trim down the contents of the mob info database by removing all data
-- that is not set as being recorded. Ask for a confirmation before
-- actually deleting anything.
-----------------------------------------------------------------------------
function MI2_SlashAction_TrimDownMobData()
	StaticPopupDialogs["MOBINFO_CONFIRMATION"].text = MI_TXT_TRIM_DOWN_CONFIRM
	StaticPopupDialogs["MOBINFO_CONFIRMATION"].OnAccept = MI2_Slash_TrimDownConfirmed
	local dialog = StaticPopup_Show( "MOBINFO_CONFIRMATION", "")
end  -- MI2_SlashAction_TrimDownMobData()


-----------------------------------------------------------------------------
-- MI2_UpdateMob()
--
-- Update a specific existing mob by adding to it the given new Mob data.
-----------------------------------------------------------------------------
local function MI2_UpdateMob( mobIndex, newMobInfo )
	local existingMobInfo = MobInfoDB[mobIndex]
	local existingMobData, newMobData = {}, {}
	MI2_GetMobDataFromMobInfo( existingMobInfo, existingMobData )
	MI2_GetMobDataFromMobInfo( newMobInfo, newMobData )
	MI2_AddTwoMobs( existingMobData, newMobData )
	MI2x_StoreMobData( existingMobData, nil, nil, MI2_PlayerName, mobIndex )
end -- MI2_UpdateMob()

-----------------------------------------------------------------------------
-- MI2_AdaptImportLocation()
--
-- Adapt the location info of an imported Mob. This is only necessary for
-- Mobs in instances, because instances are not available in the WoW
-- zone tables.
-----------------------------------------------------------------------------
local function MI2_AdaptImportLocation( mobInfo, importZoneTable )
	-- decode mob location information: only adapt mobs from instances
	local mobData = {}
	MI2_DecodeMobLocation( mobInfo, mobData )
	if not mobData.location or mobData.location.z < 100 then return end

	-- instance mob found: find the name of the instance
	local zoneId = mobData.location.z
	local zoneName = importZoneTable[zoneId]
	if not zoneName then
		-- unknown import zone ID : search zone name and add it to the zone table
		for name, id in importZoneTable do
			if id == zoneId then
				zoneName = name
				importZoneTable[zoneId] = zoneName
			end
		end
	end

	-- find the corrected zone ID for the zone name
	if zoneName then
		if not MI2_ZoneTable[zoneName] then
			MI2_ZoneTable.cnt = MI2_ZoneTable.cnt + 1
			MI2_ZoneTable[zoneName] = 100 + MI2_ZoneTable.cnt
		end
		local correctedZoneId = MI2_ZoneTable[zoneName]
		local loc = mobData.location
		mobInfo.ml = (loc.x1 or "").."/"..(loc.y1 or "").."/"..(loc.x2 or "").."/"..(loc.y2 or "").."/0/"..correctedZoneId
	else
		mobInfo.ml = nil
	end
end -- MI2_AdaptImportLocation()


-----------------------------------------------------------------------------
-- MI2_SlashAction_ImportMobData()
--
-- Import externally supplied MobInfo database into own database.
-----------------------------------------------------------------------------
function MI2_SlashAction_ImportMobData()
	local newMobs, updatedMobs, newHealth, newItems = 0, 0, 0, 0
	local chatPrefix = mifontLightBlue.."<MobInfo Import>"..mifontWhite

	chattext( chatPrefix.." starting external database import ...." )

	-- import loot items into main loot item database
	for itemId, itemInfo in MI2_ItemNameTable_Import do
		if not MI2_ItemNameTable[itemId] then
			MI2_ItemNameTable[itemId] = itemInfo
			newItems = newItems + 1
		end
	end

	-- import health data into main Mob health database
	for mobIndex, healthInfo in MobHealthDB_Import do
		if not MobHealthDB[mobIndex] then
			MobHealthDB[mobIndex] = healthInfo
			newHealth = newHealth + 1
		end
	end

	-- import Mobs into main Mob database
	for mobIndex, mobInfo in MobInfoDB_Import do
		MI2_RemoveCharData( mobInfo )
		MI2_AdaptImportLocation( mobInfo, MI2_ZoneTable_Import )
		if MobInfoDB[mobIndex] then
			updatedMobs = updatedMobs + 1
			if MobInfoConfig.ImportOnlyNew == 0 then
				-- import Mob that already exists
				MI2_UpdateMob( mobIndex, mobInfo )
			end
		else
			-- import unknown Mob
			MobInfoDB[mobIndex] = mobInfo
			newMobs = newMobs + 1
		end
	end

	-- update item cross reference table after import
	if MobInfoConfig.ImportOnlyNew == 0 then
		MI2_BuildXRefItemTable()
	end

	chattext( chatPrefix.." imported "..newMobs.." new Mobs" )
	chattext( chatPrefix.." imported "..newHealth.." new health values" )
	chattext( chatPrefix.." imported "..newItems.." new loot items" )
	if MobInfoConfig.ImportOnlyNew == 0 then
		chattext( chatPrefix.." updated data for "..updatedMobs.." existing Mobs" )
	else
		chattext( chatPrefix.." did NOT update data for "..updatedMobs.." existing Mobs" )
	end

	-- update database options frame
	MobInfoConfig.ImportSignature = MI2_Import_Signature
	MI2_DbOptionsFrameOnShow()
end  -- MI2_SlashAction_ImportMobData()


-----------------------------------------------------------------------------
-- MI2_SlashAction_DeleteSearch()
--
-- Delete all Mobs in the search result list from the MobInfo database.
-- This function will ask for confirmation before deleting.
-----------------------------------------------------------------------------
function MI2_SlashAction_DeleteSearch()
	local confirmationText = string.format( MI_TXT_DEL_SEARCH_CONFIRM, MI2_NumMobsFound )
	StaticPopupDialogs["MOBINFO_CONFIRMATION"].text = confirmationText
	StaticPopupDialogs["MOBINFO_CONFIRMATION"].OnAccept = MI2_DeleteSearchResultMobs
	local dialog = StaticPopup_Show( "MOBINFO_CONFIRMATION", "")
end -- MI2_SlashAction_DeleteSearch()


-----------------------------------------------------------------------------
-- MI2_SlashInit()
--
-- Add all Slash Commands
-----------------------------------------------------------------------------
function MI2_SlashInit()
  SlashCmdList["MOBINFO"] = MI2_SlashParse
  SLASH_MOBINFO1 = "/mobinfo2" 
  SLASH_MOBINFO2 = "/mi2" 
end  -- MI2_SlashInit()


-----------------------------------------------------------------------------
-- MI2_SlashParse()
--
-- Parses the msg entered as a slash command. This function is also used
-- for the internal purpose of setting all options in the options dialog.
-- When used by the options dialog there is no need to actually update the
-- dialog, which is indicated by the "updateOptions" parameter.
-----------------------------------------------------------------------------
function MI2_SlashParse( msg, updateOptions )
	-- extract option name and option argument from message string
	local _, _, cmd, param = string.find( string.lower(msg), "([%w_]*)[ ]*([-%w]*)") 
	
	-- handle show/hide of options dialog first of all
	-- handle all simple commands that dont require parsing right here
	if  not cmd  or  cmd == ""  or  cmd == "config"  then
		if  frmMIConfig:IsVisible()  then
			frmMIConfig:Hide()
		else
			frmMIConfig:Show()
		end
		return
	elseif  cmd == 'version'  then
		chattext( miVersion )
		return
	elseif  cmd == 'notes'  then
		chattext( miPatchNotes )
		return
	elseif  cmd == 'convertdroprate'  then
		MI2_StartDropRateConversion()
		return
	elseif  cmd == 'help'  then
		chattext( mifontYellow.. 'Usage /mobinfo2 <cmd> or /mi2 <cmd>' )
		chattext( 'Where <cmd> is any of the following:' )
		for idx, val in MI2_OPTIONS do
			if  val.help and val.help ~= ""  then
				local prefix = string.sub(idx, 1, 7)
				local option = string.lower( string.sub(idx, 8) )
				if prefix == "MI2_Opt" then
					chattext( mifontGreen..option..' - '..mifontYellow..val.help )
				end
			end
		end
		return
	end

	-- search for the option data structure matching the command
	local optionName, optionData
	for idx, val in MI2_OPTIONS do
		local lower_opt = string.lower( idx )
		local optionCommand = string.sub(lower_opt, 8)
		if cmd == lower_opt or cmd == optionCommand then
			optionName = string.sub(idx, 8)
			optionData = val
			break
		end
	end

	-- now call the option handler for the more complex commands
	if  optionData  then
		MI2_OptionParse( optionName, optionData, param, updateOptions )
	end
end -- of MI2_SlashParse()


-----------------------------------------------------------------------------
-- MI2_OptionParse()
--
-- Parses the more complex option toggle/set commands. There are 4
-- categories of options:
--   * options that can toggle between an on and off state
--   * options that represent a numeric value
--   * options that represent a text
--   * options that activate a special functionality represented by a
--     handler function that must correspond to a specific naming convention
-----------------------------------------------------------------------------
function MI2_OptionParse( optionName, optionData, param, updateOptions )
	-- handle the option according to its option type: its either a
	-- switch being toggleg, a value being set, or a special action
	if optionData.val then
		-- it is a slider setting a value
		-- get new option value from parameter and set it
		local optValue = tonumber( param ) or 0
		MobInfoConfig[optionName] = optValue
		if  updateOptions  then
			chattext( optionData.text.." : "..mifontGreen..optValue )
		end

	elseif optionData.txt then
		-- it is a text based option
		MobInfoConfig[optionName] = param
		if  updateOptions  then
			chattext( optionData.text.." : "..mifontGreen..param )
		end

	elseif  MobInfoConfig[optionName]  then
		-- it is a switch toggle option:
		-- get current option value and toggle it to the opposite state (On<->Off)
		local valTxt = { val0 = "-OFF-",  val1 = "-ON-" }
		local optValue = MobInfoConfig[ optionName ]
		optValue = 1 - optValue  -- toggle option
		MobInfoConfig[optionName] = optValue
		chattext( optionData.text.." : "..mifontGreen..valTxt["val"..optValue] )

		-- special case: disabling MobInfo requires extra processing
		if optionName == "DisableMobInfo" then MI2_UpdateMobInfoState() end

	else
		-- special action commands have a corresponding handler function
		local actionHandlerName = "MI2_SlashAction_"..optionName
		local actionHandler = getglobal( actionHandlerName )
		if  actionHandler  then
			actionHandler()
			updateOptions = true -- for AllOn, AllOff, etc.
		end
	end

	-- update font and position of health / mana texts
	MI2_MobHealth_SetPos()

	-- update options dialog if shown and if requested
	if  frmMIConfig:IsVisible()  and  updateOptions  then
		MI2_UpdateOptions()
	end

end  -- MI2_OptionParse()

