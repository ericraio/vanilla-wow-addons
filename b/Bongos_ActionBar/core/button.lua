local NORMALTEX_RATIO = 1.833333333;

BBasicActionButton = {
	Create = function(id, name, parent, size)
		local button = CreateFrame("CheckButton", name, parent);
		button:SetID(id);
		button:SetAlpha(parent:GetAlpha());
		button:SetHeight(size);
		button:SetWidth(size);
		
		--icon texture
		local iconTexture = button:CreateTexture(name .. "Icon", "BACKGROUND");
		iconTexture:SetTexCoord(0.06, 0.94, 0.06, 0.94);
		iconTexture:SetAllPoints(button);
		
		--normal, pushed, highlight, checked textures
		local normalTexture = button:CreateTexture(name .. "NormalTexture");
		normalTexture:SetTexture("Interface\\Buttons\\UI-Quickslot2");
		normalTexture:SetHeight(NORMALTEX_RATIO * size);
		normalTexture:SetWidth(NORMALTEX_RATIO * size);
		normalTexture:SetPoint("CENTER", button, "CENTER", 0, -1);
		
		button:SetNormalTexture(normalTexture);
		button:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress");
		button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
		button:SetCheckedTexture("Interface\\Buttons\\CheckButtonHilight");
		
		--hotkey
		local hotkey = button:CreateFontString(name .. "HotKey", "ARTWORK");
		hotkey:SetFontObject(NumberFontNormalSmallGray);
		hotkey:SetPoint("TOPRIGHT", button, "TOPRIGHT", 2, -2);
		hotkey:SetJustifyH("RIGHT");
		hotkey:SetWidth(size);
		hotkey:SetHeight(10);
		if not BActionSets_HotkeysShown() then
			hotkey:Hide();
		end
		
		--cooldown model
		local cooldown = CreateFrame("Model", name .. "Cooldown", button, "CooldownFrameTemplate");
		cooldown:SetAllPoints(button);
		
		return button;
	end,

	UpdateHotkey = function(button, hotkeyType)
		if not hotkeyType  then
			hotkeyType = "ACTIONBUTTON";
		end
			
		local key = string.upper(GetBindingText(GetBindingKey(hotkeyType .. button:GetID()), "KEY_"));
		--hotkeys are shortened to one letter for Alt, Ctrl, Shift, and Num Pad
		if(key) then
			key = string.gsub (key, " ", "");
			key = string.gsub (key, "ALT%-", "A");
			key = string.gsub (key, "CTRL%-", "C");
			key = string.gsub (key, "SHIFT%-", "S");
			key = string.gsub (key, "NUMPAD", "N");
			key = string.gsub (key, "BACKSPACE", "BSpc");

			--extra hotkeys
			key = string.gsub (key, "HOME", "Hm");
			key = string.gsub (key, "END", "End");
			key = string.gsub (key, "INSERT", "Ins");
			key = string.gsub (key, "DELETE", "Del");
			key = string.gsub (key, "MIDDLEMOUSE", "M3");
			key = string.gsub (key, "MOUSEBUTTON4", "M4");
			key = string.gsub (key, "MOUSEBUTTON5", "M5");
			key = string.gsub (key, "MOUSEWHEELDOWN", "MwDn");
			key = string.gsub (key, "MOUSEWHEELUP", "MwUp");
			key = string.gsub (key, "PAGEDOWN", "PgDn");
			key = string.gsub (key, "PAGEUP", "PgUp"); 
		end
			
	 	getglobal(button:GetName().."HotKey"):SetText(key);
	end,

	ShowHotkey = function(button, show)
		if show then
			getglobal(button:GetName() .. "HotKey"):Show();
		else
			getglobal(button:GetName() .. "HotKey"):Hide();
		end
	end,
}