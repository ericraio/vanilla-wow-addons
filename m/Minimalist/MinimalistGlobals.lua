Minimalist_Defaults = {
  QUESTLEVEL = TRUE,
  IGNOREDUELS = FALSE,
  GRYPH = TRUE,
  PVPPERCENT = TRUE,
  AUTOREPAIR = TRUE,
  AUTOSELL = FALSE,
  REPUTATION = TRUE,
  AUTOREZ = TRUE,
  SMARTTAXI = TRUE,
  CHATARROWS = TRUE,
  CHATBUTTONS = FALSE,
  CHATEDIT = FALSE,
  CHATSCROLL = FALSE,
  CHATTIME = FALSE,
  CHATCLEAN = FALSE,
  MAPHIDE = FALSE,
  MAPLOC = FALSE,
  MAPSCROLL = FALSE,
  GOSSIPSKIP = TRUE,
}

Minimalist_Gossip_Show = false
Minimalist_Merchant_Show = false
Minimalist_Chat_Parse = false

--change this if you want autorepair costs to be displayed elsewhere
Minimalist_ChatFrame = DEFAULT_CHAT_FRAME

--checkbuttons for the GUI config window
Minimalist_CheckButtons = {
["Auto-Ignore Duels"] = {
  index = 2,
  tooltipText = "Auto-Ignore Duel Requests (a.k.a. CGF Shield)",
  var = "IGNOREDUELS",
  func = function(switch)
    if (switch) then
      Minimalist:RegisterEvent("DUEL_REQUESTED", "MinAutoDuel")
    else
      Minimalist:UnregisterEvent("DUEL_REQUESTED")
    end
  end
},
["Auto-Repair"] = {
  index = 3,
  tooltipText = "Repair All Equipment and Inventory Automagically",
  var = "AUTOREPAIR",
  func = function(switch)
    if (switch) then
      Minimalist:MHOn()
    else
      Minimalist:MHOff()
    end
  end
},
["Auto-Resurrect"] = {
  index = 4,
  tooltipText = "Automatically Accept Resurrection Requests",
  var = "AUTOREZ",
  func = function(switch)
    if (switch) then
      Minimalist:RegisterEvent("RESURRECT_REQUEST", "MinAutoRez")
    else
      Minimalist:UnregisterEvent("RESURRECT_REQUEST")
    end
  end
},
["Auto-Sell Grey Items"] = {
  index = 5,
  tooltipText = "Sell Grey (Junk) Items in Your Bags Automatically",
  var = "AUTOSELL",
  func = function(switch)
    if (switch) then
     Minimalist:MHOn() 
    else
     Minimalist:MHOff()
    end
  end
},
["Better Reputation"] = {
  index = 6,
  tooltipText = "Display Reputation Amounts Numerically and Detailed Information in the Chat Frame",
  var = "REPUTATION",
  func = function(switch)
    if (switch) then
      Minimalist:MinRepOn()
    else
      Minimalist:MinRepOff()
    end
  end
},
["Disable Gryphons"] = {
  index = 7,
  tooltipText = "Toggle Display of Gryphons on Main Toolbar",
  var = "GRYPH",
  func = function(switch)
    if (switch) then
      Minimalist:GryphOn()
    else
      Minimalist:GryphOff()
    end
  end
},
["Display Quest Levels"] = {
  index = 8,
  tooltipText = "Display Numeric Quest Level in the Quest Frame, Quest Completion Frame, and NPC Quest Window",
  var = "QUESTLEVEL",
  func = function(switch)
    if (switch) then
      Minimalist:MinQLOn()
    else
      Minimalist:MinQLOff()
    end
  end
},
["Honor Progress Percent"] = {
  index = 10,
  tooltipText = "Show Honor Progress as a Percent on Honor Tab",
  var = "PVPPERCENT",
  func = function(switch)
    if (switch) then
      Minimalist:Hook("HonorFrame_Update", "MinHonorFrame_Update")
      HonorFrame_Update()
    else
      Minimalist:Unhook("HonorFrame_Update")
      HonorFrame_Update()
    end
  end
},
["Smart Taxi"] = {
  index = 12,
  tooltipText = "Auto-Dismounts You at Flightmasters",
  var = "SMARTTAXI",
  func = function(switch)
    if (switch) then
      Minimalist:SmartTaxiOn()
    else
      Minimalist:SmartTaxiOff()
    end 
  end
},
["Fix Arrow Keys"] = {
  index = 13,
  tooltipText = "Make Arrow Keys Move the Cursor in the Input Box",
  var = "CHATARROWS",
  func = function(switch)
    if (switch) then
      Minimalist:ChatArrowsOn()
    else
      Minimalist:ChatArrowsOff()
    end
  end
},
["Hide Buttons"] = {
  index = 14,
  tooltipText = "Hide the Chat Frame Buttons, Good to Use in Conjunction with Mouse Scrolling",
  var = "CHATBUTTONS",
  func = function(switch)
    if (switch) then
      Minimalist:ChatButtonsOff()
    else
      Minimalist:ChatButtonsOn()
    end
  end
},
["Move Input Box"] = {
  index = 15,
  tooltipText = "Move the Input Box to the Top of the Chat Frame",
  var = "CHATEDIT",
  func = function(switch)
    if (switch) then
      Minimalist:ChatMoveEditBox()
    else
      Minimalist:ChatRestoreEditBox()
    end
  end
},
["Mouse Scrolling"] = {
  index = 16,
  tooltipText = "Scroll Chat Frame with the Mouse Wheel, Shift-Scroll to Hit the Top/Bottom",
  var = "CHATSCROLL",
  func = function(switch)
    if (switch) then
      Minimalist:ChatScrollOn()
    else
      Minimalist:ChatScrollOff()
    end
  end
},
["Time Stamps"] = {
  index = 17,
  tooltipText = "Add Time Stamps to Chat Messages",
  var = "CHATTIME",
  func = function(switch)
    if (switch) then
      Minimalist:ChatParseOn()
    else
      Minimalist:ChatParseOff()
    end
  end
},
["Hide Clutter"] = {
  index = 18,
  tooltipText = "Hide clock, scroll buttons, location frame. Best used in conjunction with MouseWheel scrolling.",
  var = "MAPHIDE",
  func = function(switch)
    if (switch) then
      Minimalist:MinMapHide()
    else
      Minimalist:MinMapShow()
    end
  end
},
["Location X,Y"] = {
  index = 19,
  tooltipText = "Adds Numeric X,Y Coordinates to the MiniMap.",
  var = "MAPLOC",
  func = function(switch)
    if (switch) then
      Minimalist:MapLocOn()
    else
      Minimalist:MapLocOff()
    end
  end
},
["MouseWheel Zoom"] = {
  index = 20,
  tooltipText = "Enables MouseWheel to Zoom the Minimap When Over It.",
  var = "MAPSCROLL",
  func = function(switch)
    if (switch) then
      Minimalist:MapScrollOn()
    else
      Minimalist:MapScrollOff()
    end
  end
},
["Auto-Skip Useless Gossips"] = {
  index = 21,
  tooltipText = "Skip MC/BWL, Flightmaster, Banker, and Battlemaster Gossip. Disable to complete seasonal quests.",
  var = "GOSSIPSKIP",
  func = function(switch)
    if (switch) then
     Minimalist:GHOn() 
    else
     Minimalist:GHOff()
    end
  end
},
["Reduce Chat Clutter"] = {
  index = 22,
  tooltipText = "Shorten Channel Names to Reduce Chat Window Clutter",
  var = "CHATCLEAN",
  func = function(switch)
    if (switch) then
     Minimalist:ChatParseOn() 
    else
     Minimalist:ChatParseOff()
    end
  end
},
}

--add items here if you want to keep a grey item
Minimalist_AutoSell_Blacklist = {
-- darkmoon faire turnins
"Small Furry Paw",
"Torn Bear Pelt", 
"Soft Bushy Tail",
"Vibrant Plume", 
"Evil Bat Eye",
"Glowing Scorpid Blood",
-- AV un-sellable junk
"Broken I.W.I.N. Button",
"Document from Boomstick Imports",
"Nubless Pacifier",
}
