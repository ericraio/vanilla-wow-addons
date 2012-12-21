--[[
path: /ChatParse/
filename: BGChatParse.lua
author: "Daniel Risse" <dan@risse.com>
created: Thu, 03 Feb 2004 00:38:00 -0600
updated:

Chat Parse: Used to scrap information from Chat Messages



	COMBATLOG_XPGAIN_EXHAUSTION1_GROUP = "%s dies, you gain %d experience. (%s exp %s bonus, +%d group bonus)";

	local spec = BGChatParse_FormatToPattern(COMBATLOG_XPGAIN_EXHAUSTION1_GROUP, "creepName", "xp", CHAT_PARSE_VALUE1, CHAT_PARSE_NAME1, "group");

	local message = format(COMBATLOG_XPGAIN_EXHAUSTION1_GROUP, "Creep X", 100, "+20", "rested", 10);
	-- Creep X dies, you gain 100 experience. (+20 exp rested bonus, +10 group bonus)

	local match = BGChatParse_MatchPattern(message, spec);
	if ( match ) then
		BGDebugMessage("test", "Wahoo!!!"..match.creepName, "info");
	end
]]


local BGChatParse_Events = { };

function BGChatParse_OnLoad()
end

function BGChatParse_OnEvent(event)
	if ( not BGChatParse_Events[event] ) then
		--this:UnregisterEvent(event);
		BGDebugMessage("CP", "OnEvent("..event..") called but nothing registered...", "warning");
	else
		local index, info, match, processed, string;
		processed = { };
		for index, info in BGChatParse_Events[event] do
			if ( not info.AddOn or not processed[info.AddOn] ) then
				if ( info.input ) then
					string = info.input()
				else
					string = arg1;
				end
				match = BGChatParse_MatchPattern(string, info.patternSpec);
				if ( match ) then
					if ( arg2 ) then
						match.player = arg2;
					end
					result = info.func(match);
					if ( not result and info.AddOn ) then
						processed[info.AddOn] = true;
					end
				end
			end
		end
	end
end

function BGChatParse_RegisterEvent(info)
	if ( type(info) ~= "table" ) then
		BGDebugMessage("CP", "Input to BGChatParse_RegisterEvent must be a table!", "error");
		return nil;
	elseif ( not info.event or type(info.event) ~= "string" ) then
		BGDebugMessage("CP", "Input to BGChatParse_RegisterEvent must contain an event to watch!", "error");
		return nil;
	elseif ( not info.func or type(info.func) ~= "function" ) then
		BGDebugMessage("CP", "Input to BGChatParse_RegisterEvent must contain a function to call back to!", "error");
		return nil;
	elseif ( not info.template or type(info.template) ~= "string" ) then
		BGDebugMessage("CP", "Input to BGChatParse_RegisterEvent must contain a template to match against the Chat message!", "error");
		return nil;

	elseif ( not BGChatParse_Events[info.event] ) then
		BGChatParseFrame:RegisterEvent(info.event);
		BGChatParse_Events[info.event] = { };
		table.setn(BGChatParse_Events[info.event], 0);
	end

	if ( not info.AddOn ) then
		BGDebugMessage("CP", "Input to BGChatParse_RegisterEvent did not contain AddOn name; this is needed to BGChatParse_UnregisterEvent and to stop looking for additional matches.", "warning");
	end
	BGDebugMessage("CP", "new spec for event: "..info.event, "helper");

	local spec = BGChatParse_FormatToPattern(info.template, info.fields, info.english);
	if ( spec ) then
		table.insert(BGChatParse_Events[info.event], { func = info.func, patternSpec = spec, AddOn = info.AddOn, input = info.input });
	end
end

function BGChatParse_UnregisterEvent(info)
	if ( type(info) ~= "table" ) then
		BGDebugMessage("CP", "Input to BGChatParse_UnregisterEvent must be a table!", "error");
		return nil;
	elseif ( not info.AddOn or type(info.AddOn) ~= "string" ) then
		BGDebugMessage("CP", "Input to BGChatParse_UnregisterEvent must contain an AddOn to stop watching!", "error");
		return nil;
	end
	local event, specList, index, spec;

	for event, specList in BGChatParse_Events do
		if ( not info.event or event == info.event ) then
			for index, spec in specList do
				if ( info.AddOn == spec.AddOn ) then
					table.remove(BGChatParse_Events[event], index);
				end
			end
			if ( table.getn(BGChatParse_Events[event]) == 0 ) then
				BGChatParse_Events[event] = nil;
				BGChatParseFrame:UnregisterEvent(event);
			end
		end
	end
end

--   ("%s hits you for %d damage.", "creep", "damage");
-- this function will convert a format string into a pattern that will extract
--   named parameters from the string

function BGChatParse_FormatToPattern(template, fields, english)
	BGDebugMessage("CP", "template: "..template, "helper");
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
		BGDebugMessage("CP", "Match: "..i..", "..m, "helper");
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
			BGDebugMessage("CP", "More names passed than substitution items!\n  "..template.."\n  "..english, "error");
		else
			BGDebugMessage("CP", "More names passed than substitution items!", "error");
		end
	end
	BGDebugMessage("CP", "pattern: "..ret.pattern, "helper");
	return ret;
end


function BGChatParse_MatchPattern(message, spec)
--BGDebugMessage("CP", "match pattern on "..message.." with "..spec.pattern, "error");
	local match = { string.gfind(message, spec.pattern)() };
	if ( table.getn(match) ~= 0 ) then
		local ret = { };
		local index;
		for index=1, table.getn(match), 1 do
--			BGDebugMessage("CP","match:"..match[index],"debug");
			if ( spec[index] ) then
				ret[spec[index]] = match[index];
			end
		end
		ret["player"] = nil;
		return ret;
	end
	return nil;
end
