local L = AceLibrary("AceLocale-2.0"):new("RegenFu")

L:RegisterTranslations("koKR", function() return {
	NAME = "FuBar - RegenFu",
	DESCRIPTION = "HP/MP 재생률을 표시합니다.",
		
	HP_LABEL = "HP: ";
	MP_LABEL = "MP: ";

	MENU_SHOW_HP = "생명력 표시";
	MENU_SHOW_MP = "마나 표시";
	MENU_SHOW_PERCENT = "백분률로 표시";
	MENU_SHOW_CURRENT = "현재값 표시";

	MENU_HIDE_LABEL = "구분명 숨김";
	
	TOOLTIP1_LEFT 		= "생명력:";
	TOOLTIP2_LEFT 		= "마나:";
	TOOLTIP3_LEFT 		= "최대 생명력 재생률:";
	TOOLTIP4_LEFT 		= "최저 생명력 재생률:";
	TOOLTIP5_LEFT 		= "최대 마나 재생률:";
	TOOLTIP6_LEFT 		= "최저 마나 재생률:";
	TOOLTIP7_LEFT 		= "전투간 마나 재생:";
	TOOLTIP8_LEFT 		= "전투간 생명력 재생:";
	
} end )

