local _, class = UnitClass("PLAYER")
local armormult

local function round(arg1, decplaces)
	if (decplaces == nil) then decplaces = 0 end
	if arg1 == nil then arg1 = 0 end
	return string.format ("%."..decplaces.."f", arg1)
end

local function findpattern(text, pattern, start)
	if (text and pattern and (string.find(text, pattern, start))) then
		return string.sub(text, string.find(text, pattern, start))
	else
		return ""
	end
end

local red, green, blue, first
local a = TheoryCraft_TooltipOrs
local leftline, rightline, rightlinewasnil, _, doheal, timer
local returnvalue, colour

function TheoryCraft_AddTooltipInfo(frame, dontshow)
	if TheoryCraft_Settings["off"] then return frame end
	local tooltipdata = TheoryCraft_GetSpellDataByFrame(frame, true)
	if tooltipdata == nil then
		if (frame:NumLines() == 1) and (getglobal(frame:GetName().."TextLeft1"):GetText() ~= "Attack") then
			local _, _, name, rank = strfind(getglobal(frame:GetName().."TextLeft1"):GetText(), "(.+)%((%d+)%)")
			if not name then return nil end
			rank = tonumber(rank)

			local spellname, spellrank
			local i2 = 1
			while (true) do
				spellname, spellrank = GetSpellName(i2,BOOKTYPE_SPELL)
				if spellname == nil then return end
				spellrank = tonumber(findpattern(spellrank2, "%d+"))
				if spellrank == nil then spellrank2 = 0 end
				if ((spellname == name) or (name == string.sub(spellname, 1, string.len(name)))) and (spellrank == rank) then 
					frame:SetSpell(i2,BOOKTYPE_SPELL)
					return frame
				end
				i2 = i2 + 1
			end
		end
		frame:Show()
		return frame
	end

	timer = GetTime()
	doheal = (tooltipdata["minheal"]) and (((tooltipdata["drain"] == nil) and (tooltipdata["holynova"] == nil)) or (TheoryCraft_Settings["healanddamage"]))

	local function docolour(r, g, b)
		r = tonumber(r)
		g = tonumber(g)
		b = tonumber(b)
		if (not r) or (not g) or (not b) then return "invalid colour" end
		if (r > 1) or (r < 0) or (g > 1) or (g < 0) or (b > 1) or (b < 0) then return "invalid colour" end
		if first then
			red = r
			green = g
			blue = b
			first = false
		else
			return "|c"..string.format("%.2x", math.floor(r*255))..
				    string.format("%.2x", math.floor(g*255))..
				    string.format("%.2x", math.floor(b*255)).."ff"
		end
	end

	local function dowork(n)
		local _, _, n2 = strfind(n, "|(.+)|")
		n = string.gsub(n, "%|.+%|", "")
		if (not doheal) and ((n == "nextcritheal") or (n == "healrange") or (n == "hps") or (n == "hpsdam") or (n == "crithealrange")) then
			return "$NOT FOUND$"
		end
		if n == "spellrank" then if tooltipdata.spellrank == 0 then return "$NOT FOUND$" end end
		if TheoryCraft_Data["outfit"] ~= 1 then
			if n == "outfitname" then
				if (TheoryCraft_Data["outfit"] == 2) and (TheoryCraft_Settings["CustomOutfitName"]) then
					return TheoryCraft_Settings["CustomOutfitName"]
				else
					if TheoryCraft_Outfits[TheoryCraft_Data["outfit"]] then
						return TheoryCraft_Outfits[TheoryCraft_Data["outfit"]].name
					end
				end
			end
		end
		if n == "hitorheal" then if tooltipdata.isheal then return a.hitorhealheal else return a.hitorhealhit end end
		if n == "damorheal" then if tooltipdata.isheal then return a.damorhealheal else return a.damorhealdam end end
		if n == "damorap" then if tooltipdata.ismelee or tooltipdata.isranged then return a.damorapap else return a.damorapdam end end
--		if rightlinewasnil then
--			if tooltipdata["test"] then
--				if tooltipdata["test"][n] ~= tooltipdata[n] then
--					colour = "#c0.9,0.9,0#"
--				else
--					colour = "#c0.5,0.5,0.5#"
--				end
--				if rightline then
--					rightline = rightline.."#IF, $|test|"..n.."$IF#"
--				else
--					rightline = colour.."#IF$|test|"..n.."$IF#"
--				end
--			end
--		end
		local _, _, roundfactor = strfind(n, ",(%d+)")
		if roundfactor then roundfactor = tonumber(roundfactor) end
		n = string.gsub(n, ",%d+", "")
		if n == "penetration" and tonumber(tooltipdata["penetration"]) == 0 then
			return "$NOT FOUND$"
		end
		if n == "basemanacost" and tooltipdata["dontshowmana"] then
			return "$NOT FOUND$"
		end
		if n == "healrange" and tooltipdata["minheal"] then
			if tooltipdata["minheal"] == tooltipdata["maxheal"] then
				return round(tooltipdata["minheal"])
			else
				return round(tooltipdata["minheal"])..TheoryCraft_Locale.to..round(tooltipdata["maxheal"])
			end
		end
		if n == "dmgrange" and tooltipdata["mindamage"] then
			if tooltipdata["mindamage"] == tooltipdata["maxdamage"] then
				return round(tooltipdata["mindamage"])
			else
				return round(tooltipdata["mindamage"])..TheoryCraft_Locale.to..round(tooltipdata["maxdamage"])
			end
		end
		if ((n == "critdmgrange") or (n == "igniterange")) and (tooltipdata["critdmgmin"]) then
			if ((TheoryCraft_Settings["sepignite"]) and (n == "critdmgrange")) and (tooltipdata["critdmgmaxminusignite"]) then
				if tooltipdata["critdmgminminusignite"] == tooltipdata["critdmgmaxminusignite"] then
					return round(tooltipdata["critdmgminminusignite"])
				else
					return round(tooltipdata["critdmgminminusignite"])..TheoryCraft_Locale.to..round(tooltipdata["critdmgmaxminusignite"])
				end
			else
				if (tooltipdata["critdmgminminusignite"] == nil) and (n == "igniterange") then return "$NOT FOUND$" end
				if tooltipdata["critdmgmin"] == tooltipdata["critdmgmax"] then
					return round(tooltipdata["critdmgmin"])
				else
					return round(tooltipdata["critdmgmin"])..TheoryCraft_Locale.to..round(tooltipdata["critdmgmax"])
				end
			end
		end
		if ((n == "crithealrange") and (tooltipdata["crithealmin"])) then
			if tooltipdata["crithealmin"] == tooltipdata["crithealmax"] then
				return round(tooltipdata["crithealmin"])
			else
				return round(tooltipdata["crithealmin"])..TheoryCraft_Locale.to..round(tooltipdata["crithealmax"])
			end
		end
		if n2 then
			if tooltipdata[n2] == nil then return "$NOT FOUND$" end
			if tooltipdata[n2][n] == nil then return "$NOT FOUND$" end
			returnvalue = tooltipdata[n2][n]
		else
			if tooltipdata[n] == nil then return "$NOT FOUND$" end
			returnvalue = tooltipdata[n]
		end
		if (n == "maxoomdam") or (n == "maxevocoomdam") or (n == "maxoomheal") or (n == "maxevocoodam") then
			if returnvalue < 0 then 
				returnvalue = "Infinite"  
			else 
				returnvalue = round(returnvalue/1000, 2).."k"
			end 
		end
		if (roundfactor) and (tonumber(returnvalue)) then
			return round(returnvalue, roundfactor)
		elseif (tonumber(returnvalue)) then
			return round(returnvalue)
		else
			return returnvalue
		end
	end

	local function door(first, second)
		if strfind(first, "%$NOT FOUND%$") then first = nil end
		if strfind(second, "%$NOT FOUND%$") then second = nil end
		return first or second or "$NOT FOUND$"
	end

	local function doif(line)
		if strfind(line, "%$NOT FOUND%$") then return end
		return line
	end

	do
		tooltipdata["cooldownremaining"] = nil
		local i = 1
		local tmpstring
		while getglobal(frame:GetName().."TextLeft"..i) do
			tmpstring = getglobal(frame:GetName().."TextLeft"..i):GetText() or ""
			if string.find(tmpstring, (TheoryCraft_Locale.CooldownRem) or "Cooldown remaining: ") then
				tooltipdata["cooldownremaining"] = getglobal(frame:GetName().."TextLeft"..i):GetText()
			end
			i = i + 1
		end
	end
	frame:ClearLines()
	local a = TheoryCraft_TooltipFormat
	local dr, dg, db = TheoryCraft_Colours["AddedLine"][1], TheoryCraft_Colours["AddedLine"][2], TheoryCraft_Colours["AddedLine"][3]
	local _, tr, tg, tb, titletext, lr, lg, lb
	local bool
	for k, line in pairs(a) do
		bool = line.show
		if bool == "critmelee" then
			bool = (TheoryCraft_Settings["crit"]) and ((tooltipdata.ismelee) or (tooltipdata.isranged))
		elseif bool == "critwithdam" then
			bool = (TheoryCraft_Settings["crit"] and TheoryCraft_Settings["critdam"]) and (tooltipdata.ismelee == nil) and (tooltipdata.isranged == nil)
		elseif bool == "critwithoutdam" then
			bool = (TheoryCraft_Settings["crit"] and (not TheoryCraft_Settings["critdam"])) and (tooltipdata.ismelee == nil) and (tooltipdata.isranged == nil)
		elseif bool == "averagedam" then
			bool = TheoryCraft_Settings["averagedam"] and (not TheoryCraft_Settings["averagedamnocrit"])
		elseif bool == "averagedamnocrit" then
			bool = TheoryCraft_Settings["averagedam"] and TheoryCraft_Settings["averagedamnocrit"]
		elseif bool == "max" then
			bool = TheoryCraft_Settings["max"] and (not TheoryCraft_Settings["maxtime"])
		elseif bool == "maxtime" then
			bool = TheoryCraft_Settings["max"] and TheoryCraft_Settings["maxtime"]
		elseif bool == "maxevoc" then
			bool = TheoryCraft_Settings["maxevoc"] and (not TheoryCraft_Settings["maxtime"])
		elseif bool == "maxevoctime" then
			bool = TheoryCraft_Settings["maxevoc"] and TheoryCraft_Settings["maxtime"]
		elseif bool ~= true then
			bool = TheoryCraft_Settings[bool]
		end
		if line.inverse then bool = not bool end
		if (bool) then
			leftline = line.left
			rightline = line.right
			rightlinewasnil = rightline == nil
			if leftline then
				leftline = string.gsub(leftline, "%$(.-)%$", dowork)
				leftline = string.gsub(leftline, "#OR(.-)/(.-)OR#", door)
				leftline = string.gsub(leftline, "#IF(.-)IF#", doif)
			end
			if rightline then
				rightline = string.gsub(rightline, "%$(.-)%$", dowork)
				rightline = string.gsub(rightline, "#OR(.-)/(.-)OR#", door)
				rightline = string.gsub(rightline, "#IF(.-)IF#", doif)
			end
			if leftline and strfind(leftline, "%$NOT FOUND%$") then leftline = nil end
			if rightline and strfind(rightline, "%$NOT FOUND%$") then rightline = nil end
			red, green, blue = dr, dg, db
			first = true
			if leftline then
				leftline = string.gsub(leftline, "#c(.-),(.-),(.-)#", docolour)
				lr, lg, lb = red, green, blue
				rr, rg, rb = red, green, blue
			end
			if leftline and strfind(leftline, "#TITLE=(.-)#") then
				_, _, titletext = strfind(leftline, "#TITLE=(.-)#")
				tr = lr
				tg = lg
				tb = lb
				leftline = nil
				rightline = nil
			end
			first = true
			if rightline then
				rightline = string.gsub(rightline, "#c(.-),(.-),(.-)#", docolour)
				rr, rg, rb = red, green, blue
			end
			if leftline then
				if titletext then
					frame:AddLine(titletext, tr, tg, tb)
					titletext = nil
				end
				if strfind(leftline, "#WRAP#") then
					leftline = string.gsub(leftline, "#WRAP#", "")
					frame:AddLine(leftline, lr, lg, lb, true)
				elseif rightline then
					frame:AddDoubleLine(leftline, rightline, lr, lg, lb, rr, rg, rb)
				else
					frame:AddLine(leftline, lr, lg, lb)
				end
			end
		end
	end
	frame:Show()
	return frame
end