--[[
	Gatherer Report/Search UI
	Version: <%version%>
	Revision: $Id: GathererInfo.lua,v 1.5 2005/09/22 21:50:14 islorgris Exp $
]]--

-- Scrolling variables
GATHERERINFO_TO_DISPLAY=15;
GATHERERINFO_FRAME_HEIGHT=15;
GATHERERINFO_SUBFRAMES = { "GathererInfo_ReportFrame", "GathererInfo_SearchFrame" };

-- Defaults
currentNode = "";
GathererInfo_LastSortType = "gtype";
GathererInfo_LastSearchSortType= "Cname";
GathererInfo_AutoRegion = true;
GathererInfo_LastSortReverse = false;

GathererInfoContinents = {};
GathererInfoZones = {};

numGathererInfo = 0;
GI_totalCount = 0;


-- show display frame
function showGathererInfo(tab)
	local myTab = 1;
	if ( tab ) then myTab = tab; end;
		
	if ( not GathererInfo_DialogFrame:IsShown() ) then
		GathererInfo_DialogFrame:Show();
		PanelTemplates_SetTab(GathererInfo_DialogFrame, myTab);
		ToggleGathererInfo_Dialog(GATHERERINFO_SUBFRAMES[myTab]);
	else
		GathererInfo_DialogFrame:Hide();
	end
end

function GathererInfo_LoadContinents(...)
	for c=1, arg.n, 1 do
		GathererInfoContinents[c] = {}
		GathererInfoContinents[c] = arg[c];
		GathererInfoContinents[arg[c]] = c;
		GathererInfo_LoadZones(c, GetMapZones(c));
	end
end

function GathererInfo_LoadZones(c, ...)
	for z=1, arg.n, 1 do
		local zname = arg[z];
		if ( not GathererInfoZones[c] ) then GathererInfoZones[c] = {}; end
		GathererInfoZones[c][zname] = { continent=c, zone=z };
		GathererInfoZones[c][z] = { continent=c, zone=zname };
	end
end
-- ********************************************************************
-- dropdown menu functions
-- Continent
function GathererInfo_LocContinentDropDown_Initialize()
	local index;
	local info = {};
	
	for index in GatherItems do
		-- grab zone text from table initiated by Gatherer Main
		info.text = GathererInfoContinents[index];
		info.checked = nil;
		info.func = GathererInfo_LocContinentDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function GathererInfo_LocContinentDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(GathererInfo_LocContinentDropDown, this:GetID());
	UIDropDownMenu_SetSelectedID(GathererInfo_LocZoneDropDown, 0);
	
	UIDropDownMenu_SetText("", GathererInfo_LocZoneDropDown);

	UIDropDownMenu_ClearAll(GathererInfo_LocZoneDropDown);
	UIDropDownMenu_Initialize(GathererInfo_LocZoneDropDown, GathererInfo_LocZoneDropDown_Initialize);

	local j=1;
	while (j < GATHERERINFO_TO_DISPLAY+1) do
		getglobal("GathererInfo_FrameButton"..j):Hide();
		j = j+1;
	end	

end

-- Zone
function GathererInfo_LocZoneDropDown_Initialize()
	local index;
	local info = {};
	local gi_cont, gi_t_cont;

	gi_t_cont = UIDropDownMenu_GetText(GathererInfo_LocContinentDropDown);
	if ( gi_t_cont and gi_t_cont ~= nil and gi_t_cont ~= "") then
		gi_cont = GathererInfoContinents[gi_t_cont];

		for index in GatherItems[gi_cont] do
			-- grab zone text from table initiated by Gatherer Main
			info.text = GathererInfoZones[gi_cont][index].zone;
			info.checked = nil;
			info.func = GathererInfo_LocZoneDropDown_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	end
end

function GathererInfo_LocZoneDropDown_OnClick()
	local gi_cont, gi_zone;
	local l_zone, node_idx, index;
	
	UIDropDownMenu_SetSelectedID(GathererInfo_LocZoneDropDown, this:GetID());
	
	GathererInfo_AutoRegion = false;

	gi_cont = GathererInfoContinents[UIDropDownMenu_GetText(GathererInfo_LocContinentDropDown)];
	gi_zone = GathererInfoZones[gi_cont][UIDropDownMenu_GetText(GathererInfo_LocZoneDropDown)].zone;

	for l_zone in GatherItems[gi_cont] do
		GI_totalCount = 0;
		numGathererInfo=0;
								
		for node_idx in GatherItems[gi_cont][gi_zone] do
			for index in  GatherItems[gi_cont][gi_zone][node_idx] do
				GI_totalCount = GI_totalCount + GatherItems[gi_cont][gi_zone][node_idx][index].count;
				numGathererInfo = numGathererInfo + 1;
			end
		end
	end
		
	GathererInfo_Update();
end

-- ********************************************************************
-- Display frame initialization
function GathererInfo_SetDefaultLocation()
	local gi_t_cont = GathererInfoContinents[GetCurrentMapContinent()];
	local gi_t_zone = GetRealZoneText();
	local gi_cont = GetCurrentMapContinent();
	local gi_zone = nil;
	local l_cnt, l_zone;
	local node_idx, index;
	local found = 0;

	if ( GetRealZoneText() and GathererInfoZones[gi_cont] and GathererInfoZones[gi_cont][GetRealZoneText()] ) then
		gi_zone = GathererInfoZones[gi_cont][GetRealZoneText()].zone;
	else
		gi_zone = "unknown";
	end

	for l_cnt in GatherItems do
		if( l_cnt == gi_cont ) then
			UIDropDownMenu_SetSelectedName(GathererInfo_LocContinentDropDown, gi_t_cont);
			UIDropDownMenu_SetText(gi_t_cont, GathererInfo_LocContinentDropDown);
			
			for l_zone in GatherItems[gi_cont] do
				if ( l_zone == gi_zone and GathererInfo_AutoRegion == true) then
					UIDropDownMenu_SetSelectedName(GathererInfo_LocZoneDropDown, gi_t_zone);
					UIDropDownMenu_SetText(gi_t_zone, GathererInfo_LocZoneDropDown);
					
					GI_totalCount = 0;
					numGathererInfo=0;
					found = 1;
								
					for node_idx in GatherItems[gi_cont][gi_zone] do
						for index in  GatherItems[gi_cont][gi_zone][node_idx] do
							GI_totalCount = GI_totalCount + GatherItems[gi_cont][gi_zone][node_idx][index].count;
							numGathererInfo = numGathererInfo + 1;
						end
					end
					
					GathererInfo_Update();
				end
			end
		end
	end
end

-- update display frame relative to scrollbar
function GathererInfo_Update()
	local node_idx, index;
	local gatherInfoOffset = FauxScrollFrame_GetOffset(GathererInfo_ListScrollFrame);
	local gi_cont, gi_zone, gi_loc;
	local gatherInfoIndex;
	local showScrollBar = nil;
	local button;
	local i = 1;
	GITT = {};

	-- Get continent, zone
	if ( UIDropDownMenu_GetText(GathererInfo_LocContinentDropDown) and
		 UIDropDownMenu_GetText(GathererInfo_LocContinentDropDown) ~= "") 
	then
		gi_cont = GathererInfoContinents[UIDropDownMenu_GetText(GathererInfo_LocContinentDropDown)];
	else
		gi_cont = GetCurrentMapContinent();
	end

	if ( UIDropDownMenu_GetText(GathererInfo_LocZoneDropDown) and
		 UIDropDownMenu_GetText(GathererInfo_LocZoneDropDown) ~= "") 
	then
		gi_zone = GathererInfoZones[gi_cont][UIDropDownMenu_GetText(GathererInfo_LocZoneDropDown)].zone;
	else
		if ( GetRealZoneText() and GathererInfoZones[gi_cont] and GathererInfoZones[gi_cont][GetRealZoneText()] ) then
			gi_zone = GathererInfoZones[gi_cont][GetRealZoneText()].zone;
		else
			gi_zone = nil;
		end
	end
	-- if loc exists in stored base
	if ( GatherItems and gi_cont and gi_zone and GatherItems[gi_cont] and 
		 GatherItems[gi_cont][gi_zone] ) 
	then
		if ( GatherItems and GatherItems[gi_cont] and GatherItems[gi_cont][gi_zone] )
		then
			local typeNodeCount = {};
			typeNodeCount[0]=0;
			typeNodeCount[1]=0;
			typeNodeCount[2]=0;
			typeNodeCount[3]=0;

			for node_idx in GatherItems[gi_cont][gi_zone] do
				for index in GatherItems[gi_cont][gi_zone][node_idx] do
					local gtype;
					if ( type(GatherItems[gi_cont][gi_zone][node_idx][index].gtype) =="number" )
					then
						gtype = GatherItems[gi_cont][gi_zone][node_idx][index].gtype;
					else
						gtype = Gather_DB_TypeIndex[GatherItems[gi_cont][gi_zone][node_idx][index].gtype]
					end

					typeNodeCount[gtype] = typeNodeCount[gtype] + GatherItems[gi_cont][gi_zone][node_idx][index].count;
				end
			end

			-- assign values
			for node_idx in GatherItems[gi_cont][gi_zone] do
				local nodeCount;
				for index in GatherItems[gi_cont][gi_zone][node_idx] do
					local amount = GatherItems[gi_cont][gi_zone][node_idx][index].count;
					local gtype;
					if ( type(GatherItems[gi_cont][gi_zone][node_idx][index].gtype) == "number" )
					then
						gtype = GatherItems[gi_cont][gi_zone][node_idx][index].gtype;
					else
						gtype = Gather_DB_TypeIndex[GatherItems[gi_cont][gi_zone][node_idx][index].gtype]
					end

					nodeCount = typeNodeCount[gtype];				
				
					local found=0;
					local findex;
					for findex in GITT do
						if ( GITT[findex].name == node_idx ) then
							found = findex;
						end
					end
				
					if ( found == 0 ) then
						GITT[i] = {};
						GITT[i].name     = node_idx;

						if ( type(GatherItems[gi_cont][gi_zone][node_idx][index].gtype) == "number" ) then
							GITT[i].gatherType = Gather_DB_TypeIndex[GatherItems[gi_cont][gi_zone][node_idx][index].gtype];
						else
							GITT[i].gatherType = GatherItems[gi_cont][gi_zone][node_idx][index].gtype;
						end

						GITT[i].typePercent  = tonumber(format("%.1f",( amount / nodeCount ) * 100));
						GITT[i].densityPercent  = tonumber(format("%.1f",( amount / GI_totalCount ) * 100));

						-- divide by zero check
						if ( GITT[i].typePercent == nil ) then GITT[i].typePercent = 0; end
						if ( GITT[i].densityPercent == nil ) then GITT[i].densityPercent = 0; end

						GITT[i].amount   = tonumber(amount);

						if ( type(GatherItems[gi_cont][gi_zone][node_idx][index].icon) == "number" ) then
							GITT[i].texture  = Gather_IconSet["iconic"][GITT[i].gatherType][Gatherer_GetDB_IconIndex(GatherItems[gi_cont][gi_zone][node_idx][index].icon, GITT[i].gatherType)];
						else
							GITT[i].texture  = Gather_IconSet["iconic"][GITT[i].gatherType][GatherItems[gi_cont][gi_zone][node_idx][index].icon];
						end

						GITT[i].nodeCount = nodeCount;
						GITT[i].gi = gatherInfoOffset + i;

						i = i + 1;
					else
						GITT[found].amount = GITT[found].amount + tonumber(amount);
						GITT[found].typePercent = tonumber(format("%.1f",( GITT[found].amount / GITT[found].nodeCount ) * 100));
						GITT[found].densityPercent = tonumber(format("%.1f",( GITT[found].amount / GI_totalCount ) * 100));

						-- divide by zero check
						if ( GITT[found].typePercent == nil ) then GITT[found].typePercent = 0; end
						if ( GITT[found].densityPercent == nil ) then GITT[found].densityPercent = 0; end
						found = 0;
					end
				end
			end
		end
		SortGathererInfo(GathererInfo_LastSortType, false);
		GathererInfo_totalcount:SetText(string.gsub(string.gsub(GATHERER_REPORT_SUMMARY, "#", GI_totalCount), "&", numGathererInfo));
	end
end	

-- Add items in display frame
function GathererInfo_additem_table(gatherName, gatherNumber, gatherTexture, gatherType, typePercent, densityPercent, GIlocation, GIIndex)

	if ( GIlocation < GATHERERINFO_TO_DISPLAY +1) then
		getglobal("GathererInfo_FrameButton"..GIlocation).gatherIndex = GIIndex;
		getglobal("GathererInfo_FrameButton"..GIlocation.."Icon"):SetTexture(gatherTexture);
		getglobal("GathererInfo_FrameButton"..GIlocation.."Type"):SetText(gatherType);
		getglobal("GathererInfo_FrameButton"..GIlocation.."Gatherable"):SetText(gatherName);		
		getglobal("GathererInfo_FrameButton"..GIlocation.."Number"):SetText(gatherNumber);
		getglobal("GathererInfo_FrameButton"..GIlocation.."TypePercent"):SetText(typePercent);
		getglobal("GathererInfo_FrameButton"..GIlocation.."DensityPercent"):SetText(densityPercent);
		getglobal("GathererInfo_FrameButton"..GIlocation):Show();
	end
	
end

-- **************************************************************************
-- Sort functions (common to Report and Search)
function SortGathererInfo(sortType, reverse, search)
	local compstr = {};
	local ref_ind = 0;
	local ind, newind;
	local displayed=1;
	local offSet = FauxScrollFrame_GetOffset(GathererInfo_ListScrollFrame);
	local key1, key2, key3;
	local indexToShow=0;
	local search_stub;
	
	if (search) then
		search_stub = search;
	else
		search_stub = "";
	end

	for ind in GITT do
		indexToShow = indexToShow + 1;
		compstr[ind]= {}

		-- report sort types
		if ( sortType == "gtype" ) then -- keys: type, % per type, name (default sort)
			key1 = GITT[ind].gatherType;
			key2 = format("%.6f", GITT[ind].typePercent / 10000);
			key3 = GITT[ind].name;
		elseif ( sortType == "percent")	then -- keys: % per type, type, name
			key1 = format("%.6f", GITT[ind].typePercent / 10000);
			key2 = GITT[ind].gatherType;
			key3 = GITT[ind].name;
		elseif ( sortType == "density" ) then -- keys: % density, type, name
			key1 = format("%.6f", GITT[ind].densityPercent / 10000);
			key2 = GITT[ind].gatherType;
			key3 = GITT[ind].name;
		elseif ( sortType == "name" ) then -- keys: name, type, % type
			key1 = GITT[ind].name;
			key2 = GITT[ind].gatherType;
			key3 = format("%.6f", GITT[ind].typePercent / 10000);
		elseif ( sortType == "amount" )	then -- keys: amount, type, name
			key1 = format("%.6f", GITT[ind].amount / 10000);
			key2 = GITT[ind].gatherType;
			key3 = GITT[ind].name;
		elseif ( search_stub and search_stub ~= "" ) then
			offSet = FauxScrollFrame_GetOffset(GathererInfo_SearchListScrollFrame)
			-- handle Search sort types
			if ( sortType == "Cname" ) then 
				key1 = GITT[ind].contName;
				key2 = GITT[ind].zoneName;
				key3 = format("%.6f", GITT[ind].amount / 10000);
			elseif ( sortType == "Zname" ) then
				key1 = GITT[ind].zoneName;
				key2 = GITT[ind].contName;
				key3 = format("%.6f", GITT[ind].amount / 10000);
			elseif ( sortType == "Namount" ) then
				key1 = format("%.6f", GITT[ind].amount / 10000);
				key2 = GITT[ind].contName;
				key3 = GITT[ind].zoneName;
			elseif ( sortType == "Npercent" ) then
				key1 = format("%.6f", GITT[ind].typePercent / 10000);
				key2 = GITT[ind].contName;
				key3 = GITT[ind].zoneName;
			elseif ( sortType == "Ndensity" ) then
				key1 = format("%.6f", GITT[ind].densityPercent / 10000);
				key2 = GITT[ind].contName;
				key3 = GITT[ind].zoneName;
			end
		end

		-- build sort string
		compstr[ind] = key1.."/"..key2.."/"..key3.."#"..ind
	end

	-- call sort function
	if ( reverse and not GathererInfo_LastSortReverse) then 
		sort(compstr, GI_reverse_sort);
		GathererInfo_LastSortReverse = true;
	else
		sort(compstr);
		GathererInfo_LastSortReverse = false;
	end

	-- display sorted items
	for newind, data in compstr do
		recup = tonumber(strsub(data, string.find(data, "#")+1));

		if (newind == 1) then
		  ref_ind = GITT[1].gi
		else
		  ref_ind= ref_ind + 1;
		end

		if ( newind > offSet and displayed < GATHERERINFO_TO_DISPLAY+1) then
			if ( search_stub == "" ) then
				GathererInfo_additem_table(GITT[recup].name, GITT[recup].amount, GITT[recup].texture, GITT[recup].gatherType, GITT[recup].typePercent, GITT[recup].densityPercent, newind - offSet, ref_ind);
			elseif ( search_stub == "Search" ) then
				GathererInfo_additem_searchtable(GITT[recup].contName, GITT[recup].amount,
				 GITT[recup].zoneName, GITT[recup].typePercent,
				 GITT[recup].densityPercent, newind - offSet, ref_ind)
			end
			displayed=displayed+1;
		end
	end

	local j=displayed;
	while (j < GATHERERINFO_TO_DISPLAY+1) do
		getglobal("GathererInfo_"..search_stub.."FrameButton"..j):Hide();
		j = j+1;
	end	

	FauxScrollFrame_Update(getglobal("GathererInfo_"..search_stub.."ListScrollFrame"), indexToShow, GATHERERINFO_TO_DISPLAY, GATHERERINFO_FRAME_HEIGHT);
	
	if( search_stub == "") then
		GathererInfo_LastSortType = sortType;
	elseif ( search_stub == "Search" ) then
		GathererInfo_LastSearchSortType = sortType;
	end
end

function GI_reverse_sort(token1, token2)
	return token1 > token2;	
end

-- ***********************************************************
-- Search UI functions
function GathererInfo_GatherTypeDropDown_Initialize()
	local index;
	local info = {};

	for index in Gather_DB_TypeIndex do
		if ( index ~= "Default" and type(index) == "string" ) then
			info.text = index;
			info.checked = nil;
			info.func = GathererInfo_GatherType_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	end
end

function GathererInfo_GatherType_OnClick()
	UIDropDownMenu_SetSelectedID(GathererInfo_GatherTypeDropDown, this:GetID());
	UIDropDownMenu_SetSelectedID(GathererInfo_GatherItemDropDown, 0);
	
	UIDropDownMenu_SetText("", GathererInfo_GatherItemDropDown);

	UIDropDownMenu_ClearAll(GathererInfo_GatherItemDropDown);
	UIDropDownMenu_Initialize(GathererInfo_GatherItemDropDown, GathererInfo_GatherItemDropDown_Initialize);

	local j=1;
	while (j < GATHERERINFO_TO_DISPLAY+1) do
		getglobal("GathererInfo_SearchFrameButton"..j):Hide();
		j = j+1;
	end	
end

function GathererInfo_GatherItemDropDown_Initialize()
	local index;
	local info = {};
	local selectedGatherTypeText = UIDropDownMenu_GetText(GathererInfo_GatherTypeDropDown);
	local selectedGatherType
	
	if ( selectedGatherTypeText ) then
		selectedGatherType = Gather_DB_TypeIndex[selectedGatherTypeText];

		for index in Gather_DB_IconIndex[selectedGatherType] do
			if (index ~= "default" ) then
				info.text = index;
				info.checked = nil;
				info.func = GathererInfo_GatherItem_OnClick;
				UIDropDownMenu_AddButton(info);
			end
		end
	end
end

function GathererInfo_GatherItem_OnClick()
	local item_to_search, search_item;
	local gi_cont, gi_zone, gi_node, gi_index;

	UIDropDownMenu_SetSelectedID(GathererInfo_GatherItemDropDown, this:GetID());

	item_to_search = UIDropDownMenu_GetText(GathererInfo_GatherItemDropDown)
	_, _, search_item = string.find(item_to_search, "^([^ ]+)");
	GI_totalCount = 0;

	for gi_cont in GatherItems do
		for gi_zone in GatherItems[gi_cont] do
			for gi_node in GatherItems[gi_cont][gi_zone] do
				if ( string.find(gi_node, search_item, 1, true) ) then
					local skip_node=-1;
					for gi_index in GatherItems[gi_cont][gi_zone][gi_node] do
						if ( skip_node == -1 ) then
							local locIcon, locGtype;

							-- check gather type
							locGtype = GatherItems[gi_cont][gi_zone][gi_node][gi_index].gtype;
							if ( locGtype and type(locGtype) == "string" ) then
								locGtype = Gather_DB_TypeIndex[locGtype];
							end
							locIcon = GatherItems[gi_cont][gi_zone][gi_node][gi_index].icon;
							if ( (type(locIcon) == "string" and locIcon == search_item) or
								 (type(locIcon) == "number" and locIcon == Gather_DB_IconIndex[locGtype][item_to_search] )) then
								skip_node=0
								GI_totalCount = GI_totalCount +1;
							else
								skip_node=1
							end
						elseif ( skip_node == 0 ) then
							GI_totalCount = GI_totalCount +1;
						else
							break;
						end
					end
				end
			end
		end
	end

	GathererInfo_SearchUpdate();
end

function GathererInfo_SearchUpdate()
	local node_idx, index;
	local gatherInfoOffset = FauxScrollFrame_GetOffset(GathererInfo_SearchListScrollFrame);
	local item_to_search = UIDropDownMenu_GetText(GathererInfo_GatherItemDropDown);
	local search_item;
	local gi_cont, gi_zone, gi_loc;
	local gatherInfoIndex;
	local showScrollBar = nil;
	local button;
	local i = 1;
	GITT = {};

	-- if database exists
	if ( GatherItems and item_to_search ) then
		_, _, search_item = string.find(item_to_search, "([^ ]+)");
		for gi_cont in GatherItems do
			if ( gi_cont == 0 or not GathererInfoZones[gi_cont] ) then
				Gatherer_ChatPrint("Gatherer: Warning invalid continent index ("..gi_cont..") found in data.");
			else 
				for gi_zone in GatherItems[gi_cont] do
					if ( gi_zone == 0 or not GathererInfoZones[gi_cont][gi_zone] ) then
						Gatherer_ChatPrint("Gatherer: Warning invalid zone index ("..gi_zone..") found in "..gi_cont.." continent data.");
					else
						local nodeCount = 0;
						for node_idx in GatherItems[gi_cont][gi_zone] do
							for index in GatherItems[gi_cont][gi_zone][node_idx] do
								nodeCount = nodeCount + 1;
							end
						end
						-- assign values
						for node_idx in GatherItems[gi_cont][gi_zone] do
							local skip_node = -1;
							if ( string.find(node_idx, search_item, 1, true) ) then
								local amount = 0;
								for index in GatherItems[gi_cont][gi_zone][node_idx] do
									if ( skip_node == -1 ) then
										local locIcon, locGtype;

										-- check gather type
										locGtype = GatherItems[gi_cont][gi_zone][node_idx][index].gtype;
										if ( type(locGtype) == "string" ) then
											locGtype = Gather_DB_TypeIndex[locGtype];
										end
										locIcon = GatherItems[gi_cont][gi_zone][node_idx][index].icon;
										if ( (type(locIcon) == "string" and locIcon == search_item) or
											 (type(locIcon) == "number" and locIcon == Gather_DB_IconIndex[locGtype][item_to_search] )) then
											skip_node=0
											amount = amount + 1;
										else
											skip_node=1
										end
									elseif ( skip_node == 0 ) then
										amount = amount + 1;
									else
										break;
									end
								end

								if ( skip_node ~= 1 ) then
									local found=0;
									local findex;
									for findex in GITT do
										if ( GITT[findex].zoneName and GathererInfoZones[gi_cont][gi_zone].zone and
											 GITT[findex].zoneName == GathererInfoZones[gi_cont][gi_zone].zone ) then
											found = findex;
										end
									end
												
									if ( found == 0 ) then
										GITT[i] = {};
										GITT[i].contName = GathererInfoContinents[gi_cont];
										GITT[i].zoneName = GathererInfoZones[gi_cont][gi_zone].zone;
										GITT[i].typePercent  = tonumber(format("%.1f",( amount / nodeCount ) * 100));
										GITT[i].densityPercent  = tonumber(format("%.1f",( amount / GI_totalCount ) * 100));

										-- divide by zero check
										if ( GITT[i].typePercent == nil ) then GITT[i].typePercent = 0; end
										if ( GITT[i].densityPercent == nil ) then GITT[i].densityPercent = 0; end

										GITT[i].amount   = tonumber(amount);
										GITT[i].nodeCount = nodeCount;
										GITT[i].gi = gatherInfoOffset + i;
										i = i + 1;
									else
										GITT[found].amount = GITT[found].amount + tonumber(amount);
										GITT[found].typePercent = tonumber(format("%.1f",( GITT[found].amount / GITT[found].nodeCount ) * 100));
										GITT[found].densityPercent = tonumber(format("%.1f",( GITT[found].amount / GI_totalCount ) * 100));

										-- divide by zero check
										if ( GITT[found].typePercent == nil ) then GITT[found].typePercent = 0; end
										if ( GITT[found].densityPercent == nil ) then GITT[found].densityPercent = 0; end

										found = 0;
									end
								end
							end
						end
					end
				end
			end
		end
		local lastGITTindex = i - 1;
		SortGathererInfo(GathererInfo_LastSearchSortType, false, "Search");
		GathererInfo_Searchtotalcount:SetText(string.gsub(string.gsub(GATHERER_SEARCH_SUMMARY, "#", GI_totalCount), "&", lastGITTindex));
	end
end

-- Add items in display frame
function GathererInfo_additem_searchtable(contName, gatherNumber, zoneName, typePercent, densityPercent, GIlocation, GIIndex)

	if ( GIlocation < GATHERERINFO_TO_DISPLAY +1) then
		getglobal("GathererInfo_SearchFrameButton"..GIlocation).gatherIndex = GIIndex;
		getglobal("GathererInfo_SearchFrameButton"..GIlocation.."Type"):SetText(contName);
		getglobal("GathererInfo_SearchFrameButton"..GIlocation.."Gatherable"):SetText(zoneName);		
		getglobal("GathererInfo_SearchFrameButton"..GIlocation.."Number"):SetText(gatherNumber);
		getglobal("GathererInfo_SearchFrameButton"..GIlocation.."TypePercent"):SetText(typePercent);
		getglobal("GathererInfo_SearchFrameButton"..GIlocation.."DensityPercent"):SetText(densityPercent);
		getglobal("GathererInfo_SearchFrameButton"..GIlocation):Show();
	end
	
end
-- ***********************************************************
-- Tab selection code
function ToggleGathererInfo_Dialog(tab)
	local subFrame = getglobal(tab);
	if ( subFrame ) then
		PanelTemplates_SetTab(GathererInfo_DialogFrame, subFrame:GetID());
		if ( GathererInfo_DialogFrame:IsVisible() ) then
				PlaySound("igCharacterInfoTab");
				GathererInfo_DialogFrame_ShowSubFrame(tab);
		else
			ShowUIPanel(GathererInfo_DialogFrame);
			GathererInfo_DialogFrame_ShowSubFrame(tab);
		end
	end
end

function GathererInfo_DialogFrame_ShowSubFrame(frameName)
	for index, value in GATHERERINFO_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show()
		else
			getglobal(value):Hide();	
		end	
	end 
end
function GathererInfoFrameTab_OnClick()
	if ( this:GetName() == "GathererInfo_DialogFrameTab1" ) then
		ToggleGathererInfo_Dialog("GathererInfo_ReportFrame");
	elseif ( this:GetName() == "GathererInfo_DialogFrameTab2" ) then
		ToggleGathererInfo_Dialog("GathererInfo_SearchFrame");
	end
	PlaySound("igCharacterInfoTab");
end
