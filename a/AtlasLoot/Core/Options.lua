--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------
function AtlasLootOptions_Init()
    --Initialise all the check boxes on the options frame
	AtlasLootOptionsFrameSafeLinks:SetChecked(AtlasLootOptions.SafeLinks);
	AtlasLootOptionsFrameAllLinks:SetChecked(AtlasLootOptions.AllLinks);
	AtlasLootOptionsFrameDefaultTT:SetChecked(AtlasLootOptions.DefaultTT);
	AtlasLootOptionsFrameLootlinkTT:SetChecked(AtlasLootOptions.LootlinkTT);
	AtlasLootOptionsFrameItemSyncTT:SetChecked(AtlasLootOptions.ItemSyncTT);
    AtlasLootOptionsFrameEquipCompare:SetChecked(AtlasLootOptions.EquipCompare);
end

function AtlasLootOptions_OnLoad()
    --Disable checkboxes of missing addons
    if( not LootLink_SetTooltip ) then
        AtlasLootOptionsFrameLootlinkTT:Disable();
        AtlasLootOptionsFrameLootlinkTTText:SetText(ATLASLOOT_OPTIONS_LOOTLINK_TOOLTIPS_DISABLED);
    end
    if( not ISYNC_VERSION ) then
        AtlasLootOptionsFrameItemSyncTT:Disable();
        AtlasLootOptionsFrameItemSyncTTText:SetText(ATLASLOOT_OPTIONS_ITEMSYNC_TOOLTIPS_DISABLED);
    end
    if( not EquipCompare_RegisterTooltip ) then
        AtlasLootOptionsFrameEquipCompare:Disable();
        AtlasLootOptionsFrameEquipCompareText:SetText(ATLASLOOT_OPTIONS_EQUIPCOMPARE_DISABLED);
    end
    AtlasLootOptions_Init();
    temp=AtlasLootOptions.SafeLinks;
    UIPanelWindows['AtlasLootOptionsFrame'] = {area = 'center', pushable = 0};
end

--Functions for toggling options check boxes.
function AtlasLootOptions_SafeLinksToggle()
	if(AtlasLootOptions.SafeLinks) then
		AtlasLootOptions.SafeLinks = false;
	else
		AtlasLootOptions.SafeLinks = true;
        AtlasLootOptions.AllLinks = false;
	end
	AtlasLootOptions_Init();
end

function AtlasLootOptions_AllLinksToggle()
	if(AtlasLootOptions.AllLinks) then
		AtlasLootOptions.AllLinks = false;
	else
		AtlasLootOptions.AllLinks = true;
        AtlasLootOptions.SafeLinks = false;
	end
	AtlasLootOptions_Init();
end

function AtlasLootOptions_DefaultTTToggle()
	AtlasLootOptions.DefaultTT = true;
    AtlasLootOptions.LootlinkTT = false;
    AtlasLootOptions.ItemSyncTT = false;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_LootlinkTTToggle()
	AtlasLootOptions.DefaultTT = false;
    AtlasLootOptions.LootlinkTT = true;
    AtlasLootOptions.ItemSyncTT = false;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_ItemSyncTTToggle()
    AtlasLootOptions.DefaultTT = false;
    AtlasLootOptions.LootlinkTT = false;
    AtlasLootOptions.ItemSyncTT = true;
	AtlasLootOptions_Init();
end

function AtlasLootOptions_EquipCompareToggle()
    if(AtlasLootOptions.EquipCompare) then
        AtlasLootOptions.EquipCompare = false;
        EquipCompare_UnregisterTooltip(AtlasLootTooltip);
    else
        AtlasLootOptions.EquipCompare = true;
        EquipCompare_RegisterTooltip(AtlasLootTooltip);
    end
	AtlasLootOptions_Init();
end
