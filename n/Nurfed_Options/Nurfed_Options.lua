-----------------------------------------------------------------------------------------
--			Nurfed Options Menu
-----------------------------------------------------------------------------------------

local utility = Nurfed_Utility:New();
local framelib = Nurfed_Frames:New();

local menus = {};
local activemenu = nil;

StaticPopupDialogs["NRF_RELOADUI"] = {
	text = "Reload User Interface?",
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	OnAccept = function()
		ReloadUI();
	end,
	timeout = 10,
	whileDead = 1,
	hideOnEscape = 1,
};

local templates = {
	nrf_menu_button = {
		type = "Button",
		size = { 80, 14 },
		TextFontObject = "GameFontNormalSmall",
		TextColor = { 0.5, 0.5, 0.5 },
		HighlightTextColor = { 1, 1, 1 },
		DisabledTextColor = { 1, 1, 1 },
		PushedTextOffset = { 1, -1 },
		children = {
			NormalTexture = {
				type = "Texture",
				layer = "BACKGROUND",
				Anchor = "all",
				Texture = NRF_IMG.."statusbar8",
				Gradient = { "VERTICAL", 1, 0.5, 0, 0.2, 0, 0 },
			},
			DisabledTexture = {
				type = "Texture",
				layer = "BACKGROUND",
				Anchor = "all",
				Texture = NRF_IMG.."statusbar8",
				Gradient = { "VERTICAL", 0, 0.75, 1, 0, 0, 0.2 },
			},
		},
	},
	nrf_options = {
		type = "Frame",
		size = { 411, 271 },
		Anchor = { "TOPRIGHT", "$parentheader", "BOTTOMRIGHT", 1, 0 },
		Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
		BackdropColor = { 0, 0, 0, 0.95 },
		Alpha = 0,
		Hide = true,
	},
	nrf_addon_row = {
		type = "Frame",
		size = { 400, 14 },
		children = {
			check = {
				type = "CheckButton",
				size = { 16, 16 },
				uitemp = "UICheckButtonTemplate",
				Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 2, 0 },
				OnClick = function() Nurfed_ToggleAddOn() end,
			},
			name = {
				type = "FontString",
				layer = "ARTWORK",
				size = { 190, 14 },
				Anchor = { "LEFT", "$parentcheck", "RIGHT", 5, 0 },
				FontObject = "GameFontNormal",
				JustifyH = "LEFT",
				TextColor = { 1, 1, 1 },
			},
			loaded = {
				type = "FontString",
				layer = "ARTWORK",
				size = { 105, 14 },
				Anchor = { "LEFT", "$parentname", "RIGHT", 5, 0 },
				FontObject = "GameFontNormal",
				JustifyH = "LEFT",
				TextColor = { 1, 1, 1 },
			},
			reload = {
				type = "FontString",
				layer = "ARTWORK",
				size = { 100, 14 },
				Anchor = { "LEFT", "$parentloaded", "RIGHT", 5, 0 },
				FontObject = "GameFontNormal",
				JustifyH = "LEFT",
				TextColor = { 1, 0, 0 },
			},
		},
	},
	nrf_button = {
		type = "Button",
		size = { 30, 18 },
		Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
		BackdropColor = { 0, 0, 0, 0.75 },
		Font = { "Fonts\\ARIALN.TTF", 10, "NONE" },
		TextColor = { 0.65, 0.65, 0.65 },
		HighlightTextColor = { 1, 1, 1 },
		PushedTextOffset = { 1, -1 },
		OnShow = function() Nurfed_Options_buttonOnShow() end,
	},
	nrf_check = {
		type = "CheckButton",
		size = { 20, 20 },
		uitemp = "UICheckButtonTemplate",
		OnShow = function() Nurfed_Options_OnShow() end,
		OnClick = function() Nurfed_Options_checkOnClick() end,
	},
	nrf_smallcheck = {
		type = "CheckButton",
		size = { 16, 16 },
		uitemp = "UICheckButtonTemplate",
		OnShow = function() Nurfed_Options_OnShow() end,
		OnClick = function() Nurfed_Options_checkOnClick() end,
	},
	nrf_radio = {
		type = "CheckButton",
		size = { 14, 14 },
		uitemp = "UIRadioButtonTemplate",
		OnShow = function() Nurfed_Options_OnShow() end,
		OnClick = function() Nurfed_Options_radioOnClick() end,
	},
	nrf_slider = {
		type = "Slider",
		uitemp = "OptionsSliderTemplate",
		children = {
			value = {
				type = "FontString",
				layer = "ARTWORK",
				FontObject = "GameFontNormalSmall",
				JustifyH = "CENTER",
				TextColor = { 0, 1, 0 },
			},
		},
		OnShow = function() Nurfed_Options_OnShow() end,
		OnMouseUp = function() Nurfed_Options_sliderOnMouseUp() end,
		OnValueChanged = function() Nurfed_Options_sliderOnValueChanged() end,
	},
	nrf_editbox = {
		type = "EditBox",
		AutoFocus = false,
		Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
		BackdropColor = { 0, 0, 0.2, 0.75 },
		FontObject = "GameFontNormalSmall",
		TextColor = { 1, 1, 1 },
		TextInsets = { 3, 9, 0, 0 },
		OnEscapePressed = function() this:ClearFocus() end,
		OnEditFocusLost = function() this:HighlightText(0, 0) end,
		OnEditFocusGained = function() this:HighlightText() end,
	},
	nrf_input = {
		type = "Frame",
		size = { 130, 30 },
		children = {
			Text = {
				type = "FontString",
				layer = "ARTWORK",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, 0 },
				FontObject = "GameFontNormalSmall",
				JustifyH = "LEFT",
			},
			input = {
				template = "nrf_editbox",
				size = { 100, 18 },
				Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 0, 0 },
				OnEnterPressed = function() Nurfed_Options_inputOnClick() end,
			},
			set = {
				template = "nrf_button",
				Anchor = { "LEFT", "$parentinput", "RIGHT", 1, 0 },
				OnClick = function() Nurfed_Options_inputOnClick() end,
				vars = { text = "Set" },
			},
		},
		OnShow = function() Nurfed_Options_inputOnShow() end,
	},
	nrf_color = {
		type = "Button",
		size = { 18, 18 },
		children = {
			bg = {
				type = "Texture",
				Texture = "Interface\\ChatFrame\\ChatFrameColorSwatch",
				layer = "BACKGROUND",
				Anchor = "all",
				VertexColor = { 1, 1, 1 },
			},
			Text = {
				type = "FontString",
				layer = "ARTWORK",
				Anchor = { "LEFT", "$parent", "RIGHT", 1, 0 },
				FontObject = "GameFontNormalSmall",
				JustifyH = "LEFT",
			},
		},
		OnShow = function() Nurfed_Options_swatchOnShow() end,
		OnClick = function() Nurfed_Options_swatchOpenColorPicker() end,
	},
	nrf_scroll = {
		type = "ScrollFrame",
		Anchor = "all",
		uitemp = "FauxScrollFrameTemplate",
		OnVerticalScroll = function() FauxScrollFrame_OnVerticalScroll(100, Nurfed_Options_ScrollMenu) end,
		OnShow = function() Nurfed_Options_ScrollMenu() end,
	},
	nrf_optionpane = {
		type = "Frame",
		Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
		BackdropColor = { 0, 0, 0, 0.5 },
		BackdropBorderColor = { 0.75, 0.75, 0.75, 1 },
		children = {
			title = {
				type = "FontString",
				layer = "ARTWORK",
				Anchor = { "BOTTOMLEFT", "$parent", "TOPLEFT", 10, -2 },
				FontObject = "GameFontNormalSmall",
				JustifyH = "LEFT",
			},
		},
		OnShow = function() Nurfed_Options_paneOnShow() end,
	},
	nrf_paneeditbox = {
		type = "EditBox",
		AutoFocus = false,
		Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = nil, tile = true, tileSize = 16, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
		BackdropColor = { 0.5, 0.5, 0.5, 0.85 },
		FontObject = "GameFontNormalSmall",
		TextColor = { 1, 1, 0 },
		TextInsets = { 3, 9, 0, 0 },
		OnEscapePressed = function() this:ClearFocus() end,
		OnEditFocusLost = function() this:HighlightText(0, 0) end,
		OnEditFocusGained = function() this:HighlightText() end,
		OnEnterPressed = function() Nurfed_Options_paneAddOption() end,
	},
	nrf_panescroll = {
		type = "ScrollFrame",
		Anchor = "all",
		uitemp = "FauxScrollFrameTemplate",
		Scale = 0.75,
		OnVerticalScroll = function() FauxScrollFrame_OnVerticalScroll(13, Nurfed_Options_ScrollPane) end,
		OnShow = function() Nurfed_Options_ScrollPane() end,
	},
	nrf_pane_row = {
		type = "Button",
		children = {
			text = {
				type = "FontString",
				layer = "ARTWORK",
				Anchor = "all",
				FontObject = "GameFontNormalSmall",
				JustifyH = "LEFT",
				TextColor = { 0, 1, 1 },
			},
			HighlightTexture = {
				type = "Texture",
				layer = "BACKGROUND",
				Texture = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
				BlendMode = "ADD",
				Anchor = "all",
			},
		},
		OnClick = function() Nurfed_Options_PaneSelect() end,
	},
};

local layout = {
	type = "Frame",
	size = { 500, 300 },
	FrameStrata = "LOW",
	Anchor = { "CENTER", "$parent", "CENTER", 0, 0 },
	Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 4, top = 5, bottom = 4 }, },
	BackdropColor = { 0, 0, 0, 0.25 },
	children = {
		header = {
			type = "Frame",
			size = { 490, 20 },
			Anchor = { "TOP", "$parent", "TOP", 0, -5 },
			children = {
				bg = {
					type = "Texture",
					layer = "BACKGROUND",
					Anchor = "all",
					Texture = NRF_IMG.."statusbar8",
					Gradient = { "HORIZONTAL", 0, 0.75, 1, 0, 0, 0.2 },
				},
				title = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = "all",
					Font = { "Fonts\\FRIZQT__.TTF", 13, "OUTLINE" },
					JustifyH = "LEFT",
					TextColor = { 1, 1, 1 },
				},
				version = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = "all",
					Font = { "Fonts\\MORPHEUS.ttf", 13, "NONE" },
					JustifyH = "RIGHT",
					TextColor = { 1, 1, 1 },
				},
				border = {
					type = "Texture",
					size = { 490, 3 },
					layer = "OVERLAY",
					Anchor = { "TOP", "$parent", "BOTTOM", 0, 1 },
					Texture = "Interface\\ClassTrainerFrame\\UI-ClassTrainer-HorizontalBar",
					TexCoord = { 0.2, 1, 0, 0.25 },
				},
			},
		},
		menubg = {
			type = "Frame",
			FrameStrata = "BACKGROUND",
			size = { 85, 278 },
			Anchor = { "TOPLEFT", "$parentheader", "BOTTOMLEFT", -3, 5 },
			Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 3, right = 2, top = 3, bottom = 2 }, },
			BackdropColor = { 0, 0, 0, 0.95 },
		},
		button1 = {
			template = "nrf_menu_button",
			Anchor = { "TOPLEFT", "$parentheader", "BOTTOMLEFT", 0, 0 },
			Text = "AddOns",
			OnClick = function() Nurfed_MenuClick(this.id) end,
			vars = {
				id = 1,
			},
		},
		button2 = {
			template = "nrf_menu_button",
			Anchor = { "TOPLEFT", "$parentbutton1", "BOTTOMLEFT", 0, -1 },
			Text = "Profiles",
			OnClick = function() Nurfed_MenuClick(this.id) end,
			vars = {
				id = 2,
			},
		},
	},
	Hide = true,
};

function Nurfed_OptionsInit()
	for k, v in pairs(templates) do
		framelib:CreateTemplate(k, v);
	end

	local count = GetNumAddOns();
	local add = {};

	for i = 1, count do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i);
		local loaded = IsAddOnLoaded(i);
		if (string.find(name, "^Nurfed") and loaded) then
			local text = string.gsub(name, "Nurfed_", "");
			if (Nurfed_OptionsMenus[text]) then
				table.insert(add, text);
			end
		end
	end

	for k, v in pairs(add) do
		layout.children["button"..k + 2] = {
			template = "nrf_menu_button",
			Anchor = { "TOPLEFT", "$parentbutton"..k + 1, "BOTTOMLEFT", 0, -1 },
			OnClick = function() Nurfed_MenuClick(this.id) end,
			Text = v,
			vars = {
				id = k + 2,
			},
		};
	end

	local last = table.getn(add) + 2;
	layout.children["reloadui"] = {
		template = "nrf_menu_button",
		Anchor = { "TOPLEFT", "$parentbutton"..last, "BOTTOMLEFT", 0, -1 },
		OnClick = function() StaticPopup_Show("NRF_RELOADUI") end,
		Text = "Reload UI",
	};
	layout.children["close"] = {
		template = "nrf_menu_button",
		Anchor = { "TOPLEFT", "$parentreloadui", "BOTTOMLEFT", 0, -1 },
		OnClick = function() HideUIPanel(this:GetParent()) end,
		Text = CLOSE,
	};

	local frame = framelib:ObjectInit("Nurfed_OptionsFrame", layout);
	UIPanelWindows["Nurfed_OptionsFrame"] = { area = "center", pushable = 0, whileDead = 1 };
	Nurfed_OptionsFrameheadertitle:SetText("Nurfed Options Menu");
	Nurfed_OptionsFrameheaderversion:SetText(GetAddOnMetadata("Nurfed_Options", "Version"));

	templates = nil;
	layout = nil;
end

function Nurfed_MenuClick(id)
	this:Disable();
	local i = 1;
	local name = string.gsub(this:GetName(), id, "");
	local button = getglobal(name..i);
	while (button) do
		if (button.id ~= id and button:IsEnabled() == 0) then
			button:Enable();
			Nurfed_HideMenu(button:GetText());
		end
		i = i + 1;
		button = getglobal(name..i);
	end
	Nurfed_ShowMenu(this:GetText());
end

function Nurfed_ShowMenu(menu)
	if (not menus[menu]) then
		local opt = framelib:ObjectInit("Nurfed_OptionsFrame"..menu, Nurfed_OptionsMenus[menu], Nurfed_OptionsFrame);
		menus[menu] = opt;
		Nurfed_OptionsMenus[menu] = nil;
		if (menu == "AddOns") then
			Nurfed_GenerateAddOnsMenu();
		end
		local scroll = getglobal(opt:GetName().."scrollScrollBar");
		if (scroll) then
			scroll:SetPoint("RIGHT", scroll:GetParent():GetName(), "RIGHT", -25, 0);
		end
	end

	PlaySound("igAbiliityPageTurn");
	activemenu = menu;
	menus[menu]:Show();
	UIFrameFadeIn(menus[menu], 0.25);
end

function Nurfed_HideMenu(menu)
	menus[menu]:SetAlpha(0);
	menus[menu]:Hide();
end

-----------------------------------------------------------------------------------------
--			Nurfed AddOns Menu
-----------------------------------------------------------------------------------------

function Nurfed_GenerateAddOnsMenu()
	for i = 1, 19 do
		local row = framelib:ObjectInit("Nurfed_AddOnsRow"..i, "nrf_addon_row", Nurfed_OptionsFrameAddOns);
		if (i == 1) then
			row:SetPoint("TOPLEFT", "Nurfed_OptionsFrameAddOns", "TOPLEFT", 0, -3);
		else
			row:SetPoint("TOPLEFT", "Nurfed_AddOnsRow"..i - 1, "BOTTOMLEFT", 0, 0);
		end
	end
end

function Nurfed_ToggleAddOn()
	if (this:GetChecked()) then
		EnableAddOn(this:GetID());
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		DisableAddOn(this:GetID());
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	local reload = getglobal(this:GetParent():GetName().."reload");
	reload:SetText("(Reload UI)");
end

function Nurfed_ScrollAddOns()
	local line, offset, row;
	local function format_row(row, num)
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(num);
		local loaded = IsAddOnLoaded(num);
		local text = name;
		if (title) then
			text = title;
		end
		local check = getglobal(row.."check");
		local na = getglobal(row.."name");
		local load = getglobal(row.."loaded");

		na:SetText(text);
		if (enabled) then
			na:SetTextColor(1, 1, 1);
		else
			na:SetTextColor(0.5, 0.5, 0.5);
		end

		if (name == "Nurfed_Options") then
			check:Hide();
		else
			check:Show();
			check:SetChecked(enabled);
			check:SetID(num);
		end
		if (loaded) then
			load:SetText("Loaded");
			load:SetTextColor(1, 1, 1);
		elseif (loadable) then
			load:SetText("On Demand");
			load:SetTextColor(1, 1, 1);
		else
			local y = getglobal("ADDON_"..reason);
			load:SetText(y);
			load:SetTextColor(0.5, 0.5, 0.5);
		end
	end

	local count = GetNumAddOns();
	FauxScrollFrame_Update(this, count, 19, 14);
	for line = 1, 19 do
		offset = line + FauxScrollFrame_GetOffset(this);
		row = getglobal("Nurfed_AddOnsRow"..line);
		if offset < count then
			format_row("Nurfed_AddOnsRow"..line, offset);
			row:Show();
		else
			row:Hide();
		end
	end
end

-----------------------------------------------------------------------------------------
--			Nurfed Options Functions
-----------------------------------------------------------------------------------------

-- scroll
function Nurfed_Options_ScrollMenu()
	FauxScrollFrame_Update(this, this.pages, 1, 100);
	local page = FauxScrollFrame_GetOffset(this) + 1;
	local children = { this:GetParent():GetChildren() };
	for _, child in ipairs(children) do
		if (not string.find(child:GetName(), "scroll", 1, true)) then
			if (child.page == page) then
				child:Show();
			else
				child:Hide();
			end
		end
	end
end

-- display
function Nurfed_Options_OnShow()
	local text = getglobal(this:GetName().."Text");
	text:SetText(this.text);
	if (this.right) then
		text:ClearAllPoints()
		text:SetPoint("RIGHT", this:GetName(), "LEFT", -1, 1);
	end
	if (this.color) then
		text:SetTextColor(unpack(this.color));
	end
	if (this.option) then
		local objtype = this:GetObjectType();
		local option = utility:GetOption(activemenu, this.option);
		if (objtype == "CheckButton") then
			this:SetChecked(option);
		elseif (objtype == "Slider") then
			local low = getglobal(this:GetName().."Low");
			local high = getglobal(this:GetName().."High");
			low:SetText(this.low);
			high:SetText(this.high);
			this:SetMinMaxValues(this.min, this.max);
			this:SetValueStep(this.step);
			this:SetValue(option);
		end
	end
	this:SetScript("OnShow", nil);
	
end

local function optionInit()
	local text = getglobal(this:GetName().."Text");
	text:SetText(this.text);
	if (this.right) then
		text:ClearAllPoints()
		text:SetPoint("RIGHT", this:GetName(), "LEFT", -1, 1);
	end
	if (this.color) then
		text:SetTextColor(unpack(this.color));
	end
	if (this.option and not this.id) then
		return utility:GetOption(activemenu, this.option);
	end
end

-- buttons
function Nurfed_Options_buttonOnShow()
	this:SetText(this.text);
	local width = string.len(this.text);
	this:SetWidth(width*6 + 10);
end

-- checks
function Nurfed_Options_checkOnClick()
	local value = 0;
	local func = this.func;
	if (this:GetChecked()) then
		value = 1;
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	if (this.id and not this:GetParent().selected) then
		return;
	end
	utility:SetOption(activemenu, this.option, value, this.id, this:GetParent().selected);
	if (this.id) then
		func = this:GetParent().func;
	end
	if (func) then
		func();
	end
end

-- sliders
function Nurfed_Options_sliderOnMouseUp()
	local value = this:GetValue();
	local func = this.func;
	if (this.id and not this:GetParent().selected) then
		return;
	end
	utility:SetOption(activemenu, this.option, value, this.id, this:GetParent().selected);
	if (this.id) then
		func = this:GetParent().func;
	end
	if (func) then
		func();
	end
end

function Nurfed_Options_sliderOnValueChanged()
	local value = this:GetValue();
	local text = getglobal(this:GetName().."value");

	text:ClearAllPoints();
	if (value > (this.max / 2)) then
		text:SetPoint("LEFT", this:GetName(), "LEFT", 1, 1);
	else
		text:SetPoint("RIGHT", this:GetName(), "RIGHT", -1, 1);
	end
	text:SetText("("..format(this.format, value)..")");
end

-- editbox
function Nurfed_Options_inputOnShow()
	local option = optionInit();
	if (not option) then
		return;
	end
	local inputtext = getglobal(this:GetName().."input");
	inputtext:SetText(option);
end

function Nurfed_Options_inputOnClick()
	local inputtext = getglobal(this:GetParent():GetName().."input");
	if (not inputtext:GetText() or inputtext:GetText() == "") then
		return;
	end
	utility:SetOption(activemenu, this:GetParent().option, inputtext:GetText());
	inputtext:ClearFocus();
	if (this:GetParent().func) then
		this:GetParent().func();
	end
end

-- color swatches
function Nurfed_Options_swatchSetColor(frame)
	local option = frame.option;
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local a = OpacitySliderFrame:GetValue();
	local swatch = getglobal(frame:GetName().."bg");
	swatch:SetVertexColor(r, g, b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	utility:SetOption(activemenu, frame.option, { r, g, b, a });
	if (frame.func) then
		frame.func();
	end
end

function Nurfed_Options_swatchCancelColor(frame, prev)
	local option = frame.option;
	local r = prev.r;
	local g = prev.g;
	local b = prev.b;
	local a = prev.a;
	local swatch = getglobal(frame:GetName().."bg");
	swatch:SetVertexColor(r, g, b);
	frame.r = r;
	frame.g = g;
	frame.b = b;
	utility:SetOption(activemenu, frame.option, { r, g, b, a });
	if (frame.func) then
		frame.func();
	end
end

function Nurfed_Options_swatchOnShow()
	if (this:IsShown()) then
		local option = optionInit();
		if (not option) then
			return;
		end
		local frame = this;
		local swatch = getglobal(this:GetName().."bg");
		swatch:SetVertexColor(option[1], option[2], option[3]);

		this.r = option[1];
		this.g = option[2];
		this.b = option[3];
		this.swatchFunc = function() Nurfed_Options_swatchSetColor(frame) end;
		this.cancelFunc = function(x) Nurfed_Options_swatchCancelColor(frame, x) end;
		if (frame.opacity) then
			this.hasOpacity = frame.opacity;
			this.opacityFunc = function() Nurfed_Options_swatchSetColor(frame) end;
			this.opacity = option[4];
		end
	end
end

function Nurfed_Options_swatchOpenColorPicker()
	CloseMenus();
	ColorPickerFrame.func = this.swatchFunc;
	ColorPickerFrame.hasOpacity = this.hasOpacity;
	ColorPickerFrame.opacityFunc = this.opacityFunc;
	ColorPickerFrame.opacity = this.opacity;
	ColorPickerFrame:SetColorRGB(this.r, this.g, this.b);
	ColorPickerFrame.previousValues = {r = this.r, g = this.g, b = this.b, a = this.opacity};
	ColorPickerFrame.cancelFunc = this.cancelFunc;
	ColorPickerFrame:Show();
end

-- radios
function Nurfed_Options_radioOnClick(frame, index, noupdate)
	if (not index) then
		index = this.index;
	end
	if (not frame) then
		frame = this:GetParent();
	end
	local children = { frame:GetChildren() };
	for _, child in ipairs(children) do
		if (child.index == index) then
			child:SetChecked(1);
		else
			child:SetChecked(nil);
		end
	end
	PlaySound("igMainMenuOptionCheckBoxOn");

	if (not frame:GetParent().selected or noupdate) then
		return;
	end
	utility:SetOption(activemenu, frame.option, index, frame.id, frame:GetParent().selected);
	local func = frame:GetParent().func;
	if (func) then
		func();
	end
end

function Nurfed_Options_radioGetSelected(frame)
	if (not frame) then
		frame = this:GetParent();
	end
	local children = { frame:GetChildren() };
	for _, child in ipairs(children) do
		if (child:GetChecked()) then
			return child.index;
		end
	end
end

-- panes
function Nurfed_Options_paneOnShow()
	local title = getglobal(this:GetName().."title");
	if (this.text) then
		title:SetText(this.text);
	end
	local scroll = getglobal(this:GetName().."scrollScrollBar");
	if (scroll) then
		scroll:SetPoint("RIGHT", scroll:GetParent():GetName(), "RIGHT", -26, 0);
	end
	local children = { this:GetChildren() };
	for _, child in ipairs(children) do
		local objtype = child:GetObjectType();
		if (objtype == "CheckButton") then
			child:SetChecked(child.default);
		elseif (objtype == "Slider") then
			local low = getglobal(child:GetName().."Low");
			local high = getglobal(child:GetName().."High");
			low:SetText(child.low);
			high:SetText(child.high);
			child:SetMinMaxValues(child.min, child.max);
			child:SetValueStep(child.step);
			child:SetValue(child.default);
		elseif (objtype == "Frame" and child.isradio) then
			Nurfed_Options_radioOnClick(child, child.default, true);
		end
		child.option = this.option;
	end
	this:SetScript("OnShow", nil);
end

function Nurfed_Options_paneUpdateOptions(frame)
	local option = utility:GetOption(activemenu, frame.option);
	local selected = option[frame.selected];
	local children = { frame:GetChildren() };
	for _, child in ipairs(children) do
		local objtype = child:GetObjectType();
		if (objtype == "CheckButton") then
			child:SetChecked(selected[child.id]);
		elseif (objtype == "Slider") then
			child:SetValue(selected[child.id]);
		elseif (objtype == "Frame" and child.isradio) then
			Nurfed_Options_radioOnClick(child, selected[child.id], true);
		end
	end
end

function Nurfed_Options_paneGetOptions()
	local tbl = {};
	local children = { this:GetParent():GetChildren() };
	for _, child in ipairs(children) do
		if (child.id) then
			local objtype = child:GetObjectType();
			if (objtype == "Slider") then
				tbl[child.id] = child:GetValue();
			elseif (objtype == "CheckButton") then
				if (child:GetChecked()) then
					tbl[child.id] = 1;
				else
					tbl[child.id] = 0;
				end
			elseif (objtype == "Frame" and child.isradio) then
				tbl[child.id] = Nurfed_Options_radioGetSelected(child);
			end
		end
	end
	return tbl;
end

function Nurfed_Options_paneAddOption()
	local frame = this:GetParent();
	local objtype = this:GetObjectType();
	if (objtype == "EditBox") then
		if (this:GetText() and this:GetText() ~= "") then
			if (frame.up) then
				this:SetText(string.gsub(this:GetText(), "^%l", string.upper));
			end
			if (frame.notbl) then
				utility:SetOption(activemenu, frame.option, true, this:GetText());
			else
				local tbl = Nurfed_Options_paneGetOptions();
				utility:SetOption(activemenu, frame.option, tbl, this:GetText());
			end
		end
		this:ClearFocus();
		this:SetText("");
	else
		local option = utility:GetOption(activemenu, frame.option);
		local name = table.getn(option) + 1;
		local tbl = Nurfed_Options_paneGetOptions();
		utility:SetOption(activemenu, frame.option, tbl, name);
	end
	Nurfed_Options_ScrollPane(frame);
	if (frame.func) then
		frame.func();
	end
end

function Nurfed_Options_paneRemoveOption()
	local frame = this:GetParent();
	if (frame.selected) then
		utility:SetOption(activemenu, frame.option, nil, frame.selected);
		frame.selected = nil;
	end
	Nurfed_Options_ScrollPane(frame);
	if (frame.func) then
		frame.func();
	end
end

function Nurfed_Options_ScrollPane(frame)
	if (not frame) then
		frame = this:GetParent();
	else
		this = getglobal(frame:GetName().."scroll");
	end
	local rows = frame.rows;
	local selected = frame.selected;
	local line, offset, row, text, count, temp;
	local option = utility:GetOption(activemenu, frame.option);
	
	if (table.getn(option) > 0) then
		count = table.getn(option);
	else
		temp = {};
		for k in pairs(option) do
			table.insert(temp, k);
		end
		count = table.getn(temp);
	end
	FauxScrollFrame_Update(this, count, rows, 13);
	for line = 1, rows do
		offset = line + FauxScrollFrame_GetOffset(this);
		row = getglobal(frame:GetName().."row"..line);
		text = getglobal(row:GetName().."text");
		if offset <= count then
			if (temp) then
				text:SetText(temp[offset]);
				if (selected == temp[offset]) then
					row:LockHighlight();
				else
					row:UnlockHighlight();
				end
			else
				text:SetText(frame.prefix.." "..offset);
				row.id = offset;
				if (selected == offset) then
					row:LockHighlight();
				else
					row:UnlockHighlight();
				end
			end
			row:Show();
		else
			row:Hide();
		end
	end
end

function Nurfed_Options_PaneSelect()
	local frame = this:GetParent();
	local selected = frame.selected;
	if (this.id) then
		if (selected == this.id) then
			frame.selected = nil;
			this:UnlockHighlight();
		else
			frame.selected = this.id;
			this:LockHighlight();
		end
	else
		local text = getglobal(this:GetName().."text"):GetText();
		if (selected == text) then
			frame.selected = nil;
			this:UnlockHighlight();
		else
			frame.selected = text;
			this:LockHighlight();
		end
	end
	if (frame.selected) then
		Nurfed_Options_paneUpdateOptions(frame);
	end
	Nurfed_Options_ScrollPane(frame);
end