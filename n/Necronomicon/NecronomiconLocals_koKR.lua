-- Korean Localization added by HanDDol of wow.SomeGate.com

function Necronomicon_Locals_koKR()
	NECRONOMICON_MSG_COLOR		= "|cffcceebb";
	NECRONOMICON_DISPLAY_OPTION	= "[|cfff5f530%s|cff0099CC]";

	NECRONOMICON_CONST = {

		Title   		= "Necronomicon",
		Version 		= "0.7",
		Desc    		= "Necronomicon, Ace'd Necrosis",
		Timerheader		= "주문 타이머",
		UpdateInterval		= 0.2,
	
		ChatCmd		= {"/necro", "/necronomicon", "/Necronomicon", "/네크로"},
		
		ChatOpt 		= {
			{	
				option	= "초기화",
				desc	= "창 위치 초기화.",
				method	= "chatReset",
			},
			{
				option  = "마의지배",
				desc	= "Set the Fel Domination modifier: ctrl alt shift none",
				method  = "chatFelDom",
			},
			{
				option  = "closeonclick",
				desc    = "Toggle closing the pet menu on clicking a button",
				method  = "chatCloseClick",
			},
			{
				option  = "soulstonesound",
				desc    = "Toggle playing of soulstone expired sound",
				method  = "chatSoulstoneSound",
			},
			{
				option  = "shadowtrancesound",
				desc    = "Toggle playing of nightfall proc sound",
				method  = "chatShadowTranceSound",
			},
			{
				option	= "색깔",
				desc	= "영혼의 조각 Choos카운터 색깔 변경 : e a different shardcount texture: default blue orange rose turquoise violet x",
				method	= "chatTexture",
			},
			{
				option 	= "잠금",
				desc	= "창을 잠그기/풀기",
				method  = "chatLock",
			},
			{
				option  = "타이머",
				desc    = "타이머 켜기/끄기",
				method  = "chatTimers",
			},

		},
		
		Chat            	= {
			FelDomModifier  = "Fel Domination Modifier is now: ",
			FelDomValid	= "Valid Modifiers are: ctrl alt shift none",
			CloseOnClick    = "자동닫기 설정 변경: ",
			ShadowTranceSound = "Playing of Shadowtrance sound is now: ",
			SoulstoneSound = "Playing of Soulstone expired sound is now: ",
			Texture = "Texture is now: ",
			TextureValid = "Valid textures are: default blue orange rose turquoise violet x",
			Lock = "창 잠금 설정 변경: ",
			Timers = "타이머 설정 변경: ",
		},
		
		Message			= {
			TooFarAway 	= "They are too far away.",
			Busy		= "They are busy.",
			PreSummon	= "%s를 소환합니다. 소환문을 클릭해주세요.",
			PreSoulstone	= "Placing my soulstone on %s.",
			Soulstone	= "%s has been soulstoned.",
			SoulstoneAborted = "Soustone Aborted! It's not placed.",
			FailedSummon	= "Summoning %s failed!",
		},
		

		Pattern = {
			Shard = "영혼의 조각",
			Corrupted = "오염된", --확인 : 오염된?
			Healthstone = "생명석",
			Soulstone = "영혼석",
			Spellstone = "주문석",
			Firestone = "화염석",
			ShadowTrance = "어둠의 무아지경 효과를 얻었습니다.",
			RitualOfSummoning = "소환 의식",
			SoulstoneResurrection = "영혼석 부활",
			Warlock = "흑마법사",
			Rank = "(.+) 레벨",
			Resisted = "^(.+)|1으로;로; (.+)|1을;를; 공격했지만 저항했습니다.",
			Immune = "^(.+)|1으로;로; (.+)|1을;를; 공격했지만 피해를 입지 않았습니다.", --확인 : 면역 메시지
		},

		State = {
			Reset = 0,
			Cast = 1,
			Start = 2,
			Stop = 3,
			NewMonsterNewSpell = 4,
			NewSpell = 5,
			Update = 6,
			Failed = 7
			
		},

		Spell = {			
			["임프 소환"] = "IMP",
			["보이드워커 소환"] = "VOIDWALKER",
			["서큐버스 소환"] = "SUCCUBUS",
			["지옥사냥개 소환"] = "FELHUNTER",
			["불지옥"] = "INFERNO",
			["파멸의 의식"] = "DOOMGUARD",
			["킬로그의 눈"] = "KILROGG",
			["마의 지배"] = "FELDOMINATION",
			["악의 제물"] = "DEMONICSACRIFICE",
			["영혼의 고리"] = "SOULLINK",
			["영혼석 부활"] = "SOULSTONERESURRECTION",
			["소환 의식"] = "RITUALOFSUMMONING",
		},

		RankedSpell = {
		
		["지옥마 소환"] = { "MOUNT", 1 },
			["공포마 소환"] = { "MOUNT", 2 },
			["악마의 피부 1 레벨)"] = { "ARMOR", 1 },
			["악마의 피부 2 레벨"] = { "ARMOR", 2 },
			["악마의 갑옷 1 레벨"] = { "ARMOR", 3 },
			["악마의 갑옷 2 레벨"] = { "ARMOR", 4 },
			["악마의 갑옷 3 레벨"] = { "ARMOR", 5 },
			["악마의 갑옷 4 레벨"] = { "ARMOR", 6 },
			["악마의 갑옷 5 레벨"] = { "ARMOR", 7 },
			["생명력 집중 1 레벨"] = { "HEALTHFUNNEL", 1 },
			["생명력 집중 2 레벨"] = { "HEALTHFUNNEL", 2 },
			["생명력 집중 3 레벨"] = { "HEALTHFUNNEL", 3 },
			["생명력 집중 4 레벨"] = { "HEALTHFUNNEL", 4 },
			["생명력 집중 5 레벨"] = { "HEALTHFUNNEL", 5 },
			["생명력 집중 6 레벨"] = { "HEALTHFUNNEL", 6 },
			["생명력 집중 7 레벨"] = { "HEALTHFUNNEL", 7 },
			
			["생명석 창조 (최하급)"] = { "HEALTHSTONE", 1 },
			["생명석 창조 (하급)"] = { "HEALTHSTONE", 2 },
			["생명석 창조 (중급)"] = { "HEALTHSTONE", 3 },
			["생명석 창조 (상급)"] = { "HEALTHSTONE", 4 },
			["생명석 창조 (최상급)"] = { "HEALTHSTONE", 5 },
			["영혼석 창조 (최하급)"] = { "SOULSTONE", 1 },
			["영혼석 창조 (하급)"] = { "SOULSTONE", 2 },
			["영혼석 창조"] = { "SOULSTONE", 3 },
			["영혼석 창조 (상급)"] = { "SOULSTONE", 4 },
			["영혼석 창조 (최상급)"] = { "SOULSTONE", 5 },
			["주문석 창조"] = { "SPELLSTONE", 1 },
			["주문석 창조 (상급)"] = { "SPELLSTONE", 2 },
			["주문석 창조 (최상급)"] = { "SPELLSTONE", 3 },
			["화염석 창조 (하급)"] = { "FIRESTONE", 1 },
			["화염석 창조 (중급)"] = { "FIRESTONE", 2 },
			["화염석 창조 (상급)"] = { "FIRESTONE", 3 },
			["화염석 창조 (최상급)"] = { "FIRESTONE", 4 },
			["악마 지배 1 레벨"] = {"ENSLAVE", 1},
			["악마 지배 2 레벨"] = {"ENSLAVE", 2},
			["악마 지배 3 레벨"] = {"ENSLAVE", 3},			
		},
		TimedSpell = {
			["부패"] = { 12, 15, 18, 18, 18, 18, 18 },
			["제물"] = { 15, 15, 15, 15, 15, 15, 15, 15 },
			["생명력 착취"] = { 30, 30, 30, 30 },
			["고통의 저주"] = { 24, 24, 24, 24, 24, 24 },
			["추방"] = { 20, 30 },
			["죽음의 고리"] = {3, 3, 3},
			["무력화 저주"] = { 120, 120, 120, 120, 120, 120 },
			["무모함의 저주"] = { 120, 120, 120, 120 },
			["원소의 저주"] = { 300, 300, 300 },
			["어둠의 저주"] = { 300, 300 },
			["공포"] = { 10, 15, 20 },
			["악마 지배"] = { 300, 300, 300 },
			["파멸의 저주"] = { 60 },
			["언어의 저주"] = { 30, 30 },
		},
	}	

	ace:RegisterGlobals({
		version	= 1.01,
	
		ACEG_TEXT_NOW_SET_TO = "값 변경",
		ACEG_TEXT_DEFAULT	 = "기본값",
	
		ACEG_DISPLAY_OPTION  = "[|cfff5f530%s|r]",
	
		ACEG_MAP_ONOFF		 = {[0]="|cffff5050꺼짐|r",[1]="|cff00ff00켜짐|r"},
		ACEG_MAP_ENABLED	 = {[0]="|cffff5050꺼짐|r",[1]="|cff00ff00켜짐|r"},
	})
end