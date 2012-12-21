--[[
 Decursive (v 1.9.7) add-on for World of Warcraft UI
 Copyright (C) 2005 Archarodim ( http://www.2072productions.com/?to=decursive-continued.txt )
 This is the continued work of the original Decursive (v1.9.4) by Quu
 Decursive 1.9.4 is in public domain ( www.quutar.com )
 
 License:
	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
 
	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]
--
-- TODO allow people to edit and store the debuffs them selves... to custimze the skip list
-- TODO add a debuff priority list... "IE look for these first"
-- TODO make the main bar "hideable" instead of just closeable
-- TODO figure out a way to show that there is more than one debuff in the live list
-- TODO add more macro and keybidnings
-- TODO do a code cleanup
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Debug commands
--
-- These are commands to change any of the default actions of Decursive.
-- Change these to customize how you want things. The purpose of these flags
-- is for mod developers to customize the behavour, or for confidant people
-- to muck with things
-------------------------------------------------------------------------------
-- this will spam... really only use it for testing
local Dcr_Print_Spell_Found = false; -- XXX
-- how many seconds... can be fractional... needs to be more than 0.4... 1.0 is optimal
local Dcr_SpellCombatDelay = 1.0;
-- print out a fuckload of info
Dcr_Print_DEBUG = false;
Dcr_Print_DEBUG_bis = false;
-------------------------------------------------------------------------------



-------------------------------------------------------------------------------
-- here is the global variables, these should not be changed. These basically
-- are the limits of WoW client.
-------------------------------------------------------------------------------
DCR_MAXDEBUFFS = 16;
DCR_MAXBUFFS   = 16;
DCR_START_SLOT = 1;
DCR_END_SLOT   = 120;
-------------------------------------------------------------------------------
-- and any internal HARD settings for decursive
DCR_MAX_LIVE_SLOTS = 15;
DCR_TEXT_LIFETIME = 4;
-- DCR_MAX_RANGE_CHECK = 4;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- The stored variables
-------------------------------------------------------------------------------
Dcr_Saved = {
    -- this is the items that are stored... I might later do this per account.                                               	

    -- this is the priority list of people to cure
    PriorityList = { };

    -- this is the people to skip
    SkipList = { };

    -- this is wiether or not to show the "live" list	
    Show_LiveList = true;

    -- This will turn on and off the sending of messages to the default chat frame
    Print_ChatFrame = false;

    -- this will send the messages to a custom frame that is moveable	
    Print_CustomFrame = true;

    -- this will disable error messages
    Print_Error = true;

    -- check for abolish XXX before curing poison or disease
    Check_For_Abolish = true;

    -- this is "fix" for the fact that rank 1 of dispell magic does not always remove
    -- the high level debuffs properly. This carrys over to other things.
    AlwaysUseBestSpell = true;

    -- should we do the orders randomly?
    Random_Order = false;

    -- should we scan pets
    Scan_Pets = true;

    -- should we ignore stealthed units
    Ingore_Stealthed = false;

    -- how many to show in the livelist
    Amount_Of_Afflicted = 5;

    -- how many seconds to "black list" someone with a failed spell
    CureBlacklist	= 5.0;

    -- how often to poll for afflictions in seconds
    ScanTime = 0.2;

    -- do a range check
    -- RangeCheck = true;

    -- Are prio list members protected from blacklisting?
    DoNot_Blacklist_Prio_List = false;

    -- Play a sound when there is something to decurse
    PlaySound = true;

    -- Hide the buttons
    HideButtons = false;

};
-- this is something i use for remote debugging
DCR_REMOTE_DEBUG = { };
-- This array avoid to test someone we've just blackisted twice.
local DCR_ThisCleanBlaclisted = { };
-- local DCR_ThisNumberOoRUnits  = 0;

-------------------------------------------------------------------------------

function Dcr_OnLoad (Frame)
   Frame:RegisterEvent("PLAYER_LOGIN");
end

local Dcr_CheckingPET = false;
local Dcr_DelayedReconf = false;

function Dcr_OnEvent (event)
    local Frame = this;

     -- Dcr_debug_bis ("Event was catch: " .. event);
    

    if (event == "UNIT_PET" and arg1 == "player" and not Dcr_CheckingPET) then
	Dcr_CheckingPET = true;
	Dcr_debug_bis ("PLAYER pet detected! Poll in 2 seconds");
	return;
    elseif (event == "UNIT_PET" and (arg1 ~= "player" or Dcr_CheckingPET)) then
	return;
    elseif (event == "PLAYER_ENTER_COMBAT") then
	Dcr_EnterCombat();
	return;
    elseif (event == "PLAYER_LEAVE_COMBAT") then
	Dcr_LeaveCombat();
	return;
    elseif (event == "UI_ERROR_MESSAGE") then
	if (arg1 == SPELL_FAILED_LINE_OF_SIGHT) then
	    Dcr_errln("Out of sight!");
	    Dcr_SpellCastFailed();
	end
	return;
	--[[ elseif (
	(event == "SPELLCAST_FAILED") or
	(event == "SPELLCAST_INTERRUPTED")
	) then
	if (arg1) then --  XXX
	    Dcr_errln("test arg on cast failed: " .. arg1);

	end
	Dcr_SpellCastFailed();
	return;
	--]]
    elseif (event == "SPELLCAST_STOP") then
	Dcr_SpellWasCast();
	return;
    elseif (not Dcr_DelayedReconf and event == "SPELLS_CHANGED" and arg1==nil) then
	Dcr_DelayedReconf = true;
	return;
    elseif (event == "LEARNED_SPELL_IN_TAB") then
	Dcr_Configure();
	return;
    
    end

    if (event == "PLAYER_LOGIN") then
	Frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	Frame:RegisterEvent("PLAYER_LEAVING_WORLD");
	Dcr_Init();
	return;
    end

    if (
	(event == "PLAYER_ENTERING_WORLD")
	) then
	Frame:RegisterEvent("PLAYER_ENTER_COMBAT");
	Frame:RegisterEvent("PLAYER_LEAVE_COMBAT");
	-- Frame:RegisterEvent("SPELLCAST_FAILED");
	-- Frame:RegisterEvent("SPELLCAST_INTERRUPTED");
	Frame:RegisterEvent("SPELLCAST_STOP");
	Frame:RegisterEvent("UNIT_PET");
	Frame:RegisterEvent("SPELLS_CHANGED");
	Frame:RegisterEvent("LEARNED_SPELL_IN_TAB");
	Frame:RegisterEvent("UI_ERROR_MESSAGE");

    elseif (event == "PLAYER_LEAVING_WORLD") then

	Frame:UnregisterEvent("PLAYER_ENTER_COMBAT");
	Frame:UnregisterEvent("PLAYER_LEAVE_COMBAT");
	-- Frame:UnregisterEvent("SPELLCAST_FAILED");
	-- Frame:UnregisterEvent("SPELLCAST_INTERRUPTED");
	Frame:UnregisterEvent("SPELLCAST_STOP");
	Frame:UnregisterEvent("UNIT_PET");
	Frame:UnregisterEvent("SPELLS_CHANGED");
	Frame:UnregisterEvent("LEARNED_SPELL_IN_TAB");
	Frame:UnregisterEvent("UI_ERROR_MESSAGE");
    end

end

-------------------------------------------------------------------------------
-- and the printing functions
-------------------------------------------------------------------------------
function Dcr_debug( Message)
    if (Dcr_Print_DEBUG) then
	table.insert(DCR_REMOTE_DEBUG, Message);
	DEFAULT_CHAT_FRAME:AddMessage(Message, 0.1, 0.1, 1);
    end
end


function Dcr_debug_bis( Message)
    if (Dcr_Print_DEBUG_bis) then
	table.insert(DCR_REMOTE_DEBUG, Message);
	DEFAULT_CHAT_FRAME:AddMessage(Message, 0.1, 0.1, 1);
    end
end

function Dcr_println( Message)

    if (Dcr_Saved.Print_ChatFrame) then
	DEFAULT_CHAT_FRAME:AddMessage(Message, 1, 1, 1);
    end
    if (Dcr_Saved.Print_CustomFrame) then
	DecursiveTextFrame:AddMessage(Message, 1, 1, 1, 0.9, DCR_TEXT_LIFETIME);
    end
end

function Dcr_errln( Message)
    if (Dcr_Saved.Print_Error) then
	if (Dcr_Saved.Print_ChatFrame) then
	    DEFAULT_CHAT_FRAME:AddMessage(Message, 1, 0.1, 0.1);
	end
	if (Dcr_Saved.Print_CustomFrame) then
	    DecursiveTextFrame:AddMessage(Message, 1, 0.1, 0.1, 0.9, DCR_TEXT_LIFETIME);
	end
    end
end
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- local variables
-------------------------------------------------------------------------------
local Dcr_CuringAction_Icons = { };

-- the new spellbook (made it simpler due to localization problems)
local DCR_HAS_SPELLS = false;
local DCR_SPELL_MAGIC_1 = {0,"", ""};
local DCR_SPELL_MAGIC_2 = {0,"", ""};
local DCR_CAN_CURE_MAGIC = false;
local DCR_SPELL_ENEMY_MAGIC_1 = {0,"", ""};
local DCR_SPELL_ENEMY_MAGIC_2 ={0,"", ""};
local DCR_CAN_CURE_ENEMY_MAGIC = false;
local DCR_SPELL_DISEASE_1 = {0,"", ""};
local DCR_SPELL_DISEASE_2 = {0,"", ""};
local DCR_CAN_CURE_DISEASE = false;
local DCR_SPELL_POISON_1 = {0,"", ""};
local DCR_SPELL_POISON_2 = {0,"", ""};
local DCR_CAN_CURE_POISON = false;
local DCR_SPELL_CURSE = {0,"", ""};
local DCR_CAN_CURE_CURSE = false;
local DCR_SPELL_COOLDOWN_CHECK = {0,"", ""};

-- for the blacklist
local Dcr_Casting_Spell_On = nil;
local Dcr_Blacklist_Array = { };

-------------------------------------------------------------------------------
-- init functions and configuration functions
-------------------------------------------------------------------------------
function Dcr_Init()
    Dcr_println(DCR_VERSION_STRING);

    Dcr_debug_bis( "Decursive Initialization started !");

    Dcr_debug( "Registering the slash commands");
    SLASH_DECURSIVE1 = DCR_MACRO_COMMAND;
    SlashCmdList["DECURSIVE"] = function(msg)
	Dcr_Clean();
    end

    SLASH_DECURSIVEPRADD1 = DCR_MACRO_PRADD;
    SlashCmdList["DECURSIVEPRADD"] = function(msg)
	Dcr_AddTargetToPriorityList();
    end
    SLASH_DECURSIVEPRCLEAR1 = DCR_MACRO_PRCLEAR;
    SlashCmdList["DECURSIVEPRCLEAR"] = function(msg)
	Dcr_ClearPriorityList();
    end
    SLASH_DECURSIVEPRLIST1 = DCR_MACRO_PRLIST;
    SlashCmdList["DECURSIVEPRLIST"] = function(msg)
	Dcr_PrintPriorityList();
    end
    SLASH_DECURSIVEPRSHOW1 = DCR_MACRO_PRSHOW;
    SlashCmdList["DECURSIVEPRSHOW"] = function(msg)
	Dcr_ShowHidePriorityListUI();
    end

    SLASH_DECURSIVESKADD1 = DCR_MACRO_SKADD;
    SlashCmdList["DECURSIVESKADD"] = function(msg)
	Dcr_AddTargetToSkipList();
    end
    SLASH_DECURSIVESKCLEAR1 = DCR_MACRO_SKCLEAR;
    SlashCmdList["DECURSIVESKCLEAR"] = function(msg)
	Dcr_ClearSkipList();
    end
    SLASH_DECURSIVESKLIST1 = DCR_MACRO_SKLIST;
    SlashCmdList["DECURSIVESKLIST"] = function(msg)
	Dcr_PrintSkipList();
    end
    SLASH_DECURSIVESKSHOW1 = DCR_MACRO_SKSHOW;
    SlashCmdList["DECURSIVESKSHOW"] = function(msg)
	Dcr_ShowHideSkipListUI();
    end

    SLASH_DECURSIVESHOW1 = DCR_MACRO_SHOW;
    SlashCmdList["DECURSIVESHOW"] = function(msg)
	Dcr_ShowHideAfflictedListUI();
    end

    SLASH_DECURSIVERESET1 = DCR_MACRO_RESET;
    SlashCmdList["DECURSIVERESET"] = function(msg)
	Dcr_ResetWindow();
    end

    if (Dcr_Saved.Show_LiveList) then
	DecursiveAfflictedListFrame:Show();
    else
	DecursiveAfflictedListFrame:Hide();
    end

    if (Dcr_Saved.HideButtons == nil) then
	Dcr_Saved.HideButtons = false;
    end

    Dcr_ShowHideButtons(true);

    -- check the spellbook once
    Dcr_Configure();
    DEFAULT_CHAT_FRAME:AddMessage(DCR_IS_HERE_MSG, 0.3, 0.5, 1);
    DEFAULT_CHAT_FRAME:AddMessage(DCR_SHOW_MSG, 0.3, 0.5, 1);
end

-- this resets the location of the windows
function Dcr_ResetWindow()
    DecursiveAfflictedListFrame:ClearAllPoints();
    DecursiveAfflictedListFrame:SetPoint("CENTER", "UIParent");

    DecursivePriorityListFrame:ClearAllPoints();
    DecursivePriorityListFrame:SetPoint("CENTER", "UIParent");

    DecursiveSkipListFrame:ClearAllPoints();
    DecursiveSkipListFrame:SetPoint("CENTER", "UIParent");

    DecursivePopulateListFrame:ClearAllPoints();
    DecursivePopulateListFrame:SetPoint("CENTER", "UIParent");

    DcrOptionsFrame:ClearAllPoints();
    DcrOptionsFrame:SetPoint("CENTER", "UIParent");
end

-- this gets an array of units for us to check
function Dcr_GetUnitArray()
    -- TODO: OPTIMIZE this function... a lot of things are done several times.
    local Dcr_Unit_Array = { };
    -- create the array of curable units

    -- first... the priority list... names that go first!
    local pname;
    for _, pname in Dcr_Saved.PriorityList do
	local unit = Dcr_NameToUnit( pname);
	if (unit) then
	    table.insert(Dcr_Unit_Array,unit);
	end
    end

    -- then everything else
    local i;
    local raidnum = GetNumRaidMembers();
    local temp_table = { };

    -- add your self (you are never skipped) except if you are already in the prio list...
    if (not Dcr_IsInSkipOrPriorList(UnitName("player"))) then
	table.insert(Dcr_Unit_Array, "player");
    end

    -- add the party members... if they exist
    for i = 1, 4 do
	if (UnitExists("party"..i)) then
	    pname = UnitName("party"..i);
	    -- check the name to see if we skip
	    if (not Dcr_IsInSkipOrPriorList(pname)) then
		-- we don't skip them
		if (Dcr_Saved.Random_Order) then
		    table.insert(temp_table,"party"..i);
		else
		    table.insert(Dcr_Unit_Array,"party"..i);
		end
	    end
	end
    end
    if (Dcr_Saved.Random_Order) then
	local temp_max = table.getn(temp_table);
	for i = 1, temp_max do
	    table.insert(Dcr_Unit_Array,table.remove(temp_table,random(1, table.getn(temp_table))));
	end
    end

    -- add the raid IDs that are valid...
    -- add it from the sub group after yours... and then loop
    -- around to the group right before yours
    if ( raidnum > 0 ) then
	local currentGroup = 0;
	local name = UnitName( "player");

	for i = 1, raidnum do
	    local rName, _, rGroup = GetRaidRosterInfo(i);
	    if (rName == name) then
		currentGroup = rGroup;
		break;
	    end
	end

	-- first the groups that are after yours
	for i = 1, raidnum do
	    local pname, _, rGroup = GetRaidRosterInfo(i);
	    -- get the group and name
	    if (rGroup > currentGroup) then
		-- group is after ours
		if (not Dcr_IsInSkipOrPriorList(pname)) then
		    -- and we are not skipping this name
		    if (Dcr_Saved.Random_Order) then
			table.insert(temp_table,"raid"..i);
		    else
			table.insert(Dcr_Unit_Array,"raid"..i);
		    end
		end
	    end
	end
	-- the the ones that are before yours
	for i = 1, raidnum do
	    local pname, _, rGroup = GetRaidRosterInfo(i);
	    -- get the group and name
	    if (rGroup < currentGroup) then
		-- its before our group
		if (not Dcr_IsInSkipOrPriorList(pname)) then
		    -- and we are not skipping this name
		    if (Dcr_Saved.Random_Order) then
			table.insert(temp_table,"raid"..i);
		    else
			table.insert(Dcr_Unit_Array,"raid"..i);
		    end
		end
	    end
	end
	-- don't bother with your own group... since its also party 1-4

	if (Dcr_Saved.Random_Order) then
	    local temp_max = table.getn(temp_table);
	    for i = 1, temp_max do
		table.insert(Dcr_Unit_Array,table.remove(temp_table,random(1, table.getn(temp_table))));
	    end
	end
    end

    if (not Dcr_Saved.Scan_Pets) then
	-- we are not doing pets... leave here
	return Dcr_Unit_Array;
    end
    -- now the pets

    -- your own pet
    if (UnitExists("pet")) then
	table.insert(Dcr_Unit_Array,"pet");
    end

    -- the parties pets if they have them
    for i = 1, 4 do
	if (UnitExists("partypet"..i)) then
	    pname = UnitName("partypet"..i);
	    -- get the pet name
	    if (not Dcr_IsInSkipOrPriorList(pname)) then
		-- to see if we skip it
		if (Dcr_Saved.Random_Order) then
		    table.insert(temp_table,"partypet"..i);
		else
		    table.insert(Dcr_Unit_Array,"partypet"..i);
		end
	    end
	end
    end
    if (Dcr_Saved.Random_Order) then
	local temp_max = table.getn(temp_table);
	for i = 1, temp_max do
	    table.insert(Dcr_Unit_Array,table.remove(temp_table,random(1, table.getn(temp_table))));
	end
    end

    -- and then the raid pets if they are out
    -- don't worry about the fancier logic with the pets
    if ( raidnum > 0 ) then
	for i = 1, raidnum do
	    if (UnitExists("raidpet"..i)) then
		pname = UnitName("raidpet"..i);
		-- get pet name
		if (not Dcr_IsInSkipOrPriorList(pname)) then
		    -- to see if we skip it
		    if (Dcr_Saved.Random_Order) then
			table.insert(temp_table,"raidpet"..i);
		    else
			table.insert(Dcr_Unit_Array,"raidpet"..i);
		    end
		end
	    end
	end
	if (Dcr_Saved.Random_Order) then
	    local temp_max = table.getn(temp_table);
	    for i = 1, temp_max do
		table.insert(Dcr_Unit_Array,table.remove(temp_table,random(1, table.getn(temp_table))));
	    end
	end
    end

    return Dcr_Unit_Array;
end

-- Raid/Party Name Check Function
-- this returns the UnitID that the Name points to
-- this does not check "target" or "mouseover"
function Dcr_NameToUnit( Name)
    if (not Name) then
	return false;
    elseif (Name == UnitName("player")) then
	return "player";
    elseif (Name == UnitName("pet")) then
	return "pet";
    elseif (Name == UnitName("party1")) then
	return "party1";
    elseif (Name == UnitName("party2")) then
	return "party2";
    elseif (Name == UnitName("party3")) then
	return "party3";
    elseif (Name == UnitName("party4")) then
	return "party4";
    elseif (Name == UnitName("partypet1")) then
	return "partypet1";
    elseif (Name == UnitName("partypet2")) then
	return "partypet2";
    elseif (Name == UnitName("partypet3")) then
	return "partypet3";
    elseif (Name == UnitName("partypet4")) then
	return "partypet4";
    else
	local numRaidMembers = GetNumRaidMembers();
	if (numRaidMembers > 0) then
	    -- we are in a raid
	    local i;
	    for i=1, numRaidMembers do
		local RaidName = GetRaidRosterInfo(i);
		if ( Name == RaidName) then
		    return "raid"..i;
		end
		if ( Name == UnitName("raidpet"..i)) then
		    return "raidpet"..i;
		end
	    end
	end
    end
    return false;
end

function Dcr_CheckSpellName (id, booktype, spellname)

    if id ~= 0  then
	Dcr_debug_bis("testing spell for name changes: id="..id);
	local found_spellname, spellrank = GetSpellName(id, booktype);

	if spellname ~= found_spellname then
	    return false;
	end
    end

    return true;
end

function Dcr_ReConfigure()

    if not DCR_HAS_SPELLS then
	return;
    end

    Dcr_debug_bis("Dcr_ReConfigure was called!");

    local DoNotReconfigure = true;

    DoNotReconfigure = Dcr_CheckSpellName(DCR_SPELL_MAGIC_1[1], DCR_SPELL_MAGIC_1[2], DCR_SPELL_MAGIC_1[3]);
    DoNotReconfigure = Dcr_CheckSpellName(DCR_SPELL_MAGIC_2[1], DCR_SPELL_MAGIC_2[2], DCR_SPELL_MAGIC_2[3]);

    DoNotReconfigure = Dcr_CheckSpellName(DCR_SPELL_ENEMY_MAGIC_1[1], DCR_SPELL_ENEMY_MAGIC_1[2], DCR_SPELL_ENEMY_MAGIC_1[3]);
    DoNotReconfigure = Dcr_CheckSpellName(DCR_SPELL_ENEMY_MAGIC_2[1], DCR_SPELL_ENEMY_MAGIC_2[2], DCR_SPELL_ENEMY_MAGIC_2[3]);

    DoNotReconfigure = Dcr_CheckSpellName(DCR_SPELL_DISEASE_1[1], DCR_SPELL_DISEASE_1[2], DCR_SPELL_DISEASE_1[3]);
    DoNotReconfigure = Dcr_CheckSpellName(DCR_SPELL_DISEASE_2[1], DCR_SPELL_DISEASE_2[2], DCR_SPELL_DISEASE_2[3]);

    DoNotReconfigure = Dcr_CheckSpellName(DCR_SPELL_POISON_1[1], DCR_SPELL_POISON_1[2], DCR_SPELL_POISON_1[3]);
    DoNotReconfigure = Dcr_CheckSpellName(DCR_SPELL_POISON_2[1], DCR_SPELL_POISON_2[2], DCR_SPELL_POISON_2[3]);
    
    DoNotReconfigure = Dcr_CheckSpellName(DCR_SPELL_CURSE[1], DCR_SPELL_CURSE[2], DCR_SPELL_CURSE[3]);

    if DoNotReconfigure == false then
	Dcr_debug_bis("Dcr_ReConfigure RECONFIGURATION!");
	Dcr_Configure();
	return;
    end
    Dcr_debug_bis("Dcr_ReConfigure No reconfiguration required!");

end

Dcr_PlayerClass = "";
function Dcr_Configure()

    -- first empty out the old "spellbook"
    DCR_HAS_SPELLS = false;
    DCR_SPELL_MAGIC_1 = {0,"", ""};
    DCR_SPELL_MAGIC_2 = {0,"", ""};
    DCR_CAN_CURE_MAGIC = false;
    DCR_SPELL_ENEMY_MAGIC_1 = {0,"", ""};
    DCR_SPELL_ENEMY_MAGIC_2 = {0,"", ""};
    DCR_CAN_CURE_ENEMY_MAGIC = false;
    DCR_SPELL_DISEASE_1 = {0,"", ""};
    DCR_SPELL_DISEASE_2 = {0,"", ""};
    DCR_CAN_CURE_DISEASE = false;
    DCR_SPELL_POISON_1 = {0,"", ""};
    DCR_SPELL_POISON_2 = {0,"", ""};
    DCR_CAN_CURE_POISON = false;
    DCR_SPELL_CURSE = {0,"", ""};
    DCR_CAN_CURE_CURSE = false;


    Dcr_debug_bis("Configuring Decursive...");
    -- parse through the entire library...
    -- look for known cleaning spells...
    -- this will be called everytime the spellbook changes

    -- this is just used to make things simpler in the checking
    local Dcr_Name_Array = {
	[DCR_SPELL_CURE_DISEASE] = true,
	[DCR_SPELL_ABOLISH_DISEASE] = true,
	[DCR_SPELL_PURIFY] = true,
	[DCR_SPELL_CLEANSE] = true,
	[DCR_SPELL_DISPELL_MAGIC] = true,
	[DCR_SPELL_CURE_POISON] = true,
	[DCR_SPELL_ABOLISH_POISON] = true,
	[DCR_SPELL_REMOVE_LESSER_CURSE] = true,
	[DCR_SPELL_REMOVE_CURSE] = true,
	[DCR_SPELL_PURGE] = true,
	[DCR_PET_FEL_CAST] = true,
	[DCR_PET_DOOM_CAST] = true,
    }

    local i = 1;

    local BookType = BOOKTYPE_SPELL;
    local break_flag = false
    while not break_flag  do

	while (true) do
	    local spellName, spellRank = GetSpellName(i, BookType);
	    if (not spellName) then
		if (BookType == BOOKTYPE_PET) then
		    break_flag = true;
		    break;
		end
		BookType = BOOKTYPE_PET;
		i = 1;
		break;

	    end

	    Dcr_debug( "Checking spell - "..spellName);

	    if (Dcr_Name_Array[spellName]) then
		Dcr_debug( "Its one we care about");
		DCR_HAS_SPELLS = true;

		-- any of them will work for the cooldown... we store the last
		DCR_SPELL_COOLDOWN_CHECK[1] = i; DCR_SPELL_COOLDOWN_CHECK[2] = BookType;

		-- put it in the range icon array
		local icon = GetSpellTexture(i, BookType)
		Dcr_CuringAction_Icons[icon] = spellName;

		-- print out the spell
		Dcr_debug( string.gsub(DCR_SPELL_FOUND, "$s", spellName));
		if (Dcr_Print_Spell_Found) then
		    Dcr_println( string.gsub(DCR_SPELL_FOUND, "$s", spellName));
		end

		-- big ass if statement... due to the way that the different localizations work
		-- I used to do this more elegantly... but the german WoW broke it

		if ((spellName == DCR_SPELL_CURE_DISEASE) or (spellName == DCR_SPELL_ABOLISH_DISEASE) or
		    (spellName == DCR_SPELL_PURIFY) or (spellName == DCR_SPELL_CLEANSE)) then
		    DCR_CAN_CURE_DISEASE = true;
		    if ((spellName == DCR_SPELL_CURE_DISEASE) or (spellName == DCR_SPELL_PURIFY)) then
			Dcr_debug( "Adding to disease 1");
			DCR_SPELL_DISEASE_1[1] = i; DCR_SPELL_DISEASE_1[2] = BookType; DCR_SPELL_DISEASE_1[3] = spellName;
		    else
			Dcr_debug( "Adding to disease 2");
			DCR_SPELL_DISEASE_2[1] = i; DCR_SPELL_DISEASE_2[2] = BookType; DCR_SPELL_DISEASE_2[3] = spellName;
		    end
		end

		if ((spellName == DCR_SPELL_CURE_POISON) or (spellName == DCR_SPELL_ABOLISH_POISON) or
		    (spellName == DCR_SPELL_PURIFY) or (spellName == DCR_SPELL_CLEANSE)) then
		    DCR_CAN_CURE_POISON = true;
		    if ((spellName == DCR_SPELL_CURE_POISON) or (spellName == DCR_SPELL_PURIFY)) then
			Dcr_debug( "Adding to poison 1");
			DCR_SPELL_POISON_1[1] = i; DCR_SPELL_POISON_1[2] = BookType; DCR_SPELL_POISON_1[3] = spellName;
		    else
			Dcr_debug( "Adding to poison 2");
			DCR_SPELL_POISON_2[1] = i; DCR_SPELL_POISON_2[2] = BookType; DCR_SPELL_POISON_2[3] = spellName;
		    end
		end

		if ((spellName == DCR_SPELL_REMOVE_CURSE) or (spellName == DCR_SPELL_REMOVE_LESSER_CURSE)) then
		    Dcr_debug( "Adding to curse");
		    DCR_CAN_CURE_CURSE = true;
		    DCR_SPELL_CURSE[1] = i; DCR_SPELL_CURSE[2] =  BookType; DCR_SPELL_CURSE[3] = spellName;
		end

		if ((spellName == DCR_SPELL_DISPELL_MAGIC) or (spellName == DCR_SPELL_CLEANSE) or (spellName == DCR_PET_FEL_CAST) or (spellName == DCR_PET_DOOM_CAST)) then
		    DCR_CAN_CURE_MAGIC = true;
		    if (spellName == DCR_SPELL_CLEANSE) then
			Dcr_debug( "Adding to magic 1");
			DCR_SPELL_MAGIC_1[1] = i; DCR_SPELL_MAGIC_1[2] = BookType; DCR_SPELL_MAGIC_1[3] = spellName;
		    else
			if (spellRank == DCR_SPELL_RANK_1) then
			    Dcr_debug( "Adding to magic 1");
			    Dcr_debug_bis( "Adding to magic 1");
			    DCR_SPELL_MAGIC_1[1] = i; DCR_SPELL_MAGIC_1[2] = BookType; DCR_SPELL_MAGIC_1[3] = spellName;
			else
			    Dcr_debug( "adding to magic 2");
			    Dcr_debug_bis( "Adding to magic 2");
			    DCR_SPELL_MAGIC_2[1] = i; DCR_SPELL_MAGIC_2[2] = BookType; DCR_SPELL_MAGIC_2[3] = spellName;
			end
		    end
		end

		if ((spellName == DCR_SPELL_DISPELL_MAGIC) or (spellName == DCR_SPELL_PURGE) or (spellName == DCR_PET_FEL_CAST) or (spellName == DCR_PET_DOOM_CAST)) then
		    DCR_CAN_CURE_ENEMY_MAGIC = true;
		    if (spellRank == DCR_SPELL_RANK_1) then
			Dcr_debug( "Adding to enemy magic 1");
			Dcr_debug_bis( "Adding to enemy magic 1");
			DCR_SPELL_ENEMY_MAGIC_1[1] = i; DCR_SPELL_ENEMY_MAGIC_1[2] = BookType; DCR_SPELL_ENEMY_MAGIC_1[3] = spellName;
		    else
			Dcr_debug( "Adding to enemy magic 2");
			Dcr_debug_bis( "Adding to enemy magic 2");
			DCR_SPELL_ENEMY_MAGIC_2[1] = i; DCR_SPELL_ENEMY_MAGIC_2[2] = BookType; DCR_SPELL_ENEMY_MAGIC_2[3] = spellName;
		    end
		end

	    end

	    i = i + 1
	end
    end
   
    local _, PlayerClass = UnitClass("player");

    Dcr_PlayerClass = PlayerClass;
    --[[
    if (DCR_HAS_SPELLS and Dcr_PlayerClass ~= DCR_CLASS_WARLOCK and Dcr_FindCureingActionSlot(Dcr_CuringAction_Icons)==0) then

	    message(DCR_STR_NEED_CURE_ACTION_IN_BARS);
    end
    --]]

end
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- the priority and skip list function... stuff to manage the lists
-------------------------------------------------------------------------------
function Dcr_ShowHideAfflictedListUI()
    if (DecursiveAfflictedListFrame:IsVisible()) then
	Dcr_Saved.Show_LiveList = false;
	DecursiveAfflictedListFrame:Hide();
    else
	Dcr_Saved.Show_LiveList = true;
	DecursiveAfflictedListFrame:Show();
    end
end

-- priority list stuff
function Dcr_ShowHidePriorityListUI()
    if (DecursivePriorityListFrame:IsVisible()) then
	DecursivePriorityListFrame:Hide();
    else
	DecursivePriorityListFrame:Show();
    end
end

function Dcr_ThisSetText(text)
    getglobal(this:GetName().."Text"):SetText(text);
end

function Dcr_AddTargetToPriorityList()
    Dcr_debug( "Adding the target to the priority list");
    DcrAddUnitToPriorityList("target");
end

function DcrAddUnitToPriorityList( unit)
    if (UnitExists(unit)) then
	if (UnitIsPlayer(unit)) then
	    local name = UnitName( unit);
	    for _, pname in Dcr_Saved.PriorityList do
		if (name == pname) then
		    return;
		end
	    end
	    table.insert(Dcr_Saved.PriorityList,name);
	end
	DecursivePriorityListFrame.UpdateYourself = true;
    end
end

function Dcr_RemoveIDFromPriorityList(id)
    table.remove( Dcr_Saved.PriorityList,id);
    DecursivePriorityListFrame.UpdateYourself = true;
end

function Dcr_ClearPriorityList()
    local i;
    local max = table.getn(Dcr_Saved.PriorityList);
    for i = 1, max do
	table.remove( Dcr_Saved.PriorityList);
    end
    DecursivePriorityListFrame.UpdateYourself = true;
end

function Dcr_PrintPriorityList()
    for id, name in Dcr_Saved.PriorityList do
	Dcr_println( id.." - "..name);
    end
end

-- skip list stuff
function Dcr_ShowHideSkipListUI()
    if (DecursiveSkipListFrame:IsVisible()) then
	DecursiveSkipListFrame:Hide();
    else
	DecursiveSkipListFrame:Show();
    end
end

function Dcr_ShowHideOptionsUI()
    if (DcrOptionsFrame:IsVisible()) then
	DcrOptionsFrame:Hide();
    else
	DcrOptionsFrame:Show();
    end
end

function Dcr_ShowHideTextAnchor()
    if (DecursiveAnchor:IsVisible()) then
	DecursiveAnchor:Hide();
    else
	DecursiveAnchor:Show();
    end
end

function Dcr_ShowHideButtons(UseCurrentValue)

    local DecrFrame = "DecursiveAfflictedListFrame";
    local buttons = {
	DecrFrame .. "Priority",
	DecrFrame .. "Skip",
	DecrFrame .. "Options",
	DecrFrame .. "Hide",
    }

    DCRframeObject = getglobal(DecrFrame);

    if (not UseCurrentValue) then
	Dcr_Saved.HideButtons = (not Dcr_Saved.HideButtons);
    end

    for _, ButtonName in buttons do
	Button = getglobal(ButtonName);

	if (Dcr_Saved.HideButtons) then
	    Button:Hide();
	    DCRframeObject.isLocked = 1;
	else
	    Button:Show();
	    DCRframeObject.isLocked = 0;
	end

    end



end

function Dcr_AddTargetToSkipList()
    Dcr_debug( "Adding the target to the Skip list");
    DcrAddUnitToSkipList("target");
end

function DcrAddUnitToSkipList( unit)
    if (UnitExists(unit)) then
	if (UnitIsPlayer(unit)) then
	    local name = UnitName( unit);
	    for _, pname in Dcr_Saved.SkipList do
		if (name == pname) then
		    return;
		end
	    end
	    table.insert(Dcr_Saved.SkipList,name);
	    DecursiveSkipListFrame.UpdateYourself = true;
	end
    end
end

function Dcr_RemoveIDFromSkipList(id)
    table.remove( Dcr_Saved.SkipList,id);
    DecursiveSkipListFrame.UpdateYourself = true;
end

function Dcr_ClearSkipList()
    local i;
    local max = table.getn(Dcr_Saved.SkipList);
    for i = 1, max do
	table.remove( Dcr_Saved.SkipList);
    end
    DecursiveSkipListFrame.UpdateYourself = true;
end

function Dcr_PrintSkipList()
    for id, name in Dcr_Saved.SkipList do
	Dcr_println( id.." - "..name);
    end
end

function Dcr_IsInPriorList (name)
    for _, PriorName in Dcr_Saved.PriorityList do
	if (PriorName == name) then
	    return true;
	end
    end
    return false;
end

function Dcr_IsInSkipList (name)
    for _, SkipName in Dcr_Saved.SkipList do
	if (SkipName == name) then
	    return true;
	end
    end
    return false
end

function Dcr_IsInSkipOrPriorList( name )
    if (Dcr_IsInSkipList(name)) then
	return true;
    end

    if (Dcr_IsInPriorList(name)) then
	return true;
    end
    return false;

    --[[
    -- Dcr_debug_bis("Dcr_IsInSkipOrPriorList called with: " .. name);
    if (name) then
	for _, SkipName in Dcr_Saved.SkipList do
	    if (SkipName == name) then
		return true;
	    end
	end
	for _, PriorName in Dcr_Saved.PriorityList do
	    if (PriorName == name) then
		return true;
	    end
	end
    end
    return false;
    --]]
end
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- the combat saver functions and events. These keep us in combat mode
-------------------------------------------------------------------------------
local Dcr_CombatMode = false;
function Dcr_EnterCombat()
    Dcr_debug("Entering combat");
    Dcr_CombatMode = true;
end

function Dcr_LeaveCombat()
    Dcr_debug("Leaving combat");
    Dcr_CombatMode = false;
end


local Dcr_CheckPet_Delay	= 2;
local Dcr_DelayedReconf_delay	= 1;

local Dcr_DelayedReconf_timer	= 0;
local Dcr_CheckPet_Timer	= 0;
local Dcr_Delay_Timer		= 0;

local last_DemonType = nil;
local curr_DemonType = nil;

-- This function update Decursive states :
--   - Reconf if needed
--   - check for a pet
--   - clear the black list
function Dcr_OnUpdate(arg1)


    --checkinfgfor reconf need
    if Dcr_DelayedReconf then
	Dcr_DelayedReconf_timer = Dcr_DelayedReconf_timer + arg1;
	if (Dcr_DelayedReconf_timer >= Dcr_DelayedReconf_delay) then
	    Dcr_DelayedReconf_timer = 0;

	    Dcr_ReConfigure();
	    Dcr_DelayedReconf = false;
	    return;
	end
    end

    -- checking for pet
    if (Dcr_CheckingPET) then
	Dcr_CheckPet_Timer = Dcr_CheckPet_Timer + arg1;

	if (Dcr_CheckPet_Timer >= Dcr_CheckPet_Delay) then
	    Dcr_CheckPet_Timer = 0;

	    curr_DemonType = UnitCreatureFamily("pet");

	    if (curr_DemonType) then Dcr_debug_bis ("Pet Type: " .. curr_DemonType);  end;

	    if (last_DemonType ~= curr_DemonType) then
		if (curr_DemonType) then Dcr_debug_bis ("Pet name changed: " .. curr_DemonType); else  Dcr_debug_bis ("No more pet!"); end;

		last_DemonType = curr_DemonType;
		Dcr_Configure();
	    end

	    Dcr_CheckingPET = false;
	    return;
	end

    end

    -- clean up the blacklist
    for unit in Dcr_Blacklist_Array do
	Dcr_Blacklist_Array[unit] = Dcr_Blacklist_Array[unit] - arg1;
	if (Dcr_Blacklist_Array[unit] < 0) then
	    Dcr_Blacklist_Array[unit] = nil;
	end
    end

    -- wow the next command SPAMS alot
    -- Dcr_debug("got update "..arg1);

    -- this is the fix for the AttackTarget() bug
    if (Dcr_Delay_Timer > 0) then
	Dcr_Delay_Timer = Dcr_Delay_Timer - arg1;
	if (Dcr_Delay_Timer <= 0) then
	    if (not Dcr_CombatMode) then
		Dcr_debug("trying to reset the combat mode");
		AttackTarget();
	    else
		Dcr_debug("already in combat mode");
	    end
	end;
    end
end

-------------------------------------------------------------------------------
-- Scanning functionalty... this scans the parties and groups
-------------------------------------------------------------------------------
local Dcr_AlreadyCleanning = false;
local Dcr_RestoreTarget = true;
function Dcr_Clean(UseThisTarget, SwitchToTarget)
    -----------------------------------------------------------------------
    -- first we do the setup, make sure we can cast the spells
    -----------------------------------------------------------------------

    if (not DCR_HAS_SPELLS) then
	-- check the spellbook again... (mod by Archarodim)
	Dcr_errln(DCR_NO_SPELLS);
	Dcr_Configure();
	if (not DCR_HAS_SPELLS) then
	    Dcr_errln(DCR_NO_SPELLS);
	    return false;
	end
    end

    Dcr_RestoreTarget = true;
    if (UseThisTarget and SwitchToTarget) then
	TargetUnit(UseThisTarget);
	Dcr_RestoreTarget = false;
    end

    if (Dcr_AlreadyCleanning) then
	Dcr_debug_bis("I'm already cleaning!!!!"); -- seems to be useless
	return false;
    end

    Dcr_AlreadyCleanning = true;

    --[[
    local isUsable, notEnoughMana = Dcr_IsSpellUsable();

    if (not isUsable) then
	if (notEnoughMana) then
	    Dcr_errln(DCR_STR_NOMANA);
	    Dcr_AlreadyCleanning = false;
	    return false;
	elseif (Dcr_PlayerClass ~= DCR_CLASS_PRIEST) then
	    Dcr_errln(DCR_STR_UNUSABLE);
	    Dcr_AlreadyCleanning = false;
	    return false;
	end
    end
    --]]


    local _, cooldown = GetSpellCooldown(DCR_SPELL_COOLDOWN_CHECK[1], DCR_SPELL_COOLDOWN_CHECK[2])
    if (cooldown ~= 0) then
	-- this used to be an errline... changed it to debugg
	Dcr_debug_bis(DCR_NO_SPELLS_RDY);
	Dcr_AlreadyCleanning = false;
	return false;
    end


    -- reset blaclisted people in this clean session
    DCR_ThisCleanBlaclisted = { };
    -- reset the number of out of ranged units for this clean session
    DCR_ThisNumberOoRUnits  = 0;


    -----------------------------------------------------------------------
    -----------------------------------------------------------------------
    -- then we see what our target looks like, if freindly, check them
    -----------------------------------------------------------------------

    local targetEnemy = false;
    local targetName = nil; -- if friendly
    local cleaned = false;
    local resetCombatMode = false;
    Dcr_Casting_Spell_On = nil;



    if (UnitExists("target")) then
	Dcr_debug("We have a target");
	-- if we are currently targeting something
	-- ###
	-- This block is here to know what the current target is, so we can clean it, restor it
	-- or clear the target at the end of this function
	-- ###

	if (Dcr_CombatMode) then
	    Dcr_debug("when done scanning... if switched target reset the mode!");
	    resetCombatMode = true;
	end

	if (
	    ( UnitIsFriend("target", "player") ) -- unit is a friend ie: not FriendLY just a friend that could be MC :/
	    and 
	    (not UnitIsCharmed("target")) -- and is not mind controlled
	    ) then
	    Dcr_debug(" It is friendly");

	    -- try cleaning the current target first
	    -- if we are not asked to clean a specific target
	    -- or if we already switched to the target to clean
	    if (not UseThisTarget or SwitchToTarget) then 
		cleaned = Dcr_CureUnit("target");
	    end

	    -- we are targeting a player that is not MC, save the name to switch back later
	    targetName = UnitName("target");

	else -- unit is aggressiv or is charmed
	    Dcr_debug(" It is not friendly");
	    -- we are targeting an enemy... switch back when done
	    targetEnemy = true;

	    if ( UnitIsCharmed("target")) then
		Dcr_debug( "Unit is enemey... and charmed... so its a mind controlled friendly");
		-- try cleaning mind controlled person first
		if (not UseThisTarget or SwitchToTarget) then 
		    cleaned = Dcr_CureUnit("target");
		end
	    end
	end
    end

    if (UseThisTarget and not SwitchToTarget and not cleaned) then
	Dcr_debug( "A target to clean was specifyed");
	if (UnitIsVisible(UseThisTarget)) then
	    -- if the unit is even close by


	    if (DCR_CAN_CURE_ENEMY_MAGIC and UnitIsCharmed(UseThisTarget)) then
		-- if the unit is mind controlled and we can cure it
		if (Dcr_CureUnit(UseThisTarget)) then
		    cleaned = true;
		end

	    else -- we can't cure magic on enemies or the unit is not charmed
		if (not Dcr_CheckUnitStealth(UseThisTarget)) then
		    -- we are either not ignoring the stealthed people,
		    -- or it's not stealthed
		    if (Dcr_CureUnit(UseThisTarget)) then
			cleaned = true;
		    end
		end
	    end
	end
    end

    if (not cleaned) then

	-----------------------------------------------------------------------
	-----------------------------------------------------------------------
	-- now we check the partys (raid and local)
	-----------------------------------------------------------------------
	Dcr_debug( "Checking the arrays");

	-- this is the cleaning loops...
	local Dcr_Unit_Array = Dcr_GetUnitArray();
	-- the order is player, party1-4, raid, pet, partypet1-4, raidpet1-40
	-- the raid is current party + 1 to 8... then 1 to current party - 1

	-- mind control first
	if( not cleaned) then
	    Dcr_debug(" looking for mind controll");
	    if (DCR_CAN_CURE_ENEMY_MAGIC) then
		for _, unit in Dcr_Unit_Array do
		    -- all of the units...
		    if (not Dcr_Blacklist_Array[unit]) then
			-- if the unit is not black listed
			if (UnitIsVisible(unit)) then
			    -- if the unit is even close by
			    if (UnitIsCharmed(unit)) then
				-- if the unit is mind controlled
				if (Dcr_CureUnit(unit)) then
				    cleaned = true;
				    break;
				end
			    end
			end
		    end
		end
	    end
	end

	-- normal cleaning
	if( not cleaned) then
	    -- Dcr_debug(" normal loop");
	    for _, unit in Dcr_Unit_Array do
		-- all of the units...
		if (not Dcr_Blacklist_Array[unit]) then
		    -- if the unit is not black listed
		    if (UnitIsVisible(unit)) then
			-- if the unit is even close by
			if (not UnitIsCharmed(unit)) then
			    -- we can't cure mind controlled people
			    if (not Dcr_CheckUnitStealth(unit)) then
				-- we are either not ignoring the stealthed people,
				-- or it's not stealthed
				if (Dcr_CureUnit(unit)) then
				    cleaned = true;
				    break;
				end
			    end
			end
		    end
		end
	    end
	end

	if ( not cleaned) then
	    Dcr_debug(" double check the black list");
	    for unit in Dcr_Blacklist_Array do
		-- now... all of the black listed units
		if (not DCR_ThisCleanBlaclisted[unit]) then
		    -- we do not re-check unit that have been blaclisted just before
		    if (UnitExists(unit)) then
			-- if the unit still exists
			if (UnitIsVisible(unit)) then
			    -- if the unit is even close by
			    if (not Dcr_CheckUnitStealth(unit)) then
				-- we are either not ignoring the stealthed people,
				-- or it's not stealthed
				if (Dcr_CureUnit(unit)) then
				    -- hey... we cleaned it... remove from the black list
				    Dcr_Blacklist_Array[unit] = nil;
				    cleaned = true;
				    break;
				end
			    end
			end
		    end
		end
	    end
	end
    end
    -----------------------------------------------------------------------
    -----------------------------------------------------------------------
    -- ok... done with the cleaning... lets try to clean this up
    -- basically switch targets back if they were changed
    -----------------------------------------------------------------------

    if (not SwitchToTarget) then -- if not explicitly ask to switch to the target
	if (targetEnemy) then
	    -- we had somethign "bad" targeted
	    if (not UnitIsEnemy("target", "player")) then
		-- and we tested for range, cast dispell magic, or some how broke target... switch back
		Dcr_debug("targeting enemy");
		-- TargetLastEnemy();
		TargetUnit("playertarget"); -- XXX to test
		if (resetCombatMode) then
		    -- resetCombatMode is the fix for "auto attack"
		    Dcr_Delay_Timer = Dcr_SpellCombatDelay;
		    Dcr_debug("done... now we wait for the leave combat event");
		end
	    end
	elseif (targetName) then
	    -- we had a friendly targeted... switch back if not still targeted
	    if ( targetName ~= UnitName("target") ) then
		TargetByName(targetName);
	    end
	else
	    -- we had nobody targeted originally
	    if (UnitExists("target")) then
		-- we checked for range
		ClearTarget();
	    end
	end
    end

    if (not cleaned) then
	Dcr_println( DCR_NOT_CLEANED);
    end

    Dcr_AlreadyCleanning = false;
    return cleaned;
end



-------------------------------------------------------------------------------
-- these are the spells used to clean a "unit" given
-------------------------------------------------------------------------------
function Dcr_CureUnit(Unit)
    Dcr_debug( "Scanning to cure unit - "..Unit);

    local Magic_Count	= 0;
    local Disease_Count = 0;
    local Poison_Count	= 0;
    local Curse_Count	= 0;

    local TClass, UClass = UnitClass(Unit);

    local i = 1;
    while (UnitDebuff(Unit, i)) do
	-- the "break" was not working all that well, so we stor a go on variable
	local Go_On = true;

	local debuff_name, debuff_type = Dcr_GetUnitDebuff(Unit, i);

	if (debuff_name == nil) then
	    -- this should only happen when things are "broke"
	    Dcr_errln("%$#@*& !!! Impossible to get debuff info from tooltip :'(, if this error continues to show up, type /console reloadui");
	    Dcr_debug( "Debuff name not found!");					
	    Go_On = false;
	elseif (debuff_name ~= "") then
	    Dcr_debug( debuff_name.." found!");

	    -- test if we have to ignore this debuff {{{ --
	    -- Ignore the ones that make the target immune... abort the user
	    if (DCR_IGNORELIST[debuff_name]) then
		Dcr_errln( string.gsub( string.gsub(DCR_IGNORE_STRING, "$t", UnitName(Unit)), "$a", debuff_name));
		return false;
	    end


	    -- Ignore debuffs that are in fact buffs
	    if (DCR_SKIP_LIST[debuff_name]) then
		Dcr_errln( string.gsub( string.gsub(DCR_IGNORE_STRING, "$t", UnitName(Unit)), "$a", debuff_name));
		Go_On = false; -- == continue
	    end

	    -- If we are in combat lets see if there is any debuffs we cn afford to not remove until ths fight is over
	    if (UnitAffectingCombat("player")) then
		if (DCR_SKIP_BY_CLASS_LIST[UClass]) then
		    if (DCR_SKIP_BY_CLASS_LIST[UClass][debuff_name]) then
			-- these are just ones you don't care about by class
			Dcr_errln( string.gsub( string.gsub(DCR_IGNORE_STRING, "$t", UnitName(Unit)), "$a", debuff_name));
			Go_On = false; -- == continue
		    end
		end
	    end
	    -- }}}

	    if (Go_On) then
		-- it is one we "care" about... lets catalog it -- {{{ --
		if (debuff_type and debuff_type ~= "") then
		    if (debuff_type == DCR_MAGIC) then
			Dcr_debug( "it's magic");
			Magic_Count = Magic_Count + 1;
		    elseif (debuff_type == DCR_DISEASE) then
			Dcr_debug( "it's disease");
			Disease_Count = Disease_Count + 1;
		    elseif (debuff_type == DCR_POISON) then
			Dcr_debug( "it's poison");
			Poison_Count = Poison_Count + 1;
		    elseif (debuff_type == DCR_CURSE) then
			Dcr_debug( "it's curse");
			Curse_Count = Curse_Count + 1
		    else
			Dcr_debug( "it's unknown - "..debuff_type);
		    end
		else
		    Dcr_debug( "it's untyped");
		end
		-- }}}
	    end
	end

	i = i + 1;
    end

    local res = false;
    -- order these in the way you find most important
    if (not res) then
	res = Dcr_Cure_Magic(Magic_Count, Unit);
    end
    if (not res) then
	res = Dcr_Cure_Curse( Curse_Count, Unit);
    end
    if (not res) then
	res = Dcr_Cure_Poison( Poison_Count, Unit);
    end
    if (not res) then
	res = Dcr_Cure_Disease( Disease_Count, Unit);
    end

    return res;
end

function Dcr_Cure_Magic(Magic_Count, Unit)
    Dcr_debug( "magic count "..Magic_Count);
    if (DCR_CAN_CURE_MAGIC) then
	Dcr_debug( "Can cure magic");
    end
    if (DCR_CAN_CURE_ENEMY_MAGIC) then
	Dcr_debug( "Can cure enemy magic");
    end

    if ( (not (DCR_CAN_CURE_MAGIC or DCR_CAN_CURE_ENEMY_MAGIC)) or (Magic_Count == 0) ) then
	-- here is no magical effects... or
	-- we can't cure magic don't bother going forward
	Dcr_debug( "no magic");
	return false;
    end
    Dcr_debug( "curing magic");

    if ( DCR_CAN_CURE_ENEMY_MAGIC and UnitIsCharmed(Unit) and UnitCanAttack("player", Unit) ) then
	-- unit is charmed... and has magic debuffs on them... and we CAN attack it
	-- there is a good chance that it is the mind controll type spell
	-- the checking for the UnitCanAttack is due to the mind controlled pets and other enslaves
	if (DCR_SPELL_ENEMY_MAGIC_2[1] ~= 0 ) and (Dcr_Saved.AlwaysUseBestSpell or (Magic_Count > 1) or (DCR_SPELL_MAGIC_1[1] == 0)) then
	    return Dcr_Cast_CureSpell( DCR_SPELL_ENEMY_MAGIC_2, Unit, DCR_CHARMED, true);
	else
	    return Dcr_Cast_CureSpell( DCR_SPELL_ENEMY_MAGIC_1, Unit, DCR_CHARMED, true);
	end
    elseif (DCR_CAN_CURE_MAGIC and (not UnitCanAttack("player", Unit))) then
	-- we can cure magic... and the unit is NOT hostile to us (we can't cast on those)
	if (DCR_SPELL_MAGIC_2[1] ~= 0 ) and (Dcr_Saved.AlwaysUseBestSpell or (Magic_Count > 1) or (DCR_SPELL_MAGIC_1[1] == 0)) then
	    return Dcr_Cast_CureSpell( DCR_SPELL_MAGIC_2, Unit, DCR_MAGIC, DCR_CAN_CURE_ENEMY_MAGIC);
	else
	    return Dcr_Cast_CureSpell( DCR_SPELL_MAGIC_1, Unit, DCR_MAGIC, DCR_CAN_CURE_ENEMY_MAGIC);
	end
    -- else
	-- what it means:
	-- not (DCR_CAN_CURE_ENEMY_MAGIC and UnitIsCharmed(Unit) and UnitCanAttack("player", Unit)
	-- not (DCR_CAN_CURE_MAGIC and (not UnitCanAttack("player", Unit)))
	--
	-- !DCR_CAN_CURE_ENEMY_MAGIC or !UnitIsCharmed(Unit) or !UnitCanAttack("player", Unit)   =====> not MC or we can't attack it
	-- AND
	-- !DCR_CAN_CURE_MAGIC UnitCanAttack("player", Unit)
	--
	-- we can't cure enemy magic
	-- Dcr_errln("Something strange happened :/ Dcr_Cure_Magic() did nothing :-o");
    end
    return false;
end

function Dcr_Cure_Curse( Curse_Count, Unit)
    if ( (not DCR_CAN_CURE_CURSE) or (Curse_Count == 0)) then
	-- no curses or no curse curing spells
	Dcr_debug( "no curse");
	return false;
    end
    Dcr_debug( "curing curse");

    if (UnitIsCharmed(Unit)) then
	-- we can not cure a mind contorolled player
	return;
    end

    if (DCR_SPELL_CURSE ~= 0) then
	return Dcr_Cast_CureSpell(DCR_SPELL_CURSE, Unit, DCR_CURSE, false);
    end
    return false;
end

function Dcr_Cure_Poison(Poison_Count, Unit)
    if ( (not DCR_CAN_CURE_POISON) or (Poison_Count == 0)) then
	-- here is no magical effects... or
	-- we can't cure magic don't bother going forward
	Dcr_debug( "no poison");
	return false;
    end
    Dcr_debug( "curing poison");

    if (UnitIsCharmed(Unit)) then
	-- we can not cure a mind contorolled player
	return;
    end

    if (Dcr_Saved.Check_For_Abolish and Dcr_CheckUnitForBuff(Unit, DCR_SPELL_ABOLISH_POISON)) then
	return false;
    end

    if (DCR_SPELL_POISON_2[1] ~= 0 ) and (Dcr_Saved.AlwaysUseBestSpell or (Poison_Count > 1)) then
	return Dcr_Cast_CureSpell( DCR_SPELL_POISON_2, Unit, DCR_POISON, false);
    else
	return Dcr_Cast_CureSpell( DCR_SPELL_POISON_1, Unit, DCR_POISON, false);
    end
end

function Dcr_Cure_Disease(Disease_Count, Unit)
    if ( (not DCR_CAN_CURE_DISEASE) or (Disease_Count == 0)	) then
	-- here is no magical effects... or
	-- we can't cure magic don't bother going forward
	Dcr_debug( "no disease");
	return false;
    end
    Dcr_debug( "curing disease");

    if (UnitIsCharmed(Unit)) then
	-- we can not cure a mind contorolled player
	return;
    end

    if (Dcr_Saved.Check_For_Abolish and Dcr_CheckUnitForBuff(Unit, DCR_SPELL_ABOLISH_DISEASE)) then
	return false;
    end

    if (DCR_SPELL_DISEASE_2[1] ~= 0 ) and (Dcr_Saved.AlwaysUseBestSpell or (Disease_Count > 1)) then
	return Dcr_Cast_CureSpell( DCR_SPELL_DISEASE_2, Unit, DCR_DISEASE, false);
    else
	return Dcr_Cast_CureSpell( DCR_SPELL_DISEASE_1, Unit, DCR_DISEASE, false);
    end
end

function Dcr_Cast_CureSpell( spellID, Unit, AfflictionType, ClearCurrentTarget)
    local name = UnitName(Unit);


    if (spellID[1] == 0) then
	Dcr_errln("Stupid call to Dcr_Cast_CureSpell() with a null spellID!!!");
	return false;
    end

    -- check to see if we are in range
    if (
	    (spellID[2] ~= BOOKTYPE_PET) and
	    (not Dcr_UnitInRange(Unit))
	) then

	-- XXX We do not blacklist out of range people any more, they don't prevent anything from hapenning
	-- it will just spam a bit if there are a lot of them...

	-- Dcr_Blacklist_Array[Unit] = nil; -- attempt to remove it
	-- Dcr_Blacklist_Array[Unit] = Dcr_Saved.CureBlacklist; -- add it to the blacklist, hopefully at the end

	-- DCR_ThisCleanBlaclisted[Unit] = true;

	Dcr_errln( string.gsub( string.gsub(DCR_OUT_OF_RANGE, "$t", name), "$a", AfflictionType));
	-- DCR_ThisNumberOoRUnits = DCR_ThisNumberOoRUnits + 1;
	return false;
    else
	Dcr_debug_bis("Unit is in range or we don't check for range");
    end
    Dcr_debug_bis( "try to cast: "..spellID[1] .." - ".. spellID[2]);
    local spellName = GetSpellName(spellID[1], spellID[2]);
    Dcr_debug( "casting - "..spellName);

    -- clear the target if it will interfear
    if (ClearCurrentTarget) then
	-- it can target enemys... do don't target ANYTHING else
	if ( not UnitIsUnit( "target", Unit) ) then
	    ClearTarget();
	end
    elseif ( UnitIsFriend( "player", "target") ) then
	-- we can accedenally cure friendly targets...
	if ( not UnitIsUnit( "target", Unit) ) then
	    -- and we want to cure someone else who is not targeted
	    ClearTarget();
	end
    end

	    -- ClearTarget();
    Dcr_println( string.gsub( string.gsub( string.gsub(DCR_CLEAN_STRING, "$t", string.upper(name)), "$a", AfflictionType), "$s", spellName));
    Dcr_debug_bis( "casting on " .. UnitName(Unit) .. " -- " .. Unit);
    if (spellID[2] == BOOKTYPE_PET) then
	TargetUnit(Unit);
    end

    -- if a spell is awaiting for a target, cancel it
    if ( SpellIsTargeting()) then
	SpellStopTargeting();
    end

    -- cast the spell
    Dcr_Casting_Spell_On = Unit;
    CastSpell(spellID[1],  spellID[2]);

    -- if the spell doesn't need a target
    if (Dcr_RestoreTarget and spellID[2] == BOOKTYPE_PET) then
	TargetUnit("playertarget"); -- restore previous target 
    else
	-- if the cast succeeded
	if (SpellIsTargeting()) then
	    SpellTargetUnit(Unit);
	end
    end

    -- if the targeting failed (still waiting for a target), cancel the cast
    if ( SpellIsTargeting()) then
	SpellStopTargeting();
    end

    return true;
end


function Dcr_SpellCastFailed()
    if (
	Dcr_Casting_Spell_On	    -- a cast failed and we were casting on someone
	and not (
	    UnitIsUnit(Dcr_Casting_Spell_On, "player")   -- we do not blacklist ourself
	    or
	    (
		-- we do not blacklist people in the priority list
		Dcr_Saved.DoNot_Blacklist_Prio_List and Dcr_IsInPriorList ( UnitName(Dcr_Casting_Spell_On) )
	    )
		)
	) then

	Dcr_Blacklist_Array[Dcr_Casting_Spell_On] = nil;
	Dcr_Blacklist_Array[Dcr_Casting_Spell_On] = Dcr_Saved.CureBlacklist;
	DCR_ThisCleanBlaclisted[Dcr_Casting_Spell_On] = true;
    end
end

function Dcr_SpellWasCast()
    Dcr_Casting_Spell_On = nil;
end

function Dcr_GetUnitBuff (Unit, i)
    Dcr_ScanningTooltipTextLeft1:SetText("");

    Dcr_ScanningTooltip:SetUnitBuff(Unit, i); -- fill this fake thing with buff info

    local buff_name = Dcr_ScanningTooltipTextLeft1:GetText(); -- get the buff name
    -- local buff_type = Dcr_ScanningTooltipTextRight1:GetText();

    return buff_name;

end

function Dcr_GetUnitDebuff  (Unit, i)
    -- Dcr_ScanningTooltip:ClearLines(); -- clear the tooltip
    Dcr_ScanningTooltipTextRight1:SetText("");
    Dcr_ScanningTooltipTextLeft1:SetText("");

    Dcr_ScanningTooltip:SetUnitDebuff(Unit, i); -- fill this fake thing with Debuff info
    
    local debuff_name = Dcr_ScanningTooltipTextLeft1:GetText(); -- get the debuff name
    local debuff_type = Dcr_ScanningTooltipTextRight1:GetText(); -- get the debuff type

    return debuff_name, debuff_type;
end

function Dcr_CheckUnitForBuff(Unit, BuffName)
    for i = 1, DCR_MAXBUFFS do
	local buff_texture = UnitBuff(Unit, i);

	if buff_texture then

	    local found_buff_name = Dcr_GetUnitBuff(Unit, i);

	    if (found_buff_name == BuffName) then
		return true;
	    end


	else
	    break; -- XXX to verify
	end
    end
    return false;
end

function Dcr_CheckUnitStealth(Unit)
    if (Dcr_Saved.Ingore_Stealthed) then
	for BuffName in DCR_INVISIBLE_LIST do
	    if Dcr_CheckUnitForBuff(Unit, BuffName) then
		return true;
	    end
	end
    end
    return false;
end

function Dcr_IsSpellUsable ()
    local CuringActionSlot = Dcr_FindCureingActionSlot(Dcr_CuringAction_Icons);

    if (CuringActionSlot ~= 0) then
	return IsUsableAction(CuringActionSlot);
    else
	return true;
    end
end

-------------------------------------------------------------------------------
-- now the range functions....
-------------------------------------------------------------------------------
--[[
function Dcr_UnitInRange(Unit)
    -- this means that we are not even fraking close...
    -- don't bother going further
    if (not UnitIsVisible(Unit)) then
	return false;
    end

    -- Dcr_Saved.RangeCheck = false; -- disable this option for now
    if (not Dcr_Saved.RangeCheck) then
	-- we are not bothering to check for range.
	-- this will keep a pally from breaking swing most times
	return true;
    end

    local Dcr_Range_Slot = Dcr_FindCureingActionSlot(Dcr_CuringAction_Icons);

    if (Dcr_Range_Slot ~= 0) then
	TargetUnit(Unit);
	if UnitIsUnit("target", Unit) then
	    return (IsActionInRange(Dcr_Range_Slot) == 1);
	else
	    return false; -- if we can't target... then its out of range
	end
    end

    -- we don't know... return true just in case
    return true;

end
--]]


function Dcr_UnitInRange(Unit)
--    if (not Dcr_Saved.RangeCheck) then
--	return true;
--    end
    if(CheckInteractDistance(Unit, 4)) then
	return true;
    end
    return false;
end


local Dcr_LastFoundSlot = nil;
local Dcr_LastActionBarScan = 0;
function Dcr_FindCureingActionSlot(iconArray)

    if (Dcr_PlayerClass == DCR_CLASS_WARLOCK) then
	return 0;
    end

    if (Dcr_LastFoundSlot) then
	if (HasAction(Dcr_LastFoundSlot)) then
	    icon = GetActionTexture(Dcr_LastFoundSlot);
	    if (iconArray[icon]) then
		if (GetActionText(Dcr_LastFoundSlot) == nil) then
		    local spellName = iconArray[icon];

		    Dcr_ScanningTooltipTextLeft1:SetText("");

		    Dcr_ScanningTooltip:SetAction(Dcr_LastFoundSlot);

		    local slotName = Dcr_ScanningTooltipTextLeft1:GetText();

		    if (spellName == slotName) then
			Dcr_debug_bis("cache used!");
			return Dcr_LastFoundSlot;
		    end
		end
	    end
	end
    end

    -- This is to prevent a freeze issue
    if (GetTime() - Dcr_LastActionBarScan < 30) then
	return 0;
    end
    local i = 0;
    for i = DCR_START_SLOT, DCR_END_SLOT do
	if (HasAction(i)) then
	    icon = GetActionTexture(i);
	    if (iconArray[icon]) then
		if (GetActionText(i) == nil) then
		    local spellName = iconArray[icon];

		    Dcr_ScanningTooltipTextLeft1:SetText("");

		    Dcr_ScanningTooltip:SetAction(i);

		    local slotName = Dcr_ScanningTooltipTextLeft1:GetText();

		    if (spellName == slotName) then
			Dcr_LastFoundSlot = i;
			return i;
		    end
		else
		    Dcr_debug_bis("GetActionText: " .. GetActionText(i) );
		end
	    end
	end
    end
    Dcr_LastActionBarScan = GetTime();
    Dcr_errln("Decursive can't find your curing spell in your action bars, next try in 30 seconds...");
    return 0;
end

-------------------------------------------------------------------------------
-- the UI code
-------------------------------------------------------------------------------

function Dcr_PriorityListEntryTemplate_OnClick()
    local id = this:GetID();
    if (id) then
	if (this.Priority) then
	    Dcr_RemoveIDFromPriorityList(id);
	else
	    Dcr_RemoveIDFromSkipList(id);
	end
    end
    this.UpdateYourself = true;
    
end

function Dcr_PriorityListEntryTemplate_OnUpdate()
    if (this.UpdateYourself) then
	this.UpdateYourself = false;
	local baseName = this:GetName();
	local NameText = getglobal(baseName.."Name");

	local id = this:GetID();
	if (id) then
	    local name
	    if (this.Priority) then
		name = Dcr_Saved.PriorityList[id];
	    else
		name = Dcr_Saved.SkipList[id];
	    end
	    if (name) then
		NameText:SetText(id.." - "..name);
	    else
		NameText:SetText("Error - ID Invalid!");
	    end
	else
	    NameText:SetText("Error - No ID!");
	end
    end
end

function Dcr_PriorityListFrame_OnUpdate()
    if (this.UpdateYourself) then
	this.UpdateYourself = false;
	local baseName = this:GetName();
	local up = getglobal(baseName.."Up");
	local down = getglobal(baseName.."Down");


	local size = table.getn(Dcr_Saved.PriorityList);

	if (size < 11 ) then
	    this.Offset = 0;
	    up:Hide();
	    down:Hide();
	else
	    if (this.Offset <= 0) then
		this.Offset = 0;
		up:Hide();
		down:Show();
	    elseif (this.Offset >= (size - 10)) then
		this.Offset = (size - 10);
		up:Show();
		down:Hide();
	    else
		up:Show();
		down:Show();
	    end
	end

	local i;
	for i = 1, 10 do
	    local id = ""..i;
	    if (i < 10) then
		id = "0"..i;
	    end
	    local btn = getglobal(baseName.."Index"..id);

	    btn:SetID( i + this.Offset);
	    btn.UpdateYourself = true;

	    if (i <= size) then
		btn:Show();
	    else
		btn:Hide();
	    end
	end
end

end

function Dcr_SkipListFrame_OnUpdate()
    if (this.UpdateYourself) then
	this.UpdateYourself = false;
	local baseName = this:GetName();
	local up = getglobal(baseName.."Up");
	local down = getglobal(baseName.."Down");


	local size = table.getn(Dcr_Saved.SkipList);

	if (size < 11 ) then
	    this.Offset = 0;
	    up:Hide();
	    down:Hide();
	else
	    if (this.Offset <= 0) then
		this.Offset = 0;
		up:Hide();
		down:Show();
	    elseif (this.Offset >= (size - 10)) then
		this.Offset = (size - 10);
		up:Show();
		down:Hide();
	    else
		up:Show();
		down:Show();
	    end
	end

	local i;
	for i = 1, 10 do
	    local id = ""..i;
	    if (i < 10) then
		id = "0"..i;
	    end
	    local btn = getglobal(baseName.."Index"..id);

	    btn:SetID( i + this.Offset);
	    btn.UpdateYourself = true;

	    if (i <= size) then
		btn:Show();
	    else
		btn:Hide();
	    end
	end
    end

end

function Dcr_DisplayTooltip(Message, RelativeTo)
    DcrDisplay_Tooltip:SetOwner(RelativeTo, "ANCHOR_TOPRIGHT");
    DcrDisplay_Tooltip:ClearLines();
    DcrDisplay_Tooltip:SetText(Message);
    DcrDisplay_Tooltip:Show();
end

function Dcr_PopulateButtonPress()
    local addFunction = this:GetParent().addFunction;

    if (this.ClassType) then
	-- for the class type stuff... we do party

	local _, pclass = UnitClass("player");
	if (pclass == this.ClassType) then
	    addFunction("player");
	end

	_, pclass = UnitClass("party1");
	if (pclass == this.ClassType) then
	    addFunction("party1");
	end
	_, pclass = UnitClass("party2");
	if (pclass == this.ClassType) then
	    addFunction("party2");
	end
	_, pclass = UnitClass("party3");
	if (pclass == this.ClassType) then
	    addFunction("party3");
	end
	_, pclass = UnitClass("party4");
	if (pclass == this.ClassType) then
	    addFunction("party4");
	end
    end

    local max = GetNumRaidMembers();
    local i;
    if (max > 0) then
	for i = 1, max do
	    local _, _, pgroup, _, _, pclass = GetRaidRosterInfo(i);

	    if (this.ClassType) then
		if (pclass == this.ClassType) then
		    addFunction("raid"..i);
		end
	    end
	    if (this.GroupNumber) then
		if (pgroup == this.GroupNumber) then
		    addFunction("raid"..i);
		end
	    end
	end
    end

end

function Dcr_DebuffTemplate_OnEnter()
    DcrDisplay_Tooltip:SetOwner(this, "ANCHOR_CURSOR");
    DcrDisplay_Tooltip:ClearLines();
    DcrDisplay_Tooltip:SetUnitDebuff(this.unit,this.debuff); -- OK
    DcrDisplay_Tooltip:Show();
end

function Dcr_LiveListItem_OnUpdate()
    if (this.UpdateMe) then
	this.UpdateMe = false;
	local texture = UnitDebuff(this.unit,this.debuff);
	if (texture) then
	    local baseFrame = this:GetName();
	    getglobal(baseFrame.."DebuffIcon"):SetTexture(texture);

	    getglobal(baseFrame.."Name"):SetText(UnitName(this.unit));

	    local debuff_name, debuff_type = Dcr_GetUnitDebuff(this.unit, this.debuff);

	    getglobal(baseFrame.."Affliction"):SetText(debuff_name);
	end
    end
end

local Dcr_SoundPlayed = false;
function Dcr_PlaySound ()
    if (Dcr_Saved.PlaySound and not Dcr_SoundPlayed) then
	-- good sounds: Sound\\Doodad\\BellTollTribal.wav
	--		Sound\\interface\\AuctionWindowOpen.wav
	PlaySoundFile("Sound\\Doodad\\BellTollTribal.wav");
	Dcr_SoundPlayed = true;
    end
end

local Dcr_timeLeft = 0;
function Dcr_AfflictedListFrame_OnUpdate(elapsed)


    -- XXX find the use of this block
    if Dcr_Saved.Amount_Of_Afflicted < 1 then
	Dcr_Saved.Amount_Of_Afflicted = 1;
    elseif Dcr_Saved.Amount_Of_Afflicted > DCR_MAX_LIVE_SLOTS then
	Dcr_Saved.Amount_Of_Afflicted = DCR_MAX_LIVE_SLOTS;
    end

    Dcr_timeLeft = Dcr_timeLeft - elapsed;
    if (Dcr_timeLeft <= 0) then
	Dcr_timeLeft = Dcr_Saved.ScanTime;
	local index = 1;
	local Dcr_Unit_Array = Dcr_GetUnitArray();

	if (DCR_CAN_CURE_ENEMY_MAGIC) then
	    for _, unit in Dcr_Unit_Array do
		if (index > Dcr_Saved.Amount_Of_Afflicted) then
		    break;
		end
		if (UnitIsVisible(unit)) then
		    -- if the unit is even close by
		    if (UnitIsCharmed(unit)) then
			-- if the unit is mind controlled
			if (Dcr_ScanUnit(unit, index)) then
			    if (index == 1) then
				Dcr_PlaySound();
			    end
			    index = index + 1;
			end
		    end
		end
	    end
	end

	-- Dcr_debug(" normal loop");
	for _, unit in Dcr_Unit_Array do
	    if (index > Dcr_Saved.Amount_Of_Afflicted) then
		break;
	    end
	    if (UnitIsVisible(unit)) then
		if (not UnitIsCharmed(unit)) then
		    -- if the unit is even close by
		    if (Dcr_ScanUnit(unit, index)) then
			if (index == 1) then
			    Dcr_PlaySound();
			end
			index = index + 1;
		    end
		end
	    end
	end

	for i = index, DCR_MAX_LIVE_SLOTS do
	    if i == 1 then
		Dcr_SoundPlayed = false;
	    end
	    local item = getglobal("DecursiveAfflictedListFrameListItem"..i);
	    item.unit = "player";
	    item.debuff = 0;
	    item:Hide();
	end

	-- for testing only		
	-- Dcr_UpdateLiveDisplay( 1, "player", 1)

    end
end

function Dcr_ScanUnit( Unit, Index)
    local i = 1;
    while (UnitDebuff(Unit, i)) do

	local debuff_name, debuff_type = Dcr_GetUnitDebuff(Unit, i);

	if (debuff_name ~= "") then

	    -- test if we have to ignore this debuf  {{{ --
	    if (DCR_IGNORELIST[debuff_name]) then
		-- these are the BAD ones... the ones that make the target immune... abort the user
		Dcr_debug( string.gsub( string.gsub(DCR_IGNORE_STRING, "$t", UnitName(Unit)), "$a", debuff_name));
		return false;
	    end

	    if (DCR_SKIP_LIST[debuff_name]) then
		-- these are just ones you don't care about
		Dcr_debug( string.gsub( string.gsub(DCR_IGNORE_STRING, "$t", UnitName(Unit)), "$a", debuff_name));
		break;
	    end
	    if (UnitAffectingCombat("player")) then
		if (DCR_SKIP_BY_CLASS_LIST[UClass]) then
		    if (DCR_SKIP_BY_CLASS_LIST[UClass][debuff_name]) then
			-- these are just ones you don't care about by class
			Dcr_debug( string.gsub( string.gsub(DCR_IGNORE_STRING, "$t", UnitName(Unit)), "$a", debuff_name));
			break;
		    end
		end
	    end
	    -- }}}

	    if (debuff_type and debuff_type ~= "") then
		-- // {{{ --
		if (debuff_type == DCR_MAGIC) then
		    if (UnitIsCharmed(Unit)) then
			if (DCR_CAN_CURE_ENEMY_MAGIC) then
			    Dcr_UpdateLiveDisplay(Index, Unit, i);
			    return true;
			end
		    else
			if (DCR_CAN_CURE_MAGIC) then
			    Dcr_UpdateLiveDisplay(Index, Unit, i);
			    return true;
			end
		    end
		elseif (debuff_type == DCR_DISEASE) then
		    if (DCR_CAN_CURE_DISEASE) then
			Dcr_UpdateLiveDisplay(Index, Unit, i);
			return true;
		    end
		elseif (debuff_type == DCR_POISON) then
		    if (DCR_CAN_CURE_POISON) then
			Dcr_UpdateLiveDisplay(Index, Unit, i);
			return true;
		    end
		elseif (debuff_type == DCR_CURSE) then
		    if (DCR_CAN_CURE_CURSE) then
			Dcr_UpdateLiveDisplay(Index, Unit, i);
			return true;
		    end
		end
		-- // }}}
	    end

	end -- end of if (debuff_name ~= "")

	i = i + 1;
    end
    return false;
end

function Dcr_UpdateLiveDisplay( Index, Unit, DebuffIndex)
    local item = getglobal("DecursiveAfflictedListFrameListItem"..Index);
    item.unit = Unit;
    item.debuff = DebuffIndex;
    item.UpdateMe = true;
    item:Show();

    item = getglobal("DecursiveAfflictedListFrameListItem"..Index.."Debuff");
    item.unit = Unit;
    item.debuff = DebuffIndex;

    item = getglobal("DecursiveAfflictedListFrameListItem"..Index.."ClickMe");
    item.unit = Unit;
    item.debuff = DebuffIndex;
end

function Dcr_AmountOfAfflictedSlider_OnShow()
    getglobal(this:GetName().."High"):SetText("15");
    getglobal(this:GetName().."Low"):SetText("5");

    getglobal(this:GetName() .. "Text"):SetText(DCR_AMOUNT_AFFLIC .. Dcr_Saved.Amount_Of_Afflicted);

    this:SetMinMaxValues(1, 15);
    this:SetValueStep(1);
    this:SetValue(Dcr_Saved.Amount_Of_Afflicted);
end

function Dcr_AmountOfAfflictedSlider_OnValueChanged()
    Dcr_Saved.Amount_Of_Afflicted = this:GetValue();
    getglobal(this:GetName() .. "Text"):SetText(DCR_AMOUNT_AFFLIC .. Dcr_Saved.Amount_Of_Afflicted);
end

function Dcr_CureBlacklistSlider_OnShow()
    getglobal(this:GetName().."High"):SetText("20");
    getglobal(this:GetName().."Low"):SetText("1");

    getglobal(this:GetName() .. "Text"):SetText(DCR_BLACK_LENGTH .. Dcr_Saved.CureBlacklist);

    this:SetMinMaxValues(1, 20);
    this:SetValueStep(0.1);
    this:SetValue(Dcr_Saved.CureBlacklist);
end

function Dcr_CureBlacklistSlider_OnValueChanged()
    Dcr_Saved.CureBlacklist = this:GetValue() * 10;
    if (Dcr_Saved.CureBlacklist < 0) then
	Dcr_Saved.CureBlacklist = ceil(Dcr_Saved.CureBlacklist - 0.5)
    else
	Dcr_Saved.CureBlacklist = floor(Dcr_Saved.CureBlacklist + 0.5)
    end
    Dcr_Saved.CureBlacklist = Dcr_Saved.CureBlacklist / 10;
    getglobal(this:GetName() .. "Text"):SetText(DCR_BLACK_LENGTH .. Dcr_Saved.CureBlacklist);
end

function Dcr_ScanTimeSlider_OnShow()
    getglobal(this:GetName().."High"):SetText("1");
    getglobal(this:GetName().."Low"):SetText("0.1");

    getglobal(this:GetName() .. "Text"):SetText(DCR_SCAN_LENGTH .. Dcr_Saved.ScanTime);

    this:SetMinMaxValues(0.1, 1);
    this:SetValueStep(0.1);
    this:SetValue(Dcr_Saved.ScanTime);
end

function Dcr_ScanTimeSlider_OnValueChanged()
    Dcr_Saved.ScanTime = this:GetValue() * 10;
    if (Dcr_Saved.ScanTime < 0) then
	Dcr_Saved.ScanTime = ceil(Dcr_Saved.ScanTime - 0.5)
    else
	Dcr_Saved.ScanTime = floor(Dcr_Saved.ScanTime + 0.5)
    end
    Dcr_Saved.ScanTime = Dcr_Saved.ScanTime / 10;
    getglobal(this:GetName() .. "Text"):SetText(DCR_SCAN_LENGTH .. Dcr_Saved.ScanTime);
end
