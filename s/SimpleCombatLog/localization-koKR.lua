if GetLocale() ~= "koKR" then return end

local loc = {}

loc.core = {

	-- Strings which may appear in the combat log.
	["Melee"] = "근접",
	["Damage Shields"] = "피해 보호막",
	["All Items"] = "모든 요소",
	["You"] = "당신",
	

	-- Strings for slash commands.
	["Welcome"] = {
		"명령어 /scl.",
		"특정 대화창을 설정하려면, 대화창탭을 Alt+우클릭 하면 해당 대화창의 메뉴가 표시 됩니다.",
	},	
	["CmdHelpDesc"] = "도움말 보기",
	["CmdResetDesc"] = "모든 설정을 초기화 하고 대화창2에 대한 기본 테마를 로드합니다.",
	["CmdShowDesc"] = "대화창의 메뉴 표시.",
	
	["MsgInitial"] = "대화창2에 대한 기본 설정 로딩.",

	-- missType
	missType = {
		resist = "저항",
		immune = "면역",
		block = "막음",
		deflect = "빗맞힘",
		dodge = "회피",
		evade = "피함",
		absorb = "흡수",
		miss = "피함",
		parry = "방어",
		reflect = "반사",
	},
	
	-- damageType
	damageType = {
		drown = "호흡",
		fall = "낙하",
		exhaust = "소진",
		fire = "화염",
		lava = "용암",
		slime = "독성",
	},	

}

loc.gui = {
	menuTitle = "SCL: 대화창%d 설정",
	colorSkill = "속성에 따른 스킬 색상",
	colorEvent = "이벤트에 따른 메세지 색상",
	greaterResize = "최대화",
	suppress = "전투 로그 차단",
	clearSettings = "모든 설정 삭제",
	
	tooltip_colorSkill = "스킬명을 속성색상 설정에 따라 색상화합니다.",
	tooltip_colorEvent = "메세지를 브리자드 대화 설정에서 변경 할수 있는 이벤트에 따라 색상화 합니다.\n이벤트 이름에 따른 추가 정보를 얻을 때 유용합니다.\n예를 들면: '우호적대상의 죽음'과 '적대적대상의 죽음'을 각각 다르게 설정합니다.",
	tooltip_greaterResize = "Enables greater resize of this chat frame, so you can make a very large / small chatframe for displaying long / short messages.",
	tooltip_suppress = "기본 브리자드 전투 로그를 차단합니다.",
	tooltip_clearSettings = "Clear all settings of this chat frame EXCEPT 'Colors' and 'Formats', for these two, use the 'Restore to Default' option in their sub menu.",

}

loc.filter = {
	["Type Filters"] = "타입 필터들",
	["Name Menu Title"] = "|cffeda55f%s|r에 대한 이름 필터들",
	["Filters"] = "필터들",	
	
	["AllFilter"] = "*",	
	hit = "타격",
	heal = "치유",
	miss = "피함",	
	cast = "시전",
	gain = "획득",
	drain = "흡수",
	leech = "소모",
	dispel = "디스펠",
	buff = "강화주문",
	debuff = "약화주문",
	fade = "사라짐",
	interrupt = "차단",
	death = "죽음",
	environment = "환경",
	extraattack = "추가 공격",
	enchant = "마법부여",

	player = "플레이어",
	skill = "스킬",
	party = "파티",
	raid = "공격대",	
	pet = "소환수",
	target = "대상",
	targettarget = "대상의 대상",
	other = '기타',
	
	source = "근원",
	victim = "피해",
	
	typeTooltip = {
		AllFilter = "체크 / 해제 : 모든 타입 필터에 적용됩니다.",
		hit = "타격, 치명타, 도트데미지를 표시합니다.",
		heal = "치유, 치유 극대, 도트힐을 표시합니다.",
		miss = "피함, 회피, 막음, 빗맞힘, 면역, 방어, 피함, 저항, 반사, 흡수를 표시합니다.",
		cast = "'시전 시작', '시전' 과 '사용'을 표시합니다.",
		gain = "예: Cat gains 100 happiness from Rophy's Feed Pet Effect; Rophy gains 50 Mana from Rophy's Blessing of Wisdom.",
		drain = "예: Rophy's Viper Sting drains 50 Mana from you.",
		leech = "예: Your Dark Pact drains 100 Mana from Imp. You gain 100 Mana.",
		dispel = "디스펠 성공과 실패를 표시합니다.",	
		buff = "예: You gain Blessing of Wisdoms from Rophy.",
		debuff = "예: You are afflicted by Corruption.",
		fade = "버프 혹은 디버프 사라짐.",
		interrupt = "예: Rophy interrupts your Greater Heal.",
		death = "Note : 토템 파괴도 죽음 메세지로 분류됩니다.",
		environment = "환경 피해 - 호흡, 낙하, 소진, 화염, 용암, 독성을 표시합니다.",
		extraattack = "예: You gain 2 extra attacks through Wind Fury.",
		enchant = "예: Rophy casts Rockbiter 7 on Rophy's Dagger.",
	},		
	
}

loc.event = {
	["Events"] = "이벤트들",
	
	tooltip_Events = "SCL에서 사용할 이벤트를 선택합니다. 브리자드 대화창 이벤트 설정에 의존합니다.",
}

loc.color = {

	physical = "물리",		
	holy = "신성",	
	fire = "화염",		
	nature = "자연",	
	frost = "냉기",	
	shadow = "암흑",
	arcane = "비전",

	player = "플레이어",
	skill = "스킬",
	party = "파티",
	raid = "공격대",	
	pet = "소환수",
	target = "대상",
	targettarget = "대상의 대상",
	other = '기타',

	["Colors"] = "색상",

	hit = "타격",
	heal = "치유",
	miss = "피함",	
	buff = "강화주문",
	debuff = "약화주문",
	
	["Restore default colors"] = "기본 색상으로 초기화",	
}

loc.format = {
	["Formats"] = "형식",
	["Restore default formats"] = "기본 형식으로 초기화",	
}

loc.watch = {
	["Watches"] = "감시",
	
	tooltip_Watches = "감시 목록에 사용자 키워드를 추가 할 수 있습니다. 키워드가 포함된 메세지가 표시 될 것입니다.", 
	
	title = {
		source = "근원",
		victim = "피해",
		skill = "스킬",
	},
	
	tooltip = {
		source = "케릭터명(case sensitive)을 입력하세요. '근원'에 이름이 포함된 메세지가 표시될 것 입니다.",
		victim = "케릭터명(case sensitive)을 입력하세요. '피해'에 이름이 포함된 메세지를 표시할 것 입니다.",
		skill = "스킬명(case sensitive)을 입력하세요. 스킬을 포함한 메세지가 표시될 것 입니다.",
	},
	
	add = {
		source = "새 근원 추가",
		victim = "새로운 피해 추가",
		skill = "새로운 스킬 추가",
	}
}

loc.theme = {
	["Load Theme"] = "테마 불러오기",
	["Save Theme"] = "테마 저장하기",
	["Delete Theme"] = "테마 삭제",
	["Save As"] = "새 이름으로...",
	["Delete Theme Failed"] = "테마 [%s]를 삭제할 수 없습니다.: 대화창 %s 에서 이 테마를 사용중입니다.",
	
	tooltip_LoadTheme = "해당 대화창에 테마를 읽어옵니다. 테마는 모든 케릭터와 공유합니다.",
	tooltip_SaveTheme = "해당 대화창의 테마 설정을 저장합니다. 테마는 모든 케릭터와 공유합니다.",
	tooltip_DeleteTheme = "테마를 삭제합니다. 해당 테마를 사용하는 대화창이 없을 때만 삭제 할 수 있습니다. 미리 준비된 테마를 삭제 한다면 다음 로그인에 나타납니다.",

}

-- The default formats for combat log.
-- Do NOT localize the field names, only change the format, 
--    if you want to change the sequence of tokens, use the %n$s, for example:
-- "%s hits %s for %d." --->   "%2$s lost %3$d health from the attack of %1$s."
loc.defaultFormats = {

	-- 1st group
	hit = { "[%s] %s [%s] %s%s", { 'source', 'skill', 'victim', 'amount', 'trailers' } },
	hitCrit = { "[%s] %s 치명타 [%s] *%s*%s", { 'source', 'skill', 'victim', 'amount', 'trailers' } },
	hitDOT = { "[%s] %s 도트 [%s] ~%s~%s", { 'source', 'skill', 'victim', 'amount', 'trailers' } },
	heal = { "[%s] %s 치유 [%s] %s", { 'source', 'skill', 'victim', 'amount' } },
	healCrit = { "[%s] %s 치유 극대 [%s] *%s*", { 'source', 'skill', 'victim', 'amount' } },
	healDOT = { "[%s] %s 재생 [%s] ~%s~", { 'source', 'skill', 'victim', 'amount' } },
	miss = { "[%s] %s %s [%s]", { 'source', 'skill', 'missType', 'victim' } },	
	gain = { "[%s] %s : [%s] + %s %s", { 'source', 'skill', 'victim', 'amount', 'attribute' } },
	drain = { "[%s] %s : [%s] -%s %s", { 'source', 'skill', 'victim', 'amount', 'attribute' } },
	leech = { "[%s] %s : [%s] -%s %s, [%s] +%s %s", { 'source', 'skill', 'victim', 'amount', 'attribute', 'sourceGained', 'amountGained', 'attributeGained' } },

	-- 2nd group
	buff = { '[%s] |cff00ff00++|r %s', { 'victim', 'skill' } },
	debuff = { '[%s] |cffff0000++|r %s', { 'victim', 'skill' } },	
	fade = { '[%s] -- %s', { 'victim', 'skill' } },		
	dispel = { '[%s] -- %s', { 'victim', 'skill' } },
	dispelFailed = { "[%s] 해재 [%s] %s 실패함", { 'source', 'victim', 'skill' } },			
	extraattack = { "[%s] + %s 공격 (%s)", { 'victim', 'amount', 'skill' } },	
	cast = { "[%s] %s", { 'source', 'skill' } },
	castBegin = { "[%s] 시전 %s", { 'source', 'skill' } },
	castTargeted = { "[%s] %s [%s]", { 'source', 'skill', 'victim' } },
	interrupt = { "[%s] 차단 [%s] %s", { 'source', 'victim', 'skill' } },	
	
	-- 3rd group
	environment = { "[%s] %s %s%s", { 'victim', 'damageType', 'amount', 'trailers' } },	
	create = { "[%s] 창조 %s", { 'source', 'item' } },
	death = { "죽음: [%s]", { 'victim' } },
	deathSkill = { "죽음: [%s] <- %s", { 'victim', 'skill' } },
	deathSource = { "[%s] 죽임 [%s]", { 'source', 'victim' } },
	honor = { "명예: %s", { 'amount' } },
	honorKill = { "죽임 %s %s : %s 명예", { 'sourceRank', 'source', 'amount' } },
	dishonor = { "|cffff0000불명예: %s", { 'source' } },
	experience = { "경험치: %s%s", { 'amount', 'trailers' } },
	reputation = { "평판: %s +%s", { 'faction',  'amount' } },
	reputationRank = { "평판: %s with %s", { 'rank', 'faction' } },
	reputationMinus = { "평판: %s |cffff0000-%s", { 'faction', 'amount' } },
	enchant = { "마법부여: [%s] %s -> [%s] %s", { 'source', 'skill', 'victim', 'item' } },
	feedpet = { "먹이주기 [%s] <- %s", { 'owner', 'food' } },
	fail = { "%s 실패: %s", { 'skill', 'reason' } },
	durability = { "%s %s : %s의 %s 파괴됨", { 'source', 'skill', 'victim', 'item' } },
	
	-- Trailers don't need the field names, they are inputed manually.
	crushing =  { "(강타)", {} },
	glancing =  { "(빗맞힘)", {} },
	absorb =  { "(흡수%s)", { 'amountAbsorb' } },
	resist =  { "(저항%s)", { 'amountResist' } },
	block =  { "(방어%s)", { 'amountBlock' } },
	vulnerable =  { "(상처%s)", { 'amountVulnerable' } },	
	expSource = { "(%s)", { 'source' } }, 
	expBonus = { "(%s%s)", { 'bonusType', 'bonusAmount' } },
	expGroup = { "(길드+%s)", { 'amountGroupBonus' } },
	expRaid = { "(공격대-%s)", { 'amountRaidPenalty' } },
	
}

SimpleCombatLog:UpdateLocales(loc)
loc = nil -- nil out to save memory.
