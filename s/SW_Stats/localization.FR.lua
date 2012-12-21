--[[
	Thanks to "lethaluciole" for this translation.
	This is pretty outdated an could use some TLC
]]--
if (GetLocale() == "frFR") then
SW_RootSlashes = {"/swstats", "/sws"};


SW_CONSOLE_NOCMD = "Cette commande n\'existe pas: ";
SW_CONSOLE_HELP ="Aide: "
SW_CONSOLE_NIL_TRAILER = " n\'est pas d\195\169\fini."; -- space at beginning
SW_CONSOLE_SORTED = "Tri\195\169";
SW_CONSOLE_NOREGEX = "Il n\'y a pas de Regex pour cet \195\169v\195\168nement.";
SW_CONSOLE_FALLBACK = "Regex trouv\195\169 - ajout\195\169 \195\160 la carte";
SW_FALLBACK_BLOCK_INFO = "Cet \195\169v\195\168nement ne peut se mettre \195\160 jour par lui-m\195\170me.";
SW_FALLBACK_IGRNORED = "Cet \195\169v\195\168nement a \195\169t\195\169 ignor\195\169.";
SW_EMPTY_EVENT = "Ecouter les \195\169v\195\168nements d\195\169suets?: ";
SW_INFO_PLAYER_NF = "Il n\'y a pas d\'information pour:";
SW_PRINT_INFO_FROMTO = "|cffffffffDe:|r%s, |cffffffff\195\160:|r%s,";
SW_PRINT_ITEM = "|cffffffff%s:|r%s,";
SW_PRINT_ITEM_DMG = "D\195\162gats";
SW_PRINT_ITEM_HEAL = "Soign\195\169";
SW_PRINT_ITEM_THROUGH = "A travers";
SW_PRINT_ITEM_TYPE = "Type";
SW_PRINT_ITEM_CRIT = "|cffff2020CRIT|r";
SW_PRINT_ITEM_WORLD = "Monde";
SW_PRINT_ITEM_NORMAL = "Normal";
SW_PRINT_ITEM_RECIEVED = "Re\195\167u";
SW_PRINT_INFO_RECIEVED = "|cffff2020Dmg:%s|r, |cff20ff20Heal:%s|r";
SW_PRINT_ITEM_TOTAL_DONE = "Total";
SW_PRINT_ITEM_NON_SCHOOL = "Autres";
SW_PRINT_ITEM_IGNORED = "Ignor\195\169";
SW_SYNC_CHAN_JOIN = "|cff20ff20SWSync: Vous rejoignez:|r";
SW_SYNC_CHAN_FAIL= "|cffff2020SWSync: Vous ne pouvez pas rejoindre:|r";

SW_BARS_WIDTHERROR = "La barre est trop large!"
SW_SYNC_JOINCHECK_FROM = "Rejoindre SWSyncChannel %s de: %s?"
SW_SYNC_JOINCHECK_INFO = "Les anciennes donn\195\169es seront perdues!"
SW_SYNC_CURRENT = "Actuel SyncChannel: %s";
SW_B_CONSOLE = "C";
SW_B_SETTINGS = "S";
SW_B_REPORT = "R";
SW_B_SYNC = "S";

--[[
   you can ONLY localize the values! NOT the keys
   don't change aynthing like this ["someString"]
--]]
SW_Spellnames = {
	[1] = "Délivrance de la malédiction mineure",
	[2] = "Délivrance de la malédiction",
	[3] = "Dissipation de la magie",
	[4] = "Guérison des maladies",
	[5] = "Abolir maladie",
	[6] = "Purification",
	[7] = "Epuration",
	[8] = "Guérison du poison",
	[9] = "Abolir le poison",
	[10] = "Expiation",
}
SW_InfoTypes[19]["d"] = "How often did somebody 'decurse'?:"..SW_GetSpellList();

SW_LocalizedGUI ={
	["SW_FrameConsole_Title"] = "SW v"..SW_VERSION,
	["SW_FrameConsole_Tab1"] = "G\195\169neral",
	["SW_FrameConsole_Tab2"] = "Eventinfo",
	--["SW_FrameConsole_Tab3"] = "Param\195\168tres",
	["SW_BarSettingsFrameV2_Tab1"] = "Donn\195\169es",
	["SW_BarSettingsFrameV2_Tab2"] = "Visuel",
	["SW_Chk_ShowEventText"] = "Event->Voir Regex",
	["SW_Chk_ShowOrigStrText"] = "Voir le log",
	["SW_Chk_ShowRegExText"] = "Voir Regex",
	["SW_Chk_ShowMatchText"] = "Voir correspondances",
	["SW_Chk_ShowSyncInfoText"] = "Voir messages synchronis\195\169s",
	["SW_Chk_ShowOnlyFriendsText"] = "Ne voir que les 'amis'.",
	["SW_Chk_ShowSyncBText"] = "Voir le bouton de sync",
	["SW_Chk_ShowConsoleBText"] = "Voir le bouton de console",
	["SW_Chk_MergePetsText"] = "Confondre Pet et ma\195\174tre",
	["SW_RepTo_SayText"] = "Dire",
	["SW_RepTo_GroupText"] = "Groupe",
	["SW_RepTo_RaidText"] = "Raid",
	["SW_RepTo_GuildText"] = "Guilde",
	["SW_RepTo_ChannelText"] = "Channel",
	["SW_RepTo_WhisperText"] = "Whisper",
	["SW_BarReportFrame_Title_Text"] = "Rapporter \195\160..",
	["SW_Chk_RepMultiText"] = "Multiligne",
	["SW_Filter_PCText"] = "PC",
	["SW_Filter_NPCText"] = "NPJ",
	["SW_Filter_GroupText"] = "Groupe/Raid",
	--["SW_Filter_EverGroupText"] = "Ever Group/Raid", -- needs translation
	["SW_Filter_NoneText"] = "Rien",
	["SW_GeneralSettings_Title_Text"] = "Param\195\168tres g\195\169n\195\169raux",
	["SW_BarSyncFrame_Title_Text"] = "SyncChannel Param\195\168tres",
	["SW_BarSettingsFrameV2_Title_Text"] = "Param\195\168tres",
	["SW_BarSyncFrame_SyncLeave"] = "Quitter",
	["SW_BarSyncFrame_OptGroupText"] = "Groupe",
	["SW_BarSyncFrame_OptRaidText"] = "Raid",
	["SW_BarSyncFrame_OptGuildText"] = "Guilde",
	["SW_BarSyncFrame_SyncSend"] = "Envoyer à",
	["SW_CS_Damage"] = "Couleur: D\195\169g\195\162ts",
	["SW_CS_Heal"] = "Couleur: Soins",
	["SW_CS_BarC"] = "Couleur: Barre",
	["SW_CS_FontC"] = "Couleur: Font",
	["SW_CS_OptC"] = "Couleur: Bouton",
	["SW_TextureSlider"] = "Texture:",
	["SW_FontSizeSlider"] = "Taille de la police:",
	["SW_BarHeightSlider"] = "H:",
	--["SW_BarWidthSlider"] = "Largeur de la barre:", old 1.4.2 no longer in use
	-- ["SW_ColCountSlider"] = "Changes the bar width for this view", new 1.4.2 needs translation
	
	["SW_OptChk_NumText"] = "Somme",
	["SW_OptChk_RankText"] = "Rang",
	["SW_OptChk_PercentText"] = "%",
	["SW_VarInfoLbl"] = "Cette info demande une cible. Click Change to type in a name or click FromTarget to use your current target",
	["SW_SetInfoVarFromTarget"] = "De la cible",
	["SW_ColorsOptUseClassText"] = "Couleur classe",
}

SW_GS_Tooltips["SW_Chk_ShowOnlyFriends"] = "Cette option est seulement utilis\195\169e pour filtrer les rapports envoy\195\169s \195\160 la console via /sws.";
SW_GS_Tooltips["SW_Chk_ShowSyncB"] = "Option permettant d\'afficher un bouton suppl\195\169mentaire pour les param\195\168 de Sync sur la fen\195\170tre principale.";
SW_GS_Tooltips["SW_Chk_ShowConsoleB"] = "Option permettant d\'afficher un bouton suppl\195\169mentaire pour la console sur la fen\195\170tre principale.";
SW_GS_Tooltips["SW_CS_Damage"] = "La couleur de la barre de d\195\169g\195\162ts. Utilis\195\169 lorsque vous regardez les d\195\169tails";
SW_GS_Tooltips["SW_CS_Heal"] = "La couleur de la barre de soins";
SW_GS_Tooltips["SW_CS_BarC"] = "La couleur de la barre utilis\195\169e pour cette vue";
SW_GS_Tooltips["SW_CS_FontC"] = "La couleur de la police utilis\195\169e pour cette vue.";
SW_GS_Tooltips["SW_CS_OptC"] = "La couleur des boutons en dessous de la fen\195\170tre principale";
SW_GS_Tooltips["SW_TextureSlider"] = "Texture de la barre pour cette vue.";
SW_GS_Tooltips["SW_FontSizeSlider"] = "Taille de la police de la barre pour cette vue.";
SW_GS_Tooltips["SW_BarHeightSlider"] = "Changer la hauteur de la barre pour cette vue.";
--SW_GS_Tooltips["SW_BarWidthSlider"] = "Changer la largeur de la barre pour cette vue"; removed 1.4.2
--SW_GS_Tooltips["SW_ColCountSlider"] = "Changes the amount of columns for this view."; -- 1.4.2 needs translation
SW_GS_Tooltips["SW_SetOptTxtFrame"] = "Changer le texte affich\195\169 sur les boutons du bas de la fen\195\170tre principale.";
SW_GS_Tooltips["SW_SetFrameTxtFrame"] = "Changer le texte affiche\195\169 en titre sur la fen\195\170 principale.";
SW_GS_Tooltips["SW_OptChk_Num"] = "Afficher en chiffre (Ex: D\195\169g\195\162ts, Soins etc.).";
SW_GS_Tooltips["SW_OptChk_Rank"] = "Afficher le rang.";
SW_GS_Tooltips["SW_OptChk_Percent"] = "Afficher le pourcentage de d\195\169g\195\162ts / soins.";
SW_GS_Tooltips["SW_Filter_None"] = "Aucun filtre PC/NPC/Groupe/raid selectionn\195\169. (Toutes les donn\195\169es entrantes seront trait\195\169es!)";
SW_GS_Tooltips["SW_Filter_PC"] = "Filtre joueur activ\195\169. Fonctionne uniquement s\'il a fait partie du groupe ou si vous l'\avez cibl\195\169";
SW_GS_Tooltips["SW_Filter_NPC"] = "Filtre NPJ activ\195\169. Fonctionne uniquement si vous avez cibl\195\169 le NPJ.";
SW_GS_Tooltips["SW_Filter_Group"] = "Filtre Groupe/Raid.";
SW_GS_Tooltips["SW_ClassFilterSlider"] = "Filtre par classe. Ici vous pouvez d\195\169finir une classe sp\195\169cifique \195\160 afficher";
SW_GS_Tooltips["SW_InfoTypeSlider"] = "Le principal s\195\169lecteur de donn\195\169es. S\195\169lectionnez les donn\195\169es que vous voulez voir sur ce tableau. ";
SW_GS_Tooltips["SW_ColorsOptUseClass"] = "Utiliser les couleurs de classes. Les barres prendront la couleur de la classe du joueur.";
--SW_GS_Tooltips["SW_Filter_EverGroup"] = "Only people that have been in your group or raid are shown."; -- needs translation
--SW_GS_Tooltips["SW_OptChk_Running"] = "Uncheck to pause data collection. Check to continue collecting data. You can not pause data collection while being in a sync channel."; -- 1.5 needs translation
-- edit boxes
SW_GS_EditBoxes["SW_SetOptTxtFrame"] = {"Changer","Texte bouton: ", "Nouveau texte bouton:" };
SW_GS_EditBoxes["SW_SetFrameTxtFrame"] = {"Changer","Texte Frame: ", "Nouveau texte frame:" };
SW_GS_EditBoxes["SW_SetInfoVarTxtFrame"] = {"Changer","Info pour: ", "Nouveau nom de joueur ou mob:" };
SW_GS_EditBoxes["SW_SetSyncChanTxtFrame"] = {"Changer","SyncChannel: ", "Nouveau SyncChannel:" };

--popups
StaticPopupDialogs["SW_Reset"]["text"] = "\195\170tes-vous certain de vouloir relancer les donn\195\169es??"
StaticPopupDialogs["SW_ResetFailInfo"]["text"] = "Vous vous trouvez sur un SynChannel vous ne pouvez pas relancer les donn\195\169s!";
StaticPopupDialogs["SW_ResetSync"]["text"] = "Vous vous trouvez sur un SynChannel relancer les donn\195\169s affectera aussi les autres joueurs du raid!";

-- key bindig strings
BINDING_HEADER_SW_BINDINGS = "SW Stats";
BINDING_NAME_SW_BIND_TOGGLEBARS = "Afficher/Cacher la fen\195\170tre principale.";
BINDING_NAME_SW_BIND_CONSOLE = "Afficher/Cacher la console.";
BINDING_NAME_SW_BIND_PAGE1 = "Voir le tableau 1";
BINDING_NAME_SW_BIND_PAGE2 = "Voir le tableau 2";
BINDING_NAME_SW_BIND_PAGE3 = "Voir le tableau 3";
BINDING_NAME_SW_BIND_PAGE4 = "Voir le tableau 4";
BINDING_NAME_SW_BIND_PAGE5 = "Voir le tableau 5";
BINDING_NAME_SW_BIND_PAGE6 = "Voir le tableau 6";
BINDING_NAME_SW_BIND_PAGE7 = "Voir le tableau 7";
BINDING_NAME_SW_BIND_PAGE8 = "Voir le tableau 8";
BINDING_NAME_SW_BIND_PAGE9 = "Voir le tableau 9";
BINDING_NAME_SW_BIND_PAGE10 = "Voir le tableau 10";


function SW_FixLogStrings(str)
	local tmpStr = string.gsub(str, "(%%%d?$?s) de (%%%d?$?s)", "%1 DE %2");
	-- 1.4 consider this temp until i can test it on live myself (WOW 1.10 change)
	return string.gsub(tmpStr, "|2", "DE");
	
end

SW_mergeLocalization();
end