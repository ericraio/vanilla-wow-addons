function ReagentData_LoadTailoring()
ReagentData['crafted']['tailoring'] = {
    ['Bolt of Linen Cloth'] = {
        skill = 1,
        description = 'Bolt of Linen Cloth',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['linen']] = 2,
        }
    },
    ['Brown Linen Shirt'] = {
        skill = 1,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Linen Cloak'] = {
        skill = 1,
        description = '(Back) AC: 6',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Simple Linen Pants'] = {
        skill = 1,
        description = '(Cloth Legs) AC: 12, MinLvl: 2',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['White Linen Shirt'] = {
        skill = 1,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 1,
            [ReagentData['dye']['bleach']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Brown Linen Vest'] = {
        skill = 10,
        description = '(Cloth Chest) AC: 15, MinLvl: 3',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Linen Belt'] = {
        skill = 15,
        description = '(Cloth Waist) AC: 9, MinLvl: 4',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Simple Linen Boots'] = {
        skill = 20,
        description = '(Cloth Feet) AC: 11, MinLvl: 4',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 2,
            [ReagentData['leather']['light']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Brown Linen Pants'] = {
        skill = 30,
        description = '(Cloth Legs) AC: 16, MinLvl: 5',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 2,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Brown Linen Robe'] = {
        skill = 30,
        description = '[BoE] (Cloth Chest) AC: 19, Spi: 1, MinLvl: 5',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['linen']] = 3,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['White Linen Robe'] = {
        skill = 30,
        description = '[BoE] (Cloth Chest) AC: 19, Int: 1, MinLvl: 5',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['linen']] = 3,
            [ReagentData['dye']['bleach']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Heavy Linen Gloves'] = {
        skill = 35,
        description = '(Cloth Hands) AC: 11, MinLvl: 5',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 2,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Blue Linen Shirt'] = {
        skill = 40,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['dye']['blue']] = 1,
            [ReagentData['bolt']['linen']] = 2,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Red Linen Robe'] = {
        skill = 40,
        description = '[BoE] (Cloth Chest) AC: 19, Int: 1, MinLvl: 5',
        type = 'Cloth',
        source = 'Drop:Pattern: Red Linen Robe',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['linen']] = 3,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['Red Linen Shirt'] = {
        skill = 40,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 2,
            [ReagentData['dye']['red']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Simple Dress'] = {
        skill = 40,
        description = 'Chest',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['dye']['blue']] = 1,
            [ReagentData['bolt']['linen']] = 2,
            [ReagentData['dye']['bleach']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Linen Bag'] = {
        skill = 45,
        description = '6 Slot Container',
        type = 'Container',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 3,
            [ReagentData['thread']['coarse']] = 3,
        }
    },
    ['Blue Linen Vest'] = {
        skill = 55,
        description = '[BoE] (Cloth Chest) AC: 23, Spi: 2, MinLvl: 7',
        type = 'Cloth',
        source = 'Vendor:Pattern: Blue Linen Vest',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['blue']] = 1,
            [ReagentData['bolt']['linen']] = 3,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Red Linen Vest'] = {
        skill = 55,
        description = '[BoE] (Cloth Chest) AC: 23, Spi: 2, MinLvl: 7',
        type = 'Cloth',
        source = 'Drop:Pattern: Red Linen Vest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['linen']] = 3,
            [ReagentData['dye']['red']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Green Linen Bracers'] = {
        skill = 60,
        description = '(Cloth Wrist) AC: 9, MinLvl: 7',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 3,
            [ReagentData['thread']['coarse']] = 2,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Reinforced Linen Cape'] = {
        skill = 60,
        description = '(Back) AC: 11, MinLvl: 7',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 2,
            [ReagentData['thread']['coarse']] = 3,
        }
    },
    ['Linen Boots'] = {
        skill = 65,
        description = '(Cloth Feet) AC: 16, MinLvl: 8',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 3,
            [ReagentData['leather']['light']] = 1,
            [ReagentData['thread']['coarse']] = 1,
        }
    },
    ['Blue Linen Robe'] = {
        skill = 70,
        description = '[BoE] (Cloth Chest) AC: 26, Spi: 3, MinLvl: 9',
        type = 'Cloth',
        source = 'Vendor:Pattern: Blue Linen Robe',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['blue']] = 2,
            [ReagentData['bolt']['linen']] = 4,
            [ReagentData['thread']['coarse']] = 2,
        }
    },
    ['Red Linen Bag'] = {
        skill = 70,
        description = '6 Slot Container',
        type = 'Container',
        source = 'Drop, Vendor:Pattern: Red Linen Bag',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 4,
            [ReagentData['dye']['red']] = 1,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Bolt of Woolen Cloth'] = {
        skill = 75,
        description = 'Bolt of Woolen Cloth',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['wool']] = 3,
        }
    },
    ['Simple Kilt'] = {
        skill = 75,
        description = '(Cloth Legs) AC: 23, MinLvl: 10',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 4,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Woolen Cape'] = {
        skill = 75,
        description = '(Back) AC: 14, MinLvl: 11',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 1,
        }
    },
    ['Soft-soled Linen Boots'] = {
        skill = 80,
        description = '[BoE] (Cloth Feet) AC: 20, Sta: 2, Int: 2, MinLvl: 11',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['linen']] = 5,
            [ReagentData['leather']['light']] = 2,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Woolen Bag'] = {
        skill = 80,
        description = '8 Slot Container',
        type = 'Container',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 3,
        }
    },
    ['Green Woolen Vest'] = {
        skill = 85,
        description = '(Cloth Chest) AC: 29, MinLvl: 12',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['bolt']['wool']] = 2,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Heavy Woolen Gloves'] = {
        skill = 85,
        description = '[BoE] (Cloth Hands) AC: 19, Int: 2, Spi: 2, MinLvl: 12',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 3,
        }
    },
    ['Pearl-clasped Cloak'] = {
        skill = 90,
        description = '[BoE] (Back) AC: 16, Int: 3, MinLvl: 14',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['bolt']['wool']] = 3,
            [ReagentData['pearl']['smalllustrous']] = 1,
        }
    },
    ['Barbaric Linen Vest'] = {
        skill = 91,
        description = '[BoE] (Cloth Chest) AC: 26, Sta: 2, Spi: 2, MinLvl: 9',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['linen']] = 4,
            [ReagentData['leather']['light']] = 1,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Green Linen Shirt'] = {
        skill = 91,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['linen']] = 3,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Handstitched Linen Britches'] = {
        skill = 91,
        description = '[BoE] (Cloth Legs) AC: 23, Int: 2, Spi: 2, MinLvl: 9',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['linen']] = 4,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Green Woolen Bag'] = {
        skill = 95,
        description = '8 Slot Container',
        type = 'Container',
        source = 'Drop:Pattern: Green Woolen Bag',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 4,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Red Woolen Boots'] = {
        skill = 95,
        description = '[BoE] (Cloth Feet) AC: 23, Spi: 5, MinLvl: 15',
        type = 'Cloth',
        source = 'Drop:Pattern: Red Woolen Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 2,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 4,
        }
    },
    ['Woolen Boots'] = {
        skill = 95,
        description = '[BoE] (Cloth Feet) AC: 22, Agi: 2, Int: 2, Spi: 2, MinLvl: 14',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 2,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['bolt']['wool']] = 4,
        }
    },
    ['Blue Overalls'] = {
        skill = 100,
        description = '[BoE] (Cloth Chest) AC: 34, Str: 4, Sta: 4, MinLvl: 15',
        type = 'Cloth',
        source = 'Vendor:Pattern: Blue Overalls',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['blue']] = 2,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['bolt']['wool']] = 4,
        }
    },
    ['Gray Woolen Shirt'] = {
        skill = 100,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 2,
        }
    },
    ['Heavy Woolen Cloak'] = {
        skill = 100,
        description = '[BoE] (Back) AC: 17, Spi: 4, MinLvl: 16',
        type = 'Cloth',
        source = 'Drop:Pattern: Heavy Woolen Cloak',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['bolt']['wool']] = 3,
            [ReagentData['pearl']['smalllustrous']] = 2,
        }
    },
    ['Gray Woolen Robe'] = {
        skill = 105,
        description = '[BoE] (Cloth Chest) AC: 35, Sta: 4, Int: 5, MinLvl: 16',
        type = 'Cloth',
        source = 'Drop:Pattern: Gray Woolen Robe',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 3,
            [ReagentData['bolt']['wool']] = 4,
        }
    },
    ['Double-stitched Woolen Shoulders'] = {
        skill = 110,
        description = '(Cloth Shoulder) AC: 26, MinLvl: 17',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['bolt']['wool']] = 3,
        }
    },
    ['Heavy Woolen Pants'] = {
        skill = 110,
        description = '[BoE] (Cloth Legs) AC: 31, Int: 3, Spi: 6, MinLvl: 17',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['fine']] = 4,
            [ReagentData['bolt']['wool']] = 5,
        }
    },
    ['Stylish Red Shirt'] = {
        skill = 125,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 3,
        }
    },
    ['White Woolen Dress'] = {
        skill = 110,
        description = '(Cloth Chest) AC: 34, MinLvl: 17',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['dye']['bleach']] = 4,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 3,
        }
    },
    ['Greater Adept\'s Robe'] = {
        skill = 115,
        description = '[BoE] (Cloth Chest) AC: 37, Sta: 1, Int: 2, Spi: 7, MinLvl: 18',
        type = 'Cloth',
        source = 'Vendor:Pattern: Greater Adept\'s Robe',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['red']] = 3,
            [ReagentData['thread']['fine']] = 3,
            [ReagentData['bolt']['wool']] = 5,
        }
    },
    ['Red Woolen Bag'] = {
        skill = 115,
        description = '8 Slot Container',
        type = 'Container',
        source = 'Drop, Vendor:Pattern: Red Woolen Bag',
        result = 1,
        reagents = {
            [ReagentData['dye']['red']] = 1,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 4,
        }
    },
    ['Colorful Kilt'] = {
        skill = 120,
        description = '[BoE] (Cloth Legs) AC: 33, Agi: 5, Spi: 5, MinLvl: 14',
        type = 'Cloth',
        source = 'Drop:Pattern: Colorful Kilt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['red']] = 3,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 5,
        }
    },
    ['Reinforced Woolen Shoulders'] = {
        skill = 120,
        description = '(Cloth Shoulder) AC: 27, MinLvl: 19',
        type = 'Cloth',
        source = 'Drop:Pattern: Reinforced Woolen Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['bolt']['wool']] = 6,
            [ReagentData['leather']['medium']] = 2,
        }
    },
    ['Stylish Blue Shirt'] = {
        skill = 120,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Drop:Pattern: Stylish Blue Shirt',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['dye']['blue']] = 2,
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 4,
        }
    },
    ['Stylish Green Shirt'] = {
        skill = 120,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Drop:Pattern: Stylish Green Shirt',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['dye']['gray']] = 1,
            [ReagentData['thread']['fine']] = 1,
            [ReagentData['bolt']['wool']] = 4,
            [ReagentData['dye']['green']] = 2,
        }
    },
    ['Bolt of Silk Cloth'] = {
        skill = 125,
        description = 'Bolt of Silk Cloth',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['silk']] = 4,
        }
    },
    ['Phoenix Gloves'] = {
        skill = 125,
        description = '[BoE] (Cloth Hands) AC: 24, MinLvl: 20, Equip: Increases damage done by Fire spells and effects by up to 6.',
        type = 'Cloth',
        source = 'Drop:Pattern: Phoenix Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['pearl']['iridescent']] = 1,
            [ReagentData['dye']['bleach']] = 2,
            [ReagentData['thread']['fine']] = 4,
            [ReagentData['bolt']['wool']] = 4,
        }
    },
    ['Phoenix Pants'] = {
        skill = 125,
        description = '[BoE] (Cloth Legs) AC: 34, Int: 4, MinLvl: 20, Equip: Increases damage done by Fire spells and effects by up to 7.',
        type = 'Cloth',
        source = 'Drop:Pattern: Phoenix Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['pearl']['iridescent']] = 1,
            [ReagentData['thread']['fine']] = 3,
            [ReagentData['bolt']['wool']] = 6,
        }
    },
    ['Spidersilk Boots'] = {
        skill = 125,
        description = '[BoE] (Cloth Feet) AC: 29, Sta: 4, Int: 4, Spi: 7, MinLvl: 20',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bolt']['silk']] = 2,
            [ReagentData['pearl']['iridescent']] = 2,
            [ReagentData['leather']['medium']] = 4,
            [ReagentData['spidersilk']['silk']] = 4,
        }
    },
    ['Gloves of Meditation'] = {
        skill = 130,
        description = '[BoE] (Cloth Hands) AC: 25, Spi: 7, MinLvl: 21',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['potion']['elixirofwisdom']] = 1,
            [ReagentData['thread']['fine']] = 3,
            [ReagentData['bolt']['wool']] = 4,
        }
    },
    ['Bright Yellow Shirt'] = {
        skill = 135,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Vendor:Pattern: Bright Yellow Shirt',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 1,
            [ReagentData['dye']['yellow']] = 1,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Lesser Wizard\'s Robe'] = {
        skill = 135,
        description = '[BoE] (Cloth Chest) AC: 41, Int: 8, Spi: 5, MinLvl: 22',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 2,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['spidersilk']['silk']] = 2,
        }
    },
    ['Azure Silk Pants'] = {
        skill = 140,
        description = '[BoE] (Cloth Legs) AC: 36, Int: 6, MinLvl: 23, Equip: Increases damage done by Frost spells and effects by up to 7.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['dye']['blue']] = 2,
            [ReagentData['thread']['fine']] = 3,
        }
    },
    ['Spider Silk Slippers'] = {
        skill = 140,
        description = '[BoE] (Cloth Feet) AC: 29, Agi: 3, Spi: 7, MinLvl: 23',
        type = 'Cloth',
        source = 'Drop:Pattern: Spider Silk Slippers',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['spidersilk']['silk']] = 1,
        }
    },
    ['Azure Silk Gloves'] = {
        skill = 145,
        description = '[BoE] (Cloth Hands) AC: 26, Spi: 3, MinLvl: 24, Equip: Increases damage done by Frost spells and effects by up to 7.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Azure Silk Gloves',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['dye']['blue']] = 2,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Azure Silk Hood'] = {
        skill = 145,
        description = '(Cloth Head) AC: 33, MinLvl: 24',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 2,
            [ReagentData['dye']['blue']] = 2,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Hands of Darkness'] = {
        skill = 145,
        description = '[BoE] (Cloth Hands) AC: 26, Spi: 5, MinLvl: 24, Equip: Increases damage done by Shadow spells and effects by up to 6.',
        type = 'Cloth',
        source = 'Drop:Pattern: Hands of Darkness',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['potion']['shadowprotection']] = 2,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Azure Silk Vest'] = {
        skill = 150,
        description = '[BoE] (Cloth Chest) AC: 43, Int: 9, MinLvl: 25, Equip: Increases damage done by Frost spells and effects by up to 5.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 5,
            [ReagentData['dye']['blue']] = 4,
        }
    },
    ['Robes of Arcana'] = {
        skill = 150,
        description = '[BoE] (Cloth Chest) AC: 43, Int: 8, Spi: 7, MinLvl: 25',
        type = 'Cloth',
        source = 'Drop:Pattern: Robes of Arcana',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['thread']['fine']] = 2,
            [ReagentData['spidersilk']['silk']] = 2,
        }
    },
    ['Small Silk Pack'] = {
        skill = 150,
        description = '10 Slot Container',
        type = 'Container',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['thread']['fine']] = 3,
        }
    },
    ['Truefaith Gloves'] = {
        skill = 150,
        description = '[BoE] (Cloth Hands) AC: 27, Int: 3, MinLvl: 25, Equip: Increases healing done by spells and effects by up to 14.',
        type = 'Cloth',
        source = 'Drop:Pattern: Truefaith Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['potion']['healing']] = 4,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Dark Silk Shirt'] = {
        skill = 155,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Vendor:Pattern: Dark Silk Shirt',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 2,
            [ReagentData['dye']['gray']] = 2,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Silk Headband'] = {
        skill = 160,
        description = '(Cloth Head) AC: 34, MinLvl: 27',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['White Swashbuckler\'s Shirt'] = {
        skill = 160,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['dye']['bleach']] = 2,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Enchanter\'s Cowl'] = {
        skill = 165,
        description = '[BoE] (Cloth Head) AC: 37, Int: 10, Spi: 6, MinLvl: 28',
        type = 'Cloth',
        source = 'Vendor:Pattern: Enchanter\'s Cowl',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['spidersilk']['thick']] = 2,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Green Silk Armor'] = {
        skill = 165,
        description = '[BoE] (Cloth Chest) AC: 45, Int: 13, MinLvl: 28',
        type = 'Cloth',
        source = 'Drop:Pattern: Green Silk Armor',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 5,
            [ReagentData['dye']['green']] = 2,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Earthen Vest'] = {
        skill = 170,
        description = '[BoE] (Cloth Chest) AC: 46, Sta: 6, Spi: 10, MinLvl: 29',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['element']['earth']] = 1,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Formal White Shirt'] = {
        skill = 170,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['dye']['bleach']] = 2,
            [ReagentData['thread']['fine']] = 1,
        }
    },
    ['Shadow Hood'] = {
        skill = 170,
        description = '[BoE] (Cloth Head) AC: 37, Int: 11, MinLvl: 29, Equip: Increases damage done by Shadow spells and effects by up to 5.',
        type = 'Cloth',
        source = 'Drop:Pattern: Shadow Hood',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['oil']['shadow']] = 1,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Azure Silk Belt'] = {
        skill = 175,
        description = '[BoE] (Cloth Waist) AC: 26, Int: 5, MinLvl: 30, Equip: Increases swim speed by 15%.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['dye']['blue']] = 2,
            [ReagentData['element']['water']] = 1,
            [ReagentData['armor']['ironbuckle']] = 1,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Azure Silk Cloak'] = {
        skill = 175,
        description = '[BoE] (Back) AC: 23, Spi: 3, MinLvl: 30, Equip: Increases damage done by Frost spells and effects by up to 7.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Azure Silk Cloak',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['dye']['blue']] = 2,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Bolt of Mageweave'] = {
        skill = 175,
        description = 'Bolt of Mageweave',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['mageweave']] = 5,
        }
    },
    ['Boots of the Enchanter'] = {
        skill = 175,
        description = '[BoE] (Cloth Feet) AC: 32, Int: 5, Spi: 8, MinLvl: 30',
        type = 'Cloth',
        source = 'Drop:Pattern: Boots of the Enchanter',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['spidersilk']['thick']] = 2,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Crimson Silk Belt'] = {
        skill = 175,
        description = '[BoE] (Cloth Waist) AC: 26, Int: 7, Spi: 6, MinLvl: 30',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['armor']['ironbuckle']] = 1,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Green Silk Pack'] = {
        skill = 175,
        description = '10 Slot Container',
        type = 'Container',
        source = 'Drop:Pattern: Green Silk Pack',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['leather']['heavy']] = 3,
            [ReagentData['thread']['fine']] = 3,
            [ReagentData['dye']['green']] = 1,
        }
    },
    ['Red Swashbuckler\'s Shirt'] = {
        skill = 175,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 3,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Crimson Silk Cloak'] = {
        skill = 180,
        description = '[BoE] (Back) AC: 24, Sta: 3, FR: 7, MinLvl: 31',
        type = 'Cloth',
        source = 'Vendor:Pattern: Crimson Silk Cloak',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 5,
            [ReagentData['oil']['fire']] = 2,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Green Silken Shoulders'] = {
        skill = 180,
        description = '[BoE] (Cloth Shoulder) AC: 36, Int: 11, MinLvl: 31',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 5,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Spider Belt'] = {
        skill = 180,
        description = '[BoE] (Cloth Waist) AC: 27, Int: 8, MinLvl: 31, Use: Removes existing root spells and makes you immune to root for 5 sec.',
        type = 'Cloth',
        source = 'Drop:Pattern: Spider Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['spidersilk']['thick']] = 2,
            [ReagentData['armor']['ironbuckle']] = 1,
        }
    },
    ['Black Silk Pack'] = {
        skill = 185,
        description = '10 Slot Container',
        type = 'Container',
        source = 'Drop:Pattern: Black Silk Pack',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 5,
            [ReagentData['dye']['black']] = 1,
            [ReagentData['thread']['fine']] = 4,
        }
    },
    ['Crimson Silk Vest'] = {
        skill = 185,
        description = '(Cloth Chest) AC: 46, MinLvl: 32',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['fine']] = 2,
        }
    },
    ['Long Silken Cloak'] = {
        skill = 185,
        description = '[BoE] (Back) AC: 24, Int: 5, Spi: 6, MinLvl: 32',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['potion']['mana']] = 1,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Rich Purple Silk Shirt'] = {
        skill = 185,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Drop:Pattern: Rich Purple Silk Shirt',
        sourcerarity = 'Rare',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['dye']['purple']] = 1,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Azure Shoulders'] = {
        skill = 190,
        description = '[BoE] (Cloth Shoulder) AC: 38, Sta: 5, MinLvl: 33, Equip: Increases damage done by Frost spells and effects by up to 9.',
        type = 'Cloth',
        source = 'Drop:Pattern: Azure Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 6,
            [ReagentData['dye']['blue']] = 2,
            [ReagentData['monster']['nagascale']] = 2,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Crimson Silk Shoulders'] = {
        skill = 190,
        description = '[BoE] (Cloth Shoulder) AC: 38, Int: 8, Spi: 7, MinLvl: 33',
        type = 'Cloth',
        source = 'Drop:Pattern: Crimson Silk Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 5,
            [ReagentData['oil']['fire']] = 2,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Green Holiday Shirt'] = {
        skill = 190,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Drop:Pattern: Green Holiday Shirt',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 5,
            [ReagentData['dye']['green']] = 4,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Robe of Power'] = {
        skill = 190,
        description = '[BoP] (Cloth Chest) AC: 55, Int: 12, Spi: 8, MinLvl: 33, Equip: Increases damage and healing done by magical spells and effects by up to 8.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 2,
            [ReagentData['element']['earth']] = 2,
            [ReagentData['element']['air']] = 2,
            [ReagentData['element']['water']] = 2,
            [ReagentData['element']['fire']] = 2,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Crimson Silk Pantaloons'] = {
        skill = 195,
        description = '(Cloth Legs) AC: 43, MinLvl: 34',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 4,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Earthen Silk Belt'] = {
        skill = 195,
        description = '[BoE] (Cloth Waist) AC: 29, Sta: 8, Spi: 8, MinLvl: 34',
        type = 'Cloth',
        source = 'Drop:Pattern: Earthen Silk Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 5,
            [ReagentData['element']['earth']] = 4,
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['armor']['ironbuckle']] = 1,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Black Swashbuckler\'s Shirt'] = {
        skill = 200,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Vendor:Pattern: Black Swashbuckler\'s Shirt',
        result = 1,
        reagents = {
            [ReagentData['bolt']['silk']] = 5,
            [ReagentData['dye']['black']] = 1,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Icy Cloak'] = {
        skill = 200,
        description = '[BoE] (Back) AC: 29, Spi: 6, CR: 11, MinLvl: 35',
        type = 'Cloth',
        source = 'Vendor:Pattern: Icy Cloak',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['spidersilk']['thick']] = 2,
            [ReagentData['oil']['frost']] = 1,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Star Belt'] = {
        skill = 200,
        description = '[BoE] (Cloth Waist) AC: 30, Spi: 4, MinLvl: 35, Equip: Increases damage and healing done by magical spells and effects by up to 7.',
        type = 'Cloth',
        source = 'Drop:Pattern: Star Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 4,
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['gem']['citrine']] = 1,
            [ReagentData['armor']['ironbuckle']] = 1,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Black Mageweave Leggings'] = {
        skill = 205,
        description = '[BoE] (Cloth Legs) AC: 47, Int: 8, Spi: 14, MinLvl: 36',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 2,
            [ReagentData['thread']['silken']] = 3,
        }
    },
    ['Black Mageweave Vest'] = {
        skill = 205,
        description = '[BoE] (Cloth Chest) AC: 54, Int: 11, Spi: 12, MinLvl: 36',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 2,
            [ReagentData['thread']['silken']] = 3,
        }
    },
    ['Crimson Silk Robe'] = {
        skill = 205,
        description = '[BoE] (Cloth Chest) AC: 54, Int: 15, Spi: 6, MinLvl: 36',
        type = 'Cloth',
        source = 'Vendor:Pattern: Crimson Silk Robe',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 8,
            [ReagentData['potion']['mana']] = 2,
            [ReagentData['dye']['red']] = 4,
            [ReagentData['element']['fire']] = 4,
            [ReagentData['thread']['silken']] = 1,
        }
    },
    ['Black Mageweave Robe'] = {
        skill = 210,
        description = '[BoE] (Cloth Chest) AC: 55, Int: 8, Spi: 14, MinLvl: 37',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['thread']['heavysilken']] = 1,
        }
    },
    ['Crimson Silk Gloves'] = {
        skill = 210,
        description = '[BoE] (Cloth Hands) AC: 35, Int: 6, MinLvl: 37, Equip: Increases damage done by Fire spells and effects by up to 10.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['silk']] = 6,
            [ReagentData['leather']['thick']] = 2,
            [ReagentData['oil']['fire']] = 2,
            [ReagentData['dye']['red']] = 4,
            [ReagentData['element']['fire']] = 2,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Shadoweave Pants'] = {
        skill = 210,
        description = '[BoE] (Cloth Legs) AC: 48, Sta: 6, MinLvl: 37, Equip: Increases damage done by Shadow spells and effects by up to 15.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['spidersilk']['shadow']] = 2,
            [ReagentData['thread']['heavysilken']] = 1,
        }
    },
    ['Black Mageweave Gloves'] = {
        skill = 215,
        description = '[BoE] (Cloth Hands) AC: 35, MinLvl: 38, Equip: Increases damage and healing done by magical spells and effects by up to 9.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 2,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Orange Mageweave Shirt'] = {
        skill = 215,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 1,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['dye']['orange']] = 1,
        }
    },
    ['Red Mageweave Pants'] = {
        skill = 215,
        description = '[BoE] (Cloth Legs) AC: 49, Int: 12, MinLvl: 38, Equip: Increases damage and healing done by magical spells and effects by up to 8.',
        type = 'Cloth',
        source = 'Drop:Pattern: Red Mageweave Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['heavysilken']] = 1,
        }
    },
    ['Red Mageweave Vest'] = {
        skill = 215,
        description = '[BoE] (Cloth Chest) AC: 57, Int: 18, MinLvl: 38',
        type = 'Cloth',
        source = 'Drop:Pattern: Red Mageweave Vest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['heavysilken']] = 1,
        }
    },
    ['Shadoweave Robe'] = {
        skill = 215,
        description = '[BoE] (Cloth Chest) AC: 57, Spi: 7, MinLvl: 38, Equip: Increases damage done by Shadow spells and effects by up to 15.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['spidersilk']['shadow']] = 2,
            [ReagentData['thread']['heavysilken']] = 1,
        }
    },
    ['White Bandit Mask'] = {
        skill = 215,
        description = '[BoE] (Cloth Head) AC: 46, Str: 11, Agi: 11, MinLvl: 38',
        type = 'Cloth',
        source = 'Drop:Pattern: White Bandit Mask',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 1,
            [ReagentData['dye']['bleach']] = 1,
            [ReagentData['thread']['heavysilken']] = 1,
        }
    },
    ['Orange Martial Shirt'] = {
        skill = 220,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Vendor:Pattern: Orange Martial Shirt',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 2,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['dye']['orange']] = 2,
        }
    },
    ['Cindercloth Robe'] = {
        skill = 225,
        description = '[BoE] (Cloth Chest) AC: 59, MinLvl: 40, Equip: Increases damage done by Fire spells and effects by up to 20.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 5,
            [ReagentData['thread']['heavysilken']] = 2,
            [ReagentData['element']['heartoffire']] = 2,
        }
    },
    ['Dreamweave Gloves'] = {
        skill = 225,
        description = '[BoE] (Cloth Hands) AC: 41, Int: 4, Spi: 7, MinLvl: 40, Equip: Increases damage and healing done by magical spells and effects by up to 1 to 19.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 4,
            [ReagentData['herb']['wildvine']] = 4,
            [ReagentData['element']['heartofthewild']] = 2,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Dreamweave Vest'] = {
        skill = 225,
        description = '[BoE] (Cloth Chest) AC: 65, Int: 9, Spi: 14, MinLvl: 40, Equip: Increases damage and healing done by magical spells and effects by up to 1 to 19.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 6,
            [ReagentData['herb']['wildvine']] = 6,
            [ReagentData['element']['heartofthewild']] = 2,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Mageweave Bag'] = {
        skill = 225,
        description = '12 Slot Container',
        type = 'Container',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 4,
            [ReagentData['thread']['silken']] = 2,
        }
    },
    ['Enchanted Mageweave Pouch'] = {
        skill = 225,
        description = '16 Slot Enchanting Bag',
        type = 'Container',
        source = 'Vendor:Pattern: Enchanted Mageweave Pouch',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 4,
            [ReagentData['thread']['heavysilken']] = 2,
            [ReagentData['dust']['vision']] = 4,
        }
    },
    ['Red Mageweave Gloves'] = {
        skill = 225,
        description = '[BoE] (Cloth Hands) AC: 37, Int: 10, MinLvl: 40, Equip: Increases damage and healing done by magical spells and effects by up to 6.',
        type = 'Cloth',
        source = 'Drop:Pattern: Red Mageweave Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Shadoweave Gloves'] = {
        skill = 225,
        description = '[BoE] (Cloth Hands) AC: 37, Int: 5, MinLvl: 40, Equip: Increases damage done by Shadow spells and effects by up to 12.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 5,
            [ReagentData['spidersilk']['shadow']] = 5,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Black Mageweave Boots'] = {
        skill = 230,
        description = '[BoE] (Cloth Feet) AC: 41, Int: 7, Spi: 11, MinLvl: 41',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['leather']['thick']] = 2,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Black Mageweave Headband'] = {
        skill = 230,
        description = '[BoE] (Cloth Head) AC: 49, Int: 12, Spi: 13, MinLvl: 41',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Black Mageweave Shoulders'] = {
        skill = 230,
        description = '[BoE] (Cloth Shoulder) AC: 45, Int: 9, Spi: 10, MinLvl: 41',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Lavender Mageweave Shirt'] = {
        skill = 230,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Vendor:Pattern: Lavender Mageweave Shirt',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 2,
            [ReagentData['dye']['purple']] = 2,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Pink Mageweave Shirt'] = {
        skill = 235,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Vendor:Pattern: Pink Mageweave Shirt',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['thread']['heavysilken']] = 1,
            [ReagentData['dye']['pink']] = 1,
        }
    },
    ['Red Mageweave Bag'] = {
        skill = 235,
        description = '12 Slot Container',
        type = 'Container',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 4,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Red Mageweave Shoulders'] = {
        skill = 235,
        description = '[BoE] (Cloth Shoulder) AC: 46, Int: 15, MinLvl: 42',
        type = 'Cloth',
        source = 'Drop:Pattern: Red Mageweave Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 4,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['heavysilken']] = 3,
        }
    },
    ['Shadoweave Shoulders'] = {
        skill = 235,
        description = '[BoE] (Cloth Shoulder) AC: 46, Sta: 7, MinLvl: 42, Equip: Increases damage done by Shadow spells and effects by up to 12.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 5,
            [ReagentData['spidersilk']['shadow']] = 4,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Simple Black Dress'] = {
        skill = 235,
        description = 'Chest',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['dye']['black']] = 1,
            [ReagentData['dye']['bleach']] = 1,
            [ReagentData['thread']['heavysilken']] = 1,
        }
    },
    ['Admiral\'s Hat'] = {
        skill = 240,
        description = '[BoE] (Cloth Head) AC: 51, MinLvl: 43, Use: Increases target\'s Stamina by 20.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Admiral\'s Hat',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 3,
            [ReagentData['thread']['heavysilken']] = 2,
            [ReagentData['feather']['longelegant']] = 6,
        }
    },
    ['Red Mageweave Headband'] = {
        skill = 240,
        description = '[BoE] (Cloth Head) AC: 51, Int: 20, MinLvl: 43',
        type = 'Cloth',
        source = 'Drop:Pattern: Red Mageweave Headband',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 4,
            [ReagentData['dye']['red']] = 2,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Shadoweave Boots'] = {
        skill = 240,
        description = '[BoE] (Cloth Feet) AC: 43, Spi: 10, MinLvl: 43, Equip: Increases damage done by Shadow spells and effects by up to 10.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 6,
            [ReagentData['leather']['thick']] = 2,
            [ReagentData['spidersilk']['shadow']] = 6,
            [ReagentData['thread']['heavysilken']] = 3,
        }
    },
    ['Tuxedo Shirt'] = {
        skill = 240,
        description = '(Shirt)',
        type = 'Miscellaneous',
        source = 'Vendor:Pattern: Tuxedo Shirt',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 4,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Cindercloth Boots'] = {
        skill = 245,
        description = '[BoE] (Cloth Feet) AC: 44, MinLvl: 44, Equip: Increases damage done by Fire spells and effects by up to 15.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 5,
            [ReagentData['leather']['thick']] = 2,
            [ReagentData['thread']['heavysilken']] = 3,
            [ReagentData['element']['heartoffire']] = 1,
        }
    },
    ['Shadoweave Mask'] = {
        skill = 245,
        description = '[BoE] (Cloth Head) AC: 52, Int: 10, MinLvl: 44, Equip: Increases damage done by Shadow spells and effects by up to 17.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Shadoweave Mask',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 2,
            [ReagentData['spidersilk']['shadow']] = 8,
            [ReagentData['thread']['heavysilken']] = 2,
        }
    },
    ['Tuxedo Pants'] = {
        skill = 245,
        description = '(Cloth Legs) AC: 39, MinLvl: 30',
        type = 'Cloth',
        source = 'Vendor:Pattern: Tuxedo Pants',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 4,
            [ReagentData['thread']['heavysilken']] = 3,
        }
    },
    ['Bolt of Runecloth'] = {
        skill = 250,
        description = 'Bolt of Runecloth',
        type = 'Trade Goods',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['rune']] = 5,
        }
    },
    ['Dreamweave Circlet'] = {
        skill = 250,
        description = '[BoE] (Cloth Head) AC: 58, Int: 10, Spi: 12, MinLvl: 45, Equip: Increases damage and healing done by magical spells and effects by up to 21.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 8,
            [ReagentData['herb']['wildvine']] = 4,
            [ReagentData['bar']['truesilver']] = 1,
            [ReagentData['element']['heartofthewild']] = 2,
            [ReagentData['thread']['heavysilken']] = 3,
            [ReagentData['gem']['jade']] = 1,
        }
    },
    ['Mooncloth'] = {
        skill = 250,
        description = 'Mooncloth',
        type = 'Trade Goods',
        source = 'Vendor:Pattern: Mooncloth',
        result = 1,
        reagents = {
            [ReagentData['cloth']['fel']] = 2,
        }
    },
    ['Tuxedo Jacket'] = {
        skill = 250,
        description = '(Cloth Chest) AC: 44, MinLvl: 30, Equip: Impress others with your fashion sense.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Tuxedo Jacket',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 5,
            [ReagentData['thread']['heavysilken']] = 3,
        }
    },
    ['White Wedding Dress'] = {
        skill = 250,
        description = '(Cloth Chest) AC: 44, MinLvl: 30',
        type = 'Cloth',
        source = 'Vendor:Pattern: White Wedding Dress',
        result = 1,
        reagents = {
            [ReagentData['bolt']['mageweave']] = 5,
            [ReagentData['dye']['bleach']] = 1,
            [ReagentData['thread']['heavysilken']] = 3,
        }
    },
    ['Frostweave Robe'] = {
        skill = 255,
        description = '[BoE] (Cloth Chest) AC: 66, Spi: 11, MinLvl: 46, Equip: Increases damage done by Frost spells and effects by up to 17.',
        type = 'Cloth',
        source = 'Drop:Pattern: Frostweave Robe',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['globeofwater']] = 2,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 5,
        }
    },
    ['Frostweave Tunic'] = {
        skill = 255,
        description = '[BoE] (Cloth Chest) AC: 66, Int: 11, MinLvl: 46, Equip: Increases damage done by Frost spells and effects by up to 17.',
        type = 'Cloth',
        source = 'Drop:Pattern: Frostweave Tunic',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['globeofwater']] = 2,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 5,
        }
    },
    ['Runecloth Belt'] = {
        skill = 255,
        description = '[BoE] (Cloth Waist) AC: 37, Int: 12, Spi: 8, MinLvl: 46',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 3,
        }
    },
    ['Cindercloth Vest'] = {
        skill = 260,
        description = '[BoE] (Cloth Chest) AC: 68, Spi: 11, MinLvl: 47, Equip: Increases damage done by Fire spells and effects by up to 17.',
        type = 'Cloth',
        source = 'Drop:Pattern: Cindercloth Vest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 5,
            [ReagentData['element']['heartoffire']] = 3,
        }
    },
    ['Runecloth Bag'] = {
        skill = 260,
        description = '14 Slot Container',
        type = 'Container',
        source = 'Vendor:Pattern: Runecloth Bag',
        result = 1,
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 2,
            [ReagentData['bolt']['rune']] = 5,
        }
    },
    ['Runecloth Robe'] = {
        skill = 260,
        description = '[BoE] (Cloth Chest) AC: 68, Int: 17, Spi: 11, MinLvl: 47',
        type = 'Cloth',
        source = 'Vendor:Pattern: Runecloth Robe',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 1,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 5,
        }
    },
    ['Runecloth Tunic'] = {
        skill = 260,
        description = '[BoE] (Cloth Chest) AC: 68, Int: 11, Spi: 17, MinLvl: 47',
        type = 'Cloth',
        source = 'Drop:Pattern: Runecloth Tunic',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 1,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 5,
        }
    },
    ['Frostweave Gloves'] = {
        skill = 265,
        description = '[BoE] (Cloth Hands) AC: 43, Int: 6, MinLvl: 47, Equip: Increases damage done by Frost spells and effects by up to 15.',
        type = 'Cloth',
        source = 'Drop:Pattern: Frostweave Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 3,
            [ReagentData['element']['essenceofwater']] = 1,
        }
    },
    ['Ghostweave Belt'] = {
        skill = 265,
        description = '[BoE] (Cloth Waist) AC: 39, Int: 8, MinLvl: 48, Equip: Restores 6 mana every 5 sec.',
        type = 'Cloth',
        source = 'Drop:Pattern: Ghostweave Belt',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['ghost']] = 2,
            [ReagentData['spidersilk']['ironweb']] = 1,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 3,
        }
    },
    ['Runecloth Cloak'] = {
        skill = 265,
        description = '[BoE] (Back) AC: 34, Int: 8, Spi: 9, MinLvl: 48',
        type = 'Cloth',
        source = 'Vendor:Pattern: Runecloth Cloak',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 1,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 4,
        }
    },
    ['Brightcloth Gloves'] = {
        skill = 270,
        description = '[BoE] (Cloth Hands) AC: 44, CR: 12, SR: 11, MinLvl: 49',
        type = 'Cloth',
        source = 'Drop:Pattern: Brightcloth Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 4,
            [ReagentData['bar']['gold']] = 2,
        }
    },
    ['Brightcloth Robe'] = {
        skill = 270,
        description = '[BoE] (Cloth Chest) AC: 70, CR: 16, SR: 15, MinLvl: 49',
        type = 'Cloth',
        source = 'Drop:Pattern: Brightcloth Robe',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 5,
            [ReagentData['bar']['gold']] = 2,
        }
    },
    ['Cindercloth Gloves'] = {
        skill = 270,
        description = '[BoE] (Cloth Hands) AC: 44, Spi: 11, MinLvl: 49, Equip: Increases damage done by Fire spells and effects by up to 12.',
        type = 'Cloth',
        source = 'Drop:Pattern: Cindercloth Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 4,
            [ReagentData['element']['heartoffire']] = 3,
        }
    },
    ['Ghostweave Gloves'] = {
        skill = 270,
        description = '[BoE] (Cloth Hands) AC: 44, Int: 8, MinLvl: 49, Equip: Restores 6 mana every 5 sec.',
        type = 'Cloth',
        source = 'Drop:Pattern: Ghostweave Gloves',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['ghost']] = 2,
            [ReagentData['spidersilk']['ironweb']] = 1,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 4,
        }
    },
    ['Brightcloth Cloak'] = {
        skill = 275,
        description = '[BoE] (Back) AC: 36, CR: 7, SR: 7, MinLvl: 50, Equip: Increases damage done by Frost spells and effects by up to 7.',
        type = 'Cloth',
        source = 'Drop:Pattern: Brightcloth Cloak',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 4,
            [ReagentData['bar']['gold']] = 2,
        }
    },
    ['Cindercloth Cloak'] = {
        skill = 275,
        description = '[BoE] (Back) AC: 36, Int: 8, MinLvl: 50, Equip: Increases damage done by Fire spells and effects by up to 9.',
        type = 'Cloth',
        source = 'Drop:Pattern: Cindercloth Cloak',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 5,
            [ReagentData['element']['essenceoffire']] = 1,
        }
    },
    ['Cloak of Fire'] = {
        skill = 275,
        description = '[BoE] (Back) AC: 39, Sta: 7, FR: 6, MinLvl: 50, Use: Deals 25 Fire damage every 5 sec to all nearby enemies for 15 sec.',
        type = 'Cloth',
        source = 'Drop:Pattern: Cloak of Fire',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 6,
            [ReagentData['element']['essenceoffire']] = 4,
            [ReagentData['element']['heartoffire']] = 4,
            [ReagentData['element']['fire']] = 4,
        }
    },
    ['Enchanted Runecloth Bag'] = {
        skill = 275,
        description = '20 Slot Enchanting Bag',
        type = 'Container',
        source = 'Vendor:Pattern: Enchanted Runecloth Bag',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['bolt']['rune']] = 5,
            [ReagentData['essence']['greatereternal']] = 2,
        }
    },
    ['Cenarion Herb Bag'] = {
        skill = 275,
        description = '20 Slot Herb Bag',
        type = 'Container',
        source = 'Vendor:Pattern: Cenarion Herb Bag',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['bolt']['rune']] = 5,
            [ReagentData['herb']['purplelotus']] = 10,
            [ReagentData['herb']['morrowgrain']] = 8,
        }
    },
    ['Felcloth Pants'] = {
        skill = 275,
        description = '[BoE] (Cloth Legs) AC: 62, Int: 12, MinLvl: 50, Equip: Increases damage done by Shadow spells and effects by up to 18.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Felcloth Pants',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['cloth']['fel']] = 4,
            [ReagentData['bolt']['rune']] = 5,
        }
    },
    ['Ghostweave Vest'] = {
        skill = 275,
        description = '[BoE] (Cloth Chest) AC: 71, Int: 9, MinLvl: 50, Equip: Restores 8 mana every 5 sec.',
        type = 'Cloth',
        source = 'Drop:Pattern: Ghostweave Vest',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['ghost']] = 4,
            [ReagentData['spidersilk']['ironweb']] = 1,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 6,
        }
    },
    ['Runecloth Gloves'] = {
        skill = 275,
        description = '[BoE] (Cloth Hands) AC: 45, Int: 9, Spi: 9, MinLvl: 50, Equip: Increases damage and healing done by magical spells and effects by up to 7.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Runecloth Gloves',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['bolt']['rune']] = 4,
        }
    },
    ['Wizardweave Leggings'] = {
        skill = 275,
        description = '[BoE] (Cloth Legs) AC: 62, AR: 16, FR: 16, MinLvl: 50',
        type = 'Cloth',
        source = 'Drop:Pattern: Wizardweave Leggings',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 6,
            [ReagentData['dust']['dream']] = 1,
        }
    },
    ['Cindercloth Pants'] = {
        skill = 280,
        description = '[BoE] (Cloth Legs) AC: 63, Int: 12, MinLvl: 51, Equip: Increases damage done by Fire spells and effects by up to 18.',
        type = 'Cloth',
        source = 'Drop:Pattern: Cindercloth Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 6,
            [ReagentData['element']['essenceoffire']] = 1,
        }
    },
    ['Frostweave Pants'] = {
        skill = 280,
        description = '[BoE] (Cloth Legs) AC: 63, Spi: 12, MinLvl: 51, Equip: Increases damage done by Frost spells and effects by up to 18.',
        type = 'Cloth',
        source = 'Drop:Pattern: Frostweave Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 6,
            [ReagentData['element']['essenceofwater']] = 1,
        }
    },
    ['Mooncloth Boots'] = {
        skill = 280,
        description = '[BoE] (Cloth Feet) AC: 55, Sta: 11, Int: 14, Spi: 13, MinLvl: 51',
        type = 'Cloth',
        source = 'Quest:Sacred Cloth',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['cloth']['moon']] = 4,
            [ReagentData['bolt']['rune']] = 6,
            [ReagentData['pearl']['black']] = 2,
        }
    },
    ['Runecloth Boots'] = {
        skill = 280,
        description = '[BoE] (Cloth Feet) AC: 50, Int: 9, Spi: 14, MinLvl: 51',
        type = 'Cloth',
        source = 'Vendor:Pattern: Runecloth Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 2,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['bolt']['rune']] = 4,
        }
    },
    ['Felcloth Boots'] = {
        skill = 285,
        description = '[BoE] (Cloth Feet) AC: 51, Spi: 12, MinLvl: 52, Equip: Increases damage done by Fire spells and effects by up to 12.',
        type = 'Cloth',
        source = 'Drop:Pattern: Felcloth Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['cloth']['fel']] = 4,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['bolt']['rune']] = 6,
        }
    },
    ['Robe of Winter Night'] = {
        skill = 285,
        description = '[BoE] (Cloth Chest) AC: 81, Int: 12, MinLvl: 52, Equip: Increases damage done by Shadow spells and effects by up to 38., Equip: Increases damage done by Frost spells and effects by up to 38.',
        type = 'Cloth',
        source = 'Drop:Pattern: Robe of Winter Night',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['cloth']['fel']] = 12,
            [ReagentData['element']['essenceofundeath']] = 4,
            [ReagentData['bolt']['rune']] = 10,
            [ReagentData['element']['essenceofwater']] = 4,
        }
    },
    ['Runecloth Pants'] = {
        skill = 285,
        description = '[BoE] (Cloth Legs) AC: 65, Int: 12, Spi: 20, MinLvl: 52',
        type = 'Cloth',
        source = 'Drop:Pattern: Runecloth Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 2,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 6,
        }
    },
    ['Brightcloth Pants'] = {
        skill = 290,
        description = '[BoE] (Cloth Legs) AC: 66, CR: 17, SR: 16, MinLvl: 53',
        type = 'Cloth',
        source = 'Drop:Pattern: Brightcloth Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 1,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 6,
            [ReagentData['bar']['gold']] = 4,
        }
    },
    ['Felcloth Hood'] = {
        skill = 290,
        description = '[BoE] (Cloth Head) AC: 61, Int: 10, MinLvl: 53, Equip: Increases damage done by Shadow spells and effects by up to 24.',
        type = 'Cloth',
        source = 'Drop:Pattern: Felcloth Hood',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['cloth']['fel']] = 4,
            [ReagentData['bolt']['rune']] = 5,
        }
    },
    ['Ghostweave Pants'] = {
        skill = 290,
        description = '[BoE] (Cloth Legs) AC: 66, Int: 12, MinLvl: 53, Equip: Restores 8 mana every 5 sec.',
        type = 'Cloth',
        source = 'Drop:Pattern: Ghostweave Pants',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['dye']['ghost']] = 4,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 6,
        }
    },
    ['Mooncloth Leggings'] = {
        skill = 290,
        description = '[BoE] (Cloth Legs) AC: 72, Sta: 12, Int: 14, Spi: 21, MinLvl: 53',
        type = 'Cloth',
        source = 'Drop:Pattern: Mooncloth Leggings',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['cloth']['moon']] = 4,
            [ReagentData['bolt']['rune']] = 6,
        }
    },
    ['Runecloth Headband'] = {
        skill = 295,
        description = '[BoE] (Cloth Head) AC: 62, Int: 20, Spi: 13, MinLvl: 54',
        type = 'Cloth',
        source = 'Drop:Pattern: Runecloth Headband',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 2,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 4,
        }
    },
    ['Belt of the Archmage'] = {
        skill = 300,
        description = '[BoE] (Cloth Waist) AC: 54, Sta: 10, Int: 25, MinLvl: 57, Equip: Improves your chance to get a critical strike with spells by 1%.',
        type = 'Cloth',
        source = 'Drop:Pattern: Belt of the Archmage',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['dye']['ghost']] = 10,
            [ReagentData['thread']['rune']] = 6,
            [ReagentData['cloth']['moon']] = 10,
            [ReagentData['bolt']['rune']] = 16,
            [ReagentData['element']['essenceofwater']] = 12,
            [ReagentData['shard']['largebrilliant']] = 6,
            [ReagentData['element']['essenceoffire']] = 12,
        }
    },
    ['Bottomless Bag'] = {
     skill = 300,
     description = '[BoE] 18 Slot Container',
     type = 'Container',
     source = 'Drop:Pattern: Bottomless Bag',
     sourcerarity = 'Rare',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['leather']['core']] = 2,
          [ReagentData['thread']['rune']] = 2,
          [ReagentData['cloth']['moon']] = 12,
          [ReagentData['bolt']['rune']] = 8,
          [ReagentData['shard']['largebrilliant']] = 2,
     }
    },
    ['Cloak of Warding'] = {
        skill = 300,
        description = '[BoE] (Back) AC: 214, MinLvl: 57, Equip: Increased Defense +7',
        type = 'Cloth',
        source = 'Drop:Pattern: Cloak of Warding',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['bolt']['rune']] = 12,
            [ReagentData['monster']['guardianstone']] = 4,
            [ReagentData['bar']['arcanite']] = 1,
        }
    },
    ['Felcloth Gloves'] = {
        skill = 300,
        description = '[BoE] (Cloth Hands) AC: 55, Sta: 9, MinLvl: 57, Equip: Increases damage done by Shadow spells and effects by up to 28.',
        type = 'Cloth',
        source = 'Drop:Pattern: Felcloth Gloves',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['monster']['demonicrune']] = 6,
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['cloth']['fel']] = 20,
            [ReagentData['element']['essenceofundeath']] = 8,
            [ReagentData['bolt']['rune']] = 12,
        }
    },
    ['Felcloth Robe'] = {
        skill = 300,
        description = '[BoE] (Cloth Chest) AC: 79, Sta: 7, MinLvl: 56, Equip: Increases damage done by Shadow spells and effects by up to 32.',
        type = 'Cloth',
        source = 'Drop:Pattern: Felcloth Robe',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['monster']['demonicrune']] = 4,
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['cloth']['fel']] = 8,
            [ReagentData['bolt']['rune']] = 8,
        }
    },
    ['Felcloth Shoulders'] = {
        skill = 300,
        description = '[BoE] (Cloth Shoulder) AC: 60, Spi: 5, MinLvl: 57, Equip: Increases damage done by Shadow spells and effects by up to 18.',
        type = 'Cloth',
        source = 'Drop:Pattern: Felcloth Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['monster']['demonicrune']] = 4,
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['cloth']['fel']] = 6,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['bolt']['rune']] = 7,
        }
    },
    ['Flarecore Gloves'] = {
        skill = 300,
        description = '[BoP] (Cloth Hands) AC: 60, Sta: 10, Int: 14, FR: 25, MinLvl: 57, Classes: Priest, Mage, Warlock',
        type = 'Cloth',
        source = 'Vendor:Pattern: Flarecore Gloves',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['monster']['fierycore']] = 6,
            [ReagentData['bolt']['rune']] = 8,
            [ReagentData['element']['essenceoffire']] = 4,
            [ReagentData['leather']['enchanted']] = 2,
        }
    },
    ['Flarecore Mantle'] = {
        skill = 300,
        description = '[BoE] (Cloth Shoulder) AC: 71, Sta: 9, Int: 10, Spi: 10, FR: 24, MinLvl: 56',
        type = 'Cloth',
        source = 'Vendor:Pattern: Flarecore Mantle',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['monster']['fierycore']] = 4,
            [ReagentData['bolt']['rune']] = 12,
            [ReagentData['monster']['lavacore']] = 4,
            [ReagentData['leather']['enchanted']] = 6,
        }
    },
    ['Flarecore Wraps'] = {
        skill = 300,
        description = '[BoE] (Cloth Wrist) AC: 43, Int: 8, FR: 7, MinLvl: 60, Equip: Restores 9 mana every 5 sec.',
        type = 'Cloth',
        source = 'Drop:Pattern: Flarecore Wraps',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['thread']['rune']] = 4,
            [ReagentData['cloth']['moon']] = 6,
            [ReagentData['monster']['fierycore']] = 8,
            [ReagentData['element']['essenceoffire']] = 2,
            [ReagentData['leather']['enchanted']] = 6,
        }
    },
    ['Gloves of Spell Mastery'] = {
        skill = 300,
        description = '[BoE] (Cloth Hands) AC: 60, Int: 10, Spi: 8, MinLvl: 57, Classes: Priest, Mage, Warlock, Equip: Improves your chance to get a critical strike with spells by 2%.',
        type = 'Cloth',
        source = 'Drop:Pattern: Gloves of Spell Mastery',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['dye']['ghost']] = 10,
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['cloth']['moon']] = 10,
            [ReagentData['pearl']['golden']] = 6,
            [ReagentData['gem']['hugeemerald']] = 6,
            [ReagentData['bolt']['rune']] = 10,
            [ReagentData['leather']['enchanted']] = 8,
        }
    },
    ['Inferno Gloves'] = {
        skill = 300,
        description = '[BoE] (Cloth Hands) AC: 55, Int: 9, MinLvl: 57, Equip: Increases damage done by Fire spells and effects by up to 28.',
        type = 'Cloth',
        source = 'Drop:Pattern: Inferno Gloves',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['gem']['starruby']] = 2,
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['bolt']['rune']] = 12,
            [ReagentData['element']['essenceoffire']] = 10,
        }
    },
    ['Mooncloth Bag'] = {
        skill = 300,
        description = '16 Slot Container',
        type = 'Container',
        source = 'Drop:Pattern: Mooncloth Bag',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['cloth']['moon']] = 1,
            [ReagentData['bolt']['rune']] = 4,
        }
    },
    ['Big Bag of Enchantment'] = {
        skill = 300,
        description = '24 Slot Enchanting Bag',
        type = 'Container',
        source = 'Drop:Pattern: Big Bag of Enchantment',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 4,
            [ReagentData['bolt']['rune']] = 6,
            [ReagentData['leather']['enchanted']] = 4,
            [ReagentData['shard']['largebrilliant']] = 4,
        }
    },
    ['Satchel of Cenarius'] = {
        skill = 300,
        description = '24 Slot Herb Bag',
        type = 'Container',
        source = 'Vendor:Pattern: Satchel of Cenarius',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 4,
            [ReagentData['bolt']['rune']] = 6,
            [ReagentData['herb']['blacklotus']] = 1,
            [ReagentData['cloth']['moon']] = 8,
        }
    },
    ['Mooncloth Circlet'] = {
        skill = 300,
        description = '[BoE] (Cloth Head) AC: 71, Sta: 13, Int: 23, Spi: 15, MinLvl: 57',
        type = 'Cloth',
        source = 'Drop:Pattern: Mooncloth Circlet',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['cloth']['moon']] = 6,
            [ReagentData['bolt']['rune']] = 4,
            [ReagentData['gem']['azerothiandiamond']] = 1,
            [ReagentData['leather']['enchanted']] = 2,
        }
    },
    ['Mooncloth Gloves'] = {
        skill = 300,
        description = '[BoE] (Cloth Hands) AC: 55, Sta: 9, Int: 16, Spi: 15, MinLvl: 57',
        type = 'Cloth',
        source = 'Drop:Pattern: Mooncloth Gloves',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['cloth']['moon']] = 6,
            [ReagentData['pearl']['golden']] = 2,
            [ReagentData['bolt']['rune']] = 12,
        }
    },
    ['Mooncloth Robe'] = {
        skill = 300,
        description = '[BoE] (Cloth Chest) AC: 87, Sta: 12, Int: 25, Spi: 12, MinLvl: 56',
        type = 'Cloth',
        source = 'Vendor:Pattern: Mooncloth Robe',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['cloth']['moon']] = 4,
            [ReagentData['pearl']['golden']] = 2,
            [ReagentData['bolt']['rune']] = 6,
        }
    },
    ['Mooncloth Shoulders'] = {
        skill = 300,
        description = '[BoE] (Cloth Shoulder) AC: 65, Sta: 9, Int: 17, Spi: 11, MinLvl: 56',
        type = 'Cloth',
        source = 'Drop:Pattern: Mooncloth Shoulders',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['cloth']['moon']] = 5,
            [ReagentData['bolt']['rune']] = 5,
        }
    },
    ['Mooncloth Vest'] = {
        skill = 300,
        description = '[BoE] (Cloth Chest) AC: 85, Sta: 12, Int: 20, Spi: 19, MinLvl: 55',
        type = 'Cloth',
        source = 'Drop:Pattern: Mooncloth Vest',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['cloth']['moon']] = 4,
            [ReagentData['bolt']['rune']] = 6,
        }
    },
    ['Robe of the Archmage'] = {
        skill = 300,
        description = '[BoP] (Cloth Chest) AC: 96, Int: 12, MinLvl: 57, Classes: Mage, Equip: Increases damage and healing done by magical spells and effects by up to 35., Equip: Improves your chance to get a critical strike with spells by 1%., Use: Restores 375 to 625',
        type = 'Cloth',
        source = 'Drop:Pattern: Robe of the Archmage',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['element']['essenceofearth']] = 10,
            [ReagentData['bolt']['rune']] = 12,
            [ReagentData['element']['essenceofwater']] = 10,
            [ReagentData['element']['essenceofair']] = 10,
            [ReagentData['element']['essenceoffire']] = 10,
        }
    },
    ['Robe of the Void'] = {
        skill = 300,
        description = '[BoP] (Cloth Chest) AC: 96, Sta: 14, MinLvl: 57, Classes: Warlock, Equip: Increases damage done by Shadow spells and effects by up to 48., Use: Heal your pet for 300 to 500.',
        type = 'Cloth',
        source = 'Drop:Pattern: Robe of the Void',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['demonicrune']] = 20,
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['cloth']['fel']] = 40,
            [ReagentData['element']['essenceofundeath']] = 12,
            [ReagentData['bolt']['rune']] = 12,
            [ReagentData['element']['essenceoffire']] = 12,
        }
    },
    ['Runecloth Shoulders'] = {
        skill = 300,
        description = '[BoE] (Cloth Shoulder) AC: 59, Int: 15, Spi: 10, MinLvl: 56',
        type = 'Cloth',
        source = 'Drop:Pattern: Runecloth Shoulders',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 2,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['bolt']['rune']] = 7,
        }
    },
    ['Truefaith Vestments'] = {
        skill = 300,
        description = '[BoP] (Cloth Chest) AC: 96, Sta: 14, MinLvl: 57, Classes: Priest, Equip: Increases healing done by spells and effects by up to 66., Equip: Restores 6 mana every 5 sec., Equip: Reduces the cooldown of your Fade ability by 2 sec.',
        type = 'Cloth',
        source = 'Drop:Pattern: Truefaith Vestments',
        sourcerarity = 'Epic',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['monster']['righteousorb']] = 4,
            [ReagentData['dye']['ghost']] = 10,
            [ReagentData['thread']['rune']] = 2,
            [ReagentData['cloth']['moon']] = 10,
            [ReagentData['pearl']['golden']] = 4,
            [ReagentData['bolt']['rune']] = 12,
        }
    },
    ['Wizardweave Robe'] = {
        skill = 300,
        description = '[BoE] (Cloth Chest) AC: 77, AR: 17, FR: 18, MinLvl: 55',
        type = 'Cloth',
        source = 'Drop:Pattern: Wizardweave Robe',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 8,
            [ReagentData['dust']['dream']] = 2,
        }
    },
    ['Wizardweave Turban'] = {
        skill = 300,
        description = '[BoE] (Cloth Head) AC: 64, AR: 18, FR: 18, MinLvl: 56',
        type = 'Cloth',
        source = 'Drop:Pattern: Wizardweave Turban',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 1,
            [ReagentData['thread']['rune']] = 1,
            [ReagentData['bolt']['rune']] = 6,
            [ReagentData['dust']['dream']] = 4,
        }
    },
--~     ['Boots of Darkness'] = {
--~         type = 'Cloth',
--~         source = 'Unknown',
--~         result = 1,
--~         resultrarity = 'Uncommon',
--~         reagents = {
--~             [ReagentData['bolt']['silk']] = 3,
--~             [ReagentData['potion']['shadowprotection']] = 1,
--~             [ReagentData['thread']['fine']] = 2,
--~             [ReagentData['leather']['medium']] = 2,
--~         }
--~     },
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
    ['Argent Boots'] = {
        skill = 290,
        description = '[BoE] (Cloth Feet) AC: 57, Sta: 21, Spi: 7, SR: 4, MinLvl: 53',
        type = 'Cloth',
        source = 'Vendor:Pattern: Argent Boots',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bolt']['rune']] = 6,
            [ReagentData['leather']['enchanted']] = 4,
            [ReagentData['pearl']['golden']] = 2,
            [ReagentData['monster']['guardianstone']] = 2,
            [ReagentData['spidersilk']['ironweb']] = 2,
        },
    },
    ['Flarecore Leggings'] = {
        skill = 300,
        description = '[BoE] (Cloth Legs) AC: 94, Sta: 21, FR: 16, MinLvl: 60, Passive: Increases damage and healing done by magical spells and effects by up to 43.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Flarecore Leggings',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['cloth']['moon']] = 8,
            [ReagentData['monster']['fierycore']] = 5,
            [ReagentData['monster']['lavacore']] = 3,
            [ReagentData['element']['essenceoffire']] = 10,
            [ReagentData['spidersilk']['ironweb']] = 4,
        },
    },
    ['Wisdom of the Timbermaw'] = {
        skill = 290,
        description = '[BoE] (Cloth Waist) AC: 46, Int: 21, MinLvl: 53, Passive: Restores 4 mana every 5 sec.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Wisdom of the Timbermaw',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bolt']['rune']] = 8,
            [ReagentData['element']['essenceofearth']] = 3,
            [ReagentData['element']['livingessence']] = 3,
            [ReagentData['spidersilk']['ironweb']] = 2,
        },
    },
    ['Mantle of the Timbermaw'] = {
        skill = 300,
        description = '[BoE] (Cloth Shoulder) AC: 68, Int: 21, MinLvl: 59, Passive: Restores 6 mana every 5 sec.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Mantle of the Timbermaw',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['cloth']['moon']] = 5,
            [ReagentData['element']['essenceofearth']] = 5,
            [ReagentData['element']['livingessence']] = 5,
            [ReagentData['spidersilk']['ironweb']] = 2,
        },
    },
    ['Argent Shoulders'] = {
        skill = 300,
        description = '[BoE] (Cloth Shoulder) AC: 68, Sta: 23, Spi: 8, SR: 5, MinLvl: 59',
        type = 'Cloth',
        source = 'Vendor:Pattern: Argent Shoulders',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['cloth']['moon']] = 5,
            [ReagentData['monster']['righteousorb']] = 1,
            [ReagentData['monster']['guardianstone']] = 2,
            [ReagentData['spidersilk']['ironweb']] = 2,
        },
    },
    ['Flarecore Robe'] = {
        skill = 300,
        description = '[BoE] (Cloth Chest) AC: 102, Sta: 35, FR: 15, MinLvl: 60, Passive: Increases damage and healing done by magical spells and effects by up to 23.',
        type = 'Cloth',
        source = 'Vendor:Pattern: Flarecore Robe',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['cloth']['moon']] = 10,
            [ReagentData['monster']['fierycore']] = 2,
            [ReagentData['monster']['lavacore']] = 3,
            [ReagentData['element']['essenceoffire']] = 6,
            [ReagentData['spidersilk']['ironweb']] = 4,
        },
    },
    ['Bloodvine Vest'] = {
     skill = 300,
     description = '[BoE] (Cloth Chest) AC: 92, Int: 13, MinLvl: 60, Passive: Improves your chance to hit with spells by 2%., Passive: Increases damage and healing done by magical spells and effects by up to 27.',
     type = 'Cloth',
     source = 'Vendor:Pattern: Bloodvine Vest',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['cloth']['moon']] = 3,
          [ReagentData['herb']['bloodvine']] = 5,
          [ReagentData['monster']['powerfulmojo']] = 4,
          [ReagentData['bolt']['rune']] = 4,
          [ReagentData['spidersilk']['ironweb']] = 2,
     },
    },
    ['Bloodvine Leggings'] = {
     skill = 300,
     description = '[BoE] (Cloth Legs) AC: 80, Int: 6, MinLvl: 60, Passive: Improves your chance to hit with spells by 1%., Passive: Increases damage and healing done by magical spells and effects by up to 37.',
     type = 'Cloth',
     source = 'Vendor:Pattern: Bloodvine Leggings',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['cloth']['moon']] = 4,
          [ReagentData['herb']['bloodvine']] = 4,
          [ReagentData['monster']['powerfulmojo']] = 4,
          [ReagentData['bolt']['rune']] = 4,
          [ReagentData['spidersilk']['ironweb']] = 2,
     },
    },
    ['Bloodvine Boots'] = {
     skill = 300,
     description = '[BoE] (Cloth Feet) AC: 63, Int: 16, MinLvl: 60, Passive: Improves your chance to hit with spells by 1%., Passive: Increases damage and healing done by magical spells and effects by up to 19.',
     type = 'Cloth',
     source = 'Vendor:Pattern: Bloodvine Boots',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['cloth']['moon']] = 3,
          [ReagentData['herb']['bloodvine']] = 3,
          [ReagentData['leather']['enchanted']] = 4,
          [ReagentData['bolt']['rune']] = 4,
          [ReagentData['spidersilk']['ironweb']] = 4,
     },
    },
    ['Runed Stygian Leggings'] = {
     skill = 300,
     description = '[BoE] (Cloth Legs) AC: 78, Sta: 13, SR: 25, MinLvl: 58, Equip: Restores 6 mana every 5 sec.',
     type = 'Cloth',
     source = 'Drop:Pattern: Runed Stygian Leggings',
     sourcerarity = 'Rare',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['bolt']['rune']] = 6,
          [ReagentData['cloth']['fel']] = 6,
          [ReagentData['monster']['darkrune']] = 8,
          [ReagentData['spidersilk']['ironweb']] = 2,
     },
    },
    ['Runed Stygian Belt'] = {
     skill = 300,
     description = '[BoE] (Cloth Waist) AC: 50, Sta: 10, SR: 20, MinLvl: 58, Equip: Restores 3 mana every 5 sec.',
     type = 'Cloth',
     source = 'Drop:Pattern: Runed Stygian Belt',
     sourcerarity = 'Rare',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['bolt']['rune']] = 2,
          [ReagentData['cloth']['fel']] = 2,
          [ReagentData['monster']['darkrune']] = 6,
          [ReagentData['leather']['enchanted']] = 2,
          [ReagentData['spidersilk']['ironweb']] = 2,
     },
    },
    ['Runed Stygian Boots'] = {
     skill = 300,
     description = '[BoE] (Cloth Feet) AC: 61, Sta: 8, SR: 20, MinLvl: 58, Equip: Restores 4 mana every 5 sec.',
     type = 'Cloth',
     source = 'Drop:Pattern: Runed Stygian Boots',
     sourcerarity = 'Rare',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['bolt']['rune']] = 4,
          [ReagentData['monster']['darkrune']] = 6,
          [ReagentData['cloth']['fel']] = 4,
          [ReagentData['leather']['enchanted']] = 2,
          [ReagentData['spidersilk']['ironweb']] = 2,
     },
    },
    ['Soul Bag'] = {
     skill = 260,
     description = '20 Slot Shard Bag',
     type = 'Container',
     source = 'Vendor:Pattern: Soul Bag',
     result = 1,
     resultrarity = 'Uncommon',
     reagents = {
          [ReagentData['element']['ichorofundeath']] = 2,
          [ReagentData['bolt']['rune']] = 6,
          [ReagentData['leather']['rugged']] = 4,
          [ReagentData['thread']['rune']] = 1,
     },
    },
    ['Felcloth Bag'] = {
     skill = 285,
     description = '24 Slot Shard Bag',
     type = 'Container',
     source = 'Quest:Scholomance Book',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['monster']['darkrune']] = 2,
          [ReagentData['cloth']['fel']] = 12,
          [ReagentData['leather']['enchanted']] = 6,
          [ReagentData['spidersilk']['ironweb']] = 4,
     },
    },
    ['Core Felcloth Bag'] = {
     skill = 300,
     description = '28 Slot Shard Bag',
     type = 'Container',
     source = 'Drop:Pattern: Core Felcloth Bag',
    sourcerarity = 'Rare',
     result = 1,
     resultrarity = 'Epic',
     reagents = {
          [ReagentData['element']['essenceoffire']] = 4,
          [ReagentData['herb']['bloodvine']] = 8,
          [ReagentData['cloth']['fel']] = 20,
          [ReagentData['leather']['core']] = 16,
          [ReagentData['spidersilk']['ironweb']] = 4,
     },
    },
    ['Sylvan Crown'] = {
     skill = 300,
     description = '[BOE] (Cloth Head) AC: 80, Sta: 10, NR: 30, MinLvl: 60, Equip: Increases damage and healing done by magical spells and effects by up to 18.',
     type = 'Cloth',
     source = 'Vendor:Pattern: Sylvan Crown',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['element']['livingessence']] = 2,
          [ReagentData['bolt']['rune']] = 4,
          [ReagentData['cloth']['moon']] = 2,
          [ReagentData['spidersilk']['ironweb']] = 2,
     },
    },
    ['Sylvan Shoulders'] = {
     skill = 300,
     description = '[BOE] (Cloth Shoulders) AC: 74, Sta: 18, NR: 20, MinLvl: 60, Equip: Increases damage and healing done by magical spells and effects by up to 7.',
     type = 'Cloth',
     source = 'Vendor:Pattern: Sylvan Shoulders',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['element']['livingessence']] = 4,
          [ReagentData['bolt']['rune']] = 2,
          [ReagentData['spidersilk']['ironweb']] = 2,
     },
    },
    ['Sylvan Vest'] = {
     skill = 300,
     description = '[BOE] (Cloth Head) AC: 98, Sta: 15, NR: 30, MinLvl: 60, Equip: Increases damage and healing done by magical spells and effects by up to 12.',
     type = 'Cloth',
     source = 'Vendor:Pattern: Sylvan Vest',
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['element']['livingessence']] = 2,
          [ReagentData['bolt']['rune']] = 4,
          [ReagentData['herb']['bloodvine']] = 2,
          [ReagentData['spidersilk']['ironweb']] = 2,
     },
    },
    ["Gaea\'s Embrace"] = {
     skill = 300,
     description = '[BOE] (Cloth Back) AC: 49, Sta: 6, NR: 20, MinLvl: 60',
     type = 'Cloth',
     source = "Vendor:Pattern: Gaea\'s Embrace",
     result = 1,
     resultrarity = 'Rare',
     reagents = {
          [ReagentData['element']['livingessence']] = 4,
          [ReagentData['herb']['bloodvine']] = 1,
          [ReagentData['cloth']['moon']] = 2,
          [ReagentData['spidersilk']['ironweb']] = 4,
     },
    },
    ["Glacial Wrists"] = {
     skill = 300,
     description = '[BOE] (Cloth Wrist) AC: 53, Sta: 20, CR: 20, MinLvl: 60, Equip: Increases damage and healing done by magical spells and effects by up to 12.',
     type = 'Cloth',
     source = "Vendor:Pattern: Glacial Wrists",
     result = 1,
     resultrarity = 'Epic',
     reagents = {
          [ReagentData['other']['frozenrune']] = 4,
          [ReagentData['element']['essenceofwater']] = 2,
          [ReagentData['bolt']['rune']] = 2,
          [ReagentData['spidersilk']['ironweb']] = 4,
     },
    },
    ["Glacial Gloves"] = {
     skill = 300,
     description = '[BOE] (Cloth Hands) AC: 76, Sta: 22, CR: 30, MinLvl: 60, Equip: Increases damage and healing done by magical spells and effects by up to 15.',
     type = 'Cloth',
     source = "Vendor:Pattern: Glacial Gloves",
     result = 1,
     resultrarity = 'Epic',
     reagents = {
          [ReagentData['other']['frozenrune']] = 5,
          [ReagentData['element']['essenceofwater']] = 4,
          [ReagentData['bolt']['rune']] = 4,
          [ReagentData['spidersilk']['ironweb']] = 4,
     },
    },
    ["Glacial Vest"] = {
     skill = 300,
     description = '[BOE] (Cloth Chest) AC: 121, Sta: 26, CR: 40, MinLvl: 60, Equip: Increases damage and healing done by magical spells and effects by up to 21.',
     type = 'Cloth',
     source = "Vendor:Pattern: Glacial Vest",
     result = 1,
     resultrarity = 'Epic',
     reagents = {
          [ReagentData['other']['frozenrune']] = 7,
          [ReagentData['element']['essenceofwater']] = 6,
          [ReagentData['bolt']['rune']] = 8,
          [ReagentData['spidersilk']['ironweb']] = 8,
     },
    },
    ["Glacial Cloak"] = {
     skill = 300,
     description = '[BOE] (Cloth Back) AC: 61, Sta: 18, CR: 24, MinLvl: 60',
     type = 'Cloth',
     source = "Vendor:Pattern: Glacial Cloak",
     result = 1,
     resultrarity = 'Epic',
     reagents = {
          [ReagentData['other']['frozenrune']] = 5,
          [ReagentData['element']['essenceofwater']] = 2,
          [ReagentData['bolt']['rune']] = 4,
          [ReagentData['spidersilk']['ironweb']] = 4,
     },
    },
}
end