--[[ 

Carnival_EnemyCastBar

Description:
------------
Displays a replication of your targets spell casting bar on your UI, which can be moved around.
Spell casting time is not something that is available to your WoW client, so I have provided cast times for most (if not all spells).
As talents can be a factor on the cast time of some spells, the lowest cast time possible is used
ie. all Shadow Bolt cast times will display at 2.5 seconds even though the player you have targetted doesnt have those specific talents.
Interruptions on your target, ie. they get hit, will not adjust the display on your cast bar, as again, its impossible to know if it affected the cast.
This currently works for both Alliance and Horde, but has only been really tested playing against alliance characters.
Will display either a green cast bar for friendly targets, or a red for a hostile target.

To move the bars, simply target someone and wait for them to do something, when they do, simply click and drag the FIRST bar that appears.
This might take a few tries, just get a friend to cast their Hearthstone while you have them targetted and this becomes a whole lot easier :)

I do intend to develop this further, just a lot of people who I told about this are extremly interested in getting their grubby little paws on it.
So this is only an alpha release, as it currently doesnt do everything I want it to.

Expect a new version soon!


Support:
--------
Either reply on the website you downloaded this from (www.curse-gaming.com or http://ui.worldofwar.net) or on my guilds forums (http://www.carnivalguild.co.uk)


Author:
-------
Miranda on Al'Akir (EU)
But please, don't ask me for support while im in game!
If you want to thank me however, feel free :)


Revision History:
-----------------
18/01/06  v1.0 ALPHA
* Initial Alpha Release

24/01/06  v1.1 BETA
* Adjusted bars so that they "grow" from the bottom up
* Adjusted cast time on several spells,
* Added timers for warlock pet spells,
* Added timers for most trinkets, talisman of power, zandalarian hero charm, to show remaining time
* Added timers for gained abilities, arcane power, sprint, to show remaining time,
* Added timers for racial talents, perception, war stomp, will of the forsaken, to show cast time or remaining time depending on the talent,
* Added timers for various PvE events,
 - Molten Core
   - Lucifron (Impending Doom, Lucifron's Curse)
   - Magmadar (Fear)
   - Gehennas (Gehennas' Curse)
   - Majordomo (Magic Reflection, Damage Shield)
   - Ragnaros (Submerge, Knockback and Sons of the Flame)
 - Blackwing Lair
   - Firemaw (Wing Buffet, Shadow Flame)
   - Ebonroc (Wing Buffet, Shadow Flame)
   - Flamegor (Wing Buffet, Shadow Flame)
   - Chromaggus (Frost Burn, Time Lapse, Ignite Flesh, Corrosive Acid, Incinerate)
   - Neferian (Event Start, Bellowing Roar, Class Calls)
* Fixed some possibly laggy code

24/01/06  v1.2 BETA
* Fixed a major problem with the XML frame

27/01/06  v1.3 BETA
* Added Slash Commands
 - /cenemycast enable/disable
 - /cenemycast show
 - /cenemycast pvp
 - /cenemycast pve
* Fixed issue with "X gains Y" events
* Added Stoneform,
* Added Shadowguard,
* Added Priest - Mana Burn,
* Added Priest - Holy Fire,
* Added Priest - Mind Soothe,
* Added Priest - Prayer of Healing,
* Added Priest - Shackle Undead,
* Added Druid - Hibernate,
* Added Druid - Soothe Animal,
* Added Druid - Bark Skin,
* Added Druid - Innervate,
* Added Mage - Conjure Mana Ruby,
* Added Mage - Conjure Mana Citrine,
* Added Mage - Conjure Mana Jade,
* Added Mage - Conjure Mana Agate,
* Added Mage - Slow Fall,
* Added Warrior - Bloodrage,
* Added Warrior - Shield Wall,
* Added Warrior - Recklessness,
* Added Warrior - Berserker Rage,

31/01/06  v1.4 BETA
* Fixed an error about FADESTEP,
* Fixed problem with Bellowing Roar on Nefarian/Onyxia, Onyxia's is 1.5sconds, Nefarain's is 2.0seconds
* Fixed debug output saying "ECB Control - Running i"
* Added cooldown data to the spell database, however the data is not in use yet
* Added timer for Hakkar in Zul'Gurrub
* Added German localization!
* Added /ecb lock - Locks or Unlocks the Casting Bars
* Added /ecb reset - Resets the bar position
* Adjusted Mage - Fireball,
* Adjusted Driud - Bark Skin,
* Adjusted Driud - Innervate,
* Adjusted Druid - Healing Touch,
* Adjusted Druid - Regrowth,
* Adjusted Hunter - Scare Beast,
* Adjusted Mage - Conjure Water,
* Adjusted Mage - Conjure Food,
* Adjusted Paladin - Howl of Terror,
* Adjusted Paladin - Summon Charger,
* Adjusted Paladin - Summon Warhorse
* Adjusted Warlock - Summon Felsteed,
* Adjusted Warlock - Summon Dreadsteed,
* Adjusted Warlock - Imp - Firebolt,
* Adjusted Warrior - Slam,
* Added Paladin - Divine Protection,
* Added Paladin - Divine Shield,
* Added Hunter - Dismiss Pet,
* Added Hunter - Revive Pet,
* Added Hunter - Eyes of the Beast,
* Added Hunter - Rapid Fire,
* Added Mage - Fire Ward,
* Added Mage - Frost Ward,
* Added Mage - Teleport: Darnassus,
* Added Mage - Teleport: Thunder Bluff,
* Added Mage - Teleport: Ironforge,
* Added Mage - Teleport: Orgrimmar,
* Added Mage - Teleport: Stormwind,
* Added Mage - Teleport: Undercity,
* Added Mage - Portal: Darnassus,
* Added Mage - Portal: Thunder Bluff,
* Added Mage - Portal: Ironforge,
* Added Mage - Portal: Orgrimmar,
* Added Mage - Portal: Stormwind,
* Added Mage - Portal: Undercity,
* Added Druid - Teleport: Moonglade,
* Added Druid - Tiger's Fury,
* Added Druid - Frenzied Regeneration,
* Added Druid - Rejuvenation
* Added Druid - Abolish Poison
* Added Priest - Fade,
* Added Priest - Renew,
* Added Priest - Abolish Disease,
* Added Rogue - Evasion,
* Added Rogue - Mind-numbing Poison,
* Added Rogue - Mind-numbing Poison II,
* Added Rogue - Mind-numbing Poison III,
* Added Rogue - Pick Lock,
* Added Shaman - Far Sight,
* Added Shaman - Fire Nova Totem,
* Added Shaman - Mana Tide Totem,
* Added Shaman - Stoneclaw Totem,
* Added Warrior - Slam,
* Added Warrior - Retaliation,
* Added Warlock - Ritual of Doom,
* Added Warlock - Enslave Demon,
* Added Warlock - Inferno, 
* Added Warlock - Shadow Ward,
* Added Warlock - Create Spellstone,
* Added Warlock - Create Healthstone,
* Added Warlock - Create Soulstone,
* Added Warlock - Create Firestone,
* Added Warlock - Voidwalker - Consume Shadows,

20/02/06  v1.5
* Added French Localization
* Added "/cenemycast timer" to toggle the timer text
* Fixed the time issue with Flamestrike and BWL mobs
* Fixed Nefarian/Ragnaros Timers so that they actually work
* Fixed (maybe) the issue with the bars not locking
* Fixed (maybe) the issue with multiple bars for the same mob (BWL Drakes)
* Fixed most (if not all) the issues with some PvE bars not appearing on MC bosses
* Removed the /ecb alias so that it doesnt clash with eCastingBar
* Guessed at a fix for the clash with WarriorAlert 
* Added PvE - BWL - Flamegor - Frenzy
* Added PvE - BWL - Chromaggus - Frenzy
* Added PvE - BWL - Nefarian - Landing Warning
* Added PvE - Outdoor - Azuregos - Manastorm
* Added PvE - AQ40 - Obsidian Eradicator Respawn - 15minutes
* Added PvE - AQ20 - Anubisath - Explode - 5 seconds?
* Added General - First Aid - 8 seconds
* Added Engineering - Frost Reflector
* Added Engineering - Shadow Reflector
* Added Engineering - Fire Reflector
* (Reflectors *should* work, however have had NO testing)
* Added Mage - Ice Block - 10 seconds
* Added Paladin - Blessing of Freedom - 16 seconds
* Added Paladin - Blessing of Protection - 10 seconds
* Added Paladin - Blessing of Sacrifice - 10 seconds
* Adjusted - Hakkar - Blood Siphon - 90 seconds
* Adjusted - Warlock - Summon Imp - 6 seconds
* Adjusted - Warlock - Summon Succubus - 6 seconds
* Adjusted - Warlock - Summon Voidwalker - 6 seconds
* Adjusted - Warlock - Summon Felhunter - 6 seconds

21/02/06  v1.6
* Fixed problem with French localization
* Fixed problem with German localization
* Adjusted PvE - AQ20 - Anubisath - Explode - 6 seconds

]]--
 
carniactive = true;
mobname = "Mob";
mob = "Mob";
spell = "Cast Bar";

function ECB_RegisterUltimateUI()
	UltimateUI_RegisterConfiguration(
		"UUI_ECB",
		"SECTION",
		"Enemy Cast Bar",
		"Options to show castbars of other players / npcs."
	);
	UltimateUI_RegisterConfiguration(
		"UUI_ECB_SEPARATOR",
		"SEPARATOR",
		"Enemy Cast Bar",
		"Options to show castbars of other players / npcs."
	);
	UltimateUI_RegisterConfiguration(
		"UUI_ECB_ENABLE",
		"CHECKBOX",
		"Enable / Disable ECB",
		"Check or uncheck this box to enable or disable Enemy Cast Bar.",
		ECB_Enable,
		1
	);
	UltimateUI_RegisterConfiguration(
		"UUI_ECB_LOCK",
		"CHECKBOX",
		"Lock",
		"Check or uncheck this box to lock ECB to it's current position.",
		Carnival_EnemyCastBar_LockPos,
		0
		);
	UltimateUI_RegisterConfiguration(
		"UUI_ECB_RESET_POSITION",
		"BUTTON",
		"",
		"",
		Carnival_EnemyCastBar_ResetPos,
		0,
		0,
		0,
		0,
		"Reset Position"
	);
	UltimateUI_RegisterConfiguration(
		"UUI_ECB_TEST",
		"BUTTON",
		"",
		"",
		ECB_Test,
		0,
		0,
		0,
		0,
		"Show"
	);
	UltimateUI_RegisterConfiguration(
		"UUI_ECB_TIMER",
		"CHECKBOX",
		"Show Time on ECB",
		"Show or hide Cast Bar time.",
		ECB_Timer,
		1
	);
	UltimateUI_RegisterConfiguration(
		"UUI_ECB_PVE",
		"CHECKBOX",
		"Show PvE Spells",
		"Enables or disables ECB from showing PvE only spells.",
		ECB_PVE,
		1
	);
	UltimateUI_RegisterConfiguration(
		"UUI_ECB_PVP",
		"CHECKBOX",
		"Show PvP Spells",
		"Enables or disables ECB from showing PvP only spells.",
		ECB_PVP,
		1
	);
end

function Carnival_EnemyCastBar_OnLoad()

	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF");
	
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS");
	
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS");
	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE");
	
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	
	this:RegisterEvent("VARIABLES_LOADED");
	
	
	SLASH_CARNIVALENEMYCASTBAR1 = "/cenemycast";  
	SLASH_CARNIVALENEMYCASTBAR2 = "/cecb";  
	SlashCmdList["CARNIVALENEMYCASTBAR"] = function(msg)
		Carnival_EnemyCastBar_Handler(msg);
	end
	
	for i=1, 20 do
	
		local button = getglobal("Carni_ECB_"..i);
		button:Hide();
		
	end
	
	if ( not Carnival_EnemyCastBar ) then
		
		Carnival_EnemyCastBar = { };
		Carnival_EnemyCastBar.bStatus = true;
		Carnival_EnemyCastBar.bPvP = true;
		Carnival_EnemyCastBar.bPvE = true;
		Carnival_EnemyCastBar.bLocked = true;
		Carnival_EnemyCastBar.bDebug = true;
		Carnival_EnemyCastBar.bTimer = true;
		
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			frame:StopMovingOrSizing();
			frame:EnableMouse(0);
			Carnival_EnemyCastBar.bLocked = true;
			
		end
			
	end
end

function Carnival_EnemyCastBar_OnClick()
		
	if ( arg1 == "LeftButton" ) then
	
		DEFAULT_CHAT_FRAME:AddMessage("ECB - LeftButton");
		
	elseif ( arg1 == "RightButton" ) then
	
		DEFAULT_CHAT_FRAME:AddMessage("ECB - RightButton");
	
	end
	
end

function Carnival_EnemyCastBar_LockPos()
	
	Carnival_EnemyCastBar.bLocked = not Carnival_EnemyCastBar.bLocked;
	
	if (Carnival_EnemyCastBar.bLocked) then
	
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			frame:StopMovingOrSizing();
			frame:EnableMouse(0);
			
		end
		
		--DEFAULT_CHAT_FRAME:AddMessage("Carnival_EnemyCastBar - Bars Locked");
	
	else
	
		for i=1, 20 do
	
			local frame = getglobal("Carni_ECB_"..i);
			frame:EnableMouse(1);
			
		end	
		
	--	DEFAULT_CHAT_FRAME:AddMessage("Carnival_EnemyCastBar - Bars Unlocked");
		
	end
	
end

function Carnival_EnemyCastBar_ResetPos()

	local frame = getglobal("Carni_ECB_1");
	frame:Hide();
	frame:ClearAllPoints();
	frame:SetPoint("BOTTOMLEFT", "UIParent", "CENTER", 0, 0);

	for i=2, 20 do
	
		o = i - 1;
		local frame = getglobal("Carni_ECB_"..i);
		frame:Hide();
		frame:ClearAllPoints();
		frame:SetPoint("TOPLEFT", "Carni_ECB_"..o, "TOPLEFT", 0, 20);
		
	end

end

function Carnival_EnemyCastBar_Options(var)

	if (var) then
	
		return "on";
		
	else
	
		return "off";
		
	end

end

function ECB_Enable(arg)
	if( arg == 1 ) then
		Carnival_EnemyCastBar.bStatus = true;
		--DEFAULT_CHAT_FRAME:AddMessage("ECB Addon is now enabled")
	elseif( arg == 0) then
		Carnival_EnemyCastBar.bStatus = false;
		--DEFAULT_CHAT_FRAME:AddMessage("ECB Addon is now disabled")
	else
		DEFAULT_CHAT_FRAME:AddMessage("ECB_Enable(arg) returned invalid arg.");
	end
end

function ECB_Test()
	Carnival_EnemyCastBar_Show("Mob", "Spell Name", 10.0, "friendly");
end

function ECB_Timer(arg)
	if( arg == 1 ) then
			Carnival_EnemyCastBar.bTimer = true;
			--DEFAULT_CHAT_FRAME:AddMessage("Cast Bars time display enabled")
	elseif( arg == 0) then
			Carnival_EnemyCastBar.bTimer = false;
			--DEFAULT_CHAT_FRAME:AddMessage("Cast Bar time display disabled")
	else
		DEFAULT_CHAT_FRAME:AddMessage("ECB_Timer(arg) returned invalid arg.");
	end
end

function ECB_PVE(arg)
	if( arg == 1 ) then
			Carnival_EnemyCastBar.bPvE = true;
			--DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvE spells are now enabled")
	elseif( arg == 0) then
			Carnival_EnemyCastBar.bPvE = false;
			--DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvE spells are now disabled")
	else
		DEFAULT_CHAT_FRAME:AddMessage("ECB_PVE(arg) returned invalid arg.");
	end
end

function ECB_PVP(arg)
	if( arg == 1 ) then
			Carnival_EnemyCastBar.bPvP = true;
			--DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvP spells are now enabled")
	elseif( arg == 0) then
			Carnival_EnemyCastBar.bPvP = false;
			--DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvP spells are now disabled")
	else
		DEFAULT_CHAT_FRAME:AddMessage("ECB_PVP(arg) returned invalid arg.");
	end
end

function Carnival_EnemyCastBar_Handler(msg)

	if (msg == "") then
	
		DEFAULT_CHAT_FRAME:AddMessage("<Carnival> PvE/PvP Enemy Cast Bar")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast enable/disable ("..Carnival_EnemyCastBar_Options(Carnival_EnemyCastBar.bStatus)..") - Enables or Disables the Addon")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast show - Shows the bar, this will allow you to move it around")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast reset - Resets the bars to their original position")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast lock - Toggle - Will lock and unlock the bars into position")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast pvp ("..Carnival_EnemyCastBar_Options(Carnival_EnemyCastBar.bPvP)..") - Toggles the cast bar for PvP spells on and off")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast pve ("..Carnival_EnemyCastBar_Options(Carnival_EnemyCastBar.bPvE)..") - Toggles the cast bar for PvE spells on and off")
		DEFAULT_CHAT_FRAME:AddMessage("/cenemycast timer ("..Carnival_EnemyCastBar_Options(Carnival_EnemyCastBar.bTimer)..") - Toggles the cast bar timer text on and off")
	
	elseif (msg == "enable") then

		Carnival_EnemyCastBar.bStatus = true;
		DEFAULT_CHAT_FRAME:AddMessage("Addon is now enabled")
		
	elseif (msg == "disable") then

		Carnival_EnemyCastBar.bStatus = false;
		DEFAULT_CHAT_FRAME:AddMessage("Addon is now disabled")
		
	elseif (msg == "lock") then

		Carnival_EnemyCastBar_LockPos()
		
	elseif (msg == "reset") then

		Carnival_EnemyCastBar_ResetPos()
		DEFAULT_CHAT_FRAME:AddMessage("Bars are now reset")
		
	elseif (msg == "show") then

		Carnival_EnemyCastBar_Show("Mob", "Spell Name", 10.0, "friendly");
		
	elseif (msg == "timer") then

		if (Carnival_EnemyCastBar.bTimer) then
	
			Carnival_EnemyCastBar.bTimer = false;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bar time display disabled")
		
		else
		
			Carnival_EnemyCastBar.bTimer = true;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bars time display enabled")
		
		end
		
	elseif (msg == "pvp") then

		if (Carnival_EnemyCastBar.bPvP) then
	
			Carnival_EnemyCastBar.bPvP = false;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvP spells are now disabled")
		
		else
		
			Carnival_EnemyCastBar.bPvP = true;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvP spells are now enabled")
		
		end

	elseif (msg == "pve") then

		if (Carnival_EnemyCastBar.bPvE) then
	
			Carnival_EnemyCastBar.bPvE = false;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvE spells are now disabled")
		
		else
		
			Carnival_EnemyCastBar.bPvE = true;
			DEFAULT_CHAT_FRAME:AddMessage("Cast Bars for PvE spells are now enabled")
		
		end
		
	end
	
end

function Carnival_EnemyCastBar_Show(mob, spell, castime, ctype)

	local showing = false;
	local i = 1;
	local o = 20;
	
	while (i < o) do
	
		local button = getglobal("Carni_ECB_"..i);
	
		if (not button:IsVisible()) then
		
			if (showing == false) then
			
				if (ctype == "hostile") then
				
					red = 1.0;
					green = 0.0;
					blue = 0.0;					
				
				elseif (ctype == "friendly") then
				
					red = 0.0;
					green = 1.0;
					blue = 0.0;	
					
				elseif (ctype == "cooldown") then
				
					red = 0.0;
					green = 0.0;
					blue = 1.0;	
				
				elseif (ctype == "gains") then
				
					red = 1.0;
					green = 0.0;
					blue = 1.0;
				
				end
		
				getglobal("Carni_ECB_"..i).startTime = GetTime();
				getglobal("Carni_ECB_"..i).active = true;
				getglobal("Carni_ECB_"..i).label = mob .." - ".. spell;
				getglobal("Carni_ECB_"..i).spell = spell;
				getglobal("Carni_ECB_"..i).endTime = getglobal("Carni_ECB_"..i).startTime + castime;
				getglobal("Carni_ECB_"..i.."_StatusBar"):SetMinMaxValues(button.startTime,button.endTime);
				getglobal("Carni_ECB_"..i.."_StatusBar"):SetValue(button.startTime);
				getglobal("Carni_ECB_"..i.."_StatusBar"):SetStatusBarColor(red, green, blue);
				button:Show();
				showing = true;
			
			end
		
		end
		
		i = i + 1;
		
	end
	
	showing = false;
  
end

function Carnival_EnemyCastBar_OnEvent(event)
  
	if (event == "VARIABLES_LOADED") then
		if (UltimateUI_RegisterConfiguration) then
			ECB_RegisterUltimateUI();
		end
	end
  
	if (event == "CHAT_MSG_MONSTER_YELL") then
	
		if (Carnival_EnemyCastBar.bDebug) then
	
			DEFAULT_CHAT_FRAME:AddMessage("EVENT: "..event)
		
		end
		
		Carnival_EnemyCastBar_Yells(arg1, arg2);
		
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
	
		Carnival_EnemyCastBar_Emotes(arg1, arg2);
	
	else
	
		Carnival_EnemyCastBar_Gfind(arg1);
	
	end
	
end



function Carnival_EnemyCastBar_Gfind(arg1)

	if (Carnival_EnemyCastBar.bStatus) then

		if (arg1 ~= nil) then
	
			for mob, spell in string.gfind(arg1, Carnival_EnemyCastBar_SPELL_CAST) do
					
				Carnival_EnemyCastBar_Control(mob, spell, "casts");
				return;
				
			end	
			
			for mob, spell in string.gfind(arg1, Carnival_EnemyCastBar_SPELL_PERFORM) do
					
				Carnival_EnemyCastBar_Control(mob, spell, "performs");
				return;
				
			end
		
			for mob, spell in string.gfind(arg1, Carnival_EnemyCastBar_SPELL_GAINS) do
					
				Carnival_EnemyCastBar_Control(mob, spell, "gains");
				return;
				
			end
		
			for mob in string.gfind(arg1, Carnival_EnemyCastBar_MOB_DIES) do
				
				Carnival_EnemyCastBar_Control(mob, mob, "cooldown");
				return;
				
			end
			
			for mob, crap, spell in string.gfind(arg1, Carnival_EnemyCastBar_SPELL_AFFLICTED) do
				
				Carnival_EnemyCastBar_Control(mob, spell, "afflicted");
				return;
				
			end

			for mob, damage, from, spell in string.gfind(arg1, Carnival_EnemyCastBar_SPELL_DAMAGE) do
				
				if (mob == "Hakkar") then
				
					Carnival_EnemyCastBar_Control(mob, spell, "yells");
					return;
				
				end
				
			end
		
		end
	
	end

end

function Carnival_EnemyCastBar_UniqueCheck(spellname)

	alreadyshowing = 0;

	for i=1, 20 do
	
		local spell = getglobal("Carni_ECB_"..i).spell;
		
		if (spell == spellname) then
			
			alreadyshowing = 1;
		
		end
		
	end
	
	return alreadyshowing;

end

function Carnival_EnemyCastBar_Control(mob, spell, special)

	--DEFAULT_CHAT_FRAME:AddMessage("ECB Control - "..mob.." ("..spell..")");
	
	if (Carnival_EnemyCastBar_Raids[spell] ~= nil) then
		
		if (Carnival_EnemyCastBar.bPvE) then
				
			castime = Carnival_EnemyCastBar_Raids[spell].t;
			ctype = Carnival_EnemyCastBar_Raids[spell].c;
			
			-- Spell might have the same name but a different cast time on another mob, ie. Onyxia/Nefarian on Bellowing Roar
			if (Carnival_EnemyCastBar_Raids[spell].r) then
			
				if (mob == Carnival_EnemyCastBar_Raids[spell].r) then
				
					castime = Carnival_EnemyCastBar_Raids[spell].a;
				
				end
			
			end
			
			if (Carnival_EnemyCastBar_Raids[spell].m) then
			
				mob = Carnival_EnemyCastBar_Raids[spell].m
			
			end
			
			alreadyshowing = 0;
			
			if (Carnival_EnemyCastBar_Raids[spell].u) then
				
				unique = Carnival_EnemyCastBar_Raids[spell].u
				
				if (unique == "true") then
				
					alreadyshowing = Carnival_EnemyCastBar_UniqueCheck(spell)
				
				end
			
			end
			
			if (alreadyshowing == 0) then
			
				Carnival_EnemyCastBar_Show(mob, spell, castime, ctype);
			
			end
			
			if (Carnival_EnemyCastBar_Raids[spell].i ~= nil) then
			
				if (alreadyshowing == 0) then
			
					--DEFAULT_CHAT_FRAME:AddMessage("ECB Control - Running i");
					castime = Carnival_EnemyCastBar_Raids[spell].i;
					Carnival_EnemyCastBar_Show(mob, spell, castime, "hostile");
				
				end
			
			end
		
		end
		
	else
	
		if (Carnival_EnemyCastBar.bPvP) then
	
			if (UnitName("target") == mob) then
			
				if (Carnival_EnemyCastBar_Spells[spell] ~= nil) then
				
					if (UnitIsEnemy("player", "target")) then
						ctype = "hostile";
					else
						ctype = "friendly";
					end
			
					if (Carnival_EnemyCastBar_Spells[spell].i ~= nil) then
					
						castime = Carnival_EnemyCastBar_Spells[spell].i;
						Carnival_EnemyCastBar_Show(mob, spell, castime, ctype);					
					
					end
					
					castime = Carnival_EnemyCastBar_Spells[spell].t;
					
					if (special == "gains") then
					
						if (Carnival_EnemyCastBar_Spells[spell].g) then
						
							castime = Carnival_EnemyCastBar_Spells[spell].g;
						
						end
					
					end
					
					-- Spell might have the same name but a different cast time on another mob, ie. Death Talon Hatchers/Players on Bellowing Roar
					if (Carnival_EnemyCastBar_Spells[spell].r) then
					
						if (mob == Carnival_EnemyCastBar_Spells[spell].r) then
						
							castime = Carnival_EnemyCastBar_Spells[spell].a;
						
						end
					
					end
					
					if (Carnival_EnemyCastBar_Spells[spell].c ~= nil) then
					
						ctype = Carnival_EnemyCastBar_Spells[spell].c;
					
					end
	
					Carnival_EnemyCastBar_Show(mob, spell, castime, ctype);
					
				end
			
			end
				
		end
	
	end
		
end

function Carnival_EnemyCastBar_Yells(arg1, arg2)

	if (Carnival_EnemyCastBar.bStatus) then
	
		if (Carnival_EnemyCastBar.bDebug) then
	
			DEFAULT_CHAT_FRAME:AddMessage("YELL: "..arg2)
		
		end

		if (arg2 == "Nefarian") then
		
			if (Carnival_EnemyCastBar.bDebug) then
		
				DEFAULT_CHAT_FRAME:AddMessage("NEFARIAN YELL: "..arg1)
		
			end
			
			if (

				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_SHAMAN_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_DRUID_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_WARLOCK_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_PRIEST_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_HUNTER_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_WARRIOR_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_ROGUE_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_PALADIN_CALL) or
				string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_MAGE_CALL)
				
			) then
		
				Carnival_EnemyCastBar_Control("Nefarian", "Class Call", "pve");
				return;

			end
			
		elseif (arg2 == "Lord Victor Nefarius") then
		
			if (Carnival_EnemyCastBar.bDebug) then
		
				DEFAULT_CHAT_FRAME:AddMessage("LORD VICTOR YELL: "..arg1)
				
			end
		
			if (string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_STARTING)) then
			
				Carnival_EnemyCastBar_Control("Nefarian", "Mob Spawn", "pve");
				return;
			
			elseif (string.find(arg1, Carnival_EnemyCastBar_NEFARIAN_LAND)) then
			
				Carnival_EnemyCastBar_Control("Nefarian", "Landing", "pve");
				return;
			
			end
		
		elseif (arg2 == "Ragnaros") then
		
			if (string.find(arg1, Carnival_EnemyCastBar_RAGNAROS_STARTING)) then
		
				Carnival_EnemyCastBar_Control("Ragnaros", "Submerge", "pve");
				return;
				
			elseif (string.find(arg1, Carnival_EnemyCastBar_RAGNAROS_KICKER)) then
			
				Carnival_EnemyCastBar_Control("Ragnaros", "Knockback", "pve");
				return;
				
			elseif (string.find(arg1, Carnival_EnemyCastBar_RAGNAROS_SONS)) then
			
				Carnival_EnemyCastBar_Control("Ragnaros", "Sons of Flame", "pve");
				return;
			
			end
		
		end
	
	end

end

function Carnival_EnemyCastBar_Emotes(arg1, arg2)

	if (Carnival_EnemyCastBar.bStatus) then

		if (arg2 == "Flamegor") then
		
			if (string.find(arg1, Carnival_EnemyCastBar_FLAMEGOR_FRENZY)) then
		
				Carnival_EnemyCastBar_Control("Flamegor", "Frenzy", "pve");
				return;
				
			end
		
		elseif (arg2 == "Chromaggus") then
		
			if (string.find(arg1, Carnival_EnemyCastBar_CHROMAGGUS_FRENZY)) then
		
				Carnival_EnemyCastBar_Control("Chromaggus", "Killing Frenzy", "pve");
				return;
				
			end
		
		end
	
	end

end

--[[function Carnival_EnemyCastBar_PartyChecker(spellcaster, target)

	if (target) then

		local unit, player;
		local max = 0;
		local groupstr = "";
		
		if (UnitInRaid("player")) then
			max = 40;
			groupstr = "raid";
		else
			max = 4;
			groupstr = "party";
		end
		
		ChatFrame5:AddMessage(spellcaster.." is casting a spell, are they targetting "..target.."?");
		
		for i=0, max do
			
			unit = groupstr..i;
			player = UnitName(unit);
			
			if (player) then
			
				ChatFrame5:AddMessage("Checking "..unit.." ("..player..")");
				
				if (player == spellcaster) then
				
					mob = UnitName(unit.."target");
					if (mob) then
					
						ChatFrame5:AddMessage(""..unit.." ("..player..") target is "..mob);
						
					end
					
					if (mob == target) then
					
						ChatFrame5:AddMessage(spellcaster.." IS TARGETTING "..target.." - SHOW THE BAR!!!");
						return true;
					
					end
					
				end
			
			end
			
		end
	
	end

end--]]

function Carnival_EnemyCastBar_Target()

	TargetByName(mobname);

end

function Carnival_EnemyCastBar_OnUpdate()

    if (not carniactive) then
	
        -- Fade the bar out
        local alpha = this:GetAlpha() - 0.05;
        if (alpha > 0) then
            this:SetAlpha(alpha);
        else
            -- Hide up, reset alpha
            this:Hide();
            this:SetAlpha(1.0);
        end
		this.active = false;
		mobname = "";
		
    else
	
		if (this.endTime ~= nil) then
	
			local label = mobname;
			local now = GetTime();
	
			-- Update the spark, status bar and label
			local remains = this.endTime - now;
			--label = label .. Carnival_EnemyCastBar_NiceTime(remains);
			local sparkPos = ((now - this.startTime) / (this.endTime - this.startTime)) * 195;
			
			getglobal(this:GetName() .. "_StatusBar"):SetValue(now);
			getglobal(this:GetName() .. "_Text"):SetText( this.label );	
			getglobal(this:GetName() .. "_StatusBar_Spark"):SetPoint("CENTER", getglobal(this:GetName() .. "_StatusBar"), "LEFT", sparkPos, 0);
			
			if (Carnival_EnemyCastBar.bTimer) then
			
				getglobal(this:GetName() .. "_CastTimeText"):SetText( format("%.1f", remains) );
			
			end
			
			if (0 > remains) then
			
				getglobal(this:GetName()):Hide();
				getglobal(this:GetName()).spell = nil;
				this.active = false;
				mobname = "";
			
			end
		
		end
    end
end

-- Movable window
function Carnival_EnemyCastBar_OnDragStart()
    CarniEnemyCastBarFrame:StartMoving();
end

function Carnival_EnemyCastBar_OnDragStop()
    CarniEnemyCastBarFrame:StopMovingOrSizing();
end

-- Format seconds into m:ss
function Carnival_EnemyCastBar_NiceTime(secs)
    return string.format("%d:%02d", secs / 60, math.mod(secs, 60));
end

