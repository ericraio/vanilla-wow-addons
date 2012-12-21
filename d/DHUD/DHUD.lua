-- DHUD by Markus inger (Drathal)
-- Thanks to lozareth and andreasg for writing great addons ;) 
-- i learned a lot from both of u

-- modes
local DHUD_Casting       = nil;
local DHUD_inCombat      = nil;
local DHUD_Attacking     = nil;
local DHUD_Regen         = nil;
local DHUD_Target        = nil;
local DHUD_needMana      = nil;
local DHUD_needHealth    = nil;
local DHUD_playerDead    = nil;
local DHUD_PetneedHealth = nil;
local DHUD_PetneedMana   = nil;
local DHUD_playerID      = nil; 
local DHUD_CastingAlpha  = 1;
local DHUD_trennzeichen  = "/";
local DHUD_defaultfont   = "fonts\\FRIZQT__.TTF";
DHUD_version             = "v0.86";

-- default Config
local DHUD_Config_default = {
  ["version"]     = DHUD_version,
  ["step"]        = 0.005,
  ["stepfast"]    = 0.02,
  ["combatAlpha"] = 0.8,
  ["oocAlpha"]    = 0,
  ["selAlpha"]    = 0.5,
  ["regAlpha"]    = 0.3,
  ["scale"]       = 0.8,
  ["showclass"]   = 1,
  ["showlevel"]   = 1,
  ["showname"]    = 1,
  ["showelite"]   = 1,
  ["playerdisplaymode"]  = 1,
  ["targetdisplaymode"]  = 1,
  ["petdisplaymode"]     = 4,
  ["fontsizepet"]        = 10,
  ["fontsizeplayer"]     = 10,
  ["fontsizetarget"]     = 10,	
  ["fontsizetargetname"] = 12,	
  ["fontsizecasttime"]   = 10,
  ["fontsizecastdelay"]  = 10,
  ["xoffset"]         = 0,
  ["yoffset"]         = 0,
  ["animatebars"]     = 1,
  ["barborders"]      = 1,
  ["showauras"]       = 1,
  ["btarget"]         = 1,
  ["bplayer"]         = 1,
  ["shownpc"]         = 1,
  ["showtarget"]      = 1,
  ["showpet"]         = 1,
  ["hudspacing"]      = 170,
  ["targettexty"]     = -35,
  ["playerhptextx"]   = 190,
  ["playerhptexty"]   = -15,
  ["playermanatextx"] = 160,
  ["playermanatexty"] = -40,
  ["targethptextx"]   = 160,
  ["targethptexty"]   = -15,
  ["targetmanatextx"] = -280,
  ["targetmanatexty"] = -15,
  ["pethptextx"]      = 100,
  ["pethptexty"]      = 21,
  ["petmanatextx"]    = -100,
  ["petmanatexty"]    = 21,
  ["minimapw"]        = 0,
  ["showmmb"]         = 1,
  ["castingbar"]      = 1,
  ["castingbartimer"] = 1,
  ["casttimetextcolor"]   = "FFFF00",
  ["castdelaytextcolor"]  = "DD0000",
  ["playerhptextcolor"]   = "FFFFFF",
  ["playermanatextcolor"] = "FFFFFF",
  ["targethptextcolor"]   = "FFFFFF",
  ["targetmanatextcolor"] = "FFFFFF",	
  ["pethptextcolor"]      = "FFFFFF",
  ["petmanatextcolor"]    = "FFFFFF",	
  ["playerhpoutline"]     = 1,
  ["playermanaoutline"]   = 1,
  ["targethpoutline"]     = 1,
  ["targetmanaoutline"]   = 1,
  ["pethpoutline"]        = 1,
  ["petmanaoutline"]      = 1,
  ["casttimeoutline"]     = 1,
  ["castdelayoutline"]    = 1,
  ["targetoutline"]       = 1,
}

-- current mana / health values
local DHUD_bar = {
    ["PlayerHealth"] = 1,    
    ["PlayerMana"]   = 1,
    ["TargetHealth"] = 1,
    ["TargetMana"]   = 1,    
    ["PetHealth"]    = 1,
    ["PetMana"]      = 1,       
}

-- animated mana / health values
local DHUD_bar_anim = {
    ["PlayerHealth"] = 1,
    ["PlayerMana"]   = 1,
    ["TargetHealth"] = 1,
    ["TargetMana"]   = 1,       
    ["PetHealth"]    = 1,
    ["PetMana"]      = 1,   
}

-- flag for animation
local DHUD_change = {
    ["PlayerHealth"] = 0,
    ["PlayerMana"]   = 0,
    ["TargetHealth"] = 0,
    ["TargetMana"]   = 0, 
    ["PetHealth"]    = 0,
    ["PetMana"]      = 0,       
}

local DHUD_tex = {
    ["PlayerMana"]   = "PlayerManaBarTexture",
    ["PlayerHealth"] = "PlayerHPBarTexture",
    ["TargetMana"]   = "TargetManaBarTexture",
    ["TargetHealth"] = "TargetHPBarTexture",  
    ["PetMana"]      = "PetManaBarTexture",
    ["PetHealth"]    = "PetHPBarTexture",      
    ["Castingbar"]   = "DHUD_CastingBarTexture",   
    ["Channelbar"]   = "DHUD_CastingBarTexture",
}

local DHUD_attach = {
    ["PlayerHealth"]     = "DHUD_LeftFrame",
    ["PlayerMana"]       = "DHUD_LeftFrame",
    ["TargetHealth"]     = "DHUD_RightFrame",
    ["TargetMana"]       = "DHUD_RightFrame", 
    ["PetHealth"]        = "DHUD_LeftFrame",
    ["PetMana"]          = "DHUD_RightFrame",   
    ["Castingbar"]       = "DHUD_RightFrame",   
    ["Channelbar"]       = "DHUD_RightFrame",    
    ["PlayerHealthText"] = "DHUD_LeftFrame",
    ["TargetHealthText"]   = "DHUD_RightFrame",
    ["PlayerManaText"] = "DHUD_LeftFrame",
    ["TargetManaText"]   = "DHUD_RightFrame", 
    ["PetHealthText"]    = "DHUD_LeftFrame",
    ["PetManaText"]      = "DHUD_RightFrame",
}

local DHUD_texture_pos = { }

local DHUD_texture_settings = {
  ["PlayerHealth"]  = {256,11,11},
  ["PlayerMana"]    = {256,11,11},
  ["TargetHealth"]  = {256,5,5},
  ["TargetMana"]    = {256,5,5},	
  ["PetHealth"]     = {256,128,20},
  ["PetMana"]       = {256,128,20},	
  ["Castingbar"]    = {256,11,11}, 	
  ["Channelbar"]    = {256,11,11},
}

-- bar colors
local DHUD_BarColor = {
    ["health"]    = { 
                        ["start"]  = { ["r"] = 0, ["g"] = 1 , ["b"] = 0},
                        ["middle"] = { ["r"] = 1, ["g"] = 1 , ["b"] = 0},
                        ["end"]    = { ["r"] = 1, ["g"] = 0 , ["b"] = 0},
                    },
    ["mana"]      = {
                        ["start"]  = { ["r"] = 0, ["g"] = 1 , ["b"] = 1},
                        ["middle"] = { ["r"] = 0, ["g"] = 0 , ["b"] = 1},
                        ["end"]    = { ["r"] = 1, ["g"] = 0 , ["b"] = 1},
                    },
    ["rage"]      = {
                        ["start"]  = { ["r"] = 1, ["g"] = 0 , ["b"] = 0},
                        ["middle"] = { ["r"] = 1, ["g"] = 0 , ["b"] = 0},
                        ["end"]    = { ["r"] = 1, ["g"] = 0 , ["b"] = 0},
                    },
    ["energy"]    = {
                        ["start"]  = { ["r"] = 1, ["g"] = 1 , ["b"] = 0},
                        ["middle"] = { ["r"] = 1, ["g"] = 1 , ["b"] = 0},
                        ["end"]    = { ["r"] = 1, ["g"] = 1 , ["b"] = 0},
                    },
    ["focus"]     = {
                        ["start"]  = { ["r"] = 1, ["g"] = 0 , ["b"] = 0},
                        ["middle"] = { ["r"] = 1, ["g"] = 0 , ["b"] = 0},
                        ["end"]    = { ["r"] = 1, ["g"] = 0 , ["b"] = 0},
                    },
    ["tapped"]    = {
                        ["start"]  = { ["r"] = 0.5, ["g"] = 0.5 , ["b"] = 0.5},
                        ["middle"] = { ["r"] = 0.6, ["g"] = 0.6 , ["b"] = 0.6},
                        ["end"]    = { ["r"] = 0.7, ["g"] = 0.7 , ["b"] = 0.7},
                    },
    ["castbar"]    = {
                        ["start"]  = { ["r"] = 1, ["g"] = 1 , ["b"] = 1},
                        ["middle"] = { ["r"] = 1, ["g"] = 1 , ["b"] = 0.5},
                        ["end"]    = { ["r"] = 1, ["g"] = 1 , ["b"] = 0},
                    },
    ["channelbar"]    = {
                        ["start"]  = { ["r"] = 0.8, ["g"] = 0.8 , ["b"] = 1},
                        ["middle"] = { ["r"] = 0.7, ["g"] = 0.7 , ["b"] = 1},
                        ["end"]    = { ["r"] = 0.6, ["g"] = 0.6 , ["b"] = 1},
                    },
}

-- used for hex conversion	
local DHUD_HexTable = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
  ["a"] = 10,
  ["b"] = 11,
  ["c"] = 12,
  ["d"] = 13,
  ["e"] = 14,
  ["f"] = 15
}

-- OUTLINE
local DHUD_Outline = {
  [0] = "",
  [1] = "OUTLINE",
  [2] = "THICKOUTLINE"
}

-- slash commands
local DHUD_CommandList = {
    ["scale"] = {
                    ["type"]     = "range",
                    ["command"]  = "scale",
                    ["minvalue"] = 0.5,
                    ["maxvalue"] = 2,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["fontsizecasttime"] = {
                    ["type"]     = "range",
                    ["command"]  = "fontsizecasttime",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["fontsizecastdelay"] = {
                    ["type"]     = "range",
                    ["command"]  = "fontsizecastdelay",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["fontsizetargetname"] = {
                    ["type"]     = "range",
                    ["command"]  = "fontsizetargetname",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["fontsizetarget"] = {
                    ["type"]     = "range",
                    ["command"]  = "fontsizetarget",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                }, 
    ["fontsizeplayer"] = {
                    ["type"]     = "range",
                    ["command"]  = "fontsizeplayer",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },                
    ["fontsizepet"] = {
                    ["type"]     = "range",
                    ["command"]      = "fontsizepet",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },    
    ["combatAlpha"] = {
                    ["type"]     = "range",
                    ["command"]  = "combatalpha",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 1,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },   
    ["oocAlpha"] = {
                    ["type"]     = "range",
                    ["command"]  = "nocombatalpha",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 1,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["selAlpha"] = {
                    ["type"]     = "range",
                    ["command"]  = "selectalpha",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 1,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["regAlpha"] = {
                    ["type"]     = "range",
                    ["command"]  = "regalpha",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 1,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["playerdisplaymode"] = {
                    ["type"]     = "range",
                    ["command"]  = "playerdisplaymode",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 4,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["targetdisplaymode"] = {
                    ["type"]     = "range",
                    ["command"]  = "targetdisplaymode",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 4,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["petdisplaymode"] = {
                    ["type"]     = "range",
                    ["command"]      = "petdisplaymode",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 4,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["xoffset"] = {
                    ["type"]     = "range",
                    ["command"]  = "xoffset",
                    ["minvalue"] = -1000,
                    ["maxvalue"] = 1000,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["yoffset"] = {
                    ["type"]     = "range",
                    ["command"]  = "yoffset",
                    ["minvalue"] = -1000,
                    ["maxvalue"] = 1000,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["showclass"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showclass",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["showelite"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showelite",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["showname"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showname",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["showlevel"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showlevel",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["castingbar"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "castingbar",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                    },
    ["castingbartimer"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "castingbartimer",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },               
    ["animatebars"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "animatebars",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["reset"] = {
                    ["type"]     = "reset", 
                    ["command"]  = "reset",
                    ["output"]   = "DHUD: /dhud reset",
                    ["response"] = "DHUD: default settings loaded",
                },
    ["barborders"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "barborders",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["showauras"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showauras",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["showtarget"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showtarget",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["showpet"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showpet",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["menu"] = {
                    ["type"]     = "menu",
                    ["command"]  = "menu",
                    ["output"]   = "DHUD: /dhud menu",
                    ["response"] = "DHUD: menu",
                },
    ["btarget"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "btarget",
                    ["output"]   = "DHUD: /dhud %s (hide / show Blizzard Targetframe)",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["bplayer"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "bplayer",
                    ["output"]   = "DHUD: /dhud %s (hide / show Blizzard Playerframeframe)",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["shownpc"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "shownpc",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                },
    ["showmmb"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showmmb",
                    ["output"]   = "DHUD: /dhud %s",
                    ["response"] = "DHUD: %s is now %s",
                }, 
    ["hudspacing"] = {
                    ["type"]     = "range",
                    ["command"]  = "hudspacing",
                    ["minvalue"] = -500,
                    ["maxvalue"] = 500,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["targettexty"] = {
                    ["type"]     = "range",
                    ["command"]  = "targettexty",
                    ["minvalue"] = -500,
                    ["maxvalue"] = 500,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["playerhptextx"] = {
                    ["type"]     = "range",
                    ["command"]  = "playerhptextx",
                    ["minvalue"] = -300,
                    ["maxvalue"] = 300,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["playerhptexty"] = {
                    ["type"]     = "range",
                    ["command"]  = "playerhptexty",
                    ["minvalue"] = -300,
                    ["maxvalue"] = 300,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["playermanatextx"] = {
                    ["type"]     = "range",
                    ["command"]  = "playermanatextx",
                    ["minvalue"] = -300,
                    ["maxvalue"] = 300,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["playermanatexty"] = {
                    ["type"]     = "range",
                    ["command"]  = "playermanatexty",
                    ["minvalue"] = -300,
                    ["maxvalue"] = 300,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["casttimetextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "casttimetextcolor",
                    ["output"]   = "DHUD: /dhud %s 000000 - FFFFFF",
                    ["response"] = "DHUD: %s set to: |cff%s%s|r ",
                },
    ["castdelaytextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "castdelaytextcolor",
                    ["output"]   = "DHUD: /dhud %s 000000 - FFFFFF",
                    ["response"] = "DHUD: %s set to: |cff%s%s|r ",
                },
    ["playerhptextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "playerhptextcolor",
                    ["output"]   = "DHUD: /dhud %s 000000 - FFFFFF",
                    ["response"] = "DHUD: %s set to: |cff%s%s|r ",
                },    
    ["playermanatextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "playermanatextcolor",
                    ["output"]   = "DHUD: /dhud %s 000000 - FFFFFF",
                    ["response"] = "DHUD: %s set to: |cff%s%s|r ",
                },   
    ["targethptextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "targethptextcolor",
                    ["output"]   = "DHUD: /dhud %s 000000 - FFFFFF",
                    ["response"] = "DHUD: %s set to: |cff%s%s|r ",
                },          
    ["targetmanatextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "targetmanatextcolor",
                    ["output"]   = "DHUD: /dhud %s 000000 - FFFFFF",
                    ["response"] = "DHUD: %s set to: |cff%s%s|r ",
                },      
    ["pethptextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "pethptextcolor",
                    ["output"]   = "DHUD: /dhud %s 000000 - FFFFFF",
                    ["response"] = "DHUD: %s set to: |cff%s%s|r ",
                },       
    ["petmanatextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "petmanatextcolor",
                    ["output"]   = "DHUD: /dhud %s 000000 - FFFFFF",
                    ["response"] = "DHUD: %s set to: |cff%s%s|r ",
                },   
    ["playerhpoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "playerhpoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["playermanaoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "playermanaoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["targethpoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "targethpoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["targetmanaoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "targetmanaoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["pethpoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "pethpoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["petmanaoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "petmanaoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["casttimeoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "casttimeoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["castdelayoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "castdelayoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
    ["targetoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "targetoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                    ["output"]   = "DHUD: /dhud %s %s - %s",
                    ["response"] = "DHUD: %s set to: |cff00ff00%s|r |cffcccccc[%s - %s]|r",
                },
}

function DHUD_registerEvents()

    local f = DHUD_EventFrame;
    f:RegisterEvent("UNIT_AURA");
    f:RegisterEvent("UNIT_PET");
    f:RegisterEvent("UNIT_HEALTH");
    f:RegisterEvent("UNIT_HEALTHMAX");
    f:RegisterEvent("UNIT_MANA");
    f:RegisterEvent("UNIT_MANAMAX");
    f:RegisterEvent("UNIT_FOCUS");
    f:RegisterEvent("UNIT_FOCUSMAX");
    f:RegisterEvent("UNIT_RAGE");
    f:RegisterEvent("UNIT_RAGEMAX");
    f:RegisterEvent("UNIT_ENERGY"); 
    f:RegisterEvent("UNIT_ENERGYMAX");
    f:RegisterEvent("UNIT_DISPLAYPOWER");
    f:RegisterEvent("PLAYER_AURAS_CHANGED");
    f:RegisterEvent("PLAYER_ENTER_COMBAT"); 
    f:RegisterEvent("PLAYER_LEAVE_COMBAT"); 
    f:RegisterEvent("PLAYER_REGEN_ENABLED"); 
    f:RegisterEvent("PLAYER_REGEN_DISABLED"); 
    f:RegisterEvent("PLAYER_TARGET_CHANGED");    
    f:RegisterEvent("PLAYER_COMBO_POINTS");
    f:RegisterEvent("PLAYER_DEAD");
    f:RegisterEvent("PLAYER_ALIVE");
    f:RegisterEvent("SPELLCAST_CHANNEL_START");
    f:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
    f:RegisterEvent("SPELLCAST_DELAYED");
    f:RegisterEvent("SPELLCAST_FAILED");
    f:RegisterEvent("SPELLCAST_INTERRUPTED");
    f:RegisterEvent("SPELLCAST_START");
    f:RegisterEvent("SPELLCAST_STOP");
    f:RegisterEvent("SPELLCAST_CHANNEL_STOP");

end

function DHUD_unregisterEvents()

    local f = DHUD_EventFrame;
    f:UnregisterEvent("UNIT_AURA");
    f:UnregisterEvent("UNIT_PET");
    f:UnregisterEvent("UNIT_HEALTH");
    f:UnregisterEvent("UNIT_HEALTHMAX");
    f:UnregisterEvent("UNIT_MANA");
    f:UnregisterEvent("UNIT_MANAMAX");
    f:UnregisterEvent("UNIT_FOCUS");
    f:UnregisterEvent("UNIT_FOCUSMAX");
    f:UnregisterEvent("UNIT_RAGE");
    f:UnregisterEvent("UNIT_RAGEMAX");
    f:UnregisterEvent("UNIT_ENERGY"); 
    f:UnregisterEvent("UNIT_ENERGYMAX");
    f:UnregisterEvent("UNIT_DISPLAYPOWER");
    f:UnregisterEvent("PLAYER_AURAS_CHANGED");
    f:UnregisterEvent("PLAYER_ENTER_COMBAT"); 
    f:UnregisterEvent("PLAYER_LEAVE_COMBAT"); 
    f:UnregisterEvent("PLAYER_REGEN_ENABLED"); 
    f:UnregisterEvent("PLAYER_REGEN_DISABLED"); 
    f:UnregisterEvent("PLAYER_TARGET_CHANGED");    
    f:UnregisterEvent("PLAYER_COMBO_POINTS");
    f:UnregisterEvent("PLAYER_DEAD");
    f:UnregisterEvent("PLAYER_ALIVE");
    f:UnregisterEvent("SPELLCAST_CHANNEL_START");
    f:UnregisterEvent("SPELLCAST_CHANNEL_UPDATE");
    f:UnregisterEvent("SPELLCAST_DELAYED");
    f:UnregisterEvent("SPELLCAST_FAILED");
    f:UnregisterEvent("SPELLCAST_INTERRUPTED");
    f:UnregisterEvent("SPELLCAST_START");
    f:UnregisterEvent("SPELLCAST_STOP");    
    f:UnregisterEvent("SPELLCAST_CHANNEL_STOP"); 
  
end

function DHUD_OnLoad()

    -- Events
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("PLAYER_ENTERING_WORLD");
    this:RegisterEvent("PLAYER_LEAVING_WORLD");
    DHUD_registerEvents();
    
    -- slash handler
    SLASH_DHUD1 = "/dhud";
    SlashCmdList["DHUD"] = function(msg)
        DHUD_SCommandHandler(msg);
    end     

end;

function DHUD_OnEvent(event, arg1, arg2, arg3)

    -- init
    if (event == "VARIABLES_LOADED") then   

        -- set player ID
        DHUD_playerID = GetRealmName()..":"..UnitName("player");
                
        -- set default Values
        if( not DHUD_Config ) then
            DHUD_Config = { };
        end

        for k, v in DHUD_Config_default do
            DHUD_defaultConfig(k);
        end
                 
        -- MyAddonsSupport
        DHUD_myAddons();
        
        -- minimap button
        DHUD_createMMB();

        -- init HUD
        DHUD_init();    
         
        -- Tell 
        DEFAULT_CHAT_FRAME:AddMessage("Drathal's HUD: Loaded "..DHUD_version); 
        
        -- unregister after first load
        DHUD_EventFrame:UnregisterEvent("VARIABLES_LOADED");
    
        return;    
    end
    
    -- shapeshift etc
    if  (event == "PLAYER_AURAS_CHANGED" or event == "UNIT_DISPLAYPOWER") and arg1 == "player" then
        DHUD_updatePlayerMana();
        return;
    end
    
    -- buffs / debuffs
    if  event == "UNIT_AURA" and arg1 == "target" then
        DHUD_Auras();
        return;
    end
    
    -- update Combos
    if event == "PLAYER_COMBO_POINTS" then
        DHUD_UpdateCombos();
        return;
    end
   
    -- Hat sich Spieler Health verändert?
    if ( ( event == "UNIT_HEALTH" or event == "UNIT_HEALTHMAX" ) and arg1 == "player" ) then
        DHUD_updatePlayerHealth();
        return;
    end
    
    -- Hat sich Spieler Mana/Rage etc verändert?
    if ( (event == "UNIT_MANA" or 
          event == "UNIT_MANAMAX" or 
          event == "UNIT_FOCUS" or 
          event == "UNIT_FOCUSMAX" or
          event == "UNIT_RAGE" or 
          event == "UNIT_RAGEMAX" or
          event == "UNIT_ENERGY" or
          event == "UNIT_ENERGYMAX" ) and arg1 == "player" ) then
                DHUD_updatePlayerMana();     
        return;
    end  
    
    -- Hat sich Target Health verändert?
    if ( (event == "UNIT_HEALTH" or event == "UNIT_HEALTHMAX") and arg1 == "target" ) then
        if DHUD_Config["showtarget"] == 1 then
            DHUD_updateTargetHealth();
        end
        return;
    end
  
    -- Hat sich Target Mana/Rage etc verändert?
    if ( (event == "UNIT_MANA" or 
          event == "UNIT_MANAMAX" or 
          event == "UNIT_FOCUS" or 
          event == "UNIT_FOCUSMAX" or
          event == "UNIT_RAGE" or 
          event == "UNIT_RAGEMAX" or
          event == "UNIT_ENERGY" or
          event == "UNIT_ENERGYMAX") and arg1 == "target" ) then
          if DHUD_Config["showtarget"] == 1 then
                DHUD_updateTargetMana();     
          end
        return;
    end    

     -- Pet?
    if (  event == "UNIT_PET" ) then
        if DHUD_Config["showpet"] == 1 then
            DHUD_changeBackgroundTexture();
            DHUD_updatePetHealth();
            DHUD_updatePetMana();
        end;
        return;
    end  
    
     -- Hat sich Pet Health verändert?
    if (  (event == "UNIT_HEALTH" or event == "UNIT_HEALTHMAX") and arg1 == "pet" ) then
        if DHUD_Config["showpet"] == 1 then
            DHUD_updatePetHealth();
        end
        return;
    end  
    
    -- Hat sich Pet Mana/Rage etc verändert?
    if ( (event == "UNIT_MANA" or 
          event == "UNIT_MANAMAX" or 
          event == "UNIT_FOCUS" or 
          event == "UNIT_FOCUSMAX" or
          event == "UNIT_RAGE" or 
          event == "UNIT_RAGEMAX" or
          event == "UNIT_ENERGY" or
          event == "UNIT_ENERGYMAX") and arg1 == "pet" ) then
          if DHUD_Config["showpet"] == 1 then
                DHUD_updatePetMana();   
          end
        return;
    end          
    
    -- Target wechsel
    if event == "PLAYER_TARGET_CHANGED" then 
        DHUD_updateTargetChanged();
        return;
    end     
    
    -- Combat / Regen / Attack check
    if (event == "PLAYER_ENTER_COMBAT") then
        DHUD_Attacking = true;
        DHUD_inCombat  = true;
        DHUD_updateAlpha();
        return;
    elseif (event == "PLAYER_LEAVE_COMBAT") then
        DHUD_Attacking = nil;
        if (DHUD_Regen) then
            DHUD_inCombat = nil;
        end
        DHUD_updateAlpha();
        return;
    elseif (event == "PLAYER_REGEN_ENABLED") then
        DHUD_Regen = true;
        if (not DHUD_Attacking) then
            DHUD_inCombat = nil;
        end
        DHUD_updateAlpha();
        return;
    elseif (event == "PLAYER_REGEN_DISABLED") then
        DHUD_Regen    = nil;
        DHUD_inCombat = true;
        DHUD_updateAlpha();
        return;
    end      

    if (event == "PLAYER_DEAD") then
        DHUD_playerDead = 1;
        DHUD_updateAlpha();
        return;
    end

    if (event == "PLAYER_ALIVE") then
        DHUD_playerDead = 0;
        DHUD_updateAlpha();
        return;
    end
        
    if DHUD_Config["castingbar"] == 1 then
    
        -- start castbar
        if (event == "SPELLCAST_START") then
            this.startTime  = GetTime();
            this.maxValue   = this.startTime + (arg2 / 1000);
            this.holdTime   = 0;
            this.casting    = 1;
            this.delay      = 0;
            this.channeling = nil;
            this.fadeOut    = nil;
            this.flash      = nil;
            this.duration   = floor(arg2 / 100) / 10;
            
            DHUD_Casting    = true;
            DHUD_updateAlpha();
            
            DHUD_Casttime_Text:SetText("");
            DHUD_Casttime:Show();
            DHUD_Castdelay_Text:SetText("");
            DHUD_Castdelay:Show();
            
            DHUD_SetBar("Castingbar", 0 );
            DHUD_CastingBarTexture:Show();
            DHUD_CastingBarTexture:SetAlpha(DHUD_CastingAlpha); 
            return;
        end	

        -- failed
        if (event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED") then
    
            if (DHUD_CastingBarTexture:IsShown()) then
                DHUD_CastingBarTexture:SetVertexColor(1, 0, 0);
                DHUD_SetBar("Castingbar", 1 , 1);
                this.casting    = nil;
                this.channeling = nil;
                this.fadeOut    = 1;
                this.flash      = nil;
                this.holdTime = GetTime() + CASTING_BAR_HOLD_TIME;
                DHUD_CastingBarTextureHigh:Hide();
            end
            return;
            
        end
                
        -- stop 
        if ( event == "SPELLCAST_STOP" or event == "SPELLCAST_CHANNEL_STOP") then
                          
            if (not DHUD_CastingBarTexture:IsVisible()) then
                DHUD_CastingBarTexture:Hide();
            end
            
            if (DHUD_CastingBarTexture:IsShown()) then
                if ( event == "SPELLCAST_STOP" and this.casting == 1) then
                    this.casting    = nil;
                    this.channeling = nil;
                    this.flash      = 1;
                    this.fadeOut    = 1;
                    DHUD_CastingBarTexture:SetVertexColor(0, 1, 0);
                    DHUD_SetBar("Castingbar", 1 ,1);
                    DHUD_CastingBarTextureHigh:SetAlpha(0);
                    DHUD_CastingBarTextureHigh:Show();
                  elseif  ( event == "SPELLCAST_CHANNEL_STOP" and this.channeling == 1) then
                    this.casting    = nil;
                    this.channeling = nil;
                    this.flash      = nil;
                    this.fadeOut    = 1;
                    DHUD_Casting    = nil;
                    DHUD_updateAlpha();
                    DHUD_SetBar("Castingbar", 0 );
                end
            end
            
            return;
        end
            
        -- delayed
        if (event == "SPELLCAST_DELAYED") then
            
            if(DHUD_CastingBarTexture:IsShown()) then
                this.startTime = this.startTime + (arg1 / 1000);
                this.maxValue  = this.maxValue + (arg1 / 1000);
                this.delay     = this.delay + (arg1 / 1000);
                
                local time = GetTime();
                if (time > this.endTime) then
                    time = this.endTime
                end
                
                local barValue = this.startTime + (this.endTime - time);
                local sparkPosition = ((barValue - this.startTime) / (this.endTime - this.startTime));
                DHUD_SetBar("Castingbar", sparkPosition );
            end		
            return;
        end
        
        -- channel start
        if (event == "SPELLCAST_CHANNEL_START") then
            this.maxValue   = 1;
            this.startTime  = GetTime();
            this.endTime    = this.startTime + (arg1 / 1000);
            this.duration   = string.format( "%.1f",arg1 / 1000);
            this.holdTime   = 0;
            this.casting    = nil;
            this.channeling = 1;
            this.fadeOut    = nil;
            this.delay      = 0;
            DHUD_Casting    = true;
            DHUD_updateAlpha();
            DHUD_SetBar("Channelbar", 1 );
            DHUD_CastingBarTexture:Show();
            DHUD_CastingBarTexture:SetAlpha(DHUD_CastingAlpha);
            DHUD_Casttime_Text:SetText("");
            DHUD_Casttime:Show();
            DHUD_Castdelay_Text:SetText("");
            DHUD_Castdelay:Show();
            return;
        end
        
        -- channel update
        if (event == "SPELLCAST_CHANNEL_UPDATE") then
            
            if arg1 == 0 then
                this.channeling = nil;
            elseif (DHUD_CastingBarTexture:IsShown()) then
                local origDuration = this.endTime - this.startTime
                local elapsedTime = GetTime() - this.startTime;
                this.delay = (origDuration - elapsedTime) - (arg1/1000);
                this.endTime = GetTime() + (arg1 / 1000);
            end
            
            return;
        end
  
    end
    
    -- zoned?
    if (event == "PLAYER_ENTERING_WORLD") then   
        DHUD_registerEvents();
        DHUD_init();  
        return;
    end
    
    if (event == "PLAYER_LEAVING_WORLD") then   
        DHUD_unregisterEvents();
        return;
    end
              
end;

function DHUD_Auras()
    
    -- wenn auras aus nicht zeigen
    if DHUD_Config["showauras"] == 0 then
        return;
    end
    
    if DHUD_Config["showtarget"] == 0 then
        return;
    end;
    
    -- wenn NPC anzeige aus keine aura zeigen
    if DHUD_checkShowNPC() then
        DHUD_hideAuras();
        return;
    end;
    
  local i, icon, buff, debuff, debuffborder, debuffcount;
  
  -- Buffs 
  for i = 1, 16 do
    buff = UnitBuff("target", i);
    button = getglobal("DHUDBuff"..i);
    if (buff) then
      icon = getglobal(button:GetName().."Icon");
      icon:SetTexture(buff);
      button:Show();
      button.unit = "target";
    else
      button:Hide();
    end
    
    debuff, debuffC = UnitDebuff("target", i);
    button = getglobal("DHUDDeBuff"..i);
    if (debuff) then
      icon = getglobal(button:GetName().."Icon");
      icon:SetTexture(debuff);
      
      button.hasdebuff = 1;
      button.unit = "target";
      
      debuffborder = getglobal(button:GetName().."Border");
      debuffcount  = getglobal(button:GetName().."Count");
      
      debuffborder:Show();
      button:Show();
      
      if (debuffC <= 0) then
          debuffcount:Hide()
            elseif debuffC > 1 then
        debuffcount:SetText(debuffC);
        debuffcount:Show();
            else
                debuffcount:SetText("");
        debuffcount:Show();
      end
      
    else
      button:Hide();
    end
  end
end

function DHUD_setAlpha(mode)

    local texture = getglobal("DHUD_LeftFrameTexture");
    texture:SetAlpha(DHUD_Config[mode]);	
    
    local texture = getglobal("DHUD_RightFrameTexture");
    texture:SetAlpha(DHUD_Config[mode]);	
        
    local texture = getglobal(DHUD_tex["PlayerHealth"]);
    texture:SetAlpha(DHUD_Config[mode]);
    
    local texture = getglobal(DHUD_tex["PlayerMana"]);
    texture:SetAlpha(DHUD_Config[mode]);	 
    
    if DHUD_Config["showtarget"] == 1 then
        local texture = getglobal(DHUD_tex["TargetHealth"]);
        texture:SetAlpha(DHUD_Config[mode]);
        
        local texture = getglobal(DHUD_tex["TargetMana"]);
        texture:SetAlpha(DHUD_Config[mode]);
    end
    
    if DHUD_Config["showpet"] == 1 then
        local texture = getglobal(DHUD_tex["PetHealth"]);
        texture:SetAlpha(DHUD_Config[mode]);
        
        local texture = getglobal(DHUD_tex["PetMana"]);
        texture:SetAlpha(DHUD_Config[mode]);    
    end
    
    DHUD_CastingAlpha = DHUD_Config[mode];
     
end

function DHUD_changeBackgroundTexture()

    local has_target_health  = nil;
    local has_target_mana    = nil;
    local has_pet_health     = nil; 
    local has_pet_mana       = nil; 
    local texture_name_left  = "Interface\\AddOns\\DHUD\\textures\\standard\\bg_left_";
    local texture_name_right = "Interface\\AddOns\\DHUD\\textures\\standard\\bg_right_";
    local tex_left           = "";
    local tex_right          = "";

    -- check target
    if DHUD_Config["showtarget"] == 1 then
        if ( UnitName("target") ) then 
        
            -- npc anzeigen?
            if DHUD_checkShowNPC() then
                has_target_health = nil;
                has_target_mana   = nil;
            else
                if UnitHealthMax("target") then 
                    has_target_health = 1;
                else
                    has_target_health = nil;
                end
                
                if UnitManaMax("target") > 0 then 
                    has_target_mana = 1;
                else
                    has_target_mana = nil;
                end       
                
                -- Update Text Display
                DHUD_updateTargetHealth();
                DHUD_updateTargetMana(); 
            end
        end
    end
    
    -- check pet
    if DHUD_Config["showpet"] == 1 then
        if ( UnitName("pet") ) then 
            if UnitHealthMax("pet") then 
                has_pet_health = 1;
            else
                has_pet_health = nil;
            end
            
            if UnitManaMax("pet") > 0 then 
                has_pet_mana = 1;
            else
                has_pet_mana = nil;
            end     
            
            -- Update Text Display
            DHUD_updatePetHealth();
            DHUD_updatePetMana();            
        end
    end

    -- showing borders?
    if DHUD_Config["barborders"] == 1 then
    
        -- left Target?
        if has_target_health then
            tex_left = "Target";
        end
        
        -- Player
        tex_left = tex_left .. "Player";
        
        -- left Pet
        if has_pet_health then
            tex_left = tex_left .. "Pet";
        end
        
        -- right Target?
        if has_target_mana then
            tex_right = "Target";
        end
        
        -- Player
        tex_right = tex_right .. "Player";
        
        -- left Pet
        if has_pet_mana then
            tex_right = tex_right .. "Pet";
        end    
          
        -- set Left texture
        DHUD_LeftFrameTexture:SetTexture(texture_name_left..tex_left);   
        if DHUD_playerDead ~= 1 then
            DHUD_LeftFrameTexture:Show();
        end    
        
        -- set Right texture
        DHUD_RightFrameTexture:SetTexture(texture_name_right..tex_right); 
        if DHUD_playerDead ~= 1 then
            DHUD_RightFrameTexture:Show(); 
        end
    else
        -- set Left texture
        DHUD_LeftFrameTexture:Hide();      
        
        -- set Right texture
        DHUD_RightFrameTexture:Hide();  
    end
        
    -- show / hide Target Health Text / Bar
    if has_target_health then
        local texture = getglobal(DHUD_tex["TargetHealth"]);
        texture:Show();
        getglobal("DHUD_TargetHealth"):Show();
    else
        local texture = getglobal(DHUD_tex["TargetHealth"]);
        texture:Hide();
        getglobal("DHUD_TargetHealth"):Hide();
    end;
    
    -- show / hide Target Mana Text / Bar
    if has_target_mana then
        local texture = getglobal(DHUD_tex["TargetMana"]);
        texture:Show();
        getglobal("DHUD_TargetMana"):Show();                 
    else
        local texture = getglobal(DHUD_tex["TargetMana"]);
        texture:Hide();
        getglobal("DHUD_TargetMana"):Hide();       
    end;    

    -- show / hide Pet Health Text / Bar
    if has_pet_health then
        local texture = getglobal(DHUD_tex["PetHealth"]);
        texture:Show();
    else
        local texture = getglobal(DHUD_tex["PetHealth"]);
        texture:Hide();
    end;
    
    -- show / hide pet Mana Text / Bar
    if has_pet_mana then
        local texture = getglobal(DHUD_tex["PetMana"]);
        texture:Show();              
    else
        local texture = getglobal(DHUD_tex["PetMana"]);
        texture:Hide();     
    end;
        
end

function DHUD_updateTargetChanged()

    -- NPC anzeigen ?
    if DHUD_checkShowNPC() then
        DHUD_Target = nil;
        DHUD_TargetName:SetText("");
        
    -- sonst normal weiter
    else

        -- update TargetText
        if DHUD_Config["showtarget"] == 1 then
            DHUD_setTargetInfoText();
        else
            DHUD_TargetName:SetText("");
        end
        
        -- update Combopoints
        DHUD_UpdateCombos();
        
        -- changeBackgroundTexture 
        DHUD_changeBackgroundTexture();
        
        -- Target selected?
        if UnitLevel("target") and UnitName("target") and DHUD_Config["showtarget"] == 1 then
            DHUD_Target = 1;
        else
            DHUD_Target = nil;
        end
        
        -- update Target Health
        if DHUD_Config["showtarget"] == 1 then
            DHUD_updateTargetHealth();
            
            if DHUD_Config["animatebars"] == 1 then
                DHUD_bar_anim["TargetHealth"] = DHUD_bar["TargetHealth"];
                DHUD_SetBar("TargetHealth",DHUD_bar["TargetHealth"]);
            end
            
            -- update Target Mana
            DHUD_updateTargetMana();
            
            if DHUD_Config["animatebars"] == 1 then
                DHUD_bar_anim["TargetMana"] = DHUD_bar["TargetMana"];
                DHUD_SetBar("TargetMana",DHUD_bar["TargetMana"]);
            end
            
            -- make name clickable?
            if ( UnitIsUnit("target", "player") and GetNumPartyMembers() > 0) or
               ( UnitIsPlayer("target")  and not UnitIsEnemy("player", "target")  and not   UnitIsUnit("target", "player")   ) then
                getglobal("DHUD_Target"):EnableMouse(1);
            else
                getglobal("DHUD_Target"):EnableMouse(0);
            end
        end

    end
    
    -- Auras
    DHUD_Auras();
    
    -- change Buttonwith
    DHUD_resizeText();
    
    -- set new alpha
    DHUD_updateAlpha();
    
end

function DHUD_resizeText()

    local wb = DHUD_TargetName:GetWidth();
    local hb = DHUD_TargetName:GetHeight();
    local f = getglobal("DHUD_Target");
        
    if wb < 5 then 
       f:SetWidth(1);
       f:SetHeight(1);
       f:Hide();
    else
       f:SetWidth(wb+5);
       f:SetHeight(hb+5);
       f:Show();
    end 

end

function DHUD_setTargetInfoText()

    -- target Name
    local unitname    = "";
    local unitlevel   = "";
    local targetclass = "";
    local eclass      = "";
    local color       = "";
    local whitecolor  = "|r";
    local targetelite = "";
    local targetlevel = "";
        
    if UnitLevel("target") and UnitName("target") then
    
        -- set level
        unitlevel = UnitLevel("target");
        
        -- set name
        unitname = UnitName("target").." ";
        
        -- if level eg -1 then boss
        if unitlevel < 0 then 
            unitlevel = 99;
        end
         
        -- get diff color
        color = GetDifficultyColor(unitlevel);
        
        -- show ?? for boss and hide then level = 0
        if unitlevel == 99 then
            unitlevel = "??";
        elseif unitlevel == 0 then
            unitlevel = "";
        end; 
        
        -- build colorcoded levelstring
        local levelcolor = "|cff"..DHUD_DecToHex(color.r,color.g,color.b);
        targetlevel = levelcolor..unitlevel..whitecolor.." ";
              
        -- is Elite?
        targetelite = DHUD_CheckElite();
        
        -- set class
        if UnitClass("target") then
            targetclass, eclass = UnitClass("target");
            
            -- color classname
            if targetclass then
                local colorx = RAID_CLASS_COLORS[eclass or ""];
                color = DHUD_DecToHex(colorx.r,colorx.g,colorx.b);
                
                if (color) then
                    classcolor = "|cff"..color;
                else
                    classcolor = "|cffffffff";
                end
                
                -- is Unit pet?
                if not UnitIsPlayer("target") and not UnitCanAttack("player", "target") and UnitPlayerControlled("target") then
                    targetclass = "Pet";
                -- is Unit NPC?
                elseif not UnitIsPlayer("target") and not UnitCanAttack("player", "target") and not UnitPlayerControlled("target") then
                    targetclass = "NPC";
                end
        
                targetclass = "["..classcolor..targetclass..whitecolor.."]";
            end
        end
    end
    
    -- hide parts of text
    if DHUD_Config["showclass"] == 0 then
      targetclass = "";
    end
    
    if DHUD_Config["showname"] == 0 or not UnitLevel("target")  then
      unitname = "";
    end
    
    if DHUD_Config["showelite"] == 0 then
      targetelite = nil;
    end
    
    if DHUD_Config["showlevel"] == 0 then
      targetlevel = "";
    end
        
    -- set target infos
    local fulltext = targetlevel..unitname..targetclass;
    
    if targetelite then
        fulltext = fulltext..targetelite
    end
    
    DHUD_TargetName:SetText(fulltext);

end

function DHUD_setAlphaCombat()

    DHUD_setAlpha("combatAlpha");
    DHUD_PlayerHealth:Show();
    DHUD_PlayerMana:Show();
    DHUD_TargetName:Show();
    if UnitHealth("pet") > 0 then
       DHUD_PetMana:Show();
       DHUD_PetHealth:Show();
    end

end

function DHUD_setAlphaSelect()

    -- hide npc is on and target is friendly NPC
    if DHUD_checkShowNPC() then
        DHUD_setAlpha("oocAlpha");
        DHUD_PlayerHealth:Hide();
        DHUD_PlayerMana:Hide();
        DHUD_PetMana:Hide();
        DHUD_PetHealth:Hide();
        DHUD_TargetHealth:Hide();
        DHUD_TargetMana:Hide();
        
        if DHUD_needHealth or DHUD_needMana or DHUD_PetneedHealth or DHUD_PetneedMana then
            DHUD_setAlphaRegen();
        end
        
        DHUD_TargetName:Hide();
    else
        DHUD_setAlpha("selAlpha");
        DHUD_PlayerHealth:Show();
        DHUD_PlayerMana:Show();
        DHUD_TargetName:Show();
        if UnitHealth("pet") > 0 then
           DHUD_PetMana:Show();
           DHUD_PetHealth:Show();
        end
    end
      
end

function DHUD_setAlphaRegen()

    DHUD_setAlpha("regAlpha");
    DHUD_TargetName:Show();
    DHUD_TargetHealth:Hide();
    DHUD_TargetMana:Hide();
    
    if (DHUD_needHealth or DHUD_needMana) and DHUD_Config["regAlpha"] > 0 then
       DHUD_PlayerHealth:Show();
       DHUD_PlayerMana:Show();
    else
       DHUD_PlayerHealth:Hide();
       DHUD_PlayerMana:Hide();         
    end
    
    if (DHUD_PetneedHealth or DHUD_PetneedMana) and DHUD_Config["regAlpha"] > 0  then
       DHUD_PetMana:Show();
       DHUD_PetHealth:Show();
    else
       DHUD_PetMana:Hide();
       DHUD_PetHealth:Hide();	 
    end
      
end

function DHUD_setAlphaStandard()

    DHUD_setAlpha("oocAlpha");
    DHUD_PlayerHealth:Hide();
    DHUD_PlayerMana:Hide();
    DHUD_TargetHealth:Hide();
    DHUD_TargetMana:Hide();
    DHUD_PetMana:Hide();
    DHUD_PetHealth:Hide();
    DHUD_TargetName:Hide();
    
end

function DHUD_updateAlpha()

  -- dead ? then hide frame around bars
  -- TODO überarbeiten
  if DHUD_playerDead == 1 then
        DHUD_LeftFrameTexture:Hide(); 
        DHUD_RightFrameTexture:Hide(); 
        DHUD_CastingBarTexture:Hide();
        DHUD_CastingBarTextureHigh:Hide();
        DHUD_Castdelay:Hide();
        DHUD_Casttime:Hide();
        DHUD_TargetHealth:Hide();
      DHUD_TargetMana:Hide();
      DHUD_PlayerHealth:Hide();
      DHUD_PlayerMana:Hide();
      DHUD_PetMana:Hide();          
      DHUD_PetHealth:Hide();     
      DHUD_TargetName:Show();
      return; 
  else
      if DHUD_Config["barborders"] == 1 then
            DHUD_LeftFrameTexture:Show(); 
            DHUD_RightFrameTexture:Show();   	
        end
      DHUD_PlayerHealth:Show();
      DHUD_PlayerMana:Show();
      DHUD_TargetName:Show();
      if UnitHealth("pet") > 0 then
         DHUD_PetMana:Show();        
         DHUD_PetHealth:Show();  
      end
    end
    
    -- Combat Mode
  if DHUD_inCombat then
  
        DHUD_setAlphaCombat();
        return; 
      
  -- target selected    	    
  elseif DHUD_Target then
  
        DHUD_setAlphaSelect();
        return; 
            
    -- Player / Pet reg
    elseif DHUD_needHealth or DHUD_needMana or DHUD_PetneedHealth or DHUD_PetneedMana then
    
        DHUD_setAlphaRegen();
        return; 
        
    -- Casting
    elseif DHUD_Casting then
    
        DHUD_setAlphaRegen();
        return;     	 
         
  -- standard mode     	    		       
  else

        DHUD_setAlphaStandard();
      return;  
       
  end
  
end

function DHUD_OnUpdate()
        
    -- animate bars?
    if DHUD_Config["animatebars"] == 1 then
        -- Player HP Anim
        DHUD_Animate("PlayerHealth");
    
        -- Player Mana Anim
        DHUD_Animate("PlayerMana");    
        
        if DHUD_Config["showtarget"] == 1 then
            -- Target HP Anim
            DHUD_Animate("TargetHealth");
        
            -- Target Mana Anim
            DHUD_Animate("TargetMana");   
        end
        
        if DHUD_Config["showpet"] == 1 then
            -- Pet HP Anim
            DHUD_Animate("PetHealth");
        
            -- Pet Mana Anim
            DHUD_Animate("PetMana");    
        end
    end   
    
    -- castingbar
    if DHUD_Config["castingbar"] == 1 then
    
        if this.holdTime == nil then
            this.holdTime = 0;
        end

    -- casting
        if (this.casting) then
        
      local status = GetTime();
      if (status > this.maxValue) then
        status = this.maxValue
      end
      DHUD_CastingBarTextureHigh:Hide();
            DHUD_SetBar("Castingbar", ((status - this.startTime) / (this.maxValue - this.startTime))  );
            
            if DHUD_Config["castingbartimer"] == 1 then
                local display_time = string.format( "%.1f", (status + this.delay) - this.startTime );            
                DHUD_Casttime_Text:SetText(display_time);
                
                if ( this.delay > 0 ) then
                    DHUD_Castdelay_Text:SetText( "+"..string.format( "%.1f", this.delay) );
                else
                    DHUD_Castdelay_Text:SetText("");
                end
                
                DHUD_Castdelay:SetAlpha(1);
                DHUD_Casttime:SetAlpha(1);
            end

        -- channeling
        elseif (this.channeling) then
        
      local time = GetTime();
      if (time > this.endTime) then
        time = this.endTime
      end

            local barValue = this.startTime + (this.endTime - time);
            local sparkPosition = ((barValue - this.startTime) / (this.endTime - this.startTime));
      DHUD_SetBar("Channelbar", sparkPosition );
      DHUD_CastingBarTextureHigh:Hide();	
      
      if DHUD_Config["castingbartimer"] == 1 then
                local display_time = string.format( "%.1f",this.duration -((time + this.delay) - this.startTime)) ;            
                DHUD_Casttime_Text:SetText( display_time );	
                
                if ( this.delay > 0 ) then
                    DHUD_Castdelay_Text:SetText( "-"..string.format( "%.1f", this.delay) );
                else
                    DHUD_Castdelay_Text:SetText("");
                end
                
                DHUD_Castdelay:SetAlpha(1);
                DHUD_Casttime:SetAlpha(1);
            end
                  
      if (time == this.endTime) then
        this.channeling = nil;
        this.casting    = nil;
        this.fadeOut    = 1;
        this.flash      = nil;
        DHUD_Casting    = nil;
        DHUD_updateAlpha();               
        DHUD_SetBar("Channelbar", 0 );
          DHUD_CastingBarTexture:Hide();
          DHUD_CastingBarTextureHigh:Hide();
        return;
      end
        
            return;
            
        -- hold
    elseif ( GetTime() < this.holdTime) then
    
      return;
      
        -- flash
    elseif (this.flash) then
    
      local alpha = DHUD_CastingBarTextureHigh:GetAlpha() + CASTING_BAR_FLASH_STEP;
      if (alpha < 1) then
        DHUD_CastingBarTextureHigh:SetAlpha(alpha);
      else
        this.flash = nil;
        DHUD_CastingBarTextureHigh:SetAlpha(0);
        DHUD_CastingBarTextureHigh:Hide();
      end
      
        -- fade
    elseif (this.fadeOut) then
    
      local alpha = DHUD_CastingBarTexture:GetAlpha() - CASTING_BAR_ALPHA_STEP;
      if (alpha > 0) then
        DHUD_CastingBarTexture:SetAlpha(alpha);
        DHUD_Castdelay:SetAlpha(alpha);
        DHUD_Casttime:SetAlpha(alpha);
      else
        this.fadeOut = nil;
        DHUD_CastingBarTexture:Hide();
        DHUD_Castdelay:Hide();
        DHUD_Casttime:Hide();
              DHUD_Casting = nil;
                DHUD_updateAlpha();
      end
      
        end

        
    end
    
end

function DHUD_UpdateCombos()
        local points = GetComboPoints()
        if points == 0 then 
            DHUD_TargetCombo1Texture:Hide();
            DHUD_TargetCombo2Texture:Hide();
            DHUD_TargetCombo3Texture:Hide();
            DHUD_TargetCombo4Texture:Hide();
            DHUD_TargetCombo5Texture:Hide();
        elseif points == 1 then
            DHUD_TargetCombo1Texture:Show();
            DHUD_TargetCombo2Texture:Hide();
            DHUD_TargetCombo3Texture:Hide();
            DHUD_TargetCombo4Texture:Hide();
            DHUD_TargetCombo5Texture:Hide();       
        elseif points == 2 then
            DHUD_TargetCombo1Texture:Show();
            DHUD_TargetCombo2Texture:Show();
            DHUD_TargetCombo3Texture:Hide();
            DHUD_TargetCombo4Texture:Hide();
            DHUD_TargetCombo5Texture:Hide();        
        elseif points == 3 then
            DHUD_TargetCombo1Texture:Show();
            DHUD_TargetCombo2Texture:Show();
            DHUD_TargetCombo3Texture:Show();
            DHUD_TargetCombo4Texture:Hide();
            DHUD_TargetCombo5Texture:Hide();        
        elseif points == 4 then
            DHUD_TargetCombo1Texture:Show();
            DHUD_TargetCombo2Texture:Show();
            DHUD_TargetCombo3Texture:Show();
            DHUD_TargetCombo4Texture:Show();
            DHUD_TargetCombo5Texture:Hide();        
        elseif points == 5 then
            DHUD_TargetCombo1Texture:Show();
            DHUD_TargetCombo2Texture:Show();
            DHUD_TargetCombo3Texture:Show();
            DHUD_TargetCombo4Texture:Show();
            DHUD_TargetCombo5Texture:Show();       
        end
end

function DHUD_Animate(bar)

    -- base ändern
    local ph  = math.floor(DHUD_bar[bar] * 100);
    local pha = math.floor(DHUD_bar_anim[bar] * 100);

    -- Abwärts animieren
    if ph < pha then
        DHUD_change[bar] = 1;

        if pha - ph > 10 then
            DHUD_bar_anim[bar] = DHUD_bar_anim[bar] - DHUD_Config["stepfast"];
        else
            DHUD_bar_anim[bar] = DHUD_bar_anim[bar] - DHUD_Config["step"];
        end
        
    -- Aufwärts animieren
    elseif ph > pha then
        DHUD_change[bar] = 1;
    
        if ph - pha > 10 then
            DHUD_bar_anim[bar] = DHUD_bar_anim[bar] + DHUD_Config["stepfast"];
        else
            DHUD_bar_anim[bar] = DHUD_bar_anim[bar] + DHUD_Config["step"];
        end
    
    end

    -- Anim 
    if DHUD_change[bar] == 1 then
        DHUD_SetBar(bar,DHUD_bar_anim[bar]);
        DHUD_change[bar] = 0;
    end
    
end;

function DHUD_SetBar(bar,p,nocolor)

    local texture = getglobal(DHUD_tex[bar]);
    
    -- Hide when Bar empty
    if math.floor(p * 100) == 0 or DHUD_playerDead == 1 then
        texture:Hide();
        return;
    end

    -- Textur Settings laden
    local tex_height, tex_gap_top, tex_gap_bottom;    
    tex_height, tex_gap_top, tex_gap_bottom = unpack(DHUD_texture_settings[bar]);
    
    -- offsets setzen wenn Balken nicht die ganze höhe ausfüllt
    local tex_gap_top_p    = tex_gap_top / tex_height;    
    local tex_gap_bottom_p = tex_gap_bottom / tex_height;
    local h = (tex_height - tex_gap_top - tex_gap_bottom) * p;
    
    -- Textursettings ändern
    local frame   = getglobal(DHUD_attach[bar]);
    local top    = 1-(p-(tex_gap_top_p));
    local bottom = 1-tex_gap_bottom_p;
    
    top = top  - ((tex_gap_top_p+tex_gap_bottom_p)*(1-p));

    texture:Show();
    texture:SetHeight(h);
    texture:SetTexCoord(0, 1, top, bottom );
    texture:SetPoint("BOTTOM", frame, "BOTTOM", 0, tex_gap_bottom);

    if nocolor == nil then
        -- Farbe TODO: optimize that
        local colortype;
        local playerpower;
    
        -- healthcolor
        if ( bar == "PlayerHealth" or  bar == "TargetHealth" or  bar == "PetHealth" ) then
            colortype = "health";
        
        -- Castingbar
        elseif bar == "Castingbar" then
            colortype = "castbar";
    
        elseif bar == "Channelbar" then
            colortype = "channelbar";        
            
        -- manacolor
        else
            if bar == "PlayerMana" then
                playerpower = UnitPowerType("player");
            elseif bar == "TargetMana" then 
                playerpower = UnitPowerType("target");
            else
                playerpower = UnitPowerType("pet");
            end
            
            if (playerpower == 1) then
                colortype = "rage";
            elseif (playerpower == 2) then
                colortype = "focus";
            elseif (playerpower == 3) then
                colortype = "energy";
            else
                colortype = "mana";
            end
        end
        
        -- what uhit?
        local unit;
        
        if ( bar == "PlayerHealth" or bar == "PlayerMana") then
            unit = "player";
        elseif ( bar == "TargetHealth" or bar == "TargetMana") then
            unit = "target";
        elseif ( bar == "PettHealth" or bar == "PetMana") then
            unit = "pet";        
        end
            
        -- set values
        local r, g, b = Get_HColor( p, colortype, unit );
        texture:SetVertexColor(r, g, b);
    end
    
end;

function DHUD_CheckElite()
  local el = UnitClassification("target");
  
  local ret = "";
  if ( el == "worldboss" ) then
        ret = "Boss";
  elseif ( el == "rareelite"  ) then
        ret = "Rare Elite";
  elseif ( el == "elite"  ) then
        ret = "Elite";
  elseif ( el == "rare"  ) then
        ret = "rare";
  else
        return nil;
  end
  
  return "|cffaaaaaa"..ret.."|r";
end

function DHUD_updatePlayerMana()

    DHUD_bar["PlayerMana"] = UnitMana("player")/UnitManaMax("player");

    local playerpower = UnitPowerType("player");
    
    -- krieger
    if (playerpower == 1) then
        DHUD_PlayerMana_Text:SetText( UnitMana("player") );
        
        if UnitMana("player") == 0 then
            DHUD_needMana = nil;
        else
            DHUD_needMana = true;
        end  
        
    -- rogue
    elseif (playerpower == 3) then    
        
        -- display player mana depends on mode
        if  DHUD_Config["playerdisplaymode"] == 1 then
            DHUD_PlayerMana_Text:SetText( UnitMana("player") );
        elseif DHUD_Config["playerdisplaymode"] == 2 then
            DHUD_PlayerMana_Text:SetText( UnitMana("player") );
        elseif DHUD_Config["playerdisplaymode"] == 3 then
            DHUD_PlayerMana_Text:SetText( UnitMana("player")..DHUD_trennzeichen..UnitManaMax("player") );
        else
            DHUD_PlayerMana_Text:SetText("");
        end        

        if math.floor(DHUD_bar["PlayerMana"] * 100) >= 100 then
            DHUD_needMana = nil;
        else
            DHUD_needMana = true;
        end 
    
    -- other                
    else
    
        -- display player mana depends on mode
        if  DHUD_Config["playerdisplaymode"] == 1 then
            DHUD_PlayerMana_Text:SetText( math.floor(DHUD_bar["PlayerMana"] * 100) .. "%");
        elseif DHUD_Config["playerdisplaymode"] == 2 then
            DHUD_PlayerMana_Text:SetText( UnitMana("player") );
        elseif DHUD_Config["playerdisplaymode"] == 3 then
            DHUD_PlayerMana_Text:SetText( UnitMana("player")..DHUD_trennzeichen..UnitManaMax("player") );
        else
            DHUD_PlayerMana_Text:SetText("");
        end
                
        if math.floor(DHUD_bar["PlayerMana"] * 100) == 100 then
            DHUD_needMana = nil;
        else
            DHUD_needMana = true;
        end            
        
    end 
             
    DHUD_updateAlpha();
    
    if DHUD_playerDead == 1 then
        DHUD_PlayerMana_Text:SetText("");
    end
    
    -- set values to bar when no animation
    if DHUD_Config["animatebars"] == 0 then
        DHUD_SetBar("PlayerMana",DHUD_bar["PlayerMana"]);
    end
    
end

function DHUD_updatePlayerHealth()

    DHUD_bar["PlayerHealth"] = tonumber(UnitHealth("player")/UnitHealthMax("player"));
    
    -- display player health depends on mode
    if  DHUD_Config["playerdisplaymode"] == 1 then
        DHUD_PlayerHealth_Text:SetText( math.floor(DHUD_bar["PlayerHealth"] * 100) .. "%");
    elseif DHUD_Config["playerdisplaymode"] == 2 then
        DHUD_PlayerHealth_Text:SetText( UnitHealth("player") );
    elseif DHUD_Config["playerdisplaymode"] == 3 then
        DHUD_PlayerHealth_Text:SetText( UnitHealth("player")..DHUD_trennzeichen..UnitHealthMax("player") );
    else
        DHUD_PlayerHealth_Text:SetText("");
    end
    
    if math.floor(DHUD_bar["PlayerHealth"] * 100) == 100 then
        DHUD_needHealth = nil;
    else
        DHUD_needHealth = true;
    end
    
    -- unit dead?
    if (UnitIsGhost("player")) then
        DHUD_playerDead = 1;
    elseif (UnitIsDead("player")) then
        DHUD_playerDead = 1;
    elseif (not UnitName("player")) then
        DHUD_playerDead = 1;
    else
        DHUD_playerDead = nil;
    end    
    
    if DHUD_playerDead == 1 then
        DHUD_PlayerHealth_Text:SetText("");
    end
    
    DHUD_updateAlpha();
    
    -- set values to bar when no animation
    if DHUD_Config["animatebars"] == 0 then
        DHUD_SetBar("PlayerHealth",DHUD_bar["PlayerHealth"]);
    end
        
end

function DHUD_updateTargetHealth()

    local targethealth;
    local targethealthmax;

    DHUD_bar["TargetHealth"] = UnitHealth("target")/UnitHealthMax("target");

    if UnitHealth("target") == 0 then 
        DHUD_bar["TargetHealth"] = 0;
    end
    
    -- display target health depends on mode
    if  DHUD_Config["targetdisplaymode"] == 1 then
        DHUD_TargetHealth_Text:SetText( math.floor(DHUD_bar["TargetHealth"] * 100) .. "%");
    elseif DHUD_Config["targetdisplaymode"] == 2 then
        targethealth = DHUD_getTargetHealth();
        DHUD_TargetHealth_Text:SetText( targethealth );
    elseif DHUD_Config["targetdisplaymode"] == 3 then
        targethealth = DHUD_getTargetHealth();
        targethealthmax = DHUD_getTargetMaxHealth();
        DHUD_TargetHealth_Text:SetText( targethealth..DHUD_trennzeichen..targethealthmax );
    else
        DHUD_TargetHealth_Text:SetText("");
    end
           
    -- set values to bar when no animation
    if DHUD_Config["animatebars"] == 0 then
        DHUD_SetBar("TargetHealth",DHUD_bar["TargetHealth"]);
    end
                    
end

function DHUD_updateTargetMana()

    DHUD_bar["TargetMana"] = UnitMana("target")/UnitManaMax("target");

    if UnitMana("target") == 0 then 
        DHUD_bar["TargetMana"] = 0;
    end
            
    -- display target health depends on mode
    if  DHUD_Config["targetdisplaymode"] == 1 then
        local percent = "%";
        local upt;
        
        upt = UnitPowerType("target");
        
        if upt == 1 or upt == 3 then
            percent = "";
        end
        
        DHUD_TargetMana_Text:SetText( math.floor(DHUD_bar["TargetMana"] * 100) .. percent);
    elseif DHUD_Config["targetdisplaymode"] == 2 then
        DHUD_TargetMana_Text:SetText( UnitMana("target") );
    elseif DHUD_Config["targetdisplaymode"] == 3 then
        DHUD_TargetMana_Text:SetText( UnitMana("target")..DHUD_trennzeichen..UnitManaMax("target") );
    else
        DHUD_TargetMana_Text:SetText("");
    end

    -- set values to bar when no animation
    if DHUD_Config["animatebars"] == 0 then
        DHUD_SetBar("TargetMana",DHUD_bar["TargetMana"]);
    end
          
end

function DHUD_updatePetHealth()

    if UnitHealth("pet") <= 0 then
        DHUD_PetHealth:Hide();
        DHUD_PetneedHealth = nil;
        DHUD_SetBar("PetHealth",0);
        return;
    end

    DHUD_bar["PetHealth"] = UnitHealth("pet")/UnitHealthMax("pet");

    if UnitHealth("pet") == 0 then 
        DHUD_bar["PetHealth"] = 0;
    end
    
    -- display target health depends on mode
    if  DHUD_Config["petdisplaymode"] == 1 then
        DHUD_PetHealth_Text:SetText( math.floor(DHUD_bar["PetHealth"] * 100) .. "%");
    elseif DHUD_Config["petdisplaymode"] == 2 then
        DHUD_PetHealth_Text:SetText( UnitHealth("pet") );
    elseif DHUD_Config["petdisplaymode"] == 3 then
        DHUD_PetHealth_Text:SetText( UnitHealth("pet")..DHUD_trennzeichen..UnitHealthMax("pet") );
    else
        DHUD_PetHealth_Text:SetText("");
    end
    
    -- does pet have full health?
    if math.floor(DHUD_bar["PetHealth"] * 100) == 100 then
        DHUD_PetneedHealth = nil;
    else
        DHUD_PetneedHealth = true;
    end   
    
    DHUD_updateAlpha(); 

    -- set values to bar when no animation
    if DHUD_Config["animatebars"] == 0 then
        DHUD_SetBar("PetHealth",DHUD_bar["PetHealth"]);
    end
    
end

function DHUD_updatePetMana()

    if UnitHealth("pet") <= 0 then
        DHUD_PetMana:Hide();
        DHUD_PetneedMana = nil;
        DHUD_SetBar("PetMana",0);
        return;
    end
    
    DHUD_bar["PetMana"] = UnitMana("pet")/UnitManaMax("pet");

    if UnitMana("pet") == 0 then 
        DHUD_bar["PetMana"] = 0;
    end
            
    -- display target health depends on mode
    if  DHUD_Config["petdisplaymode"] == 1 then
        DHUD_PetMana_Text:SetText( math.floor(DHUD_bar["PetMana"] * 100) .. "%");
    elseif DHUD_Config["petdisplaymode"] == 2 then
        DHUD_PetMana_Text:SetText( UnitMana("pet") );
    elseif DHUD_Config["petdisplaymode"] == 3 then
        DHUD_PetMana_Text:SetText( UnitMana("pet")..DHUD_trennzeichen..UnitManaMax("pet") );
    else
        DHUD_PetMana_Text:SetText("");
    end
    
    -- does pet have full mana?
    if math.floor(DHUD_bar["PetMana"] * 100) >= 100 then
        DHUD_PetneedMana = nil;
    else
        DHUD_PetneedMana = true;
    end 
    
    DHUD_updateAlpha();

    -- set values to bar when no animation
    if DHUD_Config["animatebars"] == 0 then
        DHUD_SetBar("PetMana",DHUD_bar["PetMana"]);
    end
        
end

-- range command
function DHUD_CommandRange(command,rest)

    local num = tonumber(rest);
    if num == nil then
        DEFAULT_CHAT_FRAME:AddMessage(string.format(DHUD_CommandList[command]["output"],
                                                    command,
                                                    DHUD_CommandList[command]["minvalue"],
                                                    DHUD_CommandList[command]["maxvalue"])); 
        return;
    end
    if num >= DHUD_CommandList[command]["minvalue"] and num <= DHUD_CommandList[command]["maxvalue"] then
        DHUD_SetConfig(command,num);
        DHUD_init();
        DEFAULT_CHAT_FRAME:AddMessage(string.format(DHUD_CommandList[command]["response"],
                                                    command,
                                                    num,
                                                    DHUD_CommandList[command]["minvalue"],
                                                    DHUD_CommandList[command]["maxvalue"])); 
        return;
    else    
        DEFAULT_CHAT_FRAME:AddMessage(string.format(DHUD_CommandList[command]["output"],
                                                    command,
                                                    DHUD_CommandList[command]["minvalue"],
                                                    DHUD_CommandList[command]["maxvalue"])); 
        return;
    end
    

end

function DHUD_OptionsFrame_Toggle()
  if(DHUDOptionsFrame:IsVisible()) then
    DHUDOptionsFrame:Hide();
  else
    DHUDOptionsFrame:Show();
  end
end

function DHUD_SCommandHandler(msg)

    if msg then
        local b,e,command,rest = string.find(msg, "^%s*([^%s]+)%s*(.*)$");
        
        if b then      
            for var , commandStrings in DHUD_CommandList do
                if ( command == commandStrings["command"] ) then
                    if commandStrings["type"] == "range" then
                        DHUD_CommandRange(var,rest);
                        return;
                    elseif commandStrings["type"] == "toggle" then
                        DHUD_ToggleConfig(var);
                        return;
                    elseif commandStrings["type"] == "reset" then
                        DHUD_reset(); 
                        DEFAULT_CHAT_FRAME:AddMessage(DHUD_CommandList[var]["response"]);
                        return;  
                    elseif commandStrings["type"] == "color" then
                        DHUD_SetColor(var, rest);
                        return;
                    elseif commandStrings["type"] == "menu" then
                        DHUD_OptionsFrame_Toggle();
                        DEFAULT_CHAT_FRAME:AddMessage(DHUD_CommandList[var]["response"]);
                        return;  
                    end
                end
            end
        end
        
        -- ausgabe der slash befehle
        for var , commandStrings in DHUD_CommandList do
            if commandStrings["type"] == "range" then
                DEFAULT_CHAT_FRAME:AddMessage(string.format(DHUD_CommandList[var]["output"],DHUD_CommandList[var]["command"],DHUD_CommandList[var]["minvalue"],DHUD_CommandList[var]["maxvalue"]));
            elseif commandStrings["type"] == "toggle" then
                DEFAULT_CHAT_FRAME:AddMessage(string.format(DHUD_CommandList[var]["output"],DHUD_CommandList[var]["command"]));
            elseif commandStrings["type"] == "reset" then
                DEFAULT_CHAT_FRAME:AddMessage(DHUD_CommandList[var]["output"]);
            elseif commandStrings["type"] == "color" then
                DEFAULT_CHAT_FRAME:AddMessage(string.format(DHUD_CommandList[var]["output"],DHUD_CommandList[var]["command"]));
            elseif commandStrings["type"] == "menu" then
                DEFAULT_CHAT_FRAME:AddMessage(DHUD_CommandList[var]["output"]);
            end
        end
    end
    
end

function DHUD_SetConfig(key, value)
   if (DHUD_Config[key] ~= value) then
      DHUD_Config[key] = value;
   end
end

function DHUD_SetColor(key, value)
   if (DHUD_Config[key] ~= value) then
      DHUD_Config[key] = value;
      DEFAULT_CHAT_FRAME:AddMessage( string.format(DHUD_CommandList[key]["response"], key, value , value) ); 
   end
end

function DHUD_defaultConfig(key)
    if (not DHUD_Config[key]) then
      DHUD_Config[key] = DHUD_Config_default[key];
    end  
end

function DHUD_resetConfig(key)
      DHUD_Config[key] = DHUD_Config_default[key];
end

function DHUD_commandColor(key, value)
   if (DHUD_Config[key] == nil) then
      DHUD_Config[key] = "ffffff";
   end
   
   DHUD_Config[key] = value;
   
   DEFAULT_CHAT_FRAME:AddMessage(string.format(DHUD_CommandList[key]["response"],
                                                  key,
                                                  "|cffff0000"..value.."|r"));                                               
end

function DHUD_ToggleConfig(key)
   if (DHUD_Config[key] == nil) then
      DHUD_Config[key] = 0;
   end

   if (DHUD_Config[key] == 1) then
      DHUD_Config[key] = 0;
      DEFAULT_CHAT_FRAME:AddMessage(string.format(DHUD_CommandList[key]["response"],
                                                  key,
                                                  "|cffff0000OFF|r"));                                                   
   else
      DHUD_Config[key] = 1;
      DEFAULT_CHAT_FRAME:AddMessage(string.format(DHUD_CommandList[key]["response"],
                                                  key,
                                                  "|cff00ff00ON|r"));  
   end
   
   DHUD_init();
   
end

function DHUD_init()

    -- set scale
    DHUD:SetScale(DHUD_Config["scale"]);
    
    -- Set default bars
    if UnitPowerType("player") == 1 then
        DHUD_SetBar("PlayerMana"    ,0);
    else
        DHUD_SetBar("PlayerMana"    ,1);
    end
    DHUD_SetBar("PlayerHealth"  ,1);
    DHUD_SetBar("TargetMana"    ,0);
    DHUD_SetBar("TargetHealth"  ,0);
    DHUD_SetBar("PetMana"    ,1);
    DHUD_SetBar("PetHealth"  ,1); 
    
    -- setcombo position
    local DHUD_layer_pos;
    if DHUD_Config["showtarget"] == 1 then
        DHUD_layer_pos = {
            ["DHUD_TargetCombo1Texture"] = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , 17 ,  40 },
            ["DHUD_TargetCombo2Texture"] = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , 7 , 61 },
            ["DHUD_TargetCombo3Texture"] = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , -1 , 83 },
            ["DHUD_TargetCombo4Texture"] = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , -6 , 105 },
            ["DHUD_TargetCombo5Texture"] = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , -7 , 127 },
        }
    else
        DHUD_layer_pos = {
            ["DHUD_TargetCombo1Texture"] = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , 17 ,  40 },
            ["DHUD_TargetCombo2Texture"] = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , 7 , 61 },
            ["DHUD_TargetCombo3Texture"] = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , -1 , 83 },
            ["DHUD_TargetCombo4Texture"] = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , -6 , 105 },
            ["DHUD_TargetCombo5Texture"] = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , -7 , 127 },

        }
    end 
    
    local texname;
    local v;
    for texname, v in DHUD_layer_pos do
        local point, frame, relativePoint , x, y = unpack(v);
        local texture = getglobal(texname);
        texture:ClearAllPoints();
        texture:SetPoint(point, frame, relativePoint , x, y);
    end
    
    -- pos textures
    local DHUD_texture_pos = {
        ["DHUD"]              = { "CENTER", "UIParent"       , "CENTER" , DHUD_Config["xoffset"]        , DHUD_Config["yoffset"]         },
        ["DHUD_LeftFrame"]    = { "TOP"   , "DHUD"           , "TOP"    , 0 - DHUD_Config["hudspacing"] , 0                              },
        ["DHUD_RightFrame"]   = { "TOP"   , "DHUD"           , "TOP"    , DHUD_Config["hudspacing"]     , 0                              },
        ["DHUD_Target"]       = { "BOTTOM", "DHUD"           , "BOTTOM" , 0                             , DHUD_Config["targettexty"]     },
        ["DHUD_PlayerHealth"] = { "BOTTOM", "DHUD_LeftFrame" , "BOTTOM" , DHUD_Config["playerhptextx"]  , DHUD_Config["playerhptexty"]   },
        ["DHUD_PlayerMana"]   = { "BOTTOM", "DHUD_LeftFrame", "BOTTOM" , DHUD_Config["playermanatextx"], DHUD_Config["playermanatexty"] },
        ["DHUD_TargetHealth"] = { "BOTTOM", "DHUD_RightFrame" , "BOTTOM" , DHUD_Config["targethptextx"]  , DHUD_Config["targethptexty"]   },
        ["DHUD_TargetMana"]   = { "BOTTOM", "DHUD_RightFrame", "BOTTOM" , DHUD_Config["targetmanatextx"], DHUD_Config["targetmanatexty"] },
        ["DHUD_PetHealth"]    = { "BOTTOM", "DHUD_LeftFrame" , "BOTTOM" , DHUD_Config["pethptextx"]     , DHUD_Config["pethptexty"]      },
        ["DHUD_PetMana"]      = { "BOTTOM", "DHUD_RightFrame", "BOTTOM" , DHUD_Config["petmanatextx"]   , DHUD_Config["petmanatexty"]    }, 
    }
    
    local texname;
    local v;
    for texname, v in DHUD_texture_pos do
        local point, frame, relativePoint , x, y = unpack(v);
        local texture = getglobal(texname);
        texture:ClearAllPoints();
        texture:SetPoint(point, frame, relativePoint , x, y);
        texture:EnableMouse(0);
    end
                                  
    -- set fonts
    DHUD_setFont("DHUD_PetHealth_Text", DHUD_Config["fontsizepet"] / DHUD_Config["scale"] ,       DHUD_Outline[ DHUD_Config["pethpoutline"] ]);
    DHUD_setFont("DHUD_PetMana_Text", DHUD_Config["fontsizepet"] / DHUD_Config["scale"] ,         DHUD_Outline[ DHUD_Config["petmanaoutline"] ]);
    DHUD_setFont("DHUD_PlayerHealth_Text", DHUD_Config["fontsizeplayer"] / DHUD_Config["scale"] , DHUD_Outline[ DHUD_Config["playerhpoutline"] ]);
    DHUD_setFont("DHUD_PlayerMana_Text", DHUD_Config["fontsizeplayer"] / DHUD_Config["scale"] ,   DHUD_Outline[ DHUD_Config["playermanaoutline"] ]);
    DHUD_setFont("DHUD_TargetHealth_Text", DHUD_Config["fontsizetarget"] / DHUD_Config["scale"] , DHUD_Outline[ DHUD_Config["targethpoutline"] ]);
    DHUD_setFont("DHUD_TargetMana_Text", DHUD_Config["fontsizetarget"] / DHUD_Config["scale"] ,   DHUD_Outline[ DHUD_Config["targetmanaoutline"] ]);    
    DHUD_setFont("DHUD_TargetName", DHUD_Config["fontsizetargetname"] / DHUD_Config["scale"] ,    DHUD_Outline[ DHUD_Config["targetoutline"] ]);   
    DHUD_setFont("DHUD_Casttime_Text", DHUD_Config["fontsizecasttime"] / DHUD_Config["scale"] ,   DHUD_Outline[ DHUD_Config["casttimeoutline"] ]);
    DHUD_setFont("DHUD_Castdelay_Text", DHUD_Config["fontsizecastdelay"] / DHUD_Config["scale"] , DHUD_Outline[ DHUD_Config["castdelayoutline"] ]);
    
    -- font colors
    DHUD_Castdelay_Text:SetVertexColor(DHUD_hextodec(DHUD_Config["castdelaytextcolor"]));
    DHUD_Casttime_Text:SetVertexColor(DHUD_hextodec(DHUD_Config["casttimetextcolor"]));
    DHUD_PlayerHealth_Text:SetVertexColor(DHUD_hextodec(DHUD_Config["playerhptextcolor"]));
    DHUD_PlayerMana_Text:SetVertexColor(DHUD_hextodec(DHUD_Config["playermanatextcolor"]));
    DHUD_TargetHealth_Text:SetVertexColor(DHUD_hextodec(DHUD_Config["targethptextcolor"]));
    DHUD_TargetMana_Text:SetVertexColor(DHUD_hextodec(DHUD_Config["targetmanatextcolor"]));
    DHUD_PetHealth_Text:SetVertexColor(DHUD_hextodec(DHUD_Config["pethptextcolor"]));
    DHUD_PetMana_Text:SetVertexColor(DHUD_hextodec(DHUD_Config["petmanatextcolor"]));
                                               
    -- set combopoints
    DHUD_UpdateCombos();  

    -- hide Auras
    DHUD_hideAuras();
    
    --
    DHUD_changeBackgroundTexture();
        
    -- reset target settings
    DHUD_updateTargetChanged();
    
    -- 
    DHUD_updatePetHealth(); 
    DHUD_updatePetMana();
    DHUD_updatePlayerMana();
    DHUD_updatePlayerHealth();
    
    -- update alpha
    DHUD_updateAlpha();
    
    -- DUF / Perl Installed? Dont show Blizz frames
    if (DUF_INITIALIZED or Perl_Config or Perl_Config_Config) then
        DHUD_Config["btarget"] = 0;
    end

    -- Hide Blizz Target Frames
    if DHUD_Config["btarget"] == 0 then
        TargetFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
        TargetFrame:UnregisterEvent("UNIT_HEALTH")
        TargetFrame:UnregisterEvent("UNIT_LEVEL")
        TargetFrame:UnregisterEvent("UNIT_FACTION")
        TargetFrame:UnregisterEvent("UNIT_CLASSIFICATION_CHANGED")
        TargetFrame:UnregisterEvent("UNIT_AURA")
        TargetFrame:UnregisterEvent("PLAYER_FLAGS_CHANGED")
        TargetFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
        TargetFrame:Hide()
        ComboFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
        ComboFrame:UnregisterEvent("PLAYER_COMBO_POINTS")
    else
        TargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
        TargetFrame:RegisterEvent("UNIT_HEALTH")
        TargetFrame:RegisterEvent("UNIT_LEVEL")
        TargetFrame:RegisterEvent("UNIT_FACTION")
        TargetFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
        TargetFrame:RegisterEvent("UNIT_AURA")
        TargetFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
        TargetFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
        if UnitExists("target") then TargetFrame:Show() end
        ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
        ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS")
    end
    
    if DHUD_Config["bplayer"] == 0 then
        PlayerFrame:UnregisterEvent("UNIT_LEVEL")
        PlayerFrame:UnregisterEvent("UNIT_COMBAT")
        PlayerFrame:UnregisterEvent("UNIT_SPELLMISS")
        PlayerFrame:UnregisterEvent("UNIT_PVP_UPDATE")
        PlayerFrame:UnregisterEvent("UNIT_MAXMANA")
        PlayerFrame:UnregisterEvent("PLAYER_ENTER_COMBAT")
        PlayerFrame:UnregisterEvent("PLAYER_LEAVE_COMBAT")
        PlayerFrame:UnregisterEvent("PLAYER_UPDATE_RESTING")
        PlayerFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
        PlayerFrame:UnregisterEvent("PARTY_LEADER_CHANGED")
        PlayerFrame:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED")
        PlayerFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
        PlayerFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
        PlayerFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
        PlayerFrameHealthBar:UnregisterEvent("UNIT_HEALTH")
        PlayerFrameHealthBar:UnregisterEvent("UNIT_MAXHEALTH")
        PlayerFrameManaBar:UnregisterEvent("UNIT_MANA")
        PlayerFrameManaBar:UnregisterEvent("UNIT_RAGE")
        PlayerFrameManaBar:UnregisterEvent("UNIT_FOCUS")
        PlayerFrameManaBar:UnregisterEvent("UNIT_ENERGY")
        PlayerFrameManaBar:UnregisterEvent("UNIT_HAPPINESS")
        PlayerFrameManaBar:UnregisterEvent("UNIT_MAXMANA")
        PlayerFrameManaBar:UnregisterEvent("UNIT_MAXRAGE")
        PlayerFrameManaBar:UnregisterEvent("UNIT_MAXFOCUS")
        PlayerFrameManaBar:UnregisterEvent("UNIT_MAXENERGY")
        PlayerFrameManaBar:UnregisterEvent("UNIT_MAXHAPPINESS")
        PlayerFrameManaBar:UnregisterEvent("UNIT_DISPLAYPOWER")
        PlayerFrame:UnregisterEvent("UNIT_NAME_UPDATE")
        PlayerFrame:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
        PlayerFrame:UnregisterEvent("UNIT_DISPLAYPOWER")
        PlayerFrame:Hide()
    else
        PlayerFrame:RegisterEvent("UNIT_LEVEL")
        PlayerFrame:RegisterEvent("UNIT_COMBAT")
        PlayerFrame:RegisterEvent("UNIT_SPELLMISS")
        PlayerFrame:RegisterEvent("UNIT_PVP_UPDATE")
        PlayerFrame:RegisterEvent("UNIT_MAXMANA")
        PlayerFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
        PlayerFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
        PlayerFrame:RegisterEvent("PLAYER_UPDATE_RESTING")
        PlayerFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
        PlayerFrame:RegisterEvent("PARTY_LEADER_CHANGED")
        PlayerFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
        PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
        PlayerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
        PlayerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
        PlayerFrameHealthBar:RegisterEvent("UNIT_HEALTH")
        PlayerFrameHealthBar:RegisterEvent("UNIT_MAXHEALTH")
        PlayerFrameManaBar:RegisterEvent("UNIT_MANA")
        PlayerFrameManaBar:RegisterEvent("UNIT_RAGE")
        PlayerFrameManaBar:RegisterEvent("UNIT_FOCUS")
        PlayerFrameManaBar:RegisterEvent("UNIT_ENERGY")
        PlayerFrameManaBar:RegisterEvent("UNIT_HAPPINESS")
        PlayerFrameManaBar:RegisterEvent("UNIT_MAXMANA")
        PlayerFrameManaBar:RegisterEvent("UNIT_MAXRAGE")
        PlayerFrameManaBar:RegisterEvent("UNIT_MAXFOCUS")
        PlayerFrameManaBar:RegisterEvent("UNIT_MAXENERGY")
        PlayerFrameManaBar:RegisterEvent("UNIT_MAXHAPPINESS")
        PlayerFrameManaBar:RegisterEvent("UNIT_DISPLAYPOWER")
        PlayerFrame:RegisterEvent("UNIT_NAME_UPDATE")
        PlayerFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
        PlayerFrame:RegisterEvent("UNIT_DISPLAYPOWER")
        PlayerFrame:Show()
    end
    
    -- hide mobhealth frame?
    if DHUD_Config["btarget"] == 0 then     
        if (MI2_MobHealthFrame) then
            MI2_MobHealthFrame:Hide();
        end
        if (MobHealthFrame) then
            MobHealthFrame:Hide();
        end  
    else
        if (MI2_MobHealthFrame) then
            MI2_MobHealthFrame:Show();
        end
        if (MobHealthFrame) then
            MobHealthFrame:Show();
        end  
    end
    
    -- hide minimap button=
    if DHUD_Config["showmmb"] == 1 then 
        DHUD_MinimapButton:Show();            
    else
        DHUD_MinimapButton:Hide();
    end
    
    -- set minimab button angle
    local where = DHUD_Config["minimapw"];
    local mx = 52 - (80 * cos(where));
    local my = (80 * sin(where)) - 52;
    DHUD_MinimapButton:ClearAllPoints();
    DHUD_MinimapButton:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", mx,my);

    -- init castbar
    this.casting     = nil;
    this.channeling  = nil;
    this.holdTime    = 1;		
    this.maxValue    = 0;	 
    this.endTime     = 0;
    this.startTime   = 0; 
    this.delay       = 0;
    
    -- hide blizz castbar
    if DHUD_Config["castingbar"] == 1 then
        CastingBarFrame:UnregisterEvent("SPELLCAST_START");
        CastingBarFrame:UnregisterEvent("SPELLCAST_STOP");
        CastingBarFrame:UnregisterEvent("SPELLCAST_FAILED");
        CastingBarFrame:UnregisterEvent("SPELLCAST_INTERRUPTED");
        CastingBarFrame:UnregisterEvent("SPELLCAST_DELAYED");
        CastingBarFrame:UnregisterEvent("SPELLCAST_CHANNEL_START");
        CastingBarFrame:UnregisterEvent("SPELLCAST_CHANNEL_UPDATE");
        CastingBarFrame:UnregisterEvent("SPELLCAST_CHANNEL_STOP");
        CastingBarFrame:Hide();
    else
        CastingBarFrame:RegisterEvent("SPELLCAST_START");
        CastingBarFrame:RegisterEvent("SPELLCAST_STOP");
        CastingBarFrame:RegisterEvent("SPELLCAST_FAILED");
        CastingBarFrame:RegisterEvent("SPELLCAST_INTERRUPTED");
        CastingBarFrame:RegisterEvent("SPELLCAST_DELAYED");
        CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_START");
        CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
        CastingBarFrame:RegisterEvent("SPELLCAST_CHANNEL_STOP");
    end;
 
end

function DHUD_hideAuras()
    -- hide Auras
    local i, button;
    
    for i = 1, 16 do
        button = getglobal("DHUDBuff"..i);
        button:Hide();
        
        button = getglobal("DHUDDeBuff"..i);
        button:Hide();
    end
end
        
function DHUD_reset()

    for k, v in DHUD_Config_default do
        DHUD_resetConfig(k);
    end
    
    DHUD_init();

end

function DHUD_getTargetHealth()

  local h;
  
  -- get health from mobinfo / mobhealth
  if MobHealth_GetTargetCurHP then
      -- mobhealth2
    h = MobHealth_GetTargetCurHP();
  elseif MobHealth_PPP and UnitName("target") and  UnitLevel("target") then
      -- mobinfo
        local mi = UnitName("target")..":"..UnitLevel("target");
        local p = MobHealth_PPP(mi);
        h = math.floor(UnitHealth("target") * p + 0.5);
    elseif MobHealthDB and UnitName("target") and  UnitLevel("target") then
        -- telos mobhealth
        local mi = UnitName("target")..":"..UnitLevel("target");
        local p = DHUD_MobHealth_PPP(mi);
        h = math.floor(UnitHealth("target") * p + 0.5);
  else
      -- nu values
    h = UnitHealth("target");
  end
  
  -- we have no values? ok lets do it the old way
  if ((not h) or h == 0) then 
     h = UnitHealth("target"); 
    end
    
  return tonumber(h);

end


function DHUD_getTargetMaxHealth()

  local h;
  
  -- get Maxhealth from mobinfo / mobhealth
  if (MobHealth_GetTargetMaxHP and UnitHealth("target") > 0) then
    h = MobHealth_GetTargetMaxHP();
  elseif (MobHealth_PPP and UnitName("target") and UnitLevel("target")) then
        local mi = UnitName("target")..":"..UnitLevel("target");
        local p = MobHealth_PPP(mi);
        h = math.floor(100 * p + 0.5);
    elseif MobHealthDB and UnitName("target") and  UnitLevel("target") then
        -- telos mobhealth
        local mi = UnitName("target")..":"..UnitLevel("target");
        local p = DHUD_MobHealth_PPP(mi);
        h = math.floor(100 * p + 0.5);
  else
      -- no values
    h = UnitHealthMax("target");
  end
  
  -- we have no values? ok lets do it the old way
    if ((not h) or h == 0) then 
        h = UnitHealthMax("target"); 
    end
        
  return tonumber(h);
end


function DHUD_checkShowNPC()

    if UnitName("target") and DHUD_Config["shownpc"] == 0 and not UnitIsPlayer("target") and not UnitCanAttack("player", "target") and not UnitPlayerControlled("target") then
        return true;
    else
        return false;
    end

end

-- colorize
function Get_HColor( percent, typ, unit )

    local r, g, b, diff,dcolor, color1, color2; 
    local threshold1 = 0.6;    
    local threshold2 = 0.3;    

    -- omly tap target bars
    if unit == "target" then
        if (UnitIsTapped("target") and (not UnitIsTappedByPlayer("target"))) then
            typ = "tapped";
        end
    end
       
    dcolor = DHUD_BarColor[typ]["start"];
    color1 = DHUD_BarColor[typ]["middle"];
    color2 = DHUD_BarColor[typ]["end"];
        
    if ( percent <= threshold2 ) then
        r = color2["r"];        
        g = color2["g"];        
        b = color2["b"];    
    elseif ( percent <= threshold1) then        
        diff = 1 - (percent - threshold2) / (threshold1 - threshold2);
        r = color1["r"] - (color1["r"] - color2["r"]) * diff;        
        g = color1["g"] - (color1["g"] - color2["g"]) * diff;        
        b = color1["b"] - (color1["b"] - color2["b"]) * diff;    
    elseif ( percent < 1) then        
        diff = 1 - (percent - threshold1) / (1 - threshold1);        
        r = dcolor["r"] - (dcolor["r"] - color1["r"]) * diff;        
        g = dcolor["g"] - (dcolor["g"] - color1["g"]) * diff;        
        b = dcolor["b"] - (dcolor["b"] - color1["b"]) * diff;    
    else       
        return dcolor["r"], dcolor["g"], dcolor["b"];    
    end        
    
    if (r < 0) then r = 0; end    
    if (r > 1) then r = 1; end    
    if (g < 0) then g = 0; end    
    if (g > 1) then g = 1; end    
    if (b < 0) then b = 0; end    
    if (b > 1) then b = 1; end        
           
    return r, g, b;    
    
end

-- decimal to hex
function DHUD_DecToHex(red,green,blue)
  if ( not red or not green or not blue ) then
    return "ffffff"
  end

  red = floor(red * 255)
  green = floor(green * 255)
  blue = floor(blue * 255)

  local a,b,c,d,e,f

  a = DHUD_GiveHex(floor(red / 16))
  b = DHUD_GiveHex(math.mod(red,16))
  c = DHUD_GiveHex(floor(green / 16))
  d = DHUD_GiveHex(math.mod(green,16))
  e = DHUD_GiveHex(floor(blue / 16))
  f = DHUD_GiveHex(math.mod(blue,16))

  return a..b..c..d..e..f
end

function DHUD_GiveHex(dec)
  for key, value in DHUD_HexTable do
    if ( dec == value ) then
      return key
    end
  end
  return ""..dec
end

-- telos mobhealth support
function DHUD_MobHealth_PPP(index)
  if( index and MobHealthDB[index] ) then
    local s, e;
    local pts;
    local pct;
    
    s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
    if( pts and pct ) then
      pts = pts + 0;
      pct = pct + 0;
      if( pct ~= 0 ) then
        return pts / pct;
      end
    end
  end
  return 0;
end

-- create minimap button
function DHUD_createMMB()

    local f = CreateFrame("Button", "DHUD_MinimapButton", Minimap );
    f:SetWidth(31);
    f:SetHeight(31);
    f:SetFrameStrata("HIGH");
    f:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT");
    f:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
    if f.SetTopLevel then 
        f:SetTopLevel(1)
    end
    
    local bgt = f:CreateTexture("DHUD_MMBGTexture","BACKGROUND");
    bgt:SetTexture("Interface\\Icons\\Ability_Druid_TravelForm");
    bgt:SetPoint("TOPLEFT", f, "TOPLEFT", 6, -5);
    bgt:SetHeight(20);
    bgt:SetWidth(20);
    
    local t = f:CreateTexture("DHUD_MMTexture","OVERLAY");
    t:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");
    t:SetPoint("TOPLEFT", f, "TOPLEFT");
    t:SetHeight(53);
    t:SetWidth(53);    
   
    local DHUD_MMBClick = function() 
      if DHUDOptionsFrame:IsVisible() then
        DHUDOptionsFrame:Hide();
      else
        DHUDOptionsFrame:Show();
      end
    end
    
    f:RegisterForClicks("LeftButtonUp");
    f:SetScript("OnClick", DHUD_MMBClick );
    
end

-- MyAddonsSupport
function DHUD_myAddons()

    if (myAddOnsFrame_Register) then
    
        -- myAddOns Support
        local DHUD_mya = {
            ["name"]         = "DHUD",
            ["version"]      = DHUD_version,
            ["author"]       = "Drathal/Silberklinge (Markus Inger)",
            ["category"]     = MYADDONS_CATEGORY_COMBAT,
            ["email"]        = "dhud@markus-inger.de",
            ["website"]      = "http://www.markus-inger.de",
            ["optionsframe"] = "DHUDOptionsFrame",
        };

        myAddOnsFrame_Register(DHUD_mya);
    
    end
    
end

-- dropdown functions (player/target)
function DHUD_Player_DropDown_OnLoad()
  UIDropDownMenu_Initialize(this, DHUD_Player_DropDown_Initialize, "MENU");
end

function DHUD_Player_DropDown_Initialize()
  UnitPopup_ShowMenu(DHUD_Player_DropDown, "SELF", "player");
end

function DHUD_Target_DropDown_OnLoad()
  UIDropDownMenu_Initialize(this, DHUD_Target_DropDown_Initialize, "MENU");
end

function DHUD_Target_DropDown_Initialize()
  local menu = nil;
  if (UnitIsEnemy("target", "player")) then
    return;
  end
  if (UnitIsUnit("target", "player")) then
    menu = "SELF";
  elseif (UnitIsUnit("target", "pet")) then
    menu = "PET";
  elseif (UnitIsPlayer("target")) then
    if (UnitInParty("target")) then
      menu = "PARTY";
    else
      menu = "PLAYER";
    end
  end
  
  if (menu) then
    UnitPopup_ShowMenu( DHUD_Target_DropDown, menu, "target" );
  end
end

function DHUD_Target_OnClick()
    
    if ( IsAltKeyDown() or IsControlKeyDown() or IsShiftKeyDown() ) then
        if (GetNumPartyMembers() > 0) then
            ToggleDropDownMenu(1, nil, DHUD_Player_DropDown, "DHUD_Target", 25, 10);
        else
             DEFAULT_CHAT_FRAME:AddMessage("DHUD: You are not in a Party.");
        end
    else
        ToggleDropDownMenu(1, nil, DHUD_Target_DropDown, "DHUD_Target", 25, 10);
    end

end

-- set font
function DHUD_setFont(frame,size,outline)

    local font = getglobal(frame);
    font:SetFont(DHUD_defaultfont, size, outline);
    
end

-- hexcolor to rgb 
function DHUD_hextodec(hex)

    local r1 = tonumber(DHUD_HexTable[ string.lower(string.sub(hex,1,1)) ] * 16);
    local r2 = tonumber(DHUD_HexTable[ string.lower(string.sub(hex,2,2)) ]);
    local r  = (r1 + r2) / 255;

    local g1 = tonumber(DHUD_HexTable[ string.lower(string.sub(hex,3,3)) ] * 16);
    local g2 = tonumber(DHUD_HexTable[ string.lower(string.sub(hex,4,4)) ]);
    local g  = (g1 + g2) / 255;
    
    local b1 = tonumber(DHUD_HexTable[ string.lower(string.sub(hex,5,5)) ] * 16);
    local b2 = tonumber(DHUD_HexTable[ string.lower(string.sub(hex,6,6)) ]);
    local b  = (b1 + b2) / 255;
       
    return r,g,b
end
