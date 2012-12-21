
if (not Nurfed_Options) then

	local framelib = Nurfed_Frames:New();

	Nurfed_Options = {};
	
	function Nurfed_Options:New ()
		local object = {};
		setmetatable(object, self);
		self.__index = self;
		return object;
	end

	function Nurfed_Options:GetMenu(addon)
		if (not UIPanelWindows["Nurfed_OptionsFrame"]) then
			UIPanelWindows["Nurfed_OptionsFrame"] = { area = "center", pushable = 0, whileDead = 1 };
		end
		if (Nurfed_OptionsFrame:IsShown() and Nurfed_OptionsFrame.shown == addon) then
			HideUIPanel(Nurfed_OptionsFrame);
		else
			local title = string.gsub(addon, "_", " ");
			local version = getglobal(string.upper(addon).."_VERS");
			Nurfed_OptionsFrametitle:SetText(title);
			Nurfed_OptionsFrameversion:SetText(version);
			Nurfed_OptionsFrame.shown = addon;
			Nurfed_OptionsFrame.addon = string.gsub(addon, "Nurfed_", "");
			ShowUIPanel(Nurfed_OptionsFrame);
			UIFrameFadeIn(Nurfed_OptionsFrame, COMBOFRAME_FADE_IN);

			local menus = { Nurfed_OptionsFrame:GetChildren() };
			for _, menu in ipairs(menus) do
				if (menu:GetName()) then
					if (string.find(menu:GetName(), "^"..addon)) then
						menu:Show();
						Nurfed_OptionsFrame:SetWidth(menu.width);
						Nurfed_OptionsFrame:SetHeight(menu.height);
						Nurfed_OptionsFrameclose:Show();
						menu:SetWidth(menu.width - 12);
						menu:SetHeight(menu.height - 31);
						if (menu.page) then
							self:GetMenuPage(menu);
						end
					else
						menu:Hide();
					end
				end
			end
		end
	end

	function Nurfed_Options:GetMenuPage(menu)
		local i = 1;
		local page = getglobal(menu:GetName().."page"..i);
		while (page) do
			if (i == menu.page) then
				UIFrameFadeIn(page, COMBOFRAME_FADE_IN);
			else
				page:Hide();
			end
			i = i + 1;
			page = getglobal(menu:GetName().."page"..i);
		end
	end

	function Nurfed_Options:GetOption(addon, option)
		addon = string.upper("NURFED_"..addon);
		local player = UnitName("player").." - "..GetRealmName();
		if (not player or not getglobal(addon.."_SAVED")) then
			return;
		end
		local tbl = getglobal(addon.."_SAVED")[player];
		if (not tbl[option]) then
			local value = getglobal(addon.."_DEFAULT")[option];
			tbl[option] = value;
		end
		return tbl[option];
	end

	function Nurfed_Options:SetOption(addon, option, value, name, id)
		addon = string.upper("NURFED_"..addon);
		local player = UnitName("player").." - "..GetRealmName();
		local tbl = getglobal(addon.."_SAVED")[player];
		if (name and id) then
			tbl[option][name][id] = value;
		else
			tbl[option] = value;
		end
	end

	function Nurfed_Options:SetMultiOption(addon, option, name, value)
		addon = string.upper("NURFED_"..addon);
		local player = UnitName("player").." - "..GetRealmName();
		local tbl = getglobal(addon.."_SAVED")[player][option];
		tbl[name] = value;
	end

	-- Display
	local function optionInit()
		local text = getglobal(this:GetName().."text");
		text:SetText(this.text);
		if (this.right) then
			text:ClearAllPoints()
			text:SetPoint("RIGHT", this:GetName(), "LEFT", -1, 1);
		end
		if (this.color) then
			text:SetTextColor(this.color[1], this.color[2], this.color[3]);
		end
		if (this.option) then
			return Nurfed_Options:GetOption(Nurfed_OptionsFrame.addon, this.option);
		end
	end

	--Generic Button
	local function buttonOnEnter()
		this:SetBackdropColor(0, 0.75, 1, 0.75)
		getglobal(this:GetName().."text"):SetTextColor(1, 1, 1)
	end

	local function buttonOnLeave()
		this:SetBackdropColor(0, 0, 0, 0.75)
		getglobal(this:GetName().."text"):SetTextColor(0.65, 0.65, 0.65)
	end

	local function buttonOnShow()
		optionInit();
		local width = string.len(this.text);
		this:SetWidth(width*6 + 5);
	end

	local function buttonOnMouseDown()
		this:SetBackdropColor(1, 0, 0, 0.75);
	end

	local function buttonOnMouseUp()
		this:SetBackdropColor(0, 0.75, 1, 0.75);
	end

	-- Tabs
	local function tabOnShow()
		buttonOnShow();
		if (this.page == this:GetParent().page) then
			this.selected = true;
			this:SetBackdropColor(0, 0.85, 1, 0.75);
			getglobal(this:GetName().."text"):SetTextColor(1, 1, 1);
		else
			this.selected = nil;
			this:SetBackdropColor(0, 0, 0, 0.75);
			getglobal(this:GetName().."text"):SetTextColor(0.65, 0.65, 0.65);
		end
	end

	local function tabOnEnter()
		if (not this.selected) then
			this:SetBackdropColor(0, 0.75, 1, 0.75);
			getglobal(this:GetName().."text"):SetTextColor(1, 1, 1);
		end
	end

	local function tabOnLeave()
		if (not this.selected) then
			this:SetBackdropColor(0, 0, 0, 0.75);
			getglobal(this:GetName().."text"):SetTextColor(0.65, 0.65, 0.65);
		end
	end

	local function tabOnClick()
		local parent = this:GetParent();
		parent.page = this.page;

		local i = 1;
		local tab = getglobal(parent:GetName().."tab"..i);
		while(tab) do
			if (parent.page ~= tab.page) then
				tab.selected = nil;
				tab:SetBackdropColor(0, 0, 0, 0.75);
				getglobal(tab:GetName().."text"):SetTextColor(0.65, 0.65, 0.65);
			else
				tab.selected = true;
				tab:SetBackdropColor(0, 0.85, 1, 0.75);
				getglobal(tab:GetName().."text"):SetTextColor(1, 1, 1);
				Nurfed_Options:GetMenuPage(parent);
			end
			i = i + 1;
			tab = getglobal(parent:GetName().."tab"..i);
		end
	end

	-- Check Boxes
	local function checkText()
		if (not this.color) then
			local text = getglobal(this:GetName().."text");
			if (this:GetChecked()) then
				text:SetTextColor(1, 1, 1);
			else
				text:SetTextColor(0.65, 0.65, 0.65);
			end
		end
	end

	local function checkOnShow()
		if (this:IsShown()) then
			local option = optionInit();
			if (this.init) then
				this:SetChecked(this.init);
			else
				this:SetChecked(option);
			end
			checkText();
		end
	end

	local function checkOnClick()
		local value;
		if (this:GetChecked()) then
			value = 1;
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			value = 0;
			PlaySound("igMainMenuOptionCheckBoxOff");
		end
		if (this.option) then
			Nurfed_Options:SetOption(Nurfed_OptionsFrame.addon, this.option, value);
			if (this.func) then
				this.func();
			end
		elseif (this.id and this:GetParent().selected) then
			Nurfed_Options:SetOption(Nurfed_OptionsFrame.addon, this:GetParent().option, value, this:GetParent().selected, this.id);
			if (this:GetParent().func) then
				this:GetParent().func();
			end
		end
		checkText();
	end

	--Sliders
	local function sliderOnShow()
		if (this:IsShown()) then
			local option = optionInit();
			local max = getglobal(this:GetName().."high");
			local min = getglobal(this:GetName().."low");
			max:SetText(this.max);
			min:SetText(this.min);
			this:SetMinMaxValues(this.min, this.max);
			this:SetValueStep(this.step);
			if (this.init) then
				this:SetValue(this.init);
			elseif (option) then
				this:SetValue(option);
			end
		end
	end

	local function sliderOnValueChanged()
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

	local function sliderOnMouseUp()
		local value = this:GetValue();
		if (this.option) then
			Nurfed_Options:SetOption(Nurfed_OptionsFrame.addon, this.option, value);
			if (this.func) then
				this.func();
			end
		elseif (this.id and this:GetParent().selected) then
			Nurfed_Options:SetOption(Nurfed_OptionsFrame.addon, this:GetParent().option, value, this:GetParent().selected, this.id);
			if (this:GetParent().func) then
				this:GetParent().func();
			end
		end
	end

	-- Color Swatches
	local function swatchSetColor(frame)
		local option = frame.option;
		local r,g,b = ColorPickerFrame:GetColorRGB();
		local a = OpacitySliderFrame:GetValue();
		local swatch = getglobal(frame:GetName().."bg");
		swatch:SetVertexColor(r, g, b);
		frame.r = r;
		frame.g = g;
		frame.b = b;
		Nurfed_Options:SetOption(Nurfed_OptionsFrame.addon, frame.option, { r, g, b, a });
		if (frame.func) then
			frame.func();
		end
	end

	local function swatchCancelColor(frame, prev)
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
		Nurfed_Options:SetOption(Nurfed_OptionsFrame.addon, frame.option, { r, g, b, a });
		if (frame.func) then
			frame.func();
		end
	end

	local function swatchOnShow()
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
			this.swatchFunc = function() swatchSetColor(frame) end;
			this.cancelFunc = function(x) swatchCancelColor(frame, x) end;
			if (frame.opacity) then
				this.hasOpacity = frame.opacity;
				this.opacityFunc = function() swatchSetColor(frame) end;
				this.opacity = option[4];
			end
		end
	end

	local function swatchOpenColorPicker()
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

	-- Input
	local function inputOnShow()
		local option = optionInit();
		if (not option) then
			return;
		end
		local inputtext = getglobal(this:GetName().."input");
		inputtext:SetText(option);
	end

	local function inputOnClick()
		local inputtext = getglobal(this:GetParent():GetName().."input");
		if (not inputtext:GetText() or inputtext:GetText() == "") then
			return;
		end
		Nurfed_Options:SetOption(Nurfed_OptionsFrame.addon, this:GetParent().option, inputtext:GetText());
		inputtext:ClearFocus();
	end

	--Input Select
	local function inputselectSetOptions(opt, frame)
		if (not frame) then
			frame = this:GetParent();
		end
		local option = Nurfed_Options:GetOption(Nurfed_OptionsFrame.addon, frame.option);
		local children = { frame:GetChildren() };
		for _, child in ipairs(children) do
			local objtype, value;
			if (child.id) then
				objtype = child:GetObjectType();
				if (objtype == "Slider") then
					child:SetValue(option[opt][child.id]);
				elseif (objtype == "CheckButton") then
					child:SetChecked(option[opt][child.id]);
				end
			end
		end
	end

	local function inputselectUpdate(frame, pre)
		local option = Nurfed_Options:GetOption(Nurfed_OptionsFrame.addon, frame.option);
		local i = 1;
		local button = getglobal(frame:GetName().."button"..i);
		local text = getglobal(frame:GetName().."button"..i.."text");
		for opt in option do
			if (text) then
				if (pre) then
					text:SetText(pre..opt);
					button.pre = pre;
				else
					text:SetText(opt);
				end
				if (button.selected) then
					inputselectSetOptions(opt, frame);
				end
			end
			i = i + 1;
			text = getglobal(frame:GetName().."button"..i.."text");
			button = getglobal(frame:GetName().."button"..i);
		end
		while (i <= 10) do
			text = getglobal(frame:GetName().."button"..i.."text");
			text:SetText(nil);
			i = i + 1;
		end
	end

	local function inputselectOnShow()
		local option = optionInit();
		if (not option) then
			return;
		end
		inputselectUpdate(this, this.pre);
	end

	local function inputselectGetOptions()
		local tbl = {};
		local children = { this:GetParent():GetChildren() };
		for _, child in ipairs(children) do
			local objtype, value;
			if (child.id) then
				objtype = child:GetObjectType();
				if (objtype == "Slider") then
					tbl[child.id] = child:GetValue();
				elseif (objtype == "CheckButton") then
					if (child:GetChecked()) then
						tbl[child.id] = 1;
					else
						tbl[child.id] = 0;
					end
				end
			end
		end
		return tbl;
	end

	local function inputselectOnEnterPressed()
		if (not this:GetText() or this:GetText() == "") then
			return;
		end
		local value = inputselectGetOptions();
		Nurfed_Options:SetMultiOption(Nurfed_OptionsFrame.addon, this:GetParent().option, this:GetText(), value);
		inputselectUpdate(this:GetParent());
		this:SetText("");
		if (this:GetParent().func) then
			this:GetParent().func();
		end
	end

	local function inputremoveOnClick()
		for i = 1, 10 do
			local button = getglobal(this:GetParent():GetName().."button"..i);
			local highlight = getglobal(button:GetName().."highlight");
			local text = getglobal(button:GetName().."text");
			local option = text:GetText();
			if (option) then
				if (this:GetParent().pre) then
					option = string.gsub(option, this:GetParent().pre, "");
					option = tonumber(option);
				end
				if (button.selected) then
					Nurfed_Options:SetMultiOption(Nurfed_OptionsFrame.addon, this:GetParent().option, option, nil);
					button.selected = nil;
					highlight:Hide();
				end
			end
		end
		inputselectUpdate(this:GetParent(), this:GetParent().pre);
		if (this:GetParent().func) then
			this:GetParent().func();
		end
	end

	local function inputupdateOnClick()
		local value = inputselectGetOptions();
		for i = 1, 10 do
			local button = getglobal(this:GetParent():GetName().."button"..i);
			local text = getglobal(button:GetName().."text");
			local option = text:GetText();
			if (option) then
				if (this:GetParent().pre) then
					option = string.gsub(option, this:GetParent().pre, "");
					option = tonumber(option);
				end
				if (button.selected) then
					Nurfed_Options:SetMultiOption(Nurfed_OptionsFrame.addon, this:GetParent().option, option, value);
				end
			end
		end
		if (this:GetParent().func) then
			this:GetParent().func();
		end
	end

	local function inputaddOnClick()
		local value = inputselectGetOptions();
		local option = Nurfed_Options:GetOption(Nurfed_OptionsFrame.addon, this:GetParent().option);
		if (option) then
			local nextopt = table.getn(option) + 1;
			Nurfed_Options:SetMultiOption(Nurfed_OptionsFrame.addon, this:GetParent().option, nextopt, value);
			inputselectUpdate(this:GetParent(), this:GetParent().pre);
			if (this:GetParent().func) then
				this:GetParent().func();
			end
		end
	end

	local function inputselectbuttonOnClick()
		local text = getglobal(this:GetName().."text");
		local option = text:GetText();
		if (not option) then
			return;
		end
		for i = 1, 10 do
			local button = getglobal(this:GetParent():GetName().."button"..i);
			if (this:GetName() ~= button:GetName()) then
				local highlight = getglobal(button:GetName().."highlight");
				button.selected = nil;
				highlight:Hide();
			end
		end
		if (this.pre) then
			option = string.gsub(option, this.pre, "");
			option = tonumber(option);
		end
		this:GetParent().selected = nil;
		if (option) then
			local highlight = getglobal(this:GetName().."highlight");
			if (highlight:IsVisible()) then
				highlight:Hide();
				this.selected = nil;
			else
				highlight:Show();
				this.selected = true;
				this:GetParent().selected = option;
				inputselectSetOptions(option);
			end
		end
	end

	local tbl = {
		Nurfed_OptionButton = {
			type = "Button",
			size = { 30, 18 },
			Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
			BackdropColor = { 0, 0, 0, 0.75 },
			children = {
				text = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = "all",
					Font = { NRF_FONT.."framd.ttf", 9, "OUTLINE" },
					JustifyH = "CENTER",
					TextColor = { 0.65, 0.65, 0.65 },
				},
			},
			OnMouseDown = function() buttonOnMouseDown() end,
			OnMouseUp = function() buttonOnMouseUp() end,
			OnEnter = function() buttonOnEnter() end,
			OnLeave = function() buttonOnLeave() end,
			OnShow = function() buttonOnShow() end,
		},
		Nurfed_OptionTab = {
			type = "Button",
			size = { 75, 18 },
			Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
			BackdropColor = { 0, 0, 0, 0 },
			children = {
				text = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = "all",
					Font = { NRF_FONT.."framd.ttf", 9, "OUTLINE" },
					JustifyH = "CENTER",
					TextColor = { 0.5, 0.5, 0.5 },
				},
			},
			OnShow = function() tabOnShow() end,
			OnMouseDown = function() buttonOnMouseDown() end,
			OnMouseUp = function() buttonOnMouseUp() end,
			OnClick = function() tabOnClick() end,
			OnEnter = function() tabOnEnter() end,
			OnLeave = function() tabOnLeave() end,
		},
		Nurfed_OptionCheck = {
			type = "CheckButton",
			size = { 18, 18 },
			NormalTexture = "Interface\\Buttons\\UI-CheckBox-Up",
			PushedTexture = "Interface\\Buttons\\UI-CheckBox-Down",
			HighlightTexture = "Interface\\Buttons\\UI-CheckBox-Highlight",
			CheckedTexture = "Interface\\Buttons\\UI-CheckBox-Check",
			DisabledCheckedTexture = "Interface\\Buttons\\UI-CheckBox-Check-Disabled",
			children = {
				text = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = { "LEFT", "$parent", "RIGHT", 1, 1 },
					Font = { NRF_FONT.."framd.ttf", 11, "NONE" },
					JustifyH = "LEFT",
					TextColor = { 0.5, 0.5, 0.5 },
				},
			},
			OnShow = function() checkOnShow() end,
			OnClick = function() checkOnClick() end,
		},
		Nurfed_OptionSlider = {
			type = "Slider",
			size = { 128, 17 },
			Backdrop = { bgFile = "Interface\\Buttons\\UI-SliderBar-Background", edgeFile = "Interface\\Buttons\\UI-SliderBar-Border", tile = true, tileSize = 8, edgeSize = 8, insets = { left = 3, right = 3, top = 6, bottom = 6 }, },
			ThumbTexture = "Interface\\Buttons\\UI-SliderBar-Button-Horizontal",
			Orientation = "HORIZONTAL",
			children = {
				text = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = { "BOTTOM", "$parent", "TOP", 0, 1 },
					Font = { NRF_FONT.."framd.ttf", 11, "NONE" },
					JustifyH = "CENTER",
					TextColor = { 1, 1, 1 },
				},
				high = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = { "TOPRIGHT", "$parent", "BOTTOMRIGHT", 0, 1 },
					Font = { NRF_FONT.."framd.ttf", 10, "NONE" },
					JustifyH = "CENTER",
					TextColor = { 1, 1, 0 },
				},
				low = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = { "TOPLEFT", "$parent", "BOTTOMLEFT", 0, 1 },
					Font = { NRF_FONT.."framd.ttf", 10, "NONE" },
					JustifyH = "CENTER",
					TextColor = { 1, 1, 0 },
				},
				value = {
					type = "FontString",
					layer = "ARTWORK",
					Font = { NRF_FONT.."framd.ttf", 10, "NONE" },
					JustifyH = "CENTER",
					TextColor = { 0, 1, 0 },
				},
			},
			OnShow = function() sliderOnShow() end,
			OnMouseUp = function() sliderOnMouseUp() end,
			OnValueChanged = function() sliderOnValueChanged() end,
		},
		Nurfed_OptionColorSwatch= {
			type = "Button",
			size = { 16, 16 },
			children = {
				bg = {
					type = "Texture",
					Texture = "Interface\\ChatFrame\\ChatFrameColorSwatch",
					size = { 16, 16 },
					layer = "BACKGROUND",
					Anchor = { "CENTER", "$parent", "CENTER", 0, 0 },
					VertexColor = { 1, 1, 1 },
				},
				text = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = { "LEFT", "$parent", "RIGHT", 1, 0 },
					Font = { NRF_FONT.."framd.ttf", 11, "NONE" },
					JustifyH = "LEFT",
					TextColor = { 1, 1, 1 },
				},
			},
			OnShow = function() swatchOnShow() end,
			OnClick = function() swatchOpenColorPicker() end,
		},
		Nurfed_OptionInput = {
			type = "Frame",
			size = { 130, 30 },
			children = {
				text = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, 0 },
					Font = { NRF_FONT.."framd.ttf", 11, "NONE" },
					JustifyH = "LEFT",
					TextColor = { 1, 1, 1 },
				},
				input = {
					type = "EditBox",
					size = { 100, 18 },
					AutoFocus = false,
					Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
					BackdropColor = { 0, 0.2, 0.2, 0.75 },
					Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 0, 0 },
					Font = { NRF_FONT.."framd.ttf", 10, "NONE" },
					TextInsets = { 3, 9, 0, 0 },
					OnEnterPressed = function() inputOnClick() end,
					OnEscapePressed = function() this:ClearFocus() end,
				},
				set = {
					template = "Nurfed_OptionButton",
					properties = {
						Anchor = { "LEFT", "$parentinput", "RIGHT", 1, 0 },
						OnClick = function() inputOnClick() end,
						vars = {
							text = "Set",
						},
					},
				},
			},
			OnShow = function() inputOnShow() end,
		},
		Nurfed_OptionInputSelectButton = {
			type = "Button",
			size = { 80, 10 },
			children = {
				highlight = {
					type = "Texture",
					layer = "BACKGROUND",
					Texture = "Interface\\QuestFrame\\UI-QuestTitleHighlight",
					BlendMode = "ADD",
					Anchor = "all",
					Alpha = 0.75;
					Hide = true;
				},
				text = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = "all",
					Font = { NRF_FONT.."framd.ttf", 10, "NONE" },
					JustifyH = "LEFT",
					TextColor = { 1, 1, 1 },
				},
			},
			OnClick = function() inputselectbuttonOnClick() end,
		},
		Nurfed_OptionNumSelect = {
			type = "Frame",
			size = { 106, 158 },
			Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 12, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
			BackdropColor = { 0, 0, 0, 0 },
			children = {
				text = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = { "TOP", "$parent", "TOP", 0, -4 },
					Font = { NRF_FONT.."framd.ttf", 11, "NONE" },
					JustifyH = "CENTER",
					TextColor = { 1, 1, 1 },
				},
				button1 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, -15 },
					},
				},
				button2 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton1", "BOTTOMLEFT", 0, -1 },
					},
				},
				button3 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton2", "BOTTOMLEFT", 0, -1 },
					},
				},
				button4 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton3", "BOTTOMLEFT", 0, -1 },
					},
				},
				button5 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton4", "BOTTOMLEFT", 0, -1 },
					},
				},
				button6 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton5", "BOTTOMLEFT", 0, -1 },
					},
				},
				button7 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton6", "BOTTOMLEFT", 0, -1 },
					},
				},
				button8 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton7", "BOTTOMLEFT", 0, -1 },
					},
				},
				button9 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton8", "BOTTOMLEFT", 0, -1 },
					},
				},
				button10 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton9", "BOTTOMLEFT", 0, -1 },
					},
				},
				--[[
				update = {
					template = "Nurfed_OptionButton",
					properties = {
						FrameStrata = "MEDIUM",
						Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 2, 2 },
						vars = {
							text = "Update",
						},
						OnClick = function() inputupdateOnClick() end,
					},
				},
				]]
				add = {
					template = "Nurfed_OptionButton",
					properties = {
						FrameStrata = "MEDIUM",
						Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 2, 2 },
						--Anchor = { "BOTTOM", "$parent", "BOTTOM", 0, 2 },
						vars = {
							text = "Add",
						},
						OnClick = function() inputaddOnClick() end,
					},
				},
				remove = {
					template = "Nurfed_OptionButton",
					properties = {
						FrameStrata = "MEDIUM",
						Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -2, 2 },
						vars = {
							text = REMOVE,
						},
						OnClick = function() inputremoveOnClick() end,
					},
				},
			},
			OnShow = function() inputselectOnShow() end,
		},
		Nurfed_OptionInputSelect = {
			type = "Frame",
			size = { 106, 170 },
			Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 12, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
			BackdropColor = { 0, 0, 0, 0 },
			children = {
				text = {
					type = "FontString",
					layer = "ARTWORK",
					Anchor = { "TOP", "$parent", "TOP", 0, -4 },
					Font = { NRF_FONT.."framd.ttf", 11, "NONE" },
					JustifyH = "CENTER",
					TextColor = { 1, 1, 1 },
				},
				input = {
					type = "EditBox",
					size = { 100, 18 },
					AutoFocus = false,
					Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 8, insets = { left = 2, right = 2, top = 2, bottom = 2 }, },
					BackdropColor = { 0, 0.2, 0.2, 0.75 },
					Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 3, -15 },
					Font = { NRF_FONT.."framd.ttf", 10, "NONE" },
					TextInsets = { 3, 9, 0, 0 },
					OnEnterPressed = function() inputselectOnEnterPressed() end,
					OnEscapePressed = function() this:ClearFocus() end,
				},
				button1 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentinput", "BOTTOMLEFT", 3, -2 },
					},
				},
				button2 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton1", "BOTTOMLEFT", 0, -1 },
					},
				},
				button3 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton2", "BOTTOMLEFT", 0, -1 },
					},
				},
				button4 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton3", "BOTTOMLEFT", 0, -1 },
					},
				},
				button5 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton4", "BOTTOMLEFT", 0, -1 },
					},
				},
				button6 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton5", "BOTTOMLEFT", 0, -1 },
					},
				},
				button7 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton6", "BOTTOMLEFT", 0, -1 },
					},
				},
				button8 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton7", "BOTTOMLEFT", 0, -1 },
					},
				},
				button9 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton8", "BOTTOMLEFT", 0, -1 },
					},
				},
				button10 = {
					template = "Nurfed_OptionInputSelectButton",
					properties = {
						Anchor = { "TOPLEFT", "$parentbutton9", "BOTTOMLEFT", 0, -1 },
					},
				},
				--[[
				update = {
					template = "Nurfed_OptionButton",
					properties = {
						FrameStrata = "MEDIUM",
						Anchor = { "BOTTOMLEFT", "$parent", "BOTTOMLEFT", 2, 2 },
						vars = {
							text = "Update",
						},
						OnClick = function() inputupdateOnClick() end,
					},
				},
				]]
				remove = {
					template = "Nurfed_OptionButton",
					properties = {
						FrameStrata = "MEDIUM",
						Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -2, 2 },
						vars = {
							text = REMOVE,
						},
						OnClick = function() inputremoveOnClick() end,
					},
				},
			},
			OnShow = function() inputselectOnShow() end,
		},
	};

	local menutbl = {
		type = "Frame",
		FrameStrata = "LOW",
		Anchor = { "CENTER", "$parent", "CENTER", 150, 0 },
		Backdrop = { bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }, },
		BackdropColor = { 0, 0, 0, 0.75 },
		children = {
			titlebg = {
				type = "Texture",
				size = { 340, 20 },
				layer = "BACKGROUND",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 5, -5 },
				Texture = NRF_IMG.."statusbar6.tga",
				Gradient = { "HORIZONTAL", 0, 0.75, 1, 0, 0, 0.2 },
			},
			title = {
				type = "FontString",
				size = { 150, 12 },
				layer = "ARTWORK",
				Anchor = { "TOPLEFT", "$parent", "TOPLEFT", 6, -8 },
				Font = { NRF_FONT.."framd.ttf", 12, "OUTLINE" },
				JustifyH = "LEFT",
				TextColor = { 1, 1, 1 },
			},
			version = {
				type = "FontString",
				size = { 150, 12 },
				layer = "ARTWORK",
				Anchor = { "TOPRIGHT", "$parent", "TOPRIGHT", -6, -8 },
				Font = { NRF_FONT.."framd.ttf", 12, "OUTLINE" },
				JustifyH = "RIGHT",
				TextColor = { 1, 1, 1 },
			},
			close = {
				template = "Nurfed_OptionButton",
				properties = {
					FrameStrata = "MEDIUM",
					Anchor = { "BOTTOMRIGHT", "$parent", "BOTTOMRIGHT", -4, 4 },
					vars = {
						text = CLOSE,
					},
					OnClick = function() HideUIPanel(Nurfed_OptionsFrame) end,
				},
			},
		},
		Hide = true,
	};

	for temp, spec in pairs(tbl) do
		framelib:CreateTemplate(temp, spec);
	end
	framelib:ObjectInit("Nurfed_OptionsFrame", menutbl, UIParent);
	tbl = nil;
	menutbl = nil;
end