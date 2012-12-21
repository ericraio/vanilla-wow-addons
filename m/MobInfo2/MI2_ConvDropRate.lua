--
-- MI2_ConvDropRate.lua
--
-- author: NakorNH
-- this converter was written and submitted by NakorNH
--
-- DropRate data converter for the MobInfo2 AddOn
-- This converter will convert all Mobs found in the DropRate database
-- and convert them into entries for the MobInfo2 database. Item data
-- can only be converted if the item can be found in either the
-- ItemSync or KC_Items or LootLink databases (thus either of these
-- AddOns must be installed as well).
--
-- Using LootLink is recommended for the conversion because AddOns sites
-- like "http://ui.worldofwar.net" host huge LootLink item databases
-- that ensure a high conversion success rate. After successful
-- conversion LootLink can be uninstalled.
--


local MI_CONVERTER = mifontLightBlue.."<MobInfo DR Convert>"..mifontWhite.." "
local MI_MOBSFOUND = " Mobs found in DropRate data,"
local MI_NEWMOBSFOUND = " new Mobs added to database,"
local MI_EXISTINGMOBS = " existing Mobs expanded,"
local MI_PARTIALMOBS = " Mobs partially converted,"
local MI_SKIPPEDITEMS = " unknown items skipped,"
local MI_ADDEDITEMS = " items added to database,"


-----------------------------------------------------------------------------
-- MI2_StartDropRateConversion()
--
-- Scans the DropRate database. Then converts the data and adds it to MobInfo2 database
-----------------------------------------------------------------------------
function MI2_StartDropRateConversion()
	local totalMobs = 0
	local newMobsFound = 0
	local mobsExtended = 0
	local partialMobs = 0
	local itemsSkipped = 0
	local itemsFound = 0

	chattext( MI_CONVERTER.."DropRate conversion started ..." )
	
	if not drdb then
		chattext( "DropRate database not found" )
		return
	end
	
	for mobName, value in drdb do
		local notCompleteMob = 0
		local newMobData = {}
		local drMobLevel
		for index , value2 in value do
			if index == "level" then
				drMobLevel = value2
				totalMobs = totalMobs + 1
			end
		end	
		
		if drMobLevel then
			for index, value2 in value do
				local drItemID = -1
				if index == "level" then
					drMobLevel = value2
				elseif index == "looted" then
					newMobData.loots = value2
					drdb[mobName][index] = nil
				elseif index == "skinned" then
					newMobData.skinCount = value2
					notItem = 1
					drdb[mobName][index] = nil
				elseif index == "money" then
					newMobData.copper = value2
					drdb[mobName][index] = nil
				else
					drItemID = (MI2_drFindItemID(index) or 0)
				end

				-- process all item data antries where an item ID code could be found
				if drItemID > 0 then
					-- process item quality for item quality overview
					local drQuality = dritems[index]
					if drQuality == 0 then
						newMobData.r1 = (newMobData.r1 or 0) + 1
					elseif drQuality == 1 then
						newMobData.r2 = (newMobData.r2 or 0) + 1
					elseif drQuality == 2 then
						newMobData.r3 = (newMobData.r3 or 0) + 1
					elseif drQuality == 3 then
						newMobData.r4 = (newMobData.r4 or 0) + 1
					elseif drQuality == 4 then
						newMobData.r5 = (newMobData.r5 or 0) + 1
					elseif drQuality == -1 then
						drQuality = 1
					end

					-- process item value
					local drItemValue = MI2_FindItemValue( index, drItemID )
					newMobData.itemValue = (newMobData.itemValue or 0) + drItemValue

					-- add item to MobInfo items table
					if MobInfoConfig.SaveItems == 1 and (drQuality + 1) >= MobInfoConfig.ItemsQuality then
						if not newMobData.itemList then newMobData.itemList = {} end
						newMobData.itemList[drItemID] = value2
						if not MI2_ItemNameTable[drItemID] then
							MI2_ItemNameTable[drItemID] = index.."/"..(drQuality + 1)
						end
					end

					drdb[mobName][index] = nil
					itemsFound = itemsFound + 1

				elseif drItemID == 0 then
					notCompleteMob = 1
					itemsSkipped = itemsSkipped + 1
				end
			end -- for

			-- add converted DropRate Mob data to existing MobInfo data
			-- (creates new MobInfo database entry if Mob does not exist)
			local origMobData = MI2_GetMobData(mobName,drMobLevel)
			if origMobData.loots then
				mobsExtended = mobsExtended + 1
			else
				newMobsFound = newMobsFound + 1
			end	
			MI2_AddTwoMobs(newMobData, origMobData)
			MI2x_StoreMobData( newMobData, mobName, drMobLevel, MI2_PlayerName )

			-- check if entire DropRate Mob entry has been converted
			local remainingEntries = 0
			for index in drdb[mobName] do
				if index ~= "level" then
					remainingEntries = remainingEntries + 1
				end
			end
			if remainingEntries == 0 then
				drdb[mobName] = nil
			end
		end
		if notCompleteMob > 0 then
			partialMobs = partialMobs + 1
		end
		
	end

	MI2_BuildXRefItemTable()

	chattext(MI_CONVERTER..totalMobs..MI_MOBSFOUND)
	chattext(MI_CONVERTER..mobsExtended..MI_EXISTINGMOBS)
	chattext(MI_CONVERTER..newMobsFound..MI_NEWMOBSFOUND)
	chattext(MI_CONVERTER..partialMobs..MI_PARTIALMOBS)
	chattext(MI_CONVERTER..itemsFound..MI_ADDEDITEMS)
	chattext(MI_CONVERTER..itemsSkipped..MI_SKIPPEDITEMS) 
end 

-----------------------------------------------------------------------------
-- MI2_StartDropRateConversion()
--
-- Find the itemID for each item in the database
-----------------------------------------------------------------------------
function MI2_drFindItemID(index)
	-- Find item code from ItemSync
	if ISyncDB_Names then
		for ISItemID, ISItemName in ISyncDB_Names do
			if ISItemName == index then
				return ISItemID
			end
		end
	end

	-- Find item code from KC_Items (potentially dangerous : might cause disconnect
	-- when calling "GetItemInfo()" with item ID not known on server)
	if KC_ItemsDB then
		for itemCode, itemInfo in KC_ItemsDB do
			local itemName, itemLink = GetItemInfo(itemCode)
			if itemName then
				if itemName == index then
					return itemCode, itemLink
				end
			end
		end
	end
	
	-- Find item code from LootLink
	if ItemLinks then
		if ItemLinks[index] then
			local lootLinkData = ItemLinks[index].i
			local a,b,itemCode,CDRenchantCode,CDRbonusCode,CDRmiscCode = string.find(lootLinkData, "(%d*):(%d*):(%d*):(%d*)")
			return tonumber(itemCode)
		end
	end
	
	return nil
end -- of MI2_drFindItemID

