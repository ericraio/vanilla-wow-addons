--------------------------------------------------------------------------------
-- Text replacement function
--------------------------------------------------------------------------------
function AtlasLoot_FixText(text)
    --Armour class
    text = gsub(text, "#a1#", ATLASLOOT_CLOTH);
    text = gsub(text, "#a2#", ATLASLOOT_LEATHER);
    text = gsub(text, "#a3#", ATLASLOOT_MAIL);
    text = gsub(text, "#a4#", ATLASLOOT_PLATE);

    --Body slot
    text = gsub(text, "#s1#", ATLASLOOT_HEAD);
    text = gsub(text, "#s2#", ATLASLOOT_NECK);
    text = gsub(text, "#s3#", ATLASLOOT_SHOULDER);
    text = gsub(text, "#s4#", ATLASLOOT_BACK);
    text = gsub(text, "#s5#", ATLASLOOT_CHEST);
    text = gsub(text, "#s6#", ATLASLOOT_SHIRT);
    text = gsub(text, "#s7#", ATLASLOOT_TABARD);
    text = gsub(text, "#s8#", ATLASLOOT_WRIST);
    text = gsub(text, "#s9#", ATLASLOOT_HANDS);
    text = gsub(text, "#s10#", ATLASLOOT_WAIST);
    text = gsub(text, "#s11#", ATLASLOOT_LEGS);
    text = gsub(text, "#s12#", ATLASLOOT_FEET);
    text = gsub(text, "#s13#", ATLASLOOT_RING);
    text = gsub(text, "#s14#", ATLASLOOT_TRINKET);
    text = gsub(text, "#s15#", ATLASLOOT_OFF_HAND);
    text = gsub(text, "#s16#", ATLASLOOT_RELIC);

    --Weapon Weilding
    text = gsub(text, "#h1#", ATLASLOOT_ONE_HAND);
    text = gsub(text, "#h2#", ATLASLOOT_TWO_HAND);
    text = gsub(text, "#h3#", ATLASLOOT_MAIN_HAND);
    text = gsub(text, "#h4#", ATLASLOOT_OFFHAND);

    --Weapon type
    text = gsub(text, "#w1#", ATLASLOOT_AXE);
    text = gsub(text, "#w2#", ATLASLOOT_BOW);
    text = gsub(text, "#w3#", ATLASLOOT_CROSSBOW);
    text = gsub(text, "#w4#", ATLASLOOT_DAGGER);
    text = gsub(text, "#w5#", ATLASLOOT_GUN);
    text = gsub(text, "#w6#", ATLASLOOT_MACE);
    text = gsub(text, "#w7#", ATLASLOOT_POLEARM);
    text = gsub(text, "#w8#", ATLASLOOT_SHIELD);
    text = gsub(text, "#w9#", ATLASLOOT_STAFF);
    text = gsub(text, "#w10#", ATLASLOOT_SWORD);
    text = gsub(text, "#w11#", ATLASLOOT_THROWN);
    text = gsub(text, "#w12#", ATLASLOOT_WAND);
    text = gsub(text, "#w13#", ATLASLOOT_FIST);

    -- Misc. Equipment
    text = gsub(text, "#e1#", ATLASLOOT_POTION);
    text = gsub(text, "#e2#", ATLASLOOT_FOOD);
    text = gsub(text, "#e3#", ATLASLOOT_DRINK);
    text = gsub(text, "#e4#", ATLASLOOT_BANDAGE);
    text = gsub(text, "#e5#", ATLASLOOT_ARROW);
    text = gsub(text, "#e6#", ATLASLOOT_BULLET);
    text = gsub(text, "#e7#", ATLASLOOT_MOUNT);
    text = gsub(text, "#e8#", ATLASLOOT_AMMO);
    text = gsub(text, "#e9#", ATLASLOOT_QUIVER);
    text = gsub(text, "#e10#", ATLASLOOT_BAG);
    text = gsub(text, "#e11#", ATLASLOOT_ENCHANT);
    text = gsub(text, "#e12#", ATLASLOOT_TRADE_GOODS);
    text = gsub(text, "#e13#", ATLASLOOT_SCOPE);
    text = gsub(text, "#e14#", ATLASLOOT_KEY);
    text = gsub(text, "#e15#", ATLASLOOT_PET);
    text = gsub(text, "#e16#", ATLASLOOT_IDOL);
    text = gsub(text, "#e17#", ATLASLOOT_TOTEM);
    text = gsub(text, "#e18#", ATLASLOOT_LIBRAM);
    text = gsub(text, "#e19#", ATLASLOOT_DARKMOON);
    text = gsub(text, "#e20#", ATLASLOOT_BOOK);
    text = gsub(text, "#e21#", ATLASLOOT_BANNER);

    -- Classes
    text = gsub(text, "#c1#", ATLASLOOT_DRUID);
    text = gsub(text, "#c2#", ATLASLOOT_HUNTER);
    text = gsub(text, "#c3#", ATLASLOOT_MAGE);
    text = gsub(text, "#c4#", ATLASLOOT_PALADIN);
    text = gsub(text, "#c5#", ATLASLOOT_PRIEST);
    text = gsub(text, "#c6#", ATLASLOOT_ROGUE);
    text = gsub(text, "#c7#", ATLASLOOT_SHAMAN);
    text = gsub(text, "#c8#", ATLASLOOT_WARLOCK);
    text = gsub(text, "#c9#", ATLASLOOT_WARRIOR);

    --Professions
    text = gsub(text, "#p1#", ATLASLOOT_ALCHEMY);
    text = gsub(text, "#p2#", ATLASLOOT_BLACKSMITHING);
    text = gsub(text, "#p3#", ATLASLOOT_COOKING);
    text = gsub(text, "#p4#", ATLASLOOT_ENCHANTING);
    text = gsub(text, "#p5#", ATLASLOOT_ENGINEERING);
    text = gsub(text, "#p6#", ATLASLOOT_FIRST_AID);
    text = gsub(text, "#p7#", ATLASLOOT_LEATHERWORKING);
    text = gsub(text, "#p8#", ATLASLOOT_TAILORING);
    text = gsub(text, "#p9#", ATLASLOOT_DRAGONSCALE);
    text = gsub(text, "#p10#", ATLASLOOT_TRIBAL);
    text = gsub(text, "#p11#", ATLASLOOT_ELEMENTAL);

    --Reputation
    text = gsub(text, "#r1#", ATLASLOOT_NEUTRAL);
    text = gsub(text, "#r2#", ATLASLOOT_FRIENDLY);
    text = gsub(text, "#r3#", ATLASLOOT_HONORED);
    text = gsub(text, "#r4#", ATLASLOOT_REVERED);
    text = gsub(text, "#r5#", ATLASLOOT_EXALTED);

    --Battleground Factions
    text = gsub(text, "#b1#", ATLASLOOT_BG_STORMPIKE);
    text = gsub(text, "#b2#", ATLASLOOT_BG_FROSTWOLF);
    text = gsub(text, "#b3#", ATLASLOOT_BG_SENTINELS);
    text = gsub(text, "#b4#", ATLASLOOT_BG_OUTRIDERS);
    text = gsub(text, "#b5#", ATLASLOOT_BG_ARATHOR);
    text = gsub(text, "#b6#", ATLASLOOT_BG_DEFILERS);

    -- Misc phrases and mod specific stuff
    text = gsub(text, "#m1#", ATLASLOOT_CLASSES);
    text = gsub(text, "#m2#", ATLASLOOT_QUEST1);
    text = gsub(text, "#m3#", ATLASLOOT_QUEST2);
    text = gsub(text, "#m4#", ATLASLOOT_QUEST3);
    text = gsub(text, "#m5#", ATLASLOOT_SHARED);
    text = gsub(text, "#m6#", ATLASLOOT_HORDE);
    text = gsub(text, "#m7#", ATLASLOOT_ALLIANCE);
    text = gsub(text, "#m8#", ATLASLOOT_UNIQUE);
    text = gsub(text, "#m9#", ATLASLOOT_RIGHTSIDE);
    text = gsub(text, "#m10#", ATLASLOOT_LEFTSIDE);
    text = gsub(text, "#m11#", ATLASLOOT_FELCOREBAG);
    text = gsub(text, "#m12#", ATLASLOOT_ONYBAG);
    text = gsub(text, "#m13#", ATLASLOOT_WCBAG);
    text = gsub(text, "#m14#", ATLASLOOT_FULLSKILL);
    text = gsub(text, "#m15#", ATLASLOOT_295);
    text = gsub(text, "#m16#", ATLASLOOT_275);
    text = gsub(text, "#m17#", ATLASLOOT_265);
    text = gsub(text, "#m18#", ATLASLOOT_290);
    text = gsub(text, "#m19#", ATLASLOOT_SET);
    text = gsub(text, "#m20#", ATLASLOOT_285);
    text = gsub(text, "#m21#", ATLASLOOT_16SLOT);

    text = gsub(text, "#x1#", ATLASLOOT_COBRAHN);
    text = gsub(text, "#x2#", ATLASLOOT_ANACONDRA);
    text = gsub(text, "#x3#", ATLASLOOT_SERPENTIS);
    text = gsub(text, "#x4#", ATLASLOOT_FANGDRUID);
    text = gsub(text, "#x5#", ATLASLOOT_PYTHAS);
    text = gsub(text, "#x6#", ATLASLOOT_VANCLEEF);
    text = gsub(text, "#x7#", ATLASLOOT_GREENSKIN);
    text = gsub(text, "#x8#", ATLASLOOT_DEFIASMINER);
    text = gsub(text, "#x9#", ATLASLOOT_DEFIASOVERSEER);
    text = gsub(text, "#x10#", ATLASLOOT_Primal_Hakkari_Kossack);
    text = gsub(text, "#x11#", ATLASLOOT_Primal_Hakkari_Shawl);
    text = gsub(text, "#x12#", ATLASLOOT_Primal_Hakkari_Bindings);
    text = gsub(text, "#x13#", ATLASLOOT_Primal_Hakkari_Sash);
    text = gsub(text, "#x14#", ATLASLOOT_Primal_Hakkari_Stanchion);
    text = gsub(text, "#x15#", ATLASLOOT_Primal_Hakkari_Aegis);
    text = gsub(text, "#x16#", ATLASLOOT_Primal_Hakkari_Girdle);
    text = gsub(text, "#x17#", ATLASLOOT_Primal_Hakkari_Armsplint);
    text = gsub(text, "#x18#", ATLASLOOT_Primal_Hakkari_Tabard);
    text = gsub(text, "#x19#", ATLASLOOT_Qiraji_Ornate_Hilt);
    text = gsub(text, "#x20#", ATLASLOOT_Qiraji_Martial_Drape);
    text = gsub(text, "#x21#", ATLASLOOT_Qiraji_Magisterial_Ring);
    text = gsub(text, "#x22#", ATLASLOOT_Qiraji_Ceremonial_Ring);
    text = gsub(text, "#x23#", ATLASLOOT_Qiraji_Regal_Drape);
    text = gsub(text, "#x24#", ATLASLOOT_Qiraji_Spiked_Hilt);
    text = gsub(text, "#x25#", ATLASLOOT_Qiraji_Bindings_of_Dominance);
    text = gsub(text, "#x26#", ATLASLOOT_Veknilashs_Circlet);
    text = gsub(text, "#x27#", ATLASLOOT_Ouros_Intact_Hide);
    text = gsub(text, "#x28#", ATLASLOOT_Husk_of_the_Old_God);
    text = gsub(text, "#x29#", ATLASLOOT_Qiraji_Bindings_of_Command);
    text = gsub(text, "#x30#", ATLASLOOT_Veklors_Diadem);
    text = gsub(text, "#x31#", ATLASLOOT_Skin_of_the_Great_Sandworm);
    text = gsub(text, "#x32#", ATLASLOOT_Carapace_of_the_Old_God);
    text = gsub(text, "#x33#", ATLASLOOT_SCARLETDEFENDER);
    text = gsub(text, "#x34#", ATLASLOOT_SCARLETTRASH);
    text = gsub(text, "#x35#", ATLASLOOT_SCARLETCHAMPION);
    text = gsub(text, "#x36#", ATLASLOOT_SCARLETCENTURION);
    text = gsub(text, "#x37#", ATLASLOOT_SCARLETHEROD);
    text = gsub(text, "#x38#", ATLASLOOT_SCARLETPROTECTOR);
    
    --Zg Sets
    text = gsub(text, "#zgs1#", ATLASLOOT_ZG_DRUID);
    text = gsub(text, "#zgs2#", ATLASLOOT_ZG_HUNTER);
    text = gsub(text, "#zgs3#", ATLASLOOT_ZG_MAGE);
    text = gsub(text, "#zgs4#", ATLASLOOT_ZG_PALADIN);
    text = gsub(text, "#zgs5#", ATLASLOOT_ZG_PRIEST);
    text = gsub(text, "#zgs6#", ATLASLOOT_ZG_ROGUE);
    text = gsub(text, "#zgs7#", ATLASLOOT_ZG_SHAMAN);
    text = gsub(text, "#zgs8#", ATLASLOOT_ZG_WARLOCK);
    text = gsub(text, "#zgs9#", ATLASLOOT_ZG_WARRIOR);
    
    --aq20 Sets
    text = gsub(text, "#aq20s1#", ATLASLOOT_AQ20_DRUID);
    text = gsub(text, "#aq20s2#", ATLASLOOT_AQ20_HUNTER);
    text = gsub(text, "#aq20s3#", ATLASLOOT_AQ20_MAGE);
    text = gsub(text, "#aq20s4#", ATLASLOOT_AQ20_PALADIN);
    text = gsub(text, "#aq20s5#", ATLASLOOT_AQ20_PRIEST);
    text = gsub(text, "#aq20s6#", ATLASLOOT_AQ20_ROGUE);
    text = gsub(text, "#aq20s7#", ATLASLOOT_AQ20_SHAMAN);
    text = gsub(text, "#aq20s8#", ATLASLOOT_AQ20_WARLOCK);
    text = gsub(text, "#aq20s9#", ATLASLOOT_AQ20_WARRIOR);
    
    --aq40 Sets
    text = gsub(text, "#aq40s1#", ATLASLOOT_AQ40_DRUID);
    text = gsub(text, "#aq40s2#", ATLASLOOT_AQ40_HUNTER);
    text = gsub(text, "#aq40s3#", ATLASLOOT_AQ40_MAGE);
    text = gsub(text, "#aq40s4#", ATLASLOOT_AQ40_PALADIN);
    text = gsub(text, "#aq40s5#", ATLASLOOT_AQ40_PRIEST);
    text = gsub(text, "#aq40s6#", ATLASLOOT_AQ40_ROGUE);
    text = gsub(text, "#aq40s7#", ATLASLOOT_AQ40_SHAMAN);
    text = gsub(text, "#aq40s8#", ATLASLOOT_AQ40_WARLOCK);
    text = gsub(text, "#aq40s9#", ATLASLOOT_AQ40_WARRIOR);
    
    --T0 Sets
    text = gsub(text, "#t0s1#", ATLASLOOT_T0_DRUID);
    text = gsub(text, "#t0s2#", ATLASLOOT_T0_HUNTER);
    text = gsub(text, "#t0s3#", ATLASLOOT_T0_MAGE);
    text = gsub(text, "#t0s4#", ATLASLOOT_T0_PALADIN);
    text = gsub(text, "#t0s5#", ATLASLOOT_T0_PRIEST);
    text = gsub(text, "#t0s6#", ATLASLOOT_T0_ROGUE);
    text = gsub(text, "#t0s7#", ATLASLOOT_T0_SHAMAN);
    text = gsub(text, "#t0s8#", ATLASLOOT_T0_WARLOCK);
    text = gsub(text, "#t0s9#", ATLASLOOT_T0_WARRIOR);
    
    --T0.5 Sets
    text = gsub(text, "#t05s1#", ATLASLOOT_T05_DRUID);
    text = gsub(text, "#t05s2#", ATLASLOOT_T05_HUNTER);
    text = gsub(text, "#t05s3#", ATLASLOOT_T05_MAGE);
    text = gsub(text, "#t05s4#", ATLASLOOT_T05_PALADIN);
    text = gsub(text, "#t05s5#", ATLASLOOT_T05_PRIEST);
    text = gsub(text, "#t05s6#", ATLASLOOT_T05_ROGUE);
    text = gsub(text, "#t05s7#", ATLASLOOT_T05_SHAMAN);
    text = gsub(text, "#t05s8#", ATLASLOOT_T05_WARLOCK);
    text = gsub(text, "#t05s9#", ATLASLOOT_T05_WARRIOR);
    
    --T1 Sets
    text = gsub(text, "#t1s1#", ATLASLOOT_T1_DRUID);
    text = gsub(text, "#t1s2#", ATLASLOOT_T1_HUNTER);
    text = gsub(text, "#t1s3#", ATLASLOOT_T1_MAGE);
    text = gsub(text, "#t1s4#", ATLASLOOT_T1_PALADIN);
    text = gsub(text, "#t1s5#", ATLASLOOT_T1_PRIEST);
    text = gsub(text, "#t1s6#", ATLASLOOT_T1_ROGUE);
    text = gsub(text, "#t1s7#", ATLASLOOT_T1_SHAMAN);
    text = gsub(text, "#t1s8#", ATLASLOOT_T1_WARLOCK);
    text = gsub(text, "#t1s9#", ATLASLOOT_T1_WARRIOR);
    
    --T2 Sets
    text = gsub(text, "#t2s1#", ATLASLOOT_T2_DRUID);
    text = gsub(text, "#t2s2#", ATLASLOOT_T2_HUNTER);
    text = gsub(text, "#t2s3#", ATLASLOOT_T2_MAGE);
    text = gsub(text, "#t2s4#", ATLASLOOT_T2_PALADIN);
    text = gsub(text, "#t2s5#", ATLASLOOT_T2_PRIEST);
    text = gsub(text, "#t2s6#", ATLASLOOT_T2_ROGUE);
    text = gsub(text, "#t2s7#", ATLASLOOT_T2_SHAMAN);
    text = gsub(text, "#t2s8#", ATLASLOOT_T2_WARLOCK);
    text = gsub(text, "#t2s9#", ATLASLOOT_T2_WARRIOR);
    
    --T3 Sets
    text = gsub(text, "#t3s1#", ATLASLOOT_T3_DRUID);
    text = gsub(text, "#t3s2#", ATLASLOOT_T3_HUNTER);
    text = gsub(text, "#t3s3#", ATLASLOOT_T3_MAGE);
    text = gsub(text, "#t3s4#", ATLASLOOT_T3_PALADIN);
    text = gsub(text, "#t3s5#", ATLASLOOT_T3_PRIEST);
    text = gsub(text, "#t3s6#", ATLASLOOT_T3_ROGUE);
    text = gsub(text, "#t3s7#", ATLASLOOT_T3_SHAMAN);
    text = gsub(text, "#t3s8#", ATLASLOOT_T3_WARLOCK);
    text = gsub(text, "#t3s9#", ATLASLOOT_T3_WARRIOR);
    
    --PvP Epic Horde Sets
    text = gsub(text, "#pvpeh1#", ATLASLOOT_PVP_EPIC_H_DRUID);
    text = gsub(text, "#pvpeh2#", ATLASLOOT_PVP_EPIC_H_HUNTER);
    text = gsub(text, "#pvpeh3#", ATLASLOOT_PVP_EPIC_H_MAGE);
    text = gsub(text, "#pvpeh4#", ATLASLOOT_PVP_EPIC_H_PRIEST);
    text = gsub(text, "#pvpeh5#", ATLASLOOT_PVP_EPIC_H_ROGUE);
    text = gsub(text, "#pvpeh6#", ATLASLOOT_PVP_EPIC_H_SHAMAN);
    text = gsub(text, "#pvpeh7#", ATLASLOOT_PVP_EPIC_H_WARLOCK);
    text = gsub(text, "#pvpeh8#", ATLASLOOT_PVP_EPIC_H_WARRIOR);
    
    --PvP Epic Alliance Sets
    text = gsub(text, "#pvpea1#", ATLASLOOT_PVP_EPIC_A_DRUID);
    text = gsub(text, "#pvpea2#", ATLASLOOT_PVP_EPIC_A_HUNTER);
    text = gsub(text, "#pvpea3#", ATLASLOOT_PVP_EPIC_A_MAGE);
    text = gsub(text, "#pvpea4#", ATLASLOOT_PVP_EPIC_A_PALADIN);
    text = gsub(text, "#pvpea5#", ATLASLOOT_PVP_EPIC_A_PRIEST);
    text = gsub(text, "#pvpea6#", ATLASLOOT_PVP_EPIC_A_ROGUE);
    text = gsub(text, "#pvpea7#", ATLASLOOT_PVP_EPIC_A_WARLOCK);
    text = gsub(text, "#pvpea8#", ATLASLOOT_PVP_EPIC_A_WARRIOR);
    
    --PvP Rare Horde Sets
    text = gsub(text, "#pvprh1#", ATLASLOOT_PVP_RARE_H_DRUID);
    text = gsub(text, "#pvprh2#", ATLASLOOT_PVP_RARE_H_HUNTER);
    text = gsub(text, "#pvprh3#", ATLASLOOT_PVP_RARE_H_MAGE);
    text = gsub(text, "#pvprh4#", ATLASLOOT_PVP_RARE_H_PRIEST);
    text = gsub(text, "#pvprh5#", ATLASLOOT_PVP_RARE_H_ROGUE);
    text = gsub(text, "#pvprh6#", ATLASLOOT_PVP_RARE_H_SHAMAN);
    text = gsub(text, "#pvprh7#", ATLASLOOT_PVP_RARE_H_WARLOCK);
    text = gsub(text, "#pvprh8#", ATLASLOOT_PVP_RARE_H_WARRIOR);
    
    --PvP Rare Alliance Sets
    text = gsub(text, "#pvpra1#", ATLASLOOT_PVP_RARE_A_DRUID);
    text = gsub(text, "#pvpra2#", ATLASLOOT_PVP_RARE_A_HUNTER);
    text = gsub(text, "#pvpra3#", ATLASLOOT_PVP_RARE_A_MAGE);
    text = gsub(text, "#pvpra4#", ATLASLOOT_PVP_RARE_A_PALADIN);
    text = gsub(text, "#pvpra5#", ATLASLOOT_PVP_RARE_A_PRIEST);
    text = gsub(text, "#pvpra6#", ATLASLOOT_PVP_RARE_A_ROGUE);
    text = gsub(text, "#pvpra7#", ATLASLOOT_PVP_RARE_A_WARLOCK);
    text = gsub(text, "#pvpra8#", ATLASLOOT_PVP_RARE_A_WARRIOR);
    
    --Misc PvP Set Text
    text = gsub(text, "#pvps1#", ATLASLOOT_PVP_EPIC_SET);
    text = gsub(text, "#pvps2#", ATLASLOOT_PVP_RARE_SET);
    
    --Text colouring
    text = gsub(text, "=q0=", "|cff9d9d9d");
    text = gsub(text, "=q1=", "|cffFFFFFF");
    text = gsub(text, "=q2=", "|cff1eff00");
    text = gsub(text, "=q3=", "|cff0070dd");
    text = gsub(text, "=q4=", "|cffa335ee");
    text = gsub(text, "=q5=", "|cffFF8000");
    text = gsub(text, "=q6=", "|cffFF0000");
    text = gsub(text, "=ds=", "|cffFFd200");
    return text;
end
