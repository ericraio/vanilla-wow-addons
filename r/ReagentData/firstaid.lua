function ReagentData_LoadFirstAid()
ReagentData['crafted']['firstaid'] = {
    ['Linen Bandage'] = {
        skill = 1,
        description = 'Requires First Aid (1), Use: Heals 66 damage over 6 sec.',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['linen']] = 1,
        }
    },
    ['Heavy Linen Bandage'] = {
        skill = 40,
        description = 'Requires First Aid (20), Use: Heals 114 damage over 6 sec.',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['linen']] = 2,
        }
    },
    ['Anti-Venom'] = {
        skill = 80,
        description = 'Use: Target is cured of poisons up to level 25.',
        type = 'Reagent',
        source = 'Trainer',
        result = 3,
        reagents = {
            [ReagentData['monster']['smallvenomsac']] = 1,
        }
    },
    ['Wool Bandage'] = {
        skill = 80,
        description = 'Requires First Aid (50), Use: Heals 161 damage over 7 sec.',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['wool']] = 1,
        }
    },
    ['Heavy Wool Bandage'] = {
        skill = 115,
        description = 'Requires First Aid (75), Use: Heals 301 damage over 7 sec.',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['wool']] = 2,
        }
    },
    ['Strong Anti-Venom'] = {
        skill = 130,
        description = 'Use: Target is cured of poisons up to level 35.',
        type = 'Reagent',
        source = 'Drop:Manual: Strong Anti-Venom',
        sourcerarity = 'Uncommon',
        result = 3,
        reagents = {
            [ReagentData['monster']['largevenomsac']] = 1,
        }
    },
    ['Silk Bandage'] = {
        skill = 150,
        description = 'Requires First Aid (100), Use: Heals 400 damage over 8 sec.',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['silk']] = 1,
        }
    },
    ['Heavy Silk Bandage'] = {
        skill = 180,
        description = 'Requires First Aid (125), Use: Heals 640 damage over 8 sec.',
        type = 'Reagent',
        source = 'Vendor:Manual: Heavy Silk Bandage',
        result = 1,
        reagents = {
            [ReagentData['cloth']['silk']] = 2,
        }
    },
    ['Mageweave Bandage'] = {
        skill = 210,
        description = 'Requires First Aid (150), Use: Heals 800 damage over 8 sec.',
        type = 'Reagent',
        source = 'Vendor:Manual: Mageweave Bandage',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['cloth']['mageweave']] = 1,
        }
    },
    ['Heavy Mageweave Bandage'] = {
        skill = 240,
        description = 'Requires First Aid (175), Use: Heals 1104 damage over 8 sec.',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['mageweave']] = 2,
        }
    },
    ['Runecloth Bandage'] = {
        skill = 260,
        description = 'Requires First Aid (200), Use: Heals 1360 damage over 8 sec.',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['rune']] = 1,
        }
    },
    ['Heavy Runecloth Bandage'] = {
        skill = 290,
        description = 'Requires First Aid (225), Use: Heals 2000 damage over 8 sec.',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['rune']] = 2,
        }
    },
    ['Powerful Anti-Venom'] = {
        skill = 300,
        description = 'Use: Target is cured of poisons up to level 60.',
        type = 'Reagent',
        source = 'Vendor:Formula: Powerful Anti-Venom',
        result = 1,
        reagents = {
            [ReagentData['monster']['hugevenomsac']] = 1,
        }
    },
}
end