-- Storage of Quest levels...
-- All credits go to Elkano for his addon Quest Level


-- ---------------------- --
-- hooking game functions --
-- ---------------------- --
local QuestLevel_original_GetTitleText = GetTitleText;

-- GossipFrame
-- local QuestLevel_original_GossipFrameUpdate = GossipFrameUpdate;
local QuestLevel_original_GetGossipAvailableQuests = GetGossipAvailableQuests;
local QuestLevel_original_GetGossipActiveQuests = GetGossipActiveQuests;

-- QuestFrame
-- local QuestLevel_original_QuestFrameGreetingPanel_OnShow = QuestFrameGreetingPanel_OnShow;
local QuestLevel_original_GetActiveTitle = GetActiveTitle;
local QuestLevel_original_GetAvailableTitle = GetAvailableTitle;


-- -------------- --
-- storage system --
-- -------------- --

QuestLevel_StorageKeys = { };
QuestLevel_StorageKeys["levelmin"] = "<";
QuestLevel_StorageKeys["levelmax"] = ">";
QuestLevel_StorageKeys["elite"] = "@";

function QuestLevel_StorageSet(storage, key, value)
	if (not QuestLevel_StorageKeys[key]) then
		return storage;
	end
	if (storage == nil) then
		storage = "";
	end
	local storagearray = {};
	for storagekey, storagevalue in QuestLevel_StorageKeys do
		s1, s2, storagearray[storagekey] = string.find(storage, storagevalue.."(.-)¤");
	end
	storagearray[key] = value;
	local newstorage = "";
	for storagekey, storagevalue in storagearray do
		newstorage = newstorage..QuestLevel_StorageKeys[storagekey]..storagevalue.."¤";
	end
	return newstorage;
end

function QuestLevel_StorageGet(storage, key)
	if (not QuestLevel_StorageKeys[key]) then
		return nil;
	end
	if (storage == nil) then
		storage = "";
	end
	s1, s2, value = string.find(storage, QuestLevel_StorageKeys[key].."(.-)¤");
	if ( value ) then
		return value;
	else
		return nil;
	end
end


-- -------------- --
-- main functions --
-- -------------- --

local function QuestLevel_VariablesLoaded()
	if( not QuestLevel_Quest2Level ) then
		QuestLevel_Quest2Level = { };
	end

	-- convert to now storage -- beta2
	for quest, data in QuestLevel_Quest2Level do
		if ( type(data) == "table" or string.find(data, QuestLevel_StorageKeys["levelmin"]) == nil ) then
			if ( type(data) == "table" ) then
				local queststorage = "";
				queststorage = QuestLevel_StorageSet(queststorage, "levelmin", data["min"]);
				queststorage = QuestLevel_StorageSet(queststorage, "levelmax", data["max"]);
				QuestLevel_Quest2Level[quest] = queststorage;
			else
				local queststorage = "";
				queststorage = QuestLevel_StorageSet(queststorage, "levelmin", data);
				QuestLevel_Quest2Level[quest] = queststorage;
			end
		else
			break; -- data is validstorage -> table had been converted before
		end
	end

	-- convert to now storage -- beta3
	for quest, data in QuestLevel_Quest2Level do
		local levelmin = QuestLevel_StorageGet(data, "levelmin");
		local levelmax = QuestLevel_StorageGet(data, "levelmax");
		if ( levelmax == nil ) then
			break; -- data is validstorage -> table had been converted before
		end
		if ( tonumber(levelmin) >= tonumber(levelmax) ) then
			data = QuestLevel_StorageSet(data, "levelmax", nil);
			QuestLevel_Quest2Level[quest] = data;
		end
	end
end

function QuestLevel_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Elkano's QuestLevel AddOn v2.0 loaded");
	end
end

function QuestLevel_OnEvent()
	if( event == "VARIABLES_LOADED" ) then
		QuestLevel_VariablesLoaded();
	end
end

local function QuestLevel_AddLevelFromTable(questname)
	if ( QuestLevel_Quest2Level[questname] ) then
		local levelmin = tonumber(QuestLevel_StorageGet(QuestLevel_Quest2Level[questname], "levelmin"));
		local levelmax = QuestLevel_StorageGet(QuestLevel_Quest2Level[questname], "levelmax");
		if ( levelmax == nil ) then
			levelmax = levelmin;
		else
			levelmax = tonumber(levelmax);
		end
		local leveltag = "";
		if ( levelmin < levelmax ) then
			leveltag = leveltag..levelmin.."-"..levelmax;
		else
			leveltag = leveltag..levelmin;
		end
		if (QuestLevel_StorageGet(QuestLevel_Quest2Level[questname], "elite") ~= nil) then
			leveltag = leveltag.."+";
		end
		return "["..leveltag.."] "..questname;
	end
	return "[?] "..questname;
end

function GetTitleText()
	if ( QuestlogOptions[EQL3_Player].ShowQuestLevels == 1 and QuestlogOptions[EQL3_Player].OnlyLevelsInLog == 0 ) then
		local titletext = QuestLevel_original_GetTitleText();
	--	if( DEFAULT_CHAT_FRAME ) then
	--		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: GetTitleText -> "..titletext);
	--	end
		return QuestLevel_AddLevelFromTable(titletext);
	else
		-- still stor the quests..
		local titletext = QuestLevel_original_GetTitleText();
		QuestLevel_AddLevelFromTable(titletext);
		
		return QuestLevel_original_GetTitleText();
	end
end

local function QuestLevel_table2args(intable)
	if ( intable.n == 0 ) then
		return;
	elseif ( intable.n == 1 ) then
		return intable[1];
	else
		return table.remove(intable, 1), QuestLevel_table2args(intable);
	end
end

local function QuestLevel_addLevelGossip(...)
	if ( arg.n == 0) then
		return
	end
	for i=1, arg.n, 2 do
-- 		if( DEFAULT_CHAT_FRAME ) then
-- 			DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: arg["..i.."] -> "..arg[i]);
-- 		end
		arg[i] = QuestLevel_AddLevelFromTable(arg[i]);
	end
	return QuestLevel_table2args(arg);
end

-- function GossipFrameUpdate()
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00GossipFrameUpdate|r called");
-- 	end
-- 	return QuestLevel_original_GossipFrameUpdate();
-- end

function GetGossipAvailableQuests()
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00GetGossipAvailableQuests|r called");
-- 	end
	if ( QuestlogOptions[EQL3_Player].ShowQuestLevels == 1 and QuestlogOptions[EQL3_Player].OnlyLevelsInLog == 0 ) then
		return QuestLevel_addLevelGossip(QuestLevel_original_GetGossipAvailableQuests());
	else
		return QuestLevel_original_GetGossipAvailableQuests();
	end
end

function GetGossipActiveQuests()
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00GetGossipActiveQuests|r called");
-- 	end
	if ( QuestlogOptions[EQL3_Player].ShowQuestLevels == 1 and QuestlogOptions[EQL3_Player].OnlyLevelsInLog == 0 ) then
		return QuestLevel_addLevelGossip(QuestLevel_original_GetGossipActiveQuests());
	else
		return QuestLevel_original_GetGossipActiveQuests();
	end
end

-- function QuestFrameGreetingPanel_OnShow()
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00QuestFrameGreetingPanel_OnShow|r called");
-- 	end
-- 	return QuestLevel_original_QuestFrameGreetingPanel_OnShow();
-- end

function GetActiveTitle(i)
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00GetActiveTitle("..i..")|r called");
-- 	end
	if ( QuestlogOptions[EQL3_Player].ShowQuestLevels == 1 and QuestlogOptions[EQL3_Player].OnlyLevelsInLog == 0 ) then
		return QuestLevel_AddLevelFromTable(QuestLevel_original_GetActiveTitle(i));
	else
		return QuestLevel_original_GetActiveTitle(i);
	end
end

function GetAvailableTitle(i)
-- 	if( DEFAULT_CHAT_FRAME ) then
-- 		DEFAULT_CHAT_FRAME:AddMessage("[QuestLevel] DEBUG: |cffffff00GetAvailableTitle("..i..")|r called");
-- 	end
	if ( QuestlogOptions[EQL3_Player].ShowQuestLevels == 1 and QuestlogOptions[EQL3_Player].OnlyLevelsInLog == 0 ) then
		return QuestLevel_AddLevelFromTable(QuestLevel_original_GetAvailableTitle(i));
	else
		return QuestLevel_original_GetAvailableTitle(i);
	end
end
