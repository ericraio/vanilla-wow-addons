IMBA_KelThuzadInterrupt_Players={};

function IMBA_KelThuzadInterrupt_CastFrostbolt()
	IMBA_KelThuzadInterrupt_TimerFrostbolt:SetBarText("Frostbolt Casting in");
	IMBA_KelThuzadInterrupt_TimerFrostbolt.timeLength=2;
	IMBA_KelThuzadInterrupt_TimerFrostbolt.timeEnd=GetTime()+2;
	IMBA_KelThuzadInterrupt_TimerFrostbolt.repeating=false;
	IMBA_KelThuzadInterrupt_TimerFrostbolt.active=true;
end

function IMBA_KelThuzadInterrupt_AddPlayer(name)
	tinsert(IMBA_KelThuzadInterrupt_Players,{name,GetTime(),"Kick",IMBA_FindPlayerUnitByName(name)});
end

function IMBA_KelThuzadInterrupt_PlayerKicks(name)
	for k,v in IMBA_KelThuzadInterrupt_Players do
		if v[1]==name then
			v[2]=GetTime()+10;
			v[3]=10;
			v[4]="Kick";
			return;
		end
	end
	tinsert(IMBA_KelThuzadInterrupt_Players,{name,GetTime()+10,10,"Kick",IMBA_FindPlayerUnitByName(name)});
end

function IMBA_KelThuzadInterrupt_PlayerPummels(name)
	for k,v in IMBA_KelThuzadInterrupt_Players do
		if v[1]==name then
			v[2]=GetTime()+10;
			v[3]=10;
			v[4]="Pummel";
			return;
		end
	end
	tinsert(IMBA_KelThuzadInterrupt_Players,{name,GetTime()+10,10,"Pummel",IMBA_FindPlayerUnitByName(name)});
end

function IMBA_KelThuzadInterrupt_PlayerShieldBashes(name)
	for k,v in IMBA_KelThuzadInterrupt_Players do
		if v[1]==name then
			v[2]=GetTime()+12;
			v[3]=12;
			v[4]="Shield Bash";
			return;
		end
	end
	tinsert(IMBA_KelThuzadInterrupt_Players,{name,GetTime()+12,12,"Shield Bash",IMBA_FindPlayerUnitByName(name)});
end

function IMBA_KelThuzadInterrupt_Sort(v1,v2)
	if v1[2]==v2[2] then
		return v1[1]<v2[1];
	else
		return v1[2]<v2[2];
	end
end
IMBA_KelThuzadInterrupt_OldOption1=0;
IMBA_KelThuzadInterrupt_OldOption2=0;

function IMBA_KelThuzadInterrupt_OnUpdate()
	if (IMBA_KelThuzadInterrupt_OldOption1~=IMBA_CheckVar("Kel'Thuzad - Interrupt Assister","TrackRogues")) or (IMBA_KelThuzadInterrupt_OldOption2~=IMBA_CheckVar("Kel'Thuzad - Interrupt Assister","TrackWarriors")) then
		IMBA_KelThuzadInterrupt_OldOption1=IMBA_CheckVar("Kel'Thuzad - Interrupt Assister","TrackRogues");
		IMBA_KelThuzadInterrupt_OldOption2=IMBA_CheckVar("Kel'Thuzad - Interrupt Assister","TrackWarriors");
		IMBA_KelThuzadInterrupt_UpdateList();
	end
	
	local numEntries = getn(IMBA_KelThuzadInterrupt_Players);

	for k,v in IMBA_KelThuzadInterrupt_Players do
		if UnitIsDeadOrGhost(v[5]) then
			v[2]=GetTime()+12;
		end
	end
	table.sort(IMBA_KelThuzadInterrupt_Players, IMBA_KelThuzadInterrupt_Sort);
	for i=1,8,1 do
		if i<=numEntries then
			getglobal("IMBA_KelThuzadInterrupt_Interrupt"..i).active=true;
			getglobal("IMBA_KelThuzadInterrupt_Interrupt"..i).timeEnd=IMBA_KelThuzadInterrupt_Players[i][2];
			getglobal("IMBA_KelThuzadInterrupt_Interrupt"..i).timeLength=IMBA_KelThuzadInterrupt_Players[i][3];
			getglobal("IMBA_KelThuzadInterrupt_Interrupt"..i):SetBarText(IMBA_KelThuzadInterrupt_Players[i][1].."'s "..IMBA_KelThuzadInterrupt_Players[i][4]);
			if IMBA_KelThuzadInterrupt_Players[i][1]==IMBA_PlayerName then
				getglobal("IMBA_KelThuzadInterrupt_Icon"..i):Show();
			else
				getglobal("IMBA_KelThuzadInterrupt_Icon"..i):Hide();
			end
		else
			getglobal("IMBA_KelThuzadInterrupt_Interrupt"..i).active=true;
			getglobal("IMBA_KelThuzadInterrupt_Interrupt"..i).timeEnd=0;
			getglobal("IMBA_KelThuzadInterrupt_Interrupt"..i).timeLength=1;
			getglobal("IMBA_KelThuzadInterrupt_Interrupt"..i):SetBarText("None");
			getglobal("IMBA_KelThuzadInterrupt_Interrupt"..i):Hide();
			getglobal("IMBA_KelThuzadInterrupt_Icon"..i):Hide();
		end
	end
	if numEntries>8 then
		numEntries=8;
	end
	IMBA_KelThuzadInterrupt:SetHeight(numEntries*20+70);
end

function IMBA_KelThuzadInterrupt_PlayerInList(player)
	for k,v in IMBA_KelThuzadInterrupt_Players do
		if v[1]==player then
			return true;
		end
	end
	return false;
end

function IMBA_KelThuzadInterrupt_UpdateList()
	IMBA_KelThuzadInterrupt_Players={};
	for i = 1, GetNumRaidMembers() do
		if UnitExists("raid"..i) and (IMBA_KelThuzadInterrupt_PlayerInList(UnitName("raid"..i))==false) then
			local playerClass, englishClass = UnitClass("raid"..i);

			if englishClass=="WARRIOR" and (IMBA_CheckVar("Kel'Thuzad - Interrupt Assister","TrackWarriors")==false) then
				tinsert(IMBA_KelThuzadInterrupt_Players,{UnitName("raid"..i),GetTime(),12,"Shield Bash","raid"..i});
			elseif englishClass=="ROGUE" and (IMBA_CheckVar("Kel'Thuzad - Interrupt Assister","TrackRogues")==false)  then
				tinsert(IMBA_KelThuzadInterrupt_Players,{UnitName("raid"..i),GetTime(),10,"Kick","raid"..i});
			end
		end
	end
end

function IMBA_KelThuzadInterrupt_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");

	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
end

function IMBA_KelThuzadInterrupt_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");

	this:UnregisterEvent("RAID_ROSTER_UPDATE");
	this:UnregisterEvent("PARTY_MEMBERS_CHANGED");
end

function IMBA_KelThuzadInterrupt_YellActivator(arg1)
	if string.find(arg1,IMBA_KelThuzad_Stage1_End_Yell1) or string.find(arg1,IMBA_KelThuzad_Stage1_End_Yell2) or string.find(arg1,IMBA_KelThuzad_Stage1_End_Yell3) then
		IMBA_KelThuzadInterrupt:Show();	
	end
end

function IMBA_KelThuzadInterrupt_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_KelThuzadInterrupt_Title:SetText("Kel'Thuzad Interrupts");
	IMBA_KelThuzadInterrupt_TimerFrostbolt:SetBarText("Frostbolt Casting in");
	IMBA_KelThuzadInterrupt_TitleInterrupters:SetText("Interrupters");
	for i=1,8,1 do
		getglobal("IMBA_KelThuzadInterrupt_Icon"..i):SetIcon("Interface\\AddOns\\IMBA\\textures\\RedArrow.blp");
	end
	IMBA_PlayerName=UnitName("player");
	IMBA_AddAddon("Kel'Thuzad - Interrupt Assister", "Aids melee interrupters in not wasting interrupts", IMBA_LOCATIONS_NAXX_LAIR, nil, "IMBA_KelThuzadInterrupt_YellActivator",IMBA_KelThuzad_Stage1_End_Yell1,"IMBA_KelThuzadInterrupt");
	IMBA_AddOption2("Kel'Thuzad - Interrupt Assister","TrackRogues","Don't Track Rogues");
	IMBA_AddOption2("Kel'Thuzad - Interrupt Assister","TrackWarriors","Don't Track Warriors");

	IMBA_KelThuzadInterrupt_UpdateList();

	IMBA_KelThuzadInterrupt_TimerFrostbolt.timeLength=2;
	IMBA_KelThuzadInterrupt_TimerFrostbolt.timeEnd=0;
	IMBA_KelThuzadInterrupt_TimerFrostbolt.active=true;

	IMBA_KelThuzadInterrupt_RegisterEvents();
end

function IMBA_KelThuzadInterrupt_OnEvent(event)
	if event=="CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE" then
		if arg1=="Kel'Thuzad begins to cast Frostbolt." then
			IMBA_KelThuzadInterrupt_CastFrostbolt();
			IMBA_AddAlert("** Kel'Thuzad begins to cast Frostbolt **");
		end
	elseif (event=="CHAT_MSG_SPELL_SELF_DAMAGE") or (event=="CHAT_MSG_SPELL_PARTY_DAMAGE") or (event=="CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE") or (event=="CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then
		local iStart, iEnd, sPlayer;

		if IMBA_CheckVar("Kel'Thuzad - Interrupt Assister","TrackRogues")==false then
			iStart, iEnd, sPlayer = string.find(arg1, "^([%a]+) ?'?s? Kick");
			if ( sPlayer ) then
				if ( sPlayer == "Your") then
					IMBA_KelThuzadInterrupt_PlayerKicks(IMBA_PlayerName);
					return;
				else
					IMBA_KelThuzadInterrupt_PlayerKicks(sPlayer);
					return;
				end
			end	
		end
		
		if IMBA_CheckVar("Kel'Thuzad - Interrupt Assister","TrackWarriors")==false then
			iStart, iEnd, sPlayer = string.find(arg1, "^([%a]+) ?'?s? Pummel");
			if ( sPlayer ) then
				if ( sPlayer == "Your") then
					IMBA_KelThuzadInterrupt_PlayerPummels(IMBA_PlayerName);
					return;
				else
					IMBA_KelThuzadInterrupt_PlayerPummels(sPlayer);
					return;
				end
			end

			iStart, iEnd, sPlayer = string.find(arg1, "^([%a]+) ?'?s? Shield Bash");
			if ( sPlayer ) then
				if ( sPlayer == "Your") then
					IMBA_KelThuzadInterrupt_PlayerShieldBashes(IMBA_PlayerName);
					return;
				else
					IMBA_KelThuzadInterrupt_PlayerShieldBashes(sPlayer);
					return;
				end
			end
		end

		if string.find(arg1,"interrupts Kel'Thuzad's Frostbolt.") then
			IMBA_KelThuzadInterrupt_TimerFrostbolt.timeEnd=0;
			IMBA_KelThuzadInterrupt_TimerFrostbolt:SetBarText("Frostbolt Interrupted");
			IMBA_AddAlert("** Frostbolt Interrupted **");
		end
	elseif (event=="RAID_ROSTER_UPDATE") or (event=="PARTY_MEMBERS_CHANGED") then
		IMBA_KelThuzadInterrupt_UpdateList();
	end
end