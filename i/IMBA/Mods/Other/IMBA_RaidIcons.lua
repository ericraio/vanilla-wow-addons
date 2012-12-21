IMBA_RaidIcon_LastSeen={}
function IMBA_RaidIcons_OnUpdate()
	local TheTime=GetTime();
	local IconsShown=0;
	if TheTime<IMBA_RaidIcon_UpdateTime then
		return
	end

	for i=1,8 do
		if IMBA_GetRaidIconUnitID(i)~=nil then
			IMBA_RaidIcon_LastSeen[i]=TheTime;
			--DEFAULT_CHAT_FRAME:AddMessage("Raid Icon "..i.." on "..UnitName(IMBA_GetRaidIconUnitID(i)))
		end

		if IMBA_RaidIcon_LastSeen[i]==nil or TheTime>(IMBA_RaidIcon_LastSeen[i]+30) then
			if getglobal("IMBA_RaidIcons_RaidIcon"..i):IsShown() then
				getglobal("IMBA_RaidIcons_RaidIcon"..i):Hide();
				getglobal("IMBA_RaidIcons_RaidIconHealth"..i):Hide();
				if i~=8 then
					getglobal("IMBA_RaidIcons_RaidIcon"..i+1):ClearAllPoints()
					getglobal("IMBA_RaidIcons_RaidIcon"..i+1):SetPoint("CENTER","IMBA_RaidIcons_RaidIcon"..i,"CENTER");
					getglobal("IMBA_RaidIcons_RaidIconHealth"..i+1):ClearAllPoints()
					getglobal("IMBA_RaidIcons_RaidIconHealth"..i+1):SetPoint("CENTER","IMBA_RaidIcons_RaidIconHealth"..i,"CENTER");
				end
			end
		else	
			IconsShown=IconsShown+1;
			if not getglobal("IMBA_RaidIcons_RaidIcon"..i):IsShown() then
				getglobal("IMBA_RaidIcons_RaidIcon"..i):Show();
				getglobal("IMBA_RaidIcons_RaidIconHealth"..i):Show();
				if i~=8 then
					getglobal("IMBA_RaidIcons_RaidIcon"..i+1):ClearAllPoints()
					getglobal("IMBA_RaidIcons_RaidIcon"..i+1):SetPoint("TOP","IMBA_RaidIcons_RaidIcon"..i,"BOTTOM",0,-2);
					getglobal("IMBA_RaidIcons_RaidIconHealth"..i+1):ClearAllPoints()
					getglobal("IMBA_RaidIcons_RaidIconHealth"..i+1):SetPoint("TOP","IMBA_RaidIcons_RaidIconHealth"..i,"BOTTOM",0,-2);
				end
			end
		end
	end

	IMBA_RaidIcons:SetHeight(32+24*IconsShown);

	IMBA_RaidIcon_UpdateTime=TheTime+0.1;
end

function IMBA_RaidIcons_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_RaidIcons_Title:SetText("Raid Icon Monitor");
	for i=1,8,1 do
		getglobal("IMBA_RaidIcons_RaidIcon"..i):SetIconTargetIndex(i);
		getglobal("IMBA_RaidIcons_RaidIconHealth"..i).RaidIcon=i;
	end

	IMBA_AddAddon("Raid Icon Monitor", "Aids with watching the health of Raid Icon targets and targeting of", IMBA_LOCATIONS_OTHER, nil, nil,nil,"IMBA_RaidIcons");
	IMBA_RaidIcon_UpdateTime=0;
end
