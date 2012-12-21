-- Declard color codes for console messages
local RED     = "|cffff0000";
local GREEN   = "|cff00ff00";
local BLUE    = "|cff0000ff";
local MAGENTA = "|cffff00ff";
local YELLOW  = "|cffffff00";
local CYAN    = "|cff00ffff";
local WHITE   = "|cffffffff";
local ORANGE  = "|cffffba00";

TITAN_ZM_ID =  "ZeppelinMaster";
TITAN_ZM_COUNT_FORMAT = "%d";
TITAN_ZM_MENU_TEXT = "ZeppelinMaster v1.87";
TITAN_ZM_BUTTON_LABEL =  "Hello Menu Counter: ";
TITAN_ZM_TOOLTIP = "ZeppelinMaster";
TITAN_ZM_FREQUENCY = 1;		                
TITAN_ZM_ARTWORK = "Interface\\AddOns\\TitanZeppelinMaster\\Artwork\\";

activeTransitName = "";
activeSelect = -1;
activeTransit = -1;

-----------------------------------
-- local variables
-----------------------------------

local dropdownvalues = {};
local dropdownindexes = {};

local firstTooltip = true;

ZM_tempText = "";
ZM_tempTextCount = 0;

function TitanPanelZeppelinMasterButton_OnLoad()
	
	-- Make sure ZeppelinMaster loads first
	LoadAddOn("ZeppelinMaster");
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");	
	
	this.registry = { 
		id = TITAN_ZM_ID,
		category = "Information",
		menuText = TITAN_ZM_MENU_TEXT, 		
		buttonTextFunction = "TitanPanelZeppelinMasterButton_GetButtonText", 
		tooltipTitle = TITAN_ZM_TOOLTIP,
		tooltipTextFunction = "TitanPanelZeppelinMasterButton_GetTooltipText", 
		frequency = TITAN_ZM_FREQUENCY, 
		icon = TITAN_ZM_ARTWORK.."Zeppelinmaster",	
		iconWidth = 16,		
		savedVariables = {
			OptZoneGUI = 1,
			OptFaction = 1,
			OptZone = 1,
			OptAlias = 1,
			ShowLabelText = 1,
			ShowIcon = 1,
		}
	};
	
	Pre_TitanToggleVar = TitanToggleVar;
	TitanToggleVar = ZM_TitanToggleVar;
	
	--TitanToggleVar(id, var)
end

-- Hook toggle button
function ZM_TitanToggleVar(id, var) 
		--local button, id = TitanUtils_GetButton(id, true);
		--DEFAULT_CHAT_FRAME:AddMessage(var);
		--DEFAULT_CHAT_FRAME:AddMessage(id);
		
		if (id == TITAN_ZM_ID) then
				TitanPanelRightClickMenu_PrepareZeppelinMasterMenu();
				TitanPanelRightClickMenu_Close();
		end
		
		return Pre_TitanToggleVar(id, var);
end

function TitanPanelZeppelinMasterButton_OnEvent ( event ) 
	
		if (event == "VARIABLES_LOADED") then
				
		else
				--DEFAULT_CHAT_FRAME:AddMessage(event);
				TitanPanelRightClickMenu_PrepareZeppelinMasterMenu();
				TitanPanelRightClickMenu_Close();
		end

end

	
function TitanPanelZeppelinMasterButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);
	local lowestName;
	local lowestTime = 500;
	local lowestTimeStr;
	
	if (ZM_tempTextCount > 0) then
			ZM_tempTextCount = ZM_tempTextCount -1;			
			return ZM_tempText;
	end				
	
	if ((activeTransit ~= -1) and (known_times[activeTransit] ~= nil)) then
			local transit = activeTransit;
			local cycle = ZSM_CalcTripCycle(transit);
			local coord_data = ZSM_GetZepCoords(transit, cycle);					
			
			for index, data in zsm_data[transit..'_plats'] do
					--ZSM_CalcTripCycleTime(transit,cycle)								
					--DEFAULT_CHAT_FRAME:AddMessage(data['name']..":"..ZSM_CalcTripCycleTimeByIndex(transit,data['index']-1));																 				
					local arrival_time = 0;
					if (ZSM_CalcTripCycleTimeByIndex(transit,data['index']-1) > (cycle*zsm_data[transit..'_time'])) then
							arrival_time = ZSM_CalcTripCycleTimeByIndex(transit,data['index']-1) - (cycle*zsm_data[transit..'_time']);
							--DEFAULT_CHAT_FRAME:AddMessage("Arrival Time of "..data['name']..": "..arrival_time .." sec.");										
					else
							arrival_time = zsm_data[transit..'_time'] - (cycle*zsm_data[transit..'_time']);
							arrival_time = arrival_time + ZSM_CalcTripCycleTimeByIndex(transit,data['index']-1);
							--DEFAULT_CHAT_FRAME:AddMessage("Arrival Time of "..data['name']..": "..arrival_time .." sec.");
					end 
					--DEFAULT_CHAT_FRAME:AddMessage(GetRealZoneText());
													
					local platname;
					if (ZSM_Data['Opts']['CityAlias']) then
							platname = data['alias'];
					else
							platname = data['name'];
					end																
					getglobal("ZSMFramePlat"..(index+1).."Name"):SetText(platname);								
					
					local coord_data = ZSM_GetZepCoords(transit, cycle);
					local depart_time = ZSM_CalcTripCycleTime(transit,cycle) - (cycle*zsm_data[transit..'_time']) - data['adj'];
					
					local formated_depart_time = "";
					if (depart_time > 59) then
							local time_min = format("%0.0f",math.floor(depart_time/60));
							local time_sec = format("%0.0f",depart_time-(math.floor(depart_time/60)*60));
							formated_depart_time = time_min.."m "..time_sec.."s";
					else
							formated_depart_time = format("%0.0f",depart_time).."s";
					end				

					local formated_arrival_time = "";
					if (arrival_time > 59) then
							local time_min = format("%0.0f",math.floor(arrival_time/60));
							local time_sec = format("%0.0f",arrival_time-(math.floor(arrival_time/60)*60));
							formated_arrival_time = time_min.."m "..time_sec.."s";
					else
							formated_arrival_time = format("%0.0f",arrival_time).."s";
					end															
					
					if ((data['x'] == tonumber(coord_data[1])) and (data['y'] == tonumber(coord_data[2])) and (depart_time > 0)) then					
							local color;
							if (depart_time > 30) then
									color = YELLOW;
							else
									color = RED;
							end
							--getglobal("ZSMFramePlat"..(index+1).."ArrivalDepature"):SetText(color.."Dep: ".. formated_depart_time);
							TitanPanelZeppelinMasterButton.registry.icon = TITAN_ZM_ARTWORK.."Loading";
							
							local constr = data['ebv'].. color .. " ".. formated_depart_time;
							return constr;
					else 
							--local color = GREEN;										
							--getglobal("ZSMFramePlat"..(index+1).."ArrivalDepature"):SetText(color.."Arr: ".. formated_arrival_time);
							--DEFAULT_CHAT_FRAME:AddMessage(arrival_time);
							if (arrival_time < lowestTime) then
									lowestTime = arrival_time;
									lowestName = data['ebv'];
									lowestTimeStr = formated_arrival_time;
							end
							
							TitanPanelZeppelinMasterButton.registry.icon = TITAN_ZM_ARTWORK.."Transit";
					end																	
			end		
	elseif ((activeTransit ~= -1) and (known_times[activeTransit] == nil)) then					
			local transit = activeTransit;			
			
			TitanPanelZeppelinMasterButton.registry.icon = TITAN_ZM_ARTWORK.."Zeppelinmaster";
			
			return "N/A";
	elseif (activeTransit == -1) then
			TitanPanelZeppelinMasterButton.registry.icon = TITAN_ZM_ARTWORK.."Zeppelinmaster";
			return "--";
	end			
	
	-- Display Departure Time
	local constr = lowestName.. GREEN.. " " .. lowestTimeStr;
	return constr;
	
	--local countText = format(TITAN_ZM_COUNT_FORMAT, button.count);
	--return TITAN_ZM_BUTTON_LABEL, TitanUtils_GetHighlightText(countText), "test";
end

function TitanPanelZeppelinMasterButton_GetTooltipText()

	if (firstTooltip) then
			firstTooltip = false;
			TitanPanelRightClickMenu_PrepareZeppelinMasterMenu();
	end
	--local countText = format(TITAN_ZM_COUNT_FORMAT, this.count);
	--return TITAN_ZM_TOOLTIP_COUNT.."\t"..TitanUtils_GetHighlightText(countText);	
	local tooltiptext = "";
	local lowestName;
	local lowestTime = 500;
	local lowestTimeStr;	
		
	if ((activeTransit ~= -1) and (known_times[activeTransit] ~= nil)) then
			local transit = activeTransit;
			local cycle = ZSM_CalcTripCycle(transit);
			local coord_data = ZSM_GetZepCoords(transit, cycle);					
			
			tooltiptext = tooltiptext..activeTransitName.."\n\n";
			
			for index, data in zsm_data[transit..'_plats'] do
					--ZSM_CalcTripCycleTime(transit,cycle)								
					--DEFAULT_CHAT_FRAME:AddMessage(data['name']..":"..ZSM_CalcTripCycleTimeByIndex(transit,data['index']-1));																 				
					local arrival_time = 0;
					if (ZSM_CalcTripCycleTimeByIndex(transit,data['index']-1) > (cycle*zsm_data[transit..'_time'])) then
							arrival_time = ZSM_CalcTripCycleTimeByIndex(transit,data['index']-1) - (cycle*zsm_data[transit..'_time']);
							--DEFAULT_CHAT_FRAME:AddMessage("Arrival Time of "..data['name']..": "..arrival_time .." sec.");										
					else
							arrival_time = zsm_data[transit..'_time'] - (cycle*zsm_data[transit..'_time']);
							arrival_time = arrival_time + ZSM_CalcTripCycleTimeByIndex(transit,data['index']-1);
							--DEFAULT_CHAT_FRAME:AddMessage("Arrival Time of "..data['name']..": "..arrival_time .." sec.");
					end 
					--DEFAULT_CHAT_FRAME:AddMessage(GetRealZoneText());
													
					local platname;
					if (ZSM_Data['Opts']['CityAlias']) then
							platname = data['alias'];
					else
							platname = data['name'];
					end																
					getglobal("ZSMFramePlat"..(index+1).."Name"):SetText(platname);								
					
					local coord_data = ZSM_GetZepCoords(transit, cycle);
					local depart_time = ZSM_CalcTripCycleTime(transit,cycle) - (cycle*zsm_data[transit..'_time']) - data['adj'];
					
					local formated_depart_time = "";
					if (depart_time > 59) then
							local time_min = format("%0.0f",math.floor(depart_time/60));
							local time_sec = format("%0.0f",depart_time-(math.floor(depart_time/60)*60));
							formated_depart_time = time_min.."m, "..time_sec.."s";
					else
							formated_depart_time = format("%0.0f",depart_time).."s";
					end				

					local formated_arrival_time = "";
					if (arrival_time > 59) then
							local time_min = format("%0.0f",math.floor(arrival_time/60));
							local time_sec = format("%0.0f",arrival_time-(math.floor(arrival_time/60)*60));
							formated_arrival_time = time_min.."m, "..time_sec.."s";
					else
							formated_arrival_time = format("%0.0f",arrival_time).."s";
					end															
					
					if ((data['x'] == tonumber(coord_data[1])) and (data['y'] == tonumber(coord_data[2])) and (depart_time > 0)) then					
							local color;
							if (depart_time > 30) then
									color = YELLOW;
							else
									color = RED;
							end
							--getglobal("ZSMFramePlat"..(index+1).."ArrivalDepature"):SetText(color.."Dep: ".. formated_depart_time);
							
							--color .. " ".. formated_depart_time;
							--return constr;
							tooltiptext = tooltiptext..platname.."\n";
							tooltiptext = tooltiptext..color.."Departure: ".. " ".. formated_depart_time.."\n\n";
					else 
							--local color = GREEN;										
							--getglobal("ZSMFramePlat"..(index+1).."ArrivalDepature"):SetText(color.."Arr: ".. formated_arrival_time);
							--DEFAULT_CHAT_FRAME:AddMessage(arrival_time);
							
							tooltiptext = tooltiptext..platname.."\n";							
							tooltiptext = tooltiptext..GREEN.."Arrival: ".. formated_arrival_time.."\n\n";

					end																	
			end		
	elseif ((activeTransit ~= -1) and (known_times[activeTransit] == nil)) then					
			local transit = activeTransit;
			
			tooltiptext = tooltiptext..activeTransitName.."\n\n";
			
			for index, data in zsm_data[transit..'_plats'] do
					
					local platname;
					if (ZSM_Data['Opts']['CityAlias']) then
							platname = data['alias'];
					else
							platname = data['name'];
					end
				
					--getglobal("ZSMFramePlat"..(index+1).."Name"):SetText(platname);
					--getglobal("ZSMFramePlat"..(index+1).."ArrivalDepature"):SetText("-- N/A --");					
					

					tooltiptext = tooltiptext..platname.."\n";
					tooltiptext = tooltiptext.."Not Available\n\n";
					
					
			end
	elseif (activeTransit == -1) then
			--for index = 1, 2 do
			--		getglobal("ZSMFramePlat"..(index).."Name"):SetText(ZSM_STR_NONESELECT);
			--		getglobal("ZSMFramePlat"..(index).."ArrivalDepature"):SetText("-- N/A --");				
			--end
			tooltiptext = tooltiptext.."No Transit Selected\n";		
	end		
	return tooltiptext;	
end

function TitanPanelRightClickMenu_PrepareZeppelinMasterMenu()
	
	if (TitanPanelZeppelinMasterButtonRightClickMenu) then
			UIDropDownMenu_ClearAll(TitanPanelZeppelinMasterButtonRightClickMenu);
			--DEFAULT_CHAT_FRAME:AddMessage("Resetting");
	end
	--DEFAULT_CHAT_FRAME:AddMessage("Resetting");
	--UIDropDownMenu_Initialize(TitanPanelZeppelinMasterRightClickMenu, nil);
	
	--TitanPanelRightClickMenu_AddToggleIcon(TITAN_ZM_ID);
	
	local OptFaction = TitanGetVar(TITAN_ZM_ID, "OptFaction");
	local OptZone = TitanGetVar(TITAN_ZM_ID, "OptZone");
	local OptAlias = TitanGetVar(TITAN_ZM_ID, "OptAlias");	

	dropdownvalues = {};
	dropdownindexes = {};
	 
	-- Menu title
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_ZM_ID].menuText);	
	TitanPanelRightClickMenu_AddSpacer();	
	
	-- TitanPanelRightClickMenu_AddCommand() adds an entry in the menu which triggers a function when clicked
	-- 1st parameter is the menu text
	-- 2st parameter can be retrieved by "this.value" in the triggered function. It's like passing parameters to the function.
	-- 3st parameter is the triggered function name
	--TitanPanelRightClickMenu_AddCommand(TITAN_ZM_MENU_RESET_COUNT, TITAN_ZM_ID, "TitanPanelZeppelinMasterButton_ResetCount");	
	
	TitanPanelRightClickMenu_AddCommand(RED.."Select None", -1, "TitanPanelZeppelinMasterButton_SetTransport");				
	
	local count = 1;
	for index, data in zsm_data['transports'] do
			
			local tmplabel = data['label'];	
			dropdownindexes[tmplabel] = index;
			
			local textdesc; 
			if (OptAlias) then
					textdesc = zsm_data['transports'][index]['namealias'];
			else
					textdesc = zsm_data['transports'][index]['name'];
			end
			
			local addtrans = false;
			if (OptFaction) then
					local faction = UnitFactionGroup("player");
					if ((zsm_data['transports'][index]['faction'] == faction) or (zsm_data['transports'][index]['faction'] == "Nuetral")) then
							addtrans = true;
					end				
			else
					addtrans = true;
			end
			
			if (OptZone and (addtrans)) then
					local zonestr = string.lower(zsm_data['transports'][index]['name']);
					local czonestr = string.lower(GetRealZoneText());
					if (not string.find(zonestr, czonestr)) then
							addtrans = false;
					end	
			end
			
			if ((addtrans) and (zsm_data['transports'][index]['faction'] ~= -1)) then					
					table.insert(dropdownvalues, zsm_data['transports'][index]['label']);		
					
					label = zsm_data['transports'][index]['label'];
					
					if (known_times[label] ~= nil) then
							TitanPanelRightClickMenu_AddCommand(GREEN.. textdesc, count, "TitanPanelZeppelinMasterButton_SetTransport");													
					else
							TitanPanelRightClickMenu_AddCommand(textdesc, count, "TitanPanelZeppelinMasterButton_SetTransport");													
					end
					
					count = count + 1;
			end
	end

	-- A blank line in the menu
	TitanPanelRightClickMenu_AddSpacer();	
		
	TitanPanelRightClickMenu_AddToggleVar(ZSM_STR_OPT_FACTION, TITAN_ZM_ID, "OptFaction");
	TitanPanelRightClickMenu_AddToggleVar(ZSM_STR_OPT_ZONE, TITAN_ZM_ID, "OptZone");
	TitanPanelRightClickMenu_AddToggleVar(ZSM_STR_OPT_ALIAS, TITAN_ZM_ID, "OptAlias");
	
	TitanPanelRightClickMenu_AddSpacer();	
	
	--TitanPanelRightClickMenu_AddCommand(data['name'], TITAN_ZM_ID, "TitanPanelZeppelinMasterButton_ResetCount");
	
	-- Generic function to toggle label text
	--TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ZM_ID);

	-- Generic function to hide the plugin
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_ZM_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelZeppelinMasterButton_OnClick( event )
		if (event == "LeftButton") then
			
				if (table.getn(dropdownvalues) == 0) then
						activeSelect = -1;
						activeTransit = -1;
						return;
				elseif (activeSelect == -1) then
						activeSelect = 1;
				else
						activeSelect = activeSelect+1;
				end				
				
				if (activeSelect > table.getn(dropdownvalues)) then
						activeSelect = 1;
						activeTransit = dropdownvalues[activeSelect];																								
				else
						activeTransit = dropdownvalues[activeSelect];												
				end	
				
				local OptAlias = TitanGetVar(TITAN_ZM_ID, "OptAlias");
				if (OptAlias) then
						activeTransitName = zsm_data['transports'][dropdownindexes[activeTransit]]['namealias'];
				else
						activeTransitName = zsm_data['transports'][dropdownindexes[activeTransit]]['name'];
				end		
				
				local color;
				if (known_times[activeTransit] ~= nil) then
						color = GREEN;
				else
						color = RED;
				end
				
				-- Set tempory button text so you know which one is currently selected
				ZM_tempText = color..activeTransitName;
				ZM_tempTextCount = 2;
				TitanPanelButton_SetButtonText(TITAN_ZM_ID);
				
				if (known_times[activeTransit] == nil) then
						ZSM_TransportRequestData(activeTransit);
				end										
		end		
end

function TitanPanelZeppelinMasterButton_SetTransport(id)
		--DEFAULT_CHAT_FRAME:AddMessage("blah:");
		--DEFAULT_CHAT_FRAME:AddMessage(dropdownindexes[activeTransit]);
				
		if (this.value == -1) then
				activeSelect = -1;
				activeTransit = -1;
				activeTransitName = "None Selected";
		else 
				activeSelect = this.value;
				activeTransit = dropdownvalues[this.value];
				
				local OptAlias = TitanGetVar(TITAN_ZM_ID, "OptAlias");
				if (OptAlias) then
						activeTransitName = zsm_data['transports'][dropdownindexes[activeTransit]]['namealias'];
				else
						activeTransitName = zsm_data['transports'][dropdownindexes[activeTransit]]['name'];
				end		
				
				if (known_times[activeTransit] == nil) then
						ZSM_TransportRequestData(activeTransit);
				end		
		
				ZM_tempText = activeTransitName;
				ZM_tempTextCount = 2;		
		end
			
end

