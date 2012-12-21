function ReagentData_LoadEngineering()
ReagentData['crafted']['engineering'] = {
    ['Crafted Light Shot'] = {
        skill = 1,
        description = 'MinLvl: 5, Projectile, Bullet, Adds 2 damage per second',
        type = 'Bullet',
        source = 'Trainer',
        result = 200,
        reagents = {
            [ReagentData['powder']['rough']] = 1,
            [ReagentData['bar']['copper']] = 1,
        }
    },
    ['Rough Blasting Powder'] = {
        skill = 1,
        description = 'Rough Blasting Powder',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['rough']] = 1,
        }
    },
    ['Rough Dynamite'] = {
        skill = 1,
        description = 'Requires Engineering (1), Use: Inflicts 26 to 34 Fire damage in a 5 yard radius.',
        type = 'Explosives',
        source = 'Trainer',
        result = 2,
        reagents = {
            [ReagentData['powder']['rough']] = 2,
            [ReagentData['cloth']['linen']] = 1,
        }
    },
    ['Handful of Copper Bolts'] = {
        skill = 30,
        description = 'Handful of Copper Bolts',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['copper']] = 1,
        }
    },
    ['Rough Copper Bomb'] = {
        skill = 30,
        description = 'Requires Engineering (30), Use: Inflicts 22 to 28 Fire damage and disorients targets in a 3 yard radius for 1 sec.',
        type = 'Explosives',
        source = 'Trainer',
        result = 2,
        reagents = {
            [ReagentData['part']['handfulofcopperbolts']] = 1,
            [ReagentData['powder']['rough']] = 2,
            [ReagentData['cloth']['linen']] = 1,
            [ReagentData['bar']['copper']] = 1,
        }
    },
    ['Arclight Spanner'] = {
        skill = 50,
        description = 'Dmg: 5-8, Spd: 2.40, DPS: 2.7, Main Hand, Requires Engineering (50)',
        type = 'Miscellaneous',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['copper']] = 6,
        }
    },
    ['Copper Tube'] = {
        skill = 50,
        description = 'Copper Tube',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['flux']['weak']] = 1,
            [ReagentData['bar']['copper']] = 2,
        }
    },
    ['Rough Boomstick'] = {
        skill = 50,
        description = '[BoE] (Gun) Dmg: 6-13, Spd: 2.30, DPS: 4.1, MinLvl: 5',
        type = 'Gun',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['part']['handfulofcopperbolts']] = 1,
            [ReagentData['part']['coppertube']] = 1,
            [ReagentData['part']['woodenstock']] = 1,
        }
    },
    ['Crude Scope'] = {
        skill = 60,
        description = 'MinLvl: 5, Use: Attaches a permanent scope to a bow or gun that increases its damage by 1.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['gem']['malachite']] = 1,
            [ReagentData['part']['handfulofcopperbolts']] = 1,
            [ReagentData['part']['coppertube']] = 1,
        }
    },
    ['Copper Modulator'] = {
        skill = 65,
        description = 'Copper Modulator',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['part']['handfulofcopperbolts']] = 2,
            [ReagentData['cloth']['linen']] = 2,
            [ReagentData['bar']['copper']] = 1,
        }
    },
    ['Coarse Blasting Powder'] = {
        skill = 75,
        description = 'Coarse Blasting Powder',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['coarse']] = 1,
        }
    },
    ['Coarse Dynamite'] = {
        skill = 75,
        description = 'Requires Engineering (75), Use: Inflicts 51 to 69 Fire damage in a 5 yard radius.',
        type = 'Explosives',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['powder']['coarse']] = 3,
            [ReagentData['cloth']['linen']] = 1,
        }
    },
    ['Crafted Heavy Shot'] = {
        skill = 75,
        description = 'MinLvl: 15, Projectile, Bullet, Adds 4.5 damage per second',
        type = 'Bullet',
        source = 'Trainer',
        result = 200,
        reagents = {
            [ReagentData['powder']['coarse']] = 1,
            [ReagentData['bar']['copper']] = 1,
        }
    },
    ['Mechanical Squirrel'] = {
        skill = 75,
        description = 'Binds when used, Use: Creates a Mechanical Squirrel that follows you around. Right Click to summon and dismiss your Squirrel.',
        type = 'Devices',
        source = 'Drop:Schematic: Mechanical Squirrel',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Mechanical Squirrel Box',
        reagents = {
            [ReagentData['part']['handfulofcopperbolts']] = 1,
            [ReagentData['gem']['malachite']] = 2,
            [ReagentData['part']['coppermodulator']] = 1,
            [ReagentData['bar']['copper']] = 1,
        }
    },
    ['Target Dummy'] = {
        skill = 85,
        description = 'Requires Engineering (85), Use: Drops a target dummy on the ground that attracts nearby monsters to attack it. Lasts for 3 min.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['part']['handfulofcopperbolts']] = 2,
            [ReagentData['cloth']['wool']] = 1,
            [ReagentData['bar']['bronze']] = 1,
            [ReagentData['part']['coppermodulator']] = 1,
        }
    },
    ['Silver Contact'] = {
        skill = 90,
        description = 'Silver Contact',
        type = 'Parts',
        source = 'Trainer',
        result = 5,
        reagents = {
            [ReagentData['bar']['silver']] = 1,
        }
    },
    ['EZ-Thro Dynamite'] = {
        skill = 100,
        description = 'MinLvl: 10, Use: The dynamite for Non-Engineers that nearly always gets to the target! Inflicts 51 to 69 Fire damage in a 5 yard radius.',
        type = 'Explosives',
        source = 'Drop:Schematic: EZ-Thro Dynamite',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Ez-Thro Dynamite',
        reagents = {
            [ReagentData['cloth']['wool']] = 1,
            [ReagentData['powder']['coarse']] = 4,
        }
    },
    ['Flying Tiger Goggles'] = {
        skill = 100,
        description = '[BoE] (Cloth Head) AC: 27, Sta: 4, Spi: 4, Requires Engineering (100)',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['light']] = 6,
            [ReagentData['gem']['tigerseye']] = 2,
        }
    },
    ['Practice Lock'] = {
        skill = 100,
        description = 'Practice Lock',
        type = 'Misc',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['part']['handfulofcopperbolts']] = 2,
            [ReagentData['bar']['bronze']] = 1,
            [ReagentData['flux']['weak']] = 1,
        }
    },
    ['Small Seaforium Charge'] = {
        skill = 100,
        description = 'Requires Engineering (100), Use: Blasts open simple locked doors.',
        type = 'Explosives',
        source = 'Drop:Schematic: Small Seaforium Charge',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['leather']['light']] = 1,
            [ReagentData['powder']['coarse']] = 2,
            [ReagentData['part']['coppermodulator']] = 1,
            [ReagentData['drink']['refreshingspringwater']] = 1,
        }
    },
    ['Bronze Tube'] = {
        skill = 105,
        description = 'Bronze Tube',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['bronze']] = 2,
            [ReagentData['flux']['weak']] = 1,
        }
    },
    ['Deadly Blunderbuss'] = {
        skill = 105,
        description = '[BoE] (Gun) Dmg: 15-28, Spd: 2.60, DPS: 8.3, MinLvl: 16',
        type = 'Gun',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['part']['handfulofcopperbolts']] = 4,
            [ReagentData['part']['coppertube']] = 2,
            [ReagentData['part']['woodenstock']] = 1,
            [ReagentData['leather']['medium']] = 2,
        }
    },
    ['Large Copper Bomb'] = {
        skill = 105,
        description = 'Requires Engineering (105), Use: Inflicts 43 to 57 Fire damage and disorients targets in a 5 yard radius for 1 sec.',
        type = 'Explosives',
        source = 'Trainer',
        result = 2,
        reagents = {
            [ReagentData['part']['silvercontact']] = 1,
            [ReagentData['powder']['coarse']] = 4,
            [ReagentData['bar']['copper']] = 3,
        }
    },
    ['Standard Scope'] = {
        skill = 110,
        description = 'MinLvl: 10, Use: Attaches a permanent scope to a bow or gun that increases its damage by 2.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['gem']['mossagate']] = 1,
            [ReagentData['part']['bronzetube']] = 1,
        }
    },
    ['Lovingly Crafted Boomstick'] = {
        skill = 120,
        description = '[BoE] (Gun) Dmg: 12-23, Spd: 1.80, DPS: 9.7, MinLvl: 19',
        type = 'Gun',
        source = 'Vendor:Schematic: Lovingly Crafted Boomstick',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['part']['handfulofcopperbolts']] = 2,
            [ReagentData['gem']['mossagate']] = 3,
            [ReagentData['part']['heavystock']] = 1,
            [ReagentData['part']['bronzetube']] = 2,
        }
    },
    ['Shadow Goggles'] = {
        skill = 120,
        description = '[BoE] (Cloth Head) AC: 31, Int: 5, Spi: 6, Requires Engineering (120)',
        type = 'Cloth',
        source = 'Drop:Schematic: Shadow Goggles',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['shadow']] = 2,
            [ReagentData['leather']['medium']] = 4,
        }
    },
    ['Small Bronze Bomb'] = {
        skill = 120,
        description = 'Requires Engineering (120), Use: Inflicts 73 to 97 Fire damage and disorients targets in a 3 yard radius for 2 sec.',
        type = 'Explosives',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['part']['silvercontact']] = 1,
            [ReagentData['cloth']['wool']] = 1,
            [ReagentData['bar']['bronze']] = 2,
            [ReagentData['powder']['coarse']] = 4,
        }
    },
    ['Crafted Solid Shot'] = {
        skill = 125,
        description = 'MinLvl: 30, Projectile, Bullet, Adds 8.5 damage per second',
        type = 'Bullet',
        source = 'Trainer',
        result = 200,
        reagents = {
            [ReagentData['bar']['bronze']] = 1,
            [ReagentData['powder']['heavy']] = 1,
        }
    },
    ['Flame Deflector'] = {
        skill = 125,
        description = 'MinLvl: 15, Use: Increases your Fire resistance by 15 for 15 sec.',
        type = 'Devices',
        source = 'Drop:Schematic: Flame Deflector',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['part']['whirringbronzegizmo']] = 1,
            [ReagentData['monster']['smallflamesac']] = 1,
        }
    },
    ['Gnomish Universal Remote'] = {
        skill = 125,
        description = '[BoE] (Trinket) Requires Engineering (125), Use: Allows control of a mechanical target for a short time. It may not always work and may just root the machine or make it very very angry. Gnomish engineering at its finest.',
        type = 'Devices',
        source = 'Drop, Vendor:Schematic: Gnomish Universal Remote',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['malachite']] = 1,
            [ReagentData['bar']['bronze']] = 6,
            [ReagentData['monster']['flaskofoil']] = 2,
            [ReagentData['part']['whirringbronzegizmo']] = 1,
            [ReagentData['gem']['tigerseye']] = 1,
        }
    },
    ['Heavy Blasting Powder'] = {
        skill = 125,
        description = 'Heavy Blasting Powder',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['heavy']] = 1,
        }
    },
    ['Heavy Dynamite'] = {
        skill = 125,
        description = 'Requires Engineering (125), Use: Inflicts 128 to 172 Fire damage in a 5 yard radius.',
        type = 'Explosives',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['wool']] = 1,
            [ReagentData['powder']['heavy']] = 2,
        }
    },
    ['Small Blue Rocket'] = {
        skill = 125,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Small Blue Rocket',
        result = 1,
        reagents = {
            [ReagentData['powder']['coarse']] = 1,
            [ReagentData['leather']['medium']] = 1,
        }
    },
    ['Small Green Rocket'] = {
        skill = 125,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Small Green Rocket',
        result = 1,
        reagents = {
            [ReagentData['powder']['coarse']] = 1,
            [ReagentData['leather']['medium']] = 1,
        }
    },
    ['Small Red Rocket'] = {
        skill = 125,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Small Red Rocket',
        result = 1,
        reagents = {
            [ReagentData['powder']['coarse']] = 1,
            [ReagentData['leather']['medium']] = 1,
        }
    },
    ['Whirring Bronze Gizmo'] = {
        skill = 125,
        description = 'Whirring Bronze Gizmo',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['wool']] = 1,
            [ReagentData['bar']['bronze']] = 2,
        }
    },
    ['Silver-plated Shotgun'] = {
        skill = 130,
        description = '[BoE] (Gun) Dmg: 19-37, Spd: 2.70, DPS: 10.4, MinLvl: 21',
        type = 'Gun',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['part']['heavystock']] = 1,
            [ReagentData['part']['bronzetube']] = 2,
            [ReagentData['part']['whirringbronzegizmo']] = 2,
            [ReagentData['bar']['silver']] = 3,
        }
    },
    ['Ornate Spyglass'] = {
        skill = 135,
        description = 'Use: Allows you to look far into the distance.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['gem']['mossagate']] = 1,
            [ReagentData['part']['bronzetube']] = 2,
            [ReagentData['part']['whirringbronzegizmo']] = 2,
            [ReagentData['part']['coppermodulator']] = 1,
        }
    },
    ['Big Bronze Bomb'] = {
        skill = 140,
        description = 'Requires Engineering (140), Use: Inflicts 85 to 115 Fire damage and disorients targets in a 5 yard radius for 2 sec.',
        type = 'Explosives',
        source = 'Trainer',
        result = 2,
        reagents = {
            [ReagentData['part']['silvercontact']] = 1,
            [ReagentData['bar']['bronze']] = 3,
            [ReagentData['powder']['heavy']] = 2,
        }
    },
    ['Minor Recombobulator'] = {
        skill = 140,
        description = '(Trinket) Requires Engineering (140), Use: Dispels Polymorph effects on a friendly target.',
        type = 'Devices',
        source = 'Vendor:Schematic: Minor Recombobulator',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['mossagate']] = 1,
            [ReagentData['part']['bronzetube']] = 1,
            [ReagentData['part']['whirringbronzegizmo']] = 2,
            [ReagentData['leather']['medium']] = 2,
        }
    },
    ['Bronze Framework'] = {
        skill = 145,
        description = 'Bronze Framework',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['wool']] = 1,
            [ReagentData['bar']['bronze']] = 2,
            [ReagentData['leather']['medium']] = 1,
        }
    },
    ['Moonsight Rifle'] = {
        skill = 145,
        description = '[BoE] (Gun) Dmg: 14-26, Spd: 1.70, DPS: 11.8, MinLvl: 24',
        type = 'Gun',
        source = 'Drop:Schematic: Moonsight Rifle',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['part']['heavystock']] = 1,
            [ReagentData['part']['bronzetube']] = 3,
            [ReagentData['part']['whirringbronzegizmo']] = 3,
            [ReagentData['gem']['lessermoonstone']] = 2,
        }
    },
    ['Aquadynamic Fish Attractor'] = {
        skill = 150,
        description = 'Requires Fishing (100), Use: When applied to your fishing pole, increases Fishing by 100 for 5 minutes.',
        type = 'Devices',
        source = 'Trainer',
        result = 3,
        reagents = {
            [ReagentData['bar']['bronze']] = 2,
            [ReagentData['vendorother']['nightcrawlers']] = 1,
            [ReagentData['powder']['coarse']] = 1,
        }
    },
    ['Explosive Sheep'] = {
        skill = 150,
        description = 'Requires Engineering (150), Use: Summons an Explosive Sheep which will charge at a nearby enemy and explode for 135 to 165 damage. Lasts for 3 min or until it explodes.',
        type = 'Explosives',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['cloth']['wool']] = 2,
            [ReagentData['part']['whirringbronzegizmo']] = 1,
            [ReagentData['powder']['heavy']] = 2,
            [ReagentData['part']['bronzeframework']] = 1,
        }
    },
    ['Gold Power Core'] = {
        skill = 150,
        description = 'Gold Power Core',
        type = 'Parts',
        source = 'Trainer',
        result = 3,
        reagents = {
            [ReagentData['bar']['gold']] = 1,
        }
    },
    ['Blue Firework'] = {
        skill = 150,
        description = 'Use: Shoots a firework into the air that bursts into a thousand blue stars. ',
        type = 'Firework',
        source = 'Vendor:Schematic: Blue Firework',
        result = 3,
        reagents = {
            [ReagentData['powder']['heavy']] = 1,
            [ReagentData['leather']['heavy']] = 1,
     },
    },
    ['Green Firework'] = {
        skill = 150,
        description = 'Use: Shoots a firework into the air that bursts into a thousand green stars. ',
        type = 'Firework',
        source = 'Vendor:Schematic: Green Firework',
        result = 3,
        reagents = {
            [ReagentData['powder']['heavy']] = 1,
            [ReagentData['leather']['heavy']] = 1,
     },
    },
    ['Red Firework'] = {
        skill = 150,
        description = 'Use: Shoots a firework into the air that bursts into a thousand red stars. ',
        type = 'Firework',
        source = 'Vendor:Schematic: Red Firework',
        result = 3,
        reagents = {
            [ReagentData['powder']['heavy']] = 1,
            [ReagentData['leather']['heavy']] = 1,
     },
    },
    ['Green Tinted Goggles'] = {
        skill = 150,
        description = '[BoE] (Cloth Head) AC: 35, Sta: 8, Spi: 7, Requires Engineering (150)',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['mossagate']] = 2,
            [ReagentData['armor']['flyingtigergoggles']] = 1,
            [ReagentData['leather']['medium']] = 4,
        }
    },
    ['Ice Deflector'] = {
        skill = 155,
        description = 'MinLvl: 21, Use: Increases your Frost resistance by 18 for 15 sec.',
        type = 'Devices',
        source = 'Vendor:Schematic: Ice Deflector',
        result = 1,
        reagents = {
            [ReagentData['part']['whirringbronzegizmo']] = 1,
            [ReagentData['oil']['frost']] = 1,
        }
    },
    ['Discombobulator Ray'] = {
        skill = 160,
        description = 'Use: Transforms the target into a Leper Gnome, reducing its attack rate by 50% and its movement rate by 30% for 12 sec.',
        type = 'Devices',
        source = 'Drop:Schematic: Discombobulator Ray',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['part']['whirringbronzegizmo']] = 3,
            [ReagentData['cloth']['silk']] = 2,
            [ReagentData['part']['bronzetube']] = 1,
            [ReagentData['gem']['jade']] = 1,
        }
    },
    ['Iron Strut'] = {
        skill = 160,
        description = 'Iron Strut',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['iron']] = 2,
        }
    },
    ['Goblin Jumper Cables'] = {
        skill = 165,
        description = '(Trinket) Requires Engineering (165), Use: Jumper Cables will sometimes be able to shock a dead player back to life. Be warned that they are experimental and may explode. Cannot be used when in combat.',
        type = 'Devices',
        source = 'Drop, Vendor:Schematic: Goblin Jumper Cables',
        result = 1,
        reagents = {
            [ReagentData['bar']['iron']] = 6,
            [ReagentData['monster']['flaskofoil']] = 2,
            [ReagentData['gem']['shadow']] = 2,
            [ReagentData['part']['whirringbronzegizmo']] = 2,
            [ReagentData['cloth']['silk']] = 2,
            [ReagentData['part']['fusedwiring']] = 1,
        }
    },
    ['Portable Bronze Mortar'] = {
        skill = 165,
        description = 'Requires Engineering (165), Use: Inflicts 85 to 115 Fire damage and disorients targets in a 5 yard radius for 2 sec.',
        type = 'Devices',
        source = 'Drop:Schematic: Portable Bronze Mortar',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['part']['ironstrut']] = 1,
            [ReagentData['part']['bronzetube']] = 4,
            [ReagentData['powder']['heavy']] = 4,
            [ReagentData['leather']['medium']] = 4,
        }
    },
    ['Gyrochronatom'] = {
        skill = 170,
        description = 'Gyrochronatom',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['iron']] = 1,
            [ReagentData['part']['goldpowercore']] = 1,
        }
    },
    ['Bright-Eye Goggles'] = {
        skill = 175,
        description = '[BoE] (Cloth Head) AC: 38, Sta: 9, Spi: 9, Requires Engineering (175)',
        type = 'Cloth',
        source = 'Drop:Schematic: Bright-Eye Goggles',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 6,
            [ReagentData['gem']['citrine']] = 2,
        }
    },
    ['Compact Harvest Reaper Kit'] = {
        skill = 175,
        description = 'MinLvl: 30, Requires Engineering (175), Use: Creates a Compact Harvest Reaper that will fight for you for 10 min or until it is destroyed.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['part']['ironstrut']] = 2,
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['part']['gyrochronatom']] = 2,
            [ReagentData['part']['bronzeframework']] = 1,
        }
    },
    ['Gyromatic Micro-Adjustor'] = {
        skill = 175,
        description = 'Gyromatic Micro-Adjustor',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['steel']] = 4,
        }
    },
    ['Iron Grenade'] = {
        skill = 175,
        description = 'Requires Engineering (175), Use: Inflicts 132 to 218 Fire damage and disorients for 3 sec in a 3 yard radius.',
        type = 'Explosives',
        source = 'Trainer',
        result = 2,
        reagents = {
            [ReagentData['bar']['iron']] = 1,
            [ReagentData['cloth']['silk']] = 1,
            [ReagentData['powder']['heavy']] = 1,
        }
    },
    ['Large Blue Rocket'] = {
        skill = 175,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Large Blue Rocket',
        result = 1,
        reagents = {
            [ReagentData['powder']['heavy']] = 1,
            [ReagentData['leather']['heavy']] = 1,
        }
    },
    ['Large Green Rocket'] = {
        skill = 175,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Large Green Rocket',
        result = 1,
        reagents = {
            [ReagentData['powder']['heavy']] = 1,
            [ReagentData['leather']['heavy']] = 1,
        }
    },
    ['Large Red Rocket'] = {
        skill = 175,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Large Red Rocket',
        result = 1,
        reagents = {
            [ReagentData['powder']['heavy']] = 1,
            [ReagentData['leather']['heavy']] = 1,
        }
    },
    ['Solid Blasting Powder'] = {
        skill = 175,
        description = 'Solid Blasting Powder',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['solid']] = 2,
        }
    },
    ['Solid Dynamite'] = {
        skill = 175,
        description = 'Requires Engineering (175), Use: Inflicts 213 to 287 Fire damage in a 5 yard radius.',
        type = 'Explosives',
        source = 'Trainer',
        result = 2,
        reagents = {
            [ReagentData['powder']['solid']] = 1,
            [ReagentData['cloth']['silk']] = 1,
        }
    },
    ['Accurate Scope'] = {
        skill = 180,
        description = 'MinLvl: 20, Use: Attaches a permanent scope to a bow or gun that increases its damage by 3.',
        type = 'Devices',
        source = 'Vendor:Schematic: Accurate Scope',
        result = 1,
        reagents = {
            [ReagentData['gem']['citrine']] = 1,
            [ReagentData['part']['bronzetube']] = 1,
            [ReagentData['gem']['jade']] = 1,
        }
    },
    ['Advanced Target Dummy'] = {
        skill = 185,
        description = 'Requires Engineering (185), Use: Drops a target dummy on the ground that attracts nearby monsters to attack it. Lasts for 3 min.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['part']['ironstrut']] = 1,
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['part']['gyrochronatom']] = 1,
            [ReagentData['part']['bronzeframework']] = 1,
        }
    },
    ['Craftsman\'s Monocle'] = {
        skill = 185,
        description = '[BoE] (Cloth Head) AC: 40, Int: 15, MinLvl: 32, Requires Engineering (185)',
        type = 'Cloth',
        source = 'Drop:Schematic: Craftsman\'s Monocle',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 6,
            [ReagentData['gem']['citrine']] = 2,
        }
    },
    ['Flash Bomb'] = {
        skill = 185,
        description = 'MinLvl: 27, Use: Causes all Beasts in a 5 yard radius to run away for 10 sec.',
        type = 'Explosives',
        source = 'Drop:Schematic: Flash Bomb',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['cloth']['silk']] = 1,
            [ReagentData['powder']['heavy']] = 1,
            [ReagentData['pearl']['blue']] = 1,
        }
    },
    ['Big Iron Bomb'] = {
        skill = 190,
        description = 'Requires Engineering (190), Use: Inflicts 149 to 201 Fire damage and disorients targets in a 5 yard radius for 3 sec.',
        type = 'Explosives',
        source = 'Trainer',
        result = 2,
        reagents = {
            [ReagentData['part']['silvercontact']] = 1,
            [ReagentData['bar']['iron']] = 3,
            [ReagentData['powder']['heavy']] = 3,
        }
    },
    ['SnowMaster 9000'] = {
        skill = 190,
        description = 'Requires Engineering (190), Use: Allows an experienced engineer to turn water into a snowball. The Snowmaster requires a day to build up enough chill to freeze another snowball.',
        type = 'Devices',
        source = 'Drop:Schematic: Snowmaster 9000',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['part']['gyrochronatom']] = 4,
            [ReagentData['oil']['frost']] = 1,
            [ReagentData['other']['snowball']] = 4,
            [ReagentData['bar']['mithril']] = 8,
        }
    },
    ['Goblin Land Mine'] = {
        skill = 195,
        description = 'Requires Engineering (195), Use: Places the Goblin Land Mine on the ground. It will explode for 450 fire damage the next time a hostile creature passes near it.',
        type = 'Explosives',
        source = 'Drop:Schematic: Goblin Land Mine',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['bar']['iron']] = 2,
            [ReagentData['powder']['heavy']] = 3,
            [ReagentData['part']['gyrochronatom']] = 1,
        }
    },
    ['Mithril Tube'] = {
        skill = 195,
        description = 'Mithril Tube',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['mithril']] = 3,
        }
    },
    ['Gnomish Cloaking Device'] = {
        skill = 200,
        description = '[BoE] (Trinket) Requires Engineering (200), Use: Gives invisibility for 10 sec. It can only be used every 60 minutes.',
        type = 'Devices',
        source = 'Drop, Vendor:Schematic: Gnomish Cloaking Device',
        result = 1,
        reagents = {
            [ReagentData['gem']['citrine']] = 2,
            [ReagentData['part']['gyrochronatom']] = 4,
            [ReagentData['gem']['jade']] = 2,
            [ReagentData['gem']['lessermoonstone']] = 2,
            [ReagentData['part']['fusedwiring']] = 1,
        }
    },
    ['Large Seaforium Charge'] = {
        skill = 200,
        description = 'Requires Engineering (200), Use: Blasts open difficult locked doors.',
        type = 'Explosives',
        source = 'Drop:Schematic: Large Seaforium Charge',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['powder']['solid']] = 2,
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['drink']['refreshingspringwater']] = 1,
        }
    },
    ['Mechanical Dragonling'] = {
        skill = 200,
        description = '[BoE] [U] (Trinket) MinLvl: 30, Requires Engineering (200), Use: Activates your Mechanical Dragonling to fight for you for 1 min. It requires an hour to cool down before it can be used again.',
        type = 'Devices',
        source = 'Vendor:Schematic: Mechanical Dragonling',
        result = 1,
        reagents = {
            [ReagentData['part']['ironstrut']] = 4,
            [ReagentData['gem']['citrine']] = 2,
            [ReagentData['part']['gyrochronatom']] = 4,
            [ReagentData['part']['fusedwiring']] = 1,
            [ReagentData['part']['bronzeframework']] = 1,
        }
    },
    ['EZ-Thro Dynamite II'] = {
     skill = 200,
     type = 'Explosives',
     description = 'MinLvl: 30, Use: Inflicts 213 to 287 Fire damage in a 5 yard radius (Assuming that it gets to the target, some restrictions may apply.)',
     source = 'Vendor:Schematic: EZ-Thro Dynamite II',
     result = 1,
     reagents = {
          [ReagentData['powder']['solid']] = 1,
          [ReagentData['cloth']['mageweave']] = 2,
     },
    },
    ['Mechanical Repair Kit'] = {
        skill = 200,
        description = 'Requires Engineering (200), Use: Restores 700 health to a friendly mechanical target',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['powder']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 1,
            [ReagentData['cloth']['mageweave']] = 1,
        }
    },
    ['Unstable Trigger'] = {
        skill = 200,
        description = 'Unstable Trigger',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['powder']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 1,
            [ReagentData['cloth']['mageweave']] = 1,
        }
    },
    ['Fire Goggles'] = {
        skill = 205,
        description = '[BoE] (Cloth Head) AC: 44, FR: 17, Requires Engineering (205)',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['armor']['greentintedgoggles']] = 1,
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['gem']['citrine']] = 2,
            [ReagentData['element']['fire']] = 2,
        }
    },
    ['Gnomish Shrink Ray'] = {
        skill = 205,
        description = '[BoE] (Trinket) Requires Engineering (205), Use: Shrinks the target reducing their attack power by 250. Thats what it usually does anyway.....',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['gem']['jade']] = 2,
            [ReagentData['part']['mithriltube']] = 1,
            [ReagentData['monster']['flaskofmojo']] = 4,
            [ReagentData['part']['unstabletrigger']] = 1,
            [ReagentData['bar']['mithril']] = 4,
        }
    },
    ['Goblin Construction Helmet'] = {
        skill = 205,
        description = '[BoP] (Cloth Head) AC: 44, FR: 15, Requires Engineering (205), Use: Absorbs 300 to 500 Fire damage. Lasts 1 min.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['citrine']] = 1,
            [ReagentData['bar']['mithril']] = 8,
            [ReagentData['element']['fire']] = 4,
        }
    },
    ['Goblin Mining Helmet'] = {
        skill = 205,
        description = '[BoP] (Mail Head) AC: 190, Sta: 15, Requires Engineering (205), Equip: Mining +5.',
        type = 'Mail',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['element']['earth']] = 4,
            [ReagentData['gem']['citrine']] = 1,
            [ReagentData['bar']['mithril']] = 8,
        }
    },
    ['Goblin Mortar'] = {
        skill = 205,
        description = '[BoE] (Trinket) Requires Engineering (205), Use: Inflicts 383 to 517 Fire damage and stuns the targets in a 10 yard radius for 3 sec.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['powder']['solid']] = 5,
            [ReagentData['part']['goldpowercore']] = 1,
            [ReagentData['part']['mithriltube']] = 2,
            [ReagentData['bar']['mithril']] = 4,
            [ReagentData['element']['fire']] = 1,
        }
    },
    ['Goblin Rocket Fuel Recipe'] = {
        skill = 205,
        type = 'Alchemy',
        source = 'Trainer',
        result = 1,
        resultname = 'Recipe: Goblin Rocket Fuel',
        reagents = {
            [ReagentData['part']['blankparchment']] = 1,
            [ReagentData['part']['engineersink']] = 1,
        }
    },
    ['Goblin Sapper Charge'] = {
        skill = 205,
        description = 'Requires Engineering (205), Use: Explodes when triggered dealing 450 to 750 Fire damage to all enemies nearby and 375 to 625 damage to you.',
        type = 'Explosives',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['powder']['solid']] = 3,
            [ReagentData['cloth']['mageweave']] = 1,
            [ReagentData['part']['unstabletrigger']] = 1,
        }
    },
    ['Inlaid Mithril Cylinder Plans'] = {
        skill = 205,
        type = 'Blacksmithing',
        source = 'Trainer',
        result = 1,
        resultname = 'Plans: Inlaid Mithril Cylinder',
        reagents = {
            [ReagentData['part']['blankparchment']] = 1,
            [ReagentData['part']['engineersink']] = 1,
        }
    },
    ['Dimensional Ripper - Everlook'] = {
     skill = 260,
     description = 'Requires Goblin Engineering (260), Use: Rips the dimensional walls asunder and transports you to Everlook in Winterspring. There are technical problems that sometimes occur, but that\'s what Goblin Engineering is all about!',
     type = 'Miscellaneous',
     source = 'Trainer',
     result = 1,
     reagents = {
          [ReagentData['bar']['mithril']] = 10,
          [ReagentData['part']['truesilvertransformer']] = 1,
          [ReagentData['element']['heartoffire']] = 4,
          [ReagentData['gem']['starruby']] = 2,
          [ReagentData['part']['thebigone']] = 1,
     },
    },
    ['Lil\' Smoky'] = {
        skill = 205,
        description = '[BoP] Use: Right Click to summon and dismiss your robot.',
        type = 'Devices',
        source = 'Drop:Schematic: Lil\' Smoky',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['element']['coreofearth']] = 1,
            [ReagentData['bar']['truesilver']] = 1,
            [ReagentData['part']['gyrochronatom']] = 2,
            [ReagentData['part']['fusedwiring']] = 1,
            [ReagentData['bar']['mithril']] = 2,
        }
    },
    ['Mithril Blunderbuss'] = {
        skill = 205,
        description = '[BoE] (Gun) Dmg: 36-68, Spd: 2.90, DPS: 17.9, Agi: 5, MinLvl: 36',
        type = 'Gun',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['part']['heavystock']] = 1,
            [ReagentData['part']['mithriltube']] = 1,
            [ReagentData['part']['unstabletrigger']] = 1,
            [ReagentData['bar']['mithril']] = 4,
            [ReagentData['element']['fire']] = 2,
        }
    },
    ['Pet Bombling'] = {
        skill = 205,
        description = '[BoP] Use: Right Click to summon and dismiss your bomb.',
        type = 'Devices',
        source = 'Drop:Schematic: Pet Bombling',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['part']['bigironbomb']] = 1,
            [ReagentData['part']['fusedwiring']] = 1,
            [ReagentData['element']['heartoffire']] = 1,
            [ReagentData['bar']['mithril']] = 6,
        }
    },
    ['Deadly Scope'] = {
        skill = 210,
        description = 'MinLvl: 30, Use: Attaches a permanent scope to a bow or gun that increases its damage by 5.',
        type = 'Devices',
        source = 'Vendor:Schematic: Deadly Scope',
        result = 1,
        reagents = {
            [ReagentData['gem']['aquamarine']] = 2,
            [ReagentData['leather']['thick']] = 2,
            [ReagentData['part']['mithriltube']] = 1,
        }
    },
    ['Gnomish Goggles'] = {
        skill = 210,
        description = '[BoP] (Cloth Head) AC: 45, Agi: 9, Sta: 9, Spi: 9, Requires Engineering (210)',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['heavy']] = 2,
            [ReagentData['part']['goldpowercore']] = 2,
            [ReagentData['armor']['firegoggles']] = 1,
            [ReagentData['part']['mithriltube']] = 1,
            [ReagentData['monster']['flaskofmojo']] = 2,
        }
    },
    ['Gnomish Net-o-Matic Projector'] = {
        skill = 210,
        description = '[BoE] (Trinket) Requires Engineering (210), Use: Captures the target in a net for 10 sec. The net has a lot of hooks however and sometimes gets caught in the user\'s clothing when fired......',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['spidersilk']['thick']] = 4,
            [ReagentData['powder']['solid']] = 2,
            [ReagentData['spidersilk']['shadow']] = 2,
            [ReagentData['part']['mithriltube']] = 1,
            [ReagentData['bar']['mithril']] = 4,
        }
    },
    ['Hi-Impact Mithril Slugs'] = {
        skill = 210,
        description = 'MinLvl: 37, Projectile, Bullet, Adds 12.5 damage per second',
        type = 'Bullet',
        source = 'Trainer',
        result = 200,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['powder']['solid']] = 1,
            [ReagentData['bar']['mithril']] = 1,
        }
    },
    ['Gnomish Harm Prevention Belt'] = {
        skill = 215,
        description = '[BoE] (Leather Waist) AC: 66, Sta: 6, Requires Engineering (215), Use: A shield of force protects you from the next 500 damage done over the next 10 min. WARNING: Force Field may overload when struck temporarily removing the wearer from this d',
        type = 'Leather',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['armor']['duskybelt']] = 1,
            [ReagentData['gem']['aquamarine']] = 2,
            [ReagentData['bar']['truesilver']] = 2,
            [ReagentData['bar']['mithril']] = 4,
            [ReagentData['part']['unstabletrigger']] = 1,
        }
    },
    ['Mithril Casing'] = {
        skill = 215,
        description = 'Mithril Casing',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['mithril']] = 3,
        }
    },
    ['Mithril Frag Bomb'] = {
        skill = 215,
        description = 'Requires Engineering (205), Use: Inflicts 149 to 201 Fire damage and disorients targets in a 8 yard radius for 2 sec.',
        type = 'Explosives',
        source = 'Trainer',
        result = 3,
        reagents = {
            [ReagentData['powder']['solid']] = 1,
            [ReagentData['part']['mithrilcasing']] = 1,
            [ReagentData['part']['unstabletrigger']] = 1,
        }
    },
    ['Catseye Ultra Goggles'] = {
        skill = 220,
        description = '[BoE] (Cloth Head) AC: 47, Requires Engineering (220), Equip: Increases your stealth detection by 9.',
        type = 'Cloth',
        source = 'Drop:Schematic: Catseye Ultra Goggles',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 4,
            [ReagentData['gem']['aquamarine']] = 2,
            [ReagentData['potion']['catseyeelixir']] = 1,
        }
    },
    ['Mithril Heavy-bore Rifle'] = {
        skill = 220,
        description = '[BoE] (Gun) Dmg: 41-76, Spd: 2.90, DPS: 20.2, MinLvl: 39, Equip: +14 ranged Attack Power.',
        type = 'Gun',
        source = 'Drop:Schematic: Mithril Heavy-bore Rifle',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['part']['heavystock']] = 1,
            [ReagentData['gem']['citrine']] = 2,
            [ReagentData['part']['mithriltube']] = 2,
            [ReagentData['part']['unstabletrigger']] = 1,
            [ReagentData['bar']['mithril']] = 6,
        }
    },
    ['Gnomish Rocket Boots'] = {
        skill = 225,
        description = '[BoE] (Cloth Feet) AC: 41, Requires Engineering (225), Use: These boots significantly increase your run speed for 20 sec. WARNING: Their power supply and gyros do not always function as intended.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['armor']['blackmageweaveboots']] = 1,
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['powder']['solid']] = 8,
            [ReagentData['part']['gyrochronatom']] = 4,
            [ReagentData['part']['mithriltube']] = 2,
        }
    },
    ['Goblin Rocket Boots'] = {
        skill = 130,
        description = '[BoE] (Cloth Feet) AC: 41, Use: These dangerous looking boots significantly increase your run speed for 20 sec. They are prone to explode however, so use with caution.',
        type = 'Cloth',
        source = 'Trainer:Plans: Goblin Rocket Boots',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['armor']['blackmageweaveboots']] = 1,
            [ReagentData['leather']['heavy']] = 4,
            [ReagentData['part']['mithriltube']] = 2,
            [ReagentData['oil']['goblinrocketfuel']] = 2,
            [ReagentData['part']['unstabletrigger']] = 1,
        }
    },
    ['Blue Rocket Cluster'] = {
        skill = 225,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Blue Rocket Cluster',
        result = 1,
        reagents = {
            [ReagentData['powder']['solid']] = 1,
            [ReagentData['leather']['thick']] = 1,
        }
    },
    ['Green Rocket Cluster'] = {
        skill = 225,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Green Rocket Cluster',
        result = 1,
        reagents = {
            [ReagentData['powder']['solid']] = 1,
            [ReagentData['leather']['thick']] = 1,
        }
    },
    ['Red Rocket Cluster'] = {
        skill = 225,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Red Rocket Cluster',
        result = 1,
        reagents = {
            [ReagentData['powder']['solid']] = 1,
            [ReagentData['leather']['thick']] = 1,
        }
    },
    ['Firework Launcher'] = {
        skill = 225,
        description = 'Use: Place on the ground to launch firework rockets. Lasts 30 minutes.',
        type = 'Device',
        source = 'Quest:Schematic: Firework Launcher',
        result = 1,
        reagents = {
            [ReagentData['part']['inlaidmithrilcylinder']] = 1,
            [ReagentData['oil']['goblinrocketfuel']] = 1,
            [ReagentData['part']['unstabletrigger']] = 1,
            [ReagentData['part']['mithrilcasing']] = 1,
        }
    },
    ['Parachute Cloak'] = {
        skill = 225,
        description = '[BoE] (Back) AC: 30, Agi: 8, Requires Engineering (225), Use: Reduces your fall speed for 10 sec.',
        type = 'Cloth',
        source = 'Drop:Schematic: Parachute Cloak',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['bolt']['mageweave']] = 4,
            [ReagentData['powder']['solid']] = 4,
            [ReagentData['spidersilk']['shadow']] = 2,
            [ReagentData['part']['unstabletrigger']] = 1,
        }
    },
    ['Spellpower Goggles Xtreme'] = {
        skill = 225,
        description = '[BoE] (Cloth Head) AC: 46, Requires Engineering (215), Equip: Increases damage and healing done by magical spells and effects by up to 12.',
        type = 'Cloth',
        source = 'Drop:Schematic: Spellpower Goggles Xtreme',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 4,
            [ReagentData['gem']['starruby']] = 2,
        }
    },
    ['Deepdive Helmet'] = {
        skill = 230,
        description = '[BoE] (Cloth Head) AC: 49, Sta: 15, Requires Engineering (230), Equip: Allows underwater breathing.',
        type = 'Cloth',
        source = 'Vendor:Schematic: Deepdive Helmet',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['malachite']] = 4,
            [ReagentData['bar']['truesilver']] = 1,
            [ReagentData['gem']['tigerseye']] = 4,
            [ReagentData['bar']['mithril']] = 8,
            [ReagentData['part']['mithrilcasing']] = 1,
        }
    },
    ['Gnomish Battle Chicken'] = {
        skill = 230,
        description = '[BoP] (Trinket) Requires Engineering (230), Use: Creates a Battle Chicken that will fight for you for 1.50 min or until it is destroyed.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['part']['goldpowercore']] = 1,
            [ReagentData['bar']['truesilver']] = 6,
            [ReagentData['gem']['jade']] = 2,
            [ReagentData['part']['mithrilcasing']] = 1,
            [ReagentData['bar']['mithril']] = 6,
            [ReagentData['part']['inlaidmithrilcylinder']] = 2,
        }
    },
    ['Goblin Bomb Dispenser'] = {
        skill = 230,
        description = '[BoP] (Trinket) Requires Engineering (230), Use: Creates a mobile bomb that charges the nearest enemy and explodes for 315 to 385 fire damage.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['powder']['solid']] = 4,
            [ReagentData['bar']['truesilver']] = 6,
            [ReagentData['part']['accuratescope']] = 2,
            [ReagentData['part']['mithrilcasing']] = 2,
            [ReagentData['part']['unstabletrigger']] = 1,
        }
    },
    ['Rose Colored Goggles'] = {
        skill = 230,
        description = '[BoE] (Cloth Head) AC: 49, Int: 12, Spi: 13, Requires Engineering (230)',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['leather']['thick']] = 6,
            [ReagentData['gem']['starruby']] = 2,
        }
    },
    ['Gnomish Mind Control Cap'] = {
        skill = 235,
        description = '[BoE] (Cloth Head) AC: 50, Spi: 14, Requires Engineering (215), Use: Engage in mental combat with a humanoid target to try and control their mind. If all works well, you will control the mind of the target for 20 sec .....',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 2,
            [ReagentData['part']['goldpowercore']] = 1,
            [ReagentData['bar']['truesilver']] = 4,
            [ReagentData['bar']['mithril']] = 10,
            [ReagentData['cloth']['mageweave']] = 4,
        }
    },
    ['Hi-Explosive Bomb'] = {
        skill = 235,
        description = 'Requires Engineering (235), Use: Inflicts 255 to 345 Fire damage and disorients targets in a 3 yard radius for 3 sec.',
        type = 'Explosives',
        source = 'Trainer',
        result = 4,
        reagents = {
            [ReagentData['powder']['solid']] = 2,
            [ReagentData['part']['mithrilcasing']] = 2,
            [ReagentData['part']['unstabletrigger']] = 1,
        }
    },
    ['The Big One'] = {
        skill = 235,
        description = 'Requires Engineering (225), Use: Inflicts 340 to 460 Fire damage and disorients targets for 5 sec in a 10 yard radius.',
        type = 'Explosives',
        source = 'Trainer',
        result = 2,
        reagents = {
            [ReagentData['part']['soliddynamite']] = 6,
            [ReagentData['oil']['goblinrocketfuel']] = 1,
            [ReagentData['part']['mithrilcasing']] = 1,
            [ReagentData['part']['unstabletrigger']] = 1,
        }
    },
    ['Gnomish Death Ray'] = {
        skill = 240,
        description = '[BoP] (Trinket) Death or Serious Injury may result from use of this device.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['element']['ichorofundeath']] = 4,
            [ReagentData['element']['essenceofundeath']] = 1,
            [ReagentData['part']['mithriltube']] = 2,
            [ReagentData['part']['unstabletrigger']] = 1,
            [ReagentData['part']['inlaidmithrilcylinder']] = 1,
        }
    },
    ['Goblin Dragon Gun'] = {
        skill = 240,
        description = '[BoP] (Trinket) Use: Deals 61 to 69 fire damage for 10 sec to all targets in a cone in front of the engineer using the weapon. That is unless it explodes.....',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['bar']['truesilver']] = 6,
            [ReagentData['part']['mithriltube']] = 2,
            [ReagentData['oil']['goblinrocketfuel']] = 4,
            [ReagentData['bar']['mithril']] = 6,
            [ReagentData['part']['unstabletrigger']] = 1,
        }
    },
    ['Sniper Scope'] = {
        skill = 240,
        description = 'MinLvl: 40, Use: Attaches a permanent scope to a bow or gun that increases its damage by 7.',
        type = 'Devices',
        source = 'Drop:Schematic: Sniper Scope',
        sourcerarity = 'Rare',
        result = 1,
        reagents = {
            [ReagentData['gem']['starruby']] = 1,
            [ReagentData['bar']['truesilver']] = 2,
            [ReagentData['part']['mithriltube']] = 1,
        }
    },
    ['Goblin Rocket Helmet'] = {
        skill = 245,
        description = '[BoE] (Cloth Head) AC: 50, Sta: 15, Requires Engineering (235), Use: Charge an enemy, knocking it silly for 30 seconds. Also knocks you down, stunning you for a short period of time. Any damage caused will revive the target.',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['armor']['goblinconstructionhelmet']] = 1,
            [ReagentData['oil']['goblinrocketfuel']] = 4,
            [ReagentData['bar']['mithril']] = 4,
            [ReagentData['part']['unstabletrigger']] = 1,
        }
    },
    ['Green Lens'] = {
        skill = 245,
        description = '[BoE] (Cloth Head) AC: 57, Sta: 10, &lt;Random enchantment&gt;, Requires Engineering (245)',
        type = 'Cloth',
        source = 'Trainer',
        result = 1,
        resultname = 'Green Lens of .*',
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['leather']['thick']] = 8,
            [ReagentData['gem']['aquamarine']] = 3,
            [ReagentData['herb']['wildvine']] = 2,
            [ReagentData['element']['heartofthewild']] = 2,
            [ReagentData['gem']['jade']] = 3,
        }
    },
    ['Mithril Gyro-Shot'] = {
        skill = 245,
        description = 'MinLvl: 44, Projectile, Bullet, Adds 15 damage per second',
        type = 'Bullet',
        source = 'Trainer',
        result = 200,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['powder']['solid']] = 2,
            [ReagentData['bar']['mithril']] = 2,
        }
    },
    ['Dense Blasting Powder'] = {
        skill = 250,
        description = 'Dense Blasting Powder',
        type = 'Parts',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['stone']['dense']] = 2,
        }
    },
    ['Snake Burst Firework'] = {
        skill = 250,
        description = 'Use: Shoots a firework into the air that bursts in a yellow pattern.',
        type = 'Firework',
        source = 'Vendor:Schematic: Snake Burst Firework',
        result = 4,
        reagents = {
            [ReagentData['powder']['dense']] = 2,
            [ReagentData['cloth']['rune']] = 2,
            [ReagentData['salt']['deeprock']] = 1,
     },
    },
    ['Dense Dynamite'] = {
         skill = 250,
         description = 'Requires Engineering (250), Use: Inflicts 340 to 460 Fire damage in a 5 yard radius.',
         type = 'Explosives',
         source = 'Trainer',
         result = 2,
         reagents = {
              [ReagentData['powder']['dense']] = 2,
              [ReagentData['cloth']['rune']] = 3,
         },
    },
    ['Mithril Mechanical Dragonling'] = {
        skill = 250,
        description = '[BoE] [U] (Trinket) MinLvl: 40, Requires Engineering (250), Use: Activates your Mithril Mechanical Dragonling to fight for you for 1 min. It requires an hour to cool down before it can be used again.',
        type = 'Devices',
        source = 'Vendor:Schematic: Mithril Mechanical Dragonling',
        result = 1,
        reagents = {
            [ReagentData['gem']['starruby']] = 2,
            [ReagentData['bar']['truesilver']] = 4,
            [ReagentData['element']['heartoffire']] = 4,
            [ReagentData['oil']['goblinrocketfuel']] = 2,
            [ReagentData['bar']['mithril']] = 14,
            [ReagentData['part']['inlaidmithrilcylinder']] = 2,
        }
    },
    ['Salt Shaker'] = {
        skill = 250,
        description = 'Requires Leatherworking (250), Use: Allows an experienced leatherworker to turn Deeprock Salt into Refined Deeprock Salt. Use of the device exposes the user to sub-core micro radiation and should not be used more than once every few days.',
        type = 'Devices',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['part']['goldpowercore']] = 1,
            [ReagentData['bar']['thorium']] = 6,
            [ReagentData['part']['mithrilcasing']] = 1,
            [ReagentData['part']['unstabletrigger']] = 4,
        }
    },
    ['Tranquil Mechanical Yeti'] = {
        skill = 250,
        description = 'Binds when used, Use: Right Click to summon and dismiss your Tranquil Mechanical Yeti.',
        type = 'Devices',
        source = 'Quest',
        result = 1,
        resultname = 'Tranquil Mechanical Yeti',
        reagents = {
            [ReagentData['hide']['curedrugged']] = 1,
            [ReagentData['part']['thoriumwidget']] = 4,
            [ReagentData['element']['globeofwater']] = 2,
            [ReagentData['part']['truesilvertransformer']] = 2,
            [ReagentData['part']['goldpowercore']] = 1,
        }
    },
    ['Thorium Grenade'] = {
        skill = 260,
        description = 'Requires Engineering (260), Use: Inflicts 300 to 500 Fire damage and disorients for 3 sec in a 3 yard radius.',
        type = 'Explosives',
        source = 'Vendor:Schematic: Thorium Grenade',
        result = 3,
        reagents = {
            [ReagentData['powder']['dense']] = 3,
            [ReagentData['bar']['thorium']] = 3,
            [ReagentData['part']['thoriumwidget']] = 1,
            [ReagentData['cloth']['rune']] = 3,
        }
    },
    ['Thorium Rifle'] = {
        skill = 260,
        description = '[BoE] (Gun) Dmg: 42-79, Spd: 2.50, DPS: 24.2, MinLvl: 47, Equip: +17 ranged Attack Power.',
        type = 'Gun',
        source = 'Drop:Schematic: Thorium Rifle',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['part']['mithriltube']] = 2,
            [ReagentData['bar']['thorium']] = 4,
            [ReagentData['part']['deadlyscope']] = 1,
            [ReagentData['part']['mithrilcasing']] = 2,
            [ReagentData['part']['thoriumwidget']] = 2,
        }
    },
    ['Thorium Widget'] = {
        skill = 260,
        description = 'Thorium Widget',
        type = 'Parts',
        source = 'Vendor:Schematic: Thorium Widget',
        result = 1,
        reagents = {
            [ReagentData['bar']['thorium']] = 3,
            [ReagentData['cloth']['rune']] = 1,
        }
    },
    ['Gyrofreeze Ice Deflector'] = {
         skill = 260,
         description = '[BoE] [U] (Trinket) MinLvl: 47, Requires Engineering (260), Use: Reflects Frost spells back at their caster for 5 seconds.',
         type = 'Devices',
         source = 'Vendor:Schematic: Gyrofreeze Ice Deflector',
         sourcerarity = 'Common',
         result = 1,
         resultname = 'Gyrofreeze Ice Deflector',
         resultrarity = 'Rare',
         reagents = {
              [ReagentData['part']['thoriumwidget']] = 6,
              [ReagentData['part']['truesilvertransformer']] = 2,
              [ReagentData['gem']['bluesapphire']] = 2,
              [ReagentData['element']['essenceoffire']] = 4,
              [ReagentData['oil']['frost']] = 2,
              [ReagentData['herb']['icecap']] = 4,
         },
    },
    ['Truesilver Transformer'] = {
     skill = 260,
     description = 'Truesilver Transformer',
     type = 'Parts',
     source = 'Vendor:Schematic: Truesilver Transformer',
     reagents = {
          [ReagentData['bar']['truesilver']] = 2,
          [ReagentData['element']['earth']] = 2,
          [ReagentData['element']['air']] = 1,
     },
    },
    ['Lifelike Mechanical Toad'] = {
        skill = 265,
        description = 'Binds when used, Use: Right Click to summon and dismiss your lifelike mechanical toad.',
        type = 'Devices',
        source = 'Drop:Schematic: Lifelike Mechanical Toad',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['part']['goldpowercore']] = 1,
            [ReagentData['leather']['rugged']] = 1,
            [ReagentData['element']['livingessence']] = 1,
            [ReagentData['part']['thoriumwidget']] = 4,
        }
    },
    ['Spellpower Goggles Xtreme Plus'] = {
        skill = 270,
        description = '[BoE] (Cloth Head) AC: 57, Requires Engineering (270), Equip: Increases damage and healing done by magical spells and effects by up to 19.',
        type = 'Cloth',
        source = 'Drop:Schematic: Spellpower Goggles Xtreme Plus',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['gem']['starruby']] = 4,
            [ReagentData['armor']['spellpowergogglesxtreme']] = 1,
            [ReagentData['leather']['enchanted']] = 2,
            [ReagentData['cloth']['rune']] = 8,
        }
    },
    ['Dark Iron Rifle'] = {
        skill = 275,
        description = '[BoE] (Gun) Dmg: 53-100, Spd: 2.70, DPS: 29.4, MinLvl: 50, + 2 - 4 Shadow Damage',
        type = 'Gun',
        source = 'Drop:Schematic: Dark Iron Rifle',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['part']['thoriumtube']] = 2,
            [ReagentData['bar']['darkiron']] = 6,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['part']['deadlyscope']] = 2,
            [ReagentData['gem']['bluesapphire']] = 2,
            [ReagentData['gem']['largeopal']] = 2,
        }
    },
    ['Large Blue Rocket Cluster'] = {
        skill = 275,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Large Blue Rocket Cluster',
        result = 1,
        reagents = {
            [ReagentData['powder']['dense']] = 1,
            [ReagentData['leather']['rugged']] = 1,
        }
    },
    ['Large Green Rocket Cluster'] = {
        skill = 275,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Large Green Rocket Cluster',
        result = 1,
        reagents = {
            [ReagentData['powder']['dense']] = 1,
            [ReagentData['leather']['rugged']] = 1,
        }
    },
    ['Large Red Rocket Cluster'] = {
        skill = 275,
        description = 'Use: Throw into a firework launcher!',
        type = 'Firework',
        source = 'Quest:Schematic: Large Red Rocket Cluster',
        result = 1,
        reagents = {
            [ReagentData['powder']['dense']] = 1,
            [ReagentData['leather']['rugged']] = 1,
        }
    },
    ['Cluster Launcher'] = {
        skill = 275,
        description = 'Use: Place on the ground to launch cluster rockets. Lasts 30 minutes.',
        type = 'Device',
        source = 'Quest:Schematic: Firework Launcher',
        result = 1,
        reagents = {
            [ReagentData['part']['inlaidmithrilcylinder']] = 4,
            [ReagentData['oil']['goblinrocketfuel']] = 4,
            [ReagentData['part']['truesilvertransformer']] = 2,
            [ReagentData['part']['mithrilcasing']] = 1,
        }
    },
    ['Powerful Seaforium Charge'] = {
         skill = 275,
         description = 'Requires Engineering (275), Use: Blasts open nearly any locked door.',
         type = 'Explosives',
         source = 'Vendor:Schematic: Powerful Seaforium Charge',
         result = 1,
         reagents = {
              [ReagentData['part']['thoriumwidget']] = 2,
              [ReagentData['powder']['dense']] = 3,
              [ReagentData['leather']['rugged']] = 2,
              [ReagentData['drink']['refreshingspringwater']] = 1,
         },
    },
    ['Major Recombobulator'] = {
         skill = 275,
         description = 'Requires Engineering (275), Use: Dispels Polymorph effects on a friendly target. Also restores 375 to 625 health and mana.',
         type = 'Devices',
         source = 'Drop:Schematic: Major Recombobulator',
         sourcerarity = 'Uncommon',
         result = 1,
         resultname = 'Major Recombobulator',
         resultrarity = 'Uncommon',
         reagents = {
              [ReagentData['part']['thoriumtube']] = 2,
              [ReagentData['part']['truesilvertransformer']] = 1,
              [ReagentData['cloth']['rune']] = 2,
         },
    },
    ['Masterwork Target Dummy'] = {
        skill = 275,
        description = 'Requires Engineering (275), Use: Drops a target dummy on the ground that attracts nearby monsters to attack it. Lasts for 3 min.',
        type = 'Devices',
        source = 'Vendor:Schematic: Masterwork Target Dummy',
        result = 1,
        reagents = {
            [ReagentData['part']['thoriumtube']] = 1,
            [ReagentData['bar']['truesilver']] = 1,
            [ReagentData['leather']['rugged']] = 2,
            [ReagentData['part']['mithrilcasing']] = 1,
            [ReagentData['part']['thoriumwidget']] = 2,
            [ReagentData['cloth']['rune']] = 4,
        }
    },
    ['Thorium Tube'] = {
        skill = 275,
        description = 'Thorium Tube',
        type = 'Parts',
        source = 'Vendor:Schematic: Thorium Tube',
        result = 1,
        reagents = {
            [ReagentData['bar']['thorium']] = 6,
        }
    },
    ['Dark Iron Bomb'] = {
        skill = 285,
        description = 'Requires Engineering (285), Use: Inflicts 225 to 675 Fire damage and disorients targets in a 3 yard radius for 4 sec.',
        type = 'Explosives',
        source = 'Drop:Schematic: Dark Iron Bomb',
        sourcerarity = 'Uncommon',
        result = 3,
        reagents = {
            [ReagentData['bar']['darkiron']] = 1,
            [ReagentData['powder']['dense']] = 3,
            [ReagentData['part']['thoriumwidget']] = 2,
            [ReagentData['cloth']['rune']] = 3,
        }
    },
    ['Delicate Arcanite Converter'] = {
        skill = 285,
        description = 'Delicate Arcanite Converter',
        type = 'Parts',
        source = 'Vendor:Schematic: Delicate Arcanite Converter',
        result = 1,
        reagents = {
            [ReagentData['spidersilk']['ironweb']] = 1,
            [ReagentData['bar']['arcanite']] = 1,
        }
    },
    ['Thorium Shells'] = {
        skill = 285,
        description = 'MinLvl: 52, Projectile, Bullet, Adds 17.5 damage per second',
        type = 'Bullet',
        source = 'Drop:Schematic: Thorium Shells',
        sourcerarity = 'Uncommon',
        result = 200,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['powder']['dense']] = 1,
            [ReagentData['bar']['thorium']] = 2,
        }
    },
    ['Master Engineer\'s Goggles'] = {
        skill = 290,
        description = '[BoE] (Cloth Head) AC: 61, Sta: 16, Spi: 17, Requires Engineering (280)',
        type = 'Cloth',
        source = 'Drop:Schematic: Master Engineer\'s Goggles',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['armor']['firegoggles']] = 1,
            [ReagentData['gem']['hugeemerald']] = 2,
            [ReagentData['leather']['enchanted']] = 4,
        }
    },
    ['Voice Amplification Modulator'] = {
        skill = 290,
        description = '[BoE] (Neck) Equip: Increases your resistance to silence effects by 7%.',
        type = 'Miscellaneous',
        source = 'Drop:Schematic: Voice Amplification Modulator',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Uncommon',
        reagents = {
            [ReagentData['part']['goldpowercore']] = 1,
            [ReagentData['part']['delicatearcaniteconverter']] = 2,
            [ReagentData['part']['thoriumwidget']] = 1,
            [ReagentData['gem']['largeopal']] = 1,
        }
    },
    ['Arcane Bomb'] = {
        skill = 300,
        description = 'Requires Engineering (300), Use: Drains 675 to 1125 mana from those in the blast radius and does 50% of the mana drained in damage to the target. Also Silences targets in the blast for 5 sec.',
        type = 'Explosives',
        source = 'Drop:Schematic: Arcane Bomb',
        sourcerarity = 'Uncommon',
        result = 3,
        reagents = {
            [ReagentData['bar']['thorium']] = 3,
            [ReagentData['part']['delicatearcaniteconverter']] = 1,
            [ReagentData['cloth']['rune']] = 1,
        }
    },
    ['Arcanite Dragonling'] = {
        skill = 300,
        description = '[BoE] [U] (Trinket) MinLvl: 50, Requires Engineering (300), Use: The Arcanite Dragonling comes to life and defends you for 1 min.',
        type = 'Devices',
        source = 'Drop:Schematic: Arcanite Dragonling',
        sourcerarity = 'Uncommon',
        result = 1,
        resultname = 'Arcanite Mechanical Dragonling',
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['part']['goldpowercore']] = 4,
            [ReagentData['bar']['enchantedthorium']] = 10,
            [ReagentData['part']['mithrilmechanicaldragonling']] = 1,
            [ReagentData['part']['delicatearcaniteconverter']] = 8,
            [ReagentData['part']['thoriumwidget']] = 6,
            [ReagentData['leather']['enchanted']] = 6,
        }
    },
    ['Biznicks 247x128 Accurascope'] = {
        skill = 300,
        description = 'MinLvl: 50, Use: Attaches a permanent scope to a bow or gun that increases its chance to hit by 3%.',
        type = 'Devices',
        source = 'Drop:Schematic: Biznicks 247x128 Accurascope',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['bar']['darkiron']] = 6,
            [ReagentData['part']['thoriumtube']] = 1,
            [ReagentData['element']['essenceofearth']] = 2,
            [ReagentData['monster']['lavacore']] = 2,
            [ReagentData['part']['delicatearcaniteconverter']] = 4,
        }
    },
    ['Core Marksman Rifle'] = {
        skill = 300,
        description = '[BoE] (Gun) Dmg: 64-120, Spd: 2.50, DPS: 36.8, MinLvl: 60, Equip: +22 ranged Attack Power., Equip: Improves your chance to hit by 1%.',
        type = 'Gun',
        source = 'Drop:Schematic: Core Marksman Rifle',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['part']['thoriumtube']] = 2,
            [ReagentData['monster']['fierycore']] = 4,
            [ReagentData['monster']['lavacore']] = 2,
            [ReagentData['bar']['arcanite']] = 6,
            [ReagentData['part']['delicatearcaniteconverter']] = 2,
        }
    },
    ['Field Repair Bot 74A'] = {
        skill = 300,
        description = 'Requires Engineering (300), Use: Unfolds into a Field Repair Bot that can repair damaged items and purchase unwanted goods. After 10 minutes it\'s internal motor fails.',
        type = 'Devices',
        source = 'Drop',
        result = 1,
        reagents = {
            [ReagentData['element']['earth']] = 2,
            [ReagentData['leather']['rugged']] = 4,
            [ReagentData['part']['fusedwiring']] = 1,
            [ReagentData['bar']['thorium']] = 12,
            [ReagentData['element']['fire']] = 1,
        }
    },
    ['Flawless Arcanite Rifle'] = {
        skill = 300,
        description = '[BoE] (Gun) Dmg: 65-122, Spd: 3.00, DPS: 31.2, MinLvl: 56, Equip: Increased Guns +4., Equip: +10 ranged Attack Power.',
        type = 'Gun',
        source = 'Drop:Schematic: Flawless Arcanite Rifle',
        sourcerarity = 'Uncommon',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
            [ReagentData['part']['thoriumtube']] = 2,
            [ReagentData['element']['essenceofearth']] = 2,
            [ReagentData['gem']['azerothiandiamond']] = 2,
            [ReagentData['element']['essenceoffire']] = 2,
            [ReagentData['bar']['arcanite']] = 10,
            [ReagentData['leather']['enchanted']] = 2,
        }
    },
    ['Ultra-Flash Shadow Reflector'] = {
         skill = 300,
         description = '[BoE] [U] (Trinket) MinLvl: 55, Requires Engineering (300), Use: Reflects Shadow spells back at their caster for 5 seconds.',
         type = 'Devices',
         source = 'Drop:Schematic: Ultra-Flash Shadow Reflector',
         sourcerarity = 'Uncommon',
         result = 1,
         resultname = 'Ultra-Flash Shadow Reflector',
         resultrarity = 'Rare',
         reagents = {
              [ReagentData['bar']['darkiron']] = 8,
              [ReagentData['part']['truesilvertransformer']] = 4,
              [ReagentData['element']['livingessence']] = 6,
              [ReagentData['element']['essenceofundeath']] = 4,
              [ReagentData['gem']['azerothiandiamond']] = 2,
              [ReagentData['gem']['largeopal']] = 2,
         },
    },
    ['Force Reactive Disk'] = {
        skill = 300,
        description = '[BoE] (OH Shield) AC: 2548, Blk: 44, Sta: 11, MinLvl: 60, Requires Engineering (300), Equip: When the shield blocks it releases an electrical charge that damages all nearby enemies. This also has a chance of damaging the shield.',
        type = 'Shield',
        source = 'Drop:Schematic: Force Reactive Disk',
        sourcerarity = 'Rare',
        result = 1,
        resultrarity = 'Epic',
        reagents = {
            [ReagentData['element']['essenceofearth']] = 8,
            [ReagentData['element']['essenceofair']] = 8,
            [ReagentData['element']['livingessence']] = 12,
            [ReagentData['bar']['arcanite']] = 6,
            [ReagentData['part']['delicatearcaniteconverter']] = 2,
        }
    },
    ['Hyper-Radiant Flame Reflector'] = {
         skill = 290,
         description = '[BoE] [U] (Trinket) MinLvl: 53, Requires Engineering (290), Use: Reflects Fire spells back at their caster for 5 seconds.',
         type = 'Devices',
         source = 'Drop:Schematic: Hyper-Radiant Flame Reflector',
         sourcerarity = 'Uncommon',
         result = 1,
         resultname = 'Hyper-Radiant Flame Reflector',
         resultrarity = 'Rare',
         reagents = {
              [ReagentData['bar']['darkiron']] = 4,
              [ReagentData['part']['truesilvertransformer']] = 3,
              [ReagentData['element']['essenceofwater']] = 6,
              [ReagentData['gem']['starruby']] = 4,
              [ReagentData['gem']['azerothiandiamond']] = 2,
         }
    },
    ['World Enlarger'] = {
         skill = 260,
         description = '[BoE] [U] (Trinket) Requires Gnomish Engineering (250), Use: Enlarges the entire world for 5 minutes or until you attack.',
         type = 'Devices',
         source = 'Drop:Schematic: World Enlarger',
         sourcerarity = 'Uncommon',
         result = 1,
         resultname = 'World Enlarger',
         resultrarity = 'Uncommon',
         reagents = {
              [ReagentData['part']['mithrilcasing']] = 1,
              [ReagentData['part']['thoriumwidget']] = 2,
              [ReagentData['part']['goldpowercore']] = 1,
              [ReagentData['part']['unstabletrigger']] = 1,
              [ReagentData['gem']['citrine']] = 1,
         },
    },
    ['Alarm-O-Bot'] = {
         skill = 265,
         description = 'Requires Engineering (265), Use: Summons an Alarm-O-Bot for 10 minutes that occasionally sends out a pulse that detects nearby stealthy or invisible enemies.',
         type = 'Devices',
         source = 'Drop:Schematic: Alarm-O-Bot',
         sourcerarity = 'Uncommon',
         result = 1,
         resultname = 'Alarm-O-Bot',
         resultrarity = 'Common',
         reagents = {
              [ReagentData['bar']['thorium']] = 4,
              [ReagentData['part']['thoriumwidget']] = 2,
              [ReagentData['leather']['rugged']] = 4,
              [ReagentData['gem']['starruby']] = 1,
              [ReagentData['part']['fusedwiring']] = 1,
         },
    },
    ['Ultrasafe Transporter - Gadgetzan'] = {
         skill = 260,
         description = 'Requires Gnomish Engineering (260), Use: Safely transport yourself to Gadgetzan in Tanaris! Emphasis on Safe! Yup, nothing bad could ever happen while using this device!',
         type = 'Miscellaneous',
         source = 'Trainer',
         result = 1,
         reagents = {
              [ReagentData['bar']['mithril']] = 12,
              [ReagentData['part']['truesilvertransformer']] = 2,
              [ReagentData['element']['coreofearth']] = 4,
              [ReagentData['element']['globeofwater']] = 2,
              [ReagentData['gem']['aquamarine']] = 4,
              [ReagentData['part']['inlaidmithrilcylinder']] = 1,
         },
    },
    ['Bloodvine Goggles'] = {
        skill = 300,
        description = '[BoE] (Cloth Head) AC: 75, MinLvl: 60, Requires Engineering (300), Passive: Improves your chance to hit with spells by 2%., Passive: Improves your chance to get a critical strike with spells by 1%., Passive: Restores 9 mana every 5 sec.',
        type = 'Cloth',
        source = 'Vendor:Schematic: Bloodvine Goggles',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
             [ReagentData['herb']['bloodvine']] = 4,
             [ReagentData['gem']['souldarite']] = 5,
             [ReagentData['part']['delicatearcaniteconverter']] = 2,
             [ReagentData['monster']['powerfulmojo']] = 8,
             [ReagentData['leather']['enchanted']] = 4,
        }
    },
    ['Bloodvine Lens'] = {
        skill = 300,
        description = '[BoE] (Leather Head) AC: 147, Sta: 12, MinLvl: 60, Requires Engineering (300), Passive: Improves your chance to get a critical strike by 2%., Passive: Slightly increases your stealth detection.',
        type = 'Leather',
        source = 'Vendor:Schematic: Bloodvine Lens',
        result = 1,
        resultrarity = 'Rare',
        reagents = {
             [ReagentData['herb']['bloodvine']] = 5,
             [ReagentData['gem']['souldarite']] = 5,
             [ReagentData['part']['delicatearcaniteconverter']] = 1,
             [ReagentData['monster']['powerfulmojo']] = 8,
             [ReagentData['leather']['enchanted']] = 4,
        }
    },
}
end