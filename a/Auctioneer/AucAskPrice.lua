--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.6.1 (Platypus)
	Revision: $Id: AucAskPrice.lua 689 2006-01-14 00:38:53Z mentalpower $

	Auctioneer AskPrice created by Mikezter and merged into Auctioneer by MentalPower.
	Functions responsible for AskPrice's operation..

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
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]

--Local function prototypes
local init, commandHandler, chatPrintHelp, onOff, setTrigger, genVarSet, setKhaosSetKeyValue, eventHandler

function init()
	Stubby.RegisterEventHook("CHAT_MSG_WHISPER", "Auctioneer", Auctioneer.AskPrice.EventHandler);
	Stubby.RegisterEventHook("CHAT_MSG_PARTY", "Auctioneer", Auctioneer.AskPrice.EventHandler);
	Stubby.RegisterEventHook("CHAT_MSG_GUILD", "Auctioneer", Auctioneer.AskPrice.EventHandler);

	Auctioneer.AskPrice.Language = GetDefaultLanguage("player");
end

function commandHandler(command, source)

	--To print or not to print, that is the question...
	local chatprint = nil;

	if (source == "GUI") then
		chatprint = false;

	else
		chatprint = true;
	end;

	--Divide the large command into smaller logical sections (Shameless copy from the original function)
	local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");

	if (not cmd) then cmd = command; end
	if (not cmd) then cmd = ""; end
	if (not param) then	param = ""; end
	cmd = Auctioneer.Util.DelocalizeCommand(cmd);

	--Now for the real Command handling

	--/auctioneer askprice help
	if ((cmd == "") or (cmd == "help")) then
		chatPrintHelp();

	--/auctioneer askprice (on|off|toggle)
	elseif (cmd == 'on' or cmd == 'off' or cmd == 'toggle') then
		onOff(cmd, chatprint);

	--/auctioneer askprice trigger (char)
	elseif (cmd == 'trigger') then
		setTrigger(param, chatprint)

	--/auctioneer askprice (party|guild|smart|ad)
	elseif (cmd == 'vendor' or cmd == 'party' or cmd == 'guild' or cmd == 'smart' or cmd == 'ad') then
		genVarSet(cmd, param, chatprint);

	--Command not recognized
	else
		if (chatprint) then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActUnknown'), command));
		end
	end
end

function chatPrintHelp()
	local onOffToggle = " (".._AUCT('CmdOn').."|".._AUCT('CmdOff').."|".._AUCT('CmdToggle')..")";
	local lineFormat = "  |cffffffff/auctioneer askprice %s"..onOffToggle.."|r |cff2040ff[%s]|r - %s";

	Auctioneer.Util.ChatPrint("  |cffffffff/auctioneer askprice"..onOffToggle.."|r |cff2040ff["..Auctioneer.Util.GetLocalizedFilterVal('askprice').."]|r - " .. _AUCT('HelpAskPrice'));

	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceVendor'), Auctioneer.Util.GetLocalizedFilterVal('askprice-vendor'), _AUCT('HelpAskPriceVendor')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceParty'), Auctioneer.Util.GetLocalizedFilterVal('askprice-party'), _AUCT('HelpAskPriceParty')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceGuild'), Auctioneer.Util.GetLocalizedFilterVal('askprice-guild'), _AUCT('HelpAskPriceGuild')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceSmart'), Auctioneer.Util.GetLocalizedFilterVal('askprice-smart'), _AUCT('HelpAskPriceSmart')));
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceAd'), Auctioneer.Util.GetLocalizedFilterVal('askprice-ad'), _AUCT('HelpAskPriceAd')));

	lineFormat = "  |cffffffff/auctioneer askprice %s|r |cff2040ff[%s]|r - %s";
	Auctioneer.Util.ChatPrint(string.format(lineFormat, _AUCT('CmdAskPriceTrigger'), Auctioneer.Command.GetFilterVal('askprice-trigger'), _AUCT('HelpAskPriceTrigger')));
end

function onOff(state, chatprint)
	if (state == 'on' or state == 'off') then
		Auctioneer.Command.SetFilter('askprice', state);
	elseif (state == 'toggle') then
		Auctioneer.Command.SetFilter('askprice', not Auctioneer.Command.GetFilter('askprice'));
	end

	--Print the change and alert the GUI if the command came from slash commands. Do nothing if they came from the GUI.
	if (chatprint) then
		state = Auctioneer.Command.GetFilter('askprice')
		setKhaosSetKeyValue("askprice", state)

		if (state) then
			Auctioneer.Util.ChatPrint(_AUCT('StatAskPriceOn'));

		else
			Auctioneer.Util.ChatPrint(_AUCT('StatAskPriceOff'));
		end
	end
end

function setTrigger(param, chatprint)
	if ((not param) or (not type(param) == 'string')) then
		return
	end

	param = string.sub(param, 1, 1)
	Auctioneer.Command.SetFilter('askprice-trigger', param)

	if (chatprint) then
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActSet'), "askprice ".._AUCT('CmdAskPriceTrigger'), param));
		setKhaosSetKeyValue('askprice-trigger', param)
	end
end

function genVarSet(variable, param, chatprint)
	if (type(param) == "string") then
		param = Auctioneer.Util.DelocalizeFilterVal(param);
	end

	local var = "askprice-"..variable

	if (param == "on" or param == "off" or type(param) == "boolean") then
		Auctioneer.Command.SetFilter(var, param);

	elseif (param == "toggle" or param == nil or param == "") then
		param = Auctioneer.Command.SetFilter(var, not Auctioneer.Command.GetFilter(var));
	end

	if (chatprint) then
		if (Auctioneer.Command.GetFilter(var)) then
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtAskPriceEnable'), Auctioneer.Util.LocalizeCommand(variable)));
			setKhaosSetKeyValue(var, true)
		else
			Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtAskPriceDisable'), Auctioneer.Util.LocalizeCommand(variable)));
			setKhaosSetKeyValue(var, false)
		end
	end
end

function setKhaosSetKeyValue(key, value)
	if (Auctioneer_Khaos_Registered) then
		local kKey = Khaos.getSetKey("Auctioneer", key)

		if (not kKey) then
			EnhTooltip.DebugPrint("setKhaosSetKeyParameter(): key " .. key .. " does not exist")
		elseif (kKey.checked ~= nil) then
			if (type(value) == "string") then value = (value == "on"); end
			Khaos.setSetKeyParameter("Auctioneer", key, "checked", value)
		elseif (kKey.value ~= nil) then
			Khaos.setSetKeyParameter("Auctioneer", key, "value", value)
		else
			EnhTooltip.DebugPrint("setKhaosSetKeyValue(): don't know how to update key ", key)
		end
	end
end

function eventHandler(hookParams, event, text, player)

	--Nothing to do if askprice is disabled
	if (not Auctioneer.Command.GetFilter('askprice')) then
		return
	end

	if (not ((event == "CHAT_MSG_WHISPER") or ((event == "CHAT_MSG_GUILD") and Auctioneer.Command.GetFilter('askprice-guild')) or ((event == "CHAT_MSG_PARTY") and Auctioneer.Command.GetFilter('askprice-party')))) then
		return
	end

	local aCount, historicalMedian, snapshotMedian, vendorSell, eachstring, askedCount, items, usedStack, multipleItems;

	-- Check for marker (trigger char or "smart" words)
	if (string.sub(text, 1, 1) ~= Auctioneer.Command.GetFilterVal('askprice-trigger')) then
		if (Auctioneer.Command.GetFilter('askprice-smart')) then
			if (not (string.find(string.lower(text), _AUCT('CmdAskPriceSmartWord1')) and string.find(string.lower(text), _AUCT('CmdAskPriceSmartWord2')))) then
				return;
			end
		else
			return;
		end
	end

	-- Check for itemlink after trigger
	if (not (string.find(text, "|Hitem:"))) then
		return;
	end

	items = getItems(text)
	for key, link in ipairs(items) do
		aCount, historicalMedian, snapshotMedian, vendorSell = getData(link[1]);
		local askedCount

		if (multipleItems) then
			SendChatMessage("    ", "WHISPER", Auctioneer.AskPrice.Language, player);
		end

		if (link[2] > 1) then
			eachstring = string.format(_AUCT('FrmtAskPriceEach'), EnhTooltip.GetTextGSC(historicalMedian, nil, true));
		else
			eachstring = "";
		end

		if (aCount > 0) then
			SendChatMessage(link[1]..": "..string.format(_AUCT('FrmtInfoSeen'), aCount), "WHISPER", Auctioneer.AskPrice.Language, player);
			SendChatMessage(string.format(_AUCT('FrmtAskPriceBuyoutMedianHistorical'), "    ", EnhTooltip.GetTextGSC(historicalMedian*link[2], nil, true), eachstring), "WHISPER", Auctioneer.AskPrice.Language, player);
			SendChatMessage(string.format(_AUCT('FrmtAskPriceBuyoutMedianSnapshot'), "    ", EnhTooltip.GetTextGSC(snapshotMedian*link[2], nil, true), eachstring), "WHISPER", Auctioneer.AskPrice.Language, player);
		else
			SendChatMessage(link[1]..": "..string.format(_AUCT('FrmtInfoNever'), Auctioneer.Util.GetAuctionKey()), "WHISPER", Auctioneer.AskPrice.Language, player);
		end

		if (Auctioneer.Command.GetFilter('askprice-vendor') and (vendorSell > 0)) then
			if (link[2] > 1) then
				eachstring = string.format(_AUCT('FrmtAskPriceEach'), EnhTooltip.GetTextGSC(vendorSell, nil, true));
			else
				eachstring = "";
			end

			SendChatMessage(string.format(_AUCT('FrmtAskPriceVendorPrice'), "    ",EnhTooltip.GetTextGSC(vendorSell * link[2], nil, true), eachstring), "WHISPER", Auctioneer.AskPrice.Language, player);
		end

		if (link[2] > 1) then
			usedStack = link[2]
		end
		multipleItems = true;
	end

	if ((not usedStack) and (Auctioneer.Command.GetFilter('askprice-ad'))) then
		SendChatMessage(string.format(_AUCT('AskPriceAd'), Auctioneer.Command.GetFilterVal('askprice-trigger')), "WHISPER", Auctioneer.AskPrice.Language, player)
	end
end

function getData(itemLink)
	local itemID, randomProp, enchant, uniqID, lame = EnhTooltip.BreakLink(itemLink);

	local auctKey = Auctioneer.Util.GetAuctionKey();
	local itemKey = itemID..":"..randomProp..":"..enchant;

	local auctionPriceItem = Auctioneer.Core.GetAuctionPriceItem(itemKey, auctKey);
	local aCount,minCount,minPrice,bidCount,bidPrice,buyCount,buyPrice = Auctioneer.Core.GetAuctionPrices(auctionPriceItem.data);
	local historicalMedian, historicalMedCount = Auctioneer.Statistic.GetItemHistoricalMedianBuyout(itemKey, auctKey);
	local snapshotMedian, snapshotMedCount = Auctioneer.Statistic.GetItemSnapshotMedianBuyout(itemKey, auctKey);
	local median, medCount = Auctioneer.Statistic.GetUsableMedian(itemKey, auctKey);

	if (aCount > 0) then
		-- calculate auction values

		local avgMin = math.floor(minPrice / minCount);

		local bidPct = math.floor(bidCount / minCount * 100);
		local avgBid = 0;
		if (bidCount > 0) then
			avgBid = math.floor(bidPrice / bidCount);
		end

		local buyPct = math.floor(buyCount / minCount * 100);
		local avgBuy = 0;
		if (buyCount > 0) then
			avgBuy = math.floor(buyPrice / buyCount);
		end
	end

	--Get Vendor price (if available)
	--Thanks Tarog for "decrypting" informant :)
	local vendorSell;
	if (Informant) then
		local itemInfo = Informant.GetItem(itemID);

		if (itemInfo) then
			vendorSell = tonumber(itemInfo.sell)
		end
	end

	return aCount or 0, historicalMedian or 0, snapshotMedian or 0, vendorSell or 0;
end

--Many thanks to the guys at irc://chat.freenode.net/wowi-lounge for their help in creating this function
function getItems(str)
	if (not str) then return nil end
	local itemList = {};

	for number, color, item, name in string.gfind(str, "(%d*)|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
		table.insert(itemList, {"|c"..color.."|Hitem:"..item.."|h["..name.."]|h|r", tonumber(number) or 1})
	end
	return itemList;
end

Auctioneer.AskPrice = {
	Init = init,
	CommandHandler = commandHandler,
	ChatPrintHelp = chatPrintHelp,
	OnOff = onOff,
	SetTrigger = setTrigger,
	GenVarSet = genVarSet,
	EventHandler = eventHandler,
}
