IMBA_Tracker_Enabled=false;
IMBA_Tracker_UpdateTime=0;
IMBA_Tracker_StopTimeGuild=0;
IMBA_Tracker_StopTimeRaid=0;

IMBA_Tracker_LastPos={x=0;y=0};
IMBA_Tracker_PingDelta={x=0;y=0};

IMBA_Tracker_Calibration={}

IMBA_TRACKER_UPDATE_RATE = 0.5

local minimapPlayerModel;

IMBA_Minimap_Zoom={};
IMBA_Minimap_Zoom[0]={}
IMBA_Minimap_Zoom[1]={}
--For Outside of WMO's
IMBA_Minimap_Zoom[0][0]=1;
IMBA_Minimap_Zoom[0][1]=6/7;
IMBA_Minimap_Zoom[0][2]=5/7;
IMBA_Minimap_Zoom[0][3]=4/7;
IMBA_Minimap_Zoom[0][4]=3/7;
IMBA_Minimap_Zoom[0][5]=2/7;

--For Inside of WMO's
IMBA_Minimap_Zoom[1][0]=1*0.643;
IMBA_Minimap_Zoom[1][1]=4/5*0.643;
IMBA_Minimap_Zoom[1][2]=3/5*0.643;
IMBA_Minimap_Zoom[1][3]=2/5*0.643;
IMBA_Minimap_Zoom[1][4]=4/15*0.643;
IMBA_Minimap_Zoom[1][5]=1/6*0.643;

IMBA_Tracker_Preset=false


function IMBA_Tracker_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage("Tracker Loaded");
	this:RegisterEvent("MINIMAP_PING");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PLAYER_LOGIN");

	-- Create a table of all the Minimap's children objectSimpleCompass_Saved.
	local children = {Minimap:GetChildren()};
	
	for i=getn(children), 1, -1 do
		-- Iterate over them all, starting from the end of the list to see if the object reference is a model.
		-- If it is, and it has no name (in case some addon attached a model to it), it's probably the right one.
		if children[i]:IsObjectType("Model") and not children[i]:GetName() and not minimapPlayerModel then
			-- Found, setting as the addon's local to keep the reference.
			minimapPlayerModel = children[i];
			return;
		end
	end
end


function IMBA_Tracker_OnEvent(event)
	if event=="MINIMAP_PING" then
		local x,y=Minimap:GetPingPosition();
		local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];
		IMBA_Tracker_PingDelta.x=IMBA_Tracker_PingDelta.x+IMBA_Tracker_LastPos.x-x*zoom;
		IMBA_Tracker_PingDelta.y=IMBA_Tracker_PingDelta.y+IMBA_Tracker_LastPos.y-y*zoom;

		IMBA_Tracker_LastPos.x=x;
		IMBA_Tracker_LastPos.y=y;
		
		if not IMBA_TrackerData then
			IMBA_TrackerData={};
		end
		
		if IMBA_Tracker_Calibrating then
			IMBA_Tracker_CalibratePing.x=IMBA_Tracker_CalibratePing.x+IMBA_Tracker_LastPos.x-x*zoom;
			IMBA_Tracker_CalibratePing.y=IMBA_Tracker_CalibratePing.y+IMBA_Tracker_LastPos.y-y*zoom;
		end

		IMBA_TrackerData.Delta=IMBA_Tracker_PingDelta
	elseif event=="CHAT_MSG_ADDON" then
		if arg1=="IMBA_TRACKER_UPDATE" then
			if arg2=="TRANSMIT" then				
				if arg3=="RAID" then
					IMBA_Tracker_EnabledRaid=true;
					IMBA_Tracker_StopTimeRaid=GetTime()+15;
				elseif arg3=="GUILD" then
					IMBA_Tracker_EnabledGuild=true;
					IMBA_Tracker_StopTimeGuild=GetTime()+15;
				end
			elseif arg2=="CALIBRATE" then
				local score=2
				if IMBA_Tracker_ValidatePos then
					score=1
					IMBA_Tracker_ValidateTime=GetTime()+60;
					IMBA_Tracker_Calibrating=true
					IMBA_Tracker_CountTime=GetTime()+10;
					IMBA_Tracker_CalibratePing={x=0;y=0}
				end
				--DEFAULT_CHAT_FRAME:AddMessage("Calibration Request Received")
				SendAddonMessage("IMBA_TRACKER_UPDATE","CALIBRATION "..score.." "..IMBA_Tracker_PingDelta.x.." "..IMBA_Tracker_PingDelta.y,"RAID");
				IMBA_Tracker_Calibration={}
				
			elseif string.find(arg2,"CALIBRATION") and IMBA_Tracker_ValidatePos then
				local score, deltax, deltay
				_,_,score, deltax, deltay =string.find(arg2,"CALIBRATION (%d+) (-?%d+.?%d*) (-?%d+.?%d*)")
				score=tonumber(score)
				deltax=tonumber(deltax)
				deltay=tonumber(deltay)
				--DEFAULT_CHAT_FRAME:AddMessage("Received Calibration Vote "..score.." Delta "..deltax.." "..deltay);
				for k,v in IMBA_Tracker_Calibration do
					if IMBA_Tracker_CompareNumber(v.x,deltax) and IMBA_Tracker_CompareNumber(v.y,deltay) then
						v.totalx=v.totalx+score*deltax;
						v.totaly=v.totaly+score*deltay;
						v.score=v.score+score;

						v.x=v.totalx/v.score
						v.y=v.totaly/v.score
						return
					end
				end
				tinsert(IMBA_Tracker_Calibration,{x=deltax;y=deltay;totalx=deltax*score;totaly=deltay*score;score=score})
			end
		end
	elseif event=="RAID_ROSTER_UPDATE" then
		if IMBA_Tracker_EnabledRaid and GetNumRaidMembers()==0 then
			IMBA_Tracker_EnabledRaid=false;
		end
	elseif event=="PLAYER_LOGIN" then
		IMBA_Tracker_Loaded=true

		IMBA_Tracker_ValidatePos=true;
		IMBA_Tracker_ValidateTime=GetTime()+0.2;

		--DEFAULT_CHAT_FRAME:AddMessage("Validating Coords");
		if IMBA_SavedVariables.LastPlayerPos then
			local curX,curY;
			local oldX,oldY;
			curX, curY = IMBA_Tracker_GetPostion()
			
			
			oldX=IMBA_SavedVariables.LastPlayerPos.x;
			oldY=IMBA_SavedVariables.LastPlayerPos.y;

			if (not IMBA_Tracker_CompareNumber(curX,oldX)) or (not IMBA_Tracker_CompareNumber(curY,oldY)) then
				if IMBA_TrackerData then
					--DEFAULT_CHAT_FRAME:AddMessage("Incorrect - Testing with saved Delta's")
					curX=curX+IMBA_TrackerData.Delta.x
					curY=curY+IMBA_TrackerData.Delta.y
					if IMBA_Tracker_CompareNumber(curX,oldX) and IMBA_Tracker_CompareNumber(curY,oldY) then
						--DEFAULT_CHAT_FRAME:AddMessage("Correct Delta and Set")
						IMBA_Tracker_PingDelta=IMBA_TrackerData.Delta
					end
				end
			end		
		end
	end
end

function IMBA_Tracker_CompareNumber(v1,v2)
	return math.abs(v1-v2)<0.015;
end

function IMBA_Tracker_GetPostion()
	local x,y = Minimap:GetPingPosition();
	local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];

	x=x*zoom+IMBA_Tracker_PingDelta.x;
	y=y*zoom+IMBA_Tracker_PingDelta.y;
	return x, y
end

--The various equations to convert map coordinates to Ping coordinates
--Linear equations fitted via linear least squares of a decent sampling of numbers ~25
--Introduces error on the order of +/-0.005 of ping coordinates
IMBA_MapEquations={}
IMBA_MapEquations[2]={mx=-75.42874908;bx=34.2859094;my=50.2865016;by=-16.00008308}
IMBA_MapEquations[1]={mx=-78.85670491;bx=36.57127371;my=52.57102443;by=-27.42828408}

function IMBA_Tracker_GetPostion_ViaMap()
	SetMapToCurrentZone()
	local continent=GetCurrentMapContinent();
	SetMapZoom(continent)
	local x, y = GetPlayerMapPosition("player");
	local equ=IMBA_MapEquations[continent]
	if not equ then
		equ={mx=1;bx=0;my=1;by=0}
	end
	x=x*equ.mx+equ.bx
	y=y*equ.my+equ.by
	return x, y
end

function IMBA_Tracker_Calibration_Sort(v1,v2)
	return v1.score>v2.score
end


function IMBA_Tracker_OnUpdate()
	local x,y = Minimap:GetPingPosition();
	local zoom = IMBA_Minimap_Zoom[IMBA_isMinimapInsideWMO()][Minimap:GetZoom()];

	IMBA_Tracker_LastPos.x=x*zoom
	IMBA_Tracker_LastPos.y=y*zoom	

	--Position Validation
	if IMBA_Tracker_ValidatePos and IMBA_Tracker_ValidateTime<GetTime() then
		SetMapToCurrentZone()
		if GetCurrentMapContinent()>0 then
			if not IMBA_Tracker_Preset then
				--DEFAULT_CHAT_FRAME:AddMessage("Preset Map")
				SetMapZoom(GetCurrentMapContinent())
				IMBA_Tracker_ValidateTime=GetTime()+0.1
				IMBA_Tracker_Preset=true;
			else
				--DEFAULT_CHAT_FRAME:AddMessage("Correcting Map")
				local wrongX,wrongY=IMBA_Tracker_GetPostion();
				local rightX,rightY=IMBA_Tracker_GetPostion_ViaMap();

				if (not IMBA_Tracker_CompareNumber(wrongX,rightX)) or (not IMBA_Tracker_CompareNumber(wrongY,rightY)) then
					IMBA_Tracker_PingDelta.x=IMBA_Tracker_PingDelta.x+(rightX-wrongX);
					IMBA_Tracker_PingDelta.y=IMBA_Tracker_PingDelta.y+(rightY-wrongY);
				end

				IMBA_Tracker_ValidatePos=false;			
			end
		elseif GetNumRaidMembers()>0 then
			--Lets try to calibrate if we can with other raid members
			if not IMBA_Tracker_PrePinged then
				Minimap:PingLocation(0,0); --Send a ping that we can all agree on
				IMBA_Tracker_ValidateTime=GetTime()+0.5;
				IMBA_Tracker_PrePinged=true
			else			
				SendAddonMessage("IMBA_TRACKER_UPDATE","CALIBRATE","RAID");
				--DEFAULT_CHAT_FRAME:AddMessage("Requesting Calibration")
				IMBA_Tracker_ValidateTime=GetTime()+60;
				IMBA_Tracker_PrePinged=false;
			end
		end
	end

	

	if IMBA_Tracker_Calibrating and IMBA_Tracker_CountTime<GetTime() then
		sort(IMBA_Tracker_Calibration,IMBA_Tracker_Calibration_Sort)
		--DEFAULT_CHAT_FRAME:AddMessage("Calibration Vote Score of "..IMBA_Tracker_Calibration[1].score.." Delta= "..IMBA_Tracker_Calibration[1].x..", "..IMBA_Tracker_Calibration[1].y);
		if IMBA_Tracker_Calibration[1].score>1.5 then
			IMBA_Tracker_PingDelta.x=IMBA_Tracker_Calibration[1].x+IMBA_Tracker_CalibratePing.x
			IMBA_Tracker_PingDelta.y=IMBA_Tracker_Calibration[1].y+IMBA_Tracker_CalibratePing.y
			IMBA_Tracker_ValidatePos=false;
		end
		IMBA_Tracker_Calibrating=false
	end

	x=x*zoom+IMBA_Tracker_PingDelta.x;
	y=y*zoom+IMBA_Tracker_PingDelta.y;

	if IMBA_Tracker_Loaded then
		IMBA_SavedVariables.LastPlayerPos={x=x;y=y}
	end

	if not IMBA_Tracker_ValidatePos and (IMBA_Tracker_EnabledRaid or IMBA_Tracker_EnabledGuild)  and IMBA_Tracker_UpdateTime<GetTime() then
		local ang=minimapPlayerModel:GetFacing(); 

		local _, effectiveArmor, _, _, _ = UnitArmor("player");
		local  baseDefense, armorDefense = UnitDefense("player");
		local defense=baseDefense+armorDefense
		local _, englishClass = UnitClass("player");

		local msg=string.format("%.3f %.3f %.3f %d %d %d %d %d %s %d %d",x,y,ang,UnitHealth("player"),UnitHealthMax("player"),UnitMana("player"),UnitManaMax("player"),UnitPowerType("player"),englishClass,effectiveArmor,defense);
		if IMBA_Tracker_EnabledGuild then
			SendAddonMessage("IMBA_TRACKER_DATA",msg,"GUILD");
		end
		if IMBA_Tracker_EnabledRaid then
			SendAddonMessage("IMBA_TRACKER_DATA",msg,"RAID");
		end
		
		IMBA_Tracker_UpdateTime=GetTime()+IMBA_TRACKER_UPDATE_RATE;

		if IMBA_Tracker_EnabledGuild and IMBA_Tracker_StopTimeGuild<GetTime() then
			IMBA_Tracker_EnabledGuild=false;
		end

		if IMBA_Tracker_EnabledRaid and IMBA_Tracker_StopTimeRaid<GetTime() then
			IMBA_Tracker_EnabledRaid=false;
		end
	end

end