SL = (SL or {});
SL.MeleeStats = (SL.MeleeStats or {});
SL.SpellStats = (SL.SpellStats or {});
SL.Verbose = (SL.Verbose or false);
SL.Debug = (SL.Debug or false);
SL_MaxShield = 0;
SL_ShieldLeft = 0;
SL_HasShield = false;

SLASH_SHIELDLEFT1 = "/shieldleft";
SLASH_SHIELDLEFT2 = "/sl";

eventlist = {
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES",
	"CHAT_MSG_COMBAT_PARTY_HITS",
	"CHAT_MSG_COMBAT_PARTY_MISSES",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE",
	"CHAT_MSG_SPELL_SELF_DAMAGE",
	"CHAT_MSG_SPELL_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",
	"CHAT_MSG_SPELL_AURA_GONE_SELF",
	"PLAYER_ENTERING_WORLD",
	"ADDON_LOADED",
	"PET_BAR_UPDATE",
	"LEARNED_SPELL_IN_TAB"
}

local function ShieldLeft_Debug(msg)
	if SL.Debug then
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00SL Debug: "..msg);
	end
end

local function ShieldLeft_Verbose(msg)
	if SL.Verbose then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00SL: "..msg);
	end
end

local function ShieldLeft_Msg(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00SL: "..msg);
end

local function ShieldLeft_Error(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cffff0000ERROR: " .. msg);
	UIErrorsFrame:AddMessage("!! " .. msg .. " !!", 1.0, 1.0, 0, 1, 3)
end

local function RegisterEvents(EventList)
	if not EventList then
		ShieldLeft_Error("eventlist is missing")
		return
	end
	for _,aktEvent in EventList do
		this:RegisterEvent(aktEvent)
	end
end

local function UnregisterEvents(EventList)
	if not EventList then
		ShieldLeft_Error("eventlist is missing")
		return
	end
	for _,aktEvent in EventList do
		this:UnregisterEvent(aktEvent)
	end
end

local function CheckShieldSpells()
	ShieldLeft_Verbose(SL_MSG_CHECKINGSPELLS);
	local i = 1
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		end
		if spellName == SL_SHIELD then
			ShieldLeft_Verbose("found " .. spellName .. '(' .. spellRank .. ')' )
			ShieldLeftTooltip:SetSpell(i, BOOKTYPE_SPELL);
			local _, _, dmg = string.find(ShieldLeftTooltipTextLeft4:GetText(), SL_ABSORBING);
			ShieldLeft_Debug(ShieldLeftTooltipTextLeft4:GetText())
			if ( dmg ) then
				ShieldLeft_Debug(dmg)
				if SL_MaxShield < tonumber(dmg) then
					SL_MaxShield = tonumber(dmg);
					ShieldLeft_Verbose(SL_MSG_NEWMAXSHIELD .. SL_MaxShield);
				end
			end
		end
		i = i + 1
	end
	local i = 1
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_PET)
		if not spellName then
			do break end
		end
		if spellName == SL_SHIELD then
			ShieldLeft_Verbose( spellName .. '(' .. spellRank .. ')' )
			ShieldLeftTooltip:SetSpell(i, BOOKTYPE_PET);
			local _, _, dmg = string.find(ShieldLeftTooltipTextLeft4:GetText(), SL_ABSORBING);
			if ( dmg ) then
					
				if SL_MaxShield < tonumber(dmg) then
					SL_MaxShield = tonumber(dmg);
					ShieldLeft_Verbose(SL_MSG_NEWMAXSHIELD .. SL_MaxShield);
				end
			end
		end
   i = i + 1
	end
end

SlashCmdList["SHIELDLEFT"] = function(msg)
	if msg == "reset" then
		-- ShieldLeft_Reset()
	elseif msg == "info" then
		ShieldLeft_ShowInfo()
	elseif msg == "reset" then
	--
	elseif msg == "check" then
		CheckShieldSpells()
	elseif msg == "verbose" then
		SL.Verbose = not SL.Verbose;
		if SL.Verbose then
			ShieldLeft_Msg(SL_MSG_VERBOSEON)
		else
			ShieldLeft_Msg(SL_MSG_VERBOSEOFF)
		end
	elseif msg == "debug" then
		SL.Debug = not SL.Debug;
		if SL.Debug then
			ShieldLeft_Msg(SL_MSG_DEBUGON)
		else
			ShieldLeft_Msg(SL_MSG_DEBUGOFF)
		end
	else
		ShieldLeft_Msg(SL_MSG_HELP);
	end
end

function ShieldLeft_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(SL_MSG_CLICKTODRAG);
end

function ShieldLeft_OnLoad()
	RegisterEvents(eventlist)
	ShieldLeft_Verbose(SL_MSG_LOADED);
end

function ShieldLeft_ShowInfo()
	if SL.Verbose then
		ShieldLeft_Msg(SL_MSG_VERBOSEON)
	else
		ShieldLeft_Msg(SL_MSG_VERBOSEOFF)
	end
	ShieldLeft_Msg(SL_MSG_MAXSHIELD .. SL_MaxShield .. "\n");
	for aktUnit in SL.MeleeStats do
		ShieldLeft_Msg(aktUnit .. "(" .. SL.MeleeStats[aktUnit].med .. ")");
	end
	for aktUnit in SL.SpellStats do
		for aktSpell in SL.SpellStats[aktUnit] do
			ShieldLeft_Msg(aktUnit .. "'s " .. aktSpell .. "(" .. SL.SpellStats[aktUnit][aktSpell].med .. ")");
		end
	end
end

function ShieldLeft_Reset()
	SL.MeleeStats = {};
	SL.SpellStats = {};
	ShieldLeft_Msg(SL_MSG_STATSRESET);
end

-- this adds meelee damage to the database
function ShieldLeft_AddDamage(unit, dmg)
	if ( not SL.MeleeStats[unit] ) then
		SL.MeleeStats[unit] = { ["hits"] = 1, ["dmg"] = dmg, ["med"] = dmg };
		ShieldLeft_Verbose(SL_MSG_NEWCRITTER .. unit .. "(" .. dmg .. ")");
	else
		SL.MeleeStats[unit].hits = SL.MeleeStats[unit].hits + 1;
		SL.MeleeStats[unit].dmg = SL.MeleeStats[unit].dmg + dmg;
		local oldmed = (SL.MeleeStats[unit].med or 0);
		SL.MeleeStats[unit].med = ceil(SL.MeleeStats[unit].dmg / SL.MeleeStats[unit].hits);
		if abs(SL.MeleeStats[unit].med - oldmed) > 0 then
			ShieldLeft_Verbose(unit .. ": " .. SL.MeleeStats[unit].med);
		end
	end
end

-- this adds spell/ranged damage to the database
function ShieldLeft_AddSpellDamage(unit, spell, dmg)
	if ( not SL.SpellStats[unit] ) then
		SL.SpellStats[unit] = { 
			[spell] = {
				["hits"] = 1, ["dmg"] = dmg, ["med"] = dmg
			}
		};
		ShieldLeft_Verbose(SL_MSG_NEWCRITTER .. unit);
	elseif ( not SL.SpellStats[unit][spell] ) then
		SL.SpellStats[unit][spell] = { 
			["hits"] = 1, ["dmg"] = dmg, ["med"] = dmg
		};
		ShieldLeft_Verbose(SL_MSG_NEWSPELLFOR .. unit .. ": " .. spell);
	else
		SL.SpellStats[unit][spell].hits = SL.SpellStats[unit][spell].hits + 1;
		SL.SpellStats[unit][spell].dmg = SL.SpellStats[unit][spell].dmg + dmg;
		local oldmed = (SL.SpellStats[unit][spell].med or 0);
		SL.SpellStats[unit][spell].med = ceil(SL.SpellStats[unit][spell].dmg / SL.SpellStats[unit][spell].hits);
		if abs(SL.SpellStats[unit][spell].med - oldmed) > 0 then
			ShieldLeft_Verbose(unit .. "'s " .. spell .. ": " .. SL.SpellStats[unit][spell].med);
		end
	end
end

-- this subtracts the damagage the shield has absorbed from the "shield left" counter
function ShieldLeft_AbsorbShield(unit, spell)
	if ( not SL_HasShield ) then 
		return; 
	end
	local recognized;
	if ( spell ) then
		if ( SL.SpellStats[unit] and SL.SpellStats[unit][spell] ) then
			SL_ShieldLeft = SL_ShieldLeft - SL.SpellStats[unit][spell].med;
			recognized = true;
		end
	else
		if ( SL.MeleeStats[unit] ) then
			SL_ShieldLeft = SL_ShieldLeft - (SL.MeleeStats[unit].med or 0);
			recognized = true;
		end
	end
	if ( SL_ShieldLeft < 0 ) then
		SL_ShieldLeft = 0;
	end
	ShieldLeftFrameText:SetText(SL_MSG_SHIELDLEFT .. SL_ShieldLeft .. "|r");
	ShieldLeftFrame:SetWidth(ShieldLeftFrameText:GetWidth()+10);
	ShieldLeftFrame:SetHeight(ShieldLeftFrameText:GetHeight()+15);

	if ( not recognized ) then
		ShieldLeftFrame.recognized = nil;
		ShieldLeftFrame:SetBackdropColor(1, 0, 0, 0.5);
	elseif ( ShieldLeftFrame.recognized ) then
		ShieldLeftFrame.recognized = 1;
		ShieldLeftFrame:SetBackdropColor(0, 0, 1, 0.5);
	end
end

function ShieldLeft_OnEvent(event)
	local _,playerclass = UnitClass("player");
	ShieldLeft_Debug("EVENT: " .. event);
  if event == "PLAYER_ENTERING_WORLD" then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		if playerclass == "PRIEST" then
			ShieldLeft_Debug("adjusting for Priest");
			SL_SHIELD = SL_SHIELD_PRIEST;
			SL_ABSORBING = SL_ABSORBING_PRIEST;
			SL_YOUGAINSHIELD = SL_YOUGAINSHIELD_PRIEST;
			SL_YOULOOSESHIELD = SL_YOULOOSESHIELD_PRIEST;
		elseif playerclass == "WARLOCK" then
			ShieldLeft_Debug("adjusting for Warlock");
			SL_SHIELD = SL_SHIELD_WARLOCK
			SL_ABSORBING = SL_ABSORBING_WARLOCK
			SL_YOUGAINSHIELD = SL_YOUGAINSHIELD_WARLOCK;
			SL_YOULOOSESHIELD = SL_YOULOOSESHIELD_WARLOCK;
		elseif playerclass == "MAGE" then
			ShieldLeft_Debug("adjusting for Mage");
			SL_SHIELD = SL_SHIELD_MAGE
			SL_ABSORBING = SL_ABSORBING_MAGE
			SL_YOUGAINSHIELD = SL_YOUGAINSHIELD_MAGE
			SL_YOULOOSESHIELD = SL_YOULOOSESHIELD_MAGE
		else
			UnregisterEvents(eventlist)
			return;
		end
		CheckShieldSpells()
	elseif event == "ADDON_LOADED" then
		this:UnregisterEvent("ADDON_LOADED")
		local MyAddonDetails = 
		{
			name = SL_MODNAME,
      version = SL_VERSION,
			releaseDate = SL_RELEASEDATE,
      category = MYADDONS_CATEGORY_COMBAT,
			author = "VincentGdG",
			email = "h40izsq02@sneakemail.com",
			website = "http://wow.g-d-g.de"
		}
		local MyAddonHelp = {};
		MyAddonHelp[1] = SL_MSG_HELP;
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(MyAddonDetails,MyAddonHelp);
		end
	elseif event == "PET_BAR_UPDATE" or event == "LEARNED_SPELL_IN_TAB" then
		CheckShieldSpells();
	elseif ( event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" or event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" or event == "CHAT_MSG_COMBAT_PARTY_HITS" or event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES" or event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES" or event == "CHAT_MSG_COMBAT_PARTY_MISSES" ) then
		local _, _, unit, dmg1, dmg2 = string.find(arg1, SL_HITSYOUABSORBED);
		--ShieldLeft_Debug("MELEE HIT");
		if ( unit and dmg1 and dmg2 ) then
			ShieldLeft_AddDamage(unit, tonumber(dmg1)+tonumber(dmg2));
			return;
		end
		local _, _, unit, dmg1, dmg2 = string.find(arg1, SL_CRITSYOUABSORBED);
		if ( unit and dmg1 and dmg2 ) then
			ShieldLeft_AddDamage(unit, tonumber(dmg1)+tonumber(dmg2));
			return;
		end

		local _, _, unit, dmg1, dmg2 = string.find(arg1, SL_HITSYOUBLOCKED);
		if ( unit and dmg1 and dmg2 ) then
			ShieldLeft_AddDamage(unit, tonumber(dmg1)+tonumber(dmg2));
			return;
		end
		local _, _, unit, dmg1, dmg2 = string.find(arg1, SL_CRITSYOUBLOCKED);
		if ( unit and dmg1 and dmg2 ) then
			ShieldLeft_AddDamage(unit, tonumber(dmg1)+tonumber(dmg2));
			return;
		end

		local _, _, unit, dmg = string.find(arg1, SL_HITSYOUFOR)
		if ( unit and dmg ) then
			ShieldLeft_AddDamage(unit, tonumber(dmg));
			return;
		end
		local _, _, unit, dmg = string.find(arg1, SL_CRITSYOUFOR);
		if ( unit and dmg ) then
			ShieldLeft_AddDamage(unit, tonumber(dmg));
			return;
		end
		local _, _, unit = string.find(arg1,SL_ABSORBALL);
		if ( unit ) then
			ShieldLeft_AbsorbShield(unit);
			return;
		end

	elseif ( event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" or event == "CHAT_MSG_SPELL_PARTY_DAMAGE" or event == "CHAT_MSG_SPELL_SELF_DAMAGE" ) then
		--ShieldLeft_Debug("RANGED HIT");
		local _, _, unit, spell, dmg1, dmg2 = string.find(arg1, SL_RANGED_HITSYOUABSORBED);
		if ( unit and spell and dmg1 and dmg2 ) then
			ShieldLeft_AddSpellDamage(unit, spell, tonumber(dmg1)+tonumber(dmg2));
			return;
		end

		local _, _, unit, spell, dmg1, dmg2 = string.find(arg1, SL_RANGED_CRITSYOUABSORBED);
		if ( unit and spell and dmg1 and dmg2 ) then
			ShieldLeft_AddSpellDamage(unit, spell, tonumber(dmg1)+tonumber(dmg2));
			return;
		end

		local _, _, unit, spell, dmg = string.find(arg1, SL_RANGED_HITSYOU);
		if ( unit and spell and dmg ) then
			ShieldLeft_AddSpellDamage(unit, spell, tonumber(dmg));
			return;
		end

		-- this only seems to be different from the other one in German, for shooting.
		local _, _, unit, spell, dmg = string.find(arg1, SL_RANGED_HITSYOU2);
		if ( unit and spell and dmg ) then
			ShieldLeft_AddSpellDamage(unit, spell, tonumber(dmg));
			return;
		end

		local _, _, unit, spell, dmg = string.find(arg1, SL_RANGED_CRITSYOU);
		if ( unit and spell and dmg ) then
			ShieldLeft_AddSpellDamage(unit, spell, tonumber(dmg));
			return;
		end

		local _, _, unit, spell = string.find(arg1, SL_RANGED_YOUABSORB);
		if ( unit and spell ) then
			ShieldLeft_AbsorbShield(unit, spell);
			return;
		end

		local _, _, spell, dmg = string.find(arg1, SL_YOURHITSYOU);
		if ( spell and dmg) then
			ShieldLeft_AddSpellDamage("GenericUnit", spell, tonumber(dmg));
			return;
		end

		local _, _, spell = string.find(arg1, SL_YOUABSORBYOUR);
		if ( spell ) then
			ShieldLeft_AbsorbShield("GenericUnit", spell);
			return;
		end

	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE" ) then
		local _, _, dmg, unit, spell = string.find(arg1, SL_YOUSUFFER);
		if ( unit and spell and dmg ) then
			ShieldLeft_AddSpellDamage(unit, spell, tonumber(dmg));
			return;
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" or event == "CHAT_MSG_SPELL_AURA_GONE_SELF" ) then
		if ( arg1 == SL_YOUGAINSHIELD ) then
			SL_HasShield = true;
			SL_ShieldLeft = SL_MaxShield;
			ShieldLeftFrame:Show();
		elseif ( arg1 == SL_YOULOOSESHIELD ) then
			SL_HasShield = false;
			SL_ShieldLeft = 0;
			ShieldLeftFrame:Hide();
		end
		return;
	end
end
