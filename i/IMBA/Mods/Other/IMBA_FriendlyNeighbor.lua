local IMBA_FRIENDLYNEIGHBOR_SLASH_COMMAND = "/targetfn"

local PlayerList={};

function IMBA_FriendlyNeighbor_RegenActivator()
	IMBA_FriendlyNeighbor:Show();
end

function IMBA_FriendlyNeighbor_Sort(v1,v2)
	if v1[2]==v2[2] then
		return v1[1]<v2[1];
	else
		return v1[2]<v2[2];
	end
end

function IMBA_FriendlyNeighbor_OnUpdate()
	if IMBA_FriendlyNeighbor_UpdateTime>GetTime() then
		return;
	end

	
	
	if IMBA_FriendlyNeighbor_DistCheck<GetTime() then		
		PlayerList={};
		for i=1,GetNumRaidMembers() do
			if UnitExists("raid"..i) and (UnitHealth("raid"..i)>0) and (not UnitIsDeadOrGhost("raid"..i)) then
				local playerClass, englishClass = UnitClass("raid"..i);
				if (not IMBA_CheckVar("Friendly Neighbor",englishClass)) and CheckInteractDistance("raid"..i,4) then
					tinsert(PlayerList,{i,UnitHealth("raid"..i)/UnitHealthMax("raid"..i)});
				end
			end
		end
		IMBA_FriendlyNeighbor_DistCheck=GetTime()+1.5;
	else
		for k, v in PlayerList do
			PlayerList[k][2]=UnitHealth("raid"..PlayerList[k][1])/UnitHealthMax("raid"..PlayerList[k][1]);
		end
	end

	table.sort(PlayerList, IMBA_FriendlyNeighbor_Sort);

	local numEntries = getn(PlayerList);
	local classColors = IMBA_CheckVar("Friendly Neighbor","UseClassColors");

	for i=1,5 do
		if i<=numEntries then
			getglobal("IMBA_FriendlyNeighbor_Player"..i).unit="raid"..PlayerList[i][1];
			getglobal("IMBA_FriendlyNeighbor_Player"..i).ClassColor=classColors;
		else
			getglobal("IMBA_FriendlyNeighbor_Player"..i).unit=nil;
		end
	end

	IMBA_FriendlyNeighbor_PlayerList=PlayerList;

	IMBA_FriendlyNeighbor_UpdateTime=GetTime()+0.1;
end

function IMBA_FriendlyNeighbor_Target(msg)
	local number=tonumber(msg)

	if number then
		if number>=1 and number<=5 then
			if getglobal("IMBA_FriendlyNeighbor_Player"..number).unit then
				TargetUnit(getglobal("IMBA_FriendlyNeighbor_Player"..number).unit)
			end
		end
	end
end

function IMBA_FriendlyNeighbor_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_FriendlyNeighbor_Title:SetText("Friendly Neighbor");
	IMBA_FriendlyNeighbor_Player1.unit=nil;
	IMBA_FriendlyNeighbor_Player2.unit=nil;
	IMBA_FriendlyNeighbor_Player3.unit=nil;
	IMBA_FriendlyNeighbor_Player4.unit=nil;
	IMBA_FriendlyNeighbor_Player5.unit=nil;

	IMBA_AddAddon("Friendly Neighbor", "Finds the 5 players within 30 yds with the lowest percent based health", IMBA_LOCATIONS_OTHER, nil, nil,nil,"IMBA_FriendlyNeighbor");
	IMBA_AddOption2("Friendly Neighbor","UseClassColors","Use Class Colors");
	IMBA_AddOption2("Friendly Neighbor","DRUID","Hide Druids");
	IMBA_AddOption2("Friendly Neighbor","HUNTER","Hide Hunter");
	IMBA_AddOption2("Friendly Neighbor","MAGE","Hide Mages");
	IMBA_AddOption2("Friendly Neighbor","PALADIN","Hide Paladins");
	IMBA_AddOption2("Friendly Neighbor","PRIEST","Hide Priests");
	IMBA_AddOption2("Friendly Neighbor","ROGUE","Hide Rogues");
	IMBA_AddOption2("Friendly Neighbor","SHAMAN","Hide Shamans");
	IMBA_AddOption2("Friendly Neighbor","WARLOCK","Hide Warlocks");
	IMBA_AddOption2("Friendly Neighbor","WARRIOR","Hide Warriors");
	IMBA_FriendlyNeighbor_UpdateTime=0;
	

	IMBA_FriendlyNeighbor_DistCheck=0;

	--Register the slash commands
	SLASH_IMBA_FRIENDLYNEIGHBOR1 = IMBA_FRIENDLYNEIGHBOR_SLASH_COMMAND;
	SlashCmdList["IMBA_FRIENDLYNEIGHBOR"] = function(msg)
		IMBA_FriendlyNeighbor_Target(msg);
	end
end

