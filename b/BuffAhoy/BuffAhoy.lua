-- BuffAhoy - by Theck
-- Version 1.95
--
--This is an addon for WoW that adds several powerful functions to a spellcaster's
--library.  This code was designed for a paladin, but several are easily configurable 
--for other spellcasters (ex. BuffCast should work for warlocks, given the right mods to 
--the lua code, and ShoutCast was designed in part for a mage who wanted to broadcast the
--target of his sheeping spell to the party).  This addon is completely self-contained, though
--flexbar is suggested because it makes it easy to identify the action id which you want to pass
--to the script.  This AddOn is not tested for compatibility with Cosmos, but it has been tested
--with Telo's Sidebar, Clock, BuffTimers, LootLink, as well as AutoPotion, Bag_Status_Meters,
--Auctioneer, Enchantrix, LevelReveal, MapNotes, MiniGroup, and CastAway.
--
--I'd like to especially mention that i used the CastAway code as a base for the BuffCast() function,
--hence the close resemblence (no sense coding my own variable sequence when the cycle code already
--existed).  I'd like to thank danboo for doing most of the hard work for me ahead of time. :)




-- Binding Variables
BINDING_HEADER_BUFFAHOY_HEADER = "BuffAhoy Config";
BINDING_NAME_PLAYER_TARGET_BINDING = "PPT Target Self";
BINDING_NAME_PARTY1_TARGET_BINDING = "PPT Target Party 1";
BINDING_NAME_PARTY2_TARGET_BINDING = "PPT Target Party 2";
BINDING_NAME_PARTY3_TARGET_BINDING = "PPT Target Party 3";
BINDING_NAME_PARTY4_TARGET_BINDING = "PPT Target Party 4";
BINDING_NAME_CUSTOM_TARGET = "PPT Target Target";
BINDING_NAME_PLAYER_PET_BINDING = "PPT Target My Pet";
BINDING_NAME_PARTY1_PET_BINDING = "PPT Target Party Pet 1";
BINDING_NAME_PARTY2_PET_BINDING = "PPT Target Party Pet 2";
BINDING_NAME_PARTY3_PET_BINDING = "PPT Target Party Pet 3";
BINDING_NAME_PARTY4_PET_BINDING = "PPT Target Party Pet 4";
BINDING_NAME_BUFFAHOY_SHOW = "Show Buffs CP";
BINDING_NAME_MULTICAST_SHOW = "Show Caster CP";
BINDING_NAME_BUFFCASTSETONE = "Buff Sequence 1";
BINDING_NAME_BUFFCASTSETTWO = "Buff Sequence 2";
BINDING_NAME_BUFFCASTSETTHREE = "Buff Sequence 3";
BINDING_NAME_BUFFAHOYHEALONE = "Heal 1";
BINDING_NAME_BUFFAHOYHEALTWO = "Heal 2";
BINDING_NAME_BUFFAHOYHEALTHREE = "Heal 3";
BINDING_NAME_BUFFAHOYCLEANSEONE = "Cleanse 1";
BINDING_NAME_BUFFAHOYCLEANSETWO = "Cleanse 2";
BINDING_NAME_BUFFAHOYPROTECTONE = "Protect Party Member";
BINDING_NAME_MULTICASTSETONE = "MultiCast Sequence 1";
BINDING_NAME_MULTICASTSETTWO = "MultiCast Sequence 2";
BINDING_NAME_SHOUTCASTONE = "ShoutCast 1";
BINDING_NAME_SHOUTCASTTWO = "ShoutCast 2";
BINDING_NAME_SHOUTCASTTHREE = "ShoutCast 3";
BINDING_NAME_SHOUTCASTFOUR = "ShoutCast 4";

BINDING_NAME_PANIC = "Panic";




-- Local variables
local BA_step_data = {}
local playa = {}
local peta = {}
--local petArray = {}
local petFlag = false
local castFlag = nil
local failFlag = false
local tempverb = 0
local whovar = "party"
local raidArray={}
local PalShaVar;
local plyr
--local BAgotVariables = false;
--local BAgotPlayerName = false;
--local BAinCombat=false;
local BAUseAction

BA_NumWarriors=0
BA_NumMages=0
BA_NumPriests=0
BA_NumDruids=0
BA_NumHunters=0
BA_NumWarlocks=0
BA_NumRogues=0
BA_NumPalSha=0
BA_NumPets=0

local BA_GroupBuff={[BUFFAHOY_PRIEST]=0, 
					[BUFFAHOY_MAGE]=0, 
					[BUFFAHOY_DRUID]=0, 
					[BUFFAHOY_WARRIOR]=0, 
					[BUFFAHOY_HUNTER]=0, 
					[BUFFAHOY_WARLOCK]=0, 
					[BUFFAHOY_ROGUE]=0, 
					[BUFFAHOY_PALADIN]=0, 
					[BUFFAHOY_SHAMAN]=0 }

-- global vars
BA = {}
BuffAhoyNameArray = {}
raidArray["RaidCast"]={}
BA_VERSION=1.95
BADebugVar=false


--myAddons Vars
BuffAhoyDetails = {
name = 'BuffAhoy',
description = 'Buff Sequencer and other tools',
version = '1.95',
releaseDate = 'Jan 6, 2006',
author = 'Theck',
category = MYADDONS_CATEGORY_COMBAT,
frame = 'BuffAhoyFrame',
};


--initialize variables that are used by several functions
playa = {"player", "party1", "party2", "party3", "party4"}
peta = {"pet", "partypet1","partypet2","partypet3","partypet4"}

--Blizzard Registrations
UIPanelWindows["BuffAhoyFrame"] = { area = "left", pushable = 11 };

--load function
function BuffAhoy_OnLoad()

   if BA_UseAction then
	BAUseAction = BA_UseAction;
	BADebug("lOriginal")
   else
	BAUseAction = UseAction;
	BADebug("Default UA")
   end

   BuffAhoyFrame:RegisterEvent("VARIABLES_LOADED");
   BuffAhoyFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
   BuffAhoyFrame:RegisterEvent("SPELLCAST_INTERRUPTED")
   BuffAhoyFrame:RegisterEvent("SPELLCAST_FAILED")
   BuffAhoyFrame:RegisterEvent("SPELLCAST_DELAYED")
   BuffAhoyFrame:RegisterEvent("SPELLCAST_STOP")
   BuffAhoyFrame:RegisterEvent("SPELLCAST_START")
--   BuffAhoyFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
--   BuffAhoyFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
   BuffAhoyFrame:RegisterEvent("SPELLCAST_CHANNEL_START")

	local name = this:GetName();
	local header = getglobal(name.."TitleText");


	if ( header ) then 
		header:SetText("|cFFee9966BuffAhoy - by Theck|r");
	end

--   DEFAULT_CHAT_FRAME:AddMessage("BUFFAHOY",1,0,0)

   -- initialize slash commands
   SlashCmdList["BUFFAHOY"]=BuffAhoy_SlashCommandHandler;
   SLASH_BUFFAHOY1="/buffahoy"
   SLASH_BUFFAHOY2="/ba"


   OptionsFrame_EnableDropDown(BuffTypeDropdown);
   OptionsFrame_EnableDropDown(VerboseTypeDropdown);
   OptionsFrame_EnableDropDown(BuffAhoyMasterDropdown);
   OptionsFrame_EnableDropDown(SCTypeDropdown);


end

function BALoadDefaults()
	BA[plyr]={}
       	BA[plyr]["BuffCast_Verbose"]=0
   	BA[plyr]["BuffCast_Quiet"]=1
        BA[plyr]["Healzor_Verbose"]=1
  	BA[plyr]["Healzor_Verbose_Two"]=1
  	BA[plyr]["Healzor_Verbose_Three"]=1
	BA[plyr]["Healzor_Smartcastable"]=1
	BA[plyr]["Healzor_Smartcastable_Two"]=1
	BA[plyr]["Healzor_Smartcastable_Three"]=1
	BA[plyr]["Cleanzor_Verbose"]=1
	BA[plyr]["Cleanzor_Verbose_Two"]=1
	BA[plyr]["Cleanzor_Smartcastable"]=1
	BA[plyr]["Cleanzor_Smartcastable_Two"]=1
	BA[plyr]["Protectzor_Verbose"]=1
	BA[plyr]["Protectzor_Smartcastable"]=1
	BA[plyr]["PPTenabled"]=1
   	BA[plyr]["SCenabled"]=1
	BA[plyr]["multiverbosity"]=0;
	BA[plyr]["SC1_Verbose"]=1;
	BA[plyr]["SC1_SC"]=1;
	BA[plyr]["SC2_Verbose"]=1;
	BA[plyr]["SC2_SC"]=1;
	BA[plyr]["SC3_Verbose"]=1;
	BA[plyr]["SC3_SC"]=1;
	BA[plyr]["SC4_Verbose"]=1;
	BA[plyr]["SC4_SC"]=1;
	BA[plyr]["UFrameVar"]=0;
	BA[plyr]["RCFrameVar"]=1;
	BA[plyr]["statustext"]=1;
	BA[plyr]["BAFrameVar"]=1;
	BA[plyr]["manabuff"]=0;
	BA[plyr]["ShiftAlt"]=1;
	BA[plyr]["loudevents"]=1;
	BA[plyr]["forceparty"]=0;
	BA[plyr]["showPPTFrame"]=1;
	BA[plyr]["version"]=1.4
	DEFAULT_CHAT_FRAME:AddMessage("BuffAhoy Defaults Loaded!",1,0,0)
end

-- Function to call once player and variables are ready

function BAInitializeSetup()

   -- if player profile doesn't exist
   if ( not BA[plyr] ) then
	-- load defaults
	BALoadDefaults()
   end

   ---code to update version
   if ( not BA[plyr].version or BA[plyr].version < BA_VERSION) then
	BA_ExecuteVersionChanges()
   end

   --code to show/hide PPT Frame	
   if BA[plyr].showPPTFrame == 1 then
 	getglobal("PPTFrame"):Show()
   else
	getglobal("PPTFrame"):Hide()
   end
end


function BA_ExecuteVersionChanges()
  	local oldversion
  	if (not BA[plyr].version) then
		BA[plyr]["version"]=1.3
		oldversion="1.3x or prior"
		BADebug("oldversion",oldversion)
	else
		oldversion=BA[plyr].version
		BADebug("oldversion",oldversion)
	end
	if BA[plyr].version<1.4 then
		BALoadDefaults()
	end
	if BA[plyr].version<1.463 then
		BA[plyr]["buffbeginannounce"]=1;
	end
	if BA[plyr].version<1.5 then
		BA[plyr]["group"]={}
		for i=1,8 do
			BA[plyr]["group"][i]=1;
		end
	end

	BA[plyr].version=BA_VERSION
	DEFAULT_CHAT_FRAME:AddMessage("BuffAhoy Version Updated from "..oldversion.." to "..BA[plyr].version .."!!",1,0,0);

end


--[[
-- Check the player name, return true if the player name is known, false otherwise
local function BACheckPlayerName()
  if (BAgotPlayerName) then
    return true;
  end
  local pName = UnitName("player");
  if ((pName ~= nil) and (pName ~= UNKNOWNOBJECT) and (pName ~= UKNOWNBEING)) then
    BAgotPlayerName = true;
    plyr=pName;
    return true;
  end
  return false;
end
]]

function BuffAhoy_OnEvent(event)
	-- Saved Variables available here
	if (event == "VARIABLES_LOADED") then

   		-- initialize PartyTarget
   		PartyTarget="party1"
		
		if ( DEFAULT_CHAT_FRAME ) then 
	     		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ONLOAD_TEXT, 0.8, 0.8, 0.2);
   		end

		--this is supposed to help pull names from action bar slots
		for i=1,120,1 do
			BuffAhoyNameGrab(i);
   		end 

		 -- Register the addon in myAddOns
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(BuffAhoyDetails);
		end

		plyr=UnitName("player")
		BAInitializeSetup();
			
    		
    		return

	end


	if (event == "SPELLCAST_INTERRUPTED") then
		BADebug("SPELLCAST_INTERRUPTED", tempverb)
		if tempverb==2 or tempverb==6 or tempverb==7 and BA[plyr].loudevents==1 then
			SendChatMessage(BUFFAHOY_SPELL_INTERRUPTED)
		end
		castFlag=false;
		tempverb=0;
		failFlag=false;
--		BADebug("tempverb",tempverb)
		BADebug("failFlag",failFlag)
	end
	if (event == "SPELLCAST_FAILED") then
		BADebug("SPELLCAST_FAILED", tempverb)
		if tempverb==1 and BA[plyr].loudevents==1 then
			SendChatMessage(BUFFAHOY_SPELL_FAILED)
		end
		castFlag=false;
		failFlag=true;
		BADebug("failFlag",failFlag)
		tempverb=0;
	end
	if (event == "SPELLCAST_DELAYED") then
		BADebug("SPELLCAST_DELAYED", tempverb)
		if (tempverb==6 or tempverb==2) and BA[plyr].loudevents==1  then
			SendChatMessage(BUFFAHOY_SPELL_DELAYED)
			tempverb=7;
		end
		failFlag=false;
		BADebug("failFlag",failFlag)
	end
	if (event == "SPELLCAST_STOP") then
		if castFlag==true and tempverb==1 then
			tempverb=9;
			BADebug("SPELLCAST_STOP", tempverb)
			castFlag=false;
		elseif castFlag==true and tempverb==2 then
			tempverb=3;
			BADebug("SPELLCAST_STOP", tempverb)
			castFlag=false;
		elseif castFlag==true and tempverb==5 then
			tempverb=6;
			castFlag=false;
			BADebug("SPELLCAST_STOP", tempverb)
		elseif castFlag==true and tempverb==6 then
			tempverb=7;
			castFlag=false;
			BADebug("SPELLCAST_STOP", tempverb)
		else
			tempverb=0;
			BADebug("SPELLCAST_STOP", tempverb)
		end
		castFlag=false;
		failFlag=false;
		BADebug("failFlag",failFlag)
--		BADebug("tempverb",tempverb)
		
	end
	if (event == "SPELLCAST_START") then
		if tempverb==1 then
			tempverb=2;
			BADebug("SPELLCAST_START", tempverb)
		else
			tempverb=0;
			BADebug("SPELLCAST_START", tempverb)
		end
		failFlag=false;
		BADebug("failFlag",failFlag)
	end
	if (event == "SPELLCAST_CHANNEL_START") then
		if tempverb==1 then
			tempverb=5;
			BADebug("SPELLCAST_CHANNEL_START", tempverb)
		else
			tempverb=0;
			BADebug("SPELLCAST_CHANNEL_START", tempverb)
		end
		failFlag=false;
		BADebug("failFlag",failFlag)
	end
end

--Debug Function
function BADebug(string, value)
	if value==nil then value="nil" end
	if value==true then value="true" end
	if value==false then value="false" end
	if BADebugVar then
		DEFAULT_CHAT_FRAME:AddMessage(string.." is "..value);
	end
end



-- GUI STUFF:

-- Local data


function BuffAhoyTogglish()
	if ( BuffAhoyFrame ) then 
		if ( BuffAhoyFrame:IsVisible() ) then 
			HideUIPanel(BuffAhoyFrame);
		else	
			ShowUIPanel(BuffAhoyFrame);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("BuffAhoyFrame doesn't exist!!")
	end
end




function BuffAhoy_OnShow()
    BuffAhoy_ShowHelp()
	local check;
--	BADebug("BAFrameVar",BA[plyr].BAFrameVar)
	BuffAhoyFrameTogglish(BA[plyr].BAFrameVar)

	getglobal("BuffCastVerbose"):SetChecked(BA[plyr].BuffCast_Verbose);
	getglobal("BuffCastVerbose2"):SetChecked(BA[plyr].BuffCast_Verbose);

	getglobal("BuffCastQuiet"):SetChecked(BA[plyr].BuffCast_Quiet);
	getglobal("BuffCastQuiet2"):SetChecked(BA[plyr].BuffCast_Quiet);

--	getglobal("BuffCastAnnounce"):SetChecked(BA[plyr].buffbeginannounce);

	getglobal("BuffAhoyHealOneVerbose"):SetChecked(BA[plyr].Healzor_Verbose);
	getglobal("BuffAhoyHealTwoVerbose"):SetChecked(BA[plyr].Healzor_Verbose_Two);
	getglobal("BuffAhoyHealThreeVerbose"):SetChecked(BA[plyr].Healzor_Verbose_Three);
	getglobal("BuffAhoyCleanseOneVerbose"):SetChecked(BA[plyr].Cleanzor_Verbose);
	getglobal("BuffAhoyCleanseTwoVerbose"):SetChecked(BA[plyr].Cleanzor_Verbose_Two);
	getglobal("BuffAhoyProtectVerbose"):SetChecked(BA[plyr].Protectzor_Verbose);

	getglobal("BuffAhoyHealOneSC"):SetChecked(BA[plyr].Healzor_Smartcastable);
	getglobal("BuffAhoyHealTwoSC"):SetChecked(BA[plyr].Healzor_Smartcastable_Two);
	getglobal("BuffAhoyHealThreeSC"):SetChecked(BA[plyr].Healzor_Smartcastable_Three);
	getglobal("BuffAhoyCleanseOneSC"):SetChecked(BA[plyr].Cleanzor_Smartcastable);
	getglobal("BuffAhoyCleanseTwoSC"):SetChecked(BA[plyr].Cleanzor_Smartcastable_Two);
	getglobal("BuffAhoyProtectSC"):SetChecked(BA[plyr].Protectzor_Smartcastable);
	
--	getglobal("PPTENABLE2"):SetChecked(BA[plyr].PPTenabled);
--	getglobal("SCENABLE2"):SetChecked(BA[plyr].SCenabled);

	getglobal("PPTENABLE"):SetChecked(BA[plyr].PPTenabled);
	getglobal("SCENABLE"):SetChecked(BA[plyr].SCenabled);
	getglobal("BuffManaCheck"):SetChecked(BA[plyr].manabuff);
	getglobal("MultiSC"):SetChecked(BA[plyr].multiverbosity);
	getglobal("AnnOpt"):SetChecked(BA[plyr].buffbeginannounce);
	getglobal("StatusTextOpt"):SetChecked(BA[plyr].statustext);
	getglobal("LoudEventsOpt"):SetChecked(BA[plyr].loudevents);
	getglobal("ForcePartyOpt"):SetChecked(BA[plyr].forceparty);
	getglobal("PPTFrameOpt"):SetChecked(BA[plyr].showPPTFrame);

	if BA[plyr].showPPTFrame == 1 then
		getglobal("PPTFrame"):Show()
	else
		getglobal("PPTFrame"):Hide()
	end
--	getglobal("UtilMultiTog"):SetChecked(BA[plyr].UFrameVar);


--	if whovar=="raid" then check=1 else check=0 end
--	getglobal("WhoVarRaidToggle"):SetChecked(check);
--	getglobal("WhoVarRaidToggle2"):SetChecked(check);


	getglobal("ShoutCastOneSC"):SetChecked(BA[plyr].SC1_SC);
	getglobal("ShoutCastTwoSC"):SetChecked(BA[plyr].SC2_SC);
	getglobal("ShoutCastThreeSC"):SetChecked(BA[plyr].SC3_SC);
	getglobal("ShoutCastFourSC"):SetChecked(BA[plyr].SC4_SC);

	getglobal("ShoutCastOneVerbose"):SetChecked(BA[plyr].SC1_Verbose);
	getglobal("ShoutCastTwoVerbose"):SetChecked(BA[plyr].SC2_Verbose);
	getglobal("ShoutCastThreeVerbose"):SetChecked(BA[plyr].SC3_Verbose);
	getglobal("ShoutCastFourVerbose"):SetChecked(BA[plyr].SC4_Verbose);

--	getglobal("BuffAhoySetOnePlayerText"):SetText(UnitName(playa[1]));
--	for i=1,4 do
--		if UnitName(playa[i])~= nil then
--			getglobal("BuffAhoySetOneParty"..i.."Text"):SetText(UnitName(playa[i+1]));
--		else
--			getglobal("BuffAhoySetOneParty"..i.."Text"):SetText("Party");
--		end
--	end

--	UtilFrameTogglish(BA[plyr].UFrameVar)

--	BuffFrameTogglish(BA[plyr].RCFrameVar)

	getglobal("GroupOne"):SetChecked(BA[plyr]["group"][1]);
	getglobal("GroupTwo"):SetChecked(BA[plyr]["group"][2]);
	getglobal("GroupThree"):SetChecked(BA[plyr]["group"][3]);
	getglobal("GroupFour"):SetChecked(BA[plyr]["group"][4]);
	getglobal("GroupFive"):SetChecked(BA[plyr]["group"][5]);
	getglobal("GroupSix"):SetChecked(BA[plyr]["group"][6]);
	getglobal("GroupSeven"):SetChecked(BA[plyr]["group"][7]);
	getglobal("GroupEight"):SetChecked(BA[plyr]["group"][8]);

--make windows draggable
	BuffAhoyFrame:RegisterForDrag("LeftButton");


   if UnitFactionGroup("player")=="Alliance" then
	PalShaVar=BUFFAHOY_PALADIN
   else
	PalShaVar=BUFFAHOY_SHAMAN
   end
   RaidSetOnePlayerText:SetText(PalShaVar);



end

function BuffAhoy_Reset()
  if BA[plyr].BAFrameVar==1 then
	  if BA[plyr].RCFrameVar==3 then
    		for i=1,6,1 do
			PickupAction(BCS1[i])
			PickupSpell(511,"spell")
			PickupAction(BCS2[i])
			PickupSpell(511,"spell")
		end
			PickupAction(BCS3)
			PickupSpell(511,"spell")
			PickupAction(BCS4)
			PickupSpell(511,"spell")

	  elseif BA[plyr].RCFrameVar==1 then

			PickupAction(RCPalSha)
			PickupSpell(511,"spell")
			PickupAction(RCWarrior)
			PickupSpell(511,"spell")	
			PickupAction(RCMage)
			PickupSpell(511,"spell")	
			PickupAction(RCPriest)
			PickupSpell(511,"spell")	
			PickupAction(RCWarlock)
			PickupSpell(511,"spell")	
			PickupAction(RCRogue)
			PickupSpell(511,"spell")		
			PickupAction(RCHunter)
			PickupSpell(511,"spell")	
			PickupAction(RCDruid)
			PickupSpell(511,"spell")
			PickupAction(RCPet1)
			PickupSpell(511,"spell")
			PickupAction(RCS2)
			PickupSpell(511,"spell")	
			PickupAction(RCS3)
			PickupSpell(511,"spell")

	  elseif BA[plyr].RCFrameVar==2 then
		
			for i=1,8 do
				BA[plyr]["group"][i]=1;
			end

	  end	
  elseif BA[plyr].BAFrameVar==2 then
		PickupAction(HZR1)
		PickupSpell(511,"spell")
		PickupAction(HZR2)
		PickupSpell(511,"spell")
		PickupAction(HZR3)
		PickupSpell(511,"spell")
		PickupAction(CZR1)
		PickupSpell(511,"spell")
		PickupAction(CZR2)
		PickupSpell(511,"spell")
		PickupAction(PZR1)
		PickupSpell(511,"spell")
  elseif BA[plyr].BAFrameVar==3 then
    	for i=1,6,1 do
		PickupAction(MCS1[i])
		PickupSpell(511,"spell")
		PickupAction(MCS2[i])
		PickupSpell(511,"spell")
	end
		PickupAction(SCT1)
		PickupSpell(511,"spell")
		PickupAction(SCT2)
		PickupSpell(511,"spell")
		PickupAction(SCT3)
		PickupSpell(511,"spell")
		PickupAction(SCT4)
		PickupSpell(511,"spell")
  elseif BA[plyr].BAFrameVar==4 then
--	BADebug("BAFrameVar",BA[plyr].BAFrameVar);
  end
end



function BuffAhoy_ShowHelp()
	local helptext = getglobal("BuffAhoyFrameHelpText");
	if ( helptext ) then 
			helptext:SetText(BUFFAHOY_HELP);
	end

	local helptext3 = getglobal("BuffAhoySetThreeFourHelpText");
	if ( helptext3 ) then
			helptext3:SetText(BUFFAHOYBC34_HELP);
	end
	local helptext4 = getglobal("RaidSetThreeFourHelpText");
	if ( helptext4 ) then
			helptext4:SetText(BUFFAHOYRC23_HELP);
	end
end

-- Handles gui updates ever frame
function BuffAhoy_Update()
end



function BuffAhoyButton_GetID(button)
-- Telo's code
	if ( button == nil ) then
		DEFAULT_CHAT_FRAME:AddMessage("nil button passed into GetID()");
		return 0;
	end
	this = button
	return (button:GetID())
end

function BuffAhoyButton_UpdateState()
-- Desperate attempt to fix Dagar's Mac crash
--if not string.find(this:GetName(),"BuffAhoyButton") then return end
local button = this
-- Blizzard code: Purpose unknown at button time
	if ( IsCurrentAction(BuffAhoyButton_GetID(button)) or IsAutoRepeatAction(BuffAhoyButton_GetID(button)) ) then
		button:SetChecked(1);
	else
		button:SetChecked(0);
	end
this = button
end

-- BA Button Load
function BuffAhoy_ButtonLoad()
	local button = this
	BuffAhoyButton_Update();
	button:RegisterForDrag("LeftButton", "RightButton");
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	button:RegisterEvent("SPELLS_CHANGED");
	button:RegisterEvent("CURRENT_SPELL_CAST_CHANGED");
	button:RegisterEvent("SPELL_UPDATE_COOLDOWN");	
	button:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	button:RegisterEvent("ACTIONBAR_UPDATE_STATE");
	button:RegisterEvent("UNIT_INVENTORY_CHANGED");
end




-- BA Button Event Handler
function BuffAhoy_ButtonEvent(event)
	if ( event == "SPELL_UPDATE_COOLDOWN" ) then
		BuffAhoyButton_Update(this);
	end
	if ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		if ( arg1 == -1 or arg1 == BuffAhoyButton_GetID(this) ) then
			BuffAhoyButton_Update();
		end
		this = button
		return;
	end
	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			BuffAhoyButton_Update();
		end
		this = button
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_STATE" ) then
		BuffAhoyButton_UpdateState();
		this = button
		return;
	end
end


function BuffAhoy_VerboseButtonEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(BUFFAHOY_VERBOSE_TIP);
end
function BuffAhoy_VerboseButtonLeave()
	GameTooltip:Hide();
end
function BuffAhoy_VerboseToggle(set,state)
--   BADebug("set",set)
--   BADebug("state",state)
   if (set==11) then
	if ( state == true or state == 1 ) then
		BA[plyr].Healzor_Verbose=1;
	else
		BA[plyr].Healzor_Verbose=0;	
	end
   end
   if (set==12) then
	if ( state == true or state == 1 ) then
		BA[plyr].Healzor_Verbose_Two=1;	
	else
		BA[plyr].Healzor_Verbose_Two=0;	
	end
   end
   if (set==13) then
	if ( state == true or state == 1 ) then
		BA[plyr].Healzor_Verbose_Three=1;	
	else
		BA[plyr].Healzor_Verbose_Three=0;	
	end
   end
   if (set==14) then
	if ( state == true or state == 1 ) then
		BA[plyr].Protectzor_Verbose=1;	
	else
		BA[plyr].Protectzor_Verbose=0;	
	end
   end
   if (set==15) then
	if ( state == true or state == 1 ) then
		BA[plyr].Cleanzor_Verbose=1;	
	else
		BA[plyr].Cleanzor_Verbose=0;	
	end
   end
   if (set==16) then
	if ( state == true or state == 1 ) then
		BA[plyr].Cleanzor_Verbose_Two=1;	
	else
		BA[plyr].Cleanzor_Verbose_Two=0;	
	end
   end

   if (set==21) then
	if ( state == true or state == 1 ) then
		BA[plyr].SC1_Verbose=1;
	else
		BA[plyr].SC1_Verbose=0;	
	end
   end
   if (set==22) then
	if ( state == true or state == 1 ) then
		BA[plyr].SC2_Verbose=1;
	else
		BA[plyr].SC2_Verbose=0;	
	end
   end
   if (set==23) then
	if ( state == true or state == 1 ) then
		BA[plyr].SC3_Verbose=1;
	else
		BA[plyr].SC3_Verbose=0;	
	end
   end
   if (set==24) then
	if ( state == true or state == 1 ) then
		BA[plyr].SC4_Verbose=1;
	else
		BA[plyr].SC4_Verbose=0;	
	end
   end
   if (set==70) then
	if ( state == true or state == 1 ) then
		BA[plyr].BuffCast_Verbose=1;
		BA[plyr].BuffCast_Quiet=0;
		BuffAhoy_OnShow();	
--		BADebug("Verbose",BA[plyr].BuffCast_Verbose)
--		BADebug("Quiet",BA[plyr].BuffCast_Quiet)
	else
		BA[plyr].BuffCast_Verbose=0;	
		BuffAhoy_OnShow();
--		BADebug("Verbose",BA[plyr].BuffCast_Verbose)
--		BADebug("Quiet",BA[plyr].BuffCast_Quiet)
	end
   end   
   if (set==71) then
	if ( state == true or state == 1 ) then
		BA[plyr].BuffCast_Quiet=1;
		BA[plyr].BuffCast_Verbose=0;
		BuffAhoy_OnShow();	
--		BADebug("Verbose",BA[plyr].BuffCast_Verbose)
--		BADebug("Quiet",BA[plyr].BuffCast_Quiet)
	else
		BA[plyr].BuffCast_Quiet=0;	
		BuffAhoy_OnShow();
--		BADebug("Verbose",BA[plyr].BuffCast_Verbose)
--		BADebug("Quiet",BA[plyr].BuffCast_Quiet)
	end
   end
   if (set==72) then
	if ( state == true or state == 1 ) then
		BA[plyr].buffbeginannounce=1
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ANNOUNCE_ON)
	else
		BA[plyr].buffbeginannounce=0
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ANNOUNCE_OFF)
	end
	BuffAhoy_OnShow();	
   end
end


function BuffAhoy_CheckButtonEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(BUFFAHOY_OPTIONS_TIP);
end
function BuffAhoy_CheckButtonLeave()
	GameTooltip:Hide();
end

function BuffAhoy_CheckToggle(set,state)
--   if (set==1) then
--	if ( state == true or state == 1 ) then
--		BA[plyr].RCFrameVar=1;
--	else
--		BA[plyr].RCFrameVar=3;
--	end
--	BuffFrameTogglish(BA[plyr].RCFrameVar)
--   end
--   if (set==2) then
--	if ( state == true or state == 1 ) then
--		BA[plyr].UFrameVar=1;
--	else
--		BA[plyr].UFrameVar=0;
--	end
--	UtilFrameTogglish(BA[plyr].UFrameVar)
--   end
   if (set==11) then
	if (state == true or state == 1 ) then
		BA[plyr].Healzor_Smartcastable=1;
	else
		BA[plyr].Healzor_Smartcastable=0;
	end
   end
   if (set==12) then
	if (state == true or state == 1 ) then
		BA[plyr].Healzor_Smartcastable_Two=1;
	else
		BA[plyr].Healzor_Smartcastable_Two=0;
	end
   end
   if (set==13) then
	if (state == true or state == 1 ) then
		BA[plyr].Healzor_Smartcastable_Three=1;
	else
		BA[plyr].Healzor_Smartcastable_Three=0;
	end
   end
   if (set==14) then
	if (state == true or state == 1 ) then
		BA[plyr].Protectzor_Smartcastable=1;
		BADebug("Pz_sc",BA[plyr].Protectzor_Smartcastable)
	else
		BA[plyr].Protectzor_Smartcastable=0;
		BADebug("Pz_sc",BA[plyr].Protectzor_Smartcastable)
	end
   end
   if (set==15) then
	if (state == true or state == 1 ) then
		BA[plyr].Cleanzor_Smartcastable=1;
	else
		BA[plyr].Cleanzor_Smartcastable=0;
	end
   end
   if (set==16) then
	if (state == true or state == 1 ) then
		BA[plyr].Cleanzor_Smartcastable_Two=1;
	else
		BA[plyr].Cleanzor_Smartcastable_Two=0;
	end
   end
   if (set==21) then
	if ( state == true or state == 1 ) then
		BA[plyr].SC1_SC=1;
	else
		BA[plyr].SC1_SC=0;	
	end
   end
   if (set==22) then
	if ( state == true or state == 1 ) then
		BA[plyr].SC2_SC=1;
	else
		BA[plyr].SC2_SC=0;	
	end
   end
   if (set==23) then
	if ( state == true or state == 1 ) then
		BA[plyr].SC3_SC=1;
	else
		BA[plyr].SC3_SC=0;	
	end
   end
   if (set==24) then
	if ( state == true or state == 1 ) then
		BA[plyr].SC4_SC=1;
	else
		BA[plyr].SC4_SC=0;	
	end
   end
end


function BuffAhoy_OptionsButtonEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(BUFFAHOY_OPTIONS_TIP);
end
function BuffAhoy_OptionsButtonLeave()
	GameTooltip:Hide();
end
function BuffAhoy_OptionsToggle(set,state)
   if (set==1) then
	if ( state == true or state == 1 ) then
		BA[plyr].PPTenabled=1;
		BuffAhoy_OnShow();
	else
		BA[plyr].PPTenabled=0;
		BuffAhoy_OnShow();
	end
   end
   if (set==2) then
	if ( state == true or state == 1 ) then
		BA[plyr].SCenabled=1;
		BuffAhoy_OnShow();
	else
		BA[plyr].SCenabled=0;
		BuffAhoy_OnShow();
	end
   end
   if (set==3) then
	if (state == true or state == 1 ) then
		BA[plyr].manabuff=1;
	else
		BA[plyr].manabuff=0;
	end
   end
   if (set==4) then
	if (state == true or state == 1 ) then
		BA[plyr].buffbeginannounce=1;
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ANNOUNCE_ON)
		BuffAhoy_OnShow()
	else
		BA[plyr].buffbeginannounce=0;
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ANNOUNCE_OFF)
		BuffAhoy_OnShow()
	end
   end
   if (set==5) then
	if (state == true or state == 1 ) then
		BA[plyr].statustext=1;
	else
		BA[plyr].statustext=0;
	end
   end
   if (set==6) then
	if (state == true or state == 1 ) then
		BA[plyr].loudevents=1;
	else
		BA[plyr].loudevents=0;
	end
   end
   if (set==7) then
	if (state == true or state == 1 ) then
		BA[plyr].forceparty=1;
	else
		BA[plyr].forceparty=0;
	end
   end
   if (set==8) then
	if (state == true or state == 1 ) then
		BA[plyr].showPPTFrame=1;
		PPTFrame:Show()
	else
		BA[plyr].showPPTFrame=0;
		PPTFrame:Hide()
	end
   end


--   if (set==10) then
--	if (state == true or state == 1 ) then
--		whovar="raid";
--		BuffAhoy_OnShow();
--	else
--		whovar="party";
--		BuffAhoy_OnShow();
--	end
--   end

     if (set==43) then
	if (state == true or state == 1 ) then
		BA[plyr].multiverbosity=1;
		BuffAhoy_OnShow()
	else
		BA[plyr].multiverbosity=0;
		BuffAhoy_OnShow()
	end
    end

   if (set==81) then
	if ( state == true or state == 1 ) then
		BA[plyr]["group"][1]=1;
		BuffAhoy_OnShow();
	else
		BA[plyr]["group"][1]=0;
		BuffAhoy_OnShow();
	end
   end
   if (set==82) then
	if ( state == true or state == 1 ) then
		BA[plyr]["group"][2]=1;
		BuffAhoy_OnShow();
	else
		BA[plyr]["group"][2]=0;
		BuffAhoy_OnShow();
	end
   end
   if (set==83) then
	if (state == true or state == 1 ) then
		BA[plyr]["group"][3]=1;
		BuffAhoy_OnShow();
	else
		BA[plyr]["group"][3]=0;
		BuffAhoy_OnShow();
	end
   end
   if (set==84) then
	if (state == true or state == 1 ) then
		BA[plyr]["group"][4]=1;
		BuffAhoy_OnShow();
	else
		BA[plyr]["group"][4]=0;
		BuffAhoy_OnShow();
	end
   end
   if (set==85) then
	if (state == true or state == 1 ) then
		BA[plyr]["group"][5]=1;
		BuffAhoy_OnShow();
	else
		BA[plyr]["group"][5]=0;
		BuffAhoy_OnShow();
	end
   end
   if (set==86) then
	if (state == true or state == 1 ) then
		BA[plyr]["group"][6]=1;
		BuffAhoy_OnShow();
	else
		BA[plyr]["group"][6]=0;
		BuffAhoy_OnShow();
	end
   end
   if (set==87) then
	if (state == true or state == 1 ) then
		BA[plyr]["group"][7]=1;
		BuffAhoy_OnShow();
	else
		BA[plyr]["group"][7]=0;
		BuffAhoy_OnShow();
	end
   end
   if (set==88) then
	if (state == true or state == 1 ) then
		BA[plyr]["group"][8]=1;
		BuffAhoy_OnShow();
	else
		BA[plyr]["group"][8]=0;
		BuffAhoy_OnShow();
	end
   end
end

function BuffAhoyNameGrab(id)
	BA_Tooltip:SetOwner(BuffAhoyFrame, "ANCHOR_NONE")
	BA_Tooltip:SetAction(id)
	local textemp=BA_TooltipTextLeft1:GetText()
--	DEFAULT_CHAT_FRAME:AddMessage(textemp)
	if textemp~=nil then
		BuffAhoyNameArray[id]=textemp;
	else
		BuffAhoyNameArray[id]="nothing";
	end
	BA_Tooltip:Hide();
end


function BuffAhoyButton_Update()
-- When called manually, this can change - changed code to use button instead of this

local button = this
-- Blizzard code
	if button~= nil then
	local buttonID = BuffAhoyButton_GetID(button);

	local icon = getglobal(button:GetName().."Icon");
	local buttonCooldown = getglobal(button:GetName().."Cooldown");
	local texture = GetActionTexture(BuffAhoyButton_GetID(button));

		if ( texture ) then
			icon:SetTexture(texture);
			icon:Show();
			button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
			BuffAhoyNameGrab(BuffAhoyButton_GetID(button));
		else
			icon:Hide();
			buttonCooldown:Hide();
			button.rangeTimer = nil;
			button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
			getglobal(button:GetName().."HotKey"):SetVertexColor(0.6, 0.6, 0.6);
		end
	end

	
	-- Update Macro Text
	local macroName = getglobal(button:GetName().."Name");
	macroName:SetText(GetActionText(BuffAhoyButton_GetID(button)))
this = button
end



function BuffAhoy_SetTooltip()
button = this
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
	GameTooltip:SetAction(BuffAhoyButton_GetID(button))

this = button
end


function BuffFrameTogglish(state)
	if ( BuffAhoyOptions ) then 
		if ( state==1 ) then 
			ShowUIPanel(BuffAhoyOptions);
			HideUIPanel(BuffAhoySetOne);
			HideUIPanel(BuffAhoySetTwo);
			HideUIPanel(BuffAhoySetThreeFour);
			ShowUIPanel(RaidSetThreeFour);
			ShowUIPanel(RaidSetOne);
			ShowUIPanel(RaidSetTwo);
			HideUIPanel(BuffAhoyGroupFrame);

		elseif (state==3) then
	
			ShowUIPanel(BuffAhoyOptions);
			ShowUIPanel(BuffAhoySetOne);
			ShowUIPanel(BuffAhoySetTwo);
			ShowUIPanel(BuffAhoySetThreeFour);
			HideUIPanel(RaidSetThreeFour);
			HideUIPanel(RaidSetOne);
			HideUIPanel(RaidSetTwo);
			HideUIPanel(BuffAhoyGroupFrame);

		else

			ShowUIPanel(BuffAhoyOptions);
			HideUIPanel(BuffAhoySetOne);
			HideUIPanel(BuffAhoySetTwo);
			HideUIPanel(BuffAhoySetThreeFour);
			HideUIPanel(RaidSetThreeFour);
			HideUIPanel(RaidSetOne);
			HideUIPanel(RaidSetTwo);
			ShowUIPanel(BuffAhoyGroupFrame);

		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("BuffAhoyFrame doesn't exist!!")
	end
end





function BuffAhoyFrameTogglish(state)
	if (BuffAhoyOptions) then
			HideUIPanel(MultiCastSetOne);
			HideUIPanel(MultiCastSetTwo);
			HideUIPanel(ShoutCastOne);
			HideUIPanel(ShoutCastTwo);
			HideUIPanel(ShoutCastThree);
			HideUIPanel(ShoutCastFour);
			HideUIPanel(BuffAhoyHealOne);
			HideUIPanel(BuffAhoyHealTwo);
			HideUIPanel(BuffAhoyHealThree);
			HideUIPanel(BuffAhoyCleanseOne);
			HideUIPanel(BuffAhoyCleanseTwo);
			HideUIPanel(BuffAhoyProtect);
			ShowUIPanel(BuffAhoyOptions);
			HideUIPanel(BuffAhoySetOne);
			HideUIPanel(BuffAhoySetTwo);
			HideUIPanel(BuffAhoySetThreeFour);
			HideUIPanel(RaidSetThreeFour);
			HideUIPanel(RaidSetOne);
			HideUIPanel(RaidSetTwo);
			HideUIPanel(VerboseTypeDropdown);
			HideUIPanel(BuffTypeDropdown);
			HideUIPanel(SCTypeDropdown);
			HideUIPanel(BuffAhoyOptionsFrame);
			HideUIPanel(BuffAhoyGroupFrame);

		if (state==1) then
			ShowUIPanel(VerboseTypeDropdown);
			ShowUIPanel(BuffTypeDropdown);

		elseif (state ==2) then
			ShowUIPanel(BuffAhoyHealOne);
			ShowUIPanel(BuffAhoyHealTwo);
			ShowUIPanel(BuffAhoyHealThree);
			ShowUIPanel(BuffAhoyCleanseOne);
			ShowUIPanel(BuffAhoyCleanseTwo);
			ShowUIPanel(BuffAhoyProtect);
			ShowUIPanel(VerboseTypeDropdown);

		elseif (state == 3) then
			ShowUIPanel(MultiCastSetOne);
			ShowUIPanel(MultiCastSetTwo);
			ShowUIPanel(ShoutCastOne);
			ShowUIPanel(ShoutCastTwo);
			ShowUIPanel(ShoutCastThree);
			ShowUIPanel(ShoutCastFour);
			ShowUIPanel(VerboseTypeDropdown);

		elseif (state == 4) then
			ShowUIPanel(BuffAhoyOptionsFrame);
			ShowUIPanel(VerboseTypeDropdown);
			ShowUIPanel(SCTypeDropdown);
		end
	end
end

function BuffAhoyMasterDropdown_OnLoad()
	UIDropDownMenu_Initialize(this, BuffAhoyMasterDropdown_Initialize);
	UIDropDownMenu_SetSelectedID(BuffAhoyMasterDropdown, BA[plyr].BAFrameVar);
	UIDropDownMenu_SetWidth(120, BuffAhoyMasterDropdown);
end

function BuffAhoyMasterDropdown_OnClick()
	UIDropDownMenu_SetSelectedValue(BuffAhoyMasterDropdown, this.value);
--	BADebug("value",UIDropDownMenu_GetSelectedValue(BuffAhoyMasterDropdown))
	BA[plyr].BAFrameVar = UIDropDownMenu_GetSelectedValue(BuffAhoyMasterDropdown);
	BuffAhoyFrameTogglish(BA[plyr].BAFrameVar)
--	DEFAULT_CHAT_FRAME:AddMessage("Frame Var is "..BA[plyr].BAFrameVar);
	BuffAhoyMasterDropdown.tooltip = this.tooltipText;
end

function BuffAhoyMasterDropdown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(BuffAhoyMasterDropdown);
	local info;

	-- Show Buffs
	info = {};
	info.text = BUFFAHOY_PB_TEXT;
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_PB_TOOLTIP;
	info.func = BuffAhoyMasterDropdown_OnClick;
	info.value = 1;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);

	-- Show Utils
	info = {};
	info.text = BUFFAHOY_UF_TEXT;
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_UF_TOOLTIP;
	info.func = BuffAhoyMasterDropdown_OnClick;
	info.value = 2;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);

	-- Show Multi/Shoutcast
	info = {};
	info.text = BUFFAHOY_MC_TEXT;
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_MC_TOOLTIP ;
	info.func = BuffAhoyMasterDropdown_OnClick;
	info.value = 3;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);

	-- Show BuffAhoy Options
	info = {};
	info.text = BUFFAHOY_GO_TEXT ;
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_GO_TOOLTIP;
	info.func = BuffAhoyMasterDropdown_OnClick;
	info.value = 4;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);
end

function BuffTypeDropdown_OnLoad()
	UIDropDownMenu_Initialize(this, BuffTypeDropdown_Initialize);
	UIDropDownMenu_SetSelectedValue(this, BA[plyr].RCFrameVar);
--	BADebug("RC onload", BA[plyr].RCFrameVar)
--	BADebug("value onload",UIDropDownMenu_GetSelectedValue(BuffTypeDropdown));
	if BA[plyr].RCFrameVar==1 then
		UIDropDownMenu_SetSelectedID(BuffTypeDropdown, 1);
	elseif BA[plyr].RCFrameVar==2 then
		UIDropDownMenu_SetSelectedID(BuffTypeDropdown, 2);
	elseif BA[plyr].RCFrameVar==3 then
		UIDropDownMenu_SetSelectedID(BuffTypeDropdown, 3);
	end
--	BADebug("ID onload",UIDropDownMenu_GetSelectedID(BuffTypeDropdown));
	BuffFrameTogglish(BA[plyr].RCFrameVar)
	UIDropDownMenu_SetWidth(110, BuffTypeDropdown);
end

function BuffTypeDropdown_OnClick()
	UIDropDownMenu_SetSelectedValue(BuffTypeDropdown, this.value);
--	BADebug("value",UIDropDownMenu_GetSelectedValue(BuffTypeDropdown))
	BA[plyr].RCFrameVar = UIDropDownMenu_GetSelectedValue(BuffTypeDropdown);
	BuffFrameTogglish(BA[plyr].RCFrameVar)
	BuffTypeDropdown.tooltip = this.tooltipText;
end

function BuffTypeDropdown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(BuffTypeDropdown);
	local info;



	-- Show Class-based
	info = {};
	info.text = BUFFAHOY_CLASSBASE_TEXT;
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_CLASSBASE_TOOLTIP;
	info.func = BuffTypeDropdown_OnClick;
	info.value = 1;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);




	-- Show Groups
	info = {};
	info.text = BUFFAHOY_GROUP_TEXT;
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_GROUP_TOOLTIP;
	info.func = BuffTypeDropdown_OnClick;
	info.value = 2;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);


	-- Show Individualized
	info = {};
	info.text = BUFFAHOY_INDIV_TEXT ;
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_INDIV_TOOLTIP;
	info.func = BuffTypeDropdown_OnClick;
	info.value = 3;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);
end


function VerboseTypeDropdown_OnLoad()
	UIDropDownMenu_Initialize(this, VerboseTypeDropdown_Initialize);
	if whovar=="raid" then
		UIDropDownMenu_SetSelectedID(VerboseTypeDropdown, 1);
	elseif whovar=="party" then
		UIDropDownMenu_SetSelectedID(VerboseTypeDropdown, 2);
	elseif whovar=="say" then
		UIDropDownMenu_SetSelectedID(VerboseTypeDropdown, 3);
	end
	UIDropDownMenu_SetWidth(70, VerboseTypeDropdown);
end

function VerboseTypeDropdown_OnClick()
	UIDropDownMenu_SetSelectedValue(VerboseTypeDropdown, this.value);
--	BADebug("value",UIDropDownMenu_GetSelectedValue(VerboseTypeDropdown))
	local temp1 = UIDropDownMenu_GetSelectedValue(VerboseTypeDropdown);
	if temp1==1 then
		whovar="raid"
	elseif temp1==2 then
		whovar="party"
	elseif temp1==3 then
		whovar="say"
	end
	VerboseTypeDropdown.tooltip = this.tooltipText;
end

function VerboseTypeDropdown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(VerboseTypeDropdown);
	local info;

	-- Show Buffs
	info = {};
	info.text = BUFFAHOY_VERBOSE_RAID_TEXT;
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_VERBOSE_RAID_TT;
	info.func = VerboseTypeDropdown_OnClick;
	info.value = 1;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);

	-- Show Debuffs
	info = {};
	info.text = BUFFAHOY_VERBOSE_PARTY_TEXT;
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_VERBOSE_PARTY_TT ;
	info.func = VerboseTypeDropdown_OnClick;
	info.value = 2;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);

	-- Show Both
	info = {};
	info.text = BUFFAHOY_VERBOSE_SAY_TEXT;
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_VERBOSE_SAY_TT;
	info.func = VerboseTypeDropdown_OnClick;
	info.value = 3;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);
end

function SCTypeDropdown_OnLoad()
	UIDropDownMenu_Initialize(this, SCTypeDropdown_Initialize);
--	BADebug("value onload",UIDropDownMenu_GetSelectedValue(BuffTypeDropdown));
--	BADebug("ShiftAlt",BA[plyr].ShiftAlt)
	UIDropDownMenu_SetSelectedID(SCTypeDropdown, BA[plyr].ShiftAlt);
--	BADebug("ID onload",UIDropDownMenu_GetSelectedID(SCTypeDropdown));
--	BA[plyr].ShiftAlt = UIDropDownMenu_GetSelectedValue(SCTypeDropdown);
	UIDropDownMenu_SetWidth(60, SCTypeDropdown);
end

function SCTypeDropdown_OnClick()
	UIDropDownMenu_SetSelectedValue(SCTypeDropdown, this.value);
--	BADebug("value",UIDropDownMenu_GetSelectedValue(SCTypeDropdown))
	BA[plyr].ShiftAlt = UIDropDownMenu_GetSelectedValue(SCTypeDropdown);
--	BADebug("ShiftAlt",BA[plyr].ShiftAlt)
	SCTypeDropdown.tooltip = this.tooltipText;
end

function SCTypeDropdown_Initialize()
	local selectedValue = UIDropDownMenu_GetSelectedValue(SCTypeDropdown);
	local info;

	-- Alt for selfcasting
	info = {};
	info.text = "Alt";
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_ALTSELF_TOOLTIP;
	info.func = SCTypeDropdown_OnClick;
	info.value = 1;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);

	-- Shift for Smartcasting
	info.text = "Shift";
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_SHIFTSELF_TOOLTIP;
	info.func = SCTypeDropdown_OnClick;
	info.value = 2;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);

	-- Control for Smartcasting
	info.text = "Ctrl";
	info.tooltipTitle = info.text;
	info.tooltipText = BUFFAHOY_SHIFTSELF_TOOLTIP;
	info.func = SCTypeDropdown_OnClick;
	info.value = 3;
	if ( selectedValue == info.value ) then
		info.checked = 1;
	else
		info.checked = nil;
	end
	UIDropDownMenu_AddButton(info);

end

function PPTFrame_OnLoad()
--	RegisterForSave("PPTX1")
--	RegisterForSave("PPTY1")
	if not XVAR1 or not YVAR1 then
	   XVAR1 = 500;
	   YVAR1 = 500;
	else
		PPTFrame:SetPoint("TOPLEFT","UIParent","BOTTOMLEFT", XVAR1, YVAR1);
	end
	getglobal("PPTText"):SetTextHeight(13);
end

function PPTFrame_OnMouseDown(arg1)
   if arg1 == "LeftButton" then
	PPTFrame:StartMoving();
   end
end

function PPTFrame_OnMouseUp(arg1)
   if arg1 == "LeftButton" then
	PPTFrame:StopMovingOrSizing();
	PPTX1=PPTFrame:GetLeft();
	PPTY1=PPTFrame:GetTop();
   end
end

function PPTFrame_OnUpdate()
	if UnitName("target")~=nil and UnitIsFriend("player","target") then
		PPTText:SetText(UnitName("target"))
				--and (PartyTarget=="player" or PartyTarget=="party1" or PartyTarget=="party2" or PartyTarget=="party3" or PartyTarget=="party4")
	elseif PartyTarget~=nil  and UnitName(PartyTarget)~=nil then
		PPTText:SetText(UnitName(PartyTarget))
	elseif PartyTarget~=nil and UnitName(PartyTarget)==nil then
		PPTText:SetText("No Target")
	elseif PartyTarget~=nil then
		PPTText:SetText(PartyTarget)
	else
		PPTText:SetText("No Target")
	end
	if GetNumPartyMembers()<1 then
		PPTFrame:Hide()
	elseif GetNumPartyMembers()>0 and BAgotPlayerName and BA[plyr].showPPTFrame==1 then
		PPTFrame:Show()
	end
end

function PPT_CloseButton()
	PPTFrame:Hide()
end

-----------------------------------------------------------------------------------------
-- SlashCommandHandlers

function BuffAhoy_SlashCommandHandler(msg)
  if (msg== "verbose") then
    BA[plyr].BuffCast_Verbose=1
    BA[plyr].Healzor_Verbose=1
    BA[plyr].Healzor_Verbose_Two=1
    BA[plyr].Healzor_Verbose_Three=1
    BA[plyr].Cleanzor_Verbose=1
    BA[plyr].Cleanzor_Verbose_Two=1
    BA[plyr].Protectzor_verbose=1
    DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_VERBOSESLASH1)
    DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_VERBOSESLASH2)
  end
  if (msg== "silent") then
    BA[plyr].BuffCast_Verbose=0
    BA[plyr].Healzor_Verbose=0
    BA[plyr].Healzor_Verbose_Two=0
    BA[plyr].Healzor_Verbose_Three=0
    BA[plyr].Cleanzor_Verbose=0
    BA[plyr].Cleanzor_Verbose_Two=0
    BA[plyr].Protectzor_verbose=0
    DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_VERBOSESLASH3)
    DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_VERBOSESLASH2)
  end
  if (msg=="buffs") then
    BuffAhoyTogglish()
  end
  if (msg=="caster") then
    BuffAhoyTogglish()
  end
  if (msg=="config") then
    BuffAhoyTogglish()
  end
  if (msg=="") then
     DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_VERBOSESLASH2)
  end
  if (msg=="buff1") then
	BuffCastSetOne()
  end
  if (msg=="buff2") then
	BuffCastSetTwo()
  end
  if (msg=="buff3") then
	BuffCastSetThree()
  end
  if (msg=="heal1") then
	BuffAhoyHealzorOne()
  end
  if (msg=="heal2") then
	BuffAhoyHealzorTwo()
  end
  if (msg=="heal3") then
	BuffAhoyHealzorThree()
  end
  if (msg=="cleanse1") then
	BuffAhoyCleanzorOne()
  end
  if (msg=="cleanse2") then
	BuffAhoyCleanzorTwo()	
  end
  if (msg=="protect1") or (msg=="protect") then
	BuffAhoyProtectzorOne()	
  end
  if (msg=="multi1") then
	MultiCastSetEin()	
  end
  if (msg=="multi2") then
	MultiCastSetZwei()	
  end
  if (msg=="shoutcast1") or (msg=="shout1") then
	ShoutCastEin()
  end
  if (msg=="shoutcast2") or (msg=="shout2") then
	ShoutCastZwei()
  end
  if (msg=="shoutcast3") or (msg=="shout3") then
	ShoutCastDrei()
  end
  if (msg=="shoutcast4") or (msg=="shout4") then
	ShoutCastVier()
  end
  if (msg=="PPT") then
	PPTFrame:Show()
  end
  if (msg=="announce") then
	if not BA[plyr].buffbeginannounce then
		BA_ExecuteVersionChanges()
	end
	if BA[plyr].buffbeginannounce==0 then
		BA[plyr].buffbeginannounce=1
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ANNOUNCE_ON)
	elseif BA[plyr].buffbeginannounce==1 then
		BA[plyr].buffbeginannounce=0
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ANNOUNCE_OFF)
	end
  end
  if (msg=="panic") then
	Panic()
  end
  if (msg=="help") then
     DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_SLASHHELP1)
     DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_SLASHHELP2)
     DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_SLASHHELP3)
  end
end


-- Passive Targetting functions
function PlayerTarget()
  PartyTarget="player"
  if BA[plyr].PPTenabled==0 then
	TargetUnit(PartyTarget)
  end
end

function PartyTarget1()
  PartyTarget="party1"
  if BA[plyr].PPTenabled==0 then
	TargetUnit(PartyTarget)
  end
end

function PartyTarget2()
  PartyTarget="party2"
  if BA[plyr].PPTenabled==0 then
	TargetUnit(PartyTarget)
  end
end

function PartyTarget3()
  PartyTarget="party3"
  if BA[plyr].PPTenabled==0 then
	TargetUnit(PartyTarget)
  end
end

function PartyTarget4()
  PartyTarget="party4"
  if BA[plyr].PPTenabled==0 then
	TargetUnit(PartyTarget)
  end
end

function PetTargetMine()
  if UnitName("pet")~=nil then
  PartyTarget="pet"
  	if BA[plyr].PPTenabled==0 then
		TargetUnit(PartyTarget)
  	end
  elseif BA[plyr].statustext==1 then
  	DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_NOPET1)
  end
end

function PetTarget1()  
  if UnitName("partypet1")~=nil then
  PartyTarget="partypet1"
  	if BA[plyr].PPTenabled==0 then
		TargetUnit(PartyTarget)
  	end
  else
 	if UnitName("party1")~=nil and BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(UnitName("party1")..BUFFAHOY_ERR_NOPET2)
	elseif BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_NOPARTYMBR.." 1")
	end
  end
end

function PetTarget2()
  if UnitName("partypet2")~=nil then
  PartyTarget="partypet2"
  	if BA[plyr].PPTenabled==0 then
		TargetUnit(PartyTarget)
  	end
  else
 	if UnitName("party2")~=nil and BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(UnitName("party2")..BUFFAHOY_ERR_NOPET2)
	elseif BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_NOPARTYMBR.." 2")
	end
  end
end

function PetTarget3()
  if UnitName("partypet3")~=nil then
  PartyTarget="partypet3"
  	if BA[plyr].PPTenabled==0 then
		TargetUnit(PartyTarget)
  	end
  else
 	if UnitName("party3")~=nil and BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(UnitName("party3")..BUFFAHOY_ERR_NOPET2)
	elseif BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_NOPARTYMBR.." 3")
	end
  end
end

function PetTarget4()
  if UnitName("partypet4")~=nil then
  PartyTarget="partypet4"
  	if BA[plyr].PPTenabled==0 then
		TargetUnit(PartyTarget)
  	end
  else
 	if UnitName("party4")~=nil and BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(UnitName("party4")..BUFFAHOY_ERR_NOPET2)
	elseif BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_NOPARTYMBR.." 4")
	end
  end
end

function CustomPPTarget()
  if UnitName("target")~=nil then
	for i=1,40 do
		temptar="raid"..i
		if UnitName("target")==UnitName(temptar) then
			PartyTarget="raid"..i
			DEFAULT_CHAT_FRAME:AddMessage("PPT set to "..UnitName("raid"..i));
		end
		temptar="raidpet"..i
		if PartyTarget~="raidpet"..i and UnitName("target")==UnitName(temptar) then
			PartyTarget="raidpet"..i
			DEFAULT_CHAT_FRAME:AddMessage("PPT set to "..UnitName("raidpet"..i))
		end

	end
  end
end

--Buff macros (from GUI binds)
function BuffCastSetOne()
  if BA[plyr].RCFrameVar==3 then
	BuffCast("default1", BCS1.cooldown, BCS1[6], BCS1[1], BCS1[2], BCS1[3], BCS1[4], BCS1[5]);
--	BADebug("BC1 RCFrameVar",BA[plyr].RCFrameVar)
  else
	BBoC("BBOC1",RCcooldown)
--	BADebug("RS1 RCFrameVar",BA[plyr].RCFrameVar)
  end
end

--function BuffCastSetTwo()
--  if BA[plyr].RCFrameVar==3 then
--	BuffCast("default2", BCS2.cooldown, BCS2[6], BCS2[1], BCS2[2], BCS2[3], BCS2[4], BCS2[5]);
--	BADebug("BC2 RCFrameVar",BA[plyr].RCFrameVar)
--  else
--	BBoC("RCS1",RCcooldown)
--	BADebug("RS1 RCFrameVar",BA[plyr].RCFrameVar)
--  end
--end

function BuffCastSetTwo()
  if BA[plyr].RCFrameVar==3 then
	BuffCast("default2", BCScooldown, BCS3, BCS3, BCS3, BCS3, BCS3, BCS3);
--	BADebug("BC3 RCFrameVar",BA[plyr].RCFrameVar)
  else
	BBoC("BBoC2",RCcooldown, RCS2)
--	BADebug("RS2 RCFrameVar",BA[plyr].RCFrameVar)
  end
end

function BuffCastSetThree()
  if BA[plyr].RCFrameVar==3 then
	BuffCast("default3", BCScooldown, BCS4, BCS4, BCS4, BCS4, BCS4, BCS4);
--	BADebug("BC4 RCFrameVar",BA[plyr].RCFrameVar)
  else
	BBoC("BBoC3",RCcooldown, RCS3)
--	BADebug("RS3 RCFrameVar",BA[plyr].RCFrameVar)
  end
end

function BuffAhoyHealzorOne()
  Healzor(HZR1);
end

function BuffAhoyHealzorTwo()
  Healzor2(HZR2);
end

function BuffAhoyHealzorThree()
  Healzor3(HZR3);
end

function BuffAhoyCleanzorOne()
  Cleanzor(CZR1);
end


function BuffAhoyCleanzorTwo()
  Cleanzor2(CZR2);
end

function BuffAhoyProtectzorOne()
  Protectzor(PZR1);
end

function MultiCastSetEin()
  	if BA[plyr].multiverbosity==1 then
		MultiShoutCast("mscdefault",MCS1.cooldown, MCS1[1], nil, MCS1[2], nil, MCS1[3], nil, MCS1[4], nil, MCS1[5], nil, MCS1[6], nil)
  	else
		MultiCast("mcdefault",MCS1.cooldown, MCS1[1], MCS1[2], MCS1[3], MCS1[4], MCS1[5], MCS1[6])
	end
end
function MultiCastSetZwei()
  	if BA[plyr].multiverbosity==1 then
		MultiShoutCast("mscdefault",MCS2.cooldown, MCS2[1], nil, MCS2[2], nil, MCS2[3], nil, MCS2[4], nil, MCS2[5], nil, MCS2[6], nil)
  	else
		MultiCast("mcdefault",MCS2.cooldown, MCS2[1], MCS2[2], MCS2[3], MCS2[4], MCS2[5], MCS2[6])
	end
end
function ShoutCastEin()
	ShoutCast(SCT1, nil, BA[plyr].SC1_Verbose, BA[plyr].SC1_SC)
end
function ShoutCastZwei()
	ShoutCast(SCT2, nil, BA[plyr].SC2_Verbose, BA[plyr].SC2_SC)
end
function ShoutCastDrei()
	ShoutCast(SCT3, nil, BA[plyr].SC3_Verbose, BA[plyr].SC3_SC)
end
function ShoutCastVier()
	ShoutCast(SCT4, nil, BA[plyr].SC4_Verbose, BA[plyr].SC4_SC)
end

--#################Logic Functions#####################
--Check for mana, cooldown, etc
function UsableCheck(spellid, verbose, manastring, cdstring, oorstring)
   local isUsable
   local notEnoughMana
   local inRange
   local start
   local duration
   local enable
   local castme
   if spellid>=1 and spellid<=120 then
     	-- run the check
     	isUsable, notEnoughMana = IsUsableAction(spellid)
     	inRange = IsActionInRange(spellid)
     	start, duration, enable = GetActionCooldown(spellid)
   else
     	--id out of bounds, for now just default everything (maybe add error and return later)
     	isUsable=true;
     	notEnoughMana=false;
     	start=0
     	duration=0
     	enable=0
   end
   if ( start > 0 and duration > 0 and enable > 0) then
     	if cdstring~=nil and BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(cdstring);
	elseif BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_WAIT);     
	end
	return nil;
   elseif (notEnoughMana) then
        if (verbose==1 and manastring~=nil) then
		if UnitName("target")~= nil and UnitIsFriend("player","target") then
			SendChatMessage(manastring .. " %T!!" , whovar)
	        elseif UnitName(PartyTarget)~=nil then
        		SendChatMessage(manastring.." "..UnitName(PartyTarget) .."!!",whovar)
		end  
	elseif (verbose==1 and manastring==nil and BA[plyr].statustext==1) then
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_MANA)
	end
	return nil;
   elseif inRange == 0 then
	if oorstring~=nil and BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(oorstring)
	elseif BA[plyr].statustext==1 then
		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_RANGE);
	end
	return nil;
   else
	return 1;
   end

end

--Smartcasting and PPT logic
function SmartPPT(spellid, saystring, verbose, smart)
	if verbose==nil then verbose=1 end;
	if smart==nil then smart=1 end;
--	BADebug("Shift", IsShiftKeyDown())
--	BADebug("SCenabled", BA[plyr].SCenabled)
--	BADebug("smart",smart)
	if (IsShiftKeyDown() and BA[plyr].SCenabled==1 and BA[plyr].ShiftAlt==2 and smart==1) then
		BAUseAction(spellid,1,1)
	elseif (IsAltKeyDown() and BA[plyr].SCenabled==1 and  BA[plyr].ShiftAlt==1 and smart==1) then
		BAUseAction(spellid,1,1)
	elseif (IsControlKeyDown() and BA[plyr].SCenabled==1 and  BA[plyr].ShiftAlt==3 and smart==1) then
		BAUseAction(spellid,1,1)
	else
		if (BA[plyr].PPTenabled==0 and not UnitIsFriend("player","target") ) then
			if (PartyTarget~=nil and UnitName(PartyTarget)~=nil) then
				TargetUnit(PartyTarget)
			else
				TargetByName(PartyTarget)
			end
		end
		BAUseAction(spellid,1,0)
		castFlag=true;
		tempverb=verbose;
		BuffAhoyNameGrab(spellid)
		if UnitName("target")~=nil and UnitIsFriend("player","target") then
			SpellTargetUnit("target")
			if (saystring~=nil and verbose==1) then
				SendChatMessage(saystring.." "..UnitName("target").." with "..BuffAhoyNameArray[spellid],whovar)
			elseif verbose==1 then
				SendChatMessage("Casting " .. BuffAhoyNameArray[spellid].." on "..UnitName("target"),whovar)
			end
		elseif (PartyTarget~=nil and UnitName(PartyTarget)~=nil) then
			SpellTargetUnit(PartyTarget)
			if (saystring~=nil and verbose==1) then
				SendChatMessage(saystring.." "..UnitName(PartyTarget).." with "..BuffAhoyNameArray[spellid],whovar)
			elseif verbose==1 and UnitName(PartyTarget)~=nil then
				SendChatMessage("Casting " .. BuffAhoyNameArray[spellid].." on "..UnitName(PartyTarget),whovar)
			elseif UnitName(PartyTarget)==nil and BA[plyr].statustext==1 then
				DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_PPT_NOT_VALID)
			end
--		elseif PartyTarget~=nil then
--			TargetByName(PartyTarget)
--			if (saystring~=nil and verbose==1) then
--				SendChatMessage(saystring.." "..PartyTarget.." with "..BuffAhoyNameArray[spellid],whovar)
--			elseif verbose==1 then
--				SendChatMessage("Casting " .. BuffAhoyNameArray[spellid].." on "..PartyTarget,whovar)
--			end
		end
	

	end
       	--clear target if spell failed
	if SpellIsTargeting() then
		SpellStopTargeting()
 	end
end



-- Buff macro (now pet-friendly)
function BuffCast(cast_id, reset_timeout, petid, ...)

   -- if we haven't seen the cast_id before, initialize the time and step
   if not BA_step_data[cast_id] then
      BA_step_data[cast_id] = {}
      BA_step_data[cast_id]['last_time'] = 0
      BA_step_data[cast_id]['cast_step'] = 1
   end

   local now = GetTime()

   -- if the timeout has been reached, always revert to step 1
   if reset_timeout and now - BA_step_data[cast_id].last_time >= reset_timeout then
      BA_step_data[cast_id]['cast_step'] = 1
      petFlag = false
	if BA[plyr].buffbeginannounce==1 then
		SendChatMessage(BUFFAHOY_GATHER_START..UnitName("player")..BUFFAHOY_GATHER_END);
	end
   end
   
   -- update the time at which the this id was invoked
   BA_step_data[cast_id]['last_time'] = now

   -- local var for passing to UsableCheck, to determine verbosity
   if (BA[plyr].BuffCast_Verbose==1 or BA[plyr].BuffCast_Quiet==1) then 
	local talky=1;
   else
	local talky=0;
   end

   -- Check for target's existence, should stop if there is an online party member in the appropriate slot
--   if GetNumPartyMembers()>0 then
--	tarvar=playa[BA_step_data[cast_id].cast_step]
--	rpvar="party"
--	maxno=5
--   end
--   BADebug("tarvar",tarvar)
--   spellid=ClassSpecificBuffs(UnitClass(tarvar))
--   BADebug("UnitClass",UnitClass(tarvar))
--   BADebug("spellid",spellid)

--   BADebug("UnitName",UnitName(tarvar))
--   BADebug("maxno",maxno)
   while (UnitName(playa[BA_step_data[cast_id].cast_step])==nil or not HasAction(arg[BA_step_data[cast_id].cast_step])) and BA_step_data[cast_id].cast_step<table.getn( arg ) do
		BA_step_data[cast_id].cast_step = BA_step_data[cast_id].cast_step + 1
--		tarvar=playa[BA_step_data[cast_id].cast_step]

--		BADebug("stepper",BA_step_data[cast_id].cast_step)
		BADebug("UnitName",UnitName(playa[BA_step_data[cast_id].cast_step]))
--		BADebug("spellid", spellid)
--		BADebug("tarvar",tarvar)
   end


   -- local var to make code simpler
   iter=BA_step_data[cast_id]['cast_step']

   if UnitName("target")~= nil and UnitIsFriend("player","target") then
	ClearTarget()   
   end

   if BA[plyr].manabuff == 1 and UnitAffectingCombat("player")==nil then
	TargetUnit(playa[iter])
   end	

   --check for mana, cooldown, range, etc
   if (UsableCheck(arg[iter],talky)) then
   --Name Grab, for verbosity
   BuffAhoyNameGrab(arg[iter]);


   -- cast the appropriate spell

        if HasAction(arg[iter]) then
	if UnitName(playa[iter]) ~= nil then
       		if petFlag==true then
			BuffAhoyNameGrab(petid);
       			castFlag=true;
			tempverb=BA[plyr].BuffCast_Verbose;
			if BA[plyr].PPTenabled==0 or (BA[plyr].manabuff == 1 and UnitAffectingCombat("player")==nil) then TargetUnit(peta[iter]) end
       			BAUseAction(petid,1,0)
     			SpellTargetUnit(peta[iter]) 
      			petFlag=false
       			if BA[plyr].BuffCast_Verbose==1 then
          			SendChatMessage("Buffing " .. UnitName(peta[iter]) .. " with " .. BuffAhoyNameArray[petid] , whovar)
              		elseif BA[plyr].BuffCast_Quiet==1 then
				DEFAULT_CHAT_FRAME:AddMessage("Buffing " .. UnitName(peta[iter]) .. " with " .. BuffAhoyNameArray[petid] )
       			end

		else
       			castFlag=true;
			tempverb=BA[plyr].BuffCast_Verbose
			if BA[plyr].PPTenabled==0 then TargetUnit(playa[iter]) end
			BAUseAction(arg[iter],1,0)
       			SpellTargetUnit(playa[iter])
			if BA[plyr].BuffCast_Verbose==1 then
				SendChatMessage(BUFFAHOY_BUFFING_ONE .. UnitName(playa[iter]).. BUFFAHOY_BUFFING_TWO .. BuffAhoyNameArray[arg[iter]], whovar)

			elseif BA[plyr].BuffCast_Quiet==1 then
				DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_BUFFING_ONE .. UnitName(playa[iter]).. BUFFAHOY_BUFFING_TWO .. BuffAhoyNameArray[arg[iter]])
      			end
			if UnitExists(peta[iter]) and GetPetPhaseInfo(peta[iter]) then
				petFlag=true
               			BA_step_data[cast_id].cast_step = BA_step_data[cast_id].cast_step - 1
       			end
       		end
--	elseif BA[plyr].statustext==1 then
--       		DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_NOPARTYMBR.." ".. (iter-1) );     
	end
	end
       -- advance the step by one
	BA_step_data[cast_id].cast_step = BA_step_data[cast_id].cast_step + 1

       --clear target if spell failed
	if SpellIsTargeting() then
		SpellStopTargeting()
 	end
  
       -- set the step back to 1 if we've overflown the total number
	if BA_step_data[cast_id].cast_step > table.getn( arg ) then
       		BA_step_data[cast_id].cast_step = 1
		UIErrorsFrame:AddMessage("Buff Sequence Finished", 0.8, 0.8, 0.2, 1.0, UIERRORS_HOLD_TIME);
		DEFAULT_CHAT_FRAME:AddMessage("Buff Sequence Finished", 0.8, 0.8, 0.2);
	end
   
   end

end




--Heal script
function Healzor(spellid, ...)
   
   if (UsableCheck(spellid, BA[plyr].Healzor_Verbose, BUFFAHOY_NO_MANA_TO_HEAL) or (BA[plyr].Healzor_Smartcastable==1 and ( (IsShiftKeyDown() and BA[plyr].ShiftAlt==2) or (IsAltKeyDown() and BA[plyr].ShiftAlt==1) or (IsControlKeyDown() and BA[plyr].ShiftAlt==3) ) ) ) then
--	SmartPPT(spellid, BUFFAHOY_HEALZOR_TEXT, BA[plyr].Healzor_Verbose, BA[plyr].Healzor_Smartcastable)
	SmartPPT(spellid, nil, BA[plyr].Healzor_Verbose, BA[plyr].Healzor_Smartcastable)
   end
end
function Healzor2(spellid, ...)
   
   if (UsableCheck(spellid, BA[plyr].Healzor_Verbose_Two, BUFFAHOY_NO_MANA_TO_HEAL) or (BA[plyr].Healzor_Smartcastable_Two==1 and ( (IsShiftKeyDown() and BA[plyr].ShiftAlt==2) or (IsAltKeyDown() and BA[plyr].ShiftAlt==1) or (IsControlKeyDown() and BA[plyr].ShiftAlt==3) ) ) ) then
--	SmartPPT(spellid, BUFFAHOY_HEALZOR_TEXT, BA[plyr].Healzor_Verbose_Two, BA[plyr].Healzor_Smartcastable_Two)
	SmartPPT(spellid, nil, BA[plyr].Healzor_Verbose_Two, BA[plyr].Healzor_Smartcastable_Two)
   end
end
function Healzor3(spellid, ...)
   
   if (UsableCheck(spellid, BA[plyr].Healzor_Verbose_Three, BUFFAHOY_NO_MANA_TO_HEAL) or (BA[plyr].Healzor_Smartcastable_Three==1 and ( (IsShiftKeyDown() and BA[plyr].ShiftAlt==2) or (IsAltKeyDown() and BA[plyr].ShiftAlt==1) or (IsControlKeyDown() and BA[plyr].ShiftAlt==3) ) ) ) then
--	SmartPPT(spellid, BUFFAHOY_HEALZOR_TEXT, BA[plyr].Healzor_Verbose_Three, BA[plyr].Healzor_Smartcastable_Three)
	SmartPPT(spellid, nil, BA[plyr].Healzor_Verbose_Three, BA[plyr].Healzor_Smartcastable_Three)
   end
end


-- Cleanse script
function Cleanzor(spellid)

   if (UsableCheck(spellid, BA[plyr].Cleanzor_Verbose) or (BA[plyr].Cleanzor_Smartcastable==1 and ( (IsShiftKeyDown() and BA[plyr].ShiftAlt==2) or (IsAltKeyDown() and BA[plyr].ShiftAlt==1) or (IsControlKeyDown() and BA[plyr].ShiftAlt==3) ) ) ) then
--     	SmartPPT(spellid, BUFFAHOY_CLEANZOR_TEXT, BA[plyr].Cleanzor_Verbose, BA[plyr].Cleanzor_Smartcastable)
     	SmartPPT(spellid, nil, BA[plyr].Cleanzor_Verbose, BA[plyr].Cleanzor_Smartcastable)
   end
end
function Cleanzor2(spellid)

   if (UsableCheck(spellid, BA[plyr].Cleanzor_Verbose_Two) or (BA[plyr].Cleanzor_Smartcastable_Two==1 and ( (IsShiftKeyDown() and BA[plyr].ShiftAlt==2) or (IsAltKeyDown() and BA[plyr].ShiftAlt==1) or (IsControlKeyDown() and BA[plyr].ShiftAlt==3) ) ) ) then
--     	SmartPPT(spellid, BUFFAHOY_CLEANZOR_TEXT, BA[plyr].Cleanzor_Verbose_Two, BA[plyr].Cleanzor_Smartcastable_Two)
     	SmartPPT(spellid, nil, BA[plyr].Cleanzor_Verbose_Two, BA[plyr].Cleanzor_Smartcastable_Two)
   end
end 


--Blessing of Protection script
function Protectzor(spellid)

   if (UsableCheck(spellid, BA[plyr].Protectzor_Verbose, BUFFAHOY_NO_MANA_TO_PROT) or (BA[plyr].Protectzor_Smartcastable==1 and ( (IsShiftKeyDown() and BA[plyr].ShiftAlt==2) or (IsAltKeyDown() and BA[plyr].ShiftAlt==1) or (IsControlKeyDown() and BA[plyr].ShiftAlt==3) ) ) ) then
      	if (UnitName("target")~=nil and UnitIsFriend("player","target")) then
		temp=nil;
		for i=1,5,1 do
			if UnitName(playa[i])~=nil then
				if UnitName("target")==UnitName(playa[i]) then
				     	SmartPPT(spellid, nil, BA[plyr].Protectzor_Verbose, BA[plyr].Protectzor_Smartcastable)
					temp=1;				
				end
			end
		end
		if temp~=1 then
			for i=1,40,1 do
				if UnitName("raid"..i)~=nil then
					if UnitName("target")==UnitName("raid"..i) then
					     	SmartPPT(spellid, nil, BA[plyr].Protectzor_Verbose, BA[plyr].Protectzor_Smartcastable)
						temp=1;				
					end
				end
			end
		end
		if temp~=1 and BA[plyr].statustext==1 then 	
			DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_PROT_ERROR) 
		end
	else
     		SmartPPT(spellid, nil, BA[plyr].Protectzor_Verbose, BA[plyr].Protectzor_Smartcastable)
	end
   end
end

      
--SmartCast script
function Smartzor(spellid, saystring, verbosity)
  --legacy function, kept only for backwards compatibility
  if (UsableCheck(spellid,1)) then
	  SmartPPT(spellid, saystring, verbosity)
  end
end

--ShoutCast script
function ShoutCast(spellid, saystring, verbose, smart)
   if verbose==nil then verbose=1 end
   if smart==nil then smart=1 end
   if (UsableCheck(spellid, 1)) then
	BuffAhoyNameGrab(spellid);
--	if IsShiftKeyDown() and smart==1 then
	if smart==1 and ( (IsShiftKeyDown() and BA[plyr].ShiftAlt==2) or (IsAltKeyDown() and BA[plyr].ShiftAlt==1) or (IsControlKeyDown() and BA[plyr].ShiftAlt==3)) then
		SmartPPT(spellid)
        elseif (UnitName("target")~=nil and not UnitIsFriend("player","target")) then
	     -- cast spell on hostile
		BAUseAction(spellid,1,0)
		castFlag=true;
		SpellTargetUnit("target")
		if saystring~=nil and verbose==1 then
			SendChatMessage(saystring.." "..UnitName("target"),whovar) 
			tempverb=1;
		elseif verbose==1 then
			SendChatMessage("Casting " .. BuffAhoyNameArray[spellid].." on %T",whovar)
			tempverb=1;
		end
	elseif saystring ~= nil and UnitName("target")~=nil then
		SmartPPT(spellid, saystring, verbose, smart)
	else
--		SmartPPT(spellid, BUFFAHOY_SHOUTCAST_TEXT .. BuffAhoyNameArray[spellid] .. BUFFAHOY_SHOUTCAST_TEXT2, verbose, smart)
		SmartPPT(spellid, nil, verbose, smart)
	end
	successful=true
   else
	successful=false
   end
   return successful;
end


-- MultiCast script (similar to CastAway)
function MultiCast (cast_id, reset_timeout, ...)

   -- if we haven't seen the cast_id before, initialize the time and step
   if not BA_step_data[cast_id] then
      BA_step_data[cast_id] = {}
      BA_step_data[cast_id]['last_time'] = 0
      BA_step_data[cast_id]['cast_step'] = 1
   end

   local stepper = BA_step_data[cast_id]
   local now = GetTime()

   -- if the timeout has been reached, always revert to step 1
   if reset_timeout and now - stepper['last_time'] >= reset_timeout then
      stepper['cast_step'] = 1
   end
   
   -- local var to make code simpler
   iter=stepper['cast_step']

   -- update the time at which the this id was invoked
   stepper['last_time'] = now

   -- cast the appropriate spell
   if (UsableCheck(arg[iter], 1)) then


        BAUseAction(arg[iter],1,0)
          
     
     -- advance the step by one
     stepper['cast_step'] = stepper['cast_step'] + 1

     -- set the step back to 1 if we've overflown the total number
     if stepper['cast_step'] > table.getn( arg ) then
        stepper['cast_step'] = 1
     end
     
   end
end


-- MultiShoutCast script (also similar to CastAway)
function MultiShoutCast (cast_id, reset_timeout, ...)

   -- if we haven't seen the cast_id before, initialize the time and step
   if not BA_step_data[cast_id] then
      BA_step_data[cast_id] = {}
      BA_step_data[cast_id]['last_time'] = 0
      BA_step_data[cast_id]['cast_step'] = 1
   end

   local stepper = BA_step_data[cast_id]
   local now = GetTime()

   -- if the timeout has been reached, always revert to step 1
   if reset_timeout and now - stepper['last_time'] >= reset_timeout then
      stepper['cast_step'] = 1
   end
   
   -- local var to make code simpler
   iter=stepper['cast_step']

   -- update the time at which the this id was invoked
   stepper['last_time'] = now

   -- cast the appropriate spell 
 
   if HasAction(arg[iter]) then
   	successful=ShoutCast(arg[iter],arg[iter+1])          
  
  	 -- advance the step by two
   	if successful==true then
     	stepper['cast_step'] = stepper['cast_step'] + 2
   	end
   elseif (not HasAction(arg[iter])) then
	 -- advance the step by two
   	if successful==true then
     	stepper['cast_step'] = stepper['cast_step'] + 2
   	end
   end
   -- set the step back to 1 if we've overflown the total number
   if stepper['cast_step'] > table.getn( arg ) then
      stepper['cast_step'] = 1
   end
     
end



--BandAid script
function BandAid( spellname, bag, slot )


   -- if we haven't seen the cast_id before, initialize the time and step
   if not BA_step_data[BandAid] then
      BA_step_data[BandAid] = {}
      BA_step_data[BandAid]['last_time'] = 0
      BA_step_data[BandAid]['cast_step'] = 1
   end

   local stepper = BA_step_data[BandAid]
   local now = GetTime()

   -- if the timeout has been reached, always revert to step 1
   if now - stepper['last_time'] >= 5 then
      stepper['cast_step'] = 1
   end
   
   -- local var to make code simpler
   iter=stepper['cast_step']

   -- update the time at which the this id was invoked
   stepper['last_time'] = now

   if iter==1 then
      CastSpellByName(spellname)
   elseif iter==2 then
       UseContainerItem(bag,slot)
       SpellTargetUnit("player")
       DEFAULT_CHAT_FRAME:AddMessage("Bandaging");     
   end 
   

   -- advance the step by one
   stepper['cast_step'] = stepper['cast_step'] + 1

   -- set the step back to 1 if we've overflown the total number
   if stepper['cast_step'] > 2 then
      stepper['cast_step'] = 1
   end
     
end

--##########BBoC Casting Functions####################



function ClassSpecificBuffs(class)
	if class==BUFFAHOY_PALADIN or class==BUFFAHOY_SHAMAN then
		spellid=RCPalSha;   
	elseif class==BUFFAHOY_PRIEST then
		spellid=RCPriest;
	elseif class==BUFFAHOY_MAGE then
		spellid=RCMage;
	elseif class==BUFFAHOY_WARRIOR then
		spellid=RCWarrior;
	elseif class==BUFFAHOY_WARLOCK then
		spellid=RCWarlock;
	elseif class==BUFFAHOY_ROGUE then
		spellid=RCRogue;
	elseif class==BUFFAHOY_HUNTER then
		spellid=RCHunter;
	elseif class==BUFFAHOY_DRUID then
		spellid=RCDruid;
   	elseif class==nil then
		spellid=-1;
	else
		DEFAULT_CHAT_FRAME:AddMessage("Error: Unknown Class")
		spellid=-1;
   	end
	return spellid
end

function IsTargetLegal(tarvar, spellid, idno)
			-- find a legal target.  Assume we have one, and run a series of checks on them.  
			--If legaltarget is still true after all of the checks, then we have a target we can cast on.
			legaltarget=true
			-- Unit doesn't exist, or unit type isn't recognized
			if UnitName(tarvar)==nil or spellid==-1 then
				legaltarget=nil
			-- unit type isn't getting buffed
			elseif not HasAction(spellid) then
				legaltarget=nil
			-- Unit is in a group that's excluded
			elseif GetGroupBuffStatus(idno)==0 then
				legaltarget=nil
			-- Unit class already has a Greater Blessing
			elseif BA_GroupBuff[UnitClass(tarvar)]==2 and petFlag==false then
				legaltarget=nil	
				BADebug("GROUP_BUFF_PREVENT",100)
			end
			return legaltarget
end

function BBoC(cast_id, reset_timeout, id)
	local rpvar
	local tarvar
	local maxno
	local itervar
	local legaltarget

	-- if we haven't seen the cast_id before, initialize the time and step
	if not BA_step_data[cast_id] then
      BA_step_data[cast_id] = {}
      BA_step_data[cast_id]['last_time'] = 0
      BA_step_data[cast_id]['cast_step'] = 1
      BA_step_data[cast_id]['currnum']=0;
	end

   --local variables to make the coding easier
	local now = GetTime()

   -- if the timeout has been reached, always revert to step 1
	if reset_timeout and now - BA_step_data[cast_id].last_time >= reset_timeout then
		BA_step_data[cast_id].cast_step = 1
		BA_step_data[cast_id].currnum = 0
		petFlag = false
		-- reset group buff variables
	--	for i=1,GetNumRaidMembers(),1 do
		--	BA_GroupBuff[UnitClass("raid"..i)]=0
		--end
		BA_GroupBuff[BUFFAHOY_PRIEST]=0
		BA_GroupBuff[BUFFAHOY_MAGE]=0
		BA_GroupBuff[BUFFAHOY_DRUID]= 0
		BA_GroupBuff[BUFFAHOY_WARRIOR]=0
		BA_GroupBuff[BUFFAHOY_HUNTER]=0
		BA_GroupBuff[BUFFAHOY_WARLOCK]=0
		BA_GroupBuff[BUFFAHOY_ROGUE]=0
		BA_GroupBuff[BUFFAHOY_PALADIN]=0
		BA_GroupBuff[BUFFAHOY_SHAMAN]=0 

--		BADebug("ann",BA[plyr].buffbeginannounce)
		if BA[plyr].buffbeginannounce==1 then
			SendChatMessage(BUFFAHOY_GATHER_START..UnitName("player")..BUFFAHOY_GATHER_END);
		end
	end
   
   -- update the time at which the this id was invoked
   BA_step_data[cast_id].last_time = now


   -- Check for target's existence, should stop if there is an online party member in the appropriate slot
   if GetNumRaidMembers()>0 and BA[plyr].forceparty==0 then
	itervar=41-BA_step_data[cast_id].cast_step
	tarvar="raid"..itervar
	tarpetvar="raidpet"..itervar
	rpvar="raid"
	maxno=40
   else
	tarvar=playa[BA_step_data[cast_id].cast_step]
	tarpetvar=peta[BA_step_data[cast_id].cast_step]
	rpvar="party"
	maxno=5
   end
--   BADebug("tarvar",tarvar)
   if id==nil then
	spellid=ClassSpecificBuffs(UnitClass(tarvar))
   else
	spellid=id
   end

--   BADebug("UnitClass",UnitClass(tarvar))
--   BADebug("spellid",spellid)
--	BADebug("tarvar0",tarvar)
--	BADebug("UnitName0",UnitName(tarvar))
--   BADebug("maxno",maxno)

	-- find a legal target.  Assume we have one, and run a series of checks on them.  
	--If legaltarget is still true after all of the checks, then we have a target we can cast on.
--	legaltarget=IsTargetLegal(tarvar, spellid, GetNumRaidMembers()+1-BA_step_data[cast_id].cast_step)
	--GetNumRaidMembers()+
	while (IsTargetLegal(tarvar, spellid, 41-BA_step_data[cast_id].cast_step)==nil and BA_step_data[cast_id].cast_step<maxno) do
--   while (UnitName(tarvar)==nil or spellid==-1 or not HasAction(spellid) or GetGroupBuffStatus(GetNumRaidMembers()+1-BA_step_data[cast_id].cast_step)==0) and BA_step_data[cast_id].cast_step<maxno do
		BA_step_data[cast_id].cast_step = BA_step_data[cast_id].cast_step + 1
		if GetNumRaidMembers()>0 and BA[plyr].forceparty==0 then
			itervar=41-BA_step_data[cast_id].cast_step
			tarvar="raid"..itervar
		else
			tarvar=playa[BA_step_data[cast_id].cast_step]
		end
		if id==nil then
			spellid=ClassSpecificBuffs(UnitClass(tarvar))
		else
			spellid=id;
		end

		-- find a legal target.  Assume we have one, and run a series of checks on them.  
		--If legaltarget is still true after all of the checks, then we have a target we can cast on.
--		legaltarget=IsTargetLegal(tarvar, spellid, GetNumRaidMembers()+1-BA_step_data[cast_id].cast_step)
		
--		BADebug("stepper",BA_step_data[cast_id].cast_step)
--		BADebug("itervar1", spellid)
--		BADebug("tarvar1",tarvar)
--		BADebug("UnitName1",UnitName(tarvar))
   end

-- Now we should have a legal target, or else we're at the end of the buff sequence


	--more local variables to make the coding easier
	local iter = BA_step_data[cast_id].cast_step


	-- local var for passing to UsableCheck, to determine verbosity
	local talky;
	if (BA[plyr].BuffCast_Verbose==1 or BA[plyr].BuffCast_Quiet==1) then 
		talky=1
	else
		talky=0
	end
--   DEFAULT_CHAT_FRAME:AddMessage("Starting Cast Sequence", 0.8, 0.8, 0.2)
--   BADebug("spellid3",spellid)

	-- if target is friendly, clear target
	if UnitName("target")~= nil and UnitIsFriend("player","target")  then
		ClearTarget()
	end

	-- if we have the "Wait for mana/range" option checked, and we're not in combat, target the person being buffed
	if BA[plyr].manabuff == 1 and UnitAffectingCombat("player")==nil then
		TargetUnit(tarvar)
	end	

	--check for mana, cooldown, range, etc
		--BADebug("usable",UsableCheck(spellid,talky))
	if (UsableCheck(spellid,talky)) then
		--Name Grab, for verbosity
		BuffAhoyNameGrab(spellid);
		--BADebug("stepbefore",BA_step_data[cast_id].cast_step)
		-- cast the appropriate spell
        if HasAction(spellid) then
			if UnitName(tarvar) ~= nil then
				if petFlag==true and UnitName(tarpetvar)~=nil then
					castFlag=true;
					BA_step_data[cast_id].currnum = BA_step_data[cast_id].currnum + 1;
					if BA[plyr].PPTenabled==0 or (BA[plyr].manabuff == 1 and UnitAffectingCombat("player")==nil) then TargetUnit(tarpetvar) end
					if id==nil then spellid=RCPet1 end
					BAUseAction(spellid,1,0)
					SpellTargetUnit(tarpetvar)
					petFlag=false
					if BA[plyr].BuffCast_Verbose==1 then
						SendChatMessage(BUFFAHOY_BUFFING_ONE .. UnitName(tarpetvar) .. BUFFAHOY_BUFFING_TWO .. BuffAhoyNameArray[spellid].."   (".. BA_step_data[cast_id].currnum .."/"..GetMaxNum(id)..")", whovar)
					elseif BA[plyr].BuffCast_Quiet==1 then
						DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_BUFFING_ONE .. UnitName(tarpetvar) .. BUFFAHOY_BUFFING_TWO .. BuffAhoyNameArray[RCPet1].."   (".. BA_step_data[cast_id].currnum .."/"..GetMaxNum(id)..")")
					end

				else
					castFlag=true;
					failFlag=false; -- so that we can check for failure later
					--BADebug("s.find GB",string.find(BuffAhoyNameArray[spellid],BA_GREATER_BLESSING_TEXT,1,true))
					--BADebug("s.find B",string.find(BuffAhoyNameArray[spellid],"Blessing",1,true))
					if string.find(BuffAhoyNameArray[spellid],BA_GREATER_BLESSING_TEXT,1,true) then
						BA_GroupBuff[UnitClass(tarvar)]=1;
						BADebug("BA_GB",BA_GroupBuff[UnitClass(tarvar)])
						BA_step_data[cast_id].currnum=BA_step_data[cast_id].currnum + GetClassCounts(UnitClass(tarvar))
					else
						BA_step_data[cast_id].currnum=BA_step_data[cast_id].currnum + 1
					end
					tempverb=BA[plyr].BuffCast_Verbose;
					if BA[plyr].PPTenabled==0 then TargetUnit(tarvar) end
					BAUseAction(spellid,1,0)
					SpellTargetUnit(tarvar)
					if BA[plyr].BuffCast_Verbose==1 then
						if BA_GroupBuff[UnitClass(tarvar)]==1 then
							SendChatMessage(BUFFAHOY_BUFFING_ONE .. UnitClass(tarvar).."s" .. BUFFAHOY_BUFFING_TWO .. BuffAhoyNameArray[spellid] .."   ("..BA_step_data[cast_id].currnum .."/"..GetMaxNum(id)..")", whovar)
						else
							SendChatMessage(BUFFAHOY_BUFFING_ONE .. UnitName(tarvar) .. BUFFAHOY_BUFFING_TWO .. BuffAhoyNameArray[spellid] .."   ("..BA_step_data[cast_id].currnum .."/"..GetMaxNum(id)..")", whovar)
						end
					elseif BA[plyr].BuffCast_Quiet==1 then
						if BA_GroupBuff[UnitClass(tarvar)]==1 then
							DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_BUFFING_ONE .. UnitClass(tarvar).."s"  .. BUFFAHOY_BUFFING_TWO .. BuffAhoyNameArray[spellid] .."   (".. BA_step_data[cast_id].currnum .."/"..GetMaxNum(id)..")")
						else
							DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_BUFFING_ONE .. UnitName(tarvar) .. BUFFAHOY_BUFFING_TWO .. BuffAhoyNameArray[spellid] .."   (".. BA_step_data[cast_id].currnum .."/"..GetMaxNum(id)..")")
						end
					end
					if UnitExists(tarpetvar) and (HasAction(RCPet1) or id~=nil) and GetPetPhaseInfo(tarpetvar) then
						petFlag=true
						BA_step_data[cast_id].cast_step = BA_step_data[cast_id].cast_step-1
						--BADebug("step",BA_step_data[cast_id].cast_step)
					end
				end
			elseif BA[plyr].statustext==1 then
				if GetNumRaidMembers()>0 then
					DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_NORAIDMBR.. (iter) );     
				else
					DEFAULT_CHAT_FRAME:AddMessage(BUFFAHOY_ERR_NOPARTYMBR.." "..(iter) );
				end
			end  --closes UnitName
		end  --closes HasAction

		-- advance the step by one
		BA_step_data[cast_id].cast_step=BA_step_data[cast_id].cast_step+1

       -- clear target if spell failed, handle Greater Blessing exceptions
		if SpellIsTargeting() then
			--spell has failed
			SpellStopTargeting()
		end
		--if spell was a greater blessing attempt and has failed
		if BA_GroupBuff[UnitClass(tarvar)]==1 and failFlag==true then

			--reset the GB variable, so that it will attempt on the next member of that class
			BA_GroupBuff[UnitClass(tarvar)]=0;
			BADebug("GROUP_BUFF_RESET",BA_GroupBuff[UnitClass(tarvar)])

			-- subtract off of the current number if there's another member of that class later
			if GetClassCounts(UnitClass(tarvar))>1 then
				BA_step_data[cast_id].currnum=BA_step_data[cast_id].currnum - GetClassCounts(UnitClass(tarvar))
			end

		-- spell has succeeded, and it was a Greater Blessing attempt
		elseif BA_GroupBuff[UnitClass(tarvar)]==1 then

			--mark that class as successful, so that future members of that class aren't buffed
			BA_GroupBuff[UnitClass(tarvar)]=2
			BADebug("GROUP_BUFF_SUCCESS",BA_GroupBuff[UnitClass(tarvar)])
		end
		
		--BADebug("step",BA_step_data[cast_id].cast_step)

		-- Check for next target's existence, should stop if there is an online party member in the appropriate slot
		if BA_step_data[cast_id].cast_step<=maxno then
			if GetNumRaidMembers()>0 and BA[plyr].forceparty==0 then
				itervar=41-BA_step_data[cast_id].cast_step
				tarvar="raid"..itervar
				tarpetvar="raidpet"..itervar
				rpvar="raid"
				maxno=40
			else
				tarvar=playa[BA_step_data[cast_id].cast_step]
				tarpetvar=peta[BA_step_data[cast_id].cast_step]
				rpvar="party"
				maxno=5
			end

			--BADebug("stepafter",BA_step_data[cast_id].cast_step)
			--BADebug("tarvar",tarvar)
			if id==nil then
				spellid=ClassSpecificBuffs(UnitClass(tarvar))
			else
				spellid=id;
			end
				--BADebug("UnitClass",UnitClass(tarvar))
				--BADebug("spellid-pw",spellid)
	
				--BADebug("UnitName-pw",UnitName(tarvar))
				--BADebug("maxno",maxno)
				--BADebug("tarvar-pw",tarvar)
			while (IsTargetLegal(tarvar, spellid, 41-BA_step_data[cast_id].cast_step)==nil and BA_step_data[cast_id].cast_step<=maxno) do
--			while (UnitName(tarvar)==nil or spellid==-1 or not HasAction(spellid) or GetGroupBuffStatus(GetNumRaidMembers()+1-BA_step_data[cast_id].cast_step)==0) and BA_step_data[cast_id].cast_step<=maxno do

				BA_step_data[cast_id].cast_step = BA_step_data[cast_id].cast_step + 1
				if BA_step_data[cast_id].cast_step<=maxno then
					if GetNumRaidMembers()>0 and BA[plyr].forceparty==0 then
						itervar=41-BA_step_data[cast_id].cast_step
						tarvar="raid"..itervar
						tarpetvar="raidpet"..itervar
					else
						tarvar=playa[BA_step_data[cast_id].cast_step]
						tarpetvar=peta[BA_step_data[cast_id].cast_step]
					end
					if id==nil then
						spellid=ClassSpecificBuffs(UnitClass(tarvar))
					else
						spellid=id
					end
				end
					--BADebug("stepper-w",BA_step_data[cast_id].cast_step)
					--BADebug("itervar-w",itervar)
					--BADebug("UnitName-w",UnitName(tarvar))
					--BADebug("spellid-w", spellid)
					--BADebug("tarvar-w",tarvar)
			end  --closes while loop
		end  --closes bug fix section
  
       -- set the step back to 1 if we've overflown the total number
	if (BA_step_data[cast_id].cast_step>maxno) then
       		BA_step_data[cast_id].cast_step = 1
		BA_step_data[cast_id].currnum=0
		UIErrorsFrame:AddMessage("Buff Sequence Finished", 0.8, 0.8, 0.2, 1.0, UIERRORS_HOLD_TIME);
		DEFAULT_CHAT_FRAME:AddMessage("Buff Sequence Finished", 0.8, 0.8, 0.2);
		BA_GroupBuff[BUFFAHOY_PRIEST]=0
		BA_GroupBuff[BUFFAHOY_MAGE]=0
		BA_GroupBuff[BUFFAHOY_DRUID]= 0
		BA_GroupBuff[BUFFAHOY_WARRIOR]=0
		BA_GroupBuff[BUFFAHOY_HUNTER]=0
		BA_GroupBuff[BUFFAHOY_WARLOCK]=0
		BA_GroupBuff[BUFFAHOY_ROGUE]=0
		BA_GroupBuff[BUFFAHOY_PALADIN]=0
		BA_GroupBuff[BUFFAHOY_SHAMAN]=0 
	end
   
   end	--to close UsableCheck()

end	--closes function

function GetMaxNum(id)
	local temp1=0
	-- set all counts to zero
	BA_NumWarriors=0;
	BA_NumMages=0;
	BA_NumPriests=0;
	BA_NumDruids=0;
	BA_NumHunters=0;
	BA_NumWarlocks=0;
	BA_NumRogues=0;
	BA_NumPalSha=0;
	BA_NumPets=0;
		
	-- classify each raid member and add a count
	if GetNumRaidMembers()>0 and BA[plyr].forceparty==0 then
		--BADebug("raid members",GetNumRaidMembers())
		for i=1,GetNumRaidMembers(),1 do
			-- check for group buffing
			if GetGroupBuffStatus(i)~=0 then
				-- add to class subtotals
				if UnitClass("raid"..i)==BUFFAHOY_WARRIOR then
					BA_NumWarriors=BA_NumWarriors+1
				elseif UnitClass("raid"..i)==BUFFAHOY_PRIEST then
					BA_NumPriests=BA_NumPriests+1
				elseif UnitClass("raid"..i)==BUFFAHOY_DRUID then
					BA_NumDruids=BA_NumDruids+1
				elseif UnitClass("raid"..i)==BUFFAHOY_MAGE then
					BA_NumMages=BA_NumMages+1
				elseif UnitClass("raid"..i)==BUFFAHOY_HUNTER then
					BA_NumHunters=BA_NumHunters+1
				elseif UnitClass("raid"..i)==BUFFAHOY_WARLOCK then
					BA_NumWarlocks=BA_NumWarlocks+1
				elseif UnitClass("raid"..i)==BUFFAHOY_ROGUE then
					BA_NumRogues=BA_NumRogues+1
				elseif UnitClass("raid"..i)==BUFFAHOY_PALADIN or UnitClass("raid"..i)==BUFFAHOY_SHAMAN then
					BA_NumPalSha=BA_NumPalSha+1
				end
			end
			--BADebug("Paladins",BA_NumPalSha)
			-- check for pets
			if UnitExists("raidpet"..i) and GetPetPhaseInfo("raidpet"..i) and GetGroupBuffStatus(i)~=0  then
				BA_NumPets=BA_NumPets+1
			end
		end		
			--add up number of people being buffed
			if id~=nil then
				temp1 = BA_NumWarriors + BA_NumMages + BA_NumPriests + BA_NumDruids + BA_NumHunters + BA_NumWarlocks + BA_NumRogues + BA_NumPalSha + BA_NumPets
			else
				if HasAction(RCWarrior) then temp1=temp1+BA_NumWarriors end
				if HasAction(RCMage) then temp1=temp1+BA_NumMages	end
				if HasAction(RCPriest) then temp1=temp1+BA_NumPriests	end
				if HasAction(RCDruid) then temp1=temp1+BA_NumDruids	end
				if HasAction(RCHunter) then temp1=temp1+BA_NumHunters	end
				if HasAction(RCWarlock) then temp1=temp1+BA_NumWarlocks	end
				if HasAction(RCRogue) then temp1=temp1+BA_NumRogues	end
				if HasAction(RCPalSha) then temp1=temp1+BA_NumPalSha	end
				if HasAction(RCPet1) then temp1=temp1+BA_NumPets	end
			end

-- old code		

--		temp1=GetNumRaidMembers()
--		for i=1,GetNumRaidMembers(),1 do
--			if (not HasAction(RCWarrior) and UnitClass("raid"..i)=="Warrior") or (not HasAction(RCMage) and UnitClass("raid"..i)=="Mage") or (not HasAction(RCPriest) and UnitClass("raid"..i)=="Priest") or (not HasAction(RCDruid) and UnitClass("raid"..i)=="Druid") or (not HasAction(RCHunter) and UnitClass("raid"..i)=="Hunter") or (not HasAction(RCWarlock) and UnitClass("raid"..i)=="Warlock")or (not HasAction(RCRogue) and UnitClass("raid"..i)=="Rogue") or (not HasAction(RCPalSha) and (UnitClass("raid"..i)=="Paladin" or UnitClass("raid"..i)=="Shaman")) then
--					temp1=temp1-1;
--			elseif GetGroupBuffStatus(i)==0 then
--					temp1=temp1-1;
--			end
--			if ((HasAction(RCPet1) or id~=nil) and UnitExists("raidpet"..i) and GetPetPhaseInfo("raidpet"..i)) then
--				temp1=temp1+1 
--			end
--		end


		return temp1

	elseif GetNumPartyMembers()>0 then
		BADebug("party members",GetNumPartyMembers())
		for i=1,GetNumPartyMembers()+1,1 do
			-- add to class subtotals
			if UnitClass(playa[i])==BUFFAHOY_WARRIOR then
				BA_NumWarriors=BA_NumWarriors+1
				BADebug("Warriors",BA_NumWarriors)
			elseif UnitClass(playa[i])==BUFFAHOY_PRIEST then
				BA_NumPriests=BA_NumPriests+1
			elseif UnitClass(playa[i])==BUFFAHOY_MAGE then
				BA_NumMages=BA_NumMages+1
			elseif UnitClass(playa[i])==BUFFAHOY_DRUID then
				BA_NumDruids=BA_NumDruids+1
			elseif UnitClass(playa[i])==BUFFAHOY_HUNTER then
				BA_NumHunters=BA_NumHunters+1
			elseif UnitClass(playa[i])==BUFFAHOY_WARLOCK then
				BA_NumWarlocks=BA_NumWarlocks+1
				BADebug("Warlocks",BA_NumWarlocks)
			elseif UnitClass(playa[i])==BUFFAHOY_ROGUE then
				BA_NumRogues=BA_NumRogues+1
			elseif UnitClass(playa[i])==BUFFAHOY_PALADIN or UnitClass(playa[i])==BUFFAHOY_SHAMAN then
				BA_NumPalSha=BA_NumPalSha+1
				BADebug("Pal or Sha",BA_NumPalSha)
			end

			-- check for pets
			if UnitExists(peta[i]) and GetPetPhaseInfo(peta[i])  then
				BA_NumPets=BA_NumPets+1
			end
		end		
		
		--add up number of people being buffed
		if id~=nil then
			temp1 = BA_NumWarriors + BA_NumMages + BA_NumPriests + BA_NumDruids + BA_NumHunters + BA_NumWarlocks + BA_NumRogues + BA_NumPalSha + BA_NumPets
		else
			if HasAction(RCWarrior) then temp1=temp1+BA_NumWarriors end
			if HasAction(RCMage) then temp1=temp1+BA_NumMages	end
			if HasAction(RCPriest) then temp1=temp1+BA_NumPriests	end
			if HasAction(RCDruid) then temp1=temp1+BA_NumDruids	end
			if HasAction(RCHunter) then temp1=temp1+BA_NumHunters	end
			if HasAction(RCWarlock) then temp1=temp1+BA_NumWarlocks	end
			if HasAction(RCRogue) then temp1=temp1+BA_NumRogues	end
			if HasAction(RCPalSha) then temp1=temp1+BA_NumPalSha	end
			if HasAction(RCPet1) then temp1=temp1+BA_NumPets	end
		end
			
			
--		temp1=GetNumPartyMembers()+1
--		for i=1,GetNumPartyMembers()+1,1 do
--			if (not HasAction(RCWarrior) and UnitClass(playa[i])=="Warrior") or (not HasAction(RCMage) and UnitClass(playa[i])=="Mage") or (not HasAction(RCPriest) and UnitClass(playa[i])=="Priest") or (not HasAction(RCDruid) and UnitClass(playa[i])=="Druid") or (not HasAction(RCHunter) and UnitClass(playa[i])=="Hunter") or (not HasAction(RCWarlock) and UnitClass(playa[i])=="Warlock")or (not HasAction(RCRogue) and UnitClass(playa[i])=="Rogue") or (not HasAction(RCPalSha) and (UnitClass(playa[i])=="Paladin" or UnitClass(playa[i])=="Shaman")) then
--					temp1=temp1-1;
--			end
--			if (((HasAction(BCS1[6]) and BA[plyr].RCFrameVar==3) or (HasAction(RCPet1) and (BA[plyr].RCFrameVar==2 or BA[plyr].RCFrameVar==1)) or id~=nil) and UnitExists(peta[i]) and GetPetPhaseInfo(peta[i]) ) then 
--				temp1=temp1+1
--			end
--		end

		return temp1
	else
		BADebug("Alone",1)
		return 1
	end
end

function GetClassCounts(class)
	local tempx
	GetMaxNum()
	if class==BUFFAHOY_WARRIOR then
		tempx= BA_NumWarriors
	elseif class==BUFFAHOY_MAGE then
		tempx= BA_NumMages
	elseif class==BUFFAHOY_PRIEST then
		tempx= BA_NumPriests
	elseif class==BUFFAHOY_DRUID then
		tempx= BA_NumDruids
	elseif class==BUFFAHOY_HUNTER then
		tempx= BA_NumHunters
	elseif class==BUFFAHOY_WARLOCK then
		tempx= BA_NumWarlocks
	elseif class==BUFFAHOY_ROGUE then
		tempx= BA_NumRogues
	elseif class==BUFFAHOY_PALADIN or class==BUFFAHOY_SHAMAN then
		tempx= BA_NumPalSha
	end
	return tempx
end

function GetGroupBuffStatus(raidid)
	local trash1, trash2, groupno = GetRaidRosterInfo(raidid);
	return	BA[plyr]["group"][groupno]
end

function GetPetPhaseInfo(unit)
	local shifted=1;
        --BADebug("shifted before",shifted)
	for jj=1,16 do
		local ba_buff_text=UnitBuff(unit,jj)
		--BADebug("ba_buff_text",ba_buff_text)
		if ba_buff_text then
			if string.find(ba_buff_text,"PhaseShift") then
				shifted=nil;
				--BADebug("shifted during",shifted)
			end	
		end
		
	end
	return shifted;
end

function Panic()
   if UnitClass("player")=="Paladin" then
	-- check target first
	if UnitClass("target")~="Paladin" and UnitClass("target")~="Priest" then
		-- if the target is not in the party or raid
		if not UnitInParty("target") and not UnitInRaid("target") then
			if UnitIsDead("target") then
				ClearTarget()
				-- target yourself, just to make absolutely sure our target has been cleared
				TargetUnit("player")
			end
		end
	end
	--Cast DI, we should have the spellcasting hand now	
	CastSpellByName("Divine Intervention")

	-- loop through the raid members if we're in a raid
	if GetNumRaidMembers()>0 then
		for kk=1,40 do
			if UnitClass("raid"..kk) == "Paladin" or UnitClass("raid"..kk) == "Priest" and not UnitIsDead("raid"..kk) then
				if UnitName("raid"..kk)~=UnitName("player") then
					TargetUnit("raid"..kk)
					SpellTargetUnit("raid"..kk)
					if not SpellIsTargeting() then
						SendChatMessage(BUFFAHOY_PANIC_TEXT ..UnitName("raid"..kk),whovar)
						break
					end
				end
			end
		end
		if SpellIsTargeting() then
			for kk=1,40 do
				if UnitClass("raid"..kk)=="Druid" and not UnitIsDead("raid"..kk) then
					if UnitName("raid"..kk)~=UnitName("player") then
						TargetUnit("raid"..kk)
						SpellTargetUnit("raid"..kk)
						if not SpellIsTargeting() then
							SendChatMessage(BUFFAHOY_PANIC_TEXT ..UnitName("raid"..kk),whovar)
							break
						end
					end
				end
			end
		end

	elseif GetNumPartyMembers()>0 then
		for kk=1,4 do
			if UnitClass("party"..kk) == "Paladin" or UnitClass("party"..kk) == "Priest" and not UnitIsDead("party"..kk) then
				TargetUnit("party"..kk)
				SpellTargetUnit("party"..kk)
				if not SpellIsTargeting() then
					SendChatMessage(BUFFAHOY_PANIC_TEXT ..UnitName("party"..kk),whovar)
					--BADebugVar=true
					BADebug("party","party"..kk)
					BADebug("name", UnitName("party"..kk) )
					BADebug("class",UnitClass("party"..kk))
					break
				end
			end
		end
		if SpellIsTargeting() then
			for kk=1,4 do
				if UnitClass("party"..kk)=="Druid" and not UnitIsDead("party"..kk) then
					TargetUnit("party"..kk)
					SpellTargetUnit("party"..kk)
					if not SpellIsTargeting() then
						SendChatMessage(BUFFAHOY_PANIC_TEXT ..UnitName("party"..kk),whovar)
						break
					end
				end
			end
		end
	end
	if SpellIsTargeting() then
		SpellStopTargeting()
		SendChatMessage(BUFFAHOY_PANIC_FAILED,whovar)
	end
   end
end
	

function BATEST(id)
	BAUseAction(id,1,0)
end

function BAWRITE(str)
	DEFAULT_CHAT_FRAME:AddMessage(str)
end