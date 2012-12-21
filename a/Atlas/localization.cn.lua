--[[

-- Atlas Localization Data (Chinese)
-- Initial translation by DiabloHu
-- Version : Chinese (by DiabloHu)
-- Last Update : 06/20/2006
-- http://www.dreamgen.net

--]]




if ( GetLocale() == "zhCN" ) then



AtlasSortIgnore = {
}




ATLAS_TITLE = "Atlas";
ATLAS_SUBTITLE = "副本地图";
ATLAS_DESC = "Atlas 是一款副本地图查看器";

ATLAS_OPTIONS_BUTTON = "设置";

BINDING_HEADER_ATLAS_TITLE = "Atlas 按键设置";
BINDING_NAME_ATLAS_TOGGLE = "开启/关闭 Atlas";
BINDING_NAME_ATLAS_OPTIONS = "切换设置";

ATLAS_SLASH = "/atlas";
ATLAS_SLASH_OPTIONS = "设置";

ATLAS_STRING_LOCATION = "副本位置";
ATLAS_STRING_LEVELRANGE = "等级范围";
ATLAS_STRING_PLAYERLIMIT = "人数限制";
ATLAS_STRING_SELECT_CAT = "选择分类";
ATLAS_STRING_SELECT_MAP = "选择地图";

ATLAS_BUTTON_TOOLTIP = "Atlas";
ATLAS_BUTTON_TOOLTIP2 = "单击打开 Atlas";
ATLAS_BUTTON_TOOLTIP3 = "按住右键可移动这个按钮";

ATLAS_OPTIONS_TITLE = "Atlas 设置";
ATLAS_OPTIONS_SHOWBUT = "在小地图周围显示Atlas图标";
ATLAS_OPTIONS_AUTOSEL = "自动选择副本地图";
ATLAS_OPTIONS_BUTPOS = "图标位置";
ATLAS_OPTIONS_TRANS = "透明度";
ATLAS_OPTIONS_DONE = "完成";
ATLAS_OPTIONS_REPMAP = "替换世界地图";
ATLAS_OPTIONS_RCLICK = "点击右键打开世界地图";
ATLAS_OPTIONS_SHOWMAPNAME = "显示地图名称";
ATLAS_OPTIONS_RESETPOS = "重置位置";
ATLAS_OPTIONS_ACRONYMS = "显示简称";

ATLAS_HINT = "提示：单击打开 Atlas";


AtlasZoneSubstitutions = {
   ["安其拉"]               = "安其拉神殿";
}; 

local BLUE = "|cff6666ff";
local GREY = "|cff999999";
local GREN = "|cff66cc33";
local _RED = "|cffcc6666";
local ORNG = "|cffcc9933";
local PURP = "|cff9900ff";
local INDENT = "　";

--Keeps track of the different categories of maps
Atlas_MapTypes = {"副本地图", "战场地图", "飞行路线图", "地下城分布图", "户外团队作战"};

AtlasText = {
	BlackfathomDeeps = {
		ZoneName = "黑暗深渊";
		Acronym = "BFD";
		Location = "灰谷";
		BLUE.."A) 入口";
		GREY.."1) 加摩拉";
		GREY.."2) 潮湿的便笺";
		GREY.."3) 萨利维丝";
		GREY.."4) 银月守卫塞尔瑞德";
		GREY.."5) 格里哈斯特";
		GREY.."6) 洛古斯·杰特 (多个位置)";
		GREY.."7) 阿奎尼斯男爵";
		GREY..INDENT.."深渊之核";
		GREY.."8) 梦游者克尔里斯";
		GREY.."9) 瑟拉吉斯";
		GREY.."10) 阿库迈尔";
	};
	BlackrockDepths = {
		ZoneName = "黑石深渊";
		Acronym = "BRD";
		Location = "黑石山";
		BLUE.."A) 入口";
		GREY.."1) 洛考尔";
		GREY.."2) 卡兰·巨锤";
		GREY.."3) 指挥官哥沙克";
		GREY.."4) 温德索尔元帅";
		GREY.."5) 审讯官格斯塔恩";
		GREY.."6) 法律之环，塞尔德林";
		GREY.."7) 弗兰克罗恩·铸铁的雕像";
		GREY..INDENT.."控火师罗格雷恩 (稀有)";
		GREY.."8) 黑色宝库";
		GREY.."9) 弗诺斯·达克维尔";
		GREY.."10) 黑铁砧";
		GREY..INDENT.." 伊森迪奥斯";
		GREY.."11) 贝尔加";
		GREY.."12) 暗炉之锁";
		GREY.."13) 安格弗将军";
		GREY.."14) 傀儡统帅阿格曼奇";
		GREY.."15) 黑铁酒吧";
		GREY.."16) 弗莱拉斯大使";
		GREY.."17) 无敌的潘佐尔 (稀有)";
		GREY.."18) 召唤者之墓";
		GREY.."19) 讲学厅";
		GREY.."20) 玛格姆斯";
		GREY.."21) 达格兰·索瑞森大帝";
		GREY..INDENT.." 铁炉堡公主茉艾拉·铜须";
		GREY.."22) 黑熔炉";
		GREY.."23) 熔火之心 (团队副本)";
	};
	BlackrockSpireLower = {
		ZoneName = "黑石塔 (下层)";
		Acronym = "LBRS";
		Location = "黑石山";
		BLUE.."A) 入口";
		GREY.."1) 瓦罗什";
		GREY.."2) 尖锐长矛";
		GREY.."3) 欧莫克大王";
		GREY..INDENT.."尖石统帅 (稀有)";
		GREY.."4) 暗影猎手沃什加斯";
		GREY..INDENT.."第五块摩沙鲁石板";
		GREY.."5) 指挥官沃恩";
		GREY..INDENT.."第六块摩沙鲁石板";
		GREY..INDENT.."莫尔·灰蹄";
		GREY.."6) 烟网蛛后";
		GREY.."7) 水晶之牙 (稀有)";
		GREY.."8) 乌洛克";
		GREY.."9) 军需官兹格雷斯";
		GREY.."10) 奴役者基兹鲁尔";
		GREY..INDENT.." 哈雷肯";
		GREY.."11) 维姆萨拉克";
		GREY.."12) 班诺克·巨斧 (稀有)";
		GREY.."13) 尖石屠夫 (稀有)";
	};
	BlackrockSpireUpper = {
		ZoneName = "黑石塔 (上层)";
		Acronym = "UBRS";
		Location = "黑石山";
		BLUE.."A) 入口";
		GREY.."1) 烈焰卫士艾博希尔";
		GREY.."2) 索拉卡·火冠";
		GREY..INDENT.."烈焰之父";
		GREY.."3) 杰德 (稀有)";
		GREY.."4) 古拉鲁克";
		GREY.."5) 大酋长雷德·黑手";
		GREY..INDENT.."盖斯";
		GREY.."6) 奥比";
		GREY.."7) 比斯巨兽";
		GREY..INDENT.."瓦塔拉克公爵";
		GREY.."8) 达基萨斯将军";
		GREY..INDENT.."末日扣环";
		GREY.."9) 黑翼之巢 (团队副本)";
	};
	BlackwingLair = {
		ZoneName = "黑翼之巢";
		Acronym = "BWL";
		Location = "黑石塔";
		BLUE.."A) 入口";
		BLUE.."B) 通道";
		BLUE.."C) 通道";
		GREY.."1) 狂野的拉格佐尔";
		GREY.."2) 堕落的瓦拉斯塔兹";
		GREY.."3) 勒什雷尔";
		GREY.."4) 费尔默";
		GREY.."5) 埃博诺克";
		GREY.."6) 弗莱格尔";
		GREY.."7) 克洛玛古斯";
		GREY.."8) 奈法利安";
		GREY.."9) 大元素师克里希克";
	};
	DireMaulEast = {
		ZoneName = "厄运之槌 (东区)";
		Acronym = "DM";
		Location = "菲拉斯";
		BLUE.."A) 入口";
		BLUE.."B) 入口";
		BLUE.."C) 入口";
		BLUE.."D) 出口";
		GREY.."1) 开始追捕普希林";
		GREY.."2) 结束追捕普希林";
		GREY.."3) 瑟雷姆·刺蹄";
		GREY..INDENT.."海多斯博恩";
		GREY..INDENT.."雷瑟塔帝丝";
		GREY.."4) 埃隆巴克";
		GREY.."5) 奥兹恩";
		GREY..INDENT.."伊萨莉恩";
	};
	DireMaulNorth = {
		ZoneName = "厄运之槌 (北区)";
		Acronym = "DM";
		Location = "菲拉斯";
		BLUE.."A) 入口";
		GREY.."1) 卫兵摩尔达";
		GREY.."2) 践踏者克雷格";
		GREY.."3) 卫兵芬古斯";
		GREY.."4) 诺特·希姆加可";
		GREY..INDENT.."卫兵斯里基克";
		GREY.."5) 克罗卡斯";
		GREY.."6) 戈多克大王";
		GREY.."7) 厄运之槌 (西区)";
		GREN.."1') 图书馆";
	};
	DireMaulWest = {
		ZoneName = "厄运之槌 (西区)";
		Acronym = "DM";
		Location = "菲拉斯";
		BLUE.."A) 入口";
		BLUE.."B) 水晶塔";
		GREY.."1) 辛德拉古灵";
		GREY.."2) 特迪斯·扭木";
		GREY.."3) 伊琳娜·暗木";
		GREY.."4) 卡雷迪斯镇长";
		GREY.."5) 苏斯 (稀有)";
		GREY.."6) 伊莫塔尔";
		GREY..INDENT.."赫尔努拉斯";
		GREY.."7) 托塞德林王子";
		GREY.."8) 厄运之槌 (北区)";
		GREN.."1') 图书馆";
	};
	Gnomeregan = {
		ZoneName = "诺莫瑞根";
		Location = "丹莫罗";
		BLUE.."A) 入口 (正门)";
		BLUE.."B) 入口 (后门)";
		GREY.."1) 粘性辐射尘 (下层)";
		GREY.."2) 格鲁比斯";
		GREY.."3) 矩阵式打孔计算机 3005-B";
		GREY.."4) 清洗区";
		GREY.."5) 电刑器6000型";
		GREY..INDENT.."矩阵式打孔计算机 3005-C";
		GREY.."6) 麦克尼尔·瑟玛普拉格";
		GREY.."7) 黑铁大师 (稀有)";
		GREY.."8) 群体打击者9-60";
		GREY..INDENT.."矩阵式打孔计算机 3005-D";
	};
	Maraudon = {
		ZoneName = "玛拉顿";
		Acronym = "Mara/MLD";
		Location = "凄凉之地";
		BLUE.."A) 入口 (橙色)";
		BLUE.."B) 入口 (紫色)";
		BLUE.."C) 入口 (传送)";
		GREY.."1) 温格 (第五可汗)";
		GREY.."2) 诺克赛恩";
		GREY.."3) 锐刺鞭笞者";
		GREY.."4) 玛劳杜斯 (第四可汗)";
		GREY.."5) 维利塔恩";
		GREY.."6) 收割者麦什洛克 (稀有)";
		GREY.."7) 被诅咒的塞雷布拉斯";
		GREY.."8) 兰斯利德";
		GREY.."9) 工匠吉兹洛克";
		GREY.."10) 洛特格里普";
		GREY.."11) 瑟莱德丝公主";
	};
	MoltenCore = {
		ZoneName = "熔火之心";
		Acronym = "MC";
		Location = "黑石深渊";
		BLUE.."A) 入口";
		GREY.."1) 鲁西弗隆";
		GREY.."2) 玛格曼达";
		GREY.."3) 基赫纳斯";
		GREY.."4) 加尔";
		GREY.."5) 沙斯拉尔";
		GREY.."6) 迦顿男爵";
		GREY.."7) 焚化者古雷曼格";
		GREY.."8) 萨弗隆先驱者";
		GREY.."9) 管理者埃克索图斯";
		GREY.."10) 拉格纳罗斯";
	};
	OnyxiasLair = {
		ZoneName = "奥妮克希亚的巢穴";
		Location = "尘泥沼泽";
		BLUE.."A) 入口";
		GREY.."1) 奥妮克希亚守卫";
		GREY.."2) 雏龙蛋";
		GREY.."3) 奥妮克希亚";
	};
	RagefireChasm = {
		ZoneName = "怒焰裂谷";
		Acronym = "RFC";
		Location = "奥格瑞玛";
		BLUE.."A) 入口";
		GREY.."1) 玛尔·恐怖图腾";
		GREY.."2) 饥饿者塔拉加曼";
		GREY.."3) 祈求者耶戈什";
		GREY.."4) 巴扎兰";
	};
	RazorfenDowns = {
		ZoneName = "剃刀高地";
		Acronym = "RFD";
		Location = "贫瘠之地";
		BLUE.."A) 入口";
		GREY.."1) 图特卡什";
		GREY.."2) 亨利·斯特恩";
		GREY..INDENT.."奔尼斯特拉兹";
		GREY.."3) 火眼莫德雷斯";
		GREY.."4) 暴食者";
		GREY.."5) 拉戈斯诺特 (稀有)";
		GREY.."6) 寒冰之王亚门纳尔";
	};
	RazorfenKraul = {
		ZoneName = "剃刀沼泽";
		Acronym = "RFK";
		Location = "贫瘠之地";
		BLUE.."A) 入口";
		GREY.."1) 鲁古格";
		GREY.."2) 阿格姆";
		GREY.."3) 亡语者贾格巴";
		GREY.."4) 主宰拉姆塔斯";
		GREY.."5) 暴怒的阿迦赛罗斯";
		GREY.."6) 盲眼猎手 (稀有)";
		GREY.."7) 卡尔加·刺肋";
		GREY.."8) 进口商威利克斯";
		GREY..INDENT.."赫尔拉斯·静水";
		GREY.."9) 唤地者哈穆加 (稀有)";
	};
	ScarletMonastery = {
		ZoneName = "血色修道院";
		Acronym = "SM";
		Location = "提瑞斯法林地";
		BLUE.."A) 入口 (图书馆)";
		BLUE.."B) 入口 (军械库)";
		BLUE.."C) 入口 (大教堂)";
		BLUE.."D) 入口 (墓地)";
		GREY.."1) 驯犬者洛克希";
		GREY.."2) 奥法师杜安";
		GREY.."3) 赫洛德";
		GREY.."4) 大检察官法尔班克斯";
		GREY.."5) 血色十字军指挥官莫格莱尼";
		GREY..INDENT.."大检察官怀特迈恩";
		GREY.."6) 铁脊死灵 (稀有)";
		GREY.."7) 永醒的艾希尔 (稀有)";
		GREY.."8) 死灵勇士 (稀有)";
		GREY.."9) 血法师萨尔诺斯";
	};
	Scholomance = {
		ZoneName = "通灵学院";
		Acronym = "Scholo/TL";
		Location = "西瘟疫之地";
		BLUE.."A) 入口";
		BLUE.."B) 楼梯";
		BLUE.."C) 楼梯";
		GREY.."1) 基尔图诺斯的卫士";
		GREY..INDENT.."南海镇地契";
		GREY.."2) 传令官基尔图诺斯";
		GREY.."3) 詹迪斯·巴罗夫";
		GREY.."4) 塔伦米尔地契";
		GREY.."5) 血骨傀儡 (下层)";
		GREY..INDENT.."死亡骑士达克雷尔";
		GREY.."6) 马杜克·布莱克波尔";
		GREY..INDENT.."维克图斯";
		GREY.."7) 莱斯·霜语";
		GREY..INDENT.."布瑞尔地契";
		GREY..INDENT.."库尔莫克";
		GREY.."8) 讲师玛丽希亚";
		GREY.."9) 瑟尔林·卡斯迪诺夫教授";
		GREY.."10) 博学者普克尔特";
		GREY.."11) 拉文尼亚";
		GREY.."12) 阿雷克斯·巴罗夫";
		GREY..INDENT.." 凯尔达隆地契";
		GREY.."13) 伊露希亚·巴罗夫";
		GREY.."14) 黑暗院长加丁";
		GREN.."1') 火炬";
		GREN.."2') 旧宝藏箱";
		GREN.."3') 炼金实验室";
	};
	ShadowfangKeep = {
		ZoneName = "影牙城堡";
		Acronym = "SFK";
		Location = "银松森林";
		BLUE.."A) 入口";
		BLUE.."B) 通道";
		BLUE.."C) 通道";
		BLUE..INDENT.."死亡之誓 (稀有)";
		GREY.."1) 亡灵哨兵阿达曼特";
		GREY..INDENT.."巫师阿克鲁比";
		GREY..INDENT.."雷希戈尔";
		GREY.."2) 屠夫拉佐克劳";
		GREY.."3) 席瓦莱恩男爵";
		GREY.."4) 指挥官斯普林瓦尔";
		GREY.."5) 盲眼守卫奥杜";
		GREY.."6) 吞噬者芬鲁斯";
		GREY.."7) 狼王南杜斯";
		GREY.."8) 大法师阿鲁高";
	};
	Stratholme = {
		ZoneName = "斯坦索姆";
		Acronym = "Strat/STSM";
		Location = "东瘟疫之地";
		BLUE.."A) 入口 (正门)";
		BLUE.."B) 入口 (旁门)";
		GREY.."1) 斯库尔 (稀有)";
		GREY..INDENT.."斯坦索姆信使";
		GREY..INDENT.."弗拉斯·希亚比";
		GREY.."2) 弗雷斯特恩 (多个位置)";
		GREY.."3) 不可宽恕者";
		GREY.."4) 悲惨的提米";
		GREY.."5) 炮手威利";
		GREY.."6) 档案管理员加尔福特";
		GREY.."7) 巴纳扎尔";
		GREY..INDENT.."索托斯";
		GREY..INDENT.."亚雷恩";
		GREY.."8) 奥里克斯";
		GREY.."9) 石脊 (稀有)";
		GREY.."10) 安娜丝塔丽男爵夫人";
		GREY.."11) 奈鲁布恩坎";
		GREY.."12) 苍白的玛勒基";
		GREY.."13) 巴瑟拉斯镇长 (多个位置)";
		GREY.."14) 吞咽者拉姆斯登";
		GREY.."15) 瑞文戴尔男爵";
		GREN.."1') 十字军广场邮箱";
		GREN.."2') 市场邮箱";
		GREN.."3') 节日小道的邮箱";
		GREN.."4') 长者广场邮箱";
		GREN.."5') 国王广场邮箱";
		GREN.."6') 弗拉斯·希亚比的邮箱";
	};
	TheDeadmines = {
		ZoneName = "死亡矿井";
		Acronym = "VC";
		Location = "西部荒野";
		BLUE.."A) 入口";
		BLUE.."B) 出口";
		GREY.."1) 拉克佐";
		GREY.."2) 矿工约翰森 (稀有)";
		GREY.."3) 斯尼德";
		GREY.."4) 基尔尼格";
		GREY.."5) 迪菲亚火药";
		GREY.."6) 绿皮队长";
		GREY..INDENT.."曲奇";
		GREY..INDENT.."重拳先生";
		GREY..INDENT.."艾德温·范克利夫";
	};
	TheStockade = {
		ZoneName = "监狱";
		Location = "暴风城";
		BLUE.."A) 入口";
		GREY.."1) 可怕的塔格尔 (多个位置)";
		GREY.."2) 卡姆·深怒";
		GREY.."3) 哈姆霍克";
		GREY.."4) 巴吉尔·特雷德";
		GREY.."5) 迪克斯特·瓦德";
		GREY.."6) Bruegal Ironknuckle (稀有)";
	};
	TheSunkenTemple = {
		ZoneName = "阿塔哈卡神庙";
		Acronym = "ST";
		Location = "悲伤沼泽";
		BLUE.."A) 入口";
		BLUE.."B) 楼梯";
		BLUE.."C) 巨魔小首领 (上层)";
		GREY.."1) 哈卡祭坛";
		GREY..INDENT.."阿塔拉利恩";
		GREY.."2) 德姆赛卡尔";
		GREY..INDENT.."德拉维沃尔";
		GREY.."3) 哈卡的化身";
		GREY.."4) 预言者迦玛兰";
		GREY..INDENT.."可悲的奥戈姆";
		GREY.."5) 摩弗拉斯";
		GREY..INDENT.."哈扎斯";
		GREY.."6) 伊兰尼库斯的阴影";
		GREY..INDENT.."精华之泉";
		GREN.."1'-6') 雕像激活顺序";
	};
	Uldaman = {
		ZoneName = "奥达曼";
		Acronym = "Ulda/ADM";
		Location = "荒芜之地";
		BLUE.."A) 入口 (前门)";
		BLUE.."B) 入口 (后门)";
		GREY.."1) 巴尔洛戈";
		GREY.."2) 圣骑士的遗体";
		GREY.."3) 鲁维罗什";
		GREY.."4) 艾隆纳亚";
		GREY.."5) 黑曜石哨兵";
		GREY.."6) 安诺拉 (大师级附魔师)";
		GREY.."7) 古代的石头看守者";
		GREY.."8) 加加恩·火锤";
		GREY.."9) 格瑞姆洛克";
		GREY.."10) 阿扎达斯 (下层)";
		GREY.."11) 诺甘农圆盘 (下层)";
		GREY..INDENT.." 古代宝藏 (下层)";
	};
	WailingCaverns = {
		ZoneName = "哀嚎洞穴";
		Acronym = "WC";
		Location = "贫瘠之地";
		BLUE.."A) 入口";
		GREY.."1) 纳拉雷克斯的信徒";
		GREY.."2) 考布莱恩";
		GREY.."3) 安娜科德拉";
		GREY.."4) 克雷什";
		GREY.."5) 皮萨斯";
		GREY.."6) 斯卡姆";
		GREY.."7) 瑟芬迪斯 (上层)";
		GREY.."8) 永生者沃尔丹 (上层)";
		GREY.."9) 吞噬者穆坦努斯";
		GREY..INDENT.."纳拉雷克斯";
		GREY.."10) 变异精灵龙 (稀有)";
	};
	ZulFarrak = {
		ZoneName = "祖尔法拉克";
		Acronym = "ZF";
		Location = "塔纳利斯";
		BLUE.."A) 入口";
		GREY.."1) 安图苏尔";
		GREY.."2) 殉教者塞卡";
		GREY.."3) 巫医祖穆拉恩";
		GREY..INDENT.."祖尔法拉克阵亡英雄";
		GREY.."4) 耐克鲁姆";
		GREY..INDENT.."暗影祭司塞瑟斯";
		GREY.."5) 布莱中士";
		GREY.."6) 水占师维蕾萨";
		GREY..INDENT.."加兹瑞拉";
		GREY..INDENT.."灰尘怨灵 (稀有)";
		GREY.."7) 乌克兹·沙顶";
		GREY..INDENT.."卢兹鲁";
		GREY.."8) 泽雷利斯 (稀有, 巡逻)";
		GREY.."9) 杉达尔·沙掠者 (稀有)";
	};
	ZulGurub = {
		ZoneName = "祖尔格拉布";
		Acronym = "ZG";
		Location = "荆棘谷";
		BLUE.."A) 入口";
		GREY.."1) 高阶祭司耶克里克 (蝙蝠)";
		GREY.."2) 高阶祭司温诺西斯 (毒蛇)";
		GREY.."3) 高阶祭司玛尔里 (蜘蛛)";
		GREY.."4) 血领主曼多基尔 (迅猛龙, 可跳过)";
		GREY.."5) 疯狂之源 (可跳过)";
		GREY..INDENT.."格里雷克，钢铁之血";
		GREY..INDENT.."哈扎拉尔，织梦者";
		GREY..INDENT.."雷纳塔基，千刃之王";
		GREY..INDENT.."雷巫乌苏雷";
		GREY.."6) 加兹兰卡 (可跳过)";
		GREY.."7) 高阶祭司塞卡尔 (猛虎)";
		GREY.."8) 高阶祭司娅尔罗 (猎豹)";
		GREY.."9) 妖术师金度 (亡灵, 可跳过)";
		GREY.."10) 哈卡";
		GREN.."1') 混浊的水";
	};
	TheTempleofAhnQiraj = {
		ZoneName = "安其拉神殿";
		Acronym = "AQ40";
		Location = "希利苏斯";
		BLUE.."A) 入口";
		GREY.."1) 预言者斯克拉姆 (室外)";
		GREY.."2) 维姆 (可跳过)";
		GREY..INDENT.."亚尔基公主 (可跳过)";
		GREY..INDENT.."克里勋爵 (可跳过)";
		GREY.."3) 沙尔图拉";
		GREY.."4) 顽强的范克瑞斯";
		GREY.."5) 维希度斯 (可跳过)";
		GREY.."6) 哈霍兰公主";
		GREY.."7) 维克尼拉斯大帝";
		GREY..INDENT.."维克洛尔大帝";
		GREY.."8) 奥罗 (可跳过)";
		GREY.."9) 克苏恩";
		GREN.."1') 安多葛斯";
		GREN..INDENT.."温瑟拉";
		GREN..INDENT.."坎多斯特拉兹";
		GREN.."2') 亚雷戈斯";
		GREN..INDENT.."凯雷斯特拉兹";
		GREN..INDENT.."梦境之龙麦琳瑟拉";
	};
	TheRuinsofAhnQiraj = {
		ZoneName = "安其拉废墟";
		Acronym = "AQ20";
		Location = "希利苏斯";
		BLUE.."A) 入口";
		GREY.."1) 库林纳克斯";
		GREY..INDENT.."安多洛夫中将";
		GREY..INDENT.."卡多雷四精英";
		GREY.."2) 拉贾克斯将军";
		GREY..INDENT.."奎兹上尉";
		GREY..INDENT.."图比德上尉";
		GREY..INDENT.."德雷恩上尉";
		GREY..INDENT.."库雷姆上尉";
		GREY..INDENT.."耶吉斯少校";
		GREY..INDENT.."帕库少校";
		GREY..INDENT.."泽兰上校";
		GREY.."3) 莫阿姆 (可跳过)";
		GREY.."4) 吞咽者布鲁 (可跳过)";
		GREY.."5) 狩猎者阿亚米斯 (可跳过)";
		GREY.."6) 无疤者奥斯里安";
		GREN.."1') 安全房间";
	};
	Naxxramas = {
		ZoneName = "纳克萨玛斯";
		Acronym = "Nax";
		Location = "斯坦索姆";
		BLUE.."憎恶翼";
		BLUE..INDENT.."1) 帕奇维克";
		BLUE..INDENT.."2) 格罗布鲁斯";
		BLUE..INDENT.."3) 格拉斯";
		BLUE..INDENT.."4) 塔迪乌斯";
		ORNG.."地穴蜘蛛翼";
		ORNG..INDENT.."1) 阿努布雷坎";
		ORNG..INDENT.."2) 黑女巫法琳娜";
		ORNG..INDENT.."3) 迈克斯纳";
		_RED.."死亡骑士翼";
		_RED..INDENT.."1) 教官拉苏维奥斯";
		_RED..INDENT.."2) 收割者戈提克";
		_RED..INDENT.."3) 四死亡骑士";
		_RED..INDENT..INDENT.."库尔塔兹领主";
		_RED..INDENT..INDENT.."女公爵布劳缪克丝";
		_RED..INDENT..INDENT.."大领主莫格莱尼";
		_RED..INDENT..INDENT.."瑟里耶克爵士";
		PURP.."瘟疫翼";
		PURP..INDENT.."1) 瘟疫使者诺斯";
		PURP..INDENT.."2) 肮脏的希尔盖";
		PURP..INDENT.."3) 洛欧塞布";
		GREN.."冰霜飞龙巢穴";
		GREN..INDENT.."1) 萨菲隆";
		GREN..INDENT.."2) 克尔苏加德";
	};
};


AtlasBG = {
	AlteracValleyNorth = {
		ZoneName = "奥特兰克山谷 (北部)";
		Location = "奥特兰克山脉";
		BLUE.."A) 入口";
		BLUE.."B) 丹巴达尔 (联盟)";
		_RED.."1) 雷矛急救站";
		_RED.."2) 雷矛墓地";
		_RED.."3) 石炉墓地";
		_RED.."4) 落雪墓地";
		ORNG.."5) 丹巴达尔北部碉堡";
		GREY..INDENT.."空军指挥官穆维里克 (部落)";
		ORNG.."6) 丹巴达尔南部碉堡";
		ORNG.."7) 冰翼碉堡";
		GREY..INDENT.."空军指挥官古斯 (部落)";
		GREY..INDENT.."指挥官卡尔·菲利普 (联盟)";
		ORNG.."8) 石炉哨站 (巴琳达)";
		ORNG.."9) 石炉碉堡";
		GREY.."10) 深铁矿洞";
		GREY.."11) 冰翼洞穴";
		GREY.."12) 蒸汽锯 (部落)";
		GREY.."13) 空军指挥官杰斯托 (部落)";
		GREY.."14) 森林之王伊弗斯 (召唤区域)";
		"";
		"";
		"";
		"";
		"";
		_RED.."红色:"..BLUE.." 墓地, 占领区域";
		ORNG.."橙色:"..BLUE.." 碉堡, 哨塔, 摧毁区域";
		GREY.."白色:"..BLUE.." 相关 NPC, 任务区域";
	};
	AlteracValleySouth = {
		ZoneName = "奥特兰克山谷 (南部)";
		Location = "奥特兰克山脉";
		BLUE.."A) 入口";
		BLUE.."B) 霜狼要塞 (部落)";
		_RED.."1) 霜狼急救站";
		_RED.."2) 霜狼墓地";
		_RED.."3) 冰血墓地";
		ORNG.."4) 西部霜狼哨塔";
		ORNG.."5) 东部霜狼哨塔";
		GREY..INDENT.."空军指挥官艾克曼 (联盟)";
		ORNG.."6) 哨塔高地";
		GREY..INDENT.."空军指挥官斯里多尔 (联盟)";
		GREY..INDENT.."指挥官刘易斯·菲利普 (部落)";
		ORNG.."7) 冰血哨塔";
		ORNG.."8) 冰血要塞 (加尔范)";
		GREY.."9) 蛮爪洞穴";
		GREY.."10) 霜狼骑兵指挥官";
		GREY.."11) 空军指挥官维波里 (联盟)";
		GREY.."12) 冷齿矿洞";
		GREY.."13) 蒸汽锯 (联盟)";
		GREY.."14) 冰雪之王洛克霍拉 (召唤区域)";
		"";
		"";
		"";
		"";
		"";
		_RED.."红色:"..BLUE.." 墓地, 占领区域";
		ORNG.."橙色:"..BLUE.." 碉堡, 哨塔, 摧毁区域";
		GREY.."白色:"..BLUE.." 相关 NPC, 任务区域";
	};
	ArathiBasin = {
		ZoneName = "阿拉希盆地";
		Location = "阿拉希高地";
		BLUE.."A) 托尔贝恩大厅";
		BLUE.."B) 污染者之穴";
		GREY.."1) 兽栏";
		GREY.."2) 金矿";
		GREY.."3) 铁匠铺";
		GREY.."4) 伐木场";
		GREY.."5) 农场";
	};
	WarsongGulch = {
		ZoneName = "战歌峡谷";
		Location = "灰谷/贫瘠之地";
		BLUE.."A) 银翼要塞";
		BLUE.."B) 战歌伐木场";
	};
};

AtlasFP = {
	FPAllianceEast = {
		ZoneName = "联盟 (东部)";
		Location = "东部王国";
		GREY.."1) 圣光之愿礼拜堂, ".._RED.."东瘟疫之地";
		GREY.."2) 冰风岗, ".._RED.."西瘟疫之地";
		GREY.."3) 鹰巢山, ".._RED.."辛特兰";
		GREY.."4) 南海镇, ".._RED.."希尔斯布莱德丘陵";
		GREY.."5) 避难谷地, ".._RED.."阿拉希高地";
		GREY.."6) 米奈希尔港, ".._RED.."湿地";
		GREY.."7) 铁炉堡, ".._RED.."丹莫罗";
		GREY.."8) 塞尔萨玛, ".._RED.."洛克莫丹";
		GREY.."9) 瑟银哨塔, ".._RED.."灼热峡谷";
		GREY.."10) 摩根的岗哨, ".._RED.."燃烧平原";
		GREY.."11) 暴风城, ".._RED.."艾尔文森林";
		GREY.."12) 湖畔镇, ".._RED.."赤脊山";
		GREY.."13) 哨兵岭, ".._RED.."西部荒野";
		GREY.."14) 夜色镇, ".._RED.."暮色森林";
		GREY.."15) 守望堡, ".._RED.."诅咒之地";
		GREY.."16) 藏宝海湾, ".._RED.."荆棘谷";
	};
	FPAllianceWest = {
		ZoneName = "联盟 (西部)";
		Location = "卡利姆多";
		GREY.."1) 鲁瑟兰村, ".._RED.."泰达希尔";
		GREY.."2) 雷姆洛斯神殿, ".._RED.."月光林地";
		GREY.."3) 永望镇, ".._RED.."冬泉谷";
		GREY.."4) 奥伯丁, ".._RED.."黑海岸";
		GREY.."5) 刺枝林地, ".._RED.."费物德森林";
		GREY.."6) 石爪峰, ".._RED.."石爪山脉";
		GREY.."7) 阿斯特兰纳, ".._RED.."灰谷";
		GREY.."8) 塔伦迪斯营地, ".._RED.."艾萨拉";
		GREY.."9) 尼耶尔前哨战, ".._RED.."凄凉之地";
		GREY.."10) 棘齿城, ".._RED.."贫瘠之地";
		GREY.."11) 塞拉莫岛, ".._RED.."尘泥沼泽";
		GREY.."12) 羽月要塞, ".._RED.."菲拉斯";
		GREY.."13) 萨兰纳尔, ".._RED.."菲拉斯";
		GREY.."14) 马绍尔营地, ".._RED.."安戈洛环形山";
		GREY.."15) 塞纳里奥要塞, ".._RED.."希利苏斯";
		GREY.."16) 加基森, ".._RED.."塔纳利斯";
	};
	FPHordeEast = {
		ZoneName = "部落 (东部)";
		Location = "东部王国";
		GREY.."1) 圣光之愿礼拜堂, ".._RED.."东瘟疫之地";
		GREY.."2) 幽暗城, ".._RED.."提瑞斯法林地";
		GREY.."3) 瑟伯切尔, ".._RED.."银松森林";
		GREY.."4) 塔伦米尔, ".._RED.."希尔斯布莱德丘陵";
		GREY.."5) 恶齿村, ".._RED.."辛特兰";
		GREY.."6) 落锤镇, ".._RED.."阿拉希高地";
		GREY.."7) 瑟银哨塔, ".._RED.."灼热峡谷";
		GREY.."8) 卡加斯, ".._RED.."荒芜之地";
		GREY.."9) 索瑞森废墟, ".._RED.."燃烧平原";
		GREY.."10) 斯通纳德, ".._RED.."悲伤沼泽";
		GREY.."11) 格罗姆高营地, ".._RED.."荆棘谷";
		GREY.."12) 藏宝海湾, ".._RED.."荆棘谷";
	};
	FPHordeWest = {
		ZoneName = "部落 (西部)";
		Location = "卡利姆多";
		GREY.."1) 雷姆洛斯神殿, ".._RED.."月光林地";
		GREY.."2) 永望镇, ".._RED.."冬泉谷";
		GREY.."3) 血毒岗哨, ".._RED.."费物德森林";
		GREY.."4) 佐拉姆加前哨战, ".._RED.."灰谷";
		GREY.."5) 瓦罗莫克, ".._RED.."艾萨拉";
		GREY.."6) 碎木岗哨, ".._RED.."灰谷";
		GREY.."7) 奥格瑞玛, ".._RED.."杜隆塔尔";
		GREY.."8) 烈日石居, ".._RED.."石爪山脉";
		GREY.."9) 十字路口, ".._RED.."贫瘠之地";
		GREY.."10) 棘齿城, ".._RED.."贫瘠之地";
		GREY.."11) 葬影村, ".._RED.."凄凉之地";
		GREY.."12) 雷霆崖, ".._RED.."莫高雷";
		GREY.."13) 陶拉祖营地, ".._RED.."贫瘠之地";
		GREY.."14) 蕨墙村, ".._RED.."沉泥沼泽";
		GREY.."15) 莫沙彻营地, ".._RED.."菲拉斯";
		GREY.."16) 乱风岗, ".._RED.."千针石林";
		GREY.."17) 马绍尔营地, ".._RED.."安戈洛环形山";
		GREY.."18) 塞纳里奥要塞, ".._RED.."希利苏斯";
		GREY.."19) 加基森, ".._RED.."塔纳利斯";
	};
};

AtlasDL = {
	DLEast = {
		ZoneName = "地下城分布图 (东部)";
		Location = "东部王国";
		BLUE.."A) 奥特兰克山谷, ".._RED.."奥特兰克/希尔斯布莱德";
		BLUE.."B) 阿拉希盆地, ".._RED.."阿拉希高地";
		GREY.."1) 血色修道院, ".._RED.."提瑞斯法林地";
		GREY.."2) 斯坦所姆, ".._RED.."东瘟疫之地";
		GREY..INDENT.."纳克萨玛斯, ".._RED.."斯坦所姆";
		GREY.."3) 通灵学院, ".._RED.."西瘟疫之地";
		GREY.."4) 影牙城堡, ".._RED.."银松森林";
		GREY.."5) 诺莫瑞根, ".._RED.."丹莫罗";
		GREY.."6) 奥达曼, ".._RED.."荒芜之地";
		GREY.."7) 黑翼之巢, ".._RED.."黑石塔";
		GREY..INDENT.."黑石深渊, ".._RED.."黑石山";
		GREY..INDENT.."黑石塔, ".._RED.."黑石山";
		GREY..INDENT.."熔火之心, ".._RED.."黑石深渊";
		GREY.."8) 监狱, ".._RED.."暴风城";
		GREY.."9) 死亡矿井, ".._RED.."西部荒野";
		GREY.."10) 祖尔格拉布, ".._RED.."荆棘谷";
		GREY.."11) 阿塔哈卡神庙, ".._RED.."悲伤沼泽";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		"";
		BLUE.."蓝色:"..ORNG.." 战场";
		GREY.."白色:"..ORNG.." 副本地下城";
	};
	DLWest = {
		ZoneName = "地下城分布图 (西部)";
		Location = "卡利姆多";
		BLUE.."A) 战歌峡谷, ".._RED.."贫瘠之地/灰谷";
		GREY.."1) 黑暗深渊, ".._RED.."灰谷";
		GREY.."2) 怒焰裂谷, ".._RED.."奥格瑞玛";
		GREY.."3) 哀嚎洞穴, ".._RED.."贫瘠之地";
		GREY.."4) 玛拉顿, ".._RED.."凄凉之地";
		GREY.."5) 厄运之槌, ".._RED.."菲拉斯";
		GREY.."6) 剃刀沼泽, ".._RED.."贫瘠之地";
		GREY.."7) 剃刀高地, ".._RED.."贫瘠之地";
		GREY.."8) 奥妮克希亚的巢穴, ".._RED.."尘泥沼泽";
		GREY.."9) 祖尔法拉克, ".._RED.."塔纳利斯";
		GREY.."10) 安其拉废墟, ".._RED.."希利苏斯";
		GREY..INDENT.."安其拉神殿, ".._RED.."希利苏斯";
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
		BLUE.."蓝色:"..ORNG.." 战场";
		GREY.."白色:"..ORNG.." 副本地下城";
	};
};


AtlasRE = {
	Azuregos = {
		ZoneName = "艾索雷葛斯";
		Location = "艾萨拉";
		GREY.."1) 艾索雷葛斯";
	};
	FourDragons = {
		ZoneName = "梦魇巨龙";
		Location = "不定";
		GREN..INDENT.."莱索恩";
		GREN..INDENT.."艾莫莉丝";
		GREN..INDENT.."泰拉尔";
		GREN..INDENT.."伊森德雷";
		"";
		GREY.."1) 暮色森林";
		GREY.."2) 辛特兰";
		GREY.."3) 菲拉斯";
		GREY.."4) 灰谷";
	};
	Kazzak = {
		ZoneName = "卡扎克";
		Location = "诅咒之地";
		GREY.."1) 卡扎克";
		GREY.."2) 守望堡";
	};
};
end


