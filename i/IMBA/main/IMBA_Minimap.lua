IMBA_SetRaidMarker=false;
IMBA_UseRaidMarker=1;

IMBA_Minimap_Pings={};
IMBA_Minimap_BossMarkerNum=1;

IMBA_Minimap_PingWaiting=false;

--{PingType, dX, dY, Num, Icon}
IMBA_Minimap_PingQueue={}
IMBA_Minimap_PingWait=0;
IMBA_Minimap_OldSetPing=nil;
IMBA_Minimap_OldPingFunction=nil;

function IMBA_Minimap_PrintList()
	for k,v in IMBA_Minimap_Pings do
		DEFAULT_CHAT_FRAME:AddMessage(k.." pinged at "..v.dx..", "..v.dy);
	end
end

--Removed the Ping Sound
function IMBA_Minimap_SetPing(x, y, playSound)
	IMBA_Minimap_OldSetPing(x,y,false);	
end

--
function IMBA_Minimap_PingLocation(unknown, x, y)	
	if IMBA_Minimap_PingWaiting then
		local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
		local pX,pY = Minimap:GetPingPosition();
		local dX,dY;
	
		dX=x-pX;
		dY=y-pY;
		getglobal("IMBA_Minimap_RaidMarker"..IMBA_UseRaidMarker):Show();
		getglobal("IMBA_Minimap_RaidMarker"..IMBA_UseRaidMarker):SetRaidMarker(dX,dY,tonumber(IMBA_UseRaidMarker));

		dX=dX*zoom;
		dY=dY*zoom;
		if IMBA_SetRaidMarker then
			tinsert(IMBA_Minimap_PingQueue,{1,dX,dY,IMBA_UseRaidMarker,nil});
		else
			tinsert(IMBA_Minimap_PingQueue,{0,dX,dY,nil,nil});
		end
	else
		IMBA_Minimap_OldPingFunction(unknown,x,y)
		if IMBA_SetRaidMarker then
			IMBA_SetRaidMarker=false;
			if GetNumRaidMembers()>0 and (IsRaidLeader() or IsRaidOfficer()) then
				SendAddonMessage("IMBA_MINIMAP", "RAIDMARKER "..IMBA_UseRaidMarker,"RAID");
				IMBA_Minimap_PingWaiting=true;
			elseif GetNumPartyMembers()>0 then
				SendAddonMessage("IMBA_MINIMAP", "RAIDMARKER "..IMBA_UseRaidMarker,"PARTY");
				IMBA_Minimap_PingWaiting=true;
			end
			getglobal("IMBA_Minimap_RaidMarker"..IMBA_UseRaidMarker):Show();
			getglobal("IMBA_Minimap_RaidMarker"..IMBA_UseRaidMarker):SetRaidMarker(0,0,tonumber(IMBA_UseRaidMarker));	
		end
	end
end

function IMBA_Minimap_ProcessPingQueue()
	local numEntries = getn(IMBA_Minimap_PingQueue);

	if (numEntries>0) and (IMBA_Minimap_PingWaiting==false) then
		local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
		local pX,pY = Minimap:GetPingPosition();
	
		if IMBA_Minimap_PingQueue[1][1]==0 then
			IMBA_Minimap_OldPingFunction((IMBA_Minimap_PingQueue[1][2]+pX)/zoom, (IMBA_Minimap_PingQueue[1][3]+pY)/zoom);
			tremove(IMBA_Minimap_PingQueue,1);
			IMBA_Minimap_ProcessPingQueue();
		elseif IMBA_Minimap_PingQueue[1][1]==1 then
			IMBA_Minimap_OldPingFunction((IMBA_Minimap_PingQueue[1][2]+pX)/zoom, (IMBA_Minimap_PingQueue[1][3]+pY)/zoom);
			if GetNumRaidMembers()>0 and (IsRaidLeader() or IsRaidOfficer()) then
				SendAddonMessage("IMBA_MINIMAP", "RAIDMARKER "..IMBA_Minimap_PingQueue[1][4],"RAID");
				IMBA_Minimap_PingWaiting=true;
			elseif GetNumPartyMembers()>0 then
				SendAddonMessage("IMBA_MINIMAP", "RAIDMARKER "..IMBA_Minimap_PingQueue[1][4],"PARTY");
				IMBA_Minimap_PingWaiting=true;
			end
			tremove(IMBA_Minimap_PingQueue,1);
		elseif IMBA_Minimap_PingQueue[1][1]==2 then
			IMBA_Minimap_OldPingFunction((IMBA_Minimap_PingQueue[1][2]+pX)/zoom, (IMBA_Minimap_PingQueue[1][3]+pY)/zoom);
			if GetNumRaidMembers()>0 then
				SendAddonMessage("IMBA_MINIMAP", "BOSSMARKER","RAID");
				IMBA_Minimap_PingWaiting=true;
			elseif GetNumPartyMembers()>0 then
				SendAddonMessage("IMBA_MINIMAP", "BOSSMARKER","PARTY");
				IMBA_Minimap_PingWaiting=true;
			end
			tremove(IMBA_Minimap_PingQueue,1);
		end
		
	end
end

function IMBA_Minimap_ClearMarkers()
	IMBA_SetRaidMarker=false;
	if GetNumRaidMembers()>0 and (IsRaidLeader() or IsRaidOfficer()) then
		SendAddonMessage("IMBA_MINIMAP", "CLEARRAIDMARKERS","RAID");
	elseif GetNumPartyMembers()>0 then
		SendAddonMessage("IMBA_MINIMAP", "CLEARRAIDMARKERS","PARTY");
	end
	arg1="IMBA_MINIMAP";
	arg2="CLEARRAIDMARKERS";
	IMBA_Minimap_OnEvent("CHAT_MSG_ADDON");
end

function IMBA_Minimap_SetBossMarker()
	if IMBA_Minimap_PingWaiting then
		local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
		local pX,pY = Minimap:GetPingPosition();
		local dX,dY;
	
		dX=CURSOR_OFFSET_X-pX;
		dY=CURSOR_OFFSET_Y-pY;
		getglobal("IMBA_Minimap_BossMarker"..IMBA_Minimap_BossMarkerNum):Show();
		getglobal("IMBA_Minimap_BossMarker"..IMBA_Minimap_BossMarkerNum):SetMarker(dX,dY);

		dX=dX*zoom;
		dY=dY*zoom;
		tinsert(IMBA_Minimap_PingQueue,{2,dX,dY,nil,nil});
		
	else
		Minimap:PingLocation(CURSOR_OFFSET_X, CURSOR_OFFSET_Y);
		getglobal("IMBA_Minimap_BossMarker"..IMBA_Minimap_BossMarkerNum):Show();
		getglobal("IMBA_Minimap_BossMarker"..IMBA_Minimap_BossMarkerNum):SetMarker(0,0);

		if GetNumRaidMembers()>0 then
			SendAddonMessage("IMBA_MINIMAP", "BOSSMARKER","RAID");
			IMBA_Minimap_PingWaiting=true;
		elseif GetNumPartyMembers()>0 then
			SendAddonMessage("IMBA_MINIMAP", "BOSSMARKER","PARTY");
			IMBA_Minimap_PingWaiting=true;
		else
			IMBA_Minimap_BossMarkerNum=IMBA_Minimap_BossMarkerNum+1;
			if IMBA_Minimap_BossMarkerNum==9 then
				IMBA_Minimap_BossMarkerNum=1;
			end
		end			
	end

	
end

function IMBA_Minimap_ClearBossMarkers()
	if GetNumRaidMembers()>0 and (IsRaidLeader() or IsRaidOfficer()) then
		SendAddonMessage("IMBA_MINIMAP", "CLEARBOSSMARKERS","RAID");
	elseif GetNumPartyMembers()>0 then
		SendAddonMessage("IMBA_MINIMAP", "CLEARBOSSMARKERS","PARTY");
	end
	arg1="IMBA_MINIMAP";
	arg2="CLEARBOSSMARKERS";
	IMBA_Minimap_OnEvent("CHAT_MSG_ADDON");
end

function IMBA_Minimap_OnLoad()
	
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("MINIMAP_PING");
	this:RegisterEvent("PLAYER_LOGIN");

	IMBA_MC_Locations=false;
end

function IMBA_Minimap_OnEvent(event)
	if event=="CHAT_MSG_ADDON" then	
		if arg1=="IMBA_MINIMAP" then
			local commandName, params = IMBA_ExtractNextParam(arg2);
			if commandName=="RAIDMARKER" then
				local number;
				number, params = IMBA_ExtractNextParam(params);
				if IMBA_Minimap_Pings[arg4] then
					local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
					getglobal("IMBA_Minimap_RaidMarker"..number):Show();
					getglobal("IMBA_Minimap_RaidMarker"..number):SetRaidMarker(IMBA_Minimap_Pings[arg4].dx/zoom,IMBA_Minimap_Pings[arg4].dy/zoom,tonumber(number));
				else
					getglobal("IMBA_Minimap_RaidMarker"..number):Show();
					getglobal("IMBA_Minimap_RaidMarker"..number):SetRaidMarker(0,0,tonumber(number));
				end

				if arg4 == UnitName("player") then
					IMBA_Minimap_PingWaiting=false;
					IMBA_Minimap_ProcessPingQueue();
				end
			elseif commandName=="CLEARRAIDMARKERS" then
				for i=1,8,1 do
					getglobal("IMBA_Minimap_RaidMarker"..i):HideMarker();
					getglobal("IMBA_Minimap_RaidMarker"..i):Hide();
				end
			elseif commandName=="BOSSMARKER" then
				local number;
				number = IMBA_Minimap_BossMarkerNum;
				if IMBA_Minimap_Pings[arg4] then
					local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
					getglobal("IMBA_Minimap_BossMarker"..number):Show();
					getglobal("IMBA_Minimap_BossMarker"..number):SetMarker(IMBA_Minimap_Pings[arg4].dx/zoom,IMBA_Minimap_Pings[arg4].dy/zoom);
				else
					getglobal("IMBA_Minimap_BossMarker"..number):Show();
					getglobal("IMBA_Minimap_BossMarker"..number):SetMarker(0,0);
				end

				IMBA_Minimap_BossMarkerNum=IMBA_Minimap_BossMarkerNum+1;
				if IMBA_Minimap_BossMarkerNum==9 then
					IMBA_Minimap_BossMarkerNum=1;
				end

				if arg4 == UnitName("player") then
					IMBA_Minimap_PingWaiting=false;
					IMBA_Minimap_ProcessPingQueue();
				end
			elseif commandName=="CLEARBOSSMARKERS" then
				for i=1,8,1 do
					getglobal("IMBA_Minimap_BossMarker"..i):HideMarker();
					getglobal("IMBA_Minimap_BossMarker"..i):Hide();
				end
			end
		end
	elseif event=="MINIMAP_PING" then
		local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
		local PlayerName=UnitName(arg1);
		for k, v in IMBA_Minimap_Pings do
			v.dx=v.dx-arg2*zoom;
			v.dy=v.dy-arg3*zoom;
		end

		if IMBA_Minimap_Pings[PlayerName]==nil then
			IMBA_Minimap_Pings[PlayerName]={};
		end

		IMBA_Minimap_Pings[PlayerName].dx=0;
		IMBA_Minimap_Pings[PlayerName].dy=0;
	elseif event=="PLAYER_LOGIN" then
		IMBA_Minimap_OldSetPing=Minimap_SetPing;
		Minimap_SetPing=IMBA_Minimap_SetPing;
		IMBA_Minimap_OldPingFunction=Minimap.PingLocation
		Minimap.PingLocation=IMBA_Minimap_PingLocation;
	end
end