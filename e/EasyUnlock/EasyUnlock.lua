-- Globals used for the TRADE_TARGET_ITEM_CHANGED workaround
EU_GetItemInfoReq = false;
EU_UpdateCount = 0;
EU_UpdateCountLimit = 15; -- Max number of OnUpdate cycles to check for an item

-- Compatibility with Link Wrangler 1.39
function EasyUnlock_LinkWranglerCallback(frame, link)
    local itemName = GetItemInfo(link);
    EasyUnlock_AddTooltipInfo(frame, itemName); 
end

function EasyUnlock_OnLoad()
    -- Register events
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
    this:RegisterEvent("LEARNED_SPELL_IN_TAB");
    this:RegisterEvent("TRADE_SHOW");
    this:RegisterEvent("UI_ERROR_MESSAGE");
end

function EasyUnlock_OnUpdate(dt)
    -- Button-does-not-always-enable-hack
    if(EU_GetItemInfoReq) then
        -- Check if the slot contains an item known to be a lockbox
        local itemname, _, _, _, _, enchantment = GetTradeTargetItemInfo(7);
        if(itemname) then
            EU_GetItemInfoReq = false;
            EU_UpdateCount = 0;
        else
            EU_UpdateCount = EU_UpdateCount + 1;
        end
        
        if(EU_LOCKBOXES[itemname] and not enchantment) then
            EasyUnlockUnlockButton:Enable();
        else
            EasyUnlockUnlockButton:Disable();
        end

        -- Check if we haven't exceeded the checklimit
        if(EU_UpdateCount > EU_UpdateCountLimit) then
            EU_GetItemInfoReq = false;
            EU_UpdateCount = 0;
        end
    end
end

function EasyUnlock_Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 1, 0);
end

function EasyUnlock_DoFrameCheck()
    local _, class = UnitClass("player");
    if(class == "ROGUE" and EasyUnlock_GetLockpickingLevel() and not EasyUnlock:IsShown()) then     
        -- Unhide frame
        EasyUnlock:Show();
        
        -- Squeeze the 'trade' and 'cancel' buttons in TradeFrame so we can fit in our own button
        TradeFrameTradeButton:SetWidth(56);
        TradeFrameCancelButton:SetWidth(56);

        -- Fix the 'trade' button position
        TradeFrameTradeButton:SetPoint("BOTTOMRIGHT","TradeFrame","BOTTOMRIGHT",-141,55);

        -- Change the anchor of the cancel button so it's positioned relative to our 'unlock' button
        TradeFrameCancelButton:SetPoint("TOPLEFT","EasyUnlockUnlockButton","TOPRIGHT",-3,0);
    end
end

function EasyUnlock_OnEvent(event)
    if(event == "VARIABLES_LOADED") then
        if(IsAddOnLoaded("LinkWrangler")) then
            if(LINK_WRANGLER_CALLER == nil) then
                EasyUnlock_Print(EA_COMPAT_LW_UNSUPPORTED);
            else
                LINK_WRANGLER_CALLER['EasyUnlock'] = "EasyUnlock_LinkWranglerCallback";
            end
        end
    elseif(event == "TRADE_TARGET_ITEM_CHANGED" and arg1 == 7) then
        local itemname, _, _, _, _, enchantment = GetTradeTargetItemInfo(arg1);
        EU_GetItemInfoReq = true; -- Sometimes GetTradeTargetItemInfo returns nil although an update event has been triggered -> Try to get iteminfo for X OnUpdate iterations
    elseif(event == "LEARNED_SPELL_IN_TAB" and arg1 == 1) then
        EasyUnlock_DoFrameCheck();
    elseif(event == "TRADE_SHOW") then -- Seems to bug if frames are modified OnLoad
        EasyUnlock_DoFrameCheck();
        EasyUnlockUnlockButton:Disable();
    elseif(event == "UI_ERROR_MESSAGE" and arg1 == SPELL_FAILED_NOT_MOUNTED and TradeFrame:IsShown()) then
        -- Assume player clicked the unlock button
        EasyUnlockUnlockButton:Enable();
        EU_GetItemInfoReq = false;
    end
end

function EasyUnlockUnlockButton_OnClick()
    -- Disable the button
    EasyUnlockUnlockButton:Disable();

    -- Get the itemname
    local itemname = GetTradeTargetItemInfo(7);
    
    if(not itemname) then return end
    
    -- Get our lockpicking level    
    local lockpickinglevel = EasyUnlock_GetLockpickingLevel();
    
    -- Can we open this box?
    if(lockpickinglevel >= EU_LOCKBOXES[itemname]) then
        -- We can open the box, so let's do that
        CastSpellByName(EU_PICKLOCK_ABILITY);
        ClickTargetTradeButton(7);
    else
        -- Can't open this box, send the receipent a whisper
        local boxlink = GetTradeTargetItemLink(7);
        local boxlevel = EU_LOCKBOXES[itemname];
        local msg = format(EU_TOO_LOW_LOCKPICKING,boxlink,lockpickinglevel,boxlevel);
        SendChatMessage(msg,"WHISPER",nil,UnitName("NPC"));
    end
end

function EasyUnlock_GetLockpickingLevel()
    local numskills = GetNumSkillLines();
    for i=1,numskills do
        local skillname, _, _, skillrank = GetSkillLineInfo(i);
        if(skillname == EU_SKILLTAB_LOCKPICKING) then
            return skillrank;
        end     
    end
    -- Return 0 if no lockpicking level has been found
    return 0;  
end

-- Checks whether a box is locked
function EasyUnlock_IsBoxLocked()
    for i = 1, GameTooltip:NumLines() do
        local tooltipline = getglobal("GameTooltipTextLeft"..i);
        if(tooltipline and tooltipline:GetText() == EU_TOOLTIP_LOCKED) then return true; end
    end
    return false;
end

-- This function will point to the original OnClick
local EasyUnlock_OldItemButton_OnClick = ContainerFrameItemButton_OnClick;

function EasyUnlock_ItemButton_OnClick(button, ignoreShift)
    local callold = true;
    local itemLink = GetContainerItemLink(this:GetParent():GetID(), this:GetID());
    if(button == "RightButton" and not (IsControlKeyDown() or IsShiftKeyDown() or IsAltKeyDown()) and itemLink) then
        _, _, itemLink = string.find(itemLink, "(item:%d+:%d+:%d+:%d+)");
        local itemName = GetItemInfo(itemLink);
        if(EU_LOCKBOXES[itemName]) then
            if(EasyUnlock_GetLockpickingLevel() >= EU_LOCKBOXES[itemName] and EasyUnlock_IsBoxLocked()) then
                CastSpellByName(EU_PICKLOCK_ABILITY);
                PickupContainerItem(this:GetParent():GetID(), this:GetID());
                callold = false;
            end
        end
    end
    if(callold) then EasyUnlock_OldItemButton_OnClick(button, ignoreShift); end
end

-- And this one hooks us
ContainerFrameItemButton_OnClick = EasyUnlock_ItemButton_OnClick;

--
--  Tooltip stuff
--
function EasyUnlock_AddTooltipInfo(frame, itemname)
    if(EU_LOCKBOXES[itemname]) then
        local levelreq;
        if(EU_LOCKBOXES[itemname] == 0) then
            levelreq = "?";
        else
            levelreq = EU_LOCKBOXES[itemname];
        end
        local lockpickinglvl = EasyUnlock_GetLockpickingLevel();
        if(levelreq == "?") then
            -- Requirement unknown
            local reqmsg = format(ITEM_REQ_SKILL, EU_SKILLTAB_LOCKPICKING.." ("..levelreq..")");
            frame:AddLine(reqmsg,1,0.5,0);
        elseif(levelreq <= lockpickinglvl) then
            -- Lockpicking level is high enough
            local reqmsg = format(ITEM_REQ_SKILL, EU_SKILLTAB_LOCKPICKING.." ("..levelreq..")");
            frame:AddLine(reqmsg,0,1,0);
        else
            -- Lockpicking level is NOT high enough
            local reqmsg = format(ITEM_REQ_SKILL, EU_SKILLTAB_LOCKPICKING.." ("..levelreq..")");
            frame:AddLine(reqmsg,1,0,0);
        end
        -- Resize
        frame:SetHeight(frame:GetHeight() + 14);
        frame:SetWidth(190);
    end
end

function EasyUnlock_Tooltip_OnShow()
    local parentFrame = this:GetParent();
    local parentFrameName = parentFrame:GetName();
    local itemName = getglobal(parentFrameName.."TextLeft1"):GetText()
    EasyUnlock_AddTooltipInfo(parentFrame, itemName);
end