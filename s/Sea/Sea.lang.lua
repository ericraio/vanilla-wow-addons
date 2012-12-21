--[[
--
--	Sea.lang
--
--	Localization formatting functions for WoW
--	
--	$LastChangedBy: Sinaloit $
--	$Rev: 2025 $
--	$Date: 2005-07-02 18:51:34 -0500 (Sat, 02 Jul 2005) $
--]]

Sea.lang = {

	--
	-- makeLocalizedString(...)
	--
	-- 	Generates localized strings, inserting the arguments in the order
	-- 	which matchers the <##>. E.g. localizeString("<2> <1>", "a", "B"); 
	-- 	will generate: "B a". 
	--
	-- Arguments:
	-- 	(string formatString) arg
	-- 	formatString - string with <1> to <arg.n> to be inserted
	-- 	arg - contains the values to insert
	--
	makeLocalizedString = function (...)
		ret = arg[1];	
		for i=2, arg.n, 1 do
			ret = string.gsub (ret, "<"..(i-1)..">", arg[i]);
		end
		return ret;
	end;

	-- 
	-- parseLocalizedString (localizedString, formatString, order, n to parse )
	--
	-- 	This function reads values back from a localized string. 
	-- 	In order to get the values back, you must pass
	-- 	this function the final string, the original format string, 
	-- 	the order of the parameters in that string and the n number
	-- 	to parse of out the localized string. 
	-- 
	parseLocalizedString = function (str, fmt, ord, n)
		local ret = {};
		fmt1 = string.gsub (fmt, "%b<>", "(.+)");
		for i=1, n, 1 do
			ret[ord[i]] = string.gsub(str, fmt1, "%"..i);
		end
		return unpack(ret);
	end;
};
