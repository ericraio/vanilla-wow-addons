function ReagentData_LoadPoisons()
ReagentData['crafted']['poisons'] = {
    ['Crippling Poison'] = {
        skill = 1,
        description = 'MinLvl: 20, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy, slowing their movement speed to 50% of normal for 12 sec.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['poisoningredient']['essenceofpain']] = 1,
        }
    },
    ['Instant Poison'] = {
        skill = 1,
        description = 'MinLvl: 20, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 19 to 25 Nature damage. 40 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['poisoningredient']['dustofdecay']] = 1,
        }
    },
    ['Mind-numbing Poison'] = {
        skill = 100,
        description = 'MinLvl: 24, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 20% chance of poisoning the enemy, increasing their casting time by 40% for 10 sec. 50 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['empty']] = 1,
            [ReagentData['poisoningredient']['dustofdecay']] = 1,
            [ReagentData['poisoningredient']['essenceofpain']] = 1,
        }
    },
    ['Instant Poison II'] = {
        skill = 120,
        description = 'MinLvl: 28, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 30 to 38 Nature damage. 55 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['poisoningredient']['dustofdecay']] = 3,
        }
    },
    ['Blinding Powder'] = {
        skill = 125,
        description = 'MinLvl: 34',
        type = 'Reagent',
        source = 'Trainer',
        result = 3,
        reagents = {
            [ReagentData['herb']['fadeleaf']] = 1,
        }
    },
    ['Deadly Poison'] = {
        skill = 130,
        description = 'MinLvl: 30, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy for 36 Nature damage over 12 sec. Stacks up to 5 times on a single target. 60 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['poisoningredient']['deathweed']] = 1,
        }
    },
    ['Wound Poison'] = {
        skill = 140,
        description = 'MinLvl: 32, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy, reducing all healing effects used on them by 55 for 15 sec. Stacks up to 5 times on a single target. 60 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['poisoningredient']['deathweed']] = 1,
            [ReagentData['poisoningredient']['essenceofpain']] = 1,
        }
    },
    ['Instant Poison III'] = {
        skill = 160,
        description = 'MinLvl: 36, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 44 to 56 Nature damage. 70 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['poisoningredient']['dustofdeterioration']] = 1,
        }
    },
    ['Deadly Poison II'] = {
        skill = 170,
        description = 'MinLvl: 38, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy for 52 Nature damage over 12 sec. Stacks up to 5 times on a single target. 75 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['poisoningredient']['deathweed']] = 2,
        }
    },
    ['Mind-numbing Poison II'] = {
        skill = 170,
        description = 'MinLvl: 38, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 20% chance of poisoning the enemy, increasing their casting time by 50% for 12 sec. 75 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['poisoningredient']['dustofdecay']] = 4,
            [ReagentData['poisoningredient']['essenceofpain']] = 4,
        }
    },
    ['Wound Poison II'] = {
        skill = 180,
        description = 'MinLvl: 40, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy, reducing all healing effects used on them by 75 for 15 sec. Stacks up to 5 times on a single target. 75 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['leaded']] = 1,
            [ReagentData['poisoningredient']['deathweed']] = 2,
            [ReagentData['poisoningredient']['essenceofpain']] = 1,
        }
    },
    ['Instant Poison IV'] = {
        skill = 200,
        description = 'MinLvl: 44, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 67 to 85 Nature damage. 85 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['poisoningredient']['dustofdeterioration']] = 2,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Deadly Poison III'] = {
        skill = 210,
        description = 'MinLvl: 46, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy for 80 Nature damage over 12 sec. Stacks up to 5 times on a single target. 90 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['poisoningredient']['deathweed']] = 3,
        }
    },
    ['Wound Poison III'] = {
        skill = 220,
        description = 'MinLvl: 48, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy, reducing all healing effects used on them by 105 for 15 sec. Stacks up to 5 times on a single target. 90 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['poisoningredient']['essenceofagony']] = 1,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['poisoningredient']['deathweed']] = 2,
        }
    },
    ['Crippling Poison II'] = {
        skill = 230,
        description = 'MinLvl: 50, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy, slowing their movement speed to 30% of normal for 12 sec.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['poisoningredient']['essenceofagony']] = 3,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Instant Poison V'] = {
        skill = 240,
        description = 'MinLvl: 52, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy which instantly inflicts 92 to 118 Nature damage. 100 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['poisoningredient']['dustofdeterioration']] = 3,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Mind-numbing Poison III'] = {
        skill = 240,
        description = 'MinLvl: 52, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 20% chance of poisoning the enemy, increasing their casting time by 60% for 14 sec. 100 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['poisoningredient']['dustofdeterioration']] = 2,
            [ReagentData['poisoningredient']['essenceofagony']] = 2,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Deadly Poison IV'] = {
        skill = 250,
        description = 'MinLvl: 54, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy for 108 Nature damage over 12 sec. Stacks up to 5 times on a single target. 105 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['poisoningredient']['deathweed']] = 5,
        }
    },
    ['Wound Poison IV'] = {
        skill = 260,
        description = 'MinLvl: 56, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy, reducing all healing effects used on them by 135 for 15 sec. Stacks up to 5 times on a single target. 105 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['poisoningredient']['essenceofagony']] = 2,
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['poisoningredient']['deathweed']] = 2,
        }
    },
    ['Instant Poison VI'] = {
        skill = 280,
        description = 'MinLvl: 60, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 20% chance of poisoning the enemy which instantly inflicts 112 to 148 Nature damage. 115 charges.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['poisoningredient']['dustofdeterioration']] = 4,
            [ReagentData['vial']['crystal']] = 1,
        }
    },
    ['Deadly Poison V'] = {
        skill = 300,
        description = 'MinLvl: 60, Use: Coats a weapon with poison that lasts for 30 minutes. Each strike has a 30% chance of poisoning the enemy for 136 Nature damage over 12 seconds. Stacks up to 5 times on a single target. 105 charges.',
        source = 'Drop',
        result = 1,
        reagents = {
            [ReagentData['vial']['crystal']] = 1,
            [ReagentData['poisoningredient']['deathweed']] = 7,
        }
    },
}
end