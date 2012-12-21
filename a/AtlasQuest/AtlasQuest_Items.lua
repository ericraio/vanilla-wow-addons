--**********************************************************
--* Here i store every information about the Questrewards  *
--*(expect the name).                                      *
--* Informations stored: Rewards(Yes/NO)                   *
--* Itemcolor(grey, white, green, blue, purple, red),      *
--* Itemtextur(where is the pic saved), ItemID             *
--* and a link(translation issue) to the Item description  *
--**********************************************************

--Color
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local RED = "|cffff0000";

-- Item Color
local Itemc1 = "|cff9d9d9d" --grey
local Itemc2 = "|cffFFFFFF" --white
local Itemc3 = "|cff1eff00" --green
local Itemc4 = "|cff0070dd" --blue
local Itemc5 = "|cffa335ee" --purple
local Itemc6 = "|cffFF8000" --orange
local Itemc7 = "|cffFF0000" --red
--
local Itemc8 = "|cffFFd200" --ingame yellow


------------------------------- VC/Inst 1 --------------------------------------------------------------------
-----------Quest1 A
Inst1Quest1Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst1Quest1ITC1 = Itemc3;
Inst1Quest1textur1 = "INV_Sword_23"
Inst1Quest1description1 = AQITEM_ONEHAND..AQITEM_SWORD
Inst1Quest1ID1 = "2074"
--ITEM2
Inst1Quest1ITC2 = Itemc3;
Inst1Quest1textur2 = "INV_Weapon_ShortBlade_01"
Inst1Quest1description2 = AQITEM_ONEHAND..AQITEM_DAGGER
Inst1Quest1ID2 = "2089"
--ITEM3
Inst1Quest1ITC3 = Itemc3;
Inst1Quest1textur3 = "INV_ThrowingAxe_01"
Inst1Quest1description3 = AQITEM_TWOHAND..AQITEM_AXE
Inst1Quest1ID3 = "6094"

-----------Quest2 A
Inst1Quest2Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst1Quest2ITC1 = Itemc3;
Inst1Quest2textur1 = "INV_Boots_01"
Inst1Quest2description1 = AQITEM_FEET..AQITEM_MAIL
Inst1Quest2ID1 = "2037"
--ITEM2
Inst1Quest2ITC2 = Itemc3;
Inst1Quest2textur2 = "INV_Gauntlets_05"
Inst1Quest2description2 = AQITEM_HANDS..AQITEM_LEATHER
Inst1Quest2ID2 = "2036"

-----------Quest3 A
Inst1Quest3Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst1Quest3ITC1 = Itemc3;
Inst1Quest3textur1 = "INV_Pick_03"
Inst1Quest3description1 = AQITEM_TWOHAND..AQITEM_AXE
Inst1Quest3ID1 = "1893"

-----------Quest4 A
Inst1Quest4Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst1Quest4ITC1 = Itemc3;
Inst1Quest4textur1 = "INV_Gauntlets_04"
Inst1Quest4description1 = AQITEM_HANDS..AQITEM_MAIL
Inst1Quest4ID1 = "7606"
--ITEM2
Inst1Quest4ITC2 = Itemc3;
Inst1Quest4textur2 = "INV_Staff_02"
Inst1Quest4description2 = AQITEM_WAND
Inst1Quest4ID2 = "7607"

-----------Quest5 A
Inst1Quest5Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst1Quest5ITC1 = Itemc4;
Inst1Quest5textur1 = "INV_Pants_03"
Inst1Quest5description1 = AQITEM_LEGS..AQITEM_MAIL
Inst1Quest5ID1 = "6087"
--ITEM2
Inst1Quest5ITC2 = Itemc4;
Inst1Quest5textur2 = "INV_Chest_Leather_07"
Inst1Quest5description2 = AQITEM_CHEST..AQITEM_LEATHER
Inst1Quest5ID2 = "2041"
--ITEM3
Inst1Quest5ITC3 = Itemc4;
Inst1Quest5textur3 = "INV_Staff_10"
Inst1Quest5description3 = AQITEM_STAFF
Inst1Quest5ID3 = "2042"

-----------Quest6 A
Inst1Quest6Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst1Quest6ITC1 = Itemc4;
Inst1Quest6textur1 = "INV_Hammer_05"
Inst1Quest6description1 = AQITEM_TWOHAND..AQITEM_MACE
Inst1Quest6ID1 = "6953"

------------------------------- WC/Inst 2 --------------------------------------------------------------------
-----------Quest1 A
Inst2Quest1Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst2Quest1ITC1 = Itemc3;
Inst2Quest1textur1 = "INV_Pants_02"
Inst2Quest1description1 = AQITEM_LEGS..AQITEM_LEATHER
Inst2Quest1ID1 = "6480"
--ITEM2
Inst2Quest1ITC2 = Itemc2;
Inst2Quest1textur2 = "INV_Misc_Bag_07_Black"
Inst2Quest1description2 = AQITEM_BAG
Inst2Quest1ID2 = "918"

-----------Quest2 A
Inst2Quest2Rewardtext = RED..AQNoReward

-----------Quest3 A
Inst2Quest3Rewardtext = RED..AQNoReward

-----------Quest4 A
Inst2Quest4Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst2Quest4ITC1 = Itemc3;
Inst2Quest4textur1 = "INV_Scroll_06"
Inst2Quest4description1 = AQITEM_PATTERN
Inst2Quest4ID1 = "6476"
--ITEM2
Inst2Quest4ITC2 = Itemc3;
Inst2Quest4textur2 = "INV_Staff_02"
Inst2Quest4description2 = AQITEM_WAND
Inst2Quest4ID2 = "8071"
--ITEM3
Inst2Quest4ITC3 = Itemc3;
Inst2Quest4textur3 = "INV_Gauntlets_05"
Inst2Quest4description3 = AQITEM_HANDS..AQITEM_MAIL
Inst2Quest4ID3 = "6481"

-----------Quest5 A
Inst2Quest5Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst2Quest5ITC1 = Itemc3;
Inst2Quest5textur1 = "INV_Shoulder_09"
Inst2Quest5description1 = AQITEM_SHOULDER..AQITEM_CLOTH
Inst2Quest5ID1 = "10657"
--ITEM2
Inst2Quest5ITC2 = Itemc3;
Inst2Quest5textur2 = "INV_Boots_07"
Inst2Quest5description2 = AQITEM_FEET..AQITEM_MAIL
Inst2Quest5ID2 = "10658"

---------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
---------------------------------------

-----------Quest1 H
Inst2Quest1Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst2Quest1ITC1_HORDE = Itemc3;
Inst2Quest1textur1_HORDE = "INV_Pants_02"
Inst2Quest1description1_HORDE = AQITEM_LEGS..AQITEM_LEATHER
Inst2Quest1ID1_HORDE = "6480"
--ITEM2
Inst2Quest1ITC2_HORDE = Itemc2;
Inst2Quest1textur2_HORDE = "INV_Misc_Bag_07_Black"
Inst2Quest1description2_HORDE = AQITEM_BAG
Inst2Quest1ID2_HORDE = "918"

-----------Quest2 H
Inst2Quest2Rewardtext_HORDE = RED..AQNoReward

-----------Quest3 H
Inst2Quest3Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst2Quest3ITC1_HORDE = Itemc3;
Inst2Quest3textur1_HORDE = "INV_Gauntlets_06"
Inst2Quest3description1_HORDE = AQITEM_HANDS..AQITEM_CLOTH
Inst2Quest3ID1_HORDE = "10919"

-----------Quest4 H
Inst2Quest4Rewardtext_HORDE = RED..AQNoReward

-----------Quest5 H
Inst2Quest5Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst2Quest5ITC1_HORDE = Itemc3;
Inst2Quest5textur1_HORDE = "INV_Scroll_06"
Inst2Quest5description1_HORDE = AQITEM_PATTERN
Inst2Quest5ID1_HORDE = "6476"
--ITEM2
Inst2Quest5ITC2_HORDE = Itemc3;
Inst2Quest5textur2_HORDE = "INV_Staff_02"
Inst2Quest5description2_HORDE = AQITEM_WAND
Inst2Quest5ID2_HORDE = "8071"
--ITEM3
Inst2Quest5ITC3_HORDE = Itemc3;
Inst2Quest5textur3_HORDE = "INV_Gauntlets_05"
Inst2Quest5description3_HORDE = AQITEM_HANDS..AQITEM_MAIL
Inst2Quest5ID3_HORDE = "6481"

-----------Quest6 H
Inst2Quest6Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst2Quest6ITC1_HORDE = Itemc4;
Inst2Quest6textur1_HORDE = "INV_Staff_04"
Inst2Quest6description1_HORDE = AQITEM_STAFF
Inst2Quest6ID1_HORDE = "6505"
--ITEM2
Inst2Quest6ITC2_HORDE = Itemc4;
Inst2Quest6textur2_HORDE = "INV_Sword_16"
Inst2Quest6description2_HORDE = AQITEM_MAINHAND..AQITEM_SWORD
Inst2Quest6ID2_HORDE = "6504"

-----------Quest7 H
Inst2Quest7Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst2Quest7ITC1_HORDE = Itemc3;
Inst2Quest7textur1_HORDE = "INV_Shoulder_09"
Inst2Quest7description1_HORDE = AQITEM_SHOULDER..AQITEM_CLOTH
Inst2Quest7ID1_HORDE = "10657"
--ITEM2
Inst2Quest7ITC2_HORDE = Itemc3;
Inst2Quest7textur2_HORDE = "INV_Boots_07"
Inst2Quest7description2_HORDE = AQITEM_FEET..AQITEM_MAIL
Inst2Quest7ID2_HORDE = "10658"

------------------------------- ULD/Inst 4 --------------------------------------------------------------------
-----------Quest1 A
Inst4Quest1Rewardtext = RED..AQNoReward

-----------Quest2 A
Inst4Quest2Rewardtext = RED..AQNoReward

-----------Quest3 A
Inst4Quest3Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst4Quest3ITC1 = Itemc3;
Inst4Quest3textur1 = "INV_Jewelry_Amulet_03"
Inst4Quest3description1 = AQITEM_NECK
Inst4Quest3ID1 = "6723"

-----------Quest4 A
Inst4Quest4Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst4Quest4ITC1 = Itemc3;
Inst4Quest4textur1 = "INV_Shield_10"
Inst4Quest4description1 = AQITEM_SHIELD
Inst4Quest4ID1 = "9522"
--ITEM2
Inst4Quest4ITC2 = Itemc3;
Inst4Quest4textur2 = "INV_Bracer_04"
Inst4Quest4description2 = AQITEM_WRIST..AQITEM_MAIL
Inst4Quest4ID2 = "10358"
--ITEM3
Inst4Quest4ITC3 = Itemc3;
Inst4Quest4textur3 = "INV_Boots_07"
Inst4Quest4description3 = AQITEM_FEET..AQITEM_CLOTH
Inst4Quest4ID3 = "10359"

-----------Quest5 A
Inst4Quest5Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst4Quest5ITC1 = Itemc3;
Inst4Quest5textur1 = "INV_Gauntlets_04"
Inst4Quest5description1 = AQITEM_HANDS..AQITEM_LEATHER
Inst4Quest5ID1 = "4980"

-----------Quest6 A
Inst4Quest6Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst4Quest6ITC1 = Itemc3;
Inst4Quest6textur1 = "INV_Chest_Cloth_19"
Inst4Quest6description1 = AQITEM_CHEST..AQITEM_CLOTH
Inst4Quest6ID1 = "4746"

-----------Quest7 A
Inst4Quest7Rewardtext = RED..AQNoReward

-----------Quest8 A
Inst4Quest8Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst4Quest8ITC1 = Itemc3;
Inst4Quest8textur1 = "INV_Axe_09"
Inst4Quest8description1 = AQITEM_TWOHAND..AQITEM_AXE
Inst4Quest8ID1 = "9626"
--ITEM2
Inst4Quest8ITC2 = Itemc3;
Inst4Quest8textur2 = "INV_Misc_Lantern_01"
Inst4Quest8description2 = AQITEM_OFFHAND
Inst4Quest8ID2 = "9627"

-----------Quest9 A
Inst4Quest9Rewardtext = RED..AQNoReward

-----------Quest10 A
Inst4Quest10Rewardtext = RED..AQNoReward

-----------Quest11 A
Inst4Quest11Rewardtext = RED..AQNoReward

-----------Quest12 A
Inst4Quest12Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst4Quest12ITC1 = Itemc4;
Inst4Quest12textur1 = "INV_Jewelry_Necklace_02"
Inst4Quest12description1 = AQITEM_NECK
Inst4Quest12ID1 = "7673"

-----------Quest13 A
Inst4Quest13Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1(x5)"
--ITEM1
Inst4Quest13ITC1 = Itemc2;
Inst4Quest13textur1 = "INV_Potion_01"
Inst4Quest13description1 = AQITEM_POTION
Inst4Quest13ID1 = "9030"

-----------Quest14 A
Inst4Quest14Rewardtext = RED..AQNoReward

-----------Quest15 A
Inst4Quest15Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2(x5)"..AQDiscription_OR..WHITE.."3(x5)"
--ITEM1
Inst4Quest15ITC1 = Itemc2;
Inst4Quest15textur1 = "INV_Misc_Bag_17"
Inst4Quest15description1 = AQITEM_BAG
Inst4Quest15ID1 = "9587"
--ITEM2
Inst4Quest15ITC2 = Itemc2;
Inst4Quest15textur2 = "INV_Potion_53"
Inst4Quest15description2 = AQITEM_POTION
Inst4Quest15ID2 = "3928"
--ITEM3
Inst4Quest15ITC3 = Itemc2;
Inst4Quest15textur3 = "INV_Potion_73"
Inst4Quest15description3 = AQITEM_POTION
Inst4Quest15ID3 = "6149"

-----------Quest16 A
Inst4Quest16Rewardtext = RED..AQNoReward

----------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
-----------------------------------------

-----------Quest1 H
Inst4Quest1Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst4Quest1ITC1_HORDE = Itemc3;
Inst4Quest1textur1_HORDE = "INV_Shield_10"
Inst4Quest1description1_HORDE = AQITEM_SHIELD
Inst4Quest1ID1_HORDE = "9522"
--ITEM2
Inst4Quest1ITC2_HORDE = Itemc3;
Inst4Quest1textur2_HORDE = "INV_Bracer_04"
Inst4Quest1description2_HORDE = AQITEM_WRIST..AQITEM_MAIL
Inst4Quest1ID2_HORDE = "10358"
--ITEM3
Inst4Quest1ITC3_HORDE = Itemc3;
Inst4Quest1textur3_HORDE = "INV_Boots_07"
Inst4Quest1description3_HORDE = AQITEM_FEET..AQITEM_CLOTH
Inst4Quest1ID3_HORDE = "10359"

-----------Quest2 H
Inst4Quest2Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst4Quest2ITC1_HORDE = Itemc3;
Inst4Quest2textur1_HORDE = "INV_Chest_Cloth_19"
Inst4Quest2description1_HORDE = AQITEM_CHEST..AQITEM_CLOTH
Inst4Quest2ID1_HORDE = "4746"

-----------Quest3 H
Inst4Quest3Rewardtext_HORDE = RED..AQNoReward

-----------Quest4 H
Inst4Quest4Rewardtext_HORDE = RED..AQNoReward

-----------Quest5 H
Inst4Quest5Rewardtext_HORDE = RED..AQNoReward

-----------Quest6 H
Inst4Quest6Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst4Quest6ITC1_HORDE = Itemc4;
Inst4Quest6textur1_HORDE = "INV_Jewelry_Necklace_02"
Inst4Quest6description1_HORDE = AQITEM_NECK
Inst4Quest6ID1_HORDE = "7888"

-----------Quest7 H
Inst4Quest7Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1(x5)"
--ITEM1
Inst4Quest7ITC1_HORDE = Itemc2;
Inst4Quest7textur1_HORDE = "INV_Potion_01"
Inst4Quest7description1_HORDE = AQITEM_POTION
Inst4Quest7ID1_HORDE = "9030"

-----------Quest8 H
Inst4Quest8Rewardtext_HORDE = RED..AQNoReward

-----------Quest9 H
Inst4Quest9Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2(x5)"..AQDiscription_OR..WHITE.."3(x5)"
--ITEM1
Inst4Quest9ITC1_HORDE = Itemc2;
Inst4Quest9textur1_HORDE = "INV_Misc_Bag_17"
Inst4Quest9description1_HORDE = AQITEM_BAG
Inst4Quest9ID1_HORDE = "9587"
--ITEM2
Inst4Quest9ITC2_HORDE = Itemc2;
Inst4Quest9textur2_HORDE = "INV_Potion_53"
Inst4Quest9description2_HORDE = AQITEM_POTION
Inst4Quest9ID2_HORDE = "3928"
--ITEM3
Inst4Quest9ITC3_HORDE = Itemc2;
Inst4Quest9textur3_HORDE = "INV_Potion_73"
Inst4Quest9description3_HORDE = AQITEM_POTION
Inst4Quest9ID3_HORDE = "6149"

-----------Quest10 H
Inst4Quest10Rewardtext_HORDE = RED..AQNoReward

------------------------------- RFA/Inst 3 --------------------------------------------------------------------

-----------Quest1 H
Inst3Quest1Rewardtext_HORDE = RED..AQNoReward

-----------Quest2 H
Inst3Quest2Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst3Quest2ITC1_HORDE = Itemc3;
Inst3Quest2textur1_HORDE = "INV_Pants_14"
Inst3Quest2description1_HORDE = AQITEM_LEGS..AQITEM_CLOTH
Inst3Quest2ID1_HORDE = "15449"
--ITEM2
Inst3Quest2ITC2_HORDE = Itemc3;
Inst3Quest2textur2_HORDE = "INV_Pants_07"
Inst3Quest2description2_HORDE = AQITEM_LEGS..AQITEM_LEATHER
Inst3Quest2ID2_HORDE = "15450"
--ITEM3
Inst3Quest2ITC3_HORDE = Itemc3;
Inst3Quest2textur3_HORDE = "INV_Pants_03"
Inst3Quest2description3_HORDE = AQITEM_LEGS..AQITEM_MAIL
Inst3Quest2ID3_HORDE = "15451"

-----------Quest3 H
Inst3Quest3Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst3Quest3ITC1_HORDE = Itemc3;
Inst3Quest3textur1_HORDE = "INV_Bracer_08"
Inst3Quest3description1_HORDE = AQITEM_WRIST..AQITEM_CLOTH
Inst3Quest3ID1_HORDE = "15452"
--ITEM2
Inst3Quest3ITC2_HORDE = Itemc3;
Inst3Quest3textur2_HORDE = "INV_Bracer_07"
Inst3Quest3description2_HORDE = AQITEM_WRIST..AQITEM_LEATHER
Inst3Quest3ID2_HORDE = "15453"

-----------Quest4 H
Inst3Quest4Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"..AQDiscription_OR..WHITE.."4"
--ITEM1
Inst3Quest4ITC1_HORDE = Itemc3;
Inst3Quest4textur1_HORDE = "INV_Weapon_ShortBlade_05"
Inst3Quest4description1_HORDE = AQITEM_ONEHAND..AQITEM_DAGGER
Inst3Quest4ID1_HORDE = "15443"
--ITEM2
Inst3Quest4ITC2_HORDE = Itemc3;
Inst3Quest4textur2_HORDE = "INV_Hammer_23"
Inst3Quest4description2_HORDE = AQITEM_MAINHAND..AQITEM_MACE
Inst3Quest4ID2_HORDE = "15445"
--ITEM3
Inst3Quest4ITC3_HORDE = Itemc3;
Inst3Quest4textur3_HORDE = "INV_Axe_04"
Inst3Quest4description3_HORDE = AQITEM_TWOHAND..AQITEM_AXE
Inst3Quest4ID3_HORDE = "15424"
--ITEM4
Inst3Quest4ITC4_HORDE = Itemc3;
Inst3Quest4textur4_HORDE = "INV_Staff_Goldfeathered_01"
Inst3Quest4description4_HORDE = AQITEM_STAFF
Inst3Quest4ID4_HORDE = "15444"

-----------Quest5 H
Inst3Quest5Rewardtext_HORDE = RED..AQNoReward

------------------------------- ZUL/Inst 27 --------------------------------------------------------------------
-----------Quest1 A
Inst27Quest1Rewardtext = RED..AQNoReward

-----------Quest2 A
Inst27Quest2Rewardtext = RED..AQNoReward

-----------Quest3 A
Inst27Quest3Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"
--ITEM1
Inst27Quest3ITC1 = Itemc3;
Inst27Quest3textur1 = "INV_Wand_11"
Inst27Quest3description1 = AQITEM_STAFF
Inst27Quest3ID1 = "9527"
--ITEM2
Inst27Quest3ITC2 = Itemc3;
Inst27Quest3textur2 = "INV_Shoulder_23"
Inst27Quest3description2 = AQITEM_SHOULDER..AQITEM_PLATE
Inst27Quest3ID2 = "9531"

-----------Quest4 A
Inst27Quest4Rewardtext = RED..AQNoReward

-----------Quest5 A
Inst27Quest5Rewardtext = RED..AQNoReward

-----------Quest6 A
Inst27Quest6Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst27Quest6ITC1 = Itemc4;
Inst27Quest6textur1 = "INV_Jewelry_Ring_03"
Inst27Quest6description1 = AQITEM_RING
Inst27Quest6ID1 = "9533"
--ITEM2
Inst27Quest6ITC2 = Itemc4;
Inst27Quest6textur2 = "INV_Helmet_33"
Inst27Quest6description2 = AQITEM_HEAD..AQITEM_LEATHER
Inst27Quest6ID2 = "9534"

-----------Quest7 A
Inst27Quest7Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst27Quest7ITC1 = Itemc3;
Inst27Quest7textur1 = "INV_Misc_Food_54"
Inst27Quest7description1 = AQITEM_TRINKET
Inst27Quest7ID1 = "11122"

------------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
------------------------------------------

-----------Quest1 H
Inst27Quest1Rewardtext_HORDE = RED..AQNoReward

-----------Quest2 H
Inst27Quest2Rewardtext_HORDE = RED..AQNoReward

-----------Quest3 H
Inst27Quest3Rewardtext_HORDE = RED..AQNoReward

-----------Quest4 H
Inst27Quest4Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"
--ITEM1
Inst27Quest4ITC1_HORDE = Itemc3;
Inst27Quest4textur1_HORDE = "INV_Wand_11"
Inst27Quest4description1_HORDE = AQITEM_STAFF
Inst27Quest4ID1_HORDE = "9527"
--ITEM2
Inst27Quest4ITC2_HORDE = Itemc3;
Inst27Quest4textur2_HORDE = "INV_Shoulder_23"
Inst27Quest4description2_HORDE = AQITEM_SHOULDER..AQITEM_PLATE
Inst27Quest4ID2_HORDE = "9531"

-----------Quest5 H
Inst27Quest5Rewardtext_HORDE = RED..AQNoReward

-----------Quest6 H
Inst27Quest6Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst27Quest6ITC1_HORDE = Itemc4;
Inst27Quest6textur1_HORDE = "INV_Jewelry_Ring_03"
Inst27Quest6description1_HORDE = AQITEM_RING
Inst27Quest6ID1_HORDE = "9533"
--ITEM2
Inst27Quest6ITC2_HORDE = Itemc4;
Inst27Quest6textur2_HORDE = "INV_Helmet_33"
Inst27Quest6description2_HORDE = AQITEM_HEAD..AQITEM_LEATHER
Inst27Quest6ID2_HORDE = "9534"

-----------Quest7 H
Inst27Quest7Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst27Quest7ITC1_HORDE = Itemc3;
Inst27Quest7textur1_HORDE = "INV_Misc_Food_54"
Inst27Quest7description1_HORDE = AQITEM_TRINKET
Inst27Quest7ID1_HORDE = "11122"


------------------------------- STOCKADE/Inst 24 --------------------------------------------------------------------

-----------Quest1 A
Inst24Quest1Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst24Quest1ITC1 = Itemc3;
Inst24Quest1textur1 = "INV_Sword_20"
Inst24Quest1description1 = AQITEM_MAINHAND..AQITEM_SWORD
Inst24Quest1ID1 = "3400"
--ITEM2
Inst24Quest1ITC2 = Itemc3;
Inst24Quest1textur2 = "INV_Staff_16"
Inst24Quest1description2 = AQITEM_STAFF
Inst24Quest1ID2 = "1317"

-----------Quest2 A
Inst24Quest2Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst24Quest2ITC1 = Itemc3;
Inst24Quest2textur1 = "INV_Boots_08"
Inst24Quest2description1 = AQITEM_FEET..AQITEM_LEATHER
Inst24Quest2ID1 = "2033"
--ITEM2
Inst24Quest2ITC2 = Itemc3;
Inst24Quest2textur2 = "INV_Pants_03"
Inst24Quest2description2 = AQITEM_LEGS..AQITEM_MAIL
Inst24Quest2ID2 = "2906"

-----------Quest3 A
Inst24Quest3Rewardtext = RED..AQNoReward

-----------Quest4 A
Inst24Quest4Rewardtext = RED..AQNoReward

-----------Quest5 A
Inst24Quest5Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst24Quest5ITC1 = Itemc3;
Inst24Quest5textur1 = "INV_Belt_05"
Inst24Quest5description1 = AQITEM_WAIST..AQITEM_LEATHER
Inst24Quest5ID1 = "3562"
--ITEM2
Inst24Quest5ITC2 = Itemc3;
Inst24Quest5textur2 = "INV_Mace_07"
Inst24Quest5description2 = AQITEM_TWOHAND..AQITEM_MACE
Inst24Quest5ID2 = "1264"

-----------Quest6 A
Inst24Quest6Rewardtext = RED..AQNoReward

------------------------------- HUEGEL/Inst 17 --------------------------------------------------------------------
-----------Quest1 A
Inst17Quest1Rewardtext = RED..AQNoReward

-----------Quest2 A
Inst17Quest2Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst17Quest2ITC1 = Itemc4;
Inst17Quest2textur1 = "INV_Jewelry_Ring_04"
Inst17Quest2description1 = AQITEM_RING
Inst17Quest2ID1 = "10710"

-----------Quest3 A
Inst17Quest3Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"
--ITEM1
Inst17Quest3ITC1 = Itemc4;
Inst17Quest3textur1 = "INV_Sword_35"
Inst17Quest3description1 = AQITEM_ONEHAND..AQITEM_SWORD
Inst17Quest3ID1 = "10823"
--ITEM2
Inst17Quest3ITC2 = Itemc4;
Inst17Quest3textur2 = "INV_Jewelry_Necklace_07"
Inst17Quest3description2 = AQITEM_NECK
Inst17Quest3ID2 = "10824"

---------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
----------------------------------------

-----------Quest1 H
Inst17Quest1Rewardtext_HORDE = RED..AQNoReward

-----------Quest2 H
Inst17Quest2Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst17Quest2ITC1_HORDE = Itemc3;
Inst17Quest2textur1_HORDE = "INV_Misc_Bone_DwarfSkull_01"
Inst17Quest2description1_HORDE = AQITEM_MAINHAND..AQITEM_MACE
Inst17Quest2ID1_HORDE = "17039"
--ITEM2
Inst17Quest2ITC2_HORDE = Itemc3;
Inst17Quest2textur2_HORDE = "INV_Weapon_Rifle_01"
Inst17Quest2description2_HORDE = AQITEM_GUN
Inst17Quest2ID2_HORDE = "17042"
--ITEM3
Inst17Quest2ITC3_HORDE = Itemc3;
Inst17Quest2textur3_HORDE = "INV_Chest_Cloth_06"
Inst17Quest2description3_HORDE = AQITEM_CHEST..AQITEM_CLOTH
Inst17Quest2ID3_HORDE = "17043"

-----------Quest3 H
Inst17Quest3Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst17Quest3ITC1_HORDE = Itemc4;
Inst17Quest3textur1_HORDE = "INV_Jewelry_Ring_04"
Inst17Quest3description1_HORDE = AQITEM_RING
Inst17Quest3ID1_HORDE = "10710"

-----------Quest4 H
Inst17Quest4Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"
--ITEM1
Inst17Quest4ITC1_HORDE = Itemc4;
Inst17Quest4textur1_HORDE = "INV_Sword_35"
Inst17Quest4description1_HORDE = AQITEM_ONEHAND..AQITEM_SWORD
Inst17Quest4ID1_HORDE = "10823"
--ITEM2
Inst17Quest4ITC2_HORDE = Itemc4;
Inst17Quest4textur2_HORDE = "INV_Jewelry_Necklace_07"
Inst17Quest4description2_HORDE = AQITEM_NECK
Inst17Quest4ID2_HORDE = "10824"

------------------------------- SM/Inst 19 --------------------------------------------------------------------
-----------Quest1 A
Inst19Quest1Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst19Quest1ITC1 = Itemc3;
Inst19Quest1textur1 = "INV_Jewelry_Talisman_01"
Inst19Quest1description1 = AQITEM_NECK
Inst19Quest1ID1 = "7746"

-----------Quest2 A
Inst19Quest2Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst19Quest2ITC1 = Itemc4;
Inst19Quest2textur1 = "INV_Sword_27"
Inst19Quest2description1 = AQITEM_ONEHAND..AQITEM_SWORD
Inst19Quest2ID1 = "6829"
--ITEM2
Inst19Quest2ITC2 = Itemc4;
Inst19Quest2textur2 = "INV_Axe_04"
Inst19Quest2description2 = AQITEM_TWOHAND..AQITEM_AXE
Inst19Quest2ID2 = "6830"
--ITEM3
Inst19Quest2ITC3 = Itemc4;
Inst19Quest2textur3 = "INV_Sword_13"
Inst19Quest2description3 = AQITEM_ONEHAND..AQITEM_DAGGER
Inst19Quest2ID3 = "6831"
--ITEM4
Inst19Quest2ITC4 = Itemc4;
Inst19Quest2textur4 = "INV_Misc_Orb_01"
Inst19Quest2description4 = AQITEM_OFFHAND
Inst19Quest2ID4 = "11262"

-----------Quest3 A
Inst19Quest3Rewardtext = RED..AQNoReward

----------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
---------------------------------------

-----------Quest1 H
Inst19Quest1Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst19Quest1ITC1_HORDE = Itemc3;
Inst19Quest1textur1_HORDE = "INV_Boots_03"
Inst19Quest1description1_HORDE = AQITEM_FEET..AQITEM_LEATHER
Inst19Quest1ID1_HORDE = "7751"
--ITEM2
Inst19Quest1ITC2_HORDE = Itemc3;
Inst19Quest1textur2_HORDE = "INV_Shoulder_23"
Inst19Quest1description2_HORDE = AQITEM_SHOULDER..AQITEM_CLOTH
Inst19Quest1ID2_HORDE = "7750"
--ITEM3
Inst19Quest1ITC3_HORDE = Itemc3;
Inst19Quest1textur3_HORDE = "INV_Misc_Cape_02"
Inst19Quest1description3_HORDE = AQITEM_BACK
Inst19Quest1ID3_HORDE = "4643"

-----------Quest2 H
Inst19Quest2Rewardtext_HORDE = RED..AQNoReward

-----------Quest3 H
Inst19Quest3Rewardtext_HORDE = RED..AQNoReward

-----------Quest4 H
Inst19Quest4Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst19Quest4ITC1_HORDE = Itemc3;
Inst19Quest4textur1_HORDE = "INV_Shield_02"
Inst19Quest4description1_HORDE = AQITEM_SHIELD
Inst19Quest4ID1_HORDE = "7747"
--ITEM2
Inst19Quest4ITC2_HORDE = Itemc3;
Inst19Quest4textur2_HORDE = "INV_Shield_02"
Inst19Quest4description2_HORDE = AQITEM_SHIELD
Inst19Quest4ID2_HORDE = "17508"
--ITEM3
Inst19Quest4ITC3_HORDE = Itemc3;
Inst19Quest4textur3_HORDE = "INV_Misc_Orb_03"
Inst19Quest4description3_HORDE = AQITEM_OFFHAND
Inst19Quest4ID3_HORDE = "7749"

-----------Quest5 H
Inst19Quest5Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst19Quest5ITC1_HORDE = Itemc4;
Inst19Quest5textur1_HORDE = "INV_Sword_19"
Inst19Quest5description1_HORDE = AQITEM_ONEHAND..AQITEM_SWORD
Inst19Quest5ID1_HORDE = "6802"
--ITEM2
Inst19Quest5ITC2_HORDE = Itemc4;
Inst19Quest5textur2_HORDE = "INV_Staff_01"
Inst19Quest5description2_HORDE = AQITEM_OFFHAND
Inst19Quest5ID2_HORDE = "6803"
--ITEM3
Inst19Quest5ITC3_HORDE = Itemc4;
Inst19Quest5textur3_HORDE = "INV_Jewelry_Necklace_02"
Inst19Quest5description3_HORDE = AQITEM_NECK
Inst19Quest5ID3_HORDE = "10711"

-----------Quest6 H
Inst19Quest6Rewardtext_HORDE = RED..AQNoReward

------------------------------- KRAL/Inst 18 --------------------------------------------------------------------
-----------Quest1 A
Inst18Quest1Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst18Quest1ITC1 = Itemc2;
Inst18Quest1textur1 = "INV_Misc_OrnateBox"
Inst18Quest1description1 = ""
Inst18Quest1ID1 = "6755"


-----------Quest2 A
Inst18Quest2Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst18Quest2ITC1 = Itemc3;
Inst18Quest2textur1 = "INV_Misc_Cape_11"
Inst18Quest2description1 = AQITEM_BACK
Inst18Quest2ID1 = "6751"
--ITEM2
Inst18Quest2ITC2 = Itemc3;
Inst18Quest2textur2 = "INV_Boots_03"
Inst18Quest2description2 = AQITEM_FEET..AQITEM_LEATHER
Inst18Quest2ID2 = "6752"

-----------Quest3 A
Inst18Quest3Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst18Quest3ITC1 = Itemc3;
Inst18Quest3textur1 = "INV_Jewelry_Ring_14"
Inst18Quest3description1 = AQITEM_RING
Inst18Quest3ID1 = "6748"
--ITEM2
Inst18Quest3ITC2 = Itemc3;
Inst18Quest3textur2 = "INV_Jewelry_Ring_06"
Inst18Quest3description2 = AQITEM_RING
Inst18Quest3ID2 = "6750"
--ITEM3
Inst18Quest3ITC3 = Itemc3;
Inst18Quest3textur3 = "INV_Jewelry_Ring_13"
Inst18Quest3description3 = AQITEM_RING
Inst18Quest3ID3 = "6749"

-----------Quest4 A
Inst18Quest4Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"..AQDiscription_OR..WHITE.."3"..AQDiscription_OR..WHITE.."4"
--ITEM1
Inst18Quest4ITC1 = Itemc3;
Inst18Quest4textur1 = "INV_Weapon_Rifle_05"
Inst18Quest4description1 = AQITEM_GUN
Inst18Quest4ID1 = "3041"
--ITEM2
Inst18Quest4ITC2 = Itemc4;
Inst18Quest4textur2 = "INV_Shoulder_05"
Inst18Quest4description2 = AQITEM_SHOULDER..AQITEM_CLOTH
Inst18Quest4ID2 = "4197"
--ITEM3
Inst18Quest4ITC3 = Itemc4;
Inst18Quest4textur3 = "INV_Belt_35"
Inst18Quest4description3 = AQITEM_WAIST..AQITEM_MAIL
Inst18Quest4ID3 = "6742"
--ITEM4
Inst18Quest4ITC4 = Itemc4;
Inst18Quest4textur4 = "INV_Shield_10"
Inst18Quest4description4 = AQITEM_SHIELD
Inst18Quest4ID4 = "6725"

-----------Quest5 A
Inst18Quest5Rewardtext = RED..AQNoReward

-------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
---------------------------------------

-----------Quest1 H
Inst18Quest1Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst18Quest1ITC1_HORDE = Itemc2;
Inst18Quest1textur1_HORDE = "INV_Misc_OrnateBox"
Inst18Quest1description1_HORDE = ""
Inst18Quest1ID1_HORDE = "6755"

-----------Quest2 H
Inst18Quest2Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst18Quest2ITC1_HORDE = Itemc3;
Inst18Quest2textur1_HORDE = "INV_Jewelry_Ring_14"
Inst18Quest2description1_HORDE = AQITEM_RING
Inst18Quest2ID1_HORDE = "6748"
--ITEM2
Inst18Quest2ITC2_HORDE = Itemc3;
Inst18Quest2textur2_HORDE = "INV_Jewelry_Ring_06"
Inst18Quest2description2_HORDE = AQITEM_RING
Inst18Quest2ID2_HORDE = "6750"
--ITEM3
Inst18Quest2ITC3_HORDE = Itemc3;
Inst18Quest2textur3_HORDE = "INV_Jewelry_Ring_13"
Inst18Quest2description3_HORDE = AQITEM_RING
Inst18Quest2ID3_HORDE = "6749"

-----------Quest3 H
Inst18Quest3Rewardtext_HORDE = RED..AQNoReward

-----------Quest4 H
Inst18Quest4Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst18Quest4ITC1_HORDE = Itemc4;
Inst18Quest4textur1_HORDE = "INV_Shoulder_05"
Inst18Quest4description1_HORDE = AQITEM_SHOULDER..AQITEM_CLOTH
Inst18Quest4ID1_HORDE = "4197"
--ITEM2
Inst18Quest4ITC2_HORDE = Itemc4;
Inst18Quest4textur2_HORDE = "INV_Belt_35"
Inst18Quest4description2_HORDE = AQITEM_WAIST..AQITEM_MAIL
Inst18Quest4ID2_HORDE = "6742"
--ITEM3
Inst18Quest4ITC3_HORDE = Itemc4;
Inst18Quest4textur3_HORDE = "INV_Shield_10"
Inst18Quest4description3_HORDE = AQITEM_SHIELD
Inst18Quest4ID3_HORDE = "6725"

-----------Quest5 H
Inst18Quest5Rewardtext_HORDE = RED..AQNoReward

------------------------------- SCHOLO/Inst 20 --------------------------------------------------------------------

-----------Quest1 A
Inst20Quest1Rewardtext = RED..AQNoReward

-----------Quest2 A
Inst20Quest2Rewardtext = RED..AQNoReward

-----------Quest3 A
Inst20Quest3Rewardtext = RED..AQNoReward

-----------Quest4 A
Inst20Quest4Rewardtext = RED..AQNoReward

-----------Quest5 A
Inst20Quest5Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst20Quest5ITC1 = Itemc3;
Inst20Quest5textur1 = "INV_Misc_Orb_05"
Inst20Quest5description1 = AQITEM_TRINKET
Inst20Quest5ID1 = "13544"
--ITEM2
Inst20Quest5ITC2 = Itemc4;
Inst20Quest5textur2 = "INV_Misc_Flower_04"
Inst20Quest5description2 = AQITEM_OFFHAND
Inst20Quest5ID2 = "15805"
--ITEM3
Inst20Quest5ITC3 = Itemc4;
Inst20Quest5textur3 = "INV_Sword_34"
Inst20Quest5description3 = AQITEM_ONEHAND..AQITEM_SWORD
Inst20Quest5ID3 = "15806"

-----------Quest6 A
Inst20Quest6Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"..AQDiscription_OR..WHITE.."3"..AQDiscription_OR..WHITE.."4"
--ITEM1
Inst20Quest6ITC1 = Itemc4;
Inst20Quest6textur1 = "INV_Shield_05"
Inst20Quest6description1 = AQITEM_SHIELD
Inst20Quest6ID1 = "14002"
--ITEM2
Inst20Quest6ITC2 = Itemc4;
Inst20Quest6textur2 = "INV_Sword_39"
Inst20Quest6description2 = AQITEM_TWOHAND..AQITEM_SWORD
Inst20Quest6ID2 = "13982"
--ITEM3
Inst20Quest6ITC3 = Itemc4;
Inst20Quest6textur3 = "INV_Crown_01"
Inst20Quest6description3 = AQITEM_HEAD..AQITEM_CLOTH
Inst20Quest6ID3 = "13986"
--ITE4
Inst20Quest6ITC4 = Itemc4;
Inst20Quest6textur4 = "INV_Weapon_ShortBlade_21"
Inst20Quest6description4 = AQITEM_ONEHAND..AQITEM_DAGGER
Inst20Quest6ID4 = "13984"

-----------Quest7 A
Inst20Quest7Rewardtext = RED..AQNoReward

-----------Quest8 A
Inst20Quest8Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"..AQDiscription_OR..WHITE.."3"..AQDiscription_OR..WHITE.."4"
--ITEM1
Inst20Quest8ITC1 = Itemc4;
Inst20Quest8textur1 = "INV_Axe_08"
Inst20Quest8description1 = AQITEM_ONEHAND..AQITEM_AXE
Inst20Quest8ID1 = "15853"
--ITEM2
Inst20Quest8ITC2 = Itemc4;
Inst20Quest8textur2 = "INV_Staff_07"
Inst20Quest8description2 = AQITEM_STAFF
Inst20Quest8ID2 = "15854"

-----------Quest9 A
Inst20Quest9Rewardtext = RED..AQNoReward


-------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
-------------------------------------

-----------Quest1 H
Inst20Quest1Rewardtext_HORDE = RED..AQNoReward

-----------Quest2 H
Inst20Quest2Rewardtext_HORDE = RED..AQNoReward

-----------Quest3 H
Inst20Quest3Rewardtext_HORDE = RED..AQNoReward

-----------Quest4 H
Inst20Quest4Rewardtext_HORDE = RED..AQNoReward

-----------Quest5 H
Inst20Quest5Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst20Quest5ITC1_HORDE = Itemc3;
Inst20Quest5textur1_HORDE = "INV_Misc_Orb_05"
Inst20Quest5description1_HORDE = AQITEM_TRINKET
Inst20Quest5ID1_HORDE = "13544"
--ITEM2
Inst20Quest5ITC2_HORDE = Itemc4;
Inst20Quest5textur2_HORDE = "INV_Misc_Flower_04"
Inst20Quest5description2_HORDE = AQITEM_OFFHAND
Inst20Quest5ID2_HORDE = "15805"
--ITEM3
Inst20Quest5ITC3_HORDE = Itemc4;
Inst20Quest5textur3_HORDE = "INV_Sword_34"
Inst20Quest5description3_HORDE = AQITEM_ONEHAND..AQITEM_SWORD
Inst20Quest5ID3_HORDE = "15806"

-----------Quest6 H
Inst20Quest6Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"..AQDiscription_OR..WHITE.."3"..AQDiscription_OR..WHITE.."4"
--ITEM1
Inst20Quest6ITC1_HORDE = Itemc4;
Inst20Quest6textur1_HORDE = "INV_Shield_05"
Inst20Quest6description1_HORDE = AQITEM_SHIELD
Inst20Quest6ID1_HORDE = "14002"
--ITEM2
Inst20Quest6ITC2_HORDE = Itemc4;
Inst20Quest6textur2_HORDE = "INV_Sword_39"
Inst20Quest6description2_HORDE = AQITEM_TWOHAND..AQITEM_SWORD
Inst20Quest6ID2_HORDE = "13982"
--ITEM3
Inst20Quest6ITC3_HORDE = Itemc4;
Inst20Quest6textur3_HORDE = "INV_Crown_01"
Inst20Quest6description3_HORDE = AQITEM_HEAD..AQITEM_CLOTH
Inst20Quest6ID3_HORDE = "13986"
--ITE4
Inst20Quest6ITC4_HORDE = Itemc4;
Inst20Quest6textur4_HORDE = "INV_Weapon_ShortBlade_21"
Inst20Quest6description4_HORDE = AQITEM_ONEHAND..AQITEM_DAGGER
Inst20Quest6ID4_HORDE = "13984"

-----------Quest7 H
Inst20Quest7Rewardtext_HORDE = RED..AQNoReward

-----------Quest8 H
Inst20Quest8Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"..AQDiscription_OR..WHITE.."3"..AQDiscription_OR..WHITE.."4"
--ITEM1
Inst20Quest8ITC1_HORDE = Itemc4;
Inst20Quest8textur1_HORDE = "INV_Axe_08"
Inst20Quest8description1_HORDE = AQITEM_ONEHAND..AQITEM_AXE
Inst20Quest8ID1_HORDE = "15853"
--ITEM2
Inst20Quest8ITC2_HORDE = Itemc4;
Inst20Quest8textur2_HORDE = "INV_Staff_07"
Inst20Quest8description2_HORDE = AQITEM_STAFF
Inst20Quest8ID2_HORDE = "15854"

-----------Quest9 H
Inst20Quest9Rewardtext_HORDE = RED..AQNoReward


------------------------------- BFD/Inst 7 --------------------------------------------------------------------
-----------Quest1 A
Inst7Quest1Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst7Quest1ITC1 = Itemc3;
Inst7Quest1textur1 = "INV_Jewelry_Ring_08"
Inst7Quest1description1 = AQITEM_RING
Inst7Quest1ID1 = "6743"

-----------Quest2 A
Inst7Quest2Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst7Quest2ITC1 = Itemc3;
Inst7Quest2textur1 = "INV_Bracer_06"
Inst7Quest2description1 = AQITEM_WRIST..AQITEM_MAIL
Inst7Quest2ID1 = "7003"
--ITEM1
Inst7Quest2ITC2 = Itemc3;
Inst7Quest2textur2 = "INV_Misc_Cape_18"
Inst7Quest2description2 = AQITEM_BACK
Inst7Quest2ID2 = "7004"

-----------Quest3 A
Inst7Quest3Rewardtext = RED..AQNoReward

-----------Quest4 A
Inst7Quest4Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst7Quest4ITC1 = Itemc4;
Inst7Quest4textur1 = "INV_Wand_04"
Inst7Quest4description1 = AQITEM_WAND
Inst7Quest4ID1 = "7001"
--ITEM1
Inst7Quest4ITC2 = Itemc4;
Inst7Quest4textur2 = "INV_Shield_02"
Inst7Quest4description2 = AQITEM_SHIELD
Inst7Quest4ID2 = "7002"

-----------Quest5 A
Inst7Quest5Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"
--ITEM1
Inst7Quest5ITC1 = Itemc3;
Inst7Quest5textur1 = "INV_Boots_05"
Inst7Quest5description1 = AQITEM_FEET..AQITEM_CLOTH
Inst7Quest5ID1 = "6998"
--ITEM1
Inst7Quest5ITC2 = Itemc3;
Inst7Quest5textur2 = "INV_Belt_04"
Inst7Quest5description2 = AQITEM_WAIST..AQITEM_LEATHER
Inst7Quest5ID2 = "7000"

-----------Quest6 A
Inst7Quest6Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst7Quest6ITC1 = Itemc3;
Inst7Quest6textur1 = "INV_Misc_Orb_03"
Inst7Quest6description1 = AQITEM_OFFHAND
Inst7Quest6ID1 = "6898"
--ITEM1
Inst7Quest6ITC2 = Itemc3;
Inst7Quest6textur2 = "INV_Staff_09"
Inst7Quest6description2 = AQITEM_STAFF
Inst7Quest6ID2 = "15109"

-------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
-------------------------------------

-----------Quest1 H
Inst7Quest1Rewardtext_HORDE = RED..AQNoReward

-----------Quest2 H
Inst7Quest2Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst7Quest2ITC1_HORDE = Itemc3;
Inst7Quest2textur1_HORDE = "INV_Jewelry_Ring_02"
Inst7Quest2description1_HORDE = AQITEM_RING
Inst7Quest2ID1_HORDE = "17694"
--ITEM1
Inst7Quest2ITC2_HORDE = Itemc3;
Inst7Quest2textur2_HORDE = "INV_Shoulder_09"
Inst7Quest2description2_HORDE = AQITEM_SHOULDER..AQITEM_CLOTH
Inst7Quest2ID2_HORDE = "17695"

-----------Quest3 H
Inst7Quest3Rewardtext_HORDE = RED..AQNoReward

-----------Quest4 H
Inst7Quest4Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst7Quest4ITC1_HORDE = Itemc4;
Inst7Quest4textur1_HORDE = "INV_Wand_04"
Inst7Quest4description1_HORDE = AQITEM_WAND
Inst7Quest4ID1_HORDE = "7001"
--ITEM1
Inst7Quest4ITC2_HORDE = Itemc4;
Inst7Quest4textur2_HORDE = "INV_Shield_02"
Inst7Quest4description2_HORDE = AQITEM_SHIELD
Inst7Quest4ID2_HORDE = "7002"

-----------Quest5 H
Inst7Quest5Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst7Quest5ITC1_HORDE = Itemc3;
Inst7Quest5textur1_HORDE = "INV_Misc_Orb_03"
Inst7Quest5description1_HORDE = AQITEM_OFFHAND
Inst7Quest5ID1_HORDE = "6898"
--ITEM1
Inst7Quest5ITC2_HORDE = Itemc3;
Inst7Quest5textur2_HORDE = "INV_Staff_09"
Inst7Quest5description2_HORDE = AQITEM_STAFF
Inst7Quest5ID2_HORDE = "15109"

------------------------------- TEMPLE/Inst 25 --------------------------------------------------------------------
-----------Quest1 A
Inst25Quest1Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst25Quest1ITC1 = Itemc3;
Inst25Quest1textur1 = "INV_Jewelry_Talisman_05"
Inst25Quest1description1 = AQITEM_TRINKET
Inst25Quest1ID1 = "1490"

-----------Quest2 A
Inst25Quest2Rewardtext = RED..AQNoReward

-----------Quest3 A
Inst25Quest3Rewardtext = RED..AQNoReward

-----------Quest4 A
Inst25Quest4Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst25Quest4ITC1 = Itemc3;
Inst25Quest4textur1 = "INV_Box_01"
Inst25Quest4description1 = ""
Inst25Quest4ID1 = "10773"

-----------Quest5 A
Inst25Quest5Rewardtext = RED..AQNoReward

-----------Quest6 A
Inst25Quest6Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst25Quest6ITC1 = Itemc4;
Inst25Quest6textur1 = "INV_Helmet_22"
Inst25Quest6description1 = AQITEM_HEAD..AQITEM_PLATE
Inst25Quest6ID1 = "10749"
--ITEM2
Inst25Quest6ITC2 = Itemc4;
Inst25Quest6textur2 = "INV_Sword_21"
Inst25Quest6description2 = AQITEM_ONEHAND..AQITEM_DAGGER
Inst25Quest6ID2 = "10750"
--ITEM3
Inst25Quest6ITC3 = Itemc4;
Inst25Quest6textur3 = "INV_Crown_01"
Inst25Quest6description3 = AQITEM_HEAD..AQITEM_CLOTH
Inst25Quest6ID3 = "10751"

-----------Quest7 A
Inst25Quest7Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst25Quest7ITC1 = Itemc4;
Inst25Quest7textur1 = "INV_Pants_08"
Inst25Quest7description1 = AQITEM_LEGS..AQITEM_CLOTH
Inst25Quest7ID1 = "11123"
--ITEM2
Inst25Quest7ITC2 = Itemc4;
Inst25Quest7textur2 = "INV_Helmet_21"
Inst25Quest7description2 = AQITEM_HEAD..AQITEM_MAIL
Inst25Quest7ID2 = "11124"

-----------Quest8 A
Inst25Quest8Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst25Quest8ITC1 = Itemc3;
Inst25Quest8textur1 = "INV_Stone_03"
Inst25Quest8description1 = AQITEM_TRINKET
Inst25Quest8ID1 = "10455"

-------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
-------------------------------------

-----------Quest1 H
Inst25Quest1Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst25Quest1ITC1_HORDE = Itemc3;
Inst25Quest1textur1_HORDE = "INV_Jewelry_Talisman_05"
Inst25Quest1description1_HORDE = AQITEM_TRINKET
Inst25Quest1ID1_HORDE = "1490"

-----------Quest2 H
Inst25Quest2Rewardtext_HORDE = RED..AQNoReward

-----------Quest3 H
Inst25Quest3Rewardtext_HORDE = RED..AQNoReward

-----------Quest4 H
Inst25Quest4Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst25Quest4ITC1_HORDE = Itemc3;
Inst25Quest4textur1_HORDE = "INV_Box_01"
Inst25Quest4description1_HORDE = ""
Inst25Quest4ID1_HORDE = "10773"

-----------Quest5 H
Inst25Quest5Rewardtext_HORDE = RED..AQNoReward

-----------Quest6 H
Inst25Quest6Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst25Quest6ITC1_HORDE = Itemc4;
Inst25Quest6textur1_HORDE = "INV_Helmet_22"
Inst25Quest6description1_HORDE = AQITEM_HEAD..AQITEM_PLATE
Inst25Quest6ID1_HORDE = "10749"
--ITEM2
Inst25Quest6ITC2_HORDE = Itemc4;
Inst25Quest6textur2_HORDE = "INV_Sword_21"
Inst25Quest6description2_HORDE = AQITEM_ONEHAND..AQITEM_DAGGER
Inst25Quest6ID2_HORDE = "10750"
--ITEM3
Inst25Quest6ITC3_HORDE = Itemc4;
Inst25Quest6textur3_HORDE = "INV_Crown_01"
Inst25Quest6description3_HORDE = AQITEM_HEAD..AQITEM_CLOTH
Inst25Quest6ID3_HORDE = "10751"

-----------Quest7 H
Inst25Quest7Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst25Quest7ITC1_HORDE = Itemc4;
Inst25Quest7textur1_HORDE = "INV_Pants_08"
Inst25Quest7description1_HORDE = AQITEM_LEGS..AQITEM_CLOTH
Inst25Quest7ID1_HORDE = "11123"
--ITEM2
Inst25Quest7ITC2_HORDE = Itemc4;
Inst25Quest7textur2_HORDE = "INV_Helmet_21"
Inst25Quest7description2_HORDE = AQITEM_HEAD..AQITEM_MAIL
Inst25Quest7ID2_HORDE = "11124"

-----------Quest8 H
Inst25Quest8Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst25Quest8ITC1_HORDE = Itemc3;
Inst25Quest8textur1_HORDE = "INV_Stone_03"
Inst25Quest8description1_HORDE = AQITEM_TRINKET
Inst25Quest8ID1_HORDE = "10455"

------------------------------- BSF/Inst 21 --------------------------------------------------------------------
-----------Quest1 A
Inst21Quest1Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst21Quest1ITC1 = Itemc4;
Inst21Quest1textur1 = "INV_Hammer_05"
Inst21Quest1description1 = AQITEM_TWOHAND..AQITEM_MACE
Inst21Quest1ID1 = "6953"

-----------Quest3 A
Inst21Quest3Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst21Quest3ITC1 = Itemc3;
Inst21Quest3textur1 = "INV_Misc_Orb_03"
Inst21Quest3description1 = AQITEM_OFFHAND
Inst21Quest3ID1 = "6898"
--ITEM1
Inst21Quest3ITC2 = Itemc3;
Inst21Quest3textur2 = "INV_Staff_09"
Inst21Quest3description2 = AQITEM_STAFF
Inst21Quest3ID2 = "15109"

-------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
-------------------------------------

-----------Quest1 H
Inst21Quest1Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst21Quest1ITC1_HORDE = Itemc3;
Inst21Quest1textur1_HORDE = "INV_Shoulder_09"
Inst21Quest1description1_HORDE = AQITEM_SHOULDER..AQITEM_CLOTH
Inst21Quest1ID1_HORDE = "3324"

-----------Quest2 H
Inst21Quest2Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst21Quest2ITC1_HORDE = Itemc3;
Inst21Quest2textur1_HORDE = "INV_Boots_03"
Inst21Quest2description1_HORDE = AQITEM_FEET..AQITEM_LEATHER
Inst21Quest2ID1_HORDE = "6335"
--ITEM2
Inst21Quest2ITC2_HORDE = Itemc3;
Inst21Quest2textur2_HORDE = "INV_Bracer_06"
Inst21Quest2description2_HORDE = AQITEM_WRIST..AQITEM_MAIL
Inst21Quest2ID2_HORDE = "4534"

-----------Quest3 H
Inst21Quest3Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst21Quest3ITC1_HORDE = Itemc4;
Inst21Quest3textur1_HORDE = "INV_Jewelry_Ring_15"
Inst21Quest3description1_HORDE = AQITEM_RING
Inst21Quest3ID1_HORDE = "6414"

-----------Quest4 A
Inst21Quest4Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst21Quest4ITC1_HORDE = Itemc3;
Inst21Quest4textur1_HORDE = "INV_Misc_Orb_03"
Inst21Quest4description1_HORDE = AQITEM_OFFHAND
Inst21Quest4ID1_HORDE = "6898"
--ITEM1
Inst21Quest4ITC2_HORDE = Itemc3;
Inst21Quest4textur2_HORDE = "INV_Staff_09"
Inst21Quest4description2_HORDE = AQITEM_STAFF
Inst21Quest4ID2_HORDE = "15109"

------------------------------- BRD/Inst 5 --------------------------------------------------------------------
-----------Quest1 A
Inst5Quest1Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst5Quest1ITC1 = Itemc2;
Inst5Quest1textur1 = "INV_Misc_Key_08"
Inst5Quest1description1 = AQITEM_KEY
Inst5Quest1ID1 = "11000"

-----------Quest2 A
Inst5Quest2Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst5Quest2ITC1 = Itemc3;
Inst5Quest2textur1 = "INV_Boots_02"
Inst5Quest2description1 = AQITEM_FEET..AQITEM_CLOTH
Inst5Quest2ID1 = "11865"
--ITEM2
Inst5Quest2ITC2 = Itemc3;
Inst5Quest2textur2 = "INV_Shoulder_25"
Inst5Quest2description2 = AQITEM_SHOULDER..AQITEM_LEATHER
Inst5Quest2ID2 = "11963"
--ITEM3
Inst5Quest2ITC3 = Itemc3;
Inst5Quest2textur3 = "INV_Chest_Chain_16"
Inst5Quest2description3 = AQITEM_CHEST..AQITEM_MAIL
Inst5Quest2ID3 = "12049"

-----------Quest3 A
Inst5Quest3Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst5Quest3ITC1 = Itemc4;
Inst5Quest3textur1 = "INV_Bracer_13"
Inst5Quest3description1 = AQITEM_WRIST..AQITEM_CLOTH
Inst5Quest3ID1 = "11962"
--ITEM2
Inst5Quest3ITC2 = Itemc4;
Inst5Quest3textur2 = "INV_Belt_11"
Inst5Quest3description2 = AQITEM_WAIST..AQITEM_LEATHER
Inst5Quest3ID2 = "11866"

-----------Quest4 A
Inst5Quest4Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1(x10)"..AQDiscription_AND..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst5Quest4ITC1 = Itemc2;
Inst5Quest4textur1 = "INV_Drink_05"
Inst5Quest4description1 = ""
Inst5Quest4ID1 = "12003"
--ITEM2
Inst5Quest4ITC2 = Itemc3;
Inst5Quest4textur2 = "INV_Mace_08"
Inst5Quest4description2 = AQITEM_MAINHAND..AQITEM_MACE
Inst5Quest4ID2 = "11964"
--ITEM3
Inst5Quest4ITC3 = Itemc3;
Inst5Quest4textur3 = "INV_Axe_02"
Inst5Quest4description3 = AQITEM_TWOHAND..AQITEM_AXE
Inst5Quest4ID3 = "12000"


-----------Quest5 A
Inst5Quest5Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"..AQDiscription_OR..WHITE.."4"
--ITEM1
Inst5Quest5ITC1 = Itemc3;
Inst5Quest5textur1 = "INV_Misc_Cape_08"
Inst5Quest5description1 = AQITEM_BACK
Inst5Quest5ID1 = "12113"
--ITEM2
Inst5Quest5ITC2 = Itemc3;
Inst5Quest5textur2 = "INV_Gauntlets_17"
Inst5Quest5description2 = AQITEM_HANDS..AQITEM_LEATHER
Inst5Quest5ID2 = "12114"
--ITEM3
Inst5Quest5ITC3 = Itemc3;
Inst5Quest5textur3 = "INV_Bracer_17"
Inst5Quest5description3 = AQITEM_WRIST..AQITEM_MAIL
Inst5Quest5ID3 = "12112"
--ITEM4
Inst5Quest5ITC4 = Itemc3;
Inst5Quest5textur4 = "INV_Belt_34"
Inst5Quest5description4 = AQITEM_WAIST..AQITEM_PLATE
Inst5Quest5ID4 = "12115"

-----------Quest6 A
Inst5Quest6Rewardtext = RED..AQNoReward

-----------Quest7 A
Inst5Quest7Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst5Quest7ITC1 = Itemc2;
Inst5Quest7textur1 = "INV_Misc_Bag_09_Black"
Inst5Quest7description1 = ""
Inst5Quest7ID1 = "11883"

-----------Quest8 A
Inst5Quest8Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst5Quest8ITC1 = Itemc3;
Inst5Quest8textur1 = "INV_Helmet_01"
Inst5Quest8description1 = AQITEM_HEAD..AQITEM_MAIL
Inst5Quest8ID1 = "12018"
--ITEM2
Inst5Quest8ITC2 = Itemc3;
Inst5Quest8textur2 = "INV_Boots_Plate_01"
Inst5Quest8description2 = AQITEM_FEET..AQITEM_PLATE
Inst5Quest8ID2 = "12021"
--ITEM3
Inst5Quest8ITC3 = Itemc3;
Inst5Quest8textur3 = "INV_Pants_13"
Inst5Quest8description3 = AQITEM_LEGS..AQITEM_LEATHER
Inst5Quest8ID3 = "12041"

-----------Quest9 A
Inst5Quest9Rewardtext = RED..AQNoReward

-----------Quest10 A
Inst5Quest10Rewardtext = RED..AQNoReward

-----------Quest11 A
Inst5Quest11Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst5Quest11ITC1 = Itemc3;
Inst5Quest11textur1 = "INV_Jewelry_Talisman_02"
Inst5Quest11description1 = AQITEM_TRINKET
Inst5Quest11ID1 = "12065"
--ITEM2
Inst5Quest11ITC2 = Itemc3;
Inst5Quest11textur2 = "INV_Sword_26"
Inst5Quest11description2 = AQITEM_ONEHAND..AQITEM_SWORD
Inst5Quest11ID2 = "12061"
--ITEM3
Inst5Quest11ITC3 = Itemc3;
Inst5Quest11textur3 = "INV_Sword_21"
Inst5Quest11description3 = AQITEM_ONEHAND..AQITEM_DAGGER
Inst5Quest11ID3 = "12062"

-----------Quest12 A
Inst5Quest12Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst5Quest12ITC1 = Itemc3;
Inst5Quest12textur1 = "INV_Misc_Cape_02"
Inst5Quest12description1 = AQITEM_BACK
Inst5Quest12ID1 = "12066"
--ITEM2
Inst5Quest12ITC2 = Itemc3;
Inst5Quest12textur2 = "INV_Shoulder_16"
Inst5Quest12description2 = AQITEM_SHOULDER..AQITEM_LEATHER
Inst5Quest12ID2 = "12082"
--ITEM3
Inst5Quest12ITC3 = Itemc3;
Inst5Quest12textur3 = "INV_Belt_11"
Inst5Quest12description3 = AQITEM_WAIST..AQITEM_CLOTH
Inst5Quest12ID3 = "12083"

-----------Quest13 A
Inst5Quest13Rewardtext = RED..AQNoReward

-----------Quest14 A
Inst5Quest14Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst5Quest14ITC1 = Itemc4;
Inst5Quest14textur1 = "INV_Jewelry_Ring_05"
Inst5Quest14description1 = AQITEM_RING
Inst5Quest14ID1 = "12548"
--ITEM2
Inst5Quest14ITC2 = Itemc4;
Inst5Quest14textur2 = "INV_Jewelry_Ring_05"
Inst5Quest14description2 = AQITEM_RING
Inst5Quest14ID2 = "12543"
-------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
-------------------------------------

-----------Quest1 H
Inst5Quest1Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst5Quest1ITC1_HORDE = Itemc2;
Inst5Quest1textur1_HORDE = "INV_Misc_Key_08"
Inst5Quest1description1_HORDE = AQITEM_KEY
Inst5Quest1ID1_HORDE = "11000"

-----------Quest2 H
Inst5Quest2Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst5Quest2ITC1_HORDE = Itemc3;
Inst5Quest2textur1_HORDE = "INV_Boots_02"
Inst5Quest2description1_HORDE = AQITEM_FEET..AQITEM_CLOTH
Inst5Quest2ID1_HORDE = "11865"
--ITEM2
Inst5Quest2ITC2_HORDE = Itemc3;
Inst5Quest2textur2_HORDE = "INV_Shoulder_25"
Inst5Quest2description2_HORDE = AQITEM_SHOULDER..AQITEM_LEATHER
Inst5Quest2ID2_HORDE = "11963"
--ITEM3
Inst5Quest2ITC3_HORDE = Itemc3;
Inst5Quest2textur3_HORDE = "INV_Chest_Chain_16"
Inst5Quest2description3_HORDE = AQITEM_CHEST..AQITEM_MAIL
Inst5Quest2ID3_HORDE = "12049"

-----------Quest3 H
Inst5Quest3Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst5Quest3ITC1_HORDE = Itemc4;
Inst5Quest3textur1_HORDE = "INV_Bracer_13"
Inst5Quest3description1_HORDE = AQITEM_WRIST..AQITEM_CLOTH
Inst5Quest3ID1_HORDE = "11962"
--ITEM2
Inst5Quest3ITC2_HORDE = Itemc4;
Inst5Quest3textur2_HORDE = "INV_Belt_11"
Inst5Quest3description2_HORDE = AQITEM_WAIST..AQITEM_LEATHER
Inst5Quest3ID2_HORDE = "11866"

-----------Quest4 H
Inst5Quest4Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1(x5)"..AQDiscription_AND..WHITE.."2(x5)"..AQDiscription_OR..WHITE.."3"..AQDiscription_OR..WHITE.."4"
--ITEM1
Inst5Quest4ITC1_HORDE = Itemc2;
Inst5Quest4textur1_HORDE = "INV_Potion_53"
Inst5Quest4description1_HORDE = AQITEM_POTION
Inst5Quest4ID1_HORDE = "3928"
--ITEM2
Inst5Quest4ITC2_HORDE = Itemc2;
Inst5Quest4textur2_HORDE = "INV_Potion_73"
Inst5Quest4description2_HORDE = AQITEM_POTION
Inst5Quest4ID2_HORDE = "6149"
--ITEM3
Inst5Quest4ITC3_HORDE = Itemc3;
Inst5Quest4textur3_HORDE = "INV_Mace_08"
Inst5Quest4description3_HORDE = AQITEM_MAINHAND..AQITEM_MACE
Inst5Quest4ID3_HORDE = "11964"
--ITEM4
Inst5Quest4ITC4_HORDE = Itemc3;
Inst5Quest4textur4_HORDE = "INV_Axe_02"
Inst5Quest4description4_HORDE = AQITEM_TWOHAND..AQITEM_AXE
Inst5Quest4ID4_HORDE = "12000"

-----------Quest5 H
Inst5Quest5Rewardtext_HORDE = RED..AQNoReward

-----------Quest6 H
Inst5Quest6Rewardtext_HORDE = RED..AQNoReward

-----------Quest7 H
Inst5Quest7Rewardtext_HORDE = RED..AQNoReward

-----------Quest8 H
Inst5Quest8Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst5Quest8ITC1_HORDE = Itemc4;
Inst5Quest8textur1_HORDE = "INV_Jewelry_Amulet_03"
Inst5Quest8description1_HORDE = AQITEM_NECK
Inst5Quest8ID1_HORDE = "12059"

-----------Quest9 H
Inst5Quest9Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"..AQDiscription_OR..WHITE.."4"
--ITEM1
Inst5Quest9ITC1_HORDE = Itemc3;
Inst5Quest9textur1_HORDE = "INV_Shoulder_02"
Inst5Quest9description1_HORDE = AQITEM_BACK
Inst5Quest9ID1_HORDE = "12109"
--ITEM2
Inst5Quest9ITC2_HORDE = Itemc3;
Inst5Quest9textur2_HORDE = "INV_Misc_Cape_16"
Inst5Quest9description2_HORDE = AQITEM_BACK
Inst5Quest9ID2_HORDE = "12110"
--ITEM3
Inst5Quest9ITC3_HORDE = Itemc3;
Inst5Quest9textur3_HORDE = "INV_Chest_Chain_16"
Inst5Quest9description3_HORDE = AQITEM_CHEST..AQITEM_MAIL
Inst5Quest9ID3_HORDE = "12108"
--ITEM4
Inst5Quest9ITC4_HORDE = Itemc3;
Inst5Quest9textur4_HORDE = "INV_Gauntlets_26"
Inst5Quest9description4_HORDE = AQITEM_HANDS..AQITEM_PLATE
Inst5Quest9ID4_HORDE = "12111"

-----------Quest10 H
Inst5Quest10Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst5Quest10ITC1_HORDE = Itemc3;
Inst5Quest10textur1_HORDE = "INV_Misc_Cape_02"
Inst5Quest10description1_HORDE = AQITEM_BACK
Inst5Quest10ID1_HORDE = "12066"
--ITEM2
Inst5Quest10ITC2_HORDE = Itemc3;
Inst5Quest10textur2_HORDE = "INV_Shoulder_16"
Inst5Quest10description2_HORDE = AQITEM_SHOULDER..AQITEM_LEATHER
Inst5Quest10ID2_HORDE = "12082"
--ITEM3
Inst5Quest10ITC3_HORDE = Itemc3;
Inst5Quest10textur3_HORDE = "INV_Belt_11"
Inst5Quest10description3_HORDE = AQITEM_WAIST..AQITEM_CLOTH
Inst5Quest10ID3_HORDE = "12083"

-----------Quest11 H
Inst5Quest11Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"..AQDiscription_OR..WHITE.."4"
--ITEM1
Inst5Quest11ITC1_HORDE = Itemc3;
Inst5Quest11textur1_HORDE = "INV_Misc_Cape_08"
Inst5Quest11description1_HORDE = AQITEM_BACK
Inst5Quest11ID1_HORDE = "12113"
--ITEM2
Inst5Quest11ITC2_HORDE = Itemc3;
Inst5Quest11textur2_HORDE = "INV_Gauntlets_17"
Inst5Quest11description2_HORDE = AQITEM_HANDS..AQITEM_LEATHER
Inst5Quest11ID2_HORDE = "12114"
--ITEM3
Inst5Quest11ITC3_HORDE = Itemc3;
Inst5Quest11textur3_HORDE = "INV_Bracer_17"
Inst5Quest11description3_HORDE = AQITEM_WRIST..AQITEM_MAIL
Inst5Quest11ID3_HORDE = "12112"
--ITEM4
Inst5Quest11ITC4_HORDE = Itemc3;
Inst5Quest11textur4_HORDE = "INV_Belt_34"
Inst5Quest11description4_HORDE = AQITEM_WAIST..AQITEM_PLATE
Inst5Quest11ID4_HORDE = "12115"

-----------Quest12 H
Inst5Quest12Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"
--ITEM1
Inst5Quest12ITC1_HORDE = Itemc3;
Inst5Quest12textur1_HORDE = "INV_Jewelry_Ring_03"
Inst5Quest12description1_HORDE = AQITEM_RING
Inst5Quest12ID1_HORDE = "12038"

-----------Quest13 H
Inst5Quest13Rewardtext_HORDE = RED..AQNoReward

-----------Quest14 H
Inst5Quest14Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst5Quest14ITC1_HORDE = Itemc4;
Inst5Quest14textur1_HORDE = "INV_Jewelry_Ring_05"
Inst5Quest14description1_HORDE = AQITEM_RING
Inst5Quest14ID1_HORDE = "12544"
--ITEM2
Inst5Quest14ITC2_HORDE = Itemc4;
Inst5Quest14textur2_HORDE = "INV_Jewelry_Ring_05"
Inst5Quest14description2_HORDE = AQITEM_RING
Inst5Quest14ID2_HORDE = "12545"


------------------------------- Gnomeregan/Inst 29 --------------------------------------------------------------------
-----------Quest1 A
Inst29Quest1Rewardtext = RED..AQNoReward

-----------Quest2 A
Inst29Quest2Rewardtext = RED..AQNoReward

-----------Quest3 A
Inst29Quest3Rewardtext = RED..AQNoReward


-----------Quest4 A
Inst29Quest4Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst29Quest4ITC1 = Itemc3;
Inst29Quest4textur1 = "INV_Misc_Wrench_01"
Inst29Quest4description1 = AQITEM_OFFHAND..AQITEM_AXE
Inst29Quest4ID1 = "9608"
--ITEM2
Inst29Quest4ITC2 = Itemc3;
Inst29Quest4textur2 = "INV_Gauntlets_27"
Inst29Quest4description2 = AQITEM_HANDS..AQITEM_CLOTH
Inst29Quest4ID2 = "9609"

-----------Quest5 A
Inst29Quest5Rewardtext = RED..AQNoReward

-----------Quest6 A
Inst29Quest6Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_AND..WHITE.."2"
--ITEM1
Inst29Quest6ITC1 = Itemc3;
Inst29Quest6textur1 = "INV_Misc_Cape_06"
Inst29Quest6description1 = AQITEM_BACK
Inst29Quest6ID1 = "9605"
--ITEM2
Inst29Quest6ITC2 = Itemc3;
Inst29Quest6textur2 = "INV_Mace_04"
Inst29Quest6description2 = AQITEM_TWOHAND..AQITEM_MACE
Inst29Quest6ID2 = "9604"

-----------Quest7 A
Inst29Quest7Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst29Quest7ITC1 = Itemc3;
Inst29Quest7textur1 = "INV_Bracer_02"
Inst29Quest7description1 = AQITEM_WRIST..AQITEM_MAIL
Inst29Quest7ID1 = "9535"
--ITEM2
Inst29Quest7ITC2 = Itemc3;
Inst29Quest7textur2 = "INV_Shoulder_02"
Inst29Quest7description2 = AQITEM_SHOULDER..AQITEM_CLOTH
Inst29Quest7ID2 = "9536"

-----------Quest8 A
Inst29Quest8Rewardtext = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst29Quest8ITC1 = Itemc4;
Inst29Quest8textur1 = "INV_Chest_Cloth_18."
Inst29Quest8description1 = AQITEM_CHEST..AQITEM_CLOTH
Inst29Quest8ID1 = "9623"
--ITEM2
Inst29Quest8ITC2 = Itemc4;
Inst29Quest8textur2 = "INV_Pants_08"
Inst29Quest8description2 = AQITEM_LEGS..AQITEM_LEATHER
Inst29Quest8ID2 = "9624"
--ITEM3
Inst29Quest8ITC3 = Itemc4;
Inst29Quest8textur3 = "INV_Pants_03"
Inst29Quest8description3 = AQITEM_LEGS..AQITEM_MAIL
Inst29Quest8ID3 = "9625"

-------------------------------------
--        + +   +   +++   ++   +++
--        +++  + +  + +   + +  ++
--        + +   +   +  +  ++   +++
-------------------------------------

-----------Quest1 H
Inst29Quest1Rewardtext_HORDE = RED..AQNoReward

-----------Quest2 H
Inst29Quest2Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"
--ITEM1
Inst29Quest2ITC1_HORDE = Itemc3;
Inst29Quest2textur1_HORDE = "INV_Bracer_02"
Inst29Quest2description1_HORDE = AQITEM_WRIST..AQITEM_MAIL
Inst29Quest2ID1_HORDE = "9535"
--ITEM2
Inst29Quest2ITC2_HORDE = Itemc3;
Inst29Quest2textur2_HORDE = "INV_Shoulder_02"
Inst29Quest2description2_HORDE = AQITEM_SHOULDER..AQITEM_CLOTH
Inst29Quest2ID2_HORDE = "9536"

-----------Quest3 H
Inst29Quest3Rewardtext_HORDE = GREEN..AQDiscription_REWARD..WHITE.."1"..AQDiscription_OR..WHITE.."2"..AQDiscription_OR..WHITE.."3"
--ITEM1
Inst29Quest3ITC1_HORDE = Itemc4;
Inst29Quest3textur1_HORDE = "INV_Chest_Cloth_18."
Inst29Quest3description1_HORDE = AQITEM_CHEST..AQITEM_CLOTH
Inst29Quest3ID1_HORDE = "9623"
--ITEM2
Inst29Quest3ITC2_HORDE = Itemc4;
Inst29Quest3textur2_HORDE = "INV_Pants_08"
Inst29Quest3description2_HORDE = AQITEM_LEGS..AQITEM_LEATHER
Inst29Quest3ID2_HORDE = "9624"
--ITEM3
Inst29Quest3ITC3_HORDE = Itemc4;
Inst29Quest3textur3_HORDE = "INV_Pants_03"
Inst29Quest3description3_HORDE = AQITEM_LEGS..AQITEM_MAIL
Inst29Quest3ID3_HORDE = "9625"