-- English

-- Spells/Emotes that will be ignored
SA_SPELLS_IGNORE = 
{
	["Abolish Poision"] = 1;
	["Aimed Shot"] = 1;
	["Arcane Intellect"] = 1;
	["Arcane Shot"] = 1;
	["Argent Dawn Commission"] = 1;
	["Aspect of the Cheetah"] = 1;
	["Aspect of the Hawk"] = 1;
	["Aspect of the Monkey"] = 1;
	["Attack"] = 1;
	["Battle Shout"] = 1;
	["Bloodrage"] = 1;
	["Blood Craze"] = 1;
	["Blood Pact"] = 1;
	["Battle Shout"] = 1;
	["Battle Stance"] = 1;
	["Berserker Stance"] = 1;
	["Blade Flurry"] = 1;
	["Blink"] = 1;
	["Clearcasting"] = 1;
	["Cold Blood"] = 1; -- 11000-10
	["Concussive Shot"] = 1;
	["Dash"] = 1;
	["Defensive Stance"] = 1;
	["Detect Traps"] = 1;
	["Devotion Aura"] = 1;
	["Enrage"] = 1;
	["Evasion"] = 1;
	["Explosive Shot"] = 1;
	["Fade"] = 1;
	["Fire Resistance Aura"] = 1;
	["Flurry"] = 1;
	["Focused Casting"] = 1;
	["Haste"] = 1;
	["Holy Strength"] = 1;
	["Inspiration"] = 1;
	["Julie's Blessing"] = 1;
	["Remorseless"] = 1;
	["Serpent Sting"] = 1;
	["Scatter Shot"] = 1;
	["Shield Block"] = 1;
	["Spirit of Redemption"] = 1;
	["Spirit Tap"] = 1;
	["Sprint"] = 1;
	["Stealth"] = 1;
	["Swiftshifting"] = 1;
	["Travel Form"] = 1;
	["Trueshot Aura"] = 1;
	["Viper Sting"] = 1;
};

SA_MOBS_ACCEPT = 
{
};

SA_PTN_SPELL_BEGIN_CAST = "(.+) begins to cast (.+).";
SA_PTN_SPELL_GAINS_X = "(.+) gains (%d+) (.+).";
SA_PTN_SPELL_GAINS = "(.+) gains (.+).";
SA_PTN_SPELL_TOTEM = "(.+) casts (.+) Totem.";
SA_PTN_SPELL_FADE = "(.+) fades from (.+).";
SA_PTN_SPELL_BEGIN_PERFORM = "(.+) begins to perform (.+).";

SA_WOTF = "Will of the Forsaken";
SA_BERSERKER_RAGE = "Berserker Rage";
SA_AFFLICT_LIVINGBOMB = "You are afflicted by Living Bomb.";
SA_EMOTE_DEEPBREATH = "takes in a deep breath...";


SASCT_HUNTER = "Hunter";
SASCT_FEIGNDEATH = "Feign Death";
SASCT_ERRNOSTYLE = "There is an error in your settings, style not found.";
SASCT_ADDONTEST = " is testing the addon.";
SASCT_ONY = "Onyxia";
SASCT_EMOTESPACE = " ";
SASCT_LOADPRINT = "  by BarryJ (Eugorym of Perenolde). /sasct for help";
SASCT_PROFILELOADED = " profile loaded.";

SASCT_USAGE_HEADER_1 = "-- Usage/Help for ";
SASCT_USAGE_HEADER_2 = " by BarryJ (Eugorym of Perenolde)";
SASCT_USAGE_CRIT = "Whether or not the message should be a crit; does nothing if style is set to Message.  [Default is Off]";
SASCT_USAGE_STATUS = "Displays the current configuration options.";
SASCT_USAGE_STYLE = "Animation Style to use.  [Default is Vertical]";
SASCT_USAGE_TARGETONLY = "Whether or not to display messages from the selected target only.  [Default is Off]";
SASCT_USAGE_TEST = "Send a test message to see how it looks.  (Also done automatically after a settings change)";
SASCT_USAGE_TARGETINDICATOR = "Text to be put before and after the message, if the spell is being cast by your target.  [Default is ' *** ']";
SASCT_USAGE_RETARGET = "Retarget after feign death like old SpellAlert.  [Default is On]";
SASCT_USAGE_BOSSWARNINGS = "Deep Breath and Living Bomb Warning like old SpellAlert.  [Default is On]";
SASCT_USAGE_TOGGLE = "Toggles alerting of spell casting on and off.  [Default is On]";
SASCT_USAGE_COLOR = "Sets the color component of the specified color."; -- 11000-9
SASCT_USAGE_EMOTES = "Whether or not to display emotes along with spells.  [Default is On]"; -- 11000-9
SASCT_USAGE_COMPACT = "Whether or not to compact messages.  [Default is Off]"; -- 11000-10
SASCT_USAGE_REPEAT = "How long in seconds to refrain from repeating the same message [Default is 2]"; -- 11100-1


SASCT_RETARGET_1 = "Retargetting Hunter  ";
SASCT_RETARGET_2 = " : ";

SASCT_STATUS_CRIT = "Displaying the event as a crit using the "
SASCT_STATUS_CRIT_2 = " animation style.";
SASCT_STATUS_NONCRIT = "Displaying the event as a non-crit using the "
SASCT_STATUS_TARGETONLY_ON = "TargetOnly: On";
SASCT_STATUS_TARGETONLY_OFF = "TargetOnly: Off";
SASCT_STATUS_EMOTES_ON = "Alert to emotes: On";
SASCT_STATUS_EMOTES_OFF = "Alert to emotes: Off";
SASCT_STATUS_COLOR = "Using the color (r/g/b) ";
SASCT_STATUS_COLOR_DEFAULT = " for default."; -- 11000-9
SASCT_STATUS_COLOR_TARGET = " for your target."; -- 11000-9
SASCT_STATUS_COLOR_WARN = " for boss warnings."; -- 11000-9
SASCT_STATUS_COLOR_EMOTE = " for emotes."; -- 11000-10
SASCT_STATUS_TARGETINDICATOR = "TargetIndicator: ";
SASCT_STATUS_TOGGLE_ON = "Alerting to Spell Casting Enabled."; -- 11000-9
SASCT_STATUS_TOGGLE_OFF = "Alerting to Spell Casting Disabled."; -- 11000-9
SASCT_STATUS_COMPACT_ON = "Compact Messages Enabled."; -- 11000-10
SASCT_STATUS_COMPACT_OFF = "Compact Messages Disabled."; -- 11000-10
SASCT_STATUS_BOSSWARN_ON = "Alert to Boss Warnings: On"; -- 11000-11
SASCT_STATUS_BOSSWARN_OFF = "Alert to Boss Warnings: Off"; -- 11000-11
SASCT_STATUS_REPEAT = "Message Repeat Delay: " -- 11100-1

SASCT_OPT_CRIT_OFF = "Displaying as Crit - Off.";
SASCT_OPT_CRIT_ON = "Displaying as Crit - On.";
SASCT_OPT_STYLE_NOSTYLE = "You must specify a style type to use.";
SASCT_OPT_STYLE_MESSAGE = "Displaying as an SCT Message.";
SASCT_OPT_STYLE_VERTICAL = "Displaying using the Vertical animation style.";
SASCT_OPT_STYLE_RAINBOW = "Displaying using the Rainbow animation style.";
SASCT_OPT_STYLE_HORIZONTAL = "Displaying using the Horizontal animation style.";
SASCT_OPT_STYLE_ANGLEDDOWN = "Displaying using the Angled Down animation style.";
SASCT_OPT_STYLE_CHOICES = "You must choose from [message/vertical/rainbow/horizontal/angled down] for the style.";
SASCT_OPT_TARGETONLY_OFF = "Alerting to events from all entities.";
SASCT_OPT_TARGETONLY_ON = "Alerting to events from the selected target only.";
SASCT_OPT_EMOTES_OFF = "No longer alerting to emotes.";
SASCT_OPT_EMOTES_ON = "Now alerting to emotes.";
SASCT_OPT_COLOR_COICES = "You must choose a number between 0.0 and 1.0";
SASCT_OPT_TARGETINDICATOR_BLANK = "TargetIndicator set to: (blank)";
SASCT_OPT_TARGETINDICATOR_SET = "TargetIndicator set to: ";
SASCT_OPT_RESET = "Options reset.";
SASCT_OPT_RETARGET_ON = "Retarget after Feign Death- On";
SASCT_OPT_RETARGET_OFF = "Retarget after Feign Death- Off";
SASCT_OPT_BOSSWARNINGS_ON = "Boss Warnings On";
SASCT_OPT_BOSSWARNINGS_OFF = "Boss Warnings Off";
SASCT_OPT_COMPACT_ON = "Compact Messages On";
SASCT_OPT_COMPACT_OFF = "Compact Messages Off";
SASCT_OPT_REPEAT_SET = "Message Repeat Time: "; -- 11100-1
SASCT_OPT_REPEAT_ERROR = "You must enter a number."; --11100-1


SASCT_OPT_TOGGLE_OFF = "Disabled.";
SASCT_OPT_TOGGLE_ON = "Enabled.";
SASCT_OPT_COLOR_COLORS = "You must specify which color [red/green/blue]." -- 11000-9
SASCT_OPT_COLOR_TYPES = "You must specify which color you wish to modify [default/target/warn/emote]" -- 11000-10



if (GetLocale()=="koKR") then
	-- Korean by gygabyte
	SASCT_HUNTER = "사냥꾼";
	SASCT_FEIGNDEATH = "죽은척하기";
	SASCT_ERRNOSTYLE = "현재 설정에 오류가 있습니다, 움직임 형태를 찾지 못했습니다.";
	SASCT_NOSCT = "SpellAlert SCT를 불러오지 못했습니다!  필수 구성 요소인 SCT가 설치되어 있지 않습니다!";
	SASCT_ADDONTEST = "님이 애드온을 테스트 합니다.";
	SASCT_ONY = "오닉시아";
	SASCT_EMOTESPACE = "|1이;가; ";
	SASCT_LOADPRINT = "  by BarryJ (Eugorym of Perenolde). 도움말을 보실려면 '/sasct' 또는 '/ss' 를 입력하세요.";
	SASCT_PROFILELOADED = "님 프로필을 불러왔습니다.";

	SASCT_USAGE_HEADER_1 = "-- BarryJ (Eugorym of Perenolde)에 의한 만들어진 SpellAlertSCT ";
	SASCT_USAGE_HEADER_2 = " 사용법/도움말";
	SASCT_USAGE_CRIT = "치명타 메시지로 표시할지의 여부를 결정합니다.; 만약에 움직임 형태를 설정하지 않는다면 표시되지 않습니다.  [기본값 : 켜짐]";
	SASCT_USAGE_STATUS = "현재 설정 상태를 표시합니다.";
	SASCT_USAGE_STYLE = "사용할 움직임 형태.  [기본값 : vertical]";
	SASCT_USAGE_TARGETONLY = "선택한 대상의 주문만 경고할지의 여부를 결정합니다.  [기본값 : 꺼짐]";
	SASCT_USAGE_TEST = "화면에 어떻게 보이는 지 보기 위해서 테스트 메시지를 보냅니다.  (또한 설정 변경 후 자동적으로 적용됩니다)";
	SASCT_USAGE_RED = "메시지의 색상중 빨간색을 설정합니다.  [기본값 : 1.0]";
	SASCT_USAGE_GREEN = "메시지의 색상중 녹색을 설정합니다.  [기본값 : 1.0]";
	SASCT_USAGE_BLUE = "메시지의 색상중 파란색을 설정합니다.  [기본값 : 1.0]";
	SASCT_USAGE_TARGETINDICATOR = "대상이 시전하는 메시지 경고 앞뒤에 문자열을 삽입합니다.  [기본값 : ' *** ']";
	SASCT_USAGE_RETARGET = "사냥꾼이 죽은척하기를 했을 때 대상을 재타겟팅 합니다.  [기본값 : 켜짐]";
	SASCT_USAGE_BOSSWARNINGS = "오닉시아 깊은 숨과 남작 게돈의 살아있는 불길을 경고합니다.  [기본값 : 켜짐]";
	SASCT_USAGE_TOGGLE = "주문 시전 알림을 경고합니다.  [기본값 : 켜짐]";
	SASCT_USAGE_COLOR = "메시지의 색상을 설정합니다."; -- 11000-9
	SASCT_USAGE_EMOTES = "주문과 같이 나오는 감정 표현을 경고합니다.  [기본값 : 켜짐]"; -- 11000-9

	SASCT_RETARGET_1 = "적의 ";
	SASCT_RETARGET_2 = "|1으로;로; 인한 혼란 후 타겟 재설정 : ";

	SASCT_STATUS_CRIT = " 움직임 형태를 사용하여 치명타 메시지로 표시합니다."
	SASCT_STATUS_CRIT_2 = "";
	SASCT_STATUS_NONCRIT = " 움직임 형태를 사용하여 치명타 메시지로 표시하지 않습니다.";
	SASCT_STATUS_TARGETONLY_ON = "선택한 대상의 주문만 경고합니다.";
	SASCT_STATUS_TARGETONLY_OFF = "모든 대상의 주문을 경고합니다.";
	SASCT_STATUS_EMOTES_ON = "감정 표현 경고 : 켜기";
	SASCT_STATUS_EMOTES_OFF = "감정 표현 경고 : 끄기";
	SASCT_STATUS_COLOR = "r/g/b 색상 사용 : ";
	SASCT_STATUS_COLOR_DEFAULT = " <- 기본 경고 색상."; -- 11000-9
	SASCT_STATUS_COLOR_TARGET = " <- 대상 경고 색상."; -- 11000-9
	SASCT_STATUS_COLOR_WARN = " <- 보스 경고 색상."; -- 11000-9
	SASCT_STATUS_TARGETINDICATOR = "대상 문자열 표시 : ";
	SASCT_STATUS_TOGGLE_ON = "주문 시전 알림 활성화."; -- 11000-9
	SASCT_STATUS_TOGGLE_OFF = "주문 시전 알림 비활성화."; -- 11000-9

	SASCT_OPT_CRIT_OFF = "치명타 메시지로 표시 - 끄기.";
	SASCT_OPT_CRIT_ON = "치명타 메시지로 표시 - 켜기.";
	SASCT_OPT_STYLE_NOSTYLE = "사용할 움직임 형태를 정해야 합니다.";
	SASCT_OPT_STYLE_MESSAGE = "SCT 메시지로 표시.";
	SASCT_OPT_STYLE_VERTICAL = "세로 움직임 형태 표시(기본값).";
	SASCT_OPT_STYLE_RAINBOW = "무지개 움직임 형태 표시.";
	SASCT_OPT_STYLE_HORIZONTAL = "가로 움직임 형태 표시.";
	SASCT_OPT_STYLE_ANGLEDDOWN = "모난 움직임 형태 표시.";
	SASCT_OPT_STYLE_CHOICES = "움직임 형태는 [message/vertical/rainbow/horizontal/angled down] 중에서 정해야 합니다.";
	SASCT_OPT_TARGETONLY_OFF = "모든 대상의 주문을 경고합니다.";
	SASCT_OPT_TARGETONLY_ON = "선택한 대상의 주문만 경고합니다.";
	SASCT_OPT_EMOTES_OFF = "감정 표현 경고를 사용하지 않습니다.";
	SASCT_OPT_EMOTES_ON = "감정 표현 경고를 사용합니다.";
	SASCT_OPT_COLOR_COICES = "0.0과 1.0 사이의 숫자를 선택해야 합니다.";
--	SASCT_OPT_RED_SET = "빨간색의 설정값은 ";
--	SASCT_OPT_GREEN_SET = "녹색의 설정값은 ";
--	SASCT_OPT_BLUE_SET = "파란색의 설정값은 ";
	SASCT_OPT_TARGETINDICATOR_BLANK = "대상 문자열 표시 설정 : (blank)";
	SASCT_OPT_TARGETINDICATOR_SET = "대상 문자열 표시 설정 : ";
	SASCT_OPT_RESET = "설정을 초기화 합니다.";
--	SASCT_OPT_RED_END = " 입니다.";
--	SASCT_OPT_GREEN_END = " 입니다.";
--	SASCT_OPT_BLUE_END = " 입니다.";
	SASCT_OPT_RETARGET_ON = "죽은척하기 재타겟 : 켜기";
	SASCT_OPT_RETARGET_OFF = "죽은척하기 재타겟 : 끄기";
	SASCT_OPT_BOSSWARNINGS_ON = "보스 경고 : 켜기";
	SASCT_OPT_BOSSWARNINGS_OFF = "보스 경고 : 끄기";

	SASCT_OPT_TOGGLE_OFF = "비활성화.";
	SASCT_OPT_TOGGLE_ON = "활성화.";
	SASCT_OPT_COLOR_COLORS = "[red/green/blue] 중에서 색상을 선택해야 합니다.." -- 11000-9
	SASCT_OPT_COLOR_TYPES = "[default/target/warn] 중에서 색상을 바꾸길 원하는 종류를 선택해야 합니다" -- 11000-9



--[[	SA_SPELLS_HEALS = 
	{
		-- 사제
		["순간 치유"] = 1,
		["상급 치유"] = 1,
		["치유"] = 1,
		["치유의 기원"] = 1,
		["하급 치유"] = 1,
		-- 드루이드
		["치유의 손길"] = 1,
		["재생"] = 1,
		["평온"] = 1,
		-- 주술사
		["치유의 물결"] = 1,
		["하급 치유의 물결"] = 1,
		-- 성기사
		["성스러운 빛"] = 1,
		["빛의 섬광"] = 1,
	};

	SA_SPELLS_CC = 
	{
		-- 사제
		["정신 지배"] = 1,
		-- 드루이드
		["휘감는 뿌리"] = 1,
		-- 마법사
		["변이"] = 1,
		-- 흑마법사
		["공포"] = 1,
		["공포의 울부짖음"] = 1,
		["현혹"] = 1,
		["악마 지배"] = 1,
		["추방"] = 1,
		-- 성기사
		["언데드 퇴치"] = 1,
		-- 사냥꾼
		-- ["야수 겁주기"] =1,
	};

	SA_SPELLS_DISPELABLE = 
	{
		-- 사제
		["신의 권능: 보호막"] = 1,
		["소생"] = 1,
		["내면의 열정"] = 1,
		["신의 권능: 인내"] = 1,
		["어둠의 보호"] = 1,
		["천상의 정신"] = 1,
		-- 드루이드
		["회복"] = 1,
		["가시"] = 1,
		["야생의 징표"] = 1,
		["재생"] = 1,
		["정신 자극"] = 1,
		-- 마법사
		["신비한 지능"] = 1,
		["냉기 갑옷"] = 1,
		["화염계 수호"] = 1,
		["냉기계 수호"] = 1,
		["얼음 갑옷"] = 1,
		["마법사 갑옷"] = 1,
		["신비의 마법 강화"] = 1,
		["얼음 보호막"] = 1,
		["마나 보호막"] = 1,
		-- 주술사
		["번개 보호막"] = 1,
		["질풍의 무기"] = 1,
		["자연의 신속함"] = 1,
		["수면 걷기"] = 1,
		["늑대 정령"] = 1,
		-- 흑마법사
		["악마의 피부"] = 1,
		["악마의 갑옷"] = 1,
		["암흑계 수호"] = 1,
		-- Unknown
		["선인의 인내력"] = 1,
		["마력의 힘"] = 1,
	};

	SA_SPELLS_DAMAGE = 
	{
		-- 사제
		["정신 분열"] = 1,
		["마나 연소"] = 1,
		["별조각"] = 1,
		["성스러운 일격"] = 1,
		["정신의 채찍"] = 1,
		["신성한 불꽃"] = 1,
		-- 드루이드
		["천벌"] = 1,
		["별빛 화살"] = 1,
		["허리케인"] = 1,
		-- 사냥꾼
		["연발 사격"] = 1,
		-- 마법사
		["얼음 화살"] = 1,
		["화염구"] = 1,
		["신비한 화살"] = 1,
		["신비한 폭발"] = 1,
		["눈보라"] = 1,
		["불덩이 작열"] = 1,
		["순간이동: 아이언포지"] = 1,
		["순간이동: 오그리마"] = 1,
		["순간이동: 스톰윈드"] = 1,
		["순간이동: 언더시티"] = 1,
		["순간이동: 다르나서스"] = 1,
		["순간이동: 썬더 블러프"] = 1,
		["차원의 문: 아이언포지"] = 1,
		["차원의 문: 오그리마"] = 1,
		["차원의 문: 스톰윈드"] = 1,
		["차원의 문: 언더시티"] = 1,
		["차원의 문: 다르나서스"] = 1,
		["차원의 문: 썬더 블러프"] = 1,
		["불태우기"] = 1,
		["불덩이 작열"] = 1,
		["불기둥"] = 1,
		-- 주술사
		["번개 화살"] = 1,
		["연쇄 번개"] = 1,
		-- 흑마법사
		["제물"] = 1,
		["부패"] = 1,
		["어둠의 화살"] = 1,
		["영혼 흡수"] = 1,
		["생명력 집중"] = 1,
		["생명력 흡수"] = 1,
		["불타는 고통"] = 1,
		["소환 의식"] = 1,
		["마나 흡수"] = 1,
		["지옥의 불길"] = 1,
		["점화"] = 1,
		["영혼의 불꽃"] = 1,
		-- 성기사
		["천벌의 망치"] = 1,
	};]]

	-- Spells/Emotes that will be ignored
	SA_SPELLS_IGNORE = 
	{
		["독 해제"] = 1;
		["조준 사격"] = 1;
		["신비한 지능"] = 1;
		["신비한 사격"] = 1;
		["은빛여명회 위임봉"] = 1;
		["치타의 상"] = 1;
		["매의 상"] = 1;
		["원숭이의 상"] = 1;
		["공격"] = 1;
		["전투의 외침"] = 1;
		["피의 분노"] = 1;
		["피의 광기"] = 1;
		["피의 서약"] = 1;
		["전투 태세"] = 1;
		["광폭 태세"] = 1;
		["폭풍의 칼날"] = 1;
		["점멸"] = 1;
		["정신 집중"] = 1;
		["충격포"] = 1;
		["질주"] = 1;
		["방어 태세"] = 1;
		["함정 감지"] = 1;
		["기원의 오라"] = 1;
		["격노"] = 1;
		["회피"] = 1;
		["폭발 사격"] = 1;
		["소실"] = 1;
		["화염 저항의 오라"] = 1;
		["질풍"] = 1;
		["집중력"] = 1;
		["신속"] = 1;
		["신성한 힘"] = 1;
		["신의 계시"] = 1;
		["줄리의 축복"] = 1;
		["냉혹함"] = 1;
		["독사 쐐기"] = 1;
		["산탄 사격"] = 1;
		["방패 막기"] = 1;
		["구원의 영혼"] = 1;
		["정신력 누출"] = 1;
		["전력 질주"] = 1;
		["은신"] = 1;
		["재빠른 변신"] = 1;
		["치타 변신"] = 1;
		["정조준 오라"] = 1;
		["살무사 쐐기"] = 1;
	};

	SA_MOBS_ACCEPT = 
	{
	};

	SA_PTN_SPELL_BEGIN_CAST = "(.+)|1이;가; (.+)|1을;를; 시전합니다.";
	SA_PTN_SPELL_GAINS_X = "(.+)|1이;가; (%d+)의 (.+)|1을;를; 얻었습니다.";
	SA_PTN_SPELL_GAINS = "(.+)|1이;가; (.+) 효과를 얻었습니다.";
	SA_PTN_SPELL_TOTEM = "(.+)|1이;가; (.+) 토템을 시전합니다.";
	SA_PTN_SPELL_FADE = "(.+)의 몸에서 (.+) 효과가 사라졌습니다.";
	SA_PTN_SPELL_BEGIN_PERFORM = "(.+)|1이;가; (.+)|1을;를; 사용합니다.";

	SA_WOTF = "언데드의 의지";
	SA_BERSERKER_RAGE = "광전사의 격노";
	SA_AFFLICT_LIVINGBOMB = "살아있는 폭탄에 걸렸습니다.";
	SA_EMOTE_DEEPBREATH = "깊은 숨을 들이쉽니다...";

elseif (GetLocale()=="deDE") then
	-- German
	SA_PTN_SPELL_BEGIN_CAST = "(.+) beginnt (.+) zu wirken.";
	SA_PTN_SPELL_GAINS_X = "(.+) bekommt (%d+) (.+).";
	SA_PTN_SPELL_GAINS = "(.+) bekommt (.+).";
	SA_PTN_SPELL_TOTEM = "(.+) wirkt (.+).";
	SA_PTN_SPELL_FADE = "(.+) schwindet von (.+).";

	SA_WOTF = "Wille der Verlassenen";
	SA_BERSERKER_RAGE = "Berserker-Wut";
	SA_AFFLICT_SCATTERSHOT = "Ihr seid von Streuschuss betroffen."
	SA_AFFLICT_FEAR = "Ihr seid von Furcht betroffen.";
	SA_AFFLICT_INTIMIDATING_SHOUT = "Ihr seid von Demoralisierungsruf betroffen.";
	SA_AFFLICT_PSYCHIC_SCREAM = "Ihr seid von Psychischer Schrei betroffen.";
	SA_AFFLICT_PANIC = "Ihr seid von Panik betroffen.";
	SA_AFFLICT_BELLOWING_ROAR = "You are afflicted by Bellowing Roar.";
	SA_AFFLICT_ANCIENT_DESPAIR = "You are afflicted by Ancient Despair.";
	SA_AFFLICT_ANCIENT_SCREECH = "You are afflicted by Terrifying Screech.";
	SA_AFFLICT_POLYMORPH = "You are afflicted by Polymorph."
	SA_SCATTERSHOT = "Streuschuss";
	SA_FEAR = "Furcht";
	SA_INTIMIDATING_SHOUT = "Demoralisierungsruf";
	SA_PSYCHIC_SCREAM = "Psychischer Schrei";
	SA_PANIC = "Panik";
	SA_BELLOWING_ROAR = "Bellowing Roar";
	SA_ANCIENT_DESPAIR = "Ancient Despair.";
	SA_SCREECH = "Terrifying Screech.";
	SA_POLYMORPH = "Polymorph."	
	
elseif (GetLocale()=="frFR") then
	-- French
	SA_PTN_SPELL_BEGIN_CAST = "(.+) commence /195/160 lancer (.+).";
	SA_PTN_SPELL_GAINS_X = "(.+) gagne (%d+) (.+).";
	SA_PTN_SPELL_GAINS = "(.+) gagne (.+).";
	SA_PTN_SPELL_TOTEM = "(.+) invoque le Totem (.+).";
	SA_PTN_SPELL_FADE = "(.+) dispara/195/174t de (.+).";
	
	SA_WOTF = "Volont/195/169 du R/195/169prouv/195/169";
	SA_BERSERKER_RAGE = "Rage du Berserker";
	SA_EMOTE_DEEPBREATH = "prend une profonde respiration...";
	SA_AFFLICT_LIVINGBOMB = "Vous subissez les effets de la Bombe Vivante.";
end
