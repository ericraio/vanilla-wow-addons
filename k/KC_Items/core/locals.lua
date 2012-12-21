KC_ITEMS_LOCALS = {}

local locals = KC_ITEMS_LOCALS

if( not ace:LoadTranslation("KC_Items") ) then

locals.modules = {}

locals.name			= "KC_Items"

locals.msg = {}
locals.msg.color	= "|cff0099CC"
locals.msg.nowSetTo	= "now set to"
locals.msg.default	= "default"
locals.msg.display	= "[|cfff5f530%s|cff0099CC]"
locals.msg.statsframe = "Display of the stats frame is"

locals.err = {}
locals.err.modEnable	= "Cannot enable %s. Dependencies are missing or disabled."
locals.err.needs		= "%s needs the following modules: %s"

locals.rpt = {}
locals.rpt.noModules	= "----- No Modules Installed -----"
locals.rpt.header		= "-- -- -- Installed Modules -- -- --"

locals.maps = {}
locals.maps.onOff		= {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"}
locals.maps.enabled		= {[0]="|cffff5050Disabled|r",[1]="|cff00ff00Enabled|r"}

-- Chat handler locals
locals.chat = {}
locals.chat.commands	= {"/kci", "/kc_items", "/kcitems"}
locals.chat.options	= {
	 {
		option = "core",
        desc   = "Core functionality related commands.",
		args = {
			{
				option = "showstats",
				desc   = "Toggles display of stats frame.",
				method = "ShowStatsFrame"
			},
		},
    },
}

locals.chat.toggle = {
	option = "toggle",
	desc   = "Toggles this module on or off.",
	method = "Toggle"
}

end
