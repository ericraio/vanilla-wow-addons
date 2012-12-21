GUILDADS_VERSION_STORAGE  = "20051017";

GuildAdsStorage_DebugTableName = {};
GUILDADSSTORAGE_DEBUG = false;

local HourMin = 60;
local DayMin = HourMin * 24;
local MonthMin = DayMin * 30;
local TimeRef = 18467940; 	-- Nombre de minutes entre 1/1/1970 et 11/2/2005
local AdsTable = nil;   	-- GuildAds.Data[realmName].Global[channel]
local IgnoreTable = nil;	-- GuildAds.Data[realmName].Ignore[channel]
local MyAdsTable = nil;		-- GuildAds.Data[realmName].Mine[playerName]
local playerName = nil;
local playersOnlineStatus = { };
local playersByAccount = { };
local itemInfo = { };		-- cache for GetItemInfo (usefull ?)

GuildAdsItems = {};

GAS_EVENT_ADDGLOBAL = 1;
GAS_EVENT_REMOVEGLOBAL = 2;
GAS_EVENT_ADDMY = 3;
GAS_EVENT_REMOVEMY = 4;
GAS_EVENT_UPDATEINVENTORY = 5;
GAS_EVENT_ONLINE = 6;

local Listeners = {
	[GAS_EVENT_ADDGLOBAL] = {};
	[GAS_EVENT_REMOVEGLOBAL] = {};
	[GAS_EVENT_ADDMY] = {};
	[GAS_EVENT_REMOVEMY] = {};
	[GAS_EVENT_UPDATEINVENTORY] = {};
	[GAS_EVENT_ONLINE] = {};
	};

local function DEBUG_MSG(msg)
	if (GUILDADSSTORAGE_DEBUG)
	then
		ChatFrame1:AddMessage("GAS: "..msg, 1.0, 1.0, 0.5);
	end
end

--[[
	Provide a common time between different players.
	Return the number of minutes since 11/2/2005 00h00 (date of the WOW release in Europe)
	Get UTC time, using server time and PC date.
	do not use UTC ( !*t ) to avoid to much difference between server and PC time.
]]
function GAS_currentTime()
	local hours,minutes = GetGameTime();
	local t = date("*t");
	t.wday = nil;
	t.yday = nil;
	t.isdst = nil;
	t.sec = nil;
	
	local local_min = t.hour*60+t.min;
	local server_min = hours*60+minutes; 
	
	local TimeShift = server_min-local_min;
	if math.abs(TimeShift)>=12*60 then
		if local_min<server_min then
			TimeShift = TimeShift-DayMin;
		else
			TimeShift = TimeShift+DayMin;
		end
	end
	
	t.hour, t.min = hours, minutes;
	-- local_min+TimeShift : server time not round between 0 and DayMin
	return math.floor(time(t) / 60)+math.floor((local_min+TimeShift)/DayMin)*DayMin-TimeRef;
end

function GAS_timeToString(ref, relative)
	local delta;
	local prefix = "";
	if relative then
		delta = tonumber(ref);
	else
		delta = GAS_currentTime()-tonumber(ref);
	end
	
	if delta<0 then
		prefix = "-";
		delta = -delta;
	end
	
	month = math.floor(delta / MonthMin);
	deltamonth = math.mod(delta, MonthMin);
	
	day = math.floor(deltamonth / DayMin);
	deltaday = math.mod(delta, DayMin);
	
	hour = math.floor(deltaday / HourMin);
	minute = math.mod(delta, HourMin);
	
	if (month > 0) then
		return prefix..string.format(GetText("LASTONLINE_MONTHS", nil, month), month);
	elseif (day > 0) then
		return prefix..string.format(GetText("LASTONLINE_DAYS", nil, day), day);
	elseif (hour > 0) then
		return prefix..string.format(GetText("LASTONLINE_HOURS", nil, hour), hour);
	else
		return prefix..string.format(GetText("GENERIC_MIN", nil, minute), minute);
	end
end

--------------------------------------------------------------------------------
--
-- About listeners
-- 
--------------------------------------------------------------------------------
function GAS_AddListener(ltype, name, listener)
	if Listeners[ltype] then
		Listeners[ltype][name] = listener;
		return true;
	else
		return false;
	end
end

function GAS_RemoveListener(ltype, name)
	if Listeners[ltype] and Listeners[ltype][name] then
		Listeners[ltype][name] = nil;
		return true;
	else
		return false;
	end
end

function GAS_NotifyListeners(ltype, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	GuildAdsPlugin_OnEvent(ltype, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	for listenerName, listenerFunction in Listeners[ltype] do
		listenerFunction(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	end
end

--------------------------------------------------------------------------------
--
-- Set online status of a player
-- 
--------------------------------------------------------------------------------
function GAS_SetOnlineStatus(playername, status)
	if status then
		if (not playersOnlineStatus[playername]) then
			playersOnlineStatus[playername] = true;
			GAS_NotifyListeners(GAS_EVENT_ONLINE, playername, true);
		end
	else
		if (playersOnlineStatus[playername]) then
			playersOnlineStatus[playername] = nil;
			GAS_NotifyListeners(GAS_EVENT_ONLINE, playername, false);
		end
	end
end

--------------------------------------------------------------------------------
--
-- Get online status of a player
-- 
--------------------------------------------------------------------------------
function GAS_IsOnline(playername)
	if (playersOnlineStatus[playername]) then
		return true;
	else
		return false;
	end
end

--------------------------------------------------------------------------------
--
-- Init
-- 
--------------------------------------------------------------------------------
function GAS_Init(playername, channel)
	DEBUG_MSG("[GAS_Init] begin");
	
	realmName = GetCVar("realmName");
	playerName = playername;
	
	-- Set account id
	if (GuildAds.AccountId == nil) then
		GuildAds.AccountId = GAS_CreateAccountId();
	end
	
	-- If this is the first time for this realm
	if (GuildAds.Data[realmName] == nil) then
		GuildAds.Data[realmName] = {};
		GuildAds.Data[realmName].Mine = {};
		GuildAds.Data[realmName].Global = {};
		GuildAds.Data[realmName].Profile = {};
	end
	
	-- If this is the first time that this player uses GuildAds
	if (GuildAds.Data[realmName].Mine[playername] == nil) then
		GuildAds.Data[realmName].Mine[playername] = {
			[GUILDADS_MSG_TYPE_REQUEST] = { NextId = 0 };
			[GUILDADS_MSG_TYPE_AVAILABLE] = { NextId = 0  };
			[GUILDADS_MSG_TYPE_EVENT] = { NextId = 0 };
			[GUILDADS_MSG_TYPE_ANNONCE] = {};
			[GUILDADS_MSG_TYPE_SKILL] = {};
		}
		DEBUG_MSG("First time for this player");
	end

	-- Init de GuildAds.Global[realmName][g_ChatChannel]
	if (GuildAds.Data[realmName].Global[channel] == nil) then
		GuildAds.Data[realmName].Global[channel] = {
			[GUILDADS_MSG_TYPE_REQUEST] = {};
			[GUILDADS_MSG_TYPE_AVAILABLE] = {};
			[GUILDADS_MSG_TYPE_EVENT] = {};
			[GUILDADS_MSG_TYPE_ANNONCE] = {};
			[GUILDADS_MSG_TYPE_SKILL] = {};
		};
		
		DEBUG_MSG("First time for this channel");
	end
	
	-- Init de GuildAds.Data[realmName].Ignore[channel]
	if GuildAds.Data[realmName].Ignore==nil then
		GuildAds.Data[realmName].Ignore={};
	end
	if GuildAds.Data[realmName].Ignore[channel]==nil then
		GuildAds.Data[realmName].Ignore[channel]={};
	end
	
	-- Init de GuildAds.Data[realmName].Profile[realmName]
	if (GuildAds.Data[realmName].Profile == nil) then
		GuildAds.Data[realmName].Profile = {};
	end
	
	-- Init des tables pour ce personnage
	IgnoreTable = GuildAds.Data[realmName].Ignore[channel]
	AdsTable = GuildAds.Data[realmName].Global[channel];
	MyAdsTable = GuildAds.Data[realmName].Mine[playername];
	ProfileTable = GuildAds.Data[realmName].Profile;
	
	-- Init des demandes par items
	GAS_ScanItems();

	-- DEBUG
	GAS_DebugWatchTables();
	
	DEBUG_MSG("[GAS_Init] end");
end

--------------------------------------------------------------------------------
--
-- After calling this function, an illegal access to AdsTable or MyAdsTable
-- will show an error
-- Illegal access = undefined key
-- 
--------------------------------------------------------------------------------
function GAS_DebugWatchTables()
	local mt = {
		__index = function (t, n)
			local msg = "GuildAds: attempt to read undeclared variable "..n;
			local name = GuildAdsStorage_DebugTableName[t];
			if (name) then
				msg = msg .. " in "..name;
			end
			ChatFrame1:AddMessage(msg, 1.0, 0.0, 0.0);
			error(msg, 2)
			return nil;
		end,
	};
	
	setmetatable(GuildAdsStorage_DebugTableName, {__mode = "k"})
	
	GuildAdsStorage_DebugTableName[AdsTable] = "AdsTable";
	setmetatable(AdsTable, mt);
    for k, t in AdsTable do
		GuildAdsStorage_DebugTableName[AdsTable[k]] = "AdsTable["..k.."]";
		setmetatable(AdsTable[k], mt);
	end
	
	GuildAdsStorage_DebugTableName[MyAdsTable] = "MyAdsTable";
	setmetatable(MyAdsTable, mt);
	for k, t in MyAdsTable do
		GuildAdsStorage_DebugTableName[MyAdsTable[k]] = "MyAdsTable["..k.."]";
		setmetatable(MyAdsTable[k], mt);
	end	
end

function GAS_GetAccountId()
	return GuildAds.AccountId;
end

function GAS_CreateAccountId()
	local str = "";
	for i=1,4,1 do
		str = str .. string.char(math.random(65, 90));
	end
	str = str..GAS_currentTime();
	return str;
end

--------------------------------------------------------------------------------
--
-- Profile
-- 
--------------------------------------------------------------------------------
function GAS_ProfileInit(owner)	
	if (ProfileTable[owner] == nil) then
		ProfileTable[owner] = {};
		ProfileTable[owner].Inventory = {};
	end
end

function GAS_ProfileSetInventorySlot(time, owner, slot, color, ref, name, texture, count)
	GAS_ProfileInit(owner);
	ProfileTable[owner].Inventory.creationtime = time;
	ProfileTable[owner].Inventory[slot] = {
			color = color,
			ref = ref,
			name = name,
			texture = texture,
			count = count
	}
	GAS_NotifyListeners(GAS_EVENT_UPDATEINVENTORY, owner, slot);
end

function GAS_ProfileGetInventory(owner)
	GAS_ProfileInit(owner);
	return ProfileTable[owner].Inventory;
end

function GAS_ProfileGet(owner)
	GAS_ProfileInit(owner);
	return ProfileTable[owner];
end

function GAS_ProfileSetGeneral(time, owner, race, class, level, guild)
	GAS_ProfileInit(owner);
	ProfileTable[owner].race = race;
	ProfileTable[owner].class = class;
	ProfileTable[owner].level = level;
	ProfileTable[owner].guild = guild;
	ProfileTable[owner].creationtime = time;
end

function GAS_ProfileSetAccountId(owner, accountid)
	GAS_ProfileInit(owner);
	ProfileTable[owner].accountid = accountid;
	if accountid and playersByAccount[accountid] then
		playersByAccount[accountid] = nil;
	end
end

function GAS_ProfileSetUpdatedDate(owner, time)
	GAS_ProfileInit(owner);
	ProfileTable[owner].updatedDate = time;
end

function GAS_ProfileGetUpdatedDate(owner)
	GAS_ProfileInit(owner);
	return ProfileTable[owner].updatedDate;
end

function GAS_PlayersByAccount(accountid)
	if (not playersByAccount[accountid]) then
		playersByAccount[accountid] = { };
		for owner, data in ProfileTable do
			if (data.accountid == accountid) then
				tinsert(playersByAccount[accountid], owner);
			end
		end
	end
	return playersByAccount[accountid];
end

function GAS_ProfileIgnore(owner, status)
	if status then
		IgnoreTable[owner] = GAS_currentTime();
		
		local account = ProfileTable[owner].accountid;
		if account then
			playersByAccount[account] = nil;
		end
		
		ProfileTable[owner] = nil;
		for adtype, ads in AdsTable do 
			GAS_RemoveByOwner(owner, adtype);
		end
		
	else
		IgnoreTable[owner] = nil;
	end
end

function GAS_ProfileIsIgnored(owner)
	return IgnoreTable[owner];
end

function GAS_ProfileIgnoreList()
	return IgnoreTable;
end

--------------------------------------------------------------------------------
--
-- Get my ads table
-- 
--------------------------------------------------------------------------------
function GAS_GetMyAds()
	if (MyAdsTable == nil) then
		error("GuildAdsStorage : MyAdsTable == nil", 2);
	else
		return MyAdsTable;
	end
end

--------------------------------------------------------------------------------
--
-- Get global ads table
-- 
--------------------------------------------------------------------------------
function GAS_GetAds(adType)
	if (AdsTable == nil) then
		error("GuildAdsStorage : AdsTable == nil", 2);
	else
		if (adType) then
			if (not AdsTable[adType]) then
				AdsTable[adType] = {};
			end
			return AdsTable[adType];
		else
			return AdsTable;
		end
	end
end

---------------------------------------------------------------------------------
--
-- Check validity of an ad
-- 
---------------------------------------------------------------------------------
function GAS_IsValidAd(adtype, ad)
	if (adtype ==  GUILDADS_MSG_TYPE_EVENT) then
		for k, oneAd in MyAdsTable[adtype] do
			if type(oneAd)=="table" and oneAd.text == ad.text then
				return false;
			end
		end
		return true;
	else
		return true;
	end
end

---------------------------------------------------------------------------------
--
-- Add a my ad
-- 
---------------------------------------------------------------------------------
function GAS_AddMyAd(adtype, text, color, ref, name, texture, count)
	-- Create ad
	local nextId = MyAdsTable[adtype].NextId;
	local ad = {
		id = nextId,
		text = text,
		itemColor = color,
		itemRef = ref,
		itemName = name,
		texture = texture,
		count = count,
		creationtime = GAS_currentTime(),
		m_Enabled = true, 
	};
	
	-- Check validity
	if (not GAS_IsValidAd(adtype, ad)) then
		return false
	end
	
	-- Add to the my ad table
	table.insert(MyAdsTable[adtype], ad);
	
	-- Incrememnt the id and wrap around
	nextId = nextId + 1;
	if (nextId >= 65535) then 
		nextId = 0; 
	end;
	MyAdsTable[adtype].NextId = nextId;
	
	-- Notify listeners
	GAS_NotifyListeners(GAS_EVENT_ADDMY, adtype, ad);
	
	-- Notify everyone
	if (GuildAds.Config.PublishMyAds) then
		GAC_SendingUpdate(nil, 1);
		GAC_SendAd(nil, adtype, ad);
	end
	return id;
end

---------------------------------------------------------------------------------
--
-- Edit one of my ad
-- 
---------------------------------------------------------------------------------
function GAS_EditMyAd(adtype, id, text, color, ref, name, texture, count)
	-- Ad to edit
	ad = MyAdsTable[adtype][id];
	
	-- Add to the my ads table
	ad.text = text;
	ad.itemColor = color;
	ad.itemRef = ref;
	ad.itemName = name;
	ad.count = count;
	ad.texture = texture;
	
	-- Notify listeners
	GAS_NotifyListeners(GAS_EVENT_ADDMY, adtype, ad);
	
	-- Notify everyone
	if (GuildAds.Config.PublishMyAds) then
		GAC_SendingUpdate(nil, 1);
		GAC_SendAd(nil, adtype, ad);
	end
	return id;
end


---------------------------------------------------------------------------------
--
-- Remove a my ad
-- 
---------------------------------------------------------------------------------
function GAS_RemoveMyAd(adtype, id)
	for key, ad in MyAdsTable[adtype] do
		if (ad.id == id) then
			table.remove(MyAdsTable[adtype], key);
			
			-- Notify listener
			GAS_NotifyListeners(GAS_EVENT_REMOVEMY, adtype, id);
			
			-- Notify everyone
			if (GuildAds.Config.PublishMyAds) then
				GAC_SendRemove(nil, adtype, id);
			end
			
			-- Return
			return
		end
	end
end

---------------------------------------------------------------------------------
--
-- Enable a my ad
-- 
---------------------------------------------------------------------------------
function GAS_EnableMyAd(adtype, id)
	MyAdsTable[adtype][id].m_Enabled = true;
	
	-- Notify everyone
	if (GuildAds.Config.PublishMyAds) then
		-- ChatFrame1:AddMessage("GAS_EnableMyAd("..NoNil(owner)..","..NoNil(adtype)..","..NoNil(id)..")");
		GAC_SendingUpdate(nil, 1);
		GAC_SendAd(nil, adtype, MyAdsTable[adtype][id]);
	end
end

---------------------------------------------------------------------------------
--
-- Disable a my ad
-- 
---------------------------------------------------------------------------------
function GAS_DisableMyAd(adtype, id)
	MyAdsTable[adtype][id].m_Enabled = false;
	
	-- Notify everyone
	if (GuildAds.Config.PublishMyAds) then
		-- ChatFrame1:AddMessage("GAS_DisableMyAd("..NoNil(owner)..","..NoNil(adtype)..","..NoNil(id)..")");
		GAC_SendRemove(nil, adtype, MyAdsTable[adtype][id].id);
	end
end

---------------------------------------------------------------------------------
--
-- Add a global ad
-- 
---------------------------------------------------------------------------------
function GAS_AddAd(owner, adtype, ad)
	DEBUG_MSG("GAS_AddAd");
	if (AdsTable[adtype]) then
		table.insert(AdsTable[adtype], ad);
		if adtype==GUILDADS_MSG_TYPE_REQUEST or adtype==GUILDADS_MSG_TYPE_AVAILABLE then
			GAS_ScanItemsLine(adtype, owner, ad.itemName, 1, ad.count);
		end
		-- Notify listeners
		GAS_NotifyListeners(GAS_EVENT_ADDGLOBAL, owner, adtype, ad);
	end
end

---------------------------------------------------------------------------------
--
-- Remove an add by owner and id
-- 
---------------------------------------------------------------------------------
function GAS_RemoveByOwnerAndId(owner, adtype, id)
	if (AdsTable[adtype]) then
		local size = table.getn(AdsTable[adtype]);
		local i = 1;
		while (i <= size) do
			local ad = AdsTable[adtype][i];
			if ((ad.owner == owner) and (ad.id == id)) then
				table.remove(AdsTable[adtype], i);
				size = size - 1;
				if adtype==GUILDADS_MSG_TYPE_REQUEST or adtype==GUILDADS_MSG_TYPE_AVAILABLE then
					GAS_ScanItemsLine(adtype, owner, ad.itemName, -1, ad.count)
				end
				-- Notify listeners
				GAS_NotifyListeners(GAS_EVENT_REMOVEGLOBAL, owner, adtype, id);
			else
				i = i + 1;
			end
		end
	else
		-- ChatFrame1:AddMessage("Problème avec GAS_RemoveByOwnerAndId("..NoNil(owner)..","..NoNil(adtype)..","..NoNil(id)..")");
	end
end

----------------------------------------------------------------------------------
--
-- Remove all ads by owner
-- 
---------------------------------------------------------------------------------
function GAS_RemoveByOwner(owner, adtype)
	if (AdsTable[adtype]) then
		local size = table.getn(AdsTable[adtype]);
		local i = 1;
		while (i <= size) do
			local ad = AdsTable[adtype][i];
			if (ad.owner == owner) then
				table.remove(AdsTable[adtype], i);
				size = size - 1;
				if adtype==GUILDADS_MSG_TYPE_REQUEST or adtype==GUILDADS_MSG_TYPE_AVAILABLE then
					GAS_ScanItemsLine(adtype, owner, ad.itemName, -1, ad.count)
				end
				-- Notify listeners
				GAS_NotifyListeners(GAS_EVENT_REMOVEGLOBAL, owner, adtype, id);
			else
				i = i + 1;
			end
		end
	else
		-- ChatFrame1:AddMessage("Problème avec GAS_RemoveByOwner("..NoNil(owner)..","..NoNil(adtype)..","..NoNil(id)..")");
	end
end

---------------------------------------------------------------------------------
--
-- Get Skill id, name, group
-- 
---------------------------------------------------------------------------------
function GAS_GetSkillId(SkillName)
	for id, name in GUILDADS_SKILLS do
		if (name == SkillName) then
			return id;
		end
	end
	return -1;
end

function GAS_GetSkillText(SkillId)
	if (GUILDADS_SKILLS[SkillId]) then
		return GUILDADS_SKILLS[SkillId];
	else
		return "";
	end
end

---------------------------------------------------------------------------------
--
-- Get Class id, name
-- 
---------------------------------------------------------------------------------
function GAS_GetClassId(ClassName)
	for id, name in GUILDADS_CLASSES do
		if (name == ClassName) then
			return id;
		end
	end
	return -1;
end

function GAS_GetClassText(ClassId)
	if (GUILDADS_CLASSES[ClassId]) then
		return GUILDADS_CLASSES[ClassId];
	else
		return ClassId;
	end
end

---------------------------------------------------------------------------------
--
-- Get Race id, name
-- 
---------------------------------------------------------------------------------
function GAS_GetRaceId(RaceName)
	for id, name in GUILDADS_RACES do
		if (name == RaceName) then
			return id;
		end
	end
	return -1;
end

function GAS_GetRaceText(RaceId)
	if (GUILDADS_RACES[RaceId]) then
		return GUILDADS_RACES[RaceId];
	else
		return RaceId;
	end
end

----------------------------------------------------------------------------------
--
-- GAS_ScanItems
-- 
---------------------------------------------------------------------------------
function GAS_ScanItems()
	GuildAdsItems = {};
	for k,v in AdsTable[GUILDADS_MSG_TYPE_REQUEST] do
		if (v.itemName) then
			GAS_ScanItemsLine(GUILDADS_MSG_TYPE_REQUEST, v.owner, v.itemName, 1, v.count);
		end
	end
	for k,v in AdsTable[GUILDADS_MSG_TYPE_AVAILABLE] do
		if (v.itemName) then
			GAS_ScanItemsLine(GUILDADS_MSG_TYPE_AVAILABLE, v.owner, v.itemName, 1, v.count);
		end
	end
end

local function GAS_GetItemIndex(adtype, author, itemName)
	for index, data in GuildAdsItems[itemName][adtype] do
		if data.owner==author then
			return index;
		end
	end
	return nil;
end

function GAS_ScanItemsLine(adtype, author, itemName, delta, count)
	if (itemName ~= nil) then
		if (GuildAdsItems[itemName] == nil) then
			GuildAdsItems[itemName] = {
				[GUILDADS_MSG_TYPE_REQUEST] = {};
				[GUILDADS_MSG_TYPE_AVAILABLE] = {};
			};
		end
		local inf = false;
		if (count==nil) then
			count = 0;
			inf = true;
		end
		
		local index = GAS_GetItemIndex(adtype, author, itemName);
		
		if index then
			local t = GuildAdsItems[itemName][adtype][index];
			t.count = t.count+delta*count;
			if inf then
				if delta>0 then
					t.inf = true;
				else
					t.inf = false;
				end
			end
			if (t.count==0) and (not t.inf) then
				tremove(GuildAdsItems[itemName][adtype], index);
			end
		else
			if (delta>0) then
				tinsert(GuildAdsItems[itemName][adtype], {
					count = count;
					inf = inf;
					owner = author;
				});
			end
		end
		table.sort(GuildAdsItems[itemName][adtype], GAS_PredicateAds);
	end
end

function GAS_PredicateAds(a, b)
	-- nil references are always less than
	if (a == nil) then
		if (b == nil) then
			return false;
		else
			return true;
		end
	elseif (b == nil) then
		return false;
	end

	-- inf/count
	if (a.inf) then
		if (not b.inf) then
			return true;
		end
	else
		if (b.inf) then
			return false;
		else
			if (a.count < b.count) then
				return false;
			elseif (a.count > b.count) then
				return true;
			end
		end
	end

	-- owner
	if (a.owner<b.owner) then
		return true;
	elseif (a.owner>b.owner) then
		return false;
	end

	-- same
	return false;
end

function GAS_GetItemAdsInfo(itemName)
	if GuildAdsItems[itemName] then
		return GuildAdsItems[itemName][GUILDADS_MSG_TYPE_REQUEST],  GuildAdsItems[itemName][GUILDADS_MSG_TYPE_AVAILABLE];
	else
		return;
	end
end

function GAS_UnpackLink(link)
	local start, _, color, ref, name = string.find(link, "|c([%w]+)|H([^|]+)|h%[([^|]+)%]|h|r");
	if (start) then
		return color, ref, name;
	else
		local _, _, color, name = string.find(link, "|c([%w]+)%[([^|]+)%]|r");
		return color, nil, name;
	end
end

function GAS_PackLink(color, ref, name)
	if (ref) then
		color = color or "ffffffff";
		name = name or "??";
		return "|c"..color.."|H"..ref.."|h["..name.."]|h|r";
	else
		return "|c"..color.."["..name.."]|r";
	end
end

local function GAS_MakeIntFromHexString(str)
	local remain = str;
	local amount = 0;
	while( remain ~= "" ) do
		amount = amount * 16;
		local byteVal = string.byte(strupper(strsub(remain, 1, 1)));
		if( byteVal >= string.byte("0") and byteVal <= string.byte("9") ) then
			amount = amount + (byteVal - string.byte("0"));
		elseif( byteVal >= string.byte("A") and byteVal <= string.byte("F") ) then
			amount = amount + 10 + (byteVal - string.byte("A"));
		end
		remain = strsub(remain, 2);
	end
	return amount;
end

function GAS_GetRGBFromHexColor(hexColor)
	local red = GAS_MakeIntFromHexString(strsub(hexColor, 3, 4)) / 255;
	local green = GAS_MakeIntFromHexString(strsub(hexColor, 5, 6)) / 255;
	local blue = GAS_MakeIntFromHexString(strsub(hexColor, 7, 8)) / 255;
	return red, green, blue;
end

---------------------------------------------------------------------------------
--
-- Get item information (GetItemInfo)
-- 
---------------------------------------------------------------------------------
function GAS_GetItemInfo(itemRef)
	if not(itemInfo[itemRef] and itemInfo[itemRef].type) then
		-- GetAuctionItemClasses();  GetAuctionItemSubClasses(index)
		-- itemTexture valid [since|in futur] patch 1.9
		local _, _, itemLink1, itemLink2, itemLink3, itemLink4 = string.find(itemRef, "item:(%d+):(%d+):(%d+):(%d+)");
		local itemName, itemLink, itemRarity, itemMinLevel, itemType, itemSubType, itemStackCount, itemSlot, itemTexture;
		if itemLink1 and itemLink2 == "0" and itemLink3 == "0" and itemLink4 == "0" then
			itemName, itemLink, itemRarity, itemMinLevel, itemType, itemSubType, itemStackCount, itemSlot, itemTexture = GetItemInfo(itemLink1);
		else
			-- GuildAdsInternalTooltip:SetHyperlink(itemRef);
			-- GuildAdsInternalTooltip:Show();
			itemName, itemLink, itemRarity, itemMinLevel, itemType, itemSubType, itemStackCount, itemSlot, itemTexture = GetItemInfo(itemRef);
			if not itemName then
				_, itemLink, itemRarity, itemMinLevel, itemType, itemSubType, itemStackCount, itemSlot, itemTexture = GetItemInfo(itemLink1);
			end
		end
		
		if itemSlot and getglobal(itemSlot) then
			itemSlot = getglobal(itemSlot);
		end
		itemInfo[itemRef] = { };
		itemInfo[itemRef].type = itemType;
		itemInfo[itemRef].subtype = itemSubType;
		itemInfo[itemRef].slot = itemSlot;
		itemInfo[itemRef].rarity = itemRarity;
		itemInfo[itemRef].stackcount = itemStackCount;
		itemInfo[itemRef].minlevel = itemMinLevel;
		itemInfo[itemRef].name = itemName;
		itemInfo[itemRef].texture = itemTexture;
	end
	return itemInfo[itemRef];
end