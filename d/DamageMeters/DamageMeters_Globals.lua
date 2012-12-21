-------------------------------------------------------------------------------

DamageMeters_TABLE_MAX = 50;

-- Hit types.
DM_HIT = 1;
DM_CRT = 2;
DM_DOT = 3;

DamageMeters_Relation_SELF = 1;
DamageMeters_Relation_PET = 2;
DamageMeters_Relation_PARTY = 3;
DamageMeters_Relation_FRIENDLY = 4;
DamageMeters_Relation_MAX = 4;

DM_TABLE_A	= 1;
DM_TABLE_B	= 2;
DMT_FIGHT	= 3;
DMT_MAX		= 3

-- Damage type constants.
DM_DMGTYPE_ARCANE = 1;
DM_DMGTYPE_FIRE = 2;
DM_DMGTYPE_NATURE = 3;
DM_DMGTYPE_FROST = 4;
DM_DMGTYPE_SHADOW = 5;
DM_DMGTYPE_RESISTMAX = 5;
DM_DMGTYPE_HOLY = 6;
DM_DMGTYPE_PHYSICAL = 7;
DM_DMGTYPE_DEFAULT = 8;

DM_MSGTYPE_DAMAGE = 1;
DM_MSGTYPE_DAMAGERECEIVED = 2;
DM_MSGTYPE_HEALING = 3;

-- A debugging system: setting these flags to true (via the menu or otherwise) will
-- normally cause bits of code to not be run.  Useful for tracking down memory "leaks".
DM_Bypass = {
	["Constant Update"] = false,
	["Update All"] = false,
	["Update Bars"] = false,
	["Update Tables"] = false,
	["Sort"] = false,
	["Determine Ranks"] = false,
	["Determine Ranks 1"] = false,
	["SetBarInfo All"] = false,
	["Event All"] = false,
	["Generate AddValues"] = false, 
	["Generate Events"] = false,
	["UpdateTableEntry"] = false,
	["AddValue"] = false,
	["AddValue 1"] = false,
	["AddValue 2"] = false,
	["AddEvent"] = false,
	["AddEvent 1"] = false,
	["AddEvent 2"] = false,
	["BuildSpellHash"] = false,
	["CheckMsgInfoAndProcess"] = false,
	["CheckMsgInfoAndProcess 1"] = false,
};


-------------------------------------------------------------------------------
-- Functions

function DM_clone(node)
  if type(node) ~= "table" then return node end
  local b = {}
  table.foreach(node, function(k,v) b[k]=DM_clone(v) end)
  return b
end

function DM_GetFraction(num, dem)
	return (dem ~= 0) and (num/dem) or 0;
end

function DM_DUMP_TABLE(table)
	DM_DUMP_RECURSIVE(table, "[root]", "");
end

function DM_DUMP_RECURSIVE(node, name, indent)
	if type(node) ~= "table" then
		if type(node) == "boolean" then
			DMPrint(indent..name.."="..(node and "true" or "false"))
		elseif (node == nil) then
			DMPrint(indent..name.."=nil");
		else
			DMPrint(indent..name.."="..node)
		end
	else
		DMPrint(indent..name.."{", destination);
		table.foreach(node, function(k,v) DM_DUMP_RECURSIVE(v, k, indent.."-") end)
		DMPrint(indent.."} "..name);
	end
end