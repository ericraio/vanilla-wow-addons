

local L = AceLibrary("AceLocale-2.2"):new("Detox")

L:RegisterTranslations("zhTW", function() return {

	-- menu/options
	["Clean group"] = "淨化團隊",
	["Will attempt to clean a player in your raid/party."] = "嘗試淨化隊伍/團隊中的玩家",
	["Play sound if unit needs decursing"] = "當範圍內出現需要淨化的單位時發出聲音提示",
	["Show detoxing in scrolling combat frame"] = "用SCT方式顯示淨化訊息",
	["This will use SCT5 when available, otherwise Blizzards Floating Combat Text."] = "需要SCT5(ACE2)或開啟遊戲內建的浮動戰鬥文字功能",
	["Seconds to blacklist"] = "加入黑名單的時間",
	["Units that are out of Line of Sight will be blacklisted for the set duration."] = "自一個單位不能被淨化起，在設定的時間內該單位將會被忽略",
	["Max debuffs shown"] = "減益狀態顯示數量",
	["Defines the max number of debuffs to display in the live list."] = "設定在即時面板上顯示減益狀態的最多單位數量",
	["Update speed"] = "減益狀態的更新速度",
	["Defines the speed the live list is updated, in seconds."] = "設定即時列表更新速度(單位：秒)",
	["Detaches the live list from the Detox icon."] = "在螢幕上面顯示減益狀態即時列表.",
	["Show live list"] = "顯示即時列表",
	["Options for the live list."] =  "設定即時列表",
	["Live list"] = "即時列表",	

	-- Filtering
	["Filter"] = "過濾器",
	["Options for filtering various debuffs and conditions."] = "設定各種不同的減益狀態與條件",
	["Debuff"] = "減益狀態",
	["Filter by debuff and class."] = "設定按照職業與減益狀態進行過濾",
	["Classes to filter for: %s."] = "過濾受到 %s 影響的職業",
	["Toggle filtering %s on %s."] = "過濾受到 %s 影響的%s",
	["Adds a new debuff to the class submenus."] = "加入一個新的減益狀態到類別子選單中",
	["Add"] = "加入",
	["Removes a debuff from the class submenus."] = "從類別子選單中移除一個減益狀態",
	["Remove %s from the class submenus."] = "從類別子選單中移除 %s",
	["Remove"] = "移除",
	["<debuff name>"] = "<減益狀態名字>",
	["Filter stealthed units"] = "過濾潛行單位",
	["It is recommended not to cure stealthed units."] = "推薦開啟這個選項以忽略潛行單位",
	["Filter Abolished units"] = "過濾忽略單位",
	["Skip units that have an active Abolish buff."] = "忽略一個含有指定狀態的單位(如強效昏睡)",
	["Filter pets"] = "過濾寵物",
	["Pets are also your friends."] = "寵物也是友方單位",
	["Filter by type"] = "按類型過濾",
	["Only show debuffs you can cure."] = "只顯示你能夠淨化的減益狀態",
	["Filter by range"] = "範圍過濾",
	["Only show units in range."] = "只顯示你施法範圍內的單位",

	-- Priority list
	["Priority"] = "優先設定",
	["These units will be priorized when curing."] = "優先淨化勾選的單位",
	["Show priorities"] = "顯示優先列表",
	["Displays who is prioritized in the live list."] = "在即時列表顯示優先單位",
	["Priorities"] = "優先",
	["Can't add/remove current target to priority list, it doesn't exist."] = "不能從優先列表中添加/移除目前的目標，目標不存在。",
	["Can't add/remove current target to priority list, it's not in your raid."] =  "不能從優先列表中添加/移除目前的目標，因為他不在你的團隊中。",
	["%s was added to the priority list."] = "%s 已被加入優先列表.",
	["%s has been removed from the priority list."] = "%s 已從優先列表中移除.",
	["Nothing"] = "沒有效果",
	["Prioritize %s."] = "優先 %s",
	["Every %s"] = "所有 %s",
	["Prioritize every %s."] = "優先所有 %s",
	["Groups"] = "小隊",
	["Prioritize by group."] = "按照小隊優先",
	["Group %s"] = "小隊 %s",
	["Prioritize group %s."] = "優先小隊 %s",
	["Class %s"] = "%s 職業",

	-- bindings
	["Clean group"] = "淨化隊伍",
	["Toggle target priority"] = "設定目標優先",
	["Toggle target class priority"] = "設定目標職業優先",
	["Toggle target group priority"] = "設定目標小隊優先",

	-- spells and potions
	["Dreamless Sleep"]	= "無夢睡眠",
	["Greater Dreamless Sleep"]	= "強效昏睡",
	["Ancient Hysteria"]	= "上古狂亂",
	["Ignite Mana"]	= "點燃法力",
	["Tainted Mind"]	= "污濁之魂",
	["Magma Shackles"]	= "熔岩鐐銬",
	["Cripple"] = "殘廢術",
	["Frost Trap Aura"] = "冰霜陷阱光環",
	["Dust Cloud"] = "灰塵之雲",
	["Widow's Embrace"] = "黑女巫的擁抱",
	["Curse of Tongues"] = "語言詛咒",
	["Sonic Burst"] = "音爆",
	["Thunderclap"] = "雷霆一擊",
	["Delusions of Jin'do"] = "金度的欺騙",


	["Magic"]	= "魔法",
	["Charm"]	= "誘惑",
	["Curse"]	= "詛咒",
	["Poison"]	= "中毒",
	["Disease"]	= "疾病",
	
	["Cleaned %s"] = "已淨化 %s",
	
	["Rank (%d+)"] = "等級 (%d+)"
	
} end)
