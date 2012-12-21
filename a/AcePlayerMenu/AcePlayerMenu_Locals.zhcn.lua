function AcePlayerMenu_Locals_zhCN()

AcePlayerMenuLocals = {
	NAME = "AcePlayerMenu",
	DESCRIPTION = "在好友列表、工会成员列表、聊天玩家名称增加额外的菜单选项.",
	COMMANDS = {"/aceplayermenu", "/apm"},
	CMD_OPTIONS = {
		{
			option  = "toggle",
			desc	= "启用或禁用AcePlayerMenu",
			method	= "Toggle",
		},
		{
			option  = "left",
			desc	= "启用或禁用聊天窗口中左键点击人名开启菜单功能",
			method	= "Left",
		},
	},
	TEXT = {
		GUILD_INVITE = "公会邀请",
		GET_NAME = "获取姓名",
	},
	MSG = {
		APM_ON = "AcePlayerMenu 启用.",
		APM_OFF = "AcePlayerMenu 禁用.",
		LEFT_ON = "左键菜单启用.",
		LEFT_OFF = "左键菜单禁用.",
	},
}
end