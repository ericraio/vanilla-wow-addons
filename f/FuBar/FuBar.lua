local MAJOR_VERSION = "2.0"
local MINOR_VERSION = tonumber((string.gsub("$Revision: 9980 $", "^.-(%d+).-$", "%1")))

if FUBAR_REVISION and FUBAR_REVISION > MINOR_VERSION then
	MINOR_VERSION = FUBAR_REVISION
end
FUBAR_REVISION = nil

local Compost = AceLibrary("Compost-2.0")
local Dewdrop = AceLibrary("Dewdrop-2.0")
local Tablet = AceLibrary:HasInstance("Tablet-2.0") and AceLibrary("Tablet-2.0")
local Jostle = AceLibrary("Jostle-2.0")

local L = AceLibrary("AceLocale-2.0"):new("FuBar")

FuBar = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceConsole-2.0", "AceEvent-2.0", "AceHook-2.0")
local FuBar = FuBar
FuBar.title = "FuBar"
FuBar.version = MAJOR_VERSION .. "." .. MINOR_VERSION
FuBar.date = string.gsub("$Date: 2006-09-03 12:10:31 -1000 (Sun, 03 Sep 2006) $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1")

FuBar:RegisterDB("FuBar2DB")

local charID = AceLibrary("AceDB-2.0").CHAR_ID
local realmID = AceLibrary("AceDB-2.0").REALM_ID
local classID = AceLibrary("AceDB-2.0").CLASS_ID

local _G = getfenv(0)
local plugins = {}

local FuBar_Panel = FuBar_Panel
_G.FuBar_Panel = nil

if not FUBAR_DEFAULTS then
	FUBAR_DEFAULTS = function()
		return {
			fontSize = 12,
			adjust = true,
			panels = {
				[1] = {
					attachPoint = "TOP",
					plugins = {
						left = {
							"LocationFu",
							"ExperienceFu",
							"PerformanceFu",
						},
						center = {},
						right = {
							"ClockFu",
							"VolumeFu",
						}
					}
				}, 
				[2] = {
					attachPoint = "BOTTOM"
				}
			}
		}
	end
end

local CATEGORIES = {
	["Action Bars"] = L["Action Bars"],
	["Auction"] = L["Auction"],
	["Audio"] = L["Audio"],
	["Battlegrounds/PvP"] = L["Battlegrounds/PvP"],
	["Buffs"] = L["Buffs"],
	["Chat/Communication"] = L["Chat/Communication"],
	["Druid"] = L["Druid"],
	["Hunter"] = L["Hunter"],
	["Mage"] = L["Mage"],
	["Paladin"] = L["Paladin"],
	["Priest"] = L["Priest"],
	["Rogue"] = L["Rogue"],
	["Shaman"] = L["Shaman"],
	["Warlock"] = L["Warlock"],
	["Warrior"] = L["Warrior"],
	["Healer"] = L["Healer"],
	["Tank"] = L["Tank"],
	["Caster"] = L["Caster"],
	["Combat"] = L["Combat"],
	["Compilations"] = L["Compilations"],
	["Data Export"] = L["Data Export"],
	["Development Tools"] = L["Development Tools"],
	["Guild"] = L["Guild"],
	["Frame Modification"] = L["Frame Modification"],
	["Interface Enhancements"] = L["Interface Enhancements"],
	["Inventory"] = L["Inventory"],
	["Library"] = L["Library"],
	["Map"] = L["Map"],
	["Mail"] = L["Mail"],
	["Miscellaneous"] = L["Miscellaneous"],
	["Quest"] = L["Quest"],
	["Raid"] = L["Raid"],
	["Tradeskill"] = L["Tradeskill"],
	["UnitFrame"] = L["UnitFrame"],
	["Others"] = L["Others"],
}

local basePluginFrame

local alreadyEnabled = false

local backgrounds = {["Interface\\AddOns\\FuBar\\background"] = L["Default"]}

function FuBar:RegisterSkin(name, bgFile)
	assert(type(name) == "string", "You must provide a name for your skin")
	assert(type(bgFile) == "string", "You must provide a file for your skin")
	if not backgrounds[bgFile] then
		backgrounds[bgFile] = name
	end
end

local function SetBackground(bgFile)
	if backgrounds[bgFile] then
		FuBar.db.profile.skin = bgFile
		FuBar_Panel:SetBackground(bgFile)
	end
end

local function GetBackground()
	return backgrounds[FuBar.db.profile.skin] and FuBar.db.profile.skin or "Interface\\AddOns\\FuBar\\background"
end

local function background_sort(alpha, bravo)
	return backgrounds[alpha] < backgrounds[bravo]
end

local optionsTable = {
	handler = FuBar,
	type = "group",
	args = {
		overflow = {
			type = "toggle",
			name = L["Overflow plugins"],
			desc = L["Let plugins overflow onto another panel"],
			get = "IsOverflowing",
			set = "ToggleOverflowing",
		},
		create = {
			type = "execute",
			name = L["Create new panel"],
			desc = L["Create new panel"],
			func = "new",
			handler = FuBar_Panel
		},
		adjust = {
			type = "toggle",
			name = L["Auto-adjust frames"],
			desc = L["Toggle auto-adjustment of blizzard's frames"],
			get = "IsAdjust",
			set = "ToggleAdjust",
		},
		autohideTop = {
			type = "toggle",
			name = L["Auto-hide top panels"],
			desc = L["Toggle auto-hiding of the top panels"],
			get = "IsAutoHidingTop",
			set = "ToggleAutoHidingTop",
		},
		autohideBottom = {
			type = "toggle",
			name = L["Auto-hide bottom panels"],
			desc = L["Toggle auto-hiding of the bottom panels"],
			get = "IsAutoHidingBottom",
			set = "ToggleAutoHidingBottom",
		},
		texture = {
			type = "text",
			name = L["Texture"],
			desc = L["Change the texture of the panels"],
			get = GetBackground,
			set = SetBackground,
			validate = backgrounds
		},
		spacing = {
			type = "group",
			name = L["Spacing"],
			desc = L["Spacing between plugins"],
			args = {
				left = {
					type = "range",
					name = L["Left-aligned spacing"],
					desc = L["Set spacing between left-aligned plugins"],
					max = 40,
					min = 0,
					step = 1,
					get = "GetLeftSpacing",
					set = "SetLeftSpacing",
				},
				center = {
					type = "range",
					name = L["Center-aligned spacing"],
					desc = L["Set spacing between center-aligned plugins"],
					max = 40,
					min = 0,
					step = 1,
					get = "GetCenterSpacing",
					set = "SetCenterSpacing",
				},
				right = {
					type = "range",
					name = L["Right-aligned spacing"],
					desc = L["Set spacing between right-aligned plugins"],
					max = 40,
					min = 0,
					step = 1,
					get = "GetRightSpacing",
					set = "SetRightSpacing",
				},
			}
		},
		fontsize = {
			type = "group",
			name = L["Font size"],
			desc = L["Font size"],
			args = {
				panel = {
					type = "range",
					name = L["Panel font size"],
					desc = L["Set font size for the plugins on the panel"],
					max = 24,
					min = 7,
					step = 1,
					get = "GetFontSize",
					set = "SetFontSize",
				},
				tooltip = {
					type = "range",
					name = L["Tooltip font size"],
					desc = L["Set font size for the tooltip"],
					max = 2,
					min = 0.5,
					isPercent = true,
					get = function()
						return Tablet:GetFontSizePercent(FuBar.db.profile.tooltip)
					end,
					set = function(value)
						return Tablet:SetFontSizePercent(FuBar.db.profile.tooltip, value)
					end,
					hidden = function()
						return not Tablet
					end
				}
			}
		},
		transparency = {
			type = "group",
			name = L["Transparency"],
			desc = L["Transparency"],
			args = {
				panel = {
					type = "range",
					name = L["Panel transparency"],
					desc = L["Set transparency of the panels"],
					max = 1,
					min = 0,
					step = 0.05,
					isPercent = true,
					get = "GetTransparency",
					set = "SetTransparency",
				},
				tooltip = {
					type = "range",
					name = L["Tooltip transparency"],
					desc = L["Set transparency of the tooltip"],
					max = 1,
					min = 0,
					step = 0.05,
					isPercent = true,
					get = function()
						return Tablet:GetTransparency(FuBar.db.profile.tooltip)
					end,
					set = function(value)
						return Tablet:SetTransparency(FuBar.db.profile.tooltip, value)
					end,
					hidden = function()
						return not Tablet
					end
				}
			}
		},
		thickness = {
			type = "range",
			name = L["Thickness"],
			desc = L["Set thickness between the panels"],
			max = 20,
			min = 0,
			step = 1,
			get = "GetThickness",
			set = "SetThickness",
		},
	}
}

FuBar:RegisterChatCommand(L:GetTable("ChatCommands"), optionsTable)

optionsTable.args.standby = nil

function FuBar:GetScaledCursorPosition()
	local x, y = GetCursorPosition()
	local scale = GetScreenHeight() / 768
	return x * scale, y * scale
end

function FuBar:Reset()
	self:UnregisterEvent("PLAYER_LOGOUT")
	FuBar2DB = {}
	ReloadUI()
end

function FuBar:GetPanel(panelId)
	return FuBar_Panel.instances[panelId]
end

function FuBar:GetNumPanels()
	return table.getn(FuBar_Panel.instances)
end

function FuBar:GetBottommostTopPanel()
	local bottom = GetScreenHeight()
	local best
	for i = 1, self:GetNumPanels() do
		local panel = self:GetPanel(i)
		if panel:GetAttachPoint() == "TOP" and panel.frame:GetBottom() < bottom then
			bottom = panel.frame:GetBottom()
			best = panel
		end
	end
	return best
end

function FuBar:GetTopmostBottomPanel()
	local top = 0
	local best
	for i = 1, self:GetNumPanels() do
		local panel = self:GetPanel(i)
		if panel:GetAttachPoint() == "BOTTOM" and panel.frame:GetTop() > top then
			top = panel.frame:GetTop()
			best = panel
		end
	end
	return best
end

local isChangingProfile, previousProfile

function FuBar:IsChangingProfile()
	return isChangingProfile
end

function FuBar:GetPluginProfiling()
	for _,p in ipairs(plugins) do
		if p:GetTitle() == self.db.profile.profilePlugin then
			return p, p:GetTitle()
		end
	end
end

function FuBar:SetPluginProfiling(plugin)
	self.db.profile.profilePlugin = plugin:GetTitle()
end

function FuBar:IsAdjust()
	return self.db.profile.adjust
end

function FuBar:ToggleAdjust()
	self.db.profile.adjust = not self.db.profile.adjust
	self:UpdateJostleAdjustments()
	return self.db.profile.adjust
end

function FuBar:IsOverflowing()
	return not self.db.profile.overflow
end

function FuBar:ToggleOverflowing()
	self.db.profile.overflow = not self.db.profile.overflow
	for i = 1, self:GetNumPanels() do
		self:GetPanel(i):CheckForOverlap()
	end
	return not self.db.profile.overflow
end

function FuBar:UpdateJostleAdjustments()
	if not self.db.profile.adjust then
		Jostle:DisableTopAdjusting()
		Jostle:DisableBottomAdjusting()
	else
		if self:IsAutoHidingTop() then
			Jostle:DisableTopAdjusting()
		else
			Jostle:EnableTopAdjusting()
		end
		if self:IsAutoHidingBottom() then
			Jostle:DisableBottomAdjusting()
		else
			Jostle:EnableBottomAdjusting()
		end
	end
end

function FuBar:IsAutoHidingTop()
	return self.db.profile.autohideTop
end

local autohideTopTime, autohideBottomTime

function FuBar:ToggleAutoHidingTop()
	self.db.profile.autohideTop = not self.db.profile.autohideTop
	self:UpdateJostleAdjustments()
	if not self.db.profile.autohideTop then
		for i = 1, self:GetNumPanels() do
			if self:GetPanel(i):GetAttachPoint() == "TOP" then
				local frame = getglobal("FuBarFrame" .. i)
				frame:SetAlpha(1)
				frame:SetFrameStrata("HIGH")
			end
		end
	else
		self:ScheduleEvent("FuBar_AutoHideTop", self.OnUpdate_AutoHideTop, 1, self)
	end
	autohideTopTime = GetTime()
	return self.db.profile.autohideTop
end

function FuBar:IsAutoHidingBottom()
	return self.db.profile.autohideBottom
end

function FuBar:ToggleAutoHidingBottom()
	self.db.profile.autohideBottom = not self.db.profile.autohideBottom
	self:UpdateJostleAdjustments()
	if not self.db.profile.autohideBottom then
		for i = 1, self:GetNumPanels() do
			if self:GetPanel(i):GetAttachPoint() == "BOTTOM" then
				local frame = getglobal("FuBarFrame" .. i)
				frame:SetAlpha(1)
				frame:SetFrameStrata("HIGH")
			end
		end
	else
		self:ScheduleEvent("FuBar_AutoHideBottom", self.OnUpdate_AutoHideBottom, 1, self)
	end
	autohideBottomTime = GetTime()
	return self.db.profile.autohideBottom
end

function FuBar:GetFontSize()
	if not self.db.profile then
		return 12
	end
	return self.db.profile.fontSize or 12
end
	
function FuBar:SetFontSize(size)
	size = size or 12
	self.db.profile.fontSize = size
	for i,plugin in ipairs(plugins) do
		if type(plugin.SetFontSize) ~= "function" then
			table.remove(plugins, i)
			i = i - 1
		else
			plugin:SetFontSize(size)
		end
	end
	for i = 1, self:GetNumPanels() do
		self:GetPanel(i):UpdateTexture()
	end
	self:Update()
	Jostle:Refresh()
end

function FuBar:GetLeftSpacing()
	if not self.db.profile then
		return 20
	end
	return self.db.profile.leftSpacing or 20
end

function FuBar:SetLeftSpacing(size)
	self.db.profile.leftSpacing = size
	self:Update()
end

function FuBar:GetCenterSpacing()
	if not self.db.profile then
		return 20
	end
	return self.db.profile.centerSpacing or 20
end

function FuBar:SetCenterSpacing(size)
	self.db.profile.centerSpacing = size
	self:Update()
end
	
function FuBar:GetRightSpacing()
	if not self.db.profile then
		return 20
	end
	return self.db.profile.rightSpacing or 20
end

function FuBar:SetRightSpacing(size)
	self.db.profile.rightSpacing = size
	self:Update()
end

function FuBar:SetThickness(size)
	self.db.profile.thickness = size
	for i = 1, self:GetNumPanels() do
		self:GetPanel(i):UpdateTexture()
	end
	self:Update()
	Jostle:Refresh()
end

function FuBar:GetThickness(size)
	if not self.db.profile then
		return 5
	end
	return self.db.profile.thickness or 5
end

function FuBar:GetTransparency()
	return self.db.profile.transparency or 0.8
end

function FuBar:SetTransparency(value)
	self.db.profile.transparency = value
	for i = 1, self:GetNumPanels() do
		self:GetPanel(i):UpdateTexture()
	end
end

local function CheckLoadCondition(loadCondition)
	return RunScript("(function()"..loadCondition.." end)()")
end

local function _IsCorrectPlugin(plugin)
	if type(plugin) ~= "table" then
		return false
	elseif type(plugin.GetName) ~= "function" then
		return false
	elseif type(plugin.GetTitle) ~= "function" then
		return false
	elseif type(plugin.GetCategory) ~= "function" then
		return false
	elseif type(plugin.SetFontSize) ~= "function" then
		return false
	elseif type(plugin.GetFrame) ~= "function" then
		return false
	elseif type(plugin.Show) ~= "function" then
		return false
	elseif type(plugin.Hide) ~= "function" then
		return false
	elseif type(plugin.GetPanel) ~= "function" then
		return false
	elseif type(plugin:GetName()) ~= "string" then
		return false
	elseif type(plugin:GetTitle()) ~= "string" then
		return false
	elseif type(plugin:GetCategory()) ~= "string" then
		return false
	end
	local frame = plugin:GetFrame()
	if type(frame) ~= "table" then
		return false
	elseif type(frame[0]) ~= "userdata" then
		return false
	elseif type(frame.GetFrameType) ~= "function" then
		return false
	elseif type(frame:GetFrameType()) ~= "string" then
		return false
	end
	return true
end

local donothing = function() end

local function IsCorrectPlugin(plugin)
	local add = DEFAULT_CHAT_FRAME.AddMessage
	DEFAULT_CHAT_FRAME.AddMessage = donothing
	local ret, msg = pcall(_IsCorrectPlugin, plugin)
	DEFAULT_CHAT_FRAME.AddMessage = add
	if ret then
		return msg
	end
end

local function _IsCorrectPanel(panel)
	if type(panel) ~= "table" then
		return false
	elseif type(panel.AddPlugin) ~= "function" then
		return false
	elseif type(panel.RemovePlugin) ~= "function" then
		return false
	elseif type(panel.GetNumPlugins) ~= "function" then
		return false
	elseif type(panel:GetNumPlugins()) ~= "number" then
		return false
	elseif type(panel.GetPlugin) ~= "function" then
		return false
	elseif type(panel.HasPlugin) ~= "function" then
		return false
	elseif type(panel.GetPluginSide) ~= "function" then
		return false
	end
	return true
end

local function IsCorrectPanel(panel)
	local add = DEFAULT_CHAT_FRAME.AddMessage
	DEFAULT_CHAT_FRAME.AddMessage = donothing
	local ret, msg = pcall(_IsCorrectPanel, panel)
	DEFAULT_CHAT_FRAME.AddMessage = add
	if ret then
		return msg
	end
end

local n
local mt = {
	__newindex = function(self, k, v)
		rawset(self, k, v)
		n[k] = v
	end,
}

local function IsAceAddon(addon)
	if type(addon) ~= "table" then
		return false
	elseif addon == AceAddon then
		return true
	elseif not getmetatable(addon) then
		return false
	else
		return IsAceAddon(getmetatable(addon).__index)
	end
end

local blank = {}
local function LoadAddOnWrapper(addon)
	local o = getfenv(0)
	n = {}
	setmetatable(o, mt)
	local success, ret = pcall(LoadAddOn, addon)
	setmetatable(o, blank)
	if not ret then
		FuBar:Print("Error loading LoadOnDemand plugin " .. addon)
		return
	elseif not success then
		FuBar:Print("Error loading LoadOnDemand plugin " .. addon .. ": " .. ret)
		return
	end
	
	local dependencies
	local plugin
	for k,v in pairs(n) do
		if IsCorrectPlugin(v) then
			if plugin then
				if not dependencies then
					dependencies = {}
				end
				table.insert(dependencies, plugin)
			end
			plugin = v
			if IsAceAddon(plugin) then
				if not plugin._initialized then
					if not AceData.profileBasePath then
						--plugin._initialized = true
						--plugin:Initialize()
						--ace1ToBeInitialized[plugin] = true
					else
						plugin._initialized = true
						ace:InitializeApp(plugin)
					end
				end
			else
				if not plugin._initialized then
					plugin._initialized = true
					if type(plugin.Initialize) == "function" then
						plugin:Initialize()
					end
				end
			end
		end
	end
	if not plugin then
		FuBar:Print("Error loading LoadOnDemand plugin " .. addon)
		return
	end
	return ret, plugin, dependencies
end

local toBeLoaded

local function CleanDB()
	local self = FuBar
	
	local t = Compost:Acquire()
	for _,panel in ipairs(self.db.profile.panels) do
		if panel and panel.plugins then
			for _,part in pairs(panel.plugins) do
				if part then
					for i,plugin in ipairs(part) do
						if t[plugin] then
							i = i - 1
							table.remove(part, i)
						else
							t[plugin] = true
						end
					end
				end
			end
		end
	end
	t = Compost:Reclaim(t)
end

function FuBar:OnInitialize()
	toBeLoaded = {}
	
	if not next(FuBar.db.profile) then
		local def
		local profile = self:GetProfile()
		if string.find(profile, "^char/") or string.find(profile, "^class/") then
			local _,class = UnitClass("player")
			def = _G["FUBAR_DEFAULTS_" .. class] or FUBAR_DEFAULTS
		else
			def = FUBAR_DEFAULTS
		end
		if type(def) == "function" then
			def = def()
		end
		for k,v in pairs(def) do
			FuBar.db.profile[k] = v
		end
	end
	
	if not self.db.profile.loadOnDemand then
		self.db.profile.loadOnDemand = {}
	end
	
	if not self.db.profile.tooltip then
		self.db.profile.tooltip = {}
	end
	
	self:SetFontSize(self:GetFontSize())
	
	self.menu = function(level, value)
		local panelId = FuBar_Panel.selectedPanel or 1
		local panel = self:GetPanel(panelId)
		
		if not panel then
			Dewdrop:Close()
			return
		end
		
		if level == 1 then
			Dewdrop:AddLine(
				'text', self.name,
				'isTitle', true
			)
			
			local menuTitles = Compost:Acquire()
			for _,plugin in ipairs(plugins) do
				local alreadyExists = false
				local category = plugin:GetCategory()
				if not CATEGORIES[category] then
					category = L["Others"]
				end
				menuTitles[category] = true
			end
			for _,name in ipairs(toBeLoaded) do
				local category = self.db.profile.loadOnDemand[name].category
				if not CATEGORIES[category] then
					category = L["Others"]
				end
				menuTitles[category] = true
			end
			local titles = Compost:Acquire()
			for name in menuTitles do
				table.insert(titles, name)
			end
			Compost:Reclaim(menuTitles)
			table.sort(titles)
			for _,category in ipairs(titles) do
				Dewdrop:AddLine(
					'text', CATEGORIES[category],
					'value', category,
					'hasArrow', true
				)
			end
			Compost:Reclaim(titles)
			
			Dewdrop:AddLine()
			
			Dewdrop:AddLine(
				'text', L["Attach"],
				'hasArrow', true,
				'value', "attach"
			)
			
			Dewdrop:AddLine(
				'text', L["Lock panel"],
				'arg1', panel,
				'func', "ToggleLocked",
				'checked', panel:IsLocked()
			)
			
			Dewdrop:AddLine(
				'text', L["Remove panel"],
				'arg1', panel,
				'func', "WarnDestroy",
				'disabled', panelId == 1 and not self:GetPanel(2),
				'closeWhenClicked', true
			)
			
			Dewdrop:AddLine()
			
			Dewdrop:FeedAceOptionsTable(optionsTable)
			
			Dewdrop:AddLine(
				'text', CLOSE,
				'arg1', Dewdrop,
				'func', "Close"
			)
		elseif Dewdrop:FeedAceOptionsTable(optionsTable) then
		elseif level == 2 then
			if value == "attach" then
				Dewdrop:AddLine(
					'text', L["Attach to top"],
					'arg1', panel,
					'func', panel:GetAttachPoint() ~= "TOP" and "SetAttachPoint",
					'arg2', "TOP",
					'checked', panel:GetAttachPoint() == "TOP",
					'closeWhenClicked', true,
					'isRadio', true
				)
				
				Dewdrop:AddLine(
					'text', L["Attach to bottom"],
					'arg1', panel,
					'func', panel:GetAttachPoint() ~= "BOTTOM" and "SetAttachPoint",
					'arg2', "BOTTOM",
					'checked', panel:GetAttachPoint() == "BOTTOM",
					'closeWhenClicked', true,
					'isRadio', true
				)
				
				Dewdrop:AddLine(
					'text', L["Detach panel"],
					'arg1', panel,
					'func', panel:GetAttachPoint() ~= "NONE" and "SetAttachPoint",
					'arg2', "NONE",
					'checked', panel:GetAttachPoint() == "NONE",
					'closeWhenClicked', true,
					'isRadio', true
				)
			else
				for _,plugin in ipairs(plugins) do
					local category = plugin:GetCategory()
					if not CATEGORIES[category] then
						category = L["Others"]
					end
					if category == value then
						Dewdrop:AddLine(
							'text', plugin:GetTitle(),
							'arg1', plugin,
							'func', plugin:GetPanel() and "Hide" or "Show",
							'arg2', FuBar_Panel.selectedPanel or 1,
							'checked', plugin:GetPanel()
						)
					end
				end
				for i,name in ipairs(toBeLoaded) do
					local i, name = i, name
					local lod = self.db.profile.loadOnDemand[name]
					
					local category = lod.category
					if not CATEGORIES[category] then
						category = L["Others"]
					end
					if category == value then
						Dewdrop:AddLine(
							'text', lod.title,
							'arg1', self,
							'func', "LoadPlugin",
							'arg2', name
						)
					end
				end
			end
		end
	end
	
	self:ScheduleEvent(self.LoadLoadOnDemandPlugins, 0, self)
	
	CleanDB()
end

function FuBar:LoadPlugin(name)
	if not alreadyEnabled then
		local dep1,dep2,dep3,dep4 = GetAddOnDependencies(name)
		if dep1 == "Ace" or dep2 == "Ace" or dep3 == "Ace" or dep4 == "Ace" then
			if not self.acePluginToLoad then
				self.acePluginToLoad = {}
			end
			self.acePluginToLoad[name] = true
			return
		end
	end
	local loaded, plugin, dependencies = LoadAddOnWrapper(name)
	if loaded then
		if type(plugin.SetLoadOnDemand) == "function" then
			plugin:SetLoadOnDemand(true)
		end
		self.db.profile.loadOnDemand[name] = {
			title = plugin:GetTitle(),
			category = plugin:GetCategory(),
			disabled = nil,
			condition = type(plugin.GetLoadCondition) == "function" and plugin:GetLoadCondition() or nil,
		}
		plugin:Show(FuBar_Panel.selectedPanel or false)
		if dependencies then
			for _,v in ipairs(dependencies) do
				if type(v.SetLoadOnDemand) == "function" then
					v:SetLoadOnDemand(true)
				end
				self.db.profile.loadOnDemand[name].disabled = nil
				for j,u in ipairs(toBeLoaded) do
					if u == v:GetTitle() then
						table.remove(toBeLoaded, j)
						break
					end
				end
				if v.hideWithoutStandby then
					v:EnableApp()
				else
					v:Show(panelId or false)
				end
			end
		end
		self:SetFontSize(self:GetFontSize())
		for i,n in ipairs(toBeLoaded) do
			if n == name then
				table.remove(toBeLoaded, i)
				break
			end
		end
		self.db.profile.loadOnDemand[name].disabled = nil
	end
end

function FuBar:OnEnable()
	if alreadyEnabled then
		ReloadUI()
		return
	end
	alreadyEnabled = true
	
	if AceLibrary:HasInstance("Tablet-2.0") then
		Tablet = AceLibrary("Tablet-2.0")
	end
	if not self.db.profile.panels then
		self.db.profile.panels = {}
	end
	
	if not self.db.profile.minimap then
		self.db.profile.minimap = {}
	end
	
	for i = table.getn(self.db.profile.panels), 1, -1 do
		if self.db.profile.panels[i] then
			FuBar_Panel:new()
		end
	end
	
	self:CheckResolution()
	
	if self:GetNumPanels() == 0 then
		FuBar_Panel:new()
	end
	
	if FuBar.db.profile.skin then
		SetBackground(FuBar.db.profile.skin)
	end
	
	self:RegisterEvent("AceLibrary_Register")
--	self:RegisterEvent("DISPLAY_SIZE_CHANGED", "OnDisplaySizeChanged")
	self:RegisterEvent("CVAR_UPDATE", "OnCVarUpdate")
	
	self:Hook("RestartGx")
	
	local function func()
		if not self:SetupPlugins() then
			self:ScheduleEvent(func, 0)
			return
		end
		self:Update()
		
		self:ScheduleEvent("FuBar_AutoHideTop", self.OnUpdate_AutoHideTop, 1, self)
		self:ScheduleEvent("FuBar_AutoHideBottom", self.OnUpdate_AutoHideBottom, 1, self)
	end
	self:RegisterEvent("AceEvent_FullyInitialized", func, true)
	
	self:UpdateJostleAdjustments()
	
	if self.db.profile.skin and backgrounds[self.db.profile.skin] then
		FuBar_Panel:SetBackground(self.db.profile.skin)
	end
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "PLAYER_ENTERING_WORLD", true)
end

function FuBar:LoadLoadOnDemandPlugins()
	for i = 1, GetNumAddOns() do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
		if IsAddOnLoadOnDemand(i) and enabled and loadable and not IsAddOnLoaded(i) then
			local deps = Compost:Acquire(GetAddOnDependencies(name))
			local good = false
			for _,dep in ipairs(deps) do
				if dep == "FuBar" then
					good = true
					break
				end
			end
			if good then
				if not self.db.profile.loadOnDemand[name] then
					self:LoadPlugin(name)
				elseif not self.db.profile.loadOnDemand[name].disabled and (not self.db.profile.loadOnDemand[name].condition or CheckLoadCondition(self.db.profile.loadOnDemand[name].condition)) then
					self:LoadPlugin(name)
				else
					table.insert(toBeLoaded, name)
				end
			end
			Compost:Reclaim(deps)
		end
	end
end

function FuBar:AceLibrary_Register(major, instance)
	if major == "Tablet-2.0" then
		Tablet = instance
	end
end

function FuBar:PLAYER_ENTERING_WORLD()
	if self.acePluginToLoad then
		for name in pairs(self.acePluginToLoad) do
			self:LoadPlugin(name)
		end
		Compost:Reclaim(self.acePluginToLoad)
		self.acePluginToLoad = nil
	end
end

function FuBar:RestartGx()
	self.hooks.RestartGx.orig()
	self:ScheduleEvent(self.Update, 0, self)
end

function FuBar:OnCVarUpdate()
	if arg1 == "USE_UISCALE" then
		self:ScheduleEvent(self.CheckResolution, 0, self)
	end
end

local lastScreenWidth = GetScreenWidth()
function FuBar:CheckResolution()
	local screenWidth = GetScreenWidth()
	if lastScreenWidth ~= screenWidth then
		for i = 1, self:GetNumPanels() do
			self:GetPanel(i):Update()
		end
		lastScreenWidth = screenWidth
		Jostle:Refresh()
	end
end

local inTopPanel, inBottomPanel

function FuBar:OnUpdate_AutoHideTop()
	if not inTopPanel and self:IsAutoHidingTop() then
		for i = 1, self:GetNumPanels() do
			if self:GetPanel(i):GetAttachPoint() == "TOP" then
				local frame = getglobal("FuBarFrame" .. i)
				frame:SetAlpha(0)
				frame:SetFrameStrata("BACKGROUND")
			end
		end
	end
end

function FuBar:OnUpdate_AutoHideBottom()
	if not inBottomPanel and self:IsAutoHidingBottom() then
		for i = 1, self:GetNumPanels() do
			if self:GetPanel(i):GetAttachPoint() == "BOTTOM" then
				local frame = getglobal("FuBarFrame" .. i)
				frame:SetAlpha(0)
				frame:SetFrameStrata("BACKGROUND")
			end
		end
	end
end

local doneSetupPlugins, pluginsToSetup

function FuBar:OnDisable()
	for i = 1, self:GetNumPanels() do
		self:GetPanel(i).frame:Hide()
	end
end

function FuBar:Report()
	local report = Compost:Acquire(
		Compost:AcquireHash(
			'text', self.loc.ARGUMENT_ADJUST,
			'val', self:IsAdjust() and 1 or 0,
			'map', self.loc.MAP_ONOFF
		)
	)
	self.cmd:report(report)
	Compost:Reclaim(report, 1)
end

function FuBar:GetNumPlugins()
	return table.getn(plugins)
end

function FuBar:GetPlugin(i)
	return plugins[i]
end

function FuBar:RegisterPlugin(plugin)
	if not IsCorrectPlugin(plugin) then
		return
	end
	table.insert(plugins, plugin)
	
	local frame = plugin:GetFrame()
	local downTime
	if frame:HasScript("OnClick") then
		local OnClick = frame:GetScript("OnClick")
		frame:SetScript("OnClick", function()
			if OnClick and (not downTime or GetTime() < downTime + 0.5) and (not this.stopClick or GetTime() > this.stopClick) then
				OnClick()
			end
			downTime = nil
		end)
	end
	local OnMouseDown = frame:GetScript("OnMouseDown")
	frame:SetScript("OnMouseDown", function()
		if arg1 == "LeftButton" and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown() then
			downTime = GetTime()
			FuBar:Plugin_StartDrag(plugin)
		end
		if OnMouseDown then
			OnMouseDown()
		end
	end)
	local OnMouseUp = frame:GetScript("OnMouseUp")
	frame:SetScript("OnMouseUp", function()
		if arg1 == "LeftButton" then
			if not FuBar:Plugin_StopDrag(plugin) then
				if OnMouseUp then
					OnMouseUp()
				end
			else
				this.stopClick = GetTime() + 0.05
			end
		elseif OnMouseUp then
			OnMouseUp()
		end
	end)
	local OnEnter = frame:GetScript("OnEnter")
	frame:SetScript("OnEnter", function()
		FuBar:Panel_OnEnter(plugin)
		if OnEnter then
			OnEnter()
		end
	end)
	local OnLeave = frame:GetScript("OnLeave")
	frame:SetScript("OnLeave", function()
		FuBar:Panel_OnLeave(this.plugin)
		if OnLeave then
			OnLeave()
		end
	end)
end

function FuBar:Update()
	for panelId = 1, self:GetNumPanels() do
		self:GetPanel(panelId):Update()
	end
end

function FuBar:SetupPlugins()
	doneSetupPlugins = true
	if pluginsToSetup then
		for i = 1, self:GetNumPanels() do
			local panel = self:GetPanel(i)
			for h = 1, 3 do
				local side
				if h == 1 then
					side = "LEFT"
				elseif h == 2 then
					side = "CENTER"
				else
					side = "RIGHT"
				end
				local order = panel:GetSavedOrder(side)
				for _,name in ipairs(order) do
					for plugin in pairs(pluginsToSetup) do
						if not plugin:IsDisabled() and plugin:GetTitle() == name then
							if not panel:AddPlugin(plugin, nil, side) then
								doneSetupPlugins = false
								return
							end
							pluginsToSetup[plugin] = nil
							break
						end
					end
				end
			end
		end
		
		local order = self.db.profile.detached
		if order then
			for name in pairs(order) do
				for plugin in pairs(pluginsToSetup) do
					if not plugin:IsDisabled() and plugin:GetTitle() == name then
						pluginsToSetup[plugin] = nil
						plugin:Show(0)
						break
					end
				end
			end
		else
			self.db.profile.detached = {}
		end
		
		for plugin in pairs(pluginsToSetup) do
			if type(plugin.GetDefaultPosition) == "function" and plugin:GetDefaultPosition() == "MINIMAP" then
				plugin:Show(0)
			else
				self.lastPanelId = (self.lastPanelId or 0) + 1
				if self.lastPanelId > self:GetNumPanels() then
					self.lastPanelId = 1
				end
				self:GetPanel(self.lastPanelId):AddPlugin(plugin, nil, type(plugin.GetDefaultPosition) == "function" and plugin:GetDefaultPosition() or "LEFT", true)
			end
		end
		
		pluginsToSetup = nil
	end
	return true
end

function FuBar:ShowPlugin(plugin, panelId)
	if doneSetupPlugins then
		if not panelId then
			doneSetupPlugins = false
			pluginsToSetup = Compost:Acquire()
			pluginsToSetup[plugin] = true
			local function func()
				if not self:SetupPlugins() then
					self:ScheduleEvent(func, 0)
					return
				end
				self:Update()
			end
			func()
		else
			self:GetPanel(panelId):AddPlugin(plugin, nil, type(plugin.GetDefaultPosition) == "function" and plugin:GetDefaultPosition() or "LEFT", true)
		end
	else
		if not pluginsToSetup then
			pluginsToSetup = {}
		end
		pluginsToSetup[plugin] = true
	end
end

local previousPosition_panel, previousPosition_index, previousPosition_side, previousPosition_x, previousPosition_y

function FuBar:Plugin_StartDrag(plugin)
	local panel = plugin:GetPanel()
	assert(panel, plugin:GetTitle() .. ": You must be attached to a panel.")
	self:Panel_OnLeave()
	local index, side = panel:IndexOfPlugin(plugin)
	
	if index then
		if not panel:IsLocked() then
			if index < panel:GetNumPlugins(side) then
				local frame = panel:GetPlugin(index + 1, side).frame
				local x, y = frame:GetLeft(), frame:GetBottom()
				frame:ClearAllPoints()
				frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x, y)
			end
			
			previousPosition_panel = panel
			previousPosition_index = index
			previousPosition_side = side
			previousPosition_x, previousPosition_y = self:GetScaledCursorPosition()
			
			FuBar_Panel:PreventUpdate()
			panel:RemovePlugin(index, side)
			plugin:GetFrame():StartMoving()
		end
	end
end

function FuBar:Plugin_StopDrag(plugin)
	plugin:GetFrame():StopMovingOrSizing()
	if previousPosition_panel and not previousPosition_panel:IsLocked() then
		local insertAt
		local panel = previousPosition_panel
		local side = previousPosition_side
		local x, y = self:GetScaledCursorPosition()
		local px, py = previousPosition_x, previousPosition_y

		for panelId = 1, self:GetNumPanels() do
			local p = self:GetPanel(panelId)
			local frame = p.frame
			local x1, x2, y1, y2 = frame:GetLeft(), frame:GetRight(), frame:GetBottom(), frame:GetTop()
			if x1 <= x and x <= x2 and y1 <= y and y <= y2 then
				panel = p
				break
			end
		end
		
		if panel:GetNumPlugins(side) == 0 then
			insertAt = 1
		else
			for i = 1, panel:GetNumPlugins(side) + 1 do
				local left, right
				local leftPlugin
				local rightPlugin
				
				leftPlugin = panel:GetPlugin(i - 1, side)
				rightPlugin = panel:GetPlugin(i, side)
				
				if side == "RIGHT" then
					leftPlugin, rightPlugin = rightPlugin, leftPlugin
				end
				left = leftPlugin and leftPlugin:GetFrame():GetCenter() or 0
				right = rightPlugin and rightPlugin:GetFrame():GetCenter() or GetScreenWidth()
				if left <= x and x <= right then
					insertAt = i
					break
				end
			end
		end
		if not insertAt then
			insertAt = panel:GetNumPlugins(side) + 1
		end
		
		panel:AddPlugin(plugin, insertAt, side)
		FuBar_Panel:StopPreventUpdate()
		previousPosition_panel:Update()
		panel:Update()
		previousPosition_panel = nil
		previousPosition_index = nil
		previousPosition_side = nil
		previousPosition_x = nil
		previousPosition_y = nil
		if math.abs(px - x) <= 5 and math.abs(py - y) <= 5 then
			return false
		else
			return true
		end
	end
end

function FuBar:Panel_OnEnter(plugin)
	local point = plugin
	if type(plugin) == "table" then
		point = plugin:GetPanel():GetAttachPoint()
	end
	if point == "TOP" then
		inTopPanel = true
		self:CancelScheduledEvent("FuBar_AutoHideTop")
	elseif point == "BOTTOM" then
		inBottomPanel = true
		self:CancelScheduledEvent("FuBar_AutoHideBottom")
	end
	for i = 1, self:GetNumPanels() do
		local panel = self:GetPanel(i)
		if panel:GetAttachPoint() == point then
			panel.frame:SetAlpha(1)
			panel.frame:SetFrameStrata("HIGH")
		end
	end
end

function FuBar:Panel_OnLeave(plugin)
	local point = plugin
	if type(plugin) == "table" then
		if not plugin:GetPanel() then
			return
		end
		point = plugin:GetPanel():GetAttachPoint()
	end
	if point == "TOP" then
		inTopPanel = false
		self:ScheduleEvent("FuBar_AutoHideTop", self.OnUpdate_AutoHideTop, 1, self)
	elseif point == "BOTTOM" then
		inBottomPanel = false
		self:ScheduleEvent("FuBar_AutoHideBottom", self.OnUpdate_AutoHideBottom, 1, self)
	end
end

function FuBar:OnProfileEnable(oldName, _, copyFrom)
	isChangingProfile = true
	if not next(FuBar.db.profile) then
		local def
		local profile = self:GetProfile()
		if string.find(profile, "^char/") or string.find(profile, "^class/") then
			local _,class = UnitClass("player")
			def = _G["FUBAR_DEFAULTS_" .. class] or FUBAR_DEFAULTS
		else
			def = FUBAR_DEFAULTS
		end
		if type(def) == "function" then
			def = def()
		end
		for k,v in pairs(def) do
			FuBar.db.profile[k] = v
		end
	end
	
	if not self.db.profile.loadOnDemand then
		self.db.profile.loadOnDemand = {}
	end
	
	if not self.db.profile.tooltip then
		self.db.profile.tooltip = {}
	end
	
	if not self.db.profile.panels then
		self.db.profile.panels = {}
	end
	
	CleanDB()
	
	doneSetupPlugins = false
	pluginsToSetup = {}
	for i,plugin in ipairs(plugins) do
		pluginsToSetup[plugin] = true
		local frame = plugin:GetFrame()
		frame:Hide()
		frame:ClearAllPoints()
		plugin:SetPanel(nil)
	end
	
	for i = self:GetNumPanels(), 1, -1 do
		self:GetPanel(i):del(true)
	end
	
	for i = table.getn(self.db.profile.panels), 1, -1 do
		if self.db.profile.panels[i] then
			FuBar_Panel:new()
		end
	end
	
	if self:GetNumPanels() == 0 then
		FuBar_Panel:new()
	end
	
	self:CheckResolution()
	
	for i = 1, GetNumAddOns() do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
		if IsAddOnLoadOnDemand(i) and enabled and loadable and not IsAddOnLoaded(i) then
			local good = false
			for _,dep in ipairs({GetAddOnDependencies(name)}) do
				if dep == "FuBar" then
					good = true
				end
			end
			if good then
				if not self.db.profile.loadOnDemand[name] then
					self:LoadPlugin(name)
				elseif not self.db.profile.loadOnDemand[name].disabled and (not self.db.profile.loadOnDemand[name].condition or CheckLoadCondition(self.db.profile.loadOnDemand[name].condition)) then
					self:LoadPlugin(name)
				else
					local exists = false
					for _,n in ipairs(toBeLoaded) do
						if n == name then
							exists = true
							break
						end
					end
					if not exists then
						table.insert(toBeLoaded, name)
					end
				end
			end
		end
	end
	
	for i,plugin in ipairs(plugins) do
		if plugin.IsDisabled and plugin:IsDisabled() and plugin:GetPanel() then
			plugin:GetPanel():RemovePlugin(plugin)
		end
	end
	
	local name = self:GetProfile()
	for _,plugin in ipairs(plugins) do
		if type(plugin.SetProfile) == "function" and not plugin.independentProfile then
			plugin:SetProfile(name, copyFrom)
		end
	end
	
	self:SetFontSize(self:GetFontSize())
	
	local function func()
		if not self:SetupPlugins() then
			self:ScheduleEvent(func, 0)
			return
		end
		self:Update()
	end
	self:ScheduleEvent(func, 0.01)
	
	isChangingProfile = false
end

