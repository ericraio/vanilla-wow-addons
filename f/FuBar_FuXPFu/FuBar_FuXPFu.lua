local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local metro = AceLibrary("Metrognome-2.0")

FuXP = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0", "AceConsole-2.0")

local defaults = {
	Shadow = true,
	ShowRemaining = false,
	Thickness = 2,
	Spark = 1,
	Spark2 = 1,
	XP = {0, 0.4,.9,1},
	Rest = {1, 0.2, 1, 1},
	None = {0.3,0.3,0.3,1},
}

FuXP:RegisterDB("FuXPDB")
FuXP:RegisterDefaults('profile', defaults);

local L = AceLibrary("AceLocale-2.0"):new("FuXP")

function FuXP:GetXPColor()
	return self.db.profile.XP[1], self.db.profile.XP[2], self.db.profile.XP[3]
end

function FuXP:SetXPColor(r, g, b)
	self.db.profile.XP[1] = r
	self.db.profile.XP[2] = g
	self.db.profile.XP[3] = b
	self.XPBarTex:SetVertexColor(r, g, b, 1)
	self.Spark:SetVertexColor(r, g, b, 1)
end

function FuXP:GetRestColor()
	return self.db.profile.Rest[1], self.db.profile.Rest[2], self.db.profile.Rest[3]
end

function FuXP:SetRestColor(r, g, b)
	self.db.profile.Rest[1] = r
	self.db.profile.Rest[2] = g
	self.db.profile.Rest[3] = b
	self.RestedXPTex:SetVertexColor(r, g, b, 1)
end

function FuXP:GetNoXPColor()
	return self.db.profile.None[1], self.db.profile.None[2], self.db.profile.None[3]
end

function FuXP:SetNoXPColor(r, g, b)
	self.db.profile.None[1] = r
	self.db.profile.None[2] = g
	self.db.profile.None[3] = b
	self.NoXPTex:SetVertexColor(r, g, b, 1)
end

local optionsTable = {
	type = 'group',
	args = {
		currentXP = {
			type = "color",
			name = L["Current XP"],
			desc = L["Sets the color of the XP Bar"],
			get = "GetXPColor",
			set = "SetXPColor",
			order = 110,
		},
		restedXP = {
			type = 'color',
			name = L["Rested XP"],
			desc = L["Sets the color of the Rested Bar"],
			get = "GetRestColor",
			set = "SetRestColor",
			order = 111,
		},
		color = {
			type = 'color',
			name = L["No XP"],
			desc = L["Sets the empty color of the XP Bar"],
			get = "GetNoXPColor",
			set = "SetNoXPColor",
			order = 112,
		},
		spark = {
			type = 'range',
			name = L["Spark intensity"],
			desc = L["Brightness level of Spark"],
			get = function() return FuXP.db.profile.Spark end,
			set = function(v) 
				FuXP.db.profile.Spark = v
				FuXP.Spark:SetAlpha(v)
				FuXP.Spark2:SetAlpha(v)
			end,
			min = 0,
			max = 1,
			step = 0.05,
			order = 113
		},
		thickness = {
			type = 'range',
			name = L["Thickness"],
			desc = L["Sets thickness of XP Bar"],
			get = function() return FuXP.db.profile.Thickness end,
			set = function(v)
				FuXP:SetThickness(v)
			end,
			min = 1.5,
			max = 8,
			step = 0.1,
			order = 114
		},
		shadow = {
			type = 'toggle',
			name = L["Shadow"],
			desc = L["Toggles Shadow under XP Bar"],
			get = function() return FuXP.db.profile.Shadow end,
			set = function()
				FuXP.db.profile.Shadow = not FuXP.db.profile.Shadow
				if FuXP.db.profile.Shadow then FuXP.Border:Show() else FuXP.Border:Hide() end
			end,
			order = 115
		},
		remaining = {
			type = 'toggle',
			name = L["Remaining"],
			desc = L["Show Remaining in Bar"],
			get = function() return FuXP.db.profile.ShowRemaining end,
			set = function()
				FuXP.db.profile.ShowRemaining = not FuXP.db.profile.ShowRemaining
			end,
			order = 116
		},
	}
}

FuXP.version = "2.0." .. string.sub("$Revision: 7495 $", 12, -3)
FuXP.hasIcon = true
FuXP.cannotDetachTooltip = true
FuXP.defaultPosition = "LEFT"
FuXP.hideWithoutStandby = true
FuXP.cannotAttachToMinimap = true
FuXP:RegisterChatCommand(L:GetTable("AceConsole-commands"), optionsTable)
FuXP.OnMenuRequest = optionsTable

function FuXP:OnInitialize()
	local XPBar = CreateFrame("Frame", "FuXPBar", UIParent)
	local tex = XPBar:CreateTexture("XPBarTex")
	XPBar:SetFrameStrata("HIGH")
	tex:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\texture.tga")
	tex:SetVertexColor(self.db.profile.XP[1], self.db.profile.XP[2], self.db.profile.XP[3], self.db.profile.XP[4])
	tex:ClearAllPoints()
	tex:SetAllPoints(XPBar)
	tex:Show()
	XPBar:SetHeight(self.db.profile.Thickness)
	
	local spark = XPBar:CreateTexture("XPSpark", "OVERLAY")
	spark:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\glow.tga")
	spark:SetWidth(128)
	spark:SetHeight((self.db.profile.Thickness) * 8)
	spark:SetVertexColor(self.db.profile.XP[1], self.db.profile.XP[2], self.db.profile.XP[3], self.db.profile.Spark or 1)
	spark:SetBlendMode("ADD")

	local spark2 = XPBar:CreateTexture("XPSpark2", "OVERLAY")
	spark2:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\glow2.tga")
	spark2:SetWidth(128)
	spark2:SetAlpha(self.db.profile.Spark or 1)
	spark2:SetHeight((self.db.profile.Thickness) * 8)
	spark2:SetBlendMode("ADD")

	local RestedXP = CreateFrame("Frame", "FuRestXPBar", UIParent)
	local restex = RestedXP:CreateTexture("RestedXPTex")
	restex:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\texture.tga")
	restex:SetVertexColor(self.db.profile.Rest[1], self.db.profile.Rest[2], self.db.profile.Rest[3], self.db.profile.Rest[4])
	restex:ClearAllPoints()
	restex:Show()
	restex:SetAllPoints(RestedXP)
	RestedXP:SetHeight(self.db.profile.Thickness)

	local NoXP = CreateFrame("Frame", "FuNoXPBar", UIParent)
	local notex = NoXP:CreateTexture("NoXPTex")
	notex:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\texture.tga")
	notex:SetVertexColor(self.db.profile.None[1], self.db.profile.None[2], self.db.profile.None[3], self.db.profile.None[4])
	notex:ClearAllPoints()
	notex:Show()
	notex:SetAllPoints(NoXP)
	NoXP:SetHeight(self.db.profile.Thickness)

	local Border = CreateFrame("Frame", "BottomBorder", UIParent)
	local bordtex = Border:CreateTexture("BottomBorderTex")
	bordtex:SetTexture("Interface\\AddOns\\FuBar_FuXPFu\\Textures\\border.tga")
	bordtex:SetVertexColor(0, 0, 0, 1)
	bordtex:ClearAllPoints()
	bordtex:SetAllPoints(Border)
	Border:SetHeight(5)
	if not self.db.profile.Shadow then
		Border:Hide()
	end


	self.XPBar = XPBar
	self.XPBarTex = tex
	self.Spark = spark
	self.Spark2 = spark2
	self.NoXP = NoXP
	self.NoXPTex = notex
	self.RestedXP = RestedXP
	self.RestedXPTex = restex
	self.Border = Border
	self.BorderTex = bordtex
	self.Spark:SetParent(self.XPBar)
	self.Spark2:SetParent(self.XPBar)
	self.RestedXP:SetParent(self.XPBar)
	self.NoXP:SetParent(self.XPBar)
	self.Border:SetParent(self.XPBar)
	metro:Register("XPFuBar", self.Reanchor, 3, self)
	metro:Register(self.name, self.Update, 1, self)
end

function FuXP:OnEnable()
	self:RegisterEvent("UPDATE_EXHAUSTION", "UpdateBars")
	self:RegisterEvent("PLAYER_XP_UPDATE", "UpdateBars")
	self:RegisterEvent("UPDATE_FACTION", "UpdateBars")
	self:RegisterEvent("FuBar_ChangedPanels")
	metro:Start("XPFuBar")
	metro:Start(self.name)
	MainMenuExpBar:Hide()
	ReputationWatchBar:Hide()
	ExhaustionTick:Hide()
end

function FuXP:OnDisable()
	-- you do not need to unregister the event here, all events/hooks are unregistered on disable implicitly.
	self:Print("Disabling")
	self:HideBar()	
	MainMenuExpBar:Show()
	ReputationWatchBar:Show()
	ExhaustionTick:Show()
end

function FuXP:FuBar_ChangedPanels()
	if(self.Loaded) then
		self:Reanchor()
	end
end

function FuXP:Reanchor()
	local point, relpoint, y
	
	if(self.panel) then 
		metro:Stop("XPFuBar") 
	else 
		return 
	end

	self.Loaded = true
	self.Panel = self.panel
	
	if(self.Panel:GetAttachPoint() == "BOTTOM") then
		self.Side = "BOTTOM"
		self.FuPanel = FuBar:GetTopmostBottomPanel()
		point = "BOTTOMLEFT"
		relpoint = "TOPLEFT"
		self.BorderTex:SetTexCoord(1,0,1,0)
	else
		self.Side = "TOP"
		self.FuPanel = FuBar:GetBottommostTopPanel()
		point = "TOPLEFT"
		relpoint = "BOTTOMLEFT"
		self.BorderTex:SetTexCoord(1,0,0,1)
	end
	if(not self.FuPanel) then
		self.FuPanel = self.panel
	end
	self.XPBar:ClearAllPoints()
	self.Spark:ClearAllPoints()
	self.Spark2:ClearAllPoints()
	self.RestedXP:ClearAllPoints()
	self.NoXP:ClearAllPoints()
	self.Border:ClearAllPoints()
	self.XPBar:SetParent(self.FuPanel.frame)
	self.XPBar:SetPoint(point, self.FuPanel.frame, relpoint, 0, y or 0)
	self.Spark:SetPoint("RIGHT", self.XPBar, "RIGHT",11,0 )
	self.Spark2:SetPoint("RIGHT", self.XPBar, "RIGHT",11,0 )
	self.RestedXP:SetPoint("LEFT", self.XPBar, "RIGHT")
	self.NoXP:SetPoint("LEFT", self.RestedXP, "RIGHT")
	self.Border:SetPoint(point, self.XPBar, relpoint)
	self:ShowBar()
	self:UpdateBars()
end

function FuXP:ShowBar()
	self.XPBar:Show()
	self.Spark:Show()
	self.Spark2:Show()
	self.RestedXP:Show()
	self.NoXP:Show()
end

function FuXP:HideBar()
	self.XPBar:Hide()
	self.Spark:Hide()
	self.Spark2:Hide()
	self.RestedXP:Hide()
	self.NoXP:Hide()
end

function FuXP:SetThickness(thickness)
	self.XPBar:SetHeight(thickness)
	self.Spark:SetHeight((thickness) * 8)
	self.Spark2:SetHeight((thickness) * 8)
	self.RestedXP:SetHeight(thickness)
	self.NoXP:SetHeight(thickness)
	self.db.profile.Thickness = thickness
end

function FuXP:UpdateBars()
	if(not self.Loaded) then return end
	
	local name, standing, minRep, maxRep, currentRep = GetWatchedFactionInfo()
	local total = self.Panel.frame:GetWidth()
	
	self.XPBar:SetWidth(0.001)
	self.RestedXP:SetWidth(0.001)
	self.NoXP:SetWidth(0.001)
	self.Border:SetWidth(total)

	if(not name) then
		if(UnitLevel("player") == 60) then
			self.NoXP:SetWidth(total)
			return
		end
		local currentXP = UnitXP("player")
		local maxXP = UnitXPMax("player")
		local restXP = GetXPExhaustion() or 0
		local remainXP = maxXP - (currentXP + restXP)
		
		if(remainXP <= 0) then remainXP = 0 end

		self.XPBar:SetWidth((currentXP/maxXP)*total)
		if(((restXP + currentXP)/maxXP) > 1) then
			self.RestedXP:SetWidth(total - self.XPBar:GetWidth())
		else
			self.RestedXP:SetWidth((restXP/maxXP)*total + 0.001)
		end
		self.NoXP:SetWidth((remainXP/maxXP)*total)
	else
		self.XPBar:SetWidth(((currentRep - minRep)/(maxRep-minRep))*total)
		self.RestedXP:SetWidth(0.0001)
		self.NoXP:SetWidth(((maxRep - currentRep)/(maxRep - minRep))*total)
	end
end

function FuXP:UpdateText()
	if(not self.Loaded) then return end
	if(GetWatchedFactionInfo()) then
		local name, standing, minRep, maxRep, currentRep = GetWatchedFactionInfo()
		if(self.Type == "XP") then
			self:UpdateBars()
		end
		if(self.db.profile.ShowRemaining) then
			self:SetText(string.format(L["%s:%s %3.0f%% left (%s/%s)"], name, maxRep - currentRep, ((currentRep-minRep)/(maxRep-minRep))*100 , currentRep-minRep, maxRep-minRep))
		else
			self:SetText("FuRepFu")
		end
		self.Type = "Rep"
	else
		if(self.Type == "Rep") then
			self:UpdateBars()
		end
		if(self.db.profile.ShowRemaining) then
			self:SetText(string.format(L["%s to go (%3.0f%%)"], UnitXPMax("player") - UnitXP("player"), ((UnitXPMax("player") - UnitXP("player"))/UnitXPMax("player"))*100 ))
		else
			self:SetText("FuXPFu")
		end
		self.Type = "XP"
	end
end

function FuXP:OnTooltipUpdate()
	if(not self.Loaded) then return end

	local totalXP = UnitXPMax("player")
	local currentXP = UnitXP("player")
	local toLevelXP = totalXP - currentXP
	local xp = tablet:AddCategory(
		'columns', 2
	)
	local name, standing, minRep, maxRep, currentRep = GetWatchedFactionInfo()
	
	self:UpdateBars()
	
	if(self.panel:GetAttachPoint() ~= self.Side) then
		self:Reanchor()
	end

	if(not name) then
		xp:AddLine(
			'text', L["Current XP"],
			'text2', string.format("%s/%s (%3.0f%%)", currentXP,totalXP, (currentXP/totalXP)*100)
		)
		xp:AddLine(
			'text', L["To Level"],
			'text2', toLevelXP
		)
		if(GetXPExhaustion()) then
				xp:AddLine(
				'text', L["Rested XP"],
				'text2', string.format("%d (%2.f%%)", GetXPExhaustion(), (GetXPExhaustion()/totalXP)*100)
			)
		end
		tablet:SetHint(L["Click to send your current xp to an open editbox."])
	else
		xp:AddLine(
			'text', L["Faction"],
			'text2', name
		)
		xp:AddLine(
			'text', L["Rep to next standing"],
			'text2', maxRep - currentRep
		)
		xp:AddLine(
			'text', L["Current rep"],
			'text2', getglobal("FACTION_STANDING_LABEL"..standing)
		)
		tablet:SetHint(L["Click to send your current rep to an open editbox."])
	end
end

function FuXP:OnClick()
	local totalXP = UnitXPMax("player")
	local currentXP = UnitXP("player")
	local toLevelXP = totalXP - currentXP
	local name, standing, minRep, maxRep, currentRep = GetWatchedFactionInfo()
	
	if(not name) then
		DEFAULT_CHAT_FRAME.editBox:SetText(string.format(L["%s/%s (%3.0f%%) %d to go"], currentXP,totalXP, (currentXP/totalXP)*100, totalXP - currentXP))
	else
		DEFAULT_CHAT_FRAME.editBox:SetText(string.format(L["%s:%s/%s (%3.2f%%) Currently %s with %d to go"], 
					name,
					currentRep - minRep,
					maxRep - minRep, 
					(currentRep-minRep)/(maxRep-minRep)*100,
					getglobal("FACTION_STANDING_LABEL"..standing),
					maxRep - currentRep))
	end
end