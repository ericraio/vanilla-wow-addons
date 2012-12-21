--[[
  Guild Event Manager by Kiki of European Cho'gall
    New event - By Alexandre Flament and Kiki
]]

local newEventDate;
local GEM_ModifyEventId = nil;
local _GEMNew_FirstShow = true;
local GEMNewAutoMembers_PList = {};
local GEMNewAutoMembers_RList = {};

--
function GEMNewSorting_EventOnHover()
  local plugin_name = getglobal("GEMNewSortingListDropDown").name;
  GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
  GameTooltip:ClearLines();
  GameTooltip:AddLine("1");
  GameTooltipTextLeft1:SetText("|cff" .. "00AAFF" .. plugin_name .. "|r");
  local help = nil;
  for name,plugin in GEM_SUB_Plugins do
    if(name == plugin_name)
    then
      help = plugin.Help;
      break;
    end
  end
  if(help)
  then
    GameTooltip:AddLine("2");
    GameTooltipTextLeft2:SetText("|cff" .. "FFFFFF" .. help .. "|r");
  end
  GameTooltip:Show();
end
function GEMNewSortingListDropDown_OnShow(sortname)
  if(getglobal("GEMNewSortingListDropDown").name == nil)
  then
    getglobal("GEMNewSortingListDropDown").name = "";
  end
  if(sortname)
  then
    getglobal("GEMNewSortingListDropDown").name = sortname;
  end
  UIDropDownMenu_Initialize(GEMNewSortingListDropDown, GEMNewSortingListDropDown_Init);
  UIDropDownMenu_SetText(getglobal("GEMNewSortingListDropDown").name, GEMNewSortingListDropDown);
end

local function _GEMNewSorting_IsDefault(name,plugin)
  local selected = GEM_GetSelectedReroll();
  if(selected == nil or selected == "")
  then
    selected = GEM_PlayerName;
  end
  if(GEM_Events.realms[GEM_Realm].my_names[selected].default_plugin)
  then
    return GEM_Events.realms[GEM_Realm].my_names[selected].default_plugin == name;
  end
  return (plugin.Default ~= nil and plugin.Default == true);
end

function GEMNewSortingListDropDown_OnClick()
  getglobal("GEMNewSortingListDropDown").name = this.value;
  UIDropDownMenu_SetText(this.value,GEMNewSortingListDropDown);
  GEMNewSorting_Configure:Disable();
  local plugin = GEM_SUB_Plugins[this.value];
  if(plugin ~= nil and plugin.Configure ~= nil)
  then
    GEMNewSorting_Configure:Enable();
  end

  GEMNewSorting_Default:SetChecked(_GEMNewSorting_IsDefault(this.value,plugin));
end

function GEMNewSorting_Default_OnClick()
  local selected = GEM_GetSelectedReroll();
  if(selected == nil or selected == "")
  then
    selected = GEM_PlayerName;
  end

  if(GEMNewSorting_Default:GetChecked()) -- Default checked
  then
    GEM_Events.realms[GEM_Realm].my_names[selected].default_plugin = getglobal("GEMNewSortingListDropDown").name;
  else -- Default unchecked
    GEM_Events.realms[GEM_Realm].my_names[selected].default_plugin = nil;
  end
end

function GEMNewSortingListDropDown_Init()
  GEMNewSorting_Configure:Disable();
  for name,plugin in GEM_SUB_Plugins do
    local info = { };
    info.text = name;
    info.value = name;
    info.func = GEMNewSortingListDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
    if(_GEMNewSorting_IsDefault(name,plugin))
    then
      getglobal("GEMNewSortingListDropDown").name = name;
      getglobal("GEMNewSortingListDropDown").help = plugin.Help;
      UIDropDownMenu_SetText(name,GEMNewSortingListDropDown);
      if(plugin.Configure ~= nil)
      then
        GEMNewSorting_Configure:Enable();
      end
      GEMNewSorting_Default:SetChecked(1);
    end
  end
end

--
function GEMNewTemplateListDropDown_OnShow()
  if(getglobal("GEMNewTemplateListDropDown").name == nil)
  then
    getglobal("GEMNewTemplateListDropDown").name = "";
  end
  UIDropDownMenu_Initialize(GEMNewTemplateListDropDown, GEMNewTemplateListDropDown_Init);
  UIDropDownMenu_SetText(getglobal("GEMNewTemplateListDropDown").name, GEMNewTemplateListDropDown);
end

function GEMNewTemplateListDropDown_OnClick()
  getglobal("GEMNewTemplateListDropDown").name = this.value;
  UIDropDownMenu_SetText(this.value,GEMNewTemplateListDropDown);
  GEMNewTemplate_Load:Enable();
  GEMNewTemplate_Delete:Enable();
end

function GEMNewTemplateListDropDown_Init()
  for name,tab in GEM_Templates do
    local info = { };
    info.text = name;
    info.value = name;
    info.func = GEMNewTemplateListDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
  end
end

--
function GEMNewChannelDropDown_OnShow(ch_name)
  if(getglobal("GEMNewChannelDropDown").name == nil or not GEM_IsChannelInList(getglobal("GEMNewChannelDropDown").name))
  then
    getglobal("GEMNewChannelDropDown").name = GEM_DefaultSendChannel;
  end
  if(ch_name)
  then
    getglobal("GEMNewChannelDropDown").name = ch_name;
  end
  UIDropDownMenu_Initialize(GEMNewChannelDropDown, GEMNewChannelDropDown_Init);
  UIDropDownMenu_SetText(getglobal("GEMNewChannelDropDown").name, GEMNewChannelDropDown);
  UIDropDownMenu_SetWidth(120, GEMNewChannelDropDown);
end

function GEMNewChannelDropDown_OnClick()
  getglobal("GEMNewChannelDropDown").name = this.value;
  UIDropDownMenu_SetText(this.value,GEMNewChannelDropDown);
end

function GEMNewChannelDropDown_Init()
  for name,tab in GEM_COM_Channels do
    local info = { };
    info.text = name;
    info.value = name;
    if(tab.id == 0)
    then
      info.disabled = 1;
    end
    info.func = GEMNewChannelDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
  end
end

function GEM_GetSelectedChannel()
  local name = getglobal("GEMNewChannelDropDown").name;
  if(name == nil)
  then
    name = GEM_DefaultSendChannel;
  end
  return strlower(name);
end

--
function GEMNewRerollDropDown_OnShow(pl_name)
  if(getglobal("GEMNewRerollDropDown").name == nil)
  then
    getglobal("GEMNewRerollDropDown").name = GEM_PlayerName;
  end
  if(pl_name)
  then
    getglobal("GEMNewRerollDropDown").name = pl_name;
  end
  UIDropDownMenu_Initialize(GEMNewRerollDropDown, GEMNewRerollDropDown_Init);
  UIDropDownMenu_SetText(getglobal("GEMNewRerollDropDown").name, GEMNewRerollDropDown);
  UIDropDownMenu_SetWidth(80, GEMNewRerollDropDown);
end

function GEMNewRerollDropDown_OnClick()
  getglobal("GEMNewRerollDropDown").name = this.value;
  getglobal("GEMListFrameRerollDropDown").name = this.value;
  UIDropDownMenu_SetText(this.value,GEMNewRerollDropDown);
end

function GEMNewRerollDropDown_OnClickBadValue()
  GEM_ChatPrint(GEM_TEXT_REROLL_ERR_SELECT);
end

function GEMNewRerollDropDown_Init()
  for name,tab in GEM_Events.realms[GEM_Realm].my_names do
    local info = { };
    info.text = name;
    info.value = name;
    if(not GEM_IsChannelInRerollList(name,GEM_GetSelectedChannel()))
    then
      info.disabled = 1;
      info.func = GEMNewRerollDropDown_OnClickBadValue;
    else
      info.func = GEMNewRerollDropDown_OnClick;
    end
    UIDropDownMenu_AddButton(info);
  end
end
--


function GEMNew_Event_ZoneDropDown_OnShow()
  UIDropDownMenu_Initialize(GEMNew_Event_ZoneDropDown, GEMNew_Event_ZoneDropDown_Init);
  UIDropDownMenu_SetText("", GEMNew_Event_ZoneDropDown);
  UIDropDownMenu_SetWidth(80, GEMNew_Event_ZoneDropDown);
end

function GEMNew_Event_ZoneDropDown_OnClick()
  GEMNew_Where:SetText(this.value);
end

function GEMNew_Event_ZoneDropDown_Init()
  for k,instance in GEM_INSTANCES do
    local info = { };
    info.text = instance;
    info.value = instance;
    info.func = GEMNew_Event_ZoneDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
  end
end

function GEMNew_Date_OnClick()
  GEMCalendar_PickupDate(GEMNew_Date_PickedUp, nil);
end

function GEMNew_Date_PickedUp(sel_date, user_data)
  GEMNew_Date_Set(sel_date - GEM_ComputeHourOffset());
end

function GEMNew_Date_Set(sel_date)
  if(GEM_ServerOffset == 666)
  then
    GEM_ComputeServerOffset();
  end

  GEMNew_DateValueServer:SetText(GEM_HEADER_DATE_SERVER..date(GEM_HOUR_FORMAT,sel_date+(GEM_ServerOffset * 60 * 60)));
  GEMNew_DateValue:SetText(GEM_ConvertDateFormat(date(GEM_Events.DateFormat,sel_date)));

  newEventDate = sel_date;
end

local function GEMNew_GetClass(name)
  local wgt_name = "GEMNew_Limit_"..name;
  local mini,maxi;
  mini = tonumber(getglobal(wgt_name.."_Min"):GetText(),10);
  maxi = tonumber(getglobal(wgt_name.."_Max"):GetText(),10);
  
  local sub = {};
  sub.min = -1;
  sub.max = -1;
  sub.tit_count = 0;
  sub.sub_count = 0;
  sub.repl_count = 0;
  if(mini)
  then
    sub.min = mini;
  end
  if(maxi)
  then
    sub.max = maxi;
  end
  return sub;
end

local function GEMNew_SetClass(name,class)
  local wgt_name = "GEMNew_Limit_"..name;
  local mini,maxi;
  
  if(class.min)
  then
    getglobal(wgt_name.."_Min"):SetText(class.min);
  end
  if(class.min)
  then
    getglobal(wgt_name.."_Max"):SetText(class.max);
  end
end

local function GEMNew_ResetAllClasses()
  GEMNew_Limit_Warrior_Min:SetText("");
  GEMNew_Limit_Warrior_Max:SetText("");

  GEMNew_Limit_Paladin_Min:SetText("");
  GEMNew_Limit_Paladin_Max:SetText("");

  GEMNew_Limit_Shaman_Min:SetText("");
  GEMNew_Limit_Shaman_Max:SetText("");

  GEMNew_Limit_Rogue_Min:SetText("");
  GEMNew_Limit_Rogue_Max:SetText("");

  GEMNew_Limit_Mage_Min:SetText("");
  GEMNew_Limit_Mage_Max:SetText("");

  GEMNew_Limit_Warlock_Min:SetText("");
  GEMNew_Limit_Warlock_Max:SetText("");

  GEMNew_Limit_Hunter_Min:SetText("");
  GEMNew_Limit_Hunter_Max:SetText("");

  GEMNew_Limit_Druid_Min:SetText("");
  GEMNew_Limit_Druid_Max:SetText("");

  GEMNew_Limit_Priest_Min:SetText("");
  GEMNew_Limit_Priest_Max:SetText("");

end

local function GEMNew_GetClasses()
  local clas = {};
  
  clas["WARRIOR"] = GEMNew_GetClass("Warrior");
  clas["PALADIN"] = GEMNew_GetClass("Paladin");
  clas["SHAMAN"] = GEMNew_GetClass("Shaman");
  clas["ROGUE"] = GEMNew_GetClass("Rogue");
  clas["MAGE"] = GEMNew_GetClass("Mage");
  clas["WARLOCK"] = GEMNew_GetClass("Warlock");
  clas["HUNTER"] = GEMNew_GetClass("Hunter");
  clas["DRUID"] = GEMNew_GetClass("Druid");
  clas["PRIEST"] = GEMNew_GetClass("Priest");
  return clas;
end

local function GEMNew_SetClasses(classes)
  GEMNew_ResetAllClasses();
  GEMNew_SetClass("Warrior",classes["WARRIOR"]);
  GEMNew_SetClass("Paladin",classes["PALADIN"]);
  GEMNew_SetClass("Shaman",classes["SHAMAN"]);
  GEMNew_SetClass("Rogue",classes["ROGUE"]);
  GEMNew_SetClass("Mage",classes["MAGE"]);
  GEMNew_SetClass("Warlock",classes["WARLOCK"]);
  GEMNew_SetClass("Hunter",classes["HUNTER"]);
  GEMNew_SetClass("Druid",classes["DRUID"]);
  GEMNew_SetClass("Priest",classes["PRIEST"]);
end

function GEMNew_CheckResetEdit()
  if(GEMNew_Create:GetText() == GEM_TEXT_MODIFY) -- Edit mode canceled
  then
    GEMNew_Create:SetText(GEM_TEXT_CREATE);
    GEMNew_Reset();
    GEMNew_ResetAllClasses();
  end
end

function GEMNew_Create_OnClick()
  if(GEMNew_Create:GetText() == GEM_TEXT_MODIFY) -- Edit mode
  then
    local where, count,  min_lvl, max_lvl;
    local clas = GEMNew_GetClasses();
    where = GEMNew_Where:GetText();
    if(where == "")
    then
      GEM_ChatPrint(GEM_TEXT_ERR_NO_WHERE);
      GEMNew_Where:SetFocus();
      return;
    end
    comment = string.gsub(GEMNew_Comment:GetText(),"[%c]"," ");
    count = GEMNew_Count:GetNumber();
    min_lvl = GEMNew_MinLevel:GetNumber();
    max_lvl = GEMNew_MaxLevel:GetNumber();
    -- Update event
    GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].leader = GEM_GetSelectedReroll();
    GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].update_time = time();
    GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].ev_date = newEventDate;
    GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].ev_place = where;
    GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].ev_comment = comment;
    GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].max_count = count;
    GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].min_lvl = min_lvl;
    GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].max_lvl = max_lvl;
    for name,tab in clas do
      GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].classes[name].min = tab.min
      GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].classes[name].max = tab.max;
    end
    local sorttype = GEM_SUB_GetSortType(getglobal("GEMNewSortingListDropDown").name);
    if(sorttype == nil)
    then
      GEM_ChatWarning("GEMNew_Create_OnClick : Failed to update SortType for '"..getglobal("GEMNewSortingListDropDown").name.."'");
      return;
    end
    GEM_Events.realms[GEM_Realm].events[GEM_ModifyEventId].sorttype = sorttype;

    GEM_ChatDebug(GEM_DEBUG_GUI,"EditEvent : Updated EventId "..GEM_ModifyEventId.." Leader="..GEM_GetSelectedReroll().." Date="..date("%c",newEventDate).." Place="..where.." Comment="..comment.." Count="..count.." Min="..min_lvl.." Max="..max_lvl);
    
    -- Check players's level
    GEM_SUB_CheckPlayersLevel(GEM_ModifyEventId);

    -- Re order players
    GEM_SUB_SortPlayers(GEM_ModifyEventId);

    -- Notify
    GEM_COM_NotifyEventUpdate(GEM_ModifyEventId);

    GEMNew_Create:SetText(GEM_TEXT_CREATE);
    GEMNew_Reset();
    GEMNew_ResetAllClasses();
    GEMMain_SelectTab(1);
  else
    local where, count,  min_lvl, max_lvl, sorttype;
    local clas = GEMNew_GetClasses();
    where = GEMNew_Where:GetText();
    if(where == "")
    then
      GEM_ChatPrint(GEM_TEXT_ERR_NO_WHERE);
      GEMNew_Where:SetFocus();
      return;
    end
    comment = string.gsub(GEMNew_Comment:GetText(),"[%c]"," ");
    count = GEMNew_Count:GetNumber();
    min_lvl = GEMNew_MinLevel:GetNumber();
    max_lvl = GEMNew_MaxLevel:GetNumber();
    sorttype = GEM_SUB_GetSortType(getglobal("GEMNewSortingListDropDown").name);
    if(sorttype == nil)
    then
      GEM_ChatWarning("GEMNew_Create_OnClick : Failed to find SortType for '"..getglobal("GEMNewSortingListDropDown").name.."'");
      return;
    end
    local ev_id = GEM_COM_CreateNewEvent(GEM_GetSelectedChannel(),newEventDate, where,comment, count, min_lvl, max_lvl,clas,sorttype);
    GEMNew_CheckAutoMembers(ev_id);
    GEMNew_Reset();
    GEMNew_ResetAllClasses();
    GEMMain_SelectTab(1);
  end
end

function GEMNew_Reset()
  GEMNew_AutoMembers:Enable();
  GEMNewAutoMembers_PList = {};
  GEMNewAutoMembers_RList = {};
  GEMNew_Where:SetText("");
  GEMNew_Comment:SetText("");
  GEMNew_Count:SetText("5");
  GEMNew_MinLevel:SetText("1");
  GEMNew_MaxLevel:SetText("60");
  local d = floor(time() / 900) * 900;
  GEMNew_Date_Set(d);
end

function GEMNew_OnShow()
  if(_GEMNew_FirstShow)
  then
    GEMNew_Reset();
    GEMNew_ResetAllClasses();
    GEMNewTemplate_Load:Disable();
    GEMNewTemplate_Delete:Disable();
    _GEMNew_FirstShow = false;
  end
end

--
function GEMNewTemplate_Save_OnClick()
  local name = GEMNewTemplate_Name:GetText();
  if(name == "")
  then
    GEM_ChatPrint(GEM_TEXT_ERR_NO_TEMPLATE);
    GEMNewTemplate_Name:SetFocus();
    return;
  end

  GEM_Templates[name] = {};

  GEM_Templates[name].classes = GEMNew_GetClasses();
  GEM_Templates[name].where = GEMNew_Where:GetText();
  GEM_Templates[name].comment = GEMNew_Comment:GetText();
  GEM_Templates[name].count = GEMNew_Count:GetNumber();
  GEM_Templates[name].min_lvl = GEMNew_MinLevel:GetNumber();
  GEM_Templates[name].max_lvl = GEMNew_MaxLevel:GetNumber();
  GEM_Templates[name].AutoMembers_PList = GEMNewAutoMembers_PList;
  GEM_Templates[name].AutoMembers_RList = GEMNewAutoMembers_RList;

  GEM_ChatPrint(GEM_TEXT_TEMPLATE_SAVED);
  GEMNewTemplate_Name:SetText("");
  GEMNewTemplateListDropDown_OnShow();
end

function GEMNewTemplate_Load_OnClick()
  local name = getglobal("GEMNewTemplateListDropDown").name;
  GEMNew_Where:SetText(GEM_Templates[name].where);
  GEMNew_Comment:SetText(GEM_Templates[name].comment);
  GEMNew_Count:SetText(GEM_Templates[name].count);
  GEMNew_MinLevel:SetText(GEM_Templates[name].min_lvl);
  GEMNew_MaxLevel:SetText(GEM_Templates[name].max_lvl);
  GEMNew_SetClasses(GEM_Templates[name].classes);
  GEMNewAutoMembers_PList = GEM_Templates[name].AutoMembers_PList;
  GEMNewAutoMembers_RList = GEM_Templates[name].AutoMembers_RList;
  if(GEMNewAutoMembers_PList == nil) then GEMNewAutoMembers_PList = {}; end;
  if(GEMNewAutoMembers_RList == nil) then GEMNewAutoMembers_RList = {}; end;
end

StaticPopupDialogs["GEM_CONFIRM_ERASE_TEMPLATE"] = {
  text = TEXT(GEM_TEXT_NEW_CLOSE_CONFIRM),
  button1 = TEXT(OKAY),
  button2 = TEXT(CANCEL),
  OnAccept = function()
    local name = this:GetParent().data;
    GEM_Templates[name] = nil;
    getglobal("GEMNewTemplateListDropDown").name = nil;
    GEMNewTemplateListDropDown_OnShow();
    GEMNewTemplate_Load:Disable();
    GEMNewTemplate_Delete:Disable();
  end,
  timeout = 0
};

function GEMNewTemplate_Delete_OnClick()
  local dialogFrame = StaticPopup_Show("GEM_CONFIRM_ERASE_TEMPLATE");
  if(dialogFrame)
  then
    dialogFrame.data = getglobal("GEMNewTemplateListDropDown").name;
  end
end

function GEMNew_LoadEvent(event)
  GEMNew_Where:SetText(event.ev_place);
  GEMNew_Comment:SetText(event.ev_comment);
  GEMNew_Count:SetText(event.max_count);
  GEMNew_MinLevel:SetText(event.min_lvl);
  GEMNew_MaxLevel:SetText(event.max_lvl);
  GEMNew_SetClasses(event.classes);
  GEM_ModifyEventId = event.id;
  GEMNewRerollDropDown_OnShow(event.leader);
  GEMNewChannelDropDown_OnShow(event.channel);
  GEMNewSortingListDropDown_OnShow(GEM_SUB_GetSortType(event.sorttype));
  GEMNew_Date_Set(event.ev_date);
end

--
function GEMNewSorting_Configure_OnClick()
  local name = getglobal("GEMNewSortingListDropDown").name;
  local plugin = GEM_SUB_Plugins[name];
  if(plugin ~= nil and plugin.Configure ~= nil)
  then
    plugin.Configure();
  end
end

--
--[[
  Auto members Functions
]]

local MAXDISPLAY_AUTOMEMBERS = 8;
local selectPItem = nil;
local selectRItem = nil;

local function GEMNewAutoMembers_GetPList()
  local plist = {};
  
  for i,tab in GEMNewAutoMembers_PList
  do
    table.insert(plist,{ Place=i; infos=tab; });
  end

  return plist;
end

function GEMNewAutoMembers_UpdatePList()
	if(not GEMNewAutoMembersFrame:IsVisible()) then
		return;
	end
	local list = GEMNewAutoMembers_GetPList();
	local size = table.getn(list);
	
	local offset = FauxScrollFrame_GetOffset(GEMNewAutoMembersFramePItemScrollFrame);

	numButtons = MAXDISPLAY_AUTOMEMBERS;
	i = 1;

	while (i <= numButtons) do
		local j = i + offset
		local prefix = "GEMNewAutoMembersFramePItem"..i;
		local button = getglobal(prefix);
		
		if (j <= size) then
                        local infos = list[j].infos;
			button.pl_name = infos.Name;
			getglobal(prefix.."Place"):SetText("P"..list[j].Place);
			getglobal(prefix.."Name"):SetText(infos.Name);
			getglobal(prefix.."Guild"):SetText(infos.Guild);
			getglobal(prefix.."Class"):SetText(GEM_Classes[infos.Class]);
			getglobal(prefix.."Level"):SetText(infos.Level);
			button:Show();
			
			-- selected
			if (selectPItem == infos.Name) then
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
	
	FauxScrollFrame_Update(GEMNewAutoMembersFramePItemScrollFrame, size, MAXDISPLAY_AUTOMEMBERS, 17);
end

local function GEMNewAutoMembers_GetRList()
  local plist = {};
  
  for i,tab in GEMNewAutoMembers_RList
  do
    table.insert(plist,{ Place=i; infos=tab; });
  end

  return plist;
end

function GEMNewAutoMembers_UpdateRList()
	if(not GEMNewAutoMembersFrame:IsVisible()) then
		return;
	end
	local list = GEMNewAutoMembers_GetRList();
	local size = table.getn(list);
	
	local offset = FauxScrollFrame_GetOffset(GEMNewAutoMembersFrameRItemScrollFrame);

	numButtons = MAXDISPLAY_AUTOMEMBERS;
	i = 1;

	while (i <= numButtons) do
		local j = i + offset
		local prefix = "GEMNewAutoMembersFrameRItem"..i;
		local button = getglobal(prefix);
		
		if (j <= size) then
                        local infos = list[j].infos;
			button.pl_name = infos.Name;
			getglobal(prefix.."Place"):SetText("R"..list[j].Place);
			getglobal(prefix.."Name"):SetText(infos.Name);
			getglobal(prefix.."Guild"):SetText(infos.Guild);
			getglobal(prefix.."Class"):SetText(GEM_Classes[infos.Class]);
			getglobal(prefix.."Level"):SetText(infos.Level);
			button:Show();
			
			-- selected
			if (selectRItem == infos.Name) then
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
	
	FauxScrollFrame_Update(GEMNewAutoMembersFrameRItemScrollFrame, size, MAXDISPLAY_AUTOMEMBERS, 17);
end

function GEMNewAutoMembers_SortBy()
end

function GEMNewAutoMembers_OnClick()
  if(this:GetID() == 1)
  then
    selectPItem = this.pl_name;
    GEMNewAutoMembers_UpdatePList();
  elseif(this:GetID() == 2)
  then
    selectRItem = this.pl_name;
    GEMNewAutoMembers_UpdateRList();
  end
end

function GEMNewAutoMembers_OnShow()
  GEMNewAutoMembers_UpdatePList();
  GEMNewAutoMembers_UpdateRList();
end

function GEMNewAutoMembers_PInfosSet(infos)
  table.insert(GEMNewAutoMembers_PList,{ Name=infos.name; Guild=infos.guild; Class=infos.class; Level=infos.level });
  GEMNewAutoMembers_UpdatePList();
end

function GEMNewAutoMembers_RInfosSet(infos)
  table.insert(GEMNewAutoMembers_RList,{ Name=infos.name; Guild=infos.guild; Class=infos.class; Level=infos.level });
  GEMNewAutoMembers_UpdateRList();
end

function GEMNew_AutoMembers_OnClick()
  if(GEMNewAutoMembersFrame:IsVisible())
  then
    GEMNewAutoMembersFrame:Hide();
  else
    -- Show the window
    GEMNewAutoMembersFrame:Show();
  end
end

function GEMNew_CheckAutoMembers(ev_id)
  local added = false;
  local creat_time = time();

  for i,infos in GEMNewAutoMembers_PList
  do
    GEM_SUB_CreateSubscriber(ev_id,creat_time,infos.Name,infos.Class,infos.Guild,infos.Level,"",0,infos.ForceTit);
    added = true;
  end
  for i,infos in GEMNewAutoMembers_RList
  do
    GEM_SUB_CreateSubscriber(ev_id,creat_time,infos.Name,infos.Class,infos.Guild,infos.Level,"",1,0);
    added = true;
  end
  if(added)
  then
    GEM_NotifyGUI(GEM_NOTIFY_NEW_EVENT,ev_id);
  end
end
