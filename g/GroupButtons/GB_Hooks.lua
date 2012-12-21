function GB_Hook_Functions()
--	HOOK FUNCTIONS FOR PICKING UP STUFF
	GB_Old_SpellButton_OnClick = SpellButton_OnClick;
	SpellButton_OnClick = GB_SpellButton_OnClick;
	GB_Old_ContainerFrameItemButton_OnClick = ContainerFrameItemButton_OnClick;
	ContainerFrameItemButton_OnClick = GB_ContainerFrame_OnClick;
	GB_Old_PaperDollItemSlotButton_OnClick = PaperDollItemSlotButton_OnClick;
	PaperDollItemSlotButton_OnClick = GB_PaperDollItemSlotButton_OnClick;
	GB_Old_PickupMacro = PickupMacro;
	PickupMacro = GB_PickupMacro;

-- 	FOR COSMOS COMPATIBILITY  (uuuugh :P)
	GB_Old_TotemStomper_WatchSpellbook = TotemStomper_WatchSpellbook;
	TotemStomper_WatchSpellbook = GB_TotemStomper_WatchSpellbook;

--	MYINVENTORY COMPATIBILITY
	GB_Old_MyInventoryFrameItemButton_OnClick = MyInventoryFrameItemButton_OnClick;
	MyInventoryFrameItemButton_OnClick = GB_MyInventoryFrameItemButton_OnClick;

--	ALL IN ONE INVENTORY COMPATIBILITY
	GB_Old_AllInOneInventoryFrameItemButton_OnClick = AllInOneInventoryFrameItemButton_OnClick;
	AllInOneInventoryFrameItemButton_OnClick = GB_AllInOneInventoryFrameItemButton_OnClick;

--	TO UPDATE MACROS WHEN YOU ADD NEW ONES
	GB_Old_MacroFrame_Update = MacroFrame_Update;
	MacroFrame_Update = GB_MacroFrame_Update;

--  Click-casting for the default raid frames
--	GB_Old_RaidPulloutButton_OnClick = RaidPulloutButton_OnClick;
--	RaidPulloutButton_OnClick = GB_RaidPulloutButton_OnClick;

--	Click-casting and mouseovers for CTRA frames
	GB_Old_CT_RA_MemberFrame_OnClick = CT_RA_MemberFrame_OnClick;
	CT_RA_MemberFrame_OnClick = GB_CT_RA_MemberFrame_OnClick;
	GB_Old_CT_RA_MemberFrame_OnEnter = CT_RA_MemberFrame_OnEnter;
	CT_RA_MemberFrame_OnEnter = GB_CT_RA_MemberFrame_OnEnter;
	GB_Old_CT_RA_MemberFrame_OnLeave = CT_RA_MemberFrame_OnLeave;
	CT_RA_MemberFrame_OnLeave = GB_CT_RA_MemberFrame_OnLeave;

--	Support for Perl's Raid Frames, probably doesn't work, Perl's not built for click-casting
	GB_Old_Perl_Raid_MouseUp = Perl_Raid_MouseUp;
	GB_Perl_Raid_MouseUp = Perl_Raid_MouseUp;

--	Support for beyondRaid frames
	GB_Old_beyondRaidUnitOnClick = beyondRaidUnitOnClick;
	beyondRaidUnitOnClick = GB_beyondRaidUnitOnClick;

--	Support for Mars Raid
	GB_Old_MarsRaidFrame_OnClick = MarsRaidFrame_OnClick;
	MarsRaidFrame_OnClick = GB_MarsRaidFrame_OnClick;
	GB_Old_MarsRaidFrame_OnEnter = MarsRaidFrame_OnEnter;
	MarsRaidFrame_OnEnter = GB_MarsRaidFrame_OnEnter;
	GB_Old_MarsRaidFrame_OnLeave = MarsRaidFrame_OnLeave;
	MarsRaidFrame_OnLeave = GB_MarsRaidFrame_OnLeave;

--	Support for Discord Unit Frames 2.0
	if (DUF_TargetOfTargetFrame) then
		GB_Old_DUF_Element_OnClick = DUF_Element_OnClick;
		DUF_Element_OnClick = GB_DUF_Element_OnClick;
		GB_Old_DUF_UnitFrame_OnClick = DUF_UnitFrame_OnClick;
		DUF_UnitFrame_OnClick = GB_DUF_UnitFrame_OnClick;
		GB_Old_DUF_Element_OnEnter = DUF_Element_OnEnter;
		DUF_Element_OnEnter = GB_DUF_Element_OnEnter;
		GB_Old_DUF_UnitFrame_OnEnter = DUF_UnitFrame_OnEnter;
		DUF_UnitFrame_OnEnter = GB_DUF_UnitFrame_OnEnter;
		GB_Old_DUF_Element_OnLeave = DUF_Element_OnLeave;
		DUF_Element_OnLeave = GB_DUF_Element_OnLeave;
		GB_Old_DUF_UnitFrame_OnLeave = DUF_UnitFrame_OnLeave;
		DUF_UnitFrame_OnLeave = GB_DUF_UnitFrame_OnLeave;
	end

	-- Gotta get set the bars when the default raid frames load
	GB_Old_RaidFrame_LoadUI = RaidFrame_LoadUI;
	RaidFrame_LoadUI = GB_RaidFrame_LoadUI;
end

function GB_RaidFrame_LoadUI()
	GB_Old_RaidFrame_LoadUI();
	GB_Set_Appearance("raid");
end

function GB_MacroFrame_Update()
	GB_Old_MacroFrame_Update();
	GB_Update_Macros();
end

function GB_Clear_MouseAction()
	GB_MOUSE_ACTION = {nil};
end

function GB_Set_MouseAction(id, id2, idtype, options)
	GB_Clear_MouseAction();
	GB_MOUSE_ACTION.id = id;
	GB_MOUSE_ACTION.id2 = id2;
	GB_MOUSE_ACTION.idtype = idtype;
	GB_MOUSE_ACTION.options = {};
	if (options) then
		GB_Copy_Table(options, GB_MOUSE_ACTION.options);
	else
		local table = GB_Get_DefaultButtonSettings();
		GB_Copy_Table(table, GB_MOUSE_ACTION.options);
	end
end

function GB_AllInOneInventoryFrameItemButton_OnClick(button, ignoreShift)
	local bag, slot = AllInOneInventory_GetIdAsBagSlot(this:GetID());
	if ( button == "LeftButton" ) then
		if ( not IsShiftKeyDown() ) then
			local itemname = GB_Get_ItemName(bag, slot);
			local _, _, locked = GetContainerItemInfo(bag, slot);
			if (itemname and (not locked)) then
				GB_Set_MouseAction(itemname, "", "item");
				GB_Old_AllInOneInventoryFrameItemButton_OnClick(button, ignoreShift);
			else
				GB_Old_AllInOneInventoryFrameItemButton_OnClick(button, ignoreShift);
				GB_Clear_MouseAction();
			end
		else
			GB_Old_AllInOneInventoryFrameItemButton_OnClick(button, ignoreShift);
		end
	else
		GB_Old_AllInOneInventoryFrameItemButton_OnClick(button, ignoreShift);
	end
end

function GB_ContainerFrame_OnClick(button, ignoreShift)
	if ( button == "LeftButton" ) then
		if ( not IsShiftKeyDown() ) then
			local bag = this:GetParent():GetID();
			local slot = this:GetID();
			local itemname = GB_Get_ItemName(bag, slot);
			local _, _, locked = GetContainerItemInfo(bag, slot);
			if (itemname) then
				GB_Set_MouseAction(itemname, "", "item");
				GB_Old_ContainerFrameItemButton_OnClick(button, ignoreShift);
			else
				GB_Old_ContainerFrameItemButton_OnClick(button, ignoreShift);
				GB_Clear_MouseAction();
			end
		else
			GB_Old_ContainerFrameItemButton_OnClick(button, ignoreShift);
		end
	else
		GB_Old_ContainerFrameItemButton_OnClick(button, ignoreShift);
	end
end

function GB_MyInventoryFrameItemButton_OnClick(button, ignoreShift)
	local bag, slot = this.bagIndex, this.itemIndex;
	if ( button == "LeftButton" ) then
		if ( not IsShiftKeyDown() ) then
			local itemname = GB_Get_ItemName(bag, slot);
			local _, _, locked = GetContainerItemInfo(bag, slot);
			if (itemname and (not locked)) then
				GB_Set_MouseAction(itemname, "", "item");
				GB_Old_MyInventoryFrameItemButton_OnClick(button, ignoreShift);
			else
				GB_Old_MyInventoryFrameItemButton_OnClick(button, ignoreShift);
				GB_Clear_MouseAction();
			end
		else
			GB_Old_MyInventoryFrameItemButton_OnClick(button, ignoreShift);
		end
	else
		GB_Old_MyInventoryFrameItemButton_OnClick(button, ignoreShift);
	end
end

function GB_PaperDollItemSlotButton_OnClick(button, ignoreShift)
	GB_Old_PaperDollItemSlotButton_OnClick(button, ignoreShift);
	if ( button == "LeftButton" ) then
		if ( not IsShiftKeyDown() ) then
			if ( GetInventoryItemTexture("player", this:GetID()) ) then
				local itemname = GB_Get_ItemName(this:GetID());
				GB_Set_MouseAction(itemname, "", "inv");
			end
		end
	end
end

function GB_PickupMacro(arg)
	GB_Old_PickupMacro(arg);
	local macroname, texture = GetMacroInfo(arg);
	GB_Set_MouseAction(macroname, "", "macro");
end

function GB_SpellButton_OnClick(drag)
	GB_Old_SpellButton_OnClick(drag);
	if (drag) then
		local spellName, spellRank = GetSpellName(SpellBook_GetSpellID(this:GetID()), BOOKTYPE_SPELL);
		GB_Set_MouseAction(spellName, spellRank, "spell");
	end
end

function GB_TotemStomper_WatchSpellbook(drag)
	GB_Old_TotemStomper_WatchSpellbook(drag);
	if (drag) then
		local spellName, spellRank = GetSpellName(SpellBook_GetSpellID(this:GetID()), BOOKTYPE_SPELL);
		GB_Set_MouseAction(spellName, spellRank, "spell");
	end
end