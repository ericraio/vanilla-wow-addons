if ( GetLocale() == "frFR" ) then

------------ TEXT VARIABLEN
--Color
local GREY = "|cff999999";
local RED = "|cffff0000";
local REDA = "|cffcc6666";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";
local YELLOW = "|cffffff00";

AQSERVERASKInformation = " Please klick right until you see the Item frame."
AQSERVERASK = "Querry the server for: "
AQOptionB = "Options"
AQStoryB = "Story"
AQNoReward = "No Rewards"
AQERRORNOTSHOWN = "This Item is not safty!"
AQERRORASKSERVER = "Right-click to attempt to query\nthe server.  You may be disconnected."
AQDiscription_OR = "|cffff0000 or "..WHITE..""
AQDiscription_AND = "|cff008000 and "..WHITE..""
AQDiscription_REWARD = "Reward: "
AQDiscription_ATTAIN = "Attain: "
AQDiscription_LEVEL = "Niveau : "
AQDiscription_START = "Commence \195\160: \n"
AQDiscription_AIM = "Objectif: \n"
AQDiscription_NonTE = "Nonte: \n"
AQDiscription_PREQUEST= "Pr\195\169qu\195\170te: "
AQDiscription_FOLGEQUEST = "Leads to: "
ATLAS_VERSIONWARNINGTEXT = "Your atlas is old! pls update it :) (newest version is 1.8.1)"

-- ITEM TRANSLATION
AQITEM_DAGGER = " Dagger"
AQITEM_SWORD = " Sword"
AQITEM_AXE = " Axe"
AQITEM_WAND = "Wand"
AQITEM_STAFF = "Staff"
AQITEM_MACE = " Mace"
AQITEM_SHIELD = "Shield"
AQITEM_MACE = "Mace"
AQITEM_GUN = "Gun"

AQITEM_WAIST = "Waist,"
AQITEM_SHOULDER = "Shoulder,"
AQITEM_CHEST = "Chest,"
AQITEM_LEGS = "Legs,"
AQITEM_HANDS = "Hands,"
AQITEM_FEET = "Feet,"
AQITEM_WRIST = "Wrist,"
AQITEM_HEAD = "Head,"
AQITEM_BACK = "Back"

AQITEM_CLOTH = " Cloth"
AQITEM_LEATHER = " Leather"
AQITEM_MAIL = " Mail"
AQITEM_PLATE = " Plate"

AQITEM_OFFHAND = "Offhand"
AQITEM_MAINHAND = "Main Hand,"
AQITEM_ONEHAND = "One-Hand,"
AQITEM_TWOHAND = "Two-Hand,"

AQITEM_TRINKET = "Trinket"
AQITEM_POTION = "Potion"
AQITEM_OFFHAND = "Held In Hand"
AQITEM_NECK = "Neck"
AQITEM_PATTERN = "Pattern"
AQITEM_BAG = "Bag"
AQITEM_RING = "Ring"
AQITEM_KEY = "Key"

--------------DEADMINES/Inst1 ( 5 Quests)------------
Inst1Story = "Once the greatest gold production center in the human lands, the Dead Mines were abandoned when the Horde razed Stormwind city during the First War. Now the Defias Brotherhood has taken up residence and turned the dark tunnels into their private sanctum. It is rumored that the thieves have conscripted the clever goblins to help them build something terrible at the bottom of the mines - but what that may be is still uncertain. Rumor has it that the way into the Deadmines lies through the quiet, unassuming village of Moonbrook."
Inst1Caption = "Deadmines"
Inst1QAA = "5 Quests" -- how much quest for alliance
Inst1QAH = "No Quests" -- for horde

testid = "19135"
--QUEST1 Allianz

Inst1Quest1 = "1. Red Silk Bandanas"
Inst1Quest1_Level = "17"
Inst1Quest1_Attain = "12"
Inst1Quest1_Aim = "Scout Riell at the Sentinel Hill Tower wants you to bring her 10 Red Silk Bandanas."
Inst1Quest1_Location = "Scout Riell (Westfall - Sentinal Hill; "..YELLOW.."56, 47"..WHITE..")"
Inst1Quest1_Note = "You can get this Bandanas from miners in Deadmines or pre-instances."
Inst1Quest1_Prequest = "No"
Inst1Quest1_Folgequest = "No"
--
Inst1Quest1name1 = "Solid Shortblade"
Inst1Quest1name2 = "Scrimshaw Dagger"
Inst1Quest1name3 = "Piercing Axe"

--Quest 2 allianz

Inst1Quest2 = "2. Collecting Memories"
Inst1Quest2_Level = "18"
Inst1Quest2_Attain = "?"
Inst1Quest2_Aim = "Retrieve 4 Miners' Union Cards and return them to Wilder Thistlenettle in Stormwind."
Inst1Quest2_Location = "Wilder Thistlenettle (Stormwind; "..YELLOW.."65, 21"..WHITE.." )"
Inst1Quest2_Note = "The Undeads (elite), short before you join the instances, drop the cards."
Inst1Quest2_Prequest = "No"
Inst1Quest2_Folgequest = "No"
--
Inst1Quest2name1 = "Tunneler's Boots"
Inst1Quest2name2 = "Dusty Mining Gloves"
--Quest 3 allianz

Inst1Quest3 = "3. Oh Brother. . ."
Inst1Quest3_Level = "20"
Inst1Quest3_Attain = "?"
Inst1Quest3_Aim = "Bring Foreman Thistlenettle's Explorers' League Badge to Wilder Thistlenettle in Stormwind."
Inst1Quest3_Location = "Wilder Thistlenettle (Stormwind; "..YELLOW.."65,21"..WHITE.." )"
Inst1Quest3_Note = "The Undeads (elite), short before you join the instances, drop the Badge."
Inst1Quest3_Prequest = "No"
Inst1Quest3_Folgequest = "No"
--
Inst1Quest3name1 = "Miner's Revenge"

--Quest 4 allianz

Inst1Quest4 = "4. Underground Assault"
Inst1Quest4_Level = "20"
Inst1Quest4_Attain = "15"
Inst1Quest4_Aim = "Retrieve the Gnoam Sprecklesprocket from the Deadmines and return it to Shoni the Shilent in Stormwind."
Inst1Quest4_Location = "Shoni die Shilent (Stormwind; "..YELLOW.."55,12"..WHITE.." )"
Inst1Quest4_Note = "You get the Prequest from Gnoarn (Stormwind; 69,50).\nSneed's Shredder drops the Sprecklesprocket [3]."
Inst1Quest4_Prequest = "Yes, Speak with Shoni"
Inst1Quest4_Folgequest = "No"
Inst1Quest4PreQuest = "true"
--
Inst1Quest4name1 = "Polar Gauntlets"
Inst1Quest4name2 = "Sable Wand"

--Quest 5 allianz

Inst1Quest5 = "5. The Defias Brotherhood (Questline)"
Inst1Quest5_Level = "22"
Inst1Quest5_Attain = "14"
Inst1Quest5_Aim = "Kill Edwin VanCleef and bring his head to Gryan Stoutmantle."
Inst1Quest5_Location = "Gryan Stoutmantle (Westfall - Sentinal Hill "..YELLOW.."56,47 "..WHITE..")"
Inst1Quest5_Note = "You start this Questline at Gryan Stoutmantle (Westfall; 56,47).\nEdwin VanCleef is the last boss of The Deadmines. You can find him at the top of his ship [6]."
Inst1Quest5_Prequest = "Yes, The Defias Brotherhood."
Inst1Quest5_Folgequest = "Yes, The Unsent Letter"
Inst1Quest5PreQuest = "true"
--
Inst1Quest5name1 = "Chausses of Westfall"
Inst1Quest5name2 = "Tunic of Westfall"
Inst1Quest5name3 = "Staff of Westfall"

--Quest 6 allianz

Inst1Quest6 = "6. The Test of Righteousness (Paladin)"
Inst1Quest6_Level = "22"
Inst1Quest6_Attain = "20"
Inst1Quest6_Aim = "Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."
Inst1Quest6_Location = "Jordan Stilwell(Dun Morogh - Ironforge Entrance "..YELLOW.."52,36 "..WHITE..")"
Inst1Quest6_Note = "To watch the note klick on [The Test of Righteousness Information]."
Inst1Quest6_Prequest = "Yes, The Tome of Valor -> The Test of Righteousness"
Inst1Quest6_Folgequest = "Yes, The Test of Righteousness"
Inst1Quest6PreQuest = "true"
--
Inst1Quest6name1 = "Verigan's Fist"

Inst1Quest7 = "The Test of Righteousness Information"
Inst1Quest7TEXT = "Only Paladins can get this quest!\n1. You get the  Whitestone Oak Lumber from Goblin Woodcarvers in [Deadmines].\n2. To get the Bailor's Refined Ore Shipment you musst talk to Bailor Stonehand (Loch Modan; 35,44 ). He gives you the 'Bailor's Ore Shipment' quest. You find the Jordan's Ore Shipment behind a tree at 71,21\n3. You get Jordan's Smithing Hammer in [Shadowfang Keep] next to [B] (the stables).\n4. To get a Kor Gem you have to go to Thundris Windweaver (Darkshore; 37,40) and make the 'Seeking the Kor Gem' quest. For this quest you musst kill Blackfathom oracles or priestesses before [Blackfathom Deeps]. They drop a corrupted Kor Gem. Thundris Windweaver clean it for you."
Inst1Quest7_Level = "100"
Inst1Quest7_Attain = ""
Inst1Quest7_Aim = ""
Inst1Quest7_Location = ""
Inst1Quest7_Note = ""
Inst1Quest7_Prequest = ""
Inst1Quest7_Folgequest = ""
Inst1Quest7FQuest = "true"

--------------WaillingCaverns/HDW ( 7 quests)------------
Inst2Story = "Recently, a night elf druid named Naralex discovered a network of underground caverns within the heart of the Barrens. Dubbed the 'Wailing Caverns', these natural caves were filled with steam fissures which produced long, mournful wails as they vented. Naralex believed he could use the caverns' underground springs to restore lushness and fertility to the Barrens - but to do so would require siphoning the energies of the fabled Emerald Dream. Once connected to the Dream however, the druid's vision somehow became a nightmare. Soon the Wailing Caverns began to change - the waters turned foul and the once-docile creatures inside metamorphosed into vicious, deadly predators. It is said that Naralex himself still resides somewhere inside the heart of the labyrinth, trapped beyond the edges of the Emerald Dream. Even his former acolytes have been corrupted by their master's waking nightmare - transformed into the wicked Druids of the Fang."
Inst2Caption = "Wailing Caverns"
Inst2QAA = "5 Quests"
Inst2QAH = "7 Quests"

--QUEST 1 Alliance

Inst2Quest1 = "1. Deviate Hides"
Inst2Quest1_Level = "17"
Inst2Quest1_Attain = "?"
Inst2Quest1_Aim = "Nalpak in the Wailing Caverns wants 20 Deviate Hides."
Inst2Quest1_Location = "Nalpak (Barrens - Wailing Caverns; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest1_Note = "Every deviat mob in and in front of the instance drops the hides. Nalpak is in a cave above the entrance."
Inst2Quest1_Prequest = "No"
Inst2Quest1_Folgequest = "No"
--
Inst2Quest1name1 = "Slick Deviate Leggings"
Inst2Quest1name2 = "Deviate Hide Pack"


--QUEST 2 Allianz

Inst2Quest2 = "2. Trouble at the Docks"
Inst2Quest2_Level = "18"
Inst2Quest2_Attain = "14"
Inst2Quest2_Aim = "Crane Operator Bigglefuzz in Ratchet wants you to retrieve the bottle of 99-Year-Old Port from Mad Magglish who is hiding in the Wailing Caverns."
Inst2Quest2_Location = "Crane Operator Bigglefuzz (Barrens - Ratchet; "..YELLOW.."63,37 "..WHITE..")"
Inst2Quest2_Note = "You get the bottle right before you go into the instance by killing Mad Magglish. You often find him, when you go into the cave and turn to the right. Hurry, he is small and hidden (stealth)."
Inst2Quest2_Prequest = "No"
Inst2Quest2_Folgequest = "No"

--QUEST 3 Allianz

Inst2Quest3 = "3. Smart Drinks"
Inst2Quest3_Level = "18"
Inst2Quest3_Attain = "?"
Inst2Quest3_Aim = "Bring 6 portions of Wailing Essence to Mebok Mizzyrix in Ratchet."
Inst2Quest3_Location = "Mebok Mizzyrix (Barrens - Ratchet; "..YELLOW.."62,37 "..WHITE..")"
Inst2Quest3_Note = "You get the Prequest from Mebok Mizzyrix too.\nAll Ectoplasm enemies in and before the instance drop the Essence."
Inst2Quest3_Prequest = "Yes, Raptor Horns"
Inst2Quest3_Folgequest = "No"
Inst2Quest3PreQuest = "true"

--QUEST 4 horde

Inst2Quest4 = "4. Deviate Eradication"
Inst2Quest4_Level = "21"
Inst2Quest4_Attain = "?"
Inst2Quest4_Aim = "Ebru in the Wailing Caverns wants you to kill 7 Deviate Ravagers, 7 Deviate Vipers, 7 Deviate Shamblers and 7 Deviate Dreadfangs."
Inst2Quest4_Location = "Ebru (Barrens; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest4_Note = "Ebru is in a cave above the entrance."
Inst2Quest4_Prequest = "No"
Inst2Quest4_Folgequest = "No"
--
Inst2Quest4name1 = "Pattern: Deviate Scale Belt"
Inst2Quest4name2 = "Sizzle Stick"
Inst2Quest4name3 = "Dagmire Gauntlets"

--QUEST 5 Allianz

Inst2Quest5 = "5. The Glowing Shard"
Inst2Quest5_Level = "25"
Inst2Quest5_Attain = "21"
Inst2Quest5_Aim = "Travel to Ratchet to find the meaning behind the Nightmare Shard."
Inst2Quest5_Location = "The Glowing Shard(drop) (Wailing Caverns)"
Inst2Quest5_Note = "You get the glowing shard, when you kill the last boss Mutanus the Devourer. Mutanus the Devourer only appear, if you kill the four druids and escord the druid at the entrance [9].\nWhen you have the Shard, you must bring it to Ratchet (bank), and then back to the top of the hill over Wailing Caverns to Falla Sagewind."
Inst2Quest5_Prequest = "No"
Inst2Quest5_Folgequest = "Yes, In Nightmares"
--
Inst2Quest5name1 = "Talbar Mantle"
Inst2Quest5name2 = "Quagmire Galoshes"


--QUEST 1 horde

Inst2Quest1_HORDE = "1. Deviate Hides"
Inst2Quest1_HORDE_Level = "17"
Inst2Quest1_HORDE_Attain = "?"
Inst2Quest1_HORDE_Aim = "Nalpak in the Wailing Caverns wants 20 Deviate Hides."
Inst2Quest1_HORDE_Location = "Nalpak (Barrens - Wailing Caverns; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest1_HORDE_Note = "Every deviat mob in and in front of the instance drops the hides. Nalpak is in a cave above the entrance."
Inst2Quest1_HORDE_Prequest = "No"
Inst2Quest1_HORDE_Folgequest = "No"
--
Inst2Quest1name1_HORDE = "Slick Deviate Leggings"
Inst2Quest1name2_HORDE = "Deviate Hide Pack"

--QUEST 2 horde

Inst2Quest2_HORDE = "2. Trouble at the Docks"
Inst2Quest2_HORDE_Level = "18"
Inst2Quest2_HORDE_Attain = "14"
Inst2Quest2_HORDE_Aim = "Crane Operator Bigglefuzz in Ratchet wants you to retrieve the bottle of 99-Year-Old Port from Mad Magglish who is hiding in the Wailing Caverns."
Inst2Quest2_HORDE_Location = "Crane Operator Bigglefuzz (Barrens - Ratchet; "..YELLOW.."63,37 "..WHITE..")"
Inst2Quest2_HORDE_Note = "You get the bottle right before you go into the instance by killing Mad Magglish. You often find him, when you go into the cave and turn to the right. Hurry, he is small and hidden (stealth)."
Inst2Quest2_HORDE_Prequest = "No"
Inst2Quest2_HORDE_Folgequest = "No"

--QUEST 3 horde

Inst2Quest3_HORDE = "3. Serpentbloom"
Inst2Quest3_HORDE_Level = "18"
Inst2Quest3_HORDE_Attain = "14"
Inst2Quest3_HORDE_Aim = "Apothecary Zamah in Thunder Bluff wants you to collect 10 Serpentbloom."
Inst2Quest3_HORDE_Location = "Apothecary Zamah (Thunder Bluff; "..YELLOW.."22,20 "..WHITE..")"
Inst2Quest3_HORDE_Note = "You get the prequest from Apothecary Helbrim (Brachland/Crossroad; 51,30).\nYou get the Serpentbloom inside the cave in front of the instance and inside the instance. Player with Herbalism can see the plants on her minimap."
Inst2Quest3_HORDE_Prequest = "Yes, Fungal Spores -> Apothecary Zamah"
Inst2Quest3_HORDE_Folgequest = "No"
Inst2Quest3PreQuest_HORDE = "true"
--
Inst2Quest3name1_HORDE = "Apothecary Gloves"

--QUEST 4 horde

Inst2Quest4_HORDE = "4. Smart Drinks"
Inst2Quest4_HORDE_Level = "18"
Inst2Quest4_HORDE_Attain = "?"
Inst2Quest4_HORDE_Aim = "Bring 6 portions of Wailing Essence to Mebok Mizzyrix in Ratchet."
Inst2Quest4_HORDE_Location = "Mebok Mizzyrix (Barrens - Ratchet; "..YELLOW.."62,37 "..WHITE..")"
Inst2Quest4_HORDE_Note = "You get the Prequest from Mebok Mizzyrix too.\nAll Ectoplasm enemies in and before the instance drop the Essence."
Inst2Quest4_HORDE_Prequest = "Yes, Raptor Horns"
Inst2Quest4_HORDE_Folgequest = "No"
Inst2Quest4PreQuest_HORDE = "true"

--QUEST 5 horde

Inst2Quest5_HORDE = "5. Deviate Eradication"
Inst2Quest5_HORDE_Level = "21"
Inst2Quest5_HORDE_Attain = "?"
Inst2Quest5_HORDE_Aim = "Ebru in the Wailing Caverns wants you to kill 7 Deviate Ravagers, 7 Deviate Vipers, 7 Deviate Shamblers and 7 Deviate Dreadfangs."
Inst2Quest5_HORDE_Location = "Ebru (Barrens; "..YELLOW.."47,36 "..WHITE..")"
Inst2Quest5_HORDE_Note = "Ebru is in a cave above the entrance."
Inst2Quest5_HORDE_Prequest = "No"
Inst2Quest5_HORDE_Folgequest = "No"
--
Inst2Quest5name1_HORDE = "Pattern: Deviate Scale Belt"
Inst2Quest5name2_HORDE = "Sizzle Stick"
Inst2Quest5name3_HORDE = "Dagmire Gauntlets"

--QUEST 6 horde

Inst2Quest6_HORDE = "6. Leaders of the Fang (Questline)"
Inst2Quest6_HORDE_Level = "22"
Inst2Quest6_HORDE_Attain = "18"
Inst2Quest6_HORDE_Aim = "Bring the Gems of Cobrahn, Anacondra, Pythas and Serpentis to Nara Wildmane in Thunder Bluff."
Inst2Quest6_HORDE_Location = "Nara Wildmane (Thunder Bluff; "..YELLOW.."75,31 "..WHITE..")"
Inst2Quest6_HORDE_Note = "The Questline starts at Hamuul Runetotem (Thunderbluff; 78,28)\nThe 4 druids drop the gems [2],[3],[5],[7]"
Inst2Quest6_HORDE_Prequest = "Yes, The Barrens Oases -> Nara Wildmane"
Inst2Quest6_HORDE_Folgequest = "No"
Inst2Quest6PreQuest_HORDE = "true"
--
Inst2Quest6name1_HORDE = "Crescent Staff"
Inst2Quest6name2_HORDE = "Wingblade"

--QUEST 7 horde

Inst2Quest7_HORDE = "7. The Glowing Shard"
Inst2Quest7_HORDE_Level = "25"
Inst2Quest7_HORDE_Attain = "21"
Inst2Quest7_HORDE_Aim = "Travel to Ratchet to find the meaning behind the Nightmare Shard."
Inst2Quest7_HORDE_Location = "The Glowing Shard(drop) (Wailing Caverns)"
Inst2Quest7_HORDE_Note = "You get the glowing shard, when you kill the last boss Mutanus the Devourer. Mutanus the Devourer only appear, if you kill the four druids and escord the druid at the entrance [9].\nWhen you have the Shard, you must bring it to Ratchet (bank), and then back to the top of the hill over Wailing Caverns to Falla Sagewind."
Inst2Quest7_HORDE_Prequest = "No"
Inst2Quest7_HORDE_Folgequest = "Ja, In Nightmares"
--
Inst2Quest7name1_HORDE = "Talbar Mantle"
Inst2Quest7name2_HORDE = "Quagmire Galoshes"


--------------Uldaman/Inst4 ( 16 quests)------------
Inst4Story = "Uldaman is an ancient Titan vault that has laid buried deep within the earth since the world's creation. Dwarven excavations have recently penetrated this forgotten city, releasing the Titans' first failed creations: the troggs. Legends say that the Titans created troggs from stone. When they deemed the experiment a failure, the Titans locked the troggs away and tried again - resulting in the creation of the dwarven race. The secrets of the dwarves' creation are recorded on the fabled Discs of Norgannon - massive Titan artifacts that lie at the very bottom of the ancient city. Recently, the Dark Iron dwarves have launched a series of incursions into Uldaman, hoping to claim the discs for their fiery master, Ragnaros. However, protecting the buried city are several guardians - giant constructs of living stone that crush any hapless intruders they find. The Discs themselves are guarded by a massive, sentient Stonekeeper called Archaedas. Some rumors even suggest that the dwarves' stone-skinned ancestors, the earthen, still dwell deep within the city's hidden recesses."
Inst4Caption = "Uldaman"
Inst4QAA = "16 Quests"
Inst4QAH = "10 Quests"

--QUEST 1 Allianz

Inst4Quest1 = "1. A Sign of Hope"
Inst4Quest1_Level = "35"
Inst4Quest1_Attain = "35"
Inst4Quest1_Aim = "Find Hammertoe Grez in Uldaman."
Inst4Quest1_Location = "Prospector Ryedol (Badlands; "..YELLOW.."53,43 "..WHITE..")"
Inst4Quest1_Note = "The Prequest starts at the Crumpled Map (Badlands; 53,33).\nYou find Hammertoe Grez before you enter the instance (North, West)."
Inst4Quest1_Prequest = "Yes, A Sign of Hope"
Inst4Quest1_Folgequest = "Yes, Amulet of Secrets"
Inst4Quest1PreQuest = "true"

--QUEST 2 Allianz

Inst4Quest2 = "2. Amulet of Secrets"
Inst4Quest2_Level = "40"
Inst4Quest2_Attain = "?"
Inst4Quest2_Aim = "Find Hammertoe's Amulet and return it to him in Uldaman."
Inst4Quest2_Location = "Hammertoe Grez (Uldaman - pre-instance)"
Inst4Quest2_Note = "The Amulet is north of the instance entrance, at the east end of a tunnel, before the instance."
Inst4Quest2_Prequest = "Yes, A Sign of Hope"
Inst4Quest2_Folgequest = "Yes, Prospect of Faith"
Inst4Quest2FQuest = "true"


--QUEST 3 Allianz

Inst4Quest3 = "3. The Lost Tablets of Will"
Inst4Quest3_Level = "45"
Inst4Quest3_Attain = "38"
Inst4Quest3_Aim = "Find the Tablet of Will, and return them to Advisor Belgrum in Ironforge."
Inst4Quest3_Location = "Advisor Belgrum (Ironforge; "..YELLOW.."77,10 "..WHITE..")"
Inst4Quest3_Note = "The tablets are at [8]."
Inst4Quest3_Prequest = "Yes, Amulet of Secrets -> An Ambassador of Evil"
Inst4Quest3_Folgequest = "No"
Inst4Quest3FQuest = "true"
--
Inst4Quest3name1 = "Medal of Courage"

--QUEST 4 Allianz

Inst4Quest4 = "4. Power Stones"
Inst4Quest4_Level = "36"
Inst4Quest4_Attain = "?"
Inst4Quest4_Aim = "Bring 8 Dentrium Power Stones and 8 An'Alleum Power Stones to Rigglefuzz in the Badlands."
Inst4Quest4_Location = "Rigglefuzz (Badlands; "..YELLOW.."42,52 "..WHITE..")"
Inst4Quest4_Note = "The stones can be found on any Shadoforge enemies before and in the instance."
Inst4Quest4_Prequest = "No"
Inst4Quest4_Folgequest = "No"
--
Inst4Quest4name1 = "Energized Stone Circle"
Inst4Quest4name2 = "Duracin Bracers"
Inst4Quest4name3 = "Everlast Boots"

--QUEST 5 Allianz

Inst4Quest5 = "5. Agmond's Fate"
Inst4Quest5_Level = "38"
Inst4Quest5_Attain = "38"
Inst4Quest5_Aim = "Bring 4 Carved Stone Urns to Prospector Ironband in Loch Modan."
Inst4Quest5_Location = "Prospector Ironband (Loch Modan; "..YELLOW.."65,65 "..WHITE..")"
Inst4Quest5_Note = "The Prequest starts at Prospector Stormpike (Ironforge; 74,12).\nThe Urns are scattered throughout the caves before the instance."
Inst4Quest5_Prequest = "Yes, Ironband Wants You! -> Murdaloc"
Inst4Quest5_Folgequest = "No"
Inst4Quest5PreQuest = "true"
--
Inst4Quest5name1 = "Prospector Gloves"

--QUEST 6 Allianz

Inst4Quest6 = "6. Solution to Doom"
Inst4Quest6_Level = "40"
Inst4Quest6_Attain = "31"
Inst4Quest6_Aim = "Bring the Tablet of Ryun'eh to Theldurin the Lost."
Inst4Quest6_Location = "Theldurin the Lost (Badlands; "..YELLOW.."51,76 "..WHITE..")"
Inst4Quest6_Note = "The tablet is north of the caves, at the east end of a tunnel, before the instance."
Inst4Quest6_Prequest = "No"
Inst4Quest6_Folgequest = "Yes, To Ironforge for Yagyin's Digest"
--
Inst4Quest6name1 = "Doomsayer's Robe"

--QUEST 7 Allianz

Inst4Quest7 = "7. The Lost Dwarves"
Inst4Quest7_Level = "40"
Inst4Quest7_Attain = "?"
Inst4Quest7_Aim = "Find Baelog in Uldaman."
Inst4Quest7_Location = "Prospector Stormpike (Badlands; "..YELLOW.."46,12 "..WHITE..")"
Inst4Quest7_Note = "Bealog is at [1]."
Inst4Quest7_Prequest = "No"
Inst4Quest7_Folgequest = "Yes, The Hidden Chamber"

--QUEST 8 Allianz

Inst4Quest8 = "8. The Hidden Chamber"
Inst4Quest8_Level = "40"
Inst4Quest8_Attain = "?"
Inst4Quest8_Aim = "Read Baelog's Journal, explore the hidden chamber, then report to Prospector Stormpike."
Inst4Quest8_Location = "Baelog (Uldaman - [1])"
Inst4Quest8_Note = "The Hidden Chamber is at [4]."
Inst4Quest8_Prequest = "Yes, The Lost Dwarves"
Inst4Quest8_Folgequest = "No"
Inst4Quest8FQuest = "true"
--
Inst4Quest8name1 = "Dwarven Charge"
Inst4Quest8name2 = "Explorer's League Lodestar"

--QUEST 9 Allianz

Inst4Quest9 = "9. The Shattered Necklace"
Inst4Quest9_Level = "41"
Inst4Quest9_Attain = "37"
Inst4Quest9_Aim = "Search for the original creator of the shattered necklace to learn of its potential value."
Inst4Quest9_Location = "Shattered Necklace (random drop) (Uldaman)"
Inst4Quest9_Note = "Bring the necklace to Talvash del Kissel in Ironforge (36,3)"
Inst4Quest9_Prequest = "No"
Inst4Quest9_Folgequest = "Yes, Lore for a Price"

--QUEST 10 Allianz

Inst4Quest10 = "10. Back to Uldaman"
Inst4Quest10_Level = "41"
Inst4Quest10_Attain = "37"
Inst4Quest10_Aim = "Search for clues as to the current disposition of Talvash's necklace within Uldaman. The slain paladin he mentioned was the person who has it last."
Inst4Quest10_Location = "Talvash del Kissel (Ironforge; "..YELLOW.."36,3 "..WHITE..")"
Inst4Quest10_Note = "The Paladin is at [2]."
Inst4Quest10_Prequest = "Yes, Lore for a Price"
Inst4Quest10_Folgequest = "Yes, Find the Gems"

--QUEST 11 Allianz

Inst4Quest11 = "11. Find the Gems"
Inst4Quest11_Level = "43"
Inst4Quest11_Attain = "37"
Inst4Quest11_Aim = "Find the ruby, sapphire, and topaz that are scattered throughout Uldaman. Once acquired, contact Talvash del Kissel remotely by using the Phial of Scrying he previously gave you."
Inst4Quest11_Location = "Remains of a Paladin (Uldaman)"
Inst4Quest11_Note = "The gems are at[1], [8], and [9]."
Inst4Quest11_Prequest = "Yes, Back to Uldaman"
Inst4Quest11_Folgequest = "Yes, Restoring the Necklace"
Inst4Quest11FQuest = "true"

--QUEST 12 Allianz

Inst4Quest12 = "12. Restoring the Necklace"
Inst4Quest12_Level = "44"
Inst4Quest12_Attain = "38"
Inst4Quest12_Aim = "Obtain a power source from the most powerful construct you can find in Uldaman, and deliver it to Talvash del Kissel in Ironforge."
Inst4Quest12_Location = "Talvash's Scrying Bowl"
Inst4Quest12_Note = "The Shattered Necklace Power Source drops Archaedas [10]."
Inst4Quest12_Prequest = "Yes, Find the Gems."
Inst4Quest12_Folgequest = "No"-- AUFPASSEN HIER IS EIN FOLGEQUEST ABER ES GIBT NUR BELOHNUNG!
--
Inst4Quest12name1 = "Talvash's Enhancing Necklace"
Inst4Quest12FQuest = "true"

--QUEST 13 Allianz

Inst4Quest13 = "13. Uldaman Reagent Run"
Inst4Quest13_Level = "42"
Inst4Quest13_Attain = "38"
Inst4Quest13_Aim = "Bring 12 Magenta Fungus Caps to Ghak Healtouch in Thelsamar."
Inst4Quest13_Location = "Ghak Healtouch (Loch Modan; "..YELLOW.."37,49 "..WHITE..")"
Inst4Quest13_Note = "The caps are scattered throughout the instance."
Inst4Quest13_Prequest = "No"
Inst4Quest13_Folgequest = "No"
--
Inst4Quest13name1 = "Restorative Potion"

--QUEST 14 Allianz

Inst4Quest14 = "14. Reclaimed Treasures"
Inst4Quest14_Level = "43"
Inst4Quest14_Attain = "?"
Inst4Quest14_Aim = "Get Krom Stoutarm's treasured possession from his chest in the North Common Hall of Uldaman, and bring it to him in Ironforge."
Inst4Quest14_Location = "Krom Stoutarm (Ironforge; "..YELLOW.."74,9 "..WHITE..")"
Inst4Quest14_Note = "You find the treasur before you enter the instance. It is in the north of the caves, at the southeast end of the first tunnel."
Inst4Quest14_Prequest = "No"
Inst4Quest14_Folgequest = "No"

--QUEST 15 Allianz

Inst4Quest15 = "15. The Platinum Discs"
Inst4Quest15_Level = "45"
Inst4Quest15_Attain = "40"
Inst4Quest15_Aim = "Speak with stone watcher and learn what ancient lore it keeps. Once you have learned what lore it has to offer, activate the Discs of Norgannon. -> Take the miniature version of the Discs of Norgannon to the Explorers' League in Ironforge."
Inst4Quest15_Location = "The Discs of Norgannon (Uldaman - [11])"
Inst4Quest15_Note = "After you receive the quest, speak to the stone watcher to the left of the discs.  Then use the platinum discs again to recieve miniature discs, which you'll have to take to High Explorer Magellas in Ironforge (69,18)."
Inst4Quest15_Prequest = "No"
Inst4Quest15_Folgequest = "No"
--
Inst4Quest15name1 = "Taupelzsack"
Inst4Quest15name2 = "Superior Healing Potion"
Inst4Quest15name3 = "Greater Mana Potion"

--QUEST 16 Allianz

Inst4Quest16 = "16. Power in Uldaman (Mage)"
Inst4Quest16_Level = "40"
Inst4Quest16_Attain = "35"
Inst4Quest16_Aim = "Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."
Inst4Quest16_Location = "Tabetha (Dustwallow Marsh; "..YELLOW.."46,57 "..WHITE..")"
Inst4Quest16_Note = "This quest is only available to Mages!\nThe Obsidian Power Source drops from the Obsidian Sentinel at [5]."
Inst4Quest16_Prequest = "Yes, The Exorcism"
Inst4Quest16_Folgequest = "Yes, Mana Surges"
Inst4Quest16PreQuest = "true"

--QUEST 1 Horde

Inst4Quest1_HORDE = "1. Power Stones"
Inst4Quest1_HORDE_Level = "36"
Inst4Quest1_HORDE_Attain = "?"
Inst4Quest1_HORDE_Aim = "Bring 8 Dentrium Power Stones and 8 An'Alleum Power Stones to Rigglefuzz in the Badlands."
Inst4Quest1_HORDE_Location = "Rigglefuzz (Badlands; "..YELLOW.."42:52 "..WHITE..")"
Inst4Quest1_HORDE_Note = "The stones can be found on any Shadowforge enemies before and in the instance."
Inst4Quest1_HORDE_Prequest = "No"
Inst4Quest1_HORDE_Folgequest = "No"
--
Inst4Quest1name1_HORDE = "Energized Stone Circle"
Inst4Quest1name2_HORDE = "Duracin Bracers"
Inst4Quest1name3_HORDE = "Everlast Boots"

--QUEST 2 Horde

Inst4Quest2_HORDE = "2. Solution to Doom"
Inst4Quest2_HORDE_Level = "40"
Inst4Quest2_HORDE_Attain = "31"
Inst4Quest2_HORDE_Aim = "Bring the Tablet of Ryun'eh to Theldurin the Lost."
Inst4Quest2_HORDE_Location = "Theldurin the Lost (Badlands; "..YELLOW.."51,76 "..WHITE..")"
Inst4Quest2_HORDE_Note = "The tablet is north of the caves, at the east end of a tunnel, before the instance."
Inst4Quest2_HORDE_Prequest = "No"
Inst4Quest2_HORDE_Folgequest = "Yes, To Ironforge for Yagyin's Digest"
--
Inst4Quest2name1_HORDE = "Doomsayer's Robe"

--QUEST 3 Horde

Inst4Quest3_HORDE = "3. Necklace Recovery"
Inst4Quest3_HORDE_Level = "41"
Inst4Quest3_HORDE_Attain = "37"
Inst4Quest3_HORDE_Aim = "Look for a valuable necklace within the Uldaman dig site and bring it back to Dran Droffers in Orgrimmar. The necklace may be damaged."
Inst4Quest3_HORDE_Location = "Dran Droffers (Orgrimmar; "..YELLOW.."59,36 "..WHITE..")"
Inst4Quest3_HORDE_Note = "The necklace is a random drop in the instance."
Inst4Quest3_HORDE_Prequest = "No"
Inst4Quest3_HORDE_Folgequest = "Yes, Necklace Recovery, Take 2."

--QUEST 4 Horde

Inst4Quest4_HORDE = "4. Necklace Recovery, Take 2"
Inst4Quest4_HORDE_Level = "41"
Inst4Quest4_HORDE_Attain = "38"
Inst4Quest4_HORDE_Aim = "Find a clue as to the gems' whereabouts in the depths of Uldaman."
Inst4Quest4_HORDE_Location = "Dran Droffers (Orgrimmar; "..YELLOW.."59,36 "..WHITE..")"
Inst4Quest4_HORDE_Note = "The Paladin is at [2]."
Inst4Quest4_HORDE_Prequest = "Yes, Necklace Recovery"
Inst4Quest4_HORDE_Folgequest = "Yes, Translating the Journal"
Inst4Quest4FQuest_HORDE = "true"

--QUEST 5 Horde

Inst4Quest5_HORDE = "5. Translating the Journal"
Inst4Quest5_HORDE_Level = "42"
Inst4Quest5_HORDE_Attain = "40"
Inst4Quest5_HORDE_Aim = "Find someone who can translate the paladin's journal. The closest location that might have someone is Kargath, in the Badlands."
Inst4Quest5_HORDE_Location = "Remains of a Paladin (Uldaman - Punkt 2)"
Inst4Quest5_HORDE_Note = "The translator (Jarkal Mossmeld) is in Kargath (Badlands 2,46)."
Inst4Quest5_HORDE_Prequest = "Yes, Necklace Recovery, Take 2"
Inst4Quest5_HORDE_Folgequest = "Yes, Find the Gems and Power Source"
Inst4Quest5FQuest_HORDE = "true"

--QUEST 6 Horde

Inst4Quest6_HORDE = "6. Find the Gems and Power Source"
Inst4Quest6_HORDE_Level = "44"
Inst4Quest6_HORDE_Attain = "37"
Inst4Quest6_HORDE_Aim = "Recover all three gems and a power source for the necklace from Uldaman, and then bring them to Jarkal Mossmeld in Kargath. Jarkal believes a power source might be found on the strongest construct present in Uldaman."
Inst4Quest6_HORDE_Location = "Jarkal Mossmeld (Badlands; "..YELLOW.."2,46 "..WHITE..")"
Inst4Quest6_HORDE_Note = "The gems are in [1], [8], and [9].  The Shattered Necklace Power Source drops from Archaedas [10]."
Inst4Quest6_HORDE_Prequest = "Yes, Translating the Journal."
Inst4Quest6_HORDE_Folgequest = "Yes, Deliver the Gems"
Inst4Quest6FQuest_HORDE = "true"
--
Inst4Quest6name1_HORDE = "Jarkal's Enhancing Necklace"

--QUEST 7 Horde

Inst4Quest7_HORDE = "7. Uldaman Reagent Run"
Inst4Quest7_HORDE_Level = "42"
Inst4Quest7_HORDE_Attain = "38"
Inst4Quest7_HORDE_Aim = "Bring 12 Magenta Fungus Caps to Jarkal Mossmeld in Kargath."
Inst4Quest7_HORDE_Location = "Jarkal Mossmeld (Badlands; "..YELLOW.."2,69 "..WHITE..")"
Inst4Quest7_HORDE_Note = "You get the Prequest from Jarkal Mossmeld, too.\nThe caps are scattered throughout the instance."
Inst4Quest7_HORDE_Prequest = "Yes, Badlands Reagent Run"
Inst4Quest7_HORDE_Folgequest = "Yes, Badlands Reagent Run II"
Inst4Quest7PreQuest_HORDE = "true"
--
Inst4Quest7name1_HORDE = "Restorative Potion"

--QUEST 8 Horde

Inst4Quest8_HORDE = "8. Reclaimed Treasures"
Inst4Quest8_HORDE_Level = "43"
Inst4Quest8_HORDE_Attain = "?"
Inst4Quest8_HORDE_Aim = "Get Patrick Garrett's family treasure from their family chest in the South Common Hall of Uldaman, and bring it to him in the Undercity."
Inst4Quest8_HORDE_Location = "Patrick Garrett (Undercity; "..YELLOW.."72,48 "..WHITE..")"
Inst4Quest8_HORDE_Note = "You find the treasur before you enter the instance. It is at the end of the south tunnel."
Inst4Quest8_HORDE_Prequest = "No"
Inst4Quest8_HORDE_Folgequest = "No"


--QUEST 9 Horde

Inst4Quest9_HORDE = "9. The Platinum Discs"
Inst4Quest9_HORDE_Level = "45"
Inst4Quest9_HORDE_Attain = "40"
Inst4Quest9_HORDE_Aim = "Speak with stone watcher and learn what ancient lore it keeps. Once you have learned what lore it has to offer, activate the Discs of Norgannon. -> Take the miniature version of the Discs of Norgannon to the one of the sages in Thunder Bluff."
Inst4Quest9_HORDE_Location = "The Discs of Norgannon (Uldaman - [11])"
Inst4Quest9_HORDE_Note = "After you receive the quest, speak to the stone watcher to the left of the discs.  Then use the platinum discs again to recieve miniature discs, which you'll have to take to Sage Truthseeker in Thunder Bluff (34,46)."
Inst4Quest9_HORDE_Prequest = "No"
Inst4Quest9_HORDE_Folgequest = "No"
--
Inst4Quest9name1_HORDE = "Taupelzsack"
Inst4Quest9name2_HORDE = "Superior Healing Potion"
Inst4Quest9name3_HORDE = "Greater Mana Potion"

--QUEST 10 Horde

Inst4Quest10_HORDE = "10. Power in Uldaman (Mage)"
Inst4Quest10_HORDE_Level = "40"
Inst4Quest10_HORDE_Attain = "35"
Inst4Quest10_HORDE_Aim = "Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."
Inst4Quest10_HORDE_Location = "Tabetha (Dustwallow Marsh; "..YELLOW.."46,57 "..WHITE..")"
Inst4Quest10_HORDE_Note = "This quest is only available to Mages!\nThe Obsidian Power Source drops from the Obsidian Sentinel in area 5."
Inst4Quest10_HORDE_Prequest = "Yes, The Exorcism"
Inst4Quest10_HORDE_Folgequest = "Yes, Mana Surges"
Inst4Quest10PreQuest_HORDE = "true"


--------------------------Ragfire ( 5 Quests)
Inst3Story = "Ragefire Chasm consists of a network of volcanic caverns that lie below the orcs' new capital city of Orgrimmar. Recently, rumors have spread that a cult loyal to the demonic Shadow Council has taken up residence within the Chasm's fiery depths. This cult, known as the Burning Blade, threatens the very sovereignty of Durotar. Many believe that the orc Warchief, Thrall, is aware of the Blade's existence and has chosen not to destroy it in the hopes that its members might lead him straight to the Shadow Council. Either way, the dark powers emanating from Ragefire Chasm could undo all that the orcs have fought to attain."
Inst3Caption = "Ragefire Chasm"
Inst3QAA = "no Quests"
Inst3QAH = "5 Quests"

--QUEST 1 Horde

Inst3Quest1_HORDE = "1. Testing an Enemy's Strength"
Inst3Quest1_HORDE_Level = "15"
Inst3Quest1_HORDE_Attain = "?"
Inst3Quest1_HORDE_Aim = "Search Orgrimmar for Ragefire Chasm, then kill 8 Ragefire Troggs and 8 Ragefire Shaman before returning to Rahauro in Thunder Bluff."
Inst3Quest1_HORDE_Location = "Rahauro ( Thunder Bluff; "..YELLOW.."70,29 "..WHITE..")"
Inst3Quest1_HORDE_Note = "You find the troggs at the beginnig."
Inst3Quest1_HORDE_Prequest = "No"
Inst3Quest1_HORDE_Folgequest = "No"

--QUEST 2 Horde

Inst3Quest2_HORDE = "2. The Power to Destroy..."
Inst3Quest2_HORDE_Level = "16"
Inst3Quest2_HORDE_Attain = "?"
Inst3Quest2_HORDE_Aim = "Bring the books Spells of Shadow and Incantations from the Nether to Varimathras in Undercity."
Inst3Quest2_HORDE_Location = "Varimathras ( Undercity; "..YELLOW.."56,92 "..WHITE..")"
Inst3Quest2_HORDE_Note = "Searing Blade Cultists and Warlocks drop the books"
Inst3Quest2_HORDE_Prequest = "No"
Inst3Quest2_HORDE_Folgequest = "No"
--
Inst3Quest2name1_HORDE = "Ghastly Trousers"
Inst3Quest2name2_HORDE = "Dredgemire Leggings"
Inst3Quest2name3_HORDE = "Gargoyle Leggings"

--QUEST 3 Horde

Inst3Quest3_HORDE = "3. Searching for the Lost Satchel"
Inst3Quest3_HORDE_Level = "16"
Inst3Quest3_HORDE_Attain = "?"
Inst3Quest3_HORDE_Aim = "Search Ragefire Chasm for Maur Grimtotem's corpse and search it for any items of interest."
Inst3Quest3_HORDE_Location = "Rahauro ( Thunder Bluff; "..YELLOW.."70,29 "..WHITE..")"
Inst3Quest3_HORDE_Note = "You find Maur Grimmtotem at [1]. After getting the satchel you must bring it back to Rahauro in Thunder Bluff"
Inst3Quest3_HORDE_Prequest = "No"
Inst3Quest3_HORDE_Folgequest = "Yes, Returning the Lost Satchel"
--
Inst3Quest3name1_HORDE = "Featherbead Bracers"
Inst3Quest3name2_HORDE = "Savannah Bracers"

--QUEST 4 Horde

Inst3Quest4_HORDE = "4. Hidden Enemies"
Inst3Quest4_HORDE_Level = "16"
Inst3Quest4_HORDE_Attain = "?"
Inst3Quest4_HORDE_Aim = "Kill Bazzalan and Jergosh the Invoker before returning to Thrall in Orgrimmar."
Inst3Quest4_HORDE_Location = "Thrall ( Orgrimmar; "..YELLOW.."31,37 "..WHITE..")"
Inst3Quest4_HORDE_Note = "You findt Bazzalan at  [4] and Jergosh at [3]."
Inst3Quest4_HORDE_Prequest = "Yes, Hidden Enemies"
Inst3Quest4_HORDE_Folgequest = "Yes, Hidden Enemies"
Inst3Quest4PreQuest_HORDE = "true"
--
Inst3Quest4name1_HORDE = "Kris of Orgrimmar"
Inst3Quest4name2_HORDE = "Hammer of Orgrimmar"
Inst3Quest4name3_HORDE = "Axe of Orgrimmar"
Inst3Quest4name4_HORDE = "Staff of Orgrimmar"

--QUEST 5 Horde

Inst3Quest5_HORDE = "5. Slaying the Beast"
Inst3Quest5_HORDE_Level = "16"
Inst3Quest5_HORDE_Attain = "?"
Inst3Quest5_HORDE_Aim = "Enter Ragefire Chasm and slay Taragaman the Hungerer, then bring his heart back to Neeru Fireblade in Orgrimmar."
Inst3Quest5_HORDE_Location = "Neeru Fireblade ( Orgrimmar; "..YELLOW.."49,50 "..WHITE..")"
Inst3Quest5_HORDE_Note = "You find Taragaman at [2]."
Inst3Quest5_HORDE_Prequest = "No"
Inst3Quest5_HORDE_Folgequest = "No"

--------------------------Inst27 Zul'Farrak / ZUL
Inst27Story = "This sun-blasted city is home to the Sandfury trolls, known for their particular ruthlessness and dark mysticism. Troll legends tell of a powerful sword called Sul'thraze the Lasher, a weapon capable of instilling fear and weakness in even the most formidable of foes. Long ago, the weapon was split in half. However, rumors have circulated that the two halves may be found somewhere within Zul'Farrak's walls. Reports have also suggested that a band of mercenaries fleeing Gadgetzan wandered into the city and became trapped. Their fate remains unknown. But perhaps most disturbing of all are the hushed whispers of an ancient creature sleeping within a sacred pool at the city's heart - a mighty demigod who will wreak untold destruction upon any adventurer foolish enough to awaken him."
Inst27Caption = "Zul'Farrak"
Inst27QAA = "7 Quests"
Inst27QAH = "7 Quests"



--QUEST 1 Allianz

Inst27Quest1 = "1. Troll Temper"
Inst27Quest1_Level = "45"
Inst27Quest1_Attain = "?"
Inst27Quest1_Aim = "Bring 20 Vials of Troll Temper to Trenton Lighthammer in Gadgetzan."
Inst27Quest1_Location = "Trenton Lighthammer (Tanaris - Gadgetzan; "..YELLOW.."51,28 "..WHITE..")"
Inst27Quest1_Note = "Every Troll drops the Temper."
Inst27Quest1_Prequest = "No"
Inst27Quest1_Folgequest = "No"

--QUEST 2 Allianz

Inst27Quest2 = "2. Scarab Shells"
Inst27Quest2_Level = "45"
Inst27Quest2_Attain = "?"
Inst27Quest2_Aim = "Bring 5 Uncracked Scarab Shells to Tran'rek in Gadgetzan."
Inst27Quest2_Location = "Tran'rek (Tanaris - Gadgetzan; "..YELLOW.."51,26 "..WHITE..")"
Inst27Quest2_Note = "The prequest starts at Krazek (Stranglethorn Vale(Booty Bay); 25,77 ).\nEvery Scarab drops the Shells. A lot of Scarabs are at [2]."
Inst27Quest2_Prequest = "Yes, Tran'rek"
Inst27Quest2_Folgequest = "No"
Inst27Quest2PreQuest = "true"

--QUEST 3 Allianz

Inst27Quest3 = "3. Tiara of the Deep"
Inst27Quest3_Level = "46"
Inst27Quest3_Attain = "40"
Inst27Quest3_Aim = "Bring the Tiara of the Deep to Tabetha in Dustwallow Marsh."
Inst27Quest3_Location = "Tabetha (Die Marschen von Dustwallow; "..YELLOW.."46,57 "..WHITE..")"
Inst27Quest3_Note = "You get the prequest from Bink (Ironforge; 25,8).\nHydromancer Velratha drops the Tiara of the Deep. You find him at [6]."
Inst27Quest3_Prequest = "Yes, Tabetha's Task"
Inst27Quest3_Folgequest = "No"
Inst27Quest3PreQuest = "true"
--
Inst27Quest3name1 = "Spellshifter Rod"
Inst27Quest3name2 = "Gemshale Pauldrons"

--QUEST 4 Allianz

Inst27Quest4 = "4. Nekrum's Medallion (Questline)"
Inst27Quest4_Level = "47"
Inst27Quest4_Attain = "40"
Inst27Quest4_Aim = "Bring Nekrum's Medallion to Thadius Grimshade in the Blasted Lands."
Inst27Quest4_Location = "Thadius Grimshade (The Blasted Lands; "..YELLOW.."66,19 "..WHITE..")"
Inst27Quest4_Note = "The Questline starts at Gryphon Master Talonaxe (The Hinterlands; 9,44).\nYou can find Nekrum at [4]."
Inst27Quest4_Prequest = "Yes, Witherbark Cages -> Thadius Grimshade"
Inst27Quest4_Folgequest = "Yes, The Divination"
Inst27Quest4PreQuest = "true"

--QUEST 5 Allianz

Inst27Quest5 = "5. The Prophecy of Mosh'aru (Questline)"
Inst27Quest5_Level = "47"
Inst27Quest5_Attain = "40"
Inst27Quest5_Aim = "Bring the First and Second Mosh'aru Tablets to Yeh'kinya in Tanaris."
Inst27Quest5_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22 "..WHITE..")"
Inst27Quest5_Note = "You get the prequest from the same NPC.\nYou find the tables at [2] and [6]."
Inst27Quest5_Prequest = "Yes, Screecher Spirits"
Inst27Quest5_Folgequest = "Yes, The Ancient Egg"
Inst27Quest5PreQuest = "true"

--QUEST 6 Allianz

Inst27Quest6 = "6. Divino-matic Rod"
Inst27Quest6_Level = "46"
Inst27Quest6_Attain = "?"
Inst27Quest6_Aim = "Bring the Divino-matic Rod to Chief Engineer Bilgewhizzle in Gadgetzan."
Inst27Quest6_Location = "Bilgewhizzle (Tanaris - Gadgetzan; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest6_Note = "You get the Rod from Seargent Bly. You can find him at [4] after the Temple event."
Inst27Quest6_Prequest = "No"
Inst27Quest6_Folgequest = "No"
--
Inst27Quest6name1 = "Masons Fraternity Ring"
Inst27Quest6name2 = "Engineer's Guild Headpiece"


--QUEST 7 Allianz

Inst27Quest7 = "7. Gahz'rilla"
Inst27Quest7_Level = "50"
Inst27Quest7_Attain = "40"
Inst27Quest7_Aim = "Bring Gahz'rilla's Electrified Scale to Wizzle Brassbolts in the Shimmering Flats."
Inst27Quest7_Location = "Wizzle Brassbolts (Thousands Needles; "..YELLOW.."78,77 "..WHITE..")"
Inst27Quest7_Note = "You get the prequest from Klockmort Spannerspan(Ironforge; 68,46).\nYou can evocate Gahz'rilla at [6]."
Inst27Quest7_Prequest = "Yes, The Brassbolts Brothers"
Inst27Quest7_Folgequest = "No"
Inst27Quest7PreQuest = "true"
--
Inst27Quest7name1 = "Carrot on a Stick"

--QUEST 1 Horde

Inst27Quest1_HORDE = "1. The Spider God (Questline)"
Inst27Quest1_HORDE_Level = "45"
Inst27Quest1_HORDE_Attain = "42"
Inst27Quest1_HORDE_Aim = "Read from the Tablet of Theka to learn the name of the Witherbark spider god, then return to Master Gadrin."
Inst27Quest1_HORDE_Location = "Meister Gadrin ( Durotar; "..YELLOW.."55,74 "..WHITE..")"
Inst27Quest1_HORDE_Note = "The Questline starts at a Venom Bottle (The Hinterlands, troll village).\nYou find the Table at [2]."
Inst27Quest1_HORDE_Prequest = "Yes, Venom Bottles -> Consult Master Gadrin"
Inst27Quest1_HORDE_Folgequest = "Yes, Summoning Shadra"
Inst27Quest1PreQuest_HORDE = "true"

--QUEST 2 Horde

Inst27Quest2_HORDE = "2. Troll Temper"
Inst27Quest2_HORDE_Level = "45"
Inst27Quest2_HORDE_Attain = "?"
Inst27Quest2_HORDE_Aim = "Bring 20 Vials of Troll Temper to Trenton Lighthammer in Gadgetzan."
Inst27Quest2_HORDE_Location = "Trenton Lighthammer (Tanaris - Gadgetzan; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest2_HORDE_Note = "Every Troll drops ther Temper."
Inst27Quest2_HORDE_Prequest = "No"
Inst27Quest2_HORDE_Folgequest = "No"

--QUEST 3 Horde

Inst27Quest3_HORDE = "3. Scarab Shells"
Inst27Quest3_HORDE_Level = "45"
Inst27Quest3_HORDE_Attain = "?"
Inst27Quest3_HORDE_Aim = "Bring 5 Uncracked Scarab Shells to Tran'rek in Gadgetzan."
Inst27Quest3_HORDE_Location = "Tran'rek (Tanaris - Gadgetzan; "..YELLOW.."51,36 "..WHITE..")"
Inst27Quest3_HORDE_Note = "The prequest starts at Krazek (Stranglethorn Vale(Booty Bay); 25,77 ).\nEvery Scarab drops the Shells. A lot of Scarabs are at [2]."
Inst27Quest3_HORDE_Prequest = "Yes, Tran'rek"
Inst27Quest3_HORDE_Folgequest = "No"
Inst27Quest3PreQuest_HORDE = "true"

--QUEST 4 Horde

Inst27Quest4_HORDE = "4. Tiara of the Deep"
Inst27Quest4_HORDE_Level = "46"
Inst27Quest4_HORDE_Attain = "40"
Inst27Quest4_HORDE_Aim = "Bring the Tiara of the Deep to Tabetha in Dustwallow Marsh."
Inst27Quest4_HORDE_Location = "Tabetha (Die Marschen von Dustwallow; "..YELLOW.."46,57 "..WHITE..")"
Inst27Quest4_HORDE_Note = "You get the prequest from Deino (Orgrimmar; 38,85).\nVelratha drops the Tiara of the Deep. You can find her at [6]."
Inst27Quest4_HORDE_Prequest = "Yes, Tabetha's Task"
Inst27Quest4_HORDE_Folgequest = "No"
Inst27Quest4PreQuest_HORDE = "true"
--
Inst27Quest4name1_HORDE = "Spellshifter Rod"
Inst27Quest4name2_HORDE = "Gemshale Pauldrons"

--QUEST 5 Horde

Inst27Quest5_HORDE = "5. The Prophecy of Mosh'aru (Questline)"
Inst27Quest5_HORDE_Level = "47"
Inst27Quest5_HORDE_Attain = "40"
Inst27Quest5_HORDE_Aim = "Bring the First and Second Mosh'aru Tablets to Yeh'kinya in Tanaris."
Inst27Quest5_HORDE_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22 "..WHITE..")"
Inst27Quest5_HORDE_Note = "You get the prequest from the same NPC.\nYou find the tables at [2] and [6]."
Inst27Quest5_HORDE_Prequest = "Yes, Screecher Spirits"
Inst27Quest5_HORDE_Folgequest = "Yes, The Ancient Egg"
Inst27Quest5PreQuest_HORDE = "true"

--QUEST 6 Horde

Inst27Quest6_HORDE = "6. Divino-matic Rod"
Inst27Quest6_HORDE_Level = "46"
Inst27Quest6_HORDE_Attain = "?"
Inst27Quest6_HORDE_Aim = "Bring the Divino-matic Rod to Chief Engineer Bilgewhizzle in Gadgetzan."
Inst27Quest6_HORDE_Location = "Bilgewhizzle (Tanaris - Gadgetzan; "..YELLOW.."52,28 "..WHITE..")"
Inst27Quest6_HORDE_Note = "You get the Rod from Seargent Bly. You can find him at [4] after the Temple event."
Inst27Quest6_HORDE_Prequest = "No"
Inst27Quest6_HORDE_Folgequest = "No"
--
Inst27Quest6name1_HORDE = "Masons Fraternity Ring"
Inst27Quest6name2_HORDE = "Engineer's Guild Headpiece"

--QUEST 7 Horde

Inst27Quest7_HORDE = "7. Gahz'rilla"
Inst27Quest7_HORDE_Level = "50"
Inst27Quest7_HORDE_Attain = "40"
Inst27Quest7_HORDE_Aim = "Bring Gahz'rilla's Electrified Scale to Wizzle Brassbolts in the Shimmering Flats."
Inst27Quest7_HORDE_Location = "Wizzle Brassbolts (Thousands Needles; "..YELLOW.."78,77 "..WHITE..")"
Inst27Quest7_HORDE_Note = "You can evocate Gahz'rilla at [6]."
Inst27Quest7_HORDE_Prequest = "No"
Inst27Quest7_HORDE_Folgequest = "No"
--
Inst27Quest7name1_HORDE = "Carrot on a Stick"

--------------------------Stockade/verlies (6 quests)
Inst24Story = "The Stockades are a high-security prison complex, hidden beneath the canal district of Stormwind city. Presided over by Warden Thelwater, the Stockades are home to petty crooks, political insurgents, murderers and a score of the most dangerous criminals in the land. Recently, a prisoner-led revolt has resulted in a state of pandemonium within the Stockades - where the guards have been driven out and the convicts roam free. Warden Thelwater has managed to escape the holding area and is currently enlisting brave thrill-seekers to venture into the prison and kill the uprising's mastermind - the cunning felon, Bazil Thredd."
Inst24Caption = "The Stockades"
Inst24QAA = "6 Quests"
Inst24QAH = "no Quests"



--QUEST 1 Allianz

Inst24Quest1 = "1. What Comes Around..."
Inst24Quest1_Level = "25"
Inst24Quest1_Attain = "22"
Inst24Quest1_Aim = "Bring the head of Targorr the Dread to Guard Berton in Lakeshire."
Inst24Quest1_Location = "Guard Berton (Redridgemountains; "..YELLOW.."26,46 "..WHITE..")"
Inst24Quest1_Note = "You find Targorr at [1]."
Inst24Quest1_Prequest = "No"
Inst24Quest1_Folgequest = "No"
--
Inst24Quest1name1 = "Lucine Longsword"
Inst24Quest1name2 = "Hardened Root Staff"

--QUEST 2 Allianz

Inst24Quest2 = "2. Crime and Punishment"
Inst24Quest2_Level = "26"
Inst24Quest2_Attain = "22"
Inst24Quest2_Aim = "Councilman Millstipe of Darkshire wants you to bring him the hand of Dextren Ward."
Inst24Quest2_Location = "Millstipe (Duskwood - Darkshire; "..YELLOW.."72,47 "..WHITE..")"
Inst24Quest2_Note = "You find Dextren at [5]."
Inst24Quest2_Prequest = "No"
Inst24Quest2_Folgequest = "No"
--
Inst24Quest2name1 = "Ambassador's Boots"
Inst24Quest2name2 = "Darkshire Mail Leggings"


--QUEST 3 Allianz

Inst24Quest3 = "3. Quell The Uprising"
Inst24Quest3_Level = "26"
Inst24Quest3_Attain = "22"
Inst24Quest3_Aim = "Warden Thelwater of Stormwind wants you to kill 10 Defias Prisoners, 8 Defias Convicts, and 8 Defias Insurgents in The Stockade."
Inst24Quest3_Location = "Warden Thelwater (Stormwind; "..YELLOW.."41,58 "..WHITE..")"
Inst24Quest3_Note = ""
Inst24Quest3_Prequest = "No"
Inst24Quest3_Folgequest = "No"

--QUEST 4 Allianz

Inst24Quest4 = "4. The Color of Blood"
Inst24Quest4_Level = "26"
Inst24Quest4_Attain = "?"
Inst24Quest4_Aim = "Nikova Raskol of Stormwind wants you to collect 10 Red Wool Bandanas."
Inst24Quest4_Location = "Nikova Raskol (Stormwind; "..YELLOW.."73,46 "..WHITE..")"
Inst24Quest4_Note = "Every Ennemy in the Instance drops the Bandanas."
Inst24Quest4_Prequest = "No"
Inst24Quest4_Folgequest = "No"

--QUEST 5 Allianz

Inst24Quest5 = "5. The Fury Runs Deep"
Inst24Quest5_Level = "27"
Inst24Quest5_Attain = "25"
Inst24Quest5_Aim = "Motley Garmason wants Kam Deepfury's head brought to him at Dun Modr."
Inst24Quest5_Location = "Motley Garmason (Wetlands; "..YELLOW.."49,18 "..WHITE..")"
Inst24Quest5_Note = "You get the prequest from Motley, too.\nYou find Kam Deepfury at [2]."
Inst24Quest5_Prequest = "Yes, The Dark Iron War"
Inst24Quest5_Folgequest = "No"
Inst24Quest5PreQuest = "true"
--
Inst24Quest5name1 = "Belt of Vindication"
Inst24Quest5name2 = "Headbasher"


--QUEST 6 Allianz

Inst24Quest6 = "6. The Stockade Riots (Questline)"
Inst24Quest6_Level = "29"
Inst24Quest6_Attain = "16"
Inst24Quest6_Aim = "Kill Bazil Thredd and bring his head back to Warden Thelwater at the Stockade."
Inst24Quest6_Location = "Warden Thelwater (Stormwind; "..YELLOW.."41,58 "..WHITE..")"
Inst24Quest6_Note = "For more details about the prequest see [Deadmines, The Defias Brotherhood].\n You find Bazil Thredd at [4]."
Inst24Quest6_Prequest = "Yes, The Defias Brotherhood -> Bazil Thredd"
Inst24Quest6_Folgequest = "Yes, The Curious Visitor"
Inst24Quest6PreQuest = "true"



--------------Razorfen Downs/Inst17 ( 4 quests)------------
Inst17Story = "Crafted  from the same mighty vines as Razorfen Kraul, Razorfen Downs is the traditional capital city of the quillboar race. The sprawling, thorn-ridden labyrinth houses a veritable army of loyal quillboar as well as their high priests - the Death's Head tribe. Recently, however, a looming shadow has fallen over the crude den. Agents of the undead Scourge - led by the lich, Amnennar the Coldbringer - have taken control over the quillboar race and turned the maze of thorns into a bastion of undead might. Now the quillboar fight a desperate battle to reclaim their beloved city before Amnennar spreads his control across the Barrens."
Inst17Caption = "Razorfen Downs"
Inst17QAA = "3 Quests"
Inst17QAH = "4 Quests"

--QUEST 1 Allianz

Inst17Quest1 = "1. A Host of Evil"
Inst17Quest1_Level = "35"
Inst17Quest1_Attain = "30"
Inst17Quest1_Aim = "Kill 8 Razorfen Battleguard, 8 Razorfen Thornweavers, and 8 Death's Head Cultists and return to Myriam Moonsinger near the entrance to Razorfen Downs."
Inst17Quest1_Location = "Myriam Moonsinger (The Barrens; "..YELLOW.."49,94 "..WHITE..")"
Inst17Quest1_Note = "You finde the mobs outside before you enter the instance."
Inst17Quest1_Prequest = "No"
Inst17Quest1_Folgequest = "No"

--QUEST 2 Allianz

Inst17Quest2 = "2. Extinguishing the Idol"
Inst17Quest2_Level = "37"
Inst17Quest2_Attain = "34"
Inst17Quest2_Aim = "Escort Belnistrasz to the Quilboar's idol in Razorfen Downs. Protect Belnistrasz while he performs the ritual to shut down the idol."
Inst17Quest2_Location = "Belnistrasz (Razorfen Downs; "..YELLOW.."[2] "..WHITE..")"
Inst17Quest2_Note = "You find Belnistrasz at [2]."
Inst17Quest2_Prequest = "Yes, (At Belnistrasz)"
Inst17Quest2_Folgequest = "No"
Inst17Quest2PreQuest = "true"
--
Inst17Quest2name1 = "Dragonclaw Ring"

--QUEST 3 Allianz

Inst17Quest3 = "3. Bring the Light"
Inst17Quest3_Attain = "39"
Inst17Quest3_Level = "42"
Inst17Quest3_Aim = "Archbishop Bendictus wants you to slay Amnennar the Coldbringer in Razorfen Downs."
Inst17Quest3_Location = "Archbishop Bendictus (Stormwind; "..YELLOW.."39,27 "..WHITE..")"
Inst17Quest3_Note = "Amnennar the Coldbringer is the last Boss at Razorfen Downs. You can find him at [6]."
Inst17Quest3_Prequest = "No"
Inst17Quest3_Folgequest = "No"
--
Inst17Quest3name1 = "Vanquisher's Sword"
Inst17Quest3name2 = "Amberglow Talisman"

--QUEST 1 Horde

Inst17Quest1_HORDE = "1. A Host of Evil"
Inst17Quest1_HORDE_Level = "35"
Inst17Quest1_HORDE_Attain = "30"
Inst17Quest1_HORDE_Aim = "Kill 8 Razorfen Battleguard, 8 Razorfen Thornweavers, and 8 Death's Head Cultists and return to Myriam Moonsinger near the entrance to Razorfen Downs."
Inst17Quest1_HORDE_Location = "Myriam Moonsinger (The Barrens; "..YELLOW.."49,94 "..WHITE..")"
Inst17Quest1_HORDE_Note = "You finde the mobs outside before you enter the instance."
Inst17Quest1_HORDE_Prequest = "No"
Inst17Quest1_HORDE_Folgequest = "No"

--Quest 2 Horde

Inst17Quest2_HORDE = "2. An Unholy Alliance"
Inst17Quest2_HORDE_Level = "36"
Inst17Quest2_HORDE_Attain = "?"
Inst17Quest2_HORDE_Aim = "Bring Ambassador Malcin's Head to Varimathras in the Undercity."
Inst17Quest2_HORDE_Location = "Varimathras  (Undercity; "..YELLOW.."56,92 "..WHITE..")"
Inst17Quest2_HORDE_Note = "You get the prequest from the last Boss in Razorfen Kraul.\n You find Malcin outside(The Barrens, 48,92)."
Inst17Quest2_HORDE_Prequest = "Yes, An Unholy Alliance"
Inst17Quest2_HORDE_Folgequest = "No"
Inst17Quest2PreQuest_HORDE = "true"
--
Inst17Quest2name1_HORDE = "Skullbreaker"
Inst17Quest2name2_HORDE = "Nail Spitter"
Inst17Quest2name3_HORDE = "Zealot's Robe"

-- Quest 3 Horde

Inst17Quest3_HORDE = "3. Extinguishing the Idol"
Inst17Quest3_HORDE_Level = "37"
Inst17Quest3_HORDE_Attain = "34"
Inst17Quest3_HORDE_Aim = "Escort Belnistrasz to the Quilboar's idol in Razorfen Downs. Protect Belnistrasz while he performs the ritual to shut down the idol."
Inst17Quest3_HORDE_Location = "Razorfen Downs; "..YELLOW.."[2] "..WHITE..")"
Inst17Quest3_HORDE_Note = "You find Belnistrasz at [2]."
Inst17Quest3_HORDE_Prequest = "Yes, (At Belnistrasz)"
Inst17Quest3_HORDE_Folgequest = "No"
Inst17Quest3PreQuest_HORDE = "true"
--
Inst17Quest3name1_HORDE = "Dragonclaw Ring"

--QUEST 4 Horde

Inst17Quest4_HORDE = "4. Bring the End"
Inst17Quest4_HORDE_Attain = "37"
Inst17Quest4_HORDE_Level = "42"
Inst17Quest4_HORDE_Aim = "Andrew Brownell wants you to kill Amnennar the Coldbringer and return his skull."
Inst17Quest4_HORDE_Location = "Andrew Brownell (Untercity; "..YELLOW.."72,32 "..WHITE..")"
Inst17Quest4_HORDE_Note = "Amnennar the Coldbringer is the last Boss at Razorfen Downs. You can find him at [6]."
Inst17Quest4_HORDE_Prequest = "No"
Inst17Quest4_HORDE_Folgequest = "No"
--
Inst17Quest4name1_HORDE = "Vanquisher's Sword"
Inst17Quest4name2_HORDE = "Amberglow Talisman"

--------------Kloster/SM ( 6 quests)------------
Inst19Story = "The Monastery was once a proud bastion of Lordaeron's priesthood - a center for learning and enlightenment. With the rise of the undead Scourge during the Third War, the peaceful Monastery was converted into a stronghold of the fanatical Scarlet Crusade. The Crusaders are intolerant of all non-human races, regardless of alliance or affiliation. They believe that any and all outsiders are potential carriers of the undead plague - and must be destroyed. Reports indicate that adventurers who enter the monastery are forced to contend with Scarlet Commander Mograine - who commands a large garrison of fanatically devoted warriors. However, the monastery's true master is High Inquisitor Whitemane - a fearsome priestess who possesses the ability to resurrect fallen warriors to do battle in her name."
Inst19Caption = "The Scarlet Monastery"
Inst19QAA = "3 Quests"
Inst19QAH = "6 Quests"

--QUEST 1 Allianz

Inst19Quest1 = "1. Mythology of the Titans"
Inst19Quest1_Level = "38"
Inst19Quest1_Attain = "?"
Inst19Quest1_Aim = "Retrieve Mythology of the Titans from the Monastery and bring it to Librarian Mae Paledust in Ironforge."
Inst19Quest1_Location = "Mae Paledust (Ironforge; "..YELLOW.."74,12 "..WHITE..")"
Inst19Quest1_Note = "You find the book in the Libary of Scarlet Monastery."
Inst19Quest1_Prequest = "No"
Inst19Quest1_Folgequest = "No"
--
Inst19Quest1name1 = "Explorers' League Commendation"

--QUEST 2 Allianz

Inst19Quest2 = "2. In the Name of the Light"
Inst19Quest2_Level = "40"
Inst19Quest2_Attain = "39"
Inst19Quest2_Aim = "Kill High Inquisitor Whitemane, Scarlet Commander Mograine, Herod, the Scarlet Champion and Houndmaster Loksey and then report back to Raleigh the Devout in Southshore."
Inst19Quest2_Location = "Raleigh the Devout (Hillsbrad Foothills, Southshore; "..YELLOW.."51,58 "..WHITE..")"
Inst19Quest2_Note = "The Questline starts at Brother Crowley (42,24 in Stormwind).\nYou find High Inquisitor Whitemane and Kommandant Mograinebei at [5], the Herod at [3] and Houndmaster Loksey at [1]."
Inst19Quest2_Prequest = "Yes, Brother Anton -> Down the Scarlet Path"
Inst19Quest2_Folgequest = "No"
Inst19Quest2PreQuest = "true"
--
Inst19Quest2name1 = "Sword of Serenity"
Inst19Quest2name2 = "Bonebiter"
Inst19Quest2name3 = "Black Menace"
Inst19Quest2name4 = "Orb of Lorica"


--QUEST 3 Allianz MAGIER

Inst19Quest3 = "3. Rituals of Power (Mage)"
Inst19Quest3_Level = "40"
Inst19Quest3_Attain = "31"
Inst19Quest3_Aim = "Bring the book Rituals of Power to Tabetha in Dustwallow Marsh."
Inst19Quest3_Location = "Tabetha (Dustwallow Marsh; "..YELLOW.."43,57 "..WHITE..")"
Inst19Quest3_Note = "Only Mages can get this Quest!\nYou find the book in the Libary of Scarlet Monastery."
Inst19Quest3_Prequest = "Yes, Get the Scoop"
Inst19Quest3_Folgequest = "Yes, Mage's Wand"
Inst19Quest3PreQuest = "true"

--QUEST 1 Horde

Inst19Quest1_HORDE = "1. Vorrel's Revenge"
Inst19Quest1_HORDE_Level = "33"
Inst19Quest1_HORDE_Attain = "?"
Inst19Quest1_HORDE_Aim = "Return Vorrel Sengutz's wedding ring to Monika Sengutz in Tarren Mill."
Inst19Quest1_HORDE_Location = "Vorrel Sengutz (Scarlet Monastery, Graveyard)"
Inst19Quest1_HORDE_Note = "You find Vorrel Sengutz at the beginning of Scarlet Monastery Graveyard part. Nancy is in a hous in the Alterac Mountains(31,32). She has the Ring."
Inst19Quest1_HORDE_Prequest = "No"
Inst19Quest1_HORDE_Folgequest = "No"
--
Inst19Quest1name1_HORDE = "Vorrel's Boots"
Inst19Quest1name2_HORDE = "Mantle of Woe"
Inst19Quest1name3_HORDE = "Grimsteel Cape"

--Quest 2 Horde

Inst19Quest2_HORDE = "2. Hearts of Zeal"
Inst19Quest2_HORDE_Level = "33"
Inst19Quest2_HORDE_Attain = "?"
Inst19Quest2_HORDE_Aim = "Master Apothecary Faranell in the Undercity wants 20 Hearts of Zeal."
Inst19Quest2_HORDE_Location = "Master Apothecary Faranell  (Undercity; "..YELLOW.."48,69 "..WHITE..")"
Inst19Quest2_HORDE_Note = "For more details about the prequest see [Razorfen Kraul]\nYou get the hearts from every mob in Scarlet Monastery."
Inst19Quest2_HORDE_Prequest = "Yes, Going, Going, Guano!"
Inst19Quest2_HORDE_Folgequest = "No"
Inst19Quest2PreQuest_HORDE = "true"


-- Quest 3 Horde

Inst19Quest3_HORDE = "3. Test of Lore (Questline)"
Inst19Quest3_HORDE_Level = "36"
Inst19Quest3_HORDE_Attain = "32"
Inst19Quest3_HORDE_Aim = "Find The Beginnings of the Undead Threat, and return it to Parqual Fintallas in Undercity."
Inst19Quest3_HORDE_Location = "Parqual Fintallas (Undercity; "..YELLOW.."57,65 "..WHITE..")"
Inst19Quest3_HORDE_Note = "Questline starts at Dorn Plainstalker (Thousand Needles (53,41).\n You find the book in the Libary of SM."
Inst19Quest3_HORDE_Prequest = "Yes, Test of Faith - > Test of Lore"
Inst19Quest3_HORDE_Folgequest = "Yes, Test of Lore"
Inst19Quest3PreQuest_HORDE = "true"

--QUEST 4 Horde

Inst19Quest4_HORDE = "4. Compendium of the Fallen"
Inst19Quest4_HORDE_Level = "38"
Inst19Quest4_HORDE_Attain = "?"
Inst19Quest4_HORDE_Aim = "Retrieve the Compendium of the Fallen from the Monastery in Tirisfal Glades and return to Sage Truthseeker in Thunder Bluff."
Inst19Quest4_HORDE_Location = "Sage Truthseeker (Thunderbluff; "..YELLOW.."34,47 "..WHITE..")"
Inst19Quest4_HORDE_Note = "You find the book in the Libary of Scarlet Monastery."
Inst19Quest4_HORDE_Prequest = "No"
Inst19Quest4_HORDE_Folgequest = "No"
--
Inst19Quest4name1_HORDE = "Vile Protector"
Inst19Quest4name2_HORDE = "Forcestone Buckler"
Inst19Quest4name3_HORDE = "Omega Orb"

--QUEST 5 Horde

Inst19Quest5_HORDE = "5. Into The Scarlet Monastery"
Inst19Quest5_HORDE_Level = "42"
Inst19Quest5_HORDE_Attain = "33"
Inst19Quest5_HORDE_Aim = "Kill High Inquisitor Whitemane, Scarlet Commander Mograine, Herod, the Scarlet Champion and Houndmaster Loksey and then report back to Varimathras in the Undercity."
Inst19Quest5_HORDE_Location = "Varimathras  (Undercity; "..YELLOW.."56,92 "..WHITE..")"
Inst19Quest5_HORDE_Note = "You find High Inquisitor Whitemane and Kommandant Mograinebei at [5], the Herod at [3] and Houndmaster Loksey at [1]."
Inst19Quest5_HORDE_Prequest = "No"
Inst19Quest5_HORDE_Folgequest = "No"
--
Inst19Quest5name1_HORDE = "Sword of Omen"
Inst19Quest5name2_HORDE = "Prophetic Cane"
Inst19Quest5name3_HORDE = "Dragon's Blood Necklace"

--QUEST 6 Horde

Inst19Quest6_HORDE = "6. Rituals of Power (Mage)"
Inst19Quest6_HORDE_Level = "40"
Inst19Quest6_HORDE_Attain = "31"
Inst19Quest6_HORDE_Aim = "Bring the book Rituals of Power to Tabetha in Dustwallow Marsh."
Inst19Quest6_HORDE_Location = "Tabetha (Dustwallow Marsh; "..YELLOW.."46,57 "..WHITE..")"
Inst19Quest6_HORDE_Note = "Only Mages can get this Quest!\nYou find the book in the Libary of Scarlet Monastery."
Inst19Quest6_HORDE_Prequest = "Yes, Get the Scoop"
Inst19Quest6_HORDE_Folgequest = "Yes, Mage's Wand"
Inst19Quest6PreQuest_HORDE = "true"

--------------Kral ( 5 quests)------------
Inst18Story = "Ten thousand years ago - during the War of the Ancients, the mighty demigod, Agamaggan, came forth to battle the Burning Legion. Though the colossal boar fell in combat, his actions helped save Azeroth from ruin. Yet over time, in the areas where his blood fell, massive thorn-ridden vines sprouted from the earth. The quillboar - believed to be the mortal offspring of the mighty god, came to occupy these regions and hold them sacred. The heart of these thorn-colonies was known as the Razorfen. The great mass of Razorfen Kraul was conquered by the old crone, Charlga Razorflank. Under her rule, the shamanistic quillboar stage attacks on rival tribes as well as Horde villages. Some speculate that Charlga has even been negotiating with agents of the Scourge - aligning her unsuspecting tribe with the ranks of the Undead for some insidious purpose."
Inst18Caption = "Razorfen Kraul"
Inst18QAA = "5 Quests"
Inst18QAH = "5 Quests"

--QUEST 1 Allianz

Inst18Quest1 = "1. Blueleaf Tubers"
Inst18Quest1_Level = "26"
Inst18Quest1_Attain = "20"
Inst18Quest1_Aim = "In Razorfen Kraul, use the Crate with Holes to summon a Snufflenose Gopher, and use the Command Stick on the gopher to make it search for Tubers. Bring 6 Blueleaf Tubers, the Snufflenose Command Stick and the Crate with Holes to Mebok Mizzyrix in Ratchet."
Inst18Quest1_Location = "Mebok Mizzyrix (The Barrens - Ratchet; "..YELLOW.."62,37"..WHITE..")"
Inst18Quest1_Note = "The Crate, the Stick and the Manual are near Mebok Mizzyrix."
Inst18Quest1_Prequest = "No"
Inst18Quest1_Folgequest = "No"
--
Inst18Quest1name1 = "A Small Container of Gems"

--QUEST 2 Allianz

Inst18Quest2 = "2. Mortality Wanes"
Inst18Quest2_Level = "30"
Inst18Quest2_Attain = "?"
Inst18Quest2_Aim = "Find and return Treshala's Pendant to Treshala Fallowbrook in Darnassus."
Inst18Quest2_Location = "Heraltha Fallowbrook (Razorfen Kraul; "..YELLOW.." [8]"..WHITE..")"
Inst18Quest2_Note = "The pendant is a random drop. You musst bring back the pendant to Treshala Fallowbrook in Darnassus (69,67)."
Inst18Quest2_Prequest = "No"
Inst18Quest2_Folgequest = "No"
--
Inst18Quest2name1 = "Mourning Shawl"
Inst18Quest2name2 = "Lancer Boots"

--QUEST 3 Allianz

Inst18Quest3 = "3. Willix the Importer"
Inst18Quest3_Level = "30"
Inst18Quest3_Attain = "?"
Inst18Quest3_Aim = "Escort Willix the Importer out of Razorfen Kraul."
Inst18Quest3_Location = "Willix the Importer (Razorfen Kraul; "..YELLOW.." [8]"..WHITE..")"
Inst18Quest3_Note = "Willix is at [8]. You musst bring him to the entrance."
Inst18Quest3_Prequest = "No"
Inst18Quest3_Folgequest = "No"
--
Inst18Quest3name1 = "Monkey Ring"
Inst18Quest3name2 = "Snake Hoop"
Inst18Quest3name3 = "Tiger Band"

--QUEST 4 Allianz

Inst18Quest4 = "4. The Crone of the Kraul"
Inst18Quest4_Level = "34"
Inst18Quest4_Attain = "30"
Inst18Quest4_Aim = "Bring Razorflank's Medallion to Falfindel Waywarder in Thalanaar."
Inst18Quest4_Location = "Falfindel Waywarder (Feralas; "..YELLOW.."89,46"..WHITE..")"
Inst18Quest4_Note = "Charlga Razorflank [7] drop the Medallion ."
Inst18Quest4_Prequest = "Yes, Lonebrow's Journal"
Inst18Quest4_Folgequest = "Yes, The Crone of the Kraul"
Inst18Quest4PreQuest = "true"
--
Inst18Quest4name1 = "'Mage-Eye' Blunderbuss"
Inst18Quest4name2 = "Berylline Pads"
Inst18Quest4name3 = "Stonefist Girdle"
Inst18Quest4name4 = "Marbled Buckler"

--QUEST 5 Allianz KRIEGER

Inst18Quest5 = "5. Fire Hardened Mail (Warrior)"
Inst18Quest5_Level = "28"
Inst18Quest5_Attain = "20"
Inst18Quest5_Aim = "Gather the materials Furen Longbeard requires, and bring them to him in Stormwind."
Inst18Quest5_Location = "Furen Longbeard (Stormwind; "..YELLOW.."57,16"..WHITE..")"
Inst18Quest5_Note = "Only Warriors can get this Quest!\nYou get the Vial of Phlogiston at [1]."
Inst18Quest5_Prequest = "Yes, The Shieldsmith"
Inst18Quest5_Folgequest = "Yes"
Inst18Quest5PreQuest = "true"


--QUEST 1 Horde

Inst18Quest1_HORDE = "1. Blueleaf Tubers"
Inst18Quest1_HORDE_Level = "26"
Inst18Quest1_HORDE_Attain = "20"
Inst18Quest1_HORDE_Aim = "In Razorfen Kraul, use the Crate with Holes to summon a Snufflenose Gopher, and use the Command Stick on the gopher to make it search for Tubers. Bring 6 Blueleaf Tubers, the Snufflenose Command Stick and the Crate with Holes to Mebok Mizzyrix in Ratchet."
Inst18Quest1_HORDE_Location = "Mebok Mizzyrix (The Barrens - Ratchet; "..YELLOW.."62,37"..WHITE..")"
Inst18Quest1_HORDE_Note = "The Crate, the Stick and the Manual are near Mebok Mizzyrix."
Inst18Quest1_HORDE_Prequest = "No"
Inst18Quest1_HORDE_Folgequest = "No"
--
Inst18Quest1name1_HORDE = "A Small Container of Gems"

--Quest 2 Horde

Inst18Quest2_HORDE = "2. Willix the Importer"
Inst18Quest2_HORDE_Level = "30"
Inst18Quest2_HORDE_Attain = "?"
Inst18Quest2_HORDE_Aim = "Escort Willix the Importer out of Razorfen Kraul."
Inst18Quest2_HORDE_Location = "Willix the Importer (Razorfen Kraul; "..YELLOW.." [8]"..WHITE..")"
Inst18Quest2_HORDE_Note = "Willix is at [8]. You musst bring him to the entrance."
Inst18Quest2_HORDE_Prequest = "No"
Inst18Quest2_HORDE_Folgequest = "No"
--
Inst18Quest2name1_HORDE = "Monkey Ring"
Inst18Quest2name2_HORDE = "Snake Hoop"
Inst18Quest2name3_HORDE = "Tiger Band"

-- Quest 3 Horde

Inst18Quest3_HORDE = "3. Going, Going, Guano!"
Inst18Quest3_HORDE_Level = "33"
Inst18Quest3_HORDE_Attain = "?"
Inst18Quest3_HORDE_Aim = "Bring 1 pile of Kraul Guano to Master Apothecary Faranell in the Undercity."
Inst18Quest3_HORDE_Location = "Faranell (Undercity; "..YELLOW.."48,69 "..WHITE..")"
Inst18Quest3_HORDE_Note = "Every Bat drop the Kraul Guano."
Inst18Quest3_HORDE_Prequest = "No"
Inst18Quest3_HORDE_Folgequest = "Yes, Hearts of Zeal (Look [Razorfen Downs])"

--QUEST 4 Horde

Inst18Quest4_HORDE = "4. A Vengeful Fate"
Inst18Quest4_HORDE_Level = "34"
Inst18Quest4_HORDE_Attain = "29"
Inst18Quest4_HORDE_Aim = "Bring Razorflank's Heart to Auld Stonespire in Thunder Bluff."
Inst18Quest4_HORDE_Location = "Auld Stonespire (Thunderbluff; "..YELLOW.."36,59 "..WHITE..")"
Inst18Quest4_HORDE_Note = "You find Charlga Razorflank at [7]"
Inst18Quest4_HORDE_Prequest = "No"
Inst18Quest4_HORDE_Folgequest = "No"
--
Inst18Quest4name1_HORDE = "Berylline Pads"
Inst18Quest4name2_HORDE = "Stonefist Girdle"
Inst18Quest4name3_HORDE = "Marbled Buckler"

--QUEST 5 Horde

Inst18Quest5_HORDE = "5. Brutal Armor (Warrior)"
Inst18Quest5_HORDE_Level = "30"
Inst18Quest5_HORDE_Attain = "20"
Inst18Quest5_HORDE_Aim = "Bring to Thun'grim Firegaze 15 Smoky Iron Ingots, 10 Powdered Azurite, 10 Iron Bars and a Vial of Phlogiston."
Inst18Quest5_HORDE_Location = "Thun'grim Firegaze (The Barrens; "..YELLOW.."57,30 "..WHITE..")"
Inst18Quest5_HORDE_Note = "Only Warrior can get this Quest!\nYou get the Vial of Phlogiston at [1]."
Inst18Quest5_HORDE_Prequest = "Yes, Speak with Thun'grim"
Inst18Quest5_HORDE_Folgequest = "Yes"
Inst18Quest5PreQuest_HORDE = "true"

--------------Scholo ( 9 quests)------------
Inst20Story = "The Scholomance is housed within a series of crypts that lie beneath the ruined keep of Caer Darrow. Once owned by the noble Barov family, Caer Darrow fell to ruin following the Second War. As the wizard Kel'thuzad enlisted followers for his Cult of the Damned he would often promise immortality in exchange for serving his Lich King. The Barov family fell to Kel'thuzad's charismatic influence and donated the keep and its crypts to the Scourge. The cultists then killed the Barovs and turned the ancient crypts into a school for necromancy known as the Scholomance. Though Kel'thuzad no longer resides in the crypts, devoted cultists and instructors still remain. The powerful lich, Ras Frostwhisper, rules over the site and guards it in the Scourge's name - while the mortal necromancer, Darkmaster Gandling, serves as the school's insidious headmaster."
Inst20Caption = "Scholomance"
Inst20QAA = "9 Quests"
Inst20QAH = "9 Quests"

--QUEST 1 Allianz

Inst20Quest1 = "1. Plagued Hatchlings"
Inst20Quest1_Attain = "55"
Inst20Quest1_Level = "58"
Inst20Quest1_Aim = "Kill 20 Plagued Hatchlings, then return to Betina Bigglezink at the Light's Hope Chapel."
Inst20Quest1_Location = "Betina Bigglezink (Eastern Plaguelands - Light's Hope Chapel; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest1_Note = ""
Inst20Quest1_Prequest = "No"
Inst20Quest1_Folgequest = "Yes, Healthy Dragon Scale"

--QUEST 2 Allianz

Inst20Quest2 = "2. Healthy Dragon Scale"
Inst20Quest2_Attain = ""
Inst20Quest2_Level = "58"
Inst20Quest2_Aim = "Bring the Healthy Dragon Scale to Betina Bigglezink at the Light's Hope Chapel in Eastern Plaguelands."
Inst20Quest2_Location = "Healthy Dragon Scale (Drop) (Scholomance)"
Inst20Quest2_Note = "Plagued Hatchlings drop the Healthy Dragon Scale (8% Dropchance). You find Betina Bigglezink at 81,59."
Inst20Quest2_Prequest = "Yes, Plagued Hatchlings "
Inst20Quest2_Folgequest = "No"
Inst20Quest2FQuest = "true"

--QUEST 3 Allianz

Inst20Quest3 = "3. Doctor Theolen Krastinov, the Butcher"
Inst20Quest3_Attain = "55"
Inst20Quest3_Level = "60"
Inst20Quest3_Aim = "Find Doctor Theolen Krastinov inside the Scholomance. Destroy him, then burn the Remains of Eva Sarkhoff and the Remains of Lucien Sarkhoff. Return to Eva Sarkhoff when the task is complete."
Inst20Quest3_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest3_Note = "You find Doctor Theolen Krastinov at [9]."
Inst20Quest3_Prequest = "No"
Inst20Quest3_Folgequest = "Yes, Krastinov's Bag of Horrors"

--QUEST 4 Allianz

Inst20Quest4 = "4. Krastinov's Bag of Horrors"
Inst20Quest4_Attain = "55"
Inst20Quest4_Level = "60"
Inst20Quest4_Aim = "Locate Yesndice Barov in the Scholomance and destroy her. From her corpse recover Krastinov's Bag of Horrors. Return the bag to Eva Sarkhoff."
Inst20Quest4_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest4_Note = "You find Yesndice Barov at [3]."
Inst20Quest4_Prequest = "Yes, Doctor Theolen Krastinov, the Butcher"
Inst20Quest4_Folgequest = "Yes, Kirtonos the Herald"
Inst20Quest4FQuest = "true"

--QUEST 5 Allianz

Inst20Quest5 = "5. Kirtonos the Herald"
Inst20Quest5_Attain = "56"
Inst20Quest5_Level = "60"
Inst20Quest5_Aim = "Return to the Scholomance with the Blood of Innocents. Find the porch and place the Blood of Innocents in the brazier. Kirtonos will come to feast upon your soul. Fight valiantly, do not give an inch! Destroy Kirtonos and return to Eva Sarkhoff."
Inst20Quest5_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest5_Note = "The porch is at [2]."
Inst20Quest5_Prequest = "Yes, Krastinov's Bag of Horrors"
Inst20Quest5_Folgequest = "Yes, The Human, Ras Frostwhisper"
Inst20Quest5FQuest = "true"
--
Inst20Quest5name1 = "Spectral Essence"
Inst20Quest5name2 = "Penelope's Rose"
Inst20Quest5name3 = "Mirah's Song"

--QUEST 6 Allianz

Inst20Quest6 = "6. The Lich, Ras Frostwhisper"
Inst20Quest6_Attain = "60"
Inst20Quest6_Level = "60"
Inst20Quest6_Aim = "Find Ras Frostwhisper in the Scholomance. When you have found him, use the Soulbound Keepsake on his undead visage. Should you succeed in reverting him to a mortal, strike him down and recover the Human Head of Ras Frostwhisper. Take the head back to Magistrate Marduke."
Inst20Quest6_Location = "Magistrate Marduke (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest6_Note = "You find Ras Frostwhisper at [7]."
Inst20Quest6_Prequest = "Yes, The Human, Ras Frostwhisper - > Soulbound Keepsake"
Inst20Quest6_Folgequest = "No"
Inst20Quest6PreQuest = "true"
--
Inst20Quest6name1 = "Darrowshire Strongguard"
Inst20Quest6name2 = "Warblade of Caer Darrow"
Inst20Quest6name3 = "Crown of Caer Darrow"
Inst20Quest6name4 = "Darrowspike"

--QUEST 7 Allianz

Inst20Quest7 = "7. Barov Family Fortune"
Inst20Quest7_Attain = "60"
Inst20Quest7_Level = "60"
Inst20Quest7_Aim = "Venture to the Scholomance and recover the Barov family fortune. Four deeds make up this fortune: The Deed to Caer Darrow; The Deed to Brill; The Deed to Tarren Mill; and The Deed to Southshore. Return to Weldon Barov when you have completed this task."
Inst20Quest7_Location = "Weldon Barov (Western Plaguelands; "..YELLOW.."43,83"..WHITE..")"
Inst20Quest7_Note = "You find The Deed to Caer Darrow at [12], The Deed to Brill at [7], The Deed to Tarren Mill at [4] and The Deed to Southshore at [1]."
Inst20Quest7_Prequest = "No"
Inst20Quest7_Folgequest = "Yes, The Last Barov"

--QUEST 8 Allianz

Inst20Quest8 = "8. Dawn's Gambit"
Inst20Quest8_Attain = "59"
Inst20Quest8_Level = "60"
Inst20Quest8_Aim = "Place Dawn's Gambit in the Viewing Room of the Scholomance. Defeat Vectus, then return to Betina Bigglezink."
Inst20Quest8_Location = "Betina Bigglezink (Eastern Plaguelands - Light's Hope Chapel; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest8_Note = "Broodling Essence begins at Tinkee Steamboil (Burning Steppes, 65,23). The Viewing Room is at [6]."
Inst20Quest8_Prequest = "Yes, Broodling Essence - > Betina Bigglezink"
Inst20Quest8_Folgequest = "No"
Inst20Quest8PreQuest = "true"
--
Inst20Quest8name1 = "Windreaper"
Inst20Quest8name2 = "Dancing Sliver"

--QUEST 9 Allaince

Inst20Quest9 = "9. Imp Delivery (Warlock)"
Inst20Quest9_Attain = "60"
Inst20Quest9_Level = "60"
Inst20Quest9_Aim = "Bring the Imp in a Yesr to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."
Inst20Quest9_Location = "Gorzeeki Wildeyes (Burning Steppes; "..YELLOW.."12,31"..WHITE..")"
Inst20Quest9_Note = "Only Warlocks can get this Quest! You find the alchemy lab at [3']."
Inst20Quest9_Prequest = "Yes, Mor'zul Bloodbringer - > Xorothian Stardust"
Inst20Quest9_Folgequest = "Yes, Dreadsteed of Xoroth"
Inst20Quest9PreQuest = "true"



--QUEST 1 Horde

Inst20Quest1_HORDE = "1. Plagued Hatchlings"
Inst20Quest1_HORDE_Attain = "55"
Inst20Quest1_HORDE_Level = "58"
Inst20Quest1_HORDE_Aim = "Kill 20 Plagued Hatchlings, then return to Betina Bigglezink at the Light's Hope Chapel."
Inst20Quest1_HORDE_Location = "Betina Bigglezink (Eastern Plaguelands - Light's Hope Chapel; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest1_HORDE_Note = ""
Inst20Quest1_HORDE_Prequest = "No"
Inst20Quest1_HORDE_Folgequest = "No"


--QUEST 2 Horde

Inst20Quest2_HORDE = "2. Healthy Dragon Scale"
Inst20Quest2_HORDE_Attain = ""
Inst20Quest2_HORDE_Level = "58"
Inst20Quest2_HORDE_Aim = "Bring the Healthy Dragon Scale to Betina Bigglezink at the Light's Hope Chapel in Eastern Plaguelands."
Inst20Quest2_HORDE_Location = "Healthy Dragon Scale (Drop) (Scholomance)"
Inst20Quest2_HORDE_Note = "Plagued Hatchlings drop the Healthy Dragon Scale (8% Dropchance). You find Betina Bigglezink at 81,59."
Inst20Quest2_HORDE_Prequest = "Yes, Plagued Hatchlings "
Inst20Quest2_HORDE_Folgequest = "No"
Inst20Quest2FQuest_HORDE = "true"


--QUEST 3 Horde

Inst20Quest3_HORDE = "3. Doctor Theolen Krastinov, the Butcher"
Inst20Quest3_HORDE_Attain = "55"
Inst20Quest3_HORDE_Level = "60"
Inst20Quest3_HORDE_Aim = "Find Doctor Theolen Krastinov inside the Scholomance. Destroy him, then burn the Remains of Eva Sarkhoff and the Remains of Lucien Sarkhoff. Return to Eva Sarkhoff when the task is complete."
Inst20Quest3_HORDE_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest3_HORDE_Note = "You find Doctor Theolen Krastinov at [9]."
Inst20Quest3_HORDE_Prequest = "No"
Inst20Quest3_HORDE_Folgequest = "Yes, Krastinov's Bag of Horrors"

--QUEST 4 Horde

Inst20Quest4_HORDE = "4. Krastinov's Bag of Horrors"
Inst20Quest4_HORDE_Attain = "55"
Inst20Quest4_HORDE_Level = "60"
Inst20Quest4_HORDE_Aim = "Locate Yesndice Barov in the Scholomance and destroy her. From her corpse recover Krastinov's Bag of Horrors. Return the bag to Eva Sarkhoff."
Inst20Quest4_HORDE_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest4_HORDE_Note = "You find Yesndice Barov at [3]."
Inst20Quest4_HORDE_Prequest = "Yes, Doctor Theolen Krastinov, the Butcher"
Inst20Quest4_HORDE_Folgequest = "Yes, Kirtonos the Herald"
Inst20Quest4FQuest_HORDE = "true"


--QUEST 5 Horde

Inst20Quest5_HORDE = "5. Kirtonos the Herald"
Inst20Quest5_HORDE_Attain = "56"
Inst20Quest5_HORDE_Level = "60"
Inst20Quest5_HORDE_Aim = "Return to the Scholomance with the Blood of Innocents. Find the porch and place the Blood of Innocents in the brazier. Kirtonos will come to feast upon your soul. Fight valiantly, do not give an inch! Destroy Kirtonos and return to Eva Sarkhoff."
Inst20Quest5_HORDE_Location = "Eva Sarkhoff (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest5_HORDE_Note = "The porch is at [2]."
Inst20Quest5_HORDE_Prequest = "Yes, Krastinov's Bag of Horrors"
Inst20Quest5_HORDE_Folgequest = "Yes, The Human, Ras Frostwhisper"
Inst20Quest5FQuest_HORDE = "true"
--
Inst20Quest5name1_HORDE = "Spectral Essence"
Inst20Quest5name2_HORDE = "Penelope's Rose"
Inst20Quest5name3_HORDE = "Mirah's Song"

--QUEST 6 Horde

Inst20Quest6_HORDE = "6. The Lich, Ras Frostwhisper"
Inst20Quest6_HORDE_Attain = "60"
Inst20Quest6_HORDE_Level = "60"
Inst20Quest6_HORDE_Aim = "Find Ras Frostwhisper in the Scholomance. When you have found him, use the Soulbound Keepsake on his undead visage. Should you succeed in reverting him to a mortal, strike him down and recover the Human Head of Ras Frostwhisper. Take the head back to Magistrate Marduke."
Inst20Quest6_HORDE_Location = "Magistrate Marduke (Western Plaguelands; "..YELLOW.."70,73"..WHITE..")"
Inst20Quest6_HORDE_Note = "You find Ras Frostwhisper at [7]."
Inst20Quest6_HORDE_Prequest = "Yes, The Human, Ras Frostwhisper - > Soulbound Keepsake"
Inst20Quest6_HORDE_Folgequest = "No"
Inst20Quest6PreQuest_HORDE = "true"
--
Inst20Quest6name1_HORDE = "Darrowshire Strongguard"
Inst20Quest6name2_HORDE = "Warblade of Caer Darrow"
Inst20Quest6name3_HORDE = "Crown of Caer Darrow"
Inst20Quest6name4_HORDE = "Darrowspike"

--QUEST 7 Horde

Inst20Quest7_HORDE = "7. Barov Family Fortune"
Inst20Quest7_HORDE_Attain = "60"
Inst20Quest7_HORDE_Level = "60"
Inst20Quest7_HORDE_Aim = "Venture to the Scholomance and recover the Barov family fortune. Four deeds make up this fortune: The Deed to Caer Darrow; The Deed to Brill; The Deed to Tarren Mill; and The Deed to Southshore. Return to Alexi Barov when you have completed this task."
Inst20Quest7_HORDE_Location = "Alexi Barov (Western Plaguelands; "..YELLOW.."28,57"..WHITE..")"
Inst20Quest7_HORDE_Note = "You find The Deed to Caer Darrow at [12], The Deed to Brill at [7], The Deed to Tarren Mill at [4] and The Deed to Southshore at [1]."
Inst20Quest7_HORDE_Prequest = "No"
Inst20Quest7_HORDE_Folgequest = "Yes, The Last Barov"


--QUEST 8 Horde

Inst20Quest8_HORDE = "8. Dawn's Gambit"
Inst20Quest8_HORDE_Attain = "59"
Inst20Quest8_HORDE_Level = "60"
Inst20Quest8_HORDE_Aim = "Place Dawn's Gambit in the Viewing Room of the Scholomance. Defeat Vectus, then return to Betina Bigglezink."
Inst20Quest8_HORDE_Location = "Betina Bigglezink (Eastern Plaguelands - Light's Hope Chapel; "..YELLOW.."81,59"..WHITE..")"
Inst20Quest8_HORDE_Note = "Broodling Essence begins at Tinkee Steamboil (Burning Steppes, 65,23). The Viewing Room is at [6]."
Inst20Quest8_HORDE_Prequest = "Yes, Broodling Essence - > Betina Bigglezink"
Inst20Quest8_HORDE_Folgequest = "No"
Inst20Quest8PreQuest_HORDE = "true"
--
Inst20Quest8name1_HORDE = "Windreaper"
Inst20Quest8name2_HORDE = "Dancing Sliver"

--QUEST 9 Horde

Inst20Quest9_HORDE = "9. Imp Delivery (Warlock)"
Inst20Quest9_HORDE_Attain = "60"
Inst20Quest9_HORDE_Level = "60"
Inst20Quest9_HORDE_Aim = "Bring the Imp in a Yesr to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."
Inst20Quest9_HORDE_Location = "Gorzeeki Wildeyes (Burning Steppes; "..YELLOW.."12,31"..WHITE..")"
Inst20Quest9_HORDE_Note = "Only Warlocks can get this Quest! You find the alchemy lab at [3']."
Inst20Quest9_HORDE_Prequest = "Yes, Mor'zul Bloodbringer - > Xorothian Stardust"
Inst20Quest9_HORDE_Folgequest = "Yes, Dreadsteed of Xoroth"
Inst20Quest9PreQuest_HORDE = "true"

--------------Inst7/BFD(6  quests)------------
Inst7Story = "Situated along the Zoram Strand of Ashenvale, Blackfathom Depths was once a glorious temple dedicated to the night elves' moon-goddess, Elune. However, the great Sundering shattered the temple - sinking it beneath the waves of the Veiled Sea. There it remained untouched - until, drawn by its ancient power - the naga and satyr emerged to plumb its secrets. Legends hold that the ancient beast, Aku'mai, has taken up residence within the temple's ruins. Aku'mai, a favored pet of the primordial Old Gods, has preyed upon the area ever since. Drawn to Aku'mai's presence, the cult known as the Twilight's Hammer has also come to bask in the Old Gods' evil presence."
Inst7Caption = "Blackfathom Depths"
Inst7QAA = "6 Quests"
Inst7QAH = "5 Quests"

--QUEST 1 Allianz

Inst7Quest1 = "1. Knowledge in the Deeps"
Inst7Quest1_Attain = "18"
Inst7Quest1_Level = "23"
Inst7Quest1_Aim = "Bring the Lorgalis Manuscript to Gerrig Bonegrip in the Forlorn Cavern in Ironforge."
Inst7Quest1_Location = "Gerrig Bonegrip (Ironforge; "..YELLOW.."50,5"..WHITE..")"
Inst7Quest1_Note = "You find the Manuscript near [2] in the water."
Inst7Quest1_Prequest = "No"
Inst7Quest1_Folgequest = "No"
--
Inst7Quest1name1 = "Sustaining Ring"

--QUEST 2 Allianz

Inst7Quest2 = "2. Researching the Corruption "
Inst7Quest2_Attain = "19"
Inst7Quest2_Level = "24"
Inst7Quest2_Aim = "Gershala Nightwhisper in Auberdine wants 8 Corrupt Brain stems."
Inst7Quest2_Location = "Gershala Nightwhisper (Darkshore - Auberdine; "..YELLOW.."38,43"..WHITE..")"
Inst7Quest2_Note = "You get the Prequest from Argos Nightwhisper (Stormwind; 21,55). Alle Nagas before and in Blackfathomdeeps drop the brains."
Inst7Quest2_Prequest = "Yes, The Corruption Abroad"
Inst7Quest2_Folgequest = "No"
Inst7Quest2PreQuest = "true"
--
Inst7Quest2name1 = "Beetle Clasps"
Inst7Quest2name2 = "Prelacy Cape"

--QUEST 3 Allianz

Inst7Quest3 = "3. In Search of Thaelrid"
Inst7Quest3_Attain = "19"
Inst7Quest3_Level = "24"
Inst7Quest3_Aim = "Seek out Argent Guard Thaelrid in Blackfathom Deeps."
Inst7Quest3_Location = "Argent Guard Shaedlass (Darnassus; "..YELLOW.."55,24"..WHITE..")"
Inst7Quest3_Note = "You find Argent Guard Thaelrid at [4]."
Inst7Quest3_Prequest = "No"
Inst7Quest3_Folgequest = "Yes, Blackfathom Villainy"

--QUEST 4 Alliance

Inst7Quest4 = "4. Blackfathom Villainy"
Inst7Quest4_Attain = "-"
Inst7Quest4_Level = "27"
Inst7Quest4_Aim = "Bring the head of Twilight Lord Kelris to Dawnwatcher Selgorm in Darnassus."
Inst7Quest4_Location = "Argent Guard Thaelrid (Blackfathomtiefen; "..YELLOW.."[4]"..WHITE..")"
Inst7Quest4_Note = "You get this Quest from Thaelrid at [4]. Kelris is at [8]. ATTENTION! If you turn on the flames beside Lord Kelris Ennemys appear and attack you. You find Dawnwatcher Selgorm in Darnassus (55,24)"
Inst7Quest4_Prequest = "Yes, In Search of Thaelrid"
Inst7Quest4_Folgequest = "No"
Inst7Quest4FQuest = "true"
--
Inst7Quest4name1 = "Gravestone Scepter"
Inst7Quest4name2 = "Arctic Buckler"

--QUEST 5 Alliance

Inst7Quest5 = "5. Twilight Falls"
Inst7Quest5_Attain = "20"
Inst7Quest5_Level = "25"
Inst7Quest5_Aim = "Bring 10 Twilight Pendants to Argent Guard Manados in Darnassus."
Inst7Quest5_Location = "Argent Guard Manados (Darnassus; "..YELLOW.."55,23"..WHITE..")"
Inst7Quest5_Note = "Every Twilight-Enemy drop the Pendant."
Inst7Quest5_Prequest = "No"
Inst7Quest5_Folgequest = "No"
--
Inst7Quest5name1 = "Nimbus Boots"
Inst7Quest5name2 = "Heartwood Girdle"

--QUEST 6 Alliance (hexenmeister)

Inst7Quest6 = "6. The Orb of Soran'ruk (Warlock)"
Inst7Quest6_Attain = "21"
Inst7Quest6_Level = "26"
Inst7Quest6_Aim = "Find 3 Soran'ruk Fragments and 1 Large Soran'ruk Fragment and return them to Doan Karhan in the Barrens."
Inst7Quest6_Location = "Doan Karhan (Barrens; "..YELLOW.."49,67"..WHITE..")"
Inst7Quest6_Note = "Only Warlocks can get this Quest! You get the 3 Soran'ruk Fragmentes from Twilight-Akolyts in [Blackfathomdeeps]. You get the Large Soran'ruk Fragment in [Shadowfang Keep] from Shadowfang Darksouls."
Inst7Quest6_Prequest = "No"
Inst7Quest6_Folgequest = "No"
--
Inst7Quest6name1 = "Orb of Soran'ruk"
Inst7Quest6name2 = "Staff of Soran'ruk"


--QUEST 1 Horde

Inst7Quest1_HORDE = "1. The Essence of Aku'Mai "
Inst7Quest1_HORDE_Attain = "17"
Inst7Quest1_HORDE_Level = "22"
Inst7Quest1_HORDE_Aim = "Bring 20 Sapphires of Aku'Mai to Je'neu Sancrea in Ashenvale."
Inst7Quest1_HORDE_Location = "Je'neu Sancrea (Ashenvale - Zorambeach; "..YELLOW.."11,33"..WHITE..")"
Inst7Quest1_HORDE_Note = "You get the prequest Trouble in the Deeps from Tsunaman (Stonetalon Mountains, 47,64). Die Sapphire findet man vor der Instanz in den G\195\164ngen."
Inst7Quest1_HORDE_Prequest = "Yes, \195\132rger in der Tiefe"
Inst7Quest1_HORDE_Folgequest = "No"
Inst7Quest1PreQuest_HORDE = "true"

--QUEST 2 Horde

Inst7Quest2_HORDE = "2. Allegiance to the Old Gods"
Inst7Quest2_HORDE_Attain = "-"
Inst7Quest2_HORDE_Level = "26"
Inst7Quest2_HORDE_Aim = "Bring the Damp Note to Je'neu Sancrea in Ashenvale -> Kill Lorgus Jett in Blackfathom Deeps and then return to Je'neu Sancrea in Ashenvale."
Inst7Quest2_HORDE_Location = "Damp Note (drop) (Blackfathomdeeps; "..YELLOW..""..WHITE..")"
Inst7Quest2_HORDE_Note = "You get the dump Note from Blackfathom Tide Priestess (5% dropchance). Lorgus Jett is at [6]."
Inst7Quest2_HORDE_Prequest = "No"
Inst7Quest2_HORDE_Folgequest = "No"
--
Inst7Quest2name1_HORDE = "Band of the Fist"
Inst7Quest2name2_HORDE = "Chestnut Mantle"

--QUEST 3 Horde

Inst7Quest3_HORDE = "3. Amongst the Ruins"
Inst7Quest3_HORDE_Attain = "-"
Inst7Quest3_HORDE_Level = "27"
Inst7Quest3_HORDE_Aim = "Bring the Fathom Core to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."
Inst7Quest3_HORDE_Location = "Je'neu Sancrea (Ashenvale - Zorambeach; "..YELLOW.."11,33"..WHITE..")"
Inst7Quest3_HORDE_Note = "You find the Fathom Core at [7] in the water. When you get the Core Lord Aquanis appear and attack you. He drops a questitem which you have to bring to Je'neu Sancrea (Ashenvale - Zorambeach; 11,33)"
Inst7Quest3_HORDE_Prequest = "No"
Inst7Quest3_HORDE_Folgequest = "No"

--QUEST 4 Horde

Inst7Quest4_HORDE = "4. Blackfathom Villainy"
Inst7Quest4_HORDE_Attain = "-"
Inst7Quest4_HORDE_Level = "27"
Inst7Quest4_HORDE_Aim = "Bring the head of Twilight Lord Kelris to Bashana Runetotem in Thunder Bluff."
Inst7Quest4_HORDE_Location = "Argent guard Thaelrid (Blackfathomdeeps; "..YELLOW.."[4]"..WHITE..")"
Inst7Quest4_HORDE_Note = "You get this Quest from Thaelrid at [4]. Kelris is at [8]. ATTENTION! If you turn on the flames beside Lord Kelris Ennemys appear and attack you. You find Bashana Runetotem in Thunderbluff (70, 33)."
Inst7Quest4_HORDE_Prequest = "No"
Inst7Quest4_HORDE_Folgequest = "No"
--
Inst7Quest4name1_HORDE = "Gravestone Scepter"
Inst7Quest4name2_HORDE = "Arctic Buckler"

--QUEST 5 Horde (Warlock)

Inst7Quest5_HORDE = "5. The Orb of Soran'ruk (Warlock)"
Inst7Quest5_HORDE_Attain = "20"
Inst7Quest5_HORDE_Level = "25"
Inst7Quest5_HORDE_Aim = "Find 3 Soran'ruk Fragments and 1 Large Soran'ruk Fragment and return them to Doan Karhan in the Barrens."
Inst7Quest5_HORDE_Location = "Doan Karhan (Barrens; "..YELLOW.."49,57"..WHITE..")"
Inst7Quest5_HORDE_Note = "Only Warlocks can get this Quest! You get the 3 Soran'ruk Fragmentes from Twilight-Akolyts in [Blackfathomdeeps]. You get the Large Soran'ruk Fragment in [Shadowfang Keep] from Shadowfang Darksouls."
Inst7Quest5_HORDE_Prequest = "No"
Inst7Quest5_HORDE_Folgequest = "No"
--
Inst7Quest5name1_HORDE = "Orb of Soran'ruk"
Inst7Quest5name2_HORDE = "Staff of Soran'ruk"

--------------Inst25 ( 8 quests)------------
Inst25Story = "Over a thousand years ago, the powerful Gurubashi Empire was torn apart by a massive civil war. An influential group of troll priests, known as the Atal'ai, attempted to bring back an ancient blood god named Hakkar the Soulflayer. Though the priests were defeated and ultimately exiled, the great troll empire buckled in upon itself. The exiled priests fled far to the north, into the Swamp of Sorrows. There they erected a great temple to Hakkar - where they could prepare for his arrival into the physical world. The great dragon Aspect, Ysera, learned of the Atal'ai's plans and smashed the temple beneath the marshes. To this day, the temple's drowned ruins are guarded by the green dragons who prevent anyone from getting in or out. However, it is believed that some of the fanatical Atal'ai may have survived Ysera's wrath - and recommitted themselves to the dark service of Hakkar."
Inst25Caption = "The sunken Temple"
--classq
Inst25QAA = "8 Quests"
Inst25QAH = "8 Quests"

--QUEST 1 Allianz

Inst25Quest1 = "1. Into The Temple of Atal'Hakkar"
Inst25Quest1_Attain = "46"
Inst25Quest1_Level = "50"
Inst25Quest1_Aim = "Gather 10 Atal'ai Tablets for Brohann Caskbelly in Stormwind."
Inst25Quest1_Location = "Brohann Caskbelly (Stormwind; "..YELLOW.."64,20"..WHITE..")"
Inst25Quest1_Note = "You can find the Tables everywhere in the Temple."
Inst25Quest1_Prequest = "Yes, In Search of The Temple(same NPC) -> Rhapsody's Tale"
Inst25Quest1_Folgequest = "No"
Inst25Quest1PreQuest = "true"
--
Inst25Quest1name1 = "Guardian Talisman"

--QUEST 2 Allianz

Inst25Quest2 = "2. The Sunken Temple"
Inst25Quest2_Attain = "-"
Inst25Quest2_Level = "51"
Inst25Quest2_Aim = "Find Marvon Rivetseeker in Tanaris."
Inst25Quest2_Location = "Angelas Moonbreeze (Feralas; "..YELLOW.."31,45"..WHITE..")"
Inst25Quest2_Note = "You find Marvon Rivetseeker at 52,45"
Inst25Quest2_Prequest = "No"
Inst25Quest2_Folgequest = "Yes, The Stone Circle"

--QUEST 3 Allianz

Inst25Quest3 = "3. Into the Depths"
Inst25Quest3_Attain = "-"
Inst25Quest3_Level = "51"
Inst25Quest3_Aim = "Find the Altar of Hakkar in the Sunken Temple in Swamp of Sorrows."
Inst25Quest3_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest3_Note = "The Altar is at [1]."
Inst25Quest3_Prequest = "Yes, The Stone Circle"
Inst25Quest3_Folgequest = "Yes, Secret of the Circle"
Inst25Quest3FQuest = "true"


--QUEST 4 Alliance

Inst25Quest4 = "4. Secret of the Circle"
Inst25Quest4_Attain = "-"
Inst25Quest4_Level = "51"
Inst25Quest4_Aim = "Travel into the Sunken Temple and discover the secret hidden in the circle of statues."
Inst25Quest4_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest4_Note = "You find the statues at [1] open them in this order:1-6"
Inst25Quest4_Prequest = "Yes, Into the Deeps"
Inst25Quest4_Folgequest = "No"
Inst25Quest4FQuest = "true"
--
Inst25Quest4name1 = "Hakkari Urn"

--QUEST 5 Alliance

Inst25Quest5 = "5. Haze of Evil"
Inst25Quest5_Attain = "50"
Inst25Quest5_Level = "52"
Inst25Quest5_Aim = "Collect 5 samples of Atal'ai Haze, then return to Muigin in Un'Goro Crater."
Inst25Quest5_Location = "Gregan Brewspewer (Feralas; "..YELLOW.."45,25"..WHITE..")"
Inst25Quest5_Note = "The Prequest 'Muigin and Larion' starts at Muigin (Un'Goro Crater 42,9). You get the Haze from deep lurkers, murk worms, or oozes in the Temple."
Inst25Quest5_Prequest = "Yes, Muigin and Larion -> A Visit to Gregan "
Inst25Quest5_Folgequest = "No"
Inst25Quest5PreQuest = "true"



--QUEST 6 Alliance

Inst25Quest6 = "6. The God Hakkar (Questline)"
Inst25Quest6_Attain = "43"
Inst25Quest6_Level = "53"
Inst25Quest6_Aim = "Bring the Filled Egg of Hakkar to Yeh'kinya in Tanaris."
Inst25Quest6_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22"..WHITE..")"
Inst25Quest6_Note = "The Questline starts with 'Screecher Spirits' at the same NPC(See [Zul'Farrak]).\nYou have to use the Egg at [3] to start the Event. Once it start Enemys spawns and attack you. Some of them drop the blood of Hakkar. With this blood you can put out the torch around the circle. After this the Avatar of Hakkar spawn."
Inst25Quest6_Prequest = "Yes, Screecher Spirits -> The Ancient Egg"
Inst25Quest6_Folgequest = "No"
Inst25Quest6PreQuest = "true"
--
Inst25Quest6name1 = "Avenguard Helm"
Inst25Quest6name2 = "Lifeforce Dirk"
Inst25Quest6name3 = "Gemburst Circlet"

--QUEST 7 Alliance

Inst25Quest7 = "7. Jammal'an the Prophet"
Inst25Quest7_Attain = "43"
Inst25Quest7_Level = "53"
Inst25Quest7_Aim = "The Atal'ai Exile in The Hinterlands wants the Head of Jammal'an."
Inst25Quest7_Location = "The Atal'ai Exile (The Hinterlands; "..YELLOW.."33,75"..WHITE..")"
Inst25Quest7_Note = "You find Jammal'an at [4]."
Inst25Quest7_Prequest = "No"
Inst25Quest7_Folgequest = "No"
--
Inst25Quest7name1 = "Rainstrider Leggings"
Inst25Quest7name2 = "Helm of Exile"

--QUEST 8 Alliance
Inst25Quest8 = "8. The Essence of Eranikus"
Inst25Quest8_Attain = "-"
Inst25Quest8_Level = "55"
Inst25Quest8_Aim = "Place the Essence of Eranikus in the Essence Font located in this lair in the Sunken Temple."
Inst25Quest8_Location = "The Essence of Eranikus (drop) (The Sunken Temple)"
Inst25Quest8_Note = "Eranikus drop his Essence. You find the Essence Font next to him at [6]."
Inst25Quest8_Prequest = "No"
Inst25Quest8_Folgequest = "No"
--
Inst25Quest8name1 = "Chained Essence of Eranikus"


--QUEST 1 Horde

Inst25Quest1_HORDE = "1. The Temple of Atal'Hakkar"
Inst25Quest1_HORDE_Attain = "38"
Inst25Quest1_HORDE_Level = "50"
Inst25Quest1_HORDE_Aim = "Collect 20 Fetishes of Hakkar and bring them to Fel'Zerul in Stonard."
Inst25Quest1_HORDE_Location = "Fel'Zerul (Swamp of Sorrows - Stonard; "..YELLOW.."47,54"..WHITE..")"
Inst25Quest1_HORDE_Note = "All Enemys in the Temple drop Fetishes"
Inst25Quest1_HORDE_Prequest = "Yes, Pool of Tears(same NPC) -> Return to Fel'Zerul"
Inst25Quest1_HORDE_Folgequest = "No"
Inst25Quest1PreQuest_HORDE = "true"
--
Inst25Quest1name1_HORDE = "Guardian Talisman"

--QUEST 2 Horde

Inst25Quest2_HORDE = "2. The Sunken Temple"
Inst25Quest2_HORDE_Attain = ""
Inst25Quest2_HORDE_Level = "51"
Inst25Quest2_HORDE_Aim = "Find Marvon Rivetseeker in Tanaris."
Inst25Quest2_HORDE_Location = "Witch Doctor Uzer'i (Feralas; "..YELLOW.."74,43"..WHITE..")"
Inst25Quest2_HORDE_Note = "You find Marvon Rivetseeker at 52,45"
Inst25Quest2_HORDE_Prequest = "No"
Inst25Quest2_HORDE_Folgequest = "Yes, The Stone Circle"

--QUEST 3 Horde

Inst25Quest3_HORDE = "3. Into the Depths"
Inst25Quest3_HORDE_Attain = "-"
Inst25Quest3_HORDE_Level = "51"
Inst25Quest3_HORDE_Aim = "Find the Altar of Hakkar in the Sunken Temple in Swamp of Sorrows."
Inst25Quest3_HORDE_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest3_HORDE_Note = "The Altar is at [1]."
Inst25Quest3_HORDE_Prequest = "Yes, The Stone Circle"
Inst25Quest3_HORDE_Folgequest = "Yes, Secret of the Circle"
Inst25Quest3FQuest_HORDE = "true"

--QUEST 4 Horde

Inst25Quest4_HORDE = "4. Secret of the Circle"
Inst25Quest4_HORDE_Attain = "-"
Inst25Quest4_HORDE_Level = "51"
Inst25Quest4_HORDE_Aim = "Travel into the Sunken Temple and discover the secret hidden in the circle of statues."
Inst25Quest4_HORDE_Location = "Marvon Rivetseeker (Tanaris; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest4_HORDE_Note = "You find the statues at [1] open them in this order:1-6"
Inst25Quest4_HORDE_Prequest = "Yes, Into the Deeps"
Inst25Quest4_HORDE_Folgequest = "No"
Inst25Quest4FQuest_HORDE = "true"
--
Inst25Quest4name1_HORDE = "Hakkari Urn"

--QUEST 5 Horde

Inst25Quest5_HORDE = "5. Zapper Fuel"
Inst25Quest5_HORDE_Attain = "50"
Inst25Quest5_HORDE_Level = "52"
Inst25Quest5_HORDE_Aim = "Deliver the Unloaded Zapper and 5 samples of Atal'ai Haze to Larion in Marshal's Refuge."
Inst25Quest5_HORDE_Location = "Liv Rizzlefix (Barrens; "..YELLOW.."62,38"..WHITE..")"
Inst25Quest5_HORDE_Note = "The Prequest 'Larion and Muigin' starts at Larion (Un'Goro Crater 45,8). You get the Haze from deep lurkers, murk worms, or oozes in the Temple."
Inst25Quest5_HORDE_Prequest = "Yes, Larion and Muigin -> Marvon's Workshop"
Inst25Quest5_HORDE_Folgequest = "No"
Inst25Quest5PreQuest_HORDE = "true"

--QUEST 6 Horde

Inst25Quest6_HORDE = "6. The God Hakkar (Questline)"
Inst25Quest6_HORDE_Attain = "43"
Inst25Quest6_HORDE_Level = "53"
Inst25Quest6_HORDE_Aim = "Bring the Filled Egg of Hakkar to Yeh'kinya in Tanaris."
Inst25Quest6_HORDE_Location = "Yeh'kinya (Tanaris; "..YELLOW.."66,22"..WHITE..")"
Inst25Quest6_HORDE_Note = "The Questline starts with 'Screecher Spirits' at the same NPC(See [Zul'Farrak]).\nYou have to use the Egg at [3] to start the Event. Once it start Enemys spawns and attack you. Some of them drop the blood of Hakkar. With this blood you can put out the torch around the circle. After this the Avatar of Hakkar spawn."
Inst25Quest6_HORDE_Prequest = "Yes, Screecher Spirits -> The Ancient Egg"
Inst25Quest6_HORDE_Folgequest = "No"
Inst25Quest6PreQuest_HORDE = "true"
--
Inst25Quest6name1_HORDE = "Avenguard Helm"
Inst25Quest6name2_HORDE = "Lifeforce Dirk"
Inst25Quest6name3_HORDE = "Gemburst Circlet"

--QUEST 7 Horde

Inst25Quest7_HORDE = "7. Jammal'an the Prophet"
Inst25Quest7_HORDE_Attain = "43"
Inst25Quest7_HORDE_Level = "53"
Inst25Quest7_HORDE_Aim = "The Atal'ai Exile in The Hinterlands wants the Head of Jammal'an."
Inst25Quest7_HORDE_Location = "The Atal'ai Exile (The Hinterlands; "..YELLOW.."33,75"..WHITE..")"
Inst25Quest7_HORDE_Note = "You find Jammal'an at [4]."
Inst25Quest7_HORDE_Prequest = "No"
Inst25Quest7_HORDE_Folgequest = "No"
--
Inst25Quest7name1_HORDE = "Rainstrider Leggings"
Inst25Quest7name2_HORDE = "Helm of Exile"

--QUEST 8 Horde

Inst25Quest8_HORDE = "8. The Essence of Eranikus"
Inst25Quest8_HORDE_Attain = "-"
Inst25Quest8_HORDE_Level = "55"
Inst25Quest8_HORDE_Aim = "Place the Essence of Eranikus in the Essence Font located in this lair in the Sunken Temple."
Inst25Quest8_HORDE_Location = "The Essence of Eranikus (drop) (The Sunken Temple)"
Inst25Quest8_HORDE_Note = "Eranikus drop his Essence. You find the Essence Font next to him at [6]."
Inst25Quest8_HORDE_Prequest = "No"
Inst25Quest8_HORDE_Folgequest = "No"
--
Inst25Quest8name1_HORDE = "Chained Essence of Eranikus"

--------------Burg Shadowfang/Inst21/BSF ------------
Inst21Story = "During the Third War, the wizards of the Kirin Tor battled against the undead armies of the Scourge. When the wizards of Dalaran died in battle, they would rise soon after - adding their former might to the growing Scourge. Frustrated by their lack of progress (and against the advice of his peers) the Archmage, Arugal elected to summon extra-dimensional entities to bolster Dalaran's diminishing ranks. Arugal's summoning brought the ravenous worgen into the world of Azeroth. The feral wolf-men slaughtered not only the Scourge, but quickly turned on the wizards themselves. The worgen laid siege to the keep of the noble, Baron Silverlaine. Situated above the tiny hamlet of Pyrewood, the keep quickly fell into shadow and ruin. Driven mad with guilt, Arugal adopted the worgen as his children and retreated to the newly dubbed 'Shadowfang Keep'. It's said he still resides there, protected by his massive pet, Fenrus - and haunted by the vengeful ghost of Baron Silverlaine."
Inst21Caption = "Shadowfang Keep"
Inst21QAA = "2 Quests"
Inst21QAH = "4 Quests"

--Quest 1 allianz

Inst21Quest1 = "1. The Test of Righteousness (Paladin)"
Inst21Quest1_Level = "22"
Inst21Quest1_Attain = "20"
Inst21Quest1_Aim = "Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."
Inst21Quest1_Location = "Jordan Stilwell (Dun Morogh - Ironforge Entrance "..YELLOW.."52,36 "..WHITE..")"
Inst21Quest1_Note = "To see the note pls klick on  [The Test of Righteousness Information]."
Inst21Quest1_Prequest = "Yes, The Tome of Valor -> The Test of Righteousness"
Inst21Quest1_Folgequest = "Yes, The Test of Righteousness"
Inst21Quest1PreQuest = "true"
--
Inst21Quest1name1 = "Verigan's Fist"

Inst21Quest2 = "The Test of Righteousness Information"
Inst21Quest2TEXT = "Only Paladins can get this quest!\n1. You get the  Whitestone Oak Lumber from Goblin Woodcarvers in [Deadmines].\n2. To get the Bailor's Refined Ore Shipment you musst talk to Bailor Stonehand (Loch Modan; 35,44 ). He gives you the 'Bailor's Ore Shipment' quest. You find the Jordan's Ore Shipment behind a tree at 71,21\n3. You get Jordan's Smithing Hammer in [Shadowfang Keep] next to [B] (the stables).\n4. To get a Kor Gem you have to go to Thundris Windweaver (Darkshore; 37,40) and make the 'Seeking the Kor Gem' quest. For this quest you musst kill Blackfathom oracles or priestesses before [Blackfathom Deeps]. They drop a corrupted Kor Gem. Thundris Windweaver clean it for you."
Inst21Quest2_Level = "100"
Inst21Quest2_Attain = ""
Inst21Quest2_Aim = ""
Inst21Quest2_Location = ""
Inst21Quest2_Note = ""
Inst21Quest2_Prequest = ""
Inst21Quest2_Folgequest = ""
Inst21Quest2FQuest = "true"

--QUEST 2 Alliance (hexenmeister)

Inst21Quest3 = "2. The Orb of Soran'ruk (Warlock)"
Inst21Quest3_Attain = "21"
Inst21Quest3_Level = "26"
Inst21Quest3_Aim = "Find 3 Soran'ruk Fragments and 1 Large Soran'ruk Fragment and return them to Doan Karhan in the Barrens."
Inst21Quest3_Location = "Doan Karhan (Barrens; "..YELLOW.."49,67"..WHITE..")"
Inst21Quest3_Note = "Only Warlocks can get this Quest! You get the 3 Soran'ruk Fragmentes from Twilight-Akolyts in [Blackfathomdeeps]. You get the Large Soran'ruk Fragment in [Shadowfang Keep] from Shadowfang Darksouls."
Inst21Quest3_Prequest = "No"
Inst21Quest3_Folgequest = "No"
--
Inst21Quest3name1 = "Orb of Soran'ruk"
Inst21Quest3name2 = "Staff of Soran'ruk"

--QUEST 1 Horde

Inst21Quest1_HORDE = "1. Deathstalkers in Shadowfang"
Inst21Quest1_HORDE_Attain = "-"
Inst21Quest1_HORDE_Level = "25"
Inst21Quest1_HORDE_Aim = "Find the Deathstalker Adamant and Deathstalker Vincent."
Inst21Quest1_HORDE_Location = "High Executor Hadrec (Silverpine Forest; "..YELLOW.."43,40"..WHITE..")"
Inst21Quest1_HORDE_Note = "You find Adamant at [1]. Vincet is on the right side when you go into the courtyard."
Inst21Quest1_HORDE_Prequest = "No"
Inst21Quest1_HORDE_Folgequest = "No"
--
Inst21Quest1name1_HORDE = "Ghostly Mantle"

--QUEST 2 Horde

Inst21Quest2_HORDE = "2. The Book of Ur"
Inst21Quest2_HORDE_Attain = "16"
Inst21Quest2_HORDE_Level = "26"
Inst21Quest2_HORDE_Aim = "Bring the Book of Ur to Keeper Bel'dugur at the Apothecarium in the Undercity."
Inst21Quest2_HORDE_Location = "Keeper Bel'dugur (Undercity; "..YELLOW.."53,54"..WHITE..")"
Inst21Quest2_HORDE_Note = "You find the book at [6](on the left side when you enter the room)."
Inst21Quest2_HORDE_Prequest = "No"
Inst21Quest2_HORDE_Folgequest = "No"
--
Inst21Quest2name1_HORDE = "Grizzled Boots"
Inst21Quest2name2_HORDE = "Steel-clasped Bracers"

--QUEST 3 Horde

Inst21Quest3_HORDE = "3. Arugal Must Die"
Inst21Quest3_HORDE_Attain = "?"
Inst21Quest3_HORDE_Level = "27"
Inst21Quest3_HORDE_Aim = "Kill Arugal and bring his head to Dalar Dawnweaver at the Sepulcher."
Inst21Quest3_HORDE_Location = "Dalar Dawnweaver (Silverpine Forest; "..YELLOW.."44,39"..WHITE..")"
Inst21Quest3_HORDE_Note = "You find Argual at [8]."
Inst21Quest3_HORDE_Prequest = "No"
Inst21Quest3_HORDE_Folgequest = "No"
--
Inst21Quest3name1_HORDE = "Seal of Sylvanas"

--QUEST 4 Horde (hexenmeister)

Inst21Quest4_HORDE = "4. The Orb of Soran'ruk (Warlock)"
Inst21Quest4_HORDE_Attain = "21"
Inst21Quest4_HORDE_Level = "26"
Inst21Quest4_HORDE_Aim = "Find 3 Soran'ruk Fragments and 1 Large Soran'ruk Fragment and return them to Doan Karhan in the Barrens."
Inst21Quest4_HORDE_Location = "Doan Karhan (Barrens; "..YELLOW.."49,67"..WHITE..")"
Inst21Quest4_HORDE_Note = "Only Warlocks can get this Quest! You get the 3 Soran'ruk Fragmentes from Twilight-Akolyts in [Blackfathomdeeps]. You get the Large Soran'ruk Fragment in [Shadowfang Keep] from Shadowfang Darksouls."
Inst21Quest4_HORDE_Prequest = "No"
Inst21Quest4_HORDE_Folgequest = "No"
--
Inst21Quest4name1_HORDE = "Orb of Soran'ruk"
Inst21Quest4name2_HORDE = "Staff of Soran'ruk"

--------------Inst5/Blackrocktiefen/BRD ------------
Inst5Story = "Once the capital city of the Dark Iron dwarves, this volcanic labyrinth now serves as the seat of power for Ragnaros the Firelord. Ragnaros has uncovered the secret to creating life from stone and plans to build an army of unstoppable golems to aid him in conquering the whole of Blackrock Mountain. Obsessed with defeating Nefarian and his draconic minions, Ragnaros will go to any extreme to achieve final victory."
Inst5Caption = "Blackrock Depths"
Inst5QAA = "14 Quests"
Inst5QAH = "14 Quests"

--QUEST1 Allianz

Inst5Quest1 = "1. Dark Iron Legacy"
Inst5Quest1_Attain = "48"
Inst5Quest1_Level = "52"
Inst5Quest1_Aim = "Slay Fineous Darkvire and recover the great hammer, Ironfel. Take Ironfel to the Shrine of Thaurissan and place it on the statue of Franclorn Forgewright."
Inst5Quest1_Location = "Franclorn Forgewright (Blackrock)"
Inst5Quest1_Note = "Franclorn is in the middle of the blackrock, above his grave. You have to be dead to see him! Talk 2 times with him to start the quest.\nFineous Darkvire is at [9]. You find the Shrine next to the arena [7]."
Inst5Quest1_Prequest = "No"
Inst5Quest1_Folgequest = "No"
--
Inst5Quest1name1 = "Shadowforge Key"

--QUEST2 Allianz

Inst5Quest2 = "2. Ribbly Screwspigot"
Inst5Quest2_Attain = "50"
Inst5Quest2_Level = "53"
Inst5Quest2_Aim = "Bring Ribbly's Head to Yuka Screwspigot in the Burning Steppes."
Inst5Quest2_Location = "Yuka Screwspigot (Burning Steppes "..YELLOW.."65,22"..WHITE..")"
Inst5Quest2_Note = "You get the prequest from Yorba Screwspigot (Tanaris; 67,23).\nRibbly is at [15]."
Inst5Quest2_Prequest = "Yes, Yuka Screwspigot"
Inst5Quest2_Folgequest = "No"
Inst5Quest2PreQuest = "true"
--
Inst5Quest2name1 = "Rancor Boots"
Inst5Quest2name2 = "Penance Spaulders"
Inst5Quest2name3 = "Splintsteel Armor"

--QUEST3 Allianz

Inst5Quest3 = "3. The Love Potion"
Inst5Quest3_Attain = "50"
Inst5Quest3_Level = "54"
Inst5Quest3_Aim = "Bring 4 Gromsblood, 10 Giant Silver Veins and Nagmara's Filled Vial to Mistress Nagmara in Blackrock Depths."
Inst5Quest3_Location = "Nagmara (Blackrock Depths, Tavern)"
Inst5Quest3_Note = "You get the Giant Silver Veins from Giants in Azshara, Gromsblood can find a Player with  	Herbalism and you can fill the Vial at the Go-Lakka crater (Un'Goro Crater; 31,50) füllen.\nAfter compliting the quest you can use the backdoor instaed of killing Phalanx."
Inst5Quest3_Prequest = "No"
Inst5Quest3_Folgequest = "No"
--
Inst5Quest3name1 = "Manacle Cuffs"
Inst5Quest3name2 = "Nagmara's Whipping Belt"

--QUEST4 Allianz

Inst5Quest4 = "4. Hurley Blackbreath"
Inst5Quest4_Attain = "?"
Inst5Quest4_Level = "55"
Inst5Quest4_Aim = "Bring the Lost Thunderbrew Recipe to Ragnar Thunderbrew in Kharanos."
Inst5Quest4_Location = "Ragnar Thunderbrew  (Dun Morogh "..YELLOW.."46,52"..WHITE..")"
Inst5Quest4_Note = "You get the prequest from Enohar Thunderbrew (Blasted lands; 61,18).\nYou get the recipe from one of the guards who appear if you destroy the ale [15]."
Inst5Quest4_Prequest = "Yes, Ragnar Thunderbrew"
Inst5Quest4_Folgequest = "No"
Inst5Quest4PreQuest = "true"
--
Inst5Quest4name1 = "Dark Dwarven Lager"
Inst5Quest4name2 = "Swiftstrike Cudgel"
Inst5Quest4name3 = "Limb Cleaver"


--QUEST5 Allianz

Inst5Quest5 = "5. Incendius!"
Inst5Quest5_Attain = "?"
Inst5Quest5_Level = "56"
Inst5Quest5_Aim = "Find Lord Incendius in Blackrock Depths and destroy him!"
Inst5Quest5_Location = "Jalinda Sprig (Burning Steppes "..YELLOW.."85,69"..WHITE..")"
Inst5Quest5_Note = "You get the prequest from Jalinda Sprig, too. Pyron is just before the instance portal.\nYou find Lord Incendius at [10]."
Inst5Quest5_Prequest = "Yes, Overmaster Pyron"
Inst5Quest5_Folgequest = "No"
Inst5Quest5PreQuest = "true"
--
Inst5Quest5name1 = "Sunborne Cape"
Inst5Quest5name2 = "Nightfall Gloves"
Inst5Quest5name3 = "Crypt Demon Bracers"
Inst5Quest5name4 = "Stalwart Clutch"

--QUEST6 Horde

Inst5Quest6 = "6. The Heart of the Mountain"
Inst5Quest6_Attain = "50"
Inst5Quest6_Level = "55"
Inst5Quest6_Aim = "Bring the Heart of the Mountain to Maxwort Uberglint in the Burning Steppes."
Inst5Quest6_Location = "Maxwort Uberglint (Burning Steppes "..YELLOW.."65,23"..WHITE..")"
Inst5Quest6_Note = "You find the Heart at [10] in a safe."
Inst5Quest6_Prequest = "No"
Inst5Quest6_Folgequest = "No"

--QUEST6 Allianz

Inst5Quest7 = "7. The Good Stuff"
Inst5Quest7_Attain = "?"
Inst5Quest7_Level = "56"
Inst5Quest7_Aim = "Travel to Blackrock Depths and recover 20 Dark Iron Fanny Packs. Return to Oralius when you have completed this task. You assume that the Dark Iron dwarves inside Blackrock Depths carry these 'fanny pack' contraptions."
Inst5Quest7_Location = "Oralius (Burning Steppes "..YELLOW.."84,68"..WHITE..")"
Inst5Quest7_Note = "All dwarves can drop the packs."
Inst5Quest7_Prequest = "No"
Inst5Quest7_Folgequest = "No"
--
Inst5Quest7name1 = "A Dingy Fanny Pack"

--QUEST7 Allianz

Inst5Quest8 = "8. Marshal Windsor (Onyxia-Questline)"
Inst5Quest8_Attain = "48"
Inst5Quest8_Level = "54"
Inst5Quest8_Aim = "Travel to Blackrock Mountain in the northwest and enter Blackrock Depths. Find out what became of Marshal Windsor.\nYou recall Ragged John talking about Windsor being dragged off to a prison."
Inst5Quest8_Location = "Marshal Maxwell (Burning Steppes "..YELLOW.."84,68"..WHITE..")"
Inst5Quest8_Note = "The questline starts at Helendis Riverhorn (Burning Steppes "..YELLOW.."85,68"..WHITE..").\nMarshal Windsor is at [4]. You have to come back to Maxwell after completing this quest."
Inst5Quest8_Prequest = "Yes, Dragonkin Menace -> The True Masters"
Inst5Quest8_Folgequest = "Yes, Abandoned Hope -> A Crumpled Up Note"
Inst5Quest8PreQuest = "true"
--
Inst5Quest8name1 = "Conservator Helm"
Inst5Quest8name2 = "Shieldplate Sabatons"
Inst5Quest8name3 = "Windshear Leggings"

--QUEST8 Allianz

Inst5Quest9 = "9. A Crumpled Up Note (Onyxia-Questline)"
Inst5Quest9_Attain = "51"
Inst5Quest9_Level = "54"
Inst5Quest9_Aim = "You may have just stumbled on to something that Marshal Windsor would be interested in seeing. There may be hope, after all."
Inst5Quest9_Location = "A Crumpled Up Note(drop) (Blackrock Depths)"
Inst5Quest9_Note = "Marshal Windsor is at [4]."
Inst5Quest9_Prequest = "Yes, Marshal Windsor"
Inst5Quest9_Folgequest = "Yes, A Shred of Hope"
Inst5Quest9FQuest = "true"

--QUEST9 Allianz

Inst5Quest10 = "10. A Shred of Hope (Onyxia-Questline)"
Inst5Quest10_Attain = "51"
Inst5Quest10_Level = "58"
Inst5Quest10_Aim = "Return Marshal Windsor's Lost Information.\nMarshal Windsor believes that the information is being held by Golem Lord Argelmach and General Angerforge."
Inst5Quest10_Location = "Marshal Windsors (Blackrock Depths "..YELLOW.."[4]"..WHITE..")"
Inst5Quest10_Note = "Marshal Windsor is at [4].\nYou find Golem Lord Argelmach at [14], General Angerforge at [13]."
Inst5Quest10_Prequest = "Yes, A Crumpled Up Note"
Inst5Quest10_Folgequest = "Yes, Jail Break!"
Inst5Quest10FQuest = "true"

--QUEST10 Allianz

Inst5Quest11 = "11. Jail Break! (Onyxia-Questline)"
Inst5Quest11_Attain = "54"
Inst5Quest11_Level = "58"
Inst5Quest11_Aim = "Help Marshal Windsor get his gear back and free his friends. Return to Marshal Maxwell if you succeed."
Inst5Quest11_Location = "Marshal Windsors (Blackrock Depths "..YELLOW.."[4]"..WHITE..")"
Inst5Quest11_Note = "Marshal Windsor is at [4].\nThe quest is easier if you clean the ring of law and the path to the entrance before you start the event. You find Marshal Maxwell at Burning Steppes ("..YELLOW.."84,68"..WHITE..")"
Inst5Quest11_Prequest = "Yes, A Shred of Hope"
Inst5Quest11_Folgequest = "Yes, Stormwind Rendezvous"
Inst5Quest11FQuest = "true"
--
Inst5Quest11name1 = "Ward of the Elements"
Inst5Quest11name2 = "Blade of Reckoning"
Inst5Quest11name3 = "Skilled Fighting Blade"

--QUEST12 Allianz

Inst5Quest12 = "12. A Taste of Flame (Questline)"
Inst5Quest12_Attain = "52"
Inst5Quest12_Level = "58"
Inst5Quest12_Aim = "Travel to Blackrock Depths and slay Bael'Gar. [...] Return the Encased Fiery Essence to Cyrus Therepentous."
Inst5Quest12_Location = "Cyrus Therepentous (Burning Steppes "..YELLOW.."94,31"..WHITE..")"
Inst5Quest12_Note = "The questline starts at Kalaran Windblade (Sengende Schlucht; 39,38).\nBael'Gar is at [11]."
Inst5Quest12_Prequest = "Yes, The Flawless Flame -> A Taste of Flame"
Inst5Quest12_Folgequest = "No"
Inst5Quest12PreQuest = "true"
--
Inst5Quest12name1 = "Shaleskin Cape"
Inst5Quest12name2 = "Wyrmhide Spaulders"
Inst5Quest12name3 = "Valconian Sash"

--QUEST13 Allianz

Inst5Quest13 = "13. Kharan Mighthammer"
Inst5Quest13_Attain = "?"
Inst5Quest13_Level = "59"
Inst5Quest13_Aim = " Travel to Blackrock Depths and find Kharan Mighthammer.\nThe King mentioned that Kharan was being held prisoner there - perhaps you should try looking for a prison."
Inst5Quest13_Location = "King Magni Bronzebeard (Ironforge "..YELLOW.."39,55"..WHITE..")"
Inst5Quest13_Note = "The prequest starts at Royal Historian Archesonus (Ironforge; 38,55).Kharan Mighthammer is at [2]."
Inst5Quest13_Prequest = "Yes, The Smoldering Ruins of Thaurissan"
Inst5Quest13_Folgequest = "Yes, The Bearer of Bad News"
Inst5Quest13PreQuest = "true"

--QUEST14 Allianz

Inst5Quest14 = "14. The Fate of the Kingdom"
Inst5Quest14_Attain = "?"
Inst5Quest14_Level = "59"
Inst5Quest14_Aim = "Return to Blackrock Depths and rescue Princess Moira Bronzebeard from the evil clutches of Emperor Dagran Thaurissan."
Inst5Quest14_Location = "King Magni Bronzebeard (Ironforge "..YELLOW.."39,55"..WHITE..")"
Inst5Quest14_Note = "Princess Moira Bronzebeard is at [21]. During the fight she might heal Dagran. Try to interruppt her as often as possible. But be hurry she mustn't die or you can't complete the quest! After talking to her you have to come back to Magni Bronzebeard."
Inst5Quest14_Prequest = "Yes, The Bearer of Bad News"
Inst5Quest14_Folgequest = "Yes, The Princess's Surprise"
Inst5Quest14FQuest = "true"
--
Inst5Quest14name1 = "Magni's Will"
Inst5Quest14name2 = "Songstone of Ironforge"

--QUEST1 Horde

Inst5Quest1_HORDE = "1. Dark Iron Legacy"
Inst5Quest1_HORDE_Attain = "48"
Inst5Quest1_HORDE_Level = "52"
Inst5Quest1_HORDE_Aim = "Slay Fineous Darkvire and recover the great hammer, Ironfel. Take Ironfel to the Shrine of Thaurissan and place it on the statue of Franclorn Forgewright."
Inst5Quest1_HORDE_Location = "Franclorn Forgewright (Blackrock)"
Inst5Quest1_HORDE_Note = "Franclorn is in the middle of the blackrock, above his grave. You have to be dead to see him! Talk 2 times with him to start the quest.\nFineous Darkvire is at [9]. You find the Shrine next to the arena [7]."
Inst5Quest1_HORDE_Prequest = "No"
Inst5Quest1_HORDE_Folgequest = "No"
--
Inst5Quest1name1_HORDE = "Shadowforge Key"

--QUEST2 Horde

Inst5Quest2_HORDE = "2. Ribbly Screwspigot"
Inst5Quest2_HORDE_Attain = "50"
Inst5Quest2_HORDE_Level = "53"
Inst5Quest2_HORDE_Aim = "Bring Ribbly's Head to Yuka Screwspigot in the Burning Steppes."
Inst5Quest2_HORDE_Location = "Yuka Screwspigot (Burning Steppes "..YELLOW.."65,22"..WHITE..")"
Inst5Quest2_HORDE_Note = "You get the prequest from Yorba Screwspigot (Tanaris; 67,23).\nRibbly is at [15]."
Inst5Quest2_HORDE_Prequest = "Yes, Yuka Screwspigot"
Inst5Quest2_HORDE_Folgequest = "No"
Inst5Quest2PreQuest_HORDE = "true"
--
Inst5Quest11name1_HORDE = "Rancor Boots"
Inst5Quest11name2_HORDE = "Penance Spaulders"
Inst5Quest11name3_HORDE = "Splintsteel Armor"

--QUEST3 Horde

Inst5Quest3_HORDE = "3. The Love Potion"
Inst5Quest3_HORDE_Attain = "50"
Inst5Quest3_HORDE_Level = "54"
Inst5Quest3_HORDE_Aim = "Bring 4 Gromsblood, 10 Giant Silver Veins and Nagmara's Filled Vial to Mistress Nagmara in Blackrock Depths."
Inst5Quest3_HORDE_Location = "Nagmara (Blackrock Depths, Tavern)"
Inst5Quest3_HORDE_Note = "You get the Giant Silver Veins from Giants in Azshara, Gromsblood can find a Player with  	Herbalism and you can fill the Vial at the Go-Lakka crater (Un'Goro Crater; 31,50) füllen.\nAfter compliting the quest you can use the backdoor instaed of killing Phalanx."
Inst5Quest3_HORDE_Prequest = "No"
Inst5Quest3_HORDE_Folgequest = "No"
--
Inst5Quest3name1_HORDE = "Manacle Cuffs"
Inst5Quest3name2_HORDE = "Nagmara's Whipping Belt"

--QUEST 4 Horde

Inst5Quest4_HORDE = "4. Lost Thunderbrew Recipe "
Inst5Quest4_HORDE_Attain = "50"
Inst5Quest4_HORDE_Level = "55"
Inst5Quest4_HORDE_Aim = "Bring the Lost Thunderbrew Recipe to Vivian Lagrave in Kargath."
Inst5Quest4_HORDE_Location = "Shadowmage Vivian Lagrave (Badlands - Kargath; "..YELLOW.."2,47"..WHITE..")"
Inst5Quest4_HORDE_Note = "You get the prequest from apothecary Zinge in Undercity(50,68).\nYou get the recipe from one of the guards who appear if you destroy the ale [15]."
Inst5Quest4_HORDE_Prequest = "Yes, Vivian Lagrave"
Inst5Quest4_HORDE_Folgequest = "No"
Inst5Quest4PreQuest_HORDE = "true"
--
Inst5Quest4name1_HORDE = "Superior Healing Potion"
Inst5Quest4name2_HORDE = "Greater Mana Potion"
Inst5Quest4name3_HORDE = "Swiftstrike Cudgel"
Inst5Quest4name4_HORDE = "Limb Cleaver"

--QUEST5 Horde

Inst5Quest5_HORDE = "5. The Heart of the Mountain"
Inst5Quest5_HORDE_Attain = "50"
Inst5Quest5_HORDE_Level = "55"
Inst5Quest5_HORDE_Aim = "Bring the Heart of the Mountain to Maxwort Uberglint in the Burning Steppes."
Inst5Quest5_HORDE_Location = "Maxwort Uberglint (Burning Steppes "..YELLOW.."65,23"..WHITE..")"
Inst5Quest5_HORDE_Note = "You find the Heart at [10] in a safe."
Inst5Quest5_HORDE_Prequest = "No"
Inst5Quest5_HORDE_Folgequest = "No"

--QUEST 6 Horde

Inst5Quest6_HORDE = "6. KILL ON SIGHT: Dark Iron Dwarves"
Inst5Quest6_HORDE_Attain = "48"
Inst5Quest6_HORDE_Level = "52"
Inst5Quest6_HORDE_Aim = "Venture to Blackrock Depths and destroy the vile aggressors! Warlord Goretooth wants you to kill 15 Anvilrage Guardsmen, 10 Anvilrage Wardens and 5 Anvilrage Footmen. Return to him once your task is complete."
Inst5Quest6_HORDE_Location = "Sign post (Badlands - Kargath; "..YELLOW.."3,47"..WHITE..")"
Inst5Quest6_HORDE_Note = "You find the dwarves in the first part of Blackrock Depths.\nYou find Warlord Goretooth in Kargath at the top of the tower(Badlands, 5,47)."
Inst5Quest6_HORDE_Prequest = "No"
Inst5Quest6_HORDE_Folgequest = "Yes, KILL ON SIGHT: High Ranking Dark Iron Officials"

--QUEST 7 Horde

Inst5Quest7_HORDE = "7. KILL ON SIGHT: High Ranking Dark Iron Officials"
Inst5Quest7_HORDE_Attain = "50"
Inst5Quest7_HORDE_Level = "54"
Inst5Quest7_HORDE_Aim = "Venture to Blackrock Depths and destroy the vile aggressors! Warlord Goretooth wants you to kill 10 Anvilrage Medics, 10 Anvilrage Soldiers and 10 Anvilrage Officers. Return to him once your task is complete."
Inst5Quest7_HORDE_Location = "Sign post (Badlands - Kargath; "..YELLOW.."3,47"..WHITE..")"
Inst5Quest7_HORDE_Note = "You find the dwarves near Bael´Gar [11]. You find Warlord Goretooth in Kargath at the top of the tower(Badlands, 5,47).\n The attain quest starts at Lexlort(Kargath; 5,47). You find Gark Lorkrub in the Burning Stepps(38,35). You have the reduce his live below 50% to bind him and start a Escortquest(Elite!)."
Inst5Quest7_HORDE_Prequest = "Yes, KILL ON SIGHT: Dark Iron Dwarves"
Inst5Quest7_HORDE_Folgequest = "Yes, Grark Lorkrub -> Precarious Predicament(Escortquest)"
Inst5Quest7FQuest_HORDE = "true"

--QUEST 8 Horde

Inst5Quest8_HORDE = "8. Operation: Death to Angerforge"
Inst5Quest8_HORDE_Attain = "55"
Inst5Quest8_HORDE_Level = "58"
Inst5Quest8_HORDE_Aim = "Travel to Blackrock Depths and slay General Angerforge! Return to Warlord Goretooth when the task is complete."
Inst5Quest8_HORDE_Location = "Warlord Goretooth (Badlands - Kargath; "..YELLOW.."5,47"..WHITE..")"
Inst5Quest8_HORDE_Note = "You find General Angerforge at [13]. He calls help below 30%!"
Inst5Quest8_HORDE_Prequest = "Yes, Precarious Predicament"
Inst5Quest8_HORDE_Folgequest = "No"
Inst5Quest8FQuest_HORDE = "true"
--
Inst5Quest8name1_HORDE = "Conqueror's Medallion"

--QUEST 5 Horde

Inst5Quest9_HORDE = "9. The Rise of the Machines"
Inst5Quest9_HORDE_Attain = "?"
Inst5Quest9_HORDE_Level = "58"
Inst5Quest9_HORDE_Aim = "Find and slay Golem Lord Argelmach. Return his head to Lotwil. You will also need to collect 10 Intact Elemental Cores from the Ragereaver Golems and Warbringer Constructs protecting Argelmach. You know this because you are psychic."
Inst5Quest9_HORDE_Location = "Lotwil Veriatus (Badlands; "..YELLOW.."25,44"..WHITE..")"
Inst5Quest9_HORDE_Note = "You get the prequest from Hierophant Theodora Mulvadania(Kargath - Badlands; 3,47).\nYou find Argelmach at [14]."
Inst5Quest9_HORDE_Prequest = "Yes, The Rise of the Machines"
Inst5Quest9_HORDE_Folgequest = "No"
Inst5Quest9PreQuest_HORDE = "true"
--
Inst5Quest9name1_HORDE = "Azure Moon Amice"
Inst5Quest9name2_HORDE = "Raincaster Drape"
Inst5Quest9name3_HORDE = "Basaltscale Armor"
Inst5Quest9name4_HORDE = "Lavaplate Gauntlets"


--QUEST13 Horde

Inst5Quest10_HORDE = "10. A Taste of Flame (Questline)"
Inst5Quest10_HORDE_Attain = "52"
Inst5Quest10_HORDE_Level = "58"
Inst5Quest10_HORDE_Aim = "Travel to Blackrock Depths and slay Bael'Gar. [...] Return the Encased Fiery Essence to Cyrus Therepentous."
Inst5Quest10_HORDE_Location = "Cyrus Therepentous (Burning Steppes "..YELLOW.."94,31"..WHITE..")"
Inst5Quest10_HORDE_Note = "The questline starts at Kalaran Windblade (Sengende Schlucht; 39,38).\nBael'Gar is at [11]."
Inst5Quest10_HORDE_Prequest = "Yes, The Flawless Flame -> A Taste of Flame"
Inst5Quest10_HORDE_Folgequest = "No"
Inst5Quest10PreQuest_HORDE = "true"
--
Inst5Quest10name1_HORDE = "Shaleskin Cape"
Inst5Quest10name2_HORDE = "Wyrmhide Spaulders"
Inst5Quest10name3_HORDE = "Valconian Sash"

--QUEST 11 Horde

Inst5Quest11_HORDE = "11. Disharmony of Fire"
Inst5Quest11_HORDE_Attain = "?"
Inst5Quest11_HORDE_Level = "56"
Inst5Quest11_HORDE_Aim = "Enter Blackrock Depths and track down Lord Incendius. Slay him and return any source of information you may find to Thunderheart."
Inst5Quest11_HORDE_Location = "Thunderheart (Badlands - Kargath; "..YELLOW.."3,48"..WHITE..")"
Inst5Quest11_HORDE_Note = "You get the prequest from Thunderheart, too. Pyron is just before the instance portal.\nYou find Lord Incendius at [10]."
Inst5Quest11_HORDE_Prequest = "Yes, Disharmony of Flame"
Inst5Quest11_HORDE_Folgequest = "No"
Inst5Quest11PreQuest_HORDE = "true"
--
Inst5Quest11name1_HORDE = "Sunborne Cape"
Inst5Quest11name2_HORDE = "Nightfall Gloves"
Inst5Quest11name3_HORDE = "Crypt Demon Bracers"
Inst5Quest11name4_HORDE = "Stalwart Clutch"

--QUEST 12 Horde

Inst5Quest12_HORDE = "12. The Last Element"
Inst5Quest12_HORDE_Attain = "?"
Inst5Quest12_HORDE_Level = "54"
Inst5Quest12_HORDE_Aim = "Travel to Blackrock Depths and recover 10 Essence of the Elements. Your first inclination is to search the golems and golem makers. You remember Vivian Lagrave also muttering something about elementals."
Inst5Quest12_HORDE_Location = "Shadowmage Vivian Lagrave (Badlands - Kargath; "..YELLOW.."2,47"..WHITE..")"
Inst5Quest12_HORDE_Note = "You get the prequest from Thunderheart (Badlands - Kargath; "..YELLOW.."3,48"..WHITE.."). Pyron is just before the instance portal.\n Every elemental drop the Essence"
Inst5Quest12_HORDE_Prequest = "Yes, Disharmony of Flame"
Inst5Quest12_HORDE_Folgequest = "No"
Inst5Quest12PreQuest_HORDE = "true"
--
Inst5Quest12name1_HORDE = "Lagrave's Seal"

--QUEST 8 Horde

Inst5Quest13_HORDE = "13. Commander Gor'shak"
Inst5Quest13_HORDE_Attain = "?"
Inst5Quest13_HORDE_Level = "52"
Inst5Quest13_HORDE_Aim = "Find Commander Gor'shak in Blackrock Depths.\nYou recall that the crudely drawn picture of the orc included bars drawn over the portrait. Perhaps you should search for a prison of some sort."
Inst5Quest13_HORDE_Location = "Galamav the Marksman (Badlands - Kargath; "..YELLOW.."5,47"..WHITE..")"
Inst5Quest13_HORDE_Note = "You get the prequest from Thunderheart (Badlands - Kargath; "..YELLOW.."3,48"..WHITE.."). Pyron is just before the instance portal.\nYou find Commander Gor'shak at [3]. The key to open the prison dropps Gerstahn[5]. If you talk to him and start the next Quest enemys appears."
Inst5Quest13_HORDE_Prequest = "Yes, Disharmony of Flame"
Inst5Quest13_HORDE_Folgequest = "Yes, What Is Going On?(Event)"
Inst5Quest13PreQuest_HORDE = "true"


--QUEST14 Horde

Inst5Quest14_HORDE = "14. The Royal Rescue"
Inst5Quest14_HORDE_Attain = "51"
Inst5Quest14_HORDE_Level = "59"
Inst5Quest14_HORDE_Aim = "Slay Emperor Dagran Thaurissan and free Princess Moira Bronzebeard from his evil spell."
Inst5Quest14_HORDE_Location = "Thrall (Orgrimmar; "..YELLOW.."31,37"..WHITE..")"
Inst5Quest14_HORDE_Note = "After talking a with Kharan Mighthammer and Thrall you get this quest.\nYou find Emperor Dagran Thaurissan at [21]. The princess heals Dagran but you musstn't kill her to complete the quest! Try to interrupt her healing spells. (Rewards are for The Princess Saved?)"
Inst5Quest14_HORDE_Prequest = "Yes, Commander Gor'shak"
Inst5Quest14_HORDE_Folgequest = "Yes, The Princess Saved?"
Inst5Quest14FQuest_HORDE = "true"
--
Inst5Quest14name1_HORDE = "Thrall's Resolve"
Inst5Quest14name2_HORDE = "Eye of Orgrimmar"



--------------Inst8 / lower blackrock spier ------------
Inst8Story = "The mighty fortress carved within the fiery bowels of Blackrock Mountain was designed by the master dwarf-mason, Franclorn Forgewright. Intended to be the symbol of Dark Iron power, the fortress was held by the sinister dwarves for centuries. However, Nefarian - the cunning son of the dragon, Deathwing - had other plans for the great keep. He and his draconic minions took control of the upper Spire and made war on the dwarves' holdings in the mountain's volcanic depths. Realizing that the dwarves were led by the mighty fire elemental, Ragnaros - Nefarian vowed to crush his enemies and claim the whole of Blackrock mountain for himself."
Inst8Caption = "Blackrock Spire"

--------------Inst9 / lower blackrock spier ------------
Inst9Story = "The mighty fortress carved within the fiery bowels of Blackrock Mountain was designed by the master dwarf-mason, Franclorn Forgewright. Intended to be the symbol of Dark Iron power, the fortress was held by the sinister dwarves for centuries. However, Nefarian - the cunning son of the dragon, Deathwing - had other plans for the great keep. He and his draconic minions took control of the upper Spire and made war on the dwarves' holdings in the mountain's volcanic depths. Realizing that the dwarves were led by the mighty fire elemental, Ragnaros - Nefarian vowed to crush his enemies and claim the whole of Blackrock mountain for himself."
Inst9Caption = "Blackrock Spire"

--------------Dire Maul East/ Inst10------------
Inst10Story = "Built twelve thousand years ago by a covert sect of night elf sorcerers, the ancient city of Eldre'Thalas was used to protect Queen Azshara's most prized arcane secrets. Though it was ravaged by the Great Sundering of the world, much of the wondrous city still stands as the imposing Dire Maul. The ruins' three distinct districts have been overrun by all manner of creatures - especially the spectral highborne, foul satyr and brutish ogres. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults."
Inst10Caption = "Dire Maul"

--------------Dire Maul North/ Inst11------------
Inst11Story = "Built twelve thousand years ago by a covert sect of night elf sorcerers, the ancient city of Eldre'Thalas was used to protect Queen Azshara's most prized arcane secrets. Though it was ravaged by the Great Sundering of the world, much of the wondrous city still stands as the imposing Dire Maul. The ruins' three distinct districts have been overrun by all manner of creatures - especially the spectral highborne, foul satyr and brutish ogres. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults."
Inst11Caption = "Dire Maul"

--------------Dire Maul West/ Inst12------------
Inst12Story = "Built twelve thousand years ago by a covert sect of night elf sorcerers, the ancient city of Eldre'Thalas was used to protect Queen Azshara's most prized arcane secrets. Though it was ravaged by the Great Sundering of the world, much of the wondrous city still stands as the imposing Dire Maul. The ruins' three distinct districts have been overrun by all manner of creatures - especially the spectral highborne, foul satyr and brutish ogres. Only the most daring party of adventurers can enter this broken city and face the ancient evils locked within its ancient vaults."
Inst12Caption = "Dire Maul"

--------------Inst13/Maraudon------------
Inst13Story = "Protected by the fierce Maraudine centaur, Maraudon is one of the most sacred sites within Desolace. The great temple/cavern is the burial place of Zaetar, one of two immortal sons born to the demigod, Cenarius. Legend holds that Zaetar and the earth elemental princess, Theradras, sired the misbegotten centaur race. It is said that upon their emergence, the barbaric centaur turned on their father and killed him. Some believe that Theradras, in her grief, trapped Zaetar's spirit within the winding cavern - used its energies for some malign purpose. The subterranean tunnels are populated by the vicious, long-dead ghosts of the Centaur Khans, as well as Theradras' own raging, elemental minions."
Inst13Caption = "Maraudon"

--------------Inst22/Stratholme------------
Inst22Story = "Once the jewel of northern Lordaeron, the city of Stratholme is where Prince Arthas turned against his mentor, Uther Lightbringer, and slaughtered hundreds of his own subjects who were believed to have contracted the dreaded plague of undeath. Arthas' downward spiral and ultimate surrender to the Lich King soon followed. The broken city is now inhabited by the undead Scourge - led by the powerful lich, Kel'thuzad. A contingent of Scarlet Crusaders, led by Grand Crusader Dathrohan, also holds a portion of the ravaged city. The two sides are locked in constant, violent combat. Those adventurers brave (or foolish) enough to enter Stratholme will be forced to contend with both factions before long. It is said that the city is guarded by three massive watchtowers, as well as powerful necromancers, banshees and abominations. There have also been reports of a malefic Death Knight riding atop an unholy steed - dispensing indiscriminate wrath on all those who venture within the realm of the Scourge."
Inst22Caption = "Stratholme"

--------------Inst29/Gnomeregan------------
Inst29Story = "Located in Dun Morogh, the technological wonder known as Gnomeregan has been the gnomes' capital city for generations. Recently, a hostile race of mutant troggs infested several regions of Dun Morogh - including the great gnome city. In a desperate attempt to destroy the invading troggs, High Tinker Mekkatorque ordered the emergency venting of the city's radioactive waste tanks. Several gnomes sought shelter from the airborne pollutants as they waited for the troggs to die or flee. Unfortunately, though the troggs became irradiated from the toxic assault - their siege continued, unabated. Those gnomes who were not killed by noxious seepage were forced to flee, seeking refuge in the nearby dwarven city of Ironforge. There, High Tinker Mekkatorque set out to enlist brave souls to help his people reclaim their beloved city. It is rumored that Mekkatorque's once-trusted advisor, Mekgineer Thermaplugg, betrayed his people by allowing the invasion to happen. Now, his sanity shattered, Thermaplug remains in Gnomeregan - furthering his dark schemes and acting as the city's new techno-overlord."
Inst29Caption = "Gnomeregan"

------------------------------------------------------------------------------------------------------
------------------------------------------------- RAID -----------------------------------------------
------------------------------------------------------------------------------------------------------

--------------Inst30/Alptraumdrachen------------
Inst30Story = "There is a disturbance at the Great Trees. A new threat menaces these secluded areas found in Ashenvale, Duskwood, Feralas, and Hinterlands. Four great guardians of the Green Dragonflight have arrived from the Dream, but these once-proud protectors now seek only destruction and death. Take arms with your fellows and march to these hidden groves -- only you can defend Azeroth from the corruption they bring."
Inst30Caption = "Dragons of Nightmare"
Inst30Caption1 = "Ysera and the Green Dragonflight"
Inst30Caption2 = "Lethon"
Inst30Caption3 = "Emeriss"
Inst30Caption4 = "Taerar"
Inst30Caption5 = "Ysondre"

Inst30Story1 = "Ysera, the great Dreaming dragon Aspect rules over the enigmatic green dragonflight. Her domain is the fantastic, mystical realm of the Emerald Dream - and it is said that from there she guides the evolutionary path of the world itself. She is the protector of nature and imagination, and it is the charge of her flight to guard all of the Great Trees across the world, which only druids use to enter the Dream itself.In recent times, Ysera's most trusted lieutenants have been warped by a dark new power within the Emerald Dream. Now these wayward sentinels have passed through the Great Trees into Azeroth, intending to spread madness and terror throughout the mortal kingdoms. Even the mightiest of adventurers would be well advised to give the dragons a wide berth, or suffer the consequences of their misguided wrath. "
Inst30Story2 = "Lethon's exposure to the aberration within the Emerald Dream not only darkened the hue of the mighty dragon's scales, but also empowered him with the ability to extract malevolent shades from his enemies. Once joined with their master, the shades imbue the dragon with healing energies. It should come as no surprise, then, that Lethon is considered to be among the most formidable of Ysera's wayward lieutenants"
Inst30Story3 = "A  mysterious dark power within the Emerald Dream has transformed the once-majestic Emeriss into a rotting, diseased monstrosity. Reports from the few who have survived encounters with the dragon have told horrifying tales of putrid mushrooms erupting from the corpses of their dead companions. Emeriss is truly the most gruesome and appalling of Ysera's estranged green dragons."
Inst30Story4 = "Taerar was perhaps the most affected of Ysera's rogue lieutenants. His interaction with the dark force within the Emerald Dream shattered Taerar's sanity as well as his corporeal form. The dragon now exists as a specter with the ability to split into multiple entities, each of which possesses destructive magical powers. Taerar is a cunning and relentless foe who is intent on turning the madness of his existence into reality for the inhabitants of Azeroth."
Inst30Story5 = "Once one of Ysera's most trusted lieutenants, Ysondre has now gone rogue, sewing terror and chaos across the land of Azeroth. Her formerly beneficent healing powers have given way to dark magics, enabling her to cast smoldering lightning waves and summon the aid of fiendish druids. Ysondre and her kin also possess the ability to induce sleep, sending her unfortunate mortal foes to the realm of their most terrifying nightmares."

Inst30Quest1 = ""
Inst30Quest1_Attain = ""
Inst30Quest1_Level = "100"
Inst30Quest1_Aim = ""
Inst30Quest1_Location = ""
Inst30Quest1_Note = ""
Inst30Quest1_Prequest = ""
Inst30Quest1_Folgequest = ""

--QUEST 1 Horde

Inst30Quest1_HORDE = ""
Inst30Quest1_HORDE_Attain = ""
Inst30Quest1_HORDE_Level = "100"
Inst30Quest1_HORDE_Aim = ""
Inst30Quest1_HORDE_Location = ""
Inst30Quest1_HORDE_Note = ""
Inst30Quest1_HORDE_Prequest = ""
Inst30Quest1_HORDE_Folgequest = ""

Inst30Quest2 = ""
Inst30Quest2_Attain = ""
Inst30Quest2_Level = "100"
Inst30Quest2_Aim = ""
Inst30Quest2_Location = ""
Inst30Quest2_Note = ""
Inst30Quest2_Prequest = ""
Inst30Quest2_Folgequest = ""

--QUEST 2 Horde

Inst30Quest2_HORDE = ""
Inst30Quest2_HORDE_Attain = ""
Inst30Quest2_HORDE_Level = "100"
Inst30Quest2_HORDE_Aim = ""
Inst30Quest2_HORDE_Location = ""
Inst30Quest2_HORDE_Note = ""
Inst30Quest2_HORDE_Prequest = ""
Inst30Quest2_HORDE_Folgequest = ""

Inst30Quest3 = ""
Inst30Quest3_Attain = ""
Inst30Quest3_Level = "100"
Inst30Quest3_Aim = ""
Inst30Quest3_Location = ""
Inst30Quest3_Note = ""
Inst30Quest3_Prequest = ""
Inst30Quest3_Folgequest = ""

--QUEST 3 Horde

Inst30Quest3_HORDE = ""
Inst30Quest3_HORDE_Attain = ""
Inst30Quest3_HORDE_Level = "100"
Inst30Quest3_HORDE_Aim = ""
Inst30Quest3_HORDE_Location = ""
Inst30Quest3_HORDE_Note = ""
Inst30Quest3_HORDE_Prequest = ""
Inst30Quest3_HORDE_Folgequest = ""

Inst30Quest4 = ""
Inst30Quest4_Attain = ""
Inst30Quest4_Level = "100"
Inst30Quest4_Aim = ""
Inst30Quest4_Location = ""
Inst30Quest4_Note = ""
Inst30Quest4_Prequest = ""
Inst30Quest4_Folgequest = ""

--QUEST 4 Horde

Inst30Quest4_HORDE = ""
Inst30Quest4_HORDE_Attain = ""
Inst30Quest4_HORDE_Level = "100"
Inst30Quest4_HORDE_Aim = ""
Inst30Quest4_HORDE_Location = ""
Inst30Quest4_HORDE_Note = ""
Inst30Quest4_HORDE_Prequest = ""
Inst30Quest4_HORDE_Folgequest = ""

--------------Azuregos------------
Inst31Story = "Before the Great Sundering, the night elf city of Eldarath flourished in the land that is now known as Azshara. It is believed that many ancient and powerful Highborne artifacts may be found among the ruins of the once-mighty stronghold. For countless generations, the Blue Dragon Flight has safeguarded powerful artifacts and magical lore, ensuring that they do not fall into mortal hands. The presence of Azuregos, the blue dragon, seems to suggest that items of extreme significance, perhaps the fabled Vials of Eternity themselves, may be found in the wilderness of Azshara. Whatever Azuregos seeks, one thing is certain: he will fight to the death to defend Azshara's magical treasures."
Inst31Caption = "Azuregos"

--------------Kazzak------------
Inst32Story = "Following the defeat of the Burning Legion at the end of the Third War, the remaining enemy forces, led by the colossal demon Lord Kazzak, pulled back to the Blasted Lands. They continue to dwell there to this day in an area called the Tainted Scar, awaiting the reopening of the Dark Portal. It is rumored that once the Portal is reopened, Kazzak will travel with his remaining forces to Outland. Once the orc homeworld of Draenor, Outland was ripped apart by the simultaneous activation of several portals created by the orc shaman Ner'zhul, and now exists as a shattered world occupied by legions of demonic agents under command of the night elf betrayer, Illidan."
Inst32Caption = "Lord Kazzak"

--------------Inst14/geschmolzener Kern------------
Inst14Story = "The Molten Core lies at the very bottom of Blackrock Depths. It is the heart of Blackrock Mountain and the exact spot where, long ago in a desperate bid to turn the tide of the dwarven civil war, Emperor Thaurissan summoned the elemental Firelord, Ragnaros, into the world. Though the fire lord is incapable of straying far from the blazing Core, it is believed that his elemental minions command the Dark Iron dwarves, who are in the midst of creating armies out of living stone. The burning lake where Ragnaros lies sleeping acts as a rift connecting to the plane of fire, allowing the malicious elementals to pass through. Chief among Ragnaros' agents is Majordomo Executus - for this cunning elemental is the only one capable of calling the Firelord from his slumber."
Inst14Caption = "Molten Core"

--------------Inst16/Onyxia------------
Inst16Story = "Onyxia is the daughter of the mighty dragon Deathwing, and sister of the scheming Nefarion Lord of Blackrock Spire. It is said that Onyxia delights in corrupting the mortal races by meddling in their political affairs. To this end it is believed that she takes on various humanoid forms and uses her charm and power to influence delicate matters between the different races. Some believe that Onyxia has even assumed an alias once used by her father - the title of the royal House Prestor. When not meddling in mortal concerns, Onyxia resides in a fiery cave below the Dragonmurk, a dismal swamp located within Dustwallow Marsh. There she is guarded by her kin, the remaining members of the insidious Black Dragon Flight."
Inst16Caption = "Onyxias Lair"

--------------Inst6------------
Inst6Story = "Blackwing Lair can be found at the very height of Blackrock Spire. It is there in the dark recesses of the mountain's peak that Nefarian has begun to unfold the final stages of his plan to destroy Ragnaros once and for all and lead his army to undisputed supremacy over all the races of Azeroth."
Inst6Caption = "Blackwing Lair"
Inst6Caption1 = "Blackwing Lair (Story Part 1)"
Inst6Caption2 = "Blackwing Lair (Story Part 2)"

Inst6Story1 = "The mighty fortress carved within the fiery bowels of Blackrock Mountain was designed by the master dwarf-mason, Franclorn Forgewright. Intended to be the symbol of Dark Iron power, the fortress was held by the sinister dwarves for centuries. However, Nefarian - the cunning son of the dragon, Deathwing - had other plans for the great keep. He and his draconic minions took control of the upper Spire and made war on the dwarves' holdings in the mountain's volcanic depths, which serve as the seat of power for Ragnaros the Firelord. Ragnaros has uncovered the secret to creating life from stone and plans to build an army of unstoppable golems to aid him in conquering the whole of Blackrock Mountain."
Inst6Story2 = "Nefarian has vowed to crush Ragnaros. To this end, he has recently begun efforts to bolster his forces, much as his father Deathwing had attempted to do in ages past. However, where Deathwing failed, it now seems the scheming Nefarian may be succeeding. Nefarian's mad bid for dominance has even attracted the ire of the Red Dragon Flight, which has always been the Black Flight's greatest foe. Though Nefarian's intentions are known, the methods he is using to achieve them remain a mystery. It is believed, however that Nefarian has been experimenting with the blood of all of the various Dragon Flights to produce unstoppable warriors.\n \nNefarian's sanctum, Blackwing Lair, can be found at the very height of Blackrock Spire. It is there in the dark recesses of the mountain's peak that Nefarian has begun to unfold the final stages of his plan to destroy Ragnaros once and for all and lead his army to undisputed supremacy over all the races of Azeroth."

Inst6Quest1 = ""
Inst6Quest1_Attain = ""
Inst6Quest1_Level = "100"
Inst6Quest1_Aim = ""
Inst6Quest1_Location = ""
Inst6Quest1_Note = ""
Inst6Quest1_Prequest = ""
Inst6Quest1_Folgequest = ""

Inst6Quest1_HORDE = ""
Inst6Quest1_HORDE_Attain = ""
Inst6Quest1_HORDE_Level = "100"
Inst6Quest1_HORDE_Aim = ""
Inst6Quest1_HORDE_Location = ""
Inst6Quest1_HORDE_Note = ""
Inst6Quest1_HORDE_Prequest = ""
Inst6Quest1_HORDE_Folgequest = ""

Inst6Quest2 = ""
Inst6Quest2_Attain = ""
Inst6Quest2_Level = "100"
Inst6Quest2_Aim = ""
Inst6Quest2_Location = ""
Inst6Quest2_Note = ""
Inst6Quest2_Prequest = ""
Inst6Quest2_Folgequest = ""

Inst6Quest2_HORDE = ""
Inst6Quest2_HORDE_Attain = ""
Inst6Quest2_HORDE_Level = "100"
Inst6Quest2_HORDE_Aim = ""
Inst6Quest2_HORDE_Location = ""
Inst6Quest2_HORDE_Note = ""
Inst6Quest2_HORDE_Prequest = ""
Inst6Quest2_HORDE_Folgequest = ""

--------------Inst23------------
Inst23Story = "During the final hours of the War of the Shifting Sands, the combined forces of the night elves and the four dragonflights drove the battle to the very heart of the qiraji empire, to the fortress city of Ahn'Qiraj. Yet at the city gates, the armies of Kalimdor encountered a concentration of silithid war drones more massive than any they had encountered before. Ultimately the silithid and their qiraji masters were not defeated, but merely imprisoned inside a magical barrier, and the war left the cursed city in ruins. A thousand years have passed since that day, but the qiraji forces have not been idle. A new and terrible army has been spawned from the hives, and the ruins of Ahn'Qiraj are teeming once again with swarming masses of silithid and qiraji. This threat must be eliminated, or else all of Azeroth may fall before the terrifying might of the new qiraji army."
Inst23Caption = "Ruins of Ahn'Qiraj"

--------------Inst26------------
Inst26Story = "At the heart of Ahn'Qiraj lies an ancient temple complex. Built in the time before recorded history, it is both a monument to unspeakable gods and a massive breeding ground for the qiraji army. Since the War of the Shifting Sands ended a thousand years ago, the Twin Emperors of the qiraji empire have been trapped inside their temple, barely contained behind the magical barrier erected by the bronze dragon Anachronos and the night elves. Now that the Scepter of the Shifting Sands has been reassembled and the seal has been broken, the way into the inner sanctum of Ahn'Qiraj is open. Beyond the crawling madness of the hives, beneath the Temple of Ahn'Qiraj, legions of qiraji prepare for invasion. They must be stopped at all costs before they can unleash their voracious insectoid armies on Kalimdor once again, and a second War of the Shifting Sands breaks loose!"
Inst26Caption = "Temple of Ahn'Qiraj"

--------------Inst28------------
Inst28Story = "Over a thousand years ago the powerful Gurubashi Empire was torn apart by a massive civil war. An influential group of troll priests, known as the Atal'ai, called forth the avatar of an ancient and terrible blood god named Hakkar the Soulflayer. Though the priests were defeated and ultimately exiled, the great troll empire collapsed upon itself. The exiled priests fled far to the north, into the Swamp of Sorrows, where they erected a great temple to Hakkar in order to prepare for his arrival into the physical world."

Inst28Story1 = "In time, the Atal'ai priests discovered that Hakkar's physical form could only be summoned within the ancient capital of the Gurubashi Empire, Zul'Gurub. Unfortunately, the priests have met with recent success in their quest to call forth Hakkar -- reports confirm the presence of the dreaded Soulflayer in the heart of the Gurubashi ruins.\n \nIn order to quell the blood god, the trolls of the land banded together and sent a contingent of High Priests into the ancient city. Each priest was a powerful champion of the Primal Gods -- Bat, Panther, Tiger, Spider, and Snake -- but despite their best efforts, they fell under the sway of Hakkar. Now the champions and their Primal God aspects feed the awesome power of the Soulflayer. Any adventurers brave enough to venture into the foreboding ruins must overcome the High Priests if they are to have any hope of confronting the mighty blood god."
Inst28Caption = "Zul'Gurub"
Inst28Caption1 = "Zul'Gurub (Story)"

Inst28Quest1 = ""
Inst28Quest1_Attain = ""
Inst28Quest1_Level = "100"
Inst28Quest1_Aim = ""
Inst28Quest1_Location = ""
Inst28Quest1_Note = ""
Inst28Quest1_Prequest = ""
Inst28Quest1_Folgequest = ""

--QUEST 1 Horde

Inst28Quest1_HORDE = ""
Inst28Quest1_HORDE_Attain = ""
Inst28Quest1_HORDE_Level = "100"
Inst28Quest1_HORDE_Aim = ""
Inst28Quest1_HORDE_Location = ""
Inst28Quest1_HORDE_Note = ""
Inst28Quest1_HORDE_Prequest = ""
Inst28Quest1_HORDE_Folgequest = ""


--------------Inst15 /Naxxramas------------
Inst15Story = "Floating above the Plaguelands, the necropolis known as Naxxramas serves as the seat of one of the Lich King's most powerful officers, the dreaded lich Kel'Thuzad. Horrors of the past and new terrors yet to be unleashed are gathering inside the necropolis as the Lich King's servants prepare their assault. Soon the Scourge will march again..."
Inst15Caption = "Naxxramas"

--------------Inst33 / Alterac Vally------------
Inst33Story = "Long ago, before the First War, the warlock Gul'dan exiled a clan of orcs called the Frostwolves to a hidden valley deep in the heart of the Alterac Mountains. It is here in the valley's southern reaches that the Frostwolves eked out a living until the coming of Thrall.\nAfter Thrall's triumphant uniting of the clans, the Frostwolves, now led by the Orc Shaman Drek'Thar, chose to remain in the valley they had for so long called their home. In recent times, however, the relative peace of the Frostwolves has been challenged by the arrival of the Dwarven Stormpike Expedition.\nThe Stormpikes have set up residence in the valley to search for natural resources and ancient relics. Despite their intentions, the Dwarven presence has sparked heated conflict with the Frostwolf Orcs to the south, who have vowed to drive the interlopers from their lands. "
Inst33Caption = "Alterac Vally"

--------------Inst34 / Arathi Basin------------
Inst34Story = "Arathi Basin, located in Arathi Highlands, is a fast and exciting Battleground. The Basin itself is rich with resources and coveted by both the Horde and the Alliance. The Forsaken Defilers and the League of Arathor have arrived at Arathi Basin to wage war over these natural resources and claim them on behalf of their respective sides."
Inst34Caption = "Arathi Basin"

--------------Inst35 / Warsong Gulch------------
Inst35Story = "Nestled in the southern region of Ashenvale forest, Warsong Gulch is near the area where Grom Hellscream and his Orcs chopped away huge swaths of forest during the events of the Third War. Some orcs have remained in the vicinity, continuing their deforestation to fuel the Horde's expansion. They call themselves the Warsong Outriders.\nThe Night Elves, who have begun a massive push to retake the forests of Ashenvale, are now focusing their attention on ridding their land of the Outriders once and for all. And so, the Silverwing Sentinels have answered the call and sworn that they will not rest until every last Orc is defeated and cast out of Warsong Gulch. "
Inst35Caption = "Warsong Gulch"

end

--    AQINSTANZ :
-- 1  = VC     21 = BSF
-- 2  = WC     22 = STRAT
-- 3  = RFA    23 = AQ20
-- 4  = ULD    24 = STOCKADE
-- 5  = BRD    25 = TEMPLE
-- 6  = BWl    26 = AQ40
-- 7  = BFD    27 = ZUL
-- 8  = LBRS   28 = ZG
-- 9  = UBRS   29 = GNOMERE
-- 10 = DME    30 = DRAGONS
-- 11 = DMN    31 = AZUREGOS
-- 12 = DMW    32 = KAZZAK
-- 13 = MARA   33 = AV
-- 14 = MC     34 = AB
-- 15 = NAXX   35 = WS
-- 16 = ONY    36 = REST
-- 17 = HUEGEL
-- 18 = KRAL
-- 19 = KLOSTER
-- 20 = SCHOLO