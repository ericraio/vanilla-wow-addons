local L = AceLibrary:GetInstance("AceLocale-2.0"):new("Clique")
local dewdrop = AceLibrary("Dewdrop-2.0")

local listSelected = 0          -- index of clickCasts selected (0 for none)
local maybeDoubleClick = nil    -- listSelected prior to an unselect, in case of a double-click (to edit)
local editSet
local tempButton, tempModifiers, tempTexture

function Clique:SpellBookFrame_OnShow()
    self.hooks[SpellBookFrame].OnShow.orig(SpellBookFrame)

    -- This darkens the background of the options UI to match the spellbook more closely
    CliqueBackdropLeft:SetVertexColor(.7,.7,.7,1)
    CliqueBackdropRight:SetVertexColor(.7,.7,.7,1)
    CliqueFrame:SetBackdropBorderColor(.5,.5,.5,1)

    editSet = self.db.char[L"DEFAULT_FRIENDLY"]
    Clique:ListScrollUpdate()

    local button
    for i=2,8 do
        button = getglobal("SpellBookSkillLineTab"..i)
        if not button:IsVisible() then
            CliquePulloutTab:ClearAllPoints()
            CliquePulloutTab:SetPoint("TOPLEFT","SpellBookSkillLineTab"..(i-1),"BOTTOMLEFT",0,-17)			
            break
        end
    end
end

function Clique:SpellButton_OnClick()
    if not CliqueFrame:IsVisible() then
        self.hooks[this].OnClick.orig(this)
    elseif CliqueEditFrame:IsVisible() then
        -- We're editing a custom spell at the moment
        return
    else
        local id = SpellBook_GetSpellID(this:GetID());
        local texture = GetSpellTexture(id, SpellBookFrame.bookType)
        local name, rank = GetSpellName(id, SpellBookFrame.bookType)
        local a,c,s = IsAltKeyDown() or 0, IsControlKeyDown() or 0, IsShiftKeyDown() or 0
        this:SetChecked(nil)
        
        if rank and string.find(rank, "Passive") then 
            StaticPopup_Show("CLIQUE_PASSIVE_SKILL")
            return
        end
        
        local modifiers = 0
        modifiers = 0
        modifiers = bit.bor(modifiers, a * 1)
        modifiers = bit.bor(modifiers, c * 2)
        modifiers = bit.bor(modifiers, s * 4)
                
        local t = {}
        t.button = arg1
        t.texture = texture
        t.modifiers = modifiers
        t.name = name

   		if self:CheckBinding(arg1, t.modifiers) then
			return
		end

        local _,_,numrank = string.find(rank, L"RANK" .. " (%d+)")
        t.rank = numrank
                    
        table.insert(editSet, t)
        Clique:ListScrollUpdate()
        Clique:BuildActionTable()
    end
end

StaticPopupDialogs["CLIQUE_AUTO_SELF_CAST"] = {
	text = "Clique will not work properly with Blizzard's AutoSelfCast.  Please disable it.",
	button1 = TEXT(OKAY),
	OnAccept = function()
	end,
	timeout = 0,
	hideOnEscape = 1
}


function Clique:CheckBinding(button, modifiers)
    for k,v in ipairs(editSet) do
        if modifiers == v.modifiers and button == v.button then
            self:Debug("Found an existing instance of %s and %d.", button, modifiers)
            StaticPopup_Show("CLIQUE_BINDING_PROBLEM")
			-- Stop the binding from happening
			return true
        end
    end
	-- Allow the new binding
    return nil
end

function Clique.ListScrollUpdate()
    local idx,button
    local offset = FauxScrollFrame_GetOffset(CliqueListScroll)
    local clickCasts = editSet

    FauxScrollFrame_Update(CliqueListScroll, table.getn(clickCasts), 6, 48 )

    Clique:SortList()
    CliqueListFrame:Show()
	
    for i=1,6 do
        idx = offset + i
        button = getglobal("CliqueList"..i)
        if idx<=table.getn(clickCasts) then
            Clique:FillListEntry("CliqueList"..i,idx)
            button:Show()
            if idx == listSelected then
                button.lockedHighlight = 1
                getglobal("CliqueList"..i.."Highlight"):Show()
            else
                button.lockedHighlight = nil
                getglobal("CliqueList"..i.."Highlight"):Hide()
            end
        else
            button:Hide()
        end
    end
    Clique:ValidateButtons()
end

function Clique.SortFunc(a,b)
    -- Calculate modifier score
    -- The more modifiers you have, the higher your score
    
    if a.name == b.name then
        if a.rank and b.rank then
            return a.rank < b.rank
        elseif a.action and b.action then 
            return a.action < b.action
        else 
            return a.modifiers < b.modifiers
        end
    else
        return a.name < b.name
    end
end

function Clique:SortList()
    table.sort(editSet, self.SortFunc)
end
                            
-- fills the members of the ClickListTemplate for button (string frame name) and ClickIdx index to clickCasts
function Clique:FillListEntry(button, clickIdx)
    local clickCasts = editSet[clickIdx]
    getglobal(button.."Icon"):SetTexture(clickCasts.texture or "Interface\\Icons\\INV_Gizmo_02")
    getglobal(button.."Name"):SetText(clickCasts.name or L"CUSTOM_SCRIPT")
    getglobal(button.."Rank"):SetText(clickCasts.rank and L"RANK" .. " " .. clickCasts.rank or "")
    getglobal(button.."Binding"):SetText(Clique:GetBindingText(clickIdx))
end

-- the tab attached to the spellbook that toggles the window
function Clique:Toggle()
    Clique:EditCancel()
    if CliqueFrame:IsVisible() then
        CliquePulloutTab:SetChecked(0)
        CliqueFrame:Hide()
        dewdrop:Close()        
    else
        CliquePulloutTab:SetChecked(1)
        CliqueFrame:Show()
        self:ValidateButtons()
    end
end

-- returns "Modifier+Modifier+Click" string for clickCasts index
function Clique:GetBindingText(clickIdx)
    local click = editSet[clickIdx]
    local alt = (bit.band(click.modifiers, 1) > 0) and "Alt+" or ""
    local control = (bit.band(click.modifiers, 2) > 0) and "Ctrl+" or ""
    local shift = (bit.band(click.modifiers, 4) > 0) and "Shift+" or ""
    return string.format("%s%s%s%s", alt,control,shift,click.button)
end

--[[ Grey button functions ]]

-- for both CliqueListFrame and CliqueEditFrame, turn buttons on and off
function Clique:ValidateButtons()
    if CliqueListFrame:IsVisible() then
        if listSelected==0 then
            CliqueButtonDelete:Disable()
            CliqueButtonEdit:Disable()
            CliqueButtonMax:Disable()
			Clique:SetTutorial("MAIN")
        else
			Clique:SetTutorial("SELECTED")
            CliqueButtonDelete:Enable()
            CliqueButtonEdit:Enable()
            if editSet[listSelected].rank then
                CliqueButtonMax:Enable()
            else
                CliqueButtonMax:Disable()
            end					
        end
    end
end

-- All the grey button clicks go through here
function Clique:ButtonOnClick(override)
    local source = override or this -- other parts of mod can call this, or the button itself did if not override

    if source==CliqueButtonOk then -- "Ok" : close list window
        CliqueFrame:Hide()
        CliquePulloutTab:SetChecked(0)
        dewdrop:Close()
    elseif source==CliqueButtonEdit then -- "Edit" : edit selected entry
        --Clique:FillListEntry("CliqueEditEntry",listSelected)
        tempButton = editSet[listSelected].button
        tempModifiers = editSet[listSelected].modifiers
        tempTexture = editSet[listSelected].texture
        
        CliqueEditBindingName:SetText(Clique:GetBindingText(listSelected))
        CliqueEditIconTexture:SetTexture(editSet[listSelected].texture or "Interface\\Icons\\INV_Gizmo_02")
        
        CliqueEditBox:SetText(editSet[listSelected].action)
        CliqueNameEditBox:SetText(editSet[listSelected].name)
		Clique:SetTutorial("EDIT")
        CliqueListFrame:Hide()
        CliqueEditFrame:Show()
        if editSet[listSelected].action then
            CliqueTextEditBox:Show()
            --CliqueNameEditBox:Show()
            --CliqueNameEditBox:EnableMouse(true)
            --CliqueNameEditBox:EnableKeyboard(true)
            CliqueNameEditBox.readOnly = false
            CliqueFocusGrabber:Show()
        else
            CliqueTextEditBox:Hide()
            --CliqueNameEditBox:Hide()
            --CliqueNameEditBox:EnableMouse(nil)
            --CliqueNameEditBox:EnableKeyboard(nil)
            CliqueNameEditBox.readOnly = true
            CliqueFocusGrabber:Hide()
        end
    elseif source==CliqueButtonDelete then -- "Delete" : remove entry from Clique.clickCasts
        table.remove(editSet,listSelected)
        listSelected = math.min(listSelected,table.getn(editSet))
        Clique:ListScrollUpdate()
        Clique:BuildActionTable()
    elseif source==CliqueButtonNew then -- "New" : add a new entry and go edit it
        table.insert(editSet,{name="Custom",button=L"BINDING_NOT_DEFINED",modifiers=0,action="",custom=true})
        listSelected = table.getn(editSet)
        Clique:ButtonOnClick(CliqueButtonEdit)
    elseif source==CliqueButtonSave then -- "Save" : Save editbox to Clique.clickCasts[x].action and go back to list
        if CliqueEditBox:IsVisible() then
            editSet[listSelected].action = CliqueEditBox:GetText()
        end
        editSet[listSelected].name = CliqueNameEditBox:GetText()
            -- Close the icon select frame either way

        Clique:EditCancel() -- go back to CliqueListFrame
        Clique:BuildActionTable()
        listSelected = 0
        dewdrop:Close()
		Clique:SetTutorial("SELECTED")
    elseif source==CliqueButtonCancel then -- "Cancel" : Abort changes and go back to list
        if CliqueIconSelectFrame:IsVisible() then
            CliqueIconSelectFrame:Hide()
            return
        end
        
        if CliqueEditFrame:IsVisible() then
            local entry = editSet[listSelected]
            if entry then
                if entry.custom and not entry.texture and entry.name == "Custom" and entry.button == L"BINDING_NOT_DEFINED" and entry.action == "" then
                    table.remove(editSet, listSelected)
                    listSelected = 0
                end
                if tempButton and entry.button ~= tempButton then
                    entry.button = tempButton
                end
                if tempModifiers and entry.modifiers ~= tempModifiers then
                    entry.modifiers = tempModifiers
                end
                if tempTexture and entry.texture ~= tempTexture then
                    entry.texture = tempTexture
                end
            end
        end
                
        Clique:EditCancel()
        dewdrop:Close()
		Clique:SetTutorial("SELECTED")
    elseif source==CliqueButtonMax then -- "Max Rank" : Remove rank value from table
        local click = editSet[listSelected]
        click.rank = nil
        --Clique:FillListEntry("CliqueEditEntry",listSelected)
        self:ListScrollUpdate()
        Clique:BuildActionTable()
	elseif source==CliqueButtonHelp then
		if CliqueTutorial:IsVisible() then
			CliqueTutorial:Hide()
		else 
			CliqueTutorial:Show()
		end
    end
    Clique:ValidateButtons()
end

--[[ CliqueListFrame functions (note most of work done in Clique.ButtonOnClick) ]]
-- the central list update function: shows help if needed, highlights, validates buttons, etc.  Call anytime clickCasts changes
-- when a list entry on ClickListFrame is clicked: select or unselect entry
function Clique:ListOnClick()
    local idx = FauxScrollFrame_GetOffset(CliqueListScroll) + this:GetID()
    maybeDoubleClick = idx
    listSelected = (listSelected==idx) and 0 or idx
    Clique:ListScrollUpdate()
end

-- when a list entry on ClickListFrame is double clicked: edit entry irregardless of selection
function Clique:ListOnDoubleClick()
    if maybeDoubleClick then
        listSelected = maybeDoubleClick
        Clique:ButtonOnClick(CliqueButtonEdit)
    end
end

--[[ CliqueEditFrame functions (note most of work done in Clique.ButtonOnClick) ]]
-- go from ClickEditFrame to ClickListFrame
function Clique:EditCancel()
    CliqueEditFrame:Hide()
    CliqueListFrame:Show()
    listSelected = 0
    Clique:ListScrollUpdate()
    CliqueIconSelectFrame:Hide()
end

-- updates key binding from when the user does a click combo on the entry above the edit box
function Clique:EditSelectedBinding()
    local click = editSet[listSelected]
    a = IsAltKeyDown() or 0
    s = IsShiftKeyDown() or 0 
    c = IsControlKeyDown() or 0 

    local modifiers = 0
    modifiers = bit.bor(modifiers, a * 1)
    modifiers = bit.bor(modifiers, c * 2)
    modifiers = bit.bor(modifiers, s * 4)

    if self:CheckBinding(arg1, modifiers) then
        return
    end
    
    click.button = arg1
    click.modifiers = modifiers

    CliqueEditBindingName:SetText(Clique:GetBindingText(listSelected))
    Clique:BuildActionTable()
end

function Clique:DropDown_OnShow()
    self.work = self:ClearTable(self.work)
    for k,v in pairs(self.db.char) do
        table.insert(self.work, k)
    end
    table.sort(self.work)

    UIDropDownMenu_Initialize(this, Clique.DropDown_Initialize);
    UIDropDownMenu_SetSelectedValue(CliqueDropDown, editSet)
	Clique:ListScrollUpdate()
end

function Clique.DropDown_Initialize()
    local info = {}

    for k,v in ipairs(Clique.work) do
        info = {};
        info.text = v;
        info.value = Clique.db.char[v];
        info.func = Clique.DropDown_OnClick;
        UIDropDownMenu_AddButton(info);
   end
end

function Clique.DropDown_OnClick()
    UIDropDownMenu_SetSelectedValue(CliqueDropDown, this.value);
    editSet = this.value
    listSelected = 0
    Clique:ListScrollUpdate()
end

function Clique:EnableTooltips()
    -- Set Dropdown selection
    self:SetTooltip(CliqueDropDown, L"TT_DROPDOWN")
--[[
    self:SetTooltip(CliqueList1, L"TT_LIST_ENTRY")
    self:SetTooltip(CliqueList2, L"TT_LIST_ENTRY")
    self:SetTooltip(CliqueList3, L"TT_LIST_ENTRY")
    self:SetTooltip(CliqueList4, L"TT_LIST_ENTRY")
    self:SetTooltip(CliqueList5, L"TT_LIST_ENTRY")
    self:SetTooltip(CliqueList6, L"TT_LIST_ENTRY")
--]]
    self:SetTooltip(CliqueButtonDelete, L"TT_DEL_BUTTON")
    self:SetTooltip(CliqueButtonMax, L"TT_MAX_BUTTON")
    self:SetTooltip(CliqueButtonNew, L"TT_NEW_BUTTON")
    self:SetTooltip(CliqueButtonEdit, L"TT_EDIT_BUTTON")
    self:SetTooltip(CliqueButtonOk, L"TT_OK_BUTTON")
    --self:SetTooltip(CliqueEditEntry, L"TT_EDIT_BINDING")

    --self:SetTooltip(CliqueNameEditBox, L"TT_NAME_EDITBOX")
    self:SetTooltip(CliqueButtonSave, L"TT_SAVE_BUTTON")
    self:SetTooltip(CliqueButtonCancel, L"TT_CANCEL_BUTTON")
    self:SetTooltip(CliqueTextEditBox, L"TT_TEXT_EDITBOX")
    self:SetTooltip(CliquePulloutTab, L"TT_PULLOUT_TAB")
end
    
function Clique:SetTutorial(screen)
	local message = ""
	
	if screen == "MAIN" then
		message = "Using Clique is very simple.  Find a spell in the spellbook to the left, and then click on it.  When clicking you can hold any number of modifiers (Alt, Control and Shift) and you can use any button on your mouse (Left, Right, Middle, Button4 and Button5.)  This will add a spell to the list above.\n\nYou can also use the \"New\" button to add a custom lua script."
	elseif screen == "SELECTED" then
		message = "You have selected a spell or custom script.  If this is a spell (from the spellbook) and you'd like to always cast the highest rank, click the \"Max\" button.\n\nYou can also use the \"Edit\" button to change the binding of a spell, or the name/lua code of a custom script."
	elseif screen == "EDIT" then
		message = "You are in the edit screen.  You can re-bind this cast by clicking the button above.  In custom scripts, you can use Clique.unit to refer to the unit we're clicking on.\n\nYou may also right-click in the edit box to pop up a list of custom functions that are available to you.  See the documentation for more details."
	end

	CliqueTutorialText:SetText(message)
end

function Clique:UpdateIconFrame()
    local MAX_MACROS = 18;
    local NUM_MACRO_ICONS_SHOWN = 20;
    local NUM_ICONS_PER_ROW = 5;
    local NUM_ICON_ROWS = 4;
    local MACRO_ICON_ROW_HEIGHT = 36;
    local macroPopupOffset = FauxScrollFrame_GetOffset(CliqueIconScrollFrame);
    local numMacroIcons = GetNumMacroIcons();

    -- Icon list
    for i=1, NUM_MACRO_ICONS_SHOWN do
        macroPopupIcon = getglobal("CliqueIcon"..i.."Icon");
        macroPopupButton = getglobal("CliqueIcon"..i);
        
        if not macroPopupButton.icon then
            macroPopupButton.icon = macroPopupIcon
        end
        
        index = (macroPopupOffset * NUM_ICONS_PER_ROW) + i;
        if ( index <= numMacroIcons ) then
            macroPopupIcon:SetTexture(GetMacroIconInfo(index));
            macroPopupButton:Show();
        else
            macroPopupIcon:SetTexture("");
            macroPopupButton:Hide();
        end
        macroPopupButton:SetChecked(nil);
    end
    
    FauxScrollFrame_Update(CliqueIconScrollFrame, ceil(numMacroIcons / NUM_ICONS_PER_ROW) , NUM_ICON_ROWS, MACRO_ICON_ROW_HEIGHT );
end

function Clique:SetSpellIcon(texture)
    editSet[listSelected].texture = texture
    CliqueEditIconTexture:SetTexture(texture)
end    

function Clique:ClickSpellIcon()
    Clique:SetSpellIcon(this.icon:GetTexture())
    CliqueIconSelectFrame:Hide()
    if editSet[listSelected].custom then
        CliqueTextEditBox:Show()
    end
end

--[[---------------------------------------------------------------------------------
  Handle the function dropdown, with registrations
----------------------------------------------------------------------------------]]

local function InsertEditBox(text)
    CliqueEditBox:Insert(text.."\n")
end

function Clique:RegisterCustomFunction(code, display, tooltip)
    if not code or type(code) ~= "string" then 
        error("Bad argument #1 to 'RegisterCustomFunction', (string expected got " .. type(code) .. ")")
    end
    if not display or type(display) ~= "string" then 
        error("Bad argument #2 to 'RegisterCustomFunction', (string expected got " .. type(display) .. ")")
    end
    if not tooltip or type(tooltip) ~= "string" then 
        error("Bad argument #3 to 'RegisterCustomFunction', (string expected got " .. type(tooltip) .. ")")
    end

    -- Create the table if it doesn't exist
    if not self.CustomFunctions then self.CustomFunctions = {} end
    
    local t = {["code"] = code, ["display"] = display, ["tooltip"] = tooltip}
    table.insert(self.CustomFunctions, t)
end

local function DewDropMenu()
       dewdrop:AddLine(
           'text', "Custom Functions",
           'isTitle', true)

    for k,v in ipairs(Clique.CustomFunctions) do  
        Clique:LevelDebug(2, "Adding Custom Function %s", v.display)
       dewdrop:AddLine(
           'text', v.display,
           'closeWhenClicked', true,
           'arg1', v.code,
           'func', InsertEditBox,
           'tooltipText', v.tooltip)
    end
end

function Clique:DropMenu(frame)    
    dewdrop:Open(frame, 'children', DewDropMenu, 'cursorX', true, 'cursorY', true)
end

StaticPopupDialogs["CLIQUE_PASSIVE_SKILL"] = {
	text = "You can't bind a passive skill.",
	button1 = TEXT(OKAY),
	OnAccept = function()
	end,
	timeout = 0,
	hideOnEscape = 1
}

StaticPopupDialogs["CLIQUE_BINDING_PROBLEM"] = {
	text = "That combination is already bound.  Delete the old one before trying to re-bind.",
	button1 = TEXT(OKAY),
	OnAccept = function()
	end,
	timeout = 0,
	hideOnEscape = 1
};

StaticPopupDialogs["CLIQUE_AUTOSELFCAST"] = {
	text = "Clique will not work properly if Blizzard's AutoSelfCast is enabled.  Please disable it under the Interface Options.",
	button1 = TEXT(OKAY),
	OnAccept = function()
	end,
	timeout = 0,
	hideOnEscape = 1
};
