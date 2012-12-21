if( GetLocale() == "zhTW" ) then
	--abilities-----------------------------------------
	--shots
	SHT_AIMED_SHOT = "瞄準射擊";
	SHT_CONC_SHOT = "震盪射擊";
	SHT_IMP_CONC = "強化震盪射擊";
	SHT_IMP_CONC_SHORT = "強化震盪射擊";
	SHT_SCATTER = "驅散射擊";
	SHT_AUTO_SHOT = "自動射擊";

	--buffs
	SHT_HUNTERS_MARK = "獵人印記";
	SHT_RAPID_FIRE = "急速射擊";
	SHT_QUICK_SHOTS = "快速射擊";
	SHT_EXPOSE_WEAKNESS = "破甲虛弱";
	SHT_PRIMAL_BLESSING = "遠古神靈的祝福";

	--Trinkets
	SHT_DEVILSAUR = "魔暴龍眼";
	SHT_DEVILSAUR_PROC = "魔暴龍之怒";
	SHT_ZHM = "贊達拉英雄勳章";
	SHT_ZHM_PROC = "充沛之力";
	SHT_EARTHSTRIKE = "大地之擊";
	SHT_SWARMGUARD = "蟲群守衛徽章";
	SHT_JOM_GABBAR = "姜姆·蓋伯";
	SHT_KISS_SPIDER = "蜘蛛之吻";

	--pet abilities
	SHT_PET_INTIM = "脅迫";
	SHT_INTIM = "脅迫";
	SHT_BW = "狂野怒火";

	--traps
	SHT_TRAP = "陷阱";
	SHT_FROST_TRAP = "冰霜陷阱";
	SHT_EXPL_TRAP = "爆炸陷阱";
	SHT_IMMO_TRAP = "獻祭陷阱";
	SHT_FREEZING_TRAP = "冰凍陷阱";
	SHT_ENTRAPMENT = "誘捕";
	SHT_AURA = "光環";
	SHT_PRIMED = "效果";

	--Melee abilities
	SHT_WING_CLIP = "摔絆";
	SHT_IMP_WC = "強化摔絆";
	SHT_IMP_WC_SHORT = "強化摔絆";
	SHT_COUNTER = "反擊";
	SHT_DETERRENCE = "威懾";

	--Stings
	SHT_STING = "釘刺";
	SHT_WYVERN = "翼龍釘刺";
	SHT_WYVERN_TEXT = "翼龍釘刺(沉睡)";
	SHT_SERPENT = "毒蛇釘刺";
	SHT_VIPER = "蝮蛇釘刺";
	SHT_SCORPID = "毒蠍釘刺";

	--other
	SHT_FLARE = "照明彈";
	SHT_FEAR_BEAST = "恐嚇野獸";
	SHT_YOUR = "你的";
	SHT_DONE = "完成!";
	SHT_FEIGN_DEATH = "假死";

	--enemies
	SHT_FRENZY = "BOSS狂暴提示";
	SHT_FRENZY_EMOTE = "變得極為狂暴!";
	SHT_FRENZY_FLAMEGOR = "變得極為狂暴";
	SHT_CHROMAGGUS = "克洛瑪古斯";
	SHT_FLAMEGOR = "弗萊格爾";
	SHT_MAGMADAR = "瑪格曼達";
	SHT_HUHURAN = "哈霍蘭公主";
	SHT_GLUTH = "古魯斯";
	
	--messages
	SHT_RESIST = "抵抗";
	SHT_IMMUNE = "免疫";
	SHT_EVADE = "閃避";
	SHT_FADE = "消失";
	SHT_FAILED = "失敗";
	SHT_HITS = "擊中";
	SHT_CRITS = "致命一擊";
	SHT_MISSES = "沒有擊中";

	--status text---------------------------------------
	SHT_ON = "on";
	SHT_OFF = "off";
	--Slash text
	SHT_SLASH_HELP = {
		[1] = "Sorren's Hunter Timers "..SHT_VERSION,
		[2] = "命令: /sht",
		[3] = "/sht "..SHT_ON.."/"..SHT_OFF,
		[4] = "/sht menu (顯示設置目錄)命令: ",
		[5] = "/sht reset (重設計時條位置)",
		[6] = "/sht resetpos (重設計時條框位置)",
		[7] = "/sht aimed "..SHT_ON.."/"..SHT_OFF.." (開啟/關閉瞄準射擊計時條)",
		[8] = "/sht delay <time> (time單位為微秒)",
		[9] = "/sht aimeddelay <time> (time單位為微秒)",
		[10] = "/sht flash <timeleft> (倒計時在<timeleft>秒時閃爍計時條, 0 為關閉)",
		[11] = "/sht step <step> (<step>為閃爍頻率)",
		[12] = "/sht barcolor r g b (設定計時條顏色. r, g, b 取值範圍: 0 - 1)",
		[13] = "/sht barendcolor r g b (設定計時末尾顏色. r, g, b 取值範圍: 0 - 1)",
		[14] = "/sht setbgcolor r g b a (設定背景顏色. r, g, b, a 取值範圍: 0 - 10)",
		[15] = "/sht colorchange on/off (開/關自動變換顏色)",
		[16] = "/sht up/down (向上/下移動計時條)",
		[17] = "/sht scale % (縮放比例. /sht scale 100 = 100% 比例)",
		[18] = "/sht lock/unlock (鎖定/解鎖計時條位置)",
		[19] = "/sht status",
		[20] = "/sht clear all (resets all options to defaults)",
		[21] = "/sht debug (debug info for testing purposes)"
	};
	SHT_STATUS_STRINGS = {
		[1] = "|cFFFFFF00Sorren's Hunter Timers "..SHT_VERSION.."|r",
		[2] = "|cFFFFFF00狀態:|r %s |cFFFFFF00瞄準射擊計時條:|r %s",
		[3] = "|cFFFFFF00射擊延時:|r %dms |cFFFFFF00瞄準射擊延時:|r %dms",
		[4] = "|cFFFFFF00閃爍時間:|r %ds |cFFFFFF00頻率:|r %f",
		[5] = "|cFFFFFF00計時條顏色:|r %s |cFFFFFF00計時末尾顏色:|r %s",
		[6] = "|cFFFFFF00顏色變換:|r %s |cFFFFFF00增長:|r %s",
		[7] = "|cFFFFFF00縮放比例:|r %d%%"
	};

	SHT_OPTIONS_COLOR_CHANGE = "自動變換顏色";
	SHT_OPTIONS_MILI = "ms";
	SHT_OPTIONS_LOCK = "鎖定計時條";
	SHT_OPTIONS_BAR_DIST = "計時條間隔";
	SHT_OPTIONS_SCALE = "縮放比例";
	SHT_OPTIONS_FLASH = "閃爍時間";
	SHT_OPTIONS_STEP = "閃爍頻率";
	SHT_OPTIONS_BARSTART = "計時起始顏色";
	SHT_OPTIONS_BAREND = "計時結尾顏色";
	SHT_OPTIONS_BACKDROP = "背景顏色";
	SHT_OPTIONS_TIMER_TEXT = "計時器";
	SHT_OPTIONS_BARS_TEXT = "計時條";
	SHT_OPTIONS_AIMED = "瞄準射擊計時條";
	SHT_OPTIONS_DECIMALS = "小數位";
	SHT_OPTIONS_AIMED_DELAY = "瞄準延時";
	SHT_OPTIONS_SHOT_DELAY = "射擊延時";
	SHT_OPTIONS_SHOW_TEX = "顯示圖示";
	SHT_OPTIONS_LARGE_TEX = "大圖示";
	SHT_OPTIONS_APPEND = "顯示作用目標";
	SHT_OPTIONS_BORDER = "邊框顏色";
	SHT_OPTIONS_TEXT_COLOR = "文本顏色";
	SHT_OPTIONS_TIME_COLOR = "時間顏色";
	SHT_OPTIONS_TARGET_COLOR = "目標文字顏色";
	SHT_OPTIONS_OVERALL_OPACITY = "透明度";
	SHT_OPTIONS_HIDE_TEXT = "隱藏文字";
	SHT_OPTIONS_HIDE_TIME = "隱藏時間";
	SHT_OPTIONS_HIDE_GAP = "隱藏間隙";
	SHT_OPTIONS_BAR_THICKNESS = "計時條粗細";
	SHT_OPTIONS_HIDE_PADDING = "隱藏內邊框";
	SHT_OPTIONS_STICKY = "依附自動射擊";

	--Regular Expression Strings
	SHT_TRAP_AFFLICT_STRING = "(.+)受到了(.+陷阱)";
	SHT_AFFLICT_STRING = "(.+)受到了(.+)";
	SHT_FAILED_STRING = "你的(.+)施放失敗";
	SHT_MISSES_STRING = "你的(.+)沒有擊中(.+)";
	SHT_FIND_TRAP_FAILED = "的(.+陷阱)";
	SHT_FADE_STRING = "(.+)從(.+)身上消失";
	SHT_SPELL_RANK_STRIP = "(.+)%(等級 %d+%)";
	SHT_DIES = "(.+)死亡";

	--Options moved to globals because they dealt with other variables

end
