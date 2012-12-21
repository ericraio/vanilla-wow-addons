local L = AceLibrary("AceLocale-2.2"):new("RegenFu")

L:RegisterTranslations("zhTW", function() return {
	NAME = "FuBar - RegenFu",
	DESCRIPTION = "顯示 HP/MP 回復速度。",
		
	HP_LABEL = "HP: ";
	MP_LABEL = "MP: ";
	FSR_LABEL = "FSR: ",

	MENU_SHOW_HP = "顯示 HP";
	MENU_SHOW_MP = "顯示 MP";
    
    ["Show FSRT"] = "顯示 FSRT",
    
	MENU_SHOW_PERCENT = "顯示百分比";
	MENU_SHOW_CURRENT = "顯示目前數值";
	
	["Show In Combat Regen Total"] = "顯示戰鬥中回復統計",


	MENU_HIDE_LABEL = "隱藏標籤";
	
	TOOLTIP1_LEFT 		= "HP:";
	TOOLTIP2_LEFT 		= "MP:";
	TOOLTIP3_LEFT 		= "最高HP回復:";
	TOOLTIP4_LEFT 		= "最低HP回復:";
	TOOLTIP5_LEFT 		= "最高MP回復:";
	TOOLTIP6_LEFT 		= "最低MP回復:";
	TOOLTIP7_LEFT 		= "前次戰鬥MP回復:";
	TOOLTIP8_LEFT 		= "前次戰鬥HP回復:";
	TOOLTIP9_LEFT			= "最後一次戰鬥MP平均回復量:";
    
   	["AceConsole-commands"] = { "/regenfu" },

    ["Percent Regen While Casting"] = "施法中回復法力百分比",
    ["Mana Regen Forumula (Spirit/<value>)"] = "法力回復公式(精神/<數值>)",
    ["Mana Per Int"] = "每點智力增加的法力",


   	["Reset FSR Data"] = "重置FSR資料",
    ["Time Spent In Regen"] = "回魔花費時間",
    ["(This Fight)"]    = "(本次戰鬥)", 
    ["(Last Fight)"]    = "(上次戰鬥)", 

    ["Total Regen Time Observed"]        = "總回復法力時間觀測",
    ["% Of That Time In FSR"] = "5秒回1法花費時間(FSRT)時間百分比", 
    ["Spirit Needed To Equal 1mp5"]         = "5秒回1法所等價的精神",
    ["Int Needed To Equal 1mp5"]        = "5秒回1法所等價的智力", 
 } end )

