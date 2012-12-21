local L = AceLibrary("AceLocale-2.2"):new("RegenFu")

L:RegisterTranslations("koKR", function() return {
	NAME = "FuBar - RegenFu",
	DESCRIPTION = "HP/MP 재생률을 표시합니다.",
		
	HP_LABEL = "HP: ";
	MP_LABEL = "MP: ";
	FSR_LABEL = "FSR: ",

	MENU_SHOW_HP = "생명력 표시";
	MENU_SHOW_MP = "마나 표시";
    
    ["Show FSRT"] = "5초룰관련 정보 표시",
    
	MENU_SHOW_PERCENT = "백분률로 표시";
	MENU_SHOW_CURRENT = "현재값 표시";
	
	["Show In Combat Regen Total"] = "전투중 재생량총합 보기",


	MENU_HIDE_LABEL = "구분명 숨김";
	
	TOOLTIP1_LEFT 		= "생명력:";
	TOOLTIP2_LEFT 		= "마나:";
	TOOLTIP3_LEFT 		= "최대 생명력 재생률:";
	TOOLTIP4_LEFT 		= "최저 생명력 재생률:";
	TOOLTIP5_LEFT 		= "최대 마나 재생률:";
	TOOLTIP6_LEFT 		= "최저 마나 재생률:";
	TOOLTIP7_LEFT 		= "전투간 마나 재생:";
	TOOLTIP8_LEFT 		= "전투간 생명력 재생:";
	TOOLTIP9_LEFT			= "전투간 평균 마나 재생:";
    
   	["AceConsole-commands"] = { "/regenfu" },

    ["Percent Regen While Casting"] = "시전중 재생 백분률",
    ["Mana Regen Forumula (Spirit/<value>)"] = "마나 재생 공식(정신력/<값>)",
    ["Mana Per Int"] = "지능에 따른 마나",


   	["Reset FSR Data"] = "5초룰 데이터 초기화",
    ["Time Spent In Regen"] = "재생에 필요한 시간",
    ["(This Fight)"]    = "(이번 전투)", 
    ["(Last Fight)"]    = "(지난 전투)", 

    ["Total Regen Time Observed"]        = "확인 시간 중 총 재생량",
    ["% Of That Time In FSR"] = "5초룰에 따른 시간중 재생 백분률", 
    ["Spirit Needed To Equal 1mp5"]         = "5초당 1마나 회복과 동일한 정신력 요구치",
    ["Int Needed To Equal 1mp5"]        = "5초당 1마나 회복과 동일한 지능 요구치",
    
    ["FSR Countdown Bar"] = "5초룰 바",
    ["FSR"] = "5초룰",

 } end )

