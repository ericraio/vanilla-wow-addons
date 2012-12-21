--[[ 
Description
If you have ever had a quest item you have no idea which quest it belongs to, and if it safe to destroy, this AddOn is for you.	

QuestItem stores an in-game database over quest items and tell you which quest they belong to. Useful to find out if you 
are still o	n the quest, and if it safe to destroy it. The AddOn will map items to quests when you pick them up, but also 
has a limited backward compatability. If you see tooltip for a questitem you have picked up before installing the addon, 
QuestItem will try to find the item in your questlog, and map it to a quest. In case unsuccessful, the item will be marked 
as unidentified.

QuestItem now has a configuration screen you can access by typing /questitem or /qi at the chat prompt. Here you can configure
some of the functionallity as well as do manual mapping of unidentified items.

Feature summary:
- Identify quest items when picked up.
- Show quest name and status in tooltip for quest items.
- Will try to identify items picked up before the AddOn was installed.
- Identified items are available for all your characters, and status is unique for your character.
- Displays how many items are needed to complete quest, and how many you currently have.
- Manual mapping for unidentified items.
- Configuration

+ If you like this addon (or even if you don't), donations are always welcome to my character Shagoth on the Stormreaver server ;D
+ If you can translate the interface to german, edit the appropriate localization.lua file, and mail it to me at shagoth@gmail.com
+ Bug reports can be made adding a comment, or sending me a PM or email at shagoth@gmail.com

	
History:
	New in version 1.6.0:
	- Added configurable tooltip for item list.
	- Added Alt + right click to open QuestLog for an item.
	
	New in version 1.5.3:
	- Updated french language
	
	New in version 1.5.2:
	- Fixed RegisterForSave in 1.10

	New in version 1.5.1:
	- Fixed a weird graphics issue with the item list.
	- Resized the close button to fit the rectangle its placed inside
	- Added version information in the item list
	- Right click for pop-up on linked items in chat should be working

	New in version 1.5.0:
	- Sorting of items in the list.
	- Fixed the placement of the caption for the config window
	
	New in version 1.4.0:
	- Support for EngInventory

	New in version 1.3.5:
	- Should work in the bank, even with Emerald UI
	
	See older history in Changelog.txt

]]--

-- /script arg1="Dentrium-Kraftstein: 1/1"; QuestItem_OnEvent("DELETE"); arg1="Roon's Kodo Horn: 1/1"; QuestItem_OnEvent("UI_INFO_MESSAGE");
-- /script arg1="Ragefire Shaman slain: 5/8"; QuestItem_OnEvent("UI_INFO_MESSAGE"); QuestItem_OnEvent("DELETE");
-- /script arg1="Sent mail"; QuestItem_OnEvent("DELETE"); QuestItem_OnEvent("DELETE");

DEBUG = false;
QI_CHANNEL_NAME = "QuestItem";

-- QuestItem array
QuestItems = {};
-- Settings
QuestItem_Settings = {};

----------------------------------------------------
-- Updates the database with item and quest mappings
----------------------------------------------------
----------------------------------------------------
function QuestItem_UpdateItem(item, quest, count, total, status)
	-- If item doesn't exist, add quest name and total item count to it
	if(not QuestItems[item]) then
		QuestItems[item] = {};
		QuestItems[item].QuestName = quest;
	end
	
	-- If old quest name was unidentified, save new name
	if(QuestItem_SearchString(QuestItems[item].QuestName, QUESTITEM_UNIDENTIFIED) and not QuestItem_SearchString(quest, QuestItems[item].QuestName) ) then
		QuestItems[item].QuestName = quest;
	end

	if(not QuestItems[item][UnitName("player")]) then
		QuestItems[item][UnitName("player")] = {};
	end

	-- Save total count
	if(total ~= nil and QuestItem_CheckNumeric(total) ) then
		QuestItems[item].Total = QuestItem_MakeIntFromHexString(total);
	else
		QuestItems[item].Total = 0;
	end
	
	-- Save item count
	if(count ~= nil and QuestItem_CheckNumeric(count) ) then
		QuestItems[item][UnitName("player")].Count = QuestItem_MakeIntFromHexString(count);
	else
		QuestItems[item][UnitName("player")].Count = 0;
	end

	QuestItems[item][UnitName("player")].QuestStatus 	= status;
end

----------------------------------------------------------------------
-- Find a quest based on item name
-- Returns:
-- 			QuestName  	- the name of the Quest.
--			Total	   	- Total number of items required to complete it
--			Count	   	- The number of items you have
--			Texture		- Texture of the item
----------------------------------------------------------------------
----------------------------------------------------------------------
function QuestItem_FindQuest(item)
	local total = 1;
	local count = 0;
	local texture = nil;
	local itemName;
	
	-- Iterate the quest log entries
	for y=1, GetNumQuestLogEntries(), 1 do
		local QuestName, level, questTag, isHeader, isCollapsed, complete = GetQuestLogTitle(y);
		-- Don't check headers
		if(not isHeader) then
			SelectQuestLogEntry(y);
			local QDescription, QObjectives = GetQuestLogQuestText();
			
			-- Find out if this item has already been mapped to a quest. 
			-- This is to to prevent any reset of the status for manually mapped items.
			if(QuestItems[item] and (QuestItems[item].QuestName and QuestItems[item].QuestName == QuestName) ) then
				QuestItem_UpdateItem(item, QuestName, count, total, 0)
				return QuestName, total, count, texture;
			end

			-- Look for the item in quest leader boards
			if (GetNumQuestLeaderBoards() > 0) then 
				-- Look for the item in leader boards
				for i=1, GetNumQuestLeaderBoards(), 1 do --Objectives
					--local str = getglobal("QuestLogObjective"..i);
					local text, itemType, finished = GetQuestLogLeaderBoard(i);
					-- Check if type is an item, and if the item is what we are looking for
					--QuestItem_Debug("Item type: " ..itemType);
					if(itemType ~= nil and (itemType == "item" or itemType == "object") ) then
						if(QuestItem_SearchString(text, item)) then
							local count = gsub(text,"(.*): (%d+)/(%d+)","%2");
							local total = gsub(text,"(.*): (%d+)/(%d+)","%3");
							QuestItem_Debug("Count: " ..count);
							return QuestName, total, count, texture;
						end
					end
				end
			end
			-- Look for the item in the objectives - no count and total will be returned
			if(QuestItem_SearchString(QObjectives, item)) then
				return QuestName, total, count, texture;
			end
		end
	end
	return nil, total, count, texture;
end

--------------------------------------------------------------------------------
-- Check if there is a quest for the item. If it exists; update, if not, save it.
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function QuestItem_LocateQuest(itemText, itemCount, itemTotal)
	local QuestName, texture;
	
	-- Only look through the questlog if the item has not already been mapped to a quest
	if(not QuestItems[itemText] or QuestItems[itemText].QuestName == QUESTITEM_UNIDENTIFIED) then
		QuestName, itemTotal, itemCount, texture = QuestItem_FindQuest(itemText);
	else
		QuestName = QuestItems[itemText].QuestName;
	end
	
	-- Update the QuestItems array
	if(QuestName ~= nil) then
		QuestItem_Debug("Found quest for " .. itemText .. ": " .. QuestName);
		QuestItem_UpdateItem(itemText, QuestName, itemCount, itemTotal, 0);
	elseif(QuestItem_Settings["Alert"]) then
		QuestItem_PrintToScreen(QUESTITEM_CANTIDENTIFY .. itemText);
	end
end

---------------
-- OnLoad event
---------------
---------------
function QuestItem_OnLoad()
	-- RegisterForSave("QuestItems");
	-- RegisterForSave("QuestItem_Settings");
	
	this:RegisterEvent("VARIABLES_LOADED");

	-- Register slash commands
	SLASH_QUESTITEM1 = "/questitem";
	SLASH_QUESTITEM2 = "/qi";
	SlashCmdList["QUESTITEM"] = QuestItem_Config_OnCommand;
	
	QuestItem_PrintToScreen(QUESTITEM_LOADED);
	
	--QuestItem_Sky_OnLoad();
	QuestItem_HookTooltip();
end


-----------------
-- OnEvent method
-----------------
-----------------
function QuestItem_OnEvent(event)
	if(event == "VARIABLES_LOADED") then
		QuestItem_VariablesLoaded();
		this:UnregisterEvent("VARIABLES_LOADED");
		
		if(QuestItem_Settings["version"] and QuestItem_Settings["Enabled"] == true) then
			this:RegisterEvent("UI_INFO_MESSAGE");		
		end
		return;
	end
	
	if(not arg1) then
		return;
	end

	local itemText = gsub(arg1,"(.*): %d+/%d+","%1",1);
	if(event == "UI_INFO_MESSAGE") then
		local itemCount = gsub(arg1,"(.*): (%d+)/(%d+)","%2");
		local itemTotal = gsub(arg1,"(.*): (%d+)/(%d+)","%3");
		-- Ignore trade and duel events
		if(itemText ~= arg1 and not strfind(itemText, QUESTITEM_SLAIN)) then
			QuestItem_Debug("Looking for quest item "..itemText);
			QuestItem_LocateQuest(itemText, itemCount, itemTotal);
		end
	elseif(event == "DELETE") then
		if(QuestItems[itemText]) then
			QuestItems[itemText] = nil;
			QuestItem_Debug("Deleted");
		end
	end
end

------------------------------------
-- Initialize settings if not found. 
------------------------------------
------------------------------------
function QuestItem_VariablesLoaded()
	if ( QuestItem_Settings and QuestItem_Settings["version"] == QUESTITEM_VERSION ) then
		return;
	end
	
	if (not QuestItem_Settings) then
		QuestItem_Settings = { };	
	end
	
	-- No settings exist
	QuestItem_Settings["version"] = QUESTITEM_VERSION;
	
	QuestItem_Settings["Enabled"] = true;
	QuestItem_Settings["Alert"] = true;
	-- Check if AxuItemMenus is installed
	if(AxuItemMenus_AddTestHook) then
		QuestItem_Settings["DisplayRequest"] = false;
	else
		QuestItem_Settings["DisplayRequest"] = false;
	end
	QuestItem_Settings["ShiftOpen"] = false;
	QuestItem_Settings["AltOpen"] = true;
end


---------------
---------------
---------------
-- FUNCTIONS --
---------------
---------------
---------------


-- Print debug message to the default chatframe.
-- Only works if the DEBUG variable in the 
-- beginning of QuestItem.lua is set to true.
------------------------------------------------
------------------------------------------------
function QuestItem_Debug(message)
	if(DEBUG) then
		if(not message) then
			DEFAULT_CHAT_FRAME:AddMessage("Debug: Message was nil", 0.9, 0.5, 0.3);
		else
			DEFAULT_CHAT_FRAME:AddMessage("Debug: " ..message, 0.9, 0.5, 0.3);
		end
	end
end

function QuestItem_PrintToScreen(message)
	UIErrorsFrame:AddMessage(message, 0.4, 0.5, 0.8, 1.0, 8);
end

---------------------------------------------------
-- Find out if an item is a quest item by searching 
-- the text in the tooltip.
---------------------------------------------------
---------------------------------------------------
function QuestItem_IsQuestItem(tooltip)
	if(tooltip) then
		local tooltip = getglobal(tooltip:GetName() .. "TextLeft"..2);
		if(tooltip and tooltip:GetText()) then
			if(QuestItem_SearchString(tooltip:GetText(), QUESTITEM_QUESTITEM)) then
				return true;
			end
		end
	end
	return false;
end

--------------------------------------------
-- Open the specified quest in the quest log 
--------------------------------------------
--------------------------------------------
function QuestItem_OpenQuestLog(questName)
	for y=1, GetNumQuestLogEntries(), 1 do
		local QuestName, level, questTag, isHeader, isCollapsed, complete = GetQuestLogTitle(y);
		if(questName == QuestName) then
			SelectQuestLogEntry(y);
			local logFrame = getglobal("QuestLogFrame");

			if(logFrame ~= nil) then
				if(logFrame:IsVisible()) then
					ToggleQuestLog();
				end
				if(QuestLog_SetSelection == nil) then
					QuestLog_SetSelection(y);
				end
				ToggleQuestLog();
			end
			return;
		end
	end
	QuestItem_PrintToScreen(QUESTITEM_NO_QUEST);
end

---------------------------------------
-- Look for the item in the text string
---------------------------------------
---------------------------------------
function QuestItem_SearchString(text, item)
	if(string.find(string.lower(text), string.lower(item)) ) then
		return true;
	end
	return false;
end

-- Copied functions - don't want to depend on too many AddOns

-- From LootLink
function QuestItem_MakeIntFromHexString(str)
	if(not str) then
		return 0;
	end
	local remain = str;
	local amount = 0;
	while( remain ~= "" ) do
		amount = amount * 10;
		local byteVal = string.byte(strupper(strsub(remain, 1, 1)));
		if( byteVal >= string.byte("0") and byteVal <= string.byte("9") ) then
			amount = amount + (byteVal - string.byte("0"));
		end
		remain = strsub(remain, 2);
	end
	return amount;
end

function QuestItem_CheckNumeric(string)
	local remain = string;
	local hasNumber;
	local hasPeriod;
	local char;
	
	while( remain ~= "" and remain ~= nil) do
	--while( remain ~= "") do
		char = strsub(remain, 1, 1);
		if( char >= "0" and char <= "9" ) then
			hasNumber = 1;
		elseif( char == "." and not hasPeriod ) then
			hasPeriod = 1;
		else
			return nil;
		end
		remain = strsub(remain, 2);
	end
	
	return hasNumber;
end

-- From Sea
function QuestItem_ScanTooltip()
	local tooltipBase = "GameTooltip";
	local strings = {};
	for idx = 1, 10 do
		local textLeft = nil;
		local textRight = nil;
		ttext = getglobal(tooltipBase.."TextLeft"..idx);
		if(ttext and ttext:IsVisible() and ttext:GetText() ~= nil)
		then
			textLeft = ttext:GetText();
		end
		ttext = getglobal(tooltipBase.."TextRight"..idx);
		if(ttext and ttext:IsVisible() and ttext:GetText() ~= nil)
		then
			textRight = ttext:GetText();
		end
		if (textLeft or textRight)
		then
			strings[idx] = {};
			strings[idx].left = textLeft;
			strings[idx].right = textRight;
		end	
	end
	
	return strings;
end