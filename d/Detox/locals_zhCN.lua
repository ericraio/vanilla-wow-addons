

local L = AceLibrary("AceLocale-2.0"):new("Detox")

L:RegisterTranslations("zhCN", function() return {

	-- menu/options
	["Clean group"] = "净化团队",
	["Will attempt to clean a player in your raid/party."] = "尝试净化队伍/团队中的玩家.",
	["Play sound if unit needs decursing"] = "当范围内出现需要净化的单位时发出声音提示",
	["Show detoxing in scrolling combat frame"] = "用SCT方式显示净化信息",
	["This will use SCT5 when available, otherwise Blizzards Floating Combat Text."] = "需要SCT5(ACE2)或开启游戏内置战斗状态文字支持.",
	["Seconds to blacklist"] = "加入到黑名单的时间",
	["Units that are out of Line of Sight will be blacklisted for the set duration."] = "当一个单位不能被净化时候将会在设定的时间内被加入黑名单.",
	["Max debuffs shown"] = "不良状态显示数量",
	["Defines the max number of debuffs to display in the live list."] = "设置在实时面板上最多显示几个单位的不良状态.",
	["Update speed"] = "不良状态显示刷新速度",
	["Defines the speed the live list is updated, in seconds."] = "设置实时列表更新速度,单位秒.",
	["Detaches the live list from the Detox icon."] = "在屏幕上面显示不良状态实时列表.",
	["Show live list"] = "显示实时列表",
	["Options for the live list."] =  "实时列表设置",
	["Live list"] = "实时列表",	

	-- Filtering
	["Filter"] = "过滤器",
	["Options for filtering various debuffs and conditions."] = "设置各种不同的debuff跟不良状态",
	["Debuff"] = "不良状态过滤",
	["Filter by debuff and class."] = "设置按照职业与不良状态进行过滤",
	["Classes to filter for: %s."] = "过滤受到 %s 影响的职业",
	["Toggle filtering %s on %s."] = "过滤受到 %s 影响的%s",
	["Adds a new debuff to the class submenus."] = "加入一个新的debuff到不良状态可选列表",
	["Add"] = "加入",
	["Removes a debuff from the class submenus."] = "从不良状态可选列表中移除一个debuff",
	["Remove %s from the class submenus."] = "从不良状态可选列表中移除 %s",
	["Remove"] = "移除",
	["<debuff name>"] = "<不良状态名字>",
	["Filter stealthed units"] = "过滤潜行单位",
	["It is recommended not to cure stealthed units."] = "推荐开启这个选项以忽略潜行单位.",
	["Filter Abolished units"] = "过滤忽略单位",
	["Skip units that have an active Abolish buff."] = "忽略一个含有指定状态的单位(如强效昏睡).",
	["Filter pets"] = "过滤宠物",
	["Pets are also your friends."] = "宠物是人类的朋友",
	["Filter by type"] = "按类型过滤",
	["Only show debuffs you can cure."] = "只显示你能够净化的不良状态.",
	["Filter by range"] = "范围过滤",
	["Only show units in range."] = "只显示你施法范围内的单位.",

	-- Priority list
	["Priority"] = "优先设置",
	["These units will be priorized when curing."] = "优先净化勾选的单位",
	["Show priorities"] = "显示优先列表",
	["Displays who is prioritized in the live list."] = "在实时列表显示优先单位",
	["Priorities"] = "优先",
	["Can't add/remove current target to priority list, it doesn't exist."] = "不能从优先列表中添加/移除当前目标，因为其不存在.",
	["Can't add/remove current target to priority list, it's not in your raid."] =  "不能从优先列表中添加/移除当前目标，因为他不在你的团队中.",
	["%s was added to the priority list."] = "%s 被加入优先列表.",
	["%s has been removed from the priority list."] = "%s 已从优先列表中移除.",
	["Nothing"] = "没有效果",
	["Prioritize %s."] = "优先 %s",
	["Every %s"] = "所有 %s",
	["Prioritize every %s."] = "优先所有 %s",
	["Groups"] = "小队",
	["Prioritize by group."] = "按照小队优先",
	["Group %s"] = "小队 %s",
	["Prioritize group %s."] = "优先小队 %s",
	["Class %s"] = "%s 职业",

	-- bindings
	["Clean group"] = "净化队伍",
	["Toggle target priority"] = "设置目标优先",
	["Toggle target class priority"] = "设置目标职业优先",
	["Toggle target group priority"] = "设置目标小队优先",

	-- spells and potions
	["Dreamless Sleep"]	= "无梦睡眠",
	["Greater Dreamless Sleep"]	= "强效昏睡",
	["Ancient Hysteria"]	= "上古狂乱",
	["Ignite Mana"]	= "点燃法力",
	["Tainted Mind"]	= "污浊之魂",
	["Magma Shackles"]	= "熔岩镣铐",
	["Cripple"] = "残废术",
	["Frost Trap Aura"] = "冰霜陷阱光环",
	["Dust Cloud"] = "灰尘之云",
	["Widow's Embrace"] = "黑女巫的拥抱",
	["Curse of Tongues"] = "语言诅咒",

	["Magic"]	= "魔法",
	["Charm"]	= "魅惑",
	["Curse"]	= "诅咒",
	["Poison"]	= "中毒",
	["Disease"]	= "疾病",
	
	["Cleaned %s"] = "已净化 %s",
	
	["Rank (%d+)"] = "等级 (%d+)"
	
} end)