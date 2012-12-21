SUPERMACRO_VERSION = "3.14";
UIPanelWindows["SuperMacroFrame"] = { area = "left", pushable = 7, whileDead = 1 };
UIPanelWindows["SuperMacroOptionsFrame"] = { area = "left", pushable = 0, whileDead = 1 };
MACRO_ROWS = 3;
MACRO_COLUMNS = 10;
MACROS_REGULAR_SHOWN = 36;
MACROS_SUPER_SHOWN = MACRO_ROWS * MACRO_COLUMNS;
MAX_MACROS = 18;
--MAX_TOTAL_MACROS = 36;
NUM_MACRO_ICONS_SHOWN = 30;--20
NUM_ICONS_PER_ROW = 5;--5
NUM_ICON_ROWS = 6;--4
MACRO_ROW_HEIGHT = 36;
MACRO_ICON_ROW_HEIGHT = 36;
--MACRO_MAX_LETTERS = 255;
EXTEND_MAX_LETTERS = 7000;
SUPER_MAX_LETTERS = 7000;
PRINT_COLOR_DEF = {r=1, g=1, b=1};
SM_VARS = {}; -- options variables, Saved
--SM_VARS.hideAction = 0;
--SM_VARS.printColor = PRINT_COLOR_DEF;
--SM_VARS.macroTip1 = 1;
--SM_VARS.macroTip2 = 0;
--SM_VARS.minimap = 1;
--SM_VARS.replaceIcon = 1;
--SM_VARS.checkCooldown = 1;
SM_EXTEND = {}; -- ingame extended, Saved
SM_SUPER={}; -- supers' names, texture, body, Saved
SM_ORDERED={}; -- supers in alphabetical order
SM_ACTION={}; -- hold actions that have supers, for current player
SM_ACTION_SUPER={}; -- hold actions for supers, Saved per character
SM_MACRO_ICON={}; -- hold all available icons and their id
SM_ACTION_SPELL={}; -- hold macros that cast spell or items
SM_ACTION_SPELL.regular={};
SM_ACTION_SPELL.super={};
SM_AliasFunctions={}; -- functions to replace aliases
SM_AliasFunctions.low=0;
SM_AliasFunctions.high=0;

local oldextend;

function SuperMacroFrame_OnLoad()
	PanelTemplates_SetNumTabs(this, 2);
	SuperMacroFrame.selectedTab = 1;
	PanelTemplates_UpdateTabs(this);
	SuperMacroFrameTitle:SetText(SUPERMACRO_TITLE.." "..SUPERMACRO_VERSION);
	SuperMacroFrameCharacterMacroText:SetText(format(CHARACTER_SPECIFIC_MACROS, UnitName("player")));
	SM_UpdateAction();
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	lastActionUsed = nil;
	SuperMacroFrame_SetAccountMacros();
	SM_MACRO_ICON=SM_LoadMacroIcons();
	if ( not Print ) then
		Print=Printd;
	end
end

function SuperMacroFrame_OnShow()
	SuperMacroFrame.extendChanged=nil;
	SuperMacroFrame_Update();
	PlaySound("igCharacterInfoOpen");
end

function SuperMacroFrame_OnHide()
	SuperMacroPopupFrame:Hide();
	SuperMacroFrame_SaveMacro();
	PlaySound("igCharacterInfoClose");
	if ( SuperMacroFrame.extendChanged ) then
		SuperMacroSaveExtend();
	end
	SuperMacroFrame.extendChanged=nil;
	-- purge empty extends
	for m,e in ipairs(SM_EXTEND) do
		if ( e=="" ) then
			SM_EXTEND[m]=nil;
		end
	end
	SuperMacroRunScriptExtend();
end

function SuperMacroFrame_SetAccountMacros()
	local numAccountMacros, numCharacterMacros = GetNumMacros();
	if ( numAccountMacros > 0 ) then
		SuperMacroFrame_SelectMacro(1);
	else
		SuperMacroFrame_SetCharacterMacros();
	end
end

function SuperMacroFrame_SetCharacterMacros()
	local numAccountMacros, numCharacterMacros = GetNumMacros();
	if ( numCharacterMacros > 0 ) then
		SuperMacroFrame_SelectMacro(19);
	else
		SuperMacroFrame_SelectMacro(nil);
	end
end

function SuperMacroFrame_ShowFrame( tab )
	if ( tab~="regular" ) then
		SuperMacroFrameRegularFrame:Hide();
	else
		SuperMacroFrameRegularFrame:Show();
	end
	if ( tab~="super" ) then
		SuperMacroFrameSuperFrame:Hide();
	else
		SM_ORDERED=SortSuperMacroList();
		SuperMacroFrameSuperFrame:Show();
	end
end

function SuperMacroFrame_Update()
	-- determine to show regular or super macros from SM_VARS.tabShown
-- START show regular frame
	if ( SM_VARS.tabShown=="regular" ) then
	SuperMacroFrame_ShowFrame("regular");
	local numMacros;
	local numAccountMacros, numCharacterMacros = GetNumMacros();
	local macroButton, macroIcon, macroName;
	local name, texture, body, isLocal;
	local selectedName, selectedBody, selectedIcon;

	-- Disable Buttons
	if ( SuperMacroPopupFrame:IsVisible() ) then
		SuperMacroEditButton:Disable();
		SuperMacroDeleteButton:Disable();
		SuperMacroSaveButton:Disable();
	else
		SuperMacroEditButton:Enable();
		SuperMacroDeleteButton:Enable();
		SuperMacroSaveButton:Enable();
	end

	if ( not SuperMacroFrame.selectedMacro or (numAccountMacros+numCharacterMacros==0)  ) then
		SuperMacroDeleteButton:Disable();
		SuperMacroEditButton:Disable();
		SuperMacroSaveButton:Disable();
		SuperMacroFrameSelectedMacroName:SetText('');
		SuperMacroFrameText:SetText('');
		SuperMacroFrameSelectedMacroButtonIcon:SetTexture('');
	end
	
	-- Macro List
	for j=0, MAX_MACROS, MAX_MACROS do
		if ( j == 0 ) then
			numMacros = numAccountMacros;
		else
			numMacros = numCharacterMacros;
		end
	for i=1, MAX_MACROS do
		local macroID = i+j;
		getglobal("SuperMacroButton"..macroID.."ID"):SetText(macroID);
		macroButton = getglobal("SuperMacroButton"..macroID);
		macroIcon = getglobal("SuperMacroButton"..macroID.."Icon");
		macroName = getglobal("SuperMacroButton"..macroID.."Name");
		if ( i <= numMacros ) then
			name, texture, body, isLocal = GetMacroInfo(macroID);
			macroButton:SetID(macroID);
			macroIcon:SetTexture(texture);
			macroName:SetText(name);
			macroButton:Enable();
			-- Highlight Selected Macro
			if ( macroID == SuperMacroFrame.selectedMacro ) then
				macroButton:SetChecked(1);
    				SuperMacroFrameSelectedMacroName:SetText(name);
					SuperMacroFrameText:SetText(body);
					SuperMacroFrameSelectedMacroButton:SetID(macroID);				
    				SuperMacroFrameSelectedMacroButtonIcon:SetTexture(texture);
			else
				macroButton:SetChecked(0);
			end
		else
			macroButton:SetChecked(0);
			macroIcon:SetTexture("");
			macroName:SetText("");
			macroButton:Disable();
		end
	end
	end
	
	--Update New Button
	if ( numAccountMacros == MAX_MACROS ) then
		SuperMacroNewAccountButton:Disable();
	else
		SuperMacroNewAccountButton:Enable();
	end
	if ( numCharacterMacros == MAX_MACROS ) then
		SuperMacroNewCharacterButton:Disable();
	else
		SuperMacroNewCharacterButton:Enable();
	end
	
	end
-- END update regular frame

-- START show super frame
	if ( SM_VARS.tabShown=="super" ) then
	SuperMacroFrame_ShowFrame("super");
	local numMacros=SM_SUPER_SIZE or GetNumSuperMacros();
	local macroButton, macroIcon, macroName;
	local name, texture, body;

	-- Disable Buttons
	if ( SuperMacroPopupFrame:IsVisible() ) then
		SuperMacroNewSuperButton:Disable();
		SuperMacroSaveSuperButton:Disable();
		SuperMacroDeleteSuperButton:Disable();
		SuperMacroEditButton:Disable();
	else
		SuperMacroNewSuperButton:Enable();
		SuperMacroSaveSuperButton:Enable();
		SuperMacroDeleteSuperButton:Enable();
		SuperMacroEditButton:Enable();
	end
	
	if ( not SuperMacroFrame.selectedSuper or GetNumSuperMacros()==0) then
	--[[
		SuperMacroSaveSuperButton:Enable();
		SuperMacroDeleteSuperButton:Enable();
		SuperMacroEditButton:Enable();
	else
	--]]
		SuperMacroSaveSuperButton:Disable();
		SuperMacroDeleteSuperButton:Disable();
		SuperMacroEditButton:Disable();
		SuperMacroFrameSelectedMacroName:SetText('');
		SuperMacroFrameSuperText:SetText('');
		SuperMacroFrameSelectedMacroSuperButtonIcon:SetTexture('');
	end
	
	-- Macro List
	local offset=FauxScrollFrame_GetOffset(SuperMacroFrameSuperScrollFrame);
	local firstmacro = offset*MACRO_COLUMNS+1;
	local lastmacro = firstmacro + MACRO_ROWS*MACRO_COLUMNS -1;
	
	for i=1, MACROS_SUPER_SHOWN do
		getglobal("SuperMacroSuperButton"..i.."ID"):SetText(firstmacro+i-1);
		macroButton = getglobal("SuperMacroSuperButton"..i);
		macroIcon = getglobal("SuperMacroSuperButton"..i.."Icon");
		macroName = getglobal("SuperMacroSuperButton"..i.."Name");
		local macroID = firstmacro+i-1;
		if ( macroID <= numMacros ) then
			name, texture, body = GetOrderedSuperMacroInfo(macroID);
			macroButton:SetID(macroID);
			macroIcon:SetTexture(texture);
			macroName:SetText(name);
			macroButton:Enable();
			-- Highlight Selected Macro
			if ( macroID == SuperMacroFrame.selectedSuper ) then
				macroButton:SetChecked(1);
				SuperMacroFrameSelectedMacroName:SetText(name);
				SuperMacroFrameSuperText:SetText(body);
				SuperMacroFrameSelectedMacroSuperButtonIcon:SetTexture(texture);
			else
				macroButton:SetChecked(0);
			end
		else
			macroButton:SetChecked(0);
			macroIcon:SetTexture("");
			macroName:SetText("");
			macroButton:Disable();
		end
	end

	-- Scroll frame stuff
	FauxScrollFrame_Update(SuperMacroFrameSuperScrollFrame, ceil(numMacros/10), MACRO_ROWS, MACRO_ROW_HEIGHT );
	
	end
-- END update super frame
end

function SuperMacroFrame_AddMacroLine(line)
	if ( SuperMacroFrameText:IsVisible() ) then
		SuperMacroFrameText:SetText(SuperMacroFrameText:GetText()..line);
	end
end

function SuperMacroButton_OnClick( button )
	local id=this:GetID();
	if ( SuperMacroFrame.extendChanged and SuperMacroFrame.selectedMacro ) then
		SuperMacroSaveExtend();
	end
	SuperMacroFrame_SaveMacro();
	SuperMacroFrame_SelectMacro(id);
	SuperMacroFrame_Update();
	SuperMacroPopupFrame:Hide();
	SuperMacroFrameText:ClearFocus();
	local macro=SuperMacroFrameSelectedMacroName:GetText();
	local extendText=SM_EXTEND[macro];
	if ( extendText ) then
		SuperMacroFrameExtendText:SetText(extendText);
	else
		SuperMacroFrameExtendText:SetText("");
	end
	if ( button=="RightButton" ) then
		RunMacro(id);
	end
end

function SuperMacroSuperButton_OnClick( button )
	local id=this:GetID();
	SuperMacroFrame_SaveSuperMacro();
	SuperMacroFrame_SelectSuperMacro(id);
	SuperMacroFrame_Update();
	SuperMacroPopupFrame:Hide();
	SuperMacroFrameSuperText:ClearFocus();
	if ( button=="RightButton" ) then
		RunSuperMacro(id);
	end
end

function SuperMacroFrame_SelectSuperMacro(id)
	SuperMacroFrame.selectedSuper = id;
end

function SuperMacroFrame_SelectMacro(id)
	SuperMacroFrame.selectedMacro = id;
end

function SuperMacroNewAccountButton_OnClick()
	SuperMacroFrame_SaveMacro();
	SuperMacroSaveExtend();
	oldextend=nil;
	SuperMacroPopupFrame.mode = "newaccount";
	SuperMacroPopupFrame:Show();
end

function SuperMacroNewCharacterButton_OnClick()
	SuperMacroFrame_SaveMacro();
	SuperMacroSaveExtend();
	oldextend=nil;
	SuperMacroPopupFrame.mode = "newcharacter";
	SuperMacroPopupFrame:Show();
end

function SuperMacroNewSuperButton_OnClick()
	SuperMacroFrame_SaveSuperMacro();
	SuperMacroPopupFrame.mode = "newsuper";
	SuperMacroPopupFrame:Show();
end

function SuperMacroEditButton_OnClick()
	if ( SuperMacroFrame.extendChanged ) then
		SuperMacroSaveExtend();
	end
	-- erase old name extend
	oldextend=SuperMacroFrameExtendText:GetText();
	local oldmacro=SelectedMacroName();
	--SM_EXTEND[oldmacro]=nil;
	if ( not SameMacroName() ) then
		SuperMacroSaveExtend(oldmacro, 1); -- delete old extend
	end
	SuperMacroFrame_SaveMacro();
	SuperMacroPopupFrame.mode = "edit";
	SuperMacroPopupFrame.oldname=SuperMacroFrameSelectedMacroName:GetText();
	SuperMacroPopupFrame:Show();
end

function SuperMacroFrame_HideDetails()
	SuperMacroEditButton:Hide();
	SuperMacroFrameCharLimitText:Hide();
	SuperMacroFrameText:Hide();
	SuperMacroFrameSelectedMacroName:Hide();
	SuperMacroFrameSelectedMacroBackground:Hide();
	SuperMacroFrameSelectedMacroButton:Hide();
end

function SuperMacroFrame_ShowDetails()
	SuperMacroEditButton:Show();
	SuperMacroFrameCharLimitText:Show();
	SuperMacroFrameEnterMacroText:Show();
	SuperMacroFrameText:Show();
	SuperMacroFrameSelectedMacroName:Show();
	SuperMacroFrameSelectedMacroBackground:Show();
	SuperMacroFrameSelectedMacroButton:Show();
end

function SuperMacroPopupFrame_OnShow()
	if ( this.mode == "newaccount" or this.mode == "newcharacter" ) then
		SuperMacroFrameText:Hide();
		SuperMacroFrameSelectedMacroButtonIcon:SetTexture("");
		SuperMacroPopupFrame.selectedIcon = nil;
	elseif ( this.mode == "newsuper" ) then
		SuperMacroFrameSuperText:Hide();
		SuperMacroFrameSelectedMacroSuperButtonIcon:SetTexture("");
		SuperMacroPopupFrame.selectedIcon = nil;
	end
	SuperMacroFrameText:ClearFocus();
	SuperMacroFrameSuperText:ClearFocus();
	SuperMacroPopupEditBox:SetFocus();

	PlaySound("igCharacterInfoOpen");
	SuperMacroPopupFrame_Update();
	SuperMacroPopupOkayButton_Update();

	-- Disable Buttons
	SuperMacroEditButton:Disable();
	SuperMacroDeleteButton:Disable();
	SuperMacroNewAccountButton:Disable();
	SuperMacroNewCharacterButton:Disable();
end

function SuperMacroPopupFrame_OnHide()
	if ( this.mode == "newaccount" or this.mode == "newcharacter" ) then
		SuperMacroFrameText:Show();
		SuperMacroFrameText:SetFocus();
	elseif ( this.mode == "newsuper" ) then
		SuperMacroFrameSuperText:Show();
		SuperMacroFrameSuperText:SetFocus();
	end
	
	-- Enable Buttons
	SuperMacroEditButton:Enable();
	SuperMacroDeleteButton:Enable();
	local numAccountMacros, numCharacterMacros = GetNumMacros();
	if ( numAccountMacros < MAX_MACROS ) then
		SuperMacroNewAccountButton:Enable();
	end
	if ( numCharacterMacros < MAX_MACROS ) then
		SuperMacroNewCharacterButton:Enable();
	end
end

function SuperMacroPopupFrame_Update()
	local numMacroIcons = GetNumMacroIcons();
	local macroPopupIcon, macroPopupButton;
	local macroPopupOffset = FauxScrollFrame_GetOffset( SuperMacroPopupScrollFrame );
	local index;
	
	-- Determine whether we're creating a new macro or editing an existing one
	if ( this.mode == "newaccount" or this.mode == "newcharacter" ) then
		SuperMacroPopupEditBox:SetText("");
	elseif ( this.mode == "newsuper" ) then
		SuperMacroPopupEditBox:SetText("");
	elseif ( this.mode == "edit" ) then
		local name;
		if ( SM_VARS.tabShown=="regular") then
		name = GetMacroInfo(SuperMacroFrame.selectedMacro);
		elseif ( SM_VARS.tabShown=="super" ) then
			name = GetOrderedSuperMacroInfo(SuperMacroFrame.selectedSuper);
		end
		SuperMacroPopupEditBox:SetText(name);
	end
	
	-- Icon list
	for i=1, NUM_MACRO_ICONS_SHOWN do
		macroPopupIcon = getglobal("SuperMacroPopupButton"..i.."Icon");
		macroPopupButton = getglobal("SuperMacroPopupButton"..i);
		index = (macroPopupOffset * NUM_ICONS_PER_ROW) + i;
		if ( index <= numMacroIcons ) then
			macroPopupIcon:SetTexture(GetMacroIconInfo(index));
			macroPopupButton:Show();
		else
			macroPopupIcon:SetTexture("");
			macroPopupButton:Hide();
		end
		if ( index == SuperMacroPopupFrame.selectedIcon ) then
			macroPopupButton:SetChecked(1);
		else
			macroPopupButton:SetChecked(nil);
		end
	end
	
	-- Scrollbar stuff
	FauxScrollFrame_Update(SuperMacroPopupScrollFrame, ceil(numMacroIcons / NUM_ICONS_PER_ROW) , NUM_ICON_ROWS, MACRO_ICON_ROW_HEIGHT );
end

function SuperMacroPopupOkayButton_Update()
	if ( (strlen(SuperMacroPopupEditBox:GetText()) > 0) and SuperMacroPopupFrame.selectedIcon ) then
		SuperMacroPopupOkayButton:Enable();
	else
		SuperMacroPopupOkayButton:Disable();
	end
	if ( SuperMacroPopupFrame.mode == "edit" and (strlen(SuperMacroPopupEditBox:GetText()) > 0) ) then
		SuperMacroPopupOkayButton:Enable();
	end
end

function SuperMacroPopupButton_OnClick()
	SuperMacroPopupFrame.selectedIcon = this:GetID() + (FauxScrollFrame_GetOffset(SuperMacroPopupScrollFrame) * NUM_ICONS_PER_ROW);
	if ( SM_VARS.tabShown=="regular" ) then
		SuperMacroFrameSelectedMacroButtonIcon:SetTexture( GetMacroIconInfo(SuperMacroPopupFrame.selectedIcon));
	elseif ( SM_VARS.tabShown=="super" ) then
		SuperMacroFrameSelectedMacroSuperButtonIcon:SetTexture( GetMacroIconInfo(SuperMacroPopupFrame.selectedIcon));
	end
	SuperMacroPopupOkayButton_Update();
	SuperMacroPopupFrame_Update();
end

function SuperMacroPopupOkayButton_OnClick()
	local index = 1;
	local texture=SuperMacroFrameSelectedMacroSuperButtonIcon:GetTexture();
	local macroname=SuperMacroPopupEditBox:GetText();
	if ( SuperMacroPopupFrame.mode == "newaccount" ) then
		index = CreateMacro(macroname, SuperMacroPopupFrame.selectedIcon, nil, nil, false );
		SuperMacroFrame_SelectMacro(index);
	elseif ( SuperMacroPopupFrame.mode == "newcharacter" ) then
		index = CreateMacro(macroname, SuperMacroPopupFrame.selectedIcon, nil, nil, true );
		SuperMacroFrame_SelectMacro(index);
	elseif ( SuperMacroPopupFrame.mode == "newsuper" ) then
		index = CreateSuperMacro(macroname, texture, '');
		SuperMacroFrame_SelectSuperMacro(index);
	elseif ( SuperMacroPopupFrame.mode == "edit" ) then
		if ( SM_VARS.tabShown=="regular" ) then
			index = EditMacro(SuperMacroFrame.selectedMacro, macroname, SuperMacroPopupFrame.selectedIcon);
			if ( GetMacroIndexByName(SuperMacroPopupFrame.oldname)==0 ) then
				SM_UpdateActionSpell(SuperMacroPopupFrame.oldname, "regular", '');
			end
			SM_UpdateActionSpell(macroname, "regular", GetMacroInfo(index, "body"));
			SuperMacroFrame_SelectMacro(index);
		elseif ( SM_VARS.tabShown=="super" ) then
			local oldsuper=GetOrderedSuperMacroInfo(SuperMacroFrame.selectedSuper);
			if ( SM_SUPER[macroname] ) then
				macroname=SuperMacroPopupFrame.oldname;
			end
			index = EditSuperMacro(SuperMacroFrame.selectedSuper, macroname, texture);
			SuperMacroFrame_SelectSuperMacro(index);
			SuperMacro_UpdateAction(oldsuper, macroname);
		end
	end
	SuperMacroPopupFrame:Hide();
	SuperMacroFrame_Update();
	
	-- if edited name, use oldextend
	if ( oldextend ) then
		SuperMacroFrameExtendText:SetText(oldextend);
	elseif ( SameMacroName() ) then
	-- get extend with same name, else empty
		local text = SuperMacroGetExtend( GetMacroInfo( SameMacroName(),"name" ) ) ;
			if ( text ) then
				SuperMacroFrameExtendText:SetText( text );
			end
	else
		SuperMacroFrameExtendText:SetText("");
	end
	SuperMacroSaveExtend();
	oldextend=nil;
end

function SuperMacroOptionsButton_OnClick()
	if ( SuperMacroOptionsFrame:IsVisible() ) then
		HideUIPanel(SuperMacroOptionsFrame);
	else
		ShowUIPanel(SuperMacroOptionsFrame);
	end
end

function SuperMacroFrame_SaveMacro()
	if ( SuperMacroFrame.textChanged and SuperMacroFrame.selectedMacro ) then
		EditMacro(SuperMacroFrame.selectedMacro, nil, nil, SuperMacroFrameText:GetText());
		SuperMacroFrame.textChanged = nil;
		SM_UpdateActionSpell( GetMacroInfo(SuperMacroFrame.selectedMacro, "name"), "regular", SuperMacroFrameText:GetText());
	end
end

function SuperMacroFrame_SaveSuperMacro()
	if ( SuperMacroFrame.textChanged and SuperMacroFrame.selectedSuper ) then
		local macroName = SelectedMacroName();
		local macroTexture = SuperMacroFrameSelectedMacroSuperButtonIcon:GetTexture();
		local macroBody = SuperMacroFrameSuperText:GetText();
		SM_SUPER[macroName] = {macroName,macroTexture,macroBody};
		SuperMacroFrame.textChanged = nil;
		SM_UpdateActionSpell(macroName, "super", macroBody);
	end
end

function SuperMacroFrame_OnEvent(event)
	if ( event=="TRADE_SKILL_SHOW") then
		if ( not old_SM_TradeSkillSkillButton_OnClick) then
			old_SM_TradeSkillSkillButton_OnClick = TradeSkillSkillButton_OnClick;
			TradeSkillSkillButton_OnClick = SM_TradeSkillSkillButton_OnClick;
			SM_TradeSkillItem_OnClick();
		end
	end
	if ( event=="CRAFT_SHOW") then
		if ( not old_SM_CraftButton_OnClick) then
			old_SM_CraftButton_OnClick = CraftButton_OnClick;
			CraftButton_OnClick = SM_CraftButton_OnClick;
			SM_CraftItem_OnClick();
		end
	end
	if ( event=="VARIABLES_LOADED" ) then
		if ( not SM_VARS.hideAction ) then
			SM_VARS.hideAction = 0;
		end
		if ( not SM_VARS.printColor ) then
			SM_VARS.printColor = PRINT_COLOR_DEF;
		end
		if ( not SM_VARS.macroTip1 ) then
			SM_VARS.macroTip1= 1;
		end
		if ( not SM_VARS.macroTip2 ) then
			SM_VARS.macroTip2= 0;
		end
		if ( not SM_VARS.minimap ) then
			SM_VARS.minimap = 1;
		end
		if ( not SM_VARS.replaceIcon ) then
			SM_VARS.replaceIcon = 1;
		end
		if ( not SM_VARS.checkCooldown ) then
			SM_VARS.checkCooldown = 1;
		end
		if ( not SM_VARS.tabShown ) then
			SM_VARS.tabShown = "regular";
		end
		if ( SM_VARS.tabShown=="regular" ) then
			SuperMacroFrame.selectedTab = 1;
			PanelTemplates_UpdateTabs(this);
		elseif ( SM_VARS.tabShown=="super" ) then
			SuperMacroFrame.selectedTab = 2;
			PanelTemplates_UpdateTabs(this);
		end
		HideActionText();
		ToggleSMMinimap();
		SuperMacroRunScriptExtend();
		SuperMacroFrame.extendChanged=nil;
		SM_ORDERED=SortSuperMacroList();
		local player=UnitName("player").." of "..GetRealmName();
		if ( not SM_ACTION_SUPER[player] ) then
			SM_ACTION_SUPER[player]={};
		end
		SM_ACTION=SM_ACTION_SUPER[player];
		SM_UpdateActionSpell();

		-- update alias replacement function
		-- ASF aka Alias-Spellchecker-Filter
		if (ReplaceAlias and ASFOptions.aliasOn) then
			SM_InsertAliasFunction(ReplaceAlias);
		end
		-- ChatAlias
		if (CA_ParseMessage) then
			SM_InsertAliasFunction(ReplaceAlias, -1);
			-- this messes up newlines, so should not run during RunMacro
		end
		-- for any other alias addons, do tinsert(SM_AliasFunctions, your_function) inside your mod

	end
	if ( event=="PLAYER_ENTERING_WORLD" ) then
		SM_UpdateActionSpell();
	end
	if ( event=="PLAYER_LEAVING_WORLD" ) then
		SM_ACTION_SUPER[player]=SM_ACTION;
	end
end

function RunMacro(index)
	-- close edit boxes, then enter body line by line
	if ( SuperMacroFrame_SaveMacro ) then
		SuperMacroFrame_SaveMacro();
	end
	if ( MacroFrame_SaveMacro ) then
		MacroFrame_SaveMacro();
	end
	local body;
	if ( type(index) == "number" ) then
		body = GetMacroInfo(index, "body");
	elseif ( type(index) == "string" ) then
		body = GetMacroInfo(GetMacroIndexByName(index),"body");
	end
	if ( not body ) then return; end

	if ( ChatFrameEditBox:IsVisible() ) then
		ChatEdit_OnEscapePressed(ChatFrameEditBox);
	end

	body = SM_ReplaceAlias(body);

	--SM_MacroRunning = true;
	while ( strlen(body)>0 ) do
		local block, line;
		body, block, line=FindBlock(body);
		if ( block ) then
			RunScript(block);
		else
			RunLine(line);
		end
	end
	--SM_MacroRunning = nil;
end

Macro=RunMacro;

function RunSuperMacro(index)
	if ( SuperMacroFrame_SaveSuperMacro ) then
		SuperMacroFrame_SaveSuperMacro();
	end
	local _,body=nil;
	if ( type(index)=="number") then
		_,_,body = GetOrderedSuperMacroInfo(index);
	elseif ( type(index) == "string" ) then
		body = GetSuperMacroInfo(index,"body");
	end
	if ( not body ) then return; end

	if ( ChatFrameEditBox:IsVisible() ) then
		ChatEdit_OnEscapePressed(ChatFrameEditBox);
	end

	body = SM_ReplaceAlias(body);

	--SM_MacroRunning = true;
	while ( strlen(body)>0 ) do
		local block, line;
		body, block, line=FindBlock(body);
		if ( block ) then
			RunScript(block);
		else
			RunLine(line);
		end
	end
	--SM_MacroRunning = nil;
end

function FindBlock(body)
	local a,b,block=strfind(body,"^/script (%-%-%-%-%[%[.-%-%-%-%-%]%])[\n]*");
	if ( block ) then
		body=strsub(body,b+1);
		return body, block;
	end
	local a,b,line=strfind(body,"^([^\n]*)[\n]*");
	if ( line ) then
		body=strsub(body,b+1);
		return body, nil, line;
	end
end

function RunBody(text)
	local body=text;
	local length = strlen(body);
	for w in string.gfind(body, "[^\n]+") do
		RunLine(w);
	end
end

function RunLine(...)
-- execute a line in a macro
-- if script or cast, then rectify and RunScript
-- else send to chat edit box
	for k=1,arg.n do
		local text=arg[k];
		
		-- replace aliases
		text = SM_ReplaceAlias(text, -1);
		
		if ( string.find(text, "^/cast") ) then
			local i, book = SM_FindSpell(gsub(text,"^%s*/cast%s*(%w.*[%w%)])%s*$","%1"));
			if ( i ) then
				CastSpell(i,book);
			end
		else
			if ( string.find(text,"^/script ")) then
				RunScript(gsub(text,"^/script ",""));
			else
				text = gsub( text, "\n", ""); -- cannot send newlines, will disconnect
				ChatFrameEditBox:SetText(text);
				ChatEdit_SendText(ChatFrameEditBox);
			end
		end
	end -- for
end -- RunLine()
	
function SM_ReplaceAlias(body, after)
	local size, step;
	if ( after==-1 ) then
		size, step = SM_AliasFunctions.low, -1;
	else
		size, step = SM_AliasFunctions.high, 1;
	end
	for i=step, size, step do
		body = SM_AliasFunctions[i](body);
	end
	return body;
end

function SM_InsertAliasFunction(func, pos)
	if ( pos==-1 ) then
		SM_AliasFunctions.low = SM_AliasFunctions.low - 1;
		SM_AliasFunctions[SM_AliasFunctions.low]=func;
		return SM_AliasFunctions.low;
	else
		SM_AliasFunctions.high = SM_AliasFunctions.high + 1;
		SM_AliasFunctions[SM_AliasFunctions.high]=func;
		return SM_AliasFunctions.high;
	end
end

function SM_FindSpell(spell)
	local s = gsub(spell, "%s*(.-)%s*%(.*","%1");
	local r;
	local num = tonumber(gsub( spell, "%D*(%d+)%D*", "%1"),10);
	if ( string.find(spell, "%(%s*[Rr]acial")) then
		r = "racial"
	elseif ( string.find(spell, "%(%s*[Ss]ummon")) then
		r = "summon"
	elseif ( string.find(spell, "%(%s*[Aa]pprentice")) then
		r = "apprentice"
	elseif ( string.find(spell, "%(%s*[Jj]ourneyman")) then
		r = "journeyman"
	elseif ( string.find(spell, "%(%s*[Ee]xpert")) then
		r = "expert"
	elseif ( string.find(spell, "%(%s*[Aa]rtisan")) then
		r = "artisan"
	elseif ( string.find(spell, "%(%s*[Mm]aster")) then
		r = "master"
	elseif ( string.find(spell, "[Rr]ank%s*%d+") and num and num > 0) then
		r = gsub(spell, ".*%(.*[Rr]ank%s*(%d+).*", "Rank "..num);
	else
		r = ""
	end
	return FindSpell(s,r);
end

function FindSpell(spell, rank)
	local i = 1;
	local booktype = { "spell", "pet", };
	--local booktype = "spell";
	local s,r;
	local ys, yr;
	for k, book in booktype do
		while spell do
		s, r = GetSpellName(i,book);
		if ( not s ) then
			i = 1;
			break;
		end
		if ( string.lower(s) == string.lower(spell)) then ys=true; end
		if ( (r == rank) or (r and rank and string.lower(r) == string.lower(rank))) then yr=true; end
		if ( rank=='' and ys and (not GetSpellName(i+1, book) or string.lower(GetSpellName(i+1, book)) ~= string.lower(spell) )) then
			yr = true; -- use highest spell rank if omitted
		end
		if ( ys and yr ) then
			return i,book;
		end
		i=i+1;
		ys = nil;
		yr = nil;
		end
	end
	return;
end

function SuperMacroSaveExtendButton_OnClick()
	SuperMacroSaveExtend();
	SuperMacroRunScriptExtend();
end

function SuperMacroDeleteExtendButton_OnClick()
	SuperMacroSaveExtend(SelectedMacroName(),1);
	SuperMacroRunScriptExtend();
end

function SuperMacroSaveExtend(macro, delete)
	local text=SuperMacroFrameExtendText:GetText();
	if ( delete ) then text = nil; end
	if ( not macro ) then
		macro = SelectedMacroName();
	end
	if ( macro ) then
    	if ( text and text~="" ) then
		SM_EXTEND[macro]=text;
	else
		SM_EXTEND[macro]=nil;
			if ( macro == SelectedMacroName() ) then
			SuperMacroFrameExtendText:SetText('');
			end
	end
	end
	SuperMacroFrame.extendChanged=nil;
	SuperMacroFrameExtendText:ClearFocus();
end

function SuperMacroGetExtend(macro)
	return SM_EXTEND[macro];
end

function SuperMacroRunScriptExtend()
	for m,e in pairs(SM_EXTEND) do
		if ( e ) then
			RunScript(e);
		end
	end
end

function SuperMacroDeleteButton_OnClick()
-- check other macros with same name to see if save extend
	local macro=GetMacroInfo(SuperMacroFrame.selectedMacro,"name");
	if ( SameMacroName()==false ) then
		SuperMacroSaveExtend(macro,1); -- delete extend
	end
	DeleteMacro(SuperMacroFrame.selectedMacro);
	SuperMacroFrame_OnLoad();
	SuperMacroFrame_Update();
	local name = GetMacroInfo(1,"name");
	oldextend = SM_EXTEND[name];
	if ( oldextend ) then
		SuperMacroFrameExtendText:SetText(oldextend);
	end
	oldextend = nil;
	SuperMacroFrameText:ClearFocus();
end

function SuperMacroDeleteSuperButton_OnClick()
	DeleteSuperMacro(SuperMacroFrame.selectedSuper);
	--SuperMacroFrame_OnLoad();
	SuperMacroFrame_Update();
	local name = GetOrderedSuperMacroInfo(1);
	SuperMacroFrameSuperText:ClearFocus();
end

function SameMacroName(macroindex)
	if ( not macroindex and SuperMacroFrame.selectedMacro ) then
		macroindex = SuperMacroFrame.selectedMacro;
	else
		return; -- error check for nil, no macro selected
	end
	local macro=GetMacroInfo(macroindex,"name");
	local prevmacro, nextmacro = GetMacroInfo(macroindex-1,"name"), GetMacroInfo(macroindex+1,"name");
	if ( prevmacro == macro ) then
		return macroindex-1;
	elseif ( nextmacro == macro ) then
		return macroindex+1;
	else
		return false; -- must check "==false"
		-- don't check "not SameMacroName()" unless error check or no macro selected
	end
end

function SelectedMacroName()
	return SuperMacroFrameSelectedMacroName:GetText();
end

local oldGetMacroInfo=GetMacroInfo;
function GetMacroInfo(index, code)
	if ( not index ) then return; end
	-- code can be "name", "texture", "body", "islocal"
	local a={};
	a.name,a.texture,a.body,a.islocal=oldGetMacroInfo(index);
	if (not code) then
		return a.name,a.texture,a.body,a.islocal;
	else
		return a[code];
	end
end

function SetActionMacro( actionid , macro ) 
	local macroid = GetMacroIndexByName( macro )
	if ( macroid and actionid > 0 and actionid <= 120 ) then
		PickupAction( actionid );
		PickupMacro( macroid );
		PlaceAction ( actionid );
	end
end

function ToggleSMMinimap()
	if ( SM_VARS.minimap == 1 ) then
		SuperMacroMinimapButton:Show();
	else
		SuperMacroMinimapButton:Hide();
	end
end

function SM_UpdateAction()
	-- Update Macros on action bars
	local function doUpdate(button)
		if ( button ) then
			button:SetScript("OnLeave", SM_ActionButton_OnLeave);
			local oldscript=button:GetScript("OnClick");
			button:SetScript("OnClick", function()
				if ( not SM_ActionButton_OnClick() ) then
					oldscript();
				end
			end);

			-- refresh buttons on load
			local macroName = getglobal(button:GetName().."Name") and getglobal(button:GetName().."Name"):GetText();
			if ( macroName ) then
				local macroID = GetMacroIndexByName(macroName);
				if ( macroID ) then
					local name, texture, body, isLocal = GetMacroInfo(macroID);
					EditMacro(macroID, nil, nil, body, isLocal);
				end
			end
		end
	end
	for i=1,12 do
		doUpdate(getglobal("ActionButton"..i));
		doUpdate(getglobal("BonusActionButton"..i));
		doUpdate(getglobal("MultiBarBottomLeftButton"..i));
		doUpdate(getglobal("MultiBarBottomRightButton"..i));
		doUpdate(getglobal("MultiBarRightButton"..i));
		doUpdate(getglobal("MultiBarLeftButton"..i));
	end
	if ( FUActionButton1 ) then
		for i=1,72 do
			doUpdate(getglobal("FUActionButton"..i));
		end
	end
	---[[
	if ( DAB_ActionButton_1 ) then
		for i=1, 120 do
			doUpdate(getglobal("DAB_ActionButton_"..i));
		end
	end
	--]]
end

function GetNumSuperMacros()
	return getn(SM_ORDERED);
end

function GetSuperMacroInfo( superName, code)
	if ( not superName or not SM_SUPER[superName] ) then return; end
	-- code can be "name", "texture", "body"
	local a={};
	a.name,a.texture,a.body=unpack(SM_SUPER[superName]);
	if (not code) then
		return a.name,a.texture,a.body;
	else
		return a[code];
	end
end

function SortSuperMacroList()
	-- sort SM_SUPER into ordered list
	local a={};
	for n in pairs(SM_SUPER) do
		table.insert(a, n);
	end
	table.sort(a, atoz);
	return a;
end

function GetOrderedSuperMacroInfo( id )
	if ( not SM_ORDERED ) then
			SM_ORDERED=SortSuperMacroList();
	end
	if ( not SM_SUPER[SM_ORDERED[id] ] ) then
		return;
	end
	return unpack(SM_SUPER[SM_ORDERED[id] ]);
end

function GetOrderedSuperMacro( name )
	for i,v in SM_ORDERED do
		if ( v==name ) then
			return i;
		end
	end
end

function CreateSuperMacro( name, texture, body )
	if ( not SM_SUPER[name] ) then
		SM_SUPER[name]={name, texture, body or ''};
	end
	SM_UpdateActionSpell( name, "super", body);
	SM_ORDERED=SortSuperMacroList();
	return GetOrderedSuperMacro(name);
end

function EditSuperMacro( id, name, texture)
	local oldMacro, oldTexture, oldBody=GetOrderedSuperMacroInfo(id);
	if ( oldMacro~=name ) then
		SM_SUPER[oldMacro]=nil;
		SM_UpdateActionSpell( oldMacro, "super", nil);
	end
	SM_SUPER[name]={ name, texture, oldBody};
	SM_UpdateActionSpell( name, "super", oldBody);
	SM_ORDERED=SortSuperMacroList();
	return GetOrderedSuperMacro(name);
end

function DeleteSuperMacro( macro )
	local id=macro;
	if ( type(macro)=="number" ) then
		macro=GetOrderedSuperMacroInfo(macro);
	else
		id=GetOrderedSuperMacro(macro);
	end
	SM_SUPER[macro]=nil;
	SM_ORDERED=SortSuperMacroList();
	if ( GetNumSuperMacros()==0 ) then
		id=nil;
	else
		id=id>1 and id-1 or 1;
	end
	SuperMacroFrame_SelectSuperMacro(id);
end

function SM_LoadMacroIcons()
	local icon={};
	for i=1,GetNumMacroIcons() do
		local texture=GetMacroIconInfo(i);
		icon[texture]=i;
	end
	return icon;
end

function SM_UpdateActionSpell( macroname, macrotype, body)
-- SM_ACTION_SPELL={}
-- SM_ACTION_SPELL.regular={}
-- SM_ACTION_SPELL.super={}
	if ( not macroname ) then
	-- update all macros
		for i=1, 36 do
			local name,_,body=GetMacroInfo(i);
			if ( name ) then
				SM_UpdateActionSpell(name, "regular", body);
			end
		end
		for i=1, GetNumSuperMacros() do
			local name,_,body=GetOrderedSuperMacroInfo(i);
			SM_UpdateActionSpell(name, "super", body);
		end
		return;
	end
	--macrotype is "regular" or "super"
	if ( macrotype~="regular" and macrotype~="super" ) then
		macrotype="regular";
	end
	SM_ACTION_SPELL[macrotype][macroname]={};
	local id, book, texture, count, spell=FindFirstSpell(body);
	if ( id ) then
		SM_ACTION_SPELL[macrotype][macroname].type="spell";
		spell=count;
	else
		id, book, texture, count, spell=FindFirstItem(body);
		if ( id ) then
			SM_ACTION_SPELL[macrotype][macroname].type="item";
		end
	end
	if ( not id ) then
		SM_ACTION_SPELL[macrotype][macroname]=nil;
		return;
	end
	SM_ACTION_SPELL[macrotype][macroname].spell=spell;
	SM_ACTION_SPELL[macrotype][macroname].texture=texture;
end

function SM_GetActionSpell(macroname, macrotype)
	if ( macrotype and macrotype~="regular" ) then
		macrotype="super";
	else
		macrotype="regular";
	end
	if ( not SM_ACTION_SPELL[macrotype][macroname] ) then
		return nil;
	end
	local actiontype=SM_ACTION_SPELL[macrotype][macroname].type;
	local spell=SM_ACTION_SPELL[macrotype][macroname].spell;
	local texture=SM_ACTION_SPELL[macrotype][macroname].texture;
	return actiontype, spell, texture;
end