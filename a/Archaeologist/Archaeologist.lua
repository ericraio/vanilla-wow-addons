--------------------------------------------------------------------------
-- Archaeologist.lua 
--------------------------------------------------------------------------
--[[
Archaeologist 
	Unearthing Health and Mana values at a unit frame near you.

By: AnduinLothar    <KarlKFI@cosmosui.org>

Change Log:
v0.1a
-Adds Text to Unit Frame Status Bars
-Adds Dead/Offline/Ghost text to all unit frames
-Changes health bar color as it decreases
-Status bar prefix is optional
-All status text can be shown as percent or real value (except target HP which is percent from server)

v0.2a
-Fixed Slash commands not working for text.
-Sepperated Player HP/MP/XP text
-Made target percent an option so you can see true values when you target self or party member

v0.3a
-Optimized Slash and Cosmos Reg Code.
-Fixed non-Cosmos saved variables not being saved (also nil pointer bug)
-Fixed text relocation so that the HP and MP text are now slightly sepperated
-Removed partial frame replacement and replaced it with onLoad status bar initializing

v0.4a
-Fixed a hp prefix reshowing bug
-Added Pet Dead Text
-Fixed Pet MP/HP show issue

v0.5a
-TargetFrame healthbars now always display as percent unless max hp is difforent thant 100 (party, player, pet)

v0.6a
-Added 12 Buffs and 12 Debuffs for all party members and pet.
-Moved Pet Happiness to accomidate pet debuffs
-Options to Show or Hide buffs or debuffs (reverts to normal onmouseover behavior when off)
-Show anywhere between 0 and 12 Buffs or Debuffs
-Cleaned up slash command printouts
-Syncronized Cosmos with Slash Commands. Use both if you're thus inspired.

v0.7a
-Added Alternate Debuff Location.
-Added buff tooltips
-Changed Slash Command syntax
-Added Alternate HPMP text location that aligns to the outside of the bar frame.

v1.0
-Live in Cosmos!
-Spelling Errors Corrected

v1.1
-Added German Localization
-Sorting of cosmos options.
-Auto Pet Happiness Alt Location Management

v1.2
-Added French Localization
-Fixed ArchaeologistVars = nil error
-Text is now resizable from 6-20.
Note: due to a blizzard text resizing bug the text will not propperly smooth/rescale once changed.
To correct it go to windowed mode and back to fullscreen.  I have notified Blizzard of the bug.
-Made Party/Pet Buff borders green. Debuffs are still red.

v1.3
-Added 8 Buffs and 8 Debuffs for target frame.
-Target Buffs slightly rearanged. They now extend from right to left so that the 3 extra buffs don't
get covered by the portrait and elite graphics.
-Increased Pet and Party Max buffs/debuffs to 14

v1.4
-Fixed the bug that hid status text while moused over.
-Fixed the bug that hid status text while the character frame was open.

v1.41
-Implimented Smooth Text Resizing Work-around

v1.42
-Fixed a bug with loading default values from the new text sliders w/o cosmos.

v1.43
-Fixed a bigger bug with values not saving with slash commands and cosmos.

v1.5
-Made Target Buffs on top if targeting an ally and Debuffs on top if targeting an enemy.
-Added an alternate option for target buffs to display from right to left. Default is left to right.
-Fixed/Avoided MouseOver hook so that Arch plays nicely with mouse over offsets.

v1.6
-Added Optional use of the MobHealth2 addon if you are usign it.
http://www.curse-gaming.com/mod.php?addid=1087

v1.7
-Added Khaos configuration options
-Updated to work with cosmos MobHealth addon
-No longer displays 0/0 if the health is unknown
-Fixed manabar nil bug.

v1.8
-Added optional class icons to the Player, Party and Target Frames

v1.9
-Added optional replacement of unit portraits with large class icons
-Raised Target Buffs slightly to be above the Target portait
-Fixed a nil bug when using class icons on party members.

v2.0
-Updated TOC to 1700
-Increased Target Buff and Debuff max to 16
-Added 16 PartyPet Buffs and Debuffs
-Added Party Pet Buffs/Debuffs mouseover only option
-Updated all Buffs and Debuffs to 16 max
-Added Primary and Secondary Text Displays for every StatusBar
-AltTextLocation now swaps Primary and Secondary Display Text and is sepperated by Unit Type
-Added Text Inversion for all StatusBars (Show how much is missing in % or value)
-Now works with the MobHealth inbedded in MobInfo2
-Added dynamic font changing (dropdown in khaos)
[Note if you change the font the font shadow will dissapear. To get it back change the font to default and ReloadUI.]
-Added font coloring (color wheel in khaos)
-If in default positions PartyPets, PartyMembers and Target Frames are slightly relocated to make room for Text and Buffs
-Only Move Target Frame if Secondary Display is enabled on Target or Player
-Added Options to either show percent, value, both or neither on the XP bar
-Increased the Frame Level of Target Debuffs to be above the Target Frame
-Added Target debuff aplication overlays

v2.1
-Archaeologist now requires MCom for simplified Khaos/Cosmos/slash command registration
-All Slash commands are now availible via "/arch" which will bring up a dialog with availible commands.
-Removed Buggy Party Pet Buffs/Debuffs mouseover only option
-Added On/Off/Mouseover options for all statusbar displays via Khaos dropdown menus
-Added AltTextLocation for each status bar
-Added Option to use health values instead of percent on the target when possible

v2.11
-Fixed CharacterFrame 'Archaeologist_TurnOnPlayerXP' bug
-Fixed a bug where defaults where being set after MCom was registered
-Fixed a bug where duplicate settings where accidentally being saved with Khaos
-Fixed a bug that broke font resizing

v2.12
-Fixed Font Change bug causing nil error for SetTextHeight
-Prefix now stays on the Primary Display

v2.13
-TargetFrame Height now adjusts to the same height as the PlayerFrame (fix for TitanBar)
-Fixed for nil error on load involving undefaulted nil options

v2.2
-Changed 'alt text locations' to 'swap value and percent' (slash command changed as well. Ex: '/arch playerhpswap on')
-Pet happiness location now only moves when debuffs are enabled to the right or secondary text is on.
-Entirely rewrote the Target, Party and PartyPet frame offset relocation scheme based on options involving secondary display visibility, alternate buff positioning and buff/debuff hiding
-Now if party/partypet buffs are hidden the debuffs move up to close the space when applicable
-Party pet buffs disabled by default (normal space offset)
-Added Pet XP Text Display Options: On, Off, Mouseover, Prefix, Percent, Value, Invert
-Enabled Automatic MCom Option Feedback
-TBuffAlt option now wraps target buffs and debuffs in rows on eight.

v2.21
-Fixed font size save bug.

v2.3
-Added 6 value/percentage display presets (Preset1-6)
-Added 3 display prefix presets (PrefixOn, PrefixOff, PrefixDefault)

v2.4
-Added Feign Death detection for party members.
-Added Feign Death detection for player and target.
-Updated German Localization, thanks StarDust
-Updated French Localization, thanks WLMitch
-Fixed Presets not working on German Clients
(Note: MCom isn't French localized yet so slash commands will need the English On/Off while German clients use Ein/Aus)

v2.41
-Fixed Presets again, should work for French too now.

Known Bugs: Party Pet Buff/Debuff tooltips don't show.


	$Id: Archaeologist.lua 2626 2005-10-15 10:42:08Z karlkfi $
	$Rev: 2626 $
	$LastChangedBy: karlkfi $
	$Date: 2005-10-15 03:42:08 -0700 (Sat, 15 Oct 2005) $

]]--

-- <= == == == == == == == == == == == == =>
-- => Global Variables
-- <= == == == == == == == == == == == == =>

Archaeologist_TextStringPercentStatusBars = { };
Archaeologist_TextStringValueStatusBars = { };
Archaeologist_TextStringInvertStatusBars = { };
Archaeologist_TextStringAltTextStatusBars = { };

ArchaeologistStatusBars = { };
ArchaeologistOptionSetName = "Archaeologist";

ArchaeologistFonts = { 
	GameFontNormal = "Fonts\\FRIZQT__.TTF";
	NumberFontNormal = "Fonts\\ARIALN.TTF";
	ItemTextFontNormal = "Fonts\\MORPHEUS.TTF";
};

ArchaeologistOnOffMouseover = { 
	[ARCHAEOLOGIST_ON] = "on";
	[ARCHAEOLOGIST_OFF] = "off";
	[ARCHAEOLOGIST_MOUSEOVER] = "mouseover";
};

function Archaeologist_DefineStatusBars()

	ArchaeologistStatusBars.player  = { frame = PlayerFrame, statusText = PlayerStatusText };
	ArchaeologistStatusBars.party1  = { frame = PartyMemberFrame1, statusText = PartyMemberFrame1.statusText };
	ArchaeologistStatusBars.party2  = { frame = PartyMemberFrame2, statusText = PartyMemberFrame2.statusText };
	ArchaeologistStatusBars.party3  = { frame = PartyMemberFrame3, statusText = PartyMemberFrame3.statusText };
	ArchaeologistStatusBars.party4  = { frame = PartyMemberFrame4, statusText = PartyMemberFrame4.statusText };
	ArchaeologistStatusBars.pet		= { frame = PetFrame, statusText = PetStatusText };
	ArchaeologistStatusBars.target  = { frame = TargetFrame, statusText = TargetDeadText };

end

-- <= == == == == == == == == == == == == =>
-- => Variable Sync Tables
-- <= == == == == == == == == == == == == =>

ArchaeologistVars = { };
ArchaeologistVarData = { };

function Archaeologist_DefineVarData()
	ArchaeologistVarData = {

		PLAYERHP = { name = "PlayerHpEnable", default = "mouseover", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("player", "healthbar", value); end },
		PLAYERHP2 = { name = "PlayerHp2Enable", default = "off", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("player", "healthbar", value); Archaeologist_UpdateTargetLocation(); end },
		PLAYERMP = { name = "PlayerMpEnable", default = "mouseover", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("player", "manabar", value);  end },
		PLAYERMP2 = { name = "PlayerMp2Enable", default = "off", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("player", "manabar", value); Archaeologist_UpdateTargetLocation(); end },
		PLAYERXP = { name = "PlayerXpEnable", default = "mouseover", options = ArchaeologistOnOffMouseover, func = Archaeologist_PlayerXPOnOffMouseover },
		PLAYERHPINVERT = { name = "PlayerHpInvertEnable", default = 0, func = Archaeologist_TurnOnPlayerHPInvert },
		PLAYERMPINVERT = { name = "PlayerMpInvertEnable", default = 0, func = Archaeologist_TurnOnPlayerMPInvert },
		PLAYERXPINVERT = { name = "PlayerXpInvertEnable", default = 0, func = Archaeologist_TurnOnPlayerXPInvert },
		PLAYERXPP = { name = "PlayerXpPercentEnable", default = 0, func = Archaeologist_TurnOnPlayerXPPercent },
		PLAYERXPV = { name = "PlayerXpValueEnable", default = 1, func = Archaeologist_TurnOnPlayerXPValue },
		PLAYERHPNOPREFIX = { name = "PlayerHpPrefixEnable", default = 0, func = Archaeologist_TurnOffPlayerHPPrefix },
		PLAYERMPNOPREFIX = { name = "PlayerMpPrefixEnable", default = 0, func = Archaeologist_TurnOffPlayerMPPrefix },
		PLAYERXPNOPREFIX = { name = "PlayerXpPrefixEnable", default = 0, func = Archaeologist_TurnOffPlayerXPPrefix },
		PLAYERCLASSICON = { name = "PlayerClassIconEnable", default = 0, func = Archaeologist_TurnOnPlayerClassIcon },
		PLAYERHPSWAP = { name = "PlayerAltHpText", default = 0, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("player", "healthbar", toggle); end },
		PLAYERMPSWAP = { name = "PlayerAltMpText", default = 0, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("player", "manabar", toggle); end },
		
		PARTYHP = { name = "PartyHpEnable", default = "mouseover", options = ArchaeologistOnOffMouseover, func = function(value) for i=1,4 do Archaeologist_PrimaryOnOffMouseover("party"..i, "healthbar", value); end end },
		PARTYHP2 = { name = "PartyHp2Enable", default = "off", options = ArchaeologistOnOffMouseover, func = function(value) for i=1,4 do Archaeologist_SecondaryOnOffMouseover("party"..i, "healthbar", value); end end },
		PARTYMP = { name = "PartyMpEnable", default = "mouseover", options = ArchaeologistOnOffMouseover, func = function(value) for i=1,4 do Archaeologist_PrimaryOnOffMouseover("party"..i, "manabar", value); end end },
		PARTYMP2 = { name = "PartyMp2Enable", default = "off", options = ArchaeologistOnOffMouseover, func = function(value) for i=1,4 do Archaeologist_SecondaryOnOffMouseover("party"..i, "manabar", value); end end },
		PARTYHPINVERT = { name = "PartyHpInvertEnable", default = 0, func = Archaeologist_TurnOnPartyHPInvert },
		PARTYMPINVERT = { name = "PartyMpInvertEnable", default = 0, func = Archaeologist_TurnOnPartyMPInvert },
		PARTYHPNOPREFIX = { name = "PartyHpPrefixEnable", default = 1, func = Archaeologist_TurnOffPartyHPPrefix },
		PARTYMPNOPREFIX = { name = "PartyMpPrefixEnable", default = 0, func = Archaeologist_TurnOffPartyMPPrefix },
		PARTYCLASSICON = { name = "PartyClassIconEnable", default = 1, func = Archaeologist_TurnOnPartyClassIcon },
		PARTYHPSWAP = { name = "PartyAltHpText", default = 0, func = function(toggle) for i=1,4 do Archaeologist_SetUnitBarValuePercentSwap("party"..i, "healthbar", toggle); end end },
		PARTYMPSWAP = { name = "PartyAltMpText", default = 0, func = function(toggle) for i=1,4 do Archaeologist_SetUnitBarValuePercentSwap("party"..i, "manabar", toggle); end end },
		
		PETHP = { name = "PetHpEnable", default = "mouseover", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("pet", "healthbar", value); end },
		PETHP2 = { name = "PetHp2Enable", default = "off", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("pet", "healthbar", value); end },
		PETMP = { name = "PetMpEnable", default = "mouseover", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("pet", "manabar", value); end },
		PETMP2 = { name = "PetMp2Enable", default = "off", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("pet", "manabar", value); end },
		PETXP = { name = "PetXpEnable", default = "mouseover", options = ArchaeologistOnOffMouseover, func = Archaeologist_PetXPOnOffMouseover },
		PETHPINVERT = { name = "PetHpInvertEnable", default = 0, func = Archaeologist_TurnOnPetHPInvert },
		PETMPINVERT = { name = "PetMpInvertEnable", default = 0, func = Archaeologist_TurnOnPetMPInvert },
		PETXPINVERT = { name = "PetXpInvertEnable", default = 0, func = Archaeologist_TurnOnPetXPInvert },
		PETXPP = { name = "PetXpPercentEnable", default = 0, func = Archaeologist_TurnOnPetXPPercent },
		PETXPV = { name = "PetXpValueEnable", default = 1, func = Archaeologist_TurnOnPetXPValue },
		PETHPNOPREFIX = { name = "PetHpPrefixEnable", default = 1, func = Archaeologist_TurnOffPetHPPrefix },
		PETMPNOPREFIX = { name = "PetMpPrefixEnable", default = 0, func = Archaeologist_TurnOffPetMPPrefix },
		PETXPNOPREFIX = { name = "PetXpPrefixEnable", default = 0, func = Archaeologist_TurnOffPetXPPrefix },
		PETHPSWAP = { name = "PetAltHpText", default = 0, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("pet", "healthbar", toggle); end },
		PETMPSWAP = { name = "PetAltMpText", default = 0, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("pet", "manabar", toggle); end },
		
		TARGETHP = { name = "TargetHpEnable", default = "mouseover", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("target", "healthbar", value); end },
		TARGETHP2 = { name = "TargetHp2Enable", default = "off", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("target", "healthbar", value); Archaeologist_UpdateTargetLocation(); end },
		TARGETMP = { name = "TargetMpEnable", default = "mouseover", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("target", "manabar", value); end },
		TARGETMP2 = { name = "TargetMp2Enable", default = "off", options = ArchaeologistOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("target", "manabar", value); Archaeologist_UpdateTargetLocation(); end },
		TARGETHPINVERT = { name = "TargetHpInvertEnable", default = 0, func = Archaeologist_TurnOnTargetHPInvert },
		TARGETMPINVERT = { name = "TargetMpInvertEnable", default = 0, func = Archaeologist_TurnOnTargetMPInvert },
		TARGETHPNOPREFIX = { name = "TargetHpPrefixEnable", default = 1, func = Archaeologist_TurnOffTargetHPPrefix },
		TARGETMPNOPREFIX = { name = "TargetMpPrefixEnable", default = 0, func = Archaeologist_TurnOffTargetMPPrefix },
		TARGETCLASSICON = { name = "TargetClassIconEnable", default = 1, func = Archaeologist_TurnOnTargetClassIcon },
		TARGETHPSWAP = { name = "TargetAltHpText", default = 0, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("target", "healthbar", toggle); end },
		TARGETMPSWAP = { name = "TargetAltMpText", default = 0, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("target", "manabar", toggle); end },
		
		PBUFFS = { name = "PartyBuffDisable", default = 0, func = Archaeologist_TurnOffPartyBuffs },
		PBUFFNUM = { name = "PartyBuffCount", dependencies = {["PartyBuffEnable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetPartyBuffs },
		
		PDEBUFFS = { name = "PartyDebuffDisable", default = 0, func = Archaeologist_TurnOffPartyDebuffs },
		PDEBUFFNUM = { name = "PartyDebuffCount", dependencies = {["PartyDebuffEnable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetPartyDebuffs },
		
		PPTBUFFS = { name = "PartyPetBuffDisable", default = 1, func = Archaeologist_TurnOffPartyPetBuffs },
		PPTBUFFNUM = { name = "PartyPetBuffCount", dependencies = {["PartyPetBuffEnable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetPartyPetBuffs },
		
		PPTDEBUFFS = { name = "PartyPetDebuffDisable", default = 0, func = Archaeologist_TurnOffPartyPetDebuffs },
		PPTDEBUFFNUM = { name = "PartyPetDebuffCount", dependencies = {["PartyPetDebuffEnable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetPartyPetDebuffs },
		
		PTBUFFS = { name = "PetBuffDisable", default = 0, func = Archaeologist_TurnOffPetBuffs },
		PTBUFFNUM = { name = "PetBuffCount", dependencies = {["PetBuffEnable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetPetBuffs },
		
		PTDEBUFFS = { name = "PetDebuffDisable", default = 0, func = Archaeologist_TurnOffPetDebuffs },
		PTDEBUFFNUM = { name = "PetDebuffCount", dependencies = {["PetDebuffEnable"]={checked=false}}, default = 4, min = 0, max = 16, func = Archaeologist_SetPetDebuffs },
		
		TBUFFS = { name = "TargetBuffDisable", default = 0, func = Archaeologist_TurnOffTargetBuffs },
		TBUFFNUM = { name = "TargetBuffCount", dependencies = {["TargetBuffEnable"]={checked=false}}, default = 8, min = 0, max = 16, func = Archaeologist_SetTargetBuffs },
		
		TDEBUFFS = { name = "TargetDebuffDisable", default = 0, func = Archaeologist_TurnOffTargetDebuffs },
		TDEBUFFNUM = { name = "TargetDebuffCount", dependencies = {["TargetDebuffEnable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetTargetDebuffs },
		
		HPCOLOR = { name = "HealthGradientEnable", default = 0, func = function() end },
		DEBUFFALT = { name = "DebuffRelocateEnable", default = 0, func = Archaeologist_SetAltDebuffLocation },
		TBUFFALT = { name = "TargetBuffAlignment", default = 0, func = Archaeologist_TargetDebuffButton_Update },
		CLASSPORTRAIT = { name = "ClassPortrait", default = 0, func = Archaeologist_EnableClassPortrait },
		USEHPVALUE = { name = "UseHpValue", default = 0, func = function() Archaeologist_TextStatusBar_UpdateTextString(ArchaeologistStatusBars.target.frame.healthbar); end };
		HPMPLARGESIZE = { name = "LargeTextSize", default = 14, min = 6, max = 20, func = Archaeologist_SetHPMPLargeTextSize },
		HPMPSMALLSIZE = { name = "SmallTextSize", default = 14, min = 6, max = 20, func = Archaeologist_SetHPMPSmallTextSize },
		HPMPLARGEFONT = { name = "LargeFontSelect", default = "Default", options = ArchaeologistLocalizedFonts, func = Archaeologist_SetHPMPLargeFont },
		HPMPSMALLFONT = { name = "SmallFontSelect", default = "Default", options = ArchaeologistLocalizedFonts, func = Archaeologist_SetHPMPSmallFont },
		COLORPHP = { name = "PrimaryHpColorSelect", default = {r=1,g=1,b=1,opacity=1}, func = Archaeologist_SetPrimaryHPColor },
		COLORPMP = { name = "PrimaryMpColorSelect", default = {r=1,g=1,b=1,opacity=1}, func = Archaeologist_SetPrimaryMPColor },
		COLORSHP = { name = "SecondaryHpColorSelect", default = {r=1,g=1,b=1,opacity=1}, func = Archaeologist_SetSecondaryHPColor },
		COLORSMP = { name = "SecondaryMpColorSelect", default = {r=1,g=1,b=1,opacity=1}, func = Archaeologist_SetSecondaryMPColor },
	};
end

-- <= == == == == == == == == == == == == =>
-- => XML Function Calls
-- <= == == == == == == == == == == == == =>

local SavedHealthBar_OnValueChanged = nil;

function Archaeologist_OnLoad()
	
	Sea.util.hook( "TargetFrame_CheckDead", "Archaeologist_TargetCheckDead", "replace" );
	Sea.util.hook( "ShowTextStatusBarText", "Archaeologist_ShowTextStatusBarText", "replace" );
	Sea.util.hook( "HideTextStatusBarText", "Archaeologist_HideTextStatusBarText", "replace" );
	Sea.util.hook( "TextStatusBar_UpdateTextString", "Archaeologist_TextStatusBar_UpdateTextString", "replace" );
	Sea.util.hook( "CharacterFrame_OnShow", "Archaeologist_CharacterFrame_OnShow", "replace" );
	Sea.util.hook( "CharacterFrame_OnHide", "Archaeologist_CharacterFrame_OnHide", "replace" );
	Sea.util.hook( "UnitFrame_UpdateManaType", "Archaeologist_UnitFrame_UpdateManaType", "replace" );
	
	Sea.util.hook( "PartyMemberFrame_RefreshBuffs", "Archaeologist_PartyMemberFrame_RefreshBuffs", "replace" );
	Sea.util.hook( "PetFrame_RefreshBuffs", "Archaeologist_PetFrame_RefreshBuffs", "replace" );
	Sea.util.hook( "PartyMemberBuffTooltip_Update", "Archaeologist_PartyMemberBuffs_Update", "replace" );
	Sea.util.hook( "ShowPartyFrame", "Archaeologist_UpdatePartyMemberBuffs", "after" );
	Sea.util.hook( "TargetDebuffButton_Update", "Archaeologist_TargetDebuffButton_Update", "replace" );
	Sea.util.hook( "PartyMemberFrame_UpdatePet", "Archaeologist_PartyMemberFrame_UpdatePet", "replace" );
	
	Sea.util.hook( "UnitFrame_Update", "Archaeologist_UnitFrame_Update_After", "after" );
	Sea.util.hook( "UnitFrame_OnEvent", "Archaeologist_UnitFrame_OnEvent_After", "after" );
	Sea.util.hook( "SetTextStatusBarText", "Archaeologist_SetTextStatusBarText", "after" );
	
	--HealthBar_OnValueChanged manual hook to modify input
	if (HealthBar_OnValueChanged ~= SavedHealthBar_OnValueChanged) then
		SavedHealthBar_OnValueChanged = HealthBar_OnValueChanged;
		HealthBar_OnValueChanged = Archaeologist_HealthBar_OnValueChanged;
	end
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PARTY_MEMBER_DISABLE");
	this:RegisterEvent("PARTY_MEMBER_ENABLE");
	this:RegisterEvent("UNIT_AURA");
	
	Archaeologist_DefineVarData();
	Archaeologist_InitializeAddedStatusBarTexts();
	Archaeologist_DefineStatusBars();
	Archaeologist_HookStatusBars_OnLeave(); -- Add Hiding Handlers for 2ndary Displays
	Archaeologist_VarSync_SavedToVars(); --set all to default since nothing has loaded yet
end

function Archaeologist_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		
		local _, class = UnitClass("player");
		Archaeologist_PlayerIsHunter = (class == "HUNTER");
		
		if (not ArchaeologistVars) then
			ArchaeologistVars = { };
		end
		
		if (MobHealth_OnEvent) then
			if (MI2_OnEvent) then
				Sea.util.hook( "MI2_OnEvent", "Archaeologist_MobHealth_OnEvent", "after" );
			else
				Sea.util.hook( "MobHealth_OnEvent", "Archaeologist_MobHealth_OnEvent", "after" );
			end
			ArchaeologistVarData["MOBHEALTH"] = { name = "UseMobHealth", default = 0, func = Archaeologist_EnableMobHealth };
		end
		
		Archaeologist_VarSync_SavedToVars();
		--Fix the nil pet buff error, by not hooking this function until after the variable is not nil
		Sea.util.hook( "PartyMemberFrame_RefreshPetBuffs", "Archaeologist_PartyMemberFrame_RefreshPetBuffs", "replace" );
		Archaeologist_RegisterForMCom();
		
		if (not Khaos) and (not Cosmos_RegisterConfiguration) then
			Archaeologist_VarSync_VarsToLive();
			RegisterForSave("ArchaeologistVars");
		end
		
		Archaeologist_PlayerCheckDead();
		Archaeologist_UpdatePartyMembersDead();
		Archaeologist_PetCheckDead();
		Archaeologist_HideOrigTargetBuffs();
		Archaeologist_UpdateOverlapPositions()
	
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		Archaeologist_UpdatePartyMemberBuffs();
		Archaeologist_UpdatePlayerClassIcon();
	
	elseif ( event == "UNIT_HEALTH" ) then
		if (arg1 == "player") then
			Archaeologist_PlayerCheckDead();
		elseif (arg1 == "target") then
			--called by hook
			--Archaeologist_TargetCheckDead();
		elseif (arg1 == "pet") then
			Archaeologist_PetCheckDead();
		else
			local partyIndex = Archaeologist_PartyIndexFromUnit(arg1);
			Archaeologist_PartyCheckDead(partyIndex);
		end
		
	elseif (event == "PLAYER_TARGET_CHANGED") then
		Archaeologist_UpdateTargetClassIcon();
		
	elseif (event == "PARTY_MEMBERS_CHANGED") then
		Archaeologist_UpdatePartyMembersDead();
		Archaeologist_UpdatePartyClassIcons();
		
	elseif (event == "PARTY_MEMBER_ENABLE") then
		local partyIndex = Archaeologist_PartyIndexFromName(arg1);
		Archaeologist_PartyCheckDead(partyIndex);
		
	elseif (event == "PARTY_MEMBER_DISABLE") then
		local partyIndex = Archaeologist_PartyIndexFromName(arg1);
		Archaeologist_PartyCheckDead(partyIndex);
	
	elseif (event == "UNIT_AURA") then
		local partyIndex = Archaeologist_PartyIndexFromUnit(arg1);
		Archaeologist_PartyCheckDead(partyIndex);
		if (arg1 == "pet") then
			Archaeologist_PetCheckDead();
		elseif (arg1 == "player") and (Archaeologist_PlayerIsHunter) then
			--Scan for feigning
			PlayerFrame.feigning = nil;
			for i=1, 24 do
				texture = UnitBuff("player", i);
				if (texture == "Interface\\Icons\\Ability_Rogue_FeignDeath") then
					PlayerFrame.feigning = true;
				end
			end
		end
	end

end

-- <= == == == == == == == == == == == == =>
-- => Status Bar Initializing
-- <= == == == == == == == == == == == == =>

function Archaeologist_SetTextStatusBarText(bar, text, text2)
	if ( not bar or not text2 ) then
		return
	end
	bar.TextString2 = text2;
end

function Archaeologist_InitializeAddedStatusBarTexts()

	SetTextStatusBarText(PartyMemberFrame1HealthBar, PartyMemberFrame1HealthBarTextString, PartyMemberFrame1HealthBarTextString2);
	SetTextStatusBarText(PartyMemberFrame2HealthBar, PartyMemberFrame2HealthBarTextString, PartyMemberFrame2HealthBarTextString2);
	SetTextStatusBarText(PartyMemberFrame3HealthBar, PartyMemberFrame3HealthBarTextString, PartyMemberFrame3HealthBarTextString2);
	SetTextStatusBarText(PartyMemberFrame4HealthBar, PartyMemberFrame4HealthBarTextString, PartyMemberFrame4HealthBarTextString2);
	
	SetTextStatusBarText(PartyMemberFrame1ManaBar, PartyMemberFrame1ManaBarTextString, PartyMemberFrame1ManaBarTextString2);
	SetTextStatusBarText(PartyMemberFrame2ManaBar, PartyMemberFrame2ManaBarTextString, PartyMemberFrame2ManaBarTextString2);
	SetTextStatusBarText(PartyMemberFrame3ManaBar, PartyMemberFrame3ManaBarTextString, PartyMemberFrame3ManaBarTextString2);
	SetTextStatusBarText(PartyMemberFrame4ManaBar, PartyMemberFrame4ManaBarTextString, PartyMemberFrame4ManaBarTextString2);
	
	SetTextStatusBarText(TargetFrameHealthBar, TargetFrameHealthBarTextString, TargetFrameHealthBarTextString2);
	SetTextStatusBarText(TargetFrameManaBar, TargetFrameManaBarTextString, TargetFrameManaBarTextString2);
	
	SetTextStatusBarText(PetFrameHealthBar, PetFrameHealthBarText, PetFrameHealthBarText2String);
	SetTextStatusBarText(PetFrameManaBar, PetFrameManaBarText, PetFrameManaBarText2String);
	
	SetTextStatusBarText(PlayerFrameHealthBar, PlayerFrameHealthBarText, PlayerFrameHealthBarText2String);
	SetTextStatusBarText(PlayerFrameManaBar, PlayerFrameManaBarText, PlayerFrameManaBarText2String);
end

-- <= == == == == == == == == == == == == =>
-- => Variable Sync
-- <= == == == == == == == == == == == == =>

function Archaeologist_VarSync_SavedToVars()
	--sync saved values with internal values, else use default stored, else default to 0
	for index, var in ArchaeologistVarData do
		if (ArchaeologistVars[index]) then
			--already saved
		elseif (var.default) then
			ArchaeologistVars[index] = var.default;
		else
			ArchaeologistVars[index] = 0;
		end
	end
end


function Archaeologist_VarSync_VarsToLive()
	--sync live status with internal values, else use default stored, else default to 0
	for index, var in ArchaeologistVarData do
		if (var.min) and (var.max) then --slider
			if (ArchaeologistVars[index]) and (var.func) then
				var.func(ArchaeologistVars[index])
			elseif (var.func) and (var.default) then
				var.func(var.default);
			elseif (var.func) then
				var.func(0);
			end
		elseif (type(var.default) == "table") then --colorwheel
			if (ArchaeologistVars[index]) and (var.func) then
				var.func(ArchaeologistVars[index])
			elseif (var.func) and (var.default) then
				var.func(var.default);
			elseif (var.func) then
				var.func({});
			end
		elseif (ArchaeologistVars[index]) and (var.func) then
			var.func(ArchaeologistVars[index])
		elseif (var.func) and (var.default) then
			var.func(var.default);
		elseif (var.func) then
			var.func(0);
		end
	end
end


-- <= == == == == == == == == == == == == =>
-- => HP Color Mod
-- <= == == == == == == == == == == == == =>

function Archaeologist_HealthBar_OnValueChanged(value, smooth)
	if (ArchaeologistVars) then
		if (ArchaeologistVars["HPCOLOR"] == 1) then
			smooth = not smooth;
		end
	end
	SavedHealthBar_OnValueChanged(value, smooth)
end

-- <= == == == == == == == == == == == == =>
-- => HPMP Text Size
-- <= == == == == == == == == == == == == =>

function Archaeologist_SetHPMPLargeTextSize(size)
	if (type(size) ~= "number") then
		return;
	end
	local barParent = ArchaeologistStatusBars["player"].frame;
	barParent.healthbar.TextString:SetTextHeight(size);
	barParent.manabar.TextString:SetTextHeight(size);
	barParent.healthbar.TextString2:SetTextHeight(size);
	barParent.manabar.TextString2:SetTextHeight(size);
	local scale = barParent:GetScale();
	barParent:SetScale(scale+.1);
	barParent:SetScale(scale);
	barParent = ArchaeologistStatusBars["target"].frame;
	barParent.healthbar.TextString:SetTextHeight(size);
	barParent.manabar.TextString:SetTextHeight(size);
	barParent.healthbar.TextString2:SetTextHeight(size);
	barParent.manabar.TextString2:SetTextHeight(size);
	scale = barParent:GetScale();
	barParent:SetScale(scale+.1);
	barParent:SetScale(scale);
end

function Archaeologist_SetHPMPSmallTextSize(size)
	if (type(size) ~= "number") then
		return;
	end
	local barParent = ArchaeologistStatusBars["pet"].frame;
	barParent.healthbar.TextString:SetTextHeight(size);
	barParent.manabar.TextString:SetTextHeight(size);
	barParent.healthbar.TextString2:SetTextHeight(size);
	barParent.manabar.TextString2:SetTextHeight(size);
	local scale = barParent:GetScale();
	barParent:SetScale(scale+.1);
	barParent:SetScale(scale);
	for i=1, 4 do
		barParent = ArchaeologistStatusBars["party"..i].frame;
		barParent.healthbar.TextString:SetTextHeight(size);
		barParent.manabar.TextString:SetTextHeight(size);
		barParent.healthbar.TextString2:SetTextHeight(size);
		barParent.manabar.TextString2:SetTextHeight(size);
		scale = barParent:GetScale();
		barParent:SetScale(scale+.1);
		barParent:SetScale(scale);
	end
end

-- <= == == == == == == == == == == == == => <= == == == == == == == == == == == == =>
-- => Toggle Functions
-- <= == == == == == == == == == == == == => <= == == == == == == == == == == == == =>

-- <= == == == == == == == == == == == == =>
-- => TurnOn HP/MP/XP Functions
-- <= == == == == == == == == == == == == =>

function Archaeologist_PrimaryOnOffMouseover(unit, bartype, value)
	OverrideShowStatusBarText(ArchaeologistStatusBars[unit].frame[bartype], value);
end

function Archaeologist_SecondaryOnOffMouseover(unit, bartype, value)
	OverrideShowStatusBarText2(ArchaeologistStatusBars[unit].frame[bartype], value);
	if (unit == "pet") then
		Archaeologist_SetPetFrameHappinessLocation();
	end
end

function Archaeologist_PlayerXPOnOffMouseover(toggle)
	OverrideShowStatusBarText(MainMenuExpBar, toggle);
end

function Archaeologist_PetXPOnOffMouseover(toggle)
	OverrideShowStatusBarText(PetPaperDollFrameExpBar, toggle);
end

function Archaeologist_RestorePlayerHP()
	Archaeologist_PrimaryOnOffMouseover("player", "healthbar", ArchaeologistVars["PLAYERHP"]);
end

function Archaeologist_RestorePlayerMP()
	Archaeologist_PrimaryOnOffMouseover("player", "manabar", ArchaeologistVars["PLAYERMP"]);
end

function Archaeologist_RestorePlayerXP()
	Archaeologist_PlayerXPOnOffMouseover(ArchaeologistVars["PLAYERXP"])
end

-- <= == == == == == == == == == == == == =>
-- => Change HP/MP/XP Values to Percent Functions
-- <= == == == == == == == == == == == == =>

function Archaeologist_TurnOnPlayerXPPercent(toggle)
	Archaeologist_TextStringPercentStatusBars["MainMenuExpBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(MainMenuExpBar);
end

function Archaeologist_TurnOnPlayerXPValue(toggle)
	Archaeologist_TextStringValueStatusBars["MainMenuExpBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(MainMenuExpBar);
end

function Archaeologist_TurnOnPetXPPercent(toggle)
	Archaeologist_TextStringPercentStatusBars["PetPaperDollFrameExpBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(PetPaperDollFrameExpBar);
end

function Archaeologist_TurnOnPetXPValue(toggle)
	Archaeologist_TextStringValueStatusBars["PetPaperDollFrameExpBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(PetPaperDollFrameExpBar);
end

-- <= == == == == == == == == == == == == =>
-- => Invert HP/MP/XP Values
-- <= == == == == == == == == == == == == =>

function Archaeologist_TurnOnPlayerHPInvert(toggle)
	local statusBar = ArchaeologistStatusBars["player"].frame.healthbar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPlayerMPInvert(toggle)
	local statusBar = ArchaeologistStatusBars["player"].frame.manabar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPlayerXPInvert(toggle)
	Archaeologist_TextStringInvertStatusBars["MainMenuExpBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(MainMenuExpBar);
end

function Archaeologist_TurnOnPartyHPInvert(toggle)
	local statusBar = ArchaeologistStatusBars["party1"].frame.healthbar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	
	statusBar = ArchaeologistStatusBars["party2"].frame.healthbar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	
	statusBar = ArchaeologistStatusBars["party3"].frame.healthbar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	
	statusBar = ArchaeologistStatusBars["party4"].frame.healthbar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPartyMPInvert(toggle)
	local statusBar = ArchaeologistStatusBars["party1"].frame.manabar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	
	statusBar = ArchaeologistStatusBars["party2"].frame.manabar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	
	statusBar = ArchaeologistStatusBars["party3"].frame.manabar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	
	statusBar = ArchaeologistStatusBars["party4"].frame.manabar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

--only used to call onload since no more accurate data is provided
function Archaeologist_TurnOnTargetHPInvert(toggle)
	local statusBar = ArchaeologistStatusBars["target"].frame.healthbar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnTargetMPInvert(toggle)
	local statusBar = ArchaeologistStatusBars["target"].frame.manabar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end


function Archaeologist_TurnOnPetHPInvert(toggle)
	local statusBar = ArchaeologistStatusBars["pet"].frame.healthbar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPetMPInvert(toggle)
	local statusBar = ArchaeologistStatusBars["pet"].frame.manabar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPetXPInvert(toggle)
	local statusBar = PetPaperDollFrameExpBar;
	Archaeologist_TextStringInvertStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

-- <= == == == == == == == == == == == == =>
-- => Hide HP/MP/XP Value Prefix Functions
-- <= == == == == == == == == == == == == =>

function Archaeologist_UnitFrame_UpdateManaType(unitFrame)
	if ( not unitFrame ) then
		unitFrame = this;
	end
	if ( not unitFrame.manabar ) then
		return;
	end
	local info = ManaBarColor[UnitPowerType(unitFrame.unit)];
	unitFrame.manabar:SetStatusBarColor(info.r, info.g, info.b);
	
	-- Update the manabar prefix only if not hidden
	if ( Archaeologist_ManaPrefixNotHidden(unitFrame) ) then
		SetTextStatusBarTextPrefix(unitFrame.manabar, info.prefix);
		TextStatusBar_UpdateTextString(unitFrame.manabar);
	end

	-- Setup newbie tooltip
	if ( unitFrame:GetName() == "PlayerFrame" ) then
		unitFrame.manabar.tooltipTitle = info.prefix;
		unitFrame.manabar.tooltipText = getglobal("NEWBIE_TOOLTIP_MANABAR"..UnitPowerType(unitFrame.unit));
	else
		unitFrame.manabar.tooltipTitle = nil;
		unitFrame.manabar.tooltipText = nil;
	end
	
end


function Archaeologist_ManaPrefixNotHidden(frame)
	if  ( (ArchaeologistVars["PLAYERMPNOPREFIX"] == 0) and (frame == ArchaeologistStatusBars.player.frame) ) or
		( (ArchaeologistVars["PARTYMPNOPREFIX"] == 0) and (
			(frame == ArchaeologistStatusBars.party1.frame) or
			(frame == ArchaeologistStatusBars.party2.frame) or
			(frame == ArchaeologistStatusBars.party3.frame) or
			(frame == ArchaeologistStatusBars.party4.frame)
		) ) or
		( (ArchaeologistVars["PETMPNOPREFIX"] == 0) and (frame == ArchaeologistStatusBars.pet.frame) ) or
		( (ArchaeologistVars["TARGETMPNOPREFIX"] == 0) and (frame == ArchaeologistStatusBars.target.frame) )
	then
		return true;
	end
end


function Archaeologist_TurnOffUnitHPPrefix(unit, toggle)
	local statusBar = ArchaeologistStatusBars[unit].frame.healthbar;
	if (toggle == 1) then
		SetTextStatusBarTextPrefix(statusBar, nil);
	else
		SetTextStatusBarTextPrefix(statusBar, TEXT(HEALTH));
	end
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOffUnitMPPrefix(unit, toggle)
	local statusBar = ArchaeologistStatusBars[unit].frame.manabar;
	if (toggle == 1) then
		SetTextStatusBarTextPrefix(statusBar, nil);
	else
		SetTextStatusBarTextPrefix(statusBar, ManaBarColor[UnitPowerType(unit)].prefix);
	end
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end


function Archaeologist_TurnOffPlayerHPPrefix(toggle)
	Archaeologist_TurnOffUnitHPPrefix("player", toggle)
end

function Archaeologist_TurnOffPlayerMPPrefix(toggle)
	Archaeologist_TurnOffUnitMPPrefix("player", toggle)
end

function Archaeologist_TurnOffPlayerXPPrefix(toggle)
	local statusBar = MainMenuExpBar;
	if (toggle == 1) then
		SetTextStatusBarTextPrefix(statusBar, nil);
	else
		SetTextStatusBarTextPrefix(statusBar, TEXT(XP));
	end
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOffPartyHPPrefix(toggle)
	Archaeologist_TurnOffUnitHPPrefix("party1", toggle)
	Archaeologist_TurnOffUnitHPPrefix("party2", toggle)
	Archaeologist_TurnOffUnitHPPrefix("party3", toggle)
	Archaeologist_TurnOffUnitHPPrefix("party4", toggle)
end

function Archaeologist_TurnOffPartyMPPrefix(toggle)
	Archaeologist_TurnOffUnitMPPrefix("party1", toggle)
	Archaeologist_TurnOffUnitMPPrefix("party2", toggle)
	Archaeologist_TurnOffUnitMPPrefix("party3", toggle)
	Archaeologist_TurnOffUnitMPPrefix("party4", toggle)
end

function Archaeologist_TurnOffTargetHPPrefix(toggle)
	Archaeologist_TurnOffUnitHPPrefix("target", toggle)
end

function Archaeologist_TurnOffTargetMPPrefix(toggle)
	Archaeologist_TurnOffUnitMPPrefix("target", toggle)
end


function Archaeologist_TurnOffPetHPPrefix(toggle)
	Archaeologist_TurnOffUnitHPPrefix("pet", toggle)
end

function Archaeologist_TurnOffPetMPPrefix(toggle)
	Archaeologist_TurnOffUnitMPPrefix("pet", toggle)
end

function Archaeologist_TurnOffPetXPPrefix(toggle)
	local statusBar = PetPaperDollFrameExpBar;
	if (toggle == 1) then
		SetTextStatusBarTextPrefix(statusBar, nil);
	else
		SetTextStatusBarTextPrefix(statusBar, TEXT(XP));
	end
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end


-- <= == == == == == == == == == == == == =>
-- => Status HP/MP/XP Bar Overrides
-- <= == == == == == == == == == == == == =>

function OverrideShowStatusBarText(bar, toggle)
	if (type(toggle) == "string") then
		if (toggle == "on") then
			SetStatusBarTextOverride(bar, 1);
		elseif (toggle == "off") then
			SetStatusBarTextOverride(bar, 0);
		else --mouseover
			SetStatusBarTextOverride(bar, nil);
		end
	else
		if (toggle == 1) then
			SetStatusBarTextOverride(bar, 1);
		else
			SetStatusBarTextOverride(bar, nil);
		end
	end
end

function OverrideShowStatusBarText2(bar, toggle)
	if (type(toggle) == "string") then
		if (toggle == "on") then
			SetStatusBarTextOverride2(bar, 1);
		elseif (toggle == "off") then
			SetStatusBarTextOverride2(bar, 0);
		else --mouseover
			SetStatusBarTextOverride2(bar, nil);
		end
	else
		if (toggle == 1) then
			SetStatusBarTextOverride2(bar, 1);
		else
			SetStatusBarTextOverride2(bar, nil);
		end
	end
end

--[[unused.. yet
function OverrideHideStatusBarText(bar, toggle)
	if (toggle == 1) then
		SetStatusBarTextOverride(bar, 0);
	else
		SetStatusBarTextOverride(bar, nil);
	end
end
]]--

--sets the override for StatusBarTexts.
--override = nil removes override, 0 sets to hide, 1 sets to show
function SetStatusBarTextOverride(bar, override)
	if(not bar) then
		return;
	end
	if(override == "1" or override == 1 or override == "show") then
		bar.override = "show";
		--UIOptionsFrameCheckButtons["STATUS_BAR_TEXT"].value = "1"
		ShowTextStatusBarText(bar);
	elseif(override == "0" or override == 0 or override == "hide") then
		bar.override = "hide";
		HideTextStatusBarText(bar);
	else
		bar.override = nil;
		HideTextStatusBarText(bar);
	end
end

--sets the override for secondary StatusBarTexts.
--override = nil removes override, 0 sets to hide, 1 sets to show
function SetStatusBarTextOverride2(bar, override)
	if(not bar) then
		return;
	end
	if(override == "1" or override == 1 or override == "show") then
		bar.override2 = "show";
		Archaeologist_ShowTextStatusBarText2(bar);
	elseif(override == "0" or override == 0 or override == "hide") then
		bar.override2 = "hide";
		Archaeologist_HideTextStatusBarText2(bar);
	else
		bar.override2 = nil;
		Archaeologist_HideTextStatusBarText2(bar);
	end
end


--updates old lockShow to the new override notation
local function ConvertLockShowToOverrideSyntax(bar)
	if (bar.textLockable) then
		bar.textLockable = nil;
	end
	if (bar.lockShow) then
		if (bar.lockShow == 1) then
			bar.override = "show";
		end
		bar.lockShow = nil;
	end
end


--allows the setting of textStatusBar.oneText to override other values if value = 1
--used to hide hp text of a ghost
--also added optional percents
function Archaeologist_TextStatusBar_UpdateTextString(textStatusBar)
	if ( not textStatusBar ) then
		textStatusBar = this;
	end
	local string = textStatusBar.TextString;
	local string2 = textStatusBar.TextString2;
	if (string) then
		local value = textStatusBar:GetValue();
		local valueMin, valueMax = textStatusBar:GetMinMaxValues();
		if ( valueMax > 0 ) then
			textStatusBar:Show();
			if ( value == 0 and textStatusBar.zeroText ) then
				string:SetText(textStatusBar.zeroText);
				textStatusBar.isZero = 1;
				ShowTextStatusBarText(textStatusBar);
			elseif ( value == 1 and textStatusBar.oneText ) then
				string:SetText(textStatusBar.oneText);
				textStatusBar.isOne = 1;
				string:Show();
				ShowTextStatusBarText(textStatusBar);
			else
				textStatusBar.isZero = nil;
				textStatusBar.isOne = nil;

				local stringText1, stringText2 = Archaeologist_GetCurrentTextStrings(
					value, valueMax,
					textStatusBar.prefix,
					(not Archaeologist_TextStringPercentStatusBars[textStatusBar:GetName()]) or (Archaeologist_TextStringPercentStatusBars[textStatusBar:GetName()] == 1),
					(Archaeologist_TextStringValueStatusBars[textStatusBar:GetName()] == 1),
					(Archaeologist_TextStringInvertStatusBars[textStatusBar:GetName()] == 1),
					(textStatusBar == TargetFrame.healthbar) and (valueMax == 100),
					(Archaeologist_TextStringAltTextStatusBars[textStatusBar:GetName()] == 1),
					(textStatusBar == TargetFrame.healthbar) and (ArchaeologistVars["USEHPVALUE"] == 1)
				);
				string:SetText(stringText1);
				if (string2) then
					string2:SetText(stringText2);
				end
				
				if (textStatusBar.override == "show") or (textStatusBar:GetLeft()) and (MouseIsOver(textStatusBar)) then
					ShowTextStatusBarText(textStatusBar);
				else
					HideTextStatusBarText(textStatusBar);
				end
				
				if (textStatusBar.override2 == "show") or (textStatusBar:GetLeft()) and (MouseIsOver(textStatusBar)) then
					Archaeologist_ShowTextStatusBarText2(textStatusBar);
				else
					Archaeologist_HideTextStatusBarText2(textStatusBar);
				end
			end
		else
			textStatusBar:Hide();
		end
	end
end

function Archaeologist_GetCurrentTextStrings(value, valueMax, prefix, percent, exactValue, invert, isMob, altText, useHpValue)
	
	local stringText1 = "";
	local stringText2 = "";
	local percentText = "";
	local valueText = "";
	
	if (invert) then 
		percentText = "-"..(100 - Sea.math.round(value / valueMax * 100)).."%";
	else
		percentText = Sea.math.round(value / valueMax * 100).."%";
	end
	
	if (isMob) then
		if (MobHealth_GetTargetCurHP) and (MobHealth_GetTargetMaxHP) and (ArchaeologistVars["MOBHEALTH"] == 1) then
			local mobValue = MobHealth_GetTargetCurHP();
			local mobValueMax = MobHealth_GetTargetMaxHP();
			if (mobValue) and (mobValueMax) and (mobValueMax ~= 0) then
				if (invert) then
					valueText = "-"..(mobValueMax-mobValue).." / "..mobValueMax;
				else
					valueText = mobValue.." / "..mobValueMax;
				end
			end
		end
	elseif (invert) then
		valueText = "-"..(valueMax-value).." / "..valueMax;
	else
		valueText = value.." / "..valueMax;
	end
	
	if (percent) and (exactValue) then
		stringText1 = percentText.." "..valueText;
		stringText2 = percentText.." "..valueText;
	elseif (useHpValue) and (valueText ~= "") then
		stringText1 = valueText;
		stringText2 = valueText;
	elseif (percent) then
		stringText1 = percentText;
		stringText2 = valueText;
	elseif (exactValue) then
		stringText1 = valueText;
		stringText2 = valueText;
	end
	
	if (altText) then
		local temp = stringText1;
		stringText1 = stringText2;
		stringText2 = temp;
	end
	if (prefix) then
		stringText1 = prefix.." "..stringText1;
	end
	return stringText1, stringText2;
end

--removes lockShow and adds override
function Archaeologist_ShowTextStatusBarText(bar)
	if ( bar and bar.TextString ) then
		ConvertLockShowToOverrideSyntax(bar);
		if (bar.override ~= "hide") then
			bar.TextString:Show();
		end
	end
end

function Archaeologist_ShowTextStatusBarText2(bar)
	if ( bar and bar.TextString2 ) then
		if (bar.override2 ~= "hide") then
			bar.TextString2:Show();
		end
	end
end

--removes old lockShow, adds override, adds visibility for isOne, and removes UIOptions check
--effectively breaks the 'Show HP/Mana/XP Always Vislible' in the default UIOptions
function Archaeologist_HideTextStatusBarText(bar)
	if ( bar and bar.TextString ) then
		ConvertLockShowToOverrideSyntax(bar);
		if (bar.override == "hide") then
			bar.TextString:Hide();
		elseif (bar.isZero) or (bar.isOne) or (bar.override == "show") then -- or (MouseIsOver(bar)) then
			bar.TextString:Show();
		else
			bar.TextString:Hide();
		end
	end
end

function Archaeologist_HideTextStatusBarText2(bar)
	if ( bar and bar.TextString2 ) then
		if (bar.override2 == "hide") then
			bar.TextString2:Hide();
		elseif (bar.isZero) or (bar.isOne) or (bar.override2 == "show") then -- or (MouseIsOver(bar)) then
			bar.TextString2:Show();
		else
			bar.TextString2:Hide();
		end
	end
end

function Archaeologist_HookStatusBars_OnLeave()
	local afterHook = function(bar)
		Archaeologist_HideTextStatusBarText2(bar);
	end
	for unit, data in ArchaeologistStatusBars do
		local bar1 = data.frame.healthbar;
		setglobal("Archaeologist_"..bar1:GetName().."_OnLeave_orig", bar1:GetScript("OnLeave"));
		bar1:SetScript("OnLeave", function() getglobal("Archaeologist_"..bar1:GetName().."_OnLeave_orig")(); afterHook(bar1); end);
		
		local bar2 = data.frame.manabar;
		setglobal("Archaeologist_"..bar2:GetName().."_OnLeave_orig", bar2:GetScript("OnLeave"));
		bar2:SetScript("OnLeave", function() getglobal("Archaeologist_"..bar2:GetName().."_OnLeave_orig")(); afterHook(bar2); end);
	end
end

--sets bar.oneText
function SetTextStatusBarTextOneText(bar, oneText)
	if ( bar and bar.TextString ) then
		bar.oneText = oneText;
	end
end

function Archaeologist_CharacterFrame_OnShow()
	PlaySound("igCharacterInfoOpen");
	SetPortraitTexture(CharacterFramePortrait, "player");
	CharacterNameText:SetText(UnitPVPName("player"));
	UpdateMicroButtons();
	OverrideShowStatusBarText(PlayerFrameHealthBar, 1);
	OverrideShowStatusBarText(PlayerFrameManaBar, 1);
	OverrideShowStatusBarText(MainMenuExpBar, 1);
end

function Archaeologist_CharacterFrame_OnHide()
	PlaySound("igCharacterInfoClose");
	UpdateMicroButtons();
	Archaeologist_RestorePlayerHP();
	Archaeologist_RestorePlayerMP();
	Archaeologist_RestorePlayerXP();
end

-- <= == == == == == == == == == == == == =>
-- => Dead/Offline/Ghost Status Overrides
-- <= == == == == == == == == == == == == =>


function Archaeologist_TargetCheckDead()
	local unit = "target";
	local healthbar = ArchaeologistStatusBars[unit].frame.healthbar;
	local manabar = ArchaeologistStatusBars[unit].frame.manabar;
	local statusText = ArchaeologistStatusBars[unit].statusText;
	Archaeologist_UnitCheckDead(unit, statusText, healthbar, manabar);
end


function Archaeologist_PartyCheckDead(partyIndex)
	if (type(partyIndex) ~= "number")  then
		return;
	end
	local unit = "party"..partyIndex;
	local healthbar = ArchaeologistStatusBars[unit].frame.healthbar;
	local manabar = ArchaeologistStatusBars[unit].frame.manabar;
	local statusText = ArchaeologistStatusBars[unit].statusText;
	Archaeologist_UnitCheckDead(unit, statusText, healthbar, manabar);
end


function Archaeologist_UpdatePartyMembersDead()
	if (GetNumPartyMembers() > 0) then
		for i=1, GetNumPartyMembers() do
			Archaeologist_PartyCheckDead(i);
		end
	end
end


function Archaeologist_PlayerCheckDead()
	local unit = "player";
	local healthbar = ArchaeologistStatusBars[unit].frame.healthbar;
	local manabar = ArchaeologistStatusBars[unit].frame.manabar;
	local statusText = ArchaeologistStatusBars[unit].statusText;
	Archaeologist_UnitCheckDead(unit, statusText, healthbar, manabar);
end


function Archaeologist_PetCheckDead()
	local unit = "pet";
	local healthbar = ArchaeologistStatusBars[unit].frame.healthbar;
	local manabar = ArchaeologistStatusBars[unit].frame.manabar;
	local statusText = ArchaeologistStatusBars[unit].statusText;
	Archaeologist_UnitCheckDead(unit, statusText, healthbar, manabar);
end


function Archaeologist_UnitCheckDead(unit, statusText, healthbar, manabar)
	--adds Dead text if unit is Dead
	--adds Offline text if unit is a player and not connected
	--adds Ghost/Wisp text if unit is a player
	
	if ( UnitIsDead(unit) ) and ( Archaeologist_UnitIsConnected(unit) ) then
		local _, class = UnitClass(unit);
		if (ArchaeologistStatusBars[unit].frame.feigning) or (class == "HUNTER" and UnitIsEnemy("player", unit)) then
			statusText:SetText(FEIGN_DEATH);
		else
			statusText:SetText(DEAD);
		end
		statusText:Show();
		
		--hide health/mana if dead 
		SetTextStatusBarTextZeroText(healthbar, "");
		SetTextStatusBarTextZeroText(manabar, "");
		
	elseif ( UnitIsPlayer(unit) ) and ( not Archaeologist_UnitIsConnected(unit) ) then
		
		statusText:SetText(PLAYER_OFFLINE);
		healthbar:Hide();
		manabar:Hide();
		--!!!!!!!!!!!
		--^^ add a status bar hook to change this.
		--!!!!!!!!!!!
		statusText:Show();
		
		--hide health/mana if offline 
		SetTextStatusBarTextZeroText(healthbar, "");
		SetTextStatusBarTextZeroText(manabar, "");
		
	elseif ( UnitIsGhost(unit) ) then
	
		if ( UnitRace(unit) == "Night Elf" ) then
			statusText:SetText(PLAYER_WISP);
		else
			statusText:SetText(PLAYER_GHOST);
		end
		statusText:Show();

		--hide health/mana if ghost 
		SetTextStatusBarTextOneText(healthbar, "");
		SetTextStatusBarTextZeroText(manabar, "");
		
	else
	
		statusText:Hide();
		
		--show health/mana if not dead, offline or ghost
		SetTextStatusBarTextZeroText(healthbar, nil);
		SetTextStatusBarTextOneText(healthbar, nil);
		SetTextStatusBarTextZeroText(manabar, nil);
		
		--reset to override show
		ShowTextStatusBarText(healthbar);
		
	end
	
	TextStatusBar_UpdateTextString(healthbar);
	TextStatusBar_UpdateTextString(manabar);
	
end

function Archaeologist_UnitIsConnected(unit)
	ArchaeologistTooltip:SetUnit(unit);
	local tooltipOfflineLine = Sea.wow.tooltip.scan("ArchaeologistTooltip")[3];
	Sea.wow.tooltip.clear("ArchaeologistTooltip");
	local tooltipOfflineText;
	if ( tooltipOfflineLine ) then
		tooltipOfflineText = tooltipOfflineLine.left;
	end
	if (tooltipOfflineText == PLAYER_OFFLINE) then
		return;
	end
	return UnitIsConnected(unit);
end


-- <= == == == == == == == == == == == == =>
-- => Party and Pet Buffs
-- <= == == == == == == == == == == == == =>

function Archaeologist_UpdateOverlapPositions()
	Archaeologist_UpdatePartyMemberLocations();
	Archaeologist_UpdatePartyPetLocations();
	Archaeologist_UpdateTargetLocation();
end
	
function Archaeologist_UpdatePartyMemberLocations()
	local partyY = 0;   --Normal Offset
	if (ArchaeologistVars["PPTBUFFS"] == 0) and (ArchaeologistVars["PPTDEBUFFS"] == 0) then
		partyY = -20;   --Party Frames moved down 20 to make room for PartyPet Buffs and Debuffs
	end
	
	if (not PartyMemberFrame2:IsUserPlaced()) then
		PartyMemberFrame2:ClearAllPoints()
		PartyMemberFrame2:SetPoint("TOPLEFT", "PartyMemberFrame1PetFrame", "BOTTOMLEFT", -23, -10+partyY);
	end
	if (not PartyMemberFrame3:IsUserPlaced()) then
		PartyMemberFrame3:ClearAllPoints()
		PartyMemberFrame3:SetPoint("TOPLEFT", "PartyMemberFrame2PetFrame", "BOTTOMLEFT", -23, -10+partyY);
	end
	if (not PartyMemberFrame4:IsUserPlaced()) then
		PartyMemberFrame4:ClearAllPoints()
		PartyMemberFrame4:SetPoint("TOPLEFT", "PartyMemberFrame3PetFrame", "BOTTOMLEFT", -23, -10+partyY);
	end
end

function Archaeologist_UpdateTargetLocation()
	if (not TargetFrame:IsUserPlaced()) and (not PlayerFrame:IsUserPlaced()) then
		if (PlayerFrame:GetRight()) then
			local y = TargetFrame:GetTop() - UIParent:GetTop();
			local x = PlayerFrame:GetRight();
			if (ArchaeologistVars["TARGETHP2"] == "on") or (ArchaeologistVars["TARGETMP2"] == "on") or (ArchaeologistVars["PLAYERHP2"] == "on") or (ArchaeologistVars["PLAYERMP2"] == "on") then
				-- Only Move if the Secondary Display is on
				TargetFrame:ClearAllPoints()
				TargetFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", x+145, y);
			elseif (ArchaeologistVars["TARGETHP2"] == "mouseover") or (ArchaeologistVars["TARGETMP2"] == "mouseover") or (ArchaeologistVars["PLAYERHP2"] == "mouseover") or (ArchaeologistVars["PLAYERMP2"] == "mouseover") then
				-- Adjust for single Secondary Display mouseover
				TargetFrame:ClearAllPoints();
				TargetFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", x+75, y);
			else
				--Default
				TargetFrame:ClearAllPoints();
				TargetFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 250, y);
			end
		else
			--Dumb GetLeft == nil bug... don't do anything
		end
	end
end

function Archaeologist_PartyMemberFrame_UpdatePet(id)
	if ( not id ) then
		id = this:GetID();
	end
	
	local frameName = "PartyMemberFrame"..id;
	local petFrame = getglobal("PartyMemberFrame"..id.."PetFrame");
	
	local partypetY = 0;   --Normal Offset
	if ( UnitIsConnected("party"..id) and UnitExists("partypet"..id) and SHOW_PARTY_PETS == "1" ) then
		petFrame:Show();
		if (not petFrame:IsUserPlaced()) then
			if (ArchaeologistVars["PBUFFS"] == 0) and (ArchaeologistVars["PDEBUFFS"] == 0) and (ArchaeologistVars["DEBUFFALT"] == 1) then
				partypetY = -20;	--PartyPet Frames moved down 20 to make room for Pet Buffs and Debuffs
			end
		end
	else
		petFrame:Hide();
		if (not petFrame:IsUserPlaced()) then
			partypetY = 16  --PartyPet Frames moved up 16 to close party member gap
		end
	end
	
	petFrame:ClearAllPoints();
	petFrame:SetPoint("TOPLEFT", frameName, "TOPLEFT", 23, -43+partypetY);
	
	PartyMemberFrame_RefreshPetBuffs(id);
end


function Archaeologist_PartyMemberFrame_RefreshBuffs()
	
	local texture;
	if ( ArchaeologistVars["PBUFFS"] == 1 ) then
		for i=1, ArchaeologistVarData["PBUFFNUM"].max do
			getglobal(this:GetName().."NewBuff"..i):Hide();
		end
	else
		this.feigning = nil;
		for i=1, ArchaeologistVarData["PBUFFNUM"].max do
			texture = UnitBuff("party"..this:GetID(), i);
			if (texture == "Interface\\Icons\\Ability_Rogue_FeignDeath") then
				this.feigning = true;
			end
			if ( texture ) and (i <= ArchaeologistVars["PBUFFNUM"]) then
				getglobal(this:GetName().."NewBuff"..i.."Icon"):SetTexture(texture);
				getglobal(this:GetName().."NewBuff"..i):SetID(i);
				getglobal(this:GetName().."NewBuff"..i):Show();
			else
				getglobal(this:GetName().."NewBuff"..i):Hide();
			end
		end
	end
	
	if ( ArchaeologistVars["PDEBUFFS"] == 1 ) then
		for i=1, ArchaeologistVarData["PDEBUFFNUM"].max do
			getglobal(this:GetName().."NewDebuff"..i):Hide();
		end
	else
		local texture;
		for i=1, ArchaeologistVarData["PDEBUFFNUM"].max do
			texture = UnitDebuff("party"..this:GetID(), i);
			if (texture) and (i <= ArchaeologistVars["PDEBUFFNUM"]) then
				getglobal(this:GetName().."NewDebuff"..i.."Icon"):SetTexture(texture);
				getglobal(this:GetName().."NewDebuff"..i):SetID(i);
				getglobal(this:GetName().."NewDebuff"..i):Show();
			else
				getglobal(this:GetName().."NewDebuff"..i):Hide();
			end
		end
	end
	
end

function Archaeologist_PartyMemberFrame_RefreshPetBuffs(id)
	if ( not id ) then
		id = this:GetID();
	end
	local texture;
	local petFrame = "PartyMemberFrame"..id.."PetFrame"
	if ( ArchaeologistVars["PPTBUFFS"] == 1 ) then
		for i=1, ArchaeologistVarData["PPTBUFFNUM"].max do
			getglobal(petFrame.."NewBuff"..i):Hide();
		end
	else
		for i=1, ArchaeologistVarData["PPTBUFFNUM"].max do
			texture = UnitBuff("partypet"..id, i);
			if ( texture ) and (i <= ArchaeologistVars["PPTBUFFNUM"]) then
				getglobal(petFrame.."NewBuff"..i.."Icon"):SetTexture(texture);
				getglobal(petFrame.."NewBuff"..i):Show();
			else
				getglobal(petFrame.."NewBuff"..i):Hide();
			end
		end
	end
	
	if ( ArchaeologistVars["PPTDEBUFFS"] == 1 ) then
		for i=1, ArchaeologistVarData["PPTDEBUFFNUM"].max do
			getglobal(petFrame.."NewDebuff"..i):Hide();
		end
	else
		for i=1, ArchaeologistVarData["PPTDEBUFFNUM"].max do
			texture = UnitDebuff("partypet"..id, i);
			if ( texture ) and (i <= ArchaeologistVars["PPTDEBUFFNUM"]) then
				getglobal(petFrame.."NewDebuff"..i.."Icon"):SetTexture(texture);
				getglobal(petFrame.."NewDebuff"..i):Show();
			else
				getglobal(petFrame.."NewDebuff"..i):Hide();
			end
		end
	end
end

function Archaeologist_PetFrame_RefreshBuffs()
	
	local texture;
	if ( ArchaeologistVars["PTBUFFS"] == 1 ) then
		for i=1, ArchaeologistVarData["PTBUFFNUM"].max do
			getglobal("PetFrameNewBuff"..i):Hide();
		end
	else
		for i=1, ArchaeologistVarData["PTBUFFNUM"].max do
			texture = UnitBuff("pet", i);
			if ( texture ) and (i <= ArchaeologistVars["PTBUFFNUM"]) then
				getglobal("PetFrameNewBuff"..i.."Icon"):SetTexture(texture);
				getglobal("PetFrameNewBuff"..i):SetID(i);
				getglobal("PetFrameNewBuff"..i):Show();
			else
				getglobal("PetFrameNewBuff"..i):Hide();
			end
		end
	end
	
	if ( ArchaeologistVars["PTDEBUFFS"] == 1 ) then
		for i=1, ArchaeologistVarData["PTDEBUFFNUM"].max do
			getglobal("PetFrameNewDebuff"..i):Hide();
		end
	else
		local texture;
		for i=1, ArchaeologistVarData["PTDEBUFFNUM"].max do
			texture = UnitDebuff("pet", i);
			if (texture) and (i <= ArchaeologistVars["PTDEBUFFNUM"]) then
				getglobal("PetFrameNewDebuff"..i.."Icon"):SetTexture(texture);
				getglobal("PetFrameNewDebuff"..i):SetID(i);
				getglobal("PetFrameNewDebuff"..i):Show();
			else
				getglobal("PetFrameNewDebuff"..i):Hide();
			end
		end
	end
	
end

function Archaeologist_PetFrame_UpdateDebuffLocations()
	if (ArchaeologistVars["DEBUFFALT"] == 1) then
		if ( ArchaeologistVars["PTBUFFS"] == 1 ) then
			PetFrameNewDebuff1:ClearAllPoints();
			PetFrameNewDebuff1:SetPoint("TOPLEFT", "PetFrame", "TOPLEFT", 48, -42);
		else
			PetFrameNewDebuff1:ClearAllPoints();
			PetFrameNewDebuff1:SetPoint("TOP", "PetFrameNewBuff1", "BOTTOM", 0, -2);
		end
	else
		PetFrameNewDebuff1:ClearAllPoints();
		PetFrameNewDebuff1:SetPoint("TOPLEFT", "PetFrame", "TOPLEFT", 120, -24);
	end
end

function Archaeologist_PartyFrame_UpdateDebuffLocations()
	if (ArchaeologistVars["DEBUFFALT"] == 1) then
		if ( ArchaeologistVars["PBUFFS"] == 1 ) then
			for i=1, 4 do
				getglobal("PartyMemberFrame"..i.."NewDebuff1"):ClearAllPoints();
				getglobal("PartyMemberFrame"..i.."NewDebuff1"):SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPLEFT", 124, -12);
			end
		else
			for i=1, 4 do
				getglobal("PartyMemberFrame"..i.."NewDebuff1"):ClearAllPoints();
				getglobal("PartyMemberFrame"..i.."NewDebuff1"):SetPoint("TOP", "PartyMemberFrame"..i.."NewBuff1", "BOTTOM", 0, -2);
			end
		end
	else
		for i=1, 4 do
			getglobal("PartyMemberFrame"..i.."NewDebuff1"):ClearAllPoints();
			getglobal("PartyMemberFrame"..i.."NewDebuff1"):SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPLEFT", 124, -14);
		end
	end
	Archaeologist_UpdatePartyPetLocations();
end

function Archaeologist_PartyPetFrame_UpdateDebuffLocations()
	if ( ArchaeologistVars["PPTBUFFS"] == 1 ) then
		for i=1, 4 do
			getglobal("PartyMemberFrame"..i.."PetFrameNewDebuff1"):ClearAllPoints();
			getglobal("PartyMemberFrame"..i.."PetFrameNewDebuff1"):SetPoint("TOPLEFT", "PartyMemberFrame"..i.."PetFrame", "TOPLEFT", 24, -16);
		end
	else
		for i=1, 4 do
			getglobal("PartyMemberFrame"..i.."PetFrameNewDebuff1"):ClearAllPoints();
			getglobal("PartyMemberFrame"..i.."PetFrameNewDebuff1"):SetPoint("TOP", "PartyMemberFrame"..i.."PetFrameNewBuff1", "BOTTOM", 0, -2);
		end
	end
	Archaeologist_UpdatePartyMemberLocations();
end


function Archaeologist_UpdatePartyMemberBuffs()
	local tempThis = this;
	for i=1, MAX_PARTY_MEMBERS do
        if ( GetPartyMember(i) ) then
			this = getglobal("PartyMemberFrame"..i);
            Archaeologist_PartyMemberFrame_RefreshBuffs()
        end
    end
	this = tempThis;
end

function Archaeologist_UpdatePartyPetBuffs()
	PartyMemberFrame_RefreshPetBuffs(1);
	PartyMemberFrame_RefreshPetBuffs(2);
	PartyMemberFrame_RefreshPetBuffs(3);
	PartyMemberFrame_RefreshPetBuffs(4);
end

function Archaeologist_UpdatePartyPetLocations()
	PartyMemberFrame_UpdatePet(1);
	PartyMemberFrame_UpdatePet(2);
	PartyMemberFrame_UpdatePet(3);
	PartyMemberFrame_UpdatePet(4);
end

function Archaeologist_PartyMemberBuffs_Update()
	--only show buff tooltip on mouseover if buffs are hidden
	if (arg1 == "pet") then
		return (ArchaeologistVars["PTBUFFS"] == 1);
	end
	return (ArchaeologistVars["PBUFFS"] == 1);
end


function Archaeologist_TurnOffPartyBuffs(toggle)
	Archaeologist_UpdatePartyMemberBuffs();
	Archaeologist_PartyFrame_UpdateDebuffLocations();
end

function Archaeologist_TurnOffPartyPetBuffs(toggle)
	Archaeologist_UpdatePartyPetBuffs();
	Archaeologist_PartyPetFrame_UpdateDebuffLocations();
end

function Archaeologist_TurnOffPetBuffs(toggle)
	Archaeologist_PetFrame_RefreshBuffs();
	Archaeologist_PetFrame_UpdateDebuffLocations();
end


function Archaeologist_TurnOffPartyDebuffs(toggle)
	Archaeologist_UpdatePartyMemberBuffs();
	Archaeologist_UpdatePartyPetLocations();
end

function Archaeologist_TurnOffPartyPetDebuffs(toggle)
	Archaeologist_UpdatePartyPetBuffs();
	Archaeologist_UpdatePartyMemberLocations();
end

function Archaeologist_TurnOffPetDebuffs(toggle)
	Archaeologist_PetFrame_RefreshBuffs();
end


function Archaeologist_SetPartyBuffs(count)
	if (count) then
		Archaeologist_UpdatePartyMemberBuffs();
	end
end

function Archaeologist_SetPartyPetBuffs(count)
	if (count) then
		Archaeologist_UpdatePartyPetBuffs();
	end
end

function Archaeologist_SetPetBuffs(count)
	if (count) then
		Archaeologist_PetFrame_RefreshBuffs();
	end
end


function Archaeologist_SetPartyDebuffs(count)
	if (count) then
		Archaeologist_UpdatePartyMemberBuffs();
	end
end

function Archaeologist_SetPartyPetDebuffs(count)
	if (count) then
		Archaeologist_UpdatePartyPetBuffs();
	end
end

function Archaeologist_SetPetDebuffs(count)
	if (count) then
		Archaeologist_PetFrame_RefreshBuffs();
	end
end

-- <= == == == == == == == == == == == == =>
-- => Target Buffs
-- <= == == == == == == == == == == == == =>

function Archaeologist_HideOrigTargetBuffs()
	for i=1, MAX_TARGET_BUFFS do
		getglobal("TargetFrameBuff"..i):Hide();
	end
	for i=1, MAX_TARGET_DEBUFFS do
		getglobal("TargetFrameDebuff"..i):Hide();
	end
	--for i=1, MAX_PARTY_DEBUFFS do
	--	getglobal("PartyMemberFrame"..i.."PetFrameDebuff"):Hide();
	--end
end

function Archaeologist_TargetDebuffButton_Update()
	
	local button, debuff, debuffButton, buff, buffButton, debuffCount, debuffApplications;
	local numBuffs = 0;
	TargetFrame.feigning = nil;
	for i=1, ArchaeologistVarData["TBUFFNUM"].max do
		buff = UnitBuff("target", i);
		if (buff == "Interface\\Icons\\Ability_Rogue_FeignDeath") then
			TargetFrame.feigning = true;
		end
		button = getglobal("TargetFrameNewBuff"..i);
		if ( buff ) and (i <= ArchaeologistVars["TBUFFNUM"]) and (ArchaeologistVars["TBUFFS"] == 0) then
			getglobal("TargetFrameNewBuff"..i.."Icon"):SetTexture(buff);
			button:Show();
			button.id = i;
			numBuffs = numBuffs + 1;
		else
			button:Hide();
		end
	end
	local numDebuffs = 0;
	for i=1, ArchaeologistVarData["TDEBUFFNUM"].max do
		debuff, debuffApplications = UnitDebuff("target", i);
		button = getglobal("TargetFrameNewDebuff"..i);
		if ( debuff ) and (i <= ArchaeologistVars["TDEBUFFNUM"]) and (ArchaeologistVars["TDEBUFFS"] == 0) then
			getglobal("TargetFrameNewDebuff"..i.."Icon"):SetTexture(debuff);
			debuffCount = getglobal("TargetFrameNewDebuff"..i.."Count");
			if ( debuffApplications > 1 ) then
				debuffCount:SetText(debuffApplications);
				debuffCount:Show();
			else
				debuffCount:Hide();
			end
			button:Show();
			numDebuffs = numDebuffs + 1;
		else
			button:Hide();
		end
		button.id = i;
	end
	
	Archaeologist_TargetBuffs_UpdateAlignment(numBuffs, numDebuffs);
end

function Archaeologist_TargetBuffs_UpdateAlignment(numBuffs, numDebuffs)
	
	-- Position buffs depending on whether the targeted unit is friendly or not
	local topBuffPrefix = "TargetFrameNewDebuff";
	local bottomBuffPrefix = "TargetFrameNewBuff";
	local numTopBuffs = numDebuffs;
	local numBottomBuffs = numBuffs;
	if (UnitIsFriend("player", "target")) then
		topBuffPrefix = "TargetFrameNewBuff";
		bottomBuffPrefix = "TargetFrameNewDebuff";
		numTopBuffs = numBuffs;
		numBottomBuffs = numDebuffs;
	end
	
	TargetFrameNewBuff1:ClearAllPoints();
	TargetFrameNewBuff9:ClearAllPoints();
	TargetFrameNewDebuff1:ClearAllPoints();
	TargetFrameNewDebuff9:ClearAllPoints();
	
	getglobal(topBuffPrefix..1):SetPoint("TOPLEFT", "TargetFrame", "BOTTOMLEFT", 5, 32);
	if (ArchaeologistVars["TBUFFALT"] == 1) and (numTopBuffs >= 9) then
		getglobal(topBuffPrefix..9):SetPoint("TOPLEFT", topBuffPrefix..1, "BOTTOMLEFT", 0, -2);
		getglobal(bottomBuffPrefix..1):SetPoint("TOPLEFT", topBuffPrefix..9, "BOTTOMLEFT", 0, -2);
	else
		getglobal(topBuffPrefix..9):SetPoint("LEFT", topBuffPrefix..8, "RIGHT", 3, 0);
		getglobal(bottomBuffPrefix..1):SetPoint("TOPLEFT", topBuffPrefix..1, "BOTTOMLEFT", 0, -2);
	end
	if (ArchaeologistVars["TBUFFALT"] == 1) and (numBottomBuffs >= 9) then
		getglobal(bottomBuffPrefix..9):SetPoint("TOPLEFT", bottomBuffPrefix..1, "BOTTOMLEFT", 0, -2);
	else
		getglobal(bottomBuffPrefix..9):SetPoint("LEFT", bottomBuffPrefix..8, "RIGHT", 3, 0);
	end
	
end

function Archaeologist_TurnOffTargetBuffs(toggle)
	TargetDebuffButton_Update();
end

function Archaeologist_TurnOffTargetDebuffs(toggle)
	TargetDebuffButton_Update();
end


function Archaeologist_SetTargetBuffs(count)
	if (count) then
		TargetDebuffButton_Update();
	end
end


function Archaeologist_SetTargetDebuffs(count)
	if (count) then
		TargetDebuffButton_Update();
	end
end

-- <= == == == == == == == == == == == == =>
-- => Alternate Options
-- <= == == == == == == == == == == == == =>

function Archaeologist_SetAltDebuffLocation(toggle)
	Archaeologist_PetFrame_UpdateDebuffLocations();
	Archaeologist_SetPetFrameHappinessLocation();
	Archaeologist_PartyFrame_UpdateDebuffLocations();
end

function Archaeologist_SetUnitBarValuePercentSwap(unit, barType, toggle)
	local statusBar = ArchaeologistStatusBars[unit].frame[barType];
	Archaeologist_TextStringAltTextStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_SetPetFrameHappinessLocation()
	if  (ArchaeologistVars["PETHP2"] == "on") or (ArchaeologistVars["PETHP2"] == "mouseover") or 
		(ArchaeologistVars["PETMP2"] == "on") or (ArchaeologistVars["PETMP2"] == "mouseover") or
		((ArchaeologistVars["DEBUFFALT"] == 0) and (ArchaeologistVars["PTDEBUFFS"] == 0)) then
		--alt position
		PetFrameHappiness:ClearAllPoints();
		PetFrameHappiness:SetPoint("TOPRIGHT", "PetFrame", "BOTTOMLEFT", 8, 15);
	else
		--normal position
		PetFrameHappiness:ClearAllPoints();
		PetFrameHappiness:SetPoint("LEFT", "PetFrame", "RIGHT", -7, -4);
	end

end

-- <= == == == == == == == == == == == == =>
-- => Font Options
-- <= == == == == == == == == == == == == =>

function Archaeologist_SetPrimaryHPColor(colorTable)
	for unit, data in ArchaeologistStatusBars do
		data.frame.healthbar.TextString:SetTextColor(colorTable.r, colorTable.g, colorTable.b, colorTable.opacity);
	end
end

function Archaeologist_SetPrimaryMPColor(colorTable)
	for unit, data in ArchaeologistStatusBars do
		data.frame.manabar.TextString:SetTextColor(colorTable.r, colorTable.g, colorTable.b, colorTable.opacity);
	end
end

function Archaeologist_SetSecondaryHPColor(colorTable)
	for unit, data in ArchaeologistStatusBars do
		data.frame.healthbar.TextString2:SetTextColor(colorTable.r, colorTable.g, colorTable.b, colorTable.opacity);
	end
end

function Archaeologist_SetSecondaryMPColor(colorTable)
	for unit, data in ArchaeologistStatusBars do
		data.frame.manabar.TextString2:SetTextColor(colorTable.r, colorTable.g, colorTable.b, colorTable.opacity);
	end
end

function Archaeologist_SetHPMPLargeFont(key)
	if (not key) then
		return;
	end
	local font = ArchaeologistFonts[key];
	if (not font) then
		-- Will reset to default on next Reload
		return;
	end
	local frame;
	local size = ArchaeologistVars["HPMPLARGESIZE"];
	for i, unit in {"player", "target"} do
		frame = ArchaeologistStatusBars[unit].frame;
		frame.healthbar.TextString:SetFont(font, size);
		frame.healthbar.TextString2:SetFont(font, size);
		frame.manabar.TextString:SetFont(font, size);
		frame.manabar.TextString2:SetFont(font, size);
	end
	Archaeologist_SetHPMPLargeTextSize(size); --Size corrects refonting problem with linebreaks
end

function Archaeologist_SetHPMPSmallFont(key)
	if (not key) then
		return;
	end
	local font = ArchaeologistFonts[key];
	if (not font) then
		-- Will reset to default on next Reload
		return;
	end
	local frame;
	local size = ArchaeologistVars["HPMPSMALLSIZE"];
	for i, unit in {"party1", "party2", "party3", "party4", "pet"} do
		frame = ArchaeologistStatusBars[unit].frame;
		frame.healthbar.TextString:SetFont(font, size);
		frame.healthbar.TextString2:SetFont(font, size);
		frame.manabar.TextString:SetFont(font, size);
		frame.manabar.TextString2:SetFont(font, size);
	end
	Archaeologist_SetHPMPSmallTextSize(size); --Size corrects refonting problem with linebreaks
end

-- <= == == == == == == == == == == == == =>
-- => MobHealth2 Compatibility
-- <= == == == == == == == == == == == == =>


function Archaeologist_MobHealth_OnEvent(event)
	if (event == "PLAYER_TARGET_CHANGED") then
		--Archaeologist_TargetCheckDead();
		TextStatusBar_UpdateTextString(ArchaeologistStatusBars.target.frame.healthbar);
		--Sea.io.print("MobHealth2: PLAYER_TARGET_CHANGED");
	end
end


function Archaeologist_EnableMobHealth(toggle)
	local frame;
	if (MI2_MobHealthFrame) then
		frame = MI2_MobHealthFrame;
	elseif (MobHealthFrame) then
		frame = MobHealthFrame;
	else
		return;
	end
	if (toggle == 1) then
		frame:Hide();
	else
		frame:Show();
	end
end

-- <= == == == == == == == == == == == == =>
-- => Class Icons
-- <= == == == == == == == == == == == == =>

function Archaeologist_TurnOnPartyClassIcon(toggle)
	Archaeologist_UpdatePartyClassIcons();
	if (toggle == 1) then
		for i=1, 4 do
			getglobal("PartyMemberFrame"..i.."MasterIcon"):ClearAllPoints();
			getglobal("PartyMemberFrame"..i.."MasterIcon"):SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPLEFT", 15, 5);
		end
	else
		for i=1, 4 do
			getglobal("PartyMemberFrame"..i.."MasterIcon"):ClearAllPoints();
			getglobal("PartyMemberFrame"..i.."MasterIcon"):SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPLEFT", 32, 0);
		end
	end
end

function Archaeologist_UpdatePartyClassIcons()
	if (ArchaeologistVars["PARTYCLASSICON"] == 1) then
		local localizedClass, englishClass, icon;
		for i=1, GetNumPartyMembers() do
			localizedClass, englishClass = UnitClass("party"..i);
			icon = getglobal("PartyMemberFrame"..i.."ClassIcon");
			if (englishClass) then
				if (not icon:IsVisible()) then
					icon:Show();
				end
				getglobal(icon:GetName().."Texture"):SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\ClassIcons\\"..Sea.string.capitalizeWords(englishClass));
			else
				if (icon:IsVisible()) then
					icon:Hide();
				end
			end
		end
	else
		for i=1, GetNumPartyMembers() do
			icon = getglobal("PartyMemberFrame"..i.."ClassIcon");
			if (icon:IsVisible()) then
				icon:Hide();
			end
		end
	end
end

function Archaeologist_TurnOnTargetClassIcon(toggle)
	Archaeologist_UpdateTargetClassIcon();
end

function Archaeologist_UpdateTargetClassIcon()
	if (ArchaeologistVars["TARGETCLASSICON"] == 1) then
		if (UnitIsPlayer("target")) then
			local localizedClass, englishClass = UnitClass("target");
			if (not TargetFrameClassIcon:IsVisible()) then
				TargetFrameClassIcon:Show();
			end
			TargetFrameClassIconTexture:SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\ClassIcons\\"..Sea.string.capitalizeWords(englishClass));
		else
			TargetFrameClassIcon:Hide();
		end
	else
		if (TargetFrameClassIcon:IsVisible()) then
			TargetFrameClassIcon:Hide();
		end
	end
end

function Archaeologist_TurnOnPlayerClassIcon(toggle)
	Archaeologist_UpdatePlayerClassIcon();
	if (toggle == 1) then
		PlayerMasterIcon:ClearAllPoints();
		PlayerMasterIcon:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", 65, -2);
	else
		PlayerMasterIcon:ClearAllPoints();
		PlayerMasterIcon:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", 80, -10);
	end
end

function Archaeologist_UpdatePlayerClassIcon()
	if (ArchaeologistVars["PLAYERCLASSICON"] == 1) then
		local localizedClass, englishClass = UnitClass("player");
		if (not PlayerFrameClassIcon:IsVisible()) then
			PlayerFrameClassIcon:Show();
		end
		PlayerFrameClassIconTexture:SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\ClassIcons\\"..Sea.string.capitalizeWords(englishClass));
	else
		if (PlayerFrameClassIcon:IsVisible()) then
			PlayerFrameClassIcon:Hide();
		end
	end
end

function Archaeologist_ClassIcon_OnLoad()
	this:SetFrameLevel(this:GetFrameLevel()+2);
end

function Archaeologist_EnableClassPortrait(toggle)
	if (toggle == 1) then
		for unit, data in ArchaeologistStatusBars do
			if (unit ~= "pet") then
				if (UnitIsPlayer(unit)) then
					local localizedClass, englishClass = UnitClass(unit);
					if (englishClass) then
						data.frame.portrait:SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\PortraitIcons\\"..Sea.string.capitalizeWords(englishClass));
					end
				end
			end
		end
	else
		SetPortraitTexture(PlayerFrame.portrait, "player");
		SetPortraitTexture(TargetFrame.portrait, "target");
		SetPortraitTexture(PartyMemberFrame1.portrait, "party1");
		SetPortraitTexture(PartyMemberFrame2.portrait, "party2");
		SetPortraitTexture(PartyMemberFrame3.portrait, "party3");
		SetPortraitTexture(PartyMemberFrame4.portrait, "party4");
	end
end

function Archaeologist_UnitFrame_Update_After()
	if (ArchaeologistVars["CLASSPORTRAIT"] == 1) then
		if (UnitIsPlayer(this.unit)) then
			local localizedClass, englishClass = UnitClass(this.unit);
			if (englishClass) then
				this.portrait:SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\PortraitIcons\\"..Sea.string.capitalizeWords(englishClass));
			end
		end
	end
end

function Archaeologist_UnitFrame_OnEvent_After(event)
	if (ArchaeologistVars["CLASSPORTRAIT"] == 1) then
		if ( (event == "UNIT_PORTRAIT_UPDATE") and (arg1 == this.unit) ) then
			if (UnitIsPlayer(this.unit)) then
				local localizedClass, englishClass = UnitClass(this.unit);
				if (englishClass) then
					this.portrait:SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\PortraitIcons\\"..Sea.string.capitalizeWords(englishClass));
				end
			end
		end
	end
end

-- <= == == == == == == == == == == == == =>
-- => Helpful Funcs
-- <= == == == == == == == == == == == == =>

-- 1 => 0, 0 => 1
function BinaryInvert(oneZero)
	if oneZero == 1 then
		return 0;
	else 
		return 1;
	end
end

function Archaeologist_PartyIndexFromName(name)
	for i=1, GetNumPartyMembers() do
		if ( name == UnitName("party"..i) ) then
			return i;
		end
	end
end


function Archaeologist_PartyIndexFromUnit(unit)
	if (type(unit) == "string") then
		if ( strsub(unit,0, string.len(unit)-1) == "party" ) then
			local partyIndex = tonumber( strsub(unit,string.len(unit)) );
			return partyIndex;
		end
	end
end


function Archaeologist_PartyIndexFromFrame(frame)
	local frameName = frame:GetName();
	if (frameName) then
		if ( strsub(frameName,0, string.len(frameName)-1) == "PartyMemberFrame" ) then
			local frameIndex = frame:GetID();
			if (frameIndex > 0) then
				return frameIndex;
			end
		end
	end
end

-- <= == == == == == == == == == == == =>
-- => Presets
-- <= == == == == == == == == == == == =>

function Archaeologist_SetValuePercentPresets(index)
	if (index) then
		local id = MCom.getComID("/arch");
		if (index == 1) then
			-- Values on the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_ON);
			end
			
			MCom.SlashCommandHandler(id, "targethpswap "..ARCHAEOLOGIST_OFF);
			MCom.SlashCommandHandler(id, "usehpvalue "..ARCHAEOLOGIST_ON);
			if (MobHealth_OnEvent) then
				MCom.SlashCommandHandler(id, "mobhealth "..ARCHAEOLOGIST_ON);
			end
		
		elseif (index == 2) then
			-- Values next to the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_ON);
				
				MCom.SlashCommandHandler(id, v.."hpinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_OFF);
			end
			
			MCom.SlashCommandHandler(id, "targethpswap "..ARCHAEOLOGIST_ON);
			MCom.SlashCommandHandler(id, "usehpvalue "..ARCHAEOLOGIST_ON);
			if (MobHealth_OnEvent) then
				MCom.SlashCommandHandler(id, "mobhealth "..ARCHAEOLOGIST_ON);
			end
		
		elseif (index == 3) then
			-- Percentage on the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_OFF);
			end
			
			MCom.SlashCommandHandler(id, "usehpvalue "..ARCHAEOLOGIST_OFF);
			
		elseif (index == 4) then
			-- Percentage next to the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_ON);
				
				MCom.SlashCommandHandler(id, v.."hpinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_ON);
			end
			
			MCom.SlashCommandHandler(id, "usehpvalue "..ARCHAEOLOGIST_OFF);
			
		elseif (index == 5) then
			-- Percentage on the Bars, Values next to the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_ON);
				
				MCom.SlashCommandHandler(id, v.."hpinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_OFF);
			end
			
			MCom.SlashCommandHandler(id, "usehpvalue "..ARCHAEOLOGIST_OFF);
			if (MobHealth_OnEvent) then
				MCom.SlashCommandHandler(id, "mobhealth "..ARCHAEOLOGIST_ON);
			end
			
		elseif (index == 6) then
			-- Values on the Bars, Percentage next to the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_ON);
				
				MCom.SlashCommandHandler(id, v.."hpinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_ON);
			end
			
			MCom.SlashCommandHandler(id, "usehpvalue "..ARCHAEOLOGIST_OFF);
			if (MobHealth_OnEvent) then
				MCom.SlashCommandHandler(id, "mobhealth "..ARCHAEOLOGIST_ON);
			end
			
		end
		
		if (Khaos) and (KhaosFrame:IsVisible()) then
			Khaos.refresh(false, false, true);
		elseif (CosmosMasterFrame) and (CosmosMasterFrame:IsVisible()) and (not CosmosMasterFrame_IsLoading) then
			CosmosMaster_DrawData();
		end
	end
end

function Archaeologist_SetPrefixPresets(index)
	if (index) then
		local id = MCom.getComID("/arch");
		if (index == 1) then
			-- All off
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hpnoprefix "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mpnoprefix "..ARCHAEOLOGIST_ON);
			end
			
			MCom.SlashCommandHandler(id, "playerxpnoprefix "..ARCHAEOLOGIST_ON);
			MCom.SlashCommandHandler(id, "petxpnoprefix "..ARCHAEOLOGIST_ON);
		
		elseif (index == 2) then
			-- All on
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hpnoprefix "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpnoprefix "..ARCHAEOLOGIST_OFF);
			end
			
			MCom.SlashCommandHandler(id, "playerxpnoprefix "..ARCHAEOLOGIST_OFF);
			MCom.SlashCommandHandler(id, "petxpnoprefix "..ARCHAEOLOGIST_OFF);
		
		elseif (index == 3) then
			-- All default
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hpnoprefix "..ArchaeologistVarData[strupper(v.."hpnoprefix")].default);
				MCom.SlashCommandHandler(id, v.."mpnoprefix "..ArchaeologistVarData[strupper(v.."mpnoprefix")].default);
			end
			
			MCom.SlashCommandHandler(id, "playerxpnoprefix "..ArchaeologistVarData[strupper("playerxpnoprefix")].default);
			MCom.SlashCommandHandler(id, "petxpnoprefix "..ArchaeologistVarData[strupper("petxpnoprefix")].default);
		
		end
		
		if (Khaos) and (KhaosFrame:IsVisible()) then
			Khaos.refresh(false, false, true);
		elseif (CosmosMasterFrame) and (CosmosMasterFrame:IsVisible()) and (not CosmosMasterFrame_IsLoading) then
			CosmosMaster_DrawData();
		end
	end
end

-- <= == == == == == == == == == == == =>
-- => Configuration Registeration
-- <= == == == == == == == == == == == =>

function Archaeologist_RegisterForMCom()	
	
	local optionSet = {};
	
	-- <= == == == == == == == == == == == =>
	-- => Presets Registering
	-- <= == == == == == == == == == == == =>
	
	table.insert(optionSet, {
		id="PresetsHeader";
		text=ARCHAEOLOGIST_CONFIG_PRESETS;
		helptext=ARCHAEOLOGIST_CONFIG_PRESETS;
		type=K_HEADER;
		difficulty=1;
	});
	
	table.insert(optionSet, {
		id="Preset1ValuesOnBars";
		type=K_BUTTON;
		text=ARCHAEOLOGIST_CONFIG_VALUES_ON_BARS;
		helptext=ARCHAEOLOGIST_CONFIG_VALUES_ON_BARS;
		callback=function()Archaeologist_SetValuePercentPresets(1)end;
		setup={buttonText=ARCHAEOLOGIST_CONFIG_SET};
		mcopts = {
			subcom = string.lower("Preset1");
		};
	});
	
	table.insert(optionSet, {
		id="Preset2ValuesNextToBars";
		type=K_BUTTON;
		text=ARCHAEOLOGIST_CONFIG_VALUES_NEXTTO_BARS;
		helptext=ARCHAEOLOGIST_CONFIG_VALUES_NEXTTO_BARS;
		callback=function()Archaeologist_SetValuePercentPresets(2)end;
		setup={buttonText=ARCHAEOLOGIST_CONFIG_SET};
		mcopts = {
			subcom = string.lower("Preset2");
		};
	});
	
	table.insert(optionSet, {
		id="Preset3PercentageOnBars";
		type=K_BUTTON;
		text=ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_BARS;
		helptext=ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_BARS;
		callback=function()Archaeologist_SetValuePercentPresets(3)end;
		setup={buttonText=ARCHAEOLOGIST_CONFIG_SET};
		mcopts = {
			subcom = string.lower("Preset3");
		};
	});
	
	table.insert(optionSet, {
		id="Preset4PercentageNextToBars";
		type=K_BUTTON;
		text=ARCHAEOLOGIST_CONFIG_PERCENTAGE_NEXTTO_BARS;
		helptext=ARCHAEOLOGIST_CONFIG_PERCENTAGE_NEXTTO_BARS;
		callback=function()Archaeologist_SetValuePercentPresets(4)end;
		setup={buttonText=ARCHAEOLOGIST_CONFIG_SET};
		mcopts = {
			subcom = string.lower("Preset4");
		};
	});
	
	table.insert(optionSet, {
		id="Preset5PercentageOnValuesNextToBars";
		type=K_BUTTON;
		text=ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_VALUES_NEXTTO_BARS;
		helptext=ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_VALUES_NEXTTO_BARS;
		callback=function()Archaeologist_SetValuePercentPresets(5)end;
		setup={buttonText=ARCHAEOLOGIST_CONFIG_SET};
		mcopts = {
			subcom = string.lower("Preset5");
		};
	});
	
	table.insert(optionSet, {
		id="Preset6ValuesOnPercentageNextToBars";
		type=K_BUTTON;
		text=ARCHAEOLOGIST_CONFIG_VALUES_ON_PERCENTAGE_NEXTTO_BARS;
		helptext=ARCHAEOLOGIST_CONFIG_VALUES_ON_PERCENTAGE_NEXTTO_BARS;
		callback=function()Archaeologist_SetValuePercentPresets(6)end;
		setup={buttonText=ARCHAEOLOGIST_CONFIG_SET};
		mcopts = {
			subcom = string.lower("Preset6");
		};
	});
	
	table.insert(optionSet, {
		id="Preset1PrefixesOff";
		type=K_BUTTON;
		text=ARCHAEOLOGIST_CONFIG_PREFIXES_OFF;
		helptext=ARCHAEOLOGIST_CONFIG_PREFIXES_OFF;
		callback=function()Archaeologist_SetPrefixPresets(1)end;
		setup={buttonText=ARCHAEOLOGIST_CONFIG_SET};
		mcopts = {
			subcom = string.lower("PrefixOff");
		};
	});
	
	table.insert(optionSet, {
		id="Preset1PrefixesOn";
		type=K_BUTTON;
		text=ARCHAEOLOGIST_CONFIG_PREFIXES_ON;
		helptext=ARCHAEOLOGIST_CONFIG_PREFIXES_ON;
		callback=function()Archaeologist_SetPrefixPresets(2)end;
		setup={buttonText=ARCHAEOLOGIST_CONFIG_SET};
		mcopts = {
			subcom = string.lower("PrefixOn");
		};
	});
	
	table.insert(optionSet, {
		id="Preset1PrefixesDefault";
		type=K_BUTTON;
		text=ARCHAEOLOGIST_CONFIG_PREFIXES_DEFAULT;
		helptext=ARCHAEOLOGIST_CONFIG_PREFIXES_DEFAULT;
		callback=function()Archaeologist_SetPrefixPresets(3)end;
		setup={buttonText=ARCHAEOLOGIST_CONFIG_SET};
		mcopts = {
			subcom = string.lower("PrefixDefault");
		};
	});
	
	
	-- <= == == == == == == == == == == == =>
	-- => Looped Registering
	-- <= == == == == == == == == == == == =>
	
	local varPrefixes = { "PLAYER", "PARTY", "PET", "TARGET" };
	
	table.sort(varPrefixes);
	for index, varPrefix in varPrefixes do
	
		local header = {
			id = Sea.string.capitalizeWords(varPrefix).."Header";
			type = K_HEADER;
			difficulty = 1;
			text = getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP");
			helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP_INFO");
		};

		table.insert(optionSet, header);
		
		local keyList = Sea.table.getKeyList(ArchaeologistVarData);
		local sorter = function(a,b) 
			if ( type(getglobal("ARCHAEOLOGIST_CONFIG_"..a)) == type(getglobal("ARCHAEOLOGIST_CONFIG_"..b)) and type(getglobal("ARCHAEOLOGIST_CONFIG_"..a)) ~= "nil") then 
				return (getglobal("ARCHAEOLOGIST_CONFIG_"..a) < getglobal("ARCHAEOLOGIST_CONFIG_"..b));
			else
				return false;
			end
		end
		table.sort(keyList, sorter);

		for k, index in keyList do
			local var = ArchaeologistVarData[index];
			if (type(index) == "string") then
				if (strsub(index, 0, string.len(varPrefix)) == varPrefix) then
					
					local f = ArchaeologistVarData[index].func;
					local option;
					if (type(ArchaeologistVarData[index].options) == "table") then
						option = {
							id = ArchaeologistVarData[index].name;
							type = K_PULLDOWN;
							difficulty = 1;
							text = getglobal("ARCHAEOLOGIST_CONFIG_"..index);
							helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..index.."_INFO");
							--feedback = function(state) return Archaeologist_Feedback(index, state.value) end;
							dependencies = ArchaeologistVarData[index].dependencies;

							default = { 
								key = ArchaeologistVarData[index].default; 
							};
							disabled = {
								key = ArchaeologistVarData[index].default;
							};
							setup = {
								options = ArchaeologistVarData[index].options;
								multiSelect = false;
							};
							mcopts = {
								subcom = string.lower(index);
								--subhelp = getglobal("ARCHAEOLOGIST_CONFIG_"..index.."_INFO");
								varchoice = "ArchaeologistVars."..index;
								update = function(varName) f(Sea.util.getValue(varName)); end;
								noupdate = function(varName) f(Sea.util.getValue(varName)); end;
							};
						};
					else
						option = {
							id = ArchaeologistVarData[index].name;
							check = true;
							type = K_TEXT;
							difficulty = 1;
							text = getglobal("ARCHAEOLOGIST_CONFIG_"..index);
							helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..index.."_INFO");
							--feedback = function(state) return Archaeologist_Feedback(index, state.checked) end;
							default = { 
								checked = false; 
							};
							disabled = {
								checked = false;
							};
							dependencies = ArchaeologistVarData[index].dependencies;
							mcopts = {
								subcom = string.lower(index);
								varbool = "ArchaeologistVars."..index;
								update = function(varName) f(Sea.util.getValue(varName)); end;
								noupdate = function(varName) f(Sea.util.getValue(varName)); end;
							};
						};

						if ( ArchaeologistVarData[index].default == 1 ) then 
							option.default.checked = true;
							option.disabled.checked = true;
						end
					end

					table.insert(optionSet, option);
				end
			end
		end
		
	end
	
	-- <= == == == == == == == == == == == =>
	-- => Alternate Options Registering
	-- <= == == == == == == == == == == == =>

	local varPrefix = "ALTOPTS";
	
	local header = {
		id = Sea.string.capitalizeWords(varPrefix).."Header";
		type = K_HEADER;
		difficulty = 2;
		text = getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP");
		helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP_INFO");
	};
	table.insert(optionSet, header);
		
	varPrefixes = { "HPCOLOR", "DEBUFFALT", "TBUFFALT", "CLASSPORTRAIT", "USEHPVALUE" };

	if ( MobHealth_OnEvent ) then
		table.insert(varPrefixes, "MOBHEALTH" );
	end
	
	for index, varPrefix in varPrefixes do
		local f = ArchaeologistVarData[varPrefix].func;
		local option = {
			id = ArchaeologistVarData[varPrefix].name;
			check = true;
			type = K_TEXT;
			difficulty = 2;
			text = getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix);
			helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_INFO");
			--feedback = function(state) return Archaeologist_Feedback(varPrefix, state.checked) end;
			default = { 
				checked = false; 
			};
			disabled = {
				checked = false;
			};
			dependencies = ArchaeologistVarData[varPrefix].dependencies;
			mcopts = {
				subcom = string.lower(varPrefix);
				varbool = "ArchaeologistVars."..varPrefix;
				update = function(varName) f(Sea.util.getValue(varName)); end;
				noupdate = function(varName) f(Sea.util.getValue(varName)); end;
			};
		};
		if ( ArchaeologistVarData[varPrefix].default == 1 ) then 
			option.default.checked = true;
			option.disabled.checked = true;
		end
		
		table.insert(optionSet, option);
	end
	
	-- <= == == == == == == == == == == == =>
	-- => Font Options Registering
	-- <= == == == == == == == == == == == =>
	
	local varPrefix = "FONTOPTS";
	
	local header = {
		id = Sea.string.capitalizeWords(varPrefix).."Header";
		type = K_HEADER;
		difficulty = 3;
		text = getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP");
		helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP_INFO");
	};
	table.insert(optionSet, header);
	
	varPrefixes = { "HPMPLARGE", "HPMPSMALL" };
	
	for index, varPrefix in varPrefixes do
		local id = varPrefix.."FONT";
		local f = ArchaeologistVarData[id].func;
		local option = {
			id = ArchaeologistVarData[id].name;
			type = K_PULLDOWN;
			difficulty = 3;
			text = getglobal("ARCHAEOLOGIST_CONFIG_"..id);
			helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..id);
			--feedback = function(state) return Archaeologist_Feedback(id, state.value) end;
			dependencies = ArchaeologistVarData[id].dependencies;

			default = { 
				key = ArchaeologistVarData[id].default; 
			};
			disabled = {
				key = ArchaeologistVarData[id].default;
			};
			setup = {
				options = ArchaeologistVarData[id].options;
				multiSelect = false;
			};
			mcopts = {
				subcom = string.lower(id);
				subhelp = getglobal("ARCHAEOLOGIST_CONFIG_"..id.."_INFO");
				varchoice = "ArchaeologistVars."..id;
				update = function(varName) f(Sea.util.getValue(varName)); end;
				noupdate = function(varName) f(Sea.util.getValue(varName)); end;
			};
		};
		table.insert(optionSet, option);
		
		local id = varPrefix.."SIZE";
		local f = ArchaeologistVarData[id].func;
		local option = {
			id = ArchaeologistVarData[id].name;
			type = K_SLIDER;
			difficulty = 3;
			text = getglobal("ARCHAEOLOGIST_CONFIG_"..id);
			helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..id);
			--feedback = function(state) return Archaeologist_Feedback(id, state.checked) end;
			dependencies = ArchaeologistVarData[id].dependencies;

			default = { 
				slider = ArchaeologistVarData[id].default; 
			};
			disabled = {
				slider = ArchaeologistVarData[id].default;
			};
			setup = {
				sliderMin = ArchaeologistVarData[id].min;
				sliderMax = ArchaeologistVarData[id].max;
				sliderStep = 1;
				sliderText = getglobal("ARCHAEOLOGIST_CONFIG_"..id.."_SLIDER_TEXT");
			};
			mcopts = {
				subcom = string.lower(id);
				varnum = "ArchaeologistVars."..id;
				update = function(varName) f(Sea.util.getValue(varName)); end;
				noupdate = function(varName) f(Sea.util.getValue(varName)); end;
			};
		};
		if ( ArchaeologistVars[id] == 1 ) then 
			option.default.checked = true;
		end
		table.insert(optionSet, option);			
	end
	
	varPrefixes = { "COLORPHP", "COLORPMP", "COLORSHP", "COLORSMP" };
	
	for index, varPrefix in varPrefixes do
		
		local data = ArchaeologistVarData[varPrefix];
		local subcom = string.lower(varPrefix);
		local varcolor = "ArchaeologistVars."..varPrefix;
		local colorResetFeedback = function(state)
			return string.format(ARCHAEOLOGIST_COLOR_RESET, Sea.string.colorToString(state.color), data.name );
		end
		
		table.insert(
			optionSet,
			{
				id=ArchaeologistVarData[varPrefix].name;
				text=getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix);
				helptext=getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_INFO");
				difficulty=3;
				type=K_COLORPICKER;
				setup= {
					hasOpacity=true;
				};
				default={
					color=ArchaeologistVarData[varPrefix].default;
				};
				disabled={
					color=ArchaeologistVarData[varPrefix].default;
				};
				mcopts = {
					subcom = subcom;
					varcolor = varcolor;
					update = function(varName) data.func(Sea.util.getValue(varName)); end;
					noupdate = function(varName) data.func(Sea.util.getValue(varName)); end;
				};
			}
		);
		table.insert(
			optionSet,
			{
				id=ArchaeologistVarData[varPrefix].name.."Reset";
				text=getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_RESET");
				helptext=getglobal("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_RESET_INFO");
				difficulty=3;
				callback=function(state)
					--Khaos.setSetKey(KhaosCore.getCurrentSet(), data.name, {color=data.default});
					--Khaos.refresh(false, false, true);  --Refresh Visible
					Sea.util.setValue(varcolor, data.default);
					MCom.updateUI(ARCHAEOLOGIST_SUPER_SLASH_COMMAND, subcom)
				end;
				--feedback=colorResetFeedback;
				type=K_BUTTON;
				setup = {
					buttonText=RESET;
				};
			}
		);
	end
	
	-- <= == == == == == == == == == == == =>
	-- => Buff Registering
	-- <= == == == == == == == == == == == =>
	
	local varSections = { 
		PARTYBUFFS		= { "PBUFF", "PDEBUFF" };
		PARTYPETBUFFS   = { "PPTBUFF", "PPTDEBUFF" };
		PETBUFFS		= { "PTBUFF", "PTDEBUFF" };
		TARGETBUFFS		= { "TBUFF", "TDEBUFF" };
	};
	
	for headerPrefix, varPrefixes in varSections do
	
		local header = {
			id = Sea.string.capitalizeWords(headerPrefix).."Header";
			type = K_HEADER;
			difficulty = 2;
			text = getglobal("ARCHAEOLOGIST_CONFIG_"..headerPrefix.."_SEP");
			helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..headerPrefix.."_SEP_INFO");
		};
		table.insert(optionSet, header);
		
		for index, varPrefix in varPrefixes do
			local id = varPrefix.."S";
			local f = ArchaeologistVarData[id].func;
			local option = {
				id = ArchaeologistVarData[id].name;
				check = true;
				type = K_TEXT;
				difficulty = 2;
				text = getglobal("ARCHAEOLOGIST_CONFIG_"..id);
				helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..id.."_INFO");
				--feedback = function(state) return Archaeologist_Feedback(id, state.checked) end;
				default = { 
					checked = false; 
				};
				disabled = {
					checked = false;
				};
				dependencies = ArchaeologistVarData[id].dependencies;
				mcopts = {
					subcom = string.lower(id);
					varbool = "ArchaeologistVars."..id;
					update = function(varName) f(Sea.util.getValue(varName)); end;
					noupdate = function(varName) f(Sea.util.getValue(varName)); end;
				};
			};
			if ( ArchaeologistVars[id] == 1 ) then 
				option.default.checked = true;
			end
			
			table.insert(optionSet, option);
			
			local id = varPrefix.."NUM";
			local f = ArchaeologistVarData[id].func;

			local optionSlider = {
				id = ArchaeologistVarData[id].name;
				type = K_SLIDER;
				difficulty = 2;
				text = getglobal("ARCHAEOLOGIST_CONFIG_"..id);
				helptext = getglobal("ARCHAEOLOGIST_CONFIG_"..id.."_INFO");
				--feedback = function(state) return Archaeologist_Feedback(id, state.slider) end;
				dependencies = ArchaeologistVarData[id].dependencies;

				default = { 
					slider = ArchaeologistVarData[id].default; 
				};
				disabled = {
					slider = ArchaeologistVarData[id].default;
				};
				setup = {
					sliderMin = ArchaeologistVarData[id].min;
					sliderMax = ArchaeologistVarData[id].max;
					sliderStep = 1;
					sliderText = getglobal("ARCHAEOLOGIST_CONFIG_"..id.."_SLIDER_TEXT");
				};
				mcopts = {
					subcom = string.lower(id);
					varnum = "ArchaeologistVars."..id;
					update = function(varName) f(Sea.util.getValue(varName)); end;
					noupdate = function(varName) f(Sea.util.getValue(varName)); end;
				};
			};
			if ( ArchaeologistVars[id] == 1 ) then 
				option.default.checked = true;
			end
			
			table.insert(optionSet, optionSlider);		
		end
	
	end
	
	-- <= == == == == == == == == == == == =>
	-- => Config Set Registering
	-- <= == == == == == == == == == == == =>
			
	MCom.registerSmart(
		{
			supercom = ARCHAEOLOGIST_SUPER_SLASH_COMMAND;
			uifolder = "frames",
			uiset = {
				id = ArchaeologistOptionSetName;
				text = ARCHAEOLOGIST_CONFIG_SEP;
				helptext = ARCHAEOLOGIST_CONFIG_SEP_INFO;
				difficulty = 1;
				options = optionSet;
			}
		}
	);

end

function Archaeologist_Feedback(id, setToValue)
	if (not id) then
		id = "Unknown";
	end
	if (not setToValue) then
		setToValue = "false";
	end
	return string.format(ARCHAEOLOGIST_FEEDBACK_STRING, id, tostring(setToValue));
end
