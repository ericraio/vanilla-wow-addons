function ReagentData_LoadQuestItems()

if (GetLocale() == "deDE") then
    ReagentData_LoadQuestItemsGerman();
elseif (GetLocale() == "frFR") then
    ReagentData_LoadQuestItemsFrench();
elseif (GetLocale() == "zhCN") then
	ReagentData_LoadQuestItemsChinese();
else
    ReagentData_LoadQuestItemsEnglish();
end

-- Now the class specific uses
ReagentData["quest"]["Zul\'Gurub"]["use"] = {
     [ReagentData["classes"]["druid"]] = {
      [ReagentData["location"]["wrist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["stanchion"]] = 1,
      },
      [ReagentData["location"]["waist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["sash"]] = 1,
      },
      [ReagentData["location"]["chest"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["tabard"]] = 1,
      },
	  [ReagentData["location"]["enchant"]] = {
	       [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["idol"]] = 1,
		   [ReagentData["quest"]["Zul\'Gurub"]["item"]["doll"]["voodoo"]] = 1,
	  },
     },
     [ReagentData["classes"]["hunter"]] = {
      [ReagentData["location"]["wrist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["bindings"]] = 1,
      },
      [ReagentData["location"]["waist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["shawl"]] = 1,
      },
      [ReagentData["location"]["shoulder"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["aegis"]] = 1,
      },
	  [ReagentData["location"]["enchant"]] = {
	       [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["idol"]] = 1,
		   [ReagentData["quest"]["Zul\'Gurub"]["item"]["doll"]["voodoo"]] = 1,
	  },
     },
     [ReagentData["classes"]["mage"]] = {
      [ReagentData["location"]["wrist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["bindings"]] = 1,
      },
      [ReagentData["location"]["shoulder"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["shawl"]] = 1,
      },
      [ReagentData["location"]["chest"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["kossack"]] = 1,
      },
	  [ReagentData["location"]["enchant"]] = {
	       [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["idol"]] = 1,
		   [ReagentData["quest"]["Zul\'Gurub"]["item"]["doll"]["voodoo"]] = 1,
	  },
     },
     [ReagentData["classes"]["paladin"]] = {
      [ReagentData["location"]["wrist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["bindings"]] = 1,
      },
      [ReagentData["location"]["waist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["shawl"]] = 1,
      },
      [ReagentData["location"]["chest"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["tabard"]] = 1,
      },
	  [ReagentData["location"]["enchant"]] = {
	       [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["idol"]] = 1,
		   [ReagentData["quest"]["Zul\'Gurub"]["item"]["doll"]["voodoo"]] = 1,
	  },
     },
     [ReagentData["classes"]["priest"]] = {
      [ReagentData["location"]["wrist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["stanchion"]] = 1,
      },
      [ReagentData["location"]["waist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["sash"]] = 1,
      },
      [ReagentData["location"]["shoulder"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["aegis"]] = 1,
      },
	  [ReagentData["location"]["enchant"]] = {
	       [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["idol"]] = 1,
		   [ReagentData["quest"]["Zul\'Gurub"]["item"]["doll"]["voodoo"]] = 1,
	  },
     },
     [ReagentData["classes"]["rogue"]] = {
      [ReagentData["location"]["wrist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["armsplint"]] = 1,
      },
      [ReagentData["location"]["shoulder"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["girdle"]] = 1,
      },
      [ReagentData["location"]["chest"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["aegis"]] = 1,
      },
	  [ReagentData["location"]["enchant"]] = {
	       [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["idol"]] = 1,
		   [ReagentData["quest"]["Zul\'Gurub"]["item"]["doll"]["voodoo"]] = 1,
	  },
     },
     [ReagentData["classes"]["shaman"]] = {
      [ReagentData["location"]["wrist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["armsplint"]] = 1,
      },
      [ReagentData["location"]["waist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["girdle"]] = 1,
      },
      [ReagentData["location"]["chest"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["tabard"]] = 1,
      },
	  [ReagentData["location"]["enchant"]] = {
	       [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["idol"]] = 1,
		   [ReagentData["quest"]["Zul\'Gurub"]["item"]["doll"]["voodoo"]] = 1,
	  },
     },
     [ReagentData["classes"]["warlock"]] = {
      [ReagentData["location"]["wrist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["stanchion"]] = 1,
      },
      [ReagentData["location"]["shoulder"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["sash"]] = 1,
      },
      [ReagentData["location"]["chest"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["kossack"]] = 1,
      },
	  [ReagentData["location"]["enchant"]] = {
	       [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["idol"]] = 1,
		   [ReagentData["quest"]["Zul\'Gurub"]["item"]["doll"]["voodoo"]] = 1,
	  },
     },
     [ReagentData["classes"]["warrior"]] = {
      [ReagentData["location"]["wrist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["armsplint"]] = 1,
      },
      [ReagentData["location"]["waist"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["girdle"]] = 1,
      },
      [ReagentData["location"]["chest"]] = {
           [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["kossack"]] = 1,
      },
	  [ReagentData["location"]["enchant"]] = {
	       [ReagentData["quest"]["Zul\'Gurub"]["item"]["primal"]["idol"]] = 1,
		   [ReagentData["quest"]["Zul\'Gurub"]["item"]["doll"]["voodoo"]] = 1,
	  },
     },
};

ReagentData["quest"]["Ruins of Anh\'Qiraj"]["use"] = {
	[ReagentData["classes"]["druid"]] = {
		[ReagentData["location"]["finger"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["ring"]["magisterial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["alabaster"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
		},
		[ReagentData["location"]["back"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["drape"]["regal"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["vermillion"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
		},
		[ReagentData["location"]["weapon"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["hilt"]["ornate"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["jasper"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
		},
	},
	[ReagentData["classes"]["hunter"]] = {
		[ReagentData["location"]["finger"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["ring"]["ceremonial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["amber"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
		},
		[ReagentData["location"]["back"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["drape"]["regal"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["lambent"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
		},
		[ReagentData["location"]["weapon"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["hilt"]["spiked"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["azure"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
		},
	},
	[ReagentData["classes"]["mage"]] = {
		[ReagentData["location"]["finger"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["ring"]["magisterial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["azure"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
		},
		[ReagentData["location"]["back"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["drape"]["martial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["alabaster"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
		},
		[ReagentData["location"]["weapon"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["hilt"]["ornate"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["obsidian"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
		},
	},
	[ReagentData["classes"]["paladin"]] = {
		[ReagentData["location"]["finger"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["ring"]["magisterial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["vermillion"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
		},
		[ReagentData["location"]["back"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["drape"]["regal"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["obsidian"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
		},
		[ReagentData["location"]["weapon"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["hilt"]["spiked"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["amber"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
		},
	},
	[ReagentData["classes"]["priest"]] = {
		[ReagentData["location"]["finger"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["ring"]["ceremonial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["obsidian"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
		},
		[ReagentData["location"]["back"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["drape"]["martial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["jasper"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
		},
		[ReagentData["location"]["weapon"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["hilt"]["ornate"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["lambent"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
		},
	},
	[ReagentData["classes"]["rogue"]] = {
		[ReagentData["location"]["finger"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["ring"]["ceremonial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["onyx"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
		},
		[ReagentData["location"]["back"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["drape"]["martial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["azure"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
		},
		[ReagentData["location"]["weapon"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["hilt"]["spiked"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["vermillion"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
		},
	},
	[ReagentData["classes"]["shaman"]] = {
		[ReagentData["location"]["finger"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["ring"]["magisterial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["vermillion"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
		},
		[ReagentData["location"]["back"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["drape"]["regal"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["obsidian"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
		},
		[ReagentData["location"]["weapon"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["hilt"]["spiked"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["amber"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
		},
	},
	[ReagentData["classes"]["warlock"]] = {
		[ReagentData["location"]["finger"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["ring"]["ceremonial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["jasper"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
		},
		[ReagentData["location"]["back"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["drape"]["regal"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["lambent"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
		},
		[ReagentData["location"]["weapon"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["hilt"]["ornate"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["onyx"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
		},
	},
	[ReagentData["classes"]["warrior"]] = {
		[ReagentData["location"]["finger"]]= {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["ring"]["magisterial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["lambent"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
		},
		[ReagentData["location"]["back"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["drape"]["martial"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["onyx"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
		},
		[ReagentData["location"]["weapon"]] = {
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["hilt"]["spiked"]] = 1,
			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["idol"]["alabaster"]] = 2,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
--~ 			[ReagentData["quest"]["Ruins of Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
		},
	},
};

ReagentData["quest"]["Anh\'Qiraj"]["use"] = {
     [ReagentData["classes"]["druid"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["circlet"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["life"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["dominance"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["strife"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["husk"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["rebirth"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["skin"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["war"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["dominance"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["rebirth"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
        },
    },
     [ReagentData["classes"]["hunter"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["diadem"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["strife"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["command"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["war"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["carapace"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["life"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["skin"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sun"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["command"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["life"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
    },
     [ReagentData["classes"]["mage"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["circlet"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["night"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["dominance"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["death"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["husk"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sun"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["hide"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sage"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["dominance"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sun"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
        },
    },
     [ReagentData["classes"]["paladin"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["diadem"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["rebirth"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["dominance"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["life"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["carapace"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sage"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["skin"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["strife"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["dominance"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sage"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
        },
    },
     [ReagentData["classes"]["priest"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["circlet"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sage"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["command"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["rebirth"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["husk"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["death"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["hide"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["life"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["command"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["death"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
        },
    },
     [ReagentData["classes"]["rogue"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["diadem"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["war"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["command"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sun"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["carapace"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["strife"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["hide"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["night"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["command"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["strife"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
    },
     [ReagentData["classes"]["shaman"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["diadem"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["rebirth"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["dominance"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["life"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["carapace"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sage"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["skin"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["strife"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["dominance"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sage"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
        },
    },
     [ReagentData["classes"]["warlock"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["circlet"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["death"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["dominance"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sage"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["husk"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["night"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["skin"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["rebirth"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["dominance"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["night"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
        },
    },
     [ReagentData["classes"]["warrior"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["circlet"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["sun"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["crystal"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["command"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["night"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["clay"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["stone"]] = 5,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["carapace"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["war"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["silver"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bone"]] = 5,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["hide"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["death"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["bronze"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["part"]["command"]] = 1,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["idol"]["war"]] = 2,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["ivory"]] = 5,
            [ReagentData["quest"]["Anh\'Qiraj"]["item"]["scarab"]["gold"]] = 5,
        },
    },
};

ReagentData["quest"]["Naxxramas"]["use"] = {
    [ReagentData["classes"]["druid"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["headpiece"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 15,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["spaulders"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["tunic"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 25,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["wrist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["wristguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["gem"]["arcanecrystal"]] = 1,
        },
        [ReagentData["location"]["hands"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["handguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
        },
        [ReagentData["location"]["waist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["girdle"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 3,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["legguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 20,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["boots"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 3,
        },
    },
    [ReagentData["classes"]["hunter"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["headpiece"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 15,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 4,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["spaulders"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 2,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["tunic"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 25,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 4,
        },
        [ReagentData["location"]["wrist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["wristguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
        [ReagentData["location"]["hands"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["handguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
        [ReagentData["location"]["waist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["girdle"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 3,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["legguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 20,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 3,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["boots"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
    },
    [ReagentData["classes"]["mage"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["circlet"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 15,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 3,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["shoulderpads"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 2,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["robe"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 25,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 4,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["wrist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["bindings"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["gem"]["arcanecrystal"]] = 1,
        },
        [ReagentData["location"]["hands"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["gloves"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 4,
        },
        [ReagentData["location"]["waist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["belt"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["gem"]["arcanecrystal"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 2,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["leggings"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 20,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 4,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["sandals"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 3,
        },
    },
    [ReagentData["classes"]["paladin"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["headpiece"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 15,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 5,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["spaulders"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["tunic"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 25,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 2,
        },
        [ReagentData["location"]["wrist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["wristguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
        [ReagentData["location"]["hands"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["handguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
        [ReagentData["location"]["waist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["girdle"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 3,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["legguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 20,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 4,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["boots"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 2,
        },
    },
    [ReagentData["classes"]["priest"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["circlet"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 15,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 3,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["shoulderpads"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 2,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["robe"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 25,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 4,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["wrist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["bindings"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["gem"]["arcanecrystal"]] = 1,
        },
        [ReagentData["location"]["hands"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["gloves"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 4,
        },
        [ReagentData["location"]["waist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["belt"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["gem"]["arcanecrystal"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 2,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["leggings"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 20,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 4,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["sandals"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 2,
        },
    },
    [ReagentData["classes"]["rogue"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["helmet"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 15,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["pauldrons"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["breastplate"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 25,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 2,
        },
        [ReagentData["location"]["wrist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["bracers"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
        [ReagentData["location"]["hands"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["gauntlets"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
        [ReagentData["location"]["waist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["waistguard"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["legplates"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 20,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["sabatons"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["leather"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
    },
    [ReagentData["classes"]["shaman"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["headpiece"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 15,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 4,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["spaulders"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 2,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["tunic"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 25,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 4,
        },
        [ReagentData["location"]["wrist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["wristguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
        [ReagentData["location"]["hands"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["handguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
        [ReagentData["location"]["waist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["girdle"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 3,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["legguards"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 20,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 3,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["boots"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["chain"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 3,
        },
    },
    [ReagentData["classes"]["warlock"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["circlet"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 15,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 3,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["shoulderpads"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 2,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["robe"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 25,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 4,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["wrist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["bindings"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["gem"]["arcanecrystal"]] = 1,
        },
        [ReagentData["location"]["hands"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["gloves"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 4,
        },
        [ReagentData["location"]["waist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["belt"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["gem"]["arcanecrystal"]] = 2,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 2,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["leggings"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 20,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 4,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["sandals"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["cloth"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["cloth"]["moon"]] = 2,
        },
    },
    [ReagentData["classes"]["warrior"]] = {
        [ReagentData["location"]["head"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["helmet"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 15,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
        },
        [ReagentData["location"]["shoulder"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["pauldrons"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 2,
        },
        [ReagentData["location"]["chest"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["breastplate"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 25,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 4,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 2,
        },
        [ReagentData["location"]["wrist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["bracers"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 6,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["shard"]["nexuscrystal"]] = 1,
        },
        [ReagentData["location"]["hands"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["gauntlets"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
        },
        [ReagentData["location"]["waist"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["waistguard"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 8,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 5,
        },
        [ReagentData["location"]["legs"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["legplates"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 20,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 4,
        },
        [ReagentData["location"]["feet"]] = {
            [ReagentData["quest"]["Naxxramas"]["item"]["desecrated"]["sabatons"]] = 1,
            [ReagentData["quest"]["Naxxramas"]["item"]["scrap"]["plate"]] = 12,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["hide"]["curedrugged"]] = 3,
            [ReagentData["quest"]["Naxxramas"]["item"]["other"]["bar"]["arcanite"]] = 2,
        },
    },
};
-- ReagentData_IsQuestItem(item, [zone])
--
-- This function takes an item and returns the zone in which the item is used (false if none).
-- If a zone is specified as well as the item name, the function will return true or false
-- depending on whether the item is used in quests in that zone or not

function ReagentData_IsQuestItem(item, zone)
    if (item == nil or ReagentData["quest"] == nil) then
       return false;
    end
    
    for checkzone, outerarrays in ReagentData["quest"] do
        if (zone == nil or zone == ""  or checkzone == zone) then
            for itemclass, innerarrays in outerarrays["item"] do
                for trash, checkitem in innerarrays do
                    if (checkitem == item) then
                        return checkzone;
                    end
                end
            end
        end
    end
    
    return false;
end

-- ReagentData_QuestUsage(item, zone)
--
-- This function takes an item and a zone.  It then returns some information about the usage of that item
-- in the zone.  Because there's no way to predict how this could be used in the future (Blizzard could
-- do anything with new quests), the data returned will depend completely on the zone.  Fun, huh?  False will
-- always be returned on non matches.
--
-- Zul'Gurub
-- ---------
-- For Zul'Gurub, the function will return an array.  Each element in this array will be a two element array
-- like {class, armor part}.  This will allow you to determine which classes use which items for which pieces
-- of armor.  For example, calling ReagentData_QuestUsage("Primal Hakkari Aegis", "Zul\'Gurub") will return:
-- {{"hunter", "shoulder"}, {"priest", "shoulder"}, {"rogue", "chest"}}.  It is up to the individual mod authors
-- to determine how best to use this information.

function ReagentData_QuestUsage(item, zone)
    if (item == nil or ReagentData["quest"] == nil or not ReagentData_IsQuestItem(item, zone)) then
        return false;
    end
    
    local returnArray = {};
    
    if (zone == "Zul\'Gurub" or zone == "Ruins of Anh\'Qiraj" or zone == "Anh\'Qiraj"  or zone == "Naxxramas") then
        for class, array in ReagentData["quest"][zone]["use"] do
            for armor, subarray in array do
                for piece, count in subarray do
                    if (piece == item) then
                        tinsert(returnArray, {[class] = armor});
                    end
                end
            end
       end
    end
    return returnArray;
end

end -- end ReagentData_LoadQuestItems()