

if GetLocale() ~= "koKR" then return end
ACETIMER = {}

--<< ====================================================================== >>--
-- Section Defaults: Optionals, Able to be localizd                           --
--<< ====================================================================== >>--
ACETIMER.NAME			 = "AceTimer"
ACETIMER.DESCRIPTION	 = "AceTimer, your spell timer addon."

ACETIMER.CMD_SHORT       = "/at"
ACETIMER.CMD_LONG        = "/acetimer"

ACETIMER.OPT_ANCHOR      = "anchor"
ACETIMER.OPT_ANCHOR_DESC = "Shows the dragable anchor."
ACETIMER.OPT_ANCHOR_TEXT = "Anchor is now: "

ACETIMER.OPT_SCALE       = "scale"
ACETIMER.OPT_SCALE_DESC  = "Sets bar scale ( 0.5 ~ 1)."
ACETIMER.OPT_SCALE_TEXT  = "Bar Scale is: "

ACETIMER.OPT_GROW        = "grow"
ACETIMER.OPT_GROW_DESC   = "Toggles bar growing up or downwards."
ACETIMER.OPT_GROW_TEXT   = "Growth is now: "

ACETIMER.OPT_FADE        = "fade"
ACETIMER.OPT_FADE_DESC   = "Toggles whether bars disappear when spells fade."
ACETIMER.OPT_FADE_TEXT   = "Bar disappear on fade is now: "

ACETIMER.OPT_KILL        = "kill"
ACETIMER.OPT_KILL_DESC   = "Toggles whether bars disappear when killing things."
ACETIMER.OPT_KILL_TEXT   = "Bar disappear on kill is now: "

ACETIMER.OPT_SKILL       = "skill"
ACETIMER.OPT_SKILL_DESC  = "Toggles whether bars appear when skills is avaiable."
ACETIMER.OPT_SKILL_TEXT  = "Bar appear on skill avaiable is now: "

ACETIMER.MAP_ONOFF       = {[0]="|cff00ff00On|r",  [1]="|cffff5050Off|r"}
ACETIMER.MAP_DOWNUP      = {[0]="|cff00ff00Down|r",[1]="|cffff5050Up|r" }
ACETIMER.WORD_TEST       = "Test"
ACETIMER.WORD_HIDE       = "Hide"

--<< ====================================================================== >>--
-- Section Criticals: Imperatives, Not work unless localized                  --
--<< ====================================================================== >>--
ACETIMER.PAT_RANK = "(%d+) 레벨"
ACETIMER.FMT_CAST = "%s(%d 레벨)"

ACETIMER.DRUID = {
	ABOLISH_POISON    = "독 해제";
	BASH              = "강타";
	BARKSKIN          = "나무 껍질";
	DASH              = "질주";
	DEMORALIZING_ROAR = "위협의 포효";
	ENRAGE            = "분노";
	ENTANGLING_ROOTS  = "휘감는 뿌리";
	FAERIE_FIRE       = "요정의 불꽃";
	FAERIE_FIRE_FERAL = "요정의 불꽃 (야성)";
	FERAL_CHARGE      = "야성의 돌진";
	FRENZIED_REGENERATION = "광포한 재생력";
	HIBERNATE         = "겨울잠";
	INNERVATE         = "정신 자극";
	INSECT_SWARM      = "곤충 떼";
	MOONFIRE          = "달빛 섬광";
	NATURE_S_GRASP    = "자연의 손아귀";
	POUNCE            = "암습";
	RAKE              = "갈퀴 발톱";
	REGROWTH          = "재생";
	REJUVENATION      = "회복";
	RIP               = "도려내기";
	SOOTHE_ANIMAL     = "동물 달래기";
	STARFIRE          = "별빛 화살";
	TIGER_S_FURY      = "맹공격";
	
	BRUTAL_IMPACT     = "야성의 돌진";
	NATURE_S_GRACE    = "자연의 은혜";
	
	CLEARCASTING      = "정신 집중";
	POUNCE_BLEED      = "암습 피해";
	STARFIRE_STUN     = "별빛 화살 기절";
}

ACETIMER.HUNTER = {
	BESTIAL_WRATH   = "야수의 격노";
	CONCUSSIVE_SHOT = "충격포";
	COUNTERATTACK   = "역습";
	DETERRENCE      = "공격 저지";
	EXPLOSIVE_TRAP  = "폭발의 덫";
	FLARE           = "섬광";
	FREEZING_TRAP   = "얼음의 덫";
	FROST_TRAP      = "냉기의 덫";
	HUNTER_S_MARK   = "사냥꾼의 징표";
	IMMOLATION_TRAP = "제물의 덫";
	MONGOOSE_BITE   = "살쾡이의 이빨";
	RAPID_FIRE      = "속사";
	SCARE_BEAST     = "야수 겁주기";
	SCATTER_SHOT    = "산탄 사격";
	SCORPID_STING   = "전갈 쐐기";
	SERPENT_STING   = "독사 쐐기";
	VIPER_STING     = "살무사 쐐기";
	WING_CLIP       = "날개 절단";
	WYVERN_STING    = "비룡 쐐기";
	
	CLEVER_TRAPS             = "덫 개량";
	IMPROVED_CONCUSSIVE_SHOT = "충격포 연마";
	IMPROVED_WING_CLIP       = "날개 절단 연마";

	EXPLOSIVE_TRAP_EFFECT  = "폭발의 덫";
	FREEZING_TRAP_EFFECT   = "얼음의 덫";
	FROST_TRAP_EFFECT      = "냉기의 덫";
	IMMOLATION_TRAP_EFFECT = "제물의 덫";
	QUICK_SHOTS            = "신속 사격";
}

ACETIMER.MAGE = {
	ARCANE_POWER = "신비의 마법 강화";
	BLAST_WAVE   = "화염 폭풍";
	CONE_OF_COLD = "냉기 돌풍";
	COUNTERSPELL = "마법 차단";
	DETECT_MAGIC = "마법 감지";
	FIRE_WARD    = "화염계 수호";
	FIREBALL     = "화염구";
	FLAMESTRIKE  = "불기둥";
	FROST_NOVA   = "얼음 회오리";
	FROST_WARD   = "냉기계 수호";
	FROSTBOLT    = "얼음 화살";
	ICE_BLOCK    = "얼음 방패";
	ICE_BARRIER  = "얼음 보호막";
	MANA_SHIELD  = "마나 보호막";
	POLYMORPH    = "변이";
	PYROBLAST    = "불덩이 작열";
	SCORCH       = "불태우기";

	FROSTBITE    = "동상";
	IGNITE       = "작열";
	IMPACT       = "충돌";
	IMPROVED_SCORCH = "불태우기 연마";
	PERMAFROST   = "영구 결빙";

	CLEARCASTING          = "정신 집중";
	COUNTERSPELL_SILENCED = "마법 차단 - 침묵";
	FIRE_VULNERABILITY    = "화염 저항력 약화";
}

ACETIMER.PALADIN = {
	BLESSING_OF_FREEDOM    = "자유의 축복";
	BLESSING_OF_KINGS      = "왕의 축복";
	BLESSING_OF_LIGHT      = "빛의 축복";
	BLESSING_OF_MIGHT      = "힘의 축복";
	BLESSING_OF_PROTECTION = "보호의 축복";
	BLESSING_OF_SACRIFICE  = "희생의 축복";
	BLESSING_OF_SALVATION  = "구원의 축복";
	BLESSING_OF_SANCTUARY  = "성역의 축복";
	BLESSING_OF_WISDOM     = "지혜의 축복";
	CONSECRATION           = "신성화";
	DIVINE_PROTECTION      = "신의 가호";
	DIVINE_SHIELD          = "천상의 보호막";
	HAMMER_OF_JUSTICE      = "심판의 망치";
	HAMMER_OF_WRATH        = "천벌의 망치";
	HOLY_SHIELD            = "신성한 방패";
	JUDGEMENT              = "심판";
	LAY_ON_HANDS           = "신의 축복";
	REPENTANCE             = "참회";
	SEAL_OF_COMMAND        = "지휘의 문장";
	SEAL_OF_JUSTICE        = "심판의 문장";
	SEAL_OF_LIGHT          = "빛의 문장";
	SEAL_OF_RIGHTEOUSNESS  = "정의의 문장";
	SEAL_OF_THE_CRUSADER   = "성전사의 문장";
	SEAL_OF_WISDOM         = "지혜의 문장";
	TURN_UNDEAD            = "언데드 퇴치";
	
	GUARDIAN_S_FAVOR  = "수호신의 은총";
	LASTING_JUDGEMENT = "영원한 심판";
	REDOUBT           = "보루";
	VENGEANCE         = "복수";
	VINDICATION       = "비호";
	
	FORBEARANCE               = "참을성";
	JUDGEMENT_OF_JUSTICE      = "정의의 심판";
	JUDGEMENT_OF_LIGHT        = "빛의 심판";
	JUDGEMENT_OF_WISDOM       = "지혜의 심판";
	JUDGEMENT_OF_THE_CRUSADER = "성전사의 심판";
}

ACETIMER.PRIEST = {
	ABOLISH_DISEASE   = "질병 해제";
	DEVOURING_PLAGUE  = "파멸의 역병";
	ELUNE_S_GRACE     = "엘룬의 은총";
	FADE              = "소실";
	FEEDBACK          = "역순환";
	HEX_OF_WEAKNESS   = "무력의 주술";
	HOLY_FIRE         = "신성한 불꽃";
	MIND_SOOTHE       = "평정";
	POWER_INFUSION    = "마력 주입";
	POWER_WORD_SHIELD = "신의 권능: 보호막";
	PSYCHIC_SCREAM    = "영혼의 절규";
	RENEW             = "소생";
	SHACKLE_UNDEAD    = "언데드 속박";
	SHADOW_WORD_PAIN  = "어둠의 권능: 고통";
	SILENCE           = "침묵";
	STARSHARDS        = "별조각";
	TOUCH_OF_WEAKNESS = "무력의 손길";
	VAMPIRIC_EMBRACE  = "흡혈의 선물";

	BLACKOUT                   = "의식 상실";
	BLESSED_RECOVERY           = "축복받은 회복력";
	IMPROVED_SHADOW_WORD_PAIN  = "어둠의 권능: 고통 연마";
	INSPIRATION                = "신의 계시";
	SHADOW_VULNERABILITY       = "암흑 저항력 약화";
	SHADOW_WEAVING             = "어둠의 매듭";
	SPIRIT_TAP                 = "정신력 누출";

	WEAKENED_SOUL = "약화된 영혼";
}

ACETIMER.ROGUE = {
	ADRENALINE_RUSH = "아드레날린 촉진";
	BLADE_FLURRY    = "폭풍의 칼날";
	BLIND           = "실명";
	CHEAP_SHOT      = "비열한 습격";
	DISTRACT        = "혼란";
	EXPOSE_ARMOR    = "약점 노출";
	EVASION         = "회피";
	GARROTE         = "목 조르기";
	GOUGE           = "후려치기";
	HEMORRHAGE      = "과다출혈";
	KICK            = "발차기";
	KIDNEY_SHOT     = "급소 가격";
	RIPOSTE         = "반격";
	RUPTURE         = "파열";
	SAP             = "기절시키기";
	SLICE_AND_DICE  = "난도질";
	SPRINT          = "전력 질주";
	VANISH          = "소멸";

	IMPROVED_GOUGE          = "후려치기 연마";
	IMPROVED_GARROTE        = "목 조르기 연마";
	IMPROVED_EVASION        = "회피 연마";
	IMPROVED_SLICE_AND_DICE = "난도질 연마";
	MACE_SPECIALIZATION     = "둔기류 전문화";
	REMORSELESS_ATTACKS     = "냉혹함";

	KICK_SILENCED    = "발차기 - 침묵";
	MACE_STUN_EFFECT = "철퇴 기절 효과";
	REMORSELESS      = "냉혹함";
}

ACETIMER.SHAMAN = {
	DISEASE_CLEANSING_TOTEM  = "질병정화 토템";
	EARTH_SHOCK              = "대지 충격";
	EARTHBIND_TOTEM          = "속박의 토템";
	FIRE_NOVA_TOTEM          = "불꽃 회오리 토템";
	FIRE_RESISTANCE_TOTEM    = "화염 저항 토템";
	FROST_SHOCK              = "냉기 충격";
	FLAME_SHOCK              = "화염 충격";
	FLAMETONGUE_TOTEM        = "불꽃의 토템";
	FROST_RESISTANCE_TOTEM   = "냉기 저항 토템";
	GRACE_OF_AIR_TOTEM       = "은총의 토템";
	GROUNDING_TOTEM          = "마법정화 토템";
	HEALING_STREAM_TOTEM     = "치유의 토템";
	MAGMA_TOTEM              = "용암 토템";
	MANA_SPRING_TOTEM        = "마나샘 토템";
	MANA_TIDE_TOTEM          = "마나 해일 토템";
	NATURE_RESISTANCE_TOTEM  = "자연 저항 토템";
	POISON_CLEANSING_TOTEM   = "독 정화 토템";
	SEARING_TOTEM            = "불타는 토템";
	SENTRY_TOTEM             = "감시의 토템";
	STONECLAW_TOTEM          = "돌발톱 토템";
	STONESKIN_TOTEM          = "돌가죽 토템";
	STORMSTRIKE              = "폭풍의 일격";
	STRENGTH_OF_EARTH_TOTEM  = "대지력 토템";
	TRANQUIL_AIR_TOTEM       = "평온의 토템";
	TREMOR_TOTEM             = "진동의 토템";
	WINDFURY_TOTEM           = "질풍의 토템";
	WINDWALL_TOTEM           = "바람막이 토템";

	ANCESTRAL_HEALING        = "선인의 치유력";
	EVENTIDE                 = "일몰";
	IMPROVED_FIRE_NOVA_TOTEM = "불꽃 회오리 토템 연마";
	IMPROVED_STONECLAW_TOTEM = "돌발톱 토템 연마";
	
	ANCESTRAL_FORTITUDE      = "선인의 인내";
	CLEARCASTING             = "정신 집중";
	ENAMORED_WATER_SPIRIT    = "사로잡힌 물의 정령";
}

ACETIMER.WARLOCK = {
	AMPLIFY_CURSE         = "저주 증폭";
	BANISH                = "추방";
	CORRUPTION            = "부패";
	CURSE_OF_AGONY        = "고통의 저주";
	CURSE_OF_DOOM         = "파멸의 저주";
	CURSE_OF_EXHAUSTION   = "피로의 저주";
	CURSE_OF_RECKLESSNESS = "무모함의 저주";
	CURSE_OF_SHADOW       = "어둠의 저주";
	CURSE_OF_TONGUES      = "언어의 저주";
	CURSE_OF_WEAKNESS     = "무력화 저주";
	CURSE_OF_THE_ELEMENTS = "원소의 저주";
	DEATH_COIL            = "죽음의 고리";
	DRAIN_SOUL            = "영혼 흡수";
	FEAR                  = "공포";
	FEL_DOMINATION        = "마의 지배";
	ENSLAVE_DEMON         = "악마 지배";
	HOWL_OF_TERROR        = "공포의 울부짖음";
	IMMOLATE              = "제물";
	SHADOW_BOLT           = "어둠의 화살";
	SHADOW_WARD           = "암흑계 수호";
	SHADOWBURN            = "어둠의 연소";
	SIPHON_LIFE           = "생명력 착취";

	AFTERMATH             = "재앙의 여파";
	NIGHTFALL             = "일몰";
	PYROCLASM             = "화염파열";
	SACRIFICE             = "희생";
	SEDUCTION             = "현혹";
	
	SHADOW_TRANCE         = "어둠의 무아지경";
	SHADOW_VULNERABILITY  = "암흑 저항력 약화";
	SOUL_SIPHON           = "영혼 착취";
}

ACETIMER.WARRIOR = {
	BATTLE_SHOUT       = "전투의 외침";
	BERSERKER_RAGE     = "광전사의 격노";
	BLOODRAGE          = "피의 분노";
	BLOODTHIRST        = "피의 갈증";
	CHALLENGING_SHOUT  = "도전의 외침";
	CHARGE             = "돌진";
	CONCUSSION_BLOW    = "충격의 일격";
	DEATH_WISH         = "죽음의 소원";
	DEMORALIZING_SHOUT = "사기의 외침";
	DISARM             = "무장 해제";
	EXECUTE            = "마무리 일격";
	HAMSTRING          = "무력화";
	INTERCEPT          = "봉쇄";
	INTIMIDATING_SHOUT = "위협의 외침";
	LAST_STAND         = "최후의 저항";
	MOCKING_BLOW       = "도발의 일격";
	MORTAL_STRIKE      = "죽음의 일격";
	OVERPOWER          = "제압";
	PIERCING_HOWL      = "날카로운 고함";
	PUMMEL             = "자루 공격";
	RECKLESSNESS       = "무모한 희생";
	REND               = "분쇄";
	RETALIATION        = "보복";
	REVENGE            = "복수";
	SHIELD_BASH        = "방패 가격";
	SHIELD_BLOCK       = "방패 막기";
	SHIELD_WALL        = "방패의 벽";
	SUNDER_ARMOR       = "방어구 가르기";
	SWEEPING_STRIKES   = "휩쓸기 일격";
	TAUNT              = "도발";
	THUNDER_CLAP       = "천둥벼락";
	
	BLOOD_CRAZE           = "피의 광기";
	BOOMING_VOICE         = "우렁찬 음성";
	DEEP_WOUNDS           = "치명상";
	ENRAGE                = "격노";
	FLURRY                = "질풍";
	IMPROVED_HAMSTRING    = "무력화 연마";
	IMPROVED_SHIELD_BLOCK = "방패 막기 연마";
	IMPROVED_DISARM       = "무장 해제 연마";
	IMPROVED_SHIELD_WALL  = "방패의 벽 연마";
	MACE_SPECIALIZATION   = "둔기류 전문화";
	
	CHARGE_STUN          = "돌진 기절";
	INTERCEPT_STUN       = "봉쇄 기절";
	MACE_STUN_EFFECT     = "철퇴 기절 효과";
	REVENGE_STUN         = "복수 기절";
	SHIELD_BASH_SILENCED = "방패 가격 - 침묵";
}
