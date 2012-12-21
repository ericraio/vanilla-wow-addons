local _G = getfenv(0)

-- if the Debug library is available then use it
if AceLibrary:HasInstance("AceDebug-2.0") then
	oSkin = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0", "AceHook-2.0", "AceDebug-2.0")
else
	oSkin = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceDB-2.0", "AceConsole-2.0")
	function oSkin:Debug() end
end

-- specify where debug messages go
oSkin.debugFrame = ChatFrame5

function oSkin:OnInitialize()

	self:RegisterDB("oSkinDB")
	self:Defaults()
	self:Options()
	
	self.initialized = {}
	
	self:RegisterChatCommand({"/oskin"}, self.options)
	self.OnMenuRequest = self.options
	
end

function oSkin:OnEnable()

	self:RegisterEvent("AceEvent_FullyInitialized")

	-- when addon taken out of standby
	if AceLibrary("AceEvent-2.0"):IsFullyInitialized() then
		self:AceEvent_FullyInitialized()
	end

end

local backdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
	insets = {left = 4, right = 4, top = 4, bottom = 4},
}

function oSkin:applySkin(frame, header, bba, ba, fh)

	self = oSkin -- for external calls
	frame:SetBackdrop(backdrop)
	frame:SetBackdropBorderColor(self.db.profile.BackdropBorder.r or .5, self.db.profile.BackdropBorder.g or .5, self.db.profile.BackdropBorder.b or .5, bba or self.db.profile.BackdropBorder.a or 1)
	frame:SetBackdropColor(self.db.profile.Backdrop.r or 0, self.db.profile.Backdrop.g or 0, self.db.profile.Backdrop.b or 0, ba or self.db.profile.Backdrop.a or .9)

	if not frame.tfade then frame.tfade = frame:CreateTexture(nil, "BORDER") end
	frame.tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

	frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4)
	if fh then frame.tfade:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, -fh)
	else frame.tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 4) end

	frame.tfade:SetBlendMode("ADD")
	frame.tfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)

	if(header and _G[frame:GetName().."Header"]) then
		_G[frame:GetName().."Header"]:Hide()
		_G[frame:GetName().."Header"]:SetPoint("TOP", frame, "TOP", 0, 7)
	end
	
end

function oSkin:glazeStatusBar(frame, fi)

	if frame:GetFrameType() ~= "StatusBar" then return end
	frame:SetStatusBarTexture("Interface\\AddOns\\oSkin\\textures\\glaze")
	
	if fi then
		if not frame.tfade then frame.tfade = frame:CreateTexture(nil, "BORDER") end
		frame.tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
		frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT",fi,-fi)
		frame.tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",-fi,fi)
		frame.tfade:SetBlendMode("ADD")
		frame.tfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)
	end
	
end

function oSkin:skinTooltip(frame)

	if not frame.tfade then frame.tfade = frame:CreateTexture(nil, "BORDER") end
	frame.tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")

	frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT",1,-1)
	frame.tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",-1,1)

	frame.tfade:SetBlendMode("ADD")
	frame.tfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1)

	frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -6)
	frame.tfade:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -6, -30)
	
end

function oSkin:removeRegions(frame, regions)
	self:Debug("removeRegions: [%s]", frame:GetName() or "???")
	
	if not frame then return end
	
	for i, v in ipairs({ frame:GetRegions() }) do
		-- if we have a list, hide the regions in that list
		-- otherwise, hide all regions of the frame
		if regions then
			for _, r in ipairs(regions) do
				if r == i then v:SetAlpha(0) break end
			end
		else
			self:Debug("remove region: [%s]", i)
			v:SetAlpha(0)
		end
	end
	
end

function oSkin:keepRegions(frame, regions)
	self:Debug("keepRegions: [%s]", frame:GetName() or "???")
	
	if not frame then return end
	
	for i, v in ipairs({ frame:GetRegions() }) do
		-- if we have a list, hide the regions not in that list
		local keep = nil
		if regions then
			for _, r in ipairs(regions) do
				if r == i then keep = true break end
			end
		end
		if not keep then 
			self:Debug("remove region: [%s]", i)
			v:SetAlpha(0)
		end 
	end
	
end

function oSkin:hookDDScript(ddName)
	self:Debug("hookDDScript: [%s]", ddName:GetName())

	self:HookScript(ddName, "OnClick", function()
		self:Debug(ddName:GetName().."_OnClick")
		self.hooks[ddName].OnClick()
		self:skinDropDownLists()
		end)

end

function oSkin:skinDropDownLists()
--	self:Debug("skinDropDownLists")

	for i = 1, UIDROPDOWNMENU_MAXLEVELS do
		self:removeRegions(_G["DropDownList"..i])
		_G["DropDownList"..i.."Backdrop"]:Hide()
		_G["DropDownList"..i.."MenuBackdrop"]:Hide()
		self:applySkin(_G["DropDownList"..i])
	end

end

function oSkin:skinScrollBar(scrollFrame)
--	self:Debug("skinScrollBar: [%s]", scrollFrame:GetName())

	local scrollBar = _G[scrollFrame:GetName().."ScrollBar"]
	scrollBar:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
		edgeFile = "Interface\\AddOns\\oSkin\\textures\\krsnik", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	})
	scrollBar:SetBackdropBorderColor(.2,.2,.2,1)
	scrollBar:SetBackdropColor(.1,.1,.1,1)

end

function oSkin:moveObject(objName, xAdj, xDiff, yAdj, yDiff)
--	self:Debug("moveObject: [%s, %s%s, %s%s]", objName:GetName(), xAdj, xDiff, yAdj, yDiff)

	local point, relativeTo, relativePoint, xOfs, yOfs = objName:GetPoint()
	-- apply the adjustment
	if xAdj == nil then xOffset = xOfs else xOffset = (xAdj == "+" and xOfs + xDiff or xOfs - xDiff) end
	if yAdj == nil then yOffset = yOfs else yOffset = (yAdj == "+" and yOfs + yDiff or yOfs - yDiff) end
--	self:Debug("moveObject#2: [%s, %s]", xOffset, yOffset)

	objName:ClearAllPoints()
	objName:SetPoint(point, relativeTo:GetName(), relativePoint, xOffset, yOffset)
	
end
