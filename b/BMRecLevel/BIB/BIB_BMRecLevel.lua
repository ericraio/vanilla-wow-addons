BIB_BRL_ID =  "BRL";
BIB_BRL_ICON_PATH = "Interface\\Addons\\BMRecLevel\\BRL_Icon";
BIB_BRL_ICON_SIZE = 12;

function BIB_BRLButton_OnLoad()
      this:RegisterEvent("VARIABLES_LOADED");
      this:RegisterEvent("PLAYER_ENTERING_WORLD");
      this:RegisterEvent("MINIMAP_ZONE_CHANGED");
      this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
      this:RegisterEvent("PLAYER_LEVEL_UP");

      PLUG_IN_FRAME = "BIB_BRLButton";
      PLUG_IN_NAME = "Recommended Level";
      BM_ICON_SIZE = BIB_BRL_ICON_SIZE;
      BM_Plugin(PLUG_IN_FRAME, PLUG_IN_NAME,BM_ICON_SIZE, BIB_BRL_ID);
end

function BIB_BRLButton_OnEvent()
      if (event == "VARIABLES_LOADED") then
            BIB_BRLButton_Initialize();
            --TitanPanelButtonBRL_SetIcon();
      end
      if (event == "MINIMAP_ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_LEVEL_UP") then
            BIB_BRLButton_GetButtonText();
      end
end

function BIB_BRLButton_GetButtonText()
      if (BM_REC_LEVEL_BUTTON_TEXT ~= nil) then
            if (TitanGetVar(BIB_BRL_ID, "ShowLabelText")) then
			local zonetext, levelrangetext  = BMRecLevel_Update_Text();
                  BIB_BRLButtonText:SetText(zonetext .. ": " .. levelrangetext);
            else
			local __, levelrangetext  = BMRecLevel_Update_Text();
                  BIB_BRLButtonText:SetText(levelrangetext);
            end
      end
end

function BIB_BRLButton_GetTooltipText()
      return BM_REC_LEVEL_TOOLTIP_TEXT;   
end

function BIB_RightClickMenu_PrepareBRLMenu()
      local info;
      
      TitanPanelRightClickMenu_AddTitle(BMRECLEVEL_TITLE);
      
      info = {};
      info.text = BRL_SHOW_ZONE;
      info.func = BIB_BRLButton_ToggleZone;
      info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_zone;
      UIDropDownMenu_AddButton(info); 

      info = {};
      info.text = BRL_SHOW_TOOLTIP_FACTION;
      info.func = BIB_BRLButton_ToggleFaction;
      info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction;
      UIDropDownMenu_AddButton(info); 
      
      info = {};
      info.text = BRL_SHOW_TOOLTIP_INSTANCE;
      info.func = BIB_BRLButton_ToggleInstance;
      info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance;
      UIDropDownMenu_AddButton(info);     
      
      info = {};
      info.text = BRL_SHOW_TOOLTIP_CONTINENT;
      info.func = BIB_BRLButton_ToggleContinent;
      info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_continent;
      UIDropDownMenu_AddButton(info);

      TitanPanelRightClickMenu_AddSpacer();
      
      info = {};
      info.text = BRL_MOVABLE_FRAME_ENABLE;
      info.func = BIB_BRLButton_ToggleMoveableFrame;
      info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_moveable_frame;
      UIDropDownMenu_AddButton(info);

      info = {};
      info.text = BRL_MAP_TEXT_ENABLE;
      info.func = BIB_BRLButton_ToggleMapText;
      info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].map_text_enable;
      UIDropDownMenu_AddButton(info);

      TitanPanelRightClickMenu_AddSpacer();
      
      info = {};
      info.text = BRL_SHOW_REC_INSTANCE;
      info.func = BIB_BRLButton_ToggleRecInstances;
      info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_instances;
      UIDropDownMenu_AddButton(info);

      info = {};
      info.text = BRL_SHOW_REC_BATTLEGROUNDS;
      info.func = BIB_BRLButton_ToggleRecBattlegrounds;
      info.checked = BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_battlegrounds;
      UIDropDownMenu_AddButton(info);

      TitanPanelRightClickMenu_AddSpacer();

      TitanPanelRightClickMenu_AddToggleLabelText(BIB_BRL_ID);
      
      info = {};
      info.text = BM_SHOW_ICON;
      info.func = BIB_BRLButton_ToggleIcon;
      info.checked = TitanGetVar(BIB_BRL_ID, "ShowIcon");
      UIDropDownMenu_AddButton(info);
end

function BIB_BRLButton_ToggleZone()
       BRL_Show_Zone(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_zone);
       BIB_BRLButton_GetButtonText();
       BIB_BRLButton_GetTooltipText();
end

function BIB_BRLButton_ToggleMoveableFrame()
      BRL_Show_Moveable_Frame(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_moveable_frame);
       BIB_BRLButton_GetButtonText();
       BIB_BRLButton_GetTooltipText();
end

function BIB_BRLButton_ToggleInstance()
      BRL_Show_Tooltip_Instance(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_instance);
       BIB_BRLButton_GetButtonText();
       BIB_BRLButton_GetTooltipText();
end

function BIB_BRLButton_ToggleFaction()
      BRL_Show_Tooltip_Faction(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_faction);
      BIB_BRLButton_GetButtonText();
       BIB_BRLButton_GetTooltipText();
end

function BIB_BRLButton_ToggleRecInstances()
      BRL_Toogle_RecInstances(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_instances);
      BIB_BRLButton_GetButtonText();
       BIB_BRLButton_GetTooltipText();
end

function BIB_BRLButton_ToggleRecBattlegrounds()
      BRL_Toogle_RecBattlegrounds(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_rec_battlegrounds);
      BIB_BRLButton_GetButtonText();
       BIB_BRLButton_GetTooltipText();
end

function BIB_BRLButton_ToggleContinent()
      BRL_Show_Tooltip_Continent(not BRL_CONFIG[BM_PLAYERNAME_REALM].show_tooltip_continent);
      BIB_BRLButton_GetButtonText();
      BIB_BRLButton_GetTooltipText();
end

function BIB_BRLButton_ToggleMapText()
      BRL_Map_Text_Enable(not BRL_CONFIG[BM_PLAYERNAME_REALM].map_text_enable);
end

function BIB_BRLButton_ToggleIcon()
      TitanToggleVar(BIB_BRL_ID, "ShowIcon");
      BIB_BRLButton_SetIcon();
end


function BIB_BRLButton_Initialize()
      -- This is the list of the saved vars used, values can be true, false, number, text whatever you want to save. 
      savedVariables = {
            [1] = {name = "ShowIcon", value  = true},
            [2] = {name = "ShowLabelText", value  = true},
      }
      -- Function to Initialize the saved vars if they don't exisit create them if they do exisits SWEET!!
      for key, value in savedVariables do
            BM_Initialize_Variables(BIB_BRL_ID, value.name, value.value);
      end
      -- Creates the Dropdown menu
      UIDropDownMenu_Initialize(BIB_BRLButtonRightClickMenu, BIB_RightClickMenu_PrepareBRLMenu, "Menu"); 
      -- Initialize the icon
      BIB_BRLButton_SetIcon();
end

--Sets the icon to where its suppose to be if no icon skips this function
function BIB_BRLButton_SetIcon()
      local icon1 = BIB_BRLButtonIcon;
      if (TitanGetVar(TITAN_BRL_ID, "ShowIcon")) then
            icon1:SetTexture(BIB_BRL_ICON_PATH);
            icon1:SetWidth(BIB_BRL_ICON_SIZE);
            icon1:SetHeight(BIB_BRL_ICON_SIZE);
      else
            icon1:SetTexture("");
            icon1:SetWidth(1);
      end
end

--This function is in every plugin always the same except for the 2 varables
function BIB_BRLButton_OnEnter()
      GameTooltip:SetOwner(this, "ANCHOR_NONE");
      GameTooltip:SetPoint(BM_TOOLTIP_ANCHOR .. BM_PositonToolTip_RightLeft(), this, BM_TOOLTIP_RELPOINT .. BM_PositonToolTip_RightLeft(), 0, 0);
      -- set the tool tip text 
      --only these two lines will change everything else is the same for all plugins
      GameTooltip:SetText(TitanUtils_GetGreenText(BRL_TOOPTIP_TITLE)); -- Usually found in localization file  TITAN_COMBATINFO_TOOLTIP="Combat Info"
      GameTooltip:AddLine(BM_REC_LEVEL_TOOLTIP_TEXT);
      --BM_Tooltip_AddTooltipText(BM_REC_LEVEL_TOOLTIP_TEXT); --The variable created by the GetTooltipText() function
      GameTooltip:Show();     
end

--This function is in every plugin always the same
function BIB_BRLButton_OnLeave()
      -- put the tool tip in the default position
      GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
      GameTooltip:Hide();
end

--This function is in every plugin always the same
function BIB_BRLButton_OnRightClick(button)
      if (button == "RightButton") then
            ToggleDropDownMenu(1, nil, getglobal(this:GetName().."RightClickMenu"), this:GetName(), 0, 0);
            GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
            GameTooltip:Hide();
      end
end
