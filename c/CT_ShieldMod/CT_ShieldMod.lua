CT_ShieldMod_ShieldDamageLeft = 0;
CT_ShieldMod_MeleeStats = { };
CT_ShieldMod_SpellStats = { };
CT_ShieldMod_Version = "B1.0";
CT_ShieldMod_SaveStatus = "off";

SLASH_SHIELDMOD1 = "/shieldmod";
SLASH_SHIELDMOD2 = "/sm";

SlashCmdList["SHIELDMOD"] = function(msg)
	if ( msg == "save on" ) then
		CT_ShieldMod_SaveStatus = "on";
		if ( CT_Mods and CT_Mods[CT_SHIELDMOD_MODNAME] ) then
			CT_Mods[CT_SHIELDMOD_MODNAME]["modStatus"] = "on";
		end
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> Shield Mod is now saving data over sessions.", 1, 1, 0);
	elseif ( msg == "save off" ) then
		CT_ShieldMod_SaveStatus = "off";
		if ( CT_Mods and CT_Mods[CT_SHIELDMOD_MODNAME] ) then
			CT_Mods[CT_SHIELDMOD_MODNAME]["modStatus"] = "off";
		end
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> Shield Mod is no longer saving data over sessions.", 1, 1, 0);
	else
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> You can use the following slash commands to control Shield Mod:", 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> |c00FFFFFF/shieldmod save on|r - Saves stats over sessions.", 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> |c00FFFFFF/shieldmod save off|r - Stops saving stats over sessions.", 1, 1, 0);
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> Note that you can also use |c00FFFFFF/sm|r.", 1, 1, 0);
	end
end

if ( CT_AddMovable ) then
	CT_AddMovable("CT_ShieldFrame", CT_SHIELDMOD_MOVABLE, "RIGHT", "LEFT", "Minimap", -14, 0);
end

function CT_ShieldMod_OnEnter()
	if ( not CT_RegisterMod or CT_MF_ShowFrames ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText("Click to drag");
	end
end

function CT_ShieldMod_ModOnClick(modId)
	SlashCmdList["SHIELDMOD"]("save " .. CT_Mods[modId]["modStatus"]);
end

function CT_ShieldMod_OnLoad()
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_PARTY_MISSES");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES");

	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE");

	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	this:RegisterEvent("VARIABLES_LOADED");
	if ( not CT_RegisterMod ) then
		DEFAULT_CHAT_FRAME:AddMessage("<CTMod> Shield Mod " .. CT_ShieldMod_Version .. " loaded. Write /shieldmod for more info.", 1, 1, 0);
	else
		CT_RegisterMod(CT_SHIELDMOD_MODNAME, CT_SHIELDMOD_SUBNAME, 4, "Interface\\Icons\\Spell_Holy_PowerWordShield", CT_SHIELDMOD_TOOLTIP, "off", nil, CT_ShieldMod_ModOnClick);
	end
end

function CT_ShieldMod_AddDamage(unit, dmg)
	if ( not CT_ShieldMod_MeleeStats[unit] ) then
		CT_ShieldMod_MeleeStats[unit] = { ["hits"] = 1, ["dmg"] = dmg };
	else
		CT_ShieldMod_MeleeStats[unit].hits = CT_ShieldMod_MeleeStats[unit].hits + 1;
		CT_ShieldMod_MeleeStats[unit].dmg = CT_ShieldMod_MeleeStats[unit].dmg + dmg;
	end
end

function CT_ShieldMod_AbsorbShield(unit, spell)
	if ( not CT_ShieldMod_HasShield ) then return; end
	local recognized;
	if ( spell ) then
		if ( CT_ShieldMod_SpellStats[unit] and CT_ShieldMod_SpellStats[unit][spell] ) then
			CT_ShieldMod_ShieldDamageLeft = CT_ShieldMod_ShieldDamageLeft - floor(CT_ShieldMod_SpellStats[unit][spell].dmg / CT_ShieldMod_SpellStats[unit][spell].hits+0.5);
			recognized = true;
		end
	else
		if ( CT_ShieldMod_MeleeStats[unit] ) then
			CT_ShieldMod_ShieldDamageLeft = CT_ShieldMod_ShieldDamageLeft - floor(CT_ShieldMod_MeleeStats[unit].dmg / CT_ShieldMod_MeleeStats[unit].hits+0.5);
			recognized = true;
		end
	end
	if ( CT_ShieldMod_ShieldDamageLeft < 0 ) then
		CT_ShieldMod_ShieldDamageLeft = 0;
	end
	CT_ShieldFrameText:SetText("Damage Left: |c00FFFFFF" .. CT_ShieldMod_ShieldDamageLeft .. "|r");
	CT_ShieldFrame:SetWidth(CT_ShieldFrameText:GetWidth()+10);
	CT_ShieldFrame:SetHeight(CT_ShieldFrameText:GetHeight()+15);

	if ( not recognized ) then
		CT_ShieldFrame.recognized = nil;
		CT_ShieldFrame:SetBackdropColor(1, 0, 0, 0.5);
	elseif ( CT_ShieldFrame.recognized ) then
		CT_ShieldFrame.recognized = 1;
		CT_ShieldFrame:SetBackdropColor(0, 0, 1, 0.5);
	end
end

function CT_ShieldMod_AddSpellDamage(unit, spell, dmg)
	if ( not CT_ShieldMod_SpellStats[unit] ) then
		CT_ShieldMod_SpellStats[unit] = { 
			[spell] = {
				["hits"] = 1, ["dmg"] = dmg
			}
		};
	elseif ( not CT_ShieldMod_SpellStats[unit][spell] ) then
		CT_ShieldMod_SpellStats[unit][spell] = { 
			["hits"] = 1, ["dmg"] = dmg
		};
	else
		CT_ShieldMod_SpellStats[unit][spell].hits = CT_ShieldMod_SpellStats[unit][spell].hits + 1;
		CT_ShieldMod_SpellStats[unit][spell].dmg = CT_ShieldMod_SpellStats[unit][spell].dmg + dmg;
	end
end

function CT_ShieldMod_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		if ( CT_ShieldMod_SaveStatus == "off" ) then
			CT_ShieldMod_SpellStats = { };
			CT_ShieldMod_MeleeStats = { };
		end
	elseif ( UnitClass("player") ~= "Priest" ) then
		return;
	elseif ( event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" or event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" or event == "CHAT_MSG_COMBAT_PARTY_HITS" or event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES" or event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES" or event == "CHAT_MSG_COMBAT_PARTY_MISSES" ) then
		local _, _, unit, dmg1, dmg2 = string.find(arg1, "(.+) hits you for (%d+) %((%+) absorbed%)%.");
		if ( unit and dmg1 and dmg2 ) then
			CT_ShieldMod_AddDamage(unit, tonumber(dmg1)+tonumber(dmg2));
			return;
		end
		local _, _, unit, dmg1, dmg2 = string.find(arg1, "(.+) crits you for (%d+) %((%+) absorbed%)%.");
		if ( unit and dmg1 and dmg2 ) then
			CT_ShieldMod_AddDamage(unit, tonumber(dmg1)+tonumber(dmg2));
			return;
		end

		local _, _, unit, dmg1, dmg2 = string.find(arg1, "(.+) hits you for (%d+)%. %((%+) blocked%)");
		if ( unit and dmg1 and dmg2 ) then
			CT_ShieldMod_AddDamage(unit, tonumber(dmg1)+tonumber(dmg2));
			return;
		end
		local _, _, unit, dmg1, dmg2 = string.find(arg1, "(.+) crits you for (%d+)%. %((%+) blocked%)");
		if ( unit and dmg1 and dmg2 ) then
			CT_ShieldMod_AddDamage(unit, tonumber(dmg1)+tonumber(dmg2));
			return;
		end

		local _, _, unit, dmg = string.find(arg1, "(.+) hits you for (%d+)%.")
		if ( unit and dmg ) then
			CT_ShieldMod_AddDamage(unit, tonumber(dmg));
			return;
		end
		local _, _, unit, dmg = string.find(arg1, "(.+) crits you for (%d+)%.");
		if ( unit and dmg ) then
			CT_ShieldMod_AddDamage(unit, tonumber(dmg));
			return;
		end
		local _, _, unit = string.find(arg1, "(.+) attacks%. You absorb all the damage%.");
		if ( unit ) then
			CT_ShieldMod_AbsorbShield(unit);
			return;
		end

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_SELF_DAMAGE" ) then

		local _, _, unit, spell, dmg1, dmg2 = string.find(arg1, "(.+)'s (.+) hits you for (%d+) %((%d+) absorbed%)%.");
		if ( unit and spell and dmg1 and dmg2 ) then
			CT_ShieldMod_AddSpellDamage(unit, spell, tonumber(dmg1)+tonumber(dmg2));
			return;
		end

		local _, _, unit, spell, dmg1, dmg2 = string.find(arg1, "(.+)'s (.+) crits you for (%d+) %((%d+) absorbed%)%.");
		if ( unit and spell and dmg1 and dmg2 ) then
			CT_ShieldMod_AddSpellDamage(unit, spell, tonumber(dmg1)+tonumber(dmg2));
			return;
		end

		local _, _, unit, spell, dmg = string.find(arg1, "(.+)'s (.+) hits you for (%d+)%.");
		if ( unit and spell and dmg ) then
			CT_ShieldMod_AddSpellDamage(unit, spell, tonumber(dmg));
			return;
		end

		local _, _, unit, spell, dmg = string.find(arg1, "(.+)'s (.+) crits you for (%d+)%.");
		if ( unit and spell and dmg ) then
			CT_ShieldMod_AddSpellDamage(unit, spell, tonumber(dmg));
			return;
		end

		local _, _, unit, spell = string.find(arg1, "You absorb (.+)'s (.+)%.");
		if ( unit and spell ) then
			CT_ShieldMod_AbsorbShield(unit, spell);
			return;
		end

		local _, _, spell, dmg = string.find(arg1, "Your (.+) hits you for (%d+)%.");
		if ( spell and dmg) then
			CT_ShieldMod_AddSpellDamage("GenericUnit", spell, tonumber(dmg));
			return;
		end

		local _, _, spell = string.find(arg1, "You absorb your (.+)%.");
		if ( spell ) then
			CT_ShieldMod_AbsorbShield("GenericUnit", spell);
			return;
		end

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		local _, _, dmg, unit, spell = string.find(arg1, "You suffer (%d+) .+ from (.+)'s (.+)%.");
		if ( unit and spell and dmg ) then
			CT_ShieldMod_AddSpellDamage(unit, spell, tonumber(dmg));
			return;
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" or event == "CHAT_MSG_SPELL_AURA_GONE_SELF" ) then
		if ( arg1 == "You gain Power Word: Shield." ) then
			CT_ShieldMod_HasShield = 1;
			CT_ShieldFrame:Show();
		elseif ( arg1 == "Power Word: Shield fades from you." ) then
			CT_ShieldMod_HasShield = nil;
			CT_ShieldFrame:Hide();
		end
		return;
	end
		
end

CT_ShieldMod_oldUA = UseAction;
function CT_ShieldMod_newUA(id, cursor, self)
	CT_ShieldMod_oldUA(id, cursor, self);
	CT_ShieldMod_ScanTooltip(id);
end
UseAction = CT_ShieldMod_newUA;

CT_ShieldMod_oldCS = CastSpell;
function CT_ShieldMod_newCS(id, tab)
	CT_ShieldMod_oldCS(id, tab);
	CT_ShieldMod_ScanTooltip(id, 1, tab);
end
CastSpell = CT_ShieldMod_newCS;


function CT_ShieldMod_ScanTooltip(id, useSpell, spellTab)
	CT_ShieldModTooltipTextLeft1:SetText("");
	local oldVar = GetCVar("UberTooltips");
	SetCVar("UberTooltips", 1);
	if ( useSpell ) then
		CT_ShieldModTooltip:SetSpell(id, spellTab);
	else
		CT_ShieldModTooltip:SetAction(id);
	end
	SetCVar("UberTooltips", oldVar);
	if ( CT_ShieldModTooltipTextLeft1:GetText() ~= "Power Word: Shield" ) then
		return;
	end
	for i = 1, CT_ShieldModTooltip:NumLines(), 1 do
		local left = getglobal("CT_ShieldModTooltipTextLeft" .. i);
		if ( left and left:GetText() ) then
			local _, _, dmg = string.find(left:GetText(), "absorbing (%d+) damage");
			if ( dmg ) then
				CT_ShieldMod_ShieldDamageLeft = tonumber(dmg);
				return;
			end
		end
		local right = getglobal("CT_ShieldModTooltipTextRight" .. i);
		if ( right and right:GetText() ) then
			local _, _, dmg = string.find(right:GetText(), "absorbing (%d+) damage");
			if ( dmg ) then
				CT_ShieldMod_ShieldDamageLeft = tonumber(dmg);
				return;
			end
		end
	end
end
