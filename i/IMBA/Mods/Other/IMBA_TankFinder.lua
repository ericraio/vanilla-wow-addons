local IMBA_TANKFINDER_SLASH_COMMAND = "/targettf"

local TankList={};
function IMBA_TankFinder_RegenActivator()
	IMBA_TankFinder:Show();
end

function IMBA_TankFinder_Sort(v1,v2)
	if v1[2]==v2[2] then
		return v1[1]<v2[1];
	else
		return v1[2]<v2[2];
	end
end

function IMBA_TankFinder_OnUpdate()
	if IMBA_TankFinder_UpdateTime>GetTime() then
		return;
	end
	
	
	if IMBA_TankFinder_DistCheck<GetTime() then	
		TankList={};
		for i=1,GetNumRaidMembers() do
			if UnitExists("raid"..i) and (UnitHealth("raid"..i)>0) then
				
				local playerClass, englishClass = UnitClass("raid"..i);
				if (englishClass=="WARRIOR") and CheckInteractDistance("raid"..i,4) then
					tinsert(TankList,{i,UnitHealth("raid"..i)-UnitHealthMax("raid"..i)});
				end
			end
		end
		IMBA_TankFinder_DistCheck=GetTime()+1;
	else
		for k, v in TankList do
			TankList[k][2]=UnitHealth("raid"..TankList[k][1])/UnitHealthMax("raid"..TankList[k][1]);
		end
	end

	table.sort(TankList, IMBA_TankFinder_Sort);

	local numEntries = getn(TankList);

	for i=1,3 do
		if i<=numEntries then
			getglobal("IMBA_TankFinder_Tank"..i).unit="raid"..TankList[i][1];
		else
			getglobal("IMBA_TankFinder_Tank"..i).unit=nil;
		end
	end

	IMBA_TankFinder_UpdateTime=GetTime()+0.1;
end

function IMBA_TankFinder_Target(msg)
	local number=tonumber(msg)

	if number then
		if number>=1 and number<=3 then
			if TargetUnit(getglobal("IMBA_TankFinder_Tank"..number).unit) then
				TargetUnit(getglobal("IMBA_TankFinder_Tank"..number).unit)
			end
		end
	end
end


function IMBA_TankFinder_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_TankFinder_Title:SetText("Tank Finder");
	IMBA_TankFinder_Tank1.unit=nil;
	IMBA_TankFinder_Tank2.unit=nil;
	IMBA_TankFinder_Tank3.unit=nil;

	IMBA_AddAddon("Tank Finder", "Finds the 3 warriors within 30 yds with the lowest health", IMBA_LOCATIONS_OTHER, nil, nil,nil,"IMBA_TankFinder");
	IMBA_TankFinder_UpdateTime=0;
	IMBA_TankFinder_DistCheck=0;

	--Register the slash commands
	SLASH_IMBA_TANKFINDER1= IMBA_TANKFINDER_SLASH_COMMAND;
	SlashCmdList["IMBA_TANKFINDER"] = function(msg)
		IMBA_TankFinder_Target(msg);
	end
end
