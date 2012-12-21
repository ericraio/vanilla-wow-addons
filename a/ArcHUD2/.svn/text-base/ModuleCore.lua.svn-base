-- Set mixins and libraries
ArcHUD:SetModuleMixins("AceEvent-2.0", "AceHook-2.0", "Metrognome-2.0")
ArcHUD.modulePrototype.parent = ArcHUD

-- Debug function uses the core :Debug function
function ArcHUD.modulePrototype:Debug(level, ...)
	if(self.parent.LevelDebug) then
		self.parent:LevelDebug(level, "["..self.name.."] "..unpack(arg))
	end
end

function ArcHUD.modulePrototype:RegisterDewdropSettings()
	table.insert(self.parent.dewdrop_menu.L1, {"text", self.name, "hasArrow", true, "value", "L2_"..self.name})

	self.parent.dewdrop_menu["L2_"..self.name] = {
		{
			"text", self.name,
			"isTitle", true
		},
		{
			"text", self.L("Version: ")..self.version,
			"notClickable", true
		},
		{
			"text", self.L("Author: ")..self.author,
			"notClickable", true
		},
		{},
		{
			"text", self.L("TEXT","ENABLED"),
			"tooltipTitle", self.L("TEXT","ENABLED"),
			"tooltipText", self.L("TOOLTIP","ENABLED"),
			"checked", false,
			"func", ArcHUD.modDB,
			"arg1", "toggle",
			"arg2", "Enabled",
			"arg3", self.name
		},
		{
			"text", self.L("TEXT","OUTLINE"),
			"tooltipTitle", self.L("TEXT","OUTLINE"),
			"tooltipText", self.L("TOOLTIP","OUTLINE"),
			"checked", false,
			"func", ArcHUD.modDB,
			"arg1", "toggle",
			"arg2", "Outline",
			"arg3", self.name
		},
	}
	local t = {}
	for k,v in ipairs(self.options) do
		if(type(v) == "table") then
			t = {
				"text", self.L("TEXT",v.text),
				"tooltipTitle", self.L("TEXT",v.text),
				"tooltipText", self.L("TOOLTIP",v.tooltip),
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "toggle",
				"arg2", v.name,
				"arg3", self.name
			}
			table.insert(self.parent.dewdrop_menu["L2_"..self.name], t)
		end
	end

	if(self.options.attach) then
		t = {
			"text", self.L("TEXT","SIDE"),
			"tooltipTitle", self.L("TEXT","SIDE"),
			"tooltipText", self.L("TOOLTIP","SIDE"),
			"hasArrow", true,
			"value", "L3_"..self.name
		}
		table.insert(self.parent.dewdrop_menu["L2_"..self.name], t)
		self.parent.dewdrop_menu["L3_"..self.name] = {
			{
				"text", self.L("SIDE","LEFT"),
				"isRadio", true,
				"checked", true,
				"func", ArcHUD.modDB,
				"arg1", "set",
				"arg2", "Side",
				"arg3", self.name,
				"arg4", 1
			},
			{
				"text", self.L("SIDE","RIGHT"),
				"isRadio", true,
				"checked", false,
				"func", ArcHUD.modDB,
				"arg1", "set",
				"arg2", "Side",
				"arg3", self.name,
				"arg4", 2
			},
		}
		t = {
			"text", self.L("TEXT","LEVEL"),
			"tooltipTitle", self.L("TEXT","LEVEL"),
			"tooltipText", self.L("TOOLTIP","LEVEL"),
			"hasArrow", true,
			"hasSlider", true,
			"sliderMin", -5,
			"sliderMax", 5,
			"sliderStep", 1,
			"sliderValue", 0,
			"sliderFunc", ArcHUD.modDB,
			"sliderArg1", "set",
			"sliderArg2", "Level",
			"sliderArg3", self.name
		}
		table.insert(self.parent.dewdrop_menu["L2_"..self.name], t)
	end


end

-- Enabling/Disabling

function ArcHUD.modulePrototype:OnInitialize()
	self.parent:ToggleModuleActive(self, false)
	self:Debug(3, "Creating locale instance")
	self.L = AceLibrary("AceLocale-2.0"):new("ArcHUD_Module")
	if(self.Initialize) then
		self:Initialize()
		self:Debug(2, "Ring initialized")
		self:RegisterEvent("ARCHUD_MODULE_ENABLE")
		self:RegisterEvent("ARCHUD_MODULE_UPDATE")
	else
		self:Debug(1, "Missing Initialize(). Aborting")
		return
	end
	if(self.defaults and type(self.defaults) == "table") then
		-- Add defaults to ArcHUD defaults table
		self:Debug(3, "Acquiring ring DB namespace")
		self.db = self.parent:AcquireDBNamespace(self.name)
		self:Debug(3, "Registering ring default options")
		self.parent:RegisterDefaults(self.name, "profile", self.defaults)
		if(not self.db) then
			self:Debug(1, "Failed to acquire DB namespace")
		end

		-- Register chat commands
		self:RegisterDewdropSettings()
	end

	-- Add metadata for module if it doesn't exist
	if(not self.version) then
		self.version = self.parent.version
	end
	if(not self.author) then
		self.author = self.parent.author
	end
	if(not self.date) then
		self.date = self.parent.date
	end

	self:Debug(3, "Registering Metrognome timers")
	if(not self:MetroStatus(self.name .. "Alpha")) then
		self:RegisterMetro(self.name .. "Alpha", ArcHUDRingTemplate.AlphaUpdate, 0.01, self.f)
	end
	if(not self:MetroStatus(self.name .. "Fade")) then
		self:RegisterMetro(self.name .. "Fade", ArcHUDRingTemplate.DoFadeUpdate, 0.01, self.f)
	end
	if(not self:MetroStatus(self.name .. "Update")) then
		self:RegisterMetro(self.name .. "Update", ArcHUDRingTemplate.UpdateAlpha, 0.05, self)
	end
	self:Debug(2, "Ring loaded")
end

function ArcHUD.modulePrototype:OnEnable()
	self:Debug(3, "Recieved enable event")
	if(self.Enable and self.db.profile.Enabled) then
		self:Debug(2, "Enabling ring")
		if(self.disableEvents and (not self.disableEvents.option or self.disableEvents.option and self.db.profile[self.disableEvents.option])) then
			self:Debug(3, "Disabling events:")
			for k,v in ipairs(self.disableEvents) do
				local f = getglobal(v.frame)
				if(f) then
					self:Debug(3, "- Frame '"..f:GetName().."':")
					for _, event in pairs(v.events) do
						self:Debug(3, "  * "..event)
						f:UnregisterEvent(event)
					end
					if(v.hide and f:IsVisible()) then
						self:Debug(3, "- Frame '"..f:GetName().."' hiding")
						f:Hide()
					end
				end
			end
			self.eventsDisabled = TRUE
		end
		self:Debug(3, "Calling self:Enable()")
		if(self.Update) then
			self:Update()
		end
		self:Enable()
		self:RegisterEvent("ARCHUD_MODULE_DISABLE")
		if(not self:IsEventRegistered("ARCHUD_MODULE_UPDATE")) then
			self:RegisterEvent("ARCHUD_MODULE_UPDATE")
		end
		self:Debug(2, "Ring enabled")
	else
		self:Debug(2, "Ring disabled as per user setting")
		self.parent:ToggleModuleActive(self, false)
	end
end

function ArcHUD.modulePrototype:OnDisable()
	self:Debug(2, "Disabling ring")
	if(self.disableEvents and self.eventsDisabled) then
		self:Debug(3, "Re-enabling events:")
		for k,v in ipairs(self.disableEvents) do
			local f = getglobal(v.frame)
			if(f) then
				self:Debug(3, "- Frame '"..f:GetName().."':")
				for _, event in pairs(v.events) do
					self:Debug(3, "  * "..event)
					f:RegisterEvent(event)
				end
			end
		end
		self.eventsDisabled = FALSE
	end
	if(self.f) then
		self.f:Hide()
	end
	if(self.Disable) then
		self:Disable()
	end
	self:RegisterEvent("ARCHUD_MODULE_ENABLE")
	self:RegisterEvent("ARCHUD_MODULE_UPDATE")
	self:Debug(2, "Ring disabled")
end

function ArcHUD.modulePrototype:ARCHUD_MODULE_ENABLE()
	self.parent:ToggleModuleActive(self, true)
end
function ArcHUD.modulePrototype:ARCHUD_MODULE_DISABLE()
	self.parent:ToggleModuleActive(self, false)
end
function ArcHUD.modulePrototype:ARCHUD_MODULE_UPDATE(module)
	if(module == self.name) then
		if(self.db.profile.Enabled and not self.parent:IsModuleActive(self)) then
			self.parent:ToggleModuleActive(self, true)
		elseif(not self.db.profile.Enabled and self.parent:IsModuleActive(self)) then
			self.parent:ToggleModuleActive(self, false)
		elseif(self.db.profile.Enabled and self.parent:IsModuleActive(self)) then
			if(self.Update) then
				self:Debug(2, "Updating ring")
				self:Update()
			end
		end
	end
end

-- Ring frame creation and setup
function ArcHUD.modulePrototype:CreateRing(hasBG, parent)
	-- Create frame
	local f = CreateFrame("Frame", nil, parent)
	f:SetFrameStrata("BACKGROUND")
	f:SetFrameLevel(10)
	f:SetWidth(256)
	f:SetHeight(256)

	-- Set up textures
	local t

	f.quadrants = {}

	t = f:CreateTexture(nil, "ARTWORK")
	t:SetTexture("Interface\\Addons\\ArcHUD2\\Icons\\Ring.tga")
	t:SetAllPoints(f)
	f.quadrants[1] = t

	t = f:CreateTexture(nil, "ARTWORK")
	t:SetTexture("Interface\\Addons\\ArcHUD2\\Icons\\Ring.tga")
	t:SetAllPoints(f)
	f.quadrants[2] = t

	t = f:CreateTexture(nil, "ARTWORK")
	t:SetTexture("Interface\\Addons\\ArcHUD2\\Icons\\Ring.tga")
	t:SetAllPoints(f)
	f.chip = t

	t = f:CreateTexture(nil, "ARTWORK")
	t:SetTexture("Interface\\Addons\\ArcHUD2\\Icons\\Slice.tga")
	t:SetAllPoints(f)
	f.slice = t

	-- Set up frame
	ArcHUDRingTemplate:OnLoad(f)

	if(hasBG) then
		-- Create frame
		local fBG = CreateFrame("Frame", nil, f)
		fBG:SetFrameLevel(0)
		fBG:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
		fBG:SetWidth(256)
		fBG:SetHeight(256)

		-- Set up textures
		fBG.quadrants = {}
		t = fBG:CreateTexture(nil, "BACKGROUND")
		t:SetTexture("Interface\\Addons\\ArcHUD2\\Icons\\RingBG.tga")
		t:SetAllPoints(fBG)
		fBG.quadrants[1] = t

		t = fBG:CreateTexture(nil, "BACKGROUND")
		t:SetTexture("Interface\\Addons\\ArcHUD2\\Icons\\RingBG.tga")
		t:SetAllPoints(fBG)
		fBG.quadrants[2] = t

		t = fBG:CreateTexture(nil, "BACKGROUND")
		t:SetTexture("Interface\\Addons\\ArcHUD2\\Icons\\RingBG.tga")
		t:SetAllPoints(fBG)
		fBG.chip = t

		t = fBG:CreateTexture(nil, "BACKGROUND")
		t:SetTexture("Interface\\Addons\\ArcHUD2\\Icons\\Slice.tga")
		t:SetAllPoints(fBG)
		fBG.slice = t

		-- Set up frame
		ArcHUDRingTemplate:OnLoadBG(fBG)

		f.BG = fBG
	end

	return f
end

function ArcHUD.modulePrototype:CreateFontString(parent, layer, size, fontsize, justify, color, point)
	local fs = parent:CreateFontString(nil, layer)
	local width, height = unpack(size)

	fs:SetWidth(width)
	fs:SetHeight(height)
	fs:SetFont("Fonts\\"..self.L"FONT", fontsize, "OUTLINE")
	if(color) then
		fs:SetTextColor(unpack(color))
	end
	fs:SetJustifyH(justify)
	fs:SetPoint(unpack(point))

	fs:Show()

	return fs
end

function ArcHUD.modulePrototype:CreateTexture(parent, layer, size, texture, point)
	local t = parent:CreateTexture(nil, layer)
	local width, height = unpack(size)

	t:SetWidth(width)
	t:SetHeight(height)
	if(texture) then
		t:SetTexture(texture)
	end
	if(point) then
		t:SetPoint(unpack(point))
	end

	t:Show()

	return t
end
