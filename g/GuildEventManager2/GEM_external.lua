--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    External module - By Kiki
]]


--------------- Local variables ---------------
local GEM_EXTERNAL_CBFunc = nil;

--------------- Internal functions ---------------



--------------- From XML functions ---------------
local function GEMExternal_CheckValues(tab)
  if(tab.name == nil or tab.name == "")
  then
    GEM_ChatPrint(GEM_TEXT_EXTERNAL_ERR_GIVE_NAME);
    getglobal("GEMExternalFrame_Name"):SetFocus();
    return;
  end
  tab.name = string.upper(string.sub(tab.name,1,1)) .. string.sub(tab.name,2);

  if(tab.level == nil)
  then
    GEM_ChatPrint(GEM_TEXT_EXTERNAL_ERR_GIVE_LEVEL);
    getglobal("GEMExternalFrame_Level"):SetFocus();
    return;
  end
  if(tab.guild == nil)
  then
    tab.guild = "";
  end;
  if(tab.comment == nil)
  then
    tab.comment = "";
  end;

  GEM_ChatDebug(GEM_DEBUG_GLOBAL,"Adding external "..tab.name.." guild="..tab.guild.." level="..tab.level.." class="..tab.class.." comment="..tab.comment.." forcesub="..tab.forcesub);
  if(GEM_EXTERNAL_CBFunc)
  then
    GEM_EXTERNAL_CBFunc(tab);
  end
  GEMExternalFrame_Name:SetText("");
  GEMExternalFrame_Guild:SetText("");
  GEMExternalFrame_Level:SetText("");
  GEMExternalFrame_Comment:SetText("");
  GEMExternalFrame_Forcesub:SetChecked(0);
  GEMExternalFrame:Hide();
end

function GEMExternalTarget_OnClick()
  local tab = {};

  if(not UnitExists("target") or not UnitIsFriend("player","target") or not UnitIsPlayer("target"))
  then
    GEM_ChatPrint(GEM_TEXT_EXTERNAL_ERR_INVALID);
    return;
  end

  local _,clas = UnitClass("target");
  tab.name = UnitName("target");
  tab.guild = GetGuildInfo("target");
  tab.level = UnitLevel("target");
  tab.class = clas;
  tab.comment = string.gsub(getglobal("GEMExternalFrame_Comment"):GetText(),"[%c]"," ");
  local forcesub = getglobal("GEMExternalFrame_Forcesub"):GetChecked();
  if(forcesub == nil) then forcesub = 0; end;
  tab.forcesub = forcesub;
  
  GEMExternal_CheckValues(tab);
end

function GEMExternalAdd_OnClick()
  local tab = {}
  tab.name = getglobal("GEMExternalFrame_Name"):GetText();
  tab.guild = getglobal("GEMExternalFrame_Guild"):GetText();
  local level = getglobal("GEMExternalFrame_Level"):GetText();
  tab.class = getglobal("GEMExternalClassDropDown").class;
  tab.comment = string.gsub(getglobal("GEMExternalFrame_Comment"):GetText(),"[%c]"," ");
  tab.level = tonumber(level,10);
  local forcesub = getglobal("GEMExternalFrame_Forcesub"):GetChecked();
  if(forcesub == nil) then forcesub = 0; end;
  tab.forcesub = forcesub;
  
  GEMExternal_CheckValues(tab);
end

function GEMExternal_OnShow()
  GEMExternalFrame_Name:SetFocus();
end

function GEMExternalClassDropDown_OnShow()
  getglobal("GEMExternalClassDropDown").class = "WARRIOR";
  UIDropDownMenu_Initialize(GEMExternalClassDropDown, GEMExternalClassDropDown_Init);
  UIDropDownMenu_SetText(GEM_Classes["WARRIOR"], GEMExternalClassDropDown);
  UIDropDownMenu_SetWidth(90, GEMExternalClassDropDown);
end

function GEMExternalClassDropDown_OnClick()
  getglobal("GEMExternalClassDropDown").class = this.value;
  UIDropDownMenu_SetText(GEM_Classes[this.value],GEMExternalClassDropDown);
end

function GEMExternalClassDropDown_Init()
  for us,locale in GEM_Classes do
    local info = { };
    info.text = locale;
    info.value = us;
    info.func = GEMExternalClassDropDown_OnClick;
    UIDropDownMenu_AddButton(info);
  end
end


--------------- GUI Exported functions ---------------

--[[
 function GEMExternal_Choose :
  Opens the ExternalAdd frame
   CBFunc    : Function -- The CB function : void (*func)(infos) -- Called with the player (infos={name,guild,level,class})
   title     : String   -- Title of the window
  --
   Returns false if ExternalAdd is already open, True otherwise
]]
function GEMExternal_Choose(CBFunc,title,buttons)
  if(GEMExternalFrame:IsVisible())
  then
    return false;
  end
  GEM_EXTERNAL_CBFunc = CBFunc;
  GEMExternalFrameTitle:SetText(title);
  if(buttons[1])
  then
    GEMExternalFrame_CommentString:Show();
    GEMExternalFrame_Comment:Show();
  else
    GEMExternalFrame_CommentString:Hide();
    GEMExternalFrame_Comment:Hide();
  end
  if(buttons[2])
  then
    GEMExternalFrame_ForcesubString:Show();
    GEMExternalFrame_Forcesub:Show();
  else
    GEMExternalFrame_ForcesubString:Hide();
    GEMExternalFrame_Forcesub:Hide();
  end
  GEMExternalFrame:Show();
  return true;
end

-- /script GEMExternal_Choose(nil,"test",{})
