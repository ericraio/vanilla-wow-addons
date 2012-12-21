CT_AddMovable("CT_HotbarLeft_Drag", CT_BARMOD_MOVABLE_LEFTHOTBAR, "BOTTOM", "BOTTOM", "UIParent", -490, 98, function(status)
	if ( status and CT_HotbarLeft:IsVisible() ) then
		CT_HotbarLeft_Drag:Show()
	else
		CT_HotbarLeft_Drag:Hide();
	end
end);

CT_AddMovable("CT_HotbarRight_Drag", CT_BARMOD_MOVABLE_RIGHTHOTBAR, "BOTTOM", "BOTTOM", "UIParent", 14, 98, function(status)
	if ( status and CT_HotbarRight:IsVisible() ) then
		CT_HotbarRight_Drag:Show()
	else
		CT_HotbarRight_Drag:Hide();
	end
end);

CT_AddMovable("CT_SidebarLeft_Drag", CT_BARMOD_MOVABLE_LEFTSIDEBAR, "TOPLEFT", "TOPLEFT", "UIParent", 15, -86, function(status)
	if ( status and CT_SidebarFrame:IsVisible() ) then
		CT_SidebarLeft_Drag:Show()
	else
		CT_SidebarLeft_Drag:Hide();
	end
end);

CT_AddMovable("CT_SidebarRight_Drag", CT_BARMOD_MOVABLE_RIGHTSIDEBAR, "TOPRIGHT", "TOPRIGHT", "UIParent", -15, -148, function(status)
	if ( status and CT_SidebarFrame2:IsVisible() ) then
		CT_SidebarRight_Drag:Show()
	else
		CT_SidebarRight_Drag:Hide();
	end
end);

CT_AddMovable("CT_HotbarTop_Drag", CT_BARMOD_MOVABLE_TOPHOTBAR, "BOTTOM", "BOTTOM", "UIParent", -28, 140, function(status)
	if ( status and CT_HotbarTop:IsVisible() ) then
		CT_HotbarTop_Drag:Show()
	else
		CT_HotbarTop_Drag:Hide();
	end
end);

CT_AddMovable("CT_PetBar_Drag", CT_BARMOD_MOVABLE_PETBAR, "BOTTOMLEFT", "BOTTOM", "UIParent", -453, 82, function(status)
	if ( status and PetActionBarFrame:IsVisible() ) then
		CT_PetBar_Drag:Show()
	else
		CT_PetBar_Drag:Hide();
	end
end, function()
	if ( CT_HotbarLeft:IsVisible() ) then
		local x = CT_PetBar_Drag:GetLeft()-(UIParent:GetRight()/2);
		local y = CT_PetBar_Drag:GetBottom()+40;
		CT_PetBar_Drag:ClearAllPoints();
		CT_PetBar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", x, y);
	end
end);

CT_AddMovable("CT_BABar_Drag", CT_BARMOD_MOVABLE_CLASSBAR, "BOTTOMLEFT", "BOTTOM", "UIParent", -461, 88, function(status)
	if ( status and ShapeshiftBarFrame:IsVisible() ) then
		CT_BABar_Drag:Show()
	else
		CT_BABar_Drag:Hide();
	end
end, function()
	if ( CT_HotbarLeft:IsVisible() ) then
		local x = CT_BABar_Drag:GetLeft()-(UIParent:GetRight()/2);
		local y = CT_BABar_Drag:GetBottom()+40;
		CT_BABar_Drag:ClearAllPoints();
		CT_BABar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", x, y);
	end
end);

local CT_Hotcast = 0;
CT_SelfCast = 0;
CT_CDCount = 0;
CT_FadeColor = { ["r"] = 1.0, ["g"] = 1.0, ["b"] = 1.0 };
CT_ActionBar_LockedPage = 1;
local CT_NextSelfCast;
CT_Hotbar = { };
CT_SidebarAxis = {
	[1] = 2,
	[2] = 2,
	[3] = 1,
	[4] = 1,
	[5] = 2
};

CT_LSidebar_Buttons = 12;
CT_RSidebar_Buttons = 12;
CT_Alt_Hotbar = 0;
CT_Hotbars_Locked = false;
CT_HotbarButtons_Locked = false;
CT_ShowGrid = 1;

function CT_ButtonLock_Update(modid)
	local val = CT_Mods[modid];
	if ( val["modStatus"] == "off" ) then
		CT_HotbarButtons_Locked = false;
	else
		CT_HotbarButtons_Locked = true;
	end
end

function CT_Sidebar_ButtonInUse(btn)
	if ( ( strsub(btn:GetName(), 1, 3) == "CT3" and btn:GetID() <= CT_LSidebar_Buttons ) or ( strsub( btn:GetName(), 1, 3) == "CT4" and btn:GetID() <= CT_RSidebar_Buttons ) ) then
		return 1;
	else
		return nil;
	end
end

function CT_HotbarcastUp(id)
	CT_Hotbar[id] = nil;
end

function CT_HotbarcastDown(id)
	CT_Hotbar[id] = 1;
end

function CT_ActionButton_Update()
	-- Special case code for bonus bar buttons
	-- Prevents the button from updating if the bonusbar is still in an animation transition
	if ( this.isBonus and this.inTransition ) then
		CT_ActionButton_UpdateUsable();
		CT_ActionButton_UpdateCooldown();
		return;
	end
	
	local icon = getglobal(this:GetName().."Icon");
	local buttonCooldown = getglobal(this:GetName().."Cooldown");
	local texture = GetActionTexture(CT_ActionButton_GetPagedID(this));
	if ( texture ) then
		icon:SetTexture(texture);
		icon:Show();
		this.rangeTimer = -1;
		this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
		-- Save texture if the button is a bonus button, will be needed later
		if ( this.isBonus ) then
			this.texture = texture;
		end
	else
		icon:Hide();
		buttonCooldown:Hide();
		this.rangeTimer = nil;
		this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
		getglobal(this:GetName().."HotKey"):SetVertexColor(0.6, 0.6, 0.6);
	end
	CT_ActionButton_UpdateCount();
	if ( HasAction(CT_ActionButton_GetPagedID(this)) ) then
		this:RegisterEvent("ACTIONBAR_UPDATE_STATE");
		this:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
		this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
		this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
		this:RegisterEvent("PLAYER_AURAS_CHANGED");
		this:RegisterEvent("PLAYER_TARGET_CHANGED");
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
		this:RegisterEvent("CRAFT_SHOW");
		this:RegisterEvent("CRAFT_CLOSE");
		this:RegisterEvent("TRADE_SKILL_SHOW");
		this:RegisterEvent("TRADE_SKILL_CLOSE");
		this:RegisterEvent("PLAYER_ENTER_COMBAT");
		this:RegisterEvent("PLAYER_LEAVE_COMBAT");
		this:RegisterEvent("START_AUTOREPEAT_SPELL");
		this:RegisterEvent("STOP_AUTOREPEAT_SPELL");

		this:Show();
		CT_ActionButton_UpdateState();
		CT_ActionButton_UpdateUsable();
		CT_ActionButton_UpdateCooldown();
		CT_ActionButton_UpdateFlash();
	else
		this:UnregisterEvent("ACTIONBAR_UPDATE_STATE");
		this:UnregisterEvent("ACTIONBAR_UPDATE_USABLE");
		this:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
		this:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
		this:UnregisterEvent("PLAYER_AURAS_CHANGED");
		this:UnregisterEvent("PLAYER_TARGET_CHANGED");
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		this:UnregisterEvent("CRAFT_SHOW");
		this:UnregisterEvent("CRAFT_CLOSE");
		this:UnregisterEvent("TRADE_SKILL_SHOW");
		this:UnregisterEvent("TRADE_SKILL_CLOSE");
		this:UnregisterEvent("PLAYER_ENTER_COMBAT");
		this:UnregisterEvent("PLAYER_LEAVE_COMBAT");
		this:UnregisterEvent("START_AUTOREPEAT_SPELL");
		this:UnregisterEvent("STOP_AUTOREPEAT_SPELL");

		if ( this.showgrid == 0 ) then
			this:Hide();
		else
			buttonCooldown:Hide();
		end
	end

	-- Add a green border if button is an equipped item
	local border = getglobal(this:GetName().."Border");
	if ( IsEquippedAction(CT_ActionButton_GetPagedID(this)) ) then
		border:SetVertexColor(0, 1.0, 0, 0.35);
		border:Show();
	else
		border:Hide();
	end

	if ( GameTooltip:IsOwned(this) ) then
		CT_ActionButton_SetTooltip();
	else
		this.updateTooltip = nil;
	end

	-- Update Macro Text
	local macroName = getglobal(this:GetName().."Name");
	macroName:SetText(GetActionText(CT_ActionButton_GetPagedID(this)));
end

function CT_ActionButton_UpdateFlash()
	local pagedID = CT_ActionButton_GetPagedID(this);
	if ( (IsAttackAction(pagedID) and IsCurrentAction(pagedID)) or IsAutoRepeatAction(pagedID) ) then
		CT_ActionButton_StartFlash();
	else
		CT_ActionButton_StopFlash();
	end
end

function CT_ActionButton_HideGrid(button)
	local btn;
	if ( button ) then
		btn = button;
	else
		btn = this;
	end
	local isException;
	if ( 
		( GetBonusBarOffset() > 0 and strsub(btn:GetName(), 1, 12) ~= "ActionButton" ) or 
		( strsub(btn:GetName(), 1, 12) == "MultiBarLeft" and not SHOW_MULTI_ACTIONBAR_4 ) or
		( strsub(btn:GetName(), 1, 13) == "MultiBarRight" and not SHOW_MULTI_ACTIONBAR_3 ) or
		( strsub(btn:GetName(), 1, 18) == "MultiBarBottomLeft" and not SHOW_MULTI_ACTIONBAR_1 ) or
		( strsub(btn:GetName(), 1, 19) == "MultiBarBottomRight" and not SHOW_MULTI_ACTIONBAR_2 ) or
		( GetBonusBarOffset() == 0 and strsub(btn:GetName(), 1, 17) ~= "BonusActionButton" ) 
	) then
		isException = 1;
	end
	if ( CT_ShowGrid and isException ) then return; end
	btn.showgrid = 0;
	if ( not HasAction(CT_ActionButton_GetPagedID(btn)) or not isException ) then
		btn:Hide();
	end
end

function CT_ActionButton_OnLoad()
	if ( ( ( strsub( this:GetName(), 1, 3) == "CT3" and this:GetID() <= CT_LSidebar_Buttons ) or ( strsub( this:GetName(), 1, 3) == "CT4" and this:GetID() <= CT_RSidebar_Buttons ) ) and ( strsub( this:GetName(), 1, 3 ) == "CT3" or strsub( this:GetName(), 1, 3 ) == "CT4" ) ) then
		this:Hide();
	else
		this:Show();
	end
	this.flashing = 0;
	this.flashtime = 0;
	ActionButton_Update();
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	this:RegisterEvent("ACTIONBAR_SHOWGRID");
	this:RegisterEvent("ACTIONBAR_HIDEGRID");
	this:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
	this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	this:RegisterEvent("ACTIONBAR_UPDATE_STATE");
	this:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("UNIT_AURASTATE");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_CLOSE");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_CLOSE");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("UPDATE_BINDINGS");
	this:RegisterEvent("START_AUTOREPEAT_SPELL");
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	CT_ActionButton_UpdateHotkeys();
	this.showgrid = 2;
end

function CT_ActionButton_UpdateHotkeys(actionbtn)
	if ( not actionbtn ) then actionbtn = this; end
	if ( CT_ShowHotkeys == -1 ) then
		getglobal(actionbtn:GetName() .. "HotKey"):Hide();
		return;
	end
	local hotkey = getglobal(actionbtn:GetName().."HotKey");
	hotkey:Show();
	if ( not CT_ShowHotkeys ) then
		local key = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=" };
		hotkey:SetText(key[actionbtn:GetID()]);
		return;
	end
	local prefix;
	if ( strsub(actionbtn:GetName(), 0, 3) == "CT_" ) then
		prefix = "CT_HOTBAR1";
	elseif ( strsub(actionbtn:GetName(), 0, 2) == "CT" ) then
		prefix = "CT_HOTBAR" .. strsub(actionbtn:GetName(), 3, 3);
	else
		prefix = "ACTION";
	end

	local action = prefix .. "BUTTON"..actionbtn:GetID();
	local text = GetBindingText(GetBindingKey(action), "KEY_");

	text = string.gsub(text, "CTRL%-", "C-");
	text = string.gsub(text, "ALT%-", "A-");
	text = string.gsub(text, "SHIFT%-", "S-");
	text = string.gsub(text, "Num Pad", "NP");
	text = string.gsub(text, "Backspace", "Bksp");
	text = string.gsub(text, "Spacebar", "Space");
	text = string.gsub(text, "Page", "Pg");
	text = string.gsub(text, "Down", "Dn");
	text = string.gsub(text, "Arrow", "");
	text = string.gsub(text, "Insert", "Ins");
	text = string.gsub(text, "Delete", "Del");

	hotkey:SetText(text);
end

function CT_ActionButton_UpdateState()
	if ( IsCurrentAction(CT_ActionButton_GetPagedID(this)) or IsAutoRepeatAction(CT_ActionButton_GetPagedID(this)) ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function CT_ActionButton_UpdateUsable()
	local icon = getglobal(this:GetName().."Icon");
	local normalTexture = getglobal(this:GetName().."NormalTexture");
	local isUsable, notEnoughMana = IsUsableAction(CT_ActionButton_GetPagedID(this));
	if ( isUsable ) then
		if ( this.inRange and this.inRange == 0 ) then
			icon:SetVertexColor(CT_FadeColor.r, CT_FadeColor.g, CT_FadeColor.b);
			if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(CT_FadeColor.r, CT_FadeColor.g, CT_FadeColor.b); end
		else
			icon:SetVertexColor(1.0, 1.0, 1.0);
			if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(1.0, 1.0, 1.0); end
		end
	elseif ( notEnoughMana ) then
		icon:SetVertexColor(0.5, 0.5, 1.0);
		if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(0.5, 0.5, 1.0); end
	else
		icon:SetVertexColor(0.4, 0.4, 0.4);
		if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(0.4, 0.4, 0.4); end
	end
end

function CT_ActionButton_UpdateCount()
	local text = getglobal(this:GetName().."Count");
	local count = GetActionCount(CT_ActionButton_GetPagedID(this));
	if ( count > 1 ) then
		text:SetText(count);
	else
		text:SetText("");
	end
end

function CT_ActionButton_UpdateCooldown()
	local cooldown = getglobal(this:GetName().."Cooldown");
	local start, duration, enable = GetActionCooldown(CT_ActionButton_GetPagedID(this));
	CooldownFrame_SetTimer(cooldown, start, duration, enable);
end

function CT_ActionButton_OnEvent(event)
	if ( event == "PLAYER_LEAVING_WORLD" ) then
		this.disableEvents = true;
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		this.disableEvents = nil;
	elseif ( this.disableEvents ) then
		return;
	end
	if ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		if ( arg1 == -1 or arg1 == CT_ActionButton_GetPagedID(this) ) then
			CT_ActionButton_Update();
		end
		return;
	end
	if ( event == "ACTIONBAR_PAGE_CHANGED" or event == "PLAYER_AURAS_CHANGED" or event == "UPDATE_BONUS_ACTIONBAR" ) then
		CT_BarMod_UpdateCooldownCount(this);
		CT_ActionButton_Update();
		CT_ActionButton_UpdateState();
		return;
	end
	if ( event == "ACTIONBAR_SHOWGRID" ) then
		CT_ActionButton_ShowGrid();
		return;
	end
	if ( event == "ACTIONBAR_HIDEGRID" ) then
		CT_ActionButton_HideGrid();
		return;
	end
	if ( event == "UPDATE_BINDINGS" ) then
		CT_ActionButton_UpdateHotkeys();
	end

	-- All event handlers below this line MUST only be valid when the button is visible
	if ( not this:IsVisible() ) then
		return;
	end

	if ( event == "PLAYER_TARGET_CHANGED" ) then
		CT_ActionButton_UpdateUsable();
		return;
	end
	if ( event == "UNIT_AURASTATE" ) then
		if ( arg1 == "player" or arg1 == "target" ) then
			CT_ActionButton_UpdateUsable();
		end
		return;
	end
	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			CT_ActionButton_Update();
		end
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_STATE" ) then
		CT_ActionButton_UpdateState();
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_USABLE" ) then
		CT_ActionButton_UpdateUsable();
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_COOLDOWN" ) then
		CT_ActionButton_UpdateCooldown();
		return;
	end
	if ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		CT_ActionButton_UpdateState();
		return;
	end
	if ( arg1 == "player" and (event == "UNIT_HEALTH" or event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY") ) then
		CT_ActionButton_UpdateUsable();
		return;
	end
	if ( event == "PLAYER_ENTER_COMBAT" ) then
		IN_ATTACK_MODE = 1;
		if ( IsAttackAction(CT_ActionButton_GetPagedID(this)) ) then
			CT_ActionButton_StartFlash();
		end
		return;
	end
	if ( event == "PLAYER_LEAVE_COMBAT" ) then
		IN_ATTACK_MODE = 0;
		if ( IsAttackAction(CT_ActionButton_GetPagedID(this)) ) then
			CT_ActionButton_StopFlash();
		end
		return;
	end
	if ( event == "PLAYER_COMBO_POINTS" ) then
		CT_ActionButton_UpdateUsable();
		return;
	end
	if ( event == "START_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = 1;
		if ( IsAutoRepeatAction(CT_ActionButton_GetPagedID(this)) ) then
			CT_ActionButton_StartFlash();
		end
		return;
	end
	if ( event == "STOP_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = nil;
		if ( ActionButton_IsFlashing() and not IsAttackAction(CT_ActionButton_GetPagedID(this)) ) then
			CT_ActionButton_StopFlash();
		end
		return;
	end
end

function CT_ActionButton_StartFlash()
	this.flashing = 1;
	this.flashtime = 0;
	CT_ActionButton_UpdateState();
end

function CT_ActionButton_StopFlash()
	this.flashing = 0;
	getglobal(this:GetName().."Flash"):Hide();
	CT_ActionButton_UpdateState();
end

function CT_ActionButton_SetTooltip()
	if ( GetCVar("UberTooltips") == "1" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
	else
		if ( this:GetCenter() < UIParent:GetCenter() ) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		else
			GameTooltip:SetOwner(this, "ANCHOR_LEFT");
		end
	end
	
	if ( GameTooltip:SetAction(CT_ActionButton_GetPagedID(this)) ) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		this.updateTooltip = nil;
	end
end

function CT_ActionButton_GetPagedID(button)
	if( button == nil ) then
		return 0;
	end
	local page = CURRENT_ACTIONBAR_PAGE;
	if ( CT_Hotbars_Locked ) then
		page = CT_ActionBar_LockedPage;
	end
	local isBonus;
	if ( not page ) then page = 1; end
	if ( strsub( button:GetName(), 1, 3 ) == "CT2" ) then
		page = page + 1;
	elseif ( strsub( button:GetName(), 1, 3 ) == "CT3" ) then
		page = page + 2;
	elseif ( strsub( button:GetName(), 1, 3 ) == "CT4" ) then
		page = page + 3;
	elseif ( strsub( button:GetName(), 1, 3 ) == "CT5" ) then
		page = page + 4;
	elseif ( string.find(button:GetName(), "^ActionButton%d+$") ) then
		page = page - 1;
	elseif ( string.find(button:GetName(), "^BonusActionButton%d+$") or string.find(button:GetName(), "^MultiBar") ) then
		return ActionButton_GetPagedID(button);
	end
	if ( page >= 6 and not isBonus ) then
		page = page - 6;
	end
	return (button:GetID() + ((page) * NUM_ACTIONBAR_BUTTONS));
end

function CT_ActionButtonDown(bar, id)
	if ( bar == 1 ) then bar = ""; end -- First bar's buttons aren't named CT1
	local button = getglobal("CT" .. bar .. "_ActionButton" .. id);
	if ( button:GetButtonState() == "NORMAL" ) then
		button:SetButtonState("PUSHED");
	end

	if ( CT_SelfCastModifier ) then
		CT_NextSelfCast = 1;
	end
end

function CT_ActionButtonUp(bar, id)
	if ( bar == 1 ) then bar = ""; end -- First bar's buttons aren't named CT1
	local button = getglobal("CT" .. bar .. "_ActionButton" .. id);
	if ( button:GetButtonState() == "PUSHED" ) then
		button:SetButtonState("NORMAL");
		-- Used to save a macro
		if ( MacroFrame_SaveMacro ) then
			MacroFrame_SaveMacro();
		end

		if ( CT_NextSelfCast ) then
			UseAction(CT_ActionButton_GetPagedID(button), 0, 1);
		else
			UseAction(CT_ActionButton_GetPagedID(button), 1, nil);
			if ( SpellIsTargeting() and CT_SelfCast == 1 and SpellCanTargetUnit("player") ) then
				SpellTargetUnit("player");
			end
		end
		if ( CT_DebuffTimers_AddDebuff ) then
			CT_DebuffTimers_AddDebuff(CT_ActionButton_GetPagedID(button));
		end
		if ( IsCurrentAction(CT_ActionButton_GetPagedID(button)) ) then
			button:SetChecked(1);
		else
			button:SetChecked(0);
		end
	end
	CT_NextSelfCast = nil;
end

CT_oldActionButtonUp = ActionButtonUp;

function CT_newActionButtonUp(id, onSelf)
	if ( CT_NextSelfCast ) then
		CT_oldActionButtonUp(id, 1);
	else
		CT_oldActionButtonUp(id, onSelf);
		if ( SpellIsTargeting() and CT_SelfCast == 1 and SpellCanTargetUnit("player") ) then
			SpellTargetUnit("player");
		end
	end
	CT_NextSelfCast = nil;
end

ActionButtonUp = CT_newActionButtonUp;

CT_oldActionButtonDown = ActionButtonDown;

function CT_newActionButtonDown(id)
	CT_oldActionButtonDown(id);
	if ( CT_SelfCastModifier ) then
		CT_NextSelfCast = 1;
	end
end

ActionButtonDown = CT_newActionButtonDown;

function CT_LHotbar_Update()
	local modStatusLeft = "on";
	for key, val in CT_Mods do
		if ( val["modName"] == BARMOD_MODNAME_LEFTHB ) then
			modStatusLeft = val["modStatus"];
		end
	end
	if ( modStatusLeft == "off" ) then
		CT_HotbarLeft:Hide();
	else
		CT_HotbarLeft:Show();
		if ( not CT_BABar_Drag:IsUserPlaced() ) then
			CT_BABar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", -461, 128);
		end
		if ( not CT_PetBar_Drag:IsUserPlaced() ) then
			CT_PetBar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", -453, 122);
		end
	end
end
function CT_RHotbar_Update()
	local modStatusRight = "on";
	for key, val in CT_Mods do
		if ( val["modName"] == BARMOD_MODNAME_RIGHTHB ) then
			modStatusRight = val["modStatus"];
		end
	end
	if ( modStatusRight == "off" ) then
		CT_HotbarRight:Hide();
	else
		CT_HotbarRight:Show();
	end
end
function CT_THotbar_Update()
	local modStatusTop = "on";
	for key, val in CT_Mods do
		if ( val["modName"] == BARMOD_MODNAME_TOPHB ) then
			modStatusTop = val["modStatus"];
		end
	end
	if ( modStatusTop == "off" ) then
		CT_HotbarTop:Hide();
	else
		CT_HotbarTop:Show();
	end
end

function CT_ActionButton_ShowGrid()
	if ( CT_Sidebar_ButtonInUse(this) or ( strsub( this:GetName(), 1, 3 ) ~= "CT3" and strsub( this:GetName(), 1, 3 ) ~= "CT4" ) ) then
		this.showgrid = this.showgrid+1;
		getglobal(this:GetName().."NormalTexture"):SetVertexColor(1.0, 1.0, 1.0, 1.0);
		this:Show();
	end
end

function CT_GetBagColumns()
	local freeScreenHeight = GetScreenHeight() - CONTAINER_OFFSET;
	local index = 1;
	local column = 0;
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		if ( getglobal("ContainerFrame" .. i):IsVisible() ) then
			column = 1; break;
		end
	end
	while ContainerFrame1.bags[index] do
		local frame = getglobal(ContainerFrame1.bags[index]);
		-- freeScreenHeight determines when to start a new column of bags
		if ( freeScreenHeight < frame:GetHeight() and index > 1 ) then
			column = column + 1;
			freeScreenHeight = UIParent:GetHeight() - CONTAINER_OFFSET;	
		end
		freeScreenHeight = freeScreenHeight - frame:GetHeight() - VISIBLE_CONTAINER_SPACING;
		index = index + 1;
	end
	return column;
end

function CT_HideButtons(buttonname, unt, stop, hidebefore)
	for i=1, stop, 1 do
		local button = getglobal(buttonname .. i);
		if ( i <= unt ) then
			if ( hidebefore == 1 ) then
				button:Hide();
			else
				button:Show();
			end
		else
			if ( hidebefore == 1 ) then
				button:Show();
			else
				button:Hide();
			end
		end
	end
end

CT_oldActionButton_OnUpdate = ActionButton_OnUpdate;

function CT_newActionButton_OnUpdate(elapsed)
	if ( this.rangeTimer and this.rangeTimer <= elapsed ) then
		if ( IsActionInRange( ActionButton_GetPagedID(this)) == 0 ) then
			this.inRange = 0;
		else
			this.inRange = 1;
		end
		ActionButton_UpdateUsable();
	end
	CT_oldActionButton_OnUpdate(elapsed);
end

ActionButton_OnUpdate = CT_newActionButton_OnUpdate;

CT_oldActionButton_UpdateUsable = ActionButton_UpdateUsable;

function CT_newActionButton_UpdateUsable()
	CT_oldActionButton_UpdateUsable();
	local icon = getglobal(this:GetName().."Icon");
	local isUsable, notEnoughMana = IsUsableAction(ActionButton_GetPagedID(this));
	if ( isUsable ) then
		if ( this.inRange and this.inRange == 0 ) then
			icon:SetVertexColor(CT_FadeColor.r, CT_FadeColor.g, CT_FadeColor.b);
		end
	end
end

ActionButton_UpdateUsable = CT_newActionButton_UpdateUsable;

function CT_ActionButton_UpdateUsable()
	local icon = getglobal(this:GetName().."Icon");
	local normalTexture = getglobal(this:GetName().."NormalTexture");
	local isUsable, notEnoughMana = IsUsableAction(CT_ActionButton_GetPagedID(this));
	if ( isUsable ) then
		if ( this.inRange and this.inRange == 0 ) then
			icon:SetVertexColor(CT_FadeColor.r, CT_FadeColor.g, CT_FadeColor.b);
			if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(CT_FadeColor.r, CT_FadeColor.g, CT_FadeColor.b); end
		else
			icon:SetVertexColor(1.0, 1.0, 1.0);
			if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(1.0, 1.0, 1.0); end
		end
	elseif ( notEnoughMana ) then
		icon:SetVertexColor(0.5, 0.5, 1.0);
		if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(0.5, 0.5, 1.0); end
	else
		icon:SetVertexColor(0.4, 0.4, 0.4);
		if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(0.4, 0.4, 0.4); end
	end
end

function CT_ActionButton_OnUpdate(elapsed)
	if ( ActionButton_IsFlashing() ) then
		this.flashtime = this.flashtime - elapsed;
		if ( this.flashtime <= 0 ) then
			local overtime = -this.flashtime;
			if ( overtime >= ATTACK_BUTTON_FLASH_TIME ) then
				overtime = 0;
			end
			this.flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

			local flashTexture = getglobal(this:GetName().."Flash");
			if ( flashTexture:IsVisible() ) then
				flashTexture:Hide();
			else
				flashTexture:Show();
			end
		end
	end
	

	if ( this.rangeTimer ) then
		if ( this.rangeTimer < 0 ) then
			local count = getglobal(this:GetName().."HotKey");
			if ( IsActionInRange( CT_ActionButton_GetPagedID(this)) == 0 ) then
				count:SetVertexColor(1.0, 0.1, 0.1);
				this.inRange = 0;
			else
				count:SetVertexColor(1.0, 1.0, 1.0);
				this.inRange = 1;
			end
			this.rangeTimer = TOOLTIP_UPDATE_TIME;
			CT_ActionButton_UpdateUsable();
		else
			this.rangeTimer = this.rangeTimer - elapsed;
		end
	end

	if ( not this.updateTooltip ) then
		return;
	end

	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then
		return;
	end

	if ( GameTooltip:IsOwned(this) ) then
		CT_ActionButton_SetTooltip();
	else
		this.updateTooltip = nil;
	end
end

function CT_Sidebar_ChangeAxis(bar, force)
	local curraxis = CT_SidebarAxis[bar];
	if ( force ) then
		curraxis = force;
	end
	if ( curraxis == 1 ) then
		CT_SidebarAxis[tonumber(bar)] = 2;
	else
		CT_SidebarAxis[tonumber(bar)] = 1;
	end
	if ( CT_BarModOptions_Options[UnitName("player")] ) then
		CT_BarModOptions_RemoveSpaceBars(CT_BarModOptions_Options[UnitName("player")]["removeBars"])
	else
		CT_BarModOptions_RemoveSpaceBars();
	end
end

BLIZZARD_Original_updateContainerFrameAnchors = updateContainerFrameAnchors;

function updateContainerFrameAnchors()
	CT_Bag_Update();
end

function CT_updateContainerFrameAnchors()
	local freeScreenHeight = GetScreenHeight() - CONTAINER_OFFSET;
	local index = 1;
	local column = 0;
	while ContainerFrame1.bags[index] do
		local frame = getglobal(ContainerFrame1.bags[index]);
		if ( index == 1 ) then
			frame:SetPoint("BOTTOMRIGHT", frame:GetParent():GetName(), "BOTTOMRIGHT", -40, CONTAINER_OFFSET);
		elseif ( freeScreenHeight < frame:GetHeight() ) then
			column = column + 1;
			freeScreenHeight = UIParent:GetHeight() - CONTAINER_OFFSET;
			frame:SetPoint("BOTTOMRIGHT", frame:GetParent():GetName(), "BOTTOMRIGHT", -(column * CONTAINER_WIDTH + 40), CONTAINER_OFFSET);
		else
			frame:SetPoint("BOTTOMRIGHT", ContainerFrame1.bags[index - 1], "TOPRIGHT", 0, CONTAINER_SPACING);	
		end
		freeScreenHeight = freeScreenHeight - frame:GetHeight() - VISIBLE_CONTAINER_SPACING;
		index = index + 1;
	end
	return column;
end

function CT_Bag_Update()
	if ( CT_HotbarTop:IsVisible() ) then	
		CONTAINER_OFFSET = 110;
	elseif ( CT_HotbarRight:IsVisible() ) then
		CONTAINER_OFFSET = 90;
	else
		CONTAINER_OFFSET = 70;
	end

	if ( CT_SidebarFrame2:IsVisible() ) then
		CT_updateContainerFrameAnchors();		
	else
		BLIZZARD_Original_updateContainerFrameAnchors();
	end

end

CT_oldFCF_UpdateDockPosition = FCF_UpdateDockPosition;
CT_newFCF_UpdateDockPosition = function() end;

function CT_GlobalFrame_OnUpdate(elapsed)
	this.update = this.update + elapsed;
	if ( SIMPLE_CHAT == "1" and this.update > 0.05 ) then
		FCF_UpdateDockPosition = CT_newFCF_UpdateDockPosition;
		this.update = this.update - 0.05;
		ChatFrame2:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -32, 95);
		if ( ShapeshiftBarFrame:IsVisible() ) then
			ChatFrame1:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 32, 138);
		elseif ( PetActionBarFrame:IsVisible() ) then
			ChatFrame1:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 32, 130);
		else
			ChatFrame1:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", 32, 95);
		end
	else
		FCF_UpdateDockPosition = CT_oldFCF_UpdateDockPosition;
	end
	this.updateCDC = this.updateCDC + elapsed;
	if ( this.updateCDC >= 0.25 ) then
		this.updateCDC = 0;
		local currTime = GetTime();
		for k, v in CT_BarMod_Cooldowns do
			CT_BarMod_Cooldowns[k][3] = floor((v[1]+v[2])-currTime);
			if ( CT_BarMod_Cooldowns[k][3] <= 0 ) then
				CT_BarMod_Cooldowns[k] = nil;
			end
		end
		CT_BarMod_UpdateCooldownCount();
	end
end

sidebarfunction = function()
	if ( CT_SidebarFrame:IsVisible() ) then
		CT_SidebarFrame:Hide();
		CT_SetModStatus(BARMOD_MODNAME_LEFTSB, "off");
		CT_Print(BARMOD_OFF_LEFTSBAR, 1.0, 1.0, 0.0);
	else
		if ( CT_MF_ShowFrames ) then
			CT_SidebarLeft_Drag:Show();
		end
		CT_SidebarFrame:Show();
		CT_SetModStatus(BARMOD_MODNAME_LEFTSB, "on");
		CT_Print(BARMOD_ON_LEFTSBAR, 1.0, 1.0, 0.0);
	end
end
sidebarRfunction = function()
	if ( CT_SidebarFrame2:IsVisible() ) then
		CT_SidebarFrame2:Hide();
		CT_SetModStatus(BARMOD_MODNAME_RIGHTSB, "off");
		CT_Print(BARMOD_OFF_RIGHTSBAR, 1.0, 1.0, 0.0);
	else
		if ( CT_MF_ShowFrames ) then
			CT_SidebarRight_Drag:Show();
		end
		CT_SidebarFrame2:Show();
		CT_SetModStatus(BARMOD_MODNAME_RIGHTSB, "on");
		CT_Print(BARMOD_ON_RIGHTSBAR, 1.0, 1.0, 0.0);
	end
-- dbrong
	CT_Bag_Update();
end
lsidebarbuttonsfunction = function(modID, text)
	local val = CT_Mods[modID]["modValue"];
	if ( val == "6" or val == 6 ) then
		val = "9";
	elseif ( val == "9" or val == 9 ) then
		val = "12";
	elseif ( val == "12" or val == 12 ) then
		val = "6";
	end
	if ( text ) then text:SetText(val); end
	CT_Mods[modID]["modValue"] = val;
	LCT_SidebarBtns_Update(modID);
end
hotbarleftfunction = function (modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_HotbarLeft:Hide();
		CT_LeftHotbar_OnHide();
		CT_Print(BARMOD_OFF_LEFTHBAR, 1.0, 1.0, 0.0);
	else
		if ( CT_MF_ShowFrames ) then
			CT_HotbarLeft_Drag:Show();
		end
		local x = CT_PetBar_Drag:GetLeft()-(UIParent:GetRight()/2);
		local y = CT_PetBar_Drag:GetBottom()+40;
		CT_PetBar_Drag:ClearAllPoints();
		CT_PetBar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", x, y);

		x = CT_BABar_Drag:GetLeft()-(UIParent:GetRight()/2);
		y = CT_BABar_Drag:GetBottom()+40;
		CT_BABar_Drag:ClearAllPoints();
		CT_BABar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", x, y);
		CT_HotbarLeft:Show();
		CT_Print(BARMOD_ON_LEFTHBAR, 1.0, 1.0, 0.0);
	end
end
hotbarrightfunction = function (modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_HotbarRight:Hide();
		CT_Print(BARMOD_OFF_RIGHTHBAR, 1.0, 1.0, 0.0);
	else
		if ( CT_MF_ShowFrames ) then
			CT_HotbarRight_Drag:Show();
		end
		CT_HotbarRight:Show();
		CT_Print(BARMOD_ON_RIGHTHBAR, 1.0, 1.0, 0.0);
	end
	CT_Bag_Update();
end

hotbartopfunction = function ()
	if ( CT_HotbarTop:IsVisible() ) then
		CT_HotbarTop:Hide();
		CT_SetModStatus(BARMOD_MODNAME_TOPHB, "off");
		CT_Print(BARMOD_OFF_TOPBAR, 1.0, 1.0, 0.0);
	else
		if ( CT_MF_ShowFrames ) then
			CT_HotbarTop_Drag:Show();
		end
		CT_HotbarTop:Show();
		CT_SetModStatus(BARMOD_MODNAME_TOPHB, "on");
		CT_Print(BARMOD_ON_TOPBAR, 1.0, 1.0, 0.0);
	end
	CT_Bag_Update();
end
function gridinitfunction(modId)
	local val = CT_Mods[modId]["modStatus"];
	local i;
	if ( val == "off" ) then
		CT_ShowGrid = 1;
	else
		CT_ShowGrid = 0;
		for i=1, 12, 1 do
			CT_ActionButton_HideGrid(getglobal("ActionButton" .. i));
			CT_ActionButton_HideGrid(getglobal("BonusActionButton" .. i));
			CT_ActionButton_HideGrid(getglobal("MultiBarLeftButton" .. i));
			CT_ActionButton_HideGrid(getglobal("MultiBarRightButton" .. i));
			CT_ActionButton_HideGrid(getglobal("MultiBarBottomLeftButton" .. i));
			CT_ActionButton_HideGrid(getglobal("MultiBarBottomRightButton" .. i));
			CT_ActionButton_HideGrid(getglobal("CT_ActionButton" .. i));
			CT_ActionButton_HideGrid(getglobal("CT2_ActionButton" .. i));
			CT_ActionButton_HideGrid(getglobal("CT3_ActionButton" .. i));
			CT_ActionButton_HideGrid(getglobal("CT4_ActionButton" .. i));
			CT_ActionButton_HideGrid(getglobal("CT5_ActionButton" .. i));
		end
	end
end

function movefunction(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_Print(BARMOD_OFF_MOVEPARTYFRAME);
		CT_CheckPartyMove();
	elseif ( val == "on" ) then
		CT_Print(BARMOD_ON_MOVEPARTYFRAME);
		CT_CheckPartyMove();
	end
end

function CT_CheckPartyMove()
	if ( CT_MovableParty_IsInstalled ) then
		for i = 1, 4, 1 do
			CT_LinkFrameDrag(getglobal("PartyMemberFrame" .. i), getglobal("CT_MovableParty" .. i .. "_Drag"), "TOPLEFT", "TOPLEFT", -40, -7);
		end
		return;
	elseif ( CT_GetModStatus(BARMOD_MODNAME_MOVEPARTYFRAME) == "on" ) then
		local offset = -128;
		if ( UnitExists("pet") ) then
			offset = -160;
		end
		PartyMemberFrame1:ClearAllPoints();
		PartyMemberFrame1:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 50, offset);
	else
		local offset = -128;
		if ( UnitExists("pet") ) then
			offset = -160;
		end
		PartyMemberFrame1:ClearAllPoints();
		PartyMemberFrame1:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 10, offset);
	end
	for i = 2, 4, 1 do
		getglobal("PartyMemberFrame" .. i):ClearAllPoints();
		getglobal("PartyMemberFrame" .. i):SetPoint("TOPLEFT", "PartyMemberFrame" .. (i-1) .. "PetFrame", "BOTTOMLEFT", -23, -10);
	end
end

CT_oldPickupAction = PickupAction;
CT_PickupAction = function(x)
	if ( not CT_HotbarButtons_Locked or IsShiftKeyDown() ) then
		if ( this ) then
			CT_BarMod_Cooldowns[this:GetName()] = nil;
			CT_BarMod_UpdateCooldownCount();
		end
		CT_oldPickupAction(x);
	end
end
PickupAction = CT_PickupAction;

function cooldownfunction(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_Print(BARMOD_OFF_COOLDOWNCOUNT, 1, 1, 0);
		CT_CDCount = 0;
		CT_BarMod_UpdateCooldownCount();
	elseif ( val == "on" ) then
		CT_Print(BARMOD_ON_COOLDOWNCOUNT, 1, 1, 0);
		CT_CDCount = 1;
		CT_BarMod_UpdateCooldownCount();
	end
end

function cooldowninitfunction(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "off" ) then
		CT_CDCount = 0;
		CT_BarMod_UpdateCooldownCount();
	elseif ( val == "on" ) then
		CT_CDCount = 1;
		CT_BarMod_UpdateCooldownCount();
	end
end
--[[
CT_RegisterMod(BARMOD_MODNAME_LEFTSB, BARMOD_ONOFFTOGGLE, 2, "Interface\\Icons\\Spell_Holy_MindVision", BARMOD_TOOLTIP_LEFTSB, "off", nil, sidebarfunction, CT_LSidebar_Update);
CT_RegisterMod(BARMOD_MODNAME_RIGHTSB, BARMOD_ONOFFTOGGLE, 2, "Interface\\Icons\\Spell_Holy_MindVision", BARMOD_TOOLTIP_RIGHTSB, "off", nil, sidebarRfunction, CT_RSidebar_Update);
CT_RegisterMod(BARMOD_MODNAME_LEFTHB, BARMOD_ONOFFTOGGLE, 2, "Interface\\Icons\\Spell_Holy_MindVision", BARMOD_TOOLTIP_LEFTHB, "off", nil, hotbarleftfunction, CT_LHotbar_Update);
CT_RegisterMod(BARMOD_MODNAME_RIGHTHB, BARMOD_ONOFFTOGGLE, 2, "Interface\\Icons\\Spell_Holy_MindVision", BARMOD_TOOLTIP_RIGHTHB, "off", nil, hotbarrightfunction, CT_RHotbar_Update);
CT_RegisterMod(BARMOD_MODNAME_TOPHB, BARMOD_ONOFFTOGGLE, 2, "Interface\\Icons\\Spell_Holy_MindVision", BARMOD_TOOLTIP_TOPHB, "off", nil, hotbartopfunction, CT_THotbar_Update);

CT_RegisterMod(BARMOD_MODNAME_PAGELOCK, BARMOD_SUB_PAGELOCK, 2, "Interface\\Icons\\INV_Misc_Key_03", BARMOD_TOOLTIP_PAGELOCK, "off", nil, HotbarsLockFunction, HotbarsLockInitFunction);
CT_RegisterMod(BARMOD_MODNAME_BUTTONLOCK, BARMOD_SUB_BUTTONLOCK, 2, "Interface\\Icons\\INV_Misc_Key_13", BARMOD_TOOLTIP_BUTTONLOCK, "off", nil, HotbarButtonsLockFunction, CT_ButtonLock_Update);
CT_RegisterMod(BARMOD_MODNAME_HIDEGRID, BARMOD_SUB_HIDEGRID, 2, "Interface\\Icons\\Ability_Vanish", BARMOD_TOOLTIP_HIDEGRID, "off", nil, gridfunction, gridinitfunction);
]]
CT_RegisterMod(BARMOD_MODNAME_MOVEPARTYFRAME, BARMOD_ONOFFTOGGLE, 2, "Interface\\Icons\\Spell_Holy_MindSooth", BARMOD_TOOLTIP_MOVEPARTYFRAME, "off", nil, movefunction, CT_CheckPartyMove);
CT_RegisterMod(BARMOD_MODNAME_COOLDOWNCOUNT, BARMOD_SUB_COOLDOWNCOUNT, 2, "Interface\\Icons\\INV_Misc_PocketWatch_01", BARMOD_TOOLTIP_COOLDOWNCOUNT, "off", nil, cooldownfunction, cooldowninitfunction);

CT_PetBar_DragFrame_Orientation = "H";
CT_BABar_DragFrame_Orientation = "H";
CT_Show_PetBarDrag = 0;

function CT_Bar_DragFrame_OnMD(force)
	local var, type;
	if ( this == CT_PetBar_Drag ) then
		var = CT_PetBar_DragFrame_Orientation;
		type = "PetAction";
	else
		var = CT_BABar_DragFrame_Orientation;
		type = "Shapeshift";
	end
	if ( arg1 == "LeftButton" ) then
			this:StartMoving();
	else
		if ( var == "H" or force ) then
			var = "V";
		else
			var = "H";
		end
		local i;
		for i = 2, 10, 1 do
			getglobal(type .. "Button" .. i):ClearAllPoints();
			if ( var == "H" ) then
				getglobal(type .. "Button" .. i):SetPoint("LEFT", type .. "Button" .. (i-1), "RIGHT", 8, 0);
			else
				getglobal(type .. "Button" .. i):SetPoint("TOP", type .. "Button" .. (i-1), "BOTTOM", 0, -8);
			end
		end
	end
	if ( this == CT_PetBar_Drag ) then
		CT_PetBar_DragFrame_Orientation = var;
	else
		CT_BABar_DragFrame_Orientation = var;
	end
	if ( CT_BarModOptions_RemoveSpaceSpecial ) then
		CT_BarModOptions_RemoveSpaceSpecial(CT_BarModOptions_Options[UnitName("player")]["removeSpecial"]);
	end
	if ( CT_BottomBar_HideTextures ) then
		CT_BottomBar_HideTextures(CT_BottomBar_HiddenFrames[UnitName("player")]["ClassBackground"]);
	end
end

function CT_BarMod_CheckRotations()
	for key, val in CT_SidebarAxis do
		if ( val == 1 ) then val = 2; else val = 1; end
		CT_Sidebar_ChangeAxis(tonumber(key), val);
	end
end

local oorfunc = function(modId, text)
	local val = CT_Mods[modId]["modValue"];
	if ( val == "1" ) then
		val = "2"
		CT_FadeColor = { ["r"] = 0.5, ["g"] = 0.5, ["b"] = 0.5 };
		CT_Print(BARMOD_ON_OOR1, 1, 1, 0);
	elseif ( val == "2" ) then
		val = "3";
		CT_FadeColor = { ["r"] = 0.8, ["g"] = 0.4, ["b"] = 0.4 };
		CT_Print(BARMOD_ON_OOR2, 1, 1, 0);
	elseif ( val == "3" ) then
		val = "1";
		CT_FadeColor = { ["r"] = 1, ["g"] = 1, ["b"] = 1 };
		CT_Print(BARMOD_OFF_OOR, 1, 1, 0);
	end
	if ( text ) then text:SetText(val); end
	CT_Mods[modId]["modValue"] = val;
	CT_Mods[modId]["modStatus"] = "switch";
end

local oorinitfunc = function(modId)
	local val = CT_Mods[modId]["modValue"];
	if ( val == "2" ) then
		CT_FadeColor = { ["r"] = 0.5, ["g"] = 0.5, ["b"] = 0.5 };
	elseif ( val == "3" ) then
		CT_FadeColor = { ["r"] = 0.8, ["g"] = 0.4, ["b"] = 0.4 };
	elseif ( val == "1" ) then
		CT_FadeColor = { ["r"] = 1, ["g"] = 1, ["b"] = 1 };
	end
end

local selffunc = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_SelfCast = 1;
		CT_Print(BARMOD_ON_SELFCAST, 1, 1, 0);
	else
		CT_Print(BARMOD_OFF_SELFCAST, 1, 1, 0);
		CT_SelfCast = 0;
	end
end

local selfinitfunc = function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_SelfCast = 1;
	else
		CT_SelfCast = 0;
	end
end

local hotkeyfunc = function(modId, text)
	local val = CT_Mods[modId]["modValue"];
	if ( val == "3" ) then
		val = "1";
		CT_ShowHotkeys = nil;
		CT_Print(BARMOD_ON_HOTKEY1, 1, 1, 0);
	elseif ( val == "1" ) then
		val = "2";
		CT_ShowHotkeys = 1;
		CT_Print(BARMOD_ON_HOTKEY2, 1, 1, 0);
	elseif ( val == "2" ) then
		val = "3";
		CT_ShowHotkeys = -1;
		CT_Print(BARMOD_OFF_HOTKEY, 1, 1, 0);
	end
	CT_BarMod_UpdateAllHotkeys();
	if ( text ) then
		text:SetText(val);
	end
	CT_Mods[modId]["modValue"] = val;
end

local hotkeyinitfunc = function(modId)
	local val = CT_Mods[modId]["modValue"];
	if ( val == "1" ) then
		CT_ShowHotkeys = nil;
	elseif ( val == "2" ) then
		CT_ShowHotkeys = 1;
	elseif ( val == "3" ) then
		CT_ShowHotkeys = -1;
	end
	CT_BarMod_UpdateAllHotkeys();
	CT_Mods[modId]["modStatus"] = "switch";
end

function cskeyfunc(modId, text)
	local val = CT_Mods[modId]["modValue"];
	if ( val == "Ctrl" ) then
		val = "Alt";
		CT_SelfCastModKey = IsAltKeyDown;
		CT_Print(BARMOD_ON_SCKEY2, 1, 1, 0);
	elseif ( val == "Alt" ) then
		val = "Shift";
		CT_SelfCastModKey = IsShiftKeyDown;
		CT_Print(BARMOD_ON_SCKEY3, 1, 1, 0);
	elseif ( val == "Shift" ) then
		val = "None";
		CT_SelfCastModKey = nil;
		CT_Print(BARMOD_ON_SCKEY4, 1, 1, 0);
	elseif ( val == "None" ) then
		val = "Ctrl";
		CT_SelfCastModKey = IsControlKeyDown;
		CT_Print(BARMOD_ON_SCKEY1, 1, 1, 0);
	end
	CT_Mods[modId]["modValue"] = val;
	if ( text ) then text:SetText(val); end
end

function cskeyinitfunc(modId, text)
	local val = CT_Mods[modId]["modValue"];
	if ( val == "Alt" ) then
		CT_SelfCastModKey = IsAltKeyDown;
	elseif ( val == "Shift" ) then
		CT_SelfCastModKey = IsShiftKeyDown;
	elseif ( val == "Ctrl" ) then
		CT_SelfCastModKey = IsControlKeyDown;
	end
end

CT_RegisterMod(BARMOD_MODNAME_OOR, BARMOD_SUB_OOR, 2, "Interface\\Icons\\Ability_TownWatch", BARMOD_TOOLTIP_OOR, "switch", "1", oorfunc, oorinitfunc);
CT_RegisterMod(BARMOD_MODNAME_HOTKEYS, BARMOD_SUB_HOTKEYS, 2, "Interface\\Icons\\INV_Misc_Key_09", BARMOD_TOOLTIP_HOTKEYS, "switch", "1", hotkeyfunc, hotkeyinitfunc);

--CT_RegisterMod(BARMOD_MODNAME_TTPOS, BARMOD_SUB_TTPOS, 5, "Interface\\Icons\\Ability_Mount_WhiteTiger", BARMOD_TOOLTIP_TTPOS, "off", nil, ttfunc, ttinitfunc);

CT_RegisterMod(BARMOD_MODNAME_SCKEY, BARMOD_SUB_SCKEY, 4, "Interface\\Icons\\Spell_Holy_GreaterHeal", BARMOD_TOOLTIP_SCKEY, "switch", "None", cskeyfunc, cskeyinitfunc);
CT_RegisterMod(BARMOD_MODNAME_SELFCAST, BARMOD_SUB_SELFCAST, 4, "Interface\\Icons\\Spell_Holy_GreaterHeal", BARMOD_TOOLTIP_SELFCAST, "off", nil, selffunc, selfinitfunc);

function CT_ActionButton_OnClick()
	if ( ( strsub( this:GetName(), 1, 3 ) ~= "CT3" and strsub( this:GetName(), 1, 3 ) ~= "CT4" ) or CT_Sidebar_ButtonInUse(this) ) then

		if ( IsShiftKeyDown() ) then
			PickupAction(CT_ActionButton_GetPagedID(this));
		else
			if ( MacroFrame_SaveMacro ) then
				MacroFrame_SaveMacro();
			end
			if ( CT_NextSelfCast ) then
				UseAction(CT_ActionButton_GetPagedID(this), 0, 1);
			else
				UseAction(CT_ActionButton_GetPagedID(this), 1, nil);
				if ( SpellIsTargeting() and CT_SelfCast == 1 and not SpellCanTargetUnit("target") and SpellCanTargetUnit("player") ) then
					SpellTargetUnit("player");
				end
			end
		end
		CT_ActionButton_Update();
		CT_ActionButton_UpdateState();
	end
end

CT_oldUseAction = UseAction;

function CT_newUseAction(id, cursor, onSelf)
	if ( ( CT_SelfCastModifier and CT_SelfCast == 1 )  or ( CT_SelfCastModKey and CT_SelfCastModKey() ) ) then
		onSelf = 1;
	end
	CT_oldUseAction(id, cursor, onSelf);
	if ( SpellIsTargeting() and CT_SelfCast == 1 and not SpellCanTargetUnit("target") and SpellCanTargetUnit("player") ) then
		SpellTargetUnit("player");
	end
end

UseAction = CT_newUseAction;

CT_BarMod_oldUseContainerItem = UseContainerItem;
function CT_BarMod_newUseContainerItem(bag, item)
	CT_BarMod_oldUseContainerItem(bag, item);
	if ( ( CT_SelfCast == 1 or ( CT_SelfCastModKey and CT_SelfCastModKey() ) ) and SpellIsTargeting() and not SpellCanTargetUnit("target") and SpellCanTargetUnit("player") ) then
		SpellTargetUnit("player");
	end
end
UseContainerItem = CT_BarMod_newUseContainerItem;

function CT_BarMod_UpdateAllHotkeys()
	local key = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=" };
	local i;
	for i = 1, 12, 1 do
		CT_ActionButton_UpdateHotkeys(getglobal("CT_ActionButton" .. i));
		CT_ActionButton_UpdateHotkeys(getglobal("CT2_ActionButton" .. i));
		CT_ActionButton_UpdateHotkeys(getglobal("CT3_ActionButton" .. i));
		CT_ActionButton_UpdateHotkeys(getglobal("CT4_ActionButton" .. i));
		CT_ActionButton_UpdateHotkeys(getglobal("CT5_ActionButton" .. i));

		if ( CT_ShowHotkeys and CT_ShowHotkeys == -1 ) then
			getglobal("ActionButton" .. i .. "HotKey"):Hide();
			getglobal("BonusActionButton" .. i .. "HotKey"):Hide();
			getglobal("MultiBarBottomLeftButton" .. i .. "HotKey"):Hide();
			getglobal("MultiBarBottomRightButton" .. i .. "HotKey"):Hide();
			getglobal("MultiBarLeftButton" .. i .. "HotKey"):Hide();
			getglobal("MultiBarRightButton" .. i .. "HotKey"):Hide();
		else
			getglobal("ActionButton" .. i .. "HotKey"):Show();
			getglobal("BonusActionButton" .. i .. "HotKey"):Show();
			getglobal("MultiBarBottomLeftButton" .. i .. "HotKey"):Show();
			getglobal("MultiBarBottomRightButton" .. i .. "HotKey"):Show();
			getglobal("MultiBarLeftButton" .. i .. "HotKey"):Show();
			getglobal("MultiBarRightButton" .. i .. "HotKey"):Show();
			if ( not CT_ShowHotkeys ) then
				getglobal("ActionButton" .. i .. "HotKey"):SetText(key[i]);
				getglobal("BonusActionButton" .. i .. "HotKey"):SetText(key[i]);
				getglobal("MultiBarBottomLeftButton" .. i .. "HotKey"):Show();
				getglobal("MultiBarBottomRightButton" .. i .. "HotKey"):Show();
				getglobal("MultiBarLeftButton" .. i .. "HotKey"):Show();
				getglobal("MultiBarRightButton" .. i .. "HotKey"):Show();
			else
				getglobal("ActionButton" .. i .. "HotKey"):SetText(GetBindingText(GetBindingKey("ACTIONBUTTON" .. i), "KEY_"));
				getglobal("BonusActionButton" .. i .. "HotKey"):SetText(GetBindingText(GetBindingKey("ACTIONBUTTON" .. i), "KEY_"));
				getglobal("MultiBarBottomLeftButton" .. i .. "HotKey"):SetText(GetBindingText(GetBindingKey("MULTIACTIONBAR1BUTTON" .. i), "KEY_"));
				getglobal("MultiBarBottomRightButton" .. i .. "HotKey"):SetText(GetBindingText(GetBindingKey("MULTIACTIONBAR2BUTTON" .. i), "KEY_"));
				getglobal("MultiBarLeftButton" .. i .. "HotKey"):SetText(GetBindingText(GetBindingKey("MULTIACTIONBAR4BUTTON" .. i), "KEY_"));
				getglobal("MultiBarRightButton" .. i .. "HotKey"):SetText(GetBindingText(GetBindingKey("MULTIACTIONBAR3BUTTON" .. i), "KEY_"));
			end
		end
	end
end

CT_oldActionButton_UpdateHotkeys = ActionButton_UpdateHotkeys;

function CT_newActionButton_UpdateHotkeys()
	local key = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=" };
	if ( not CT_ShowHotkeys ) then
		getglobal(this:GetName() .. "HotKey"):SetText(key[this:GetID()]);
		getglobal(this:GetName() .. "HotKey"):Show();
	else
		CT_ActionButton_UpdateHotkeys();
	end
end

ActionButton_UpdateHotkeys = CT_newActionButton_UpdateHotkeys;

CT_oldPickupPetAction = PickupPetAction;
function CT_newPickupPetAction(arg)
	if ( not CT_HotbarButtons_Locked or IsShiftKeyDown() ) then
		CT_oldPickupPetAction(arg);
	end
end
PickupPetAction = CT_newPickupPetAction;

function CT_HotbarToggle(num)
	local arr = {
		"CT_HotbarLeft",
		"CT_HotbarRight",
		"CT_SidebarFrame",
		"CT_SidebarFrame2",
		"CT_HotbarTop"
	};

	if ( getglobal(arr[num]):IsVisible() ) then
		getglobal(arr[num]):Hide();
	else
		getglobal(arr[num]):Show();
	end
end

CT_oldSPAB = ShowPetActionBar;
function CT_newSPAB()
	CT_oldSPAB();
	if ( PetActionBarFrame:IsVisible() and CT_MF_ShowFrames ) then
		CT_PetBar_Drag:Show();
	else
		CT_PetBar_Drag:Hide();
	end
end
ShowPetActionBar = CT_newSPAB;

function CT_LeftHotbar_OnHide()
	local x = CT_BABar_Drag:GetLeft()-(UIParent:GetRight()/2);
	local y = CT_BABar_Drag:GetBottom()-40;
	CT_BABar_Drag:ClearAllPoints();
	CT_BABar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", x, y);

	x = CT_PetBar_Drag:GetLeft()-(UIParent:GetRight()/2);
	y = CT_PetBar_Drag:GetBottom()-40;
	CT_PetBar_Drag:ClearAllPoints();
	CT_PetBar_Drag:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOM", x, y);
end

-- Functions to display grid

function CT_updateActionButtons()
	for i = 1, 12, 1 do
		local ab = getglobal("ActionButton" .. i);
		if ( CT_BottomBar_Enabled and CT_BottomBar_Enabled[UnitName("player")] and CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbar"] ) then
			ab.showgrid = 0;
			ab:Hide();
		elseif ( not HasAction(ActionButton_GetPagedID(ab)) ) then
			if ( CT_ShowGrid ) then
				ab.showgrid = 1;
				ab:Show();
			else
				ab.showgrid = 0;
				ab:Hide();
			end
		elseif ( GetBonusBarOffset() > 0 ) then
			ab.showgrid = 0;
			ab:Hide();
		else
			ab.showgrid = 1;
			ab:Show();
		end
		--[[local ab = getglobal("ActionButton" .. i);
		if ( not HasAction(ActionButton_GetPagedID(ab)) or CT_ShowGrid ) then
			if ( 
				( not CT_ShowGrid and not HasAction(CT_ActionButton_GetPagedID(ab)) ) or 
				GetBonusBarOffset() > 0 or
				( not CT_BottomBar_Enabled or not CT_BottomBar_Enabled[UnitName("player")] or 
					( not CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] and 
					not CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbarBackgroundLeft"] ) 
				)
			) then 
				ab.showgrid = 0;
				ab:Hide();
			else
				ab.showgrid = 1;
				ab:Show();
			end
		end
		ab = getglobal("BonusActionButton" .. i);
		if ( not HasAction(ActionButton_GetPagedID(ab)) or CT_ShowGrid ) then
			if ( 
				GetBonusBarOffset() == 0 or
				( not CT_ShowGrid and not HasAction(CT_ActionButton_GetPagedID(ab)) ) or 
				( not CT_BottomBar_Enabled or not CT_BottomBar_Enabled[UnitName("player")] or 
					( not CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] and 
					not CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbarBackgroundLeft"] ) 
				)
			) then 
				ab.showgrid = 0;
				ab:Hide();
			else
				ab.showgrid = 1;
				ab:Show();
			end
		end]]
		local ab = getglobal("BonusActionButton" .. i);
		if ( CT_BottomBar_Enabled and CT_BottomBar_Enabled[UnitName("player")] and CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbar"] ) then
			ab.showgrid = 0;
			ab:Hide();
		elseif ( not HasAction(ActionButton_GetPagedID(ab)) ) then
			if ( CT_ShowGrid ) then
				ab.showgrid = 1;
				ab:Show();
			else
				ab.showgrid = 0;
				ab:Hide();
			end
		elseif ( GetBonusBarOffset() == 0 ) then
			ab.showgrid = 0;
			ab:Hide();
		else
			ab.showgrid = 1;
			ab:Show();
		end
		ab = getglobal("MultiBarBottomLeftButton" .. i);
		if ( not HasAction(ActionButton_GetPagedID(ab)) and ab.showgrid == 0 ) then
			if ( not CT_ShowGrid ) then
				ab.showgrid = 0;
				ab:Hide();
			else
				ab.showgrid = 1;
				ab:Show();
			end
		end
		ab = getglobal("MultiBarBottomRightButton" .. i);
		if ( not HasAction(ActionButton_GetPagedID(ab)) and ab.showgrid == 0 ) then
			if ( not CT_ShowGrid ) then
				ab.showgrid = 0;
				ab:Hide();
			else
				ab.showgrid = 1;
				ab:Show();
			end
		end
		ab = getglobal("MultiBarLeftButton" .. i);
		if ( not HasAction(ActionButton_GetPagedID(ab)) and ab.showgrid == 0 ) then
			if ( not CT_ShowGrid ) then
				ab.showgrid = 0;
				ab:Hide();
			else
				ab.showgrid = 1;
				ab:Show();
			end
		end
		ab = getglobal("MultiBarRightButton" .. i);
		if ( not HasAction(ActionButton_GetPagedID(ab)) and ab.showgrid == 0 ) then
			if ( not CT_ShowGrid ) then 
				ab.showgrid = 0;
				ab:Hide();
			else
				ab.showgrid = 1;
				ab:Show();
			end
		end
	end
end

CT_oldActionButton_Update = ActionButton_Update;
function CT_newActionButton_Update()
	CT_oldActionButton_Update();
	if ( not HasAction(CT_ActionButton_GetPagedID(this)) and this.showgrid == 0 ) then
		if ( not CT_ShowGrid or ( ( not CT_BottomBar_Enabled or not CT_BottomBar_Enabled[UnitName("player")] or ( not CT_BottomBar_RotatedFrames[UnitName("player")]["Bars"] and not CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbarBackgroundLeft"] ) ) and ( strsub(this:GetName(), 1, 12) == "ActionButton" or strsub(this:GetName(), 1, 17) == "BonusActionButton" ) ) ) then 
			this.showgrid = 0;
			this:Hide();
			return;
		else
			this.showgrid = 1;
			this:Show();
			return;
		end
	end
	if ( 
		( strsub(this:GetName(), 1, 12) == "ActionButton" and GetBonusBarOffset() > 0 ) or 
		( strsub(this:GetName(), 1, 12) == "MultiBarLeft" and not SHOW_MULTI_ACTIONBAR_4 ) or
		( strsub(this:GetName(), 1, 13) == "MultiBarRight" and not SHOW_MULTI_ACTIONBAR_3 ) or
		( strsub(this:GetName(), 1, 18) == "MultiBarBottomLeft" and not SHOW_MULTI_ACTIONBAR_1 ) or
		( strsub(this:GetName(), 1, 19) == "MultiBarBottomRight" and not SHOW_MULTI_ACTIONBAR_2 ) or
		( strsub(this:GetName(), 1, 17) == "BonusActionButton" and GetBonusBarOffset() == 0 ) 
	) then
		this.showgrid = 0;
		this:Hide();
	elseif ( CT_ShowGrid ) then
		this.showgrid = 1;
		this:Show();
	end
end
ActionButton_Update = CT_newActionButton_Update;

function CT_newActionButton_UpdateUsable()
	local icon = getglobal(this:GetName().."Icon");
	if ( not icon ) then
		return;
	end
	local normalTexture = getglobal(this:GetName().."NormalTexture");
	local isUsable, notEnoughMana = IsUsableAction(ActionButton_GetPagedID(this));
	if ( isUsable ) then
		if ( this.inRange and this.inRange == 0 ) then
			icon:SetVertexColor(CT_FadeColor.r, CT_FadeColor.g, CT_FadeColor.b);
			if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(CT_FadeColor.r, CT_FadeColor.g, CT_FadeColor.b); end
		else
			icon:SetVertexColor(1.0, 1.0, 1.0);
			if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(1.0, 1.0, 1.0); end
		end
	elseif ( notEnoughMana ) then
		icon:SetVertexColor(0.5, 0.5, 1.0);
		if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(0.5, 0.5, 1.0); end
	else
		icon:SetVertexColor(0.4, 0.4, 0.4);
		if ( not CT_ShowGrid ) then normalTexture:SetVertexColor(0.4, 0.4, 0.4); end
	end
end
ActionButton_UpdateUsable = CT_newActionButton_UpdateUsable;

ActionButton_HideGrid = CT_ActionButton_HideGrid;

function CT_newActionButton_ShowGrid(button)
	if ( not button ) then
		button = this;
	end
	button.showgrid = button.showgrid+1;
	getglobal(button:GetName().."NormalTexture"):SetVertexColor(1.0, 1.0, 1.0, 1.0);

	if ( 
		( strsub(button:GetName(), 1, 12) == "ActionButton" and ( ( CT_BottomBar_Enabled and CT_BottomBar_Enabled[UnitName("player")] and CT_BottomBar_HiddenFrames[UnitName("player")] and CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbar"] ) or GetBonusBarOffset() > 0 ) ) or
		( strsub(button:GetName(), 1, 12) == "MultiBarLeft" and not SHOW_MULTI_ACTIONBAR_4 ) or
		( strsub(button:GetName(), 1, 13) == "MultiBarRight" and not SHOW_MULTI_ACTIONBAR_3 ) or
		( strsub(button:GetName(), 1, 18) == "MultiBarBottomLeft" and not SHOW_MULTI_ACTIONBAR_1 ) or
		( strsub(button:GetName(), 1, 19) == "MultiBarBottomRight" and not SHOW_MULTI_ACTIONBAR_2 )
	) then
		button:Hide();
	elseif ( strsub(button:GetName(), 1, 17) == "BonusActionButton" and ( ( CT_BottomBar_Enabled and CT_BottomBar_Enabled[UnitName("player")] and CT_BottomBar_HiddenFrames[UnitName("player")] and CT_BottomBar_HiddenFrames[UnitName("player")]["BarHotbar"] ) or GetBonusBarOffset() == 0 ) ) then
		button:Hide();
	else
		button:Show();
	end
end
ActionButton_ShowGrid = CT_newActionButton_ShowGrid;

CT_oldActionButton_OnEvent = ActionButton_OnEvent;
function CT_newActionButton_OnEvent(event)

	if ( event == "UPDATE_BONUS_ACTIONBAR" ) then
		ActionButton_Update();
	else
		CT_oldActionButton_OnEvent(event);
	end
end
ActionButton_OnEvent = CT_newActionButton_OnEvent;

MultiActionBar_UpdateGrid = function(barName)
	for i=1, NUM_MULTIBAR_BUTTONS do
		if ( CT_ShowGrid ) then
			ActionButton_ShowGrid(getglobal(barName.."Button"..i));
		else
			ActionButton_HideGrid(getglobal(barName.."Button"..i));
		end
	end
end

function CT_BarMod_GetSpellName(id)
	if ( not CTTooltip ) then
		return;
	end
	CTTooltipTextLeft1:SetText("");
	CTTooltip:SetAction(id);
	local name = CTTooltipTextLeft1:GetText();
	if ( name and name ~= "" ) then
		return name;
	end
end

CT_BarMod_Cooldowns = { };
CT_BarMod_oldCooldownFrame_SetTimer = CooldownFrame_SetTimer;
function CT_BarMod_newCooldownFrame_SetTimer(this, start, duration, enable)
	CT_BarMod_oldCooldownFrame_SetTimer(this, start, duration, enable);
	if ( duration >= 2 and start > 0 and enable > 0 ) then
		CT_BarMod_Cooldowns[this:GetParent():GetName()] = { start, duration, duration, CT_BarMod_GetSpellName(CT_ActionButton_GetPagedID(this:GetParent())) };
	else
		CT_BarMod_Cooldowns[this:GetParent():GetName()] = nil;
	end
end
CooldownFrame_SetTimer = CT_BarMod_newCooldownFrame_SetTimer;

function CT_BarMod_UpdateCooldownCount(btn)
	if ( not btn ) then
		for b = 1, 7, 1 do
			local prefix = "CT" .. b .. "_";
			if ( b == 1 ) then
				prefix = "CT_";
			elseif ( b == 6 ) then
				prefix = "";
			elseif ( b == 7 ) then
				prefix = "Bonus";
			end
			for i = 1, 12, 1 do
				if ( CT_CDCount == 1 ) then
					local name = prefix .. "ActionButton" .. i;
					local btn = getglobal(name);
					local id = CT_ActionButton_GetPagedID(btn);
					local count = getglobal(name .. "CDCount");
					if ( CT_BarMod_Cooldowns[name] and CT_BarMod_Cooldowns[name][3] > 0 ) then
						local form = CT_BarMod_FormatCooldown(CT_BarMod_Cooldowns[name][3]);
						count:Show();
						count:SetText(form);
					else
						count:Hide();
					end
				else
					getglobal(prefix .. "ActionButton" .. i .. "CDCount"):Hide();
				end
			end
		end
	else
		if ( CT_CDCount == 1 ) then
			local name = btn:GetName();
			local id = CT_ActionButton_GetPagedID(btn);
			local count = getglobal(btn:GetName() .. "CDCount");
			if ( CT_BarMod_Cooldowns[name] and CT_BarMod_Cooldowns[name][3] > 0 ) then
				local form = CT_BarMod_FormatCooldown(CT_BarMod_Cooldowns[name][3]);
				count:Show();
				count:SetText(form);
			else
				count:Hide();
			end
		else
			getglobal(btn:GetName() .. "CDCount"):Hide();
		end
	end
end

function CT_BarMod_FormatCooldown(cd)
	if ( cd >= 3600 ) then
		return floor(cd/3600) .. "h";
	elseif ( cd > 60 ) then
		local m = mod(cd, 60);
		if ( m < 10 ) then
			m = "0" .. m;
		end
		return floor(cd/60) .. ":" .. m;
	else
		return cd;
	end
end

function CT_BarMod_FindRanges()
	CT_BarMod_MaxRanges = { };
	CT_BarMod_MinRanges = { };
	for i = 1, 120, 1 do
		CTTooltipTextLeft1:SetText("");
		CTTooltip:SetAction(i);
		if ( CTTooltipTextLeft1:GetText() and CTTooltipTextLeft1:GetText() ~= "" ) then
			local range;
			for y = 1, CTTooltip:NumLines(), 1 do
				CT_Print("Looping " .. y .. "/" .. CTTooltip:NumLines());
				local useless, useless, maxRange = string.find(getglobal("CTTooltipTextRight" .. y):GetText() or "", "^(%d+) yd range$");
				if ( maxRange ) then
					CT_BarMod_MaxRanges[i] = tonumber(maxRange);
					break;
				else
					local useless, useless, maxRange = string.find(getglobal("CTTooltipTextLeft" .. y):GetText() or "", "^(%d+) yd range$");
					if ( maxRange ) then
						CT_BarMod_MaxRanges[i] = tonumber(maxRange);
						break;
					else
						local useless, useless, minRange, maxRange = string.find(getglobal("CTTooltipTextRight" .. y):GetText() or "", "^(%d+)%-(%d+) yd range$");
						if ( str ) then
							CT_BarMod_MaxRanges[i] = tonumber(maxRange);
							CT_BarMod_MinRanges[i] = tonumber(minRange);
							break;
						else
							local useless, useless, minRange, maxRange = string.find(getglobal("CTTooltipTextLeft" .. y):GetText() or "", "^(%d+)%-(%d+) yd range$");
							if ( str ) then
								CT_BarMod_MaxRanges[i] = tonumber(maxRange);
								CT_BarMod_MinRanges[i] = tonumber(minRange);
								break;
							end
						end
					end
				end
			end
		end
	end
end

function CT_BarMod_FindTargetRange()
	if ( not UnitExists("target") ) then
		return "";
	end
	local currMin = 0;
	local currMax = 1000;
	for k, v in CT_BarMod_MaxRanges do
		if ( IsActionInRange(v) == 1 and v < currMax ) then
			break;
		end
	end
end

function CT_BarMod_SetCCScaling(scale)
	if ( not CT_BarMod_EnteredWorld ) then
		CT_BarMod_RequiresScalingUpdate = scale;
		return;
	end
	for i = 1, 12, 1 do
		getglobal("CT_ActionButton" .. i .. "CD"):SetScale(scale);
		getglobal("CT2_ActionButton" .. i .. "CD"):SetScale(scale);
		getglobal("CT3_ActionButton" .. i .. "CD"):SetScale(scale);
		getglobal("CT4_ActionButton" .. i .. "CD"):SetScale(scale);
		getglobal("CT5_ActionButton" .. i .. "CD"):SetScale(scale);
		getglobal("ActionButton" .. i .. "CD"):SetScale(scale);
		getglobal("BonusActionButton" .. i .. "CD"):SetScale(scale);
		
		getglobal("CT_ActionButton" .. i .. "CD").scale = scale;
		getglobal("CT2_ActionButton" .. i .. "CD").scale = scale;
		getglobal("CT3_ActionButton" .. i .. "CD").scale = scale;
		getglobal("CT4_ActionButton" .. i .. "CD").scale = scale;
		getglobal("CT5_ActionButton" .. i .. "CD").scale = scale;
		getglobal("ActionButton" .. i .. "CD").scale = scale;
		getglobal("BonusActionButton" .. i .. "CD").scale = scale;
	end
end

if ( CT_CPFrame_ShowSlider ) then
	-- Add stuff for CC scaling
	local function ccscalingonchangefunc(modName, value)
		if ( value ) then
			CT_Mods[modName]["modValue"] = value;
			CT_BarMod_SetCCScaling(value);
			CT_SaveInfoName(modName);
		end
	end
	
	local function ccscalinginitfunction(modName)
		CT_BarMod_SetCCScaling(CT_Mods[modName]["modValue"] or 1);
	end
	
	local function ccscalingfunction(modName, button)
		if ( CT_CPFrame_IsSliderVisible() ) then
			CT_CPFrame_HideSlider();
		else
			CT_CPFrame_ShowSlider(button, modName, ( CT_Mods[modName]["modValue"] or 1 ), ccscalingonchangefunc, 0.75, 1.5, 0.05, "0.75", "1.5", modName, "Drag this slider to increase or decrease the size of the CooldownCount text", "%s");
		end
	end
	CT_RegisterMod(BARMOD_MODNAME_CCSCALING, BARMOD_SUB_CCSCALING, 2, "Interface\\Icons\\Spell_Holy_MindVision", BARMOD_TOOLTIP_CCSCALING, "slider", nil, ccscalingfunction, ccscalinginitfunction);
end