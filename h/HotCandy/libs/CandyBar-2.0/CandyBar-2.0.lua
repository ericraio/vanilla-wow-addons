--[[
Name: CandyBar-2.0
Revision: $Rev: 13442 $
Author: Ammo (wouter@muze.nl)
Website: http://www.wowace.com/
Documentation: http://www.wowace.com/
SVN: svn://svn.wowace.com/root/trunk/CandyBar/CandyBar-2.0
Description: A timer bars library
Dependencies: AceLibrary, AceOO-2.0, PaintChips-2.0, (optional) Compost-2.0
]]

local vmajor, vminor = "CandyBar-2.0", "$Revision: 13442 $"

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(vmajor, vminor) then return end

if not AceLibrary:HasInstance("AceOO-2.0") then error(vmajor .. " requires AceOO-2.0") end

if not AceLibrary:HasInstance("PaintChips-2.0") then error(vmajor .. " requires PaintChips-2.0") end

local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")
local paint = AceLibrary("PaintChips-2.0")

local AceOO = AceLibrary:GetInstance("AceOO-2.0")
local Mixin = AceOO.Mixin
local CandyBar = Mixin {
	"RegisterCandyBar",
	"UnregisterCandyBar",
	"IsCandyBarRegistered",
	"StartCandyBar",
	"StopCandyBar",
	"PauseCandyBar",
	"CandyBarStatus",
	"SetCandyBarTexture",
	"SetCandyBarTime",
	"SetCandyBarColor",
	"SetCandyBarText",
	"SetCandyBarIcon",
	"SetCandyBarWidth",
	"SetCandyBarHeight",
	"SetCandyBarBackgroundColor",
	"SetCandyBarTextColor",
	"SetCandyBarTimerTextColor",
	"SetCandyBarFontSize",
	"SetCandyBarPoint",
	"SetCandyBarGradient",
	"SetCandyBarScale",
	"SetCandyBarTimeFormat",
	"SetCandyBarTimeLeft",
	"SetCandyBarCompletion",
	"SetCandyBarFade",
	"RegisterCandyBarGroup",
	"UnregisterCandyBarGroup",
	"IsCandyBarGroupRegistered",
	"SetCandyBarGroupPoint",
	"SetCandyBarGroupGrowth",
	"UpdateCandyBarGroup",
	"RegisterCandyBarWithGroup",
	"UnregisterCandyBarWithGroup",
	"IsCandyBarRegisteredWithGroup",
	"SetCandyBarReversed",
	"IsCandyBarReversed",
	"SetCandyBarOnClick",
}


local function getnewtable() return compost and compost:Acquire() or {} end
local function reclaimtable(t) if compost then compost:Reclaim(t) end end


-- Registers a new candy bar
-- name - A unique identifier for your bar.
-- time - Time for the bar
-- text - text displayed on the bar [defaults to the name if not set]
-- icon - icon off the bar [optional]
-- c1 - c10 - color of the bar [optional]
-- returns true on a succesful register
function CandyBar:Register(name, time, text, icon, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(time, 3, "number")
	if not name or not time then return end
	if CandyBar.var.handlers[name] then self:Unregister(name) end
	local t = getnewtable()
	t.name, t.time, t.text, t.icon = name, time, text or name, icon
	t.texture = CandyBar.var.defaults.texture
	t.color = {}
	if not paint:GetRGBPercent(c1) then c1 = "green" end
	_, t.color[1], t.color[2], t.color[3] = paint:GetRGBPercent(c1)
	t.color[4] = 1
	t.running = nil
	t.endtime = 0
	t.reversed = nil
	CandyBar.var.handlers[name] = t
	CandyBar.var.handlers[name].frame = CandyBar:AcquireBarFrame(name)
	if c1 and c2 then
		CandyBar:SetGradient( name, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	end
	return true
end


-- Removes a candy bar
-- a1 - a10 handlers that you wish to remove
-- returns true upon sucessful removal
function CandyBar:Unregister(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10)
	CandyBar:argCheck(a1, 2, "string")
	if not CandyBar.var.handlers[a1] then return end
	CandyBar:UnregisterWithGroup(a1)
	CandyBar:ReleaseBarFrame(a1)
	reclaimtable(CandyBar.var.handlers[a1])
	CandyBar.var.handlers[a1] = nil
	if a2 then CandyBar:Unregister(a2,a3,a4,a5,a6,a7,a8,a9,a10)
	elseif not CandyBar:HasHandlers() then CandyBar.var.frame:Hide() end
	return true
end

-- Checks if a candy bar is registered
-- Args: name - name of the candybar
-- returns true if a the candybar is registered
function CandyBar:IsRegistered(name)
	CandyBar:argCheck(name, 2, "string")
	if CandyBar.var.handlers[name] then return true end
	return false
end

-- Start a bar
-- Args:  name - the candybar you want to start
--        fireforget [optional] - pass true if you want the bar to unregister upon completion
-- returns true if succesful
function CandyBar:Start( name, fireforget )
	CandyBar:argCheck(name, 2, "string")
	if not CandyBar.var.handlers[name] then return end
	local t = GetTime()
	if CandyBar.var.handlers[name].paused then
		local pauseoffset = t - CandyBar.var.handlers[name].pausetime
		CandyBar.var.handlers[name].endtime = CandyBar.var.handlers[name].endtime + pauseoffset
		CandyBar.var.handlers[name].starttime = CandyBar.var.handlers[name].starttime + pauseoffset
	else
		-- bar hasn't elapsed a second.
		CandyBar.var.handlers[name].elapsed = 0
		CandyBar.var.handlers[name].endtime = t + CandyBar.var.handlers[name].time
		CandyBar.var.handlers[name].starttime = t
	end
	CandyBar.var.handlers[name].fireforget = fireforget
	CandyBar.var.handlers[name].running = true
	CandyBar.var.handlers[name].paused = nil
	CandyBar.var.handlers[name].fading = nil
	CandyBar:AcquireBarFrame( name ) -- this will reset the barframe incase we were fading out when it was restarted
	CandyBar.var.handlers[name].frame:Show()
	if CandyBar.var.handlers[name].group then CandyBar:UpdateGroup( CandyBar.var.handlers[name].group ) end -- update the group
	CandyBar.var.frame:Show()
	return true

end

-- Stop a bar
-- Args:  name - the candybar you want to stop
-- returns true if succesful
function CandyBar:Stop( name)
	CandyBar:argCheck(name, 2, "string")
	if not CandyBar.var.handlers[name] then return end

	CandyBar.var.handlers[name].running = nil
	CandyBar.var.handlers[name].paused = nil

	if CandyBar.var.handlers[name].fadeout then
		CandyBar.var.handlers[name].frame.spark:Hide()
		CandyBar.var.handlers[name].fading = true
		CandyBar.var.handlers[name].fadeelapsed = 0
		local t = GetTime()
		if CandyBar.var.handlers[name].endtime > t then
			CandyBar.var.handlers[name].endtime = t
		end

		local reversed = CandyBar.var.handlers[name].reversed
	else
		CandyBar.var.handlers[name].frame:Hide()
		CandyBar.var.handlers[name].starttime = nil
		CandyBar.var.handlers[name].endtime = 0
		if CandyBar.var.handlers[name].group then CandyBar:UpdateGroup(CandyBar.var.handlers[name].group) end
		if CandyBar.var.handlers[name].fireforget then
			return CandyBar:Unregister(name)
		end
	end
	if not CandyBar:HasHandlers() then CandyBar.var.frame:Hide() end
	return true
end

-- Pause a bar
-- Name - the candybar you want to pause
-- returns true if succesful
function CandyBar:Pause( name )
	CandyBar:argCheck(name, 2, "string")
	if not CandyBar.var.handlers[name] then return end
	CandyBar.var.handlers[name].pausetime = GetTime()
	CandyBar.var.handlers[name].paused = true
	CandyBar.var.handlers[name].running = nil
end

-- Query a timer's status
-- Args: name - the schedule you wish to look up
-- Returns: registered - true if a schedule exists with this name
--	    time    - time for this bar
--          elapsed - time elapsed for this bar
--          running - true if this schedule is currently running
function CandyBar:Status(name)
	CandyBar:argCheck(name, 2, "string")
	if not CandyBar.var.handlers[name] then return end
	return true, CandyBar.var.handlers[name].time, CandyBar.var.handlers[name].elapsed, CandyBar.var.handlers[name].running, CandyBar.var.handlers[name].paused
end


-- Set the time for a bar.
-- Args: name - the candybar name
--	 time - the new time for this bar
-- returns true if succesful
function CandyBar:SetTime(name, time)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(time, 3, "number")
	if not CandyBar.var.handlers[name] then return end
	CandyBar.var.handlers[name].time = time

	return true
end

-- Set the time left for a bar.
-- Args: name - the candybar name
--       time - time left on the bar
-- returns true if succesful

function CandyBar:SetTimeLeft(name, time)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(time, 3, "number")
	if not CandyBar.var.handlers[name] then return end
	if CandyBar.var.handlers[name].time < time or time < 0 then return end

	local e = CandyBar.var.handlers[name].time - time
	local d = CandyBar.var.handlers[name].elapsed - e
	if CandyBar.var.handlers[name].starttime and CandyBar.var.handlers[name].endtime then
		CandyBar.var.handlers[name].starttime = CandyBar.var.handlers[name].starttime + d
		CandyBar.var.handlers[name].endtime = CandyBar.var.handlers[name].endtime + d
	end

	CandyBar.var.handlers[name].elapsed = e

	return true
end

-- Sets smooth coloring of the bar depending on time elapsed
-- Args: name - the candybar name
--       c1 - c10 color order of the gradient
-- returns true when succesful
function CandyBar:SetGradient(name, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	CandyBar:argCheck(name, 2, "string")

	CandyBar:argCheck(c1, 3, "string")
	CandyBar:argCheck(c2, 4, "string")

	if not CandyBar.var.handlers[name] then return end
	if not c1 or not c2 then return end


	local gtable = {}

	gtable[1] = {}
	gtable[2] = {}

	if not paint:GetRGBPercent(c1) then c1 = "green" end
	if not paint:GetRGBPercent(c2) then c2 = "green" end
	if c3 and not paint:GetRGBPercent(c3) then c3 = "green" end
	if c4 and not paint:GetRGBPercent(c4) then c4 = "green" end
	if c5 and not paint:GetRGBPercent(c5) then c5 = "green" end
	if c6 and not paint:GetRGBPercent(c6) then c6 = "green" end
	if c7 and not paint:GetRGBPercent(c7) then c7 = "green" end
	if c8 and not paint:GetRGBPercent(c8) then c8 = "green" end
	if c9 and not paint:GetRGBPercent(c9) then c9 = "green" end
	if c10 and not paint:GetRGBPercent(c10) then c10 = "green" end

	_, gtable[1][1], gtable[1][2], gtable[1][3] = paint:GetRGBPercent(c1)
	_, gtable[2][1], gtable[2][2], gtable[2][3] = paint:GetRGBPercent(c2)
	if c3 then gtable[3] = {} _, gtable[3][1], gtable[3][2], gtable[3][3] = paint:GetRGBPercent(c3) end
	if c4 then gtable[4] = {} _, gtable[4][1], gtable[4][2], gtable[4][3] = paint:GetRGBPercent(c4) end
	if c5 then gtable[5] = {} _, gtable[5][1], gtable[5][2], gtable[5][3] = paint:GetRGBPercent(c5) end
	if c6 then gtable[6] = {} _, gtable[6][1], gtable[6][2], gtable[6][3] = paint:GetRGBPercent(c6) end
	if c7 then gtable[7] = {} _, gtable[7][1], gtable[3][2], gtable[7][3] = paint:GetRGBPercent(c7) end
	if c8 then gtable[8] = {} _, gtable[8][1], gtable[8][2], gtable[8][3] = paint:GetRGBPercent(c8) end
	if c9 then gtable[9] = {} _, gtable[9][1], gtable[9][2], gtable[9][3] = paint:GetRGBPercent(c9) end
	if c10 then gtable[10] = {} _, gtable[10][1], gtable[10][2], gtable[10][3] = paint:GetRGBPercent(c10) end



	local max = table.getn(gtable)

	for i = 1, max do
		if not gtable[i][4] then gtable[i][4] = 1 end
		gtable[i][5] = (i-1) / (max-1)
	end

	self.var.handlers[name].gradienttable = gtable
	self.var.handlers[name].gradient = true

	CandyBar.var.handlers[name].frame.statusbar:SetStatusBarColor( gtable[1][1], gtable[1][2], gtable[1][3], gtable[1][4])

	return true
end

-- Set the color of the bar
-- Args: name - the candybar name
--	 color - new color of the bar
--	 alpha - new alpha of the bar
-- Setting the color will override smooth settings.
function CandyBar:SetColor(name, color, alpha)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(color, 3, "string")

	if not CandyBar.var.handlers[name] then return end

	if not paint:GetRGBPercent(color) then return end

	local ctable = {}

	_, ctable[1], ctable[2], ctable[3] = paint:GetRGBPercent(color)

	if alpha then ctable[4] = alpha else ctable[4] = 1 end

	CandyBar.var.handlers[name].color = ctable
	CandyBar.var.handlers[name].gradient = nil

	CandyBar.var.handlers[name].frame.statusbar:SetStatusBarColor( ctable[1], ctable[2], ctable[3], ctable[4] )

	return true
end

-- Set the color of background of the bar
-- Args: name - the candybar name
--	 color - new color of the bar
-- 	 alpha - new alpha of the bar
-- Setting the color will override smooth settings.
function CandyBar:SetBackgroundColor(name, color, alpha)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(color, 3, "string")

	if not CandyBar.var.handlers[name] then return end

	if not paint:GetRGBPercent(color) then return end

	local ctable = {}

	_, ctable[1], ctable[2], ctable[3] = paint:GetRGBPercent(color)

	if alpha then ctable[4] = alpha else ctable[4] = 1 end

	CandyBar.var.handlers[name].bgcolor = ctable

	CandyBar.var.handlers[name].frame.statusbarbg:SetStatusBarColor( ctable[1], ctable[2], ctable[3], ctable[4] )

	return true
end

-- Set the color for the bar text
-- Args: name - name of the candybar
--	 color - new color of the text
--	 alpha - new alpha of the text
-- returns true when succesful
function CandyBar:SetTextColor(name, color, alpha)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(color, 3, "string")

	if not CandyBar.var.handlers[name] then return end

	if not paint:GetRGBPercent(color) then return end

	local ctable = {}

	_, ctable[1], ctable[2], ctable[3] = paint:GetRGBPercent(color)

	if alpha then ctable[4] = alpha else ctable[4] = 1 end


	CandyBar.var.handlers[name].textcolor = ctable

	CandyBar.var.handlers[name].frame.text:SetTextColor( ctable[1], ctable[2], ctable[3], ctable[4] )

	return true
end

-- Set the color for the timer text
-- Args: name - name of the candybar
--	 color - new color of the text
--	 alpha - new alpha of the text
-- returns true when succesful
function CandyBar:SetTimerTextColor(name, color, alpha)
        CandyBar:argCheck(name, 2, "string")
        CandyBar:argCheck(color, 3, "string")
	if not CandyBar.var.handlers[name] then return end

	if not paint:GetRGBPercent(color) then return end

	local ctable = {}

	_, ctable[1], ctable[2], ctable[3] = paint:GetRGBPercent(color)

	if alpha then ctable[4] = alpha else ctable[4] = 1 end

	CandyBar.var.handlers[name].timertextcolor = ctable

	CandyBar.var.handlers[name].frame.timertext:SetTextColor( ctable[1], ctable[2], ctable[3], ctable[4] )

	return true
end

-- Set the text for the bar
-- Args: name - name of the candybar
--       text - text to set it to
-- returns true when succesful
function CandyBar:SetText(name, text)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(text, 2, "string")
	if not CandyBar.var.handlers[name] then return end

	CandyBar.var.handlers[name].text = text
	CandyBar.var.handlers[name].frame.text:SetText(text)

	return true
end

-- Set the fontsize
-- Args: name - name of the candybar
-- 	     fontsize - new fontsize
-- returns true when succesful
function CandyBar:SetFontSize(name, fontsize)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(fontsize, 3, "number")

	if not CandyBar.var.handlers[name] then return end

	local font, _, _ = GameFontHighlight:GetFont()
	local timertextwidth = fontsize * 3
	local width = CandyBar.var.handlers[name].width or CandyBar.var.defaults.width
	local f = CandyBar.var.handlers[name].frame

	CandyBar.var.handlers[name].fontsize = fontsize
	f.timertext:SetFont(font, fontsize)
	f.text:SetFont(font, fontsize)
	f.timertext:SetWidth( timertextwidth )
	f.text:SetWidth( ( width - timertextwidth ) * .9 )

	return true
end


-- Set the point where a bar should be anchored
-- Args: name -- name of the bar
-- 	 point -- anchor point
-- 	 rframe -- relative frame
-- 	 rpoint -- relative point
-- 	 xoffset -- x offset
-- 	 yoffset -- y offset
-- returns true when succesful
function CandyBar:SetPoint(name, point, rframe, rpoint, xoffset, yoffset)
        CandyBar:argCheck(name, 2, "string")

	if not CandyBar.var.handlers[name] then return end

	CandyBar.var.handlers[name].point = point
	CandyBar.var.handlers[name].rframe = rframe
	CandyBar.var.handlers[name].rpoint = rpoint
	CandyBar.var.handlers[name].xoffset = xoffset
	CandyBar.var.handlers[name].yoffset = yoffset

	CandyBar.var.handlers[name].frame:ClearAllPoints()
	CandyBar.var.handlers[name].frame:SetPoint(point, rframe,rpoint,xoffset,yoffset)

	return true
end

-- Set the width for a bar
-- Args: name - name of the candybar
--       width - new width of the candybar
-- returns true when succesful
function CandyBar:SetWidth(name, width)
        CandyBar:argCheck(name, 2, "string")
        CandyBar:argCheck(width, 3, "number")

	if not CandyBar.var.handlers[name] then return end

	local height = CandyBar.var.handlers[name].height or CandyBar.var.defaults.height
	local fontsize = CandyBar.var.handlers[name].fontsize or CandyBar.var.defaults.fontsize
	local timertextwidth = fontsize * 3
	local f = CandyBar.var.handlers[name].frame
	f:SetWidth( width + height )
	f.statusbar:SetWidth( width )
	f.statusbarbg:SetWidth( width )

	f.timertext:SetWidth( timertextwidth )
	f.text:SetWidth( ( width - timertextwidth ) * .9 )

	CandyBar.var.handlers[name].width = width

	return true
end

-- Set the height for a bar
-- Args: name - name of the candybar
--       height - new height for the bar
-- returs true when succesful
function CandyBar:SetHeight(name, height)
        CandyBar:argCheck(name, 2, "string")
        CandyBar:argCheck(height, 3, "number")

	if not CandyBar.var.handlers[name] then return end

	local width = CandyBar.var.handlers[name].width or CandyBar.var.defaults.width
	local f = CandyBar.var.handlers[name].frame

	f:SetWidth( width + height )
	f:SetHeight( height )
	f.icon:SetWidth( height )
	f.icon:SetHeight( height )
	f.statusbar:SetHeight( height )
	f.statusbarbg:SetHeight( height )
	f.spark:SetHeight( height + 25 )

	f.statusbarbg:SetPoint( "TOPLEFT", f, "TOPLEFT", height, 0)
	f.statusbar:SetPoint("TOPLEFT", f, "TOPLEFT", height, 0)

	CandyBar.var.handlers[name].height = height


	return true
end

-- Set the scale for a bar
-- Args: name - name of the candybar
-- 	 scale - new scale of the bar
-- returns true when succesful
function CandyBar:SetScale(name, scale)
        CandyBar:argCheck(name, 2, "string")
        CandyBar:argCheck(scale, 3, "number")

	if not CandyBar.var.handlers[name] then return end

	CandyBar.var.handlers[name].scale = scale

	CandyBar.var.handlers[name].frame:SetScale( scale )

	return true
end

-- Set the time formatting function for a bar
-- Args: name - name of the candybar
--       func - function that returns the formatted string
-- 	     a1-a10 - optional arguments to that function
-- returns true when succesful

function CandyBar:SetTimeFormat(name, func, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(func, 3, "function")

	if not CandyBar.var.handlers[name] then return end
	CandyBar.var.handlers[name].timeformat = func
	CandyBar.var.handlers[name].timeformat1 = a1
	CandyBar.var.handlers[name].timeformat2 = a2
	CandyBar.var.handlers[name].timeformat3 = a3
	CandyBar.var.handlers[name].timeformat4 = a4
	CandyBar.var.handlers[name].timeformat5 = a5
	CandyBar.var.handlers[name].timeformat6 = a6
	CandyBar.var.handlers[name].timeformat7 = a7
	CandyBar.var.handlers[name].timeformat8 = a8
	CandyBar.var.handlers[name].timeformat9 = a9
	CandyBar.var.handlers[name].timeformat10 = a10

	return true
end

-- Set the completion function for a bar
-- Args: name - name of the candybar
--		   func - function to call upon ending of the bar
--       a1 - a10 - arguments to pass to the function
-- returns true when succesful
function CandyBar:SetCompletion(name, func, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(func, 3, "function")

	if not CandyBar.var.handlers[name] then return end
	CandyBar.var.handlers[name].completion = func
	CandyBar.var.handlers[name].completion1 = a1
	CandyBar.var.handlers[name].completion2 = a2
	CandyBar.var.handlers[name].completion3 = a3
	CandyBar.var.handlers[name].completion4 = a4
	CandyBar.var.handlers[name].completion5 = a5
	CandyBar.var.handlers[name].completion6 = a6
	CandyBar.var.handlers[name].completion7 = a7
	CandyBar.var.handlers[name].completion8 = a8
	CandyBar.var.handlers[name].completion9 = a9
	CandyBar.var.handlers[name].completion10 = a10

	return true

end

-- Set the on click function for a bar
-- Args: name - name of the candybar
--		   func - function to call when the bar is clicked
--       a1 - a10 - arguments to pass to the function
-- returns true when succesful
function CandyBar:SetOnClick(name, func, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	CandyBar:argCheck(name, 2, "string")
	if func then CandyBar:argCheck(func, 3, "function") end

	if not CandyBar.var.handlers[name] then return end
	CandyBar.var.handlers[name].onclick = func
	CandyBar.var.handlers[name].onclick1 = a1
	CandyBar.var.handlers[name].onclick2 = a2
	CandyBar.var.handlers[name].onclick3 = a3
	CandyBar.var.handlers[name].onclick4 = a4
	CandyBar.var.handlers[name].onclick5 = a5
	CandyBar.var.handlers[name].onclick6 = a6
	CandyBar.var.handlers[name].onclick7 = a7
	CandyBar.var.handlers[name].onclick8 = a8
	CandyBar.var.handlers[name].onclick9 = a9
	CandyBar.var.handlers[name].onclick10 = a10

	if func then
		-- enable mouse
		CandyBar.var.handlers[name].frame:EnableMouse(true)
		CandyBar.var.handlers[name].frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
		CandyBar.var.handlers[name].frame:SetScript("OnClick", function() CandyBar:OnClick() end )
		CandyBar.var.handlers[name].frame.icon:EnableMouse(true)
		CandyBar.var.handlers[name].frame.icon:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
		CandyBar.var.handlers[name].frame.icon:SetScript("OnClick", function() CandyBar:OnClick() end )
	else
		CandyBar.var.handlers[name].frame:EnableMouse(false)
		CandyBar.var.handlers[name].frame:RegisterForClicks()
		CandyBar.var.handlers[name].frame:SetScript("OnClick", nil )
		CandyBar.var.handlers[name].frame.icon:EnableMouse(false)
		CandyBar.var.handlers[name].frame.icon:RegisterForClicks()
		CandyBar.var.handlers[name].frame.icon:SetScript("OnClick", nil )	
	end

	return true

end
-- Set the texture for a bar
-- Args: name - name of the candybar
--	 texture - new texture, if passed nil, the texture is reset to default
-- returns true when succesful
function CandyBar:SetTexture(name, texture)
        CandyBar:argCheck(name, 2, "string")
	if texture then CandyBar:argCheck(texture, 3, "string") end

	if not CandyBar.var.handlers[name] then return end
	if not texture then texture = CandyBar.var.defaults.texture end

	CandyBar.var.handlers[name].texture = texture

	CandyBar.var.handlers[name].frame.statusbar:SetStatusBarTexture(texture)
	CandyBar.var.handlers[name].frame.statusbarbg:SetStatusBarTexture(texture)

	return true
end

-- Set the icon on a bar
-- Args: name - name of the candybar
-- 	 icon - icon path, nil removes the icon
-- returns true when succesful
function CandyBar:SetIcon(name, icon)
	CandyBar:argCheck(name, 2, "string")
        CandyBar:argCheck(icon, 3, "string")

	if not CandyBar.var.handlers[name] then return end
	CandyBar.var.handlers[name].icon = icon

	if not icon then
		CandyBar.var.hanlders[name].frame.icon:Hide()
	else
		CandyBar.var.handlers[name].frame.icon:SetNormalTexture( icon )
		CandyBar.var.handlers[name].frame.icon:Show()
	end

	return true
end

-- Sets the fading style of a candybar
-- args: name - name of the candybar
--			 time - duration of the fade (default .5 seconds), negative to keep the bar on screen
-- returns true when succesful
function CandyBar:SetFade(name, time, fade)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(time, 3, "number")
	if not CandyBar.var.handlers[name] then return end

	CandyBar.var.handlers[name].fadetime = time
	CandyBar.var.handlers[name].fadeout = true

	return true
end


function CandyBar:SetReversed(name, reversed)
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(reversed, 3, "boolean")
	if not CandyBar.var.handlers[name] then return end
	
	CandyBar.var.handlers[name].reversed = reversed
	return true
end

function CandyBar:IsReversed(name)
	CandyBar:argCheck(name, 2, "string")
	if not CandyBar.var.handlers[name] then return end

	return CandyBar.var.handlers[name].reversed
end


-- Registers a candybar with a certain candybar group
-- args: name - name of the candybar
--       group - group to register the bar with
-- returns true when succesful
function CandyBar:RegisterWithGroup( name, group )
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(group, 3, "string")

	if not CandyBar.var.handlers[name] or not CandyBar.var.groups[group] then return end

	CandyBar:UnregisterWithGroup(name)

	table.insert( CandyBar.var.groups[group].bars, name)
	-- CandyBar.var.groups[group].bars[name] = name
	CandyBar.var.handlers[name].group = group
	CandyBar:UpdateGroup(group)

	return true
end

-- Unregisters a candybar from its group
-- args: name - name of the candybar
-- returns true when succesful

function CandyBar:UnregisterWithGroup( name )
	CandyBar:argCheck(name, 2, "string")
	if not CandyBar.var.handlers[name] then return end
	--if not CandyBar.var.handlers[name].group then return end

	local group = CandyBar.var.handlers[name].group
	if not CandyBar.var.groups[group] then return end

	for k,v in pairs( CandyBar.var.groups[group].bars ) do
		if v == name then
			table.remove( CandyBar.var.groups[group].bars, k)
		end
	end
	-- CandyBar.var.groups[group].bars[name] = nil
	CandyBar.var.handlers[name].group = nil

	CandyBar:UpdateGroup(group)

	return true

end



-- Register a Candybar group
-- Args: name - name of the candybar group
-- returns true when succesful
function CandyBar:RegisterGroup( name )
	CandyBar:argCheck(name, 2, "string")
	if CandyBar.var.groups[name] then return end

	local t = getnewtable()

	t.point = "CENTER"
	t.rframe = UIParent
	t.rpoint = "CENTER"
	t.xoffset = 0
	t.yoffset = 0
	t.bars = {}

	CandyBar.var.groups[name] = t
	return true
end

-- Unregister a candybar group
-- Args: a1-a2 candybar group ids
-- returns true when succesful

function CandyBar:UnregisterGroup( a1, a2, a3, a4, a5, a6, a7, a8, a9, a10 )
	CandyBar:argCheck(a1, 2, "string")
	if not CandyBar.var.groups[a1] then return end
	reclaimtable(CandyBar.var.groups[a1])
	CandyBar.var.groups[a1] = nil

	if a2 then CandyBar:UnregisterGroup( a2, a3,a4, a5, a6, a7, a8, a9, a10 )	end

	return true
end

-- Checks if a group is registered
-- Args: name - Candybar group
-- returns true if the candybar group is registered
function CandyBar:IsGroupRegistered( name )
	CandyBar:argCheck(name, 2, "string")
	if not CandyBar.var.groups[name] then return false end
	return true
end

-- Checks if a bar is registered with a group
-- Args: name - Candybar name
--       group - group id [optional]
-- returns true is the candybar is registered with a/the group
function CandyBar:IsRegisteredWithGroup( name, group )
	CandyBar:argCheck(name, 2, "string")
	if not CandyBar.var.handlers[name] then return end

	if group then
		if not CandyBar.var.groups[group] then return false end
		if CandyBar.var.handlers[name].group == group then return true end
	elseif CandyBar.var.handlers[name].group then
		return true
	end
	return false
end


-- Set the point for a CanyBargroup
-- 	 point -- anchor point
-- 	 rframe -- relative frame
-- 	 rpoint -- relative point
-- 	 xoffset [optional] -- x offset
-- 	 yoffset [optional] -- y offset
-- The first bar of the group will be anchored at the anchor.
-- returns true when succesful

function CandyBar:SetGroupPoint(name, point, rframe, rpoint, xoffset, yoffset )
	CandyBar:argCheck(name, 2, "string")
	if not CandyBar.var.groups[name] then return end

	CandyBar.var.groups[name].point = point
	CandyBar.var.groups[name].rframe = rframe
	CandyBar.var.groups[name].rpoint = rpoint
	CandyBar.var.groups[name].xoffset = xoffset
	CandyBar.var.groups[name].yoffset = yoffset
	CandyBar:UpdateGroup(name)
	return true
end


-- SetGroupGrowth - sets the group to grow up or down
-- Args: name - name of the candybar group
--       growup - true if growing up, false for growing down
-- returns true when succesful
function CandyBar:SetGroupGrowth( name, growup )
	CandyBar:argCheck(name, 2, "string")
	CandyBar:argCheck(growup, 3, "boolean")

	if not CandyBar.var.groups[name] then return end

	CandyBar.var.groups[name].growup = growup

	CandyBar:UpdateGroup(name)

	return true
end

function CandyBar:SortGroup( name )
	if not CandyBar.var.groups[name] then return end
	table.sort( CandyBar.var.groups[name].bars,
		function( a, b )
				return CandyBar.var.handlers[a].endtime < CandyBar.var.handlers[b].endtime
		end
	)
end

-- internal method
-- UpdateGroup - updates the location of bars in a group
-- Args: name - name of the candybar group
-- returns true when succesful

function CandyBar:UpdateGroup( name )
	if not CandyBar.var.groups[name] then return end

	local point = CandyBar.var.groups[name].point
	local rframe = CandyBar.var.groups[name].rframe
	local rpoint = CandyBar.var.groups[name].rpoint
	local xoffset = CandyBar.var.groups[name].xoffset
	local yoffset = CandyBar.var.groups[name].yoffset
	local m = -1
	if CandyBar.var.groups[name].growup then m = 1 end

	local bar = 0
	local barh = 0

	CandyBar:SortGroup( name )

	for c,n in pairs(CandyBar.var.groups[name].bars) do
		if CandyBar.var.handlers[n] then
			if CandyBar.var.handlers[n].frame:IsShown() then
				CandyBar:SetPoint(n, point, rframe, rpoint, xoffset, yoffset + (m * bar))
				barh = CandyBar.var.handlers[n].height or CandyBar.var.defaults.height
				bar = bar + barh
			end
		end
	end
	return true
end

-- Internal Method
-- Update a bar on screen
function CandyBar:Update( name )

	if not CandyBar.var.handlers[name] then return end

	local t = CandyBar.var.handlers[name].time - CandyBar.var.handlers[name].elapsed

	local timetext

	local reversed = CandyBar.var.handlers[name].reversed

	if CandyBar.var.handlers[name].timeformat then
		local c = CandyBar.var.handlers[name]
		timetext = CandyBar.var.handlers[name].timeformat(t, c.timeformat1, c.timeformat2, c.timeformat3, c.timeformat4, c.timeformat5, c.timeformat6, c.timeformat7, c.timeformat8, c.timeformat9, c.timeformat10 )
	else
		local h = floor(t/3600)
		local m = t - (h*3600)
		m = floor(m/60)
		local s = t - ((h*3600) + (m*60))
		if h > 0 then
			timetext = string.format("%d:%02d", h, m)
		elseif m > 0 then
			timetext = string.format("%d:%02d", m, s)
		elseif s < 10 then
			timetext = string.format("%1.1f", s)
		else
			timetext = string.format("%d", floor(s))
		end
	end
	CandyBar.var.handlers[name].frame.timertext:SetText(timetext)

	local perc = t / CandyBar.var.handlers[name].time

	CandyBar.var.handlers[name].frame.statusbar:SetValue(reversed and 1-perc or perc)

	local width = CandyBar.var.handlers[name].width or CandyBar.var.defaults.width

	local sp = width * perc
	sp = reversed and -sp or sp
	CandyBar.var.handlers[name].frame.spark:SetPoint("CENTER", CandyBar.var.handlers[name].frame.statusbar, reversed and "RIGHT" or "LEFT", sp, 0)

	if CandyBar.var.handlers[name].gradient then
		local p = CandyBar.var.handlers[name].elapsed / CandyBar.var.handlers[name].time
		local gstart, gend, gp
		-- find the appropriate start/end
		for i = 1, table.getn(CandyBar.var.handlers[name].gradienttable)-1 do
			if CandyBar.var.handlers[name].gradienttable[i][5] < p and p <= CandyBar.var.handlers[name].gradienttable[i+1][5] then
				-- the bounds are to assure no divide by zero error here.

				gstart = self.var.handlers[name].gradienttable[i]
				gend = self.var.handlers[name].gradienttable[i+1]
				gp = (p - gstart[5]) / (gend[5] - gstart[5])
			end
		end
		if gstart and gend then
			local color = getnewtable()
			-- calculate new gradient
			local i
			for i = 1, 4 do
				-- these may be the same.. but I'm lazy to make sure.
				color[i] = gstart[i]*(1-gp) + gend[i]*(gp)
			end
			CandyBar.var.handlers[name].frame.statusbar:SetStatusBarColor( color[1], color[2], color[3], color[4])

			reclaimtable(color)
			color = nil
		end
	end
end

-- Intenal Method
-- Fades the bar out when it's complete.
function CandyBar:UpdateFade( name )
	if not CandyBar.var.handlers[name] then return end
	if not CandyBar.var.handlers[name].fading then return end

	-- if the fade is done go and keel the bar.
	if CandyBar.var.handlers[name].fadeelapsed > CandyBar.var.handlers[name].fadetime then
		CandyBar.var.handlers[name].fading = nil
		CandyBar.var.handlers[name].starttime = nil
		CandyBar.var.handlers[name].endtime = 0
		CandyBar.var.handlers[name].frame:Hide()
		if CandyBar.var.handlers[name].group then CandyBar:UpdateGroup(CandyBar.var.handlers[name].group) end
		if CandyBar.var.handlers[name].fireforget then
			return CandyBar:Unregister(name)
		end
	else -- we're fading, set the alpha for the texts, statusbar and background. fade from default to 0 in the time given.
		local t = CandyBar.var.handlers[name].fadetime - CandyBar.var.handlers[name].fadeelapsed
		local p = t / CandyBar.var.handlers[name].fadetime
		local color = CandyBar.var.handlers[name].color or CandyBar.var.defaults.color
		local bgcolor = CandyBar.var.handlers[name].bgcolor or CandyBar.var.defaults.bgcolor
		local textcolor = CandyBar.var.handlers[name].textcolor or CandyBar.var.defaults.textcolor
		local timertextcolor = CandyBar.var.handlers[name].timertextcolor or CandyBar.var.defaults.timertextcolor
		local colora = color[4] * p
		local bgcolora = bgcolor[4] * p
		local textcolora = textcolor[4] * p
		local timertextcolora = timertextcolor[4] * p

		CandyBar.var.handlers[name].frame.statusbarbg:SetStatusBarColor( bgcolor[1], bgcolor[2], bgcolor[3], bgcolora)
		CandyBar.var.handlers[name].frame.statusbar:SetStatusBarColor( color[1], color[2], color[3], colora)
		CandyBar.var.handlers[name].frame.text:SetTextColor( textcolor[1], textcolor[2], textcolor[3], textcolora )
		CandyBar.var.handlers[name].frame.timertext:SetTextColor( timertextcolor[1], timertextcolor[2], timertextcolor[3], timertextcolora )
		CandyBar.var.handlers[name].frame.icon:SetAlpha(p)
	end
	return true
end

-- Internal Method
-- Create and return a new bar frame, recycles where needed
-- Name - which candybar is this for
-- Returns the frame
function CandyBar:AcquireBarFrame( name )
	if not CandyBar.var.handlers[name] then return end

	local f = CandyBar.var.handlers[name].frame

	local color = CandyBar.var.handlers[name].color or CandyBar.var.defaults.color
	local bgcolor = CandyBar.var.handlers[name].bgcolor or CandyBar.var.defaults.bgcolor
	local icon = CandyBar.var.handlers[name].icon or nil
	local texture = CandyBar.var.handlers[name].texture or CandyBar.var.defaults.texture
	local width = CandyBar.var.handlers[name].width or CandyBar.var.defaults.width
	local height = CandyBar.var.handlers[name].height or CandyBar.var.defaults.height
	local point = CandyBar.var.handlers[name].point or CandyBar.var.defaults.point
	local rframe = CandyBar.var.handlers[name].rframe or CandyBar.var.defaults.rframe
	local rpoint = CandyBar.var.handlers[name].rpoint or CandyBar.var.defaults.rpoint
	local xoffset = CandyBar.var.handlers[name].xoffset or CandyBar.var.defaults.xoffset
	local yoffset = CandyBar.var.handlers[name].yoffset or CandyBar.var.defaults.yoffset
	local text = CandyBar.var.handlers[name].text or CandyBar.var.defaults.text
	local fontsize = CandyBar.var.handlers[name].fontsize or CandyBar.var.defaults.fontsize
	local textcolor = CandyBar.var.handlers[name].textcolor or CandyBar.var.defaults.textcolor
	local timertextcolor = CandyBar.var.handlers[name].timertextcolor or CandyBar.var.defaults.timertextcolor
	local scale = CandyBar.var.handlers[name].scale or CandyBar.var.defaults.scale
	if not scale then scale = 1 end
	local timertextwidth = fontsize * 3
	local font, _, _ = GameFontHighlight:GetFont()


	if not f and table.getn(CandyBar.var.framepool) > 0 then
		f = table.remove(CandyBar.var.framepool)
	end

	if not f then f = CreateFrame("Button", nil, UIParent) end
	f:Hide()
	f.owner = name
	-- yes we add the height to the width for the icon.
	f:SetWidth( width + height )
	f:SetHeight( height )
	f:ClearAllPoints()
	f:SetPoint( point, rframe, rpoint, xoffset, yoffset)
	-- disable mouse
	f:EnableMouse(false)
	f:RegisterForClicks()
	f:SetScript("OnClick", nil)
	f:SetScale( scale )

	if not f.icon then f.icon = CreateFrame("Button", nil, f) end
	f.icon:ClearAllPoints()
	f.icon.owner = name
	f.icon:EnableMouse(false)
	f.icon:RegisterForClicks()
	f.icon:SetScript("OnClick", nil)
	-- an icno is square and the height of the bar, so yes 2x height there
	f.icon:SetHeight( height)
	f.icon:SetWidth( height)
	f.icon:SetPoint("LEFT", f, "LEFT", 0, 0)
	f.icon:SetNormalTexture(icon)
	f.icon:SetAlpha(1)
	f.icon:Show()

	if not f.statusbarbg then
		f.statusbarbg = CreateFrame("StatusBar", nil, f )
		f.statusbarbg:SetFrameLevel(f.statusbarbg:GetFrameLevel() - 1)
	end
	f.statusbarbg:ClearAllPoints()
	f.statusbarbg:SetHeight( height )
	f.statusbarbg:SetWidth( width )
	-- offset the height of the frame on the x-axis for the icon.
	f.statusbarbg:SetPoint( "TOPLEFT", f, "TOPLEFT", height, 0)
	f.statusbarbg:SetStatusBarTexture( texture )
	f.statusbarbg:SetStatusBarColor( bgcolor[1],bgcolor[2],bgcolor[3],bgcolor[4])
	f.statusbarbg:SetMinMaxValues(0,100)
	f.statusbarbg:SetValue(100)

	if not f.statusbar then f.statusbar = CreateFrame("StatusBar", nil, f ) end
	f.statusbar:ClearAllPoints()
	f.statusbar:SetHeight( height )
	f.statusbar:SetWidth( width )
	-- offset the height of the frame on the x-axis for the icon.
	f.statusbar:SetPoint( "TOPLEFT", f, "TOPLEFT", height, 0)
	f.statusbar:SetStatusBarTexture( texture )
	f.statusbar:SetStatusBarColor( color[1], color[2], color[3], color[4] )
	f.statusbar:SetMinMaxValues(0,1)
	f.statusbar:SetValue(1)


	if not f.spark then f.spark = f.statusbar:CreateTexture(nil, "OVERLAY") end
	f.spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	f.spark:SetWidth(16)
	f.spark:SetHeight( height + 25 )
	f.spark:SetBlendMode("ADD")
	f.spark:Show()

	if not f.timertext then f.timertext = f.statusbar:CreateFontString(nil, "OVERLAY") end
	f.timertext:SetFontObject(GameFontHighlight)
	f.timertext:SetFont( font, fontsize )
	f.timertext:SetHeight( height)
	f.timertext:SetWidth( timertextwidth )
	f.timertext:SetPoint( "LEFT", f.statusbar, "LEFT", 0, 0)
	f.timertext:SetJustifyH("RIGHT")
	f.timertext:SetText("0")
	f.timertext:SetTextColor(timertextcolor[1], timertextcolor[2], timertextcolor[3], timertextcolor[4])

	if not f.text then f.text = f.statusbar:CreateFontString(nil, "OVERLAY") end
	f.text:SetFontObject(GameFontHighlight)
	f.text:SetFont( font, fontsize)
	f.text:SetHeight(height)
	f.text:SetWidth( (width - timertextwidth) *.9 )
	f.text:SetPoint( "RIGHT", f.statusbar, "RIGHT", 0, 0)
	f.text:SetJustifyH("LEFT")
	f.text:SetText(text)
	f.text:SetTextColor(textcolor[1], textcolor[2], textcolor[3], textcolor[4])

	if CandyBar.var.handlers[name].onclick then
		f:EnableMouse(true)
		f:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
		f:SetScript("OnClick", function() CandyBar:OnClick() end )
		f.icon:EnableMouse(true)
		f.icon:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
		f.icon:SetScript("OnClick", function() CandyBar:OnClick() end )	
	end


	return f
end


-- Internal Method
-- Releases a bar frame into the pool
-- Name - which candybar's frame are we're releasing
-- Returns true when succesful
function CandyBar:ReleaseBarFrame( name )
	if not CandyBar.var.handlers[name] then return end
	if not CandyBar.var.handlers[name].frame then return end
	CandyBar.var.handlers[name].frame:Hide()
	table.insert(CandyBar.var.framepool, CandyBar.var.handlers[name].frame)
	return true
end


-- Internal Method
-- Executes the OnClick function of a bar

function CandyBar:OnClick()
	if not this.owner then return end
	if not CandyBar.var.handlers[this.owner] then return end
	if not CandyBar.var.handlers[this.owner].onclick then return end
	-- pass the name of the handlers first, and the button clicked as the second argument
	local c = CandyBar.var.handlers[this.owner]
	local button = arg1
	CandyBar.var.handlers[this.owner].onclick( this.owner, button, c.onclick1, c.onclick2, c.onclick3, c.onclick4, c.onclick5, c.onclick6, c.onclick7, c.onclick8, c.onclick9, c.onclick10)
	return true
end


-- Internal Method
-- on update handler
function CandyBar:OnUpdate()
	local t = GetTime()
	for i,v in pairs(this.owner.var.handlers) do
		if v.running then
			v.elapsed = t - v.starttime
			if v.endtime <= t then
				if this.owner.var.handlers[i].completion then
					local c = this.owner.var.handlers[i]
					this.owner.var.handlers[i].completion( c.completion1, c.completion2, c.completion3, c.completion4, c.completion5, c.completion6, c.completion7, c.completion8, c.completion9, c.completion10 )
				end
				this.owner:Stop(i)
			else
				this.owner:Update(i)
			end
		elseif v.fading then
			v.fadeelapsed = (t - v.endtime)
			this.owner:UpdateFade(i)
		end
	end
end

-- Internal Method
-- returns true if we have any handlers
function CandyBar:HasHandlers()
	for i in pairs(CandyBar.var.handlers) do return true end
end


------------------------------
--      Mixins Methods      --
------------------------------

CandyBar.IsCandyBarRegistered = CandyBar.IsRegistered
CandyBar.StartCandyBar = CandyBar.Start
CandyBar.StopCandyBar = CandyBar.Stop
CandyBar.PauseCandyBar = CandyBar.Pause
CandyBar.CandyBarStatus = CandyBar.Status
CandyBar.SetCandyBarTexture = CandyBar.SetTexture
CandyBar.SetCandyBarTime = CandyBar.SetTime
CandyBar.SetCandyBarColor = CandyBar.SetColor
CandyBar.SetCandyBarText = CandyBar.SetText
CandyBar.SetCandyBarIcon = CandyBar.SetIcon
CandyBar.SetCandyBarBackgroundColor = CandyBar.SetBackgroundColor
CandyBar.SetCandyBarTextColor = CandyBar.SetTextColor
CandyBar.SetCandyBarTimerTextColor = CandyBar.SetTimerTextColor
CandyBar.SetCandyBarFontSize = CandyBar.SetFontSize
CandyBar.SetCandyBarPoint = CandyBar.SetPoint
CandyBar.SetCandyBarScale = CandyBar.SetScale
CandyBar.SetCandyBarTimeFormat = CandyBar.SetTimeFormat
CandyBar.SetCandyBarTimeLeft = CandyBar.SetTimeLeft
CandyBar.SetCandyBarCompletion = CandyBar.SetCompletion
CandyBar.RegisterCandyBarGroup = CandyBar.RegisterGroup
CandyBar.UnregisterCandyBarGroup = CandyBar.UnregisterGroup
CandyBar.IsCandyBarGroupRegistered = CandyBar.IsGroupRegistered
CandyBar.SetCandyBarGroupPoint = CandyBar.SetGroupPoint
CandyBar.SetCandyBarGroupGrowth = CandyBar.SetGroupGrowth
CandyBar.UpdateCandyBarGroup = CandyBar.UpdateGroup
CandyBar.SetCandyBarOnClick = CandyBar.SetOnClick
CandyBar.SetCandyBarFade = CandyBar.SetFade
CandyBar.RegisterCandyBarWithGroup = CandyBar.RegisterWithGroup
CandyBar.UnregisterCandyBarWithGroup = CandyBar.UnregisterWithGroup
CandyBar.IsCandyBarRegisteredWithGroup = CandyBar.IsRegisteredWithGroup
CandyBar.SetCandyBarReversed = CandyBar.SetReversed
CandyBar.IsCandyBarReversed = CandyBar.IsReversed
CandyBar.SetCandyBarOnClick = CandyBar.SetOnClick
CandyBar.SetCandyBarHeight = CandyBar.SetHeight
CandyBar.SetCandyBarWidth = CandyBar.SetWidth

function CandyBar:RegisterCandyBar(name, time, text, icon, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	if not CandyBar.var.addons[self] then CandyBar.var.addons[self] = getnewtable() end
	CandyBar.var.addons[self][name] = CandyBar:Register(name, time, text, icon, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
end

function CandyBar:UnregisterCandyBar( a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	CandyBar:argCheck(a1, 2, "string")
	if CandyBar.var.addons[self] then CandyBar.var.addons[self][a1] = nil end
	CandyBar:Unregister(a1)
	if a2 then self:UnregisterCandyBar( a2, a3, a4, a5, a6, a7, a8, a9, a10) end
end


function CandyBar:OnEmbedDisable(target)
	if self.var.addons[target] then
		for i in pairs(self.var.addons[target]) do
			self:Unregister(i)
		end
	end
end



--------------------------------
--      Load this bitch!      --
--------------------------------


function CandyBar:activate(oldLib, oldDeactivate)
	CandyBar = self

	if oldLib then self.var = oldLib.var
	else
		local _,_,ourpath = string.find(debugstack(), "\\AddOns\\(.-)CandyBar%-2%.0%.lua")
		ourpath = "Interface\\AddOns\\"..ourpath .. "bar.tga"
		self.var = {  -- "Local" variables go here
			frame = CreateFrame("Frame"),
			handlers = {},
			groups = {},
			framepool = {},
			addons = {},
			defaults = {
				texture = "Interface\\TargetingFrame\\UI-StatusBar",
				width = 200,
				height = 16,
				scale = 1,
				point = "CENTER",
				rframe = UIParent,
				rpoint = "CENTER",
				xoffset = 0,
				yoffset = 0,
				fontsize = 11,
				color = { 1, 0, 1, 1 },
				bgcolor = { 0, .5, .5, .5},
				textcolor = {1, 1, 1, 1},
				timertextcolor = {1, 1, 1, 1},
			}
		}
		self.var.frame:Hide()
		self.var.frame.name = "CandyBar-2.0 Frame"
	end
	self.var.frame:SetScript("OnUpdate", self.OnUpdate)
	self.var.frame.owner = self

	if oldDeactivate then oldDeactivate(oldLib) end
end


local function external(self, major, instance)
	if major == "Compost-2.0" then compost = instance end
end


AceLibrary:Register(CandyBar, vmajor, vminor, CandyBar.activate, nil, external)
