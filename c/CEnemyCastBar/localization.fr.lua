-- WARNING
-- THE COMMENTED OUT ABILITIES ARE THERE FOR A REASON
-- PLEASE DO NOT UNCOMMENT THEM, OTHERWISE THINGS WILL PROBABLY BREAK

if ( GetLocale() == "frFR" ) then

	CEnemyCastBar_Spells = {

		-- IMPORTANT: Maybe some spells which cause debuffs have to be moved to CEnemyCastBar_Afflicitions to be shown
		-- "g=0" prevents a bar if a player gains this spell. "g=x" shows a bar of x seconds instead of "t=x" if it's a gain.
		-- "i=x" shows a bar of x seconds additional to "t" (everytime)

		-- All Classes
			-- General
		["Pierre de foyer"] = {t=10.0, icontex="INV_Misc_Rune_01"};
		
			-- Trinkets & Racials
		["Armure fragile"] = 					{t=20.0, d=120, icontex="Spell_Shadow_GrimWard"}; -- gain
		["Pouvoir Instable"] = 					{t=20.0, d=120, icontex="Spell_Lightning_LightningBolt01"}; -- gain
		["Force Sup\195\169rieure"] = 				{t=20.0, d=120, icontex="Spell_Shadow_GrimWard"}; -- gain
		["Pouvoir \195\169ph\195\169m\195\168re"] = 		{t=15.0, d=90, icontex="Spell_Holy_MindVision"}; -- gain
		["Puissance des Arcanes"] = 				{t=15.0, d=180, icontex="Spell_Nature_Lightning"}; -- gain
		["Destruction Massive"] = 				{t=20.0, d=180, icontex="Spell_Fire_WindsofWoe"}; -- gain
		["Pouvoir des Arcanes"] = 				{t=20.0, d=180, icontex="Spell_Arcane_StarFire"}; -- gain
		["Bouclier dynamis\195\169"] = 				{t=20.0, d=180, icontex="Spell_Nature_CallStorm"}; -- gain
		["Lumi\195\168re \195\169clatante"] = 			{t=20.0, d=180, icontex="Spell_Holy_MindVision"}; -- gain
		["Volont\195\169 des R\195\169prouv\195\169s"] = 	{t=5.0, d=120, icontex="Spell_Shadow_RaiseDead"}; -- gain
		["Perception"] = 					{t=20.0, d=180, icontex="Spell_Nature_Sleep"}; -- gain
		["Acc\195\169l\195\169ration mentale de Mar'li"] = 	{t=30.0, d=180, icontex="INV_ZulGurubTrinket"}; -- gain
		["Choc martial"] = 					{t=0.5, d=120, icontex="Ability_WarStomp"};
		["Forme de pierre"] =					{t=8.0, d=180, icontex="Spell_Shadow_UnholyStrength"};
		["Garde de l'ombre"] = 					{t=1.5, icontex="Spell_Nature_LightningShield"};

		["Choc de terre"] = 					{t=20.0, d=120, icontex="Spell_Nature_AbolishMagic"}; -- gain
		["Don de vie"] = 					{t=20.0, d=300, icontex="INV_Misc_Gem_Pearl_05"}; -- gain
		["Alignement sur la nature"] = 				{t=20.0, d=300, icontex="Spell_Nature_SpiritArmor"}; -- gain

			-- Engineering
	        ["R\195\169flectogivre"] = 				{t=5.0, d=300.0, icontex="Spell_Frost_FrostWard"}; -- gain
	        ["R\195\169flectombre"] = 				{t=5.0, d=300.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
	        ["R\195\169flectofeu"] = 				{t=5.0, d=300.0, icontex="Spell_Fire_SealOfFire"}; -- gain

			-- First Aid
		["Premiers soins"] = 					{t=8.0, d=60, icontex="Spell_Holy_Heal"}; -- gain
		["Bandage en lin"] = 					{t=3.0, icontex="INV_Misc_Bandage_15"};
		["Bandage \195\169pais en lin"] = 			{t=3.0, icontex="INV_Misc_Bandage_18"};
		["Bandage en laine"] = 					{t=3.0, icontex="INV_Misc_Bandage_14"};
		["Bandage \195\169pais en laine"] = 			{t=3.0, icontex="INV_Misc_Bandage_17"};
		["Bandage en soie"] = 					{t=3.0, icontex="INV_Misc_Bandage_01"};
		["Bandage \195\169pais en soie"] = 			{t=3.0, icontex="INV_Misc_Bandage_02"};
		["Bandage en tissu de mage"] = 				{t=3.0, icontex="INV_Misc_Bandage_19"};
		["Bandage \195\169pais en tissu de mage"] = 		{t=3.0, icontex="INV_Misc_Bandage_20"};
		["Bandage en \195\169toffe runique"] = 			{t=3.0, icontex="INV_Misc_Bandage_11"};
		["Bandage \195\169pais en \195\169toffe runique"] = 	{t=3.0, icontex="INV_Misc_Bandage_12"};
		                                                                                                                      
		-- Druid                                                                                                              
		["Toucher gu\195\169risseur"] = 			{t=3.0, icontex="Spell_Nature_HealingTouch"};
		["R\195\169tablissement"] = 				{t=2.0, g=21.0, icontex="Spell_Nature_ResistNature"};
		["Renaissance"] = 					{t=2.0, d=1800.0, icontex="Spell_Nature_Reincarnation"};
		["Feu stellaire"] = 					{t=3.5, icontex="Spell_Arcane_StarFire"};
		["Col\195\168re"] = 					{t=2.0, icontex="Spell_Nature_AbolishMagic"};
		["Sarments"] = 						{t=1.5, icontex="Spell_Nature_StrangleVines"};
		["C\195\169l\195\169rit\195\169"] = 			{t=15.0, d=300.0, icontex="Ability_Druid_Dash"}; -- gain
		["Hibernation"] = 					{t=1.5, icontex="Spell_Nature_Sleep"};
		["Apaiser les animaux"] = 				{t=1.5, icontex="Ability_Hunter_BeastSoothe"};
		["Ecorce"] = 						{t=15.0, d=60, icontex="Spell_Nature_StoneClawTotem"}; -- gain
		["Innervation"] = 					{t=20.0, icontex="Spell_Nature_Lightning"}; -- gain
		["T\195\169l\195\169portation : Moonglade"] = 		{t=10.0, icontex="Spell_Arcane_TeleportMoonglade"};
		["Fureur du tigre"] = 					{t=6.0, icontex="Ability_Mount_JungleTiger"}; -- gain
["R\195\169g\195\169n\195\169ration fr\195\169n\195\169tique"] = 	{t=10.0, d=180.0, icontex="Ability_BullRush"}; -- gain
		["R\195\169cup\195\169ration"] = 			{t=12.0, icontex="Spell_Nature_Rejuvenation"}; -- gain
		["Abolir le poison"] = 					{t=8.0, icontex="Spell_Nature_NullifyPoison_02"}; -- gain

		["Tranquilit\195\169"] = 	{t=10.0, d=300.0, icontex="Spell_Nature_Tranquility"};
		
		-- Hunter                                                 
		["Vis\195\169e"] = 		{t=3.0, d=6.0, icontex="INV_Spear_07"};
		["Effrayer une b\195\170te"] = 	{t=1.0, d=30.0, icontex="Ability_Druid_Cower"};
		["Salve"] = 			{t=6.0, d=60.0, icontex="Ability_Marksmanship"};
		["Renvoyer le familier"] = 	{t=5.0, icontex="Spell_Nature_SpiritWolf"};
		["Ressusciter le familier"] = 	{t=10.0, icontex="Ability_Hunter_BeastSoothe"};
		["Oeil de la b\195\170te"] = 	{t=2.0, icontex="Ability_EyeOfTheOwl"};
		["Tir rapide"] = 		{t=15.0, d=300.0, icontex="Ability_Hunter_RunningShot"}; -- gain
		["Dissuasion"] = 		{t=10, d=300.0, icontex="Ability_Whirlwind"}; -- gain

		["Fl\195\168ches multiples"] = 	{d=10.0, icontex="Ability_UpgradeMoonGlaive"};


		-- Mage
		["Eclair de givre"] = {t=2.5, icontex="Spell_Frost_FrostBolt02"};
		["Boule de feu"] = {t=3.0, icontex="Spell_Fire_FlameBolt"};
		["Invocation d'eau"] = {t=3.0, icontex="INV_Drink_18"};
		["Invocation de nourriture"] = {t=3.0, icontex="INV_Misc_Food_33"};
		["Invocation d'un rubis de mana"] = {t=3.0, icontex="INV_Misc_Gem_Ruby_01"};
		["Invocation d'une citrine de mana"] = {t=3.0, icontex="INV_Misc_Gem_Opal_01"};
		["Invocation d'une jade de mana"] = {t=3.0, icontex="INV_Misc_Gem_Emerald_02"};
		["Invocation d'une agate de mana"] = {t=3.0, icontex="INV_Misc_Gem_Emerald_01"};
		["M\195\169tamorphose"] = {t=1.5, icontex="Spell_Nature_Polymorph"};
		["Explosion pyrotechnique"] = {t=6.0, d=60.0, icontex="Spell_Fire_Fireball02"};
		["Br\195\187lure"] = {t=1.5, icontex="Spell_Fire_SoulBurn"};
		["Choc de flammes"] = {t=3.0, r="Eveilleur Griffemort", a=2.5, icontex="Spell_Fire_SelfDestruct"};
		["Chute lente"] = {t=30.0, icontex="Spell_Magic_FeatherFall"}; -- gain
		["Portail : Darnassus"] = {t=10.0, icontex="Spell_Arcane_PortalDarnassus"};
		["Portail : Thunder Bluff"] = {t=10.0, icontex="Spell_Arcane_PortalThunderBluff"};
		["Portail : Ironforge"] = {t=10.0, icontex="Spell_Arcane_PortalIronForge"};
		["Portail : Orgrimmar"] = {t=10.0, icontex="Spell_Arcane_PortalOrgrimmar"};
		["Portail : Stormwind"] = {t=10.0, icontex="Spell_Arcane_PortalStormWind"};
		["Portail : Undercity"] = {t=10.0, icontex="Spell_Arcane_PortalUnderCity"};
		["T\195\169l\195\169portation : Darnassus"] = {t=10.0, icontex="Spell_Arcane_TeleportDarnassus"};
		["T\195\169l\195\169portation : Thunder Bluff"] = {t=10.0, icontex="Spell_Arcane_TeleportThunderBluff"};
		["T\195\169l\195\169portation : Ironforge"] = {t=10.0, icontex="Spell_Arcane_TeleportIronForge"};
		["T\195\169l\195\169portation : Orgrimmar"] = {t=10.0, icontex="Spell_Arcane_TeleportOrgrimmar"};
		["T\195\169l\195\169portation : Stormwind"] = {t=10.0, icontex="Spell_Arcane_TeleportStormWind"};
		["T\195\169l\195\169portation : Undercity"] = {t=10.0, icontex="Spell_Arcane_TeleportUnderCity"};
		["Gardien de feu"] = {t=30.0, icontex="Spell_Fire_FireArmor"}; -- gain
		["Gardien de givre"] = {t=30.0, icontex="Spell_Frost_FrostWard"}; -- gain
		["Evocation"] = {t=8.0, icontex="Spell_Nature_Purge"}; -- gain
		["Parade de glace"] = {t=10.0, d=300.0, icontex="Spell_Frost_Frost"}; -- gain
		["Pouvoir des arcanes"] = {t=15.0, d=180.0, icontex="Spell_Nature_Lightning"}; -- gain

		["Barri\195\168re de glace"] = {d=120.0, icontex="Spell_Ice_Lament"};
		["Transfert"] = {d=15.0, icontex="Spell_Arcane_Blink"};

		
		-- Paladin
		["Lumi\195\168re sacr\195\169e"] = {t=2.5, icontex="Spell_Holy_HolyBolt"};
		["Eclair lumineux"] = {t=1.5, icontex="Spell_Holy_FlashHeal"};
		["Invocation d'un destrier"] = {t=3.0, g=0.0, icontex="Ability_Mount_Charger"};
		["Invocation d'un Cheval de Guerre"] = {t=3.0, g=0.0, icontex="Spell_Nature_Swiftness"};
		["Marteau de courroux"] = {t=1.0, d=6.0, icontex="Ability_ThunderClap"};
		["Col\195\168re divine"] = {t=2.0, d=60.0, icontex="Spell_Holy_Excorcism"};
		["Renvoi des morts-vivants"] = {t=1.5, d=30.0, icontex="Spell_Holy_TurnUndead"};
		["R\195\169demption"] = {t=10.0, icontex="Spell_Holy_Resurrection"};
		["Protection divine"] = {t=8.0, d=300.0, icontex="Spell_Holy_Restoration"}; -- gain
		["Bouclier divin"] = {t=12.0, d=300.0, icontex="Spell_Holy_DivineIntervention"}; -- gain
		["Sceau de libert\195\169"] = {t=16.0, icontex="Spell_Holy_SealOfValor"}; -- gain
		["Sceau de protection"] = {t=10.0, d=300.0, icontex="Spell_Holy_SealOfProtection"}; -- gain
		["Blessing of Sacrifice"] = {t=30.0, icontex="Spell_Holy_SealOfSacrifice"}; -- gain
		["Vengeance"] = {t=8.0, icontex="Ability_Racial_Avatar"}; -- gain, Talent

		["Imposition des mains"] = {d=3600.0, icontex="Spell_Holy_LayOnHands"};

		
		-- Priest
		["Soins sup\195\169rieurs"] = {t=2.5, g=15, icontex="Spell_Holy_GreaterHeal"}; --!
		["Soins rapides"] = {t=1.5, icontex="Spell_Holy_FlashHeal"};
		["R\195\169surrection"] = {t=10.0, icontex="Spell_Holy_Resurrection"};
		["Ch\195\162timent"] = {t=2.0, icontex="Spell_Holy_HolySmite"}; --!
		["Attaque mentale"] = {t=1.5, d=8.0, icontex="Spell_Shadow_UnholyFrenzy"};
		["Contr\195\180le mental"] = {t=3.0, g=0.0, icontex="Spell_Shadow_ShadowWordDominate"};
		["Br\195\187lure de mana"] = {t=3.0, icontex="Spell_Shadow_ManaBurn"};
		["Feu int\195\169rieur"] = {t=3.0, icontex="Spell_Holy_SearingLight"}; --!
		["Apaisement"] = {t=1.5, icontex="Spell_Holy_MindSooth"};
		["Pri\195\168re de soins"] = {t=3.0, icontex="Spell_Holy_PrayerOfHealing02"};
		["Entraves des morts-vivants"] = {t=1.5, icontex="Spell_Nature_Slow"};
		["Oubli"] = {t=10.0, d=30.0, icontex="Spell_Magic_LesserInvisibilty"}; -- gain
		["R\195\169novation"] = {t=15.0, icontex="Spell_Holy_Renew"}; -- gain
		["Abolir maladie"] = {t=20.0, icontex="Spell_Nature_NullifyDisease"}; -- gain
		["R\195\169action"] = {t=15.0, icontex="Spell_Shadow_RitualOfSacrifice"}; -- gain
		["Inspiration"] = {t=15.0, icontex="INV_Shield_06"}; -- gain (target), Talent
		["Infusion de puissance"] = {t=15.0, d=180, icontex="Spell_Holy_PowerInfusion"}; -- gain, Talent
		["Incantation focalis\195\169e"] = {t=6.0, icontex="Spell_Arcane_Blink"}; -- gain, Talent

		["Mot de pouvoir : Bouclier"] = {t=30, d=15.0, icontex="Spell_Holy_PowerWordShield"};


		-- Rogue
		["D\195\169sarmement de pi\195\168ge"] = {t=2.0, icontex="Spell_Shadow_GrimWard"};
		["Sprint"] = {t=15.0, d=300.0, icontex="Ability_Rogue_Sprint"}; -- gain
		["Crochetage"] = {t=5.0, icontex="Spell_Nature_MoonKey"};
		["Evasion"] = {t=15.0, d=300, icontex="Spell_Shadow_ShadowWard"}; -- gain
		["Disparition"] = {t=10.0, d=300, icontex="Ability_Vanish"}; -- gain
		["Deluge de lames"] = {t=15.0, d=120, icontex="Ability_Rogue_SliceDice"}; -- gain

		["Poison instantan\195\169 VI"] = {t=3.0, icontex="Ability_Poisons"};
		["Poison mortel V"] = {t=3.0, icontex="Ability_Rogue_DualWeild"};
		["Poison affaiblissant"] = {t=3.0, icontex="Ability_PoisonSting"};
		["Poison affaiblissant II"] = {t=3.0, icontex="Ability_PoisonSting"};
		["Poison de distraction mentale"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		["Poison de distraction mentale II"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};
		["Poison de distraction mentale III"] = {t=3.0, icontex="Spell_Nature_NullifyDisease"};

		
		-- Shaman
		["Vague de soins inf\195\169rieurs"] = {t=1.5, icontex="Spell_Nature_HealingWaveLesser"};
		["Vague de soins"] = {t=2.5, icontex="Spell_Nature_MagicImmunity"}; --! talent
		["Esprit ancestral"] = {t=10.0, icontex="Spell_Nature_Regenerate"};
		["Cha\195\174ne d'\195\169clairs"] = {t=2.5, d=6.0, icontex="Spell_Nature_ChainLightning"};
		["Loup fant\195\180me"] = {t=3.0, icontex="Spell_Nature_SpiritWolf"};
		["Rappel astral"] = {t=10.0, icontex="Spell_Nature_AstralRecal"};
		["Salve de gu\195\169rison"] = {t=2.5, icontex="Spell_Nature_HealingWaveGreater"};
		["Eclair"] = {t=3.0, icontex="Spell_Nature_Lightning"};
		["Double vue"] = {t=2.0, icontex="Spell_Nature_FarSight"};
		["Totem de Griffes de pierre"] = {t=15.0, d=30.0, icontex="Spell_Nature_StoneClawTotem"}; -- gain
		["Totem Fontaine de mana"] = {t=15.0, d=300.0, icontex="Spell_Frost_SummonWaterElemental"}; -- gain
		["Totem Nova de feu"] = {t=5.0, d=15.0, icontex="Spell_Fire_SealOfFire"}; -- gain
		["Ma\195\174trise \195\169l\195\169mentaire"] = {t=12.0, d=25, icontex="Spell_Holy_SealOfMight"}; -- gain

		["Totem de Gl\195\168be"] = {d=15.0, icontex="Spell_Nature_GroundingTotem"}; -- works?

		
		-- Warlock
		["Trait de l'ombre"] = {t=2.5, icontex="Spell_Shadow_ShadowBolt"};
		["Immolation"] = {t=1.5, icontex="Spell_Fire_Immolation"};
		["Feu de l'\195\162me"] = {t=4.0, d=60.0, icontex="Spell_Fire_Fireball02"};
		["Douleur br\195\187lante"] = {t=1.5, icontex="Spell_Fire_SoulBurn"};
		["Invocation d'un Destrier de l'Effroi"] = {t=3.0, g=0.0, icontex="Ability_Mount_Dreadsteed"};
		["Invocation d'un palefroi corrompu"] = {t=3.0, g=0.0, icontex="Spell_Nature_Swiftness"};
		["Invocation d'un diablotin"] = {t=6.0, icontex="Spell_Shadow_Imp"};
		["Invocation d'une succube"] = {t=6.0, icontex="Spell_Shadow_SummonSuccubus"};
		["Invocation d'un marcheur du Vide"] = {t=6.0, icontex="Spell_Shadow_SummonVoidWalker"};
		["Invocation d'un chasseur corrompu"] = {t=6.0, icontex="Spell_Shadow_SummonFelHunter"};
		["Peur"] = {t=1.5, icontex="Spell_Shadow_Possession"};
		["Hurlement de terreur"] = {t=2.0, d=40.0, g=0.0, icontex="Spell_Shadow_DeathScream"};
		["Bannir"] = {t=1.5, icontex="Spell_Shadow_Cripple"};
		["Rituel d'invocation"] = {t=5.0, icontex="Spell_Shadow_Twilight"};
		["Rituel de mal\195\169diction"] = {t=10.0, icontex="Spell_Shadow_AntiMagicShell"};
		["Cr\195\169ation de Pierre de sort"] = {t=5.0, icontex="INV_Misc_Gem_Sapphire_01"};
		["Cr\195\169ation de Pierre d'\195\162me"] = {t=3.0, icontex="Spell_Shadow_SoulGem"};
		["Cr\195\169ation de Pierre de soins"] = {t=3.0, icontex="INV_Stone_04"};
		["Cr\195\169ation de Pierre de soins majeure"] = {t=3.0, icontex="INV_Stone_04"};
		["Cr\195\169ation de Pierre de feu"] = {t=3.0, icontex="INV_Ammo_FireTar"};
		["Asservir d\195\169mon"] = {t=3.0, icontex="Spell_Shadow_EnslaveDemon"};
		-- ["Infernal"] = {t=2.0, d=3600.0}; -- removed for PvE (Geddon) 
		["Gardien de l'ombre"] = {t=30.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
		["Mal\195\169diction amplifi\195\169e"] = {t=30.0, d=180, icontex="Spell_Shadow_Contagion"}; -- gain
        	   
			-- Imp
			["Eclair de Feu"] = {t=1.5, icontex="Spell_Fire_FireBolt"};
			
			-- Succubus
			["S\195\169duction"] = {t=1.5, icontex="Spell_Shadow_MindSteal"};
			["Baiser apaisant"] = {t=4.0, d=4.0, icontex="Spell_Shadow_SoothingKiss"};
			
			-- Voidwalker
			["Consumer les ombres"] = {t=10.0, icontex="Spell_Shadow_AntiShadow"}; -- gain
		
		-- Warrior
		["Rage sanguinaire"] = {t=10.0, d=60, icontex="Ability_Racial_BloodRage"}; -- gain
		["Sanguinaire"] = {t=8.0, icontex="Spell_Nature_BloodLust"}; -- gain
		["Mur protecteur"] = {t=10.0, d=1800.0, icontex="Ability_Warrior_ShieldWall"}; -- gain
		["T\195\169m\195\169rit\195\169"] = {t=15.0, d=1800.0, icontex="Ability_CriticalStrike"}; -- gain
		["Repr\195\169sailles"] = {t=15.0, d=1800.0, icontex="Ability_Warrior_Challange"}; -- gain
		["Rage berserker"] = {t=10.0, d=30, icontex="Spell_Nature_AncestralGuardian"}; -- gain
	        ["Dernier rempart"] = {t=20.0, d=600, icontex="Spell_Holy_AshesToAshes"}; -- gain
	        ["Souhait mortel"] = {t=30.0, d=180, icontex="Spell_Shadow_DeathPact"}; -- gain
	        -- ["Enrager"] = {t=12.0, icontex="Spell_Shadow_UnholyFrenzy"}; -- gain
		["Ma\195\174trise du blocage"] = {t=5.5, icontex="Ability_Defend"}; -- gain, 1 Talent point in impr. block


		-- Mobs
	        ["Rapetisser"] = {t=3.0, icontex="Spell_Ice_MagicDamage"};
	        ["Mal\195\169diction de la Banshee"] = {t=2.0, icontex="Spell_Nature_Drowsy"};
	        ["Salve de Traits de l'ombre"] = {t=3.0, icontex="Spell_Shadow_ShadowBolt"};
	        ["Faiblesse"] = {t=3.0, icontex="Spell_Shadow_Cripple"};
	        ["Gu\195\169rison t\195\169n\195\169breuse"] = {t=3.5, icontex="Spell_Shadow_ChillTouch"}; -- gain
		["D\195\169cr\195\169pitude spirituelle"] = {t=2.0, icontex="Spell_Holy_HarmUndeadAura"};
		["Bourrasque"] = {t=2.0, icontex="Spell_Nature_EarthBind"};

		
	}
	
	CEnemyCastBar_Raids = {

		-- "mcheck" to only show a bar if cast from this mob, don't use together with "m", "i" or "r"!
		-- "m" sets a mob's name for the castbar; "i" shows a second bar; "r" sets a different CastTime for this Mob
		-- "active" only allows this spell to be an active cast, no afflictions and something else!
		-- "global" normally is used for afflictions to be shown even it's not your target, but here the important feature is that the castbar won't be updated if active!
		-- "checktarget" checks if the mob casted this spell is your current target. Normally this isn't done with RaidSpells.
		-- "icasted" guides this spell through the instant cast protection

		-- Ahn'Qiraj
		
			-- 40 Man
				["Eradicateur d'obsidienne"] = {t=1800.0, c="cooldown", global="true", m="Respawn", icontex="Spell_Holy_Resurrection"};
	
				-- Twin Emperors
				["T\195\169l\195\169portation des jumeaux"] = {t=25.0, c="cooldown", icasted="true", icontex="Spell_Arcane_Blink"};
				["Explosion de l'insecte"] = {t=5.0, c="gains", icontex="Spell_Fire_Fire"};
				["Mutation de l'insecte"] = {t=5.0, c="gains", icontex="Ability_Hunter_Pet_Scorpid"};

				-- C'Thun
				["Eye Tentacle (Repeater)"] = {t=45, c="cooldown", icontex="INV_Misc_AhnQirajTrinket_05"};  -- don't translate, used internally! +auto global="true" on engage!
				["Next Eye Tentacle"] = {t=122, c="cooldown", icontex="INV_Misc_AhnQirajTrinket_05"};  -- don't translate, used internally!
				["Phase2 Eye Tentacle"] = {t=42, c="cooldown", icontex="INV_Misc_AhnQirajTrinket_05"};  -- don't translate, used internally!
				--["Dark Glare (Repeater)"] = {t=86, c="cooldown", icontex="Spell_Nature_CallStorm"};  -- don't translate, used internally!; remove in lua, too, if works
				["First Dark Glare"] = {t=48, c="cooldown", icontex="Spell_Nature_CallStorm"};  -- don't translate, used internally! +auto global="true" on engage!
				["Weakened!!!"] = {t=45, c="gains"};  -- don't translate, used internally!
				["Rayon de l'Oeil"] = {t=86, i=40, c="cooldown", active="true", icontex="Spell_Nature_CallStorm"};

				-- Skeram
				["Explosion des arcanes"] = {t=1.2, c="hostile", mcheck="Le Proph\195\168te Skeram", icontex="Spell_Nature_WispSplode"};

				-- Sartura (Twin Emps enrage)
				["Tourbillon"] = {t=15.0, c="gains", mcheck="Garde de guerre Sartura", icontex="Ability_Whirlwind"};
				["Enraged mode"] = {t=900, r="Sartura", a=600, c="cooldown", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally! +if player enters combat and target are twins! +auto global="true" on engage!
				["Enters Enraged mode"] = {t=3, c="gains", icontex="Spell_Shadow_UnholyFrenzy"}; -- don't translate, used internally!

				-- Huhuran
				["Berserk mode"] = {t=300, c="cooldown", icontex="Racial_Troll_Berserk"}; -- don't translate, used internally! if player enters combat and target is Huhuran! +auto global="true" on engage!
				["Enters Berserk mode"] = {t=3, c="gains", icontex="Racial_Troll_Berserk"}; -- don't translate, used internally!
				["Piq\195\187re de wyverne"] = {t=25, c="cooldown", m="Huhuran", aZone="Ahn'Qiraj", checkevent="CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE - CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE - CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE", icontex="INV_Spear_02"};

			-- 20 Man
				["Exploser"] = {t=6.0, c="hostile", icontex="Spell_Fire_SelfDestruct"};
	
				-- Moam
				["Until Stoneform"] = {t=90, c="grey", icontex="Spell_Shadow_UnholyStrength"}; -- don't translate, used internally!
				["Dynamiser"] = {t=90, c="gains", icontex="Spell_Nature_Cyclone"};


		-- Zul'Gurub

			-- Hakkar
			["Siphon de sang"] = {t=90, c="cooldown", mcheck="Hakkar", icontex="Spell_Shadow_LifeDrain02"};
			["LIFE DRAIN"] = {t=90.0, c="cooldown", icontex="Spell_Shadow_LifeDrain02"}; -- don't translate, used internally!

 			-- Mandokir's Gaze
			--["Regard mena\195\167ant"] = {t=2.0, c="hostile", active="true", icontex="Spell_Shadow_Charm"}; -- removed, to call it in the affliction section
		
		-- Molten Core
		
			-- Lucifron
			["Mal\195\169diction imminente"] = {t=20, c="cooldown", m="Lucifron", icontex="Spell_Shadow_NightOfTheDead"};
			["Mal\195\169diction de Lucifron"] = {t=20, c="cooldown", m="Lucifron", icontex="Spell_Shadow_BlackPlague"};
		
			-- Magmadar
			["Panique"] = {t=30, c="cooldown", m="Magmadar", icontex="Spell_Shadow_DeathScream"};

			-- Gehennas
			["Mal\195\169diction de Gehennas"] = {t=30, c="cooldown", m="Gehennas", icontex="Spell_Shadow_GatherShadows"};

			-- Geddon
			["Infernal"] = {t=8.0, c="gains", mcheck="Baron Geddon", icontex="Spell_Fire_Incinerate"};

			-- Majordomo
			["Renvoi de la magie"] = {t=30, i=10.0, c="cooldown", m="Majordomo", icontex="Spell_Frost_FrostShock"};
			["Bouclier de d\195\169g\195\162ts"] = {t=30, i=10.0, c="cooldown", m="Majordomo", icontex="Spell_Nature_LightningShield"};
			
			-- Ragnaros
			["Submerge"] = {t=180.0, c="cooldown", icontex="Spell_Fire_Volcano"}; -- don't translate, used internally!
			["Knockback"] = {t=28.0, c="cooldown", icontex="Ability_Kick"}; -- don't translate, used internally!
			["Sons of Flame"] = {t=90.0, c="cooldown", icontex="ell_Fire_LavaSpawn"}; -- don't translate, used internally!

		-- Onyxia
			["Souffle de flammes"] = {t=2.0, c="hostile", active="true", icontex="Spell_Fire_Fire"};
			
		-- Blackwing Lair

			-- Razorgore
			["Mob Spawn (45sec)"] = {t=45.0, c="cooldown", icontex="Spell_Shadow_RaiseDead"}; -- don't translate, used internally!

			-- Firemaw/Flamegor/Ebonroc
			["Frappe des ailes"] = {t=31.5, i=1.2, c="cooldown", r="Onyxia", a=0, icontex="INV_Misc_MonsterScales_14"};
			["First Wingbuffet"] = {t=30.0, c="cooldown", icontex="INV_Misc_MonsterScales_14"};  -- don't translate, used internally! if player enters combat and target is firemaw or flamegor this castbar appears to catch the first wingbuffet!
			["Flamme d'ombre"] = {t=2.0, c="hostile", active="true", icontex="Spell_Fire_Incinerate"}; 
			
			-- Flamegor
			["Frenzy (CD)"] = {t=10.0, c="cooldown", icontex="INV_Misc_MonsterClaw_03"}; -- don't translate, used internally!
			
			-- Chromaggus
			["Br\195\187lure de givre"] = {t=60, i=2.0, c="cooldown", active="true", icontex="Spell_Frost_ChillingBlast"};
			["Trou de temps"] = {t=60, i=2.0, c="cooldown", active="true", icontex="Spell_Arcane_PortalOrgrimmar"};
			["Enflammer la chair"] = {t=60, i=2.0, c="cooldown", active="true", icontex="Spell_Fire_Fire"};
			["Acide corrosif"] = {t=60, i=2.0, c="cooldown", active="true", icontex="Spell_Nature_Acid_01"};
			["Incin\195\169rer"] = {t=60, i=2.0, c="cooldown", active="true", icontex="Spell_Fire_FlameShock"};
			["Killing Frenzy"] = {t=15.0, c="cooldown", icontex="INV_Misc_MonsterClaw_03"}; -- don't translate, used internally!
				-- Chromaggus, Flamegor, Magmadar etc.
			["Fr\195\169n\195\169sie"] = {t=8.0, c="gains", checktarget="true", icontex="INV_Misc_MonsterClaw_03"};

			-- Neferian/Onyxia
			["Rugissement puissant"] = {t=2.0, c="hostile", r="Onyxia", a=1.5, active="true", icontex="Spell_Shadow_Charm"};
			
			-- Neferian			
			["Nefarian calls"] = {t=30.0, c="gains", icontex="INV_Misc_Head_Dragon_Black"}; -- don't translate, used internally!
			["Mob Spawn"] = {t=8.0, c="hostile", icontex="Spell_Shadow_RaiseDead"}; -- don't translate, used internally!
			["Landing"] = {t=10.0, c="hostile", icontex="INV_Misc_Head_Dragon_Black"}; -- don't translate, used internally!
			
		-- Outdoor
		
			-- Azuregos
			["Temp\195\170te de mana"] = {t=10.0, c="hostile", icontex="Spell_Frost_IceStorm"};

		
	}


	CEnemyCastBar_Afflictions = {

	-- Warning: only add Spells with the "CEnemyCastBar_SPELL_AFFLICTED" pattern here!
	-- fragile="true", if mob with the same name dies, the bar won't be removed
	-- multi="true", the bar is not removed if debuff fades earlier (usefull if one spell is allowed to produce multiple afflictions)
	-- stun="true", flags all spells which use the same Diminishing Return timer. These 8 Spells were tested to use one and the same timer.
	-- death="true", removes the castbar although it is a "fragile"
	-- periodicdmg="true" -> don't update and remove those castbars, only allows periodic damage done by yourself
	-- spellDR="true", triggers a separate class DR Timer; affmob="true", this stun triggers a class specific DR Timer on a mob (not player), too

		-- Naturfreund | Warrior Afflicions
		["Provocation"] = {t=3.0, multi="true", icontex="Spell_Nature_Reincarnation"};
		["Coup railleur"] = {t=6.0, multi="true", icontex="Ability_Warrior_PunishingBlow"};
		["Cri de d\195\169fi"] = {t=6, multi="true", icontex="Ability_BullRush"};
	        ["Brise-genou"] = {t=15.0, icontex="Ability_ShockWave"};
	        ["Hurlement per\195\167ant"] = {t=6.0, icontex="Spell_Shadow_DeathScream"};
			["Coup de bouclier - silencieux"] = {t=4, solo="true", icontex="Ability_Warrior_ShieldBash"};
			["Bourrasque"] = {t=5, solo="true", stun="true", icontex="Ability_ThunderBolt"};
			["Charge \195\169tourdissante"] = {t=1, solo="true", stun="true", icontex="Ability_Warrior_Charge"};
			["Interception \195\169tourdissante"] = {t=3, solo="true", stun="true", icontex="Ability_Rogue_Sprint"};
			["Etourdissement vengeur"] = {t=3, solo="true", icontex="Ability_Warrior_Revenge"};
			["Cri d'intimidation"] = {t=8, solo="true", icontex="Ability_GolemThunderClap"};
			["D\195\169sarmement"] = {t=10, solo="true", icontex="Ability_Warrior_Disarm"};
			-- periodic damage spells
				["Pourfendre"] = {t=21, periodicdmg="true", icontex="Ability_Gouge"};

		-- Naturfreund | Mage Afflicions
		["Nova de givre"] = {t=8.0, magecold="true", icontex="Spell_Frost_FrostNova"};
		["Morsure du givre"] = {t=5.0, magecold="true", icontex="Spell_Frost_FrostArmor"};
		["Transir"] = {t=5.0, magecold="true", icontex="Spell_Frost_IceStorm"};
		["C\195\180ne de froid"] = {t=9.0, magecold="true", icontex="Spell_Frost_Glacier"}; -- slightly improved with talents (+1 sec)
		["Eclair de givre"] = {t=10, solo="true", magecold="true", icontex="Spell_Frost_FrostBolt02"}; -- slightly improved with talents (+1 sec)
		["Froid hivernal"] = {t=15, magecold="true", icontex="Spell_Frost_ChillingBlast"};
		["Vuln\195\169rabilit\195\169 au Feu"] = {t=30, magecold="true", icontex="Spell_Fire_SoulBurn"};
		["M\195\169tamorphose"] = {t=50, fragile="true", spellDR="true", sclass="MAGE", icontex="Spell_Nature_Polymorph"};
			["Contresort - Silencieux"] = {t=4, solo="true", icontex="Spell_Frost_IceShock"};

		-- Naturfreund | Hunter Afflicions
	        ["Coupure d'ailes"] = {t=10, icontex="Ability_Rogue_Trip"};
		["Trait de choc am\195\169lior\195\169"] = {t=3, solo="true", icontex="Spell_Frost_Stun"};
	        ["Effet Pi\195\168ge givrant"] = {t=20.0, fragile="true", spellDR="true", sclass="HUNTER", icontex="Spell_Frost_ChainsOfIce"};
			-- periodic damage spells
				["Morsure de serpent"] = {t=15, periodicdmg="true", icontex="Ability_Hunter_Quickshot"};

		-- Naturfreund | Priest Afflicions
		["Vuln\195\169rabilit\195\169 \195\160 l'Ombre"] = {t=15, magecold="true", icontex="Spell_Shadow_ShadowBolt"};
		["Apaisement"] = {t=15, icontex="Spell_Holy_MindSooth"};
		["Entraves des morts-vivants"] = {t=50, fragile="true", spellDR="true", sclass="PRIEST", icontex="Spell_Nature_Slow"};
			["Cri psychique"] = {t=8, solo="true", icontex="Spell_Shadow_PsychicScream"};
			-- periodic damage spells
				["Mot de l'ombre : Douleur"] = {t=18, periodicdmg="true", icontex="Spell_Shadow_ShadowWordPain"};
				["Peste d\195\169vorante"] = {t=24, periodicdmg="true", icontex="Spell_Shadow_BlackPlague"};
				["Flammes sacr\195\169es"] = {t=10, periodicdmg="true", directhit="true", icontex="Spell_Holy_SearingLight"};

		-- Naturfreund | Warlock Afflicions
		["Bannir"] = {t=30, fragile="true", icontex="Spell_Shadow_Cripple"};
		-- Succubus
		["S\195\169duction"] = {t=15, fragile="true", spellDR="true", sclass="WARLOCK", icontex="Spell_Shadow_MindSteal"};
			["Peur"] = {t=8, solo="true", icontex="Spell_Shadow_Possession"};
			-- periodic damage spells
				["Mal\195\169diction d'agonie"] = {t=24, periodicdmg="true", icontex="Spell_Shadow_CurseOfSargeras"};
				["Corruption"] = {t=18, periodicdmg="true", icontex="Spell_Shadow_AbominationExplosion"};
				["Immolation"] = {t=15, periodicdmg="true", directhit="true", icontex="Spell_Fire_Immolation"};

		-- Naturfreund | Rogue Afflicions
	        ["Poison affaiblissant"] = {t=12, icontex="Ability_PoisonSting"};
	        ["Assommer"] = {t=45, fragile="true", spellDR="true", sclass="ROGUE", drshare="Assommer, Suriner", icontex="Ability_Sap"};
			["Aiguillon perfide"] = {t=6, cpinterval=1, solo="true", spellDR="true", sclass="ROGUE", affmob="true", icontex="Ability_Rogue_KidneyShot"}; -- own DR
			["Coup bas"] = {t=4, solo="true", stun="true", icontex="Ability_CheapShot"};
			["Suriner"] = {t=5.5, solo="true", spellDR="true", sclass="ROGUE", drshare="Assommer, Suriner", icontex="Ability_Gouge"}; -- normal 4sec impr. 5.5sec (no DR)
			["C\195\169cit\195\169"] = {t=10, solo="true", spellDR="true", sclass="ROGUE", icontex="Spell_Shadow_MindSteal"};
			["Coup de pied - Silencieux"] = {t=2, solo="true", icontex="Ability_Kick"};
			["Riposte"] = {t=6, solo="true", icontex="Ability_Warrior_Disarm"};
			-- periodic damage spells
				["Garrot"] = {t=18, periodicdmg="true", icontex="Ability_Rogue_Garrote"};
				["Rupture"] = {t=22, cpinterval=4, periodicdmg="true", icontex="Ability_Rogue_Rupture"};

		-- Naturfreund | Druid Afflicions
	        ["Grondement"] = {t=3, multi="true", icontex="Ability_Physical_Taunt"};
	        ["Rugissement provocateur"] = {t=6, multi="true", icontex="Ability_Druid_ChallangingRoar"};
		["Sarments"] = {t=27, fragile="true", death="true", spellDR="true", sclass="DRUID", icontex="Spell_Nature_StrangleVines"};
		["Hibernation"] = {t=40, fragile="true", icontex="Spell_Nature_Sleep"};
			["Sonner"] = {t=4, solo="true", stun="true", icontex="Ability_Druid_Bash"};
			["Traquenard"] = {t=2, solo="true", stun="true", icontex="Ability_Druid_SupriseAttack"};
			["Effet de Charge farouche"] = {t=4, solo="true", stun="true", icontex="Ability_Hunter_Pet_Bear"};
			-- periodic damage spells
				["Essaim d'insectes"] = {t=12, periodicdmg="true", icontex="Spell_Nature_InsectSwarm"};
				["Eclat lunaire"] = {t=12, periodicdmg="true", directhit="true", icontex="Spell_Nature_StarFall"};
				["D\195\169chirure"] = {t=12, periodicdmg="true", icontex="Ability_GhoulFrenzy"};

		-- Naturfreund | Paladin Afflicions
			["Marteau de la justice"] = {t=6, solo="true", stun="true", icontex="Spell_Holy_SealOfMight"};
			["Repentir"] = {t=6, solo="true", icontex="Spell_Holy_PrayerOfHealing"};

		-- Naturfreund | Shaman Afflicions
		["Horion de givre"] = {t=8.0, magecold="true", spellDR="true", sclass="SHAMAN", icontex="Spell_Frost_FrostShock"};
			-- periodic damage spells
				["Horion de flammes"] = {t=12, periodicdmg="true", directhit="true", icontex="Spell_Fire_FlameShock"};


	-- Naturfreund | Raidencounter Afflicions
	-- gobal="true" creates a castbar even without a target!

		-- Zul'Gurub
		["Illusions de Jin'do"] = {t=20, global="true", icontex="Spell_Shadow_UnholyFrenzy"}; -- Delusions of Jin'do
		["Rendre frou"] = {t=9.5, global="true", icontex="Spell_Shadow_ShadowWordDominate"}; -- Hakkars Mind Control
		["Regard mena\195\167ant"] = {t=5.7, global="true", icontex="Spell_Shadow_Charm"}; -- Mandokir's Gaze

		-- MC
		["Bombe vivante"] = {t=8, global="true", icontex="INV_Enchant_EssenceAstralSmall"}; -- Geddon's Bomb

		-- BWL
		["D\195\169flagration"] = {t=10.0, global="true", icontex="Spell_Fire_Incinerate"}; -- Razorgores (and Drakkisaths) Burning
		["Mont\195\169e d'adr\195\169naline"] = {t=20.0, global="true", icontex="INV_Gauntlets_03"}; -- Vaelastrasz BA
		["Ombre d'Ebonroc"] = {t=8.0, global="true", icontex="Spell_Shadow_GatherShadows"}; -- Ebonroc selfheal debuff

		-- AQ40
		["Accomplissement v\195\169ritable"] = {t=20, global="true", icontex="Spell_Shadow_Charm"}; -- Skeram MindControl
		["Peste"] = {t=40, global="true", icontex="Spell_Shadow_CurseOfTounges"}; -- Anubisath Defenders Plague
		["Enchev\195\170trement"] = {t=10, global="true", icontex="Spell_Nature_StrangleVines"}; -- Fankriss the Unyielding's Entangle

		-- Non Boss DeBuffs:
		["M\195\169tamorphose sup\195\169rieure"] = {t=20.0, fragile="true", icontex="Spell_Nature_Brilliance"}; -- Polymorph of BWL Spellbinders


	-- REMOVALS
	-- just to remove the bar if this spell fades (t is useless here) | only the spells in "CEnemyCastBar_Afflictions" are checked by the "fade-engine"
		-- Moam
		["Dynamiser"] = {t=0};
		-- Other
		["Fr\195\169n\195\169sie"] = {t=0};
		["Stun DR"] = {t=0}; -- don't translate, used internally! clear the dimishing return timer if mob dies
		["Shield Block"] = {t=0};
		-- AQ40 Sartura
		["Enraged mode"] = {t=0}; -- don't translate, used internally!


	}


	-- Zul'Gurub
	CEnemyCastBar_HAKKAR_YELL			= "ANNONCE LA FIN DE VOTRE MONDE";

	-- AQ40
	CEnemyCastBar_SARTURA_NAME			= "Garde de guerre Sartura";
	CEnemyCastBar_SARTURA_CALL			= "Je vous condamne \195\160 mort";
	CEnemyCastBar_SARTURA_CRAZY			= "devient fou furieux";

	CEnemyCastBar_HUHURAN_NAME			= "Princesse Huhuran";
	CEnemyCastBar_HUHURAN_CRAZY			= "entre dans une rage d\195\169mente";
	CEnemyCastBar_HUHURAN_FRENZY			= "est pris de fr\195\169n\195\169sie";

	CEnemyCastBar_CTHUN_NAME1	 		= "Oeil de C'Thun";
	CEnemyCastBar_CTHUN_WEAKENED			= "est affaibli";

	-- Ruins of AQ
	CEnemyCastBar_MOAM_STARTING			= "sent votre peur.";

	-- MC
	CEnemyCastBar_RAGNAROS_STARTING			= "^ET MAINTENANT,";
	CEnemyCastBar_RAGNAROS_KICKER			= "^GO\195\155TEZ";
	CEnemyCastBar_RAGNAROS_SONS	 			= "^VENEZ, MES SERVITEURS";

	-- BWL
	CEnemyCastBar_RAZORGORE_CALLER			= "Grethok le Contr\195\180leur";
	CEnemyCastBar_RAZORGORE_CALL			= "Sonnez l'alarme";

	CEnemyCastBar_FIREMAW_NAME			= "Gueule-de-feu";
	CEnemyCastBar_EBONROC_NAME			= "Ebonroc";
	CEnemyCastBar_FLAMEGOR_NAME			= "Flamegor";	
	CEnemyCastBar_FLAMEGOR_FRENZY			= "est pris de fr\195\169n\195\169sie";
	CEnemyCastBar_CHROMAGGUS_FRENZY			= "entre dans une sanglante fr\195\169n\195\169sie";
	
	CEnemyCastBar_NEFARIAN_STARTING			= "Que les jeux commencent";
	CEnemyCastBar_NEFARIAN_LAND				= "Beau travail";
	CEnemyCastBar_NEFARIAN_SHAMAN_CALL		= "Chamans, montrez moi";
	CEnemyCastBar_NEFARIAN_DRUID_CALL		= "Les druides et leur stupides";
	CEnemyCastBar_NEFARIAN_WARLOCK_CALL		= "D\195\169monistes, vous ne devriez pas jouer";
	CEnemyCastBar_NEFARIAN_PRIEST_CALL		= "Pr\195\170tres ! Si vous continuez";
	CEnemyCastBar_NEFARIAN_HUNTER_CALL		= "Ah, les chasseurs et les stupides";
	CEnemyCastBar_NEFARIAN_WARRIOR_CALL		= "Guerriers, je sais que vous pouvez frapper plus fort";
	CEnemyCastBar_NEFARIAN_ROGUE_CALL		= "Voleurs, arr\195\170tez de vous cacher";
	CEnemyCastBar_NEFARIAN_PALADIN_CALL		= "Les paladins";
	CEnemyCastBar_NEFARIAN_MAGE_CALL		= "Les mages aussi";
	

	-- Event Pattern
	CEnemyCastBar_MOB_DIES					= "(.+) meurt"
	CEnemyCastBar_SPELL_GAINS 				= "(.+) gagne (.+)."
	CEnemyCastBar_SPELL_CAST 				= "(.+) commence \195\160 lancer (.+)."
	CEnemyCastBar_SPELL_PERFORM				= "(.+) commence \195\160 ex\195\169cuter (.+)."
	CEnemyCastBar_SPELL_CASTS				= "(.+) lance (.+)."
	CEnemyCastBar_SPELL_AFFLICTED				= "(.+) (.+) les effets de (.+).";
	CEnemyCastBar_SPELL_DAMAGE 				= "(.+) de (.+) inflige \195\160 (.+) (%d+)";
	--							spell 	from 			mob damage <- correct order here? tell me pls
						-- engl. : "%s suffers %d %s damage from %s's %s."
						-- french: "%5$s de %4$s inflige à %1$s %2$d points de dégâts |2 %3$s."
						-- german: "%1$s erleidet %2$d %3$sschaden von %4$s (durch %5$s)."
						-- \195\160 == à,


	-- Naturfreund
	CEnemyCastBar_SPELL_DAMAGE_SELFOTHER			= "Votre (.+) inflige (.+) \195\160 (.+).";

	CEnemyCastBar_SPELL_FADE 				= "(.+) sur (.+) vient de se dissiper.";
	--							effect		mob <- correct order here? tell me pls

	CEnemyCastBar_SPELL_REMOVED 				= "(.+) n'est plus sous l'influence de (.+)."
	--							mob	spell <- correct order here? tell me pls

	CEnemyCastBar_SPELL_HITS_SELFOTHER			= "Votre (.+) touche (.+) et lui inflige (.+).";
	--								spell	 	mob		(damage)
	CEnemyCastBar_SPELL_CRITS_SELFOTHER			= "Votre (.+) inflige un coup critique \195\160 (.+) %((.+)%).";

	CECB_SELF1	= "Vous";
	CECB_SELF2	= "vous";


-- Options Menue
CECB_status_txt = "EnemyCastBar Mod activated";
CECB_pvp_txt = "PvP/Common CastBars activated";
 CECB_gains_txt = "Spelltype 'gains' activated";
 CECB_cdown_txt = "Some CoolDownBars activated";
  CECB_cdownshort_txt = "ONLY show short CDs";
CECB_pve_txt = "PvE/Raid Castbars activated";
CECB_afflict_txt = "Show Debuffs";
 CECB_globalfrag_txt = "'Show Mob Outs' even w/o Target";
 CECB_magecold_txt = "Show Cold + Vulnerability effects";
 CECB_solod_txt = "Show 'Solo Debuffs' (Stuns)";
  CECB_drtimer_txt = "Consider 'Diminishing Return'";
  CECB_classdr_txt = "Consider class specific 'DRs'";
 CECB_sdots_txt = "Observe own DoTs";
 CECB_affuni_txt = "ONLY show Debuffs from RaidBosses";
CECB_parsec_txt = "Parse CT_RA/Raid/PartyChat";
 CECB_broadcast_txt = "Broadcast CBs via CT_RA Channel";
CECB_targetm_txt = "Target on BarLeftClick";
CECB_timer_txt = "Show Timer next to CastBars";
CECB_tsize_txt = "Small textfont for CastBars";
CECB_flipb_txt = "Flip over CastBars";
CECB_flashit_txt = "'Flash' CastBars at their end";
CECB_showicon_txt = "Show Icon next to CastBars";
CECB_scale_txt = "Scaling: ";
CECB_alpha_txt = "Alphablending: ";
CECB_numbars_txt = "Max. number of CastBars: ";
CECB_space_txt = "Iconsize, Distance of CastBars: ";
CECB_minimap_txt = "Position at the MiniMap: ";

CECB_status_tooltip = "Activates/ Deactivates the appearing of CastBars while gaming and switches off all Events to reduce CPU load.";
CECB_pvp_tooltip = "Activates CastBars for all supported, common spells of players.";
 CECB_gains_tooltip = "Activates CastBars for 'gains'.\nThose are spells like 'Iceblock', 'Bloodrage' and Heal over Time (HoTs).";
 CECB_cdown_tooltip = "Activates the CoolDown-Times for some(!) spells, which have casttimes or are 'gains'.";
  CECB_cdownshort_tooltip = "Only shows Cooldowns if their duration is 60 or less seconds.";
CECB_pve_tooltip = "Activates CastBars for PvE/Raid-Encounters";
CECB_afflict_tooltip = "Shows immobilizing Debuffs, e.g. '(Polymorph)' or 'Harmstring'. Simultaneously activates many Debuffs of bosses which can be cast on players, e.g. 'Burning Adrenaline'.";
 CECB_globalfrag_tooltip = "Shows CastBars at 'Mob Outs', even if the affected Mob is not your current target.\n\n'Mob Outs' are 'Shackle Undead', 'Banish', 'Polymorph' etc.";
 CECB_magecold_tooltip = "Shows the following cold effects:\n'Frost Nova', 'Frostbite', 'Chilled', 'Cone of Cold' and 'Frostbolt'.\nAdditionally vulnerabilities (cold, fire, shadow) will be displayed.";
 CECB_solod_tooltip = "Shows many Stuns. Also activates silenced, fear, disarm and threat effects!";
  CECB_drtimer_tooltip = "Considers 'Diminishing Return' for the biggest stun-family which use the same timer.\nThese are 3 Warrior, 3 Druid, 1 Pala and 1 Rogue stuns.\n\nYou will see a bar counting down the 20 seconds until you will be able to afflict the full stun length again.";
  CECB_classdr_tooltip = "Considers class specific 'Diminishing Returns' like 'Sap' and 'Polymorph'.\n\n|cffff0000Usually these timers are only active against other Players|r and are only displayed for the matching character class.";
 CECB_sdots_tooltip = "Shows the duration of your DoTs (e.g. |cffffffff'Corruption' |r-|cffffffff 'Serpent Sting'|r).\nThe CastBars won't renew if the DoT is casted again before the duration ran out! |cffff0000\nAt best, renew the DoT at the very end of its duration or the timer becomes crazy!|r\n\nDoTs which additionally afflict instant damage will renew the CastBar and do not have this problem (e.g |cffffffff'Immolate'|r)!";
 CECB_affuni_tooltip = "Switches off all Debuffs, which do not come from RaidBosses, to have a better overview.";
CECB_timer_tooltip = "Additionally shows an digital Timer beneath the CastBars.";
CECB_targetm_tooltip = "The Mob, the CastBar came from, may be targeted by a LeftClick on the CastBar through this option.";
CECB_parsec_tooltip = "All Users who enable this option, receive a CastBar on their screen, if one of the following commands with a set time appears at the beginning of the Raid-/Party-/CT_RA-Chat: '|cffffffff.countmin|r', '|cffffffff.countsec|r', '|cffffffff.repeat|r' or '|cffffffff.stopcount|r' (s. Help).\n\nExample:\n|cffffffff.countsec 45 Until Spawn|r\n\nInstead of:\n|cffffffff/necb countsec 45 Until Spawn\n\n|cffff0000Also needed for CT_RA Support!";
CECB_broadcast_tooltip = "Raidspells and Debuffs will be broadcasted through the CT_RA Channel.\nThis only works if sender and receiver use the same language!\n\n|cffff0000ATTENTION:|r This option should only be enable by some few, selected Players of the Raid!\nPvP Spells won't be transmitted.";
CECB_tsize_tooltip = "Lowers the size of the textfont to allow more letters in the castbars.";
CECB_flipb_tooltip = "Turns the direction in which CastBars appear around.\nNormal: From button up.\nActivated: From top down.";
CECB_flashit_tooltip = "CastBars with a Totaltime of at least 20 Sekunden, begin to 'flash' after 20% of the bar is left.\nBut at maximum the last 10 seconds are 'flashed'.";
CECB_showicon_tooltip = "Displays the proper spell icon next to the Castbar.\n\nThe size will automatically fit to the 'Space between CastBars' setting.";
CECB_scale_tooltip = "Does allow to change the size of the CastBars from 30 till 130 percent.";
CECB_alpha_tooltip = "Does allow to change the transparency of the CastBars.";
CECB_numbars_tooltip = "Sets the maximum allowed CastBars on your screen.";
CECB_space_tooltip = "Sets the space between CastBars.\n(default is 20)";
CECB_minimap_tooltip = "Moves the NECB Button around the MiniMap.";
CECB_fps_tooltip = "Creates a standalone clone of the FPS Bar which can be placed freely.\n\n|cffff0000This setting will NOT be saved.";


CECB_menue_txt = "Options";
CECB_menuesub1_txt = "Which CastBars to show?";
CECB_menuesub2_txt = "Appearance of CastBars/ Other";
CECB_menue_reset = "Defaults";
CECB_menue_help = "Help";
CECB_menue_mbar = "Movable Bar";
--CECB_menue_close = "Close";
CECB_menue_rwarning = "WARNING!\n\nAll values and positions will be restored \nto 'factory defaults'!\n\nDo you really want a complete reset?";
CECB_menue_ryes = "Yes";
CECB_menue_rno = "NO!";
CECB_menue_CTRAChan = "CT_RA Channel: ";
CECB_menue_CTRAnoBC = "please broadcast";
CECB_minimapoff_txt = "off";


end
