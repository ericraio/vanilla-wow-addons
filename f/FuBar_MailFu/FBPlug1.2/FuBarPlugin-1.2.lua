local MAJOR_VERSION = "1.2"
local MINOR_VERSION = tonumber(string.sub("$Revision: 1962 $", 12, -3))

if FuBarPlugin and FuBarPlugin.versions[MAJOR_VERSION] and FuBarPlugin.versions[MAJOR_VERSION].minor >= MINOR_VERSION and FuBarPlugin.MinimapContainer and FuBarPlugin.MinimapContainer.versions[MAJOR_VERSION] and FuBarPlugin.MinimapContainer.versions[MAJOR_VERSION].minor >= MINOR_VERSION then
	return
end

local loc = {
	ARGUMENT_VISIBLE = "visible",
	ARGUMENT_COLOR = "color",
	ARGUMENT_SHOWICON = "showIcon",
	ARGUMENT_SHOWTEXT = "showText",
	ARGUMENT_PROFILE = "profile",
	
	TEXT_TOGGLE_VISIBILITY = "Toggle Visibility.",
	TEXT_TOGGLE_WHETHER_TO_SHOW_THE_ICON = "Toggle whether to show the icon.",
	TEXT_TOGGLE_WHETHER_TO_SHOW_TEXT = "Toggle whether to show text.",
	TEXT_LIST_PROFILING_INFO = "List profiling information",
	
	MENU_SHOW_ICON = "Show icon",
	MENU_SHOW_TEXT = "Show text",
	MENU_SHOW_COLORED_TEXT = "Show colored text",
	MENU_DETACH_TOOLTIP = "Detach tooltip",
	MENU_LOCK_TOOLTIP = "Lock tooltip",
	MENU_ON_LEFT_SIDE = "On left side",
	MENU_IN_CENTER = "In center",
	MENU_ON_RIGHT_SIDE = "On right side",
	MENU_HIDE = "Hide",
	MENU_DISABLE = "Disable",
	MENU_ABOUT = "About",
	
	MAP_ONOFF = {[0]="|cffff0000Off|r",[1]="|cff00ff00On|r"},
	
	PATTERN_MERGE_WITH_CHILD = "Merge with %s",
	PATTERN_SWITCH_TO_CHILD = "Switch to %s",
}

if GetLocale() == "deDE" then
	loc.TEXT_TOGGLE_VISIBILITY = "Sichtbarkeit umschalten."
	loc.TEXT_TOGGLE_WHETHER_TO_SHOW_THE_ICON = "Iconanzeige umschalten."
	loc.TEXT_TOGGLE_WHETHER_TO_SHOW_TEXT = "Textanzeige umschalten."
	loc.TEXT_LIST_PROFILING_INFO = "Liste Profilinformationen"
	
	loc.MENU_SHOW_ICON = "Zeige Icon"
	loc.MENU_SHOW_TEXT = "Zeige Text"
	loc.MENU_SHOW_COLORED_TEXT = "Farbigen Text anzeigen"
	loc.MENU_DETACH_TOOLTIP = "Tooltip l\195\182sen"
	loc.MENU_LOCK_TOOLTIP = "Tooltip verankern"
	loc.MENU_ON_LEFT_SIDE = "Auf linker Seite anzeigen"
	loc.MENU_IN_CENTER = "In der Mitte anzeigen"
	loc.MENU_ON_RIGHT_SIDE = "Auf rechter Seite anzeigen"
	loc.MENU_HIDE = "Ausblenden"
	loc.MENU_DISABLE = "Deaktivieren"
	loc.MENU_ABOUT = "\195\156ber"
	
	loc.MAP_ONOFF[0] = "|cffff0000Aus|r"
	loc.MAP_ONOFF[1] = "|cff00ff00An|r"
	
	loc.PATTERN_MERGE_WITH_CHILD = "Mit %s verbinden"
	loc.PATTERN_SWITCH_TO_CHILD = "Zu %s wechseln"
	
elseif GetLocale() == "frFR" then
	loc.TEXT_TOGGLE_VISIBILITY = "Bascule la visibilite."
	loc.TEXT_TOGGLE_WHETHER_TO_SHOW_THE_ICON = "Bascule la dissimulation ou l'affichage de l'icone."
	loc.TEXT_TOGGLE_WHETHER_TO_SHOW_TEXT = "Bascule la dissimulation ou l'affichage du text."
--	loc.TEXT_LIST_PROFILING_INFO = "List profiling information" -- CHECK
	
	loc.MENU_SHOW_ICON = "Afficher l'icon"
	loc.MENU_SHOW_TEXT = "Afficher le text"
--	loc.MENU_SHOW_COLORED_TEXT = "Show colored text" -- CHECK
--	loc.MENU_DETACH_TOOLTIP = "Detach tooltip" -- CHECK
--	loc.MENU_LOCK_TOOLTIP = "Lock tooltip" -- CHECK
--	loc.MENU_ON_LEFT_SIDE = "On left side" -- CHECK
--	loc.MENU_IN_CENTER = "In center" -- CHECK
--	loc.MENU_ON_RIGHT_SIDE = "On right side" -- CHECK
	loc.MENU_HIDE = "Dissimule"
	loc.MENU_DISABLE = "Desactive"
	loc.MENU_ABOUT = "A propos"
	
--	loc.MAP_ONOFF[0] = "|cffff0000Off|r" -- CHECK
--	loc.MAP_ONOFF[1] = "|cff00ff00On|r" -- CHECK
	
	loc.PATTERN_MERGE_WITH_CHILD = "Fusione avec %s"
	loc.PATTERN_SWITCH_TO_CHILD = "Echange avec %s"
end

local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')

if FUBAR_REVISION and MINOR_VERSION > FUBAR_REVISION then
	FUBAR_REVISION = MINOR_VERSION
end

-------------IRIEL'S-STUB-CODE--------------
local stub = {};

-- Instance replacement method, replace contents of old with that of new
function stub:ReplaceInstance(old, new)
   for k,v in pairs(old) do old[k]=nil; end
   for k,v in pairs(new) do old[k]=v; end
end

-- Get a new copy of the stub
function stub:NewStub()
  local newStub = {};
  self:ReplaceInstance(newStub, self);
  newStub.lastVersion = '';
  newStub.versions = {};
  return newStub;
end

-- Get instance version
function stub:GetInstance(version)
   if (not version) then version = self.lastVersion; end
   local versionData = self.versions[version];
   if (not versionData) then
      message("Cannot find library instance with version '" 
              .. version .. "'");
      return;
   end
   return versionData.instance;
end

-- Register new instance
function stub:Register(newInstance)
   local version,minor = newInstance:GetLibraryVersion();
   self.lastVersion = version;
   local versionData = self.versions[version];
   if (not versionData) then
      -- This one is new!
      versionData = { instance = newInstance,
         minor = minor,
         old = {} 
      };
      self.versions[version] = versionData;
      newInstance:LibActivate(self);
      return newInstance;
   end
   if (minor <= versionData.minor) then
      -- This one is already obsolete
      if (newInstance.LibDiscard) then
         newInstance:LibDiscard();
      end
      return versionData.instance;
   end
   -- This is an update
   local oldInstance = versionData.instance;
   local oldList = versionData.old;
   versionData.instance = newInstance;
   versionData.minor = minor;
   local skipCopy = newInstance:LibActivate(self, oldInstance, oldList);
   table.insert(oldList, oldInstance);
   if (not skipCopy) then
      for i, old in ipairs(oldList) do
         self:ReplaceInstance(old, newInstance);
      end
   end
   return newInstance;
end

-- Bind stub to global scope if it's not already there
if (not FuBarPlugin) then
   FuBarPlugin = stub:NewStub();
end
if (not FuBarPlugin.MinimapContainer) then
   FuBarPlugin.MinimapContainer = stub:NewStub();
end

-- Nil stub for garbage collection
stub = nil;
-----------END-IRIEL'S-STUB-CODE------------

local RegisterTablet
-- FuBarPlugin
do
	local compost
	if CompostLib then
		compost = CompostLib:GetInstance('compost-1')
	end
	
	local epsilon = 1e-5
	
	local lib = AceAddon:new()
	
	local function VersionToNumber(version)
		if version == nil then
			return 0
		elseif type(version) == "number" then
			return version
		end
		local num = 0
		local place = 1
		string.gsub(version, "(%d+)", function (w)
			num = num + tonumber(w) * math.pow(10, place * 2)
			if place > 0 then
				place = place - 1
			else
				place = place - 2
			end
		end)
		return num
	end
	
	function lib:assert(condition, message)
		if not condition then
			local stack = debugstack()
			local first = string.gsub(stack, "\n.*", "")
			local file = string.gsub(first, "^(.*\\.*)%.lua:%d+: .*", "%1")
			local dir = string.gsub(file, "^(.*)\\.*", "%1")
			if not message then
				local _,_,second = string.find(stack, "\n(.-)\n")
				message = "assertion failed! " .. second
			end
			if self:GetTitle() then
				message = self:GetTitle() .. ": " .. message
			end
			local i = 1
			for s in string.gfind(stack, "\n(.-)\n") do
				i = i + 1
				if not string.find(s, dir .. "\\.*%.lua:%d+:") then
					error(message, i)
					return
				end
			end
			error(message, 2)
			return
		end
		return condition
	end
	
	function lib:GetTitle()
		local _,_,title = string.find(self.name, "FuBar %- (.+)")
		if not title then
			title = self.name
		end
		return title
	end
	
	function lib:DisableHideWithoutStandby()
		self.hideWithoutStandby = false
		if not self._hideWithoutStandbyEnabled then
			return
		end
		self._hideWithoutStandbyEnabled = false
		for index, value in self.cmd.options do
			if value.method == "_ToggleVisible" then
				table.remove(self.cmd.options, index)
				break
			end
		end
		
		self._ToggleVisible = nil
		
		self.Report = self._Report
		self._Report = nil
		
		if self.data.hidden then
			self:DisableAddon()
		end
		self.data.hidden = nil
	end
	
	function lib:EnableHideWithoutStandby()
		self.hideWithoutStandby = true
		if self._hideWithoutStandbyEnabled then 
			return
		end
		self._hideWithoutStandbyEnabled = true
		table.insert(self.cmd.options, {
			option = loc.ARGUMENT_VISIBLE,
			desc = loc.TEXT_TOGGLE_VISIBILITY,
			method = "_ToggleVisible"
		})
		
		function self:_ToggleVisible()
			if self.data.hidden then
				self:Show()
			else
				self:Hide()
			end
			self.cmd:status(loc.ARGUMENT_VISIBLE, not self.data.hidden and 1 or 0, loc.MAP_ONOFF)
		end
		
		if self.Report then
			self._Report = self.Report
			function self:Report()
				self:_Report()
				ace:print(" - ", format(ACE_CMD_REPORT_LINE, loc.ARGUMENT_VISIBLE, loc.MAP_ONOFF[not self.data.hidden and 1 or 0]))
			end
		else
			function self:Report()
				local report = compost and compost:Acquire(
					compost:AcquireHash(
						'text', loc.ARGUMENT_VISIBLE,
						'val', not self.data.hidden and 1 or 0,
						'map', loc.MAP_ONOFF
					)
				) or {{
					text = loc.ARGUMENT_VISIBLE,
					val = not self.data.hidden and 1 or 0,
					map = loc.MAP_ONOFF
				}}
				self.cmd:report(report)
				if compost then
					compost:Reclaim(report, 1)
				end
			end
		end
	end
	
	function lib:IsTextColored()
		if self.data then
			return not self.data.uncolored
		else
			return true
		end
	end
	
	function lib:ToggleMinimapAttached()
		if FuBar then
			local value = self:IsMinimapAttached()
			if value then
				self.panel:RemovePlugin(self)
				FuBar:GetPanel(1):AddPlugin(self, nil, self.defaultPosition)
			else
				self.panel:RemovePlugin(self)
				FuBarPlugin.MinimapContainer:GetInstance(MAJOR_VERSION):AddPlugin(self)
			end
		end
	end
	
	function lib:IsMinimapAttached()
		return self.panel == FuBarPlugin.MinimapContainer:GetInstance(MAJOR_VERSION)
	end
	
	function lib:ToggleTextColored(loud)
		self.data.uncolored = not self.data.uncolored or nil
		if loud then
			self.cmd:status(loc.ARGUMENT_COLOR, not self.data.uncolored and 1 or 0, loc.MAP_ONOFF)
		end
		self:UpdateText()
		return not self.data.uncolored
	end
	
	function lib:Update()
		self:UpdateData()
		self:UpdateText()
		self:UpdateTooltip()
	end
	
	function lib:UpdateDisplay()
		self:UpdateText()
		self:UpdateTooltip()
	end
	
	local function inheritDefaults(t, defaults)
		if not defaults then
			return
		end
		for k,v in pairs(defaults) do
			if type(v) == "table" then
				if type(t[k]) ~= "table" then
					t[k] = {}
				end
				inheritDefaults(t[k], v)
			elseif t[k] == v then
				t[k] = nil
			end
		end
		for k,v in pairs(t) do
			if v == 1 and defaults[k] == true then
				t[k] = nil
			elseif v == true and defaults[k] == 1 then
				t[k] = nil
			end
		end
		setmetatable(t, { __index = defaults })
	end
	
	function lib:_OnAceProfileLoaded()
		if self.db then
			local t = self.db._table
			if not t.profiles then
				t.profiles = {}
			end
			if not t.profiles[self.profilePath[2]] then
				t.profiles[self.profilePath[2]] = {}
			end
			if self.data ~= self.db._table.profiles[self.profilePath[2]] then
				self.data = self.db._table.profiles[self.profilePath[2]]
			else
				return
			end
		elseif FuBar then
			if not FuBarDB.pluginDB[self:GetTitle()] then
				FuBarDB.pluginDB[self:GetTitle()] = {}
			end
			if not FuBarDB.pluginDB[self:GetTitle()].profiles then
				FuBarDB.pluginDB[self:GetTitle()].profiles = {}
			end
			if not FuBarDB.pluginDB[self:GetTitle()].profiles[FuBar.profilePath[2]] then
				FuBarDB.pluginDB[self:GetTitle()].profiles[FuBar.profilePath[2]] = {}
			end
			if self.data ~= FuBarDB.pluginDB[self:GetTitle()].profiles[FuBar.profilePath[2]] then
				self.data = FuBarDB.pluginDB[self:GetTitle()].profiles[FuBar.profilePath[2]]
			else
				return
			end
		end
		inheritDefaults(self.data, self.defaults)
		
		if type(self.ACE_PROFILE_LOADED) == "function" then
			self:ACE_PROFILE_LOADED()
		end
			
		self.data.version = self.version
		
		self:Update()
	end
	
	function lib:Show(panelId)
		if self:IsLoadOnDemand() and FuBar then
			if not FuBar.fullData.loadOnDemand then
				FuBar.fullData.loadOnDemand = {}
			end
			if not FuBar.fullData.loadOnDemand[self.folderName] then
				FuBar.fullData.loadOnDemand[self.folderName] = {}
			end
			FuBar.fullData.loadOnDemand[self.folderName].disabled = nil
		end
		if self.disabled then
			self.panelIdTmp = panelId
			self:EnableAddon()
			self.panelIdTmp = nil
			if not self.db then
				self.data.disabled = nil
			end
		elseif not self.data.hidden then
			if panelId == 0 or not FuBar then
				FuBarPlugin.MinimapContainer:GetInstance('1.2'):AddPlugin(self)
			else
				FuBar:ShowPlugin(self, panelId or self.panelIdTmp)
			end
			self:Update()
		end
	end
	
	function lib:Hide()
		if self.hideWithoutStandby then
			self.data.hidden = true
		end
		if not self.hideWithoutStandby then
			if not self.overrideTooltip and not self.cannotDetachTooltip and self:IsTooltipDetached() and self.data.detachedTooltip.detached then
				self:ReattachTooltip()
				self.data.detachedTooltip.detached = true
			end
			if not self.db then
				self.data.disabled = true
			end
			self:DisableAddon()
			if self:IsLoadOnDemand() and FuBar then
				FuBar.fullData.loadOnDemand[self.folderName].disabled = true
			end
		end
		if self.panel then
			self.panel:RemovePlugin(self)
		end
		self.frame:Hide()
		if self.minimapFrame then
			self.minimapFrame:Hide()
		end
	end
	
	function lib:AddImpliedMenuOptions(level)
		if self.hasIcon and not self.hasNoText then
			dewdrop:AddLine(
				'text', loc.MENU_SHOW_ICON,
				'func', function()
					self:ToggleIconShown()
				end,
				'checked', self:IsIconShown(),
				'level', level
			)
		end
		
		if not self.cannotHideText and self.hasIcon and not self.hasNoText then
			dewdrop:AddLine(
				'text', loc.MENU_SHOW_TEXT,
				'func', function()
					self:ToggleTextShown()
				end,
				'checked', self:IsTextShown(),
				'leve', level
			)
		end
		
		if not self.userDefinedFrame and not self.hasNoText and not self.hasNoColor then
			dewdrop:AddLine(
				'text', loc.MENU_SHOW_COLORED_TEXT,
				'arg1', self,
				'func', "ToggleTextColored",
				'checked', self:IsTextColored(),
				'level', level
			)
		end
		
		if not self.overrideTooltip and not self.cannotDetachTooltip then
			dewdrop:AddLine(
				'text', loc.MENU_DETACH_TOOLTIP,
				'func', function()
					if self:IsTooltipDetached() then
						self:ReattachTooltip()
					else
						self:DetachTooltip()
					end
				end,
				'checked', self:IsTooltipDetached(),
				'level', level
			)
			
			dewdrop:AddLine(
				'text', loc.MENU_LOCK_TOOLTIP,
				'arg1', tablet,
				'func', "ToggleLocked",
				'arg2', self.frame,
				'checked', tablet:IsLocked(self.frame),
				'disabled', not self:IsTooltipDetached(),
				'level', level
			)
		end
		
		if not self:IsMinimapAttached() then
			dewdrop:AddLine(
				'text', loc.MENU_ON_LEFT_SIDE,
				'arg1', self.panel,
				'func', self.panel:GetPluginSide(self) ~= "LEFT" and "SetPluginSide",
				'arg2', self,
				'arg3', "LEFT",
				'checked', self.panel:GetPluginSide(self) == "LEFT",
				'level', level,
				'closeWhenClicked', self.panel:GetPluginSide(self) ~= "LEFT",
				'isRadio', true
			)
			
			dewdrop:AddLine(
				'text', loc.MENU_IN_CENTER,
				'arg1', self.panel,
				'func', self.panel:GetPluginSide(self) ~= "CENTER" and "SetPluginSide",
				'arg2', self,
				'arg3', "CENTER",
				'checked', self.panel:GetPluginSide(self) == "CENTER",
				'level', level,
				'closeWhenClicked', self.panel:GetPluginSide(self) ~= "CENTER",
				'isRadio', true
			)
			
			dewdrop:AddLine(
				'text', loc.MENU_ON_RIGHT_SIDE,
				'arg1', self.panel,
				'func', self.panel:GetPluginSide(self) ~= "RIGHT" and "SetPluginSide",
				'arg2', self,
				'arg3', "RIGHT",
				'checked', self.panel:GetPluginSide(self) == "RIGHT",
				'level', level,
				'closeWhenClicked', self.panel:GetPluginSide(self) ~= "RIGHT",
				'isRadio', true
			)
		end
		
		dewdrop:AddLine(
			'text', "Attach to minimap",
			'arg1', self,
			'func', "ToggleMinimapAttached",
			'checked', self:IsMinimapAttached(),
			'level', level,
			'closeWhenClicked', true
		)
		
		if self.hideWithoutStandby then
			dewdrop:AddLine(
				'text', loc.MENU_HIDE,
				'arg1', self,
				'func', "Hide",
				'level', level,
				'closeWhenClicked', true
			)
		end
		
		dewdrop:AddLine(
			'text', loc.MENU_DISABLE,
			'arg1', self,
			'func', "DisableAddon",
			'level', level,
			'closeWhenClicked', true
		)
		
		dewdrop:AddLine(
			'level', level
		)
		
		dewdrop:AddLine(
			'text', loc.MENU_ABOUT,
			'arg1', self.cmd,
			'func', "DisplayAddonInfo",
			'level', level
		)
	end
	
	function lib:SetIcon(path)
		self:assert(self.hasIcon, "Cannot set icon unless self.hasIcon is set. (" .. self:GetTitle() .. ")")
		if not self.iconFrame then
			return
		end
		if type(path) ~= "string" then
			path = "Interface\\AddOns\\" .. self.folderName .. "\\icon"
		end
		if string.sub(path, 1, 16) == "Interface\\Icons\\" then
			self.iconFrame:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		else
			self.iconFrame:SetTexCoord(0, 1, 0, 1)
		end
		self.iconFrame:SetTexture(path)
		if self.minimapIcon then
			if string.sub(path, 1, 16) == "Interface\\Icons\\" then
				self.minimapIcon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
			else
				self.minimapIcon:SetTexCoord(0, 1, 0, 1)
			end
			self.minimapIcon:SetTexture(path)
		end
	end
	
	function lib:GetIcon()
		if self.hasIcon then
			return self.iconFrame:GetTexture()
		end
	end
	
	function lib:CheckWidth(force)
		if (self.iconFrame and self.iconFrame:IsShown()) or (self.textFrame and self.textFrame:IsShown()) then
			if self.data and not self:IsIconShown() then
				self.iconFrame:SetWidth(epsilon)
			end
			local width
			if not self.hasNoText then
				self.textFrame:SetHeight(0)
				self.textFrame:SetWidth(500)
				width = self.textFrame:GetStringWidth() + 1
				self.textFrame:SetWidth(width)
				self.textFrame:SetHeight(self.textFrame:GetHeight())
			end
			if self.hasNoText or not self.textFrame:IsShown() then
				self.frame:SetWidth(self.iconFrame:GetWidth())
				if self.panel and self.panel:GetPluginSide(self) == "CENTER" then
					self.panel:UpdateCenteredPosition()
				end
			elseif force or not self.textWidth or self.textWidth < width or self.textWidth - 8 > width then
				self.textWidth = width
				self.textFrame:SetWidth(width)
				if self.iconFrame and self.iconFrame:IsShown() then
					self.frame:SetWidth(width + self.iconFrame:GetWidth())
				else
					self.frame:SetWidth(width)
				end
				if self.panel and self.panel:GetPluginSide(self) == "CENTER" then
					self.panel:UpdateCenteredPosition()
				end
			end
		end
	end
	
	function lib:SetText(text)
		if not self.textFrame then
			return
		end
--		self:assert(self.textFrame, "Cannot set text without a textFrame (" .. self:GetTitle() .. ")")
		self:assert(not self.hasNoText, "Cannot set text if self.hasNoText has been set. (" .. self:GetTitle() .. ")")
		self:assert(text, "You must provide a value for text, even if it is blank. (" .. self:GetTitle() .. ")")
		if text == "" then
			if self.hasIcon then
				self:ShowIcon()
			else
				text = self:GetTitle()
			end
		end
		if not self:IsTextColored() then
			text = string.gsub(text, "|c%x%x%x%x%x%x%x%x(.-)|r", "%1")
		end
		self.textFrame:SetText(text)
		self:CheckWidth()
	end
	
	function lib:GetText()
		self:assert(self.textFrame, "Cannot get text without a self.textFrame (" .. self:GetTitle() .. ")")
		if not self.hasNoText then
			return self.textFrame:GetText() or ""
		end
	end
	
	function lib:IsIconShown()
		if not self.hasIcon then
			return false
		elseif self.hasNoText then
			return true
		elseif not self.data then
			return true
		elseif not self.data.showIcon then
			return true
		else
			return (self.data.showIcon == 1 or self.data.showIcon == true) and true or false
		end
	end
	
	function lib:ToggleIconShown(loud)
		self:assert(self.iconFrame, "Cannot toggle icon without a self.iconFrame (" .. self:GetTitle() .. ")")
		self:assert(self.hasIcon, "Cannot show icon unless self.hasIcon is set. (" .. self:GetTitle() .. ")")
		self:assert(not self.hasNoText, "Cannot hide icon if self.hasNoText is set. (" .. self:GetTitle() .. ")")
		self:assert(self.textFrame, "Cannot hide icon if self.textFrame is not set. (" .. self:GetTitle() .. ")")
		self:assert(self.iconFrame, "Cannot hide icon if self.iconFrame is not set. (" .. self:GetTitle() .. ")")
		local value = not self:IsIconShown()
		self.data.showIcon = value and 1 or 0
		if loud then
			self.cmd:status(loc.ARGUMENT_SHOWICON, value and 1 or 0, loc.MAP_ONOFF)
		end
		if value then
			if self.textFrame:IsShown() and self.textFrame:GetText() == self:GetTitle() then
				self.textFrame:Hide()
				self.textFrame:SetText("")
			end
			self.iconFrame:Show()
			self.iconFrame:SetWidth(self.iconFrame:GetHeight())
		else
			if not self.textFrame:IsShown() or not self.textFrame:GetText() then
				self.textFrame:Show()
				self.textFrame:SetText(self:GetTitle())
			end
			self.iconFrame:Hide()
			self.iconFrame:SetWidth(epsilon)
		end
		self:CheckWidth(true)
		return value
	end
	
	function lib:ShowIcon()
		if not self:IsIconShown() then
			self:ToggleIconShown()
		end
	end
	
	function lib:HideIcon()
		if self:IsIconShown() then
			self:ToggleIconShown()
		end
	end
	
	function lib:IsTextShown()
		if not self.hasIcon then
			return false
		elseif self.hasNoText then
			return false
		elseif not self.data then
			return true
		elseif not self.data.showText then
			return true
		else
			return (self.data.showText == 1 or self.data.showText == true) and true or false
		end
	end
	
	function lib:ToggleTextShown(loud)
		self:assert(not self.cannotHideText, "Cannot hide text unless self.cannotHideText is unset. (" .. self:GetTitle() .. ")")
		self:assert(self.hasIcon, "Cannot show text unless self.hasIcon is set. (" .. self:GetTitle() .. ")")
		self:assert(not self.hasNoText, "Cannot hide text if self.hasNoText is set. (" .. self:GetTitle() .. ")")
		self:assert(self.textFrame, "Cannot hide text if self.textFrame is not set. (" .. self:GetTitle() .. ")")
		self:assert(self.iconFrame, "Cannot hide text if self.iconFrame is not set. (" .. self:GetTitle() .. ")")
		local value = not self:IsTextShown()
		self.data.showText = value and 1 or 0
		if loud then
			self.cmd:status(loc.ARGUMENT_SHOWTEXT, value and 1 or 0, loc.MAP_ONOFF)
		end
		if value then
			self.textFrame:Show()
			self:UpdateText()
		else
			self.textFrame:SetText("")
			self.textFrame:SetWidth(epsilon)
			self.textFrame:Hide()
			if not self:IsIconShown() then
				DropDownList1:Hide()
			end
			self:ShowIcon()
		end
		self:CheckWidth(true)
		return value
	end
	
	function lib:ShowText()
		if not self:IsTextShown() then
			self:ToggleTextShown()
		end
	end
	
	function lib:HideText()
		if self:IsTextShown() then
			self:ToggleTextShown()
		end
	end
	
	function lib:OpenChildFrame(child)
		self:assert(child, "Expected frame, received nil. (" .. self:GetTitle() .. ")")
		if FuBarPlugin.lastChildFrame then
			FuBarPlugin.lastChildFrame:Hide()
		end
		FuBarPlugin.lastChildFrame = child
		local frame = self.frame
		local width, height = GetScreenWidth(), GetScreenHeight()
		local anchor
		if frame:GetLeft() <= width/2 then
			anchor = "LEFT"
		else
			anchor = "RIGHT"
		end
		child:ClearAllPoints()
		if frame:GetTop() <= height/2 then
			child:SetPoint("BOTTOM" .. anchor, frame, "TOP" .. anchor)
			local left = child:GetLeft()
			child:ClearAllPoints()
			child:SetPoint("LEFT", UIParent, "LEFT", left, 0)
			child:SetPoint("BOTTOM", frame, "TOP")
		else
			child:SetPoint("TOP" .. anchor, frame, "BOTTOM" .. anchor)
			local left = child:GetLeft()
			child:ClearAllPoints()
			child:SetPoint("LEFT", UIParent, "LEFT", left, 0)
			child:SetPoint("TOP", frame, "BOTTOM")
		end
		child:Show()
	end
	
	local onClickTypes = {"OnClick", "OnDoubleClick", "OnMouseDown", "OnMouseUp"}
	
	function lib:HookIntoPlugin(mother, style)
		if self.hookedPlugin then
			ace:print(self:GetTitle() .. ": Cannot hook into a plugin while already hooked into another.")
			return false
		end
		if not mother or type(mother) ~= "table" or getmetatable(self).__index ~= getmetatable(mother).__index then
			ace:print(self:GetTitle() .. ": Cannot hook into given plugin.")
			return false
		end
		local showTitle = false
		if style then
			local a, b = string.find(style, "_TITLE")
			if a and b then
				showTitle = true
				style = string.sub(style, 1, a - 1) .. string.sub(style, b + 1)
			end
		end
		if style ~= "INLINE" and style ~= "SWITCH" and style ~= "SWITCHTEXT" then
			style = "INLINE"
		end
		local child = self
		local merged = false
		local current = "MOTHER"
		local mother__UpdateTooltip = mother._UpdateTooltip
		local child_UpdateTooltip = child.UpdateTooltip
		local mother_UpdateText = mother.UpdateText
		local child_UpdateText = child.UpdateText
		local child_Show = child.Show
		local mother_funcs = {}
		local mother_MenuSettings = mother.MenuSettings
		local manualStandby = false
		local motherIcon = mother:GetIcon()
		local childIcon = child:GetIcon()
		local merge, unmerge, switch
		switch = function()
			if current == "MOTHER" then
				self.data["switch." .. mother:GetTitle()] = "CHILD"
				current = "CHILD"
				getmetatable(mother).__index.SetIcon(mother, childIcon)
			else
				self.data["switch." .. mother:GetTitle()] = "MOTHER"
				current = "MOTHER"
				getmetatable(mother).__index.SetIcon(mother, motherIcon)
			end
			mother:UpdateText()
			mother:UpdateTooltip()
			dewdrop:Close()
		end
		function self:SwitchPluginHook()
			switch()
		end
		function self:IsCurrentPluginHookSwitch()
			return current ~= "MOTHER"
		end
		merge = function()
			merged = true
			self.data["merge." .. mother:GetTitle()] = 1
			if style == "INLINE" or style == "SWITCHTEXT" then
				function mother:_UpdateTooltip()
					mother__UpdateTooltip(mother)
					if showTitle and not mother:IsTooltipDetached() then
						tablet:AddCategory(
							'text', child:GetTitle(),
							'font', tablet:GetHeaderFontObject(),
							'justify', "CENTER",
							'isTitle', true
						)
					end
					child:_UpdateTooltip()
				end
			elseif style == "SWITCH" then
				function mother:_UpdateTooltip()
					if current == "MOTHER" then
						mother__UpdateTooltip(mother)
					else
						mother.tooltip:SetTitle(child:GetTitle())
						child.tooltip = mother.tooltip
						child:_UpdateTooltip()
					end
				end
			end
			function child:UpdateTooltip()
				mother:UpdateTooltip()
			end
			
			local text
			if style == "INLINE" then
				function mother:SetText(t)
					text = t
				end
				function child:SetText(t)
					if text == "" or not text then
						text = t
					else
						text = text .. " " .. t
					end
				end
			elseif style == "SWITCH" or style == "SWITCHTEXT" then
				function mother:SetText(t)
					if current == "MOTHER" then
						text = t
					end
				end
				function child:SetText(t)
					if current ~= "MOTHER" then
						text = t
					end
				end
			end
			
			if style == "INLINE" then
				function mother:UpdateText()
					text = ""
					if mother_UpdateText then
						mother_UpdateText(mother)
					end
					if child_UpdateText then
						child_UpdateText(child)
					end
					getmetatable(mother).__index.SetText(mother, text)
					text = nil
				end
			elseif style == "SWITCH" or style == "SWITCHTEXT" then
				function mother:UpdateText()
					text = ""
					if current == "MOTHER" and mother_UpdateText then
						mother_UpdateText(mother)
					end
					if current ~= "MOTHER" and child_UpdateText then
						child_UpdateText(child)
					end
					getmetatable(mother).__index.SetText(mother, text)
					text = nil
				end
			end
			child.UpdateText = mother.UpdateText
			
			for _,name in onClickTypes do
				local name = name
				mother_funcs[name] = mother[name]
				local child_func = child[name]
				if style == "INLINE" then
					if mother_funcs[name] and child_func then
						mother[name] = function(self, alpha)
							mother_funcs[name](mother, alpha)
							child_func(child, alpha)
						end
					elseif child_func then
						mother[name] = child_func
					end
				elseif style == "SWITCH" or style == "SWITCHTEXT" then
					if mother_funcs[name] and child_func then
						mother[name] = function(self, alpha)
							if current == "MOTHER" and mother_funcs[name] ~= "nil" then
								mother_funcs[name](mother, alpha)
							elseif current ~= "MOTHER" and child_func then
								child_func(child, alpha)
							end
						end
					elseif child_func then
						mother[name] = function(self, alpha)
							if current ~= "MOTHER" and child_func then
								child_func(child, alpha)
							end
						end
					elseif mother_funcs[name] then
						mother[name] = function(self, alpha)
							if current == "MOTHER" and mother_funcs[name] ~= "nil" then
								mother_funcs[name](mother, alpha)
							end
						end
					end
				end
				if not mother_funcs[name] then
					mother_funcs[name] = "nil"
				end
			end
			
			if style == "SWITCH" or style == "SWITCHTEXT" then
				function mother:SetIcon(path)
					motherIcon = path
					getmetatable(mother).__index.SetIcon(mother, path)
				end
				function child:SetIcon(path)
					childIcon = path
					getmetatable(mother).__index.SetIcon(mother, path)
				end
			end
			
			function child:Show(panelId)
				if panelId and panelId ~= 0 then
					unmerge()
				end
				
				child_Show(self, panelId)
			end
			
			if not child.hideWithoutStandby then
				manualStandby = true
				child:EnableHideWithoutStandby()
			end
			child:Hide()
			
			mother:UpdateText()
			mother:UpdateTooltip()
		end
		unmerge = function()
			merged = false
			self.data["merge." .. mother:GetTitle()] = 0
			mother._UpdateTooltip = mother__UpdateTooltip
			child.UpdateTooltip = child_UpdateTooltip
			mother.SetText = nil
			child.SetText = nil
			mother.SetIcon = nil
			child.SetIcon = nil
			mother.UpdateText = mother_UpdateText
			child.UpdateText = child_UpdateText
			for name,func in pairs(mother_funcs) do
				if func == "nil" then
					mother[name] = nil
				else
					mother[name] = func
				end
			end
			child.Show = child_Show
			if manualStandby then
				child:DisableHideWithoutStandby()
				manualStandby = false
			end
			mother:SetIcon(motherIcon)
			mother:UpdateText()
			mother:UpdateTooltip()
			child:Show()
		end
		
		function mother:MenuSettings(level, value)
			if level == 1 then
				dewdrop:AddLine(
					'text', format(loc.PATTERN_MERGE_WITH_CHILD, child:GetTitle()),
					'func', function()
						if merged then
							unmerge()
						else
							if child.disabled then
								child:EnableAddon()
							end
							merge()
						end
					end,
					'checked', merged,
					'hasArrow', merged and (style == "SWITCH" or style == "SWITCHTEXT"),
					'value', child:GetTitle()
				)
			elseif level == 2 and value == child:GetTitle() then
				dewdrop:AddLine(
					'text', format(loc.PATTERN_SWITCH_TO_CHILD, child:GetTitle()),
					'func', switch,
					'checked', current ~= "MOTHER"
				)
			end
			if merged then
				if (style ~= "SWITCH" or (style == "SWITCH" and current == "MOTHER")) and mother_MenuSettings then
					if level == 1 then
						dewdrop:AddLine()
					end
					mother_MenuSettings(mother, level, value)
				end
				if (style ~= "SWITCH" or (style == "SWITCH" and current == "CHILD")) and child.MenuSettings then
					if level == 1 then
						dewdrop:AddLine()
						dewdrop:AddLine(
							'text', child:GetTitle(),
							'isTitle', true
						)
					end
					child:MenuSettings(level, value)
				end
			else
				if mother_MenuSettings then
					if level == 1 then
						dewdrop:AddLine()
					end
					mother_MenuSettings(mother, level, value)
				end
			end
		end
		if not self.data["merge." .. mother:GetTitle()] then
			self.data["merge." .. mother:GetTitle()] = 1
		end
		if (style == "SWITCH" or style == "SWITCHTEXT") and not self.data["switch." .. mother:GetTitle()] then
			self.data["switch." .. mother:GetTitle()] = "MOTHER"
		end
		if self.data["merge." .. mother:GetTitle()] == 1 then
			merge()
		end
		if style == "SWITCH" or style == "SWITCHTEXT" then
			if self.data["switch." .. mother:GetTitle()] == "MOTHER" then
				self.data["switch." .. mother:GetTitle()] = "CHILD"
			else
				self.data["switch." .. mother:GetTitle()] = "MOTHER"
			end
			current = self.data["switch." .. mother:GetTitle()]
			switch()
		end
		self.hookedPlugin = mother
		return true
	end
	
	function lib:IsTooltipDetached()
		if not tablet.registry[self.frame] then
			self:UpdateTooltip()
		end
		return not tablet:IsAttached(self.frame)
	end
	
	function lib:DetachTooltip()
		tablet:Detach(self.frame)
	end
	
	function lib:ReattachTooltip()
		tablet:Attach(self.frame)
	end
	
	function lib:GetName()
		return self.name
	end
	
	function lib:GetCategory()
		return self.category
	end
	
	function lib:GetFrame()
		return self.frame
	end
	
	function lib:GetPanel()
		return self.panel
	end
	
	function lib:GetDefaultPosition()
		return self.defaultPosition or "LEFT"
	end
	
	local function IsCorrectPanel(panel)
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
	
	function lib:SetPanel(panel)
		if panel then
			self:assert(IsCorrectPanel(panel), "Panel does not have the correct API.")
		end
		self.panel = panel
	end
	
	function lib:SetFontSize(size)
		self:assert(not self.userDefinedFrame, "You must provide a SetFontSize(size) method if you provide your own frame.")
		if self.hasIcon and self.iconFrame then
--			self:assert(self.iconFrame, (self.name and self.name .. ": " or "") .. "No iconFrame found")
			self.iconFrame:SetWidth(size + 3)
			self.iconFrame:SetHeight(size + 3)
		end
		if not self.hasNoText and self.textFrame then
--			self:assert(self.textFrame, (self.name and self.name .. ": " or "") .. "No textFrame found")
			local font, _, flags = self.textFrame:GetFont()
			self.textFrame:SetFont(font, size, flags)
		end
		self:CheckWidth()
	end
	
	function lib:SetLoadOnDemand(lod)
		self._loadOnDemand = lod and true or false
	end
	
	function lib:IsLoadOnDemand()
		return self._loadOnDemand
	end
	
	function lib:IsDisabled()
		return self.disabled
	end
	
	local function cleanDefaults(t, defaults, notFirst)
		if defaults then
			for k,v in pairs(defaults) do
				if type(v) == "table" then
					if type(t[k]) == "table" then
						cleanDefaults(t[k], v, true)
						if next(t[k]) == nil then
							t[k] = nil
						end
					end
				elseif t[k] == v then
					t[k] = nil
				elseif t[k] == true and v == TRUE then
					t[k] = nil
				elseif t[k] == TRUE and v == true then
					t[k] = nil
				end
			end
			for k,v in pairs(t) do
				if v == false and not defaults[k] then
					t[k] = nil
				end
			end
		end
		if not notFirst then
			if next(t) == "version" and next(t, "version") == nil then
				t.version = nil
				return true
			end
		end
		return false
	end
	
	function RegisterTablet(self)
		if not tablet:IsRegistered(self.frame) then
			tablet:Register(self.frame,
				'children', function()
					tablet:SetTitle(self:GetTitle())
					self:_UpdateTooltip()
				end,
				'clickable', self.clickableTooltip,
				'data', FuBar and FuBar.data.tooltip or self.data.detachedTooltip,
				'detachedData', self.data.detachedTooltip,
				'point', function(frame)
					if frame:GetTop() > GetScreenHeight() / 2 then
						local x = frame:GetCenter()
						if x < GetScreenWidth() / 3 then
							return "TOPLEFT", "BOTTOMLEFT"
						elseif x < GetScreenWidth() * 2 / 3 then
							return "TOP", "BOTTOM"
						else
							return "TOPRIGHT", "BOTTOMRIGHT"
						end
					else
						local x = frame:GetCenter()
						if x < GetScreenWidth() / 3 then
							return "BOTTOMLEFT", "TOPLEFT"
						elseif x < GetScreenWidth() * 2 / 3 then
							return "BOTTOM", "TOP"
						else
							return "BOTTOMRIGHT", "TOPRIGHT"
						end
					end
				end,
				'menu', function(level, value, valueN_1, valueN_2, valueN_3, valueN_4)
					self:MenuSettings(level, value, true, valueN_1, valueN_2, valueN_3, valueN_4)
				end
			)
		end
	end
	
	function lib:RegisterForLoad()
		if not self.defaults then
			self.defaults = {}
		end
		if not self.defaults.detachedTooltip then
			self.defaults.detachedTooltip = {}
		end
		
		if not self.cmd then
			local title = string.lower(self:GetTitle())
			self.cmd = AceChatCmd:new({"/" .. string.gsub(title, " ", "_"), "/" .. string.gsub(title, " ", "")}, {})
		end
		
		_,_,self.folderName = string.find(debugstack(2, 1, 0), "\\AddOns\\(.*)\\")
		
		self.versionNumber = FuBarUtils and VersionToNumber(self.version)
		
		if not self.frame then
			local name = "FuBarPlugin" .. self:GetTitle() .. "Frame"
			local frame = getglobal(name)
			if not frame or not getglobal(self.frame:GetName() .. "Text") or not getglobal(self.frame:GetName() .. "Icon") then
				frame = getmetatable(self).__index.CreateBasicPluginFrame(self, name)
				
				local icon = frame:CreateTexture(name .. "Icon", "ARTWORK")
				icon:SetWidth(16)
				icon:SetHeight(16)
				icon:SetPoint("LEFT", frame, "LEFT")
				
				local text = frame:CreateFontString(name .. "Text", "ARTWORK")
				text:SetWidth(134)
				text:SetHeight(24)
				text:SetPoint("LEFT", icon, "RIGHT", 0, 1)
				text:SetFontObject(GameFontNormal)
			end
			self.frame = frame
			self.textFrame = getglobal(self.frame:GetName() .. "Text")
			self.iconFrame = getglobal(self.frame:GetName() .. "Icon")
		else
			self.userDefinedFrame = true
		end
		
		self.frame.plugin = self
		self.frame:SetParent(UIParent)
		self.frame:SetPoint("RIGHT", UIParent, "LEFT", -5, 0)
		self.frame:Hide()
		
		if not self.UpdateData then
			self.UpdateData = function(self) end
		end
		if not self.UpdateText then
			if self.hasNoText then
				self.UpdateText = function(self) end
			else
				self.UpdateText = function(self)
					self:SetText(self:GetTitle())
				end
			end
		end
		if not self.UpdateTooltip then
			self.UpdateTooltip = function(self) end
		end
		
		if self.hasIcon then
			self:SetIcon(self.hasIcon)
			
			if not self.cmd.options then
				self.cmd.options = {}
			end
			
			table.insert(self.cmd.options, {
				option = loc.ARGUMENT_SHOWICON,
				desc = loc.TEXT_TOGGLE_WHETHER_TO_SHOW_THE_ICON,
				method = "ToggleIconShown"
			})
			
			local old_Enable = self.Enable
			function self:Enable()
				if old_Enable then
					old_Enable(self)
				end
				if self:IsIconShown() then
					self.iconFrame:Show()
				else
					self.iconFrame:Hide()
				end
				self:CheckWidth(true)
			end
			
			local old_Report = self.Report
			if old_Report then
				function self:Report()
					old_Report(self)
					ace:print(" - ", format(ACE_CMD_REPORT_LINE, loc.ARGUMENT_SHOWICON, loc.MAP_ONOFF[self:IsIconShown() and 1 or 0]))
				end
			else
				function self:Report()
					local report = compost and compost:Acquire(
						compost:AcquireHash(
							'text', loc.ARGUMENT_SHOWICON,
							'val', self:IsIconShown() and 1 or 0,
							'map', loc.MAP_ONOFF
						)
					) or {{
						text = loc.ARGUMENT_SHOWICON,
						val = self:IsIconShown() and 1 or 0,
						map = loc.MAP_ONOFF
					}}
					self.cmd:report(report)
					if compost then
						compost:Reclaim(report, 1)
					end
				end
			end
		end
		
		if not self.textFrame or not self.hasIcon then
			self.cannotHideText = true
		end
		if not self.cannotHideText then
			table.insert(self.cmd.options, {
				option = loc.ARGUMENT_SHOWTEXT,
				desc = loc.TEXT_TOGGLE_WHETHER_TO_SHOW_TEXT,
				method = "ToggleTextShown"
			})
			
			local old_Enable = self.Enable
			function self:Enable()
				if old_Enable then
					old_Enable(self)
				end
				if self:IsTextShown() then
					self.textFrame:Show()
				else
					self.textFrame:Hide()
				end
				self:CheckWidth(true)
			end
			
			local old_Report = self.Report
			if old_Report then
				function self:Report()
					old_Report(self)
					ace:print(" - ", format(ACE_CMD_REPORT_LINE, loc.ARGUMENT_SHOWTEXT, loc.MAP_ONOFF[self:IsTextShown() and 1 or 0]))
				end
			else
				function self:Report()
					local report = compost and compost:Acquire(
						compost:AcquireHash(
							'text', loc.ARGUMENT_SHOWTEXT,
							'val', self:IsTextShown() and 1 or 0,
							'map', loc.MAP_ONOFF
						)
					) or {{
						text = loc.ARGUMENT_SHOWTEXT,
						val = self:IsTextShown() and 1 or 0,
						map = loc.MAP_ONOFF
					}}
					self.cmd:report(report)
					compost:Reclaim(report, 1)
				end
			end
		end
		
		if self.hideWithoutStandby then
			self:EnableHideWithoutStandby()
		end
		
		local old_Enable = self.Enable
		function self:Enable()
			if old_Enable then
				old_Enable(self)
			end
			if not self.hideWithoutStandby or not self.data.hidden then
				self:Show()
			end
			self:RegisterEvent("ACE_PROFILE_LOADED", "_OnAceProfileLoaded")
			
			if not self.overrideTooltip and not self.cannotDetachTooltip and self.data.detachedTooltip and self.data.detachedTooltip.detached then
				self:DetachTooltip()
			end
		end
		
		if self.db then
			local old_Initialize = self.Initialize
			function self:Initialize()
				local t = self.db._table
				if not t.profiles then
					t.profiles = {}
				end
				if not t.profiles[self.profilePath[2]] then
					t.profiles[self.profilePath[2]] = {}
				end
				
				if not t.realms then
					t.realms = {}
				end
				if not t.realms[GetRealmName() .. UnitFactionGroup("player")] then
					t.realms[GetRealmName() .. UnitFactionGroup("player")] = {}
				end
				if type(self.chardb) ~= "string" then
					if not t.chars then
						t.chars = {}
					end
					if not t.chars[GetRealmName() .. UnitName("player")] then
						t.chars[GetRealmName() .. UnitName("player")] = {}
					end
					self.charData = t.chars[GetRealmName() .. UnitName("player")]
				else
					local c = getglobal(self.chardb)
					if type(c) ~= "table" then
						setglobal(self.chardb, {})
						c = getglobal(self.chardb)
					end
					self.charData = c
				end
				if not t.classes then
					t.classes = {}
				end
				if not t.classes[UnitClass("player")] then
					t.classes[UnitClass("player")] = {}
				end
				if not t.full then
					t.full = {}
				end
				self.data = t.profiles[self.profilePath[2]]
				inheritDefaults(self.data, self.defaults)
				self.realmData = t.realms[GetRealmName() .. UnitFactionGroup("player")]
				inheritDefaults(self.realmData, self.realmDefaults)
				inheritDefaults(self.charData, self.charDefaults)
				self.classData = t.classes[UnitClass("player")]
				inheritDefaults(self.classData, self.classDefaults)
				self.fullData = t.full
				inheritDefaults(self.fullData, self.fullDefaults)
				
				self.data.version = VersionToNumber(self.data.version)
				self.charData.version = VersionToNumber(self.charData.version)
				self.classData.version = VersionToNumber(self.classData.version)
				self.realmData.version = VersionToNumber(self.realmData.version)
				self.fullData.version = VersionToNumber(self.fullData.version)
				if self.data.version >= 500 then
					self.data.version = self.data.version / 100
					self.charData.version = self.charData.version / 100
					self.classData.version = self.classData.version / 100
					self.realmData.version = self.realmData.version / 100
					self.fullData.version = self.fullData.version / 100
				end
				
				if old_Initialize then
					old_Initialize(self)
				end
				
				self.data.version = VersionToNumber(self.version)
				self.charData.version = VersionToNumber(self.version)
				self.classData.version = VersionToNumber(self.version)
				self.realmData.version = VersionToNumber(self.version)
				self.fullData.version = VersionToNumber(self.version)
			end
		elseif FuBar then
			local old_Initialize = self.Initialize
			function self:Initialize()
				if not FuBarDB.pluginDB then
					FuBarDB.pluginDB = {}
				end
				
				if not FuBarDB.pluginDB[self:GetTitle()] then
					FuBarDB.pluginDB[self:GetTitle()] = {}
				end
				
				local t = FuBarDB.pluginDB[self:GetTitle()]
				
				if not t.profiles then
					t.profiles = {}
				end
				if not t.profiles[FuBar.profilePath[2]] then
					t.profiles[FuBar.profilePath[2]] = {}
				end
				if not t.realms then
					t.realms = {}
				end
				if not t.realms[GetRealmName() .. UnitFactionGroup("player")] then
					t.realms[GetRealmName() .. UnitFactionGroup("player")] = {}
				end
				if type(self.chardb) ~= "string" then
					if not t.chars then
						t.chars = {}
					end
					if not t.chars[GetRealmName() .. UnitName("player")] then
						t.chars[GetRealmName() .. UnitName("player")] = {}
					end
					self.charData = t.chars[GetRealmName() .. UnitName("player")]
				else
					local c = getglobal(self.chardb)
					if type(c) ~= "table" then
						setglobal(self.chardb, {})
						c = getglobal(self.chardb)
					end
					self.charData = c
				end
				if not t.classes then
					t.classes = {}
				end
				if not t.classes[UnitClass("player")] then
					t.classes[UnitClass("player")] = {}
				end
				if not t.full then
					t.full = {}
				end
				self.data = t.profiles[FuBar.profilePath[2]]
				inheritDefaults(self.data, self.defaults)
				self.realmData = t.realms[GetRealmName() .. UnitFactionGroup("player")]
				inheritDefaults(self.realmData, self.realmDefaults)
				inheritDefaults(self.charData, self.charDefaults)
				self.classData = t.classes[UnitClass("player")]
				inheritDefaults(self.classData, self.classDefaults)
				self.fullData = t.full
				inheritDefaults(self.fullData, self.fullDefaults)
				
				if old_Initialize then
					old_Initialize(self)
				end
				
				self.data.version = VersionToNumber(self.version)
				self.charData.version = VersionToNumber(self.version)
				self.classData.version = VersionToNumber(self.version)
				self.realmData.version = VersionToNumber(self.version)
				self.fullData.version = VersionToNumber(self.version)
				
				if self.data.disabled then
					self:DisableAddon()
				end
			end
		else
			local old_Initialize = self.Initialize
			function self:Initialize()
				self.data = {}
				self.charData = {}
				self.classData = {}
				self.realmData = {}
				self.fullData = {}
				
				if old_Initialize then
					old_Initialize(self)
				end
				
				self.data.version = VersionToNumber(self.version)
				self.charData.version = VersionToNumber(self.version)
				self.classData.version = VersionToNumber(self.version)
				self.realmData.version = VersionToNumber(self.version)
				self.fullData.version = VersionToNumber(self.version)
			end
		end
		
		local old_Disable = self.Disable
		function self:Disable()
			if old_Disable then
				old_Disable(self)
			end
			self:Hide()
		end
		
		if not self.overrideTooltip then
			self._UpdateTooltip = self.UpdateTooltip
			function self:UpdateTooltip()
				RegisterTablet(self)
				tablet:Refresh(self.frame)
			end
		end
		
		local self_Initialize = self.Initialize
		function self:Initialize()
			self_Initialize(self)
			
			local profilePlugin = FuBar and FuBar:GetPluginProfiling()
			
			if self == profilePlugin then
				local start = GetTime()
				local tree = {}
				local treeMemories = {}
				local treeTimes = {}
				local memories = {}
				local times = {}
				local aname = self.name
				for name,value in pairs(self) do
					if type(value) == "function" and name ~= "Initialize" then
						local oldFunction = value
						local name = name
						local rName = name
						if name == "UpdateTooltip" then
							name = "tablet:Refresh"
						elseif name == "_UpdateTooltip" then
							name = "UpdateTooltip"
						end
						if strsub(name, 1, 1) ~= "_" then
							memories[name] = 0
							times[name] = 0
							self[rName] = function(self, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
								local pos = table.getn(tree)
								table.insert(tree, name)
								table.insert(treeMemories, 0)
								table.insert(treeTimes, 0)
								local t, mem = GetTime(), gcinfo() 
								local r1, r2, r3, r4, r5, r6, r7, r8 = oldFunction(self, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
								mem, t = gcinfo() - mem, GetTime() - t
								if pos > 0 then
									treeMemories[pos] = treeMemories[pos] + mem
									treeTimes[pos] = treeTimes[pos] + t
								end
								local otherMem = table.remove(treeMemories)
								if mem - otherMem > 0 then
									memories[name] = memories[name] + mem - otherMem
								end
								times[name] = times[name] + t - table.remove(treeTimes)
								table.remove(tree)
								return r1, r2, r3, r4, r5, r6, r7, r8
							end
						end
					end
				end
				
				if not self.cmd.options then
					self.cmd.options = {}
				end
				
				table.insert(self.cmd.options, {
					option = loc.ARGUMENT_PROFILE,
					desc = loc.TEXT_LIST_PROFILING_INFO,
					method = "_ListProfileInfo"
				})
				
				function self:_ListProfileInfo()
					local duration = GetTime() - start
					for name in pairs(memories) do
						local mem = memories[name]
						local time = times[name]
						DEFAULT_CHAT_FRAME:AddMessage(string.format("%.3fs / %.3fs (%.3f%%) || %s (%d KiB)", times[name], duration, times[name] / duration * 100, name, memories[name]))
					end
				end
				
				function self:GetProfileInfo()
					return GetTime() - start, times, memories
				end
			end
		end
		
		if self.defaultPosition ~= "LEFT" and self.defaultPosition ~= "CENTER" and self.defaultPosition ~= "RIGHT" and self.defaultPosition ~= "MINIMAP" then
			self.defaultPosition = "LEFT"
		end
		if type(self.defaultMinimapPosition) ~= "number" then
			self.defaultMinimapPosition = math.random(1, 360)
		end
		
		self.frame:RegisterEvent("PLAYER_LOGOUT")
		local OnEvent = self.frame:GetScript("OnEvent")
		self.frame:SetScript("OnEvent", function()
			if OnEvent then
				OnEvent()
			end
			if event == "PLAYER_LOGOUT" then
				local t
				if self.db then
					t = self.db._table
				elseif FuBar then
					t = FuBarDB.pluginDB[self:GetTitle()]
				else
					return
				end
				if cleanDefaults(self.data, self.defaults) then
					if self.db then
						t.profiles[self.profilePath[2]] = nil
					else
						t.profiles[FuBar.profilePath[2]] = nil
					end
					if not next(t.profiles) then
						t.profiles = nil
					end
				end
				if cleanDefaults(self.charData, self.charDefaults) then
					if type(self.chardb) ~= "string" then
						t.chars[ace.char.realm .. ace.char.name] = nil
						if not next(t.chars) then
							t.chars = nil
						end
					else
						setglobal(self.chardb, nil)
					end
				end
				if cleanDefaults(self.fullData, self.fullDefaults) then
					t.full = nil
				end
				if cleanDefaults(self.realmData, self.realmDefaults) then
					t.realms[ace.char.realm .. ace.char.faction] = nil
					if not next(t.realms) then
						t.realms = nil
					end
				end
				if cleanDefaults(self.classData, self.classDefaults) then
					t.classes[ace.char.class] = nil
					if not next(t.classes) then
						t.classes = nil
					end
				end
				if not next(t) then
					if self.db then
						setglobal(self.db.name, nil)
					else
						FuBarDB.pluginDB[self:GetTitle()] = nil
					end
				end
			end
		end)
		
		AceAddon.RegisterForLoad(self)
		if FuBar then
			FuBar:RegisterPlugin(self)
		end
	end
	
	function lib:GetLibraryVersion()
		return MAJOR_VERSION, MINOR_VERSION
	end
	
	function lib:LibActivate(stub, oldLib, oldList)
	end
	
	function lib:LibDeactivate()
	end
	
	function lib:new(o)
		local mt = { __index = self }
		if type(o) ~= "table" then
			o = {}
		end
		return setmetatable(o, mt)
	end
	
	function lib:CreateBasicPluginFrame(name)
		local frame = CreateFrame("Button", name, UIParent)
		frame:SetFrameStrata("HIGH")
		frame:EnableMouse(true)
		frame:EnableMouseWheel(true)
		frame:SetMovable(true)
		frame:SetWidth(150)
		frame:SetHeight(24)
		frame:SetPoint("CENTER", UIParent, "CENTER")
		
		frame:SetScript("OnClick", function()
			if type(self.OnClick) == "function" then
				self:OnClick()
			end
		end)
		frame:SetScript("OnDoubleClick", function()
			if type(self.OnDoubleClick) == "function" then
				self:OnDoubleClick()
			end
		end)
		frame:SetScript("OnMouseDown", function()
			if arg1 == "RightButton" and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown() then
				self:OpenMenu()
				return
			else
				HideDropDownMenu(1)
				if type(self.OnMouseDown) == "function" then
					self:OnMouseDown(arg1)
				end
			end
		end)
		frame:SetScript("OnMouseUp", function()
			if type(self.OnMouseUp) == "function" then
				self:OnMouseUp(arg1)
			end
		end)
		return frame
	end
	
	function lib:CreatePluginChildFrame(frameType, name, parent)
		assert(self.frame, "You must have self.frame declared in order to add child frames")
		local child = CreateFrame(frameType, name, parent)
		if parent then
			child:SetFrameLevel(parent:GetFrameLevel() + 2)
		end
		child:SetScript("OnEnter", function()
			if self.frame:GetScript("OnEnter") then
				self.frame:GetScript("OnEnter")()
			end
		end)
		child:SetScript("OnLeave", function()
			if self.frame:GetScript("OnLeave") then
				self.frame:GetScript("OnLeave")()
			end
		end)
		if child:HasScript("OnClick") then
			child:SetScript("OnClick", function()
				if self.frame:HasScript("OnClick") and self.frame:GetScript("OnClick") then
					self.frame:GetScript("OnClick")()
				end
			end)
		end
		if child:HasScript("OnDoubleClick") then
			child:SetScript("OnDoubleClick", function()
				if self.frame:HasScript("OnDoubleClick") and self.frame:GetScript("OnDoubleClick") then
					self.frame:GetScript("OnDoubleClick")()
				end
			end)
		end
		child:SetScript("OnMouseDown", function()
			if self.frame:GetScript("OnMouseDown") then
				self.frame:GetScript("OnMouseDown")()
			end
		end)
		child:SetScript("OnMouseUp", function()
			if self.frame:GetScript("OnMouseUp") then
				self.frame:GetScript("OnMouseUp")()
			end
		end)
		return child
	end
	
	function lib:OpenMenu(frame)
		if not frame then
			frame = self:GetFrame()
		end
		if dewdrop:IsOpen(frame) then
			dewdrop:Close()
			return
		end
		tablet:Close()
		
		if not dewdrop:IsRegistered(self:GetFrame()) then
			dewdrop:Register(self:GetFrame(),
				'children', function(level, value, valueN_1, valueN_2, valueN_3, valueN_4)
					if level == 1 then
						dewdrop:AddLine(
							'text', self:GetTitle(),
							'isTitle', true
						)
					end
					
					if self.MenuSettings then
						self:MenuSettings(level, value, false, valueN_1, valueN_2, valueN_3, valueN_4)
					end
					
					if level == 1 and not self.overrideMenu then
						if self.MenuSettings then
							dewdrop:AddLine()
						end
						self:AddImpliedMenuOptions()
					end
					if level == 1 then
						dewdrop:AddLine(
							'text', CLOSE,
							'func', dewdrop.Close,
							'arg1', dewdrop
						)
					end
				end,
				'point', function(frame)
					local x, y = frame:GetCenter()
					local leftRight
					if x < GetScreenWidth() / 2 then
						leftRight = "LEFT"
					else
						leftRight = "RIGHT"
					end
					if y < GetScreenHeight() / 2 then
						return "BOTTOM" .. leftRight, "TOP" .. leftRight
					else
						return "TOP" .. leftRight, "BOTTOM" .. leftRight
					end
				end,
				'dontHook', true
			)
		end
		if frame == self:GetFrame() then
			dewdrop:Open(self:GetFrame())
		else
			dewdrop:Open(frame, self:GetFrame())
		end
	end
	
	FuBarPlugin:Register(lib)
	lib = nil
	
	if not FuBarPlugin.new then
		function FuBarPlugin:new(o)
			FuBarPlugin:GetInstance(MAJOR_VERSION):assert(type(o) == "table", "You must provide a table to register")
			local name
			if o.name then
				name = o.name .. ": "
			else
				name = ""
			end
			FuBarPlugin:GetInstance(MAJOR_VERSION):assert(o.fuCompatible, name .. "You must provide a fuCompatible field.")
			local compatNumber = VersionToNumber(o.fuCompatible)
			if compatNumber >= 500 then
				compatNumber = compatNumber / 100
			end
			if compatNumber < 101 then
				return FuBarPlugin:GetInstance("1.0"):new(o)
			elseif compatNumber < 103 then
				return FuBarPlugin:GetInstance("1.2"):new(o)
			end
		end
	end
end

-- MinimapContainer
do
	local lib = {}
	
	local initialized = false
	function lib:Initialize()
		if initialized then
			return
		end
		initialized = true
		
		self.plugins = {}
	end
	
	function lib:AddPlugin(plugin)
		if FuBar and FuBar:IsChangingProfile() then
			return
		end
		self:Initialize()
		if plugin.panel ~= nil then
			plugin.panel:RemovePlugin(plugin)
		end
		plugin.panel = self
		if not plugin.minimapFrame then
			local frame = CreateFrame("Button", plugin.frame:GetName() .. "MinimapButton", Minimap)
			plugin.minimapFrame = frame
			RegisterTablet(plugin)
			tablet:Register(frame, plugin.frame)
			frame.plugin = plugin
			frame:SetWidth(31)
			frame:SetHeight(31)
			frame:SetFrameStrata("HIGH")
			frame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
			local icon = frame:CreateTexture(frame:GetName() .. "Icon", "BACKGROUND")
			plugin.minimapIcon = icon
			local path = plugin:GetIcon() or (plugin.iconFrame and plugin.iconFrame:GetTexture()) or "Interface\\Icons\\INV_Misc_QuestionMark"
			icon:SetTexture(path)
			if string.sub(path, 1, 16) == "Interface\\Icons\\" then
				icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
			else
				icon:SetTexCoord(0, 1, 0, 1)
			end
			icon:SetWidth(20)
			icon:SetHeight(20)
			icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 7, -5)
			local overlay = frame:CreateTexture(frame:GetName() .. "Overlay","OVERLAY")
	overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
			overlay:SetWidth(53)
			overlay:SetHeight(53)
			overlay:SetPoint("TOPLEFT",frame,"TOPLEFT")
			frame:EnableMouse(true)
			frame:RegisterForClicks("LeftButtonUp")
			frame.plugin = plugin
			if type(plugin.OnClick) == "function" then
				frame:SetScript("OnClick", function()
					if not this.dragged then
						plugin:OnClick(arg1)
					end
				end)
			end
			if type(plugin.OnDoubleClick) == "function" then
				frame:SetScript("OnDoubleClick", function()
					plugin:OnDoubleClick(arg1)
				end)
			end
			frame:SetScript("OnMouseDown", function()
				this.dragged = false
				if arg1 == "LeftButton" and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown() then
					HideDropDownMenu(1)
					if type(plugin.OnMouseDown) == "function" then
						plugin:OnMouseDown(arg1)
					end
				elseif arg1 == "RightButton" and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown() then
					plugin:OpenMenu(frame)
				else
					HideDropDownMenu(1)
					if type(plugin.OnMouseDown) == "function" then
						plugin:OnMouseDown(arg1)
					end
				end
				if plugin.OnClick or plugin.OnMouseDown or plugin.OnMouseUp or plugin.OnDoubleClick then
					if string.sub(this.plugin.minimapIcon:GetTexture(), 1, 16) == "Interface\\Icons\\" then
						plugin.minimapIcon:SetTexCoord(0.14, 0.86, 0.14, 0.86)
					else
						plugin.minimapIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					end
				end
			end)
			frame:SetScript("OnMouseUp", function()
				if not this.dragged and type(plugin.OnMouseUp) == "function" then
					plugin:OnMouseUp(arg1)
				end
				if string.sub(this.plugin.minimapIcon:GetTexture(), 1, 16) == "Interface\\Icons\\" then
					plugin.minimapIcon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
				else
					plugin.minimapIcon:SetTexCoord(0, 1, 0, 1)
				end
			end)
			frame:RegisterForDrag("LeftButton")
			frame:SetScript("OnDragStart", self.OnDragStart)
			frame:SetScript("OnDragStop", self.OnDragStop)
		end
		plugin.frame:Hide()
		plugin.minimapFrame:Show()
		self:ReadjustLocation(plugin)
		table.insert(self.plugins, plugin)
		local exists = false
		return true
	end
	
	function lib:RemovePlugin(index)
		if FuBar and FuBar:IsChangingProfile() then
			return
		end
		self:Initialize()
		if type(index) == "table" then
			index = self:IndexOfPlugin(index)
			if not index then
				return
			end
		end
		local t = self.plugins
		local plugin = t[index]
		assert(plugin.panel == self, "Plugin has improper panel field")
		plugin:SetPanel(nil)
		table.remove(t, index)
		return true
	end
	
	function lib:ReadjustLocation(plugin)
		local frame = plugin.minimapFrame
		local position = plugin.data.minimapPosition or plugin.defaultMinimapPosition or math.random(1, 360)
		local angle = math.rad(position or 0)
		local x = math.cos(angle) * 80
		local y = math.sin(angle) * 80
		frame:SetPoint("CENTER", Minimap, "CENTER", x, y)
	end

	function lib:GetPlugin(index)
		return self.plugins[index]
	end
	
	function lib:GetNumPlugins()
		return table.getn(self.plugins)
	end
	
	function lib:IndexOfPlugin(plugin)
		for i,p in ipairs(self.plugins) do
			if p == plugin then
				return i, "MINIMAP"
			end
		end
	end
	
	function lib:HasPlugin(plugin)
		return self:IndexOfPlugin(plugin) ~= nil
	end
	
	function lib:GetPluginSide(plugin)
		local index = self:IndexOfPlugin(plugin)
		assert(index, "Plugin not in panel")
		return "MINIMAP"
	end
	
	function lib.OnDragStart()
		this.dragged = true
		this:LockHighlight()
		this:SetScript("OnUpdate", FuBarPlugin.MinimapContainer:GetInstance(MAJOR_VERSION).OnUpdate)
		if string.sub(this.plugin.minimapIcon:GetTexture(), 1, 16) == "Interface\\Icons\\" then
			this.plugin.minimapIcon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		else
			this.plugin.minimapIcon:SetTexCoord(0, 1, 0, 1)
		end
	end
	
	function lib.OnDragStop()
		this:SetScript("OnUpdate", nil)
		this:UnlockHighlight()
	end
	
	function lib.OnUpdate()
		local mx, my = Minimap:GetCenter()
		local px, py = GetCursorPosition()
		local scale = GetScreenHeight() / 768
		px, py = px * scale, py * scale
		local lastPosition = this.plugin.data.minimapPosition
		local position = math.deg(math.atan2(py - my, px - mx))
		if position <= 0 then
			position = position + 360
		elseif position > 360 then
			position = position - 360
		end
		this.plugin.data.minimapPosition = position
		FuBarPlugin.MinimapContainer:GetInstance(MAJOR_VERSION):ReadjustLocation(this.plugin)
	end
	
	function lib:GetLibraryVersion()
		return MAJOR_VERSION, MINOR_VERSION
	end
	
	function lib:LibActivate(stub, oldLib, oldList)
	end
	
	function lib:LibDeactivate()
	end
	
	FuBarPlugin.MinimapContainer:Register(lib)
	lib = nil
end