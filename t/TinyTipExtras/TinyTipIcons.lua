--[[
-- Name: TinyTip
-- Author: Thrae of Maelstrom (aka "Matthew Carras")
-- Release Date: 6-25-06
--
-- These functions include more extragant features having
-- specifically to do with textures,
-- such as the PvP Rank Icon or buffs and debuffs.
--]]

local _G = getfenv(0)
local GameTooltip, UIParent,GTStatusBar = _G.GameTooltip, _G.UIParent, _G.GameTooltipStatusBar
local fClearAllPoints, fSetPoint, fHide,fShow,fGetScale = UIParent.ClearAllPoints, UIParent.SetPoint, UIParent.Hide, UIParent.Show, UIParent.GetScale
local txSetTexture, txSetTexCoord, txShow, txHide = _G.CharacterFramePortrait.SetTexture, _G.CharacterFramePortrait.SetTexCoord, _G.CharacterFramePortrait.Show, _G.CharacterFramePortrait.Hide
local db,EventFrame,ExtrasFrame
local tooltip = GameTooltip
local gtAddLine = GameTooltip.AddLine
local fsSetText, fsGetText, fsShow, fsHide = _G.GameTooltipTextLeft1.SetText, _G.GameTooltipTextLeft1.GetText, _G.GameTooltipTextLeft1.Show, _G.GameTooltipTextLeft1.Hide
local strformat= string.format

local TextureTable,NumTextures, NumUnusedTextures, BuffFrame, PvPTexture, PvPIconFrame, RTIcon, RTIconFrame

local i,dtable,tmp,tmp2

_G.TinyTipIconsExists = true

local function SetTextureTable(path,count)
	local tx
	if NumUnusedTextures > 0 then
		tx = TextureTable[ (NumTextures - NumUnusedTextures) + 1 ]
		txSetTexture(tx, path)
		if count and count > 0 then fsSetText(tx.fs, count ) else fsHide(tx.fs) end
		txShow(tx)
		NumUnusedTextures = NumUnusedTextures - 1
	else
		NumTextures = NumTextures + 1
		tinsert(TextureTable, BuffFrame:CreateTexture())
		tx = TextureTable[ NumTextures ]
		txSetTexture(tx, path)
		tx.fs = ExtrasFrame:CreateFontString(nil, "ARTWORK", "NumberFontNormal")
		if count and count > 0 then fsSetText(tx.fs, count) else fsHide(tx.fs) end
		fsShow(tx.fs)
		txShow(tx)
	end

	return tx
end

function TinyTipIcons_ResetTextureTable()
	NumUnusedTextures = NumTextures
end

function TinyTipIcons_Init(_db,_EventFrame, _ExtrasFrame, _gtAddLine, _tooltip)
	if _db then db = _db end
	if _EventFrame then EventFrame = _EventFrame end
	if _ExtrasFrame then ExtrasFrame = _ExtrasFrame end
	if _gtAddLine then gtAddLine = _gtAddLine end
	if _tooltip then tooltip = _tooltip end

	if db["PvPIcon"] then
		if not PvPIconFrame then PvPIconFrame = _G.CreateFrame("Frame", nil, ExtrasFrame) PvPIconFrame:Show() end
		if not PvPTexture then PvPTexture = PvPIconFrame:CreateTexture(nil, "ARTWORK") end
		PvPTexture:SetPoint(db["PvPIconAnchor1"] or "TOPRIGHT", tooltip, db["PvPIconAnchor2"] or "TOPLEFT", db["PvPIconOffX"] or 0, db["PvPIconOffY"] or 0)
		txHide(PvPTexture)
		PvPIconFrame:SetScale(db["PvPIconScale"] or 0.7)
	end
	if db["RTIcon"] then
		if not RTIconFrame then
			RTIconFrame = _G.CreateFrame("Frame", nil, ExtrasFrame)
			RTIconFrame:Show()
		end
		RTIconFrame:SetScale(db["RTIconScale"] or 0.1)
		if not RTIcon then
			RTIcon = RTIconFrame:CreateTexture(nil, "ARTWORK")
			txSetTexture(RTIcon, "Interface\\TargetingFrame\\UI-RaidTargetingIcons")
			txHide(RTIcon)
		end
		if db["PvPIcon"] and PvPTexture then 
			RTIcon:SetPoint(db["RTIconAnchor1"] or "TOPLEFT", PvPTexture, db["RTIconAnchor2"] or "BOTTOMLEFT", db["RTIconOffX"] or 0, db["RTIconOffY"] or 0)
		else
			RTIcon:SetPoint(db["RTIconAnchor1"] or "TOPRIGHT", tooltip, db["RTIconAnchor2"] or "TOPLEFT", db["RTIconOffX"] or 0, db["RTIconOffY"] or 0)
		end
	end
	if (db["Buffs"] or db["Debuffs"]) then
		if not BuffFrame then
			BuffFrame = _G.CreateFrame("Frame", nil, ExtrasFrame)
			BuffFrame:Show()
		end
		BuffFrame:SetScale(db["BuffScale"] or 0.2)
		if not TextureTable then
			TextureTable = {}
			NumTextures,NumUnusedTextures = 0,0
		end
	else
		TextureTable = nil
	end
end

function TinyTipIcons_ResetRTIcon(unit,numRaid)
	tmp = GetRaidTargetIndex(unit)
	if numRaid and numRaid > 0 and tmp and tmp > 0 then
		tmp = _G.UnitPopupButtons["RAID_TARGET_" .. tmp] 
		if tmp then
			txSetTexCoord(RTIcon, tmp.tCoordLeft, tmp.tCoordRight, tmp.tCoordTop, tmp.tCoordBottom )
			txShow(RTIcon)
			fShow(ExtrasFrame)
		end
	else
		txHide(RTIcon)
	end
end

function TinyTipIcons_ResetPvPIcon(rank,isplayer)
	if isplayer and rank > 0 then
		txSetTexture(PvPTexture, strformat("%s%02d",
						       "Interface\\PvPRankBadges\\PvPRank",
							rank))
		txShow(PvPTexture)
		fShow(ExtrasFrame)
	else
		txHide(PvPTexture)
	end
end

function TinyTipIcons_HideUnusedTextures()
	local tx
	i = NumUnusedTextures
	while i > 0 do
		tx = TextureTable[ NumTextures - i + 1 ]
		txHide(tx)
		fsHide(tx.fs)
		i = i - 1
	end
end

local lastTx
function TinyTipIcons_ShowBuffs(unit)
	local flag, count = db["Buffs"], 0
	tmp,tmp2 = nil,nil
	if flag then
	if flag == 1 then num = 8
	else num = 32 end
	for i = 1,num,1 do
			tmp,tmp2 = _G.UnitBuff(unit, i, flag ~= 1)
			if tmp then
				count = count + 1
				if flag ~= 3 then
					tmp = SetTextureTable( tmp,tmp2 )
					fClearAllPoints(tmp)
					if count == 1 then
						fSetPoint(tmp, db["BuffAnchor1"] or "BOTTOM", (db["ExtraTooltip"] and _G.TinyTipExtras_Tooltip) or GameTooltip, db["BuffAnchor2"] or "TOPLEFT", db["BuffOffX"] or 0, db["BuffOffY"] or (-2 / fGetScale(UIParent)) )
					else
						fSetPoint(tmp, "LEFT", lastTx, "RIGHT", 0, 0)
					end
					fSetPoint(tmp.fs, "BOTTOM", tmp, "TOP", 0, 0)
					lastTx = tmp
				end
		end
	end
	if flag == 3 and count > 0 then
		gtAddLine( tooltip, strformat("%s %s: (|cFFFFFFFF%d|r)", _G.UnitClass("player"), TinyTipExtrasLocale_Buffs, count) )
	end
	fShow(ExtrasFrame)
end
end
function TinyTipIcons_ShowDebuffs(unit)
	local flag, count = db["Debuffs"], 0
	tmp,tmp2 = nil,nil
	if flag then
	if flag >= 4 then
		if not dtable then dtable = {} end
		for i,_ in TinyTipExtrasLocale_DebuffMap do
			dtable[i] = 0
		end
	end
	if flag == 1 then num = 8 
	else num = 32 end
	for i = 1,num,1 do
		if flag >= 4 and _G.UnitIsFriend(unit,"player") then
			_,_,tmp = _G.UnitDebuff(unit,i,flag ~= 5)
			if tmp then dtable[ tmp ] = dtable[ tmp ] + 1 end
		else
			tmp,tmp2 = _G.UnitDebuff(unit, i, flag ~= 1)
			if tmp then
					count = count + 1
					if flag ~= 3 then
						tmp = SetTextureTable( tmp,tmp2 )
						fClearAllPoints(tmp)
						if count == 1 then
							fSetPoint(tmp, db["DebuffAnchor1"] or "TOP", (db["ManaBar"] and _G.TinyTipExtras_ManaBar) or GTStatusBar, db["DebuffAnchor2"] or "BOTTOMLEFT", db["DebuffOffX"] or 0, db["DebuffOffY"] or (2 / fGetScale(UIParent)) )
						else
							fSetPoint(tmp, "LEFT", lastTx, "RIGHT", 0, 0)
						end
						fSetPoint(tmp.fs, "TOP", tmp, "BOTTOM", 0, 0)
						lastTx = tmp
					end
			end
		end
	end
	if dtable then
		for i,num in dtable do
			if num > 0 then
				gtAddLine(tooltip, strformat( "%s: (|cFFFFFFFF%d|r)", TinyTipExtrasLocale_DebuffMap[ i ], num) )
			end
		end
	elseif flag == 3 and count > 0 then
		gtAddLine(tooltip, strformat("%s: (|cFFFFFFFF%d|r)", TinyTipExtrasLocale_DispellableDebuffs, count) )
	end
	fShow(ExtrasFrame)
end
end
