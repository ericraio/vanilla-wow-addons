--[[
  ****************************************************************
	SCT Globalization Format Parser
	
	Some of this code was directly taken from MarsMessageParser.lua 
	with permission from the author (as said in the file).
	
	It used is being used by SCT simply to make sure all the 
	GlobalStrings.lua strings are ordered and converted properly.
	
	****************************************************************]]
	
	
local SCT_GlobalStrings = {};
local ParseFunction;
local parseBuffer;
local parseOrder;
local parseCount;

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
		if(string.find(character, "[%%cEefgGiouXxqs]")) then
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
		elseif(string.find(character, "[%%d]")) then
			local order;
			_, _, order = string.find(parseBuffer, "(%d+)%$");
			parseCount = parseCount + 1;
			if(order) then
				parseOrder[parseCount] = tonumber(order);
			else
				parseOrder[parseCount] = parseCount;
			end
			result = "(%d+)";
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

function SCTGlobalParser_Format(formatString)
	parseBuffer = nil;
	parseOrder = {};
	parseCount = 0;
	
	--see if in "cache" table
	if (SCT_GlobalStrings[formatString] == nil) then
		local parseString = string.gsub(formatString, ".", ParseFunction);
		SCT_GlobalStrings[formatString] = { parseString, parseOrder };
	end
	
	return SCT_GlobalStrings[formatString];
end

function SCTGlobalParser_ParseMessage(arg1, formatString)
	local parseResult;
	local findResult;
	
	parseResult = SCTGlobalParser_Format(formatString);	
	findResult = {string.find(arg1, parseResult[1])};
	if(findResult[1]) then
		local i, n;
		local callResult = {};
		n = table.getn(findResult);
		for i=3,n do
			callResult[parseResult[2][i-2]] = findResult[i];
		end
		return unpack(callResult);
	end
	return nil;
end

	