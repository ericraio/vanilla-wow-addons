assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("oRAOPlayerTarget")
local roster = AceLibrary("RosterLib-2.0")
local paintchips = AceLibrary("PaintChips-2.0")
local tablet = AceLibrary("Tablet-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["playertargetoptional"] = true,
	["pt"] = true,
	["Player"] = true,
	["PlayerTarget"] = true,
	["Optional/PlayerTarget"] = true,
	["Options for the playertargets."] = true,
	["Targettarget"] = true,
	["Toggle TargetTarget frames."] = true,
	["Scale"] = true,
	["Set frame scale."] = true,
	["Alpha"] = true,
	["Set frame alpha."] = true,
	["Raidicon"] = true,
	["Toggle raid icons."] = true,
	["Frames"] = true,
	["Options for the playertarget frames."] = true,
	["Growup"] = true,
	["Toggle growup."] = true,
	["Inverse"] = true,
	["Toggle inverse healthbar."] = true,
	["Deficit"] = true,
	["Toggle deficit health."] = true,
	["Clickcast"] = true,
	["Toggle clickcast support."] = true,
	["Clicktarget"] = true,
	["Define clicktargets."] = true,
	["Define the clicktarget for player."] = true,
	["Define the clicktarget for target."] = true,
	["Define the clicktarget for targettarget."] = true,
	["Target"] = true,
	["TargetTarget"] = true,
	["Nr of Players shown."] = true,
	["Nr Players"] = true,
	["Nr"] = true,
	["Classcolor"] = true,
	["Color healthbars by class."] = true,
	["Enemycolor"] = true,
	["Set the color for enemies. (used when classcolor is enabled)"] = true,
	["Coloraggro"] = true,
	["Color Aggro"] = true,
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = true,
	["Backdrop"] = true,
	["Toggle the backdrop."] = true,
	["Highlight"] = true,
	["Toggle highlighting your target."] = true,
	["Reverse"] = true,
	["Toggle reverse order PT|PTT|PTTT or PTTT|PTT|PT."] = true,
	["Numbers"] = true,
	["Toggle showing of PT numbers."] = true,
	["Tooltips"] = true,
	["Toggle showing of tooltips."] = true,
	["Show"] = true,
	["Show player."] = true,
	["Show target."] = true,
	["Show targettarget."] = true,
	["Define which frames you want to see."] = true,
	["Layout"] = true,
	["Set the layout for the PT frames."] = true,
	["Vertical"] = true,
	["Horizontal"] = true,
	
	["set"] = true,
	["Set Player"] = true,
	["Set a player."]= true,
	["<nr> <name>"] = true,
	["<nr>"] = true,
	["<name>"] = true,
	["Remove Player"] = true,
	["remove"] = true,
	["Remove a player."] = true,
	["Removed player: "] = true,
	["Set player: "] = true,
	
	["(%S+)%s*(.*)"] = true,

	["<Not Assigned>"] = true,

} end )


L:RegisterTranslations("koKR", function() return {
	["Player"] = "플레이어탱커",
	["PlayerTarget"] = "플레이어탱커대상",
	["Optional/PlayerTarget"] = "부가/플레이어탱커",
	["Options for the playertargets."] = "플레이어 탱커에 대한 설정을 변경합니다.",
	["Targettarget"] = "대상의대상",
	["Toggle TargetTarget frames."] = "대상의 대상창을 토글합니다.",
	["Scale"] = "크기",
	["Set frame scale."] = "창의 크기를 설정합니다.",
	["Alpha"] = "투명도",
	["Set frame alpha."] = "창의 투명도를 설정합니다.",
	["Raidicon"] = "공격대아이콘",
	["Toggle raid icons."] = "공격대 아이콘 표시를 토글합니다.",
	["Frames"] = "창",
	["Options for the playertarget frames."] = "플레이어탱커 창에 관한 설정을 변경합니다.",
	["Growup"] = "방향",
	["Toggle growup."] = "창의 진행 방향을 토글합니다.",
	["Inverse"] = "반전",
	["Toggle inverse healthbar."] = "생명력바 반전기능을 토글합니다.",
	["Deficit"] = "결손치",
	["Toggle deficit health."] = "생명력바 결손치 표시기능을 토글합니다.",
	["Clickcast"] = "시전",
	["Toggle clickcast support."] = "클릭캐스트 기능 지원을 토글합니다.",
	["Clicktarget"] = "클릭시대상선정",
	["Define clicktargets."] = "클릭시 선택 대상을 정의합니다.",
	["Define the clicktarget for player."] = "플레이어탱커를 클릭시 선택 대상을 정의힙니다.",
	["Define the clicktarget for target."] = "대상 클릭시 선택 대상을 정의합니다.",
	["Define the clicktarget for targettarget."] = "대상의 대상을 클릭시 선택 대상을 정의합니다.",
	["Target"] = "대상",
	["TargetTarget"] = "대상의대상",
	["Nr of Players shown."] = "플레이어탱커의 번호를 표시힙니다.",
	["Nr Players"] = "플레이어탱커의 수",
	["Nr"] = "수",
	["Classcolor"] = "직업별색상",
	["Color healthbars by class."] = "직업별로 생명력바의 색상을 변경합니다.",
	["Enemycolor"] = "적색상",
	["Set the color for enemies. (used when classcolor is enabled)"] = "적의 경우의 색상을 설정합니다. (직업별색상 기능을 사용할 때)",
	["Color Aggro"] = "어그로 색상",
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "현재 상태에 따라서 플레이어 탱커를 위한 어그로 색상을 표시힙니다. 오렌지는 대상, 녹색은 탱커, 적색은 어그로 없읍니다.",
	["Backdrop"] = "배경",
	["Toggle the backdrop."] = "배경 토글",
	["Highlight"] = "강조",
	["Toggle highlighting your target."] = "대상 강조 기능 토글",
	["Reverse"] = "반전",
	["Toggle reverse order PT|PTT|PTTT or PTTT|PTT|PT."] = "플레이어탱커목록의 순서를 반대로표시합니다.",
	["Numbers"] = "플레이어탱커번호",
	["Toggle showing of PT numbers."] = "플레이어탱커의 번호의 표시를 토글합니다.",
	["Tooltips"] = "툴팁",
	["Toggle showing of tooltips."] = "툴팁의 표시를 토글합니다.",
	["Show"] = "표시",
	["Show player."] = "플레이어탱커 표시",
	["Show target."] = "대상 표시",
	["Show targettarget."] = "대상의 대상 표시",
	["Define which frames you want to see."] = "표시하길 원하는 창을 정의합니다.",
	["Layout"] = "레이아웃",
	["Set the layout for the PT frames."] = "플레이어탱커창의 레이아웃을 설정합니다.",
	["Vertical"] = "수직",
	["Horizontal"] = "수평",
	
--	["set"] = true,
	["Set Player"] = "플레이어 선택",
	["Set a player."]= "플레이어를 선택합니다",
	["<nr> <name>"] = "<번호> <이름>",
	["<nr>"] = "<번호>",
	["<name>"] = "<이름>",
	["Remove Player"] = "플레이어 삭제",
	["remove"] = "삭제",
	["Remove a player."] = "플레이어를 목록에서 삭제합니다.",
	["Removed player: "] = "삭제된 플레이어: ",
	["Set player: "] = "설정된 플레이어: ",
	
	["(%S+)%s*(.*)"] = "(%S+)%s*(.*)",

	["<Not Assigned>"] = "<미정의됨>",

} end )

L:RegisterTranslations("zhCN", function() return {
	["playertargetoptional"] = "playertargetoptional",
	["pt"] = "玩家目标",
	["Player"] = "玩家",
	["PlayerTarget"] = "玩家目标",
	["Optional/PlayerTarget"] = "Optional/PlayerTarget",
	["Options for the playertargets."] = "玩家目标选项",
	["Targettarget"] = "目标的目标",
	["Toggle TargetTarget frames."] = "显示目标的目标框体",
	["Scale"] = "大小",
	["Set frame scale."] = "设定框体大小",
	["Alpha"] = "透明度",
	["Set frame alpha."] = "设置框体透明度",
	["Raidicon"] = "raid图标",
	["Toggle raid icons."] = "显示raid图标",
	["Frames"] = "框体",
	["Options for the playertarget frames."] = "玩家目标框体选项",
	["Growup"] = "往上增添",
	["Toggle growup."] = "选择往上增添",
	["Inverse"] = "翻转",
	["Toggle inverse healthbar."] = "选择翻转血条",
	["Deficit"] = "亏损血量",
	["Toggle deficit health."] = "显示亏损血量",
	["Clickcast"] = "点击施法",
	["Toggle clickcast support."] = "选择点击施法支持",
	["Clicktarget"] = "点击设定目标",
	["Define clicktargets."] = "定义点击设定目标",
	["Define the clicktarget for player."] = "定义点击PT设定的目标",
	["Define the clicktarget for target."] = "定义点击PTT设定的目标",
	["Define the clicktarget for targettarget."] = "定义点击PTTT设定的目标",
	["Target"] = "目标",
	["TargetTarget"] = "目标的目标",
	["Nr of Players shown."] = "显示的PT数量",
	["Nr Players"] = "PT数量",
	["Nr"] = "数量",
	["Classcolor"] = "职业颜色",
	["Color healthbars by class."] = "把血条着色为职业颜色",
	["Enemycolor"] = "敌人颜色",
	["Set the color for enemies. (used when classcolor is enabled)"] = "为敌人设置颜色(需要激活职业颜色)",
	["Coloraggro"] = "仇恨颜色",
	["Color Aggro"] = "仇恨颜色",
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "PT的名字边框用颜色来显示仇恨的状态。橘红是有目标，绿色是正在坦克，红色是没有仇恨",
	["Backdrop"] = "背景",
	["Toggle the backdrop."] = "显示背景",
	["Highlight"] = "高亮",
	["Toggle highlighting your target."] = "高亮显示你的目标",
	["Reverse"] = "逆转",
	["Toggle reverse order PT|PTT|PTTT or PTTT|PTT|PT."] = "逆转顺序：MT|MTT|MTTT 或 MTTT|MTT|MT",
	["Numbers"] = "数量",
	["Toggle showing of PT numbers."] = "显示PT的数量",
	["Tooltips"] = "提示",
	["Toggle showing of tooltips."] = "顯示提示",
	["Show"] = "显示",
	["Show player."] = "显示PT",
	["Show target."] = "显示目标",
	["Show targettarget."] = "显示目标的目标",
	["Define which frames you want to see."] = "定义想要看到的框架",
	["Layout"] = "布局",
	["Set the layout for the PT frames."] = "设置PT框架的布局",
	["Vertical"] = "垂直",
	["Horizontal"] = "水平",
	
	["set"] = "设置",
	["Set Player"] = "设定PT",
	["Set a player."]= "设定PT",
	["<nr> <name>"] = "<数量> <名字>",
	["<nr>"] = "<数量>",
	["<name>"] = "<姓名>",
	["Remove Player"] = "移除PT",
	["remove"] = "移除",
	["Remove a player."] = "移除PT",
	["Removed player: "] = "移除PT：",
	["Set player: "] = "设置PT：",
	
	["(%S+)%s*(.*)"] = "(%d+)%s*(.*)",

	["<Not Assigned>"] = "<还未设定>",
} end )

L:RegisterTranslations("zhTW", function() return {
	["playertargetoptional"] = "玩家自訂目標",
	["pt"] = "玩家目標",
	["Player"] = "玩家",
	["PlayerTarget"] = "玩家目標",
	["Optional/PlayerTarget"] = "可選/玩家目標",
	["Options for the playertargets."] = "玩家目標選項",
	["Targettarget"] = "目標的目標",
	["Toggle TargetTarget frames."] = "顯示目標的目標框架",
	["Scale"] = "大小",
	["Set frame scale."] = "設定框架大小",
	["Alpha"] = "透明度",
	["Set frame alpha."] = "設定框架的透明度",
	["Raidicon"] = "團隊圖示",
	["Toggle raid icons."] = "切換團隊圖示",
	["Frames"] = "框架",
	["Options for the playertarget frames."] = "玩家目標的框架選項",
	["Growup"] = "往上排列",
	["Toggle growup."] = "切換往上排列",
	["Inverse"] = "倒轉",
	["Toggle inverse healthbar."] = "切換倒轉血條",
	["Deficit"] = "減少血量",
	["Toggle deficit health."] = "顯示減少血量",
	["Clickcast"] = "點擊施法",
	["Toggle clickcast support."] = "切換點擊施法支援",
	["Clicktarget"] = "點擊設定目標",
	["Define clicktargets."] = "定義點擊設定目標",
	["Define the clicktarget for player."] = "定義點擊PT設定的目標",
	["Define the clicktarget for target."] = "定義點擊PTT設定的目標",
	["Define the clicktarget for targettarget."] = "定義點擊PTTT設定的目標",
	["Target"] = "目標",
	["TargetTarget"] = "目標的目標",
	["Nr of Players shown."] = "顯示的玩家數量",
	["Nr Players"] = "玩家數量",
	["Nr"] = "數量",
	["Classcolor"] = "職業顏色",
	["Color healthbars by class."] = "依職業設定血條顏色",
	["Enemycolor"] = "敵人顏色",
	["Set the color for enemies. (used when classcolor is enabled)"] = "為敵人設定顏色(需要使用職業顏色)",
	["Coloraggro"] = "仇恨顏色",
	["Color Aggro"] = "仇恨顏色",
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "玩家目標的名字邊框用顏色來顯示仇恨的狀態。橘紅是有目標，綠色是正在坦怪，紅色是沒有仇恨。",
	["Backdrop"] = "背景",
	["Toggle the backdrop."] = "顯示背景",
	["Highlight"] = "高亮度",
	["Toggle highlighting your target."] = "高亮度顯示你的目標",
	["Reverse"] = "反轉",
	["Toggle reverse order PT|PTT|PTTT or PTTT|PTT|PT."] = "反轉順序：PT|PTT|PTTT 或 PTTT|PTT|PT",
	["Numbers"] = "數量",
	["Toggle showing of PT numbers."] = "顯示玩家目標的數量",
	["Tooltips"] = "提示",
	["Toggle showing of tooltips."] = "顯示提示",
	["Show"] = "顯示",
	["Show player."] = "顯示玩家",
	["Show target."] = "顯示目標",
	["Show targettarget."] = "顯示目標的目標",
	["Define which frames you want to see."] = "定義想要看到的框架",
	["Layout"] = "佈置",
	["Set the layout for the PT frames."] = "設定玩家目標框架的佈置",
	["Vertical"] = "垂直",
	["Horizontal"] = "水平",
	
	["set"] = "設置",
	["Set Player"] = "設置玩家",
	["Set a player."]= "設置一位玩家",
	["<nr> <name>"] = "<數量> <姓名>",
	["<nr>"] = "<數量>",
	["<name>"] = "<姓名>",
	["Remove Player"] = "移除玩家",
	["remove"] = "移除",
	["Remove a player."] = "移除一位玩家",
	["Removed player: "] = "移除玩家：",
	["Set player: "] = "設置玩家：",
	
	["(%S+)%s*(.*)"] = "(%S+)%s*(.*)",

	["<Not Assigned>"] = "<尚未設置>",

} end )

L:RegisterTranslations("frFR", function() return {
	--["playertargetoptional"] = true,
	--["pt"] = true,
	["Player"] = "Joueur",
	["PlayerTarget"] = "Cibles Joueurs (PT)",
	["Optional/PlayerTarget"] = "Optionnel/Cibles Joueurs",
	["Options for the playertargets."] = "Optons concernant les cibles des joueurs.",
	--["Targettarget"] = true,
	["Toggle TargetTarget frames."] = "Affiche ou non les cadres de la cible de la cible.",
	["Scale"] = "Taille",
	["Set frame scale."] = "D\195\169termine la taille des cadres.",
	["Alpha"] = "Transparence",
	["Set frame alpha."] = "D\195\169termine la transparence des cadres.",
	["Raidicon"] = "Ic\195\180nedeRaid",
	["Toggle raid icons."] = "Affiche ou non les ic\195\180nes de raid.",
	["Frames"] = "Cadres",
	["Options for the playertarget frames."] = "Options concernant les cadres des cibles des joueurs.",
	["Growup"] = "VersleHaut",
	["Toggle growup."] = "Ajoute ou non les PTs vers le haut.",
	["Inverse"] = "Inverser",
	["Toggle inverse healthbar."] = "Inverse ou non le sens de remplissage des barres de vie.",
	["Deficit"] = "D\195\169ficit",
	["Toggle deficit health."] = "Affiche ou non le d\195\169ficit en vie.",
	--["Clickcast"] = true,
	["Toggle clickcast support."] = "Active ou non le support des addons de \"clickcasting\".",
	--["Clicktarget"] = true,
	["Define clicktargets."] = "D\195\169termine la cible des clics.",
	["Define the clicktarget for player."] = "D\195\169termine la cible lors du clic sur le cadre du joueur.",
	["Define the clicktarget for target."] = "D\195\169termine la cible lors du clic sur le cadre de la cible.",
	["Define the clicktarget for targettarget."] = "D\195\169termine la cible lors du clic sur le cadre de la cible de la cible.",
	["Target"] = "Cible",
	["TargetTarget"] = "CibledelaCible",
	["Nr of Players shown."] = "Nombre de joueurs \195\160 afficher.",
	["Nr Players"] = "Nbre de joueurs",
	["Nr"] = "N\194\176",
	["Classcolor"] = "CouleurdeClasse",
	["Color healthbars by class."] = "Colore les barres de vie selon la classe.",
	["Enemycolor"] = "CouleurEnnemi",
	["Set the color for enemies. (used when classcolor is enabled)"] = "D\195\169termine la couleur pour les ennemis. (utilis\195\169 si CouleurdeClasse est activ\195\169)",
	--["Coloraggro"] = true,
	["Color Aggro"] = "Couleur d'aggro",
	["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."] = "Indique le statut de l'aggro des PTs selon la couleur de leurs noms. Orange s'ils ont la cible, Vert s'ils tankent, Rouge s'ils n'ont pas l'aggro.",
	["Backdrop"] = "Fond",
	["Toggle the backdrop."] = "Affiche ou non le fond.",
	["Highlight"] = "Surbrillance",
	["Toggle highlighting your target."] = "Met ou non en surbrillance votre cible.",
	["Reverse"] = "Inverser",
	["Toggle reverse order PT|PTT|PTTT or PTTT|PTT|PT."] = "Inverse ou non l'ordre d'affichage. (PT|PTT|PTTT ou PTTT|PTT|PT)",
	["Numbers"] = "Num\195\169ros",
	["Toggle showing of PT numbers."] = "Affiche ou non les num\195\169ros des PTs.",
	["Tooltips"] = "Infobulles",
	["Toggle showing of tooltips."] = "Affiche ou non les infobulles.",
	["Show"] = "Afficher",
	["Show player."] = "Affiche le joueur.",
	["Show target."] = "Affiche la cible.",
	["Show targettarget."] = "Affiche la cible de la cible.",
	["Define which frames you want to see."] = "D\195\169termine les cadres que vous souhaitez voir.",
	["Layout"] = "Style",
	["Set the layout for the PT frames."] = "D\195\169termine le style des cadres des PTs.",
	--["Vertical"] = true,
	--["Horizontal"] = true,

	--["set"] = true,
	["Set Player"] = "Ajouter un joueur",
	["Set a player."]= "Ajoute un joueur.",
	["<nr> <name>"] = "<n\194\176> <nom>",
	["<nr>"] = "<n\194\176>",
	["<name>"] = "<nom>",
	["Remove Player"] = "Enlever un joueur",
	--["remove"] = true,
	["Remove a player."] = "Enl\195\168ve un joueur",
	["Removed player: "] = "Joueur enlev\195\169 : ",
	["Set player: "] = "Joueur ajout\195\169 : ",

	--["(%S+)%s*(.*)"] = true,

	["<Not Assigned>"] = "<Non assign\195\169>",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRAOPlayerTarget = oRA:NewModule(L["playertargetoptional"])
oRAOPlayerTarget.defaults = {
	raidicon = true,
	alpha = 1,
	scale = 1,
	growup = false,
	inverse = false,
	deficit = false,
	clickcast = true,
	ctplayer = L["Player"],
	cttarget = L["Target"],
	cttargettarget = L["TargetTarget"],
	nrpts = 10,
	classcolor = true,
	enemycolor = "cc2200",
	coloraggro = true,
	backdrop = true,
	highlight = true,
	reverse = false,
	numbers = true,
	tooltips = true,
	showpt = true,
	showptt = true,
	showpttt = true,
	layout = L["Vertical"],
	playertable = {},
}
oRAOPlayerTarget.optional = true
oRAOPlayerTarget.name = L["Optional/PlayerTarget"]
oRAOPlayerTarget.consoleCmd = L["pt"]
oRAOPlayerTarget.consoleOptions = {
	type = "group",
	desc = L["Options for the playertargets."],
	name = L["PlayerTarget"],
	args = {
		[L["Nr"]] = {
			type = "range",
			name = L["Nr Players"],
			desc = L["Nr of Players shown."],
			get = function() return oRAOPlayerTarget.db.profile.nrpts end,
			set = function(v) oRAOPlayerTarget:SetNrPlayers(v) end,
			min = 0, max = 10, step = 1,
		},
		[L["set"]] = {
			name = L["Set Player"], type = "group",
			desc = L["Set a player."],
			-- disabled = function() return not oRAOPlayerTarget:IsValidRequest(UnitName("player"), true) end,
			disabled = function() return not oRA:IsModuleActive(oRAOPlayerTarget) end,
			args = {
				["1"] = {
					name = "1.", type = "text", desc = L["Set Player"].." 1",
					get = function() 
						if oRAOPlayerTarget.db.profile.playertable[1] then return oRAOPlayerTarget.db.profile.playertable[1]
						else return "" end
					end,
					set = function(v) oRAOPlayerTarget:Set(1, v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 1,
				},
				["2"] = {
					name = "2.", type = "text", desc = L["Set Player"].." 2",
					get = function() 
						if oRAOPlayerTarget.db.profile.playertable[2] then return oRAOPlayerTarget.db.profile.playertable[2]
						else return "" end
					end,
					set = function(v) oRAOPlayerTarget:Set(2, v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 2,
				},
				["3"] = {
					name = "3.", type = "text", desc = L["Set Player"].." 3",
					get = function() 
						if oRAOPlayerTarget.db.profile.playertable[3] then return oRAOPlayerTarget.db.profile.playertable[3]
						else return "" end
					end,
					set = function(v) oRAOPlayerTarget:Set(3, v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 3,
				},
				["4"] = {
					name = "4.", type = "text", desc = L["Set Player"].." 4",
					get = function() 
						if oRAOPlayerTarget.db.profile.playertable[4] then return oRAOPlayerTarget.db.profile.playertable[4]
						else return "" end
					end,
					set = function(v) oRAOPlayerTarget:Set(4, v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 4,
				},
				["5"] = {
					name = "5.", type = "text", desc = L["Set Player"].." 5",
					get = function() 
						if oRAOPlayerTarget.db.profile.playertable[5] then return oRAOPlayerTarget.db.profile.playertable[5]
						else return "" end
					end,
					set = function(v) oRAOPlayerTarget:Set(5, v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 5,
				},
				["6"] = {
					name = "6.", type = "text", desc = L["Set Player"].." 6",
					get = function() 
						if oRAOPlayerTarget.db.profile.playertable[6] then return oRAOPlayerTarget.db.profile.playertable[6]
						else return "" end
					end,
					set = function(v) oRAOPlayerTarget:Set(6, v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 6,
				},
				["7"] = {
					name = "7.", type = "text", desc = L["Set Player"].." 7",
					get = function() 
						if oRAOPlayerTarget.db.profile.playertable[7] then return oRAOPlayerTarget.db.profile.playertable[7]
						else return "" end
					end,
					set = function(v) oRAOPlayerTarget:Set(7, v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 7,
				},
				["8"] = {
					name = "8.", type = "text", desc = L["Set Player"].." 8",
					get = function() 
						if oRAOPlayerTarget.db.profile.playertable[8] then return oRAOPlayerTarget.db.profile.playertable[8]
						else return "" end
					end,
					set = function(v) oRAOPlayerTarget:Set(8, v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 8,
				},
				["9"] = {
					name = "9.", type = "text", desc = L["Set Player"].." 9",
					get = function() 
						if oRAOPlayerTarget.db.profile.playertable[9] then return oRAOPlayerTarget.db.profile.playertable[9]
						else return "" end
					end,
					set = function(v) oRAOPlayerTarget:Set(9, v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 9,
				},
				["10"] = {
					name = "10.", type = "text", desc = L["Set Player"].." 10",
					get = function() 
						if oRAOPlayerTarget.db.profile.playertable[10] then return oRAOPlayerTarget.db.profile.playertable[10]
						else return "" end
					end,
					set = function(v) oRAOPlayerTarget:Set(10, v) end,
					validate = function(v) return string.find(v, "^(%S+)$") end,
					usage = L["<name>"],
					order = 10,
				},
			}
		},
		[L["remove"]] = {
			name = L["Remove Player"], type = "group",
			desc = L["Remove a player."],
			-- disabled = function() return not oRAOPlayerTarget:IsValidRequest(UnitName("player"), true) end,
			disabled = function() return not oRA:IsModuleActive(oRAOPlayerTarget) end,
			args = {
				["1"] = {
					name = "1.", type = "execute", desc = L["Remove Player"].." 1",
					func = function() oRAOPlayerTarget:Remove("1") end,
					disabled = function() return not oRAOPlayerTarget.db.profile.playertable[1] end,
					order = 1,
				},				
				["2"] = {
					name = "2.", type = "execute", desc = L["Remove Player"].." 2",
					func = function() oRAOPlayerTarget:Remove("2") end,
					disabled = function() return not oRAOPlayerTarget.db.profile.playertable[2] end,
					order = 2,
				},
				["3"] = {
					name = "3.", type = "execute", desc = L["Remove Player"].." 3",
					func = function() oRAOPlayerTarget:Remove("3") end,
					disabled = function() return not oRAOPlayerTarget.db.profile.playertable[3] end,
					order = 3,
				},
				["4"] = {
					name = "4.", type = "execute", desc = L["Remove Player"].." 4",
					func = function() oRAOPlayerTarget:Remove("4") end,
					disabled = function() return not oRAOPlayerTarget.db.profile.playertable[4] end,
					order = 4,
				},
				["5"] = {
					name = "5.", type = "execute", desc = L["Remove Player"].." 5",
					func = function() oRAOPlayerTarget:Remove("5") end,
					disabled = function() return not oRAOPlayerTarget.db.profile.playertable[5] end,
					order = 5,
				},
				["6"] = {
					name = "6.", type = "execute", desc = L["Remove Player"].." 6",
					func = function() oRAOPlayerTarget:Remove("6") end,
					disabled = function() return not oRAOPlayerTarget.db.profile.playertable[6] end,
					order = 6,
				},
				["7"] = {
					name = "7.", type = "execute", desc = L["Remove Player"].." 7",
					func = function() oRAOPlayerTarget:Remove("7") end,
					disabled = function() return not oRAOPlayerTarget.db.profile.playertable[7] end,
					order = 7,
				},
				["8"] = {
					name = "8.", type = "execute", desc = L["Remove Player"].." 8",
					func = function() oRAOPlayerTarget:Remove("8") end,
					disabled = function() return not oRAOPlayerTarget.db.profile.playertable[8] end,
					order = 8,
				},
				["9"] = {
					name = "9.", type = "execute", desc = L["Remove Player"].." 9",
					func = function() oRAOPlayerTarget:Remove("9") end,
					disabled = function() return not oRAOPlayerTarget.db.profile.playertable[9] end,
					order = 9,
				},
				["10"] = {
					name = "10.", type = "execute", desc = L["Remove Player"].." 10",
					func = function() oRAOPlayerTarget:Remove("10") end,
					disabled = function() return not oRAOPlayerTarget.db.profile.playertable[10] end,
					order = 10,
				},
			}
		},	
		[L["Frames"]] = {
			type = "group",
			desc = L["Options for the playertarget frames."],
			name = L["Frames"],
			args = {
				[L["Classcolor"]] = {
					type = "toggle",
					name = L["Classcolor"],
					desc = L["Color healthbars by class."],
					get = function() return oRAOPlayerTarget.db.profile.classcolor end,
					set = function(v) oRAOPlayerTarget:SetClassColor(v) end,
				},
				[L["Enemycolor"]] = {
					type = "color",
					name = L["Enemycolor"],
					desc = L["Set the color for enemies. (used when classcolor is enabled)"],
					get = function()
						local _, r, g, b = paintchips:GetRGBPercent( oRAOPlayerTarget.db.profile.enemycolor )
						return r, g, b
					end,
					set = function(r, g, b)
						local hex = format("%02x%02x%02x", r*255, g*255, b*255)
						paintchips:RegisterHex( hex )
						oRAOPlayerTarget.db.profile.enemycolor = hex
					end,
					disabled = function() return not oRAOPlayerTarget.db.profile.classcolor end,					
				},
				[L["Coloraggro"]] = {
					type = "toggle",
					name = L["Color Aggro"],
					desc = L["Color aggro status for PTs on their names. Orange has target, Green is tanking, Red has no aggro."],
					get = function() return oRAOPlayerTarget.db.profile.coloraggro end,
					set = function(v) oRAOPlayerTarget.db.profile.coloraggro = v end,
				},
				[L["Backdrop"]] = {
					type = "toggle",
					name = L["Backdrop"],
					desc = L["Toggle the backdrop."],
					get = function() return oRAOPlayerTarget.db.profile.backdrop end,
					set = function(v) oRAOPlayerTarget.db.profile.backdrop = v end,
				},
				[L["Highlight"]] = {
					type = "toggle",
					name = L["Highlight"],
					desc = L["Toggle highlighting your target."],
					get = function() return oRAOPlayerTarget.db.profile.highlight end,
					set = function(v) oRAOPlayerTarget.db.profile.highlight = v end,
				},
		
				[L["Scale"]] = {
					type = "range",
					name = L["Scale"],
					desc = L["Set frame scale."],
					get = function() return oRAOPlayerTarget.db.profile.scale end,
					set = function(v) oRAOPlayerTarget:SetScale(v) end,
					min = 0.1,
					max = 2,
				},				

				[L["Alpha"]] = {
					type = "range",
					name = L["Alpha"],
					desc = L["Set frame alpha."],
					get = function() return oRAOPlayerTarget.db.profile.alpha end,
					set = function(v) oRAOPlayerTarget:SetAlpha(v) end,
					min = 0.1,
					max = 1,
				},
	
				[L["Raidicon"]] = {
					type = "toggle",
					name = L["Raidicon"],
					desc = L["Toggle raid icons."],
					get = function() return oRAOPlayerTarget.db.profile.raidicon end,
					set = function(v) oRAOPlayerTarget:ToggleRaidIcon(v) end,
				},

				[L["Growup"]] = {
					type = "toggle",
					name = L["Growup"],
					desc = L["Toggle growup."],
					get = function() return oRAOPlayerTarget.db.profile.growup end,
					set = function(v) oRAOPlayerTarget:ToggleGrowup(v) end,
				},

				[L["Inverse"]] = {
					type = "toggle",
					name = L["Inverse"],
					desc = L["Toggle inverse healthbar."],
					get = function() return oRAOPlayerTarget.db.profile.inverse end,
					set = function(v) oRAOPlayerTarget:ToggleInverse(v) end,
				},
				[L["Reverse"]] = {
					type = "toggle",
					name = L["Reverse"],
					desc = L["Toggle reverse order PT|PTT|PTTT or PTTT|PTT|PT."],
					get = function() return oRAOPlayerTarget.db.profile.reverse end,
					set = function(v) oRAOPlayerTarget:ToggleReverse(v) end,
				},
				[L["Numbers"]] = {
					type = "toggle",
					name = L["Numbers"],
					desc = L["Toggle showing of PT numbers."],
					get = function() return oRAOPlayerTarget.db.profile.numbers end,
					set = function(v) oRAOPlayerTarget:ToggleNumbers(v) end,
				},
				[L["Tooltips"]] = {
					type = "toggle",
					name = L["Tooltips"],
					desc = L["Toggle showing of tooltips."],
					get = function() return oRAOPlayerTarget.db.profile.tooltips end,
					set = function(v) oRAOPlayerTarget.db.profile.tooltips = v end,
				},				
				[L["Deficit"]] = {
					type = "toggle",
					name = L["Deficit"],
					desc = L["Toggle deficit health."],
					get = function() return oRAOPlayerTarget.db.profile.deficit end,
					set = function(v) oRAOPlayerTarget:ToggleDeficit(v) end,
				},
				
				[L["Clickcast"]] = {
					type = "toggle",
					name = L["Clickcast"],
					desc = L["Toggle clickcast support."],
					get = function() return oRAOPlayerTarget.db.profile.clickcast end,
					set = function(v) oRAOPlayerTarget.db.profile.clickcast = v end,
				},
				[L["Layout"]] = {
					type = "text",
					name = L["Layout"],
					desc = L["Set the layout for the PT frames."],
					get = function() return oRAOPlayerTarget.db.profile.layout end,
					set = function(v) oRAOPlayerTarget:SetLayout(v) end,
					validate = {L["Vertical"], L["Horizontal"]}
				},
				[L["Clicktarget"]] = {
					type = "group", name = L["Clicktarget"], desc = L["Define clicktargets."],
					args = {
						[L["Player"]] = {
							name = L["Player"], type = "text", desc = L["Define the clicktarget for player."],
							get = function() return oRAOPlayerTarget.db.profile.ctplayer end,
							set = function(v) oRAOPlayerTarget.db.profile.ctplayer = v end,
							validate = { L["Player"], L["Target"], L["TargetTarget"] }
						},
						[L["Target"]] = {
							name = L["Target"], type = "text", desc = L["Define the clicktarget for target."],
							get = function() return oRAOPlayerTarget.db.profile.cttarget end,
							set = function(v) oRAOPlayerTarget.db.profile.cttarget = v end,
							validate = { L["Player"], L["Target"], L["TargetTarget"] }
						},
						[L["TargetTarget"]] = {
							name = L["TargetTarget"], type = "text", desc = L["Define the clicktarget for targettarget."],
							get = function() return oRAOPlayerTarget.db.profile.cttargettarget end,
							set = function(v) oRAOPlayerTarget.db.profile.cttargettarget = v end,
							validate = { L["Player"], L["Target"], L["TargetTarget"] }
						},
					},
				},
				[L["Show"]] = {
					type = "group", name = L["Show"], desc = L["Define which frames you want to see."],
					args = {
						[L["Player"]] = {
							name = L["Player"], type = "toggle", desc = L["Show player."],
							get = function() return oRAOPlayerTarget.db.profile.showpt end,
							set = function(v)
								oRAOPlayerTarget.db.profile.showpt = v
								oRAOPlayerTarget:UpdateFrameShow()
							end,
						},
						[L["Target"]] = {
							name = L["Target"], type = "toggle", desc = L["Show target."],
							get = function() return oRAOPlayerTarget.db.profile.showptt end,
							set = function(v)
								oRAOPlayerTarget.db.profile.showptt = v
								oRAOPlayerTarget:UpdateFrameShow()
							end,
						},
						[L["TargetTarget"]] = {
							name = L["TargetTarget"], type = "toggle", desc = L["Show targettarget."],
							get = function() return oRAOPlayerTarget.db.profile.showpttt end,
							set = function(v)
								oRAOPlayerTarget.db.profile.showpttt = v
								oRAOPlayerTarget:UpdateFrameShow()
							end,
						},
					},
				},

			},
		},	
	}	
}


------------------------------
--      Initialization      --
------------------------------

function oRAOPlayerTarget:OnEnable()
	self.ptf = {}
	self.pttf = {}
	self.ptttf = {}
	self.enabled = nil
	
	if not self.db.profile.playertable then self.db.profile.playertable = {} end

	paintchips:RegisterHex(self.db.profile.enemycolor or "cc2200" )

	self:SetupFrames()

	self:RegisterEvent("oRA_LeftRaid")
	self:RegisterEvent("oRA_JoinedRaid")
	self:RegisterEvent("RosterLib_RosterChanged", function() self:oRA_PlayerTargetUpdate() end)

	self:RegisterEvent("oRA_BarTexture")

	-- Check for Watchdog
	if (WatchDog_OnClick) then
		oRA_PlayerTargetFramesCustomClick = WatchDog_OnClick
	end
end


function oRAOPlayerTarget:OnDisable()
	self:UnregisterAllEvents()
end



------------------------------
--      Event Handlers      --
------------------------------

function oRAOPlayerTarget:oRA_LeftRaid()
	self.enabled = nil
	self.mainframe:Hide()
end

function oRAOPlayerTarget:oRA_JoinedRaid()
	if not self.enabled then
		self.enabled = true
		self:oRA_PlayerTargetUpdate()
	end
end


function oRAOPlayerTarget:oRA_PlayerTargetUpdate()
	
	if not self.db.profile.playertable then return end
	if not self.enabled then return end
	
	self:UpdateConsole()
	
	local showpt, unitid

	for i = 1, self.db.profile.nrpts do
		unitid = roster:GetUnitIDFromName(self.db.profile.playertable[i])

		if unitid then
			if self.db.profile.showpt then
				if not self.ptf[i] then self.ptf[i] = self:CreateUnitFrame( self.mainframe, i, "pt" ) end
				self.ptf[i].unit = unitid
			end
			if self.db.profile.showptt then
				if not self.pttf[i] then self.pttf[i] = self:CreateUnitFrame( self.mainframe, i, "ptt" ) end
				self.pttf[i].unit = unitid
			end

			if self.db.profile.showpttt then
				if not self.ptttf[i] then self.ptttf[i] = self:CreateUnitFrame( self.mainframe, i, "pttt" ) end
				self.ptttf[i].unit = unitid
			end

			showpt = true

		else -- unit nolonger in the raid or unknown
			if self.ptf[i] then self.ptf[i].unit = nil end
			if self.pttf[i] then self.pttf[i].unit = nil end
			if self.ptttf[i] then self.ptttf[i].unit = nil end
		end
	end


	if showpt then
		self.mainframe:Show()
	else
		self.mainframe:Hide()
	end
end

function oRAOPlayerTarget:oRA_BarTexture( texture )
	for _, f in pairs({ self.ptf, self.pttf, self.ptttf }) do
		for _, f in pairs(f) do
			f.bar:SetStatusBarTexture(self.core.bartextures[texture])
			f.bar.texture:SetTexture(self.core.bartextures[texture])
		end
	end
end

------------------------------
-- ConsoleOption Functions  --
------------------------------

function oRAOPlayerTarget:SetScale(scale)
	self.db.profile.scale = scale

	if self.mainframe then
		self.mainframe:SetScale(scale)
	end
	self:RestorePosition()
end


function oRAOPlayerTarget:SetAlpha(alpha)
	self.db.profile.alpha = alpha

	if self.mainframe then
		self.mainframe:SetAlpha(alpha)
	end
end

function oRAOPlayerTarget:SetClassColor(state)
	self.db.profile.classcolor = state
	if self.ptf then
		for _, f in pairs(self.ptf) do
			self:UpdateHealthBar(f.bar, self:GetUnit(f))
		end
	end
	if self.pttf then
		for _, f in pairs(self.pttf) do
			self:UpdateHealthBar(f.bar, self:GetUnit(f))
		end
	end
	if self.ptttf then
		for _, f in pairs(self.ptttf) do
			self:UpdateHealthBar(f.bar, self:GetUnit(f))
		end
	end
end


function oRAOPlayerTarget:UpdateFrameShow()
	for _, f in pairs({self.ptf, self.pttf, self.ptttf}) do
		if f then
			for _, f in pairs(f) do
				if f then
					self:SetStyle(f)
					if f.type == "pt" then
						if self.db.profile.showpt then f:Show() else f:Hide() end
					elseif f.type == "ptt" then
						if self.db.profile.showptt then f:Show() else f:Hide() end
					else 
						if self.db.profile.showpttt then f:Show() else f:Hide() end
					end
				end
			end
		end
	end
	self:ToggleNumbers(self.db.profile.numbers)
end


function oRAOPlayerTarget:ToggleRaidIcon(state)
	self.db.profile.raidicon = state

	if state then return end

	for _, f in pairs({ self.ptf, self.pttf, self.ptttf }) do
		if f then
			for _, f in pairs(f) do
				if f then f.raidicon:Hide() end
			end
		end
	end
end

function oRAOPlayerTarget:ToggleNumbers(state)
	self.db.profile.numbers = state

	local ff = self.ptttf

	if self.db.profile.showptt then ff = self.pttf end
	if self.db.profile.showpt then ff = self.ptf end

	if not ff then return end

	for _, f in pairs(ff) do
		if state and f.number then
			f.number:Show()
		elseif f.number then
			f.number:Hide()
		end
	end
end

function oRAOPlayerTarget:SetLayout(state)
	self.db.profile.layout = state
	for _, f in pairs({self.ptf, self.pttf, self.ptttf}) do
		if f then
			for _, f in pairs(f) do
				if f then self:SetStyle(f) end
			end
		end
	end	
end


function oRAOPlayerTarget:ToggleGrowup(state)
	self.db.profile.growup = state
	for _, f in pairs({self.ptf, self.pttf, self.ptttf}) do
		if f then
			for _, f in pairs(f) do
				if f then self:SetStyle(f) end
			end
		end
	end	
end

function oRAOPlayerTarget:ToggleInverse(state)
	self.db.profile.inverse = state
end

function oRAOPlayerTarget:ToggleReverse(state)
	self.db.profile.reverse = state
	
	for _, f in pairs({self.ptf, self.pttf, self.ptttf}) do
		if f then
			for _, f in pairs(f) do
				if f then self:SetStyle(f) end
			end
		end
	end	
end

function oRAOPlayerTarget:ToggleDeficit(state)
	self.db.profile.deficit = state

	for _, f in pairs({self.ptf, self.pttf, self.ptttf}) do
		if f then
			for _, f in pairs(f) do
				if f then self:UpdateHealthBar(f.bar, self:GetUnit(f)) end
			end
		end
	end

end

function oRAOPlayerTarget:SetNrPlayers( nr )
	self.db.profile.nrpts = nr

	for i = ( nr + 1 ), 10 do
		if self.ptf and self.ptf[i] then self.ptf[i].unit = nil end
		if self.pttf and self.pttf[i] then self.pttf[i].unit = nil end
		if self.ptttf and self.ptttf[i] then self.ptttf[i].unit = nil end
	end

	-- Make sure to update the tablet in case it's detached.
	self:TriggerEvent("oRA_UpdateConfigGUI")
	self:oRA_PlayerTargetUpdate()
end

------------------------------
--     Utility Functions    --
------------------------------

function oRAOPlayerTarget:SavePosition()
	local f = self.mainframe
	if not f then return end

	local s = f:GetEffectiveScale()
		
	self.db.profile.posx = f:GetLeft() * s
	self.db.profile.posy = f:GetTop() * s	
end


function oRAOPlayerTarget:RestorePosition()
	local x = self.db.profile.posx
	local y = self.db.profile.posy

	if not x or not y then return end

	local f = self.mainframe
	if not f then return end
	local s = f:GetEffectiveScale()

	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x / s, y / s)
end


function oRAOPlayerTarget:SetupFrames()
	local f = CreateFrame("Frame", nil, UIParent)
	f:Hide()
	f:SetMovable(true)
	f:SetScript("OnUpdate", function() self:OnUpdate() end)
	f:SetWidth(100)
	f:SetHeight(100)
	f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	f:SetAlpha(self.db.profile.alpha)
	f:SetScale(self.db.profile.scale)

	f.update = 0

	self.mainframe = f
	self:RestorePosition()
end


function oRAOPlayerTarget:CreateUnitFrame( parent, id, type )
	-- Main frame
	-- local f = CreateFrame("Button", "oRA_PlayerTargetFrames_" .. type .. id, parent)
	local f = CreateFrame("Button", nil, parent)
	f:Hide()
	f:EnableMouse(true)
	f:SetMovable(true)
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnEnter", function() self:OnEnter() end)
	f:SetScript("OnLeave", function() GameTooltip:Hide() end)
	f:SetScript("OnClick", function() self:OnClick() end)
	f:SetScript("OnDragStart", function() if IsAltKeyDown() then parent:StartMoving() end end)
	f:SetScript("OnDragStop", function() parent:StopMovingOrSizing() self:SavePosition() end)

	-- Tank Statusbar
	f.bar = CreateFrame("StatusBar", nil, f)
	f.bar:SetMinMaxValues(0,100)

	-- Tank Statusbar background texture, visible when the bar depleats
	f.bar.texture = f.bar:CreateTexture(nil, "BORDER")
	f.bar.texture:SetVertexColor(1, 0, 0, 0.5)

	-- Tank Statusbar text
	f.bar.text = f.bar:CreateFontString(nil, "OVERLAY")
	f.bar.text:SetFontObject(GameFontHighlightSmall)
	f.bar.text:SetJustifyH("RIGHT")

	-- Tank Number
	f.number = f.bar:CreateFontString(nil, "OVERLAY")
	f.number:SetFontObject(GameFontHighlightSmall)
	f.number:SetJustifyH("RIGHT")

	-- Tank Name
	f.name = f.bar:CreateFontString(nil, "OVERLAY")
	f.name:SetFontObject(GameFontHighlightSmall)
	f.name:SetJustifyH("LEFT")

	-- Raid Icons
	f.raidicon = f.bar:CreateTexture(nil, "OVERLAY")
	f.raidicon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	f.raidicon:Hide()

	-- Set static stuff and style
	f.number:SetText(id..".")
	f.type = type
	f:SetID(id)

	self:SetStyle(f)

	return f
end

function oRAOPlayerTarget:GetPosition( f )
	local relframe, relx, rely
	
	if self.db.profile.layout == L["Horizontal"] then -- HORIZONTAL POSITIONING
		-- default positioning
		relframe = self.mainframe
		relx = 136 * (f:GetID() - 1)
		if self.db.profile.reverse then relx = relx * -1 end
		rely = 0
		
		if f.type == "ptt" and self.db.profile.showpt then
			relframe = self.ptf[f:GetID()]
			relx = 0
			rely = -21
			if self.db.profile.growup then rely = 21 end
		end
		
		-- same deal for pttt adjust if ptt or pt is shown
		if f.type == "pttt" then
			if self.db.profile.showptt then
				relframe = self.pttf[f:GetID()]
				relx = 0
				rely = -21
				if self.db.profile.growup then rely = 21 end
			elseif self.db.profile.showpt then
				relframe = self.ptf[f:GetID()]
				relx = 0
				rely = -21
				if self.db.profile.growup then rely = 21 end
			end
		end
					
	else -- VERTICAL POSITIONING
		-- default positioning
		relframe = self.mainframe
		relx = 0
		if self.db.profile.growup then
			rely = 21 * (f:GetID() - 1)
		else 
			rely = -21 * (f:GetID() - 1)
		end	
		
	  -- adjust positioning for ptt if pt is shown
		if f.type == "ptt" and self.db.profile.showpt then
			relframe = self.ptf[f:GetID()]
			relx = 120
			if self.db.profile.reverse then relx = -120 end
			rely = 0
		end
	
		-- same deal for pttt adjust if ptt or pt is shown
		if f.type == "pttt" then
			if self.db.profile.showptt then
				relframe = self.pttf[f:GetID()]
				relx = 120
				if self.db.profile.reverse then relx = -120 end
				rely = 0
			elseif self.db.profile.showpt then
				relframe = self.ptf[f:GetID()]
				relx = 120
				if self.db.profile.reverse then relx = -120 end
				rely = 0			
			end
		end	
	end
	return relframe, relx, rely
end


function oRAOPlayerTarget:SetStyle(f)
	local relframe, relx, rely = self:GetPosition(f)
	
	self:SetWHP(f, 120, 21, "TOPLEFT", relframe, "TOPLEFT", relx , rely)

	f:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})

	if self.db.profile.backdrop then
		f:SetBackdropColor(0, 0, 0, .5)
	else 
		f:SetBackdropColor(0, 0, 0, 0)
	end
	
	f.bar:SetStatusBarTexture(self.core.bartextures[self.core.db.profile.bartexture])
	f.bar.texture:SetTexture(self.core.bartextures[self.core.db.profile.bartexture])
	f.bar.texture:SetVertexColor(.5, .5, .5, .5)
	
	self:SetWHP(f.bar, 112, 16, "LEFT", f, "LEFT", 4, 0)
	self:SetWHP(f.bar.texture, 112, 16, "CENTER", f.bar, "CENTER", 0, 0)
	if self.db.profile.reverse then
		f.number:SetJustifyH("LEFT")
	else
		f.number:SetJustifyH("RIGHT")
	end
	
	self:SetWHP(f.number, 32, 14, self.db.profile.reverse and "LEFT" or "RIGHT", f, self.db.profile.reverse and "RIGHT" or "LEFT", 0, 0)

	if not self.db.profile.numbers then
		f.number:Hide()
	else
		if f.type == "pt" and self.db.profile.showpt then
			f.number:Show()
		elseif f.type == "ptt" and not self.db.profile.showpt and self.db.profile.showptt then
			f.number:Show()
		elseif f.type == "pttt" and not self.db.profile.showpt and not self.db.profile.showptt and self.db.profile.showpttt then
			f.number:Show()
		else
			f.number:Hide()
		end
	end

	self:SetWHP(f.raidicon, 14, 14, "LEFT", f.bar, "LEFT", 1, 0)		
	self:SetWHP(f.name, 62, 14, "LEFT", f.bar, "LEFT", 18, 0)
	self:SetWHP(f.bar.text, 32, 14, "RIGHT", f.bar, "RIGHT", 0, 0)

end


function oRAOPlayerTarget:SetWHP(f, width, height, p1, relative, p2, x, y)
	if not f then return end

	f:SetWidth(width)
	f:SetHeight(height)

	if p1 then
		f:ClearAllPoints()
		f:SetPoint(p1, relative, p2, x, y)
	end
end


function oRAOPlayerTarget:GetUnit(f, click)
	if not f or not f.type then return end

	if not click then
		if f.type == "pt" then return f.unit end
		if f.type == "ptt" then return f.unit .. "target" end
		if f.type == "pttt" then return f.unit .. "targettarget" end
	else
		local c
		if f.type == "pt" then c = self.db.profile.ctplayer end
		if f.type == "ptt" then c = self.db.profile.cttarget end
		if f.type == "pttt" then c = self.db.profile.cttargettarget end
		if c == L["Player"] then return f.unit end
		if c == L["Target"] then return f.unit .. "target" end
		if c == L["TargetTarget"] then return f.unit .. "targettarget" end
	end
end


function oRAOPlayerTarget:UpdateFrames(f)
	for _, f in pairs(f) do
		if f.unit then
			local unit = self:GetUnit(f)

			if UnitExists(unit) then
				f.name:SetText(UnitName(unit))

				self:UpdateHealthBar(f.bar, unit)

				if self.db.profile.raidicon then
					self:UpdateRaidIcon(f, unit)
				end

				if f.type == "pt" and self.db.profile.coloraggro then
					if UnitExists( unit .. "target" ) then
						f.name:SetTextColor( 1, 0.5, 0.25, 1 )
						if UnitExists( unit .. "targettarget") then
							if UnitIsUnit(unit, unit .. "targettarget") then
								f.name:SetTextColor(0.5, 1, 0.5, 1)
							else
								f.name:SetTextColor(1, 0, 0, 1)
							end
						end
					else
						f.name:SetTextColor( 1, 1, 1, 1)
					end
				else 
					if UnitIsEnemy(unit, "player") then f.name:SetTextColor( 1, 0, 0, 1)
					else f.name:SetTextColor( 1, 1, 1, 1) end
				end
				
				if UnitIsUnit( unit, "target") and self.db.profile.highlight then
					f:SetBackdropColor(1, .84, 0, 1 )
				elseif self.db.profile.backdrop then
					f:SetBackdropColor(0, 0, 0, .5)
				else
					f:SetBackdropColor(0, 0, 0, 0)
				end
				
				f:Show()
			else
				f:Hide()
			end

		else
			f:Hide()
		end
	end
end


function oRAOPlayerTarget:UpdateHealthBar(bar, unit)
	if not unit then return end
	local cur, max = UnitHealth(unit) or 0, UnitHealthMax(unit) or 0
	local perc = cur / max

	bar:SetMinMaxValues(0, max)
	
	if self.db.profile.inverse then
		bar:SetValue(max - cur)
	else
		bar:SetValue(cur)
	end

	if self.db.profile.classcolor then
		if not UnitIsEnemy(unit, "player") then 
			local _, class = UnitClass( unit )
			local _, r,g,b = paintchips:GetRGBPercent( class )
			bar:SetStatusBarColor(r,g,b)
		else
			local _, r,g,b = paintchips:GetRGBPercent( self.db.profile.enemycolor )
			bar:SetStatusBarColor(r,g,b)
		end
	else
		bar:SetStatusBarColor(self:GetHealthBarColor(perc))
	end
	
	if self.db.profile.deficit then
		local val = max - cur
		if val > 1000 then
			val = ceil(val/100)/10 .. "k"
		elseif val == 0 then
			val = ""
		end
		
		bar.text:SetText(val)
	else
		bar.text:SetText(ceil(perc * 100) .. "%")
	end

	bar:Show()
end


function oRAOPlayerTarget:GetHealthBarColor(perc)
	local r, g

	if perc > 0.5 then
		r = (1.0 - perc) * 2
		g = 1.0
	else
		r = 1.0
		g = perc * 2
	end

	return r, g, 0
end


function oRAOPlayerTarget:UpdateRaidIcon(f, unit)
	local icon = GetRaidTargetIndex(unit)

	if icon then
		SetRaidTargetIconTexture(f.raidicon, icon)
		f.raidicon:Show()
	else
		f.raidicon:Hide()
	end
end

-------------------------------
--    Key Binding Handlers   --
-------------------------------

function oRAOPlayerTarget:BindingAssist( nr )
	if self.ptf and self.ptf[nr] and self.ptf[nr].unit then
		local unit = self:GetUnit( self.ptf[nr] )
		if unit and UnitExists( unit .."target") then
			AssistUnit(unit)
		end
	end
end

function oRAOPlayerTarget:BindingTarget( nr )
	if self.ptf and self.ptf[nr] and self.ptf[nr].unit then
		local unit = self:GetUnit( self.ptf[nr] )
		if unit then 
			TargetUnit(unit)
		end
	end
end

-------------------------------
--   Frame Script Functions  --
-------------------------------

function oRAOPlayerTarget:OnUpdate()
	this.update = this.update + arg1

	if this.update >= 0.3 then
		if self.db.profile.showpt then self:UpdateFrames(self.ptf) end
		if self.db.profile.showptt then self:UpdateFrames(self.pttf) end
		if self.db.profile.showpttt then self:UpdateFrames(self.ptttf) end

		this.update = 0
	end
end


function oRAOPlayerTarget:OnEnter()
	if not self.db.profile.tooltips then return end
	local unit = self:GetUnit(this)

	GameTooltip_SetDefaultAnchor(GameTooltip, this)

	if unit and GameTooltip:SetUnit(unit) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME
	else
		this.updateTooltip = nil
	end
end


function oRAOPlayerTarget:OnClick()
	local unit = self:GetUnit(this,true)
	if self.db.profile.clickcast and oRA_PlayerTargetFramesCustomClick then
		oRA_PlayerTargetFramesCustomClick(arg1, unit)
	elseif UnitExists(unit) then
		TargetUnit(unit)
	end
	-- this following piece of code is specifically for attack on assist.
--	if unit == this.unit .. "target" and UnitExists( this.unit ) then
--			AssistUnit("player")
--	end

end
 
---------------------------
-- Setting and Removing  --
---------------------------


function oRAOPlayerTarget:Set( num, name )
	if not num then return end
	if not name or name == "" then name = UnitName("target") end
	
	-- lower the name and upper the first letter, not for chinese and korean though
	if GetLocale() ~= "zhTW" and GetLocale() ~= "zhCN" and GetLocale() ~= "koKR" then
		local _, len = string.find(name, "[%z\1-\127\194-\244][\128-\191]*")
		name = string.upper(string.sub(name, 1, len)) .. string.lower(string.sub(name, len + 1))
	end

	if not self:IsValidRequest(name, true) then return end

	for k,v in pairs( self.db.profile.playertable ) do
		if v == name then self.db.profile.playertable[k] = nil end
	end
	
	self.db.profile.playertable[num] = name
	self:UpdateConsole()
	self:oRA_PlayerTargetUpdate()
	
	self:Print(L["Set player: "] .. "[".. num .. "] [" .. name .."]")
end

function oRAOPlayerTarget:Remove( num )
	if not num then return end
	num = tonumber(num)
	local name = self.db.profile.playertable[num]
	if not name then return end
	self.db.profile.playertable[num] = nil
	self:UpdateConsole()
	self:oRA_PlayerTargetUpdate()
	self:Print(L["Removed player: "] .. num .." "..name )
end

function oRAOPlayerTarget:TooltipClick( num )
	if not num then return end
	num = tonumber(num)
	local name = UnitName("target")
	if self.db.profile.playertable[num] then
		if not name then self:Remove(num)
		else self:Set( num, name ) end	
	else
		if name then self:Set( num, name ) end
	end
end

function oRAOPlayerTarget:UpdateConsole()
	for k = 1, 10, 1 do
				self.core.consoleOptions.args[L["pt"]].args[L["remove"]].args[tostring(k)].name = tostring(k).."."
				self.core.consoleOptions.args[L["pt"]].args[L["set"]].args[tostring(k)].name = tostring(k).."."
	end
	for k,v in pairs(self.db.profile.playertable) do
		if self:IsValidRequest(v,true) then
				self.core.consoleOptions.args[L["pt"]].args[L["remove"]].args[tostring(k)].name = tostring(k)..". "..v
				self.core.consoleOptions.args[L["pt"]].args[L["set"]].args[tostring(k)].name = tostring(k)..". "..v
		end
	end
end

------------------------------
--      Tooltip Updating    --
------------------------------

function oRAOPlayerTarget:OnTooltipUpdate()
	local cat = tablet:AddCategory("columns", 2, "text", "#", "justify", "LEFT", "text2", L["PlayerTarget"], "justify2", "LEFT", "child_justify", "LEFT", "child_justify2", "LEFT" )
	local p 
	for k = 1, self.db.profile.nrpts, 1 do
		p = self.db.profile.playertable[k]
		if p then
			if self:IsValidRequest( p, true ) then
				local unit = self.core.roster:GetUnitIDFromName(p)
				local _, class = UnitClass( unit )
				cat:AddLine( "text", tostring(k)..". ", "text2", "|cff"..paintchips:GetHex(class) .. p.."|r", "func", self.TooltipClick, "arg1", self, "arg2", k)
			else
				cat:AddLine( "text", tostring(k)..". ", "text2", "|cffcccccc<"..p..">|r", "func", self.TooltipClick, "arg1", self, "arg2", k)
			end
		else
			cat:AddLine( "text", tostring(k)..". ", "text2", "|cffcccccc"..L["<Not Assigned>"].."|r", "func", self.TooltipClick, "arg1", self, "arg2", k)
		end
	end
end

