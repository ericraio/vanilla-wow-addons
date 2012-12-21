--[[
SpellAlert (modified again)
Author:______Sent
Thanks:______Awen_(Original_Author)
_____________Mithryn_(versions_up_to_1.65)
]]

local fullString;
local currentTarget;
local partyNum = 0;
local raidNum = 0;
local membersList = {};

local cType = 0; -- 0=damage, 1=heal, 2=buff-gain, 3=buff-gone, 4=totem, 5=emote, 6=periodic, 7=istant, 8=CC, 9=Misc

-- --------------- --
-- Event functions --
-- --------------- --

function SA_BeginsToCast(mob, spell)
	if (SA_TBL_HEALS[spell]) then cType = 1; end
	if (SA_TBL_CC[spell]) then cType = 8; end
	if ((not SAVars[cType].on) or membersList[mob] or (SAVars[cType].to and (currentTarget ~= mob)) or SA_IGNORE[cType][spell]) then
		return;
	end
	AlertFrame_Show(SAVars[cType].alert, fullString, mob, spell);
end

function SA_BeginsToPerform(mob, spell)
	if ((not SAVars[cType].on) or membersList[mob] or (SAVars[cType].to and (currentTarget ~= mob)) or SA_IGNORE[cType][spell]) then
		return;
	end
	AlertFrame_Show(SAVars[cType].alert, fullString, mob, spell);
end

function SA_CastsOn(mob, spell, mob2)
	if ((not SAVars[cType].on) or membersList[mob] or (SAVars[cType].to and (currentTarget ~= mob)) or SA_IGNORE[cType][spell]) then
		return;
	end
	AlertFrame_Show(SAVars[cType].alert, fullString, mob, spell);
end

function SA_GainsFrom(mob, num, power, mob2, spell)
	if ((not SAVars[cType].on) or membersList[mob2] or (SAVars[cType].to and (currentTarget ~= mob)) or SA_IGNORE[cType][spell]) then
		return;
	end
	AlertFrame_Show(SAVars[cType].alert, fullString, mob, num.." "..power);
end

function SA_GainsX(mob, spell, num)
	if ((not SAVars[cType].on) or membersList[mob] or (SAVars[cType].to and (currentTarget ~= mob)) or SA_IGNORE[cType][spell]) then
		return;
	end
	AlertFrame_Show(SAVars[cType].alert, fullString, mob, spell.." ("..num..")");
end

function SA_Gains(mob, spell)
	if ((not SAVars[cType].on) or membersList[mob] or (SAVars[cType].to and (currentTarget ~= mob)) or SA_IGNORE[cType][spell]) then
		return;
	end
	AlertFrame_Show(SAVars[cType].alert, fullString, mob, spell);
end

function SA_FadesFrom(spell, mob)
	if ((not SAVars[cType].on) or membersList[mob] or (SAVars[cType].to and (currentTarget ~= mob)) or SA_IGNORE[cType][spell]) then
		return;
	end
	AlertFrame_Show(SAVars[cType].alert, fullString, mob, spell);
end

function SA_OnEvent(event, arg1, arg2)
	fullString = arg1;

	if (event == "PLAYER_ENTERING_WORLD") then
		SA_SMF_Adjust(1);
		SA_SMF_Adjust(2);
		SA_SMF_Adjust(3);
		SA_SMF_UpdateLook(1);
		SA_SMF_UpdateLook(2);
		SA_SMF_UpdateLook(3);

	elseif (event == "VARIABLES_LOADED") then
		SA_SAVarsIntegrityCheck();

	elseif (event == "PARTY_MEMBERS_CHANGED") then
		local num = GetNumPartyMembers();
		if ((num ~= partyNum) and (GetNumRaidMembers() == 0)) then
			partyNum = num;
			SA_BuildMembersList(false);
		end

	elseif (event == "RAID_ROSTER_UPDATE") then
		local num = GetNumRaidMembers();
		if (num ~= raidNum) then
			raidNum = num;
			SA_BuildMembersList(true);
		end

	elseif (event == "PLAYER_TARGET_CHANGED") then
		currentTarget = UnitName("target");

	elseif (not SAVars.on) then return;
	elseif (SAVars.offonrest and IsResting()) then return;

	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
		cType = 0;
		MarsMessageParser_ParseMessage("SpellAlert", arg1);

	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") then
		cType = 2;
		MarsMessageParser_ParseMessage("SpellAlert", arg1);

	elseif (event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS") then
		cType = 6;
		MarsMessageParser_ParseMessage("SpellAlert", arg1);

	elseif (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then
		cType = 0;
		MarsMessageParser_ParseMessage("SpellAlert", arg1);

	elseif (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF") then
		cType = 2;
		MarsMessageParser_ParseMessage("SpellAlert", arg1);

	elseif (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
		cType = 6;
		MarsMessageParser_ParseMessage("SpellAlert", arg1);

	elseif (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then
		cType = 3;
		MarsMessageParser_ParseMessage("SpellAlert", arg1);

	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
		cType = 5;
		if ((not SAVars[cType].on) or (SAVars[cType].to and (currentTarget ~= arg2)) or SA_IGNORE[cType][arg1]) then
			return;
		end
		AlertFrame_Show(SAVars[cType].alert, arg2.." "..arg1, arg2, arg1);

	end
end

function SA_BuildMembersList(isRaid)
	local max, g, name;
	if (isRaid) then
		max = 40;
		g = "raid";
	else
		max = 4;
		g = "party";
	end
	for i = 1, max do
		name = UnitName(g..i);
		if (name) then
			membersList[name] = true; 
		end
		name = UnitName(g.."pet"..i);
		if (name) then
			membersList[name] = true;
		end
	end
end


--==QUESTA NON DOVREBBE STARE QUI==--
function AlertFrame_Show(num, fullStr, mob, spell)
	if (SAVars[cType].short) then
		getglobal("SA_SMF"..num):AddMessage(string.gsub(string.gsub(SAVars[cType].shortstr, "$m", mob), "$s", spell), SAVars[cType].r, SAVars[cType].g, SAVars[cType].b);
	else
		getglobal("SA_SMF"..num):AddMessage(fullStr, SAVars[cType].r, SAVars[cType].g, SAVars[cType].b);
	end
end