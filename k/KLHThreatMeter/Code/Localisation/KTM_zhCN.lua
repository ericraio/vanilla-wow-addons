
klhtm.string.data["zhCN"] =
{
	["spell"] = 
	{
		["heroicstrike"] = "英勇打击",
		["maul"] = "槌击",
		["swipe"] = "挥击",
		["shieldslam"] = "盾牌猛击",
		["revenge"] = "复仇",
		["shieldbash"] = "盾击",
		["sunder"] = "破甲攻击",
		["feint"] = "佯攻",
		["cower"] = "畏缩",
		["taunt"] = "嘲讽",
		["growl"] = "低吼",
		["vanish"] = "消失",
		["frostbolt"] = "寒冰箭",
		["fireball"] = "火球术",
		["arcanemissiles"] = "奥术飞弹",
		["scorch"] = "灼烧",
		
		-- Items / Buffs:
		["burningadrenaline"] = "燃烧刺激",
		["arcaneshroud"] = "Arcane Shroud",
		["reducethreat"] = "Reduce Threat",
		["twinteleport"] = "Twin Teleport", 
		
		-- Spell Sets
		-- warlock descruction
		["shadowbolt"] = "暗影箭",
		["immolate"] = "献祭",
		["conflagrate"] = "燃烧",
		["searingpain"] = "灼热之痛",
		["rainoffire"] = "火焰之雨",
		["soulfire"] = "灵魂之火",
		["shadowburn"] = "暗影灼烧",
		["hellfire"] = "地狱烈焰",
		
		-- mage offensive arcane
		["arcaneexplosion"] = "魔爆术",
		["counterspell"] = "法术反制",
		
		-- priest shadow
		["mindflay"] = "精神鞭笞",
		["devouringplague"] = "吸血鬼的拥抱",
		["shadowwordpain"] = "暗言术：痛",
		["mindblast"] = "心灵震爆",
		["manaburn"] = "法力燃烧",
	},
	["power"] = 
	{
		["mana"] = "法力",
		["rage"] = "怒气",
		["energy"] = "能量",
	},
	["threatsource"] = 
	{
		["powergain"] = "获得能力",
		["total"] = "总共",
		["special"] = "技能",
		["healing"] = "治疗",
		["dot"] = "Dots",
		["threatwipe"] = "仇恨清除",
		["damageshield"] = "伤害护盾",
		["whitedamage"] = "普通攻击",
	},
	["talent"] = 
	{
		["defiance"] = "挑衅",
		["impale"] = "穿刺",
		["silentresolve"] = "无声消退",
		["shadowaffinity"] = "暗影亲和",
		["druidsubtlety"] = "微妙",
		["feralinstinct"] = "野性本能",
		["ferocity"] = "凶暴",
		["savagefury"] = "野蛮暴怒",
		["masterdemonologist"] = "恶魔学识大师",
		["arcanesubtlety"] = "奥术精妙",
		["righteousfury"] = "强化愤怒圣印",
	},
	["threatmod"] = 
	{
		["tranquilair"] = "宁静之风图腾",
		["salvation"] = "拯救祝福",
		["battlestance"] = "战斗姿态",
		["defensivestance"] = "防御姿态",
		["berserkerstance"] = "狂暴姿态",
		["defiance"] = "挑衅",
		["basevalue"] = "基础值",
		["bearform"] = "熊形态",	
		["glovethreatenchant"] = "+Threat Enchant to Gloves",
		["backthreatenchant"] = "-Threat Enchant to Back",
	},
	["class"] = 
	{
		["warrior"] = "战士",
		["druid"] = "德鲁伊",
		["shaman"] = "萨满",
		["rogue"] = "盗贼",
		["hunter"] = "猎人",
		["warlock"] = "术士",
		["mage"] = "法师",
		["paladin"] = "圣骑士",
		["priest"] = "牧师",
	},
	["sets"] = 
	{
		["bloodfang"] = "血牙",
		["nemesis"] = "复仇",
		["netherwind"] = "灵风",
		["might"] = "力量",
		["arcanist"] = "奥术师",
	},
	["boss"] = 
	{
		["name"] = 
		{
			["onyxia"] = "奥妮克希亚",
			["ebonroc"] = "埃博诺克",
			["razorgore"] = "狂野的拉佐格尔",
		},
		["spell"] = 
		{
			["knockaway"] = "击飞",
			["wingbuffet"] = "龙翼打击",
			["uppercut"] = "上钩拳",
		},
		["speech"] = 
		{
			["razorphase2"] = "在宝珠的控制力消失之前逃走",
			["onyxiaphase3"] = "看起来需要再给你一次教训",
		},
	},
	["misc"] = 
	{
		["imp"] = "小鬼", -- UnitCreatureFamily("pet")
		["spellrank"] = "等级 (%d+)", -- second value of GetSpellName(x, "spell")
		["aggrogain"] = "获得Aggro",
	},
	
	--[[
	No longer used: R17
	
	["combatlog"] = 
	{
		
		["whiteattackhit"] = "你击中(.+)造成(%d+)点伤害。", -- COMBATHITSELFOTHER and COMBATHITSCHOOLSELFOTHER
		["whiteattackcrit"] = "你对(.+)造成(%d+)的致命一击伤害。", -- COMBATHITCRITSELFOTHER and COMBATHITCRITSCHOOLSELFOTHER
		["damageshield"] = "你将(%d+)点(.+)伤害反弹给(.+)。", -- DAMAGESHIELDSELFOTHER
		["abilityhit"] = "你的(.+)击中(.+)造成(%d+)点伤害。", -- SPELLLOGSELFOTHER
		["abilitycrit"] = "你的(.+)对(.+)造成(%d+)的致命一击伤害。", -- SPELLLOGCRITSELFOTHER
		["spellhit"] = "你的(.+)击中(.+)造成(%d+)点(.+)伤害。", --SPELLLOGSCHOOLSELFOTHER
		["spellcrit"] = "你的(.+)致命一击对(.+)造成(%d+)点(.+)伤害。", -- SPELLLOGCRITSCHOOLSELFOTHER
		["perform"] = "你对(.+)使用(.+)。", -- SPELLPERFORMGOSELFTARGETTED
		["dot"] = "你的(.+)使(.+)受到了(%d+)点(.+)伤害。", -- PERIODICAURADAMAGESELFOTHER
		["yourhotonother"] = "(.+)获得(%d+)点生命值 （你的(.+)）。", -- PERIODICAURAHEALSELFOTHER
		["othershotonyou"] = "你获得(%d+)点生命值（(.+)的(.+)）。", -- PERIODICAURAHEALOTHERSELF
		["hotonself"] = "你因(.+)而获得了(%d+)点生命值。", -- PERIODICAURAHEALSELFSELF
		["powergain"] = "你从(.+)获得了(%d+)点(.+)。", -- POWERGAINSELFSELF
		["healcritonself"] = "你的(.+)对你产生极效治疗效果，恢复了(%d+)点生命值。", -- HEALEDCRITSELFSELF
		["healcritonother"] = "你的(.+)对(.+)产生极效治疗效果，恢复了(%d+)点生命值。", -- HEALEDCRITSELFOTHER 
		["healhitonself"] = "你的(.+)治疗了你(%d+)点生命值。", -- HEALEDSELFSELF
		["healhitonother"] = "你的(.+)治疗了(.+[^%d])(%d+)点生命值。", -- HEALEDSELFOTHER
		["enemyspellhit"] = "(.+)的(.+)击中你造成(%d+)点伤害。", -- SPELLLOGOTHERSELF
		["buffstart"] = "你获得了(.+)的效果。", -- AURAADDEDSELFHELPFUL
		["debuffstart"] = "你受到(.+)效果的影响。", -- AURAADDEDSELFHARMFUL
		["buffend"] = "(.+)效果从你身上消失了。", -- AURAREMOVEDSELF
		["spellcast"] = "你对(.+)施放了(.+)。", -- SPELLCASTGOSELFTARGETTED
	},
	
	]]
	
	["gui"] = 
	{
		["raidlabel"] = "团队仇恨",
		["raidshortlabel"] = "团队",
		["column"] = 
		{
			["name"] = "团队",
			["hits"] = "命中",
			["damage"] = "伤害",
			["threat"] = "仇恨",
			["%max"] = "%Max",
		}
	},
	["print"] = 
	{
		["main"] = 
		{
			["startupmessage"] = "KLHThreatMeter Release |cff33ff33%s|r Revision |cff33ff33%s|r 已经加载。 输入 |cffffff00/ktm|r 取得更多帮助。",
		},
		["data"] = 
		{
			["abilityrank"] = "你的 %s 技能等级是 %s。",
			["globalthreat"] = "你的总体仇恨修正值是 %s。",
			["globalthreatmod"] = "%s 给予你 %s。",
			["multiplier"] = "作为一个%s，你的%s仇恨修正值是 %s。",
			["damage"] = "伤害",
			["shadowspell"] = "暗影术",
			["arcanespell"] = "奥术",
			["holyspell"] = "神圣法术",
			["setactive"] = "是否穿着 %s 套装 %d 件? ... %s。",
			["true"] = "是",
			["false"] = "否",
			["healing"] = "你的治疗造成了 %s 仇恨（被总体修正值修正前）。",
			["talentpoint"] = "你有 %d 点天赋值在 %s。",
			["talent"] = "发现 %d 点 %s 天赋。",
		},
		["combat"] = 
		{
			["razorphase2"] = "团队仇恨已经被拉佐格尔清除，现在谁是主要目标。",
			["onyxiaphase3"] = "团队仇恨已经被奥妮克希亚清除。",
		},
		["network"] = 
		{
			["newmttargetnil"] = "无法确认主要目标 %s, 因为 %s 没有目标。",
			["newmttargetmismatch"] = "%s 设定主要目标为 %s，但是他的主要目标是 %s， 将会使用他的主要目标替代，请注意。",
			["threatreset"] = "团队仇恨列表已经被 %s 清除。",
			["newmt"] = "主要目标已经被更改为'%s'，被 %s 改变。",
			["mtclear"] = "主要目标已经被 %s 清除。",
			["knockbackstart"] = "击飞侦测已经被 %s 启用。",
			["knockbackstop"] = "击飞侦测已经被 %s 停用。",
			["aggrogain"] = "%s 报告，在产生了 %d 仇恨后获得Aggro。",
			["aggroloss"] = "%s 报告，%d 仇恨失去了Aggro。",
			["knockback"] = "%s 报告被击飞，他的仇恨值下降到 %d 。",
			["knockbackstring"] = "%s 报告了这个击飞的文字：'%s'。",
			["upgraderequest"] = "%s 请你升级KLHThreatMeter到 %s 版本。你目前使用的是 %s。",
			["remoteoldversion"] = "%s 正在使用KLHThreatMeter的 %s 版本。请告诉他升级到 %s。",
			["knockbackvaluechange"] = "|cffffff00%s|r 设定了 %s 的 |cffffff00%s|r 仇恨减少到 |cffffff00%d%%|r。",
			["raidpermission"] = "只有队长才能这样做。",
			["needmastertarget"] = "你必须设置一个主目标。",
			["knockbackinactive"] = "击飞侦测在团队中被关闭。",
			["versionrequest"] = "查询团队内的版本信息，将在3秒钟后报告。",
			["versionrecent"] = "这些人使用版本 %s: { ",
			["versionold"] = "这些人使用旧版本: { ",
			["versionnone"] = "这些人没有使用KLHThreatMeter，或者不在正确的CTRA频道: { ",	
		}			
	}
}	
