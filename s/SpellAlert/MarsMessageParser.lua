---------------------------------------------------------------------------
-- MarsMessageParser.lua
---------------------------------------------------------------------------
--
-- This file Copyright (C) 2005 MarsMod.  All rights reserved.
--
-- You are permitted to include this file in your AddOns provided that you
-- do not modify it.  Suggestions and bug reports should be sent to
-- MarsMod @ gmail.com.
--
-- You are also permitted to modify this file, but only if you first
-- replace all occurances of "MarsMessageParser" with "YourMod".
--
---------------------------------------------------------------------------
--
-- How to use MarsMessageParser:
--
-- 1. Decide on what your "clientId" will be.  Lets use "MyAddOn" for this
-- example.
--
-- 2. Write a function that you want called when certain messages arrive:
--   function MyAddOn_DeclareWinner(player, itemText)
--      DEFAULT_CHAT_FRAME:AddMessage(itemText.." goes to "..player..".");
--   end
--   function MyAddOn_DeclareSelfWinner(itemText)
--      MyAddOn_DeclareWinner(UnitName("player"), itemText);
--   end
--
-- 3. Register your functions in the order you want them checked:
--   MarsMessageParser_RegisterFunction("MyAddOn", LOOT_ROLL_YOU_WON,
--      MyAddOn_DeclareSelfWinner, true);
--   MarsMessageParser_RegisterFunction("MyAddOn", LOOT_ROLL_WON,
--      MyAddOn_DeclareWinner, true);
--
-- 4. Somewhere in your event handling code, add something like this:
--   if(event == "CHAT_MSG_LOOT") then
--      MarsMessageParser_ParseMessage("MyAddOn", arg1);
--   end
--
-- The message parser will try to check arg1 against all your registered
-- functions in the order you registered them and will call the first
-- function that matches.
--
---------------------------------------------------------------------------
--
-- API Specification
--
-- MarsMessageParser_RegisterFunction(clientId, formatString, func, endsWithLink)
--    clientId - a string unique to your AddOn to avoid AddOn conflict
--    formatString - the localized format from GlobalVariables.lua for the
--       message you want to check for
--    func - the function that you want called when that message arrives.
--       the parameters in formatString will be passed into your function
--       in the local-independent order
--    endsWithLink - if true, tells the message parser to treat the last
--       seven parameters in the local-independent order as the seven
--       parameters for a textual item link.  these parameters will then be
--       wrapped up into a single string parameter for passing to your
--       function
--
-- MarsMessageParser_ParseMessage(clientId, message)
--    clientId - a string unique to your AddOn to avoid AddOn conflict
--    message - the localized message received from the server
--
---------------------------------------------------------------------------

local parseRegistrations;
local ParseFunction;
local parseBuffer;
local parseOrder;
local parseCount;

if((not MarsMessageParser_Version) or (MarsMessageParser_Version < 10)) then

	MarsMessageParser_Version = 10;

	parseRegistrations = {};

	ParseFunction = function (character)
		local result;
		if(not parseBuffer) then
			if(character == "%") then
				parseBuffer = character;
				result = "";
			else
				if(string.find(character, "[%^%$%(%)%%%.%[%]%*%+%-%?]")) then
					result = "%"..character;
				else
					result = character;
				end
			end
		else
			parseBuffer = parseBuffer..character;
			if(string.find(character, "[%%cdEefgGiouXxqs]")) then
				local order;
				_, _, order = string.find(parseBuffer, "(%d+)%$");
				parseCount = parseCount + 1;
				if(order) then
					parseOrder[parseCount] = tonumber(order);
				else
					parseOrder[parseCount] = parseCount;
				end
				result = "(.+)";
				parseBuffer = nil;
			elseif(string.find(character, "[%$%.%d]")) then
				result = "";
			else
				result = parseBuffer;
				parseBuffer = nil;
			end
		end
		return result;
	end

	function MarsMessageParser_RegisterFunction(clientId, formatString, func, endsWithLink)
		if(not parseRegistrations[clientId]) then
			parseRegistrations[clientId] = {};
		end
		parseBuffer = nil;
		parseOrder = {};
		parseCount = 0;
		local parseString = string.gsub(formatString, ".", ParseFunction);
		local registerId = table.getn(parseRegistrations[clientId]) + 1;
		parseRegistrations[clientId][registerId] = { parseString, parseOrder, func, endsWithLink };
	end

	function MarsMessageParser_ParseMessage(clientId, message)
		local registerId = 1;
		local findResult;
		if(not parseRegistrations[clientId]) then
			return;
		end
		repeat
			findResult = {string.find(message, parseRegistrations[clientId][registerId][1])};
			if(findResult[1]) then
				local i, n;
				local callResult = {};
				n = table.getn(findResult);
				for i=3,n do
					callResult[parseRegistrations[clientId][registerId][2][i-2]] = findResult[i];
				end
				n = n - 2;
				if(parseRegistrations[clientId][registerId][4]) then
					callResult[n-6] = string.format("%s|Hitem:%s:%s:%s:%s|h[%s]|h%s", callResult[n-6], callResult[n-5], callResult[n-4], callResult[n-3], callResult[n-2], callResult[n-1], callResult[n]);
					for i=n,n-5,-1 do
						callResult[i] = nil;
					end
				end
				parseRegistrations[clientId][registerId][3](unpack(callResult));
				return;
			end
			registerId = registerId + 1;
		until(not parseRegistrations[clientId][registerId]);
	end

end