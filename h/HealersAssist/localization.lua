--[[
  Healers Assist Localization file
  
 -- UTF8 Converter : http://black-fraternity.de/lua/utf8converter.php
]]

-- Buff textures
HA_BLESSING_OF_LIGHT_TEXTURE = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02";
HA_GREATER_BLESSING_OF_LIGHT_TEXTURE = "Interface\\Icons\\Spell_Holy_GreaterBlessingofLight";
HA_POWER_INFUSION_TEXTURE = "Interface\\Icons\\Spell_Holy_PowerInfusion";
HA_DIVINE_FAVOR_TEXTURE = "Interface\\Icons\\Spell_Holy_Heal";
HA_UNSTABLE_POWER_TEXTURE = "Interface\\Icons\\Spell_Lightning_LightningBolt01";
HA_HEALING_OF_THE_AGES_TEXTURE = "Interface\\Icons\\Spell_Nature_HealingWaveGreater";
-- Debuff textures
HA_MORTAL_STRIKE_TEXTURE = "Interface\\Icons\\Ability_Warrior_SavageBlow";
HA_MORTAL_WOUND_TEXTURE = "Interface\\Icons\\Ability_CriticalStrike";
HA_VEIL_OF_SHADOW_TEXTURE = "Interface\\Icons\\Spell_Shadow_GatherShadows"; -- Reduce healing effects by 75%
HA_NECROTIC_POISON_TEXTURE = "Interface\\Icons\\Ability_Creature_Poison_03"; -- Reduce healing effects by 90%
HA_GREEN_AFFLICTION_TEXTURE = "Interface\\Icons\\INV_Misc_Head_Dragon_Green"; -- Chromaggus Green affliction -- Reduce healing effects by 50%


if ( GetLocale() == "frFR" ) then
  -- French localized variables
  -- �(à) �(á) �(â) �(ã) �(ä) �(æ) �(ç) �(è) �(é) �(ê) �(ë) �(î) �(ï) �(ò) �(ó) �(ô) �(õ) �(ö) �(ù) �(ú) �(û) �(ü) '(’)
  -- => Displayed strings

  HA_CHAT_MISC_LOADED = "Chargé ! (/ha pour l’aide)";
  HA_CHAT_HELP_CHANNEL = "Indique le canal a utiliser. Ne rien indiquer pour ne plus utiliser de canal (Désactive l'addon)";
  HA_CHAT_HELP_SHOW = "Afficher la fenêtre principale de l'addon.";
  HA_CHAT_HELP_LOCK = "Verrouille ou non la fenêtre principale de l'addon.";
  HA_CHAT_HELP_AUTO = "Affichage automatiquement la fenêtre principale de l'addon quand vous etes dans un groupe ou un raid. La cache quand vous n'etes pas en groupé.";
  HA_CHAT_HELP_DEBUG = "Affiche ou non la fenêtre de debug.";
  HA_CHAT_HELP_VERSIONS = "Affiche la version de HA des membres du groupe/raid";
  HA_CHAT_HELP_MSG = "Envoie un message aux utilisateurs de HA dans votre groupe/raid";
  HA_CHAT_CMD_UNKNOWN = "Commande inconnue. Essayez /ha help";
  HA_CHAT_CMD_PARAM_ERROR = "Erreur de paramètre pour la commande ";
  HA_CHAT_LOCK_ON = "La fenêtre principale est maintenant verrouillée";
  HA_CHAT_LOCK_OFF = "La fenêtre principale n’est plus verrouillée";
  HA_TEXT_UPGRADE_NEEDED = "Une nouvelle version majeure de HealersAssist (incompatible avec celle-ci) est disponible. Il faut mettre à jour.";
  HA_TEXT_MINOR_VERSION = "Une nouvelle version mineure de HealersAssist est disponible. Vous devriez mettre à jour.";

  HA_CHAT_MSG_IN_REGEN = "%s entre en mode repos !"; -- $1=from
  HA_CHAT_MSG_OUT_OF_REGEN = "%s sort du mode repos !"; -- $1=from
  HA_CHAT_MSG_INNERVATED = "TU AS RECU UNE INNERVATION. TU PEUX CONTINUER A LANCER DES SORTS !!";
  HA_CHAT_MSG_INFUSED = "TU AS RECU UNE INFUSION DE PUISSANCE !! BLAST OU SOIGNE PENDANT 15 SEC !!!";

  HA_RANK = "Rang";
  HA_PASSIVE = "Passif";

  HA_Spells = {
    -- Druid
    ["Toucher guérisseur"] = { short="Toucher"; iname=HA_SPELL_HEALING_TOUCH },
    ["Rétablissement"] = { short="Rétabl"; iname=HA_SPELL_REGROWTH },
    ["Tranquilité"] = { short="Tranq"; iname=HA_SPELL_TRANQUILITY; group=true },
    ["Renaissance"] = { short="Résurrect"; iname=HA_SPELL_REBIRTH; cooldown=true; rez=true; nonheal=true },
    -- Priest
    ["Soins inférieurs"] = { short="Soins Inf"; iname=HA_SPELL_LESSER_HEAL },
    ["Soins"] = { short="Soins"; iname=HA_SPELL_HEAL },
    ["Soins rapides"] = { short="S Rapides"; iname=HA_SPELL_FLASH_HEAL },
    ["Soins supérieurs"] = { short="Soins Sup"; iname=HA_SPELL_GREATER_HEAL },
    ["Prière de soins"] = { short="Prière"; iname=HA_SPELL_PRAYER_OF_HEALING; group=true },
    ["Résurrection"] = { short="Résurrect"; iname=HA_SPELL_RESURRECTION; rez=true; nonheal=true },
    ["Puits de lumière"] = { short="Puits"; iname=HA_SPELL_LIGHTWELL; cooldown=true; nonheal=true },
    -- Shaman
    ["Vague de soins"] = { short="Vague soin"; iname=HA_SPELL_HEALING_WAVE },
    ["Vague de soins inférieurs"] = { short="Vague inf"; iname=HA_SPELL_LESSER_HEALING_WAVE },
    ["Salve de guérison"] = { short="Salve"; iname=HA_SPELL_CHAIN_HEAL; group=true },
    ["Esprit ancestral"] = { short="Résurrect"; iname=HA_SPELL_ANCESTRAL_SPIRIT; rez=true; nonheal=true },
    -- Paladin
    ["Lumière sacrée"] = { short="Lumière"; iname=HA_SPELL_HOLY_LIGHT },
    ["Eclair lumineux"] = { short="Eclair"; iname=HA_SPELL_FLASH_OF_LIGHT },
    ["Rédemption"] = { short="Résurrect"; iname=HA_SPELL_REDEMPTION; rez=true; nonheal=true },
  };

  HA_InstantSpells = {
    -- Druid
    ["Récupération"] = { short="Récup"; iname=HA_SPELL_REJUVENATION },
    ["Rétablissement sur le temps"] = { short="Rétabl"; iname=HA_SPELL_REGROWTH_HOT },
    ["Innervation"] = { short="Innerv"; iname=HA_SPELL_INNERVATE; cooldown=true; nonheal=true },
    ["Délivrance de la malédiction"] = { short="Malédiction"; iname=HA_SPELL_REMOVE_CURSE; nonheal=true },
    ["Abolir le poison"] = { short="Abolir"; iname=HA_SPELL_ABOLISH_POISON; nonheal=true },
    ["Guérison du poison"] = { short="Poison"; iname=HA_SPELL_CURE_POISON; nonheal=true },
    ["Prompte guérison"] = { short="Prompte"; iname=HA_SPELL_SWIFTMEND },
    -- Priest
    ["Rénovation"] = { short="Rénov"; iname=HA_SPELL_RENEW },
    ["Mot de pouvoir : Bouclier"] = { short="Bouclier"; iname=HA_SPELL_PWS; nonheal=true },
    ["Nova sacrée"] = { short="Nova"; iname=HA_SPELL_HOLY_NOVA; group=true },
    ["Infusion de puissance"] = { short="Infusion"; iname=HA_SPELL_POWER_INFUSION; cooldown=true; nonheal=true },
    ["Abolir maladie"] = { short="Abolir"; iname=HA_SPELL_ABOLISH_DISEASE; nonheal=true },
    ["Guérison des maladies"] = { short="Maladie"; iname=HA_SPELL_CURE_DISEASE; nonheal=true },
    ["Dissipation de la magie"] = { short="Dispel"; iname=HA_SPELL_DISPEL_MAGIC; nonheal=true },
    -- Paladin
    ["Horion sacré"] = { short="Horion"; iname=HA_SPELL_HOLY_SHOCK },
    ["Intervention divine"] = { short="Intervention"; iname=HA_SPELL_DIVINE_INTERVENTION; cooldown=true; nonheal=true },
    ["Bouclier divin"] = { short="Bouc. divin"; iname=HA_SPELL_DIVINE_SHIELD; cooldown=true; nonheal=true },
    ["Purification"] = { short="Purifi"; iname=HA_SPELL_PURIFY; nonheal=true },
    ["Epuration"] = { short="Epuration"; iname=HA_SPELL_CLEANSE; nonheal=true },
    ["Imposition des mains"] = { short="Imposition"; iname=HA_SPELL_LAY_ON_HANDS },
    ["B\195\169n\195\169diction de protection"] = { short="Protection"; iname=HA_SPELL_BLESSING_OF_PROTECTION; cooldown=true; nonheal=true },
    -- Shaman
    ["Totem de Vague de mana"] = { short="Vague mana"; iname=HA_SPELL_MANA_TIDE; cooldown=true; nonheal=true },
    ["Expiation"] = { short="Expiation"; iname=HA_SPELL_PURGE; nonheal=true },
  };
  
  HA_HotSpells = {
    -- Druid
    ["Récupération"] = HA_SPELL_REJUVENATION,
    ["Rétablissement"] = HA_SPELL_REGROWTH_HOT,
    -- Priest
    ["Rénovation"] = HA_SPELL_RENEW,
  };

  HA_PassiveSpells = {
    -- Shaman
    ["Réincarnation"] = { short="Réincarnation"; iname=HA_SPELL_REINCARNATION; cooldown=true; nonheal=true},
  };
  
  HA_ZONE_FELWOOD = "Gangrebois (Felwood)";
  HA_ZONE_RUINS_AHNQIRAJ = "Ruines d'Ahn'Qiraj";
  HA_ZONE_TEMPLE_AHNQIRAJ = "Ahn'Qiraj";
  HA_ZONE_MOLTEN_CORE = "Coeur du Magma";
  HA_ZONE_BLACKWING_LAIR = "Le repaire de l'Aile Noire";
  HA_ZONE_NAXXRAMAS = "Naxxramas";

  HA_DEBUF_NAME_NEFARIUS = "Voile de l'ombre";

  HA_PARSE_SPELL_FAILED_REASON = "Vous n'avez pas réussi à lancer (.+) : (.+)%.";

  function HA_FixLogStrings(str)
    return string.gsub(str, "(%%%d?$?s) de (%%%d?$?s)", "%1 DE %2");
  end


elseif ( GetLocale() == "deDE" ) then

  HA_CHAT_MISC_LOADED = "geladen! (/ha f\195\188r die Hilfe)";
  HA_CHAT_HELP_CHANNEL = "legt den zu benutzenden Channel fest. Um das Addon zu deaktivieren gebe keinen Channel an.";
  HA_CHAT_HELP_SHOW = "Zeigt das \195\156bersichtsfenster.";
  HA_CHAT_HELP_LOCK = "Fixiert das \195\156bersichtsfenster.";
  HA_CHAT_HELP_AUTO = "Legt fest ob das \195\156bersichtsfenster automatisch in gruppen angezeigt werden soll.";
  HA_CHAT_HELP_DEBUG = "Zeigt/Versteckt das Debug fenster";
  HA_CHAT_HELP_VERSIONS = "Prints version of all HA users in your group/raid";
  HA_CHAT_HELP_MSG = "Sends a message to all HA users in your group/raid";
  HA_CHAT_CMD_UNKNOWN = "Unbekannter Befehlt. Gebe /ha ein um die Hilfe zu sehen";
  HA_CHAT_CMD_PARAM_ERROR = "Falsche Parameter";
  HA_CHAT_LOCK_ON = "Das \195\156bersichtsfenster ist jetzt fixiert";
  HA_CHAT_LOCK_OFF = "Das \195\156bersichtsfenster ist jetzt beweglich";
  HA_TEXT_UPGRADE_NEEDED = "Es gibt ein wichtiges Update von Healers Assist. Du musst upgraden um die Funktionalit\195\164t zu gew\195\164hrleisten!.";
  HA_TEXT_MINOR_VERSION = "Es gibt ein Update von Healers Assist. Du solltest upgraden.";

  HA_CHAT_MSG_IN_REGEN = "%s regeneriert jetzt!"; -- $1=from
  HA_CHAT_MSG_OUT_OF_REGEN = "%s regeneriert nicht mehr!"; -- $1=from
  HA_CHAT_MSG_INNERVATED = "Du hast Anregen! Du solltest zu einer Waffe mit viel Willenskraft wechseln!";
  HA_CHAT_MSG_INFUSED = "Du hast Seele der Macht! Heilen!";

  HA_RANK = "Rang";
  HA_PASSIVE = "Passiv";

  HA_Spells = {
    -- Druid
    ["Heilende Ber\195\188hrung"] = { short="Touch"; iname=HA_SPELL_HEALING_TOUCH },
    ["Nachwachsen"] = { short="Regrowth"; iname=HA_SPELL_REGROWTH },
    ["Gelassenheit"] = { short="Tranq"; iname=HA_SPELL_TRANQUILITY; group=true },
    ["Wiedergeburt"] = { short="Rebirth"; iname=HA_SPELL_REBIRTH; cooldown=true; rez=true; nonheal=true },
    -- Priest
    ["Geringes Heilen"] = { short="Lesser heal"; iname=HA_SPELL_LESSER_HEAL },
    ["Heilen"] = { short="Heal"; iname=HA_SPELL_HEAL },
    ["Blitzheilung"] = { short="Flash heal"; iname=HA_SPELL_FLASH_HEAL },
    ["Gro\195\159e Heilung"] = { short="Greater heal"; iname=HA_SPELL_GREATER_HEAL },
    ["Gebet der Heilung"] = { short="Prayer"; iname=HA_SPELL_PRAYER_OF_HEALING; group=true },
    ["Auferstehung"] = { short="Resurrect"; iname=HA_SPELL_RESURRECTION; rez=true; nonheal=true },
    ["Brunnen des Lichts"] = { short="Brunnen"; iname=HA_SPELL_LIGHTWELL; cooldown=true; nonheal=true },
    -- Shaman
    ["Welle der Heilung"] = { short="Wave"; iname=HA_SPELL_HEALING_WAVE },
    ["Geringe Welle der Heilung"] = { short="Lesser wave"; iname=HA_SPELL_LESSER_HEALING_WAVE },
    ["Kettenheilung"] = { short="Chain heal"; iname=HA_SPELL_CHAIN_HEAL; group=true },
    ["Geist der Ahnen"] = { short="Resurrect"; iname=HA_SPELL_ANCESTRAL_SPIRIT; rez=true; nonheal=true },
    -- Paladin
    ["Heiliges Licht"] = { short="Holy light"; iname=HA_SPELL_HOLY_LIGHT },
    ["Lichtblitz"] = { short="Flash light"; iname=HA_SPELL_FLASH_OF_LIGHT },
    ["Erl\195\182sung"] = { short="Resurrect"; iname=HA_SPELL_REDEMPTION; rez=true; nonheal=true },
  };

  HA_InstantSpells = {
    -- Druid
    ["Verj\195\188ngung"] = { short="Rejuv"; iname=HA_SPELL_REJUVENATION },
    ["Nachwachsen (HoT)"] = { short="Regrowth"; iname=HA_SPELL_REGROWTH_HOT },
    ["Anregen"] = { short="Innerv"; iname=HA_SPELL_INNERVATE; cooldown=true; nonheal=true },
    ["Fluch aufheben"] = { short="Curse"; iname=HA_SPELL_REMOVE_CURSE; nonheal=true },
    ["Vergiftung aufheben"] = { short="Abolish"; iname=HA_SPELL_ABOLISH_POISON; nonheal=true },
    ["Vergiftung heilen"] = { short="Poison"; iname=HA_SPELL_CURE_POISON; nonheal=true },
    ["Rasche Heilung"] = { short="Swift"; iname=HA_SPELL_SWIFTMEND },
    -- Priest
    ["Erneuerung"] = { short="Renew"; iname=HA_SPELL_RENEW },
    ["Machtwort: Schild"] = { short="Shield"; iname=HA_SPELL_PWS; nonheal=true },
    ["Heilige Nova"] = { short="Nova"; iname=HA_SPELL_HOLY_NOVA; group=true },
    ["Seele der Macht"] = { short="Infusion"; iname=HA_SPELL_POWER_INFUSION; cooldown=true; nonheal=true },
    ["Krankheit aufheben"] = { short="Abolish"; iname=HA_SPELL_ABOLISH_DISEASE; nonheal=true },
    ["Krankheit heilen"] = { short="Disease"; iname=HA_SPELL_CURE_DISEASE; nonheal=true },
    ["Magiebannung"] = { short="Dispel"; iname=HA_SPELL_DISPEL_MAGIC; nonheal=true },
    -- Paladin
    ["Heiliger Schock"] = { short="Shock"; iname=HA_SPELL_HOLY_SHOCK },
    ["G\195\182ttliches Eingreifen"] = { short="Intervention"; iname=HA_SPELL_DIVINE_INTERVENTION; cooldown=true; nonheal=true },
    ["Gottesschild"] = { short="Div. shield"; iname=HA_SPELL_DIVINE_SHIELD; cooldown=true; nonheal=true },
    ["L\195\164utern"] = { short="Purify"; iname=HA_SPELL_PURIFY; nonheal=true },
    ["Reinigung des Glaubens"] = { short="Cleanse"; iname=HA_SPELL_CLEANSE; nonheal=true },
    ["Handauflegung"] = { short="Legung"; iname=HA_SPELL_LAY_ON_HANDS },
    ["Segen des Schutzes"] = { short="Protection"; iname=HA_SPELL_BLESSING_OF_PROTECTION; cooldown=true; nonheal=true },
    -- Shaman
    ["Totem der Manaflut"] = { short="Mana Tide"; iname=HA_SPELL_MANA_TIDE; cooldown=true; nonheal=true },
    ["Reinigen"] = { short="Purge"; iname=HA_SPELL_PURGE; nonheal=true },
  };
 
  HA_HotSpells = {
    -- Druid
    ["Verj\195\188ngung"] = HA_SPELL_REJUVENATION,
    ["Nachwachsen"] = HA_SPELL_REGROWTH_HOT,
    -- Priest
    ["Erneuerung"] = HA_SPELL_RENEW,
  };

  HA_PassiveSpells = {
    -- Shaman
    ["Reinkarnation"] = { short="Reinkarnation"; iname=HA_SPELL_REINCARNATION; cooldown=true; nonheal=true},
  };

  HA_ZONE_FELWOOD = "Teufelswald";
  HA_ZONE_RUINS_AHNQIRAJ = "Ruinen von Ahn'Qiraj";
  HA_ZONE_TEMPLE_AHNQIRAJ = "Ahn'Qiraj";
  HA_ZONE_MOLTEN_CORE = "Geschmolzener Kern";
  HA_ZONE_BLACKWING_LAIR = "Pechschwingenhort";
  HA_ZONE_NAXXRAMAS = "Naxxramas";

  HA_DEBUF_NAME_NEFARIUS = "Schleier des Schattens";
  
  HA_PARSE_SPELL_FAILED_REASON = "Ihr scheitert beim Wirken von (.+): (.+)%."
 
  function HA_FixLogStrings(str)
    return str;
  end

else
  -- Default English values
  HA_CHAT_MISC_LOADED = "Loaded ! (/ha for help)";
  HA_CHAT_HELP_CHANNEL = "Specifies the channel to use. Specify nothing to stop using a channel (disables the addon).";
  HA_CHAT_HELP_SHOW = "Shows the main window.";
  HA_CHAT_HELP_LOCK = "Locks or not the main window.";
  HA_CHAT_HELP_AUTO = "Automatically display the main window when you are in a group ou raid. Hide it when not grouped.";
  HA_CHAT_HELP_DEBUG = "Shows or not, the debug window.";
  HA_CHAT_HELP_VERSIONS = "Prints version of all HA users in your group/raid";
  HA_CHAT_HELP_MSG = "Sends a message to all HA users in your group/raid";
  HA_CHAT_CMD_UNKNOWN = "Unknown command. Try /ha help";
  HA_CHAT_CMD_PARAM_ERROR = "Parameter error for command ";
  HA_CHAT_LOCK_ON = "Main window is now locked";
  HA_CHAT_LOCK_OFF = "Main window is now unlocked";
  HA_TEXT_UPGRADE_NEEDED = "There is a new major version of HealersAssist (incompatible with yours) available. Please upgrade.";
  HA_TEXT_MINOR_VERSION = "There is a new minor verson of HealersAssist available. You should upgrade.";

  HA_CHAT_MSG_IN_REGEN = "%s enters regen state !"; -- $1=from
  HA_CHAT_MSG_OUT_OF_REGEN = "%s leaves regen state !"; -- $1=from
  HA_CHAT_MSG_INNERVATED = "YOU HAVE BEEN INNERVATED !! YOU CAN KEEP CASTING !!!";
  HA_CHAT_MSG_INFUSED = "YOU HAVE BEEN INFUSED WITH POWER !! GO BLAST OR HEAL FOR 15 SEC !!!";

  HA_RANK = "Rank";
  HA_PASSIVE = "Passive";

  HA_Spells = {
    -- Druid
    ["Healing Touch"] = { short="Touch"; iname=HA_SPELL_HEALING_TOUCH },
    ["Regrowth"] = { short="Regrowth"; iname=HA_SPELL_REGROWTH },
    ["Tranquility"] = { short="Tranq"; iname=HA_SPELL_TRANQUILITY; group=true },
    ["Rebirth"] = { short="Rebirth"; iname=HA_SPELL_REBIRTH; cooldown=true; rez=true; nonheal=true },
    -- Priest
    ["Lesser Heal"] = { short="Lesser heal"; iname=HA_SPELL_LESSER_HEAL },
    ["Heal"] = { short="Heal"; iname=HA_SPELL_HEAL },
    ["Flash Heal"] = { short="Flash heal"; iname=HA_SPELL_FLASH_HEAL },
    ["Greater Heal"] = { short="Greater heal"; iname=HA_SPELL_GREATER_HEAL },
    ["Prayer of Healing"] = { short="Prayer"; iname=HA_SPELL_PRAYER_OF_HEALING; group=true },
    ["Resurrection"] = { short="Resurrect"; iname=HA_SPELL_RESURRECTION; rez=true; nonheal=true },
    ["Lightwell"] = { short="Well"; iname=HA_SPELL_LIGHTWELL; cooldown=true; nonheal=true },
    -- Shaman
    ["Healing Wave"] = { short="Wave"; iname=HA_SPELL_HEALING_WAVE },
    ["Lesser Healing Wave"] = { short="Lesser wave"; iname=HA_SPELL_LESSER_HEALING_WAVE },
    ["Chain Heal"] = { short="Chain heal"; iname=HA_SPELL_CHAIN_HEAL; group=true },
    ["Ancestral Spirit"] = { short="Resurrect"; iname=HA_SPELL_ANCESTRAL_SPIRIT; rez=true; nonheal=true },
    -- Paladin
    ["Holy Light"] = { short="Holy light"; iname=HA_SPELL_HOLY_LIGHT },
    ["Flash of Light"] = { short="Flash light"; iname=HA_SPELL_FLASH_OF_LIGHT },
    ["Redemption"] = { short="Resurrect"; iname=HA_SPELL_REDEMPTION; rez=true; nonheal=true },
  };

  HA_InstantSpells = {
    -- Druid
    ["Rejuvenation"] = { short="Rejuv"; iname=HA_SPELL_REJUVENATION },
    ["Regrowth over time"] = { short="Regrowth"; iname=HA_SPELL_REGROWTH_HOT },
    ["Innervate"] = { short="Innerv"; iname=HA_SPELL_INNERVATE; cooldown=true; nonheal=true },
    ["Remove Curse"] = { short="Curse"; iname=HA_SPELL_REMOVE_CURSE; nonheal=true },
    ["Abolish Poison"] = { short="Abolish"; iname=HA_SPELL_ABOLISH_POISON; nonheal=true },
    ["Cure Poison"] = { short="Poison"; iname=HA_SPELL_CURE_POISON; nonheal=true },
    ["Swiftmend"] = { short="Swift"; iname=HA_SPELL_SWIFTMEND },
    -- Priest
    ["Renew"] = { short="Renew"; iname=HA_SPELL_RENEW },
    ["Power Word: Shield"] = { short="Shield"; iname=HA_SPELL_PWS; nonheal=true },
    ["Holy Nova"] = { short="Nova"; iname=HA_SPELL_HOLY_NOVA; group=true },
    ["Power Infusion"] = { short="Infusion"; iname=HA_SPELL_POWER_INFUSION; cooldown=true; nonheal=true },
    ["Abolish Disease"] = { short="Abolish"; iname=HA_SPELL_ABOLISH_DISEASE; nonheal=true },
    ["Cure Disease"] = { short="Disease"; iname=HA_SPELL_CURE_DISEASE; nonheal=true },
    ["Dispel Magic"] = { short="Dispel"; iname=HA_SPELL_DISPEL_MAGIC; nonheal=true },
    -- Paladin
    ["Holy Shock"] = { short="Shock"; iname=HA_SPELL_HOLY_SHOCK },
    ["Divine Intervention"] = { short="Intervention"; iname=HA_SPELL_DIVINE_INTERVENTION; cooldown=true; nonheal=true },
    ["Divine Shield"] = { short="Div. shield"; iname=HA_SPELL_DIVINE_SHIELD; cooldown=true; nonheal=true },
    ["Purify"] = { short="Purify"; iname=HA_SPELL_PURIFY; nonheal=true },
    ["Cleanse"] = { short="Cleanse"; iname=HA_SPELL_CLEANSE; nonheal=true },
    ["Lay on Hands"] = { short="Lay"; iname=HA_SPELL_LAY_ON_HANDS },
    ["Blessing of Protection"] = { short="Protection"; iname=HA_SPELL_BLESSING_OF_PROTECTION; cooldown=true; nonheal=true },
    -- Shaman
    ["Mana Tide Totem"] = { short="Mana Tide"; iname=HA_SPELL_MANA_TIDE; cooldown=true; nonheal=true },
    ["Purge"] = { short="Purge"; iname=HA_SPELL_PURGE; nonheal=true },
  };
  
  HA_HotSpells = {
    -- Druid
    ["Rejuvenation"] = HA_SPELL_REJUVENATION,
    ["Regrowth"] = HA_SPELL_REGROWTH_HOT,
    -- Priest
    ["Renew"] = HA_SPELL_RENEW,
  };

  HA_PassiveSpells = {
    -- Shaman
    ["Reincarnation"] = { short="Reincarnation"; iname=HA_SPELL_REINCARNATION; cooldown=true; nonheal=true},
  };

  HA_ZONE_FELWOOD = "Felwood";
  HA_ZONE_RUINS_AHNQIRAJ = "Ruins of Ahn'Qiraj";
  HA_ZONE_TEMPLE_AHNQIRAJ = "Ahn'Qiraj";
  HA_ZONE_MOLTEN_CORE = "Molten Core";
  HA_ZONE_BLACKWING_LAIR = "Blackwing Lair";
  HA_ZONE_NAXXRAMAS = "Naxxramas";

  HA_DEBUF_NAME_NEFARIUS = "Veil of Shadow";

  HA_PARSE_SPELL_FAILED_REASON = "You fail to cast (.+): (.+)%."
  
  function HA_FixLogStrings(str)
    return str;
  end

end

-- Variables depending on localization
HA_HealDebuffs = {
  [HA_MORTAL_STRIKE_TEXTURE] = { -- No need for zone, always Mortal Strike -- Use name if another spell/ability uses the same texture
    malus = 0.50,
  },
  [HA_MORTAL_WOUND_TEXTURE] = { -- Healing debuff in Ahn'Qiraj
    zones = {
      [HA_ZONE_RUINS_AHNQIRAJ] = 0.10,
      [HA_ZONE_TEMPLE_AHNQIRAJ] = 0.10, -- Fankriss
      [HA_ZONE_NAXXRAMAS] = 0.10,
    },
  },
  [HA_VEIL_OF_SHADOW_TEXTURE] = {
    zones = {
      [HA_ZONE_FELWOOD] = 0.50, -- Curse of the Deadwood
      [HA_ZONE_MOLTEN_CORE] = 0.75, -- Curse of gehennas
      [HA_ZONE_BLACKWING_LAIR] = {
        names = { -- Needed to prevent catching Ebonroc self heal debuf
          [HA_DEBUF_NAME_NEFARIUS] = 0.75, -- Nefarius
        },
      },
      [HA_ZONE_NAXXRAMAS] = 0.75, -- ??
    },
  },
  [HA_NECROTIC_POISON_TEXTURE] = {
    zones = {
      [HA_ZONE_NAXXRAMAS] = 0.90, -- ??
    },
  },
  [HA_GREEN_AFFLICTION_TEXTURE] = {
    zones = {
      [HA_ZONE_BLACKWING_LAIR] = 0.50, -- Chromaggus Green affliction
    },
  },
  -- Hex of weakness (20% HR) (http://www.thottbot.com/?sp=19285)
};

