--[[
	Tradeskill support
	Gives you quantities based upon your tradeskilling abilities.
	$Id: InfTrades.lua 716 2006-02-09 15:25:17Z mentalpower $
	Version 3.8.0 (Kangaroo)

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

local p = EnhancedTooltip.DebugPrint;

local tsfHookOnUpdate, tsfHookSetSelection, scanTradeskillLink, tradeSkillText
local readFormula, getCounts, scanBank, scanBags, scanContainer, getPlayerName
local initTrades

-- Hooked functions

function tradeHook(type, selID)
	p("Processing trade", trade, selID);
	if (selID == nil) then
		-- We are hooked into the tradeskill frame and it has been updated
		for i=1, TRADE_SKILLS_DISPLAYED, 1 do
			local button = getglobal("TradeSkillSkill"..i)
			local skillIndex = button:GetID()
			local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(skillIndex);
			button:SetText(tradeSkillText(skillIndex, skillName))
			scanTradeskillID(i, false)
		end
	else
		scanTradeskillLink(selID, true)
	end
end

function bankHook()
	p("Processing bank contents");
	scanContainer(BANK_CONTAINER)
	for bag = 5, 10 do
		scanContainer(bag)
	end
end

function bagHook()
	p("Processing bag contents");
	for bag = 0, 4 do
		scanContainer(bag)
	end
end

function initTrades()
	Stubby.RegisterFunctionHook("EnhTooltip.TradeHook", 100, tradeHook);
	Stubby.RegisterFunctionHook("EnhTooltip.BankHook", 100, bankHook);
	Stubby.RegisterFunctionHook("EnhTooltip.BagHook", 100, bagHook);
	Informant.InitTrades = function() end
end
Informant.InitTrades = initTrades

-- Associated functions

function scanTradeskillLink(id, setStrings)
	-- We are hooked into the tradeskill frame and it has been updated
	local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(id)
	local skillLink = GetTradeSkillItemLink(id)
	local skillID = EnhancedTooltip.baselinkFromLink(skillLink)

	if (setStrings) then
		local totalSkillItems = getTotalCount(skillID)
		if (totalSkillItems > 0) then
			local invSkillItems = getInventoryCount(skillID)
			TradeSkillSkillName:SetText(skillName.." ["..invSkillItems.."/"..totalSkillItems.."]")
		else
			TradeSkillSkillName:SetText(skillName)
		end
	end

	local formula = "";
	local numReagents = GetTradeSkillNumReagents(id)
	for i=1, numReagents, 1 do
		local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(id, i)
		local reagentLink = GetTradeSkillReagentLink(id, i);
		local reagentID = EnhancedTooltip.baselinkFromLink(reagentLink);
		local totalReagents = getTotalCount(reagentName)
		formula = formula..":"..reagentID.."x"..reagentCount
		if (setStrings) then
			getglobal("TradeSkillReagent"..i.."Name"):SetText(reagentName.." ["..totalReagents.."]")
		end
	end
	Informant_Formulae[skillID] = formula;
end


function scanContainer(bag)
	local texture, itemCount, itemLink
	local itemID, randomProperty, enchantment, uniqueID, itemName
	local containerItems = GetContainerNumSlots(bag)
	if (containerItems) then
		for containerItemNum = 1, containerItems do
			itemLink = GetContainerItemLink(bag, containerItemNum)
			if (itemLink) then
				texture, itemCount = GetContainerItemInfo(bag, containerItemNum)
				itemID, randomProperty, enchantment, uniqueID, itemName = EnhTooltip.BreakLink(itemLink)

				if ((bag == BANK_CONTAINER) or ((bag >= 5) and (bag <= 10))) then
				end
			end
		end
	end
end


-- Utility functions

-- Get the current realm and player
local playerRealm = nil
local playerName = nil
function getPlayerName()
	if (playerName == nil) then
		playerRealm = GetCVar("realmName")
		playerName = UnitName("player")
	end
	return playerRealm, playerName;
end

-- Read (and extrapolate) a formula and work out how many we can make
function readFormula(itemKey)
	local formula = Informant_Formulae[itemKey]
	local bag, bank, other, make, vend, all
	local tBag, tBank, tOther, tMake, tVend, tAll
	for reagKey, reagCount in string.gfind(formula, ":(%d+)x(%d+)") do
		local _,_, reagID = string.find(reagKey, "(\d+):");
		bag, bank, other = getCounts(reagKey)
		if (InformantFormula[reagKey]) then
			local subMake = readFormula(reagKey)
			make = subMake.all
		end
		vend = 0;
		local reagData = Informant.getItem(reagID);
		if (reagData.quantity > 0) then
			vend = 9999;
		end
		all = math.max(9999, bag + bank + other + vend + make);

		tBag = math.min(tBag, math.floor(bag / reagCount))
		tBank = math.min(tBank, math.floor(bank / reagCount))
		tOther = math.min(tOther, math.floor(other / reagCount))
		tMake = math.min(tMake, math.floor(make / reagCount))
		tAll = math.min(tAll, math.floor(all / reagCount))
	end

	return {
		bag = tBag,
		bank = tBank,
		other = tOther,
		make = tMake,
		all = tAll,
	}
end

-- How many of these do I have?
function getCounts(itemID)
	local curRealm, curPlayer = getPlayerName()
	local invTotal = 0
	local bankTotal = 0
	local otherTotal = 0
	if (InformantItems and InformatItems[curRealm]) then
		for player, pData in Informant_Items[curRealm] do
			local i,j, invCount, bankCount = string.find(pData, "(%d):(%d)");
			if (player == curPlayer) then
				invTotal = tonumber(invCount)
				bankTotal = tonumber(bankCount)
			else
				otherTotal = tonumber(invCount) + tonumber(bankCount)
			end
		end
	end
	return invTotal, bankTotal, otherTotal;
end

