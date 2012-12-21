function ReagentData_LoadMining()
ReagentData['crafted']['mining'] = {
    ['Smelt Copper'] = {
        skill = 1,
        description = 'Copper Bar',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['ore']['copper']] = 1,
        }
    },
    ['Smelt Bronze'] = {
        skill = 65,
        description = 'Bronze Bar',
        source = 'Trainer',
        result = 2,
        reagents = {
            [ReagentData['bar']['tin']] = 1,
            [ReagentData['bar']['copper']] = 1,
        }
    },
    ['Smelt Tin'] = {
        skill = 65,
        description = 'Tin Bar',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['ore']['tin']] = 1,
        }
    },
    ['Smelt Silver'] = {
        skill = 75,
        description = 'Silver Bar',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['ore']['silver']] = 1,
        }
    },
    ['Smelt Iron'] = {
        skill = 125,
        description = 'Iron Bar',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['ore']['iron']] = 1,
        }
    },
    ['Smelt Gold'] = {
        skill = 155,
        description = 'Gold Bar',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['ore']['gold']] = 1,
        }
    },
    ['Smelt Steel'] = {
        skill = 165,
        description = 'Steel Bar',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['iron']] = 1,
            [ReagentData['vendorother']['coal']] = 1,
        }
    },
    ['Smelt Mithril'] = {
        skill = 175,
        description = 'Mithril Bar',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['ore']['mithril']] = 1,
        }
    },
    ['Smelt Dark Iron'] = {
        skill = 230,
        description = 'Dark Iron Bar',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['ore']['darkiron']] = 8,
        }
    },
    ['Smelt Truesilver'] = {
        skill = 230,
        description = 'Truesilver Bar',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['ore']['truesilver']] = 1,
        }
    },
    ['Smelt Thorium'] = {
        skill = 250,
        description = 'Thorium Bar',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['ore']['thorium']] = 1,
        }
    },
    ['Smelt Elementium'] = {
        skill = 300,
        description = 'Elementium Bar',
        source = 'Quest',
        result = 1,
        reagents = {
            [ReagentData['ore']['elementium']] = 1,
            [ReagentData['bar']['arcanite']] = 10,
            [ReagentData['monster']['fierycore']] = 1,
            [ReagentData['flux']['elemental']] = 3,
        }
    },
}
end