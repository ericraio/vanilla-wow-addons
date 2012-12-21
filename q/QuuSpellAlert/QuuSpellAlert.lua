-------------------------------------------------------------------------------
-- Quu Spell Alert
-- A mod that alerts about spell effects. Written by Quu
-- Original "Spell Alert" written by Awen
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Contants
-- The things that make this tick
-------------------------------------------------------------------------------
BINDING_HEADER_QSATITLE = "Quu Spell Alert";
QSA_VERSION             = "2.5.1";
local QSA_SLASH_COMMAND = "/qsa";
-- how long alerts should be displayed
local QSA_NON_CRIT_TIME = 2;
local QSA_CRIT_TIME     = 5;

-------------------------------------------------------------------------------
-- controll variables
-- these are the variables that are saved between sessions, and variables
-- that enable the "controll" logic
-------------------------------------------------------------------------------

-- the basics (there are stored in the savedvariables.lua
QSA_SavedVars_DEFAULT = { 
	Enabled = true;
	
	CombatOnly = true;
	TargetOnly = false;
	
	ShortDisplay = true;
	
	EmoteMode = true;
	GainMode = true;
	FadeMode = false;
	Afflictions = true;
	
	QSA_Hide = false;
};

QSA_SavedVars = { 
};
QSA_RED   = 1.0;
QSA_GREEN = 0.2;
QSA_BLUE  = 0.2;
QSA_ALPHA = 1.0;

function getVar( varName)
	local playerName = UnitName( "player");
	if (not QSA_SavedVars[playerName]) then
		QSA_SavedVars[playerName] = QSA_SavedVars_DEFAULT;
	end
	
	return QSA_SavedVars[playerName][varName];
end

function setVar( varName, value)
	local playerName = UnitName( "player");
	if (not QSA_SavedVars[playerName]) then
		QSA_SavedVars[playerName] = QSA_SavedVars_DEFAULT;
	end
	
	QSA_SavedVars[playerName][varName] = value;
end

function toggleVar( varName) 
	local playerName = UnitName( "player");
	if (not QSA_SavedVars[playerName]) then
		QSA_SavedVars[playerName] = QSA_SavedVars_DEFAULT;
	end
	
	QSA_SavedVars[playerName][varName] = not QSA_SavedVars[playerName][varName];
end


-- this is the last caster that was captured
-- used for the key binding
local QSA_LastTarget;

-------------------------------------------------------------------------------
-- Alert functions
-------------------------------------------------------------------------------
-- print simple messages
function QSA_println( Message)
	DEFAULT_CHAT_FRAME:AddMessage(Message, 1.0, 1.0, 1.0);
end

-- normal alerts
function QSA_Banner(msg)
	QuuSpellAlertNormalFrame:AddMessage(msg, QSA_RED, QSA_GREEN, QSA_BLUE, QSA_ALPHA, QSA_NON_CRIT_TIME);
end

-- critical alerts
function QSA_Critical(msg)
	QuuSpellAlertCriticalFrame:AddMessage(msg, QSA_RED, QSA_GREEN, QSA_BLUE, QSA_ALPHA, QSA_CRIT_TIME);
end

-------------------------------------------------------------------------------
-- the colour picking stuff (and alpha)
-------------------------------------------------------------------------------
-- initial loading of the color chooser
function QSA_ChooseColor()
	ColorPickerFrame.func = QSA_SetColor;
	ColorPickerFrame.hasOpacity = true;
	ColorPickerFrame.opacityFunc = QSA_SetOpacity;
	ColorPickerFrame.opacity = 1.0 - QSA_ALPHA;
	ColorPickerFrame:SetColorRGB(QSA_RED, QSA_GREEN, QSA_BLUE);
	ColorPickerFrame.previousValues = {r = QSA_RED, g = QSA_GREEN, b = QSA_BLUE, opacity = (1.0 - QSA_ALPHA)};
	ColorPickerFrame.cancelFunc = QSA_CancelColor;
	ShowUIPanel(ColorPickerFrame);
end

-- this is the values as they are set
function QSA_SetColor()
	QSA_RED, QSA_GREEN, QSA_BLUE = ColorPickerFrame:GetColorRGB();
end

-- this si the opacity as they are set
function QSA_SetOpacity()
	QSA_ALPHA = 1.0 - OpacitySliderFrame:GetValue();
end

-- they changed thier minds
function QSA_CancelColor()
	QSA_RED   = ColorPickerFrame.previousValues.r;
	QSA_GREEN = ColorPickerFrame.previousValues.g;
	QSA_BLUE  = ColorPickerFrame.previousValues.b;
	QSA_ALPHA = 1.0 - ColorPickerFrame.previousValues.opacity;
end

-------------------------------------------------------------------------------
-- Options box... the functions for the options dialog box
-------------------------------------------------------------------------------
function QSA_OptionsOpen()
	if ( not QuuSpellAlertOptions:IsVisible() ) then
		QuuSpellAlertOptionsEnable:SetChecked(getVar("Enabled"));
		QuuSpellAlertOptionsCombat:SetChecked(getVar("CombatOnly"));
		QuuSpellAlertOptionsTarget:SetChecked(getVar("TargetOnly"));
		QuuSpellAlertOptionsShort:SetChecked(getVar("ShortDisplay"));
		QuuSpellAlertOptionsEmote:SetChecked(getVar("EmoteMode"));
		QuuSpellAlertOptionsGain:SetChecked(getVar("GainMode"));
		QuuSpellAlertOptionsFade:SetChecked(getVar("FadeMode"));
		QuuSpellAlertOptionsAffliction:SetChecked(getVar("Afflictions"));

		QuuSpellAlertOptions:Show();
	else
		QSA_OptionsClose();
	end
end

function QSA_OptionsClose()

	setVar( "Enabled", QuuSpellAlertOptionsEnable:GetChecked());
	setVar( "CombatOnly", QuuSpellAlertOptionsCombat:GetChecked());
	setVar( "TargetOnly", QuuSpellAlertOptionsTarget:GetChecked());
	setVar( "ShortDisplay", QuuSpellAlertOptionsShort:GetChecked());
	setVar( "EmoteMode", QuuSpellAlertOptionsEmote:GetChecked());
	setVar( "GainMode", QuuSpellAlertOptionsGain:GetChecked());
	setVar( "FadeMode", QuuSpellAlertOptionsFade:GetChecked());
	setVar( "Afflictions", QuuSpellAlertOptionsAffliction:GetChecked());

	QuuSpellAlertOptions:Hide();
end

-------------------------------------------------------------------------------
-- the init and configuration
-------------------------------------------------------------------------------
function QSA_Init()
	QSA_Status();

	-- Register our slash command
	SLASH_QSA1 = QSA_SLASH_COMMAND;
	SlashCmdList["QSA"] = function(msg)
		QSA_Command(msg);
	end

	if (getVar( "QSA_Hide")) then
		QuuSpellAlertAnchor:Hide();
	end

	QSA_LastTarget = nil;
end

function QSA_Command(msg)
	if( msg ) then
		local command = string.lower(msg);
		if( command == "" ) then
			QSA_println(QSA_SLASH_COMMAND.." ["..QSA_MACRO_STATUS.."|"..QSA_MACRO_TOGGLE.."|...]");
			QSA_println("  "..QSA_MACRO_STATUS.."  "..QSA_MACRO_STATUS_DESC);
			QSA_println("  "..QSA_MACRO_TOGGLE.."  "..QSA_MACRO_TOGGLE_DESC);
			QSA_println("  "..QSA_MACRO_REPORT.."  "..QSA_MACRO_REPORT_DESC);
			QSA_println("  "..QSA_MACRO_TARGET.."  "..QSA_MACRO_TARGET_DESC);
			QSA_println("  "..QSA_MACRO_SHOW.."  "..QSA_MACRO_SHOW_DESC);
			QSA_println("  "..QSA_MACRO_EMOTE.."  "..QSA_MACRO_EMOTE_DESC);
			QSA_println("  "..QSA_MACRO_GAIN.."  "..QSA_MACRO_GAIN_DESC);
			QSA_println("  "..QSA_MACRO_FADE.."  "..QSA_MACRO_FADE_DESC);
			QSA_println("  "..QSA_MACRO_COMBAT.."  "..QSA_MACRO_COMBAT_DESC);
			QSA_println("  "..QSA_MACRO_TRGNLY.."  "..QSA_MACRO_TRGNLY_DESC);
			QSA_println("  "..QSA_MACRO_SHORT.."  "..QSA_MACRO_SHORT_DESC);
			QSA_println("  "..QSA_MACRO_AFFL.."  "..QSA_MACRO_AFFL_DESC);
			QSA_println("  "..QSA_MACRO_TEST.."  "..QSA_MACRO_TEST_DESC);
		elseif (command == QSA_MACRO_STATUS ) then
			QSA_Status();
		elseif (command == QSA_MACRO_TOGGLE ) then
			toggleVar( "Enabled");
			QSA_Status();
		elseif (command == QSA_MACRO_REPORT ) then
			toggleVar( "QSA_Report");
			QSA_Status();
		elseif (command == QSA_MACRO_TARGET ) then
			QSA_TargetLast();
		elseif (command == QSA_MACRO_SHOW ) then
			setVar( "QSA_Hide", false)
			QuuSpellAlertAnchor:Show();
			QuuSpellAlertTimerFrame:Show();
		elseif (command == QSA_MACRO_EMOTE ) then
			toggleVar( "EmoteMode");
			QSA_Status();
		elseif (command == QSA_MACRO_GAIN ) then
			toggleVar( "GainMode");
			QSA_Status();
		elseif (command == QSA_MACRO_FADE ) then
			toggleVar( "FadeMode");
			QSA_Status();
		elseif (command == QSA_MACRO_COMBAT ) then
			toggleVar( "CombatOnly");
			QSA_Status();
		elseif (command == QSA_MACRO_TRGNLY ) then
			toggleVar( "TargetOnly");
			QSA_Status();
		elseif (command == QSA_MACRO_SHORT ) then
			toggleVar( "ShortDisplay");
			QSA_Status();
		elseif (command == QSA_MACRO_AFFL ) then
			toggleVar( "Afflictions");
			QSA_Status();
		elseif (command == QSA_MACRO_TEST ) then
			QSA_Test();
		else
			QSA_println( QSA_MACRO_ERROR);
		end
	end
end

function QSA_Test()
	local enabled_temp = getVar("Enabled");
	local combat_temp = getVar("CombatOnly");
	local target_only = getVar("TargetOnly");

	setVar( "Enabled",true);
	setVar( "CombatOnly",false);
	setVar( "TargetOnly",false);

	-- I am not going to localize the test strings

	
	--Running through the events
	local creature = "Beta Death Shaman";

	local emote = " is dacing to the beat!";
	QSA_Event( "CHAT_MSG_MONSTER_EMOTE", emote, creature);
	
	local casting = "Uber Flame Strike";
	local buffer = string.format(SPELLCASTOTHERSTART, creature, casting);
	QSA_Event( "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", buffer, nil);
	
	local performing = "Death Coil Onion";
	buffer = string.format(SPELLPERFORMOTHERSTART, creature, performing);
	QSA_Event( "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", buffer, nil);
	
	local totem = "Uber "..QSA_TOTEM;
	buffer = string.format(SPELLCASTGOOTHER, creature, totem);
	QSA_Event( "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", buffer, nil);
	

	local aura = "Uberness";
	buffer = string.format(AURAADDEDOTHERHELPFUL, creature, aura);
	QSA_Event( "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", buffer, nil);

	-- and displaying some information
	QSA_Critical("This is the Critical Alert area");
	QSA_Critical("More important stuff is here");

	setVar( "TargetOnly",target_only);
	setVar( "CombatOnly",combat_temp);
	setVar( "Enabled",enabled_temp);
end

function QSA_TargetLast()
	if (QSA_LastTarget ~= nil) then
		TargetByName(QSA_LastTarget);
	end
end

function QSA_Status()
	--[[
	QSA_println( "Quu Spell Alert "..QSA_VERSION);
	if (getVar("Enabled")) then
		 QSA_println( QSA_STATUS_ENABLED);
		if (QSA_Report) then
			QSA_println( QSA_REPORT_ENABLED);
		end
		if (getVar("EmoteMode")) then
			QSA_println( QSA_EMOTE_ENABLED);
		end
		if (getVar("GainMode")) then
			QSA_println( QSA_GAIN_ENABLED);
		end
		if (getVar("FadeMode")) then
			QSA_println( QSA_FADE_ENABLED);
		end
		if (getVar("CombatOnly")) then
			QSA_println( QSA_COMBAT_ENABLED);
		end
		if (getVar("TargetOnly")) then
			QSA_println( QSA_TRGONLY_ENABLED)
		end
		if (getVar("ShortDisplay")) then
			QSA_println( QSA_SHORT_ENABLED)
		end
		if (getVar("Afflictions")) then
			QSA_println( QSA_AFFL_ENABLED)
		end
	else
		QSA_println( QSA_STATUS_DISBALED);
	end
	]]--
end


-------------------------------------------------------------------------------
-- the display logic
-- this takes the spell and caster... and determains if we alert on it
-------------------------------------------------------------------------------

function QSA_ReplaceTokens( originalString, caster, effect)
	return string.gsub( string.gsub( originalString, "$c", caster), "$e", effect);
end

-- name check function
function QSA_IsInParty( Name)
	if (Name == UnitName("player")) then
		return true;
	elseif (Name == UnitName("pet")) then
		return true;
	elseif (Name == UnitName("party1")) then
		return true;
	elseif (Name == UnitName("party2")) then
		return true;
	elseif (Name == UnitName("party3")) then
		return true;
	elseif (Name == UnitName("party4")) then
		return true;
	elseif (Name == UnitName("partypet1")) then
		return true;
	elseif (Name == UnitName("partypet2")) then
		return true;
	elseif (Name == UnitName("partypet3")) then
		return true;
	elseif (Name == UnitName("partypet4")) then
		return true;
	else
		local numRaidMembers = GetNumRaidMembers();
		if (numRaidMembers > 0) then
			-- we are in a raid
			for i=1, numRaidMembers do
				RaidName = GetRaidRosterInfo(i);
				if ( Name == RaidName) then
					return true;
				end
				if ( Name == UnitName("raidpet"..i)) then
					return true;
				end
			end
		end
	end
	return false;
end

-- this displays the information
function QSA_Display( Creature, Effect, Msg, type, bannner)
	if (not getVar(type)) then
		return;
	end;
	
	-- first... do we ignore it?
	if (QSA_IgnoreSpells[Effect]) then
		return;
	end

	-- then if they are in our party... ignore it
	if (QSA_IsInParty(Creature)) then
		return;
	end

	if (getVar("TargetOnly") and (UnitExists("target"))) then
		if (UnitName("target") ~= Creature) then
			return;
		end
	end

	-- save the name for a targetbyname possability
	QSA_LastTarget = Creature;

	if (QSA_ImportantSpells[Effect]) then
		-- its important... flag it
		if (getVar("ShortDisplay")) then
			QSA_Critical( QSA_ReplaceTokens(bannner, Creature, Effect));
		else
			QSA_Critical( Msg);
		end

	else
		-- its not important... put a normal display
		if (getVar("ShortDisplay")) then
			QSA_Banner( QSA_ReplaceTokens(bannner, Creature, Effect));
		else
			QSA_Banner( Msg);
		end
	end

end

-------------------------------------------------------------------------------
-- event block... this listens and deals with all those pesky events
-------------------------------------------------------------------------------

-- this is all the events that might trip up ones we care about
-- all these doe is remove potential "pitfall" alerts... spam
QSA_PreConsumerStrings = {
	AURAADDEDSELFHELPFUL,
	AURADISPELSELF,
	AURAREMOVEDSELF,
	GENERICPOWERGAIN_OTHER,
	GENERICPOWERGAIN_SELF,
	PERIODICAURAHEALOTHEROTHER,
	PERIODICAURAHEALOTHERSELF,
	PERIODICAURAHEALSELFOTHER,
	PERIODICAURAHEALSELFSELF,
	POWERGAIN_OTHER,
	POWERGAIN_SELF,
	SPELLCASTGOSELF,
	SPELLCASTSELFSTART,
	SPELLEXTRAATTACKSOTHER,
	SPELLEXTRAATTACKSOTHER_SINGULAR,
	SPELLEXTRAATTACKSSELF,
	SPELLEXTRAATTACKSSELF_SINGULAR,
	SPELLPERFORMSELFSTART,
	SPELLPOWERDRAINOTHEROTHER,
	SPELLPOWERDRAINOTHERSELF,
	SPELLPOWERLEECHOTHEROTHER,
	SPELLPOWERLEECHOTHERSELF,
	SPELLPOWERLEECHSELFOTHER,
}

-- this function converts one of the globals into a search string
-- this is important so we don't have to localize them
function QSA_FormatGlobalStrings( globalString)
	local res = globalString;

	-- first reformat the "global" so it can be gsubed
	local i;
	for i = 1, string.len(res) do
		if (string.sub(res, i, i) == "%") then
			if (i == 1) then
				res = "$"..string.sub(res, 2);
			else
				res = string.sub(res, 1, i -1).."$"..string.sub(res, i + 1);
			end
		end
	end
	res = string.gsub(res, "$s", "(.+)");
	res = string.gsub(res, "$d", "(%d)");
	return res;
end

-- this is the "big" function
function QSA_Event(event, arg1, arg2)
	-- are we enabled
	if (not getVar("Enabled")) then
		return;
	end

	-- are we in combat
	if ((not UnitAffectingCombat("player")) and getVar("CombatOnly")) then
		return;
	end

	-- first lets check for emotes
	if (
		(event == "CHAT_MSG_EMOTE") or
		-- (event == "CHAT_MSG_TEXT_EMOTE") or
		(event == "CHAT_MSG_MONSTER_EMOTE")
	) then
		-- got one... process it for display
		QSA_Display( arg2, arg1, arg2.." "..arg1, "EmoteMode", QSA_EMOTE_BANNER);
		return;
	elseif (
		(event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") or
		(event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE") or
		(event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
	) then
		-- looks like we have somethign effecting the party

		if (getVar("Afflictions")) then
			for effect in string.gfind(arg1,QSA_FormatGlobalStrings(AURAADDEDSELFHARMFUL)) do
				if (getVar("Afflictions")) then
					if (QSA_Alert_Afflictions[effect]) then
						QSA_Critical(arg1);
					end
				end
	
				return;
			end

			-- now we look to see if a team member is afflicted with somethign we care about
			for player, effect in string.gfind(arg1,QSA_FormatGlobalStrings(AURAADDEDOTHERHARMFUL)) do
				--AURAADDEDOTHERHARMFUL = "%s is afflicted by %s."; -- Combat log text for aura events
				if (QSA_Alert_Afflictions[effect]) then
					QSA_Critical(arg1);
				end
				return;
			end
		end
	else

		-- first remove any troublesome strings that might trip up the real ones
		for key, value in QSA_PreConsumerStrings do
			for _  in string.gfind(arg1,QSA_FormatGlobalStrings(value)) do
				if (QSA_Debug) then
					if ( not QSA_DebugArray.preConsumed) then
						QSA_DebugArray.preConsumed = { };
					end
					QSA_DebugArray.preConsumed[arg1] = event;
				end
				return;
			end
		end


		-- now parse the different spells we listen to
		local mob = "<ERROR>";
		local effect = "<ERROR>";


		for mob, effect in string.gfind(arg1,QSA_FormatGlobalStrings(SPELLCASTOTHERSTART)) do
			QSA_Display( mob, effect, arg1, "Enabled", QSA_CASTING_BANNER);
			return;
		end

		for mob, effect in string.gfind(arg1,QSA_FormatGlobalStrings(SPELLPERFORMOTHERSTART)) do
			QSA_Display( mob, effect, arg1, "Enabled", QSA_CASTING_BANNER);
			return;
		end

		for mob, effect in string.gfind(arg1,QSA_FormatGlobalStrings(SPELLCASTGOOTHER)) do
			if (string.find(effect, QSA_TOTEM)) then
				QSA_Display( mob, effect, arg1, "Enabled", QSA_CASTING_BANNER);
			end


			return;
		end

		for effect, mob in string.gfind(arg1,QSA_FormatGlobalStrings(AURAREMOVEDOTHER)) do
			QSA_Display( mob, effect, arg1, "FadeMode", QSA_FADE_BANNER);
			return;
		end

		for mob, effect in string.gfind(arg1,QSA_FormatGlobalStrings(AURADISPELOTHER)) do
			QSA_Display( mob, effect, arg1, "FadeMode", QSA_FADE_BANNER);
			return;
		end

		for mob, effect in string.gfind(arg1,QSA_FormatGlobalStrings(AURAADDEDOTHERHELPFUL)) do
			QSA_Display( mob, effect, arg1, "GainMode", QSA_GAIN_BANNER);
			return;
		end

		-- GAIN2 is for when a mob gets a bad status ailment...
		-- we don't normally care about that... so only do it
		-- if it is an important event.
		for mob, effect in string.gfind(arg1,QSA_FormatGlobalStrings(AURAADDEDOTHERHARMFUL)) do
			if (QSA_ImportantSpells[effect]) then
				QSA_Display( mob, effect, arg1, "GainMode", QSA_GAIN_BANNER);
			end
			return;
		end

	end
end

