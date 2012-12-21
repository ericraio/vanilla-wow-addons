--[[
Spell Alert
        Author:         Awen
	Modified by:    Mithryn
        Thanks:		Quu (Code contribution)
                        Cyron (German Translation)
			Awen (Original Code)

]]


SAConfig = { };
SAConfig.color = { };
SAConfig.on = 1;
SAConfig.emote_on = 1;
SAConfig.retarget_on = 1;
SAConfig.targetonly = 1;
SAConfig.heals = 1;
SAConfig.cc = 1;
SAConfig.dispelable = 1;
SAConfig.damage = 1;
SAConfig.misc = 1;
SAConfig.pos = 20;
SAConfig.shadow = 0;
SAConfig.zoom = 37;
SAConfig.color.at = {r=1,g=0,b=0};
SAConfig.color.he = {r=1,g=1,b=0};
SAConfig.color.bu = {r=0,g=1,b=0};
SAConfig.color.em = {r=1,g=0.6,b=0};
SAConfig.color.to = {r=0.5,g=0.5,b=0.5};
SAConfig.radio = 1;
SAConfig.drag = 5;
SAConfig.holdTime = 1;
SAConfig.livingBomb = 1;

local kind = 0;
local sa_gains = { };
local sa_color_prev = {r=1,g=1,b=1};
local fadeInTime = 0.1;
local fadeOutTime = 0.4;
local startTime = 0;
local cType = 0;	-- 0 = damage, 1 = heal, 2 = buff, 3 = emote, 4 = totem
local shadow;
local getX, getY;
local change = 0;
local changed = false;

local sa_options = 0;

function SpellAlert_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");

	SlashCmdList["SpellAlertCOMMAND"] = SpellAlertHandler;
	SLASH_SpellAlertCOMMAND1 = "/spellalert";
	DEFAULT_CHAT_FRAME:AddMessage("SpellAlert by Awen. Type /spellalert for options.");
	DEFAULT_CHAT_FRAME:AddMessage("SpellAlert was modified by Mithryn.");

end

function SpellAlert_OnEvent()
	if (SAConfig.on == 0) then
		return;
	end
	
	if (event == "VARIABLES_LOADED") then

		if (not SAConfig) then
			SAConfig = {};
	
			SAConfig.on = 1;
			SAConfig.emote_on = 1;
			SAConfig.retarget_on = 1;
			SAConfig.targetonly = 1;
			SAConfig.heals = 1;
			SAConfig.cc = 1;
			SAConfig.dispelable = 1;
			SAConfig.damage = 1;
			SAConfig.misc = 1;
			SAConfig.pos = 20;
			SAConfig.shadow = 0;
			SAConfig.zoom = 37;
			SAConfig.radio = 1;
			SAConfig.version = 1.5;
			SAConfig.shadow = 0;
			SAConfig.drag = 5;
			SAConfig.version = 1.6;
			SAConfig.holdTime = 1;
			SAConfig.livingBomb = 1;

			SAConfig.color = {};
			SAConfig.color.at = {r=1,g=0,b=0};
			SAConfig.color.he = {r=1,g=1,b=0};
			SAConfig.color.bu = {r=0,g=1,b=0};
			SAConfig.color.em = {r=1,g=0.6,b=0};
			SAConfig.color.to = {r=0.5,g=0.5,b=0.5};
			DEFAULT_CHAT_FRAME:AddMessage("SpellAlert: Setting Options to Default");

		elseif (not SAConfig.color) then
			SAConfig.color = {};
			SAConfig.color.at = {r=1,g=0,b=0};
			SAConfig.color.he = {r=1,g=1,b=0};
			SAConfig.color.bu = {r=0,g=1,b=0};
			SAConfig.color.em = {r=1,g=0.6,b=0};
			SAConfig.color.to = {r=0.5,g=0.5,b=0.5};
			DEFAULT_CHAT_FRAME:AddMessage("SpellAlert: Setting Options to Default");

		elseif (not SAConfig.radio) then
			SAConfig.radio = 1;
			DEFAULT_CHAT_FRAME:AddMessage("SpellAlert: Setting Options to Default");

		elseif (not SAConfig.version or not SAConfig.version == 1.5) then
			SAConfig.version = 1.5;
			SAConfig.shadow = 0;
			SAConfig.drag = 5;
			DEFAULT_CHAT_FRAME:AddMessage("Updated SpellAlert to 1.5");

		elseif (not SAConfig.version or not SAConfig.version == 1.6) then
			SAConfig.version = 1.6;
			SAConfig.holdTime = 1;
			SAConfig.livingBomb = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Updated SpellAlert to 1.6");

		end
		
		if(SAConfig.shadow == 0) then
			shadow = "";
		elseif (SAConfig.shadow == 1) then
			shadow = "OUTLINE";
		elseif (SAConfig.shadow == 2) then
			shadow = "THICKOUTLINE";
		end		

		AlertFrameText:SetTextColor(1, 1, 1);
		SpellAlert_Toggle();
		AlertFrameText:SetFont("Fonts\\FRIZQT__.TTF", SAConfig.zoom, shadow);
		AlertFrameText:SetText("SpellAlert Loaded!");
		if(not SAConfig.holdTime) then
			SAConfig.holdTime = 1;
		end
		AlertFrame_Show()

	end

	local mob, spell;
	if (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_BEGIN_CAST) do
			if (not SpellAlert_isParty(mob)) then
				cType = 0;
				if (SAConfig.radio == 1) then
					SpellAlert_alert(mob, spell, arg1);
				elseif (SAConfig.radio == 2) then
					SpellAlert_alert(mob, spell, mob.." begins to cast |cffffffff"..spell.."|r.");
				else
					SpellAlert_alert(mob, spell, "|cffffffff"..mob.." beings to cast |r"..spell..".");
				end				
			end
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF") then
		for mob, spell, k in string.gfind(arg1, SA_PTN_SPELL_GAINS_X) do
			return;
		end
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_BEGIN_CAST) do
			if (not SpellAlert_isParty(mob)) then
				cType = 1;
				if (SAConfig.radio == 1) then
					SpellAlert_alert(mob, spell, arg1);
				elseif (SAConfig.radio == 2) then
					SpellAlert_alert(mob, spell, mob.." begins to cast |cffffffff"..spell.."|r.");
				else
					SpellAlert_alert(mob, spell, "|cffffffff"..mob.." beings to cast |r"..spell..".");
				end				
			end
			return;
		end
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_TOTEM) do
			if (not SpellAlert_isParty(mob)) then
				cType = 4;
				if (SAConfig.radio == 1) then
					SpellAlert_alert(mob, spell, arg1);
				elseif (SAConfig.radio == 2) then
					SpellAlert_alert(mob, spell, mob.." casts |cffffffff"..spell.."|r Totem.");
				else
					SpellAlert_alert(mob, spell, "|cffffffff"..mob.." casts |r"..spell.." Totem.");
				end				
			end
			return;
		end
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_GAINS) do
			cType = 2;
			if (SAConfig.radio == 1) then
				SpellAlert_alert(mob, spell, arg1);
			elseif (SAConfig.radio == 2) then
				SpellAlert_alert(mob, spell, mob.." gains |cffffffff"..spell.."|r.");
			else
				SpellAlert_alert(mob, spell, "|cffffffff"..mob.." gains |r"..spell..".");
			end				
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_BUFF") then
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_BEGIN_CAST) do
			cType = 1;
			if (SAConfig.radio == 1) then
				SpellAlert_alert(mob, spell, arg1);
			elseif (SAConfig.radio == 2) then
				SpellAlert_alert(mob, spell, mob.." begins to cast |cffffffff"..spell.."|r.");
			else
				SpellAlert_alert(mob, spell, "|cffffffff"..mob.." begins to cast |r"..spell..".");
			end				
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS") then
		for mob, spell, k in string.gfind(arg1, SA_PTN_SPELL_GAINS_X) do
			return;
		end
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_GAINS) do
			cType = 2;
			if (SAConfig.radio == 1) then
				SpellAlert_alert(mob, spell, arg1);
			elseif (SAConfig.radio == 2) then
				SpellAlert_alert(mob, spell, mob.." gains |cffffffff"..spell.."|r.");
			else
				SpellAlert_alert(mob, spell, "|cffffffff"..mob.." gains |r"..spell..".");
			end				
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_BEGIN_CAST) do
			cType = 0;
			if (SAConfig.radio == 1) then
				SpellAlert_alert(mob, spell, arg1);
			elseif (SAConfig.radio == 2) then
				SpellAlert_alert(mob, spell, mob.." begins to cast |cffffffff"..spell.."|r.");
			else
				SpellAlert_alert(mob, spell, "|cffffffff"..mob.." begins to cast |r"..spell..".");
			end				
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS") then
		for mob, spell, temp in string.gfind(arg1, SA_PTN_SPELL_GAINS_X) do
			return;
		end
		for mob, spell in string.gfind(arg1, SA_PTN_SPELL_GAINS) do
			if ( (spell == SA_WOTF) or
			     (spell == SA_BERSERKER_RAGE) ) then
				sa_gains[mob] = {};
				sa_gains[mob].spell = spell;
				sa_gains[mob].time = GetTime();
			end
			cType = 2;
			if (SAConfig.radio == 1) then
				SpellAlert_alert(mob, spell, arg1);
			elseif (SAConfig.radio == 2) then
				SpellAlert_alert(mob, spell, mob.." gains |cffffffff"..spell.."|r.");
			else
				SpellAlert_alert(mob, spell, "|cffffffff"..mob.." gains |r"..spell..".");
			end				
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then
		for spell, mob in string.gfind(arg1, SA_PTN_SPELL_FADE) do
			if ( (spell == SA_WOTF) or
			     (spell == SA_BERSERKER_RAGE) ) then
				local tt = sa_gains[mob];
				if (tt) then
					if (tt.spell == spell) then
						if (GetTime() - tt.time <= 30) then
							cType = 2;
							if (SAConfig.radio == 1) then
								SpellAlert_alert(mob, spell, arg1);
							elseif (SAConfig.radio == 2) then
								SpellAlert_alert(mob, spell, "|cffffffff"..spell.."|r gains "..mob..".");
							else
								SpellAlert_alert(mob, spell, spell.."|cffffffff fades from "..mob..".");
							end				
						end
					end
					tt[mob] = nil;
					return;
				end
			end
		end           
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") then
		if (arg1 == SA_AFFLICT_LIVINGBOMB) then
			if (SAConfig.livingBomb == 1) then
				AlertFrameText:SetText("YOU ARE THE LIVING BOMB!");
				AlertFrameText:SetTextColor(SAConfig.color.at.r,SAConfig.color.at.g,SAConfig.color.at.b);
				AlertFrame_Show();
			end
		end
		if (arg1 == SA_AFFLICT_SCATTERSHOT) then
			SpellAlert_retarget(SA_SCATTERSHOT);
		elseif (arg1 == SA_AFFLICT_FEAR) then
			SpellAlert_retarget(SA_FEAR);
		elseif (arg1 == SA_AFFLICT_INTIMIDATING_SHOUT) then
			SpellAlert_retarget(SA_INTIMIDATING_SHOUT);
		elseif (arg1 == SA_AFFLICT_PSYCHIC_SCREAM) then
			SpellAlert_retarget(SA_PSYCHIC_SCREAM);
		elseif (arg1 == SA_AFFLICT_PANIC) then
			SpellAlert_retarget(SA_PANIC);
		elseif (arg1 == SA_AFFLICT_BELLOWING_ROAR) then
			SpellAlert_retarget(SA_BELLOWING_ROAR);
		elseif (arg1 == SA_AFFLICT_ANCIENT_DESPAIR) then
			SpellAlert_retarget(SA_ANCIENT_DESPAIR);
		elseif (arg1 == SA_AFFLICT_ANCIENT_SCREECH) then
			SpellAlert_retarget(SA_SCREECH);
		elseif (arg1 == SA_AFFLICT_POLYMORPH) then
			SpellAlert_retarget(SA_POLYMORPH);
		elseif (arg1 == SA_AFFLICT_DEATHCOIL) then
			SpellAlert_retarget(SA_DEATHCOIL);
		end
	elseif (event == "CHAT_MSG_EMOTE") then
		if (arg1) then
			if (SAConfig.emote_on == 1) then
				cType = 3;
				SpellAlert_alert("", "", arg1);
			end
		end
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
		local name = arg2;
		if (not name) then
			name = "nil";
		end
		if (arg1) then
			if (SAConfig.emote_on == 1) then
				cType = 3;
--				AlertFrameText:SetTextColor(1,0.6,0);
				SpellAlert_alert(name, arg1, name .. " " .. arg1);
			end
		end
	end
end

function SpellAlert_setOptions()

	SAConfig.on = 1;
	SAConfig.emote_on = 1;
	SAConfig.retarget_on = 1;
	SAConfig.targetonly = 1;
	SAConfig.heals = 1;
	SAConfig.cc = 1;
	SAConfig.dispelable = 1;
	SAConfig.damage = 1;
	SAConfig.misc = 1;
	SAConfig.pos = 20;
	SAConfig.shadow = 0;
	SAConfig.zoom = 37;
	SAConfig.color.at = {r=1,g=0,b=0};
	SAConfig.color.he = {r=1,g=1,b=0};
	SAConfig.color.bu = {r=0,g=1,b=0};
	SAConfig.color.em = {r=1,g=0.6,b=0};
	SAConfig.color.to = {r=0.5,g=0.5,b=0.5};
	SAConfig.radio = 1;
	SAConfig.drag = 5;
	SAConfig.livingBomb = 1;
	SAConfig.holdTime = 1;

	SAOptionsEnable:SetChecked(SpellAlert_Int2Bool(SAConfig.on));
	SAOptionsEmote:SetChecked(SpellAlert_Int2Bool(SAConfig.emote_on));
	SAOptionsRetarget:SetChecked(SpellAlert_Int2Bool(SAConfig.retarget_on));
	SAOptionsTargetOnly:SetChecked(SpellAlert_Int2Bool(SAConfig.targetonly));
	SAOptionsHeals:SetChecked(SpellAlert_Int2Bool(SAConfig.heals));
	SAOptionsCC:SetChecked(SpellAlert_Int2Bool(SAConfig.cc));
	SAOptionsDispelable:SetChecked(SpellAlert_Int2Bool(SAConfig.dispelable));
	SAOptionsMisc:SetChecked(SpellAlert_Int2Bool(SAConfig.misc));
	SAOptionsDamage:SetChecked(SpellAlert_Int2Bool(SAConfig.damage));
	SASizeSlider:SetValue(SAConfig.zoom);
	SAPosSlider:SetValue(SAConfig.pos);
	SAShadowSlider:SetValue(SAConfig.shadow);
	boxColor = getglobal("SAat_NormalTexture");
	boxColor:SetVertexColor(SAConfig.color.at.r,SAConfig.color.at.g,SAConfig.color.at.b);
	boxColor = getglobal("SAhe_NormalTexture");
	boxColor:SetVertexColor(SAConfig.color.he.r,SAConfig.color.he.g,SAConfig.color.he.b);
	boxColor = getglobal("SAbu_NormalTexture");
	boxColor:SetVertexColor(SAConfig.color.bu.r,SAConfig.color.bu.g,SAConfig.color.bu.b);
	boxColor = getglobal("SAem_NormalTexture");
	boxColor:SetVertexColor(SAConfig.color.em.r,SAConfig.color.em.g,SAConfig.color.em.b);
	boxColor = getglobal("SAto_NormalTexture");
	boxColor:SetVertexColor(SAConfig.color.to.r,SAConfig.color.to.g,SAConfig.color.to.b);

	SAOptionsRadio1:SetChecked(0);
	SAOptionsRadio2:SetChecked(0);
	SAOptionsRadio3:SetChecked(0);
	SAOptionsRadioA:SetChecked(0);
	SAOptionsRadioB:SetChecked(0);

	SAOptionsRadioA:SetChecked(1);
	SADrag:SetMovable(false);
	SADrag:ClearAllPoints();
	SADrag:SetPoint("CENTER", "UIParent", "CENTER");
	SADrag:Hide();
	AlertFrame:ClearAllPoints();
	AlertFrame:SetPoint("TOP", 0, SAConfig.pos);

	sa_options = 1;
	AlertFrameText:SetAlpha(1);
	AlertFrameText:Show();
	AlertFrameText:SetTextColor(0.3,0.3,0.3);

	SAOptionsRadio1:SetChecked(1);
	AlertFrameText:SetText("<Enemy Name> begins casting <Spell>!");
	
end


function SpellAlertHandler(msg)

	SpellAlert_OptionsLoad();
	SAOptions:Show();

end

function SpellAlert_alert(mob, spell, msg)
	if (GetLocale()=="enUS") then
		if (SA_SPELLS_IGNORE[spell]) then
			return;
		end
		
		if (SAConfig.heals == 0) then
			if (SA_SPELLS_HEALS[spell] == 1) then
				return;
			end
		end
		
		if (SAConfig.cc == 0) then
			if (SA_SPELLS_CC[spell] == 1) then
				return;
			end
		end
		
		if (SAConfig.dispelable == 0) then
			if (SA_SPELLS_DISPELABLE[spell] == 1) then
				return;
			end
		end
		
		if (SAConfig.damage == 0) then
			if (SA_SPELLS_DAMAGE[spell] == 1) then
				return;
			end
		end
		
	end
	
	SpellAlert_banner(msg, mob);
end

function AlertFrame_Color()

	if (SA_SPELLS_HEALS[spell] == 1) then
		cType = 1;
--		AlertFrameText:SetTextColor(1,1,0);
	end

	if (SA_SPELLS_CC[spell] == 1) then
		cType = 0;
--		AlertFrameText:SetTextColor(1,0,1);		
	end

	if (SA_SPELLS_DISPELABLE[spell] == 1) then
		cType = 2;
--		AlertFrameText:SetTextColor(0,1,0);		
	end
	
	if (SA_SPELLS_DAMAGE[spell] == 1) then
		cType = 0;
--		AlertFrameText:SetTextColor(1,0,0);		
	end

	if (cType == 0) then
		AlertFrameText:SetTextColor(SAConfig.color.at.r,SAConfig.color.at.g,SAConfig.color.at.b);
	elseif (cType == 1) then
		AlertFrameText:SetTextColor(SAConfig.color.he.r,SAConfig.color.he.g,SAConfig.color.he.b);
	elseif (cType == 2) then
		AlertFrameText:SetTextColor(SAConfig.color.bu.r,SAConfig.color.bu.g,SAConfig.color.bu.b);
	elseif (cType == 3) then
		AlertFrameText:SetTextColor(SAConfig.color.em.r,SAConfig.color.em.g,SAConfig.color.em.b);
	elseif (cType == 4) then
		AlertFrameText:SetTextColor(SAConfig.color.to.r,SAConfig.color.to.g,SAConfig.color.to.b);
	end
			
end

function SpellAlert_banner(msg, mob)
	if (SAConfig.targetonly == 0) then
		AlertFrameText:SetText(msg);
		AlertFrame_Color();
		AlertFrame_Show();
	else
		local targetname = UnitName("target");
		if (mob == targetname) then
			AlertFrameText:SetText(msg);
			AlertFrame_Color();
			AlertFrame_Show();
		end
	end
end

function SpellAlert_isParty(name)
	for i = 1, 4, 1 do
		local partyname = UnitName("party" .. i);
		if (name == partyname) then
			return 1;
		end
	end
	return nil;
end

function SpellAlert_retarget(spell)
	if (SAConfig.retarget_on == 0) then
		return;
	end
	if (not UnitName("target")) then
		if (sa_targetName) then
			if (sa_targetHostile) then
				DEFAULT_CHAT_FRAME:AddMessage("SpellAlert is trying to retarget after " .. spell .. " : " .. sa_targetName);
				TargetLastEnemy();
			else
				DEFAULT_CHAT_FRAME:AddMessage("SpellAlert is trying to retarget after " .. spell .. " : " .. sa_targetName);
				TargetByName(sa_targetName);
			end
		end
	end
end

function SpellAlert_retargetHunter()
	if (SAConfig.retarget_on == 0) then
		return;
	end
	if (not UnitName("target")) then
		if (sa_targetName) then
			if (sa_targetHostile) then
				TargetByName(sa_targetName);
				if (UnitIsDeadOrGhost("target") and UnitCanAttack("player", "target")) then
					DEFAULT_CHAT_FRAME:AddMessage("SpellAlert is trying to retarget after Feign Death : " .. sa_targetName);
					TargetByName(sa_targetName);
				else
					ClearTarget();
					sa_targetHostile = nil;
					sa_targetName = nil;
				end
			end
		end
	end
end

function SpellAlert_OpenColorPicker(button, kinda)

	kind = kinda;

	if ( not button ) then
		button = this;
	end
	ColorPickerFrame.func = SpellAlert_SetColor;

	if (kind == 0) then
		sa_color_prev.r = SAConfig.color.at.r;
		sa_color_prev.g = SAConfig.color.at.g;
		sa_color_prev.b = SAConfig.color.at.b;
	elseif (kind == 1) then
		sa_color_prev.r = SAConfig.color.he.r;
		sa_color_prev.g = SAConfig.color.he.g;
		sa_color_prev.b = SAConfig.color.he.b;
	elseif (kind == 2) then
		sa_color_prev.r = SAConfig.color.bu.r;
		sa_color_prev.g = SAConfig.color.bu.g;
		sa_color_prev.b = SAConfig.color.bu.b;
	elseif (kind == 3) then
		sa_color_prev.r = SAConfig.color.em.r;
		sa_color_prev.g = SAConfig.color.em.g;
		sa_color_prev.b = SAConfig.color.em.b;
	elseif (kind == 4) then
		sa_color_prev.r = SAConfig.color.to.r;
		sa_color_prev.g = SAConfig.color.to.g;
		sa_color_prev.b = SAConfig.color.to.b;
	end
	
	ColorPickerFrame.cancelFunc = SpellAlert_CancelColor;
	if (kind == 0) then
		ColorPickerFrame:SetColorRGB(SAConfig.color.at.r, SAConfig.color.at.g, SAConfig.color.at.b);
	elseif (kind == 1) then
		ColorPickerFrame:SetColorRGB(SAConfig.color.he.r, SAConfig.color.he.g, SAConfig.color.he.b);
	elseif (kind == 2) then
		ColorPickerFrame:SetColorRGB(SAConfig.color.bu.r, SAConfig.color.bu.g, SAConfig.color.bu.b);
	elseif (kind == 3) then
		ColorPickerFrame:SetColorRGB(SAConfig.color.em.r, SAConfig.color.em.g, SAConfig.color.em.b);
	elseif (kind == 4) then
		ColorPickerFrame:SetColorRGB(SAConfig.color.to.r, SAConfig.color.to.g, SAConfig.color.to.b);
	end
	ColorPickerFrame:Show();
end

function SpellAlert_SetColor()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	local swatch,frame;
	if (kind == 0) then
		swatch = getglobal("SAat_NormalTexture");
		swatch:SetVertexColor(r,g,b);
		SAConfig.color.at.r = r;
		SAConfig.color.at.g = g;
		SAConfig.color.at.b = b;
		AlertFrameText:SetTextColor(SAConfig.color.at.r,SAConfig.color.at.g,SAConfig.color.at.b);
	elseif (kind == 1) then
		swatch = getglobal("SAhe_NormalTexture");
		swatch:SetVertexColor(r,g,b);
		SAConfig.color.he.r = r;
		SAConfig.color.he.g = g;
		SAConfig.color.he.b = b;
		AlertFrameText:SetTextColor(SAConfig.color.he.r,SAConfig.color.he.g,SAConfig.color.he.b);
	elseif (kind == 2) then
		swatch = getglobal("SAbu_NormalTexture");
		swatch:SetVertexColor(r,g,b);
		SAConfig.color.bu.r = r;
		SAConfig.color.bu.g = g;
		SAConfig.color.bu.b = b;
		AlertFrameText:SetTextColor(SAConfig.color.bu.r,SAConfig.color.bu.g,SAConfig.color.bu.b);
	elseif (kind == 3) then
		swatch = getglobal("SAem_NormalTexture");
		swatch:SetVertexColor(r,g,b);
		SAConfig.color.em.r = r;
		SAConfig.color.em.g = g;
		SAConfig.color.em.b = b;
		AlertFrameText:SetTextColor(SAConfig.color.em.r,SAConfig.color.em.g,SAConfig.color.em.b);
	elseif (kind == 4) then
		swatch = getglobal("SAto_NormalTexture");
		swatch:SetVertexColor(r,g,b);
		SAConfig.color.to.r = r;
		SAConfig.color.to.g = g;
		SAConfig.color.to.b = b;
		AlertFrameText:SetTextColor(SAConfig.color.to.r,SAConfig.color.to.g,SAConfig.color.to.b);
	end

end

function SpellAlert_CancelColor()
	if (kind == 0) then
		swatch = getglobal("SAat_NormalTexture");
		SAConfig.color.at.r = sa_color_prev.r;
		SAConfig.color.at.g = sa_color_prev.g;
		SAConfig.color.at.b = sa_color_prev.b;
		swatch:SetVertexColor(sa_color_prev.r, sa_color_prev.g, sa_color_prev.b);
	elseif (kind == 1) then
		swatch = getglobal("SAhe_NormalTexture");
		SAConfig.color.he.r = sa_color_prev.r;
		SAConfig.color.he.g = sa_color_prev.g;
		SAConfig.color.he.b = sa_color_prev.b;
		swatch:SetVertexColor(sa_color_prev.r, sa_color_prev.g, sa_color_prev.b);
	elseif (kind == 2) then
		swatch = getglobal("SAbu_NormalTexture");
		SAConfig.color.bu.r = sa_color_prev.r;
		SAConfig.color.bu.g = sa_color_prev.g;
		SAConfig.color.bu.b = sa_color_prev.b;
		swatch:SetVertexColor(sa_color_prev.r, sa_color_prev.g, sa_color_prev.b);
	elseif (kind == 3) then
		swatch = getglobal("SAem_NormalTexture");
		SAConfig.color.em.r = sa_color_prev.r;
		SAConfig.color.em.g = sa_color_prev.g;
		SAConfig.color.em.b = sa_color_prev.b;
		swatch:SetVertexColor(sa_color_prev.r, sa_color_prev.g, sa_color_prev.b);
	elseif (kind == 4) then
		swatch = getglobal("SAto_NormalTexture");
		SAConfig.color.to.r = sa_color_prev.r;
		SAConfig.color.to.g = sa_color_prev.g;
		SAConfig.color.to.b = sa_color_prev.b;
		swatch:SetVertexColor(sa_color_prev.r, sa_color_prev.g, sa_color_prev.b);
	end
	AlertFrameText:SetTextColor(0.3,0.3,0.3);
end

function SpellAlert_OptionsClose()
	SAConfig.on = SpellAlert_Bool2Int(SAOptionsEnable:GetChecked());
	SAConfig.emote_on = SpellAlert_Bool2Int(SAOptionsEmote:GetChecked());
	SAConfig.retarget_on = SpellAlert_Bool2Int(SAOptionsRetarget:GetChecked());
	SAConfig.targetonly = SpellAlert_Bool2Int(SAOptionsTargetOnly:GetChecked());
	SAConfig.heals = SpellAlert_Bool2Int(SAOptionsHeals:GetChecked());
	SAConfig.cc = SpellAlert_Bool2Int(SAOptionsCC:GetChecked());
	SAConfig.dispelable = SpellAlert_Bool2Int(SAOptionsDispelable:GetChecked());
	SAConfig.misc = SpellAlert_Bool2Int(SAOptionsMisc:GetChecked());
	SAConfig.damage = SpellAlert_Bool2Int(SAOptionsDamage:GetChecked());
	SAConfig.livingBomb = SpellAlert_Bool2Int(SAOptionsBomb:GetChecked());
	AlertFrameText:SetText(" ");
	sa_options = 0;
	SAOptions:Hide();
	AlertFrame:ClearAllPoints();
	getX = AlertFrame:GetLeft();
	getY = AlertFrame:GetTop();
	SADrag:Hide();
end

function SpellAlert_OptionsLoad()
	local boxColor;
	SAOptionsEnable:SetChecked(SpellAlert_Int2Bool(SAConfig.on));
	SAOptionsEmote:SetChecked(SpellAlert_Int2Bool(SAConfig.emote_on));
	SAOptionsRetarget:SetChecked(SpellAlert_Int2Bool(SAConfig.retarget_on));
	SAOptionsTargetOnly:SetChecked(SpellAlert_Int2Bool(SAConfig.targetonly));
	SAOptionsHeals:SetChecked(SpellAlert_Int2Bool(SAConfig.heals));
	SAOptionsCC:SetChecked(SpellAlert_Int2Bool(SAConfig.cc));
	SAOptionsDispelable:SetChecked(SpellAlert_Int2Bool(SAConfig.dispelable));
	SAOptionsMisc:SetChecked(SpellAlert_Int2Bool(SAConfig.misc));
	SAOptionsDamage:SetChecked(SpellAlert_Int2Bool(SAConfig.damage));
	SAOptionsBomb:SetChecked(SpellAlert_Int2Bool(SAConfig.livingBomb));
	SASizeSlider:SetValue(SAConfig.zoom);
	SAPosSlider:SetValue(SAConfig.pos);
	SAShadowSlider:SetValue(SAConfig.shadow);
	SADelaySlider:SetValue(SAConfig.holdTime);
	boxColor = getglobal("SAat_NormalTexture");
	boxColor:SetVertexColor(SAConfig.color.at.r,SAConfig.color.at.g,SAConfig.color.at.b);
	boxColor = getglobal("SAhe_NormalTexture");
	boxColor:SetVertexColor(SAConfig.color.he.r,SAConfig.color.he.g,SAConfig.color.he.b);
	boxColor = getglobal("SAbu_NormalTexture");
	boxColor:SetVertexColor(SAConfig.color.bu.r,SAConfig.color.bu.g,SAConfig.color.bu.b);
	boxColor = getglobal("SAem_NormalTexture");
	boxColor:SetVertexColor(SAConfig.color.em.r,SAConfig.color.em.g,SAConfig.color.em.b);
	boxColor = getglobal("SAto_NormalTexture");
	boxColor:SetVertexColor(SAConfig.color.to.r,SAConfig.color.to.g,SAConfig.color.to.b);

	SAOptionsRadio1:SetChecked(0);
	SAOptionsRadio2:SetChecked(0);
	SAOptionsRadio3:SetChecked(0);
	SAOptionsRadioA:SetChecked(0);
	SAOptionsRadioB:SetChecked(0);

	sa_options = 1;
	AlertFrameText:SetAlpha(1);
	AlertFrameText:Show();
	AlertFrameText:SetTextColor(0.3,0.3,0.3);
	if (SAConfig.radio == 1) then
		SAOptionsRadio1:SetChecked(1);
		AlertFrameText:SetText("<Enemy Name> begins casting <Spell>!");
	elseif (SAConfig.radio == 2) then
		SAOptionsRadio2:SetChecked(1);
		AlertFrameText:SetText("<Enemy Name> begins casting |cffffffff<Spell>!|r");
	else
		SAOptionsRadio3:SetChecked(1);
		AlertFrameText:SetText("|cffffffff<Enemy Name> begins casting |r<Spell>!");
	end

	if (SAConfig.drag == 5) then
		SAOptionsRadioA:SetChecked(1);
	else
		SAOptionsRadioB:SetChecked(1);
	end

	SpellAlert_Toggle();

end

function SA_Radio_OnClick()
	local radioId = this:GetID();
	if(radioId <= 3) then
		SAConfig.radio = radioId;
	else
		SAConfig.drag = radioId;
	end
	SA_Radio_Update();
end

function SA_Radio_Update()
	SAOptionsRadio1:SetChecked(0);
	SAOptionsRadio2:SetChecked(0);
	SAOptionsRadio3:SetChecked(0);
	SAOptionsRadioA:SetChecked(0);
	SAOptionsRadioB:SetChecked(0);

	if (SAConfig.radio == 1) then
		SAOptionsRadio1:SetChecked(1);
		AlertFrameText:SetText("<Enemy Name> begins casting <Spell>!");
	elseif (SAConfig.radio == 2) then
		SAOptionsRadio2:SetChecked(1);
		AlertFrameText:SetText("<Enemy Name> begins casting |cffffffff<Spell>!|r");
	else
		SAOptionsRadio3:SetChecked(1);
		AlertFrameText:SetText("|cffffffff<Enemy Name> begins casting |r<Spell>!");
	end

	if (SAConfig.drag == 5) then
		SAOptionsRadioA:SetChecked(1);
	else
		SAOptionsRadioB:SetChecked(1);
	end

	SpellAlert_Toggle()

end

function SpellAlert_Toggle()
	
	if (SAConfig.drag == 5) then
		SADrag:SetMovable(false);
		AlertFrame:ClearAllPoints();
		AlertFrame:SetPoint("TOP", 0, SAConfig.pos);
		AlertFrameText:ClearAllPoints();
		AlertFrameText:SetPoint("CENTER", "AlertFrame", "CENTER");
		AlertFrameText:SetJustifyH("CENTER");
		SADrag:Hide();
	else

		if (sa_options == 1) then
			SADrag:Show();
		end
		
		AlertFrame:ClearAllPoints();

		if ((SADrag:GetLeft()+32) < (GetScreenWidth()/2)) then
			AlertFrame:SetPoint("LEFT", "SADrag", "LEFT", 0, -30);
			AlertFrameText:ClearAllPoints();
			AlertFrameText:SetPoint("LEFT", "AlertFrame", "LEFT");
			AlertFrameText:SetJustifyH("LEFT");
		else
			AlertFrame:SetPoint("RIGHT", "SADrag", "RIGHT", 0, -30);
			AlertFrameText:ClearAllPoints();
			AlertFrameText:SetPoint("RIGHT", "AlertFrame", "RIGHT");
			AlertFrameText:SetJustifyH("RIGHT");
		end

		SADrag:SetMovable(true);
	end

end

function AlertFrame_Adjust()

	if (SADrag:IsVisible()) then
		if ((SADrag:GetLeft()+32) < (GetScreenWidth()/2)) then
			if (change == 0 and not changed) then
				AlertFrame:ClearAllPoints();
				AlertFrame:SetPoint("LEFT", "SADrag", "LEFT", 0, -30);
				AlertFrameText:ClearAllPoints();
				AlertFrameText:SetPoint("LEFT", "AlertFrame", "LEFT");
				AlertFrameText:SetJustifyH("LEFT");
				changed = true;
			elseif (change == 1 and changed) then
				change = 0;
				changed = false;
			end
			
			AlertFrameText:SetWidth(GetScreenWidth() - AlertFrame:GetLeft());
			
		else
			if (change == 1 and not changed) then
				AlertFrame:ClearAllPoints();
				AlertFrame:SetPoint("RIGHT", "SADrag", "RIGHT", 0, -30);
				AlertFrameText:ClearAllPoints();
				AlertFrameText:SetPoint("RIGHT", "AlertFrame", "RIGHT");
				AlertFrameText:SetJustifyH("RIGHT");
				changed = true;
			elseif (change == 0 and changed) then
				change = 1;
				changed = false;
			end

			AlertFrameText:SetWidth(GetScreenWidth() - (GetScreenWidth() - AlertFrame:GetRight()));

		end

	end
	
end


function SpellAlert_UpdateLook()

	if(SAConfig.shadow == 0) then
		shadow = "";
	elseif (SAConfig.shadow == 1) then
		shadow = "OUTLINE";
	elseif (SAConfig.shadow == 2) then
		shadow = "THICKOUTLINE";
	end	

	AlertFrameText:SetFont("Fonts\\FRIZQT__.TTF", SAConfig.zoom, shadow);
	
end


function SpellAlert_UpdatePosition()

	AlertFrame:ClearAllPoints();
	AlertFrame:SetPoint("TOP", 0, SAConfig.pos);

end

function SpellAlert_Bool2Int(val)
	if (val) then
		return 1;
	else
		return 0;
	end
end

function SpellAlert_Int2Bool(val)
	if (val == 0) then
		return nil;
	else
		return 1;
	end
end

function AlertFrame_Show()
	startTime = GetTime();
	AlertFrameText:Show();
end

function SpellAlert_OnUpdate()
	local targetName = UnitName("target");
	if (targetName) then
		sa_targetClass = UnitClass("target");
		sa_targetHostile = UnitIsEnemy("player", "target");
		sa_targetName = targetName;
	else
		if (sa_targetName and (sa_targetClass == "Hunter") and sa_targetHostile) then
			SpellAlert_retargetHunter();
		end
	end

	if(sa_options == 0) then
		local elapsed = GetTime() - startTime;
		if ( elapsed < fadeInTime ) then
			local alpha = (elapsed / fadeInTime);
			AlertFrameText:SetAlpha(alpha);
			return;
		end
		if ( elapsed < (fadeInTime + SAConfig.holdTime) ) then
			AlertFrameText:SetAlpha(1.0);
			return;
		end
		if ( elapsed < (fadeInTime + SAConfig.holdTime + fadeOutTime) ) then
			local alpha = 1.0 - ((elapsed - SAConfig.holdTime - fadeInTime) / fadeOutTime);
			AlertFrameText:SetAlpha(alpha);
			return;
		end
		AlertFrameText:Hide();
	end
end
