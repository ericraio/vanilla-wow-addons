-- Declard color codes for console messages
local RED     = "|cffff0000";
local GREEN   = "|cff00ff00";
local BLUE    = "|cff0000ff";
local MAGENTA = "|cffff00ff";
local YELLOW  = "|cffffff00";
local CYAN    = "|cff00ffff";
local WHITE   = "|cffffffff";
local ORANGE  = "|cffffba00";

-----------------------------------
-- global variables
-----------------------------------

known_times = {};
activeTransitName = "";
activeSelect = 1;
activeTransit = -1;


-----------------------------------
-- local variables
-----------------------------------


local vars_loaded = false;
local update_int = 0.8;
local ctime_elapse = 0;
local dataChannel = "ZeppelinMaster";
local Pre_ChatFrame_OnEvent;
local ZSM_version = "1.87";
local protoVersion = "1.7";
local varsVersion = 1.0;
local newVerAvail = false;
local known_times_session = {};
local req_timeout;
local known_times_req = {};
local dropdownvalues = {};
local dropdownindex = {};

local prox = 2;
local debug = false;

function ZSM_OnLoad()
  
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_CHANNEL");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");	
	this:RegisterEvent("CHAT_MSG_SYSTEM");  
	this:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
  this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
  
  -- Register slash command
  SLASH_ZSM1 = "/zsm";
  SLASH_ZSM2 = "/zm";
 
  
  SlashCmdList["ZSM"] = function(msg)
      ZSM_SlashCommandHandler(msg);
  end  
	
  Pre_ChatFrame_OnEvent = ChatFrame_OnEvent;
	ChatFrame_OnEvent = ZSM_ChatFrame_OnEvent;	
	
	Pre_message = message;
	message = ZSM_message;
	--OpenMailFrame
end

function ZSM_message ( message )
		-- Very bad way to supress popup errors, shhhh
		
		if ( string.find(message, "Too many buttons in UIDropDownMenu:") ) then
				--DEFAULT_CHAT_FRAME:AddMessage("Error Message intercepted: "..message);
				return;
		else 
				return Pre_message ( message );
		end		
end

function ZSM_ChatFrame_OnEvent ( event )

		if ((event == "CHAT_MSG_CHANNEL") and (string.lower(arg9) == string.lower(dataChannel))) then
				-- Silence				
				if (debug) then
						return Pre_ChatFrame_OnEvent ( event );
				end
		else				
				return Pre_ChatFrame_OnEvent ( event );
								
		end

end

function ZSM_OnUpdate( elapse )		
		
		if (not WorldMapFrame:IsVisible()) then
				SetMapZoom(0);
				x,y = GetPlayerMapPosition("player");
				x = format("%0.3f", x);
				y = format("%0.3f", y);
				SetMapToCurrentZone();
		else
				return;
		end
		
								
		if (req_timeout ~= nil) then
				req_timeout = req_timeout - elapse;
				if (req_timeout <= 0) then
						local highPlayer = {};
						local highTimestamp = {};
						local highTime = {};
						local tmpTransTimestamps = {};
						for playerName,data in known_times_req do
								for transport,transData in data do
										DEFAULT_CHAT_FRAME:AddMessage(playerName..":"..transport);
										--DEFAULT_CHAT_FRAME:AddMessage(highTimestamp);
										
										if (tmpTransTimestamps[transport] == nil) then
												highPlayer[transport] = playerName;
												highTimestamp[transport] = transData['timestamp'];
												highTime[transport] = transData['time'];
										elseif (tmpTransTimestamps[transport] > highTimestamp[transport]) then
												highPlayer[transport] = playerName;
												highTimestamp[transport] = transData['timestamp'];
												highTime[transport] = transData['time'];
										end
								end
						end
						
						-- Highest Timestamp wins
						for transport, timestamp in highTimestamp do							
								ZSM_Data[transport] = {};
								ZSM_Data[transport]['timestamp'] = highTimestamp[transport];
								known_times[transport] = highTime[transport];
								req_timeout = nil;
								known_times_req = {};
								
								if (debug) then
										DEFAULT_CHAT_FRAME:AddMessage("["..highPlayer[transport].."] has most recent transport time:"..highTime[transport]..", with timestamp:".. highTimestamp[transport].." for ".. transport);
								end
						end					
				end				
		end
		

		
		ctime_elapse = ctime_elapse + elapse;		
		if (ctime_elapse > update_int) then
				ctime_elapse = 0;									
				
				if ((activeTransit ~= -1) and (known_times[activeTransit] ~= nil)) then
						local transit = activeTransit;
						local cycle = ZSM_CalcTripCycle(transit);
						local coord_data = ZSM_GetZepCoords(transit, cycle);
						
						if (tonumber(coord_data[3]) > 10) then
								--DEFAULT_CHAT_FRAME:AddMessage("Transit:org2gg Cyc:"..cycle_pos['org2gg']);
									
								for index, data in zsm_data[transit..'_plats'] do																				
										if ((tonumber(x) == data['x']) and (tonumber(y) == data['y'])) then
												local depart_time = ZSM_CalcTripCycleTime(transit,cycle) - (cycle*zsm_data[transit..'_time']) - data['adj'] ;
												--DEFAULT_CHAT_FRAME:AddMessage("At platform:".. data['name'].." depart time:"..depart_time);				
												if ((depart_time < 10) and (depart_time >= 0)) then
														--SendChatMessage("Departure Time: ".. format("%0.0f", depart_time) .." sec.", "SAY");				
												end
										end
								end																					
						end

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
										getglobal("ZSMFramePlat"..(index+1).."ArrivalDepature"):SetText(color.."Dep: ".. formated_depart_time);
								else 
										local color = GREEN;										
										getglobal("ZSMFramePlat"..(index+1).."ArrivalDepature"):SetText(color.."Arr: ".. formated_arrival_time);
								end
									
								
								if (floor((floor(arrival_time) / 10)) == (floor(arrival_time) / 10)) then
										if (arrival_time < 60) then
												
												if ((floor(arrival_time) == 20) or (floor(arrival_time) == 21)) then
															--SendChatMessage("Want to know arrival departure times of any Zeppelin/Ship/Tram in Azeroth on GUI?","SAY");
															--SendChatMessage("Visit curse-gaming.com and download addon called ZeppelinMaster :)","SAY");
												else
															--SendChatMessage("Arrival Time in "..data['name']..": "..format("%0.0f", arrival_time) .." sec.", "SAY");
												end
										end
								end
									
						end		
				elseif ((activeTransit ~= -1) and (known_times[activeTransit] == nil)) then					
						local transit = activeTransit;
						for index, data in zsm_data[transit..'_plats'] do
								
								local platname;
								if (ZSM_Data['Opts']['CityAlias']) then
										platname = data['alias'];
								else
										platname = data['name'];
								end
							
								getglobal("ZSMFramePlat"..(index+1).."Name"):SetText(platname);
								getglobal("ZSMFramePlat"..(index+1).."ArrivalDepature"):SetText("-- N/A --");					
						end
				elseif (activeTransit == -1) then
						for index = 1, 2 do
								getglobal("ZSMFramePlat"..(index).."Name"):SetText(ZSM_STR_NONESELECT);
								getglobal("ZSMFramePlat"..(index).."ArrivalDepature"):SetText("-- N/A --");				
						end
				end				
		end						

		if (ZSM_ProxyCheck(x,'0.315',prox) and ZSM_ProxyCheck(y,'0.450',prox) and (not known_times_session['org2uc'])) then
				ZSM_SetKnownTime(25, 'org2uc');
				known_times_session['org2uc'] = true;
		elseif (ZSM_ProxyCheck(x,'0.725',prox) and ZSM_ProxyCheck(y,'0.227',prox) and (not known_times_session['org2uc'])) then
				ZSM_SetKnownTime(131, 'org2uc');
				known_times_session['org2uc'] = true;
		elseif (ZSM_ProxyCheck(x,'0.311',prox) and ZSM_ProxyCheck(y,'0.443',prox) and (not known_times_session['org2gg'])) then				
				ZSM_SetKnownTime(16, 'org2gg');
				known_times_session['org2gg'] = true;
		elseif (ZSM_ProxyCheck(x,'0.717',prox) and ZSM_ProxyCheck(y,'0.759',prox) and (not known_times_session['org2gg'])) then				
				ZSM_SetKnownTime(63, 'org2gg');	
				known_times_session['org2gg'] = true;	
		elseif (ZSM_ProxyCheck(x,'0.741',prox) and ZSM_ProxyCheck(y,'0.723',prox) and (not known_times_session['grom2uc'])) then
				ZSM_SetKnownTime(42 ,'grom2uc');
				known_times_session['grom2uc'] = true;
		elseif (ZSM_ProxyCheck(x,'0.711',prox) and ZSM_ProxyCheck(y,'0.747',prox) and (not known_times_session['grom2uc'])) then
				ZSM_SetKnownTime(118 ,'grom2uc');
				known_times_session['grom2uc'] = true;
		elseif (ZSM_ProxyCheck(x,'0.712',prox) and ZSM_ProxyCheck(y,'0.811',prox) and (not known_times_session['ratch2bb'])) then
				ZSM_SetKnownTime(93, 'ratch2bb');
				known_times_session['ratch2bb'] = true;
		elseif (ZSM_ProxyCheck(x,'0.285',prox) and ZSM_ProxyCheck(y,'0.532',prox) and (not known_times_session['ratch2bb'])) then
				ZSM_SetKnownTime(162, 'ratch2bb');
				known_times_session['mh2bb'] = true;		
		elseif (ZSM_ProxyCheck(x,'0.740',prox) and ZSM_ProxyCheck(y,'0.436',prox) and (not known_times_session['mh2aub'])) then
				ZSM_SetKnownTime(30, 'mh2aub');
				known_times_session['mh2aub'] = true;		
		elseif (ZSM_ProxyCheck(x,'0.170',prox) and ZSM_ProxyCheck(y,'0.288',prox) and (not known_times_session['mh2aub'])) then
				ZSM_SetKnownTime(84, 'mh2aub');
				known_times_session['mh2ds'] = true;		
		elseif (ZSM_ProxyCheck(x,'0.734',prox) and ZSM_ProxyCheck(y,'0.464',prox) and (not known_times_session['mh2thera'])) then
				ZSM_SetKnownTime(21, 'mh2thera');
				known_times_session['mh2thera'] = true;		
		elseif (ZSM_ProxyCheck(x,'0.312',prox) and ZSM_ProxyCheck(y,'0.620',prox) and (not known_times_session['mh2thera'])) then
				ZSM_SetKnownTime(83, 'mh2thera');
				known_times_session['mh2thera'] = true;							
		elseif (ZSM_ProxyCheck(x,'0.171',prox) and ZSM_ProxyCheck(y,'0.252',prox) and (not known_times_session['rtv2ds'])) then
				ZSM_SetKnownTime(28, 'rtv2ds');	
				known_times_session['rtv2ds'] = true;					
		elseif (ZSM_ProxyCheck(x,'0.180',prox) and ZSM_ProxyCheck(y,'0.221',prox) and (not known_times_session['rtv2ds'])) then
				ZSM_SetKnownTime(94, 'rtv2ds');	
				known_times_session['rtv2ds'] = true;					
		end			
														
end

function ZSM_ProxyCheck(curpos, checkpos, prox) 
		for i=0, prox do
				--DEFAULT_CHAT_FRAME:AddMessage("Checking loc:"..curpos.." for desired loc:"..checkpos);
				if ((tonumber(curpos)-(i*0.001)) == tonumber(checkpos)) then
					return true;
				elseif ((tonumber(curpos)+(i*0.001)) == tonumber(checkpos)) then
					return true;
				end
		end
		return false;
end

function ZSM_CalcTripCycleTimeByIndex(transit, index) 
		local sum_time = 0;
		for i = 1, index do	  				  	
				local Args = GetArgs(zsm_data[transit..'_data'][i], ":");
				sum_time = sum_time + tonumber(Args[3]);
		end
		return sum_time;
end

function ZSM_CalcTripCycle(transit) 
		local div_time = GetTime() - known_times[transit];
		div_time = div_time / zsm_data[transit..'_time'];
		div_time = div_time - floor(div_time);
		return div_time;
end

function ZSM_CalcTripCycleTime(transit, cycle) 
		local sum_time = 0;
		for i = 1, table.getn(zsm_data[transit..'_data']) do	  				  	
				local Args = GetArgs(zsm_data[transit..'_data'][i], ":");				
				sum_time = sum_time + tonumber(Args[3]);						
				if ((cycle*zsm_data[transit..'_time']) <= sum_time) then
					 return sum_time;
				end
		end
end

function ZSM_GetZepCoords(transit, cycle)
		local sum_time = 0;
		for i = 1, table.getn(zsm_data[transit..'_data']) do	    	
				local Args = GetArgs(zsm_data[transit..'_data'][i], ":");
				sum_time = sum_time + tonumber(Args[3]);
				if ((cycle*zsm_data[transit..'_time']) <= sum_time) then							
						return Args;
				end
		end
end

function ZSM_SetKnownTime( value, transit )
				
		local sum_time = 0;
		for i = 1, value do	    	
				local Args = GetArgs(zsm_data[transit..'_data'][i], ":");
				sum_time = sum_time + Args[3];
		end
		known_times[transit] = GetTime() - sum_time;		
		known_times['uptime'] = GetTime();		
		
		if (debug) then
				DEFAULT_CHAT_FRAME:AddMessage(transit .." Zep Time Set :"..known_times[transit]);
		end
		
		ZSM_Data[transit] = {};
		ZSM_Data[transit]['timestamp'] = time();
		local id, name = GetChannelName(dataChannel);	
		SendChatMessage('KNOWN:'..protoVersion..":"..transit..":"..value, "CHANNEL", nil, id);				

end

-------------------

-- DB Drop Down
function ZSM_TransportSelect_Initialize()
	local info;		
	dropdownvalues = {};
	
	for i = 0, getn(zsm_data['transports']), 1 do
		dropdownindex[zsm_data['transports'][i]['label']] = i;
		
		local textdesc; 
		if (ZSM_Data['Opts']['CityAlias']) then
				if (known_times[zsm_data['transports'][i]['label']]) then
					textdesc = GREEN..zsm_data['transports'][i]['namealias'];
				else
					textdesc = zsm_data['transports'][i]['namealias'];
				end
		else
				if (known_times[zsm_data['transports'][i]['label']]) then
					textdesc = GREEN .. zsm_data['transports'][i]['name'];
				else
					textdesc = zsm_data['transports'][i]['name'];
				end
		end
				
		info = {
			text = textdesc;
			func = ZSM_TransportSelect_OnClick;
		};       
		
		local addtrans = false;
		if (ZSM_Data['Opts']['FactionSpecific']) then
				local faction = UnitFactionGroup("player");
				if ((zsm_data['transports'][i]['faction'] == faction) or (zsm_data['transports'][i]['faction'] == "Nuetral")) then
						addtrans = true;
				end				
		else
				addtrans = true;
		end
		
		if (ZSM_Data['Opts']['ZoneSpecific'] and (addtrans)) then
				local zonestr = string.lower(zsm_data['transports'][i]['name']);
				local czonestr = string.lower(GetRealZoneText());
				if (not string.find(zonestr, czonestr)) then
						addtrans = false;
				end	
		end
		
		if ((addtrans) or (zsm_data['transports'][i]['faction'] == -1)) then
				UIDropDownMenu_AddButton(info);								
				table.insert(dropdownvalues, zsm_data['transports'][i]['label']);
		end
	end
		
		
end


-- DB Drop Down
function ZSM_TransportSelect_PreInitialize()
	local info;		
	
	info = {
		text = 'loading variables';
		func = ZSM_TransportSelect_OnClick;
	};       			
	UIDropDownMenu_AddButton(info);
end

function ZSM_TransportSelect_OnShow()

	if (vars_loaded) then
			ZSM_TransportSelect_OnLoaded();
			UIDropDownMenu_SetWidth(150);
			return;
	end
	
	UIDropDownMenu_ClearAll(ZSMFrameTransportSelect);
	UIDropDownMenu_Initialize(ZSMFrameTransportSelect, ZSM_TransportSelect_PreInitialize);
	UIDropDownMenu_SetSelectedID(ZSMFrameTransportSelect, 1);
	UIDropDownMenu_SetWidth(150);
end
         
function ZSM_TransportSelect_OnLoaded()	
	UIDropDownMenu_ClearAll(ZSMFrameTransportSelect);
	UIDropDownMenu_Initialize(ZSMFrameTransportSelect, ZSM_TransportSelect_Initialize);
	UIDropDownMenu_SetSelectedID(ZSMFrameTransportSelect, activeSelect);
	
end

function ZSM_TransportSelect_OnClick()
	if (req_timeout ~= nil) then
			-- Can't change selection while data request is in process
			return;
	end
	
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(ZSMFrameTransportSelect, i);
	activeTransit = dropdownvalues[i];	
	activeSelect = i;
	if (ZSM_Data['Opts']['CityAlias']) then 
			activeTransitName = zsm_data['transports'][dropdownindex[activeTransit]]['namealias'];
	else
			activeTransitName = zsm_data['transports'][dropdownindex[activeTransit]]['name'];
	end
	
	if (known_times[activeTransit] == nil) then
			local id, name = GetChannelName(dataChannel);	
			SendChatMessage('REQ:'..protoVersion..":"..activeTransit, "CHANNEL", nil, id);			
	end
end

function ZSM_TransportRequestData(transport) 	
	
		local id, name = GetChannelName(dataChannel);	
		SendChatMessage('REQ:'..protoVersion..":"..transport, "CHANNEL", nil, id);			
		
		if (debug) then
				DEFAULT_CHAT_FRAME:AddMessage("Data requested for transport ".. transport);
		end

end

-----------------

function ZSM_Minimize_OnClick ()

			if( not ZSMFrame:IsVisible() )then
					ZSMFrame:Show();
					ZSMHeaderFrameMinimizeButton:SetText("v");
					ZSM_Data['Opts']['ShowLowerGUI'] = true;
			else
					ZSMFrame:Hide();
					ZSMHeaderFrameMinimizeButton:SetText("^");
					ZSM_Data['Opts']['ShowLowerGUI'] = false;
			end

end

function ZSM_Close_OnClick ()
		ZSMHeaderFrame:Hide();
		ZSM_Data['Opts']['ShowGUI'] = false;
		DEFAULT_CHAT_FRAME:AddMessage(YELLOW.. "ZeppelinMaster -- GUI Closed! ("..GREEN.."Type /zm to show again"..YELLOW..")");
end

function ZSM_Options_OnClick ()

			if( not ZSMOptionsFrame:IsVisible() )then
					ZSMOptionsFrame:Show();
					
			else
					ZSMOptionsFrame:Hide();
			end

end

function ZSM_OptionsSave_OnClick ()
	
		ZSM_Data['Opts']['ZoneGUI'] = ZSMOptionsFrameOptZoneGUI:GetChecked();
		ZSM_Data['Opts']['FactionSpecific'] = ZSMOptionsFrameOptFactionSpecific:GetChecked();
		ZSM_Data['Opts']['ZoneSpecific'] = ZSMOptionsFrameOptZoneSpecific:GetChecked();
		ZSM_Data['Opts']['CityAlias'] = ZSMOptionsFrameOptCityAlias:GetChecked();
		
		-- Refresh Dropdown with current options applied
		ZSM_TransportSelect_OnLoaded();
		
		
		--DEFAULT_CHAT_FRAME:AddMessage(OptCityAlias);
		
		
		ZSMOptionsFrame:Hide();

end

function ZSM_OptionsClose_OnClick ()
		if (ZSM_Data['Opts']['ZoneGUI']) then
				ZSMOptionsFrameOptZoneGUI:SetChecked();
		end	
		if (ZSM_Data['Opts']['FactionSpecific']) then
				ZSMOptionsFrameOptFactionSpecific:SetChecked();
		end
		if (ZSM_Data['Opts']['ZoneSpecific']) then
				ZSMOptionsFrameOptZoneSpecific:SetChecked();
		end
		if (ZSM_Data['Opts']['CityAlias']) then
				ZSMOptionsFrameOptCityAlias:SetChecked();
		end																
		ZSMOptionsFrame:Hide();
end

-----------------

function ZSM_OnEvent( event )

		if (event == "VARIABLES_LOADED") then
				vars_loaded = true;

				-- Initialize Saved Variables
				if (ZSM_Opts == nil) then
						ZSM_Opts = {};
				end																	
						
				if (ZSM_Opts['dataChannel'] == nil) then
						ZSM_Opts['dataChannel'] = dataChannel;					
				end
				if (ZSM_Data == nil) then
						ZSM_Data = {};
						known_times = {};
				end
				if (ZSM_Data['protoVersion'] == nil) then
						ZSM_Data['protoVersion'] = protoVersion;
				end
				if (ZSM_Data['protoVersion'] ~= protoVersion) then
						-- If protocol is different, reset data
						known_times = {};
						ZSM_Data['protoVersion'] = protoVersion;
						
						if (debug) then
								DEFAULT_CHAT_FRAME:AddMessage(YELLOW.. "ZeppelinMaster - DEBUG - ".. RED .."Protocol changed, data reset!!");
						end
				end
				if (ZSM_Data['Opts'] == nil) then
						ZSM_Data['Opts'] = {};
						ZSM_Data['Opts']['ZoneGUI'] = false;
						ZSM_Data['Opts']['FactionSpecific'] = true;
						ZSM_Data['Opts']['ZoneSpecific'] = false;
						ZSM_Data['Opts']['CityAlias'] = true;						
				end
				
				if ((ZSM_Data['Opts']['version'] == nil) or (ZSM_Data['Opts']['version'] < varsVersion)) then
						ZSM_Data['Opts']['version'] = varsVersion;
						ZSM_Data['Opts']['ZoneGUI'] = false;
				end
				
				if (ZSM_Data['Opts']['ShowGUI'] == nil) then
						ZSM_Data['Opts']['ShowGUI'] = true;
				end
				
				if (ZSM_Data['Opts']['ShowLowerGUI'] == nil) then
						ZSM_Data['Opts']['ShowLowerGUI'] = true;
				end				
				
				-- Set GUI Options
				if (ZSM_Data['Opts']['ZoneGUI']) then
						ZSMOptionsFrameOptZoneGUI:SetChecked();
				end	
				if (ZSM_Data['Opts']['FactionSpecific']) then
						ZSMOptionsFrameOptFactionSpecific:SetChecked();
				end
				if (ZSM_Data['Opts']['ZoneSpecific']) then
						ZSMOptionsFrameOptZoneSpecific:SetChecked();
				end
				if (ZSM_Data['Opts']['CityAlias']) then
						ZSMOptionsFrameOptCityAlias:SetChecked();
				end						
				
				ZSM_TransportSelect_OnLoaded();
				--														
				
				dataChannel = ZSM_Opts['dataChannel'];
				
				if (ZSM_Data['Opts']['ShowLowerGUI']) then
						ZSMFrame:Show();
				else
						ZSMFrame:Hide();
				end
				
				if (ZSM_Data['Opts']['ShowGUI']) then
						ZSMHeaderFrame:Show();
				else
						ZSMHeaderFrame:Hide();
				end
				
				if ((ZSM_Data['agedTimestamp'] ~= nil) and (ZSM_Data['agedTimestamp'] > time())) then
						ZSM_Data['agedTimestamp'] = time();
						DEFAULT_CHAT_FRAME:AddMessage("ZeppelinMaster: Aged timestamp was too old, setting oldest timestamp to current system time.");
				end
				
				--ZSMHeaderFrameAddonName:SetText("ZeppelinMaster "..ZSM_version);
				ZSMOptionsFrameOptionsTitle:SetText("ZeppelinMaster Options (v"..ZSM_version..")");
				DEFAULT_CHAT_FRAME:AddMessage(YELLOW.. "ZeppelinMaster v"..ZSM_version.." -- Loaded. (type /zsm to toggle interface)");
				if ((known_times['uptime'] ~= nil) and (known_times['uptime'] > GetTime())) then
						-- Since uptime is less than last known zep time, reset must have occured
						-- Clear known times
						known_times = {};
						known_times['uptime'] = GetTime();
						
						DEFAULT_CHAT_FRAME:AddMessage(YELLOW.. "ZeppelinMaster -- ".. RED .."Sync Data Out-Of-Date ... Data Reset!");
				end						
				
		elseif (event == "CHAT_MSG_SYSTEM") then
				if (string.find(string.lower(arg1), "restart in") or string.find(string.lower(arg1), "shutdown in")) then
						-- Server is going down, clear zeppelin times also record down time server went down so we can
						-- inform other clients that their data is out of date if their data timestamp is less than 
						-- server reset.
						
						known_times = {};										
						ZSM_Data['agedTimestamp'] = time();
				end
		elseif ((event == "CHAT_MSG_CHANNEL_NOTICE")) then
				joinedch = true;
				-- Automatically join data channel
				JoinChannelByName(dataChannel);
				
				if (arg9 == dataChannel) then
						local id, name = GetChannelName(dataChannel);
						SendChatMessage('REQVER:1:1', "CHANNEL", nil, id);

						-- Transmit all our known data when someone joins a channel
						for index, data in zsm_data['transports'] do
								
								if (data['label'] ~= -1) then
										ZSM_TransportRequestData(data['label']);
								end
						end						
				end
				
				
		elseif (event == "CHAT_MSG_CHANNEL_JOIN") then
				-- if our client was around for a server shutdown or restart, let other clients know data before this date is out-of-date
				if ((ZSM_Data['agedTimestamp'] ~= nil) and (string.lower(arg9) == string.lower(dataChannel))) then					
						local id, name = GetChannelName(dataChannel);
						SendChatMessage('DATED:'..protoVersion..":"..ZSM_Data['agedTimestamp'], "CHANNEL", nil, id);
				end				
				
		elseif ((event == "CHAT_MSG_CHANNEL") and (arg9 == dataChannel) and (arg2 ~= UnitName("player"))) then
												
				local Args = GetArgs(arg1, ":");
				local numArgs = table.getn(Args);
				
				if (numArgs <= 2) then
						return;
				end
				
				local command = Args[1];				
				local version = Args[2];
												
				--DEFAULT_CHAT_FRAME:AddMessage(arg4..":"..arg2..":"..arg1);
				
				if ((tonumber(protoVersion) < tonumber(version)) and (not newVerAvail)) then
						newVerAvail = true;
						DEFAULT_CHAT_FRAME:AddMessage(YELLOW.."ZeppelinMaster ::".. RED .." There is a new version of ZeppelinMaster available at curse-gaming.com!");
						return;
				end				
				
				if (command == "REQVER") then	
						local id, name = GetChannelName(dataChannel);									
						SendChatMessage('VER:'..protoVersion..":"..ZSM_version, "CHANNEL", nil, id);			
				elseif (command == "VER") then
						local clientversion = Args[3];
						
						if ((tonumber(ZSM_version) < tonumber(clientversion)) and (not newVerAvail)) then
								newVerAvail = true;
								DEFAULT_CHAT_FRAME:AddMessage(YELLOW.."ZeppelinMaster ::".. RED .." There is a new version of ZeppelinMaster available at curse-gaming.com!");
								return;
						end									
				elseif ((command == "DATED") and (protoVersion == version)) then						
						local dated_timestamp = tonumber(Args[3]);
						if ((ZSM_Data['agedTimestamp'] ~= nil) and (ZSM_Data['agedTimestamp'] < dated_timestamp) and (dated_timestamp < time()))  then
								ZSM_Data['agedTimestamp'] = dated_timestamp;
						elseif ((ZSM_Data['agedTimestamp'] == nil) and (dated_timestamp < time())) then
								ZSM_Data['agedTimestamp'] = dated_timestamp;
						end
						
						-- Check to see any of this clients data is older than last aged timestamp
						-- if so clear it
						for transport, time in known_times do
							
								if ((ZSM_Data[transport] ~= nil) and (ZSM_Data[transport]['timestamp'] ~= nil) and (ZSM_Data['agedTimestamp'] ~= nil) and (ZSM_Data[transport]['timestamp'] < ZSM_Data['agedTimestamp'])) then
										known_times[transport] = nil;
										ZSM_Data[transport] = nil;		
										
										if (debug) then
												DEFAULT_CHAT_FRAME:AddMessage(transport.." timestamp is too old, removing.");
										end							
								end
						end						
					
				elseif ((command == "KNOWN") and (protoVersion == version)) then
						local transit = Args[3];				
						local value = tonumber(Args[4]);
						
						local sum_time = 0;
						for i = 1, value do	    	
								local Args = GetArgs(zsm_data[transit..'_data'][i], ":");
								sum_time = sum_time + Args[3];
						end
						
						known_times[transit] = GetTime() - sum_time;		
						ZSM_Data[transit] = {};
						ZSM_Data[transit]['timestamp'] = time();
						
						if (debug) then
								DEFAULT_CHAT_FRAME:AddMessage(RED.."Zep Time Broadcast Received from ".. arg2 .." -- ".. transit .." Zep Time Set :"..known_times[transit]);
						end
				elseif ((command == "REQ") and (protoVersion == version)) then
						local transit = Args[3];
						
						if (debug) then
								DEFAULT_CHAT_FRAME:AddMessage(arg2.." requested ".. transit);
						end							
						
						if (known_times[transit] ~= nil) then
								local cycle = ZSM_CalcTripCycle(transit);
								local time = cycle*zsm_data[transit..'_time'];
								local id, name = GetChannelName(dataChannel);									
								SendChatMessage('RESP:'..protoVersion..":"..transit..":"..time..":"..ZSM_Data[transit]['timestamp'], "CHANNEL", nil, id);
								
								if (debug) then
										DEFAULT_CHAT_FRAME:AddMessage(dataChannel.." -- ".. id);
								end
						end
						
					
				elseif ((command == "RESP") and (protoVersion == version)) then
						local transit = Args[3];
						local time = tonumber(Args[4]);
						local timestamp = tonumber(Args[5]);
						
						if (known_times[transit] == nil) then
								req_timeout = 1;								
								if (known_times_req[arg2] == nil) then
										known_times_req[arg2] = {};
								end
								known_times_req[arg2][transit] = {};
								known_times_req[arg2][transit]['timestamp'] = timestamp;
								known_times_req[arg2][transit]['time'] = GetTime() - time;								
																
								if (debug) then
										DEFAULT_CHAT_FRAME:AddMessage(RED.."Zep Time Brocast Received from ".. arg2 .." -- ".. transit .." Zep Time Set :"..known_times_req[arg2][transit]['time']);
								end	
						end			
						
						ZM_tempText = RED.."Receiving Data..";
						ZM_tempTextCount = 2;
				end
		elseif (event == "ZONE_CHANGED_NEW_AREA") then
			
				if (not ZSM_Data['Opts']['ZoneGUI']) then
						-- Opt: Show GUI when zone change contains a transport
						return;
				end
				-- Open GUI if entering zone with transport
				for index, zone_data in zsm_data['transports'] do						
						if (zone_data['label'] ~= -1) then							
								local plat_data = zsm_data[zone_data['label']..'_plats'];
								if (plat_data ~= nil) then										
										for index, trans_data in plat_data do
												--DEFAULT_CHAT_FRAME:AddMessage(trans_data['name'] );
												if (trans_data['name'] == GetRealZoneText()) then
														ZSMHeaderFrame:Show();
														ZSMFrame:Show();														
												end
										end
								end
						end
				end
							
		end
	
end

function ZSM_SlashCommandHandler(msg)

  local msgArgs;
	local numArgs;
	
	-- Get the arguments
	msg = string.lower(msg);
	msgArgs = GetArgs(msg, " ");
	
	-- Get the number of arguments
	numArgs = table.getn(msgArgs);
				
	-- Check if command is for DKP, for 1 argument only
	if (numArgs == 0) then										
			DEFAULT_CHAT_FRAME:AddMessage(YELLOW.."ZeppelinMaster -- Display GUI");
			ZSMHeaderFrame:Show();
			ZSM_Data['Opts']['ShowGUI'] = true;
	elseif (numArgs == 1) then
			if (msgArgs[1] == "reset") then
					DEFAULT_CHAT_FRAME:AddMessage(RED.."ZeppelinMaster -- Session Reset!");
					known_times_session = {};
					known_times = {};
			end
	elseif (numArgs == 2) then
			if (msgArgs[1] == "channel") then
					LeaveChannelByName(dataChannel);
					ZSM_Opts['dataChannel'] = msgArgs[2];
					dataChannel = ZSM_Opts['dataChannel'];
					JoinChannelByName(dataChannel);
					DEFAULT_CHAT_FRAME:AddMessage(YELLOW.."ZeppelinMaster -- Data Channel set to [".. msgArgs[2] .."]");
			end
	end
	
end


--[[
Extract key/value from message.
]]--
function GetArgs(message, separator)

	-- Declare 'args' variable.
	local args = {};

	-- Declare 'i' integer.
	i = 0;

	-- Search for seperators in the string and return
	-- the separated data.
	for value in string.gfind(message, "[^"..separator.."]+") do
		i = i + 1;
		args[i] = value;
	end -- end for

	-- Submit the filtered data.
	return args;
end -- end GetArgs()