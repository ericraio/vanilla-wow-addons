function ReagentData_LoadAlchemy()
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
    ['Elixir of Minor Defense'] = {
        skill = 1,
        description = 'Use: Increases armor by 50 for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['silverleaf']] = 2,
        }
    },
    ['Minor Healing Potion'] = {
        skill = 1,
        description = 'Use: Restores 70 to 90 health.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['peacebloom']] = 1,
            [ReagentData['herb']['silverleaf']] = 1,
        }
    },
    ['Weak Troll\'s Blood Potion'] = {
        skill = 15,
        description = 'Use: Regenerate 2 health every 5 sec for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['earthroot']] = 2,
            [ReagentData['herb']['peacebloom']] = 1,
        }
    },
    ['Minor Mana Potion'] = {
        skill = 25,
        description = 'MinLvl: 5, Use: Restores 140 to 180 mana.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['mageroyal']] = 1,
            [ReagentData['herb']['silverleaf']] = 1,
        }
    },
    ['Minor Rejuvenation Potion'] = {
        skill = 40,
        description = 'MinLvl: 5, Use: Restores 90 to 150 mana and 90 to 150 health.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['peacebloom']] = 1,
            [ReagentData['herb']['mageroyal']] = 2,
        }
    },
    ['Discolored Healing Potion'] = {
        skill = 50,
        description = 'MinLvl: 5, Use: Restores 140 to 180 health.',
        source = 'Quest:Recipe: Discolored Healing Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['peacebloom']] = 1,
            [ReagentData['monster']['discoloredworgheart']] = 1,
        }
    },
    ['Elixir of Minor Agility'] = {
        skill = 50,
        description = 'MinLvl: 2, Use: Increases Agility by 4 for 1 hour.',
        source = 'Drop:Recipe: Elixir of Minor Agility',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['swifthistle']] = 1,
            [ReagentData['herb']['silverleaf']] = 1,
        }
    },
    ['Elixir of Minor Fortitude'] = {
        skill = 50,
        description = 'MinLvl: 2, Use: Increases the player\'s maximum health by 27 for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['earthroot']] = 2,
            [ReagentData['herb']['peacebloom']] = 1,
        }
    },
    ['Lesser Healing Potion'] = {
        skill = 55,
        description = 'MinLvl: 3, Use: Restores 140 to 180 health.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['briarthorn']] = 1,
            [ReagentData['potion']['minorhealing']] = 1,
        }
    },
    ['Rage Potion'] = {
        skill = 60,
        description = 'MinLvl: 4, Classes: Warrior, Use: Increases Rage by 20 to 40.',
        source = 'Vendor:Recipe: Rage Potion',
        result = 1,
        reagents = {
            [ReagentData['herb']['briarthorn']] = 1,
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['monster']['sharpclaw']] = 1,
        }
    },
    ['Swiftness Potion'] = {
        skill = 60,
        description = 'MinLvl: 5, Use: Increases run speed by 50% for 15 sec.',
        source = 'Drop:Recipe: Swiftness Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['briarthorn']] = 1,
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['swifthistle']] = 1,
        }
    },
    ['Blackmouth Oil'] = {
        skill = 80,
        description = 'Blackmouth Oil',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['alchemyfish']['oilyblackmouth']] = 2,
            [ReagentData['vial']['empty']] = 1,
        }
    },
    ['Elixir of Giant Growth'] = {
        skill = 90,
        description = 'MinLvl: 8, Use: Your size is increased and your Strength goes up by 8 to match your new size. Lasts 2 min.',
        source = 'Drop:Recipe: Elixir of Giant Growth',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['earthroot']] = 1,
            [ReagentData['cookingfish']['deviate']] = 1,
        }
    },
    ['Elixir of Water Breathing'] = {
        skill = 90,
        description = 'MinLvl: 8, Use: Allows the Imbiber to breathe water for 30 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['stranglekelp']] = 1,
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['oil']['blackmouth']] = 2,
        }
    },
    ['Elixir of Wisdom'] = {
        skill = 90,
        description = 'MinLvl: 10, Use: Increases Intellect by 6 for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['briarthorn']] = 2,
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['mageroyal']] = 1,
        }
    },
    ['Holy Protection Potion'] = {
        skill = 100,
        description = 'MinLvl: 10, Use: Absorbs 300 to 500 holy damage. Lasts 1 hour.',
        source = 'Vendor:Recipe: Holy Protection Potion',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['bruiseweed']] = 1,
            [ReagentData['herb']['swifthistle']] = 1,
        }
    },
    ['Swim Speed Potion'] = {
        skill = 100,
        description = 'MinLvl: 10, Use: Increases swim speed by 100% for 20 sec.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['swifthistle']] = 1,
            [ReagentData['oil']['blackmouth']] = 1,
        }
    },
    ['Healing Potion'] = {
        skill = 110,
        description = 'MinLvl: 12, Use: Restores 280 to 360 health.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['briarthorn']] = 1,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['bruiseweed']] = 1,
        }
    },
    ['Minor Magic Resistance Potion'] = {
        skill = 110,
        description = 'MinLvl: 12, Use: Increases your resistance to all schools of magic by 25 for 3 min.',
        source = 'Drop:Recipe: Minor Magic Resistance Potion',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['wildsteelbloom']] = 1,
            [ReagentData['herb']['mageroyal']] = 3,
        }
    },
    ['Elixir of Poison Resistance'] = {
        skill = 120,
        description = 'MinLvl: 14, Use: Target is immune to poison for 1 min and is cured of any existing poisons.',
        source = 'Drop:Recipe: Elixir of Poison Resistance',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['bruiseweed']] = 1,
            [ReagentData['monster']['largevenomsac']] = 1,
        }
    },
    ['Lesser Mana Potion'] = {
        skill = 120,
        description = 'MinLvl: 14, Use: Restores 280 to 360 mana.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['stranglekelp']] = 1,
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['herb']['mageroyal']] = 1,
        }
    },
    ['Strong Troll\'s Blood Potion'] = {
        skill = 125,
        description = 'MinLvl: 15, Use: Regenerate 6 health every 5 sec for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['briarthorn']] = 2,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['bruiseweed']] = 2,
        }
    },
    ['Elixir of Defense'] = {
        skill = 130,
        description = 'MinLvl: 16, Use: Increases armor by 150 for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['stranglekelp']] = 1,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['wildsteelbloom']] = 1,
        }
    },
    ['Fire Oil'] = {
        skill = 130,
        description = 'Fire Oil',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['alchemyfish']['firefinsnapper']] = 2,
        }
    },
    ['Shadow Protection Potion'] = {
        skill = 135,
        description = 'MinLvl: 17, Use: Absorbs 675 to 1125 shadow damage. Lasts 1 hour.',
        source = 'Vendor:Recipe: Shadow Protection Potion',
        result = 1,
        reagents = {
            [ReagentData['herb']['kingsblood']] = 1,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['gravemoss']] = 1,
        }
    },
    ['Elixir of Firepower'] = {
        skill = 140,
        description = 'MinLvl: 18, Use: Increases spell fire damage by up to 10 for 30 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['kingsblood']] = 1,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['oil']['fire']] = 2,
        }
    },
    ['Elixir of Lesser Agility'] = {
        skill = 140,
        description = 'MinLvl: 18, Use: Increases Agility by 8 for 1 hour.',
        source = 'Drop:Recipe: Elixir of Lesser Agility',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['wildsteelbloom']] = 1,
            [ReagentData['herb']['swifthistle']] = 1,
        }
    },
    ['Elixir of Ogre\'s Strength'] = {
        skill = 150,
        description = 'MinLvl: 20, Use: Increases Strength by 8 for 1 hour.',
        source = 'Drop:Recipe: Elixir of Ogre\'s Strength',
        result = 1,
        reagents = {
            [ReagentData['herb']['kingsblood']] = 1,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['earthroot']] = 1,
        }
    },
    ['Free Action Potion'] = {
        skill = 150,
        description = 'MinLvl: 20, Use: Makes you immune to stun and movement impairing effects for the next 30 sec.',
        source = 'Vendor:Recipe: Free Action Potion',
        result = 1,
        reagents = {
            [ReagentData['herb']['stranglekelp']] = 1,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['oil']['blackmouth']] = 2,
        }
    },
    ['Greater Healing Potion'] = {
        skill = 155,
        description = 'MinLvl: 21, Use: Restores 455 to 585 health.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['liferoot']] = 1,
            [ReagentData['herb']['kingsblood']] = 1,
            [ReagentData['vial']['leaded']] = 1,
        }
    },
    ['Mana Potion'] = {
        skill = 160,
        description = 'MinLvl: 22, Use: Restores 455 to 585 mana.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['stranglekelp']] = 1,
            [ReagentData['herb']['kingsblood']] = 1,
            [ReagentData['vial']['leaded']] = 1,
        }
    },
    ['Fire Protection Potion'] = {
        skill = 165,
        description = 'MinLvl: 23, Use: Absorbs 975 to 1625 fire damage. Lasts 1 hour.',
        source = 'Vendor:Recipe: Fire Protection Potion',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['oil']['fire']] = 1,
            [ReagentData['monster']['smallflamesac']] = 1,
        }
    },
    ['Lesser Invisibility Potion'] = {
        skill = 165,
        description = 'MinLvl: 23, Use: Gives the imbiber lesser invisibility for 15 sec.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['fadeleaf']] = 1,
            [ReagentData['herb']['wildsteelbloom']] = 1,
        }
    },
    ['Shadow Oil'] = {
        skill = 165,
        description = 'MinLvl: 24, Use: When applied to a melee weapon it gives a 15% chance of casting Shadowbolt III at the opponent when it hits. Lasts 30 minutes.',
        source = 'Vendor:Recipe: Shadow Oil',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['fadeleaf']] = 4,
            [ReagentData['herb']['gravemoss']] = 4,
        }
    },
    ['Elixir of Fortitude'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Increases the player\'s maximum health by 120 for 1 hour.',
        source = 'Drop:Recipe: Elixir of Fortitude',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['goldthorn']] = 1,
            [ReagentData['herb']['wildsteelbloom']] = 1,
        }
    },
    ['Great Rage Potion'] = {
        skill = 175,
        description = 'MinLvl: 25, Classes: Warrior, Use: Increases Rage by 30 to 60.',
        source = 'Vendor:Recipe: Great Rage Potion',
        result = 1,
        reagents = {
            [ReagentData['herb']['kingsblood']] = 1,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['monster']['largefang']] = 1,
        }
    },
    ['Mighty Troll\'s Blood Potion'] = {
        skill = 180,
        description = 'MinLvl: 26, Use: Regenerate 12 health every 5 sec for 1 hour.',
        source = 'Drop:Recipe: Mighty Troll\'s Blood Potion',
        result = 1,
        reagents = {
            [ReagentData['herb']['liferoot']] = 1,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['bruiseweed']] = 1,
        }
    },
    ['Elixir of Agility'] = {
        skill = 185,
        description = 'MinLvl: 27, Use: Increases Agility by 15 for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['stranglekelp']] = 1,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['goldthorn']] = 1,
        }
    },
    ['Elixir of Frost Power'] = {
        skill = 190,
        description = 'MinLvl: 28, Use: Increases spell frost damage by up to 15 for 30 min.',
        source = 'Drop:Recipe: Elixir of Frost Power',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['khadgarswhisker']] = 1,
            [ReagentData['herb']['wintersbite']] = 2,
        }
    },
    ['Frost Protection Potion'] = {
        skill = 190,
        description = 'MinLvl: 28, Use: Absorbs 1350 to 2250 frost damage. Lasts 1 hour.',
        source = 'Vendor:Recipe: Frost Protection Potion',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['goldthorn']] = 1,
            [ReagentData['herb']['wintersbite']] = 1,
        }
    },
    ['Nature Protection Potion'] = {
        skill = 190,
        description = 'MinLvl: 28, Use: Absorbs 1350 to 2250 nature damage. Lasts 1 hour.',
        source = 'Vendor:Recipe: Nature Protection Potion',
        result = 1,
        reagents = {
            [ReagentData['herb']['liferoot']] = 1,
            [ReagentData['herb']['stranglekelp']] = 1,
            [ReagentData['vial']['leaded']] = 1,
        }
    },
    ['Elixir of Detect Lesser Invisibility'] = {
        skill = 195,
        description = 'MinLvl: 29, Use: Grants detect lesser invisibility for 10 min.',
        source = 'Drop:Recipe: Elixir of Detect Lesser Invisibility',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['khadgarswhisker']] = 1,
            [ReagentData['herb']['fadeleaf']] = 1,
        }
    },
    ['Elixir of Greater Defense'] = {
        skill = 195,
        description = 'MinLvl: 29, Use: Increases armor by 250 for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['goldthorn']] = 1,
            [ReagentData['herb']['wildsteelbloom']] = 1,
        }
    },
    ['Catseye Elixir'] = {
        skill = 200,
        description = 'MinLvl: 30, Use: Increases your stealth detection by 10 for 10 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['goldthorn']] = 1,
            [ReagentData['herb']['fadeleaf']] = 1,
        }
    },
    ['Frost Oil'] = {
        skill = 200,
        description = 'MinLvl: 30, Use: When applied to a melee weapon it gives a 10% chance of casting Frostbolt at the opponent when it hits. Lasts 30 minutes.',
        source = 'Vendor:Recipe: Frost Oil',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['khadgarswhisker']] = 4,
            [ReagentData['herb']['wintersbite']] = 2,
        }
    },
    ['Greater Mana Potion'] = {
        skill = 205,
        description = 'MinLvl: 31, Use: Restores 700 to 900 mana.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['khadgarswhisker']] = 1,
            [ReagentData['herb']['goldthorn']] = 1,
        }
    },
    ['Oil of Immolation'] = {
        skill = 205,
        description = 'MinLvl: 31, Use: Does 50 fire damage to any enemies within a 5 yard radius around the caster every 3 seconds for 15 sec',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['goldthorn']] = 1,
            [ReagentData['herb']['firebloom']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Goblin Rocket Fuel'] = {
        skill = 210,
        description = 'Used by Goblin Engineers to power their creations',
        type = 'Reagent',
        source = 'Recipe:Recipe: Goblin Rocket Fuel',
        result = 1,
        reagents = {
            [ReagentData['monster']['volatilerum']] = 1,
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['herb']['firebloom']] = 1,
        }
    },
    ['Magic Resistance Potion'] = {
        skill = 210,
        description = 'MinLvl: 32, Use: Increases your resistance to all schools of magic by 50 for 3 min.',
        source = 'Drop:Recipe: Magic Resistance Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['purplelotus']] = 1,
            [ReagentData['herb']['khadgarswhisker']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Restorative Potion'] = {
        skill = 210,
        description = 'MinLvl: 32, Use: Removes all negative effects on you.',
        source = 'Quest',
        result = 1,
        reagents = {
            [ReagentData['element']['earth']] = 1,
            [ReagentData['herb']['goldthorn']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Elixir of Greater Water Breathing'] = {
        skill = 215,
        description = 'MinLvl: 35, Use: Allows the Imbiber to breathe water for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['purplelotus']] = 2,
            [ReagentData['element']['ichorofundeath']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Lesser Stoneshield Potion'] = {
        skill = 215,
        description = 'MinLvl: 33, Use: Increases armor by 1000 for 1.50 min.',
        source = 'Quest:Recipe: Lesser Stoneshield Potion',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['ore']['mithril']] = 1,
            [ReagentData['herb']['goldthorn']] = 1,
        }
    },
    ['Superior Healing Potion'] = {
        skill = 215,
        description = 'MinLvl: 35, Use: Restores 700 to 900 health.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['sungrass']] = 1,
            [ReagentData['herb']['khadgarswhisker']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Philosophers\' Stone'] = {
        skill = 225,
        description = '[BoP] Required for Alchemical Transmutation.',
        type = 'Trade Goods',
        source = 'Vendor:Recipe: Philosophers\' Stone',
        result = 1,
        reagents = {
            [ReagentData['herb']['purplelotus']] = 4,
            [ReagentData['bar']['iron']] = 4,
            [ReagentData['herb']['firebloom']] = 4,
            [ReagentData['gem']['blackvitriol']] = 1,
        }
    },
    ['Transmute: Iron to Gold'] = {
        skill = 225,
        description = 'Gold Bar',
        type = 'Trade Goods',
        source = 'Vendor:Recipe: Transmute Iron to Gold',
        result = 1,
        resultname = 'Gold Bar',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['iron']] = 1,
        }
    },
    ['Transmute: Mithril to Truesilver'] = {
        skill = 225,
        description = 'Truesilver Bar',
        type = 'Trade Goods',
        source = 'Vendor:Recipe: Transmute Mithril to Truesilver',
        result = 1,
        resultname = 'Truesilver Bar',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['mithril']] = 1,
        }
    },
    ['Wildvine Potion'] = {
        skill = 225,
        description = 'MinLvl: 35, Use: Restores 1 to 1000 health and 1 to 1000 mana.',
        source = 'Drop:Recipe: Wildvine Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['wildvine']] = 1,
            [ReagentData['herb']['purplelotus']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Dreamless Sleep Potion'] = {
        skill = 230,
        description = 'MinLvl: 35, Use: Puts the imbiber in a dreamless sleep for 15 sec. During that time the imbiber heals 1200 health and 1200 mana.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['purplelotus']] = 3,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Elixir of Detect Undead'] = {
        skill = 230,
        description = 'MinLvl: 36, Use: Shows the location of all nearby undead on the minimap for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['arthastears']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Arcane Elixir'] = {
        skill = 235,
        description = 'MinLvl: 37, Use: Increases spell damage by 20 for 30 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['goldthorn']] = 1,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['herb']['blindweed']] = 1,
        }
    },
    ['Elixir of Greater Intellect'] = {
        skill = 235,
        description = 'MinLvl: 37, Use: Increases Intellect by 25 for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['khadgarswhisker']] = 1,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['herb']['blindweed']] = 1,
        }
    },
    ['Invisibility Potion'] = {
        skill = 235,
        description = 'MinLvl: 37, Use: Gives the imbiber invisibility for 18 sec.',
        source = 'Drop:Recipe: Invisibility Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['sungrass']] = 1,
            [ReagentData['herb']['ghostmushroom']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Elixir of Dream Vision'] = {
        skill = 240,
        description = 'MinLvl: 38, Use: Gives you a dream vision that lets you explore areas that are too dangerous to explore in person.',
        source = 'Drop:Recipe: Elixir of Dream Vision',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['purplelotus']] = 3,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Elixir of Greater Agility'] = {
        skill = 240,
        description = 'MinLvl: 38, Use: Increases Agility by 25 for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['sungrass']] = 1,
            [ReagentData['herb']['goldthorn']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Gift of Arthas'] = {
        skill = 240,
        description = 'MinLvl: 38, Use: Increases resistance to shadow by 10. If an enemy strikes the caster, they have a 30% chance of being inflicted with disease that increases their damage taken by 8 for 3 min.',
        source = 'Drop:Recipe: Gift of Arthas',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['arthastears']] = 1,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['herb']['blindweed']] = 1,
        }
    },
    ['Elixir of Giants'] = {
        skill = 245,
        description = 'MinLvl: 38, Use: Increases your Strength by 25 for 1 hour.',
        source = 'Drop:Recipe: Elixir of Giants',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['sungrass']] = 1,
            [ReagentData['herb']['gromsblood']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Ghost Dye'] = {
        skill = 245,
        description = 'Ghost Dye',
        type = 'Trade Goods',
        source = 'Vendor:Recipe: Ghost Dye',
        result = 1,
        reagents = {
            [ReagentData['dye']['purple']] = 1,
            [ReagentData['herb']['ghostmushroom']] = 2,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Elixir of Demonslaying'] = {
        skill = 250,
        description = 'MinLvl: 40, Use: Increases attack power by 265 against demons. Lasts 5 min.',
        source = 'Vendor:Recipe: Elixir of Demonslaying',
        result = 1,
        reagents = {
            [ReagentData['herb']['ghostmushroom']] = 1,
            [ReagentData['herb']['gromsblood']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Elixir of Detect Demon'] = {
        skill = 250,
        description = 'MinLvl: 40, Use: Shows the location of all nearby demons on the minimap for 1 hour.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['herb']['gromsblood']] = 2,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Elixir of Shadow Power'] = {
        skill = 250,
        description = 'MinLvl: 40, Use: Increases spell shadow damage by up to 40 for 30 min.',
        source = 'Vendor:Recipe: Elixir of Shadow Power',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['ghostmushroom']] = 3,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Limited Invulnerability Potion'] = {
        skill = 250,
        description = 'MinLvl: 45, Use: Imbiber is immune to physical attacks for the next 6 sec.',
        source = 'Drop:Recipe: Limited Invulnerability Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['ghostmushroom']] = 1,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['herb']['blindweed']] = 2,
        }
    },
    ['Stonescale Oil'] = {
        skill = 250,
        description = 'Stonescale Oil',
        type = 'Reagent',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['alchemyfish']['stonescaleeel']] = 1,
        }
    },
    ['Mighty Rage Potion'] = {
        skill = 255,
        description = 'MinLvl: 46, Classes: Warrior, Use: Increases Rage by 45 to 75 and increases Strength by 60 for 20 sec.',
        source = 'Drop:Recipe: Mighty Rage Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['gromsblood']] = 3,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Superior Mana Potion'] = {
        skill = 260,
        description = 'MinLvl: 41, Use: Restores 900 to 1500 mana.',
        source = 'Vendor:Recipe: Superior Mana Potion',
        result = 1,
        reagents = {
            [ReagentData['herb']['sungrass']] = 2,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['herb']['blindweed']] = 2,
        }
    },
    ['Elixir of Superior Defense'] = {
        skill = 265,
        description = 'MinLvl: 43, Use: Increases armor by 450 for 1 hour.',
        source = 'Vendor:Recipe: Elixir of Superior Defense',
        result = 1,
        reagents = {
            [ReagentData['herb']['sungrass']] = 1,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['oil']['stonescale']] = 2,
        }
    },
    ['Elixir of the Sages'] = {
        skill = 270,
        description = 'MinLvl: 44, Use: Increases Intellect and Spirit by 18 for 1 hour.',
        source = 'Drop:Recipe: Elixir of the Sages',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['dreamfoil']] = 1,
            [ReagentData['herb']['plaguebloom']] = 2,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Elixir of Brute Force'] = {
        skill = 275,
        description = 'MinLvl: 45, Use: Increases Strength and Stamina by 18 for 1 hour.',
        source = 'Drop:Recipe: Elixir of Brute Force',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['gromsblood']] = 2,
            [ReagentData['herb']['plaguebloom']] = 2,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Major Healing Potion'] = {
        skill = 275,
        description = 'MinLvl: 45, Use: Restores 1050 to 1750 health.',
        source = 'Vendor:Recipe: Major Healing Potion',
        result = 1,
        reagents = {
            [ReagentData['herb']['mountainsilversage']] = 1,
            [ReagentData['herb']['goldensansam']] = 2,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Transmute: Air to Fire'] = {
        skill = 275,
        description = 'Essence of Fire',
        type = 'Reagent',
        source = 'Vendor:Recipe: Transmute Air to Fire',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Essence of Fire',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['essenceofair']] = 1,
        }
    },
    ['Transmute: Arcanite'] = {
        skill = 275,
        description = 'Arcanite Bar',
        type = 'Trade Goods',
        source = 'Vendor:Recipe: Transmute Arcanite',
        result = 1,
        resultname = 'Arcanite Bar',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bar']['thorium']] = 1,
            [ReagentData['gem']['arcanecrystal']] = 1,
        }
    },
    ['Transmute: Earth to Life'] = {
        skill = 275,
        description = 'Living Essence',
        type = 'Reagent',
        source = 'Drop:Recipe: Transmute Earth to Life',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Living Essence',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['essenceofearth']] = 1,
        }
    },
    ['Transmute: Earth to Water'] = {
        skill = 275,
        description = 'Essence of Water',
        type = 'Reagent',
        source = 'Vendor:Recipe: Transmute Earth to Water',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Essence of Water',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['essenceofearth']] = 1,
        }
    },
    ['Transmute: Fire to Earth'] = {
        skill = 275,
        description = 'Essence of Earth',
        type = 'Reagent',
        source = 'Vendor:Recipe: Transmute Fire to Earth',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Essence of Earth',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['essenceoffire']] = 1,
        }
    },
    ['Transmute: Life to Earth'] = {
        skill = 275,
        description = 'Essence of Earth',
        type = 'Reagent',
        source = 'Drop:Recipe: Transmute Life to Earth',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Essence of Earth',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['livingessence']] = 1,
        }
    },
    ['Transmute: Undeath to Water'] = {
        skill = 275,
        description = 'Essence of Water',
        type = 'Reagent',
        source = 'Drop:Recipe: Transmute Undeath to Water',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Essence of Water',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['essenceofundeath']] = 1,
        }
    },
    ['Transmute: Water to Air'] = {
        skill = 275,
        description = 'Essence of Air',
        type = 'Reagent',
        source = 'Vendor:Recipe: Transmute Water to Air',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Essence of Air',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['essenceofwater']] = 1,
        }
    },
    ['Transmute: Water to Undeath'] = {
        skill = 275,
        description = 'Essence of Undeath',
        type = 'Reagent',
        source = 'Drop:Recipe: Transmute Water to Undeath',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Essence of Undeath',
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['essenceofwater']] = 1,
        }
    },
    ['Elixir of the Mongoose'] = {
        skill = 280,
        description = 'MinLvl: 46, Use: Increases Agility by 25 and chance to get a critical hit by 2 for 1 hour.',
        source = 'Drop:Recipe: Elixir of the Mongoose',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['mountainsilversage']] = 2,
            [ReagentData['herb']['plaguebloom']] = 2,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Greater Stoneshield Potion'] = {
        skill = 280,
        description = 'MinLvl: 46, Use: Increases armor by 2000 for 2 min.',
        source = 'Drop:Recipe: Greater Stoneshield Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['oil']['stonescale']] = 3,
            [ReagentData['ore']['thorium']] = 1,
        }
    },
    ['Greater Arcane Elixir'] = {
        skill = 285,
        description = 'MinLvl: 47, Use: Increases spell damage by 35 for 1 hour.',
        source = 'Drop:Recipe: Greater Arcane Elixir',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['dreamfoil']] = 3,
            [ReagentData['herb']['mountainsilversage']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Purification Potion'] = {
        skill = 285,
        description = 'MinLvl: 47, Use: Attempts to remove one Curse, one Disease and one Poison from the Imbiber.',
        source = 'Drop:Recipe: Purification Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['icecap']] = 2,
            [ReagentData['herb']['plaguebloom']] = 2,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Greater Arcane Protection Potion'] = {
        skill = 290,
        description = 'MinLvl: 48, Use: Absorbs 1950 to 3250 arcane damage. Lasts 1 hour.',
        source = 'Drop:Recipe: Greater Arcane Protection Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['dreamfoil']] = 1,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['dust']['dream']] = 1,
        }
    },
    ['Greater Fire Protection Potion'] = {
        skill = 290,
        description = 'MinLvl: 48, Use: Absorbs 1950 to 3250 fire damage. Lasts 1 hour.',
        source = 'Drop:Recipe: Greater Fire Protection Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['dreamfoil']] = 1,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['element']['fire']] = 1,
        }
    },
    ['Greater Frost Protection Potion'] = {
        skill = 290,
        description = 'MinLvl: 48, Use: Absorbs 1950 to 3250 frost damage. Lasts 1 hour.',
        source = 'Drop:Recipe: Greater Frost Protection Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['dreamfoil']] = 1,
            [ReagentData['element']['water']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
--~     ['Greater Holy Protection Potion'] = {
--~         skill = 290,
--~         description = 'MinLvl: 48, Use: Absorbs 1950 to 3250 holy damage. Lasts 1 hour.',
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['herb']['dreamfoil']] = 1,
--~             [ReagentData['element']['air']] = 1,
--~             [ReagentData['vial']['crystal']] = 1,
--~         }
--~     },
    ['Greater Nature Protection Potion'] = {
        skill = 290,
        description = 'MinLvl: 48, Use: Absorbs 1950 to 3250 nature damage. Lasts 1 hour.',
        source = 'Drop:Recipe: Greater Nature Protection Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['element']['earth']] = 1,
            [ReagentData['herb']['dreamfoil']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Greater Shadow Protection Potion'] = {
        skill = 290,
        description = 'MinLvl: 48, Use: Absorbs 1950 to 3250 shadow damage. Lasts 1 hour.',
        source = 'Drop:Recipe: Greater Shadow Protection Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['dreamfoil']] = 1,
            [ReagentData['oil']['shadow']] = 1,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Major Mana Potion'] = {
        skill = 295,
        description = 'MinLvl: 49, Use: Restores 1350 to 2250 mana.',
        source = 'Drop, Vendor:Recipe: Major Mana Potion',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['dreamfoil']] = 3,
            [ReagentData['herb']['icecap']] = 2,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
--~     ['Alchemist\'s Stone'] = {
--~         skill = 300,
--~         description = '[BoP] [U] (Trinket) Spi: 8, Requires Alchemy (300), Passive: Increases the effects that healing and mana potions have on the wearer by 33%.',
--~         type = 'Trade Goods',
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'Alchemists\' Stone',
--~         resultrarity = 'Epic',
--~         reagents = {
--~             [ReagentData['element']['essenceofearth']] = 8,
--~             [ReagentData['element']['essenceofwater']] = 8,
--~             [ReagentData['element']['essenceofair']] = 8,
--~             [ReagentData['element']['livingessence']] = 8,
--~             [ReagentData['element']['essenceoffire']] = 8,
--~             [ReagentData['gem']['blackvitriol']] = 2,
--~             [ReagentData['herb']['blacklotus']] = 4,
--~         }
--~     },
    ['Flask of Chromatic Resistance'] = {
        skill = 300,
        description = 'MinLvl: 50, Use: Increases your resistance to all schools of magic by 25 for 2 hrs. You can only have the effect of one flask at a time.',
        source = 'Drop:Recipe: Flask of Chromatic Resistance',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['icecap']] = 30,
            [ReagentData['herb']['mountainsilversage']] = 10,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['herb']['blacklotus']] = 1,
        }
    },
    ['Flask of Distilled Wisdom'] = {
        skill = 300,
        description = 'MinLvl: 50, Use: Increases the player\'s maximum mana by 2000 for 2 hrs. You can only have the effect of one flask at a time.',
        source = 'Drop:Recipe: Flask of Distilled Wisdom',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['dreamfoil']] = 30,
            [ReagentData['herb']['icecap']] = 10,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['herb']['blacklotus']] = 1,
        }
    },
    ['Flask of Petrification'] = {
        skill = 300,
        description = 'MinLvl: 50, Use: You turn to stone, protecting you from all physical attacks and spells for 1 min, but during that time you cannot attack, move or cast spells. You can only have the effect of one flask at a time.',
        source = 'Drop:Recipe: Flask of Petrification',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['mountainsilversage']] = 10,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['oil']['stonescale']] = 30,
            [ReagentData['herb']['blacklotus']] = 1,
        }
    },
    ['Flask of Supreme Power'] = {
        skill = 300,
        description = 'MinLvl: 50, Use: Increases damage done by magical spells and effects by up to 150 for 2 hrs. You can only have the effect of one flask at a time.',
        source = 'Drop:Recipe: Flask of Supreme Power',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['dreamfoil']] = 30,
            [ReagentData['herb']['mountainsilversage']] = 10,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['herb']['blacklotus']] = 1,
        }
    },
    ['Flask of the Titans'] = {
        skill = 300,
        description = 'MinLvl: 50, Use: Increases the player\'s maximum health by 1200 for 2 hrs. You can only have the effect of one flask at a time.',
        source = 'Drop:Recipe: Flask of the Titans',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['gromsblood']] = 30,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['oil']['stonescale']] = 10,
            [ReagentData['herb']['blacklotus']] = 1,
        }
    },
    ['Major Rejuvenation Potion'] = {
        skill = 300,
        description = 'MinLvl: 50, Use: Restores 1440 to 1760 mana and health.',
        source = 'Drop:Recipe: Major Rejuvination Potion',
        sourcerarity = 'Rare',
        result = 1,
        resultname = 'Major Rejuvenation Potion',
        reagents = {
            [ReagentData['herb']['dreamfoil']] = 4,
            [ReagentData['element']['heartofthewild']] = 1,
            [ReagentData['herb']['goldensansam']] = 4,
            [ReagentData['vial']['imbued']] = 1,
        }
    },
--~     ['Cowardly Flight Potion'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['herb']['kingsblood']] = 1,
--~             [ReagentData['vial']['leaded']] = 1,
--~             [ReagentData['feather']['Delicate Feather']] = 1,
--~         }
--~     },
--~     ['Elixir of Tongues'] = {
--~         source = 'Unknown:Recipe: Elixir of Tongues',
--~         result = 1,
--~         resultname = 'Elixir of Tongues (NYI)',
--~         reagents = {
--~             [ReagentData['vial']['empty']] = 1,
--~             [ReagentData['herb']['earthroot']] = 2,
--~             [ReagentData['herb']['mageroyal']] = 2,
--~         }
--~     },
--~     ['Elixir of Waterwalking'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~             [ReagentData['herb']['liferoot']] = 1,
--~             [ReagentData['vial']['leaded']] = 1,
--~             [ReagentData['oil']['blackmouth']] = 1,
--~         }
--~     },
--~     ['Refined Scale of Onyxia'] = {
--~         source = 'Unknown',
--~         result = 1,
--~         resultname = 'UnknownItem',
--~         reagents = {
--~          [ReagentData['monster']['scaleofonyxia']] = 1,
--~         }
--~     },
    ['Mageblood Potion'] = {
         skill = 300,
         description = 'MinLvl: 40, Use: Regenerate 12 mana every 5 sec for 60 minutes.',
         source = 'Vendor:Recipe: Mageblood Potion',
         result = 1,
         reagents = {
              [ReagentData['herb']['dreamfoil']] = 1,
              [ReagentData['herb']['plaguebloom']] = 2,
              [ReagentData['vial']['crystal']] = 1,
         }
    },
    ['Greater Dreamless Sleep Potion'] = {
         skill = 300,
         description = 'MinLvl: 55, Use: Puts the imbiber in a dreamless sleep for 12 seconds. During that time the imbiber heals 2100 health and 2100 mana.',
         source = 'Vendor:Recipe: Greater Dreamless Sleep Potion',
         result = 1,
         reagents = {
              [ReagentData['herb']['dreamfoil']] = 2,
              [ReagentData['herb']['goldensansam']] = 1,
              [ReagentData['vial']['crystal']] = 1,
         }
    },
    ['Living Action Potion'] = {
         skill = 300,
         description = 'MinLvl: 47, Use: Makes you immune to stun and movement impairing effects for the next 5 seconds. Also removes existing Stun and Movement impairing effects.',
         source = 'Vendor:Recipe: Living Action Potion',
         result = 1,
         reagents = {
              [ReagentData['herb']['icecap']] = 2,
              [ReagentData['herb']['mountainsilversage']] = 2,
              [ReagentData['element']['heartofthewild']] = 2,
              [ReagentData['vial']['crystal']] = 1,
         }
    },
    ['Major Troll\'s Blood Potion'] = {
         skill = 300,
         description = 'MinLvl: 53, Use: Regenerate 20 health every 5 sec for 60 minutes.',
         source = 'Vendor:Recipe: Major Troll\'s Blood Potion',
         result = 1,
         reagents = {
              [ReagentData['herb']['gromsblood']] = 1,
              [ReagentData['herb']['plaguebloom']] = 2,
              [ReagentData['vial']['crystal']] = 1,
         }
    },
    ['Elixir of Greater Firepower'] = {
         skill = 250,
         description = 'MinLvl: 40, Use: Increases spell fire damage by up to 40 for 30 minutes.',
         source = 'Drop:Recipe: Elixir of Greater Firepower',
         result = 1,
         reagents = {
              [ReagentData['oil']['fire']] = 3,
              [ReagentData['herb']['firebloom']] = 3,
              [ReagentData['vial']['crystal']] = 1,
         }
    },
    ['Gurubashi Mojo Madness'] = {
         skill = 300,
         description = 'Use: Extinguishes the Brazier of Madness.',
         source = 'Quest',
         result = 3,
         reagents = {
              [ReagentData['other']['bloodofheroes']] = 3,
              [ReagentData['monster']['massivemojo']] = 1,
              [ReagentData['monster']['powerfulmojo']] = 6,
              [ReagentData['herb']['blacklotus']] = 1,
         }
    },
    ['Transmute: Elemental Fire'] = {
            skill = 225,
            description = 'Elemental Fire',
            type = 'Trade Goods',
            source = 'Vendor:Recipe: Transmute Elemental Fire',
            result = 3,
            resultname = 'Elemental Fire',
            reagents = {
                [ReagentData['element']['heartoffire']] = 1,
            }
    },
}
end