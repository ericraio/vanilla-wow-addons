function ReagentData_LoadLeatherworking()
ReagentData['crafted']['leatherworking'] = {
    ['Handstitched Leather Boots'] = {
        skill = 1,
        description = '(Leather Feet) AC: 31, MinLvl: 3',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 2,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Handstitched Leather Bracers'] = {
        skill = 1,
        description = '(Leather Wrist) AC: 21, MinLvl: 4',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 2,
            [ReagentData['thread']['coarse']] = 3,
        }
    },
    ['Handstitched Leather Cloak'] = {
        skill = 1,
        description = '(Back) AC: 8, MinLvl: 4',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 2,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Handstitched Leather Vest'] = {
        skill = 1,
        description = '(Leather Chest) AC: 45, MinLvl: 3',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 3,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Light Armor Kit'] = {
        skill = 1,
        description = 'Use: Permanently increase the armor value of an item worn on the chest, legs, hands or feet by 8.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 1,
        }
    },
    ['Light Leather'] = {
        skill = 1,
        description = 'Light Leather',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['ruinedscraps']] = 3,
        }
    },
    ['Handstitched Leather Pants'] = {
        skill = 15,
        description = '(Leather Legs) AC: 46, MinLvl: 5',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 4,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Handstitched Leather Belt'] = {
        skill = 25,
        description = '(Leather Waist) AC: 29, MinLvl: 5',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 6,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Light Leather Quiver'] = {
        skill = 30,
        description = '8 Slot Quiver, Equip: Increases ranged attack speed by 10%.',
        type = 'Quiver',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 4,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['Small Leather Ammo Pouch'] = {
        skill = 30,
        description = '8 Slot Ammo Pouch, Equip: Increases ranged attack speed by 10%.',
        type = 'Ammo Pouch',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 3,
            [ReagentData['thread']['coarse']] = 4,
        }
    },
    ['Cured Light Hide'] = {
        skill = 35,
        description = 'Cured Light Hide',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['salt']['salt']] = 1,
            [ReagentData['hide']['light']] = 1,
        }
    },
    ['Rugged Leather Pants'] = {
        skill = 35,
        description = '[BoE] (Leather Legs) AC: 51, Sta: 1, MinLvl: 6',
        type = 'Leather',
        source = 'Drop:Pattern: Rugged Leather Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 5,
            [ReagentData['thread']['coarse']] = 5,
        }
    },
    ['Embossed Leather Vest'] = {
        skill = 40,
        description = '[BoE] (Leather Chest) AC: 62, Sta: 2, MinLvl: 7',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 8,
            [ReagentData['thread']['coarse']] = 4,
        }
    },
    ['Kodo Hide Bag'] = {
        skill = 40,
        description = '6 Slot Container',
        type = 'Container',
        source = 'Quest:Pattern: Kodo Hide Bag',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 4,
            [ReagentData['leather']['thinkodo']] = 3,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Embossed Leather Boots'] = {
        skill = 55,
        description = '[BoE] (Leather Feet) AC: 48, Sta: 2, Spi: 2, MinLvl: 10',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 8,
            [ReagentData['thread']['coarse']] = 5,
        }
    },
    ['Embossed Leather Gloves'] = {
        skill = 55,
        description = '(Leather Hands) AC: 39, MinLvl: 8',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 3,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['Embossed Leather Cloak'] = {
        skill = 60,
        description = '(Back) AC: 12, MinLvl: 8',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 5,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['White Leather Jerkin'] = {
        skill = 60,
        description = '(Leather Chest) AC: 62, MinLvl: 8',
        type = 'Leather',
        source = 'Drop:Pattern: White Leather Jerkin',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 8,
            [ReagentData['dye']['bleach']] = 1,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['Embossed Leather Pants'] = {
        skill = 75,
        description = '[BoE] (Leather Legs) AC: 61, Sta: 2, Spi: 3, MinLvl: 10',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 6,
            [ReagentData['hide']['curedlight']] = 1,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['Fine Leather Gloves'] = {
        skill = 75,
        description = '[BoE] (Leather Hands) AC: 43, Int: 2, Spi: 2, MinLvl: 10',
        type = 'Leather',
        source = 'Drop:Pattern: Fine Leather Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 4,
            [ReagentData['hide']['curedlight']] = 1,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['Fine Leather Belt'] = {
        skill = 80,
        description = '(Leather Waist) AC: 38, MinLvl: 11',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 6,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['Fine Leather Cloak'] = {
        skill = 85,
        description = '[BoE] (Back) AC: 14, Sta: 2, MinLvl: 10',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 10,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Fine Leather Tunic'] = {
        skill = 85,
        description = '[BoE] (Leather Chest) AC: 73, Agi: 4, Sta: 3, MinLvl: 12',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 6,
            [ReagentData['hide']['curedlight']] = 3,
            [ReagentData['thread']['coarse']] = 4,
        }
    },
    ['Deviate Scale Cloak'] = {
        skill = 90,
        description = '[BoE] (Back) AC: 16, Agi: 2, Sta: 2, MinLvl: 13',
        type = 'Cloth',
        source = 'Vendor:Pattern: Deviate Scale Cloak',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['hide']['curedlight']] = 1,
            [ReagentData['scale']['deviate']] = 8,
        }
    },
    ['Fine Leather Boots'] = {
        skill = 90,
        description = '(Leather Feet) AC: 49, MinLvl: 13',
        type = 'Leather',
        source = 'Drop:Pattern: Fine Leather Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 7,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['Moonglow Vest'] = {
        skill = 90,
        description = '[BoE] (Leather Chest) AC: 74, Int: 3, Spi: 4, MinLvl: 13',
        type = 'Leather',
        source = 'Quest:Pattern: Moonglow Vest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 6,
            [ReagentData['hide']['curedlight']] = 1,
            [ReagentData['pearl']['smalllustrous']] = 1,
            [ReagentData['thread']['coarse']] = 4,
        }
    },
    ['Murloc Scale Belt'] = {
        skill = 90,
        description = '(Leather Waist) AC: 40, MinLvl: 13',
        type = 'Leather',
        source = 'Drop, Vendor:Pattern: Murloc Scale Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
         [ReagentData['monster']['slimymurlocscale']] = 8,
         [ReagentData['leather']['light']] = 6,
         [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Light Leather Bracers'] = {
        skill = 91,
        description = '(Leather Wrist) AC: 28, MinLvl: 9',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 6,
            [ReagentData['thread']['coarse']] = 4,
        }
    },
    ['Light Leather Pants'] = {
        skill = 95,
        description = '[BoE] (Leather Legs) AC: 66, Agi: 5, Spi: 3, MinLvl: 14',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 10,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['hide']['curedlight']] = 1,
        }
    },
    ['Murloc Scale Breastplate'] = {
        skill = 95,
        description = '[BoE] (Leather Chest) AC: 76, Str: 5, Agi: 3, MinLvl: 14',
        type = 'Leather',
        source = 'Drop, Vendor:Pattern: Murloc Scale Breastplate',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['monster']['slimymurlocscale']] = 12,
            [ReagentData['leather']['light']] = 8,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['hide']['curedlight']] = 1,
        }
    },
    ['Black Whelp Cloak'] = {
        skill = 100,
        description = '[BoE] (Back) AC: 17, Sta: 3, MinLvl: 15',
        type = 'Cloth',
        source = 'Vendor:Pattern: Black Whelp Cloak',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['scale']['blackwhelp']] = 12,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['leather']['medium']] = 4,
        }
    },
    ['Cured Medium Hide'] = {
        skill = 100,
        description = 'Cured Medium Hide',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['salt']['salt']] = 1,
            [ReagentData['hide']['medium']] = 1,
        }
    },
    ['Dark Leather Boots'] = {
        skill = 100,
        description = '(Leather Feet) AC: 51, MinLvl: 15',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['leather']['medium']] = 4,
        }
    },
    ['Dark Leather Tunic'] = {
        skill = 100,
        description = '[BoE] (Leather Chest) AC: 78, Agi: 6, MinLvl: 15',
        type = 'Leather',
        source = 'Drop:Pattern: Dark Leather Tunic',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['leather']['medium']] = 6,
        }
    },
    ['Hillman\'s Leather Vest'] = {
        skill = 100,
        description = '[BoE] (Leather Chest) AC: 78, Sta: 4, Spi: 4, MinLvl: 15',
        type = 'Leather',
        source = 'Drop:Pattern: Hillman\'s Leather Vest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['hide']['curedlight']] = 2,
            [ReagentData['armor']['fineleathertunic']] = 1,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['Medium Armor Kit'] = {
        skill = 100,
        description = 'MinLvl: 5, Use: Permanently increase the armor value of an item worn on the chest, legs, hands or feet by 16.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['medium']] = 4,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Medium Leather'] = {
        skill = 100,
        description = 'Medium Leather',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 4,
        }
    },
    ['Deviate Scale Gloves'] = {
        skill = 105,
        description = '[BoE] (Leather Hands) AC: 49, Agi: 3, Sta: 3, MinLvl: 16',
        type = 'Leather',
        source = 'Vendor:Pattern: Deviate Scale Gloves',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['scale']['deviate']] = 6,
            [ReagentData['scale']['perfectdeviate']] = 2,
        }
    },
    ['Fine Leather Pants'] = {
        skill = 105,
        description = '[BoE] (Leather Legs) AC: 69, Int: 5, Spi: 4, MinLvl: 16',
        type = 'Leather',
        source = 'Drop:Pattern: Fine Leather Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['leather']['medium']] = 8,
            [ReagentData['bolt']['wool']] = 1,
        }
    },
    ['Dark Leather Cloak'] = {
        skill = 110,
        description = '(Back) AC: 17, MinLvl: 17',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['leather']['medium']] = 8,
        }
    },
    ['Dark Leather Pants'] = {
        skill = 115,
        description = '[BoE] (Leather Legs) AC: 72, Agi: 8, MinLvl: 18',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['leather']['medium']] = 12,
        }
    },
    ['Deviate Scale Belt'] = {
        skill = 115,
        description = '[BoE] (Leather Waist) AC: 51, Agi: 5, Sta: 6, Spi: 3, MinLvl: 18',
        type = 'Leather',
        source = 'Quest:Pattern: Deviate Scale Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['scale']['deviate']] = 10,
            [ReagentData['scale']['perfectdeviate']] = 10,
        }
    },
    ['Dark Leather Gloves'] = {
        skill = 120,
        description = '[BoE] (Leather Hands) AC: 54, MinLvl: 21, Equip: Increases your lockpicking skill slightly.',
        type = 'Leather',
        source = 'Drop:Pattern: Dark Leather Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['armor']['fineleathergloves']] = 1,
            [ReagentData['hide']['curedmedium']] = 1,
        }
    },
    ['Hillman\'s Belt'] = {
        skill = 120,
        description = '[BoE] (Leather Waist) AC: 48, Sta: 4, Spi: 4, MinLvl: 20',
        type = 'Leather',
        source = 'Drop:Pattern: Hillman\'s Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['potion']['elixirofwisdom']] = 1,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['leather']['medium']] = 8,
        }
    },
    ['Nimble Leather Gloves'] = {
        skill = 120,
        description = '[BoE] (Leather Hands) AC: 52, Agi: 4, Spi: 4, MinLvl: 19',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['potion']['elixirofminoragility']] = 1,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['leather']['medium']] = 6,
        }
    },
    ['Red Whelp Gloves'] = {
        skill = 120,
        description = '[BoE] (Leather Hands) AC: 52, MinLvl: 19, Equip: 5% chance of dealing 15 to 25 Fire damage on a successful melee attack.',
        type = 'Leather',
        source = 'Vendor:Pattern: Red Whelp Gloves',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['scale']['redwhelp']] = 6,
            [ReagentData['leather']['medium']] = 4,
        }
    },
    ['Toughened Leather Armor'] = {
        skill = 120,
        description = '(Leather Chest) AC: 80, MinLvl: 19',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['leather']['medium']] = 10,
            [ReagentData['hide']['curedlight']] = 2,
        }
    },
    ['Dark Leather Belt'] = {
        skill = 125,
        description = '[BoE] (Leather Waist) AC: 48, Agi: 4, Sta: 4, MinLvl: 20',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['armor']['fineleatherbelt']] = 1,
            [ReagentData['hide']['curedmedium']] = 1,
        }
    },
    ['Fletcher\'s Gloves'] = {
        skill = 125,
        description = '[BoE] (Leather Hands) AC: 53, MinLvl: 20, Equip: Improves your chance to get a critical strike with missile weapons by 1%., Equip: Decreases your chance to parry an attack by 1%.',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['feather']['longtail']] = 4,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['leather']['medium']] = 8,
        }
    },
    ['Hillman\'s Shoulders'] = {
        skill = 130,
        description = '[BoE] (Leather Shoulder) AC: 65, Sta: 5, Spi: 4, MinLvl: 21',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['leather']['medium']] = 4,
            [ReagentData['hide']['curedmedium']] = 1,
        }
    },
    ['Earthen Leather Shoulders'] = {
        skill = 135,
        description = '[BoE] (Leather Shoulder) AC: 67, Sta: 7, MinLvl: 22',
        type = 'Leather',
        source = 'Vendor:Pattern: Earthen Leather Shoulders',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['earth']] = 1,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['leather']['medium']] = 6,
        }
    },
    ['Herbalist\'s Gloves'] = {
        skill = 135,
        description = '[BoE] (Leather Hands) AC: 55, MinLvl: 22, Equip: Herbalism +5.',
        type = 'Leather',
        source = 'Vendor:Pattern: Herbalist\'s Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['herb']['kingsblood']] = 4,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['leather']['medium']] = 8,
        }
    },
    ['Toughened Leather Gloves'] = {
        skill = 135,
        description = '[BoE] (Leather Hands) AC: 61, Agi: 6, Sta: 3, Spi: 6, MinLvl: 22',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['potion']['elixirofdefense']] = 2,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['leather']['medium']] = 4,
            [ReagentData['spidersilk']['silk']] = 2,
            [ReagentData['hide']['curedmedium']] = 2,
        }
    },
    ['Dark Leather Shoulders'] = {
        skill = 140,
        description = '[BoE] (Leather Shoulder) AC: 68, Agi: 7, MinLvl: 23',
        type = 'Leather',
        source = 'Drop:Pattern: Dark Leather Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['leather']['medium']] = 12,
            [ReagentData['potion']['elixiroflesseragility']] = 1,
        }
    },
    ['Pilferer\'s Gloves'] = {
        skill = 140,
        description = '[BoE] (Leather Hands) AC: 56, Agi: 8, MinLvl: 23',
        type = 'Leather',
        source = 'Drop:Pattern: Pilferer\'s Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['monster']['luckycharm']] = 2,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['leather']['medium']] = 10,
        }
    },
    ['Heavy Earthen Gloves'] = {
        skill = 145,
        description = '[BoE] (Leather Hands) AC: 57, MinLvl: 24, Equip: +16 Attack Power.',
        type = 'Leather',
        source = 'Drop:Pattern: Heavy Earthen Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['earth']] = 2,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['leather']['medium']] = 12,
            [ReagentData['bolt']['wool']] = 2,
        }
    },
    ['Hillman\'s Leather Gloves'] = {
        skill = 145,
        description = '[BoE] (Leather Hands) AC: 57, Sta: 6, Spi: 5, MinLvl: 24',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['fine']] = 4,
            [ReagentData['leather']['medium']] = 14,
        }
    },
    ['Barbaric Gloves'] = {
        skill = 150,
        description = '[BoE] (Leather Hands) AC: 58, Agi: 4, Sta: 5, Spi: 4, MinLvl: 25',
        type = 'Leather',
        source = 'Drop:Pattern: Barbaric Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 6,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['monster']['largefang']] = 2,
        }
    },
    ['Cured Heavy Hide'] = {
        skill = 150,
        description = 'Cured Heavy Hide',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['salt']['salt']] = 3,
            [ReagentData['hide']['heavy']] = 1,
        }
    },
    ['Heavy Armor Kit'] = {
        skill = 150,
        description = 'MinLvl: 20, Use: Permanently increase the armor value of an item worn on the chest, legs, hands or feet by 24.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['heavy']] = 5,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Heavy Leather'] = {
        skill = 150,
        description = 'Heavy Leather',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['medium']] = 5,
        }
    },
    ['Heavy Leather Ammo Pouch'] = {
        skill = 150,
        description = 'MinLvl: 30, 14 Slot Ammo Pouch, Equip: Increases ranged attack speed by 12%.',
        type = 'Ammo Pouch',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 8,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Heavy Leather Ball'] = {
     skill = 150,
     description = 'Use: Throw the ball to a friendly player. If they have free room in their pack they will catch it!',
     source = 'Vendor:Pattern: Heavy Leather Ball',
     result = 1,
     reagents = {
          [ReagentData['leather']['heavy']] = 2,
          [ReagentData['thread']['fine']] = 1,
     },
    },
    ['Heavy Quiver'] = {
        skill = 150,
        description = 'MinLvl: 30, 14 Slot Quiver, Equip: Increases ranged attack speed by 12%.',
        type = 'Quiver',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 8,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Hillman\'s Cloak'] = {
        skill = 150,
        description = '(Back) AC: 20, MinLvl: 25',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['heavy']] = 5,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Green Leather Armor'] = {
        skill = 155,
        description = '[BoE] (Leather Chest) AC: 95, Agi: 8, Spi: 8, MinLvl: 26',
        type = 'Leather',
        source = 'Vendor:Pattern: Green Leather Armor',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 9,
            [ReagentData['thread']['fine']] = 4,
            [ReagentData['dye']['green']] = 2,
        }
    },
    ['Green Leather Belt'] = {
        skill = 160,
        description = '[BoE] (Leather Waist) AC: 54, Agi: 6, Spi: 6, MinLvl: 27',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 5,
            [ReagentData['hide']['curedheavy']] = 1,
            [ReagentData['armor']['ironbuckle']] = 1,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Guardian Pants'] = {
        skill = 160,
        description = '[BoE] (Leather Legs) AC: 85, Int: 8, Spi: 8, MinLvl: 27',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 12,
            [ReagentData['bolt']['silk']] = 2,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Dusky Leather Leggings'] = {
        skill = 165,
        description = '[BoE] (Leather Legs) AC: 86, Agi: 13, MinLvl: 28',
        type = 'Leather',
        source = 'Drop:Pattern: Dusky Leather Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 10,
            [ReagentData['dye']['black']] = 1,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Raptor Hide Belt'] = {
        skill = 165,
        description = '[BoE] (Leather Waist) AC: 55, Str: 6, Sta: 6, MinLvl: 28',
        type = 'Leather',
        source = 'Vendor:Pattern: Raptor Hide Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['hide']['raptor']] = 4,
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Raptor Hide Harness'] = {
        skill = 165,
        description = '[BoE] (Leather Chest) AC: 98, Sta: 13, MinLvl: 28',
        type = 'Leather',
        source = 'Vendor:Pattern: Raptor Hide Harness',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['hide']['raptor']] = 6,
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Barbaric Leggings'] = {
        skill = 170,
        description = '[BoE] (Leather Legs) AC: 87, Agi: 7, Sta: 7, Spi: 7, MinLvl: 29',
        type = 'Leather',
        source = 'Vendor:Pattern: Barbaric Leggings',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 10,
            [ReagentData['gem']['mossagate']] = 1,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Guardian Belt'] = {
        skill = 170,
        description = '[BoE] (Leather Waist) AC: 56, Int: 7, Spi: 6, MinLvl: 29',
        type = 'Leather',
        source = 'Drop:Pattern: Guardian Belt',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['hide']['curedheavy']] = 2,
            [ReagentData['armor']['ironbuckle']] = 1,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Thick Murloc Armor'] = {
        skill = 170,
        description = '[BoE] (Leather Chest) AC: 100, Str: 9, Sta: 8, MinLvl: 29',
        type = 'Leather',
        source = 'Drop, Vendor:Pattern: Thick Murloc Armor',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 10,
            [ReagentData['hide']['curedheavy']] = 1,
            [ReagentData['monster']['thickmurlocscale']] = 12,
            [ReagentData['thread']['fine']] = 3,
        }
    },
    ['Barbaric Shoulders'] = {
        skill = 175,
        description = '[BoE] (Leather Shoulder) AC: 76, Agi: 5, Sta: 6, Spi: 5, MinLvl: 30',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 8,
            [ReagentData['hide']['curedheavy']] = 1,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Dusky Leather Armor'] = {
        skill = 175,
        description = '[BoE] (Leather Chest) AC: 102, Agi: 14, MinLvl: 30',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 10,
            [ReagentData['oil']['shadow']] = 1,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Green Whelp Armor'] = {
        skill = 175,
        description = '[BoE] (Leather Chest) AC: 102, Spi: 11, MinLvl: 30, Equip: When struck by a melee attacker, that attacker has a 5% chance of being put to sleep for 30 sec.',
        type = 'Leather',
        source = 'Drop:Pattern: Green Whelp Armor',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 10,
            [ReagentData['scale']['greenwhelp']] = 4,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Guardian Armor'] = {
        skill = 175,
        description = '[BoE] (Leather Chest) AC: 102, Int: 10, Spi: 9, MinLvl: 30',
        type = 'Leather',
        source = 'Drop:Pattern: Guardian Armor',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 12,
            [ReagentData['hide']['curedheavy']] = 2,
            [ReagentData['oil']['shadow']] = 1,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Frost Leather Cloak'] = {
        skill = 180,
        description = '[BoE] (Back) AC: 24, MinLvl: 31, Equip: Increases damage done by Frost spells and effects by up to 8.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 6,
            [ReagentData['element']['earth']] = 2,
            [ReagentData['element']['water']] = 2,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Green Leather Bracers'] = {
        skill = 180,
        description = '[BoE] (Leather Wrist) AC: 45, Agi: 6, Spi: 5, MinLvl: 31',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 6,
            [ReagentData['hide']['curedheavy']] = 2,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Dusky Bracers'] = {
        skill = 185,
        description = '[BoE] (Leather Wrist) AC: 46, Agi: 8, MinLvl: 32',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 16,
            [ReagentData['dye']['black']] = 1,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Gem-studded Leather Belt'] = {
        skill = 185,
        description = '[BoE] (Leather Waist) AC: 65, Sta: 8, Spi: 6, MinLvl: 32, Use: Heal yourself for 225 to 375.',
        type = 'Leather',
        source = 'Vendor:Pattern: Gem-studded Leather Belt',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['pearl']['iridescent']] = 2,
            [ReagentData['gem']['citrine']] = 1,
            [ReagentData['hide']['curedheavy']] = 4,
            [ReagentData['gem']['jade']] = 2,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Guardian Cloak'] = {
        skill = 185,
        description = '[BoE] (Back) AC: 24, Int: 5, Spi: 6, MinLvl: 32',
        type = 'Cloth',
        source = 'Drop:Pattern: Guardian Cloak',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 14,
            [ReagentData['bolt']['silk']] = 2,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Barbaric Harness'] = {
        skill = 190,
        description = '(Leather Chest) AC: 101, MinLvl: 33',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['heavy']] = 14,
            [ReagentData['armor']['ironbuckle']] = 1,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Gloves of the Greatfather'] = {
        skill = 190,
        description = '[BoE] (Leather Hands) AC: 66, MinLvl: 33, Equip: Increases healing done by spells and effects by up to 16., Equip: Increases damage done by Nature spells and effects by up to 7.',
        type = 'Leather',
        source = 'Drop:Pattern: Gloves of the Greatfather',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 8,
            [ReagentData['element']['earth']] = 4,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Green Whelp Bracers'] = {
        skill = 190,
        description = '[BoE] (Leather Wrist) AC: 47, Spi: 8, MinLvl: 33',
        type = 'Leather',
        source = 'Vendor:Pattern: Green Whelp Bracers',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 8,
            [ReagentData['scale']['greenwhelp']] = 6,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Guardian Gloves'] = {
        skill = 190,
        description = '(Leather Hands) AC: 63, MinLvl: 33',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['hide']['curedheavy']] = 1,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Murloc Scale Bracers'] = {
        skill = 190,
        description = '[BoE] (Leather Wrist) AC: 47, Str: 5, Sta: 6, MinLvl: 33',
        type = 'Leather',
        source = 'Drop, Vendor:Pattern: Murloc Scale Bracers',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 14,
            [ReagentData['hide']['curedheavy']] = 1,
            [ReagentData['monster']['thickmurlocscale']] = 16,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Dusky Belt'] = {
        skill = 195,
        description = '[BoE] (Leather Waist) AC: 61, Agi: 8, Sta: 8, MinLvl: 34',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 10,
            [ReagentData['bolt']['silk']] = 2,
            [ReagentData['dye']['black']] = 2,
            [ReagentData['armor']['ironbuckle']] = 1,
        }
    },
    ['Guardian Leather Bracers'] = {
        skill = 195,
        description = '[BoE] (Leather Wrist) AC: 48, Int: 6, Spi: 6, MinLvl: 34',
        type = 'Leather',
        source = 'Drop:Pattern: Guardian Leather Bracers',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 6,
            [ReagentData['hide']['curedheavy']] = 2,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Barbaric Belt'] = {
        skill = 200,
        description = '[BoE] (Leather Waist) AC: 62, Str: 11, MinLvl: 35, Use: Increase Rage by 30.',
        type = 'Leather',
        source = 'Drop:Pattern: Barbaric Belt',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 6,
            [ReagentData['hide']['curedheavy']] = 2,
            [ReagentData['monster']['coarsegorillahair']] = 2,
            [ReagentData['armor']['ironbuckle']] = 1,
            [ReagentData['potion']['greatrage']] = 1,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Comfortable Leather Hat'] = {
        skill = 200,
        description = '[BoE] (Leather Head) AC: 90, Sta: 11, Spi: 10, MinLvl: 35',
        type = 'Leather',
        source = 'Drop:Pattern: Comfortable Leather Hat',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 12,
            [ReagentData['hide']['curedheavy']] = 2,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Cured Thick Hide'] = {
        skill = 200,
        description = 'Cured Thick Hide',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['hide']['thick']] = 1,
            [ReagentData['salt']['deeprock']] = 1,
        }
    },
    ['Dusky Boots'] = {
        skill = 200,
        description = '[BoE] (Leather Feet) AC: 76, Agi: 11, Sta: 3, MinLvl: 35',
        type = 'Leather',
        source = 'Drop:Pattern: Dusky Boots',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 8,
            [ReagentData['oil']['shadow']] = 1,
            [ReagentData['hide']['shadowcat']] = 2,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Shadowskin Gloves'] = {
        skill = 200,
        description = '[BoE] (Leather Hands) AC: 76, Sta: 6, MinLvl: 35, Equip: Improves your chance to get a critical strike by 1%.',
        type = 'Leather',
        source = 'Vendor:Pattern: Shadowskin Gloves',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['thick']] = 6,
            [ReagentData['gem']['shadow']] = 4,
            [ReagentData['hide']['curedheavy']] = 2,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['hide']['shadowcat']] = 8,
            [ReagentData['pearl']['black']] = 2,
        }
    },
    ['Swift Boots'] = {
        skill = 200,
        description = '[BoE] (Leather Feet) AC: 76, Spi: 10, MinLvl: 35, Use: Increases run speed by 40% for 15 sec.',
        type = 'Leather',
        source = 'Drop:Pattern: Swift Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 10,
            [ReagentData['spidersilk']['thick']] = 2,
            [ReagentData['potion']['swiftness']] = 2,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Thick Armor Kit'] = {
        skill = 200,
        description = 'MinLvl: 30, Use: Permanently increase the armor value of an item worn on the chest, legs, hands or feet by 32.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['thick']] = 5,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Thick Leather'] = {
        skill = 200,
        description = 'Thick Leather',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['heavy']] = 6,
        }
    },
    ['Nightscape Headband'] = {
        skill = 205,
        description = '[BoE] (Leather Head) AC: 91, Agi: 12, Sta: 11, MinLvl: 36',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 5,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Nightscape Tunic'] = {
        skill = 205,
        description = '[BoE] (Leather Chest) AC: 113, Agi: 15, Sta: 6, MinLvl: 36',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 7,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Turtle Scale Gloves'] = {
        skill = 205,
        description = '[BoE] (Mail Hands) AC: 146, Sta: 7, Int: 6, Spi: 6, MinLvl: 36',
        type = 'Mail',
        source = 'Drop, Vendor:Pattern: Turtle Scale Gloves',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 6,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['scale']['turtle']] = 8,
        }
    },
    ['Nightscape Shoulders'] = {
        skill = 210,
        description = '[BoE] (Leather Shoulder) AC: 86, Agi: 11, Sta: 5, MinLvl: 37',
        type = 'Leather',
        source = 'Vendor:Pattern: Nightscape Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 8,
            [ReagentData['cloth']['mageweave']] = 6,
            [ReagentData['thread']['silken']] = 3,
        }
    },
    ['Turtle Scale Bracers'] = {
        skill = 210,
        description = '[BoE] (Mail Wrist) AC: 204, MinLvl: 37',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 8,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['scale']['turtle']] = 12,
        }
    },
    ['Turtle Scale Breastplate'] = {
        skill = 210,
        description = '[BoE] (Mail Chest) AC: 238, Sta: 9, Int: 9, Spi: 9, MinLvl: 37',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 6,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['scale']['turtle']] = 12,
        }
    },
    ['Big Voodoo Robe'] = {
        skill = 215,
        description = '[BoE] (Leather Chest) AC: 117, Int: 14, Spi: 9, MinLvl: 38',
        type = 'Leather',
        source = 'Drop:Pattern: Big Voodoo Robe',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 10,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['monster']['flaskofmojo']] = 4,
        }
    },
    ['Big Voodoo Mask'] = {
        skill = 220,
        description = '[BoE] (Leather Head) AC: 97, Int: 14, Spi: 9, MinLvl: 39',
        type = 'Leather',
        source = 'Drop:Pattern: Big Voodoo Mask',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 8,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['monster']['flaskofmojo']] = 6,
        }
    },
    ['Tough Scorpid Bracers'] = {
        skill = 220,
        description = '[BoE] (Mail Wrist) AC: 107, Agi: 7, Spi: 6, MinLvl: 39',
        type = 'Mail',
        source = 'Drop:Pattern: Tough Scorpid Bracers',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 10,
            [ReagentData['scale']['scorpid']] = 4,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Tough Scorpid Breastplate'] = {
        skill = 220,
        description = '[BoE] (Mail Chest) AC: 245, Agi: 15, Spi: 7, MinLvl: 39',
        type = 'Mail',
        source = 'Drop:Pattern: Tough Scorpid Breastplate',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 12,
            [ReagentData['scale']['scorpid']] = 12,
            [ReagentData['thread']['silken']] = 4,
        }
    },
    ['Wild Leather Shoulders'] = {
        skill = 220,
        description = '[BoE] (Leather Shoulder) AC: 90, MinLvl: 39',
        type = 'Leather',
        source = 'Quest:Pattern: Wild Leather Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Wild Leather Shoulders of .*',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 10,
            [ReagentData['herb']['wildvine']] = 1,
            [ReagentData['hide']['curedthick']] = 1,
        }
    },
    ['Dragonscale Gauntlets'] = {
        skill = 225,
        description = '[BoE] (Mail Hands) AC: 171, Sta: 7, Spi: 6, MinLvl: 40, Equip: Improves your chance to get a critical strike by 1%.',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['thick']] = 24,
            [ReagentData['scale']['worndragon']] = 12,
            [ReagentData['hide']['curedthick']] = 2,
            [ReagentData['thread']['heavysilken']] = 4,
        }
    },
    ['Quickdraw Quiver'] = {
        skill = 225,
        description = 'MinLvl: 40, 16 Slot Quiver, Equip: Increases ranged attack speed by 13%.',
        type = 'Quiver',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 12,
            [ReagentData['hide']['curedthick']] = 1,
            [ReagentData['potion']['elixirofagility']] = 1,
            [ReagentData['thread']['silken']] = 4,
        }
    },
    ['Thick Leather Ammo Pouch'] = {
        skill = 225,
        description = 'MinLvl: 40, 16 Slot Ammo Pouch, Equip: Increases ranged attack speed by 13%.',
        type = 'Ammo Pouch',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 10,
            [ReagentData['hide']['curedthick']] = 1,
            [ReagentData['potion']['elixirofgreaterdefense']] = 1,
            [ReagentData['thread']['silken']] = 6,
        }
    },
    ['Tough Scorpid Gloves'] = {
        skill = 225,
        description = '[BoE] (Mail Hands) AC: 155, Agi: 10, Spi: 9, MinLvl: 40',
        type = 'Mail',
        source = 'Drop:Pattern: Tough Scorpid Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 6,
            [ReagentData['scale']['scorpid']] = 8,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Wild Leather Helmet'] = {
        skill = 225,
        description = '[BoE] (Leather Head) AC: 99, MinLvl: 40',
        type = 'Leather',
        source = 'Quest:Pattern: Wild Leather Helmet',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Wild Leather Helmet of .*',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 10,
            [ReagentData['herb']['wildvine']] = 2,
            [ReagentData['hide']['curedthick']] = 1,
        }
    },
    ['Wild Leather Vest'] = {
        skill = 225,
        description = '[BoE] (Leather Chest) AC: 121, MinLvl: 40',
        type = 'Leather',
        source = 'Quest:Pattern: Wild Leather Vest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Wild Leather Vest of .*',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 12,
            [ReagentData['herb']['wildvine']] = 2,
            [ReagentData['hide']['curedthick']] = 1,
        }
    },
    ['Wolfshead Helm'] = {
        skill = 225,
        description = '[BoE] (Leather Head) AC: 109, Spi: 10, MinLvl: 40, Classes: Druid, Equip: When shapeshifting into Cat form the Druid gains 20 energy, when shapeshifting into Bear form the Druid gains 5 rage.',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['thick']] = 18,
            [ReagentData['hide']['curedthick']] = 2,
            [ReagentData['monster']['wickedclaw']] = 8,
            [ReagentData['hide']['thickwolf']] = 2,
            [ReagentData['thread']['heavysilken']] = 4,
        }
    },
    ['Gauntlets of the Sea'] = {
        skill = 230,
        description = '[BoE] (Leather Hands) AC: 85, Agi: 7, MinLvl: 41, Use: Heal friendly target for 300 to 500.',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['thick']] = 20,
            [ReagentData['element']['globeofwater']] = 8,
            [ReagentData['element']['coreofearth']] = 2,
            [ReagentData['hide']['curedthick']] = 1,
            [ReagentData['thread']['heavysilken']] = 4,
        }
    },
    ['Nightscape Pants'] = {
        skill = 230,
        description = '[BoE] (Leather Legs) AC: 108, Agi: 16, Sta: 7, MinLvl: 41',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 14,
            [ReagentData['thread']['silken']] = 4,
        }
    },
    ['Turtle Scale Helm'] = {
        skill = 230,
        description = '[BoE] (Mail Head) AC: 206, Sta: 10, Int: 10, Spi: 10, MinLvl: 41',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 14,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['scale']['turtle']] = 24,
        }
    },
    ['Nightscape Boots'] = {
        skill = 235,
        description = '[BoE] (Leather Feet) AC: 87, Agi: 12, MinLvl: 42, Equip: Increases your effective stealth level by 1.',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 16,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Tough Scorpid Boots'] = {
        skill = 235,
        description = '[BoE] (Mail Feet) AC: 178, Agi: 12, Spi: 7, MinLvl: 42',
        type = 'Mail',
        source = 'Drop:Pattern: Tough Scorpid Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 12,
            [ReagentData['scale']['scorpid']] = 12,
            [ReagentData['thread']['silken']] = 6,
        }
    },
    ['Turtle Scale Leggings'] = {
        skill = 235,
        description = '[BoE] (Mail Legs) AC: 226, Sta: 11, Int: 10, Spi: 11, MinLvl: 42',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 14,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['scale']['turtle']] = 28,
        }
    },
    ['Big Voodoo Cloak'] = {
        skill = 240,
        description = '[BoE] (Back) AC: 31, Int: 9, Spi: 5, MinLvl: 43',
        type = 'Cloth',
        source = 'Drop:Pattern: Big Voodoo Cloak',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 14,
            [ReagentData['thread']['heavysilken']] = 2,
            [ReagentData['monster']['flaskofbigmojo']] = 4,
        }
    },
    ['Big Voodoo Pants'] = {
        skill = 240,
        description = '[BoE] (Leather Legs) AC: 110, Int: 10, Spi: 15, MinLvl: 42',
        type = 'Leather',
        source = 'Drop:Pattern: Big Voodoo Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 10,
            [ReagentData['thread']['heavysilken']] = 2,
            [ReagentData['monster']['flaskofbigmojo']] = 6,
        }
    },
    ['Tough Scorpid Shoulders'] = {
        skill = 240,
        description = '[BoE] (Mail Shoulder) AC: 197, Agi: 10, Spi: 10, MinLvl: 43',
        type = 'Mail',
        source = 'Drop:Pattern: Tough Scorpid Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 12,
            [ReagentData['thread']['heavysilken']] = 2,
            [ReagentData['scale']['scorpid']] = 16,
        }
    },
    ['Tough Scorpid Leggings'] = {
        skill = 245,
        description = '[BoE] (Mail Legs) AC: 235, Agi: 17, Spi: 10, MinLvl: 44',
        type = 'Mail',
        source = 'Drop:Pattern: Tough Scorpid Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 14,
            [ReagentData['thread']['heavysilken']] = 2,
            [ReagentData['scale']['scorpid']] = 8,
        }
    },
    ['Wild Leather Boots'] = {
        skill = 245,
        description = '[BoE] (Leather Feet) AC: 90, MinLvl: 44',
        type = 'Leather',
        source = 'Quest:Pattern: Wild Leather Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Wild Leather Boots of .*',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 14,
            [ReagentData['herb']['wildvine']] = 4,
            [ReagentData['hide']['curedthick']] = 2,
        }
    },
    ['Cured Rugged Hide'] = {
        skill = 250,
        description = 'Cured Rugged Hide',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['salt']['refineddeeprock']] = 1,
            [ReagentData['hide']['rugged']] = 1,
        }
    },
    ['Feathered Breastplate'] = {
        skill = 250,
        description = '[BoE] (Leather Chest) AC: 146, Int: 10, Spi: 24, MinLvl: 45',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['thick']] = 40,
            [ReagentData['hide']['curedthick']] = 4,
            [ReagentData['thread']['heavysilken']] = 4,
            [ReagentData['feather']['jetblack']] = 40,
            [ReagentData['pearl']['black']] = 2,
        }
    },
    ['Helm of Fire'] = {
        skill = 250,
        description = '[BoE] (Leather Head) AC: 118, Agi: 17, Sta: 10, FR: 5, MinLvl: 45, Use: Hurls a fiery ball that causes 286 to 376 Fire damage and an additional 40 damage over 8 sec.',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['thick']] = 40,
            [ReagentData['element']['coreofearth']] = 4,
            [ReagentData['hide']['curedthick']] = 2,
            [ReagentData['thread']['heavysilken']] = 4,
            [ReagentData['element']['heartoffire']] = 8,
        }
    },
    ['Rugged Armor Kit'] = {
        skill = 250,
        description = 'MinLvl: 40, Use: Permanently increase the armor value of an item worn on the chest, legs, hands or feet by 40.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['rugged']] = 5,
        }
    },
    ['Rugged Leather'] = {
        skill = 250,
        description = 'Rugged Leather',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['leather']['thick']] = 6,
        }
    },
    ['Tough Scorpid Helm'] = {
        skill = 250,
        description = '[BoE] (Mail Head) AC: 222, Agi: 14, Spi: 14, MinLvl: 45',
        type = 'Mail',
        source = 'Drop:Pattern: Tough Scorpid Helm',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 10,
            [ReagentData['thread']['heavysilken']] = 2,
            [ReagentData['scale']['scorpid']] = 20,
        }
    },
    ['Wild Leather Cloak'] = {
        skill = 250,
        description = '[BoE] (Back) AC: 33, MinLvl: 45',
        type = 'Cloth',
        source = 'Quest:Pattern: Wild Leather Cloak',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Wild Leather Cloak of .*',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 16,
            [ReagentData['herb']['wildvine']] = 6,
            [ReagentData['hide']['curedthick']] = 2,
        }
    },
    ['Wild Leather Leggings'] = {
        skill = 250,
        description = '[BoE] (Leather Legs) AC: 116, MinLvl: 45',
        type = 'Leather',
        source = 'Quest:Pattern: Wild Leather Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Wild Leather Leggings of .*',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 16,
            [ReagentData['herb']['wildvine']] = 6,
            [ReagentData['hide']['curedthick']] = 2,
        }
    },
    ['Dragonscale Breastplate'] = {
        skill = 255,
        description = '[BoE] (Mail Chest) AC: 306, Sta: 10, FR: 13, CR: 13, SR: 12, MinLvl: 46, Use: Absorbs 600 magical damage. Lasts 2 min.',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['thick']] = 40,
            [ReagentData['scale']['worndragon']] = 30,
            [ReagentData['hide']['curedthick']] = 4,
            [ReagentData['thread']['heavysilken']] = 4,
        }
    },
    ['Heavy Scorpid Bracers'] = {
        skill = 255,
        description = '[BoE] (Mail Wrist) AC: 122, Sta: 8, Spi: 8, MinLvl: 46',
        type = 'Mail',
        source = 'Vendor:Pattern: Heavy Scorpid Bracers',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['scale']['heavyscorpid']] = 4,
            [ReagentData['leather']['rugged']] = 4,
        }
    },
    ['Green Dragonscale Breastplate'] = {
        skill = 260,
        description = '[BoE] (Mail Chest) AC: 311, Spi: 25, NR: 11, MinLvl: 47',
        type = 'Mail',
        source = 'Vendor:Pattern: Green Dragonscale Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['leather']['rugged']] = 20,
            [ReagentData['scale']['greendragon']] = 25,
        }
    },
    ['Wicked Leather Gauntlets'] = {
        skill = 260,
        description = '[BoE] (Leather Hands) AC: 86, Agi: 12, Sta: 11, MinLvl: 47',
        type = 'Leather',
        source = 'Vendor:Pattern: Wicked Leather Gauntlets',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 8,
            [ReagentData['dye']['black']] = 1,
        }
    },
    ['Chimeric Gloves'] = {
        skill = 265,
        description = '[BoE] (Leather Hands) AC: 87, AR: 11, NR: 12, MinLvl: 48',
        type = 'Leather',
        source = 'Vendor:Pattern: Chimeric Gloves',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 6,
            [ReagentData['leather']['chimera']] = 6,
        }
    },
    ['Heavy Scorpid Vest'] = {
        skill = 265,
        description = '[BoE] (Mail Chest) AC: 288, Sta: 16, Spi: 15, MinLvl: 48',
        type = 'Mail',
        source = 'Drop:Pattern: Heavy Scorpid Vest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['scale']['heavyscorpid']] = 6,
            [ReagentData['leather']['rugged']] = 6,
        }
    },
    ['Wicked Leather Bracers'] = {
        skill = 265,
        description = '[BoE] (Leather Wrist) AC: 61, Agi: 11, Sta: 5, MinLvl: 48',
        type = 'Leather',
        source = 'Drop:Pattern: Wicked Leather Bracers',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 8,
            [ReagentData['dye']['black']] = 1,
        }
    },
    ['Green Dragonscale Leggings'] = {
        skill = 270,
        description = '[BoE] (Mail Legs) AC: 282, Spi: 26, NR: 11, MinLvl: 49',
        type = 'Mail',
        source = 'Drop:Pattern: Green Dragonscale Leggings',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 20,
            [ReagentData['scale']['greendragon']] = 25,
        }
    },
    ['Ironfeather Shoulders'] = {
        skill = 270,
        description = '[BoE] (Leather Shoulder) AC: 117, Int: 20, Spi: 8, MinLvl: 49, Set: Ironfeather Armor (2)',
        type = 'Leather',
        source = 'Vendor:Pattern: Ironfeather Shoulders',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 24,
            [ReagentData['feather']['iron']] = 80,
            [ReagentData['gem']['jade']] = 2,
        }
    },
    ['Living Shoulders'] = {
        skill = 270,
        description = '[BoE] (Leather Shoulder) AC: 117, Spi: 13, NR: 8, MinLvl: 49, Equip: Increases healing done by spells and effects by up to 28.',
        type = 'Leather',
        source = 'Vendor:Pattern: Living Shoulders',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 12,
            [ReagentData['element']['livingessence']] = 4,
        }
    },
    ['Runic Leather Gauntlets'] = {
        skill = 270,
        description = '[BoE] (Leather Hands) AC: 88, Int: 8, Spi: 14, MinLvl: 49',
        type = 'Leather',
        source = 'Drop:Pattern: Runic Leather Gauntlets',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 10,
            [ReagentData['cloth']['rune']] = 6,
        }
    },
    ['Volcanic Leggings'] = {
        skill = 270,
        description = '[BoE] (Leather Legs) AC: 204, FR: 20, MinLvl: 49, Set: Volcanic Armor (3)',
        type = 'Leather',
        source = 'Drop:Pattern: Volcanic Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 6,
            [ReagentData['element']['coreofearth']] = 1,
            [ReagentData['element']['essenceoffire']] = 1,
        }
    },
    ['Chimeric Boots'] = {
        skill = 275,
        description = '[BoE] (Leather Feet) AC: 99, AR: 12, NR: 12, MinLvl: 50',
        type = 'Leather',
        source = 'Drop:Pattern: Chimeric Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['leather']['chimera']] = 8,
        }
    },
    ['Frostsaber Boots'] = {
        skill = 275,
        description = '[BoE] (Leather Feet) AC: 99, CR: 12, SR: 12, MinLvl: 50',
        type = 'Leather',
        source = 'Vendor:Pattern: Frostsaber Boots',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['leather']['frostsaber']] = 6,
        }
    },
    ['Heavy Scorpid Gauntlets'] = {
        skill = 275,
        description = 'Heavy Scorpid Gauntlet - [BoE] (Mail Hands) AC: 186, Sta: 12, Spi: 12, MinLvl: 50',
        type = 'Mail',
        source = 'Drop:Pattern: Heavy Scorpid Gauntlets',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Heavy Scorpid Gauntlet',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['scale']['heavyscorpid']] = 8,
            [ReagentData['leather']['rugged']] = 6,
        }
    },
    ['Runic Leather Bracers'] = {
        skill = 275,
        description = '[BoE] (Leather Wrist) AC: 63, Int: 10, Spi: 10, MinLvl: 50',
        type = 'Leather',
        source = 'Drop:Pattern: Runic Leather Bracers',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 6,
            [ReagentData['pearl']['black']] = 1,
            [ReagentData['cloth']['rune']] = 6,
        }
    },
    ['Stormshroud Pants'] = {
        skill = 275,
        description = '[BoE] (Leather Legs) AC: 138, MinLvl: 50, Equip: Improves your chance to get a critical strike by 2%., Equip: Increases your chance to dodge an attack by 1%., Set: Stormshroud Armor (4)',
        type = 'Leather',
        source = 'Vendor:Pattern: Stormshroud Pants',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 16,
            [ReagentData['element']['essenceofwater']] = 2,
            [ReagentData['element']['essenceofair']] = 2,
        }
    },
    ['Warbear Harness'] = {
        skill = 275,
        description = '[BoE] (Leather Chest) AC: 158, Str: 11, Sta: 27, MinLvl: 50',
        type = 'Leather',
        source = 'Drop, Vendor:Pattern: Warbear Harness',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 28,
            [ReagentData['leather']['warbear']] = 12,
        }
    },
    ['Chimeric Leggings'] = {
        skill = 280,
        description = '[BoE] (Leather Legs) AC: 127, AR: 16, NR: 16, MinLvl: 51',
        type = 'Leather',
        source = 'Drop:Pattern: Chimeric Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 8,
            [ReagentData['leather']['chimera']] = 8,
        }
    },
    ['Heavy Scorpid Belt'] = {
        skill = 280,
        description = '[BoE] (Mail Waist) AC: 170, Sta: 12, Spi: 12, MinLvl: 51',
        type = 'Mail',
        source = 'Drop:Pattern: Heavy Scorpid Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['scale']['heavyscorpid']] = 8,
            [ReagentData['leather']['rugged']] = 6,
        }
    },
    ['Runic Leather Belt'] = {
        skill = 280,
        description = '[BoE] (Leather Waist) AC: 82, Int: 14, Spi: 9, MinLvl: 51',
        type = 'Leather',
        source = 'Drop:Pattern: Runic Leather Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 12,
            [ReagentData['cloth']['rune']] = 10,
        }
    },
    ['Wicked Leather Headband'] = {
        skill = 280,
        description = '[BoE] (Leather Head) AC: 118, Agi: 16, Sta: 16, MinLvl: 51',
        type = 'Leather',
        source = 'Drop:Pattern: Wicked Leather Headband',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 12,
            [ReagentData['dye']['black']] = 1,
        }
    },
    ['Blue Dragonscale Breastplate'] = {
        skill = 285,
        description = '[BoE] (Mail Chest) AC: 338, Int: 28, Spi: 8, AR: 8, MinLvl: 52',
        type = 'Mail',
        source = 'Vendor:Pattern: Blue Dragonscale Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['scale']['bluedragon']] = 30,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 28,
            [ReagentData['hide']['curedrugged']] = 1,
        }
    },
    ['Frostsaber Leggings'] = {
        skill = 285,
        description = '[BoE] (Leather Legs) AC: 129, CR: 17, SR: 16, MinLvl: 52',
        type = 'Leather',
        source = 'Drop:Pattern: Frostsaber Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 6,
            [ReagentData['leather']['frostsaber']] = 8,
        }
    },
    ['Heavy Scorpid Leggings'] = {
        skill = 285,
        description = '[BoE] (Mail Legs) AC: 269, Sta: 12, Spi: 20, MinLvl: 52',
        type = 'Mail',
        source = 'Drop:Pattern: Heavy Scorpid Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['scale']['heavyscorpid']] = 12,
            [ReagentData['leather']['rugged']] = 8,
        }
    },
    ['Living Leggings'] = {
        skill = 285,
        description = '[BoE] (Leather Legs) AC: 142, Spi: 25, NR: 8, MinLvl: 52, Equip: Increases healing done by spells and effects by up to 24.',
        type = 'Leather',
        source = 'Drop:Pattern: Living Leggings',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 16,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['element']['livingessence']] = 6,
        }
    },
    ['Stormshroud Armor'] = {
        skill = 285,
        description = '[BoE] (Leather Chest) AC: 163, MinLvl: 52, Equip: Improves your chance to get a critical strike by 2%., Equip: Increases your chance to dodge an attack by 1%., Set: Stormshroud Armor (4)',
        type = 'Leather',
        source = 'Drop:Pattern: Stormshroud Armor',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 16,
            [ReagentData['element']['essenceofwater']] = 3,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['element']['essenceofair']] = 3,
        }
    },
    ['Volcanic Breastplate'] = {
        skill = 285,
        description = '[BoE] (Leather Chest) AC: 268, FR: 20, MinLvl: 52, Set: Volcanic Armor (3)',
        type = 'Leather',
        source = 'Drop:Pattern: Volcanic Breastplate',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 8,
            [ReagentData['element']['essenceofearth']] = 1,
            [ReagentData['element']['essenceoffire']] = 1,
        }
    },
    ['Warbear Woolies'] = {
        skill = 285,
        description = '[BoE] (Leather Legs) AC: 142, Str: 28, Sta: 12, MinLvl: 52',
        type = 'Leather',
        source = 'Drop, Vendor:Pattern: Warbear Woolies',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 24,
            [ReagentData['leather']['warbear']] = 14,
        }
    },
    ['Black Dragonscale Breastplate'] = {
        skill = 290,
        description = '[BoE] (Mail Chest) AC: 344, Sta: 8, FR: 12, MinLvl: 53, Equip: +50 Attack Power.',
        type = 'Mail',
        source = 'Vendor:Pattern: Black Dragonscale Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['leather']['rugged']] = 40,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['scale']['blackdragon']] = 60,
        }
    },
    ['Chimeric Vest'] = {
        skill = 290,
        description = '[BoE] (Leather Chest) AC: 150, AR: 16, NR: 17, MinLvl: 53',
        type = 'Leather',
        source = 'Drop:Pattern: Chimeric Vest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 10,
            [ReagentData['leather']['chimera']] = 10,
        }
    },
    ['Devilsaur Gauntlets'] = {
        skill = 290,
        description = '[BoE] (Leather Hands) AC: 103, Sta: 9, MinLvl: 53, Equip: +28 Attack Power., Equip: Improves your chance to get a critical strike by 1%., Set: Devilsaur Armor (2)',
        type = 'Leather',
        source = 'Vendor:Pattern: Devilsaur Gauntlets',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 30,
            [ReagentData['leather']['devilsaur']] = 8,
        }
    },
    ['Ironfeather Breastplate'] = {
        skill = 290,
        description = '[BoE] (Leather Chest) AC: 165, Int: 12, Spi: 28, MinLvl: 53, Set: Ironfeather Armor (2)',
        type = 'Leather',
        source = 'Drop:Pattern: Ironfeather Breastplate',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 40,
            [ReagentData['feather']['iron']] = 120,
            [ReagentData['gem']['jade']] = 1,
            [ReagentData['hide']['curedrugged']] = 1,
        }
    },
    ['Runic Leather Headband'] = {
        skill = 290,
        description = '[BoE] (Leather Head) AC: 122, Int: 20, Spi: 12, MinLvl: 53',
        type = 'Leather',
        source = 'Vendor:Pattern: Runic Leather Headband',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 14,
            [ReagentData['cloth']['rune']] = 10,
        }
    },
    ['Wicked Leather Pants'] = {
        skill = 290,
        description = '[BoE] (Leather Legs) AC: 131, Agi: 20, Sta: 12, MinLvl: 53',
        type = 'Leather',
        source = 'Drop:Pattern: Wicked Leather Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 16,
            [ReagentData['dye']['black']] = 3,
            [ReagentData['hide']['curedrugged']] = 1,
        }
    },
    ['Blue Dragonscale Shoulders'] = {
        skill = 295,
        description = '[BoE] (Mail Shoulder) AC: 262, Int: 21, Spi: 6, AR: 6, MinLvl: 54',
        type = 'Mail',
        source = 'Drop:Pattern: Blue Dragonscale Shoulders',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['scale']['bluedragon']] = 30,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 28,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['leather']['enchanted']] = 2,
        }
    },
    ['Corehound Boots'] = {
     skill = 295,
     description = '[BoE] (Leather Feet) AC: 126, Agi: 13, Sta: 10, FR: 24, MinLvl: 54',
     type = 'Leather',
     source = 'Vendor:Pattern: Corehound Boots',
     result = 1,
     resultrarity = 'Epic',
     reagents = {
          [ReagentData['leather']['core']] = 20,
          [ReagentData['thread']['rune']] = 2,
          [ReagentData['monster']['fierycore']] = 6,
          [ReagentData['monster']['lavacore']] = 2,
     }
    },
    ['Frostsaber Gloves'] = {
        skill = 295,
        description = '[BoE] (Leather Hands) AC: 95, CR: 13, SR: 12, MinLvl: 54',
        type = 'Leather',
        source = 'Drop:Pattern: Frostsaber Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 6,
            [ReagentData['leather']['frostsaber']] = 10,
        }
    },
    ['Heavy Scorpid Helm'] = {
        skill = 295,
        description = '[BoE] (Mail Head) AC: 258, Sta: 20, Spi: 13, MinLvl: 54',
        type = 'Mail',
        source = 'Vendor:Pattern: Heavy Scorpid Helm',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['scale']['heavyscorpid']] = 12,
            [ReagentData['leather']['rugged']] = 8,
            [ReagentData['hide']['curedrugged']] = 1,
        }
    },
    ['Stormshroud Shoulders'] = {
        skill = 295,
        description = '[BoE] (Leather Shoulder) AC: 114, Sta: 10, MinLvl: 54, Equip: Improves your chance to get a critical strike by 1%., Equip: Increases your chance to dodge an attack by 1%., Set: Stormshroud Armor (4)',
        type = 'Leather',
        source = 'Drop:Pattern: Stormshroud Shoulders',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 12,
            [ReagentData['element']['essenceofwater']] = 3,
            [ReagentData['element']['essenceofair']] = 3,
            [ReagentData['leather']['enchanted']] = 2,
        }
    },
    ['Black Dragonscale Boots'] = {
        skill = 300,
        description = '[BoE] (Mail Feet) AC: 270, Sta: 10, FR: 24, MinLvl: 56, Equip: +28 Attack Power.',
        type = 'Mail',
        source = 'Vendor:Pattern: Black Dragonscale Boots',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['monster']['fierycore']] = 4,
            [ReagentData['scale']['blackdragon']] = 30,
            [ReagentData['monster']['lavacore']] = 3,
            [ReagentData['leather']['enchanted']] = 6,
        }
    },
    ['Black Dragonscale Leggings'] = {
        skill = 300,
        description = '[BoE] (Mail Legs) AC: 320, Sta: 8, FR: 13, MinLvl: 57, Equip: +54 Attack Power.',
        type = 'Mail',
        source = 'Drop:Pattern: Black Dragonscale Leggings',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['leather']['rugged']] = 40,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['scale']['blackdragon']] = 60,
            [ReagentData['leather']['enchanted']] = 4,
        }
    },
    ['Black Dragonscale Shoulders'] = {
        skill = 300,
        description = '[BoE] (Mail Shoulder) AC: 266, Sta: 9, FR: 6, MinLvl: 55, Equip: +40 Attack Power.',
        type = 'Mail',
        source = 'Drop:Pattern: Black Dragonscale Shoulders',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 44,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['scale']['blackdragon']] = 45,
            [ReagentData['leather']['enchanted']] = 2,
        }
    },
    ['Chromatic Cloak'] = {
        skill = 300,
        description = '[BoE] (Back) AC: 48, Sta: 10, FR: 9, SR: 9, MinLvl: 57, Equip: Improves your chance to get a critical strike with spells by 1%.',
        type = 'Cloth',
        source = 'Drop:Pattern: Chromatic Cloak',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['thread']['rune']] = 8,
            [ReagentData['monster']['brilliantchromaticscale']] = 12,
            [ReagentData['leather']['rugged']] = 30,
            [ReagentData['hide']['curedrugged']] = 5,
            [ReagentData['scale']['blackdragon']] = 30,
            [ReagentData['scale']['reddragon']] = 30,
        }
    },
    ['Core Armor Kit'] = {
        skill = 300,
        description = 'MinLvl: 50, Use: Permanently increases the defense value of an item worn on the chest, legs, hands or feet by 5.',
        source = 'Drop:Pattern: Core Armor Kit',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
         [ReagentData['leather']['core']] = 3,
         [ReagentData['thread']['rune']] = 2,
        }
    },
    ['Devilsaur Leggings'] = {
        skill = 300,
        description = '[BoE] (Leather Legs) AC: 148, Sta: 12, MinLvl: 55, Equip: +46 Attack Power., Equip: Improves your chance to get a critical strike by 1%., Set: Devilsaur Armor (2)',
        type = 'Leather',
        source = 'Drop:Pattern: Devilsaur Leggings',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 30,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['leather']['devilsaur']] = 14,
        }
    },
    ['Frostsaber Tunic'] = {
        skill = 300,
        description = '[BoE] (Leather Chest) AC: 158, CR: 18, SR: 18, MinLvl: 57',
        type = 'Leather',
        source = 'Drop:Pattern: Frostsaber Tunic',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['leather']['rugged']] = 12,
            [ReagentData['leather']['frostsaber']] = 12,
            [ReagentData['hide']['curedrugged']] = 1,
        }
    },
    ['Girdle of Insight'] = {
        skill = 300,
        description = '[BoE] (Leather Waist) AC: 98, Sta: 9, Int: 23, MinLvl: 57',
        type = 'Leather',
        source = 'Drop:Pattern: Girdle of Insight',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 4,
            [ReagentData['leather']['rugged']] = 12,
            [ReagentData['monster']['powerfulmojo']] = 12,
            [ReagentData['hide']['curedrugged']] = 2,
        }
    },
    ['Stormshroud Gloves'] = {
        skill = 300,
        description = '[BoE] (Leather Gloves) AC: 109, Sta: 10, MinLvl: 57, Equip: Improves your chance to get a critical strike by 1%., Equip: Increases your chance to hit by 1%., Set: Stormshroud Armor (4)',
        type = 'Leather',
        source = 'Drop:Pattern: Stormshroud Gloves',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 2,
            [ReagentData['hide']['curedrugged']] = 2,
            [ReagentData['element']['essenceofwater']] = 4,
            [ReagentData['element']['essenceofair']] = 4,
            [ReagentData['leather']['enchanted']] = 6,
        }
    },
    ['Heavy Scorpid Shoulders'] = {
        skill = 300,
        description = '[BoE] (Mail Shoulder) AC: 245, Sta: 14, Spi: 13, MinLvl: 56',
        type = 'Mail',
        source = 'Drop:Pattern: Heavy Scorpid Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['scale']['heavyscorpid']] = 14,
            [ReagentData['leather']['rugged']] = 14,
            [ReagentData['hide']['curedrugged']] = 1,
        }
    },
    ['Hide of the Wild'] = {
        skill = 300,
        description = '[BoE] (Back) AC: 48, Sta: 8, Int: 10, MinLvl: 57, Equip: Increases healing done by spells and effects by up to 38.',
        type = 'Cloth',
        source = 'Drop:Pattern: Hide of the Wild',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['thread']['rune']] = 8,
            [ReagentData['leather']['rugged']] = 30,
            [ReagentData['element']['essenceofwater']] = 10,
            [ReagentData['hide']['curedrugged']] = 3,
            [ReagentData['element']['livingessence']] = 12,
            [ReagentData['monster']['larvalacid']] = 8,
        }
    },
    ['Living Breastplate'] = {
        skill = 300,
        description = '[BoE] (Leather Chest) AC: 169, Spi: 25, NR: 10, MinLvl: 55, Equip: Increases healing done by spells and effects by up to 24.',
        type = 'Leather',
        source = 'Drop:Pattern: Living Breastplate',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['cloth']['moon']] = 2,
            [ReagentData['leather']['rugged']] = 16,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['element']['livingessence']] = 8,
        }
    },
    ['Molten Helm'] = {
        skill = 300,
        description = '[BoE] (Leather Head) AC: 150, Sta: 16, FR: 29, MinLvl: 55, Equip: Increases your chance to dodge an attack by 1%.',
        type = 'Leather',
        source = 'Vendor:Pattern: Molten Helm',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
         [ReagentData['leather']['core']] = 15,
         [ReagentData['thread']['rune']] = 2,
         [ReagentData['monster']['fierycore']] = 3,
         [ReagentData['monster']['lavacore']] = 6,
        }
    },
    ['Mongoose Boots'] = {
        skill = 300,
        description = '[BoE] (Leather Feet) AC: 120, Agi: 23, Sta: 9, MinLvl: 57',
        type = 'Leather',
        source = 'Drop:Pattern: Mongoose Boots',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 4,
            [ReagentData['gem']['blackdiamond']] = 4,
            [ReagentData['leather']['rugged']] = 12,
            [ReagentData['hide']['curedrugged']] = 2,
            [ReagentData['element']['essenceofair']] = 6,
        }
    },
    ['Red Dragonscale Breastplate'] = {
        skill = 300,
        description = '[BoE] (Mail Chest) AC: 360, FR: 12, MinLvl: 56, Equip: Increases healing done by spells and effects by up to 60.',
        type = 'Mail',
        source = 'Drop:Pattern: Red Dragonscale Breastplate',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 40,
            [ReagentData['scale']['reddragon']] = 30,
        }
    },
    ['Runic Leather Armor'] = {
        skill = 300,
        description = '[BoE] (Leather Chest) AC: 158, Int: 21, Spi: 13, MinLvl: 57',
        type = 'Leather',
        source = 'Drop:Pattern: Runic Leather Armor',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['leather']['rugged']] = 22,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['leather']['enchanted']] = 4,
            [ReagentData['cloth']['rune']] = 16,
        }
    },
    ['Runic Leather Pants'] = {
        skill = 300,
        description = '[BoE] (Leather Legs) AC: 135, Int: 13, Spi: 20, MinLvl: 55',
        type = 'Leather',
        source = 'Drop:Pattern: Runic Leather Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 18,
            [ReagentData['cloth']['rune']] = 12,
            [ReagentData['leather']['enchanted']] = 2,
        }
    },
    ['Runic Leather Shoulders'] = {
        skill = 300,
        description = '[BoE] (Leather Shoulder) AC: 119, Int: 15, Spi: 10, MinLvl: 57',
        type = 'Leather',
        source = 'Drop:Pattern: Runic Leather Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['leather']['rugged']] = 16,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['leather']['enchanted']] = 4,
            [ReagentData['cloth']['rune']] = 18,
        }
    },
    ['Shifting Cloak'] = {
        skill = 300,
        description = '[BoE] (Back) AC: 48, Agi: 17, Sta: 8, MinLvl: 57, Equip: Increases your chance to dodge an attack by 1%.',
        type = 'Cloth',
        source = 'Drop:Pattern: Shifting Cloak',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['thread']['rune']] = 8,
            [ReagentData['leather']['rugged']] = 30,
            [ReagentData['hide']['curedrugged']] = 4,
            [ReagentData['element']['essenceofair']] = 12,
            [ReagentData['monster']['skinofshadow']] = 4,
            [ReagentData['monster']['guardianstone']] = 8,
        }
    },
    ['Swift Flight Bracers'] = {
        skill = 300,
        description = '[BoE] (Mail Wrist) AC: 160, Sta: 7, MinLvl: 57, Equip: +41 ranged Attack Power.',
        type = 'Mail',
        source = 'Drop:Pattern: Swift Flight Bracers',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 4,
            [ReagentData['leather']['rugged']] = 12,
            [ReagentData['feather']['iron']] = 60,
            [ReagentData['hide']['curedrugged']] = 4,
            [ReagentData['monster']['larvalacid']] = 8,
        }
    },
    ['Volcanic Shoulders'] = {
        skill = 300,
        description = '[BoE] (Leather Shoulder) AC: 167, FR: 18, MinLvl: 56, Set: Volcanic Armor (3)',
        type = 'Leather',
        source = 'Drop:Pattern: Volcanic Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['leather']['rugged']] = 10,
            [ReagentData['element']['essenceofearth']] = 1,
            [ReagentData['element']['essenceoffire']] = 1,
        }
    },
    ['Wicked Leather Armor'] = {
        skill = 300,
        description = '[BoE] (Leather Chest) AC: 156, Agi: 25, Sta: 7, MinLvl: 56',
        type = 'Leather',
        source = 'Drop:Pattern: Wicked Leather Armor',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['leather']['rugged']] = 20,
            [ReagentData['cloth']['fel']] = 6,
            [ReagentData['dye']['black']] = 4,
            [ReagentData['hide']['curedrugged']] = 2,
        }
    },
    ['Wicked Leather Belt'] = {
        skill = 300,
        description = '[BoE] (Leather Waist) AC: 87, Agi: 14, Sta: 13, MinLvl: 55',
        type = 'Leather',
        source = 'Drop:Pattern: Wicked Leather Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['leather']['rugged']] = 14,
            [ReagentData['dye']['black']] = 2,
        }
    },
    ['Gordok Ogre Suit'] = {
        skill = 290,
        source = 'Quest',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['bolt']['rune']] = 2,
        [ReagentData['monster']['ogretannin']] = 1,
        }
    },
--~     ['Nightscape Cloak'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['leather']['thick']] = 12,
--~             [ReagentData['thread']['silken']] = 4,
--~         }
--~     },
--~     ['Onyxia Scale Breastplate'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['thread']['rune']] = 2,
--~             [ReagentData['leather']['rugged']] = 40,
--~             [ReagentData['monster']['scaleofonyxia']] = 12,
--~             [ReagentData['scale']['blackdragon']] = 60,
--~         }
--~     },
    ['Onyxia Scale Cloak'] = {
        skill = 300,
        type = 'Cloth',
        source = 'Quest',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['armor']['cinderclothcloak']] = 1,
            [ReagentData['monster']['scaleofonyxia']] = 1,
        }
    },
    ['Golden Mantle of the Dawn'] = {
        skill = 300,
        description = '[BoE] (Leather Shoulder) AC: 134, Sta: 22, MinLvl: 59, Passive: Increases your chance to dodge an attack by 1%.',
        type = 'Leather',
        source = 'Vendor:Pattern: Golden Mantle of the Dawn',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['enchanted']] = 8,
            [ReagentData['monster']['guardianstone']] = 4,
            [ReagentData['hide']['curedrugged']] = 2,
            [ReagentData['thread']['rune']] = 2,
        },
    },
    ['Lava Belt'] = {
        skill = 300,
        description = '[BoE] (Leather Waist) AC: 223, Sta: 15, FR: 26, MinLvl: 60',
        type = 'Leather',
        source = 'Vendor:Pattern: Lava Belt',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['lavacore']] = 5,
            [ReagentData['hide']['curedrugged']] = 4,
            [ReagentData['spidersilk']['ironweb']] = 4,
        },
    },
    ['Barbaric Bracers'] = {
        skill = 155,
        description = '[BoE] (Leather Wrist) AC: 47, Sta: 6, Agi: 4, Spi: 4, MinLvl: 27',
        type = 'Leather',
        source = 'Vendor:Pattern: Barbaric Bracers',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['heavy']] = 8,
            [ReagentData['hide']['curedheavy']] = 2,
            [ReagentData['pearl']['smalllustrous']] = 4,
            [ReagentData['hide']['raptor']] = 1,
            [ReagentData['monster']['largefang']] = 4,
        },
    },
    ['Dawn Treaders'] = {
        skill = 290,
        description = '[BoE] (Leather Feet) AC: 114, Sta: 18, MinLvl: 53, Passive: Increases your chance to dodge an attack by 1%.',
        type = 'Leather',
        source = 'Vendor:Pattern: Dawn Treaders',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['rugged']] = 30,
            [ReagentData['monster']['guardianstone']] = 2,
            [ReagentData['element']['essenceofwater']] = 4,
            [ReagentData['hide']['curedrugged']] = 2,
            [ReagentData['thread']['rune']] = 2,
        },
    },
    ['Molten Belt'] = {
        skill = 300,
        description = '[BoE] (Leather Feet) AC: 114, Sta: 18, MinLvl: 53, Passive: Increases your chance to dodge an attack by 1%.',
        type = 'Leather',
        source = 'Vendor:Pattern: Dawn Treaders',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['fierycore']] = 2,
            [ReagentData['monster']['lavacore']] = 7,
            [ReagentData['element']['essenceofearth']] = 6,
            [ReagentData['hide']['curedrugged']] = 4,
            [ReagentData['spidersilk']['ironweb']] = 4,
        },
    },
    ['Might of the Timbermaw'] = {
        skill = 290,
        description = '[BoE] (Leather Waist) AC: 93, Str: 21, Sta: 9, MinLvl: 53',
        type = 'Leather',
        source = 'Vendor:Pattern: Might of the Timbermaw',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['rugged']] = 30,
            [ReagentData['monster']['powerfulmojo']] = 2,
            [ReagentData['element']['livingessence']] = 4,
            [ReagentData['hide']['curedrugged']] = 2,
            [ReagentData['thread']['rune']] = 2,
        },
    },
    ['Timbermaw Brawlers'] = {
        skill = 300,
        description = '[BoE] (Leather Hands) AC: 112, Str: 23, Sta: 10, MinLvl: 59',
        type = 'Leather',
        source = 'Vendor:Pattern: Timbermaw Brawlers',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['enchanted']] = 8,
            [ReagentData['monster']['powerfulmojo']] = 6,
            [ReagentData['element']['livingessence']] = 6,
            [ReagentData['hide']['curedrugged']] = 2,
            [ReagentData['spidersilk']['ironweb']] = 2,
        },
    },
    ['Chromatic Gauntlets'] = {
        skill = 300,
        description = '[BoE] (Mail Hands) AC: 279, HR: 5, FR: 5, NR: 5, CR: 5, SR: 5, Passive: +44 Attack Power., Passive: Improves your chance to get a critical strike by 1%., Passive: Improves your chance to get a critical strike with spells by 1%., MinLvl: 60',
        type = 'Mail',
        source = 'Vendor:Pattern: Chromatic Gauntlets',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['fierycore']] = 5,
            [ReagentData['monster']['lavacore']] = 2,
            [ReagentData['leather']['core']] = 4,
            [ReagentData['monster']['brilliantchromaticscale']] = 4,
            [ReagentData['hide']['curedrugged']] = 4,
            [ReagentData['spidersilk']['ironweb']] = 4,
        },
    },
    ['Corehound Belt'] = {
        skill = 300,
        description = '[BoE] (Leather Waist) AC: 118, Int: 16, FR: 12, Passive: Increases healing done by spells and effects by up to 62.',
        type = 'Mail',
        source = 'Vendor:Pattern: Corehound Belt',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['fierycore']] = 8,
            [ReagentData['leather']['core']] = 12,
            [ReagentData['leather']['enchanted']] = 10,
            [ReagentData['hide']['curedrugged']] = 4,
            [ReagentData['spidersilk']['ironweb']] = 4,
        },
    },
    ['Primal Batskin Jerkin'] = {
        skill = 300,
        description = '[BoE] (Leather Chest) AC: 181, Agi: 32, Sta: 6, MinLvl: 60, Passive: Improves your chance to hit by 1%.',
        type = 'Leather',
        source = 'Vendor:Pattern: Primal Batskin Jerkin',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['primalbat']] = 14,
            [ReagentData['hide']['curedrugged']] = 5,
            [ReagentData['element']['livingessence']] = 4,
            [ReagentData['thread']['rune']] = 4,
        },
    },
    ['Primal Batskin Gloves'] = {
        skill = 300,
        description = '[BoE] (Leather Hands) AC: 113, Agi: 10, Sta: 9, MinLvl: 60, Passive: Improves your chance to hit by 2%.',
        type = 'Leather',
        source = 'Vendor:Pattern: Primal Batskin Gloves',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['primalbat']] = 10,
            [ReagentData['hide']['curedrugged']] = 4,
            [ReagentData['element']['livingessence']] = 4,
            [ReagentData['thread']['rune']] = 3,
        },
    },
    ['Primal Batskin Bracers'] = {
        skill = 300,
        description = '[BoE] (Leather Wrist) AC: 79, Agi: 14, Sta: 7, MinLvl: 60, Passive: Improves your chance to hit by 1%.',
        type = 'Leather',
        source = 'Vendor:Pattern: Primal Batskin Bracers',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['primalbat']] = 8,
            [ReagentData['hide']['curedrugged']] = 3,
            [ReagentData['element']['livingessence']] = 4,
            [ReagentData['thread']['rune']] = 3,
        },
    },
    ['Blood Tiger Breastplate'] = {
        skill = 300,
        description = '[BoE] (Leather Chest) AC: 181, Str: 17, Sta: 17, Int: 16, Spi: 13, MinLvl: 60',
        type = 'Leather',
        source = 'Vendor:Pattern: Blood Tiger Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['primaltiger']] = 35,
            [ReagentData['herb']['bloodvine']] = 2,
            [ReagentData['hide']['curedrugged']] = 3,
            [ReagentData['thread']['rune']] = 3,
        },
    },
    ['Blood Tiger Shoulders'] = {
        skill = 300,
        description = '[BoE] (Leather Shoulders) AC: 136, Str: 13, Sta: 13, Int: 12, Spi: 10, MinLvl: 60',
        type = 'Leather',
        source = 'Vendor:Pattern: Blood Tiger Shoulders',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['primaltiger']] = 25,
            [ReagentData['herb']['bloodvine']] = 2,
            [ReagentData['hide']['curedrugged']] = 3,
            [ReagentData['thread']['rune']] = 3,
        },
    },
    ['Green Dragonscale Gauntlets'] = {
        skill = 280,
        description = '[BoE] (Mail Hands) AC: 208, Sta: 5, Spi: 18, NR: 9, MinLvl: 51',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['rugged']] = 20,
            [ReagentData['scale']['greendragon']] = 30,
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['thread']['rune']] = 2,
        },
    },
    ['Blue Dragonscale Leggings'] = {
        skill = 280,
        description = '[BoE] (Mail Legs) AC: 310, Int: 20, Spi: 19, AR: 12, MinLvl: 55',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['rugged']] = 28,
            [ReagentData['scale']['bluedragon']] = 36,
            [ReagentData['hide']['curedrugged']] = 2,
            [ReagentData['thread']['rune']] = 2,
        },
    },
    ['Dreamscale Breasatplate'] = {
        skill = 300,
        description = '[BoP] (Mail Chest) AC: 434, NR: 30, Agi: 15, Sta: 15, Int: 14, MinLvl: 60, Passive: Restores 4 mana ever 5 sec.',
        type = 'Mail',
        source = 'Vendor:Pattern: Dreamscale Breastplate',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['leather']['enchanted']] = 12,
            [ReagentData['scale']['dream']] = 6,
            [ReagentData['element']['livingessence']] = 4,
            [ReagentData['hide']['curedrugged']] = 4,
            [ReagentData['spidersilk']['ironweb']] = 6,
        },
    },
    ['Sandstalker Bracers'] = {
        skill = 300,
        description = '[BoE] (Mail Wrist) AC: 220, NR: 15, Sta: 7, MinLvl: 57',
        type = 'Mail',
        source = 'Vendor:Pattern: Sandstalker Bracers',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['heavysilithidcarapace']] = 1,
            [ReagentData['monster']['silithidchitin']] = 20,
            [ReagentData['monster']['larvalacid']] = 2,
        },
    },
    ['Sandstalker Breastplate'] = {
        skill = 300,
        description = '[BoE] (Mail Chest) AC: 485, NR: 25, Sta: 13, MinLvl: 57',
        type = 'Mail',
        source = 'Vendor:Pattern: Sandstalker Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['heavysilithidcarapace']] = 2,
            [ReagentData['monster']['silithidchitin']] = 40,
            [ReagentData['monster']['larvalacid']] = 2,
            [ReagentData['hide']['curedrugged']] = 2,
        },
    },
    ['Sandstalker Gauntlets'] = {
        skill = 300,
        description = '[BoE] (Mail Hands) AC: 308, NR: 20, Sta: 9, MinLvl: 57',
        type = 'Mail',
        source = 'Vendor:Pattern: Sandstalker Bracers',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['heavysilithidcarapace']] = 2,
            [ReagentData['monster']['silithidchitin']] = 30,
            [ReagentData['monster']['larvalacid']] = 2,
            [ReagentData['hide']['curedrugged']] = 1,
        },
    },
    ['Spitfire Bracers'] = {
        skill = 300,
        description = '[BoE] (Mail Wrist) AC: 160, Agi: 9, Int: 9, MinLvl: 57, Passive: Restore 4 mana every 5 sec., Passive: Increases damage and healing done by magical spells and effects by up to 8',
        type = 'Mail',
        source = 'Vendor:Pattern: Spitfire Bracers',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['lightsilithidcarapace']] = 1,
            [ReagentData['monster']['silithidchitin']] = 20,
            [ReagentData['element']['essenceoffire']] = 2,
        },
    },
    ['Spitfire Breastplate'] = {
        skill = 300,
        description = '[BoE] (Mail Chest) AC: 365, Agi: 16, Int: 16, MinLvl: 57, Passive: Restore 6 mana every 5 sec., Passive: Increases damage and healing done by magical spells and effects by up to 15',
        type = 'Mail',
        source = 'Vendor:Pattern: Spitfire Breastplate',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['lightsilithidcarapace']] = 3,
            [ReagentData['monster']['silithidchitin']] = 40,
            [ReagentData['element']['essenceoffire']] = 2,
            [ReagentData['hide']['curedrugged']] = 2,
     },
    },
    ['Spitfire Gauntlets'] = {
        skill = 300,
        description = '[BoE] (Mail Hands) AC: 228, Agi: 12, Int: 12, MinLvl: 57, Passive: Restore 5 mana every 5 sec., Passive: Increases damage and healing done by magical spells and effects by up to 11',
        type = 'Mail',
        source = 'Vendor:Pattern: Spitfire Gauntlets',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['lightsilithidcarapace']] = 2,
            [ReagentData['monster']['silithidchitin']] = 30,
            [ReagentData['element']['essenceoffire']] = 2,
            [ReagentData['hide']['curedrugged']] = 1,
        },
    },
    ['Black Whelp Tunic'] = {
        skill = 100,
        description = '[BoE] (Leather Chest) AC: 78, Str: 5, Agi: 3, MinLvl: 15',
        type = 'Leather',
        source = 'Vendor:Pattern: Black Whelp Tunic',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['medium']] = 8,
            [ReagentData['scale']['blackwhelp']] = 8,
            [ReagentData['hide']['curedlight']] = 1,
            [ReagentData['thread']['fine']] = 2,
        },
    },
    ['Bramblewood Belt'] = {
        skill = 300,
        description = '[BoE] (Leather Waist) AC: 108, Sta: 14, NR: 15, MinLvl: 60',
        type = 'Leather',
        source = 'Vendor:Pattern: Bramblewood Belt',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['enchanted']] = 4,
            [ReagentData['element']['livingessence']] = 2,
            [ReagentData['hide']['curedrugged']] = 1,
        },
    },
    ['Bramblewood Boots'] = {
        skill = 300,
        description = '[BoE] (Leather Feet) AC: 132, Sta: 12, NR: 25, MinLvl: 60',
        type = 'Leather',
        source = 'Vendor:Pattern: Bramblewood Boots',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['enchanted']] = 6,
            [ReagentData['element']['livingessence']] = 2,
            [ReagentData['hide']['curedrugged']] = 2,
            [ReagentData['monster']['larvalacid']] = 2,
        },
    },
    ['Bramblewood Helm'] = {
        skill = 300,
        description = '[BoE] (Leather Head) AC: 156, Sta: 20, NR: 30, MinLvl: 60',
        type = 'Leather',
        source = 'Vendor:Pattern: Bramblewood Helm',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['enchanted']] = 12,
            [ReagentData['element']['livingessence']] = 2,
            [ReagentData['hide']['curedrugged']] = 2,
            [ReagentData['herb']['bloodvine']] = 2,
        },
    },
    ['Polar Bracers'] = {
        skill = 300,
        description = '[BoE] (Leather Wrist) AC: 102, Agi: 12, Sta: 20, CR: 20, MinLvl: 60',
        type = 'Leather',
        source = 'Vendor:Pattern: Polar Bracers',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['other']['frozenrune']] = 4,
            [ReagentData['element']['essenceofwater']] = 2,
            [ReagentData['hide']['curedrugged']] = 2,
            [ReagentData['leather']['enchanted']] = 12,
            [ReagentData['spidersilk']['ironweb']] = 4,
        },
    },
    ['Polar Gloves'] = {
        skill = 300,
        description = '[BoE] (Leather Hands) AC: 146, Agi: 18, Sta: 18, CR: 30, MinLvl: 60',
        type = 'Leather',
        source = 'Vendor:Pattern: Polar Gloves',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['other']['frozenrune']] = 5,
            [ReagentData['element']['essenceofwater']] = 2,
            [ReagentData['hide']['curedrugged']] = 3,
            [ReagentData['leather']['enchanted']] = 12,
            [ReagentData['spidersilk']['ironweb']] = 4,
        },
    },
    ['Polar Tunic'] = {
        skill = 300,
        description = '[BoE] (Leather Chest) AC: 234, Agi: 18, Sta: 26, CR: 40, MinLvl: 60',
        type = 'Leather',
        source = 'Vendor:Pattern: Polar Tunic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['other']['frozenrune']] = 7,
            [ReagentData['element']['essenceofwater']] = 2,
            [ReagentData['hide']['curedrugged']] = 4,
            [ReagentData['leather']['enchanted']] = 16,
            [ReagentData['spidersilk']['ironweb']] = 4,
        },
    },
    ['Icy Scale Bracers'] = {
         skill = 300,
         description = '[BoE] (Leather Wrist) AC: 221,  Sta: 17, CR: 20, MinLvl: 60, Equip: +32 Attack Power.',
         type = 'Mail',
         source = 'Vendor:Pattern: Icy Scale Bracers',
         result = 1,
         resultrarity = 'Epic',
         reagents = {
              [ReagentData['other']['frozenrune']] = 5,
              [ReagentData['element']['essenceofwater']] = 2,
              [ReagentData['hide']['curedrugged']] = 2,
              [ReagentData['scale']['heavyscorpid']] = 16,
              [ReagentData['spidersilk']['ironweb']] = 4,
         },
    },
    ['Icy Scale Gauntlets'] = {
         skill = 300,
         description = '[BoE] (Leather Hands) AC: 316,  Sta: 22, CR: 30, MinLvl: 60, Equip: +22 Attack Power.',
         type = 'Mail',
         source = 'Vendor:Pattern: Icy Scale Bracers',
         result = 1,
         resultrarity = 'Epic',
         reagents = {
              [ReagentData['other']['frozenrune']] = 5,
              [ReagentData['element']['essenceofwater']] = 2,
              [ReagentData['hide']['curedrugged']] = 3,
              [ReagentData['scale']['heavyscorpid']] = 16,
              [ReagentData['spidersilk']['ironweb']] = 4,
         },
    },
    ['Icy Scale Breastplate'] = {
         skill = 300,
         description = '[BoE] (Leather Chest) AC: 506,  Sta: 24, CR: 40, MinLvl: 60, Equip: +40 Attack Power.',
         type = 'Mail',
         source = 'Vendor:Pattern: Icy Scale Bracers',
         result = 1,
         resultrarity = 'Epic',
         reagents = {
              [ReagentData['other']['frozenrune']] = 7,
              [ReagentData['element']['essenceofwater']] = 2,
              [ReagentData['hide']['curedrugged']] = 4,
              [ReagentData['scale']['heavyscorpid']] = 24,
              [ReagentData['spidersilk']['ironweb']] = 4,
         },
        },
}
end