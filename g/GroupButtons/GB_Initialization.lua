--GB_Old_UIErrorsFrame_OnEvent = UIErrorsFrame_OnEvent;
--function UIErrorsFrame_OnEvent(event, message)
--	GB_Old_UIErrorsFrame_OnEvent(event, message);
--	if (GB_ISCASTING or GB_INSTANTCASTING) then
		--SpellStopTargeting();
--	end
--end

function GB_CheckForInvalidSpells()
	local idtype, name, rank;
	for index in GB_UNITS_ARRAY do
		for i=1, 20 do
			idtype = GB_Settings[GB_INDEX][index].Button[i].idType;
			name = GB_Settings[GB_INDEX][index].Button[i].name;
			rank = GB_Settings[GB_INDEX][index].Button[i].rank;
			if (idtype == "spell") then
				if (not GB_SPELLS[name][rank]) then
					GB_Settings[GB_INDEX][index].Button[i] = GB_Get_DefaultButtonSettings();
					GB_ActionButton_Initialize(index, i);
				end
			end
		end
	end
end

function GB_DisableGB()
	if (GB_Settings[GB_INDEX].Disable) then
		GB_Settings[GB_INDEX] = {};
		GB_Settings[GB_INDEX].Disable = true;
		GB_INITIALIZED = false;
		for _,box in GB_CLICKBOXES do
			getglobal(box):Hide();
			getglobal(box.."_Texture"):Hide();
		end
		for i=1,4 do
			local partyBar = getglobal(GB_Get_UnitBar("party"..i));
			local petBar = getglobal(GB_Get_UnitBar("partypet"..i));
			partyBar.noshow = true;
			petBar.noshow = true;
			partyBar:Hide();
			petBar:Hide();
		end
		for i=1,40 do
			local raidbar = getglobal(GB_Get_UnitBar("raid"..i));
			raidbar.noshow = true;
			raidbar:Hide();
		end
		GB_LowestHealthBar:Hide();
		GB_HostileTargetBar:Hide();
		GB_FriendlyTargetBar:Hide();
		GB_PlayerBar:Hide();
	else
		GB_Settings[GB_INDEX] = {};
		GB_Settings[GB_INDEX].Undisable = true;
		GB_Feedback("Reloading the UI.");
		GB_MacroBox:SetText("/console reloadui");
		ChatEdit_SendText(GB_MacroBox);
	end
end

function GB_Initialize()
	if (GB_INITIALIZED) then return; end

	for i=2,30 do
		local left = getglobal("GBAuraTooltipTextLeft"..i)
		for i,v in left do
			if (type(v) == "function") then
				left[i] = function() end
			end
		end
		local left = getglobal("GBAuraTooltipTextRight"..i)
		for i,v in left do
			if (type(v) == "function") then
				left[i] = function() end
			end
		end
	end
	for i,v in GBAuraTooltipTextLeft1 do
		if (type(v) == "function" and i ~= "GetText" and i ~= "SetText" and i ~= "Hide" and i ~= "Show") then
			GBAuraTooltipTextLeft1[i] = function() end
		end
	end
	for i,v in GBAuraTooltipTextRight1 do
		if (type(v) == "function" and i ~= "GetText" and i ~= "SetText" and i ~= "Hide" and i ~= "Show") then
			GBAuraTooltipTextRight1[i] = function() end
		end
	end

	GB_INDEX = UnitName("player").."::"..GetCVar("realmName");
	_,GB_PLAYER_CLASS = UnitClass("player")

	GBTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
	GBAuraTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");

	if (GB_Settings and GB_Settings[GB_INDEX]) then
		if (GB_Settings[GB_INDEX].Disable) then
			GB_Settings[GB_INDEX] = {};
			GB_Settings[GB_INDEX].Disable = true;
			GB_MiscOptions_DisableGB:SetChecked(1);
			GroupButtonsFrame:UnregisterEvent("BAG_UPDATE");
			for _,box in GB_CLICKBOXES do
				getglobal(box):Hide();
				getglobal(box.."_Texture"):Hide();
			end
			for i=1,4 do
				local partyBar = getglobal(GB_Get_UnitBar("party"..i));
				local petBar = getglobal(GB_Get_UnitBar("partypet"..i));
				partyBar.noshow = true;
				petBar.noshow = true;
				partyBar:Hide();
				petBar:Hide();
			end
			for i=1,40 do
				local raidbar = getglobal(GB_Get_UnitBar("raid"..i));
				raidbar.noshow = true;
				raidbar:Hide();
			end
			GB_LowestHealthBar:Hide();
			GB_HostileTargetBar:Hide();
			GB_FriendlyTargetBar:Hide();
			GB_PlayerBar:Hide();
			return;
		end
	end

	GB_Hook_Functions();

	if (GetLocale() == "deDE") then
		if (UnitClass("player") == GB_TEXT.Shaman) then
			GB_CURES.CurePoison.text = "Vergiftung heilen";
		end
	end

	GB_RaidMemberSelect1:ClearAllPoints();
	GB_RaidMemberSelect1:SetPoint("TOPLEFT", "GB_RaidMemberSelect", "TOPLEFT", 10, -35);
	GB_RaidMemberSelect1_Label:SetText("Raid Member 1");
	local prm;
	for i=2,20 do
		prm = "GB_RaidMemberSelect"..(i - 1);
		getglobal("GB_RaidMemberSelect"..i):ClearAllPoints();
		getglobal("GB_RaidMemberSelect"..i):SetPoint("TOPLEFT", prm, "BOTTOMLEFT", 0, 0);
	end
	GB_RaidMemberSelect21:ClearAllPoints();
	GB_RaidMemberSelect21:SetPoint("TOPLEFT", "GB_RaidMemberSelect", "TOPLEFT", 270, -35);
	GB_RaidMemberSelect21_Label:SetText("Raid Member 21");
	for i=22,40 do
		prm = "GB_RaidMemberSelect"..(i - 1);
		getglobal("GB_RaidMemberSelect"..i):ClearAllPoints();
		getglobal("GB_RaidMemberSelect"..i):SetPoint("TOPLEFT", prm, "BOTTOMLEFT", 0, 0);
	end

	if (not GB_Settings) then
		GB_Settings = {};
	end

	if (not GB_Settings[GB_INDEX]) then
		GB_Initialize_DefaultSettings();
	elseif (GB_Settings[GB_INDEX].Undisable) then
		GB_Initialize_DefaultSettings();
	end

	GB_Initialize_NewSettings();
	GB_INITIALIZED = true;

	if (DUF_TargetOfTargetFrame) then
		GB_Settings[GB_INDEX].hideClickboxes = true;
	end

	GB_Update_FrameLocations();
	GB_UnitFrames_Initialize();
	GB_Update_Spells();
	GB_Update_InventoryItems();
	GB_Update_ContainerItems(1);
	GB_Update_Macros();
	GB_CheckForInvalidSpells();
	GB_Spellbook_Initialize();
	GB_Initialize_BarOptions("player");
	GB_Initialize_Labels();
	GB_Initialize_Toggles();
	GB_Initialize_AllBars();
	GB_Initialize_Menus();
	GB_Initialize_AnnounceOptions();
	GB_Initialize_ThresholdsOptions();
	GB_Initialize_MiscOptions();
	GB_Update_Bindings();
	GB_Update_RaidMemberSelect();
	GB_Bars_Raise();

	if (not GB_Get("partypet", "hide")) then
		if (UnitName("pet")) then
			GB_PetBar0:Show();
		end
	end
	for i=1, GetNumPartyMembers() do
		getglobal("GB_PartyBar"..i).noshow = false;
		GB_LowestHealthBar.noshow = false;
		if (not GB_Get("party", "hide")) then
			getglobal("GB_PartyBar"..i):Show();
			if (not GB_Get("partypet", "hide")) then
				if (UnitName("partypet"..i)) then
					getglobal("GB_PetBar"..i).noshow = false;
					getglobal("GB_PetBar"..i):Show();
				end
			end
		end
		if (not GB_Get("lowesthealth", "hide")) then
			GB_LowestHealthBar:Show();
		end
	end

	if (not GB_Settings[GB_INDEX].Disable) then
		GB_Initialize_AllBars();
	end

	if (not GB_Settings[GB_INDEX].Disable) then
				for _,box in GB_CLICKBOXES do
					getglobal(box):Hide();
					getglobal(box.."_Texture"):Hide();
				end
				if (not GB_Get("hideClickboxes")) then
					GB_PlayerClickbox:Show();
					if (UnitName("target")) then
						GB_TargetClickbox:Show();
					end
					if (UnitName("pet")) then
						GB_Pet0Clickbox:Show();
					end
					for i=1,GetNumPartyMembers() do
						getglobal("GB_Party"..i.."Clickbox"):Show();
						if (UnitName("partypet"..i)) then
							getglobal("GB_Pet"..i.."Clickbox"):Show();
						end
					end
				end
			end
end

function GB_Initialize_NewSettings()
	if (not GB_Settings[GB_INDEX].HealingBonus) then
		GB_Settings[GB_INDEX].HealingBonus = 0;
	end

	if (not GB_Settings[GB_INDEX].Initialized["4.11"]) then
		GB_Settings[GB_INDEX].disablePartyRange = true;
	end

	if (not GB_Settings[GB_INDEX].Initialized["4.3"]) then
		for bar in GB_UNITS_ARRAY do
			if (GB_Settings[GB_INDEX][bar]) then 
				GB_Settings[GB_INDEX][bar].oldLeftClick = "l";
				GB_Settings[GB_INDEX][bar].oldRightClick = "r";
				for i = 1, GB_UNITS_ARRAY[bar].buttons do
					if (GB_Settings[GB_INDEX][bar].Button[i].preventOverhealing) then
						GB_Settings[GB_INDEX][bar].Button[i].cancelHeal = true;
					else
						GB_Settings[GB_INDEX][bar].Button[i].cancelHeal = false;
					end
				end
			end
		end
	end

	if (not GB_Settings[GB_INDEX].Initialized["4.5"]) then
		GB_Settings[GB_INDEX].frameLocs = {};
		GB_Settings[GB_INDEX].partypet = {
				Button = {},
				alpha = 1,
				buttonSize = 30,
				hide = false,
				rows = 1,
				collapse = false,
				spacing = 0,
				attach = false,
				attachPoint = "TOPLEFT",
				attachTo = "BOTTOMLEFT",
				xoffset = 0,
				yoffset = 0,
				mouseover = false,
				clickCast = {},
				Clickbox = { x1=0, x2=0, y1=0, y2=0 },
				oldLeftClick = "l",
				oldRightClick = "r"
			};
		GB_Settings[GB_INDEX].raid = {
				Button = {},
				alpha = 1,
				buttonSize = 30,
				hide = false,
				rows = 1,
				collapse = false,
				spacing = 0,
				attach = false,
				attachPoint = "TOPLEFT",
				attachTo = "BOTTOMLEFT",
				xoffset = 0,
				yoffset = 0,
				mouseover = false,
				clickCast = {},
				Clickbox = { x1=0, x2=0, y1=0, y2=0 },
				oldLeftClick = "l",
				oldRightClick = "r"
			};
		for i=1, 20 do
			GB_Settings[GB_INDEX].partypet.Button[i] = GB_Get_DefaultButtonSettings();
			GB_Settings[GB_INDEX].raid.Button[i] = GB_Get_DefaultButtonSettings();
			GB_Settings[GB_INDEX].party.Button[i].OOCoption = "hide";
			GB_Settings[GB_INDEX].friendlytarget.Button[i].OOCoption = "hide";
			GB_Settings[GB_INDEX].hostiletarget.Button[i].OOCoption = "hide";
			GB_Settings[GB_INDEX].player.Button[i].OOCoption = "hide";
			GB_Settings[GB_INDEX].lowesthealth.Button[i].OOCoption = "hide";
		end
	end

	if (not GB_Settings[GB_INDEX].Initialized["4.6"]) then
		GB_Settings[GB_INDEX].OOMcolor = {r=.2, g=.2, b=1};	
		GB_Settings[GB_INDEX].OORcolor = {r=1, g=.2, b=.2};
		GB_Settings[GB_INDEX].greycolor = {r=.4, g=.4, b=.4};
	end

	if (not GB_Settings[GB_INDEX].Initialized["4.7"]) then
		GB_Settings[GB_INDEX].announcements[4] = "";
		GB_Settings[GB_INDEX].announcements[5] = "";
		GB_Settings[GB_INDEX].pet = {};
		GB_Copy_Table(GB_Settings[GB_INDEX].partypet, GB_Settings[GB_INDEX].pet);
	end

	if (not GB_Settings[GB_INDEX].Initialized["4.95"]) then
		GB_Settings[GB_INDEX].modifybyUIscale = true;
		GB_Settings[GB_INDEX].announceChannel = "";
	end

	if (not GB_Settings[GB_INDEX].announceChannel) then
		GB_Settings[GB_INDEX].announceChannel = "";
	end

	GB_Settings[GB_INDEX].Initialized["4.95"] = true;
	GB_Settings[GB_INDEX].Initialized["4.7"] = true;
	GB_Settings[GB_INDEX].Initialized["4.6"] = true;
	GB_Settings[GB_INDEX].Initialized["4.5"] = true;
	GB_Settings[GB_INDEX].Initialized["4.3"] = true;
	GB_Settings[GB_INDEX].Initialized["4.11"] = true;
end

function GB_Initialize_AnchorsMenu()
	local width = 0;
	for i=1,9 do
		local optiontext = getglobal("GB_Menu_Anchors_Option"..i.."_Text");
		optiontext:SetText(GB_ANCHOR_POINTS[i].text);
		getglobal("GB_Menu_Anchors_Option"..i).value = GB_ANCHOR_POINTS[i].value;
		if (optiontext:GetWidth() > width) then
			width = optiontext:GetWidth();
		end
	end
	for i=1,9 do
		getglobal("GB_Menu_Anchors_Option"..i):SetWidth(width);
	end
	GB_Menu_Anchors:SetWidth(width + 20);
end

function GB_Initialize_AnnounceNumMenu()
	for i=1,5 do
		getglobal("GB_Menu_Announce_Option"..i.."_Text"):SetText(i);
		getglobal("GB_Menu_Announce_Option"..i):SetWidth(20);
	end
	GB_Menu_Announce:SetWidth(30);
end

function GB_Initialize_AnnounceOptions()
	GB_AnnounceOptions_Text1:SetText(GB_Settings[GB_INDEX].announcements[1]);
	GB_AnnounceOptions_Text2:SetText(GB_Settings[GB_INDEX].announcements[2]);
	GB_AnnounceOptions_Text3:SetText(GB_Settings[GB_INDEX].announcements[3]);
	GB_AnnounceOptions_Text4:SetText(GB_Settings[GB_INDEX].announcements[4]);
	GB_AnnounceOptions_Text5:SetText(GB_Settings[GB_INDEX].announcements[5]);
	GB_AnnounceOptions_FailedText:SetText(GB_Get("failedText"));
	GB_AnnounceOptions_InterruptedText:SetText(GB_Get("interruptedText"));
	if (not GB_Settings[GB_INDEX].announceChannel) then
		GB_Settings[GB_INDEX].announceChannel = "";
	end
	GB_AnnounceOptions_AnnounceChannel:SetText(GB_Get("announceChannel"));
	if (GB_Get("announceInterrupted")) then
		GB_AnnounceOptions_AnnounceInterrupts:SetChecked(1);
	end
	if (GB_Get("sendToChannel")) then
		GB_AnnounceOptions_SendToChannel:SetChecked(1);
	end
	if (GB_Get("announceFailed")) then
		GB_AnnounceOptions_AnnounceFailures:SetChecked(1);
	end
	if (GB_Get("doNotUseSay")) then
		GB_AnnounceOptions_DoNotUseSay:SetChecked(1);
	end
	if (GB_Get("doNotUseParty")) then
		GB_AnnounceOptions_DoNotUseParty:SetChecked(1);
	end
	if (GB_Get("doNotUseRaid")) then
		GB_AnnounceOptions_DoNotUseRaid:SetChecked(1);
	end
	if (GB_Get("doNotAnnounceSolo")) then
		GB_AnnounceOptions_DoNotAnnounceSolo:SetChecked(1);
	end
	if (GB_Get("announceDisabled")) then
		GB_AnnounceOptions_TurnOffAllAnnouncements:SetChecked(1);
	end
end

function GB_Initialize_ClickboxMenu()
	local width = 0;
	for i, v in GB_CLICKBOX_MENU do
		local option = getglobal("GB_Menu_Clickboxes_Option"..i);
		option.index = v.value;
		getglobal(option:GetName().."_Text"):SetText(v.text);
		local textwidth = getglobal(option:GetName().."_Text"):GetWidth();
		if (textwidth > width) then
			width = textwidth;
		end
	end
	for i=1,5 do
		getglobal("GB_Menu_Clickboxes_Option"..i):SetWidth(width);
	end
	GB_Menu_Clickboxes:SetWidth(width + 20);
end

function GB_Initialize_ContextMenu()
	local width = 0;
	for i, value in GB_CONTEXTS do
		local option = getglobal("GB_Menu_Contexts_Option"..i);
		option.index = value.index;
		getglobal(option:GetName().."_Text"):SetText(value.text);
		local textwidth = getglobal(option:GetName().."_Text"):GetWidth();
		if (textwidth > width) then
			width = textwidth;
		end
	end
	for i=1,15 do
		getglobal("GB_Menu_Contexts_Option"..i):SetWidth(width);
	end
	GB_Menu_Contexts:SetWidth(width + 20);
end

function GB_Initialize_CopyBarMenu()
	local width = 0;
	for i,v in GB_COPYBAR_MENU do
		getglobal("GB_Menu_CopyBar_Option"..i).value = v.value;
		local option = getglobal("GB_Menu_CopyBar_Option"..i.."_Text");
		option:SetText(v.text);
		if (option:GetWidth() > width) then
			width = option:GetWidth();
		end
	end
	for i=1,5 do
		getglobal("GB_Menu_CopyBar_Option"..i):SetWidth(width);
	end
	GB_Menu_CopyBar:SetWidth(width + 20);
end

function GB_Initialize_DefaultSettings()
	GB_Settings[GB_INDEX] = {
			Initialized = { ["4.0"] = true },
			barsLocked = true,
			buttonsLocked = true,
			showLabels = false,
			showEmpty = false,
			hideAllBlessings = false,
			hideClickboxes = false,
			hideBaseBindings = false,
			hideDynamicBindings = false,
			healthThresholds = {0,0,0,0},
			manaThreshold = 0,
			aeThreshold = 0,
			numPastAEThreshold = 3,
			POthreshold = 0,
			cancelHealThreshold = 0,
			announcements = { GB_DEFAULT_ANNOUNCE_TEXT, "", "" },
			announceFailed = true,
			announceInterrupted = true,
			failedText = GB_TEXT.DefaultFailedText,
			interruptedText = GB_TEXT.DefaultInterruptedText,
			doNotUseSay = true,
			doNotUseParty = false,
			doNotUseRaid = false,
			disableTooltip = false,
			dontAttack = false,
			dontTargetPet = false,
			disableGBSpam = false,
			disableCantDoYetSpam = false,
			disableActionInProgressSpam = false,
			disableOutOfRangeSpam = false,
			announceDisabled = false,
			Undisable = nil
		};
	for unit in GB_UNITS_ARRAY do
		GB_Settings[GB_INDEX][unit] = {
				Button = {},
				alpha = 1,
				buttonSize = 30,
				hide = false,
				rows = 1,
				collapse = false,
				spacing = 0,
				attach = false,
				attachPoint = "TOPLEFT",
				attachTo = "BOTTOMLEFT",
				xoffset = 0,
				yoffset = 0,
				mouseover = false,
				clickCast = {},
				Clickbox = { x1=0, x2=0, y1=0, y2=0 }
			};
		for i=1, 20 do
			GB_Settings[GB_INDEX][unit].Button[i] = GB_Get_DefaultButtonSettings();
		end
	end
end

function GB_Initialize_FormsMenu()
	local numForms = GetNumShapeshiftForms();
	getglobal("GB_Menu_Forms_Option0_Text"):SetText(GB_TEXT.NoForm);
	local width = getglobal("GB_Menu_Forms_Option0_Text"):GetWidth();
	for i=1, 10 do
		local option = getglobal("GB_Menu_Forms_Option"..i.."_Text");
		if (i > numForms) then
			getglobal("GB_Menu_Forms_Option"..i):Hide();
		else
			local _, name = GetShapeshiftFormInfo(i);
			option:SetText(name);
			if (option:GetWidth() > width) then
				width = option:GetWidth()
			end
		end
	end
	for i=0, 10 do
		getglobal("GB_Menu_Forms_Option"..i):SetWidth(width);
	end
	getglobal("GB_Menu_Forms_Option99"):SetWidth(width);
	if (width == 0) then
		width = 50;
		numForms = 1;
	end
	GB_Menu_Forms:SetWidth(width + 20);
	GB_Menu_Forms:SetHeight((numForms + 2) * 15 + 20);
end

function GB_Initialize_Labels()
	local label, labeltext, text, name;
	for unit, value in GB_UNITS_ARRAY do
		for index in value.frames do
			label = getglobal(value.frames[index].."_Label");
			labeltext = getglobal(value.frames[index].."_Label_Text");
			text = value.labels[index];
			if (unit == "raid") then
				name = UnitName("raid"..index);
				if (name) then
					text = name;
				end
			end
			labeltext:SetText(text);
			label:SetWidth(labeltext:GetWidth() + 10);
		end
	end
end

function GB_Initialize_Menus()
	GB_Initialize_AnchorsMenu();
	GB_Initialize_AnnounceNumMenu();
	GB_Initialize_ClickboxMenu();
	GB_Initialize_ContextMenu();
	GB_Initialize_CopyBarMenu();
	GB_Initialize_FormsMenu();
	GB_Initialize_NumPartyMenu();
	GB_Initialize_OutOfContextMenu();
end

function GB_Initialize_MiscOptions()
	if (GB_Get("dontAttack")) then
		GB_MiscOptions_DoNotAttack:SetChecked(1);
	end
	if (GB_Get("dontTargetPet")) then
		GB_MiscOptions_DoNotTargetPet:SetChecked(1);
	end
	if (GB_Get("disableTooltip")) then
		GB_MiscOptions_DisableTooltip:SetChecked(1);
	end
	if (GB_Get("disableGBSpam")) then
		GB_MiscOptions_DisableGroupButtonsSpam:SetChecked(1);
	end
	if (GB_Get("disableCantDoYetSpam")) then
		GB_MiscOptions_DisableCantDoYetSpam:SetChecked(1);
	end
	if (GB_Get("disableActionInProgressSpam")) then
		GB_MiscOptions_DisableActionInProgressSpam:SetChecked(1);
	end
	if (GB_Get("disableOutOfRangeSpam")) then
		GB_MiscOptions_DisableOutOfRangeSpam:SetChecked(1);
	end
	if (GB_Get("hideBaseBindings")) then
		GB_MiscOptions_HideBaseKeybindings:SetChecked(1);
	end
	if (GB_Get("hideDynamicBindings")) then
		GB_MiscOptions_HideDynamicKeybindings:SetChecked(1);
	end
	if (GB_Get("disablePartyRange")) then
		GB_MiscOptions_DisablePartyRange:SetChecked(1);
	end
	if (GB_Get("includePets")) then
		GB_MiscOptions_IncludePets:SetChecked(1);
	end
	if (GB_Get("includeRaid")) then
		GB_MiscOptions_IncludeRaid:SetChecked(1);
	end
	if (GB_Get("showCooldown")) then
		GB_MiscOptions_ShowCooldown:SetChecked(1);
	end
	if (GB_Get("applyPOonCtrl")) then
		GB_MiscOptions_ApplyPOonCtrl:SetChecked(1);
	end
	if (GB_Get("hideInRaid")) then
		GB_MiscOptions_HideInRaid:SetChecked(1);
	end
	if (GB_Get("changeTarget")) then
		GB_MiscOptions_ChangeTarget:SetChecked(1);
	end
	if (GB_Get("modifybyUIscale")) then
		GB_MiscOptions_ModifyByUIScale:SetChecked(1);
	end
	if (GB_Get("autoleaveform")) then
		GB_MiscOptions_AutoCancelForm:SetChecked(1);
	end
	if (GB_Get("limitlhrange")) then
		GB_MiscOptions_LimitLHRange:SetChecked(1);
	end
	if (GB_Get("limitaerange")) then
		GB_MiscOptions_LimitARange:SetChecked(1);
	end
	GB_MiscOptions_OORColor:SetBackdropColor(GB_Settings[GB_INDEX].OORcolor.r, GB_Settings[GB_INDEX].OORcolor.g, GB_Settings[GB_INDEX].OORcolor.b);
	GB_MiscOptions_OOMColor:SetBackdropColor(GB_Settings[GB_INDEX].OOMcolor.r, GB_Settings[GB_INDEX].OOMcolor.g, GB_Settings[GB_INDEX].OOMcolor.b);
	GB_MiscOptions_GreyColor:SetBackdropColor(GB_Settings[GB_INDEX].greycolor.r, GB_Settings[GB_INDEX].greycolor.g, GB_Settings[GB_INDEX].greycolor.b);
	GB_MiscOptions_HealingBonus:SetText(GB_Settings[GB_INDEX].HealingBonus);
end

function GB_Initialize_NumPartyMenu()
	for i=1,5 do
		getglobal("GB_Menu_NumParty_Option"..i.."_Text"):SetText(i);
		getglobal("GB_Menu_NumParty_Option"..i):SetWidth(30);
	end
	GB_Menu_NumParty:SetWidth(30);
end

function GB_Initialize_OutOfContextMenu()
	local width = 0;
	for i=1,3 do
		local optiontext = getglobal("GB_Menu_OutOfContext_Option"..i.."_Text");
		optiontext:SetText(GB_OOC_MENU[i].text);
		getglobal("GB_Menu_OutOfContext_Option"..i).value = GB_OOC_MENU[i].value;
		if (optiontext:GetWidth() > width) then
			width = optiontext:GetWidth();
		end
	end
	for i=1,3 do
		getglobal("GB_Menu_OutOfContext_Option"..i):SetWidth(width);
	end
	GB_Menu_OutOfContext:SetWidth(width + 20);
end

function GB_Initialize_ThresholdsOptions()
	GB_ThresholdsOptions_HealthThreshold1:SetText(GB_Settings[GB_INDEX].healthThresholds[1]);
	GB_ThresholdsOptions_HealthThreshold2:SetText(GB_Settings[GB_INDEX].healthThresholds[2]);
	GB_ThresholdsOptions_HealthThreshold3:SetText(GB_Settings[GB_INDEX].healthThresholds[3]);
	GB_ThresholdsOptions_HealthThreshold4:SetText(GB_Settings[GB_INDEX].healthThresholds[4]);
	GB_ThresholdsOptions_ManaThreshold:SetText(GB_Get("manaThreshold"));
	GB_ThresholdsOptions_AreaHealThreshold:SetText(GB_Get("aeThreshold"));
	GB_ThresholdsOptions_NumPartyToCheck_Setting:SetText(GB_Get("numPastAEThreshold"));
	GB_ThresholdsOptions_CancelHealThreshold:SetText(GB_Get("cancelHealThreshold"));
end

function GB_Initialize_Toggles()
	if (not GB_Get("barsLocked")) then
		GB_LockBars_Button:SetText(GB_TEXT.LockBars);
	end
	if (not GB_Get("buttonsLocked")) then
		GB_LockButtons_Button:SetText(GB_TEXT.LockButtons);
	end
	if (GB_Get("showEmpty")) then
		GB_ShowEmpty_Button:SetText(GB_TEXT.HideEmpty);
	end
	if (GB_Get("showLabels")) then
		GB_Labels_Show();
		GB_ShowLabels_Button:SetText(GB_TEXT.HideLabels);
	end
	if (GB_Get("hideClickboxes")) then
		GB_Set("hideClickboxes", false);
		GB_Toggle_Clickboxes();
	end
end

function GB_Parse_Tooltip(filter)
	local value;
	for i = 1, 30 do
		local textleft = getglobal("GBTooltipTextLeft"..i):GetText();
		local textright = getglobal("GBTooltipTextRight"..i):GetText();
		local text;
		if (textleft and textright) then
			text = textleft.." "..textright
		elseif (textleft) then
			text = textleft
		elseif (textright) then
			text = textright
		end
		if (text) then
			_,_,value = string.find(text, filter);
		end
		if (value) then break; end
	end
	return value;
end

function GB_RegisterWithMyAddons()
	if (myAddOnsFrame) then
		myAddOnsList.GroupButtons = {
			name = "Group Buttons", 
			description = "Adds hotbars connected to different targets",
			version = GB_VERSION,
			category = MYADDONS_CATEGORY_BARS,
			frame = "GroupButtonsFrame",
			optionsframe = "GB_Options"};
	end
end

function GB_Update_ContainerItems(counttoggle)
	if (not GB_INITIALIZED) then return; end
	GB_ITEMS = {};
	for bag = 0,  4 do
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots) then
			for slot = 1, bagslots do
				local itemName = GB_Get_ItemName(bag, slot);
				if (itemName) then
					GB_ITEMS[itemName] = { bag = bag, slot = slot};
				end
			end
		end
	end
	if (not counttoggle) then
		for bar in GB_UNITS_ARRAY do
			for button = 1, 20 do
				local idType = GB_Settings[GB_INDEX][bar].Button[button].idType;
				local name = GB_Settings[GB_INDEX][bar].Button[button].name;
				if (idType == "inv" and (not GB_INVENTORY[name])) then
					if (GB_ITEMS[name]) then
						GB_Settings[GB_INDEX][bar].Button[button].idType = "item";
					else
						GB_Settings[GB_INDEX][bar].Button[button] = GB_Get_DefaultButtonSettings();
					end
				elseif (idType == "item" and (not GB_ITEMS[name])) then
					if (GB_INVENTORY[name]) then
						GB_Settings[GB_INDEX][bar].Button[button].idType = "inv";
					else
						GB_Settings[GB_INDEX][bar].Button[button] = GB_Get_DefaultButtonSettings();
					end
				end
				if (idType == "item" or idType == "inv") then
					GB_ActionButton_SetCount(bar, button);
				end
			end
		end
	end
end

function GB_Update_FrameLocations()
	for frame, offset in GB_Settings[GB_INDEX].frameLocs do
		getglobal(frame):ClearAllPoints();
		getglobal(frame):SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", offset.x, offset.y);
	end
end

function GB_Update_InventoryItems()
	if (not GB_INITIALIZED) then return; end
	GB_INVENTORY = {};
	local slots = { "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot", "RangedSlot", "AmmoSlot" };
	for _,slot in slots do
		local slotId, texture = GetInventorySlotInfo(slot);
		local name = GB_Get_ItemName(slotId);
		if (name) then
			local count = GetInventoryItemCount("player", slotId);
			GB_INVENTORY[name] = { slot = slot, id = slotId, texture = texture, count = count };
		end
	end
end

function GB_Update_Macros()
	GB_MACROS = {};
	local base, character = GetNumMacros();
	for i=1, base do
		local name, texture, body = GetMacroInfo(i);
		if (name) then
			GB_MACROS[name] = { id=i, texture = texture, body = body };	
		end
	end
	for i=19, 18 + character do
		local name, texture, body = GetMacroInfo(i);
		if (name) then
			GB_MACROS[name] = { id=i, texture = texture, body = body };	
		end
	end
end

function GB_Update_RaidMemberSelect()
	local unit, rms, name, class, level, fileName, color;
	for i=1,40 do
		unit = "raid"..i;
		rms = "GB_RaidMemberSelect"..i;
		if (UnitExists(unit) and UnitName(unit)) then
			getglobal(rms):Show();
			name = UnitName(unit);
			_, _, _, level, class, fileName = GetRaidRosterInfo(i);
			color = RAID_CLASS_COLORS[fileName];
			if (color) then
				getglobal(rms.."_Label"):SetTextColor(color.r, color.g, color.b);
			end
			if (not level) then level = ""; end
			if (not class) then class = ""; end
			getglobal(rms.."_Label"):SetText(name.." ("..level.." "..class..")");
			if (GB_RAID_MEMBERS[name]) then
				getglobal(rms):SetChecked(1);
			else
				getglobal(rms):SetChecked(0);
			end
		else
			getglobal(rms):Hide();
		end
	end
	GB_RAID_MEMBERS = {nil};
	for i=1,GetNumRaidMembers() do
		rms = getglobal("GB_RaidMemberSelect"..i);
		if (rms:GetChecked()) then
			if (UnitName("raid"..i)) then
				GB_RAID_MEMBERS[UnitName("raid"..i)] = true;
			else
				rms:SetChecked(0);
			end
		end
	end
end

function GB_Update_Spells(forceupdate)
	if (not GB_INITIALIZED) then return; end
	local spellID = 1;
	while true do
		local spellName, spellRank = GetSpellName(spellID, BOOKTYPE_SPELL);
		if not spellName then
			do break end
		end

		local skipspell;
		if (not GB_SPELLS[spellName]) then
			GB_SPELLS[spellName] = {};
		elseif (GB_SPELLS[spellName][spellRank]) then
			GB_SPELLS[spellName][spellRank].id = spellID;
			skipspell = 1;
		end
		if (forceupdate or (not skipspell)) then
			local spellMana, spellRage, spellEnergy, spellType, spellMin, spellMax, spellCastingTime, spellAvg, spellDuration, otamt;

			GBTooltip:SetSpell(spellID, SpellBookFrame.bookType);
			local textleft, textright, text;
			for i = 1, 30 do
				if (getglobal("GBTooltipTextLeft"..i):IsShown()) then
					textleft = getglobal("GBTooltipTextLeft"..i):GetText();
				else
					textleft = nil;
				end
				if (getglobal("GBTooltipTextRight"..i):IsShown()) then
					textright = getglobal("GBTooltipTextRight"..i):GetText();
				else
					textright = nil;
				end
				if (textleft and textright) then
					text = textleft.." "..textright
				elseif (textleft) then
					text = textleft
				elseif (textright) then
					text = textright
				end
				if (text) then
					if (not spellMana) then
						_,_,spellMana = string.find(text, GB_FILTERS.Mana);
					end
					if (not spellRage) then
						_,_,spellRage = string.find(text, GB_FILTERS.Rage);
					end
					if (not spellEnergy) then
						_,_,spellEnergy = string.find(text, GB_FILTERS.Energy);
					end
					if (not spellMin) then
						_,_,spellMin,spellMax = string.find(text, GB_FILTERS.To);
						if (spellMin and spellMax) then
							string.gsub(spellMin, ',', '.');
							string.gsub(spellMax, ',', '.');
							spellMin = tonumber(spellMin);
							spellMax = tonumber(spellMax);
						end
					end
					if (string.find(string.upper(text), GB_FILTERS.Heal)) then
						if (string.find(text, GB_FILTERS.HealOverTime)) then
							_,_,otamt,spellDuration = string.find(text, GB_FILTERS.HealOverTime);
							if (otamt) then string.gsub(otamt, ',', '.'); end
							otamt = tonumber(otamt);
							if (otamt) then
								spellType = "HoT";
								if (not spellMax) then
									spellMin, spellMax = otamt, otamt;
								elseif (spellType ~= "HoT") then
									spellType = "heal";
								end
							end
						elseif (string.find(text, GB_FILTERS.DruidHealOverTime)) then
							_,_,otamt,spellDuration = string.find(text, GB_FILTERS.DruidHealOverTime);
							if (otamt) then string.gsub(otamt, ',', '.'); end
							otamt = tonumber(otamt);
							if (otamt) then
								spellType = "HoT";
								if (not spellMax) then
									spellMin, spellMax = otamt, otamt;
								elseif (spellType ~= "HoT") then
									spellType = "heal";
								end
							end
						elseif (spellType ~= "HoT") then
							spellType = "heal";
						end
					elseif (string.find(text, GB_FILTERS.Damage) or string.find(string.upper(text), GB_FILTERS.Damage)) then
						if (string.find(text, GB_FILTERS.DamageOverTime)) then
							_,_,otamt,spellDuration = string.find(text, GB_FILTERS.DamageOverTime);
							if (otamt) then string.gsub(otamt, ',', '.'); end
							otamt = tonumber(otamt);
							if (otamt) then
								spellType = "DoT";
								if (not spellMax) then
									spellMin, spellMax = otamt, otamt;
								elseif (spellType ~= "DoT") then
									spellType = "damage";
								end
							end
						elseif (spellType ~= "DoT") then
							spellType = "damage";
						end
					end
					if (not spellCastingTime) then
						_,_,spellCastingTime = string.find(text, GB_FILTERS.CastingTime);
					end
				end
			end

			if (not spellMana) then
				if (spellRage) then
					spellMana = spellRage;
				elseif (spellEnergy) then
					spellMana = spellEnergy;
				end
			end
			if (not spellMana) then
				spellMana = 0;
			else
				spellMana = tonumber(spellMana);
			end
			if (not spellCastingTime) then
				spellCastingTime = 0;
			else
				string.gsub(spellCastingTime, ',', '.');
				spellCastingTime = tonumber(spellCastingTime);
				if (not spellCastingTime) then
					spellCastingTime = 0;
				end
			end
			spellMin = tonumber(spellMin);
			if (not spellMin) then
				spellMin = 0;
			end
			spellMax = tonumber(spellMax);
			if (not spellMax) then
				spellMax = 0;
			end
			if (spellType == "heal" or spellType == "HoT") then
				local ct = spellCastingTime;
				if (ct == 0) then
					ct = 3.5;
				end
				local bonus = (spellCastingTime / 3.5) * GB_Settings[GB_INDEX].HealingBonus;
				spellMin = spellMin + bonus;
				spellMax = spellMax + bonus;
			end
			spellAvg = (spellMin + spellMax) / 2;
			if (not spellDuration) then
				spellDuration = 0;
			end

			for _,v in GB_CURES do
				if (v.text == spellName) then
					spellType = "cure";
					break;
				end
			end
			if (spellType ~= "cure" and spellType ~= "HoT") then
				for _,v in GB_MINLVL_SPELLS do
					if (v == spellName) then
						spellType="buff";
						break;
					end
				end
			end

			GB_SPELLS[spellName][spellRank] = {
				id = spellID,
				mana = spellMana,
				type = spellType,
				min = spellMin,
				max = spellMax,
				avg = spellAvg,
				castingTime = spellCastingTime,
				duration = spellDuration
			};
		end

		spellID = spellID + 1;
	end

	GB_SPELLS_COUNT = spellID - 1;
	GB_Update_SpellRanges();

	for bar, value in GB_UNITS_ARRAY do
		for button = 1, 20 do
			if (GB_Settings[GB_INDEX][bar].Button[button].idType == "spell") then
				if (not GB_SPELLS[GB_Settings[GB_INDEX][bar].Button[button].name]) then
					GB_Settings[GB_INDEX][bar].Button[button] = GB_Get_DefaultButtonSettings();
					GB_ActionButton_Initialize(bar, button);
				end
			end
		end
	end
end

function GB_Update_SpellRanges(forceupdate)
	local match;
	for spellname, ranks in GB_SPELLS do
		for spellrank,spell in ranks do
			if (forceupdate or (not GB_SPELLS[spellname][spellrank].range)) then
				local texture = GetSpellTexture(spell.id, "BOOKTYPE_SPELL");
				GBTooltip:ClearLines();
				GBTooltip:SetSpell(spell.id, SpellBookFrame.bookType);
				local range = GB_Parse_Tooltip(GB_FILTERS.Range);
				GB_SPELLS[spellname][spellrank].rangeinyds = range;
				for i=120, 1, -1 do
					local abtexture = GetActionTexture(i);
					if (abtexture == texture) then
						match = i;
						break;
					end
					GBTooltip:ClearLines();
					GBTooltip:SetAction(i);
					local abrange = GB_Parse_Tooltip(GB_FILTERS.Range);
					if (abrange == range) then
						match = i;
					end
				end
				GB_SPELLS[spellname][spellrank].range = match;
			end
		end
	end
end

