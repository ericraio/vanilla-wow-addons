--[[ 
	Class Button
--]]

BClassButton = {
	--constructor
	Create = function(id, parent)
		local button = BBasicActionButton.Create(id, parent:GetName() .. "Button" .. id, parent, 30);
		
		if not BActionSets.g.hideHotkeys then
			BClassButton.UpdateHotkey(button);
		end
	
		BClassButton.SetScripts(button);
	
		return button;
	end,

	--load scripts
	SetScripts = function(button)
		button:SetScript("OnClick", BClassButton.OnClick);
		button:SetScript("OnEnter", BClassButton.OnEnter);
		button:SetScript("OnLeave", BClassButton.OnLeave);
	end,

	--[[ OnX Functions ]]--

	OnClick = function()
		this:SetChecked(not this:GetChecked() );
		CastShapeshiftForm(this:GetID());
	end,
	
	OnEnter = function()
		if BActionSets.g.tooltips then
			if GetCVar("UberTooltips") == "1" then
				GameTooltip_SetDefaultAnchor(GameTooltip, this);
			else
				GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			end
			GameTooltip:SetShapeshift(this:GetID());
		end
	end,

	OnLeave = function()
		GameTooltip:Hide();
	end,

	Update = function(button)
		local texture, name, isActive, isCastable = GetShapeshiftFormInfo(button:GetID());
		button:SetChecked(isActive);
		
		--update icon
		local icon = getglobal(button:GetName() .. "Icon");
		icon:SetTexture(texture);
		if isCastable then
			icon:SetVertexColor(1.0, 1.0, 1.0);
		else
			icon:SetVertexColor(0.4, 0.4, 0.4);
		end

		--update cooldown
		local cooldown = getglobal(button:GetName() .. "Cooldown");
		if texture then
			cooldown:Show();
		else
			cooldown:Hide();
		end
		local start, duration, enable = GetShapeshiftFormCooldown(button:GetID());
		CooldownFrame_SetTimer(cooldown, start, duration, enable);
	end,
	
	UpdateHotkey = function(button)
		BBasicActionButton.UpdateHotkey(button, "SHAPESHIFTBUTTON");
	end,
}