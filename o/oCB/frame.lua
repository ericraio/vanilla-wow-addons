function oCB:CreateFramework(b, n, s)
	self.frames[b] = CreateFrame("Frame", n, UIParent)
	self.frames[b]:Hide()
	self.frames[b].name = b
	
	if(s =="MirrorBar") then
		self.frames[b]:SetScript("OnUpdate", self.OnMirror)
	else
		self.frames[b]:SetScript("OnUpdate", self.OnCasting)
	end
	self.frames[b]:SetMovable(true)
	self.frames[b]:EnableMouse(true)
	self.frames[b]:RegisterForDrag("LeftButton")
	self.frames[b]:SetScript("OnDragStart", function() if not self.db.profile.lock then this:StartMoving() end end)
	self.frames[b]:SetScript("OnDragStop", function() this:StopMovingOrSizing() self:savePosition() end)
	
	self.frames[b].Bar = CreateFrame("StatusBar", nil, self.frames[b])
	self.frames[b].Spark = self.frames[b].Bar:CreateTexture(nil, "OVERLAY")
	self.frames[b].Time = self.frames[b].Bar:CreateFontString(nil, "OVERLAY")
	self.frames[b].Spell = self.frames[b].Bar:CreateFontString(nil, "OVERLAY")
	if(s ~="MirrorBar") then
		self.frames[b].Delay = self.frames[b].Bar:CreateFontString(nil, "OVERLAY")
	end
	
	self:Layout(b, s)
end

function oCB:Layout(b, s)
	local db = self.db.profile[s or b]
	local f, _ = GameFontHighlightSmall:GetFont()
	
	self.frames[b]:SetWidth(db.width+9)
	self.frames[b]:SetHeight(db.height+10)
	self.frames[b]:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = self.Borders[db.edgeFile], edgeSize = 16,
		insets = {left = 5, right = 5, top = 5, bottom = 5},
	})
	self.frames[b]:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
	self.frames[b]:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
	
	self.frames[b].Bar:ClearAllPoints()
	self.frames[b].Bar:SetPoint("CENTER", self.frames[b], "CENTER", 0, 0)
	self.frames[b].Bar:SetWidth(db.width)
	self.frames[b].Bar:SetHeight(db.height)
	self.frames[b].Bar:SetStatusBarTexture(self.Textures[db.texture])
	
	self.frames[b].Spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	self.frames[b].Spark:SetWidth(16)
	self.frames[b].Spark:SetHeight(db.height*2.44)
	self.frames[b].Spark:SetBlendMode("ADD")
	
	self.frames[b].Time:SetJustifyH("RIGHT")
	self.frames[b].Time:SetFont(f,db.timeSize)
	self.frames[b].Time:SetText("X.Y")
	self.frames[b].Time:ClearAllPoints()
	self.frames[b].Time:SetPoint("RIGHT", self.frames[b].Bar, "RIGHT",-10,0)
	
	self.frames[b].Spell:SetJustifyH("CENTER")
	self.frames[b].Spell:SetWidth(db.width-self.frames[b].Time:GetWidth())
	self.frames[b].Spell:SetFont(f,db.spellSize)
	self.frames[b].Spell:ClearAllPoints()
	self.frames[b].Spell:SetPoint("LEFT", self.frames[b], "LEFT",10,0)
	
	if(s ~="MirrorBar") then
		self.frames[b].Delay:SetTextColor(1,0,0,1)
		self.frames[b].Delay:SetJustifyH("RIGHT")
		self.frames[b].Delay:SetFont(f,db.delaySize)
		self.frames[b].Delay:SetText("X.Y")
		self.frames[b].Delay:ClearAllPoints()
		self.frames[b].Delay:SetPoint("TOPRIGHT", self.frames[b], "TOPRIGHT",-10,20)
	end
	
	self:updatePositions(b)
end

function oCB:ShowBlizzCB()
	CastingBarFrame:RegisterEvent("SPELLCAST_START")
	CastingBarFrame:RegisterEvent("SPELLCAST_STOP")
	CastingBarFrame:RegisterEvent("SPELLCAST_INTERRUPTED")
	CastingBarFrame:RegisterEvent("SPELLCAST_FAILED")
	CastingBarFrame:RegisterEvent("SPELLCAST_DELAYED")
	CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_START")
	CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_STOP")
end

function oCB:HideBlizzCB()
	CastingBarFrame:UnregisterEvent("SPELLCAST_START")
	CastingBarFrame:UnregisterEvent("SPELLCAST_STOP")
	CastingBarFrame:UnregisterEvent("SPELLCAST_INTERRUPTED")
	CastingBarFrame:UnregisterEvent("SPELLCAST_FAILED")
	CastingBarFrame:UnregisterEvent("SPELLCAST_DELAYED")
	CastingBarFrame:UnregisterEvent("SPELLCAST_CHANNEL_START")
	CastingBarFrame:UnregisterEvent("SPELLCAST_CHANNEL_STOP")
end