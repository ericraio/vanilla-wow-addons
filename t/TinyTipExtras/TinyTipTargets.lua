--[[
-- Name: TinyTip
-- Author: Thrae of Maelstrom (aka "Matthew Carras")
-- Release Date: 6-25-06
--
-- These functions include adding target data. 
-- If you don't use these options, then you can safely 
-- remove it from the TOC.
--]]

local _G = getfenv(0)
local tmp,tmp2,i,pid,RaidTable,c
local strformat = string.format
local tooltip = _G.GameTooltip
local fGetName = UIParent.GetName
local gtAddLine, AddDoubleLine = GameTooltip.AddLine, GameTooltip.AddDoubleLine
local fsSetText, fsGetText = _G.GameTooltipTextLeft1.SetText, _G.GameTooltipTextLeft1.GetText

_G.TinyTipTargetsExists = true

function TinyTipTargets_ResetReferences(_AddLine,_AddDoubleLine, _tooltip)
	gtAddLine, gtAddDoubleLine, tooltip = _AddLine, _AddDoubleLine, _tooltip
end

-- Add Target of Mouseover (what they're targeting)
function TinyTipTargets_Mouse(unit,flag)
	pid = unit .. "target"
	if _G.UnitExists(pid) then
		tmp = _G.UnitIsUnit(pid, "player")
		c = _G[ fGetName(tooltip) .. "TextLeft1" ]
		tmp2 = strformat("%s : |cFF%s%s|r", 
				(flag == 2 and fsGetText(c)) or _G.TinyTipTargetsLocale_Targeting, 
				(not tmp and _G.UnitIsPlayer(pid) and _G.TinyTip_ColorPlayer(pid)) or "FFFFFF", 
				(not tmp and (_G.UnitName(pid) or "Unknown")) or _G.TinyTipTargetsLocale_YOU)
		if flag == 2 then
			fsSetText( c, tmp2)
		else
			gtAddLine( tooltip, tmp2)
		end
	end
end

-- Add How Many Raid Members are targeting this unit (except you)
function TinyTipTargets_Raid(unit,num,flag)
		c,tmp2 = 0,nil
		if flag == 2 then
			if not RaidTable then RaidTable = {} end
			for c,tmp in RaidTable do
				if tmp then RaidTable[c]["n"] = 0 end
			end
		end
		for i = 1,num,1 do
			pid = "raid" .. i
			if _G.UnitIsUnit(pid .. "target",unit) and not _G.UnitIsUnit(pid,"player") then
				if flag == 2 then
					_,c = _G.UnitClass(pid)
					if c then
						if not RaidTable[c] then RaidTable[c] = {} end
						if not RaidTable[c]["l"] then RaidTable[c]["l"] = _G.UnitClass(pid) end
						RaidTable[c]["n"] = (RaidTable[c]["n"] or 0) + 1
					end
				elseif flag == 3 then
					tmp2 = strformat("%s|cFF%s%s|r\n", 
										  tmp2 or "", _G.TinyTip_ColorPlayer(pid), _G.UnitName(pid) or "Unknown")
					c = c + 1
				else
					if not tmp2 then tmp2 = 0 end
					tmp2 = tmp2 + 1
				end
			end
		end
		if flag == 2 and RaidTable then
			gtAddLine( tooltip, _G.TinyTipTargetsLocale_TargetedBy .. ":\n" ) 
			for c,tmp in RaidTable do
				if tmp and tmp.n and tmp.n > 0 and tmp.l then
					gtAddLine( tooltip, strformat("|cFF%s%s|r: %d", 
										  strformat("%2x%2x%2x", 
														_G.RAID_CLASS_COLORS[c].r*255, 
														_G.RAID_CLASS_COLORS[c].g*255, 
														_G.RAID_CLASS_COLORS[c].b*255), 
										  tmp.l,
										  tmp.n ) )
				end
			end
		elseif tmp2 and flag == 3 then
			gtAddLine( tooltip, strformat("%s: %s%s", 
								 _G.TinyTipTargetsLocale_TargetedBy, 
								 ((c > 1) and "\n") or "",
								tmp2) )
		elseif tmp2 and tmp2 > 0 then
			gtAddLine( tooltip, strformat("%s: (|cFFFFFFFF%s|r) %s", 
											_G.TinyTipTargetsLocale_TargetedBy, tostring(tmp2), 
											_G.RAID) )
		end
end

-- Add How Many Party Members are targeting this unit (except you)
function TinyTipTargets_Party(unit, num, flag)
		tmp,tmp2 = 0,nil
		for i = 1,num,1 do
			pid = "party" .. i	
			if _G.UnitIsUnit(pid .. "target",unit) and not _G.UnitIsUnit(pid, "player") then
				if flag ~= 2 then
					tmp2 = strformat("%s|cFF%s%s|r\n", 
										  tmp2 or "", _G.TinyTip_ColorPlayer(pid), _G.UnitName(pid) or "Unknown")
					tmp = tmp + 1
					
				else
					if not tmp2 then tmp2 = 0 end
					tmp2 = tmp2 + 1
				end
			end
		end
		if tmp2 then
			if flag ~= 2 then
				gtAddLine( tooltip, strformat("%s: %s%s", 
									_G.TinyTipTargetsLocale_TargetedBy, 
									((tmp > 0) and "\n") or "",
									tmp2) )
			else
				gtAddLine( tooltip, strformat("%s: (|cFFFFFFFF%s|r) %s", 
											 _G.TinyTipTargetsLocale_TargetedBy, tmp2, _G.TUTORIAL_TITLE19) )
			end
		end
end
