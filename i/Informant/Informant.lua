--[[
	Informant
	An addon for World of Warcraft that shows pertinent information about
	an item in a tooltip when you hover over the item in the game.
	3.8.0 (Kangaroo)
	$Id: Informant.lua 912 2006-06-26 13:53:44Z mentalpower $

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]

INFORMANT_VERSION = "3.8.0"
if (INFORMANT_VERSION == "<".."%version%>") then
	INFORMANT_VERSION = "3.7.DEV"
end

-- GLOBAL FUNCTION PROTOTYPES:

local getItem--(itemID);     itemID is the first value in a blizzard hyperlink id
--                           this pattern would extract the id you need:
--                             "item:(%d+):%d+:%d+:%d+"



-- LOCAL FUNCTION PROTOTYPES:
local addLine				-- addLine(text, color)
local clear					-- clear()
local frameActive			-- frameActive(isActive)
local frameLoaded			-- frameLoaded()
local getCatName			-- getCatName(catID)
local getFilter				-- getFilter(filter)
local getFilterVal			-- getFilterVal(type)
local getItem				-- getItem(itemID)
local getRowCount			-- getRowCount()
local nilSafeString			-- nilSafeString(String)
local onEvent				-- onEvent(event)
local onLoad				-- onLoad()
local onVariablesLoaded		-- onVariablesLoaded()
local onQuit				-- onQuit()
local scrollUpdate			-- scrollUpdate(offset)
local setDatabase			-- setDatabase(database)
local setFilter				-- setFilter(key, value)
local setFilterDefaults		-- setFilterDefaults()
local setRequirements		-- setRequirements(requirements)
local setSkills				-- setSkills(skills)
local setVendors			-- setVendors(vendors)
local showHideInfo			-- showHideInfo()
local skillToName			-- skillToName(userSkill)
local split					-- split(str, at)
local tooltipHandler		-- tooltipHandler(funcVars, retVal, frame, name, link, quality, count, price)
local getKeyBindProfile		-- getKeyBindProfile()
local whitespace			-- whitespace(length)

-- LOCAL VARIABLES

local self = {}
local lines = {}
local itemInfo = nil

-- GLOBAL VARIABLES

BINDING_HEADER_INFORMANT_HEADER = _INFM('BindingHeader')
BINDING_NAME_INFORMANT_POPUPDOWN = _INFM('BindingTitle')

InformantConfig = {}

-- LOCAL DEFINES

CLASS_TO_CATEGORY_MAP = {
	[2]  = 1,
	[4]  = 2,
	[1]  = 3,
	[0]  = 4,
	[7]  = 5,
	[6]  = 6,
	[11] = 7,
	[9]  = 8,
	[5]  = 9,
	[15] = 10,
}

local filterDefaults = {
		['all'] = 'on',
		['embed'] = 'off',
		['locale'] = 'default',
		['show-vendor'] = 'on',
		['show-vendor-buy'] = 'on',
		['show-vendor-sell'] = 'on',
		['show-usage'] = 'on',
		['show-stack'] = 'on',
		['show-merchant'] = 'on',
		['show-quest'] = 'on',
		['show-icon'] = 'on',
	}

-- FUNCTION DEFINITIONS

function split(str, at)
	local splut = {}

	if (type(str) ~= "string") then return nil end
	if (not str) then str = "" end
	if (not at)
		then table.insert(splut, str)
	else
		for n, c in string.gfind(str, '([^%'..at..']*)(%'..at..'?)') do
			table.insert(splut, n)
			if (c == '') then break end
		end
	end
	return splut
end

function skillToName(userSkill)
	local skillName = self.skills[tonumber(userSkill)]
	local localized = "Unknown"
	if (skillName) then
		if (_INFM("Skill"..skillName)) then
			localized = _INFM("Skill"..skillName)
		else
			localized = "Unknown:"..skillName
		end
	end
	return localized, skillName
end

function getItem(itemID)
	local baseData = self.database[itemID]
	if (not baseData) then 
		return getItemBasic(itemID)
	end

	local _, _, _, iLevel, sType, _, iCount, _, sTexture = GetItemInfo(itemID)

	local baseSplit = split(baseData, ":")
	local buy = tonumber(baseSplit[1])
	local sell = tonumber(baseSplit[2])
	local class = tonumber(baseSplit[3])
	local quality = tonumber(baseSplit[4])
	local stack = tonumber(iCount) or tonumber(baseSplit[5])
	local additional = baseSplit[6]
	local usedby = baseSplit[7]
	local quantity = baseSplit[8]
	local limited = baseSplit[9]
	local merchantlist = baseSplit[10]
	local cat = CLASS_TO_CATEGORY_MAP[class]

	local dataItem = {
		['buy'] = buy,
		['sell'] = sell,
		['class'] = class,
		['cat'] = cat,
		['quality'] = quality,
		['stack'] = stack,
		['additional'] = additional,
		['usedby'] = usedby,
		['quantity'] = quantity,
		['limited'] = limited,
		['texture'] = sTexture,
		['fullData'] = true,
	}

	local addition = ""
	if (additional ~= "") then
		addition = " - ".._INFM("Addit"..additional)
	end
	local catName = getCatName(cat)
	if (not catName) then
		if (sType) then
			dataItem.classText = sType..addition
		else
			dataItem.classText = "Unknown"..addition
		end
	else
		dataItem.classText = catName..addition
	end

	if (usedby ~= '') then
		local usedList = split(usedby, ",")
		local skillName, localized, localeString
		local usage = ""
		dataItem.usedList = {}
		if (usedList) then
			for pos, userSkill in pairs(usedList) do
				localized = skillToName(userSkill)
				if (usage == "") then
					usage = localized
				else
					usage = usage .. ", " .. localized
				end
				table.insert(dataItem.usedList, localized)
			end
		end
		dataItem.usageText = usage
	end

	local reqSkill = 0
	local reqLevel = 0
	local skillName = ""

	local skillsRequired = self.requirements[itemID]
	if (skillsRequired) then
		local skillSplit = split(skillsRequired, ":")
		reqSkill = skillSplit[1]
		reqLevel = skillSplit[2]
		skillName = skillToName(reqSkill)
	end

	dataItem.isPlayerMade = (reqSkill ~= 0)
	dataItem.reqSkill = reqSkill
	dataItem.reqSkillName = skillName
	dataItem.reqLevel = iLevel or reqLevel

	if (merchantlist ~= '') then
		local merchList = split(merchantlist, ",")
		local vendName
		local vendList = {}
		if (merchList) then
			for pos, merchID in pairs(merchList) do
				vendName = self.vendors[tonumber(merchID)]
				if (vendName) then
					table.insert(vendList, vendName)
				end
			end
		end
		dataItem.vendors = vendList
	end

	dataItem.quests = {}
	dataItem.questCount = 0
	local questItemUse = InformantQuests.usage[itemID]
	if (questItemUse) then
		local questData = split(questItemUse, ",")
		local questInfoSplit, questID, questCount
		for pos, questInfo in pairs(questData) do
			questInfoSplit = split(questInfo, ":")
			questID = tonumber(questInfoSplit[1])
			questCount = tonumber(questInfoSplit[2])
			if (not dataItem.quests[questID]) then
				questName = Babylonian.GetString(InformantQuests.names, questID)
				dataItem.quests[questID] = {
					['count'] = questCount,
					['name'] = questName,
					['level'] = tonumber(InformantQuests.levels[questID])
				}
				dataItem.questCount = dataItem.questCount + 1
			end
		end
	end

	return dataItem
end

function getItemBasic(itemID)
	if (not itemID) then return end
	local sName, sLink, iQuality, iLevel, sType, sSubType, iCount, sEquipLoc, sTexture = GetItemInfo(tonumber(itemID))

	if (sName) then
		local dataItem = {
			['classText'] = sType,
			['quality'] = iQuality,
			['stack'] = iCount,
			['texture'] = sTexture,
			['reqLevel'] = iLevel,
			['fullData'] = false,
		}
	return dataItem
	end
end

function setSkills(skills)
	self.skills = skills
	Informant.SetSkills = nil -- Set only once
end

function setRequirements(requirements)
	self.requirements = requirements
	Informant.SetRequirements = nil -- Set only once
end

function setVendors(vendors)
	self.vendors = vendors
	Informant.SetVendors = nil -- Set only once
end

function setDatabase(database)
	self.database = database
	Informant.SetDatabase = nil -- Set only once
end


function setFilter(key, value)
	if (not InformantConfig.filters) then
		InformantConfig.filters = {};
		setFilterDefaults()
	end
	if (type(value) == "boolean") then
		if (value) then
			InformantConfig.filters[key] = 'on';
		else
			InformantConfig.filters[key] = 'off';
		end
	else
		InformantConfig.filters[key] = value;
	end
end

function getFilterVal(type)
	if (not InformantConfig.filters) then
		InformantConfig.filters = {}
		setFilterDefaults()
	end
	return InformantConfig.filters[type]
end

function getFilter(filter)
	value = getFilterVal(filter)
	if ((value == _INFM('CmdOn')) or (value == "on")) then return true
	elseif ((value == _INFM('CmdOff')) or (value == "off")) then return false end
	return true
end

function getLocale()
	local locale = Informant.GetFilterVal('locale');
	if (locale ~= 'on') and (locale ~= 'off') and (locale ~= 'default') then
		return locale;
	end
	return GetLocale();
end

local categories
function getCatName(catID)
	if (not categories) then categories = {GetAuctionItemClasses()} end
	for cat, name in categories do
		if (cat == catID) then return name end
	end
end

function tooltipHandler(funcVars, retVal, frame, name, link, quality, count, price)
	-- nothing to do, if informant is disabled
	if (not getFilter('all')) then
		return;
	end;

	if EnhTooltip.LinkType(link) ~= "item" then return end

	local quant = 0
	local sell = 0
	local buy = 0
	local stacks = 1

	local itemID, randomProp, enchant, uniqID, lame = EnhTooltip.BreakLink(link)
	if (itemID and itemID > 0) and (Informant) then
		itemInfo = getItem(itemID)
	end
	if (not itemInfo) then return end

	itemInfo.itemName = name
	itemInfo.itemLink = link
	itemInfo.itemCount = count
	itemInfo.itemQuality = quality

	stacks = itemInfo.stack
	if (not stacks) then stacks = 1 end

	buy = tonumber(itemInfo.buy) or 0
	sell = tonumber(itemInfo.sell) or 0
	quant = tonumber(itemInfo.quantity) or 0

	if (quant == 0) and (sell > 0) then
		local ratio = buy / sell
		if ((ratio > 3) and (ratio < 6)) then
			quant = 1
		else
			ratio = buy / (sell * 5)
			if ((ratio > 3) and (ratio < 6)) then
				quant = 5
			end
		end
	end
	if (quant == 0) then quant = 1 end

	buy = buy/quant

	itemInfo.itemBuy = buy
	itemInfo.itemSell = sell
	itemInfo.itemQuant = quant

	local embedded = getFilter('embed')

	if (getFilter('show-icon')) then
		if (itemInfo.texture) then
			EnhTooltip.SetIcon(itemInfo.texture)
		end
	end

	if (getFilter('show-vendor')) then
		if ((buy > 0) or (sell > 0)) then
			local bgsc = EnhTooltip.GetTextGSC(buy, true)
			local sgsc = EnhTooltip.GetTextGSC(sell, true)

			if (count and (count > 1)) then
				if (getFilter('show-vendor-buy')) then
					EnhTooltip.AddLine(string.format(_INFM('FrmtInfoBuymult'), count, bgsc), buy*count, embedded, true)
					EnhTooltip.LineColor(0.8, 0.5, 0.1)
				end
				if (getFilter('show-vendor-sell')) then
					EnhTooltip.AddLine(string.format(_INFM('FrmtInfoSellmult'), count, sgsc), sell*count, embedded, true)
					EnhTooltip.LineColor(0.8, 0.5, 0.1)
				end
			else
				if (getFilter('show-vendor-buy')) then
					EnhTooltip.AddLine(string.format(_INFM('FrmtInfoBuy')), buy, embedded, true)
					EnhTooltip.LineColor(0.8, 0.5, 0.1)
				end
				if (getFilter('show-vendor-sell')) then
					EnhTooltip.AddLine(string.format(_INFM('FrmtInfoSell')), sell, embedded, true)
					EnhTooltip.LineColor(0.8, 0.5, 0.1)
				end
			end
		end
	end

	if (getFilter('show-stack')) then
		if (stacks > 1) then
			EnhTooltip.AddLine(string.format(_INFM('FrmtInfoStx'), stacks), nil, embedded)
		end
	end
	if (getFilter('show-merchant')) then
		if (itemInfo.vendors) then
			local merchantCount = table.getn(itemInfo.vendors)
			if (merchantCount > 0) then
				EnhTooltip.AddLine(string.format(_INFM('FrmtInfoMerchants'), merchantCount), nil, embedded)
				EnhTooltip.LineColor(0.5, 0.8, 0.5)
			end
		end
	end
	if (getFilter('show-usage')) then
		local reagentInfo = ""
		if (itemInfo.classText) then
			reagentInfo = string.format(_INFM('FrmtInfoClass'), itemInfo.classText)
			EnhTooltip.AddLine(reagentInfo, nil, embedded)
			EnhTooltip.LineColor(0.6, 0.4, 0.8)
		end
		if (itemInfo.usedList and itemInfo.usageText) then
			if (table.getn(itemInfo.usedList) > 2) then

				local currentUseLine = nilSafeString(itemInfo.usedList[1])..", "..nilSafeString(itemInfo.usedList[2])..","
				reagentInfo = string.format(_INFM('FrmtInfoUse'), currentUseLine)
				EnhTooltip.AddLine(reagentInfo, nil, embedded)
				EnhTooltip.LineColor(0.6, 0.4, 0.8)

				for index = 3, table.getn(itemInfo.usedList), 2 do
					if (itemInfo.usedList[index+1]) then
						reagentInfo = whitespace(string.len(_INFM('FrmtInfoUse')) + 3)..nilSafeString(itemInfo.usedList[index])..", "..nilSafeString(itemInfo.usedList[index+1])..","
						EnhTooltip.AddLine(reagentInfo, nil, embedded)
						EnhTooltip.LineColor(0.6, 0.4, 0.8)
					else
						reagentInfo = whitespace(string.len(_INFM('FrmtInfoUse')) + 3)..nilSafeString(itemInfo.usedList[index])
						EnhTooltip.AddLine(reagentInfo, nil, embedded)
						EnhTooltip.LineColor(0.6, 0.4, 0.8)
					end
				end
			else
				reagentInfo = string.format(_INFM('FrmtInfoUse'), itemInfo.usageText)
				EnhTooltip.AddLine(reagentInfo, nil, embedded)
				EnhTooltip.LineColor(0.6, 0.4, 0.8)
			end
		end
	end
	if (getFilter('show-quest')) then
		if (itemInfo.quests) then
			local questCount = itemInfo.questCount
			if (questCount > 0) then
				EnhTooltip.AddLine(string.format(_INFM('FrmtInfoQuest'), questCount), nil, embedded)
				EnhTooltip.LineColor(0.5, 0.5, 0.8)
			end
		end
	end
end

function nilSafeString(str)
	if (not str) then str = "" end
	return str;
end

function whitespace(length)
	local spaces = ""
	while length ~= 0 do
		spaces = spaces.." "
		length = length - 1
	end
	return spaces
end

function showHideInfo()
	if (InformantFrame:IsVisible()) then
		InformantFrame:Hide()
	elseif (itemInfo) then
		InformantFrameTitle:SetText(_INFM('FrameTitle'))

		-- Woohoo! We need to provide any information we can from the item currently in itemInfo
		local quality = itemInfo.itemQuality or itemInfo.quality or 0

		local color = "ffffff"
		if (quality == 4) then color = "a335ee"
		elseif (quality == 3) then color = "0070dd"
		elseif (quality == 2) then color = "1eff00"
		elseif (quality == 0) then color = "9d9d9d"
		end

		clear()
		addLine(string.format(_INFM('InfoHeader'), color, itemInfo.itemName))

		local buy = itemInfo.itemBuy or itemInfo.buy or 0
		local sell = itemInfo.itemSell or itemInfo.sell or 0
		local quant = itemInfo.itemQuant or itemInfo.quantity or 0
		local count = itemInfo.itemCount or 1

		if ((buy > 0) or (sell > 0)) then
			local bgsc = EnhTooltip.GetTextGSC(buy, true)
			local sgsc = EnhTooltip.GetTextGSC(sell, true)

			if (count and (count > 1)) then
				local bqgsc = EnhTooltip.GetTextGSC(buy*count, true)
				local sqgsc = EnhTooltip.GetTextGSC(sell*count, true)
				addLine(string.format(_INFM('FrmtInfoBuymult'), count, bgsc)..": "..bqgsc, "ee8822")
				addLine(string.format(_INFM('FrmtInfoSellmult'), count, sgsc)..": "..sqgsc, "ee8822")
			else
				addLine(string.format(_INFM('FrmtInfoBuy'))..": "..bgsc, "ee8822")
				addLine(string.format(_INFM('FrmtInfoSell'))..": "..sgsc, "ee8822")
			end
		end

		if (itemInfo.stack > 1) then
			addLine(string.format(_INFM('FrmtInfoStx'), itemInfo.stack))
		end

		local reagentInfo = ""
		if (itemInfo.classText) then
			reagentInfo = string.format(_INFM('FrmtInfoClass'), itemInfo.classText)
			addLine(reagentInfo, "aa66ee")
		end
		if (itemInfo.usageText) then
			reagentInfo = string.format(_INFM('FrmtInfoUse'), itemInfo.usageText)
			addLine(reagentInfo, "aa66ee")
		end

		if (itemInfo.isPlayerMade) then
			addLine(string.format(_INFM('InfoPlayerMade'), itemInfo.reqLevel, itemInfo.reqSkillName), "5060ff")
		end

		if (itemInfo.quests) then
			local questCount = itemInfo.questCount
			if (questCount > 0) then
				addLine("")
				addLine(string.format(_INFM('FrmtInfoQuest'), questCount), nil, embed)
				addLine(string.format(_INFM('InfoQuestHeader'), questCount), "70ee90")
				for pos, quest in itemInfo.quests do
					addLine(string.format(_INFM('InfoQuestName'), quest.count, quest.name, quest.level), "80ee80")
				end
				addLine(string.format((_INFM('InfoQuestSource')).." WoWGuru.com"));
			end
		end

		if (itemInfo.vendors) then
			local vendorCount = table.getn(itemInfo.vendors)
			if (vendorCount > 0) then
				addLine("")
				addLine(string.format(_INFM('InfoVendorHeader'), vendorCount), "ddff40")
				for pos, merchant in itemInfo.vendors do
					addLine(string.format(" ".._INFM('InfoVendorName'), merchant), "eeee40")
				end
			end
		end
		InformantFrame:Show()
	else
		clear()
		addLine(_INFM('InfoNoItem'), "ff4010")
		InformantFrame:Show()
	end
end

function onQuit()
	if (not InformantConfig.position) then
		InformantConfig.position = { }
	end
	InformantConfig.position.x, InformantConfig.position.y = InformantFrame:GetCenter()
end

function onLoad()
	this:RegisterEvent("ADDON_LOADED")

	if (not InformantConfig) then
		InformantConfig = {}
		setFilterDefaults()
	end

	InformantFrameTitle:SetText(_INFM('FrameTitle'))
--	Informant.InitTrades();
end

local function frameLoaded()
	Stubby.RegisterEventHook("PLAYER_LEAVING_WORLD", "Informant", onQuit)
	Stubby.RegisterFunctionHook("EnhTooltip.AddTooltip", 300, tooltipHandler)

	onLoad()

	-- Setup the default for stubby to always load (people can override this on a
	-- per toon basis)
	Stubby.SetConfig("Informant", "LoadType", "always", true)

	-- Register our temporary command hook with stubby
	Stubby.RegisterBootCode("Informant", "CommandHandler", [[
		local function cmdHandler(msg)
			local i,j, cmd, param = string.find(string.lower(msg), "^([^ ]+) (.+)$")
			if (not cmd) then cmd = string.lower(msg) end
			if (not cmd) then cmd = "" end
			if (not param) then param = "" end
			if (cmd == "load") then
				if (param == "") then
					Stubby.Print("Manually loading Informant...")
					LoadAddOn("Informant")
				elseif (param == "always") then
					Stubby.Print("Setting Informant to always load for this character")
					Stubby.SetConfig("Informant", "LoadType", param)
					LoadAddOn("Informant")
				elseif (param == "never") then
					Stubby.Print("Setting Informant to never load automatically for this character (you may still load manually)")
					Stubby.SetConfig("Informant", "LoadType", param)
				else
					Stubby.Print("Your command was not understood")
				end
			else
				Stubby.Print("Informant is currently not loaded.")
				Stubby.Print("  You may load it now by typing |cffffffff/informant load|r")
				Stubby.Print("  You may also set your loading preferences for this character by using the following commands:")
				Stubby.Print("  |cffffffff/informant load always|r - Informant will always load for this character")
				Stubby.Print("  |cffffffff/informant load never|r - Informant will never load automatically for this character (you may still load it manually)")
			end
		end
		SLASH_INFORMANT1 = "/informant"
		SLASH_INFORMANT2 = "/inform"
		SLASH_INFORMANT3 = "/info"
		SLASH_INFORMANT4 = "/inf"
		SlashCmdList["INFORMANT"] = cmdHandler
	]]);
	Stubby.RegisterBootCode("Informant", "Triggers", [[
		local loadType = Stubby.GetConfig("Informant", "LoadType")
		if (loadType == "always") then
			LoadAddOn("Informant")
		else
			Stubby.Print("]].._INFM('MesgNotLoaded')..[[");
		end
	]]);
end

function onVariablesLoaded()
	setFilterDefaults()

	InformantFrameTitle:SetText(_INFM('FrameTitle'))

	if (InformantConfig.position) then
		InformantFrame:ClearAllPoints()
		InformantFrame:SetPoint("CENTER", UIParent, "BOTTOMLEFT", InformantConfig.position.x, InformantConfig.position.y)
	end

	if (not InformantConfig.welcomed) then
		clear()
		addLine(_INFM('Welcome'))
		InformantConfig.welcomed = true
	end

	-- Restore key bindings
	-- This workaround is required for LoadOnDemand addons since their saved
	-- bindings are deleted upon login.
	local profile = getKeyBindProfile();
	if (InformantConfig and InformantConfig.bindings) then
		if (not	InformantConfig.bindings[profile]) then profile = 'global'; end
		if (InformantConfig.bindings[profile]) then
			for _,key in ipairs(InformantConfig.bindings[profile]) do
				SetBinding(key, 'INFORMANT_POPUPDOWN')
			end
		end
	end
	this:RegisterEvent("UPDATE_BINDINGS")	-- Monitor changes to bindings

	Informant.InitCommands()
end

function onEvent(event)
	if (event == "ADDON_LOADED" and string.lower(arg1) == "informant") then
		onVariablesLoaded()
		this:UnregisterEvent("ADDON_LOADED")
	elseif (event == "UPDATE_BINDINGS") then
		-- Store key bindings for Informant
		local key1, key2 = GetBindingKey('INFORMANT_POPUPDOWN');
		local profile = getKeyBindProfile();

		if (not InformantConfig.bindings) then InformantConfig.bindings = {}; end
		if (not InformantConfig.bindings[profile]) then InformantConfig.bindings[profile] = {}; end

		InformantConfig.bindings[profile][1] = key1;
		InformantConfig.bindings[profile][2] = key2;
	end
end

function frameActive(isActive)
	if (isActive) then
		scrollUpdate(0)
	end
end

function getRowCount()
	return table.getn(lines)
end

function scrollUpdate(offset)
	local numLines = getRowCount()
	if (numLines > 25) then
		if (not offset) then
			offset = FauxScrollFrame_GetOffset(InformantFrameScrollBar)
		else
			if (offset > numLines - 25) then offset = numLines - 25 end
			FauxScrollFrame_SetOffset(InformantFrameScrollBar, offset)
		end
	else
		offset = 0
	end
	local line
	for i=1, 25 do
		line = lines[i+offset]
		local f = getglobal("InformantFrameText"..i)
		if (line) then
			f:SetText(line)
			f:Show()
		else
			f:Hide()
		end
	end
	if (numLines > 25) then
		FauxScrollFrame_Update(InformantFrameScrollBar, numLines, 25, numLines)
		InformantFrameScrollBar:Show()
	else
		InformantFrameScrollBar:Hide()
	end
end

function testWrap(text)
	InformantFrameTextTest:SetText(text)
	if (InformantFrameTextTest:GetWidth() < InformantFrame:GetWidth() - 20) then
		return text, ""
	end

	local pos, test, best, rest
	best = text
	rest = nil
	pos = string.find(text, " ")
	while (pos) do
		test = string.sub(text, 1, pos-1)
		InformantFrameTextTest:SetText(test)
		if (InformantFrameTextTest:GetWidth() < InformantFrame:GetWidth() - 20) or (not rest) then
			best = test
			rest = string.sub(test, pos+1)
		else
			break
		end
		pos = string.find(text, " ", pos+1)
	end
	return best, rest
end

function addLine(text, color, level)
	if (text == nil) then return end
	if (not level) then level = 1 end
	if (level > 100) then
		return
	end

	if (type(text) == "table") then
		for pos, line in text do
			addLine(line, color, level)
		end
		return
	end

	if (not text) then
		table.insert(lines, "nil")
	else
		local best, rest = testWrap(text)
		if (color) then
			table.insert(lines, string.format("|cff%s%s|r", color, best))
		else
			table.insert(lines, best)
		end
		if (rest) and (rest ~= "") then
			addLine(rest, color, level+1)
		end
	end
	scrollUpdate()
end

function clear()
	lines = {}
	scrollUpdate()
end

function setFilterDefaults()
	if (not InformantConfig.filters) then InformantConfig.filters = {}; end
	for k,v in pairs(filterDefaults) do
		if (InformantConfig.filters[k] == nil) then
			InformantConfig.filters[k] = v;
		end
	end
end

-- Key binding helper functions

function getKeyBindProfile()
	if (IsAddOnLoaded("PerCharBinding")) then
		return GetRealmName() .. ":" .. UnitName("player")
	end
	return 'global'
end

-- GLOBAL OBJECT

Informant = {
	version = INFORMANT_VERSION,
	GetItem = getItem,
	GetRowCount = getRowCount,
	AddLine = addLine,
	Clear = clear,
	ShowHideInfo = showHideInfo,

	-- These functions are only meant for internal use.
	SetSkills = setSkills,
	SetRequirements = setRequirements,
	SetVendors = setVendors,
	SetDatabase = setDatabase,
	FrameActive = frameActive,
	FrameLoaded = frameLoaded,
	ScrollUpdate = scrollUpdate,
	GetFilter = getFilter,
	GetFilterVal = getFilterVal,
	GetLocale = getLocale,
	OnEvent = onEvent,
	SetFilter = setFilter,
	SetFilterDefaults = setFilterDefaults,
}

