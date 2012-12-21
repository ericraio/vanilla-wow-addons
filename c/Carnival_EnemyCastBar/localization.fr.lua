-- WARNING
-- THE COMMENTED OUT ABILITIES ARE THERE FOR A REASON
-- PLEASE DO NOT UNCOMMENT THEM, OTHERWISE THINGS WILL PROBABLY BREAK

if ( GetLocale() == "frFR" ) then

	Carnival_EnemyCastBar_Spells = {
	
		-- All Classes
			-- General
		["Pierre de foyer"] = {t=10.0};
		
			-- Trinkets & Racials
		["Sanctuaire"] = {t=20.0, c="gains"};
		["Pouvoir Instable"] = {t=20.0, c="gains"};
		["Force Sup\195\169rieure"] = {t=20.0, c="gains"};
		["Pouvoir \195\169ph\195\169m/195/168re"] = {t=15.0, c="gains"};
		["Puissance des Arcanes"] = {t=20.0, c="gains"};
		["Destruction Massive"] = {t=20.0, c="gains"};
		["Pouvoir des Arcanes"] = {t=20.0, c="gains"};
		["Energized Shield"] = {t=20.0, c="gains"}; -- ??
		["Brilliant Light"] = {t=20.0, c="gains"}; -- ??
		["Volont\195\169 des R\195\169prouv\195\169s"] = {t=5.0, c="gains"};
		["Perception"] = {t=20.0, c="gains"};
		["Choc martial"] = {t=1.5};
		["Forme de pierre"] = {t=8.0};
		["Gardien des T\195\169n/195/168bres"] = {t=1.5}; -- ??
		
			-- Engineering
		["Frost Reflector"] = {t=5.0, c="gains"};
		["Shadow Reflector"] = {t=5.0, c="gains"};
		["Fire Reflector"] = {t=5.0, c="gains"};
		
			-- First Aid
		["Premiers soins"] = {t=8.0, c="gains"};
		["Bandage en lin"] = {t=3.0};
		["Bandage \195\169pais en lin"] = {t=3.0};
		["Bandage en laine"] = {t=3.0};
		["Bandage \195\169pais en laine"] = {t=3.0};
		["Bandage en soie"] = {t=3.0};
		["Bandage \195\169pais en soie"] = {t=3.0};
		["Bandage en tissu de mage"] = {t=3.0};
		["Bandage \195\169pais en tissu de mage"] = {t=3.0};
		["Bandage en \195\169toffe runique"] = {t=3.0};
		["Bandage \195\169pais en \195\169toffe runique"] = {t=3.0};
		
		-- Druid
		["Toucher gu\195\169risseur"] = {t=3.0};
		["R\195\169tablissement"] = {t=2.0, g=21.0};
		["Renaissance"] = {t=2.0, d=1800.0};
		["Feu stellaire"] = {t=3.5};
		["Col/195/168re"] = {t=2.0};
		["Sarments"] = {t=2.0};
		["C\195\169l\195\169rit\195\169"] = {t=15.0, c="gains", d=300.0};
		["Hibernation"] = {t=1.5};
		["Apaiser les animaux"] = {t=1.5};
		["Ecorce"] = {t=15.0, i=0.0, c="gains"};
		["Innervation"] = {t=20.0, i=0.0, c="gains"};
		["T\195\169l\195\169portation : Moonglade"] = {t=10.0}; -- ??
		["Fureur du tigre"] = {t=6.0, c="gains"};
		["R\195\169g\195\169n\195\169ration fr\195\169n\195\169tique"] = {t=10.0, c="gains", d=180.0};
		["R\195\169cup\195\169ration"] = {t=12.0, c="gains"};
		["Abolir le poison"] = {t=8.0, c="gains"};
		--["Ouragan"] = {t=10.0, d=60.0};
		--["Tranquilit\195\169"] = {t=10.0, d=300.0};
		
		-- Hunter
		["Vis\195\169e"] = {t=3.0, d=6.0};
		["Effrayer une b\195\170te"] = {t=1.0, d=30.0};
		["Salve"] = {t=6.0, d=60.0};
		["Renvoyer le familier"] = {t=5.0};
		["Ressusciter le familier"] = {t=10.0};
		["Oeil de la b\195\170te"] = {t=2.0};
		["Tir rapide"] = {t=15.0, c="gains", d=300.0};
		--["Fl/195/168ches multiples"] = {t=0.0, d=10.0};
		--["Piq\195\187re de wyverne"] = {t=0.0, d=120.0};
		--["Tir des arcanes"] = {t=0.0, d=6.0};
		--["Trait provocateur"] = {t=0.0, d=8.0};
		
		-- Mage
		["Eclair de givre"] = {t=2.5};
		["Boule de feu"] = {t=3.0};
		["Invocation d'eau"] = {t=3.0};
		["Invocation de nourriture"] = {t=3.0};
		["Invocation d'un rubis de mana"] = {t=3.0};
		["Invocation d'une citrine de mana"] = {t=3.0};
		["Invocation d'une jade de mana"] = {t=3.0};
		["Invocation d'une agate de mana"] = {t=3.0};
		["M\195\169tamorphose"] = {t=1.5};
		["Explosion pyrotechnique"] = {t=6.0, d=60.0};
		["Br\195\187lure"] = {t=1.5};
		["Choc de flammes"] = {t=3.0, r="Eveilleur Griffemort", a=2.5};
		["Chute lente"] = {t=30.0, c="gains"};
		["Portail : Darnassus"] = {t=10.0};
		["Portail : Thunder Bluff"] = {t=10.0};
		["Portail : Ironforge"] = {t=10.0};
		["Portail : Orgrimmar"] = {t=10.0};
		["Portail : Stormwind"] = {t=10.0};
		["Portail : Undercity"] = {t=10.0};
		["T\195\169l\195\169portation : Darnassus"] = {t=10.0};
		["T\195\169l\195\169portation : Thunder Bluff"] = {t=10.0};
		["T\195\169l\195\169portation : Ironforge"] = {t=10.0};
		["T\195\169l\195\169portation : Orgrimmar"] = {t=10.0};
		["T\195\169l\195\169portation : Stormwind"] = {t=10.0};
		["T\195\169l\195\169portation : Undercity"] = {t=10.0};
		["Gardien de feu"] = {t=30.0, c="gains"};
		["Gardien de givre"] = {t=30.0, c="gains"};
		["Parade de glace"] = {t=10.0, c="gains"};
		--["Vague d'explosions"] = {t=0.0, d=45.0};
		--["Barri/195/168re de glace"] = {t=0.0, d=120.0};
		--["C\195\180ne de froid"] = {t=0.0, d=120.0};
		--["Trait de feu"] = {t=0.0, d=8.0};
		--["Nova de givre"] = {t=0.0, d=25.0};
		--["Contresort"] = {t=0.0, d=30.0};
		--["Transfert"] = {t=0.0, d=15.0};
		--["Parade de glace"] = {t=0.0, d=300.0};
		
		-- Paladin
		["Lumi/195/168re sacr\195\169e"] = {t=2.5};
		["Eclair lumineux"] = {t=1.5};
		["Invocation d'un destrier"] = {t=3.0, g=0.0}; -- ??
		["Invocation d'un Cheval de Guerre"] = {t=3.0, g=0.0}; -- ??
		["Marteau de courroux"] = {t=1.0, d=6.0};
		["Col/195/168re divine"] = {t=2.0, d=60.0};
		["Renvoi des morts-vivants"] = {t=1.5, d=30.0};
		["R\195\169demption"] = {t=10.0};
		["Protection divine"] = {t=8.0, c="gains", d=300.0};
		["Bouclier divin"] = {t=12.0, c="gains", d=300.0};
		["Sceau de libert\195\169"] = {t=16.0, c="gains"};
		["Sceau de protection"] = {t=10.0, c="gains"};
		["Blessing of Sacrifice"] = {t=30.0, c="gains"};
		--["Cons\195\169cration"] = {t=0.0, d=8.0};
		--["Exorcisme"] = {t=0.0, d=15.0};
		--["Marteau de la justice"] = {t=0.0, d=60.0};
		--["Imposition des mains"] = {t=0.0, d=3600.0};
		--["B\195\169n\195\169diction de protection"] = {t=0.0, d=300.0};
		
		-- Priest
		["Soins sup\195\169rieurs"] = {t=3.0};
		["Soins rapides"] = {t=1.5};
		["R\195\169surrection"] = {t=10.0};
		["Ch\195\162timent"] = {t=2.5};
		["Attaque mentale"] = {t=1.5, d=8.0};
		["Contr\195\180le mental"] = {t=3.0};
		["Br\195\187lure de mana"] = {t=3.0};
		["Feu int\195\169rieur"] = {t=4.0, d=15.0};
		["Apaisement"] = {t=1.5};
		["Pri/195/168re de soins"] = {t=3.0};
		["Entraves des morts-vivants"] = {t=1.5};
		["Oubli"] = {t=10.0, c="gains", d=30.0};
		["R\195\169novation"] = {t=15.0, c="gains"};
		["Abolir maladie"] = {t=20.0, c="gains"};
		--["Mot de pouvoir : Bouclier"] = {t=0.0, d=4.0};
		--["Peste d\195\169vorante"] = {t=0.0, d=180.0};
		--["Nova sacr\195\169e"] = {t=0.0, d=30.0};
		--["Pri/195/168re du d\195\169sespoir"] = {t=0.0, d=1800.0};
		--["Cri psychique"] = {t=0.0, d=30.0};
		
		-- Rogue
		["D\195\169sarmement de pi/195/168ge"] = {t=5.0};
		["Sprint"] = {t=15.0, c="gains", d=300.0};
		["Poison de distraction mentale"] = {t=3.0};
		["Poison de distraction mentale II"] = {t=3.0};
		["Poison de distraction mentale III"] = {t=3.0};
		["Crochetage"] = {t=5.0};
		["Evasion"] = {t=15.0, c="gains"};
		--["C\195\169cit\195\169"] = {t=0.0, d=300.0};
		--["Suriner"] = {t=0.0, d=10.0};
		--["Feinte"] = {t=0.0, d=10.0};
		--["Coup de pied"] = {t=0.0, d=10.0};
		--["Aiguillon perfide"] = {t=0.0, d=20.0};
		
		-- Shaman
		["Vague de soins inf\195\169rieurs"] = {t=1.5};
		["Vague de soins"] = {t=3.0};
		["Esprit ancestral"] = {t=10.0};
		["Cha\195\174ne d'\195\169clairs"] = {t=2.5, d=6.0};
		["Loup fant\195\180me"] = {t=3.0};
		["Rappel astral"] = {t=10.0};
		["Salve de gu\195\169rison"] = {t=2.5};
		["Eclair"] = {t=3.0};
		["Double vue"] = {t=2.0};
		["Totem de Griffes de pierre"] = {t=15.0, c="gains", d=30.0};
		["Totem Fontaine de mana"] = {t=15.0, c="gains", d=300.0};
		["Totem Nova de feu"] = {t=5.0, c="gains", d=15.0};
		--["Horion de terre"] = {t=0.0, d=6.0};
		--["Horion de givre"] = {t=0.0, d=6.0};
		--["Horion de flammes"] = {t=0.0, d=6.0};
		--["Totem de Gl/195/168be"] = {t=0.0, d=15.0};
		
		-- Warlock
		["Trait de l'ombre"] = {t=2.5};
		["Immolation"] = {t=1.5};
		["Feu de l'\195\162me"] = {t=4.0, d=60.0};
		["Douleur br\195\187lante"] = {t=1.5};
		["Invocation d'un Destrier de l'Effroi"] = {t=3.0, g=0.0}; -- ??
		["Invocation d'un palefroi corrompu"] = {t=3.0, g=0.0};
		["Invocation d'un diablotin"] = {t=6.0};
		["Invocation d'une succube"] = {t=6.0};
		["Invocation d'un marcheur du Vide"] = {t=6.0};
		["Invocation d'un chasseur corrompu"] = {t=6.0};
		["Peur"] = {t=1.5};
		["Hurlement de terreur"] = {t=2.0, d=40.0, g=0.0};
		["Bannir"] = {t=1.5};
		["Rituel d'invocation"] = {t=5.0};
		["Rituel de mal\195\169diction"] = {t=10.0};
		["Cr\195\169ation de Pierre de sort"] = {t=5.0};
		["Cr\195\169ation de Pierre d'\195\162me"] = {t=3.0};
		["Cr\195\169ation de Pierre de soin"] = {t=3.0};
		["Cr\195\169ation de Pierre de feu"] = {t=3.0};
		["Asservir d\195\169mon"] = {t=3.0};
		["Infernal"] = {t=2.0, d=3600.0};
		["Gardien de l'ombre"] = {t=30.0, c="gains"};
		--["Conflagration"] = {t=0.0, d=10.0};
		--["Voile mortel"] = {t=0.0, d=120.0};
		--["Br\195\187lure de l'ombre"] = {t=0.0, d=15.0};

			-- Imp
			["Eclair de Feu"] = {t=1.5};
			
			-- Succubus
			["S\195\169duction"] = {t=1.5};
			["Baiser apaisant"] = {t=4.0, d=4.0};
			--["Fouet de la douleur"] = {t=0.0, d=6.0};
			
			-- Felhunter
			--["Festin magique"] = {t=0.0, d=8.0};
			--["Verrou magique"] = {t=0.0, d=30.0};
			
			-- Voidwalker
			["Consumer les ombres"] = {t=10.0, c="gains"};
		
		-- Warrior
		["Rage sanguinaire"] = {t=10.0, c="gains"};
		["Sanguinaire"] = {t=8.0, c="gains", d=6.0};
		["Mur protecteur"] = {t=10.0, c="gains", d=1800.0};
		["T\195\169m\195\169rit\195\169"] = {t=15.0, c="gains", d=1800.0};
		["Repr\195\169sailles"] = {t=15.0, c="gains", d=1800.0};
		["Rage berserker"] = {t=10.0, c="gains"};
		["Heurtoir"] = {t=1.0, c="gains"};
		--["Vengeance"] = {t=0.0, d=5.0};
		--["Coup de bouclier"] = {t=0.0, d=6.0};
		--["Fulgurance"] = {t=0.0, d=5.0};
		--["Frappe mortelle"] = {t=0.0, d=6.0};
		--["Vol\195\169e de coups"] = {t=0.0, d=10.0};
		--["Coup de tonnerre"] = {t=0.0, d=4.0};
		--["Coup railleur"] = {t=0.0, d=120.0};
		--["Interception"] = {t=0.0, d=30.0};
		--["Charge"] = {t=0.0, d=15.0};
		--["Tourbillon"] = {t=0.0, d=10.0};
		--["D\195\169sarmement"] = {t=0.0, d=60.0};
		--["Provocation"] = {t=0.0, d=10.0};		
		
	}
	
	Carnival_EnemyCastBar_Raids = {
	
		-- Ahn'Qiraj
		
			-- 40 Man Trash
			["Obsidian Eradicator"] = {t=1800.0, c="cooldown"};
			
			-- 20 Man Trash
			["Explode"] = {t=6.0};
	
		-- Zul'Gurrub
		
			-- Hakkar
			["Blood Siphon"] = {t=90.0, c="cooldown", m="Hakkar", u="true"}; -- ??
		
		-- Molten Core
		
			-- Lucifron
			["Impending Doom"] = {t=20.0, c="cooldown", m="Lucifron", u="true"}; -- ??
			["Lucifron's Curse"] = {t=20.0, c="cooldown", m="Lucifron", u="true"}; -- ??
		
			-- Magmadar
			["Panic"] = {t=30.0, c="cooldown", m="Magmadar", u="true"}; -- ??

			-- Gehennas
			["Gehennas' Curse"] = {t=30.0, c="cooldown", m="Gehennas", u="true"}; -- ??

			-- Majordomo
			["Magic Reflection"] = {t=30.0, i=10.0, c="cooldown", m="Majordomo", u="true"}; -- ??
			["Damage Shield"] = {t=30.0, i=10.0, c="cooldown", m="Majordomo", u="true"}; -- ??
			
			-- Ragnaros
			["Submerge"] = {t=180.0, c="cooldown"}; -- ??
			["Knockback"] = {t=28.0, c="cooldown"}; -- ??
			["Sons of Flame"] = {t=90.0, c="cooldown"}; -- ??
			
		-- Blackwing Lair
				
			-- Firemaw/Flamegor/Ebonroc
			["Frappe des ailes"] = {t=32.0, i=1.0, c="cooldown", u="true"}; 
			["Flamme d'ombre"] = {t=2.0, c="hostile"}; 
			
			-- Flamegor
			["Frenzy"] = {t=10.0, c="cooldown"};
			
			-- Chromaggus
			["Br\195\187lure de givre"] = {t=60.0, i=2.0, c="cooldown"};
			["Trou de temps"] = {t=60.0, i=2.0, c="cooldown"}; 
			["Enflammer la chair"] = {t=60.0, i=2.0, c="cooldown"}; 
			["Acide corrosif"] = {t=60.0, i=2.0, c="cooldown"};
			["Incin\195\169rer"] = {t=60.0, i=2.0, c="cooldown"};
			["Killing Frenzy"] = {t=15.0, c="cooldown"};
			
			-- Neferian/Onyxia
			["Rugissement puissant"] = {t=2.0, c="hostile", r="Onyxia", a=1.5, u="true"};
			
			-- Neferian			
			["Class Call"] = {t=33.0, c="cooldown"}; -- ??
			["Mob Spawn"] = {t=10.0, c="hostile"}; -- ??
			["Landing"] = {t=10.0, c="hostile"};
			
		-- Outdoor
		
			-- Azuregos
			["Manastorm"] = {t=10.0, c="hostile"};
		
	}
	
	Carnival_EnemyCastBar_RAGNAROS_STARTING			= "NOW FOR YOU,"; -- ??
	Carnival_EnemyCastBar_RAGNAROS_KICKER			= "TASTE THE FLAMES"; -- ??
	Carnival_EnemyCastBar_RAGNAROS_SONS	 			= "COME FORTH, MY SERVANTS!"; -- ??
	
	Carnival_EnemyCastBar_FLAMEGOR_FRENZY			= "Flamegor est pris de fr195169n195169sie !";
	Carnival_EnemyCastBar_CHROMAGGUS_FRENZY			= "entre dans une sanglante fr195169n195169sie !";
	
	Carnival_EnemyCastBar_NEFARIAN_STARTING			= "Let the games begin!"; -- ??
	Carnival_EnemyCastBar_NEFARIAN_LAND				= "Well done, my minions"; -- ??
	Carnival_EnemyCastBar_NEFARIAN_SHAMAN_CALL		= "Shamans, show me"; -- ??
	Carnival_EnemyCastBar_NEFARIAN_DRUID_CALL		= "Druids and your silly"; -- ??
	Carnival_EnemyCastBar_NEFARIAN_WARLOCK_CALL		= "Warlocks, you shouldn't be playing"; -- ??
	Carnival_EnemyCastBar_NEFARIAN_PRIEST_CALL		= "Priests! If you're going to keep"; -- ??
	Carnival_EnemyCastBar_NEFARIAN_HUNTER_CALL		= "Hunters and your annoying"; -- ??
	Carnival_EnemyCastBar_NEFARIAN_WARRIOR_CALL		= "Warriors, I know you can hit harder"; -- ??
	Carnival_EnemyCastBar_NEFARIAN_ROGUE_CALL		= "Rogues"; -- ??
	Carnival_EnemyCastBar_NEFARIAN_PALADIN_CALL		= "Paladins"; -- ??
	Carnival_EnemyCastBar_NEFARIAN_MAGE_CALL		= "Mages"; -- ??
	
	Carnival_EnemyCastBar_MOB_DIES					= "(.+) meurt."
	Carnival_EnemyCastBar_SPELL_GAINS 				= "(.+) gagne (.+)."
	Carnival_EnemyCastBar_SPELL_CAST 				= "(.+) commence \195\160 lancer (.+)."
	Carnival_EnemyCastBar_SPELL_PERFORM				= "(.+) commence \195\160 ex\195\169cuter (.+)."
	Carnival_EnemyCastBar_SPELL_CASTS				= "(.+) lance (.+)."
	Carnival_EnemyCastBar_SPELL_AFFLICTED			= "(.+) (.+) subit les effets de (.+).";
	Carnival_EnemyCastBar_SPELL_DAMAGE 				= "(.+) suffers (.+) from (.+) (.+)"; -- ??

end
