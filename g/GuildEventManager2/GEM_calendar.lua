--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Calendar module - By Kiki
]]

--------------- Local variables ---------------
local GEM_CALENDAR_CBFunc = nil;
local GEM_CALENDAR_UserData = nil;

local GEM_EVENT_CALENDAR_INSTANCE_NONE = 0;
local GEM_EVENT_CALENDAR_INSTANCE_ONYXIA = 1;
local GEM_EVENT_CALENDAR_INSTANCE_MC = 2;
local GEM_EVENT_CALENDAR_INSTANCE_BWL = 3;
local GEM_EVENT_CALENDAR_INSTANCE_ZG = 4;
local GEM_EVENT_CALENDAR_INSTANCE_AQ20 = 5;
local GEM_EVENT_CALENDAR_INSTANCE_AQ40 = 6;

GEM_EVENT_CALENDAR_Resets = {
  [GEM_EVENT_CALENDAR_INSTANCE_NONE] = { name=GEM_EVENT_CALENDAR_INSTANCE_NONE_NAME; };
  [GEM_EVENT_CALENDAR_INSTANCE_ONYXIA] = { start=GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_1; delay=24*60*60* 5; texture="Interface\\AddOns\\GuildEventManager2\\images\\"..GEM_EVENT_CALENDAR_INSTANCE_IMAGES_DIR.."\\onx"; name=GEM_EVENT_CALENDAR_INSTANCE_ONYXIA_NAME; };
  [GEM_EVENT_CALENDAR_INSTANCE_MC] = { start=GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_2; delay=24*60*60* 7; texture="Interface\\AddOns\\GuildEventManager2\\images\\"..GEM_EVENT_CALENDAR_INSTANCE_IMAGES_DIR.."\\mc"; name=GEM_EVENT_CALENDAR_INSTANCE_MC_NAME; };
  [GEM_EVENT_CALENDAR_INSTANCE_BWL] = { start=GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_2; delay=24*60*60* 7; texture="Interface\\AddOns\\GuildEventManager2\\images\\"..GEM_EVENT_CALENDAR_INSTANCE_IMAGES_DIR.."\\bwl"; name=GEM_EVENT_CALENDAR_INSTANCE_BWL_NAME; };
  [GEM_EVENT_CALENDAR_INSTANCE_ZG] = { start=GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_3; delay=24*60*60* 3; texture="Interface\\AddOns\\GuildEventManager2\\images\\"..GEM_EVENT_CALENDAR_INSTANCE_IMAGES_DIR.."\\zg"; name=GEM_EVENT_CALENDAR_INSTANCE_ZG_NAME; };
  [GEM_EVENT_CALENDAR_INSTANCE_AQ20] = { start=GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_3; delay=24*60*60* 3; texture="Interface\\AddOns\\GuildEventManager2\\images\\"..GEM_EVENT_CALENDAR_INSTANCE_IMAGES_DIR.."\\aq20"; name=GEM_EVENT_CALENDAR_INSTANCE_AQ20_NAME; };
  [GEM_EVENT_CALENDAR_INSTANCE_AQ40] = { start=GEM_EVENT_CALENDAR_INSTANCE_FIRST_RESET_TIME_2; delay=24*60*60* 7; texture="Interface\\AddOns\\GuildEventManager2\\images\\"..GEM_EVENT_CALENDAR_INSTANCE_IMAGES_DIR.."\\aq40"; name=GEM_EVENT_CALENDAR_INSTANCE_AQ40_NAME; };
};


--------------- Internal functions ---------------

local function GEMEventCalendar_DrawTexture(parent,line,row,start_tim,ShowReset)
  if(ShowReset ~= 0) -- Draw reset days
  then
    local diff = start_tim - GEM_EVENT_CALENDAR_Resets[ShowReset].start;
    local result = math.mod(diff,GEM_EVENT_CALENDAR_Resets[ShowReset].delay);
    if(result < 24*60*60)
    then
      getglobal(parent:GetName().."Day"..line..row.."Texture"):SetTexture(GEM_EVENT_CALENDAR_Resets[ShowReset].texture);
      return;
    end
  end
end

function GEMEventCalendar_DrawDays(parent,tim,ShowReset)
  local today = date("*t");

  -- Clear all days
  for i=1,6 do
    for j=1,7 do
      getglobal(parent:GetName().."Day"..i..j.."Text"):SetText("");
      getglobal(parent:GetName().."Day"..i..j.."Texture"):SetTexture("");
      getglobal(parent:GetName().."Day"..i..j):Hide();
    end
  end

  -- Compute starting month day
  local tab = date("*t",tim);
  local day = 1;
  local line = 1;
  local row = 1;
  local current_month = tab.month;
  tab.hour = 12;
  tab.min = 1;
  tab.sec = 1;
  tim = time(tab);
  local start_tim = tim - ((tab.day-1) * 60*60*24); -- Rewind (tab.day - 1) days
  tab = date("*t",start_tim);
  
  -- Display all valid days
  while tab.month == current_month
  do
    if(tab.wday < row) -- Changed line
    then
      line = line + 1;
    end
    row = tab.wday;
    getglobal(parent:GetName().."Day"..line..row.."Text"):SetText(day);
    getglobal(parent:GetName().."Day"..line..row):Show();
    getglobal(parent:GetName().."Day"..line..row).time = start_tim;
    if(today.year == tab.year and today.yday == tab.yday)
    then
      getglobal(parent:GetName().."Day"..line..row.."Text"):SetTextColor(0.1,0.8,0.1);
    else
      getglobal(parent:GetName().."Day"..line..row.."Text"):SetTextColor(1.0,0.7,0.15);
    end
    GEMEventCalendar_DrawTexture(parent,line,row,start_tim,ShowReset);
    day = day + 1;
    start_tim = start_tim + 60*60*24; -- Increment day
    tab = date("*t",start_tim);
  end
end

local function GEMCalendar_DrawDays(tim)
  local today = date("*t");

  -- Clear all days
  for i=1,6 do
    for j=1,7 do
      getglobal("GEMCalendarDay"..i..j):SetText("");
      getglobal("GEMCalendarDay"..i..j):Hide();
    end
  end

  -- Compute starting month day
  local tab = date("*t",tim);
  local day = 1;
  local line = 1;
  local row = 1;
  local current_month = tab.month;
  tab.hour = 12;
  tab.min = 1;
  tab.sec = 1;
  tim = time(tab);
  local start_tim = tim - ((tab.day-1) * 60*60*24); -- Rewind (tab.day - 1) days
  tab = date("*t",start_tim);
  
  -- Display all valid days
  while tab.month == current_month
  do
    if(tab.wday < row) -- Changed line
    then
      line = line + 1;
    end
    row = tab.wday;
    getglobal("GEMCalendarDay"..line..row):SetText(day);
    getglobal("GEMCalendarDay"..line..row):Show();
    getglobal("GEMCalendarDay"..line..row).time = start_tim;
    if(today.year == tab.year and today.yday == tab.yday)
    then
      getglobal("GEMCalendarDay"..line..row.."Text"):SetTextColor(0.1,0.8,0.1);
    else
      getglobal("GEMCalendarDay"..line..row.."Text"):SetTextColor(1.0,0.7,0.15);
    end
    day = day + 1;
    start_tim = start_tim + 60*60*24; -- Increment day
    tab = date("*t",start_tim);
  end
end


--------------- From XML functions ---------------
--[[
function GEMCalendar_EventOnHover()
  GameTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
  GameTooltip:AddLine("Coucou "..this:GetID());
  GameTooltip:Show();
end
]]

function GEMCalendar_OnClick()
  local tab = date("*t",this.time);
  tab.hour = getglobal("GEMCalendarHourDropDown").hour;
  tab.min = getglobal("GEMCalendarMinuteDropDown").min;
  tab.sec = 0;
  if(GEM_CALENDAR_CBFunc)
  then
    GEM_CALENDAR_CBFunc(time(tab),GEM_CALENDAR_UserData);
  end
  GEMCalendarFrame:Hide();
end

function GEMCalendar_OnShow()
  GEMCalendar_DrawDays(time());
end

function GEMCalendarMonthDropDown_OnShow()
  local tab = date("*t");
  getglobal("GEMCalendarMonthDropDown").month = tab.month;
  UIDropDownMenu_Initialize(GEMCalendarMonthDropDown, GEMCalendarMonthDropDown_Init);
  UIDropDownMenu_SetText(GEMCalendar_Month[tab.month], GEMCalendarMonthDropDown);
  UIDropDownMenu_SetWidth(70, GEMCalendarMonthDropDown);
end

function GEMCalendarMonthDropDown_OnClick()
  local tab = date("*t");
  getglobal("GEMCalendarMonthDropDown").month = this.value;
  tab.day = 1;
  tab.month = getglobal("GEMCalendarMonthDropDown").month;
  tab.year = getglobal("GEMCalendarYearDropDown").year;
  GEMCalendar_DrawDays(time(tab));
  UIDropDownMenu_SetText(GEMCalendar_Month[this.value], GEMCalendarMonthDropDown);
end

function GEMCalendarMonthDropDown_Init()
  for i,month in GEMCalendar_Month do
    local info = { };
    info.text = month;
    info.value = i;
    info.func = GEMCalendarMonthDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
  end
end
--
function GEMCalendarYearDropDown_OnShow()
  local tab = date("*t");
  getglobal("GEMCalendarYearDropDown").year = tab.year;
  UIDropDownMenu_Initialize(GEMCalendarYearDropDown, GEMCalendarYearDropDown_Init);
  UIDropDownMenu_SetText(tab.year, GEMCalendarYearDropDown);
  UIDropDownMenu_SetWidth(58, GEMCalendarYearDropDown);
end

function GEMCalendarYearDropDown_OnClick()
  local tab = date("*t");
  getglobal("GEMCalendarYearDropDown").year = this.value;
  tab.day = 1;
  tab.month = getglobal("GEMCalendarMonthDropDown").month;
  tab.year = getglobal("GEMCalendarYearDropDown").year;
  GEMCalendar_DrawDays(time(tab));
  UIDropDownMenu_SetText(this.value,GEMCalendarYearDropDown);
end

function GEMCalendarYearDropDown_Init()
  for i=2005,2008 do
    local info = { };
    info.text = i;
    info.value = i;
    info.func = GEMCalendarYearDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
  end
end
--
function GEMCalendarHourDropDown_OnShow()
  getglobal("GEMCalendarHourDropDown").hour = 20;
  UIDropDownMenu_Initialize(GEMCalendarHourDropDown, GEMCalendarHourDropDown_Init);
  UIDropDownMenu_SetText("20h", GEMCalendarHourDropDown);
  UIDropDownMenu_SetWidth(48, GEMCalendarHourDropDown);
end

function GEMCalendarHourDropDown_OnClick()
  getglobal("GEMCalendarHourDropDown").hour = this.value;
  if(this.value < 10)
  then
    UIDropDownMenu_SetText("0"..this.value.."h",GEMCalendarHourDropDown);
  else
    UIDropDownMenu_SetText(this.value.."h",GEMCalendarHourDropDown);
  end
end

function GEMCalendarHourDropDown_Init()
  for i=0,23 do
    local info = { };
    if(i < 10)
    then
      info.text = "0"..i.."h";
    else
      info.text = i.."h";
    end
    info.value = i;
    info.func = GEMCalendarHourDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
  end
end
--
function GEMCalendarMinuteDropDown_OnShow()
  getglobal("GEMCalendarMinuteDropDown").min = 0;
  UIDropDownMenu_Initialize(GEMCalendarMinuteDropDown, GEMCalendarMinuteDropDown_Init);
  UIDropDownMenu_SetText("00", GEMCalendarMinuteDropDown);
  UIDropDownMenu_SetWidth(40, GEMCalendarMinuteDropDown);
end

function GEMCalendarMinuteDropDown_OnClick()
  getglobal("GEMCalendarMinuteDropDown").min = this.value;
  if(this.value < 10)
  then
    UIDropDownMenu_SetText("0"..this.value,GEMCalendarMinuteDropDown);
  else
    UIDropDownMenu_SetText(this.value,GEMCalendarMinuteDropDown);
  end
end

function GEMCalendarMinuteDropDown_Init()
  for i=0,45,15 do
    local info = { };
    if(i < 10)
    then
      info.text = "0"..i;
    else
      info.text = i;
    end
    info.value = i;
    info.func = GEMCalendarMinuteDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
  end
end


--------------- GUI Exported functions ---------------

--[[
 function GEMCalendar_PickupDate :
  Opens the calendar
   CBFunc    : Function -- The CB function : void (*func)(sel_date,user_data) -- Called with the selected date (hour/minute undefined)
   user_data : any      -- User data returned in the callback
  --
   Returns false if Calendar is already open, True otherwise
]]
function GEMCalendar_PickupDate(CBFunc,user_data)
  if(GEMCalendarFrame:IsVisible())
  then
    return false;
  end
  GEM_CALENDAR_CBFunc = CBFunc;
  GEM_CALENDAR_UserData = user_data;
  GEMCalendarFrame:Show();
  return true;
end

-- /script GEMCalendar_PickupDate(nil)
