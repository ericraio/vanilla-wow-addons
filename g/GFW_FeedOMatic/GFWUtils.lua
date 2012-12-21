------------------------------------------------------
-- GFWUtils.lua
-- Useful utility / debug functions
------------------------------------------------------

GFWUTILS_THIS_VERSION = 8;

------------------------------------------------------

-- Shortcuts for common text color codes
function GFWUtils_temp_HiliteText(text)
	if (text == nil) then return nil; end
	return HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end
function GFWUtils_temp_RedText(text)
	if (text == nil) then return nil; end
	return RED_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end
function GFWUtils_temp_GrayText(text)
	if (text == nil) then return nil; end
	return GRAY_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end
function GFWUtils_temp_LightYellowText(text)
	if (text == nil) then return nil; end
	return LIGHTYELLOW_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
end

-- Prints a message to the chat frame
function GFWUtils_temp_Print(message, r, g, b)
	DEFAULT_CHAT_FRAME:AddMessage(message, (r or GFW_FONT_COLOR.r), (g or GFW_FONT_COLOR.g), (b or GFW_FONT_COLOR.b));
end

-- Prints a message to the chat frame once per interval (seconds) or once per session if interval is nil
function GFWUtils_temp_PrintOnce(message, interval, r, g, b)
	if (GFWUtils.PrintOnceCache == nil) then
		GFWUtils.PrintOnceCache = {};
	end
	if (interval == nil and GFWUtils.PrintOnceCache[message]) then
		return;
	end
	if (interval and GFWUtils.PrintOnceCache[message] and GetTime() - GFWUtils.PrintOnceCache[message] < interval) then
		return;
	end
	DEFAULT_CHAT_FRAME:AddMessage(message, (r or GFW_FONT_COLOR.r), (g or GFW_FONT_COLOR.g), (b or GFW_FONT_COLOR.b));
	GFWUtils.PrintOnceCache[message] = GetTime();
end

-- Prints a message to the chat frame only if Debug is set
function GFWUtils_temp_DebugLog(message)
	if (GFWUtils.Debug) then
		DEFAULT_CHAT_FRAME:AddMessage(message, GFW_DEBUG_COLOR.r, GFW_DEBUG_COLOR.g, GFW_DEBUG_COLOR.b);
	end
end

-- Prints a message in yellow to the floating messages frame
function GFWUtils_temp_Note(message)
	UIErrorsFrame:AddMessage(message, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
end

-- Converts string.format to a string.find pattern: "%s hits %s for %d." to "(.+) hits (.+) for (%d+)"
-- based on Recap by Gello
function GFWUtils_temp_FormatToPattern(formatString)

	local patternString = formatString;
	
	patternString = string.gsub(patternString, "%%%d+%$([diouXxfgbcsq])", "%%%1"); -- reordering specifiers (e.g. %2$s) stripped	
	patternString = string.gsub(patternString, "([%$%(%)%.%[%]%*%+%-%?%^])", "%%%1"); -- convert regex special characters
	
	patternString = string.gsub(patternString, "%%c", "(.)"); -- %c to (.)
	patternString = string.gsub(patternString, "%%s", "(.+)"); -- %s to (.+)
	patternString = string.gsub(patternString, "%%[du]", "(%%d+)"); -- %d to (%d+)
	patternString = string.gsub(patternString, "%%([gf])", "(%%d+%%.*%%d*)"); -- %g or %f to (%d+%.*%d*)
		
	return patternString;

end

-- Splits a string into a table of strings separated by 'separator'.
-- e.g. Split(aString, ", ") is the reverse of table.concat(aTable, ", ")
function GFWUtils_temp_Split(aString, separator)
	if (aString == nil) then return nil; end
	
	local t = {};
	local function helper(segment)
		table.insert(t, segment);
	end
	helper((string.gsub(aString, "(.-)"..separator, helper)));
	return t;
end

-- Capitalizes the first letter of each word in aString.
function GFWUtils_temp_TitleCase(aString)
	if (aString == nil) then return nil; end
	local function capWords(first, rest) 
		return string.upper(first)..string.lower(rest);
	end
	return string.gsub(aString, "(%w)([%w_']*)", capWords);
end

-- Splits a cash amount into gold, siver, and copper
function GFWUtils_temp_GSC(money)
	if (money == nil) then money = 0; end
	local g = math.floor(money / 10000);
	local s = math.floor((money - (g*10000)) / 100);
	local c = math.floor(money - (g*10000) - (s*100));
	return g,s,c;
end

-- Formats money text by color for gold, silver, copper
-- discards copper for amounts greater than 1g unless second arg evaluates true
-- based on Auctioneer
function GFWUtils_temp_TextGSC(money, noRound)
    local GSC_GOLD="ffd100";
    local GSC_SILVER="e6e6e6";
    local GSC_COPPER="c8602c";
    local GSC_START="|cff%s%d%s|r";
    local GSC_PART=" |cff%s%02d%s|r";
    local GSC_NONE="|cffa0a0a0none|r";

	local g, s, c = GFWUtils.GSC(money);
	
	local gsc = "";
	if (g > 0) then
		gsc = format(GSC_START, GSC_GOLD, g, "g");     
		if (s > 0) then
			gsc = gsc..format(GSC_PART, GSC_SILVER, s, "s");
			if (noRound and c > 0) then
				gsc = gsc..format(GSC_PART, GSC_COPPER, c, "c");
			end
		end
	elseif (s > 0) then
		gsc = format(GSC_START, GSC_SILVER, s, "s");
		if (c > 0) then
			gsc = gsc..format(GSC_PART, GSC_COPPER, c, "c");
		end
	elseif (c > 0) then
		gsc = gsc..format(GSC_START, GSC_COPPER, c, "c");
	else
		gsc = GSC_NONE;
	end

	return gsc;
end

function GFWUtils_temp_ItemLink(linkInfo)
	local sName, sLink, iQuality, iLevel, sType, sSubType, iCount = GetItemInfo(linkInfo);
	if (sName) then
		local _, _, _, color = GetItemQualityColor(iQuality);
		local linkFormat = "%s|H%s|h[%s]|h|r";
		return string.format(linkFormat, color, sLink, sName);
	else
		return nil;
	end
end

------------------------------------------------------
-- load only if not already loaded
------------------------------------------------------

if (GFWUtils == nil) then
	GFWUtils = {};
end
local G = GFWUtils;
if (G.Version == nil or (tonumber(G.Version) ~= nil and G.Version < GFWUTILS_THIS_VERSION)) then

	-- Constants
	GFW_FONT_COLOR = {r=0.25, g=1.0, b=1.0};
	GFW_DEBUG_COLOR = {r=1.0, g=0.75, b=0.25};
	G.Debug = false;

	-- Functions
	G.Hilite = GFWUtils_temp_HiliteText;
	G.Red = GFWUtils_temp_RedText;
	G.Gray = GFWUtils_temp_GrayText;
	G.LtY = GFWUtils_temp_LightYellowText;
	G.Print = GFWUtils_temp_Print;
	G.PrintOnce = GFWUtils_temp_PrintOnce;
	G.DebugLog = GFWUtils_temp_DebugLog;
	G.Note = GFWUtils_temp_Note;
	G.FormatToPattern = GFWUtils_temp_FormatToPattern;
	G.Split = GFWUtils_temp_Split;
	G.TitleCase = GFWUtils_temp_TitleCase;
	G.GSC = GFWUtils_temp_GSC;
	G.TextGSC = GFWUtils_temp_TextGSC;
	G.ItemLink = GFWUtils_temp_ItemLink;
	
	-- Set version number
	G.Version = GFWUTILS_THIS_VERSION;
end

