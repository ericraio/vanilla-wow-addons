--[[
	Localization
	 	Embeddable addon for selecting a global localization for addons.
	
	By: AnduinLothar
	
	Based on inspiration from Babylonian code by norganna and MentalPower.
	Brought to you without any real xml thanks to Iriel's VirtualFrames.
	
	To use as an embeddable addon:
	- Put the Localization folder inside your Interface/AddOns/<YourAddonName>/ folder.
	- Add Localization\Localization.xml to your toc or load it in your xml before your localization files.
	- Add Localization to the OptionalDeps in your toc
	
	To use as an addon library:
	- Put the Localization folder inside your Interface/AddOns/ folder.
	- Add Localization to the Dependencies in your toc
	
	Note: The AddonName passed to most functions must be identical to the AddonName as returned by arg1 of ADDON_LOADED for Load on Demand addons.
	
	$Id: Localization.lua 3547 2006-05-16 02:35:13Z karlkfi $
	$Rev: 3547 $
	$LastChangedBy: karlkfi $
	$Date: 2006-05-15 19:35:13 -0700 (Mon, 15 May 2006) $
]]--

local LOCALIZATION_NAME 		= "Localization"
local LOCALIZATION_VERSION 		= 0.06
local LOCALIZATION_LAST_UPDATED	= "May 4, 2006"
local LOCALIZATION_AUTHOR 		= "AnduinLothar"
local LOCALIZATION_EMAIL		= "karlkfi@cosmosui.org"
local LOCALIZATION_WEBSITE		= "http://www.wowwiki.com/Localization_Lib"

------------------------------------------------------------------------------
--[[ Embedded Sub-Library Load Algorithm ]]--
------------------------------------------------------------------------------

if (not Localization) then
	Localization = {}
	RegisterCVar("PreferedLocale", "")
	RegisterCVar("RemoveUnusedLocales", 'false')
end
local isBetterInstanceLoaded = ( Localization.version and Localization.version >= LOCALIZATION_VERSION )

if (not isBetterInstanceLoaded) then
	
	------------------------------------------------------------------------------
	--[[ Variables ]]--
	------------------------------------------------------------------------------
	
	Localization.version = LOCALIZATION_VERSION
	Localization.clientLocale = GetLocale()
	if (not Localization.preferedLocale) then
		local pref = GetCVar("PreferedLocale")
		if (pref and pref ~= "") then
			Localization.preferedLocale = pref
		else
			Localization.preferedLocale = Localization.clientLocale
			--Localization.promptForPrefrence = true
		end
	end
	if (not Localization.callbacks) then
		Localization.callbacks = {}
	end
	if (not Localization.localizedStrings) then
		Localization.localizedStrings = {}
	end
	if (not Localization.localizedGlobalStrings) then
		Localization.localizedGlobalStrings = {}
	end
	if (not Localization.protected) then
		Localization.protected = {}
	end
	
	------------------------------------------------------------------------------
	--[[ User Addon Functions ]]--
	------------------------------------------------------------------------------
	
	function Localization.RegisterAddonStrings(locale, addon, stringTable, eraseOrig, protect)
		-- Registers strings with the global database by addon and locale
		-- 'eraseOrig' will remove all previously registered strings for this addon in this locale
		-- 'protect' will not allow this information to be deleted by RemoveUnusedLocales. For internal use only. Used to protect the language selection screen text.
		-- This method is highly prefered over RegisterGlobalAddonStrings so as not to pollute the global namespace.
		if (not locale) then
			DEFAULT_CHAT_FRAME:AddMessage("[Localization] WARNING: locale for RegisterAddonStrings invalid.")
			return
		end
		if (not addon) then
			DEFAULT_CHAT_FRAME:AddMessage("[Localization] WARNING: addon for RegisterAddonStrings invalid.")
		end
		if (not Localization.localizedStrings[locale]) then
			Localization.localizedStrings[locale] = {}
		end
		local lang = Localization.localizedStrings[locale]
		if (eraseOrig or not lang[addon]) then
			lang[addon] = stringTable
		else
			lang = lang[addon]
			for key, text in stringTable do
				lang[key] = text
			end
		end
		
		--protection
		if (not Localization.protected[locale]) then
			Localization.protected[locale] = {}
		end
		if (protect and not Localization.protected[locale][addon]) then
			Localization.protected[locale][addon] = true;
		end
	end
	
	function Localization.RegisterGlobalAddonStrings(locale, addon, stringTable, eraseOrig, protect)
		-- Registers strings with the global database by addon and locale
		-- 'eraseOrig' will remove all previously registered strings for this addon in this locale
		-- 'protect' will not allow this information to be deleted by RemoveUnusedLocales. For internal use only. Used to protect the language selection screen text.
		-- This method may be useful if the strings are called frequently or are used in bindings.
		if (not locale) then
			DEFAULT_CHAT_FRAME:AddMessage("[Localization] WARNING: locale for RegisterGlobalAddonStrings invalid.")
			return
		end
		if (not addon) then
			DEFAULT_CHAT_FRAME:AddMessage("[Localization] WARNING: addon for RegisterGlobalAddonStrings invalid.")
		end
		if (not Localization.localizedGlobalStrings[locale]) then
			Localization.localizedGlobalStrings[locale] = {}
		end
		local lang = Localization.localizedGlobalStrings[locale]
		if (eraseOrig or not lang[addon]) then
			lang[addon] = stringTable
		else
			lang = lang[addon]
			for key, text in stringTable do
				lang[key] = text
			end
		end
		
		--protection
		if (not Localization.protected[locale]) then
			Localization.protected[locale] = {}
		end
		if (protect and not Localization.protected[locale][addon]) then
			Localization.protected[locale][addon] = true;
		end
	end
	
	function Localization.SetAddonDefault(addon, locale)
		-- Sets required Addon default locale.  It should have values for all availible strings.
		if (not Localization.defaults) then
			Localization.defaults = {}
		end
		Localization.defaults[addon] = locale
	end
	
	function Localization.RegisterCallback(key, callback, silent)
		-- Registers optional callback function to update your addon's strings when the prefered locale is changed
		if (not silent) then
			if (not key) then
				DEFAULT_CHAT_FRAME:AddMessage("[Localization] WARNING: key for RegisterCallback invalid.")
				return
			end
			if (not callback) then
				DEFAULT_CHAT_FRAME:AddMessage("[Localization] WARNING: callback for RegisterCallback invalid.")
			end
			if (Localization.callbacks[key]) then
				DEFAULT_CHAT_FRAME:AddMessage("[Localization] WARNING: callback allready exists for key: " .. key)
			end
		end
		Localization.callbacks[key] = callback
	end

	function Localization.GetString(addon, stringKey)
		-- returns the globally prefered localization, else client locale, else addon default
		-- It is recommended you make an addon file local refrence to shorten this call in your code:
		-- local function TEXT(key) return Localization.GetString("YourAddonName", key) end
		local lang;
		if (Localization.preferedLocale) then
			lang = Localization.localizedStrings[Localization.preferedLocale]
			if (lang[addon] and lang[addon][stringKey]) then
				return lang[addon][stringKey]
			elseif (Localization.preferedLocale == "enGB") then
				-- enGB falls back on enUS
				lang = Localization.localizedStrings["enUS"]
				if (lang and lang[addon] and lang[addon][stringKey]) then
					return lang[addon][stringKey]
				end
			end
		end
		lang = Localization.localizedStrings[Localization.clientLocale]
		if (lang[addon] and lang[addon][stringKey]) then
			return lang[addon][stringKey]
		elseif (Localization.clientLocale == "enGB") then
			-- enGB falls back on enUS
			lang = Localization.localizedStrings["enUS"]
			if (lang and lang[addon] and lang[addon][stringKey]) then
				return lang[addon][stringKey]
			end
		end
		
		return Localization.localizedStrings[Localization.defaults[addon]][addon][stringKey]
	end
	
	function Localization.GetClientString(addon, stringKey)
		-- returns the client localization, else addon default
		local lang = Localization.localizedStrings[Localization.clientLocale]
		if (lang[addon] and lang[addon][stringKey]) then
			return lang[addon][stringKey]
		elseif (Localization.clientLocale == "enGB") then
			-- enGB falls back on enUS
			lang = Localization.localizedStrings["enUS"]
			if (lang and lang[addon] and lang[addon][stringKey]) then
				return lang[addon][stringKey]
			end
		end
		
		return Localization.localizedStrings[Localization.defaults[addon]][addon][stringKey]
	end
	
	function Localization.GetSpecificString(language, addon, stringKey)
		if (Localization.localizedStrings[language] and Localization.localizedStrings[language][addon]) then
			return Localization.localizedStrings[language][addon][stringKey]
		end
	end
	
	function Localization.AssignAddonGlobalStrings(addon)
		-- Assigns global values to the keys of the global String database
		-- First choice is prefered localization, else client locale, else addon default
		-- This function must be called in your addon after SetAddonDefault and before the global strings can be used.
		local prefLang = Localization.preferedLocale and Localization.localizedGlobalStrings[Localization.preferedLocale] and Localization.localizedGlobalStrings[Localization.preferedLocale][addon]
		local clientLang = Localization.clientLocale and Localization.localizedGlobalStrings[Localization.clientLocale] and Localization.localizedGlobalStrings[Localization.clientLocale][addon]
		local preferedIsGB = (Localization.preferedLocale == "enGB")
		local enUSLang = Localization.localizedGlobalStrings["enUS"] and Localization.localizedGlobalStrings["enUS"][addon]
		local defaultLang = Localization.localizedGlobalStrings[Localization.defaults[addon]][addon]
		
		for key, text in defaultLang do
			if (prefLang and prefLang[key]) then
				setglobal(key, prefLang[key])
			elseif (preferedIsGB and enUSLang and enUSLang[key]) then
				setglobal(key, enUSLang[key])
			elseif (clientLang and clientLang[key]) then
				setglobal(key, clientLang[key])
			else
				setglobal(key, text)
			end
		end

	end
	
	------------------------------------------------------------------------------
	--[[ Internal Functions ]]--
	------------------------------------------------------------------------------
	
	local function TEXT(key) return Localization.GetString("Localization", key) end
	
	function Localization.SetGlobalPreference(localization)
		if (type(localization) ~= "string") then
			return
		end
		-- Global preference will be used for GetString
		Localization.preferedLocale = localization
		SetCVar("PreferedLocale", localization)
		for key, func in Localization.callbacks do
			func(localization)
		end
	end
	
	function Localization.GetGlobalPreference()
		return GetCVar("PreferedLocale")
	end
	
	function Localization.RemoveUnusedLocales()
		-- Keeps current prefered and client Localizations as well as addon defaults, removes all else from memory
		-- reloadui to get back deleted localized strings
		for locale, addonTable in Localization.localizedStrings do
			if (locale ~= Localization.clientLocale and locale ~= Localization.preferedLocale) then
				local used;
				for addon, default in Localization.defaults do
					if (locale == default or Localization.protected[locale][addon]) then
						used = true
					else
						Localization.localizedStrings[locale][addon] = nil 
					end
				end
				if (not used) then
					Localization.localizedStrings[locale] = nil
				end
			end
		end
	end
	
	function Localization.AssignAllGlobalStrings()
		-- Assigns global values to the keys of the global String database
		-- First choice is prefered localization, else client locale, else addon default
		-- This function is called when the Global preference is updated
		local prefLang = Localization.preferedLocale and Localization.localizedGlobalStrings[Localization.preferedLocale]
		local clientLang = Localization.clientLocale and Localization.localizedGlobalStrings[Localization.clientLocale]
		local preferedIsGB = (Localization.preferedLocale == "enGB")
		local enUSLang = Localization.localizedGlobalStrings["enUS"]
		
		for addon, locale in Localization.defaults do
			local lang = Localization.localizedGlobalStrings[locale]
			if (lang and lang[addon]) then
				-- If there aren't any default global strings for this local or addon, don't bother trying to assign any from other locales
				for key, text in lang[addon] do
					if (prefLang and prefLang[addon] and prefLang[addon][key]) then
						setglobal(key, prefLang[addon][key])
					elseif (preferedIsGB and enUSLang and enUSLang[addon] and enUSLang[addon][key]) then
						setglobal(key, enUSLang[addon][key])
					elseif (clientLang and clientLang[addon] and clientLang[addon][key]) then
						setglobal(key, clientLang[addon][key])
					else
						setglobal(key, text)
					end
				end
			end
		end

	end
	
	------------------------------------------------------------------------------
	--[[ Frame Scripts ]]--
	------------------------------------------------------------------------------
	
	function Localization.Prompt()
		--Show Frame with dropdown asking for prefered language
		LanguageSelectionFrame:Show()
		--Have option checkbox for removing unused languages
		--Select options and then click Confirm/Cancil
		
		--will Khaos need an update?
	end
	
	function Localization.UpdatePrompt()
		LanguageSelectionFrameConfigurationSelectText:SetText(TEXT(Localization.preferedLocale));
		LanguageSelectionFrameText:SetText(TEXT("SelectPreferred"))
		LanguageSelectionFrameCheckBoxText:SetText(TEXT("RemoveUnused"))
		LanguageSelectionFrameLeftButton:SetText(TEXT("Confirm"))
		LanguageSelectionFrameRightButton:SetText(TEXT("Cancel"))
	end
	
	function Localization.OnEvent()
		if (event == "VARIABLES_LOADED" or (Localization.variablesHaveLoaded and event == "ADDON_LOADED")) then
			Localization.variablesHaveLoaded = true
			if (not LanguageSelectionFrame:IsShown()) then
				if (Localization.promptForPrefrence) then
					Localization.Prompt()
				else
					Localization.SetGlobalPreference(Localization.preferedLocale)
					if (GetCVar("RemoveUnusedLocales") == 'true') then
						Localization.RemoveUnusedLocales()
					end
					--[[
					if (arg1) then
						-- ADDON_LOADED passed Addon Name as arg1
						if (Localization.defaults[arg1]) then
							Localization.AssignAllGlobalStrings(arg1)
						end
					else
						Localization.AssignAllGlobalStrings()
					end
					]]--
				end
			end
		end
		if (not Localization.earthButtonLoaded) then
			Localization.earthButtonLoaded = true
			if(EarthFeature_AddButton) then
				EarthFeature_AddButton(
					{
						id = LOCALIZATION_NAME;
						name = function() return TEXT("Localization") end;
						subtext = function() return TEXT("ShowPrompt") end;
						tooltip = function() return TEXT("EarthTooltip") end;
						icon = "Interface\\Icons\\INV_Misc_Book_06";
						callback = Localization.Prompt;
					}
				);
			end
			if(CT_RegisterMod) then
				-- This will only work for whatever language is prefered when it's run.
				-- It would require substantial hacking to force it to update when the locale changes.
				CT_RegisterMod(
					LOCALIZATION_NAME,
					TEXT("ShowPrompt"),
					5,
					"Interface\\Icons\\INV_Misc_Book_06",
					TEXT("EarthTooltip"),
					"on",
					"",
					Localization.Prompt
				);
			end
			if(myAddOnsFrame_Register) then
				myAddOnsFrame_Register(
					{
						name = LOCALIZATION_NAME;
						version = Localization.version;
						releaseDate = LOCALIZATION_LAST_UPDATED;
						author = LOCALIZATION_AUTHOR;
						email = LOCALIZATION_EMAIL;
						website = LOCALIZATION_WEBSITE;
						category = MYADDONS_CATEGORY_OTHERS;
						optionsframe = "LanguageSelectionFrame";
					}
				);
			end
		end
	end
	
	function Localization.SellectionFrame_OnShow()
		if (not Localization.preferedLocale) then
			Localization.SetGlobalPreference(Localization.clientLocale)
		else
			Localization.UpdatePrompt()
		end
		LanguageSelectionFrame.oldLocalePref = Localization.preferedLocale
		LanguageSelectionFrameCheckBox:SetChecked( GetCVar("RemoveUnusedLocales") == 'true' )
	end
	
	function Localization.ConfirmPreference()
		if (LanguageSelectionFrameCheckBox:GetChecked()) then
			SetCVar("RemoveUnusedLocales", 'true')
			Localization.RemoveUnusedLocales()
		else
			SetCVar("RemoveUnusedLocales", 'false')
		end
		this:GetParent():Hide()
	end
	
	function Localization.CancelPreference()
		Localization.SetGlobalPreference(LanguageSelectionFrame.oldLocalePref)
		this:GetParent():Hide()
	end
	
	------------------------------------------------------------------------------
	--[[ Menu Functions ]]--
	------------------------------------------------------------------------------
	
	function Localization.LoadDropDownMenu()
		
		-- Title
		local info = {}
		info.text = TEXT("AvailLangs")
		info.notClickable = 1
		info.isTitle = 1
		UIDropDownMenu_AddButton(info, 1)
		
		-- Client Locale at top
		local info = {}
		info.value = Localization.clientLocale
		info.text = TEXT(info.value)
		if (Localization.preferedLocale == info.value) then
			info.checked = true
		end
		info.func = function()
			Localization.SetGlobalPreference(info.value)
		end
		UIDropDownMenu_AddButton(info, 1)
		
		-- Note that the current menu frame will only allow for 32 objects, 31 locales + title
		for locale, AddonList in Localization.localizedStrings do
			if (locale ~= Localization.clientLocale) then
				local info = {}
				info.value = locale
				info.text = TEXT(info.value)
				if (not Localization.GetSpecificString(info.value, "Localization", info.value)) then
					-- If that local isn't localized inot a language name, use the locale string
					info.text = info.value
				end
				if (Localization.preferedLocale == info.value) then
					info.checked = true
				end
				info.func = function()
					Localization.SetGlobalPreference(info.value)
				end
				UIDropDownMenu_AddButton(info, 1)
			end
		end
		
		-- Set the width of the menu to the size of the dropdown bar
		Localization.SetDropDownWidth(1, 200)
		
		-- nil the displayMode so that the rest of ToggleDropDownMenu doesn't error on the fake frame
		LanguageDropDown.displayMode = nil
	end
	
	function Localization.SetDropDownWidth(id, width)
		local dropdown = getglobal("DropDownList"..id)
		dropdown:SetWidth(width)
		local i = 1
		local button = getglobal("DropDownList"..id.."Button"..i)
		while (button) do
			-- Left is aligned by default, align the right side too.
			button:SetPoint("RIGHT", dropdown, "RIGHT", -10,0)
			i = i + 1
			button = getglobal("DropDownList"..id.."Button"..i)
		end
		dropdown.noResize = 1
	end
	
	function Localization.ShowDropDown()
		LanguageDropDown.displayMode = "MENU"
		ToggleDropDownMenu(1, nil, LanguageDropDown, this:GetName(), 0, 0, "TOPLEFT")
		PlaySound("igMainMenuOptionCheckBoxOn")
	end

	------------------------------------------------------------------------------
	--[[ Frame Templates - Requires Iriel's VirtualFrames package ]]--
	------------------------------------------------------------------------------
	
	local VF = IrielVirtualFrames:GetInstance("KarlPrototype-2-dev")
	
	VF:Register("EarthCheckButtonTemplate", {
		type = "CheckButton";
		name = "EarthCheckButtonTemplate";
		Size = { 32, 32, };
		NormalTexture = {
			type = "Texture";
			name = "$parentNormalTexture";
			Texture = "Interface\\Buttons\\UI-CheckBox-Up";
		};
		PushedTexture = {
			type = "Texture";
			name = "$parentPushedTexture";
			Texture = "Interface\\Buttons\\UI-CheckBox-Down";
		};
		HighlightTexture = {
			type = "Texture";
			name = "$parentHighlightTexture";
			Texture = "Interface\\Buttons\\UI-CheckBox-Highlight";
			AlphaMode = "ADD";
		};
		CheckedTexture = {
			type = "Texture";
			name = "$parentCheckedTexture";
			Texture = "Interface\\Buttons\\UI-CheckBox-Check";
		};
		DisabledCheckedTexture = {
			type = "Texture";
			name = "$parentDisabledCheckedTexture";
			Texture = "Interface\\Buttons\\UI-CheckBox-Check-Disabled";
		};
		-- Regions
		{
			type = "FontString";
			name = "$parentText";
			inherits = "GameFontNormalSmall";
			DrawLayer = "ARTWORK";
			Anchors = {
				{"LEFT", nil, "RIGHT", -2, 0, };
			};
		};
	});
	
	VF:Register("EarthPanelButtonUpTexture", {
		type = "Texture";
		name = "EarthPanelButtonUpTexture";
		Texture = "Interface\\Buttons\\UI-Panel-Button-Up";
		TexCoords = { left = 0, right = 0.625, top = 0, bottom = 0.6875, };
	});
	
	VF:Register("EarthPanelButtonDownTexture", {
		type = "Texture";
		name = "EarthPanelButtonDownTexture";
		Texture = "Interface\\Buttons\\UI-Panel-Button-Down";
		TexCoords = { left = 0, right = 0.625, top = 0, bottom = 0.6875, };
	});
	
	VF:Register("EarthPanelButtonDisabledTexture", {
		type = "Texture";
		name = "EarthPanelButtonDisabledTexture";
		Texture = "Interface\\Buttons\\UI-Panel-Button-Disabled";
		TexCoords = { left = 0, right = 0.625, top = 0, bottom = 0.6875, };
	});
	
	VF:Register("EarthPanelButtonDisabledDownTexture", {
		type = "Texture";
		name = "EarthPanelButtonDisabledDownTexture";
		Texture = "Interface\\Buttons\\UI-Panel-Button-Disabled-Down";
		TexCoords = { left = 0, right = 0.625, top = 0, bottom = 0.6875, };
	});
	
	VF:Register("EarthPanelButtonHighlightTexture", {
		type = "Texture";
		name = "EarthPanelButtonHighlightTexture";
		Texture = "Interface\\Buttons\\UI-Panel-Button-Highlight";
		AlphaMode = "ADD";
		TexCoords = { left = 0, right = 0.625, top = 0, bottom = 0.6875, };
	});
	
	VF:Register("EarthPanelButtonTemplate", {
		type = "Button";
		name = "EarthPanelButtonTemplate";
		NormalText = {
			type = "Font";
			name = "$parentText";
			inherits = "GameFontNormal";
		};
		DisabledText = {
			type = "Font";
			inherits = "GameFontDisable";
		};
		HighlightText = {
			type = "Font";
			inherits = "GameFontHighlight";
		};
		NormalTexture = {
			type = "Texture";
			inherits = "EarthPanelButtonUpTexture";
		};
		PushedTexture = {
			type = "Texture";
			inherits = "EarthPanelButtonDownTexture";
		};
		DisabledTexture = {
			type = "Texture";
			inherits = "EarthPanelButtonDisabledTexture";
		};
		HighlightTexture = {
			type = "Texture";
			inherits = "EarthPanelButtonHighlightTexture";
		};
	});
	
	VF:Register("LoginSelectionFrameTemplate", {
		type = "Frame";
		Hidden = true;
		Parent = "UIParent";
		Size = { 300, 150, };
		Anchors = {
			{"CENTER", "$parent", "CENTER", 0, 40, };
		};
		Backdrop = {
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true, tileSize = 16, edgeSize = 16, -- misc values
			insets = { left = 4, right = 4, top = 4, bottom = 4, },
		};
		-- Regions
		{
			type = "FontString";
			name = "$parentText";
			inherits = "GameFontNormal";
			--DrawLayer = "LOW";
			--MaxLines = 12;
			Size = { 0, 10, };
			Anchors = {
				{"TOP", "$parent", "TOP", 0, -20, };
			};
		};
		-- Children
		{
			type = "Frame";
			name = "$parentConfigurationSelect";
			Size = { 220, 32, };
			Anchors = {
				{"CENTER", "$parent", "CENTER", 0, 10, };
			};
			-- Regions
			{
				type = "Texture";
				name = "$parentLeft";
				DrawLayer = "ARTWORK";
				Texture = "Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame";
				Size = { 25, 64, };
				Anchors = {
					{"TOPLEFT", nil, "TOPLEFT", 0, 17, };
				};
				TexCoords = { left = 0, right = 0.1953125, top = 0, bottom = 1, };
			};
			{
				type = "Texture";
				name = "$parentMiddle";
				DrawLayer = "ARTWORK";
				Texture = "Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame";
				Size = { 180, 64, };
				Anchors = {
					{"LEFT", "$parentLeft", "RIGHT"};
				};
				TexCoords = { left = 0.1953125, right = 0.8046875, top = 0, bottom = 1, };
			};
			{
				type = "Texture";
				name = "$parentRight";
				DrawLayer = "ARTWORK";
				Texture = "Interface\\Glues\\CharacterCreate\\CharacterCreate-LabelFrame";
				Size = { 25, 64, };
				Anchors = {
					{"LEFT", "$parentMiddle", "RIGHT"};
				};
				TexCoords = { left = 0.8046875, right = 1, top = 0, bottom = 1, };
			};
			{
				type = "FontString";
				name = "$parentText";
				inherits = "GameFontHighlightSmall";
				DrawLayer = "ARTWORK";
				JustifyH = "RIGHT";
				Size = { 0, 10, };
				Anchors = {
					{"RIGHT", "$parentRight", "RIGHT", -43, 2, };
				};
			};
			-- Children
			{
				type = "Button";
				name = "$parentButton";
				Size = { 24, 24, };
				Anchors = {
					{"TOPLEFT", "$parentLeft", "TOPLEFT", 16, -19, };
				};
				NormalTexture = {
					type = "Texture";
					name = "$parentNormalTexture";
					Texture = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up";
					Size = { 24, 24, };
					Anchors = {
						{"RIGHT", nil, "RIGHT"};
					};
				};
				PushedTexture = {
					type = "Texture";
					name = "$parentPushedTexture";
					Texture = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down";
					Size = { 24, 24, };
					Anchors = {
						{"RIGHT", nil, "RIGHT"};
					};
				};
				DisabledTexture = {
					type = "Texture";
					name = "$parentDisabledTexture";
					Texture = "Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled";
					Size = { 24, 24, };
					Anchors = {
						{"RIGHT", nil, "RIGHT"};
					};
				};
				HighlightTexture = {
					type = "Texture";
					name = "$parentHighlightTexture";
					Texture = "Interface\\Buttons\\UI-Common-MouseHilight";
					AlphaMode = "ADD";
					Size = { 24, 24, };
					Anchors = {
						{"RIGHT", nil, "RIGHT"};
					};
				};
			};
		};
		{
			type = "CheckButton";
			name = "$parentCheckBox";
			inherits = "EarthCheckButtonTemplate";
			Size = { 32, 32, };
			Anchors = {
				{"TOPLEFT", "$parent", "LEFT", 16, -8, };
			};
		};
		{
			type = "Button";
			name = "$parentLeftButton";
			inherits = "EarthPanelButtonTemplate";
			Size = { 96, 24, };
			Anchors = {
				{"TOP", "$parent", "CENTER", -64, -38, };
			};
		};
		{
			type = "Button";
			name = "$parentRightButton";
			inherits = "EarthPanelButtonTemplate";
			Size = { 96, 24, };
			Anchors = {
				{"TOP", "$parent", "CENTER", 64, -38, };
			};
		};
	});
	
	------------------------------------------------------------------------------
	--[[ Frame Instantiations ]]--
	------------------------------------------------------------------------------
	
	VF:Instantiate("LoginSelectionFrameTemplate", "LanguageSelectionFrame", "UIParent")
	
	-- Fake menu frame.... who says you need a frame, bah!
	LanguageDropDown = {
		initialize = Localization.LoadDropDownMenu;
		GetName = function() return "LanguageDropDown" end;
		SetHeight = function() end;
	}
	
	------------------------------------------------------------------------------
	--[[ Frame Script Assignment ]]--
	------------------------------------------------------------------------------
	
	LanguageSelectionFrame:RegisterEvent("VARIABLES_LOADED")
	LanguageSelectionFrame:RegisterEvent("ADDON_LOADED")
	
	LanguageSelectionFrame:SetScript("OnEvent", Localization.OnEvent)
	LanguageSelectionFrame:SetScript("OnShow", Localization.SellectionFrame_OnShow)
	LanguageSelectionFrameConfigurationSelectButton:SetScript("OnClick", Localization.ShowDropDown)
	LanguageSelectionFrameLeftButton:SetScript("OnClick", Localization.ConfirmPreference)
	LanguageSelectionFrameRightButton:SetScript("OnClick", Localization.CancelPreference)
	
	------------------------------------------------------------------------------
	--[[ Slash Command ]]--
	------------------------------------------------------------------------------
	
	SLASH_LOCALIZATION1 = "/locale"
	SlashCmdList["LOCALIZATION"] = Localization.Prompt	
	
	------------------------------------------------------------------------------
	--[[ Direct Execution ]]--
	------------------------------------------------------------------------------
	
	Localization.SetAddonDefault("Localization", "enUS")
	Localization.RegisterCallback("AssignAllGlobalStrings", Localization.AssignAllGlobalStrings)
	Localization.RegisterCallback("LocalizationPrompt", Localization.UpdatePrompt)
	
	-- Leave frame text updating until after the localization files have been loaded
	
end
