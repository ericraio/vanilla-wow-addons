function ReagentData_LoadBlacksmithing()
ReagentData['crafted']['blacksmithing'] = {
    ['Copper Bracers'] = {
        skill = 1,
        description = '(Mail Wrist) AC: 35, MinLvl: 2',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['copper']] = 10,
            [ReagentData['stone']['rough']] = 3,
        }
    },
    ['Copper Chain Pants'] = {
        skill = 1,
        description = '(Mail Legs) AC: 83, MinLvl: 4',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['copper']] = 4,
        }
    },
    ['Rough Copper Vest'] = {
        skill = 1,
        description = '(Mail Chest) AC: 81, MinLvl: 2',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['copper']] = 4,
        }
    },
    ['Rough Sharpening Stone'] = {
        skill = 1,
        description = 'Use: Increase sharp weapon damage by 2 for 30 minutes.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['rough']] = 1,
        }
    },
    ['Rough Weightstone'] = {
        skill = 25,
        description = 'Use: Increase the damage of a blunt weapon by 2 for 30 minutes.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['rough']] = 1,
            [ReagentData['cloth']['linen']] = 1,
        }
    },
    ['Copper Mace'] = {
        skill = 15,
        description = '(MH Mace) Dmg: 6-11, Spd: 2.20, DPS: 3.9, MinLvl: 4',
        type = 'Mace',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['flux']['weak']] = 1,
            [ReagentData['cloth']['linen']] = 2,
            [ReagentData['bar']['copper']] = 6,
        }
    },
    ['Copper Axe'] = {
        skill = 20,
        description = '(MH Axe) Dmg: 5-10, Spd: 1.90, DPS: 3.9, MinLvl: 4',
        type = 'Axe',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['flux']['weak']] = 1,
            [ReagentData['cloth']['linen']] = 2,
            [ReagentData['bar']['copper']] = 6,
        }
    },
    ['Copper Chain Boots'] = {
        skill = 20,
        description = '(Mail Feet) AC: 65, MinLvl: 4',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['copper']] = 8,
        }
    },
    ['Copper Shortsword'] = {
        skill = 25,
        description = '(MH Sword) Dmg: 5-11, Spd: 2.10, DPS: 3.8, MinLvl: 4',
        type = 'Sword',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['flux']['weak']] = 1,
            [ReagentData['cloth']['linen']] = 2,
            [ReagentData['bar']['copper']] = 6,
        }
    },
    ['Rough Grinding Stone'] = {
        skill = 25,
        description = 'Rough Grinding Stone',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['rough']] = 2,
        }
    },
    ['Copper Claymore'] = {
        skill = 30,
        description = '(2H Sword) Dmg: 15-23, Spd: 3.00, DPS: 6.3, MinLvl: 6',
        type = 'Two-Hand Sword',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['flux']['weak']] = 2,
            [ReagentData['grinding']['rough']] = 1,
            [ReagentData['leather']['light']] = 1,
            [ReagentData['bar']['copper']] = 10,
        }
    },
    ['Copper Dagger'] = {
        skill = 30,
        description = '(1H Dagger) Dmg: 5-10, Spd: 1.50, DPS: 5.0, MinLvl: 6',
        type = 'Dagger',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['flux']['weak']] = 1,
            [ReagentData['grinding']['rough']] = 1,
            [ReagentData['leather']['light']] = 1,
            [ReagentData['bar']['copper']] = 6,
        }
    },
    ['Copper Battle Axe'] = {
        skill = 35,
        description = '[BoE] (2H Axe) Dmg: 23-35, Spd: 3.20, DPS: 9.1, Sta: 3, MinLvl: 8',
        type = 'Two-Hand Axe',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['malachite']] = 2,
            [ReagentData['flux']['weak']] = 2,
            [ReagentData['grinding']['rough']] = 2,
            [ReagentData['leather']['light']] = 2,
            [ReagentData['bar']['copper']] = 12,
        }
    },
    ['Copper Chain Belt'] = {
        skill = 35,
        description = '(Mail Waist) AC: 61, MinLvl: 6',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['copper']] = 6,
        }
    },
    ['Copper Chain Vest'] = {
        skill = 35,
        description = '[BoE] (Mail Chest) AC: 108, Str: 1, MinLvl: 5',
        type = 'Mail',
        source = 'Drop, Quest:Plans: Copper Chain Vest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['malachite']] = 1,
            [ReagentData['grinding']['rough']] = 2,
            [ReagentData['bar']['copper']] = 8,
        }
    },
    ['Runed Copper Gauntlets'] = {
        skill = 40,
        description = '(Mail Hands) AC: 73, MinLvl: 7',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['grinding']['rough']] = 2,
            [ReagentData['bar']['copper']] = 8,
        }
    },
    ['Runed Copper Pants'] = {
        skill = 45,
        description = '[BoE] (Mail Legs) AC: 113, Str: 2, Sta: 2, MinLvl: 8',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['grinding']['rough']] = 2,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['bar']['copper']] = 8,
        }
    },
    ['Gemmed Copper Gauntlets'] = {
        skill = 60,
        description = '[BoE] (Mail Hands) AC: 90, MinLvl: 10',
        type = 'Mail',
        source = 'Drop:Plans: Gemmed Copper Gauntlets',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['malachite']] = 1,
            [ReagentData['gem']['tigerseye']] = 1,
            [ReagentData['bar']['copper']] = 8,
        }
    },
    ['Coarse Sharpening Stone'] = {
        skill = 65,
        description = 'MinLvl: 5, Use: Increase sharp weapon damage by 3 for 30 minutes.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['coarse']] = 1,
        }
    },
    ['Coarse Weightstone'] = {
        skill = 65,
        description = 'MinLvl: 5, Use: Increase the damage of a blunt weapon by 3 for 30 minutes.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['wool']] = 1,
            [ReagentData['stone']['coarse']] = 1,
        }
    },
    ['Heavy Copper Maul'] = {
        skill = 65,
        description = '(2H Mace) Dmg: 21-32, Spd: 2.80, DPS: 9.5, MinLvl: 11',
        type = 'Two-Hand Mace',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['flux']['weak']] = 2,
            [ReagentData['leather']['light']] = 2,
            [ReagentData['bar']['copper']] = 12,
        }
    },
    ['Coarse Grinding Stone'] = {
        skill = 75,
        description = 'Coarse Grinding Stone',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['coarse']] = 2,
        }
    },
    ['Runed Copper Breastplate'] = {
        skill = 80,
        description = '[BoE] (Mail Chest) AC: 162, Str: 4, Sta: 3, MinLvl: 13',
        type = 'Mail',
        source = 'Drop:Plans: Runed Copper Breastplate',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['shadow']] = 1,
            [ReagentData['grinding']['rough']] = 2,
            [ReagentData['bar']['copper']] = 12,
        }
    },
    ['Runed Copper Bracers'] = {
        skill = 90,
        description = '(Mail Wrist) AC: 68, MinLvl: 14',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['grinding']['rough']] = 3,
            [ReagentData['bar']['copper']] = 10,
        }
    },
    ['Runed Copper Belt'] = {
        skill = 90,
        description = '(Mail Waist) AC: 86, MinLvl: 13',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['copper']] = 10,
        }
    },
    ['Thick War Axe'] = {
        skill = 90,
        description = '[BoE] (MH Axe) Dmg: 15-28, Spd: 2.50, DPS: 8.6, Str: 1, Sta: 1, MinLvl: 12',
        type = 'Axe',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['flux']['weak']] = 2,
            [ReagentData['grinding']['rough']] = 2,
            [ReagentData['bar']['silver']] = 2,
            [ReagentData['leather']['light']] = 2,
            [ReagentData['bar']['copper']] = 10,
        }
    },
    ['Heavy Copper Broadsword'] = {
        skill = 95,
        description = '[BoE] (2H Sword) Dmg: 27-41, Spd: 2.70, DPS: 12.6, Sta: 6, MinLvl: 14',
        type = 'Two-Hand Sword',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['flux']['weak']] = 2,
            [ReagentData['gem']['tigerseye']] = 2,
            [ReagentData['leather']['medium']] = 2,
            [ReagentData['bar']['copper']] = 14,
        }
    },
    ['Rough Bronze Boots'] = {
        skill = 95,
        description = '(Mail Feet) AC: 106, MinLvl: 13',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['bronze']] = 6,
            [ReagentData['grinding']['rough']] = 6,
        }
    },
    ['Big Bronze Knife'] = {
        skill = 100,
        description = '[BoE] (1H Dagger) Dmg: 13-25, Spd: 1.90, DPS: 10.0, Sta: 3, MinLvl: 15',
        type = 'Dagger',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 6,
            [ReagentData['flux']['weak']] = 4,
            [ReagentData['grinding']['rough']] = 2,
            [ReagentData['gem']['tigerseye']] = 1,
            [ReagentData['leather']['medium']] = 1,
        }
    },
    ['Ironforge Breastplate'] = {
        skill = 100,
        description = '[BoE] (Mail Chest) AC: 198, Str: 3, Sta: 3, MinLvl: 15',
        type = 'Mail',
        source = 'Quest:Plans: Ironforge Breastplate',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['grinding']['rough']] = 3,
            [ReagentData['gem']['tigerseye']] = 2,
            [ReagentData['bar']['copper']] = 16,
        }
    },
    ['Silver Rod'] = {
        skill = 100,
        description = 'Needed by Enchanters.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['grinding']['rough']] = 2,
            [ReagentData['bar']['silver']] = 1,
        }
    },
    ['Silver Skeleton Key'] = {
        skill = 100,
        description = 'Requires Blacksmithing (100), Use: Allows opening of simple locks. The skeleton key is consumed in the process.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 2,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['grinding']['rough']] = 1,
            [ReagentData['bar']['silver']] = 1,
        }
    },
    ['Rough Bronze Cuirass'] = {
        skill = 105,
        description = '(Mail Chest) AC: 168, MinLvl: 18',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['bronze']] = 7,
        }
    },
    ['Rough Bronze Leggings'] = {
        skill = 105,
        description = '[BoE] (Mail Legs) AC: 149, Sta: 5, Spi: 4, MinLvl: 16',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 6,
        }
    },
    ['Bronze Mace'] = {
        skill = 110,
        description = '(MH Mace) Dmg: 18-34, Spd: 2.60, DPS: 10.0, MinLvl: 17',
        type = 'Mace',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['bronze']] = 6,
            [ReagentData['flux']['weak']] = 4,
            [ReagentData['leather']['medium']] = 1,
        }
    },
    ['Rough Bronze Shoulders'] = {
        skill = 110,
        description = '(Mail Shoulder) AC: 124, MinLvl: 17',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['bronze']] = 5,
            [ReagentData['gem']['shadow']] = 1,
            [ReagentData['grinding']['coarse']] = 1,
        }
    },
    ['Bronze Axe'] = {
        skill = 115,
        description = '(MH Axe) Dmg: 15-29, Spd: 2.10, DPS: 10.5, MinLvl: 18',
        type = 'Axe',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['bronze']] = 7,
            [ReagentData['flux']['weak']] = 4,
            [ReagentData['leather']['medium']] = 1,
        }
    },
    ['Pearl-handled Dagger'] = {
        skill = 115,
        description = '[BoE] (1H Dagger) Dmg: 13-26, Spd: 1.70, DPS: 11.5, Agi: 2, Sta: 2, MinLvl: 18',
        type = 'Dagger',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 6,
            [ReagentData['grinding']['coarse']] = 2,
            [ReagentData['pearl']['smalllustrous']] = 2,
            [ReagentData['flux']['strong']] = 1,
        }
    },
    ['Bronze Shortsword'] = {
        skill = 120,
        description = '(MH Sword) Dmg: 16-31, Spd: 2.10, DPS: 11.2, MinLvl: 19',
        type = 'Sword',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['bronze']] = 5,
            [ReagentData['flux']['weak']] = 4,
            [ReagentData['leather']['medium']] = 2,
        }
    },
    ['Patterned Bronze Bracers'] = {
        skill = 120,
        description = '[BoE] (Mail Wrist) AC: 80, Str: 5, MinLvl: 20',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 5,
            [ReagentData['grinding']['coarse']] = 2,
        }
    },
    ['Bronze Warhammer'] = {
        skill = 125,
        description = '(2H Mace) Dmg: 37-57, Spd: 3.10, DPS: 15.2, MinLvl: 20',
        type = 'Two-Hand Mace',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['bronze']] = 8,
            [ReagentData['leather']['medium']] = 1,
            [ReagentData['flux']['strong']] = 1,
        }
    },
    ['Deadly Bronze Poniard'] = {
        skill = 125,
        description = '[BoE] (1H Dagger) Dmg: 16-30, Spd: 1.80, DPS: 12.8, Agi: 4, MinLvl: 20',
        type = 'Dagger',
        source = 'Drop:Plans: Deadly Bronze Poniard',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 4,
            [ReagentData['potion']['swiftness']] = 1,
            [ReagentData['gem']['shadow']] = 2,
            [ReagentData['grinding']['coarse']] = 2,
            [ReagentData['leather']['medium']] = 2,
            [ReagentData['flux']['strong']] = 1,
        }
    },
    ['Heavy Grinding Stone'] = {
        skill = 125,
        description = 'Heavy Grinding Stone',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['heavy']] = 3,
        }
    },
    ['Heavy Sharpening Stone'] = {
        skill = 125,
        description = 'MinLvl: 15, Use: Increase sharp weapon damage by 4 for 30 minutes.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['heavy']] = 1,
        }
    },
    ['Heavy Weightstone'] = {
        skill = 125,
        description = 'MinLvl: 15, Use: Increase the damage of a blunt weapon by 4 for 30 minutes.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['wool']] = 1,
            [ReagentData['stone']['heavy']] = 1,
        }
    },
    ['Silvered Bronze Shoulders'] = {
        skill = 125,
        description = '[BoE] (Mail Shoulder) AC: 137, Str: 3, Sta: 3, Spi: 3, MinLvl: 20',
        type = 'Mail',
        source = 'Drop:Plans: Silvered Bronze Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 8,
            [ReagentData['bar']['silver']] = 2,
            [ReagentData['grinding']['coarse']] = 2,
        }
    },
    ['Bronze Greatsword'] = {
        skill = 130,
        description = '(2H Sword) Dmg: 38-58, Spd: 3.00, DPS: 16.0, MinLvl: 21',
        type = 'Two-Hand Sword',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['bronze']] = 12,
            [ReagentData['leather']['medium']] = 2,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Heavy Bronze Mace'] = {
        skill = 130,
        description = '[BoE] (MH Mace) Dmg: 25-47, Spd: 2.80, DPS: 12.9, Str: 4, MinLvl: 20',
        type = 'Mace',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['mossagate']] = 1,
            [ReagentData['bar']['bronze']] = 8,
            [ReagentData['gem']['shadow']] = 1,
            [ReagentData['grinding']['coarse']] = 2,
            [ReagentData['leather']['medium']] = 2,
            [ReagentData['flux']['strong']] = 1,
        }
    },
    ['Silvered Bronze Boots'] = {
        skill = 130,
        description = '[BoE] (Mail Feet) AC: 128, Str: 4, Sta: 4, Spi: 3, MinLvl: 21',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 6,
            [ReagentData['bar']['silver']] = 1,
            [ReagentData['grinding']['coarse']] = 2,
        }
    },
    ['Silvered Bronze Breastplate'] = {
        skill = 130,
        description = '[BoE] (Mail Chest) AC: 186, Str: 5, Sta: 5, Spi: 4, MinLvl: 21',
        type = 'Mail',
        source = 'Drop:Plans: Silvered Bronze Breastplate',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 10,
            [ReagentData['bar']['silver']] = 2,
            [ReagentData['grinding']['coarse']] = 2,
            [ReagentData['gem']['lessermoonstone']] = 1,
        }
    },
    ['Bronze Battle Axe'] = {
        skill = 135,
        description = '(2H Axe) Dmg: 39-59, Spd: 2.90, DPS: 16.9, MinLvl: 22',
        type = 'Two-Hand Axe',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['bronze']] = 14,
            [ReagentData['leather']['medium']] = 2,
            [ReagentData['flux']['strong']] = 1,
        }
    },
    ['Silvered Bronze Gauntlets'] = {
        skill = 135,
        description = '[BoE] (Mail Hands) AC: 118, Str: 4, Sta: 4, Spi: 3, MinLvl: 22',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 8,
            [ReagentData['bar']['silver']] = 1,
            [ReagentData['grinding']['coarse']] = 2,
        }
    },
    ['Iridescent Hammer'] = {
        skill = 140,
        description = '[BoE] (1H Mace) Dmg: 18-34, Spd: 1.80, DPS: 14.4, Str: 3, Sta: 3, MinLvl: 23',
        type = 'Mace',
        source = 'Drop:Plans: Iridescent Hammer',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 10,
            [ReagentData['pearl']['iridescent']] = 1,
            [ReagentData['grinding']['coarse']] = 2,
            [ReagentData['leather']['medium']] = 2,
            [ReagentData['flux']['strong']] = 1,
        }
    },
    ['Green Iron Boots'] = {
        skill = 145,
        description = '[BoE] (Mail Feet) AC: 134, Str: 3, Sta: 7, MinLvl: 24',
        type = 'Mail',
        source = 'Drop:Plans: Green Iron Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 4,
            [ReagentData['grinding']['coarse']] = 2,
            [ReagentData['gem']['lessermoonstone']] = 2,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Mighty Iron Hammer'] = {
        skill = 145,
        description = '[BoE] (MH Mace) Dmg: 30-57, Spd: 2.80, DPS: 15.5, Str: 5, MinLvl: 25',
        type = 'Mace',
        source = 'Drop:Plans: Mighty Iron Hammer',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 6,
            [ReagentData['potion']['elixirofogresstrength']] = 1,
            [ReagentData['grinding']['coarse']] = 2,
            [ReagentData['gem']['lessermoonstone']] = 2,
            [ReagentData['leather']['medium']] = 2,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Shining Silver Breastplate'] = {
        skill = 145,
        description = '[BoE] (Mail Chest) AC: 214, Str: 14, Sta: 6, MinLvl: 24',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['mossagate']] = 2,
            [ReagentData['bar']['bronze']] = 20,
            [ReagentData['pearl']['iridescent']] = 2,
            [ReagentData['bar']['silver']] = 4,
            [ReagentData['gem']['lessermoonstone']] = 2,
        }
    },
    ['Golden Rod'] = {
        skill = 150,
        description = 'Needed by Enchanters.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['gold']] = 1,
            [ReagentData['grinding']['coarse']] = 2,
        }
    },
    ['Golden Skeleton Key'] = {
        skill = 150,
        description = 'Requires Blacksmithing (150), Use: Allows opening of standard locks. The skeleton key is consumed in the process.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 2,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['grinding']['heavy']] = 1,
            [ReagentData['bar']['gold']] = 1,
        }
    },
    ['Green Iron Gauntlets'] = {
        skill = 150,
        description = '[BoE] (Mail Hands) AC: 124, Str: 5, Sta: 6, MinLvl: 25',
        type = 'Mail',
        source = 'Drop:Plans: Green Iron Gauntlets',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 4,
            [ReagentData['grinding']['coarse']] = 2,
            [ReagentData['pearl']['smalllustrous']] = 2,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Iron Buckle'] = {
        skill = 150,
        description = 'Iron Buckle',
        type = 'Reagent',
        source = 'Trainer',
        result = 2,
        reagents = {
            [ReagentData['bar']['iron']] = 1,
        }
    },
    ['Iron Shield Spike'] = {
        skill = 150,
        description = 'Requires Blacksmithing (150), Use: Attaches an Iron Spike to your shield that deals damage every time you block with it.',
        type = 'Trade Goods',
        source = 'Drop:Plans: Iron Shield Spike',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['bar']['iron']] = 6,
            [ReagentData['grinding']['coarse']] = 4,
        }
    },
    ['Green Iron Leggings'] = {
        skill = 155,
        description = '[BoE] (Mail Legs) AC: 176, Str: 8, Sta: 8, MinLvl: 26',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 8,
            [ReagentData['grinding']['heavy']] = 1,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Silvered Bronze Leggings'] = {
        skill = 155,
        description = '[BoE] (Mail Legs) AC: 176, Str: 7, Sta: 6, Spi: 6, MinLvl: 26',
        type = 'Mail',
        source = 'Drop:Plans: Silvered Bronze Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['bronze']] = 12,
            [ReagentData['bar']['silver']] = 4,
            [ReagentData['grinding']['coarse']] = 2,
        }
    },
    ['Solid Iron Maul'] = {
        skill = 155,
        description = '[BoE] (2H Mace) Dmg: 59-89, Spd: 3.50, DPS: 21.1, Sta: 12, MinLvl: 26',
        type = 'Two-Hand Mace',
        source = 'Vendor:Plans: Solid Iron Maul',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['bar']['iron']] = 8,
            [ReagentData['grinding']['heavy']] = 1,
            [ReagentData['bar']['silver']] = 4,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Barbaric Iron Breastplate'] = {
        skill = 160,
        description = '(Mail Chest) AC: 204, Str: 12, MinLvl: 27',
        type = 'Mail',
        source = 'Quest:Plans: Barbaric Iron Breastplate',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 20,
            [ReagentData['grinding']['heavy']] = 4,
        }
    },
    ['Barbaric Iron Shoulders'] = {
        skill = 160,
        description = '[BoE] (Mail Shoulder) AC: 153, Str: 6, Agi: 6, MinLvl: 27',
        type = 'Mail',
        source = 'Quest:Plans: Barbaric Iron Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 8,
            [ReagentData['gem']['shadow']] = 2,
            [ReagentData['grinding']['heavy']] = 2,
            [ReagentData['monster']['sharpclaw']] = 4,
        }
    },
    ['Green Iron Shoulders'] = {
        skill = 160,
        description = '[BoE] (Mail Shoulder) AC: 153, Str: 4, Sta: 7, MinLvl: 27',
        type = 'Mail',
        source = 'Drop:Plans: Green Iron Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 7,
            [ReagentData['grinding']['heavy']] = 1,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Hardened Iron Shortsword'] = {
        skill = 160,
        description = '[BoE] (MH Sword) Dmg: 21-39, Spd: 1.80, DPS: 16.7, Sta: 5, MinLvl: 27',
        type = 'Sword',
        source = 'Vendor:Plans: Hardened Iron Shortsword',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 3,
            [ReagentData['bar']['iron']] = 6,
            [ReagentData['grinding']['heavy']] = 1,
            [ReagentData['gem']['lessermoonstone']] = 2,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Green Iron Bracers'] = {
        skill = 165,
        description = '(Mail Wrist) AC: 86, MinLvl: 28',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['iron']] = 6,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Iron Counterweight'] = {
        skill = 165,
        description = 'Requires Blacksmithing (165), Use: Attaches a counterweight to a two-handed sword, mace, axe or polearm making it 3% faster.',
        type = 'Trade Goods',
        source = 'Drop:Plans: Iron Counterweight',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['bar']['iron']] = 4,
            [ReagentData['grinding']['coarse']] = 2,
            [ReagentData['gem']['lessermoonstone']] = 1,
        }
    },
    ['Golden Iron Destroyer'] = {
        skill = 170,
        description = '[BoE] (2H Mace) Dmg: 50-76, Spd: 2.75, DPS: 22.9, Str: 11, Sta: 4, MinLvl: 29',
        type = 'Two-Hand Mace',
        source = 'Drop:Plans: Golden Iron Destroyer',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['bar']['iron']] = 10,
            [ReagentData['grinding']['heavy']] = 2,
            [ReagentData['bar']['gold']] = 4,
            [ReagentData['gem']['lessermoonstone']] = 2,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Golden Scale Leggings'] = {
        skill = 170,
        description = '[BoE] (Mail Legs) AC: 184, Str: 11, Spi: 5, MinLvl: 29',
        type = 'Mail',
        source = 'Drop:Plans: Golden Scale Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 10,
            [ReagentData['grinding']['heavy']] = 1,
            [ReagentData['bar']['gold']] = 2,
        }
    },
    ['Green Iron Helm'] = {
        skill = 170,
        description = '[BoE] (Mail Head) AC: 171, Str: 5, Sta: 11, MinLvl: 29',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 12,
            [ReagentData['gem']['citrine']] = 1,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Barbaric Iron Helm'] = {
        skill = 175,
        description = '[BoE] (Mail Head) AC: 173, Str: 9, Agi: 9, MinLvl: 30',
        type = 'Mail',
        source = 'Quest:Plans: Barbaric Iron Helm',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 10,
            [ReagentData['monster']['largefang']] = 2,
            [ReagentData['monster']['sharpclaw']] = 2,
        }
    },
    ['Golden Scale Shoulders'] = {
        skill = 175,
        description = '[BoE] (Mail Shoulder) AC: 160, Str: 7, Spi: 6, MinLvl: 30',
        type = 'Mail',
        source = 'Drop:Plans: Golden Scale Shoulders',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['steel']] = 6,
            [ReagentData['grinding']['heavy']] = 1,
            [ReagentData['bar']['gold']] = 2,
        }
    },
    ['Jade Serpentblade'] = {
        skill = 175,
        description = '[BoE] (1H Sword) Dmg: 33-62, Spd: 2.60, DPS: 18.3, Str: 4, Agi: 4, MinLvl: 30',
        type = 'Sword',
        source = 'Drop:Plans: Jade Serpentblade',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 3,
            [ReagentData['bar']['iron']] = 8,
            [ReagentData['grinding']['heavy']] = 2,
            [ReagentData['gem']['jade']] = 2,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Barbaric Iron Boots'] = {
        skill = 180,
        description = '[BoE] (Mail Feet) AC: 149, Str: 7, Agi: 7, MinLvl: 31',
        type = 'Mail',
        source = 'Quest:Plans: Barbaric Iron Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 12,
            [ReagentData['grinding']['heavy']] = 2,
            [ReagentData['gem']['tigerseye']] = 4,
            [ReagentData['monster']['largefang']] = 4,
        }
    },
    ['Glinting Steel Dagger'] = {
        skill = 180,
        description = '[BoE] (1H Dagger) Dmg: 19-37, Spd: 1.50, DPS: 18.7, MinLvl: 31, Equip: +12 Attack Power.',
        type = 'Dagger',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['mossagate']] = 1,
            [ReagentData['element']['earth']] = 1,
            [ReagentData['leather']['heavy']] = 1,
            [ReagentData['bar']['steel']] = 10,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Green Iron Hauberk'] = {
        skill = 180,
        description = '[BoE] (Mail Chest) AC: 358, Str: 7, Sta: 11, MinLvl: 31',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['mossagate']] = 2,
            [ReagentData['bar']['iron']] = 20,
            [ReagentData['grinding']['heavy']] = 4,
            [ReagentData['armor']['greenleather']] = 1,
            [ReagentData['gem']['jade']] = 2,
        }
    },
    ['Moonsteel Broadsword'] = {
        skill = 180,
        description = '[BoE] (2H Sword) Dmg: 55-83, Spd: 2.80, DPS: 24.6, Sta: 4, Spi: 12, MinLvl: 31',
        type = 'Two-Hand Sword',
        source = 'Vendor:Plans: Moonsteel Broadsword',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 3,
            [ReagentData['bar']['steel']] = 8,
            [ReagentData['grinding']['heavy']] = 2,
            [ReagentData['gem']['lessermoonstone']] = 3,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Barbaric Iron Gloves'] = {
        skill = 185,
        description = '[BoE] (Mail Hands) AC: 137, Str: 11, MinLvl: 32',
        type = 'Mail',
        source = 'Quest:Plans: Barbaric Iron Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 14,
            [ReagentData['grinding']['heavy']] = 3,
            [ReagentData['monster']['largefang']] = 2,
        }
    },
    ['Golden Scale Bracers'] = {
        skill = 185,
        description = '(Mail Wrist) AC: 91, MinLvl: 32',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['steel']] = 5,
            [ReagentData['grinding']['heavy']] = 2,
        }
    },
    ['Massive Iron Axe'] = {
        skill = 185,
        description = '[BoE] (2H Axe) Dmg: 71-108, Spd: 3.50, DPS: 25.6, Str: 11, Sta: 7, MinLvl: 32',
        type = 'Two-Hand Axe',
        source = 'Vendor:Plans: Massive Iron Axe',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['bar']['iron']] = 14,
            [ReagentData['grinding']['heavy']] = 2,
            [ReagentData['bar']['gold']] = 4,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Polished Steel Boots'] = {
        skill = 185,
        description = '[BoE] (Mail Feet) AC: 151, Sta: 11, MinLvl: 32',
        type = 'Mail',
        source = 'Drop:Plans: Polished Steel Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['steel']] = 8,
            [ReagentData['gem']['citrine']] = 1,
            [ReagentData['grinding']['heavy']] = 2,
            [ReagentData['gem']['lessermoonstone']] = 1,
        }
    },
    ['Edge of Winter'] = {
        skill = 190,
        description = '[BoE] (MH Axe) Dmg: 30-56, Spd: 2.10, DPS: 20.5, Sta: 3, MinLvl: 33, Chance on hit: Blasts a target for 30 Frost damage.',
        type = 'Axe',
        source = 'Drop:Plans: Edge of Winter',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['bar']['steel']] = 10,
            [ReagentData['element']['air']] = 2,
            [ReagentData['element']['water']] = 2,
            [ReagentData['oil']['frost']] = 1,
        }
    },
    ['Golden Scale Coif'] = {
        skill = 190,
        description = '[BoE] (Mail Head) AC: 181, Str: 10, Spi: 10, MinLvl: 33',
        type = 'Mail',
        source = 'Vendor:Plans: Golden Scale Coif',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['steel']] = 8,
            [ReagentData['grinding']['heavy']] = 2,
            [ReagentData['bar']['gold']] = 2,
        }
    },
    ['Searing Golden Blade'] = {
        skill = 190,
        description = '[BoE] (1H Dagger) Dmg: 21-39, Spd: 1.40, DPS: 21.4, MinLvl: 34, Equip: Increases damage done by Fire spells and effects by up to 7.',
        type = 'Dagger',
        source = 'Drop:Plans: Searing Golden Blade',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['bar']['steel']] = 10,
            [ReagentData['bar']['gold']] = 4,
            [ReagentData['element']['fire']] = 2,
        }
    },
    ['Steel Weapon Chain'] = {
        skill = 190,
        description = 'Requires Blacksmithing (190), Use: Attaches a chain to your weapon, making it impossible to disarm.',
        type = 'Trade Goods',
        source = 'Drop:Plans: Steel Weapon Chain',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['bar']['steel']] = 8,
            [ReagentData['grinding']['heavy']] = 2,
        }
    },
    ['Golden Scale Cuirass'] = {
        skill = 195,
        description = '[BoE] (Mail Chest) AC: 231, Str: 14, Spi: 6, MinLvl: 35',
        type = 'Mail',
        source = 'Drop:Plans: Golden Scale Cuirass',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['steel']] = 12,
            [ReagentData['grinding']['heavy']] = 4,
            [ReagentData['bar']['gold']] = 2,
            [ReagentData['gem']['jade']] = 2,
        }
    },
    ['Frost Tiger Blade'] = {
        skill = 200,
        description = '[BoE] (2H Sword) Dmg: 78-118, Spd: 3.40, DPS: 28.8, MinLvl: 35, Equip: Improves your chance to get a critical strike by 1%., Chance on hit: Launches a bolt of frost at the enemy causing 20 to 30 Frost damage and slowing movement speed by 50% f',
        type = 'Two-Hand Sword',
        source = 'Drop:Plans: Frost Tiger Blade',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['bar']['steel']] = 8,
            [ReagentData['grinding']['heavy']] = 2,
            [ReagentData['oil']['frost']] = 1,
            [ReagentData['gem']['jade']] = 2,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Golden Scale Boots'] = {
        skill = 200,
        description = '[BoE] (Mail Feet) AC: 159, Str: 8, Spi: 8, MinLvl: 35',
        type = 'Mail',
        source = 'Drop:Plans: Golden Scale Boots',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['steel']] = 10,
            [ReagentData['grinding']['heavy']] = 4,
            [ReagentData['gem']['citrine']] = 1,
            [ReagentData['bar']['gold']] = 4,
        }
    },
    ['Inlaid Mithril Cylinder'] = {
        skill = 200,
        description = 'Used by Gnomish Engineers to reinforce their creations',
        type = 'Reagent',
        source = 'Recipe:Plans: Inlaid Mithril Cylinder',
        result = 1,
        reagents = {
            [ReagentData['bar']['truesilver']] = 1,
            [ReagentData['bar']['gold']] = 1,
            [ReagentData['bar']['mithril']] = 5,
        }
    },
    ['Shadow Crescent Axe'] = {
        skill = 200,
        description = '[BoE] (2H Axe) Dmg: 58-87, Spd: 2.50, DPS: 29.0, Str: 11, Sta: 10, MinLvl: 35',
        type = 'Two-Hand Axe',
        source = 'Drop:Plans: Shadow Crescent Axe',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 3,
            [ReagentData['bar']['steel']] = 10,
            [ReagentData['grinding']['heavy']] = 3,
            [ReagentData['gem']['citrine']] = 2,
            [ReagentData['oil']['shadow']] = 1,
            [ReagentData['flux']['strong']] = 2,
        }
    },
    ['Solid Grinding Stone'] = {
        skill = 200,
        description = 'Solid Grinding Stone',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['solid']] = 4,
        }
    },
    ['Solid Sharpening Stone'] = {
        skill = 200,
        description = 'MinLvl: 25, Use: Increase sharp weapon damage by 6 for 30 minutes.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['solid']] = 1,
        }
    },
    ['Solid Weightstone'] = {
        skill = 200,
        description = 'MinLvl: 25, Use: Increase the damage of a blunt weapon by 6 for 30 minutes.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['solid']] = 1,
            [ReagentData['cloth']['silk']] = 1,
        }
    },
    ['Steel Breastplate'] = {
        skill = 200,
        description = '[BoE] (Mail Chest) AC: 381, MinLvl: 35',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['steel']] = 16,
            [ReagentData['grinding']['heavy']] = 3,
        }
    },
    ['Truesilver Rod'] = {
        skill = 200,
        description = 'Needed by Enchanters.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['grinding']['heavy']] = 1,
            [ReagentData['bar']['truesilver']] = 1,
        }
    },
    ['Truesilver Skeleton Key'] = {
        skill = 200,
        description = 'Requires Blacksmithing (200), Use: Allows opening of difficult locks. The skeleton key is consumed in the process.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 2,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['truesilver']] = 1,
            [ReagentData['grinding']['solid']] = 1,
        }
    },
    ['Golden Scale Gauntlets'] = {
        skill = 205,
        description = '[BoE] (Mail Hands) AC: 146, Str: 11, Spi: 4, MinLvl: 36',
        type = 'Mail',
        source = 'Quest:Plans: Golden Scale Gauntlets',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['steel']] = 10,
            [ReagentData['grinding']['heavy']] = 4,
            [ReagentData['gem']['citrine']] = 1,
            [ReagentData['bar']['gold']] = 4,
        }
    },
    ['Heavy Mithril Gauntlet'] = {
        skill = 205,
        description = '[BoE] (Plate Hands) AC: 268, Sta: 8, MinLvl: 40',
        type = 'Plate',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['mithril']] = 6,
            [ReagentData['cloth']['mageweave']] = 4,
        }
    },
    ['Heavy Mithril Shoulder'] = {
        skill = 205,
        description = '[BoE] (Plate Shoulder) AC: 225, Sta: 12, MinLvl: 40',
        type = 'Plate',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 6,
            [ReagentData['bar']['mithril']] = 8,
        }
    },
    ['Heavy Mithril Axe'] = {
        skill = 210,
        description = '[BoE] (MH Axe) Dmg: 45-85, Spd: 2.70, DPS: 24.1, Sta: 7, MinLvl: 37',
        type = 'Axe',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['gem']['citrine']] = 2,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 12,
        }
    },
    ['Heavy Mithril Pants'] = {
        skill = 210,
        description = '[BoE] (Plate Legs) AC: 417, Sta: 11, MinLvl: 40',
        type = 'Plate',
        source = 'Drop:Plans: Heavy Mithril Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['lessermoonstone']] = 2,
            [ReagentData['bar']['mithril']] = 10,
        }
    },
    ['Mithril Scale Pants'] = {
        skill = 210,
        description = '[BoE] (Mail Legs) AC: 208, Spi: 11, MinLvl: 37, Equip: Increases your chance to dodge an attack by 1%.',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['mithril']] = 12,
        }
    },
    ['Mithril Scale Bracers'] = {
        skill = 215,
        description = '[BoE] (Mail Wrist) AC: 106, Sta: 6, Spi: 7, MinLvl: 38',
        type = 'Mail',
        source = 'Vendor:Plans: Mithril Scale Bracers',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['citrine']] = 2,
            [ReagentData['bar']['mithril']] = 8,
        }
    },
    ['Mithril Shield Spike'] = {
        skill = 215,
        description = 'Requires Blacksmithing (215), Use: Attaches a Mithril Spike to your shield that deals damage every time you block with it.',
        type = 'Trade Goods',
        source = 'Drop:Plans: Mithril Shield Spike',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['truesilver']] = 2,
            [ReagentData['grinding']['solid']] = 4,
            [ReagentData['bar']['mithril']] = 4,
        }
    },
    ['Steel Plate Helm'] = {
        skill = 215,
        description = '(Plate Head) AC: 355, MinLvl: 40',
        type = 'Plate',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['steel']] = 14,
            [ReagentData['grinding']['solid']] = 1,
        }
    },
    ['Blue Glittering Axe'] = {
        skill = 220,
        description = '[BoE] (1H Axe) Dmg: 32-61, Spd: 1.80, DPS: 25.8, Agi: 8, MinLvl: 39',
        type = 'Axe',
        source = 'Drop:Plans: Blue Glittering Axe',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['aquamarine']] = 2,
            [ReagentData['leather']['thick']] = 4,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 16,
        }
    },
    ['Ornate Mithril Gloves'] = {
        skill = 220,
        description = '[BoE] (Plate Hands) AC: 268, MinLvl: 40, Equip: Improves your chance to get a critical strike by 1%.',
        type = 'Plate',
        source = 'Quest:Plans: Ornate Mithril Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['truesilver']] = 1,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 10,
            [ReagentData['cloth']['mageweave']] = 6,
        }
    },
    ['Ornate Mithril Pants'] = {
        skill = 220,
        description = '[BoE] (Plate Legs) AC: 375, Str: 12, MinLvl: 40, Equip: Increases your chance to dodge an attack by 1%.',
        type = 'Plate',
        source = 'Quest:Plans: Ornate Mithril Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['aquamarine']] = 1,
            [ReagentData['bar']['truesilver']] = 1,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 12,
        }
    },
    ['Ornate Mithril Shoulder'] = {
        skill = 225,
        description = '[BoE] (Plate Shoulder) AC: 327, Str: 5, MinLvl: 40, Equip: Increases your chance to dodge an attack by 1%.',
        source = 'Quest',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 6,
            [ReagentData['bar']['truesilver']] = 1,
            [ReagentData['bar']['mithril']] = 12,
        }
    },
    ['Truesilver Gauntlets'] = {
        skill = 225,
        description = '[BoE] (Plate Hands) AC: 300, Str: 16, Sta: 7, MinLvl: 40',
        type = 'Plate',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['aquamarine']] = 3,
            [ReagentData['gem']['citrine']] = 3,
            [ReagentData['bar']['truesilver']] = 8,
            [ReagentData['armor']['guardiangloves']] = 1,
            [ReagentData['grinding']['solid']] = 2,
            [ReagentData['bar']['mithril']] = 10,
        }
    },
    ['Wicked Mithril Blade'] = {
        skill = 225,
        description = '[BoE] (MH Sword) Dmg: 43-80, Spd: 2.30, DPS: 26.7, Str: 6, Agi: 4, MinLvl: 40',
        type = 'Sword',
        source = 'Drop:Plans: Wicked Mithril Blade',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 2,
            [ReagentData['bar']['truesilver']] = 4,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 14,
        }
    },
    ['Big Black Mace'] = {
        skill = 230,
        description = '[BoE] (MH Mace) Dmg: 46-86, Spd: 2.40, DPS: 27.5, Str: 8, MinLvl: 41',
        type = 'Mace',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 2,
            [ReagentData['gem']['shadow']] = 4,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 16,
            [ReagentData['pearl']['black']] = 1,
        }
    },
    ['Heavy Mithril Breastplate'] = {
        skill = 230,
        description = '[BoE] (Plate Chest) AC: 536, Sta: 15, MinLvl: 41',
        type = 'Plate',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['mithril']] = 16,
        }
    },
    ['Mithril Coif'] = {
        skill = 230,
        description = '[BoE] (Mail Head) AC: 206, Sta: 12, Spi: 13, MinLvl: 41',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['mithril']] = 10,
            [ReagentData['cloth']['mageweave']] = 6,
        }
    },
    ['Orcish War Leggings'] = {
        skill = 230,
        description = '[BoE] (Mail Legs) AC: 208, Str: 17, MinLvl: 37',
        type = 'Mail',
        source = 'Quest',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['earth']] = 1,
            [ReagentData['bar']['mithril']] = 12,
        }
    },
    ['Heavy Mithril Boots'] = {
        skill = 235,
        description = '[BoE] (Plate Feet) AC: 382, Sta: 12, MinLvl: 42',
        type = 'Plate',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 4,
            [ReagentData['bar']['mithril']] = 14,
        }
    },
    ['Mithril Scale Shoulders'] = {
        skill = 235,
        description = '[BoE] (Mail Shoulder) AC: 194, Sta: 10, Spi: 10, MinLvl: 42',
        type = 'Mail',
        source = 'Drop:Plans: Mithril Scale Shoulders',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 4,
            [ReagentData['gem']['citrine']] = 4,
            [ReagentData['bar']['mithril']] = 14,
        }
    },
    ['Mithril Spurs'] = {
        skill = 235,
        description = 'Requires Blacksmithing (215), Use: Attaches spurs to your boots that increase your mounted movement speed slightly.',
        type = 'Trade Goods',
        source = 'Drop:Plans: Mithril Spurs',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['grinding']['solid']] = 3,
            [ReagentData['bar']['mithril']] = 4,
        }
    },
    ['Ornate Mithril Boots'] = {
        skill = 240,
        description = '[BoE] (Plate Feet) AC: 324, MinLvl: 44, Equip: Increases your chance to dodge an attack by 1%., Use: Removes existing root spells and makes you immune to root for 5 sec.',
        type = 'Plate',
        source = 'Quest',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 4,
            [ReagentData['gem']['aquamarine']] = 1,
            [ReagentData['bar']['truesilver']] = 2,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 14,
        }
    },
    ['The Shatterer'] = {
        skill = 235,
        description = '[BoE] (MH Mace) Dmg: 53-99, Spd: 2.40, DPS: 31.7, MinLvl: 42, Chance on hit: Disarm target\'s weapon for 10 sec.',
        type = 'Mace',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['citrine']] = 5,
            [ReagentData['element']['coreofearth']] = 4,
            [ReagentData['bar']['truesilver']] = 6,
            [ReagentData['gem']['jade']] = 5,
            [ReagentData['grinding']['solid']] = 4,
            [ReagentData['bar']['mithril']] = 24,
        [ReagentData['leather']['thick']] = 4,
        }
    },
    ['Dazzling Mithril Rapier'] = {
        skill = 240,
        description = '[BoE] (MH Sword) Dmg: 34-63, Spd: 1.70, DPS: 28.5, Agi: 8, MinLvl: 43',
        type = 'Sword',
        source = 'Drop:Plans: Dazzling Mithril Rapier',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['aquamarine']] = 1,
            [ReagentData['gem']['mossagate']] = 2,
            [ReagentData['gem']['lessermoonstone']] = 2,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 14,
            [ReagentData['cloth']['mageweave']] = 2,
        }
    },
    ['Ornate Mithril Breastplate'] = {
        skill = 235,
        description = '[BoE] (Plate Chest) AC: 463, MinLvl: 43, Equip: Improves your chance to get a critical strike by 1%., Equip: Increases your chance to dodge an attack by 1%.',
        type = 'Plate',
        source = 'Quest',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['truesilver']] = 4,
            [ReagentData['element']['heartoffire']] = 1,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 16,
        }
    },
    ['Heavy Mithril Helm'] = {
        skill = 245,
        description = '[BoE] (Plate Head) AC: 469, Sta: 15, MinLvl: 42',
        type = 'Plate',
        source = 'Drop:Plans: Heavy Mithril Helm',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['aquamarine']] = 1,
            [ReagentData['bar']['mithril']] = 14,
        }
    },
    ['Ornate Mithril Helm'] = {
        skill = 245,
        description = '[BoE] (Plate Head) AC: 383, Str: 10, MinLvl: 44, Equip: Improves your chance to get a critical strike by 1%.',
        type = 'Plate',
        source = 'Quest',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['truesilver']] = 2,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 16,
            [ReagentData['pearl']['black']] = 1,
        }
    },
    ['Phantom Blade'] = {
        skill = 245,
        description = '[BoE] (MH Sword) Dmg: 59-111, Spd: 2.60, DPS: 32.7, MinLvl: 44, Chance on hit: Decrease the armor of the target by 100 for 20 sec. While affected, the target cannot stealth or turn invisible.',
        type = 'Sword',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['aquamarine']] = 6,
            [ReagentData['bar']['truesilver']] = 8,
            [ReagentData['leather']['thick']] = 2,
            [ReagentData['element']['breathofwind']] = 6,
            [ReagentData['potion']['lesserinvisibility']] = 2,
            [ReagentData['grinding']['solid']] = 4,
            [ReagentData['bar']['mithril']] = 28,
        }
    },
    ['Runed Mithril Hammer'] = {
        skill = 245,
        description = '[BoE] (MH Mace) Dmg: 41-76, Spd: 2.00, DPS: 29.2, Str: 7, Sta: 4, MinLvl: 44',
        type = 'Mace',
        source = 'Drop:Plans: Runed Mithril Hammer',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 4,
            [ReagentData['element']['coreofearth']] = 2,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 18,
        }
    },
    ['Truesilver Breastplate'] = {
        skill = 245,
        description = '[BoE] (Plate Chest) AC: 519, Sta: 12, MinLvl: 44, Equip: When struck in combat has a 3% chance to heal you for 60 to 100.',
        type = 'Plate',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['starruby']] = 4,
            [ReagentData['bar']['truesilver']] = 24,
            [ReagentData['grinding']['solid']] = 2,
            [ReagentData['bar']['mithril']] = 12,
            [ReagentData['pearl']['black']] = 4,
        }
    },
    ['Blight'] = {
        skill = 250,
        description = '[BoE] (2H Polearm) Dmg: 93-141, Spd: 2.70, DPS: 43.3, MinLvl: 45, Chance on hit: Diseases a target for 50 Nature damage and an additional 180 damage over 1 min.',
        type = 'Polearm',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['thick']] = 6,
            [ReagentData['element']['ichorofundeath']] = 10,
            [ReagentData['bar']['truesilver']] = 10,
            [ReagentData['grinding']['solid']] = 6,
            [ReagentData['bar']['mithril']] = 28,
        }
    },
    ['Dense Grinding Stone'] = {
        skill = 250,
        description = 'Dense Grinding Stone',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['dense']] = 4,
        }
    },
    ['Dense Sharpening Stone'] = {
        skill = 250,
        description = 'MinLvl: 35, Use: Increase sharp weapon damage by 8 for 30 minutes.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['dense']] = 1,
        }
    },
    ['Dense Weightstone'] = {
        skill = 250,
        description = 'MinLvl: 35, Use: Increase the damage of a blunt weapon by 8 for 30 minutes.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['dense']] = 1,
            [ReagentData['cloth']['rune']] = 1,
        }
    },
    ['Thorium Armor'] = {
        skill = 250,
        description = '[BoE] (Plate Chest) AC: 480, AR: 8, FR: 8, NR: 8, CR: 8, SR: 8, MinLvl: 45',
        type = 'Plate',
        source = 'Drop:Plans: Thorium Armor',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['other']['yellowpowercrystal']] = 4,
            [ReagentData['bar']['thorium']] = 16,
            [ReagentData['gem']['bluesapphire']] = 1,
        }
    },
    ['Thorium Belt'] = {
        skill = 250,
        description = '[BoE] (Plate Waist) AC: 270, AR: 6, FR: 6, NR: 6, CR: 6, SR: 6, MinLvl: 45',
        type = 'Plate',
        source = 'Drop:Plans: Thorium Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['other']['redpowercrystal']] = 4,
            [ReagentData['bar']['thorium']] = 12,
        }
    },
    ['Ebon Shiv'] = {
        skill = 255,
        description = '[BoE] (1H Dagger) Dmg: 32-59, Spd: 1.50, DPS: 30.3, Agi: 9, MinLvl: 46',
        type = 'Dagger',
        source = 'Vendor:Plans: Ebon Shiv',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 2,
            [ReagentData['leather']['thick']] = 2,
            [ReagentData['bar']['truesilver']] = 6,
            [ReagentData['grinding']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 12,
        }
    },
    ['Thorium Bracers'] = {
        skill = 255,
        description = '[BoE] (Plate Wrist) AC: 214, AR: 5, FR: 5, NR: 5, CR: 5, SR: 5, MinLvl: 46',
        type = 'Plate',
        source = 'Drop:Plans: Thorium Bracers',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['other']['bluepowercrystal']] = 4,
            [ReagentData['bar']['thorium']] = 12,
        }
    },
    ['Radiant Belt'] = {
        skill = 260,
        description = '[BoE] (Mail Waist) AC: 159, CR: 12, SR: 12, MinLvl: 47',
        type = 'Mail',
        source = 'Drop:Plans: Radiant Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['thorium']] = 10,
            [ReagentData['element']['heartoffire']] = 2,
        }
    },
    ['Truesilver Champion'] = {
        skill = 260,
        description = '[BoE] (2H Sword) Dmg: 108-162, Spd: 3.00, DPS: 45.0, MinLvl: 47, Chance on hit: Protects the caster with a holy shield.',
        type = 'Two-Hand Sword',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['starruby']] = 6,
            [ReagentData['leather']['thick']] = 6,
            [ReagentData['bar']['truesilver']] = 16,
            [ReagentData['element']['breathofwind']] = 4,
            [ReagentData['grinding']['solid']] = 8,
            [ReagentData['bar']['mithril']] = 30,
        }
    },
    ['Dark Iron Pulverizer'] = {
        skill = 265,
        description = '[BoE] (2H Mace) Dmg: 140-211, Spd: 3.70, DPS: 47.4, MinLvl: 50, Chance on hit: Stuns target for 8 sec.',
        type = 'Two-Hand Mace',
        source = 'Drop:Plans: Dark Iron Pulverizer',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['darkiron']] = 18,
            [ReagentData['element']['heartoffire']] = 4,
        }
    },
    ['Dark Iron Mail'] = {
        skill = 270,
        description = '[BoE] (Mail Chest) AC: 433, Sta: 13, FR: 12, MinLvl: 51',
        type = 'Mail',
        source = 'Drop:Plans: Dark Iron Mail',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['darkiron']] = 10,
            [ReagentData['element']['heartoffire']] = 2,
        }
    },
    ['Radiant Breastplate'] = {
        skill = 270,
        description = '[BoE] (Mail Chest) AC: 293, CR: 16, SR: 16, MinLvl: 49',
        type = 'Mail',
        source = 'Drop:Plans: Radiant Breastplate',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 1,
            [ReagentData['bar']['thorium']] = 18,
            [ReagentData['element']['heartoffire']] = 2,
        }
    },
    ['Wildthorn Mail'] = {
        skill = 270,
        description = '[BoE] (Mail Chest) AC: 322, Sta: 5, Spi: 11, MinLvl: 49, Equip: Increases damage done by Nature spells and effects by up to 30.',
        type = 'Mail',
        source = 'Drop:Plans: Wildthorn Mail',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['herb']['wildvine']] = 4,
            [ReagentData['bar']['enchantedthorium']] = 2,
            [ReagentData['gem']['hugeemerald']] = 1,
            [ReagentData['element']['livingessence']] = 4,
            [ReagentData['bar']['thorium']] = 40,
        }
    },
    ['Arcanite Rod'] = {
        skill = 275,
        description = 'Needed by Enchanters.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['grinding']['dense']] = 1,
            [ReagentData['bar']['arcanite']] = 3,
        }
    },
    ['Arcanite Skeleton Key'] = {
        skill = 275,
        description = 'Requires Blacksmithing (275), Use: Allows opening of hard locks. The skeleton key is consumed in the process.',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 2,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['grinding']['dense']] = 1,
            [ReagentData['bar']['arcanite']] = 1,
        }
    },
    ['Dark Iron Sunderer'] = {
        skill = 275,
        description = '[BoE] (2H Axe) Dmg: 101-153, Spd: 2.60, DPS: 48.8, MinLvl: 52, Chance on hit: Reduces targets armor by 300 for 20 sec.',
        type = 'Two-Hand Axe',
        source = 'Drop:Plans: Dark Iron Sunderer',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['darkiron']] = 26,
            [ReagentData['element']['heartoffire']] = 4,
        }
    },
    ['Dawn\'s Edge'] = {
        skill = 275,
        description = '[BoE] (1H Axe) Dmg: 53-100, Spd: 2.10, DPS: 36.4, MinLvl: 50, Equip: Improves your chance to get a critical strike by 1%.',
        type = 'Axe',
        source = 'Quest:Plans: Dawn\'s Edge',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['starruby']] = 4,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['bar']['enchantedthorium']] = 4,
            [ReagentData['bar']['thorium']] = 30,
            [ReagentData['gem']['bluesapphire']] = 4,
            [ReagentData['grinding']['dense']] = 2,
        }
    },
    ['Ornate Thorium Handaxe'] = {
        skill = 275,
        description = '[BoP] (MH Axe) Dmg: 43-81, Spd: 1.90, DPS: 32.6, Str: 10, MinLvl: 50',
        type = 'Axe',
        source = 'Vendor:Plans: Ornate Thorium Handaxe',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['grinding']['dense']] = 2,
            [ReagentData['gem']['largeopal']] = 2,
        }
    },
    ['Thorium Shield Spike'] = {
        skill = 275,
        description = 'Requires Blacksmithing (250), Use: Attaches a Thorium Spike to your shield that deals damage every time you block with it.',
        type = 'Trade Goods',
        source = 'Drop:Plans: Thorium Shield Spike',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['essenceofearth']] = 2,
            [ReagentData['bar']['thorium']] = 4,
            [ReagentData['grinding']['dense']] = 4,
        }
    },
    ['Blazing Rapier'] = {
        skill = 280,
        description = '[BoE] (1H Sword) Dmg: 44-82, Spd: 1.70, DPS: 37.1, MinLvl: 51, Chance on hit: Burns the enemy for 100 damage over 30 sec.',
        type = 'Sword',
        source = 'Quest:Plans: Blazing Rapier',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['enchantedthorium']] = 10,
            [ReagentData['gem']['azerothiandiamond']] = 2,
            [ReagentData['element']['essenceoffire']] = 4,
            [ReagentData['element']['heartoffire']] = 4,
            [ReagentData['grinding']['dense']] = 2,
        }
    },
    ['Dark Iron Shoulders'] = {
        skill = 280,
        description = '[BoE] (Plate Shoulder) AC: 514, Sta: 10, FR: 10, MinLvl: 53',
        type = 'Plate',
        source = 'Drop:Plans: Dark Iron Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['darkiron']] = 6,
            [ReagentData['element']['heartoffire']] = 1,
        }
    },
    ['Enchanted Battlehammer'] = {
        skill = 280,
        description = '[BoE] (2H Mace) Dmg: 100-150, Spd: 2.60, DPS: 48.1, MinLvl: 51, Equip: Increases your chance to parry an attack by 1%., Equip: Improves your chance to hit by 2%.',
        type = 'Two-Hand Mace',
        source = 'Quest:Plans: Enchanted Battlehammer',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['powerfulmojo']] = 4,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['bar']['enchantedthorium']] = 6,
            [ReagentData['gem']['hugeemerald']] = 2,
            [ReagentData['bar']['thorium']] = 20,
        }
    },
    ['Huge Thorium Battleaxe'] = {
        skill = 280,
        description = '[BoE] (2H Axe) Dmg: 114-172, Spd: 3.30, DPS: 43.3, MinLvl: 51, Equip: Increased Two-handed Axes +10.',
        type = 'Two-Hand Axe',
        source = 'Vendor:Plans: Huge Thorium Battleaxe',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['rugged']] = 6,
            [ReagentData['bar']['thorium']] = 40,
            [ReagentData['grinding']['dense']] = 6,
        }
    },
    ['Thorium Boots'] = {
        skill = 280,
        description = '[BoE] (Plate Feet) AC: 367, AR: 7, FR: 7, NR: 7, CR: 7, SR: 7, MinLvl: 51',
        type = 'Plate',
        source = 'Drop:Plans: Thorium Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['rugged']] = 8,
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['other']['greenpowercrystal']] = 4,
        }
    },
    ['Thorium Helm'] = {
        skill = 280,
        description = '[BoE] (Plate Head) AC: 434, AR: 10, FR: 10, NR: 10, CR: 10, SR: 10, MinLvl: 51',
        type = 'Plate',
        source = 'Drop:Plans: Thorium Helm',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 1,
            [ReagentData['other']['yellowpowercrystal']] = 4,
            [ReagentData['bar']['thorium']] = 24,
        }
    },
    ['Dark Iron Plate'] = {
        skill = 285,
        description = '[BoP] (Plate Chest) AC: 817, Sta: 12, FR: 19, MinLvl: 54',
        type = 'Plate',
        source = 'Drop:Plans: Dark Iron Plate',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['darkiron']] = 20,
            [ReagentData['element']['heartoffire']] = 8,
        }
    },
    ['Demon Forged Breastplate'] = {
        skill = 285,
        description = '[BoE] (Plate Chest) AC: 597, Sta: 12, MinLvl: 52, Equip: When struck has a 3% chance of stealing 120 life from the attacker over 4 sec.',
        type = 'Plate',
        source = 'Quest:Plans: Demon Forged Breastplate',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['demonicrune']] = 10,
            [ReagentData['gem']['starruby']] = 4,
            [ReagentData['bar']['thorium']] = 40,
            [ReagentData['gem']['bluesapphire']] = 4,
        }
    },
    ['Radiant Gloves'] = {
        skill = 285,
        description = '[BoE] (Mail Hands) AC: 192, CR: 12, SR: 12, MinLvl: 52',
        type = 'Mail',
        source = 'Drop:Plans: Radiant Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['thorium']] = 18,
            [ReagentData['element']['heartoffire']] = 4,
        }
    },
    ['Serenity'] = {
        skill = 285,
        description = '[BoE] (MH Mace) Dmg: 52-98, Spd: 2.00, DPS: 37.5, MinLvl: 52, Chance on hit: Dispels a magic effect on the current foe.',
        type = 'Mace',
        source = 'Drop:Plans: Serenity',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['powerfulmojo']] = 4,
            [ReagentData['bar']['enchantedthorium']] = 6,
            [ReagentData['gem']['hugeemerald']] = 1,
            [ReagentData['gem']['bluesapphire']] = 2,
            [ReagentData['bar']['arcanite']] = 2,
            [ReagentData['gem']['largeopal']] = 2,
        }
    },
    ['Corruption'] = {
        skill = 290,
        description = '[BoP] (2H Sword) Dmg: 119-179, Spd: 3.00, DPS: 49.7, Str: 30, Sta: 30, Spi: -40, MinLvl: 53',
        type = 'Two-Hand Sword',
        source = 'Drop:Plans: Corruption',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['demonicrune']] = 16,
            [ReagentData['element']['essenceofundeath']] = 8,
            [ReagentData['bar']['thorium']] = 40,
            [ReagentData['gem']['bluesapphire']] = 2,
            [ReagentData['grinding']['dense']] = 2,
            [ReagentData['bar']['arcanite']] = 2,
        [ReagentData['leather']['rugged']] = 4,
        }
    },
    ['Fiery Plate Gauntlets'] = {
        skill = 290,
        description = '[BoE] (Plate Hands) AC: 379, FR: 10, MinLvl: 53, Equip: Adds 4 fire damage to your weapon attack.',
        type = 'Plate',
        source = 'Quest:Plans: Fiery Plate Gauntlets',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['starruby']] = 4,
            [ReagentData['bar']['enchantedthorium']] = 6,
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['element']['essenceoffire']] = 2,
        }
    },
    ['Radiant Boots'] = {
        skill = 290,
        description = '[BoE] (Mail Feet) AC: 215, CR: 15, SR: 15, MinLvl: 53',
        type = 'Mail',
        source = 'Drop:Plans: Radiant Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['thorium']] = 14,
            [ReagentData['element']['heartoffire']] = 4,
        }
    },
    ['Volcanic Hammer'] = {
        skill = 290,
        description = '[BoE] (MH Mace) Dmg: 60-113, Spd: 2.50, DPS: 34.6, MinLvl: 53, Chance on hit: Hurls a fiery ball that causes 100 to 128 Fire damage and an additional 18 damage over 6 sec.',
        type = 'Mace',
        source = 'Drop:Plans: Volcanic Hammer',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 4,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['bar']['thorium']] = 30,
            [ReagentData['element']['heartoffire']] = 4,
        }
    },
    ['Dark Iron Bracers'] = {
        skill = 295,
        description = '[BoP] (Plate Wrist) AC: 394, Sta: 7, FR: 18, MinLvl: 54',
        type = 'Plate',
        source = 'Vendor:Plans: Dark Iron Bracers',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['bar']['darkiron']] = 4,
            [ReagentData['monster']['fierycore']] = 2,
            [ReagentData['monster']['lavacore']] = 2,
        }
    },
    ['Fiery Chain Girdle'] = {
        skill = 295,
        description = '[BoP] (Mail Waist) AC: 214, Sta: 10, Int: 9, Spi: 8, FR: 24, MinLvl: 54',
        type = 'Mail',
        source = 'Vendor:Plans: Fiery Chain Girdle',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['bar']['darkiron']] = 6,
            [ReagentData['monster']['fierycore']] = 3,
            [ReagentData['monster']['lavacore']] = 3,
        }
    },
    ['Radiant Circlet'] = {
        skill = 295,
        description = '[BoE] (Mail Head) AC: 258, CR: 18, SR: 18, MinLvl: 54',
        type = 'Mail',
        source = 'Drop:Plans: Radiant Circlet',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['thorium']] = 18,
            [ReagentData['element']['heartoffire']] = 4,
        }
    },
    ['Storm Gauntlets'] = {
        skill = 295,
        description = '[BoE] (Mail Hands) AC: 218, Int: 7, FR: 10, MinLvl: 54, Equip: Adds 3 Lightning damage to your weapon attack., Equip: Increases damage done by Nature spells and effects by up to 15.',
        type = 'Mail',
        source = 'Drop, Vendor:Plans: Storm Gauntlets',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['enchantedthorium']] = 4,
            [ReagentData['element']['essenceofwater']] = 4,
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['gem']['bluesapphire']] = 4,
        }
    },
    ['Annihilator'] = {
        skill = 300,
        description = '[BoE] (MH Axe) Dmg: 49-92, Spd: 1.70, DPS: 41.5, MinLvl: 58, Chance on hit: Enemies armor is reduced by 200. Stacks up to 3 times.',
        type = 'Axe',
        source = 'Drop:Plans: Annihilator',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['element']['essenceofundeath']] = 10,
            [ReagentData['gem']['hugeemerald']] = 8,
            [ReagentData['bar']['thorium']] = 40,
            [ReagentData['grinding']['dense']] = 2,
            [ReagentData['bar']['arcanite']] = 12,
            [ReagentData['leather']['enchanted']] = 4,
        }
    },
    ['Arcanite Champion'] = {
        skill = 300,
        description = '[BoE] (2H Sword) Dmg: 129-194, Spd: 3.00, DPS: 53.8, MinLvl: 58, Chance on hit: Heal self for 270 to 450 and Increases Strength by 120 for 30 sec.',
        type = 'Two-Hand Sword',
        source = 'Drop:Plans: Arcanite Champion',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['righteousorb']] = 1,
            [ReagentData['gem']['azerothiandiamond']] = 8,
            [ReagentData['grinding']['dense']] = 2,
            [ReagentData['bar']['arcanite']] = 15,
            [ReagentData['gem']['largeopal']] = 4,
            [ReagentData['leather']['enchanted']] = 8,
        }
    },
    ['Arcanite Reaper'] = {
        skill = 300,
        description = '[BoE] (2H Axe) Dmg: 153-256, Spd: 3.80, DPS: 53.8, Sta: 13, MinLvl: 58, Equip: +62 Attack Power.',
        type = 'Two-Hand Axe',
        source = 'Drop:Plans: Arcanite Reaper',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['grinding']['dense']] = 2,
            [ReagentData['bar']['arcanite']] = 20,
            [ReagentData['leather']['enchanted']] = 6,
        }
    },
    ['Dark Iron Destroyer'] = {
        skill = 300,
        description = '[BoE] (MH Axe) Dmg: 71-134, Spd: 2.40, DPS: 42.7, Str: 10, FR: 6, MinLvl: 60',
        type = 'Axe',
        source = 'Vendor:Plans: Dark Iron Destroyer',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['darkiron']] = 18,
            [ReagentData['gem']['bloodofthemountain']] = 2,
            [ReagentData['monster']['lavacore']] = 12,
            [ReagentData['leather']['enchanted']] = 2,
        }
    },
    ['Dark Iron Leggings'] = {
        skill = 300,
        description = '[BoE] (Plate Legs) AC: 778, Sta: 14, FR: 30, MinLvl: 55',
        type = 'Plate',
        source = 'Vendor:Plans: Dark Iron Leggings',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['bar']['darkiron']] = 16,
            [ReagentData['monster']['fierycore']] = 4,
            [ReagentData['monster']['lavacore']] = 6,
        }
    },
    ['Dark Iron Reaver'] = {
        skill = 300,
        description = '[BoE] (MH Sword) Dmg: 71-134, Spd: 2.40, DPS: 42.7, Sta: 10, FR: 6, MinLvl: 60',
        type = 'Sword',
        source = 'Vendor:Plans: Dark Iron Reaver',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['darkiron']] = 16,
            [ReagentData['monster']['fierycore']] = 12,
            [ReagentData['gem']['bloodofthemountain']] = 2,
            [ReagentData['leather']['enchanted']] = 2,
        }
    },
    ['Elemental Sharpening Stone'] = {
        skill = 300,
        description = 'MinLvl: 50, Use: Increase critical chance on a melee weapon by 2% for 30 minutes.',
        type = 'Trade Goods',
        source = 'Drop:Plans: Elemental Sharpening Stone',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['earth']] = 2,
            [ReagentData['stone']['dense']] = 3,
        }
    },
    ['Fiery Chain Shoulders'] = {
        skill = 300,
        description = '[BoE] (Mail Shoulders) AC: 299, Int: 14, Sta: 10, FR: 25, MinLvl: 57',
        type = 'Mail',
        source = 'Vendor:Plans: Fiery Chain Shoulders',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['bar']['darkiron']] = 16,
            [ReagentData['monster']['fierycore']] = 4,
            [ReagentData['monster']['lavacore']] = 5,
        }
    },
    ['Frostguard'] = {
        skill = 300,
        description = '[BoE] (MH Sword) Dmg: 66-124, Spd: 2.30, DPS: 41.3, MinLvl: 58, Chance on hit: Target\'s movement slowed to 70% and attacks slowed by 20% for 5 sec.',
        type = 'Sword',
        source = 'Drop:Plans: Frostguard',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['element']['essenceofwater']] = 4,
            [ReagentData['gem']['azerothiandiamond']] = 8,
            [ReagentData['gem']['bluesapphire']] = 8,
            [ReagentData['grinding']['dense']] = 2,
            [ReagentData['bar']['arcanite']] = 18,
            [ReagentData['leather']['enchanted']] = 4,
        }
    },
    ['Hammer of the Titans'] = {
        skill = 300,
        description = '[BoE] (2H Mace) Dmg: 163-246, Spd: 3.80, DPS: 53.8, Str: 15, MinLvl: 58, Chance on hit: Stuns target for 3 sec.',
        type = 'Two-Hand Mace',
        source = 'Drop:Plans: Hammer of the Titans',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['element']['essenceofearth']] = 10,
            [ReagentData['monster']['guardianstone']] = 4,
            [ReagentData['bar']['thorium']] = 50,
            [ReagentData['bar']['arcanite']] = 15,
            [ReagentData['leather']['enchanted']] = 6,
        }
    },
    ['Heartseeker'] = {
        skill = 300,
        description = '[BoE] [U] (1H Dagger) Dmg: 49-92, Spd: 1.70, DPS: 41.5, Str: 4, MinLvl: 58, Equip: Improves your chance to get a critical strike by 1%.',
        type = 'Dagger',
        source = 'Drop:Plans: Heartseeker',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['starruby']] = 6,
            [ReagentData['bar']['enchantedthorium']] = 10,
            [ReagentData['gem']['azerothiandiamond']] = 6,
            [ReagentData['bar']['arcanite']] = 10,
            [ReagentData['leather']['enchanted']] = 2,
            [ReagentData['gem']['largeopal']] = 6,
            [ReagentData['grinding']['dense']] = 4,
        }
    },
    ['Helm of the Great Chief'] = {
        skill = 300,
        description = '[BoE] (Mail Head) AC: 292, Sta: 12, Spi: 30, MinLvl: 56',
        type = 'Mail',
        source = 'Drop:Plans: Helm of the Great Chief',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['enchantedthorium']] = 4,
            [ReagentData['gem']['hugeemerald']] = 2,
            [ReagentData['feather']['jetblack']] = 60,
            [ReagentData['bar']['thorium']] = 40,
            [ReagentData['gem']['largeopal']] = 6,
        }
    },
    ['Invulnerable Mail'] = {
        skill = 300,
        description = '[BoE] (Mail Chest) AC: 554, MinLvl: 57, Equip: Physical Attacks will be harmlessly deflected 5% of the time., Equip: Increased Defense +20.',
        type = 'Mail',
        source = 'Drop:Plans: Invulnerable Mail',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['bar']['enchantedthorium']] = 30,
            [ReagentData['gem']['hugeemerald']] = 6,
            [ReagentData['gem']['azerothiandiamond']] = 6,
            [ReagentData['bar']['arcanite']] = 30,
        }
    },
    ['Lionheart Helm'] = {
        skill = 300,
        description = '[BoE] (Plate Head) AC: 565, Str: 18, MinLvl: 56, Equip: Improves your chance to get a critical strike by 2%., Equip: Improves your chance to hit by 2%.',
        type = 'Plate',
        source = 'Drop:Plans: Lionheart Helm',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['wickedclaw']] = 40,
            [ReagentData['gem']['azerothiandiamond']] = 4,
            [ReagentData['bar']['thorium']] = 80,
            [ReagentData['gem']['bluesapphire']] = 10,
            [ReagentData['bar']['arcanite']] = 12,
        }
    },
    ['Masterwork Stormhammer'] = {
        skill = 300,
        description = '[BoE] (MH Mace) Dmg: 58-108, Spd: 2.00, DPS: 41.5, MinLvl: 57, Chance on hit: Blasts up to 3 targets for 105 to 145 Nature damage.',
        type = 'Mace',
        source = 'Drop:Plans: Masterwork Stormhammer',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['element']['essenceofearth']] = 6,
            [ReagentData['bar']['enchantedthorium']] = 20,
            [ReagentData['gem']['hugeemerald']] = 8,
            [ReagentData['gem']['largeopal']] = 8,
            [ReagentData['leather']['enchanted']] = 4,
        }
    },
    ['Radiant Leggings'] = {
        skill = 300,
        description = '[BoE] (Mail Legs) AC: 286, CR: 18, SR: 18, MinLvl: 56',
        type = 'Mail',
        source = 'Drop:Plans: Radiant Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['element']['heartoffire']] = 4,
        }
    },
    ['Runic Breastplate'] = {
        skill = 300,
        description = '[BoE] (Plate Chest) AC: 738, FR: 15, NR: 15, MinLvl: 57',
        type = 'Plate',
        source = 'Drop:Plans: Runic Breastplate',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 1,
            [ReagentData['bar']['thorium']] = 40,
            [ReagentData['bar']['arcanite']] = 2,
        }
    },
    ['Runic Plate Boots'] = {
        skill = 300,
        description = '[BoE] (Plate Feet) AC: 492, FR: 10, NR: 10, MinLvl: 55',
        type = 'Plate',
        source = 'Drop:Plans: Runic Plate Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['silver']] = 10,
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['bar']['arcanite']] = 2,
        }
    },
    ['Runic Plate Helm'] = {
        skill = 300,
        description = '[BoE] (Plate Head) AC: 621, FR: 13, NR: 13, MinLvl: 56',
        type = 'Plate',
        source = 'Drop:Plans: Runic Plate Helm',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['truesilver']] = 2,
            [ReagentData['gem']['hugeemerald']] = 1,
            [ReagentData['bar']['thorium']] = 30,
            [ReagentData['bar']['arcanite']] = 2,
        }
    },
    ['Runic Plate Leggings'] = {
        skill = 300,
        description = '[BoE] (Plate Legs) AC: 665, FR: 14, NR: 14, MinLvl: 57',
        type = 'Plate',
        source = 'Drop:Plans: Runic Plate Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 1,
            [ReagentData['bar']['thorium']] = 40,
            [ReagentData['bar']['arcanite']] = 2,
        }
    },
    ['Runic Plate Shoulders'] = {
        skill = 300,
        description = '[BoE] (Plate Shoulder) AC: 527, FR: 10, NR: 10, MinLvl: 55',
        type = 'Plate',
        source = 'Drop:Plans: Runic Plate Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['gold']] = 6,
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['bar']['arcanite']] = 2,
        }
    },
    ['Stronghold Gauntlets'] = {
        skill = 300,
        description = '[BoE] (Plate Hands) AC: 441, Sta: 12, MinLvl: 57, Equip: Immune to Disarm., Equip: Increases your chance to parry an attack by 1%., Equip: Improves your chance to get a critical strike by 1%.',
        type = 'Plate',
        source = 'Drop:Plans: Stronghold Gauntlets',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['element']['essenceofearth']] = 10,
            [ReagentData['bar']['enchantedthorium']] = 20,
            [ReagentData['gem']['bluesapphire']] = 4,
            [ReagentData['bar']['arcanite']] = 15,
            [ReagentData['gem']['largeopal']] = 4,
        }
    },
    ['Thorium Leggings'] = {
        skill = 300,
        description = '[BoE] (Plate Legs) AC: 499, AR: 10, FR: 10, NR: 10, CR: 10, SR: 10, MinLvl: 55',
        type = 'Plate',
        source = 'Drop:Plans: Thorium Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['other']['redpowercrystal']] = 4,
            [ReagentData['bar']['thorium']] = 26,
        }
    },
    ['Whitesoul Helm'] = {
        skill = 300,
        description = '[BoE] (Plate Head) AC: 629, Int: 15, Spi: 15, MinLvl: 55, Equip: Increases healing done by spells and effects by up to 32.',
        type = 'Plate',
        source = 'Drop:Plans: Whitesoul Helm',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['truesilver']] = 6,
            [ReagentData['bar']['enchantedthorium']] = 4,
            [ReagentData['bar']['gold']] = 6,
            [ReagentData['gem']['azerothiandiamond']] = 2,
            [ReagentData['bar']['thorium']] = 20,
        }
    },
--~     ['Bleakwood Hew'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['herb']['wildvine']] = 6,
--~             [ReagentData['leather']['rugged']] = 8,
--~             [ReagentData['element']['livingessence']] = 6,
--~             [ReagentData['bar']['thorium']] = 30,
--~             [ReagentData['grinding']['dense']] = 2,
--~             [ReagentData['gem']['largeopal']] = 6,
--~         }
--~     },
--~     ['Blood Talon'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['monster']['demonicrune']] = 8,
--~             [ReagentData['gem']['starruby']] = 10,
--~             [ReagentData['bar']['enchantedthorium']] = 10,
--~             [ReagentData['grinding']['dense']] = 2,
--~             [ReagentData['bar']['arcanite']] = 10,
--~         }
--~     },
--~     ['Darkspear'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['monster']['powerfulmojo']] = 20,
--~             [ReagentData['bar']['enchantedthorium']] = 20,
--~             [ReagentData['gem']['hugeemerald']] = 2,
--~             [ReagentData['gem']['azerothiandiamond']] = 2,
--~             [ReagentData['grinding']['dense']] = 2,
--~         }
--~     },
--~     ['Dawnbringer Shoulders'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['gem']['hugeemerald']] = 2,
--~             [ReagentData['element']['essenceofwater']] = 2,
--~             [ReagentData['bar']['thorium']] = 20,
--~             [ReagentData['bar']['arcanite']] = 4,
--~         }
--~     },
    ['Enchanted Thorium Breastplate'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Chest) AC: 657, Sta: 26, Str: 12, MinLvl: 58, Passive: Increased Defense +9.',
        source = 'Quest:Enchanted Thorium Platemail: Volume I',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['element']['essenceofearth']] = 4,
            [ReagentData['bar']['enchantedthorium']] = 24,
            [ReagentData['bar']['arcanite']] = 8,
            [ReagentData['element']['essenceofwater']] = 4,
            [ReagentData['gem']['hugeemerald']] = 2,
            [ReagentData['gem']['azerothiandiamond']] = 2,
        }
    },
    ['Enchanted Thorium Helm'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Head) AC: 526, Sta: 25, Str: 12, MinLvl: 57, Passive: Increased Defense +9.',
        source = 'Quest:Enchanted Thorium Platemail: Volume III',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['arcanite']] = 6,
            [ReagentData['element']['essenceofearth']] = 6,
            [ReagentData['bar']['enchantedthorium']] = 16,
            [ReagentData['gem']['largeopal']] = 2,
            [ReagentData['gem']['azerothiandiamond']] = 1,
        }
    },
    ['Imperial Plate Belt'] = {
    skill = 265,
        type = 'Plate',
        source = 'Quest:Plans: Imperial Plate Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['thorium']] = 22,
            [ReagentData['leather']['rugged']] = 6,
            [ReagentData['gem']['aquamarine']] = 1,
        }
    },
    ['Imperial Plate Boots'] = {
        skill = 295,
        type = 'Plate',
        description = '[BoE] (Plate Feet) AC: 386, Sta: 12, Str: 13, MinLvl: 54',
        source = 'Quest:Imperial Plate Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['thorium']] = 34,
            [ReagentData['gem']['aquamarine']] = 1,
            [ReagentData['gem']['starruby']] = 1,
        }
    },
    ['Imperial Plate Bracers'] = {
        skill = 270,
        type = 'Plate',
        description = '[BoE] (Plate Wrist) AC: 225, Sta: 8, Str: 9, MinLvl: 49',
        source = 'Quest:Plans: Imperial Plate Bracers',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 1,
            [ReagentData['bar']['thorium']] = 20,
        }
    },
    ['Imperial Plate Chest'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Chest) AC: 570, Sta: 17, Str: 18, MinLvl: 55',
        source = 'Quest:Plans: Imperial Plate Chest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['thorium']] = 40,
            [ReagentData['gem']['starruby']] = 2,
        }
    },
    ['Imperial Plate Helm'] = {
        skill = 295,
        type = 'Plate',
        description = '[BoE] (Plate Head) AC: 456, Sta: 17, Str: 18, MinLvl: 54',
        source = 'Quest:Plans: Imperial Plate Helm',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 2,
            [ReagentData['bar']['thorium']] = 34,
        }
    },
    ['Imperial Plate Leggings'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Leggings) AC: 507, Sta: 18, Str: 18, MinLvl: 56',
        source = 'Quest:Plans: Imperial Plate Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 2,
            [ReagentData['bar']['thorium']] = 44,
        }
    },
    ['Imperial Plate Shoulders'] = {
        skill = 265,
        type = 'Plate',
        description = '[BoE] (Plate Shoulders) AC: 380, Sta: 11, Str: 12, MinLvl: 47',
        source = 'Quest:Plans: Imperial Plate Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['rugged']] = 6,
            [ReagentData['bar']['thorium']] = 24,
            [ReagentData['gem']['citrine']] = 2,
        }
    },
--~     ['Inlaid Thorium Hammer'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['bar']['truesilver']] = 2,
--~             [ReagentData['leather']['rugged']] = 4,
--~             [ReagentData['bar']['gold']] = 4,
--~             [ReagentData['bar']['thorium']] = 30,
--~             [ReagentData['gem']['bluesapphire']] = 2,
--~         }
--~     },
--~     ['Ironforge Chain'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['gem']['malachite']] = 2,
--~             [ReagentData['grinding']['rough']] = 2,
--~             [ReagentData['bar']['copper']] = 12,
--~         }
--~     },
--~     ['Ironforge Gauntlets'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['bar']['bronze']] = 8,
--~             [ReagentData['gem']['shadow']] = 3,
--~             [ReagentData['grinding']['coarse']] = 4,
--~         }
--~     },
--~     ['Mithril Scale Gloves'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['leather']['heavy']] = 6,
--~             [ReagentData['bar']['mithril']] = 8,
--~             [ReagentData['cloth']['mageweave']] = 4,
--~         }
--~     },
    ['Ornate Mithril Shoulders'] = {
        skill = 225,
        type = 'Plate',
        source = 'Quest:Plans: Ornate Mithril Shoulder',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Ornate Mithril Shoulder',
        resultrarity = 'Uncommon',
        reagents = {
          [ReagentData['leather']['thick']] = 6,
          [ReagentData['bar']['truesilver']] = 1,
          [ReagentData['bar']['mithril']] = 12,
        }
    },
--~     ['Rough Bronze Bracers'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['bar']['bronze']] = 4,
--~         }
--~     },
--~     ['Rune Edge'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['leather']['rugged']] = 4,
--~             [ReagentData['bar']['thorium']] = 30,
--~             [ReagentData['grinding']['dense']] = 2,
--~             [ReagentData['gem']['largeopal']] = 2,
--~         }
--~     },
    ['Sulfuron Hammer'] = {
        skill = 300,
        description = '(2H Mace) Dmg: 176-295, Spd: 3.70, DPS: 63.6, MinLvl: 60, Chance On Hit: Hurls a fiery ball that causes 83 to 101 Fire damage and an additional 16 damage over 8 seconds.',
        source = 'Quest:A Binding Contract',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['bar']['darkiron']] = 20,
            [ReagentData['gem']['bloodofthemountain']] = 10,
            [ReagentData['monster']['fierycore']] = 10,
            [ReagentData['monster']['sulfuroningot']] = 8,
            [ReagentData['element']['essenceoffire']] = 25,
            [ReagentData['monster']['lavacore']] = 10,
            [ReagentData['bar']['arcanite']] = 50,
        }
    },
--~     ['Thorium Greatsword'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['leather']['rugged']] = 4,
--~             [ReagentData['bar']['thorium']] = 16,
--~             [ReagentData['grinding']['dense']] = 2,
--~         }
--~     },
    ['Dark Iron Gauntlets'] = {
        skill = 295,
        description = '[BoE] (Plate Hands) AC: 495, Sta: 16, Agi: 12, FR: 28, MinLvl: 60',
        type = 'Plate',
        source = 'Vendor:Plans: Dark Iron Gauntlets',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['lavacore']] = 3,
            [ReagentData['monster']['fierycore']] = 5,
            [ReagentData['leather']['core']] = 4,
            [ReagentData['bar']['darkiron']] = 4,
            [ReagentData['gem']['bloodofthemountain']] = 2,
        },
    },
    ['Dark Iron Helm'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Head) AC: 758, Sta: 20, FR: 35, MinLvl: 60',
        source = 'Vendor:Plans: Dark Iron Gauntlets',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['lavacore']] = 4,
            [ReagentData['monster']['fierycore']] = 2,
            [ReagentData['bar']['darkiron']] = 4,
        },
    },
    ['Blackguard'] = {
        skill = 300,
        type = 'Sword',
        description = '[BoE] (OH Sword) Dmg: 65-121, Spd: 1.80, DPS: 51.7, Sta: 9, MinLvl: 60, Passive: Increases your chance to parry an attack by 1%.',
        source = 'Vendor:Plans: Blackguard',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['lavacore']] = 6,
            [ReagentData['monster']['fierycore']] = 6,
            [ReagentData['bar']['arcanite']] = 10,
            [ReagentData['bar']['darkiron']] = 6,
            [ReagentData['monster']['guardianstone']] = 12,
        },
    },
    ['Gloves of the Dawn'] = {
        skill = 300,
        description = '[BoE] (Plate Hands) AC: 417, Str: 23, Sta: 10, MinLvl: 59',
        type = 'Plate',
        source = 'Vendor:Plans: Gloves of the Dawn',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['bar']['arcanite']] = 2,
            [ReagentData['bar']['truesilver']] = 10,
            [ReagentData['monster']['righteousorb']] = 1,
        },
    },
    ['Enchanted Thorium Leggings'] = {
        skill = 300,
        description = '[BoE] (Plate Legs) AC: 575, Str: 20, Sta: 21, MinLvl: 58, Passive: Increased Defense +8',
        type = 'Plate',
        source = 'Quest:Enchanted Thorium Platemail: Volume II',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['arcanite']] = 10,
            [ReagentData['bar']['enchantedthorium']] = 20,
            [ReagentData['element']['essenceofwater']] = 6,
            [ReagentData['gem']['bluesapphire']] = 2,
            [ReagentData['gem']['hugeemerald']] = 1,
        },
    },
    ['Girdle of the Dawn'] = {
        skill = 290,
        description = '[BoE] (Plate Waist) AC: 341, Str: 21, Sta: 9, MinLvl: 53',
        type = 'Plate',
        source = 'Vendor:Plans: Girdle of the Dawn',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['thorium']] = 8,
            [ReagentData['bar']['truesilver']] = 6,
            [ReagentData['monster']['righteousorb']] = 1,
        },
    },
    ['Heavy Timbermaw Boots'] = {
        skill = 300,
        type = 'Mail',
        description = '[BoE] (Mail Feet) AC: 258, Sta: 23, MinLvl: 59, Passive: +20 Attack Power.',
        source = 'Vendor:Plans: Heavy Timbermaw Boots',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['arcanite']] = 4,
            [ReagentData['element']['essenceofearth']] = 6,
            [ReagentData['element']['livingessence']] = 6,
        },
    },
    ['Ebon Hand'] = {
        skill = 300,
        type = 'Mace',
        description = '[BoE] (OH Mace) Dmg: 90-168, Spd: 2.50, DPS: 51.6, Sta: 9, FR: 7, MinLvl: 60, Chance On Hit: Sends a shadowy bolt at the enemy causing 125 to 275 Shadow damage.',
        source = 'Vendor:Plans: Ebon Hand',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['lavacore']] = 4,
            [ReagentData['monster']['fierycore']] = 7,
            [ReagentData['bar']['arcanite']] = 12,
            [ReagentData['bar']['darkiron']] = 8,
            [ReagentData['gem']['azerothiandiamond']] = 4,
        },
    },
    ['Nightfall'] = {
        skill = 300,
        type = 'Two-Hand Axe',
        description = '[BoE] (2H Mace) Dmg: 187-282, Spd: 3.30, DPS: 67.0, MinLvl: 60, Chance On Hit: Spell damage taken by target increased by 15% for 5 seconds.',
        source = 'Vendor:Plans: Nightfall',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['lavacore']] = 8,
            [ReagentData['monster']['fierycore']] = 5,
            [ReagentData['bar']['arcanite']] = 10,
            [ReagentData['bar']['darkiron']] = 12,
            [ReagentData['gem']['hugeemerald']] = 4,
        },
    },
    ['Blackfury'] = {
        skill = 300,
        type = 'Polearm',
        description = '[BoE] (Polearm) Dmg: 105-158, Spd: 2.10, DPS: 62.6, Str: 35, Sta: 15, FR: 10, MinLvl: 60, Passive: Improves your chance to get a critical strike by 1%.',
        source = 'Vendor:Plans: Blackfury',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['lavacore']] = 5,
            [ReagentData['monster']['fierycore']] = 2,
            [ReagentData['bar']['arcanite']] = 16,
            [ReagentData['bar']['darkiron']] = 6,
        },
    },
    ['Black Amnesty'] = {
        skill = 300,
        type = 'Dagger',
        description = '[BoE] (OH Dagger) Dmg: 53-100, Spd: 1.60, DPS: 47.8, MinLvl: 60, Chance On Hit: Reduce your threat to the current target making them less likely to attack you.',
        source = 'Vendor:Plans: Black Amnesty',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['lavacore']] = 3,
            [ReagentData['monster']['fierycore']] = 6,
            [ReagentData['bar']['arcanite']] = 12,
            [ReagentData['gem']['bloodofthemountain']] = 1,
            [ReagentData['bar']['darkiron']] = 4,
     },
    },
    ['Bloodsoul Breastplate'] = {
        skill = 300,
        type = 'Mail',
        description = '[BoE] (Mail Chest) AC: 381, Sta: 13, Agi: 9, MinLvl: 60, Passive: Improves your chance to get a critical strike by 2%.',
        source = 'Vendor:Plans: Bloodsoul Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['gem']['souldarite']] = 10,
            [ReagentData['herb']['bloodvine']] = 2,
            [ReagentData['gem']['starruby']] = 2,
        },
    },
    ['Bloodsoul Shoulders'] = {
        skill = 300,
        type = 'Mail',
        description = '[BoE] (Mail Shoulder) AC: 286, Sta: 10, Agi: 24, MinLvl: 60',
        source = 'Vendor:Plans: Bloodsoul Shoulders',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['thorium']] = 16,
            [ReagentData['gem']['souldarite']] = 8,
            [ReagentData['herb']['bloodvine']] = 2,
            [ReagentData['gem']['starruby']] = 1,
        },
    },
    ['Bloodsoul Gauntlets'] = {
        skill = 300,
        type = 'Mail',
        description = '[BoE] (Mail Hands) AC: 238, Sta: 17, Agi: 10, MinLvl: 60, Passive: Improves your chance to get a critical strike by 1%.',
        source = 'Vendor:Plans: Bloodsoul Gauntlets',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['thorium']] = 12,
            [ReagentData['gem']['souldarite']] = 6,
            [ReagentData['herb']['bloodvine']] = 2,
            [ReagentData['leather']['enchanted']] = 4,
        },
    },
    ['Darksoul Breastplate'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Chest) AC: 736, Sta: 32, MinLvl: 60, Passive: Improves your chance to hit by 1%.',
        source = 'Vendor:Plans: Darksoul Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['gem']['souldarite']] = 14,
            [ReagentData['gem']['largeopal']] = 2,
        },
    },
    ['Darksoul Leggings'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Legs) AC: 722, Sta: 22, MinLvl: 60, Passive: Improves your chance to hit by 2%.',
        source = 'Vendor:Plans: Darksoul Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['thorium']] = 18,
            [ReagentData['gem']['souldarite']] = 12,
            [ReagentData['gem']['largeopal']] = 2,
        },
    },
    ['Darksoul Shoulders'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Shoulders) AC: 507, Sta: 24, MinLvl: 60, Passive: Improves your chance to hit by 1%.',
        source = 'Vendor:Plans: Darksoul Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['thorium']] = 16,
            [ReagentData['gem']['souldarite']] = 10,
            [ReagentData['gem']['largeopal']] = 1,
        },
    },
    ['Darkrune Gauntlets'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Hands) AC: 410, SR: 20, Sta: 8, MinLvl: 58, Passive: Increases your change to block attacks with a shield by 2%',
        source = 'Quest:Plans: Darkrune Gauntlets',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['thorium']] = 12,
            [ReagentData['monster']['darkrune']] = 6,
            [ReagentData['bar']['truesilver']] = 6,
            [ReagentData['leather']['enchanted']] = 2,
        },
    },
    ['Darkrune Helm'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Head) AC: 534, SR: 25, Sta: 13, MinLvl: 58, Passive: Improves your chance to get a critical strike by 1%.',
        source = 'Quest:Plans: Darkrune Helm',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['thorium']] = 16,
            [ReagentData['monster']['darkrune']] = 8,
            [ReagentData['bar']['truesilver']] = 8,
            [ReagentData['gem']['blackdiamond']] = 1,
        },
    },
    ['Darkrune Breastplate'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Chest) AC: 657, Sta: 14, SR: 25, MinLvl: 58, Passive: Increases your change to dodge an attack by 1%',
        source = 'Quest:Plans: Darkrune Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['monster']['darkrune']] = 10,
            [ReagentData['bar']['truesilver']] = 10,
        },
    },
    ['Black Grasp of the Destroyer'] = {
        skill = 300,
        type = 'Mail',
        description = '[BoE] (Mail Hands) AC: 279, MinLvl: 60, Equip: +28 Attack Power., Equip: Improves your chance to get a critical strike by 1%., Equip: On successful melee or ranged attack gain 8 mana and if possible drain 8 mana from the target.',
        source = 'Drop:Plans: Black Grasp of the Destroyer',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['ore']['largeobsidianshard']] = 8,
            [ReagentData['ore']['smallobsidianshard']] = 24,
            [ReagentData['leather']['enchanted']] = 8,
            [ReagentData['potion']['flaskofsupremepower']] = 1,
        },
    },
    ['Heavy Obsidian Belt'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Waist) AC: 397, Str: 25, MinLvl: 60, Equip: +5 All Resists.',
        source = 'Vendor:Plans: Heavy Obsidian Belt',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['ore']['smallobsidianshard']] = 14,
            [ReagentData['bar']['enchantedthorium']] = 4,
            [ReagentData['element']['essenceofearth']] = 1,
        },
    },
    ['Light Obsidian Belt'] = {
        skill = 300,
        type = 'Mail',
        description = '[BoE] (Mail Waist) AC: 224, MinLvl: 60, Equip: +32 Attack Power., Equip: Improves your chance to get a critical strike by 1%., Equip: +5 All Resists.',
        source = 'Vendor:Plans: Light Obsidian Belt',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['ore']['smallobsidianshard']] = 14,
            [ReagentData['leather']['enchanted']] = 4,
        },
    },
    ['Jagged Obsidian Shield'] = {
        skill = 300,
        type = 'Shield',
        description = '[BoE] (OH Shield) AC: 2645, Blk: 48, Str: 25, MinLvl: 60, Equip: Increases your chance to block attacks with a shield by 2%., Equip: +5 All Resistances., Equip: When struck by a harmful spell, the caster of that spell has a 5% chance to be silenced for 3 seconds.',
        source = 'Vendor:Plans: Heavy Obsidian Belt',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
          [ReagentData['ore']['largeobsidianshard']] = 8,
          [ReagentData['ore']['smallobsidianshard']] = 24,
          [ReagentData['bar']['enchantedthorium']] = 8,
          [ReagentData['element']['essenceofearth']] = 4,
        },
    },
    ['Obsidian Mail Tunic'] = {
        skill = 300,
        type = 'Shield',
        description = '[BoE] (Mail Chest) AC: 458, MinLvl: 60, Equip: +76 Attack Power., Equip: Improves your chance to get a critical strike by 1%., Equip: Spell Damage received is reduced by 10.',
        source = 'Vendor:Plans: Obsidian Mail Tunic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['ore']['largeobsidianshard']] = 15,
            [ReagentData['ore']['smallobsidianshard']] = 36,
            [ReagentData['leather']['enchanted']] = 12,
            [ReagentData['monster']['guardianstone']] = 10,
            [ReagentData['gem']['azerothiandiamond']] = 4,
        },
    },
    ['Thich Obsidian Breastplate'] = {
        skill = 300,
        type = 'Shield',
        description = '[BoE] (Plate Chest) AC: 814, Str: 38, Sta: 16, MinLvl: 60, Equip: When struck by a damage spell you have a 30% chance of getting a 6 seconds spell shield that absorbs 300 to 500 of that school of damage.',
        source = 'Drop:Plans: Thick Obsidian Breastplate',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['ore']['largeobsidianshard']] = 18,
            [ReagentData['ore']['smallobsidianshard']] = 40,
            [ReagentData['bar']['enchantedthorium']] = 12,
            [ReagentData['element']['essenceofearth']] = 10,
            [ReagentData['gem']['hugeemerald']] = 4,
        },
    },
    ['Sageblade'] = {
        skill = 300,
        type = 'Sword',
        description = '[BoE] (MH Sword) Dmg: 49-100, Spd: 1.8, DPS: 41.4, Sta: 14, Ind: 6, MinLvl: 59, Equip: Increases damage and healing done by magical spells and effects by up to 20., Equip: Decreases the magical resistances of your spell targets by 10.',
        source = 'Drop:Plans: Sageblade',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['bar']['arcanite']] = 12,
            [ReagentData['shard']['nexuscrystal']] = 2,
            [ReagentData['potion']['flaskofsupremepower']] = 2,
            [ReagentData['leather']['enchanted']] = 4,
        },
    },
    ['Persuader'] = {
        skill = 300,
        type = 'Mace',
        description = '[BoE] (MH Mace) Dmg: 86-161, Spd: 2.7, DPS: 45.7, MinLvl: 58, Equip: Improves your chance to hit by 1%., Equip: Improves your chance to get a critical strike by 1%.',
        source = 'Drop:Plans: Persuader',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['bar']['arcanite']] = 12,
            [ReagentData['bar']['darkiron']] = 10,
            [ReagentData['element']['essenceofundeath']] = 20,
            [ReagentData['monster']['darkrune']] = 20,
            [ReagentData['leather']['devilsaur']] = 10,
            [ReagentData['monster']['skinofshadow']] = 2,
        },
    },
    ['Titanic Breastplate'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Chest) AC: 598, Str: 30, MinLvl: 55, Equip: Improves your chance to hit by 2%., Equip: Improves your chance to get a critical strike by 1%.',
        source = 'Drop:Plans: Titanic Breastplate',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['bar']['arcanite']] = 12,
            [ReagentData['bar']['thorium']] = 20,
            [ReagentData['element']['essenceofearth']] = 10,
            [ReagentData['potion']['flaskofthetitans']] = 2,
        },
    },
    ['Ironvine Belt'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Waist) AC: 408, Sta: 12, NR: 15, MinLvl: 60, Equip: Increased Defense +3.',
        source = 'Vendor:Plans: Ironvine Belt',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['enchantedthorium']] = 6,
            [ReagentData['element']['livingessence']] = 2,
        },
    },
    ['Ironvine Gloves'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Hands) AC: 454, Sta: 10, NR: 20, MinLvl: 60, Equip: Increased Defense +10.',
        source = 'Vendor:Plans: Ironvine Gloves',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
          [ReagentData['bar']['enchantedthorium']] = 6,
          [ReagentData['herb']['bloodvine']] = 1,
          [ReagentData['element']['livingessence']] = 2,
        },
    },
    ['Ironvine Breastplate'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Chest) AC: 726, Sta: 15, NR: 30, MinLvl: 60, Equip: Increased Defense +7.',
        source = 'Vendor:Plans: Ironvine Belt',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['enchantedthorium']] = 12,
            [ReagentData['bar']['arcanite']] = 2,
            [ReagentData['element']['livingessence']] = 2,
            [ReagentData['herb']['bloodvine']] = 2,
        },
    },
    ['Icebane Bracers'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Wrist) AC: 393, Str: 6, Sta: 13, CR: 24, MinLvl: 60, Equip: Increased Defense +5.',
        source = 'Vendor:Plans: Icebane Bracers',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
                [ReagentData['other']['frozenrune']] = 4,
                [ReagentData['bar']['thorium']] = 12,
                [ReagentData['bar']['arcanite']] = 2,
                [ReagentData['element']['essenceofwater']] = 2,
        },
    },
    ['Icebane Gauntlets'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Hands) AC: 562, Str: 9, Sta: 18, CR: 34, MinLvl: 60, Equip: Increased Defense +5.',
        source = 'Vendor:Plans: Icebane Gauntlets',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['other']['frozenrune']] = 5,
            [ReagentData['bar']['thorium']] = 12,
            [ReagentData['bar']['arcanite']] = 2,
            [ReagentData['element']['essenceofwater']] = 2,
        },
    },
    ['Icebane Breastplate'] = {
        skill = 300,
        type = 'Plate',
        description = '[BoE] (Plate Chest) AC: 899, Str: 12, Sta: 24, CR: 42, MinLvl: 60, Equip: Increased Defense +8.',
        source = 'Vendor:Plans: Icebane Breastplate',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['other']['frozenrune']] = 7,
            [ReagentData['bar']['thorium']] = 16,
            [ReagentData['bar']['arcanite']] = 2,
            [ReagentData['element']['essenceofwater']] = 4,
        },
    },
}
end