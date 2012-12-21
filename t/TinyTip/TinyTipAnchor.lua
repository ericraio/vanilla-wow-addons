--[[
-- Name: TinyTip
-- Author: Thrae of Maelstrom (aka "Matthew Carras")
-- Release Date: 6-25-06
--
-- This file handles the position and anchoring of the
-- tooltip. If you don't care about these options, then
-- this file can safely removed from the TOC.
--]]

local _G = getfenv(0)
local UIParent,GameTooltip = _G.UIParent, _G.GameTooltip
local gtClearPts, gtSetOwner, gtSetPt = GameTooltip.ClearAllPoints, GameTooltip.SetOwner, GameTooltip.SetPoint
local tClearPts, tSetOwner, tSetPt = gtClearPts, gtSetOwner, gtSetPt
local fSetScript, fGetScale, fGetAlpha, fGetCenter, fGetLeft, fGetRight, fGetTop, fGetBottom, fGetWidth, fGetHeight = UIParent.SetScript, UIParent.GetScale, UIParent.GetAlpha, UIParent.GetCenter, UIParent.GetLeft, UIParent.GetRight, UIParent.GetTop, UIParent.GetBottom, UIParent.GetWidth, UIParent.GetHeight
local db,EventFrame

local acehook

local unitMouseover

_G.TinyTipAnchorExists = true

function TinyTipAnchor_ResetReferences(ClearPts, SetPt, SetOwner)
	tClearPts, tSetPt, tSetOwner = ClearPts, SetPt, SetOwner
end

-- blatantly stolen from PerfecEventFrame by cladhaire!
-- Used for UAnchor == "STICKY"
local function SmartSetOwner(owner, setX, setY, tooltip)
	if (not owner) then owner = UIParent end
	if (not tooltip) then tooltip = this end
	if (not setX) then setX = 0 end
	if (not setY) then setY = 0 end

	local x,y = fGetCenter(owner)
  local left = fGetLeft(owner)
	local right = fGetRight(owner)
  local top = fGetTop(owner)
  local bottom = fGetBottom(owner)
	local screenWidth = _G.GetScreenWidth()
  local screenHeight = _G.GetScreenHeight()
  local scale = fGetScale(owner)
  if (x~=nil and y~=nil and left~=nil and 
	right~=nil and top~=nil and bottom~=nil 
	and screenWidth>0 and screenHeight>0) then
    setX = setX * scale
    setY = setY * scale
    x = x * scale
		y = y * scale 
		left = left * scale 
		right = right * scale 
		width = right - left 
		top = top * scale 
		bottom = bottom * scale 
		local anchorPoint 
		
		if (y <= (screenHeight * (1/2))) then 
			top = top + setY 
			anchorPoint = "TOP" 
			if (top < 0) then 
				setY = setY - top 
			end 
		else 
			setY = -setY 
			bottom = bottom + setY 
			anchorPoint = "BOTTOM" 
			if (bottom > screenHeight) then 
				setY = setY + (screenHeight - bottom) 
			end 
		end 
		
		if (x <= (screenWidth * (1/2))) then 
			left = left + setX 
			if (anchorPoint == "BOTTOM") then 
				anchorPoint = anchorPoint.."RIGHT" 
				setX = setX - width 
				if (left < 0) then 
					setX = setX - left 
				end 
			else 
				anchorPoint = anchorPoint.."LEFT" 
				if (left < 0) then 
					setX = setX - left 
				end 
			end 
		else 
			setX = -setX 
			right = right + setX 
			if (anchorPoint == "BOTTOM") then 
				anchorPoint = anchorPoint.."LEFT" 
				setX = setX + width 
				if (right > screenWidth) then 
					setX = setX - (right - screenWidth) 
				end 
			else 
				anchorPoint = anchorPoint.."RIGHT" 
				if (right > screenWidth) then 
					setX = setX + (screenWidth - right) 
				end 
			end 
		end 
		
		scale = fGetScale(tooltip) 
		if (scale) then 
			setX = setX / scale 
			setY = setY / scale 
		end
		
		tClearPts(tooltip)
		tSetOwner(tooltip, owner, "ANCHOR_"..anchorPoint, setX, setY)
	end
end

-- Used to stick GameTooltip to the cursor with offsets.
local x,y,uiscale, tscale,utooltip
local getcpos = _G.GetCursorPosition
local function OnUpdate()
	if unitMouseover and not _G.UnitExists("mouseover") then
		if db["Fade"] ~= 1 or fGetAlpha(GameTooltip) < 0.1 then
			if this.tooltip == _G.TinyTipExtras_Tooltip then this.tooltip:Hide() end
			fSetScript(this, "OnUpdate", nil)
			return
		end
	end
	x,y = getcpos()
	utooltip = this.tooltip
	uiscale,tscale = fGetScale(UIParent), fGetScale(utooltip)
	x,y = (x + (utooltip.OffX or 0)) / uiscale / tscale, (y + (utooltip.OffY or 0)) / uiscale / tscale
	tClearPts(utooltip)
	tSetPt(utooltip, "BOTTOM", UIParent, "BOTTOMLEFT", x, y)
end

function TinyTipAnchor_AlwaysAnchor()
	tClearPts(GameTooltip)
	tSetPt(GameTooltip, db["FAnchor"] or "BOTTOMRIGHT", UIParent, db["FAnchor"] or "BOTTOMRIGHT", (db["FOffX"] or 0) - ((not db["FAnchor"] and (_G.CONTAINER_OFFSET_X - 13)) or 0), (db["FOffY"] or 0) + ((not db["FAnchor"] and _G.CONTAINER_OFFSET_Y) or 0))
end

_G.TinyTipAnchor_Original_GameTooltip_SetDefaultAnchor = nil
function TinyTipAnchor_SetDefaultAnchor(tooltip,owner,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
	tooltip.owner = owner
	if _G.TinyTipAnchor_Original_GameTooltip_SetDefaultAnchor and tooltip ~= _G.TinyTipExtras_Tooltip then
		_G.TinyTipAnchor_Original_GameTooltip_SetDefaultAnchor(tooltip,owner,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
	end
	if db and EventFrame and (db["AnchorAll"] or (tooltip == GameTooltip or tooltip == _G.TinyTipExtras_Tooltip) ) then
		if db["Fade"] == 2 then
				fSetScript(EventFrame, "OnUpdate", _G.TinyTip_SlimOnUpdate)
		else
				fSetScript(EventFrame, "OnUpdate", nil)
		end
		if tooltip == _G.TinyTipExtras_Tooltip then
			if db["ETAnchor"] or db["ETOffX"] or db["ETOffY"] then
				gtClearPts(GameTooltip)
				gtSetPt(GameTooltip, db["ETAnchor"] or "BOTTOMRIGHT", UIParent, db["ETAnchor"] or "BOTTOMRIGHT", (db["ETOffX"] or 0) - _G.CONTAINER_OFFSET_X - 13, (db["ETOffY"] or 0) + _G.CONTAINER_OFFSET_Y)
			end
			tClearPts(tooltip)
			tSetPt(tooltip, "RIGHT", GameTooltip, "LEFT", -5 / fGetScale(UIParent) , 0 )
		end
		if owner ~= UIParent then
			if db["FAnchor"] or db["FOffX"] or db["FOffY"] then
				if db["FAnchor"] == "CURSOR" then
					if db["Fade"] ~= 1 and not db["ExtraTooltip"] then
						tSetOwner(tooltip, owner, "ANCHOR_CURSOR")
					else
						tSetOwner(tooltip, owner, "ANCHOR_NONE")
					end
					if db["FOffX"] or db["FOffY"] or db["Fade"] == 1 or db["ExtraTooltip"] then
						tooltip.OffX, tooltip.OffY,unitMouseover = db["FOffX"] or 0, db["FOffY"] or 0, nil
						fSetScript(EventFrame, "OnUpdate", OnUpdate)
					end
				elseif db["FAnchor"] == "STICKY" then
						SmartSetOwner(owner, db["FOffX"], db["FOffY"], tooltip)
				else
						tSetOwner(tooltip, owner, "ANCHOR_NONE")
						tClearPts(tooltip) 
						tSetPt(tooltip, db["FAnchor"] or "BOTTOMRIGHT", UIParent, db["FAnchor"] or "BOTTOMRIGHT", (db["FOffX"] or 0) - ((not db["FAnchor"] and (_G.CONTAINER_OFFSET_X - 13)) or 0), (db["FOffY"] or 0) + ((not db["FAnchor"] and _G.CONTAINER_OFFSET_Y) or 0))
				end
			end
		else
			if tooltip == GameTooltip and db["ExtraTooltip"] then return end
			if db["MAnchor"] ~= "GAMEDEFAULT" or db["MOffX"] or db["MOffY"] then
				if not db["MAnchor"] then
					if db["Fade"] ~= 1 and not db["ExtraTooltip"] then
						tSetOwner(tooltip, owner, "ANCHOR_CURSOR")
					else
						tSetOwner(tooltip, owner, "ANCHOR_NONE")
					end
					if db["MOffX"] or db["MOffY"] or db["Fade"] == 1 or db["ExtraTooltip"] then
						tooltip.OffX, tooltip.OffY,unitMouseover = db["MOffX"] or 0, db["MOffY"] or 0, true
						fSetScript(EventFrame, "OnUpdate", OnUpdate)
					end
				else
					tSetOwner(tooltip, owner, "ANCHOR_NONE")
					tClearPts(tooltip)
					tSetPt(tooltip, 
								(db["MAnchor"] ~= "GAMEDEFAULT" and db["MAnchor"]) or "BOTTOMRIGHT", 
								UIParent, 
								(db["MAnchor"] ~= "GAMEDEFAULT" and db["MAnchor"]) or "BOTTOMRIGHT", 
								(db["MOffX"] or 0) - ((db["MAnchor"] == "GAMEDEFAULT" and (_G.CONTAINER_OFFSET_X - 13)) or 0), 
								(db["MOffY"] or 0) + ((db["MAnchor"] == "GAMEDEFAULT" and _G.CONTAINER_OFFSET_Y) or 0))
				end
			end
		end
	end
end

function TinyTipAnchor_Hook(_acehook)
	acehook = _acehook
	if acehook and not acehook:IsHooked("GameTooltip_SetDefaultAnchor") then
		acehook:Hook("GameTooltip_SetDefaultAnchor", _G.TinyTipAnchor_SetDefaultAnchor)
		_G.TinyTipAnchor_Original_GameTooltip_SetDefaultAnchor = acehook.hooks["GameTooltip_SetDefaultAnchor"].orig
	end
end

function TinyTipAnchor_SetLocals(_db, _EventFrame,_acehook)
	db, EventFrame,acehook = _db,_EventFrame,_acehook
	TinyTipAnchor_SetLocals = nil
end

