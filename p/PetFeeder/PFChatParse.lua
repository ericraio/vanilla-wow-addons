--[[
path: /ChatParse/
filename: PFChatParse.lua
author: "Daniel Risse" <dan@risse.com>
created: Thu, 03 Feb 2004 00:38:00 -0600
updated:

Chat Parse: Used to scrap information from Chat Messages



	COMBATLOG_XPGAIN_EXHAUSTION1_GROUP = "%s dies, you gain %d experience. (%s exp %s bonus, +%d group bonus)";

	local spec = PFChatParse_FormatToPattern(COMBATLOG_XPGAIN_EXHAUSTION1_GROUP, "creepName", "xp", CHAT_PARSE_VALUE1, CHAT_PARSE_NAME1, "group");

	local message = format(COMBATLOG_XPGAIN_EXHAUSTION1_GROUP, "Creep X", 100, "+20", "rested", 10);
	-- Creep X dies, you gain 100 experience. (+20 exp rested bonus, +10 group bonus)

	local match = PFChatParse_MatchPattern(message, spec);
	if ( match ) then
		PFDebugMessage("test", "Wahoo!!!"..match.creepName, "info");
	end
]]


local PFChatParse_Events = { };

function PFChatParse_OnLoad()
end

function PFChatParse_OnEvent(event)
	if ( not PFChatParse_Events[event] ) then
		--this:UnregisterEvent(event);
		PFDebugMessage("CP", "OnEvent("..event..") called but nothing registered...", "warning");
	else
		local index, info, match, processed, string;
		processed = { };
		for index, info in PFChatParse_Events[event] do
			if ( not info.AddOn or not processed[info.AddOn] ) then
				if ( info.input ) then
					string = info.input()
				else
					string = arg1;
				end
				match = PFChatParse_MatchPattern(string, info.patternSpec);
				if ( match ) then
					result = info.func(match);
					if ( not result and info.AddOn ) then
						processed[info.AddOn] = true;
					end
				end
			end
		end
	end
end

function PFChatParse_RegisterEvent(info)
	if ( type(info) ~= "table" ) then
		PFDebugMessage("CP", "Input to PFChatParse_RegisterEvent must be a table!", "error");
		return nil;
	elseif ( not info.event or type(info.event) ~= "string" ) then
		PFDebugMessage("CP", "Input to PFChatParse_RegisterEvent must contain an event to watch!", "error");
		return nil;
	elseif ( not info.func or type(info.func) ~= "function" ) then
		PFDebugMessage("CP", "Input to PFChatParse_RegisterEvent must contain a function to call back to!", "error");
		return nil;
	elseif ( not info.template or type(info.template) ~= "string" ) then
		PFDebugMessage("CP", "Input to PFChatParse_RegisterEvent must contain a template to match against the Chat message!", "error");
		return nil;

	elseif ( not PFChatParse_Events[info.event] ) then
		PFChatParseFrame:RegisterEvent(info.event);
		PFChatParse_Events[info.event] = { };
		table.setn(PFChatParse_Events[info.event], 0);
	end

	if ( not info.AddOn ) then
		PFDebugMessage("CP", "Input to PFChatParse_RegisterEvent did not contain AddOn name; this is needed to PFChatParse_UnregisterEvent and to stop looking for additional matches.", "warning");
	end
	PFDebugMessage("CP", "new spec for event: "..info.event, "helper");

	local spec = PFChatParse_FormatToPattern(info.template, info.fields, info.english);
	if ( spec ) then
		table.insert(PFChatParse_Events[info.event], { func = info.func, patternSpec = spec, AddOn = info.AddOn, input = info.input });
	end
end

function PFChatParse_UnregisterEvent(info)
	if ( type(info) ~= "table" ) then
		PFDebugMessage("CP", "Input to PFChatParse_UnregisterEvent must be a table!", "error");
		return nil;
	elseif ( not info.AddOn or type(info.AddOn) ~= "string" ) then
		PFDebugMessage("CP", "Input to PFChatParse_UnregisterEvent must contain an AddOn to stop watching!", "error");
		return nil;
	end
	local event, specList, index, spec;

	for event, specList in PFChatParse_Events do
		if ( not info.event or event == info.event ) then
			for index, spec in specList do
				if ( info.AddOn == spec.AddOn ) then
					table.remove(PFChatParse_Events[event], index);
				end
			end
			if ( table.getn(PFChatParse_Events[event]) == 0 ) then
				PFChatParse_Events[event] = nil;
				PFChatParseFrame:UnregisterEvent(event);
			end
		end
	end
end

--   ("%s hits you for %d damage.", "creep", "damage");
-- this function will convert a format string into a pattern that will extract
--   named parameters from the string

function PFChatParse_FormatToPattern(template, fields, english)
	PFDebugMessage("CP", "template: "..template, "helper");
	local ret = { pattern = template };
	ret.pattern = string.gsub(ret.pattern, "%(", "%%(");
	ret.pattern = string.gsub(ret.pattern, "%)", "%%)");
	ret.pattern = string.gsub(ret.pattern, "%.", "%%.");
	ret.pattern = string.gsub(ret.pattern, "%+", "%%+");
	ret.pattern = string.gsub(ret.pattern, "%[", "%%[");
	ret.pattern = string.gsub(ret.pattern, "%]", "%%]");

	local index, field, count, matchCount, fieldCount;
	matchCount = 0;
	fieldCount = 0;
	local replaceFunc = function(i, m)
		if ( i == "" ) then
			matchCount = matchCount + 1;
			i = matchCount;
		else
			i = 0 + i;
		end
		PFDebugMessage("CP", "Match: "..i..", "..m, "helper");
		if ( not fields[i] ) then
			if ( m == "d" ) then
				return "[0-9]+";
			elseif ( m == "s" ) then
				return ".+";
			end
		else
			fieldCount = fieldCount + 1;
			ret[fieldCount] = fields[i];
			fields[i] = nil;
			if ( m == "d" ) then
				return "([0-9]+)";
			elseif ( m == "s" ) then
				return "(.+)";
			end
		end
	end;
	ret.pattern, count = string.gsub(ret.pattern, "%%(%d*)$?([ds])", replaceFunc);
	if ( next(fields) ) then
		if ( english ) then
			PFDebugMessage("CP", "More names passed than substitution items!\n  "..template.."\n  "..english, "error");
		else
			PFDebugMessage("CP", "More names passed than substitution items!", "error");
		end
	end
	PFDebugMessage("CP", "pattern: "..ret.pattern, "helper");
	return ret;
end


function PFChatParse_MatchPattern(message, spec)
	local match = { string.gfind(message, spec.pattern)() };
	if ( table.getn(match) ~= 0 ) then
		local ret = { };
		local index;
		for index=1, table.getn(match), 1 do
			if ( spec[index] ) then
				ret[spec[index]] = match[index];
			end
		end
		return ret;
	end
	return nil;
end
