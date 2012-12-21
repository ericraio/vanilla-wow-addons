--[[
	BPetButton
		A Pet Action Button
		Should work exactly like the normal pet action buttons, but with a modified appearance
--]]

local function ReuseAndRename(oldName, newName, newParent)
	local button = getglobal(oldName);
	setglobal(newName, button);
	
	button:SetParent(newParent);
	button:SetAlpha(newParent:GetAlpha());
	button:SetFrameLevel(0);		
	getglobal(button:GetName() .. "Icon"):SetTexCoord(0.06, 0.94, 0.06, 0.94);

	return button;
end 

BPetButton = {
	--[[ Constructor ]]--
	
	Create = function(id, parent)
		local name = "BPetActionButton" .. id;
		
		local button;
		if BongosSets.dontReuse then
			button = BBasicActionButton.Create(id, name, parent, 30);
			button:SetID(id)
			
			local autoCastable = button:CreateTexture(name .. "AutoCastable", "OVERLAY");
			autoCastable:SetTexture("Interface\\Buttons\\UI-AutoCastableOverlay");
			autoCastable:SetWidth(58);
			autoCastable:SetHeight(58);
			autoCastable:SetPoint("CENTER", button);
			autoCastable:Hide();
			
			local autoCast = CreateFrame("Model", name .. "AutoCast", button)
			autoCast:SetModel("Interface\\Buttons\\UI-AutoCastButton.mdx");
			autoCast:SetScale(1.2)
			autoCast:SetSequence(0);
			autoCast:SetSequenceTime(0, 0);
			autoCast:Hide();
			
			local normalTexture = button:CreateTexture(name .. "NormalTexture2");
			normalTexture:SetTexture("Interface\\Buttons\\UI-Quickslot2");
			normalTexture:SetWidth(54);
			normalTexture:SetHeight(54);
			normalTexture:SetPoint("CENTER", button, "CENTER", 0, -1);
			button:SetNormalTexture(normalTexture);
		else
			button = ReuseAndRename("PetActionButton" .. id, name, parent)
		end
		
		getglobal(button:GetName() .. "AutoCastable"):SetPoint("CENTER", button, "CENTER", 0, -1);
		
		local autoCast = getglobal(button:GetName() .. "AutoCast");
		autoCast:SetPoint("TOPLEFT", button, "TOPLEFT", -0.5, -1);
		autoCast:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0.5, -1.5);
		
		if not BActionSets_HotkeysShown() then
			getglobal(button:GetName() .. "HotKey"):Hide();
		end
		
		BPetButton.UpdateHotkey(button);
		BPetButton.SetScripts(button);

		return button;
	end,

	SetScripts = function(button)
		button:RegisterForDrag("LeftButton", "RightButton");
		button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		
		button:SetScript("OnLoad", nil);
		button:SetScript("OnEvent", nil);
		button:SetScript("OnDragStart", BPetButton.OnDragStart);
		button:SetScript("OnClick", BPetButton.OnClick);
		button:SetScript("OnDragStart", BPetButton.OnDragStart);
		button:SetScript("OnReceiveDrag", BPetButton.OnReceiveDrag);
		button:SetScript("OnEnter", BPetButton.OnEnter);
	end,

	--[[ OnX Functions ]]--

	OnClick = function()
		this:SetChecked(0);
		if BActionSets_IsQuickMoveKeyDown() or bg_showGridPet then
			PickupPetAction(this:GetID());
		else
			if arg1 == "LeftButton" then
				CastPetAction(this:GetID());
			else
				TogglePetAutocast(this:GetID());
			end
		end
	end,

	OnDragStart = function()
		if not BActionSets_ButtonsLocked() or BActionSets_IsQuickMoveKeyDown() or bg_showGridPet then
			this:SetChecked(0);
			PickupPetAction(this:GetID());
		end
	end,

	OnReceiveDrag = function()
		if BActionSets_IsQuickMoveKeyDown() or bg_showGridPet then
			this:SetChecked(0);
			PickupPetAction(this:GetID());
		end
	end,

	OnEnter = function()
		if BActionSets_TooltipsShown() then 
			PetActionButton_OnEnter();
		end
	end,
	
	OnLeave = PetActionButton_OnLeave,
	
	--[[ Update Functions ]]--
	
	Update = function(button)
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(button:GetID());

		button.isToken = isToken;
		button.tooltipSubtext = subtext;
		button:SetChecked(isActive);
		
		if name then
			button:Show();
		elseif not(bg_showGridPet or BActionSets_ShowGrid()) then
			button:Hide();
		end
		
		local icon = getglobal(button:GetName() .. "Icon");
		
		if texture then
			if GetPetActionsUsable() then
				SetDesaturation(icon, false);			
			else
				SetDesaturation(icon, true);
			end
			icon:Show();
			button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
			getglobal(button:GetName().."NormalTexture2"):SetVertexColor(1, 1, 1, 1);
		else
			icon:Hide();
			button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
			getglobal(button:GetName().."NormalTexture2"):SetVertexColor(1, 1, 1, 0.5);
		end
		
		if not isToken then
			icon:SetTexture(texture);
			button.tooltipName = name;
		else
			icon:SetTexture(getglobal(texture));
			button.tooltipName = getglobal(name);
		end

		local autoCastTexture = getglobal(button:GetName() .. "AutoCastable");
		if autoCastAllowed then
			autoCastTexture:Show();
		else
			autoCastTexture:Hide();
		end

		local autoCastModel = getglobal(button:GetName() .. "AutoCast");
		if autoCastEnabled then
			autoCastModel:Show();
		else
			autoCastModel:Hide();
		end
	end,
	
	UpdateCooldown = function(button)
		local start, duration, enable = GetPetActionCooldown(button:GetID());
		CooldownFrame_SetTimer(getglobal(button:GetName() .. "Cooldown"), start, duration, enable);
	end,
	
	UpdateHotkey = function(button)
		BBasicActionButton.UpdateHotkey(button, "BONUSACTIONBUTTON");
	end,		
	
	ShowGrid = function(button)
		button:Show();
	end,
	
	HideGrid = function(button)
		if not GetPetActionInfo(button:GetID()) then
			button:Hide();
		end
	end,
	
	Hide = function(button)
		button:Hide();
	end,
}