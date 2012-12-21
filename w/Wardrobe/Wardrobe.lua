--[[

	Wardrobe-AL

	By AnduinLothar karlkfi@yahoo.com

	Wardrobe lets you define up to 20 distinct equipment profiles 
	(called "outfits") and lets you switch among them on the fly.  
	For example, you can define a Normal Outfit that consists of 
	your regular equipment, an Around Town Outfit that consists of 
	what you'd like to wear when inside a city or roleplaying, a 
	Stamina Outfit that consists of all your best +stam gear, etc.  
	You can then switch amongst these outfits using a simple slash chat 
	command (/wardrobe wear Around Town Outfit), or using a small 
	interactive button docked beneath your radar.

]]--

Wardrobe = {};

---------------------------------------------------------------------------------
-- Info
---------------------------------------------------------------------------------

local WARDROBE_VERSION					= "1.82-AL";

---------------------------------------------------------------------------------
-- Localization Registration
---------------------------------------------------------------------------------

Localization.SetAddonDefault("Wardrobe", "enUS");
Localization.AssignAddonGlobalStrings("Wardrobe");	--For Bindings
local function TEXT(key) return Localization.GetString("Wardrobe", key) end

local Wardrobe_XMLTextAssignment = {
	NamePopupText				= "POPUP_TITLE";
	PopupConfirmText			= "POPUP_TITLE";
	NamePopupAcceptButton		= "TXT_ACCEPT";
	PopupConfirmAcceptButton	= "TXT_ACCEPT";
	NamePopupCancelButton		= "TXT_CANCEL";
	PopupConfirmCancelButton	= "TXT_CANCEL";
	CheckboxToggle				= "TXT_TOGGLE";
	CheckboxAccept				= "TXT_ACCEPT";
	CheckboxColorpick			= "TXT_COLOR";
	MainMenuFrameTitle			= "TXT_EDITOUTFITS";
	MainMenuFrameNewButton		= "TXT_NEW";
	MainMenuFrameCloseButton	= "TXT_CLOSE";
	ColorPickFrameTitle			= "TXT_SELECTCOLOR";
	ColorPickFrameOKButton		= "TXT_OK";
	ColorPickFrameCancelButton	= "TXT_CANCEL";
}

function Wardrobe.UpdateXMLText()
	for frameName, key in Wardrobe_XMLTextAssignment do
		if (Wardrobe[frameName]) then
			Wardrobe[frameName]:SetText(TEXT(key));
		else
			--print(frameName)
		end
	end
end

Localization.RegisterCallback("WardrobeXML", Wardrobe.UpdateXMLText);

---------------------------------------------------------------------------------
-- Variables
---------------------------------------------------------------------------------

WARDROBE_DEBUG						= false;
WARDROBE_NUM_OUTFITS				= 20;
WARDROBE_NUM_POPUP_FUNCTION_BUTTONS	= 1;

WARDROBE_TEMP_OUTFIT_NAME			= "#temp#";

local WARDROBE_UNMOUNT_OUTFIT_NAME			= "#unmount#";
local WARDROBE_UNPLAGUE_OUTFIT_NAME			= "#unplague#";
local WARDROBE_DONEEATING_OUTFIT_NAME		= "#uneating#";
local WARDROBE_DONESWIMMING_OUTFIT_NAME		= "#unswimming#";

Wardrobe.SpecialOutfitVirtualNames = {
	-- [specialID] -> virtualOutfitName
	["mounted"] = WARDROBE_UNMOUNT_OUTFIT_NAME,
	["chowing"] = WARDROBE_DONEEATING_OUTFIT_NAME,
	["plague"] = WARDROBE_UNPLAGUE_OUTFIT_NAME,
	["swimming"] = WARDROBE_DONESWIMMING_OUTFIT_NAME
};

Wardrobe.SpecialOutfitVirtualIDs = {
	-- [virtualOutfitName] -> specialID
	[WARDROBE_UNMOUNT_OUTFIT_NAME] = "mounted",
	[WARDROBE_DONEEATING_OUTFIT_NAME] = "chowing",
	[WARDROBE_UNPLAGUE_OUTFIT_NAME] = "plague",
	[WARDROBE_DONESWIMMING_OUTFIT_NAME] = "swimming"
};

Wardrobe.WaitingListVirtualNames = {
	-- [specialID] -> virtualOutfitName
	["mount"] = {id="mounted",toggle=true},
	["unmount"] = {id="mounted",toggle= false},
	["eating"] = {id="chowing",toggle=true},
	["uneating"] = {id="chowing",toggle=false},
	["plague"] = {id="plague",toggle=true},
	["unplague"] = {id="plague",toggle=false},
	["swim"] = {id="swimming",toggle=true},
	["unswim"] = {id="swimming",toggle= false}
};

WARDROBE_MAX_SCROLL_ENTRIES		 = 9;

WARDROBE_NOISY				= false;

function Wardrobe.GetPlagueZones()
	return {
		TEXT("TXT_WPLAGUELANDS"),
		TEXT("TXT_EPLAGUELANDS"), 
		TEXT("TXT_STRATHOLME"),
		TEXT("TXT_SCHOLOMANCE")
	}
end
					  
WARDROBE_DEFAULT_BUTTON_COLOR = 11;  -- corresponds to the entry in WARDROBE_CONSTANTS_TEXTCOLORS (in this case, #11 is green)
				  
Wardrobe.InventorySlots = {
	"HeadSlot",
	"NeckSlot",
	"ShoulderSlot",
	"BackSlot",
	"ChestSlot",
	"ShirtSlot",
	"TabardSlot",
	"WristSlot",
	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",
	"Finger0Slot",
	"Finger1Slot",
	"Trinket0Slot",
	"Trinket1Slot",
	"MainHandSlot",
	"SecondaryHandSlot",
	"RangedSlot"
};

Wardrobe.InventorySlotsSize = table.getn( Wardrobe.InventorySlots )

-- the variable that stores all the wardrobe info
-- and gets saved when you quit the game
Wardrobe_Config							= {};
Wardrobe_Config.Enabled					= true;
Wardrobe_Config.xOffset					= 10;
Wardrobe_Config.yOffset					= 39;
Wardrobe_Config.DefaultCheckboxState	= 1;	   -- default state for the checkboxes when specifying what equipment slots make up an outfit on the character paperdoll screen
Wardrobe_Config.MustClickUIButton		= false;   -- default state for the checkboxes when specifying what equipment slots make up an outfit on the character paperdoll screen
Wardrobe_Config.version					= WARDROBE_VERSION;

Wardrobe.Current_Outfit				= 0;
Wardrobe.InventorySearchForward		= 1;
Wardrobe.AlreadySetCharactersWardrobeID = false;	-- set this to true once we've looked up this character's wardrobe info
Wardrobe.PopupFunction				= "";	   -- tells the popup confirmation box what it's confirming (deleting an outfit, adding one, etc)
WARDROBE_CONSTANTS_POPUP_TITLE		= "";	   -- the title of the popup confirmation box
Wardrobe.Rename_OldName				= "";	   -- remembers original outfit name in case we cancel a rename
Wardrobe.BeingDragged				= false;	-- flag for dragging the wardrobe UI button
Wardrobe.DragLock					= false;	-- true if we're not allowed to drag the wardrobe UI button
Wardrobe.InCombat					= false;	-- true if we're in combat
Wardrobe.RegenEnabled				= true;	 -- true if we can't regen (usually means we're in combat)
Wardrobe.ShowingCharacterPanel		= false;	-- true if the character paperdoll frame is visible
Wardrobe.PressedAcceptButton		= false;	-- remembers if we pressed the accept button in case the character paperdoll frame closes via other means
Wardrobe.WaitingList 				= {};

--============================================================================================--
--============================================================================================--
--																							--
--							  INITIALIZATION FUNCTIONS									  --
--																							--
--============================================================================================--
--============================================================================================--


---------------------------------------------------------------------------------
-- Stuff done when the plugin first loads
---------------------------------------------------------------------------------
function Wardrobe.OnLoad()  

	-- watch our bags and update our wardrobe availability
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	--this:RegisterEvent("MIRROR_TIMER_START");	--Swimming Currently Disabled
	
	Wardrobe.RegisterXMLRefrences();
	Wardrobe.DropDown_OnLoad();
	Wardrobe.RegisterOptionConfigs();
end

---------------------------------------------------------------------------------
-- Convert all XML frames with the prefix "Wardrobe_Blah" to be refrenced by the Wardrobe.Blah equiv
-- An experiment in global namespace minimization
---------------------------------------------------------------------------------

function Wardrobe.RegisterXMLRefrences()
	local globalNameSpace = getfenv(0);
	local tempTable = {};
	local newName, newValue, foundString, number;
	local globalName, globalValue = next(globalNameSpace);
	while (globalName ~= nil) do
		newName, newValue = next(globalNameSpace, globalName);
		if ( type(globalName) == "string" ) and ( type(globalValue) == "table" ) and ( strfind(globalName, "Wardrobe_") ) then
			foundString, number = string.gsub(globalName, "^Wardrobe_", "")
			if (number > 0) and (globalValue.GetName) then
				tempTable[foundString] = globalValue;
				if (foundString ~= "MainMenuFrameTitle") and (foundString ~= "IconFrame") and (foundString ~= "PopupTitle") and (not strfind(foundString, "SortScrollFrame")) and (not strfind(foundString, "MainMenuFrameEntry")) then
					--Leave ScrollFrame refrences for template Compatibility
					--Leave Minimap Button refrences for MobileMinimapFrame Use
					--Leave PopupTitle refrences for ColorCycle Use
					--Leave MainMenuFrameTitle refrences for ColorCycle Use
					--Leave MainMenuFrameEntrys refrences for ColorCycle Use
					globalNameSpace[globalName] = nil;
				end
			end
		end
		globalName,globalValue = newName,newValue;
	end
	for n, v in tempTable do
		globalNameSpace.Wardrobe[n] = v;
	end
end


---------------------------------------------------------------------------------
-- Register Option Configs
---------------------------------------------------------------------------------
function Wardrobe.RegisterOptionConfigs()
	
	if (Khaos) then
		Wardrobe.RegisterKhaos();
	end
	
	local WardrobeCommands = {"/wardrobe","/wd"};
	if (Sky) then
		Sky.registerSlashCommand(
			{
				id="Wardrobe";
				commands = WardrobeCommands;
				onExecute = Wardrobe.ChatCommandHandler;
				helpText = function() return TEXT("CHAT_COMMAND_INFO") end;
			}
		);
	else
		SlashCmdList["WARDROBESLASH"] = Wardrobe.ChatCommandHandler;
		for i, slash in WardrobeCommands do
			setglobal("SLASH_WARDROBESLASH"..i, slash);
		end
	end
	
	-- makes sure we have a Print() command
	if(not Print) then
		function Print(msg, r, g, b, frame) 
			if (not r) then r = 1.0; end
			if (not g) then g = 1.0; end
			if (not b) then b = 1.0; end
			if ( frame ) then 
				frame:AddMessage(msg, r, g, b);
			else
				if ( DEFAULT_CHAT_FRAME ) then 
					DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
				end
			end
		end
	end
end

function Wardrobe.RegisterKhaos()
	local optionSet = {
		id="Wardrobe";
		text=function() return TEXT("CONFIG_HEADER") end;
		helptext=function() return TEXT("CONFIG_HEADER_INFO") end;
		callback=function(state) Wardrobe.Toggle(state and 1); end;
		feedback=function(state) return state and TEXT("TXT_ENABLED") or TEXT("TXT_DISABLED") end;
		difficulty=1;
		default={checked=true};
		options={
			{
				id = "Header";
				text = function() return TEXT("CONFIG_HEADER").." "..Wardrobe_Config.version end;
				helptext = function() return TEXT("CONFIG_HEADER_INFO") end;
				type = K_HEADER;
			};
			{
				id = "WearOutfit";
				text = function() return TEXT("CONFIG_WEAROUTFIT") end;
				helptext = function() return TEXT("CONFIG_WEAROUTFIT_INFO") end;
				feedback = function(state) return format(TEXT("CONFIG_WEAROUTFIT_FEEDBACK"), Wardrobe_Config[WD_realmID][WD_charID].Outfit[state.value].OutfitName) end;
				callback = function(state) 
					if (state.value) then 
						Wardrobe.WearOutfit(state.value);
					end
				end;
				setup = {
					options = Wardrobe.GetListOfOutfits;
					orderedOptions = true;
					multiSelect = false;
					noSelect = true;
				};
				default = {
					value = nil;
				};
				disabled = {
					value = nil;
				};
				type = K_PULLDOWN;
			};
			{
				id = "EditOutfits";
				text = function() return TEXT("CONFIG_EDIT") end;
				helptext = function() return TEXT("CONFIG_EDIT_INFO") end;
				feedback = function() return TEXT("CONFIG_EDIT_FEEDBACK") end;
				callback = Wardrobe.ShowMainMenu;
				type = K_BUTTON;
				setup = {
					buttonText = function() return TEXT("CONFIG_EDIT_BUTTON") end;
				};
			};
			{
				id = "OutfitKeyHeader";
				text = function() return TEXT("CONFIG_KEY_HEADER") end;
				helptext = function() return TEXT("CONFIG_KEY_HEADER") end;
				type = K_HEADER;
			};
			{
				id = "HelpText1";
				text = function() return TEXT("HELP_13") end;
				helptext = function() return TEXT("HELP_13") end;
				type = K_TEXT;
			};
			{
				id = "HelpText2";
				text = function() return TEXT("HELP_14") end;
				helptext = function() return TEXT("HELP_14") end;
				type = K_TEXT;
			};
			{
				id = "HelpText3";
				text = function() return TEXT("HELP_15") end;
				helptext = function() return TEXT("HELP_15") end;
				type = K_TEXT;
			};
			{
				id = "HelpText4";
				text = function() return TEXT("HELP_16") end;
				helptext = function() return TEXT("HELP_16") end;
				type = K_TEXT;
			};
			{
				id = "OptionsHeader";
				text = function() return TEXT("CONFIG_OPTIONS_HEADER") end;
				helptext = function() return TEXT("CONFIG_OPTIONS_HEADER") end;
				type = K_HEADER;
			};
			{
				id = "RequireClick";
				text = function() return TEXT("CONFIG_REQCLICK") end;
				helptext = function() return TEXT("CONFIG_REQCLICK_INFO") end;
				feedback = function(state) 
					if (state.checked) then
						return TEXT("TXT_BUTTONONCLICK");
					else
						return TEXT("TXT_BUTTONONMOUSEOVER");
					end
				end;
				callback = function(state) Wardrobe_Config.MustClickUIButton = (state.checked) end;
				check = true;
				type = K_CHECKBOX;
				default = {
					checked = false;
				};
				disabled = {
					checked = false;
				};
			};
			{
				id = "LockButton";
				text = function() return TEXT("CONFIG_LOCKBUTTON") end;
				helptext = function() return TEXT("CONFIG_LOCKBUTTON_INFO") end;
				feedback = function(state) 
					if (state.checked) then
						return TEXT("TXT_BUTTONLOCKED");
					else
						return TEXT("TXT_BUTTONUNLOCKED");
					end
				end;
				callback = function(state) Wardrobe.DragLock = (state.checked) end;
				check = true;
				type = K_CHECKBOX;
				default = {
					checked = false;
				};
				disabled = {
					checked = false;
				};
			};
			{
				id = "DropDownScale";
				text = function() return TEXT("CONFIG_DROPDOWNSCALE") end;
				helptext = function() return TEXT("CONFIG_DROPDOWNSCALE_INFO") end;
				feedback = function(state) 
					return format(TEXT("CONFIG_DROPDOWNSCALE_FEEDBACK"), state.slider*100);
				end;
				callback = function(state) Wardrobe.SetDropDownScale(state.slider) end;
				check = true;
				type = K_SLIDER;
				dependencies = {["DropDownScale"]={checked=true}};
				default = { 
					checked = false;
					slider = UIParent:GetScale(); 
				};
				disabled = {
					checked = false;
					slider = UIParent:GetScale();
				};
				setup = {
					sliderMin = 0.5;
					sliderMax = 1.0;
					sliderStep = 0.1;
					sliderSignificantDigits = 1;
				};
			};
			{
				id = "Reset";
				text = function() return TEXT("CONFIG_RESET") end;
				helptext = function() return TEXT("CONFIG_RESET_INFO") end;
				feedback = function() return TEXT("CONFIG_RESET_FEEDBACK") end;
				callback = Wardrobe.EraseAllOutfits;
				type = K_BUTTON;
				setup = {
					buttonText = function() return TEXT("CONFIG_RESET_BUTTON") end;
				};
			};
		};
	};
	Khaos.registerOptionSet(
		"inventory",
		optionSet
	);
end

---------------------------------------------------------------------------------
-- Event handler
---------------------------------------------------------------------------------
function Wardrobe.OnEvent(event)

	if (Wardrobe_Config.Enabled) then	   
		if (event == "PLAYER_REGEN_DISABLED") then
			--Sea.io.print("PLAYER_REGEN_DISABLED");
			Wardrobe.RegenEnabled = false;
		elseif (event == "PLAYER_REGEN_ENABLED") then
			Wardrobe.RegenEnabled = true;
			--Sea.io.print("PLAYER_REGEN_ENABLED ", Wardrobe.IsPlayerInCombat());
			if (not Wardrobe.IsPlayerInCombat()) then
				Wardrobe.CheckWaitingList();
				Wardrobe.CheckForMounted();
				Wardrobe.CheckForEatDrink();
			end
		elseif (event == "PLAYER_ENTER_COMBAT") then
			--Sea.io.print("PLAYER_ENTER_COMBAT");
			Wardrobe.InCombat = true;
		elseif (event == "PLAYER_LEAVE_COMBAT") then
			Wardrobe.InCombat = false;
			--Sea.io.print("PLAYER_LEAVE_COMBAT ", Wardrobe.IsPlayerInCombat());
			if (not Wardrobe.IsPlayerInCombat()) then
				--Wardrobe.CheckWaitingList();
			end
		elseif (event == "PLAYER_AURAS_CHANGED") then
			--if (not Wardrobe.IsPlayerInCombat()) then
				if (Chronos) then
					Chronos.scheduleByName("WardrobeAuraCheck", .2, Wardrobe.AuraCheck);
				else
					Wardrobe.CheckForMounted();
					Wardrobe.CheckForEatDrink();
				end
			--end
		elseif (event == "ZONE_CHANGED_NEW_AREA") then
			Wardrobe.ChangedZone();
		elseif (event == "MIRROR_TIMER_START") then
			Wardrobe.CheckForSwimming();
		elseif (event == "PLAYER_ENTERING_WORLD") then
			Wardrobe.UpdateOldConfigVersions();
			Wardrobe.CheckForMounted();
			Wardrobe.CurrentZone = GetZoneText();
			Wardrobe.ChangedZone();
			Wardrobe.SetDropDownScale(Wardrobe_Config.DropDownScale);
		end
	end
end

function Wardrobe.AuraCheck()
	Wardrobe.CheckForMounted();
	Wardrobe.CheckForEatDrink();
end



---------------------------------------------------------------------------------
-- Return true if we're in combat
---------------------------------------------------------------------------------
function Wardrobe.IsPlayerInCombat() 
	if (Wardrobe.InCombat) or (not Wardrobe.RegenEnabled) then
		return true;
	else
		return false;
	end
end


---------------------------------------------------------------------------------
-- Update outdated config information
---------------------------------------------------------------------------------
function Wardrobe.UpdateOldConfigVersions()
	if (Wardrobe_Config.DefaultCheckboxState == nil) then
		Wardrobe.Debug("Adding DefaultCheckboxState to Wardrobe_Config.");
		Wardrobe_Config.DefaultCheckboxState = 1;
	else
		Wardrobe.Debug("Wardrobe_Config.DefaultCheckboxState = "..tostring(Wardrobe_Config.DefaultCheckboxState));		
	end
	
	-- Clear out unused items
	Wardrobe.CheckForOurWardrobeID();
	for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do
		for j = 1, Wardrobe.InventorySlotsSize do
			if (outfit.Item[j]) then
				if (outfit.Item[j].IsSlotUsed ~= 1) then
					outfit.Item[j] = nil;
				elseif (outfit.Item[j].Name == "") then
					outfit.Item[j] = {IsSlotUsed = 1};
				end
			end
		end
	end
	
	Wardrobe_Config.version = WARDROBE_VERSION;
end


--============================================================================================--
--============================================================================================--
--																							--
--							  CHAT COMMAND FUNCTIONS										--
--																							--
--============================================================================================--
--============================================================================================--


---------------------------------------------------------------------------------
-- Break a chat command into its command and variable parts (i.e. "debug on" 
-- will break into command = "debug" and variable = "on", or "add my spiffy wardrobe"
-- breaks into command = "add" and variable = "my spiffy wardrobe"
---------------------------------------------------------------------------------
function Wardrobe.ParseCommand(msg)
	firstSpace = string.find(msg, " ", 1, true);
	if (firstSpace) then
		local command = string.sub(msg, 1, firstSpace - 1);
		local var  = string.sub(msg, firstSpace + 1);
		return command, var
	else
		return msg, nil;
	end
end


---------------------------------------------------------------------------------
-- A simple chat command handler.  takes commands in the form "/wardrobe command var"
---------------------------------------------------------------------------------
function Wardrobe.ChatCommandHandler(msg)
	local command, var = Wardrobe.ParseCommand(msg);
	if ((not command) and msg) then
		command = msg;
	end
	if (command) then
		command = string.lower(command);
		if (command == TEXT("CMD_RESET")) then
			Wardrobe.EraseAllOutfits();
		elseif (command == TEXT("CMD_LIST")) then
			Wardrobe.ListOutfits(var);
		elseif (command == TEXT("CMD_WEAR") or command == TEXT("CMD_WEAR2") or command == TEXT("CMD_WEAR3")) then
			Wardrobe.WearOutfit(var);
		elseif (command == TEXT("CMD_ON")) then
			Wardrobe.Toggle(1);
		elseif (command == TEXT("CMD_OFF")) then
			Wardrobe.Toggle(0);
		elseif (command == TEXT("CMD_LOCK")) then
			Wardrobe.ToggleLockButton(true);
		elseif (command == TEXT("CMD_UNLOCK")) then
			Wardrobe.ToggleLockButton(false);
		elseif (command == TEXT("CMD_CLICK")) then
			Wardrobe.ToggleClickButton(true);
		elseif (command == TEXT("CMD_MOUSEOVER")) then
			Wardrobe.ToggleClickButton(false);
		elseif (command == TEXT("CMD_SCALE")) then
			Wardrobe.SetDropDownScale(var);
		elseif (command == TEXT("CMD_VERSION")) then
			Wardrobe.Print(TEXT("TXT_WARDROBEVERSION").." "..WARDROBE_VERSION);
		elseif (command == "testcheck") then
			Wardrobe.ShowWardrobe_ConfigurationScreen();
		elseif (command == "testsort") then
			Wardrobe.ShowMainMenu();
		elseif (command == "debug") then
			Wardrobe.ToggleDebug();
		elseif (command == "report") then
			Wardrobe.DumpDebugReport();
		elseif (command == "itemlist") then
			Wardrobe.BuildItemList();
		elseif (command == "struct") then
			Wardrobe.DumpDebugStruct();
		else
			Wardrobe.ShowHelp();
		end
	end
end



--============================================================================================--
--============================================================================================--
--																							--
--							  WARDROBE MAIN FUNCTIONS									   --
--																							--
--============================================================================================--
--============================================================================================--

---------------------------------------------------------------------------------
-- Each character on an account has an ID assigned to it that specifies its wardrobes
-- This function returns the ID associated with this character
---------------------------------------------------------------------------------
function Wardrobe.GetThisCharactersWardrobeID()
	
	Wardrobe.Debug("Looking up this character's wardrobe number...");
	
	-- upgrade old versions
	if ( Wardrobe_Config.version == nil ) then
		Wardrobe_Config = nil;
		Wardrobe_Config = { };
		Wardrobe_Config.Enabled				 = true;
		Wardrobe_Config.xOffset				 = 10;
		Wardrobe_Config.yOffset				 = 39;
		Wardrobe_Config.DefaultCheckboxState	= 1;	   -- default state for the checkboxes when specifying what equipment slots make up an outfit on the character paperdoll screen
		Wardrobe_Config.MustClickUIButton	   = false;   -- default state for the checkboxes when specifying what equipment slots make up an outfit on the character paperdoll screen
		Wardrobe_Config.version = WARDROBE_VERSION;
		Wardrobe.Print("Erasing old Wardrobe_Config because it don't support realm");
	elseif ( not Wardrobe_Config.version == WARDOBE_VERSION ) then
		Wardrobe_Config.version = WARDROBE_VERSION;
	end
	
	-- Look for this realm in the wardrobe table
	WD_RealmName = GetRealmName();
	WD_realmID = nil;
	
	for i = 1, table.getn(Wardrobe_Config) do
		if ( Wardrobe_Config[i].RealmName == WD_RealmName ) then
			WD_realmID = i;
			break;
		end
	end
	
	-- if we didn't find this realm, add us to the wardrobe table
	if (not WD_realmID) then
		Wardrobe.AddThisRealmToWardrobeTable();
		WD_realmID = table.getn(Wardrobe_Config);
	end
	
	
	-- look for this character in the wardrobe table
	WD_charID = nil;
	WD_PlayerName = UnitName("player")
	
	for i = 1, table.getn(Wardrobe_Config[WD_realmID]) do
		if (Wardrobe_Config[WD_realmID][i].PlayerName == WD_PlayerName) then
			WD_charID = i;
			break;
		end
	end
	
	-- if we didn't find this character, add us to the wardrobe table
	if (not WD_charID) then
		Wardrobe.AddThisCharacterToWardrobeTable();
		WD_charID = table.getn(Wardrobe_Config[WD_realmID]);
	end
	
	Wardrobe.ButtonUpdateVisibility();
	
	Wardrobe.Debug("This character's wardrobe number is: "..WD_charID);
	
	-- flag that we've already found / created this character's wardrobe entry
	Wardrobe.AlreadySetCharactersWardrobeID = true;
end


---------------------------------------------------------------------------------
-- Checks to see if we've already looked up the number associated with this character
-- If not, grab the number
---------------------------------------------------------------------------------
function Wardrobe.CheckForOurWardrobeID()
	if (not Wardrobe.AlreadySetCharactersWardrobeID) then
		Wardrobe.GetThisCharactersWardrobeID();
	end
end


-- NOTES ABOUT DATASTRUCTURES:
--
-- For each character, the wardrobes are stored in a datastructure that looks like this
-- 
-- x = total number of outfits
-- y = total slots on a character (head, feet, hands, etc)
--
-- Outfit[x]		  -- the datastructure for a single outfit
--
--	 SortNumber	   -- specifies the position this outfit will appear in the list of outfits when the list is sorted
--	 OutfitName	   -- the name of this outfit
--	 Available		-- true if all of the items in this outfit are in our bags or equiped
--	 Mounted		  -- true if this is the outfit to be worn when we mount
--	 Virtual		  -- true if this outfit is virtual (not a real outfit, but only used as temporary storage)
--	 Selected		 -- true if this outfit is the currently selected outfit on the menu screen (highlighted white)
--	 Item[1]		  -- the data structure for all the items in this outfit
--		  Name		-- the name of the item
--		  IsSlotUsed  -- 1 if this outfit uses this slot, 0 if not (i.e. an outfit might not involve your trinkets, or might only consist of your rings)
--		.
--		.
--		.
--	 Item[y]	  
--
-- So, let's say you have two outfits in your wardrobe.  Wardrobe[1] represents outfit 1, and Wardrobe[2] 
-- represents outfit 2.  for outfit 1, Wardrobe[1].OutfitName would be the name of this outfit (say, "In town outfit").  
-- the item on your character slot 5 would be Wardrobe[1].Item[5].Name.  Since all these are stored per character, the
-- actual datastructure would look like:
--
-- Wardrobe_Config[WD_realmID][3].Wardrobe[1].Item[5].Name --> for character 3, outfit 1, item 5


---------------------------------------------------------------------------------
-- Add an entry for this realm to the main table of wardrobes
---------------------------------------------------------------------------------
function Wardrobe.AddThisRealmToWardrobeTable()
	
	Wardrobe.Debug("Didn't find a wardrobe ID for this realm.  Adding this realm to the table...");
	
	-- build the structure for this realm's wardrobe
	tempTable = { };
	tempTable.RealmName = WD_RealmName;
	
	-- stick this structure into the main table of wardrobes
	table.insert(Wardrobe_Config, tempTable);
end


---------------------------------------------------------------------------------
-- Add an entry for this character to the main table of wardrobes
---------------------------------------------------------------------------------
function Wardrobe.AddThisCharacterToWardrobeTable()
	
	Wardrobe.Debug("Didn't find a wardrobe ID for this character.  Adding this character to the table...");
	
	-- build the structure for this char's wardrobe
	tempTable = { };
	tempTable.PlayerName = WD_PlayerName
	tempTable.Outfit = { };
	
	-- stick this structure into the main table of wardrobes
	table.insert(Wardrobe_Config[WD_realmID], tempTable);
end


---------------------------------------------------------------------------------
-- Create and return a blank outfit structure
---------------------------------------------------------------------------------
function Wardrobe.CreateBlankOutfit()
	local tempTable2 = { };
	tempTable2.SortNumber = nil;
	tempTable2.OutfitName = "";
	tempTable2.Available = false;
	tempTable2.Special = "";
	tempTable2.Virtual = false;
	tempTable2.Selected = false;
	tempTable2.ButtonColor = WARDROBE_DEFAULT_BUTTON_COLOR;
	tempTable2.Item = { };
	--[[
	for i = 1, Wardrobe.InventorySlotsSize do
		tempTable3 = { };
		tempTable3.Name = "";
		tempTable3.IsSlotUsed = Wardrobe_Config.DefaultCheckboxState;
		table.insert(tempTable2.Item, tempTable3);
	end
	]]--
	
	return tempTable2;
end


---------------------------------------------------------------------------------
-- Add the named outfit to our wardrobe
---------------------------------------------------------------------------------
function Wardrobe.AddNewOutfit(outfitName, buttonColor)   

	 if (Wardrobe_Config.Enabled) then
	
		-- if we haven't already looked up our character's number
		Wardrobe.CheckForOurWardrobeID();

		if (not outfitName) then
			return;
		end
		
		-- make sure we don't already have an outfit with the same name
		if (Wardrobe.FoundOutfitName(outfitName)) then
			Wardrobe.Print(TEXT("TXT_OUTFITNAMEEXISTS"));   
			return;
		end

		Wardrobe.Debug("Trying to set this wardrobe as \""..outfitName.."\"");

		-- if we found a free outfit slot
		local outfitNum = Wardrobe.GetNextFreeOutfitSlot();
		if (outfitNum ~= 0) then
		
			-- store our current equipment in this outfit
			Wardrobe.StoreItemsInOutfit(outfitName, outfitNum, "added");
			Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].ButtonColor = buttonColor;
		-- otherwise we've used the maximum number of outfits
		else
			Wardrobe.Print(TEXT("TXT_USEDUPALL").." "..WARDROBE_NUM_OUTFITS.." "..TEXT("TXT_OFYOUROUTFITS"), 1.0, 0.0, 0.0);
		end
	end
end


---------------------------------------------------------------------------------
-- Create and return the index of the next free outfit slot
---------------------------------------------------------------------------------
function Wardrobe.GetNextFreeOutfitSlot(virtualOutfitName)

	-- find next unused outfit slot
	local outfitNum = 0;
	
	local outfitCount = 0;
	local outfits = Wardrobe_Config[WD_realmID][WD_charID].Outfit;
	local duplicate = false;
	for i, oufit in outfits do
		if (not oufit.Virtual) then
			outfitCount = outfitCount + 1;
		end
		if (oufit.OutfitName == virtualOutfitName) then
			table.remove(outfits, i);
			duplicate = true;
		end
	end
	
	if (duplicate) then
		Wardrobe.RenumberSortNumbers();
	end
	
	-- if we aren't already using our max number of outfits
	if (outfitCount < WARDROBE_NUM_OUTFITS or addingVirtualOutfit) then
		-- add another outfit to the list and return its index
		table.insert(outfits, Wardrobe.CreateBlankOutfit());
		outfitNum = table.getn(outfits);
		outfits[outfitNum].SortNumber = outfitNum;
	end
		
	return outfitNum;	
end


---------------------------------------------------------------------------------
-- Store our currently equipped items in the specified outfit name
---------------------------------------------------------------------------------
function Wardrobe.StoreItemsInOutfit(outfitName, outfitNum, printMessage)

	-- store the name of this outfit
	local outfit = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum];
	outfit.OutfitName = outfitName;
	outfit.Special = nil;
	outfit.Virtual = false;

	-- for each slot on our character's person (hands, feet, etc)
	for i = 1, Wardrobe.InventorySlotsSize do
		if (Wardrobe.ItemCheckState[i] == 1) then
			if (not outfit.Item[i]) then
				outfit.Item[i] = {};
			end
			local item = outfit.Item[i];
			item.IsSlotUsed = 1
			local itemID, permEnchant, tempEnchant, suffix, itemName = Wardrobe.GetItemInfoAtInventorySlotNumber(i);
			item.Name = itemName;
			item.ItemID = itemID;
			item.Suffix = suffix;
			item.PermEnchant = permEnchant;
			Wardrobe.Debug("	Setting USED slot "..Wardrobe.InventorySlots[i].." = ["..tostring(item.Name).."]");
		else
			outfit.Item[i] = nil;
			Wardrobe.Debug("	Setting unused slot "..Wardrobe.InventorySlots[i]);
		end
	end 

	-- all the items in this outfit are currently available in the player's inventory
	outfit.Available = true;

	if (printMessage) then
		Wardrobe.Print(TEXT("TXT_OUTFIT").." \""..outfitName.."\" "..printMessage..".");
	end
end


---------------------------------------------------------------------------------
-- Update an outfit
---------------------------------------------------------------------------------
function Wardrobe.UpdateOutfit(outfitName, buttonColor)

	if (Wardrobe_Config.Enabled) then
	
		-- if we haven't already looked up our character's number
		Wardrobe.CheckForOurWardrobeID();
			 
		-- check to see if the wardrobe doesn't exist
		if (outfitName == nil or outfitName == "") then
			Wardrobe.Print(TEXT("TXT_PLEASEENTERNAME"));
		elseif (not Wardrobe.FoundOutfitName(outfitName)) then
			Wardrobe.Print(TEXT("TXT_OUTFITNOTEXIST"));
			UIErrorsFrame:AddMessage(TEXT("TXT_NOTEXISTERROR"), 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
		else

			-- find the outfit to update
			for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do

				-- if we found the outfit, store our equipment
				if (outfit.OutfitName == outfitName) then
					Wardrobe.StoreItemsInOutfit(outfitName, i, TEXT("TXT_UPDATED"));
					outfit.ButtonColor = buttonColor;
				end
			end
		end
	end
end


---------------------------------------------------------------------------------
-- Erase the named outfit
---------------------------------------------------------------------------------
function Wardrobe.EraseOutfit(outfitName, silent, eraseAll)  

	if (Wardrobe_Config.Enabled) then
	
		-- if we haven't already looked up our character's number
		Wardrobe.CheckForOurWardrobeID();
		
		Wardrobe.Debug("Trying to delete outfit \""..outfitName.."\"");
		
		local found = false;
		-- find the outfit to erase
		local outfits = Wardrobe_Config[WD_realmID][WD_charID].Outfit;
		for i = 1, table.getn(outfits) do

			-- if we found the outfit
			if (outfits[i]) and (outfits[i].OutfitName == outfitName) then

				-- remove the outfit
				table.remove(outfits, i);
				
				--Wardrobe.RemoveAPopupButton(outfitName);
				
				found = true;
				
				if (not eraseAll) then
					break;
				else
					i = 1;
				end
			end
		end
		
		Wardrobe.RenumberSortNumbers();
		
		if (found) then
			if (not eraseAll) and (not silent) then
				Wardrobe.Print(TEXT("TXT_OUTFIT").." \""..outfitName.."\" "..TEXT("TXT_DELETED"));
				Wardrobe.ListOutfits();
				UIErrorsFrame:AddMessage(TEXT("TXT_OUTFIT").." \""..outfitName.."\" "..TEXT("TXT_DELETED"), 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
			end
		else
			Wardrobe.Print(TEXT("TXT_UNABLETOFIND").." \""..outfitName.."!\"");
			UIErrorsFrame:AddMessage(TEXT("TXT_UNABLEFINDERROR"), 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
		end
		return found;
	end
end


---------------------------------------------------------------------------------
-- Erase all our outfits
---------------------------------------------------------------------------------
function Wardrobe.EraseAllOutfits()

	if (Wardrobe_Config.Enabled) then
	
		-- if we haven't already looked up our character's number
		Wardrobe.CheckForOurWardrobeID();

		-- delete all the outfits
		Wardrobe_Config[WD_realmID][WD_charID].Outfit = { };
		
		-- hide the main menu
		Wardrobe.ToggleMainMenuFrameVisibility(false);
		
		Wardrobe.Print(TEXT("TXT_ALLOUTFITSDELETED"));
		UIErrorsFrame:AddMessage(TEXT("TXT_ALLOUTFITSDELETED"), 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
	end
end


---------------------------------------------------------------------------------
-- Print a list of our outfits
---------------------------------------------------------------------------------
function Wardrobe.ListOutfits(var)

	if (Wardrobe_Config.Enabled) then
	
		-- if we haven't already looked up our character's number
		Wardrobe.CheckForOurWardrobeID();

		local foundOutfits = false;
		Wardrobe.Print(TEXT("TXT_YOURCURRENTARE"));

		-- for each outfit
		for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do

			-- if it has a name and isn't virtual
			if (outfit.OutfitName ~= "" and (not outfit.Virtual)) then
				Wardrobe.Print("	o ".. outfit.OutfitName);
				foundOutfits = true;

				-- if we asked for a detailed printout, show all the items
				if (var == "items") then
					for j = 1, Wardrobe.InventorySlotsSize do	
						local item = outfit.Item[j];
						if (item) and (item.Name) and (item.Name ~= "") then
							Wardrobe.Print("		["..Wardrobe.InventorySlots[j].." -> ".. item.Name.."]");
						end
					end		   
				end
			end
		end

		if (not foundOutfits) then
			Wardrobe.Print("  "..TEXT("TXT_NOOUTFITSFOUND"));
		end
	end
end


---------------------------------------------------------------------------------
-- Wear an outfit
---------------------------------------------------------------------------------
function Wardrobe.WearOutfit(wardrobeName, silent)

	if (Wardrobe_Config.Enabled) then
	
		 -- if we haven't already looked up our character's number
		Wardrobe.CheckForOurWardrobeID();
		
		local outfit;
		
		-- if the user didn't specify a wardrobe to wear
		if (not wardrobeName) then

			Wardrobe.Print(TEXT("TXT_SPECIFYOUTFITTOWEAR"));
			return;

		-- else use the specified wardrobe
		elseif (type(wardrobeName) == "number") then
			local outfitNumber = wardrobeName;
			wardrobeName = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNumber].OutfitName;
			if (wardrobeName) then
				Wardrobe.Debug("Wardrobe.WearOutfit: Found outfit at #".. outfitNumber);
				outfit = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNumber];
			else
				Wardrobe.Print(TEXT("TXT_UNABLEFIND").." \""..wardrobeName.."\" "..TEXT("TXT_INYOURLISTOFOUTFITS"));
				return;	   
			end
		else
			local outfitNumber = 0;
			for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
				Wardrobe.Debug("In WearOutfit, Looking at outfit #"..i.."  name = ["..Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName.."]");
				if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName == wardrobeName) then
					outfitNumber = i;
					Wardrobe.Debug("Wardrobe.WearOutfit: Found outfit at #"..outfitNumber);
					break;
				end
			end

			if (outfitNumber == 0) then
				Wardrobe.Print(TEXT("TXT_UNABLEFIND").." \""..wardrobeName.."\" "..TEXT("TXT_INYOURLISTOFOUTFITS"));
				return;	   
			end
			
			outfit = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNumber];
		end


		Wardrobe.Debug(TEXT("TXT_SWITCHINGTOOUTFIT").." \""..wardrobeName.."\"");

		-- this variable "freeBagSpacesUsed" lets us track which empty pack spaces we've
		-- already assigned an item to be put into.  we need to do this because when we remove
		-- items from our character and put them into our bags, the server takes time to actually
		-- move the item into the bag.  during this delay, we may be still removing items, and we
		-- may see a slot that LOOKS empty but really the server just hasn't gotten around to moving
		-- a previous item into the slot.  this variable lets us mark each empty slot once we've assigned
		-- an item to it so that we don't try to use the same empty slot for another item.
		local freeBagSpacesUsed = { };

		-- tracks how our switching is going.  if at any point we can't remove an item (bags are full, etc),
		-- this will get set to false
		local switchResult = true;
		local itemID, permEnchant, tempEnchant, suffix, invItemName, theSlotID, outfitItemName, outfitItemID, outfitPermEnchant, equipingTwoHandWeapon;
		-- for each slot on our character (hands, neck, head, feet, etc)
		for i = 1, Wardrobe.InventorySlotsSize do
			local outfitItem = outfit.Item[i];
			-- if this slot is used in this outfit
			if (equipingTwoHandWeapon) and (Wardrobe.InventorySlots[i] == "SecondaryHandSlot") then
				itemID, permEnchant, tempEnchant, suffix, invItemName = Wardrobe.GetItemInfoAtInventorySlotNumber(i);
				if (itemID) and (Chronos) then
					Wardrobe.Debug("	  Moving offhand to back of bags: "..invItemName);
					Chronos.scheduleByName("ReBag:"..invItemName, 1, ReBagContainerItem, invItemName);
				end
			elseif (outfitItem) and (outfitItem.IsSlotUsed == 1) then
				
				theSlotID = GetInventorySlotInfo(Wardrobe.InventorySlots[i]);
				outfitItemName = outfitItem.Name;
				outfitItemID = outfitItem.ItemID;
				outfitSuffix = outfitItem.Suffix;
				outfitPermEnchant = outfitItem.PermEnchant;
				Wardrobe.Debug("Working on slot -> "..Wardrobe.InventorySlots[i]);

			
				itemID, permEnchant, tempEnchant, suffix, invItemName = Wardrobe.GetItemInfoAtInventorySlotNumber(i);
				
				-- if we've set an item for this slot
				if (((outfitItemID) and (outfitSuffix) and (outfitPermEnchant)) and ((outfitItemID ~= itemID) or (outfitSuffix ~= suffix) or (outfitPermEnchant ~= permEnchant))) or ((outfitItemName) and (outfitItemName ~= "") and (outfitItemName ~=  invItemName)) then
					-- equip the correct item
					Wardrobe.Debug("	  Didn't match!  Switching out "..Wardrobe.InventorySlots[i].." for ["..outfitItemName.."]");
					if (not Wardrobe.Equip(outfitItemName, theSlotID, outfitItemID, outfitSuffix, outfitPermEnchant)) then
						Wardrobe.Print(TEXT("TXT_WARNINGUNABLETOFIND").." \""..outfitItemName.."\" "..TEXT("TXT_INYOURBAGS"));
					elseif (not outfitItemID) or (not outfitSuffix) or (not outfitPermEnchant) then
						-- Item not stored with itemID info
						--outfitItem.ItemID = itemID;
						--outfitItem.Suffix = suffix;
						--outfitItem.PermEnchant = permEnchant;
						--outfitItem.TempEnchant = tempEnchant;
					end
					
					-- Check for 2h weapon
					if (Wardrobe.InventorySlots[i] == "MainHandSlot") and (outfitItemID) then
						local _, _, _, _, _, _, _, equipLoc = GetItemInfo(outfitItemID); 
						equipingTwoHandWeapon = (equipLoc == "INVTYPE_2HWEAPON");
					end
				
				-- Forced Empty Slot, slot currently has an item in it
				elseif (invItemName) and ((not outfitItemName) or (outfitItemName == "")) then
					-- if inventory slot has an item equipped and it's a duel slot then check the next slots for swapping 
					local swapped = false;
					if (equipingTwoHandWeapon) and (Wardrobe.InventorySlots[i] == "SecondaryHandSlot") then
						-- Should never be hit, is caught in first escape clause.
						swapped = true;
						result = true;
						
					elseif (Wardrobe.InventorySlots[i] == "MainHandSlot") or (Wardrobe.InventorySlots[i] == "Finger0Slot") or (Wardrobe.InventorySlots[i] == "Trinket0Slot") then
						-- Next Inv Slot
						outfitItem = outfit.Item[i+1];
						outfitItemName = outfitItem.Name;
						outfitItemID = outfitItem.ItemID;
						outfitSuffix = outfitItem.Suffix;
						outfitPermEnchant = outfitItem.PermEnchant;
						if ((outfitItemID) and (outfitSuffix) and (outfitPermEnchant) and (outfitItemID == itemID) and (outfitSuffix == suffix) and (outfitPermEnchant == permEnchant)) or ((outfitItemName) and (outfitItemName ==  invItemName)) then
							-- Put secondary slot item in bag
							local secondarySlotID = GetInventorySlotInfo(Wardrobe.InventorySlots[i+1]);
							PickupInventoryItem(secondarySlotID);
							result, freeBagSpacesUsed = BagItem(freeBagSpacesUsed);
							switchResult = switchResult and result;
							Wardrobe.Debug("   Trying to remove "..Wardrobe.InventorySlots[i].." ( slot ID #"..theSlotID..")");
							
							-- Equip primary slot item to secondary slot
							PickupInventoryItem(theSlotID);
							EquipCursorItem(secondarySlotID);
							Wardrobe.Debug("	  Matched Next Slot!  Moving "..Wardrobe.InventorySlots[i].." item to "..Wardrobe.InventorySlots[i+1]..".");
							swapped = true;
						end
					end
					
					-- this outfit doesn't use an item for this inventory slot (i.e. no gloves in this wardrobe)
					if (not swapped) then
						-- grab the inventory item and bag it
						PickupInventoryItem(theSlotID);
						result, freeBagSpacesUsed = BagItem(freeBagSpacesUsed);
						Wardrobe.Debug("   Trying to remove "..Wardrobe.InventorySlots[i].." ( slot ID #"..theSlotID..")");
					end
					
					-- if we failed to switch, this will let us know
					switchResult = switchResult and result;
				
				-- Item found was item desired
				else
					Wardrobe.Debug("	  Matched!  No need to switch out "..Wardrobe.InventorySlots[i]..".");
				end
			end	
		end 

		-- only errorcheck when dealing with non-virtual outfits
		if (not outfit.Virtual and not silent) then
		
			-- if everything went OK
			if (switchResult) then
				if ( WARDROBE_NOISY ) then
					Wardrobe.Print(TEXT("TXT_SWITCHEDTOOUTFIT").." \""..wardrobeName..".\"");
				end
				Wardrobe.Current_Outfit = outfitNumber;
			else
				Wardrobe.Print(TEXT("TXT_PROBLEMSCHANGING"));
			end
		end	
	
		if (mrpOnMRPEvent) then
			--MyRolePlay support for swapping outfits
			mrpOnMRPEvent("CHANGE_OUTFIT", wardrobeName);
		end
	
	end
end


---------------------------------------------------------------------------------
-- Rename an outfit
---------------------------------------------------------------------------------
function Wardrobe.RenameOutfit(oldName, newName)

	if (Wardrobe_Config.Enabled) then	

		-- check to see if the new name is already being used
		if (not Wardrobe.FoundOutfitName(newName) and newName ~= "") then
			for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
				if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName == oldName) then
					Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName = newName;
					break;
				end
			end   
			UIErrorsFrame:AddMessage(TEXT("TXT_OUTFITRENAMEDERROR"), 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
			Wardrobe.Print(TEXT("TXT_OUTFITRENAMEDTO").." \""..oldName.."\" "..TEXT("TXT_TOWORDONLY").." \""..newName.."\"");
		end
	end
end



---------------------------------------------------------------------------------
-- Comparison function for sorting outfits
---------------------------------------------------------------------------------
function Wardrobe.SortOutfitCompare(outfit1, outfit2)
	if (Wardrobe.SpecialOutfitVirtualIDs[outfit1.Name]) then
		return false
	elseif (outfit1.SortNumber < outfit2.SortNumber) then
		return true;
	else
		return false;
	end
end


---------------------------------------------------------------------------------
-- Sort the outfits based on the .SortNumber property
---------------------------------------------------------------------------------
function Wardrobe.SortOutfits()
	table.sort(Wardrobe_Config[WD_realmID][WD_charID].Outfit, Wardrobe.SortOutfitCompare);
	
	Wardrobe.RenumberSortNumbers();
end


---------------------------------------------------------------------------------
-- Re-number the .SortNumbers so they start at 1 and go up by 1
---------------------------------------------------------------------------------
function Wardrobe.RenumberSortNumbers()
	for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
		Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].SortNumber = i;
	end
end


---------------------------------------------------------------------------------
-- Re-order an outfit in the list of outfits
---------------------------------------------------------------------------------
function Wardrobe.OrderOutfit(outfitNum, direction)
	if (outfitNum == 1 and direction < 0) then return; end
	if (outfitNum == table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) and direction > 0) then return; end
	
	local outfit = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum];
	
	if (direction > 0) then
		
		swapNum = 0;
		for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
			if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].SortNumber == outfit.SortNumber + 1) then
				swapNum = i;
				break;
			end
		end
		Wardrobe_Config[WD_realmID][WD_charID].Outfit[swapNum].SortNumber = outfit.SortNumber
		outfit.SortNumber = outfit.SortNumber + 1;
	else
		swapNum = 0;
		for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
			if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].SortNumber == outfit.SortNumber - 1) then
				swapNum = i;
				break;
			end
		end
		Wardrobe_Config[WD_realmID][WD_charID].Outfit[swapNum].SortNumber = outfit.SortNumber
		outfit.SortNumber = outfit.SortNumber - 1;
	end
	
	return swapNum;	
end


---------------------------------------------------------------------------------
-- return the index of the selected outfit, or nil if none
---------------------------------------------------------------------------------
function Wardrobe.FindSelectedOutfit()
	local outfitNum = nil;
	for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
		if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Selected) then
			outfitNum = i;
			break;
		end
	end

	return outfitNum;	
end


---------------------------------------------------------------------------------
-- Tag this outfit to be worn when mounted
---------------------------------------------------------------------------------
function Wardrobe.SetMountedOutfit(outfitName)
	local outfitNumber;
	for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
		Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Special = "";
		if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName == outfitName) then
			outfitNumber = i;
		end
	end
	if (not outfitNumber) then
		Wardrobe.Print(TEXT("TXT_UNABLETOFINDOUTFIT").." \""..outfitName..".\"");
	else
		Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNumber].Special = "mounted";
		Wardrobe.Print(TEXT("TXT_OUTFIT").." \""..outfitName.."\" "..TEXT("TXT_WILLBEWORNWHENMOUNTED"));
	end
end


---------------------------------------------------------------------------------
-- See if we're mounted
---------------------------------------------------------------------------------
function Wardrobe.PlayerIsMounted()
	if (not IsMounted) then return end
	return UnitIsMounted("player");
end

function Wardrobe.CheckForMounted()
	--Sea.io.print("CheckForMounted");
	if (not IsMounted) then return end
	local mounted = Wardrobe.PlayerIsMounted();
	Wardrobe.EventTaskToggle(mounted, "MountState", "mount", "unmount");
end


---------------------------------------------------------------------------------
-- See if we're eating/drinking
---------------------------------------------------------------------------------
function Wardrobe.PlayerIsEatingOrDrinking()
	-- check our buffs for an eat or drink buff
	for i = 1, 16 do
		local texture = UnitBuff("player", i);
		if (texture) then
			if (string.find(texture,"INV_Misc_Fork") or string.find(texture,"INV_Drink")) then
				return 1;
			end
		end
	end
end

function Wardrobe.CheckForEatDrink()
	local chowing = Wardrobe.PlayerIsEatingOrDrinking();
	Wardrobe.EventTaskToggle(chowing, "ChowingState", "eating", "uneating");
end

---------------------------------------------------------------------------------
-- See if we switched into or out of the plaguelands
---------------------------------------------------------------------------------

function Wardrobe.PlayerIsInPlagueZone()
	local currZone = GetZoneText();
	Wardrobe.CurrentZone = currZone;
	local plaguezones = Wardrobe.GetPlagueZones();
	for i = 1, table.getn(plaguezones) do
		if (currZone == plaguezones[i]) then
			return 1;
		end
	end
end

function Wardrobe.ChangedZone()
	if (Wardrobe.CurrentZone ~= GetZoneText()) then
		local inPlagueZone = Wardrobe.PlayerIsInPlagueZone();
		Wardrobe.EventTaskToggle(inPlagueZone, nil, "plague", "unplague");
	end
end

---------------------------------------------------------------------------------
-- See if we're swimming, or at least if the breath bar is up.
---------------------------------------------------------------------------------
function Wardrobe.PlayerIsSwimming()
	local breathBar;
	for i=1,3 do
		breathBar = getglobal("MirrorTimer"..i.."Text");
		if (breathBar:IsVisible()) and (breathBar:GetText() == BREATH_LABEL) then
			return 1;
		end
	end
end

function Wardrobe.CheckForSwimming()
	local swimming = Wardrobe.PlayerIsSwimming();
	Wardrobe.EventTaskToggle(swimming, nil, "swim", "unswim");
end

---------------------------------------------------------------------------------
-- Wear the outfit specially tagged as indicated
---------------------------------------------------------------------------------
function Wardrobe.WearSpecialOutfit(specialID, virtualOutfitName, wearIt)

	Wardrobe.CheckForOurWardrobeID();
		
	local outfitNumber;
	for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
		if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Special == specialID) then
			outfitNumber = i;
			break;
		end
	end

	if (outfitNumber) then
		if (wearIt) then
			-- remember what we're wearing before we put on the special outfit
			Wardrobe.StoreVirtualOutfit(virtualOutfitName, outfitNumber);
			-- wear our special outfit
			Wardrobe.WearOutfit(outfitNumber, true);
		else
			-- re-equip the virtual outfit
			Wardrobe.CheckForEquipVirtualOutfit(virtualOutfitName);
		end
	end
end

---------------------------------------------------------------------------------
-- Trigger special outfits or add task to task list based on event trigger
---------------------------------------------------------------------------------

function Wardrobe.EventTaskToggle(value, variableName, trueTaskID, falseTaskID)
	
	local taskID;
	-- toggle the state and schedule wearing our tasked outfit
	if (variableName) then
		--Sea.io.print("Value: ", value, " ", variableName, " ", Wardrobe[variableName]);
		if (value) and (not Wardrobe_Config[variableName]) then
			taskID = trueTaskID;
		elseif (not value) and (Wardrobe_Config[variableName]) then
			taskID = falseTaskID;
		end
	else
		if (value) then
			taskID = trueTaskID;
		else
			taskID = falseTaskID;
		end
	end
	
	if (taskID) then
		local taskInfo = Wardrobe.WaitingListVirtualNames[taskID];
		if (variableName) then
			Wardrobe_Config[variableName] = taskInfo.toggle;
		end
		if (Wardrobe.IsPlayerInCombat()) then
			Wardrobe.AddToWaitingList(taskID);
		else	
			local eventID = taskInfo.id;
			Wardrobe.WearSpecialOutfit(eventID, Wardrobe.SpecialOutfitVirtualNames[eventID], taskInfo.toggle);
		end	
	end
   
end

---------------------------------------------------------------------------------
-- Waiting Task List Functions
---------------------------------------------------------------------------------

function Wardrobe.AddToWaitingList(theTask)
	--Sea.io.print("Adding "..theTask.." to waiting list!");
	table.insert(Wardrobe.WaitingList, theTask);
end


function Wardrobe.CheckWaitingList()
	--Sea.io.print("Checking Wardrobe.WaitingList: "..asText(Wardrobe.WaitingList));
	for i = 1, table.getn(Wardrobe.WaitingList) do
		local theTask = table.remove(Wardrobe.WaitingList, 1);
		--Sea.io.print("Popped "..theTask.." from waiting list!");
		local taskID;
		for taskName, taskInfo in Wardrobe.WaitingListVirtualNames do
			if (theTask == taskName) then
				--Sea.io.print("Putting on ".. taskName.." from virtual outfits.");
				Wardrobe.WearSpecialOutfit(taskInfo.id, Wardrobe.SpecialOutfitVirtualNames[taskInfo.id], taskInfo.toggle);
				break;
			end
		end
	end
end


---------------------------------------------------------------------------------
-- Store what we're currently wearing in a virtual outfit
---------------------------------------------------------------------------------
function Wardrobe.StoreVirtualOutfit(virtualOutfitName, currentOutfitName)

	local currentOutfitNum;
	if (type(currentOutfitName) == "number") then
		currentOutfitNum = currentOutfitName;
	else
		currentOutfitNum = Wardrobe.GetOutfitNum(currentOutfitName);
	end
	
	Wardrobe.ItemCheckState = { };
	local outfit = Wardrobe_Config[WD_realmID][WD_charID].Outfit[currentOutfitNum];
	for i = 1, Wardrobe.InventorySlotsSize do
		local item = outfit.Item[i];
		if (item) and (item.IsSlotUsed == 1) then
			Wardrobe.ItemCheckState[i] = 1;
		end
	end	
	
	local newOutfitNum = Wardrobe.GetNextFreeOutfitSlot(true);
	
	-- this new outfit will remember what we're about to remove in order to wear our special outfit
	Wardrobe.StoreItemsInOutfit(virtualOutfitName, newOutfitNum);

	-- set this outfit to virtual so it'll be hidden and not show up as a normal outfit
	Wardrobe_Config[WD_realmID][WD_charID].Outfit[newOutfitNum].Virtual = true;
end


---------------------------------------------------------------------------------
-- If we have a virtual outfit, wear it and delete it
---------------------------------------------------------------------------------
function Wardrobe.CheckForEquipVirtualOutfit(virtualOutfitName)

	if (not virtualOutfitName) then
		virtualOutfitName = WARDROBE_TEMP_OUTFIT_NAME;
	end
	
	if (Wardrobe.FoundOutfitName(virtualOutfitName)) then
		Wardrobe.WearOutfit(virtualOutfitName, true);
		Wardrobe.EraseOutfit(virtualOutfitName, true, true);
	end
end


---------------------------------------------------------------------------------
-- Update whether we have all the items for our outfits in our bags
---------------------------------------------------------------------------------
function Wardrobe.UpdateOutfitAvailability()

	if (Wardrobe_Config.Enabled and not Wardrobe.InCombat) then
	
		-- if we haven't already looked up our character's number
		Wardrobe.CheckForOurWardrobeID();

		Wardrobe.Debug("Wardrobe Availability:");
		
		local masterItemList = Wardrobe.BuildItemList();
	
		-- for each outfit
		--for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
		for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do

			-- if it has a name
			if (outfit.OutfitName) and (outfit.OutfitName ~= "") then

				local foundAllItems = true;

				-- for each item in the outfit
				--for j = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item) do
				for j, item in outfit.Item do

					-- if this slot is used in this outfit
					if (item) and (item.IsSlotUsed == 1) then
					
						if (item.ItemID) and (item.Suffix) and (item.PermEnchant) then
							local foundTheItem = false;
							for k = 1, table.getn(masterItemList) do
								if (item.ItemID == masterItemList[k].ItemID) and (item.Suffix == masterItemList[k].Suffix) and (item.PermEnchant == masterItemList[k].PermEnchant) then
									foundTheItem = true;
									break;
								end
							end
							if (not foundTheItem) then 
								foundAllItems = false;
								break;
							end
						
						elseif (item.Name) and (item.Name ~= "") then

							local foundTheItem = false;
							for k = 1, table.getn(masterItemList) do
								--{Name = itemName, ItemID = itemID, TempEnchant = tempEnchant}
								if (item.Name == masterItemList[k].Name) then
									foundTheItem = true;
									break;
								end
							end
							if (not foundTheItem) then 
								foundAllItems = false;
								break;
							end
						end
					end	
				end

				-- if we found all items in our inventory
				outfit.Available = foundAllItems;
				Wardrobe.Debug("   Outfit \"".. outfit.OutfitName.."\" -- found all items = "..tostring(foundAllItems));
			end
		end
	end
end


---------------------------------------------------------------------------------
-- Determine which outfit we're currently wearing
---------------------------------------------------------------------------------
function Wardrobe.DetermineActiveOutfit()

	Wardrobe.Debug("Wardrobe.DetermineActiveOutfit: Updating Active Outfit");
	local ActiveOutfitList = { };
	local foundOutfit = false;
	
	-- build a reference table of the currently equipped items
	Wardrobe.CurrentlyEquippedItemList = { };
	for j = 1, Wardrobe.InventorySlotsSize do
		local itemID, permEnchant, tempEnchant, suffix, itemName = Wardrobe.GetItemInfoAtInventorySlotNumber(j);
		if (itemID) then
			Wardrobe.CurrentlyEquippedItemList[j] = {Name = itemName, ItemID = itemID, PermEnchant = permEnchant, TempEnchant = tempEnchant, Suffix = suffix};
		end
	end	

	-- for each outfit
	for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do
	
		Wardrobe.Debug("  Working on outfit "..i..": "..outfit.OutfitName);
		
		foundOutfit = true;
		
		-- for each slot on our character (hands, neck, head, feet, etc)
		for j = 1, Wardrobe.InventorySlotsSize do
			local item = outfit.Item[j];
			-- if this slot is used in this outfit
			if (item) and (item.IsSlotUsed == 1) then
				local thisItem = Wardrobe.CurrentlyEquippedItemList[j];
				-- if this item is different from what we're already wearing
				Wardrobe.Debug("	Working on slot -> "..Wardrobe.InventorySlots[j]);
				-- item in inv slot
				if (thisItem) and (thisItem.Name) then
					Wardrobe.Debug("	   Comparing ["..tostring(item.Name).."] with ["..tostring(thisItem.Name).."]");
					if (item.ItemID) and (item.Suffix) and (item.PermEnchant) then
						if (item.ItemID ~= thisItem.ItemID) or (item.Suffix ~= thisItem.Suffix) or (item.PermEnchant ~= thisItem.PermEnchant) then
							foundOutfit = false;
							break;
						end
					elseif (item.Name) and (item.Name ~= "") then
						if (item.Name ~= thisItem.Name) then
							foundOutfit = false;
							break;
						end
					else
						-- Forced empty slot
						foundOutfit = false;
						break;
					end
				
				-- no item in inv slot
				elseif (item.Name) and (item.Name ~= "") then
					foundOutfit = false;
					break;
				end
			end
		end
		
		if (foundOutfit) then
			table.insert(ActiveOutfitList, i);
		end
	end
	
	return ActiveOutfitList;	 
end


function Wardrobe.GetActiveOutfitsTextList()
	local activeOutfitList = Wardrobe.DetermineActiveOutfit();
	local outfitText = "";
	local outfits = Wardrobe_Config[WD_realmID][WD_charID].Outfit;
	for i, outfitID in activeOutfitList do
		-- don't match special outfits
		local buttonColorTable = WARDROBE_TEXTCOLORS[outfits[outfitID].ButtonColor];
		local name = outfits[outfitID].OutfitName;
		if (strsub(name, 1, 1) ~= "#") then
			outfitText = outfitText..", |c"..Wardrobe.colorToString(buttonColorTable)..name.."|r";
		end
	end
	if (outfitText == "") then
		return TEXT("TXT_NO_OUTFIT");
	else
		return strsub(outfitText, 3);
	end
end

function Wardrobe.GetListOfOutfits()
	Wardrobe.CheckForOurWardrobeID();
	Wardrobe.UpdateOutfitAvailability();
	local activeOutfits = Wardrobe.DetermineActiveOutfit();
	Wardrobe.ActiveOutfitList = activeOutfits;
	local outfitTable = {};
	for i, outfit in Wardrobe_Config[WD_realmID][WD_charID].Outfit do
		local nameString = outfit.OutfitName;
		if (strsub(nameString, 1, 1) ~= "#") then
			if ( Wardrobe.isInList(activeOutfits, i) ) then 
				nameString = "|c"..Wardrobe.colorToString(WARDROBE_TEXTCOLORS[outfit.ButtonColor])..nameString.."|r";
			elseif ( outfit.Available ) then
				nameString = "|c"..Wardrobe.colorToString(WARDROBE_DRABCOLORS[outfit.ButtonColor])..nameString.."|r";
			else
				nameString = "|c"..Wardrobe.colorToString(WARDROBE_UNAVAILIBLECOLOR)..nameString.."|r";
			end
			
			tinsert(outfitTable, nameString);
		end
	end
	return outfitTable;
end

--============================================================================================--
--============================================================================================--
--																							--
--							  UTILITY FUNCTIONS											 --
--																							--
--============================================================================================--
--============================================================================================--


-----------------------------------------------------------------------------------
-- for in-line coloring (from Sea)
-----------------------------------------------------------------------------------
function Wardrobe.colorToString( color )
	if ( not color ) then 
		return "FFFFFFFF";
	end
	return format( "%.2X%.2X%.2X%.2X", 255, color[1]*255, color[2]*255, color[3]*255 );
end

-----------------------------------------------------------------------------------
-- value comparison, returns key/index
-----------------------------------------------------------------------------------
function Wardrobe.isInList( list, value )
	if ( not list or not value ) then 
		return;
	end
	for k, v in list do
		if (v == value) then
			return k;
		end
	end
end

-----------------------------------------------------------------------------------
-- Our own print function
-----------------------------------------------------------------------------------
function Wardrobe.Print(theMsg, r, g, b)
	
	-- 0.50, 0.50, 1.00
	if (not r) then r = 0.50; end
	if (not g) then g = 0.50; end
	if (not b) then b = 1.00; end

	if (type(theMsg) == "table") then
		Print(asText(theMsg), r, g, b);
	else
		Print(theMsg, r, g, b);
	end
end


-----------------------------------------------------------------------------------
-- Toggle the plugin on and off
-----------------------------------------------------------------------------------
function Wardrobe.Toggle(toggle)
	if (toggle == 1) then
		if (not Khaos) then
			Wardrobe.Print(TEXT("TXT_ENABLED"));
		end
		Wardrobe_Config.Enabled = true;
		Wardrobe.TitanUpdateMinimapStatus(true);
	else
		if (not Khaos) then
			Wardrobe.Print(TEXT("TXT_DISABLED"));
		end
		Wardrobe_Config.Enabled = false;
		Wardrobe.TitanUpdateMinimapStatus(false);
	end
end


-----------------------------------------------------------------------------------
-- Nifty little function to view any lua object as text
-----------------------------------------------------------------------------------
function asText(obj)

	visitRef = {}
	visitRef.n = 0

	asTxRecur = function(obj, asIndex)
		if type(obj) == "table" then
			if visitRef[obj] then
				return "@"..visitRef[obj]
			end
			visitRef.n = visitRef.n +1
			visitRef[obj] = visitRef.n

			local begBrac, endBrac
			if asIndex then
				begBrac, endBrac = "[{", "}]"
			else
				begBrac, endBrac = "{", "}"
			end
			local t = begBrac
			local k, v = nil, nil
			repeat
				k, v = next(obj, k)
				if k ~= nil then
					if t > begBrac then
						t = t..", "
					end
					t = t..asTxRecur(k, 1).."="..asTxRecur(v)
				end
			until k == nil
			return t..endBrac
		else
			if asIndex then
				-- we're on the left side of an "="
				if type(obj) == "string" then
					return obj
				else
					return "["..obj.."]"
				end
			else
				-- we're on the right side of an "="
				if type(obj) == "string" then
					return '"'..obj..'"'
				else
					return tostring(obj)
				end
			end
		end
	end -- asTxRecur

	return asTxRecur(obj)
end -- asText


---------------------------------------------------------------------------------
-- Display the help text
---------------------------------------------------------------------------------
function Wardrobe.ShowHelp()
	Wardrobe.Print(TEXT("HELP_1")..WARDROBE_VERSION);
	Wardrobe.Print(TEXT("HELP_2"));
	Wardrobe.Print(TEXT("HELP_3"));
	Wardrobe.Print(TEXT("HELP_4"));
	Wardrobe.Print(TEXT("HELP_5"));
	Wardrobe.Print(TEXT("HELP_6"));
	Wardrobe.Print(TEXT("HELP_7"));
	Wardrobe.Print(TEXT("HELP_8"));
	Wardrobe.Print(TEXT("HELP_9"));
	Wardrobe.Print(TEXT("HELP_10"));
	Wardrobe.Print(TEXT("HELP_11"));
	Wardrobe.Print(TEXT("HELP_12"));
	Wardrobe.Print(TEXT("HELP_13"));
	Wardrobe.Print(TEXT("HELP_14"));
	Wardrobe.Print(TEXT("HELP_15"));
	Wardrobe.Print(TEXT("HELP_16"));
end



--============================================================================================--
--============================================================================================--
--																							--
--							  DEBUG FUNCTIONS											   --
--																							--
--============================================================================================--
--============================================================================================--


-----------------------------------------------------------------------------------
-- Print out a debug statement if the WARDROBE_DEBUG flag is set
-----------------------------------------------------------------------------------
function Wardrobe.Debug(theMsg)
	if (WARDROBE_DEBUG) then
		ChatFrame1:AddMessage(theMsg, 1.0, 1.0, 0.7);
	end
end


---------------------------------------------------------------------------------
-- Toggle debug output
---------------------------------------------------------------------------------
function Wardrobe.ToggleDebug()
	WARDROBE_DEBUG = not WARDROBE_DEBUG;
	if (WARDROBE_DEBUG) then
		Print("Wardrobe: Debug ON",1.0,1.0,0.5);
	else
		Print("Wardrobe: Debug OFF",1.0,1.0,0.5);
	end	
end


---------------------------------------------------------------------------------
-- Debug routine to print the current state of the plugin
---------------------------------------------------------------------------------
function Wardrobe.DumpDebugReport()
	
	Wardrobe.CheckForOurWardrobeID();
	
	Wardrobe.Debug("Wardrobe.DumpDebugReport: Character's wardrobe database");
	local WardrobeDatabase = Wardrobe_Config[WD_realmID][WD_charID];
	for outfitNum, outfit in WardrobeDatabase.Outfit do
		Wardrobe.Debug("Outfit: "..tostring(outfit.OutfitName));
		for i, item in outfit.Item do
			if (item) then
				Wardrobe.Debug(Wardrobe.InventorySlots[i].." = "..tostring(item.Name));
			end
		end
	end
end



---------------------------------------------------------------------------------
-- Print a debug report
---------------------------------------------------------------------------------
function Wardrobe.DumpDebugStruct()
	for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
		Print("Outfit #"..i..":");
		Print(asText(Wardrobe_Config[WD_realmID][WD_charID].Outfit[i]));
		Print("--------------------");
	end
end


