local DEBUGMODE=false

local BUTTONNAME = {buff="BuffaloButton", debuff="DebuffaloButton", weapon = "WeaponBuffaloButton"}
local BUTTON_TEMPLATE_NAME = {buff="BuffaloButton", debuff="DebuffaloButton", weapon = "WeaponBuffaloButton"}
local FRAME_NAME = {buff="BuffaloFrame", debuff="DebuffaloFrame", weapon = "WeaponBuffaloFrame"}
local MININDEX = {buff=0, debuff=0, weapon=0}
local MAXINDEX = {buff=31, debuff=15, weapon=1}
local TEMPENCHANTGHOSTTEXT = {"MH", "OH"}
local BUFF, DEBUFF, WEAPON = "buff", "debuff", "weapon" --cats
local GHOST_COLOR = {	buff =	{r=0.2, g=0.8, b=0.2},
						debuff=	{r=0.8, g=0.2, b=0.2},
						weapon=	{r=0.2, g=0.2, b=0.8},
						warning={r=1.0, g=0.2, b=0.2},
						alpha=0.8}
local BUFF_FILTER={buff="HELPFUL", debuff="HARMFUL"}
local UPDATETIME = 0.2

local timeSinceWeaponUpdate = 0
local timeSinceBuffUpdate = 0

Buffalo = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0", "AceDebug-2.0")
Buffalo:RegisterDB("BuffaloDB")
Buffalo:RegisterDefaults("profile", BUFFALO_DEFAULT_OPTIONS)
local L = AceLibrary("AceLocale-2.2"):new("Buffalo")
local slashOptions = {
	type = 'group',
	args={
		reset = {
			type='execute',
			name=L["Reset"],
			desc=L["Reset"],
			func = function() Buffalo.Reset(Buffalo) end

		},
		config = {
			type='execute',
			name=L["config"],
			desc=L["Config"],
			func = function() Buffalo.dewdrop:Open(UIParent, 'children', Buffalo_OptionsTable, 'cursorX', true, 'cursorY', true) end
		},
	}
}
Buffalo:RegisterChatCommand({"/buffalo"}, slashOptions)

local abacus=AceLibrary("Abacus-2.0")


local anchors = {	buff = {{point="TOPRIGHT", relativeTo="BuffaloFrame" , relativePoint="TOPRIGHT", xOffs=0, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton0" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton1" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton2" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton3" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton4" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton5" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton6" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="TOP", relativeTo="BuffaloButton0" , relativePoint="BOTTOM", xOffs=0, yOffs=-15},
							{point="RIGHT", relativeTo="BuffaloButton8" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton9" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton10", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton11", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton12", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton13", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton14", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="TOP", relativeTo="BuffaloButton8" , relativePoint="BOTTOM", xOffs=0, yOffs=-15},
							{point="RIGHT", relativeTo="BuffaloButton16" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton17" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton18", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton19", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton20", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton21", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton22", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="TOP", relativeTo="BuffaloButton16" , relativePoint="BOTTOM", xOffs=0, yOffs=-15},
							{point="RIGHT", relativeTo="BuffaloButton23" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton24" , relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton25", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton26", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton27", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton28", relativePoint="LEFT", xOffs=-5, yOffs=0},
							{point="RIGHT", relativeTo="BuffaloButton29", relativePoint="LEFT", xOffs=-5, yOffs=0},
					},

				debuff = {	{point="TOPRIGHT", relativeTo="DebuffaloFrame", relativePoint="TOPRIGHT", xOffs=0, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton0", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton1", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton2", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton3", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton4", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton5", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton6", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="TOP", relativeTo="DebuffButton0", relativePoint="BOTTOM", xOffs=0, yOffs=-15},
				 			{point="RIGHT", relativeTo="DebuffButton8", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton9", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton10", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton11", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton12", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton13", relativePoint="LEFT", xOffs=-5, yOffs=0},
				 			{point="RIGHT", relativeTo="DebuffButton14", relativePoint="LEFT", xOffs=-5, yOffs=0},
				},

				weapon = {	{point="TOPRIGHT", relativeTo="WeaponBuffaloFrame", relativePoint="TOPRIGHT", xOffs=0, yOffs=0},
				 			{point="RIGHT", relativeTo="WeaponBuffalo1", relativePoint="LEFT", xOffs=-5, yOffs=0},
				}

			}



function Buffalo.ButtonIterator(cat, n)
	self=Buffalo
-- 		self:Debug("n:",n)
-- 		self:Debug("min",MININDEX[cat])
-- 		self:Debug("max",MAXINDEX[cat])
	local buttonName, ghostButtonLabel
	if(not n) then
		n=MININDEX[cat]
		buttonName=BUTTONNAME[cat].."0"
	elseif(MININDEX[cat]<=n and n<MAXINDEX[cat]) then
		n=n+1
		buttonName=BUTTONNAME[cat]..(n-MININDEX[cat])
	else
		n=nil
	end
	if(cat==WEAPON and n) then
		ghostButtonLabel = TEMPENCHANTGHOSTTEXT[n+1]
	elseif(n) then
		ghostButtonLabel = n+1 - MININDEX[cat]
	end
	return n, buttonName, ghostButtonLabel
end

function Buffalo:OnInitialize()
	self.dewdrop = AceLibrary("Dewdrop-2.0")
end

function Buffalo:OnEnable()
	if( not BuffaloButton0) then
		self:CreateBuffButtons()
	end
	self:SetDebugging(DEBUGMODE)
	self:DisableBlizzardBuffs()
	for cat, frameName in pairs(FRAME_NAME) do
		getglobal(frameName):Show()
	end
	self:RestoreSettings()
-- 	dewdrop:Register(UIParent, Buffalo_OptionsTable)
--	self:EnableBuffaloBuffs()
-- 	for i, buttonName in self.ButtonIterator, "buff", nil do
-- 		self:Debug("ButtonID: ", getglobal(buttonName):GetID())
-- 	end
end

function Buffalo:OnDisable()
	self:EnableBlizzardBuffs()
	for cat, frameName in pairs(FRAME_NAME) do
		getglobal(frameName):Hide()
	end
end

function Buffalo:OnProfileEnable()
	self:FillAnchors()
end

function Buffalo:RestoreSettings()
	self:ToggleLock(self.db.profile.locked)
	self:FillAnchors()
end

function Buffalo:DisableBlizzardBuffs()
	BuffaloFrame:Show()
	DebuffaloFrame:Show()
	WeaponBuffaloFrame:Show()
	BuffFrame:Hide()
	TemporaryEnchantFrame:Hide()
	for i=0,23 do
		button = getglobal("BuffButton"..i)
		button:UnregisterEvent("PLAYER_AURAS_CHANGED")
		button:Hide()
	end

	for i=1,2 do
		button = getglobal("TempEnchant"..i)
		button:UnregisterEvent("PLAYER_AURAS_CHANGED")
		button:Hide()
	end
end

function Buffalo:EnableBlizzardBuffs()
	BuffaloFrame:Hide()
	DebuffaloFrame:Hide()
	WeaponBuffaloFrame:Hide()
	BuffFrame:Show()
	TemporaryEnchantFrame:Show()
	for i=0,23 do
		button = getglobal("BuffButton"..i)
		button:RegisterEvent("PLAYER_AURAS_CHANGED")
		this = button
		BuffButton_Update()
--		button:Show()
	end

	for i=1,2 do
		button = getglobal("TempEnchant"..i)
		button:RegisterEvent("PLAYER_AURAS_CHANGED")
		button:Show()
	end
end

function Buffalo:CreateBuffButtons()
	for cat, templateName in pairs(BUTTON_TEMPLATE_NAME) do
		for i, buttonName, ghostButtonLabel in self.ButtonIterator, cat, nil do
			local button = CreateFrame("Button", buttonName, getglobal(FRAME_NAME[cat]), templateName)
			button.cat=cat
			if(cat ~= "weapon") then
				button:SetID(i)
			else
				button:SetID(i+16)
			end
			button.buffFilter=BUFF_FILTER[cat]
			button:RegisterForClicks("RightButtonUp")
			getglobal(button:GetName().."_Ghost_Label"):SetText(ghostButtonLabel)
			getglobal(button:GetName().."_Ghost_Texture"):SetTexture(GHOST_COLOR[cat].r, GHOST_COLOR[cat].g, GHOST_COLOR[cat].b, GHOST_COLOR.alpha)
			self:BuffaloButton_Update(button)
		end
	end
	self:FillAnchors()
end

function Buffalo:BuffaloButton_Update(button)
 	local buffIndex, untilCancelled = GetPlayerBuff(button:GetID(), button.buffFilter);
 	button.buffIndex = buffIndex;
 	button.untilCancelled = untilCancelled;
 	local timeLeft = GetPlayerBuffTimeLeft(buffIndex)
 	local buffDuration = getglobal(button:GetName().."Duration");
 	buffDuration:SetText(self:GetDurationString(timeLeft, button.cat))

 	if ( buffIndex < 0 and self.db.profile.locked) then
 		button:Hide();
 		buffDuration:Hide();
 	else
 		button:SetAlpha(1.0);
 		button:Show();
 		if ( SHOW_BUFF_DURATIONS == "1" and timeLeft > 0) then
 			buffDuration:Show();
 		else
 			buffDuration:Hide();
 		end
 	end

 	local icon = getglobal(button:GetName().."Icon");
 	icon:SetTexture(GetPlayerBuffTexture(buffIndex));

 	-- Set color of debuff border based on dispel class.
 	local color;
 	local debuffType = GetPlayerBuffDispelType(GetPlayerBuff(button:GetID(), "HARMFUL"));
 	local debuffSlot = getglobal(button:GetName().."Border");
--  	self:Debug("debuffType:",debuffType)
--  	self:Debug("debuffSlot:",debuffSlot)
 	if ( debuffType ) then
 		color = DebuffTypeColor[debuffType];
 		color.a=1
 	elseif(buffIndex >= 0) then
 		color = DebuffTypeColor["none"];
 		color.a=1
 	else
 		color = {r=0, g=0, b=0, a=0}
 	end
 	if ( debuffSlot ) then
 		debuffSlot:SetVertexColor(color.r, color.g, color.b, color.a);
 	end

	-- Set the number of applications of an aura if its a debuff
	local buffCount = getglobal(button:GetName().."Count");
	local count = GetPlayerBuffApplications(buffIndex);
	if ( count > 1 ) then
		buffCount:SetText(count);
		buffCount:Show();
	else
		buffCount:Hide();
	end

	if ( GameTooltip:IsOwned(button) ) then
		GameTooltip:SetPlayerBuff(buffIndex);
	end
	self.printnext=DebuffaloButton1 and (button:GetName() == "DebuffaloButton1")
	self:Test("Nach _Update")
end

function Buffalo:WeaponBuffaloFrame_OnUpdate(elapsed)
	timeSinceWeaponUpdate = timeSinceWeaponUpdate + elapsed
	if(timeSinceWeaponUpdate > UPDATETIME) then
		local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();

		if(hasMainHandEnchant) then
			local textureName = GetInventoryItemTexture("player", 16)
			WeaponBuffaloButton0Icon:SetTexture(textureName)
			WeaponBuffaloButton0Duration:SetText(self:GetDurationString(mainHandExpiration/1000, "weapon"))
			WeaponBuffaloButton0Duration:Show()
			if(mainHandCharges > 0) then
				WeaponBuffaloButton0Count:SetText(mainHandCharges)
				WeaponBuffaloButton0Count:Show()
			else
				WeaponBuffaloButton0Count:Hide()
			end
			WeaponBuffaloButton0:SetID(16)
			WeaponBuffaloButton0:Show()
		elseif(self.db.profile.locked) then
			WeaponBuffaloButton0:Hide()
		else
			WeaponBuffaloButton0Icon:SetTexture(nil)
		end

		if(hasOffHandEnchant) then
			local textureName = GetInventoryItemTexture("player", 17)
			WeaponBuffaloButton1Icon:SetTexture(textureName)
			WeaponBuffaloButton1Duration:SetText(self:GetDurationString(offHandExpiration/1000, "weapon"))
			WeaponBuffaloButton1Duration:Show()
			if(offHandCharges > 0) then
				WeaponBuffaloButton1Count:SetText(offHandCharges)
				WeaponBuffaloButton1Count:Show()
			else
				WeaponBuffaloButton1Count:Hide()
			end
			WeaponBuffaloButton1:SetID(17)
			WeaponBuffaloButton1:Show()
		elseif(self.db.profile.locked) then
			WeaponBuffaloButton1:Hide()
		else
			WeaponBuffaloButton1Icon:SetTexture(nil)
		end

		timeSinceWeaponUpdate = 0
	end
end

function Buffalo:BuffButton_OnUpdate(elapsed, button)
	button.timeSinceLastUpdate = button.timeSinceLastUpdate + elapsed
	if(button.timeSinceLastUpdate > UPDATETIME) then
		local buffDuration = getglobal(button:GetName().."Duration");
		if ( button.untilCancelled == 1 ) then
			buffDuration:Hide();
			return;
		end
	
		local buffIndex = button.buffIndex;
		local timeLeft = GetPlayerBuffTimeLeft(buffIndex);
		if ( timeLeft < BUFF_WARNING_TIME and self.db.profile.locked and self.db.profile.flashes[button.cat]) then
--			local ghost = getglobal(button:GetName().."_Ghost_Texture")
--			ghost:SetTexture(GHOST_COLOR.warning.r, GHOST_COLOR.warning.g, GHOST_COLOR.warning.b)
			UIFrameFlash(button, 2, 2, timeLeft, false, 0, 0)
		else
			UIFrameFlashRemoveFrame(button)
			button:SetAlpha(1.0);
		end
	
		-- Update duration
		if(timeLeft>0) then
			buffDuration:SetText(self:GetDurationString(timeLeft, button.cat))
			buffDuration:Show()
		else
			buffDuration:Hide()
		end
		if ( BuffFrameUpdateTime > 0 ) then
			return;
		end
		if ( GameTooltip:IsOwned(button) ) then
			GameTooltip:SetPlayerBuff(buffIndex);
		end
		button.timeSinceLastUpdate = 0
	end
end


function Buffalo:GetDurationString(seconds, cat)
	if(not self.db.profile.verboseTimers[cat])then
		return SecondsToTimeAbbrev(seconds)
	else
		if(seconds > 3600) then
			return abacus:FormatDurationCondensed(seconds, self.db.profile.whiteTimers[cat], true)
		else
			return abacus:FormatDurationCondensed(seconds, self.db.profile.whiteTimers[cat], false)
		end
	end
end

function Buffalo:SetShowGhostBuffFrames(value)
	if(value) then
		for cat, templateName in pairs(BUTTON_TEMPLATE_NAME) do
			for _, buttonName, ghostButtonLabel in self.ButtonIterator, cat, nil do
				local label = getglobal(buttonName.."_Ghost_Label")
				local ghost = getglobal(buttonName.."_Ghost_Texture")
				getglobal(buttonName):Show()
				label:SetText(ghostButtonLabel)
				label:Show()
				ghost:SetTexture(GHOST_COLOR[cat].r, GHOST_COLOR[cat].g, GHOST_COLOR[cat].b, GHOST_COLOR.alpha)
				ghost:Show()
			end
		end
	else
		for cat, templateName in pairs(BUTTON_TEMPLATE_NAME) do
			for _, buttonName in self.ButtonIterator, cat, nil do
				local label = getglobal(buttonName.."_Ghost_Label")
				local ghost = getglobal(buttonName.."_Ghost_Texture")
				label:Hide()
				ghost:Hide()
			end
		end
	end
end

function Buffalo:SavePos(cat)
	local frame=getglobal(FRAME_NAME[cat])
	self.db.profile.xPos[cat] = frame:GetLeft()
	self.db.profile.yPos[cat] = frame:GetBottom()
end

function Buffalo:SetScale(scale, cat)
	for i, buttonName in self.ButtonIterator, cat, nil do
		getglobal(buttonName):SetScale(scale)
	end
	local frame = getglobal(FRAME_NAME[cat])
	frame:ClearAllPoints()
	frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", self.db.profile.xPos[cat], self.db.profile.yPos[cat])
	self.db.profile.scale[cat] = scale
end

--[[
Sets the distance between the buff buttons.
padding - the distance in pixels
cat - either "buff", "debuff" or "weapon"
direction - either "x" or "y"
]]
function Buffalo:SetPadding(padding, cat, direction)
	self.db.profile.padding[cat][direction] = padding
	self:FillAnchors(cat)
end

function Buffalo:GetGrowRightCoeff(cat)
	if self.db.profile.growRight[cat] then
		return 1
	else
		return -1
	end
end

function Buffalo:GetGrowUpwardsCoeff(cat)
	if self.db.profile.growUpwards[cat] then
		return 1
	else
		return -1
	end
end

--[[
Sets the direction in which the buffs grow
direction - either "right", "left", "up" or "down"
cat - either "buff", "debuff" or "weapon"
]]
function Buffalo:SetGrowthDirection(direction, cat)
	if(direction == "right") then
		self.db.profile.growRight[cat] = true
	elseif(direction == "left") then
		self.db.profile.growRight[cat] = nil
	elseif(direction == "up") then
		self.db.profile.growUpwards[cat] = true
	elseif(direction == "down") then
		self.db.profile.growUpwards[cat] = nil
	end
	self:FillAnchors(cat)
end

--[[
These set the number of rows/cols for the given cat
cat - either "buff", "debuff" or "weapon"
]]
function Buffalo:SetRows(rows, cat)
	self.db.profile.rows[cat] = rows
	self:FillAnchors(cat)
end
function Buffalo:SetCols(cols, cat)
	self.db.profile.cols[cat] = cols
	self:FillAnchors(cat)
end

function Buffalo:SetGrowHorizontalFirst(value, cat)
	self.db.profile.growHorizontalFirst[cat] = value or false
	self:FillAnchors(cat)
end

function Buffalo:ApplyAnchors(cat)
	if(self.db.profile.locked) then
		BuffButton0:SetMovable(true)
		BuffButton16:SetMovable(true)
		TempEnchant1:SetMovable(true)
	end
	if(type(cat) == "nil") then
		self:ApplyAnchors("buff")
		self:ApplyAnchors("debuff")
		self:ApplyAnchors("weapon")
		return
	end
	local frame = getglobal(FRAME_NAME[cat])
	frame:ClearAllPoints()
	frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", self.db.profile.xPos[cat], self.db.profile.yPos[cat])
	for i, buttonName in self.ButtonIterator, cat, nil do
		local button = getglobal(buttonName)
		local anchor = anchors[cat][i+1]
		button:ClearAllPoints()
		button:SetPoint(anchor.point, anchor.relativeTo, anchor.relativePoint, anchor.xOffs, anchor.yOffs)
	end
	if(self.db.profile.locked) then
		BuffButton0:SetMovable(false)
		BuffButton16:SetMovable(false)
		TempEnchant1:SetMovable(false)
	end
	for cat, _ in pairs(BUTTON_TEMPLATE_NAME) do
		self:SetScale(self.db.profile.scale[cat], cat)
	end
end

function Buffalo:FillAnchors(cat)
	if(type(cat) == "nil") then
		self:FillAnchors("buff")
		self:FillAnchors("debuff")
		self:FillAnchors("weapon")
		return
	end
	for i, buttonName in self.ButtonIterator, cat, nil do
-- 		self:Debug("cat: ", cat)
-- 		self:Debug("i+1: ", i+1)
		local anchor = anchors[cat][i+1]
		if(i==MININDEX[cat]) then -- first button in this category
			anchor.point="TOPRIGHT"
			anchor.relativeTo=FRAME_NAME[cat]
			anchor.relativePoint="TOPRIGHT"
			anchor.xOffs=0
			anchor.yOffs=0
		else
			local anchorPoint, relativePoint, switchAnchorPoint, switchRelativePoint, limit = self:GetAnchorInfo(cat)
			if i==15 and false then
				self:Debug("Button: ", i)
				self:Debug("MinIndex: ", MININDEX[cat])
				self:Debug("limit: ", limit)
			end
			if(mod((i-MININDEX[cat]), limit) == 0 or (limit==1)) then --[[and not (i==MAXINDEX[cat])]]
				anchor.point = switchAnchorPoint
				anchor.relativeTo = BUTTONNAME[cat]..(i-limit)
				anchor.relativePoint = switchRelativePoint
				anchor.xOffs = (not self.db.profile.growHorizontalFirst[cat] and self:GetGrowRightCoeff(cat)*self.db.profile.padding[cat].x) or 0
				anchor.yOffs = (self.db.profile.growHorizontalFirst[cat] and self:GetGrowUpwardsCoeff(cat)*self.db.profile.padding[cat].y) or 0
			else
				anchor.point = anchorPoint
				anchor.relativeTo = BUTTONNAME[cat]..(i-1)
				anchor.relativePoint = relativePoint
				anchor.xOffs = (self.db.profile.growHorizontalFirst[cat] and self:GetGrowRightCoeff(cat)*self.db.profile.padding[cat].x) or 0
				anchor.yOffs = (not self.db.profile.growHorizontalFirst[cat] and self:GetGrowUpwardsCoeff(cat)*self.db.profile.padding[cat].y) or 0
			end
		end
	end
	self:ApplyAnchors(cat)
end

--[[
returns the needed information to determine which button is to be attached to which button in what way. wwwwwww
*anchorPoint - the anchorpoint of the current button
*relativePoint - the point where we attach it to
*switchAnchorPoint, switchRelativePoint - like above, but for when the row / column switches ("linebreak")
*limit - the number of columns / rows where to perform a switch
]]
function Buffalo:GetAnchorInfo(cat)
	local anchorPoint, relativePoint
	local switchAnchorPoint, switchRelativePoint
	local limit
	if(self.db.profile.growHorizontalFirst[cat]) then
		limit = self.db.profile.cols[cat]
		if(self.db.profile.growRight[cat]) then
			anchorPoint = "LEFT"
			relativePoint = "RIGHT"
		else
			anchorPoint = "RIGHT"
			relativePoint = "LEFT"
		end

		if(self.db.profile.growUpwards[cat]) then
			switchAnchorPoint = "BOTTOM"
			switchRelativePoint = "TOP"
		else
			switchAnchorPoint = "TOP"
			switchRelativePoint = "BOTTOM"
		end
	else
		limit = self.db.profile.rows[cat]
		if(self.db.profile.growRight[cat]) then
			switchAnchorPoint = "LEFT"
			switchRelativePoint = "RIGHT"
		else
			switchAnchorPoint = "RIGHT"
			switchRelativePoint = "LEFT"
		end

		if(self.db.profile.growUpwards[cat]) then
			anchorPoint = "BOTTOM"
			relativePoint = "TOP"
		else
			anchorPoint = "TOP"
			relativePoint = "BOTTOM"
		end
	end
	return anchorPoint, relativePoint, switchAnchorPoint, switchRelativePoint, limit
end

function Buffalo:ToggleLock(value)
	for cat, frameName in pairs(FRAME_NAME) do
		local frame = getglobal(frameName)
		frame:SetMovable(not value)
	end
	self.db.profile.locked = value
	self:SetShowGhostBuffFrames(not value)
end

function Buffalo:ToggleHide(value, cat)
	local frame = getglobal(FRAME_NAME[cat])
	self.db.profile.hide[cat] = value
	if(value) then
		frame:Hide()
	else
		frame:Show()
	end
end

function Buffalo:Reset()
	self:ResetDB("profile")
	self:OnProfileEnable()
end

function Buffalo:BuffButton_OnClick(button)
	if(IsAltKeyDown())then
		if(not button.buffFilter) then
			self.dewdrop:Open(button, 'children', Buffalo_OptionsTable.args.weapon)
		elseif(button.buffFilter == "HELPFUL") then
			self.dewdrop:Open(button, 'children', Buffalo_OptionsTable.args.buffs)
		elseif(button.buffFilter == "HARMFUL") then
			self.dewdrop:Open(button, 'children', Buffalo_OptionsTable.args.debuffs)
		end
	else
		CancelPlayerBuff(button.buffIndex);
	end
end

function Buffalo:PrintAnchor(frame)
	if(not self:IsDebugging()) then return end
	point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint()
	self:Debug("Point: ", point or "nil")
	self:Debug("RelativeTo: ", (relativeTo and relativeTo:GetName()) or "nil")
	self:Debug("RelativePoint: ", relativePoint or "nil")
	self:Debug("X-Offset:", xOfs or "nil")
	self:Debug("Y-Offset:", yOfs or "nil")
	local cx, cy = frame:GetCenter()
	self:Debug("Center: ", cx, cy)
end

function Buffalo:Test(position)
	if true then return end
	if(DebuffaloButton1Border) then
		local r,g,b,a = DebuffaloButton1Border:GetVertexColor()
		self:Debug(position, a)
		self.printnext=false
	end
end
