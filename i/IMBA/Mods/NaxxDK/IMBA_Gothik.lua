SpawnNumbers={};
TraineesSpawned=0;
DeathknightSpawned=0;
RidersSpawned=0;

IMBA_LIVE_TRAINEE_DEATH		= "Unrelenting Trainee dies."
IMBA_LIVE_DEATHKNIGHT_DEATH	= "Unrelenting Deathknight dies."
IMBA_LIVE_RIDER_DEATH		= "Unrelenting Rider dies."
IMBA_DEAD_TRAINEE_DEATH		= "Spectral Trainee dies."
IMBA_DEAD_DEATHKNIGHT_DEATH	= "Spectral Deathknight dies."
IMBA_DEAD_RIDER_DEATH		= "Spectral Rider dies."
IMBA_DEAD_HORSE_DEATH		= "Spectral Horse dies."

IMBA_GOTHIK_YELL = "Foolishly you have sought your own demise"

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_LIVE_TRAINEE_DEATH		= "Jeune recrue tenace meurt."
	IMBA_LIVE_DEATHKNIGHT_DEATH	= "Chevalier de la mort tenace meurt."
	IMBA_LIVE_RIDER_DEATH		= "Cavalier tenace meurt."
	IMBA_DEAD_TRAINEE_DEATH		= "Jeune recrue spectral meurt."
	IMBA_DEAD_DEATHKNIGHT_DEATH	= "Chevalier de la mort spectral meurt."
	IMBA_DEAD_RIDER_DEATH		= "Cavalier spectral meurt."
	IMBA_DEAD_HORSE_DEATH		= "Cheval spectral meurt."

	IMBA_GOTHIK_YELL = "Dans votre folie, vous avez provoqu\195\169 votre propre mort."
end

function IMBA_Gothik_UpdateBarNumbers()
	IMBA_Gothik_LiveTrainees:SetValText(SpawnNumbers["LiveTrainees"]-KillNumLiveTrainees);
	IMBA_Gothik_LiveDeathknights:SetValText(SpawnNumbers["LiveDeathknights"]-KillNumLiveDeathknights);
	IMBA_Gothik_LiveRiders:SetValText(SpawnNumbers["LiveRiders"]-KillNumLiveRiders);
	IMBA_Gothik_DeadTrainees:SetValText(KillNumLiveTrainees-KillNumDeadTrainees);
	IMBA_Gothik_DeadDeathknights:SetValText(KillNumLiveDeathknights-KillNumDeadDeathknights);
	IMBA_Gothik_DeadRiders:SetValText(KillNumLiveRiders-KillNumDeadRiders);
	IMBA_Gothik_DeadHorses:SetValText(KillNumLiveRiders-KillNumDeadHorses);
end

function IMBA_Gothik_InitSpawnNumbers()
	SpawnNumbers={};
	SpawnNumbers["LiveTrainees"]=0;
	SpawnNumbers["LiveDeathknights"]=0;
	SpawnNumbers["LiveRiders"]=0;

	KillNumLiveTrainees=0;
	KillNumLiveDeathknights=0;
	KillNumLiveRiders=0;
	KillNumDeadTrainees=0;
	KillNumDeadDeathknights=0;
	KillNumDeadRiders=0;
	KillNumDeadHorses=0;

	SendAddonMessage("IMBA", "VARSYNC KillNumLiveTrainees 0 REPLACE","RAID");
	SendAddonMessage("IMBA", "VARSYNC KillNumLiveDeathknights 0 REPLACE","RAID");
	SendAddonMessage("IMBA", "VARSYNC KillNumLiveRiders 0 REPLACE","RAID");
	SendAddonMessage("IMBA", "VARSYNC KillNumDeadTrainees 0 REPLACE","RAID");
	SendAddonMessage("IMBA", "VARSYNC KillNumDeadDeathknights 0 REPLACE","RAID");
	SendAddonMessage("IMBA", "VARSYNC KillNumDeadRiders 0 REPLACE","RAID");
	SendAddonMessage("IMBA", "VARSYNC KillNumDeadHorses 0 REPLACE","RAID");

	TraineesSpawned=0;
	DeathknightsSpawned=0;
	RidersSpawned=0;
	IMBA_Gothik_UpdateBarNumbers();
end

function IMBA_Gothik_TraineeSpawn()
	SpawnNumbers["LiveTrainees"]=SpawnNumbers["LiveTrainees"]+3;
	IMBA_Gothik_UpdateBarNumbers();

	TraineesSpawned=TraineesSpawned+1;
	if TraineesSpawned>= 11 then
		IMBA_Gothik_TimerTrainee.active=false;
		IMBA_Gothik_TimerTrainee:SetValText("");
	else
		IMBA_Gothik_TimerTrainee:SetBarText("Trainee Spawn "..TraineesSpawned+1);
	end
end

	
	

function IMBA_Gothik_DeathknightSpawn()
	SpawnNumbers["LiveDeathknights"]=SpawnNumbers["LiveDeathknights"]+2;
	IMBA_Gothik_UpdateBarNumbers();

	DeathknightsSpawned=DeathknightsSpawned+1;

	if DeathknightsSpawned>= 7 then	
		IMBA_Gothik_TimerDeathknight.active=false;
		IMBA_Gothik_TimerDeathknight:SetValText("");
	else
		IMBA_Gothik_TimerDeathknight:SetBarText("Deathknight Spawn "..DeathknightsSpawned+1);
	end
end

function IMBA_Gothik_RiderSpawn()
	SpawnNumbers["LiveRiders"]=SpawnNumbers["LiveRiders"]+1;
	RidersSpawned=RidersSpawned+1;
	IMBA_Gothik_UpdateBarNumbers();

	if RidersSpawned>= 4 then
		IMBA_Gothik_TimerRider.active=false;
		IMBA_Gothik_TimerRider:SetValText("");
	else
		IMBA_Gothik_TimerRider:SetBarText("Rider Spawn "..RidersSpawned+1);
	end
end


IMBA_GOTHIK_TRAINEE_SPAWN_TIME		=	20
IMBA_GOTHIK_TRAINEE_FIRST_SPAWN_TIME	=	27
IMBA_GOTHIK_DK_SPAWN_TIME		=	25
IMBA_GOTHIK_DK_FIRST_SPAWN_TIME		=	77
IMBA_GOTHIK_RIDER_SPAWN_TIME		=	30
IMBA_GOTHIK_RIDER_FIRST_SPAWN_TIME	=	137
IMBA_GOTHIK_STAGE1_TIME			=	270
	

function IMBA_Gothik_FirstTraineeSpawn()
	IMBA_Gothik_TimerTrainee:StartTimer(IMBA_GOTHIK_TRAINEE_SPAWN_TIME,true,IMBA_Gothik_TraineeSpawn);
	IMBA_Gothik_TraineeSpawn();
end

function IMBA_Gothik_FirstDeathknightSpawn()
	IMBA_Gothik_TimerDeathknight:StartTimer(IMBA_GOTHIK_DK_SPAWN_TIME,true,IMBA_Gothik_DeathknightSpawn);
	IMBA_Gothik_DeathknightSpawn();
end

function IMBA_Gothik_FirstRiderSpawn()
	IMBA_Gothik_TimerRider:StartTimer(IMBA_GOTHIK_RIDER_SPAWN_TIME,true,IMBA_Gothik_RiderSpawn);
	IMBA_Gothik_RiderSpawn();

end

function IMBA_Gothik_Stage2Start()	
	IMBA_Gothik_TimerStage2:SetValText("");
	IMBA_Gothik_TimerStage2.active=false;
end

function IMBA_Gothik_Start()
	IMBA_Gothik_TimerTrainee:StartTimer(IMBA_GOTHIK_TRAINEE_FIRST_SPAWN_TIME,false,IMBA_Gothik_FirstTraineeSpawn);
	IMBA_Gothik_TimerDeathknight:StartTimer(IMBA_GOTHIK_DK_FIRST_SPAWN_TIME,false,IMBA_Gothik_FirstDeathknightSpawn);
	IMBA_Gothik_TimerRider:StartTimer(IMBA_GOTHIK_RIDER_FIRST_SPAWN_TIME,false,IMBA_Gothik_FirstRiderSpawn);

	IMBA_Gothik_TimerStage2:StartTimer(IMBA_GOTHIK_STAGE1_TIME,false,IMBA_Gothik_Stage2Start);

	IMBA_Gothik_TimerTrainee:SetBarText("Trainee Spawn 1");
	IMBA_Gothik_TimerDeathknight:SetBarText("Deathknight Spawn 1");
	IMBA_Gothik_TimerRider:SetBarText("Rider Spawn 1");
end



function IMBA_Gothik_YellActivator(arg1)
	if string.find(arg1,IMBA_GOTHIK_YELL) then	--Normal Aggro Yell
		IMBA_Gothik_InitSpawnNumbers();
		IMBA_Gothik_Start();
		IMBA_Gothik:Show();
		return true;
	elseif string.find(arg1,"Teamanare shi rikk mannor rikk lok karkun") then	--Aggro Yell in Demonic
		IMBA_Gothik_InitSpawnNumbers();
		IMBA_Gothik_Start();
		IMBA_Gothik:Show();
		return true;
	end
	return false;
end

function IMBA_Gothik_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
end

function IMBA_Gothik_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
end


function IMBA_Gothik_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);



	
	IMBA_Gothik_Title:SetText("Gothik Status");
	IMBA_Gothik_TitleLive:SetText("Live Spawn Numbers");

	IMBA_Gothik_LiveTrainees:SetBarText("Trainees");
	IMBA_Gothik_LiveTrainees:SetValText("0");
	IMBA_Gothik_LiveDeathknights:SetBarText("Deathknights");
	IMBA_Gothik_LiveDeathknights:SetValText("0");
	IMBA_Gothik_LiveRiders:SetBarText("Riders");
	IMBA_Gothik_LiveRiders:SetValText("0");


	IMBA_Gothik_TitleDead:SetText("Undead Spawn Numbers");

	IMBA_Gothik_DeadTrainees:SetBarText("Trainees");
	IMBA_Gothik_DeadTrainees:SetValText("0");
	IMBA_Gothik_DeadDeathknights:SetBarText("Deathknights");
	IMBA_Gothik_DeadDeathknights:SetValText("0");
	IMBA_Gothik_DeadRiders:SetBarText("Riders");
	IMBA_Gothik_DeadRiders:SetValText("0");
	IMBA_Gothik_DeadHorses:SetBarText("Horses");
	IMBA_Gothik_DeadHorses:SetValText("0");

	IMBA_Gothik_TitleTimers:SetText("Timers");


	IMBA_Gothik_TimerTrainee.timeLength=20;
	IMBA_Gothik_TimerTrainee.timeEnd=GetTime()+20;
	IMBA_Gothik_TimerTrainee.repeating=true;
	IMBA_Gothik_TimerTrainee.active=false;
	IMBA_Gothik_TimerTrainee:SetBarText("Trainee Spawn 1");
	IMBA_Gothik_TimerTrainee.callback=IMBA_Gothik_TraineeSpawn;

	IMBA_Gothik_TimerDeathknight.timeLength=25;
	IMBA_Gothik_TimerDeathknight.timeEnd=GetTime()+25;
	IMBA_Gothik_TimerDeathknight.repeating=true;
	IMBA_Gothik_TimerDeathknight.active=false;
	IMBA_Gothik_TimerDeathknight:SetBarText("Deathknight Spawn 1");
	IMBA_Gothik_TimerDeathknight.callback=IMBA_Gothik_DeathknightSpawn;

	IMBA_Gothik_TimerRider.timeLength=30;
	IMBA_Gothik_TimerRider.timeEnd=GetTime()+30;
	IMBA_Gothik_TimerRider.repeating=true;
	IMBA_Gothik_TimerRider.active=false;
	IMBA_Gothik_TimerRider:SetBarText("Rider Spawn 1");
	IMBA_Gothik_TimerRider.callback=IMBA_Gothik_RiderSpawn;

	IMBA_Gothik_TimerStage2.timeLength=270;
	IMBA_Gothik_TimerStage2.timeEnd=GetTime()+270;
	IMBA_Gothik_TimerStage2.repeating=true;
	IMBA_Gothik_TimerStage2.active=false;
	IMBA_Gothik_TimerStage2:SetBarText("Gothik Comes Down");

	IMBA_Gothik_InitSpawnNumbers();
	

	
	IMBA_AddAddon("Gothik the Harverster", "Tracks Spawn Times and Total Adds Alive", IMBA_LOCATIONS_NAXX_DK, nil, "IMBA_Gothik_YellActivator","Foolishly you have sought your own demise", "IMBA_Gothik");
	IMBA_AddSyncVar("Gothik the Harverster","KillNumLiveTrainees","MAX");
	IMBA_AddSyncVar("Gothik the Harverster","KillNumLiveDeathknights","MAX");
	IMBA_AddSyncVar("Gothik the Harverster","KillNumLiveRiders","MAX");
	IMBA_AddSyncVar("Gothik the Harverster","KillNumDeadTrainees","MAX");
	IMBA_AddSyncVar("Gothik the Harverster","KillNumDeadDeathknights","MAX");
	IMBA_AddSyncVar("Gothik the Harverster","KillNumDeadRiders","MAX");
	IMBA_AddSyncVar("Gothik the Harverster","KillNumDeadHorses","MAX");
end

function IMBA_Gothik_OnEvent(event)
	if ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
		if ( arg1 == IMBA_LIVE_TRAINEE_DEATH ) then
			KillNumLiveTrainees=KillNumLiveTrainees+1;
			IMBA_Gothik_UpdateBarNumbers();
		elseif ( arg1 == IMBA_LIVE_DEATHKNIGHT_DEATH ) then
			KillNumLiveDeathknights=KillNumLiveDeathknights+1;
			IMBA_Gothik_UpdateBarNumbers();
		elseif ( arg1 == IMBA_LIVE_RIDER_DEATH ) then
			KillNumLiveRiders=KillNumLiveRiders+1;
			IMBA_Gothik_UpdateBarNumbers();
		elseif ( arg1 == IMBA_DEAD_TRAINEE_DEATH ) then
			KillNumDeadTrainees=KillNumDeadTrainees+1;
			IMBA_Gothik_UpdateBarNumbers();
		elseif ( arg1 == IMBA_DEAD_DEATHKNIGHT_DEATH ) then
			KillNumDeadDeathknights=KillNumDeadDeathknights+1;
			IMBA_Gothik_UpdateBarNumbers();
		elseif ( arg1 == IMBA_DEAD_RIDER_DEATH ) then
			KillNumDeadRiders=KillNumDeadRiders+1;
			IMBA_Gothik_UpdateBarNumbers();
		elseif ( arg1 == IMBA_DEAD_HORSE_DEATH ) then
			KillNumDeadHorses=KillNumDeadHorses+1;
			IMBA_Gothik_UpdateBarNumbers();
		end
	end
end