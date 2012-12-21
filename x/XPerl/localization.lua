
-- Localisation file

XPerl_ProductName	= "|cFFD00000X-Perl|r UnitFrames"
XPerl_Author		= "|cFFFF8080Zek|r"
XPerl_Description       = XPerl_ProductName.." by "..XPerl_Author
XPerl_VersionNumber     = GetAddOnMetadata("XPerl", "Version")
XPerl_Version		= XPerl_Description.." - "..XPerl_VersionNumber
XPerl_LongDescription	= "UnitFrame replacement for new look Player, Pet, Party, Target, Target's Target, Raid"
XPerl_ModMenuIcon	= "Interface\\Icons\\INV_Misc_Gem_Pearl_02"

XPERL_COMMS_PREFIX	= "X-Perl"
XPERL_MINIMAP_HELP1	= "|c00FFFFFFLeft click|r for Options (and to unlock frames)"
XPERL_MINIMAP_HELP2	= "|c00FFFFFFRight click|r to drag this icon"

-- Class name localization is not too important. The only time these strings
-- are used is when the raid frame titles need to be shown when in class sort
-- mode AND when no players of that class have been seen. X-Perl builds an
-- internal list of WoW localised class names as they are encountered. The WoW
-- api function UnitClass returns both the localized and english class name.
XPERL_LOC_CLASS_WARRIOR	= "Warrior"
XPERL_LOC_CLASS_MAGE	= "Mage"
XPERL_LOC_CLASS_ROGUE	= "Rogue"
XPERL_LOC_CLASS_DRUID	= "Druid"
XPERL_LOC_CLASS_HUNTER	= "Hunter"
XPERL_LOC_CLASS_SHAMAN	= "Shaman"
XPERL_LOC_CLASS_PRIEST	= "Priest"
XPERL_LOC_CLASS_WARLOCK	= "Warlock"
XPERL_LOC_CLASS_PALADIN	= "Paladin"
XPERL_LOC_CLASS_PETS	= "Pets"
XPERL_TYPE_NOT_SPECIFIED = "Not specified"
XPERL_TYPE_CIVILIAN	= "Civilian"
XPERL_TYPE_PET		= "Pet"
XPERL_TYPE_BOSS		= "Boss"
XPERL_TYPE_RAREPLUS	= "Rare+"
XPERL_TYPE_ELITE	= "Elite"
XPERL_TYPE_RARE		= "Rare"

XPERL_SPELL_SUNDER	= "Sunder Armor"
XPERL_SPELL_SHADOWV	= "Shadow Vulnerability"
XPERL_SPELL_FIREV	= "Fire Vulnerability"
XPERL_SPELL_WINTERCH	= "Winter's Chill"

-- Status
XPERL_LOC_DEAD		= "Dead"
XPERL_LOC_GHOST		= "Ghost"
XPERL_LOC_FEIGNDEATH	= "Feign Death"
XPERL_LOC_OFFLINE	= "Offline"
XPERL_LOC_RESURRECTED	= "Resurrected"
XPERL_LOC_SS_AVAILABLE	= "SS Available"
XPERL_LOC_UPDATING	= "Updating"
XPERL_RAID_GROUP	= "Group %d"

XPERL_OK		= "OK"
XPERL_CANCEL		= "Cancel"

XPERL_LOC_LARGENUMDIV	= 1000
XPERL_LOC_LARGENUMTAG	= "K"

BINDING_HEADER_XPERL = "X-Perl Key Bindings"
BINDING_NAME_TOGGLERAID = "Toggle Raid Windows"
BINDING_NAME_TOGGLERAIDSORT = "Toggle Raid Sort by Class/Group"
BINDING_NAME_TOGGLEOPTIONS = "Toggle Options Window"
BINDING_NAME_TOGGLEBUFFTYPE = "Toggle Buffs/Debuffs/none"
BINDING_NAME_TOGGLEBUFFCASTABLE = "Toggle Castable/Curable"

XPERL_KEY_NOTICE_RAID_BUFFANY = "All buffs/debuffs shown"
XPERL_KEY_NOTICE_RAID_BUFFCURECAST = "Only castable/curable buffs or debuffs shown"
XPERL_KEY_NOTICE_RAID_BUFFS = "Raid Buffs shown"
XPERL_KEY_NOTICE_RAID_DEBUFFS = "Raid Debuffs shown"
XPERL_KEY_NOTICE_RAID_NOBUFFS = "No raid buffs shown"

if ( GetLocale() == "frFR" ) then
	XPERL_LOC_CLASS_WARRIOR	= "Guerrier"
	XPERL_LOC_CLASS_MAGE	= "Mage"
	XPERL_LOC_CLASS_ROGUE	= "Voleur"
	XPERL_LOC_CLASS_DRUID	= "Druide"
	XPERL_LOC_CLASS_HUNTER	= "Chasseur"
	XPERL_LOC_CLASS_SHAMAN	= "Chaman"
	XPERL_LOC_CLASS_PRIEST	= "Pr\195\170tre"
	XPERL_LOC_CLASS_WARLOCK	= "D\195\169moniste"
	XPERL_LOC_CLASS_PALADIN	= "Paladin"
	XPERL_LOC_CLASS_PETS	= "Familiers"
	XPERL_TYPE_NOT_SPECIFIED = "Non indiqu\195\169"
	XPERL_TYPE_CIVILIAN	= "Civil"

	XPERL_SPELL_SUNDER	= "Fracasser armure"
--	XPERL_SPELL_SHADOWV	= ?
	XPERL_SPELL_FIREV	= "Vuln\195\169rabilit\195\169 au Feu"
	XPERL_SPELL_WINTERCH	= "Froid hivernal"

	XPERL_LOC_DEAD = "Mort"
	XPERL_LOC_GHOST = "Fant\195\180me"
	XPERL_LOC_FEIGNDEATH = "Feindre la Mort"

	XPERL_CANCEL	= "Annuler"
end
if ( GetLocale() == "deDE") then
	XPerl_LongDescription	= "UnitFrame Alternative f\195\188r ein neues Aussehen von Spieler, Begleiter, Gruppe, Ziel, Ziel des Ziels, Raid"

	XPERL_MINIMAP_HELP1	= "|c00FFFFFFLinksklick|r f\195\188r Optionen (und Frames entsperren)"
	XPERL_MINIMAP_HELP2	= "|c00FFFFFFRechtsklick|r, um das Icon zu verschieben"

	XPERL_LOC_CLASS_WARRIOR	= "Krieger"
	XPERL_LOC_CLASS_MAGE	= "Magier"
	XPERL_LOC_CLASS_ROGUE	= "Schurke"
	XPERL_LOC_CLASS_DRUID	= "Druide"
	XPERL_LOC_CLASS_HUNTER	= "J\195\164ger"
	XPERL_LOC_CLASS_SHAMAN	= "Schamane"
	XPERL_LOC_CLASS_PRIEST	= "Priester"
	XPERL_LOC_CLASS_WARLOCK	= "Hexenmeister"
	XPERL_LOC_CLASS_PALADIN	= "Paladin"
	XPERL_LOC_CLASS_PETS	= "Begleiter"
	XPERL_TYPE_NOT_SPECIFIED	= "Nicht spezifiziert"
	XPERL_TYPE_CIVILIAN	= "Zivilist"
	XPERL_TYPE_PET		= "Begleiter"
	XPERL_TYPE_BOSS		= "Boss"
	XPERL_TYPE_RAREPLUS	= "Rar+"
	XPERL_TYPE_ELITE		= "Elite"
	XPERL_TYPE_RARE		= "Rar"

	XPERL_SPELL_SUNDER	= "R\195\188stung zerrei\195\159en"
	XPERL_SPELL_SHADOWV	= "Schattenverwundbarkeit"
	XPERL_SPELL_FIREV	= "Feuerverwundbarkeit"
	XPERL_SPELL_WINTERCH	= "Winterk\195\164lte"

	XPERL_LOC_DEAD		= "Tot"
	XPERL_LOC_GHOST		= "Geist"
	XPERL_LOC_FEIGNDEATH	= "Totgestellt"
	XPERL_LOC_OFFLINE	= "Offline"
	XPERL_LOC_RESURRECTED	= "Wiederbelebung"
	XPERL_LOC_SS_AVAILABLE	= "SS verf\195\188gbar"
	XPERL_LOC_UPDATING	= "Aktualisierung"
	XPERL_RAID_GROUP	= "Gruppe %d"

	XPERL_CANCEL		= "Abbrechen"

	BINDING_HEADER_XPERL = "X-Perl Tastenbelegung"
	BINDING_NAME_TOGGLERAID = "Schalter f\195\188r das Raidfenster"
	BINDING_NAME_TOGGLERAIDSORT = "Schalter f\195\188r Raid sortieren nach Klasse/Gruppe"
	BINDING_NAME_TOGGLEOPTIONS = "Schalter f\195\188r das Optionsfenster"
	BINDING_NAME_TOGGLEBUFFTYPE = "Schalter f\195\188r Buffs/Debuffs/Keine"
	BINDING_NAME_TOGGLEBUFFCASTABLE = "Schalter f\195\188r Zauberbar/Heilbar"

	XPERL_KEY_NOTICE_RAID_BUFFANY = "Alle Buffs/Debuffs zeigen"
	XPERL_KEY_NOTICE_RAID_BUFFCURECAST = "Nur zauberbare/heilbare Buffs oder Debuffs zeigen"
	XPERL_KEY_NOTICE_RAID_BUFFS = "Raid-Buffs zeigen"
	XPERL_KEY_NOTICE_RAID_DEBUFFS = "Raid-Debuffs zeigen"
	XPERL_KEY_NOTICE_RAID_NOBUFFS = "Keine Raid-Buffs zeigen"
end
if (GetLocale() == "zhCN") then
	-- Thanks Hughman for translations
	XPerl_LongDescription	= "全新外观的玩家状态框，包括玩家、宠物、队伍、团队、目标以及目标的目标"

	XPERL_MINIMAP_HELP1	= "|c00FFFFFF左键点击|r打开选项（并解锁框体）"
	XPERL_MINIMAP_HELP2	= "|c00FFFFFF右键点击|r拖动图标"

	XPERL_LOC_DRUID		= "德鲁伊"
	XPERL_LOC_HUNTER		= "猎人"
	XPERL_LOC_MAGE		= "法师"
	XPERL_LOC_PALADIN	= "圣骑士"
	XPERL_LOC_PRIEST		= "牧师"
	XPERL_LOC_ROGUE		= "盗贼"
	XPERL_LOC_SHAMAN		= "萨满祭司"
	XPERL_LOC_WARLOCK	= "术士"
	XPERL_LOC_WARRIOR	= "战士"
	XPERL_LOC_NOT_SPECIFIED	= "非特定的"
	XPERL_TYPE_CIVILIAN	= "平民"
	XPERL_TYPE_PET		= "宠物"
	XPERL_TYPE_BOSS		= "首领"
	XPERL_TYPE_RAREPLUS	= "银英"
	XPERL_TYPE_ELITE		= "精英"
	XPERL_TYPE_RARE		= "稀有"

	XPERL_SPELL_SUNDER	= "破甲攻击"
	XPERL_SPELL_SHADOWV	= "暗影易伤"
	XPERL_SPELL_FIREV	= "火焰易伤"
	XPERL_SPELL_WINTERCH	= "深冬之寒"

	XPERL_LOC_DEAD		= "死亡"
	XPERL_LOC_GHOST		= "幽灵"
	XPERL_LOC_FEIGNDEATH	= "假死"
	XPERL_LOC_OFFLINE	= "离线"
	XPERL_LOC_RESURRECTED	= "已被复活"
	XPERL_LOC_SS_AVAILABLE	= "灵魂已保存"
	XPERL_LOC_UPDATING	= "更新中"
	XPERL_RAID_GROUP		= "小队 %d"

	XPERL_OK            	= "确认"
	XPERL_CANCEL        	= "取消"

	XPERL_LOC_LARGENUMDIV	= 10000
	XPERL_LOC_LARGENUMTAG	= "W"

	BINDING_HEADER_XPERL = "X-Perl 快捷键"
	BINDING_NAME_TOGGLERAID = "切换团队窗口"
	BINDING_NAME_TOGGLERAIDSORT = "切换团队排列方式"
	BINDING_NAME_TOGGLEBUFFTYPE = "切换增益/减益/无"
	BINDING_NAME_TOGGLEBUFFCASTABLE = "切换显示可施加/解除的增益/减益魔法"

	XPERL_KEY_NOTICE_RAID_BUFFANY = "显示所有的增益/减益魔法"
	XPERL_KEY_NOTICE_RAID_BUFFCURECAST = "只显示可施放/解除的的增益/减益魔法"
	XPERL_KEY_NOTICE_RAID_BUFFS = "显示团队增益魔法"
	XPERL_KEY_NOTICE_RAID_DEBUFFS = "显示团队减益魔法"
	XPERL_KEY_NOTICE_RAID_NOBUFFS = "不显示团队增益/减益魔法"
end
if ( GetLocale() == "koKR" ) then
	XPERL_LOC_CLASS_WARRIOR = "전사"
	XPERL_LOC_CLASS_MAGE = "마법사"
	XPERL_LOC_CLASS_ROGUE = "도적"
	XPERL_LOC_CLASS_DRUID = "드루이드"
	XPERL_LOC_CLASS_HUNTER = "사냥꾼"
	XPERL_LOC_CLASS_SHAMAN = "주술사"
	XPERL_LOC_CLASS_PRIEST = "사제"
	XPERL_LOC_CLASS_WARLOCK = "흑마법사"
	XPERL_LOC_CLASS_PALADIN = "성기사"
	XPERL_LOC_NOT_SPECIFIED = "무엇인가"

	XPERL_SPELL_SUNDER	= "방어구 가르기"
--	XPERL_SPELL_SHADOWV	?
	XPERL_SPELL_FIREV	= "화염 저항력 약화"
	XPERL_SPELL_WINTERCH	= "혹한의 추위"

	XPERL_LOC_DEAD = "죽음"
	XPERL_LOC_FEIGNDEATH = "죽은척하기"
	XPERL_LOC_OFFLINE = "오프라인"
	XPERL_LOC_RESURRECTED = "부활받음"
	XPERL_LOC_SS_AVAILABLE = "영혼석 있음"
end
if (GetLocale() == "zhTW") then
	XPERL_LOC_WARRIOR = "戰士"
	XPERL_LOC_MAGE = "法師"
	XPERL_LOC_ROGUE = "盜賊"
	XPERL_LOC_DRUID = "德魯伊"
	XPERL_LOC_HUNTER = "獵人"
	XPERL_LOC_SHAMAN = "薩滿"
	XPERL_LOC_PRIEST = "牧師"
	XPERL_LOC_WARLOCK = "術士"
	XPERL_LOC_PALADIN = "聖騎士"
	XPERL_LOC_NOT_SPECIFIED = "非特定的"
end
