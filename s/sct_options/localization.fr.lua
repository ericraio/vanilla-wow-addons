-- SCT localization information
-- French Locale
-- Initial translation by Juki <Unskilled>
-- Translation by Sasmira
-- Date 04/03/2006

if GetLocale() ~= "frFR" then return end

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "D\195\169g\195\162ts", tooltipText = "Activer/D\195\169sactiver les d\195\169g\195\162ts de m\195\169l\195\169e et divers (feu, chute, etc...)."};
SCT.LOCALS.OPTION_EVENT2 = {name = "Rat\195\169s", tooltipText = "Activer/D\195\169sactiver les coups rat\195\169s"};
SCT.LOCALS.OPTION_EVENT3 = {name = "D\195\169vi\195\169s", tooltipText = "Activer/D\195\169sactiver les coups d\195\169vi\195\169s"};
SCT.LOCALS.OPTION_EVENT4 = {name = "Parades", tooltipText = "Activer/D\195\169sactiver les coups par\195\169s"};
SCT.LOCALS.OPTION_EVENT5 = {name = "Bloqu\195\169s", tooltipText = "Activer/D\195\169sactiver les coups bloqu\195\169s"};
SCT.LOCALS.OPTION_EVENT6 = {name = "D\195\169g\195\162ts Sorts", tooltipText = "Activer/D\195\169sactiver les d\195\169g\195\162ts de sorts"};
SCT.LOCALS.OPTION_EVENT7 = {name = "Sorts Soins", tooltipText = "Activer/D\195\169sactiver les sorts de soins"};
SCT.LOCALS.OPTION_EVENT8 = {name = "Sorts Resist\195\169s", tooltipText = "Activer/D\195\169sactiver les sorts r\195\169sist\195\169s"};
SCT.LOCALS.OPTION_EVENT9 = {name = "D\195\169buffs", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous \195\170tes debuffs"};
SCT.LOCALS.OPTION_EVENT10 = {name = "Absorb\195\169s", tooltipText = "Activer/D\195\169sactiver les d\195\169g\195\162ts absorb\195\169s"};
SCT.LOCALS.OPTION_EVENT11 = {name = "Vie Faible", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque votre vie est faible"};
SCT.LOCALS.OPTION_EVENT12 = {name = "Mana Faible", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque votre mana est faible"};
SCT.LOCALS.OPTION_EVENT13 = {name = "Gains d\'Energie", tooltipText = "Activer/D\195\169sactiver l\'affichage des gains de Mana, Rage, Energie\ndes potions, obejts, buffs, etc...(pas des r\195\169g\195\169ration naturelle)"};
SCT.LOCALS.OPTION_EVENT14 = {name = "Mode Combat", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous rentrez ou sortez d\'un combat"};
SCT.LOCALS.OPTION_EVENT15 = {name = "Points de Combo", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous gagnez des points de combo"};
SCT.LOCALS.OPTION_EVENT16 = {name = "Points d\'Honneur", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous gagnez des points d\'Honneur"};
SCT.LOCALS.OPTION_EVENT17 = {name = "Buffs", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque vous \195\170tes buffs"};
SCT.LOCALS.OPTION_EVENT18 = {name = "Fin des Buffs", tooltipText = "Activer/D\195\169sactiver l\'affichage lorsque les buffs se dissipent"};
SCT.LOCALS.OPTION_EVENT19 = {name = "Ex\195\169cution/Courroux", tooltipText = "Activer/D\195\169sactiver l\'affichage de l\'alerte pour Ex\195\169cution et Marteau de Courroux (Guerrier/Paladin Seulement)"};
SCT.LOCALS.OPTION_EVENT20 = {name = "R\195\169putation", tooltipText = "Activer/D\195\169sactiver l\'affichage du Gain ou de la perte de R\195\169putation"};
SCT.LOCALS.OPTION_EVENT21 = {name = "Vos Soins", tooltipText = "Activer/D\195\169sactiver l\'affichage des soins que vous faites aux les autres"};
SCT.LOCALS.OPTION_EVENT22 = {name = "Comp\195\169tences", tooltipText = "Activer/D\195\169sactiver l\'affichage du Gain de points de Comp\195\169tences"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "Scrolling Combat Text", tooltipText = "Activer/D\195\169sactiver Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK2 = { name = "Mode Combat", tooltipText = "Activer/D\195\169sactiver l\'affichage de * autour de tous les Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK3 = { name = "Voir Soigneurs", tooltipText = "Activer/D\195\169sactiver l\'affichage de qui ou par quoi vous \195\170tes soign\195\169s."};
SCT.LOCALS.OPTION_CHECK4 = { name = "Affichage vers le Bas", tooltipText = "Activer/D\195\169sactiver le d\195\169roulement du texte vers le bas"};
SCT.LOCALS.OPTION_CHECK5 = { name = "Critiques", tooltipText = "Activer/D\195\169sactiver les coups/soins critiques au dessus de votre t\195\170te"};
SCT.LOCALS.OPTION_CHECK6 = { name = "Type de Sorts", tooltipText = "Activer/D\195\169sactiver l\'affichage du type de dommage caus\195\169 par les Sorts"};
SCT.LOCALS.OPTION_CHECK7 = { name = "Valider Font: Dommage", tooltipText = "Activer/D\195\169sactiver le changement de la Font sur les dommages dans le jeu par rapport \195\160 la Font us\195\169e par SCT.\n\nIMPORTANT: VOUS DEVEZ VOUS DECONNECTER ET VOUS RECONNECTER POUR QUE CELA PRENNE EFFET. RELANCER L\'INTERFACE NE FONCTIONNE PAS"};
SCT.LOCALS.OPTION_CHECK8 = { name = "Show all Power Gain", tooltipText = "Enables or Disables showing all power gain, not just those from the chat log\n\nNOTE: This is dependent on the regular Power Gain event being on, is VERY SPAMMY, and sometimes acts strange for Druids just after shapeshifting back to caster form."};
SCT.LOCALS.OPTION_CHECK9 = { name = "FPS Independent Mode", tooltipText = "Enables or Disables making the animation speed use your FPS or not. When on, makes the animations more consistent and greatly speeds them up on slow machines or in laggy situations."};
SCT.LOCALS.OPTION_CHECK10 = { name = "Show Overhealing", tooltipText = "Enables or Disables showing how much you overheal for against you or your targets. Dependent on 'Your Heals' being on."};
SCT.LOCALS.OPTION_CHECK11 = { name = "Alert Sounds", tooltipText = "Enables or Disables playing sounds for warning alerts."};
SCT.LOCALS.OPTION_CHECK12 = { name = "Spell Damage Colors", tooltipText = "Enables or Disables showing spell damage in colors per spell class (colors not configurable)"};
SCT.LOCALS.OPTION_CHECK13 = { name = "Enable Custom Events", tooltipText = "Enables or Disables using custom events. When disabled, much less memory is consumed by SCT."};
SCT.LOCALS.OPTION_CHECK14 = { name = "Enable Light Mode", tooltipText = "Enables or Disables SCT Light Mode. Light mode uses built in WoW Events for most SCT events and reduces combat log parsing. This means faster performance overall, but at a cost of a few features, including Custom Events.\n\nPLEASE be aware these WoW events do not provide as much feedback as the combat log and can be BUGGY."};
SCT.LOCALS.OPTION_CHECK15 = { name = "Flash", tooltipText = "Makes sticky crits 'Flash' into view."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="Vitesse du Texte", minText="Rapide", maxText="Lent", tooltipText = "Contr\195\180le la vitesse d\'animation du texte d\195\169roulant"};
SCT.LOCALS.OPTION_SLIDER2 = { name="Taille Texte", minText="Petit", maxText="Grand", tooltipText = "Contr\195\180le la taille du texte d\195\169roulant"};
SCT.LOCALS.OPTION_SLIDER3 = { name="PV %", minText="10%", maxText="90%", tooltipText = "Contr\195\180le le % de vie n\195\169cessaire pour donner un avertissement"};
SCT.LOCALS.OPTION_SLIDER4 = { name="Mana %", minText="10%", maxText="90%", tooltipText = "Contr\195\180le le % de mana n\195\169cessaire pour donner un avertissement"};
SCT.LOCALS.OPTION_SLIDER5 = { name="Transparence", minText="0%", maxText="100%", tooltipText = "Contr\195\180le la transparence du texte"};
SCT.LOCALS.OPTION_SLIDER6 = { name="Distance du Texte", minText="Petite", maxText="Grande", tooltipText = "Contr\195\180le la distance de d\195\169placement du texte"};
SCT.LOCALS.OPTION_SLIDER7 = { name="Centrer position X ", minText="-600", maxText="600", tooltipText = "Contr\195\180le la position du texte au centre"};
SCT.LOCALS.OPTION_SLIDER8 = { name="Centrer position Y ", minText="-400", maxText="400", tooltipText = "Contr\195\180le la position du texte au centre"};
SCT.LOCALS.OPTION_SLIDER9 = { name="Centrer Position X ", minText="-600", maxText="600", tooltipText = "Contr\195\180le la position du message au centre"};
SCT.LOCALS.OPTION_SLIDER10 = { name="Centrer Position Y ", minText="-400", maxText="400", tooltipText = "Contr\195\180le la position du message au centre"};
SCT.LOCALS.OPTION_SLIDER11 = { name="Temps d\'affichage: ", minText="Rapide", maxText="Lent", tooltipText = "Contr\195\180le le temps d\'affichage des messages"};
SCT.LOCALS.OPTION_SLIDER12 = { name="Taille: ", minText="Petite", maxText="Grande", tooltipText = "Contr\195\180le la taille des messages"};
SCT.LOCALS.OPTION_SLIDER13 = { name="Healer Filter", minText="0", maxText="500", tooltipText = "Controls the minimum amount a heal needs to heal you for to appear in SCT. Good for filtering out frequent small heals like Totems, Blessings, etc..."};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="Options SCT "..SCT.Version};
SCT.LOCALS.OPTION_MISC2 = {name="Options: Ev\195\168nement"};
SCT.LOCALS.OPTION_MISC3 = {name="Options: Texte"};
SCT.LOCALS.OPTION_MISC4 = {name="Options: Divers"};
SCT.LOCALS.OPTION_MISC5 = {name="Options: Alerte"};
SCT.LOCALS.OPTION_MISC6 = {name="Options: Animation"};
SCT.LOCALS.OPTION_MISC7 = {name="S\195\169lection: Profil"};
SCT.LOCALS.OPTION_MISC8 = {name="Sauver & Fermer", tooltipText = "Sauvegarde la configuration en cours et ferme les options"};
SCT.LOCALS.OPTION_MISC9 = {name="R.\195\160.Z.", tooltipText = "-ATTENTION-\n\nEtes vous certain de vouloir remettre SCT par d\195\169faut ?"};
SCT.LOCALS.OPTION_MISC10 = {name="S\195\169lection", tooltipText = "S\195\169lectionner le profil d\'un autre personnage"};
SCT.LOCALS.OPTION_MISC11 = {name="Lancer", tooltipText = "Lancer le profil d\'un autre personnage pour ce personne"};
SCT.LOCALS.OPTION_MISC12 = {name="Suppr.", tooltipText = "Supprimer le profil du personnage"}; 
SCT.LOCALS.OPTION_MISC13 = {name="Abandonner", tooltipText = "Abandonner la S\195\169lection"};
SCT.LOCALS.OPTION_MISC14 = {name="Texte", tooltipText = ""};
SCT.LOCALS.OPTION_MISC15 = {name="Messages", tooltipText = ""};
SCT.LOCALS.OPTION_MISC16 = {name="Options: Message"};
SCT.LOCALS.OPTION_MISC17 = {name="Spell Options"};
SCT.LOCALS.OPTION_MISC18 = {name="Misc.", tooltipText = ""};
SCT.LOCALS.OPTION_MISC19 = {name="Spells", tooltipText = ""};
SCT.LOCALS.OPTION_MISC20 = {name="Frame 2", tooltipText = ""};
SCT.LOCALS.OPTION_MISC21 = {name="Frame 2 Options", tooltipText = ""};
SCT.LOCALS.OPTION_MISC22 = {name="Classic Profile", tooltipText = "Load the Classic profile. Makes SCT act very close to how it used to by default"};
SCT.LOCALS.OPTION_MISC23 = {name="Performance Profile", tooltipText = "Load the Performance profile. Selects all the settings to get the best performance out of SCT"};
SCT.LOCALS.OPTION_MISC24 = {name="Split Profile", tooltipText = "Load the Split profile. Makes Incoming damage and events appear on the right side, and Incoming heals and buffs on the left side."};
SCT.LOCALS.OPTION_MISC25 = {name="Grayhoof Profile", tooltipText = "Load Grayhoof's profile. Sets SCT to act how Grayhoof sets his."};
SCT.LOCALS.OPTION_MISC26 = {name="Built In Profiles", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="Split SCTD Profile", tooltipText = "Load Split SCTD profile. If you have SCTD installed, makes Incoming events appear on the right side, and Outgoing events appear on the left side, and misc appear on top."};

--Animation Types
SCT.LOCALS.OPTION_SELECTION1 = { name="Type d\'Animation", tooltipText = "Le type d\'animation que vous voulez utiliser", table = {[1] = "Vertical (Normal)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down", [5] = "Angled Up", [6] = "Sprinkler"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="Style de C\195\180t\195\169", tooltipText = "Choix du C\195\180t\195\169 ou vous voulez afficher le d\195\169rouler le texte", table = {[1] = "Alternating",[2] = "Damage Left",[3] = "Damage Right"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="Font", tooltipText = "Choix de la font que vous voulez utiliser", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION4 = { name="Contour de Font", tooltipText = "Choix du contour de font que vous voulez utiliser", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="Font Message", tooltipText = "Choix de la font Message que vous voulez utiliser", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION6 = { name="Contour de la Font", tooltipText = "Choix du contour de font Message que vous voulez utiliser", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};