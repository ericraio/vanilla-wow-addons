--   
-- Localisation for MobInfo
--
-- created by 影千代@布蘭卡德
-- Date: 2006/6/13
--
-- zhTW Chinese Traditional localization
--

if ( GetLocale() == "zhTW" ) then
MI_DESCRIPTION = "增加怪物的詳細相關資訊到提示訊息視窗，並且在目標狀態欄顯示估計的生命/法力資料";

MI_MOB_DIES_WITH_XP = "(.+)死亡，你獲得[^%d]*(%d+)點經驗值。";
MI_MOB_DIES_WITHOUT_XP = "(.+)死亡了。";
MI_PARSE_SPELL_DMG = "(.+)的(.+)擊中你造成(%d+)點.*傷害";
MI_PARSE_BOW_DMG = "(.+)的(.+)擊中你造成(%d+)點傷害";
MI_PARSE_COMBAT_DMG = "(.+)擊中你造成(%d+)點傷害";
MI_PARSE_SELF_MELEE = "你擊中(.+)造成(%d+)點傷害";
MI_PARSE_SELF_MELEE_CRIT = "你對(.+)造成(%d+)的致命一擊傷害";
MI_PARSE_SELF_SPELL = "你的(.+)擊中(.+)造成(%d+)點.+傷害";
MI_PARSE_SELF_SPELL_CRIT = "你的(.+)致命一擊對(.+)造成(%d+)點.+傷害";
MI_PARSE_SELF_BOW = "你的(.+)擊中(.+)造成(%d+)點傷害";
MI_PARSE_SELF_BOW_CRIT = "你的(.+)對(.+)造成(%d+)的致命一擊傷害";
MI_PARSE_SELF_PET = "(.+)擊中(.+)造成(%d+)點傷害";
MI_PARSE_SELF_PET_CRIT = "(.+)對(.+)造成(%d+)的致命一擊傷害";
MI_PARSE_SELF_PET_SPELL = "(.+)的(.+)擊中(.+)造成(%d+)點傷害";
MI_PARSE_SELF_PET_SPELL_CRIT = "(.+)的(.+)對(.+)造成(%d+)點致命一擊傷害";
MI_PARSE_SELF_SPELL_PERIODIC = "你的(.+)使(.+)受到了(%d+)點(.+)傷害";

MI_TXT_GOLD   = "金";
MI_TXT_SILVER = "銀";
MI_TXT_COPPER = "銅";

MI_TXT_CONFIG_TITLE		= "MobInfo 2 選項";
MI_TXT_WELCOME          = "歡迎使用 MobInfo 2!";
MI_TXT_OPEN				= "開啟";
MI_TXT_CLASS			= "職業";
MI_TXT_HEALTH			= "生命值";
MI_TXT_MANA				= "法力值";
MI_TXT_XP				= "經驗";
MI_TXT_KILLS			= "殺死數";
MI_TXT_DAMAGE			= "傷害 + [DPS]";
MI_TXT_TIMES_LOOTED		= "拾取次數";
MI_TXT_EMPTY_LOOTS		= "空身取數";
MI_TXT_TO_LEVEL			= "升級還需 # 個";
MI_TXT_QUALITY			= "品質";
MI_TXT_CLOTH_DROP      = "布料掉落";
MI_TXT_COIN_DROP       = "平均金錢掉落";
MI_TEXT_ITEM_VALUE     = "平均物品價值";
MI_TXT_MOB_VALUE       = "怪物總價值";
MI_TXT_COMBINED			= "已合併等級：";
MI_TXT_MOB_DB_SIZE		= "MobInfo資料庫大小：";
MI_TXT_HEALTH_DB_SIZE	= "生命值資料庫大小：";
MI_TXT_PLAYER_DB_SIZE	= "玩家生命值資料庫大小：";
MI_TXT_ITEM_DB_SIZE		= "物品資料庫大小：";
MI_TXT_CUR_TARGET		= "目前目標：";
MI_TXT_MH_DISABLED		= "MobInfo 警告：發現 MobHealth 插件. 本插件內建的 MobHealth 功能已停用，請刪除獨立的 MobHealth 插件以啟用本插件的全部功能。";
MI_TXT_MH_DISABLED2		= (MI_TXT_MH_DISABLED.."\n\n 單獨停用MobHealth並不會失去資料。\n\n好處是：血量/魔法位置可調整，並可調整顯示字體和大小");
MI_TXT_CLR_ALL_CONFIRM	= "你確認要執行以下刪除動作嗎？";
MI_TXT_SEARCH_LEVEL		= "怪物等級：";
MI_TXT_SEARCH_MOBTYPE	= "怪物類型：";
MI_TXT_SEARCH_LOOTS		= "怪物已拾取：";
MI_TXT_TRIM_DOWN_CONFIRM = "警告：這是一個直接永久性的資料刪除動作。你真的想刪除沒有被選取到的那些資料嗎。"
MI_TXT_CLAM_MEAT		= "蚌肉"
MI_TXT_SHOWING			= "顯示列表："
MI_TXT_DROPPED_BY		= "掉落："
MI_TXT_LOCATION			= "地點: "
MI_TXT_DEL_SEARCH_CONFIRM = "你是否真的要自資料庫中，刪除搜尋結果中的 %d 筆怪物的資料？"
BINDING_HEADER_MI2HEADER	= "MobInfo 2"
BINDING_NAME_MI2CONFIG	= "開啟MobInfo2選項"

MI2_FRAME_TEXTS = {}
MI2_FRAME_TEXTS["MI2_FrmTooltipOptions"]     = "怪物提示訊息內容"
MI2_FRAME_TEXTS["MI2_FrmHealthOptions"]      = "怪物血量選項"
MI2_FRAME_TEXTS["MI2_FrmDatabaseOptions"]    = "資料庫選項"
MI2_FRAME_TEXTS["MI2_FrmHealthValueOptions"] = "生命值"
MI2_FRAME_TEXTS["MI2_FrmManaValueOptions"]    = "法力值"
MI2_FRAME_TEXTS["MI2_FrmSearchOptions"]		= "搜尋選項"
MI2_FRAME_TEXTS["MI2_FrmSearchLevel"]		= "怪物等級"
MI2_FRAME_TEXTS["MI2_FrmItemTooltip"]		= "物品提示訊息選項"
MI2_FRAME_TEXTS["MI2_FrmImportDatabase"]	= "匯入外部資料"

--
-- This section defines all buttons in the options dialog
--   text : the text displayed on the button
--  help : the (short) one line help text for the button
--   info : additional multi line info text for button
--      info is displayed in the help tooltip below the "help" line
--      info is optional and can be omitted if not required
--

MI2_OPTIONS = {};

MI2_OPTIONS["MI2_OptSearchMinLevel"] = 
	{ text = "最小"; help = "搜尋怪物時的最小等級限制"; }

MI2_OPTIONS["MI2_OptSearchMaxLevel"] = 
	{ text = "最大"; help = "搜尋怪物時的最大等級限制(必須< 66)"; }

MI2_OPTIONS["MI2_OptSearchNormal"] = 
	{ text = "普通"; help = "在搜尋結果中包含普通怪物"; }

MI2_OPTIONS["MI2_OptSearchElite"] = 
	{ text = "精英"; help = "在搜尋結果中包含精英怪物"; }

MI2_OPTIONS["MI2_OptSearchBoss"] = 
	{ text = "首領"; help = "在搜尋結果中包含首領級別的怪物"; }

MI2_OPTIONS["MI2_OptSearchMinLoots"] = 
	{ text = "最小"; help = "搜尋結果中的怪物必須被拾取的最小次數"; }

MI2_OPTIONS["MI2_OptSearchMobName"] = 
	{ text = "怪物名稱"; help = "想要搜尋的怪物部分或者完整名稱";
	info = '留空時不限定查找特定怪物\n輸入"*"搜尋全部怪物'; }  

MI2_OPTIONS["MI2_OptSearchItemName"] = 
	{ text = "物品名稱"; help = "想要搜尋的物品部分或者完整名稱";
	info = '留空時搜尋所有物品名稱'; }	

MI2_OPTIONS["MI2_OptSortByValue"] = 
	{ text = "按數值分類"; help = "分類搜尋結果按怪物值";
	info = '按你能夠造成怪物傷害的值分類查找它們。'; }

MI2_OPTIONS["MI2_OptSortByItem"] = 
	{ text = "按物品數分類"; help = "分類搜尋結果按物品數列表";
	info = '按怪物掉落指定物品的多少分類查找到的怪物。'; }

MI2_OPTIONS["MI2_OptItemTooltip"] = 
	{ text = "在物品提示資訊中顯示掉落怪物"; help = "在物品的提示資訊中顯示掉落它的怪物名稱";
	info = "在提示資訊中顯示可掉落滑鼠所指物品的所有怪物。\n每行顯示該怪物掉落的物品數量及占總數的百分比。" }

MI2_OPTIONS["MI2_OptCompactMode"] = 
	{ text = "緊湊怪物提示資訊"; help = "啟動怪物提示資訊的緊湊模式，每行顯示2個值";
	info = "緊湊提示資訊模式使用簡稱來顯示描述資訊.\n要禁止某行資訊顯示需要同時禁止該行顯示的所有資訊。" }

MI2_OPTIONS["MI2_OptDisableMobInfo"] = 
	{ text = "禁用怪物提示資訊"; help = "禁止在提示資訊顯示怪物資訊";
	info = "禁止所有怪物訊息插件提供的附加提示資訊，包括怪物的提示資訊和物品的提示資訊。" }

MI2_OPTIONS["MI2_OptShowClass"] = 
  { text = "顯示類型"; help = "顯示怪物的類型資訊"; }

MI2_OPTIONS["MI2_OptShowHealth"] = 
  { text = "顯示生命值"; help = "顯示怪物的生命值 (目前/最大)"; }

MI2_OPTIONS["MI2_OptShowMana"] = 
	{ text = "顯示法力值"; help = "顯示怪物的法力/狂暴/精力值(目前/最大)"; }

MI2_OPTIONS["MI2_OptShowXp"] = 
{ text = "EXP"; help = "顯示此怪物可得的經驗值";
info = "這是最後打死此怪物時，給你的實際經驗值。\n(灰色的怪物將不顯示此數值)" }

MI2_OPTIONS["MI2_OptShowNo2lev"] = 
{ text = "升級所需數量"; help = "顯示要殺幾隻此種怪物才能升級";
info = "計算還要殺幾隻同樣的怪物可升級\n(灰色的怪物不顯示此數字)" }

MI2_OPTIONS["MI2_OptShowDamage"] = 
  { text = "顯示傷害/DPS"; help = "顯示怪物的傷害值範圍 (最小/最大)和DPS (每秒傷害值)"; 
    info = "傷害值範圍和DPS是按每個玩家角色\n來單獨計算和存儲的.\nDPS資訊更新較慢但是會隨著每次戰鬥而增加." }

MI2_OPTIONS["MI2_OptShowCombined"] = 
  { text = "顯示合併資訊"; help = "在提示資訊裏面顯示組合資訊";
    info = "在提示資訊裏面顯示一個資訊\n顯示合併模式已啟動並顯示\n不同等級中同一種怪的統計資料." }

MI2_OPTIONS["MI2_OptShowKills"] = 
  { text = "顯示殺死數"; help = "顯示你殺了多少個這樣的怪物";
    info = "怪物殺死計數是按每個玩家角\n色來單獨計算和存儲的." }

MI2_OPTIONS["MI2_OptShowLoots"] = 
  { text = "顯示拾取總數"; help = "顯示怪物被拾取了多少次"; }

MI2_OPTIONS["MI2_OptShowCloth"] = 
  { text = "顯示布料掉率"; help = "顯示怪物的布料掉率"; }

MI2_OPTIONS["MI2_OptShowEmpty"] = 
  { text = "顯示空拾取數"; help = "顯示發現空身屍體的次數(次數/百分比)";
    info = "當你打開一個屍體但是沒有任何\n戰利品的時候這個數目會增加." }

MI2_OPTIONS["MI2_OptShowTotal"] = 
  { text = "顯示怪物總價值"; help = "顯示怪物的平均總價值";
    info = "這個數值等於平均金錢數值+平均物\n品價值之和" }

MI2_OPTIONS["MI2_OptShowCoin"] = 
  { text = "顯示平均掉落金錢"; help = "顯示每個該種怪物平均掉落的金錢數目";
    info = "掉落的金錢總數除以拾取\n次數，如果為0則不顯示" }

MI2_OPTIONS["MI2_OptShowIV"] = 
  { text = "顯示平均物品價值"; help = "顯示每個該種怪物掉落物品的平均價值";
    info = "掉落物品的價值總量除以\n拾取次數，如果為0則不顯示" }

MI2_OPTIONS["MI2_OptShowQuality"] = 
  { text = "顯示戰利品品質"; help = "顯示戰利品品質計數和百分比";
    info = "按品質類別統計顯示殺死怪物獲得的戰\n利品數目.\n沒有掉落過物品的類別將不顯示.\n百分比表示該類物品從該怪物掉落的幾率。" }

MI2_OPTIONS["MI2_OptShowLocation"] = 
{ text = "顯示地點"; help = "顯示在哪裡可以找到此種怪物";
info = "要使本功能能運作，必需開啟記錄地點的選項。"; }

MI2_OPTIONS["MI2_OptShowItems"] = 
	{ text = "顯示拾取物品詳細資訊"; help = "顯示所有拾取物品名稱和數量";
	info = "要使這個選項起作用必須開啟記錄拾取物品資料選項"; }

MI2_OPTIONS["MI2_OptShowClothSkin"] = 
{ text = "布和皮捨取記錄"; help = "顯示布和皮的名稱和數量";
info = "記錄捨取物品的選項必須開啟，此功能才能運作"; }

MI2_OPTIONS["MI2_OptShowBlankLines"] = 
  { text = "顯示空行"; help = "在提示資訊裏面顯示一條空行";
    info = "在提示資訊裏面通過顯示\n空行來分段，以提高可讀性" }

MI2_OPTIONS["MI2_OptCombinedMode"] = 
  { text = "整合相同怪物"; help = "對同樣名字的怪物進行整合";
    info = "整合模式會計算相同名字但不同等級的怪物.\n啟用後將在提示資訊中顯示一個標誌" }

MI2_OPTIONS["MI2_OptKeypressMode"] = 
  { text = "按住ALT顯示怪物資訊"; help = "只有按下ALT才會在提示框顯示怪物資訊"; }

MI2_OPTIONS["MI2_OptItemFilter"] = 
	{ text = "拾取物品過濾"; help = "設置提示資訊裏顯示的拾取物品的過濾條件";
	info = "只在提示資訊中顯示那些包含過濾文本的物品。\n例如輸入'布'將只顯示物品名稱包含'布'的物品。\n不輸入任何文字查看所有物品。" }

MI2_OPTIONS["MI2_OptSavePlayerHp"] = 
  { text = "永久儲存玩家生命值"; help = "永久儲存在PVP戰鬥中獲得的玩家生命值資料。";
    info = "一般情況下PVP戰鬥結束\n後玩家生命值資料將被丟棄，這\n個選項允許你記錄該資料。" }

MI2_OPTIONS["MI2_OptAllOn"] = 
  { text = "顯示全開"; help = "將所有的顯示選項打開"; }

MI2_OPTIONS["MI2_OptAllOff"] = 
  { text = "顯示全關"; help = "將所有的顯示選項關閉"; }

MI2_OPTIONS["MI2_OptMinimal"] = 
  { text = "最少訊息"; help = "顯示最少量但最有用的怪物資訊"; }

MI2_OPTIONS["MI2_OptDefault"] = 
  { text = "預設"; help = "顯示預設的怪物資訊"; }

MI2_OPTIONS["MI2_OptBtnDone"] = 
  { text = "完成"; help = "關閉 MobInfo 選項對話方塊"; }

MI2_OPTIONS["MI2_OptStableMax"] = 
  { text = "顯示穩定的生命最大值"; help = "在目標框顯示穩定的最大生命值";
    info = "此選項開啟以後，在一場\n戰鬥中怪物的估計最大生命值不\n會變化，新估計的數值將在\n下一場戰鬥時顯示出來"; }

MI2_OPTIONS["MI2_OptTargetHealth"] = 
  { text = "顯示生命值"; help = "在目標框顯示生命值"; }

MI2_OPTIONS["MI2_OptTargetMana"] = 
  { text = "顯示法力值"; help = "在目標框顯示法力值"; }

MI2_OPTIONS["MI2_OptHealthPercent"] = 
  { text = "顯示百分比"; help = "在目標框顯示生命值百分比"; }

MI2_OPTIONS["MI2_OptManaPercent"] = 
  { text = "顯示百分比"; help = "在目標框顯示法力值百分比"; }

MI2_OPTIONS["MI2_OptHealthPosX"] = 
  { text = "水平位置"; help = "調整生命值的水平位置"; }

MI2_OPTIONS["MI2_OptHealthPosY"] = 
  { text = "垂直位置"; help = "調整生命值的垂直位置"; }

MI2_OPTIONS["MI2_OptManaPosX"] = 
  { text = "水平位置"; help = "調整法力值的水平位置"; }

MI2_OPTIONS["MI2_OptManaPosY"] = 
  { text = "垂直位置"; help = "調整法力值的垂直位置"; }

MI2_OPTIONS["MI2_OptTargetFont"] = 
	{ text = "字體"; help = "設定生命/法力值的顯示字體";
	  choice1= "數值字體"; choice2="遊戲字體"; choice3="物品資訊字體" }

MI2_OPTIONS["MI2_OptTargetFontSize"] = 
	{ text = "字體大小"; help = "設定生命/法力值的顯示字體大小。"; }

MI2_OPTIONS["MI2_OptClearTarget"] = 
  { text = "清除目前目標資料"; help = "清除目前目標的資料。"; }

MI2_OPTIONS["MI2_OptClearMobDb"] = 
	{ text = "清除怪物資料"; help = "清除全部怪物資訊資料。"; }

MI2_OPTIONS["MI2_OptClearHealthDb"] = 
	{ text = "清除生命值資料"; help = "清除全部怪物生命值資料。"; }

MI2_OPTIONS["MI2_OptClearPlayerDb"] = 
	{ text = "清除玩家資料"; help = "清除全部玩家生命值資料。"; }

MI2_OPTIONS["MI2_OptSaveItems"] = 
	{ text = "記錄以下品質的掉落物品資料:"; help = "開啟後記錄所有MobInfo2所能記的怪物相關資料。";
	info = "你可以選擇想記錄的物品的品質等級。"; }

MI2_OPTIONS["MI2_OptSaveBasicInfo"] = 
	{ text = "記錄基本怪物資訊"; help = "記錄基本怪物的相關資訊。";
	info = "基本怪物資訊包括：經驗值、怪物類型、計算：拾取、空拾取、布、金錢、物品的價值"; }

MI2_OPTIONS["MI2_OptSaveCharData"] = 
	{ text = "記錄角色相關的怪物資料"; help = "開啟後記錄所有和玩家角色有關的怪物資訊。";
	info = "開啟或關閉保存以下資料：\n擊殺次數、最大／最小傷害、DPS (每秒傷害值)\n\n這些資料將依玩家角色分開儲存。\n這幾個資料只能同時設定為『儲存』或『不儲存』。"; }

MI2_OPTIONS["MI2_OptSaveLocation"] = 
{ text = "記錄地點資料"; help = "記錄在哪些區域地點和座標可以找到怪物。" }

MI2_OPTIONS["MI2_OptItemsQuality"] = 
	{ text = ""; cmnd = "itemsquality";  help = "記錄指定品質(含)更好的物品詳細資訊。";
	  choice1 = "灰色以及更好"; choice2="白色以及更好"; choice3="綠色以及更好" }

MI2_OPTIONS["MI2_OptTrimDownMobData"] = 
	{ text = "最佳化怪物資料庫大小"; help = "移除過剩的資料最佳化怪物資料庫大小。";
	  info = "過剩的資料是指資料庫裡未被設定為需要記錄的全部資料。"; }

MI2_OPTIONS["MI2_OptImportMobData"] = 
{ text = "開始匯入"; help = "匯入外部資料到你自己的怪物資料庫";
info = "注意：請仔細詳讀匯入步驟的指示！\n一定要在匯入前，先備份自己的資料庫，以免造成資料永久遺失！"; }

MI2_OPTIONS["MI2_OptDeleteSearch"] = 
{ text = "刪除"; help = "自資料庫中，刪除所有在搜尋結果中的怪物資料。";
info = "警告：本步驟是沒辦法復原的，\n使用前請小心！\n建議在刪除這些資料前，先備份自己的資料庫。"; }

MI2_OPTIONS["MI2_OptImportOnlyNew"] = 
{ text = "只匯入目前還未知的怪物資料"; help = "匯入目前在你的資料庫中，還沒有記錄的資料";
info = "開啟這個選項可以預防現在已存在的資料被修改覆蓋掉，\n只有目前未知(新的)資料會匯入資料庫。\n如此可以確保原資料的一致性。"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab1"] = 
	{ text = "提示資訊選項"; help = "設置在提示資訊裏面顯示的怪物資訊選項"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab2"] = 
	{ text = "生命/法力值"; help = "設置目標框中顯示 生命/法力值 的選項"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab3"] = 
	{ text = "資料庫"; help = "資料庫管理選項"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab4"] = 
	{ text = "搜尋"; help = "搜尋資料庫"; }

MI2_OPTIONS["MI2_SearchResultFrameTab1"] = 
	{ text = "怪物列表"; help = ""; }

MI2_OPTIONS["MI2_SearchResultFrameTab2"] = 
	{ text = "物品列表"; help = ""; }


end;


