-- WARNING
-- THE COMMENTED OUT ABILITIES ARE THERE FOR A REASON
-- PLEASE DO NOT UNCOMMENT THEM, OTHERWISE THINGS WILL PROBABLY BREAK

if ( GetLocale() == "deDE" ) then

	Carnival_EnemyCastBar_Spells = {
	
		-- All Classes
			-- General
		["Ruhestein"] = {t=10.0};
		
			-- Trinkets & Racials
		["Spr\195\182der R\195\188stung"] = {t=20.0, c="gains"};
		["Instabile Macht"] = {t=20.0, c="gains"};
		["Ruhelose St\195\164rke"] = {t=20.0, c="gains"};
		["Ephemere Macht"] = {t=15.0, c="gains"};
		["Arkane Macht"] = {t=20.0, c="gains"};
		["Massive Zerst\195\182rung"] = {t=20.0, c="gains"};
		["Arkane Kraft"] = {t=20.0, c="gains"};
		["Energiegeladener Schild"] = {t=20.0, c="gains"};
		["Glei\195\159endes Licht"] = {t=20.0, c="gains"};
		["Wille der Vergessenen"] = {t=5.0, c="gains"};
		["Wahrnehmung"] = {t=20.0, c="gains"};
		["Kriegsstampfen"] = {t=1.5};
		["Steinform"] = {t=8.0};
		["Schattenschild"] = {t=1.5};
		
			-- Engineering
		["Frostreflektor"] = {t=5.0, c="gains"};
		["Schattenreflektor"] = {t=5.0, c="gains"};
		["Feuerreflektor"] = {t=5.0, c="gains"};
		
			-- First Aid
		["Erste Hilfe"] = {t=8.0, c="gains"};
		["Leinenstoffverband"] = {t=3.0};
		["Schwerer Leinenstoffverband"] = {t=3.0};
		["Wollstoffverband"] = {t=3.0};
		["Schwerer Wollstoffverband"] = {t=3.0};
		["Seidenstoffverbannt"] = {t=3.0};
		["Schwerer Seidenstoffverband"] = {t=3.0};
		["Magiestoffverbannt"] = {t=3.0};
		["Schwerer Magiestoffverband"] = {t=3.0};
		["Runenstoffverband"] = {t=3.0};
		["Schwerer Runenstoffverband"] = {t=3.0};
		
		-- Druid
		["Heilende Ber\195\188hrung"] = {t=3.0};
		["Nachwachsen"] = {t=2.0, g=21.0};
		["Wiedergeburt"] = {t=2.0, d=1800.0};
		["Sternenfeuer"] = {t=3.5};
		["Zorn"] = {t=2.0};
		["Wucherwurzeln"] = {t=2.0};
		["Spurt"] = {t=15.0, c="gains", d=300.0};
		["Winterschlaf"] = {t=1.5};
		["Tier bes\195\164nftigen"] = {t=1.5};
		["Baumrinde"] = {t=15.0, i=0.0, c="gains"};
		["Anregen"] = {t=20.0, i=0.0, c="gains"};
		["Teleportieren: Moonglade"] = {t=10.0};
		["Tigerfuror"] = {t=6.0, c="gains"};
		["Rasende Regeneration"] = {t=10.0, c="gains", d=180.0};
		["Verj\195\188ngung"] = {t=12.0, c="gains"};
		["Vergiftung aufheben"] = {t=8.0, c="gains"};
		--["Hurrikan"] = {t=10.0, d=60.0};
		--["Gelassenheit"] = {t=10.0, d=300.0};
		
		-- Hunter
		["Gezielter Schuss"] = {t=3.0, d=6.0};
		["Wildtier \195\164ngstigen"] = {t=1.0, d=30.0};
		["Salve"] = {t=6.0, d=60.0};
		["Tier freigeben"] = {t=5.0};
		["Tier wiederbeleben"] = {t=10.0};
		["Augen des Wildtiers"] = {t=2.0};
		["Schnellfeuer"] = {t=15.0, c="gains", d=300.0};
		--["Mehrfachschuss"] = {t=0.0, d=10.0};
		--["Stich des Fl\195\188geldrachen"] = {t=0.0, d=120.0};
		--["Arkaner Schuss"] = {t=0.0, d=6.0};
		--["Ablenkender Schuss"] = {t=0.0, d=8.0};
		
		-- Mage
		["Frostblitz"] = {t=2.5};
		["Feuerball"] = {t=3.0};
		["Wasser herbeizaubern"] = {t=3.0};
		["Essen herbeizaubern"] = {t=3.0};
		["Mana-Rubin herbeizaubern"] = {t=3.0};
		["Mana-Citrin herbeizaubern"] = {t=3.0};
		["Mana-Jade herbeizaubern"] = {t=3.0};
		["Mana-Achat herbeizaubern"] = {t=3.0};
		["Verwandlung"] = {t=1.5};
		["Pyroschlag"] = {t=6.0, d=60.0};
		["Versenegen"] = {t=1.5};
		["Flammensto\195\159"] = {t=3.0, r="Brutw\195\164chter der Todeskrallen", a=2.5};
		["Langsamer Fall"] = {t=30.0, c="gains"};
		["Portal: Darnassus"] = {t=10.0};
		["Portal: Thunder Bluff"] = {t=10.0};
		["Portal: Ironforge"] = {t=10.0};
		["Portal: Orgrimmar"] = {t=10.0};
		["Portal: Stormwind"] = {t=10.0};
		["Portal: Undercity"] = {t=10.0};
		["Teleportieren: Darnassus"] = {t=10.0};
		["Teleportieren: Thunder Bluff"] = {t=10.0};
		["Teleportieren: Ironforge"] = {t=10.0};
		["Teleportieren: Orgrimmar"] = {t=10.0};
		["Teleportieren: Stormwind"] = {t=10.0};
		["Teleportieren: Undercity"] = {t=10.0};
		["Feuer-Zauberschutz"] = {t=30.0, c="gains"};
		["Frost-Zauberschutz"] = {t=30.0, c="gains"};
		["Eisblock"] = {t=10.0, c="gains"};
		--["Druckwelle"] = {t=0.0, d=45.0};
		--["Eis-Barriere"] = {t=0.0, d=120.0};
		--["KÃ¤ltekegel"] = {t=0.0, d=120.0};
		--["Feuerschlag"] = {t=0.0, d=8.0};
		--["Frostnova"] = {t=0.0, d=25.0};
		--["Gegenzauber"] = {t=0.0, d=30.0};
		--["Blinzeln"] = {t=0.0, d=15.0};
		--["Eisblock"] = {t=0.0, d=300.0};
		
		-- Paladin
		["Heiliges Licht"] = {t=2.5};
		["Lichtblitz"] = {t=1.5};
		["Streitross beschw\195\182ren"] = {t=3.0, g=0.0};
		["Schlachtross beschw\195\182ren"] = {t=3.0, g=0.0};
		["Hammer des Zorns"] = {t=1.0, d=6.0};
		["Heiliger Zorn"] = {t=2.0, d=60.0};
		["Untote vertreiben"] = {t=1.5, d=30.0};
		["Erl\195\182sung"] = {t=10.0};
		["G\195\182ttlicher Schutz"] = {t=8.0, c="gains", d=300.0};
		["Gottesschild"] = {t=12.0, c="gains", d=300.0};
		["Segen der Freiheit"] = {t=16.0, c="gains"};
		["Segen des Schutzes"] = {t=10.0, c="gains"};
		["Segen der Opferung"] = {t=30.0, c="gains"};
		--["Weihe"] = {t=0.0, d=8.0};
		--["Exorzismus"] = {t=0.0, d=15.0};
		--["Hammer der Gerechtigkeit"] = {t=0.0, d=60.0};
		--["Handauflegung"] = {t=0.0, d=3600.0};
		--["Segen des Schutzes"] = {t=0.0, d=300.0};
		
		-- Priest
		["Gro\195\159e Heilung"] = {t=3.0};
		["Blitzheilung"] = {t=1.5};
		["Auferstehung"] = {t=10.0};
		["G\195\182ttliche Pein"] = {t=2.5};
		["Gedankenschlag"] = {t=1.5, d=8.0};
		["Gedankenkontrolle"] = {t=3.0};
		["Manabrand"] = {t=3.0};
		["Heiliges Feuer"] = {t=4.0, d=15.0};
		["Gedankenbes\195\164nftigung"] = {t=1.5};
		["Gebet der Heilung"] = {t=3.0};
		["Untote Fesseln"] = {t=1.5};
		["Verblassen"] = {t=10.0, c="gains", d=30.0};
		["Erneuerung"] = {t=15.0, c="gains"};
		["Krankheit aufheben"] = {t=20.0, c="gains"};
		--["Machtwort: Schild"] = {t=0.0, d=4.0};
		--["Verschlingende Seuche"] = {t=0.0, d=180.0};
		--["Heilige Nova"] = {t=0.0, d=30.0};
		--["Verzweifeltes Gebet"] = {t=0.0, d=1800.0};
		--["Psychischer Schrei"] = {t=0.0, d=30.0};
		
		-- Rogue
		["Falle entsch\195\164rfen"] = {t=5.0};
		["Sprinten"] = {t=15.0, c="gains", d=300.0};
		["Gedankenbenebelndes Gift"] = {t=3.0};
		["Gedankenbenebelndes Gift II"] = {t=3.0};
		["Gedankenbenebelndes Gift III"] = {t=3.0};
		["Schloss knacken"] = {t=5.0};
		["Entrinnen"] = {t=15.0, c="gains"};
		--["Blenden"] = {t=0.0, d=300.0};
		--["Solarplexus"] = {t=0.0, d=10.0};
		--["Finte"] = {t=0.0, d=10.0};
		--["Tritt"] = {t=0.0, d=10.0};
		--["Nierenhieb"] = {t=0.0, d=20.0};
		
		-- Shaman
		["Geringe Welle der Heilung"] = {t=1.5};
		["Welle der Heilung"] = {t=3.0};
		["Geist der Ahnen"] = {t=10.0};
		["Kettenblitzschlag"] = {t=2.5, d=6.0};
		["Geisterwolf"] = {t=3.0};
		["Astraler R\195\188ckruf"] = {t=10.0};
		["Kettenheilung"] = {t=2.5};
		["Blitzschlag"] = {t=3.0};
		["Fernsicht"] = {t=2.0};
		["Totem der Steinklaue"] = {t=15.0, c="gains", d=30.0};
		["Totem der Manaflut"] = {t=15.0, c="gains", d=300.0};
		["Totem der Feuernova"] = {t=5.0, c="gains", d=15.0};
		--["Erdschock"] = {t=0.0, d=6.0};
		--["Frostschock"] = {t=0.0, d=6.0};
		--["Flammenschock"] = {t=0.0, d=6.0};
		--["Totem der Erdung"] = {t=0.0, d=15.0};
		
		-- Warlock
		["Schattenblitz"] = {t=2.5};
		["Feuerbrand"] = {t=1.5};
		["Seelenfeuer"] = {t=4.0, d=60.0};
		["Sengender Schmerz"] = {t=1.5};
		["Schreckensross herbeirufen"] = {t=3.0, g=0.0};
		["Teufelsross beschw\195\182ren"] = {t=3.0, g=0.0};
		["Wichtel beschw\195\182ren"] = {t=6.0};
		["Sukkubus beschw\195\182ren"] = {t=6.0};
		["Leerwandler beschw\195\182ren"] = {t=6.0};
		["Teufelsj\195\164ger beschw\195\182ren"] = {t=6.0};
		["Furcht"] = {t=1.5};
		["Schreckgeheul"] = {t=2.0, d=40.0};
		["Verbannen"] = {t=1.5};
		["Ritual der Beschw\195\182rung"] = {t=5.0};
		["Ritual der Verdammnis"] = {t=10.0};
		["Zauberstein herstellen"] = {t=5.0};
		["Seelenstein herstellen"] = {t=3.0};
		["Gesundheitsstein herstellen"] = {t=3.0};
		["Feuerstein herstellen"] = {t=3.0};
		["D\195\164monensklave"] = {t=3.0};
		["Inferno"] = {t=2.0, d=3600.0};
		["Schatten-Zauberschutz"] = {t=30.0, c="gains"};
		--["Feuersbrunst"] = {t=0.0, d=10.0};
		--["Todesmantel"] = {t=0.0, d=120.0};
		--["Schattenbrand"] = {t=0.0, d=15.0};

			-- Imp
			["Feuerblitz"] = {t=1.5};
			
			-- Succubus
			["Verf\195\188hrung"] = {t=1.5};
			["Bes\195\164nftigender Kuss"] = {t=4.0, d=4.0};
			--["Schmerzenspeitsche"] = {t=0.0, d=6.0};
			
			-- Felhunter
			--["Magie verschlingen"] = {t=0.0, d=8.0};
			--["Festzaubern"] = {t=0.0, d=30.0};
			
			-- Voidwalker
			["Schatten verzehren"] = {t=10.0, c="gains"};
		
		-- Warrior
		["Blutrausch"] = {t=10.0, c="gains"};
		["Blutdurst"] = {t=8.0, c="gains", d=6.0};
		["Schildwall"] = {t=10.0, c="gains", d=1800.0};
		["Tollk\195\188hnheit"] = {t=15.0, c="gains", d=1800.0};
		["Gegenschlag"] = {t=15.0, c="gains", d=1800.0};
		["Berserkerwut"] = {t=10.0, c="gains"};
		["Zerschmettern"] = {t=1.0, c="gains"};
		--["Rache"] = {t=0.0, d=5.0};
		--["Schildschlag"] = {t=0.0, d=6.0};
		--["\195\188berw\195\164ltigen"] = {t=0.0, d=5.0};
		--["T\195\182dlicher Sto\195\159"] = {t=0.0, d=6.0};
		--["Zuschlagen"] = {t=0.0, d=10.0};
		--["Donnerknall"] = {t=0.0, d=4.0};
		--["Sp\195\182ttischer Schlag"] = {t=0.0, d=120.0};
		--["Abfangen"] = {t=0.0, d=30.0};
		--["Sturmangriff"] = {t=0.0, d=15.0};
		--["Wirbelwind"] = {t=0.0, d=10.0};
		--["Entwaffnen"] = {t=0.0, d=60.0};
		--["Spott"] = {t=0.0, d=10.0};
		
	}
	
	Carnival_EnemyCastBar_Raids = {
	
		-- Ahn'Qiraj
		
			-- 40 Man Trash
			["Obsidian Eradicator"] = {t=1800.0, c="cooldown"};
			
			-- 20 Man Trash
			["Explodieren"] = {t=6.0};		
		
		-- Zul'Gurrub
		
			-- Hakkar
			["Bluttrinker"] = {t=90.0, c="cooldown", m="Hakkar", u="true"};
		
		-- Molten Core
		
			-- Lucifron
			["Drohende Verdammnis"] = {t=20.0, c="cooldown", m="Lucifron", u="true"};
			["Lucifrons Fluch"] = {t=20.0, c="cooldown", m="Lucifron", u="true"};
		
			-- Magmadar
			["Panik"] = {t=30.0, c="cooldown", m="Magmadar", u="true"};

			-- Gehennas
			["Gehennas Fluch"] = {t=30.0, c="cooldown", m="Gehennas", u="true"};

			-- Majordomo
			["Magie reflektieren"] = {t=30.0, i=10.0, c="cooldown", m="Majordomo", u="true"};
			["Schadensschild"] = {t=30.0, i=10.0, c="cooldown", m="Majordomo", u="true"};
			
			-- Ragnaros
			["Submerge"] = {t=180.0, c="cooldown"};
			["Knockback"] = {t=28.0, c="cooldown"};
			["Sons of Flame"] = {t=90.0, c="cooldown"};
			
		-- Blackwing Lair
				
			-- Firemaw/Flamegor/Ebonroc
			["Fl\195\188gelpuffer"] = {t=32.0, i=1.0, c="cooldown", u="true"};
			["Schattenflamme"] = {t=2.0, c="hostile"};
			
			-- Flamegor
			["Frenzy"] = {t=10.0, c="cooldown"};
			
			-- Chromaggus
			["Frostbeulen"] = {t=60.0, i=2.0, c="cooldown"};
			["Zeitraffer"] = {t=60.0, i=2.0, c="cooldown"};
			["Fleisch entz\195\188nden"] = {t=60.0, i=2.0, c="cooldown"};
			["\195\164tzende S\195\164ure"] = {t=60.0, i=2.0, c="cooldown"};
			["Verbrennen"] = {t=60.0, i=2.0, c="cooldown"};
			["Killing Frenzy"] = {t=15.0, c="cooldown"};
			
			-- Neferian/Onyxia
			["Dr\195\182hnendes Gebr\195\188ll"] = {t=2.0, c="hostile", r="Onyxia", a=1.5, u="true"};
			
			-- Neferian			
			["Class Call"] = {t=30.0, c="cooldown"};
			["Mob Spawn"] = {t=10.0, c="hostile"};
			["Landing"] = {t=10.0, c="hostile"};
			
		-- Outdoor
		
			-- Azuregos
			["Manasturm"] = {t=10.0, c="hostile"};
		
	}
	
	Carnival_EnemyCastBar_RAGNAROS_STARTING			= "UND JETZT ZU EUCH";
	Carnival_EnemyCastBar_RAGNAROS_KICKER			= "SP\195\156RT";
	Carnival_EnemyCastBar_RAGNAROS_SONS	 			= "VORW\195\164RTS,";
	
	Carnival_EnemyCastBar_FLAMEGOR_FRENZY			= "ger\195\164t in Raserei!";
	Carnival_EnemyCastBar_CHROMAGGUS_FRENZY			= "Chromaggus ger\195\164t in t\195\182dliche Raserei!";
	
	Carnival_EnemyCastBar_NEFARIAN_STARTING			= "Lasst die Spiele beginnen!";
	Carnival_EnemyCastBar_NEFARIAN_LAND				= "Sehr gut, meine Diener";
	Carnival_EnemyCastBar_NEFARIAN_SHAMAN_CALL		= "Schamanen";
	Carnival_EnemyCastBar_NEFARIAN_DRUID_CALL		= "Druiden und ihre l\195\164cherliche";
	Carnival_EnemyCastBar_NEFARIAN_WARLOCK_CALL		= "Hexenmeister, Ihr sollt nicht mit Magie";
	Carnival_EnemyCastBar_NEFARIAN_PRIEST_CALL		= "Priester! Wenn Ihr weiterhin";
	Carnival_EnemyCastBar_NEFARIAN_HUNTER_CALL		= "J\195\164ger und ihre l\195\164stigen";
	Carnival_EnemyCastBar_NEFARIAN_WARRIOR_CALL		= "Krieger, Ich bin mir";
	Carnival_EnemyCastBar_NEFARIAN_ROGUE_CALL		= "Schurken? Kommt aus";
	Carnival_EnemyCastBar_NEFARIAN_PALADIN_CALL		= "Paladine";
	Carnival_EnemyCastBar_NEFARIAN_MAGE_CALL		= "Auch Magier";
	
	Carnival_EnemyCastBar_MOB_DIES					= "(.+) stirbt."
	Carnival_EnemyCastBar_SPELL_GAINS 				= "(.+) bekommt (.+)."
	Carnival_EnemyCastBar_SPELL_CAST 				= "(.+) beginnt (.+) zu wirken."
	Carnival_EnemyCastBar_SPELL_PERFORM				= "(.+) beginnt (.+) herzustellen."
	Carnival_EnemyCastBar_SPELL_CASTS				= "(.+) beginnt (.+)."
	Carnival_EnemyCastBar_SPELL_AFFLICTED			= "(.+) (.+) betroffent von (.+).";
	Carnival_EnemyCastBar_SPELL_DAMAGE 				= "(.+) suffers (.+) from (.+) (.+)";--

end
