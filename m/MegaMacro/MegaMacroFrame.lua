MAX_MEGAMACROS = 84;
NUM_MACRO_ICONS_SHOWN = 20;
NUM_ICONS_PER_ROW = 5;
NUM_ICON_ROWS = 4;
MACRO_ICON_ROW_HEIGHT = 36;
local menucheck = 0;
local loadcheck = 0;

BINDING_HEADER_MEGAMACROHEADER = "Megamacro";
BINDING_NAME_MEGAMACRO = "MegaMacro Toggle";

MegaMacroText = {};

SLASH_MEGAMACRO1 = "/megamacro";
SlashCmdList["MEGAMACRO"] = function(msg)
	ShowMegaMacroFrame();
end
SlashCmdList["MACRO"] = function(msg)
	ShowMegaMacroFrame();
end
UIPanelWindows["MegaMacroFrame"] = { area = "left", pushable = 5 };

-- Hook the New MacroFrame Load to load MegaMacro LoadOnDemand Style :)
--MacroFrame_LoadUI = MegaMacroFrame_LoadUI;

function MegaMacroFrame_LoadUI()
	-- Hmm :) do nothing for now..
	--UIParentLoadAddOn("MegaMacro");
	if ( not MegaMacroFrame:IsVisible() ) then
		ShowUIPanel(MegaMacroFrame);
	end
end

function ShowMegaMacroFrame()
	ShowUIPanel(MegaMacroFrame);
end

function MegaMacro_SpellButton_OnClick(drag) 
	local id = SpellBook_GetSpellID(this:GetID());
	if ( id > MAX_SPELLS ) then
		return;
	end
	this:SetChecked("false");
	if ( drag ) then
		PickupSpell(id, SpellBookFrame.bookType);
	elseif ( IsShiftKeyDown() ) then
		if ( MegaMacroFrame and MegaMacroFrame:IsVisible() ) then
			local spellName, subSpellName = GetSpellName(id, SpellBookFrame.bookType);
			if ( spellName and not IsSpellPassive(id, SpellBookFrame.bookType) ) then
				if ( subSpellName and (strlen(subSpellName) > 0) ) then
					MegaMacroFrame_AddMacroLine(TEXT(SLASH_CAST1).." "..spellName.."("..subSpellName..")");
				else
					MegaMacroFrame_AddMacroLine(TEXT(SLASH_CAST1).." "..spellName);
				end
			end
		else
			PickupSpell(id, SpellBookFrame.bookType );
		end
	elseif ( arg1 ~= "LeftButton" and SpellBookFrame.bookType == BOOKTYPE_PET ) then
		ToggleSpellAutocast(id, SpellBookFrame.bookType);
	else
		CastSpell(id, SpellBookFrame.bookType);
		SpellButton_UpdateSelection();
	end
end

function MegaMacroFrame_OnLoad()
	--Fix the load error hopefully
	--this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	
	-- Hook functions
	MacroFrame_LoadUI = MegaMacroFrame_LoadUI;
	ShowMacroFrame = ShowMegaMacroFrame;

	-- Hook spellbook to allow shift clicking of spells
	SpellButton_OnClick = MegaMacro_SpellButton_OnClick;

	if ( GetNumMacros() > 0 ) then
		MegaMacroFrame_SelectMacro(1);
		MegaMacroFrameSelectedMacroButton:SetID(1);
	else
		MegaMacroFrame_SelectMacro(nil);
	end
end

function DeleteMegaMacroFrame_OnLoad()
	if ( GetNumMacros() > 0 ) then
		MegaMacroFrame_SelectMacro(1);
		MegaMacroFrameSelectedMacroButton:SetID(1);
	else
		MegaMacroFrame_SelectMacro(nil);
	end
end

function MegaMacro_OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		MegaMacro_Init();
	end
end

function MegaMacro_Init()
	if ( loadcheck == 0 ) then
		local numMacros = GetNumMacros();
		for i=1, MAX_MEGAMACROS do
			if ( i <= numMacros ) then
				macroName = GetMacroInfo(i);
				if ( not MegaMacroText[macroName] ) then
					MegaMacroText[macroName] = "";
				else
					RunScript(MegaMacroText[macroName]);
				end
			end
		end
		loadcheck = 1;
	end
end

function NewChatMenu_OnShow()
	UIMenu_OnShow();
	EmoteMenu:Hide();
	if (menucheck ==0) then
		--ChatMenuButton10:Hide();
		UIMenu_AddButton("MegaMacro", nil, ShowMegaMacroFrame);
		menucheck = 1;
	end
end

function MegaMacro_Execute()
	MegaMacroText[macroName] = MegaMacroEditBox:GetText();
	RunScript(MegaMacroText[macroName]);
	MegaMegaMacroNewButton:Disable();
end

function MegaMacro_UpdateText(macroName)
	
	--if ( not macroName ) then
		-- Hmm
	--else
	--if ( not MegaMacroText[macroName] ) then
		--MegaMacroText[macroName] = "";
	--end
	MegaMacroText[macroName] = MegaMacroEditBox:GetText();
	--end
end

function MegaMacroFrame_OnShow()
	MegaMacroFrame_Update();
	PlaySound("igCharacterInfoOpen");
	--MacroNewButton:SetText(NEW);
	--Mega macro updates
	MegaMegaMacroNewButton:Disable();
	MegaMacroID = MegaMacroFrame.selectedMacro;
	if ( not MegaMacroID ) then
		-- Hmm
	else
		macroName = GetMacroInfo(MegaMacroID);
		MegaMacroEditBox:SetText(MegaMacroText[macroName]);
	end
end

function MegaMacroFrame_OnHide()
	MegaMacroPopupFrame:Hide();
	if ( MegaMacroFrame.textChanged and MegaMacroFrame.selectedMacro and GetNumMacros() > 0) then
		EditMacro(MegaMacroFrame.selectedMacro, nil, nil, MegaMacroFrameText:GetText(), 1);		
	end
	MegaMacroFrame.textChanged = nil;
	--Dunno why but this is what blizzard did..
	--SaveMacros();
	PlaySound("igCharacterInfoClose");
end

function MegaMacroFrame_Update()
	local numMacros	= GetNumMacros();
	local megamacroButton, macroIcon, macroName;
	local name, texture, body, isLocal;
	local selectedName, selectedBody, selectedIcon;
	
	-- Macro List
	for i=1, MAX_MEGAMACROS do
		megamacroButton = getglobal("MegaMacroButton"..i);
		macroIcon = getglobal("MegaMacroButton"..i.."Icon");
		macroName = getglobal("MegaMacroButton"..i.."Name");
		if ( i <= numMacros ) then
			name, texture, body, isLocal = GetMacroInfo(i);
			macroIcon:SetTexture(texture);
			macroName:SetText(name);
			megamacroButton:Enable();
			-- Highlight Selected Macro
			if ( i == MegaMacroFrame.selectedMacro ) then
				megamacroButton:SetChecked(1);
				MegaMacroFrameSelectedMacroName:SetText(name);
				MegaMacroFrameText:SetText(body);
				MegaMacroFrameSelectedMacroButtonIcon:SetTexture(texture);
			else
				megamacroButton:SetChecked(0);
			end
		else
			megamacroButton:SetChecked(0);
			macroIcon:SetTexture("");
			macroName:SetText("");
			megamacroButton:Disable();
		end
	end

	--Mega Macro Updates
	local numMacros	= GetNumMacros();
	for i=1, MAX_MEGAMACROS do		
		if ( i <= numMacros ) then
			macroName = GetMacroInfo(i);
			if ( not MegaMacroText[macroName] ) then
				MegaMacroText[macroName] = "";
			else
				--RunScript on PLAYER_ENTERING_WORLD once
				--RunScript(MegaMacroText[macroName]);
			end
		end
	end

	-- Macro Details
	if ( MegaMacroFrame.selectedMacro ~= nil ) then
		MegaMacroFrame_ShowDetails();
		MegaMacroDeleteButton:Enable();
	else
		MegaMacroFrame_HideDetails();
		MegaMacroDeleteButton:Disable();
	end
	
	if ( numMacros == MAX_MEGAMACROS or MegaMacroPopupFrame:IsVisible() ) then
		MegaMacroNewButton:Disable();
	else
		MegaMacroNewButton:Enable();
	end

	-- Disable Buttons
	if ( MegaMacroPopupFrame:IsVisible() ) then
		MegaMacroEditButton:Disable();
		MegaMacroDeleteButton:Disable();
	else
		MegaMacroEditButton:Enable();
		MegaMacroDeleteButton:Enable();
	end

	if ( not MegaMacroFrame.selectedMacro ) then
		MegaMacroDeleteButton:Disable();
	end
end

function MegaMacroFrame_AddMacroLine(line)
	if ( MegaMacroFrameText:IsVisible() ) then
		MegaMacroFrameText:SetText(MegaMacroFrameText:GetText()..line);
	end
end

function MegaMacroButton_OnClick()
	if ( MegaMacroFrame.textChanged and MegaMacroFrame.selectedMacro ) then
		EditMacro(MegaMacroFrame.selectedMacro, nil, nil, MegaMacroFrameText:GetText(), 1);		
	end
	MegaMacroFrame.textChanged = nil;
	MegaMacroFrame_SelectMacro(this:GetID());
	MegaMacroFrameSelectedMacroButton:SetID(this:GetID());
	MegaMacroFrame_Update();
	MegaMacroPopupFrame:Hide();
	MegaMacroFrameText:ClearFocus();
	--Mega Macro Stuff
	MegaMacroEditBox:ClearFocus();
	MegaMacroEditBox:SetTextColor(25,25,25);
	MegaMacroID = MegaMacroFrame.selectedMacro;
	macroName = GetMacroInfo(MegaMacroID);
	--if ( not MegaMacroText[macroName] ) then
		--MegaMacroText[macroName] = "";
	--end
	MegaMacroEditBox:SetText(MegaMacroText[macroName]);
	MegaMacro_UpdateText(macroName);
end

function MegaMacroFrame_SelectMacro(id)
	MegaMacroFrame.selectedMacro = id;
end

function MegaMacroNewButton_OnClick()
	if ( MegaMacroNewButton:GetText() == COMPLETE ) then
		MegaMacroFrameText:ClearFocus();
		EditMacro(MegaMacroFrame.selectedMacro, nil, nil, MegaMacroFrameText:GetText(), 1);		
		--MegaMacroNewButton:SetText(NEW);
		return;
	end
	
	MegaMacroPopupFrame.mode = "new";
	if ( MegaMacroFrame.textChanged and MegaMacroFrame.selectedMacro ) then
		EditMacro(MegaMacroFrame.selectedMacro, nil, nil, MegaMacroFrameText:GetText(), 1);		
	end
	MegaMacroFrameText:Hide();
	MegaMacroFrame.textChanged = nil;
	MegaMacroFrameSelectedMacroButtonIcon:SetTexture("");
	MegaMacroPopupFrame.selectedIcon = nil;
	MegaMacroPopupFrame:Show();
	--MegaMacroNewButton:SetText(COMPLETE);
	MegaMegaMacroNewButton:Disable();
end

function MegaMacroEditButton_OnClick()
	MegaMacroPopupFrame.mode = "edit";
	if ( MegaMacroFrame.textChanged ) then
		EditMacro(MegaMacroFrame.selectedMacro, nil, nil, MegaMacroFrameText:GetText(), 1);		
	end
	MegaMacroFrame.textChanged = nil;
	MegaMacroPopupOkayButton_Update();
	MegaMacroPopupFrame:Show();
end

function MegaMacroFrame_HideDetails()
	MegaMacroEditButton:Hide();
	MegaMacroFrameCharLimitText:Hide();
	MegaMacroFrameText:Hide();
	MegaMacroFrameSelectedMacroName:Hide();
	MegaMacroFrameSelectedMacroBackground:Hide();
	MegaMacroFrameSelectedMacroButton:Hide();
end

function MegaMacroFrame_ShowDetails()
	MegaMacroEditButton:Show();
	MegaMacroFrameCharLimitText:Show();
	MegaMacroFrameEnterMacroText:Show();
	MegaMacroFrameText:Show();
	MegaMacroFrameSelectedMacroName:Show();
	MegaMacroFrameSelectedMacroBackground:Show();
	MegaMacroFrameSelectedMacroButton:Show();
end

function MegaMacroPopupFrame_OnShow()
	MegaMacroPopupFrame_Update();
	PlaySound("igCharacterInfoOpen");
	MegaMacroFrameText:ClearFocus();
	MegaMacroPopupEditBox:SetFocus();
	MegaMacroPopupOkayButton_Update();

	-- Disable Buttons
	MegaMacroEditButton:Disable();
	MegaMacroDeleteButton:Disable();
	MegaMacroNewButton:Disable();
end

function MegaMacroPopupFrame_OnHide()
	if ( this.mode == "new" ) then
		MegaMacroFrameText:Show();
		MegaMacroFrameText:SetFocus();
	end
	
	-- Enable Buttons
	MegaMacroEditButton:Enable();
	MegaMacroDeleteButton:Enable();
	MegaMacroNewButton:Enable();
end

function MegaMacroPopupFrame_Update()
	local numMacroIcons = GetNumMacroIcons();
	local macroPopupIcon, macroPopupButton;
	local macroPopupOffset = FauxScrollFrame_GetOffset(MegaMacroPopupScrollFrame);
	local index;
	
	-- Determine whether we're creating a new macro or editing an existing one
	if ( this.mode == "new" ) then
		MegaMacroPopupEditBox:SetText("");
	elseif ( this.mode == "edit" ) then
		local name, texture, body, isLocal = GetMacroInfo(MegaMacroFrame.selectedMacro);
		MegaMacroPopupEditBox:SetText(name);
	end
	
	-- Icon list
	for i=1, NUM_MACRO_ICONS_SHOWN do
		macroPopupIcon = getglobal("MegaMacroPopupButton"..i.."Icon");
		macroPopupButton = getglobal("MegaMacroPopupButton"..i);
		index = (macroPopupOffset * NUM_ICONS_PER_ROW) + i;
		if ( index <= numMacroIcons ) then
			macroPopupIcon:SetTexture(GetMacroIconInfo(index));
			macroPopupButton:Show();
		else
			macroPopupIcon:SetTexture("");
			macroPopupButton:Hide();
		end
		if ( index == MegaMacroPopupFrame.selectedIcon ) then
			macroPopupButton:SetChecked(1);
		else
			macroPopupButton:SetChecked(nil);
		end
	end
	
	-- Scrollbar stuff
	FauxScrollFrame_Update(MegaMacroPopupScrollFrame, ceil(numMacroIcons / NUM_ICONS_PER_ROW) , NUM_ICON_ROWS, MACRO_ICON_ROW_HEIGHT );
end

function MegaMacroPopupOkayButton_Update()
	if ( (strlen(MegaMacroPopupEditBox:GetText()) > 0) and MegaMacroPopupFrame.selectedIcon ) then
		MegaMacroPopupOkayButton:Enable();
	else
		MegaMacroPopupOkayButton:Disable();
	end
	if ( MegaMacroPopupFrame.mode == "edit" and (strlen(MegaMacroPopupEditBox:GetText()) > 0) ) then
		MegaMacroPopupOkayButton:Enable();
	end
end

function MegaMacroPopupButton_OnClick()
	MegaMacroPopupFrame.selectedIcon =  this:GetID() + (FauxScrollFrame_GetOffset(MegaMacroPopupScrollFrame) * NUM_ICONS_PER_ROW)
	MegaMacroFrameSelectedMacroButtonIcon:SetTexture(GetMacroIconInfo(MegaMacroPopupFrame.selectedIcon));
	MegaMacroPopupOkayButton_Update();
	MegaMacroPopupFrame_Update();
end

function MegaMacroPopupOkayButton_OnClick()
	local index = 1
	if ( MegaMacroPopupFrame.mode == "new" ) then
		index = CreateMacro(MegaMacroPopupEditBox:GetText(), MegaMacroPopupFrame.selectedIcon, nil, 1);
	elseif ( MegaMacroPopupFrame.mode == "edit" ) then
		local id = MegaMacroFrame.selectedMacro;
		if ( not id ) then
			-- Hmm
		else
			local idName = GetMacroInfo(id);
			local newmacroName = MegaMacroPopupEditBox:GetText();
			if ( not MegaMacroText[newmacroName] ) then
				MegaMacroText[newmacroName] = MegaMacroText[idName];
			end
			MegaMacroText[idName] = nil;
		end
		index = EditMacro(MegaMacroFrame.selectedMacro, MegaMacroPopupEditBox:GetText(), MegaMacroPopupFrame.selectedIcon);
		
	end
	MegaMacroFrame_SelectMacro(index);
	MegaMacroPopupFrame:Hide();
	MegaMacroFrame_Update();
end

function MegaMacroFrame_EditMacro()
	if ( MegaMacroFrameText:IsVisible() ) then
		if ( MegaMacroFrame.textChanged ) then
			EditMacro(MegaMacroFrame.selectedMacro, nil, nil, MegaMacroFrameText:GetText(), 1);
			MegaMacroFrame.textChanged = nil;
		end
	end
end

function ToggleMegaMacroFrame()
	if ( MegaMacroFrame:IsVisible() ) then
		MegaMacroFrame:Hide();
	else
		MegaMacroFrame:Show();
	end
end