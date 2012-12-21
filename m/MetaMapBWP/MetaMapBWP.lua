
BWP_NAME = "MetaMapBWP";
BWP_IMAGE_PATH = "Interface\\AddOns\\MetaMapBWP\\Artwork\\Arrows\\"
BWP_BUTTON_HEIGHT = 16;
BWP_BUTTON_COUNT = 11;

BWP_Options = {};
BWP_Data = {};
BWP_CZone = {};
BWP_Destination = nil;
BWP_Data["Kalimdor"] = {};
BWP_Data["Eastern Kingdoms"] = {};

local BWPnode = {};
local BWPmeta = {};
local BWPDisp = {};
local BWPDispm = {};

BWP_CountDown = 0;
BWP_SetDist = 0;
BWP_ArrowIcon = nil;
BWP_playerIsDead = false;
BWP_GuardActive = false;

BWP_Highlighttext ="|cffFFFFFF";
BWP_Redtext="|cffFF0000";
BWP_Greentext = "|cff00FF00";

local BWP_Zones = {};
local BWP_KalimdorZones = {};
local BWP_EasternZones = {};
local BWP_Player = nil;
local BWP_SetSpecial = false;
local BWP_SpecialDest = 0;
local old_ToggleDropDownMenu = ToggleDropDownMenu;
local Old_AbandonQuest =  AbandonQuest
oldBWPFOLLOW_UnitPopup_OnClick = UnitPopup_OnClick
-- Query redirect
BWPDispm.__index = SNDisp;
-- Query redirect
BWPmeta.__index = BWPnode;
local BWP_FirstLoad = true;
local gdpx, gdpy, gddx, gddy, gddir, gdclx, gdcly;
--Map Variables below
local MAX_LOC_SAMPLES = 50;-- Circular arrays to store X,Y,time locations
local LOC_X_SAMPLES = {};
local LOC_Y_SAMPLES = {};
local LOC_T_SAMPLES = {};	
-- The last index written into
local lastIdx = 0;
-- Last coordinates, used to avoid spamming location arrays
local lastX,lastY = 0,0;
-- Configuration/thresholds -- Tune these together with coordinate
-- system for a balance of update speed and jitter reduction
-- Make sure that MIN_CUMUL_RANGE is at least 2 times as large as	
-- MIN_SAMPLE_DISTANCE (Preferably between about 3-10 times)
-- Minimum change in at least one direction to store something	
local MIN_SAMPLE_DISTANCE = 0.0001;
-- Maximum age of an old record to look at
local MAX_CUMUL_TIME = 2.0;
-- Minimum range for a significant vector
local MIN_CUMUL_RANGE = 0.0003;
-- Square of minimum range to avoid an unnecessary sqrt
local MIN_CUMUL_RANGE_SQ = MIN_CUMUL_RANGE * MIN_CUMUL_RANGE;
-- Last degree value, just here for debugging sanity
local lastDeg = nil;

function BWP_SetVars()
	if(BWP_Options.ShowYards == nil) then BWP_Options.ShowYards = false; end
	if(BWP_Options.ShowCorpse == nil) then BWP_Options.ShowCorpse = false; end
	if(BWP_Options.ShowOnGuard == nil) then BWP_Options.ShowOnGuard = false; end
	if(BWP_Options.SetAlpha == nil) then BWP_Options.SetAlpha = 1.0; end
	if(BWP_Options.SetDistance == nil) then BWP_Options.SetDistance = 0.0040; end
	if(BWP_Options.ShowPoints == nil) then BWP_Options.ShowPoints = true; end
	if(BWP_Options.ShowNPC == nil) then BWP_Options.ShowNPC = true; end
	if(BWP_Options.ClearDest == nil) then BWP_Options.ClearDest = true; end
end

function BWP_OnLoad()
	SLASH_BWPCOMMAND1 = "/bwp"; 
	SlashCmdList["BWPCOMMAND"] = BWP_LocCommand
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("QUEST_GREETING");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("QUEST_COMPLETE");
	this:RegisterEvent("QUEST_FINISHED");
	this:RegisterEvent("QUEST_GREETING");
	this:RegisterEvent("QUEST_ACCEPT_CONFIRM");
	this:RegisterEvent("GOSSIP_CLOSED");
	this:RegisterEvent("PLAYER_DEAD");
	table.insert(UnitPopupMenus["PLAYER"],"BWPFOLLOW")
	table.insert(UnitPopupMenus["PARTY"],"BWPFOLLOW")
	table.insert(UnitPopupMenus["RAID"],"BWPFOLLOW")
	UnitPopupButtons["BWPFOLLOW"] = { text = "Set As Waypoint", dist = 0 } 
end

function BWP_OnEvent(event)
	if(event == "ADDON_LOADED") then
		BWP_SetVars()
		BWP_OptionsInit();
		BWP_Generate()
		MetaKBMenu_RBSelect = BWP_ShowKBMenu;
		MetaMapNotes_RBSelect = BWP_ShowNoteMenu;
	end
	if(event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") then
		BWP_OptionsInit();
	end
	if (event == "UNIT_NAME_UPDATE" and arg1 == "player") then 
		if (BWP_FirstLoad) then
			BWP_Player = UnitName("player");
			if (playerName ~= UNKNOWNOBJECT) then 
				BWP_FirstLoad = nil;
			end
		end
	end
	if(event == "GOSSIP_CLOSED") then
		BWP_SetSpecial = true;
		BWP_SpecialDest = 2;
	end
	if(event == "QUEST_COMPLETE") then
		local title = GetTitleText() or "";
		clearquest(title)
	end
	if(strsub(event,1,16) == "CHAT_MSG_SYSTEM") then
		local msg = arg1;
		local plr = arg2;
		if ( (msg and msg ~= nil) and (plr and plr ~= nil) ) then
			local _,_,questname = string.find(msg,"Quest accepted: (.*)")
			if(questname) then
				BWP_AddQuest(questname)
			end						
		end
	end
end

function BWP_OnUpdate(arg)
	if(UnitIsDeadOrGhost("player")) then
		DeadMan();
	else
		BWP_Alive();
	end
	if(BWP_SetSpecial) then BWP_Special_Dest(); end

	if(BWP_CountDown > 0) then 
		BWP_CountDown = BWP_CountDown - 1; 
		if(BWP_CountDown == 1 and BWP_Options.ClearDest) then
			BWP_CountDown = 0;
			if(BWP_SpecialDest) then
				BWP_SpecialOff();
			else
				BWP_ClearDest();
			end
		end
		return;
	end
	if(BWP_Destination) then
		local UpdateBWP = BWP_GetDir();
		if(UpdateBWP) then BWP_SetRotation(UpdateBWP); end
		BWPDistanceText:SetText(BWP_GetDistText())
	end
end

function  BWP_LocCommand(msg)
	local name = "QuickLoc";
	local i,j,x,y,tmp = string.find(msg,"%s*(%d+)%s*[,.]%s*(%d+)%s*([^%c]*)");
	if(x == nil or y == nil) then
		SetMapToCurrentZone();
		x, y = GetPlayerMapPosition("player");
		if(msg ~= "" and msg ~= nil) then
			name = msg;
		end
	else
		x = x / 100;
		y = y / 100;
		if(tmp ~= "" and tmp ~= nil) then
			name = tmp;
		end
	end
	setmininote(x, y, name, 7);
	BWP_OptionsInit();
end

function BWP_SelectionDropDown_OnLoad()
	UIDropDownMenu_Initialize(BWP_OptionsDropDown, BWP_DropDownFrame_Initialize );
	UIDropDownMenu_SetWidth(80);
end

function ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
	if(this:GetParent()) and (this:GetParent():GetName())and(this:GetParent():GetName()== "BWP_MenuFrame_DropDown")then
		BWP_MenuFrame:Show();
		old_ToggleDropDownMenu(level, value, dropDownFrame,"BWP_MenuFrame", xOffset, yOffset)
	else
		old_ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
		BWP_MenuFrame:Hide();
	end
	return nil
end

function BWP_OptionsInit()
	if(BWP_Options.SetAlpha < 0.15) then BWP_Options.SetAlpha = 0.15; end
	BWP_DistanceSlider:SetValue(BWP_Options.SetDistance);
	BWP_AlphaSlider:SetValue(BWP_Options.SetAlpha);
	if(BWP_Destination and BWP_Destination.zone == GetRealZoneText()) then
		BWPDestText:SetText("("..BWP_Destination.name..")");
		BWPDistanceText:SetText(BWP_GetDistText())
		BWP_DisplayFrame:Show();
	else
		BWP_DisplayFrame:Hide();
	end
end

function MetaMapBWP_UpdateDistance()
	BWP_Options.SetDistance = this:GetValue();
	local dist = MetaMap_round(this:GetValue() * 4000)
	BWP_SetDistText:SetText(dist);
end

function MetaMapBWP_UpdateAlpha()
	BWP_Options.SetAlpha = this:GetValue();
	BWP_DisplayFrame:SetAlpha(BWP_Options.SetAlpha);
end

function MetaMapBWPMenu_Init()
	local items = 0;
	for i=1, BWP_BUTTON_COUNT, 1 do
		local button = getglobal("MetaMapBWPMenu_Option"..i);
		button:SetHeight(BWP_BUTTON_HEIGHT);
		if(i == 1) then
			button:SetText("Always load on startup");
			button.toggle = MetaMapOptions.BWPalwaysOn;
		elseif(i == 2) then
			button:SetText(BWP_SHOW_CORPSE);
			button.toggle = BWP_Options.ShowCorpse;
		elseif(i == 3) then
			button:SetText(BWP_SHOW_GUARD);
			button.toggle = BWP_Options.ShowOnGuard;
		elseif(i == 4) then
			button:SetText(BWP_SHOW_QNPC);
			button.toggle = BWP_Options.ShowNPC;
		elseif(i == 5) then
			button:SetText(BWP_SHOW_MAPPOINTS);
			button.toggle = BWP_Options.ShowPoints;
		elseif(i == 6) then
			button:SetText(BWP_CLEAR_ARRIVE);
			button.toggle = BWP_Options.ClearDest;
		elseif(i == 7) then
			if(BWP_Options.ShowYards) then
				button:SetText(BWP_SHOW_METRES);
			else
				button:SetText(BWP_SHOW_YARDS);
			end
			button.toggle = false;
		elseif(i == 8) then
			button:SetHeight(10); -- Spacer
		elseif(i == 9) then
			button:SetText(BWP_CLEAR_DEST);
			button.toggle = false;
		elseif(i == 10) then
			button:SetHeight(0); -- Spare
			button.toggle = false;
		elseif(i == 11) then
			button:SetHeight(0); -- Spare
			button.toggle = false;
		end
		if(button.toggle) then
			getglobal("MetaMapBWPMenu_Option"..i.."Check"):Show();
		else
			getglobal("MetaMapBWPMenu_Option"..i.."Check"):Hide();
		end
		button:Show();
		items = i;
	end
	MetaMapBWPMenu:ClearAllPoints();
	local yPos = "TOP";
	local xPos = "RIGHT";
	local x, y = GetCursorPosition();
	x = x / UIParent:GetEffectiveScale() +15;
	y = y / UIParent:GetEffectiveScale() +15;
	if(y <= (UIParent:GetHeight() /2)) then yPos = "BOTTOM"; y = y +50; end
	if(x <= (UIParent:GetHeight() /2)) then xPos = "LEFT"; x = x -30; end
	MetaMapBWPMenu:SetPoint(yPos..xPos, "UIParent", "BOTTOMLEFT", x, y);
	MetaMapBWPMenu:SetHeight((BWP_BUTTON_HEIGHT *items) + (BWP_BUTTON_HEIGHT *2));
	PlaySound("UChatScrollButton");
	MetaMapBWPMenu:Show();
end

function MetaMapBWPMenu_Select(id)
	local button = getglobal("MetaMapBWPMenu_Option"..id);
	if(id == 1) then
		MetaMapOptions.BWPalwaysOn = not MetaMapOptions.BWPalwaysOn;
		button.toggle = MetaMapOptions.BWPalwaysOn;
	elseif(id == 2) then
		BWP_Options.ShowCorpse = not BWP_Options.ShowCorpse;
		button.toggle = BWP_Options.ShowCorpse;
	elseif(id == 3) then
		BWP_Options.ShowOnGuard = not BWP_Options.ShowOnGuard;
		button.toggle = BWP_Options.ShowOnGuard;
	elseif(id == 4) then
		BWP_Options.ShowNPC = not BWP_Options.ShowNPC;
		button.toggle = BWP_Options.ShowNPC;
	elseif(id == 5) then
		BWP_Options.ShowPoints = not BWP_Options.ShowPoints;
	elseif(id == 6) then
		BWP_Options.ClearDest = not BWP_Options.ClearDest;
		button.toggle = BWP_Options.ClearDest;
	elseif(id == 7) then
		BWP_Options.ShowYards = not BWP_Options.ShowYards;
		if(BWP_Options.ShowYards) then
			button:SetText(BWP_SHOW_METRES);
		else
			button:SetText(BWP_SHOW_YARDS);
		end
		button.toggle = false;
	elseif(id == 8) then
		-- Spacer
	elseif(id == 9) then
		BWP_ClearDest();
		button.toggle = false;
	elseif(id == 10) then
		-- spare
	elseif(id == 11) then
		-- spare
	end
	if(button.toggle) then
		getglobal("MetaMapBWPMenu_Option"..id.."Check"):Show();
	else
		getglobal("MetaMapBWPMenu_Option"..id.."Check"):Hide();
	end
	BWP_OptionsInit()
end

function MetaMapBWPMenu_OnUpdate()
	if (MetaMapBWPMenu:IsVisible()) then
		if (not MouseIsOver(MetaMapBWPMenu) and not MouseIsOver(MetaMapBWPMenuSliderMenu)) then
			MetaMapBWPMenu:Hide();
		end
	end
end

function BWP_SetDest() --Sets the current Destination
	if(this.value.QuestGiver) then
		UIDropDownMenu_SetText(this.value.QuestGiver, BWP_MenuFrame_DropDown)
		setmininote(this.value.X,this.value.Y,this.value.QuestGiver,"7")
	elseif(this.value.title) then
		UIDropDownMenu_SetText(this.value.title, BWP_MenuFrame_DropDown)
		setmininote(this.value.xcoord, this.value.ycoord,this.value.title,"7")
	end
	BWP_OptionsInit();
end	

function BWP_GetDistText()
	local px , py = GetPlayerMapPosition("player")
	if(px == 0 and py==0) then 
		return "Dead Zone";
	end
	local dx, dy = nil,nil
	if(BWP_Destination and BWP_Destination.x and BWP_Destination.y) then
		dx, dy = BWP_Destination.x, BWP_Destination.y
	else 
		return nil 
	end
	local loc1,loc2 = {x = px , y= py},{x=dx,y=dy}
	local thisDistance, theseUnits , flag = BWP_FormatDist(loc1,loc2)
	if (flag == "A") then 
		return BWPGreenText("("..BWP_ARRIVED..")") 
	elseif flag == "Y" then 
		return "("..thisDistance..theseUnits..")"
	end
	local colortext = getglobal("BWP"..flag.."Text")
	local testtext = colortext(thisDistance..theseUnits)
	return "("..testtext..")"
end

function DeadMan()
	if(BWP_playerIsDead) then return; end
	deadx, deady = GetCorpseMapPosition();
	deadx = deadx * 100; deady = deady * 100;
	if(deadx and deady and deadx ~= 0 and deady ~= 0) then
		if(BWP_Destination) then
			BWP_OldDest = BWP_Destination;
		end
		BWP_playerIsDead = true;
		if(BWP_Options.ShowCorpse) then
			setmininote(deadx, deady, BWP_CORPSE_TEXT , "7");
		else
			BWP_DisplayFrame:Hide();
		end
	end
end

function BWP_Alive()
	if(not BWP_playerIsDead) then return; end
	if(BWP_OldDest)then
		local continent, zone = MetaMap_NameToZoneID(BWP_OldDest.zone);
		setmininote(BWP_OldDest.x, BWP_OldDest.y, BWP_OldDest.name, "7", continent, zone);
		BWP_OldDest = nil;
		BWP_playerIsDead = false;
	elseif(BWP_playerIsDead)then
		BWP_playerIsDead = false;
		BWP_ClearDest();
	end 
end

function BWP_SpecialOff()
	if(BWP_OldDest)then
		local continent, zone = MetaMap_NameToZoneID(BWP_OldDest.zone);
		setmininote(BWP_OldDest.x, BWP_OldDest.y, BWP_OldDest.name, "7", continent, zone);
		BWP_OldDest = nil;
	else
		BWP_ClearDest();
	end
	BWP_SpecialDest = 0;
end

function UnitPopup_OnClick()
	if UnitPopupMenus[this.owner][this.value]=="BWPFOLLOW" then
		BWPFOLLOW_Name = UnitName(getglobal(UIDROPDOWNMENU_INIT_MENU).unit)
		if(not BWPFOLLOWPLAYER) then
			BWP_TargetPlayer = string.lower(BWPFOLLOW_Name);
			BWP_SetSpecial = true; 
			BWP_SpecialDest = 1
			BWPFOLLOWPLAYER = 1
			DEFAULT_CHAT_FRAME:AddMessage("Now Following "..BWPFOLLOW_Name)
			UnitPopupButtons["BWPFOLLOW"] = { text = "Stop Following", dist = 0 } 
		else
			BWPFOLLOWPLAYER = nil
			BWP_SetSpecial = false; 
			BWP_SpecialDest = 0;
			BWP_ClearDest()
			DEFAULT_CHAT_FRAME:AddMessage("No Longer Following "..BWPFOLLOW_Name)
			UnitPopupButtons["BWPFOLLOW"] = { text = "Set As Waypoint", dist = 0 } 
		end	
	end
	oldBWPFOLLOW_UnitPopup_OnClick()
end 

function BWP_DropDownFrame_Initialize() --Create Dropdown
	if( UIDROPDOWNMENU_MENU_LEVEL == 1) then
		descript = {};
		descript.text = BWPGreenText("-"..BWP_NAME.." "..BWP_OPTION_TEXT.."-")
		descript.func = BWP_ShowOptions;
		UIDropDownMenu_AddButton(descript)
		
		info = {}
		info.text = BWP_SELECTMSG
		info.notClickable = 1;
		info.isTitle = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		local x, y = GetPlayerMapPosition("player");
		if(x == 0 and y == 0)then 
			--Header 
			info = {
				text = BWP_NILLOCATION;
				notClickable = 1;
				isTitle = 1;
				notCheckable = 1; }
			UIDropDownMenu_AddButton(info);
			return;
		end
	end
	BWP_Generate();
	bwpx,bwpy = nil,nil
	local BWP_BREAK_IT_DOWN = nil
	if(BWP_numpoints() > 20) then BWP_BREAK_IT_DOWN = 1 end
	if(BWP_Options.ShowPoints) then
		if(not BWP_BREAK_IT_DOWN) or  ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
			local ZonePoints = {nil}
			local isExtra = nil
			if(this.value == "BWP_CZone") then
				ZonePoints = getglobal(this.value)
			elseif(this.value) and (BWP_CZone_XTRA) and (BWP_CZone_XTRA[this.value])then
				ZonePoints = BWP_CZone_XTRA[this.value]
			elseif(not this.value) then
				ZonePoints = BWP_CZone
			end
			if(ZonePoints) then
				for val,k in ZonePoints do
					if(k) then
						title =  ZonePoints[val].title;
					end
					if (strlen(title) >= 24) then 
						title = strsub(title, 1, 21).."..."; 
					end
					if (title == "") then 
						title = SN_CZone[val]:getNote1();
					end
					descript = {}
					descript.text = val..".  "..title;
					descript.func = BWP_SetDest;
					descript.value = k;
					descript.notCheckable = 1;
					UIDropDownMenu_AddButton(descript, UIDROPDOWNMENU_MENU_LEVEL);
				end
			end
		else --Break It Down Too many Points		
			info = {};
			info.text = BWP_Get_MenuTitle(BWP_CZone);
			info.hasArrow = 1;
			info.value = "BWP_CZone";
			UIDropDownMenu_AddButton(info);
			if(BWP_CZone_XTRA) then
				for k,v in BWP_CZone_XTRA do
					if(BWP_Get_MenuTitle(v)) then
					local info = {};
					info.text = BWP_Get_MenuTitle(v);
					info.hasArrow = 1;
					info.value = k;
					UIDropDownMenu_AddButton(info);
					descript.notCheckable = 1;
					end
				end
			end
		end	
	end
	
	local LocalQList = BWP_GetQuestList()
	if(LocalQList and BWP_Options.ShowNPC) then
		if(not BWP_BREAK_IT_DOWN) or (( UIDROPDOWNMENU_MENU_LEVEL == 2 ) and (this.value == "Q")) then
			table.sort(LocalQList,BWPSortByQuestGiverName)
			local thisindex = 0
			for v, thisquest in LocalQList do
				if(thisquest) then 
					descript = {};--Make our menu Options
					descript.text = BWP_NPC_TEXT..thisquest["QuestGiver"];
					descript.func = BWP_SetDest;
					descript.value = thisquest;
					descript.notCheckable = 1;
					UIDropDownMenu_AddButton(descript,UIDROPDOWNMENU_MENU_LEVEL );
				end
			end	
		elseif(UIDROPDOWNMENU_MENU_LEVEL == 1) then
			local info = {};
				local info = {};
				info.text = BWP_QUEST_NPCSTRING	;
				info.hasArrow = 1;
				info.value = "Q";
				descript.notCheckable = 1;
				UIDropDownMenu_AddButton(info);
		end
	end
end

function BWP_Get_MenuTitle(MList)
	local tempstring = nil
	local firstword,lastword = nil, nil
	for k,v in MList do
		
		if(not tempstring) then -- if its our first word in the List
			if(v.title) then 
				tempstring = v.title 
			elseif (v.QuestGiver) then 
				tempstring = v.QuestGiver 
			end --set tempstring(so it will have a value)
			firstword = tempstring
		else
			if(v.title) then 
				tempstring = v.title 
			elseif (v.QuestGiver) then 
				tempstring = v.QuestGiver 
			end
		end
		
	end
	if(tempstring) and (firstword) then
		lastword = strsub(tempstring, 1, 5)
		firstword = strsub(firstword, 1, 5)
		return "Notes: "..firstword.." - "..lastword
	else return nil end
end

function BWP_ShowOptions()
	MetaMapBWPMenu_Init();
end

function BWP_ClearDest() --Removes current destination
	UIDropDownMenu_SetText(nil, BWP_MenuFrame_DropDown)
	if(MiniNotePOI)then
		MetaMapNotes_ClearMiniNote();
	end
	BWP_Destination = nil;
	BWP_SetSpecial = false; 
	BWP_SpecialDest = 0;
	if(BWPFOLLOWPLAYER)then	BWPFOLLOWPLAYER = nil; UnitPopupButtons["BWPFOLLOW"] = { text = "Set As Waypoint", dist = 0 }; end
	BWP_DisplayFrame:Hide();
	BWP_Arrow:SetTexture(BWP_IMAGE_PATH.."forward");
end

function BWPGreenText(inText) --TextOverride
	if (inText) then
		return BWP_Greentext..inText..FONT_COLOR_CODE_CLOSE;
	end
end
function BWPRedText(inText) --Text Override
	if (inText) then
		return BWP_Redtext..inText..FONT_COLOR_CODE_CLOSE;
	end
end
function BWPHilightText(inText)	 --Text Override
	if (inText) then
		return BWP_Highlighttext..inText..FONT_COLOR_CODE_CLOSE;
	end
end

function BWP_SpecialOn()
	local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
	local continent, zone = MetaMap_NameToZoneID(GetRealZoneText());
	local name, unknown, textureIndex, x, y;
	for landmarkIndex = 1, GetNumMapLandmarks(), 1 do
		name, unknown, textureIndex, x, y = GetMapLandmarkInfo(landmarkIndex);
		if (textureIndex == 6) then
			if(BWP_Destination) then
				BWP_OldDest = BWP_Destination;
			end
			setmininote(x, y, name, "7", continent, zone);
		end
	end
end

function clearquest(title)	--Removes a quest/questgiver
	_,_,realtitle = string.find(title,".*%[%d%]% (.*)")
	if(realtitle)then
		
		title = realtitle
	end
	if(BWP_QuestList)then
		for v, thisquest in BWP_QuestList do
			if(string.find(thisquest["QuestName"],title))then
				if(thisquest["QuestName"] == title) then
					if(BWP_Destination) and (thisquest["QuestGiver"] == BWP_Destination.name)then
						BWP_ClearDest()
					end
					
					BWP_QuestList[v]= nil
					tempQuestlist = {}
					local index = 1 
					for i,q in BWP_QuestList do
						tempQuestlist[index] = q
						index = index + 1
					end
					BWP_QuestList = tempQuestlist
				else
					BWPqnamestring=BWP_QuestList[v]["QuestName"]
					_,_,tempstring1 = string.find(BWPqnamestring,"(.*)"..title)
					_,_,tempstring2 = string.find(BWPqnamestring,".*"..title.."%,(.*)")
					if(not tempstring1)and (tempstring2)then 
						BWPqnamestring = tempstring2
					elseif(not tempstring2)and(tempstring1)then
						BWPqnamestring = tempstring1
					elseif(tempstring2) and (tempstring1) then
						BWPqnamestring = tempstring1..tempstring2
					else
						DEFAULT_CHAT_FRAME:AddMessage("ERROR ON QUEST TURN IN:BWP[Unable to perform string operation]")
					end
					BWP_QuestList[v]["QuestName"]=BWPqnamestring
				end
			end
		end
	end
end
	
function BWP_numpoints()
	if(table.getn(BWP_CZone) > 20 ) then BWP_ChecknumPOI() end
	local tempnum = 0
	if(BWP_CZone) then
			tempnum = table.getn(BWP_CZone)
	end
	if (BWP_CZone_XTRA) then 
		if(BWP_CZone_XTRA[1]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[1]) end
		if(BWP_CZone_XTRA[2]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[2]) end
		if(BWP_CZone_XTRA[3]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[3]) end
		if(BWP_CZone_XTRA[4]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[4]) end
		if(BWP_CZone_XTRA[5]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[5]) end
		if(BWP_CZone_XTRA[6]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[6]) end
		if(BWP_CZone_XTRA[7]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[7]) end
		if(BWP_CZone_XTRA[8]) then tempnum = tempnum + table.getn(BWP_CZone_XTRA[8]) end -- max number of second menus
	end
	if(BWP_QuestList) then
		for v, thisquest in BWP_QuestList do
			if(thisquest)and(thisquest.Zone == GetCurrentMapZone())then
				tempnum = tempnum + 1
			end
		end
	end
	return tempnum
end

function BWP_Special_Dest()
	if(BWPFOLLOWPLAYER)then
		if(BWP_TargetPlayer) then
			local bwpthisflag 
			local playeridindex = GetNumRaidMembers()
			if (playeridindex == 0) then playeridindex = GetNumPartyMembers();bwpthisflag = nil else  bwpthisflag = "R" end
			if (playeridindex == 0 ) then
				DEFAULT_CHAT_FRAME:AddMessage(BWPGROUPERROR)
				BWP_SpecialDest = 0;
				BWP_SetSpecial = false; 
			else
				if(bwpthisflag) then -- if its a raid group
					for x =  1, playeridindex do
					local Rname, Rrank, Rsubgroup, Rlevel, Rclass, RfileName, Rzone, Ronline = GetRaidRosterInfo(x)
						if (Rname) then
							local tempuid = "raid"..x
							if(string.lower(Rname) == BWP_TargetPlayer) then
								BWP_TargetUnitID = tempuid
								
							elseif(x == 1) then --If the player wasnt found in the current group
								DEFAULT_CHAT_FRAME:AddMessage(BWPGROUPERROR1)
								BWP_SpecialDest = 0;
								BWP_SetSpecial = false; 
								BWPFOLLOWPLAYER = nil
							end
						end
					end
				else -- its a normal PARTy
					for x = 1,playeridindex do
						if (GetPartyMember(x)) then  --Doesnt work in Raid :(
							local tempuid = "party"..x
							if(string.lower(UnitName(tempuid)) == BWP_TargetPlayer) then
								BWP_TargetUnitID = tempuid
								
							elseif(x == playeridindex) and (not BWP_TargetUnitID) then --If the player wasnt found in the current group
								DEFAULT_CHAT_FRAME:AddMessage(BWPGROUPERROR2)
								BWP_SpecialDest = 0;
								BWP_SetSpecial = flase; 
								BWPFOLLOWPLAYER = nil;
							end
						end
					end
				end
				if(BWP_TargetUnitID) then
					local posX, posY = GetPlayerMapPosition(BWP_TargetUnitID)
					BWP_TargetUnitID = nil
					BWP_Destination = {
						name = BWP_TargetPlayer,
						x = posX ,
						y = posY ,			
						zone = GetRealZoneText()}						
					BWP_SetRotation();
				end
			end
		end
	else
		if(BWP_SpecialDest == 2) then
			BWP_SetSpecial = false; 
			BWP_SpecialOn();
		end
	end
end	
			
function BWP_GetQuestList() -- Returns an Array of QuestNPC Data
	local localquestlist = {}
	if(BWP_QuestList) then
		for k,v in BWP_QuestList do
			zone = GetCurrentMapZone()
			if(v.Zone == zone) then
				table.insert(localquestlist,v)
			end
		end
	end
	return localquestlist
end

function BWP_AddQuest(questname)--Adds a quest giver to waypoint menu
	if(UnitExists("target")) and(not UnitIsPlayer("Target")) and (UnitReaction("Player", "Target")>3)and (not UnitAffectingCombat("Player"))and ((UnitName("target")~= nil)or(UnitName("target")~= "")) then
		if (not BWP_QuestList) then
	    BWP_QuestList = {}
			local Questlist ={}
			local questitem = {}
			questitem["QuestName"] = questname
			questitem["QuestGiver"] = UnitName("Target")
			questitem["X"],questitem["Y"] = GetPlayerMapPosition("Player")
			questitem["Zone"]= GetCurrentMapZone()
			Questlist[1] = questitem
			BWP_QuestList = Questlist
		else
			local Questlist = BWP_QuestList
			local questitem = {}
			local index = 0
			questitem["QuestName"] = questname
			questitem["QuestGiver"] = UnitName("Target")
			questitem["Zone"]= GetCurrentMapZone()
			questitem["X"],questitem["Y"] = GetPlayerMapPosition("Player")
			for k,v in Questlist do 
				index = index + 1
				if(UnitName("Target") == v["QuestGiver"]) then
					if(v["QuestName"])then
						questitem = nil
						questitem = v 
						if(questitem["QuestName"])then
							if(not string.find(questitem["QuestName"],questname))then
								questitem["QuestName"] = (questitem["QuestName"]..","..questname)
							end
						end
					end
					Questlist[index] = questitem
					BWP_QuestList = Questlist
					return 1
				end
			end
			Questlist[index+1] = questitem
			BWP_QuestList = Questlist
		end
	end
end

--Abandon quest to know when you drop a quest and no longer require that questgiver
function  AbandonQuest() 
	local title = GetAbandonQuestName()
	if(title)then
		DEFAULT_CHAT_FRAME:AddMessage("Abandoning:"..title)
		clearquest(title)
	end
	Old_AbandonQuest()
	return Old_AbandonQuest
end

function setmininote(x, y, name, icon, continent, zone)
	if(continent == nil or zone == nil) then
		continent, zone = MetaMap_NameToZoneID(GetRealZoneText());
	end
	if(type(continent) == "string") then return; end
	if(x >= 1) then x = x / 100; end
	if(y >= 1) then y = y / 100; end
	MetaMapNotes_AddNewNote(continent, zone, x, y, name, "", "", "MetaMapBWP", icon, 0, 0, 0, 2);
	BWP_Destination = {};
	BWP_Destination.name = name;
	BWP_Destination.x = x;
	BWP_Destination.y = y;
	BWP_Destination.zone = MetaMap_ZoneNames[continent][zone];
	BWPDestText:SetText("("..BWP_Destination.name..")");
	BWPDistanceText:SetText(BWP_GetDistText())
	BWP_DisplayFrame:Show();
end

--Set up Mini Menu
function BWP_MiniDropMenu_OnLoad()
   UIDropDownMenu_Initialize(this, BWP_MiniDropMenu_Initialize);
   UIDropDownMenu_SetWidth(80, BWP_MiniDropMenu);
end 

--Initialize minimenu with options
function BWP_MiniDropMenu_Initialize()
	local info;
	if(tempitem_XBWP) then -- Make sure you have a valid object
	   if(tempitem_XBWP.X and tempitem_XBWP.Y) then -- Make sure X and Y coords Exist(means were in same zone)
		   info = {};
		   info.text = BWP_INFO_TEXT2..tempitem_XBWP.Name..BWP_INFO_TEXT3; --Option message "Set"..$name.."as waypoint"
		   info.func = QuickSetMiniMenu; -- Function to set as destination
		   info.value = tempitem_XBWP --Pass the object value
		   tempitem_XBWP = nil
		   UIDropDownMenu_AddButton(info);
		else --X and Y dont Exist so its not in out current zone
			info = {};
			info.text = BWP_INFO_TEXT1..tempitem_XBWP.Name..BWP_INFO_TEXT3; --non click message "Must be in same zone blah blah"
			info.isTitle = 1
			tempitem_XBWP = nil
			UIDropDownMenu_AddButton(info);
		end
	end
end

--sets a mininote from the value passed by the mini menu
function  QuickSetMiniMenu()
	UIDropDownMenu_SetText(this.value.Name, BWP_MenuFrame_DropDown);
	setmininote(this.value.X,this.value.Y,this.value.Name, "7", this.value.continent, this.value.zone);
	BWP_OptionsInit();
end

function BWP_CallMenu()
	ToggleDropDownMenu(1,1,BWP_MenuFrame_DropDown, "cursor",-150,0)
end

function BWP_ShowKBMenu(id)
	local centerx, centery;
	local name = getglobal("MetaKB_ScrollFrameButton"..id.."Name"):GetText();
	local zCheck = getglobal("MetaKB_ScrollFrameButton"..id.."Coords"):GetText();
	if(string.find(zCheck, "%(%d+\.?-?%d*%)?, %(?%d+\.?-?%d*%)")) then
		local continent, zone = MetaMap_NameToZoneID(GetRealZoneText());
		local coords = MetaKB_Data[MetaKB_dbID][name][continent][zone];
		local dx = coords[2]/100 - coords[4]/100;
		local dy = coords[3]/100 - coords[1]/100;
		centerx = MetaMap_round(coords[4]/100 + dx/2, 0);
		centery = MetaMap_round(coords[1]/100 + dy/2, 0);
	end
	local cx, cy = GetCursorPosition();
	BWP_MiniDropMenu:ClearAllPoints()
	BWP_MiniDropMenu:SetPoint("BOTTOM","UIParent","BOTTOMLEFT", cx, cy)
	tempitem_XBWP ={X = centerx, Y = centery, Name = name, continent = continent, zone = zone};
	ToggleDropDownMenu(1,1,BWP_MiniDropMenu)
end

function BWP_ShowNoteMenu(id)
	local continent, zone, currentZone, mapName = MetaMap_GetCurrentMapInfo();
	if not currentZone then	return end
	tempitem_XBWP ={X = currentZone[id].xPos,Y = currentZone[id].yPos ,Name = currentZone[id].name} --call our minimenu (only option is to set waypoint)
	ToggleDropDownMenu(1,1,BWP_MiniDropMenu,"cursor",-150,0)
end


function BWP_ChecknumPOI()
	BWP_CZone_XTRA = nil
	local POIinZone = table.getn(BWP_CZone)
	if( POIinZone > 20) then
		local temp_CZone = {nil}
		BWP_CZone_XTRA = {nil}
		BWP_CZone_XTRA[1] = {nil}
		BWP_CZone_XTRA[2] = {nil}
		BWP_CZone_XTRA[3] = {nil}
		BWP_CZone_XTRA[4] = {nil}
		BWP_CZone_XTRA[5] = {nil}
		BWP_CZone_XTRA[6] = {nil}
		BWP_CZone_XTRA[7] = {nil}
		BWP_CZone_XTRA[8] = {nil}
		local BWPcount = 0
		table.sort(BWP_CZone,BWPsortbyName)
		for k,v in BWP_CZone do
			BWPcount = BWPcount + 1
			if(BWPcount < 21) then
				tinsert(temp_CZone, v)
			elseif(BWPcount < 42) then 
				tinsert(BWP_CZone_XTRA[1], v );
			elseif(BWPcount < 63) then 
				tinsert(BWP_CZone_XTRA[2], v );
			elseif(BWPcount < 84) then 
				tinsert(BWP_CZone_XTRA[3], v );
			elseif(BWPcount < 105) then 
				tinsert(BWP_CZone_XTRA[4], v );
			elseif(BWPcount < 126) then 
				tinsert(BWP_CZone_XTRA[5], v );
			elseif(BWPcount < 147) then 
				tinsert(BWP_CZone_XTRA[6], v );
			elseif(BWPcount < 168) then 
				tinsert(BWP_CZone_XTRA[7], v );
			elseif(BWPcount < 189) then 
				tinsert(BWP_CZone_XTRA[8], v );
			end
		end
		BWP_CZone = temp_CZone
	end
end


-- Constructor
function BWPnode:new(x, y, text, who) 
	return setmetatable( { xcoord = x, ycoord = y, note = text, author = who}, SNmeta);
end

-- Deconstructor
function BWPnode:delete()
	return setmetatable({}, BWPmeta);
end

--Getters
function BWPnode:getX() return self.xcoord; end
function BWPnode:getY() return self.ycoord; end
function BWPnode:getNote() return self.note; end
function BWPnode:getAuthor() return self.author; end

-- Setters
function BWPnode:setX(x) self.xcoord = x; end
function BWPnode:setY(y) self.ycoord = y; end
function BWPnode:setNote(text) self.note = text; end
function BWPnode:setAuthor(text) self.author = text; end

-- Constructor
function BWPDisp:new(x, y, who, desc, txt1, txt2, mod) 
	return setmetatable( { xcoord = x, ycoord = y, author = who, title = desc, inf1 = txt1, inf2 = txt2, type = mod }, BWPDispm);
end

-- Deconstructor
function BWPDisp:delete()
	return setmetatable({}, BWPDispm);
end

-- Getters
function BWPDisp:getX() return self.xcoord; end
function BWPDisp:getY() return self.ycoord; end
function BWPDisp:getTitle() return self.title; end
function BWPDisp:getNote1() return self.inf1; end
function BWPDisp:getNote2() return self.inf2; end
function BWPDisp:getAuthor() return self.author; end
function BWPDisp:getType() return self.type; end

function BWP_FormatCoords(x, y)
	local rx, ry, fx, fy, nx, ny;
	nx = string.format("%i", x*10000); ny = string.format("%i", y*10000);
	fx = string.format("%i", x*1000); fy = string.format("%i", y*1000);
	rx = string.format("%i", x*100); ry = string.format("%i", y*100);

	fx = tonumber(strsub(fx, strlen(fx),strlen(fx))); fy = tonumber(strsub(fy, strlen(fy), strlen(fy)));

	if (tonumber(strsub(nx, strlen(nx), strlen(nx))) >= 5) then fx = fx + 1; end
	if (tonumber(strsub(ny, strlen(ny), strlen(ny))) >= 5) then fy = fy + 1; end

	return tonumber(rx.."."..fx), tonumber(ry.."."..fy);
end

--Returns Distance(in whatever units it recieves)
function BWP_GetDist(loc1 , loc2)
	if(not loc1) or (not loc2) then return nil 
	else return math.sqrt((loc1.x - loc2.x)^2 + (loc1.y - loc2.y)^2)
	end
end

--formats to yards or meters or clicks
function BWP_FormatDist(loc1,loc2)
	local zone = GetRealZoneText();
	local thisDistance = BWP_GetDist(loc1 , loc2)
	local flag = BWP_getflag(thisDistance) -- gets the color flag based on distance in Units
	thisDistance = BWP_ConvertToYards(loc1.x, loc1.y, loc2.x, loc2.y) /10;
	if(BWP_Options.ShowYards) then
		theseUnits = " Yds"
	else
		thisDistance = thisDistance * 0.9144	
		theseUnits = " Mtrs"
	end
	thisDistance = tonumber(string.format("%.0f" , thisDistance)) -- we dont really need decimal places with this small of units
	return thisDistance, theseUnits, flag
end

function BWP_getflag(distanceinUNITS)-- Really returns a color equivilent of a distance range
	local tcd =  BWP_Options.SetDistance
	if(BWP_Options.SetDistance < 0.0040) then tcd =  0.0040 end
	if (distanceinUNITS <= (BWP_Options.SetDistance *1.215)) then 	return "A"
	elseif (distanceinUNITS < tcd * 2.452) then return "Green" --for Green Text
	elseif (distanceinUNITS < tcd * 242.5) then return "Y" --For Yellow text
	else return "Red" -- for red text
	end
end

function BWP_ConvertToYards(x1, y1, x2, y2)
	if(x1 == nil) then
		x1, y1, x2, y2 = 0, 0, 0, 0;
	end
   local dx = (x1 - x2) * 40482.686754239;
   local dy = (y1 - y2) * (40482.686754239 / 1.5);
   return math.sqrt(dx * dx + dy * dy)
end

function BWP_GetDir()
	if(not updCount)then
	 updCount = 0
	end
	updCount = updCount + 1;
	if (updCount < 2) then
		return;
	end
	updCount = 0;
	-- Find out where we are now
	local x,y = GetPlayerMapPosition("player");

	local t = GetTime();
   -- Store data if we've moved at least min sample distance
    local dx,dy = 0.00001,0.0001
	if ((x ~= 0) or (y ~= 0)) then
		dx,dy = lastX - x, lastY - y 
	end
	if ((math.abs(dx) >= MIN_SAMPLE_DISTANCE)
		or (math.abs(dy) >= MIN_SAMPLE_DISTANCE)) then
		
		lastIdx = lastIdx + 1;
		if (lastIdx > MAX_LOC_SAMPLES) then
            lastIdx = 1;
		end
		LOC_X_SAMPLES[lastIdx] = x;

        LOC_Y_SAMPLES[lastIdx] = y;

        LOC_T_SAMPLES[lastIdx] = t;

        lastX,lastY = x,y;
	end
	if (lastIdx == 0) then
      return;
   end
   
   local idx = lastIdx;
   local cx,cy,ct = LOC_X_SAMPLES[idx], LOC_Y_SAMPLES[idx];
   local ct = LOC_T_SAMPLES[idx]; 
   local cutoff = t - MAX_CUMUL_TIME;
   local tx,ty,tt;
   local found = nil;
   -- Scan back through the sample list for a long enough vector
   while (true) do
      idx = idx - 1;
      if (idx == 0) then
         idx = MAX_LOC_SAMPLES;
      end
      tx, ty, tt = LOC_X_SAMPLES[idx], LOC_Y_SAMPLES[idx], LOC_T_SAMPLES[idx];      
      -- If we ran out of samples without finding a long enough
      -- vector then stop
      if (not tt) or (tt >= ct) or (tt < cutoff)  then
		break
      end
      dx = cx - tx;
      dy = cy - ty;

      -- If this vector is finally long enough, set found flag and break
      -- dx,dy, tx,ty,tt, and idx will all be useful
		
      if ((dx*dx + dy*dy) >= MIN_CUMUL_RANGE_SQ) then
         found = true;
         break;
      end
   end
   -- Not enough data
   if (not found) then
      if (lastDeg) then
         lastDeg = nil;
      end
      return
   end
   -- If we get here we have a vector, let's convert it to degrees
	local deg = math.deg(math.atan2(dx,-dy)); 
	local loc1  , loc2 = {}, {}
	loc1.x, loc1.y = BWP_Destination.x, BWP_Destination.y
	loc2.x, loc2.y = GetPlayerMapPosition("player")
	gdclx = (loc1.x - loc2.x  );
	gdcly = (loc1.y - loc2.y );
	_,_,Arrivedyet = BWP_FormatDist(loc1,loc2)
	 if (Arrivedyet == "A")and(not BWPFOLLOWPLAYER) then
		return "Arrived!"
	end
	local goaldeg = math.deg(math.atan2(gdclx,-gdcly))
	return (goaldeg - deg)
end

function GetLocalPoints()
	local Waypoints = {} 
	local countit = 0
	local zone = GetRealZoneText();
	local cont = nil;
	local cData;

	if (BWP_Zones and BWP_Zones[zone] == 1) then cont = "Kalimdor";
	elseif (BWP_Zones and BWP_Zones[zone] == 2) then cont = "Eastern Kingdoms"; end
	if (BWP_Data[cont] and BWP_Data[cont][zone]) then	
		text = "\n"
		local temp = BWP_Data[cont][zone];
		local node = nil;
		for key in temp do
			node = setmetatable(temp[key], BWPmeta);
			cData = BWPDisp:new(node:getX(), node:getY(), node:getAuthor(), "", node:getNote(), "", "BWP");
			tinsert(Waypoints, cData);
			countit = countit + 1
		end
	end
	if (MetaMapNotes_Data) then
		local BWP_mnCont, BWP_mnZone = MetaMap_GetCurrentMapInfo();
		if (MetaMapNotes_Data[BWP_mnCont] and MetaMapNotes_Data[BWP_mnCont][BWP_mnZone]) then
			for key in MetaMapNotes_Data[BWP_mnCont][BWP_mnZone] do
				
				local adjx, adjy = MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].xPos * 100, MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].yPos* 100;
				cData = BWPDisp:new(adjx, adjy, MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].creator, MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].name, MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].inf1, MetaMapNotes_Data[BWP_mnCont][BWP_mnZone][key].inf2, "MN");
				tinsert(Waypoints, cData);
				
				countit = countit + 1
			end
		end
	end
	return Waypoints , countit
end

function BWP_Generate()
	BWP_CZone = {};
	BWP_CZone , localpoints = GetLocalPoints()
end

function BWPsortbyName(a,b) return string.lower(a.title) < string.lower(b.title) end
function BWPSortByQuestGiverName(a,b) return string.lower(a.QuestGiver) < string.lower(b.QuestGiver) end

function BWP_SetRotation(dir)
	if(dir) then
		OffSet = tonumber(dir)
		if(OffSet)then
			if(OffSet > 180 )then
				OffSet = OffSet - 360
			elseif(OffSet < -180) then
				OffSet = OffSet + 360
			end
		end
		if(dir == "Arrived!") then
			BWP_CountDown = 75
			BWP_ArrowIcon = BWP_IMAGE_PATH.."Arrived"
		elseif(OffSet)and ((OffSet >=-5) and ( OffSet <= 5))or(OffSet < -355) then 
			BWP_ArrowIcon = BWP_IMAGE_PATH.."forward"
		elseif(OffSet)and (OffSet < -5) and (OffSet >= -15) then
			BWP_ArrowIcon = BWP_IMAGE_PATH.."FLeft+2"
		elseif(OffSet)and (OffSet < -15) and (OffSet >= -35) then
			BWP_ArrowIcon = BWP_IMAGE_PATH.."FLeft+1"
		elseif(OffSet)and (OffSet < -35) and (OffSet >= -55) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."FLeft"
		elseif(OffSet)and (OffSet < -55) and (OffSet >= -65) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."FLeft-1"
		elseif(OffSet)and (OffSet < -65) and (OffSet >= -80) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."FLeft-2"
		elseif(OffSet)and (OffSet < -80) and (OffSet >= -100) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."left"
		elseif(OffSet)and (OffSet < -100) and (OffSet >= -115) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."BLeft-2"
		elseif(OffSet)and (OffSet < -115) and (OffSet >= -135) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."BLeft-1"
		elseif(OffSet)and (OffSet < -135) and (OffSet >= -155) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."BLeft"
		elseif(OffSet)and (OffSet < -155) and (OffSet >= -165) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."BLeft+1"
		elseif(OffSet)and (OffSet < -165) and (OffSet >= -175) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."BLeft+2"
		elseif(OffSet)and ((OffSet < -175) and (OffSet >= -190)) or((OffSet > 175) and (OffSet <= 190)) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."Backward"
		elseif(OffSet)and (OffSet > 165) and (OffSet <= 175) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."BRight+2"
		elseif(OffSet)and (OffSet > 155) and (OffSet <= 165) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."BRight+1"
		elseif(OffSet)and (OffSet > 135) and (OffSet <= 155) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."BRight"
		elseif(OffSet)and (OffSet > 115) and (OffSet <= 135) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."BRight-1"
		elseif(OffSet)and (OffSet > 100) and (OffSet <= 115) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."BRight-2"
		elseif(OffSet)and (OffSet > 80) and (OffSet <= 100) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."right"
		elseif(OffSet)and (OffSet > 65) and (OffSet <= 80) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."FRight-2"
		elseif(OffSet)and (OffSet > 55) and (OffSet <= 65) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."FRight-1"
		elseif(OffSet)and (OffSet > 35) and (OffSet <= 55) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."FRight"
		elseif(OffSet)and (OffSet > 15) and (OffSet <= 35) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."FRight+1"
		elseif(OffSet)and (OffSet > 5) and (OffSet <= 15) then	
			BWP_ArrowIcon = BWP_IMAGE_PATH.."FRight+2"
		end
	end
	if(BWP_Destination) then
		BWP_Arrow:SetTexture(BWP_ArrowIcon);
	end
end
