-- 09/04/2005 12:30:49 PIng: Replace hardcoded strings for UI by localized variables
-- 09/04/2005 12:31:41 PIng: Bug fix. Replace ShM_PrintMessage by SkM_PrintMessage
-- 09/04/2005 15:52:09 PIng: Add guild support
-- 09/04/2005 16:18:34 PIng: Update war info on target frame when status is changed

SKM_UNIT_PLAYER = "player";
SKM_UNIT_TARGET = "target";
SKM_UNIT_MOUSEOVER = "mouseover";
SKM_UNIT_PARTY = "party";
SKM_UNIT_PET = "pet";

SKM_UNIT_PARTY_1 = SKM_UNIT_PARTY.."1";
SKM_UNIT_PARTY_2 = SKM_UNIT_PARTY.."2";
SKM_UNIT_PARTY_3 = SKM_UNIT_PARTY.."3";
SKM_UNIT_PARTY_4 = SKM_UNIT_PARTY.."4";



_RealmName = nil;
_PlayerName = nil;


SKM_MAX_MAP_NOTES	= 200;


local TXT_NIL = "nil";

local SKM_MESSAGE_PREFIX = "SKM: ";

local SKM_TRACE_MODE_NONE = 0;
local SKM_TRACE_MODE_PRINT = 1;
local SKM_TRACE_MODE_CHATMSG = 2;

local SKM_TRACE_NIL = false;

local TXT_NIL = "nil";

--local SKM_TRACE_MODE = SKM_TRACE_MODE_NONE;
--local SKM_TRACE_MODE = SKM_TRACE_MODE_PRINT;
local SKM_TRACE_MODE = SKM_TRACE_MODE_CHATMSG;



-- number of days in a month for a non leap year
local DaysInMonth = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

-- list of leap years for the first half of the 21st century
local LeapYears = { 2000, 2004, 2008, 2012, 2016, 2020, 2024, 2028, 2032, 2036, 2040, 2044, 2048 };



-- List of ennemy player factions races (alliance and horde)
-- (could easily add more by altering the list, though it probably won't happen !)
SKM_PlayerFaction = {
  { 	Faction = "Alliance",
  	RaceList = { SKM_RACE.Dwarf, SKM_RACE.Gnome, SKM_RACE.Human, SKM_RACE.NightElf }
  };

  { 	Faction = "Horde",
  	RaceList = { SKM_RACE.Orc, SKM_RACE.Tauren, SKM_RACE.Troll, SKM_RACE.Undead }
  };
};

SKM_HonorKillPerDay = 4;


SKM_ToStandardCase = {
	["A"] = { "\195\128", "\195\129", "\195\130", "\195\131", "\195\132", "\195\133" },
	["E"] = { "\195\136", "\195\137", "\195\138", "\195\139"},
	["I"] = { "\195\140", "\195\141", "\195\142", "\195\143"},
	["O"] = { "\195\146", "\195\147", "\195\148", "\195\149", "\195\150", "\195\152" },
	["U"] = { "\195\153", "\195\154", "\195\155", "\195\156" },
	["Y"] = { "\195\157", "\195\191", "\197\184" },

	["C"] = { "\195\135" },
	["D"] = { "\195\144" },
	["N"] = { "\195\145" },
	["S"] = { "\197\160", "\197\161"}
};


SKM_GuildChannelPrefix = "SKM";



-- OLD table indexes - before data migration - SKMap 1.4
-- -----------------------------------------------------
_SKM_OLD = {
	_name = "name";
	_class = "class";
	_guild = "guild";
	_race = "race";
	_level = "level";

	_playerNote	= "playerNote";

	_playerKill = "playerKill";
	_playerAssistKill = "playerAssistKill";
	_playerFullKill	= "playerFullKill";

	_honorKill = "honorKill";
	_honorCount = "honorCount";
	_honorLastKill = "honorLastKill";
	_rank = "rank";

	_meetCount = "meetCount";
	_atWar = "atWar";
--	_guildAtWar = "guildAtWar";
	_warDate = "warDate";

	_continent = "continent";
	_zone = "zone";
	_xPos = "xPos";
	_yPos = "yPos";
	_zoneName = "zoneName";

--	_lastUpdate	= "lastUpdate";
	_lastView = "lastView";
	_lastPlayerViewed = "lastPlayerViewed";

	_enemyKillPlayer = "enemyKillPlayer";
	_enemyKillBG = "enemyKillBG";
	_playerBGKill = "playerBGKill";

	_members = "members";

	_type = "type";
	_date = "date";
	_enemyType = "enemyType";
	_enemyPlayer = "enemyPlayer";
	_enemyCreature = "enemyCreature";

	_playerDeath = "playerDeath";
	_playerDeathPvP = "playerDeathPvP";
	_playerDeathPvE = "playerDeathPvE";
	_creatureKill_Target = "creatureKill_Target";
	_creatureKill_Xp = "creatureKill_Xp";
	_levelUp = "levelUp";

	_loneWolfKill = "loneWolfKill";

	_storedInfo	= "storedInfo";

	_win = "win";
	_loss = "loss";
	_duel = "duel";
	_lastDuel = "lastDuel";
--	_score = "score";
};

-- new table indexes - after data migration - SKMap 1.4
-- ----------------------------------------------------
_SKM = {
	_name = "Na";
	_class = "Cl";
	_guild = "Gu";
	_race = "Ra";
	_level = "Lv";

	_playerNote	= "PlN";

	_playerKill = "PK";
	_playerAssistKill = "PaK";
	_playerFullKill	= "PfK";

	_honorKill = "hK";
	_honorCount = "hC";
	_honorLastKill = "hLK";
	_rank = "Rk";

	_meetCount = "mC";
	_atWar = "Wr";
	_guildAtWar = "gWr"; -- not saved
	_warDate = "WD";

	_continent = "Co";
	_zone = "Zo";
	_xPos = "x";
	_yPos = "y";
	_zoneName = "ZN";

	_lastUpdate	= "lU"; -- not saved
	_lastView = "lV";
	_lastPlayerViewed = "lPV";


	_enemyKillPlayer = "EKP";
	_enemyKillBG = "EKb";
	_playerBGKill = "PbK";

	_members = "Mb"; -- not saved

	_type = "Ty";
	_date = "Da";
	_enemyType = "ETy";
	_enemyPlayer = "EPl";
	_enemyCreature = "ECr";

	_playerDeath = "PD";
	_playerDeathPvP = "PDp";
	_playerDeathPvE = "PDc";
	_creatureKill_Target = "CKt";
	_creatureKill_Xp = "CKx";
	_levelUp = "LvU";

	_loneWolfKill = "LwK";

	_storedInfo	= "Inf";

	_win = "Win";
	_loss = "Los";
	_duel = "Du";
	_lastDuel = "lDu";
	_score = "Scr"; -- not saved


	-- following indexes are for temporary use (ie not saved in SavedVariables.lua, so it's
	-- not as important if they're a bit longer)

	_noteIndex = "NIn";
	_default = "Def";
	_multiType = "MTy";
	_playerKillAndDeath	= "PKaD";

	_totalDamage = "tDm";
	_groupDamage = "gDm";
	_lastHateUpdate = "lHU";
	_hateLevel = "HLv";
	_damage	= "Dm";
	_hatePercent = "HPct";

	_time = "Ti";

	_owner = "Own";
	_player	= "Ply";
	_other = "Oth";

	_players = "players";
	_guilds = "guilds";
	_duels = "duels";

	_bookCredits = "bookCredits";
	_bookGeneralStat = "bookGeneralStat";
	_bookClassStat = "bookClassStat";
	_bookRaceStat = "bookRaceStat";
	_bookPlayerStat = "bookPlayerStat";
	_bookGuildStat = "bookGuildStat";
	_bookMapStat = "bookMapStat";
	_bookDateStat = "bookDateStat";

	_bookBGDateMapStat = "bookBGDateMapStat";
	_bookBGDateStat = "bookBGDateStat";
	_bookBGMapStat = "bookBGMapStat";

	_checkButton = "CBtn";
	_slider = "Slid";

};



SKM_IndexMigr = {
	[2] = {
		EnemyHistory = {
			{Old=_SKM_OLD._name, New=_SKM._name},
			{Old=_SKM_OLD._class, New=_SKM._class},
			{Old=_SKM_OLD._guild, New=_SKM._guild},
			{Old=_SKM_OLD._race, New=_SKM._race},
			{Old=_SKM_OLD._level, New=_SKM._level},
			{Old=_SKM_OLD._playerNote, New=_SKM._playerNote},
			{Old=_SKM_OLD._playerKill, New=_SKM._playerKill},
			{Old=_SKM_OLD._playerAssistKill, New=_SKM._playerAssistKill},
			{Old=_SKM_OLD._playerFullKill, New=_SKM._playerFullKill},
			{Old=_SKM_OLD._honorKill, New=_SKM._honorKill},
			{Old=_SKM_OLD._honorCount, New=_SKM._honorCount},
			{Old=_SKM_OLD._honorLastKill, New=_SKM._honorLastKill},
			{Old=_SKM_OLD._rank, New=_SKM._rank},
			{Old=_SKM_OLD._meetCount, New=_SKM._meetCount},
			{Old=_SKM_OLD._atWar, New=_SKM._atWar},
			{Old=_SKM_OLD._warDate, New=_SKM._warDate},
			{Old=_SKM_OLD._continent, New=_SKM._continent},
			{Old=_SKM_OLD._zone, New=_SKM._zone},
			{Old=_SKM_OLD._xPos, New=_SKM._xPos},
			{Old=_SKM_OLD._yPos, New=_SKM._yPos},
			{Old=_SKM_OLD._zoneName, New=_SKM._zoneName},
	--		{Old=_SKM_OLD._lastUpdate, New=_SKM._lastUpdate},
			{Old=_SKM_OLD._lastView, New=_SKM._lastView},
			{Old=_SKM_OLD._enemyKillPlayer, New=_SKM._enemyKillPlayer},
			{Old=_SKM_OLD._enemyKillBG, New=_SKM._enemyKillBG},
			{Old=_SKM_OLD._playerBGKill, New=_SKM._playerBGKill},
		};
		GuildHistory = {
			{Old=_SKM_OLD._name, New=_SKM._name},
	--		{Old=_SKM_OLD._members, New=_SKM._members},
			{Old=_SKM_OLD._meetCount, New=_SKM._meetCount},
			{Old=_SKM_OLD._atWar, New=_SKM._atWar},
			{Old=_SKM_OLD._warDate, New=_SKM._warDate},
			{Old=_SKM_OLD._playerKill, New=_SKM._playerKill},
			{Old=_SKM_OLD._playerAssistKill, New=_SKM._playerAssistKill},
			{Old=_SKM_OLD._playerFullKill, New=_SKM._playerFullKill},
			{Old=_SKM_OLD._enemyKillPlayer, New=_SKM._enemyKillPlayer},
			{Old=_SKM_OLD._lastView, New=_SKM._lastView},
			{Old=_SKM_OLD._lastPlayerViewed, New=_SKM._lastPlayerViewed},
		};
		GlobalMapData = {
			{Old=_SKM_OLD._continent, New=_SKM._continent},
			{Old=_SKM_OLD._zone, New=_SKM._zone},
			{Old=_SKM_OLD._xPos, New=_SKM._xPos},
			{Old=_SKM_OLD._yPos, New=_SKM._yPos},
			{Old=_SKM_OLD._storedInfo, New=_SKM._storedInfo},
		};
		StoredInfo = {
			{Old=_SKM_OLD._type, New=_SKM._type},
			{Old=_SKM_OLD._date, New=_SKM._date},
			{Old=_SKM_OLD._name, New=_SKM._name},
			{Old=_SKM_OLD._level, New=_SKM._level},
			{Old=_SKM_OLD._enemyType, New=_SKM._enemyType},
			{Old=_SKM_OLD._loneWolfKill, New=_SKM._loneWolfKill},
			{Old=_SKM_OLD._honorKill, New=_SKM._honorKill},
		};
		EnemyType = {
			[_SKM_OLD._enemyPlayer] = _SKM._enemyPlayer;
			[_SKM_OLD._enemyCreature] = _SKM._enemyCreature;
		};
		RecordType = {

			[_SKM_OLD._playerKill] = _SKM._playerKill;
			[_SKM_OLD._playerAssistKill] = _SKM._playerAssistKill;
			[_SKM_OLD._playerFullKill] = _SKM._playerFullKill;
			[_SKM_OLD._playerDeath] = _SKM._playerDeath;
			[_SKM_OLD._playerDeathPvP] = _SKM._playerDeathPvP;
			[_SKM_OLD._playerDeathPvE] = _SKM._playerDeathPvE;
			[_SKM_OLD._creatureKill_Target] = _SKM._creatureKill_Target;
			[_SKM_OLD._creatureKill_Xp] = _SKM._creatureKill_Xp;
			[_SKM_OLD._levelUp] = _SKM._levelUp;
		};
		DuelHistory = {
			{Old=_SKM_OLD._name, New=_SKM._name},
			{Old=_SKM_OLD._class, New=_SKM._class},
			{Old=_SKM_OLD._guild, New=_SKM._guild},
			{Old=_SKM_OLD._race, New=_SKM._race},
			{Old=_SKM_OLD._level, New=_SKM._level},
			{Old=_SKM_OLD._playerNote, New=_SKM._playerNote},
			{Old=_SKM_OLD._win, New=_SKM._win},
			{Old=_SKM_OLD._loss, New=_SKM._loss},
			{Old=_SKM_OLD._duel, New=_SKM._duel},
			{Old=_SKM_OLD._lastDuel, New=_SKM._lastDuel},
		};
		BGStatDate = {
			{Old=_SKM_OLD._enemyKillBG, New=_SKM._enemyKillBG},
			{Old=_SKM_OLD._playerBGKill, New=_SKM._playerBGKill},
		};
	};

};







--_time			= "time";

--_type			= "type";

--_name			= "name";
--_class			= "class";
--_guild 			= "guild"; -- PIng: Add guild support
--_race			= "race";
--_level			= "level";
--_date			= "date";
--_sortdate		= "sortdate";

--_killedBy		= "killBy";

--_playerNote		= "playerNote";

--_noteIndex = "noteIndex";

--_icon_PlayerKill	= "icon_PlayerKill";
--_icon_PlayerDeath 	= "icon_PlayerDeath";

-- type of map events
--_playerKill		= "playerKill";
--_playerAssistKill	= "playerAssistKill";
--_playerFullKill 	= "playerFullKill";
--_playerDeath		= "playerDeath";
--_playerDeathPvP		= "playerDeathPvP";
--_playerDeathPvE		= "playerDeathPvE";
--_creatureKill_Target	= "creatureKill_Target";
--_creatureKill_Xp	= "creatureKill_Xp";
--_levelUp		= "levelUp";

--_loneWolfKill		= "loneWolfKill";

--_honorKill = "honorKill";
--_honorCount = "honorCount";
--_honorLastKill = "honorLastKill";
--_rank = "rank";

--_win = "win";
--_loss = "loss";
--_duel = "duel";
--_lastDuel = "lastDuel";
--_score = "score";

--_default		= "default";
--_multiType		= "multiType";
--_playerKillAndDeath	= "playerKillAndDeath";

--_enemyKillPlayer	= "enemyKillPlayer";

--_enemyKillBG = "enemyKillBG";
--_playerBGKill = "playerBGKill";


--_meetCount		= "meetCount";
--_atWar			= "atWar";
--_guildAtWar		= "guildAtWar";
--_warDate		= "warDate";

--_continent 		= "continent";
--_zone			= "zone";
--_xPos			= "xPos";
--_yPos			= "yPos";
--_icon			= "icon";
--_storedInfo		= "storedInfo";

--_zoneName		= "zoneName";


--_lastUpdate		= "lastUpdate";
--_totalDamage		= "totalDamage";
--_groupDamage		= "groupDamage";

--_lastHateUpdate		= "lastHateUpdate";
--_hateLevel		= "hateLevel";
--_enemyType		= "enemyType";
--_damage			= "damage";

--_lastView		= "lastView";
--_lastPlayerViewed	= "lastPlayerViewed";

--_enemyPlayer		= "enemyPlayer";
--_enemyCreature		= "enemyCreature";

--_owner			= "owner";
--_player			= "player";
--_other			= "other";

--_players		= "players";
--_guilds			= "guilds";
--_duels			= "duels";
--_members		= "members";

--_bookCredits		= "bookCredits";
--_bookGeneralStat	= "bookGeneralStat";
--_bookClassStat		= "bookClassStat";
--_bookRaceStat		= "bookRaceStat";
--_bookPlayerStat		= "bookPlayerStat";
--_bookGuildStat		= "bookGuildStat";
--_bookMapStat		= "bookMapStat";
--_bookDateStat		= "bookDateStat";

--_bookBGDateMapStat	= "bookBGDateMapStat";
--_bookBGDateStat		= "bookBGDateStat";
--_bookBGMapStat		= "bookBGMapStat";


--_checkButton	= "checkButton";

--_slider = "slider";





function SkM_TableInsertMaxLengthLine(Lines, sLine, iMaxLen, iThreshold, sColorPrefix)
	local FName = "SkM_TableInsertMaxLengthLine";
	local sTmp = sLine;
	local SeparList = {" ", "-", ".", ",", ":", ";"};
	local sColor = "";
	if (sColorPrefix) then
		sColor = sColorPrefix;
	end
	while (string.len(sTmp) > 0) do
		if (string.len(sTmp) <= iMaxLen) then
			table.insert(Lines, sColor..sTmp);
			sTmp = "";
		else
			local iPos = iMaxLen;
			local sChar = string.sub(sTmp, iPos, iPos);
			while (iPos > iMaxLen - iThreshold) and not (intable(sChar, SeparList)) do
				iPos = iPos - 1;
				sChar = string.sub(sTmp, iPos, iPos);
			end
			if (intable(sChar, SeparList)) then
				table.insert(Lines, sColor..string.sub(sTmp, 1, iPos));
				sTmp = string.sub(sTmp, iPos+1, string.len(sTmp));
			else
				table.insert(Lines, sColor..string.sub(sTmp, 1, iMaxLen));
				sTmp = string.sub(sTmp, iMaxLen+1, string.len(sTmp));
			end
		end
	end

end



-- --------------------------------------------------------------------------------------
-- ifnil
-- --------------------------------------------------------------------------------------
-- Return input value if it's not nil, else return alternative value specified.
-- --------------------------------------------------------------------------------------
function ifnil( iVal, iNewVal)
	if ( iVal == nil) then
		return iNewVal;
	else
		return iVal;
	end
end


-- --------------------------------------------------------------------------------------
-- snil
-- --------------------------------------------------------------------------------------
-- Return the input string, or the string "nil" if the variable is nil
-- --------------------------------------------------------------------------------------
function snil_old( Val )
	if ( Val == nil ) then
		return TXT_NIL;
	else
		return Val;
	end
end

function snil( Val )
	if ( Val == nil ) then
		return TXT_NIL;
	else
		if ( Val == true) then
			return "true";
		elseif ( Val == false) then
			return "false";
		else
			return Val;
		end
	end
end


-- --------------------------------------------------------------------------------------
-- copytable
-- --------------------------------------------------------------------------------------
-- Make a copy of a table
-- --------------------------------------------------------------------------------------
function copytable(MyTable)
	if (type(MyTable) ~= "table" ) then
		return MyTable;
	end
	local idx, val;
	local NewTable = {};
	for idx, val in MyTable do
		NewTable[idx] = copytable(val);
	end
	return NewTable;
end


-- --------------------------------------------------------------------------------------
-- intable
-- --------------------------------------------------------------------------------------
-- Return true if "Val" is in table "TheTable"
-- --------------------------------------------------------------------------------------
function intable( Val, TheTable)
	local idx, TableValue;
	for idx, TableValue in TheTable do
		if Val == TableValue then
			return true;
		end
	end
	return false;
end


-- remove "Val" if found in list "TheTable"
-- return resulting list
function removefromlist( Val, TheTable )
	local MyTable = TheTable;
	local iSize = table.getn(MyTable);
	local i = 1;
	while (i <= iSize) do
		if (MyTable[i] == Val) then
			table.remove(MyTable, i);
			iSize = iSize - 1;
		else
			i = i + 1;
		end
	end
	return MyTable;
end


-- --------------------------------------------------------------------------------------
-- appendtables
-- --------------------------------------------------------------------------------------
-- Append several list tables and returns the resulting table.
-- Can take single elements also, in that case convert them to tables.
-- --------------------------------------------------------------------------------------
function appendtables( ... )

	local TableRes = { };
	local iNbArg = arg.n;
	local i;

	for i=1, iNbArg do
		local MyTable;
		local Table = arg[i];
		if (type(Table) ~= "table" ) then
			MyTable = { Table };
		else
			MyTable = Table;
		end

		local idx, TableValue;
		for idx, TableValue in MyTable do
			table.insert(TableRes, TableValue);
		end
	end

	return TableRes;
end


-- --------------------------------------------------------------------------------------
-- mergetables
-- --------------------------------------------------------------------------------------
-- Merge two list tables and returns the resulting table.
-- If both tables contain the same indexes, the first tables values will be returned for
-- this index.
-- Recursively merge sub tables if needed.
-- --------------------------------------------------------------------------------------
function mergetables(Table1, Table2)

	if (type(Table1) ~= "table") and (type(Table2) ~= "table") then
		return Table1;
	end
	if (type(Table1) ~= "table") then
		return Table2;
	end
	if (type(Table2) ~= "table") then
		return Table1;
	end

	local idx, TableValue;
	local TableRes = Table1;
	for idx, TableValue in Table2 do
		if (not Table1[idx]) then
			TableRes[idx] = TableValue;
		else
			TableRes[idx] = mergetables(Table1[idx], TableValue);

		end
	end

	return TableRes;
end


-- --------------------------------------------------------------------------------------
-- revlist
-- --------------------------------------------------------------------------------------
-- Returns a list in reverse order
-- --------------------------------------------------------------------------------------
function revlist(ListIn)
	local ListOut = {};
	local MyList;

	if (type(ListIn) ~= "table" ) then
		MyList = { ListIn };
	else
		MyList = ListIn;
	end

	local idx, TableValue;
	for idx, TableValue in MyList do
		table.insert(ListOut, 1, TableValue);
	end

	return ListOut;
end


function tablesize(Table)
	local idx, val
	local iSize = 0
	for idx, val in Table do
		iSize = iSize + 1;
	end
	return iSize;
end



-- **************************************************************************************
-- Logs, debug and display functions
-- **************************************************************************************

-- --------------------------------------------------------------------------------------
-- SkM_Trace
-- --------------------------------------------------------------------------------------
-- Debug function. Display information on screen, or on the default chat frame.
--   FName = calling function name
--   Level = level of trace, used to check if this debug will be displayed
--   Message = message to trace
-- --------------------------------------------------------------------------------------
function SkM_Trace( FName, Level, Message )
	local OutMessage;

	if (Level <= SKM_Config.DebugLevel) then

		if (SKM_Config.DebugMaxFuncLen) and (string.len(FName) > SKM_Config.DebugMaxFuncLen) then
			if (SKM_Config.DebugMaxFuncLen < 10) then
				OutMessage = string.sub(FName, 1, SKM_Config.DebugMaxFuncLen).."/"..snil(Message);
			else
				OutMessage = string.sub(FName, 1, SKM_Config.DebugMaxFuncLen - 7)..".."
				             ..string.sub(FName, string.len(FName)-4, string.len(FName)).."/"..snil(Message);
			end
		else
			OutMessage = FName.."/"..snil(Message);
		end

		if (SKM_Config.RecordDebug) then
			local sDate = SkM_GetDate();
			local sRecordMsg = "["..sDate.."]<"..Level.."> "..snil(FName).."/"..snil(Message);
			table.insert(SKM_Debug, sRecordMsg);

			SKM_Context.RecLines = SKM_Context.RecLines + 1;
			SKM_Context.TmpRecLines = SKM_Context.TmpRecLines + 1;
			if (SKM_Context.TmpRecLines >= SKM_Config.RecordIntervalInfo) then
				SkM_ChatMessageCol("Lines recorded : "..SKM_Context.RecLines.." (Total : "..table.getn(SKM_Debug)..")");
				SKM_Context.TmpRecLines = 0;
			end

			return;
		end

		if (SKM_TRACE_MODE == SKM_TRACE_MODE_PRINT) then
			print(OutMessage);
		elseif (SKM_TRACE_MODE == SKM_TRACE_MODE_CHATMSG) then
			if not DEFAULT_CHAT_FRAME then
				return;
			end
			local r = SKM_Config.RGB_Debug[Level].r;
			local g = SKM_Config.RGB_Debug[Level].g;
			local b = SKM_Config.RGB_Debug[Level].b;
			SkM_PrintMessage(OutMessage, r, g, b);  -- PIng: Bug Fix.Replace ShM_PrintMessage by SkM_PrintMessage
		end
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_PrintMessage
-- --------------------------------------------------------------------------------------
-- Display a message in a frame in a specified RGB color, calling Blizz function
-- <frame>:AddMessage.
-- I don't know what the two last parameters stand for :/
-- --------------------------------------------------------------------------------------
function SkM_PrintMessage(msg, r, g, b, frame, id, unknown4th)
	local OutMessage;

	if(unknown4th) then
		local temp = id;
		id = unknown4th;
		unknown4th = id;
	end

	OutMessage = snil(msg);

	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 1.0; end
	if ( frame ) then
		frame:AddMessage(OutMessage, r, g, b, id, unknown4th);
	else
		if ( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage(OutMessage, r, g, b, id, unknown4th);
		end
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_ChatMessageCol
-- --------------------------------------------------------------------------------------
-- Display a message on the default chat frame, with the module prefix.
-- Color is the module global chat color, if it has been set (default : white).
-- --------------------------------------------------------------------------------------
function SkM_ChatMessageCol( Message )
	local OutMessage;
	local r = SKM_Config.RGB_Msg.r;

	local g = SKM_Config.RGB_Msg.g;
	local b = SKM_Config.RGB_Msg.b;

	if not DEFAULT_CHAT_FRAME then
		return;
	end
	OutMessage = SKM_MESSAGE_PREFIX..snil(Message);
	SkM_PrintMessage(OutMessage, r, g, b);
end


-- --------------------------------------------------------------------------------------
-- SkM_ChatMessageColP
-- --------------------------------------------------------------------------------------
-- Display a message on the default chat frame, with the module prefix.
-- RBGTriplet specifies the text color.
-- --------------------------------------------------------------------------------------
function SkM_ChatMessageColP( Message, RGBTriplet )
	local OutMessage;
	local r = RGBTriplet.r;
	local g = RGBTriplet.g;
	local b = RGBTriplet.b;

	if not DEFAULT_CHAT_FRAME then
		return;
	end
	OutMessage = SKM_MESSAGE_PREFIX..snil(Message);
	SkM_PrintMessage(OutMessage, r, g, b);
end







-- --------------------------------------------------------------------------------------
-- SkM_Initialize
-- --------------------------------------------------------------------------------------
-- Module initialization
-- --------------------------------------------------------------------------------------
function SkM_Initialize()

	SKM_Context = {

		MapOpen = false;

		-- record damage done by player to enemies
		EnemyCombat = { };

		-- record damage done by enemies to player
		PlayerCombat = { };


		-- record recent enemy kills
		RecentEnemyKill = { };

		-- record recent WAR warnings to reduce spam
		RecentWarWarning = { };

		--DuelEnemy = nil;

		-- list of player names in group
		GroupList = { };

		-- list of player names in guild
		GuildList = { };

		-- list of notes associated to a physical POI on the world map
		WorldMapPOINotes = { };

		PlayerAlive = true;

		DataInit = false;

		-- parse patterns
		Pattern = { };

	};

	SKM_Context.Continents = { GetMapContinents() } ;
	SKM_Context.Zones = { };

	for idx, val in SKM_Context.Continents do
		SKM_Context.Zones[idx] = { GetMapZones(idx) } ;
	end

	SkM_BuildParsePatterns();

	SKM_Context.Race = {
		IndexToString = {
			[1] = SKM_RACE.Dwarf;
			[2] = SKM_RACE.Gnome;

			[3] = SKM_RACE.Human;
			[4] = SKM_RACE.NightElf;
			[5] = SKM_RACE.Orc;
			[6] = SKM_RACE.Tauren;

			[7] = SKM_RACE.Troll;
			[8] = SKM_RACE.Undead;
		};
		StringToIndex = {
			[SKM_RACE.Dwarf] = 1;
			[SKM_RACE.Gnome] = 2;
			[SKM_RACE.Human] = 3;
			[SKM_RACE.NightElf] = 4;
			[SKM_RACE.Orc] = 5;
			[SKM_RACE.Tauren] = 6;
			[SKM_RACE.Troll] = 7;
			[SKM_RACE.Undead] = 8;
		};
	};


	SKM_Context.Class = {
		IndexToString = {
			[1] = SKM_CLASS.Druid;
			[2] = SKM_CLASS.Hunter;
			[3] = SKM_CLASS.Mage;
			[4] = SKM_CLASS.Paladin;
			[5] = SKM_CLASS.Priest;
			[6] = SKM_CLASS.Rogue;
			[7] = SKM_CLASS.Shaman;
			[8] = SKM_CLASS.Warrior;
			[9] = SKM_CLASS.Warlock;
		};
		StringToIndex = {
			[SKM_CLASS.Druid] = 1;
			[SKM_CLASS.Hunter] = 2;
			[SKM_CLASS.Mage] = 3;
			[SKM_CLASS.Paladin] = 4;
			[SKM_CLASS.Priest] = 5;
			[SKM_CLASS.Rogue] = 6;
			[SKM_CLASS.Shaman] = 7;
			[SKM_CLASS.Warrior] = 8;
			[SKM_CLASS.Warlock] = 9;
		};
	};

	SkM_InitData(false);
end


-- --------------------------------------------------------------------------------------
-- SkM_InitData

-- --------------------------------------------------------------------------------------
-- Initialization of data saved across sessions
-- --------------------------------------------------------------------------------------
function SkM_InitData(bForceInit)
	local FName = "SkM_InitData";

	-- context not yet created
	if (not SKM_Context) then
		return false;
	end

	-- initialization already performed
	if (SKM_Context.DataInit == true) and (not bForceInit) then
		return true;
	end

	_PlayerName = SkM_UnitName(SKM_UNIT_PLAYER);
	_RealmName = GetCVar("realmName");

	-- if player name or realm name can't be retrieved yet, abort initialization
	if (not _PlayerName) or (not _RealmName) then
		return false;
	end

	SKM_Context.PlayerName = _PlayerName;
	SKM_Context.RealmName = _RealmName;

	-- store player current level, because we get old level upon event "level up", but I'm
	-- not sure it would always be the case.
	--SKM_Context.PlayerLevel = UnitLevel(SKM_UNIT_PLAYER);
	-- since 1.5 it returns 0 at this point... have to do it later.

	-- global module data
	if (not SKM_Data) then
		SKM_Data = { } ;
	end

	-- for recording debug messages
	if (not SKM_Debug) then
		SKM_Debug = { };
	end

	-- module data for current realm
	if (not SKM_Data[_RealmName]) then
		SKM_Data[_RealmName] = { };
	end

	-- module data for current player of current realm
	if (not SKM_Data[_RealmName][_PlayerName]) then
		SKM_Data[_RealmName][_PlayerName] = { };
		SKM_Data[_RealmName][_PlayerName].PlayerName = SKM_Context.PlayerName;

		local sDate = SkM_GetDate();
		SKM_Data[_RealmName][_PlayerName].InitDate = sDate;
	end
	
	-- dunno when it happenned, but some chars do not have a "PlayerName". Fix it...
	if (not SKM_Data[_RealmName][_PlayerName].PlayerName) then
		SKM_Data[_RealmName][_PlayerName].PlayerName = _PlayerName;						
	end

	-- sub maps of player data

	if (not SKM_Data[_RealmName][_PlayerName].GlobalMapData) then
		SKM_Data[_RealmName][_PlayerName].GlobalMapData = { };
	end
	if (not SKM_Data[_RealmName][_PlayerName].MapData) then
		SKM_Data[_RealmName][_PlayerName].MapData = { };

		local idx_c, val_c;
		for idx_c, val_c in SKM_Context.Continents do
			SKM_Data[_RealmName][_PlayerName].MapData[idx_c] = { };

			local idx_z, val_z
			for idx_z, val_z in SKM_Context.Zones[idx_c] do
				SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z] = { };
			end
		end
	end

	if (not SKM_Data[_RealmName][_PlayerName].EnemyHistory) then
		SKM_Data[_RealmName][_PlayerName].EnemyHistory = { };
	end

	-- 09/04/2005 16:28:31 PIng: Add Guild support
	if (not SKM_Data[_RealmName][_PlayerName].GuildHistory) then
		SKM_Data[_RealmName][_PlayerName].GuildHistory = { };
	end

	if (not SKM_Data[_RealmName][_PlayerName].UnknownEnemy) then
		SKM_Data[_RealmName][_PlayerName].UnknownEnemy = { };
	end

	if (not SKM_Data[_RealmName][_PlayerName].DuelHistory) then
		SKM_Data[_RealmName][_PlayerName].DuelHistory = { };
	end

	if (not SKM_Data[_RealmName][_PlayerName].BGStats) then
		SKM_Data[_RealmName][_PlayerName].BGStats = { };
	end


	local sGuildName = GetGuildInfo(SKM_UNIT_PLAYER);
	SkM_Trace(FName, 3, "Player guild = "..snil(sGuildName));
	if (sGuildName) and (sGuildName ~= "") and (false) then
  	-- build guild list : open guild roster to retrieve guild players list
		GuildRoster();
		--SetGuildRosterShowOffline(1);
  	SkM_BuildGuildList();
  	--FriendsFrame:Hide();
  	HideUIPanel(FriendsFrame);
  end

	-- Global settings
	if (not SKM_Settings) then
		SKM_Settings = { };
	end
	SkM_LoadDefaultSettings(false);

	SkM_RecordVersionHistory();

	SKM_Context.DataInit = true;
	SkM_Trace(FName, 3, "Done");
	return true;
end


-- --------------------------------------------------------------------------------------
-- SkM_LoadDefaultSettings
-- --------------------------------------------------------------------------------------
-- Load (or reload) setting default values from configuration file
-- --------------------------------------------------------------------------------------
function SkM_LoadDefaultSettings(bForceReload)
	local FName = "SkM_LoadDefaultSettings";

	if (not SKM_Settings) then
		SKM_Settings = { };
	end

	if (bForceReload) then

		SkM_Trace(FName, 3, "Force reload default settings");

		for i=1, table.getn(SKM_OPTION_LIST), 1 do
			local key = SKM_OPTION_LIST[i];
			SKM_Settings[key] = SKM_Config[key];
		end

	else
		SkM_Trace(FName, 3, "Load missing default settings");

		for i=1, table.getn(SKM_OPTION_LIST), 1 do
			local key = SKM_OPTION_LIST[i];
			SkM_Trace(FName, 3, "key = "..key);
			if (SKM_Settings[key] == nil) then
				SKM_Settings[key] = SKM_Config[key];
			end
		end

	end

	if (SKM_Settings.CreatureKillRecordsByZone > SKM_MAX_CREEP_RECORD_BY_ZONE) then
		SKM_Settings.CreatureKillRecordsByZone = SKM_MAX_CREEP_RECORD_BY_ZONE;
	end


	-- for management of data migration. No use for now, but might be needed later on.
	if (SKM_Settings.DataModel == nil) then
		SKM_Settings.DataModel = SKM_VERSION;
	else
		SKM_Settings.DataModel = SKM_VERSION;
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ResetData
-- --------------------------------------------------------------------------------------
-- Warning : this deletes ALL module data (for all players and realms)
-- Use with caution !
-- --------------------------------------------------------------------------------------
function SkM_ResetData()
	SKM_Data = nil;
	SkM_InitData(true);
end


-- --------------------------------------------------------------------------------------
-- SkM_ResetPlayerData
-- --------------------------------------------------------------------------------------
-- Delete all current player data
-- --------------------------------------------------------------------------------------
function SkM_ResetPlayerData()
	SKM_Data[_RealmName][_PlayerName] = nil;
	SkM_InitData(true);
end


-- --------------------------------------------------------------------------------------
-- SkM_ResetPlayerData
-- --------------------------------------------------------------------------------------
-- Delete current player map data only
-- --------------------------------------------------------------------------------------
function SkM_ResetPlayerMapData()
	SKM_Data[_RealmName][_PlayerName].GlobalMapData = nil;
	SKM_Data[_RealmName][_PlayerName].MapData = nil;
	SkM_InitData(true);
end


-- --------------------------------------------------------------------------------------
-- SkM_ResetAccountMapData
-- --------------------------------------------------------------------------------------
-- Delete all map data on a given account
-- USE WITH CAUTION !!!
-- --------------------------------------------------------------------------------------
function SkM_ResetAccountMapData()
	local FName = "SkM_ResetAccountMapData";

	local idx_realm, val_realm, idx_char, val_char, idx_enemy, val_enemy;

	for idx_realm, val_realm in SKM_Data do
		for idx_char, val_char in SKM_Data[idx_realm] do

			if (SKM_Data[idx_realm][idx_char].PlayerName == idx_char) then
				SkM_Trace(FName, 1, "Cleaning for "..idx_realm.." / "..idx_char);

				-- clean up map data
				SKM_Data[idx_realm][idx_char].GlobalMapData = nil;
				SKM_Data[_RealmName][_PlayerName].MapData = nil;

				-- clean up zone stored in enemy information
				for idx_enemy, val_enemy in SKM_Data[idx_realm][idx_char].EnemyHistory do
					SKM_Data[idx_realm][idx_char].EnemyHistory[idx_enemy][_SKM._continent] = nil;
					SKM_Data[idx_realm][idx_char].EnemyHistory[idx_enemy][_SKM._zone] = nil;
					SKM_Data[idx_realm][idx_char].EnemyHistory[idx_enemy][_SKM._xPos] = nil;
					SKM_Data[idx_realm][idx_char].EnemyHistory[idx_enemy][_SKM._yPos] = nil;
				end
			end
		end
	end

	SkM_InitData(true);
end


-- --------------------------------------------------------------------------------------
-- SkM_GetOption
-- --------------------------------------------------------------------------------------
-- Get a player option value
-- --------------------------------------------------------------------------------------
function SkM_GetOption(sConfigKey)
	local FName = "SkM_GetOption";
	if (SKM_Settings == nil) then
		SkM_Trace(FName, 1, "Settings not initialized, can't get value for "..snil(sConfigKey));
		return;
	end
	if (sConfigKey == nil) then
		SkM_Trace(FName, 1, "received nil param");
		return;
	end
	--return (SKM_Data[_RealmName][_PlayerName].Settings[sConfigKey]);
	return (SKM_Settings[sConfigKey]);
end


-- --------------------------------------------------------------------------------------
-- SkM_SetOption
-- --------------------------------------------------------------------------------------
-- Set a player option to a given value
-- --------------------------------------------------------------------------------------
function SkM_SetOption(sConfigKey, Value)
	local FName = "SkM_SetOption";
	if (SKM_Settings == nil) then
		SkM_Trace(FName, 1, "Settings not initialized, can't set value for "..snil(sConfigKey));
		return;
	end
	if (sConfigKey == nil) then
		SkM_Trace(FName, 1, "received nil param");
		return;
	end
	--SKM_Data[_RealmName][_PlayerName].Settings[sConfigKey] = Value;
	SKM_Settings[sConfigKey] = Value;
end


function SkM_GetRaceText(Index)
	return SKM_Context.Race.IndexToString[Index];
end

function SkM_GetRaceIndex(Text)
	return SKM_Context.Race.StringToIndex[Text];
end

function SkM_GetClassText(Index)
	return SKM_Context.Class.IndexToString[Index];
end

function SkM_GetClassIndex(Text)
	return SKM_Context.Class.StringToIndex[Text];
end


-- --------------------------------------------------------------------------------------
-- SkM_ExtractParam
-- --------------------------------------------------------------------------------------
-- Extract parameters from a string. Delimiter is the blank character (space).
-- Return the first parameter and the rest of the string ("" if empty).
-- --------------------------------------------------------------------------------------
function SkM_ExtractParam(msg)
	local params = msg;
	local command = params;
	local index = strfind(command, " ");

	if ( index ) then
		command = strsub(command, 1, index-1);
		params = strsub(params, index+1);
	else
		params = "";
	end
	return command, params;
end


-- --------------------------------------------------------------------------------------
-- SkM_IdentifyCommand
-- --------------------------------------------------------------------------------------
-- Check if the given command matches a module command.
-- it's the case if the passed in command starts with the module command
-- eg. : module command "fort" allows to type in "fortitude".
-- --------------------------------------------------------------------------------------
function SkM_IdentifyCommand(sCmd, sModuleCommand)

	if ((not sModuleCommand) or (sModuleCommand == "")) then
		return false;
	end
	if ((not sCmd) or (sCmd == "")) then
		return false;
	end

	local iLen = string.len(sModuleCommand);

	if ( string.sub(sCmd, 1, iLen) == sModuleCommand) then
		return true;
	else
		return false;
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_SetDebugLevel
-- --------------------------------------------------------------------------------------
-- Set the module debug level (-1, 0, 1, 2, 3)
-- --------------------------------------------------------------------------------------
function SkM_SetDebugLevel( iLevel )
	local iNewLevel = ifnil(iLevel, -1);

	SKM_Config.DebugLevel = iNewLevel;
	SkM_ChatMessageCol("Debug level set to "..iNewLevel);
end


function SkM_StartDebugRecord()
	SKM_Context.RecLines = 0;
	SKM_Context.TmpRecLines = 0;
	SKM_Config.RecordDebug = true;
	SkM_ChatMessageCol("Started recording debug messages");
end


function SkM_StopDebugRecord()
	SKM_Config.RecordDebug = false;
	SKM_Context.RecLines = nil;
	SKM_Context.TmpRecLines = nil;
	SkM_ChatMessageCol("Stopped recording debug messages");
end


function SkM_ClearDebugRecord()
	SKM_Debug = { };
	SKM_Context.RecLines = 0;
	SKM_Context.TmpRecLines = 0;
	SkM_ChatMessageCol("Recorded debug messages cleared");
end



-- --------------------------------------------------------------------------------------
-- SkM_GetDate
-- --------------------------------------------------------------------------------------
-- Get current date in two formats :
-- DD/MM/YYYY HH:MI:SS
-- YYYY/MM/DD HH:MI:SS (this is a sortable date)
-- --------------------------------------------------------------------------------------
function SkM_GetDate()
	-- date is a shortcut to "os.date" (os package is not available, but Blizz provided
	-- us the date function :)
	local CurDate = date("*t");
	local sYear = string.format("%0.04d", CurDate.year);
	local sMonth = string.format("%0.02d", CurDate.month);
	local sDay = string.format("%0.02d", CurDate.day);
	local sHour = string.format("%0.02d", CurDate.hour);
	local sMin = string.format("%0.02d", CurDate.min);
	local sSec = string.format("%0.02d", CurDate.sec);

	-- date in format DD/MM/YYYY HH:MI:SS
	local StrDate1 = sDay.."/"..sMonth.."/"..sYear.." "..sHour..":"..sMin..":"..sSec;

	-- date in format YYYY/MM/DD HH:MI:SS (useful for sorting !)
	local StrDate2 = sYear.."/"..sMonth.."/"..sDay.." "..sHour..":"..sMin..":"..sSec;

	return StrDate1, StrDate2;
end


function SkM_GetDay()
	local sDate1, sDate2 = SkM_GetDate();
	local sDay1, sDay2;
	sDay1 = string.sub(sDate1, 1, 10);
	sDay2 = string.sub(sDate2, 1, 10);
	return sDay1, sDay2;
end


-- --------------------------------------------------------------------------------------
-- SkM_GetSortableDate
-- --------------------------------------------------------------------------------------
-- Convert date to sortable format :
-- from DD/MM/YYYY HH:MI:SS format to YYYY/MM/DD HH:MI:SS format
-- or, from DD/MM/YYYY format to YYYY/MM/DD format
-- --------------------------------------------------------------------------------------
function SkM_GetSortableDate(sDate)
	if (not sDate) then
		return nil;
	end

	local sMonth, sDay, sYear, sHour, sMin, sSec;
	local sSortDate;

	sDay = string.sub(sDate, 1, 2);
	sMonth = string.sub(sDate, 4, 5);
	sYear = string.sub(sDate, 7, 10);

	if (string.len(sDate) == 19) then
		sHour = string.sub(sDate, 12, 13);
		sMin = string.sub(sDate, 15, 16);
		sSec = string.sub(sDate, 18, 19);

		SortDate = sYear.."/"..sMonth.."/"..sDay.." "..sHour..":"..sMin..":"..sSec;
	else
		SortDate = sYear.."/"..sMonth.."/"..sDay;
	end

	-- sortable date
	return SortDate;
end


function SkM_GetZoneText()
	local sText = GetZoneText();
	-- apply fix if needed.
	for idx, val in SKM_ZoneFix do
		if sText == val.Val_ZoneText then
			return val.Val_MapZones;
		end
	end
	return sText;
end


-- Return continent and zone number shifted to english order
function SkM_GetCurrentMapZone_Shift()
	local FName = "SkM_GetCurrentMapZone_Shift";

	local iCont = GetCurrentMapContinent();
	local iZone = GetCurrentMapZone();
	if (iCont) and (iCont ~= 0) and (iZone) and (iZone ~= 0) and (SKM_ZoneShift) then
		if (SKM_ZoneShift[iCont]) and (SKM_ZoneShift[iCont][iZone]) then
			iZone = SKM_ZoneShift[iCont][iZone];
		else
			SkM_Trace(FName, 1, "Undefined shift : cont = "..iCont.." / zone = "..iZone);
		end
	end
	return iCont, iZone;
end


-- --------------------------------------------------------------------------------------
-- SkM_GetZone
-- --------------------------------------------------------------------------------------
-- Return continent and zone number
-- or (nil, nil) if GetZoneText() does not match any known zone
-- --------------------------------------------------------------------------------------
function SkM_GetZone()
	for i=1, getn(SKM_Context.Continents), 1 do
		for j=1, getn(SKM_Context.Zones[i]), 1 do
			--if (SKM_Context.Zones[i][j] == GetZoneText()) then
			if (SKM_Context.Zones[i][j] == SkM_GetZoneText()) then
				return i, j;
			end
		end
	end
	return nil, nil;
end


function SkM_GetZone_Shift(p_iCont, p_iZone)
	local iCont, iZone;
	if (p_iCont) and (p_iZone) then
		iCont = p_iCont;
		iZone = p_iZone;
	else
		iCont, iZone = SkM_GetZone();
	end

	if (iCont) and (iZone) and (SKM_ZoneShift) then
		iZone = SKM_ZoneShift[iCont][iZone];
	end
	return iCont, iZone;
end


-- get zone text from shifted zone index (english order)
function SkM_GetZoneTextFromIndex(p_iCont, p_iZone)
	return ifnil(SKM_ZoneText[p_iCont][p_iZone], "");
end


function SkM_IsInBattleground()
	local FName = "SkM_IsInBattleground";
	local sZone = SkM_GetZoneText();
	if (intable(sZone, SKM_BATTLEGROUNDS)) then
		return true;
	else
		return false;
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_CheckNearNotes
-- --------------------------------------------------------------------------------------
-- Check if there are notes nearby given location
-- OBSOLETE. I don't use it any more.
-- --------------------------------------------------------------------------------------
function SkM_CheckNearNotes(idx_c, idx_z, xPos, yPos, icon)
	local iNoteCount = getn(SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z]);

	for i=1, iNoteCount, 1 do
		local idx_gn = SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z][i];
		local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[idx_gn];

		if (abs(Note[_SKM._xPos] - xPos) <= 0.0009765625 * SKM_Config.MapNotes_MinDiff)
		and (abs(Note[_SKM._yPos] - yPos) <= 0.0013020833 * SKM_Config.MapNotes_MinDiff)
		then
			return true;
		end
	end
	return false;
end


-- --------------------------------------------------------------------------------------
-- SkM_FindNotePOINum
-- --------------------------------------------------------------------------------------
-- Retrieve which POI object is associated to a given map note
-- --------------------------------------------------------------------------------------
function SkM_FindNotePOINum(idx_n)
	for idx_poi, val_poi in SKM_Context.WorldMapPOINotes do
		if (intable(idx_n, val_poi)) then
			return idx_poi;
		end
	end
	return nil;
end


-- --------------------------------------------------------------------------------------
-- SkM_CheckNearNotesPOI
-- --------------------------------------------------------------------------------------
-- For a given map note, try and find nearby allocated POI so that we may group
-- current note to the notes associated to this POI.
-- --------------------------------------------------------------------------------------
function SkM_CheckNearNotesPOI(idx_c, idx_z, xPos, yPos, index, DiscardedNotes)
	local iNoteCount = getn(SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z]);

	local i;
	for i=1, iNoteCount, 1 do
		-- don't check notes > current note, because they've not been treated yet
		if (i == index) then
			return nil;
		end

		if (intable(i, DiscardedNotes)) then
			-- that note has been discarded, so don't check if it's too close !
		else
			local idx_gn = SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z][i];
			local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[idx_gn];

			if (abs(Note[_SKM._xPos] - xPos) <= 0.0009765625 * SKM_Config.MapNotes_MinDiff)
			and (abs(Note[_SKM._yPos] - yPos) <= 0.0013020833 * SKM_Config.MapNotes_MinDiff)
			then
				-- we're close to another note that has an associated POI
				-- find this POI number and return it
				local iPOINum = SkM_FindNotePOINum(i);
				return iPOINum;
			end
		end
	end
	return nil;
end


-- --------------------------------------------------------------------------------------
-- SkM_AddMapNote
-- --------------------------------------------------------------------------------------
-- Add a new player map note
-- --------------------------------------------------------------------------------------
function SkM_AddMapNote(idx_c, idx_z, Note)
	local FName = "SkM_AddMapNote";

	-- insert note to global data in last position
	table.insert(SKM_Data[_RealmName][_PlayerName].GlobalMapData, Note);

	-- retrieve index of inserted note
	local idx_gn = table.getn(SKM_Data[_RealmName][_PlayerName].GlobalMapData);

	-- insert new global note index to map note list
	table.insert(SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z], idx_gn);
end


-- --------------------------------------------------------------------------------------
-- SkM_AddMapData
-- --------------------------------------------------------------------------------------
-- Create a new note from input stored data and store it in current zone records
-- --------------------------------------------------------------------------------------
function SkM_AddMapData(p_StoreInfo)
	local FName = "SkM_AddMapData";

	local idx_c, idx_z = SkM_GetZone();

	SkM_Trace(FName, 3, "idx_c = "..snil(idx_c)..", idx_z = "..snil(idx_z));

	if (idx_z) then
		SetMapZoom(idx_c, idx_z);
		local xPos, yPos = GetPlayerMapPosition(SKM_UNIT_PLAYER);

		local cont_shift, zone_shift = SkM_GetZone_Shift(idx_c, idx_z);

		SkM_Trace(FName, 3, "Player Position : x = "..snil(xPos)..", y = "..snil(yPos));

		--if ((not SkM_CheckNearNotes(idx_c, idx_z, xPos, yPos, icon)) and xPos ~= 0 and yPos ~= 0 ) then
		if (xPos ~= 0 and yPos ~= 0) then

			local Note = { };
			--Note[_SKM._continent] = idx_c;
			--Note[_SKM._zone] = idx_z;
			Note[_SKM._continent] = cont_shift;
			Note[_SKM._zone] = zone_shift;
			Note[_SKM._xPos] = xPos;
			Note[_SKM._yPos] = yPos;
			Note[_SKM._storedInfo] = p_StoreInfo;

			-- DOH !! forgot this one in 1.4. Now all records are messed up :(
			--SkM_AddMapNote(idx_c, idx_z, Note);
			SkM_AddMapNote(cont_shift, zone_shift, Note);
			SKM_Context.RecordingDisabled = false;
			return true;
		end
	end

	if (not SKM_Context.RecordingDisabled) then
		-- 1.5 : removed message that is of no use !
		--SkM_ChatMessageCol("Event recording is disabled in this location");
		SKM_Context.RecordingDisabled = true;
	end

	return false;
end


-- --------------------------------------------------------------------------------------
-- SkM_RecordPlayerDeath
-- --------------------------------------------------------------------------------------
-- Record player death event.
-- Find if it's a PvE or PvP or unknown death, determine responsibilities for this
-- death, and create a record of the appropriate type.
-- --------------------------------------------------------------------------------------
function SkM_RecordPlayerDeath()
	local FName = "SkM_RecordPlayerDeath";

	local StoreInfo = { };

	StoreInfo[_SKM._type] = _SKM._playerDeath;

	local sDate1, sDate2 = SkM_GetDate();
	StoreInfo[_SKM._date] = sDate1;
	--StoreInfo[_sortdate] = sDate2;

	local sKiller, KillerType, HateList = SkM_PlayerDeathResp();

	-- check if in battleground
	local bBattleground = SkM_IsInBattleground();

	-- if killer is known, and if its type (player or creature) is also known, record
	-- specific death event

	-- note : it's possible that we determined that a given unit is responsible for our
	-- death, but we don't know if it's a player or a creature. It can happen if this
	-- unit killed us with dots only. In that case, the death type will be undetermined.

	-- addition : it can happen also because pets and players trigger the same events, thus
	-- if we never targetted or mouse-overed a given player, we will not know if he is
	-- a player or a pet.

	if (sKiller) and (KillerType == nil) then
		-- try to target to see if this is a player
		TargetByName(sKiller);
		SkM_UpdateUnitData();

		-- if this is an enemy player, then he should have been stored !
		if (SKM_Data[_RealmName][_PlayerName].EnemyHistory[sKiller]) then
			KillerType = _SKM._enemyPlayer;
		end
	end

	if (sKiller) and (KillerType) then
		StoreInfo[_SKM._name] = sKiller;
		StoreInfo[_SKM._enemyType] = KillerType;

		if (KillerType == _SKM._enemyPlayer) then
			SkM_UpdateEnemyLastView(sKiller, sDate1, false);

			StoreInfo[_SKM._type] = _SKM._playerDeathPvP;

			SkM_UpdateEnemy_IncrKillPlayer(sKiller, 1, bBattleground);

			if (bBattleground) then
				SkM_BGStats_AddDeath();
			end

			-- update target info if needed
			SkM_SetTargetInfo();

		else
			StoreInfo[_SKM._type] = _SKM._playerDeathPvE;
		end
	end

	-- check if world record are disabled, if it's the case return
	if (StoreInfo[_SKM._type] == _SKM._playerDeathPvP) then
		if (not SkM_GetOption("RecordPlayerDeath")) then
			return;
		end
	else
		if (not SkM_GetOption("RecordPlayerDeathNonPvP")) then
			return;
		end
	end


	if (SkM_AddMapData(StoreInfo)) then

		if (SkM_GetOption("DisplayDeathRecord")) then
			if (sKiller) and (KillerType) then
				if (KillerType == _SKM._enemyPlayer) then
					SkM_ChatMessageColP(string.format(SKM_UI_STRINGS.RecordMessage_PlayerPvPDeath, sKiller), SKM_Config.RGB_PlayerPvPDeath);
				else
					SkM_ChatMessageColP(string.format(SKM_UI_STRINGS.RecordMessage_PlayerPvEDeath, sKiller), SKM_Config.RGB_PlayerPvEDeath);
				end
			else
				SkM_ChatMessageColP(SKM_UI_STRINGS.RecordMessage_PlayerDeath, SKM_Config.RGB_PlayerDeath);
			end
		end

	end

	if (SkM_GetOption("ReportPlayerDeath")) then
		local iNbLine = math.min(SKM_Config.ReportDeathMaxLines, table.getn(HateList));
		if (iNbLine > 0) then
			SkM_ChatMessageColP(string.format(SKM_UI_STRINGS.ReportMessage_PlayerDeath, iNbLine),
				SKM_Config.RGB_ReportDeath);

			for i=1, iNbLine, 1 do
				SkM_ChatMessageColP(string.format("%d. %s (%d %%)", i, HateList[i][_SKM._name], HateList[i][_SKM._hatePercent]),
					SKM_Config.RGB_ReportDeath);
			end
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_PlayerAlive
-- --------------------------------------------------------------------------------------
-- Player is back to life, remember it.
-- --------------------------------------------------------------------------------------
function SkM_PlayerAlive()
	SKM_Context.PlayerAlive = true;
end


-- --------------------------------------------------------------------------------------
-- SkM_PlayerDeath
-- --------------------------------------------------------------------------------------
-- Handle player death event.
-- --------------------------------------------------------------------------------------
function SkM_PlayerDeath()
	local FName = "SkM_PlayerDeath";

	-- check if player was alive because in some cases we get two death messages for the
	-- same death
	if (SKM_Context.PlayerAlive == false) then
		SkM_Trace(FName, 3, "Not alive, discard death event");
		return;
	end

	SKM_Context.PlayerAlive = false;

--	if (not SkM_GetOption("RecordPlayerDeath")) then
--		return;
--	end

	SkM_RecordPlayerDeath();
end


-- --------------------------------------------------------------------------------------
-- SkM_WorldMapUpdate
-- --------------------------------------------------------------------------------------
-- Handle World Map Update event
-- --------------------------------------------------------------------------------------
function SkM_WorldMapUpdate()
	local FName = "SkM_WorldMapUpdate";

	if (WorldMapFrame:IsVisible()) then
		-- world map is visible, draw all that need to be !

		--local serverTime = GetTime();
		SKM_Context.MapOpen = true;
		--local mapContinent = GetCurrentMapContinent();
		--local mapZone = GetCurrentMapZone();
		local mapContinent, mapZone = SkM_GetCurrentMapZone_Shift();
		SKM_Context.CloseMap = { continent = mapContinent, zone = mapZone, time = GetTime() };
		SkM_MainDraw();

	elseif (SKM_Context.MapOpen) then
		-- Map is not visible, but recorded as opened. Close it.
		SKM_Context.MapOpen = false;
		SkM_MainDraw();
		--SkM_ChangeMap();
	else
		-- Map not visible, probably closed
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_CloseWorldMap
-- --------------------------------------------------------------------------------------
-- Handle Close World Map event
-- --------------------------------------------------------------------------------------
function SkM_CloseWorldMap()
	local FName = "SkM_CloseWorldMap";

	SKM_Context.MapOpen = false;
	SkM_MainDraw();
	--SkM_ChangeMap();
end


-- --------------------------------------------------------------------------------------
-- SkM_MainDraw
-- --------------------------------------------------------------------------------------
-- Display our records as custom POI on the world map, and hide unused POI.
-- --------------------------------------------------------------------------------------
function SkM_MainDraw()
	local FName = "SkM_MainDraw";

	SKM_Context.WorldMapPOINotes = { };

	local lastUnused = 1;
	local maxNotes = SKM_MAX_MAP_NOTES;
	local iNbNotes = 0;

	--local idx_c = GetCurrentMapContinent();
	--local idx_z = GetCurrentMapZone();
	local idx_c, idx_z = SkM_GetCurrentMapZone_Shift();

	if (idx_c ~= 0) and (idx_z ~= 0)
	  and (SKM_Data[_RealmName][_PlayerName].MapData[idx_c])
	  and (SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z])
	then
		iNbNotes = table.getn(SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z]);
	end

	if (SKM_Context.MapOpen) and (SkM_GetOption("MapDisplayRecords")) then

		if (idx_c ~= 0) and (idx_z ~= 0)
		  and (SKM_Data[_RealmName][_PlayerName].MapData[idx_c])
		  and (SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z])
		then

			--iNbNotes = table.getn(SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z]);

			local DiscardedNotes = { };

			for idx_n, val_n in SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z] do

				local idx_gn = SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z][idx_n];
				local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[idx_gn];

				if (Note[_SKM._xPos]) and (Note[_SKM._yPos]) and (lastUnused <= maxNotes) then
					local iPOINum = SkM_CheckNearNotesPOI(idx_c, idx_z, Note[_SKM._xPos], Note[_SKM._yPos], idx_n, DiscardedNotes);
					if (iPOINum) then
						SkM_Trace(FName, 3, "Already too close POI, discard this one : "..snil(idx_n));

						table.insert(DiscardedNotes, idx_n);

						-- and insert it in the close POI list
						table.insert(SKM_Context.WorldMapPOINotes[iPOINum], idx_n);
					else
						local mainNote = getglobal("SKMapPOI"..lastUnused);

						SKM_Context.WorldMapPOINotes[lastUnused] = { };
						table.insert(SKM_Context.WorldMapPOINotes[lastUnused], idx_n);

						local mnX,mnY;
						mnX = Note[_SKM._xPos] * WorldMapDetailFrame:GetWidth();
						mnY = -Note[_SKM._yPos] * WorldMapDetailFrame:GetHeight();
						mainNote:SetAlpha(0.8);

						-- SkM_Trace(FName, 3, "Attach position : x = "..snil(mnX)..", y = "..snil(mnY));


						mainNote:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", mnX, mnY);
						mainNote:SetFrameLevel(WorldMapPlayer:GetFrameLevel() - 1);
						mainNote.toolTip = idx_n;

						-- icon is determined below

						lastUnused = lastUnused + 1;
					end

				end
			end  -- for map notes

			for i=1, getn(SKM_Context.WorldMapPOINotes), 1 do
				local mainNote = getglobal("SKMapPOI"..i);
				local mainNoteTexture = getglobal("SKMapPOI"..i.."Texture");

				local iNbNotes = getn(SKM_Context.WorldMapPOINotes[i]);
				local icon;

				local iNumOfTypes, iNumOfPlayerKillTypes, iNumOfPlayerDeathTypes,
				      iNumOfCreatureKillTypes, TypeCount = SkM_CountPOIEventType(idx_c, idx_z, i);

				SkM_Trace(FName, 3, "Number of different types = "..iNumOfTypes..", of player kill = "..iNumOfPlayerKillTypes..", of death = "..iNumOfPlayerDeathTypes);

				if (iNumOfTypes == 1) then
					-- several notes, but of a single type. Pick the first !

					local idx_n = SKM_Context.WorldMapPOINotes[i][1];
					local idx_gn = SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z][idx_n];
					local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[idx_gn];

					local noteType = Note[_SKM._storedInfo][_SKM._type];
					SkM_Trace(FName, 3, "Single type = "..noteType);

					icon = SKM_Config.IconsByType[noteType];
					if (not icon) then
						icon = SKM_Config.IconsByType[_SKM._default];
					end

				else

					if (iNumOfPlayerDeathTypes == iNumOfTypes) then
						icon = SKM_Config.IconsByType[_SKM._playerDeath];
					elseif (iNumOfPlayerKillTypes == iNumOfTypes) then
						icon = SKM_Config.IconsByType[_SKM._playerKill];
					elseif (iNumOfCreatureKillTypes == iNumOfTypes) then
						icon = SKM_Config.IconsByType[_SKM._creatureKill_Target];
					elseif (iNumOfPlayerDeathTypes + iNumOfPlayerKillTypes == iNumOfTypes) then
						icon = SKM_Config.IconsByType[_SKM._playerKillAndDeath];
					else
						icon = SKM_Config.IconsByType[_SKM._multiType];
					end

				end

				local texture = SKM_Config.IconPath .. "\\" .. icon;
				SkM_Trace(FName, 3, "texture = "..texture);

				mainNoteTexture:SetTexture(texture);
				mainNote:Show();
			end

		end -- if known zone info
	end -- if display map

	-- hide unused notes
	for i=lastUnused, maxNotes, 1 do
		local mainNote = getglobal("SKMapPOI"..i);
		mainNote:Hide();
	end



	if (not SkM_GetOption("ShowWorldMapControl")) then
		SKMapWorldMapControl:Hide();
	else

		if (SKM_Context.MapOpen) and (idx_z ~= 0) and (iNbNotes > 0) then
			local idx=1;
			local MyButton = getglobal("SKMapWorldMapControl_CheckButton"..idx);
			local ButtonText = getglobal("SKMapWorldMapControl_CheckButton"..idx.."Text");
			ButtonText:SetText(SKM_UI_STRINGS.WorldMap_Button_ShowRecords);

			if (SkM_GetOption("MapDisplayRecords")) then
				MyButton:SetChecked(1);
			else
				MyButton:SetChecked(0);
			end

			SKMapWorldMapControl:Show();
		else
			SKMapWorldMapControl:Hide();
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_CountPOIEventType
-- --------------------------------------------------------------------------------------
-- Count the different types of records attached to a given POI.
-- Will be useful to allocate an icon to this POI.
-- --------------------------------------------------------------------------------------
function SkM_CountPOIEventType(idx_c, idx_z, iPOINum)
	local FName = "SkM_CountPOIEventType";

	local iNbNotes = getn(SKM_Context.WorldMapPOINotes[iPOINum]);
	local TypeCount = { };

	local iPlayerDeathTypes = 0;
	local iPlayerKillTypes = 0;
	local iCreatureKillTypes = 0;

	for i=1, iNbNotes, 1 do
		local idx_n = SKM_Context.WorldMapPOINotes[iPOINum][i];
		local idx_gn = SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z][idx_n];
		local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[idx_gn];

		local noteType = Note[_SKM._storedInfo][_SKM._type];


		if (not TypeCount[noteType]) then
			TypeCount[noteType] = 0;
		end
		TypeCount[noteType] = TypeCount[noteType] + 1;
	end
	local iTypes = 0;
	for idx, val in TypeCount do
		iTypes = iTypes + 1;
		if (idx == _SKM._playerAssistKill) or (idx == _SKM._playerKill) or (idx == _SKM._playerFullKill) then
			iPlayerKillTypes = iPlayerKillTypes + 1;
		elseif (idx == _SKM._playerDeath) or (idx == _SKM._playerDeathPvE) or (idx == _SKM._playerDeathPvP) then
			iPlayerDeathTypes = iPlayerDeathTypes + 1;
		elseif (idx == _SKM._creatureKill_Xp) or (idx == _SKM._creatureKill_Target) then
			iCreatureKillTypes = iCreatureKillTypes + 1;
		end

		SkM_Trace(FName, 3, "Type = "..idx..", Count = "..val);
	end
	return iTypes, iPlayerKillTypes, iPlayerDeathTypes, iCreatureKillTypes, TypeCount;
end


-- --------------------------------------------------------------------------------------
-- SkM_GetNoteMessage
-- --------------------------------------------------------------------------------------
-- Build a note string message from a pattern and an information structure
-- --------------------------------------------------------------------------------------
function SkM_GetNoteMessage(Info, sMessagePattern)
	local FName = "SkM_GetNoteMessage";

	if (not Info) then
		SkM_Trace(FName, 3, "Info is nil");
		return nil;
	end
	if (not sMessagePattern) then
		SkM_Trace(FName, 3, "Pattern is nil");
		return nil;
	end

	local sMessage = sMessagePattern;

	local sVal_Name = ifnil(Info[_SKM._name], "??");
	local sVal_Guild = ifnil(Info[_SKM._guild], "??");
	local sVal_Class = ifnil(Info[_SKM._class], "??");
	local sVal_Race = ifnil(Info[_SKM._race], "??");
	local sVal_Level = ifnil(Info[_SKM._level], "??");
	local sVal_Player = ifnil(_PlayerName, "??");
	local sVal_Date = ifnil(Info[_SKM._date], "??");

	if (sVal_Level == -1) then
		sVal_Level = "++";
	end

	sMessage = string.gsub(sMessage, "%%name", sVal_Name);
	sMessage = string.gsub(sMessage, "%%race", sVal_Race);
	sMessage = string.gsub(sMessage, "%%guild", sVal_Guild);
	sMessage = string.gsub(sMessage, "%%class", sVal_Class);
	sMessage = string.gsub(sMessage, "%%level", sVal_Level);
	sMessage = string.gsub(sMessage, "%%player", sVal_Player);
	sMessage = string.gsub(sMessage, "%%date", sVal_Date);

	return sMessage;
end


-- --------------------------------------------------------------------------------------
-- SkM_FillWorldMapToolTip
-- --------------------------------------------------------------------------------------
-- Builds the ToolTip for one of our custom POI that just got mouse focus.
-- --------------------------------------------------------------------------------------
function SkM_FillWorldMapToolTip(idx_c, idx_z, idx_n, idx_poi)
	local FName = "SkM_FillWorldMapToolTip";

	SkM_Trace(FName, 3, "idx_n = "..snil(idx_n)..", idx_poi = "..snil(idx_poi));
	local iLineCount = 0;

	local idx, val;

	if (not SKM_Context.WorldMapPOINotes[idx_poi]) then
		SkM_Trace(FName, 3, "WorldMapPOINotes not defined for POI "..idx_poi);
		return;
	end
	for idx, val in SKM_Context.WorldMapPOINotes[idx_poi] do

		local idx_gn = SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z][val];
		local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[idx_gn];

		SkM_Trace(FName, 4, "idx_gn = "..snil(idx_gn));

		--local StoredInfo = Note[_SKM._storedInfo];
		local StoredInfo = copytable(Note[_SKM._storedInfo]);

		iLineCount = iLineCount + 1;
		if (iLineCount > SKM_Config.MapNotes_MaxLines) then
			return false;
		end

		local sPattern;
		local sName = StoredInfo[_SKM._name];

		SkM_Trace(FName, 3, "Type = "..snil(StoredInfo[_SKM._type]));
		SkM_Trace(FName, 3, "Name = "..snil(sName)..", Enemy Type = "..snil(StoredInfo[_SKM._enemyType]));

		local Enemy;
		if (sName) then
			if not (StoredInfo[_SKM._enemyType] == _SKM._enemyCreature
			        or StoredInfo[_SKM._type] == _SKM._creatureKill_Target
			        or StoredInfo[_SKM._type] == _SKM._creatureKill_Xp) then
				Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];
			end
		end


		local bNoEnemyData = true;
		if (Enemy) then
			StoredInfo[_SKM._class] = SkM_GetClassText(Enemy[_SKM._class]);
			StoredInfo[_SKM._race] = SkM_GetRaceText(Enemy[_SKM._race]);
			StoredInfo[_SKM._level] = Enemy[_SKM._level];

			if (StoredInfo[_SKM._class]) or (StoredInfo[_SKM._race]) or (StoredInfo[_SKM._level]) then
				bNoEnemyData = false;
			end

			SkM_Trace(FName, 3, "Class = "..snil(Enemy[_SKM._class])..", Race = "..snil(Enemy[_SKM._race])..", Level = "..snil(Enemy[_SKM._level]));
		end


		local RGB;
		local sPattern;

		if (StoredInfo[_SKM._type] == _SKM._playerAssistKill) then
			sPattern = SKM_Config.Message_PlayerKill;
			RGB = SKM_Config.RGB_PlayerAssistKill;

		elseif (StoredInfo[_SKM._type] == _SKM._playerKill) then
			sPattern = SKM_Config.Message_PlayerKill;
			RGB = SKM_Config.RGB_PlayerKill;


		elseif (StoredInfo[_SKM._type] == _SKM._playerFullKill) then
			sPattern = SKM_Config.Message_PlayerKill;

			if (StoredInfo[_SKM._loneWolfKill]) then
				RGB = SKM_Config.RGB_LoneWolfKill;
			else
				RGB = SKM_Config.RGB_PlayerFullKill;
			end

		elseif (StoredInfo[_SKM._type] == _SKM._playerDeath) then
			sPattern = SKM_Config.Message_PlayerDeath;
			RGB = SKM_Config.RGB_PlayerDeath;

		elseif (StoredInfo[_SKM._type] == _SKM._playerDeathPvE) then
			sPattern = SKM_Config.Message_PlayerDeath_PvE;
			RGB = SKM_Config.RGB_PlayerPvEDeath;

		elseif (StoredInfo[_SKM._type] == _SKM._playerDeathPvP) then
			if (bNoEnemyData == false) then
				sPattern = SKM_Config.Message_PlayerDeath_PvP;
			else
				sPattern = SKM_Config.Message_PlayerDeath_PvP_NoData;
			end
			RGB = SKM_Config.RGB_PlayerPvPDeath;

		elseif (StoredInfo[_SKM._type] == _SKM._creatureKill_Target) then
			if (StoredInfo[_SKM._class]) then
				sPattern =  SKM_Config.Message_CreatureKill_RareDetail;
			else
				sPattern =  SKM_Config.Message_CreatureKill_Detail;
			end
			RGB = SKM_Config.RGB_CreatureKill;

		elseif (StoredInfo[_SKM._type] == _SKM._creatureKill_Xp) then
			sPattern = SKM_Config.Message_CreatureKill_Basic;
			RGB = SKM_Config.RGB_CreatureKill;

		elseif (StoredInfo[_SKM._type] == _SKM._levelUp) then
			sPattern = SKM_Config.Message_LevelUp;
			RGB = SKM_Config.RGB_LevelUp;
		end

		if (StoredInfo[_SKM._honorKill]) then
			sPattern = sPattern.." "..SKM_Config.SubMessage_HonorKill;
		end

		local sLine = SkM_GetNoteMessage(StoredInfo, sPattern);
		WorldMapTooltip:AddLine(sLine, RGB.r, RGB.g, RGB.b);
	end

	return true;
end


-- --------------------------------------------------------------------------------------
-- SkM_WorldMapEnterPOI
-- --------------------------------------------------------------------------------------
-- Handle POI "OnEnter" event :
-- Acquire and prepare ToolTip, then display it.
-- --------------------------------------------------------------------------------------
function SkM_WorldMapEnterPOI(id)
	local FName = "SkM_WorldMapEnterPOI";

	SkM_Trace(FName, 3, "id = "..id);

	--if ((not MapNotesPOIMenuFrame:IsVisible()) and (not MapNotesNewMenuFrame:IsVisible()) and MapNotes_BlockingFrame()) then
	if (true) then
		local x, y = this:GetCenter();
		local x2, y2 = WorldMapButton:GetCenter();
		local anchor = "";
		if (x > x2) then
			anchor = "ANCHOR_LEFT";
		else
			anchor = "ANCHOR_RIGHT";
		end

		--local idx_z = GetCurrentMapZone();
		--local idx_c = GetCurrentMapContinent();
		local idx_c, idx_z = SkM_GetCurrentMapZone_Shift();

		local idx_n = this.toolTip;

		local idx_gn = SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z][idx_n];
		local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[idx_gn];


		SkM_Trace(FName, 3, "this.toolTip = "..this.toolTip);

		WorldMapTooltip:SetOwner(this, anchor);

		--WorldMapTooltip:SetText(""); -- doesn't display if no title
		WorldMapTooltip:SetText(SKM_UI_STRINGS.Map_Window_Title);

		local xPos = Note[_SKM._xPos];
		local yPos = Note[_SKM._yPos];


		--SkM_FillWorldMapToolTip(idx_c, idx_z, xPos, yPos);
		SkM_FillWorldMapToolTip(idx_c, idx_z, idx_n, id);

		WorldMapTooltip:Show();
	else
		WorldMapTooltip:Hide();
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_WorldMapLeavePOI
-- --------------------------------------------------------------------------------------
-- Handle POI "OnLeave" event :
-- Hide ToolTip.
-- --------------------------------------------------------------------------------------
function SkM_WorldMapLeavePOI(id)
	local FName = "SkM_WorldMapLeavePOI";
	WorldMapTooltip:Hide();
end


-- --------------------------------------------------------------------------------------
-- SkM_FormatParsePattern
-- --------------------------------------------------------------------------------------
-- Format a parsing pattern.
-- Input pattern is a readable string that contains %s and %d for substitutions.
-- Return value is a regular expression, with special characters escaped by '%'.
-- --------------------------------------------------------------------------------------
function SkM_FormatParsePattern(sTemplate)
	local FName = "SkM_FormatParsePattern";

	local sPattern = sTemplate;

	sPattern = string.gsub(sPattern, "%(", "%%(");
	sPattern = string.gsub(sPattern, "%)", "%%)");
	sPattern = string.gsub(sPattern, "%.", "%%.");
	sPattern = string.gsub(sPattern, "%+", "%%+");
	sPattern = string.gsub(sPattern, "%[", "%%[");
	sPattern = string.gsub(sPattern, "%]", "%%]");

	sPattern = string.gsub(sPattern, "%%d", "([0-9]+)");
	sPattern = string.gsub(sPattern, "%%s", "(.+)");

	return sPattern;
end


-- --------------------------------------------------------------------------------------
-- SkM_BuildParsePatterns
-- --------------------------------------------------------------------------------------
-- Format as regular expressions all the parsing patterns that we need.
-- --------------------------------------------------------------------------------------
function SkM_BuildParsePatterns()
	local FName = "SkM_BuildParsePatterns";

	for idx, val in SKM_PATTERN do
		local sPattern = SkM_FormatParsePattern(val);
		SKM_Context.Pattern[idx] = sPattern;
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_XpGain
-- --------------------------------------------------------------------------------------
-- Handle "player receives combat xp" chat event.
-- If we can match one of the "creature kill" messages, then record the creature kill.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_XpGain(sMsg)
	local FName = "SkM_ParseCombatChat_XpGain";

	SkM_Trace(FName, 3, "You gain combat xp");

	for sFoe, iXpGain, iBaseXp, iRestXp in string.gfind(sMsg, SKM_Context.Pattern.XpGain_Rested_Solo) do
		if (sFoe and iXpGain and iBaseXp and iRestXp) then
			SkM_Trace(FName, 3, "XpGain_Rested_Solo : Foe = "..sFoe..", Xp = "..iXpGain);

			SkM_RecordCreatureKill_Xp(sFoe);
			return;
		end
	end

	for sFoe, iXpGain, iBaseXp, iRestXp, iGroupBonus in string.gfind(sMsg, SKM_Context.Pattern.XpGain_Rested_Group) do
		if (sFoe and iXpGain and iBaseXp and iRestXp and iGroupBonus) then
			SkM_Trace(FName, 3, "XpGain_Rested_Group : Foe = "..sFoe..", Xp = "..iXpGain);

			SkM_RecordCreatureKill_Xp(sFoe);
			return;
		end
	end

	for sFoe, iXpGain, iBaseXp, iRestXp, iRaidPenalty in string.gfind(sMsg, SKM_Context.Pattern.XpGain_Rested_Raid) do
		if (sFoe and iXpGain and iBaseXp and iRestXp and iRaidPenalty) then
			SkM_Trace(FName, 3, "XpGain_Rested_Raid : Foe = "..sFoe..", Xp = "..iXpGain);

			SkM_RecordCreatureKill_Xp(sFoe);
			return;
		end
	end

	for sFoe, iXpGain in string.gfind(sMsg, SKM_Context.Pattern.XpGain_Solo) do
		if (sFoe and iXpGain) then
			SkM_Trace(FName, 3, "XpGain_Solo : Foe = "..sFoe..", Xp = "..iXpGain);

			SkM_RecordCreatureKill_Xp(sFoe);
			return;
		end
	end

	for sFoe, iXpGain, iGroupBonus in string.gfind(sMsg, SKM_Context.Pattern.XpGain_Group) do
		if (sFoe and iXpGain and iGroupBonus) then
			SkM_Trace(FName, 3, "XpGain_Group : Foe = "..sFoe..", Xp = "..iXpGain);

			SkM_RecordCreatureKill_Xp(sFoe);
			return;
		end
	end

	for sFoe, iXpGain, iRaidPenalty in string.gfind(sMsg, SKM_Context.Pattern.XpGain_Raid) do
		if (sFoe and iXpGain and iRaidPenalty) then
			SkM_Trace(FName, 3, "XpGain_Raid : Foe = "..sFoe..", Xp = "..iXpGain);

			SkM_RecordCreatureKill_Xp(sFoe);
			return;
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_SelfCombatHit
-- --------------------------------------------------------------------------------------
-- Handle "Player hits something" chat event.
-- Record damage done to this enemy.
-- Note that this may be a player or a creature. We don't check it yet as enemy player
-- may not be yet known, it's better to check on death event.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_SelfCombatHit(sMsg)
	local FName = "SkM_ParseCombatChat_SelfCombatHit";

	SkM_Trace(FName, 3, "You do physical damage to something");

	for sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Player_HitDamage) do
		if (sFoe and iDamage) then
			SkM_Trace(FName, 3, "Player_HitDamage : Foe = "..sFoe..", Damage = "..iDamage);

			SkM_LogDamage_OnPvpEnemy(iDamage, _PlayerName, sFoe);
			return;
		end
	end

	for sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Player_HitCritDamage) do
		if (sFoe and iDamage) then
			SkM_Trace(FName, 3, "Player_HitDamage : Foe = "..sFoe..", Damage = "..iDamage);

			SkM_LogDamage_OnPvpEnemy(iDamage, _PlayerName, sFoe);
			return;
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_SelfCombatSpell
-- --------------------------------------------------------------------------------------
-- Handle "Player does spell damage on something" chat event.
-- Record damage done to this enemy.
-- Note that this may be a player or a creature. We don't check it yet as enemy player
-- may not be yet known, it's better to check on death event.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_SelfCombatSpell(sMsg)
	local FName = "SkM_ParseCombatChat_SelfCombatSpell";

	SkM_Trace(FName, 3, "You do spell damage to something");

	for sSpell, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Player_SpellDamage) do
		if (sSpell and sFoe and iDamage) then
			SkM_Trace(FName, 3, "Player_SpellDamage : Spell = "..sSpell..", Foe = "..sFoe..", Damage = "..iDamage);

			SkM_LogDamage_OnPvpEnemy(iDamage, _PlayerName, sFoe);
			return;
		end
	end

	for sSpell, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Player_SpellCritDamage) do
		if (sSpell and sFoe and iDamage) then
			SkM_Trace(FName, 3, "Player_SpellCritDamage : Spell = "..sSpell..", Foe = "..sFoe..", Damage = "..iDamage);

			SkM_LogDamage_OnPvpEnemy(iDamage, _PlayerName, sFoe);
			return;
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_FriendCombatHit
-- --------------------------------------------------------------------------------------
-- Handle "Friendly player hits something" chat event.
-- Record damage done to this enemy.
-- Note that this may be a player or a creature. We don't check it yet as enemy player
-- may not be yet known, it's better to check on death event.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_FriendCombatHit(sMsg)
	local FName = "SkM_ParseCombatChat_FriendCombatHit";

	SkM_Trace(FName, 3, "A friend do physical damage to something");

	for sAttacker, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Other_HitDamage) do
		if (sAttacker and sFoe and iDamage) then
			SkM_Trace(FName, 3, "Other_HitDamage : Attacker = "..sAttacker..", Foe = "..sFoe..", Damage = "..iDamage);

			SkM_LogDamage_OnPvpEnemy(iDamage, sAttacker, sFoe);
			return;
		end
	end

	for sAttacker, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Other_HitCritDamage) do
		if (sAttacker and sFoe and iDamage) then
			SkM_Trace(FName, 3, "Other_HitCritDamage : Attacker = "..sAttacker..", Foe = "..sFoe..", Damage = "..iDamage);


			SkM_LogDamage_OnPvpEnemy(iDamage, sAttacker, sFoe);
			return;
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_FriendCombatSpell
-- --------------------------------------------------------------------------------------
-- Handle "Friendly player does spell damage to something" chat event.
-- Record damage done to this enemy.
-- Note that this may be a player or a creature. We don't check it yet as enemy player
-- may not be yet known, it's better to check on death event.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_FriendCombatSpell(sMsg)
	local FName = "SkM_ParseCombatChat_FriendCombatSpell";

	SkM_Trace(FName, 3, "A friend do spell damage to something");

	-- PIng: Patch for French version where attacker and spell are inversed

	if ( GetLocale() == "frFR" ) then

		for sSpell, sAttacker, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Other_SpellDamage) do
			if (sAttacker and sSpell and sFoe and iDamage) then
				SkM_Trace(FName, 3, "Other_SpellDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Foe = "..sFoe..", Damage = "..iDamage);

				if (SkM_IsTotem(sAttacker)) then
					-- ignore totem damage
					return;
				end

				SkM_LogDamage_OnPvpEnemy(iDamage, sAttacker, sFoe);
				return;
			end
		end
	else

		for sAttacker, sSpell, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Other_SpellDamage) do
			if (sAttacker and sSpell and sFoe and iDamage) then
				SkM_Trace(FName, 3, "Other_SpellDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Foe = "..sFoe..", Damage = "..iDamage);

				if (SkM_IsTotem(sAttacker)) then
					-- ignore totem damage
					return;
				end

				SkM_LogDamage_OnPvpEnemy(iDamage, sAttacker, sFoe);
				return;
			end
		end
	end

	for sAttacker, sSpell, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Other_SpellCritDamage) do
		if (sAttacker and sSpell and sFoe and iDamage) then
			SkM_Trace(FName, 3, "Other_SpellCritDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Foe = "..sFoe..", Damage = "..iDamage);

			SkM_LogDamage_OnPvpEnemy(iDamage, sAttacker, sFoe);
			return;
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_PetCombatHit
-- --------------------------------------------------------------------------------------
-- Handle "Our pet hits something" chat event.
-- Record damage (for pet owner !) done to this enemy.
-- Note that this may be a player or a creature. We don't check it yet as enemy player
-- may not be yet known, it's better to check on death event.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_PetCombatHit(sMsg)
	local FName = "SkM_ParseCombatChat_PetCombatHit";

	SkM_Trace(FName, 3, "Your pet does physical damage to something");

	for sAttacker, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Other_HitDamage) do
		if (sAttacker and sFoe and iDamage) then
			SkM_Trace(FName, 3, "Other_HitDamage : Attacker = "..sAttacker..", Foe = "..sFoe..", Damage = "..iDamage);

			SkM_LogDamage_OnPvpEnemy(iDamage, _PlayerName, sFoe);
			return;
		end
	end

	for sAttacker, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Other_HitCritDamage) do
		if (sAttacker and sFoe and iDamage) then
			SkM_Trace(FName, 3, "Other_HitCritDamage : Attacker = "..sAttacker..", Foe = "..sFoe..", Damage = "..iDamage);

			SkM_LogDamage_OnPvpEnemy(iDamage, _PlayerName, sFoe);
			return;
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_PetCombatSpell
-- --------------------------------------------------------------------------------------
-- Handle "Our pet does spell damage to something" chat event.
-- Record damage (for pet owner !) done to this enemy.
-- Note that this may be a player or a creature. We don't check it yet as enemy player
-- may not be yet known, it's better to check on death event.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_PetCombatSpell(sMsg)
	local FName = "SkM_ParseCombatChat_PetCombatSpell";

	SkM_Trace(FName, 3, "Your pet does spell damage to something");

	-- Note : it may be your totem if you are a shaman
	-- in this case, we don't ignore it : we count it as player damage also.



	for sAttacker, sSpell, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Other_SpellDamage) do
		if (sAttacker and sSpell and sFoe and iDamage) then
			SkM_Trace(FName, 3, "Other_SpellDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Foe = "..sFoe..", Damage = "..iDamage);

			SkM_LogDamage_OnPvpEnemy(iDamage, _PlayerName, sFoe);
			return;
		end

	end

	for sAttacker, sSpell, sFoe, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Other_SpellCritDamage) do
		if (sAttacker and sSpell and sFoe and iDamage) then
			SkM_Trace(FName, 3, "Other_SpellCritDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Foe = "..sFoe..", Damage = "..iDamage);

			SkM_LogDamage_OnPvpEnemy(iDamage, _PlayerName, sFoe);
			return;
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_EnemyDot
-- --------------------------------------------------------------------------------------
-- Handle "Enemy player suffers from DoT" chat event.
-- Record damage done (by either self of another player) to this enemy.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_EnemyDot(sMsg)
	local FName = "SkM_ParseCombatChat_EnemyDot";

	SkM_Trace(FName, 3, "An enemy suffers from DoT damage");

	-- PIng: Patch for French version

	if ( GetLocale() == "frFR" ) then
		for sSpell, iDamage, sDamageType, sFoe  in string.gfind(sMsg, SKM_Context.Pattern.Player_DotDamage) do
			if (sFoe and iDamage and sDamageType and sSpell) then
				SkM_Trace(FName, 3, "Player_DotDamage : Foe = "..sFoe..", Damage = "..iDamage..", Damage type = "..sDamageType..", Spell = "..sSpell);

				SkM_LogDamage_OnPvpEnemy(iDamage, _PlayerName, sFoe);
				return;
			end
		end
		for sSpell, sAttacker, sFoe, iDamage, sDamageType  in string.gfind(sMsg, SKM_Context.Pattern.Other_DotDamage) do
			if (sFoe and iDamage and sDamageType and sAttacker and sSpell) then
				SkM_Trace(FName, 3, "Other_DotDamage : Attacker = "..sAttacker..", Foe = "..sFoe..", Damage = "..iDamage..", Damage type = "..sDamageType..", Spell = "..sSpell);

				SkM_LogDamage_OnPvpEnemy(iDamage, sAttacker, sFoe);
				return;
			end
		end

	else
		for sFoe, iDamage, sDamageType, sSpell in string.gfind(sMsg, SKM_Context.Pattern.Player_DotDamage) do
			if (sFoe and iDamage and sDamageType and sSpell) then
				SkM_Trace(FName, 3, "Player_DotDamage : Foe = "..sFoe..", Damage = "..iDamage..", Damage type = "..sDamageType..", Spell = "..sSpell);

				SkM_LogDamage_OnPvpEnemy(iDamage, _PlayerName, sFoe);
				return;
			end
		end
		for sFoe, iDamage, sDamageType, sAttacker, sSpell in string.gfind(sMsg, SKM_Context.Pattern.Other_DotDamage) do
			if (sFoe and iDamage and sDamageType and sAttacker and sSpell) then
				SkM_Trace(FName, 3, "Other_DotDamage : Attacker = "..sAttacker..", Foe = "..sFoe..", Damage = "..iDamage..", Damage type = "..sDamageType..", Spell = "..sSpell);

				SkM_LogDamage_OnPvpEnemy(iDamage, sAttacker, sFoe);
				return;
			end
		end
	end

end


-- --------------------------------------------------------------------------------------

-- SkM_ParseCombatChat_SelfDot
-- --------------------------------------------------------------------------------------
-- Handle "Self suffers from DoT" chat event.
-- Record damage done to self, without any "enemy type" as we don't know if the enemy

-- is a player or a creep.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_SelfDot(sMsg)
	local FName = "SkM_ParseCombatChat_SelfDot";

	SkM_Trace(FName, 3, "Self suffers from DoT damage");

	-- We suffered from a DoT : in this case, log damage without enemy type, because
	-- we do *not* know from the event if it's a player or a creature that cast the DoT !

	if ( GetLocale() == "frFR" ) then
		-- 0.09.1 Begin of modification Fix ?
		for sSpell, sAttacker, iDamage, sDamageType  in string.gfind(sMsg, SKM_Context.Pattern.Self_DotDamage) do
			if (iDamage and sDamageType and sAttacker and sSpell) then
				SkM_Trace(FName, 3, "Self_DotDamage : Attacker = "..sAttacker..", Damage = "..iDamage..", Damage type = "..sDamageType..", Spell = "..sSpell);

				SkM_LogDamage_OnSelf(iDamage, sAttacker, nil);
				return;
			end
		end
		-- 0.09.1 End of modification

	else

		for iDamage, sDamageType, sAttacker, sSpell  in string.gfind(sMsg, SKM_Context.Pattern.Self_DotDamage) do
			if (iDamage and sDamageType and sAttacker and sSpell) then
				SkM_Trace(FName, 3, "Self_DotDamage : Attacker = "..sAttacker..", Damage = "..iDamage..", Damage type = "..sDamageType..", Spell = "..sSpell);

				SkM_LogDamage_OnSelf(iDamage, sAttacker, nil);
				return;
			end
		end

	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_EnemyCombatHit
-- --------------------------------------------------------------------------------------
-- Handle "Enemy player hits something" chat event.
-- If we are the victim, record damage done to self by that enemy.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_EnemyCombatHit(sMsg)
	local FName = "SkM_ParseCombatChat_EnemyCombatHit";

	SkM_Trace(FName, 3, "A player enemy does physical damage to something");

	-- that may be an enemy PET also ! so we need to check if we know this enemy
	-- if not, log it without "enemy type" filled...

	for sAttacker, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Self_HitDamage) do
		if (sAttacker and iDamage) then
			SkM_Trace(FName, 3, "Self_HitDamage : Attacker = "..sAttacker..", Damage = "..iDamage);

			SkM_LogDamage_OnSelf(iDamage, sAttacker, SkM_GetKnownEnemyType(sAttacker));
			return;
		end
	end

	for sAttacker, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Self_HitCritDamage) do
		if (sAttacker and iDamage) then
			SkM_Trace(FName, 3, "Self_CritHitDamage : Attacker = "..sAttacker..", Damage = "..iDamage);

			SkM_LogDamage_OnSelf(iDamage, sAttacker, SkM_GetKnownEnemyType(sAttacker));
			return;
		end
	end

	-- Self is not the target
	-- we don't care who the hostile player hits and for which amount !
	SkM_Trace(FName, 3, "Hostile picks on other player or mob : do nothing");
end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_EnemyCombatSpell
-- --------------------------------------------------------------------------------------
-- Handle "Enemy player does spell damage to something" chat event.
-- If we are the victim, record damage done to self by that enemy.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_EnemyCombatSpell(sMsg)
	local FName = "SkM_ParseCombatChat_EnemyCombatSpell";

	SkM_Trace(FName, 3, "A player enemy does spell damage to something");

	-- that may be an enemy PET also ! so we need to check if we know this enemy
	-- if not, log it without "enemy type" filled...

	-- Is Self the target ?

	-- PIng: Patch for French version

	if ( GetLocale() == "frFR" ) then

		for  sSpell, sAttacker, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Self_SpellDamage) do
			if (sAttacker and sSpell and iDamage) then
				SkM_Trace(FName, 3, "Self_SpellDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Damage = "..iDamage);

				if (SkM_IsTotem(sAttacker)) then

					-- ignore totem damage
					return;
				end

				SkM_LogDamage_OnSelf(iDamage, sAttacker, SkM_GetKnownEnemyType(sAttacker));
				return;
			end
		end
	else

		for sAttacker, sSpell, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Self_SpellDamage) do
			if (sAttacker and sSpell and iDamage) then
				SkM_Trace(FName, 3, "Self_SpellDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Damage = "..iDamage);

				if (SkM_IsTotem(sAttacker)) then
					-- ignore totem damage
					return;
				end

				SkM_LogDamage_OnSelf(iDamage, sAttacker, SkM_GetKnownEnemyType(sAttacker));
				return;
			end
		end
	end

	for sAttacker, sSpell, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Self_SpellCritDamage) do
		if (sAttacker and sSpell and iDamage) then
			SkM_Trace(FName, 3, "Self_SpellCritDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Damage = "..iDamage);

			SkM_LogDamage_OnSelf(iDamage, sAttacker, SkM_GetKnownEnemyType(sAttacker));
			return;
		end
	end



	-- Self is not the target
	-- we don't care who the hostile player hits and for which amount !
	SkM_Trace(FName, 3, "Hostile picks on other player or mob : do nothing");
end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_CreatureCombatHit
-- --------------------------------------------------------------------------------------
-- Handle "Creature hits something" chat event.
-- If we are the victim, record damage done to self by that creature.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_CreatureCombatHit(sMsg)
	local FName = "SkM_ParseCombatChat_CreatureCombatHit";

	SkM_Trace(FName, 3, "A creature does physical damage to something");

	for sAttacker, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Self_HitDamage) do
		if (sAttacker and iDamage) then
			SkM_Trace(FName, 3, "Self_HitDamage : Attacker = "..sAttacker..", Damage = "..iDamage);

			SkM_LogDamage_OnSelf(iDamage, sAttacker, _SKM._enemyCreature);
			return;
		end
	end

	for sAttacker, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Self_HitCritDamage) do
		if (sAttacker and iDamage) then
			SkM_Trace(FName, 3, "Self_CritHitDamage : Attacker = "..sAttacker..", Damage = "..iDamage);

			SkM_LogDamage_OnSelf(iDamage, sAttacker, _SKM._enemyCreature);
			return;
		end
	end

	-- Self is not the target
	-- we don't care who the creature hits and for which amount !
	SkM_Trace(FName, 3, "Creature picks on other player or mob : do nothing");
end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_CreatureCombatSpell
-- --------------------------------------------------------------------------------------
-- Handle "Creature does spell damage to something" chat event.
-- If we are the victim, record damage done to self by that creature.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_CreatureCombatSpell(sMsg)
	local FName = "SkM_ParseCombatChat_CreatureCombatSpell";

	SkM_Trace(FName, 3, "A creature does spell damage to something");

	-- 0.08.1 Begin of modification: Patch for French version

	if ( GetLocale() == "frFR" ) then

		for  sSpell, sAttacker, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Self_SpellDamage) do
			if (sAttacker and sSpell and iDamage) then
				SkM_Trace(FName, 3, "Self_SpellDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Damage = "..iDamage);

				if (SkM_IsTotem(sAttacker)) then
					-- ignore totem damage

					return;
				end

				SkM_LogDamage_OnSelf(iDamage, sAttacker, _SKM._enemyCreature);
				return;
			end
		end
	else

	      for sAttacker, sSpell, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Self_SpellDamage) do
			if (sAttacker and sSpell and iDamage) then
				SkM_Trace(FName, 3, "Self_SpellDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Damage = "..iDamage);

				if (SkM_IsTotem(sAttacker)) then
					-- ignore totem damage
					return;
				end

				SkM_LogDamage_OnSelf(iDamage, sAttacker, _SKM._enemyCreature);
				return;
			end
		end
	end
	-- 0.08.1 End of modification

	for sAttacker, sSpell, iDamage in string.gfind(sMsg, SKM_Context.Pattern.Self_SpellCritDamage) do
		if (sAttacker and sSpell and iDamage) then
			SkM_Trace(FName, 3, "Self_SpellCritDamage : Attacker = "..sAttacker..", Spell = "..sSpell..", Damage = "..iDamage);

			SkM_LogDamage_OnSelf(iDamage, sAttacker, _SKM._enemyCreature);
			return;
		end
	end

	-- Self is not the target
	-- we don't care who the creature hits and for which amount !
	SkM_Trace(FName, 3, "Creature picks on other player or mob : do nothing");
end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_HostileDeath
-- --------------------------------------------------------------------------------------
-- Handle "Enemy player dies" chat event.
-- Find out from information previously gathered if we can be awarded this kill,
-- and if so record it.
-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_HostileDeath(sMsg)
	local FName = "SkM_ParseCombatChat_HostileDeath";

	for sFoe in string.gfind(sMsg, SKM_Context.Pattern.Other_Death) do
		if (sFoe) then
			SkM_Trace(FName, 3, "Other_Death : Foe = "..sFoe);


			SkM_Trace(FName, 2, "Enemy player death detected (from chat msg) : "..snil(sFoe));
			SkM_PvpEnemyDeath(sFoe);
			return;
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ParseCombatChat_HonorKill
-- --------------------------------------------------------------------------------------
-- Handle "Enemy player dies and is worth honor" chat event.
-- Find out from information previously gathered if we can be awarded this kill,
-- and if so record it.

-- --------------------------------------------------------------------------------------
function SkM_ParseCombatChat_HonorKill(sMsg)
	local FName = "SkM_ParseCombatChat_HonorKill";

	for sFoe, sRank in string.gfind(sMsg, SKM_Context.Pattern.Honor_Kill) do
		if (sFoe and sRank) then
			SkM_Trace(FName, 3, "Honor_Kill : Foe = "..sFoe..", Rank = "..sRank);

			SkM_Trace(FName, 2, "Enemy player death detected (from chat, honor) : "..snil(sFoe));
			SkM_PvpEnemyDeath(sFoe, true, sRank);
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_RecordCreatureKill_Xp
-- --------------------------------------------------------------------------------------
-- Record a creature kill by "combat xp message".
-- --------------------------------------------------------------------------------------
function SkM_RecordCreatureKill_Xp(sName)
	local FName = "SkM_RecordCreatureKill_Xp";

	if (not SkM_GetOption("RecordCreatureKill")) then
		return;
	end


	local curTime = GetTime();

	SkM_Trace(FName, 3, "Creature by xp kill : "..sName.." (time = "..curTime..")");

	-- check if we're already processed this kill on health change
	if (SKM_Context.LastCreatureKill) then

		SkM_Trace(FName, 3, "Recent creature kill : "..snil(SKM_Context.LastCreatureKill[_SKM._name]).." (time = "..snil(SKM_Context.LastCreatureKill[_SKM._time])..")");

		if (SKM_Context.LastCreatureKill[_SKM._name] == sName) and (curTime < SKM_Context.LastCreatureKill[_SKM._time] + 1) then
			SkM_Trace(FName, 2, "Already processed kill : "..sName);

			-- clear last creature kill and return
			SKM_Context.LastCreatureKill = nil;
			return;
		end
	end

	-- kill not recorded by target kill, process it
	local StoreInfo = { };

	StoreInfo[_SKM._type] = _SKM._creatureKill_Xp;

	local sDate1, sDate2 = SkM_GetDate();
	StoreInfo[_SKM._date] = sDate1;
	--StoreInfo[_sortdate] = sDate2;

	StoreInfo[_SKM._name] = sName;

	if (not SkM_AddMapData(StoreInfo)) then
		return;
	end


	if (SkM_GetOption("DisplayCreatureKillRecord")) then
		SkM_ChatMessageColP(string.format(SKM_UI_STRINGS.RecordMessage_CreatureKill, sName), SKM_Config.RGB_CreatureKill);
	end

	-- memorize killed mob to that we don't count it again when receiving xp message
	SKM_Context.LastCreatureKill = { };
	SKM_Context.LastCreatureKill[_SKM._name] = sName;
	SKM_Context.LastCreatureKill[_SKM._time] = GetTime();

	--local idx_c, idx_z = SkM_GetZone();
	local idx_c, idx_z = SkM_GetZone_Shift();
	if (idx_z) then
		SkM_CleanZoneCreatureKill(idx_c, idx_z);
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_RecordCreatureKill_Target
-- --------------------------------------------------------------------------------------
-- Record a creature kill by target (the creature we are currently targetting dies,
-- and it was tapped by us).
-- --------------------------------------------------------------------------------------
function SkM_RecordCreatureKill_Target(sName, iLevel, sCreatureClass)
	local FName = "SkM_RecordCreatureKill_Target";

	if (not SkM_GetOption("RecordCreatureKill")) then
		return;
	end


	local curTime = GetTime();

	SkM_Trace(FName, 3, "Creature by target kill : "..sName.." (time = "..curTime..")");

	-- check if we're already processed this kill on combat xp message
	if (SKM_Context.LastCreatureKill) then

		SkM_Trace(FName, 3, "Recent creature kill : "..snil(SKM_Context.LastCreatureKill[_SKM._name]).." (time = "..snil(SKM_Context.LastCreatureKill[_SKM._time])..")");

		if (SKM_Context.LastCreatureKill[_SKM._name] == sName) and (curTime < SKM_Context.LastCreatureKill[_SKM._time] + 1) then
			SkM_Trace(FName, 2, "Already processed kill : "..sName);

			-- clear last creature kill and return
			SKM_Context.LastCreatureKill = nil;
			return;
		end
	end

	local StoreInfo = { };

	StoreInfo[_SKM._type] = _SKM._creatureKill_Target;

	local sDate1, sDate2 = SkM_GetDate();
	StoreInfo[_SKM._date] = sDate1;
	--StoreInfo[_sortdate] = sDate2;

	StoreInfo[_SKM._name] = sName;
	StoreInfo[_SKM._level] = iLevel;
	StoreInfo[_SKM._class] = SKM_Config.CreatureClassLabel[sCreatureClass];

	if (not SkM_AddMapData(StoreInfo)) then
		return;
	end

	if (SkM_GetOption("DisplayCreatureKillRecord")) then
		SkM_ChatMessageColP(string.format(SKM_UI_STRINGS.RecordMessage_CreatureKill, sName), SKM_Config.RGB_CreatureKill);
	end


	-- memorize killed mob to that we don't count it again when receiving xp message
	SKM_Context.LastCreatureKill = { };
	SKM_Context.LastCreatureKill[_SKM._name] = sName;
	SKM_Context.LastCreatureKill[_SKM._time] = GetTime();

	--local idx_c, idx_z = SkM_GetZone();
	local idx_c, idx_z = SkM_GetZone_Shift();
	if (idx_z) then
		SkM_CleanZoneCreatureKill(idx_c, idx_z);
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_DeleteNote
-- --------------------------------------------------------------------------------------
-- Delete a global note. Remove this note from global and zone map data, and recompute
-- indexes of more recent notes.
-- --------------------------------------------------------------------------------------
function SkM_DeleteNote(RealmName, PlayerName, idx_gn)
	local FName = "SkM_DeleteNote";

	SkM_Trace(FName, 3, "Removing note ("..RealmName.." / "..PlayerName..") : global index = "..idx_gn);

	local idx_c, idx_z, idx_n;
	local val_c, val_z, val_n;

	local cont_rem, zone_rem, note_rem;

	for idx_c = 1,getn(SKM_Data[RealmName][PlayerName].MapData),1 do
		for idx_z = 1,getn(SKM_Data[RealmName][PlayerName].MapData[idx_c]) do
			for idx_n = 1,getn(SKM_Data[RealmName][PlayerName].MapData[idx_c][idx_z]) do
				local val_n = SKM_Data[RealmName][PlayerName].MapData[idx_c][idx_z][idx_n];
				if (val_n == idx_gn) then
					cont_rem = idx_c;
					zone_rem = idx_z;
					note_rem = idx_n;
				elseif (val_n > idx_gn) then
					SKM_Data[RealmName][PlayerName].MapData[idx_c][idx_z][idx_n] = val_n - 1;
				end
			end
		end
	end


	SkM_Trace(FName, 3, "Removing note : continent = "..snil(cont_rem)..", zone = "..snil(zone_rem)..", note = "..snil(note_rem));

	table.remove(SKM_Data[RealmName][PlayerName].MapData[cont_rem][zone_rem], note_rem);
	table.remove(SKM_Data[RealmName][PlayerName].GlobalMapData, idx_gn);
end


-- --------------------------------------------------------------------------------------
-- SkM_CleanZoneCreatureKill
-- --------------------------------------------------------------------------------------
-- A creature kill has been recorded, clean older creature kill records if necessary
-- (from configurable maximum number of creature records by zone).
-- --------------------------------------------------------------------------------------
function SkM_CleanZoneCreatureKill(idx_c, idx_z)
	local FName = "SkM_CleanZoneCreatureKill";


	SkM_Trace(FName, 3, "Continent = "..idx_c..", Zone = "..idx_z);

	local iZoneNoteCount = getn(SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z]);
	--iZoneNoteCount = tablesize(SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z]);

	SkM_Trace(FName, 3, "Notes in zone = "..iZoneNoteCount);

	local iCreatureKill = 0;
	local i;

	for i=iZoneNoteCount, 1, -1 do
		local idx_gn = SKM_Data[_RealmName][_PlayerName].MapData[idx_c][idx_z][i];
		local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[idx_gn];

		if ((Note) and (Note[_SKM._storedInfo])) 
		and ((Note[_SKM._storedInfo][_SKM._type] == _SKM._creatureKill_Target) or (Note[_SKM._storedInfo][_SKM._type] == _SKM._creatureKill_Xp)) then
			if (iCreatureKill >= SkM_GetOption("CreatureKillRecordsByZone")) then

				-- already reached the max count of creature kill notes by zone
				-- have to delete this one.

				-- remove from GlobalMapData and from MapData
				SkM_Trace(FName, 3, "Removing note : global index = "..idx_gn..", map index = "..i);

				SkM_DeleteNote(_RealmName, _PlayerName, idx_gn);

			else
				iCreatureKill = iCreatureKill + 1;
			end
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_CheckForgetEnemy
-- --------------------------------------------------------------------------------------
-- Check if we can forget an enemy that has engaged in combat against us.
-- If no update has been received in a given time frame, then forget him.
-- --------------------------------------------------------------------------------------
function SkM_CheckForgetEnemy(sName)
	local Name = "SkM_CheckForgetEnemy";

	local curTime = GetTime();

	if (SKM_Context.EnemyCombat[sName]) then
		-- there exists information about that enemy.
		-- check when last updated
		if (curTime - SKM_Context.EnemyCombat[sName][_SKM._lastUpdate] > SKM_Config.ForgetEnemyTimer) then
			SKM_Context.EnemyCombat[sName] = nil;
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_BuildGroupList
-- --------------------------------------------------------------------------------------
-- Build a list of players currently in the group. Called each time the group members
-- change.
-- --------------------------------------------------------------------------------------
function SkM_BuildGroupList()
	local FName = "SkM_BuildGroupList";

	SkM_Trace(FName, 2, "Party changed, rebuild group list");


	SKM_Context.GroupList = { };

	local i;
	for i=1,GetNumPartyMembers() do
		local sUnit = SKM_UNIT_PARTY .. i;
		local sName = SkM_UnitName(sUnit);

		if (sName) then
			table.insert(SKM_Context.GroupList, sName);
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_IsNameInGroup
-- --------------------------------------------------------------------------------------
-- Check if given player name is in party.
-- --------------------------------------------------------------------------------------
function SkM_IsNameInGroup(sName)
	return (	(sName == _PlayerName)
	         or (intable(sName, SKM_Context.GroupList))
	);
end


-- --------------------------------------------------------------------------------------
-- SkM_LogDamage_OnPvpEnemy
-- --------------------------------------------------------------------------------------
-- Keep track of damage done on an enemy, and who did this damage (self or our group,
-- or someone else).
-- --------------------------------------------------------------------------------------
function SkM_LogDamage_OnPvpEnemy(iDamage, sFriendName, sName)
	local FName = "SkM_LogDamage_OnPvpEnemy";

	local curTime = GetTime();

	-- first check if we remember this enemy and if no update was received for a long time,
	-- then forget him and start anew.
	SkM_CheckForgetEnemy(sName);

	if (not SKM_Context.EnemyCombat[sName]) then
		SKM_Context.EnemyCombat[sName] = { };
		SKM_Context.EnemyCombat[sName][_SKM._name] = sName;
		SKM_Context.EnemyCombat[sName][_SKM._totalDamage] = 0;
		SKM_Context.EnemyCombat[sName][_SKM._groupDamage] = 0;
	end

	SKM_Context.EnemyCombat[sName][_SKM._lastUpdate] = curTime;

	SKM_Context.EnemyCombat[sName][_SKM._totalDamage] = SKM_Context.EnemyCombat[sName][_SKM._totalDamage] + iDamage;

	if (SkM_IsNameInGroup(sFriendName)) then
		SKM_Context.EnemyCombat[sName][_SKM._groupDamage] = SKM_Context.EnemyCombat[sName][_SKM._groupDamage] + iDamage;
	end

	SkM_Trace(FName, 3, "EnemyCombat updated for "..sName.." : Total damage = ".. SKM_Context.EnemyCombat[sName][_SKM._totalDamage] ..", Group damage = ".. SKM_Context.EnemyCombat[sName][_SKM._groupDamage]);
end


function SkM_UpdateEnemyHistory()
	SKM_Context.PlayerDataChanged = true;
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_IncrCounter
-- --------------------------------------------------------------------------------------
-- Increment enemy counter for a given type, and enemy guild counter if applicable
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_IncrCounter(sName, sType, iValue, bPropagateToGuild)
	SkM_UpdateEnemyHistory();

	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][sType] = ifnil(SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][sType], 0) + iValue;

	if (bPropagateToGuild) then
		local sGuildName = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._guild];
		if ((sGuildName ~= nil) and (sGuildName ~= "")) then
			SkM_UpdateGuild_IncrCounter(sGuildName, sType, iValue);
		end
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_IncrPlayerKill
-- --------------------------------------------------------------------------------------
-- Increment enemy kill count, and enemy guild kill count if applicable
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_IncrPlayerKill(sName, iValue)
	SkM_UpdateEnemy_IncrCounter(sName, _SKM._playerKill, iValue, true);
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_IncrPlayerFullKill
-- --------------------------------------------------------------------------------------
-- Increment enemy full kill count, and enemy guild full kill count if applicable
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_IncrPlayerFullKill(sName, iValue)
	SkM_UpdateEnemy_IncrCounter(sName, _SKM._playerFullKill, iValue, true);
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_IncrPlayerAssistKill
-- --------------------------------------------------------------------------------------
-- Increment enemy assist kill count, and enemy guild assist kill count if applicable
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_IncrPlayerAssistKill(sName, iValue)
	SkM_UpdateEnemy_IncrCounter(sName, _SKM._playerAssistKill, iValue, true);
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_IncrKillPlayer
-- --------------------------------------------------------------------------------------
-- Increment enemy kill player count, and enemy guild kill player count if applicable
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_IncrKillPlayer(sName, iValue, bBattleground)
	local sType;
	if (bBattleground) then
		sType = _SKM._enemyKillBG;
	else
		sType = _SKM._enemyKillPlayer;
	end
	SkM_UpdateEnemy_IncrCounter(sName, sType, iValue, true);
end

-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_IncrHonorKill
-- --------------------------------------------------------------------------------------
-- Increment enemy honor kill count, and enemy guild kill count if applicable
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_IncrHonorKill(sName, iValue)
	SkM_UpdateEnemy_IncrCounter(sName, _SKM._honorKill, iValue, true);
end

function SkM_UpdateEnemy_IncrLoneWolfKill(sName, iValue)
	SkM_UpdateEnemy_IncrCounter(sName, _SKM._loneWolfKill, iValue, true);
end



-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_IncrMeet
-- --------------------------------------------------------------------------------------
-- Increment enemy meet count
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_IncrMeet(sName, iValue)
	SkM_UpdateEnemy_IncrCounter(sName, _SKM._meetCount, iValue, false);
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_SetLastView
-- --------------------------------------------------------------------------------------
-- Update enemy last view date/time
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_SetLastView(sName, sDate)
	SkM_UpdateEnemyHistory();

	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._lastView] = sDate;
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_SetLastUpdate

-- --------------------------------------------------------------------------------------
-- Update enemy last update date/time
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_SetLastUpdate(sName, sDate)
	SkM_UpdateEnemyHistory();

	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._lastUpdate] = sDate;
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_SetLevel
-- --------------------------------------------------------------------------------------
-- Update enemy level
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_SetLevel(sName, iLevel)
	SkM_UpdateEnemyHistory();

	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._level] = iLevel;
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_SetClass
-- --------------------------------------------------------------------------------------
-- Update enemy class
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_SetClass(sName, sClass)
	SkM_UpdateEnemyHistory();

	if (not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._class]) then
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._class] = sClass;
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_SetRace
-- --------------------------------------------------------------------------------------
-- Update enemy race
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_SetRace(sName, sRace)
	SkM_UpdateEnemyHistory();

	if (not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._race]) then
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._race] = sRace;
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_SetLocation
-- --------------------------------------------------------------------------------------
-- Update enemy last seen location
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_SetLocation(sName, idx_c, idx_z, xPos, yPos)
	SkM_UpdateEnemyHistory();

	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._zoneName] = nil;

	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._continent] = idx_c;
	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._zone] = idx_z;
	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._xPos] = xPos;
	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._yPos] = yPos;
end

function SkM_UpdateEnemy_SetLocationName(sName, sZoneName)
	SkM_UpdateEnemyHistory();

	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._continent] = nil;
	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._zone] = nil;
	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._xPos] = nil;
	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._yPos] = nil;

	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._zoneName] = sZoneName;
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemy_SetWar
-- --------------------------------------------------------------------------------------
-- Update enemy 'at war' status, and war date
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemy_SetWar(sName, bWar, sDate)
	SkM_UpdateEnemyHistory();

	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._atWar] = bWar;
	if (bWar) then
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._warDate] = sDate;
	else
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._warDate] = nil;
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateEnemyLastView
-- --------------------------------------------------------------------------------------
-- Received some information about an enemy : update this enemy information
-- --------------------------------------------------------------------------------------
function SkM_UpdateEnemyLastView(sName, sDate, bTarget, sUnit)
	local FName = "SkM_UpdateEnemyLastView";

	SkM_UpdateEnemyHistory();

	local sTheUnit;
	if (sUnit) then
		sTheUnit = sUnit;
	else
		sTheUnit = SKM_UNIT_TARGET;
	end

	-- if we have unit on target (or mouseover), check if we should ignore or not
	if (bTarget) then

		-- if we already have recorded this player, we update his information anyway,
		-- even if he's low level, and even if he has no PvP flag

		-- if we have added this enemy to the unknown enemy at war, then we record him anyway

		if    (not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName])
		  and (not SKM_Data[_RealmName][_PlayerName].UnknownEnemy[sName])
		then

			if (not SkM_GetOption("StoreEnemyPlayers")) then
				SkM_Trace(FName, 2, "Storing disabled");
				return;
			end

			if (SkM_GetOption("IgnoreLowerEnemies")) then
				local iUnitLevel = UnitLevel(sTheUnit);
				if (iUnitLevel == -1) then
					iUnitLevel = 500;
				end
				local iMinLevel = math.floor( UnitLevel(SKM_UNIT_PLAYER) * SkM_GetOption("IgnoreLevelThreshold") / 100 );
				if ( iUnitLevel < iMinLevel ) then
					SkM_Trace(FName, 1, "Not storing, too low level : "..iUnitLevel..", min. = "..iMinLevel);
					return;
				end
			end
		end

		if (SkM_GetOption("IgnoreNoPvPFlag")) then
			if not (UnitIsPVP(sTheUnit) or UnitIsPVPFreeForAll(sTheUnit)) then
				SkM_Trace(FName, 1, "Not storing, Unit "..snil(sTheUnit).." is not PvP flagged");
				return;
			end
		end

	end

	if (not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName]) then
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName] = { };
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._name] = sName;
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._playerAssistKill] = 0;
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._playerKill] = 0;
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._playerFullKill] = 0;
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._enemyKillPlayer] = 0;
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._enemyKillBG] = 0;
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._playerBGKill] = 0;
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._meetCount] = 1;

		if (SKM_Data[_RealmName][_PlayerName].UnknownEnemy[sName]) then
			SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._meetCount] = 1;
			SKM_Data[_RealmName][_PlayerName].UnknownEnemy[sName] = nil;

			SkM_Trace(FName, 2, snil(sName).."Added with 'at WAR' status");
		end

		SkM_Trace(FName, 1, "First encounter of enemy : "..snil(sName));
	else

		if ((not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._meetCount]
		  or (not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._lastView]))) then

			-- 09/04/2005 18:44:32 PIng Add a check since LastView is updated later now.
			SkM_UpdateEnemy_IncrMeet(sName, 1);
		else
			-- increase number of time player met this enemy if last viewed time is older than
			-- configurable value
			local iDiffTime = SkM_DiffDate(sDate, SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._lastView]);
			if (iDiffTime ~= nil) and (iDiffTime > SKM_Config.TimeRangeForNewMeeting) then
				SkM_UpdateEnemy_IncrMeet(sName, 1);
			end
		end

	end

	-- if we have unit on target (or mouseover), update information
	if (bTarget) then
		SkM_UpdateEnemy_SetLevel(sName, UnitLevel(sTheUnit));
		SkM_UpdateEnemy_SetClass(sName, SkM_GetClassIndex(UnitClass(sTheUnit)));
		SkM_UpdateEnemy_SetRace(sName, SkM_GetRaceIndex(UnitRace(sTheUnit)));
		SkM_UpdateEnemy_SetGuild(sName, ifnil(GetGuildInfo(sTheUnit),"")); -- PIng Add guild support
		--SkM_UpdateEnemy_SetLastUpdate(sName, sDate);

		-- get/update rank also
		local iRank = UnitPVPRank(sTheUnit);
		if (iRank >= 1) then
			local sRank = GetPVPRankInfo(iRank, sTheUnit);
			if (sRank) then
				SkM_UpdateEnemyRank(sName, sRank);
			end
		end

	end

	local idx_c, idx_z = SkM_GetZone();
	if (idx_z) then
		SetMapZoom(idx_c, idx_z);
		local xPos, yPos = GetPlayerMapPosition(SKM_UNIT_PLAYER);

		--SkM_UpdateEnemy_SetLocation(sName, idx_c, idx_z, xPos, yPos);

		local cont_shift, zone_shift = SkM_GetZone_Shift(idx_c, idx_z);
		SkM_UpdateEnemy_SetLocation(sName, cont_shift, zone_shift, xPos, yPos);
	else
		local sZoneName = SkM_GetZoneText();
		SkM_UpdateEnemy_SetLocationName(sName, sZoneName);
	end

	-- 09/04/2005 16:46:34 PIng: Add guild support

	-- Update guild if known
	local sGuildName = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._guild];
	-- if ((sGuildName ~= nil) and (sGuildName ~= "not in a guild")) then
	if ((sGuildName ~= nil) and (sGuildName ~= "")) then
		SkM_UpdateGuildHistory(sGuildName, sDate, sName);
	end

	-- 09/04/2005 16:46:43 End of modification

	SkM_UpdateEnemy_SetLastView(sName, sDate);  -- 09/04/2005 18:30:05 PIng: Moved in order to have the information available for guild update

end


function SkM_UpdateEnemyRank(sName, sRank)
	SkM_UpdateEnemyHistory();

	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._rank] = sRank;
end


function SkM_UpdateEnemy_SetGuild(sName, sGuild)
	SkM_UpdateEnemyHistory();

	--if (not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._guild]) then
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._guild] = sGuild;
	--end
end

function SkM_UpdateGuild_SetLastView(sGuildName, sDate, sPlayerName)
	SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._lastView] = sDate;
	SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._lastPlayerViewed] = sPlayerName;
end

function SkM_UpdateGuild_IncrCounter(sGuildName, sType, iValue)
	SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][sType] = ifnil(SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][sType], 0) + iValue;
end

function SkM_UpdateGuild_IncrPlayerKill(sGuildName, iValue)
	SkM_UpdateGuild_IncrCounter(sGuildName, _SKM._playerKill, iValue);
end

function SkM_UpdateGuild_IncrPlayerFullKill(sGuildName, iValue)
	SkM_UpdateGuild_IncrCounter(sGuildName, _SKM._playerFullKill, iValue);
end

function SkM_UpdateGuild_IncrPlayerAssistKill(sGuildName, iValue)
	SkM_UpdateGuild_IncrCounter(sGuildName, _SKM._playerAssistKill, iValue);
end

function SkM_UpdateGuild_IncrKillPlayer(sGuildName, iValue, bBattleground)
	local sType;
	if (bBattleground) then
		sType = _SKM._enemyKillBG;
	else
		sType = _SKM._enemyKillPlayer;
	end
	SkM_UpdateGuild_IncrCounter(sGuildName, sType, iValue);
end

function SkM_UpdateGuild_IncrHonorKill(sGuildName, iValue)
	SkM_UpdateGuild_IncrCounter(sGuildName, _SKM._honorKill, iValue);
end

function SkM_UpdateGuild_IncrMeet(sGuildName, iValue)
	SkM_UpdateGuild_IncrCounter(sGuildName, _SKM._meetCount, iValue);
end


-- --------------------------------------------------------------------------------------

-- SkM_UpdateGuildHistory
-- --------------------------------------------------------------------------------------
-- Update guild information when receiving an update of a enemy from this guild
-- --------------------------------------------------------------------------------------
function SkM_UpdateGuildHistory(sGuildName, sDate, sName)
	local FName = "SkM_UpdateGuildHistory";

	SkM_Trace(FName, 2, "Guild Name : "..sGuildName..", Date : ".. sDate.. ", Player Name : "..sName);

	if (not SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName]) then
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName] = { };
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._name] = sGuildName;
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._playerAssistKill] = 0;
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._playerKill] = 0;
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._playerFullKill] = 0;
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._enemyKillPlayer] = 0;
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._enemyKillBG] = 0;
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._playerBGKill] = 0;
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._meetCount] = 1;
	else
		if  ((not SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._meetCount])
		  or (not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._lastView])) then
			SkM_Trace(FName, 2, "Increment Meet count for Guild for first time"..sGuildName);
			SkM_UpdateGuild_IncrMeet(sGuildName, 1);
		else
			-- increase number of time player met this guild if last viewed time for this enemy is older than
			-- configurable value
			SkM_Trace(FName, 2, "check if we need to increment");
			local iDiffTime = SkM_DiffDate(sDate, SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._lastView]);
			if (iDiffTime ~= nil) and (iDiffTime > SKM_Config.TimeRangeForNewMeeting) then
				SkM_Trace(FName, 1, "Increment Meet count for Guild "..sGuildName);
				SkM_UpdateGuild_IncrMeet(sGuildName, 1);
			end
		end
		SkM_Trace(FName, 2, "Exit");

	end

	SkM_UpdateGuild_SetLastView(sGuildName, sDate, sName);
end



-- --------------------------------------------------------------------------------------
-- SkM_UpdateGuild_SetWar
-- --------------------------------------------------------------------------------------
-- Update guild 'at war' status and war date
-- --------------------------------------------------------------------------------------
function SkM_UpdateGuild_SetWar(sName, bWar, sDate)
	SKM_Data[_RealmName][_PlayerName].GuildHistory[sName][_SKM._atWar] = bWar;
	if (bWar) then
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sName][_SKM._warDate] = sDate;
	else
		SKM_Data[_RealmName][_PlayerName].GuildHistory[sName][_SKM._warDate] = nil;
	end
end


function SkM_GetRecentEnemyKill(sName)
	local bFound = false;
	local iNoteIndex;
	local sDate = SkM_GetDate();
	local i;
	for i=table.getn(SKM_Context.RecentEnemyKill), 1, -1 do
		if (SKM_Context.RecentEnemyKill[i][_SKM._name] == sName) then
			local iDiffTime = SkM_DiffDate(sDate, SKM_Context.RecentEnemyKill[i][_SKM._date]);
			if (iDiffTime ~= nil) and (iDiffTime <= SKM_Config.RecentEnemyKillDelay) then
				bFound = true;
				iNoteIndex = SKM_Context.RecentEnemyKill[i][_SKM._noteIndex];
				return bFound, iNoteIndex;
			end
		end
	end
	return bFound, iNoteIndex;
end


function SkM_AddRecentEnemyKill(sName, sDate, iGlobalNote)
	local FName = "SkM_AddRecentEnemyKill";

	SkM_Trace(FName, 2, "Name = "..snil(sName)..", G. Note = "..snil(iGlobalNote));

	local Record = { };
	Record[_SKM._name] = sName;
	Record[_SKM._date] = sDate;
	Record[_SKM._noteIndex] = iGlobalNote;
	table.insert(SKM_Context.RecentEnemyKill, Record);

	while (table.getn(SKM_Context.RecentEnemyKill) > SKM_Config.MaxRecentEnemyKill) do
		table.remove(SKM_Context.RecentEnemyKill, 1);
	end
end


function SkM_GetRecentWarWarning(sName)
	local bFound = false;
	local sDate = SkM_GetDate();
	local i;
	for i=table.getn(SKM_Context.RecentWarWarning), 1, -1 do
		if (SKM_Context.RecentWarWarning[i][_SKM._name] == sName) then
			local iDiffTime = SkM_DiffDate(sDate, SKM_Context.RecentWarWarning[i][_SKM._date]);
			if (iDiffTime ~= nil) and (iDiffTime <= SKM_Config.RecentWarWarningDelay) then
				bFound = true;
				return bFound;
			end
		end
	end
	return bFound;
end

function SkM_AddRecentWarWarning(sName, sDate)
	local Record = { };
	Record[_SKM._name] = sName;
	Record[_SKM._date] = sDate;
	table.insert(SKM_Context.RecentWarWarning, Record);

	while (table.getn(SKM_Context.RecentWarWarning) > SKM_Config.MaxRecentWarWarning) do
		table.remove(SKM_Context.RecentWarWarning, 1);
	end
end



-- --------------------------------------------------------------------------------------
-- SkM_PvpEnemyDeath
-- --------------------------------------------------------------------------------------
-- An enemy dies...
-- Check from his name if we know him as an enemy player. If it's the case, check how
-- much relative damage did the group to this enemy, and record appropriate kill event.
-- --------------------------------------------------------------------------------------
function SkM_PvpEnemyDeath(sName, bHonorKill, sRank)
	local FName = "SkM_PvpEnemyDeath";

	SkM_Trace(FName, 3, "Name = "..snil(sName));
	if (not sName) then
		SkM_Trace(FName, 1, "nil parameter received !");
		return;
	end

	SkM_CheckForgetEnemy(sName);

--	if (not SkM_GetOption("RecordPlayerKill")) then
--		return;
--	end


	-- check if in battleground
	local bBattleground = SkM_IsInBattleground();

	if (not SKM_Context.EnemyCombat[sName]) and (not bHonorKill) then
		-- no information about this enemy
		return;
	end

	if (not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName]) then
		-- if this is a honor kill, then we *know* it is a player
		-- also check that "store enemy players" is enabled.

		if (not bHonorKill) or (not SkM_GetOption("StoreEnemyPlayers")) then
			-- we have no information about the enemy just killed.
			-- maybe he's a player that has never been targeted, but maybe not...
			-- in doubt we do nothing
			SkM_Trace(FName, 3, sName.." : type unknown...");

			SKM_Context.EnemyCombat[sName] = nil;
			return;
		end

	end

	local sDate1, sDate2 = SkM_GetDate();

	SkM_UpdateEnemyLastView(sName, sDate1, false);
	if (sRank) then
		SkM_UpdateEnemyRank(sName, sRank);
	end

	-- check if we have already recorded this kill
	local bRecorded, iNoteIndex;
	bRecorded, iNoteIndex = SkM_GetRecentEnemyKill(sName);
	if (bRecorded) then
		-- already recorded
		SkM_Trace(FName, 3, "Kill already recorded : idx_gn = "..snil(iNoteIndex));

		if (bHonorKill) then
			SkM_Trace(FName, 3, "Adjust as honor kill");

			-- we received an "honor kill", it means the kill was previously recorded due to
			-- a event that was not an "honor kill" : now take honor info into account
--			SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorKill] = ifnil(SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorKill], 0) + 1;
			SkM_UpdateEnemy_IncrHonorKill(sName, 1);

			SkM_SetHonorFlags(sName);

--			local sGuildName = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._guild];
--			if ((sGuildName ~= nil) and (sGuildName ~= "")) then
--				SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._honorKill] = ifnil(SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._honorKill], 0) + 1;
--			end

			if (iNoteIndex) then
				SKM_Data[_RealmName][_PlayerName].GlobalMapData[iNoteIndex][_SKM._storedInfo][_SKM._honorKill] = true;
			end

		end

		return;
	end

	SkM_Trace(FName, 3, "Kill not yet recorded");

	local KillType;

	if (not SKM_Context.EnemyCombat[sName]) then
		-- did not receive any combat information about this player, but
		-- we received an "honor" kill : award an "assist kill" by default
		SkM_Trace(FName, 3, "No combat info, but honor kill : award Assist Kill");

		KillType = _SKM._playerAssistKill;

	elseif (SKM_Context.EnemyCombat[sName][_SKM._groupDamage] == 0) then
		SkM_Trace(FName, 3, "Group didn't do any damage");

		if (bHonorKill) then
			-- no damage recorded by our group, but we received an "honor kill" :
			-- award an "assist kill" by default
			KillType = _SKM._playerAssistKill;
		end

	else
		local iPercent = SKM_Context.EnemyCombat[sName][_SKM._groupDamage] / SKM_Context.EnemyCombat[sName][_SKM._totalDamage];

		if (iPercent < 0.50) then
			SkM_Trace(FName, 3, "Group damage < 50% : award Assist Kill");
			KillType = _SKM._playerAssistKill;
		elseif (iPercent < 1.00) then
			SkM_Trace(FName, 3, "Group damage >= 50% and < 100% : award Kill");
			KillType = _SKM._playerKill;
		else
			SkM_Trace(FName, 3, "Group damage = 100% : award Full Kill");
			KillType = _SKM._playerFullKill;
		end

	end

	if (KillType ~= nil) then

		if (bBattleground == true) then
			KillType = _SKM._playerBGKill;
		end

		if (SkM_GetOption("DisplayKillRecord")) then
			if (KillType == _SKM._playerAssistKill) then
				SkM_ChatMessageColP(string.format(SKM_UI_STRINGS.RecordMessage_AssistKill, sName), SKM_Config.RGB_PlayerAssistKill);
			elseif (KillType == _SKM._playerKill) then
				SkM_ChatMessageColP(string.format(SKM_UI_STRINGS.RecordMessage_Kill, sName), SKM_Config.RGB_PlayerKill);
			elseif (KillType == _SKM._playerFullKill) then
				SkM_ChatMessageColP(string.format(SKM_UI_STRINGS.RecordMessage_FullKill, sName), SKM_Config.RGB_PlayerFullKill);
			end
		end

		--SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][KillType] = ifnil(SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][KillType], 0) + 1;
		SkM_UpdateEnemy_IncrCounter(sName, KillType, 1, true);

		if (bBattleground == true) then
			SkM_BGStats_AddKill();
		end


		if (bHonorKill) then
			--SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorKill] = ifnil(SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorKill], 0) + 1;
			SkM_UpdateEnemy_IncrHonorKill(sName, 1);

			SkM_SetHonorFlags(sName);
		end

		-- asked by Fumus : record special count for solo kills for which player did full damage
		if (KillType == _SKM._playerFullKill) and (getn(SKM_Context.GroupList) == 1) then
			SkM_Trace(FName, 3, "Group damage = 100% + solo : lone wolf kill");
			--SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._loneWolfKill] = ifnil(SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._loneWolfKill], 0) + 1;
			SkM_UpdateEnemy_IncrLoneWolfKill(sName, 1);
		end

--		local sGuildName = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._guild];
--		if ((sGuildName ~= nil) and (sGuildName ~= "")) then
--			SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][KillType] = ifnil(SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][KillType], 0) + 1;
--
--			if (bHonorKill) then

--				SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._honorKill] = ifnil(SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._honorKill], 0) + 1;
--			end
--
--			-- asked by Fumus : record special count for solo kills for which player did full damage
--			if (KillType == _SKM._playerFullKill) and (getn(SKM_Context.GroupList) == 1) then
--				SkM_Trace(FName, 3, "Group damage = 100% + solo : lone wolf kill");
--				SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._loneWolfKill] = ifnil(SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName][_SKM._loneWolfKill], 0) + 1;
--			end
--		end

		--local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];

		local StoreInfo = { };

		StoreInfo[_SKM._type] = KillType;
		StoreInfo[_SKM._name] = sName;
		StoreInfo[_SKM._date] = sDate1;
		--StoreInfo[_sortdate] = sDate2;

		-- asked by Fumus : record special count for solo kills for which player did full damage
		if (KillType == _SKM._playerFullKill) and (getn(SKM_Context.GroupList) == 1) then
			StoreInfo[_SKM._loneWolfKill] = true;
		end

		if (bHonorKill) then
			StoreInfo[_SKM._honorKill] = true;
		end

		StoreInfo[_SKM._enemyType] = _SKM._enemyPlayer;

		if (SkM_GetOption("RecordPlayerKill")) then
			local idx_gn;
			if (SkM_AddMapData(StoreInfo)) then
				idx_gn = table.getn(SKM_Data[_RealmName][_PlayerName].GlobalMapData);
			end

			SkM_AddRecentEnemyKill(sName, sDate1, idx_gn);
		end

		-- update target info if needed
		SkM_SetTargetInfo();
	end

	SKM_Context.EnemyCombat[sName] = nil;
end


function SkM_SetHonorFlags(sName)
	local FName = "SkM_SetHonorFlags";

	if (not sName) then
		SkM_Trace(FName, 1, "Name is nil");
		return;
	end
	if (not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName]) then
		SkM_Trace(FName, 1, "Enemy "..snil(sName).." not known");
		return;
	end

	local sDate = SkM_GetDate();
	local sDateLast = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorLastKill];

	if (not sDateLast) then
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorLastKill] = sDate;
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorCount] = 1;
	elseif (string.sub(sDate, 1, 10) ~= string.sub(sDateLast, 1, 10)) then
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorLastKill] = sDate;
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorCount] = 1;
	else
		SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorCount] = ifnil(SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorCount], 0) + 1;
	end

end


function SkM_GetHonorRemainingKills(sName)
	local FName = "SkM_GetHonorRemainingKills";

	if (not sName) then
		SkM_Trace(FName, 1, "Name is nil");
		return;
	end
	if (not SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName]) then
		SkM_Trace(FName, 1, "Enemy "..snil(sName).." not known");
		return;
	end

	local iCount;
	local sDate = SkM_GetDate();
	local sDateLast = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorLastKill];

	if (not sDateLast) then
		iCount = SKM_HonorKillPerDay;
	elseif (string.sub(sDate, 1, 10) ~= string.sub(sDateLast, 1, 10)) then
		iCount = SKM_HonorKillPerDay;
	else
		iCount = SKM_HonorKillPerDay - ifnil(SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName][_SKM._honorCount], 0);
		if (iCount < 0) then
			iCount = 0;
		end
	end
	return iCount;
end


function SkM_StoreDuelEnemyInfo(sUnit)
	local FName = "SkM_StoreDuelEnemyInfo";

	local sName = UnitName(sUnit);
	if (not sName) then
		return;
	end

	if (SKM_Context.DuelEnemy) and (SKM_Context.DuelEnemy[_SKM._name] == sName) then
		-- already stored
		return;
	end

	SKM_Context.DuelEnemy = { };
	SKM_Context.DuelEnemy[_SKM._name] = sName;
	SKM_Context.DuelEnemy[_SKM._race] = SkM_GetRaceIndex(UnitRace(sUnit));
	SKM_Context.DuelEnemy[_SKM._class] = SkM_GetClassIndex(UnitClass(sUnit));
	SKM_Context.DuelEnemy[_SKM._level] = UnitLevel(sUnit);
	SKM_Context.DuelEnemy[_SKM._guild] = GetGuildInfo(sUnit);

end


-- --------------------------------------------------------------------------------------
-- SkM_UpdateUnitData
-- --------------------------------------------------------------------------------------
-- Target unit has been updated. If it's an enemy, update that player information.
-- If it's a creep, store creature information.
-- --------------------------------------------------------------------------------------
function SkM_UpdateUnitData()
	local FName = "SkM_UpdateUnitData";

	local sName = SkM_UnitName(SKM_UNIT_TARGET);

	if (not sName) then
		-- clear target info
		SKM_Context.TargetInfo = nil;
	else
		if (SkM_UnitIsEnemyPlayer(SKM_UNIT_TARGET)) then
			local sDate1, sDate2 = SkM_GetDate();
			SkM_UpdateEnemyLastView(sName, sDate1, true, SKM_UNIT_TARGET);
		end

		if (not UnitIsPlayer(SKM_UNIT_TARGET)) then
			SkM_StoreTargetInfo(_SKM._enemyCreature);
		elseif (SkM_UnitIsEnemyPlayer(SKM_UNIT_TARGET)) then
			SkM_StoreTargetInfo(_SKM._enemyPlayer);
		else
			SKM_Context.TargetInfo = nil;
		end

		if (SkM_GetOption("StoreDuels")) then
			if (SkM_UnitIsDuelingPlayer(SKM_UNIT_TARGET)) then
				SkM_StoreDuelEnemyInfo(SKM_UNIT_TARGET);
			end
		end

	end


end


-- --------------------------------------------------------------------------------------
-- SkM_MouseOverUnitData
-- --------------------------------------------------------------------------------------
-- Get information on enemy player on mouse-over
-- --------------------------------------------------------------------------------------
function SkM_MouseOverUnitData()
	local FName = "SkM_MouseOverUnitData";

	local sName = SkM_UnitName(SKM_UNIT_MOUSEOVER);

	if (sName) then
		if (SkM_UnitIsEnemyPlayer(SKM_UNIT_MOUSEOVER)) then
			local sDate1, sDate2 = SkM_GetDate();
			SkM_UpdateEnemyLastView(sName, sDate1, true, SKM_UNIT_MOUSEOVER);

			--local iLevel = UnitLevel(SKM_UNIT_MOUSEOVER);
			--local sClass = UnitClass(SKM_UNIT_MOUSEOVER);
			--local sRace = UnitRace(SKM_UNIT_MOUSEOVER);
			--local sGuild = GetGuildInfo(SKM_UNIT_MOUSEOVER);
			--SkM_Trace(FName, 1, "Name = "..snil(sName)..", Level = "..snil(iLevel)..", Class = "..snil(sClass)..", Race = "..snil(sRace)..", Guild = "..snil(sGuild));

		elseif (SkM_GetOption("StoreDuels")) and (SkM_UnitIsDuelingPlayer(SKM_UNIT_MOUSEOVER)) then
			SkM_StoreDuelEnemyInfo(SKM_UNIT_MOUSEOVER);
		end

	end

end


-- --------------------------------------------------------------------------------------
-- SkM_ForgetPlayerHate
-- --------------------------------------------------------------------------------------
-- For all enemies in player hate list, recompute hate level from time elapsed since
-- last update.
-- "forget" enemy if hate reaches zero or if no update has been
-- received for a given time.
-- --------------------------------------------------------------------------------------
function SkM_ForgetPlayerHate()
	local FName = "SkM_ForgetPlayerHate";

	local curTime = GetTime();

	for sName, Enemy in SKM_Context.PlayerCombat do

		if (curTime - Enemy[_SKM._lastUpdate] > SKM_Config.ForgetAggressorTimer) then
			-- no  update since given time interval, forget, whatever the hate level may be
			SKM_Context.PlayerCombat[sName] = nil;
		else
			-- don't forget, but reduce hate from time elapsed
			local iTime = curTime - Enemy[_SKM._lastHateUpdate];

			nHateReduction = Enemy[_SKM._hateLevel] * (iTime / 100) * SKM_Config.HateReductionCoeff;

			SKM_Context.PlayerCombat[sName][_SKM._hateLevel] = Enemy[_SKM._hateLevel] - nHateReduction;
			SKM_Context.PlayerCombat[sName][_SKM._lastHateUpdate] = curTime;

			-- if hate is reduced to zero (or less), forget
			if (SKM_Context.PlayerCombat[sName][_SKM._hateLevel] <= 0) then
				SKM_Context.PlayerCombat[sName] = nil;
			end
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_LogDamage_OnSelf
-- --------------------------------------------------------------------------------------
-- Keep track of damage done on self and update "hate level" associated to the damage
-- dealer.
-- --------------------------------------------------------------------------------------
function SkM_LogDamage_OnSelf(iDamage, sName, EnemyType)
	local FName = "SkM_LogDamage_OnSelf";

	local curTime = GetTime();

	SkM_ForgetPlayerHate();

	if (not SKM_Context.PlayerCombat[sName]) then
		SKM_Context.PlayerCombat[sName] = { };
		SKM_Context.PlayerCombat[sName][_SKM._name] = sName;
		SKM_Context.PlayerCombat[sName][_SKM._enemyType] = EnemyType;
		SKM_Context.PlayerCombat[sName][_SKM._hateLevel] = 0;
		SKM_Context.PlayerCombat[sName][_SKM._damage] = 0;
		SKM_Context.PlayerCombat[sName][_SKM._lastHateUpdate] = curTime;
		SKM_Context.PlayerCombat[sName][_SKM._lastUpdate] = curTime;
	end

	-- store enemy type if we have it now and it was not previously stored
	if (not SKM_Context.PlayerCombat[sName][_SKM._enemyType]) and (EnemyType ~= nil) then
		SKM_Context.PlayerCombat[sName][_SKM._enemyType] = EnemyType;
	end

	SKM_Context.PlayerCombat[sName][_SKM._damage] = SKM_Context.PlayerCombat[sName][_SKM._damage] + iDamage;
	SKM_Context.PlayerCombat[sName][_SKM._hateLevel] = SKM_Context.PlayerCombat[sName][_SKM._hateLevel] + iDamage;

	SkM_Trace(FName, 3, "PlayerCombat updated for "..sName.." : damage = ".. SKM_Context.PlayerCombat[sName][_SKM._damage] ..", hate level = ".. SKM_Context.PlayerCombat[sName][_SKM._hateLevel]);
end


-- --------------------------------------------------------------------------------------
-- SkM_HateList_Dump
-- --------------------------------------------------------------------------------------
-- Debug function. Dump content of "PlayerCombat" (hate list).
-- --------------------------------------------------------------------------------------
function SkM_HateList_Dump()
	local FName = "SkM_HateList_Dump";

	local curTime = GetTime();


	SkM_ForgetPlayerHate();

	for idx, Elem in SKM_Context.PlayerCombat do
		local iTime = math.ceil(curTime - Elem[_SKM._lastUpdate]);
		local sReport = Elem[_SKM._name].." (last update : "..iTime.." s ago) -> damage = "..Elem[_SKM._damage]..", hate = "..Elem[_SKM._hateLevel];

		SkM_ChatMessageCol(sReport);
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_SortPlayerCombat_ByHate
-- --------------------------------------------------------------------------------------
-- Sort "PlayerCombat" list by hate level.
-- --------------------------------------------------------------------------------------
function SkM_SortPlayerCombat_ByHate(e1, e2)
	if (not e2[_SKM._hateLevel]) then
		return true;
	end
	if (not e1[_SKM._hateLevel]) then
		return false;
	end
	return (e1[_SKM._hateLevel] > e2[_SKM._hateLevel]);
end


-- --------------------------------------------------------------------------------------
-- SkM_PlayerDeathResp
-- --------------------------------------------------------------------------------------
-- Find who is responsible for your death, if any. This is the most hated enemy player
-- or creature from "PlayerCombat" list.
-- Also reset hate list afterwards.
-- --------------------------------------------------------------------------------------
function SkM_PlayerDeathResp()
	local FName = "SkM_PlayerDeathResp";

	SkM_ForgetPlayerHate();

	local HateList = {};
	local EnemyName, EnemyType;
	local iTotal = 0;

	local idx, val;
	for idx, val in SKM_Context.PlayerCombat do
		local Elem = copytable(val);
		iTotal = iTotal + Elem[_SKM._hateLevel];
		table.insert(HateList, Elem);
	end

	table.sort(HateList, SkM_SortPlayerCombat_ByHate);

	if (table.getn(HateList) > 0) then
		EnemyName = HateList[1][_SKM._name];
		EnemyType = HateList[1][_SKM._enemyType];
	end

	for idx, val in HateList do
		val[_SKM._hatePercent] = math.floor(100 * val[_SKM._hateLevel] / iTotal);
	end

	SkM_Trace(FName, 2, "Most hated = "..snil(EnemyName)..", type = "..snil(EnemyType));
	
	SKM_Context.PlayerCombat = { };

	return EnemyName, EnemyType, HateList;
end


-- --------------------------------------------------------------------------------------
-- SkM_DumpEnemyCombat
-- --------------------------------------------------------------------------------------
-- Debug function. Dump content of "EnemyCombat" list.
-- --------------------------------------------------------------------------------------
function SkM_DumpEnemyCombat()
	local FName = "SkM_DumpEnemyCombat";
	local curTime = GetTime();

	for idx, val in SKM_Context.EnemyCombat do
		local iTime = math.ceil(curTime - val[_SKM._lastUpdate]);

		sReport = val[_SKM._name] .. " (last update : "..iTime.." s ago) -> total damage = ".. val[_SKM._totalDamage] .. ", group damage = " .. val[_SKM._groupDamage];
		SkM_ChatMessageCol(sReport);
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_IsLeapYear
-- --------------------------------------------------------------------------------------
-- Is given year a leap year ?
-- --------------------------------------------------------------------------------------
function SkM_IsLeapYear(iYear)
	return intable(iYear, LeapYears);
end


-- --------------------------------------------------------------------------------------
-- SkM_DaysInYear
-- --------------------------------------------------------------------------------------
-- Return number of days in given year
-- --------------------------------------------------------------------------------------
function SkM_DaysInYear(iYear)
	if (SkM_IsLeapYear(iYear)) then
		return 366;
	else
		return 365;
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_DaysInMonth
-- --------------------------------------------------------------------------------------
-- Return number of days in given month of a given year
-- --------------------------------------------------------------------------------------
function SkM_DaysInMonth(iMonth, iYear)
	local iDays = DaysInMonth[iMonth];
	if (iMonth == 2) and SkM_IsLeapYear(iYear) then
		iDays = 29;
	end
	return iDays;
end


-- --------------------------------------------------------------------------------------
-- SkM_TimeSinceEpoch
-- --------------------------------------------------------------------------------------
-- Return the number of seconds since "epoch", fixed at 01/01/2004 00:00:00.
-- (we do not need to handle time periods prior to WoW release, so this does not need
-- to be less than this time)
-- --------------------------------------------------------------------------------------
function SkM_TimeSinceEpoch(sDate)
	local FName = "SkM_TimeSinceEpoch";

	SkM_Trace(FName, 3, "Date = "..snil(sDate));

	local iDay, iMonth, iYear, iHour, iMin, iSec;

	iDay = tonumber( string.sub(sDate, 1, 2) );
	iMonth = tonumber( string.sub(sDate, 4, 5) );
	iYear = tonumber( string.sub(sDate, 7, 10) ) ;

	iHour = tonumber( string.sub(sDate, 12, 13) );
	iMin = tonumber( string.sub(sDate, 15, 16) );
	iSec = tonumber( string.sub(sDate, 18, 19) );

	if (iDay == nil) or (iMonth == nil) or (iYear == nil) or (iHour == nil) or (iMin == nil) or (iSec == nil) then
		return nil;
	end

	local iTime = 0;

	iIndYear = 2004;
	while (iIndYear < iYear) do
		iTime = iTime + SkM_DaysInYear(iIndYear); iIndYear = iIndYear + 1;
	end

	iIndMonth = 1;
	while (iIndMonth < iMonth) do
		iTime = iTime + SkM_DaysInMonth(iIndMonth, iYear); iIndMonth = iIndMonth + 1;
	end

	iTime = (iTime + (iDay - 1)) * 24;
	iTime = (iTime + (iHour - 1)) * 60;
	iTime = (iTime + (iMin - 1)) * 60;
	iTime = iTime + iSec;

	SkM_Trace(FName, 3, "Sec num since 01/01/2004 = "..snil(iTime));
	return iTime;
end


-- --------------------------------------------------------------------------------------
-- SkM_DiffDate
-- --------------------------------------------------------------------------------------
-- Return the difference in seconds between two dates in format DD/MM/YYYY HH:MI:SS
-- --------------------------------------------------------------------------------------
function SkM_DiffDate(sDate1, sDate2)
	local FName = "SkM_DiffDate";

	if (sDate1 == nil) or (sDate2 == nil) then
		return nil;
	end

	local iTime1, iTime2, iTime;

	iTime1 = SkM_TimeSinceEpoch(sDate1);
	iTime2 = SkM_TimeSinceEpoch(sDate2);

	if (iTime1 == nil) or (iTime2 == nil) then
		return nil;
	end

	iTime = iTime1 - iTime2;
	SkM_Trace(FName, 3, "Time difference = "..snil(iTime));
	return iTime;
end


-- --------------------------------------------------------------------------------------
-- SkM_SetTargetInfoText
-- --------------------------------------------------------------------------------------
-- Set a line of text of SKMapTargetInfoButton
-- --------------------------------------------------------------------------------------
function SkM_SetTargetInfoText(id, sLabel, sValue, sDetail)
	local FName = "SkM_SetTargetInfoText";

	local TextLabe, ValueLabel, DetailLabel;
	if (sLabel) then
		TextLabel = getglobal("SKMapTargetInfoButton"..id.."Label");
		if (not TextLabel) then return false; end
	end
	if (sValue) then
		ValueLabel = getglobal("SKMapTargetInfoButton"..id.."Value");
		if (not ValueLabel) then return false; end
	end
	if (sDetail) then
		DetailLabel = getglobal("SKMapTargetInfoButton"..id.."Detail");
		if (not DetailLabel) then return false; end
	end

	if (sLabel) then
		TextLabel:SetText(sLabel);
	end
	if (sValue) then
		ValueLabel:SetText(sValue);
	end
	if (sDetail) then
		DetailLabel:SetText(sDetail);
	end

	return true;
end


-- --------------------------------------------------------------------------------------
-- SkM_SetSmallTargetInfoText
-- --------------------------------------------------------------------------------------
-- Set a line of text of SKMapSmallTargetInfoButton
-- --------------------------------------------------------------------------------------
function SkM_SetSmallTargetInfoText(id, sLabel, sValue)
	local FName = "SkM_SetTargetInfoText";

	local TextLabe, ValueLabel;
	if (sLabel) then
		TextLabel = getglobal("SKMapSmallTargetInfoButton"..id.."Label");
		if (not TextLabel) then return false; end
	end
	if (sValue) then
		ValueLabel = getglobal("SKMapSmallTargetInfoButton"..id.."Value");
		if (not ValueLabel) then return false; end
	end

	if (sLabel) then
		TextLabel:SetText(sLabel);
	end
	if (sValue) then
		ValueLabel:SetText(sValue);
	end

	return true;
end


-- --------------------------------------------------------------------------------------
-- SkM_ShowTargetGuildInfo
-- --------------------------------------------------------------------------------------
-- Display or hide guild info mini frame
-- --------------------------------------------------------------------------------------
function SkM_ShowTargetGuildInfo(bShow, sGuildName, bGuildWar)

	if (not SkM_GetOption("ShowTargetGuildInfo")) then
		SKMapTargetGuildInfo:Hide();
	else
		if (bShow ~= true) or (sGuildName == nil) or (sGuildName == "") then
			SKMapTargetGuildInfo:Hide();
		else
			local id=1;
			TextValue = getglobal("SKMapTargetGuildInfoButton"..id.."Value");

			local sText;
			if (bGuildWar) then
				sText = SKM_Config.Col_PlayerWar;
			else
				sText = SKM_Config.Col_Label;
			end
			sText = sText..sGuildName;
			TextValue:SetText(sText);

			SKMapTargetGuildInfo:Show();
		end
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_ShowTargetClassInfo
-- --------------------------------------------------------------------------------------
-- Display or hide class info mini frame
-- --------------------------------------------------------------------------------------
function SkM_ShowTargetClassInfo(bShow, sClass)

	if (not SkM_GetOption("ShowTargetClassInfo")) then
		SKMapTargetClassInfo:Hide();
	else
		if (bShow ~= true) or (sClass == nil) or (sClass == "") then
			SKMapTargetClassInfo:Hide();
		else
			local id=1;
			TextValue = getglobal("SKMapTargetClassInfoButton"..id.."Value");

			sText = SKM_Config.Col_Label;
			sText = sText..sClass;
			TextValue:SetText(sText);

			SKMapTargetClassInfo:Show();
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_SetTargetInfo
-- --------------------------------------------------------------------------------------
-- Fill and display or hidel TargetInfo frame(s) according to current target
-- --------------------------------------------------------------------------------------
function SkM_SetTargetInfo()
	local FName = "SkM_SetTargetInfo";

	local sName = SkM_UnitName(SKM_UNIT_TARGET);
--local sName = "Abaddon";
	if (not sName) then
		-- no target
		SkM_HideTargetInfoFrame();
		SkM_ShowTargetGuildInfo(false, nil, nil);
		SkM_ShowTargetClassInfo(false, nil);
		SkM_SetWarDragon(false, false);
		return false;
	end

	local sClass = UnitClass(SKM_UNIT_TARGET);

	if (SkM_UnitIsEnemyPlayer(SKM_UNIT_TARGET)) then
--if (true) then

		local bWar = false;
		local bGuildWar = false;

		local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];
		if (not Enemy) then
			SkM_HideTargetInfoFrame();
			SkM_SetWarDragon(false, false);
			return false;
		end

		-- 09/04/2005 17:23:14 PIng Add guild support
		local sGuildName =  Enemy[_SKM._guild];
		if (sGuildName == "") then sGuildName = nil; end
		local Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName];
		-- 09/04/2005 17:24:33 End of modification

		if (Enemy[_SKM._atWar]) then
			bWar = true;
		end
		if (Guild) and (Guild[_SKM._atWar]) then
			bGuildWar = true;
		end

		SkM_ShowTargetGuildInfo(true, sGuildName, bGuildWar);
		SkM_ShowTargetClassInfo(true, sClass);

		local iKill = ifnil(Enemy[_SKM._playerKill], 0);
		local iAssistKill = ifnil(Enemy[_SKM._playerAssistKill], 0);
		local iFullKill = ifnil(Enemy[_SKM._playerFullKill], 0);
		local iTotalKill = iKill + iAssistKill + iFullKill;
		local iHonorKill = ifnil(Enemy[_SKM._honorKill], 0);

		local iRemaining = SkM_GetHonorRemainingKills(sName);

		-- 09/04/2005 17:25:03 PIng Add guild support
		local gKill = "";
		local gAssistKill = "";
		local gFullKill = "";
		local gTotalKill = "";
		local gDeath = "";
		local gMet = "";
		if (sGuildName ~= nil) then
			gKill = ifnil(Guild[_SKM._playerKill], 0);
			gAssistKill = ifnil(Guild[_SKM._playerAssistKill], 0);
			gFullKill = ifnil(Guild[_SKM._playerFullKill], 0);
			gTotalKill = gKill + gAssistKill + gFullKill;
			gDeath = ifnil(Guild[_SKM._enemyKillPlayer], 0);
			gMet = ifnil(Guild[_SKM._meetCount], 0);
		end
		-- 09/04/2005 17:25:12 End of modification

		local iDeath = ifnil(Enemy[_SKM._enemyKillPlayer], 0);
		local iMet = ifnil(Enemy[_SKM._meetCount], 0);

		SkM_Trace(FName, 3, "Kill = "..iKill..", AssistKill = "..iAssistKill..", FullKill = "..iFullKill..", Met = "..iMet);
		-- 09/04/2005 17:25:03 PIng Add guild support
		if (sGuildName ~= nil) then
			SkM_Trace(FName, 3, "Guild Kill = "..gKill..", Guild AssistKill = "..gAssistKill..", Guild FullKill = "..gFullKill..", Guild Met = "..gMet);
		end
		-- 09/04/2005 17:25:12 End of modification

		local sKill = SKM_Config.Col_PlayerTotalKill .. iTotalKill;
		local sKillDetail;
		-- only display detail kill count if there's at least one kill
--		if (iTotalKill == 0) then
--			sKillDetail = "";
--		else
--			sKillDetail = SKM_Config.Col_Label .. "( " .. SKM_Config.Col_PlayerFullKill .. iFullKill .. SKM_Config.Col_Label .. " + " .. SKM_Config.Col_PlayerKill .. iKill .. SKM_Config.Col_Label .. " + " .. SKM_Config.Col_PlayerAssistKill .. iAssistKill .. SKM_Config.Col_Label .. " )";
--		end

		sKillDetail = SKM_UI_STRINGS.Small_Target_Honor..SKM_Config.Col_HonorKill..iHonorKill.."  ";
		--local FrameColor;
		local LabelColor;
		if (iRemaining == 0) then

			sKillDetail = sKillDetail..SKM_Config.Col_Label.."( "..SKM_Config.Col_Honorless..SKM_UI_STRINGS.Small_Target_NoHonor..SKM_Config.Col_Label.." )";
			--FrameColor = { r = 0.0, g = 0.0, b = 0.0 };
			LabelColor = SKM_Config.Col_LabelTitle;
		else
			sKillDetail = sKillDetail..SKM_Config.Col_Label.."( "..SKM_Config.Col_HonorKill..iRemaining..SKM_Config.Col_Label.." )";
			--FrameColor = { r = 0.3, g = 1.0, b = 1.0 };
			LabelColor = SKM_Config.Col_HonorKill;
		end

		local sDeath = SKM_Config.Col_PlayerDeath .. iDeath;
		local sMet = SKM_Config.Col_PlayerMet .. iMet;

		local sWar1 = "";
		local sWar2 = "";

		if (Enemy[_SKM._atWar] == true) then
			sWar1 = SKM_Config.Col_PlayerWar.. SKM_UI_STRINGS.Small_Target_War;
			sWar2 = "";
			if (Enemy[_SKM._warDate]) then
				local sDisplayDate = string.sub(Enemy[_SKM._warDate], 1, 10);
				sWar2 = SKM_Config.Col_PlayerWar .. SKM_UI_STRINGS.Since .. sDisplayDate;
			end
		end

		local bRes1, bRes2, bRes3, bRes4;

		if (SkM_GetOption("SmallTargetInfo")) then
			bRes1 = SkM_SetSmallTargetInfoText(1, LabelColor..SKM_UI_STRINGS.Small_Target_Info_Kill, sKill);
			bRes2 = SkM_SetSmallTargetInfoText(2, SKM_UI_STRINGS.Small_Target_Info_Death, sDeath);
			bRes3 = SkM_SetSmallTargetInfoText(3, SKM_UI_STRINGS.Small_Target_Info_Met, sMet);
			bRes4 = SkM_SetSmallTargetInfoText(4, sWar1);
		else
			bRes1 = SkM_SetTargetInfoText(1, SKM_UI_STRINGS.Small_Target_Info_Kill, sKill, sKillDetail);
			bRes2 = SkM_SetTargetInfoText(2, SKM_UI_STRINGS.Small_Target_Info_Death, sDeath, "");
			bRes3 = SkM_SetTargetInfoText(3, SKM_UI_STRINGS.Small_Target_Info_Met, sMet, "");
			bRes4 = SkM_SetTargetInfoText(4, sWar1, "", sWar2);
		end

		SkM_ShowTargetFrameWarButtons(Enemy[_SKM._atWar]);

		SkM_SetWarDragon(bWar, bGuildWar);

		if (bRes1 and bRes2 and bRes3 and bRes4) then
			SkM_ShowTargetInfoFrame();
			return true;
		else
			SkM_HideTargetInfoFrame();
			return false;
		end

	else
		SkM_HideTargetInfoFrame();
		SkM_SetWarDragon(false, false);

		if (UnitIsPlayer(SKM_UNIT_TARGET)) then
			local sGuildName = GetGuildInfo(SKM_UNIT_TARGET);
			SkM_ShowTargetGuildInfo(true, sGuildName, false);
			SkM_ShowTargetClassInfo(true, sClass);
		else
			SkM_ShowTargetGuildInfo(false, nil, nil);
			SkM_ShowTargetClassInfo(false, nil);
		end



		-- if we switch from a player dragon to an elite mob, we must keep the "elite" frame !
		--if (UnitIsPlusMob(SKM_UNIT_TARGET)) then
		local sUnitClassification = UnitClassification(SKM_UNIT_TARGET);
		if     (UnitIsPlusMob(SKM_UNIT_TARGET))
		  or ( (sUnitClassification ~= nil) and (sUnitClassification ~= "") and (sUnitClassification ~= "normal") )
		then
			TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
		end

		return false;
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_SetWarDragon
-- --------------------------------------------------------------------------------------
-- Display or hide the red "elite dragon" around target portrait.
-- If this enemy or his guild is set "at war", then the dragon is shown
-- Otherwise, color is reset and the "elite dragon" is hidden
-- --------------------------------------------------------------------------------------
function SkM_SetWarDragon(bWar, bGuildWar)
	local FName = "SkM_SetWarDragon";

	if (bWar) or (bGuildWar) then
		--Set Red Dragon Overlay on Texture to Target
		TargetFrameTexture:SetVertexColor(1.0, 200.0, 1.0, TargetFrameTexture:GetAlpha());
		TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");

	else
		-- not at war with target
		TargetFrameTexture:SetVertexColor(1.0, 1.0, 1.0, TargetFrameTexture:GetAlpha());
		TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_EnemyWar
-- --------------------------------------------------------------------------------------
-- Declare war to an enemy player, or call a truce with this player
-- --------------------------------------------------------------------------------------
function SkM_EnemyWar(bWar, sEnemyName)
	local FName = "SkM_EnemyWar";

	SkM_Trace(FName, 3, "War button pressed");

	local sName;
	if (sEnemyName) then
		sName = sEnemyName;
	else
		local sTargetName = SkM_UnitName(SKM_UNIT_TARGET);
		sName = sTargetName;
	end

	if (not sName) then
		SkM_Trace(FName, 1, "No enemy specified");
		return;
	end

	local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];
	if (not Enemy) then
		SkM_Trace(FName, 1, "Enemy not found : "..snil(sName));
		return;
	end

	local sGuildName = Enemy[_SKM._guild];
	local Guild;
	local bGuildWar = false;
	if (sGuildName) and (sGuildName ~= "") then
		Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName];
	end
	if (Guild) and (Guild[_SKM._atWar]) then
		bGuildWar = true;
	end

	local sDate = SkM_GetDate();

	SkM_UpdateEnemy_SetWar(sName, bWar, sDate);

	SkM_ShowTargetFrameWarButtons(Enemy[_SKM._atWar]);

	-- 09/04/2005 16:18:34 PIng: Update war info on target frame when status is changed
	local sWar1 = "";
	local sWar2 = "";

	if (Enemy[_SKM._atWar] == true) then
		sWar1 = SKM_Config.Col_PlayerWar.. SKM_UI_STRINGS.Small_Target_War;
		sWar2 = "";
		if (Enemy[_SKM._warDate]) then
			local sDisplayDate = string.sub(Enemy[_SKM._warDate], 1, 10);
			sWar2 = SKM_Config.Col_PlayerWar .. SKM_UI_STRINGS.Since .. sDisplayDate;
		end
	end

	local bRes4;

	if (SkM_GetOption("SmallTargetInfo")) then
		bRes4 = SkM_SetSmallTargetInfoText(4, sWar1);
	else
		bRes4 = SkM_SetTargetInfoText(4, sWar1, "", sWar2);
	end
	-- 09/04/2005 16:18:31 End of modification

	if (sName == sTargetName) then
		SkM_SetWarDragon(bWar, bGuildWar);
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_UnknownEnemyWar
-- --------------------------------------------------------------------------------------
-- Declare war to an enemy player that can is potentially not known yet
-- --------------------------------------------------------------------------------------
function SkM_UnknownEnemyWar(sName, bWar, bDisplay)
	local FName = "SkM_UnknownEnemyWar";


	SkM_Trace(FName, 3, "Enemy player = "..snil(sName));

	local sDate = SkM_GetDate();

	if (sName) then
		local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];
		if (Enemy) then
			local bWarPrev = Enemy[_SKM._atWar];
			SkM_UpdateEnemy_SetWar(sName, bWar, sDate);
			if (bDisplay) then
				if (bWar) and (not bWarPrev) then
					SkM_ChatMessageCol("Now at WAR with "..sName);
				elseif (not bWar) and (bWarPrev) then
					SkM_ChatMessageCol("No longer at WAR with "..sName);
				end
			end

			-- update target info if needed
			SkM_SetTargetInfo();

			-- update interface enemy list if needed
			local bVisible, sFrame = SKMap_IsUIVisible();

			if (bVisible) and (sFrame == "SKMap_ListFrame") and (SKM_List_ActiveList == _SKM._players) then
				SKMap_ListFrame_UpdateList();
				if (SKM_List_SelectedPlayer) then
					SKMap_ListFrame_ShowWarButton(bWar);
				end
			end
			if (SKM_List_ActiveList == _SKM._players) and (SKM_List_SelectedPlayer) then
				SKMap_ListFrame_SelectElement(SKM_List_SelectedPlayer);
			end

		else
			-- unknown enemy
			if (bWar) then
				SKM_Data[_RealmName][_PlayerName].UnknownEnemy[sName] = 1;
				if (bDisplay) then
					SkM_ChatMessageCol("Now at WAR with "..sName.." (not yet known)");
				end
			else
				if (SKM_Data[_RealmName][_PlayerName].UnknownEnemy[sName]) then
					SKM_Data[_RealmName][_PlayerName].UnknownEnemy[sName] = nil;
					if (bDisplay) then
						SkM_ChatMessageCol("No longer at WAR with "..sName.." (not yet known)");
					end
				end
			end

		end

	end
end


function SkM_ShowUnknownEnemyWar()
	local sMsg = "";
	local iCount = 0;

	local idx, val;
	for idx, val in SKM_Data[_RealmName][_PlayerName].UnknownEnemy do
		sMsg = sMsg..idx.."  ";
		iCount = iCount + 1;
	end

	if (iCount == 0) then
		SkM_ChatMessageCol("Unknown players WAR list is empty");
	else
		SkM_ChatMessageCol("Unknown players WAR list ("..iCount..") :");
		SkM_ChatMessageCol(sMsg);
	end

end


function SkM_ClearUnknownEnemyWar()
	SKM_Data[_RealmName][_PlayerName].UnknownEnemy = { };
	SkM_ChatMessageCol("Unknown players WAR list cleared");
end


function SkM_FindSharedEnemyWar(sName)
	local FName = "SkM_FindSharedEnemyWar";

	-- parse all characters of the same realm
	local idx_char, val_char;
	for idx_char, val_char in SKM_Data[_RealmName] do
		if (SKM_Data[_RealmName][idx_char].PlayerName == idx_char) then
			local Enemy = SKM_Data[_RealmName][idx_char].EnemyHistory[sName];

			-- if enemy known to this player, and set "at war", return him
			if (Enemy) and (Enemy[_SKM._atWar]) then
				return Enemy, idx_char;
			end
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_MouseOverUnit
-- --------------------------------------------------------------------------------------
-- Handle "mouseover unit" event.
-- If that unit is an enemy player that is "at war", or whose guild is "at war" :
--   Display floating message (if configured)
--   Play warning sound (if configured)
-- If unit is an unknown enemy and we have no current target, target him to store
-- information, then clear target again.
-- --------------------------------------------------------------------------------------
function SkM_MouseOverUnit()
	local FName = "SkM_MouseOverUnit";

	local sDate = SkM_GetDate();

	-- store information related to mouse-overed unit
	SkM_MouseOverUnitData();

	if (SkM_UnitIsEnemyPlayer(SKM_UNIT_MOUSEOVER)) then
--	if (true) then
		-- Grab the name of who we've moused-over
		local sName = SkM_UnitName(SKM_UNIT_MOUSEOVER);
		--local sName = "Ledieu";
		if (not sName) then
			return;
		end

		local sGuildName = GetGuildInfo(SKM_UNIT_MOUSEOVER);

		local bWar = false;
		local bGuildWar = false;
		local bSharedWar = false;

		local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];
		local SharedEnemy, SharedChar;
		local Guild;

		if (Enemy) and (Enemy[_SKM._atWar]) then
			bWar = true;
		end

		if (sGuildName ~= nil) and (sGuildName ~= "") then
			Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[sGuildName];
			if (Guild ~= nil) and (Guild[_SKM._atWar]) then
				bGuildWar = true;
			end
		end

		if not (bWar or bGuildWar) then
			if (SkM_GetOption("SharedWarMode")) then
				SharedEnemy, SharedChar = SkM_FindSharedEnemyWar(sName);
				if (SharedEnemy) and (SharedEnemy[_SKM._atWar]) then
					bSharedWar = true;
				end
			end
		end

		if (bWar) or (bGuildWar) or (bSharedWar) then
			local bFilter = false;

			if (SkM_GetOption("WarEnableFilter")) then
				-- check against global "last warning date"
				if (SKM_Context.LastWarWarning) then
					local iDiffTime = SkM_DiffDate(sDate, SKM_Context.LastWarWarning);
					if (iDiffTime ~= nil) and (iDiffTime <= SkM_GetOption("WarFilterDelay")) then
						-- Filter out to reduce spam
						bFilter = true;
					end
				end

			end

			-- check against last warning for given enemy
			-- (independently of filter option)
			if (SkM_GetRecentWarWarning(sName)) then
				-- Filter out to reduce spam
				bFilter = true;
			end

			if (not bFilter) then
				SKM_Context.LastWarWarning = sDate;
				SkM_AddRecentWarWarning(sName, sDate);

				SkM_Trace(FName, 3, "Last War Warning = "..snil(SKM_Context.LastWarWarning));

				if (SkM_GetOption("WarSoundWarning")) then
					--PlaySound("AuctionWindowClose");
					PlaySoundFile(SKM_Config.WarSoundFile);
				end

				if (SkM_GetOption("WarFloatingMessage")) then
					local sWarMessage = "";
					if (bWar) and (bGuildWar) then
						sWarMessage = sName.." / "..sGuildName;
					elseif (bWar) then
						sWarMessage = sName;
					elseif (bGuildWar) then
						sWarMessage = sGuildName;
					elseif (bSharedWar) then
						sWarMessage = sName..SKM_Config.Col_SharedWar.." ["..SharedChar.."]".."|r";
					end
					UIErrorsFrame:AddMessage(SKM_UI_STRINGS.War_Floating_Message..sWarMessage, 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
				end

				if (SkM_GetOption("WarChatMessage")) then
					local sWarMessage = "";
					if (bWar) and (bGuildWar) then
						sWarMessage = sName.." / "..sGuildName;
					elseif (bWar) then
						sWarMessage = sName;
					elseif (bGuildWar) then
						sWarMessage = sGuildName;
					elseif (bSharedWar) then
						sWarMessage = sName..SKM_Config.Col_SharedWar.." ["..SharedChar.."]".."|r";
					end
					if (SkM_GetOption("WarShowNote")) then
						if (not bSharedWar) then
							if (Enemy) and (Enemy[_SKM._playerNote] ~= nil) and (Enemy[_SKM._playerNote] ~= "") then
								sWarMessage = sWarMessage .. SKM_Config.Col_Label.." - " .. SKM_Config.Col_PlayerNote.. Enemy[_SKM._playerNote];
							end
						else
							if (SharedEnemy) and (SharedEnemy[_SKM._playerNote]) and (SharedEnemy[_SKM._playerNote] ~= "") then
								sWarMessage = sWarMessage .. SKM_Config.Col_Label.." - " .. SKM_Config.Col_PlayerNote .. SharedEnemy[_SKM._playerNote];
							end
						end
					end
					SkM_PrintMessage(SKM_UI_STRINGS.War_Floating_Message..sWarMessage, 1.0, 0.0, 0.0);
				end

			end

			if (SkM_GetOption("WarAutoTarget") and (not UnitName(SKM_UNIT_TARGET))) then
				TargetByName(sName);
			end
		end

		-- Add information to tooltip (if option enabled)
		if (SkM_GetOption("TooltipTargetInfo")) then
			SKMap_TooltipEnemyInfo(sName);
		end

		-- Add player note to tooltip (if option enabled)
		if (SkM_GetOption("TooltipPlayerNote")) then
			SKMap_TooltipEnemyNote(sName);
		end

	end

	--if (SkM_GetOption("TooltipTargetInfo")) then
	--	SKMap_TooltipEnemyInfo("Ledieu");
	--end
	--if (SkM_GetOption("TooltipPlayerNote")) then
	--	SKMap_TooltipEnemyNote("Ledieu");
	--end


end


-- --------------------------------------------------------------------------------------
-- SkM_ShowTargetInfoFrame
-- --------------------------------------------------------------------------------------
-- Show one of the SKMap TargetInfo frames (small or normal), and hide the other.
-- --------------------------------------------------------------------------------------
function SkM_ShowTargetInfoFrame()
	local FName = "SkM_ShowTargetInfoFrame";

	local bShow = SkM_GetOption("ShowTargetInfo");

	if (SkM_GetOption("SmallTargetInfo")) then
		SkM_DisplayTargetInfoFrames(false, bShow);
	else
		SkM_DisplayTargetInfoFrames(bShow, false);
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_HideTargetInfoFrame
-- --------------------------------------------------------------------------------------
-- Hide both SKMap TargetInfo frames.
-- --------------------------------------------------------------------------------------
function SkM_HideTargetInfoFrame()
	local FName = "SkM_HideTargetInfoFrame";

	SkM_DisplayTargetInfoFrames(false, false);
end


-- --------------------------------------------------------------------------------------
-- SkM_ShowTargetFrameWarButtons
-- --------------------------------------------------------------------------------------
-- Show/hide war and truce button on the currently active SKMap TargetInfo frame,
-- according to war status.
-- --------------------------------------------------------------------------------------
function SkM_ShowTargetFrameWarButtons(bWar)
	local FName = "SkM_ShowTargetFrameWarButtons";

	if (SkM_GetOption("SmallTargetInfo")) then
		if (bWar == true) then
			SKMapSmallPvPTruceButton:Show();
			SKMapSmallPvPWarButton:Hide();
		else

			SKMapSmallPvPTruceButton:Hide();
			SKMapSmallPvPWarButton:Show();
		end

	else
		if (bWar == true) then
			SKMapPvPTruceButton:Show();
			SKMapPvPWarButton:Hide();
		else
			SKMapPvPTruceButton:Hide();
			SKMapPvPWarButton:Show();
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_DisplayTargetInfoFrames
-- --------------------------------------------------------------------------------------
-- Show or Hide the large or small target info frame
-- --------------------------------------------------------------------------------------
function SkM_DisplayTargetInfoFrames(bLarge, bSmall)
	local FName = "SkM_DisplayTargetInfoFrames";

	if (bLarge == true) then
		SKMapTargetInfoFrame:Show();
	elseif (bLarge == false) then
		SKMapTargetInfoFrame:Hide();
	end

	if (bSmall == true) then
		SKMapSmallTargetInfoFrame:Show();
	elseif (bSmall == false) then
		SKMapSmallTargetInfoFrame:Hide();
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_TargetInfoResize
-- --------------------------------------------------------------------------------------
-- Switch from one size of the SKMap TargetInfo frame to the other
-- --------------------------------------------------------------------------------------
function SkM_TargetInfoResize()
	local FName = "SkM_TargetInfoResize";

	SkM_SetOption("SmallTargetInfo", not (SkM_GetOption("SmallTargetInfo")) );

	SkM_SetTargetInfo();
end


-- --------------------------------------------------------------------------------------
-- SkM_StoreTargetInfo
-- --------------------------------------------------------------------------------------
-- Store currently targetted creature information.
-- Remember if it's tapped and by who.
-- --------------------------------------------------------------------------------------
function SkM_StoreTargetInfo(sTargetType)
	local sName = SkM_UnitName(SKM_UNIT_TARGET);

	if (not sName) then
		SKM_Context.TargetInfo = nil;
	else
		if (not SKM_Context.TargetInfo) or (SKM_Context.TargetInfo[_SKM._name] ~= sName) then
			SKM_Context.TargetInfo = { };
			SKM_Context.TargetInfo[_SKM._name] = sName;
		end

		SKM_Context.TargetInfo[_SKM._type] = sTargetType;

		if (sTargetType == _SKM._enemyCreature) then

			if (UnitIsTapped(SKM_UNIT_TARGET)) then
				if (UnitIsTappedByPlayer(SKM_UNIT_TARGET)) then
					SKM_Context.TargetInfo[_SKM._owner] = _SKM._player;
				else
					SKM_Context.TargetInfo[_SKM._owner] = _SKM._other;
				end
			end

		end

	end
end


-- --------------------------------------------------------------------------------------
-- SkM_TargetHealthUpdated
-- --------------------------------------------------------------------------------------
-- Target unit health has changed.
-- If this is a creature and if it just died, record creature kill if need be.
-- If this is a creature and it's still alive, update information.
-- --------------------------------------------------------------------------------------
function SkM_TargetHealthUpdated()
	local FName = "SkM_TargetHealthUpdated";

	local sName = SkM_UnitName(SKM_UNIT_TARGET);
	if (not sName) then
		return;
	end

	if (UnitHealth(SKM_UNIT_TARGET) == 0 or UnitIsCorpse(SKM_UNIT_TARGET) or UnitIsDeadOrGhost(SKM_UNIT_TARGET)) then

		-- we use this event to track pve kills for unit currently targetted
		-- (player kills are tracked by damage done)

		if (not UnitIsPlayer(SKM_UNIT_TARGET)) then

			-- award kill to player if : we have previously stored the creature information
			-- in context, and if it was tapped by player
			-- in all cases, clear target info.
			if (SKM_Context.TargetInfo) and (SKM_Context.TargetInfo[_SKM._name] == sName) then

				if (SKM_Context.TargetInfo[_SKM._owner] == _SKM._player) then

					SkM_Trace(FName, 3, "Target creature (".. sName ..") kill detected - by player");

					local iLevel = UnitLevel(SKM_UNIT_TARGET);
					local bElite = UnitIsPlusMob(SKM_UNIT_TARGET);
					local sClassification = UnitClassification(SKM_UNIT_TARGET);

					SkM_RecordCreatureKill_Target(sName, iLevel, sClassification);
				else
					SkM_Trace(FName, 3, "Target creature (".. sName ..") kill detected, but by other");
				end
			end

		elseif (SkM_UnitIsEnemyPlayer(SKM_UNIT_TARGET)) then
			SkM_Trace(FName, 2, "Enemy player death detected (from target) : "..snil(sName));
			SkM_PvpEnemyDeath(sName);
		end

		SKM_Context.TargetInfo = nil;

	else
		-- unit is alive
		if (not UnitIsPlayer(SKM_UNIT_TARGET)) then
			-- not a player, update owner information
			SkM_StoreTargetInfo(_SKM._enemyCreature);
		end
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_PlayerLevelUp
-- --------------------------------------------------------------------------------------
-- Handle "player level up" event : record event, and store new level.
-- --------------------------------------------------------------------------------------
function SkM_PlayerLevelUp()
	local FName = "SkM_PlayerLevelUp";

	local StoreInfo = { };

	StoreInfo[_SKM._type] = _SKM._levelUp;

	local sDate1, sDate2 = SkM_GetDate();
	StoreInfo[_SKM._date] = sDate1;
	--StoreInfo[_sortdate] = sDate2;

	StoreInfo[_SKM._name] = _PlayerName;

	local iNewLevel;
	if (SKM_Context.PlayerLevel) then
		iNewLevel = SKM_Context.PlayerLevel + 1;
	else
		iNewLevel = UnitLevel(SKM_UNIT_PLAYER) + 1;
	end
	StoreInfo[_SKM._level] = iNewLevel;
	SKM_Context.PlayerLevel = iNewLevel;

	if (not SkM_AddMapData(StoreInfo)) then
		return;
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_CountGuildMembers
-- --------------------------------------------------------------------------------------
-- Count number of members known for a given guild.
-- --------------------------------------------------------------------------------------
function SkM_CountGuildMembers(sGuild, sRealm, sPlayer)
	local FName = "SkM_CountGuildMembers";

	local sRealmName = sRealm;
	local sPlayerName = sPlayer;

	SkM_Trace(FName, 4, "Get member count for guild : "..snil(sGuild));

	if (sRealmName == nil) then
		sRealmName = _RealmName;
	end

	if (sPlayerName == nil) then
		sPlayerName = _PlayerName;
	end

	if (SKM_Data[sRealmName] == nil) then
		return nil;
	end
	if (SKM_Data[sRealmName][sPlayerName] == nil) then
		return nil;
	end

	local iCount = 0;

	for idx, val in SKM_Data[sRealmName][sPlayerName].EnemyHistory do
		local sName = val[_SKM._name];
		if (sName) then
			if (val[_SKM._guild] == sGuild) then
				iCount = iCount + 1;
			end
		end
	end

	return iCount;
end


-- --------------------------------------------------------------------------------------
-- SkM_ComputeStatistics
-- --------------------------------------------------------------------------------------
-- Compute various statistics that will be used in the report frame.
-- --------------------------------------------------------------------------------------
function SkM_ComputeStatistics()
	local FName = "SkM_ComputeStatistics";

	SKM_Context.Statistics = { };

	SKM_Context.Statistics.Globals = { };
	SKM_Context.Statistics.Race = { };
	SKM_Context.Statistics.Class = { };
	SKM_Context.Statistics.Zone = { };
	SKM_Context.Statistics.Date = { };
	SKM_Context.Statistics.Enemy = { };
	SKM_Context.Statistics.Guild = { };

	SKM_Context.Statistics.BGZone = { };
	SKM_Context.Statistics.BGDate = { };
	SKM_Context.Statistics.BGDateZone = { };

	local iDeathForLevel = 0;
	local iKillForLevel = 0;
	local iTotalLevelDeath = 0;
	local iTotalLevelKill = 0;

	-- compute : global, by race, by class, by enemy
	-- statistics from EnemyHistory map
	for idx, val in SKM_Data[_RealmName][_PlayerName].EnemyHistory do

		SKM_Context.Statistics.Globals.EnemyPlayers = ifnil(SKM_Context.Statistics.Globals.EnemyPlayers, 0) + 1;

		local iDeath = ifnil(val[_SKM._enemyKillPlayer], 0);
		--local iKill = ifnil(val[_SKM._playerAssistKill], 0) + ifnil(val[_SKM._playerKill], 0) + ifnil(val[_SKM._playerFullKill], 0);
		local iKill = ifnil(val[_SKM._playerKill], 0) + ifnil(val[_SKM._playerFullKill], 0);
		if (SkM_GetOption("AssistKillStat")) then
			iKill = iKill + ifnil(val[_SKM._playerAssistKill], 0)
		end


		SKM_Context.Statistics.Globals.Death = ifnil(SKM_Context.Statistics.Globals.Death, 0) + iDeath;
		SKM_Context.Statistics.Globals.Kill = ifnil(SKM_Context.Statistics.Globals.Kill, 0) + iKill;

		-- for computing averages
		if (val[_SKM._level]) and (val[_SKM._level] ~= -1) then
			iDeathForLevel = iDeathForLevel + iDeath;
			iKillForLevel = iKillForLevel + iKill;
			iTotalLevelDeath = iTotalLevelDeath + ( val[_SKM._level] * iDeath );
			iTotalLevelKill = iTotalLevelKill + ( val[_SKM._level] * iKill );
		end

		local sRace = SkM_GetRaceText(val[_SKM._race]);
		if (sRace) then
			if (SKM_Context.Statistics.Race[sRace] == nil) then
				SKM_Context.Statistics.Race[sRace] = { };
			end
			SKM_Context.Statistics.Race[sRace].Death = ifnil(SKM_Context.Statistics.Race[sRace].Death, 0) + iDeath;
			SKM_Context.Statistics.Race[sRace].Kill = ifnil(SKM_Context.Statistics.Race[sRace].Kill, 0) + iKill;
		end

		local sClass = SkM_GetClassText(val[_SKM._class]);
		if (sClass) then
			if (SKM_Context.Statistics.Class[sClass] == nil) then
				SKM_Context.Statistics.Class[sClass] = { };
			end
			SKM_Context.Statistics.Class[sClass].Death = ifnil(SKM_Context.Statistics.Class[sClass].Death, 0) + iDeath;
			SKM_Context.Statistics.Class[sClass].Kill = ifnil(SKM_Context.Statistics.Class[sClass].Kill, 0) + iKill;
		end

		sEnemyName = val[_SKM._name];
		if (sEnemyName) and ( (iDeath > 0) or (iKill > 0) ) then
			SKM_Context.Statistics.Enemy[sEnemyName] = { };
			SKM_Context.Statistics.Enemy[sEnemyName].Death = iDeath;
			SKM_Context.Statistics.Enemy[sEnemyName].Kill = iKill;
		end

	end


	-- compute : global, by race, by class, by enemy
	-- statistics from EnemyHistory map
	for idx, val in SKM_Data[_RealmName][_PlayerName].GuildHistory do
	--for idx, val in SkM_GetPlayerData("GuildHistory") do

		SKM_Context.Statistics.Globals.EnemyGuilds = ifnil(SKM_Context.Statistics.Globals.EnemyGuilds, 0) + 1;

		local iDeath = ifnil(val[_SKM._enemyKillPlayer], 0);
		local iKill = ifnil(val[_SKM._playerAssistKill], 0) + ifnil(val[_SKM._playerKill], 0) + ifnil(val[_SKM._playerFullKill], 0);

		local sGuildName = val[_SKM._name];
		if (sGuildName) and ( (iDeath > 0) or (iKill > 0) ) then
			SKM_Context.Statistics.Guild[sGuildName] = { };
			SKM_Context.Statistics.Guild[sGuildName].Death = iDeath;
			SKM_Context.Statistics.Guild[sGuildName].Kill = iKill;
		end
	end


	-- compute averages
	if (iDeathForLevel > 0) then
		SkM_Trace(FName, 3, "iDeathForLevel = "..iDeathForLevel..", iTotalLevelDeath = "..iTotalLevelDeath);
		SKM_Context.Statistics.Globals.DeathAverageLevel = math.floor (iTotalLevelDeath / iDeathForLevel);
	end
	if (iKillForLevel > 0) then
		SkM_Trace(FName, 3, "iKillForLevel = "..iKillForLevel..", iTotalLevelKill = "..iTotalLevelKill);
		SKM_Context.Statistics.Globals.KillAverageLevel = math.floor (iTotalLevelKill / iKillForLevel);
	end

	SkM_Trace(FName, 3, "Average level of victims : "..snil(SKM_Context.Statistics.Globals.KillAverageLevel));
	SkM_Trace(FName, 3, "Average level of executioners : "..snil(SKM_Context.Statistics.Globals.DeathAverageLevel));


	-- compute : by zone, by date
	-- statistics from GlobalMapData map
	local i;
	local iNbNotes = getn(SKM_Data[_RealmName][_PlayerName].GlobalMapData);

	SKM_Context.Statistics.Globals.MapRecords = iNbNotes;

	SkM_Trace(FName, 3, "Global notes count = "..iNbNotes);
	for i=1, iNbNotes, 1 do
		local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[i];

		local StoredInfo = Note[_SKM._storedInfo];
		if (StoredInfo) then
	
			local iKill = 0;
			local iDeath = 0;
	
			-- if   (StoredInfo[_SKM._type] == _SKM._playerAssistKill)
			if   (StoredInfo[_SKM._type] == _SKM._playerAssistKill) and (SkM_GetOption("AssistKillStat"))
			  or (StoredInfo[_SKM._type] == _SKM._playerKill)
			  or (StoredInfo[_SKM._type] == _SKM._playerFullKill) then
				iKill = 1;
				SkM_Trace(FName, 3, "PvP Kill : global note = "..i);
	
			elseif (StoredInfo[_SKM._type] == _SKM._playerDeathPvP) then
				iDeath = 1;
				SkM_Trace(FName, 3, "PvP Death : global note = "..i);
			end
	
			if (iKill > 0) or (iDeath > 0) then
	
				--local sZoneText = SKM_Context.Zones[Note[_SKM._continent]][Note[_SKM._zone]];
				local sZoneText = SkM_GetZoneTextFromIndex(Note[_SKM._continent], Note[_SKM._zone]);
				if (sZoneText) then
					if (SKM_Context.Statistics.Zone[sZoneText] == nil) then
						SKM_Context.Statistics.Zone[sZoneText] = { };
					end
					SKM_Context.Statistics.Zone[sZoneText].Death = ifnil(SKM_Context.Statistics.Zone[sZoneText].Death, 0) + iDeath;
					SKM_Context.Statistics.Zone[sZoneText].Kill = ifnil(SKM_Context.Statistics.Zone[sZoneText].Kill, 0) + iKill;
				end
	
				local sDate = string.sub(StoredInfo[_SKM._date], 1, 10);
				if (sDate) then
					if (SKM_Context.Statistics.Date[sDate] == nil) then
						SKM_Context.Statistics.Date[sDate] = { };
					end
					SKM_Context.Statistics.Date[sDate].Death = ifnil(SKM_Context.Statistics.Date[sDate].Death, 0) + iDeath;
					SKM_Context.Statistics.Date[sDate].Kill = ifnil(SKM_Context.Statistics.Date[sDate].Kill, 0) + iKill;
				end
				
			end			
		end
	end

	-- compute : battlegrounds by zone, by date, by date and zone
	for idx1, val1 in SKM_Data[_RealmName][_PlayerName].BGStats do
		local sZone = idx1;
		if (SKM_Context.Statistics.BGZone[sZone] == nil) then
			SKM_Context.Statistics.BGZone[sZone] = { };
		end

		for idx2, val2 in val1 do
			local sDate = idx2;
			local iDeath = ifnil(val2[_SKM._enemyKillBG], 0);
			local iKill = ifnil(val2[_SKM._playerBGKill], 0);

			SKM_Context.Statistics.BGZone[sZone].Death = ifnil(SKM_Context.Statistics.BGZone[sZone].Death, 0) + iDeath;
			SKM_Context.Statistics.BGZone[sZone].Kill = ifnil(SKM_Context.Statistics.BGZone[sZone].Kill, 0) + iKill;

			if (SKM_Context.Statistics.BGDate[sDate] == nil) then
				SKM_Context.Statistics.BGDate[sDate] = { };
			end
			SKM_Context.Statistics.BGDate[sDate].Death = ifnil(SKM_Context.Statistics.BGDate[sDate].Death, 0) + iDeath;
			SKM_Context.Statistics.BGDate[sDate].Kill = ifnil(SKM_Context.Statistics.BGDate[sDate].Kill, 0) + iKill;

			local sDateZone = idx2.." - "..idx1;
			if (SKM_Context.Statistics.BGDateZone[sDateZone] == nil) then
				SKM_Context.Statistics.BGDateZone[sDateZone] = { };
				SKM_Context.Statistics.BGDateZone[sDateZone].Zone = idx1;
				SKM_Context.Statistics.BGDateZone[sDateZone].Date = idx2;
			end
			SKM_Context.Statistics.BGDateZone[sDateZone].Death = ifnil(SKM_Context.Statistics.BGDateZone[sDateZone].Death, 0) + iDeath;
			SKM_Context.Statistics.BGDateZone[sDateZone].Kill = ifnil(SKM_Context.Statistics.BGDateZone[sDateZone].Kill, 0) + iKill;
		end
	end



	-- provide sortable lists
	SKM_Context.Statistics.ClassList = {};
	for idx, val in SKM_Context.Statistics.Class do
		val.SortKey = idx;
		val.Key = idx;
		table.insert(SKM_Context.Statistics.ClassList, val);
	end
	table.sort(SKM_Context.Statistics.ClassList, SkM_SortStatList);

	SKM_Context.Statistics.RaceList = {};
	for idx, val in SKM_Context.Statistics.Race do
		val.SortKey = idx;
		val.Key = idx;
		table.insert(SKM_Context.Statistics.RaceList, val);
	end

	table.sort(SKM_Context.Statistics.RaceList, SkM_SortStatList);

	SKM_Context.Statistics.EnemyList = {};
	for idx, val in SKM_Context.Statistics.Enemy do
		--val.SortKey = string.upper(idx);
		val.SortKey = SkM_NormalizeString(idx);
		val.Key = idx;
		table.insert(SKM_Context.Statistics.EnemyList, val);
	end
	table.sort(SKM_Context.Statistics.EnemyList, SkM_SortStatList);

	SKM_Context.Statistics.GuildList = {};
	for idx, val in SKM_Context.Statistics.Guild do
		--val.SortKey = string.upper(idx);
		val.SortKey = SkM_NormalizeString(idx);
		val.Key = idx;
		table.insert(SKM_Context.Statistics.GuildList, val);
	end
	table.sort(SKM_Context.Statistics.GuildList, SkM_SortStatList);

	SKM_Context.Statistics.ZoneList = {};
	for idx, val in SKM_Context.Statistics.Zone do
		val.SortKey = idx;
		val.Key = idx;
		table.insert(SKM_Context.Statistics.ZoneList, val);
	end
	table.sort(SKM_Context.Statistics.ZoneList, SkM_SortStatList);

	SKM_Context.Statistics.DateList = {};
	for idx, val in SKM_Context.Statistics.Date do
		val.SortKey = SkM_GetSortableDate(idx);
		val.Key = idx;
		table.insert(SKM_Context.Statistics.DateList, val);
	end
	table.sort(SKM_Context.Statistics.DateList, SkM_SortStatList);

	SKM_Context.Statistics.BGDateList = {};
	for idx, val in SKM_Context.Statistics.BGDate do
		val.SortKey = SkM_GetSortableDate(idx);
		val.Key = idx;
		table.insert(SKM_Context.Statistics.BGDateList, val);
	end
	table.sort(SKM_Context.Statistics.BGDateList, SkM_SortStatList);

	SKM_Context.Statistics.BGZoneList = {};
	for idx, val in SKM_Context.Statistics.BGZone do
		val.SortKey = idx;
		val.Key = idx;
		table.insert(SKM_Context.Statistics.BGZoneList, val);
	end
	table.sort(SKM_Context.Statistics.BGZoneList, SkM_SortStatList);

	SKM_Context.Statistics.BGDateZoneList = {};
	for idx, val in SKM_Context.Statistics.BGDateZone do
		val.SortKey = SkM_GetSortableDate(val.Date)..val.Zone;
		val.Key = idx;
		table.insert(SKM_Context.Statistics.BGDateZoneList, val);
	end
	table.sort(SKM_Context.Statistics.BGDateZoneList, SkM_SortStatList);


end


-- --------------------------------------------------------------------------------------
-- SkM_SortStatList
-- --------------------------------------------------------------------------------------
-- Statistics sorting function
-- --------------------------------------------------------------------------------------
function SkM_SortStatList(e1, e2)
	if (e1.SortKey < e2.SortKey) then
		return true;
	elseif (e2.SortKey < e1.SortKey) then
		return false;
	end
	return false;
end


-- --------------------------------------------------------------------------------------
-- SkM_GetUnitFaction
-- --------------------------------------------------------------------------------------
-- Find player faction for a given unit
-- --------------------------------------------------------------------------------------
function SkM_GetUnitFaction(sUnit)
	if (sUnit == nil) then
		return nil;
	end
	local sRace = UnitRace(sUnit);
	if (sRace == nil) then
		return nil;
	end
	local i;
	for i=1, getn(SKM_PlayerFaction), 1 do
		if ( intable(sRace, SKM_PlayerFaction[i].RaceList) ) then
			return i, SKM_PlayerFaction[i].Faction;
		end
	end
	return nil;
end


-- --------------------------------------------------------------------------------------
-- SkM_UnitIsEnemyPlayer
-- --------------------------------------------------------------------------------------
-- Is unit an enemy player of the opposite faction ?
-- --------------------------------------------------------------------------------------
function SkM_UnitIsEnemyPlayer(sUnit)
	if (sUnit == nil) then
		return nil;
	end
	return (  (UnitIsPlayer(sUnit))
	      and (UnitIsEnemy(SKM_UNIT_PLAYER, sUnit))
	      and (SkM_UnitIsOppositeFaction(SKM_UNIT_PLAYER, sUnit))
	);
end


-- --------------------------------------------------------------------------------------
-- SkM_UnitIsDuelingPlayer
-- --------------------------------------------------------------------------------------
-- Is unit a player you are currently dueling ?
-- ie, if he is a player, tagged as "enemy" but of your faction.
-- --------------------------------------------------------------------------------------
function SkM_UnitIsDuelingPlayer(sUnit)
	if (sUnit == nil) then
		return nil;
	end
	return (  (UnitIsPlayer(sUnit))
	      and (UnitIsEnemy(SKM_UNIT_PLAYER, sUnit))
	      and (not SkM_UnitIsOppositeFaction(SKM_UNIT_PLAYER, sUnit))
	);
end


-- --------------------------------------------------------------------------------------
-- SkM_UnitIsOppositeFaction
-- --------------------------------------------------------------------------------------
-- Check if two units are on opposite faction or not, using their race.
-- Return true if it's the case, false if not, and nil if indeterminate
-- --------------------------------------------------------------------------------------
function SkM_UnitIsOppositeFaction(sUnit1, sUnit2)
	local FName = "SkM_UnitIsOppositeFaction";

	local Faction1 = SkM_GetUnitFaction(sUnit1);
	local Faction2 = SkM_GetUnitFaction(sUnit2);

	if (Faction1 == nil) then
		SkM_Trace(FName, 1, "Unknown faction for "..snil(sUnit1));
		return nil;
	end
	if (Faction2 == nil) then
		SkM_Trace(FName, 1, "Unknown faction for "..snil(sUnit2));
		return nil;
	end

	if (Faction1 == Faction2) then
		return false;
	else
		return true;
	end

end


-- --------------------------------------------------------------------------------------
-- SkM_DeleteEnemy
-- --------------------------------------------------------------------------------------
-- Delete an enemy player and all associated map records (kills or deaths).
-- --------------------------------------------------------------------------------------
function SkM_DeleteEnemy(sName)
	local FName = "SkM_DeleteEnemy";

	local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];

	if (Enemy == nil) then
		SkM_Trace(FName, 1, "Enemy not found : "..snil(sName));
		return;
	end

	SkM_Trace(FName, 1, "Removing Enemy : "..sName);

	SkM_UpdateEnemyHistory();

	-- remove all recorded events associated to this enemy : kills and deaths
	local i;
	local iNbNotes = table.getn(SKM_Data[_RealmName][_PlayerName].GlobalMapData);
	for i=iNbNotes, 1, -1 do
		local Note = SKM_Data[_RealmName][_PlayerName].GlobalMapData[i];

		local StoredInfo = Note[_SKM._storedInfo];

		if (StoredInfo) and (StoredInfo[_SKM._name] == sName) then

			-- remove from GlobalMapData and from MapData
			SkM_Trace(FName, 3, "Removing note : global index = "..i);

			SkM_DeleteNote(_RealmName, _PlayerName, i);
		end
	end

	-- finally, delete the enemy. Bye bye !
	SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName] = nil;
end


-- --------------------------------------------------------------------------------------
-- SkM_DeleteDuelEnemy
-- --------------------------------------------------------------------------------------
-- Delete all duel information associated to a given player
-- --------------------------------------------------------------------------------------
function SkM_DeleteDuelEnemy(sName)
	local FName = "SkM_DeleteDuelEnemy";

	SKM_Data[_RealmName][_PlayerName].DuelHistory[sName] = nil;
end


-- --------------------------------------------------------------------------------------
-- SkM_GetKnownEnemyType
-- --------------------------------------------------------------------------------------
-- Return _SKM._enemyPlayer if given name matches a known player, otherwise return nil
-- (ie, we do not know for now if it's a player or not, but we may get the information
-- later on)
-- --------------------------------------------------------------------------------------
function SkM_GetKnownEnemyType(sName)
	local EnemyType;
	local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[sName];
	if (Enemy) then
		EnemyType = _SKM._enemyPlayer;
	end
	return EnemyType;
end


-- --------------------------------------------------------------------------------------
-- SkM_UnitName
-- --------------------------------------------------------------------------------------
-- Call UnitName to get unit name.
-- Return nil if we get "Unknown Entity".
-- --------------------------------------------------------------------------------------
function SkM_UnitName(sUnit)
	local sName = UnitName(sUnit);

	-- if we got "unknown entity", try again, maybe it will work this time
	if (sName == SKM_UNKNOWN_ENTITY) then
		sName = UnitName(sUnit);
	end

	if (sName == "") or (sName == SKM_UNKNOWN_ENTITY) then
		sName = nil;
	end
	return sName;
end


-- --------------------------------------------------------------------------------------
-- SkM_IsTotem
-- --------------------------------------------------------------------------------------
-- Check if given name matches a totem (and *not* a player)
-- --------------------------------------------------------------------------------------
function SkM_IsTotem(sName)
	local FName = "SkM_IsTotem";

	if (sName) then
		for sType in string.gfind(sName, SKM_Context.Pattern.Totem) do
			if (sType) then
				SkM_Trace(FName, 2, "Name = "..snil(sName).." : this is a totem. Type = "..sType);
				return true;
			end
		end
	end

	SkM_Trace(FName, 3, "Name = "..snil(sName).." : not a totem");
	return false;

	--  if (string.find(sName, SKM_Context.Pattern.Totem)) then
	--    SkM_Trace(FName, 2, "Name = "..snil(sName).." : this is a totem");
	--    return true;
	--  else
	--    SkM_Trace(FName, 3, "Name = "..snil(sName).." : not a totem");
	--    return false;
	--  end

end


function SkM_NormalizeString(sName)
	local FName = "SkM_NormalizeString";

	if (sName == nil) then
		return nil;
	end

	local sString = string.upper(sName);
	i=1;
	while (string.sub(sString, i, i) == " ") and (i < string.len(sString)) do
		i = i + 1;
	end
	if (i > 1 ) then
		sString = string.sub(sString, i, string.len(sString));
	end

	sString = SkM_NormString(sString, 2); -- only need to normalize the first two chars to provide an accurate sort
	return sString;
end


function SkM_LogDuel(sWinner, sLoser)
	local FName = "SkM_LogDuel";

	local sName;
	local sDate = SkM_GetDate();
	local bWin;

	if (sWinner == _PlayerName) then
		sName = sLoser;
		bWin = true;
	else
		sName = sWinner;
		bWin = false;
	end

	if (SKM_Context.DuelEnemy == nil) or (SKM_Context.DuelEnemy[_SKM._name] ~= sName) then
		-- rare case of a finished duel but we did not see at any time our enemy.
		-- okay, force target him then.
		-- I agree that messing with player target is a bad idea in most cases, but at the end
		-- of a duel it should not matter much.

		SkM_Trace(FName, 2, "End of duel but no info about enemy "..snil(sName).." : force target");

		TargetByName(sName);
		SkM_StoreDuelEnemyInfo(SKM_UNIT_TARGET);

		if (SKM_Context.DuelEnemy == nil) or (SKM_Context.DuelEnemy[_SKM._name] ~= sName) then
			-- might potentially happen if enemy is too far away. Even more unlikely, but
			-- just in case...
			SkM_Trace(FName, 1, "Still no info about enemy !");
			SKM_Context.DuelEnemy = nil;
			return;
		end

	end

	if (not SKM_Data[_RealmName][_PlayerName].DuelHistory[sName]) then
		SKM_Data[_RealmName][_PlayerName].DuelHistory[sName] = { };
		SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._name] = sName;

		SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._race] = SKM_Context.DuelEnemy[_SKM._race];
		SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._class] = SKM_Context.DuelEnemy[_SKM._class];
		SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._win] = 0;
		SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._loss] = 0;
		SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._duel] = 0;
	else
		if (not SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._race]) then
			SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._race] = SKM_Context.DuelEnemy[_SKM._race];
		end
		if (not SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._class]) then
			SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._class] = SKM_Context.DuelEnemy[_SKM._class];
		end
	end

	SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._level] = SKM_Context.DuelEnemy[_SKM._level];
	SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._guild] = SKM_Context.DuelEnemy[_SKM._guild];
	SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._lastDuel] = sDate;

	SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._duel] = ifnil(SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._duel], 0) + 1;
	if (bWin) then
		SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._win] = ifnil(SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._win], 0) + 1;
		SkM_Trace(FName, 1, "Duel won vs "..sName..", Win = "..SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._win]..", Loss = "..SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._loss]..", Total = "..SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._duel]);
	else
		SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._loss] = ifnil(SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._loss], 0) + 1;
		SkM_Trace(FName, 1, "Duel lost vs "..sName..", Win = "..SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._win]..", Loss = "..SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._loss]..", Total = "..SKM_Data[_RealmName][_PlayerName].DuelHistory[sName][_SKM._duel]);
	end

	-- clear duel information
	SKM_Context.DuelEnemy = nil;
end


function SkM_ParseDuelResult(sMsg)
	local FName = "SkM_ParseDuelResult";

	local sWinner, sLoser;

	if (not SkM_GetOption("StoreDuels")) then
		return;
	end

	for sWinner, sLoser in string.gfind(sMsg, SKM_Context.Pattern.Duel_Won) do
		if (sWinner and sLoser) then
			if (sWinner == _PlayerName) or (sLoser == _PlayerName) then
				SkM_Trace(FName, 3, "Duel_Won : Winner = "..sWinner..", Loser = "..sLoser);

				SkM_LogDuel(sWinner, sLoser);
				return;
			end
		end
	end

end


function SkM_UpdateBGStats(sZoneName, sDate, iDeath, iKill)

	if (not SKM_Data[_RealmName][_PlayerName].BGStats[sZoneName]) then
		SKM_Data[_RealmName][_PlayerName].BGStats[sZoneName] = { };
	end

	if (not SKM_Data[_RealmName][_PlayerName].BGStats[sZoneName][sDate]) then
		SKM_Data[_RealmName][_PlayerName].BGStats[sZoneName][sDate] = { };
		SKM_Data[_RealmName][_PlayerName].BGStats[sZoneName][sDate][_SKM._enemyKillBG] = 0;
		SKM_Data[_RealmName][_PlayerName].BGStats[sZoneName][sDate][_SKM._playerBGKill] = 0;
	end

	if (iDeath) then
		SKM_Data[_RealmName][_PlayerName].BGStats[sZoneName][sDate][_SKM._enemyKillBG] = ifnil(SKM_Data[_RealmName][_PlayerName].BGStats[sZoneName][sDate][_SKM._enemyKillBG], 0) + iDeath;
	end

	if (iKill) then
		SKM_Data[_RealmName][_PlayerName].BGStats[sZoneName][sDate][_SKM._playerBGKill] = ifnil(SKM_Data[_RealmName][_PlayerName].BGStats[sZoneName][sDate][_SKM._playerBGKill], 0) + iKill;
	end
end


function SkM_BGStats_AddDeath()
	local sZone = SkM_GetZoneText();
	local sDate = SkM_GetDay();
	SkM_UpdateBGStats(sZone, sDate, 1, nil);
end


function SkM_BGStats_AddKill()
	local sZone = SkM_GetZoneText();
	local sDate = SkM_GetDay();
	SkM_UpdateBGStats(sZone, sDate, nil, 1);
end


function SkM_NormString2(sString)
	local sRes = sString;
	local idx, val, i;
	for idx, val in SKM_ToStandardCase do
		for i=1, table.getn(val), 1 do
			sRes = string.gsub(sRes, val[i], idx);
		end
	end
	return sRes;
end


function SkM_NormString(sInputString, iNormMinLen)
	local FName = "SkM_NormString";
	local sString = string.upper(sInputString);
	local iLen = string.len(sString);
	local sRes = "";
	local sNonStd = "";

	local iByte_A = string.byte("A");
	local iByte_Z = string.byte("Z");
	local iByte_a = string.byte("a");
	local iByte_z = string.byte("z");

	local i;
	for i=1,iLen,1 do
		--SkM_Trace(FName, 3, i.." Res="..sRes);

		local sChar = string.sub(sString, i, i);
		local iByte = string.byte(sString, i);
		if   ((iByte >= iByte_A) and (iByte <= iByte_Z))
		  or ((iByte >= iByte_a) and (iByte <= iByte_z))
		  or (intable(sChar, { " ", "-" } ))
		then
			if (string.len(sNonStd) > 0) then
				sRes = sRes..SkM_NormString2(sNonStd);
				sNonStd = "";
			end
			sRes = sRes..sChar;
			if (i<iLen) and (iNormMinLen) and (string.len(sRes) >= iNormMinLen) then
				sRes = sRes..string.sub(sString, i+1, iLen);
				return sRes;
			end
		else
			sNonStd = sNonStd..sChar;
		end
	end
	if (string.len(sNonStd) > 0) then
		sRes = sRes..SkM_NormString2(sNonStd);
		sNonStd = "";
	end

	return sRes;
end


function SkM_GetEnemyList(sName, bNormalize, bPrefix)
	local FName = "SkM_GetEnemyList";
	local TheList = { };

	local sEnemyName = string.upper(sName);
	if (bNormalize) then
	 	sEnemyName = SkM_NormString(sName);
	end
	local iNameLen = string.len(sEnemyName);

	SkM_Trace(FName, 3, "Name = "..sName);

	local ResList = {};
	for idx, val in SKM_Data[_RealmName][_PlayerName].EnemyHistory do
		local sCurName = string.upper(idx);
		local bMatch = false;
		if (bNormalize) then
			sCurName = SkM_NormString(sCurName, iNameLen);
		end
		SkM_Trace(FName, 3, "CurName = "..sCurName);
		if (not bPrefix) then
			if (sCurName == sEnemyName) then
				bMatch = true;
			end
		else
			if (string.sub(sCurName, 1, iNameLen) == sEnemyName) then
				bMatch = true;
			end
		end

		if (bMatch) then
			table.insert(TheList, idx);
		end
	end

	table.sort(TheList, function(e1,e2) return e1<e2; end);

	return TheList;
end


function SkM_GetEnemyInfo(sName, bMatchFullName, bMatchSpecialChar)
	local FName = "SkM_GetEnemyInfo";

	SkM_Trace(FName, 2, "Name = "..sName..", FullName = "..snil(bMatchFullName)..", MatchSpec = "..snil(bMatchSpecialChar));

	local bNormalize = true;
	local bPrefix = true;

	if (bMatchSpecialChar) then
		bNormalize = false;
	end
	if (bMatchFullName) then
		bPrefix = false;
	end

	SkM_ChatMessageCol("Looking for : "..sName);

	local EnemyList = SkM_GetEnemyList(sName, bNormalize, bPrefix);
	local iEnemyCount = table.getn(EnemyList);

	for i=1,iEnemyCount,1 do
		local Enemy = SKM_Data[_RealmName][_PlayerName].EnemyHistory[EnemyList[i]];
		if (Enemy) then
			local Lines = {};

			local iKill = ifnil(Enemy[_SKM._playerKill], 0);
			local iAssistKill = ifnil(Enemy[_SKM._playerAssistKill], 0);
			local iFullKill = ifnil(Enemy[_SKM._playerFullKill], 0);
			local iTotalKill = iKill + iAssistKill + iFullKill;
			local iDeath = ifnil(Enemy[_SKM._enemyKillPlayer], 0);
			local iMet = ifnil(Enemy[_SKM._meetCount], 0);
			local sDisplayDate = string.sub(Enemy[_SKM._lastView], 1, 10);

			local Guild;
			local bGuildWar = false;
			if (Enemy[_SKM._guild] ~= nil) and (Enemy[_SKM._guild] ~= "") then
				Guild = SKM_Data[_RealmName][_PlayerName].GuildHistory[Enemy[_SKM._guild]];
				bGuildWar = Guild[_SKM._atWar];
			end

			-- line 1 : <rank> <player> <guild> : level <level> <race> <class>

			local sLine = "";
			if (Enemy[_SKM._rank]) then
				sLine = sLine..SKM_Config.Col_Rank..Enemy[_SKM._rank].." ";
			end

			if (Enemy[_SKM._atWar]) then
				sLine = sLine..SKM_Config.Col_PlayerWar;
			else
				sLine = sLine..SKM_Config.Col_Label;
			end
			sLine = sLine..Enemy[_SKM._name]..SKM_Config.Col_Label;

			if (Guild) then
				sLine = sLine.." <";
				if (Guild[_SKM._atWar]) then
					sLine = sLine..SKM_Config.Col_PlayerWar;
				end
				sLine = sLine..Enemy[_SKM._guild]..SKM_Config.Col_Label..">";
			end

			if (Enemy[_SKM._level] ~= nil) and (Enemy[_SKM._race] ~= nil) and (Enemy[_SKM._class] ~= nil) then
				sLine = sLine.." : "..SKM_UI_STRINGS.List_Frame_Level..Enemy[_SKM._level].." "..SkM_GetRaceText(Enemy[_SKM._race]).." "..SkM_GetClassText(Enemy[_SKM._class]);
			end

			table.insert(Lines, sLine);

			if (iEnemyCount == 1) then

				-- line 2 : <met> <kill> <death> <last seen date and location>
				sLine = "";

				sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Met..SKM_Config.Col_Label..iMet;
				sLine = sLine.."  "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Kill..SKM_Config.Col_Label..iTotalKill;
				sLine = sLine.."  "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Death..SKM_Config.Col_Label .. iDeath;

				sLine = sLine.."  "..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Last_Seen;
				sLine = sLine..SKM_Config.Col_Label..sDisplayDate;

				if (Enemy[_SKM._continent] ~= nil) and (Enemy[_SKM._zone] ~= nil) then
					local sZoneText = SkM_GetZoneTextFromIndex(Enemy[_SKM._continent], Enemy[_SKM._zone]);
					sLine = sLine.." - "..sZoneText;

				elseif (Enemy[_SKM._zoneName] ~= nil) then
					sLine = sLine.." - "..Enemy[_SKM._zoneName];
				end

				table.insert(Lines, sLine);


				if (Enemy[_SKM._playerNote] ~= nil) and (Enemy[_SKM._playerNote] ~= "") then

					local sLine = "";

					sLine = sLine..SKM_Config.Col_LabelTitle..SKM_UI_STRINGS.List_Frame_Note;
					sLine = sLine..SKM_Config.Col_Label..Enemy[_SKM._playerNote];

					table.insert(Lines, sLine);
				end


			end

			for i=1,table.getn(Lines),1 do
				DEFAULT_CHAT_FRAME:AddMessage(Lines[i]);
			end

		end
	end

	--SkM_ChatMessageCol("Enemy matching : "..iEnemyCount);
	SkM_ChatMessageCol("Found : "..iEnemyCount);
end


function SkM_DataCleanUp()
	local FName = "SkM_DataCleanUp";
	if (not SKM_Data) then
		return;
	end
	if (not SKM_Settings) then
		return;
	end

	if (SkM_GetOption("DataCleanUp")) then
		local sDate = SkM_GetDate();
		local iDiffTime = SkM_DiffDate(sDate, SKM_Settings.LastDataCleanUp);
		if (SKM_Settings.LastDataCleanUp == nil) or (iDiffTime == nil) or (iDiffTime > SkM_GetOption("DataCleanUpInterval") * 3600 * 24) then

			SkM_DoCleanUp();

			SKM_Settings.LastDataCleanUp = sDate;
		end
	end

end


function SkM_DoCleanUp()
	local FName = "SkM_DoCleanUp";

	local sDate = SkM_GetDate();

	if (SkM_GetOption("CleanInactiveEnemies")) then

		for idx_realm, val_realm in SKM_Data do
			for idx_char, val_char in SKM_Data[idx_realm] do
				if (SKM_Data[idx_realm][idx_char].PlayerName == idx_char) then

					SkM_Trace(FName, 1, "Cleaning for "..idx_realm.." / "..idx_char);
					for idx_enemy, val_enemy in SKM_Data[idx_realm][idx_char].EnemyHistory do

						local iDiffTime = SkM_DiffDate(sDate, val_enemy[_SKM._lastView]);
						if (iDiffTime ~= nil) and (iDiffTime > SkM_GetOption("CleanInactiveEnemiesDelay") * 3600 * 24) then
							-- long time no see. Check if we have to remove him
							if   (ifnil(val_enemy[_SKM._playerAssistKill], 0) + ifnil(val_enemy[_SKM._playerKill], 0) + ifnil(val_enemy[_SKM._playerFullKill], 0) == 0)
							 and (ifnil(val_enemy[_SKM._enemyKillPlayer], 0) == 0)
							 and (ifnil(val_enemy[_SKM._enemyKillBG], 0) == 0)
							 and (ifnil(val_enemy[_SKM._playerBGKill], 0) == 0)
							 and not (val_enemy[_SKM._atWar])
							 and ( (val_enemy[_SKM._playerNote] == nil) or (val_enemy[_SKM._playerNote] == "") )
							then
								SkM_Trace(FName, 2, idx_realm.." / "..idx_char.." : remove "..idx_enemy);

								SKM_Data[idx_realm][idx_char].EnemyHistory[idx_enemy] = nil;
							end

						end
					end
				end
			end
		end
	end

	if (SkM_GetOption("CleanEmptyGuilds")) then
		for idx_realm, val_realm in SKM_Data do
			for idx_char, val_char in SKM_Data[idx_realm] do
				if (SKM_Data[idx_realm][idx_char].PlayerName == idx_char) then
					for idx_guild, val_guild in SKM_Data[idx_realm][idx_char].GuildHistory do

						if (SkM_CountGuildMembers(idx_guild, idx_realm, idx_char) == 0) then
							SkM_Trace(FName, 2, idx_realm.." / "..idx_char.." : remove "..idx_guild);
							SKM_Data[idx_realm][idx_char].GuildHistory[idx_guild] = nil;
						end
					end
				end
			end
		end
	end

end



function SkM_ZoneRematch(RealmName, PlayerName, ZoneShift, minDate, maxDate)
	local FName = "SkM_ZoneRematch";
	local idx_c, val_c, idx_z, val_z, idx_gn, Note;
	local cont_shift, zone_shift;

	local iCountShift = 0;
	local iCountNoShift = 0;

	if (ZoneShift == nil) then
		SkM_Trace(FName, 1, "ZoneShift is nil ! ");
		return;
	end

	-- reinitialize map data
	SKM_Data[RealmName][PlayerName].MapData = { };

	for idx_c, val_c in SKM_Context.Continents do
		SKM_Data[RealmName][PlayerName].MapData[idx_c] = { };

		for idx_z, val_z in SKM_Context.Zones[idx_c] do
			SKM_Data[RealmName][PlayerName].MapData[idx_c][idx_z] = { };
		end
	end


	-- parse global map data to rebuild local map data
	if (SKM_Data[RealmName][PlayerName].GlobalMapData) then
		for idx_gn, Note in SKM_Data[RealmName][PlayerName].GlobalMapData do
			local bDoShift = true;
			idx_c = Note[_SKM._continent];
			idx_z = Note[_SKM._zone];

			local StoredInfo = Note[_SKM._storedInfo];

			if (StoredInfo) and (StoredInfo[_SKM._date]) then
				if (maxDate) then
					local iDiffTime = SkM_DiffDate(maxDate, StoredInfo[_SKM._date]);
					if (iDiffTime < 0) then
						-- Note generated after max date, skip
						bDoShift = false;
					end
				end
				if (minDate) then
					local iDiffTime = SkM_DiffDate(minDate, StoredInfo[_SKM._date]);
					if (iDiffTime > 0) then
						-- Note generated before min date, skip
						bDoShift = false;
					end
				end
			end

			if (bDoShift) then
				zone_shift = ZoneShift[idx_c][idx_z];

				-- insert new map note
				table.insert(SKM_Data[RealmName][PlayerName].MapData[idx_c][zone_shift], idx_gn);

				-- update global note zone index
				SKM_Data[RealmName][PlayerName].GlobalMapData[idx_gn][_SKM._zone] = zone_shift;

				iCountShift = iCountShift + 1;
			else
				-- insert unchanged map note
				table.insert(SKM_Data[RealmName][PlayerName].MapData[idx_c][idx_z], idx_gn);

				iCountNoShift = iCountNoShift + 1;
			end
		end

	end


	-- parse enemy information and shift zone where last seen
	for idx_enemy, val_enemy in SKM_Data[RealmName][PlayerName].EnemyHistory do
		idx_c = val_enemy[_SKM._continent];
		idx_z = val_enemy[_SKM._zone];
		local bDoShift = true;

		if (idx_c == nil) or (idx_z == nil) then
			bDoShift = false;

			if (val_enemy[_SKM._lastView]) then
				if (maxDate) then
					local iDiffTime = SkM_DiffDate(maxDate, val_enemy[_SKM._lastView]);
					if (iDiffTime < 0) then
						-- generated after max date, skip
						bDoShift = false;
					end
				end
				if (minDate) then
					local iDiffTime = SkM_DiffDate(minDate, val_enemy[_SKM._lastView]);
					if (iDiffTime > 0) then
						-- generated before min date, skip
						bDoShift = false;
					end
				end
			end
		end

		if (bDoShift) then
			zone_shift = ZoneShift[idx_c][idx_z];

			SKM_Data[RealmName][PlayerName].EnemyHistory[idx_enemy][_SKM._zone] = zone_shift;
		end
	end

	SkM_Trace(FName, 1, "Realm = "..RealmName.." / Player = "..PlayerName.." : Zone Rematch completed, shift count = "..iCountShift..", 'no shift' count = "..iCountNoShift);
end


function SkM_AccountZoneRematch(ZoneShift, minDate, maxDate)
	local FName = "SkM_AccountZoneRematch";

	if (ZoneShift == nil) then
		SkM_Trace(FName, 1, "ZoneShift is nil ! ");
		return;
	end

	local idx_realm, val_realm, idx_char, val_char;

	for idx_realm, val_realm in SKM_Data do
		for idx_char, val_char in SKM_Data[idx_realm] do
			if (SKM_Data[idx_realm][idx_char].PlayerName == idx_char) then
				SkM_ZoneRematch(idx_realm, idx_char, ZoneShift, minDate, maxDate)
			end
		end
	end
end


function SkM_DoMapShift(Source, Dest, ZoneShift, minDate, maxDate)
	local FName = "SkM_DoMapShift";

	local sDate = SkM_GetDate();

	if (ZoneShift == nil) then
		SkM_Trace(FName, 1, "ZoneShift is nil ! ");
		return;
	end

	SkM_Trace(FName, 1, "Do shift ("..snil(Source).." -> "..snil(Dest)..")");
	SkM_Trace(FName, 1, "Shift interval = ["..snil(minDate).." -> "..snil(maxDate).."]");

	SkM_AccountZoneRematch(ZoneShift, minDate, maxDate);

	if (SKM_Settings.ZoneShifts == nil) then
		SKM_Settings.ZoneShifts = {};
	end
	local ZoneShiftRecord = {
		Date = sDate;
		Source = Source;
		Dest = Dest;
		minDate = minDate;
		maxDate = maxDate;
	};
	table.insert(SKM_Settings.ZoneShifts, ZoneShiftRecord);

end


function SkM_GetShiftTable(source, dest)
	if (SKM_ShiftTables == nil) then
		return nil;
	end
	if (SKM_ShiftTables[source] == nil) then
		return nil;
	end
	return SKM_ShiftTables[source][dest];
end


-- --------------------------------------------------------------------------------------
-- SkM_MapShiftMigration
-- --------------------------------------------------------------------------------------
-- Proceed to all map shift migrations, if needed.
-- If no new zone shift is defined since last migration, nothing will be done.
-- --------------------------------------------------------------------------------------
function SkM_MapShiftMigration()
	local FName = "SkM_MapShiftMigration";

	local bShift = false;
	local curTime = GetTime();

	-- check if there are map migrations that need be done

	-- NOTE : the following case is not handled and WILL NOT BE !!
	-- if user changes his locale interface language while there has been a new locale
	-- shift defined on his previous language, before installing the new version of SKMap.
	-- too bad !


	SkM_Trace(FName, 1, "Automatic map migration starting...");

	local bNewLocale = false;
	-- if we don't have information of last local language, we assume there were no
	-- language change... otherwise, there's nothing we can do...
	if (SKM_Settings.LastLocale ~= nil) then
		if (SKM_CurrentLocale ~= SKM_Settings.LastLocale) then
			bNewLocale = true;
		end
	else
		SKM_Settings.LastLocale = SKM_CurrentLocale;
	end


	-- are there new locale shift defines for previous language ?
	local iNbLocalShift = 0;
	local iNextLocalShift = 0;
	local bNewLocalShift = false;
	if (SKM_Locale[SKM_Settings.LastLocale]) and (SKM_Locale[SKM_Settings.LastLocale].LocalShift) then
		iNbLocalShift = table.getn(SKM_Locale[SKM_Settings.LastLocale].LocalShift);
	end
	if (iNbLocalShift > ifnil(SKM_Settings.LastLocalShift, 0)) then
		bNewLocalShift = true;
		iNextLocalShift = ifnil(SKM_Settings.LastLocalShift, 0) + 1;
	end


	if (bNewLocalShift) then

		if (SKM_Settings.ZoneShiftDest) and (SKM_Settings.ZoneShiftSource) then
			-- apply reverse shift first for all data ulterior to next local shift

			SkM_DoMapShift(
				SKM_Settings.ZoneShiftDest, SKM_Settings.ZoneShiftSource,
				SkM_GetShiftTable(SKM_Settings.ZoneShiftDest, SKM_Settings.ZoneShiftSource),
				SKM_Locale[SKM_Settings.LastLocale].LocalShift[iNextShift].DateShift, nil);

			bShift = true;
		end

		SKM_Settings.LastLocalShift = 0;
		SKM_Settings.LastCurrentShift = 0;

		-- now perform all new local shifts
		-- each local shift is performed on all data up to the local shift date
		local i;
		for i=iNextLocalShift,iNbLocalShift, 1 do

			SkM_Trace(FName, 3, "Performing local shift "..i);
			local Source = SKM_Locale[SKM_Settings.LastLocale].LocalShift[i].Source;
			local Dest = SKM_Locale[SKM_Settings.LastLocale].LocalShift[i].Dest;
			local DateShift = SKM_Locale[SKM_Settings.LastLocale].LocalShift[i].DateShift;

			SkM_DoMapShift(Source, Dest, SkM_GetShiftTable(Source, Dest), nil, DateShift)

			bShift = true;

			SKM_Settings.LastLocalShift = i;
		end

		-- now apply current shift if need be
		-- moved out of if condition, see below
	end

	-- now apply current shift if need be
	if (ifnil(SKM_Settings.LastCurrentShift, 0) == 0) then
		if (SKM_Locale[SKM_Settings.LastLocale].CurrentShift) then

			local Source = SKM_Locale[SKM_Settings.LastLocale].CurrentShift.Source;
			local Dest = SKM_Locale[SKM_Settings.LastLocale].CurrentShift.Dest;

			if (Source == SKM_Settings.ZoneShiftSource) and (Dest == SKM_Settings.ZoneShiftDest) then
				SkM_Trace(FName, 3, "current shift already performed");
			else

				SkM_Trace(FName, 3, "Perform final shift (current)");

				local DateMin = nil;
				local DateMax = nil;

				-- fix for 1.4 bug for DE version
				if (SKM_CurrentLocale == "DE") then
					DateMax = SKM_Context.DateIndexBug;
				end

				SkM_DoMapShift(Source, Dest, SkM_GetShiftTable(Source, Dest), DateMin, DateMax);

				bShift = true;
			end

			SKM_Settings.LastCurrentShift = 1;

			SKM_Settings.ZoneShiftSource = Source;
			SKM_Settings.ZoneShiftDest = Dest;
		else
			-- no current shift
			SKM_Settings.ZoneShiftSource = nil;
			SKM_Settings.ZoneShiftDest = nil;
		end
	end


	if (bNewLocale) then

		if (SKM_Locale[SKM_CurrentLocale]) and (SKM_Locale[SKM_CurrentLocale].CurrentShift) then
			SKM_Settings.ZoneShiftSource = SKM_Locale[SKM_CurrentLocale].CurrentShift.Source;
			SKM_Settings.ZoneShiftDest = SKM_Locale[SKM_CurrentLocale].CurrentShift.Dest;
		else
			-- no current shift

			SKM_Settings.ZoneShiftSource = nil;
			SKM_Settings.ZoneShiftDest = nil;
		end

		-- now we can safely store the new language as the current one.
		SKM_Settings.LastLocale = SKM_CurrentLocale;

		-- also store LastLocalShift as the latest local shift, if any
		if (SKM_Locale[SKM_Settings.LastLocale]) and (SKM_Locale[SKM_Settings.LastLocale].LocalShift) then
			iNbLocalShift = table.getn(SKM_Locale[SKM_Settings.LastLocale].LocalShift);
			SKM_Settings.LastLocalShift = iNbLocalShift;
		else
			SKM_Settings.LastLocalShift = nil;
		end

	end


	SkM_Trace(FName, 3, "Zone Shift performed ? "..snil(bShift));

	if (bShift) then
		local endTime = GetTime();
		local elapsedTime = math.floor(100 * (endTime - curTime)) / 100;
		SkM_ChatMessageCol("Zone order shift(s) performed, elapsed time : "..elapsedTime.." s");
	end

end


function SkM_ReverseZoneShift(ZoneShift)
	local NewShift = { };

	local i,j;
	for i=1,table.getn(ZoneShift),1 do
		local Line = { };
		for j=1,table.getn(ZoneShift[i]),1 do
			Line[ZoneShift[i][j]] = j;
		end
		NewShift[i] = Line;
	end
	return NewShift;
end


function SkM_CharDataMigration(Ver, RealmName, PlayerName)
	local FName = "SkM_CharDataMigration";

	-- Migration of EnemyHistory
	if (SKM_Data[RealmName][PlayerName].EnemyHistory) then
		local idx_enemy, val_enemy;
		for idx_enemy, val_enemy in SKM_Data[RealmName][PlayerName].EnemyHistory do
			local EnemyMigr = {};
			local idx, val;
			for idx, val in SKM_IndexMigr[Ver].EnemyHistory do
				if (val_enemy[val.Old]) then
					EnemyMigr[val.New] = val_enemy[val.Old];
				end
			end

			SKM_Data[RealmName][PlayerName].EnemyHistory[idx_enemy] = nil;
			SKM_Data[RealmName][PlayerName].EnemyHistory[idx_enemy] = EnemyMigr;

			-- now migration of race and class to indexes
			local sRace = SKM_Data[RealmName][PlayerName].EnemyHistory[idx_enemy][_SKM._race];
			local sClass = SKM_Data[RealmName][PlayerName].EnemyHistory[idx_enemy][_SKM._class];
			local id_race = SKM_Context.Race.StringToIndex[sRace];
			local id_class = SKM_Context.Class.StringToIndex[sClass];
			SKM_Data[RealmName][PlayerName].EnemyHistory[idx_enemy][_SKM._race] = id_race;
			SKM_Data[RealmName][PlayerName].EnemyHistory[idx_enemy][_SKM._class] = id_class;
		end
	end

	-- Migration of DuelHistory
	if (SKM_Data[RealmName][PlayerName].DuelHistory) then
		local idx_enemy, val_enemy;
		for idx_enemy, val_enemy in SKM_Data[RealmName][PlayerName].DuelHistory do
			local DuelMigr = {};
			local idx, val;
			for idx, val in SKM_IndexMigr[Ver].DuelHistory do
				if (val_enemy[val.Old]) then
					DuelMigr[val.New] = val_enemy[val.Old];
				end
			end

			SKM_Data[RealmName][PlayerName].DuelHistory[idx_enemy] = nil;
			SKM_Data[RealmName][PlayerName].DuelHistory[idx_enemy] = DuelMigr;

			-- now migration of race and class to indexes
			local sRace = SKM_Data[RealmName][PlayerName].DuelHistory[idx_enemy][_SKM._race];
			local sClass = SKM_Data[RealmName][PlayerName].DuelHistory[idx_enemy][_SKM._class];
			local id_race = SKM_Context.Race.StringToIndex[sRace];
			local id_class = SKM_Context.Class.StringToIndex[sClass];
			SKM_Data[RealmName][PlayerName].DuelHistory[idx_enemy][_SKM._race] = id_race;
			SKM_Data[RealmName][PlayerName].DuelHistory[idx_enemy][_SKM._class] = id_class;
		end
	end

	-- Migration of GuildHistory
	if (SKM_Data[RealmName][PlayerName].GuildHistory) then
		local idx_guild, val_guild;
		for idx_guild, val_guild in SKM_Data[RealmName][PlayerName].GuildHistory do
			local GuildMigr = {};
			local idx, val;
			for idx, val in SKM_IndexMigr[Ver].GuildHistory do
				if (val_guild[val.Old]) then
					GuildMigr[val.New] = val_guild[val.Old];
				end
			end

			SKM_Data[RealmName][PlayerName].GuildHistory[idx_guild] = nil;
			SKM_Data[RealmName][PlayerName].GuildHistory[idx_guild] = GuildMigr;
		end
	end

	-- Migration of BGStats
	if (SKM_Data[RealmName][PlayerName].BGStats) then
		local idx_zone, val_zone;
		for idx_zone, val_zone in SKM_Data[RealmName][PlayerName].BGStats do
			local idx_date, val_date;
			for idx_date, val_date in SKM_Data[RealmName][PlayerName].BGStats[idx_zone] do
				local StatMigr = {};
				local idx, val;
				for idx, val in SKM_IndexMigr[Ver].BGStatDate do
					if (val_date[val.Old]) then
						StatMigr[val.New] = val_date[val.Old];
					end
				end

				SKM_Data[RealmName][PlayerName].BGStats[idx_zone][idx_date] = nil;
				SKM_Data[RealmName][PlayerName].BGStats[idx_zone][idx_date] = StatMigr;
			end
		end
	end

	-- Migration of GlobalMapData
	if (SKM_Data[RealmName][PlayerName].GlobalMapData) then
		local iNbNotes = table.getn(SKM_Data[RealmName][PlayerName].GlobalMapData);
		local i;
		for i=1, iNbNotes, 1 do
			local Note = SKM_Data[RealmName][PlayerName].GlobalMapData[i];
			local NoteMigr = {};
			local idx, val;
			for idx, val in SKM_IndexMigr[Ver].GlobalMapData do
				if (Note[val.Old]) then
					NoteMigr[val.New] = Note[val.Old];
				end
			end

			SKM_Data[RealmName][PlayerName].GlobalMapData[i] = nil;

			SKM_Data[RealmName][PlayerName].GlobalMapData[i] = NoteMigr;

			local StoredInfo = NoteMigr[_SKM._storedInfo];
			if (StoredInfo) then
				local InfoMigr = {};
				for idx, val in SKM_IndexMigr[Ver].StoredInfo do
					if (StoredInfo[val.Old]) then
						InfoMigr[val.New] = StoredInfo[val.Old];
					end
				end
				InfoMigr[_SKM._type] = SKM_IndexMigr[Ver].RecordType[InfoMigr[_SKM._type]];
				InfoMigr[_SKM._enemyType] = SKM_IndexMigr[Ver].EnemyType[InfoMigr[_SKM._enemyType]];

				-- fix level if not "level up" event
				if not (InfoMigr[_SKM._type] == _SKM._levelUp
			 	        or InfoMigr[_SKM._type] == _SKM._creatureKill_Target
			 	        or InfoMigr[_SKM._type] == _SKM._creatureKill_Xp
			 	) then
					InfoMigr[_SKM._level] = nil;
				end

				SKM_Data[RealmName][PlayerName].GlobalMapData[i][_SKM._storedInfo] = InfoMigr;
			end
		end
	end

	-- fix battleground stats bug
	if (SKM_Data[RealmName][PlayerName].BGStats) then
		local idx_bg, val_bg
		for idx_bg, val_bg in SKM_Data[RealmName][PlayerName].BGStats do
			if not (intable(idx_bg, SKM_BATTLEGROUNDS)) then
				SKM_Data[RealmName][PlayerName].BGStats[idx_bg] = nil;
			end
		end
	end

	-- fix wrong "level up" records
	if (SKM_Data[RealmName][PlayerName].GlobalMapData) then
		local i = 1;
		local iMaxLevel = 0;
		local iNbNotes = table.getn(SKM_Data[RealmName][PlayerName].GlobalMapData);
		while (i < iNbNotes) do
			local Note = SKM_Data[RealmName][PlayerName].GlobalMapData[i];

			local StoredInfo = Note[_SKM._storedInfo];
			if (StoredInfo) and (StoredInfo[_SKM._type] == _SKM._levelUp) then

				if (StoredInfo[_SKM._level] > 1) and (StoredInfo[_SKM._level] > iMaxLevel) then
					iMaxLevel = StoredInfo[_SKM._level];
					i = i + 1;
				else
					-- remove from GlobalMapData and from MapData
					SkM_Trace(FName, 3, "Previous max level = "..iMaxLevel..", Note level up = "..StoredInfo[_SKM._level]);
					SkM_Trace(FName, 3, "Removing note for "..PlayerName.." : global index = "..i);

					SkM_DeleteNote(RealmName, PlayerName, i);
					iNbNotes = iNbNotes - 1;
				end

			else
				i = i + 1;
			end
		end
	end



end


function SkM_AccountDataMigration(Ver)
	local FName = "SkM_AccountDataMigration";

	local idx_realm, val_realm, idx_char, val_char;
	for idx_realm, val_realm in SKM_Data do
		for idx_char, val_char in SKM_Data[idx_realm] do
			if (SKM_Data[idx_realm][idx_char].PlayerName == idx_char) then
				SkM_CharDataMigration(Ver, idx_realm, idx_char);
			end
		end
	end
end


function SkM_DataModelMigration()
	local FName = "SkM_DataModelMigration";

	local curTime = GetTime();
	local bMigr = false;

	if (SKM_Settings.SavedDataVersion == nil) then
		SKM_Settings.SavedDataVersion = 1;
	end

	if (SKM_Settings.SavedDataVersion < 2) then
		SkM_AccountDataMigration(2);
		SKM_Settings.SavedDataVersion = 2;
		bMigr = true;
	end

	if (bMigr) then
		local endTime = GetTime();
		local elapsedTime = math.floor(100 * (endTime - curTime)) / 100;
		SkM_ChatMessageCol("Data migrated to v."..SKM_Settings.SavedDataVersion..", elapsed time : "..elapsedTime.." s");
	end

end


-- function provided to fix MapData indexes from GlobalMapData (which is supposed to be
-- correct !)
function SkM_FixMapIndexes(RealmName, PlayerName)
	local FName = "SkM_FixMapIndexes";
	local idx_c, val_c, idx_z, val_z, idx_gn;

	SkM_Trace(FName, 3, "Realm = "..snil(RealmName).. " / Player = "..snil(PlayerName));

	-- reinitialize map data
	SKM_Data[RealmName][PlayerName].MapData = { };

	for idx_c, val_c in SKM_Context.Continents do
		SKM_Data[RealmName][PlayerName].MapData[idx_c] = { };

		for idx_z, val_z in SKM_Context.Zones[idx_c] do
			SKM_Data[RealmName][PlayerName].MapData[idx_c][idx_z] = { };
		end
	end

	-- parse global map data to rebuild local map data
	if (SKM_Data[RealmName][PlayerName].GlobalMapData) then
		for idx_gn, Note in SKM_Data[RealmName][PlayerName].GlobalMapData do
			idx_c = Note[_SKM._continent];
			idx_z = Note[_SKM._zone];

			-- insert new map note
			table.insert(SKM_Data[RealmName][PlayerName].MapData[idx_c][idx_z], idx_gn);
		end
	end

end

-- function provided to fix MapData indexes from GlobalMapData (which is supposed to be
-- correct !)
function SkM_AccountFixMapIndexes()
	local idx_realm, val_realm, idx_char, val_char;

	for idx_realm, val_realm in SKM_Data do
		for idx_char, val_char in SKM_Data[idx_realm] do
			if (SKM_Data[idx_realm][idx_char].PlayerName == idx_char) then
				SkM_FixMapIndexes(idx_realm, idx_char);
			end
		end
	end
end


-- get date of first record affected by the index bug since 1.4
-- needed to fix german data !
function SkM_GetDateIndexBug(bIgnoreLocale)
	local FName = "SkM_GetDateIndexBug";

	SKM_Context.DateIndexBug = nil;

	local iBug = 0;
	local iOK = 0;

	if not (bIgnoreLocale) then
		if (SKM_CurrentLocale ~= "DE") then
			SkM_Trace(FName, 1, "Non DE locale");
			return;
		end
	end

	local idx_realm, val_realm, idx_char, val_char;
	local idx_c, val_c, idx_z, val_z, idx_n, val_n, Note;

	local r_c, r_z, r_n, r_gn, r_realm, r_char;

	for idx_realm, val_realm in SKM_Data do
		for idx_char, val_char in SKM_Data[idx_realm] do
			if (SKM_Data[idx_realm][idx_char].PlayerName == idx_char) then
				for idx_c, val_c in SKM_Data[idx_realm][idx_char].MapData do
					for idx_z, val_z in SKM_Data[idx_realm][idx_char].MapData[idx_c] do
						for idx_n, val_n in SKM_Data[idx_realm][idx_char].MapData[idx_c][idx_z] do
							Note = SKM_Data[idx_realm][idx_char].GlobalMapData[val_n];
							if not ((Note[_SKM._continent] == idx_c) and (Note[_SKM._zone] == idx_z)) then
								-- bad index !
								iBug = iBug + 1;
								if (Note[_SKM._storedInfo]) and (Note[_SKM._storedInfo][_SKM._date]) then

									if (SKM_Context.DateIndexBug == nil) then
										SKM_Context.DateIndexBug = Note[_SKM._storedInfo][_SKM._date];
										r_c = idx_c; r_z = idx_z; r_n = idx_n; r_gn = val_n; r_realm = idx_realm; r_char = idx_char;
									else
										local iDiffTime = SkM_DiffDate(SKM_Context.DateIndexBug, Note[_SKM._storedInfo][_SKM._date]);
										if (iDiffTime ~= nil) and (iDiffTime > 0) then
											SKM_Context.DateIndexBug = Note[_SKM._storedInfo][_SKM._date];
											r_c = idx_c; r_z = idx_z; r_n = idx_n; r_gn = val_n; r_realm = idx_realm; r_char = idx_char;
										end
									end
								end
							else
								iOK = iOK + 1;
							end
						end
					end
				end

			end
		end
	end

	SkM_Trace(FName, 1, "OK = "..iOK.." / Bugged = "..iBug);
	SkM_Trace(FName, 1, "DateIndexBug = ".. snil(SKM_Context.DateIndexBug));
	SkM_Trace(FName, 1, "realm = "..snil(r_realm).." / char = "..snil(r_char));
	SkM_Trace(FName, 1, "cont. = "..snil(r_c).." / zone = "..snil(r_z).." / note = "..snil(r_n).." / gn = "..snil(r_gn));
end


function SkM_DataFixMapIndexes()
	if (SKM_Settings.FixMapIndexes == nil) then
		SkM_GetDateIndexBug();

		--if (SKM_CurrentLocale ~= "EN") then
			SkM_AccountFixMapIndexes();
		--end
		local sDate = SkM_GetDate();
		SKM_Settings.FixMapIndexes = sDate;
	end
end


-- keep track of history of versions installed.
function SkM_RecordVersionHistory()
	local sLastVer;
	if (SKM_Settings.VersionHistory == nil) then
		SKM_Settings.VersionHistory = {};
	else
		local iCount = table.getn(SKM_Settings.VersionHistory);
		if (iCount > 0) then
			sLastVer = SKM_Settings.VersionHistory[iCount].Version;
		end
	end
	if (sLastVer ~= SKM_VERSION) then
		local sDate = SkM_GetDate();
		local VersionRecord = {
			Date = sDate;
			Version = SKM_VERSION;
		};
		table.insert(SKM_Settings.VersionHistory, VersionRecord);
	end
end



-- nchnch - new
-- --------------------------------------------------------------------------------------



-- --------------------------------------------------------------------------------------
-- SkM_GetGuildChannelName
-- --------------------------------------------------------------------------------------
-- Build a unique channel name from the realm name and the player guild name
-- --------------------------------------------------------------------------------------
function SkM_GetGuildChannel()
	local FName = "SkM_GetGuildChannel";

	local sName;

	--if (not SKM_Context.RealmName) then
	--	SkM_Trace(FName, 1, "Realm not known !");
	--	return nil;
	--end

	local sGuildName = GetGuildInfo(SKM_UNIT_PLAYER);
	if (not sGuildName) then
		SkM_Trace(FName, 2, "Not in a guild");
		return nil;
	end

	sName = SKM_GuildChannelPrefix.." - "..sGuildName;

	SkM_Trace(FName, 3, "Channel name : "..snil(sName));
	return sName;
end


-- --------------------------------------------------------------------------------------
-- SkM_IsNameInGuild
-- --------------------------------------------------------------------------------------

-- Check if given player name is in guild/
-- --------------------------------------------------------------------------------------
function SkM_IsNameInGuild(sName)
	return (	(sName == _PlayerName)
	         or (intable(sName, SKM_Context.GuildList))
	);
end


function SkM_JoinGuildChannel()
	local FName = "SkM_JoinGuildChannel";
	local sChannel = SkM_GetGuildChannel();

	if (not sChannel) then
		SkM_Trace(FName, 1, "Unable to get SKMap guild channel name");
		return false;
	end

	JoinChannelByName(sChannel, nil, nil);

	SKM_Context.GuildChannel = sChannel;
	return true;
end


function SkM_LeaveGuildChannel()
	local FName = "SkM_LeaveGuildChannel";

	if (not SKM_Context.GuildChannel) then
		SkM_Trace(FName, 1, "SKMap guild channel name not defined");
		return;
	end

	LeaveChannelByName(SKM_Context.GuildChannel);
	SKM_Context.GuildChannel = nil;
end




function SkM_GetChannelIndex(sName)
	local FName = "SkM_GetChannelIndex";

	if (not sName) then
		SkM_Trace(FName, 1, "Channel name not specified");
		return nil;
	end

	SkM_Trace(FName, 3, "Looking for index for channel : "..snil(sName));

	local MyChannelList = GetChannelList();

	local idx, val;
	for idx, val in MyChannelList do
		if (val == sName) then
			SkM_Trace(FName, 3, "Channel number = "..idx);
			return idx;
		end
	end
	SkM_Trace(FName, 2, "Channel not found");
	return nil;
end


function SkM_SendGuildChannelMessage(sMsg)
	local FName = "SkM_SendGuildChannelMessage";
	local iChannelIndex = SkM_GetChannelIndex(SKM_Context.GuildChannel);

	if (iChannelIndex) then
		SendChatMessage(sMsg, "CHANNEL", nil, iChannelIndex);
	end
end


function SkM_GuildChannelMessage(iCode, ...)
	local FName = "SkM_GuildChannelMessage";
	local sMsg;
	local sParam = "";

	local i;
	for i=1, arg.n do
		local sField = SkM_FormatMessageField(arg[i]);
		sParam = sParam..sField.." ";
	end

	sMsg = string.format("<SKM=%d>%s</SKM>", iCode, sParam);

	SkM_Trace(FName, 3, "Formated message = "..snil(sMsg));

	SkM_SendGuildChannelMessage(sMsg);
end


function SkM_FormatMessageField(sField)
	local sOutput = sField;

	sOutput = string.gsub(sOutput, "\\", "\\\\");
	sOutput = string.gsub(sOutput, "\"", "\\\"");

	return sOutput;
end


function SkM_GetMessageFields(sMsg)
	local FName = "SkM_GetMessageFields";

	local i=1;
	local iLen = string.len(sMsg);
	local iStartField;
	local bSpecial = false;
	local bInField = false;
	local sField = "";
	local Fields = { };

	while (i <= iLen) do
		local sChar = string.sub(sMsg, i, i);

		if (not bInField) then
			if (sChar == "\"") then
				bInField = true;
			elseif (sChar == " ") then
				-- skip
			else
				-- error
				SkM_Trace(FName, 1, "Unexpected character : '"..sChar.."' at position "..i);
				return nil;
			end
		else

			if (sChar == "\\") then
				if ( bSpecial) then
					sField = sField..sChar;
					bSpecial = false;
				else
					bSpecial = true;
				end
			else
				if (sChar == "\"") then
					if (bSpecial) then
						sField = sField..sChar;
						bSpecial = false;
					else
						table.insert(Fields, sField);
						sField = "";
						bInField = false;
					end
				else
					sField = sField..sChar;
				end

			end
		end
		i = i + 1;
	end
	return Fields;
end


function SkM_ProcessChannelMessage(iCode, sValue)
	local FName = "SkM_ProcessChannelMessage";

	local Fields = SkM_GetMessageFields(sValue);

	if (iCode == 1) then
		-- message = update player information
		if (table.getn(Fields) == 4) then
			local sName = Fields[1];
			local sRace = Fields[2];

			local sClass = Fields[3];
			local sLevel = Fields[4];
			SkM_Trace(FName, 3, "Player update: Name="..sName..", Race="..sRace..", Class="..sClass..", Lvl="..sLevel);


		end
	else

	end
end


function SkM_HandleChannelMessage(sMsg, sChannel, sSender)
	local FName = "SkM_HandleChannelMessage";

	if (sChannel == SKM_Context.GuildChannel) then
		SkM_Trace(FName, 3, "Message = "..snil(sMsg));


		-- check if sender is a guild member, if not he should not be sending
		-- messages on this channel !

		if (not SkM_IsNameInGuild(sSender)) then
			SkM_Trace(FName, 2, "Sender : "..snil(sSender)..", not in your guild !");
		else
			-- now handle the message
			--for iCode, sValue in string.gfind(sMsg, SKM_Context.Pattern.) do
			--"<SKM=%d>%s</SKM>"
			for iCode, sValue in string.gfind(sMsg, "<SKM=([0-9]+)>(.+)</SKM>") do
				if (sCode and sValue) then
					SkM_ProcessChannelMessage(iCode, sValue);
				end
			end
		end
	end
end


-- --------------------------------------------------------------------------------------
-- SkM_BuildGuildList
-- --------------------------------------------------------------------------------------
-- Build a list of players currently in the guild.
-- --------------------------------------------------------------------------------------
function SkM_BuildGuildList()
	local FName = "SkM_BuildGuildList";

	SkM_Trace(FName, 2, "Rebuild guild list");

	SKM_Context.GuildList = { };

	local iNumGuildMembers = GetNumGuildMembers();

	local i;
	for i=1, iNumGuildMembers, 1 do
--Usage: name, rank, rankIndex, level, class, zone, group, note, officernote, online = GetGuildRosterInfo(index);
		local sName = GetGuildRosterInfo(i);

		if (sName) then
			table.insert(SKM_Context.GuildList, sName);
		end
	end

end




function SkM_AddGuildMessageToQueue(sMsg, iPriority)
	local FName = "SkM_AddGuildMessageToQueue";

	if (SKM_Context.QueueSendMessage == nil) then
		SKM_Context.QueueSendMessage = { };
	end

	local iMessagePriority = ifnil(iPriority, 0);

	if (iMessagePriority == 0) then
		table.insert(SKM_Context.QueueSendMessage, { Message = sMsg; Priority = iMessagePriority } );
		return;
	end

	local i;
	local iQueueSize = table.getn(SKM_Context.QueueSendMessage);
	for i=1,iQueueSize,1 do
		if (SKM_Context.QueueSendMessage[i].Priority < iMessagePriority) then
			table.insert(SKM_Context.QueueSendMessage, { Message = sMsg; Priority = iMessagePriority }, i);
			return;
		end
	end
	table.insert(SKM_Context.QueueSendMessage, { Message = sMsg; Priority = iMessagePriority } );

end



function SkM_ProcessQueue()
	local FName = "SkM_ProcessQueue";

	--local sDate = SkM_GetDate();
	local sTime = GetTime();
	local bProcess = false;

	if (SKM_Context.QueueLastSentMessage == nil) then
		bProcess = true;
	else
		local iDiffTime = sTime - SKM_Context.QueueLastSentMessage;

		--if (iDiffTime > SkM_GetOption("SendMessageMinDelay")) then
		if (iDiffTime > 1) then
			bProcess = true;
		end
	end

	if (bProcess) then
		local sMsg = SKM_Context.QueueSendMessage[1].Message;
		table.remove(SKM_Context.QueueSendMessage, 1);

		SkM_SendGuildChannelMessage(sMsg);

		SKM_Context.QueueLastSentMessage = sTime;
	end

end



function SkM_SendWarList()
	local FName = "SkM_SendWarList";
	local idx, val;
	for idx, val in SKM_Data[_RealmName][_PlayerName].EnemyHistory do
	-- nchnch

		if (val[_SKM._atWar]) then
			-- local sMsg =

			SkM_AddGuildMessageToQueue(sMsg, 0);
		end

	end

end




-- TEST functions

function SkM_CharCode(sIn)
	--local List = { };
	local sOut = "";
	local i;
	for i=1, string.len(sIn), 1 do
		--List.insert(string.byte(sIn, i));
		sOut = sOut.."\\";
		sOut = sOut..string.byte(sIn, i);
	end
	--return List;
	return sOut;
end

function SkM_TestHonor()
	local FName = "SkM_TestHonor";
	local sMsg = "Gorwald dies, honorable kill Rank: First Sergeant (Estimated Honor Points: 67)";


	for sFoe, sRank in string.gfind(sMsg, SKM_Context.Pattern.Honor_Kill) do
		if (sFoe and sRank) then
			SkM_Trace(FName, 0, "Honor_Kill : Foe = "..sFoe..", Rank = "..sRank);

			SkM_Trace(FName, 0, "Enemy player death detected (from chat, honor) : "..snil(sFoe));
			--SkM_PvpEnemyDeath(sFoe, true, sRank);
		end
	end

end


function SkM_RecMapZones()
	local FName = "SkM_RecMapZones";

	SkM_ClearDebugRecord();
	SkM_SetDebugLevel(1);
	SkM_StartDebugRecord();

	local lv_Continents = { GetMapContinents() } ;
	for idx, val in lv_Continents do
		SkM_Trace(FName, 1, "Continent "..idx.." = "..val);
		local lv_Zones = { GetMapZones(idx) };
		for idx2, val2 in lv_Zones do
			SkM_Trace(FName, 1, "Cont. "..idx..", Zone "..idx2.." = "..val2);
		end
	end

	SkM_StopDebugRecord();
	SkM_SetDebugLevel(-1);
end



function test()
	local FName = "test";
	local idx, val;
	for idx, val in getfenv() do
		if (type(val) == "string" ) then
			SkM_Trace(FName, 0, idx.." = "..val);
		end
	end
end

-- OBSOLETE stuff




