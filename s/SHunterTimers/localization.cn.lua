if( GetLocale() == "zhCN" ) then
	--abilities-----------------------------------------
	--shots
	SHT_AIMED_SHOT = "瞄准射击";
	SHT_CONC_SHOT = "震荡射击";
	SHT_IMP_CONC = "强化震荡射击";
	SHT_IMP_CONC_SHORT = "强化震荡射击";
	SHT_SCATTER = "驱散射击";
	SHT_AUTO_SHOT = "自动射击";

	--buffs
	SHT_HUNTERS_MARK = "猎人印记";
	SHT_RAPID_FIRE = "急速射击";
	SHT_QUICK_SHOTS = "快速射击";
	SHT_EXPOSE_WEAKNESS = "破甲虚弱";
	SHT_PRIMAL_BLESSING = "远古神灵的祝福";

	--Trinkets
	SHT_DEVILSAUR = "魔暴龙眼";
	SHT_DEVILSAUR_PROC = "魔暴龙之怒";
	SHT_ZHM = "赞达拉英雄勋�";
	SHT_ZHM_PROC = "充沛之力";
	SHT_EARTHSTRIKE = "大地之击";
	SHT_SWARMGUARD = "虫群卫士徽�";
	SHT_JOM_GABBAR = "Jom Gabbar";
	SHT_KISS_SPIDER = "蜘蛛之吻";

	--pet abilities
	SHT_PET_INTIM = "胁迫";
	SHT_INTIM = "胁迫";
	SHT_BW = "狂野怒火";

	--traps
	SHT_TRAP = "陷阱";
	SHT_FROST_TRAP = "冰霜陷阱";
	SHT_EXPL_TRAP = "爆炸陷阱";
	SHT_IMMO_TRAP = "献祭陷阱";
	SHT_FREEZING_TRAP = "冰冻陷阱";
	SHT_ENTRAPMENT = "诱捕";
	SHT_AURA = "光环";
	SHT_PRIMED = "效果";

	--Melee abilities
	SHT_WING_CLIP = "摔绊";
	SHT_IMP_WC = "强化摔绊";
	SHT_IMP_WC_SHORT = "强化摔绊";
	SHT_COUNTER = "反击";
	SHT_DETERRENCE = "威慑";

	--Stings
	SHT_STING = "钉刺";
	SHT_WYVERN = "翼龙钉刺";
	SHT_WYVERN_TEXT = "翼龙钉刺(沉睡)";
	SHT_SERPENT = "毒蛇钉刺";
	SHT_VIPER = "蝰蛇钉刺";
	SHT_SCORPID = "毒蝎钉刺";

	--other
	SHT_FLARE = "照明弹";
	SHT_FEAR_BEAST = "恐吓野兽";
	SHT_YOUR = "你的";
	SHT_DONE = "完成";
	SHT_FEIGN_DEATH = "假死";

	--enemies
	SHT_FRENZY = "BOSS狂暴提示";
	SHT_FRENZY_EMOTE = "变得极为狂暴";
	SHT_FRENZY_FLAMEGOR = "变得极为狂暴";
	SHT_CHROMAGGUS = "克洛玛古斯";
	SHT_FLAMEGOR = "弗莱格尔";
	SHT_MAGMADAR = "玛格曼达";
	SHT_HUHURAN = "哈霍兰公主";
	SHT_GLUTH = "格拉斯";

	--messages
	SHT_RESIST = "抵抗";
	SHT_IMMUNE = "免疫";
	SHT_EVADE = "闪避";
	SHT_FADE = "消失";
	SHT_FAILED = "失败";
	SHT_HITS = "击中";
	SHT_CRITS = "致命一击";
	SHT_MISSES = "没有击中";

	--status text---------------------------------------
	SHT_ON = "on";
	SHT_OFF = "off";
	--Slash text
	SHT_SLASH_HELP = {
		[1] = "Sorren's Hunter Timers "..SHT_VERSION,
		[2] = "命令: /sht",
		[3] = "/sht "..SHT_ON.."/"..SHT_OFF,
		[4] = "/sht menu (显示配置菜单)命令: ",
		[5] = "/sht reset (重设计时条位置)",
		[6] = "/sht resetpos (重设计时条框位置)",
		[7] = "/sht aimed "..SHT_ON.."/"..SHT_OFF.." (开启/关闭瞄准射击计时条)",
		[8] = "/sht delay <time> (time单位为微秒)",
		[9] = "/sht aimeddelay <time> (time单位为微秒)",
		[10] = "/sht flash <timeleft> (倒计时在<timeleft>秒时闪烁计时条, 0 为关闭)",
		[11] = "/sht step <step> (<step>为闪烁频率)",
		[12] = "/sht barcolor r g b (设定计时条颜色. r, g, b 取值范围: 0 - 1)",
		[13] = "/sht barendcolor r g b (设定计时末尾颜色. r, g, b 取值范围: 0 - 1)",
		[14] = "/sht setbgcolor r g b a (设定背景颜色. r, g, b, a 取值范围: 0 - 10)",
		[15] = "/sht colorchange on/off (开/关自动变换颜色)",
		[16] = "/sht up/down (向上/下移动计时条)",
		[17] = "/sht scale % (缩放比例. /sht scale 100 = 100% 比例)",
		[18] = "/sht lock/unlock (锁定/解锁计时条位置)",
		[19] = "/sht status",
		[20] = "/sht clear all (resets all options to defaults)",
		[21] = "/sht debug (debug info for testing purposes)"
	};
	SHT_STATUS_STRINGS = {
		[1] = "|cFFFFFF00Sorren's Hunter Timers "..SHT_VERSION.."|r",
		[2] = "|cFFFFFF00状态:|r %s |cFFFFFF00瞄准射击计时条:|r %s",
		[3] = "|cFFFFFF00射击延时:|r %dms |cFFFFFF00瞄准射击延时:|r %dms",
		[4] = "|cFFFFFF00闪烁时间:|r %ds |cFFFFFF00频率:|r %f",
		[5] = "|cFFFFFF00计时条颜色:|r %s |cFFFFFF00计时末尾颜色:|r %s",
		[6] = "|cFFFFFF00颜色变换:|r %s |cFFFFFF00增长:|r %s",
		[7] = "|cFFFFFF00缩放比例:|r %d%%"
	};

	SHT_OPTIONS_COLOR_CHANGE = "自动变换颜色";
	SHT_OPTIONS_MILI = "ms";
	SHT_OPTIONS_LOCK = "锁定计时条";
	SHT_OPTIONS_BAR_DIST = "计时条间隔";
	SHT_OPTIONS_SCALE = "缩放比例";
	SHT_OPTIONS_FLASH = "闪烁时间";
	SHT_OPTIONS_STEP = "闪烁频率";
	SHT_OPTIONS_BARSTART = "计时起始颜色";
	SHT_OPTIONS_BAREND = "计时结尾颜色";
	SHT_OPTIONS_BACKDROP = "背景颜色";
	SHT_OPTIONS_TIMERS_TEXT = "计时器";
	SHT_OPTIONS_BARS_TEXT = "计时条";
	SHT_OPTIONS_DECIMALS = "小数位";
	SHT_OPTIONS_AIMED_DELAY = "瞄准延时";
	SHT_OPTIONS_SHOT_DELAY = "射击延时";
	SHT_OPTIONS_SHOW_TEX = "显示图标";
	SHT_OPTIONS_LARGE_TEX = "大图标";
	SHT_OPTIONS_APPEND = "显示作用目标";
	SHT_OPTIONS_BORDER = "边框颜色";
	SHT_OPTIONS_TEXT_COLOR = "文本颜色";
	SHT_OPTIONS_TIME_COLOR = "时间颜色";
	SHT_OPTIONS_TARGET_COLOR = "目标文本颜色";
	SHT_OPTIONS_OVERALL_OPACITY = "透明度";
	SHT_OPTIONS_HIDE_TEXT = "隐藏文本";
	SHT_OPTIONS_HIDE_TIME = "隐藏时间";
	SHT_OPTIONS_HIDE_GAP = "隐藏间隙";
	SHT_OPTIONS_BAR_THICKNESS = "计时条粗细";
	SHT_OPTIONS_HIDE_PADDING = "隐藏内边框";
	SHT_OPTIONS_STICKY = "自动射击";

	--Regular Expression Strings
	SHT_TRAP_AFFLICT_STRING = "(.+)受到了(.+陷阱)";
	SHT_AFFLICT_STRING = "(.+)受到了(.+)";
	SHT_FAILED_STRING = "你的(.+)施放失败";
	SHT_MISSES_STRING = "你的(.+)没有击中(.+)";
	SHT_FIND_TRAP_FAILED = "的(.+陷阱)";
	SHT_FADE_STRING = "(.+)从(.+)身上消失";
	SHT_SPELL_RANK_STRIP = "(.+)%(等级 %d+%)";
	SHT_DIES = "(.+)死亡";

	--Options moved to globals because they dealt with other variables

end
