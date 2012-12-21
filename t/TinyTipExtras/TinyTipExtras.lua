--[[
-- Name: TinyTip
-- Author: Thrae of Maelstrom (aka "Matthew Carras")
-- Release Date: 6-25-06
--
-- These functions include more extragant features,
-- such as the PvP Rank Icon or buffs and debuffs, or
-- and extra tooltip. This is LoadedOnDemand by TinyTip.
--]]

local _G = getfenv(0)
local GameTooltip, UIParent,GTStatusBar = _G.GameTooltip, _G.UIParent, _G.GameTooltipStatusBar
local fClearAllPoints, fSetPoint, fHide,fShow, fGetScript, fSetScript = UIParent.ClearAllPoints, UIParent.SetPoint, UIParent.Hide, UIParent.Show, UIParent.GetScript, UIParent.SetScript
local db,EventFrame,ExtrasFrame
local tooltip = GameTooltip
local gtAddLine, gtNumLines = GameTooltip.AddLine, GameTooltip.NumLines
local fsSetText, fsGetText, fsShow, fsHide, fsIsShown, fsGetTextColor = _G.GameTooltipTextLeft1.SetText, _G.GameTooltipTextLeft1.GetText, _G.GameTooltipTextLeft1.Show, _G.GameTooltipTextLeft1.Hide, _G.GameTooltipTextLeft1.IsShown, _G.GameTooltipTextLeft1.GetTextColor
local strformat= string.format

local acehook

local tiplib = _G.AceLibrary:GetInstance("TipLib-1.0")

local PvPTexture, ExtraTooltip, ManaBar

local i,tmp,tmp2,tmp3

_G.TinyTipExtrasExists = true

local SetUnit_IsHooked, FadeOut_IsHooked

--[[
-- This is the AnchorTooltipTable table. As it requires you know the frame name
-- of the tooltip you wish to anchor, I am going to make it static. Add entries
-- into the table as so:

   ["TooltipName"] = {
	 	["Anchor"] = "BOTTOMRIGHT",
	 	["OffX"] = -50,
	 	["OffY"] = 13
	}
--
--]]

--[[
local AnchorTooltipTable = { 
 ["TooltipName"] = {
	 ["Anchor"] = "BOTTOMRIGHT",
	 ["OffX"] = -50,
	 ["OffY"] = 13
	}
}
--]]


local Original_GameTooltip_OnTooltipCleared, OnTooltipCleared_IsHooked
local function OnTooltipCleared(this,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
	if Original_GameTooltip_OnTooltipCleared then
		Original_GameTooltip_OnTooltipCleared(this,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)
	end

	_G.TinyTip_OnTooltipCleared(this,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10)

	if ExtraTooltip then
		ExtraTooltip:Hide()
	end
	if ExtrasFrame then
		fHide(ExtrasFrame)
		if TinyTipIcons_ResetTextureTable then TinyTipIcons_ResetTextureTable() end
	end
	if ManaBar then
		fHide(ManaBar)
	end
end

local function ManaBar_Init()
	if GameTooltip.unit then
			tmp = _G.UnitManaMax( GameTooltip.unit )
			ManaBar:SetMinMaxValues(0, tmp or 100)
			-- If disconnected
			if not _G.UnitIsConnected(GameTooltip.unit) then
				ManaBar:SetValue( tmp or 100 )
				ManaBar:SetStatusBarColor(0.5, 0.5, 0.5)
			else
				ManaBar:SetValue( _G.UnitMana( GameTooltip.unit ) or 100)
				tmp = _G.ManaBarColor[ _G.UnitPowerType( GameTooltip.unit ) ]
				ManaBar:SetStatusBarColor( tmp.r, tmp.g, tmp.b )
			end
	end
end
local function ManaBar_OnEvent()
	if _G.event == "UNIT_MANA" or _G.event == "UNIT_ENERGY" or _G.event == "UNIT_RAGE" then
		if _G.arg1 and _G.arg1 == GameTooltip.unit then
			ManaBar_Init()
		end
	elseif _G.event == "UNIT_DISPLAYPOWER" then
		if _G.arg1 and _G.arg1 == GameTooltip.unit and _G.UnitPowerType( GameTooltip.unit ) and _G.UnitPowerType( GameTooltip.unit ) > 0 then
			tmp = _G.ManaBarColor[ _G.UnitPowerType( GameTooltip.unit ) ]
			ManaBar:SetStatusBarColor( tmp.r, tmp.g, tmp.b )
		end
	end
end

local function ATTOnUpdate()
	fClearAllPoints(this)
	fSetPoint(this, this.TTAnchor or "BOTTOMRIGHT", UIParent, this.TTAnchor or "BOTTOMRIGHT", this.TTOffX or 0, this.TTOffY or 0)
end

function TinyTipExtras_CopyGameTooltip()
	tmp = gtNumLines(GameTooltip)
	for i = 1, tmp do
		tmp2 = _G[ strformat("GameTooltipTextLeft%d", i) ]
		tmp3 = _G[ strformat("GameTooltipTextRight%d", i) ]
		if tmp2 and tmp3 and fsIsShown(tmp2) and fsIsShown(tmp3) and fsGetText(tmp2) and fsGetText(tmp3) then
			ExtraTooltip:AddLine( fsGetText(tmp2), fsGetTextColor(tmp2) or unpack{1,1,1}, nil, fsGetText(tmp3), fsGetTextColor(tmp3) )
		elseif tmp2 and fsGetText(tmp2) then
			ExtraTooltip:AddLine( fsGetText(tmp2), fsGetTextColor(tmp2) or unpack{1,1,1} )
		end
	end
end

function TinyTipExtras_ATTUnhook(k)
	if db["AnchorTooltipTable"] and db["AnchorTooltipTable"][ k ] then
		if acehook:IsHooked( AnchorTooltipTable[ k ], "OnUpdate") then
			acehook:Unhook( AnchorTooltipTable[ k ], "OnUpdate")
		end
	end
end

function TinyTipExtras_Init(_db,_EventFrame,_acehook)
	if _db then db = _db end
	if _EventFrame then EventFrame = _EventFrame end
	if _acehook then acehook = _acehook end

	if acehook and not acehook:IsHooked(GameTooltip, "OnTooltipCleared") then -- most sure-fire way to hide something
		acehook:HookScript(GameTooltip, "OnTooltipCleared", OnTooltipCleared)
		Original_GameTooltip_OnTooltipCleared = acehook.hooks[GameTooltip]["OnTooltipCleared"].orig
	end
	if acehook and AnchorTooltipTable then
		local k,v
		for k,v in AnchorTooltipTable do
			if _G[ k ] then
				if not acehook:IsHooked( _G[ k ], "OnUpdate") then
					if v then
						if v.Anchor then
							_G[ k ].TTAnchor = v.Anchor
						end
						if v.OffX then
							_G[ k ].TTOffX = v.OffX
						end
						if v.OffY then
							_G[ k ].TTOffY = v.OffY
						end
					end
					acehook:HookScript( _G[ k ], "OnUpdate", ATTOnUpdate)
				end
			end
		end
	end

	if db["ManaBar"] then
		if not ManaBar then
			ManaBar = _G.CreateFrame("StatusBar", "TinyTipExtras_ManaBar", GameTooltip)
			ManaBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill")
			ManaBar:SetHeight(8)
			ManaBar:SetPoint("TOPLEFT", GTStatusBar, "BOTTOMLEFT", 0, 0)
			ManaBar:SetPoint("TOPRIGHT", GTStatusBar, "BOTTOMRIGHT", 0, 0)
			ManaBar:SetScript("OnShow", ManaBar_Init)
			ManaBar:SetScript("OnEvent", ManaBar_OnEvent)
			ManaBar:RegisterEvent("UNIT_DISPLAYPOWER")
			ManaBar:RegisterEvent("UNIT_MANA")
			ManaBar:RegisterEvent("UNIT_ENERGY")
			ManaBar:RegisterEvent("UNIT_RAGE")
		end
	end

	if db["ExtraTooltip"] then
		if not ExtraTooltip then
			ExtraTooltip = tiplib:CreatePsuedoTooltip("TinyTipExtras_Tooltip", UIParent)
			ExtraTooltip:SetScale( db["Scale"] or 1.0 )
		end

		if db["Compact"] then _G.TinyTip_UnCompactGameTooltip() end
		GTStatusBar:SetPoint("TOPLEFT", ExtraTooltip, "BOTTOMLEFT", 2, -1)
		GTStatusBar:SetPoint("TOPRIGHT", ExtraTooltip, "BOTTOMRIGHT", -2, -1)
		GTStatusBar:SetParent(ExtraTooltip)
		if ManaBar then ManaBar:SetParent(ExtraTooltip) end
		if ExtrasFrame then ExtrasFrame:SetParent(ExtraTooltip) end
		if _G.TinyTipAnchor_ResetReferences then
			_G.TinyTipAnchor_ResetReferences(ExtraTooltip.ClearAllPoints, ExtraTooltip.SetPoint, ExtraTooltip.SetOwner)
		end
		if db["ExtraTooltip"] == 1 then
			_G.TinyTip_ResetReferences(ExtraTooltip.AddLine, ExtraTooltip.AddDoubleLine, ExtraTooltip, ExtraTooltip)
			gtAddLine = ExtraTooltip.AddLine
			tooltip = ExtraTooltip
			if _G.TinyTipTargets_ResetReferences then
				_G.TinyTipTargets_ResetReferences(ExtraTooltip.AddLine, ExtraTooltip.AddDoubleLines, ExtraTooltip)
			end
		else
			_G.TinyTip_ResetReferences(GameTooltip.AddLine, GameTooltip.AddDoubleLine, ExtraTooltip, GameTooltip)
			gtAddLine = GameTooltip.AddLine
			tooltip = GameTooltip
			if _G.TinyTipTargets_ResetReferences then
				_G.TinyTipTargets_ResetReferences(GameTooltip.AddLine, GameTooltip.AddDoubleLines, GameTooltip)
			end
		end
	else
		GameTooltip:SetScale(  db["Scale"] or 1.0 )
		GTStatusBar:SetPoint("TOPLEFT", GameTooltip, "BOTTOMLEFT", 2, -1)
		GTStatusBar:SetPoint("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", -2, -1)
		GTStatusBar:SetParent(GameTooltip)
		if ManaBar then ManaBar:SetParent(GameTooltip) end
		if ExtrasFrame then ExtrasFrame:SetParent(GameTooltip) end
		_G.TinyTip_ResetReferences(GameTooltip.AddLine, GameTooltip.AddDoubleLine, GameTooltip, GameTooltip)
		gtAddLine = GameTooltip.AddLine
		tooltip = GameTooltip
		if _G.TinyTipAnchor_ResetReferences then
			_G.TinyTipAnchor_ResetReferences(GameTooltip.ClearAllPoints, GameTooltip.SetPoint, GameTooltip.SetOwner)
		end
		if _G.TinyTipTargets_ResetReferences then
			_G.TinyTipTargets_ResetReferences(GameTooltip.AddLine, GameTooltip.AddDoubleLines, GameTooltip)
		end
	end

	if db["PvPIcon"] or db["Buffs"] or db["Debuffs"] or db["RTIcon"] then
		if not ExtrasFrame then
			ExtrasFrame = _G.CreateFrame("Frame", "TinyTipExtras_Frame", GameTooltip)
		end
		if TinyTipIcons_Init then TinyTipIcons_Init(db, EventFrame, ExtrasFrame, gtAddLine, tooltip) end
	end
end
