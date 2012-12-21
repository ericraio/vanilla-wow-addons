AutoBuff casts self-buffs, weapon buffs, tracking abilites, aspects, and seals.

Originally authored by Frosty, adopted by Dsanai in August 2005.

Frosty is no longer playing World of Warcraft. He has allowed me to officially adopt AutoBuff. I intend to continue it while respecting his vision. Please direct any suggestions, comments, or blame, to Dsanai. Frosty only deserves praise. :)

FEATURES =================================

-- Casts buffs when you roll your scrollwheel forward or backward.
-- Casts buffs when you hit an [optional] keybinding.
-- Casts buffs when you switch/gain/lose targets.
-- Casts buffs through a macroable slash command.
-- All triggers can be individually or globally configured.
-- All spells can be disabled or configured as desired.
-- You can set mana/health thresholds, and only trigger if the conditions are met.
-- You can set which rank of spell will be cast (or it will default to using the highest known rank).
-- You can set waterbreathing spells (Warlock and Shaman) to only cast after 30 seconds or more underwater, or cast any time your spell conditions are met.
-- Only cast in combat, out of combat, or always.
-- Cast before the buff has expired so you never lose the effect.
-- All options can be set as a default, or per spell.
-- Optional Titan Panel and FuBar 2+ support allows you to access the UI through a click of its icon, or access certain options through a right-click menu. Mousing over the icon will show you the status of several AutoBuff options.
-- Won't try and cast if you are mounted, or are polymorphed, or if certain spells (such as Mind Control) are active.
-- Won't try to cast while your loot window is showing (when hunting or looting your hook during fishing).
-- Won't try to cast while you are channeling a spell or ability, eating, drinking, or using a bandage.
-- Won't cast if an ability with the same effect is already active (Arcane Brilliance, Gift of the Wild, Prayer of Fortitude).
-- Druid will auto-use "Track Humanoids" if it's enabled, and you go into cat form.
-- For abilities that override each other, it won't override a manually-used buff (ie. Mage Armor and Ice Armor).
-- All options can be configured with a graphical interface.
-- All options are saved per-character.
-- Can intelligently cast Rogues' Feint spell, based on your being in combat against a neutral-to-hostile target, and it being within 5 yards of you.
-- Will not cast if you're a Priest or Warlock with active Spirit Tap (but will if you have full mana, to maximize its usefulness). This 'block' can be deactivated, if desired.
-- Translated and localized for English, German, French, and Korean clients.

CLASS ABILITIES ==========================

-- All: Tracking abilities
-- Rogue: "Feint", "Blade Flurry", "Evasion", "Sprint", "Cold Blood"
-- Shaman: "Lightning Shield", "Water Breathing", and all four weapon buffs.
-- Priest: "Inner Fire", "Power Word: Fortitude", "Power Word: Shield", "Shadow Protection", "Elune's Grace", "Fear Ward", "Divine Spirit", "Feedback", "Shadowguard", "Touch of Weakness", "Fade", "Renew", "Focused Casting"
-- Warrior: "Battle Shout", "Bloodrage", "Berserker Rage"
-- Druid: "Nature's Grasp", "Mark of the Wild", "Thorns", "Omen of Clarity", "Track Humanoids" (Cat Form), "Cower" (Cat Form), "Rejuvenation"
-- Mage: "Frost Armor", "Ice Armor", "Mage Armor", "Arcane Intellect", "Mana Shield", "Amplify Magic", "Dampen Magic", "Frost Ward", "Fire Ward", "Ice Barrier", "Ice Block"
-- Warlock: "Demon Armor", "Demon Skin", "Detect Invisibility" (all 3), "Unending Breath", "Soul Link", "Life Tap", "Dark Pact"
-- Hunter: "Trueshot Aura", all Tracking abilities, and all Aspects
-- Paladin: "Sense Undead", "Righteous Fury", "Holy Shield", "Divine Favor", all Auras, Blessings, and Seals

RACIAL ABILITIES =========================

-- Troll: "Berserking"
-- Human: "Perception"
-- Orc: "Blood Fury"
-- Dwarf: "Stoneform"

COMMANDS =================================

-- User Interface: /autobuff OR /ab
-- List of Commands: /autobuff help

FREQUENTLY ASKED QUESTIONS (FAQ) =========

Q: It won't cast Waterbreathing spells!

A: You MUST be underwater for AT LEAST 30 seconds before it will cast it. If you want it to cast all the time, regardless of whether you're swimming or not, use the "/autobuff water" command, or change the WaterBreathing option on the Titan Menu.

Q: It won't cast my Aspects, Tracking spells, or Seals!

A: If you already have an Aspect or Tracking spell or Seal on you, it will NOT override it. It only casts these spells if you do not currently have one turned on. For hunters, this ensures that after death or a gryphon ride (if you had Cheetah on), your chosen default Aspect or Tracking spell will be recast. For a paladin, this allows you to manually cast any seal, and the AutoBuff default Seal will only be automatically cast once that one has expired (or been judged). In this manner, you can set one that you normally like to have on you, and STILL be able to manually choose one for a specific function or reason.

Q: Battle Shout won't cast!

A: Remember, rage is the same as mana (for the purposes of the AutoBuff options panel). The default mana casting level is set to > 40%. For a Warrior, this means that you'd have to have 40 rage before Battle Shout will cast! You need to set the Mana slider for Battle Shout to > 10% instead. This will allow it to cast when you have more than 10 rage (which is what the spell costs). It will then fire as soon as it possibly can.

Q: How do I get rid of the floating button, especially now that there's a Titan one?

A: Type /autobuff hide, or use the right-click menu on the Titan icon (there's a "Show Button" option).

Q: Can you make it buff party/raid members?

A: Nope, sorry. Try CastParty: http://tinyurl.com/boj7m

Q: Can you add MiniPetLeash?

A: No need. MiniPet: http://tinyurl.com/dd47g

Q: Can you make it change between Hawk, Monkey, and Cheetah aspects?

A: Try SmartAspect: http://tinyurl.com/cmjqc

Q: Why does it have all those key triggers if only the scroll button is used?

A: Patch 1.10 removed my ability to hook all those other movement/mouse keys. Only the scroll wheel and target switching are now supported. You can configure which spells use either of the trigger types, or set the defaults however you prefer.

Q: Why isn't it working with Fubar?

A: Do you have Fubar 2.0 or higher? If not, get it from here: http://www.wowinterface.com/downloads/fileinfo.php?id=4571
