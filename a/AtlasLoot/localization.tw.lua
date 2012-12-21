-- [[
-- Version: 1.17.03
-- Last Updated: 2006/08/02
-- Maintained by: Arith Hsu
-- ]]
if (GetLocale() == 	"zhTW") then
-----------------------
-- Localised Globals --
-----------------------
ATLASLOOT_FIRST_TIME_TEXT = 	"歡迎使用 AtlasLoot Enhanced. 請花一點時間來設定訊息提示和連結的喜好. 輸入 /atlasloot 可以再次設定喜好選項";
ATLASLOOT_FIRST_TIME_BUTTON = 	"設定";

ATLASLOOT_OLD_ATLAS_TEXT_PT1 = 	"您現在的 Atlas 插件版本並不完全支援此版本的 Atlasloot, Atlas 的最新版本為 (";
ATLASLOOT_OLD_ATLAS_TEXT_PT2 = 	"). 依 Atlas 版本的變化, AtlasLoot 也許會出現偶然的錯誤, 請儘快前往 http://www.atlasmod.com 更新";
ATLASLOOT_OLD_ATLAS_BUTTON = 	"OK";

ATLASLOOT_DROP_RATE = 	"掉落機率: ";
ATLASLOOT_DKP = 		"DKP";

ATLASLOOT_BANNER_TEXT = 	"點選首領名稱查閱掉落物."

ATLASLOOT_UIBACK = 		"返回";

ATLASLOOT_CLOTH = 		"布甲";
ATLASLOOT_LEATHER = 	"皮甲";
ATLASLOOT_MAIL = 		"鎖甲";
ATLASLOOT_PLATE = 		"鎧甲";

ATLASLOOT_HEAD = 		"頭部";
ATLASLOOT_NECK = 		"頸部";
ATLASLOOT_SHOULDER = 	"肩部";
ATLASLOOT_BACK = 		"背部";
ATLASLOOT_CHEST = 		"胸部";
ATLASLOOT_SHIRT = 		"襯衣";
ATLASLOOT_TABARD = 		"公會徽章";
ATLASLOOT_WRIST = 		"手腕";
ATLASLOOT_HANDS = 		"手";
ATLASLOOT_WAIST = 		"腰部";
ATLASLOOT_LEGS = 		"腿部";
ATLASLOOT_FEET = 		"腳";
ATLASLOOT_RING = 		"手指";
ATLASLOOT_TRINKET = 	"飾品";
ATLASLOOT_OFF_HAND = 	"副手物品";
ATLASLOOT_RELIC = 		"聖物";

ATLASLOOT_ONE_HAND = 	"單手";
ATLASLOOT_TWO_HAND = 	"雙手";
ATLASLOOT_MAIN_HAND = 	"主手";
ATLASLOOT_OFFHAND = 	"副手";

ATLASLOOT_AXE = 		"斧";
ATLASLOOT_BOW = 		"弓";
ATLASLOOT_CROSSBOW = 	"弩";
ATLASLOOT_DAGGER = 		"匕首";
ATLASLOOT_GUN = 		"槍";
ATLASLOOT_MACE = 		"錘";
ATLASLOOT_POLEARM = 	"長柄武器";
ATLASLOOT_SHIELD = 		"盾牌";
ATLASLOOT_STAFF = 		"法杖";
ATLASLOOT_SWORD = 		"劍";
ATLASLOOT_THROWN = 		"投擲武器";
ATLASLOOT_WAND = 		"魔杖";
ATLASLOOT_FIST = 		"拳套";

ATLASLOOT_POTION = 			"藥物";
ATLASLOOT_FOOD = 			"食物";
ATLASLOOT_DRINK = 			"水";
ATLASLOOT_BANDAGE = 		"繃帶";
ATLASLOOT_ARROW = 			"箭";
ATLASLOOT_BULLET = 			"子彈"
ATLASLOOT_MOUNT = 			"坐騎";
ATLASLOOT_AMMO = 			"彈藥袋";
ATLASLOOT_QUIVER = 			"箭袋";
ATLASLOOT_BAG = 			"背包";
ATLASLOOT_ENCHANT = 		"公式";
ATLASLOOT_TRADE_GOODS = 	"商品";
ATLASLOOT_SCOPE = 			"瞄準鏡";
ATLASLOOT_KEY = 			"鑰匙";
ATLASLOOT_PET = 			"寵物";
ATLASLOOT_IDOL = 			"雕像";
ATLASLOOT_TOTEM = 			"圖騰";
ATLASLOOT_LIBRAM = 			"聖契";
ATLASLOOT_DARKMOON = 		"暗月卡";
ATLASLOOT_BOOK = 			"書籍";
ATLASLOOT_BANNER = 			"軍旗";

ATLASLOOT_DRUID = 		"德魯伊";
ATLASLOOT_HUNTER = 		"獵人";
ATLASLOOT_MAGE = 		"法師";
ATLASLOOT_PALADIN = 	"聖騎士";
ATLASLOOT_PRIEST = 		"牧師";
ATLASLOOT_ROGUE = 		"盜賊";
ATLASLOOT_SHAMAN = 		"薩滿";
ATLASLOOT_WARLOCK = 	"術士";
ATLASLOOT_WARRIOR = 	"戰士";

ATLASLOOT_ALCHEMY = 		"煉金";
ATLASLOOT_BLACKSMITHING = 	"鍛造";
ATLASLOOT_COOKING = 		"烹飪";
ATLASLOOT_ENCHANTING = 		"附魔";
ATLASLOOT_ENGINEERING = 	"工程學";
ATLASLOOT_FIRST_AID = 		"急救";
ATLASLOOT_LEATHERWORKING = 	"製皮";
ATLASLOOT_TAILORING = 		"裁縫";
ATLASLOOT_DRAGONSCALE = 	"龍鱗";
ATLASLOOT_TRIBAL = 			"部族";
ATLASLOOT_ELEMENTAL = 		"元素";

ATLASLOOT_NEUTRAL = 	"中立";
ATLASLOOT_FRIENDLY = 	"友善";
ATLASLOOT_HONORED = 	"尊敬";
ATLASLOOT_REVERED = 	"崇敬";
ATLASLOOT_EXALTED = 	"崇拜";

ATLASLOOT_CLASSES = 	"職業:";
ATLASLOOT_QUEST1 = 		"該物品將觸發一個任務";
ATLASLOOT_QUEST2 = 		"任務物品";
ATLASLOOT_QUEST3 = 		"任務獎勵";
ATLASLOOT_SHARED = 		"都掉落";
ATLASLOOT_HORDE = 		"部落";
ATLASLOOT_ALLIANCE = 	"聯盟";
ATLASLOOT_UNIQUE = 		"唯一";
ATLASLOOT_RIGHTSIDE = 	"右半部份";
ATLASLOOT_LEFTSIDE = 	"左半部份";
ATLASLOOT_FELCOREBAG = 	"28 格靈魂碎片";
ATLASLOOT_ONYBAG = 		"18 格";
ATLASLOOT_WCBAG = 		"10 格";
ATLASLOOT_FULLSKILL = 	"(300)";
ATLASLOOT_295 = 		"(295)";
ATLASLOOT_275 = 		"(275)";
ATLASLOOT_265 = 		"(265)";
ATLASLOOT_290 = 		"(290)";
ATLASLOOT_SET = 		"套裝";
ATLASLOOT_285 = 		"(285)";
ATLASLOOT_16SLOT = 		"16 格";

ATLASLOOT_VIPERSET = 	"套裝: 毒蛇的擁抱 (5 件)";
ATLASLOOT_COBRAHN = 	"考布萊恩 掉落";
ATLASLOOT_ANACONDRA = 	"安娜科德拉 掉落";
ATLASLOOT_SERPENTIS = 	"瑟芬迪斯 掉落";
ATLASLOOT_FANGDRUID = 	"尖牙德魯伊 掉落";
ATLASLOOT_PYTHAS = 		"皮薩斯 掉落";

ATLASLOOT_DEFIASSET = 		"套裝: 迪菲亞皮甲 (5 件)";
ATLASLOOT_VANCLEEF = 		"艾德溫‧范克里夫 掉落";
ATLASLOOT_GREENSKIN = 		"綠皮隊長 掉落";
ATLASLOOT_DEFIASMINER = 	"迪菲亞赤膊礦工 掉落";
ATLASLOOT_DEFIASOVERSEER = 	"迪菲亞工頭/迪菲亞監工 掉落";

ATLASLOOT_Primal_Hakkari_Kossack = 		"原始哈卡萊套索";
ATLASLOOT_Primal_Hakkari_Shawl = 		"原始哈卡萊披肩";
ATLASLOOT_Primal_Hakkari_Bindings = 	"原始哈卡萊護腕";
ATLASLOOT_Primal_Hakkari_Sash = 		"原始哈卡萊腰帶";
ATLASLOOT_Primal_Hakkari_Stanchion = 	"原始哈卡萊直柱";
ATLASLOOT_Primal_Hakkari_Aegis = 		"原始哈卡萊之盾";
ATLASLOOT_Primal_Hakkari_Girdle = 		"原始哈卡萊束帶";
ATLASLOOT_Primal_Hakkari_Armsplint = 	"原始哈卡萊護臂";
ATLASLOOT_Primal_Hakkari_Tabard = 		"原始哈卡萊徽章";

ATLASLOOT_Qiraji_Ornate_Hilt = 		"其拉華麗刀柄";
ATLASLOOT_Qiraji_Martial_Drape = 	"其拉軍用披風";
ATLASLOOT_Qiraji_Magisterial_Ring =	"其拉將領戒指";
ATLASLOOT_Qiraji_Ceremonial_Ring = 	"其拉典禮戒指";
ATLASLOOT_Qiraji_Regal_Drape = 		"其拉帝王披風";
ATLASLOOT_Qiraji_Spiked_Hilt = 		"其拉尖刺刀柄";

ATLASLOOT_Qiraji_Bindings_of_Dominance = 	"其拉統御腕輪";
ATLASLOOT_Veknilashs_Circlet = 				"維克尼拉斯的頭飾";
ATLASLOOT_Ouros_Intact_Hide = 				"奧羅的外皮";
ATLASLOOT_Husk_of_the_Old_God = 			"上古之神的外殼";
ATLASLOOT_Qiraji_Bindings_of_Command = 		"其拉命令腕輪";
ATLASLOOT_Veklors_Diadem = 					"維克洛爾的王冠";
ATLASLOOT_Skin_of_the_Great_Sandworm = 		"巨型沙蟲的皮";
ATLASLOOT_Carapace_of_the_Old_God = 		"上古之神的甲殼";

ATLASLOOT_SCARLETSET = 			"套裝︰血色十字軍鏈甲（6件）";
ATLASLOOT_SCARLETDEFENDER = 	"血色防禦者/血色僕從掉落";
ATLASLOOT_SCARLETTRASH = 		"普通怪物掉落";
ATLASLOOT_SCARLETCHAMPION = 	"血色勇士掉落";
ATLASLOOT_SCARLETCENTURION = 	"血色百夫長掉落";
ATLASLOOT_SCARLETHEROD = 		"赫洛德/莫格萊尼掉落";
ATLASLOOT_SCARLETPROTECTOR = 	"血色保衛者/血色衛兵掉落";

ATLASLOOT_AQ40_SETS =	"安其拉神廟套裝";
ATLASLOOT_AQ20_SETS =	"安其拉廢墟套裝";
ATLASLOOT_ZG_SETS =		"祖爾格拉布套裝";
ATLASLOOT_TIER0_SETS =	"T0 套裝";
ATLASLOOT_TIER05_SETS =	"T0.5 套裝";
ATLASLOOT_TIER1_SETS =	"T1 套裝";
ATLASLOOT_TIER2_SETS =	"T2 套裝";
ATLASLOOT_TIER3_SETS =	"T3 套裝";
ATLASLOOT_PVP_SETS =	"PvP 套裝";

ATLASLOOT_ZG_DRUID =	"占卜師套裝";
ATLASLOOT_ZG_HUNTER =	"捕獵者套裝";
ATLASLOOT_ZG_MAGE =		"幻術師套裝";
ATLASLOOT_ZG_PALADIN =	"思考者護甲";
ATLASLOOT_ZG_PRIEST =	"懺悔者衣飾";
ATLASLOOT_ZG_ROGUE =	"狂妄者套裝";
ATLASLOOT_ZG_SHAMAN =	"預言者套裝";
ATLASLOOT_ZG_WARLOCK =	"惡魔師護甲";
ATLASLOOT_ZG_WARRIOR =	"辯護者重甲";

ATLASLOOT_AQ20_DRUID =		"不滅生命套裝";
ATLASLOOT_AQ20_HUNTER =		"隱秘通途套裝";
ATLASLOOT_AQ20_MAGE =		"魔法祕密套裝";
ATLASLOOT_AQ20_PALADIN =	"永恆公正套裝";
ATLASLOOT_AQ20_PRIEST =		"無盡智慧套裝";
ATLASLOOT_AQ20_ROGUE =		"籠罩陰影套裝";
ATLASLOOT_AQ20_SHAMAN =		"聚集風暴套裝";
ATLASLOOT_AQ20_WARLOCK =	"禁斷邪語套裝";
ATLASLOOT_AQ20_WARRIOR =	"堅定力量套裝";

ATLASLOOT_AQ40_DRUID =		"起源套裝";
ATLASLOOT_AQ40_HUNTER =		"攻擊者";
ATLASLOOT_AQ40_MAGE =		"神祕套裝";
ATLASLOOT_AQ40_PALADIN =	"復仇者";
ATLASLOOT_AQ40_PRIEST =		"神諭者套裝";
ATLASLOOT_AQ40_ROGUE =		"死亡執行者";
ATLASLOOT_AQ40_SHAMAN =		"風暴召喚者";
ATLASLOOT_AQ40_WARLOCK =	"厄運召喚者";
ATLASLOOT_AQ40_WARRIOR =	"征服者";

ATLASLOOT_T0_DRUID =	"野性之心";
ATLASLOOT_T0_HUNTER =	"馭獸者";
ATLASLOOT_T0_MAGE =		"博學者";
ATLASLOOT_T0_PALADIN =	"光鑄";
ATLASLOOT_T0_PRIEST =	"虔誠";
ATLASLOOT_T0_ROGUE =	"迅影";
ATLASLOOT_T0_SHAMAN =	"元素";
ATLASLOOT_T0_WARLOCK =	"鬼霧";
ATLASLOOT_T0_WARRIOR =	"勇氣";

ATLASLOOT_T05_DRUID =	"野獸之心";
ATLASLOOT_T05_HUNTER =	"獸王";
ATLASLOOT_T05_MAGE =	"巫師";
ATLASLOOT_T05_PALADIN =	"靈鑄";
ATLASLOOT_T05_PRIEST =	"正義";
ATLASLOOT_T05_ROGUE =	"闇影";
ATLASLOOT_T05_SHAMAN =	"五雷";
ATLASLOOT_T05_WARLOCK =	"亡霧";
ATLASLOOT_T05_WARRIOR =	"英雄";

ATLASLOOT_T1_DRUID =	"塞納里奧";
ATLASLOOT_T1_HUNTER =	"巨獸之王";
ATLASLOOT_T1_MAGE =		"祕法師";
ATLASLOOT_T1_PALADIN =	"秩序之源";
ATLASLOOT_T1_PRIEST =	"預言";
ATLASLOOT_T1_ROGUE =	"夜幕殺手";
ATLASLOOT_T1_SHAMAN =	"大地之怒";
ATLASLOOT_T1_WARLOCK =	"惡魔之心";
ATLASLOOT_T1_WARRIOR =	"力量";

ATLASLOOT_T2_DRUID =	"怒風";
ATLASLOOT_T2_HUNTER =	"馭龍者";
ATLASLOOT_T2_MAGE =		"靈風";
ATLASLOOT_T2_PALADIN =	"審判";
ATLASLOOT_T2_PRIEST =	"卓越";
ATLASLOOT_T2_ROGUE =	"血牙";
ATLASLOOT_T2_SHAMAN =	"無盡風暴";
ATLASLOOT_T2_WARLOCK =	"復仇";
ATLASLOOT_T2_WARRIOR =	"憤怒";

ATLASLOOT_T3_DRUID =	"夢行者";
ATLASLOOT_T3_HUNTER =	"地穴行者";
ATLASLOOT_T3_MAGE =		"霜火";
ATLASLOOT_T3_PALADIN =	"救贖";
ATLASLOOT_T3_PRIEST =	"信仰";
ATLASLOOT_T3_ROGUE =	"骨鐮";
ATLASLOOT_T3_SHAMAN =	"粉碎大地";
ATLASLOOT_T3_WARLOCK =	"瘟疫之心";
ATLASLOOT_T3_WARRIOR =	"無畏";

ATLASLOOT_AQ40_CLASS_SET_PIECES_1 = 	"X) AQ40 職業套裝";
ATLASLOOT_ZG_CLASS_SET_PIECES_1 = 		"X) ZG 職業套裝";
ATLASLOOT_AQ20_CLASS_SET_PIECES_1 = 	"X) AQ20 職業套裝";
ATLASLOOT_NAXX_SET_PIECES = 			"X) T3 套裝";
ATLASLOOT_BWL_SET_PIECES = 				"X) T2 套裝";
ATLASLOOT_MC_SET_PIECES = 				"X) T1 套裝";
ATLASLOOT_T0_SET_PIECES = 				"X) T0 套裝";
ATLASLOOT_T05_SET_PIECES = 				"X) T0.5 套裝";
ATLASLOOT_AQ_ENCHANTS = 				"X) AQ 公式";
ATLASLOOT_ZG_ENCHANTS = 				"X) ZG 公式";
ATLASLOOT_CLASS_BOOKS = 				"X) 職業技能書";
ATLASLOOT_TRIBUTE_RUN = 				"X) 貢品";
ATLASLOOT_DM_BOOKS = 					"X) 厄運書籍";
ATLASLOOT_TRASH_MOBS = 					"X) 小怪掉落";
ATLASLOOT_RANDOM_LOOT = 				"X) BOSS 隨機掉落";
ATLASLOOT_CLASS_SET_PIECES = 			"X) 聲望獎勵裝備";
ATLASLOOT_NO_ITEMINFO = 				" |cffff0000（無物品資訊）";

ATLASLOOT_OPTIONS_TITLE = 						"AtlasLoot 選項";
ATLASLOOT_OPTIONS_SAFE_LINKS = 					"安全物品連結|cff1eff00（建議）|r";
ATLASLOOT_OPTIONS_ALL_LINKS = 					"使用所有連結|cffff0000（可能導致斷線!）|r";
ATLASLOOT_OPTIONS_DEFAULT_TOOLTIPS = 			"預設提示";
ATLASLOOT_OPTIONS_LOOTLINK_TOOLTIPS = 			"Lootlink 提示|cff1eff00（建議）|r";
ATLASLOOT_OPTIONS_LOOTLINK_TOOLTIPS_DISABLED = 	"|cff9d9d9dLootlink 提示（建議）|r";
ATLASLOOT_OPTIONS_ITEMSYNC_TOOLTIPS = 			"ItemSync 提示";
ATLASLOOT_OPTIONS_ITEMSYNC_TOOLTIPS_DISABLED = 	"|cff9d9d9dItemSync 提示|r";
ATLASLOOT_OPTIONS_EQUIPCOMPARE = 				"使用 EquipCompare";
ATLASLOOT_OPTIONS_EQUIPCOMPARE_DISABLED = 		"|cff9d9d9d使用 EquipCompare|r";
ATLASLOOT_OPTIONS_DONE = 						"完成";

--------------------------------------------------------------------------------
-- AtlasBossButtons (Traditional Chinese)
--------------------------------------------------------------------------------
AtlasLootBossButtons = {

	BlackwingLair = {
		"";
		"";
		"";
		"BWLRazorgore";
		"BWLVaelastrasz";
		"BWLLashlayer";
		"BWLFiremaw";
		"BWLEbonroc";
		"BWLFlamegor";
		"BWLChromaggus";
		"BWLNefarian";
        "";
        "BWLTrashMobs";
		"T2SET";
		};

	MoltenCore = {
		"";
		"MCLucifron";
		"MCMagmadar";
		"MCGehennas";
		"MCGarr";
		"MCShazzrah";
		"MCGeddon";
		"MCGolemagg";
		"MCSulfuron";
		"MCMajordomo";
		"MCRagnaros";
		"";
		"MCTrashMobs";
        "MCRANDOMBOSSDROPPS";
		"T1SET";
		};

	OnyxiasLair = {
		"";
		"";
		"";
		"Onyxia";
		};

	ZulGurub = {
		"";
		"ZGJeklik";
		"ZGVenoxis";
		"ZGMarli";
		"ZGMandokir";
		"";
		"ZGGrilek";
		"ZGHazzarah";
		"ZGRenataki";
		"ZGWushoolay";
		"ZGGahzranka";
		"ZGThekal";
		"ZGArlokk";
		"ZGJindo";
		"ZGHakkar";
		"";
		"";
        "ZGTrash";
        "ZGShared";
		"ZGSET";
        "ZGEnchants";
		};

	TheRuinsofAhnQiraj = {
		"";
		"AQ20Kurinnaxx";
		"";
		"";
		"AQ20Rajaxx";
		"AQ20CAPTIAN";
		"AQ20CAPTIAN";
		"AQ20CAPTIAN";
		"AQ20CAPTIAN";
		"AQ20CAPTIAN";
		"AQ20CAPTIAN";
		"AQ20CAPTIAN";
		"AQ20Moam";
		"AQ20Buru";
		"AQ20Ayamiss";
		"AQ20Ossirian";
        "";
        "";
        "AQ20ClassBooks";
        "AQEnchants";
        "AQ20SET";
		};

	TheTempleofAhnQiraj = {
		"";
		"AQ40Skeram";
		"AQ40Vem";
		"AQ40Sartura";
		"AQ40Fankriss";
		"AQ40Viscidus";
		"AQ40Huhuran";
		"AQ40Emperors";
		"AQ40Ouro";
		"AQ40CThun";
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "AQ40Trash";
        "AQEnchants";
        "AQ40SET";
		};

	Gnomeregan = {
		"";
		"";
		"GnViscousFallout";
		"GnGrubbis";
		"";
		"";
		"GnElectrocutioner6000";
		"";
		"GnMekgineerThermaplugg";
		"GnDIAmbassador";
		"GnCrowdPummeler960";
		};

	TheStockade = {
		"";
		"";
		"SWStKamDeepfury";
		"";
		"";
		"";
		"SWStBruegalIronknuckle";
		};

	BlackfathomDeeps = {
		"";
		"BFDGhamoora";
		"";
		"BFDLadySarevess";
		"";
		"BFDGelihast";
		"";
		"BFDBaronAquanis";
		"";
		"BFDTwilightLordKelris";
		"BFDOldSerrakis";
		"BFDAkumai";
		};

	WailingCaverns = {
		"";
		"";
		"WCLordCobrahn";
		"WCLadyAnacondra";
		"WCKresh";
		"WCLordPythas";
		"WCSkum";
		"WCLordSerpentis";
		"WCVerdan";
		"WCMutanus";
		"";
		"WCDeviateFaerieDragon";
        "";
        "WCViperSET";
		};

	TheDeadmines = {
		"";
		"";
		"VCRhahkZor";
		"VCMinerJohnson";
		"VCSneed";
		"VCGilnid";
		"";
		"VCCaptainGreenskin";
		"VCVanCleef";
		"VCMrSmite";
		"VCCookie";
        "";
        "VCDefiasSET";
		};

	TheSunkenTemple = {
		"";
		"";
		"STTrollMinibosses";
		"";
		"STAtalalarion";
		"STDreamscythe";
		"STWeaver";
		"STAvatarofHakkar";
		"STJammalan";
		"STOgom";
		"STMorphaz";
		"STHazzas";
		"STEranikus";
		};

	Maraudon = {
		"";
		"";
		"";
		"";
		"MaraNoxxion";
		"MaraRazorlash";
		"";
		"MaraLordVyletongue";
		"MaraMeshlok";
		"MaraCelebras";
		"MaraLandslide";
		"MaraTinkererGizlock";
		"MaraRotgrip";
		"MaraPrincessTheradras";
		};

	ZulFarrak = {
		"";
		"ZFAntusul";
		"";
		"ZFWitchDoctorZumrah";
		"";
		"";
		"ZFSezzziz";
		"";
		"";
		"ZFGahzrilla";
		"ZFDustwraith";
		"ZFChiefUkorzSandscalp";
		"";
		"ZFZerillis";
		};

	RazorfenDowns = {
		"";
		"RFDTutenkash";
		"";
		"";
		"RFDMordreshFireEye";
		"RFDGlutton";
		"RFDRagglesnout";
		"RFDAmnennar";
		};

	Uldaman = {
		"";
		"";
		"";
		"";
		"UldRevelosh";
		"UldIronaya";
		"";
		"";
		"UldAncientStoneKeeper";
		"UldGalgannFirehammer";
		"UldGrimlok";
		"UldArchaedas";
		};

	ScarletMonastery = {
		"";
		"";
		"";
		"";
		"SMHoundmasterLoksey";
		"SMDoan";
		"SMHerod";
		"SMFairbanks";
		"SMMograine";
		"SMWhitemane";
		"SMIronspine";
		"SMAzshir";
		"SMFallenChampion";
		"SMBloodmageThalnos";
        "";
        "SMScarletSET";
		};

	RazorfenKraul = {
		"";
		"";
		"";
		"RFKDeathSpeakerJargba";
		"RFKOverlordRamtusk";
		"RFKAgathelos";
		"RFKBlindHunter";
		"RFKCharlgaRazorflank";
		"";
		"";
		"RFKEarthcallerHalmgar";
		};

        BlackrockDepths = {
        "";
        "BRDLordRoccor";
        "";
        "";
        "";
        "BRDHighInterrogatorGerstahn";
        "BRDArena";
        "BRDTheldren";
        "";
        "BRDPyromantLoregrain";
        "BRDWarderStilgiss";
        "BRDFineousDarkvire";
        "";
        "BRDLordIncendius";
        "BRDBaelGar";
        "";
        "BRDGeneralAngerforge";
        "BRDGolemLordArgelmach";
        "BRDGuzzler";
        "BRDFlamelash";
        "BRDPanzor";
        "BRDTomb";
        "";
        "BRDMagmus";
        "BRDImperatorDagranThaurissan";
        "BRDPrincess";
        "";
        };

     RagefireChasm = {
        "";
        "";
        "RFCTaragaman";
        "RFCJergosh";
        "";
        };

     ShadowfangKeep = {
        "";
        "";
        "";
        "";
        "";
        "";
        "";
        "BSFRazorclawtheButcher";
        "BSFSilverlaine";
        "BSFSpringvale";
        "BSFOdotheBlindwatcher";
        "BSFFenrustheDevourer";
        "BSFWolfMasterNandos";
        "BSFArchmageArugal";
        --"BSFIronbarkProtector";
        };

     DireMaulEast = {
        "";
        "";
        "";
        "";
        "";
        "DMEPusillin";
        "DMEZevrimThornhoof";
        "DMEHydro";
        "DMELethtendris";
        "";
        "DMEAlzzin";
        "DMEIsalien";
        "";
        "DMBooks";
        };

     DireMaulNorth = {
        "";
        "DMNGuardMoldar";
        "DMNStomperKreeg";
        "DMNGuardFengus";
        "DMNThimblejack";
        "DMNGuardSlipkik";
        "DMNCaptainKromcrush";
        "DMNKingGordok";
        "";
        "";
        "";
        "DMNTRIBUTERUN";
        "DMBooks";
        };

     DireMaulWest = {
        "";
        "";
        "";
        "DMWTendrisWarpwood";
        "DMWIllyannaRavenoak";
        "DMWMagisterKalendris";
        "DMWTsuzee";
        "DMWImmolthar";
        "DMWPrinceTortheldrin";
        "";
        "";
        "";
        "DMBooks";
        };

     BlackrockSpireUpper = {
        "";
        "UBRSEmberseer";
        "UBRSSolakar";
        "UBRSFLAME";
        "UBRSRunewatcher";
        "UBRSAnvilcrack";
        "UBRSRend";
        "UBRSGyth";
        "";
        "UBRSBeast";
        "UBRSValthalak";
        "UBRSDrakkisath";
        "";
        "";
        "";
        "T0SET";
        };

     Stratholme = {
       "";
       "";
       "STRATSkull";
       "STRATStratholmeCourier";
       "STRATFrasSiabi";
       "STRATHearthsingerForresten";
       "STRATTheUnforgiven";
       "STRATTimmytheCruel";
       "STRATCannonMasterWilley";
       "STRATArchivistGalford";
       "STRATBalnazzar";
       "STRATSothosJarien";
       "STRATSothosJarien";
       "";
       "STRATStonespine";
       "STRATBaronessAnastari";
       "STRATNerubenkan";
       "STRATMalekithePallid";
       "STRATMagistrateBarthilas";
       "STRATRamsteintheGorger";
       "STRATBaronRivendare";
       };

       BlackrockSpireLower = {
        "";
        "";
        "";
        "LBRSOmokk";
        "LBRSSpirestoneLord";
        "LBRSVosh";
        "";
        "LBRSVoone";
        "";
        "LBRSGrayhoof";
        "LBRSSmolderweb";
        "LBRSCrystalFang";
        "LBRSDoomhowl";
        "LBRSZigris";
        "LBRSSlavener";
        "LBRSHalycon";
        "LBRSWyrmthalak";
        "LBRSGrimaxe";
        "LBRSSpirestoneButcher";
	"";
        "T0SET";
       };

       Scholomance = {
        "";
        "";
        "";
        "SCHOLOBloodSteward";
        "";
        "SCHOLOKirtonostheHerald";
        "SCHOLOJandiceBarov";
        "";
        "SCHOLORattlegore";
        "SCHOLOMarduk";
        "SCHOLOVectus";
        "SCHOLORasFrostwhisper";
        "";
        "SCHOLOKormok";
        "SCHOLOInstructorMalicia";
        "SCHOLODoctorTheolenKrastinov";
        "SCHOLOLorekeeperPolkelt";
        "SCHOLOTheRavenian";
        "SCHOLOLordAlexeiBarov";
        "";
        "SCHOLOLadyIlluciaBarov";
        "SCHOLODarkmasterGandling";
	"";
        "";
        "";
        "";
        "T0SET";
       };
       
    Naxxramas = {
        "";
        "NAXPatchwerk";
        "NAXGrobbulus";
        "NAXGluth";
        "NAXThaddius";
        "";
        "NAXAnubRekhan";
        "NAXGrandWidowFaerlina";
        "NAXMaexxna";
        "";
        "NAXInstructorRazuvious";
        "NAXGothikderHarvester";
        "NAXTheFourHorsemen";
        "";
        "";
        "";
        "";
        "";
        "NAXNothderPlaguebringer";
        "NAXHeiganderUnclean";
        "NAXLoatheb";
        "";
        "NAXSapphiron";
        "NAXKelThuzard";
        "";
        "NAXTrash";
        "T3SET";
       };

    Kazzak = {
       "KKazzak";
       };

    Dragons = {
       "DTaerar";
       "DEmeriss";
       "DLethon";
       "DYsondre";
       };
    Azuregos = {
       "AAzuregos";
       };
	};

end