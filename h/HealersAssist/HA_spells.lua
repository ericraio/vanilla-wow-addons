--[[
  Healers Assist by Kiki of European Cho'gall (Alliance)
    Spells Constantes
]]

--[[
 Cast ratio :
  Instant : 0.429
  1.5s : 0.429
  2.0s : 0.571
  2.5s : 0.714
  3.0s : 0.857
  >= 3.5s : 1.0
  
   ActualBenefit = AdvertisedBenefit * (CastingTime / 3.5) (CastingTime above 3.5 is ignored for this equation)

 Level ratio :
  1 : 0.288
  2 : 0.3
  4 : 0.40
  6 : 0.475
  8 : 0.55
  10 : 0.625
  12 : 0.70
  14 : 0.775
  16 : 0.845
  18 : 0.925
  >= 20 : 1.0
  
   EffectiveBonus = (1-((20-LevelLearnt)*0.0375))*AdvertisedBonus
]]

--[[
  ************* TALENTS *************
]]
-- Druid
HA_TALENT_GIF_OF_NATURE = 1;
HA_TALENT_IMPROVED_REJUVINATION = 2;
-- Priest
HA_TALENT_SPIRITUAL_HEALING = 11;
HA_TALENT_IMPROVED_RENEW = 12;
HA_TALENT_SPIRITUAL_GUIDANCE = 13;
-- Shaman
HA_TALENT_PURIFICATION = 21;
-- Paladin
HA_TALENT_HEALING_LIGHT = 31;

--[[ -- Old code (if talent bonus are applied one after another, and not all at once)
HA_Talents = {
-- Druid
  [HA_TALENT_GIF_OF_NATURE] = { rankratio = {[0]=1.00; [1]=1.02; [2]=1.04; [3]=1.06; [4]=1.08; [5]=1.10}; texture="Interface\\Icons\\Spell_Nature_ProtectionformNature" };
  [HA_TALENT_IMPROVED_REJUVINATION] = { rankratio = {[0]=1.00; [1]=1.05; [2]=1.10; [3]=1.15}; texture="Interface\\Icons\\Spell_Nature_Rejuvenation" };
-- Priest
  [HA_TALENT_SPIRITUAL_HEALING] = { rankratio = {[0]=1.00; [1]=1.02; [2]=1.04; [3]=1.06; [4]=1.08; [5]=1.10}; texture="Interface\\Icons\\Spell_Nature_MoonGlow" };
  [HA_TALENT_IMPROVED_RENEW] = { rankratio = {[0]=1.00; [1]=1.05; [2]=1.10; [3]=1.15}; texture="Interface\\Icons\\Spell_Holy_Renew" };
  [HA_TALENT_SPIRITUAL_GUIDANCE] = { spiritratio = {[0]=0.00; [1]=0.05; [2]=0.10; [3]=0.15; [4]=0.20; [5]=0.25}; texture="Interface\\Icons\\Spell_Holy_SpiritualGuidence" };
-- Shaman
  [HA_TALENT_PURIFICATION] = { rankratio = {[0]=1.00; [1]=1.02; [2]=1.04; [3]=1.06; [4]=1.08; [5]=1.10}; texture="Interface\\Icons\\Spell_Frost_WizardMark" };
-- Paladin
  [HA_TALENT_HEALING_LIGHT] = { rankratio = {[0]=1.00; [1]=1.04; [2]=1.08; [3]=1.12}; texture="Interface\\Icons\\Spell_Holy_HolyBolt" };
};
]]
HA_Talents = {
-- Druid
  [HA_TALENT_GIF_OF_NATURE] = { rankratio = {[0]=0; [1]=0.02; [2]=0.04; [3]=0.06; [4]=0.08; [5]=0.10}; texture="Interface\\Icons\\Spell_Nature_ProtectionformNature" };
  [HA_TALENT_IMPROVED_REJUVINATION] = { rankratio = {[0]=0.00; [1]=0.05; [2]=0.10; [3]=0.15}; texture="Interface\\Icons\\Spell_Nature_Rejuvenation" };
-- Priest
  [HA_TALENT_SPIRITUAL_HEALING] = { rankratio = {[0]=0.00; [1]=0.02; [2]=0.04; [3]=0.06; [4]=0.08; [5]=0.10}; texture="Interface\\Icons\\Spell_Nature_MoonGlow" };
  [HA_TALENT_IMPROVED_RENEW] = { rankratio = {[0]=0.00; [1]=0.05; [2]=0.10; [3]=0.15}; texture="Interface\\Icons\\Spell_Holy_Renew" };
  [HA_TALENT_SPIRITUAL_GUIDANCE] = { spiritratio = {[0]=0.00; [1]=0.05; [2]=0.10; [3]=0.15; [4]=0.20; [5]=0.25}; texture="Interface\\Icons\\Spell_Holy_SpiritualGuidence" };
-- Shaman
  [HA_TALENT_PURIFICATION] = { rankratio = {[0]=0.00; [1]=0.02; [2]=0.04; [3]=0.06; [4]=0.08; [5]=0.10}; texture="Interface\\Icons\\Spell_Frost_WizardMark" };
-- Paladin
  [HA_TALENT_HEALING_LIGHT] = { rankratio = {[0]=0.00; [1]=0.04; [2]=0.08; [3]=0.12}; texture="Interface\\Icons\\Spell_Holy_HolyBolt" };
};

--[[
  ************* SPELL FAILURE *************
]]

HA_SPELL_FAILED_YOU_ARE_DEAD = 1;
HA_SPELL_FAILED_INTERRUPTED = 2;
HA_SPELL_FAILED_OUT_OF_SIGHT = 3;
HA_SPELL_FAILED_INTERRUPTED2 = 4;
HA_SPELL_FAILED_TARGET_IMMUNE = 5;
HA_SPELL_FAILED_OUT_OF_RANGE = 6;
HA_SPELL_FAILED_TARGET_DIED = 7;
HA_SPELL_FAILED_TARGET_HOSTILE = 8;


--[[
  ************* SPELLS *************
]]

-- Druid
HA_SPELL_FIRST_DRUID = 1;
  -- Casted
HA_SPELL_HEALING_TOUCH = 1;
HA_SPELL_REGROWTH = 2;
  -- Instant
HA_SPELL_REJUVENATION = 6;
HA_SPELL_REGROWTH_HOT = 7;
HA_SPELL_SWIFTMEND = 8;
  -- Group
  -- Channel
HA_SPELL_TRANQUILITY = 11;
  -- Other
HA_SPELL_INNERVATE = 16;
HA_SPELL_REBIRTH = 17;
HA_SPELL_REMOVE_CURSE = 18;
HA_SPELL_ABOLISH_POISON = 19;
HA_SPELL_CURE_POISON = 20;

-- Priest
HA_SPELL_FIRST_PRIEST = 31;
  -- Casted
HA_SPELL_LESSER_HEAL = 31;
HA_SPELL_HEAL = 32;
HA_SPELL_FLASH_HEAL = 33;
HA_SPELL_GREATER_HEAL = 34;
  -- Instant
HA_SPELL_RENEW = 36;
HA_SPELL_CURE_DISEASE = 37;
HA_SPELL_ABOLISH_DISEASE = 38;
HA_SPELL_DISPEL_MAGIC = 39;
  -- Group
HA_SPELL_PRAYER_OF_HEALING = 41;
  -- Channel
  -- Other
HA_SPELL_RESURRECTION = 46;
HA_SPELL_PWS = 47;
HA_SPELL_LIGHTWELL = 48;
HA_SPELL_HOLY_NOVA = 49;
HA_SPELL_POWER_INFUSION = 50;

-- Shaman
HA_SPELL_FIRST_SHAMAN = 51;
  -- Casted
HA_SPELL_HEALING_WAVE = 51;
HA_SPELL_LESSER_HEALING_WAVE = 52;
  -- Instant
HA_SPELL_PURGE = 55;
  -- Group
HA_SPELL_CHAIN_HEAL = 56;
  -- Channel
  -- Other
HA_SPELL_REINCARNATION = 61;
HA_SPELL_ANCESTRAL_SPIRIT = 62;
HA_SPELL_MANA_TIDE = 63;

-- Paladin
HA_SPELL_FIRST_PALADIN = 71;
  -- Casted
HA_SPELL_HOLY_LIGHT = 71;
HA_SPELL_FLASH_OF_LIGHT = 72;
  -- Instant
HA_SPELL_HOLY_SHOCK = 76;
  -- Group
  -- Channel
  -- Other
HA_SPELL_DIVINE_INTERVENTION = 81;
HA_SPELL_DIVINE_SHIELD = 82;
HA_SPELL_REDEMPTION = 83;
HA_SPELL_PURIFY = 84;
HA_SPELL_CLEANSE = 85;
HA_SPELL_LAY_ON_HANDS = 86;
HA_SPELL_BLESSING_OF_PROTECTION = 87;

HA_Cooldown = {
  [HA_SPELL_INNERVATE] = { texture="Interface\\Icons\\Spell_Nature_Lightning"; flash_r=1.0; flash_g=0.2; flash_b=0.2; can_request=true },
  [HA_SPELL_REBIRTH] = { texture="Interface\\Icons\\Spell_Nature_Reincarnation"; flash_r=1.0; flash_g=0.2; flash_b=0.2; can_request=true },
  [HA_SPELL_DIVINE_INTERVENTION] = { texture="Interface\\Icons\\Spell_Nature_TimeStop"; flash_r=1.0; flash_g=0.2; flash_b=0.2; can_request=true, longrange=true },
  [HA_SPELL_BLESSING_OF_PROTECTION] = { texture="Interface\\Icons\\Spell_Holy_SealOfProtection"; flash_r=1.0; flash_g=0.2; flash_b=0.2; can_request=true },
  [HA_SPELL_LIGHTWELL] = { texture="Interface\\Icons\\Spell_Holy_SummonLightwell"; flash_r=1.0; flash_g=0.2; flash_b=0.2; can_request=true; norange=true },
  [HA_SPELL_REINCARNATION] = { texture="Interface\\Icons\\Spell_Nature_Reincarnation"; flash_r=1.0; flash_g=0.2; flash_b=0.2 },
  [HA_SPELL_MANA_TIDE] = { texture="Interface\\Icons\\Spell_Frost_SummonWaterElemental"; flash_r=1.0; flash_g=0.2; flash_b=0.2; can_request=true; norange=true },
  [HA_SPELL_POWER_INFUSION] = { texture="Interface\\Icons\\Spell_Holy_PowerInfusion"; flash_r=1.0; flash_g=0.2; flash_b=0.2; can_request=true },
};

HA_SpellOvertime = {
-- Druid
  [HA_SPELL_REJUVENATION] = { texture="Interface\\Icons\\Spell_Nature_Rejuvenation"; duration=12 },
  [HA_SPELL_REGROWTH_HOT] = { texture="Interface\\Icons\\Spell_Nature_ResistNature"; duration=21},
  [HA_SPELL_ABOLISH_POISON] = {texture="Interface\\Icons\\Spell_Nature_NullifyPoison_02"; duration=8},
  [HA_SPELL_INNERVATE] = {texture="Interface\\Icons\\Spell_Nature_Lightning"; duration=20},
-- Priest
  [HA_SPELL_RENEW] = {texture="Interface\\Icons\\Spell_Holy_Renew"; duration=15},
  [HA_SPELL_POWER_INFUSION] = {texture="Interface\\Icons\\Spell_Holy_PowerInfusion"; duration=15},
  [HA_SPELL_ABOLISH_DISEASE] = {texture="Interface\\Icons\\Spell_Nature_NullifyDisease"; duration=20},
-- Paladin
  [HA_SPELL_DIVINE_INTERVENTION] = {texture="Interface\\Icons\\Spell_Nature_TimeStop"; duration=180},
};

HA_SpellRanks = {
-- Druid
  -- Casted
  [HA_SPELL_HEALING_TOUCH] = {
    [1] = { base=47, castratio=0.429, levelratio=0.288 },
    [2] = { base=106, castratio=0.571, levelratio=0.55 },
    [3] = { base=228, castratio=0.714, levelratio=0.775 },
    [4] = { base=417, castratio=0.857, levelratio=1.0 },
    [5] = { base=650, castratio=1.0, levelratio=1.0 },
    [6] = { base=838, castratio=1.0, levelratio=1.0 },
    [7] = { base=1050, castratio=1.0, levelratio=1.0 },
    [8] = { base=1339, castratio=1.0, levelratio=1.0 },
    [9] = { base=1685, castratio=1.0, levelratio=1.0 },
    [10] = { base=2086, castratio=1.0, levelratio=1.0 },
    [11] = { base=2472, castratio=1.0, levelratio=1.0 },
  },
  [HA_SPELL_REGROWTH] = { -- Only 50% of the bonus because one spell, 2 effects
    [1] = { base=100, castratio=0.571*0.50, levelratio=0.70 },
    [2] = { base=188, castratio=0.571*0.50, levelratio=0.925 },
    [3] = { base=272, castratio=0.571*0.50, levelratio=1.0 },
    [4] = { base=357, castratio=0.571*0.50, levelratio=1.0 },
    [5] = { base=451, castratio=0.571*0.50, levelratio=1.0 },
    [6] = { base=566, castratio=0.571*0.50, levelratio=1.0 },
    [7] = { base=711, castratio=0.571*0.50, levelratio=1.0 },
    [8] = { base=887, castratio=0.571*0.50, levelratio=1.0 },
    [9] = { base=1061, castratio=0.571*0.50, levelratio=1.0 },
  },
  -- Instant
  [HA_SPELL_REJUVENATION] = { -- WHY only 80% of the bonus ??
    [1] = { base=32, castratio=1.0*0.80, levelratio=0.40 },
    [2] = { base=56, castratio=1.0*0.80, levelratio=0.625 },
    [3] = { base=116, castratio=1.0*0.80, levelratio=0.845 },
    [4] = { base=180, castratio=1.0*0.80, levelratio=1.0 },
    [5] = { base=244, castratio=1.0*0.80, levelratio=1.0 },
    [6] = { base=304, castratio=1.0*0.80, levelratio=1.0 },
    [7] = { base=388, castratio=1.0*0.80, levelratio=1.0 },
    [8] = { base=488, castratio=1.0*0.80, levelratio=1.0 },
    [9] = { base=608, castratio=1.0*0.80, levelratio=1.0 },
    [10] = { base=756, castratio=1.0*0.80, levelratio=1.0 },
    [11] = { base=888, castratio=1.0*0.80, levelratio=1.0 },
  },
  [HA_SPELL_REGROWTH_HOT] = { -- Only 50% of the bonus because one spell, 2 effects
    [1] = { base=98, castratio=1.0*0.50, levelratio=0.70 },
    [2] = { base=175, castratio=1.0*0.50, levelratio=0.925 },
    [3] = { base=259, castratio=1.0*0.50, levelratio=1.0 },
    [4] = { base=343, castratio=1.0*0.50, levelratio=1.0 },
    [5] = { base=427, castratio=1.0*0.50, levelratio=1.0 },
    [6] = { base=546, castratio=1.0*0.50, levelratio=1.0 },
    [7] = { base=686, castratio=1.0*0.50, levelratio=1.0 },
    [8] = { base=861, castratio=1.0*0.50, levelratio=1.0 },
    [9] = { base=1064, castratio=1.0*0.50, levelratio=1.0 },
  },
  -- Group
  -- Channel
  [HA_SPELL_TRANQUILITY] = {
    [1] = { base=470, castratio=0.33, levelratio=1.0 },
    [2] = { base=690, castratio=0.33, levelratio=1.0 },
    [3] = { base=1025, castratio=0.33, levelratio=1.0 },
    [4] = { base=1470, castratio=0.33, levelratio=1.0 },
  },

-- Priest
  -- Casted
  [HA_SPELL_LESSER_HEAL] = {
    [1] = { base=52, castratio=0.429, levelratio=0.288 },
    [2] = { base=83, castratio=0.571, levelratio=0.40 },
    [3] = { base=154, castratio=0.714, levelratio=0.625 },
  },
  [HA_SPELL_HEAL] = {
    [1] = { base=330, castratio=0.857, levelratio=1.0 },
    [2] = { base=476, castratio=0.857, levelratio=1.0 },
    [3] = { base=624, castratio=0.857, levelratio=1.0 },
    [4] = { base=780, castratio=0.857, levelratio=1.0 },
  },
  [HA_SPELL_FLASH_HEAL] = {
    [1] = { base=224, castratio=0.429, levelratio=1.0 },
    [2] = { base=297, castratio=0.429, levelratio=1.0 },
    [3] = { base=372, castratio=0.429, levelratio=1.0 },
    [4] = { base=453, castratio=0.429, levelratio=1.0 },
    [5] = { base=583, castratio=0.429, levelratio=1.0 },
    [6] = { base=722, castratio=0.429, levelratio=1.0 },
    [7] = { base=901, castratio=0.429, levelratio=1.0 },
  },
  [HA_SPELL_GREATER_HEAL] = {
    [1] = { base=981, castratio=0.857, levelratio=1.0 },
    [2] = { base=1248, castratio=0.857, levelratio=1.0 },
    [3] = { base=1556, castratio=0.857, levelratio=1.0 },
    [4] = { base=1917, castratio=0.857, levelratio=1.0 },
    [5] = { base=2080, castratio=0.857, levelratio=1.0 },
  },
  -- Instant
  [HA_SPELL_RENEW] = {
    [1] = { base=45, castratio=1.0, levelratio=0.55 },
    [2] = { base=100, castratio=1.0, levelratio=0.775 },
    [3] = { base=175, castratio=1.0, levelratio=1.0 },
    [4] = { base=245, castratio=1.0, levelratio=1.0 },
    [5] = { base=315, castratio=1.0, levelratio=1.0 },
    [6] = { base=400, castratio=1.0, levelratio=1.0 },
    [7] = { base=510, castratio=1.0, levelratio=1.0 },
    [8] = { base=650, castratio=1.0, levelratio=1.0 },
    [9] = { base=810, castratio=1.0, levelratio=1.0 },
    [10] = { base=970, castratio=1.0, levelratio=1.0 },
  },
  -- Group
  [HA_SPELL_PRAYER_OF_HEALING] = {
    [1] = { base=322, castratio=0.33, levelratio=1.0 },
    [2] = { base=472, castratio=0.33, levelratio=1.0 },
    [3] = { base=694, castratio=0.33, levelratio=1.0 },
    [4] = { base=965, castratio=0.33, levelratio=1.0 },
    [5] = { base=1070, castratio=0.33, levelratio=1.0 },
  },
  -- Channel

-- Shaman
  -- Casted
  [HA_SPELL_HEALING_WAVE] = {
    [1] = { base=41, castratio=0.429, levelratio=0.288 },
    [2] = { base=76, castratio=0.571, levelratio=0.475 },
    [3] = { base=149, castratio=0.714, levelratio=0.70 },
    [4] = { base=303, castratio=0.857, levelratio=0.925 },
    [5] = { base=421, castratio=0.857, levelratio=1.0 },
    [6] = { base=595, castratio=0.857, levelratio=1.0 },
    [7] = { base=816, castratio=0.857, levelratio=1.0 },
    [8] = { base=1092, castratio=0.857, levelratio=1.0 }, -- To update
    [9] = { base=1464, castratio=0.857, levelratio=1.0 }, -- To update
    [10] = { base=1735, castratio=0.857, levelratio=1.0 },
  },
  [HA_SPELL_LESSER_HEALING_WAVE] = {
    [1] = { base=182, castratio=0.429, levelratio=1.0 },
    [2] = { base=274, castratio=0.429, levelratio=1.0 },
    [3] = { base=371, castratio=0.429, levelratio=1.0 },
    [4] = { base=489, castratio=0.429, levelratio=1.0 },
    [5] = { base=668, castratio=0.429, levelratio=1.0 }, -- To update
    [6] = { base=880, castratio=0.429, levelratio=1.0 }, -- To update
  },
  -- Instant
  -- Group
  [HA_SPELL_CHAIN_HEAL] = {
    [1] = { base=356, castratio=0.714, levelratio=1.0 },
    [2] = { base=435, castratio=0.714, levelratio=1.0 }, -- To update
    [3] = { base=590, castratio=0.714, levelratio=1.0 }, -- To update
  },
  -- Channel

-- Paladin
  -- Casted
  [HA_SPELL_HOLY_LIGHT] = {
    [1] = { base=46, castratio=0.714, levelratio=0.288 },
    [2] = { base=88, castratio=0.714, levelratio=0.475 },
    [3] = { base=181, castratio=0.714, levelratio=0.775 },
    [4] = { base=345, castratio=0.714, levelratio=1.0 },
    [5] = { base=537, castratio=0.714, levelratio=1.0 },
    [6] = { base=758, castratio=0.714, levelratio=1.0 },
    [7] = { base=1022, castratio=0.714, levelratio=1.0 },
    [8] = { base=1343, castratio=0.714, levelratio=1.0 },
    [9] = { base=1680, castratio=0.714, levelratio=1.0 },
  },
  [HA_SPELL_FLASH_OF_LIGHT] = {
    [1] = { base=72, castratio=0.429, levelratio=1.0 },
    [2] = { base=109, castratio=0.429, levelratio=1.0 },
    [3] = { base=162, castratio=0.429, levelratio=1.0 },
    [4] = { base=218, castratio=0.429, levelratio=1.0 },
    [5] = { base=294, castratio=0.429, levelratio=1.0 },
    [6] = { base=368, castratio=0.429, levelratio=1.0 },
  },
  -- Instant
  [HA_SPELL_HOLY_SHOCK] = {
    [1] = { base=212, castratio=0.429, levelratio=1.0 },
    [1] = { base=290, castratio=0.429, levelratio=1.0 },
    [1] = { base=380, castratio=0.429, levelratio=1.0 },
  },
  -- Group
  -- Channel

};

HA_SpellTalents = {
-- Druid
  [HA_SPELL_HEALING_TOUCH] = { ratios={HA_TALENT_GIF_OF_NATURE} };
  [HA_SPELL_REGROWTH] = { ratios={HA_TALENT_GIF_OF_NATURE} };
  [HA_SPELL_REJUVENATION] = { ratios={HA_TALENT_GIF_OF_NATURE,HA_TALENT_IMPROVED_REJUVINATION} };
  [HA_SPELL_REGROWTH_HOT] = { ratios={HA_TALENT_GIF_OF_NATURE} };
  [HA_SPELL_TRANQUILITY] = { ratios={HA_TALENT_GIF_OF_NATURE} };
-- Priest
  [HA_SPELL_LESSER_HEAL] = { ratios={HA_TALENT_SPIRITUAL_HEALING,HA_TALENT_SPIRITUAL_GUIDANCE} };
  [HA_SPELL_HEAL] = { ratios={HA_TALENT_SPIRITUAL_HEALING,HA_TALENT_SPIRITUAL_GUIDANCE} };
  [HA_SPELL_FLASH_HEAL] = { ratios={HA_TALENT_SPIRITUAL_HEALING,HA_TALENT_SPIRITUAL_GUIDANCE} };
  [HA_SPELL_GREATER_HEAL] = { ratios={HA_TALENT_SPIRITUAL_HEALING,HA_TALENT_SPIRITUAL_GUIDANCE} };
  [HA_SPELL_RENEW] = { ratios={HA_TALENT_SPIRITUAL_HEALING,HA_TALENT_IMPROVED_RENEW,HA_TALENT_SPIRITUAL_GUIDANCE} };
  [HA_SPELL_PRAYER_OF_HEALING] = { ratios={HA_TALENT_SPIRITUAL_HEALING,HA_TALENT_SPIRITUAL_GUIDANCE} };
  [HA_SPELL_HOLY_NOVA] = { ratios={HA_TALENT_SPIRITUAL_HEALING,HA_TALENT_SPIRITUAL_GUIDANCE} };
-- Shaman
  [HA_SPELL_HEALING_WAVE] = { ratios={HA_TALENT_PURIFICATION} };
  [HA_SPELL_LESSER_HEALING_WAVE] = { ratios={HA_TALENT_PURIFICATION} };
  [HA_SPELL_CHAIN_HEAL] = { ratios={HA_TALENT_PURIFICATION} };
-- Paladin
  [HA_SPELL_HOLY_LIGHT] = { ratios={HA_TALENT_HEALING_LIGHT}; blessing=400};
  [HA_SPELL_FLASH_OF_LIGHT] = { ratios={HA_TALENT_HEALING_LIGHT}; blessing=115 };

};

HA_FailReasons = {
  [HA_SPELL_FAILED_YOU_ARE_DEAD] = SPELL_FAILED_CASTER_DEAD;
  [HA_SPELL_FAILED_INTERRUPTED] = SPELL_FAILED_INTERRUPTED_COMBAT;
  [HA_SPELL_FAILED_OUT_OF_SIGHT] = SPELL_FAILED_LINE_OF_SIGHT;
  [HA_SPELL_FAILED_INTERRUPTED2] = SPELL_FAILED_INTERRUPTED;
  [HA_SPELL_FAILED_TARGET_IMMUNE] = SPELL_FAILED_IMMUNE;
  [HA_SPELL_FAILED_OUT_OF_RANGE] = SPELL_FAILED_OUT_OF_RANGE;
  [HA_SPELL_FAILED_TARGET_DIED] = SPELL_FAILED_TARGETS_DEAD;
  [HA_SPELL_FAILED_TARGET_HOSTILE] = SPELL_FAILED_TARGET_ENEMY;
};

-- Spell Functions 

HA_ISpells = {};
HA_ISpellInfos = {};

function HA_BuildLocalNames()
  for name,tab in HA_Spells
  do
    HA_ISpells[tab.iname] = name;
    HA_ISpellInfos[tab.iname] = tab;
  end
  for name,tab in HA_InstantSpells
  do
    HA_ISpells[tab.iname] = name;
    HA_ISpellInfos[tab.iname] = tab;
  end
  for name,tab in HA_PassiveSpells
  do
    HA_ISpells[tab.iname] = name;
    HA_ISpellInfos[tab.iname] = tab;
  end

  HA_INNERVATE = HA_GetLocalName(HA_SPELL_INNERVATE);
  HA_REBIRTH = HA_GetLocalName(HA_SPELL_REBIRTH);
  HA_DIVINE_INTERVENTION = HA_GetLocalName(HA_SPELL_DIVINE_INTERVENTION);
  HA_BLESSING_OF_PROTECTION = HA_GetLocalName(HA_SPELL_BLESSING_OF_PROTECTION);
  HA_REINCARNATION = HA_GetLocalName(HA_SPELL_REINCARNATION);
  HA_LIGHTWELL = HA_GetLocalName(HA_SPELL_LIGHTWELL);
  HA_MANA_TIDE = HA_GetLocalName(HA_SPELL_MANA_TIDE);
  HA_POWER_INFUSION = HA_GetLocalName(HA_SPELL_POWER_INFUSION);
end

function HA_GetLocalName(ISpell)
  return HA_ISpells[ISpell];
end

function HA_GetLocalInfos(ISpell)
  return HA_ISpellInfos[ISpell];
end

function HA_GetLocalReason(IReason)
  return HA_FailReasons[IReason];
end

function HA_IsSpellClass(ISpell, Class)
  if(ISpell < HA_SPELL_FIRST_PRIEST)
  then
    return Class == "DRUID";
  elseif(ISpell < HA_SPELL_FIRST_SHAMAN)
  then
    return Class == "PRIEST";
  elseif(ISpell < HA_SPELL_FIRST_PALADIN)
  then
    return Class == "SHAMAN";
  else
    return Class == "PALADIN";
  end
  return false;
end

function HA_GetSpellClass(ISpell)
  if(ISpell == nil) then return ""; end
  if(ISpell < HA_SPELL_FIRST_PRIEST)
  then
    return "DRUID";
  elseif(ISpell < HA_SPELL_FIRST_SHAMAN)
  then
    return "PRIEST";
  elseif(ISpell < HA_SPELL_FIRST_PALADIN)
  then
    return "SHAMAN";
  else
    return "PALADIN";
  end
  return "";
end

function HA_GetSpellCode(SpellName)
  if(HA_Spells[SpellName])
  then
    return HA_Spells[SpellName].iname;
  elseif(HA_InstantSpells[SpellName])
  then
    return HA_InstantSpells[SpellName].iname;
  end
  return nil;
end
