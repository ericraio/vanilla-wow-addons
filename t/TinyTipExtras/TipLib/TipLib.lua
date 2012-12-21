--[[
-- Library of common functions to tooltips.
-- Can be used to create a psuedo tooltip.
--
-- Requires AceLibrary. If you comment out
-- TipLib in your TOC file, then comment out
-- AceLibrary as well.
--
-- Author: Thrae (aka "Matthew Carras")
-- Released: 7-11-06
--]]

local MAJOR_VERSION = "TipLib-1.0"
local MINOR_VERSION = "$Revision: 5255 $"

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local _G = getfenv(0)
local fCreateFontString, fGetName, fSetPoint, fClearAllPoints, fSetWidth, fSetHeight, fGetScale,fSetScript = _G.UIParent.CreateFontString, _G.UIParent.GetName, _G.UIParent.SetPoint, _G.UIParent.ClearAllPoints, _G.UIParent.SetWidth, _G.UIParent.SetHeight, _G.UIParent.GetScale, _G.UIParent.SetScript
local fsSetText, fsSetTextColor, fsShow, fsHide, fsGetWidth, fsGetHeight, fsGetFont, fsIsShown = _G.GameTooltipTextLeft1.SetText, _G.GameTooltipTextLeft1.SetTextColor, _G.GameTooltipTextLeft1.Show, _G.GameTooltipTextLeft1.Hide, _G.GameTooltipTextLeft1.GetWidth, _G.GameTooltipTextLeft1.GetHeight,_G.GameTooltipTextLeft1.GetFont, _G.GameTooltipTextLeft1.IsShown
local strfind,strformat = string.find,string.format

local TipLib = {}

function TipLib.SetText(tooltip,textL,rL,gL,bL,aL,textWrap,textR,rR,gR,bR,aR)
	local fsLeft,fsRight
	if tooltip.numLines == 0 then
		fsLeft = fCreateFontString( tooltip, fGetName(tooltip) .. "TextLeft1", "ARTWORK", "GameTooltipHeaderText")
		fSetPoint(fsLeft, "TOPLEFT", 10, -10)
		fsRight = fCreateFontString( tooltip, fGetName(tooltip) .. "TextRight1", "ARTWORK", "GameTooltipHeaderText")
		fSetPoint(fsRight, "LEFT", fsLeft, "RIGHT", 40, 0)
		tooltip.numLines = 1
		_,tooltip.headerfsHeight = fsGetFont(fsLeft)
	end
	if not fsLeft then fsLeft = _G[ fGetName(tooltip) .. "TextLeft1" ] end
	fsSetText(fsLeft, textL)
	fsSetTextColor(fsLeft, rL or 1.0, gL or 0.8, bL or 0, aL or 1.0)
	fsShow(fsLeft)
	if textR then
		if not fsRight then fsRight = _G[ fGetName(tooltip) .. "TextRight1" ] end
		fsSetText(fsRight, textR)
		fsSetTextColor(fsRight, rR or 1.0, gR or 0.8, bR or 0, aR or 1.0)
		fsShow(fsRight)
	end
end

function TipLib.AddLine(tooltip, textL, rL, gL, bL, aL, textR, rR, gR, bR, aR,textWrap)
	local fsLeft,fsRight
	if tooltip.unusedLines > 0 then
		fsLeft = _G[ strformat("%s%s%d", fGetName(tooltip),"TextLeft", (tooltip.numLines - tooltip.unusedLines + 1)) ]
		fsSetText(fsLeft, textL)
		fsSetTextColor(fsLeft, rL or 1.0, gL or 0.8, bL or 0, aL or 1.0)
		fsShow(fsLeft)
		if textR then
			fsRight = _G[ strformat("%s%s%d", fGetName(tooltip),"TextRight", (tooltip.numLines - tooltip.unusedLines + 1)) ]
			fsSetText(fsRight, textR)
			fsSetTextColor(fsRight, rR or 1.0, gR or 0.8, bR or 0, aR or 1.0)
			fsShow(fsRight)
		end
		tooltip.unusedLines = tooltip.unusedLines - 1
	elseif tooltip.numLines == 0 then

		tooltip:SetText(textL, rL, gL, bL, aL, textWrap, textR, rR, gR, bR, aR)

	elseif tooltip.numLines then
		tooltip.numLines = tooltip.numLines + 1
		fsLeft = fCreateFontString(tooltip,
										strformat("%s%s%d", fGetName(tooltip), "TextLeft", tooltip.numLines), 
										"ARTWORK", "GameTooltipText")
		fsSetText(fsLeft, textL)
		fsSetTextColor(fsLeft, rL or 1.0, gL or 0.8, bL or 0, aL or 1.0)		
		fSetPoint(fsLeft, "TOPLEFT", 
											_G[ strformat("%s%s%d", fGetName(tooltip), "TextLeft", tooltip.numLines - 1) ], 
											"BOTTOMLEFT", 
											0, -2)
		fsShow(fsLeft)
		fsRight = fCreateFontString(tooltip,
										strformat("%s%s%d", fGetName(tooltip), "TextRight", tooltip.numLines), 
										"ARTWORK", "GameTooltipText")
		if textR then
			fsSetText(fsRight, textR)
			fsSetTextColor(fsRight, rR or 1.0, gR or 0.8, bR or 0, aR or 1.0)
			fsShow(fsRight)
		end
		fSetPoint(fsRight, "LEFT", fsLeft, "RIGHT", 40, 0)
		if not tooltip.fsHeight then _,tooltip.fsHeight = fsGetFont(fsLeft) end
	end
end

function TipLib.ClearLines(tooltip)
	local i,fsLeft,fsRight
	local numUsedLines = tooltip.numLines - tooltip.unusedLines
	for i=1,numUsedLines,1 do
		fsLeft = _G[ strformat("%s%s%d", fGetName(tooltip),"TextLeft", i) ]
	  fsRight = _G[ strformat("%s%s%d", fGetName(tooltip),"TextRight", i) ]
		fsSetText(fsLeft,"")
		fsHide(fsLeft)
		fsSetText(fsRight,"")
		fsHide(fsRight)
	end
	tooltip.unusedLines = tooltip.numLines
end

function TipLib.NumLines(tooltip) 
	return tooltip.numLines 
end

function TipLib.Show(tooltip)
	local i,fsLeft,fsRight,lineWidth
	local largestWidth,totalHeight = 0,0
	local numUsedLines = tooltip.numLines - tooltip.unusedLines
	if numUsedLines > 0 then
		for i=1,numUsedLines,1 do
			fsLeft = _G[ strformat("%sTextLeft%d", fGetName(tooltip), i) ]
			fsRight = _G[ strformat("%sTextRight%d", fGetName(tooltip), i) ]
			lineWidth=0
			if fsIsShown(fsLeft) then
				lineWidth = fsGetWidth(fsLeft)
				totalHeight = totalHeight + fsGetHeight(fsLeft)
			end
			if fsIsShown(fsRight) then
				lineWidth = lineWidth + fsGetWidth(fsRight) + 40
			end
			if lineWidth > largestWidth then
				largestWidth = lineWidth
			end
		end

		fSetWidth( tooltip, largestWidth + 25)
		fSetHeight( tooltip, (totalHeight * 1.1) + 25 )	
		tooltip:orgShow()
	end
end

function TipLib.Hide(tooltip)
	tooltip:ClearLines()
	tooltip.owner = nil
	tooltip:orgHide()
end

local x,y,uiscale
local getcpos = _G.GetCursorPosition
function TipLib.OnUpdate()
	x,y = getcpos()
	uiscale,tscale = fGetScale(UIParent), fGetScale(this)
	x,y = (x + this.OffX) / uiscale / tscale, (y + this.OffY) / uiscale / tscale
	fClearAllPoints(this)
	fSetPoint(this, "BOTTOMLEFT", UIParent, x, y)
end

function TipLib.SetOwner(tooltip,owner,anchor,x,y)
	tooltip.owner = owner

	anchor = string.upper(anchor)
	fSetScript(tooltip, "OnUpdate", nil)
	if anchor == "ANCHOR_CURSOR" then
		tooltip.OffX, tooltip.OffY = x or 0,y or 0
		fSetScript(tooltip, "OnUpdate", tooltip.tlOnUpdate)
	elseif anchor ~= "ANCHOR_NONE" then
		_,_,anchor = strfind(anchor, "ANCHOR_(.+)",1)
		fSetPoint(tooltip, anchor,owner,anchor,x or 0,y or 0)
	end
end

function TipLib.IsOwned(tooltip,o)
	return tooltip.owner == o
end

function TipLib.CreatePsuedoTooltip(self,name,parent)
			local tooltip = _G.CreateFrame("Frame", name, parent or _G.UIParent)
			tooltip:SetFrameStrata("TOOLTIP")
			tooltip:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
                   						 edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", 
					                     tile = true, tileSize = 16, edgeSize = 16, 
          					           insets = { left = 5, right = 5, top = 5, bottom = 5 }})
  		tooltip:SetBackdropColor(_G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, _G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, _G.TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
			tooltip:SetBackdropBorderColor( _G.TOOLTIP_DEFAULT_COLOR.r, _G.TOOLTIP_DEFAULT_COLOR.g, _G.TOOLTIP_DEFAULT_COLOR.b)

			tooltip.numLines = 0
			tooltip.unusedLines = 0
			tooltip.headerfsHeight = 0
			tooltip.fsHeight = 0
			tooltip.owner = _G.UIParent

			fSetPoint(tooltip, "BOTTOMRIGHT", tooltip:GetParent(), "BOTTOMRIGHT", -_G.CONTAINER_OFFSET_X - 13, _G.CONTAINER_OFFSET_Y)

			tooltip.tlOnUpdate = self.OnUpdate
			tooltip.SetOwner = self.SetOwner
			tooltip.orgShow = tooltip.Show
			tooltip.Show = self.Show
			tooltip.orgHide = tooltip.Hide
			tooltip.Hide = self.Hide
			tooltip.NumLines = self.NumLines
			tooltip.SetText = self.SetText
			tooltip.AddLine = self.AddLine
			tooltip.ClearLines = self.ClearLines
			return tooltip
end

AceLibrary:Register(TipLib, MAJOR_VERSION, MINOR_VERSION)
