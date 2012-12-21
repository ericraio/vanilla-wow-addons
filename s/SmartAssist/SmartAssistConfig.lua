NUM_SLOTS = 120;

-------------------------------------------------------------------------------
-- tab management code, credits to guim author
-------------------------------------------------------------------------------

SA_SUBFRAMES = { "SABasicOptionsFrame", "SAListOptionsFrame", "SAAdvancedOptionsFrame", "SmartActionsOptionsFrame" };

function SA_ToggleDialog(tab)
	local subFrame = getglobal(tab);
	if ( subFrame ) then
		PanelTemplates_SetTab(SAOptionsFrame, subFrame:GetID());
		if ( SAOptionsFrame:IsVisible() ) then
			PlaySound("igCharacterInfoTab");
		else
			ShowUIPanel(SAOptionsFrame);
		end
		SA_ShowSubFrame(tab);
	end
end

function SA_ShowSubFrame(frameName)
	for index, value in SA_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show();
		else
			getglobal(value):Hide();	
		end	
	end 
end

function SA_Tab_OnClick()
	local id = this:GetID();
	local tab = SA_SUBFRAMES[id];
	local subFrame = getglobal(tab);
	PanelTemplates_SetTab(SAOptionsFrame, id);
	SA_ShowSubFrame(tab);
	PlaySound("igCharacterInfoTab");
end

-------------------------------------------------------------------------------
-- spell & action drag hookups
-------------------------------------------------------------------------------

local SA_DRAGSPELL = nil;
local SA_DRAGSLOT = nil;
local SA_DRAGNAME = nil;

function SA_ClearDragData()
	SA_DRAGSPELL = nil;
	SA_DRAGSLOT = nil;
	SA_DRAGNAME = nil;
end
 
-- hook to spellbook pickup routine
local SA_BasePickupSpell = PickupSpell;
function PickupSpell(id, bookType)
	SA_ClearDragData();
	local result = SA_BasePickupSpell(id, bookType);
	--SA_Debug("picked up spell id="..id.." bookType="..bookType);
	if (CursorHasSpell()) then
		local name, rank = GetSpellName(id, bookType);
		local texture = GetSpellTexture(id, bookType);
		SA_DRAGSPELL = {};
		SA_DRAGSPELL.Id = id;
		SA_DRAGSPELL.Texture = texture;
		SA_DRAGSPELL.Name = name;
		SA_DRAGSPELL.BookType = bookType;
		SA_DRAGNAME = name;
	end
	return result;
end

local SA_BasePickupAction = PickupAction;
function PickupAction(slot)
	SA_ClearDragData();
	SA_Debug("picked up spell from slot "..slot);
	-- set drag slot
	SA_DRAGSLOT = slot;
	SA_DRAGNAME = SA_GetSlotName(slot);
	SA_Debug("SA_DRAGNAME="..tostring(SA_DRAGNAME));
	return SA_BasePickupAction(slot);
end

-------------------------------------------------------------------------------
-- smart assist configuration dialog
-------------------------------------------------------------------------------

function SA_Options_Init()
end

function SA_Options_OnHide()
end

function SA_Options_OnLoad()
	tinsert(UISpecialFrames, "SAOptionsFrame");
	-- Tab Handling code
	PanelTemplates_SetNumTabs(this, 4);
	PanelTemplates_SetTab(this, 1);
end

-- todo: this update is not anymore good since we have divided optiosn across several tabs ...
function SA_Options_OnShow()
	SAPriorizeHealthCB:SetChecked(SA_OPTIONS.PriorizeHealth);
	SAAssistOnEmoteCB:SetChecked(SA_OPTIONS.AssistOnEmote);
	SAVisualWarningCB:SetChecked(SA_OPTIONS.VisualWarning);
	SAFallbackTargetNearestCB:SetChecked(SA_OPTIONS.FallbackTargetNearest);
	SACheckNearestCB:SetChecked(SA_OPTIONS.CheckNearest);
	SANearestMustBePvPCB:SetChecked(SA_OPTIONS.NearestMustBePvP);
	SANearestMustBeTargetingCB:SetChecked(SA_OPTIONS.NearestMustBeTargetting);
	SAAutoAssistCB:SetChecked(SA_OPTIONS.AutoAssist);

	SAAutoPetAttackCB:SetChecked(SA_OPTIONS.AutoPetAttack);
	SAAutoPetAttackBusyCB:SetChecked(SA_OPTIONS.AutoPetAttackBusy);
	
	SA_Options_UpdatePullerText();
		
	if (SA_OPTIONS.AutoAssistTexture) then
		SAAssistText:SetText(SA_OPTIONS.AutoAssistName);
		SA_Debug("setting button texture to="..SA_OPTIONS.AutoAssistTexture);
		SetItemButtonTexture(SAAssistWithSlot, SA_OPTIONS.AutoAssistTexture);
	end
	SA_Options_UpdateClassOrder();
	
	-- set health slider value & update text
	SAHealthSlider:SetValue(SA_OPTIONS.PriorizeHealthValue);
	SA_Options_UpdateHealthSlider();
end

-------------------------------------------------------------------------------
-- Update list options tab
-------------------------------------------------------------------------------

function SA_Options_VariablesLoaded()
	SA_Options_AddIconPositions("SAClassIconMode");
	SA_Options_AddIconPositions("SATargetIconMode");
	SA_Options_AddIconPositions("SAHuntersMarkIconMode");
end

function SA_Options_AddIconPositions(name)
	local c = getglobal(name);
	for i=1, table.getn(SA_ICONPOS) do
		Selection_AddSelection(c, i, SA_ICONPOS[i].name);
	end
end

function SA_Options_OnShowListOptions()
	SAAudioWarningCB:SetChecked(SA_OPTIONS.AudioWarning);
	SALostAudioWarningCB:SetChecked(SA_OPTIONS.LostAudioWarning);
	
	SAVerboseAcquiredAggroCB:SetChecked(SA_OPTIONS.VerboseAcquiredAggro);
	SAVerboseLostAggroCB:SetChecked(SA_OPTIONS.VerboseLostAggro);
	
	SAShowAvailableCB:SetChecked(SA_OPTIONS.ShowAvailable);
	SAPreservedOrderCB:SetChecked(SA_OPTIONS.PreservedOrder);
	SATankModeCB:SetChecked(SA_OPTIONS.TankMode);
	SAAddMyTargetCB:SetChecked(SA_OPTIONS.AddMyTarget);
	SAOutOfCombatCB:SetChecked(SA_OPTIONS.OutOfCombat);
	SAHideTBYCB:SetChecked(SA_OPTIONS.HideTBY);
	SAHideTitleCB:SetChecked(SA_OPTIONS.HideTitle);
	
	SAListWidthSlider:SetValue(SA_OPTIONS.ListWidth);
	SAListScaleSlider:SetValue(SA_OPTIONS.ListScale);

	SAListSpacingSlider:SetValue(SA_OPTIONS.ListSpacing);
	SAListHorizontalCB:SetChecked(SA_OPTIONS.ListHorizontal);
	SAListTwoRowCB:SetChecked(SA_OPTIONS.ListTwoRow);
	
	SA_Options_UpdateListWidthSlider();
	SA_Options_UpdateListSpacingSlider();
	
	Selection_SetSelectedValue(SAClassIconMode, SA_OPTIONS.ClassIconMode);
	Selection_SetSelectedValue(SATargetIconMode, SA_OPTIONS.TargetIconMode);
	Selection_SetSelectedValue(SAHuntersMarkIconMode, SA_OPTIONS.HuntersMarkIconMode);
	
	SA_Options_DisplayList(true);
end

function SA_Options_OnHideListOptions()
	SA_Options_DisplayList(false);
end

function SA_Options_DisplayList(display)
	if (display) then
		SA_List_SetTitleButton(MODE_NORMAL);
	else
		SA_List_SetTitleButton(MODE_OOC);
	end
	for i=1, 10 do
		local box = getglobal("Target"..i);
		if (display) then
			box:Show();
		else
			box:Hide();
		end;
	end
end

function SA_Options_UpdateListWidthSlider()
	SA_OPTIONS.ListWidth = SAListWidthSlider:GetValue();
	SA_List_UpdateAppearance();
end

function SA_Options_UpdateListScaleSlider()
	SA_OPTIONS.ListScale = SAListScaleSlider:GetValue();
	SAListFrameScaler:SetScale(SA_OPTIONS.ListScale);
	local s = string.sub(tostring(SA_OPTIONS.ListScale),0,4);
	SAListScaleSliderText:SetText("list scale "..s);
end

function SA_Options_UpdateListSpacingSlider()
	SA_OPTIONS.ListSpacing = SAListSpacingSlider:GetValue();
	SA_List_UpdateAppearance();
end

function SA_Options_UpdateListSpacingSliderText()
	if (SA_OPTIONS.ListHorizontal) then
		SAListSpacingSliderHigh:SetText("right");
		SAListSpacingSliderLow:SetText("left");
	else
		SAListSpacingSliderHigh:SetText("up");
		SAListSpacingSliderLow:SetText("down");
	end
end

-- callback from SmartSelection
function SA_Options_ClassIcon(value)
	SA_OPTIONS["ClassIconMode"] = value;
	SA_List_UpdateAppearance();
end

-- callback from SmartSelection
function SA_Options_TargetIcon(value)
	SA_OPTIONS["TargetIconMode"] = value;
	SA_List_UpdateAppearance();
end

function SA_Options_HuntersMarkIcon(value)
	SA_OPTIONS["HuntersMarkIconMode"] = value;
	SA_List_UpdateAppearance();
end

-------------------------------------------------------------------------------
-- Update advanced options tab
-------------------------------------------------------------------------------

function SA_Options_OnShowAdvanced()
	
	-- update the dropdown Select Modifier
	UIDropDownMenu_SetSelectedID(SASelectModifierDD, SA_OPTIONS.AssistKeyMode);
	SASelectModifierDDText:SetText(SELECT_MODIFIER_TEXTS[SA_OPTIONS.AssistKeyMode]);
	if (SA_OPTIONS.AssistKeyMode == 4) then
		SASelectModifierDDInfo:SetText("selecting does not assist");
	else
		SASelectModifierDDInfo:SetText("assists player");
	end
	-- update the dropdown Assist Modifier
	UIDropDownMenu_SetSelectedID(SAAssistModifierDD, SA_OPTIONS.DisableAutoCastKeyMode);
	SAAssistModifierDDText:SetText(ASSIST_MODIFIER_TEXTS[SA_OPTIONS.DisableAutoCastKeyMode]);
		
	-- set disable slider value & update text
	SADisableSlider:SetValue(SA_OPTIONS.DisableSliderValue);
	SA_Options_UpdateDisableSlider();

	SAPauseResetsOrderCB:SetChecked(SA_OPTIONS.PauseResetsOrder);
	SADisableTargetNearestCB:SetChecked(SA_OPTIONS.DisableTargetNearest);
	SADisablePriorityHealthCB:SetChecked(SA_OPTIONS.DisablePriorityHealth);
			
	SAVerboseAssistCB:SetChecked(SA_OPTIONS.VerboseAssist);
	SAVerboseIncomingCB:SetChecked(SA_OPTIONS.VerboseIncoming);
	SAVerboseNearestCB:SetChecked(SA_OPTIONS.VerboseNearest);
	SAVerboseUnableToAssistCB:SetChecked(SA_OPTIONS.VerboseUnableToAssist);
	
	SADisableAssistWithoutPullerCB:SetChecked(SA_OPTIONS.DisableAssistWithoutPuller);
end

function SA_Options_UpdatePullerText()
	local candidates,_ = SA_GetCandidates();
	--SA_RefreshPuller(candidates); -- causes infinite loop and stack overflow because this method is called from refresh path also!
	if (SA_OPTIONS["puller"]==nil) then
		SACurrentPuller:SetText("Puller: none / pet when available");
	else
		SACurrentPuller:SetText("Puller: "..SA_OPTIONS["puller"]);
	end
end

----------------------------------------------------------------------------------
-- displays list of all available members in order of current assist configuration
----------------------------------------------------------------------------------

function SA_PullerText_OnEnter(arg)
	local text = "Current assist order:\n\n";
	local candidates, members = SA_GetCandidates(false);
	if (members > 0) then
		table.sort(candidates, function(a,b) return SA_SortCandidate(a,b,members) end);
		for _,candidate in candidates do
			-- colorize text by class
			local cv = RAID_CLASS_COLORS[string.upper(candidate["class"])];
			local color = "";
			if (not cv) then
				color = "|cff888888";
			else
				color = SA_ToTextCol(cv.r, cv.g, cv.b);
			end
			text = text .. color..candidate.unitName .. "|r" .. "\n";
		end
	else
		text = text .. "- no members";
	end
	GameTooltip:SetOwner(arg, "ANCHOR_LEFT");
	GameTooltip:SetText(text,1,1,1,1,1);
end

function SA_PullerText_OnLeave(arg)
	GameTooltip:Hide();
end

-------------------------------------------------------------------------------
-- togle a boolean option, play a tick sound
-------------------------------------------------------------------------------

function SA_ToggleOption(option)
	if (SA_OPTIONS[option]==nil or SA_OPTIONS[option]==false) then
		SA_OPTIONS[option] = true;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		SA_OPTIONS[option] = false;
		PlaySound("igMainMenuOptionCheckBoxOn");
	end
end

function SA_ToggleAvailable()
	SA_ToggleOption("ShowAvailable");
	if (SA_OPTIONS.ShowAvailable) then
		printInfo("Enabling available assist list and related features");
		SAListFrame:Show();
	else
		printInfo("Disabling available assist list and related features");
		SAListFrame:Hide();
	end
	SA_Options_OnShow();
end

-------------------------------------------------------------------------------
-- auto cast on assist slot
-------------------------------------------------------------------------------

function SA_SpellSlot_OnReceiveDrag()
	SA_Debug("Received drag");
	
	-- enable whining again, incase user has Auto Attack enabled which will screw the cast
	SA_OPTIONS.AutoAttackWhineIgnored = false;
	
	if (CursorHasSpell() and not SA_DRAGSLOT) then
		SA_OPTIONS.AutoAssist = true;
		SA_OPTIONS.AutoAssistTexture = SA_DRAGSPELL.Texture;
		SA_OPTIONS.AutoAssistName = SA_DRAGSPELL.Name;

		-- drop icon
		PickupSpell(SA_DRAGSPELL.Id, SA_DRAGSPELL.BookType);
		
		-- update the config window		
		SA_Options_OnShow();
	else
		SpellBookFrame:Show();
	end
end

-------------------------------------------------------------------------------
-- updates classorder view
-------------------------------------------------------------------------------

function SA_Options_UpdateClassOrder()
	for k,v in SA_OPTIONS.ClassOrder do
		getglobal("ClassOrderFrameClass" .. k .. "Text"):SetText(v);
	end
end

-------------------------------------------------------------------------------
-- update disable target
-------------------------------------------------------------------------------

function SA_Options_UpdateDisableSlider()
	SA_OPTIONS.DisableSliderValue = SADisableSlider:GetValue();
	SADisableSliderText:SetText("members > "..SA_OPTIONS.DisableSliderValue);
end

-------------------------------------------------------------------------------
-- updates health slider TEXT (not value)
-------------------------------------------------------------------------------

function SA_Options_UpdateHealthSlider()
	SA_OPTIONS.PriorizeHealthValue = SAHealthSlider:GetValue();
	SAHealthSliderText:SetText("Priority health ("..SA_OPTIONS.PriorizeHealthValue.." %)");
end

-------------------------------------------------------------------------------
-- class order routines
-------------------------------------------------------------------------------

function SA_ClassOrderMove(move)
	local text = getglobal(this:GetParent():GetName() .. "Text"):GetText()
	-- where is our text in table, also check for boundaries
	local index = SA_TableIndex(SA_OPTIONS.ClassOrder, text);
	-- move the element in our list	
	local moving = SA_OPTIONS.ClassOrder[index];
	table.remove(SA_OPTIONS.ClassOrder, index);
	table.insert(SA_OPTIONS.ClassOrder, index+move, moving);
	SA_Options_UpdateClassOrder();
end

-------------------------------------------------------------------------------
-- initialize dropdown (thanks to atlas)
-------------------------------------------------------------------------------

SELECT_MODIFIER_TEXTS = {"Shift - select", "Ctrl - select", "Alt - select", "Disabled" };
function SASelectModifierDD_Initialize()
	local info;
	for _,value in SELECT_MODIFIER_TEXTS do
		info = {
			text = value;
			func = SASelectModifierDDButton_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function SASelectModifierDD_OnLoad()
	UIDropDownMenu_Initialize(SASelectModifierDD, SASelectModifierDD_Initialize);
	UIDropDownMenu_SetSelectedID(SASelectModifierDD, 1);
	UIDropDownMenu_SetWidth(90);
end

function SASelectModifierDDButton_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(SASelectModifierDD);
	if(oldID ~= this:GetID()) then
		SA_OPTIONS["AssistKeyMode"]=this:GetID()
		SA_Options_OnShowAdvanced();
	end
end

-------------------------------------------------------------------------------

ASSIST_MODIFIER_TEXTS = {"Shift", "Ctrl ", "Alt", "None" };
function SAAssistModifierDD_Initialize()
	local info;
	for _,value in ASSIST_MODIFIER_TEXTS do
		info = {
			text = value;
			func = SAAssistModifierDDButton_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function SAAssistModifierDD_OnLoad()
	UIDropDownMenu_Initialize(SAAssistModifierDD, SAAssistModifierDD_Initialize);
	UIDropDownMenu_SetSelectedID(SAAssistModifierDD, 1);
	UIDropDownMenu_SetWidth(90);
end

function SAAssistModifierDDButton_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(SAAssistModifierDD);
	if(oldID ~= this:GetID()) then
		SA_OPTIONS["DisableAutoCastKeyMode"]=this:GetID()
		SA_Options_OnShowAdvanced();
	end
end

-------------------------------------------------------------------------------
-- smart spell configuration methods
-------------------------------------------------------------------------------

function SA_Options_SmartActions_OnShow()
	SATriggerAssistCB:SetChecked(SA_OPTIONS.TriggerAssist);
	SA_RefreshSlots();
end

function SA_RefreshSlots()

	local i = 0;
	for _,spell in SA_OPTIONS.AssistSpells do
		i = i + 1;
		local slot = getglobal("SAAssistSlot"..i);
		local texture = SA_GetTextureForSpell(spell);
		if (texture) then
			SetItemButtonTexture(slot, texture);
		else
			SA_Debug("unknown texture for spell "..tostring(spell));
			SetItemButtonTexture(slot, "Interface\\Icons\\INV_Misc_QuestionMark");
		end
	end

	-- clear old textures	
	for c = i+1, 20 do 
		local slot = getglobal("SAAssistSlot"..c);
		SetItemButtonTexture(slot, nil);
	end
	
end

function SA_SmartActionSlot_OnEnter(arg)
	if (SA_DRAGSLOT or SA_DRAGSPELL) then return; end;
	local text = SA_OPTIONS.AssistSpells[this:GetID()];
	if (text) then
		GameTooltip:SetOwner(arg, "ANCHOR_RIGHT");
		GameTooltip:SetText(text,1,1,1,1,1);
	end
end

function SA_SmartActionSlot_OnClick()
	if (CursorHasSpell()) then
		printInfo("This is drag instead of click!");
		SA_SmartActionSlot_OnReceiveDrag();
		return;
	end
	
	-- remove selected spell & update table element id's (why doesn't lua do this =P)
	if (SA_OPTIONS.AssistSpells[this:GetID()]) then
		table.remove(SA_OPTIONS.AssistSpells, this:GetID());
		local temp = {};
		for _,v in SA_OPTIONS.AssistSpells do
			table.insert(temp, v);
		end
		SA_OPTIONS.AssistSpells = temp;
	end
	
	SA_Options_SmartActions_OnShow();
end

function SA_SmartActionSlot_OnReceiveDrag()
	-- get spell name and release drag, Todo: separate to function?
	local spell = SA_DRAGNAME;
	if (SA_DRAGSLOT) then
		PickupAction(SA_DRAGSLOT);
	elseif (SA_DRAGSPELL) then
		PickupSpell(SA_DRAGSPELL.Id, SA_DRAGSPELL.BookType);
	else
		printInfo("bug #5933");
	end
	SA_ClearDragData();
	
	if (not spell) then
		printInfo("Problem: Unable to get spell name");
		return;
	end
	
	if (SA_TableIndex(SA_OPTIONS.AssistSpells, spell) ~= -1) then
		printInfo("Spell already exists in list");
		return;
	end
	
	SA_Debug("Adding spell "..tostring(spell));
	table.insert(SA_OPTIONS.AssistSpells, spell);

	-- refresh the view
	SA_Options_SmartActions_OnShow()
end

-------------------------------------------------------------------------------
-- reset all smartactions
-------------------------------------------------------------------------------

function SA_ResetSmartActions()
	SA_OPTIONS.AssistSpells = {};
	-- refresh the view
	SA_Options_SmartActions_OnShow()
end

-------------------------------------------------------------------------------
-- try to autoconfigure smart actions
-------------------------------------------------------------------------------

function SA_AutoConfigureSmartActions()
	local found = 0;
	for slot = 1, NUM_SLOTS do
		local spell = SA_GetSlotName(slot);
		if (spell) then
			if (AUTOCONF_ATTACKS[spell]) then
				if (SA_TableIndex(SA_OPTIONS.AssistSpells, spell) == -1) then 
					SA_Debug("found attack "..spell);
					table.insert(SA_OPTIONS.AssistSpells, spell);
					found = found + 1;
				end
			end
		end
	end
	if (found>0) then
		printInfo("Auto configured "..found.." actions.");
	else
		printInfo("Auto configure was unable to find any actions. This is most likelly because your class does not (yet) have predefined set of spells or you are using non-english client.");
	end
	
	-- refresh the view
	SA_Options_SmartActions_OnShow();
end

-------------------------------------------------------------------------------
-- slot & spell utilities
-------------------------------------------------------------------------------

function SA_GetTextureForSpell(name)
	local id = SA_FindSlotByName(name);
	if (id==nil) then return nil; end;
	return GetActionTexture(id);
end

function SA_FindSlotByName(name)
	local textName;
	for slot = 1, NUM_SLOTS do
		slotName = SA_GetSlotName(slot);
		if (slotName == name) then
			return slot;
		end		
	end
	return nil;
end

function SA_GetSlotName(slot)
	SAActionTip:SetAction(slot);
	return SAActionTipTextLeft1:GetText();
end
