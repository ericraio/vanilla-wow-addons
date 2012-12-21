--[[
	WARNING! If you edit this file you need a good editor, not notepad.
	This file HAS to be saved in UTF-8 format (without signature) else we would have to escape
	all special chars
	
	For now im using zh both for zhTW and zhCN 
	I only had a zhTW GlobalStrings but im just assuming it's the same with zhCN
]]--
if ((GetLocale() == "zhTW") or (GetLocale() == "zhCN"))then


function SW_FixLogStrings(str)
	-- almost all strings don't have spaces before and after %d, but we need those
	return string.gsub(str, "(.)(%%%d?$?d)(.)", "%1 %2 %3");
end
-- this MUST go at the end of a localization
-- Again if you create a localization put SW_mergeLocalization(); at the end!!!
SW_mergeLocalization();
end