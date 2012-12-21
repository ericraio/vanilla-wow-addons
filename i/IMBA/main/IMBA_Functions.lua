function IMBA_RaidInCombat()
	if GetNumRaidMembers()==0 then
		return false
	end
	NumInCombat=0;
	for i = 1, GetNumRaidMembers() do
		if UnitAffectingCombat("raid"..i)~=nil then
			NumInCombat=NumInCombat+UnitAffectingCombat("raid"..i);
		end
	end
	if NumInCombat>2 then
		return true;
	end
	return false;
end

function IMBA_BossAggroed(BossName)
	if UnitName("target")==BossName then
		return true;
	end

	if GetNumRaidMembers()==0 then
		return false
	end
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid"..i.."target")==BossName then
			if UnitAffectingCombat("raid"..i.."target")~=nil then
				return true;
			end
		end
	end
	return false;
end

--Don't call this before UI has finished loading
function IMBA_SetLogDistance(Dist)
	if not Dist then
		Dist=200;
	end
	SetCVar("CombatDeathLogRange", Dist);
	SetCVar("CombatLogRangeParty", Dist);
	SetCVar("CombatLogRangePartyPet", Dist);
	SetCVar("CombatLogRangeFriendlyPlayers", Dist);
	SetCVar("CombatLogRangeFriendlyPlayersPets", Dist);
	SetCVar("CombatLogRangeHostilePlayers", Dist);
	SetCVar("CombatLogRangeHostilePlayersPets", Dist);
	SetCVar("CombatLogRangeCreature", Dist);
end


--This Function is From AllInOneInventory
function IMBA_ExtractNextParam(msg)
	local params = msg;
	local command = params;
	local index = strfind(command, " ");
	if ( index ) then
		command = strsub(command, 1, index-1);
		params = strsub(params, index+1);
	else
		params = "";
	end
	return command, params;
end

function IMBA_FindBuffCountAndDuration(name)
	local j, buff, buffApplications, buffTime;
	for j=1,16 do
		buff = GetPlayerBuffTexture(GetPlayerBuff(j - 1, "HELPFUL"));
		if string.find(string.upper(buff),string.upper(name)) then
			buffApplications = GetPlayerBuffApplications(GetPlayerBuff(j - 1, "HELPFUL"));
			buffTime = GetPlayerBuffTimeLeft(GetPlayerBuff(j - 1, "HELPFUL"));
			return buffApplications, buffTime;
		end
	end
	return 0, 0;
end
function IMBA_FindDebuffCountAndDuration(name)
	local j, buff, debuffApplications, debuffTime;
	for j=1,16 do
		buff = GetPlayerBuffTexture(GetPlayerBuff(j - 1, "HARMFUL"));
		if buff~=nil and string.find(string.upper(buff),string.upper(name)) then
			debuffApplications = GetPlayerBuffApplications(GetPlayerBuff(j - 1, "HARMFUL"));
			debuffTime = GetPlayerBuffTimeLeft(GetPlayerBuff(j - 1, "HARMFUL"));
			return debuffApplications, debuffTime;
		end
	end
	return 0, 0;
end

function IMBA_GetRaidIconUnitID(raidtargetindex)
	if GetNumRaidMembers()==0 then
		return nil
	end
	for i=1,GetNumRaidMembers() do
		if UnitExists("raid"..i) and GetRaidTargetIndex("raid"..i) == raidtargetindex then
			return "raid"..i
		elseif UnitExists("raid"..i.."target") and GetRaidTargetIndex("raid"..i.."target") == raidtargetindex then
			return "raid"..i.."target"
		elseif UnitExists("raid"..i.."targettarget") and GetRaidTargetIndex("raid"..i.."targettarget") == raidtargetindex then
			return "raid"..i.."targettarget"
		elseif UnitExists("raidpet"..i) and GetRaidTargetIndex("raidpet"..i) == raidtargetindex then
			return "raidpet"..i
		end
	end
	return nil;
end

function IMBA_GetRaidIconName(raidtargetindex)
	if raidtargetindex==1 then
		return "Star";
	elseif raidtargetindex==2 then
		return "Circle";
	elseif raidtargetindex==3 then
		return "Diamond";
	elseif raidtargetindex==4 then
		return "Triangle";
	elseif raidtargetindex==5 then
		return "Moon";
	elseif raidtargetindex==6 then
		return "Square";
	elseif raidtargetindex==7 then
		return "Cross";
	elseif raidtargetindex==8 then
		return "Skull";
	end
end

function IMBA_FindPlayerUnitByName(name)
	if UnitExists("player") and (UnitName("player")==name) then
		return "player";
	end
	if GetNumRaidMembers()==0 then
		return nil
	end
	for i=1,GetNumRaidMembers() do
		if UnitExists("raid"..i) and (UnitName("raid"..i)==name) then
			return "raid"..i;
		end
	end
	return nil;
end

function IMBA_FindUnitByName(name)
	if UnitExists("player") and (UnitName("player")==name) then
		return "player";
	end
	if UnitExists("playertarget") and (UnitName("playertarget")==name) then
		return "playertarget";
	end
	if GetNumRaidMembers()==0 then
		return nil
	end
	for i=1,GetNumRaidMembers() do
		if UnitExists("raid"..i) and (UnitName("raid"..i)==name) then
			return "raid"..i;
		elseif UnitExists("raid"..i.."target") and (UnitName("raid"..i.."target")==name) then
			return "raid"..i.."target";
		end
	end
	return nil;
end

function IMBA_SendEvent(event)
	local frame
	
	-- first let's find all the frames
	local hasonevent
		
	while true do
		
		-- get next frame
		frame = EnumerateFrames(frame)
		if frame == nil then
			break
		end
	

		hasonevent = frame:GetScript("OnEvent")
		
		if hasonevent then
			hasonevent(event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9);
		end
	end 
end

function IMBA_CheckIfCanActivate(Addon)
	return (IMBA_Addons[Addon].RegenActivator~=nil) or (IMBA_Addons[Addon].YellActivator~=nil);
end

function IMBA_IsPlayerALeader()
	return IsPartyLeader() or IsRaidLeader() or IsRaidOfficer()
end

--Function from gatherer though slightly changed to be more correctly named
function IMBA_isMinimapInsideWMO()
	local tempzoom = 0;
	local InsideWMO = 0;
	if (GetCVar("minimapZoom") == GetCVar("minimapInsideZoom")) then
		if (GetCVar("minimapInsideZoom")+0 >= 3) then 
			Minimap:SetZoom(Minimap:GetZoom() - 1);
			tempzoom = 1;
		else
			Minimap:SetZoom(Minimap:GetZoom() + 1);
			tempzoom = -1;
		end
	end
	if (GetCVar("minimapInsideZoom")+0 == Minimap:GetZoom()) then InsideWMO = 1; end
	Minimap:SetZoom(Minimap:GetZoom() + tempzoom);
	return InsideWMO;
end

function IMBA_Flash_Warning()
	UIFrameFlash(LowHealthFrame, 0.5, 0.5, 5);
	LowHealthFrame.flashing = 1;
end

--Just some fun function I made to traverse all the children of a frame
--Help me find about screen flashing :)
--UIFrameFlash(LowHealthFrame, 0.5, 0.5, 5);	LowHealthFrame.flashing = 1;
function TraverseChildren(TheFrame,msg)
	local i, smsg;
	if not msg then
		msg="";
	end
	
	local children = {TheFrame:GetChildren()};
	for i=1,getn(children) do
		if not children[i]:GetName() then
			DEFAULT_CHAT_FRAME:AddMessage(msg.."Child "..i);
			smsg=msg.."Child "..i.."->"
			
		else
			DEFAULT_CHAT_FRAME:AddMessage(msg..children[i]:GetName());
			smsg=msg..children[i]:GetName().."->"
		end
		TraverseChildren(children[i],smsg)		
	end
end
