if GetLocale() == "deDE" then

  --
  -- German
  --

  CLEANPLAYERFRAME_MYADDONS_DESCRIPTION = "Entfernt den Text Gesundheit/Mana/Wut/Fokus/Energie vom Spielerportr\195\164t.";
  --CLEANPLAYERFRAME_MYADDONS_RELEASEDATE = "30. August 2006";

  CLEANPLAYERFRAME_CHATHELP = {
    HIGHLIGHT_FONT_COLOR_CODE .. "/cleanplayerframe" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Einstellungen \195\164ndern."
  };

  CLEANPLAYERFRAME_COMBOTEXT = { "Nichts \195\164ndern", "Nur Text entfernen", "Nur aktuellen Wert anzeigen" };
  CLEANPLAYERFRAME_COMBOLABLEL = "Spielerportr\195\164t:";

  CLEANPLAYERFRAME_PARTYTEXT = { "Deaktiviert", "Gesundheitswert anzeigen", "Farbigen Gesundheitswert anzeigen", "Farbigen Gesundheitswert + Nachrichten anzeigen" };
  CLEANPLAYERFRAME_PARTYLABEL = "Party:";

  CLEANPLAYERFRAME_TARGETTEXT = { "Deaktiviert",
                                  "Genauen Wert anzeigen wenn m\195\182glich, ansonsten Prozent",
                                  "Immer Prozent anzeigen",
                                  "Beides anzeigen" };
  CLEANPLAYERFRAME_TARGETLABEL = "Zielinfo:"

  CLEANPLAYERFRAME_FONTTEXT = { "Font ohne Umrandung", "Font mit Umrandung" };
  CLEANPLAYERFRAME_FONTLABEL = "Font:";

  CLEANPLAYERFRAME_COLORIZEBARS = "Farbige Gesundheitsbalken";
  CLEANPLAYERFRAME_PARTYPERCENT = "Zeige Gesundheit der\nGrupppenmitglieder in Prozent";
  CLEANPLAYERFRAME_SMALLFONT = "Verwende kleinen Font im Spielerporträt";

  CLEANPLAYER_USEMODELS = "Verwende 3D-Modelle im Spieler-,\nParty- und Zielportr\195\164t";
  
  -- If the health value of a party member drops below "percentWarn" then "warn" message is displayed.
  -- If the health value of a party member drops below "percentDamger" then "danger" message is displayed.
  -- The message depends on YOUR class, eg. if you play a priest and a party member health is at 10% the message "Heal NOW!" is displayed.
  CLEANPLAYERFRAME_MESSAGES = {
    PRIEST = {
      warn = "  Heilung empfohlen",
      percentWarn = 45,
      danger = "  Heile JETZT!",
      percentDanger = 30 },
    ROGUE = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    WARRIOR = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    MAGE = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    DRUID = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    HUNTER = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    WARLOCK = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    SHAMAN = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    PALADIN = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 }};

else

  --
  -- English
  --

  CLEANPLAYERFRAME_MYADDONS_DESCRIPTION = "Removes text health/mana/rage/focus/energy from the player frame.";
  --CLEANPLAYERFRAME_MYADDONS_RELEASEDATE = "August 30, 2006";

  CLEANPLAYERFRAME_CHATHELP = {
    HIGHLIGHT_FONT_COLOR_CODE .. "/cleanplayerframe" .. LIGHTYELLOW_FONT_COLOR_CODE .. " - Change setup."
  };

  CLEANPLAYERFRAME_COMBOTEXT = { "Leave untouched", "Hide text", "Show only current value" };
  CLEANPLAYERFRAME_COMBOLABLEL = "Player frame:";

  CLEANPLAYERFRAME_TARGETTEXT = { "Disabled",
                                  "Show current value if possible, otherwise percent",
                                  "Show always percent",
                                  "Show both" };
  CLEANPLAYERFRAME_TARGETLABEL = "Targetinfo:"

  CLEANPLAYERFRAME_FONTTEXT = { "Use font without outline", "Use font with outline" };
  CLEANPLAYERFRAME_FONTLABEL = "Font:";

  CLEANPLAYERFRAME_PARTYTEXT = { "Disabled", "Show health values", "Show colorized health values", "Show colorized health values + assist messages" };
  CLEANPLAYERFRAME_PARTYLABEL =  "Party:";

  CLEANPLAYERFRAME_COLORIZEBARS = "Colorize health bars";
  CLEANPLAYERFRAME_PARTYPERCENT = "Show party member health in percent";
  CLEANPLAYERFRAME_SMALLFONT = "Use small font for player frame";

  CLEANPLAYER_USEMODELS = "Use 3D models in player, party\nand target frame";
  
  -- If the health value of a party member drops below "percentWarn" then warn message is displayed.
  -- If the health value of a party member drops below "percentDamger" then danger message is displayed.
  -- The message depends on YOUR class, eg. if you play a priest and a party member health is at 10% the message "Heal NOW!" is displayed.
  CLEANPLAYERFRAME_MESSAGES = {
    PRIEST = {
      warn = "  Healing recommended",
      percentWarn = 45,
      danger = "  Heal NOW!",
      percentDanger = 30 },
    ROGUE = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    WARRIOR = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    MAGE = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    DRUID = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    HUNTER = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    WARLOCK = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    SHAMAN = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 },
    PALADIN = {
      warn = "",
      percentWarn = -1,
      danger = "",
      percentDanger = -1 }};

end