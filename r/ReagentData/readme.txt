Reagent Data - Version 2.4.0c

Author: Jerigord (GDI)
German Translated provided by Xadros

Description:
Reagent Data is a comprehensive library of all reagents used in tradeskills in World of Warcraft.
It also contains a variety of common item classes to provide a rich reagent library for other mod
developers.  In addition, it provides an access API to give developers flexibility when dealing
with the data as well as direct access to its data arrays so authors can get exactly what they
want from it.

Users: 
This mod is a base mod used by several other addons.  There is no need to directly interact
with this addon and you should not delete or otherwise alter it unless you're certain it's not
currently in use.

Mod Authors: 
Reagent Data was designed with you in mind.  It provides you a massive reagent library and
API that will automatically translate to other languages, giving your mod additional flexibility at no
coding cost.  It is as comprehensive as possible and designed to be flexible and lightweight so you
don't have to worry about coding or storing the reagent data yourself.

Installation:
Reagent Data will normally be packaged along with another addon.
If you have downloaded a standalone copy, unzip it into your
World of Warcraft directory.  This will create a ReagentData
directory in your Interface/AddOns folder.  Aside from that, it
doesn't do anything unless another mod interacts with it.

Homepage: http://www.tarys.com/reagents/
Mirror #1: http://ui.worldofwar.net/ui.php?id=617
Mirror #2: http://www.curse-gaming.com/mod.php?addid=851

-------------
-- Changes --
-------------
--------------------
-- Version 2.4.0c --
--------------------

 * Added Chinese Translation thanks to SonicXP
 * Updated German Translation thanks to Farook
 
-----------------------
-- API/Table Changes --
-----------------------

 * General
   - Added Arcane Powder: ReagentData["reagent"]["arcanepowder"]
   - Added Symbol of Kings: ReagentData["reagent"]["symbolofkings"]
   - Added Weapon Location: ReagentData["location"]["weapon"]
   - Added Ruins of Anh'Qiraj quest data: ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]

--------------------
-- Version 2.4.0b --
--------------------

 * Fixed a few errors in the tables
 * Added back in the ZG enchants with the correct quest items. 

-----------------------
-- API/Table Changes --
-----------------------

 * General
   - Added Primal Hakkari Idol: ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["idol"]
   - Added Punctured Voodoo Doll: ReagentData["quest"]["Zul\'Gurub"]["item"]["doll"]["voodoo"]
   - Added the remainder of the Desecrated items to ['quest']['Naxxramas']['items'] (thanks to wmrojer for catching that)

--------------------
-- Version 2.4.0a --
--------------------

 * Updated for the 1.11.2 (11120) patch
 
 * Thanks to wmrojer for fixing some errors that I made in my code. 

-----------------------
-- API/Table Changes --
-----------------------

 * General
   - Commented out alot of the 'Unknown' recipes. Didn't delete them incase they ever come back.
   - Cleaned up some of the spacing to make the code look more uniform.
   - Added Nexus Crystal: ReagentData['shard']['nexuscrystal']
   - Added Morrowgrain: ReagentData['herb']['morrowgrain]
   - Added Frozen Rune: ReagentData['other']['frozenrune']
   - Added Chimaerok Tenderloin: ReagentData['monster']['chimaeroktenderloin']
   - Added Small Obsidian Shard: ReagentData['ore']['smallobsidianshard']
   - Added Large Obsidian Shard: ReagentData['ore']['largeobsidianshard']
   - Added Blood of Heroes: ReagentData['other']['bloodofheroes']
   - Added Frayed Abomination Stitchings: ReagentData['other']['frayedabominationstitchings']
   - Added Deadly Poison V: ReagentData['poison']['deadlyv']
   - Changed Dreamscale: from ReagentData['monster']['dreamscale'] to ReagentData['scale']['dream'] 
   - Added All the Desecrated items and War Torn Scraps to ['quest']['Naxxramas']['items']
   
 * Alchemy
   - Added recipes for Elixer of Greater Firepower, Transmute Elemental Fire, and Gurubashi Mojo Madness
   - Added Heart of Fire to the alchemy tables

 * Blacksmithing
   - Updated reagent costs for Dark Iron Bracers, Fiery Chain Girdle, Blackguard, Ebon Hand, Nightfall, Blackfury, Black Amnesty
   - Corrected spelling and added type, description and resultrarity to Darkrune Helm 
   - Added Skill data to Dark Iron Gauntlets, Dark Iron Helm, Gloves of the Dawn, Girdle of the Dawn, Heavy Timbermay Boots,
     Ebon Hand, Nightfall, Blackfury, Black Amnesty
   - Changed Darkrune Helm, Darkrune Gauntlets and Darkrune Breastplate from 'Vendor' to 'Quest'
   - Added recipes for Black Grasp of the Destroyer, Heavy Obsidian Belt, Light Obsidian Belt, Jagged Obsidian Shield,
     Obsidian Mail Tunic, Thick Obsidian Breastplate, Sageblade, Persuader, Titanic Breastplate, Ironvine Belt,
     Ironvine Gloves, Ironvine Breastplate, Icebane Bracers, Icebane Gauntlets and Icebane Breastplate.
   - Added Frozen Rune, Small Obsidian Shard, Large Obsidian Shard, Black Diamond, Nexus Crystal, Flask of the Titans, Flask of Supreme Power,
     and Skin of Shadow to the blacksmithing tables
 
 * Cooking
   - Added recipes for Smoked Desert Dumplings and Dirge's Kickin' Chimaerok Chops
   - Added Chimaerok Tenderloin to the cooking tables
   
 * Enchanting
   - Added Recipes for Enchant 2H Weapon - Agility, Enchant Gloves - Threat, Enchant Gloves - Shadow Power, Enchant Gloves - Frost Power,
     Enchant Gloves - Fire Power, Enchant Gloves - Healing Power, Enchant Gloves - Superior Agility, Enchant Cloak - Greater Fire Resistance,
     Enchant Cloak - Greater Nature Resistance, Enchant Cloak - Stealth, Enchant Cloak - Subtelty, Enchant Cloak - Dodge,
     Minor Wizard Oil, Minor Mana Oil, Lesser Wizard Oil, Lesser Mana Oil, Wizard Oil, Brilliant Mana Oil and Brilliant Wizard Oil
   - Added Vials, Larval Acid, Black Diamond, Guardian Stone, Stranglethorn Seed, Firebloom, Purple Lotus, Black Lous, Wintersbite,
     Essence of Fire, Essence of Water, Essence of Air and Essence of Earth to enchanting tables
     
 * Engineering
   - Added recipes for Small Blue Rocket, Small Green Rocket, Small Red Rocket, Large Blue Rocker, Large Red Rocket, Blue Roclet Cluster,
     Green Rocket Cluster, Red Rocket Cluster, Large Blue Rocket Cluster, Large Green Rocket Cluster, Large Red Rocket Cluster,
     Firework Launcher, Cluster Launcher and Tranquil Mechanical Yeti
     
 * Leatherworking
   - Added recipes for Stormshroud Gloves, Brambelwood Belt, Bramblewood Boots, Bramblewood Helm, Polar Bracers, Polar Gloves, Polar Tunic,
     Icy Scale Bracers, Icy Scale Gauntlets and Icy Scale Breastplate
   - Added Skill Data to Gordok Ogre Suit, Onyxia Scale Cloak, Golden Mantle of the Dawn, Lava Belt, Dawn Treaders, Molten Belt,
     Mantle of the Timbermaw, Timbermaw Brawlers, Chromatic Gauntlets and Corehound Belt
   - Updated reagent cost for Dreamscale Breastplate
   - Updated the rarity of Stormshroud Shoulders from Uncommon to Rare
   - Updated Description on Stormshroud set items to reflect the new standing of 4 pieces
   - Added Frozen Rune to leatherworking tables
   
 * Tailoring
   - Added recipes for Enchanted Mageweave Pouch, Enchanted Runecloth Bag, Cenarion Herb Bag, Big Bag of Enchantment, Satchel of Cenarius,
     Soul Bag, Felcloth Bag, Core Felcloth Bag, Sylvan Shoulders, Sylvan Vest, Sylvan Crown, Gaea's Embrace, Glacial Gloves,
     Glacial Wrists, Glacial Vest and Glacial Cloak
   - Added skill data for Gordok Ogre Suit, Argent Boots, Flarecore Leggings, Wisdom of the Timbermaw, Mantle of the Timbermaw,
     Argent Shoulders and Flarecore Robe
   - Added source data for Mooncloth Boots, Gloves of Spell Mastery
   - Changed Dreamweave Circlet from Uncommon to Rare
   - Added Frozen Rune, Purple Lotus, Morrowgrain, Greater Eternal Essence and Vision Dust to tailoring tables
   
 * First Aid
   - Changed Powerful Anti-Venon: from source = 'Vendor:Manual: Powerful Anti-Venom' to source = 'Vendor:Formula: Powerful Anti-Venom'
 
 * Poisons
   - Added Deadly Poison V Recipe
   
 * Mage
   - Added Arcane Powder to Mage Reagents
 
 * Quests
   - Added info for the drops for the Tier 3 armor from Naxxramas
   - Removed all the bijou's and coins from the Zul'Gurub tables as they are no londer needed
  
-------------------
-- Version 2.3.0 --
-------------------

 * This version has been graciously provided by Zindjorl.  All new information and bug fixes are his credit.
   Thanks for the help while I was moving!
 
 * General 
   - File structure changed to more easily accommodate localization.  Each language now appears in its own file.
   - I have the Darkmoon Faire items (including localized strings), but I haven't gotten a chance to add them yet.
     I hope to have them out once things calm down here a bit.

 * API/Table Changes
   - Anh'Qiraj data has been added for the English localization.
   - Zul'Gurub enchant information has been added.

-------------------
-- Version 2.2.4 --
-------------------

 * Localization
    - Corrected some encoding errors in the German Zul'Gurub strings.  Thanks to Maischter.
    - Received a complete new French translation, including Zul'Gurub items, thanks to Zindjorl.

--------------------
-- Version 2.2.3b --
--------------------

 * Localization
    - Received a complete new German translation thanks to Maischter

-------------------
-- Version 2.2.3 --
-------------------

 * General
   - Corrected typos in several tradeskill files
   - Added missing some identified missing entries in the German and French translations to remove some nil errors.
     These entries are not localized, however.  If you find more missing entries or translations, please email them
     to me.  I no longer check the comments on the mod sites.
   - Attempted to add German translation of Zul'Gurub items, though there may be an encoding error in what I received.
     Thanks to Sunny.
   - Updated for the 1.9 patch

-------------------
-- Version 2.2.2 --
-------------------

-----------------------
-- API/Table Changes --
-----------------------

 Alchemy:
   Corrected a typo in the Living Action Potion ingredients.  Thanks to Vladimir.

-------------------
-- Version 2.2.1 --
-------------------

 * Updated for the 1.8 (1800) patch

-----------------------
-- API/Table Changes --
-----------------------

 * General
   - Added Dark Rune: ReagentData['monster']['darkrune']
   - Added Dreamscale: ReagentData['monster']['dreamscale']
   - Added Heavy Silithid Carapace: ReagentData['monster']['heavysilithidcarapace']
   - Added Light Silithid Carapace: ReagentData['monster']['lightsilithidcarapace']
   - Added Sandworm Meat: ReagentData['monster']['sandwormmeat']
   - Added Silithid Chitin: ReagentData['monster']['silithidchitin']
   - Changed ReagentData['monster']['bloodvine'] to ReagentData['herb']['bloodvine']

 * Blacksmithing
   - Added Darkrune Gauntlets, Darkrune Helm, and Darkrune Breastplate recipes

 * Cooking
   - Added Sandworm Meat to ReagentData['cooking']

 * Leatherworking
   - Added Dreamscale to ReagentData['leatherworking']
   - Added Heavy Silithid Carapace to ReagentData['leatherworking']
   - Added Light Silithid Carapace to ReagentData['leatherworking']
   - Added Silithid Chitin to ReagentData['leatherworking']
   - Added Green Dragonscale Gauntlets, Blue Dragonscale Leggings, Dreamscale Breastplate,
     Sandstalker Bracers, Sandstalker Breastplate, Sandstalker Gauntlets, Spitfire Gauntlets,
     Spitfire Breastplate, Spitfire Bracers, and Black Whelp Tunic recipes

 * Tailoring 
   - Added Dark Rune to ReagentData['tailoring']
   - Added Runed Stygian Leggings and Runed Stygian Belt recipes

-------------------
-- Version 2.2.0 --
-------------------

--------------------
-- New Tables/API --
--------------------

 Reagent Data now contains a ReagentData['quest'] table for important quest items.  This was done
 due to the addition of new quests that have a complicated number of tradeable items that are
 desired by multiple classes.  The table was designed to be zone-centric.  That is to say, the subtables 
 of ReagentData['quest'] are the names of the zones in which the quests appear.  Currently, only
 Zul'Gurub quests are supported.  Due to the dynamic nature of the quest system, the individual table
 design and format will vary from zone table to zone table.  This is by design.

-----------------------
-- API/Table Changes --
-----------------------

 * All profession tables have been tweaked or revamped thanks to Fara and Andreas.

 * General:
   - Added Massive Mojo: ReagentData['monster']['massiveomojo']
   - Added Bloodvine: ReagentData['monster']['bloodvine']
   - Added Primal Bat Leather: ReagentData['leather']['primalbat']
   - Added Primal Tiger Leather: ReagentData['leather']['primaltiger']
   - Added Elementium Ore: ReagentData['ore']['elementium']
   - Added Elemental Flux: ReagentData['flux']['elementium']
   - Added Souldarite: ReagentData['gem']['souldarite']
   - Added Huge Venom Sac: ReagentData['monster']['hugevenomsac']
   - Added ReagentData['bandage']['powerfulantivenom']
   - Changed ReagentData['monster']['coreleather'] to ReagentData['leather']['core']

 * Alchemy
   - Corrected Major Rejuvenation Potion (spelling error)
   - Corrected Restorative Potion (name change)
   - Added Elemental Air to ReagentData['alchemy']
   - Added Large Fang to ReagentData['alchemy']
   - Added Heart of the Wild to ReagentData['alchemy']
   - Removed Oil of Immolation from ReagentData['alchemy'] since it's not used in any recipes
   - Removed Goblin Rocket Fuel from ReagentData['alchemy'] since it's not used in any recipes
   - Added Mageblood Potion, Greater Dreamless Sleep Potion, Living Action Potion, and 
     Major Troll's Blood Potion recipes

 * Blacksmithing
   - Too many recipe changes to list individually.  The recipe list should be far, far more accurate now.
   - Added Elemental Air to ReagentData['blacksmithing']
   - Added Essence of Undeath to ReagentData['blacksmithing']
   - Added Core Leather to ReagentData['blacksmithing']
   - Added Sulfuron Ingot to ReagentData['blacksmithing']
   - Added Bloodvine to ReagentData['blacksmithing']
   - Added Souldarite to ReagentData['blacksmithing']
   - Corrected Elixir of Ogre's Strength in ReagentData['blacksmithing'] (spelling error)
   - Corrected Lesser Invisibility Potion in ReagentData['blacksmithing'] (spelling error)

 * Enchanting
   - Corrected skill level on Lesser Magic, Greater Magic, and Lesser Mystic wands
   - Added in all enchanting effects thanks to data from Fara!

 * Engineering: 
   - Removed several Unknown Items
   - Removed Strong Flux and Elemental Flux from ReagentData['flux']
   - Added Truesilver Transformer to ReagentData['part'] and ReagentData['engineering']
   - Added The Big One to ReagentData['part'] and ReagentData['engineering']
   - Added Essence of Water to ReagentData['engineering']
   - Added Elemental Air to ReagentData['engineering'].  Man this stuff is popualr.
   - Added Essence of Undeath to ReagentData['engineering']
   - Added Icecap to ReagentData['engineering']
   - Added Deeprock Salt to ReagentData['engineering']
   - Added Bloodvine to ReagentData['engineering']
   - Added Souldarite to ReagentData['engineering']
   - Added Powerful Mojo to ReagentData['engineering']
   - Added Hyper-Radiant Flame Reflector, Dimensional Ripper - Everlook, Green Firework, EZ-Thro Dynamite II,
     Red Firework, Blue Firework, Powerful Seaforium Charge, Gyrofreeze Ice Deflector, World Enlarger,
     Alarm-O-Bot, Ultrasafe Transporter - Gadgetzan, Ultra-Flash Shadow Reflector, Dense Dynamite,
     Snake Burst Firework, Bloodvine Goggles, and Bloodvine Lens recipes.

 * First Aid
   - Added ReagentData['monster']['hugevenomsac']

 * Leatherworking
   - Removed Mageweave Bolt from ReagentData['leatherworking']
   - Added Righteous Orb to ReagentData['leatherworking']
   - Added Ironweb Spider Silk to ReagentData['leatherworking']
   - Added Powerful Mojo to ReagentData['leatherworking']
   - Added Runecloth Bolt to ReagentData['leatherworking']
   - Added Felcloth to ReagentData['leatherworking']
   - Added Mooncloth to ReagentData['leatherworking']
   - Added Jet Black Feather to ReagentData['leatherworking']
   - Added Bloodvine to ReagentData['leatherworking']
   - Added Golden Mantle of the Dawn, Heavy Leather Ball, Lava Belt, Barbaric Bracers, Dawn Treaders,
     Molten Belt, Might of the Timbermaw, Timbermaw Brawlers, Chromatic Gauntlets, Corehound Belt,
     Primal Batskin Jerkin, Primal Batskin Gloves, Primal Batskin Bracers, Blood Tiger Breastplate,
     Blood Tiger Shoulders, recipes.

 * Mining
   - Added Smelt Elementium

 * Tailoring
   - Removed several Unknown Items
   - Added Enchanted Leather to ReagentData['tailoring']
   - Added Living Essence to ReagentData['tailoring']
   - Added Essence of Earth to ReagentData['tailoring']
   - Added Arcanite Bar to ReagentData['tailoring']
   - Added Bloodvine to ReagentData['tailoring']
   - Added Argent Boots, Flarecore Leggings, Wisdom of the Timbermaw, Mantle of the Timbermaw, Argent Shoulders
     Flarecore Robe, Bloodvine Vest, Bloodvine Leggings, and Bloodvine Boots recipes.

---------------
-- Bug Fixes --
---------------

 * More German translation corrections.  You crazy kids and your umlautes.

-------------------
-- Version 2.1.3 --
-------------------

---------------
-- Bug Fixes --
---------------

 * Corrected some errors with the German and French localizations.  Thanks to Jens and Elkano.

-------------------
-- Version 2.1.2 --
-------------------

-----------------------
-- API/Table Changes --
-----------------------

 * Updated for the 1600 patch
 * Reintegrated German and French translations.

-------------------
-- Version 2.1.1 --
-------------------

-----------------------
-- API/Table Changes --
-----------------------

 * Added ReagentData['monster']['righteousorb'] to ReagentData['enchanting']. - Credit to DaemoN

-------------------
-- Version 2.1.0 --
-------------------

---------------
-- Bug Fixes --
---------------

 * Due to insurmountable problems, the item link system Reagent Data 2.0.0 has been removed.  It was
   causing a disconnect problem for too many clients due to factors beyond my control.  It will still 
   be used to create the old, static version of Reagent Data and can be used to quickly localize new
   language versions of the mod.  If you are interested in helping with this localization process,
   please email Jerigord at reagentwatch -at- tarys -dot- com.

 * As of this version, only the English version of Reagent Data will be distributed in this zip file.
   This is done to keep file sizes down and due to the new translation mechanism.  Localized versions
   of Reagent Data will be distributed separately as reagentdata-x.y.z-lang.zip where lang refers to 
   the language of the translation.  Due to its design, other language versions can be dropped in over
   top of the English version without affecting the mods that use Reagent Data.

-----------------------
-- API/Table Changes --
-----------------------

 * Corrected ReagentData['reagent']['ironwoodseed'] - Credit to Rassilon
 * Added ReagentData['reagent']['wildthornroot'].  Also added to ReagentData['spellreagents']['druid']. - Credit to Rassilon
 * Added ReagentData['reagent']['sacredcandle'].  Also added to ReagentData['spellreagents']['priest']. - Credit to Jexx

-------------------
-- Version 2.0.0 --
-------------------

------------------
-- New Features --
------------------

 * Reagent Data now uses an item link based system developed by
   Tuatara.  Instead of storing text strings for the item
   names, it stores the item link used by the WoW database.  On
   load, your client automatically converts those item links
   into the localized string names for your client.  Item links
   were provided courtesy of the Cosmos team with contributions from GDI.
 * If the localization fails or breaks for any reason, issuing
   a "/reagentdata" command will re-localize the data on demand. 
 * Added in a comprehensive recipe database compiled by
   Bima. All tradeskill recipes should be represented within
   Reagent Data now with all relevant information.  See the
   recipe section below for more information.

-----------------------
-- API/Table Changes --
-----------------------

General:

 * Changed ReagentData['monster']['bighearmeat'] to ReagentData['monster']['bigbearmeat']
 * Changed ReagentData['cookingfish']['rawnightfish'] to ReagentData['cookingfish']['rawmightfish']
 * Changed ReagentData['blacksmithing']['gem']['shadowgem'] to ReagentData['blacksmithing']['gem']['shadow'] - Credit to Fudge
 * Changed ReagentData['scale']['slimymurloc'] to ReagentData['monster']['slimymurlocscale']
 * Changed ReagentData['scale']['thickmurloc'] to ReagentData['monster']['thickmurlocscale']
 * Added ReagentData['armor']['cinderclothcloak'].  Also added to ReagentData['leatherworking']
 * Added ReagentData['monster']['sulfuroningot'].  Also added to ReagentData['blacksmithing']
 * Added ReagentData['monster']['coreleather'].  Also added to ReagentData['leatherworking'] and ReagentData['tailoring']
 * Added ReagentData['monster']['skinofshadow'].  Also added to ReagentData['leatherworking']
 * Added ReagentData['monster']['ogretannin'].  Also added to ReagentData['leatherworking'] and ReagentData['tailoring']
 * Added ReagentData['monster']['scaleofonyxia'].  Also added to ReagentData['leatherworking'] and ReagentData['alchemy']
 * Added ReagentData['monster']['softfrenzyflesh'].  Also added to ReagentData['cooking']
 * Added ReagentData['vendorother']['coal'].
 * Corrected scale listing in ReagentData['skinning']
 * Removed ReagentData['poison']['cripplingiii']
 * Removed ReagentData['element']['wildessence']

Alchemy:
 * Added ReagentData['element']['earth'] to ReagentData['alchemy']
 * Added ReagentData['element']['water'] to ReagentData['alchemy']
 * Added ReagentData['element']['ichorofundeath'] to ReagentData['alchemy']
 * Added ReagentData['dye']['purple'] to ReagentData['alchemy']
 * Added ReagentData['element']['essenceofair'] to ReagentData['alchemy']
 * Added ReagentData['element']['essenceofearth'] to ReagentData['alchemy']
 * Added ReagentData['element']['essenceoffire'] to ReagentData['alchemy']
 * Added ReagentData['element']['essenceofwater'] to ReagentData['alchemy']
 * Added ReagentData['element']['essenceofundeath'] to ReagentData['alchemy']
 * Added ReagentData['element']['heartofthewild'] to ReagentData['alchemy']
 * Added ReagentData['dust']['dream'] to ReagentData['alchemy']
 * Removed ReagentData['oil']['frost'] from ReagentData['alchemy']

Blacksmithing:
 * Corrected ReagentData['potion']['lesserinvisibility'] in ReagentData['blacksmithing']
 * Added ReagentData['element']['essenceofearth'] to ReagentData['blacksmithing']
 * Added ReagentData['element']['essenceoffire'] to ReagentData['blacksmithing']
 * Added ReagentData['element']['essenceofwater'] to ReagentData['blacksmithing']

Enchanting:
 * Added ReagentData['oil']['frost'] to ReagentData['enchanting']
 * Corrected ReagentData['oil']['fire'] in ReagentData['enchanting']

Engineering:
 * Added ReagentData['gem']['bluesapphire'] to ReagentData['engineering']
 * Added ReagentData['gem']['largeopal'] to ReagentData['engineering']
 * Added ReagentData['gem']['hugeemerald'] to ReagentData['engineering']
 * Added ReagentData['gem']['azerothiandiamond'] to ReagentData['engineering']
 * Added ReagentData['element']['essenceofearth'] to ReagentData['engineering']
 * Added ReagentData['element']['essenceoffire'] to ReagentData['engineering']
 * Added ReagentData['element']['essenceofair'] to ReagentData['engineering']	

Leatherworking:
 * Added ReagentData['gem']['shadow'] to ReagentData['leatherworking']
 * Removed ReagentData['cloth']['linen'] from ReagentData['leatherworking']
 * Removed ReagentData['cloth']['wool'] from ReagentData['leatherworking']
 * Removed ReagentData['cloth']['silk'] from ReagentData['leatherworking']

Tailoring:
 * Corrected ReagentData['pearl']['golden'] in ReagentData['tailoring'] - Credit to Bruce Walter
 * Corrected ReagentData['potion']['shadowprotection'] in ReagentData['tailoring']
 * Corrected ReagentData['herb']['wildvine'] in ReagentData['tailoring']
 * Added ReagentData['element']['essenceoffire'] to ReagentData['tailoring']
 * Added ReagentData['element']['essenceofair'] to ReagentData['tailoring']
 * Added ReagentData['element']['essenceofundeath'] to ReagentData['tailoring']
 * Added ReagentData['gem']['hugeemerald'] to ReagentData['tailoring']
 * Added ReagentData['gem']['azerothiandiamond'] to ReagentData['tailoring']
 * Added ReagentData['pearl']['black'] to ReagentData['tailoring']
 * Added ReagentData['pearl']['golden'] to ReagentData['tailoring']
 * Added ReagentData['monster']['righteousorb'] to ReagentData['tailoring']

------------------------
-- Recipe Information --
------------------------

Thanks to Bima, Reagent Data now includes a complete set of
recipe information for all tradeskills in the game.  This data
was compiled from several online resources and fits into the
Reagent Data schema in a way that should be intuitive for addon
developers.

All recipe information appears in the ReagentData['crafted']
table.  The professions are broken into subtables based on their
Reagent Data names.  Recipes are included for alchemy,
blacksmithing, cooking, enchanting, engineering, firstaid,
leatherworking, mining, poisons, and tailoring.  Here's an
example entry:

ReagentData['crafted']['alchemy'] = {
    ['Elixir of Lion\'s Strength'] = {
        skill = 1,
        description = 'Use: Increases Strength by 4 for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['earthroot']] = 1,
            [ReagentData['herb']['silverleaf']] = 1,
        }
    },
};

Currently all recipe data is in English.  The index into each
table is the name of the recipe.  This points to an information
table about the recipe that contains things like skill level ,
description, source, result, and a reagent list.  The description
contains either usage information about the item, item
statistics, or both.  Standard abbreviations are used for item
statistics to make parsing easier.  The reagents table is keyed
off of ReagentData items with a value of the number required by
the recipe.

-------------------
-- Version 1.2.3 --
-------------------

-----------------------
-- API/Table Changes --
-----------------------

 All API changes in this version are credit to Tuatara unless otherwise noted

 * Changed ReagentData['alchemyfish']['rawstonescaleeel'] to ReagentData['alchemyfish']['stonescaleeel']
 * Changed ReagentData['reagent']['demonicfigure'] to ReagentData['reagent']['demonicfigurine']
 * Added ReagentData['dye']['black']
 * Added ReagentData['monster']['giantclammeat'].  Also added to ReagentData['cooking']
 * Added ReagentData['armor']['fineleathertunic'].  Also added to ReagentData['leatherworking']
 * Added ReagentData['bar']['steel']
 * Added ReagentData['armor']['greentintedgoggles'].  Also added to ReagentData['engineering']
 * Added ReagentData['part']['mithrilmechanicaldragonling']
 * Added ReagentData['part']['woodenstock']
 * Added ReagentData['other']['snowball'].  Also added to ReagentData['engineering']
 * Corrected German translation for Enchanting.  - Credit to Lunox

-------------------
-- Version 1.2.2 --
-------------------

-----------------------
-- API/Table Changes --
-----------------------

 * Added ReagentData['monster']['buzzardwing'].  Also added to ReagentData['cooking']
 * Added ReagentData['monster']['softfrenzyflesh'].  Also added to ReagentData['cooking']

-------------------
-- Version 1.2.1 --
-------------------

-----------------------
-- API/Table Changes --
-----------------------

 * Added ReagentData['monster']['whitespidermeat'].  Also added to ReagentData['cooking'] - Credit to swanee52
 * Added ReagentData['monster']['tenderwolfmeat'].  Also added to ReagentData['cooking']
 * Added ReagentData['element']['livingessence'].  Also added to ReagentData['alchemy'].  It was omitted during
   original build by mistake.  - Credit to Cadex.
 * Corrected leatherworking entries for Essence of Earth/Air/Water.  The table structure was not built
   properly.  - Credit to Cadex.

-------------------
-- Version 1.2.0 --
-------------------

-----------------------
-- API/Table Changes --
-----------------------
 * Moved pearls to their own category, ReagentData['pearl'] and marked it as monster dropped.
   Previously, pearls were listed as gems, which caused problems with Reagent Info.
 * Added/Confirmed German translation for Bronze Bar, Dreamfoil, Major Mana Potion, Arthas' Tears,
   Mountain Silversage, Black Lotus, Fishing, Herbalism, Black Diamond, Dreamless Sleep, Elixir of
   Greater Intellect, Elixir of Greater Agility, Elixir of Detect Demon, Bolt of Mageweave, Iridescent
   Pearl, Black Vitriol, Claw Meat, Zesty Clam Meat, and all new poison ingredients.  
   Thanks to Xadros and jth for these!

-------------------
-- Version 1.1.0 --
-------------------

------------------
-- New Features --
------------------

* Added the rogue poison ingredient table: ReagentData['poisoningredient']
  This table contains the vendor ingredients used in poisons
* Added the rogue poison reagent table: ReagentData['poisonreagent']
  This table contains everything needed for creating rogue poisons and is the preferred method
  for accessing rogue poison reagent information.

---------------
-- Bug Fixes --
---------------

* Fixed two typos in ReagentData['alchemy'] - Credit to Myrathi

-----------------------
-- API/Table Changes --
-----------------------

* Removed ReagentData['alchemyfish']['deviate'], moved to ReagentData['cookingfish']['deviate']
* Updated ReagentData['cooking'] to reflect the deviate fish change
* Added ReagentData['alchemyfish'] to ReagentData['alchemy'].  Yes, I totally forgot it.
* Added ReagentData['vial']['imbued']
* Added ReagentData['herb']['blacklotus']
* Added ReagentData['part']['delicatearcaniteconverter']
* Added ReagentData['gem']['blackdiamond'].  Also added to ReagentData['leatherworking']
* Added ReagentData['monster']['brilliantchromaticscale'].  Also added to ReagentData['leatherworking']
* Added ReagentData['monster']['fierycore'].  Also added to ReagentData['blacksmithing'], 
  ReagentData['engineering'], ReagentData['leatherworking'], ReagentData['tailoring']
* Added ReagentData['monster']['lavacore'].  Also added to ReagentData['blacksmithing'], 
  ReagentData['engineering'], ReagentData['leatherworking'], ReagentData['tailoring']
* Added ReagentData['monster']['guardianstone'].  Also added to ReagentData['blacksmithing'],
  ReagentData['leatherworking'], ReagentData['tailoring']
* Added ReagentData['shard']['largebrilliant'] to ReagentData['tailoring']

------------------------
-- Change Information --
------------------------

Here are the standards for version numbering for this mod.  I will adhere to these as best I can.
The mod will use a three dot notation for version numbering: X.Y.Z.  In the event that the third
dot is omitted, it is understood to be a zero.

The X portion of the number refers to the version "family" of the mod.  New versions of the mod will
remain in the same family provided there are no significant changes to the API that break functionality.
This means that any mod that is compatible with the X family should be compatible with all versions of
the X family.  The mod may not full use of features introduced later in the family, but it should still
run.  X level upgrades will, therefore, be rare and only occur when a significant change to the mod is
made that will break previous addons.

The Y portion of the version number refers to the revision level of the mod.  New revisions may include
new data tables (such as the introduction of rogue poison reagents in 1.1.0), new API calls that
provide significant new functionality, and structure changes to Reagent Data tables.  No Y change should 
break a previous mod, however.  The only exception to this would be mods that directly access base
data tables.  If the Y change includes a table change, some mods may experience a nil error.  This will
be documented in the change log.

The Z portion of the version number refers to the current patch level of the mod.  This will be the most
frequently changing number of the mod.  The Z number will be updated for Blizzard TOC changes, minor
typographical errors (spelling, grammar, etc), or minor bug fixes to the API.  Z changes do not indicate
a major change in functionality.

As a final note, the three numbers are not on a fixed scale.  This means that any of the three numbers
does not have a fixed upper; they will increment as much as necessary.  If there are not a huge number of
changes, the version number could conceivably reach things like 1.2.14 as the UI TOC changes, though this
is not likely.

----------------------
-- API Information: --
----------------------

There are two primary ways of accessing data in Reagent Data: By
accessing the ReagentData table itself or by using the various
API functions.  

ReagentData Table:
The ReagentData table is a collection of subtables that hold
various base item and profession information.  The following
indices are available:

Base Item Classes:
alchemyfish - Alchemy Fish
bandage - Bandages
bar - Metal Bars
cloth - Cloth
cookingfish - Cooking Fish
element - Elements (such as Elemental Earth)
gem - Gems
herb - Herbs
hide - Hides (including the cured versions)
leather - Leather
ore - Metal ores
poison - Rogue poisons
potion - Various potions
reagent - Spell reagents (not assocaited with any class)
scale - Scales
stone - Stone

Item Classes Produced by Tradeskills
armor - Only those used in tradeskills
bolt - Cloth bolts
grinding - Grinding stones
oil - Various oils such as Blackmouth Oil and Frost Oil
other - Items that don't fir in other categories
power - Blasting powders
part - Engineering parts (including the vendor purchased ones)
rod - Metal rods

Enchanting Reagents:
dust - Enchanting dusts
essence - Enchanting essences
shard - Enchanting shards

Vendor Items:
drink - Drinks used in tradeskills
dye - Dyes
flux - Fluxes
food - Food used in tradeskills
salt - Salts (including refined deeprock)
spice - Cooking spices
thread - Threads
vendorother - Other vendor items
vial - Vials
wood - Enchanting woods

Other Item Classes:
monster - Items primarily obtained from monsters
feather - Feathers (not light feather)
spidersilk - Spider silks

Professions (Tradeskills that produce a finished product):
alchemy - Alchemy
blacksmithing - Blacksmithing
cooking - Cooking
enchating - Enchanting
engineering - Engineering
firstaid - First Aid
leatherworking - Leatherworking
tailoring - Tailoring

Gather Skills (Tradeskills that create raw materials):
fishing - Fishing
herbalism - Herbalism
mining - Mining
skinning - Skinning

Helper Tables:
professions - Contains the localized text version of profession names
gathering - Contains the localized text version of the gather skills
reverseprofessions - This allows you to easily get the index for
a profession from the localized text name.
reversegathering - This allows you to easily get the index for a
gather skill from the localized text name.
spellreagents - A multidimensional table of all classes and the
spell reagents they use.
vendor - A collection of all item clases that come from vendors
monsterdrops - A collection of all item classes that come from
monster drops

ReagentData Design Principles:
The ReagentData table holds the complete reagent information for this addon.  It was created with two 
principles in mind.  

First, each reagent will only appear by name once.  That means that there will only be one place
that says "Light Leather".  Any other references to the item will call the table reference to that base name.
This cuts down on potential typos, makes translations easier, and cuts down on memory usage by using LUA's
table reference mechanisms instead of flinging multiple copies of the strings into memory.

Second, reagents will be broken down into logical base groups based on a common attribute.  For example,
all leathers appear in a ReagentData['leather'] category because they're all leathers.  After the base groups,
other logical groups such as professions and vendor items are built by referencing the base groups as 
mentioned earlier.

One benefit of this mechanism is that only the base groups need to be altered for a translation.  By creating
a new GetLocale() if block that contains translations for the base groups, all references to those items are
automatically translated into the new language based on the client's settings.  For example, if your code
references ReagentData['leather']['light'], it will resolve to "Light Leather" on English clients.  However,
if a German client runs your mod, it will automatically resolve to "Leichtes Leder" without any special
effort on your part.

API Functions

ReagentData provides a few functions to make developing your
addon a little easier.

ReagentData_ClassSpellReagent(item)

This function takes an item name (such as "Fish Oil") and returns
an array of classes that use the reagent {"Shaman"}.  It returns the
translated text version of the name.

ReagentData_GatheredBy(item)

This function takes an item name (such as "Light Leather") and returns
an array of gather skills that are used to gather the item.  For example, 
calling ReagentData_GatheredBy("Light Leather") on an English client
will return {"Skinning"}.  Results are not sorted, so be sure to run them 
through table.sort if you want them in alphabetical order.

I can't think of any items that are gathered by more than one skill, but 
this way the function behaves the same as other API calls and is flexible 
in case we  can one day skin herbs or something.

ReagentData_GetItemClass(class)

Returns the data array for the requested item class.  This is the 
Reagent Data name for the item, NOT the translated name.  This means
you'll need to run it through ReagentData['reverseprofessions'] or
ReagentData['reversegatherskills'] first.  This function does NOT
flatten the returned function either, so keep that in mind when loading
professions; it doesn't apply to base classes such as ReagentData['bar'].

Most authors will simply want to access the ReagentData tables directly
instead of using this function, but it's provided anyway.

ReagentData_GetProfessions(item)

Returns a table that contains a translated list of all professions
that use the specified item.  For example, calling
ReagentData_GetProfessions("Light Leather") on an English client
will return {"Blacksmithing", "Engineering", "Leatherworking", "Tailoring"}.
Results are not sorted, so be sure to run them through table.sort if you
want them in alphabetical order.

ReagentData_GetSpellReagents(class)

Returns a table that contains all spell reagents used by the specified
class.  For example, calling ReagentData_GetSpellReagents("shaman"}
will return {"Ankh", "Fish Oil", "Shiny Fish Scales"}.  If class
is omitted or specified as "all", all classes and spell reagents will
be returned in a multi-dimensional array.

Boolean Functions:

ReagentData_IsMonsterDrop(item)

A Boolean function that indicates if the specified item is primarily 
obtained from monster drops.  Item is expected to be a localized string 
such as "Tiger Meat".

ReagentData_IsUsedByProfession(item, profession)

A Boolean function that indicates if the specified profession
uses the specified item.  Both profession and item are expected
to be the localized text version of the name (such as
"Copper Bar" and "Blacksmithing").

ReagentData_IsVendorItem(item)

A Boolean function that indicates if the specified item is primarily
obtained from vendors.  Item is expected to be a localized string such as "Heavy Stock".

-----------------------------------------------

Final Notes:

As I mentioned, this library was created with addon authors in
mind.  Until now, authors who wanted to use reagent data either
had to compile their own list (which is VERY time consuming) or
rely on Sea (which provides a lot of unnecessary extras, is
incomplete, and has a negative stigma).  With the release of
Reagent Data, these problems should now be solved.  If you find a
problem with Reagent Data or would like something added to it,
please contact me at reagentwatch@tarys.com.  This is your mod,
so why not try and make it the best it can be?  :-)

I'm definitely not stopping here.  With the release of Reagent
Data, I'm also releasing Reagent Info as a demonstration addon.
This mod is essentially a replacement for Reagent Helper and took
a single afternoon to develop from start to finish due in part to
the flexibility of the Reagent Data library.  In the future,
tradeskill information can also be included as is done via the
Reagent Tips addon.  Reagent Watch 3.0 and above will also
utilize Reagent Data and I'm considering a few other things to
create a Reagent Suite.  The sky's the limit!  (No Cosmos pun intended.)

Thanks To:
   * My wife for putting up with my bizarre coding desires and
   having some good data structure sense.
   * Celdor for assisting with some design concepts and
   suggesting some API features...even if your suggestions suck.
   ;-)
   * Xadros for your German translation.  You originally provided
   it for little ol' Reagent Watch and now look at what it's
   become.
   * Tuatara and Alexander for the design and prototype of the
   item link version.  This allowed Reagent Data to expand to a
   whole new level of usefulness.
   * Bima for the recipe information.  How cool is this stuff anyway?