--
-- MobInfo2.lua
--
-- Main module of MobInfo-2 AddOn
-- Version:  2.97
--
-- MobInfo-2 is a World of Warcraft AddOn that provides you with useful
-- additional information about Mobs (ie. opponents/monsters). It adds
-- new information to the game's Tooltip when you hover with your mouse
-- over a mob. It also adds a numeric display of the Mobs health
-- and mana (current and max) to the Mob target frame.
--
-- MobInfo-2 is the continuation of the original "MobInfo" by Dizzarian,
-- combined with the original "MobHealth2" by Wyv. Both Dizzarian and
-- Wyv sadly no longer play WoW and stopped maintaining their AddOns.
-- I have "inhereted" MobInfo from Dizzarian and MobHealth-2 from Wyv
-- and now continue to update and improve the united result.
--

-- global vars
MI2_Debug = 0  -- 0=no debug info, 1=minimal debug info, 2=extensive debug info, 3=more extensive+event info
MI2_DebugItems = 0  -- 0=no item debug info, 1=show item ID and item value in tooltip
MI2_DB_VERSION = 6
MI2_IMPORT_DB_VERSION = 6

-- default initialization for all MobInfo database tables
-- this automatically gets overwritten by the database contents loaded from file
MobInfoDB		= { ["DatabaseVersion:0"] = { ver = MI2_DB_VERSION } }
MI2_CharTable	= { charCount = 0 }
MI2_ZoneTable	= { cnt = 0 }
MI2_ItemNameTable = {}
MobHealthPlayerDB = {}
MobHealthDB		= {	}

local MI2_CurrentTargets = {}
local MI2_RecentCorpses = {}
local MI2_NewCorpseIdx = 0
local MI2_CurrentCorpseIndex = nil
local MI2_LootFrameOpen = false

-- skinning loot table using localization independant item IDs:
--    Ruined Leather Scraps, Light Leather, Medium Leather, Heavy Leather, Thick Leather, Rugged Leather
--    Chimera Leather, Devilsaur Leather, Frostsaber Leather, Warbear Leather,
--    Light Hide, Medium Hide, Heavy Hide, Thick Hide, Rugged Hide, Shadowcat Hide, Thick Wolfhide
--    Scorpid Scale, Shiny Fish Scales, Red Whelp Scales, Turtle Scales, Black Whelp Scales, Brilliant Chromatic Scale
--    Black Dragonscale, Blue Dragonscale, Red Dragonscale, Green Dragonscale, Worn Dragonscale, Heavy Scorpid Scale
local miSkinLoot = { [2934]=1, [2318]=1, [2319]=1, [4234]=1, [4304]=1, [8170]=1, 
                    [15423]=1,[15417]=1,[15422]=1,[15419]=1,
                      [783]=1, [4232]=1, [4235]=1, [8169]=1, [8171]=1, [7428]=1, [8368]=1,
                     [8154]=1,[17057]=1, [7287]=1, [8167]=1, [7286]=1,[12607]=1,
                    [15416]=1,[15415]=1,[15414]=1,[15412]=1, [8165]=1,[15408]=1, }

-- cloth loot table using localization independant item IDs
-- Linen Cloth, Wool Cloth, Silk Cloth, Mageweave Cloth, Felcloth, Runecloth, Mooncloth
local miClothLoot = { [2589]=1, [2592]=1, [4306]=1, [4338]=1, [14256]=1, [14047]=1, [14342]=1 };

local MI2_ItemCollapseList = { [2725]=2725, [2728]=2725, [2730]=2725, [2732]=2725, 
                               [2734]=2725, [2735]=2725, [2738]=2725, [2740]=2725,[2742]=2725,
                               [2745]=2725, [2748]=2725, [2749]=2725, [2750]=2725, [2751]=2725 }

-- global MobInfo color constansts
mifontBlue = "|cff0000ff"
mifontItemBlue = "|cff2060ff"
mifontLightBlue = "|cff00e0ff"
mifontGreen = "|cff00ff00"
mifontRed = "|cffff0000"
mifontLightRed = "|cffff8080"
mifontGold = "|cffffcc00"
mifontGray = "|cff888888"
mifontWhite = "|cffffffff"
mifontSubWhite = "|cffbbbbbb"
mifontMageta = "|cffe040ff" -- old magenta: "|cffff00ff"
mifontYellow  = "|cffffff00"
mifontCyan   = "|cff00ffff"
mifontOrange = "|cffff7000"
MI2_QualityColor = { [1]=mifontGray, [2]=mifontWhite, [3]=mifontGreen, [4]=mifontItemBlue, [5]=mifontMageta, [6]=mifontOrange, [7]=mifontRed }


-----------------------------------------------------------------------------
-- MI2_GetMobData( mobName, mobLevel [, unitId] )
--
-- Get and return all the data that MobInfo knows about a given mob.
-- This is an externally available interface function that can be
-- called by other AddOns to access MobInfo data. It should be fast,
-- efficient, and easy to use
--
-- The data describing a Mob is returned in table form as described below.
--
-- To identify the mob you must supply its name and level. You can
-- optionally supply a "unitId" to get additional info:
--   mobName : name of mob, eg. "Forest Lurker"
--   mobLevel : mob level as integer number
--   unitId : optional WoW unit identification, should be either
--            "target" or "mouseover"
--
-- Examples:
--    A.   mobData = MI2_GetMobData( "Forest Lurker", 10 )
--    B.   mobData = MI2_GetMobData( "Forest Lurker", 10, "target" )
--
-- Return Value:
-- The return value is a LUA table with one table entry for each value that
-- MobInfo can know about a Mob. Note that table entries exist ONLY if the
-- corresponding value has actually been collected for the given Mob.
-- Unrecorded values do NOT exist in the table and thus evaluate to a NIL
-- expression.
--
-- Values you can get without "unitId" (as per Example A above):
--    mobData.healthMax  :  health maximum
--    mobData.xp         :  experience value
--    mobData.kills      :  number of times current player has killed this mob
--    mobData.minDamage  :  minimum damage done by mob
--    mobData.maxDamage  :  maximum damage done by mob
--    mobData.dps        :  dps of Mon against current player
--    mobData.loots      :  number of times this mob has been looted
--    mobData.emptyLoots :  number of times this mob gave empty loot
--    mobData.clothCount :  number of times this mob gave cloth loot
--    mobData.copper     :  total money loot of this mob as copper amount
--    mobData.itemValue  :  total item value loot of this mob as copper amount
--    mobData.mobType    :  mob type for special mobs: 1=normal, 2=rare/elite, 3=boss
--    mobData.r1         :  number of rarity 1 loot items (grey)
--    mobData.r2         :  number of rarity 2 loot items (white)
--    mobData.r3         :  number of rarity 3 loot items (green)
--    mobData.r4         :  number of rarity 4 loot items (blue)
--    mobData.r5         :  number of rarity 5 loot items (purple)
--    mobData.itemList   :  table that lists all recorded items looted from this mob
--                          table entry index gives WoW item ID, 
--                          table entry value gives item amount
--
-- Additional values you will get with "unitId" (as per Example B above):
--    mobData.class      :  class of mob as localized text
--    mobData.healthCur  :  current health of given unit
--    mobData.manaCur    :  current mana of given unit
--    mobData.manaMax    :  maximum mana for given unit
--
-- Code Example:
--    
--    local mobData = MI2_GetMobData( "Forest Lurker", 10 )
--    
--    if mobData.xp then
--        DEFAULT_CHAT_FRAME:AddMessage( "XP = "..mobData.xp ) 
--    end
--    
--    if mobData.copper and mobData.loots then
--        local avgLoot = mobData.copper / mobData.loots
--        DEFAULT_CHAT_FRAME:AddMessage( "average loot = "..avgLoot ) 
--    end
-----------------------------------------------------------------------------
function MI2_GetMobData( mobName, mobLevel, unitId )
	local mobData = {}
	local mobIndex = mobName..":"..mobLevel

    -- get mobs PPP and calculate max health
	local mobPPP = MobHealth_PPP(mobIndex)
	if mobPPP <= 0 then mobPPP = 1 end
	mobData.healthMax = floor(mobPPP * 100 + 0.5)

	if MI2_Debug > 2 then chattext( "M2DBG: MI2_GetMobData: name=["..mobName.."], level="..mobLevel..", exists: "..tostring(MobInfoDB[mobIndex] ~= nil) ) end

	-- obtain unit specific values if unitId is given
	if unitId then
		mobData.class = UnitClass(unitId)
		if UnitHealthMax(unitId) == 100 then
			mobData.healthCur = floor(mobPPP * UnitHealth(unitId) + 0.5)
		else
			mobData.healthCur = UnitHealth(unitId)
		end
		mobData.manaCur = UnitMana( unitId )
		mobData.manaMax = UnitManaMax( unitId )
	end

	-- decode basic mob info
	-- exit here if mob does not exist in DB, set color only if mob exists
	local mobInfo = MobInfoDB[mobIndex]
	if  not mobInfo then return mobData end
	mobData.color = GetDifficultyColor( mobLevel )

	MI2_GetMobDataFromMobInfo( mobInfo, mobData )

	return mobData
end -- MI2_GetMobData()


-----------------------------------------------------------------------------
-- MI2_GetMobDataFromMobInfo()
--
-- Extract all data describing a specific mob from a given mob database
-- record (called "mobInfo"). The various different fields within the
-- record get decoded and the resulting data is returned in a convenient
-- format that allows for easy further processing of the data. The return
-- format for the decoded data is called "mobData". The resulting "mobData"
-- structure is returned.
-----------------------------------------------------------------------------
function MI2_GetMobDataFromMobInfo( mobInfo, mobData )
	MI2_DecodeBasicMobData( mobInfo, mobData )
	MI2_DecodePlayerSpecificData( mobInfo, mobData, MI2_PlayerName )
	MI2_DecodeQualityOverview( mobInfo, mobData )
	MI2_DecodeMobLocation( mobInfo, mobData )
	MI2_DecodeItemList( mobInfo, mobData )
end -- MI2_GetMobDataFromMobInfo()


-----------------------------------------------------------------------------
-- MI2_DecodeBasicMobData()
--
-- Decode the basic mob data. This function is used by the public
-- "MI2_GetMobData()" and also by the Mob search routines.
-----------------------------------------------------------------------------
function MI2_DecodeBasicMobData( mobInfo, mobData, mobIndex )
	if mobIndex then
		mobInfo = MobInfoDB[mobIndex]
		if not mobInfo then
			-- unknown mob is being looted
			mobData.loots = 1
			return
		end
	end

	-- decode mob basic info: loots, empty loots, experience, cloth count, money looted, item value looted, mob type
	mobData.mobType = 1
	if mobInfo.bi then
		local a,b,lt,el,cp,iv,cc,xp,mt,sc = string.find( mobInfo.bi, "(%d*)/(%d*)/(%d*)/(%d*)/(%d*)/(%d*)/(%d*)/(%d*)")
		mobData.loots		= tonumber(lt)
		mobData.emptyLoots	= tonumber(el)
		mobData.xp			= tonumber(xp)
		mobData.clothCount	= tonumber(cc)
		mobData.copper		= tonumber(cp)
		mobData.itemValue	= tonumber(iv)
		mobData.mobType		= tonumber(mt) or 1
		mobData.skinCount	= tonumber(sc)
	end
end -- MI2_DecodeBasicMobData()


-----------------------------------------------------------------------------
-- MI2_DecodeMobLocation()
--
-- Decode mob location info, skip invalid location data
-- The location is encoded in the mob record entry "ml".
-- The decoded data is stored in the given "mobData" structure.
-----------------------------------------------------------------------------
function MI2_DecodeMobLocation( mobInfo, mobData, mobIndex )
	if mobIndex then
		mobInfo = MobInfoDB[mobIndex]
	end

	if mobInfo.ml then
		local a,b,x1,y1,x2,y2,c,z = string.find( mobInfo.ml, "(%d*)/(%d*)/(%d*)/(%d*)/(%d*)/(%d*)")
		mobData.location = {}
		mobData.location.x1	= tonumber(x1)
		mobData.location.y1	= tonumber(y1)
		mobData.location.x2	= tonumber(x2)
		mobData.location.y2	= tonumber(y2)
		mobData.location.c	= tonumber(c)
		mobData.location.z	= (tonumber(z) or 0)
		if not mobData.location.x1 or not mobData.location.x2 or 
				not mobData.location.y1 or not mobData.location.y2 or 
				not mobData.location.c or mobData.location.z == 0 then
			mobData.location = nil
		end
	end
end -- MI2_DecodeMobLocation()


-----------------------------------------------------------------------------
-- MI2_DecodeQualityOverview()
--
-- Decode item quality data: loot count per item rarity category
-- The loot items quality overview is encoded in the mob record entry "qi".
-- The decoded data is stored in the given "mobData" structure.
-----------------------------------------------------------------------------
function MI2_DecodeQualityOverview( mobInfo, mobData, mobIndex )
	if mobIndex then
		mobInfo = MobInfoDB[mobIndex]
	end

	if mobInfo.qi then
		local a,b,r1,r2,r3,r4,r5 = string.find( mobInfo.qi, "(%d*)/(%d*)/(%d*)/(%d*)/(%d*)")
		mobData.r1	= tonumber(r1)
		mobData.r2	= tonumber(r2)
		mobData.r3	= tonumber(r3)
		mobData.r4	= tonumber(r4)
		mobData.r5	= tonumber(r5)
	end
end -- MI2_DecodeQualityOverview


-----------------------------------------------------------------------------
-- MI2_DecodePlayerSpecificData()
--
-- Decode player specific data: number of kills, min damage, max damage, dps
-- Player specific data is encoded in mob record entries starting with
-- the lowercase letter "c" plus a player name index number, eg. "c7",
-- this is called the player ID code. The playerName parameter must give
-- the player ID code for the player data to decode.
-- The decoded data is stored in the given "mobData" structure.
-----------------------------------------------------------------------------
function MI2_DecodePlayerSpecificData( mobInfo, mobData, playerName, mobIndex )
	if mobIndex then
		mobInfo = MobInfoDB[mobIndex]
	end

	if mobInfo[playerName] then
		local a,b,kl,mind,maxd,dps = string.find( mobInfo[playerName], "(%d*)/(%d*)/(%d*)/(%d*)")
		mobData.kills		= tonumber(kl)
		mobData.minDamage	= tonumber(mind)
		mobData.maxDamage	= tonumber(maxd)
		mobData.dps			= tonumber(dps)
	end
end


-----------------------------------------------------------------------------
-- MI2_DecodeItemList()
--
-- Decode the item list encoded in the "il" string of a mobInfo database
-- record. The result is stored in the given mobData record as a new
-- record field called "itemList".
-----------------------------------------------------------------------------
function MI2_DecodeItemList( mobInfo, mobData, mobIndex )
	if mobIndex then
		mobInfo = MobInfoDB[mobIndex]
	end

	if mobInfo.il then
		local lootItems = mobInfo.il
		local s,e, item, amount = string.find( lootItems, "(%d+)[:]?(%d*)" )
		if e then mobData.itemList = {} end
		while e do
			mobData.itemList[tonumber(item)] = tonumber(amount) or 1
			s,e, item, amount = string.find( lootItems, "/(%d+)[:]?(%d*)", e+1 )
		end
	end
end -- MI2_DecodeItemList()


-----------------------------------------------------------------------------
-- MI2_StoreMobData()
--
-- Store the contents of a given "mobData" structure (ie. the data describing
-- a mob) in the mob database. The "mobData" must be compatible to what is
-- returned by the "MI2_GetMobData()" function.
-----------------------------------------------------------------------------
function MI2x_StoreMobData( mobData, mobName, mobLevel, playerName, mobIndex )
	if not mobIndex then
		mobIndex = mobName..":"..mobLevel
	end

	-- create the mob basic info (".bi") string
	if mobData.mobType == 1 then mobData.mobType = "" end
	local basicInfo = (mobData.loots or "").."/"..(mobData.emptyLoots or "").."/"..(mobData.copper or "").."/"..(mobData.itemValue or "").."/"..
	             (mobData.clothCount or "").."/"..(mobData.xp or "").."/"..(mobData.mobType or "").."/"..(mobData.skinCount or "")

	-- create the mob quality info (".qi") string
	local qualityInfo = (mobData.r1 or "").."/"..(mobData.r2 or "").."/"..(mobData.r3 or "").."/"..(mobData.r4 or "").."/"..(mobData.r5 or "")

	-- create the mob player specific info, which is stored using the players name
	local playerInfo = (mobData.kills or "").."/"..(mobData.minDamage or "").."/"..(mobData.maxDamage or "").."/"..(mobData.dps or "")

	-- create the mob location data
	-- note: a copy of this code can be found in MI2_AdaptImportLocation()
	local loc = mobData.location or {}
	local locationInfo = (loc.x1 or "").."/"..(loc.y1 or "").."/"..(loc.x2 or "").."/"..(loc.y2 or "").."/"..(loc.c or "").."/"..(loc.z or "")

	-- create loot item list string for database
	local itemList = ""
	if mobData.itemList then
		local prefix = ""
		for itemID, amount in mobData.itemList do
			itemList = itemList..prefix..itemID
			if amount > 1 then
				itemList = itemList..":"..amount
			end
			prefix = "/"
		end
	end
	
	-- only enter non empty data into database record
	local mobInfo = {}
	local recordNotEmpty = false
	if MobInfoConfig.SaveBasicInfo == 1 and basicInfo ~= "///////" then
		mobInfo.bi = basicInfo
		recordNotEmpty = true
	end
	if MobInfoConfig.SaveBasicInfo == 1 and qualityInfo ~= "////" then
		mobInfo.qi = qualityInfo
		recordNotEmpty = true
	end
	if MobInfoConfig.SaveCharData == 1 and playerInfo ~= "///" then
		mobInfo[playerName] = playerInfo
		recordNotEmpty = true
	end
	if MobInfoConfig.SaveItems == 1 and itemList ~= "" then
		mobInfo.il = itemList
		recordNotEmpty = true
	end

	if MobInfoConfig.SaveBasicInfo == 1 and locationInfo ~= "/////" then
		mobInfo.ml = locationInfo
		recordNotEmpty = true
	end

	-- do not store empty records in database
	if recordNotEmpty then
		MobInfoDB[mobIndex] = mobInfo
	end

end -- MI2_StoreMobData()


-----------------------------------------------------------------------------
-- MI2_RemoveCharData()
--
-- Remove all char specific data from the given Mob database record.
-----------------------------------------------------------------------------
function MI2_RemoveCharData( mobInfo )
	for entryName, entryData in mobInfo do
		if entryName ~= "bi" and entryName ~= "qi" and entryName ~= "il" and entryName ~= "ml" and entryName ~= "ver" then
			mobInfo[entryName] = nil
		end
	end
end -- MI2_StoreMobData()


-----------------------------------------------------------------------------
-- MI2_PrepareForImport()
--
-- Prepare for importing external MobInfo databases into the main database.
-----------------------------------------------------------------------------
function MI2_PrepareForImport()
	local mobDbSize, healthDbSize, itemDbSize = 0, 0, 0

	--	external database version number check
	local version = MobInfoDB["DatabaseVersion:0"].ver
	if version and version < MI2_IMPORT_DB_VERSION then
		MI2_Import_Status = "BADVER"
		return
	end

	-- calculate Mob database size and import signature
	local levelSum, nameSum = 0, 0
	for index in MobInfoDB do  
		mobDbSize = mobDbSize + 1
		local mobName, mobLevel = MI2_GetIndexComponents( index )
		levelSum = levelSum + mobLevel
		nameSum = nameSum + string.len( mobName )
	end
	for index in MobHealthDB do  healthDbSize = healthDbSize + 1  end
	for index in MI2_ItemNameTable do  itemDbSize = itemDbSize + 1  end
	MI2_Import_Signature = mobDbSize.."_"..healthDbSize.."_"..itemDbSize.."_"..levelSum.."_"..nameSum

	-- store copy of databases to be imported and calculate import status
	MobInfoDB["DatabaseVersion:0"] = nil
	MobInfoDB_Import = MobInfoDB
	MI2_ItemNameTable_Import = MI2_ItemNameTable
	MI2_ZoneTable_Import = MI2_ZoneTable
	MobHealthDB_Import = MobHealthDB
	if mobDbSize > 1 then
		MI2_Import_Status = (mobDbSize-1).." Mobs"
	end
	if healthDbSize > 0 then
		if MI2_Import_Status then
			MI2_Import_Status = MI2_Import_Status.." & " 
		end
		MI2_Import_Status = (MI2_Import_Status or "")..healthDbSize.." HP values"
	end

	MobInfoDB		= { ["DatabaseVersion:0"] = { ver = MI2_DB_VERSION } }
	MI2_CharTable	= { charCount = 0 }
	MI2_ZoneTable	= { cnt = 0 }
	MI2_ItemNameTable = {}
	MobHealthDB		= {	}
end -- MI2_PrepareForImport()
	
-----------------------------------------------------------------------------
-- MI2_DeleteMobData()
--
-- Delete data for a specific Mob from database and current target table.
-----------------------------------------------------------------------------
function MI2_DeleteMobData( mobIndex, deleteHealth )
	if mobIndex then
		MobInfoDB[mobIndex] = nil
		MI2_CurrentTargets[mobIndex] = nil
		if deleteHealth then
			MobHealthDB[mobIndex] = nil
		end
		if mobIndex == MI2_Target.mobIndex then
			MI2_Target = {}
			MobHealth_Display()
		end
	end
end  -- MI2_DeleteMobData()


-----------------------------------------------------------------------------
-- chattext()
--
-- spits out msg to the chat channel. used in debuging
-----------------------------------------------------------------------------
function chattext(txt)
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(txt)
	end
end -- chattext()


-----------------------------------------------------------------------------
-- MI2_InitOptions()
--
-- initialize MobInfo configuration options
-- this takes into account new options that have been added to MobInfo
-- in the course of developement
-----------------------------------------------------------------------------
 function MI2_InitOptions()
	-- initialize MobInfoConfig
	if not MobInfoConfig or not MobInfoConfig.ShowLoots then
		MobInfoConfig = { }
		MI2_SlashAction_Default()
	end

	-- initial defaults for all config options
	if  not MobInfoConfig.ShowBlankLines	then  MobInfoConfig.ShowBlankLines = 1	end
	if  not MobInfoConfig.TargetFontSize	then  MobInfoConfig.TargetFontSize = 10	end
	if  not MobInfoConfig.DisableMobInfo	then  MobInfoConfig.DisableMobInfo = 0	end
	if  not MobInfoConfig.ShowDamage	then  MobInfoConfig.ShowDamage = 1		end
	if  not MobInfoConfig.ShowMana		then  MobInfoConfig.ShowMana = 1		end
	if  not MobInfoConfig.ShowEmpty		then  MobInfoConfig.ShowEmpty = 0		end
	if  not MobInfoConfig.CombinedMode	then  MobInfoConfig.CombinedMode = 0	end
	if  not MobInfoConfig.ShowCombined	then  MobInfoConfig.ShowCombined = 1	end
	if  not MobInfoConfig.KeypressMode	then  MobInfoConfig.KeypressMode = 0	end
	if  not MobInfoConfig.StableMax		then  MobInfoConfig.StableMax = 0		end
	if  not MobInfoConfig.TargetHealth	then  MobInfoConfig.TargetHealth = 1	end
	if  not MobInfoConfig.TargetMana	then  MobInfoConfig.TargetMana = 1		end
	if  not MobInfoConfig.HealthPercent	then  MobInfoConfig.HealthPercent = 1	end
	if  not MobInfoConfig.ManaPercent	then  MobInfoConfig.ManaPercent = 1		end
	if  not MobInfoConfig.HealthPosX	then  MobInfoConfig.HealthPosX = -7		end
	if  not MobInfoConfig.HealthPosY	then  MobInfoConfig.HealthPosY = 11		end
	if  not MobInfoConfig.ManaPosX		then  MobInfoConfig.ManaPosX = -7		end
	if  not MobInfoConfig.ManaPosY		then  MobInfoConfig.ManaPosY = 11		end
	if  not MobInfoConfig.TargetFont	then  MobInfoConfig.TargetFont = 2		end
	if  not MobInfoConfig.SavePlayerHp	then  MobInfoConfig.SavePlayerHp = 0	end
	if  not MobInfoConfig.CompactMode	then  MobInfoConfig.CompactMode = 1		end
	if  not MobInfoConfig.ShowItems		then  MobInfoConfig.ShowItems = 1		end
	if  not MobInfoConfig.SaveItems		then  MobInfoConfig.SaveItems = 1		end
	if  not MobInfoConfig.SaveCharData	then  MobInfoConfig.SaveCharData = 1	end
	if  not MobInfoConfig.ItemsQuality	then  MobInfoConfig.ItemsQuality = 2	end
	if  not MobInfoConfig.SaveBasicInfo	then  MobInfoConfig.SaveBasicInfo = 1	end
	if  not MobInfoConfig.ItemTooltip	then  MobInfoConfig.ItemTooltip = 1		end
	if  not MobInfoConfig.ItemFilter	then  MobInfoConfig.ItemFilter = ""		end
	if  not MobInfoConfig.ShowLocation	then  MobInfoConfig.ShowLocation = 1	end
	if  not MobInfoConfig.SaveLocation	then  MobInfoConfig.SaveLocation = 1	end
	if  not MobInfoConfig.ShowClothSkin	then  MobInfoConfig.ShowClothSkin = 1	end
	if  not MobInfoConfig.ImportOnlyNew	then  MobInfoConfig.ImportOnlyNew = 0	end

	-- former option "HealthOff" has been renamed to "DisableHealth"
	if  not MobInfoConfig.DisableHealth  then  
		MobInfoConfig.DisableHealth = (MobInfoConfig.HealthOff or 0)
	end

	-- config values that no longer exist
	if  MobInfoConfig.HealthOff		then	MobInfoConfig.HealthOff = nil  end
	if  MobInfoConfig.ManaDistance	then	MobInfoConfig.ManaDistance = nil end
	if  MobInfoConfig.ShowPercent	then	MobInfoConfig.ShowPercent = nil end
	if  MobInfoConfig.CustomTracks	then	MobInfoConfig.CustomTracks = nil end
	if  MobInfoConfig.SaveAllValues	then	MobInfoConfig.SaveAllValues = nil end
	if  MobInfoConfig.MobDbVersion	then	MobInfoConfig.MobDbVersion = nil end
	if  MobInfoConfig.MobDbVersion	then	MobInfoConfig.MobDbVersion = nil end
	if  MobInfoConfig.ClearOnExit	then	MobInfoConfig.ClearOnExit = nil end
	if  MobInfoConfig.SaveGoodItems	then	MobInfoConfig.SaveGoodItems = nil	end
	if  MobInfoConfig.SaveQualityData	then	MobInfoConfig.SaveQualityData = nil	end
end -- MI2_InitOptions()


-----------------------------------------------------------------------------
-- MI2_IndexComponents()
--
-- Return the component parts of a mob index: mob name, mob level
-----------------------------------------------------------------------------
function MI2_GetIndexComponents( mobIndex )
	local a, b, mobName, mobLevel = string.find(mobIndex, "(.+):(.+)$")
	mobLevel = tonumber(mobLevel)
	return mobName, mobLevel
end  -- MI2_IndexComponents()


-----------------------------------------------------------------------------
-- MI2_CleanupDatabases()
--
-- Cleanup for MobInfo database. This function corrects bugs in the
-- MobInfo database and applies some changes that have been made to
-- the format of the actual database entires.
--
-- With "DatabaseVersion" 3 the database storage format has changed completely,
-- which means that a complex conversion must be applied to convert the
-- old into the new database format.
--
-- increased DB version to 4 to enforce a cleanup run for everyone installing
-- the newest MobInfo release (2.64 and above)
-----------------------------------------------------------------------------
function MI2_CleanupDatabases()
--	local startTime = GetTime()
	local mobIndex, mobInfo

	if MobInfoDB.DatabaseVersion then MobInfoDB.DatabaseVersion = nil end

	-- attempt to automatically fix invalid database entries where the index is bugged
	for mobIndex, mobInfo in MobInfoDB do
		local mobName, mobLevel = MI2_GetIndexComponents( mobIndex )
		if not mobName or not mobLevel or mobName == "" then
			MobInfoDB[mobIndex] = nil
		end
	end

	-- update database to the most recent version
	-- this will convert old databases into the new DB format and will attempt
	-- to fix any invalid database entries
	if not MobInfoDB["DatabaseVersion:0"] or MobInfoDB["DatabaseVersion:0"].ver < MI2_DB_VERSION then
		if MI2_Debug > 0 then chattext( "M2DBG: running DB cleanup for ver=[nil]" ) end
		MobInfoDB["DatabaseVersion:0"] = nil

		-- loop through all Mobs in the database
		for mobIndex, mobInfo in MobInfoDB do
			-- build new "basic info" entry from old separate entries
			if (mobInfo.lt or mobInfo.el or mobInfo.cp or mobInfo.iv or mobInfo.cc or mobInfo.xp) and not mobInfo.bi then
				if mobInfo.lt and mobInfo.lt <= 0 then mobInfo.lt = nil end
				if mobInfo.cp and mobInfo.cp <= 0 then mobInfo.cp = nil end
				if mobInfo.iv and mobInfo.iv <= 0 then mobInfo.iv = nil end
				if mobInfo.el and mobInfo.el <= 0 then mobInfo.el = nil end
				if mobInfo.cc and mobInfo.cc <= 0 then mobInfo.cc = nil end
				mobInfo.bi = (mobInfo.lt or "").."/"..(mobInfo.el or "").."/"..(mobInfo.cp or "").."/"..(mobInfo.iv or "").."/"..(mobInfo.cc or "").."/"..(mobInfo.xp or "").."/"..(mobInfo.mt or "")
			end
			local s, slashCount = string.gsub( (mobInfo.bi or ""), "/", "@" )
			if slashCount == 6 then mobInfo.bi = mobInfo.bi.."/"; slashCount = slashCount + 1 end
			if mobInfo.bi == "///////" then mobInfo.bi = nil end
			if mobInfo.bi and slashCount ~= 7 then mobInfo.bi = nil end

			-- build new "quality info" entry from  old separate entries
			if (mobInfo.r0 or mobInfo.r1 or mobInfo.r2 or mobInfo.r3 or mobInfo.r4) and not mobInfo.qi then
				if mobInfo.r0 and mobInfo.r0 <= 0 then mobInfo.r0 = nil end
				if mobInfo.r1 and mobInfo.r1 <= 0 then mobInfo.r1 = nil end
				if mobInfo.r2 and mobInfo.r2 <= 0 then mobInfo.r2 = nil end
				if mobInfo.r3 and mobInfo.r3 <= 0 then mobInfo.r3 = nil end
				if mobInfo.r4 and mobInfo.r4 <= 0 then mobInfo.r4 = nil end
				mobInfo.qi = (mobInfo.r0 or "").."/"..(mobInfo.r1 or "").."/"..(mobInfo.r2 or "").."/"..(mobInfo.r3 or "").."/"..(mobInfo.r4 or "")
			end
			if mobInfo.qi == "////" then  mobInfo.qi = nil  end

			-- loop through all Mob database record entries
			-- process char specific data and remove all invalid entries from database record
			for entryName, entryData in mobInfo do
				if type(entryData) == "table" then
					-- char specific data in table form found: convert it to new DB format
					local dl = entryData.dl
					local du = entryData.du
					local dd = entryData.dd
					if (dl or du) and not dd then
						dd = dl.."/"..du.."/"..0
					end
					mobInfo[entryName] = (entryData.kl or "").."/"..(dd or "")
				else
					local isCharEntry = type(entryData) == "string" and (string.find(entryName,":") ~= nil or MI2_CharTable[entryName]) and string.find(entryData,"/") ~= nil
					isCharEntry = isCharEntry or type(entryData) == "string"
					if isCharEntry then
						if mobInfo[entryName] == "///" then
							mobInfo[entryName] = nil
						end
					elseif entryName ~= "bi" and entryName ~= "qi" and entryName ~= "il" and entryName ~= "ml" then
						mobInfo[entryName] = nil
					end
				end
			end -- for
		end -- for

		-- loop through all Mobs in the database and convert char name into char index
		-- delete all empty mob records
		for mobIndex, mobInfo in MobInfoDB do
			local entryCount = 0
			for entryName, entryData in mobInfo do
				entryCount = entryCount + 1
				local isCharEntry = type(entryData) == "string" and string.find(entryName,":") ~= nil and string.find(entryData,"/") ~= nil
				if isCharEntry then
					if not MI2_CharTable[entryName] then
						MI2_CharTable.charCount = MI2_CharTable.charCount + 1
						MI2_CharTable[entryName] = "c"..MI2_CharTable.charCount
					end
					mobInfo[MI2_CharTable[entryName]] = entryData
					mobInfo[entryName] = nil
				end
			end -- for
			if entryCount == 0 then
				MobInfoDB[mobIndex] = nil
			end
		end

		MobInfoDB["DatabaseVersion:0"] = { ver = MI2_DB_VERSION }
	end

--	chattext( "<MobInfo> database conversion time = "..(GetTime()-startTime).." seconds" )
end  -- MI2_CleanupDatabases()


-----------------------------------------------------------------------------
-- MI2_ImportLocationsFromMI2B()
--
-- Import the Mob locations that have been recorded by the MI2_Browser
-- AddOn into the MobInfo2 Mob database. Only import correct location
-- data for Mobs that do not yet have a location.
-----------------------------------------------------------------------------
function MI2_ImportLocationsFromMI2B()
	-- import TipBuddy Mob location data into the MobInfo database
	if MobInfoDB_B and not MobInfoDB_B.converted then
		for idx, val in MobInfoDB_B do
			if MobInfoDB[idx] and not MobInfoDB[idx].ml and val.loc and val.loc.l and val.loc.x and val.loc.y then
				local x = floor( val.loc.x * 100.0 )
				local y = floor( val.loc.y * 100.0 )
				local _, _, continent, zone = string.find( (tostring(val.loc.l)), MI2B_LOCPATTERN )
				if continent and zone and x > 0 and y > 0 then
					local locationInfo = (x or "").."/"..(y or "").."/"..(x or "").."/"..(y or "").."/"..(continent or "").."/"..(zone or "")
					MobInfoDB[idx].ml = locationInfo
				end
			end
		end
		MobInfoDB_B.converted = 1
	end
end

-----------------------------------------------------------------------------
-- MI2_AddItemToXRefTable()
--
-- build the cross reference table for fast item lookup
-- The table is indexed by item name and lists all Mobs that drop the item
-----------------------------------------------------------------------------
local function MI2_AddItemToXRefTable( mobIndex, itemName, itemAmount )
	if not MI2_XRefItemTable[itemName] then
		MI2_XRefItemTable[itemName] = {}
	end

	local oldAmount = MI2_XRefItemTable[itemName][mobIndex]
	MI2_XRefItemTable[itemName][mobIndex] = (oldAmount or 0) + itemAmount

--chattext("DBG: XRefItemTable: item=["..itemName.."], mob=["..mobIndex.."], val="..MI2_XRefItemTable[itemName][mobIndex] )
end -- MI2_AddItemToXRefTable()


-----------------------------------------------------------------------------
-- MI2_BuildXRefItemTable()
--
-- build the cross reference table for fast item lookup
-- The table is indexed by item name and lists all Mobs that drop the item.
-- It is needed for quickly generating the "Dropped By" list in item tooltips.
-----------------------------------------------------------------------------
function MI2_BuildXRefItemTable()
	MI2_XRefItemTable = {}
	for mobIndex, mobInfo in MobInfoDB do
		local mobData = {}
		MI2_DecodeItemList( mobInfo, mobData )
		if mobData.itemList then 
			for itemID, amount in mobData.itemList do
				local itemText = MI2_ItemNameTable[itemID]
				if itemText then
					itemText = string.sub( itemText, 1, -3 )
					MI2_AddItemToXRefTable( mobIndex, itemText, amount )
				end
			end
		end
	end
end -- MI2_BuildXRefItemTable()


-----------------------------------------------------------------------------
-- MI2_NewMobTarget()
--
-- Add a Mob to the list of current targets. MobInfo tracks all current
-- targets to collect data on the Mobs and for advanced kill counting.
-----------------------------------------------------------------------------
function MI2_NewMobTarget( index )
	if  not MI2_CurrentTargets[index] then
		MI2_CurrentTargets[index] = {}
	end  

	local mobData = MI2_CurrentTargets[index]
	mobData.time = GetTime()
	mobData.killed = nil

	-- obtain and store mob type 
	local mobType  = UnitClassification( "target" )
	if mobType and mobType ~= "normal" then
		if mobType == "rare" or mobType == "elite" then
			mobData.mobType = 2
		else
			mobData.mobType = 3
		end
	end

	return mobData
end -- MI2_NewMobTarget()


-----------------------------------------------------------------------------
-- MI2_RecordDamage()
--
-- record damage value for a mob
-----------------------------------------------------------------------------
function MI2_RecordDamage( index, damage )
	local mobData = MI2_CurrentTargets[index]

	if MI2_Debug > 1 then chattext( "M2DBG: damage reported: mob=["..index.."], dmg="..damage ) end

	-- update minimum and/or maximum damage for mob
	if mobData and damage > 0 then
		if not mobData.minDamage or mobData.minDamage <= 0 then
			mobData.minDamage, mobData.maxDamage = damage, damage
		elseif damage < mobData.minDamage then
			if MI2_Debug > 0 then chattext( "M2DBG: recording new MIN dmg "..damage.." for ["..index.."] (old="..mobData.minDamage..")" ) end
			mobData.minDamage = damage
		elseif damage > mobData.maxDamage then
			if MI2_Debug > 0 then chattext( "M2DBG: recording new MAX dmg "..damage.." for ["..index.."] (old="..mobData.maxDamage..")" ) end
			mobData.maxDamage = damage
		end
	end
end -- MI2_RecordDamage()


-----------------------------------------------------------------------------
-- MI2_RecordDps()
--
-- record a new dps (damage per second) value for a specific mob
-- dps gets calculated from damage done within a given time
-----------------------------------------------------------------------------
function MI2_RecordDps( index, deltaTime, damage  )
	local mobData = MI2_CurrentTargets[index]

	-- only store dps for fights longer then 4 seconds
	if mobData and deltaTime > 4 then
		-- calculate DPS value
		local newDps = damage / deltaTime
		if not mobData.dps then mobData.dps = newDps end
		mobData.dps = floor( ((2.0 * mobData.dps) + newDps) / 3.0 )

		-- update the dd (damage data) entry for this mob
		if MI2_Debug > 0 then chattext( "M2DBG: recording new dps: idx="..index..", new dps="..mobData.dps ) end
	end
end -- MI2_RecordDps()


-----------------------------------------------------------------------------
-- MI2_RecordKill()
--
-- record a kill and optionally the xp you got for the kill for the given mob
-----------------------------------------------------------------------------
local function MI2_RecordKill( index, xp )
	local mobData = MI2_CurrentTargets[index]

	if mobData then
		if not mobData.killed then
			mobData.kills = (mobData.kills or 0) + 1
		end
		mobData.killed = 1
		if xp > 0 then
			mobData.xp = xp
		end
		mobData.time = GetTime()
	end

	if MI2_Debug > 0 then chattext( "M2DBG: recording kill "..(mobData.kills or "<nil>").." and XP "..xp.." for mob ["..index.."]" ) end
end -- MI2_RecordKill()


-----------------------------------------------------------------------------
-- MI2_RecordLocation()
--
-- record the current location of the player as the location of the Mob
-- he is fighting
-----------------------------------------------------------------------------
local function MI2_RecordLocation( index )
	local mobData = MI2_CurrentTargets[index]

	if mobData and not mobData.location then
		local x, y = GetPlayerMapPosition("player")
		x = floor( x * 100.0 )
		y = floor( y * 100.0 )
		mobData.location = { x1=x, x2=x, y1=y, y2=y, c=MI2_CurContinent, z=MI2_CurZone }
	end
end -- MI2_RecordLocation()


-----------------------------------------------------------------------------
-- MI2_RecordLootData()
--
-- Record the data for one loot item. This function is called in turn for
-- each loot item in the loot window.
-----------------------------------------------------------------------------
local function MI2_RecordLootData( mobData, itemID, money, itemValue, quality, isSkinningLoot )
	mobData.clothCount = (mobData.clothCount or 0) + (miClothLoot[itemID] or 0 )
	mobData.copper = (mobData.copper or 0) + money
	if isSkinningLoot then
		mobData.skinCount = (mobData.skinCount or 0) + 1
	else
		-- count item value only for non skinning loot
		mobData.itemValue = (mobData.itemValue or 0) + itemValue
	end

	-- decide whether item should be counted in quality overview
	if itemValue < 1 and quality == 2 or isSkinningLoot then
		quality = -1
	end

	-- record loot item quality (if enabled)
	if quality == 1 then 
		mobData.r1 = (mobData.r1 or 0) + 1
	elseif quality == 2 then
		mobData.r2 = (mobData.r2 or 0) + 1
	elseif quality == 3 then
		mobData.r3 = (mobData.r3 or 0) + 1
	elseif quality == 4 then
		mobData.r4 = (mobData.r4 or 0) + 1
	elseif quality == 5 then
		mobData.r5 = (mobData.r5 or 0) + 1
	end
end -- MI2_RecordLootData()


-----------------------------------------------------------------------------
-- MI2_AddTwoMobs()
--
-- add the data for two mobs,
-- the data of the second mob (mobData2) is added to the data of the first
-- mob (mobData1). The result is returned in "mobData1".
-----------------------------------------------------------------------------
function MI2_AddTwoMobs( mobData1, mobData2 )
	mobData1.loots = (mobData1.loots or 0) + (mobData2.loots or 0)
	mobData1.kills = (mobData1.kills or 0) + (mobData2.kills or 0)
	mobData1.emptyLoots = (mobData1.emptyLoots or 0) + (mobData2.emptyLoots or 0)
	mobData1.clothCount = (mobData1.clothCount or 0) + (mobData2.clothCount or 0)
	mobData1.copper = (mobData1.copper or 0) + (mobData2.copper or 0)
	mobData1.itemValue = (mobData1.itemValue or 0) + (mobData2.itemValue or 0)
	mobData1.skinCount = (mobData1.skinCount or 0) + (mobData2.skinCount or 0)
	mobData1.r1 = (mobData1.r1 or 0) + (mobData2.r1 or 0)
	mobData1.r2 = (mobData1.r2 or 0) + (mobData2.r2 or 0)
	mobData1.r3 = (mobData1.r3 or 0) + (mobData2.r3 or 0)
	mobData1.r4 = (mobData1.r4 or 0) + (mobData2.r4 or 0)
	mobData1.r5 = (mobData1.r5 or 0) + (mobData2.r5 or 0)
	if mobData2.mobType then mobData1.mobType = mobData2.mobType end
	if mobData2.xp then mobData1.xp = mobData2.xp end

	-- combine locations
	if mobData1.location or mobData2.location then
		if not mobData1.location then
			mobData1.location = mobData2.location
		elseif mobData2.location then
			if mobData2.location.x1 < mobData1.location.x1 then
				mobData1.location.x1 = mobData2.location.x1
			end
			if mobData2.location.x2 > mobData1.location.x2 then
				mobData1.location.x2 = mobData2.location.x2
			end
			if mobData2.location.y1 < mobData1.location.y1 then
				mobData1.location.y1 = mobData2.location.y1
			end
			if mobData2.location.y2 > mobData1.location.y2 then
				mobData1.location.y2 = mobData2.location.y2
			end
			if mobData1.location.c == 0 then
				mobData1.location.c = mobData2.location.c
			end
		end
	end

	-- combine DPS od two mobs
	if not mobData1.dps then
		mobData1.dps = mobData2.dps
	else
		if mobData2.dps then
			mobData1.dps = floor( ((2.0 * mobData1.dps) + mobData2.dps) / 3.0 )
		end
	end

	-- combine minimum and maximum damage	
	if (mobData2.minDamage or 99999) < (mobData1.minDamage or 99999) then
		mobData1.minDamage = mobData2.minDamage
	end
	if (mobData2.maxDamage or 0) > (mobData1.maxDamage or 0) then
		mobData1.maxDamage = mobData2.maxDamage
	end
	
	-- add loot item tables of the two mobs
	if mobData2.itemList then
		if not mobData1.itemList then mobData1.itemList = {} end
		for itemID, amount in mobData2.itemList do
			mobData1.itemList[itemID] = (mobData1.itemList[itemID] or 0) + mobData2.itemList[itemID]
		end
	end

	if mobData1.loots == 0 then mobData1.loots = nil end
	if mobData1.kills == 0 then mobData1.kills = nil end
	if mobData1.emptyLoots == 0 then mobData1.emptyLoots = nil end
	if mobData1.clothCount == 0 then mobData1.clothCount = nil end
	if mobData1.copper == 0 then mobData1.copper = nil end
	if mobData1.itemValue == 0 then mobData1.itemValue = nil end
	if mobData1.skinCount == 0 then mobData1.skinCount = nil end
	if mobData1.dps == 0 then mobData1.dps = nil end
	if mobData1.r1 == 0 then mobData1.r1 = nil end
	if mobData1.r2 == 0 then mobData1.r2 = nil end
	if mobData1.r3 == 0 then mobData1.r3 = nil end
	if mobData1.r4 == 0 then mobData1.r4 = nil end
	if mobData1.r5 == 0 then mobData1.r5 = nil end
end  -- MI2_AddTwoMobs


-----------------------------------------------------------------------------
-- MI2_ProcessTargetTable()
--
-- process the MobInfo target table
-- The target table collects all mob related data (except for health) during
-- a fight and when looting. This function transfers the data that has been
-- collected into the main mob database.
--
-- There are 2 criterias for detecting when the right time has come to
-- transfer a mob into the database. After storing a mob in the database
-- it is removed from the table of current targets:
--   * Looted : mobs that have been looted have been fully processed, their
--     data is complete and can thus be stored
--   * Timeout : mobs that have been in the table for over 20 seconds
--     and have not been killed in that time can be stored
--   * Timeout : mobs that have been killed and have not been looted within
--     the last 60 seconds
-- 
-----------------------------------------------------------------------------
function MI2_ProcessTargetTable()
	for index, newMobData in MI2_CurrentTargets do
		local deltaT = GetTime() - newMobData.time
		if (newMobData.loots and newMobData.loots == newMobData.kills)
				or (not newMobData.loots and newMobData.skinCount)
				or (not newMobData.kills and deltaT > 30)
				or deltaT > 60 then
			if MI2_Debug > 1 then chattext( "M2DBG: entering mob ["..index.."] into database" ) end
			local mobName, mobLevel = MI2_GetIndexComponents( index )
			
			local realMobData = MI2_GetMobData( mobName, mobLevel )
			MI2_AddTwoMobs( realMobData, newMobData )
			MI2x_StoreMobData( realMobData, mobName, mobLevel, MI2_PlayerName )
			MI2_CurrentTargets[index] = nil
		end
	end
end -- MI2_ProcessTargetTable


-----------------------------------------------------------------------------
-- MI2_GetMobHealthStr()
--
-- Returns the mobhealth in the form of xx/xx from the mobdb formed by
-- MobHealth mod Pulled from Telo's MobHealth
-----------------------------------------------------------------------------
local function MI2_GetMobHealthStr( index, healthPercent )
	local ppp = MobHealth_PPP( index )
	if ppp > 0 and healthPercent then
		return string.format("%d / %d", (healthPercent * ppp) + 0.5, (100 * ppp) + 0.5)
	end
end -- MI2_GetMobHealthStr()


-----------------------------------------------------------------------------
-- copper2text()
--
-- Turns a full copper amount to a readable string, eg. 10340 = 1g 3s 40c
-----------------------------------------------------------------------------
function copper2text(copper)
	local g,s,c
		
	g = floor(copper / COPPER_PER_GOLD)
	s = floor(copper / COPPER_PER_SILVER) - g * SILVER_PER_GOLD
	c = copper - g * COPPER_PER_GOLD - s * COPPER_PER_SILVER

	if g > 0 then  
  		return mifontWhite..g..mifontYellow..'g '..mifontWhite..s ..mifontSubWhite..'s '..mifontWhite..c..mifontGold..'c'
	end  

	if s > 0 then  
  		return mifontWhite..s ..mifontSubWhite..'s '..mifontWhite..c..mifontGold..'c'
	end  

	return mifontWhite..c..mifontGold..'c'
end


-----------------------------------------------------------------------------
-- lootName2Copper()
--
-- Turns a lootname like 1 Gold 3 Silver 40 Copper to total copper 10340
-----------------------------------------------------------------------------
function lootName2Copper(item)
	local i = 0
	local g,s,c = 0
	local money = 0
	  
	i = string.find(item, MI_TXT_GOLD )
	if i then
		g = tonumber( string.sub(item,0,i-1) )
		item = string.sub(item,i+5,string.len(item))
		money = money + ((g or 0) * COPPER_PER_GOLD)
	end
	i = string.find(item, MI_TXT_SILVER )
	if i then
		s = tonumber( string.sub(item,0,i-1) )
		item = string.sub(item,i+7,string.len(item))
		money = money + ((s or 0) * COPPER_PER_SILVER)
	end
	i = string.find(item, MI_TXT_COPPER )
	if i then
		c = tonumber( string.sub(item,0,i-1) )
		money = money + (c or 0)
	end

	return money
end -- lootName2Copper()


-----------------------------------------------------------------------------
-- MI2_FindItemValue()
--
-- Find the item value in either the Auctioneer database or in out own copy
-- of the Auctioneer item value database or by asking KC_Items
-----------------------------------------------------------------------------
function MI2_FindItemValue( itemID, link )
	local price
	
	-- check if KC_Items is available and knows the price
	if KC_Items then
		if KC_Items.GetItemPrices and KC_Items.GetCode and link then
			price = KC_Items:GetItemPrices( KC_Items:GetCode(link) )
		elseif KC_Common.GetItemPrices then
			price = KC_Common:GetItemPrices( itemID )
		end
		if price and price > 0 then return price end
	end
	
	-- check if ItemsSync is installed and knows the price
	if ISync and ISync.FetchDB then
		price = tonumber( ISync:FetchDB(itemID, "price") or 0 )
		if price and price > 0 then return price end
	end

	-- check if Auctioneer is installed and knows the price
	if  Auctioneer_GetVendorBuyPrice  then
		price = Auctioneer_GetVendorSellPrice(itemID)
		if price and price > 0 then return price end
	end

	-- check if built-in copy of the Auctioneer base prices knows the item price
	if MI2_BasePrices[itemID] then
		return MI2_BasePrices[itemID]
	end

	return 0  
end -- MI2_FindItemValue()


-----------------------------------------------------------------------------
-- GetLootId()
--
-- get loot ID code for given loot slot number, also return link object
-----------------------------------------------------------------------------
local function GetLootId( slot )
	local idNumber = 0

	local link = GetLootSlotLink( slot )
	if link then
		local _, _, idCode = string.find(link, "|Hitem:(%d+):(%d+):(%d+):")
		idNumber = tonumber( idCode or 0 )
	end

	return idNumber, link
end -- GetLootId()


-----------------------------------------------------------------------------
-- MI2_RecordAllLootItems()
--
-- Record the data for all items found in the currently open loot window.
-- Return to the caller whether this loot window represents real mob loot
-- or not. Examples for "not" are: skinning, clam loot
-----------------------------------------------------------------------------
local function MI2_RecordAllLootItems( mobIndex, mobData )
	local isSkinningLoot = false

	-- iterate through all loot slots and record data for each item
	for slot = 1, GetNumLootItems(), 1 do
		local money, itemValue = 0, 0

		-- obtain loot slot data from WoW
		local texture, itemName, quantity, quality = GetLootSlotInfo( slot )
		local itemID, link = GetLootId( slot )
		quality = quality + 1

		-- abort loot processing upon finding clam meat (ie. a clam was opened)
		if string.find(itemName, MI_TXT_CLAM_MEAT) ~= nil then  return true  end

		-- calculate value of money loot
		if LootSlotIsCoin(slot) then
			money = lootName2Copper(itemName)
			quality = -1
		elseif LootSlotIsItem(slot) then
			itemValue = MI2_FindItemValue( itemID, link )
		end

		-- skinning loot => its a skinning loot window
		if miSkinLoot[itemID] and slot == 1 then  
			isSkinningLoot = true  
		end

		-- record item data within Mob database and in global item table
		-- update cross reference table accordingly
		if MobInfoConfig.SaveItems == 1 and quality >= MobInfoConfig.ItemsQuality then
			if not mobData.itemList then mobData.itemList = {} end
			mobData.itemList[itemID] = (mobData.itemList[itemID] or 0) + quantity
			MI2_ItemNameTable[itemID] = itemName.."/"..quality
			MI2_AddItemToXRefTable( mobIndex, itemName, mobData.itemList[itemID] )
		end

		-- add loot item data to MobInfoDB
		MI2_RecordLootData( mobData, itemID, money, itemValue, quality, isSkinningLoot )
		if MI2_Debug > 1 then chattext( "M2DBG: Loot: slot="..slot..", name=["..item.."], id=["..itemID.."], val=["..itemValue.."], q=["..(quality+1).."]" ) end
	end -- for loop

	return isSkinningLoot;
end -- MI2_RecordAllLootItems()


-----------------------------------------------------------------------------
-- MI2_RecordLooting()
--
-- for non skinning loot increment loot counter and (if applicable)
-- update kill counter, if there have been more kills then loots
-----------------------------------------------------------------------------
local function MI2_RecordLooting( mobData, numLootItems )
	mobData.loots = (mobData.loots or 0) + 1
	if mobData.loots > (mobData.kills or 0) then
		mobData.kills = (mobData.kills or 0) + 1
	end
	-- update empty loot counter
	if numLootItems < 1 then
		mobData.emptyLoots = (mobData.emptyLoots or 0) + 1
	end
end


-----------------------------------------------------------------------------
-- MI2_GetCorpseId()
--
-- create a (hopefully) unique corpse ID out of the loot items found in 
-- the corpse loot window, return nil if loot is empty
-- WoW Bug: GetNumLootItems() includes emptied loot window slots
-----------------------------------------------------------------------------
local function MI2_GetCorpseId( index )
	local corpseId
	local numSlots = GetNumLootItems()
	local numItems = 0 

	if index and numSlots > 0 then
		corpseId = index
		for slot = 1, numSlots do
			local texture, item = GetLootSlotInfo( slot )
			if item ~= "" then corpseId = corpseId..item end
		end
	end

	return corpseId
end -- MI2_GetCorpseId()


-----------------------------------------------------------------------------
-- MI2_StoreCorpseId()
--
-- enter given corpse ID into list of all corpse IDs
-- a list of corpse IDs is maintained to allow detecting corpse reopening
-----------------------------------------------------------------------------
local function MI2_StoreCorpseId( corpseId, isNewCorpse )
	if MI2_Debug > 0 then chattext( "M2DBG: storing new corpse ID ["..(corpseId or "nil").."], newIdx="..MI2_NewCorpseIdx..", curIdx="..(MI2_CurrentCorpseIndex or "<nil>") ) end

	-- store a new corpse ID
	if isNewCorpse then
		MI2_NewCorpseIdx = MI2_NewCorpseIdx + 1
		if MI2_NewCorpseIdx > 10 then
			MI2_NewCorpseIdx = 1
		end
		MI2_CurrentCorpseIndex = MI2_NewCorpseIdx
	end

	if MI2_CurrentCorpseIndex then
		MI2_RecentCorpses[MI2_CurrentCorpseIndex] = corpseId
		if not corpseId then
			MI2_CurrentCorpseIndex = nil
		end
	end
end -- MI2_StoreCorpseId()


-----------------------------------------------------------------------------
-- MI2_CheckForCorpseReopen()
--
-- Check if the corpse for the given mob index is being reopened.
-- This is done by calculating a (hopefully) unique corpse ID and adding
-- it to the list if it is a new corpse ID. 
-----------------------------------------------------------------------------
local function MI2_CheckForCorpseReopen( mobIndex )
	local isReopen = false
	local corpseId = MI2_GetCorpseId( mobIndex )

	-- check if corpse ID is already in the list
	for index, recentCorpseId in MI2_RecentCorpses do
		if recentCorpseId == corpseId then
			MI2_CurrentCorpseIndex = index
			isReopen = true
			break
		end
	end

	-- add corpse ID the the list if it is a new one
	if corpseId and not isReopen then
		MI2_StoreCorpseId( corpseId, 1 )
	end

	return isReopen
end -- MI2_CheckForCorpseReopen()


-----------------------------------------------------------------------------
-- MI2_EventLootOpened()
--
-- WoW event notification that loot frame has been opened
-----------------------------------------------------------------------------
function MI2_EventLootOpened( )
	local index = MI2_Target.mobIndex or MI2_LastTargetIdx
	local mobData = MI2_CurrentTargets[index]
	local numLootItems = GetNumLootItems()

	MI2_CurrentCorpseIndex = nil
	MI2_LootFrameOpen = true

	-- if there is a target it must be a dead one, the loot must be mob loot
	-- reject non empty loots without target (empty loots opened by "QuickLoot" have no target)
	if not mobData or (not MI2_Target.mobIndex and numLootItems > 0)
			or (MI2_Target.mobIndex and not UnitIsDead("target")) or MI2_IsNonMobLoot then
		if MI2_Debug > 0 then chattext( "M2DBG: non Mob loot detected, nonMobFlag="..tostring(MI2_IsNonMobLoot) ) end
		MI2_IsNonMobLoot = false
		return
	end

	-- check if this is a known corpse being reopened, reopened corpses
	-- can (and must) be ignored because they have already been fully processed
	if MI2_CheckForCorpseReopen(index) then
		if MI2_Debug > 0 then chattext( "M2DBG: corpse REOPEN detected" ) end
		return
	end	

	-- record all loot found on the corpse (called each time to catch skinning))
	-- record location where Mob has been looted
	local skinningLoot = MI2_RecordAllLootItems( index, mobData )
	MI2_RecordLocation( index )
	if not skinningLoot then
		MI2_RecordLooting( mobData, numLootItems )
	end

	-- process target data right away if loots and kills are balanced
	if mobData.loots == mobData.kills or skinningLoot then
		MI2_ProcessTargetTable()
	end
end -- MI2_EventLootOpened()


-----------------------------------------------------------------------------
-- MI2_EventLootSlotCleared()
--
-- WoW event notification that one loot item has been looted.
-- This results in a new corpse ID which must be stored for corpse reopen
-- detection
-----------------------------------------------------------------------------
function MI2_EventLootSlotCleared( )
	if MI2_CurrentCorpseIndex then
		MI2_StoreCorpseId( MI2_GetCorpseId(MI2_Target.mobIndex) )
	end
end -- MI2_EventLootSlotCleared
-----------------------------------------------------------------------------


-----------------------------------------------------------------------------
-- MI2_EventLootClosed()
--
-- Event handler for WoW event that the loot window has been closed.
-- This is used to catch empty loots when using auto-loot (Shift+RightClick)
-- In this case "LOOT_CLOSED" is the only loot event that fires
-----------------------------------------------------------------------------
function MI2_EventLootClosed( )
	local mobIndex = MI2_Target.mobIndex
	if mobIndex and not MI2_LootFrameOpen then
		local mobData = MI2_NewMobTarget( mobIndex )
		MI2_RecordLooting( mobData, 0 )
		MI2_ProcessTargetTable()
	end
	MI2_LootFrameOpen = false
end -- MI2_EventLootClosed


-----------------------------------------------------------------------------
-- MI2_GetLootItemString()
--
-- Get and return a string describing a specific loot item.
-- The loot item is identified by its item ID.
-- The color for the string is returned as well
-----------------------------------------------------------------------------
function MI2_GetLootItemString( itemID )
	local itemString = MI2_ItemNameTable[itemID] or tostring(itemID)
	local color

	-- extract quality from string
	local s,e, quality = string.find( itemString, "/(%d+)" )
	if s then itemString = string.sub( itemString, 1, s-1 ) end
	if quality then color = MI2_QualityColor[tonumber(quality)] end

	return itemString, (color or mifontLightRed)
end -- MI2_GetLootItemString()


-----------------------------------------------------------------------------
-- MI2_AddItemsToTooltip()
--
-- Add one loot item description line to the tooltip. Item description
-- texts can optionally be shortened. Skinning loot uses skinned counter
-- instead of looted counter.
-----------------------------------------------------------------------------
local function MI2_AddOneItemToTooltip( mobData, itemID, amount, useFilter )
	local itemText, itemColor = MI2_GetLootItemString( itemID )

	-- apply item filter is requested
	if useFilter then
		if MobInfoConfig.ItemFilter ~= ""  then
			local itemNotOK = string.find( string.lower(itemText), string.lower(MobInfoConfig.ItemFilter) ) == nil
			if itemNotOK then return end
		end
	else
		itemColor = "* "..itemColor -- prefix for cloth and skinning loot
	end

	-- shorten item text to keep tooltip reasonably small
	local shortItemNames = true
	if shortItemNames and string.len(itemText) > 35 then
		itemText = string.sub(itemText,1,35).."..."
	end
	itemText = itemText..": "..amount

	local totalAmount = mobData.loots
	if miSkinLoot[itemID] then
		totalAmount = mobData.skinCount
	end
	if totalAmount and totalAmount > 0 then
		itemText = itemText.." ("..ceil(amount/totalAmount*100).."%)"  
	end
	
	GameTooltip:AddLine( itemColor..itemText )
end -- MI2_AddItemsToTooltip


-----------------------------------------------------------------------------
-- MI2_AddItemsToTooltip()
--
-- Add the list of items to the Mob tooltip. This function must be
-- called only for mobs that exist and that have an existing item list.
-- The item list gets printed in three parts: first all real non cloth and
-- non skinning loot items, then the skinning and then the cloth items.
-- The parts can be enabled/disabled separately.
--
-- Notoriously similar and numerous items that radically increase tooltip
-- size without being of much (if any) interest will be collapsed into
-- just one item (example: "Green Hills of Stranglethorn" pages).
-----------------------------------------------------------------------------
local function MI2_AddItemsToTooltip( mobData )
	local skinList = {}
	local clothList = {}
	local collapsedList = {}

	-- collapse almost identical items into one item
	for itemID, amount in mobData.itemList do
		if MI2_ItemCollapseList[itemID] then
			local collapsedID = MI2_ItemCollapseList[itemID]
			collapsedList[collapsedID] = (collapsedList[collapsedID] or 0) + amount
		end
	end

	-- first add all non cloth and non skin items to tooltip (apply item filter)
	for itemID, amount in mobData.itemList do
		local isSkin = miSkinLoot[itemID]
		local isCloth = miClothLoot[itemID]
		if isSkin then
			skinList[itemID] = amount
		elseif isCloth then
			clothList[itemID] = amount
		elseif MobInfoConfig.ShowItems == 1 and not MI2_ItemCollapseList[itemID] then
			MI2_AddOneItemToTooltip( mobData, itemID, amount, true )
		end
	end

	-- add collapsed items
	for itemID, amount in collapsedList do
		MI2_AddOneItemToTooltip( mobData, itemID, amount, true )
	end

	if MobInfoConfig.ShowClothSkin == 1 then
		-- add all cloth and skinning items to tooltip
		for itemID, amount in skinList do
			MI2_AddOneItemToTooltip( mobData, itemID, amount, false )
		end

		-- add all cloth and skinning items to tooltip
		for itemID, amount in clothList do
			MI2_AddOneItemToTooltip( mobData, itemID, amount, false )
		end
	end
end -- MI2_AddItemsToTooltip


-----------------------------------------------------------------------------
-- MI2_AddLocationToTooltip()
--
-- Add the Mob location to the tooltip. Mob location always uses an entire
-- tooltip line.
-----------------------------------------------------------------------------
local function MI2_AddLocationToTooltip( location, showFullLocation )
	local x = floor( (location.x1 + location.x2) / 2 )
	local y = floor( (location.y1 + location.y2) / 2 )
	local zone = MI2_Zones[location.c][location.z]
	if zone then
		if showFullLocation then
			GameTooltip:AddLine( mifontGold..MI_TXT_LOCATION..mifontWhite..zone.." ("..x.."/"..y..")" )
		else
			GameTooltip:AddLine( mifontGold..MI_TXT_LOCATION..mifontWhite..zone )
		end
	end
end -- MI2_AddLocationToTooltip()


-----------------------------------------------------------------------------
-- MI2_CreateNormalTooltip()
--
-- add all collected mob data to the game tooltip, data is only added if
-- corresponding "Show" flag is set
-----------------------------------------------------------------------------
local function MI2_CreateNormalTooltip( mobData, mobIndex, showFullLocation )
	local copperAvg, itemValueAvg
	local addEmptyLine = 0
	
	if mobData.class and MobInfoConfig.ShowClass == 1 then
		GameTooltip:AddDoubleLine( mifontGold..MI_TXT_CLASS, mifontWhite..mobData.class )
	end

	if mobData.healthCur and MobInfoConfig.ShowHealth == 1 then
		GameTooltip:AddDoubleLine( mifontGold..MI_TXT_HEALTH, mifontWhite..mobData.healthCur.." / "..mobData.healthMax )
		MI2_HealthLine = GameTooltip:NumLines()
	end

	if mobData.manaMax and mobData.manaMax > 0 and MobInfoConfig.ShowMana == 1 then
		GameTooltip:AddDoubleLine( mifontGold..MI_TXT_MANA, mifontWhite..mobData.manaCur.." / "..mobData.manaMax )
		MI2_ManaLine = GameTooltip:NumLines()
	end

	-- exit right here if mob does not exist in database
	if not mobData.color then
		return
	end
	
	local mobGivesXp = not (mobData.color.r == 0.5  and  mobData.color.g == 0.5  and  mobData.color.b == 0.5)
	if mobGivesXp and mobData.xp then
		if MobInfoConfig.ShowXp == 1 then
			GameTooltip:AddDoubleLine( mifontGold..MI_TXT_XP, mifontWhite..mobData.xp )
		end 
		if MobInfoConfig.ShowNo2lev == 1 then
			GameTooltip:AddDoubleLine( mifontGold..MI_TXT_TO_LEVEL, mifontWhite..mobData.mob2Level )
		end 
	end

	if (mobData.minDamage or mobData.dps) and MobInfoConfig.ShowDamage == 1 then 
		GameTooltip:AddDoubleLine( mifontGold..MI_TXT_DAMAGE, mifontWhite..(mobData.minDamage or 0).."-"..(mobData.maxDamage or 0).."  ["..(mobData.dps or 0).."]" )
	end

	addEmptyLine = MobInfoConfig.ShowBlankLines

	if  MobInfoConfig.CombinedMode == 1  and  MobInfoConfig.ShowCombined == 1  then
		if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
		GameTooltip:AddLine( mifontGray.."["..MI_TXT_COMBINED..mobData.combinedStr.."]" )
	end

	if mobData.kills and MobInfoConfig.ShowKills == 1 then
		if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
		GameTooltip:AddDoubleLine( mifontGold..MI_TXT_KILLS, mifontWhite..mobData.kills )
	end          

	if  mobData.loots  and  MobInfoConfig.ShowLoots == 1  then
		if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
		GameTooltip:AddDoubleLine( mifontGold..MI_TXT_TIMES_LOOTED, mifontWhite..mobData.loots )
	end

	if  mobData.emptyLoots  and  MobInfoConfig.ShowEmpty == 1  then
		local emptyLootsStr = mifontWhite..mobData.emptyLoots
		if  mobData.loots  then
			emptyLootsStr = emptyLootsStr.." ("..ceil((mobData.emptyLoots/mobData.loots)*100).."%) "
		end
		if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
		GameTooltip:AddDoubleLine( mifontGold..MI_TXT_EMPTY_LOOTS, emptyLootsStr )
	end

	if mobData.clothCount and MobInfoConfig.ShowCloth == 1 then
		local clothStr = mifontWhite..mobData.clothCount
		if mobData.loots then
			clothStr = clothStr.." ("..ceil((mobData.clothCount/mobData.loots)*100).."%) "
		end
		if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
		GameTooltip:AddDoubleLine( mifontGold..MI_TXT_CLOTH_DROP, clothStr )
	end

	if mobData.copper and mobData.loots then
		copperAvg = ceil( mobData.copper / mobData.loots )
		if MobInfoConfig.ShowCoin == 1 then
			if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
			GameTooltip:AddDoubleLine(mifontGold..MI_TXT_COIN_DROP,mifontWhite..copper2text(copperAvg))
		end
	end

	if mobData.itemValue and mobData.loots then
		itemValueAvg = ceil( mobData.itemValue / mobData.loots )
		if MobInfoConfig.ShowIV == 1 then
			if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
			GameTooltip:AddDoubleLine(mifontGold..MI_TEXT_ITEM_VALUE,mifontWhite..copper2text(itemValueAvg))
		end
	end

	local totalValue = (copperAvg or 0) + (itemValueAvg or 0)
	if totalValue > 0 and MobInfoConfig.ShowTotal == 1 then
		if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
		GameTooltip:AddDoubleLine(mifontGold..MI_TXT_MOB_VALUE,mifontWhite..copper2text(totalValue))
	end

	if  mobData.qualityStr ~= ""  and  MobInfoConfig.ShowQuality == 1  then
		if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
		GameTooltip:AddDoubleLine(mifontGold..MI_TXT_QUALITY, mobData.qualityStr)
	end

	if mobData.location and MobInfoConfig.ShowLocation == 1 then
		if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
		MI2_AddLocationToTooltip( mobData.location, showFullLocation )
	end

	addEmptyLine = MobInfoConfig.ShowBlankLines

	if mobData.itemList and (MobInfoConfig.ShowItems == 1 or MobInfoConfig.ShowClothSkin == 1) then
		if addEmptyLine == 1 then GameTooltip:AddLine("\n") addEmptyLine = 0 end
		MI2_AddItemsToTooltip( mobData )
	end

  -----------------------------------------------------------------------
  -- debugging code : append actual database contents to end of tooltip
  -- enabled by setting local vairable "MI2_Debug"
  if MI2_Debug > 1 then
  GameTooltip:AddLine("----------------  D e b u g   I n f o  ----------------")
  GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."index",mobIndex)
  if MobInfoDB[mobIndex] and MI2_PlayerName then
    if MobInfoDB[mobIndex].bi then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."[lt,el,cp,iv,cc,xp,mt]",mifontWhite..MobInfoDB[mobIndex].bi) end
    if MobInfoDB[mobIndex].qi then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."[r1,r2,r3,r4,r5]",mifontWhite..MobInfoDB[mobIndex].qi) end
    if MobInfoDB[mobIndex][MI2_PlayerName] then GameTooltip:AddDoubleLine("[DBG] "..mifontGold.."[kl,dmin,dmax,dps]",mifontWhite..MobInfoDB[mobIndex][MI2_PlayerName]) end
  end end
  -- end of debugging code
  -----------------------------------------------------------------------
end -- MI2_CreateNormalTooltip()


-----------------------------------------------------------------------------
-- MI2_CreateCompactTooltip()
--
-- add all collected mob data to the game tooltip, data is only added if
-- corresponding "Show" flag is set
-----------------------------------------------------------------------------
local function MI2_CreateCompactTooltip( mobData, mobIndex, showFullLocation )
	local firstLine = GameTooltip:NumLines() + 1

	if (mobData.healthCur or mobData.manaMax and mobData.manaMax > 0)  
			and (MobInfoConfig.ShowHealth == 1 or MobInfoConfig.ShowMana == 1) then
		GameTooltip:AddDoubleLine( mifontGold.."HP    "..mifontWhite..(mobData.healthCur or 0).." / "..(mobData.healthMax or 0), mifontWhite..(mobData.manaCur or 0).." / "..(mobData.manaMax or 0)..mifontGold.." Mana" )
		MI2_HealthLine = GameTooltip:NumLines()
		if mobData.manaMax and mobData.manaMax > 0 then
			MI2_ManaLine = MI2_HealthLine
		end
	end

	-- exit right here if mob does not exist in database
	if not mobData.color then
		return
	end

	local mobGivesXp = not (mobData.color.r == 0.5  and  mobData.color.g == 0.5  and  mobData.color.b == 0.5)
	if mobGivesXp and mobData.xp and (MobInfoConfig.ShowXp == 1 or MobInfoConfig.ShowNo2lev == 1) then
		GameTooltip:AddDoubleLine( mifontGold.."XP    "..mifontWhite..mobData.xp, mifontWhite..mobData.mob2Level..mifontGold.." KtL    " )
	end

	if (mobData.minDamage or mobData.dps) and MobInfoConfig.ShowDamage == 1 then
		GameTooltip:AddDoubleLine( mifontGold.."Dmg "..mifontWhite..(mobData.minDamage or 0).."-"..(mobData.maxDamage or 0), mifontWhite..(mobData.dps or 0)..mifontGold.." Dps   " )
	end

	if  MobInfoConfig.CombinedMode == 1  and  MobInfoConfig.ShowCombined == 1  then
		GameTooltip:AddLine( mifontGray.."["..MI_TXT_COMBINED..mobData.combinedStr.."]" )
	end

	if (mobData.kills or mobData.loots) and (MobInfoConfig.ShowKills == 1 or MobInfoConfig.ShowLoots == 1)  then
		GameTooltip:AddDoubleLine( mifontGold.."Kills  "..mifontWhite..(mobData.kills or 0), mifontWhite..(mobData.loots or 0)..mifontGold.." Loots" )
	end          

	if  (mobData.emptyLoots or mobData.clothCount) and (MobInfoConfig.ShowCloth == 1 or MobInfoConfig.ShowEmpty == 1)  then
		local emptyLootsStr = mifontWhite..(mobData.emptyLoots or 0)
		if  mobData.loots  then
			emptyLootsStr = emptyLootsStr.." ("..ceil(((mobData.emptyLoots or 0)/mobData.loots)*100).."%) "
		end
		local clothStr = mifontWhite..(mobData.clothCount or 0)
		if mobData.loots then
			clothStr = clothStr.." ("..ceil(((mobData.clothCount or 0)/mobData.loots)*100).."%) "
		end
		GameTooltip:AddDoubleLine( mifontGold.."CL     "..mifontWhite..clothStr, mifontWhite..emptyLootsStr..mifontGold.." EL      " )
	end

	if (mobData.copper or mobData.itemValue) and mobData.loots and MobInfoConfig.ShowTotal == 1 then
		local copperAvg = ceil( (mobData.copper or 0) / mobData.loots )
		local itemValueAvg = ceil( (mobData.itemValue or 0) / mobData.loots )
		local totalValue = copperAvg + itemValueAvg
		if totalValue > 0 then
			GameTooltip:AddDoubleLine( mifontGold.."Val    "..mifontWhite..copper2text(totalValue), mifontWhite..copper2text(copperAvg)..mifontGold.." Coins" )
		end
	end

	if  mobData.qualityStr ~= ""  and  MobInfoConfig.ShowQuality == 1  then
		GameTooltip:AddLine( mifontGold.."Q      "..mifontWhite..mobData.qualityStr )
	end

	if mobData.location and MobInfoConfig.ShowLocation == 1 then
		MI2_AddLocationToTooltip( mobData.location, showFullLocation )
	end
	
	if mobData.itemList and (MobInfoConfig.ShowItems == 1 or MobInfoConfig.ShowClothSkin == 1) then
		MI2_AddItemsToTooltip( mobData )
	end
end -- MI2_CreateCompactTooltip()


-----------------------------------------------------------------------------
-- MI2_BuildQualityString()
--
-- Build a string drepresenting the loot quality overview for the given mob.
-----------------------------------------------------------------------------
local function MI2_BuildQualityString( mobData )
	local quality, chance
	local rt = mobData.loots or 1
 
	mobData.qualityStr = ""
	for idx = 1, 5 do
		quality = mobData["r"..idx]
		if quality then
			chance = ceil( quality / rt * 100.0 )
			if chance > 100 then chance = 100 end
			mobData.qualityStr = mobData.qualityStr..MI2_QualityColor[idx]..quality.."("..chance.."%) "
		end
	end
end  -- MI2_CreateQualityString


-----------------------------------------------------------------------------
-- MI2_BuildMobInfoTooltip()
--
-- create game tooltip contents
-- this includes handling the combined mode where data for several mobs
-- with same name but different levels has to be added up
-----------------------------------------------------------------------------
function MI2_BuildMobInfoTooltip( mobName, mobLevel, showFullLocation )
	-- do not add anything to the tooltip for players
	if  UnitIsPlayer("mouseover")  then  return  end

	-- get mob data for hovered mob
	local mobData = MI2_GetMobData( mobName, mobLevel, "mouseover" )
	mobData.combinedStr = ""

	MI2_MouseoverIndex = mobName..":"..mobLevel

	-- handle combined Mob mode : try to find the other Mobs with same
	-- name but differing level, add their data to the tooltip data
	if  MobInfoConfig.CombinedMode == 1 and mobLevel > 0 then
		for levelToCombine = mobLevel-3, mobLevel+3, 1 do
			if levelToCombine ~= mobLevel  then
				local dataToCombine = MI2_GetMobData( mobName, levelToCombine )
				if dataToCombine.color then
					MI2_AddTwoMobs( mobData, dataToCombine )
					mobData.combinedStr = mobData.combinedStr.." L"..levelToCombine
					mobData.color = GetDifficultyColor( levelToCombine )
				end
			else
				mobData.combinedStr = mobData.combinedStr.." L"..levelToCombine
			end
		end
	end

	-- if there is data about the "mouseover" mob in the target table it has to be added
	local dataToCombine = MI2_CurrentTargets[MI2_MouseoverIndex]
	if dataToCombine then
		MI2_AddTwoMobs( mobData, dataToCombine )
		if not mobData.color then mobData.color = {r=1.0;b=1.0;c=1.0} end
	end

	-- calculate number of mobs to next level based on mob experience
	if mobData.xp then
		local xpCurrent = UnitXP("player") + mobData.xp
		local xpToLevel = UnitXPMax("player") - xpCurrent
		mobData.mob2Level = ceil(abs(xpToLevel / mobData.xp))+1
	end

	-- display the Mob data to the game tooltip
	MI2_BuildQualityString( mobData )
	if MobInfoConfig.CompactMode == 1 then
		MI2_CreateCompactTooltip( mobData, MI2_MouseoverIndex, showFullLocation )
	else
		MI2_CreateNormalTooltip( mobData, MI2_MouseoverIndex, showFullLocation )
	end
end -- MI2_BuildMobInfoTooltip()


-----------------------------------------------------------------------------
-- MI2_DebugShowContainerItemInfo()
--
-- Show debugging info for the current hovered container item.
-- The info is added to the game tooltip.
-- This function is called only if "MI2_DebugItems > 0"
-----------------------------------------------------------------------------
local function MI2_DebugShowContainerItemInfo()
	local frame = GetMouseFocus()
	if frame then
		local frameName = (frame:GetName() or "")
		local _,_,parenFrameName, num = string.find( frameName, "(.+)Item(%d+)" )
		if parenFrameName and num then
			local parentFrame = getglobal( parenFrameName )
			if parentFrame then
				local link = GetContainerItemLink( parentFrame:GetID(), frame:GetID() )
				local _, _, itemID = string.find((link or ""), "|Hitem:(%d+):(%d+):(%d+):")
				if IsControlKeyDown() then GameTooltip:AddLine( mifontSubWhite.."[frame="..frameName..",item="..link.."]" ) end
				if itemID then
					local itemValue = MI2_BasePrices[tonumber(itemID)]
					if itemValue then
						GameTooltip:AddLine( mifontSubWhite.."[itemID="..itemID..",price="..itemValue.."]" )
					else
						GameTooltip:AddLine( mifontRed.."** NO PRICE ** "..mifontMageta.."item="..link..mifontMageta..",itemID="..itemID )
					end
					GameTooltip:Show()
				end
			end
		end
	end
end -- MI2_DebugShowContainerItemInfo()


-----------------------------------------------------------------------------
-- MI2_BuildItemDataTooltip()
--
-- Build the additional game tooltip content for a given item name.
-- If the item is a known loot item this function will add the names of
-- all Mobs that drop the item to the game tooltip. Each Mob name will
-- appear on its own line.
-----------------------------------------------------------------------------
function MI2_BuildItemDataTooltip( itemName )

	if MI2_DebugItems > 0 then MI2_DebugShowContainerItemInfo() end

	-- get the table of all Mobs that drop the item, exit if none
	local itemFound = MI2_XRefItemTable[itemName]
	if not itemFound then return false end

	-- Create a list of mobs dropping this item that is indexed by only
	-- the base Mob name. For each Mob calculate the chance to drop.
	-- Create a second list referencing the same data that is indexed
	-- numerically so that it can then be sorted by chance to get.
	local numMobs = 0
	local resultList = {}
	local sortList = {}
	for mobIndex, itemAmount in itemFound do
		local mobData = {}
		MI2_DecodeBasicMobData( nil, mobData, mobIndex )

		local mobName, mobLevel = MI2_GetIndexComponents( mobIndex )
		local itemData = resultList[mobName]
		if not itemData then
			numMobs = numMobs + 1
			itemData = { name = mobName, loots = 0, count = 0 }
			resultList[mobName] = itemData
			sortList[numMobs] = itemData
		end

		itemData.loots = itemData.loots + (mobData.loots or 0)
		itemData.count = itemData.count + itemAmount
		if itemData.loots > 0 then
			itemData.chance = floor(100.0 * itemData.count / itemData.loots + 0.5)
			if itemData.chance > 100 then itemData.chance = 100 end
			if itemData.loots < 5 then
				itemData.rating = itemData.chance + itemData.loots * 1000
			else
				itemData.rating = itemData.chance + 5000
			end
		else
			itemData.chance = itemData.count
			itemData.rating = itemData.chance
		end
	end

	-- sort list of Mobs by chance to get
	table.sort( sortList, function(a,b) return (a.rating > b.rating) end  )

	-- add Mobs to tooltip
	GameTooltip:AddLine( mifontLightBlue..MI_TXT_DROPPED_BY..numMobs.." Mobs:" )
	if numMobs > 8 then numMobs = 8 end
	for idx = 1, numMobs do
		local data = sortList[idx]
		if data.loots > 0 then
			GameTooltip:AddDoubleLine( mifontLightBlue.."  "..data.name, mifontWhite..data.chance.."% ("..data.count.."/"..data.loots..")" )
		else
			GameTooltip:AddDoubleLine( mifontLightBlue.."  "..data.name, mifontWhite..data.chance )
		end
	end
	if sortList[9] then
		GameTooltip:AddLine( mifontLightBlue.."  [...]" )
	end

	return true
end -- MI2_BuildItemDataTooltip()


-----------------------------------------------------------------------------
-- MI2_DpsCalculation()
--
-- Calculate an updated DPS (damage per second) based on the current target
-- data in "MI2_Target" and the new damage value given as parameter.
-----------------------------------------------------------------------------
function MI2_DpsCalculation( damage, contextInfo )

if not damage then
	chattext( "MI2_ERROR: chat message parse error in "..contextInfo )
	return
end

	-- calculate and update DPS for target
	if not MI2_Target.FightStartTime then
		MI2_Target.FightStartTime = GetTime() - 1.0
		MI2_Target.FightEndTime = GetTime()
		MI2_Target.FightDamage = damage
	elseif MI2_Target.FightEndTime then
		MI2_Target.FightEndTime = GetTime()
		MI2_Target.FightDamage = MI2_Target.FightDamage + damage
	end
end  -- MI2_DpsCalculation()


-----------------------------------------------------------------------------
-- MI2_EventSelfMelee()
--
-- handler for event CHAT_MSG_COMBAT_SELF_HITS
-- handles normal and critical melee damage
-----------------------------------------------------------------------------
function MI2_EventSelfMelee( )
	local dmgText = arg1

	-- normal melee damage
	for  creature, damage in string.gfind( dmgText, MI_PARSE_SELF_MELEE ) do
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_MELEE" )
		return
	end

	-- critical melee damage
	for  creature, damage in string.gfind( dmgText, MI_PARSE_SELF_MELEE_CRIT ) do
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_MELEE_CRIT" )
		return
	end
end  -- MI2_EventSelfMelee()


-----------------------------------------------------------------------------
-- MI2_EventSelfSpell()
--
-- handler for event "CHAT_MSG_SPELL_SELF_DAMAGE"
-- handles normal and critical spell damage and damage done by bows/guns
-----------------------------------------------------------------------------
function MI2_EventSelfSpell( )
	local dmgText = arg1

	-- normal spell damage
	for  spell, creature, damage in string.gfind( dmgText, MI_PARSE_SELF_SPELL ) do
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_SPELL" )
		return
	end

	-- critical spell damage
	for  spell, creature, damage in string.gfind( dmgText, MI_PARSE_SELF_SPELL_CRIT ) do
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_SPELL_CRIT" )
		return
	end

	-- damage done by bows/guns
	for  spell, creature, damage in string.gfind( dmgText, MI_PARSE_SELF_BOW ) do
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_BOW" )
		return
	end

	-- critical damage done by bows/guns (for German this will get parsed above as "normal spell")
	for  spell, creature, damage in string.gfind( dmgText, MI_PARSE_SELF_BOW_CRIT ) do
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_BOW" )
		return
	end
end -- MI2_EventSelfSpell()


-----------------------------------------------------------------------------
-- MI2_EventSelfPet()
--
-- handler for event "CHAT_MSG_COMBAT_PET_HITS" and "CHAT_MSG_SPELL_PET_DAMAGE"
-- handles normal and critical melee/spell damage done by players pet
-----------------------------------------------------------------------------
function MI2_EventSelfPet( )
	local dmgText = arg1

	-- damage done by players pet
	for  petName, creature, damage in string.gfind( dmgText, MI_PARSE_SELF_PET ) do
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_PET" )
		return
	end

	-- critical damage done by players pet
	for  petName, creature, damage in string.gfind( dmgText, MI_PARSE_SELF_PET_CRIT ) do
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_PET_CRIT" )
		return
	end

	-- damage done by spells of players pet
	for  petName, spell, creature, damage in string.gfind( dmgText, MI_PARSE_SELF_PET_SPELL ) do
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_PET_SPELL" )
		return
	end

	-- critical damage done by spells of players pet
	for  petName, spell, creature, damage in string.gfind( dmgText, MI_PARSE_SELF_PET_SPELL_CRIT) do
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_PET_SPELL_CRIT" )
		return
	end
end -- MI2_EventSelfPet()


-----------------------------------------------------------------------------
-- MI2_EventSpellPeriodic()
--
-- handler for event "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE"
-- handles periodic damage done by spells
-----------------------------------------------------------------------------
function MI2_EventSpellPeriodic( )
	local dmgText = arg1

	-- periodic spell damage
	for  dummy, damage, damageType, spell in string.gfind( dmgText, MI_PARSE_SELF_SPELL_PERIODIC ) do
		if GetLocale()=="zhTW" then
			spell, dummy, damage, damageType = dummy, damage, damageType, spell;
		end
		MI2_DpsCalculation( tonumber(damage), "PARSE_SELF_SPELL_PERIODIC" )
		return
	end
end -- MI2_EventSpellPeriodic()


-----------------------------------------------------------------------------
-- MI2_EventCreatureDiesXP()
--
-- event handler for the chat message telling us that a creature died
-- and gave us XP points
-----------------------------------------------------------------------------
function MI2x_EventCreatureDiesXP()
	local idx = MI2_LastTargetIdx

	-- capture kills giving XP
	-- sometimes the kill deselects current target, sometimes it doesn't
	-- yet to properly record a kill the idx (ie. name and level) is required
	for creatureName, xp in string.gfind(arg1, MI_MOB_DIES_WITH_XP ) do
		if not idx or creatureName == MI2_Target.name then
			idx = MI2_Target.index
		end
		if idx then
			MI2_RecordKill( idx, tonumber(xp) )
			MI2_RecordLocation( idx )
		end
	end
end -- MI2_EventCreatureDiesXP()


-----------------------------------------------------------------------------
-- MI2_CreatureDiesHostile()
--
-- Event handler for chat message telling me that a hostile creature in
-- my vicinity has died. The kill will only get counted if my current
-- targets name is identical to the name of the creature that died, and if
-- I have actually been in a fight with the mob.
-----------------------------------------------------------------------------
function MI2x_CreatureDiesHostile()
	local index = MI2_Target.mobIndex
	if index and UnitIsDead("target") then
		-- kills without XP never deselect the current target
		for creatureName in string.gfind(arg1, MI_MOB_DIES_WITHOUT_XP ) do
			if creatureName == MI2_Target.name and MI2_Target.FightStartTime then
				MI2_RecordKill( index, 0 )
				MI2_RecordLocation( index )
			end
		end
	end
end -- MI2_CreatureDiesHostile()


-----------------------------------------------------------------------------
-- MI2_UpdateMobInfoState()
--
-- Enable or disable all Mob ToolTip options depending on state of
-- "DisableMobInfo". Update event handlers accordingly.
-----------------------------------------------------------------------------
function MI2_UpdateMobInfoState()
	local children = { MI2_FrmTooltipOptions:GetChildren() }

	-- update MobInfo options dialog
	for index, frame in children do
		if frame ~= MI2_OptDisableMobInfo and frame ~= MI2_OptItemFilter then
			if MobInfoConfig.DisableMobInfo == 0 then
				frame:Enable()
				getglobal(frame:GetName().."Text"):SetTextColor( 1.0, 0.8, 0.0 )
			else
				frame:Disable()
				getglobal(frame:GetName().."Text"):SetTextColor( 0.5, 0.5, 0.5 )
			end
		end
	end

	MI2_InitializeEventTable()
end  -- MI2_UpdateMobInfoState()

-----------------------------------------------------------------------------
-- MI2_UpdateTooltipHealthMana()
--
-- Update the health and mana values in the Mob tooltip, if they exist.
-----------------------------------------------------------------------------
function MI2_UpdateTooltipHealthMana( healthCur, healthMax )
	local tooltip = "GameTooltip"
	if TipBuddyTooltip then tooltip = "TipBuddyTooltip" end
	if MI2_HealthLine and healthCur then
		local healthText = healthCur.." / "..healthMax
		if MobInfoConfig.CompactMode == 1 then
			local healthLine = getglobal(tooltip.."TextLeft"..MI2_HealthLine)
			healthLine:SetText( mifontGold.."HP    "..mifontWhite..healthText )
		else
			local healthLine = getglobal(tooltip.."TextRight"..MI2_HealthLine)
			healthLine:SetText( mifontWhite..healthText )
		end
	end

	if MI2_ManaLine then
		local manaText = mifontWhite..UnitMana("mouseover").." / "..UnitManaMax("mouseover")
		local manaLine = getglobal(tooltip.."TextRight"..MI2_ManaLine)
		if MobInfoConfig.CompactMode == 1 then
			manaLine:SetText( manaText..mifontGold.." Mana" )
		else
			manaLine:SetText( manaText )
		end
	end
end -- MI2_UpdateTooltipHealthMana()

