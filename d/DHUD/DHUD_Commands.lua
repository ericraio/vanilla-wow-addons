DHUD_CommandList = {
    ["scale"] = {
                    ["type"]     = "range",
                    ["command"]  = "scale",
                    ["minvalue"] = 0.5,
                    ["maxvalue"] = 2,
                },
    ["fontsizecasttime"] = {
                    ["type"]     = "range",
                    ["command"]  = "fontsizecasttime",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                },
    ["fontsizecastdelay"] = {
                    ["type"]     = "range",
                    ["command"]  = "fontsizecastdelay",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                },
    ["fontsizetargetname"] = {
                    ["type"]     = "range",
                    ["command"]  = "fontsizetargetname",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                },
    ["fontsizetarget"] = {
                    ["type"]     = "range",
                    ["command"]  = "fontsizetarget",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                }, 
    ["fontsizeplayer"] = {
                    ["type"]     = "range",
                    ["command"]  = "fontsizeplayer",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                },                
    ["fontsizepet"] = {
                    ["type"]     = "range",
                    ["command"]      = "fontsizepet",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 30,
                },    
    ["combatAlpha"] = {
                    ["type"]     = "range",
                    ["command"]  = "combatalpha",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 1,
                },   
    ["oocAlpha"] = {
                    ["type"]     = "range",
                    ["command"]  = "nocombatalpha",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 1,
                },
    ["selAlpha"] = {
                    ["type"]     = "range",
                    ["command"]  = "selectalpha",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 1,
                },
    ["regAlpha"] = {
                    ["type"]     = "range",
                    ["command"]  = "regalpha",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 1,
                },
    ["playerdisplaymode"] = {
                    ["type"]     = "range",
                    ["command"]  = "playerdisplaymode",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 4,
                },
    ["targetdisplaymode"] = {
                    ["type"]     = "range",
                    ["command"]  = "targetdisplaymode",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 4,
                },
    ["petdisplaymode"] = {
                    ["type"]     = "range",
                    ["command"]      = "petdisplaymode",
                    ["minvalue"] = 1,
                    ["maxvalue"] = 4,
                },
    ["xoffset"] = {
                    ["type"]     = "range",
                    ["command"]  = "xoffset",
                    ["minvalue"] = -1000,
                    ["maxvalue"] = 1000,
                },
    ["yoffset"] = {
                    ["type"]     = "range",
                    ["command"]  = "yoffset",
                    ["minvalue"] = -1000,
                    ["maxvalue"] = 1000,
                },
    ["showclass"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showclass",
                },
    ["showelite"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showelite",
                },
    ["showname"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showname",
                },
    ["showlevel"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showlevel",
                },
    ["castingbar"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "castingbar",
                    },
    ["castingbartimer"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "castingbartimer",
                },               
    ["animatebars"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "animatebars",
                },
    ["reset"] = {
                    ["type"]     = "reset", 
                    ["command"]  = "reset",
                },
    ["barborders"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "barborders",
                },
    ["showauras"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showauras",
                },
    ["showtarget"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showtarget",
                },
    ["showpet"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showpet",
                },
    ["menu"] = {
                    ["type"]     = "menu",
                    ["command"]  = "menu",
                },
    ["btarget"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "btarget",
                },
    ["bplayer"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "bplayer",
                },
    ["shownpc"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "shownpc",
                },
    ["showmmb"] = {
                    ["type"]     = "toggle",
                    ["command"]  = "showmmb",
                }, 
    ["hudspacing"] = {
                    ["type"]     = "range",
                    ["command"]  = "hudspacing",
                    ["minvalue"] = -500,
                    ["maxvalue"] = 500,
                },
    ["targettexty"] = {
                    ["type"]     = "range",
                    ["command"]  = "targettexty",
                    ["minvalue"] = -500,
                    ["maxvalue"] = 500,
                },
    ["playerhptextx"] = {
                    ["type"]     = "range",
                    ["command"]  = "playerhptextx",
                    ["minvalue"] = -300,
                    ["maxvalue"] = 300,
                },
    ["playerhptexty"] = {
                    ["type"]     = "range",
                    ["command"]  = "playerhptexty",
                    ["minvalue"] = -300,
                    ["maxvalue"] = 300,
                },
    ["playermanatextx"] = {
                    ["type"]     = "range",
                    ["command"]  = "playermanatextx",
                    ["minvalue"] = -300,
                    ["maxvalue"] = 300,
                },
    ["playermanatexty"] = {
                    ["type"]     = "range",
                    ["command"]  = "playermanatexty",
                    ["minvalue"] = -300,
                    ["maxvalue"] = 300,
                },
    ["casttimetextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "casttimetextcolor",
                },
    ["castdelaytextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "castdelaytextcolor",
                },
    ["playerhptextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "playerhptextcolor",
                },    
    ["playermanatextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "playermanatextcolor",
                },   
    ["targethptextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "targethptextcolor",
                },          
    ["targetmanatextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "targetmanatextcolor",
                },      
    ["pethptextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "pethptextcolor",
                },       
    ["petmanatextcolor"] = {
                    ["type"]     = "color",
                    ["command"]  = "petmanatextcolor",
                },   
    ["playerhpoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "playerhpoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                },
    ["playermanaoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "playermanaoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                },
    ["targethpoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "targethpoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                },
    ["targetmanaoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "targetmanaoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                },
    ["pethpoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "pethpoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                },
    ["petmanaoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "petmanaoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                },
    ["casttimeoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "casttimeoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                },
    ["castdelayoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "castdelayoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                },
    ["targetoutline"] = {
                    ["type"]     = "range",
                    ["command"]  = "targetoutline",
                    ["minvalue"] = 0,
                    ["maxvalue"] = 2,
                },
}
