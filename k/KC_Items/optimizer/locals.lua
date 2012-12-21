KC_ITEMS_LOCALS.modules.optimizer = {}
local locals = KC_ITEMS_LOCALS.modules.optimizer

if( not ace:LoadTranslation("KC_Optimizer") ) then

locals.name			= "KC_Optimizer"
locals.description	= "Upgrades and imports data."

locals.msg = {}
locals.msg.upgrade = "Upgrading data from version [%s]."
locals.msg.unknown = "unknown"
locals.msg.complete= "Upgrade complete."

-- Chat handler locals
locals.chat = {
	option	= "optimizer",
	desc	= "Functions relating to optimizing the Items Database.",
	args	= {
		{
			option = "import",
			desc   = "Options to import data to the base database.",
			args = {
				{
					option = "master",
					desc   = "Import the master database shipped with KC_Items.",
					method = "ImportMasterDB"
				},
			}
		},
    },  
}

end
