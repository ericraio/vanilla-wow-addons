-- WARNING
-- THE COMMENTED OUT ABILITIES ARE THERE FOR A REASON
-- PLEASE DO NOT UNCOMMENT THEM, OTHERWISE THINGS WILL PROBABLY BREAK

if ( GetLocale() == "enUS" ) then

	Carnival_EnemyCastBar_Spells = {
	
		-- All Classes
			-- General
		["Hearthstone"] = {t=10.0};
		
			-- Trinkets & Racials
		["Brittle Armor"] = {t=20.0, c="gains"};
		["Unstable Power"] = {t=20.0, c="gains"};
		["Restless Strength"] = {t=20.0, c="gains"};
		["Ephemeral Power"] = {t=15.0, c="gains"};
		["Arcane Power"] = {t=20.0, c="gains"};
		["Massive Destruction"] = {t=20.0, c="gains"};
		["Arcane Potency"] = {t=20.0, c="gains"};
		["Energized Shield"] = {t=20.0, c="gains"};
		["Brilliant Light"] = {t=20.0, c="gains"};
		["Will of the Forsaken"] = {t=5.0, c="gains"};
		["Perception"] = {t=20.0, c="gains"};
		["War Stomp"] = {t=1.5};
		["Stoneform"] = {t=8.0};
		["Shadowguard"] = {t=1.5};
		
			-- Engineering
		["Frost Reflector"] = {t=5.0, c="gains"};
		["Shadow Reflector"] = {t=5.0, c="gains"};
		["Fire Reflector"] = {t=5.0, c="gains"};
		
			-- First Aid
		["First Aid"] = {t=8.0, c="gains"};
		["Linen Bandage"] = {t=3.0};
		["Heavy Linen Bandage"] = {t=3.0};
		["Wool Bandage"] = {t=3.0};
		["Heavy Wool Bandage"] = {t=3.0};
		["Silk Bandage"] = {t=3.0};
		["Heavy Silk Bandage"] = {t=3.0};
		["Mageweave Bandage"] = {t=3.0};
		["Heavy Mageweave Bandage"] = {t=3.0};
		["Runecloth Bandage"] = {t=3.0};
		["Heavy Runecloth Bandage"] = {t=3.0};
		
		-- Druid
		["Healing Touch"] = {t=3.0};
		["Regrowth"] = {t=2.0, g=21.0};
		["Rebirth"] = {t=2.0, d=1800.0};
		["Starfire"] = {t=3.5};
		["Wrath"] = {t=2.0};
		["Entangling Roots"] = {t=2.0};
		["Dash"] = {t=15.0, c="gains", d=300.0};
		["Hibernate"] = {t=1.5};
		["Soothe Animal"] = {t=1.5};
		["Bark Skin"] = {t=15.0, i=0.0, c="gains"};
		["Innervate"] = {t=20.0, i=0.0, c="gains"};
		["Teleport: Moonglade"] = {t=10.0};
		["Tiger's Fury"] = {t=6.0, c="gains"};
		["Frenzied Regeneration"] = {t=10.0, c="gains", d=180.0};
		["Rejuvenation"] = {t=12.0, c="gains"};
		["Abolish Poison"] = {t=8.0, c="gains"};
		--["Hurricane"] = {t=10.0, d=60.0};
		--["Tranquility"] = {t=10.0, d=300.0};
		
		-- Hunter
		["Aimed Shot"] = {t=3.0, d=6.0};
		["Scare Beast"] = {t=1.0, d=30.0};
		["Volley"] = {t=6.0, d=60.0};
		["Dismiss Pet"] = {t=5.0};
		["Revive Pet"] = {t=10.0};
		["Eyes of the Beast"] = {t=2.0};
		["Rapid Fire"] = {t=15.0, c="gains", d=300.0};
		--["Multi-Shot"] = {t=0.0, d=10.0};
		--["Wyvern Sting"] = {t=0.0, d=120.0};
		--["Arcane Shot"] = {t=0.0, d=6.0};
		--["Distracting Shot"] = {t=0.0, d=8.0};
		
		-- Mage
		["Frostbolt"] = {t=2.5};
		["Fireball"] = {t=3.0};
		["Conjure Water"] = {t=3.0};
		["Conjure Food"] = {t=3.0};
		["Conjure Mana Ruby"] = {t=3.0};
		["Conjure Mana Citrine"] = {t=3.0};
		["Conjure Mana Jade"] = {t=3.0};
		["Conjure Mana Agate"] = {t=3.0};
		["Polymorph"] = {t=1.5};
		["Pyroblast"] = {t=6.0, d=60.0};
		["Scorch"] = {t=1.5};
		["Flamestrike"] = {t=3.0, r="Death Talon Hatcher", a=2.5};
		["Slow Fall"] = {t=30.0, c="gains"};
		["Portal: Darnassus"] = {t=10.0};
		["Portal: Thunder Bluff"] = {t=10.0};
		["Portal: Ironforge"] = {t=10.0};
		["Portal: Orgrimmar"] = {t=10.0};
		["Portal: Stormwind"] = {t=10.0};
		["Portal: Undercity"] = {t=10.0};
		["Teleport: Darnassus"] = {t=10.0};
		["Teleport: Thunder Bluff"] = {t=10.0};
		["Teleport: Ironforge"] = {t=10.0};
		["Teleport: Orgrimmar"] = {t=10.0};
		["Teleport: Stormwind"] = {t=10.0};
		["Teleport: Undercity"] = {t=10.0};
		["Fire Ward"] = {t=30.0, c="gains"};
		["Frost Ward"] = {t=30.0, c="gains"};
		["Ice Block"] = {t=10.0, c="gains"};
		--["Blast Wave"] = {t=0.0, d=45.0};
		--["Ice Barrier"] = {t=0.0, d=120.0};
		--["Cone of Cold"] = {t=0.0, d=120.0};
		--["Fire Blast"] = {t=0.0, d=8.0};
		--["Frost Nova"] = {t=0.0, d=25.0};
		--["Counterspell"] = {t=0.0, d=30.0};
		--["Blink"] = {t=0.0, d=15.0};
		--["Ice Block"] = {t=0.0, d=300.0};
		
		-- Paladin
		["Holy Light"] = {t=2.5};
		["Flash of Light"] = {t=1.5};
		["Summon Charger"] = {t=3.0, g=0.0};
		["Summon Warhorse"] = {t=3.0, g=0.0};
		["Hammer of Wrath"] = {t=1.0, d=6.0};
		["Holy Wrath"] = {t=2.0, d=60.0};
		["Turn Undead"] = {t=1.5, d=30.0};
		["Redemption"] = {t=10.0};
		["Divine Protection"] = {t=8.0, c="gains", d=300.0};
		["Divine Shield"] = {t=12.0, c="gains", d=300.0};
		["Blessing of Freedom"] = {t=16.0, c="gains"};
		["Blessing of Protection"] = {t=10.0, c="gains"};
		["Blessing of Sacrifice"] = {t=30.0, c="gains"};
		--["Consecration"] = {t=0.0, d=8.0};
		--["Exorcism"] = {t=0.0, d=15.0};
		--["Hammer of Justice"] = {t=0.0, d=60.0};
		--["Lay on Hands"] = {t=0.0, d=3600.0};
		--["Blessing of Protection"] = {t=0.0, d=300.0};
		
		-- Priest
		["Greater Heal"] = {t=3.0};
		["Flash Heal"] = {t=1.5};
		["Resurrection"] = {t=10.0};
		["Smite"] = {t=2.5};
		["Mind Blast"] = {t=1.5, d=8.0};
		["Mind Control"] = {t=3.0};
		["Mana Burn"] = {t=3.0};
		["Holy Fire"] = {t=4.0, d=15.0};
		["Mind Soothe"] = {t=1.5};
		["Prayer of Healing"] = {t=3.0};
		["Shackle Undead"] = {t=1.5};
		["Fade"] = {t=10.0, c="gains", d=30.0};
		["Renew"] = {t=15.0, c="gains"};
		["Abolish Disease"] = {t=20.0, c="gains"};
		--["Power Word: Shield"] = {t=0.0, d=4.0};
		--["Devouring Plague"] = {t=0.0, d=180.0};
		--["Holy Nova"] = {t=0.0, d=30.0};
		--["Desperate Prayer"] = {t=0.0, d=1800.0};
		--["Psychic Scream"] = {t=0.0, d=30.0};
		
		-- Rogue
		["Disarm Trap"] = {t=5.0};
		["Sprint"] = {t=15.0, c="gains", d=300.0};
		["Mind-numbing Poison"] = {t=3.0};
		["Mind-numbing Poison II"] = {t=3.0};
		["Mind-numbing Poison III"] = {t=3.0};
		["Pick Lock"] = {t=5.0};
		["Evasion"] = {t=15.0, c="gains"};
		--["Blind"] = {t=0.0, d=300.0};
		--["Gouge"] = {t=0.0, d=10.0};
		--["Feint"] = {t=0.0, d=10.0};
		--["Kick"] = {t=0.0, d=10.0};
		--["Kidney Shot"] = {t=0.0, d=20.0};
		
		-- Shaman
		["Lesser Healing Wave"] = {t=1.5};
		["Healing Wave"] = {t=3.0};
		["Ancestral Spirit"] = {t=10.0};
		["Chain Lightning"] = {t=2.5, d=6.0};
		["Ghost Wolf"] = {t=3.0};
		["Astral Recall"] = {t=10.0};
		["Chain Heal"] = {t=2.5};
		["Lightning Bolt"] = {t=3.0};
		["Far Sight"] = {t=2.0};
		["Stoneclaw Totem"] = {t=15.0, c="gains", d=30.0};
		["Mana Tide Totem"] = {t=15.0, c="gains", d=300.0};
		["Fire Nova Totem"] = {t=5.0, c="gains", d=15.0};
		--["Earth Shock"] = {t=0.0, d=6.0};
		--["Frost Shock"] = {t=0.0, d=6.0};
		--["Flame Shock"] = {t=0.0, d=6.0};
		--["Grounding Totem"] = {t=0.0, d=15.0};
		
		-- Warlock
		["Shadow Bolt"] = {t=2.5};
		["Immolate"] = {t=1.5};
		["Soul Fire"] = {t=4.0, d=60.0};
		["Searing Pain"] = {t=1.5};
		["Summon Dreadsteed"] = {t=3.0, g=0.0};
		["Summon Felsteed"] = {t=3.0, g=0.0};
		["Summon Imp"] = {t=6.0};
		["Summon Succubus"] = {t=6.0};
		["Summon Voidwalker"] = {t=6.0};
		["Summon Felhunter"] = {t=6.0};
		["Fear"] = {t=1.5};
		["Howl of Terror"] = {t=2.0, d=40.0, g=0.0};
		["Banish"] = {t=1.5};
		["Ritual of Summoning"] = {t=5.0};
		["Ritual of Doom"] = {t=10.0};
		["Create Spellstone"] = {t=5.0};
		["Create Soulstone"] = {t=3.0};
		["Create Healthstone"] = {t=3.0};
		["Create Firestone"] = {t=3.0};
		["Enslave Demon"] = {t=3.0};
		["Inferno"] = {t=2.0, d=3600.0};
		["Shadow Ward"] = {t=30.0, c="gains"};
		--["Conflagrate"] = {t=0.0, d=10.0};
		--["Death Coil"] = {t=0.0, d=120.0};
		--["Shadowburn"] = {t=0.0, d=15.0};

			-- Imp
			["Firebolt"] = {t=1.5};
			
			-- Succubus
			["Seduction"] = {t=1.5};
			["Soothing Kiss"] = {t=4.0, d=4.0};
			--["Lash of Pain"] = {t=0.0, d=6.0};
			
			-- Felhunter
			--["Devour Magic"] = {t=0.0, d=8.0};
			--["Spell Lock"] = {t=0.0, d=30.0};
			
			-- Voidwalker
			["Consume Shadows"] = {t=10.0, c="gains"};
		
		-- Warrior
		["Bloodrage"] = {t=10.0, c="gains"};
		["Bloodthirst"] = {t=8.0, c="gains", d=6.0};
		["Shield Wall"] = {t=10.0, c="gains", d=1800.0};
		["Recklessness"] = {t=15.0, c="gains", d=1800.0};
		["Retaliation"] = {t=15.0, c="gains", d=1800.0};
		["Berserker Rage"] = {t=10.0, c="gains"};
		["Slam"] = {t=1.0, c="gains"};
		--["Revenge"] = {t=0.0, d=5.0};
		--["Shield Slam"] = {t=0.0, d=6.0};
		--["Overpower"] = {t=0.0, d=5.0};
		--["Mortal Strike"] = {t=0.0, d=6.0};
		--["Pummel"] = {t=0.0, d=10.0};
		--["Thunder Clap"] = {t=0.0, d=4.0};
		--["Mocking Blow"] = {t=0.0, d=120.0};
		--["Intercept"] = {t=0.0, d=30.0};
		--["Charge"] = {t=0.0, d=15.0};
		--["Whirlwind"] = {t=0.0, d=10.0};
		--["Disarm"] = {t=0.0, d=60.0};
		--["Taunt"] = {t=0.0, d=10.0};		
		
	}
	
	Carnival_EnemyCastBar_Raids = {
	
		-- Ahn'Qiraj
		
			-- 40 Man Trash
			["Obsidian Eradicator"] = {t=1800.0, c="cooldown"};
			
			-- 20 Man Trash
			["Explode"] = {t=6.0};
	
		-- Zul'Gurrub
		
			-- Hakkar
			["Blood Siphon"] = {t=90.0, c="cooldown", m="Hakkar", u="true"};
		
		-- Molten Core
		
			-- Lucifron
			["Impending Doom"] = {t=20.0, c="cooldown", m="Lucifron", u="true"};
			["Lucifron's Curse"] = {t=20.0, c="cooldown", m="Lucifron", u="true"};
		
			-- Magmadar
			["Panic"] = {t=30.0, c="cooldown", m="Magmadar", u="true"};

			-- Gehennas
			["Gehennas' Curse"] = {t=30.0, c="cooldown", m="Gehennas", u="true"};

			-- Majordomo
			["Magic Reflection"] = {t=30.0, i=10.0, c="cooldown", m="Majordomo", u="true"};
			["Damage Shield"] = {t=30.0, i=10.0, c="cooldown", m="Majordomo", u="true"};
			
			-- Ragnaros
			["Submerge"] = {t=180.0, c="cooldown"};
			["Knockback"] = {t=28.0, c="cooldown"};
			["Sons of Flame"] = {t=90.0, c="cooldown"};
			
		-- Blackwing Lair
				
			-- Firemaw/Flamegor/Ebonroc
			["Wing Buffet"] = {t=32.0, i=1.0, c="cooldown", u="true"};
			["Shadow Flame"] = {t=2.0, c="hostile"};
			
			-- Flamegor
			["Frenzy"] = {t=10.0, c="cooldown"};
			
			-- Chromaggus
			["Frost Burn"] = {t=60.0, i=2.0, c="cooldown"};
			["Time Lapse"] = {t=60.0, i=2.0, c="cooldown"};
			["Ignite Flesh"] = {t=60.0, i=2.0, c="cooldown"};
			["Corrosive Acid"] = {t=60.0, i=2.0, c="cooldown"};
			["Incinerate"] = {t=60.0, i=2.0, c="cooldown"};
			["Killing Frenzy"] = {t=15.0, c="cooldown"};
			
			-- Neferian/Onyxia
			["Bellowing Roar"] = {t=2.0, c="hostile", r="Onyxia", a=1.5, u="true"};
			
			-- Neferian			
			["Class Call"] = {t=30.0, c="cooldown"};
			["Mob Spawn"] = {t=10.0, c="hostile"};
			["Landing"] = {t=10.0, c="hostile"};
			
		-- Outdoor
		
			-- Azuregos
			["Manastorm"] = {t=10.0, c="hostile"};
		
	}
	
	Carnival_EnemyCastBar_RAGNAROS_STARTING			= "NOW FOR YOU,";
	Carnival_EnemyCastBar_RAGNAROS_KICKER			= "TASTE THE FLAMES";
	Carnival_EnemyCastBar_RAGNAROS_SONS	 			= "COME FORTH, MY SERVANTS!";
	
	Carnival_EnemyCastBar_FLAMEGOR_FRENZY			= "goes into a frenzy!";
	Carnival_EnemyCastBar_CHROMAGGUS_FRENZY			= "goes into a killing frenzy!";
	
	Carnival_EnemyCastBar_NEFARIAN_STARTING			= "Let the games begin!";
	Carnival_EnemyCastBar_NEFARIAN_LAND				= "Well done, my minions";
	Carnival_EnemyCastBar_NEFARIAN_SHAMAN_CALL		= "Shamans, show me";
	Carnival_EnemyCastBar_NEFARIAN_DRUID_CALL		= "Druids and your silly";
	Carnival_EnemyCastBar_NEFARIAN_WARLOCK_CALL		= "Warlocks, you shouldn't be playing";
	Carnival_EnemyCastBar_NEFARIAN_PRIEST_CALL		= "Priests! If you're going to keep";
	Carnival_EnemyCastBar_NEFARIAN_HUNTER_CALL		= "Hunters and your annoying";
	Carnival_EnemyCastBar_NEFARIAN_WARRIOR_CALL		= "Warriors, I know you can hit harder";
	Carnival_EnemyCastBar_NEFARIAN_ROGUE_CALL		= "Rogues";
	Carnival_EnemyCastBar_NEFARIAN_PALADIN_CALL		= "Paladins";
	Carnival_EnemyCastBar_NEFARIAN_MAGE_CALL		= "Mages";
	
	Carnival_EnemyCastBar_MOB_DIES					= "(.+) dies."
	Carnival_EnemyCastBar_SPELL_GAINS 				= "(.+) gains (.+)."
	Carnival_EnemyCastBar_SPELL_CAST 				= "(.+) begins to cast (.+)."
	Carnival_EnemyCastBar_SPELL_PERFORM				= "(.+) begins to perform (.+)."
	Carnival_EnemyCastBar_SPELL_CASTS				= "(.+) casts (.+)."
	Carnival_EnemyCastBar_SPELL_AFFLICTED			= "(.+) (.+) afflicted by (.+).";
	Carnival_EnemyCastBar_SPELL_DAMAGE 				= "(.+) suffers (.+) from (.+) (.+)";

end
