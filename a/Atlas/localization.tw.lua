--[[

-- Atlas Data (Traditional Chinese)
-- Initial Translated by: Warren Chen
-- Maintained by: Warren Chen, Arith Hsu, Kuraki, Suzuna
-- Last Update: 08/01/2006 - Arith
-- Revision History:
--    6/21 Arith: * Merged Suzuna's revision
--                * Added 1.7.4's new strings into zhTW and translate them
--    7/05 Arith: Correct some Nax bosses' translation
--    7/11 Arith: Revise the new summon bosses' name in Stratholme
--    7/18 Arith: Correct the translation of the boss names in The Ruins of Ahn'Qiraj
--    7/19 Arith: Correct the translation of the boss names in the Naxxramas
--    7/24 Arith: Review and revise lots of incorrect bosses names
--    8/01 Arith: Upgraded to version 1.8 and translated the new strings introduced in the latest version
--    8/11 Arith: Revised translation for "Master Elemental Shaper Krixix"
--]]

if ( GetLocale() == "zhTW" ) then

AtlasSortIgnore = {
}

ATLAS_TITLE = "Atlas";
ATLAS_SUBTITLE = "副本地圖集";
ATLAS_DESC = "Atlas 是一個副本地圖瀏覽器.";

ATLAS_OPTIONS_BUTTON = "選項";

BINDING_HEADER_ATLAS_TITLE = "Atlas 按鍵設定";
BINDING_NAME_ATLAS_TOGGLE = "開啟/關閉 Atlas";
BINDING_NAME_ATLAS_OPTIONS = "切換設定";

ATLAS_SLASH = "/atlas";
ATLAS_SLASH_OPTIONS = "設定";

ATLAS_STRING_LOCATION = "副本位置";
ATLAS_STRING_LEVELRANGE = "等級範圍";
ATLAS_STRING_PLAYERLIMIT = "人數上限";
ATLAS_STRING_SELECT_CAT = "選擇種類";
ATLAS_STRING_SELECT_MAP = "選擇地圖";

ATLAS_BUTTON_TOOLTIP = "開啟/關閉 Atlas";
ATLAS_BUTTON_TOOLTIP2 = "左鍵點擊以開啟Atlas.";
ATLAS_BUTTON_TOOLTIP3 = "右鍵點擊並拖拉以移動這個按鈕.";

ATLAS_OPTIONS_TITLE = "Atlas 選項設定";
ATLAS_OPTIONS_SHOWBUT = "在小地圖周圍顯示 Atlas 按鈕";
ATLAS_OPTIONS_AUTOSEL = "自動選擇副本地圖";
ATLAS_OPTIONS_BUTPOS = "按鈕位置";
ATLAS_OPTIONS_TRANS = "透明度";
ATLAS_OPTIONS_DONE = "完成";
ATLAS_OPTIONS_REPMAP = "取代世界地圖";
ATLAS_OPTIONS_RCLICK = "點擊滑鼠右鍵開啟世界地圖";
ATLAS_OPTIONS_SHOWMAPNAME = "顯示地圖名稱";
ATLAS_OPTIONS_RESETPOS = "重設位置";
ATLAS_OPTIONS_ACRONYMS = "顯示縮寫";

ATLAS_HINT = "提示: 點擊滑鼠左鍵開啟 Atlas";

ATLAS_LOCALE = {
	menu = "Atlas",
	tooltip = "Atlas",
	button = "Atlas"
};

AtlasZoneSubstitutions = {
	["阿塔哈卡神廟"] 	= "沈沒的神廟";
	["安其拉"] 			= "安其拉神廟";
	["安其拉廢墟"] 		= "安其拉廢墟";
}; 

local BLUE = "|cff6666ff";
local GREY = "|cff999999";
local GREN = "|cff66cc33";
local _RED = "|cffcc6666";
local ORNG = "|cffcc9933";
local PURP = "|cff9900ff";
local INDENT = "　";

--Keeps track of the different categories of maps
Atlas_MapTypes = {"副本地圖集", "戰場地圖集", "飛航路徑地圖集", "地下城位置", "團隊會戰" };

AtlasText = {
	BlackfathomDeeps = {
		ZoneName = "黑暗深淵";
		Acronym = "BFD";
		Location = "梣谷";
		BLUE.."A) 入口";
		GREY.."1) 加摩拉";
		GREY.."2) 潮濕的便箋";
		GREY.."3) 薩利維絲";
		GREY.."4) 銀月守衛塞爾瑞德";
		GREY.."5) 格裏哈斯特";
		GREY.."6) 洛古斯‧傑特 (多個位置)";
		GREY.."7) 阿奎尼斯男爵";
		GREY..INDENT.."深淵之核";
		GREY.."8) 夢遊者克爾裏斯";
		GREY.."9) 瑟拉吉斯";
		GREY.."10) 阿庫邁爾";
	};
	BlackrockDepths = {
		ZoneName = "黑石深淵";
		Acronym = "BRD";
		Location = "黑石山";
		BLUE.."A) 入口";
		GREY.."1) 洛考爾";
		GREY.."2) 卡蘭‧巨錘";
		GREY.."3) 指揮官哥沙克";
		GREY.."4) 溫德索爾元帥";
		GREY.."5) 審訊官格斯塔恩";
		GREY.."6) 法律之環, 瑟爾倫";
		GREY.."7) 弗蘭克羅恩‧鑄鐵的雕像";
		GREY..INDENT.."控火師羅格雷恩 (稀有)";
		GREY.."8) 黑色寶庫";
		GREY.."9) 弗諾斯‧達克維爾";
		GREY.."10) 黑鐵砧";
		GREY..INDENT.." 伊森迪奧斯";
		GREY.."11) 貝爾加";
		GREY.."12) 暗爐之鎖";
		GREY.."13) 安格弗將軍";
		GREY.."14) 傀儡統帥阿格曼奇";
		GREY.."15) 黑鐵酒吧";
		GREY.."16) 弗萊拉斯大使";
		GREY.."17) 無敵的潘佐爾 (稀有)";
		GREY.."18) 召喚者之墓";
		GREY.."19) 講學廳";
		GREY.."20) 瑪格姆斯";
		GREY.."21) 達格蘭‧索瑞森大帝";
		GREY..INDENT.."鐵爐堡公主茉艾拉‧銅鬚";
		GREY.."22) 黑熔爐";
		GREY.."23) 熔火之心 (團隊副本)";
	};
	BlackrockSpireLower = {
		ZoneName = "黑石塔 (下層)";
		Acronym = "LBRS";
		Location = "黑石山";
		BLUE.."A) 入口";
		GREY.."1) 瓦羅什";
		GREY.."2) 尖銳長矛";
		GREY.."3) 歐莫克大王";
		GREY..INDENT.."尖石統帥 (稀有)";
		GREY.."4) 暗影獵手沃什加斯";
		GREY..INDENT.."第五塊摩沙魯石板";
		GREY.."5) 維姆薩拉克";
		GREY..INDENT.."第六塊摩沙魯石板";
		GREY..INDENT.."莫爾‧灰蹄 (召喚)";
		GREY.."6) 煙網蛛后";
		GREY.."7) 水晶之牙 (稀有)";
		GREY.."8) 烏洛克";
		GREY.."9) 軍需官茲格雷斯";
		GREY.."10) 奴役者基茲盧爾";
		GREY..INDENT.."哈雷肯";
		GREY.."11) 維姆薩拉克";
		GREY.."12) 班諾克‧巨斧 (稀有)";
		GREY.."13) 尖石屠夫 (稀有)";
	};
	BlackrockSpireUpper = {
		ZoneName = "黑石塔 (上層)";
		Acronym = "UBRS";
		Location = "黑石山";
		BLUE.."A) 入口";
		GREY.."1) 烈焰衛士艾博希爾";
		GREY.."2) 索拉卡‧火冠";
		GREY..INDENT.."烈焰之父";
		GREY.."3) 傑德 (稀有)";
		GREY.."4) 古拉魯克";
		GREY.."5) 大酋長雷德‧黑手";
		GREY..INDENT.."蓋斯";
		GREY.."6) 奧比";
		GREY.."7) 比斯巨獸";
		GREY..INDENT.."瓦薩拉克 (召喚)";
		GREY.."8) 達基薩斯將軍";
		GREY..INDENT.."末日扣環之箱";
		GREY.."9) 黑翼之巢 (團隊副本)";
	};
	BlackwingLair = {
		ZoneName = "黑翼之巢";
		Acronym = "BWL";
		Location = "黑石塔";
		BLUE.."A) 入口";
		BLUE.."B) 通道";
		BLUE.."C) 通道";
		GREY.."1) 狂野的拉佐格爾";
		GREY.."2) 墮落的瓦拉斯塔茲";
		GREY.."3) 勒西雷爾";
		GREY.."4) 費爾默";
		GREY.."5) 埃博諾克";
		GREY.."6) 弗萊格爾";
		GREY.."7) 克洛瑪古斯";
		GREY.."8) 奈法利安";
		GREY.."9) 大元素師克里希克";
	};
	DireMaulEast = {
		ZoneName = "厄運之槌 (東)";
		Acronym = "DM";
		Location = "菲拉斯";
		BLUE.."A) 入口";
		BLUE.."B) 入口";
		BLUE.."C) 入口";
		BLUE.."D) 出口";
		GREY.."1) 開始追捕普希林";
		GREY.."2) 結束追捕普希林";
		GREY.."3) 瑟雷姆‧刺蹄";
		GREY..INDENT.."海多斯博恩";
		GREY..INDENT.."蕾瑟塔蒂絲";
		GREY.."4) 埃隆巴克";
		GREY.."5) 奧茲恩";
		GREY..INDENT.."依薩利恩 (召喚)";
	};
	DireMaulNorth = {
		ZoneName = "厄運之槌 (北)";
		Acronym = "DM";
		Location = "菲拉斯";
		BLUE.."A) 入口";
		GREY.."1) 衛兵摩爾達";
		GREY.."2) 踐踏者克雷格";
		GREY.."3) 衛兵芬古斯";
		GREY.."4) 諾特‧希姆加克";
		GREY..INDENT.."衛兵斯里基克";
		GREY.."5) 克羅卡斯";
		GREY.."6) 戈多克大王";
		GREY.."7) 厄運之槌 (西)";
		GREN.."1') 圖書館";
	};
	DireMaulWest = {
		ZoneName = "厄運之槌 (西)";
		Acronym = "DM";
		Location = "菲拉斯";
		BLUE.."A) 入口";
		BLUE.."B) 水晶塔";
		GREY.."1) 辛德拉古靈";
		GREY.."2) 特迪斯‧扭木";
		GREY.."3) 伊琳娜‧暗木";
		GREY.."4) 卡雷迪斯鎮長";
		GREY.."5) 蘇斯 (稀有)";
		GREY.."6) 伊莫塔爾";
		GREY..INDENT.."赫爾努拉斯";
		GREY.."7) 托塞德林王子";
		GREY.."8) 厄運之槌 (北)";
		GREN.."1') 圖書館";
	};
	Gnomeregan = {
		ZoneName = "諾姆瑞根";
		Location = "丹莫洛";
		BLUE.."A) 入口 (正門)";
		BLUE.."B) 入口 (後門)";
		GREY.."1) 粘性輻射塵 (下層)";
		GREY.."2) 格魯比斯";
		GREY.."3) 矩陣式打孔電腦 3005-B";
		GREY.."4) 清洗區";
		GREY.."5) 電刑器 6000 型";
		GREY..INDENT.."矩陣式打孔電腦 3005-C";
		GREY.."6) 麥克尼爾‧瑟瑪普拉格";
		GREY.."7) 黑鐵大師 (稀有)";
		GREY.."8) 群體打擊者9-60";
		GREY..INDENT.."矩陣式打孔電腦 3005-D";
	};
	Maraudon = {
		ZoneName = "瑪拉頓";
		Acronym = "Mara";
		Location = "淒涼之地";
		BLUE.."A) 入口 (橙色)";
		BLUE.."B) 入口 (紫色)";
		BLUE.."C) 入口 (傳送)";
		GREY.."1) 溫格 (第五可汗)";
		GREY.."2) 諾克賽恩";
		GREY.."3) 銳刺鞭笞者";
		GREY.."4) 瑪勞杜斯 (第四可汗)";
		GREY.."5) 維利塔恩";
		GREY.."6) 收割者麥什洛克 (稀有)";
		GREY.."7) 被詛咒的塞雷布拉斯";
		GREY.."8) 蘭斯利德";
		GREY.."9) 工匠吉茲洛克";
		GREY.."10) 洛特格里普";
		GREY.."11) 瑟萊德絲公主";
	};
	MoltenCore = {
		ZoneName = "熔火之心";
		Acronym = "MC";
		Location = "黑石深淵";
		BLUE.."A) 入口";
		GREY.."1) 魯西弗隆";
		GREY.."2) 瑪格曼達";
		GREY.."3) 基赫納斯";
		GREY.."4) 加爾";
		GREY.."5) 沙斯拉爾";
		GREY.."6) 迦頓男爵";
		GREY.."7) 焚化者古雷曼格";
		GREY.."8) 薩弗隆先驅者";
		GREY.."9) 管理者埃克索圖斯";
		GREY.."10) 拉格納羅斯";
	};
	OnyxiasLair = {
		ZoneName = "奧妮克希亞的巢穴";
		Location = "塵泥沼澤";
		BLUE.."A) 入口";
		GREY.."1) 奧妮克希亞守衛";
		GREY.."2) 雛龍蛋";
		GREY.."3) 奧妮克希亞";
	};
	RagefireChasm = {
		ZoneName = "怒焰裂谷";
		Acronym = "RFC";
		Location = "奧格瑪";
		BLUE.."A) 入口";
		GREY.."1) 瑪爾‧恐怖圖騰";
		GREY.."2) 饑餓者塔拉加曼";
		GREY.."3) 祈求者耶戈什";
		GREY.."4) 巴紮蘭";
	};
	RazorfenDowns = {
		ZoneName = "剃刀高地";
		Acronym = "RFD";
		Location = "貧瘠之地";
		BLUE.."A) 入口";
		GREY.."1) 圖特卡什";
		GREY.."2) 亨利‧斯特恩";
		GREY..INDENT.."貝尼斯特拉茲";
		GREY.."3) 火眼莫德雷斯";
		GREY.."4) 暴食者";
		GREY.."5) 拉戈斯諾特 (稀有)";
		GREY.."6) 寒冰之王亞門納爾";
	};
	RazorfenKraul = {
		ZoneName = "剃刀沼澤";
		Acronym = "RFK";
		Location = "貧瘠之地";
		BLUE.."A) 入口";
		GREY.."1) 魯古格";
		GREY.."2) 阿格姆";
		GREY.."3) 亡語者賈格巴";
		GREY.."4) 主宰拉姆塔斯";
		GREY.."5) 暴怒的阿迦賽羅斯";
		GREY.."6) 盲眼獵手 (稀有)";
		GREY.."7) 卡爾加‧刺肋";
		GREY.."8) 進口商威利克斯";
		GREY..INDENT.."赫爾拉斯‧靜水";
		GREY.."9) 喚地者哈穆加 (稀有)";
	};
	ScarletMonastery = {
		ZoneName = "血色修道院";
		Acronym = "SM";
		Location = "提里斯法林地";
		BLUE.."A) 入口 (圖書館)";
		BLUE.."B) 入口 (軍械庫)";
		BLUE.."C) 入口 (大教堂)";
		BLUE.."D) 入口 (墓地)";
		GREY.."1) 馴犬者洛克希";
		GREY.."2) 奧法師杜安";
		GREY.."3) 赫洛德";
		GREY.."4) 大檢察官法爾班克斯";
		GREY.."5) 血色十字軍指揮官莫格萊尼";
		GREY..INDENT.."大檢察官懷特邁恩";
		GREY.."6) 鐵脊死靈 (稀有)";
		GREY.."7) 永醒的艾希爾 (稀有)";
		GREY.."8) 死靈勇士 (稀有)";
		GREY.."9) 血法師薩爾諾斯";
	};
	Scholomance = {
		ZoneName = "通靈學院";
		Acronym = "Scholo";
		Location = "西瘟疫之地";
		BLUE.."A) 入口";
		BLUE.."B) 樓梯";
		BLUE.."C) 樓梯";
		GREY.."1) 基爾圖諾斯的衛士";
		GREY..INDENT.."南海鎮地契";
		GREY.."2) 傳令官基爾圖諾斯";
		GREY.."3) 詹迪斯‧巴羅夫";
		GREY.."4) 塔倫米爾地契";
		GREY.."5) 血骨傀儡 (下層)";
		GREY..INDENT.."死亡騎士達克雷爾";
		GREY.."6) 馬杜克‧布萊克波爾";
		GREY..INDENT.."維克圖斯";
		GREY.."7) 萊斯‧霜語";
		GREY..INDENT.."布瑞爾地契";
		GREY..INDENT.."科爾莫克 (召喚)";
		GREY.."8) 講師瑪麗希亞";
		GREY.."9) 瑟爾林‧卡斯迪諾夫教授";
		GREY.."10) 博學者普克爾特";
		GREY.."11) 拉文尼亞";
		GREY.."12) 阿萊克斯‧巴羅夫";
		GREY..INDENT.." 凱爾達隆地契";
		GREY.."13) 伊露希亞‧巴羅夫";
		GREY.."14) 黑暗院長加丁";
		GREN.."1') 火炬";
		GREN.."2') 舊寶藏箱";
		GREN.."3') 煉金實驗室";
	};
	ShadowfangKeep = {
		ZoneName = "影牙城堡";
		Acronym = "SFK";
		Location = "銀松森林";
		BLUE.."A) 入口";
		BLUE.."B) 通道";
		BLUE.."C) 通道";
		BLUE..INDENT.."死亡之誓 (稀有)";
		GREY.."1) 亡靈哨兵阿達曼特";
		GREY..INDENT.."巫師阿克魯比";
		GREY..INDENT.."雷希戈爾";
		GREY.."2) 屠夫拉佐克勞";
		GREY.."3) 席瓦萊恩男爵";
		GREY.."4) 指揮官斯普林瓦爾";
		GREY.."5) 盲眼守衛奧杜";
		GREY.."6) 吞噬者芬魯斯";
		GREY.."7) 狼王南杜斯";
		GREY.."8) 大法師阿魯高";
	};
	Stratholme = {
		ZoneName = "斯坦索姆";
		Acronym = "Strat";
		Location = "東瘟疫之地";
		BLUE.."A) 入口 (前門)";
		BLUE.."B) 入口 (側門)";
		GREY.."1) 斯庫爾 (稀有, 巡邏)";
		GREY..INDENT.."斯坦索姆信差";
		GREY..INDENT.."弗拉斯‧希亞比";
		GREY.."2) 弗雷斯特恩 (稀有, 多個位置)";
		GREY.."3) 不可寬恕者";
		GREY.."4) 悲慘的提米";
		GREY.."5) 炮手威利";
		GREY.."6) 檔案管理員加爾福特";
		GREY.."7) 巴納札爾";
		GREY..INDENT.."索索斯 (召喚)";
		GREY..INDENT.."賈琳 (召喚)";
		GREY.."8) 奧裏克斯";
		GREY.."9) 石脊 (稀有)";
		GREY.."10) 安娜絲塔麗男爵夫人";
		GREY.."11) 奈魯布恩坎";
		GREY.."12) 蒼白的瑪勒基";
		GREY.."13) 巴瑟拉斯鎮長 (多個位置)";
		GREY.."14) 吞咽者拉姆斯登";
		GREY.."15) 瑞文戴爾男爵";
		GREN.."1') 十字軍廣場郵箱";
		GREN.."2') 市場郵箱";
		GREN.."3') 節日小道的郵箱";
		GREN.."4') 長者廣場郵箱";
		GREN.."5') 國王廣場郵箱";
		GREN.."6') 弗拉斯‧希亞比的郵箱";
	};
	TheDeadmines = {
		ZoneName = "死亡礦井";
		Acronym = "VC";
		Location = "西部荒野";
		BLUE.."A) 入口";
		BLUE.."B) 出口";
		GREY.."1) 拉克佐";
		GREY.."2) 礦工約翰森 (稀有)";
		GREY.."3) 斯尼德";
		GREY.."4) 基爾尼格";
		GREY.."5) 迪菲亞火藥";
		GREY.."6) 綠皮隊長";
		GREY..INDENT.."艾德溫‧范克里夫";
		GREY..INDENT.."重拳先生";
		GREY..INDENT.."曲奇";
	};
	TheStockade = {
		ZoneName = "監獄";
		Location = "暴風城";
		BLUE.."A) 入口";
		GREY.."1) 可怕的塔高爾 (多個位置)";
		GREY.."2) 卡姆‧深怒";
		GREY.."3) 哈姆霍克";
		GREY.."4) 巴基爾‧斯瑞德";
		GREY.."5) 迪克斯特‧瓦德";
		GREY.."6) 布魯戈‧艾爾克納寇 (稀有)";
	};
	TheSunkenTemple = {
		ZoneName = "沈沒的神廟";
		Acronym = "ST";
		Location = "悲傷沼澤";
		BLUE.."A) 入口";
		BLUE.."B) 樓梯";
		BLUE.."C) 食人妖小首領 (上層)";
		GREY.."1) 哈卡祭壇";
		GREY..INDENT.."阿塔拉利恩";
		GREY.."2) 德姆塞卡爾";
		GREY..INDENT.."德拉維沃爾";
		GREY.."3) 哈卡的化身";
		GREY.."4) 預言者迦瑪蘭";
		GREY..INDENT.."可悲的奧戈姆";
		GREY.."5) 摩弗拉斯";
		GREY..INDENT.."哈扎斯";
		GREY.."6) 伊蘭尼庫斯的陰影";
		GREY..INDENT.."精華之泉";
		GREN.."1'-6') 雕像啟動順序";
	};
	Uldaman = {
		ZoneName = "奧達曼";
		Acronym = "Ulda";
		Location = "荒蕪之地";
		BLUE.."A) 入口 (前門)";
		BLUE.."B) 入口 (後門)";
		GREY.."1) 巴爾洛戈";
		GREY.."2) 聖騎士的遺體";
		GREY.."3) 魯維羅什";
		GREY.."4) 艾隆納亞";
		GREY.."5) 黑曜石哨兵";
		GREY.."6) 安諾拉 (大師級附魔師)";
		GREY.."7) 古代的石頭看守者";
		GREY.."8) 加加恩‧火錘";
		GREY.."9) 格瑞姆洛克";
		GREY.."10) 阿札達斯 (下層)";
		GREY.."11) 諾甘農圓盤 (下層)";
		GREY..INDENT.."古代寶藏 (下層)";
	};
	WailingCaverns = {
		ZoneName = "哀嚎洞穴";
		Acronym = "WC";
		Location = "貧瘠之地";
		BLUE.."A) 入口";
		GREY.."1) 納拉雷克斯的信徒";
		GREY.."2) 考布萊恩";
		GREY.."3) 安娜科德拉";
		GREY.."4) 克雷什";
		GREY.."5) 皮薩斯";
		GREY.."6) 斯卡姆";
		GREY.."7) 瑟芬迪斯 (上層)";
		GREY.."8) 永生者沃爾丹 (上層)";
		GREY.."9) 吞噬者穆坦努斯";
		GREY..INDENT.."納拉雷克斯";
		GREY.."10) 變異精靈龍 (稀有)";
	};
	ZulFarrak = {
		ZoneName = "祖爾法拉克";
		Acronym = "ZF";
		Location = "塔納利斯";
		BLUE.."A) 入口";
		GREY.."1) 安圖蘇爾";
		GREY.."2) 殉教者塞卡";
		GREY.."3) 巫醫祖穆拉恩";
		GREY..INDENT.."祖爾法拉克陣亡英雄";
		GREY.."4) 耐克魯姆";
		GREY..INDENT.."暗影祭司塞瑟斯";
		GREY.."5) 布萊中士";
		GREY.."6) 水占師維蕾薩";
		GREY..INDENT.."加茲瑞拉";
		GREY..INDENT.."灰塵怨靈 (稀有)";
		GREY.."7) 烏克茲‧沙頂";
		GREY..INDENT.."盧茲魯";
		GREY.."8) 澤雷利斯 (稀有, 巡邏)";
		GREY.."9) 杉達爾‧沙掠者 (稀有)";
	};
	ZulGurub = {
		ZoneName = "祖爾格拉布";
		Acronym = "ZG";
		Location = "荊棘谷";
		BLUE.."A) 入口";
		GREY.."1) 高階祭司 耶克里克 (蝙蝠王)";
		GREY.."2) 高階祭司 溫諾希斯 (蛇王)";
		GREY.."3) 高階祭司 瑪爾羅 (蜘蛛王)";
		GREY.."4) 血領主 曼多基爾 (恐龍王, 可選擇)";
		GREY.."5) 瘋狂之源 (可選擇)";
		GREY..INDENT.."格里雷克‧鋼鐵之血 (戰士)";
		GREY..INDENT.."哈札拉爾‧織夢者 (召喚師)";
		GREY..INDENT.."雷納塔基‧千刃之王 (盜賊)";
		GREY..INDENT.."烏蘇雷‧雷巫 (法師)";
		GREY.."6) 加茲蘭卡 (召喚者, 可選擇)";
		GREY.."7) 高階祭司 塞卡爾 (虎王)";
		GREY.."8) 高階祭司 婭爾羅 (豹王)";
		GREY.."9) 妖術師 金度 (瘟疫之神, 可選擇)";
		GREY.."10) 哈卡 (噬魂者)";
		GREN.."1') 混濁的水";
	};
	TheTempleofAhnQiraj = {
		ZoneName = "安其拉神廟";
		Acronym = "AQ40";
		Location = "希利蘇斯";
		BLUE.."A) 入口";
		GREY.."1) 預言者斯克拉姆 (戶外)";
		GREY.."2) 維姆/克里勳爵/亞爾基公主(可選擇)";
		GREY.."3) 沙爾圖拉";
		GREY.."4) 頑強的范克里斯";
		GREY.."5) 維希度斯 (可選擇)";
		GREY.."6) 哈霍蘭公主";
		GREY.."7) 雙子帝王 維克尼拉斯/維克洛爾大帝";
		GREY.."8) 奧羅 (可選擇)";
		GREY.."9) 克蘇恩之眼 / 克蘇恩";
		GREN.."1') 安多葛斯";
		GREN..INDENT.."溫瑟拉";
		GREN..INDENT.."坎多斯特拉茲";
		GREN.."2') 亞雷戈斯";
		GREN..INDENT.."凱雷斯特拉茲";
		GREN..INDENT.."夢境之龍麥琳瑟拉";
	};
	TheRuinsofAhnQiraj = {
		ZoneName = "安其拉廢墟";
		Acronym = "AQ20";
		Location = "希利蘇斯";
		BLUE.."A) 入口";
		GREY.."1) 庫林納克斯";
		GREY..INDENT.."安多洛夫中將";
		GREY..INDENT.."四個卡多雷精英";
		GREY.."2) 拉賈克斯將軍";
		GREY..INDENT.."奎茲上尉";
		GREY..INDENT.."圖畢德上尉";
		GREY..INDENT.."德蘭上尉";
		GREY..INDENT.."瑟瑞姆上尉";
		GREY..INDENT.."葉吉斯少校";
		GREY..INDENT.."帕康少校";
		GREY..INDENT.."澤朗上校";
		GREY.."3) 莫阿姆 (可選擇)";
		GREY.."4) 吞咽者布魯 (可選擇)";
		GREY.."5) 狩獵者阿亞米斯 (可選擇)";
		GREY.."6) 無疤者奧斯里安";
		GREN.."1') 安全的房間";
	};
	Naxxramas = {
		ZoneName = "納克薩瑪斯";
		Acronym = "Nax";
		Location = "斯坦索姆";
		BLUE.."憎惡區"; 						-- Abomination Wing
		BLUE..INDENT.."1) 縫補者";
		BLUE..INDENT.."2) 葛羅巴斯";
		BLUE..INDENT.."3) 古魯斯";
		BLUE..INDENT.."4) 泰迪斯";
		ORNG.."蜘蛛區"; 						-- Spider Wing
		ORNG..INDENT.."1) 阿努比瑞克漢";
		ORNG..INDENT.."2) 大寡婦費琳娜";
		ORNG..INDENT.."3) 梅克絲娜";
		_RED.."死亡騎士區"; 					-- Deathknight Wing
		_RED..INDENT.."1) 講師拉祖維斯";
		_RED..INDENT.."2) 收割者高希";
		_RED..INDENT.."3) 四騎士"; 				-- The Four Horsemen
		_RED..INDENT..INDENT.."庫爾塔茲領主"; -- Thane Korth'azz
		_RED..INDENT..INDENT.."女公爵布勞繆克絲"; 	-- Lady Blaumeux
		_RED..INDENT..INDENT.."莫格萊尼公爵"; 	-- Highlord Mograine
		_RED..INDENT..INDENT.."瑟裡耶克爵士"; 	-- Sir Zeliek
		PURP.."瘟疫區"; 						-- Necro Wing
		PURP..INDENT.."1) 瘟疫者諾斯";
		PURP..INDENT.."2) 骯髒者海根";
		PURP..INDENT.."3) 洛斯伯";
		GREN.."冰霜巨龍的巢穴"; 				-- Frostwyrm Lair
		GREN..INDENT.."1) 薩菲隆"; 				-- Sapphiron
		GREN..INDENT.."2) 科爾蘇加德";
	};
};


AtlasBG = {
	AlteracValleyNorth = {
		ZoneName = "奧特蘭克山谷 (北)";
		Location = "奧特蘭克山脈";
		BLUE.."A) 入口";
		BLUE.."B) 丹巴達爾 (聯盟)";
		_RED.."1) 雷矛急救站";
		_RED.."2) 雷矛墓地";
		_RED.."3) 石爐墓地";
		_RED.."4) 落雪墓地";
		ORNG.."5) 丹巴達爾北部碉堡";
		GREY..INDENT.."空軍指揮官 穆維里克 (部落)";
		ORNG.."6) 丹巴達爾南部碉堡";
		ORNG.."7) 冰翼碉堡";
		GREY..INDENT.."空軍指揮官 古斯 (部落)";
		GREY..INDENT.."指揮官 卡爾菲利普 (聯盟)";
		ORNG.."8) 石爐哨站 (巴林達上尉)";
		ORNG.."9) 石爐碉堡";
		GREY.."10) 深鐵礦坑";
		GREY.."11) 冰翼洞穴";
		GREY.."12) 蒸氣鋸 (部落)";
		GREY.."13) 空軍指揮官 傑斯托 (部落)";
		GREY.."14) 森林之王 伊弗斯 (召喚區)";
		"";
		"";
		"";
		"";
		"";
		_RED.."紅:".._RED.." 墓地, 可佔領的地區";
		ORNG.."橙:"..ORNG.." 碉堡, 哨塔, 可摧毀的地區";
		GREY.."灰:"..GREY.." 相關 NPCs, 任務地區";
	};
	AlteracValleySouth = {
		ZoneName = "奧特蘭克山谷 (南)";
		Location = "希爾斯布萊德丘陵";
		BLUE.."A) 入口";
		BLUE.."B) 霜狼要塞 (部落)";
		_RED.."1) 霜狼急救站";
		_RED.."2) 霜狼墓地";
		_RED.."3) 冰血墓地";
		ORNG.."4) 西部霜狼哨塔";
		ORNG.."5) 東部霜狼哨塔";
		GREY..INDENT.."空軍指揮官 艾克曼 (聯盟)";
		ORNG.."6) 哨塔高地";
		GREY..INDENT.."空軍指揮官 斯里多爾 (聯盟)";
		GREY..INDENT.."指揮官 路易斯菲利普 (部落)";
		ORNG.."7) 冰血哨塔";
		ORNG.."8) 冰血要塞 (加爾范上尉)";
		GREY.."9) 蠻爪洞穴";
		GREY.."10) 霜狼騎兵指揮官";
		GREY.."11) 空軍指揮官 維波里 (聯盟)";
		GREY.."12) 金牙礦坑";
		GREY.."13) 蒸氣鋸 (聯盟)";
		GREY.."14) 冰雪之王 洛克霍拉 (召喚區)";
		"";
		"";
		"";
		"";
		"";
		_RED.."紅:".._RED.." 墓地, 可佔領的地區";
		ORNG.."橙:"..ORNG.." 碉堡, 哨塔, 可摧毀的地區";
		GREY.."灰:"..GREY.." 相關 NPCs, 任務地區";
	};
	ArathiBasin = {
		ZoneName = "阿拉希盆地";
		Location = "阿拉希高地";
		BLUE.."A) 托爾貝恩大廳 (聯盟)";
		BLUE.."B) 污染者之穴 (部落)";
		GREY.."1) (獸) 獸欄";
		GREY.."2) (礦) 金礦";
		GREY.."3) (鐵) 鐵匠舖";
		GREY.."4) (木) 伐木廠";
		GREY.."5) (農) 農場";
	};
	WarsongGulch = {
		ZoneName = "戰歌峽谷";
		Location = "梣谷 / 貧瘠之地";
		BLUE.."A) 銀翼要塞 (聯盟)";
		BLUE.."B) 戰歌伐木廠 (部落)";
	};
};

AtlasFP = {
	FPAllianceEast = {
		ZoneName = "聯盟 (東)";
		Location = "東部王國";
		GREY.."1) 聖光之願禮拜堂, ".._RED.."東瘟疫之地";
		GREY.."2) 寒風營地, ".._RED.."西瘟疫之地";
		GREY.."3) 鷹巢山, ".._RED.."辛特蘭";
		GREY.."4) 南海鎮, ".._RED.."希爾斯布萊德丘陵";
		GREY.."5) 避難谷地, ".._RED.."阿拉希高地";
		GREY.."6) 米奈希爾港, ".._RED.."濕地";
		GREY.."7) 鐵爐堡, ".._RED.."丹莫洛";
		GREY.."8) 塞爾薩瑪, ".._RED.."洛克莫丹";
		GREY.."9) 瑟銀哨塔, ".._RED.."灼熱峽谷";
		GREY.."10) 摩根的崗哨, ".._RED.."燃燒平原";
		GREY.."11) 暴風城, ".._RED.."艾爾文森林";
		GREY.."12) 湖畔鎮, ".._RED.."赤脊山";
		GREY.."13) 哨兵嶺, ".._RED.."西部荒野";
		GREY.."14) 夜色鎮, ".._RED.."暮色森林";
		GREY.."15) 守望堡, ".._RED.."詛咒之地";
		GREY.."16) 藏寶海灣, ".._RED.."荊棘谷";
	};
	FPAllianceWest = {
		ZoneName = "聯盟 (西)";
		Location = "卡林多";
		GREY.."1) 魯瑟蘭村, ".._RED.."泰達希爾";
		GREY.."2) 月光林地, ".._RED.."月光林地";
		GREY.."3) 永望鎮, ".._RED.."冬泉谷";
		GREY.."4) 奧伯丁, ".._RED.."黑海岸";
		GREY.."5) 刺枝林地, ".._RED.."費伍德森林";
		GREY.."6) 石爪峰, ".._RED.."石爪山脈";
		GREY.."7) 阿斯特蘭納, ".._RED.."梣谷";
		GREY.."8) 塔倫迪斯營地, ".._RED.."艾薩拉";
		GREY.."9) 尼耶爾前哨站, ".._RED.."淒涼之地";
		GREY.."10) 棘齒城, ".._RED.."貧瘠之地";
		GREY.."11) 塞拉摩島, ".._RED.."塵泥沼澤";
		GREY.."12) 羽月要塞, ".._RED.."菲拉斯";
		GREY.."13) 薩蘭納爾, ".._RED.."菲拉斯";
		GREY.."14) 馬紹爾營地, ".._RED.."安戈洛環形山";
		GREY.."15) 塞納里奧城堡, ".._RED.."希利蘇斯";
		GREY.."16) 加基森, ".._RED.."塔納利斯";
	};
	FPHordeEast = {
		ZoneName = "部落 (東)";
		Location = "東部王國";
		GREY.."1) 聖光之願禮拜堂, ".._RED.."東瘟疫之地";
		GREY.."2) 幽暗城, ".._RED.."提里斯法林地";
		GREY.."3) 瑟伯切爾, ".._RED.."銀松森林";
		GREY.."4) 塔倫米爾, ".._RED.."希爾斯布萊德丘陵";
		GREY.."5) 惡齒村, ".._RED.."辛特蘭";
		GREY.."6) 落錘鎮, ".._RED.."阿拉希高地";
		GREY.."7) 瑟銀哨塔, ".._RED.."灼熱峽谷";
		GREY.."8) 卡加斯, ".._RED.."荒蕪之地";
		GREY.."9) 烈焰峰, ".._RED.."燃燒平原";
		GREY.."10) 斯通納德, ".._RED.."悲傷沼澤";
		GREY.."11) 格羅姆高營地, ".._RED.."荊棘谷";
		GREY.."12) 藏寶海灣, ".._RED.."荊棘谷";
	};
	FPHordeWest = {
		ZoneName = "部落 (西)";
		Location = "卡林多";
		GREY.."1) 月光林地, ".._RED.."月光林地";
		GREY.."2) 永望鎮, ".._RED.."冬泉谷";
		GREY.."3) 血毒崗哨, ".._RED.."費伍德森林";
		GREY.."4) 佐拉姆前哨站, ".._RED.."梣谷";
		GREY.."5) 瓦羅莫克, ".._RED.."艾薩拉";
		GREY.."6) 碎木崗哨, ".._RED.."梣谷";
		GREY.."7) 奧格瑪, ".._RED.."杜洛塔";
		GREY.."8) 烈日石居, ".._RED.."石爪山脈";
		GREY.."9) 十字路口, ".._RED.."貧瘠之地";
		GREY.."10) 棘齒城, ".._RED.."貧瘠之地";
		GREY.."11) 葬影村, ".._RED.."淒涼之地";
		GREY.."12) 雷霆崖, ".._RED.."莫高雷";
		GREY.."13) 陶祖拉營地, ".._RED.."貧瘠之地";
		GREY.."14) 蕨牆村, ".._RED.."塵泥沼澤";
		GREY.."15) 莫沙徹營地, ".._RED.."菲拉斯";
		GREY.."16) 亂風崗, ".._RED.."千針石林";
		GREY.."17) 馬紹爾營地, ".._RED.."安戈洛環形山";
		GREY.."18) 加基森, ".._RED.."塔納利斯";
		GREY.."19) 塞納里奧城堡, ".._RED.."希莉蘇斯";
	};
};

AtlasDL = {
	DLEast = {
		ZoneName = "地下城位置 (東部)";
		Location = "東部王國";
		BLUE.."A) 奧特蘭克山谷, ";
		_RED..INDENT.."奧特蘭克山脈 / 希爾斯布萊德丘陵";
		BLUE.."B) 阿拉希盆地, ".._RED.."阿拉希高地";
		GREY.."1) 血色修道院, ".._RED.."提里斯法林地";
		GREY.."2) 斯坦索姆, ".._RED.."東瘟疫之地";
		GREY..INDENT.."納克薩瑪斯, ".._RED.."斯坦索姆";
		GREY.."3) 通靈學院, ".._RED.."西瘟疫之地";
		GREY.."4) 影牙城堡, ".._RED.."銀松森林";
		GREY.."5) 諾姆瑞根, ".._RED.."丹莫洛";
		GREY.."6) 奧達曼, ".._RED.."荒蕪之地";
		GREY.."7) 黑翼之巢, ".._RED.."黑石塔";
		GREY..INDENT.."黑石深淵, ".._RED.."黑石山";
		GREY..INDENT.."黑石塔, ".._RED.."黑石山";
		GREY..INDENT.."融火之心, ".._RED.."黑石深淵";
		GREY.."8) 監獄, ".._RED.."暴風城";
		GREY.."9) 死亡礦井, ".._RED.."西部荒野";
		GREY.."10) 祖爾格拉布, ".._RED.."荊棘谷";
		GREY.."11) 沈沒的神廟, ".._RED.."悲傷沼澤";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		BLUE.."藍:"..ORNG.." 戰場";
		GREY.."灰:"..ORNG.." 副本";
	};
	DLWest = {
		ZoneName = "地下城位置 (西部)";
		Location = "卡林多";
		BLUE.."A) 戰歌峽谷, ".._RED.."貧瘠之地 / 梣谷";
		GREY.."1) 黑暗深淵, ".._RED.."梣谷";
		GREY.."2) 怒焰裂谷, ".._RED.."奧格瑪";
		GREY.."3) 哀嚎洞穴, ".._RED.."貧瘠之地";
		GREY.."4) 瑪拉頓, ".._RED.."淒涼之地";
		GREY.."5) 厄運之槌, ".._RED.."菲拉斯";
		GREY.."6) 剃刀沼澤, ".._RED.."貧瘠之地";
		GREY.."7) 剃刀高地, ".._RED.."貧瘠之地";
		GREY.."8) 奧妮克希亞的巢穴, ".._RED.."塵泥沼澤";
		GREY.."9) 祖爾法拉克, ".._RED.."塔納利斯";
		GREY.."10) 安其拉廢墟, ".._RED.."希利蘇斯";
		GREY..INDENT.."安其拉神廟, ".._RED.."希利蘇斯";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		BLUE.."藍:"..ORNG.." 戰場";
		GREY.."灰:"..ORNG.." 副本";
	};
};

AtlasRE = {
	Azuregos = {
		ZoneName = "艾索雷葛斯";
		Location = "艾薩拉";
		GREY.."1) 艾索雷葛斯";
	};
	FourDragons = {
		ZoneName = "翡翠四巨龍";
		Location = "多個地方";
		GREN..INDENT.."雷索";
		GREN..INDENT.."艾莫莉絲";
		GREN..INDENT.."泰拉爾";
		GREN..INDENT.."伊索德雷";
		"";
		GREY.."1) 暮色森林";
		GREY.."2) 辛特蘭";
		GREY.."3) 菲拉斯";
		GREY.."4) 梣谷";
	};
	Kazzak = {
		ZoneName = "卡札克";
		Location = "詛咒之地";
		GREY.."1) 卡札克";
		GREY.."2) 守望堡";
	};
};

end

