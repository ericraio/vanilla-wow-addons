if not ace:LoadTranslation("RecapFu") then

if not RecapFu then
	local compost = CompostLib:GetInstance('compost-1')
	RecapFu = compost:Acquire()
end

RecapFu.locals = {
	Desc    = "Easy access to Recap info.",
	
	DISABLED = "Disabled",

	BUTTON = {
		LABEL = "DPS:",
		NO_LABEL = " ",
		HINT_TEXT = "Left-click to toggle Recap window",
		PAUSE_TEXT = "Pause Monitoring",
		START_TEXT = "Resume Monitoring",
		SHOWLABEL = "Show Label",
		
		DPS = "Show your DPS",
		DPS_IN = "Show your DPS in",
		DPS_OUT = "Show your DPS out",
		HEALING = "Show Healing",
		OVERHEAL = "Show Overhealing %",
		MAXHIT = "Show Max Hit",
	},
	
	TOOLTIP = {
		STATE = "State: ",
		VIEW_TYPE = "View Type: ",
		
		DPS = "Your DPS: ",
		DPS_IN = "Total DPS In: ",
		DPS_OUT = "Total DPS Out: ",
		HEALING = "Healing: ",
		OVERHEAL = "Overhealing %: ",
		MAXHIT = "Max hit: ",
	},
}

end