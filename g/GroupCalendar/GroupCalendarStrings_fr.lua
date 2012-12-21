if GetLocale() == "frFR" then
	GroupCalendar_cTitle = "Calendrier de groupe v%s";

	GroupCalendar_cSun = "Dim";
	GroupCalendar_cMon = "Lun";
	GroupCalendar_cTue = "Mar";
	GroupCalendar_cWed = "Mer";
	GroupCalendar_cThu = "Jeu";
	GroupCalendar_cFri = "Ven";
	GroupCalendar_cSat = "Sam";

	GroupCalendar_cSunday = "Dimanche";
	GroupCalendar_cMonday = "Lundi";
	GroupCalendar_cTuesday = "Mardi";
	GroupCalendar_cWednesday = "Mercredi";
	GroupCalendar_cThursday = "Jeudi";
	GroupCalendar_cFriday = "Vendredi";
	GroupCalendar_cSaturday = "Samedi";

	GroupCalendar_cSelfWillAttend = "%s sera pr\195\169sent";

	GroupCalendar_cMonthNames = {"Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"};
	GroupCalendar_cDayOfWeekNames = {GroupCalendar_cSunday, GroupCalendar_cMonday, GroupCalendar_cTuesday, GroupCalendar_cWednesday, GroupCalendar_cThursday, GroupCalendar_cFriday, GroupCalendar_cSaturday};

	GroupCalendar_cLoadMessage = "GroupCalendar charg\195\169. Taper /calendar pour afficher le calendrier";
	GroupCalendar_cInitializingGuilded = "GroupCalendar: Initialisation des param\195\170tres pour joueur guild\195\169";
	GroupCalendar_cInitializingUnguilded = "GroupCalendar: Initialisation des param\195\170tres pour joueur non guild\195\169";
	GroupCalendar_cLocalTimeNote = "(%s local)";

	GroupCalendar_cOptions = "Configuration...";

	GroupCalendar_cCalendar = "Calendrier";
	GroupCalendar_cChannel = "Canal";
	GroupCalendar_cTrust = "Confiance";
	GroupCalendar_cAbout = "A propos";

	GroupCalendar_cUseServerDateTime = "Use server dates and times";
	GroupCalendar_cUseServerDateTimeDescription = "Turn on to show events using the server date and time, turn off to use your local date and time";
	
	GroupCalendar_cChannelConfigTitle = "Config canal de donn\195\169es";
	GroupCalendar_cChannelConfigDescription = "Le canal de donn\195\169es du calendrier est utilis\195\169 pour envoyer et recevoir les events entre joueurs. Toute personne pouvant joindre le canal pourra voir vos \195\169vents s\'ils le veulent. Pour garder votre calendrier priv\195\169 vous devriez utiliser un mot de passe pour le canal.";
	GroupCalendar_cAutoChannelConfig = "Configuration de canal automatique";
	GroupCalendar_cManualChannelConfig = "Configuration du canal manuelle";
	GroupCalendar_cStoreAutoConfig = "Stockage auto. configure les donn\195\169es depuis les notes du joueur";
	GroupCalendar_cAutoConfigPlayer = "Nom du joueur :";
	GroupCalendar_cApplyChannelChanges = "Appliquer";
	GroupCalendar_cAutoConfigTipTitle = "Configuration canal Automatique";
	GroupCalendar_cAutoConfigTipDescription = "Obtention automatique des configuration de canal depuis votre tableau de guilde. Vous devez obligatoirement \195\170tre dans une guilde et ce dispositif doit \195\170tre configur\195\169 par un officier de la guilde pour pouvoir l\'utiliser .";
	GroupCalendar_cManualConfigTipDescription = "Vous permet de saisir manuellement les informations de canal et de mot de passe.";
	GroupCalendar_cStoreAutoConfigTipDescription = "Permet \195\160 un officier de guilde de stocker la configuration du canal dans la note des joueurs s\195\169lection\195\169s dans le tableau de guilde.";
	GroupCalendar_cAutoConfigPlayerTipDescription = "Le nom du joueur dans le tableau de guilde ayant les donn\195\169es de configuration du canal.";
	GroupCalendar_cChannelNameTipTitle = "Nom du canal";
	GroupCalendar_cChannelNameTipDescription = "Le nom du canal de chat qui sera utilis\195\169 pour envoyer et recevoir les donn\195\169es des \195\169ents des autres joueurs";
	GroupCalendar_cConnectChannel = "Connecter";
	GroupCalendar_cDisconnectChannel = "D\195\169connecter";
	GroupCalendar_cChannelStatus =
	{
		Starting = {mText = "Status: D\195\169marrage...", mColor = {r = 1, g = 1, b = 0.3}},
		Connected = {mText = "Status: Canal de donn\195\169s connect\195\169", mColor = {r = 0.3, g = 1, b = 0.3}},
		Disconnected = {mText = "Status: Canal de donn\195\169es non connect\195\169", mColor = {r = 1, g = 0.2, b = 0.4}},
		Initializing = {mText = "Status: Initialisation du canal de donn\195\169es", mColor = {r = 1, g = 1, b = 0.3}},
		Error = {mText = "Error: %s", mColor = {r = 1, g = 0.2, b = 0.4}},
	};

	GroupCalendar_cConnected = "Connect\195\169";
	GroupCalendar_cDisconnected = "Deconnect\195\169";
	GroupCalendar_cTooManyChannels = "Vous avez d\195\169j\195\160 rejoint le nombre maximum de canaux (10)";
	GroupCalendar_cJoinChannelFailed = "N'a pas joint le canal pour une raison inconnue";
	GroupCalendar_cWrongPassword = "Le mot de passe est incorrect";
	GroupCalendar_cAutoConfigNotFound = "Donn\195\169es de configuration non trouv\195\169es dans le tableau de guilde";
	GroupCalendar_cErrorAccessingNote = "N'a pas pu retrouver les donn\195\169es de configuration";

	GroupCalendar_cTrustConfigTitle = "Config Confiance";
	GroupCalendar_cTrustConfigDescription = "Confiance d\195\169signe qui vous autoris\195\169s \195\160 vous ajouter des \195\169vents. Cela ne limite pas qui peut voir les \195\169ventsde votre calendrier. UTilisez un canal de donn\195\169es avec mot de passe pour restreindre l\'acc\195\168s \195\160 votre calendrier.";
	GroupCalendar_cTrustGroupLabel = "Confiance:";
	GroupCalendar_cEvent = "Event";
	GroupCalendar_cAttendance = "Assistance";

	GroupCalendar_cAboutTitle = "A propos de Group Calendar";
	GroupCalendar_cTitleVersion = "Group Calendar v"..gGroupCalendar_VersionString;
	GroupCalendar_cAuthor = "Designed and written by Baylord of Thunderlord";
	GroupCalendar_cTestersTitle = "Beta Testers";
	GroupCalendar_cTestersNames = "Agnosbear, Airmid, Allaric, Andrys, Chaz, Deathwave, Drizztt, Fizzlebang, Mistwalker, Ragdzar, Saracen, Thoros, Usps and Zya";
	GroupCalendar_cSpecialThanksTitle = "Special thanks for their extraordinary support to";
	GroupCalendar_cSpecialThanksNames = "Agnosbear, Fizzlebang, Mistwalker and SFC Alliance";
	GroupCalendar_cGuildURL = "http://www.starfleetclan.com";
	GroupCalendar_cRebuildDatabase = "Reconstruire la base de donn\195\169es";
	GroupCalendar_cRebuildDatabaseDescription = "Reconstruit la base de don\195\169es de votre personnage. Cela devrait r\195\169soudre les probl\195\168mes pour les personnes qui ne voient pas tous vos \195\169vents, Mais il y a un l\195\169ger risque que certaines r\195\169ponses d\'assistance d\'\195\169vent soient p\195\169rdues.";

	GroupCalendar_cTrustGroups =
	{
	"Quiconque ayant acc\195\168s au canal de donn\195\169es",
	"Les autres membres de votre guilde",
	"Uniquement ceux list\195\169s en dessous"
	};

	GroupCalendar_cTrustAnyone = "Confiance envers tous ceux ayant acc\195\168s au canal";
	GroupCalendar_cTrustGuildies = "Confiance envers les membres de la guilde";
	GroupCalendar_cTrustMinRank = "Rang Minimum:";
	GroupCalendar_cTrustNobody = "Confiance uniquement \195\160 ceux list\195\169s ci-dessous";
	GroupCalendar_cTrustedPlayers = "Joueurs additionels";
	GroupCalendar_cExcludedPlayers = "Joueurs exclus"
	GroupCalendar_cPlayerName = "Nom du joueur:";
	GroupCalendar_cAddTrusted = "Confiance";
	GroupCalendar_cRemoveTrusted = "Retirer";
	GroupCalendar_cAddExcluded = "Exclure";

	CalendarEventViewer_cTitle = "Voir Event";
	CalendarEventViewer_cDone = "Fini";

	CalendarEventViewer_cLevelRangeFormat = "Niveaux %i \195\160 %i";
	CalendarEventViewer_cMinLevelFormat = "Niveauxs %i et +";
	CalendarEventViewer_cMaxLevelFormat = "Jusqu\'au niveau %i";
	CalendarEventViewer_cAllLevels = "Tous niveaux";
	CalendarEventViewer_cSingleLevel = "Niveau %i uniquement";

	CalendarEventViewer_cYes = "Oui! Je participe \195\160 cet \195\169vent";
	CalendarEventViewer_cNo = "Non. je ne participe pas \195\160 cet \195\169vent";

	CalendarEventViewer_cResponseMessage =
	{
	"Status: Aucune r\195\169ponse envoy\195\169e",
	"Status: Attente de confirmation",
	"Status: Confirm\195\169 - Accept\195\169",
	"Status: Confirm\195\169 - En attente",
	"Status: Confirm\195\169 - Rejet\195\169",
	};

	CalendarEventEditorFrame_cTitle = "Ajout/Modif Event";
	CalendarEventEditor_cDone = "Fini";
	CalendarEventEditor_cDelete = "Effacer";

	CalendarEventEditor_cConfirmDeleteMsg = "Effacer \"%s\"?";

	-- Event names

	GroupCalendar_cGeneralEventGroup = "General";
	GroupCalendar_cDungeonEventGroup = "Dungeons";
	GroupCalendar_cBattlegroundEventGroup = "Battlegrounds";

	GroupCalendar_cMeetingEventName = "R\195\169union";
	GroupCalendar_cBirthdayEventName = "Anniversaire";

	GroupCalendar_cAQREventName = "Ruines d'Ahn'Qiraj";
	GroupCalendar_cAQTEventName = "Temple d'Ahn'Qiraj";
	GroupCalendar_cBFDEventName = "Profondeurs de Brassenoir";
	GroupCalendar_cBRDEventName = "Profondeurs de Blackrock";
	GroupCalendar_cUBRSEventName = "Profondeurs de Blackrock (Upper)";
	GroupCalendar_cLBRSEventName = "Profondeurs de Blackrock (Lower)";
	GroupCalendar_cBWLEventName = "Repaire de l'Aile Noire";
	GroupCalendar_cDeadminesEventName = "Les Mortemines";
	GroupCalendar_cDMEventName = "Hache Tripe";
	GroupCalendar_cGnomerEventName = "Gnomeregan";
	GroupCalendar_cMaraEventName = "Maraudon";
	GroupCalendar_cMCEventName = "Coeur de Magma";
	GroupCalendar_cOnyxiaEventName = "Repaire d'Onyxia";
	GroupCalendar_cRFCEventName = "Gouffre de Ragefeu";
	GroupCalendar_cRFDEventName = "Souilles de Tranchebauge";
	GroupCalendar_cRFKEventName = "Kraal de Tranchebauge";
	GroupCalendar_cSMEventName = "Monast\195\168re Ecarlate";
	GroupCalendar_cScholoEventName = "Scholomance";
	GroupCalendar_cSFKEventName = "Ombreroc";
	GroupCalendar_cStockadesEventName = "La Prison";
	GroupCalendar_cStrathEventName = "Stratholme";
	GroupCalendar_cSTEventName = "Le Temple Englouti";
	GroupCalendar_cUldEventName = "Uldaman";
	GroupCalendar_cWCEventName = "Cavernes de Lamentations";
	GroupCalendar_cZFEventName = "Zul'Farrak";
	GroupCalendar_cZGEventName = "Zul'Gurub";
	GroupCalendar_cAQEventName = "Ahn'Qiraj";

	GroupCalendar_cABEventName = "Arathi Basin";
	GroupCalendar_cAVEventName = "Alterac Valley";
	GroupCalendar_cWSGEventName = "Warsong Gulch";
	
	GroupCalendar_cZGResetEventName = "Zul'Gurub Resets";
	GroupCalendar_cMCResetEventName = "Molten Core Resets";
	GroupCalendar_cOnyxiaResetEventName = "Onyxia Resets";
	GroupCalendar_cBWLResetEventName = "Blackwing Lair Resets";
	GroupCalendar_cAQRResetEventName = "Ahn'Qiraj Ruins Resets";
	GroupCalendar_cAQTResetEventName = "Ahn'Qiraj Temple Resets";

	GroupCalendar_cTransmuteCooldownEventName = "Transmute Available";
	GroupCalendar_cSaltShakerCooldownEventName = "Salt Shaker Available";
	GroupCalendar_cMoonclothCooldownEventName = "Mooncloth Available";
	GroupCalendar_cSnowmasterCooldownEventName = "SnowMaster 9000 Available";

	GroupCalendar_cPersonalEventOwner = "Private";

	GroupCalendar_cRaidInfoMCName = GroupCalendar_cMCEventName;
	GroupCalendar_cRaidInfoOnyxiaName = GroupCalendar_cOnyxiaEventName;
	GroupCalendar_cRaidInfoZGName = GroupCalendar_cZGEventName;
	GroupCalendar_cRaidInfoBWLName = GroupCalendar_cBWLEventName;
	GroupCalendar_cRaidInfoAQRName = "Ahn'Qiraj";
	GroupCalendar_cRaidInfoAQTName = GroupCalendar_cAQTEventName;
	
	-- Race names

	GroupCalendar_cDwarfRaceName = "Nain";
	GroupCalendar_cGnomeRaceName = "Gnome";
	GroupCalendar_cHumanRaceName = "Humain";
	GroupCalendar_cNightElfRaceName = "Elfe de la Nuit";
	GroupCalendar_cOrcRaceName = "Orc";
	GroupCalendar_cTaurenRaceName = "Tauren";
	GroupCalendar_cTrollRaceName = "Troll";
	GroupCalendar_cUndeadRaceName = "Mort-vivan";
	GroupCalendar_cBloodElfRaceName = "Elfe de Sang";
	GroupCalendar_cDraeneiRaceName = "Draenei";

	-- Class names

	GroupCalendar_cDruidClassName = "Druide";
	GroupCalendar_cHunterClassName = "Chasseur";
	GroupCalendar_cMageClassName = "Mage";
	GroupCalendar_cPaladinClassName = "Paladin";
	GroupCalendar_cPriestClassName = "Pr\195\170tre";
	GroupCalendar_cRogueClassName = "Voleur";
	GroupCalendar_cShamanClassName = "Chaman";
	GroupCalendar_cWarlockClassName = "D\195\169moniste";
	GroupCalendar_cWarriorClassName = "Guerrier";

	-- Plural forms of class names

	GroupCalendar_cDruidsClassName = "Druides";
	GroupCalendar_cHuntersClassName = "Chasseurs";
	GroupCalendar_cMagesClassName = "Mages";
	GroupCalendar_cPaladinsClassName = "Paladins";
	GroupCalendar_cPriestsClassName = "Pr\195\170tres";
	GroupCalendar_cRoguesClassName = "Voleurs";
	GroupCalendar_cShamansClassName = "Chamans";
	GroupCalendar_cWarlocksClassName = "D\195\169monistes";
	GroupCalendar_cWarriorsClassName = "Guerriers";

	-- ClassColorNames are the indices for the RAID_CLASS_COLORS array found in FrameXML\Fonts.xml
	-- in the English version of WoW these are simply the class names in caps, I don't know if that's
	-- true of other languages so I'm putting them here in case they need to be localized

	GroupCalendar_cDruidClassColorName = "DRUID";
	GroupCalendar_cHunterClassColorName = "HUNTER";
	GroupCalendar_cMageClassColorName = "MAGE";
	GroupCalendar_cPaladinClassColorName = "PALADIN";
	GroupCalendar_cPriestClassColorName = "PRIEST";
	GroupCalendar_cRogueClassColorName = "ROGUE";
	GroupCalendar_cShamanClassColorName = "SHAMAN";
	GroupCalendar_cWarlockClassColorName = "WARLOCK";
	GroupCalendar_cWarriorClassColorName = "WARRIOR";

	-- Label forms of the class names for the attendance panel.  Usually just the plural
	-- form of the name followed by a colon

	GroupCalendar_cDruidsLabel = GroupCalendar_cDruidsClassName..":";
	GroupCalendar_cHuntersLabel = GroupCalendar_cHuntersClassName..":";
	GroupCalendar_cMagesLabel = GroupCalendar_cMagesClassName..":";
	GroupCalendar_cPaladinsLabel = GroupCalendar_cPaladinsClassName..":";
	GroupCalendar_cPriestsLabel = GroupCalendar_cPriestsClassName..":";
	GroupCalendar_cRoguesLabel = GroupCalendar_cRoguesClassName..":";
	GroupCalendar_cShamansLabel = GroupCalendar_cShamansClassName..":";
	GroupCalendar_cWarlocksLabel = GroupCalendar_cWarlocksClassName..":";
	GroupCalendar_cWarriorsLabel = GroupCalendar_cWarriorsClassName..":";

	GroupCalendar_cTimeLabel = "Temps:";
	GroupCalendar_cDurationLabel = "Dur\195\169e:";
	GroupCalendar_cEventLabel = "Event:";
	GroupCalendar_cTitleLabel = "Titre:";
	GroupCalendar_cLevelsLabel = "Niveaux:";
	GroupCalendar_cLevelRangeSeparator = "\195\160";
	GroupCalendar_cDescriptionLabel = "Description:";
	GroupCalendar_cCommentLabel = "Commentaire:";

	CalendarEditor_cNewEvent = "Nouvel Event...";
	CalendarEditor_cEventsTitle = "Events";

	GroupCalendar_cGermanTranslation = "Traduction allemande: Palyr de Silver Hand";
	GroupCalendar_cFrenchTranslation = "Traduction fran\195\167aise: Kisanth de Dalaran (EU)";
	GroupCalendar_cChineseTranslation = "Chinese translation by Aska of Royaltia (HK)";

	CalendarEventEditor_cNotAttending = "Ne viens pas";
	CalendarEventEditor_cConfirmed = "Confirm\195\169";
	CalendarEventEditor_cDeclined = "Declin\195\169";
	CalendarEventEditor_cStandby = "En attente";
	CalendarEventEditor_cPending = "En suspens";
	CalendarEventEditor_cUnknownStatus = "Inconnu %s";

	GroupCalendar_cChannelNameLabel = "Nom de canal:";
	GroupCalendar_cPasswordLabel = "Mot de passe:";

	GroupCalendar_cTimeRangeFormat = "%s \195\160 %s";

	GroupCalendar_cPluralMinutesFormat = "%d minutes";
	GroupCalendar_cSingularHourFormat = "%d heure";
	GroupCalendar_cPluralHourFormat = "%d heures";
	GroupCalendar_cSingularHourPluralMinutes = "%d heure %d minutes";
	GroupCalendar_cPluralHourPluralMinutes = "%d heures %d minutes";

	GroupCalendar_cLongDateFormat = "$day. $month $year";
	GroupCalendar_cLongDateFormatWithDayOfWeek = "$dow $day. $month $year";

	GroupCalendar_cNotAttending = "Ne viens pas";
	GroupCalendar_cAttending = "Viens";
	GroupCalendar_cPendingApproval = "Attente d\'approbation";

	BINDING_HEADER_GROUPCALENDAR_TITLE = "Calendrier de groupe";
	BINDING_NAME_GROUPCALENDAR_TOGGLE = "GroupCalendar [ON/OFF]";

	-- Tradeskill cooldown items

	GroupCalendar_cHerbalismSkillName = "Herboriste";
	GroupCalendar_cAlchemySkillName = "Alchimie";
	GroupCalendar_cEnchantingSkillName = "Enchantement";
	GroupCalendar_cLeatherworkingSkillName = "Travail du cuir";
	GroupCalendar_cSkinningSkillName = "Skinning";
	GroupCalendar_cTailoringSkillName = "Couture";
	GroupCalendar_cMiningSkillName = "Minage";
	GroupCalendar_cBlacksmithingSkillName = "Forge";
	GroupCalendar_cEngineeringSkillName = "Ing\195\169nierie";

	GroupCalendar_cTransmuteMithrilToTruesilver = "Transmutation : Mithril en vrai-argent";
	GroupCalendar_cTransmuteIronToGold = "TTransmutation : Fer en Or";
	GroupCalendar_cTransmuteLifeToEarth = "Transmutation de la Vie en Terre";
	GroupCalendar_cTransmuteWaterToUndeath = "Transmutation de l'Eau en Non-mort";
	GroupCalendar_cTransmuteWaterToAir = "Transmutation de l'Eau en Air";
	GroupCalendar_cTransmuteUndeathToWater = "Transmutation du Non-mort en Eau";
	GroupCalendar_cTransmuteFireToEarth = "Transmutation du Feu en Terre";
	GroupCalendar_cTransmuteEarthToLife = "Transmutation de la Terre en Vie";
	GroupCalendar_cTransmuteEarthToWater = "Transmutation de la Terre en Eau";
	GroupCalendar_cTransmuteAirToFire = "Transmutation de l'Air en Feu";
	GroupCalendar_cTransmuteArcanite = "Transmutation d'arcanite";
	GroupCalendar_cMooncloth = "Etoffe lunaire";

	GroupCalendar_cCharactersLabel = "Character:";

	GroupCalendar_cConfirmed = "Accepted";
	GroupCalendar_cStandby = "Standby";
	GroupCalendar_cDeclined = "Declined";
	GroupCalendar_cRemove = "Remove";
	GroupCalendar_cEditPlayer = "Edit Player...";
	GroupCalendar_cInviteNow = "Inivte to group";
	GroupCalendar_cStatus = "Status";
	GroupCalendar_cAddPlayerEllipses = "Add player...";

	GroupCalendar_cAddPlayer = "Add player";
	GroupCalendar_cPlayerLevel = "Level:";
	GroupCalendar_cPlayerClassLabel = "Class:";
	GroupCalendar_cPlayerRaceLabel = "Race:";
	GroupCalendar_cPlayerStatusLabel = "Status:";
	GroupCalendar_cRankLabel = "Guild rank:";
	GroupCalendar_cGuildLabel = "Guild:";
	GroupCalendar_cSave = "Save";
	GroupCalendar_cLastWhisper = "Last whisper:";
	GroupCalendar_cReplyWhisper = "Whisper reply:";

	GroupCalendar_cUnknown = "Unknown";
	GroupCalendar_cAutoConfirmationTitle = "Automatic Confirmations";
	GroupCalendar_cEnableAutoConfirm = "Enable automatic confirmations";
	GroupCalendar_cMinLabel = "min";
	GroupCalendar_cMaxLabel = "max";

	GroupCalendar_cAddPlayerTitle = "Add...";
	GroupCalendar_cAutoConfirmButtonTitle = "Settings...";

	GroupCalendar_cClassLimitDescription = "Use the fields below to set minimum and maximum numbers for each class.  Classes which haven't met the minimum yet will be filled first, the extra spots will be filled in order of response until the maximums are reached.";

	GroupCalendar_cViewByDate = "View by Date";
	GroupCalendar_cViewByRank = "View by Rank";
	GroupCalendar_cViewByName = "View by Name";
	GroupCalendar_cViewByStatus = "View by Status";
	GroupCalendar_cViewByClassRank = "View by Class and Rank";

	GroupCalendar_cMaxPartySizeLabel = "Maximum party size:";
	GroupCalendar_cMinPartySizeLabel = "Minimum party size:";
	GroupCalendar_cNoMinimum = "No minimum";
	GroupCalendar_cNoMaximum = "No maximum";
	GroupCalendar_cPartySizeFormat = "%d players";

	GroupCalendar_cInviteButtonTitle = "Invite Selected";
	GroupCalendar_cAutoSelectButtonTitle = "Select Players...";
	GroupCalendar_cAutoSelectWindowTitle = "Select Players";

	GroupCalendar_cNoSelection = "No players selected";
	GroupCalendar_cSingleSelection = "1 player selected";
	GroupCalendar_cMultiSelection = "%d players selected";

	GroupCalendar_cInviteNeedSelectionStatus = "Select players to be invited";
	GroupCalendar_cInviteReadyStatus = "Ready to invite";
	GroupCalendar_cInviteInitialInvitesStatus = "Sending initial invitations";
	GroupCalendar_cInviteAwaitingAcceptanceStatus = "Waiting for initial acceptance";
	GroupCalendar_cInviteConvertingToRaidStatus = "Converting to raid";
	GroupCalendar_cInviteInvitingStatus = "Sending invitations";
	GroupCalendar_cInviteCompleteStatus = "Invitations completed";
	GroupCalendar_cInviteReadyToRefillStatus = "Ready to fill vacant slots";
	GroupCalendar_cInviteNoMoreAvailableStatus = "No more players available to fill the group";
	GroupCalendar_cRaidFull = "Raid full";

	GroupCalendar_cInviteWhisperFormat = "[GroupCalendar] You are being invited to the event '%s'.  Please accept the invitation if you wish to join this event.";
	GroupCalendar_cAlreadyGroupedWhisper = "[GroupCalendar] You are already in a group.  Please /w back when you leave your group.";
	GroupCalendar_cAlreadyGroupedSysMsg = "(.+) is already in a group";
	GroupCalendar_cInviteDeclinedSysMsg = "(.+) declines your group invitation.";
	GroupCalendar_cNoSuchPlayerSysMsg = "No player named '(.+)' is currently playing.";

	GroupCalendar_cJoinedGroupStatus = "Joined";
	GropuCalendar_cInvitedGroupStatus = "Invited";
	GropuCalendar_cReadyGroupStatus = "Ready";
	GroupCalendar_cGroupedGroupStatus = "In another group";
	GroupCalendar_cStandbyGroupStatus = "Standby";
	GroupCalendar_cDeclinedGroupStatus = "Declined invitation";
	GroupCalendar_cOfflineGroupStatus = "Offline";
	GroupCalendar_cLeftGroupStatus = "Left group";

	GroupCalendar_cPriorityLabel = "Priority:";
	GroupCalendar_cPriorityDate = "Date";
	GroupCalendar_cPriorityRank = "Rank";

	GroupCalendar_cConfrimDeleteRSVP = "Remove %s from this event? They can't join again unless you add them back manually.";

	GroupCalendar_cConfirmSelfUpdateMsg = "%s";
	GroupCalendar_cConfirmSelfUpdateParamFormat = "A newer copy of the events for $mUserName is available from $mSender.  Do you want to update your events to the newer version? If you update then any events you've added or changed since logging in will be lost.";
	GroupCalendar_cConfirmSelfRSVPUpdateParamFormat = "A newer copy of the attendance requests for %mUserName is available from $mSender.  Do you wnat to update your attendance requests to the newer version?  If you update then any unconfirmed attendance changes you've made since logging in will be lost.";
	GroupCalendar_cUpdate = "Update";

	GroupCalendar_cConfirmClearWhispers = "Clear all recent whispers?";
	GroupCalendar_cClear = "Clear";
end
