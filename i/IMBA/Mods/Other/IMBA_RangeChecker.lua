function IMBA_RangeChecker_OnUpdate()
	if not IMBA_RangeChecker_Active and not IMBA_CheckVar("Range Checker","AlwaysRun") then
		this:SetBackdropColor(0.0,0.0,0.0,0.6);
		return;
	end
	if IMBA_RangeChecker_UpdateTime>GetTime() then
		return;
	end

	
	local PlayerList={};
	for i=1,GetNumRaidMembers() do
		if UnitExists("raid"..i) and not UnitIsUnit("player", "raid"..i) and (UnitHealth("raid"..i)>0) and (not UnitIsDeadOrGhost("raid"..i)) then
			if CheckInteractDistance("raid"..i,3) then
				tinsert(PlayerList,{UnitName("raid"..i)});
			end
		end
	end
	
	--table.sort(PlayerList);

	local numEntries = getn(PlayerList);

	for i=1,5 do
		if i<=numEntries then
			getglobal("IMBA_RangeChecker_Player"..i):SetText(PlayerList[i][1]);
			getglobal("IMBA_RangeChecker_Player"..i):Show();
		else
			getglobal("IMBA_RangeChecker_Player"..i):Hide();
		end
	end
	if numEntries>5 then
		numEntries=5;
	end
	this:SetHeight(30+16*numEntries);

	if numEntries==0 then
		this:SetBackdropColor(0.0,1.0,0.0,0.6);
	else
		this:SetBackdropColor(1.0,0.0,0.0,0.6);
	end


	IMBA_RangeChecker_UpdateTime=GetTime()+0.1;
end


function IMBA_RangeChecker_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_RangeChecker_Title:SetText("Range Checker");

	IMBA_AddAddon("Range Checker", "Checks for players within 10 yds, Grey=Inactive, Green=Safe and Red=Too Close", IMBA_LOCATIONS_OTHER, nil, nil,nil,"IMBA_RangeChecker");
	IMBA_AddOption2("Range Checker","AlwaysRun","Always Running");
	IMBA_RangeChecker_UpdateTime=0;
	IMBA_RangeChecker_Active=false;
end

