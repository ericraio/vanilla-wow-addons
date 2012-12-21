-- Font Colors
BM_WHITE = HIGHLIGHT_FONT_COLOR_CODE;
BM_RED = RED_FONT_COLOR_CODE;
BM_ORANGE = "|cffff8020";
BM_YELLOW = "|cffffff20";
BM_GREEN = GREEN_FONT_COLOR_CODE;
BM_GRAY = GRAY_FONT_COLOR_CODE;
BM_NORMAL = NORMAL_FONT_COLOR_CODE;
BM_FONT_OFF = FONT_COLOR_CODE_CLOSE;

BRL_ZONE_RANGE = BM_WHITE .. BRL_TOOLTIP_CRANGE .. BM_FONT_OFF;
BRL_INSTANCE_TEXT = "%s%s (%d+ " .. BRL_TOOLTIP_TO .. " %d+)" .. BM_FONT_OFF;  -- Instance (35+ to 45+)
BRL_WORLDMAP_TEXT = "(%d-%d)" .. "\n\n" .. BM_FONT_OFF;


BM_REC_LEVEL_TOOLTIP_TEXT = "";
BM_REC_LEVEL_TOOLTIP_SHORT = "";
BM_REC_ZONE = "";
BM_PLAYER_LEVEL = 0;

-- ***SAVED VARIABLES*** --
BRL_STARTUP												= {};
BRL_STARTUP.m_Loaded							= false;
BRL_STARTUP.m_strPlayer						= "";
BRL_CONFIG												= {};

-- **Default values**
DEFAULT_BRL_ZONE_INFO_ENABLE			= true;
DEFAULT_BRL_TOOLTIP_ENABLE				= true;
DEFAULT_BRL_MAP_TEXT_ENABLE				= true;
DEFAULT_BRL_TOOLTIP_OFFSET_LEFT		= true;	
DEFAULT_BRL_TOOLTIP_OFFSET_BOTTOM	= true;
DEFAULT_BRL_SHOW_TOOLTIP_FACTION	= false;
DEFAULT_BRL_SHOW_TOOLTIP_INSTANCE	= true;
DEFAULT_BRL_SHOW_TOOLTIP_CONTINENT= false;
DEFAULT_BRL_BORDER_ALPHASLIDER		= 1;
BRL_SET_LEFT_RIGHT								= "LEFT";
BRL_SET_BOTTOM_TOP								= "BOTTOM";


function BM_Rec_Level_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function BM_Rec_Level_OnEvent()
	if (event == "VARIABLES_LOADED") then			
		BRL_initialize();
	elseif (event == "PLAYER_ENTERING_WORLD" ) then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD");
		this:RegisterEvent("PLAYER_LEAVING_WORLD");
		this:RegisterEvent("MINIMAP_ZONE_CHANGED");
		this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
		this:RegisterEvent("PLAYER_LEVEL_UP");
		BM_Rec_Level_Update_Text();
	elseif (event == "PLAYER_LEAVING_WORLD" ) then
		this:UnregisterEvent("PLAYER_LEAVING_WORLD");
		this:UnregisterEvent("MINIMAP_ZONE_CHANGED");
		this:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
		this:UnregisterEvent("PLAYER_LEVEL_UP");
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
	else
		BM_Rec_Level_Update_Text();
	end
end

function BRL_initialize()
	-- double check that we are getting the player's name update
	if (BRL_STARTUP.m_Loaded == false) then
		-- add the realm to the "player's name" for the config settings
		BRL_STARTUP.m_strPlayer = GetCVar("realmName") .. "|" .. UnitName("player");
		
		-- Make sure BM_CONFIG is ready
		if (not BRL_CONFIG) then
			BRL_CONFIG = { };
		end

		if (not BRL_CONFIG[BRL_STARTUP.m_strPlayer]) then
			BRL_CONFIG[BRL_STARTUP.m_strPlayer] = { };
		end
		
		-- Zone Info Box Show/Hide
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].zone_info_enable == nil) then
			BRL_CONFIG[BRL_STARTUP.m_strPlayer].zone_info_enable = DEFAULT_BRL_ZONE_INFO_ENABLE;
		end
		-- Tooltip Show/Hide
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_enable == nil) then
			BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_enable = DEFAULT_BRL_TOOLTIP_ENABLE;
		end
		-- Map Text Show/Hide
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].map_text_enable == nil) then
			BRL_CONFIG[BRL_STARTUP.m_strPlayer].map_text_enable = DEFAULT_BRL_MAP_TEXT_ENABLE;
		end
		-- Tooltip Offset Left/Right
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_left == nil) then
			BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_left = DEFAULT_BRL_TOOLTIP_OFFSET_LEFT;
		end
		-- Tooltip Offset Bottom/Top
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_bottom == nil) then
			BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_bottom = DEFAULT_BRL_TOOLTIP_OFFSET_BOTTOM;
		end
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].border_alpha == nil) then
			BRL_CONFIG[BRL_STARTUP.m_strPlayer].border_alpha = DEFAULT_BRL_BORDER_ALPHASLIDER;
		end
			
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].zone_info_enable == false) then
			BM_Rec_Level:Hide();
			BM_Rec_Level_Text_Frame:Hide();
		else
			BM_Rec_Level:Show();
			BM_Rec_Level_Text_Frame:Show();
		end
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].map_text_enable == false) then
			BM_Rec_WorldMap_Frame:Hide();
		else
			BM_Rec_WorldMap_Frame:Show();
		end
		
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_bottom == false) then
			BRL_SET_BOTTOM_TOP = "TOP";
		else
			BRL_SET_BOTTOM_TOP = "BOTTOM";
		end
		
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_left == false) then
			BRL_SET_LEFT_RIGHT = "RIGHT";
		else
			BRL_SET_LEFT_RIGHT = "LEFT";
		end

		BM_Rec_Level:SetAlpha(BRL_CONFIG[BRL_STARTUP.m_strPlayer].border_alpha);
		
		if ( BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_faction == nil ) then
			BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_faction = DEFAULT_BRL_SHOW_TOOLTIP_FACTION;
		end
		
		if ( BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_instance == nil ) then
			BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_instance = DEFAULT_BRL_SHOW_TOOLTIP_INSTANCE;
		end

		if ( BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_continent == nil ) then
			BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_continent = DEFAULT_BRL_SHOW_TOOLTIP_CONTINENT;
		end
		

		-- variables are loaded, ready to go
		BRL_STARTUP.m_Loaded = true;
		

		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(BRL_LOADED .. BRL_LOADED_INFO);
    else
			UIErrorsFrame:AddMessage(BRL_LOADED, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
		end
	end
end

function BM_Get_Color(low,high)
	-- PlayerLevel <= low for zone - 4  == RED
	-- PlayerLevel <  low for zone      == ORANGE
	-- PlayerLevel <= high              == YELLOW
	-- PlayerLevel <  high + 5          == GREEN
	-- Otherwise                        == GRAY
  local playerLevel = UnitLevel("player");
	if (playerLevel <= (low-4)) then
		return BM_RED;
	elseif (playerLevel < low) then
		return BM_ORANGE;
	elseif (playerLevel <= high) then
		return BM_YELLOW;
	elseif (playerLevel < (high+5)) then
		return BM_GREEN;
	else
		return BM_GRAY;
	end
end

function BM_Get_Instance_Text(index,colors)
	local instanceColor = BM_WHITE;
	if ( BM_INSTANCES[index] == nil ) then
		return "";
	end
	if (colors) then
		instanceColor = BM_Get_Color(BM_INSTANCES[index].low,BM_INSTANCES[index].high);
	end
	return format(BRL_INSTANCE_TEXT, instanceColor, BM_INSTANCES[index].zone,
								BM_INSTANCES[index].low, BM_INSTANCES[index].high );
end

function BM_Rec_Level_Update_Text()	
  local playerLevel = UnitLevel("player");
  local zoneColor;
  BM_REC_LEVEL_BUTTON_TEXT = "";
	for i = 0, table.getn(BM_RECOMMEND), 1 do
		if (string.find(BM_RECOMMEND[i].zone, GetZoneText())) then
			BM_Rec_Level_Update_Tooltip_Text(i);
			if (BM_RECOMMEND[i].faction == BRL_CITY) then
				BM_REC_LEVEL_BUTTON_TEXT = BM_WHITE .. BRL_FACTION[BM_RECOMMEND[i].faction] .. BM_FONT_OFF;
			else
				zoneColor = BM_Get_Color(BM_RECOMMEND[i].low,BM_RECOMMEND[i].high);
				BM_REC_LEVEL_BUTTON_TEXT = zoneColor .. format("%d-%d", BM_RECOMMEND[i].low, BM_RECOMMEND[i].high) .. BM_FONT_OFF;
			end
		end
	end
	BM_Rec_Level_Text:SetText(BRL_ZONE_RANGE .. BM_REC_LEVEL_BUTTON_TEXT);
	return 
end

function  BM_Rec_Level_Update_Tooltip_Text(index)	
  local player_level = UnitLevel("player");
  local c,i;
  local tempText,tempText2;

	BM_REC_LEVEL_TOOLTIP_TEXT = "";
	BM_REC_LEVEL_TOOLTIP_SHORT = "";
	tempText = BRL_TOOLTIP_CZONE .. BM_WHITE .. GetZoneText() .. BM_FONT_OFF;

  if ( BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_instance ) then
		if ( BM_RECOMMEND[index].instances[0] ~= nil ) then
		  for c = 0, table.getn(BM_RECOMMEND[index].instances), 1 do
				tempText = tempText .. "\n" .. BRL_TOOLTIP_CINSTANCES ..
																		BM_Get_Instance_Text(BM_RECOMMEND[index].instances[c], false);
			end
		end
	end			

	tempText = tempText .. "\n\n" .. BM_WHITE .. BRL_TOOLTIP_RECOMMEND .. BM_FONT_OFF;
  tempText2 = tempText;
  
	for i = 0, table.getn(BM_RECOMMEND), 1 do
		if ( BM_RECOMMEND[i].low <= player_level and 
		     BM_RECOMMEND[i].high >= player_level ) then	
			if ( (BM_RECOMMEND[i].faction == BRL_CONTESTED) or (UnitFactionGroup("player") == BRL_FACTION[BM_RECOMMEND[i].faction]) ) then

				-- Add zone name and level range.
			  tempText = tempText ..
						"\n" .. BRL_TOOLTIP_RZONE .. BM_WHITE .. BM_RECOMMEND[i].zone .. 
						" (" .. BM_RECOMMEND[i].low .. "-" .. BM_RECOMMEND[i].high .. ")" .. BM_FONT_OFF;
        tempText2 = tempText2 ..
						"\n" .. BRL_TOOLTIP_RZONE .. BM_WHITE .. BM_RECOMMEND[i].zone .. 
						" (" .. BM_RECOMMEND[i].low .. "-" .. BM_RECOMMEND[i].high .. ")" .. BM_FONT_OFF;

        -- Show faction
				if ( BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_faction ) then
					tempText = tempText .. "\n" .. BRL_TOOLTIP_RFACTION .. BM_WHITE .. 
							BRL_FACTION[BM_RECOMMEND[i].faction] .. BM_FONT_OFF;
					tempText2 = tempText2 .. " [" .. BRL_FACTION[BM_RECOMMEND[i].faction] .. "]";
				end

        -- show continent
        if ( BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_continent ) then
          tempText = tempText .. "\n" .. BRL_TOOLTIP_RCONTINENT .. BM_WHITE .. 
          		BRL_CONTINENT[BM_RECOMMEND[i].continent] .. BM_FONT_OFF;
          tempText2 = tempText2 .. " (" .. BRL_CONTINENT[BM_RECOMMEND[i].continent] .. ")";
        end

				-- add any instances
				if ( BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_instance) then
				  if ( BM_RECOMMEND[i].instances[0] ~= nil ) then
				    for c = 0, table.getn(BM_RECOMMEND[i].instances), 1 do
							tempText = tempText .. "\n" .. BRL_TOOLTIP_RINSTANCES .. 
																		BM_Get_Instance_Text(BM_RECOMMEND[i].instances[c], false);
						end
					end
        end
        if ( BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_instance or
             BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_continent or
             BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_faction ) then
					tempText = tempText .. "\n";  -- Extra linebreak if we show more then just zone name
				end
			end
		end
	end
	
	tempText = tempText .. "\n\n" .. BM_WHITE .. BRL_TOOLTIP_RECOMMEND_INSTANCES .. BM_FONT_OFF;
	tempText2 = tempText2 .. "\n\n" .. BM_WHITE .. BRL_TOOLTIP_RECOMMEND_INSTANCES .. BM_FONT_OFF;
	for i = 0, table.getn(BM_INSTANCES), 1 do
		if ( BM_INSTANCES[i].low <= player_level and
				 BM_INSTANCES[i].high >= player_level ) then
			tempText = tempText .. "\n" .. BRL_TOOLTIP_RZONE .. BM_Get_Instance_Text(i,false);
			tempText2 = tempText2 .. "\n" .. BRL_TOOLTIP_RZONE .. BM_Get_Instance_Text(i,false);
		end
	end
				  
	BM_REC_LEVEL_TOOLTIP_TEXT = tempText;
	BM_REC_LEVEL_TOOLTIP_SHORT = tempText2;
	return
end

-- when the mouse goes over the main frame, this gets called
function BM_Rec_Level_OnEnter()
	BRL_STARTUP.m_strPlayer = GetCVar("realmName") .. "|" .. UnitName("player");
	if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_enable) then
		if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_enable == true) then
			if (BRL_SET_BOTTOM_TOP == "BOTTOM") then
				GameTooltip:SetOwner(this, "ANCHOR_NONE");
				GameTooltip:SetPoint("TOP" .. BRL_SET_LEFT_RIGHT, "BM_Rec_Level", "BOTTOM" .. BRL_SET_LEFT_RIGHT, 0, 0);
				-- set the tool tip text
				GameTooltip:SetText(BRL_TOOPTIP_TITLE,nil,nil,nil,1);
				GameTooltip:AddLine(BM_REC_LEVEL_TOOLTIP_TEXT);
				GameTooltip:Show();
			elseif (BRL_SET_BOTTOM_TOP == "TOP") then
				GameTooltip:SetOwner(this, "ANCHOR_NONE");
				GameTooltip:SetPoint("BOTTOM" .. BRL_SET_LEFT_RIGHT, "BM_Rec_Level", "TOP" .. BRL_SET_LEFT_RIGHT, 0, 0);
				-- set the tool tip text
				GameTooltip:SetText(BRL_TOOPTIP_TITLE,nil,nil,nil,1);
				GameTooltip:AddLine(BM_REC_LEVEL_TOOLTIP_TEXT);
				GameTooltip:Show();
			end
		end
	end
end

function BM_Rec_Level_OnLeave()
	BRL_STARTUP.m_strPlayer = GetCVar("realmName") .. "|" .. UnitName("player");
	if (BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_enable == true) then
		-- put the tool tip in the default position
		GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
		GameTooltip:Hide();
	end
end

function BM_WorldMapButton_OnUpdate()
   local player_level = UnitLevel("player");
   local zoneColor;
	 if (WorldMapFrame.areaName ~= nil) then 	
		 for i = 0, table.getn(BM_RECOMMEND), 1 do
			if (string.find(BM_RECOMMEND[i].zone, WorldMapFrame.areaName)) then
				zoneColor = BM_Get_Color(BM_RECOMMEND[i].low, BM_RECOMMEND[i].high);
				zoneText = zoneColor .. format(BRL_WORLDMAP_TEXT, BM_RECOMMEND[i].low, BM_RECOMMEND[i].high);
				if ( BM_RECOMMEND[i].instances[0] ~= nil ) then
				  zoneText = zoneText .. BM_NORMAL .. BRL_TOOLTIP_CINSTANCES .. "\n" .. BM_FONT_OFF;
					for c = 0, table.getn(BM_RECOMMEND[i].instances), 1 do
						zoneText = zoneText .. BM_Get_Instance_Text(BM_RECOMMEND[i].instances[c], true) .. "\n";
					end
				end
				BM_Rec_WorldMap_Text:SetText(zoneText);
			end
		end
	else
		BM_Rec_WorldMap_Text:SetText("");
	end

	if (WorldMapFrame.poiHighlight == 1) then
		for i = 0, table.getn(BM_RECOMMEND), 1 do
			if (string.find(BM_RECOMMEND[i].zone, WorldMapFrameAreaLabel:GetText())) then
				zoneText = BM_WHITE .. BRL_FACTION[BM_RECOMMEND[i].faction] .. "\n\n" .. BM_FONT_OFF;
				if (BM_RECOMMEND[i].instances ~= nil) then
					zoneText = zoneText .. BM_NORMAL .. BRL_TOOLTIP_RINSTANCES .. "\n" .. BM_FONT_OFF;
					for c = 0, table.getn(BM_RECOMMEND[i].instances), 1 do
						zoneText = zoneText .. BM_Get_Instance_Text(BM_RECOMMEND[i].instances[c], true) .. "\n";
					end
				end
				BM_Rec_WorldMap_Text:SetText(zoneText);
			end
		end
	end
end

function BRL_Zone_Info_Enable(msg)
	if (msg == false) then
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].zone_info_enable = false;
		BM_Rec_Level:Hide();
		BM_Rec_Level_Text_Frame:Hide();
	else
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].zone_info_enable = true;
		BM_Rec_Level:Show();
		BM_Rec_Level_Text_Frame:Show();
	end	
end

function BRL_Tooltip_Enable(msg)
	if (msg == false) then
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_enable = false;
	else
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_enable = true;
	end	
end

function BRL_Map_Text_Enable(msg)
	if (msg == false) then
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].map_text_enable = false;
		BM_Rec_WorldMap_Frame:Hide();
	else
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].map_text_enable = true;
		BM_Rec_WorldMap_Frame:Show();
	end	
end

function BRL_Tooltip_Offset_Left(msg)
	if (msg == false) then
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_left = false;
		BRL_SET_LEFT_RIGHT = "RIGHT";
	else
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_left = true;
		BRL_SET_LEFT_RIGHT = "LEFT";
	end	
end

function BRL_Tooltip_Offset_Bottom(msg)
	if (msg == false) then
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_bottom = false;
		BRL_SET_BOTTOM_TOP = "TOP";
	else
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_bottom = true;
		BRL_SET_BOTTOM_TOP = "BOTTOM";
	end	
end

function BRL_Show_Tooltip_Faction(msg)
	if (msg == false) then
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_faction = false;
	else
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_faction = true;
	end	
	BM_Rec_Level_Update_Text();
end

function BRL_Show_Tooltip_Instance(msg)
	if (msg == false) then
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_instance = false;
	else
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_instance = true;
	end	
	BM_Rec_Level_Update_Text();
end
	
function BRL_Show_Tooltip_Continent(msg)
	if (msg == false) then
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_continent = false;
	else
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_continent = true;
	end	
	BM_Rec_Level_Update_Text();
end
	
function BRL_Border_Alpha(msg)
	if (msg < 0 or msg > 1) then
		UIErrorsFrame:AddMessage(BRL_ERROR_MESSAGE_1, 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
	else
		BRL_CONFIG[BRL_STARTUP.m_strPlayer].border_alpha = msg;
		BM_Rec_Level:SetAlpha(BRL_CONFIG[BRL_STARTUP.m_strPlayer].border_alpha);
	end
end

function  BRL_Reset_SlashHandler()
	StaticPopup_Show("BRL_RESET_ALL");
end

function BRL_Reset_Everything()
	BRL_CONFIG[BRL_STARTUP.m_strPlayer].zone_info_enable = DEFAULT_BRL_ZONE_INFO_ENABLE;
	BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_enable = DEFAULT_BRL_TOOLTIP_ENABLE;
	BRL_CONFIG[BRL_STARTUP.m_strPlayer].map_text_enable = DEFAULT_BRL_MAP_TEXT_ENABLE;
	BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_left = DEFAULT_BRL_TOOLTIP_OFFSET_LEFT;
	BRL_CONFIG[BRL_STARTUP.m_strPlayer].tooltip_offset_bottom = DEFAULT_BRL_TOOLTIP_OFFSET_BOTTOM;
	BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_faction = DEFAULT_BRL_SHOW_TOOLTIP_FACTION;
	BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_instance = DEFAULT_BRL_SHOW_TOOLTIP_INSTANCE;
	BRL_CONFIG[BRL_STARTUP.m_strPlayer].show_tooltip_continent = DEFAULT_BRL_SHOW_TOOLTIP_CONTINENT;
	BRL_CONFIG[BRL_STARTUP.m_strPlayer].border_alpha = DEFAULT_BRL_BORDER_ALPHASLIDER;
	BM_Rec_Level:ClearAllPoints();
	BM_Rec_Level:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	BM_Rec_Level:Show();
	BM_Rec_Level_Text_Frame:Show();
	BRL_SET_BOTTOM_TOP = "BOTTOM";
	BRL_SET_LEFT_RIGHT = "LEFT";
end