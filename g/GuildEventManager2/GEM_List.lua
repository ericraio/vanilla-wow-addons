--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Events list - By Alexandre Flament & Kiki
]]

GEM_SORTBY_DATE = "date";
GEM_SORTBY_WHERE = "where";
GEM_SORTBY_LEADER = "leader";
GEM_SORTBY_COUNT = "count";
GEM_SORTBY_MINMAX = "minmax";

local MAXDISPLAY_EVENT  = 12;
local sortType = GEM_SORTBY_DATE;
local sortDir = true;
local UIEvents = nil;
local UIEventsRefresh = true;
local selectEvent = nil;
local GEMList_PreviousTab = 1;

GEM_Classes = {};
GEM_Classes["WARRIOR"] = GEM_TEXT_CLASS_WARRIOR;
GEM_Classes["PALADIN"] = GEM_TEXT_CLASS_PALADIN;
GEM_Classes["SHAMAN"] = GEM_TEXT_CLASS_SHAMAN;
GEM_Classes["ROGUE"] = GEM_TEXT_CLASS_ROGUE;
GEM_Classes["MAGE"] = GEM_TEXT_CLASS_MAGE;
GEM_Classes["WARLOCK"] = GEM_TEXT_CLASS_WARLOCK;
GEM_Classes["HUNTER"] = GEM_TEXT_CLASS_HUNTER;
GEM_Classes["DRUID"] = GEM_TEXT_CLASS_DRUID;
GEM_Classes["PRIEST"] = GEM_TEXT_CLASS_PRIEST;
GEMList_CurrentGroupIDMustReset = false;
GEMList_CurrentGroupID = nil;
GEMList_CurrentGroupIsRaid = false;
GEMList_MustConvertToRaid = false;
GEM_NewEvents = {};

function GEMList_GetCursorWidgetPosition()
  local abs_x,abs_y = GetCursorPosition();
  local x = this:GetLeft();
  local y = this:GetTop();
  
  return abs_x-x,abs_y-y;
end

--[[
  Tabs handling function
]]
function GEMList_SelectTab(tab)
  PanelTemplates_SetTab(GEMListMiddleFrame, tab);
  local TabFrames = {
    [1] = "GEMListDetailsFrame",
    [2] = "GEMListLimitationsFrame",
    [3] = "GEMListAdminFrame"
  };
  for id, name in TabFrames do
    if (id == tab) then
      getglobal(name):Show();
    else
      getglobal(name):Hide();
    end
  end
  GEMList_PreviousTab = tab;
end

local function GEMList_Middle_ShowFrame()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  
  if(event ~= nil)
  then
--[[    if(GEM_IsMyReroll(event.leader))
    then
      GEMListMiddleFrameTab3:Show();
    else
      GEMListMiddleFrameTab3:Hide();
      if(GEMList_PreviousTab == 3)
      then
        GEMList_PreviousTab = 1;
      end
    end]]
    PanelTemplates_SetNumTabs(GEMListMiddleFrame,3);
    GEMList_SelectTab(GEMList_PreviousTab);
    GEMListMiddleFrame:Show();
  else
    GEMListMiddleFrame:Hide();
  end
end


--[[
  Details Tab functions
]]
function GEMListDetails_OnShow()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil)
  then
    GEMListDetailsFrame_Descr_Value:SetText(event.ev_comment);
    local plugin = GEM_SUB_GetPlugin(event.sorttype);
    if(plugin == nil)
    then
      GEMListDetailsFrame_SortType_Value:SetText(GEM_TEXT_DETAILS_UNKNOWN.." ("..event.sorttype..")");
    else
      if(plugin.Help)
      then
        GEMListDetailsFrame_SortType_Value:SetText(plugin.Name.." : "..plugin.Help);
      else
        GEMListDetailsFrame_SortType_Value:SetText(plugin.Name);
      end
    end
  end
end


--[[
  Limitations Tab functions
]]
local function GEMListLimit_GetRangeValue(tab,name,range)
  if(tab[name] == nil)
  then
    return -1;
  end
  if(tab[name][range] == nil)
  then
    return -1;
  end
  return tab[name][range];
end

local function GEMListLimit_SetClassValues(name)
  local wgt_name = "GEMListLimitItem_"..name;
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil)
  then
    local min,max,titular,substitute,replacement;

    min = GEMListLimit_GetRangeValue(event.classes,name,"min");
    max = GEMListLimit_GetRangeValue(event.classes,name,"max");
    titular = GEMListLimit_GetRangeValue(event.classes,name,"tit_count");
    substitute = GEMListLimit_GetRangeValue(event.classes,name,"sub_count");
    replacement = GEMListLimit_GetRangeValue(event.classes,name,"repl_count");

    getglobal(wgt_name.."Class"):SetText(GEM_Classes[name]);
    if(min == -1)
    then
      getglobal(wgt_name.."Min"):SetText("-");
      getglobal(wgt_name.."Min"):SetTextColor(1,1,1);
      getglobal(wgt_name.."Titular"):SetTextColor(1,1,1);
    else
      getglobal(wgt_name.."Min"):SetText(min);
      if(titular < min)
      then
        getglobal(wgt_name.."Min"):SetTextColor(1,0,0);
        getglobal(wgt_name.."Titular"):SetTextColor(1,0,0);
      else
        getglobal(wgt_name.."Min"):SetTextColor(0,1,0);
        getglobal(wgt_name.."Titular"):SetTextColor(0,1,0);
      end
    end
    if(max == -1)
    then
      getglobal(wgt_name.."Max"):SetText("-");
      getglobal(wgt_name.."Max"):SetTextColor(1,1,1);
      getglobal(wgt_name.."Substitute"):SetTextColor(1,1,1);
    else
      getglobal(wgt_name.."Max"):SetText(max);
      if(substitute > 0)
      then
        getglobal(wgt_name.."Max"):SetTextColor(0.2,0.2,1);
        getglobal(wgt_name.."Substitute"):SetTextColor(0.2,0.2,1);
      else
        getglobal(wgt_name.."Max"):SetTextColor(1,1,1);
        getglobal(wgt_name.."Substitute"):SetTextColor(1,1,1);
      end
    end
    if(titular == -1)
    then
      getglobal(wgt_name.."Titular"):SetText("n/a");
    else
      getglobal(wgt_name.."Titular"):SetText(titular);
    end
    if(substitute == -1)
    then
      getglobal(wgt_name.."Substitute"):SetText("n/a");
    else
      getglobal(wgt_name.."Substitute"):SetText(substitute);
    end
    getglobal(wgt_name.."Replacement"):SetText(replacement);
  end
end

function GEMListLimitations_OnShow()
  if(not GEMListLimitationsFrame:IsVisible()) then
    return;
  end
  GEMListLimit_SetClassValues("WARRIOR");
  GEMListLimit_SetClassValues("PALADIN");
  GEMListLimit_SetClassValues("SHAMAN");
  GEMListLimit_SetClassValues("ROGUE");
  GEMListLimit_SetClassValues("MAGE");
  GEMListLimit_SetClassValues("WARLOCK");
  GEMListLimit_SetClassValues("HUNTER");
  GEMListLimit_SetClassValues("DRUID");
  GEMListLimit_SetClassValues("PRIEST");
end


--[[
  Admin Tab functions
]]

GEMADMIN_SORTBY_PLACE = "place";
GEMADMIN_SORTBY_NAME = "name";
GEMADMIN_SORTBY_GUILD = "guild";
GEMADMIN_SORTBY_CLASS = "class";
GEMADMIN_SORTBY_LEVEL = "level";

local MAXDISPLAY_LIST  = 10;
local sortTypeAdmin = GEMADMIN_SORTBY_PLACE;
local sortDirAdmin = true;
local UIList = nil;
local UIListAdminRefresh = true;
local selectAdminItem = nil;

function GEMListAdmin_EventOnClick(button)
  selectAdminItem = this.pl_name;
  GEMListAdmin_UpdatePlayersList();
  if(button == "RightButton")
  then
    ToggleDropDownMenu(1,nil,GEMListAdminMenu,"cursor");
  end
end

function GEMListAdmin_EventOnHover()
	if (selectEvent ~= nil and GEM_Events.realms[GEM_Realm].events[selectEvent] ~= nil) then
		local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
                local pl_name = getglobal(this:GetName().."Name"):GetText();
		if(pl_name and event.players[pl_name] ~= nil and event.players[pl_name].comment ~= nil and event.players[pl_name].comment ~= "")
		then
			GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
			GameTooltip:ClearLines();
			local lines = 0;
			lines = GEMList_AddTooltipText("|cff" .. "00AAFF" .. GEM_TEXT_ADMIN_COMMENT .. "|r",lines);
			lines = GEMList_AddTooltipText("|cff" .. "FFFFFF" .. event.players[pl_name].comment .. "|r",lines,"FFFFFF");
			GameTooltip:Show();
		end
	end
end

function GEMListAdmin_GetList()
  if (UIListAdminRefresh) then 
    local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
    UIList = {};

    if(event ~= nil and event.closed_comment == nil)
    then
      GEM_CheckEventHasChannel(event);
      local players = GEM_Players[GEM_Realm][event.channel];
      if(players == nil) then players = {}; end;

      for pos,tab in event.titulars do
        if(tab.guild == GEM_NA_FORMAT and players[tab.name]) then tab.guild = players[tab.name].guild; end;
        tinsert(UIList, {place = "P"..pos; name = tab.name; guild=tab.guild; class=tab.class; level=tab.level});
      end
  
      for pos,tab in event.substitutes do
        if(tab.guild == GEM_NA_FORMAT and players[tab.name]) then tab.guild = players[tab.name].guild; end;
        tinsert(UIList, {place = "S"..pos; name = tab.name; guild=tab.guild; class=tab.class; level=tab.level});
      end
  
      for pos,tab in event.replacements do
        if(tab.guild == GEM_NA_FORMAT and players[tab.name]) then tab.guild = players[tab.name].guild; end;
        tinsert(UIList, {place = "R"..pos; name = tab.name; guild=tab.guild; class=tab.class; level=tab.level});
      end

      -- If leader is not online, add speculative list
      if(not GEM_IsPlayerConnected(event.channel,event.leader) and GEM_Events.realms[GEM_Realm].commands[selectEvent])
      then
        for cmdid,cmdtab in GEM_Events.realms[GEM_Realm].commands[selectEvent].cmds
        do
          if(cmdtab.cmd == GEM_CMD_CMD_SUBSCRIBE and cmdtab.acked == 0) -- A subscribe not acked ?
          then
            tinsert(UIList, {place = "NA"; name = cmdtab.params[5]; guild=cmdtab.params[7]; class=cmdtab.params[6]; level=tonumber(cmdtab.params[8],10); stamp=cmdtab.stamp});
          end
        end
      end

      table.sort(UIList, GEMListAdmin_Predicate);
      if(not sortDirAdmin)
      then
        UIList = GEMList_InvertList(UIList);
      end
    end
    UIListAdminRefresh = false;
  end
  
  return UIList;
end

function GEMListAdmin_UpdatePlayersList()
	if(not GEMListAdminFrame:IsVisible()) then
		return;
	end
	local list = GEMListAdmin_GetList();
	local size = table.getn(list);
	
	local offset = FauxScrollFrame_GetOffset(GEMListAdminItemScrollFrame);
        local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
        local iamassistant = false;
        if(event == nil)
        then
          UIEventsRefresh = true;
          GEMList_UpdateEventList();
          return;
        end
	numButtons = MAXDISPLAY_LIST;
	i = 1;

	if(GEM_IsMyReroll(event.leader) and GEM_IsChannelJoined(event.channel)) -- If I'm leader of this event AND my toon has joined the channel
	then
		GEMListAdminFrameClose:Enable();
		GEMListAdminFrameEdit:Enable();
		GEMListAdminFrameGroup:Enable();
		GEMListAdminFrameAddExt:Enable();
		GEMListAdminFrameIgnore:Disable();
		GEMListAdminFrameBanned:Enable();
		iamassistant = true;
	else
		GEMListAdminFrameClose:Disable();
		GEMListAdminFrameEdit:Disable();
		GEMListAdminFrameAddExt:Disable();
		if(not GEM_IsMyReroll(event.leader))
		then
			GEMListAdminFrameIgnore:Enable();
		end
		GEMListAdminFrameBanned:Disable();
		if(GEM_Events.realms[GEM_Realm].assistant[event.id] and GEM_IsChannelJoined(event.channel)) -- If I'm assistant AND my toon has joined the channel
		then
			GEMListAdminFrameGroup:Enable();
			iamassistant = true;
		else
			GEMListAdminFrameGroup:Disable();
		end
	end
	while (i <= numButtons) do
		local j = i + offset
		local prefix = "GEMListAdminItem"..i;
		local button = getglobal(prefix);
		
		if (j <= size) then
			button.pl_name = list[j].name;
			if((GEM_IsMyReroll(list[j].name) and iamassistant) or -- Myself and I'm assistant (assistant is set if I'm the leader)
			  (list[j].name == event.leader) or -- This is the leader
			  (GEM_IsMyReroll(event.leader) and event.assistants ~= nil and event.assistants[list[j].name])) -- I'm the leader, and there is an assistants list, and this subscriber is assistant
			then
				getglobal(prefix.."Place"):SetTextColor(0,1,0);
			else
				getglobal(prefix.."Place"):SetTextColor(1,1,1);
			end
			getglobal(prefix.."Place"):SetText(list[j].place);
			if(GEM_IsPlayerConnected(event.channel,list[j].name))
			then
				if(GEM_IsMyReroll(list[j].name) or GEM_IsPlayerInGroup(list[j].name))
				then
					getglobal(prefix.."Name"):SetTextColor(0,1,0); -- Green
				else
					getglobal(prefix.."Name"):SetTextColor(0.4,0.4,1); -- blue
				end
			else
				getglobal(prefix.."Name"):SetTextColor(1,1,1); -- White
			end
			getglobal(prefix.."Name"):SetText(list[j].name);
			getglobal(prefix.."Guild"):SetText(list[j].guild);
			getglobal(prefix.."Class"):SetText(GEM_Classes[list[j].class]);
			getglobal(prefix.."Level"):SetText(list[j].level);
			button:Show();
			
			-- selected
			if (GEM_IsMyReroll(event.leader) and selectAdminItem == list[j].name and not GEM_IsMyReroll(list[j].name)) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
		else
			button.pl_name = nil;
			button:Hide();
		end
		
		i = i + 1;
	end
	
	FauxScrollFrame_Update(GEMListAdminItemScrollFrame, size, MAXDISPLAY_LIST, 17);
	
end

_GEMList_PlaceConvert = {};
_GEMList_PlaceConvert["P"] = 100;
_GEMList_PlaceConvert["S"] = 200;
_GEMList_PlaceConvert["R"] = 300;
_GEMList_PlaceConvert["NA"] = 400;

function GEMListAdmin_PredicatePlace(a, b)
  local _,_,type1,num1 = string.find(a.place,"([^%d]+)(%d*)");
  local _,_,type2,num2 = string.find(b.place,"([^%d]+)(%d*)");
  
  if(type1 == nil or type2 == nil)
  then
    if (a.place < b.place) then
      return true;
    elseif (a.place > b.place) then
      return false;
    end
  else
    if(num1 == "") then num1 = a.stamp; end;
    if(num2 == "") then num2 = b.stamp; end;
    local v1 = _GEMList_PlaceConvert[type1] + tonumber(num1,10);
    local v2 = _GEMList_PlaceConvert[type2] + tonumber(num2,10);
    if(v1 < v2) then
      return true;
    elseif(v1 > v2) then
      return false;
    end
  end
  
  return GEMListAdmin_PredicateName(a, b);
end

function GEMListAdmin_PredicateName(a, b)
	if (a.name < b.name) then
		return true;
	elseif (a.name > b.name) then
		return false;
	end
	
	return GEMListAdmin_PredicateGuild(a, b);
end

function GEMListAdmin_PredicateGuild(a, b)
	if (a.guild == nil or b.guild == nil) then
		if(a.guild == nil and b.guild == nil) then
			return GEMListAdmin_PredicateClass(a, b);
		elseif(a.guild == nil) then
			return false;
		else
			return true;
		end
	end
	if (a.guild < b.guild) then
		return true;
	elseif (a.guild > b.guild) then
		return false;
	end
	
	return GEMListAdmin_PredicateClass(a, b);
end

function GEMListAdmin_PredicateClass(a, b)
	if (a.class < b.class) then
		return true;
	elseif (a.class > b.class) then
		return false;
	end
	
	return GEMListAdmin_PredicateLevel(a, b);
end

function GEMListAdmin_PredicateLevel(a, b)
	if (a.level < b.level) then
		return true;
	elseif (a.level > b.level) then
		return false;
	end
	
	return false;
end

function GEMListAdmin_Predicate(a, b)
	-- a ou b est nil
	if (a == nil) then
		if (b == nil) then
			return false;
		else
			return true;
		end
	elseif (b == nil) then
		return false;
	end
	
	GEMADMIN_SORTBY = {
		[GEMADMIN_SORTBY_PLACE] = GEMListAdmin_PredicatePlace,
		[GEMADMIN_SORTBY_NAME] = GEMListAdmin_PredicateName,
		[GEMADMIN_SORTBY_GUILD] = GEMListAdmin_PredicateGuild,
		[GEMADMIN_SORTBY_CLASS] = GEMListAdmin_PredicateClass,
		[GEMADMIN_SORTBY_LEVEL] = GEMListAdmin_PredicateLevel
	};
	
	predicate = GEMADMIN_SORTBY[sortTypeAdmin];
	return predicate(a,b);
end

function GEMListAdmin_SortBy(aSortType, aSortDir)
  sortTypeAdmin = aSortType;
  sortDirAdmin = aSortDir;
  UIListAdminRefresh = true;
  GEMListAdmin_UpdatePlayersList();
end

function GEMListAdmin_OnShow()
  UIListAdminRefresh = true;
  GEMListAdmin_UpdatePlayersList();
end

StaticPopupDialogs["GEM_CONFIRM_CLOSE"] = {
  text = TEXT(GEM_TEXT_ADMIN_CLOSE_CONFIRM),
  button1 = TEXT(OKAY),
  button2 = TEXT(CANCEL),
  hasEditBox = 1,
  maxLetters = 100,
  OnAccept = function()
    local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
    GEM_EVT_CloseEvent(this:GetParent().data,text);
  end,
  EditBoxOnEnterPressed = function()
    local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
    GEM_EVT_CloseEvent(this:GetParent().data,text);
  end,
  OnShow = function()
    getglobal(this:GetName().."EditBox"):SetFocus();
  end,
  OnHide = function()
    if ( ChatFrameEditBox:IsVisible() ) then
      ChatFrameEditBox:SetFocus();
    end
    getglobal(this:GetName().."EditBox"):SetText("");
  end,
  timeout = 0,
  exclusive = 1
};

function GEMListAdmin_CloseOnClick()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil)
  then
    local dialogFrame = StaticPopup_Show("GEM_CONFIRM_CLOSE");
    if(dialogFrame)
    then
      dialogFrame.data = event.id;
    end
  end
end

function GEMListAdmin_EditOnClick()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil)
  then
    GEMNew_Create:SetText(GEM_TEXT_MODIFY);
    GEMNew_AutoMembers:Disable();
    if(GEMNewAutoMembersFrame:IsVisible())
    then
      GEMNewAutoMembersFrame:Hide();
    end
    GEMMain_SelectTab(2);
    GEMNew_LoadEvent(event);
  end
end

function GEMListAdmin_External_Set(infos, user_data)
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil)
  then
    if(infos.level < event.min_lvl or infos.level > event.max_lvl)
    then
      GEM_ChatPrint(GEM_TEXT_EXTERNAL_ERR_LEVEL);
      return;
    end
    GEM_SUB_CreateSubscriber(event.id,time(),infos.name,infos.class,infos.guild,infos.level,infos.comment,infos.forcesub,infos.forcetit);
  end
end

function GEM_IsPlayerInGroup(pl_name)
  if(GEMList_CurrentGroupIsRaid)
  then
    for i = 1, 40 do
      local name = GetRaidRosterInfo(i);
      if(name and name == pl_name)
      then
        return true;
      end
    end
  else
    for i = 1,4 do
      local name = UnitName("party"..i);
      if(name and name == pl_name)
      then
        return true;
      end
    end
  end
  return false;
end

function GEMListAdmin_GroupOnClick()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil)
  then
    if(GEMList_CurrentGroupIDMustReset)
    then
      GEMList_CurrentGroupIDMustReset = false;
      GEMList_CurrentGroupID = nil;
      GEMList_CurrentGroupIsRaid = false;
      GEMList_MustConvertToRaid = false;
    end
    if(GEMList_CurrentGroupID ~= nil) -- Check current group and raid
    then
      if(GEMList_CurrentGroupID ~= event.id)
      then
        GEM_ChatPrint(GEM_TEXT_ADMIN_ERR_LEAVE_GROUP);
        return;
      end
    else -- Check if already grouped
      GEMList_CurrentGroupID = event.id;
      if(GetNumPartyMembers() ~= 0 or UnitInRaid("player"))
      then
        GEM_ChatPrint(GEM_TEXT_ADMIN_ERR_ALREADY_GROUP);
        if(GetNumRaidMembers() ~= 0)
        then
          GEMList_CurrentGroupIsRaid = true;
          GEM_ChatDebug(GEM_DEBUG_GLOBAL,"I'm in a raid !");
        end
      end
    end
    -- Ok let's group titulars
    for i,tab in event.titulars
    do
      if(GEMList_MustConvertToRaid == true)
      then
        ConvertToRaid();
        GEMList_CurrentGroupIsRaid = true;
        GEM_ChatDebug(GEM_DEBUG_GLOBAL,"Converted to raid !");
        GEMList_MustConvertToRaid = false;
      end
      GEM_ChatDebug(GEM_DEBUG_GLOBAL,"Group : Checking "..tab.name);
      if(tab.name ~= GEM_PlayerName and not GEM_IsPlayerInGroup(tab.name))
      then
        GEM_ChatDebug(GEM_DEBUG_GLOBAL,"Group : "..tab.name.." not in group, inviting");
        InviteByName(tab.name);
      end
    end
  end
end

function GEMListAdmin_AddExtOnClick()
  GEMExternal_Choose(GEMListAdmin_External_Set,GEM_TEXT_EXTERNAL_HEADER,{true,true});
end

StaticPopupDialogs["GEM_CONFIRM_IGNORE"] = {
  text = TEXT(GEM_TEXT_ADMIN_IGNORE_CONFIRM),
  button1 = TEXT(OKAY),
  button2 = TEXT(CANCEL),
  OnAccept = function()
    local event = GEM_Events.realms[GEM_Realm].events[this:GetParent().data.ev_id];
    if(event ~= nil)
    then
      GEM_Events.realms[GEM_Realm].ignore[event.id] = 1;
      GEM_EVT_ClearEvent(event.id,"Ignored",true);
      GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,event.id);
    end
  end,
  timeout = 0
};

function GEMListAdmin_IgnoreOnClick()
  if (selectEvent and not GEM_EVT_CheckExpiredEvent(selectEvent)) then
    local dialogFrame = StaticPopup_Show("GEM_CONFIRM_IGNORE");
    if(dialogFrame)
    then
      dialogFrame.data = { ev_id=selectEvent };
    end
  end
end

function GEMListAdmin_BannedOnClick()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(GEMListBannedFrame:IsVisible() or event == nil)
  then
    return;
  end
  GEMListBannedFrame.Event = selectEvent;
  GEMListBannedFrame:Show();
end


function GEMListAdminMenu_OnLoad()
  HideDropDownMenu(1);
  GEMListAdminMenu.initialize = GEMListAdminMenu_Initialize;
  GEMListAdminMenu.displayMode = "MENU";
  GEMListAdminMenu.name = "Titre";
end

function GEMListAdminMenu_Initialize()
  info = { };
  info.text =  selectAdminItem;
  info.isTitle = true;
  info.notCheckable = 1;
  UIDropDownMenu_AddButton(info,1);

  info = { };
  info.text =  WHISPER_MESSAGE;
  info.notCheckable = 1;
  info.value = selectAdminItem;
  info.func = GEMListAdminMenu_Whisper_OnClick;
  if(GEM_IsMyReroll(selectAdminItem))
  then
    info.disabled = 1;
  end
  UIDropDownMenu_AddButton(info,1);

  info = { };
  info.text =  GROUP_INVITE;
  info.notCheckable = 1;
  info.value = selectAdminItem;
  info.func = GEMListAdminMenu_GroupInvite_OnClick;
  if(GEM_IsMyReroll(selectAdminItem) or GEM_IsPlayerInGroup(selectAdminItem))
  then
    info.disabled = 1;
  end
  UIDropDownMenu_AddButton(info,1);

  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil and selectAdminItem ~= nil and selectAdminItem ~= "" and GEM_IsMyReroll(event.leader))
  then
    info = { };
    info.text =  GEM_TEXT_ADMIN_ASSISTANT;
    info.notCheckable = 1;
    info.value = selectAdminItem;
    info.func = GEMListAdminMenu_Assistant_OnClick;
    if(event.assistants == nil or event.assistants[selectAdminItem] or GEM_IsMyReroll(selectAdminItem))
    then
      info.disabled = 1;
    end
    UIDropDownMenu_AddButton(info,1);
  
    info = { };
    info.text =  GEM_TEXT_ADMIN_KICK;
    info.notCheckable = 1;
    info.value = selectAdminItem;
    info.disabled = GEM_IsMyReroll(selectAdminItem);
    info.func = GEMListAdminMenu_Kick_OnClick;
    UIDropDownMenu_AddButton(info,1);
  
    info = { };
    info.text =  GEM_TEXT_ADMIN_BAN;
    info.notCheckable = 1;
    info.value = selectAdminItem;
    info.disabled = GEM_IsMyReroll(selectAdminItem);
    info.func = GEMListAdminMenu_Ban_OnClick;
    UIDropDownMenu_AddButton(info,1);
    
    info = { };
    info.text =  GEM_TEXT_FORCETIT;
    info.value = selectAdminItem;
    info.func = GEMListAdminMenu_Forcetit_OnClick;
    info.checked = event.players[selectAdminItem].forcetit == 1;
    UIDropDownMenu_AddButton(info,1);

    info = { };
    info.text =  GEM_TEXT_FORCESUB;
    info.value = selectAdminItem;
    info.func = GEMListAdminMenu_Forcesub_OnClick;
    info.checked = event.players[selectAdminItem].forcesub == 1;
    UIDropDownMenu_AddButton(info,1);

    info = { };
    info.text =  GEM_TEXT_SETLEADER;
    info.notCheckable = 1;
    info.value = selectAdminItem;
    info.disabled = GEM_IsMyReroll(selectAdminItem);
    info.func = GEMListAdminMenu_SetLeader_OnClick;
    UIDropDownMenu_AddButton(info,1);

  end

  info = { };
  info.text = CANCEL;
  info.notCheckable = 1;
  info.func = GEMListAdminMenu_Cancel_OnClick;
  UIDropDownMenu_AddButton(info,1);
end

function GEMListAdminMenu_Cancel_OnClick()
  HideDropDownMenu(1);
end

function GEMListAdminMenu_Whisper_OnClick()
  local pl_name = this.value;
  if(pl_name)
  then
    if(not ChatFrameEditBox:IsVisible())
    then
      ChatFrame_OpenChat("/w "..pl_name.." ");
    else
      ChatFrameEditBox:SetText("/w "..pl_name.." ");
    end
    ChatEdit_ParseText(ChatFrame1.editBox,0);
  end
end

function GEMListAdminMenu_GroupInvite_OnClick()
  local pl_name = this.value;
  if(pl_name)
  then
    InviteByName(pl_name);
  end
end

StaticPopupDialogs["GEM_KICK_DIALOG"] = {
  text = TEXT(GEM_TEXT_ADMIN_KICK),
  button1 = TEXT(ACCEPT),
  button2 = TEXT(CANCEL),
  hasEditBox = 1,
  maxLetters = 100,
  OnAccept = function()
    local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
    GEM_COM_KickPlayer(this:GetParent().data.ev_id,this:GetParent().data.pl_name,text);
  end,
  EditBoxOnEnterPressed = function()
    local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
    GEM_COM_KickPlayer(this:GetParent().data.ev_id,this:GetParent().data.pl_name,text);
  end,
  OnShow = function()
    getglobal(this:GetName().."EditBox"):SetFocus();
  end,
  OnHide = function()
    if ( ChatFrameEditBox:IsVisible() ) then
      ChatFrameEditBox:SetFocus();
    end
    getglobal(this:GetName().."EditBox"):SetText("");
  end,
  timeout = 0,
  exclusive = 1
};

function GEMListAdminMenu_Assistant_OnClick()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil and selectAdminItem ~= nil and selectAdminItem ~= "")
  then
    GEM_COM_AddAssistant(event.id,selectAdminItem);
    GEM_NotifyGUI(GEM_NOTIFY_MY_SUBSCRIPTION,selectEvent);
  end
end

function GEMListAdminMenu_Kick_OnClick()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil and selectAdminItem ~= nil and selectAdminItem ~= "")
  then
    local dialogFrame = StaticPopup_Show("GEM_KICK_DIALOG");
    if(dialogFrame)
    then
      dialogFrame.data = { ev_id=event.id, pl_name=selectAdminItem };
    end
  end
end

StaticPopupDialogs["GEM_BAN_DIALOG"] = {
  text = TEXT(GEM_TEXT_ADMIN_BAN),
  button1 = TEXT(ACCEPT),
  button2 = TEXT(CANCEL),
  hasEditBox = 1,
  maxLetters = 100,
  OnAccept = function()
    local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
    GEM_COM_BanPlayer(this:GetParent().data.ev_id,this:GetParent().data.pl_name,text);
  end,
  EditBoxOnEnterPressed = function()
    local text = getglobal(this:GetParent():GetName().."EditBox"):GetText();
    GEM_COM_BanPlayer(this:GetParent().data.ev_id,this:GetParent().data.pl_name,text);
  end,
  OnShow = function()
    getglobal(this:GetName().."EditBox"):SetFocus();
  end,
  OnHide = function()
    if ( ChatFrameEditBox:IsVisible() ) then
      ChatFrameEditBox:SetFocus();
    end
    getglobal(this:GetName().."EditBox"):SetText("");
  end,
  timeout = 0,
  exclusive = 1
};

function GEMListAdminMenu_Ban_OnClick()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil and selectAdminItem ~= nil and selectAdminItem ~= "")
  then
    local dialogFrame = StaticPopup_Show("GEM_BAN_DIALOG");
    if(dialogFrame)
    then
      dialogFrame.data = { ev_id=event.id, pl_name=selectAdminItem };
    end
  end
end

function GEMListAdminMenu_Forcetit_OnClick()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil and selectAdminItem ~= nil and selectAdminItem ~= "")
  then
    if(GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcesub == 1) -- Was in replacement
    then
      GEM_SUB_RemoveFromReplacementList(event.id,selectAdminItem,GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].class);
      GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcesub = 0;
      GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcetit = 1;
    elseif(GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcetit == 1) -- Was forced titular
    then
      GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcetit = 0;
    elseif(GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcetit == 0) -- Was not forced titular
    then
      GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcetit = 1;
    end
    GEM_SUB_SortPlayers(event.id); -- Sort players
    GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,event.id); -- Redraw
  end
end

function GEMListAdminMenu_Forcesub_OnClick()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil and selectAdminItem ~= nil and selectAdminItem ~= "")
  then
    GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcetit = 0; -- Clear forcetit status
    if(GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcesub == 1) -- Was in replacement
    then
      GEM_SUB_RemoveFromReplacementList(event.id,selectAdminItem,GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].class);
      GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcesub = 0;
    else -- Move to replacement
      GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].forcesub = 1;
      GEM_SUB_AddToReplacementList(event.id,selectAdminItem,GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].guild,GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].class,GEM_Events.realms[GEM_Realm].events[event.id].players[selectAdminItem].level);
    end
    GEM_SUB_SortPlayers(event.id); -- Sort players
    GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,event.id); -- Redraw
  end
end

StaticPopupDialogs["GEM_CONFIRM_SETLEADER"] = {
  text = TEXT(GEM_TEXT_ADMIN_SETLEADER_CONFIRM),
  button1 = TEXT(OKAY),
  button2 = TEXT(CANCEL),
  OnAccept = function()
    GEM_COM_ChangeLeader(this:GetParent().data.ev_id,this:GetParent().data.pl_name);
  end,
  timeout = 0
};

function GEMListAdminMenu_SetLeader_OnClick()
  local event = GEM_Events.realms[GEM_Realm].events[selectEvent];
  if(event ~= nil and selectAdminItem ~= nil and selectAdminItem ~= "")
  then
    local dialogFrame = StaticPopup_Show("GEM_CONFIRM_SETLEADER");
    if(dialogFrame)
    then
      dialogFrame.data = { ev_id=event.id, pl_name=selectAdminItem };
    end
  end
end


--[[
  List Functions
]]

function GEMList_InvertList(list)
  local newlist = {};
  local count = table.getn(list);
  for i=1,count
  do
    table.insert(newlist,list[count+1-i]);
  end
  return newlist;
end

function GEMSetColumnWidth( width, frame )
	if ( not frame ) then
    		frame = this;
	end
	frame:SetWidth(width);
	getglobal(frame:GetName().."Middle"):SetWidth(width - 9);
end

function _GEMList_AddBanKickTooltip(event,lines)
  if(GEM_Events.realms[GEM_Realm].banned[event.id] ~= nil)
  then
    return GEMList_AddTooltipText("|cff" .. "FF0000" .. GEM_TEXT_TOOLTIP_BANNED .. GEM_Events.realms[GEM_Realm].banned[event.id] .. "|r",lines,"FF0000");
  elseif(GEM_Events.realms[GEM_Realm].kicked[event.id] ~= nil)
  then
    return GEMList_AddTooltipText("|cff" .. "800000" .. GEM_TEXT_TOOLTIP_KICKED .. GEM_Events.realms[GEM_Realm].kicked[event.id] .. "|r",lines,"800000");
  end
  return lines;
end

function _GEMList_AddClosedTooltip(event,lines)
  if(GEM_Events.realms[GEM_Realm].events[event.id].closed_comment ~= nil)
  then
    return GEMList_AddTooltipText("|cff" .. "A0A0A0" .. GEM_TEXT_TOOLTIP_CLOSED .. GEM_Events.realms[GEM_Realm].events[event.id].closed_comment .. "|r",lines,"A0A0A0");
  end
  return lines;
end

local function _GEMList_AddTooltipLine(text,lines)
  lines = lines + 1;
  local tooltip = getglobal("GameTooltipTextLeft"..lines);
  GameTooltip:AddLine(".");
  tooltip:SetText(text);
  return lines;
end

function GEMList_AddTooltipText(text,lines,multi_line_color)
  local _GEM_MAX_TT_LINE_LENGTH = 100;
  local added = false;
  while(string.len(text) > _GEM_MAX_TT_LINE_LENGTH)
  do
    local add = 0;
    while(string.byte(text,_GEM_MAX_TT_LINE_LENGTH+add) and string.byte(text,_GEM_MAX_TT_LINE_LENGTH+add) ~= 32)
    do
      add = add + 1;
    end
    if(string.byte(text,_GEM_MAX_TT_LINE_LENGTH+add) == nil) -- Don't create new line if we reach eol
    then
      break;
    end
    local submsg = string.sub(text,1,_GEM_MAX_TT_LINE_LENGTH+add);
    if(added and multi_line_color)
    then
      submsg = "|cff"..multi_line_color..submsg;
    end
    lines = _GEMList_AddTooltipLine(submsg,lines);
    added = true;
    text = string.sub(text,_GEM_MAX_TT_LINE_LENGTH+add+1);
  end
  if(added and multi_line_color)
  then
    text = "|cff"..multi_line_color..text;
  end
  lines = _GEMList_AddTooltipLine(text,lines);
  
  return lines;
end

function GEMList_EventOnHover()
	local ev_id = this.eventid;
	if (ev_id ~= nil and GEM_Events.realms[GEM_Realm].events[ev_id] ~= nil) then
		local event = GEM_Events.realms[GEM_Realm].events[ev_id];
		GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
		GameTooltip:ClearLines();
                local color = "E0C010";
                local color1 = "00AAFF";
                local color2 = "E0C010";
                local color3 = "FFFFFF";
                if(event.closed_comment)
                then
                  color = "706005";
                  color1 = "005588";
                  color2 = "706005";
                  color3 = "888888";
                end
                local lines = 0;

                local alias = event.channel;
                if(GEM_COM_Channels[event.channel] and GEM_COM_Channels[event.channel].alias and GEM_COM_Channels[event.channel].alias ~= "")
                then
                  alias = GEM_COM_Channels[event.channel].alias;
                end
                lines = GEMList_AddTooltipText("|cff" .. color1 .. event.ev_place .. " |cff"..color3.."(" .. string.format(GEM_TEXT_EVT_CHANNEL,alias) .. ")|r",lines,color3);
                lines = GEMList_AddTooltipText("|cff" .. color2 .. event.leader .. "|r (" .. GEM_ConvertDateFormat(date(GEM_Events.DateFormat,event.ev_date + GEM_ComputeHourOffset()))..")",lines);
		if(event.ev_comment ~= "")
		then
			lines = GEMList_AddTooltipText("|cff" .. color3 .. GEM_TEXT_COMMENT .. " : "..event.ev_comment.."|r",lines,color3);
		end
		lines = _GEMList_AddBanKickTooltip(event,lines);
		lines = _GEMList_AddClosedTooltip(event,lines);
		GameTooltip:Show();
	end
end

function GEMList_EventOnClick()
	selectEvent = this.eventid;
	GEMList_UpdateEventList();
	if(GEMList_PreviousTab == 1) -- Details
	then
		GEMListDetails_OnShow();
	elseif(GEMList_PreviousTab == 2) -- Limits
	then
		GEMListLimitations_OnShow();
	elseif(GEMList_PreviousTab == 3) -- Admin
	then
		UIListAdminRefresh = true;
		GEMListAdmin_UpdatePlayersList()
	end
end

function GEMList_PredicateDate(a, b)
	if (a.event.ev_date < b.event.ev_date) then
		return true;
	elseif (a.event.ev_date > b.event.ev_date) then
		return false;
	end
	
	return GEMList_PredicateWhere(a, b);
end

function GEMList_PredicateWhere(a, b)
	if (a.event.ev_place < b.event.ev_place) then
		return true;
	elseif (a.event.ev_place > b.event.ev_place) then
		return false;
	end
	
	return GEMList_PredicateLeader(a, b);
end

function GEMList_PredicateLeader(a, b)
	if (a.event.leader < b.event.leader) then
		return true;
	elseif (a.event.leader > b.event.leader) then
		return false;
	end
	
	return GEMList_PredicateCount(a, b);
end

function GEMList_PredicateCount(a, b)
	if (a.event.titular_count < b.event.titular_count) then
		return true;
	elseif (a.event.titular_count > b.event.titular_count) then
		return false;
	end
	
	return GEMList_PredicateMinMax(a, b);
end

function GEMList_PredicateMinMax(a, b)
	if (a.event.max_lvl < b.event.max_lvl) then
		return true;
	elseif (a.event.max_lvl > b.event.max_lvl) then
		return false;
	end
	
	return false;
end

function GEMList_Predicate(a, b)
	-- a ou b est nil
	if (a == nil) then
		if (b == nil) then
			return false;
		else
			return true;
		end
	elseif (b == nil) then
		return false;
	end
	
	GEM_SORTBY = {
		[GEM_SORTBY_DATE] = GEMList_PredicateDate,
		[GEM_SORTBY_WHERE] = GEMList_PredicateWhere,
		[GEM_SORTBY_LEADER] = GEMList_PredicateLeader,
		[GEM_SORTBY_COUNT] = GEMList_PredicateCount,
		[GEM_SORTBY_MINMAX] = GEMList_PredicateMinMax
	};
	
	predicate = GEM_SORTBY[sortType];
	return predicate(a,b);
end

function GEMList_SortBy(aSortType, aSortDir)
	sortType = aSortType;
	sortDir = aSortDir;
	UIEventsRefresh = true;
	GEMList_UpdateEventList();
end

function GEMList_GetEvent()
  if(UIEventsRefresh)
  then 
    UIEvents = {};
    local selected = GEM_GetSelectedReroll();
    local infos = GEM_Events.realms[GEM_Realm].my_names[selected];
    for ev_id,event in GEM_Events.realms[GEM_Realm].events
    do
      if((GEM_Events.realms[GEM_Realm].ignore[event.id] == nil) and -- Not in ignore list
         (GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].FilterEvents == nil or GEM_IsMyReroll(event.leader) or (infos.level >= event.min_lvl and infos.level <= event.max_lvl))) -- And level is ok
      then
        tinsert(UIEvents, {id = ev_id; event = event});
      end
    end
    table.sort(UIEvents, GEMList_Predicate);
    if(not sortDir)
    then
      UIEvents = GEMList_InvertList(UIEvents);
    end
    UIEventsRefresh = false;
  end

  return UIEvents;
end

function GEM_ConvertDateFormat(df)
  for src,dest in GEM_DATE_CONVERT
  do
    df = string.gsub(df,src,dest);
  end
  return df;
end

function GEM_IsNewEvent(id)
  for _,n in GEM_NewEvents
  do
    if(n == id) then return true; end
  end
  return false;
end

function GEM_RemoveNewEvent(id)
  for i,n in GEM_NewEvents
  do
    if(n == id) then tremove(GEM_NewEvents,i); return; end
  end
end

function GEMList_UpdateEventList()
	if(not GEMListFrame:IsVisible()) then
		return;
	end
	local events = GEMList_GetEvent();
	local size = table.getn(events);
	local enable_subscribe = false;
	local enable_unsubscribe = false;
	local sel_event = nil;
	
	local enableEventActions = false;
	local enableClosedActions = false;
	local offset = FauxScrollFrame_GetOffset(GEMEventItemScrollFrame);
	numButtons = MAXDISPLAY_EVENT;
	i = 1;

	local selected = GEM_GetSelectedReroll();
	local infos = GEM_Events.realms[GEM_Realm].my_names[selected];
	while (i <= numButtons) do
		local j = i + offset
		local prefix = "GEMEventItem"..i;
		local button = getglobal(prefix);
		
		if (j <= size) then
			local id = events[j].id;
			local event = events[j].event;
			local banned = GEM_Events.realms[GEM_Realm].banned[event.id] ~= nil;
			local kicked = GEM_Events.realms[GEM_Realm].kicked[event.id] ~= nil;
			local level_ok = infos.level >= event.min_lvl and infos.level <= event.max_lvl;
			if(infos.level == 0) -- No level, set as OK
			then
				level_ok = true;
			end

			button.eventid = id;
			getglobal(prefix.."Date"):SetText(GEM_ConvertDateFormat(date(GEM_Events.DateFormat,event.ev_date + GEM_ComputeHourOffset())));
			getglobal(prefix.."Where"):SetText(event.ev_place);
			getglobal(prefix.."Leader"):SetText(event.leader);
			getglobal(prefix.."Date"):SetTextColor(0.9,0.8,0.10);
			getglobal(prefix.."RangeLevel"):SetTextColor(1,1,1);

			if(GEM_IsNewEvent(id))
			then
				getglobal(prefix.."Where"):SetTextColor(0,1,0);
			else
				getglobal(prefix.."Where"):SetTextColor(1,1,1);
			end
			if(GEM_IsPlayerConnected(event.channel,event.leader))
			then
				getglobal(prefix.."Leader"):SetTextColor(0,1,0);
			else
				getglobal(prefix.."Leader"):SetTextColor(1,1,1);
			end
			if(GEM_Events.realms[GEM_Realm].subscribed[event.id] ~= nil) -- I subscribed for this event
			then
				if(selectEvent == id) -- This event is the selected one
				then
					enable_unsubscribe = true;
					getglobal("GEMListFrameForcesub"):Disable();
					getglobal("GEMListFrameComment"):EnableKeyboard(0);
					getglobal("GEMListFrameComment"):EnableMouse(0);
					getglobal("GEMListFrameComment"):SetTextColor(0.5,0.5,0.5);
					getglobal("GEMListFrameComment"):SetText(GEM_Events.realms[GEM_Realm].subscribed[event.id].comment);
					if(GEM_Events.realms[GEM_Realm].subscribed[event.id].forcesub == 1)
					then
						getglobal("GEMListFrameForcesub"):SetChecked(1);
					else
						getglobal("GEMListFrameForcesub"):SetChecked(0);
					end
					getglobal("GEMListFrameCommentString"):SetTextColor(0.4,0.4,0.4);
					getglobal("GEMListFrameForcesubString"):SetTextColor(0.4,0.4,0.4);
					GEM_SetSelectedReroll(GEM_Events.realms[GEM_Realm].subscribed[event.id].name);
				end
				if(GEM_Events.realms[GEM_Realm].subscribed[event.id].state == "1") -- Titular
				then
					getglobal(prefix.."Count"):SetTextColor(0,1,0); -- Green
				elseif(GEM_Events.realms[GEM_Realm].subscribed[event.id].state == "2") -- Substitute
				then
					getglobal(prefix.."Count"):SetTextColor(0.2,0.2,1); -- Blue
				elseif(GEM_Events.realms[GEM_Realm].subscribed[event.id].state == "3") -- Replacement
				then
					getglobal(prefix.."Count"):SetTextColor(0.8,0.8,0); -- Yellow
				else -- Not Acked
					getglobal(prefix.."Count"):SetTextColor(0.3,0.3,0.3); -- Dark Grey
				end
			elseif(GEM_IsMyReroll(event.leader)) -- I'm the leader
			then
				getglobal(prefix.."Count"):SetTextColor(0,1,0);
				if(selectEvent == id) -- This event is the selected one
				then
					getglobal("GEMListFrameForcesub"):Disable();
					getglobal("GEMListFrameComment"):EnableKeyboard(0);
					getglobal("GEMListFrameComment"):EnableMouse(0);
					getglobal("GEMListFrameComment"):SetTextColor(0.6,0.6,0.6);
					getglobal("GEMListFrameComment"):SetText("");
					getglobal("GEMListFrameForcesub"):SetChecked(0);
					getglobal("GEMListFrameCommentString"):SetTextColor(0.4,0.4,0.4);
					getglobal("GEMListFrameForcesubString"):SetTextColor(0.4,0.4,0.4);
				end
			else -- Not subscribed
				if(selectEvent == id) -- This event is the selected one
				then
					if(not banned and level_ok) -- Not banned, and level range is ok
					then
						enable_subscribe = true;
					end
					getglobal("GEMListFrameForcesub"):Enable();
					getglobal("GEMListFrameComment"):EnableKeyboard(1);
					getglobal("GEMListFrameComment"):EnableMouse(1);
					getglobal("GEMListFrameComment"):SetTextColor(1,1,1);
					getglobal("GEMListFrameComment"):SetText("");
					getglobal("GEMListFrameForcesub"):SetChecked(0);
					getglobal("GEMListFrameCommentString"):SetTextColor(0.90,0.75,0);
					getglobal("GEMListFrameForcesubString"):SetTextColor(0.90,0.75,0);
				end
				if(banned)
				then
					getglobal(prefix.."Count"):SetTextColor(1,0,0);
				elseif(kicked)
				then
					getglobal(prefix.."Count"):SetTextColor(0.5,0,0);
				elseif(not level_ok)
				then
					getglobal(prefix.."Count"):SetTextColor(0.7,0,0.8);
				else
					getglobal(prefix.."Count"):SetTextColor(1,1,1);
				end
			end
			local subs = table.getn(event.substitutes);
			if(subs ~= 0)
			then
				getglobal(prefix.."Count"):SetText(event.titular_count.."/"..event.max_count.." ("..subs..")");
			else
				getglobal(prefix.."Count"):SetText(event.titular_count.."/"..event.max_count);
			end
			getglobal(prefix.."RangeLevel"):SetText(event.min_lvl.." - "..event.max_lvl);
			button:Show();
			
			if(event.closed_comment)
			then
				getglobal(prefix.."Date"):SetTextColor(0.5,0.5,0.5);
				getglobal(prefix.."Where"):SetTextColor(0.5,0.5,0.5);
				getglobal(prefix.."Leader"):SetTextColor(0.5,0.5,0.5);
				getglobal(prefix.."Count"):SetTextColor(0.5,0.5,0.5);
				getglobal(prefix.."RangeLevel"):SetTextColor(0.5,0.5,0.5);
			end
			-- selected
			if (selectEvent == id) then
				button:LockHighlight();
				sel_event = event;
				if(event.closed_comment) then
					enableClosedActions = true;
				else
					enableEventActions = true;
				end
			else
				button:UnlockHighlight();
			end
		else
			button.eventid = nil;
			button:Hide();
		end
		
		i = i + 1;
	end
	
	FauxScrollFrame_Update(GEMEventItemScrollFrame, size, MAXDISPLAY_EVENT, 17);
	
	if (enableEventActions) then
		GEMListFrameCommentString:Show();
		GEMListFrameForcesubString:Show();
		GEMListFrameComment:Show();
		GEMListFrameForcesub:Show();
		GEMList_Middle_ShowFrame();
		GEMListFrameSubscribe:Show();
		GEMListFrameUnsubscribe:Show();
		GEMListFrameRerollDropDown:Show();
		GEMListFrameUnclose:Hide();
		GEMListFrameEventIgnore:Hide();
		GEMListFrameDelete:Hide();
		GEMListFrameRecover:Hide();
		GEMListFrameUnsubscribe:Disable();
		GEMListFrameSubscribe:Disable();
		if(enable_subscribe) then
			GEMListFrameSubscribe:Enable();
		end
		if(enable_unsubscribe) then
			GEMListFrameUnsubscribe:Enable();
		end
	else
		GEMListFrameCommentString:Hide();
		GEMListFrameForcesubString:Hide();
		GEMListFrameComment:Hide();
		GEMListFrameForcesub:Hide();
		GEMListMiddleFrame:Hide();
		GEMListFrameSubscribe:Hide();
		GEMListFrameUnsubscribe:Hide();
		GEMListFrameRerollDropDown:Hide();
		GEMListFrameUnclose:Hide();
		GEMListFrameEventIgnore:Hide();
		GEMListFrameDelete:Hide();
		GEMListFrameRecover:Hide();
		if(enableClosedActions) then
			if(sel_event.crashed) then
				if(not GEM_EVT_CheckExpiredEvent(sel_event.id) and GEM_IsChannelJoined(sel_event.channel)) then
					GEMListFrameRecover:Show();
				end
			elseif(GEM_IsMyReroll(sel_event.leader) and not GEM_EVT_CheckExpiredEvent(sel_event.id) and GEM_IsChannelJoined(sel_event.channel)) then
				GEMListFrameUnclose:Show();
				GEMListFrameDelete:Show();
			else
				GEMListFrameEventIgnore:Show();
			end
		else
			GEMListFrameUnclose:Hide();
			GEMListFrameEventIgnore:Hide();
			GEMListFrameDelete:Hide();
			GEMListFrameRecover:Hide();
		end
	end
	GEM_NewEvents = {};
end

function GEMList_SubscribeOnClick()
  if (selectEvent and not GEM_EVT_CheckExpiredEvent(selectEvent)) then
    local forcesub = GEMListFrameForcesub:GetChecked();
    if(forcesub == nil) then forcesub = 0; end;
    GEM_COM_Subscribe(selectEvent,forcesub,string.gsub(GEMListFrameComment:GetText(),"[%c]"," "));
  end
end

function GEMList_UnsubscribeOnClick()
  if (selectEvent and not GEM_EVT_CheckExpiredEvent(selectEvent)) then
    GEM_COM_Unsubscribe(selectEvent,"Test unsubscribe comment");
  end
end

function GEMList_UncloseOnClick()
  if (selectEvent and not GEM_EVT_CheckExpiredEvent(selectEvent)) then
    GEM_EVT_UnCloseEvent(selectEvent);
    GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,selectEvent);
  end
end

StaticPopupDialogs["GEM_CONFIRM_DELETEEVENT"] = {
  text = TEXT(GEM_TEXT_DELETE_CONFIRM),
  button1 = TEXT(OKAY),
  button2 = TEXT(CANCEL),
  OnAccept = function()
    local event = GEM_Events.realms[GEM_Realm].events[this:GetParent().data.ev_id];
    if(event ~= nil)
    then
      event.ev_date = time() - GEM_ExpirationTimeSelf * 2;
      event.update_time = time();
      GEM_COM_BroadcastEvent(event); -- Force brodcast (or it will be deleted before update)
      GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,event.id);
    end
  end,
  timeout = 0
};

function GEMList_DeleteOnClick()
  if (selectEvent and not GEM_EVT_CheckExpiredEvent(selectEvent)) then
    local dialogFrame = StaticPopup_Show("GEM_CONFIRM_DELETEEVENT");
    if(dialogFrame)
    then
      dialogFrame.data = { ev_id=selectEvent };
    end
  end
end

function GEMList_RecoverOnClick()
  if (selectEvent and not GEM_EVT_CheckExpiredEvent(selectEvent)) then
    if(GEM_SUB_RecoverSubscribers(selectEvent)) then
      GEM_EVT_UnCloseEvent(selectEvent);
      GEM_NotifyGUI(GEM_NOTIFY_EVENT_UPDATE,selectEvent);
      GEM_ChatPrint("Event recovered using known informations !");
    else
      GEM_ChatPrint("Failed to recover the event !");
    end
  end
end

--
function GEM_SetSelectedReroll(pl_name)
  if(GEM_Events.realms[GEM_Realm].my_names[pl_name] == nil)
  then
    return;
  end
  getglobal("GEMListFrameRerollDropDown").name = pl_name;
  getglobal("GEMNewRerollDropDown").name = pl_name;
  UIDropDownMenu_SetText(pl_name,GEMListFrameRerollDropDown);
end

function GEM_GetSelectedReroll()
  local name;
  if(GEMNewRerollDropDown:IsVisible())
  then
    name = getglobal("GEMNewRerollDropDown").name;
  else
    name = getglobal("GEMListFrameRerollDropDown").name;
  end
  if(name == nil)
  then
    name = GEM_PlayerName;
  end
  if(GEM_Events.realms[GEM_Realm].my_names[name] == nil)
  then
    GEM_ChatPrint("GEM_GetSelectedReroll : WARNING : my_names not initialized for "..name);
    return nil;
  end
  if(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].guild == nil or GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].guild == "")
  then
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].guild = GetGuildInfo("player");
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].level = UnitLevel("player");
  end
  return name;
end

function GEMListFrameRerollDropDown_OnShow()
  if(getglobal("GEMListFrameRerollDropDown").name == nil)
  then
    getglobal("GEMListFrameRerollDropDown").name = GEM_PlayerName;
  end
  UIDropDownMenu_Initialize(GEMListFrameRerollDropDown, GEMListFrameRerollDropDown_Init);
  UIDropDownMenu_SetText(getglobal("GEMListFrameRerollDropDown").name, GEMListFrameRerollDropDown);
  UIDropDownMenu_SetWidth(80, GEMListFrameRerollDropDown);
end

function GEMListFrameRerollDropDown_OnClick()
  getglobal("GEMListFrameRerollDropDown").name = this.value;
  getglobal("GEMNewRerollDropDown").name = this.value;
  UIDropDownMenu_SetText(this.value,GEMListFrameRerollDropDown);
  GEMList_Notify(GEM_NOTIFY_MY_SUBSCRIPTION,""); -- Force update of the list
end

function GEMListFrameRerollDropDown_OnClickBadValue()
  GEM_ChatPrint(GEM_TEXT_REROLL_ERR_SELECT);
end

function GEMListFrameRerollDropDown_Init()
  for name,tab in GEM_Events.realms[GEM_Realm].my_names do
    local info = { };
    info.text = name;
    info.value = name;
    if(not GEM_IsChannelInRerollList(name,GEM_GetSelectedChannel()))
    then
      info.disabled = 1;
      info.func = GEMListFrameRerollDropDown_OnClickBadValue;
    else
      info.func = GEMListFrameRerollDropDown_OnClick;
    end
    UIDropDownMenu_AddButton(info);
  end
end

function GEMList_OnShow()
  GEM_EVT_CheckExpiredEvents();
  GEMList_UpdateEventList();
end

function GEMList_OnLoad()
  GEM_SetNotifyCallback(GEMList_Notify);
end

local function _GEMList_RefreshLists(ev_id)
  if(ev_id == nil or ev_id == "")
  then
    ev_id = selectEvent;
  end
  if(ev_id ~= nil and GEM_Events.realms[GEM_Realm].events[ev_id] == nil) -- id no longer exists
  then
    selectEvent = nil;
  end
  UIEventsRefresh = true;
  GEMList_UpdateEventList();
  if(ev_id == selectEvent) -- Event selected
  then
    if(GEMList_PreviousTab == 1) -- Details
    then
      GEMListDetails_OnShow();
    elseif(GEMList_PreviousTab == 2) -- Limits
    then
      GEMListLimitations_OnShow();
    elseif(GEMList_PreviousTab == 3) -- Admin
    then
      UIListAdminRefresh = true;
      GEMListAdmin_UpdatePlayersList()
    end
  end
end

local _GEMList_Blink = true;
function GEMList_NotifyNewEvent()
  if(table.getn(GEM_NewEvents) == 0) -- Reset texture
  then
    GEMMinimapButtonText:SetText("");
    GEMMinimapButtonTexture:SetAlpha(1);
    return;
  end

  GEMMinimapButtonText:SetText("N");
  if(_GEMList_Blink)
  then
    _GEMList_Blink = false;
    GEMMinimapButtonTexture:SetAlpha(0.7);
  else
    _GEMList_Blink = true;
    GEMMinimapButtonTexture:SetAlpha(1);
  end
  GEMSystem_Schedule(1,GEMList_NotifyNewEvent);
end

function GEMList_Notify(cmd,...)
	if(cmd == GEM_NOTIFY_NEW_EVENT) then
		UIEventsRefresh = true;
		GEMList_UpdateEventList();
		GEM_ChatDebug(GEM_DEBUG_GUI,"GEMList_Notify : New Event : "..arg[1]);
		if(not GEMMainFrame:IsVisible()) then
			if(not GEM_IsNewEvent(arg[1]))
			then
				tinsert(GEM_NewEvents,arg[1]);
				if(table.getn(GEM_NewEvents) == 1) -- Start schedule if first new event
				then
					GEMSystem_Schedule(1,GEMList_NotifyNewEvent);
					_GEMList_Blink = true;
				end
			end
		end
	elseif(cmd == GEM_NOTIFY_CLOSE_EVENT) then
		UIEventsRefresh = true;
		GEMList_UpdateEventList();
		GEM_ChatDebug(GEM_DEBUG_GUI,"GEMList_Notify : Close Event : "..arg[1]);
	elseif(cmd == GEM_NOTIFY_EVENT_UPDATE) then
		GEM_ChatDebug(GEM_DEBUG_GUI,"GEMList_Notify : Update Event : "..arg[1]);
		_GEMList_RefreshLists(arg[1]);
	elseif(cmd == GEM_NOTIFY_SUBSCRIBER) then
		GEM_ChatDebug(GEM_DEBUG_GUI,"GEMList_Notify : My subscription changed for "..arg[1]);
		_GEMList_RefreshLists(arg[1]);
	elseif(cmd == GEM_NOTIFY_UNSUBSCRIBER) then
		GEM_ChatDebug(GEM_DEBUG_GUI,"GEMList_Notify : My subscription changed for "..arg[1]);
		_GEMList_RefreshLists(arg[1]);
        elseif(cmd == GEM_NOTIFY_MY_SUBSCRIPTION) then
		GEM_ChatDebug(GEM_DEBUG_GUI,"GEMList_Notify : My subscription changed for "..arg[1]);
		_GEMList_RefreshLists(arg[1]);
        elseif(cmd == GEM_NOTIFY_PLAYER_INFOS) then
		if(GEMPlayersFrame:IsVisible()) -- Players list
		then
			GEMPlayers_UpdatePlayersList();
		end
	end
end


--[[
  Banned list Functions
]]

local MAXDISPLAY_BANS = 10;
local selectBannedItem = nil;

local function GEMListBanned_GetList()
  local bans = {};
  
  for name,reason in GEM_Events.realms[GEM_Realm].events[GEMListBannedFrame.Event].banned do
    table.insert(bans,{Name=name, Reason=reason });
  end

  return bans;
end

function GEMListBanned_UpdatePlayersList()
	if(not GEMListBannedFrame:IsVisible()) then
		return;
	end
	local list = GEMListBanned_GetList();
	local size = table.getn(list);
	
	local offset = FauxScrollFrame_GetOffset(GEMListBannedItemScrollFrame);

	numButtons = MAXDISPLAY_BANS;
	i = 1;
	GEMListBanned_UnBan:Disable();

	while (i <= numButtons) do
		local j = i + offset
		local prefix = "GEMListBannedItem"..i;
		local button = getglobal(prefix);
		
		if (j <= size) then
			button.pl_name = list[j].Name;
			getglobal(prefix.."Name"):SetText(list[j].Name);
			getglobal(prefix.."Reason"):SetText(list[j].Reason);
			button:Show();
			
			-- selected
			if (selectBannedItem == list[j].Name) then
				button:LockHighlight();
				if(GEM_IsMyReroll(GEM_Events.realms[GEM_Realm].events[GEMListBannedFrame.Event].leader)) then
					GEMListBanned_UnBan:Enable();
				end
			else
				button:UnlockHighlight();
			end
		else
			button.pl_name = nil;
			button:Hide();
		end
		
		i = i + 1;
	end
	
	FauxScrollFrame_Update(GEMListBannedItemScrollFrame, size, MAXDISPLAY_BANS, 17);
end


function GEMListBannedUnBan_OnClick()
  if(selectBannedItem ~= nil and selectBannedItem ~= "")
  then
    GEM_COM_UnBanPlayer(GEMListBannedFrame.Event,selectBannedItem);
    GEMListBanned_UpdatePlayersList();
  end
end

function GEMListBanned_EventOnClick()
  selectBannedItem = this.pl_name;
  GEMListBanned_UpdatePlayersList();
end

function GEMListBanned_OnShow()
  GEMListBanned_UpdatePlayersList();
end

----------------------------- CALENDAR ---------------------------
local _GEMEventCalendar_CurrentMonth = nil;
local _GEMEventCalendar_CurrentYear = nil;
local _GEMEventCalendar_CurrentReset = 0;

function GEMEventCalendarResetsDropDown_OnShow()
  UIDropDownMenu_Initialize(GEMListFrameCalViewResetsDropDown, GEMEventCalendarResetsDropDown_Init);
  UIDropDownMenu_SetText(GEM_EVENT_CALENDAR_Resets[_GEMEventCalendar_CurrentReset].name, GEMListFrameCalViewResetsDropDown);
  UIDropDownMenu_SetWidth(80, GEMListFrameCalViewResetsDropDown);
end

function GEMEventCalendarResetsDropDown_OnClick()
  _GEMEventCalendar_CurrentReset = this.value;
  if(this.value == 0)
  then
    UIDropDownMenu_SetText(GEM_EVENT_CALENDAR_INSTANCE_NONE_NAME, GEMListFrameCalViewResetsDropDown);
  else
    UIDropDownMenu_SetText(GEM_EVENT_CALENDAR_Resets[_GEMEventCalendar_CurrentReset].name,GEMListFrameCalViewResetsDropDown);
  end
  GEMEventCalendar_OnShow(getglobal("GEMListFrameCalViewCal"));
end

function GEMEventCalendarResetsDropDown_Init()
    local info = { };
    info.text = GEM_EVENT_CALENDAR_INSTANCE_NONE_NAME;
    info.value = 0;
    info.func = GEMEventCalendarResetsDropDown_OnClick;
    UIDropDownMenu_AddButton(info);

  for i,tab in GEM_EVENT_CALENDAR_Resets do
    local info = { };
    info.text = tab.name;
    info.value = i;
    info.func = GEMEventCalendarResetsDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
  end
end

function GEMListCalendarCheckBox_OnClick()
  if(GEMListCalendarCheckBox:GetChecked()) -- Calendar view
  then
    GEMListFrameListView:Hide();
    GEMListFrameCalView:Show();
  else
    GEMListFrameCalView:Hide();
    GEMListFrameListView:Show();
  end
end

function GEMEventCalendar_OnShow(parent)
  local tab = date("*t");

  if(_GEMEventCalendar_CurrentMonth == nil)
  then
    _GEMEventCalendar_CurrentMonth = tab.month;
    _GEMEventCalendar_CurrentYear = tab.year;
    _GEMEventCalendar_CurrentReset = 0;
  end

  tab.month = _GEMEventCalendar_CurrentMonth;
  tab.year = _GEMEventCalendar_CurrentYear;

  GEMListFrameCalViewMonthYear:SetText(GEMCalendar_Month[tab.month].." ".._GEMEventCalendar_CurrentYear);
  GEMEventCalendar_DrawDays(parent,time(tab),_GEMEventCalendar_CurrentReset);
end

function GEMEventCalendar_PreviousMonth()
  _GEMEventCalendar_CurrentMonth = _GEMEventCalendar_CurrentMonth - 1;
  if(_GEMEventCalendar_CurrentMonth == 0)
  then
    _GEMEventCalendar_CurrentYear = _GEMEventCalendar_CurrentYear - 1;
    _GEMEventCalendar_CurrentMonth = 12;
  end
  GEMEventCalendar_OnShow(getglobal("GEMListFrameCalViewCal"));
end

function GEMEventCalendar_NextMonth()
  _GEMEventCalendar_CurrentMonth = _GEMEventCalendar_CurrentMonth + 1;
  if(_GEMEventCalendar_CurrentMonth == 13)
  then
    _GEMEventCalendar_CurrentYear = _GEMEventCalendar_CurrentYear + 1;
    _GEMEventCalendar_CurrentMonth = 1;
  end
  GEMEventCalendar_OnShow(getglobal("GEMListFrameCalViewCal"));
end

