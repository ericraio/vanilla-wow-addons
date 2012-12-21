--[[
SpellAlert (modified again)
Author:______Sent
Thanks:______Awen_(Original_Author)
_____________Mithryn_(versions_up_to_1.65)
]]

SA_STR_PROVERB = "In girum imus nocte et consumimur igni"

SALimits = {
	["size"] = {min = 1, max = 50},
	["lines"] = {min = 1, max = 20},
	["space"] = {min = 0, max = 100},
	["holdTime"] = {min = 0, max = 5},
	["fadeTime"] = {min = 0, max = 5},
};

local tmpVars = {};

local SADefaults = {};
		SADefaults[0] = {}; -- Damage
		SADefaults[0].r = 1;
		SADefaults[0].g = 0;
		SADefaults[0].b = 0;
		SADefaults[0].to = false;
		SADefaults[0].on = true;
		SADefaults[0].short = false;
		SADefaults[0].alert = 1;
		SADefaults[0].shortstr = ">>$s ($m)";

		SADefaults[1] = {}; -- Healing
		SADefaults[1].r = 1;
		SADefaults[1].g = 1;
		SADefaults[1].b = 0;
		SADefaults[1].to = false;
		SADefaults[1].on = true;
		SADefaults[1].short = false;
		SADefaults[1].alert = 1;
		SADefaults[1].shortstr = "**$s ($m)";

		SADefaults[2] = {}; -- Buff-gain
		SADefaults[2].r = 0;
		SADefaults[2].g = 0;
		SADefaults[2].b = 1;
		SADefaults[2].to = false;
		SADefaults[2].on = true;
		SADefaults[2].short = false;
		SADefaults[2].alert = 1;
		SADefaults[2].shortstr = "++$s ($m)";

		SADefaults[3] = {}; -- Buff-gone
		SADefaults[3].r = 0.1;
		SADefaults[3].g = 0.3;
		SADefaults[3].b = 1;
		SADefaults[3].to = false;
		SADefaults[3].on = true;
		SADefaults[3].short = false;
		SADefaults[3].alert = 1;
		SADefaults[3].shortstr = "--$s ($m)";

		SADefaults[4] = {}; -- Totem
		SADefaults[4].r = 0.5;
		SADefaults[4].g = 0.5;
		SADefaults[4].b = 0.5;
		SADefaults[4].to = false;
		SADefaults[4].on = true;
		SADefaults[4].short = false;
		SADefaults[4].alert = 1;
		SADefaults[4].shortstr = "$s Totem ($m)";

		SADefaults[5] = {}; -- Mob Emote
		SADefaults[5].r = 1;
		SADefaults[5].g = 0.6;
		SADefaults[5].b = 0;
		SADefaults[5].to = false;
		SADefaults[5].on = true;
		SADefaults[5].short = false;
		SADefaults[5].alert = 1;
		SADefaults[5].shortstr = "$s";

		SADefaults[6] = {}; -- Periodic
		SADefaults[6].r = 1;
		SADefaults[6].g = 1;
		SADefaults[6].b = 1;
		SADefaults[6].to = false;
		SADefaults[6].on = true;
		SADefaults[6].short = false;
		SADefaults[6].alert = 1;
		SADefaults[6].shortstr = "$s ($m)";

		SADefaults[7] = {}; -- Istant
		SADefaults[7].r = 1;
		SADefaults[7].g = 1;
		SADefaults[7].b = 1;
		SADefaults[7].to = false;
		SADefaults[7].on = true;
		SADefaults[7].short = false;
		SADefaults[7].alert = 1;
		SADefaults[7].shortstr = "^^$s ($m)";

		SADefaults[8] = {}; -- Crowd Control
		SADefaults[8].r = 0;
		SADefaults[8].g = 1;
		SADefaults[8].b = 0;
		SADefaults[8].to = false;
		SADefaults[8].on = true;
		SADefaults[8].short = false;
		SADefaults[8].alert = 1;
		SADefaults[8].shortstr = "<<$s ($m)";

		SADefaults[9] = {}; -- Misc
		SADefaults[9].r = 1;
		SADefaults[9].g = 1;
		SADefaults[9].b = 1;
		SADefaults[9].to = false;
		SADefaults[9].on = true;
		SADefaults[9].short = false;
		SADefaults[9].alert = 1;
		SADefaults[9].shortstr = ">>$s ($m)";

		SADefaults.on = true;
		SADefaults.offonrest = false;

		SADefaults.alert1 = {};
		SADefaults.alert1.outline = "";
		SADefaults.alert1.size = 30;
		SADefaults.alert1.holdTime = 3;
		SADefaults.alert1.fadeTime = 3;
		SADefaults.alert1.top = 0;
		SADefaults.alert1.left = 0;
		SADefaults.alert1.lines = 1;
		SADefaults.alert1.alpha = 1;
		SADefaults.alert1.font = "Fonts\\FRIZQT__.TTF";
		SADefaults.alert1.space = 0;

		SADefaults.alert2 = {};
		SADefaults.alert2.outline = "";
		SADefaults.alert2.size = 30;
		SADefaults.alert2.holdTime = 3;
		SADefaults.alert2.fadeTime = 3;
		SADefaults.alert2.top = 0;
		SADefaults.alert2.left = 0;
		SADefaults.alert2.lines = 1;
		SADefaults.alert2.alpha = 1;
		SADefaults.alert2.font = "Fonts\\FRIZQT__.TTF";
		SADefaults.alert2.space = 0;

		SADefaults.alert3 = {};
		SADefaults.alert3.outline = "";
		SADefaults.alert3.size = 30;
		SADefaults.alert3.holdTime = 3;
		SADefaults.alert3.fadeTime = 3;
		SADefaults.alert3.top = 0;
		SADefaults.alert3.left = 0;
		SADefaults.alert3.lines = 1;
		SADefaults.alert3.alpha = 1;
		SADefaults.alert3.font = "Fonts\\FRIZQT__.TTF";
		SADefaults.alert3.space = 0;

-- -------------- --
-- Init Functions --
-- -------------- --

function SA_OnLoad()

-- SPELLCASTGOOTHER = "%s casts %s.";

	MarsMessageParser_RegisterFunction("SpellAlert", SPELLCASTOTHERSTART, SA_BeginsToCast); -- "%s begins to cast %s."
	MarsMessageParser_RegisterFunction("SpellAlert", SPELLPERFORMOTHERSTART, SA_BeginsToPerform); -- "%s begins to perform %s."
	MarsMessageParser_RegisterFunction("SpellAlert", SPELLCASTGOOTHERTARGETTED, SA_CastsOn); -- "%s casts %s on %s."
	MarsMessageParser_RegisterFunction("SpellAlert", POWERGAINOTHEROTHER, SA_GainsFrom); -- "%s gains %d %s from %s's %s."
	MarsMessageParser_RegisterFunction("SpellAlert", AURAAPPLICATIONADDEDOTHERHELPFUL, SA_GainsX); -- "%s gains %s (%d)."
	MarsMessageParser_RegisterFunction("SpellAlert", AURAADDEDOTHERHELPFUL, SA_Gains); -- "%s gains %s."
	MarsMessageParser_RegisterFunction("SpellAlert", AURAREMOVEDOTHER, SA_FadesFrom); -- "%s fades from %s."

	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");

	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");

	SA_Reset();

	SlashCmdList["SpellAlertCOMMAND"] = SA_Handler;
	SLASH_SpellAlertCOMMAND1 = "/spellalert";
	DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00SpellAlert|r 1.11.8. Type /spellalert for options.");
end

function SA_Reset()
	SAVars = SADefaults;
end

function SA_SAVarsIntegrityCheck()

tmpVars = {};

	if (type(SAVars) ~= "table") then
		SA_Reset();
	else
		for currentNode in SADefaults do
			SA_CheckNode(SADefaults, SAVars, currentNode, tmpVars);
		end
		SAVars = tmpVars;
	end
end

function SA_CheckNode(masterParent, slaveParent, node, tmpTable)
	local master = masterParent[node];
	local slave = slaveParent[node];

	if (type(master) ~= type(slave)) then
		tmpTable[node] = master;

	elseif (type(master) == "table") then
		tmpTable[node] = {};
		for currentNode in master do
			SA_CheckNode(master, slave, currentNode, tmpTable[node]);
		end

	elseif (SALimits[node] and ((slave < SALimits[node].min) or (slave > SALimits[node].max))) then
		tmpTable[node] = master;

	else
		tmpTable[node] = slave;
	end
end