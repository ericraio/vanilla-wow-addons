function ReagentData_LoadCooking()
ReagentData['crafted']['cooking'] = {
    ['Brilliant Smallfish'] = {
        skill = 1,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Brilliant Smallfish',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawbrilliantsmall']] = 1,
        }
    },
    ['Charred Wolf Meat'] = {
        skill = 1,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['monster']['stringywolfmeat']] = 1,
        }
    },
    ['Crispy Bat Wing'] = {
        skill = 1,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 2 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Crispy Bat Wing',
        result = 1,
        reagents = {
            [ReagentData['monster']['meatybatwing']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Gingerbread Cookie'] = {
        skill = 1,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 2 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Gingerbread Cookie',
        result = 1,
        reagents = {
            [ReagentData['spice']['holiday']] = 1,
            [ReagentData['monster']['smallegg']] = 1,
        }
    },
    ['Herb Baked Egg'] = {
        skill = 1,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 2 Stamina and Spirit for 15 min.',
        source = 'Trainer:Recipe: Herb Baked Egg',
        result = 1,
        reagents = {
            [ReagentData['monster']['smallegg']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Roasted Boar Meat'] = {
        skill = 1,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['monster']['chunkofboarmeat']] = 1,
        }
    },
    ['Slitherskin Mackerel'] = {
        skill = 1,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Slitherskin Mackerel',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawslitherskinmackerel']] = 1,
        }
    },
    ['Kaldorei Spider Kabob'] = {
        skill = 10,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 2 Stamina and Spirit for 15 min.',
        source = 'Quest:Recipe: Kaldorei Spider Kabob',
        result = 1,
        reagents = {
            [ReagentData['monster']['smallspiderleg']] = 1,
        }
    },
    ['Spiced Wolf Meat'] = {
        skill = 10,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 2 Stamina and Spirit for 15 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['monster']['stringywolfmeat']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Scorpid Surprise'] = {
        skill = 20,
        description = 'Use: Heals 294 damage over 21 sec, assuming you don\'t bite down on a poison sac.',
        source = 'Vendor:Recipe: Scorpid Surprise',
        result = 1,
        reagents = {
            [ReagentData['monster']['scorpidstinger']] = 1,
        }
    },
    ['Beer Basted Boar Ribs'] = {
        skill = 25,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 2 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Beer Basted Boar Ribs',
        result = 1,
        reagents = {
            [ReagentData['monster']['cragboarrib']] = 1,
            [ReagentData['drink']['rhapsodymalt']] = 1,
        }
    },
    ['Egg Nog'] = {
        skill = 35,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 2 Stamina and Spirit for 15 min. Also packs quite a kick...',
        source = 'Vendor:Recipe: Egg Nog',
        result = 1,
        reagents = {
            [ReagentData['spice']['holiday']] = 1,
            [ReagentData['monster']['smallegg']] = 1,
            [ReagentData['drink']['holidyspirits']] = 1,
            [ReagentData['drink']['icecoldmilk']] = 1,
        }
    },
    ['Roasted Kodo Meat'] = {
        skill = 35,
        description = 'Use: Restores 61 health over 18 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 2 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Roasted Kodo Meat',
        result = 2,
        reagents = {
            [ReagentData['spice']['mild']] = 1,
            [ReagentData['monster']['kodomeat']] = 1,
        }
    },
    ['Smoked Bear Meat'] = {
        skill = 40,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Smoked Bear Meat',
        result = 1,
        reagents = {
            [ReagentData['monster']['bearmeat']] = 1,
        }
    },
    ['Boiled Clams'] = {
        skill = 50,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 4 Stamina and Spirit for 15 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['monster']['clawmeat']] = 1,
            [ReagentData['drink']['refreshingspringwater']] = 1,
        }
    },
    ['Coyote Steak'] = {
        skill = 50,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 4 Stamina and Spirit for 15 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['monster']['coyotemeat']] = 1,
        }
    },
    ['Fillet of Frenzy'] = {
        skill = 50,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 4 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Fillet of Frenzy',
        result = 2,
        reagents = {
         [ReagentData['monster']['softfrenzyflesh']] = 1,
         [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Goretusk Liver Pie'] = {
        skill = 50,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 4 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Goretusk Liver Pie',
        result = 1,
        reagents = {
            [ReagentData['monster']['goretuskliver']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Loch Frenzy Delight'] = {
        skill = 50,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Loch Frenzy Delight',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawlochfrenzy']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Longjaw Mud Snapper'] = {
        skill = 50,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Longjaw Mud Snapper',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawlongjawmudsnapper']] = 1,
        }
    },
    ['Rainbow Fin Albacore'] = {
        skill = 50,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Rainbow Fin Albacore',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawrainbowfinalbacore']] = 1,
        }
    },
    ['Strider Stew'] = {
        skill = 50,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 4 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Strider Stew',
        result = 2,
        reagents = {
            [ReagentData['monster']['stridermeat']] = 1,
            [ReagentData['food']['shinyredapple']] = 1,
        }
    },
    ['Blood Sausage'] = {
        skill = 60,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 4 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Blood Sausage',
        result = 2,
        reagents = {
            [ReagentData['monster']['spiderichor']] = 1,
            [ReagentData['monster']['bearmeat']] = 1,
            [ReagentData['monster']['boarintestines']] = 1,
        }
    },
    ['Thistle Tea'] = {
        skill = 60,
        description = 'MinLvl: 5, Classes: Rogue, Use: Instantly restores 100 energy.',
        source = 'Vendor, Quest:Recipe: Thistle Tea',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['herb']['swifthistle']] = 1,
            [ReagentData['drink']['refreshingspringwater']] = 1,
        }
    },
    ['Crab Cake'] = {
        skill = 75,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 4 Stamina and Spirit for 15 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['monster']['crawlermeat']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Westfall Stew'] = {
        skill = 75,
        description = 'MinLvl: 5, Use: Restores 552 health over 24 sec. Must remain seated while eating.',
        source = 'Vendor, Quest:Recipe: Westfall Stew',
        result = 1,
        reagents = {
            [ReagentData['monster']['murloceye']] = 1,
            [ReagentData['monster']['goretusksnout']] = 1,
            [ReagentData['monster']['stringyvulturemeat']] = 1,
        }
    },
    ['Crocolisk Steak'] = {
        skill = 80,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 4 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Crocolisk Steak',
        result = 1,
        reagents = {
            [ReagentData['monster']['crocoliskmeat']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Dry Pork Ribs'] = {
        skill = 80,
        description = 'MinLvl: 5, Use: Restores 243 health over 21 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 4 Stamina and Spirit for 15 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['monster']['boarribs']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Cooked Crab Claw'] = {
        skill = 85,
        description = 'MinLvl: 5, Use: Restores 294 health and 294 mana over 21 sec. Must remain seated while eating.',
        source = 'Drop, Vendor:Recipe: Cooked Crab Claw',
        result = 1,
        reagents = {
            [ReagentData['monster']['crawlerclaw']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Savory Deviate Delight'] = {
        skill = 85,
        description = 'Use: Eat me.',
        source = 'Drop:Recipe: Savory Deviate Delight',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['deviate']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Clam Chowder'] = {
        skill = 90,
        description = 'MinLvl: 10, Use: Restores 552 health over 24 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Clam Chowder',
        result = 1,
        reagents = {
            [ReagentData['monster']['clawmeat']] = 1,
            [ReagentData['drink']['icecoldmilk']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Dig Rat Stew'] = {
        skill = 90,
        description = 'MinLvl: 10, Use: Restores 552 health over 24 sec. Must remain seated while eating.',
        source = 'Quest:Recipe: Dig Rat Stew',
        result = 2,
        reagents = {
            [ReagentData['monster']['digrat']] = 1,
        }
    },
    ['Murloc Fin Soup'] = {
        skill = 90,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Murloc Fin Soup',
        result = 1,
        reagents = {
            [ReagentData['monster']['murlocfin']] = 2,
            [ReagentData['spice']['hot']] = 1,
        }
    },
    ['Bristle Whisker Catfish'] = {
        skill = 100,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Bristle Whisker Catfish',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawbristlewhiskercat']] = 1,
        }
    },
    ['Crispy Lizard Tail'] = {
        skill = 100,
        description = 'MinLvl: 12, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Crispy Lizard Tail',
        result = 2,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['thunderlizardtail']] = 1,
        }
    },
    ['Redridge Goulash'] = {
        skill = 100,
        description = 'MinLvl: 10, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Redridge Goulash',
        result = 1,
        reagents = {
            [ReagentData['monster']['toughcondormeat']] = 1,
            [ReagentData['monster']['crispspidermeat']] = 1,
        }
    },
    ['Seasoned Wolf Kabob'] = {
        skill = 100,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Seasoned Wolf Kabob',
        result = 3,
        reagents = {
            [ReagentData['monster']['leanwolfflank']] = 2,
            [ReagentData['spice']['stormwindseasoningherbs']] = 1,
        }
    },
    ['Big Bear Steak'] = {
        skill = 110,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Big Bear Steak',
        result = 1,
        reagents = {
            [ReagentData['monster']['bigbearmeat']] = 1,
            [ReagentData['spice']['hot']] = 1,
        }
    },
    ['Gooey Spider Cake'] = {
        skill = 110,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Gooey Spider Cake',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['gooeyspiderleg']] = 2,
        }
    },
    ['Lean Venison'] = {
        skill = 110,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Lean Venison',
        result = 2,
        reagents = {
            [ReagentData['monster']['stagmeat']] = 1,
            [ReagentData['spice']['mild']] = 4,
        }
    },
    ['Succulent Pork Ribs'] = {
        skill = 110,
        description = 'MinLvl: 10, Use: Restores 552 health over 24 sec. Must remain seated while eating.',
        source = 'Drop, Vendor:Recipe: Succulent Pork Ribs',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['boarribs']] = 2,
        }
    },
    ['Crocolisk Gumbo'] = {
        skill = 120,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Crocolisk Gumbo',
        result = 1,
        reagents = {
            [ReagentData['monster']['tendercrocoliskmeat']] = 1,
            [ReagentData['spice']['hot']] = 1,
        }
    },
    ['Goblin Deviled Clams'] = {
        skill = 125,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['tangyclammeat']] = 1,
        }
    },
    ['Hot Lion Chops'] = {
        skill = 125,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Hot Lion Chops',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['lionmeat']] = 1,
        }
    },
    ['Lean Wolf Steak'] = {
        skill = 125,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Lean Wolf Steak',
        result = 1,
        reagents = {
            [ReagentData['monster']['leanwolfflank']] = 1,
            [ReagentData['spice']['mild']] = 1,
        }
    },
    ['Curiously Tasty Omelet'] = {
        skill = 130,
        description = 'MinLvl: 15, Use: Restores 552 health over 24 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 6 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Curiously Tasty Omelet',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['raptoregg']] = 1,
        }
    },
    ['Tasty Lion Steak'] = {
        skill = 150,
        description = 'MinLvl: 20, Use: Restores 874 health over 27 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 8 Stamina and Spirit for 15 min.',
        source = 'Quest:Recipe: Tasty Lion Steak',
        result = 1,
        reagents = {
            [ReagentData['spice']['soothing']] = 1,
            [ReagentData['monster']['lionmeat']] = 2,
        }
    },
    ['Barbecued Buzzard Wing'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 874 health over 27 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 8 Stamina and Spirit for 15 min.',
        source = 'Vendor, Quest:Recipe: Barbecued Buzzard Wing',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['buzzardwing']] = 1,
        }
    },
    ['Carrion Surprise'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 874 health over 27 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 8 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Carrion Surprise',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['mysterymeat']] = 1,
        }
    },
    ['Giant Clam Scorcho'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 874 health over 27 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 8 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Giant Clam Scorcho',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['giantclammeat']] = 1,
        }
    },
    ['Goldthorn Tea'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 1344 mana over 27 sec. Must remain seated while drinking.',
        source = 'Unknown',
        result = 4,
        reagents = {
            [ReagentData['herb']['goldthorn']] = 1,
            [ReagentData['drink']['refreshingspringwater']] = 1,
        }
    },
    ['Hot Wolf Ribs'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 874 health over 27 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 8 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Hot Wolf Ribs',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['redwolfmeat']] = 1,
        }
    },
    ['Jungle Stew'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 874 health over 27 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 8 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Jungle Stew',
        result = 2,
        reagents = {
            [ReagentData['food']['shinyredapple']] = 2,
            [ReagentData['monster']['tigermeat']] = 1,
            [ReagentData['drink']['refreshingspringwater']] = 1,
        }
    },
    ['Mithril Headed Trout'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 874 health over 27 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Mithril Head Trout',
        result = 1,
        resultname = 'Mithril Head Trout',
        reagents = {
            [ReagentData['cookingfish']['rawmithrilheadtrout']] = 1,
        }
    },
    ['Mystery Stew'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 874 health over 27 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 8 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Mystery Stew',
        result = 1,
        reagents = {
            [ReagentData['monster']['mysterymeat']] = 1,
            [ReagentData['drink']['skinofdwarvenstout']] = 1,
        }
    },
    ['Roast Raptor'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 874 health over 27 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 8 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Roast Raptor',
        result = 1,
        reagents = {
            [ReagentData['monster']['raptorflesh']] = 1,
            [ReagentData['spice']['hot']] = 1,
        }
    },
    ['Rockscale Cod'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 874 health over 27 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Rockscale Cod',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawrockscalecod']] = 1,
        }
    },
    ['Soothing Turtle Bisque'] = {
        skill = 175,
        description = 'MinLvl: 25, Use: Restores 874 health over 27 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 8 Stamina and Spirit for 15 min.',
        source = 'Quest:Recipe: Soothing Turtle Bisque',
        result = 1,
        reagents = {
            [ReagentData['spice']['soothing']] = 1,
            [ReagentData['monster']['turtlemeat']] = 1,
        }
    },
    ['Dragonbreath Chili'] = {
        skill = 200,
        description = 'MinLvl: 35, Use: Occasionally belch flame at enemies struck in melee for the next 10 min.',
        source = 'Vendor:Recipe: Dragonbreath Chili',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['monster']['smallflamesac']] = 1,
            [ReagentData['monster']['mysterymeat']] = 1,
        }
    },
    ['Heavy Kodo Stew'] = {
        skill = 200,
        description = 'MinLvl: 35, Use: Restores 1392 health over 30 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 12 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Heavy Kodo Stew',
        result = 2,
        reagents = {
            [ReagentData['spice']['soothing']] = 1,
            [ReagentData['monster']['heavykodomeat']] = 2,
            [ReagentData['drink']['refreshingspringwater']] = 1,
        }
    },
    ['Spider Sausage'] = {
        skill = 200,
        description = 'MinLvl: 35, Use: Restores 1392 health over 30 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 12 Stamina and Spirit for 15 min.',
        source = 'Trainer',
        result = 1,
        reagents = {
            [ReagentData['monster']['whitespidermeat']] = 2,
        }
    },
    ['Cooked Glossy Mightfish'] = {
        skill = 225,
        description = 'MinLvl: 35, Use: Restores 874 health over 27 sec. Must remain seated while eating. Also increases your Stamina by 10 for 10 min.',
        source = 'Vendor:Recipe: Cooked Glossy Mightfish',
        result = 1,
        reagents = {
            [ReagentData['spice']['soothing']] = 1,
            [ReagentData['cookingfish']['rawglossymightfish']] = 1,
        }
    },
    ['Filet of Redgill'] = {
        skill = 225,
        description = 'MinLvl: 35, Use: Restores 1392 health over 30 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Filet of Redgill',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawredgill']] = 1,
        }
    },
    ['Monster Omelet'] = {
        skill = 225,
        description = 'MinLvl: 40, Use: Restores 1392 health over 30 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 12 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Monster Omelet',
        result = 1,
        reagents = {
            [ReagentData['spice']['soothing']] = 2,
            [ReagentData['monster']['giantegg']] = 1,
        }
    },
    ['Spiced Chili Crab'] = {
        skill = 225,
        description = 'MinLvl: 40, Use: Restores 1392 health over 30 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 12 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Spiced Chili Crab',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 2,
            [ReagentData['monster']['tendercrabmeat']] = 1,
        }
    },
    ['Spotted Yellowtail'] = {
        skill = 225,
        description = 'MinLvl: 35, Use: Restores 1392 health over 30 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Spotted Yellowtail',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawspottedyellowtail']] = 1,
        }
    },
    ['Tender Wolf Steak'] = {
        skill = 225,
        description = 'MinLvl: 40, Use: Restores 1392 health over 30 sec. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 12 Stamina and Spirit for 15 min.',
        source = 'Vendor:Recipe: Tender Wolf Steak',
        result = 1,
        reagents = {
            [ReagentData['spice']['soothing']] = 1,
            [ReagentData['monster']['tenderwolfmeat']] = 1,
        }
    },
    ['Undermine Clam Chowder'] = {
        skill = 225,
        description = 'MinLvl: 35, Use: Restores 1392 health over 30 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Undermine Clam Chowder',
        result = 2,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['drink']['icecoldmilk']] = 1,
            [ReagentData['monster']['zestyclammeat']] = 2,
        }
    },
    ['Grilled Squid'] = {
        skill = 240,
        description = 'MinLvl: 35, Use: Restores 874 health over 27 sec. Must remain seated while eating. If you eat for 10 seconds will also increase your Agility by 10 for 10 min.',
        source = 'Vendor:Recipe: Grilled Squid',
        result = 1,
        reagents = {
            [ReagentData['spice']['soothing']] = 1,
            [ReagentData['cookingfish']['wintersquid']] = 1,
        }
    },
    ['Hot Smoked Bass'] = {
        skill = 240,
        description = 'MinLvl: 35, Use: Restores 874 health over 27 sec. Must remain seated while eating. Also increases your Spirit by 10 for 10 min.',
        source = 'Vendor:Recipe: Hot Smoked Bass',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 2,
            [ReagentData['cookingfish']['rawsummerbass']] = 1,
        }
    },
    ['Nightfin Soup'] = {
        skill = 250,
        description = 'MinLvl: 35, Use: Restores 874 health over 27 sec. Must remain seated while eating. Also restores 8 Mana every 5 seconds for 10 min.',
        source = 'Vendor:Recipe: Nightfin Soup',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawnightfinsnapper']] = 1,
            [ReagentData['drink']['refreshingspringwater']] = 1,
        }
    },
    ['Poached Sunscale Salmon'] = {
        skill = 250,
        description = 'MinLvl: 35, Use: Restores 874 health over 27 sec. Must remain seated while eating. Also restores 6 health every 5 seconds for 10 min.',
        source = 'Vendor:Recipe: Poached Sunscale Salmon',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['rawsunscalesalmon']] = 1,
        }
    },
    ['Baked Salmon'] = {
        skill = 275,
        description = 'MinLvl: 45, Use: Restores 2148 health over 30 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Baked Salmon',
        result = 1,
        reagents = {
            [ReagentData['spice']['soothing']] = 1,
            [ReagentData['cookingfish']['rawwhitescalesalmon']] = 1,
        }
    },
    ['Lobster Stew'] = {
        skill = 275,
        description = 'MinLvl: 45, Use: Restores 2148 health over 30 sec. Must remain seated while eating.',
        source = 'Vendor:Recipe: Lobster Stew',
        result = 1,
        reagents = {
            [ReagentData['cookingfish']['darkclawlobster']] = 1,
            [ReagentData['drink']['refreshingspringwater']] = 1,
        }
    },
    ['Mightfish Steak'] = {
        skill = 275,
        description = 'MinLvl: 45, Use: Restores 1933 health over 27 sec. Must remain seated while eating. Also increases your Stamina by 10 for 10 min.',
        source = 'Vendor:Recipe: Mightfish Steak',
        result = 1,
        reagents = {
            [ReagentData['spice']['hot']] = 1,
            [ReagentData['spice']['soothing']] = 1,
            [ReagentData['cookingfish']['largerawmightfish']] = 1,
        }
    },
    ['Runn Tum Tuber Surprise'] = {
        skill = 275,
        description = 'MinLvl: 45, Use: Restores 1933 health over 27 sec. Must remain seated while eating. Also increases your Intellect by 10 for 10 min.',
        source = 'Drop:Recipe: Runn Tum Tuber Surprise',
        sourcerarity = 'Uncommon',
        result = 1,
        reagents = {
         [ReagentData['other']['runntumtuber']] = 1,
         [ReagentData['spice']['soothing']] = 1,
        }
    },
    ['Smoked Desert Dumplings'] = {
        skill = 275,
        description = 'MinLvl: 45, Use:  Restores 2148 health over 30 seconds. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 20 Strength for 15 minutes.',
        source = 'Quest:Silithus',
        result = 1,
        reagents = {
         [ReagentData['monster']['sandwormmeat']] = 1,
         [ReagentData['spice']['soothing']] = 1,
        }
    },
    ["Dirge\'s Kickin\' Chimaerok Chops"] = {
        skill = 300,
        description = 'MinLvl: 55, Use: Restores 2550 health over 30 seconds. Must remain seated while eating. If you spend at least 10 seconds eating you will become well fed and gain 25 Stamina for 15 minutes.',
        source = "Drop:Recipe: Dirge\'s Kickin\' Chimaerok Chops",
        sourcerarity = 'Epic',
        result = 1,
        reagents = {
         [ReagentData['monster']['chimaeroktenderloin']] = 1,
         [ReagentData['spice']['hot']] = 1,
         [ReagentData['oil']['goblinrocketfuel']] = 1,
         [ReagentData['salt']['deeprock']] = 1,
        }
    },
}
end