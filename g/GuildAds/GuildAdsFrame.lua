GUILDADSFRAME_DEBUG = false;

local g_playerName = "Noname";
local g_realmName = "None";

local GUILDADS_NUM_GLOBAL_AD_BUTTONS = 17;
local GUILDADS_NUM_MY_AD_BUTTONS = 5;

GUILDADS_ADBUTTONSIZEY = 16;

GUILDADS_MY_ADS    = 1;
GUILDADS_MY_FILTER = 2;

-- Pour GuildAds_GameTooltip_AddText
local MAX_LINE_SIZE=60;

local g_adtype = GUILDADS_MSG_TYPE_REQUEST;		--- Which ads type
local g_mytype = GUILDADS_MY_ADS;				--- My ads, Filter

local g_GlobalAdSelected;						--- Index of the ad currently selected
local g_GlobalTitleSelected;					--- Index of the title currently selected
local g_MyAdSelected;							--- Index of my ad currently selected

local g_HideGroup = {							--- Minus/Plus on title
	[GUILDADS_MSG_TYPE_ANNONCE] = {},
	[GUILDADS_MSG_TYPE_REQUEST] = {},
	[GUILDADS_MSG_TYPE_AVAILABLE] = {},
	[GUILDADS_MSG_TYPE_EVENT] = {},
	[GUILDADS_MSG_TYPE_SKILL] = {}
};

local g_AdFilters = { 
	[GUILDADS_MSG_TYPE_ANNONCE] = {},
	[GUILDADS_MSG_TYPE_REQUEST] = {},
	[GUILDADS_MSG_TYPE_AVAILABLE] = {},
	[GUILDADS_MSG_TYPE_EVENT] = {},
	[GUILDADS_MSG_TYPE_SKILL] = {}
};

local g_AdColor = {
	[GUILDADS_MSG_TYPE_ANNONCE]	= { ["r"] = 1,    ["g"] = 1,    ["b"] = 1 }, 
	[GUILDADS_MSG_TYPE_REQUEST]	= { ["r"] = 1,    ["g"] = 1,    ["b"] = 1 },
	[GUILDADS_MSG_TYPE_AVAILABLE]  = { ["r"] = 0.75, ["g"] = 0.75, ["b"] = 1 },
	[GUILDADS_MSG_TYPE_INVENTORY]	= { ["r"] = 1,    ["g"] = 0.75, ["b"] = 0.75 },
	[GUILDADS_MSG_TYPE_EVENT]	= { ["r"] = 1,    ["g"] = 1,    ["b"] = 1 },
	[GUILDADS_MSG_TYPE_SKILL]	= { ["r"] = 1,    ["g"] = 1,    ["b"] = 0.5 },
	};
	
local g_OnlineColor = {
	[true]				= { ["r"] = 1,    ["g"] = 0.86, ["b"] = 0 },
	[false]				= { ["r"] = 0.5,  ["g"] = 0.5,  ["b"] = 0.5 },
};

local SinceColor = { ["r"] = 0.3,    ["g"] = 0.6, ["b"] = 1.0 };

local g_TableToShowCache = {};

GuildAds_ItemFilterOrder = {
		"everything",
		"everythingelse",
		"gather",
		"monster",
		"classReagent",
		"tradeReagent",
		"vendor",
		"trade"
};

g_DateFilter = {
	1,
	60,
	24*60,
	24*60*2,
	24*60*7,
	24*60*14,
	24*60*30
};

local g_sortBySubType = false;

-- date of the last time the GuildAds window was opened (for HideAdsOlderThan filter)
local g_lastInteraction = nil;

---------------------------------------------------------------------------------
--
-- DEBUG_MSG
--
---------------------------------------------------------------------------------
local function DEBUG_MSG(msg)
	if (GUILDADSFRAME_DEBUG) then
		ChatFrame1:AddMessage(msg, 1.0, 1.0, 0.5);
	end
end

---------------------------------------------------------------------------------
--
-- Listeners
--
---------------------------------------------------------------------------------
function GuildAds_OnOnline(owner, status)
	-- update UI
	GuildAds_UpdateGlobalAdButtons(g_adtype);
	GuildAds_UpdateMemberCount();
	
	-- show connected status except for my guild
	local gowner = GuildAds_GetPlayerGuild(owner);
	local gprofile = GuildAds_GetPlayerGuild(g_playerName);
	if (owner ~= g_playerName and (gowner ~= gprofile or gowner == nil)) then
		local msg;
		if (status) then
			if GuildAds_HasJoined(owner) then
				msg = string.format(ERR_FRIEND_ONLINE_SS, owner, owner);
				GuildAds_ResetHasJoined(owner);
			end
		else
			msg = string.format(ERR_FRIEND_OFFLINE_S, owner);
		end
		if (msg) then
			GAC_AddChatMessage(msg);
		end
	end
end

function GuildAds_OnUpdateInventory(owner, slot)
	local inventory = GAS_ProfileGetInventory(owner);
	local item = inventory[slot];
	GuildAdsInspectItemSlotButton_Update(owner, slot,  item.ref, item.texture, item.count);
	GuildAdsInspect_SetTime(owner, GAS_timeToString(inventory.creationtime));
end

function GuildAds_OnAddGlobalAd(owner, adtype, ad)
	-- update UI
	GuildAds_UpdateGlobalAdButtons(adtype, true);
	if adtype==GUILDADS_MSG_TYPE_ANNONCE then
		GuildAds_UpdateMemberCount();
	end
		
	-- Affichage dans la fenêtre de chat
	if (owner ~= g_playerName) then
		local tochat = nil;
		if adtype==GUILDADS_MSG_TYPE_REQUEST and GuildAdsConfig_GetProfileValue("ShowNewAsk") then
			tochat = GUILDADS_HEADER_REQUEST..": "..GuildAds_AdGetText(adtype, ad, true);
		end
		if adtype == GUILDADS_MSG_TYPE_AVAILABLE and GuildAdsConfig_GetProfileValue("ShowNewHave") then
			tochat = GUILDADS_HEADER_AVAILABLE..": "..GuildAds_AdGetText(adtype, ad, true);
		end
		if (tochat ~= nil) then
			GAC_AddChatMessage("["..owner.."]\32"..tochat);
		end
	end
end

function GuildAds_OnDeleteGlobalAd(owner, adtype, id)
	-- update UI
	GuildAds_UpdateGlobalAdButtons(adtype, true);
	if adtype==GUILDADS_MSG_TYPE_ANNONCE then
		GuildAds_UpdateMemberCount();
	end
end

function GuildAds_OnAddMyAd(adtype, ad)
	-- update UI
	if (GuildAdsFrame:IsVisible()) then
		GuildAds_UpdateMyFrame();
	end
end

function GuildAds_OnDeleteMyAd(adtype, id)
	-- update UI
	if (GuildAdsFrame:IsVisible()) then
		GuildAds_UpdateMyFrame();
	end
end

--------------------------------------------------------------------------------
--
-- OnLoad
-- 
--------------------------------------------------------------------------------
function GuildAdsFrame_OnLoad()
	-- Get player name
	g_playerName = UnitName("player");
	g_realmName = GetCVar("realmName");
	
	-- Init g_TableToShowCache
	g_TableToShowCache = {};
	
	-- Initial selection values
	g_GlobalAdSelected = 0;
	g_GlobalTitleSelected = 0;
	g_MyAdSelected = 0;
	
	-- UI stuff
	GuildAdsRemoveButton:Disable();
	PanelTemplates_SetNumTabs(GuildAdsFrame, 5);
	PanelTemplates_SetTab(GuildAdsFrame, 1);
	GuildAdsVersion:SetText(GuildAds_GetVersionAsString());
	
	tinsert(UISpecialFrames,"GuildAdsFrame");
	
	if ButtonHole then
		GuildAdsMinimapButton:Show();
		ButtonHole.application.RegisterMod({
			id="GUILDADS", 
			name=GUILDADS_TITLE, 
            tooltip=GUILDADS_TITLE, 
            buttonFrame="GuildAdsMinimapButton", 
            updateFunction="GuildAdsMinimapButton_Update"
			}
		);
	end
end

--------------------------------------------------------------------------------
--
-- Init
-- 
--------------------------------------------------------------------------------
function GuildAdsFrame_Init()
	-- Set listener
	GAS_AddListener(GAS_EVENT_ONLINE, "GuildAds", GuildAds_OnOnline);
	GAS_AddListener(GAS_EVENT_UPDATEINVENTORY, "GuildAds", GuildAds_OnUpdateInventory);
	GAS_AddListener(GAS_EVENT_ADDGLOBAL, "GuildAds", GuildAds_OnAddGlobalAd);
	GAS_AddListener(GAS_EVENT_REMOVEGLOBAL, "GuildAds", GuildAds_OnDeleteGlobalAd);
	GAS_AddListener(GAS_EVENT_ADDMY, "GuildAds", GuildAds_OnAddMyAd);
	GAS_AddListener(GAS_EVENT_REMOVEMY, "GuildAds", GuildAds_OnDeleteMyAd);
	
	-- Enable access to GuildAds
	if not ButtonHole then
		GuildAdsMinimapButton_Update();
		GuildAdsMinimapButton:Show();
	end
	
	-- Init date filter
	local range = table.getn(g_DateFilter)+1;
	GuildAds_DateFilter:SetMinMaxValues(1,range);
	GuildAds_DateFilter:SetValueStep(1);
	local dateFilter = GuildAdsConfig_GetProfileValue("HideAdsOlderThan", nil);
	if dateFilter then
		for value, time in g_DateFilter do
			if dateFilter==time then
				GuildAds_DateFilter:SetValue(value);
			end
		end
	else
		GuildAds_DateFilter:SetValue(range);
	end
	
	-- Init g_sortBySubType
	g_sortBySubType = GuildAdsConfig_GetProfileValue("sortBySubType", true);
	
	-- Init g_AdFilters
	for id, name in GUILDADS_SKILLS do
		tinsert(g_AdFilters[GUILDADS_MSG_TYPE_SKILL], { id=id, name=name});
	end
	
	local playerFaction = GUILDADS_RACES_TO_FACTION[GAS_GetRaceId(UnitRace("player"))];
	for id, name in GUILDADS_CLASSES do
		if (GUILDADS_CLASS_TO_FACTION[id]==nil or GUILDADS_CLASS_TO_FACTION[id]==playerFaction) then
			tinsert(g_AdFilters[GUILDADS_MSG_TYPE_ANNONCE], { id=id, name=name});
		end
	end

	local FilterNames = {};
	if (ReagentData) then
		FilterNames = GUILDADS_ITEMS;
	else
		FilterNames = GUILDADS_ITEMS_SIMPLE;
	end
	for i, key in GuildAds_ItemFilterOrder do
		if (FilterNames[key]) then
			tinsert(g_AdFilters[GUILDADS_MSG_TYPE_REQUEST], {id = key, name=FilterNames[key] });
			tinsert(g_AdFilters[GUILDADS_MSG_TYPE_AVAILABLE], {id = key, name=FilterNames[key] });
		end
	end
end

----------------------------------------------------------------------------------
--
-- Called when the main window is shown
-- 
---------------------------------------------------------------------------------
function GuildAds_OnShow()
	DEBUG_MSG("GuildAds_OnShow");
	-- reset UI cache because of the HideAdsOlderThan filter ?
	local currentTime = GAS_currentTime();
	local dateFilter = GuildAdsConfig_GetProfileValue("HideAdsOlderThan", nil);
	if dateFilter and g_lastInteraction then
		if currentTime-g_lastInteraction>dateFilter then
			GuildAdsFrame_ResetCache();
		end
	end;
	g_lastInteraction = currentTime;
	
	-- update
	GuildAds_UpdateGlobalAdButtons(g_adtype);
	GuildAds_UpdateMyFrame();
end

---------------------------------------------------------------------------------
--
-- Choose a tab (Available, Request, Event, ...)
-- 
---------------------------------------------------------------------------------
function GuildAds_SelectTab(adType)
	DEBUG_MSG("GuildAds_SelectTab("..adType..")");
	
	if (g_adtype == GUILDADS_MSG_TYPE_REQUEST) then
		GuildAdsAddButtonLookFor:Hide();
	elseif (g_adtype == GUILDADS_MSG_TYPE_AVAILABLE) then
		GuildAdsAddButtonAvailable:Hide();
	elseif (g_adtype == GUILDADS_MSG_TYPE_EVENT) then
		GuildAdsAddButtonEvent:Hide();
	end
	-------
	local toId = {
		[GUILDADS_MSG_TYPE_REQUEST] = 1,
		[GUILDADS_MSG_TYPE_AVAILABLE] = 2,
		[GUILDADS_MSG_TYPE_SKILL] = 3,
		[GUILDADS_MSG_TYPE_EVENT] = 4,
		[GUILDADS_MSG_TYPE_ANNONCE] = 5
		
	};
	PanelTemplates_SetTab(GuildAdsFrame, toId[adType]);
	g_adtype = adType;
	g_GlobalAdSelected = 0;
	g_GlobalTitleSelected = 0;
	GuildAds_UpdateGlobalAdButtons(adType);
	-- GuildAds_UpdateMyFrame updated by GuildAds_MyAdsEdit
	GuildAds_MyAdsEdit(nil);
	
	--------
	if (g_adtype == GUILDADS_MSG_TYPE_REQUEST) then
		GuildAds_DateFilter:Show();
		GuildAdsGroupByAccountCheckButton:Hide();
		GuildAdsGuildShowOfflinesCheckButton:Hide();
		GuildAdsAddButtonLookFor:Show();
		GuildAdsRemoveButton:Show();
		GuildAdsEditBox:Show();
		GuildAdsEditBox:SetWidth(465);
		GuildAdsEditItem:Show();
		GuildAds_Event_ZoneDropDown:Hide();
		GuildAds_MyTab1:Show();
		GuildAds_MyTab2:Show();
	elseif (g_adtype == GUILDADS_MSG_TYPE_AVAILABLE) then
		GuildAds_DateFilter:Show();
		GuildAdsGroupByAccountCheckButton:Hide();
		GuildAdsGuildShowOfflinesCheckButton:Hide();
		GuildAdsAddButtonAvailable:Show();
		GuildAdsRemoveButton:Show();
		GuildAdsEditBox:Show();
		GuildAdsEditBox:SetWidth(465);
		GuildAdsEditItem:Show();
		GuildAds_Event_ZoneDropDown:Hide();
		GuildAds_MyTab1:Show();
		GuildAds_MyTab2:Show();
	elseif (g_adtype == GUILDADS_MSG_TYPE_SKILL) then
		GuildAds_DateFilter:Hide();
		GuildAdsGroupByAccountCheckButton:Hide();
		GuildAdsGuildShowOfflinesCheckButton:Hide();
		GuildAdsRemoveButton:Hide();
		GuildAdsEditBox:Hide();
		GuildAdsEditItem:Hide();
		GuildAds_Event_ZoneDropDown:Hide();
		GuildAds_MySelectTab(GUILDADS_MY_FILTER);
		GuildAds_MyTab1:Hide();
		GuildAds_MyTab2:Show();
	elseif (g_adtype == GUILDADS_MSG_TYPE_EVENT) then
		GuildAds_DateFilter:Show();
		GuildAdsGroupByAccountCheckButton:Hide();
		GuildAdsGuildShowOfflinesCheckButton:Hide();
		GuildAdsAddButtonEvent:Show();
		GuildAdsRemoveButton:Show();
		GuildAdsEditBox:Show();
		GuildAdsEditItem:Hide();
		GuildAds_Event_ZoneDropDown:Show();
		GuildAdsEditBox:SetWidth(330);
		GuildAds_MySelectTab(GUILDADS_MY_ADS);
		GuildAds_MyTab1:Show();
		GuildAds_MyTab2:Hide();
	elseif (g_adtype == GUILDADS_MSG_TYPE_ANNONCE) then
		GuildAds_DateFilter:Hide();
		if (GuildAds.Config.GroupByAccount) then
			GuildAdsGroupByAccountCheckButton:SetChecked(1);
		else
			GuildAdsGroupByAccountCheckButton:SetChecked(0);
		end
		if (GuildAdsConfig_GetProfileValue("GuildShowOfflines")) then
			GuildAdsGuildShowOfflinesCheckButton:SetChecked(1);
		else
			GuildAdsGuildShowOfflinesCheckButton:SetChecked(0);
		end
		GuildAdsGroupByAccountCheckButton:Show();
		GuildAdsGuildShowOfflinesCheckButton:Show();
		GuildAdsRemoveButton:Hide();
		GuildAdsEditBox:Hide();
		GuildAdsEditItem:Hide();
		GuildAds_Event_ZoneDropDown:Hide();
		GuildAds_MySelectTab(GUILDADS_MY_FILTER);
		GuildAds_MyTab1:Hide();
		GuildAds_MyTab2:Show();	
	end
	
	DEBUG_MSG("GuildAds_SelectTab("..adType..") End");
end


function GuildAdsFrame_OnChannelChange()
	GuildAdsFrame_ResetCache();
	GuildAds_UpdateGlobalAdButtons(g_adtype);
	GuildAds_MyAdsEdit(nil);
end

---------------------------------------------------------------------------------
--
-- Predicate functions which can be used to compare two ads for sorting
-- return true if the first argument should come first in the sorted array
-- 
---------------------------------------------------------------------------------
function GuildAds_SkillPredicate(a, b)
	--
	-- nil references are always less than
	--
	if (a == nil) then
		if (b == nil) then
			-- a==nil, b==nil
			return false;
		else
			-- a==nil, b~=nil
			return true;
		end
	elseif (b == nil) then
		-- a~=nil, b==nil
		return false;
	end

	-- for skills
	if (a.skillRank and b.skillRank) then
		--
		-- Sort by skill name (ie id)
		--
		if (a.id < b.id) then
			return true;
		elseif (a.id > b.id) then
			return false;
		end

		--
		-- Sort by skill rank
		--		
		if (a.skillRank < b.skillRank) then
			return false;
		elseif (a.skillRank > b.skillRank) then
			return true;
		end
	end
	
	--
	-- Sort by owner next
	--
	aowner = a.owner;
	bowner = b.owner;
	if (aowner == nil) then
		aowner = "";
	end
	if (bowner == nil) then
		bowner = "";
	end
	
	if (aowner < bowner) then
		return true;
	elseif (aowner > bowner) then
		return false;
	end
	
	-- These ads are identical
	return false;
end

function GuildAds_AdPredicate(a, b)
	--
	-- nil references are always less than
	--
	if (a == nil) then
		if (b == nil) then
			-- a==nil, b==nil
			return false;
		else
			-- a==nil, b~=nil
			return true;
		end
	elseif (b == nil) then
		-- a~=nil, b==nil
		return false;
	end
	
	--
	-- Sort by item type (g_itemInfo)
	--
	if a.itemRef then
		if b.itemRef then
			local info, atype, btype;
			info = GAS_GetItemInfo(a.itemRef);
			atype = info.type;
			if g_sortBySubType then
				if info.type and info.subtype and info.type~=info.subtype then
					atype = atype.." - "..info.subtype;
				end
				if info.rarity then
					local tmp = 5-info.rarity;
					atype = atype.." ("..tmp..") "; -- 10-[0..5] just in case
				end
			end
			
			info = GAS_GetItemInfo(b.itemRef);
			btype = info.type;
			if g_sortBySubType then
				if info.type and info.subtype and info.type~=info.subtype then
					btype = btype.." - "..info.subtype;
				end
				if info.rarity then
					local tmp = 5-info.rarity;
					btype = btype.." ("..tmp..") "; -- 10-[0..5] just in case
				end
			end
			
			if atype and btype  then
				if (atype < btype) then
					return true;
				elseif (atype > btype) then
					return false;
				end
			else
				if atype and not btype then
					return true;
				elseif not atype and btype then
					return false;
				end
			end
		else
		    -- a.itemRef~=nil, b.itemRef==nil
		    return true;
		end
	else
		if b.itemRef then
			return false;
		end
	end
	-- (a.itemRef==nil AND b.itemRef==nil) OR atype==btype
	
	--
	-- Sort by itemName
	--
	if a.itemName then
		if b.itemName then
			if (a.itemName < b.itemName) then
				return true;
			elseif (a.itemName > b.itemName) then
				return false;
			end
		else
			return true;
		end
	else
		if b.itemName then
			return false
		end
	end
	-- (a.itemName==nil AND b.itemName==nil) OR a.itemName==b.itemName
	
	--
	-- Sort by text
	--
	if (a.text and b.text) then
		if (a.text < b.text) then
			return true;
		elseif (b.text < a.text) then
			return false;
		end
	end
	
	--
	-- Sort by owner next
	--
	aowner = a.owner;
	bowner = b.owner;
	if (aowner == nil) then
		aowner = "";
	end
	if (bowner == nil) then
		bowner = "";
	end
	
	if (aowner < bowner) then
		return true;
	elseif (aowner > bowner) then
		return false;
	end
	
	--
	-- Sort by Id
	--
	if (tostring(a.id) < tostring(b.id)) then
		return true;
	elseif (tostring(a.id) > tostring(b.id)) then
		return false;
	end

	-- These ads are identical
	return false;
end

function GuildAds_EventPredicate(a, b)
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
	
	--
	-- Sort by text
	--
	if (a.text and b.text) then
		if (a.text < b.text) then
			return true;
		elseif (b.text < a.text) then
			return false;
		end
	end
	
	-- Get profiles
	pa = GAS_ProfileGet(a.owner);
	pb = GAS_ProfileGet(b.owner);
	
	--
	-- Sort by class
	--
	if pa.class and pb.class then
		if (pa.class < pb.class) then
			return true;
		elseif (pa.class > pb.class) then
			return false;
		end
	end
	
	--
	-- sort by level (low level first)
	--
	if pa.level and pb.level then
		if (pa.level > pb.level) then
			return false;
		elseif (pa.level < pb.level) then
			return true;
		end
	end
	
	--
	-- Sort by name
	--
	if (a.owner > b.owner) then
		return true;
	elseif (a.owner < b.owner) then
		return false;
	end
end

local cacheHigherLevel = {};
local function getHigherlevel(accountid)
	if accountid==nil then
		return nil;
	else
		if cacheHigherLevel[accountid] then
			return cacheHigherLevel[accountid];
		else
			local players = GAS_PlayersByAccount(accountid);
			local bestUser = "";
			local bestUserLevel = 0;
			for _, user in players do
				local profile = GAS_ProfileGet(user);
				if profile.level > bestUserLevel then
					bestUser = user;
					bestUserLevel = profile.level;
				end
			end
			cacheHigherLevel[accountid] = bestUser;
			return bestUser;
		end;
	end;
end;

function GuildAds_CharPredicate(a, b)
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
	
	-- Get profiles
	pa = GAS_ProfileGet(a.owner);
	pb = GAS_ProfileGet(b.owner);
	
	--
	-- GuildAds.Config.GroupByAccount
	--

	if (GuildAds.Config.GroupByAccount) then
		-- sort by accountId
		ha = getHigherlevel(pa.accountid) or "zzzzzz";
		hb = getHigherlevel(pb.accountid) or "zzzzzz";
		if (ha > hb) then
			return false;
		elseif (ha < hb) then
			return true;
		end
	end
	
	--
	-- sort by level (high level first)
	--
	if pa.level and pb.level then
		if (pa.level < pb.level) then
			return false;
		elseif (pa.level > pb.level) then
			return true;
		end
	end
	
	--
	-- Sort by class
	--
	if pa.class and pb.class then
		if (pa.class < pb.class) then
			return true;
		elseif (pa.class > pb.class) then
			return false;
		end
	end
	
	--
	-- Sort by name
	--
	if (a.owner < b.owner) then
		return true;
	elseif (a.owner > b.owner) then
		return false;
	end
	
	return false;
end

---------------------------------------------------------------------------------
--
-- Sort ads table
--
---------------------------------------------------------------------------------
function GuildAds_AdsSort(adtype, ads)
	DEBUG_MSG("GuildAds_AdsSort");
	local size = table.getn(ads);
	if (size) then
		local predicate = nil;
		if (adtype == GUILDADS_MSG_TYPE_ANNONCE) then
			cacheHigherLevel = {};
			predicate = GuildAds_CharPredicate;
		elseif (adtype == GUILDADS_MSG_TYPE_EVENT) then
			predicate = GuildAds_EventPredicate;
		elseif (adtype == GUILDADS_MSG_TYPE_SKILL) then
			predicate = GuildAds_SkillPredicate;
		else
			predicate = GuildAds_AdPredicate;
		end
		table.sort(ads, predicate);
	end	
end

---------------------------------------------------------------------------------
--
-- Output data to text
-- 
---------------------------------------------------------------------------------

function GuildAds_TitleText(adType, groupValue)
	if (adType == GUILDADS_MSG_TYPE_SKILL) then
		return ""; -- nothing, just blank
	elseif (adType == GUILDADS_MSG_TYPE_ANNONCE) then
		if (groupValue == nil) then
			return "";
		elseif (groupValue == "") then
			return GUILDADS_ACCOUNT_NA;
		else
			return getHigherlevel(groupValue);
		end
	elseif (adType == GUILDADS_MSG_TYPE_EVENT) then
		return groupValue.." ("..GuildAds_GetGroupCount(adType, groupValue)..")";
	else
		return groupValue;
	end
end

function GuildAds_AdGetText(adType, ad, tochat)
	if (adType == GUILDADS_MSG_TYPE_SKILL) then
		return "";  -- done with another widget
	elseif (adType == GUILDADS_MSG_TYPE_ANNONCE) then
		return GuildAds_GetPlayerInfo(ad.owner);
		
	elseif (adType == GUILDADS_MSG_TYPE_EVENT) then
		if (ad.owner == nil) then
			return ad.text;
		else
			return GuildAds_GetPlayerInfo(ad.owner);
		end
		
	elseif (adType == GUILDADS_MSG_TYPE_AVAILABLE) or (adType == GUILDADS_MSG_TYPE_REQUEST) then
		local text = "";
		if (ad.itemName) then
			if (tochat) then
				text = GAS_PackLink(ad.itemColor, ad.itemRef, ad.itemName);
			else
				text = "|c"..ad.itemColor.."["..ad.itemName.."]|r";
			end
			if (ad.count) then
				text = text.." x "..ad.count;
			end
		end
		if (ad.text) and (ad.text ~= "") then
			if (text ~= "") then
				text = text..", "
			end
			text = text..ad.text;
		end
		return text
	else
		return ad.text;
	end
end

function GuildAds_GetPlayerInfo(playerName)
	local profile = GAS_ProfileGet(playerName);
	if (profile.level) then
		return LEVEL.." "..profile.level..", "..(GAS_GetRaceText(profile.race) or "")..", "..(GAS_GetClassText(profile.class) or "");
	else
		return "";
	end
end

function GuildAds_GetPlayerGuild(playerName)
	local profile = GAS_ProfileGet(playerName);
	if (profile ~= nil) then
		return profile.guild;
	else
		return nil;
	end
end

---------------------------------------------------------------------------------
--
-- Filter global ad
-- 
---------------------------------------------------------------------------------
GuildAds_ItemFilterFunction = {
	everything = function(ad)
		return true;
	end;
	
	everythingelse = function(ad)
		if ad.itemName then
			return not (
					GuildAds_ItemFilterFunction.monster(ad)
				or GuildAds_ItemFilterFunction.classReagent(ad)
				or GuildAds_ItemFilterFunction.tradeReagent(ad)
				or GuildAds_ItemFilterFunction.vendor(ad)
				or GuildAds_ItemFilterFunction.gather(ad)
			);
		else
			return true;
		end
	end;
	
	monster = function(ad)
		if ad.itemName then
			return ReagentData_IsMonsterDrop(ad.itemName);
		else
			return false;
		end
	end;
	
	classReagent = function (ad)
		if ad.itemName then
			return table.getn(ReagentData_ClassSpellReagent(ad.itemName))>0;
		else
			return false;
		end
	end;
	
	tradeReagent = function(ad)
		if ad.itemName then
			return table.getn(ReagentData_GetProfessions(ad.itemName))>0;
		else
			return false;
		end
	end;
	
	vendor = function(ad)
		if ad.itemName then
			return ReagentData_IsVendorItem(ad.itemName);
		else
			return false;
		end
	end;
	
	gather = function(ad)
		if ad.itemName then
			return table.getn(ReagentData_GatheredBy(ad.itemName)) > 0;
		else
			return false;
		end
	end;
};

local function GuildAds_AdIsVisible(adType, ad)
	if (not (GuildAds.Config.ShowOfflinePlayer or GAS_IsOnline(ad.owner))) then
		return false;
	end
	if (not GuildAds.Config.ShowMyAds) and (g_playerName == ad.owner) then
		return false;
	end
	if (adType == GUILDADS_MSG_TYPE_SKILL) then
		if (GuildAds.Config.Filters[GUILDADS_MSG_TYPE_SKILL][ad.id]) then
			
			return true;
		else
			return false;
		end
	elseif (adType == GUILDADS_MSG_TYPE_REQUEST) or (adType == GUILDADS_MSG_TYPE_AVAILABLE) then
		local dateFilter = GuildAdsConfig_GetProfileValue("HideAdsOlderThan", nil);
		if dateFilter and ad.creationtime then
			local currentDelta = GAS_currentTime()-ad.creationtime;
			-- Hack to avoid wrong display. Obviously there is a bug in offline/online sync about time.
			if currentDelta<0 then
				return false;
			end
			if currentDelta>dateFilter then
				return false;
			end
		end
		for id, name in GuildAds.Config.Filters[adType] do
			filterFunction =  GuildAds_ItemFilterFunction[id];
			if filterFunction and filterFunction(ad) then
				return true;
			end
		end
		return false;
	elseif adType == GUILDADS_MSG_TYPE_ANNONCE then
		if not GuildAdsConfig_GetProfileValue("GuildShowOfflines") and not GAS_IsOnline(ad.owner) then
			return false;
		end
		local profile = GAS_ProfileGet(ad.owner);
		for id, name in GuildAds.Config.Filters[adType] do
			if id == profile.class then
				return true;
			end
		end
		return false;
	elseif adType == GUILDADS_MSG_TYPE_EVENT then
		local dateFilter = GuildAdsConfig_GetProfileValue("HideAdsOlderThan", nil);
		if dateFilter and ad.creationtime then
			local currentDelta = GAS_currentTime()-ad.creationtime;
			-- Hack to avoid wrong display. Obviously there is a bug in offline/online sync about time.
			if currentDelta<0 then
				return false;
			end
			if currentDelta>dateFilter then
				return false;
			end
		end
		-- temporary hack to avoid a bug
		if ad.text == nil then
			return false;
		end
	end
	return true;
end

---------------------------------------------------------------------------------
--
-- GuildAds_GetTableToShow : Return a list of item to Show
-- t[i].title for a title
-- t[i].iAd for a reference to an ad
-- g_TableToShowCache[g_adtype] must be set to nil, when ad are changed
-- (done by listeners)
-- 
---------------------------------------------------------------------------------
local function GetEventGroup(ad)
	if (ad) then
		return ad.text;
	else
		return nil
	end
end

local function GetSkillGroup(ad)
	if (ad) then
		return ad.id;
	else
		return nil;
	end
end

local function GetCharGroup(ad)
	if (ad) and (GuildAds.Config.GroupByAccount) then
		local profile = GAS_ProfileGet(ad.owner);
		if (profile.accountid == nil) then
			return "";
		else
			return profile.accountid;
		end
	else
		return nil;
	end
end

local function GetItemGroup(ad)
	if (ad) and (ad.itemRef) then
		local info = GAS_GetItemInfo(ad.itemRef);
		if info.type then
			if g_sortBySubType and info.subtype and info.subtype~=info.type then
				return info.type.." - "..info.subtype;
			else
				return info.type;
			end
		else
			return UNKNOWNOBJECT;
		end
	else
		return LABEL_NOTE;
	end
end

local GuildAdsGroupBy =
	{
		[GUILDADS_MSG_TYPE_REQUEST] = GetItemGroup;
		[GUILDADS_MSG_TYPE_AVAILABLE] = GetItemGroup;
		[GUILDADS_MSG_TYPE_SKILL] = GetSkillGroup;
		[GUILDADS_MSG_TYPE_EVENT] = GetEventGroup;
		[GUILDADS_MSG_TYPE_ANNONCE] = GetCharGroup;
	};
	
function GuildAdsFrame_ResetCache()
	g_TableToShowCache = {};
	GuildAds_UpdateMemberCount();
end

function GuildAds_GetTableToShow(adType, updateData)
	local adTable = GAS_GetAds(adType);
	
	if (not g_TableToShowCache[adType] or updateData) then
		local getGroup = GuildAdsGroupBy[adType];
		GuildAds_AdsSort(adType, adTable);
		
		local linear = {};
		local groupCount = {};
		local adCount = 0;
		
		local adGroup, groupTitle, currentGroup;
		for adId, ad in adTable do
			if GuildAds_AdIsVisible(adType, ad) then
				if (getGroup) then
					adGroup = getGroup(ad);
					groupTitle = GuildAds_TitleText(adType, adGroup);

					if (currentGroup~=adGroup) then
						tinsert(linear, { groupId = adGroup } );
						currentGroup = adGroup;
					end
					if (not g_HideGroup[adType][adGroup]) then
						tinsert(linear, { adId = adId } );
					end
					
					adCount = adCount + 1;
					if (adGroup) then
						groupCount[adGroup] = (groupCount[adGroup] or 0) + 1;
					end
				else
					tinsert(linear, { adId = adId } );
					adCount = adCount + 1;
				end
			end
		end
		g_TableToShowCache[adType] = {table=linear, adCount=adCount, groupCount=groupCount};
	end
	return g_TableToShowCache[adType].table, adTable, g_TableToShowCache[adType].groupCount, g_TableToShowCache[adType].adCount;
end

function GuildAds_GetGroupCount(adType, groupId)
	if 		g_TableToShowCache[adType]
		and g_TableToShowCache[adType].groupCount 
		and g_TableToShowCache[adType].groupCount[groupId] then
		return g_TableToShowCache[adType].groupCount[groupId];
	else
		return 0;
	end
end

---------------------------------------------------------------------------------
--
-- Update the buttons for a given table
-- 
---------------------------------------------------------------------------------
function GuildAds_UpdateAdButtonForAd(button, selected, adType, ad)
	-- paranoia
	if (not button) then
		DEBUG_MSG("GuildAds_UpdateAdButtonForAd: button is nil");
		error("GuildAds_UpdateAdButtonForAd: button is nil", 2);
		return;
	end

	local buttonName= button:GetName();
	
	local ownerColor = g_OnlineColor[GAS_IsOnline(ad.owner)];
	
	local titleField = buttonName.."Title";
	local ownerField = buttonName.."Owner";
	local textField = buttonName.."Text";
	local classField = buttonName.."Class";
	local raceField = buttonName.."Race";
	local skillBar = buttonName.."SkillBar";
	local skillName = skillBar.."SkillName";
	local skillRank = skillBar.."SkillRank";
	
	button:SetNormalTexture("");
		
	-- color, text, owner
	getglobal(titleField):Hide();
	
	getglobal(ownerField):SetText(ad.owner);
	getglobal(ownerField):SetTextColor(ownerColor["r"], ownerColor["g"], ownerColor["b"]);
	
	-- ask/have ads
	if adType==GUILDADS_MSG_TYPE_REQUEST or adType==GUILDADS_MSG_TYPE_AVAILABLE then
		getglobal(textField):Show();
		getglobal(textField):SetText(GuildAds_AdGetText(adType, ad));
		getglobal(textField):SetTextColor(g_AdColor[adType]["r"], g_AdColor[adType]["g"], g_AdColor[adType]["b"]);
	else
		getglobal(textField):Hide();
	end
		
	-- skill
	if (adType == GUILDADS_MSG_TYPE_SKILL) then
		getglobal(skillBar):Show();
		getglobal(skillName):SetText(GAS_GetSkillText(ad.id));
		if (ad.skillRank) then
			getglobal(skillBar):SetValue(ad.skillRank);
			getglobal(skillRank):SetText(ad.skillRank.."/"..ad.skillMaxRank);
		else
			getglobal(skillBar):SetValue(1);
			getglobal(skillRank):SetText("");					
		end
	else
		getglobal(skillBar):Hide();
	end
	
	-- annonce and event
	local profile 
	if (adType==GUILDADS_MSG_TYPE_ANNONCE or adType==GUILDADS_MSG_TYPE_EVENT) then
		profile = GAS_ProfileGet(ad.owner);
		if (profile.level) then
			getglobal(textField):SetTextColor(1.0, 1.0, 1.0);
			getglobal(textField):Show();
			getglobal(textField):SetText(LEVEL.." "..profile.level);
			getglobal(classField):Show();
			getglobal(classField):SetText(GAS_GetClassText(profile.class));
			getglobal(raceField):Show();
			getglobal(raceField):SetText(GAS_GetRaceText(profile.race));
		end
	end
	if not (profile and profile.level) then
		getglobal(classField):Hide();
		getglobal(raceField):Hide();
	end
		
	-- selected
	if (selected) then
		button:LockHighlight();
	else
		button:UnlockHighlight();
	end
end

function GuildAds_UpdateAdButtonForTitle(button, selected, adType, groupId)
	local buttonName = button:GetName();
		
	local titleField = buttonName.."Title";
	local ownerField = buttonName.."Owner";
	local textField = buttonName.."Text";
	local classField = buttonName.."Class";
	local raceField = buttonName.."Race";
	local skillBar = buttonName.."SkillBar";
	local skillName = skillBar.."SkillName";
	local skillRank = skillBar.."SkillRank";
	
	local title = GuildAds_TitleText(adType, groupId);
	if (title and title ~= "") then
		if (g_HideGroup[adType][groupId]) then
			button:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
		else
			button:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
		end
	else
		button:SetNormalTexture("");
	end
	
	getglobal(textField):SetText("");
	getglobal(ownerField):SetText("");
	getglobal(classField):Hide();
	getglobal(raceField):Hide();
	getglobal(skillBar):Hide();
	
	getglobal(titleField):Show();
	getglobal(titleField):SetText(title);
	
	-- selected
	if (selected) then
		button:LockHighlight();
	else
		button:UnlockHighlight();
	end
end

---------------------------------------------------------------------------------
--
-- Update global ad buttons in the UI
-- 
---------------------------------------------------------------------------------
function GuildAds_UpdateGlobalAdButtons(adType, updateData)
	if (GuildAdsFrame:IsVisible() and (not adType or adType==g_adtype)) then
		DEBUG_MSG("GuildAds_UpdateGlobalAdButtons:"..g_adtype);
		local offset = FauxScrollFrame_GetOffset(GuildAdsGlobalAdScrollFrame);
		
		local linear, adTable = GuildAds_GetTableToShow(g_adtype, updateData);
		local linearSize = table.getn(linear);
	
		-- init
		local i = 1;
		local j = i + offset;
		
		-- for each buttons
		while (i <= GUILDADS_NUM_GLOBAL_AD_BUTTONS) do
			local button = getglobal("GuildAdsGlobalAdButton"..i);
			
			if (j <= linearSize) then
				if (linear[j].groupId) then
					-- update internal data
					button.groupId = linear[j].groupId;
					button.idAd = nil;
					-- create a title
					GuildAds_UpdateAdButtonForTitle(button, g_GlobalTitleSelected==linear[j].groupId, g_adtype, linear[j].groupId);
				elseif (linear[j].adId) then
					-- update internal data
					button.groupId = nil;
					button.idAd = linear[j].adId;
					-- create a ads
					GuildAds_UpdateAdButtonForAd(button, g_GlobalAdSelected == linear[j].adId, g_adtype, adTable[linear[j].adId]);
				end
				button:Show();
				j = j+1;
			else
				button:Hide();
			end
		
			i = i+1;
		end
	
		FauxScrollFrame_Update(GuildAdsGlobalAdScrollFrame, linearSize, GUILDADS_NUM_GLOBAL_AD_BUTTONS, GUILDADS_ADBUTTONSIZEY);
	else
		-- update another tab than the visible one
		if updateData then
			-- but data needs to be reseted
			g_TableToShowCache[adType] = nil;
		end
	end
end

---------------------------------------------------------------------------------
--
-- Update members count
--
---------------------------------------------------------------------------------
function GuildAds_UpdateMemberCount()
	local players = GAS_GetAds(GUILDADS_MSG_TYPE_ANNONCE);
	local count = table.getn(players);
	local countOnline = 0;
	local str;
	if count>1 then
		str = GUILD_TOTAL_P1;
	else
		str = GUILD_TOTAL;
	end
	str = string.format(str,count);
	
	for id, ad in players do
		if GAS_IsOnline(ad.owner) then
			countOnline = countOnline+1;
		end
	end
	
	str = str .." "..string.format(GUILD_TOTALONLINE, countOnline);
	
	GuildAdsCountText:SetText(str);	
end

---------------------------------------------------------------------------------
--
-- Called when a global ad is clicked
-- 
---------------------------------------------------------------------------------
function GuildAds_GlobalAdButton_OnClick(button)
	if this.idAd then
		-- an ad was clicked
		local newSelectedId = this.idAd;
		if (newSelectedId ~= g_GlobalAdSelected) then
			g_GlobalAdSelected = newSelectedId;
			g_GlobalTitleSelected = 0;
			GuildAds_UpdateGlobalAdButtons(g_adtype);
		end
		if button=="LeftButton" then
			local ad = GAS_GetAds(g_adtype)[this.idAd];
			if IsControlKeyDown() then
				if ad.itemRef then
					DressUpItemLink(ad.itemRef);
				end
			elseif IsShiftKeyDown() then
				if ad.owner == g_playerName then
					local myAds = GAS_GetMyAds()[g_adtype];
					local size = table.getn(myAds);
					for index=1,size do
						if myAds[index].id==ad.id then
							GuildAds_MyAdsEdit(index);
						end
					end
				else
					if ad.itemRef then
						GuildAds_MyAdsEdit(nil);
						GuildAds_setEditItem(ad.text, GAS_PackLink(ad.itemColor, ad.itemRef, ad.itemName), ad.texture, ad.count);
					end
				end
			end
		end
	elseif this.groupId then
		-- a title was clicked
		local updateUI = false;
		local updateData;
		if (this.groupId ~= g_GlobalTitleSelected) then
			g_GlobalAdSelected = 0;
			g_GlobalTitleSelected = this.groupId;
			updateUI = true;
		end
		if button == "LeftButton" then
			if (g_HideGroup[g_adtype][this.groupId]) then
				g_HideGroup[g_adtype][this.groupId] = nil;
			else
				if GuildAds_TitleText(g_adtype, this.groupId) ~= "" then
					g_HideGroup[g_adtype][this.groupId] = true;
				end
			end
			updateUI = true;
			updateData = true;
		end
		if updateUI then
			GuildAds_UpdateGlobalAdButtons(g_adtype, updateData);
		end
	end
	if button == "RightButton" then
		GuildAdsFromAdsMenu.groupId = this.groupId;
		ToggleDropDownMenu(1, nil, GuildAdsFromAdsMenu, "cursor");
	end
end

---------------------------------------------------------------------------------
--
-- Called when mouse hover a global ad
-- 
---------------------------------------------------------------------------------
function GuildAds_GameTooltip_AddText(text, r, g, b)
	if text~=nil then
		line = "";
		text = string.gsub(text, "|(%w+)|H([%w:]+)|h([^|]+)|h|r", "%3");
		for word in string.gfind(text,"[^ ]+") do
			if (string.len(line) > MAX_LINE_SIZE) then
				GameTooltip:AddLine(line, r, g, b);
				line = word;
			else
				line = line.." "..word;
			end
		end
		if (string.len(line) > 0) then
			GameTooltip:AddLine(line, r, g, b);
		end
	end
end

function GuildAds_GameTooltip_AddTT(color, ref, name, count)
	if (EnhTooltip and ref and name) then
		local link = GAS_PackLink(color, ref, name);
		
		-- EnhTooltip.TooltipCall(frame,name,link,quality,count,price,forcePopup,hyperlink)
		EnhTooltip.TooltipCall(GameTooltip, name, link, -1, count, 0);
	end
end

function GuildAds_GlobalAdButton_OnEnter(obj)
	local id = nil;
	if (obj == nil) then
		obj = this;
	end;
	local id = obj.idAd;
	if (not id) then
		return;
	end
	
	local adTable = GAS_GetAds(g_adtype);
	local item = adTable[id];
	if (item and item["creationtime"]) then
		local creationtime = GAS_timeToString(item["creationtime"]+0);
		
		local time = string.format(GUILDADS_SINCE, creationtime);
		
		GameTooltip:SetOwner(obj, "ANCHOR_BOTTOMRIGHT");
		
		if item.itemRef then
			GameTooltip:SetHyperlink(item.itemRef);
		else
			if (item.itemName) then
				GameTooltip:AddLine(item.itemName, 1.0, 1.0, 1.0);
			end
		end
		
		if (g_adtype == GUILDADS_MSG_TYPE_ANNONCE) then
			local owner = item.owner;
			local ownerColor = g_OnlineColor[GAS_IsOnline(owner)];
			local profile = GAS_ProfileGet(item.owner);
			local higherlevelOwner;
			local higherColor;
			if profile.accountid then
				higherlevelOwner = getHigherlevel(profile.accountid);
				higherColor = g_OnlineColor[GAS_IsOnline(higherlevelOwner)];
				if higherlevelOwner==owner then
					higherlevelOwner=nil;
				end
			end
		
			if higherlevelOwner then
				GameTooltip:AddDoubleLine(owner, higherlevelOwner, ownerColor.r, ownerColor.g, ownerColor.b, higherColor.r, higherColor.g, higherColor.b);
			else
				GameTooltip:AddLine(owner, ownerColor.r, ownerColor.g, ownerColor.b);
			end
			
			local guildName = GuildAds_GetPlayerGuild(adTable[id].owner);
			if (guildName) then 
				GameTooltip:AddLine(CHAT_GUILD_SEND..guildName, 1.0, 1.0, 1.0);
			end
			
			local flag, message = GAC_GetFlag(item.owner);
			if flag then
				GameTooltip:AddLine(flag..": "..message, 1.0, 1.0, 1.0);
			end
		end
		
		text = adTable[id].text;
		if (text~=nil) then
			GuildAds_GameTooltip_AddText(LABEL_NOTE..": "..text, SinceColor.r, SinceColor.g, SinceColor.b);
		end
		
		if GuildAds_ShowPlayerVersion() then
			local meta = GAC_GetMeta(item.owner);
			if meta and meta.version then
				GameTooltip:AddLine("Version: "..meta.version, 1.0, 1.0, 1.0);
			else
				GameTooltip:AddLine("Version: ?", 1.0, 1.0, 1.0);
			end
		end
		
		GuildAdsPlugin_OnShowAd(GameTooltip, g_adtype, item);
		
		GameTooltip:AddLine(time, SinceColor.r, SinceColor.g, SinceColor.b);
		
		GameTooltip:Show();
		
		GuildAds_GameTooltip_AddTT(adTable[id].itemColor, adTable[id].itemRef, adTable[id].itemName, adTable[id].count or 1);
	end
end

----------------------------------------------------------------------------------
--
-- Get selected global ad 
--
----------------------------------------------------------------------------------
local function getSelectedAd()
	if (g_GlobalAdSelected > 0) then
		local adTable = GAS_GetAds(g_adtype);
		local size = table.getn(adTable);
		if (g_GlobalAdSelected <= size) then
			return adTable[g_GlobalAdSelected];
		end
	end
	return nil;
end

---------------------------------------------------------------------------------
--
-- Called when a my add is clicked
-- 
---------------------------------------------------------------------------------
function GuildAds_MyAdButton_OnClick()
	local id = this:GetID();
	local offset = FauxScrollFrame_GetOffset(GuildAdsMyAdScrollFrame);
	selected = id + offset;
	if (g_mytype == GUILDADS_MY_ADS) then
		if (selected == g_MyAdSelected) then
			GuildAds_MyAdsEdit(nil);
		else
			GuildAds_MyAdsEdit(selected);
		end
	end
end

---------------------------------------------------------------------------------
--
-- Edit one of my ad (or none if nil)
-- 
---------------------------------------------------------------------------------
function GuildAds_MyAdsEdit(id)
	if (id == nil) then
		g_MyAdSelected = 0;
		GuildAds_setEditItem(nil, nil, nil, nil);
		GuildAdsRemoveButton:Disable();
	else
		g_MyAdSelected = id;
		if (g_mytype == GUILDADS_MY_ADS) then
			local myads = GAS_GetMyAds();
			local ad = myads[g_adtype][id];
			local link = nil;
			if (ad.itemName) then
				link = GAS_PackLink(ad.itemColor, ad.itemRef, ad.itemName);
			end
			GuildAds_setEditItem(ad.text, link, ad.texture, ad.count);
		end
		GuildAdsRemoveButton:Enable();
	end
	GuildAds_UpdateMyFrame();
end

----------------------------------------------------------------------------------
--
-- Called when MyAds check button is clicked
-- 
---------------------------------------------------------------------------------
function GuildAds_MyCheckButton_OnClick()
	if ( this:GetChecked() ) then	
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	
	if (g_mytype == GUILDADS_MY_FILTER) then
		GuildAds_MyFilterCheckButton_OnClick();
	else
		GuildAds_MyAdsCheckButton_OnClick();
	end
end

function GuildAds_MyFilterCheckButton_OnClick()
	if (GuildAds.Config.Filters[g_adtype][this.m_filterIndex]) then
		GuildAds.Config.Filters[g_adtype][this.m_filterIndex] = nil;
	else
		GuildAds.Config.Filters[g_adtype][this.m_filterIndex] = true;
	end
	GuildAds_UpdateMyFrame();
	GuildAds_UpdateGlobalAdButtons(g_adtype, true);
end

function GuildAds_MyAdsCheckButton_OnClick()
	if ( this:GetChecked() ) then	
		GAS_EnableMyAd(g_adtype, this.m_AdIndex);
	else
		GAS_DisableMyAd(g_adtype, this.m_AdIndex);
	end
end


---------------------------------------------------------------------------------
function GuildAds_GetAddButton()
	if (g_adtype == GUILDADS_MSG_TYPE_REQUEST) then
		return GuildAdsAddButtonLookFor;
	elseif (g_adtype == GUILDADS_MSG_TYPE_AVAILABLE) then
		return GuildAdsAddButtonAvailable;
	elseif (g_adtype == GUILDADS_MSG_TYPE_EVENT) then
		return GuildAdsAddButtonEvent;
	end
end

function GuildAds_AddButtonUpdate()
	if (GuildAdsEditBox:GetText() ~= "") then
		local addButton = GuildAds_GetAddButton();
		if (addButton) then
			addButton:Enable();
		end
	else
		if (g_editName == nil) then
			local addButton = GuildAds_GetAddButton();
			if (addButton) then
				addButton:Disable();
			end
		end
	end
end

function GuildAds_setEditItem(text, link, texture, count)
	local enableAddButton = false;
	
	if (link) then 
		g_editColor, g_editRef, g_editName = GAS_UnpackLink(link);
	else
		g_editColor = nil;
		g_editRef = nil;
		g_editName = nil;
	end
	
	g_editTexture = texture;
	GuildAdsEditTexture:SetNormalTexture(texture);
	
	if (text) then
		GuildAdsEditBox:SetText(text);
		enableAddButton = true;
	else
		GuildAdsEditBox:SetText("");
	end
	
	if (count) then
		GuildAdsEditCount:SetText(count);
		enableAddButton = true;
	else
		GuildAdsEditCount:SetText("");
	end
	
	if (g_editName) then
		GuildAdsEditTextureName:SetText(g_editName);
		enableAddButton = true;
	else
		GuildAdsEditTextureName:SetText("");
	end
	
	if (g_editColor) then
		local r, g, b = GAS_GetRGBFromHexColor(g_editColor);
		GuildAdsEditTextureName:SetTextColor(r, g, b);
	else
		GuildAdsEditTextureName:SetTextColor(1.0, 1.0, 1.0);
	end
	
	local addButton = GuildAds_GetAddButton();
	if (addButton) then
		if enableAddButton then
			addButton:Enable();
		else
			addButton:Disable();
		end
	end
end

----------------------------------------------------------------------------------
--
-- Add a new entry to MyAds
-- 
---------------------------------------------------------------------------------
function GuildAds_AddButton_OnClick(request_type)
	DEBUG_MSG("GuildAds_AddButton_OnClick("..NoNil(request_type)..")");
	--
	-- Add a new ad if there is text in the edit box
	--
	local text = GuildAdsEditBox:GetText();
	if (text ~= "") or (g_editName ~= "") then
		text = string.sub(text, 1, 200);
		if (request_type == nil) then
			request_type = 1;
		end
		local count = GuildAdsEditCount:GetNumber();
		if (count == 0) then
			count = nil;
		end
		
		if (g_editName or text~="") then
			local resetEdit = true;
			
			if (g_MyAdSelected == 0) then
				if (not GAS_AddMyAd(request_type, text, g_editColor, g_editRef, g_editName, g_editTexture, count)) then
					resetEdit = false;
				end
			else
				GAS_EditMyAd(request_type, g_MyAdSelected, text, g_editColor, g_editRef, g_editName, g_editTexture, count);
			end
		
			-- Reset edit box and update buttons in UI
			if (resetEdit) then
				GuildAdsEditBox:AddHistoryLine(text);
				GuildAds_MyAdsEdit(nil);
			end
		end
	end
end

----------------------------------------------------------------------------------
--
-- Remove the currently selected MyAds
-- 
---------------------------------------------------------------------------------
function GuildAds_RemoveButton_OnClick()
	--
	-- Remove the currently selected ad only if one is selected
	--
	if (g_MyAdSelected > 0) then
		--
		-- Make sure there is something in the table
		--
		local myads = GAS_GetMyAds();
		local size = table.getn(myads[g_adtype]);
		if (g_MyAdSelected <= size) then
			-- Delete ads
			GAS_RemoveMyAd(g_adtype, myads[g_adtype][g_MyAdSelected].id);
			
			-- Adjust the selected index if the last ad in the table was deleted
			if (g_MyAdSelected == size) then
				if (g_MyAdSelected > 1) then
					g_MyAdSelected = g_MyAdSelected - 1;
				else
					g_MyAdSelected = nil;
				end
			end
			
			-- Make sure changes are reflected in the UI
			GuildAds_MyAdsEdit(g_MyAdSelected);
		end
	end
end

---------------------------------------------------------------------------------
--
-- Toggle group by account
-- 
---------------------------------------------------------------------------------
function GuildAdsConfig_SetGroupByAccount(state)
	GuildAds.Config.GroupByAccount = state;
	g_TableToShowCache[GUILDADS_MSG_TYPE_ANNONCE] = nil;
	GuildAds_UpdateGlobalAdButtons(g_adtype, true);
end

---------------------------------------------------------------------------------
--
-- Toggle show offline players
-- 
---------------------------------------------------------------------------------
function GuildAds_ShowOfflinePlayer(state)
	if (state) then
		GuildAds.Config.ShowOfflinePlayer = true;
	else
		GuildAds.Config.ShowOfflinePlayer = false;
	end
	GuildAds_UpdateGlobalAdButtons(g_adtype, true);
end

---------------------------------------------------------------------------------
--
-- Toggle show my ads
-- 
---------------------------------------------------------------------------------
function GuildAds_ShowMyAds(state)
	if state then
		GuildAds.Config.ShowMyAds = true;
	else
		GuildAds.Config.ShowMyAds = false;
	end
	GuildAds_UpdateGlobalAdButtons(g_adtype, true);
end

---------------------------------------------------------------------------------
--
-- Toggle sort by subtype
-- 
---------------------------------------------------------------------------------
function GuildAds_SortBySubType(state)
	if state then
		GuildAdsConfig_SetProfileValue("sortBySubType", true);
	else
		GuildAdsConfig_SetProfileValue("sortBySubType", false);
	end
	g_sortBySubType = state;
	GuildAdsFrame_ResetCache();
	GuildAds_UpdateGlobalAdButtons(g_adtype);
end

function GuildAds_GuildShowOfflines(state)
	if state then
		GuildAdsConfig_SetProfileValue("GuildShowOfflines", true);
	else
		GuildAdsConfig_SetProfileValue("GuildShowOfflines", nil);
	end
	GuildAds_UpdateGlobalAdButtons(g_adtype, true);
end

----------------------------------------------------------------------------------
--
-- Update the contents of the MyAds frame
-- 
---------------------------------------------------------------------------------
function GuildAds_UpdateFiltersFrame()
	local offset = FauxScrollFrame_GetOffset(GuildAdsMyAdScrollFrame);
	
	local filters = g_AdFilters[g_adtype];
	
	if (not GuildAds.Config.Filters[g_adtype]) then
		GuildAds.Config.Filters[g_adtype] = { };
	end
	filtersSelected = GuildAds.Config.Filters[g_adtype];
	
	local size = table.getn(filters);
	local i = 1;
	while (i <= GUILDADS_NUM_MY_AD_BUTTONS) do
		--
		-- Get the index to the ad displayed in this row
		--
		local index = i + offset;
		--
		-- Get the button on this row and set the index
		--
		local button = getglobal("GuildAdsMyAdButton"..i);
		local checkButton = getglobal("GuildAdsMyAdButton"..i.."CheckButton");
		--
		-- Is there a valid ad on this row?
		--
		if (index <= size) then
			-- Set id
			button.m_filterIndex = filters[index].id;
			checkButton.m_filterIndex = filters[index].id;
			
			-- Check the check box if appropriate
			if (filtersSelected[filters[index].id]) then
				checkButton:SetChecked(1);
			else
				checkButton:SetChecked(0);
			end
			checkButton:Show();
			
			-- Update the button text
			button:Show();
			local textField = "GuildAdsMyAdButton"..i.."Text";
			getglobal(textField):SetText(filters[index].name);
			
			-- If this is the selected ad, highlight it
			if (g_MyAdSelected == filters[index].id) then
				button:LockHighlight();
				checkButton:LockHighlight();
			else
				button:UnlockHighlight();
				checkButton:UnlockHighlight();
			end
		else
			-- Hide the button
			button:Hide();
			checkButton:Hide();
		end
		-- Next row
		i = i + 1;
	end
	
	-- Update the scroll bar
	FauxScrollFrame_Update(GuildAdsMyAdScrollFrame, size, GUILDADS_NUM_MY_AD_BUTTONS, GUILDADS_ADBUTTONSIZEY);
end

function GuildAds_UpdateMyAdsFrame()
	--
	-- Sort my ads
	--
	local myads = GAS_GetMyAds();
	GuildAds_AdsSort(g_adtype, myads[g_adtype])
	
	--
	-- Determine where the scroll bar is
	--
	local offset = FauxScrollFrame_GetOffset(GuildAdsMyAdScrollFrame);
	--
	-- Walk through all the rows in the MyAds frame
	--
	local size = table.getn(myads[g_adtype]);
	local i = 1;
	while (i <= GUILDADS_NUM_MY_AD_BUTTONS) do
		--
		-- Get the index to the ad displayed in this row
		--
		local iAd = i + offset;
		--
		-- Get the button on this row and set the index
		--
		local button = getglobal("GuildAdsMyAdButton"..i);
		local checkButton = getglobal("GuildAdsMyAdButton"..i.."CheckButton");
		
		button.m_AdIndex = iAd;
		checkButton.m_AdIndex = iAd;
		--
		-- Is there a valid ad on this row?
		--
		if (iAd <= size) then
			local ad = myads[g_adtype][iAd];
			--
			-- Check the check box if appropriate
			--
			if (ad.m_Enabled) then
				checkButton:SetChecked(1);
			else
				checkButton:SetChecked(0);
			end
			checkButton:Show();
			--
			-- Update the button text
			--
			button:Show();
			local textField = "GuildAdsMyAdButton"..i.."Text";
			getglobal(textField):SetText(GuildAds_AdGetText(g_adtype, ad));
			--
			-- If this is the selected ad, highlight it
			--
			if (g_MyAdSelected == iAd) then
				button:LockHighlight();
				checkButton:LockHighlight();
			else
				button:UnlockHighlight();
				checkButton:UnlockHighlight();
			end
		else
			--
			-- Hide the button
			--
			button:Hide();
			checkButton:Hide();
		end
		--
		-- Next row
		--
		i = i + 1;
	end
	--
	-- Update the scroll bar
	--
	FauxScrollFrame_Update(GuildAdsMyAdScrollFrame, size, GUILDADS_NUM_MY_AD_BUTTONS, GUILDADS_ADBUTTONSIZEY);
end

function GuildAds_UpdateMyFrame()
	if (g_mytype == GUILDADS_MY_FILTER) then
		GuildAds_UpdateFiltersFrame();
	else
		GuildAds_UpdateMyAdsFrame();
	end	
end

function GuildAds_MySelectTab(tab)
	g_mytype = tab;
	if (g_mytype == GUILDADS_MY_ADS) then
		PanelTemplates_SelectTab(GuildAds_MyTab1);
		PanelTemplates_DeselectTab(GuildAds_MyTab2);
	else
		PanelTemplates_SelectTab(GuildAds_MyTab2);
		PanelTemplates_DeselectTab(GuildAds_MyTab1);
	end
	GuildAds_MyAdsEdit(nil);
	GuildAds_UpdateMyFrame();
end

-------- Date filter ------
function GuildAds_DateFilter_OnValueChanged()
	if g_DateFilter[this:GetValue()] then
		GuildAds_DateFilterLabel:SetText(GAS_timeToString(g_DateFilter[this:GetValue()], true));
		GuildAdsConfig_SetProfileValue("HideAdsOlderThan", g_DateFilter[this:GetValue()]);
	else
		GuildAds_DateFilterLabel:SetText(GUILDADS_ITEMS.everything);
		GuildAdsConfig_SetProfileValue("HideAdsOlderThan", nil);
	end
	GuildAdsFrame_ResetCache();
	GuildAds_UpdateGlobalAdButtons(g_adtype);
end


-------- Minimap button ------
function GuildAdsMinimapButton_Update()
	if GuildAds and GuildAds.Config then
		GuildAdsMinimapButton:SetPoint( "TOPLEFT", "Minimap", "TOPLEFT",
			55 - ( ( GuildAds.Config.MinimapRadiusOffset ) * cos( GuildAds.Config.MinimapArcOffset ) ),
			( ( GuildAds.Config.MinimapRadiusOffset ) * sin( GuildAds.Config.MinimapArcOffset ) ) - 55
		);
	end
end

------ Bouton instance --------
function GuildAds_Event_ZoneDropDown_OnShow()
   	UIDropDownMenu_Initialize(GuildAds_Event_ZoneDropDown, GuildAds_Event_ZoneDropDown_Init);
	UIDropDownMenu_SetText(GUILDADS_EVENTS_TITLE, GuildAds_Event_ZoneDropDown);
	UIDropDownMenu_SetWidth(100, GuildAds_Event_ZoneDropDown);
end

function GuildAds_Event_ZoneDropDown_OnClick()
	GuildAdsEditBox:SetText(this.value);
end

function GuildAds_Event_ZoneDropDown_Init()
	for k,instance in GUILDADS_EVENTS do
		local info = { };
		info.text = instance;
		info.value = instance;
		info.func = GuildAds_Event_ZoneDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end


---------- Right click on an ads -----------------------
function GuildAdsFromAdsMenu_OnLoad()
	HideDropDownMenu(1);
	GuildAdsFromAdsMenu.initialize = GuildAdsFromAdsMenu_Initialize;
	GuildAdsFromAdsMenu.displayMode = "MENU";
	GuildAdsFromAdsMenu.name = "Titre";
end

function GuildAdsFromAdsMenu_Initialize()
	if (GuildAdsFromAdsMenu.groupId) then
		if (g_adtype == GUILDADS_MSG_TYPE_EVENT) then
			GuildAdsFromAdsMenu_InitializeEvent();
		end
	else
		GuildAdsFromAdsMenu_InitializeOwner();
	end
end

function GuildAdsFromAdsMenu_InitializeOwner()
	local ad = getSelectedAd();
	
	info = { };
	info.text =  ad.owner;
	info.isTitle = true;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info, 1);
	
	info = { };
	info.text =  WHISPER_MESSAGE;
	info.notCheckable = 1;
	info.value = ad;
	info.func = GuildAdsFromAdsMenu_Whisper_OnClick;
	--[[
	if not GAS_IsOnline(ad.owner) then
		info.disabled = 1
	end
	]]
	UIDropDownMenu_AddButton(info, 1);
	
	info = { };
	info.text =  INSPECT;
	info.notCheckable = 1;
	info.value = ad;
	info.func = GuildAdsFromAdsMenu_Inspect_OnClick;
	UIDropDownMenu_AddButton(info, 1);
	
	info = { };
	info.text =  CHAT_INVITE_SEND;
	info.notCheckable = 1;
	info.value = ad;
	info.func = GuildAdsFromAdsMenu_Invite_OnClick;
	UIDropDownMenu_AddButton(info, 1);
	
	info = { };
	info.text =  WHO;
	info.notCheckable = 1;
	info.value = ad;
	info.func = GuildAdsFromAdsMenu_Who_OnClick;
	UIDropDownMenu_AddButton(info, 1);
	
	GuildAdsPlugin_OnShowContextMenu(g_adtype, ad);

	if g_adtype==GUILDADS_MSG_TYPE_ANNONCE then
		info = { };
		info.text =  IGNORE;
		info.notCheckable = 1;
		info.value = ad;
		info.func = GuildAdsFromAdsMenu_Ignore_OnClick;
		UIDropDownMenu_AddButton(info, 1);
	end
	
	
	info = { };
	info.text = CANCEL;
	info.notCheckable = 1;
	info.func = GuildAdsFromAdsMenu_Cancel_OnClick;
	UIDropDownMenu_AddButton(info, 1);
end

---------- Right click on an ads (event) -----------------------
function GuildAdsFromAdsMenu_InitializeEvent()
	info = { };
	info.text =  GuildAdsFromAdsMenu.groupId;
	info.isTitle = true;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info, 1);

	info = { };
	info.text =  GUILDADS_BUTTON_ADDEVENT;
	info.notCheckable = 1;
	info.func = GuildAdsFromAdsMenu_Event_OnClick;
	info.value = GuildAdsFromAdsMenu.groupId;
	UIDropDownMenu_AddButton(info, 1);
	
	info = { };
	info.text = CANCEL;
	info.notCheckable = 1;
	info.func = GuildAdsFromAdsMenu_Cancel_OnClick;
	UIDropDownMenu_AddButton(info, 1);
end

function GuildAdsFromAdsMenu_Cancel_OnClick()
	HideDropDownMenu(1);
end

function GuildAdsFromAdsMenu_Event_OnClick()
	GAS_AddMyAd(GUILDADS_MSG_TYPE_EVENT, this.value);
end

function GuildAdsFromAdsMenu_Whisper_OnClick()
	local ad = this.value;
	if (ad) then
		if ( not ChatFrameEditBox:IsVisible() ) then
			ChatFrame_OpenChat("/w "..ad.owner.." ");
		else
			ChatFrameEditBox:SetText("/w "..ad.owner.." ");
		end
		ChatEdit_ParseText(ChatFrame1.editBox, 0);
	end
end

function GuildAdsFromAdsMenu_Inspect_OnClick()
	local ad = this.value;
	if (ad) then
		GuildAdsInspectUser(ad.owner);
	end
end

function GuildAdsFromAdsMenu_Invite_OnClick()
	local ad = this.value;
	if (ad) then
		InviteByName(ad.owner);
	end
end

function GuildAdsFromAdsMenu_Who_OnClick()
	local ad = this.value;
	if (ad) then
		local text = ChatFrameEditBox:GetText();
		ChatFrameEditBox:SetText("/who "..ad.owner);
		ChatEdit_SendText(ChatFrameEditBox);
		ChatFrameEditBox:SetText(text);
	end
end

function GuildAdsFromAdsMenu_Ignore_OnClick()
	local ad = this.value;
	if (ad) then
		GAS_ProfileIgnore(ad.owner, true);
		GuildAdsFrame_ResetCache();
	end
end