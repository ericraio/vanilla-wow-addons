--[[
	button.lua
		Scripts for Bongos Action Buttons, which add more features to blizzard action buttons
		
	Changes over the normal action buttons:
		Colored red when out of range
		Selfcast can be enabled
		Altcast can be enabled
		Hotkeys are shortened
		Added the abiliy to skip pages when paging.
		GetPagedID is flexible
--]]

--local constants
local MAX_BUTTONS = 120; --the current maximum amount of action buttons

local function ReuseAndRename(oldName, newName, newParent)
	local button = getglobal(oldName);
	button:SetParent(newParent);
	button:SetAlpha(newParent:GetAlpha());
	button:SetFrameLevel(0);	
	setglobal(newName, button);
	
	return button;
end 

BActionButton = {
	--[[ Constructor Functions ]]--
	
	--Create an Action Button with the given ID and parent
	Create = function(id, parent)
		local name = "BActionButton" .. id;
		local button;
		if BongosSets.dontReuse then
			button = CreateFrame("CheckButton", name, parent, "ActionButtonTemplate");
		else
			if id <= 12 then
				button = ReuseAndRename("ActionButton" .. id, name, parent)
			elseif id <= 24 then
				button = ReuseAndRename("MultiBarBottomLeftButton" .. id-12, name, parent)
			elseif id <= 36 then
				button = ReuseAndRename("MultiBarBottomRightButton" .. id-24, name, parent)
			elseif id <= 48 then
				button = ReuseAndRename("MultiBarRightButton" .. id-36, name, parent)
			elseif id <= 60 then
				button = ReuseAndRename("MultiBarLeftButton" .. id-48, name, parent)
			else
				button = CreateFrame("CheckButton", name, parent, "ActionButtonTemplate");
			end
		end
		button:SetID(id)

		getglobal(button:GetName() .. "Icon"):SetTexCoord(0.06,0.94,0.06,0.94);
		
		getglobal(button:GetName() .. "Border"):SetVertexColor(0, 1, 0, 0.6);
		
		if not BActionSets_HotkeysShown() then
			getglobal(button:GetName() .. "HotKey"):Hide();
		end
		
		if not BActionSets_MacrosShown() then
			getglobal(button:GetName() .. "Name"):Hide();
		end
		
		BActionButton.UpdateHotkey(button);
		BActionButton.SetScripts(button);
		
		return button;
	end,
		
	--Called after the button is created, sets all scripts and listeners
	SetScripts = function(button)
		button.flashing = 0;
		button.flashtime = 0;
		
		button:RegisterForDrag("LeftButton", "RightButton");
		button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		
		button:SetScript("OnUpdate", BActionButton.OnUpdate);
		button:SetScript("OnClick", BActionButton.OnClick);
		button:SetScript("OnDragStart", BActionButton.OnDragStart);
		button:SetScript("OnReceiveDrag", BActionButton.OnReceiveDrag);
		button:SetScript("OnEnter", BActionButton.OnEnter);
		button:SetScript("OnLeave", BActionButton.OnLeave);
	end,
	
	--[[ OnX Functions ]]--
	
	OnClick = function()
		local pagedID = BActionButton.GetPagedID(this:GetID());
		
		if BActionSets_IsQuickMoveKeyDown() or bg_showGrid then
			PickupAction(pagedID);
		else
			if MacroFrame_SaveMacro then
				MacroFrame_SaveMacro();
			end
			
			local selfCast;
			if arg1 == "RightButton" then
				selfCast = 1;
			end
			UseAction(pagedID, 0, selfCast);
		end
		BActionButton.UpdateState(this);
	end,
	
	OnDragStart = function()
		if not BActionSets_ButtonsLocked() or BActionSets_IsQuickMoveKeyDown() or bg_showGrid then
			PickupAction(BActionButton.GetPagedID(this:GetID()));
			BActionButton.UpdateState(this);
		end
	end,
	
	OnReceiveDrag = function()
		PlaceAction(BActionButton.GetPagedID(this:GetID()));
		BActionButton.UpdateState(this);
	end,
	
	OnEnter = function()
		BActionButton.UpdateTooltip(this);
	end,

	OnLeave = function()
		this.updateTooltip = nil;
		GameTooltip:Hide();
	end,
	
	--OnUpdate
	OnUpdate = function()	
		--update flashing
		if this.flashing == 1 then
			this.flashtime = this.flashtime - arg1;
			if this.flashtime <= 0 then
				local overtime = -this.flashtime;
				if overtime >= ATTACK_BUTTON_FLASH_TIME then
					overtime = 0;
				end
				this.flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

				local flashTexture = getglobal(this:GetName().."Flash");
				if flashTexture:IsShown() then
					flashTexture:Hide();
				else
					flashTexture:Show();
				end
			end
		end
		
		-- Handle range indicator
		if this.rangeTimer then
			if this.rangeTimer < 0 then
				local pagedID = BActionButton.GetPagedID(this:GetID());
				local hotkey = getglobal(this:GetName().."HotKey");
				
				if IsActionInRange(pagedID) == 0 then
					hotkey:SetVertexColor(1, 0.1, 0.1);
					if BActionSets_ColorOutOfRange() and IsUsableAction(pagedID) then
						local rangeColor = BActionSets_GetRangeColor();
						getglobal(this:GetName() .. "Icon"):SetVertexColor(rangeColor.r, rangeColor.g, rangeColor.b);
					end
				else
					hotkey:SetVertexColor(0.6, 0.6, 0.6);
					if IsUsableAction(pagedID) then
						getglobal(this:GetName() .. "Icon"):SetVertexColor(1, 1, 1);
					end
				end
				this.rangeTimer = TOOLTIP_UPDATE_TIME;
			else
				this.rangeTimer = this.rangeTimer - arg1;
			end
		end

		--Tooltip stuff, probably for the cooldown timer
		if this.updateTooltip then
			this.updateTooltip = this.updateTooltip - arg1;
			if this.updateTooltip <= 0 then
				if GameTooltip:IsOwned(this) then
					BActionButton.UpdateTooltip(this);
				else
					this.updateTooltip = nil;
				end
			end
		end
	end,
	
	--[[ Update Functions ]]--
	
	--Updates the icon, count, cooldown, usability color, if the button is flashing, if the button is equipped,  and macro text.
	Update = function(button)
		local pagedID = BActionButton.GetPagedID(button:GetID());
		local buttonName = button:GetName();
		
		--if the button's not empty, then show the icon, else show an empty button
		local texture = GetActionTexture(pagedID);
		local icon = getglobal(buttonName.."Icon");
		local buttonCooldown = getglobal(buttonName.."Cooldown");
		
		if texture then
			icon:SetTexture(texture);
			icon:Show();
			button.rangeTimer = TOOLTIP_UPDATE_TIME;
			button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
			getglobal(buttonName.."NormalTexture"):SetVertexColor(1, 1, 1, 1);
		else
			icon:Hide();
			buttonCooldown:Hide();
			button.rangeTimer = nil;
			getglobal(buttonName.."HotKey"):SetVertexColor(0.6, 0.6, 0.6);
			button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
			getglobal(buttonName.."NormalTexture"):SetVertexColor(1, 1, 1, 0.4);
		end
		
		--update count
		if IsConsumableAction(pagedID) then
			getglobal(buttonName.."Count"):SetText(GetActionCount(pagedID));
		else
			getglobal(buttonName.."Count"):SetText("");
		end
		
		--update cooldown/usability if there's an action
		if HasAction(pagedID) then
			button:Show();
			BActionButton.UpdateUsable(button);
			BActionButton.UpdateCooldown(button);
		elseif not (bg_showGrid or BActionSets_ShowGrid()) then
			button:Hide();
		else
			button:Show();
			buttonCooldown:Hide();
		end
		
		--Update if the button is flashing or not
		BActionButton.UpdateFlash(button);
		
		-- Add a green border if the button is an equipped ite
		local border = getglobal(buttonName.."Border");
		if IsEquippedAction(pagedID) then
			border:Show();
		else
			border:Hide();
		end
		
		if GameTooltip:IsOwned(button) then
			BActionButton.UpdateTooltip(button);
		else
			button.updateTooltip = nil;
		end
	
		-- Update Macro Text
		getglobal(buttonName.."Name"):SetText(GetActionText(pagedID));
	end,
	
	--colors the action button if out of mana, out of range, etc
	UpdateUsable = function(button)
		local pagedID = BActionButton.GetPagedID(button:GetID());
		local icon = getglobal(button:GetName().."Icon");
		
		local isUsable, notEnoughMana = IsUsableAction(pagedID);
		if isUsable then
			if BActionSets_ColorOutOfRange() and IsActionInRange(pagedID) == 0 then
				local rangeColor = BActionSets_GetRangeColor();
				icon:SetVertexColor(rangeColor.r, rangeColor.g, rangeColor.b);
			else
				icon:SetVertexColor(1,1,1);
			end
		elseif notEnoughMana then
			--Make the icon blue if out of mana
			icon:SetVertexColor(0.5, 0.5, 1);
		else
			--Skill unusable
			icon:SetVertexColor(0.3, 0.3, 0.3);
		end
	end,
	
	--Update the cooldown timer
	UpdateCooldown = function(button)
		local start, duration, enable = GetActionCooldown(BActionButton.GetPagedID(button:GetID()));
		CooldownFrame_SetTimer(getglobal(button:GetName().."Cooldown"), start, duration, enable);
	end,
	
	--Update if a button is checked or not
	UpdateState = function(button)
		local pagedID = BActionButton.GetPagedID(button:GetID());
		button:SetChecked(IsCurrentAction(pagedID) or IsAutoRepeatAction(pagedID));
	end,
	
	--Update a a flashing button
	UpdateFlash = function(button)
		local pagedID = BActionButton.GetPagedID(button:GetID());
		if (IsCurrentAction(pagedID) and IsAttackAction(pagedID)) or IsAutoRepeatAction(pagedID) then
			button.flashing = 1;
			button.flashtime = 0;
		else
			button.flashing = nil;
			getglobal(button:GetName().."Flash"):Hide();
		end
		BActionButton.UpdateState(button);
	end,
	
	UpdateTooltip = function(button)
		if BActionSets_TooltipsShown() then
			if GetCVar("UberTooltips") == "1" then
				GameTooltip_SetDefaultAnchor(GameTooltip, button);
			else
				GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
			end

			if GameTooltip:SetAction(BActionButton.GetPagedID(button:GetID())) then
				button.updateTooltip = TOOLTIP_UPDATE_TIME;
			else
				button.updateTooltip = nil;
			end
		end
	end,
	
	UpdateHotkey = BBasicActionButton.UpdateHotkey,
	
	--next two are basically wrapper functions for use with ForAllButtons
	UpdateUsableAndCooldown = function(button)
		BActionButton.UpdateUsable(button);
		BActionButton.UpdateCooldown(button);
	end,
	
	UpdateAll = function(button)
		BActionButton.Update(button);
		BActionButton.UpdateState(button);
	end,
	
	--hides a button, if its currently not attached to any actionbar
	ShowIfUsed = function(button)
		if button:GetParent() then
			BActionButton.UpdateAll(button);
			if not button:GetParent():IsShown() then
				button:Hide();
			end
		else
			button:Hide();
		end
	end,
	
	--[[ Toggles ]]--
	
	--Show Empty Buttons
	ShowGrid = function(button)
		button:Show();
	end,
	
	--Hide Empty Buttons
	HideGrid = function(button)
		if not HasAction(BActionButton.GetPagedID(button:GetID())) then
			button:Hide();
		end
	end,
	
	ShowMacroText = function(button, enable)
		if enable then
			getglobal(button:GetName().."Name"):Show();
		else
			getglobal(button:GetName().."Name"):Hide();
		end
	end,
	
	--[[ Action ID Functions ]]--
	
	--returns the barID of the button's parent
	GetParent = function(buttonID)
		local button = getglobal("BActionButton" .. buttonID);
		if button and button:GetParent() then
			return button:GetParent().id;
		end
		
		local numActionBars = BActionBar.GetNumber();
		local maxButtonsPerBar = math.floor(MAX_BUTTONS / numActionBars);
		for i = 1, numActionBars do
			if buttonID <= maxButtonsPerBar * i then
				return i;
			end
		end
		
		return nil;
	end,

	--Paging, this extends it to page 10 and allows page skipping
	GetPagedID = function(buttonID, barID)
		if not barID then
			barID = BActionButton.GetParent(buttonID);
			if not barID then
				return buttonID;
			end
		end
		
		--normal paging
		local pageOffset = BActionBar.GetPage(barID);
		if pageOffset ~= 0 then
			local pagedID = mod(buttonID + pageOffset * BActionBar.GetSize(barID), MAX_BUTTONS);	
			if pagedID == 0 then
				return MAX_BUTTONS;
			end
			return pagedID;
		end
		
		--stance paging - (bear form, fury stance, etc)
		local stanceOffset = BActionBar.GetStance(barID);
		if stanceOffset ~= 0 then
			local pagedID =  mod(buttonID + stanceOffset * BActionBar.GetSize(barID), MAX_BUTTONS);
			if pagedID == 0 then
				return MAX_BUTTONS;
			end			
			return pagedID;
		end
		
		--Contextual paging - targeting a friendly unit or something
		local contextOffset = BActionBar.GetContext(barID)
		if contextOffset ~= 0 then
			local pagedID =  mod(buttonID + contextOffset * BActionBar.GetSize(barID), MAX_BUTTONS);
			if pagedID == 0 then
				return MAX_BUTTONS;
			end			
			return pagedID;
		end
		
		return buttonID;
	end,
}

--[[ Function Hooks and Overrides ]]--

local oUseAction = UseAction;
UseAction = function(id, s, onSelf)
	if BActionSets_IsSelfCastHotkeyDown() then
		oUseAction(id, s, 1);
		if SpellIsTargeting() then
			SpellTargetUnit("player");
		end
	else
		oUseAction(id, s, onSelf);
		if SpellIsTargeting() and onSelf then
			SpellTargetUnit("player");
		end
	end
end

--Release button, do action
ActionButtonUp = function(id, onSelf)
	local button = getglobal("BActionButton".. id);
	
	-- Used to save a macro
	if MacroFrame_SaveMacro then
		MacroFrame_SaveMacro();
	end
		
	local pagedID = BActionButton.GetPagedID(id);
	
	if button and button:GetButtonState() == "PUSHED" then
		button:SetButtonState("NORMAL");
		button:SetChecked(IsCurrentAction(pagedID));
	end
	UseAction(pagedID, 0, onSelf);
end

--Press button
ActionButtonDown = function(id)
	local button = getglobal("BActionButton".. id);
	
	if button and button:GetButtonState() == "NORMAL" then
		button:SetButtonState("PUSHED");
	end
end