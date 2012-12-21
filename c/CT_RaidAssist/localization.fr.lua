if ( GetLocale() == "frFR" ) then
    -- Version : French ( by Sasmira, Juki )
    -- Last Update : 06/01/2005
    
    CT_RAMENU_INSTALLATION = "CT_RaidAssist est un mod con\195\167u pour vous aider dans la gestion de raid. Il permet de surveiller la vie & la mana/energie/rage de n\'importe quel membre du raid, ainsi que de jusqu\'\195\160 5 cibles d\'unit\195\169. Vous pouvez montrer jusqu\'\195\160 4 buffs de votre choix, montrer les debuffs, et vous faire informer de cure les debuffs ou relancer les buffs.";
    
    CT_RAMENU_STEP1 = "1) Enregistrer un canal|c00FFFFFFAppuyer sur le bouton 'Options G\195\169n\195\169rales' ci-dessous et choisissez un canal. Notez que chaque utilisateur de ce mod dans le raid doit choisir le m\195\170me canal. Notez aussi que le mod choisi un canal par d\195\169faut nomm\195\169 |rCTNomGuilde |c00FFFFFF(sans les espaces).|r";
    
    CT_RAMENU_STEP2 = "2) Joindre le canal\n|c00FFFFFFUne fois que votre canal est choisi, appuyez sur 'Joindre Canal\' pour \195\170tre sur d\'\195\170tre dans le canal. Les leaders/promus peuvent broadcast le canal au raid, ce qui choisira le bon canal pour tout le monde, tout ce qui leur reste \195\160 faire est de taper |r/raidassist join|c00FFFFFF.|r";
    
    CT_RAMENU_STEP3 = "3) Sentez la magie !\n|c00FFFFFFLe mod devrait \195\170tre maintenant correctement configur\195\169, et pr\195\170t \195\160 l\'emploi. Vous pouvez s\195\169lectionner quels groupes montrer en les cochant ou d\195\169cochant sur la fen\195\170tre CTRaid. Pour configurer des param\195\168tres additionnels, utilisez les options ci-dessous :";
    
    CT_RAMENU_BUFFSDESCRIPT = "Selectionnez les buffs et debuffs que vous voulez montrer. Un max de 4 buffs peut \195\170tre montr\195\169. Les debuffs changeront la couleur de la fen\195\170tre avec celle que vous avez choisi.";
	CT_RAMENU_BUFFSTOOLTIP = "Utilisez les fl\195\170ches pour d\195\169placer les buffs. Si la limite est d\195\169pass\195\169e, ceux du haut sont prioritaires.";
	CT_RAMENU_DEBUFFSTOOLTIP = "Utilisez les fl\195\170ches pour d\195\169placer les debuffs. Si la limite est d\195\169pass\195\169e, ceux du haut sont prioritaires.";
    CT_RAMENU_GENERALDESCRIPT = "Ci-dessous vous trouverez les options pour changer la fa\195\167on dont les choses sont affich\195\169es. Activer une cible d\'unit\195\169 vous montrera la cible des joueurs d\195\169sign\195\169s comme Main Tank (MT). Les leaders ou les promus peuvent faire un clic droit sur un joueur dans la fen\195\170tre CTRaid et les d\195\169signer comme Main Tank (MT). Il peut y avoir jusqu\'\195\160 5 Main Tank et donc 5 cibles d\'unit\195\169. Les leaders ou les promus du raid peuvent aussi appuyer sur le bouton 'Mettre \195\160 Jour Statut' pour mettre \195\160 jour la vie, mana, et buffs pour tout le monde dans le raid.";
    CT_RAMENU_REPORTDESCRIPT = "Cocher une case vous fait rapporter la vie et la mana pour la personne correspondante. Si vous ou la personne quitte le groupe, vous arreterez de rapporter.";
    
    BINDING_HEADER_CT_RAIDASSIST = "CT_RaidAssist";
    BINDING_NAME_CT_CUREDEBUFF = "Cure Debuffs Raid"; 
    BINDING_NAME_CT_RECASTRAIDBUFF = "Relancer Buffs Raid";
    BINDING_NAME_CT_SHOWHIDE = "Montrer/Cacher Fen\195\170tre Raid";
    BINDING_NAME_CT_TOGGLEDEBUFFS = "Afficher/Masquer Buff/Debuff";
    BINDING_NAME_CT_ASSISTMT1 = "Assister MT 1";
    BINDING_NAME_CT_ASSISTMT2 = "Assister MT 2";
    BINDING_NAME_CT_ASSISTMT3 = "Assister MT 3";
    BINDING_NAME_CT_ASSISTMT4 = "Assister MT 4";
    BINDING_NAME_CT_ASSISTMT5 = "Assister MT 5";
    
    CT_RAMENU_FAQ1 = "Q. Peut-on d\195\169placer les groupes CTRaid?";
	CT_RAMENU_FAQANSWER1 = "Assurez vous que \"Bloquer Positions Groupes\" est d\195\169coch\195\169 et que \"Montrer Noms Groupes\" est coch\195\169, ensuite faites glisser en cliquant sur 'Groupe #'.";
    CT_RAMENU_FAQ2 = "Q. Comment envoyer un message d\'alerte CTRaid?";
	CT_RAMENU_FAQANSWER2 = "Les leaders ou les promus du raid peuvent envoyer une alerte sur l\'\195\169cran \195\160 tous les membres du raid utilisant le mod en tapant /rs <texte> où <text> est votre message. Chaque personne peut changer la couleur d\'affichage de ces alertes.";
    CT_RAMENU_FAQ3 = "Q. Comment utiliser les options d\'invite?";
	CT_RAMENU_FAQANSWER3 = "Les leaders ou les promus du raid peuvent /rainvite xx-yy (/rainvite 58-60) pour inviter tous les membres de la guilde avec le level sp\195\169cifi\195\169.  /rakeyword affecte un mot de passe, si quelqu\'un vous l\'envoi (/tell), il sera automatiquement invit\195\169.";
    CT_RAMENU_FAQ4 = "Q. Certains membres du raid sont montr\195\169s comme N/A, qu\'est ce que cel\195\160 veut dire?";
	CT_RAMENU_FAQANSWER4 = "Si quelqu\'un est montr\195\169 comme N/A, c'est qu\'il ne poss\195\168de pas le mod ou qu\'il n\'est pas bien configur\195\169. Un leader ou un promu du raid peut broadcast le canal pour que tout le monde ait le m\195\170me. Ils doivent ensuite joindre le canal.";
    CT_RAMENU_FAQ5 = "Q. Le nom des membres du raid change de couleur, pourquoi?";
	CT_RAMENU_FAQANSWER5 = "Quand une personne est debuff, cel\195\160 change la couleur de fond de leur case avec la couleur que vous avez choisi dans les 'Options Buffs'. Si vous ne voulez pas voir quand quelqu\'un est debuff, d\195\169cochez simplement l\'option debuff.";
    CT_RAMENU_FAQ6 = "Q. Quand j'invite en masse, il n\'invite pas tout le monde, comment ca se fait?";
	CT_RAMENU_FAQANSWER6 = "Le jeu n\'obtient pas d\'informations \195\160 propos des membres de votre guilde avant que vous visitiez l\'onglet de guilde. Ouvrez l\'onglet de guilde et r\195\169essayez d\'inviter en masse.";
    CT_RAMENU_FAQ12 = "Pour plus d\'informations sur les mods CT, des suggestions, des commentaires, ou pour des questions sans r\195\169ponses, rendez vous sur http://www.ctmod.net";
	
	-- Class
	CT_RA_WARRIOR = "Guerrier";
	CT_RA_ROGUE = "Voleur";
	CT_RA_HUNTER = "Chasseur";
	CT_RA_MAGE = "Mage";
	CT_RA_WARLOCK = "D\195\169moniste";
	CT_RA_SHAMAN = "Chaman";
	CT_RA_PALADIN = "Paladin";
	CT_RA_DRUID = "Druide";
	CT_RA_PRIEST = "Pr\195\170tre";
	
	CT_RA_AFKMESSAGE = "Vous \195\170tes maintenant ABS : (.+)";
	CT_RA_DNDMESSAGE = "Vous \195\170tes maintenant en mode Ne pas d\195\169ranger : (.+)%.";
	
	-- Buffs
	CT_RA_POWERWORDFORTITUDE = { "Mot de pouvoir : Robustesse", "Pri\195\168re de robustesse" };
	CT_RA_MARKOFTHEWILD = { "Marque du fauve", "Don du fauve" };
	CT_RA_ARCANEINTELLECT = { "Intelligence des arcanes", "Illumination des arcanes" };
	CT_RA_ADMIRALSHAT = "Chapeau d\'amiral";
	CT_RA_SHADOWPROTECTION = { "Protection contre l\'ombre", "Pri\195\168re de protection contre l\'Ombre" };
	CT_RA_POWERWORDSHIELD = "Mot de pouvoir : Bouclier";
	CT_RA_SOULSTONERESURRECTION = "R\195\169surrection de Pierre d\'\195\162me";
	CT_RA_DIVINESPIRIT = { "Esprit divin", "Pri\195\168re d'Esprit" };
	CT_RA_THORNS = "Epines";
	CT_RA_FEARWARD = "Gardien de peur";
	CT_RA_BLESSINGOFMIGHT = { "B\195\169n\195\169diction de puissance", "B\195\169n\195\169diction de puissance Sup\195\169rieure" };
	CT_RA_BLESSINGOFWISDOM = { "B\195\169n\195\169diction de sagesse", "B\195\169n\195\169diction de sagesse Sup\195\169rieure" };
	CT_RA_BLESSINGOFKINGS = { "B\195\169n\195\169diction des rois", "B\195\169n\195\169diction des rois Sup\195\169rieure" };
	CT_RA_BLESSINGOFSALVATION = { "B\195\169n\195\169diction de salut", "B\195\169n\195\169diction de salut Sup\195\169rieure" };
	CT_RA_BLESSINGOFLIGHT = { "B\195\169n\195\169diction de lumi\195\168re", "B\195\169n\195\169diction de lumi\195\168re Sup\195\169rieure" };
	CT_RA_BLESSINGOFSANCTUARY = { "B\195\169n\195\169diction du Sanctuaire", "B\195\169n\195\169diction du Sanctuaire Sup\195\169rieure" };
	CT_RA_REGROWTH = "R\195\169tablissement";
	CT_RA_REJUVENATION = "R\195\169cup\195\169ration";
	CT_RA_RENEW = "R\195\169novation";
	CT_RA_AMPLIFYMAGIC = "Amplification de la magie";
	CT_RA_DAMPENMAGIC = "Att\195\169nuer la magie";
	
	-- Debuffs
	CT_RA_MAGIC = "Magie";
	CT_RA_DISEASE = "Maladie";
	CT_RA_POISON = "Poison";
	CT_RA_CURSE = "Mal\195\169diction";
	CT_RA_WEAKENEDSOUL = "Ame_affaiblie";
	CT_RA_RECENTLYBANDAGED = "Un bandage a \195\169t\195\169 appliqu\195\169 r\195\169cemment";
	
	-- Cures
	CT_RA_DISPELMAGIC = "Dissiper la magie";
	CT_RA_ABOLISHDISEASE = "Abolir maladie";
	CT_RA_ABOLISHPOISON = "Abolir le poison";
	CT_RA_CLEANSE = "Epuration";
	CT_RA_PURIFY = "Purification";
	CT_RA_CUREDISEASE = "Gu\195\169rison des maladies";
	CT_RA_CUREPOISON = "Gu\195\169rison du poison";
	CT_RA_REMOVECURSE = "D\195\169livrance de la mal\195\169diction";
	CT_RA_REMOVELESSERCURSE = "D\195\169livrance de la mal\195\169diction mineure";
	
	-- Resurrections
	CT_RA_RESURRECTION = "R\195\169surrection";
	CT_RA_REDEMPTION = "R\195\169demption";
	CT_RA_REBIRTH = "Renaissance";
	CT_RA_ANCESTRALSPIRIT = "Esprit Ancestral";
	
	-- "Regexps"
	CT_RA_HASJOINEDRAIDREGEXP = "^([^%s]+) a rejoint le groupe de raid$";
	CT_RA_HASLEFTRAIDREGEXP = "^([^%s]+) a quitt\195\131\194\169 le groupe de raid$";
	CT_RA_TANKHASDIEDREGEXP = "^([^%s]+) meurt%.$";
end

CT_RA_FEIGNDEATH["fr"] = "Feindre la Mort";