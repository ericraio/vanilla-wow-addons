CT_RATab_AutoPromotions = { };

function CT_RATab_newRaidFrameDropDown_Initialize()
	UnitPopup_ShowMenu(getglobal(UIDROPDOWNMENU_OPEN_MENU), "RAID", this.unit, this.name, this.id);
	local info = {};
	info.text = "Auto-Promote";
	info.tooltipTitle = "Auto-Promote";
	info.tooltipText = "When checked, this player is automatically promoted when he or she joins the raid.";
	info.checked = CT_RATab_AutoPromotions[this.name];
	info.value = this.id;
	info.func = CT_RATab_AutoPromote_OnClick;
	UIDropDownMenu_AddButton(info);
end

function CT_RATab_AutoPromote_OnClick()
	local name, rank = GetRaidRosterInfo(this.value);
	CT_RATab_AutoPromotions[name] = not CT_RATab_AutoPromotions[name];
	if ( CT_RA_Level and CT_RA_Level >= 2 and CT_RATab_AutoPromotions[name] and rank < 1 ) then
		PromoteToAssistant(name);
		CT_RA_Print("<CTRaid> Auto-Promoted |c00FFFFFF" .. name .. "|r.", 1, 0.5, 0);
	end
end

function CT_RATab_LoadDropDown()
	UIDropDownMenu_Initialize(this, CT_RATab_InitializeDropDown);
	UIDropDownMenu_SetWidth(135);
end

function CT_RATab_InitializeDropDown()
	local info = { };
	info.text = LOOT_FREE_FOR_ALL;
	info.value = "freeforall";
	info.tooltipTitle = LOOT_FREE_FOR_ALL;
	info.tooltipText = "Set the default loot type to Free for All, which will make CT_RaidAssist automatically set your loot type to the selected option upon creating a raid.";
	info.func = CT_RATab_ClickDropDown;
	UIDropDownMenu_AddButton(info);
	
	info = { };
	info.text = LOOT_ROUND_ROBIN;
	info.value = "roundrobin";
	info.tooltipTitle = LOOT_ROUND_ROBIN;
	info.tooltipText = "Set the default loot type to Round Robin, which will make CT_RaidAssist automatically set your loot type to the selected option upon creating a raid.";
	info.func = CT_RATab_ClickDropDown;
	UIDropDownMenu_AddButton(info);
	
	info = { };
	info.text = LOOT_MASTER_LOOTER;
	info.value = "master";
	info.tooltipTitle = LOOT_MASTER_LOOTER;
	info.tooltipText = "Set the default loot type to Master Looter, which will make CT_RaidAssist automatically set your loot type to the selected option upon creating a raid.";
	info.func = CT_RATab_ClickDropDown;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = LOOT_GROUP_LOOT;
	info.value = "group";
	info.tooltipTitle = LOOT_GROUP_LOOT;
	info.tooltipText = "Set the default loot type to Group Loot, which will make CT_RaidAssist automatically set your loot type to the selected option upon creating a raid.";
	info.func = CT_RATab_ClickDropDown;
	UIDropDownMenu_AddButton(info);
	
	info = { };
	info.text = LOOT_NEED_BEFORE_GREED;
	info.value = "needbeforegreed";
	info.tooltipTitle = LOOT_NEED_BEFORE_GREED;
	info.tooltipText = "Set the default loot type to Need Before Greed, which will make CT_RaidAssist automatically set your loot type to the selected option upon creating a raid.";
	info.func = CT_RATab_ClickDropDown;
	UIDropDownMenu_AddButton(info);
end

function CT_RATab_ClickDropDown()
	CT_RATab_SetDropDownID(this:GetID());
	CT_RATab_DefaultLootMethod = this:GetID();
	if ( CT_RA_Level >= 2 and GetNumRaidMembers() > 0 ) then
		if ( this.value == "master" ) then
			SetLootMethod("master", UnitName("player"));
		else
			SetLootMethod(this.value);
		end
	end
end

function CT_RATab_SetDropDownID(id)
	UIDropDownMenu_SetSelectedID(CT_RATabLootDropDown, id);
	if ( id == 1 ) then
		CT_RATabLootDropDownText:SetText(LOOT_FREE_FOR_ALL);
	elseif ( id == 2 ) then
		CT_RATabLootDropDownText:SetText(LOOT_ROUND_ROBIN);
	elseif ( id == 3 ) then
		CT_RATabLootDropDownText:SetText(LOOT_MASTER_LOOTER);
	elseif ( id == 4 ) then
		CT_RATabLootDropDownText:SetText(LOOT_GROUP_LOOT);
	elseif ( id == 5 ) then
		CT_RATabLootDropDownText:SetText(LOOT_NEED_BEFORE_GREED);
	end
end