-- Function for each events possible targets
--[[
	PROCEDURE FOR ADDING EVENTS:
	1.  Code to detect and raise event.  If polling a number of items, do by iterating a list of available items.
	2.  Choose what event group (FBEventToggles) it belongs to.  If it needs a new group insert the following info:
		under FBEventToggles[<groupname>] 
		["toggle"] 	= default state
		["desc"]		= Description displayed in Performance frame.  Note the first 4 letters are used to
					   sort, but are not displayed
		["timer"]		= If a timer is used to poll, this is its name, otherwise nil
		["highlist"]	= If a list of items are polled, this is the COMPLETE list of possible items to poll
		["lowlist"]		= {} empty table, this is where the list of only those items we are interested in is kept.
	3.  For each event in the event group insert an entry in FBEventGroups of the form:
		FBEventGroups[<event>] = <groupname>  (from above)
	4.  For each event, insert a function in FBGUIEventTargets that returns a list of potential targets for the
	    event.
		FBGUIEventTargets["event"] = function() end

	NOTE: all table keys are lower case.
--]]
	local util = Utility_Class:New()

	FBEventToggleInfo = {
		["buttoncheck"] = {
			["toggle"] 	= "high",
			["desc"]	= "G01 Mouse enter/leave button",
			["timer"]	= nil,
			["highlist"]	= FBCompleteButtonList,
			["lowlist"]	= {}
			},
		["boundcheck"] 	=	{
			["toggle"] 	= "high",
			["desc"]	= "G01 Mouse enter/leave group",
			["timer"]	= "boundcheck",
			["highlist"]	= nil,
			["lowlist"]	= {}
			},
		["meleecheck"]	=	{
			["toggle"] 	= "high",
			["desc"]	= "G02 Enter/Leave Melee",
			["timer"]	= nil,
			["highlist"]	= {},
			["lowlist"]	= {}
			},
		["aggrocheck"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G02 Gain/Lose Aggro",
			["timer"]	= nil,
			["highlist"]	= {},
			["lowlist"]	= {}
			},
		["affectcombat"]	= {
			["toggle"] 	= "high",
			["desc"]	= "G02 Start/End Combat",
			["timer"]	= "affectcombat",
			["highlist"]	= {["player"] = true, ["party1"] = true, ["party2"] = true, ["party3"] = true, ["party4"] = true, ["pet"] = true, ["target"] = true},
			["lowlist"]	= {}
			},
		["manacheck"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G03 Action Mana",
			["timer"]	= "manacheck",
			["highlist"]	= FBCompleteButtonList,
			["lowlist"]	= {}
			},
		["cooldowncheck"] 	= {
			["toggle"] 	= "high",
			["desc"]	= "G03 Action Cooldown",
			["timer"]	= "cooldowncheck",
			["highlist"]	= FBCompleteButtonList,
			["lowlist"]	= {}
			},
		["rangecheck"] 		= {
			["toggle"] 	= "high",
			["desc"]	= "G03 Action In Range",
			["timer"]	= "rangecheck",
			["highlist"]	= FBCompleteButtonList,
			["lowlist"]	= {}
			},
		["usablecheck"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G03 Action Usable",
			["timer"]	= "usablecheck",
			["highlist"]	= FBCompleteButtonList,
			["lowlist"]	= {}
			},
		["targetcheck"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G04 Gain/Lose/Change Target (and Target's Target)",
			["timer"]	= "targettarget",
			["highlist"]	= nil,
			["lowlist"]	= {}
			},
		["formcheck"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G55 Gain/Lose Aura",
			["timer"]	= nil,
			["highlist"]	= {},
			["lowlist"]	= {}
			},
		["itembuffs"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G56 Gain/Lose ItemBuff",
			["timer"]	= "itembuffs",
			["highlist"]	= {},
			["lowlist"]	= {}
			},
		["buffcheck"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G57 Gain/Lose Buff",
			["timer"]	= nil,
			["highlist"]	= {},
			["lowlist"]	= {}
			},
		["groupcheck"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G06 Gain/Lose Partymate",
			["timer"]	= nil,
			["highlist"]	= {["player"] = true, ["party1"] = true, ["party2"] = true, ["party3"] = true, ["party4"] = true},
			["lowlist"]	= {}
			},
		["petcheck"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G06 Gain/Lose Pet",
			["timer"]	= nil,
			["highlist"]	= {},
			["lowlist"]	= {}
			},
		["deathcheck"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G06 Unit Died/Ressed",
			["timer"]	= "deathcheck",
			["highlist"]	= {["player"] = true, ["party1"] = true, ["party2"] = true, ["party3"] = true, ["party4"] = true, ["pet"] = true },
			["lowlist"]	= {}
			},
		["keycheck"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G07 Modifier Key Up/Down",
			["timer"]	= "keycheck",
			["highlist"]	= {["ShiftKey"] = true, ["ControlKey"] = true, ["AltKey"] = true},
			["lowlist"]	= {}
			},
		["bindingkeyevents"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G07 Binding Key Up/Down",
			["timer"]	= nil,
			["highlist"]	= CompleteBindingList,
			["lowlist"]	= {}
			},
		["buttonevents"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G07 Button Up/Down/Click",
			["timer"]	= nil,
			["highlist"]	= FBCompleteButtonList,
			["lowlist"]	= {}
			},
		["missevents"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G99 Player/Target Miss (obsolete)",
			["timer"]	= nil,
			["highlist"]	= {},
			["lowlist"]	= {}
			},
		["combatevents"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G10 Unit Combat",
			["timer"]	= nil,
			["highlist"]	= {["player"] = true, ["party1"] = true, ["party2"] = true, ["party3"] = true, ["party4"] = true, ["pet"] = true, ["target"] = true},
			["lowlist"]	= {}
			},
		["healthevents"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G08 Health Above/Below ##",
			["timer"]	= nil,
			["highlist"]	= {["player"] = true, ["party1"] = true, ["party2"] = true, ["party3"] = true, ["party4"] = true, ["pet"] = true, ["target"] = true},
			["lowlist"]	= {}
			},
		["manaevents"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G08 Mana Above/Below ##",
			["timer"]	= nil,
			["highlist"]	= {["player"] = true, ["party1"] = true, ["party2"] = true, ["party3"] = true, ["party4"] = true, ["pet"] = true, ["target"] = true},
			["lowlist"]	= {}
			},
		["comboevents"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G08 Combo Points",
			["timer"]	= nil,
			["highlist"]	= {},
			["lowlist"]	= {}
			},
		["actionbarpage"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G98 Action Bar Page",
			["timer"]	= nil,
			["highlist"]	= {},
			["lowlist"]	= {}
			},
		["autoitems"]		= {
			["toggle"] 	= "high",
			["desc"]	= "G97 Auto Item events",
			["timer"]	= nil,
			["highlist"]	= {},
			["lowlist"]	= {}
			},
		["trackinglist"]	= {
			["toggle"] = "high",
			["desc"]	= "G08 Tracking events",
			["timer"]	= nil,
			["highlist"]	= FBCompleteTrackingList,
			["lowlist"]	= {}
			},	
		["none"]		= {
			["toggle"] 	= "high",
			["desc"]	= "XXX",
			["timer"]	= nil,
			["highlist"]	= {},
			["lowlist"]	= {}
			},
			
			
	}
	
	FBEventGroups = {
		["mouseentergroup"]	=	"boundcheck",
		["mouseleavegroup"]	=	"boundcheck",
		["mouseenterbutton"]	=	"buttoncheck",
		["mouseleavebutton"]	=	"buttoncheck",
		["entercombat"]		=	"meleecheck",
		["leavecombat"]		=	"meleecheck",
		["gainaggro"]		=	"aggrocheck",
		["loseaggro"]		=	"aggrocheck",
		["startcombat"]		=	"affectcombat",
		["endcombat"]		=	"affectcombat",
		["cooldownmet"]		=	"cooldowncheck",
		["cooldownstart"]	=	"cooldowncheck",
		["enoughmana"]		=	"manacheck",
		["notenoughmana"]	=	"manacheck",
		["nowinrange"]		=	"rangecheck",
		["outofrange"]		=	"rangecheck",
		["notusable"]		=	"usablecheck",
		["isusable"]		=	"usablecheck",
		["gainbuff"]		=	"buffcheck",
		["losebuff"]		=	"buffcheck",
		["gaindebuff"]		=	"buffcheck",
		["losedebuff"]		=	"buffcheck",
		["gaindebufftype"]	=	"buffcheck",
		["losedebufftype"]	=	"buffcheck",
		["gainaura"]		=	"formcheck",
		["loseaura"]		=	"formcheck",
		["healthabove10"]	=	"healthevents",
		["healthabove20"]	=	"healthevents",
		["healthabove30"]	=	"healthevents",
		["healthabove40"]	=	"healthevents",
		["healthabove50"]	=	"healthevents",
		["healthabove60"]	=	"healthevents",
		["healthabove70"]	=	"healthevents",
		["healthabove80"]	=	"healthevents",
		["healthabove90"]	=	"healthevents",
		["healthbelow10"]	=	"healthevents",
		["healthbelow20"]	=	"healthevents",
		["healthbelow30"]	=	"healthevents",
		["healthbelow40"]	=	"healthevents",
		["healthbelow50"]	=	"healthevents",
		["healthbelow60"]	=	"healthevents",
		["healthbelow70"]	=	"healthevents",
		["healthbelow80"]	=	"healthevents",
		["healthbelow90"]	=	"healthevents",
		["healthbelow100"]	=	"healthevents",
		["healthfull"]		=	"healthevents",
		["combopoints"]		=	"comboevents",
		["manaabove10"]		=	"manaevents",
		["manaabove20"]		=	"manaevents",
		["manaabove30"]		=	"manaevents",
		["manaabove40"]		=	"manaevents",
		["manaabove50"]		=	"manaevents",
		["manaabove60"]		=	"manaevents",
		["manaabove70"]		=	"manaevents",
		["manaabove80"]		=	"manaevents",
		["manaabove90"]		=	"manaevents",
		["manabelow10"]		=	"manaevents",
		["manabelow20"]		=	"manaevents",
		["manabelow30"]		=	"manaevents",
		["manabelow40"]		=	"manaevents",
		["manabelow50"]		=	"manaevents",
		["manabelow60"]		=	"manaevents",
		["manabelow70"]		=	"manaevents",
		["manabelow80"]		=	"manaevents",
		["manabelow90"]		=	"manaevents",
		["manabelow100"]	=	"manaevents",
		["manafull"] 		=	"manaevents",
		["losttarget"]		=	"targetcheck",
		["gaintarget"]		=	"targetcheck",
		["targetgaintarget"]=	"targetcheck",
		["targetlosttarget"]=	"targetcheck",
		["targetchangedtarget"]="targetcheck",
		["gainpartymate"]	=	"groupcheck",
		["losepartymate"]	=	"groupcheck",
		["gainpet"]			=	"petcheck",
		["losepet"]			=	"petcheck",
		["petsummoned"]		=	"petcheck",
		["petdismissed"]	=	"petcheck",
		["unitdied"]		=	"deathcheck",
		["unitressed"]		=	"deathcheck",
		["actionbarpage"]	=	"actionbarpage",
		["rightbuttonclick"]=	"buttonevents",
		["leftbuttonclick"]	=	"buttonevents",
		["rightbuttonup"]	=	"buttonevents",
		["leftbuttonup"]	=	"buttonevents",
		["rightbuttondown"]	=	"buttonevents",
		["leftbuttondown"]	=	"buttonevents",
		["bindingkeyup"]	=	"bindingkeyevents",
		["bindingkeydown"]	=	"bindingkeyevents",
		["shiftkeyup"]		=	"keycheck",
		["shiftkeydown"]	=	"keycheck",
		["controlkeyup"]	=	"keycheck",
		["controlkeydown"]	=	"keycheck",
		["altkeyup"]		=	"keycheck",
		["altkeydown"]		=	"keycheck",
		["profileloaded"]	=	"none",
		["targetmiss"]		=	"missevents",
		["playermiss"]		=	"missevents",
		["autoitemout"]		=	"autoitems",
		["autoitemrestored"]=	"autoitems",
		["unitbuff"] 		=	"buffcheck",
		["unitdebuff"]		=	"buffcheck",
		["unitdebufftype"]	=	"buffcheck",
		["playercombat"]	=	"combatevents",
		["targetcombat"]	=	"combatevents",
		["gainitembuff"]	= 	"itembuffs",
		["loseitembuff"]	=	"itembuffs",
		["mainhandcharges"] =	"itembuffs",
		["offhandcharges"]	=	"itembuffs",
		["trackingchanged"]	= "trackinglist",
	}		
	
	FBGUIEventTargets = {}
	FBGUIEventTargets["mouseentergroup"]	=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBGroupData) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["mouseleavegroup"]	=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBGroupData) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["mouseenterbutton"]	=	
		function()
			return FBCompleteButtonList
		end
	FBGUIEventTargets["mouseleavebutton"]	=
		function()
			return FBCompleteButtonList
		end
	FBGUIEventTargets["entercombat"]		=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["leavecombat"]		=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["gainaggro"]			=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["loseaggro"]			=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["startcombat"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["endcombat"]			=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["cooldownmet"]		=	
		function()
			return FBCompleteIDList
		end
	FBGUIEventTargets["cooldownstart"]		=	
		function()
			return FBCompleteIDList
		end
	FBGUIEventTargets["enoughmana"]			=	
		function()
			return FBCompleteIDList
		end
	FBGUIEventTargets["notenoughmana"]		=	
		function()
			return FBCompleteIDList
		end
	FBGUIEventTargets["nowinrange"]			=	
		function()
			return FBCompleteIDList
		end
	FBGUIEventTargets["outofrange"]			=	
		function()
			return FBCompleteIDList
		end
	FBGUIEventTargets["notusable"]			=	
		function()
			return FBCompleteIDList
		end
	FBGUIEventTargets["isusable"]			=	
		function()
			return FBCompleteIDList
		end
	FBGUIEventTargets["gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["gainaura"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["auras"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["loseaura"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["auras"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["healthabove10"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthabove20"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthabove30"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthabove40"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthabove50"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthabove60"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthabove70"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthabove80"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthabove90"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthbelow10"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthbelow20"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthbelow30"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthbelow40"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthbelow50"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthbelow60"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthbelow70"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthbelow80"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthbelow90"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthbelow100"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["healthfull"]			=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["combopoints"]		=	
		function()
			return FBComboPointsList
		end
	FBGUIEventTargets["manaabove10"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manaabove20"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manaabove30"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manaabove40"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manaabove50"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manaabove60"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manaabove70"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manaabove80"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manaabove90"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manabelow10"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manabelow20"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manabelow30"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manabelow40"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manabelow50"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manabelow60"]		=
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manabelow70"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manabelow80"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manabelow90"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manabelow100"]		=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["manafull"] 			=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["losttarget"]			=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["gaintarget"]			=	
		function()
			return FBCompleteReactionList
		end
	FBGUIEventTargets["targetgaintarget"]			=	
		function()
			return FBCompleteTargetTargetList
		end
	FBGUIEventTargets["targetlosttarget"]			=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["targetchangedtarget"]			=	
		function()
			return FBCompleteTargetTargetList
		end
	FBGUIEventTargets["gainpartymate"]			=	
		function()
			return FBCompletePartyList
		end
	FBGUIEventTargets["losepartymate"]		=	
		function()
			return FBCompletePartyList
		end
	FBGUIEventTargets["gainpet"]			=	
		function()
			return FBPetTypes
		end
	FBGUIEventTargets["losepet"]			=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["petsummoned"]			=	
		function()
			return FBCompletePetList
		end
	FBGUIEventTargets["petdismissed"]			=	
		function()
			return FBCompletePetList
		end
	FBGUIEventTargets["unitdied"]			=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["unitressed"]			=	
		function()
			return FBGUIUnitList
		end
	FBGUIEventTargets["actionbarpage"]		=	
		function()
			return FBCompletePageList
		end
	FBGUIEventTargets["rightbuttonclick"]	=	
		function()
			return FBCompleteButtonList
		end
	FBGUIEventTargets["leftbuttonclick"]	=	
		function()
			return FBCompleteButtonList
		end
	FBGUIEventTargets["rightbuttonup"]		=	
		function()
			return FBCompleteButtonList
		end
	FBGUIEventTargets["leftbuttonup"]		=	
		function()
			return FBCompleteButtonList
		end
	FBGUIEventTargets["rightbuttondown"]	=	
		function()
			return FBCompleteButtonList
		end
	FBGUIEventTargets["leftbuttondown"]		=	
		function()
			return FBCompleteButtonList
		end
	FBGUIEventTargets["bindingkeyup"]		=	
		function()
			return FBCompleteBindingList
		end
	FBGUIEventTargets["bindingkeydown"]		=	
		function()
			return FBCompleteBindingList
		end
	FBGUIEventTargets["shiftkeyup"]			=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["shiftkeydown"]		=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["controlkeyup"]		=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["controlkeydown"]		=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["altkeyup"]			=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["altkeydown"]			=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["profileloaded"]		=	
		function()
			return FBNoTargetsList
		end
	FBGUIEventTargets["targetmiss"]			=	
		function()
			return FBCompleteMissList
		end
	FBGUIEventTargets["playermiss"]			=	
		function()
			return FBCompleteMissList
		end
	FBGUIEventTargets["autoitemout"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBSavedProfile[FBProfileName].FlexActions) do
				table.insert(returnvalue,v["name"])
			end
			return returnvalue
		end
	FBGUIEventTargets["autoitemrestored"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBSavedProfile[FBProfileName].FlexActions) do
				table.insert(returnvalue,v["name"])
			end
			return returnvalue
		end
	FBGUIEventTargets["playercombat"]			=	
		function()
			local returnvalue = {}
			local i,v
			for i,v in pairs(FBCombatTypes) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["targetcombat"]			=	
		function()
			local returnvalue = {}
			local i,v
			for i,v in pairs(FBCombatTypes) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["unitbuff"]			=	
		function()
			return FBGUIUnitBuffList
		end
	FBGUIEventTargets["unitdebuff"]			=	
		function()
			return FBGUIUnitBuffList
		end
	FBGUIEventTargets["unitdebufftype"]			=	
		function()
			return FBGUIUnitBuffList
		end
	FBGUIEventTargets["gainitembuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["itembuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["loseitembuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["itembuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["mainhandcharges"]			=	
		function()
			return FBNoValuesList
		end
	FBGUIEventTargets["offhandcharges"]			=	
		function()
			return FBNoValuesList
		end
	FBGUIEventTargets["petgainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["petlosebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["petgaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["petlosedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["petgaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["petlosedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["targetgainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["targetlosebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["targetgaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["targetlosedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["targetgaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["targetlosedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end

	FBGUIEventTargets["trackingchanged"]			=	
		function()
			return FBCompleteTrackingList
		end			
	FBGUIEventTargets["party1gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party1losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party1gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party1losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party1gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party1losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["partypet1gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet1losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet1gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet1losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet1gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet1losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["party2gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party2losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party2gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party2losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party2gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party2losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["partypet2gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet2losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet2gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet2losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet2gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet2losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["party3gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party3losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party3gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party3losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party3gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party3losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["partypet3gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet3losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet3gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet3losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet3gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet3losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["party4gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party4losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party4gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party4losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party4gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["party4losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["partypet4gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet4losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet4gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet4losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet4gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["partypet4losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid1gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid1losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid1gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid1losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid1gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid1losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet1gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet1losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet1gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet1losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet1gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet1losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid2gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid2losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid2gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid2losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid2gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid2losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet2gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet2losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet2gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet2losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet2gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet2losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid3gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid3losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid3gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid3losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid3gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid3losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet3gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet3losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet3gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet3losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet3gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet3losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid4gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid4losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid4gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid4losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid4gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid4losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet4gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet4losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet4gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet4losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet4gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet4losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid5gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid5losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid5gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid5losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid5gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid5losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet5gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet5losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet5gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet5losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet5gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet5losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid6gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid6losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid6gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid6losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid6gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid6losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet6gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet6losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet6gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet6losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet6gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet6losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid7gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid7losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid7gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid7losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid7gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid7losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet7gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet7losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet7gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet7losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet7gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet7losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid8gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid8losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid8gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid8losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid8gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid8losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet8gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet8losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet8gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet8losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet8gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet8losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid9gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid9losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid9gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid9losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid9gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid9losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet9gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet9losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet9gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet9losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet9gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet9losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid10gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid10losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid10gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid10losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid10gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid10losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet10gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet10losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet10gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet10losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet10gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet10losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid11gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid11losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid11gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid11losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid11gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid11losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet11gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet11losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet11gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet11losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet11gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet11losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid12gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid12losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid12gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid12losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid12gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid12losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet12gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet12losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet12gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet12losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet12gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet12losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid13gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid13losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid13gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid13losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid13gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid13losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet13gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet13losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet13gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet13losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet13gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet13losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid14gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid14losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid14gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid14losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid14gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid14losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet14gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet14losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet14gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet14losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet14gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet14losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid15gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid15losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid15gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid15losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid15gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid15losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet15gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet15losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet15gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet15losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet15gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet15losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid16gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid16losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid16gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid16losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid16gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid16losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet16gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet16losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet16gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet16losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet16gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet16losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid17gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid17losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid17gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid17losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid17gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid17losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet17gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet17losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet17gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet17losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet17gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet17losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid18gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid18losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid18gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid18losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid18gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid18losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet18gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet18losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet18gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet18losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet18gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet18losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid19gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid19losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid19gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid19losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid19gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid19losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet19gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet19losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet19gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet19losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet19gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet19losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid20gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid20losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid20gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid20losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid20gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid20losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet20gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet20losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet20gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet20losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet20gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet20losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid21gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid21losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid21gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid21losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid21gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid21losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet21gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet21losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet21gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet21losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet21gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet21losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid22gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid22losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid22gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid22losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid22gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid22losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet22gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet22losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet22gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet22losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet22gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet22losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid23gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid23losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid23gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid23losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid23gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid23losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet23gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet23losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet23gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet23losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet23gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet23losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid24gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid24losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid24gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid24losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid24gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid24losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet24gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet24losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet24gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet24losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet24gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet24losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid25gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid25losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid25gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid25losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid25gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid25losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet25gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet25losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet25gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet25losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet25gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet25losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid26gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid26losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid26gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid26losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid26gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid26losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet26gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet26losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet26gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet26losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet26gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet26losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid27gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid27losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid27gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid27losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid27gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid27losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet27gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet27losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet27gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet27losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet27gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet27losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid28gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid28losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid28gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid28losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid28gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid28losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet28gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet28losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet28gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet28losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet28gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet28losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid29gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid29losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid29gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid29losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid29gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid29losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet29gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet29losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet29gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet29losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet29gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet29losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid30gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid30losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid30gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid30losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid30gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid30losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet30gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet30losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet30gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet30losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet30gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet30losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid31gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid31losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid31gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid31losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid31gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid31losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet31gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet31losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet31gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet31losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet31gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet31losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid32gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid32losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid32gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid32losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid32gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid32losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet32gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet32losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet32gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet32losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet32gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet32losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid33gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid33losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid33gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid33losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid33gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid33losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet33gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet33losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet33gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet33losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet33gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet33losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid34gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid34losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid34gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid34losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid34gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid34losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet34gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet34losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet34gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet34losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet34gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet34losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid35gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid35losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid35gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid35losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid35gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid35losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet35gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet35losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet35gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet35losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet35gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet35losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid36gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid36losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid36gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid36losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid36gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid36losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet36gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet36losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet36gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet36losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet36gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet36losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid37gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid37losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid37gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid37losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid37gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid37losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet37gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet37losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet37gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet37losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet37gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet37losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid38gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid38losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid38gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid38losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid38gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid38losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet38gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet38losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet38gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet38losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet38gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet38losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid39gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid39losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid39gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid39losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid39gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid39losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet39gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet39losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet39gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet39losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet39gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet39losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raid40gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid40losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid40gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid40losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid40gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raid40losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end	FBGUIEventTargets["raidpet40gainbuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet40losebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["buffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet40gaindebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet40losedebuff"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debuffs"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet40gaindebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end
	FBGUIEventTargets["raidpet40losedebufftype"]			=	
		function()
			local i,v
			local returnvalue = {}
			for i,v in pairs(FBBuffs["debufftypes"]) do
				table.insert(returnvalue,i)
			end
			return returnvalue
		end