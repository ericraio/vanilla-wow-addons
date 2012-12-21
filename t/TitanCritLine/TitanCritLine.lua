-------------------------------------------------------------------------------
--                              Titan [CritLine]                             --
-------------------------------------------------------------------------------
--[[
VERSION HISTORY:

Titan [CritLine] v0.3.7
-Fixed an bug with DE and FR clients.

Titan [CritLine] v0.3.6
-Fixed an bug with DE client.

Titan [CritLine] v0.3.5
-Fixed an bug with DE clients crits not working.
-Fixed a bug with french text on the settings menu.

Titan [CritLine] v0.3.4
-Fixed an error with the French clients recording one hit as a Crit and Normal hit.
-Settings menu translated to French and German.
-Changed default for Level Adjustment to be off.

Titan [CritLine] v0.3.3
-Attempts to repair saved data information.
-Fixed an issue with French clients not recording hits.

Titan [CritLine] v0.3.2
-Fixed an issue with German clients not recording hits.
-Added Right-Click menu to toggle Icon/Text.
-Added better error handling and error recovery.

Titan [CritLine] v0.3.1
-Added command to rebuild data structure.
-Change archive format to .zip.

Titan [CritLine] v0.3
-Added level range filter.
-Added attack type to splash screen message (e.g. 'New Ambush Record!')
-Cleaned up summary tooltip.
-Added healing spells.

Titan [CritLine] v0.2
-Added settings menu
-Added Detailed summary for high damage attacks (ToolTip)
-Toggle for ScreenShot on new damage records.
-Toggle for counting PvP damage only.
-Toggle for sound
-Toggle Splash Screen

Titan [CritLine] v0.1
-Initial Release
]]
-------------------------------------------------------------------------------

DEBUG = false; --A flag for outputting debug info to the console.

TITAN_CRITLINE_ID =  "CritLine";
TITAN_CRITLINE_VERSION = " v0.3.5";

TITAN_CRITLINE_BUTTON_LABEL = "CL: ";
TITAN_CRITLINE_BUTTON_ICON = "Interface\\AddOns\\TitanCritLine\\TitanCritLine";
TITAN_CRITLINE_BUTTON_TEXT = "%s/%s";

HEADER_TEXT_COLOR  = "|cffffffff"; --White
SUBHEADER_TEXT_COLOR  = "|cffCEA208"; --Gold
BODY_TEXT_COLOR  = "|cffffffff"; --?White?
HINT_TEXT_COLOR  = "|cff00ff00"; --Green

TitanCritLine_PlayerRealm = "";
TitanCritLine_PlayerName = "";
TitanCritLine_PlayerRealmName = "";

DAMAGE_TYPE_NONHEAL = "0";
DAMAGE_TYPE_HEAL =  "1";

-------------------------------------------------------------------------------
function TitanCritLine_DisplaySettings()

	--display a settings menu;
	TitanCritLine_SettingsFrameTitle:SetText(COLOR(HEADER_TEXT_COLOR, TITAN_CRITLINE_ID.." Settings"));

	TitanCritLine_SettingsFrame_Option1Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_SPLASH_TEXT));
	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SPLASH"] == "1" ) then
		TitanCritLine_SettingsFrame_Option1:SetChecked(true);
	end

	TitanCritLine_SettingsFrame_Option2Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_PLAYSOUNDS_TEXT));
	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PLAYSOUND"] == "1" ) then
		TitanCritLine_SettingsFrame_Option2:SetChecked(true);
	end

	TitanCritLine_SettingsFrame_Option3Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_PVPONLY_TEXT));
	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PVPONLY"] == "1" ) then
		TitanCritLine_SettingsFrame_Option3:SetChecked(true);
	end

	TitanCritLine_SettingsFrame_Option4Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_SCREENCAP_TEXT));
	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SNAPSHOT"] == "1" ) then
		TitanCritLine_SettingsFrame_Option4:SetChecked(true);
	end

	TitanCritLine_SettingsFrame_Option5Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_LVLADJ_TEXT));
	if ( tonumber(TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["LVLADJ"]) > 0 ) then
		TitanCritLine_SettingsFrame_Option5:SetChecked(true);
	end

	TitanCritLine_SettingsFrame_Option6Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_FILTER_HEALING_TEXT));
	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["FILTER_HEALING"] == "1" ) then
		TitanCritLine_SettingsFrame_Option6:SetChecked(true);
	end

	TitanCritLine_SettingsFrame_Reset:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_RESET_TEXT));

	TitanCritLine_SettingsFrame:Show();
end
-------------------------------------------------------------------------------
function TitanPanelRightClickMenu_PrepareCritLineMenu()
	
	local id = TITAN_CRITLINE_ID;
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText..TITAN_CRITLINE_VERSION);

	local info = {};
	info.text = "Settings";
	info.func = TitanCritLine_DisplaySettings;
	--info.checked = TitanGetVar(id, "ShowUsedSlots");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddToggleIcon(id);
	TitanPanelRightClickMenu_AddToggleLabelText(id);
	
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
end
-------------------------------------------------------------------------------
function COLOR(color, msg)
	return color..msg..FONT_COLOR_CODE_CLOSE;
end
-------------------------------------------------------------------------------
function TitanCritLine_OnClick(button)
	if (button == "LeftButton") then
		TitanCritLine_DisplaySettings();
	end
end
-------------------------------------------------------------------------------
function TitanPanelCritLine_GetButtonText(id)	
	local buttonRichText = format(TITAN_CRITLINE_BUTTON_TEXT, COLOR(BODY_TEXT_COLOR, TitanCritLine_GetHighestDamage()), COLOR(BODY_TEXT_COLOR, TitanCritLine_GetHighestCrit()));

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["FILTER_HEALING"] == "0") then
		buttonRichText = buttonRichText.." - "..format(TITAN_CRITLINE_BUTTON_TEXT, COLOR(BODY_TEXT_COLOR, TitanCritLine_GetHighestHeal()), COLOR(BODY_TEXT_COLOR, TitanCritLine_GetHighestHealCrit()));
	end

	TitanCritLine_DEBUG("TitanPanelCritLine_GetButtonText: "..TITAN_CRITLINE_BUTTON_LABEL..buttonRichText);
	return TITAN_CRITLINE_BUTTON_LABEL, buttonRichText;
end
-------------------------------------------------------------------------------
function TitanCritLine_OnLoad()

	this.registry = { 
		id = TITAN_CRITLINE_ID,
		menuText = TITAN_CRITLINE_ID, 
		buttonTextFunction = "TitanPanelCritLine_GetButtonText", 
		tooltipTitle = "CritLine Summary"..TITAN_CRITLINE_VERSION,
		tooltipTextFunction = "TitanCritLine_GetSummaryRichText", 
		icon = TITAN_CRITLINE_BUTTON_ICON,	
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	};

	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");

	--Healing Messages
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF"); --On Self
	--this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF"); --On Friendly
	--this:RegisterEvent("CHAT_MSG_SPELL_PET_BUFF"); --On Pet

	DEFAULT_CHAT_FRAME:AddMessage(TITAN_CRITLINE_ID.." "..TITAN_CRITLINE_VERSION.." loaded.");

end
-------------------------------------------------------------------------------

function TitanCritLine_OnEvent()
	TitanCritLine_DEBUG("Received Event: "..event);
		
	if (event == "PLAYER_ENTERING_WORLD") then
		TitanCritLine_Initialize();
		TitanPanelButton_UpdateButton(TITAN_CRITLINE_ID);	
		TitanPanelButton_UpdateTooltip();
	
	elseif (event == "CHAT_MSG_SPELL_SELF_BUFF") then
		if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["FILTER_HEALING"] == "0") then
			for attacktype, creaturename, damage in string.gfind(arg1, HEAL_SPELL_CRIT_MSG) do
				TitanCritLine_RecordHit(attacktype, "CRIT", tonumber(damage), creaturename, DAMAGE_TYPE_HEAL);
				return;
			end
			for attacktype, creaturename, damage in string.gfind(arg1, HEAL_SPELL_HIT_MSG) do
				TitanCritLine_RecordHit(attacktype, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_HEAL);
				return;
			end
		end
	elseif (event == "CHAT_MSG_COMBAT_SELF_HITS") then
		for creaturename, damage in string.gfind(arg1, COMBAT_CRIT_MSG)do
			TitanCritLine_DEBUG("Crit Hit: "..creaturename.." for "..damage);
			TitanCritLine_RecordHit(NORMAL_HIT_TEXT, "CRIT", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);			
			return;
		end

		for creaturename, damage in string.gfind(arg1, COMBAT_HIT_MSG) do
			TitanCritLine_DEBUG("Regular Hit: "..creaturename.." for "..damage);
			TitanCritLine_RecordHit(NORMAL_HIT_TEXT, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end



	elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		for attacktype, creaturename, damage in string.gfind(arg1, SPELL_CRIT_MSG) do
			TitanCritLine_RecordHit(attacktype, "CRIT", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end

		for attacktype, creaturename, damage in string.gfind(arg1, SPELL_HIT_MSG) do
			TitanCritLine_RecordHit(attacktype, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end

	end
end
-------------------------------------------------------------------------------
function TitanCritLine_Rebuild()
	DEFAULT_CHAT_FRAME:AddMessage(TITAN_CRITLINE_ID.." "..TITAN_CRITLINE_VERSION.." rebuilding data.");
	TitanCritLineSettings[TitanCritLine_PlayerRealmName] = nil;
	TitanCritLine_Initialize();
	DEFAULT_CHAT_FRAME:AddMessage(TITAN_CRITLINE_ID.." "..TITAN_CRITLINE_VERSION.." rebuilding data complete.");
end
-------------------------------------------------------------------------------
function TitanCritLine_Initialize()

	TitanCritLine_DEBUG("Initializing...");

	TitanCritLine_PlayerRealm = GetCVar("realmName");
	TitanCritLine_PlayerName = UnitName("player");
	TitanCritLine_PlayerRealmName = TitanCritLine_PlayerRealm.."."..TitanCritLine_PlayerName;

	if (TitanCritLineSettings == nil) then
		TitanCritLineSettings = {};
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName] == nil) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName] = {};
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"] == nil) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"] = {};
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["FILTER_HEALING"] == nil) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["FILTER_HEALING"] = "1";
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["LVLADJ"] == nil) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["LVLADJ"] = "0";
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SPLASH"] == nil) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SPLASH"] = "1";
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PVPONLY"] == nil) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PVPONLY"] = "0";
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PLAYSOUND"] == nil) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PLAYSOUND"] = "1";
	end
	
	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SNAPSHOT"] == nil) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SNAPSHOT"] = "0";
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"] == nil) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"] = {};
	end

	TitanCritLine_DEBUG("Initialization Complete.");

end
-------------------------------------------------------------------------------
function TitanCritLine_RecordHit(AttackType, HitType, Damage, uname, IsHealing)

	local targetlvl = UnitLevel("target");
	if (targetlvl == nil) then targetlvl = 0; end

	if (Damage == nil) then
		TitanCritLine_DEBUG("No Damage! exiting...");
		return;
	end
	if (uname == nil) then uname = "??"; end
	if (UnitLevel("target") == nil) then
		TitanCritLine_DEBUG("No Target! exiting...");
		return;
	end
	if (uname == nil) then uname = "??"; end
	if (IsHealing == nil) then
		TitanCritLine_DEBUG("IsHealing==nil! exiting...");
		return;
	end
	
	if ( (UnitIsPlayer("target") ~= 1) and (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PVPONLY"] == "1") ) then
		TitanCritLine_DEBUG("Target !=player and PvPOnly enabled, exiting...");
		return;
	end

	--Determine Level Difference
	local leveldiff = 0;
	if (UnitLevel("player") < UnitLevel("target")) then
		leveldiff = (UnitLevel("target") - UnitLevel("player"));
	else
		leveldiff = (UnitLevel("player") - UnitLevel("target"));
	end
	
	TitanCritLine_DEBUG("Level difference: "..leveldiff);

	if ( (tonumber(TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["LVLADJ"]) ~= 0) and (tonumber(TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["LVLADJ"]) < leveldiff) ) then
		return;
	end

	if (TitanCritLineSettings == nil) then
		return;
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName] == nil) then
		TitanCritLine_DEBUG("TitanCritLineSettings[TitanCritLine_PlayerRealmName] should not be nil at this point!");
		TitanCritLine_Initialize();--attempt recovery..
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"] == nil) then
		TitanCritLine_DEBUG("TitanCritLineSettings[TitanCritLine_PlayerRealmName][DATA] should not be nil at this point!");
		TitanCritLine_Initialize(); --attempt recovery..
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType] == nil) then
		TitanCritLine_DEBUG("Creating TitanCritLineSettings["..TitanCritLine_PlayerRealmName.."][DATA]["..AttackType.."]...");
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType] = {};
	end

	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType][HitType] == nil) then
		TitanCritLine_DEBUG("Creating TitanCritLineSettings["..TitanCritLine_PlayerRealmName.."][DATA]["..AttackType.."]["..HitType.."]...");
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType][HitType] = {};
	end

	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType][HitType]["Damage"] == nil or
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType][HitType]["Damage"] < Damage ) then

		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType][HitType]["Damage"] = Damage;
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType][HitType]["Target"] = uname;
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType][HitType]["Level"] = UnitLevel("target");
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType][HitType]["Date"] = date();
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][AttackType][HitType]["IsHeal"] = IsHealing;
		TitanCritLine_DisplayNewRecord(AttackType, Damage);
	end
end
-------------------------------------------------------------------------------
function TitanCritLine_DisplayNewRecord(AttackType, DamageAmount)

	TitanCritLine_DEBUG(format(TITAN_CRITLINE_NEW_RECORD_MSG, AttackType));

	if(TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SPLASH"] == "1") then
		TitanCritLineSplashFrame:AddMessage(DamageAmount, 1, 1, 1, 1, 3);
		TitanCritLineSplashFrame:AddMessage(format(TITAN_CRITLINE_NEW_RECORD_MSG, AttackType), 1, 1, 0, 1, 3);
	end

	--Play Sound?
	if(TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PLAYSOUND"] == "1") then PlaySound("LEVELUP", 1, 1, 0, 1, 3); end

	--ScreenShot?
	if(TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SNAPSHOT"] == "1") then TakeScreenshot(); end

	--Update Button Function
	TitanPanelButton_UpdateButton(TITAN_CRITLINE_ID);

end
-------------------------------------------------------------------------------
function TitanCritLine_DisplaySummary()
	--display summary;
	--use: ScrollingMessageFrame?
	TitanCritLine_DisplayDialog(TitanCritLine_GetSummaryRichText());
end
-------------------------------------------------------------------------------
function TitanCritLine_GetSummaryRichText()
	--build the SummaryDisplay rich text and return it instead of displaying it.
	--this is used for displaying as a tooltip.

	local hicrit = TitanCritLine_GetHighestCrit();
	local hidmg = TitanCritLine_GetHighestDamage();

	--For healing
	local hihealcrit = TitanCritLine_GetHighestHealCrit();
	local hihealdmg = TitanCritLine_GetHighestHeal();

	local rtfAttack="";

	for k,v in pairs (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"]) do
		attacktype = k;
		rtfAttack = rtfAttack..COLOR(HEADER_TEXT_COLOR, attacktype).."\n";
		for k,v in pairs (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype]) do
			if (k == "NORMAL") then
				rtfAttack = rtfAttack.."  "..COLOR(SUBHEADER_TEXT_COLOR, NORMAL_TEXT).." [";
			else
				rtfAttack = rtfAttack.."  "..COLOR(SUBHEADER_TEXT_COLOR, CRIT_TEXT).." [";
			end

			if ( k == "CRIT") then
				if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["IsHeal"] == "0") then
					if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"] == hicrit) then
						rtfAttack = rtfAttack..COLOR(HINT_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"]).."]\t";
					else
						rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"]).."]\t";
					end
				else
					if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"] == hihealcrit) then
						rtfAttack = rtfAttack..COLOR(HINT_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"]).."]\t";
					else
						rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"]).."]\t";
					end
				end
			else
				if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["IsHeal"] == "0") then
					if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"] == hidmg) then
						rtfAttack = rtfAttack..COLOR(HINT_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"]).."]\t";
					else
						rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"]).."]\t";
					end
				else
					if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"] == hihealdmg) then
						rtfAttack = rtfAttack..COLOR(HINT_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"]).."]\t";
					else
						rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Damage"]).."]\t";
					end
				end

			end
			if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Level"] == -1) then
				rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Target"]).." ["..COLOR(BODY_TEXT_COLOR, "??").."]\n";
			else
				rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Target"]).." ["..COLOR(BODY_TEXT_COLOR, TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][k]["Level"]).."]\n";
			end
		end
	end
	--TitanCritLine_DEBUG("rtfAttack: "..rtfAttack);
	return rtfAttack
end
-------------------------------------------------------------------------------
function TitanCritLine_DisplayAbout()
	--Display About Dialog
	TitanCritLine_DisplayDialog(TitanCritLine_GetAboutRichText());
end
-------------------------------------------------------------------------------
function TitanCritLine_GetAboutRichText()
	--build the SummaryAbout rich text and return it instead of displaying it.
	--this is used for displaying as a tooltip.
	return 
		COLOR(HEADER_TEXT_COLOR, TITAN_CRITLINE_ID.." v"..TITAN_CRITLINE_VERSION).."\n"..
		COLOR(SUBHEADER_TEXT_COLOR, "Concept By: ".."\n".."Sordit").."\n\n"..
		COLOR(SUBHEADER_TEXT_COLOR, "Developers: ").."\n"..
			COLOR(BODY_TEXT_COLOR, "Sordit: ".."\t".."sordit@spam.com").."\n"..
			COLOR(BODY_TEXT_COLOR, "Uggh: ".."\t".."uggh@spam.com").."\n\n"..
		COLOR(BODY_TEXT_COLOR, "First off, I would like to thank Sordit for the TitanCritLine concept!").."\n"..
		COLOR(BODY_TEXT_COLOR, "It was his idea that sparked my interest in this project, and since").."\n"..
		COLOR(BODY_TEXT_COLOR, "then I have been up many nights trying to make this a great UI Mod.").."\n\n"..
		COLOR(BODY_TEXT_COLOR, "Why two versions?").."\n"..
		COLOR(BODY_TEXT_COLOR, "I prefer to have TitanCritLine as a Titan plugin, and Sordit wants it to").."\n"..
		COLOR(BODY_TEXT_COLOR, "be stand-alone. So we are working on standardizing the TitanCritLine core").."\n"..
		COLOR(BODY_TEXT_COLOR, "code for the use in both of our mod projects. By doing this, we can").."\n"..
		COLOR(BODY_TEXT_COLOR, "benefit off each other enhancements and bug fixes.").."\n\n"..
		COLOR(BODY_TEXT_COLOR, "Sordit's Stand-Alone Version:").."\n"..
		COLOR(BODY_TEXT_COLOR, "http://ui.worldofwar.net/ui.php?id=810").."\n\n"..
		COLOR(BODY_TEXT_COLOR, "Uggh's Titan Plugin Version:").."\n"..
		COLOR(BODY_TEXT_COLOR, "http://ui.worldofwar.net/ui.php?id=849");
end
-------------------------------------------------------------------------------
function TitanCritLine_SettingsOptionButton_OnClick(arg1)
	if ( arg1 == 1 ) then
		TitanCritLine_ToggleSplash();
	elseif ( arg1 == 2 ) then
		TitanCritLine_ToggleSound();
	elseif ( arg1 == 3 ) then
		TitanCritLine_TogglePvP();
	elseif ( arg1 == 4 ) then
		TitanCritLine_ToggleScreenShots();
	elseif ( arg1 == 5 ) then
		TitanCritLine_ToggleLevelAdjustment();
	elseif ( arg1 == 6 ) then
		TitanCritLine_ToggleHealing();
	end
end
-------------------------------------------------------------------------------
function TitanCritLine_ToggleLevelAdjustment()

	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["LVLADJ"] == "0" ) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["LVLADJ"] = "4";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." level adjustment on");
	else
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["LVLADJ"] = "0";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." level adjustment off");
	end
end
-------------------------------------------------------------------------------
function TitanCritLine_ToggleScreenShots()

	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SNAPSHOT"] == "0" ) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SNAPSHOT"] = "1";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." screen shots on");
	else
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SNAPSHOT"] = "0";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." screen shots off");
	end
end
-------------------------------------------------------------------------------
function TitanCritLine_ToggleSound()

	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PLAYSOUND"] == "0" ) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PLAYSOUND"] = "1";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." sound on");
	else
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PLAYSOUND"] = "0";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." sound off");
	end
end
-------------------------------------------------------------------------------
function TitanCritLine_TogglePvP()

	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PVPONLY"] == "0" ) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PVPONLY"] = "1";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." pvponly on");
	else
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["PVPONLY"] = "0";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." pvponly off");
	end
end
-------------------------------------------------------------------------------
function TitanCritLine_ToggleSplash()

	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SPLASH"] == "0" ) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SPLASH"] = "1";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." splash on");
	else
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["SPLASH"] = "0";
		info.checked = 0;
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." splash off");
	end
end
-------------------------------------------------------------------------------
function TitanCritLine_ToggleHealing()

	if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["FILTER_HEALING"] == "0" ) then
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["FILTER_HEALING"] = "1";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." filter healing on");
	else
		TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]["FILTER_HEALING"] = "0";
		TitanCritLine_DEBUG(TITAN_CRITLINE_ID.." filter healing off");
	end
end
-------------------------------------------------------------------------------
function TitanCritLine_Reset()
	TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"] = {};
	TitanPanelCritLineButtonText:SetText(TitanPanelCritLine_GetButtonText(0));
end
-------------------------------------------------------------------------------
function TitanCritLine_ResetAll()
	TitanCritLineSettings = {};
	TitanCritLine_Initialize();
	TitanPanelCritLineButtonText:SetText(TitanPanelCritLine_GetButtonText(0));
end
-------------------------------------------------------------------------------
function TitanCritLine_SettingsClose()
	TitanCritLine_SettingsFrame:Hide();
end
-------------------------------------------------------------------------------
function TitanCritLine_GetHighestCrit()
	--loop thru the Table and find the highest crit damage score and return it.
	--this is for displaying high records as "345/934" or highlighting in summary fields.
	local hidmg = 0;

	if (TitanCritLineSettings == nil) then return hidmg; end
	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName] == nil) then return hidmg; end
	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"] == nil) then return hidmg; end

	for k,v in pairs (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"]) do
		if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["CRIT"] ~= nil ) then
			if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["CRIT"]["IsHeal"] == "0" ) then
				if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["CRIT"]["Damage"] > hidmg ) then
					hidmg = TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["CRIT"]["Damage"];
				end
			end
		end
	end
	return hidmg;
end
-------------------------------------------------------------------------------
function TitanCritLine_GetHighestHealCrit()
	--loop thru the Table and find the highest crit damage score and return it.
	--this is for displaying high records as "345/934" or highlighting in summary fields.
	local hidmg = 0;

	if (TitanCritLineSettings == nil) then return hidmg; end
	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName] == nil) then return hidmg; end
	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"] == nil) then return hidmg; end

	for k,v in pairs (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"]) do
		if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["CRIT"] ~= nil ) then
			if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["CRIT"]["IsHeal"] == "1" ) then
				if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["CRIT"]["Damage"] > hidmg ) then
					hidmg = TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["CRIT"]["Damage"];
				end
			end
		end
	end
	return hidmg;
end
-------------------------------------------------------------------------------
function TitanCritLine_GetHighestDamage()
	--loop thru the Table and find the highest normal damage score and return it.
	--this is for displaying high records as "345/934" or highlighting in summary fields.
	local hidmg = 0;

	if (TitanCritLineSettings == nil) then return hidmg; end
	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName] == nil) then return hidmg; end
	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"] == nil) then return hidmg; end

	for k,v in pairs (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"]) do
		if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["NORMAL"] ~= nil ) then
			if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["NORMAL"]["IsHeal"] == "0" ) then
				if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["NORMAL"]["Damage"] > hidmg ) then
					hidmg = TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["NORMAL"]["Damage"];
				end
			end
		end
	end
	return hidmg;
end
-------------------------------------------------------------------------------
function TitanCritLine_GetHighestHeal()
	--loop thru the Table and find the highest normal damage score and return it.
	--this is for displaying high records as "345/934" or highlighting in summary fields.
	local hidmg = 0;

	if (TitanCritLineSettings == nil) then return hidmg; end
	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName] == nil) then return hidmg; end
	if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"] == nil) then return hidmg; end

	for k,v in pairs (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"]) do
		if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["NORMAL"] ~= nil ) then
			if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["NORMAL"]["IsHeal"] == "1" ) then
				if ( TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["NORMAL"]["Damage"] > hidmg ) then
					hidmg = TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][k]["NORMAL"]["Damage"];
				end
			end
		end
	end
	return hidmg;
end
-------------------------------------------------------------------------------
function TitanCritLine_DEBUG(message)
	if (DEBUG) then
		DEFAULT_CHAT_FRAME:AddMessage("DEBUG: "..message);
	end
end

function TitanCritLine_DisplayDialog(message)
	GameTooltip:SetText(message);
	GameTooltip:Show();
end