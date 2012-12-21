function GB_Main_RegisterEvents()
	this:RegisterEvent("ACTIONBAR_HIDEGRID");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	--this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("TRAINER_CLOSED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UPDATE_BINDINGS");
	this:RegisterEvent("VARIABLES_LOADED");
end

function GB_Main_OnLoad()
	GB_Main_RegisterEvents();

	SlashCmdList["GB"] = GB_Slash_Handler;
	SLASH_GB1 = "/gb";
	SLASH_GB2 = "/groupbuttons";
end

function GB_Main_OnEvent()
	if (event == "VARIABLES_LOADED") then
		GB_VARIABLES_LOADED = true;
		if (  GB_ENTERING_WORLD and GB_BAGS_LOADED) then
			GB_Initialize();
		end
	elseif (event == "PLAYER_ENTERING_WORLD") then
		--GB_Main_RegisterEvents();
		GB_ENTERING_WORLD = true;
		if ( GB_VARIABLES_LOADED and GB_BAGS_LOADED) then
			GB_Initialize();
		end
		GB_REGEN = true;
		GB_INCOMBAT = false;
	elseif (event == "ACTIONBAR_HIDEGRID") then
		GB_Clear_MouseAction();
	elseif (event == "BAG_UPDATE") then
		if (GB_INITIALIZED) then
			GroupButtonsFrame.itemstimer = .5;
		else
			GB_BAGS_LOADED = nil;
			GroupButtonsFrame.bagsloadedtimer = 1;
		end
	elseif (event == "PLAYER_ENTER_COMBAT") then
		GB_ATTACKING = true;
		GB_INCOMBAT = true;
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		GB_ATTACKING = false;
		if (GB_REGEN) then
			GB_INCOMBAT = false;
		end
	elseif (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterAllEvents();
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
	elseif (event == "PLAYER_REGEN_DISABLED") then
		GB_REGEN = false;
		GB_INCOMBAT = true;
	elseif (event == "PLAYER_REGEN_ENABLED") then
		GB_REGEN = true;
		if (not GB_ATTACKING) then
			GB_INCOMBAT = false;
		end
	elseif (event == "PLAYER_TARGET_CHANGED") then
		if (UnitName("target")) then
			this.targetauras = true;
			GB_Update_Auras("target");
		else
			this.targetauras = false;
		end
	elseif (event == "RAID_ROSTER_UPDATE") then
		if (not GB_INITIALIZED) then return; end
		for i=1,40 do
			local unit = "raid"..i;
			if (UnitExists(unit) and UnitName(unit) and (not GB_SKIP_NAMES[UnitName(unit)])) then
				GB_RAID_MEMBERS[UnitName(unit)] = 1;
			end
		end
		GB_Update_RaidMemberSelect();
		if (not GB_Settings[GB_INDEX].raid.hide) then
			GB_Initialize_Labels();
		end
		if (GetNumRaidMembers() > 0 and GB_SHUFFLE_RAID and (not GB_Settings[GB_INDEX].raid.hide)) then
			GB_Set_Appearance("raid");
		end
		if (GB_Settings[GB_INDEX].hideInRaid and GetNumRaidMembers() > 0) then
			local partyBar, petBar;
			for i=1,4 do
				partyBar = getglobal(GB_Get_UnitBar("party"..i));
				petBar = getglobal(GB_Get_UnitBar("partypet"..i));
				partyBar.noshow = true;
				petBar.noshow = true;
				partyBar:Hide();
				petBar:Hide();
			end
		end
	elseif (event == "SPELLCAST_FAILED") then
		if (GB_ANNOUNCEFAILURE) then
			GB_Announce_Failed(GB_Get("failedText"));
		end
		GB_ANNOUNCEFAILURE = nil;
		GB_ANNOUNCEINTERRUPTED = nil;
		GB_ISCASTING = nil;
		GB_INSTANTCASTING = nil;
		GB_CURRENT_HEAL = {nil};
		GB_ANNOUNCED = {nil};
		GB_SPELLISCASTING = nil;
	elseif (event == "SPELLCAST_INTERRUPTED") then
		if (GB_ANNOUNCEINTERRUPTED) then
			GB_Announce_Failed(GB_Get("interruptedText"));
		end
		GB_ANNOUNCEFAILURE = nil;
		GB_ANNOUNCEINTERRUPTED = nil;
		GB_ISCASTING = nil;
		GB_INSTANTCASTING = nil;
		GB_CURRENT_HEAL = {nil};
		GB_ANNOUNCED = {nil};
		GB_SPELLISCASTING = nil;
	elseif (event == "SPELLCAST_START") then
		GB_ANNOUNCEFAILURE = nil;
		GB_ANNOUNCEINTERRUPTED = nil;
		GB_INSTANTCASTING = nil;
		if (GB_ANNOUNCETEXT) then
			GB_Announce_Spellcast(GB_ANNOUNCETEXT, GB_WHISPERTARGET);
		end
		GB_ISCASTING = nil;
		GB_INSTANTCASTING = nil;
		GB_ANNOUNCETEXT = nil;
		GB_SPELLISCASTING = true;
	elseif (event == "SPELLCAST_STOP") then
		if (GB_INSTANTCASTING) then
			GB_Announce_Spellcast(GB_ANNOUNCETEXT, GB_WHISPERTARGET);
			GB_ANNOUNCEFAILURE = nil;
			GB_ANNOUNCEINTERRUPTED = nil;
			GB_ISCASTING = nil;
		end
		GB_INSTANTCASTING = nil;
		GB_CURRENT_HEAL = {nil};
		GB_SPELLISCASTING = nil;
	elseif (event == "SPELLS_CHANGED") then
		if (GB_CheckForNewSpells() and GB_INITIALIZED) then
			if (ClassTrainerFrame and ClassTrainerFrame:IsVisible()) then return; end
			GroupButtonsFrame.spellstimer = .1;
			GB_Spellbook_Initialize();
		end
	elseif (event == "TRAINER_CLOSED") then
		GB_Spellbook_Initialize();
		if (GB_SPELLS_UPDATED) then
			GB_SPELLS_UPDATED = nil;
		else
			GB_Update_SpellRanks();
		end
	elseif (event == "UNIT_AURA") then
		if (arg1 == "target") then
			if (this.targetauras) then
				GB_Update_Auras(arg1);				
			end
		else
			GB_Update_Auras(arg1);
		end
	elseif (event == "PLAYER_AURAS_CHANGED") then
		GB_Update_Auras("player");
	elseif (event == "UNIT_HEALTH") then
		if (GB_CURRENT_HEAL[1] and arg1 == GB_CURRENT_HEAL[3]) then
			if (GB_Settings[GB_INDEX].cancelHealThreshold) then
				if (not GB_Get_PastThreshold("cancelHealThreshold", GB_CURRENT_HEAL[3])) then
					local text = GB_TEXT.HealCancelledMessage;
					text = string.gsub(text, '$s', GB_CURRENT_HEAL[1]);
					text = string.gsub(text, '$r', GB_CURRENT_HEAL[2]);
					GB_Feedback(text);
					GB_CURRENT_HEAL = {};
					SpellStopCasting();
				end
			end
		end
	elseif (event == "UNIT_INVENTORY_CHANGED") then
		if (GB_INITIALIZED) then
			GroupButtonsFrame.itemstimer = .5;
		end
	elseif (event == "UNIT_LEVEL") then
		if (GetNumRaidMembers() > 0 and string.find(arg1, "raid")) then
			GB_Update_RaidMemberSelect();
		end
	elseif (event == "UNIT_NAME") then
		if (GetNumRaidMembers() > 0 and string.find(arg1, "raid")) then
			GB_Update_RaidMemberSelect();
		end
	elseif (event == "UPDATE_BINDINGS") then
		GB_Update_Bindings();
	end
end

function GB_Slash_Handler(msg)
	local command, param;
	local index = string.find(msg, " ");

	if( index) then
		command = string.sub(msg, 1, (index - 1));
		param = string.sub(msg, (index + 1)  );
	else
		command = msg;
	end
   
	if ( command == "" ) then
		GB_Show_OptionsFrame("main");
	elseif (command == "updateranges") then
		GB_Update_SpellRanges(1)
	elseif (command == "updatespells") then
		GB_Update_Spells(1);
	elseif (command == "toggle") then
		if (param == "labels") then
			GB_Toggle_Labels();
		elseif (param == "empty") then
			GB_Toggle_EmptyButtons();
		elseif (param == "spellbook") then
			GB_Toggle_MiniSpellbook();
		elseif (param == "barlock") then
			GB_Toggle_BarLock();
		elseif (param == "buttonlock") then
			GB_Toggle_ButtonsLock();
		end
	elseif (command == "hidebar") then
		local unitBar = GB_Get_UnitBar(param);
		if (unitBar) then
			GB_Settings[GB_INDEX][getglobal(unitBar).index].hide = true;
			GB_Set_Appearance(getglobal(unitBar).index);
		end
	elseif (command == "showbar") then
		local unitBar = GB_Get_UnitBar(param);
		if (unitBar) then
			GB_Settings[GB_INDEX][getglobal(unitBar).index].hide = nil;
			GB_Set_Appearance(getglobal(unitBar).index);
		end
	elseif (command == "setkeybar") then
		local unitBar = GB_Get_UnitBar(param);
		if (param == "target") then unitBar = "target"; end
		if (unitBar) then
			GB_Set_CurrentKeybindingBar(unitBar);
		end
	elseif (command == "useaction") then
		local _, _, bar, button = string.find(param, "(.*) (.*)");
		bar = GB_Get_UnitBar(bar);
		if (bar) then
			button = tonumber(button);
			if (button) then
				GB_ActionButton_OnClick(bar, button);
			end
		end
	elseif (command == "contexts") then
		local unitBar = GB_Get_UnitBar("target");
		local button;
		for i=1,20 do
			button = getglobal(unitBar.."_Button_"..i);
			for index,v in button.InContext do
				if (v == -1) then
					GB_Debug("button "..i.." "..index.." = "..v);
				end
			end
		end
	elseif (command == "spelldata") then
		for name, ranks in GB_SPELLS do
			for rank,data in ranks do
				for i, v in data do
					if (string.find(name, param)) then
						GB_Feedback(name.." "..rank..": "..i.." = "..v);	
					end
				end
			end
		end
	elseif (command == "clearall") then
		GB_Settings[GB_INDEX] = nil;
		GB_Initialize_DefaultSettings();
		GB_Initialize_NewSettings();
		GB_UnitFrames_Initialize();
		GB_Initialize_BarOptions("player");
		GB_Initialize_Labels();
		GB_Initialize_Toggles();
		GB_Initialize_AllBars();
		GB_Initialize_AnnounceOptions();
		GB_Initialize_ThresholdsOptions();
		GB_Initialize_MiscOptions();
	elseif (command == "hidebar") then
		if (GB_Settings[GB_INDEX][param]) then
			GB_Settings[GB_INDEX][param].hide = true;
			GB_Set_Appearance(param);
		end
	elseif (command == "showbar") then
		if (GB_Settings[GB_INDEX][param]) then
			GB_Settings[GB_INDEX][param].hide = nil;
			GB_Set_Appearance(param);
		end
	else
		for _, t in GB_HELP_TEXT do
			GB_Feedback(t);
		end
	end
end

function GB_Debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage( msg, 1.0, 0.0, 0.0 );
end

function GB_Feedback(msg)
	if (GB_Get("disableGBSpam")) then return; end
	DEFAULT_CHAT_FRAME:AddMessage( msg, 1.0, 1.0, 0.0 );
end

function GB_StopMoving(frame)
	if (frame) then
		this = frame;
	end
	if (this.isMoving) then
		this:StopMovingOrSizing();
		this:SetUserPlaced(true);
		GB_Settings[GB_INDEX].frameLocs[this:GetName()] = {x = this:GetLeft(), y = this:GetTop()};
		this.isMoving = false;
	end
end

function GB_StartMoving(frame)
	if (frame) then
		this = frame;
	end
	if (this:GetName() ~= "GB_Options" and this:GetName() ~= "GB_MiniSpellbook" ) then
		if (not GB_Get("barsLocked")) then
			GB_Feedback(GB_TEXT.BarsUnlockedWarning);
		end
	end
	if (arg1 == "LeftButton") then
		this:SetUserPlaced(true);
		this:StartMoving();
		this.isMoving = true;
	end
end

function GB_Copy_Table(src, dest)
	for index, value in src do
		if (type(value) == "table") then
			dest[index] = {};
			GB_Copy_Table(value, dest[index]);
		else
			dest[index] = value;
		end
	end
end

function GB_MenuTimeout()
	if (this.timer) then
		this.timer = this.timer - arg1;
		if (this.timer < 0) then
			this:Hide();
			this.timer = nil;
		end
	end
end

function GB_SpellChanged(text, name, rank)
	text = string.gsub(text, "$name", name);
	if (rank and rank ~= "") then
		text = string.gsub(text, "$rank", "("..rank..")");
	end
	GB_Feedback(text);
end

function GB_Show_Tooltip(bar, button)
	if (GB_Settings[GB_INDEX].Disable) then return; end
	if (GB_Get("disableTooltip")) then return; end
	local idType = GB_Settings[GB_INDEX][bar].Button[button].idType;
	local name = GB_Settings[GB_INDEX][bar].Button[button].name;
	if (not name) then
		return;
	end
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	if (idType == "spell") then
		GameTooltip:SetSpell(GB_SPELLS[name][GB_Settings[GB_INDEX][bar].Button[button].rank].id, SpellBookFrame.bookType);
	elseif (idType == "item") then
		local hasCooldown = GameTooltip:SetBagItem(GB_ITEMS[name].bag,GB_ITEMS[name].slot);
		if ( hasCooldown ) then
			this.updateTooltip = TOOLTIP_UPDATE_TIME;
		else
			this.updateTooltip = nil;
		end
	elseif (idType == "inv") then
		local _,hasCooldown = GameTooltip:SetInventoryItem("player", GB_INVENTORY[name].id);
		if ( hasCooldown ) then
			this.updateTooltip = TOOLTIP_UPDATE_TIME;
		else
			this.updateTooltip = nil;
		end
	elseif (idType == "macro") then
		GameTooltip:SetText(name, 1, 1, 1);
	end
end

function GB_AttackTarget()
	if (UnitCanAttack("player","target") and UnitHealth("target") > 0) then
		if (not GB_ATTACKING) then
			if (not GB_Get("dontAttack")) then
				AttackTarget(); 
			end
		end
	end
end

function GB_Announce_Spellcast(text, target)
	if (not GB_ISCASTING) then return; end
	if (not text) then return; end
	if (GB_Get("announceDisabled")) then return; end

	if (GB_Get("doNotAnnounceSolo")) then
		local numParty = GetNumPartyMembers() + GetNumRaidMembers();
		if (numParty < 1) then return; end
	end

	local channel = "SAY";
	local lang = ChatFrameEditBox.language;
	
	if (GB_Get("doNotUseSay")) then channel="WHISPER"; end
	if (not GB_Get("doNotUseParty")) then
		if (GetNumPartyMembers() > 0) then channel = "PARTY"; end
	end
	if (not GB_Get("doNotUseRaid")) then
		if (GetNumRaidMembers() > 0) then channel = "RAID"; end
	end

	if (GB_Settings[GB_INDEX].sendToChannel and GB_Settings[GB_INDEX].announceChannel and GB_Settings[GB_INDEX].announceChannel ~= "") then
		channel = "CHANNEL";
		target = GetChannelName(GB_Settings[GB_INDEX].announceChannel);
	end
	
	SendChatMessage(text, channel, lang, target);

	if (GB_Get("announceFailed")) then
		GB_ANNOUNCEFAILURE = true;
	else
		GB_ANNOUNCEFAILURE = nil;
	end
	if (GB_Get("announceInterrupted")) then
		GB_ANNOUNCEINTERRUPTED = true;
	else
		GB_ANNOUNCEINTERRUPTED = nil;
	end
end

function GB_KeyBindingFrame_GetLocalizedName(name, prefix)
	if ( not name ) then
		return "";
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
		if ( GetLocale() == "deDE") then
			modKeys = gsub(modKeys, "CTRL", "STRG");
		end
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
	return modKeys..localizedName;
end

function GB_Update_Bindings()
	for bar in GB_UNITS_ARRAY do
		for _, unitBar in GB_UNITS_ARRAY[bar].frames do
			for button = 1, GB_UNITS_ARRAY[bar].buttons do
				local keytext = getglobal(unitBar.."_Button_"..button.."TextFrame_HotKey");
				local keytext2 = getglobal(unitBar.."_Button_"..button.."TextFrame_DynamicHotKey");
				local unit = getglobal(unitBar).unit;
				if (bar == "lowesthealth") then
					unit = bar;
				end
				if (unit == "hostiletarget") then unit = "target";
				elseif (unit == "friendlytarget") then unit = "target";
				end
				local action = "GB_"..string.upper(unit)..button;
				if (string.find(unit,"party")) then
					action = "GB_"..string.upper(unit).."_"..button;
				end
				local action2 = "GB_DYNAMICKB"..button;
				local kbtext = GB_KeyBindingFrame_GetLocalizedName(GetBindingKey(action), "KEY_");
				local kbtext2 = GB_KeyBindingFrame_GetLocalizedName(GetBindingKey(action2), "KEY_");
				kbtext = string.upper(kbtext);
				kbtext2 = string.upper(kbtext2);
				kbtext = string.gsub(kbtext, "SHIFT", "S");
				kbtext = string.gsub(kbtext, "CTRL", "C");
				kbtext = string.gsub(kbtext, "ALT", "A");
				kbtext = string.gsub(kbtext, "MOUSE BUTTON", "MB");
				kbtext = string.gsub(kbtext, "MIDDLE MOUSE", "MM");
				kbtext = string.gsub(kbtext, "NUM PAD", "NP");
				kbtext2 = string.gsub(kbtext2, "SHIFT", "S");
				kbtext2 = string.gsub(kbtext2, "CTRL", "C");
				kbtext2 = string.gsub(kbtext2, "ALT", "A");
				kbtext2 = string.gsub(kbtext2, "MIDDLE MOUSE", "MM");
				kbtext2 = string.gsub(kbtext2, "MOUSE BUTTON", "MB");
				kbtext2 = string.gsub(kbtext2, "NUM PAD", "NP");
				if (GB_Get("hideBaseBindings")) then kbtext = ""; end
				if (GB_Get("hideDynamicBindings")) then kbtext2 = ""; end
				keytext:SetText(kbtext);
				if (GB_CURRENT_KB_BAR == unitBar or GB_CURRENT_KB_BAR == unit) then
					keytext2:SetText(kbtext2);
				else
					keytext2:SetText("");
				end
			end
		end
	end
end

function GB_Set_CurrentKeybindingBar(unitBar)
	GB_CURRENT_KB_BAR = unitBar;
	GB_Update_Bindings();
end

function GB_Announce_Failed(text)
	if ((not text) or text == "") then return; end
	if (not GB_ANNOUNCED.spellName) then return; end
	if (GB_ANNOUNCED.target) then
		text = string.gsub(text, '$t', GB_ANNOUNCED.target);
	end
	if (GB_ANNOUNCED.spellRank) then
		text = string.gsub(text, '$r', GB_ANNOUNCED.spellRank);
	end
	text = string.gsub(text, '$s', GB_ANNOUNCED.spellName);
	local channel = "SAY";
	local lang = ChatFrameEditBox.language;
	if (GB_Get("doNotUseSay")) then channel="WHISPER"; end
	if (not GB_Get("doNotUseParty")) then
		if (GetNumPartyMembers() > 0) then channel = "PARTY"; end
	end
	if (not GB_Get("doNotUseRaid")) then
		if (GetNumRaidMembers() > 0) then channel = "RAID"; end
	end
	if (GB_Settings[GB_INDEX].sendToChannel and GB_Settings[GB_INDEX].announceChannel and GB_Settings[GB_INDEX].announceChannel ~= "") then
		channel = "CHANNEL";
		GB_ANNOUNCED.target = GetChannelName(GB_Settings[GB_INDEX].announceChannel);
	end
	SendChatMessage(text, channel, lang, GB_ANNOUNCED.target);
end

function GB_Update_SpellRanks()
	if (GB_Settings[GB_INDEX].Disable) then return; end 
	GB_SPELLS_UPDATED = true;
	GB_CheckForNewSpells();
	GB_Update_Spells();
	local idType, spellrank, rank, autoUpdate, name
	for bar in GB_UNITS_ARRAY do
		for button = 1, 20 do
			name = GB_Settings[GB_INDEX][bar].Button[button].name
			idType = GB_Settings[GB_INDEX][bar].Button[button].idType;
			spellrank = GB_Settings[GB_INDEX][bar].Button[button].rank;
			autoUpdate = GB_Settings[GB_INDEX][bar].Button[button].autoUpdate;
			if (idType == "spell" and autoUpdate) then
				_,_,rank = string.find(spellrank, " (%d*)");
				rank = tonumber(rank);
				if (rank) then
					rank = rank + 1;
					if (GB_SPELLS[name][GB_TEXT.Rank..rank]) then
						GB_Settings[GB_INDEX][bar].Button[button].rank = GB_TEXT.Rank..rank;
						GB_ActionButton_Initialize(bar, button);
						if (bar == GB_BAR) then
							GB_Options_InitAction(bar, button);
						end
					end
				end
			end
		end
	end
end

function GB_CheckForNewSpells()
	count = 0;
	while true do
		count = count + 1;
		local spellName, spellRank = GetSpellName(count, BOOKTYPE_SPELL);
		if not spellName then
			do break end
		end
	end
	if (GB_SPELLS_COUNT ~= (count  - 1)) then
		return true;
	end
end

function GB_CheckTimeout(timeout, elapsed)
	if (GroupButtonsFrame[timeout].time) then
		GroupButtonsFrame[timeout].time = GroupButtonsFrame[timeout].time - elapsed;
		if (GroupButtonsFrame[timeout].time < 0) then
			GroupButtonsFrame[timeout].time = nil;
			GroupButtonsFrame[timeout].func();
		end
	end
end

function GB_CheckBagsTimer(elapsed)
	if (this.bagsloadedtimer) then
		this.bagsloadedtimer = this.bagsloadedtimer - elapsed;
		if (this.bagsloadedtimer < 0) then
			this.bagsloadedtimer = nil;
			GB_BAGS_LOADED = true;
			if (GB_ENTERING_WORLD and GB_VARIABLES_LOADED) then
				GB_Initialize();
			end
		end
	end
end

function GB_CheckItemUpdateTimer(elapsed)
	if (this.itemstimer) then
		this.itemstimer = this.itemstimer - elapsed;
		if (this.itemstimer < 0) then
			this.itemstimer = nil;
			GB_Update_InventoryItems();
			GB_Update_ContainerItems();
		end
	end
end

function GB_CheckSpellsUpdateTimer(elapsed)
	if (this.spellstimer) then
		this.spellstimer = this.spellstimer - elapsed;
		if (this.spellstimer < 0) then
			this.spellstimer = nil;
			GB_Update_Spells();
			GB_Spellbook_Initialize();
		end
	end
end

function GB_UnitInRaid(unit)
	local name = UnitName(unit);
	for i=1, GetNumRaidMembers() do
		if (UnitName("raid"..i) == name) then return true; end
	end
end

function GB_CureAny(unit)
	if (not unit) then
		if (GB_LAST_UNIT) then
			unit = GB_LAST_UNIT;
		else
			unit = "target";
		end
	end
	if (not UnitName(unit)) then return; end
	local disease, poison, curse, magic;
	local debuff;
	local spell, rank;
	for i = 1, 8 do
		debuff = UnitDebuff(unit, i);	
		if (not debuff) then break; end
		GBTooltip:SetUnitDebuff(unit, i);
		if (GBTooltipTextRight1:IsVisible()) then
			debuff = GBTooltipTextRight1:GetText();
		else
			debuff = nil;
		end
		if (debuff) then
			if (string.find(debuff, GB_FILTERS.Disease)) then
				if (disease) then
					disease = disease + 1;
				else
					disease = 1;
				end
			end
			if (string.find(debuff, GB_FILTERS.Poison)) then
				if (poison) then
					poison = poison + 1;
				else
					poison = 1;
				end
			end
			if (string.find(debuff, GB_FILTERS.Magic)) then
				if (magic) then
					magic = magic + 1;
				else
					magic = 1;
				end
			end
			if (string.find(debuff, GB_FILTERS.Curse)) then
				if (curse) then
					curse = curse + 1;
				else
					curse = 1;
				end
			end
		end
	end
	if (magic and (not spell)) then
		if (GB_SPELLS[GB_CURES.DispelMagic.text]) then
			spell = GB_CURES.DispelMagic.text;
			rank = 1;
			if (magic > 1) then
				rank = 2;
			end
		elseif (GB_SPELLS[GB_CURES.Cleanse.text]) then
			spell = GB_CURES.Cleanse.text;
		end
	end
	if (disease and (not spell)) then
		if (GB_SPELLS[GB_CURES.CureDisease.text]) then
			spell = GB_CURES.CureDisease.text;
		elseif (GB_SPELLS[GB_CURES.Purify.text]) then
			spell = GB_CURES.Purify.text;
		end
		if (disease > 1 and GB_SPELLS[GB_CURES.AbolishDisease.text]) then
			if (not GB_Get_BuffMatch(GB_CURES.AbolishDisease.text, target)) then
				spell = GB_CURES.AbolishDisease.text;
			else
				spell = nil;
			end
		end
	end
	if (poison and (not spell)) then
		if (GB_SPELLS[GB_CURES.CurePoison.text]) then
			spell = GB_CURES.CurePoison.text;
		elseif (GB_SPELLS[GB_CURES.Purify.text]) then
			spell = GB_CURES.Purify.text;
		end
		if (poison > 1 and GB_SPELLS[GB_CURES.AbolishPoison.text]) then
			if (not GB_Get_BuffMatch(GB_CURES.AbolishPoison.text, target)) then
				spell = GB_CURES.AbolishPoison.text;
			else
				spell = nil;
			end
		end
	end
	if (curse and (not spell)) then
		if (GB_SPELLS[GB_CURES.RemoveCurse.text]) then
			spell = GB_CURES.RemoveCurse.text;
		end
	end
	if (spell) then
		if (rank) then
			rank = GB_TEXT.Rank..rank;
		else
			rank = "";
		end
		CastSpell( GB_SPELLS[spell][rank].id, "BOOKTYPE_SPELL" );
	else
		GB_Feedback(GB_TEXT.NoEffectsFound);
	end
end

--[[function GB_RunMacro(macroname)
	local macroID = GetMacroIndexByName(macroname);
	local _, _, body = GetMacroInfo(macroID);
	if (string.find(body, "\n")) then
		local line = "";
		for i=1,string.len(body) do
			local character = string.sub(body, i, i);
			if (character == "\n") then
				GB_MacroBox:SetText(line);
				ChatEdit_SendText(GB_MacroBox);
				line = "";
			else
				line = line..character;
			end
		end
	else
		GB_MacroBox:SetText(body);
		ChatEdit_SendText(GB_MacroBox);
	end
end --]]

function GB_RunMacro(macroname)
	local name, texture, body, isLocal = GetMacroInfo(GetMacroIndexByName(macroname));

	if ( not body ) then return; end

	local length = string.len(body);
	local text="";
	for i = 1, length do
		text=text..string.sub(body,i,i);
		if ( string.sub(body,i,i) == "\n" or i == length ) then
			if ( string.find(text,"/cast") ) then
				local i, booktype = GB_GetSpell(gsub(text,"%s*/cast%s*(.*)%s;*.*","%1"));
				if ( i ) then
					RunScript("CastSpell("..i..",'"..booktype.."')");
				end
			else
				while ( string.find(text, "CastSpellByName")) do
					local spell = gsub(text,'.-CastSpellByName.-%(.-"(.-)".*','%1',1);
					local i, booktype = GB_GetSpell(spell);
					if ( i ) then
						text = gsub(text,'CastSpellByName.-%(.-".-"','CastSpell('..i..','..'"'..booktype..'"',1);
					else
						text = gsub(text,'CastSpellByName.-%(.-".-"%)','',1);
					end
				end
				if ( string.find(text,"/script")) then
					RunScript(gsub(text,"%s*/script%s*(.*)","%1"));
				else
					GB_MacroBox:SetText(text);
					ChatEdit_SendText(GB_MacroBox);
				end
			end
			text="";
		end
	end
end

function GB_GetSpell(spell)
	local s = gsub(spell, "%s-(.-)%s*%(.*","%1");
	local r;
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
	elseif ( not string.find(spell, "%(")) then
		r = ""
	else
		r = gsub(spell, ".*%(.*[Rr]ank%s*(%d+).*", "Rank %1");
	end
	return GB_FindSpell(s,r);
end

function GB_FindSpell(spell, rank)
	local i = 1;
	local booktype = "spell";
	local s,r;
	local ys, yr;
	while true do
		s, r = GetSpellName(i,"spell");
		if ( not s ) then break; end
		if ( string.lower(s) == string.lower(spell)) then ys=true; end
		if ( (r == rank) or (r and rank and string.lower(r) == string.lower(rank))) then yr=true; end
		if ( ys and yr ) then
			return i,booktype;
		end
		i=i+1;
		ys = nil;
		yr = nil;
	end
	i = 1;
	while true do
		s, r = GetSpellName(i,"pet");
		if ( not s) then break; end
		if ( string.lower(s) == string.lower(spell)) then ys=true; end
		if ( (r == rank) or (r and rank and string.lower(r) == string.lower(rank))) then yr=true; end
		if ( ys and yr ) then
			booktype = "pet";
			return i,booktype;
		end
		i=i+1;
		ys = nil;
		yr = nil;
	end
	return nil, booktype;
end

function GB_Update_Auras(unit)
	if (unit == "mouseover") then return; end
	if (not UnitName(unit)) then return; end
	GB_BUFFS[unit] = {nil};
	GB_DEBUFFS[unit] = {nil};
	GBAuraTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");

	if (unit == "player") then
		GB_SHADOWFORM_INDEX = nil
	end
	for i = 1, 16 do
		if (UnitBuff(unit, i)) then
			GBAuraTooltip:SetUnitBuff(unit, i);
			if (GBAuraTooltipTextLeft1:IsShown()) then
				GB_BUFFS[unit][GBAuraTooltipTextLeft1:GetText()] = i;
				if (unit == "player" and GBAuraTooltipTextLeft1:GetText() == GB_TEXT.Shadowform) then
					for j = 0, 15 do
						local bi = GetPlayerBuff(j, "HELPFUL")
						if (GetPlayerBuffTexture(bi)) then
							GBAuraTooltip:SetPlayerBuff(bi);
							if (GBAuraTooltipTextLeft1:IsShown() and GBAuraTooltipTextLeft1:GetText() == GB_TEXT.Shadowform) then
								GB_SHADOWFORM_INDEX = j
								break
							end
						end
					end
				end
				if (string.find(GBAuraTooltipTextLeft1:GetText(), "-", 1, true)) then
					GB_BUFFS[unit][UnitBuff(unit, i)] = i;
				end
			end
		end
	end
	for i = 1, 16 do
		if (UnitDebuff(unit, i)) then
			GBAuraTooltip:SetUnitDebuff(unit, i);
			if (GBAuraTooltipTextLeft1:IsShown()) then
				GB_DEBUFFS[unit][GBAuraTooltipTextLeft1:GetText()] = true;
			end
			if (GBAuraTooltipTextRight1:IsShown()) then
				GB_DEBUFFS[unit][GBAuraTooltipTextRight1:GetText()] = true;
			end
		end
	end
end