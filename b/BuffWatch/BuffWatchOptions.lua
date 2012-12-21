BW_TTIP_SORTORDER = "Specifies the sort order for the player list in the BuffWatch Window"
BW_TTIP_SHOWONSTARTUP = "Show the BuffWatch window on startup"
BW_TTIP_SHOWPETS = "Show pets in the player list"
BW_TTIP_SHOWCASTABLEBUFFS = "Only show buffs you can cast"
BW_TTIP_SHOWDEBUFFS = "Show debuffs"
BW_TTIP_SHOWDISPELLDEBUFFS = "Only show debuffs you can dispell"
BW_TTIP_DEBUFFSALWAYSVISIBLE = "Always show players with debuffs"
BW_TTIP_ALIGNBUFFS = "Align buff icons for all players"
BW_TTIP_SHOWEXPIREDWARNING = "Shows a warning if buffs have started to expire"
BW_TTIP_PLAYEXPIREDSOUND = "Plays a sound if buffs have started to expire"
BW_TTIP_HIGHLIGHTPVP = "Highlight players that are PvP Flagged"
BW_TTIP_PREVENTPVPBUFF = "Prevent BuffWatch from buffing players that are PvP Flagged"
BW_TTIP_BUFFTHRESHOLD = "Number of players missing the buff for it to cast group version"
BW_TTIP_ALPHA = "Sets the transparency of the BuffWatch window"
BW_TTIP_UPDPERSEC = "Maximum number of updates per second to refresh buffs"
BW_TTIP_SHOWUPDPERSEC = "Show updates per second counter"

function BW_Options_OnLoad()

    -- Add BW_Options to the UIPanelWindows list
    UIPanelWindows["BW_Options"] = {area = "center", pushable = 0}

end

function BW_Options_Init()
    BW_Options_ShowOnStartup:SetChecked(BuffWatchConfig.show_on_startup)
    BW_Options_ShowPets:SetChecked(BuffWatchConfig.ShowPets)
    BW_Options_ShowOnlyCastableBuffs:SetChecked(BuffWatchConfig.ShowCastableBuffs)
    BW_Options_ShowDebuffs:SetChecked(BuffWatchConfig.ShowDebuffs)
    BW_Options_ShowOnlyDispellDebuffs:SetChecked(BuffWatchConfig.ShowDispellableDebuffs)
    BW_Options_DebuffsAlwaysVisible:SetChecked(BuffWatchConfig.DebuffsAlwaysVisible)
    BW_Options_AlignBuffs:SetChecked(BuffWatchConfig.AlignBuffs)
    BW_Options_ShowExpiredWarning:SetChecked(BuffWatchConfig.ExpiredWarning)
    BW_Options_PlayExpiredSound:SetChecked(BuffWatchConfig.ExpiredSound)    
    BW_Options_HighlightPvP:SetChecked(BuffWatchConfig.HighlightPvP)
    BW_Options_PreventPvPBuff:SetChecked(BuffWatchConfig.PreventPvPBuff)
    BW_Options_BuffThreshold:SetValue(BuffWatchConfig.BuffThreshold)
    BW_Options_Alpha:SetValue(BuffWatchConfig.alpha)
    BW_Options_UpdPerSec:SetValue(BuffWatchConfig.UpdPerSec)
    BW_Options_ShowUpdPerSec:SetChecked(BuffWatchConfig.ShowUpdPerSec)
    if BuffWatchConfig.ShowUpdPerSec == true then
        BW_UPS:Show()
    else
        BW_UPS:Hide()
    end        
end

function BW_Options_SortOrder_OnClick()
    i = this:GetID()
    UIDropDownMenu_SetSelectedID(BW_Options_SortOrder, i)
    BuffWatchConfig.SortOrder = BW_SORTORDER_DROPDOWN_LIST[i]
    BW_GetAllBuffs()
    BW_UpdateBuffStatus(true)
    BW_ResizeWindow()
end

function BW_Options_SortOrder_Initialize()
    local info
    for i = 1, getn(BW_SORTORDER_DROPDOWN_LIST) do
        info = {
            text = BW_SORTORDER_DROPDOWN_LIST[i],
            func = BW_Options_SortOrder_OnClick
        }
        UIDropDownMenu_AddButton(info)
    end
end

function BW_Options_SortOrder_OnLoad()
    UIDropDownMenu_Initialize(this, BW_Options_SortOrder_Initialize)
    UIDropDownMenu_SetText(BuffWatchConfig.SortOrder, this)
    UIDropDownMenu_SetWidth(90, BW_Options_SortOrder)
end

function BW_Options_HighlightPvP_Clicked()
    BW_ColourAllNames()
end