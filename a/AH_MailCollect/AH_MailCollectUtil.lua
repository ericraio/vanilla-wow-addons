
ace:RegisterFunctions(AH_MailCollect, {

version = AH_MailCollect.ACEUTIL_VERSION,

ParseCash = function(c)
	local c=ace.round(c or 0)
	return floor(c/(100*100)),mod(floor(c/100),100),mod(floor(c),100)
end,

ColorText = function(c,...)
	if(not c) then return ace.concat(arg) end
	if(type(c)=="table") then
		return "|cff"..ace.HexDigit(c[1] or c.r)..ace.HexDigit(c[2] or c.g)..
					   ace.HexDigit(c[3] or c.b)..ace.concat(arg).."|r"
	end
	return "|cff"..c..ace.concat(arg).."|r"
end,

CashTextLetters = function(cash,sep,nocol)
	-- Arg order for these doesn't matter, so swap them if sep is TRUE
	if((sep==TRUE) or (sep==true)) then sep=nocol; nocol=TRUE end
	local g,s,c=ace.ParseCash(cash or 0)
	local str=""
	if(g>0) then
		if(nocol) then str=g..ACEG_LETTER_GOLD
		else
			str=ace.ColorText(ACEG_COLOR_HEX_GOLD,g..ACEG_LETTER_GOLD)
		end
	end
	if(s>0) then
		if(str ~= "") then str = str..(sep or " ") end
		if(nocol) then str=str..s..ACEG_LETTER_SILVER
		else
			str=str..ace.ColorText(ACEG_COLOR_HEX_SILVER,s..ACEG_LETTER_SILVER)
		end
	end
	if(c>0) then
		if(str ~= "") then str=str..(sep or " ") end
		if(nocol) then str=str..c..ACEG_LETTER_COPPER
		else
			str=str..ace.ColorText(ACEG_COLOR_HEX_COPPER,c..ACEG_LETTER_COPPER)
		end
	end
	return str
end,

})
