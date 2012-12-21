-- AddonMenu (Satrina@Stormrage)
-- An embedded library to support addon configuration menus in the SELF menu
-- See AddonMenu.txt for usage

local version = 1.5

if not AddonMenu or (AddonMenu.version < version) then

	local prevAddonMenu = AddonMenu
	
	AddonMenu = {
		version = version,
		debug = nil,
		
		--------------------
		-- User functions --
		--------------------
	
		--
		-- AddMenuItem
		-- Add text as a menu option to the addon menu callback will be invoked when the user selects it
		--
		AddMenuItem = function(self, name, callbackFunc, submenu)
			self:Init()
			if not submenu then 
				table.insert(UnitPopupMenus["ADDON_MENU"], 1, name)
			else
				if not UnitPopupMenus[submenu] then
					if self.debug then
						ChatFrame1:AddMessage("AddMenuItem: Adding submenu |cff00ff00"..submenu.."|r")
					end
					table.insert(UnitPopupMenus["ADDON_MENU"], 1, submenu)
					UnitPopupButtons[submenu] = { text = TEXT(submenu), dist = 0, nested = 1 }
					UnitPopupMenus[submenu] = { "CANCEL" }
				end
				table.insert(UnitPopupMenus[submenu], 1, name)
			end
			if self.debug then
				ChatFrame1:AddMessage("AddMenuItem: Adding menu item |cff00ff00"..name.."|r")
			end
			UnitPopupButtons[name] = { text = TEXT(name), dist = 0 }
			self:InsertCallback(name, callbackFunc)
		end,
	
		-------------------------------------------
		-- Users should not call these functions --
		-------------------------------------------
	
		--
		-- AddonMenuName
		-- Return the localised text for the addon menu name
		--
		AddonMenuName = function(self)
			-- if (GetLocale() == "deDE") then
			--	return "GermanText"
			-- elseif (GetLocale() == "frFR") then
			-- 	return "FrenchText"
			-- else
			return "Addons"
			-- end
		end,
		
		--
		-- InsertCallback
		-- Insert a callback into the hook table
		--
		InsertCallback = function(self, item, callbackFunc)
			for index,entry in pairs(self.callbacks) do
				if entry.name == item then
					return
				end
			end
			table.insert(self.callbacks, {name = item, func = callbackFunc})
		end,
		
		--
		-- UnitPopup_OnClick
		-- If the menu item clicked is in the hook table, call its callback
		-- Otherwise call the global UnitPopup_OnClick
		--
		UnitPopup_OnClick = function()
			for index,entry in AddonMenu.callbacks do
				if (this.value == entry.name) then
					entry.func()
					return
				end
			end
			AddonMenu.unitPopupOnClick()
		end,

		-- 
		-- UnitPopup_ShowMenu
		-- Override the original function with a copy of itself, making two small changes to support a third level of nesting.
		-- Very ugly.
		-- Unless we're in the self menu and above the first level of nesting, though, just passthrough
		-- 
		UnitPopup_ShowMenu = function(dropdownMenu, which, unit, name, userData)
			if (UIDROPDOWNMENU_MENU_LEVEL > 1) and (which == "SELF") then
				-- Init variables
				dropdownMenu.which = which;
				dropdownMenu.unit = unit;
				if ( unit and not name ) then
					name = UnitName(unit);
				end
				dropdownMenu.name = name;
				dropdownMenu.userData = userData;
			
				-- Determine which buttons should be shown or hidden
				UnitPopup_HideButtons();
				
				-- If only one menu item (the cancel button) then don't show the menu
				local count = 0;
				for index, value in UnitPopupMenus[which] do
					if( UnitPopupShown[index] == 1 and value ~= "CANCEL" ) then
						count = count + 1;
					end
				end
				if ( count < 1 ) then
					return;
				end
			
				-- Determine which loot method and which loot threshold are selected and set the corresponding buttons to the same text
				dropdownMenu.selectedLootMethod = UnitLootMethod[GetLootMethod()].text;
				UnitPopupButtons["LOOT_METHOD"].text = dropdownMenu.selectedLootMethod;
				UnitPopupButtons["LOOT_METHOD"].tooltipText = UnitLootMethod[GetLootMethod()].tooltipText;
				dropdownMenu.selectedLootThreshold = getglobal("ITEM_QUALITY"..GetLootThreshold().."_DESC");
				UnitPopupButtons["LOOT_THRESHOLD"].text = dropdownMenu.selectedLootThreshold;
				-- This allows player to view loot settings if he's not the leader
				if ( ((GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0)) and IsPartyLeader() ) then
					-- If this is true then player is the party leader
					UnitPopupButtons["LOOT_METHOD"].nested = 1;
					UnitPopupButtons["LOOT_THRESHOLD"].nested = 1;
				else
					UnitPopupButtons["LOOT_METHOD"].nested = nil;
					UnitPopupButtons["LOOT_THRESHOLD"].nested = nil;
				end
			
				-- If level 2 dropdown
				local info;
				local color;
				local icon;
				if ( UIDROPDOWNMENU_MENU_LEVEL > 1 ) then
					dropdownMenu.which = UIDROPDOWNMENU_MENU_VALUE;
					for index, value in UnitPopupMenus[UIDROPDOWNMENU_MENU_VALUE] do
						info = {};
						info.text = UnitPopupButtons[value].text;
						info.owner = UIDROPDOWNMENU_MENU_VALUE;
						-- Set the text color
						color = UnitPopupButtons[value].color;
						if ( color ) then
							info.textR = color.r;
							info.textG = color.g;
							info.textB = color.b;
						end
						-- Icons
						info.icon = UnitPopupButtons[value].icon;
						info.tCoordLeft = UnitPopupButtons[value].tCoordLeft;
						info.tCoordRight = UnitPopupButtons[value].tCoordRight;
						info.tCoordTop = UnitPopupButtons[value].tCoordTop;
						info.tCoordBottom = UnitPopupButtons[value].tCoordBottom;
						-- Checked conditions
						if ( info.text == dropdownMenu.selectedLootMethod  ) then
							info.checked = 1;
						elseif ( info.text == dropdownMenu.selectedLootThreshold ) then
							info.checked = 1;
						elseif ( strsub(value, 1, 12) == "RAID_TARGET_" ) then
							local raidTargetIndex = GetRaidTargetIndex(unit);
							if ( raidTargetIndex == index ) then
								info.checked = 1;
							end
						end
		
						if ( UnitPopupButtons[value].nested ) then
							 info.hasArrow = 1;
						end
						
						info.value = value;
						info.func = UnitPopup_OnClick;
						-- Setup newbie tooltips
						info.tooltipTitle = UnitPopupButtons[value].text;
						info.tooltipText = getglobal("NEWBIE_TOOLTIP_UNIT_"..value);
						UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
					end
					return;			
				end
			
				-- Add dropdown title
				if ( unit or name ) then
					info = {};
					if ( name ) then
						info.text = name;
					else
						info.text = TEXT(UNKNOWN);
					end
					info.isTitle = 1;
					info.notCheckable = 1;
					UIDropDownMenu_AddButton(info);
				end
				
				-- Show the buttons which are used by this menu
				local tooltipText;
				for index, value in UnitPopupMenus[which] do
					if( UnitPopupShown[index] == 1 ) then
						info = {};
						info.text = UnitPopupButtons[value].text;
						info.value = value;
						info.owner = which;
						info.func = UnitPopup_OnClick;
						if ( not UnitPopupButtons[value].checkable ) then
							info.notCheckable = 1;
						end
						-- Text color
						if ( value == "LOOT_THRESHOLD" ) then
							-- Set the text color
							color = ITEM_QUALITY_COLORS[GetLootThreshold()];
							info.textR = color.r;
							info.textG = color.g;
							info.textB = color.b;
						else
							color = UnitPopupButtons[value].color;
							if ( color ) then
								info.textR = color.r;
								info.textG = color.g;
								info.textB = color.b;
							end
						end
						-- Icons
						info.icon = UnitPopupButtons[value].icon;
						info.tCoordLeft = UnitPopupButtons[value].tCoordLeft;
						info.tCoordRight = UnitPopupButtons[value].tCoordRight;
						info.tCoordTop = UnitPopupButtons[value].tCoordTop;
						info.tCoordBottom = UnitPopupButtons[value].tCoordBottom;
						-- Checked conditions
						if ( strsub(value, 1, 12) == "RAID_TARGET_" ) then
							local raidTargetIndex = GetRaidTargetIndex("target");
							if ( raidTargetIndex == index ) then
								info.checked = 1;
							end
						end
						if ( UnitPopupButtons[value].nested ) then
							info.hasArrow = 1;
						end
						
						-- Setup newbie tooltips
						info.tooltipTitle = UnitPopupButtons[value].text;
						tooltipText = getglobal("NEWBIE_TOOLTIP_UNIT_"..value);
						if ( not tooltipText ) then
							tooltipText = UnitPopupButtons[value].tooltipText;
						end
						info.tooltipText = tooltipText;
						UIDropDownMenu_AddButton(info);
					end
				end
				PlaySound("igMainMenuOpen");
			else
				AddonMenu.origShowMenu(dropdownMenu, which, unit, name, userData)
			end
		end,
	
		-- 
		-- Initialisation
		-- 
		Init = function(self)
			if not self.initialised then
				if self.debug then
					ChatFrame1:AddMessage(string.format("AddMenuitem: Initializing version |cff00ff00%.1f|r", self.version))
				end
				if prevAddonMenu then
					if self.debug then
						ChatFrame1:AddMessage(string.format("AddMenuitem: Migrating data from AddonMenu version %.1f", prevAddonMenu.version))
					end
					self.callbacks = prevAddonMenu.callbacks
					self.submenus = prevAddonMenu.submenus
					self.nextSubmenuID = prevAddonMenu.nextSubmenuID
					self.unitPopupOnClick = prevAddonMenu.unitPopupOnClick
					if prevAddonMenu.origShowMenu then
						self.origShowMenu = prevAddonMenu.origShowMenu
					else
						self.origShowMenu = getglobal("UnitPopup_ShowMenu")
					end
					prevAddonMenu = {}
				else
					self.callbacks = {}
					self.submenus = {}
					self.nextSubmenuID = 200
					self.unitPopupOnClick = getglobal("UnitPopup_OnClick")
					self.origShowMenu = getglobal("UnitPopup_ShowMenu")
					UnitPopupButtons["ADDON_MENU"] = { text = self:AddonMenuName(), dist = 0, nested = 1 }
					table.insert(UnitPopupMenus["SELF"], table.getn(UnitPopupMenus["SELF"]), "ADDON_MENU")
					UnitPopupMenus["ADDON_MENU"] = {}
				end
				UnitPopup_OnClick = self.UnitPopup_OnClick
				UnitPopup_ShowMenu = self.UnitPopup_ShowMenu
				self.initialised = true
			end
		end
	}
end