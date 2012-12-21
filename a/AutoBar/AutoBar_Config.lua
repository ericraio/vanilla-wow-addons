--
--  AutoBar
--
--  Config functions
-- 
--  Author: Marc aka Saien on Hyjal
--  http://64.168.251.69/wow
--

UIPanelWindows["AutoBar_Options"] = { area = "center", pushable = 99, whileDead = 1 };

StaticPopupDialogs["AUTOBAR_ITEMENTRY"] = {
	text = "Enter Item Name or ItemID:",
	button1 = TEXT(ACCEPT),
	button2 = TEXT(CANCEL),
	hasEditBox = 1, 
	maxLetters = 50,
	hasWideEditBox = 1,
	OnAccept = function()
		local editBox = getglobal(this:GetParent():GetName().."WideEditBox");
		local text = editBox:GetText();
		if (tonumber(text) and tonumber(text) > 0) then
			text = tonumber(text);
		end
		local tmp = AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting];
		if (type(tmp) == "table") then
			AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting][AutoBar_Options_ConfigButton_ChooseCategory.editting] = text;
		else
			AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting] = text;
		end
		AutoBar_Options_ConfigButton_ChooseCategory:Hide();
	end,
	OnShow = function()
		local editBox = getglobal(this:GetName().."WideEditBox");
		local tmp = AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting];
		local txt;
		if (type(tmp) == "table") then
			txt = AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting][AutoBar_Options_ConfigButton_ChooseCategory.editting];
		else
			txt = AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting];
		end
		if (txt) then
			editBox:SetText(txt);
		else
			editBox:SetText("");
		end
		editBox:SetFocus();
	end,
	OnHide = function()
		local editBox = getglobal(this:GetName().."WideEditBox");
		if (ChatFrameEditBox:IsVisible()) then 
			ChatFrameEditBox:SetFocus();
		end
		editBox:SetText("");
	end,
	OnCancel = function()
		this:GetParent():Hide();
	end,
	EditBoxOnEnterPressed = function ()
		StaticPopupDialogs["AUTOBAR_ITEMENTRY"].OnAccept();
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function ()
		this:GetParent():Hide();
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
};

------------------------------------
------------------------------------
------------------------------------

local function AutoBar_Config_SlashCmd(msg)
	--[[
	msg = string.lower (msg);
	local firstword, restwords;
	local idx = string.find(msg," ");
	if (idx) then
		firstword = string.sub(msg,1,idx-1);
		restwords = string.sub(msg,idx+1);
	else
		firstword = msg;
	end
	]]

	AutoBar_ToggleConfig();
end

------------------------------------

function AutoBar_Config_OnLoad()
	SLASH_AUTOBAR1 = "/autobar";
	SlashCmdList["AUTOBAR"] = function (msg)
		AutoBar_Config_SlashCmd(msg);
	end
end

function AutoBar_Config_OnShow()
	local idx,button,hotkey;
	for idx = 1, AUTOBAR_MAXBUTTONS, 1 do
		button = getglobal("AutoBar_Options_Buttons_Button"..idx);
		hotkey = getglobal("AutoBar_Options_Buttons_Button"..idx.."HotKey");
		count  = getglobal("AutoBar_Options_Buttons_Button"..idx.."Count");
		icon   = getglobal("AutoBar_Options_Buttons_Button"..idx.."Icon");
		hotkey:SetText("#"..idx);
		if (AutoBar_Config[AutoBar_Player].buttons[idx]) then
			local buttoninfo = AutoBar_Config[AutoBar_Player].buttons[idx];
			icon:SetTexture(AutoBar_GetTexture(buttoninfo));
			count:SetText("");
		else
			count:SetText("Empty");
			icon:SetTexture("");
		end
	end
	AutoBar_Options_Bar_Sliders();
	AutoBar_Options_CheckBox_Setup();
end

function AutoBar_Config_ButtonSetTooltip()
	local buttoninfo;
	local preamble, extended;
	if (this.itemid) then
		local name,itemid = GetItemInfo(this.itemid);
		if (name and itemid) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetHyperlink(itemid);
		else
			local tmp = "item:"..this.itemid..":0:0:0";
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetHyperlink("item:"..this.itemid..":0:0:0");
		end
		return;
	end
	if (this.category) then
		buttoninfo = this.category;
		extended=true;
	elseif (string.find(this:GetName(), "^AutoBar_Options_Buttons_Button")) then
		buttoninfo = AutoBar_Config[AutoBar_Player].buttons[this:GetID()];
		extended=true;
		preamble=true;
	elseif (string.find(this:GetName(), "^AutoBar_Options_ConfigButton_Button")) then
		extended=true;
		local tmp = AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting];
		if (type(tmp) == "table") then
			buttoninfo = tmp[this:GetID()]
		else
			buttoninfo = tmp;
		end
	end
	local message = "";
	if (buttoninfo == "EMPTY") then
	elseif (type(buttoninfo) == "table") then
		if (preamble) then message = "Multi Category Button\n"; end
		local idx,cat;
		for idx,cat in buttoninfo do
			if (type(cat) == "string" and AutoBar_Category_Info[cat]) then
				message = message.."\n"..AutoBar_Category_Info[cat].description;
			elseif (type(cat) == "number") then
				local name = GetItemInfo(cat);
				if (name) then
					message = message.."\n"..name.." (Custom Item by ID)";
				else
					message = message.."\n(Item ID not recognized)";
				end
			else
				message = message.."\n"..cat.." (Custom Item by Name)";
			end
		end
	elseif (type(buttoninfo) == "string" and AutoBar_Category_Info[buttoninfo]) then
		if (preamble) then message = "Single Category Button\n\n"; end
		message = message..AutoBar_Category_Info[buttoninfo].description;
		if (extended) then
			message = message.."\n";
			if (AutoBar_Category_Info[buttoninfo].notusable) then
				message = message.."\nNot directly usable.";
			end
			if (AutoBar_Category_Info[buttoninfo].targetted) then
				if (AutoBar_Category_Info[buttoninfo].targetted == "WEAPON") then
					message = message.."\nWeapon Target\n(Left click main weapon\nRight click offhand weapon.)";
				else
					message = message.."\nTargetted.";
				end
			end
			if (AutoBar_Category_Info[buttoninfo].noncombat) then
				message = message.."\nNon combat only.";
			end
			if (AutoBar_Category_Info[buttoninfo].combatonly) then
				message = message.."\nCombat only.";
			end
			if (AutoBar_Category_Info[buttoninfo].location) then
				message = message.."\nLocation: "..AutoBar_Category_Info[buttoninfo].location..".";
			end
			if (AutoBar_Category_Info[buttoninfo].limit) then
				message = message.."\nLimited Usage: ";
				if (AutoBar_Category_Info[buttoninfo].limit.downhp) then
					message = message.."Require HP restore";
					if (AutoBar_Category_Info[buttoninfo].limit.downmana) then
						message = message..", ";
					end
				end
				if (AutoBar_Category_Info[buttoninfo].limit.downmana) then
					message = message.."Require Mana restore";
				end
			end

		end
	elseif (type(buttoninfo) == "string" and not AutoBar_Category_Info[buttoninfo]) then
		if (preamble) then message = "Single Item Button\n\n"; end
		message = message..buttoninfo.." (Custom Item by Name)";
	elseif (type(buttoninfo) == "number") then
		if (preamble) then message = "Single Item Button\n\n"; end
		local name = GetItemInfo(buttoninfo);
		if (name) then
			message = message..name.." (Custom Item by ID)";
		else
			message = message.."(Item ID not recognized)";
		end
	end

	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(message);
end

function AutoBar_Config_Button_Edit(num)
	if (not num) then num = AutoBar_Options_ConfigButton.editting; end
	local buttoninfo = AutoBar_Config[AutoBar_Player].buttons[num];
	AutoBar_Options_ConfigButton.editting = num;
	AutoBar_Options_ConfigButton:Show();
	AutoBar_Options_ConfigButtonTitleText:SetText("Edit Button #"..num);
	local idx,tmp,i;
	---
	if (type(buttoninfo) == "table") then
		tmp = 0;
		for idx = 1, 8, 1 do
			if (AutoBar_Config[AutoBar_Player].buttons[num][idx]) then
				tmp = idx;
			end
		end
		idx = 1;
		while (idx < tmp) do 
			if (AutoBar_Config[AutoBar_Player].buttons[num][idx]) then
				idx = idx + 1;
			else
				AutoBar_Config[AutoBar_Player].buttons[num][idx] = 
				AutoBar_Config[AutoBar_Player].buttons[num][idx+1];
				AutoBar_Config[AutoBar_Player].buttons[num][idx+1] = nil;
				tmp = 0;
				for i = 1, 8, 1 do
					if (AutoBar_Config[AutoBar_Player].buttons[num][i]) then
						tmp = i;
					end
				end
			end
		end
	end
	---
	for idx = 1, 8, 1 do
		local button   = getglobal("AutoBar_Options_ConfigButton_Button"..idx);
		local hotkey   = getglobal("AutoBar_Options_ConfigButton_Button"..idx.."HotKey");
		local count    = getglobal("AutoBar_Options_ConfigButton_Button"..idx.."Count");
		local icon     = getglobal("AutoBar_Options_ConfigButton_Button"..idx.."Icon");
		local move     = getglobal("AutoBar_Options_ConfigButton_Move"..idx);
		local moveup   = getglobal("AutoBar_Options_ConfigButton_Move"..idx.."_Up");
		local movedown = getglobal("AutoBar_Options_ConfigButton_Move"..idx.."_Down");
		local checkbox = getglobal("AutoBar_Options_ConfigButton_Option"..idx);
		local checkboxtext = getglobal("AutoBar_Options_ConfigButton_Option"..idx.."Text");

		hotkey:Hide();
		if (type(buttoninfo) == "table") then
			if (buttoninfo[idx]) then
				move:Show();
				count:SetText("");
				if (AutoBar_Category_Info[buttoninfo[idx]] and AutoBar_Category_Info[buttoninfo[idx]].targetted) then
					checkbox:Show();
					checkboxtext:SetText("Smart Self Cast");
					if (AutoBar_Config[AutoBar_Player].smartselfcast and AutoBar_Config[AutoBar_Player].smartselfcast[buttoninfo[idx]]) then
						checkbox:SetChecked(1);
					else
						checkbox:SetChecked(0);
					end
				else
					checkbox:Hide();
				end
				if (idx == 1) then
					moveup:Hide();
				else
					moveup:Show();
				end
				if (buttoninfo[idx+1]) then
					movedown:Show();
				else
					movedown:Hide();
				end
			else
				move:Hide();
				count:SetText("Empty");
				checkbox:Hide();
			end
			icon:SetTexture(AutoBar_GetTexture(buttoninfo[idx]));
			button:Show();
		else
			move:Hide();
			if (idx == 1) then
				icon:SetTexture(AutoBar_GetTexture(buttoninfo));
				button:Show();
				if (buttoninfo) then
					count:SetText("");
					if (AutoBar_Category_Info[buttoninfo] and AutoBar_Category_Info[buttoninfo].targetted) then
						checkbox:Show();
						checkboxtext:SetText("Smart Self Cast");
						if (AutoBar_Config[AutoBar_Player].smartselfcast and AutoBar_Config[AutoBar_Player].smartselfcast[buttoninfo]) then
							checkbox:SetChecked(1);
						else
							checkbox:SetChecked(0);
						end
					else
						checkbox:Hide();
					end
				else
					count:SetText("Empty");
					checkbox:Hide();
				end
			else
				button:Hide();
				checkbox:Hide();
			end
		end
	end
	---
	if (type(buttoninfo) == "table") then
		AutoBar_Options_ConfigButton_ConvertButton:SetText("Convert to Single Item");
	else
		AutoBar_Options_ConfigButton_ConvertButton:SetText("Convert to Multi Item");
	end
end

local function AutoBar_ConfigButton_OnClick(mousebutton)
	local tmp = AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting];
	if (type(tmp) == "table") then
		AutoBar_Options_ConfigButton_ChooseCategory.editting = this:GetID();
	else
		AutoBar_Options_ConfigButton_ChooseCategory.editting = nil;
	end
	AutoBar_Options_ConfigButton_ChooseCategory:Show();
end

local function AutoBar_ConfigButton_ChooseCategory_OnClick(mousebutton)
	if (IsShiftKeyDown()) then
		if (AutoBar_Options_ConfigButton_ChooseCategory.categoryexplore) then
			AutoBar_Options_ConfigButton_ChooseCategory.categoryexplore = nil;
			this:GetParent():Hide();
		else
			local category = this.category;
			if (category == "EMPTY") then category = nil; end
			if (category) then
				AutoBar_Options_ConfigButton_ChooseCategory.categoryexplore = category;
				AutoBar_Config_ButtonChooseCategory_OnShow();
			end
		end
	else
		local category = this.category;
		if (category == "EMPTY") then category = nil; end
		if (AutoBar_Options_ConfigButton_ChooseCategory.editting) then
			AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting][AutoBar_Options_ConfigButton_ChooseCategory.editting] = category;
		else
			AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting] = category;
		end
		AutoBar_Options_ConfigButton_ChooseCategory.categoryexplore = nil;
		this:GetParent():Hide();
	end
end
	
function AutoBar_Config_ButtonOnClick(mousebutton)
	if (string.find(this:GetName(), "^AutoBar_Options_Buttons_Button")) then
		return AutoBar_Config_Button_Edit(this:GetID());
	elseif (string.find(this:GetName(), "^AutoBar_Options_ConfigButton_Button")) then
		return AutoBar_ConfigButton_OnClick(mousebutton);
	elseif (string.find(this:GetName(), "^AutoBar_Options_ConfigButton_ChooseCategory_Button")) then
		return AutoBar_ConfigButton_ChooseCategory_OnClick(mousebutton);
	end
end

function AutoBar_Config_Button_ConvertOnClick()
	local buttoninfo = AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting];
	if (type(buttoninfo) == "table") then
		local tmp = buttoninfo[1];
		AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting] = tmp;
	else
		local tmp = buttoninfo;
		AutoBar_Config[AutoBar_Player].buttons[AutoBar_Options_ConfigButton.editting] = { tmp };
	end
	AutoBar_Config_Button_Edit(AutoBar_Options_ConfigButton.editting);
end

function AutoBar_Config_ButtonChooseCategory_OnShow()
	if (AutoBar_Options_ConfigButton_ChooseCategory.categoryexplore and not AutoBar_Category_Info[AutoBar_Options_ConfigButton_ChooseCategory.categoryexplore]) then
		AutoBar_Options_ConfigButton_ChooseCategory.categoryexplore = nil;
	end
	if (AutoBar_Options_ConfigButton_ChooseCategory.categoryexplore) then
		AutoBar_Options_ConfigButton_ChooseCategory_HintText1:Hide();
		local category = AutoBar_Options_ConfigButton_ChooseCategory.categoryexplore;

		FauxScrollFrame_Update(AutoBar_Options_ConfigButton_ChooseCategory_Scroll, table.getn(AutoBar_Category_Info[category].items), 7, 36);
		local offset = FauxScrollFrame_GetOffset(AutoBar_Options_ConfigButton_ChooseCategory_Scroll);
		local idx,name,texture;
		for idx = 1, 7, 1 do
			local button = getglobal("AutoBar_Options_ConfigButton_ChooseCategory_Button"..idx);
			local hotkey = getglobal("AutoBar_Options_ConfigButton_ChooseCategory_Button"..idx.."HotKey");
			local count  = getglobal("AutoBar_Options_ConfigButton_ChooseCategory_Button"..idx.."Count");
			local icon   = getglobal("AutoBar_Options_ConfigButton_ChooseCategory_Button"..idx.."Icon");
			local text   = getglobal("AutoBar_Options_ConfigButton_ChooseCategory_Text"..idx);
			button.category = nil;
			if (AutoBar_Category_Info[category].items[idx+offset]) then
				if (type(AutoBar_Category_Info[category].items[idx+offset]) == "number") then
					name,_,_,_,_,_,_,_,texture = GetItemInfo(AutoBar_Category_Info[category].items[idx+offset]);
					if (not name) then
						name = "(Not Found: Item "..AutoBar_Category_Info[category].items[idx+offset]..")";
						texture = "Interface\\Icons\\INV_Misc_Gift_01";
					elseif (not texture) then
						texture = "Interface\\Icons\\INV_Misc_Gift_02";
					end
				else
					texture = "Interface\\Icons\\INV_Misc_Gift_03";
					name = AutoBar_Category_Info[category].items[idx+offset];
				end
				icon:SetTexture(texture);
				text:SetText(name);
				count:SetText("");
				button:Show();
				button.itemid = tonumber(AutoBar_Category_Info[category].items[idx+offset]);
			else
				button:Hide();
				button.itemid = nil;
				text:SetText("");
			end
		end
	else
		AutoBar_Options_ConfigButton_ChooseCategory_HintText1:Show();
		local sortedCategories = {};
		for categoryName, rec in AutoBar_Category_Info do
			table.insert(sortedCategories, categoryName);
		end
		table.sort (sortedCategories);
		table.insert(sortedCategories, 1, "EMPTY");
		FauxScrollFrame_Update(AutoBar_Options_ConfigButton_ChooseCategory_Scroll, table.getn(sortedCategories), 7, 36);
		local offset = FauxScrollFrame_GetOffset(AutoBar_Options_ConfigButton_ChooseCategory_Scroll);
		local idx;
		for idx = 1, 7, 1 do
			local button = getglobal("AutoBar_Options_ConfigButton_ChooseCategory_Button"..idx);
			local hotkey = getglobal("AutoBar_Options_ConfigButton_ChooseCategory_Button"..idx.."HotKey");
			local count  = getglobal("AutoBar_Options_ConfigButton_ChooseCategory_Button"..idx.."Count");
			local icon   = getglobal("AutoBar_Options_ConfigButton_ChooseCategory_Button"..idx.."Icon");
			local text   = getglobal("AutoBar_Options_ConfigButton_ChooseCategory_Text"..idx);
			button.itemid = nil;
			if (sortedCategories[idx+offset] == "EMPTY") then
				icon:SetTexture("");
				count:SetText("Empty");
				text:SetText("Delete Current Category");
				button:Show();
				button.category = sortedCategories[idx+offset];
			elseif (sortedCategories[idx+offset]) then
				icon:SetTexture(AutoBar_GetTexture(sortedCategories[idx+offset]));
				count:SetText("");
				text:SetText(AutoBar_Category_Info[sortedCategories[idx+offset]].description);
				button.category = sortedCategories[idx+offset];
				button:Show();
			else
				button:Hide();
				button.category = nil;
				text:SetText("");
			end
		end
	end
end

function AutoBar_Config_ButtonChooseCategory_OnScroll()
	GameTooltip:Hide();
	AutoBar_Config_ButtonChooseCategory_OnShow();
end

function AutoBar_Config_Button_InsertCustomItem()
	StaticPopup_Show("AUTOBAR_ITEMENTRY");
end

function AutoBar_Options_Bar_Sliders(calledfromslider)
	if (not AutoBar_Config[AutoBar_Player].display) then
		AutoBar_Config[AutoBar_Player].display = {}; 
	end
	--
	local rows, columns, gapping, alpha, width, height, dockshiftx, dockshifty;
	if (calledfromslider) then
		rows    = AutoBar_Options_Bar_Rows:GetValue();
		columns = AutoBar_Options_Bar_Columns:GetValue();
		gapping = AutoBar_Options_Bar_Gapping:GetValue();
		alpha   = AutoBar_Options_Bar_Alpha:GetValue();
		width   = AutoBar_Options_Bar_ButtonWidth:GetValue();
		height  = AutoBar_Options_Bar_ButtonHeight:GetValue();
		dockshiftx = AutoBar_Options_Bar_DockShiftX:GetValue();
		dockshifty = AutoBar_Options_Bar_DockShiftY:GetValue();
	end
	--
	if ((not rows or rows == 0) and AutoBar_Config[AutoBar_Player].display.rows) then 
		rows = AutoBar_Config[AutoBar_Player].display.rows;
	elseif (not rows or rows == 0) then 
		rows = 1; 
	end
	if ((not columns or columns == 0) and AutoBar_Config[AutoBar_Player].display.columns) then 
		columns = AutoBar_Config[AutoBar_Player].display.columns;
	elseif (not columns or columns == 0) then 
		columns = 6; 
	end
	if ((not gapping or gapping == 0) and AutoBar_Config[AutoBar_Player].display.gapping) then 
		gapping = AutoBar_Config[AutoBar_Player].display.gapping;
	elseif (not gapping or gapping == 0) then 
		gapping = 6; 
	end
	if ((not alpha or alpha == 0) and AutoBar_Config[AutoBar_Player].display.alpha) then 
		alpha = AutoBar_Config[AutoBar_Player].display.alpha*10;
	elseif (not alpha or alpha == 0) then 
		alpha = 10; 
	end
	if ((not width or width == 0) and AutoBar_Config[AutoBar_Player].display.buttonwidth) then 
		width = AutoBar_Config[AutoBar_Player].display.buttonwidth;
	elseif (not width or width == 0) then 
		width = 36; 
	end
	if ((not height or height == 0) and AutoBar_Config[AutoBar_Player].display.buttonheight) then 
		height = AutoBar_Config[AutoBar_Player].display.buttonheight;
	elseif (not height or height == 0) then 
		height = 36; 
	end
	if ((not dockshiftx or dockshiftx == 0) and AutoBar_Config[AutoBar_Player].display.dockshiftx) then 
		dockshiftx = AutoBar_Config[AutoBar_Player].display.dockshiftx;
	elseif (not dockshiftx or dockshiftx == 0) then 
		dockshiftx = 0; 
	end
	if ((not dockshifty or dockshifty == 0) and AutoBar_Config[AutoBar_Player].display.dockshifty) then 
		dockshifty = AutoBar_Config[AutoBar_Player].display.dockshifty;
	elseif (not dockshifty or dockshifty == 0) then 
		dockshifty = 0; 
	end
	--
	if (calledfromslider) then
		while (rows*columns > 12) do
			this:SetValue(this:GetValue()-1);
			rows = AutoBar_Options_Bar_Rows:GetValue();
			columns = AutoBar_Options_Bar_Columns:GetValue();
		end
		if (height ~= width and not AutoBar_Config[AutoBar_Player].display.unlockbuttonratio) then
			if (this:GetName() == "AutoBar_Options_Bar_ButtonWidth") then
				height = width;
			elseif (this:GetName() == "AutoBar_Options_Bar_ButtonHeight") then
				width = height;
			end
		end
		--
		if (rows == 1) then
			AutoBar_Config[AutoBar_Player].display.rows = nil;
		else
			AutoBar_Config[AutoBar_Player].display.rows = rows;
		end
		if (columns == 6) then
			AutoBar_Config[AutoBar_Player].display.columns = nil;
		else
			AutoBar_Config[AutoBar_Player].display.columns = columns;
		end
		if (gapping == 6) then
			AutoBar_Config[AutoBar_Player].display.gapping = nil;
		else
			AutoBar_Config[AutoBar_Player].display.gapping = gapping;
		end
		if (alpha == 10) then
			AutoBar_Config[AutoBar_Player].display.alpha = nil;
		else
			AutoBar_Config[AutoBar_Player].display.alpha = math.floor(alpha)/10;
		end
		if (width == 36) then
			AutoBar_Config[AutoBar_Player].display.buttonwidth = nil;
		else
			AutoBar_Config[AutoBar_Player].display.buttonwidth = width;
		end
		if (height == 36) then
			AutoBar_Config[AutoBar_Player].display.buttonheight = nil;
		else
			AutoBar_Config[AutoBar_Player].display.buttonheight = height;
		end
		if (dockshiftx == 0) then
			AutoBar_Config[AutoBar_Player].display.dockshiftx = nil;
		else
			AutoBar_Config[AutoBar_Player].display.dockshiftx = dockshiftx;
		end
		if (dockshifty == 0) then
			AutoBar_Config[AutoBar_Player].display.dockshifty = nil;
		else
			AutoBar_Config[AutoBar_Player].display.dockshifty = dockshifty;
		end
	end
	--
	AutoBar_Options_Bar_RowsText:SetText("Rows - "..rows);
	AutoBar_Options_Bar_Rows:SetValue(rows);
	AutoBar_Options_Bar_ColumnsText:SetText("Columns - "..columns);
	AutoBar_Options_Bar_Columns:SetValue(columns);
	AutoBar_Options_Bar_GappingText:SetText("Icon Gapping - "..gapping);
	AutoBar_Options_Bar_Gapping:SetValue(gapping);
	AutoBar_Options_Bar_AlphaText:SetText("Icon Alpha - "..math.floor(alpha)/10);
	AutoBar_Options_Bar_Alpha:SetValue(alpha);
	AutoBar_Options_Bar_ButtonWidthText:SetText("Button Width - "..width);
	AutoBar_Options_Bar_ButtonWidth:SetValue(width);
	AutoBar_Options_Bar_ButtonHeightText:SetText("Button Height - "..height);
	AutoBar_Options_Bar_ButtonHeight:SetValue(height);
	AutoBar_Options_Bar_DockShiftXText:SetText("Shift Dock Left/Right - "..dockshiftx);
	AutoBar_Options_Bar_DockShiftX:SetValue(dockshiftx);
	AutoBar_Options_Bar_DockShiftYText:SetText("Shift Dock Up/Down - "..dockshifty);
	AutoBar_Options_Bar_DockShiftY:SetValue(dockshifty);

	AutoBar_SetupVisual();
end

function AutoBar_Options_CheckBox_Setup()
	AutoBar_Options_Bar_DockingMainBarText:SetText("Docked to Main Menu");
	AutoBar_Options_Bar_WidthHeightLockedText:SetText("Lock Button Height\nand Width Together");
	AutoBar_Options_Bar_ReverseButtonsText:SetText("Reverse Buttons");
	AutoBar_Options_Bar_HideKeyTextText:SetText("Hide Keybinding Text");
	AutoBar_Options_Bar_HideCountText:SetText("Hide Count text");
	AutoBar_Options_Bar_ShowEmptyButtonsText:SetText("Show Empty Buttons");
	if (AutoBar_Config[AutoBar_Player].display.docking == "MAINMENU") then
		AutoBar_Options_Bar_DockingMainBar:SetChecked(1);
	else
		AutoBar_Options_Bar_DockingMainBar:SetChecked(0);
	end
	if (AutoBar_Config[AutoBar_Player].display.unlockbuttonratio) then
		AutoBar_Options_Bar_WidthHeightLocked:SetChecked(0);
	else
		AutoBar_Options_Bar_WidthHeightLocked:SetChecked(1);
	end
	if (AutoBar_Config[AutoBar_Player].display.reversebuttons) then
		AutoBar_Options_Bar_ReverseButtons:SetChecked(1);
	else
		AutoBar_Options_Bar_ReverseButtons:SetChecked(0);
	end
	if (AutoBar_Config[AutoBar_Player].display.hidekeytext) then
		AutoBar_Options_Bar_HideKeyText:SetChecked(1);
	else
		AutoBar_Options_Bar_HideKeyText:SetChecked(0);
	end
	if (AutoBar_Config[AutoBar_Player].display.hidecount) then
		AutoBar_Options_Bar_HideCount:SetChecked(1);
	else
		AutoBar_Options_Bar_HideCount:SetChecked(0);
	end
	if (AutoBar_Config[AutoBar_Player].display.showemptybuttons) then
		AutoBar_Options_Bar_ShowEmptyButtons:SetChecked(1);
	else
		AutoBar_Options_Bar_ShowEmptyButtons:SetChecked(0);
	end
end

function AutoBar_Options_CheckBox_OnCheck()
	local button = this:GetName(); 
	if (this:GetChecked()) then
		if (button == "AutoBar_Options_Bar_DockingMainBar") then
			AutoBar_Config[AutoBar_Player].display.docking = "MAINMENU";
		elseif (button == "AutoBar_Options_Bar_WidthHeightLocked") then
			AutoBar_Config[AutoBar_Player].display.unlockbuttonratio = nil;
		elseif (button == "AutoBar_Options_Bar_ReverseButtons") then
			AutoBar_Config[AutoBar_Player].display.reversebuttons = 1;
		elseif (button == "AutoBar_Options_Bar_HideKeyText") then
			AutoBar_Config[AutoBar_Player].display.hidekeytext = 1;
		elseif (button == "AutoBar_Options_Bar_HideCount") then
			AutoBar_Config[AutoBar_Player].display.hidecount = 1;
		elseif (button == "AutoBar_Options_Bar_ShowEmptyButtons") then
			AutoBar_Config[AutoBar_Player].display.showemptybuttons = 1;
		end
	else
		if (button == "AutoBar_Options_Bar_DockingMainBar") then
			AutoBar_Config[AutoBar_Player].display.docking = nil;
		elseif (button == "AutoBar_Options_Bar_WidthHeightLocked") then
			AutoBar_Config[AutoBar_Player].display.unlockbuttonratio = 1;
		elseif (button == "AutoBar_Options_Bar_ReverseButtons") then
			AutoBar_Config[AutoBar_Player].display.reversebuttons = nil;
		elseif (button == "AutoBar_Options_Bar_HideKeyText") then
			AutoBar_Config[AutoBar_Player].display.hidekeytext = nil;
		elseif (button == "AutoBar_Options_Bar_HideCount") then
			AutoBar_Config[AutoBar_Player].display.hidecount = nil;
		elseif (button == "AutoBar_Options_Bar_ShowEmptyButtons") then
			AutoBar_Config[AutoBar_Player].display.showemptybuttons = nil;
		end
	end
	AutoBar_Options_CheckBox_Setup();
	AutoBar_SetupVisual();
end

function AutoBar_Options_ConfigButton_Option_OnCheck()
	local num = AutoBar_Options_ConfigButton.editting; 
	local buttoninfo = AutoBar_Config[AutoBar_Player].buttons[num];
	local category;
	if (type(buttoninfo) == "table") then
		category = buttoninfo[this:GetID()];
	else
		category = buttoninfo;
	end
	if (not AutoBar_Config[AutoBar_Player].smartselfcast) then
		AutoBar_Config[AutoBar_Player].smartselfcast = {};
	end
	AutoBar_Config[AutoBar_Player].smartselfcast[category] = this:GetChecked();
	AutoBar_Config_Button_Edit();
end

function AutoBar_Options_MoveArrow_OnClick(buttonnum, direction)
	local primarybutton = AutoBar_Options_ConfigButton.editting;
	local tmp;
	if (type(AutoBar_Config[AutoBar_Player].buttons[primarybutton]) == "table") then
		if (direction == "UP") then
			tmp = AutoBar_Config[AutoBar_Player].buttons[primarybutton][buttonnum-1];
			AutoBar_Config[AutoBar_Player].buttons[primarybutton][buttonnum-1] = 
			AutoBar_Config[AutoBar_Player].buttons[primarybutton][buttonnum];
			AutoBar_Config[AutoBar_Player].buttons[primarybutton][buttonnum] = tmp;
		elseif (direction == "DOWN") then
			tmp = AutoBar_Config[AutoBar_Player].buttons[primarybutton][buttonnum+1];
			AutoBar_Config[AutoBar_Player].buttons[primarybutton][buttonnum+1] = 
			AutoBar_Config[AutoBar_Player].buttons[primarybutton][buttonnum];
			AutoBar_Config[AutoBar_Player].buttons[primarybutton][buttonnum] = tmp;
		end
	end
	AutoBar_Config_Button_Edit(primarybutton);
end

------------------------------------

function AutoBar_ToggleConfig()
	if (AutoBar_Options:IsVisible()) then
		HideUIPanel(AutoBar_Options);
	else
		ShowUIPanel(AutoBar_Options);
	end
end

