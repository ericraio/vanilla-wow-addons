--[[
GuildTools v 2.4

Addon that allows you to store in game info into SV.lua for further parsing.
Contains: 
BankScan     - scans all posessions of the character, including bank, bags amd bags in bank.
IncomingMail - grabs all the nonCOD items and money from mailbox as soon as it's opened. 
               Also keeps track of all the incoming mail including sender, item sent, money sent
			   and date when the message was received.
			   
Author: Roman Tarakanov (RTE/Arthas)
Date: Mar 28 '06

]]--
---------------------------------------------------------------
----------------------Standart mesages-------------------------
---------------------------------------------------------------

local GT_VER    = "2.4";
local GT_BS_VER = "2.3";
local GT_IM_VER = "2.3";

local MSG_GT_GREETING1 = "GuildTools v" .. GT_VER .. " is loaded.";
local MSG_GT_GREETING2 = "For more information type /gts info.";
local MSG_GT_GREETING = "GuildTools v" .. GT_VER .. ".";
local MSG_BS_GREETING = "BankScan v" .. GT_BS_VER .. ".";
local MSG_IM_GREETING = "IncomingMail v" .. GT_IM_VER .. ".";

local MSG_GT_ADDONOFF = "GT> AddOn is turned off, use /gts on to turn it on for this character";
local MSG_GT_ON = "GT> AddOn is now ENABLED for this character";
local MSG_GT_OFF = "GT> AddOn is now DISABLED for this character";
local MSG_GT_CLEARED = "GT> Variables have been cleared.";
local MSG_GT_INVALID = "GT> Not a valid command. See /gts info for list of commands.";
local MSG_DEBUG_ON = "GT> Debug mode is now ENABLED for this character";
local MSG_DEBUG_OFF = "GT> Debug mode is now DISABLED for this character";

local MSG_BS_ON = "GT> BankScan part of this AddOn is now ENABLED for this character";
local MSG_BS_OFF = "GT> BankScan part of this AddOn is now DISABLED for this character";
local MSG_BS_SORTON = "GT> BankScan's sort function is ENABLED";
local MSG_BS_SORTOFF = "GT> BankScan's sort function is DISABED";
local MSG_BS_OK = "GT> BankScan | Success : prescan was successful, now you can run finalize to save the data";
local MSG_BS_DONE = "GT> BankScan | Success : finilize was successful, now you can log out and run BankParser.exe to get html file";
local MSG_BS_BANKCLOSED = "GT> BankScan | Error : bank must be opened for this script to work.";

local MSG_IM_ON = "GT> IncomingMail part of this AddOn is now ENABLED for this character";
local MSG_IM_OFF = "GT> IncomingMail part of this AddOn is now DISABLED for this character";
local MSG_IM_START = "GT> IncomingMail started taking mail. Please do not do anything.";
local MSG_IM_CANCELED = "GT> IncomingMail grabbing procedure was canceled, some of the data might be corupted.";
local MSG_IM_SUCCESS = "GT> IncomingMail successfully grabbed your mail.";
local MSG_IM_SAVED = "GT> Mailed items database have been saved in SV. You can now run MailParser to get html file.";
local MSG_IM_CLEARED = "GT> IncomingMail varibles are cleared.";
local MSG_IM_NOBAG = "GT> There are no empy slots in your bags. Canceling IncomingMail.";

---------------------------------------------------------------
----------------Global GuildTools variables--------------------
---------------------------------------------------------------

--BankOpen indicator
-- 0 - bank closed
-- 1 - bank opened
local BankStatus = 0;
--Position in the array GT_Saved of the current character 
-- -1 - not in array
local Position=-1;
--Debug mode indicator 
-- 1 - debug mode on
-- 0 - debug mode off (default)
local DebugMode = 0;

---------------------------------------------------------------
------------------Global BankScan variables--------------------
---------------------------------------------------------------

--List of the bags to look in
local BanknBags = { -1, 5, 6, 7, 8, 9, 10, 0, 1, 2, 3, 4};
local MoneyScanned = 1;

---------------------------------------------------------------
---------------Global IncomingMail variables-------------------
---------------------------------------------------------------

local MailOpened = false;
local State = 0;

local availableSlots = {};
local numSlots = 0;
local emptySlots = 0;
local currentMessage = 1;
local From = 0;
local To = 0;

---------------------------------------------------------------
----------------Global GuildTools functions--------------------
---------------------------------------------------------------
function GT_Bsclear()
		if (GT_Saved[Position].addonOn) then
			--GT_Saved = {};
			GT_BS_ScannedItems = {};
			GT_BS_PreScannedItems = {};
			GT_BS_Money = 0;
			GT_IM_Saved = {};
			GT_IM_MailedItems[Position] = {};
			GT_IM_NumMailedItems[Position] = 0;
			GT_Echo(MSG_GT_CLEARED);
		else
			GT_Echo(MSG_ADDONOFF);
		end
end

function GT_On()
	GT_Saved[Position].addonOn = true;
	GT_Echo(MSG_GT_ON);
end

function GT_Bson()
	GT_Saved[Position].BSOn = true;		
	GT_Echo(MSG_BS_ON);
end

function GT_Bscan()
		if (GT_Saved[Position].BSOn) then
			NumItems = 1;
			if (BankStatus == 1) then
				GT_BS_PreScannedItems = {};
				GT_Debug("GT_BS_DoScan is called.");
				GT_BS_DoScan();
				GT_Debug("GT_BS_DoScan exited.");
				GT_BS_Money = " "..GetMoney().." ";
				GT_BS_Finalize();
				GT_Echo(MSG_BS_DONE);
			else
				GT_Echo(MSG_BS_BANKCLOSED);
			end
		else
			GT_Echo(MSG_ADDONOFF);
		end
end

function GT_RegisterUltimateUI()
	UltimateUI_RegisterConfiguration(
		"UUI_GT",
		"SECTION",
		"Guild Tools",
		"Shortcuts to use Guild Tools."
	);
	UltimateUI_RegisterConfiguration(
		"UUI_GT_SEPARATOR",
		"SEPARATOR",
		"Guild Tools",
		"Shortcuts to use Guild Tools."
	);
	UltimateUI_RegisterConfiguration(
		"UUI_GT_CLEAR",
		"BUTTON",
		"",
		"",
		GT_Bsclear,
		0,
		0,
		0,
		0,
		"/gts bsclear"
	);
	UltimateUI_RegisterConfiguration(
		"UUI_GT_CLEAR",
		"BUTTON",
		"",
		"",
		GT_On,
		0,
		0,
		0,
		0,
		"/gts on"
	);
	UltimateUI_RegisterConfiguration(
		"UUI_GT_CLEAR",
		"BUTTON",
		"",
		"",
		GT_Bson,
		0,
		0,
		0,
		0,
		"/gts bson"
	);
	UltimateUI_RegisterConfiguration(
		"UUI_GTT_SEPARATOR",
		"SEPARATOR",
		"Scan!",
		"Scan button below!"
	);
	UltimateUI_RegisterConfiguration(
		"UUI_GT_CLEAR",
		"BUTTON",
		"",
		"",
		GT_Bscan,
		0,
		0,
		0,
		0,
		"/gts bscan"
	);
end


--OnEvent function
function GT_OnEvent()	 
	GT_Debug("OnEvent is called");

	if (event == "VARIABLES_LOADED") then
		GT_Debug("Variables are loaded.");
		GT_RegisterUltimateUI();
		SlashCmdList["GUILDTOOLS"] = GT_SlashCommand;
		SLASH_GUILDTOOLS1 = "/guildtools";
		SLASH_GUILDTOOLS2 = "/gts";
		
		--GT_Saved = {};
		--GT_BS_ScannedItems = {};
		--GT_IM_MailedItems = {};
		--GT_IM_NumMailedItems = {};
		
		--Saved variables of the AddOn
		--Initialize if blank		
		if (not GT_Saved) then
            GT_Saved = {};
		end
		
		--Find varibles in GT_Saved if exist
		local i;
		GT_Debug("GT_Saved size: "..table.getn(GT_Saved));
		if (GT_Saved) then
			for  i = 1, table.getn(GT_Saved), 1 do
				if (string.find(GT_Saved[i].name, UnitName("player")) and string.find(GT_Saved[i].server, GetCVar("realmName"))) then
					if (not GT_Saved[i].addonOn) then GT_Saved[i].addonOn=false; end
					if (not GT_Saved[i].BSOn) then GT_Saved[i].BSOn=false; end
					if (not GT_Saved[i].mailOn) then GT_Saved[i].mailOn=false; end
					Position = i;
				end
			end
		end
		
		--If new character is observed - initialize the data.
		--On new character AddOn and mail grabber part (future functionality) are off by default
		if (Position == -1) then
			if (GT_Saved) then
				i = table.getn(GT_Saved)+1;
			else
				i = 1;
			end		
			GT_Saved[i] = { name=UnitName("player"), server=GetCVar("realmName"), 
				mailOn=false, addonOn=false, BSOn=false, BSSort=1};
			Position = i;
		end
		
		GT_Debug("Position: "..Position);
		GT_Echo(MSG_GT_GREETING1);
		GT_Echo(MSG_GT_GREETING2);
		
		if (not GT_IM_Saved) then GT_IM_Saved = {}; end
		if (not GT_IM_NumMailedItems) then GT_IM_NumMailedItems = {}; end
		if (not GT_IM_MailedItems) then GT_IM_MailedItems = {}; end
		if (not GT_IM_NumMailedItems[Position]) then GT_IM_NumMailedItems[Position] = 0; end
		if (not GT_IM_MailedItems[Position]) then GT_IM_MailedItems[Position] = {}; end
		if (not GT_BS_PreScannedItems) then GT_BS_PreScannedItems = {}; end
		if (not GT_BS_Money) then GT_BS_Money = 0; MoneyScanned = nil; end
		
	elseif (event == "BANKFRAME_OPENED") then
		GT_Debug("Bank was opened.");
		BankStatus = 1;

	elseif (event == "BANKFRAME_CLOSED") then
		GT_Debug("Bank was closed.");		
		BankStatus = 0;
	
	elseif (not GT_Saved[Position].addonOn) then return; 
	
	elseif (event == "MAIL_SHOW") then
		if (GT_Saved[Position].mailOn) then
			MailOpened = true;
			State = 0;
			GT_Echo(MSG_IM_START);
			GT_IM_ScanSlots();
		end
		
	elseif (event == "MAIL_CLOSED") then
		if (GT_Saved[Position].mailOn) then
			GT_Debug("State = "..State);
			if (State < 11 and State ~= -99) then GT_Echo(MSG_IM_CANCELED); end
			MailOpened = false;
			State = -99;
			GT_IM_Message:Hide();
			GT_IM_Update:Hide();
		end
		
	elseif (event == "MAIL_INBOX_UPDATE") then
		if (GT_Saved[Position].mailOn) then
			GT_Debug("grab!!!!!");
			GT_IM_Update:Show();
		end
		
	elseif (event == "BAG_UPDATE") then
		if (GT_Saved[Position].addonOn and GT_Saved[Position].mailOn) then
			GT_IM_ScanItems();
		end		
	end
end

--Slash command handler
function GT_SlashCommand(msg)
	msg = string.lower(msg);
	GT_Debug("/command: "..msg);

---------------------------------------------------------------
------------------GT standart commands-------------------------
---------------------------------------------------------------
	if (msg == "on") then
		GT_Saved[Position].addonOn = true;
		GT_Echo(MSG_GT_ON);
		
	elseif (msg == "off") then
		GT_Saved[Position].addonOn = false;
		GT_Echo(MSG_GT_OFF);
		
	elseif (msg == "debug") then
		
		if (DebugMode == 1) then
			GT_Echo(MSG_DEBUG_OFF);
			DebugMode = 0;
		else
			GT_Echo(MSG_DEBUG_ON);
			DebugMode = 1;
		end
		
	elseif (msg == "status") then
		if (GT_Saved[Position].addonOn) then
			
			local status = "DISABLED";
			if (GT_Saved[Position].addonOn) then 
				status = "ENABLED";
			end
			GT_Echo("GT> AddOn  is "..status..", see /gts info for information on the AddOn.");
			
			status = "DISABLED";
			if (GT_Saved[Position].BSOn) then 
				status = "ENABLED";
			end
			GT_Echo("GT> BankScan is "..status..", see /gts bsinfo for list of commands.");
			
			status = "DISABLED";
			if (GT_Saved[Position].mailOn) then 
				status = "ENABLED";
			end
			GT_Echo("GT> MailGrabber is "..status..", see /gts iminfo for list of commands.");
			
			status = "DISABLED";
			if (DebugMode == 1) then 
				status = "ENABLED";
			end
			GT_Echo("GT> Debug mode is "..status..".");
			
		else
			GT_Echo(MSG_ADDONOFF);
		end
		
	elseif (msg == "info") then
		GT_Echo(MSG_GT_GREETING);
		GT_Echo("GT> Scans possesions of the char, including bank into SV.lua.");
		GT_Echo("GT> List of components:");
		GT_Echo("GT> BankScan - scanns possesions of char. See /gts bsinfo for more info.");
		GT_Echo("GT> IncomingMail - tracks incoming mail. See /gts iminfo for more info.");
		GT_Echo("GT> -------------------------------------------------------------------");
		GT_Echo("GT> Available commands:");
		GT_Echo("GT> /gts status   shows the status of GuildTools and components.");
		GT_Echo("GT> /gts <on/off> turns the GuildTools on/off for this char.");
		GT_Echo("GT> /gts clear    clears all saved variables for this addon. If used all data will be lost.");
		GT_Echo("GT> /gts debug    tuggles Debug Mode on/off.");
		GT_Echo("GT> /gts info     shows this screen.");
		
	elseif (not GT_Saved[Position].addonOn) then
		GT_Echo(MSG_GT_ADDONOFF);
		return;
		
	elseif (msg == "clear") then
		if (GT_Saved[Position].addonOn) then
			--GT_Saved = {};
			GT_BS_ScannedItems = {};
			GT_BS_PreScannedItems = {};
			GT_BS_Money = 0;
			GT_IM_Saved = {};
			GT_IM_MailedItems[Position] = {};
			GT_IM_NumMailedItems[Position] = 0;
			GT_Echo(MSG_GT_CLEARED);
		else
			GT_Echo(MSG_ADDONOFF);
		end
		
	elseif (msg == "vars") then
		if (MailOpened) then 
			GT_Debug("MailOpened: true"); 
		else 
			GT_Debug("MailOpened: false"); 
		end
		GT_Debug("State: "..State);
		GT_Debug("From = "..From..", To = "..To);
		
---------------------------------------------------------------
-------------------------BS commands---------------------------
---------------------------------------------------------------
	elseif (msg == "bs") then
		local status = "DISABLED";
		if (GT_Saved[Position].BSOn) then 
			status = "ENABLED";
		end
		GT_Echo(MSG_BS_GREETING1);
		GT_Echo("GT> BankScan BankScan is "..status..", see /gts bsinfo for list of commands.");
		
	elseif (msg == "bson") then
		GT_Saved[Position].BSOn = true;		
		GT_Echo(MSG_BS_ON);
		
	elseif (msg == "bsoff") then
		GT_Saved[Position].BSOn = false;
		GT_Echo(MSG_BS_OFF);
		
	elseif (msg == "bssort") then
		if (GT_Saved[Position].BSSort==1) then
			GT_Saved[Position].BSSort=2;		
			GT_Echo(MSG_BS_SORTOFF);
		else
			GT_Saved[Position].BSSort=1;		
			GT_Echo(MSG_BS_SORTON);
		end
		
	elseif (msg == "bscan") then
		if (GT_Saved[Position].BSOn) then
			NumItems = 1;
			if (BankStatus == 1) then
				GT_BS_PreScannedItems = {};
				GT_Debug("GT_BS_DoScan is called.");
				GT_BS_DoScan();
				GT_Debug("GT_BS_DoScan exited.");
				GT_BS_Money = " "..GetMoney().." ";
				GT_BS_Finalize();
				GT_Echo(MSG_BS_DONE);
			else
				GT_Echo(MSG_BS_BANKCLOSED);
			end
		else
			GT_Echo(MSG_ADDONOFF);
		end
		
	elseif (msg == "bsprescan") then
		if (GT_Saved[Position].BSOn) then
			NumItems = 1;
			if (BankStatus == 1) then
				if (not MoneyScanned) then GT_Debug("Clear money"); GT_BS_Money = 0; end
				GT_BS_Money = GT_BS_Money+GetMoney();
				MoneyScanned = 1;
				GT_Debug("GT_BS_DoScan is called.");
				GT_BS_DoScan();
				GT_Debug("GT_BS_DoScan exited.");
				GT_Echo(MSG_BS_OK);
			else
				GT_Echo(MSG_BS_BANKCLOSED);
			end
		else
			GT_Echo(MSG_ADDONOFF);
		end	
		
	elseif (msg == "bsfinal") then
		if (GT_Saved[Position].BSOn) then
			GT_BS_Money = " "..GT_BS_Money.." ";
			GT_BS_Finalize();
			GT_Echo(MSG_BS_DONE);
		else
			GT_Echo(MSG_ADDONOFF);
		end
		
	elseif (msg == "bsinfo") then
		GT_Echo(MSG_BS_GREETING);
		GT_Echo("GT> Scans possesions of the char, including bank into SV.lua.");
		GT_Echo("GT> Available commands:");
		GT_Echo("GT> /gts bs         shows the status of BankScan.");
		GT_Echo("GT> /gts bs<on/off> turns the BankScan on/off for this char.");
		GT_Echo("GT> /gts sort       tuggles the BankScan's sorting function on/off for this char.");
		GT_Echo("GT> /gts bscan      performs the scan of possesions of this char for parsing into SV.lua.");
		GT_Echo("GT> /gts bsprescan  performs the scan of possesions of this char and adds them to priviously scanned.");
		GT_Echo("GT> /gts bsfinal    sends all the scanned data from bsprescan for parsing into SV.lua.");
		GT_Echo("GT> /gts bsinfo     shows this screen.");
		
---------------------------------------------------------------
-------------------------IM commands---------------------------
---------------------------------------------------------------
	elseif (msg == "im") then
		local status = "DISABLED";
		if (GT_Saved[Position].addonOn) then 
			status = "ENABLED";
		end
		GT_Echo("GT> IncomingMail is "..status..", see /gts iminfo for list of commands.");
		
	elseif (msg == "imon") then
		GT_Saved[Position].mailOn = true;	
		GT_Echo(MSG_IM_ON);
		
	elseif (msg == "imoff") then
		GT_Saved[Position].mailOn = false;
		GT_Echo(MSG_IM_OFF);
		
	elseif (msg == "imsave") then
		GT_IM_Save();
		GT_Echo(MSG_IM_SAVED);
		
	elseif (msg == "imclear") then
		if (GT_Saved[Position].mailOn) then
			GT_IM_MailedItems[Position] = {};
			GT_IM_NumMailedItems[Position] = 0;		
			GT_Echo(MSG_IM_CLEARED);
		else
			GT_Echo(MSG_IMOFF);
		end
		
	elseif (msg == "iminfo") then
		GT_Echo(MSG_IM_GREETING1);
		GT_Echo("GT> Grabs all the nonCoD mail from your mailbox.");
		GT_Echo("GT> Also stores info about all the incoming mail in database.");
		GT_Echo("GT> Available commands:");
		GT_Echo("GT> /gts im         shows the status of IncomingMail.");
		GT_Echo("GT> /gts im<on/off> turns the IncomingMail on/off for this char.");
		GT_Echo("GT> /gts imsave     saves database of this char for parsing in SV.lua.");
		GT_Echo("GT> /gts imclear    clears database for this character (Saved with /gm imsave stays intact).");
		GT_Echo("GT> /gts iminfo     shows this screen.");
		
---------------------------------------------------------------
----------------------End of  commands-------------------------
---------------------------------------------------------------
	else
		GT_Echo(MSG_GT_INVALID);
		
	end
end

--Returns full info of the item on bag_id, slot_id, nil if item is not there
function GT_GetItemInfo(bag_id, slot_id)
	local count, texture, itemLink, itemName, i, command, itemQuality, itemDesc, itemType, itemSubType, itemId;
	
	if (not GetContainerItemInfo(bag_id, slot_id)) then 
		GT_Debug("No item in the slot "..bag_id..", "..slot_id);
		return nil;
	end
	
	--Get texture and count of the item in the current slot
	texture, count = GetContainerItemInfo(bag_id, slot_id);
	_,_,texture = string.find(texture, "%a+\\%a+\\([%w_]+)");
	
	--Get link and the name of the item in the current slot
	itemLink = GetContainerItemLink(bag_id, slot_id);
	_, _, itemLink, itemName = string.find(itemLink,
	"|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$");
	_, _, itemQuality, _, itemType, itemSubType = GetItemInfo(itemLink);
	
	GT_Debug("Link: "..itemLink);
	--Set tooltip to the current item
	GT_ItemTooltip:SetOwner(this,"ANCHOR_BOTTOMRIGHT");
	GT_ItemTooltip:ClearLines();
	GT_ItemTooltip:SetHyperlink(itemLink);
	
	--Copy the description test from the tooltip to the variable
	--<n> - new line symbol
	--<t> - tab symbol
	for i=1, GT_ItemTooltip:NumLines(),1 do
	
		command = getglobal("GT_ItemTooltipTextLeft" .. i);
		if (command:IsShown()) then
			text_left = command:GetText();
		else
			text_left = nil;
		end
		
		command = getglobal("GT_ItemTooltipTextRight" .. i);
		if (command:IsShown()) then
			text_right = command:GetText();
		else
			text_right = nil;
		end
		
		if (text_left and string.find(text_left, "\n")) then
			text_left = " ";
		end
		
		if (text_right and string.find(text_right, "\n")) then
			text_right = " ";
		end
		
		if (i == 1) then 
			itemDesc = text_left;
		else
			if (text_left) then 
				itemDesc = itemDesc.." <n> "..text_left;
			end
		end
		if (text_right) then
                  itemDesc = itemDesc.." <t> "..text_right;
		end
	end
	_,_,itemId = string.find(itemLink,"item:(%d+):%d+:%d+:%d+");
	GT_Debug("ID: "..itemId);
	return itemName, itemQuality, itemDesc, count, texture, itemType, itemSubType, itemId;
end

--Prints message into the text chat window
function GT_Echo(message)
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage(message, 0.5, 0.5, 1.0);
	end
end

--Prints debug message into the chat window iff local variable DebugMode is set to 1
--otherwise does nothing
function GT_Debug(message)
	if (DebugMode == 1) then
		message = "GT><**Debug**> " .. message;
		if ( DEFAULT_CHAT_FRAME ) then 
			DEFAULT_CHAT_FRAME:AddMessage(message, 1.0, 0.0, 0.0);
		end
	end
end

---------------------------------------------------------------
---------------------BankScan functions------------------------
---------------------------------------------------------------

--This function actually scans all bags for items
function GT_BS_DoScan()
	--Array of items that will be saved in SavedVariables.lua
	--Initiated as empty, if BankScan is not called during the session all data will be wiped upon logout
	GT_BS_ScannedItems = {};

	local index, bag_id, slot_id, count, texture, itemLink, itemName, i, command, itemQuality, itemDesc, itemType, itemSubType, itemId;

	--Go through every slot in the bags (and bank)
	for index, bag_id in BanknBags do
		if (GetContainerNumSlots(bag_id)) then
			for slot_id = 1, GetContainerNumSlots(bag_id), 1 do
				if (GetContainerItemLink(bag_id, slot_id)) then
					
					itemName, itemQuality, itemDesc, count, texture, itemType, itemSubType, itemId = GT_GetItemInfo(bag_id, slot_id);
					
					--Save info on current item in the array
					if (not GT_BS_PreScannedItems[itemName]) then
						GT_BS_PreScannedItems[itemName] = {description="  "..itemDesc.." ",
														number=count,
														pic=" "..texture.." ", 
														quality=itemQuality,
														subtype = " "..itemSubType.." ",
														type = " "..itemType.." ",
														id = " "..itemId.." "};
						--Sorting function
						if (GT_Saved[Position].BSSort == 1) then
							if(itemType=="Trade Goods") then 
								GT_BS_PreScannedItems[itemName].sort = 900;
								if (itemSubType=="Devices") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 36 - 300;
								elseif (itemSubType=="Explosives") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 35 - 300;
								elseif (itemSubType=="Parts") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 58;
								elseif (itemSubType=="Trade Goods") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 59;
								elseif (itemSubType=="Enchanting") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 57;
								end 
							elseif(itemType=="Reagent") then 
								GT_BS_PreScannedItems[itemName].sort = 895;
							elseif(itemType=="Weapon") then 
								GT_BS_PreScannedItems[itemName].sort = 700;
								if (itemSubType=="Fishing Pole") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 39 - 100;
								elseif (itemSubType=="Miscellaneous") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 38 - 100;
								elseif (itemSubType=="Thrown") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 9 - 200;
								else GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 50;
								end 
							elseif(itemType=="Armor") then 
								GT_BS_PreScannedItems[itemName].sort = 600;
								if (itemSubType=="Shield") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 60;
								elseif (itemSubType=="Cloth") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 59;
								elseif (itemSubType=="Leather") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 58;
								elseif (itemSubType=="Mail") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 57;
								elseif (itemSubType=="Plate") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 56;
								elseif (itemSubType=="Miscellaneous") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 37;
								end 
							elseif(itemType=="Recipe") then 
								GT_BS_PreScannedItems[itemName].sort = 500;
								if (itemSubType=="Book") then GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 59;
								else GT_BS_PreScannedItems[itemName].sort = GT_BS_PreScannedItems[itemName].sort + 50;
								end
							elseif(itemType=="Projectile") then 
								GT_BS_PreScannedItems[itemName].sort = 450;
							elseif(itemType=="Consumable") then 
								GT_BS_PreScannedItems[itemName].sort = 350;
							elseif(itemType=="Container") then 
								GT_BS_PreScannedItems[itemName].sort = 250;
							else GT_BS_PreScannedItems[itemName].sort = 50; end
						else
							GT_BS_PreScannedItems[itemName].sort = 10000 - (bag_id+2)*100 - (slot_id+2);
						end
					else
						GT_BS_PreScannedItems[itemName].number = GT_BS_PreScannedItems[itemName].number + count;
					end
				end
			end
		end
	end
end

function GT_BS_Finalize()
	--Array of items that will be saved in SavedVariables.lua
	--Initiated as empty, if BankScan is not called during the session all data will be wiped upon logout
	GT_BS_ScannedItems = {};
	
	for itemName, param in pairs(GT_BS_PreScannedItems) do
		local element = {name = itemName, description = param.description, 
					number = param.number, pic = param.pic, quality = param.quality,
					sort = param.sort, type = param.type, subtype = param.subtype, id = param.id};
		table.insert(GT_BS_ScannedItems, element);
	end
	GT_BS_PreScannedItems = {};
	MoneyScanned = nil;
	
	--Sorting done in the following way:
	--first sort according to sort function, then alphabetically by subtype then by quality, then alphabeticaly by name
	table.sort(GT_BS_ScannedItems, function(i,j) return ((i.sort>j.sort) or (i.sort==j.sort and i.subtype<j.subtype) or 
										(i.sort==j.sort and i.subtype==j.subtype and i.quality>j.quality) or
										(i.sort==j.sort and i.subtype==j.subtype and i.quality==j.quality and i.name<j.name)) end);
	
      for itemName, param in pairs(GT_BS_ScannedItems) do
		GT_BS_ScannedItems[itemName].name = " "..param.name.." ";
		GT_BS_ScannedItems[itemName].number = " "..param.number.." ";
		GT_BS_ScannedItems[itemName].quality = " "..param.quality.." ";
	end 
	GT_BS_Date = " "..date("%m/%d/%y").." ";
	GT_Debug("BS Date: "..GT_BS_Date);
end
	
---------------------------------------------------------------
------------------Incoming Mail functions----------------------
---------------------------------------------------------------

--Scans inventory for empty slots and stores the list of them
--in global variable availableSlots
function GT_IM_ScanSlots()
local index, bag_id, slot_id, i;
	GT_Debug("ScanSlots.");
	if (MailOpened and State == 0) then
		
		GT_IM_Message:Show();
		
		numSlots = 0;
		--availableSlots = nil;
		availableSlots = {};
		
		for index, bag_id in {4,3,2,1,0} do
			if (GetContainerNumSlots(bag_id)) then
				for slot_id = GetContainerNumSlots(bag_id), 1, -1 do
					if (not GetContainerItemLink(bag_id, slot_id)) then
						availableSlots[numSlots+1] = {bag_id = bag_id, slot_id = slot_id};
						numSlots = numSlots+1;
					end
				end
			end
		end
		
		emptySlots = numSlots;
		
		GT_Debug("Empty space is scanned. There are "..numSlots.." empty slots.");
		
		if (numSlots < 1) then 
			GT_Echo(MSG_IM_NOBAG);
			State = -1;
			return;
		end
		
		State = 1;
		From = GT_IM_NumMailedItems[Position] + 1;
		currentMessage = 1;
		--GT_IM_Update:Show();
	end
end

--Takes mail from the mailbox
function GT_IM_GrabMail()
	GT_IM_Update:Hide();
	local index, bag_id, slot_id, i;
	GT_Debug("GrabMail is called.");
	if (MailOpened and State == 1) then
		
		GT_Debug("------>Next item. "..currentMessage.." out of "..GetInboxNumItems());
		if (GetInboxNumItems() < currentMessage) then 
			GT_Debug("End of messages."); 
			State = 10; 
			GT_IM_ScanItems(); 
			return; 
		end
		
		if (emptySlots<=1) then 
			GT_Debug("End of slots."); 
			State = 10; 
			GT_IM_ScanItems(); 
			return; 
		end
		
		local sender, money, CODAmount, hasItem;
		_, _, sender, _, money, CODAmount, _, hasItem = GetInboxHeaderInfo(currentMessage);
		
		while ((not hasItem and money==0) or CODAmount>0) do
			GT_Debug("Message has no item nor cash or is COD - skipping.");
			currentMessage = currentMessage + 1;
			if (currentMessage > GetInboxNumItems()) then
				GT_Debug("End of messages.");
				State = 10;
				GT_IM_ScanItems();
				return; 
			end
			_, _, sender, _, money, CODAmount, _, hasItem = GetInboxHeaderInfo(currentMessage);
		end
		
		local _item = "None";
		local _pic = "INV_Misc_QuestionMark";
		GT_Debug("Grabbing stuff from message. From: "..sender);
		
		if (hasItem) then 
			GT_Debug("Taking item ...");
			TakeInboxItem(currentMessage);
			_item = "Unknown";
			emptySlots = emptySlots - 1;
		end
		
		if (money>0) then 
			if (_item == "None") then 
				GT_Debug("No item, but there's money, taking ...");
				TakeInboxMoney(currentMessage); 
				_pic = "INV_Misc_Coin_01";
				
			elseif (_item == "Unknown") then
				GT_Debug("There's money AND item ...");
				State = 2;
				
			else 
				GT_Debug("WTF?????");
				State = -1;
				
			end
		end
		
		GT_Debug("Grabbing complete.");
		
		--Save info on current item in the array
		GT_IM_NumMailedItems[Position] = GT_IM_NumMailedItems[Position] + 1;
		GT_IM_MailedItems[Position][GT_IM_NumMailedItems[Position]] = {description="  ".._item.." ",
																		name=" ".._item.." ", 
																		number=" ".._item.." ",
																		pic=" ".._pic.." ", 
																		quality=" ".._item.." ",
																		from=" "..sender.." ",
																		coin=" "..money.." ",
																		when=" "..date("%m/%d/%y").." ",
																		id=" 00000 ",
																		type=" None ",
																		subtype=" None "};
		
		To = GT_IM_NumMailedItems[Position];
        GT_Debug("From = "..From.." To = "..To);
		
		if (State == 1) then 
			if (string.find(sender, "Auction") and string.find(sender, "House")) then 
				State = 3; 
			else 
				State = 4; 
			end
		end
		
		return;
		
	--Item was taken - time to take the money
	elseif (MailOpened and State == 2) then
        TakeInboxMoney(currentMessage);
		State = 4;
		return;
		
	--Item from AH was taken, waiting for message to disapear
	elseif (MailOpened and State == 3) then
		GT_Debug("AH - waiting ...");
		State = 1;
		return;
		
	--Everything from the message was taken - deleting the message
	elseif (MailOpened and State == 4) then
		GT_Debug("Deleting ...");
		DeleteInboxItem(currentMessage);
		State = 1;
		return;	
		
	else
		GT_Debug("Just doing nothing.");
	end
end

--Scans global variable availableSlots for items, if found - updates MailedItems.
function GT_IM_ScanItems()
	GT_Debug("ScanItem is called.");
	if (MailOpened and State == 10) then
		
		if (To < From) then 
			State = 11; 
			GT_IM_Update:Hide();
			GT_IM_Message:Hide();
			GT_Echo(MSG_IM_SUCCESS);
			return; 
		end
		
		local bag_id, slot_id, count, texture, itemName, i, itemQuality, itemDesc, itemType, itemSubType, itemId;
		
		bag_id = availableSlots[numSlots].bag_id;
		slot_id = availableSlots[numSlots].slot_id;
		GT_Debug("Checking: "..bag_id..", "..slot_id);
		if (not GT_GetItemInfo(bag_id, slot_id)) then return; end
		
		for i = From, To, 1 do 
			GT_Debug("Checking: "..bag_id..", "..slot_id);
			if (bag_id > -1 and slot_id > -1) then
				itemName, itemQuality, itemDesc, count, texture, itemType, itemSubType, itemId = GT_GetItemInfo(bag_id, slot_id);
			else
				itemName = "Error";
				itemQuality = "1";
				itemDesc = "Error has occured.";
				count = "1";
				texture = "INV_Misc_QuestionMark";
			end
			
			--if (not itemName) then return; end
			
			if (GT_IM_MailedItems[Position][i].name == " None ") then
				GT_Debug("Skipping...");
				GT_IM_MailedItems[Position][i].description = " No item ";
				GT_IM_MailedItems[Position][i].name = " None ";
				GT_IM_MailedItems[Position][i].pic = " INV_Misc_Coin_01 ";
				GT_IM_MailedItems[Position][i].number = " 0 ";
				GT_IM_MailedItems[Position][i].quality = " 1 ";
				GT_IM_MailedItems[Position][i].id = " 00000 ";
				GT_IM_MailedItems[Position][i].type = " None ";
				GT_IM_MailedItems[Position][i].subtype = " None ";
			else
				if (not itemName) then From = i; GT_Debug("Ejecting..."); return; end
				if (numSlots > 0) then
					availableSlots[numSlots] = nil;
					numSlots = numSlots - 1;
				end
				
				GT_Debug("itemName='"..GT_IM_MailedItems[Position][i].name.."', replacing with '"..itemName.."'");
				GT_Debug("Changing...");
				GT_IM_MailedItems[Position][i].number = " "..count.." ";
				GT_IM_MailedItems[Position][i].quality = " "..itemQuality.." ";
				GT_IM_MailedItems[Position][i].description = " "..itemDesc.." ";
				GT_IM_MailedItems[Position][i].name = " "..itemName.." ";
				GT_IM_MailedItems[Position][i].pic = " "..texture.." ";
				GT_IM_MailedItems[Position][i].id = " "..itemId.." ";
				GT_IM_MailedItems[Position][i].type = " "..itemType.." ";
				GT_IM_MailedItems[Position][i].subtype = " "..itemSubType.." ";
				
				if (numSlots > 0) then 
					bag_id = availableSlots[numSlots].bag_id;
					slot_id = availableSlots[numSlots].slot_id;
				else
					bag_id = -1;
					slot_id = -1;
				end
			end
		end
		
	State = 11;
	GT_IM_Update:Hide();
	GT_IM_Message:Hide();
	GT_Echo(MSG_IM_SUCCESS);
	end
end

--Transfers data from GT_IM_NumMailedItems to BS_GT_Saved in reverse order
function GT_IM_Save()
	local i, j;
	j = 0;
	BS_GT_Saved = {};
	for i = GT_IM_NumMailedItems[Position], 1, -1 do
		if (GT_IM_MailedItems[Position][i]) then
			GT_IM_Saved[GT_IM_NumMailedItems[Position]+1-i-j] = GT_IM_MailedItems[Position][i];
		else
			j = j + 1;
		end
	end
end