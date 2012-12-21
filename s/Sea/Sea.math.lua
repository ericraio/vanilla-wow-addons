--[[
--
--	Sea.math
--
--	Useful math constants and values
--
--	$LastChangedBy: legorol $
--	$Rev: 2845 $
--	$Date: 2005-12-07 21:32:15 -0600 (Wed, 07 Dec 2005) $
--]]

Sea.math = {
	
	-- Traditional pi
	pi = math.pi;

	--
	-- rgbaFromHex(string hex)
	--	
	--	Convert a hex string "AARRGGBB" into floats
	--
	-- Args:
	-- 	(string hex)
	-- 	hex - the string in hexidecimal
	--
	-- Returns:
	-- 	(Number red, number blue, number green, number alpha)
	-- 
	rgbaFromHex = function (hexColor)
		local alpha, red, green, blue = 1;
		local intFromHex = Sea.math.intFromHex;
		local ssub = string.sub;
		-- Handle short strings
		if ( string.len(hexColor) > 6 ) then
			alpha = intFromHex(ssub(hexColor, 1, 2)) / 255;
			red = intFromHex(ssub(hexColor, 3, 4)) / 255;
			green = intFromHex(ssub(hexColor, 5, 6)) / 255;
			blue = intFromHex(ssub(hexColor, 7, 8)) / 255;
		else
			red = intFromHex(ssub(hexColor, 1, 2)) / 255;
			green = intFromHex(ssub(hexColor, 3, 4)) / 255;
			blue = intFromHex(ssub(hexColor, 5, 6)) / 255;
		end

		return red, green, blue, alpha;
	end;

	--
	-- intFromHex(string hex)
	--
	-- 	Convert a hex string into an integer.
	--
	-- Args:
	-- 	(string hex)
	-- 	hex - the string in hexidecimal
	--
	-- Returns:
	-- 	(number value)
	-- 	value - the number as an integer
	--
	-- Recoded by Iriel (iriel@vigilance-committee.org) for performance
	intFromHex = function ( hexCode )
		local intFromHexTable = Sea.math.intFromHexTable;
		local amount = 0;
		local len = string.len(hexCode)
		local ssub = string.sub;
		local c;
		for i=1,len do 
			c = ssub(hexCode, i, i);
			amount = amount * 16 + (intFromHexTable[c] or 0);
		end
	return amount;
	end; 
	
	intFromHexTable = {
		["0"] = 0,  ["1"] = 1,  ["2"] = 2,  ["3"] = 3,  ["4"] = 4,
		["5"] = 5,  ["6"] = 6,  ["7"] = 7,  ["8"] = 8,  ["9"] = 9,
		["A"] = 10, ["B"] = 11, ["C"] = 12,
		["D"] = 13, ["E"] = 14, ["F"] = 15,
		["a"] = 10, ["b"] = 11, ["c"] = 12,
		["d"] = 13, ["e"] = 14, ["f"] = 15,
	};

	--
	-- hexFromInt(Num int [, minlength])
	--
	--	Converts a decimal to hex string
	--	
	-- Args:
	-- 	(Number int)
	-- 	int - the value in decimal
	-- 	minlength - the zero padding 
	--
	-- Returns:
	-- 	(String hex)
	-- 	hex - the value in hex
	--
	hexFromInt = function (intval, minlength)
		local fmt = "%.2x"
		if ( minlength ) then 
			fmt = "%."..minlength.."x";
		end
		return string.format(fmt, intval );
	end; 


	-- 
	-- convertBase(string input, int original, int outputBase)
	-----------------------------------------------------------
	--               Function made by KaTTaNa !              -- 
	--               --------------------------              --
	--   http://www.wc3sear.ch/index.php?p=JASS&ID=37&sid=   --
	--               --------------------------              --
	--               Converted in LUA by vjeux               --
	--                                                       --
	-- Usage : BaseConversion(255, 10, 16)                   --
	-- => Return "ff"                                        --
	--                                                       --
	-- Usage : BaseConversion("ff", 16, 10)                  --
	-- => Return "255"                                        --
	-----------------------------------------------------------
	-- 
	convertBase = function (input, inputBase, outputBase)
		local charMap = "0123456789abcdefghijklmnopqrstuvwxyz~!@#$%^&*()_+-=[]";
		local s;
		local result = "";
		local val = 0;
		local i;
		local p = 0;
		local pow = 1;
		local sign = "";
		
		if ( inputBase < 2 or inputBase > string.len(charMap) or outputBase < 2 or outputBase > string.len(charMap) ) then
			-- Bases are invalid or out of bounds
			return "Invalid bases given";
		end
		if ( string.sub(input, 1, 1) == "-" ) then
			sign = "-";
			input = string.sub(input, 1, string.len(input));
		end
		i = string.len(input);
		-- Get the integer value of input
		while (i > 0) do
			s = string.sub(input, i, i);
			p = 0;
			local bool = false;
			while (bool == false) do
				if ( p >= inputBase ) then
					-- Input cannot match base
					return "Input does not match base!\n P = "..p;
				end
				if ( s == string.sub(charMap, p+1, p+1) ) then
					val = val + pow * p;
					pow = pow * inputBase;
					bool = true;
				end
				p = p + 1;
			end
			i = i - 1;
		end
		while (val > 0) do
			p = math.mod(val, outputBase);
			result = string.sub(charMap, p+1, p+1)..result;
			val = val / outputBase;
		end
		
		for i = 1, string.len(result), 1 do
			if (string.sub(result, 1, 1) == "0") then
				result = string.sub(result, 2, string.len(result));
			else
				return sign..result
			end
		end
		
		if (string.len(sign..result) == 0) then 
			return "0";
		else
			return sign..result.."-"..string.len(sign..result);
		end
	end;	


	-- round(float x)
	--
	-- 	Rounds a float value to the "closest" integer (following IEEE standard).
	--
	-- Args:
	-- 	(float x)
	-- 	x - the value to round
	--
	-- Returns:
	-- 	(number value)
	-- 	value - the number as an integer (the closest integer to x)
	round = function (x)
		if (x < 0) then
			return math.ceil(x-0.5)
		else
			return math.floor(x+0.5)
		end
	end

};
