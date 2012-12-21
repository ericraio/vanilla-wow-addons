DL_VARIABLES_LOADED = nil;
DL_ENTERING_WORLD = nil;

DL_INIT_FUNCTIONS = {};
DL_FRAME_FUNCTIONS = {};

DL_Old_UseAction = UseAction;

DL_Old_PickupAction = PickupAction;
DL_Old_PlaceAction = PlaceAction;

function DL_PickupAction(action)
	DL_Old_PickupAction(action);
	DL_Update_ActionList();
end

function DL_PlaceAction(action)
	DL_Old_PlaceAction(action);
	DL_Update_ActionList();
end

PickupAction = DL_PickupAction;
PlaceAction = DL_PlaceAction;

function DiscordLib_Main_OnEvent(event)
	if (event == "CHAT_MSG_COMBAT_SELF_MISSES" or event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		if (string.find(arg1, DL_TEXT.Dodge)) then
			DL_TARGET_DODGED = 6;
		elseif (string.find(arg1, DL_TEXT.Parry)) then
			DL_TARGET_PARRIED = 6;
		elseif (string.find(arg1, DL_TEXT.Block)) then
			DL_TARGET_BLOCKED = 6;
		end
	elseif (event == "PARTY_MEMBERS_CHANGED") then
		for i=1,4 do
			DL_Update_Auras("party"..i);
		end
	elseif (event == "PET_ATTACK_START") then
		DL_PETATTACKING = true;
	elseif (event == "PET_ATTACK_STOP") then
		DL_PETATTACKING = nil;
	elseif (event == "PLAYER_AURAS_CHANGED") then
		DL_Update_Auras("player");
	elseif (event == "PLAYER_ENTER_COMBAT") then
		DL_ATTACKING = true;
		DL_INCOMBAT = true;
	elseif (event == "PLAYER_ENTERING_WORLD") then
		DL_ENTERING_WORLD = true;
		DL_ATTACKING = nil;
		DL_INCOMBAT = nil;
		DL_REGEN = true;
		if ( DL_VARIABLES_LOADED ) then
			DL_START_CHECKING_FRAME = true;
		end
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		DL_ATTACKING = nil;
		if (DL_REGEN) then
			DL_INCOMBAT = nil;
		end
	elseif (event == "PLAYER_REGEN_DISABLED") then
		DL_REGEN = nil;
		DL_INCOMBAT = true;
	elseif (event == "PLAYER_REGEN_ENABLED") then
		DL_REGEN = true;
		if (not DL_ATTACKING) then
			DL_INCOMBAT = nil;
		end
	elseif (event == "PLAYER_TARGET_CHANGED") then
		DL_Update_Auras("target");
	elseif (event == "RAID_ROSTER_UPDATE") then
		for i=1,40 do
			DL_Update_Auras("raid"..i);
		end
	elseif (event == "UNIT_AURA") then
		if (arg1 ~= "mouseover" and arg1 ~= "player") then
			DL_Update_Auras(arg1);
		end
	elseif (event == "UNIT_PET") then
		DL_Update_Auras("pet");
		for i=1,4 do
			DL_Update_Auras("partypet"..i);
		end
	elseif (event == "UPDATE_SHAPESHIFT_FORMS") then
		DL_Update_Forms();
	elseif (event == "VARIABLES_LOADED") then
		DL_VARIABLES_LOADED = true;
		if ( DL_ENTERING_WORLD ) then
			DL_START_CHECKING_FRAME = true;
		end
	end
end

function DiscordLib_Main_OnLoad()
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PET_ATTACK_START");
	this:RegisterEvent("PET_ATTACK_STOP");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_PET");
	this:RegisterEvent("UPDATE_SHAPESHIFT_FORMS");
	this:RegisterEvent("VARIABLES_LOADED");

	SlashCmdList["DISCLIB"] = DL_Slash_Handler;
	SLASH_DISCLIB1 = "/disclib";
end

function DL_Slash_Handler(msg)
	if (msg == "nobuffchecking") then
		if (DiscordLibrary_Settings.disableBuffChecking) then
			DiscordLibrary_Settings.disableBuffChecking = nil;
			DL_Feedback("Discord Library's buff/debuff checking has been turned on.");
			DiscordLib_MainFrame:RegisterEvent("UNIT_AURA");
			DiscordLib_MainFrame:RegisterEvent("PLAYER_AURAS_CHANGED");
			DL_Update_Auras("player");
			DL_Update_Auras("pet");
			DL_Update_Auras("target");
			for i=1,4 do
				DL_Update_Auras("party"..i);
				DL_Update_Auras("partypet"..i);
			end
			for i=1,40 do
				DL_Update_Auras("raid"..i);
			end
		else
			DiscordLibrary_Settings.disableBuffChecking = 1;
			DL_Feedback("Discord Library's buff/debuff checking has been turned off.");
			DL_BUFFS = {};
			DL_DEBUFFS = {};
			DL_STATUS = {};
			DiscordLib_MainFrame:UnregisterEvent("UNIT_AURA");
			DiscordLib_MainFrame:UnregisterEvent("PLAYER_AURAS_CHANGED");
		end
	end
end

function DiscordLib_Main_OnUpdate(elapsed)
	if (DL_TARGET_DODGED) then
		DL_TARGET_DODGED = DL_TARGET_DODGED - elapsed;
		if (DL_TARGET_DODGED < 0) then DL_TARGET_DODGED = nil; end
	end
	if (DL_TARGET_BLOCKED) then
		DL_TARGET_BLOCKED = DL_TARGET_BLOCKED - elapsed;
		if (DL_TARGET_BLOCKED < 0) then DL_TARGET_BLOCKED = nil; end
	end
	if (DL_TARGET_PARRIED) then
		DL_TARGET_PARRIED = DL_TARGET_PARRIED - elapsed;
		if (DL_TARGET_PARRIED < 0) then DL_TARGET_PARRIED = nil; end
	end
	if (this.inittimer) then
		this.inittimer = this.inittimer - elapsed;
		if (this.inittimer < 0) then
			this.inittimer = nil;
			DiscordLib_Initialize();
		end
	else
		if (DL_START_CHECKING_FRAME and (not DISCORDLIB_INITIALIZED)) then
			if (ZoneTextFrame:GetCenter()) then
				this.inittimer = 1;
			end
		end
	end
end

function DL_UnitName(unit)
	local name = UnitName(unit);
	if (name == UNKNOWNOBJECT or name == UKNOWNBEING) then
		return nil;
	else
		return name;
	end
end

DL_Old_MoneyFrame_Update = MoneyFrame_Update
function MoneyFrame_Update(frameName, money)
	if (not money) then return end
	DL_Old_MoneyFrame_Update(frameName, money)
end

--[[DL_Old_ChatEdit_OnEnterPressed = ChatEdit_OnEnterPressed
function ChatEdit_OnEnterPressed()
	local f = this:GetName()
	DL_Debug(f)
	if (string.find(f, "DAB_")) then
		return
	end
	DL_Old_ChatEdit_OnEnterPressed()
end

DL_Old_ChatEdit_OnEscapePressed = ChatEdit_OnEscapePressed
function ChatEdit_OnEscapePressed(editBox)
	if (not editBox) then return end
	if (not editBox.SetText) then return end
	DL_Old_ChatEdit_OnEscapePressed(editBox)
end
--]]
function DiscordLib_Initialize()
	if (DISCORDLIB_INITIALIZED) then return; end

	if (not DiscordLibrary_Settings) then
		DiscordLibrary_Settings = {}
	end

	DL_Old_ColorPickerFrame_OnColorSelect = ColorPickerFrame:GetScript("OnColorSelect");
	ColorPickerFrame:SetScript("OnColorSelect", function() DL_Old_ColorPickerFrame_OnColorSelect(); DL_ColorBox_UpdateDisplay(); end);

	for i=2,30 do
		local left = getglobal("DiscordLib_AuraTooltipTextLeft"..i)
		for i,v in left do
			if (type(v) == "function") then
				left[i] = function() end
			end
		end
		local left = getglobal("DiscordLib_AuraTooltipTextRight"..i)
		for i,v in left do
			if (type(v) == "function") then
				left[i] = function() end
			end
		end
	end
	for i,v in DiscordLib_AuraTooltipTextLeft1 do
		if (type(v) == "function" and i ~= "GetText" and i ~= "SetText" and i ~= "Hide" and i ~= "Show") then
			DiscordLib_AuraTooltipTextLeft1[i] = function() end
		end
	end
	for i,v in DiscordLib_AuraTooltipTextRight1 do
		if (type(v) == "function" and i ~= "GetText" and i ~= "SetText" and i ~= "Hide" and i ~= "Show") then
			DiscordLib_AuraTooltipTextRight1[i] = function() end
		end
	end
	
	DiscordLib_Tooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
	DiscordLib_AuraTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");

	DL_Update_ActionList();
	DL_Init_AnchorFramesList();
	DL_Init_UnitsList();
	DL_TEXTURES_LIST = { {text="", value=""} };
	DL_Init_FontsList();
	DL_Update_Forms();
		DL_Update_Auras("player");
	DL_Update_Auras("pet");
	for i=1,4 do
		DL_Update_Auras("party"..i);
		DL_Update_Auras("partypet"..i);
	end
	for i=1,40 do
		DL_Update_Auras("raid"..i);
	end
	for index, initFunction in DL_FRAME_FUNCTIONS do
		initFunction();
	end
	for index, initFunction in DL_INIT_FUNCTIONS do
		initFunction();
	end

	DISCORDLIB_INITIALIZED = true;
	DL_INIT_FUNCTIONS = nil;
end

function DiscordLib_RegisterInitFunc(func, delay)
	DL_INIT_FUNCTIONS_INDEX = DL_INIT_FUNCTIONS_INDEX + 1;
	DL_INIT_FUNCTIONS[DL_INIT_FUNCTIONS_INDEX] = func;
end

function DiscordLib_RegisterFrameCreationFunc(func)
	DL_FRAME_FUNCTIONS_INDEX = DL_FRAME_FUNCTIONS_INDEX + 1
	DL_FRAME_FUNCTIONS[DL_FRAME_FUNCTIONS_INDEX] = func
end

function DL_ActionUsable(action)
	local cd = DL_CooldownLeft(action);
	if (cd > 0) then return; end
	local isUsable, notEnoughMana = IsUsableAction(action);
	if (not isUsable) then return; end
	if (notEnoughMana) then return; end
	local range = IsActionInRange(action);
	if (range ~= 0) then return true; end
end

function DL_AddToMenu(menu, text, value, desc)
	if (not text) then return; end
	if (not value) then value = text; end
	if (desc == 1) then
		desc = value;
		if (desc and string.len(desc) > 25) then
			desc = string.sub(desc, 1, 25).."\n"..string.sub(desc, 26);
		end
	end
	local found;
	for _, val in menu do
		if (val.value == value) then
			found = 1;
			break;
		end
	end
	if (not found) then
		menu[table.getn(menu) + 1] = { text=text, value=value, desc=desc };
	end
end

function DL_Alphabetic_Insert(table, value, subindex, start)
	local insertIndex;
	for i,v in table do
		if ( strlower(value[subindex])<strlower(v[subindex]) or strlower(value[subindex])==strlower(v[subindex]) ) then
			if ((start and i >= start) or (not start)) then
				insertIndex = i;
				break;
			end
		end
	end
	tinsert(table, insertIndex, value);
end

function DL_AttackTarget()
	if (UnitHealth("target") and UnitHealth("target") <= 0) then return; end
	local _, class = UnitClass("player");
	if (class == "ROGUE" and DL_Get_ShapeshiftForm() == 1) then return; end
	if (class == "DRUID" and DL_Get_ShapeshiftForm() == 3) then return; end
	if (UnitCanAttack("player","target")) then
		if (not DL_ATTACKING) then
			AttackTarget(); 
		end
	end
end

function DL_CheckBuff(unit, buff)
	if (not DL_BUFFS[unit]) then return; end
	for i=1,16 do
		if (DL_BUFFS[unit][i]) then
			if (string.find(DL_BUFFS[unit][i], buff, 1, true)) then
				return true;
			end
		else
			break;
		end
	end
end

function DL_CheckDebuff(unit, buff)
	if (not DL_DEBUFFS[unit]) then return; end
	for i=1,16 do
		if (DL_DEBUFFS[unit][i]) then
			if (string.find(DL_DEBUFFS[unit][i], buff, 1, true)) then
				return i;
			end
		else
			break;
		end
	end
end

function DL_CheckStatus(unit, status)
	if (not DL_STATUS[unit]) then return 0; end
	local count = 0;
	for i=1,16 do
		if (DL_STATUS[unit][i] == status) then
			count = count + 1;
		end
	end
	return count;
end

function DL_CleanUp_TempOptions(menu)
	if (menu.addedoptions) then
		for i in menu.addedoptions do
			getglobal(menu.table)[i] = nil;
		end
	end
end

function DL_ColorBox_UpdateColor()
	if (not this:GetText() or this:GetText() == "") then return; end
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local id = this:GetID();
	if (id == 1) then
		r = this:GetNumber();
		if (not r) then r = 0; end
	elseif (id == 2) then
		g = this:GetNumber();
		if (not g) then g=0; end
	else
		b = this:GetNumber();
		if (not b) then b=0; end
	end
	ColorPickerFrame:SetColorRGB(r, g, b);
end

function DL_ColorBox_UpdateDisplay()
	if (DL_COLORBOX_FOCUS) then return; end
	local r, g, b = ColorPickerFrame:GetColorRGB();
	DL_RedBox:SetNumber(DL_round(r, 4));
	DL_GreenBox:SetNumber(DL_round(g, 4));
	DL_BlueBox:SetNumber(DL_round(b, 4));
end

function DL_Compare(val1, val2, method)
	if (method == 1) then
		if (val1 > val2) then return 1; else return; end
	elseif (method == 2) then
		if (val1 >= val2) then return 1; else return; end
	elseif (method == 3) then
		if (val1 == val2) then return 1; else return; end
	elseif (method == 4) then
		if (val1 <= val2) then return 1; else return; end
	elseif (method == 5) then
		if (val1 < val2) then return 1; else return; end
	end
end

function DL_CooldownLeft(action)
	local start, duration, enable = GetActionCooldown(action);
	if (start and duration and enable) then
		local remaining = duration - (GetTime() - start);
		if (remaining > 0) then
			return remaining;
		else
			return 0;
		end
	else
		return 0;
	end
end

function DL_Copy_Table(src, dest)
	for index, value in src do
		if (type(value) == "table") then
			dest[index] = {};
			DL_Copy_Table(value, dest[index]);
		else
			dest[index] = value;
		end
	end
end

function DL_Debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage( msg, 1.0, 0.0, 0.0 );
end

function DL_Error(msg)
	if (not DL_ScriptErrors:IsVisible()) then
		DL_ScriptErrors_Message:SetText(msg);
		DL_ScriptErrors:Show();
	else
		DL_ERRORS_QUEUE[table.getn(DL_ERRORS_QUEUE) + 1] = msg;
	end
end

function DL_Feedback(msg)
	DEFAULT_CHAT_FRAME:AddMessage( msg, 1.0, 1.0, 0.0 );
end

function DL_Get_ActionName(id, ranktoggle)
	if (not id) then return ""; end
	if (not HasAction(id)) then return ""; end
	DiscordLib_Tooltip:SetOwner(WorldFrame, "ANCHOR_NONE", 100, 100);
	DiscordLib_Tooltip:SetAction(id);
	local name, rank = "";
	if (DiscordLib_TooltipTextLeft1:IsShown()) then
		name = DiscordLib_TooltipTextLeft1:GetText();
	end
	if (DiscordLib_TooltipTextRight1:IsShown()) then
		rank = DiscordLib_TooltipTextRight1:GetText();
	end
	if (ranktoggle) then
		return name, rank;		
	else
		if (not rank) then
			return name;
		else
			return name.." ("..rank..")";
		end
	end
end

function DL_Get_Backdrop(index)
	-- returns bgtexture, bordertexture, tile, tileSize, edgeSize, left, right, top, bottom
	if (index == 1) then
		return "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop", "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop",  true, 8, 1, 1, 1, 1, 1;
	elseif (index == 2) then
		return "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop", "Interface\\Tooltips\\UI-Tooltip-Border", true, 16, 16, 5, 5, 5, 5;
	elseif (index == 3) then
		return "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop", "Interface\\DialogFrame\\UI-DialogBox-Border", true, 32, 32, 11, 12, 12, 11;
	elseif (index == 4) then
		return "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop", "Interface\\Buttons\\UI-SliderBar-Border", true, 8, 8, 3, 3, 6, 6;
	elseif (index == 5) then
		return "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop", "Interface\\Glues\\Common\\Glue-Tooltip-Border", true, 16, 16, 10, 5, 4, 9;
	end
end

function DL_Get_Health(unit)
	local health;
	if (unit == "target" and MobHealth_GetTargetCurHP) then
		health = MobHealth_GetTargetCurHP();
		if ((not health) or health == 0) then health = UnitHealth(unit); end
	elseif (string.find(unit, "target") and MobHealth_PPP) then
		if (UnitName(unit) and UnitLevel(unit)) then
			local mhindex = UnitName(unit)..":"..UnitLevel(unit);
			local ppp = MobHealth_PPP(mhindex);
			health = math.floor(UnitHealth(unit) * ppp + 0.5);
		end
		if (health == 0 or (not health)) then health = UnitHealth(unit); end
	else
		health = UnitHealth(unit);
	end
	return health;
end

function DL_Get_HealthMax(unit)
	local healthmax;
	if (unit == "target" and MobHealth_GetTargetMaxHP and UnitHealth(unit) > 0) then
		healthmax = MobHealth_GetTargetMaxHP();
		if ((not healthmax) or healthmax == 0) then healthmax = UnitHealthMax(unit); end
	elseif (string.find(unit, "target") and MobHealth_PPP) then
		if (UnitName(unit) and UnitLevel(unit)) then
			local mhindex = UnitName(unit)..":"..UnitLevel(unit);
			local ppp = MobHealth_PPP(mhindex);
			healthmax = math.floor(100 * ppp + 0.5);
		end
		if (healthmax == 0 or (not healthmax)) then healthmax = UnitHealthMax(unit); end
	else
		healthmax = UnitHealthMax(unit);
	end
	if (not healthmax) then healthmax = 0; end
	return healthmax;
end

function DL_Get_HexColor(r, g, b)
	return "|cFF"..string.format("%02X%02X%02X", r * 255.0, g * 255.0, b * 255.0);
end

function DL_Get_ItemName(bag, slot)
	local itemname, itemlink = "";
	if (slot) then
		itemlink = GetContainerItemLink(bag,slot);
	else
		itemlink = GetInventoryItemLink("player", bag);
	end
	if (itemlink) then
		itemname = string.sub(itemlink, string.find(itemlink, "[", 1, true) + 1, string.find(itemlink, "]", 1, true) - 1);
	end
	return itemname;
end

function DL_Get_MenuText(menu, value)
	for _, option in menu do
		if (option.value == value) then
			return option.text;
		end
	end
	return "";
end

function DL_Get_LocalKBText(name, prefix, shorten)
	if (not prefix) then
		prefix = "KEY_";
	end
	local tempName = name;
	local i = strfind(name, "-");
	local dashIndex = nil;
	while ( i ) do
		if ( not dashIndex ) then
			dashIndex = i;
		else
			dashIndex = dashIndex + i;
		end
		tempName = strsub(tempName, i + 1);
		i = strfind(tempName, "-");
	end

	local modKeys = '';
	if ( not dashIndex ) then
		dashIndex = 0;
	else
		modKeys = strsub(name, 1, dashIndex);
	end

	local variablePrefix = prefix;
	if ( not variablePrefix ) then
		variablePrefix = "";
	end
	local localizedName = nil;
	if ( IsMacClient() ) then
		-- see if there is a mac specific name for the key
		localizedName = getglobal(variablePrefix..tempName.."_MAC");
	end
	if ( not localizedName ) then
		localizedName = getglobal(variablePrefix..tempName);
	end
	if ( not localizedName ) then
		localizedName = tempName;
	end

	local kbtext = modKeys..localizedName;
	if (shorten) then
		kbtext = string.upper(kbtext);
		kbtext = string.gsub(kbtext, "SHIFT", "S");
		kbtext = string.gsub(kbtext, "CTRL", "C");
		kbtext = string.gsub(kbtext, "ALT", "A");
		kbtext = string.gsub(kbtext, "MOUSE BUTTON", "MB");
		kbtext = string.gsub(kbtext, "BUTTON1", "MB1");
		kbtext = string.gsub(kbtext, "BUTTON2", "MB2");
		kbtext = string.gsub(kbtext, "BUTTON3", "MB3");
		kbtext = string.gsub(kbtext, "BUTTON4", "MB4");
		kbtext = string.gsub(kbtext, "BUTTON5", "MB5");
		kbtext = string.gsub(kbtext, "MIDDLE MOUSE", "MM");
		kbtext = string.gsub(kbtext, "NUM PAD", "NP");
	end

	return kbtext;
end

function DL_Get_KeybindingText(name, prefix, shorten)
	local kbtext, kbtext2 = GetBindingKey(name);
	if ( not kbtext ) then
		kbtext = "";
	else
		kbtext = DL_Get_LocalKBText(kbtext, prefix, shorten);
	end
	if ( not kbtext2 ) then
		kbtext2 = "";
	else
		kbtext2 = DL_Get_LocalKBText(kbtext2, prefix, shorten);
	end
	return kbtext, kbtext2;
end

function DL_Get_Offsets(frame, baseframe, attachpoint, attachto)
	local x1, y1 = DL_Get_Position(frame, attachpoint);
	local x2, y2 = DL_Get_Position(baseframe, attachto);
	local xoffset, yoffset;
	if (x1 and x2 and y1 and y2) then
		local es1, es2 = 1, 1;
		if (baseframe.GetEffectiveScale) then
			es1 = baseframe:GetEffectiveScale();
		end
		if (frame.GetEffectiveScale) then
			es2 = frame:GetEffectiveScale();
		end
		xoffset = DL_round(x1 - x2 * es1 / es2, 2);
		yoffset = DL_round(y1 - y2 * es1 / es2, 2);
	end
	return xoffset, yoffset;
end

function DL_Get_Position(frame, attach)
	if (frame.GetCenter and (not frame:GetCenter())) then
		return;
	end
	local x, y;
	if (attach == "TOPLEFT") then
		x = frame:GetLeft();
		y = frame:GetTop();
	elseif (attach == "TOP") then
		x = frame:GetCenter();
		y = frame:GetTop();
	elseif (attach == "TOPRIGHT") then
		x = frame:GetRight();
		y = frame:GetTop();
	elseif (attach == "LEFT") then
		x = frame:GetLeft();
		_, y = frame:GetCenter();
	elseif (attach == "CENTER") then
		x, y = frame:GetCenter();
	elseif (attach == "RIGHT") then
		x = frame:GetRight();
		_, y = frame:GetCenter();
	elseif (attach == "BOTTOMLEFT") then
		x = frame:GetLeft();
		y = frame:GetBottom();
	elseif (attach == "BOTTOM") then
		x = frame:GetCenter();
		y = frame:GetBottom();
	elseif (attach == "BOTTOMRIGHT") then
		x = frame:GetRight();
		y = frame:GetBottom();
	end
	x = DL_round(x, 2);
	y = DL_round(y, 2);
	return x, y;
end

function DL_Get_ShapeshiftForm()
	for i=1,GetNumShapeshiftForms() do
		local _, _, isActive = GetShapeshiftFormInfo(i);
		if isActive == 1 then return i; end
	end
	return 0;
end

function DL_Hook(func, prefix)
	setglobal(prefix.."_Old_"..func, getglobal(func));
	setglobal(func, getglobal(prefix.."_"..func));
end

function DL_Init_AnchorFramesList()
	DL_ANCHOR_FRAMES = {};
	DL_ANCHOR_FRAMES[1] = { text = "UIParent", value="UIParent" };
end

function DL_Init_CheckBox(frame, setting)
	if (setting) then
		frame:SetChecked(1);
	else
		frame:SetChecked(0);
	end
end

function DL_Init_ColorPicker(frame, color)
	if (not color) then
		color = {r=1, g=1, b=1};
	end
	frame:SetBackdropColor(color.r, color.g, color.b);
end

function DL_Init_EditBox(frame, text)
	if (not text) then
		text = "";
	end
	frame.prevvalue = text;
	frame:SetText(text);
end

function DL_Init_FontsList()
	DL_FONTS_LIST = {};
	DL_FONTS_LIST[1] = { text="Fonts\\FRIZQT__.TTF", value="Fonts\\FRIZQT__.TTF", desc="Fonts\\FRIZQT__.TTF" };
	DL_FONTS_LIST[2] = { text="Fonts\\ARIALN.TTF", value="Fonts\\ARIALN.TTF", desc="Fonts\\ARIALN.TTF" };
	DL_FONTS_LIST[3] = { text="Fonts\\skurri.ttf", value="Fonts\\skurri.ttf", desc="Fonts\\skurri.ttf" };
	DL_FONTS_LIST[4] = { text="Fonts\\MORPHEUS.ttf", value="Fonts\\MORPHEUS.ttf", desc="Fonts\\MORPHEUS.ttf" };
end

function DL_Init_MenuControl(frame, setting, override)
	local text;
	for _, value in getglobal(frame.table) do
		if (value.value == setting) then
			text = value.text;
			break;
		end
	end
	if ((not text) and frame.addoptions) then
		for _, value in frame.addoptions do
			if (value.value == setting) then
				text = value.text;
				break;
			end
		end
	end
	if (not text) then
		if (override) then
			text = setting;
			if (not text) then
				text = "";
			end
		else
			text = "";
		end
	end
	getglobal(frame:GetName().."_Setting"):SetText(text);
end

function DL_Init_Slider(frame, setting)
	if (string.find(frame:GetName(), "DFM") and (not setting)) then
		getglobal(frame:GetName().."_Display"):SetText("");
		return;
	end
	if (frame.scale) then
		setting = setting * frame.scale;
	end
	local min, max = frame:GetMinMaxValues();
	getglobal(frame:GetName().."_Display"):SetText(setting);
	if (setting < min or setting > max) then
		return;
	end
	frame:SetValue(setting);
end

function DL_Init_TabButton(text, selected, func, checked)
	getglobal(this:GetName().."_Border"):SetVertexColor(.4, 0, 0);
	getglobal(this:GetName().."_Text"):SetText(text);
	this.selected = selected;
	this.clickFunc = func;
	if (checked) then
		getglobal(this:GetName().."_Text"):SetTextColor(1, 0, 0);
		getglobal(this:GetName().."_Background"):SetVertexColor(1, 1, 0);
		if (selected) then
			setglobal(selected, this:GetName());
		end
	else
		getglobal(this:GetName().."_Background"):SetVertexColor(0, 0, 0);
	end
end

function DL_Init_UnitsList()
	DL_UNITS_LIST = {};
	DL_UNITS_LIST[1] = {text=""};
	DL_UNITS_LIST[2] = {text="player (you)", value="player"};
	DL_UNITS_LIST[3] = {text="pet", value="pet"};
	DL_UNITS_LIST[4] = {text="target", value="target"};
	for i=1,4 do
		DL_UNITS_LIST[i + 4] = {text="party"..i, value="party"..i};
		DL_UNITS_LIST[i + 8] = {text="partypet"..i, value="partypet"..i};
	end
	for i=1,40 do
		DL_UNITS_LIST[i + 12] = {text="raid"..i, value="raid"..i};
	end
end

function DL_IsMouseOver(frame)
	local lowx = frame:GetLeft();
	local highx = frame:GetRight();
	local lowy = frame:GetBottom();
	local highy = frame:GetTop();
	if (not lowx or not highx or not lowy or not highy) then return; end
	local x, y = GetCursorPosition();
	x = x  / UIParent:GetScale();
	y = y / UIParent:GetScale();
	if (x < lowx or x > highx) then
		return nil;
	end
	if (y < lowy or y > highy) then
		return nil;
	end
	return true;
end

function DL_Layout_VerticalFrames(base, num, onClick)
	local button, prev;
	if (onClick) then
		getglobal(base..1):SetScript("OnClick", onClick);
	end
	for i=2, num do
		button = getglobal(base..i);
		prev = getglobal(base..(i - 1));
		button:ClearAllPoints();
		button:SetPoint("TOP", prev, "BOTTOM", 0, 0);
		if (onClick) then
			button:SetScript("OnClick", onClick);
		end
	end
end

function DL_Layout_Menu(menu, clickFunc)
	local button, button2;
	if (clickFunc) then
		getglobal(menu.."_Option1"):SetScript("OnClick", clickFunc);
	end
	for i=2, getglobal(menu).count do
		button = getglobal(menu.."_Option"..i);
		button2 = menu.."_Option"..(i - 1);
		button:ClearAllPoints();
		button:SetPoint("TOPLEFT", button2, "BOTTOMLEFT", 0, 0);
		if (clickFunc) then
			button:SetScript("OnClick", clickFunc);
		end
	end
end

function DL_Layout_ScrollButtons(base, num, onClick)
	local button, prev;
	if (onClick) then
		getglobal(base..1):SetScript("OnClick", onClick);
		getglobal(base.."1Highlight"):SetVertexColor(1, 0, 1, 1);
		getglobal(base.."1Checked"):SetVertexColor(.7, .7, 0, 1);
	end
	for i=2, num do
		button = getglobal(base..i);
		prev = getglobal(base..(i - 1));
		button:ClearAllPoints();
		button:SetPoint("TOP", prev, "BOTTOM", 0, 0);
		if (onClick) then
			button:SetScript("OnClick", onClick);
			getglobal(base..i.."Highlight"):SetVertexColor(1, 0, 1, 1);
			getglobal(base..i.."Checked"):SetVertexColor(.7, .7, 0, 1);
		end
	end
end

function DL_Menu_Timeout(elapsed)
	if (this.timer) then
		this.timer = this.timer - elapsed;
		if (this.timer < 0) then
			this.timer = nil;
			this:Hide();
		end
	end
end

function DL_NudgeButton_OnLoad()
	if (this:GetID() == 0) then
		this:SetText(0);
	elseif (this:GetID() == 1) then
		this:SetText("^");
	elseif (this:GetID() == 2) then
		this:SetText("v");
	elseif (this:GetID() == 3) then
		this:SetText("<");
	elseif (this:GetID() == 4) then
		this:SetText(">");
	elseif (this:GetID() == 5) then
		this:SetText("-");
	elseif (this:GetID() == 6) then
		this:SetText("+");
	elseif (this:GetID() == 7) then
		this:SetText("R");
	elseif (this:GetID() == 8) then
		this:SetText("L");
	end
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp");
end

function DL_PetAttack()
	if (DL_PETATTACKING) then return; end
	if (not UnitName("target")) then return; end
	if (not UnitCanAttack("pet", "target")) then return; end
	PetAttack();
end

function DL_round(number, precision)
	if (precision > 0) then
		number = number * 10 ^ precision;
	end
	local remainder = number  - math.floor(number);
	if (remainder >= .5) then
		number = math.floor(number) + 1;
	else
		number = math.floor(number);
	end
	if (precision > 0) then
		number = number / 10 ^ precision;
	end
	return number;
end

function DL_ScriptErrors_OK_OnClick()
	if (DL_ERRORS_QUEUE[1]) then
		DL_ScriptErrors_Message:SetText(DL_ERRORS_QUEUE[1]);
		table.remove(DL_ERRORS_QUEUE, 1);
	else
		DL_ScriptErrors:Hide();
	end
end

function DL_Set_Anchor(subframe, xoffset, yoffset, attachpoint, attachto, center, frame)
	if (not frame) then
		frame = this;
	end
	if (not attachpoint) then
		attachpoint = "TOPLEFT";
	end
	if (not attachto) then
		attachto = "BOTTOMLEFT";
	end
	xoffset = getglobal(frame:GetName().."_Label"):GetWidth() + xoffset + 5;
	if (center) then
		xoffset = xoffset / 2;
	end
	frame:ClearAllPoints();
	frame:SetPoint(attachpoint, frame:GetParent():GetName()..subframe, attachto, xoffset, yoffset);
end

function DL_Set_Label(text)
	getglobal(this:GetName().."_Label"):SetText(text);
end

function DL_Set_OptionsTitle(frame, texture, version)
	getglobal(frame.."_TitleFrame_Title"):SetTexture("Interface\\AddOns\\"..texture);
	getglobal(frame.."_TitleFrame_Title"):SetAlpha(1);
	getglobal(frame.."_TitleFrame_Version"):SetText("v"..version);
end

function DL_Set_Timer(id, seconds)
	if (not DL_TIMERS) then DL_TIMERS = {}; end
	DL_TIMERS[id] = seconds;
end

function DL_Show_Menu(toggle)
	if (toggle) then
		this = this:GetParent();
	end
	local menu = getglobal(this.menu);
	if (menu:IsVisible()) then
		menu:Hide();
		DL_CleanUp_TempOptions(menu);
		return;
	end
	if (this.addoptions) then
		menu.addedoptions = {};
		for i,v in this.addoptions do
			tinsert(getglobal(this.table), v);
			menu.addedoptions[table.getn(getglobal(this.table))] = 1;
		end
	else
		menu.addedoptions = nil;
	end
	if (not menu.scrollMenu) then
		local count = 0;
		local widest = 0;
		for _, value in getglobal(this.table) do
			count = count + 1;
			getglobal(this.menu.."_Option"..count):Show();
			getglobal(this.menu.."_Option"..count.."_Text"):SetText(value.text);
			getglobal(this.menu.."_Option"..count).value = value.value;
			getglobal(this.menu.."_Option"..count).desc = value.desc;
			local width = getglobal(this.menu.."_Option"..count.."_Text"):GetWidth();
			if (width > widest) then
				widest = width;
			end
		end
		for i=1, menu.count do
			if (i <= count) then
				getglobal(this.menu.."_Option"..i):SetWidth(widest);
			else
				getglobal(this.menu.."_Option"..i):Hide();			
			end
		end
		menu:SetWidth(widest + 20);
		menu:SetHeight(count * 15 + 20);
	end
	menu:ClearAllPoints();
	local frame = this:GetName();
	menu:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 0);
	if (menu:GetBottom() < UIParent:GetBottom()) then
		local yoffset = UIParent:GetBottom() - menu:GetBottom();
		menu:ClearAllPoints();
		menu:SetPoint("TOPLEFT", this:GetName().."_Setting", "BOTTOMLEFT", 0, yoffset);
	end
	menu:Show();
	menu.table = this.table;
	menu.index = this.index;
	menu.subindex = this.subindex;
	menu.subindex2 = this.subindex2;
	menu.miscindex = this.miscindex;
	menu.initFunc = this.initFunc;
	menu.settingType = this.settingType;
	menu.controlbox = this:GetName().."_Setting";
	menu.cboxbase = this:GetName();
	if (menu.scrollMenu) then
		for i=1, 10 do
			getglobal(menu:GetName().."_Button"..i):SetChecked(0);
		end
		this = getglobal(menu:GetName().."_ScrollFrame");
		getglobal(menu:GetName().."_ScrollFrameScrollBar"):SetValue(0);
		getglobal(menu:GetName().."_ScrollFrame").offset = 0;
		menu.updateFunc();
	end
end

function DL_Sort(origTable)
	local function sortf(a, b)
		if ( strlower(a)<strlower(b) ) then
			return true;
		elseif ( strlower(a)==strlower(b) and a<b ) then
			return true;
		end
	end
	table.sort(origTable, sortf);
end

function DL_SortKeys(origTable)
	local a = {};
	for n in pairs(origTable) do
		table.insert(a, n);
	end
	DL_Sort(a, sortf);
	return a;
end

function DL_TabButton_OnClick()
	local selected = getglobal(this.selected);
	if (selected) then
		getglobal(selected):SetChecked(0);
		getglobal(selected.."_Background"):SetVertexColor(0, 0, 0);
		getglobal(selected.."_Text"):SetTextColor(1, 1, 0);
	end
	this:SetChecked(1);
	getglobal(this:GetName().."_Background"):SetVertexColor(1, 1, 0);
	getglobal(this:GetName().."_Text"):SetTextColor(1, 0, 0);
	if (this.selected) then
		setglobal(this.selected, this:GetName());
	end
	if (this.clickFunc) then
		this.clickFunc(this:GetID());
	end
end

function DL_Update_Auras(unit)
	if (DiscordLibrary_Settings and DiscordLibrary_Settings.disableBuffChecking) then
		return;
	end
	if (not DL_BUFFS[unit]) then
		DL_BUFFS[unit] = {};
	end
	if (not DL_DEBUFFS[unit]) then
		DL_DEBUFFS[unit] = {};
	end	
	if (not DL_STATUS[unit]) then
		DL_STATUS[unit] = {};
	end
	if ((not UnitExists(unit)) or (not UnitName(unit))) then return; end
	for i=1,16 do
		if (UnitBuff(unit, i)) then
			DiscordLib_AuraTooltip:SetUnitBuff(unit, i);
			if (DiscordLib_AuraTooltipTextLeft1:IsShown()) then
				DL_BUFFS[unit][i] = DiscordLib_AuraTooltipTextLeft1:GetText();
			else
				DL_BUFFS[unit][i] = "";
			end
		else
			DL_BUFFS[unit][i] = "";
		end
		if (UnitDebuff(unit, i)) then
			DiscordLib_AuraTooltip:SetUnitDebuff(unit, i);
			if (DiscordLib_AuraTooltipTextLeft1:IsShown()) then
				DL_DEBUFFS[unit][i] = DiscordLib_AuraTooltipTextLeft1:GetText();
			else
				DL_DEBUFFS[unit][i] = "";
			end
			if (DiscordLib_AuraTooltipTextRight1:IsShown()) then
				DL_STATUS[unit][i] = DiscordLib_AuraTooltipTextRight1:GetText();
			else
				DL_STATUS[unit][i] = "";
			end
		else
			DL_DEBUFFS[unit][i] = "";
			DL_STATUS[unit][i] = "";
		end
	end
end

function DL_Update_Forms()
	DL_FORMS = {};
	local _, class = UnitClass("player");
	if (class ~= "WARRIOR") then
		DL_FORMS[0] = { text=DL_TEXT.Humanoid, value=0 };
	end
	for i=1,GetNumShapeshiftForms() do
		local _, name = GetShapeshiftFormInfo(i);
		DL_FORMS[i] = { text=name, value=i };
	end
end

function DL_Update_Timers(elapsed)
	if (not DL_TIMERS) then return; end
	for k,v in DL_TIMERS do
		DL_TIMERS[k] = v - elapsed;
	end
end

function UseAction(action, checkcursor, selfcast)
	DL_LAST_ACTION = action;
	DL_Old_UseAction(action, checkcursor, selfcast);
end

function DL_Update_ActionList()
	DL_ACTIONS = {};
	for i=1, 120 do
		DL_ACTIONS[i] = { text="["..i.."] "..DL_Get_ActionName(i), value=i };
	end
end