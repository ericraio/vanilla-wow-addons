--[[
	WARNING! If you edit this file you need a good editor, not notepad.
	This file HAS to be saved in UTF-8 format (without signature) else we would have to escape
	all special chars

	Credits for zhTW translation: apa1102
	Thanks a LOT!
]]--

if (GetLocale() == "zhTW") then
-- 1.4.2 Found a chineese localization through google that needs a different pre filter so i added this
-- and added a localization for it 
SW_PRE_REGEX = "%d+";

-- There seems to be 2 different versions, one with and one without FixLogStrings
-- set this to false to skip string changes
SW_ZH_FIXSTRINGS = true;

-- the main slash commands registered (only 2)
SW_RootSlashes = {"/swstats", "/sws"};

SW_CONSOLE_NOCMD = "沒有此命令：";
SW_CONSOLE_HELP ="說明：";
SW_CONSOLE_NIL_TRAILER = "未定義"; -- space at beginning
SW_CONSOLE_SORTED = "分類";
SW_CONSOLE_NOREGEX = "此事件無匹配表達式";
SW_CONSOLE_FALLBACK = "發現匹配表達式 - 加入列表中";
SW_FALLBACK_BLOCK_INFO = "自動更新拒絕了此事件";
SW_FALLBACK_IGRNORED = "此事件已被忽略";
SW_EMPTY_EVENT = "監聽不需要的事件？：";
SW_INFO_PLAYER_NF = "沒有任何訊息：";
SW_PRINT_INFO_FROMTO = "|cffffffff來自：|r%s，|cffffffff目標：|r%s，";
SW_PRINT_ITEM = "|cffffffff%s：|r%s，";
SW_PRINT_ITEM_DMG = "傷害";
SW_PRINT_ITEM_HEAL = "治療";
SW_PRINT_ITEM_THROUGH = "透過";
SW_PRINT_ITEM_TYPE = "類型";
SW_PRINT_ITEM_CRIT = "|cffff2020致命一擊|r";
SW_PRINT_ITEM_WORLD = "世界";
SW_PRINT_ITEM_NORMAL = "一般";
SW_PRINT_ITEM_RECIEVED = "受到";
SW_PRINT_INFO_RECIEVED = "|cffff2020傷害：%s|r，|cff20ff20治療：%s|r";
SW_PRINT_ITEM_TOTAL_DONE = "全部";
SW_PRINT_ITEM_NON_SCHOOL = "其他";
SW_PRINT_ITEM_IGNORED = "忽略";
SW_PRINT_ITEM_DEATHS = "死亡";

SW_SYNC_CHAN_JOIN = "|cff20ff20SW同步：你已經加入：|r";
SW_SYNC_CHAN_FAIL= "|cffff2020SW同步：無法加入：|r";
SW_SYNC_JOINCHECK_FROM = "加入SW同步頻道 %s 從：%s？"
SW_SYNC_JOINCHECK_INFO = "原有數據將全部清除！"
SW_SYNC_CURRENT = "目前同步頻道：%s";
SW_BARS_WIDTHERROR = "狀態條過寬！"
SW_B_CONSOLE = "C";
SW_B_SETTINGS = "S";
SW_B_SYNC = "Y";
SW_B_REPORT = "R";
SW_STR_MAX = "Max";
SW_STR_EVENTCOUNT = "#";
SW_STR_AVERAGE = "ø";
SW_STR_PET_PREFIX = "[寵物] "; -- pet prefix for pet info displayed in the bars
SW_STR_VPP_PREFIX = "[所有寵物] "; -- pet prefix for virtual pet per player info displayed in the bars
SW_STR_VPR = "[團隊寵物]"; -- pet string for virtual pet per raid info displayed in the bars
-- 1.5.beta.1 Reset vote
SW_STR_RV = "|cffff5d5d重置投票！|r由|cffff5d5d%s|r提出。你想要重置同步頻道嗎？";
SW_STR_RV_PASSED = "|cffffff00[SW同步]|r |cff00ff00重置投票通過！|r";
SW_STR_RV_FAILED = "|cffffff00[SW同步]|r |cffff5d5d重置投票駁回！|r";
SW_STR_VOTE_WARN = "|cffffff00[SW同步]|r |cffff5d5d不要反覆提出投票...|r";

--[[
   you can ONLY localize the values! NOT the keys
   don't change aynthing like this ["someString"]
--]]
SW_Spellnames = {
	[1] = "解除次級詛咒",
	[2] = "解除詛咒",
	[3] = "驅散魔法",
	[4] = "祛病術",
	[5] = "驅除疾病",
	[6] = "純凈術",
	[7] = "清潔術",
	[8] = "消毒術",
	[9] = "驅毒術",
	[10] = "凈化術",
}

SW_LocalizedGUI ={
	["SW_FrameConsole_Title"] = "SW v"..SW_VERSION,
	["SW_FrameConsole_Tab1"] = "一般",
	["SW_FrameConsole_Tab2"] = "事件訊息",
	--["SW_FrameConsole_Tab3"] = "設定",
	["SW_BarSettingsFrameV2_Tab1"] = "數據",
	["SW_BarSettingsFrameV2_Tab2"] = "外觀設定",
	["SW_BarSettingsFrameV2_Tab3"] = "寵物",
	["SW_Chk_ShowEventText"] = "顯示事件→匹配",
	["SW_Chk_ShowOrigStrText"] = "顯示日誌訊息",
	["SW_Chk_ShowRegExText"] = "顯示匹配表達式",
	["SW_Chk_ShowMatchText"] = "顯示匹配",
	["SW_Chk_ShowSyncInfoText"] = "顯示同步訊息",
	["SW_Chk_ShowOnlyFriendsText"] = "只顯示友善角色",
	["SW_Chk_ShowSyncBText"] = "顯示同步按鈕",
	["SW_Chk_ShowConsoleBText"] = "顯示控制臺按鈕",
	["SW_Chk_ShowDPSText"] = "顯示DPS";
	["SW_Chk_MergePetsText"] = "合併寵物數據到主人",
	["SW_RepTo_SayText"] = "說",
	["SW_RepTo_GroupText"] = "隊伍",
	["SW_RepTo_RaidText"] = "團隊",
	["SW_RepTo_GuildText"] = "公會",
	["SW_RepTo_ChannelText"] = "頻道",
	["SW_RepTo_WhisperText"] = "悄悄話",
	["SW_RepTo_ClipboardText"] = "剪貼簿",
	["SW_RepTo_OfficerText"] = "幹部",
	["SW_BarReportFrame_Title_Text"] = "報告給..",
	["SW_Chk_RepMultiText"] = "分行顯示",
	["SW_Filter_PCText"] = "PC",
	["SW_Filter_NPCText"] = "NPC",
	["SW_Filter_GroupText"] = "目前隊伍/團隊成員",
	["SW_Filter_EverGroupText"] = "曾在隊伍/團隊成員",
	["SW_Filter_NoneText"] = "無",
	["SW_GeneralSettings_Title_Text"] = "一般設定",
	["SW_BarSyncFrame_Title_Text"] = "同步頻道設定",
	["SW_BarSettingsFrameV2_Title_Text"] = "設定",
	["SW_BarSyncFrame_SyncLeave"] = "離開",
	["SW_BarSyncFrame_OptGroupText"] = "隊伍",
	["SW_BarSyncFrame_OptRaidText"] = "團隊",
	["SW_BarSyncFrame_OptGuildText"] = "公會",
	["SW_BarSyncFrame_SyncSend"] = "傳送給",
	["SW_CS_Damage"] = "傷害顏色",
	["SW_CS_Heal"] = "治療顏色",
	["SW_CS_BarC"] = "狀態條顏色",
	["SW_CS_FontC"] = "文字顏色",
	["SW_CS_OptC"] = "按鈕顏色",
	["SW_TextureSlider"] = "材質：",
	["SW_FontSizeSlider"] = "文字大小：",
	["SW_BarHeightSlider"] = "高：",
	--["SW_BarWidthSlider"] = "狀態條寬：",
	["SW_ColCountSlider"] = "顯示列數：",
	["SW_OptChk_NumText"] = "數值",
	["SW_OptChk_RankText"] = "排名",
	["SW_OptChk_PercentText"] = "百分比",
	["SW_VarInfoLbl"] = "此訊息需要一個目標。點擊改變來輸入一個名字或點擊從目標來設定你目前目標。",
	["SW_NoPetInfoLabel"] = "此訊息不包含任何寵物過濾設定。",
	["SW_SetInfoVarFromTarget"] = "從目標",
	["SW_ColorsOptUseClassText"] = "職業顏色",
	["SW_TextWindow_Title_Text"] = "使用Ctrl+c來複製。",
	["SW_BarSyncFrame_SyncARPY"] = "允許",
	["SW_BarSyncFrame_SyncARPN"] = "禁止",
	-- 1.5 new pet filter labels 
	["SW_PF_InactiveText"] = "不運作",
	["SW_PF_ActiveText"] = "運作",
	["SW_PF_MMText"] = "合併造成量",
	["SW_PF_MRText"] = "合併受到量",
	["SW_PF_MBText"] = "合併兩者",
	["SW_PF_CurrentText"] = "目前",
	["SW_PF_VPPText"] = "顯示玩家寵物",
	["SW_PF_VPRText"] = "顯示團隊寵物",
	["SW_PF_IgnoreText"] = "忽略所有寵物訊息",
};

SW_GS_Tooltips["SW_Chk_ShowOnlyFriends"] = "此選項只被用來過濾報告至控制臺的/sws快捷命令。";
SW_GS_Tooltips["SW_Chk_ShowSyncB"] = "開啟後在主視窗的標題欄額外顯示一個同步按鈕。";
SW_GS_Tooltips["SW_Chk_ShowConsoleB"] = "開啟後在主視窗的標題欄額外顯示一個控制臺按鈕。";
SW_GS_Tooltips["SW_CS_Damage"] = "傷害條顏色。例如：當查看細節時使用。";
SW_GS_Tooltips["SW_CS_Heal"] = "治療條顏色。例如：當查看細節時使用。";
SW_GS_Tooltips["SW_CS_BarC"] = "狀態條顏色。可能會被顯示數據設定的顏色所取代。";
SW_GS_Tooltips["SW_CS_FontC"] = "文字顏色。";
SW_GS_Tooltips["SW_CS_OptC"] = "改變主視窗下按鈕顏色。";
SW_GS_Tooltips["SW_TextureSlider"] = "改變狀態條材質。"; 
SW_GS_Tooltips["SW_FontSizeSlider"] = "改變狀態條文字大小。";
SW_GS_Tooltips["SW_BarHeightSlider"] = "改變狀態條高度。";
--SW_GS_Tooltips["SW_BarWidthSlider"] = "改變狀態條寬度。";
SW_GS_Tooltips["SW_ColCountSlider"] = "改變主視窗顯示數據的列數。";
SW_GS_Tooltips["SW_SetOptTxtFrame"] = "改變主視窗下按鈕的文字顯示。";
SW_GS_Tooltips["SW_SetFrameTxtFrame"] = "改變主視窗標題文字。";
SW_GS_Tooltips["SW_OptChk_Num"] = "顯示數值(例如：傷害、治療等等)。";
SW_GS_Tooltips["SW_OptChk_Rank"] = "顯示排名。";
SW_GS_Tooltips["SW_OptChk_Percent"] = "顯示百分比(在團隊總量中的百分比)。";
SW_GS_Tooltips["SW_Filter_None"] = "不使用PC/NPC/隊伍過濾，所有被取得的數據都顯示出來。";
SW_GS_Tooltips["SW_Filter_PC"] = "已使用玩家角色過濾。只顯示在你隊伍中或曾點擊過的目標玩家數據。";
SW_GS_Tooltips["SW_Filter_NPC"] = "已使用非玩家角色過濾，你必需點擊此目標一次且此目標非玩家控制。";
SW_GS_Tooltips["SW_Filter_Group"] = "只顯示你隊伍或團隊中的玩家及寵物數據。";
SW_GS_Tooltips["SW_Filter_EverGroup"] = "只顯示曾經在你隊伍或團隊中的玩家及寵物數據。";
SW_GS_Tooltips["SW_ClassFilterSlider"] = "職業過濾，只顯示特定職業。(你必需點擊過此目標或他們在你的隊伍/團隊中。)";
SW_GS_Tooltips["SW_InfoTypeSlider"] = "主要數據選擇。選擇哪種數據你想要在此標籤頁面看到。(同步)表示該數據是否可以被同步。";
SW_GS_Tooltips["SW_ColorsOptUseClass"] = "使用職業顏色。使用顏色區分玩家職業。(已知玩家及怪物的職業將取代狀態條的顏色)";
SW_GS_Tooltips["SW_Chk_ShowDPS"] = "是否顯示DPS在主視窗的標題上？";
SW_GS_Tooltips["SW_OptCountSlider"] = "改變主視窗下按鈕的數量。";
SW_GS_Tooltips["SW_AllowARP"] = "允許將報告傳送至團隊。";
SW_GS_Tooltips["SW_DisAllowARP"] = "禁止將報告傳送至團隊。";
SW_GS_Tooltips["SW_OptChk_Running"] = "取消來暫停蒐集數據。你無法在同步頻道中暫停蒐集數據。";
-- 1.5 new pet filter Tooltips
SW_GS_Tooltips["SW_PF_Inactive"] = "新的寵物過濾大部份不運作，寵物將如一般顯示。";
SW_GS_Tooltips["SW_PF_Active"] = "顯示寵物被標記為"..SW_STR_PET_PREFIX.."和被精神控制/奴役的寵物或玩家。只有寵物存在時統計。(只顯示在你隊伍/團隊中玩家控制的怪物，而被怪物控制的玩家將不顯示。)";
SW_GS_Tooltips["SW_PF_MM"] = "隱藏寵物造成的傷害/治療並合併到其擁有者數據。";
SW_GS_Tooltips["SW_PF_MR"] = "隱藏寵物受到的傷害/治療並合併到其擁有者數據。";
SW_GS_Tooltips["SW_PF_MB"] = "隱藏寵物造成及受到的傷害/治療並合併到其擁有者數據。";
SW_GS_Tooltips["SW_PF_Current"] = "類似於運作，但只顯示目前擁有的寵物。";
SW_GS_Tooltips["SW_PF_VPP"] = "同玩家的所有寵物合併至一個寵物。";
SW_GS_Tooltips["SW_PF_VPR"] = "所有隊伍/團隊的寵物合併至一個寵物。";
SW_GS_Tooltips["SW_PF_Ignore"] = "忽略所有寵物訊息。";

-- edit boxes
SW_GS_EditBoxes["SW_SetOptTxtFrame"] = {"更改","按鈕文字：", "新按鈕文字：" };
SW_GS_EditBoxes["SW_SetFrameTxtFrame"] = {"更改","標題文字：", "新標題文字：" };
SW_GS_EditBoxes["SW_SetInfoVarTxtFrame"] = {"更改","訊息來源：", "新玩家或怪物名稱：" };
SW_GS_EditBoxes["SW_SetSyncChanTxtFrame"] = {"更改","同步頻道：", "新同步頻道：" };

--Popups
StaticPopupDialogs["SW_Reset"]["text"] = "你確定要重置數據嗎？";
StaticPopupDialogs["SW_ResetSync"]["text"] = "你正在一個同步頻道，將使用重置所有玩家的命令！你確定要重置所有數據嗎？";
StaticPopupDialogs["SW_JoinCheck"]["text"] = "加入檢查";
StaticPopupDialogs["SW_ResetFailInfo"]["text"] = "你正在一個同步頻道，無法重置數據，只有隊長/助理才有權利重置！你可以用'"..SW_RootSlashes[1].." rv'來提出投票。";
StaticPopupDialogs["SW_PostFail"]["text"] = "抱歉，你不能報告到這個頻道。需要隊長允許你才可以報告數據到此頻道！";
StaticPopupDialogs["SW_InvalidChan"]["text"] = "抱歉，這是一個無效的頻道名稱！";

--icon menu
SW_MiniIconMenu[2]["textShow"] = "顯示主視窗";
SW_MiniIconMenu[2]["textHide"] = "隱藏主視窗";
SW_MiniIconMenu[3]["textShow"] = "顯示控制臺";
SW_MiniIconMenu[3]["textHide"] = "隱藏控制臺";
SW_MiniIconMenu[4]["textShow"] = "顯示一般設定";
SW_MiniIconMenu[4]["textHide"] = "隱藏一般設定";
SW_MiniIconMenu[5]["textShow"] = "顯示同步設定";
SW_MiniIconMenu[5]["textHide"] = "隱藏同步設定";
SW_MiniIconMenu[7]["text"] = "重置數據";
SW_MiniIconMenu[9]["text"] = "更新隊伍訊息";

-- key bindig strings
BINDING_HEADER_SW_BINDINGS = "SW Stats";
BINDING_NAME_SW_BIND_TOGGLEBARS = "顯示/隱藏主視窗";
BINDING_NAME_SW_BIND_CONSOLE = "顯示/隱藏控制臺";
BINDING_NAME_SW_BIND_PAGE1 = "顯示訊息標籤1";
BINDING_NAME_SW_BIND_PAGE2 = "顯示訊息標籤2";
BINDING_NAME_SW_BIND_PAGE3 = "顯示訊息標籤3";
BINDING_NAME_SW_BIND_PAGE4 = "顯示訊息標籤4";
BINDING_NAME_SW_BIND_PAGE5 = "顯示訊息標籤5";
BINDING_NAME_SW_BIND_PAGE6 = "顯示訊息標籤6";
BINDING_NAME_SW_BIND_PAGE7 = "顯示訊息標籤7";
BINDING_NAME_SW_BIND_PAGE8 = "顯示訊息標籤8";
BINDING_NAME_SW_BIND_PAGE9 = "顯示訊息標籤9";
BINDING_NAME_SW_BIND_PAGE10 = "顯示訊息標籤10";

--info types
SW_InfoTypes[1]["t"] = "傷害量(同步)";
SW_InfoTypes[1]["d"] = "顯示一個簡單的傷害量列表。";
SW_InfoTypes[2]["t"] = "治療量(同步)";
SW_InfoTypes[2]["d"] = "顯示一個簡單的治療量列表。(包含過量治療)";
SW_InfoTypes[3]["t"] = "受到傷害量(同步)";
SW_InfoTypes[3]["d"] = "顯示受到的傷害量列表。(誰受到最大的傷害量？)";
SW_InfoTypes[4]["t"] = "受到治療量(同步)";
SW_InfoTypes[4]["d"] = "顯示受到治療的目標。(誰獲得最多的治療量？)";
SW_InfoTypes[5]["t"] = "治療分析(同步)";
SW_InfoTypes[5]["d"] = "顯示詳細治療訊息。(誰受到了這個人的治療？)";
SW_InfoTypes[6]["t"] = "治療訊息(同步)";
SW_InfoTypes[6]["d"] = "顯示目標的詳細治療訊息。(這個人治療了誰？)";
SW_InfoTypes[7]["t"] = "技能詳情(非同步)";
SW_InfoTypes[7]["d"] = "顯示目標的詳細技能訊息。(這個人使用了什麼技能？)。名字旁的()裡面的數字指出此技能產生的最大傷害/治療。";
SW_InfoTypes[8]["t"] = "平均效能(非同步)";
SW_InfoTypes[8]["d"] = "顯示目標的技能平均訊息。(這個人的寒冰箭造成的平均傷害是多少？)。名字旁的數字指出使用次數。注意：當施放一個高傷害帶有低傷害DOT技能時可能有小數點。";
SW_InfoTypes[9]["t"] = "傷害類型(非同步)";
SW_InfoTypes[9]["d"] = "顯示目標的技能系別訊息。(這個人主要傷害部份是什麼系的？例如：火焰、冰霜等等)";
SW_InfoTypes[10]["t"] = "受到傷害類型(非同步)";
SW_InfoTypes[10]["d"] = "顯示目標受到的傷害系別訊息。(這個人主要受到哪種系別的傷害？例如：火焰、冰霜等等)";
SW_InfoTypes[11]["t"] = "傷害量摘要(非同步)";
SW_InfoTypes[11]["d"] = "顯示職業傷害量訊息。(這個團隊中的某職業主要傷害量來自哪個系？例如：火焰、冰霜等等)。注意：確認使用職業過濾。";
SW_InfoTypes[12]["t"] = "受到傷害量摘要(非同步)";
SW_InfoTypes[12]["d"] = "顯示職業受到傷害量訊息。(這個團隊中的某職業主要受到傷害量來自哪個系？例如：火焰、冰霜等等)。注意：確認使用職業過濾。";
SW_InfoTypes[13]["t"] = "過量治療量(同步)";
SW_InfoTypes[13]["d"] = "顯示過量治療訊息。名字旁邊的百分比為過量治療的百分比，如果你同時用了'百分比'選項，則此百分比表示在團隊總過量治療量中的百分比。";
SW_InfoTypes[14]["t"] = "有效治療量(同步)";
SW_InfoTypes[14]["d"] = "顯示治療量列表。過量治療量部份被'扣除'給你一個'真實'治療量列表。";
SW_InfoTypes[15]["t"] = "法力效率";
SW_InfoTypes[15]["d"] = "顯示每點法力產生的傷害/治療量。越高的數字表示越高的法力效率。(此功能只對你自己有效)";
SW_InfoTypes[16]["t"] = "治療量法力效率(同步)";
SW_InfoTypes[16]["d"] = "比較其他人治療量的法力效率。一個為2的比率表示：1點法力治療了2點生命力(數字越高越好)";
SW_InfoTypes[17]["t"] = "死亡計數(同步)";
SW_InfoTypes[17]["d"] = "某人或某怪物多常死掉？不只是你殺死的而已，這計算所有死亡！";
SW_InfoTypes[18]["t"] = "傷害量法力效率(同步)";
SW_InfoTypes[18]["d"] = "比較其他人傷害量的法力效率。一個為2的比率表示：1點法力治療了2點生命力(數字越高越好)";
SW_InfoTypes[19]["t"] = "解咒計數(同步 v1.5.1+)";
SW_InfoTypes[19]["d"] = "某人多常'解咒'？："..SW_GetSpellList();
SW_InfoTypes[20]["t"] = "能量獲得(非同步)";
SW_InfoTypes[20]["d"] = "這是實驗性的，他只計算能量獲得的 # 及非傷害/治療事件(不確定這是否顯示無法治療或做傷害的過程)";

SW_LocalizedCommands = {
	["help"] = {	["c"] = "?",
				["si"] = "顯示控制臺說明。",
	},
	["console"] = {["c"] = "con",
				["si"] = "開啟控制臺。",
	},
	["dumpVar"] = {["c"] = "dump",
				["si"] = "清除變量。",
				["u"] = "用法："..SW_RootSlashes[1].." dump 變量名",
	},
	["reset"] = {	["c"] = "reset",
				["si"] = "清空數據。",
	},
	["toggleBars"]={["c"] = "bars",
				["si"] = "顯示或隱藏主視窗。",
					
	},
	["toggleGS"] = {["c"] = "gs",
				["si"] = "顯示或隱藏一般設定視窗。",
	},
	["skillUsage"] ={["c"] = "su",
				["si"] = "控制臺中顯示同步頻道裡每個人的技能。技能名稱必需完全與遊戲中相同。",
				["u"] = "用法："..SW_RootSlashes[1].." su 技能名稱",
	},
	["versionCheck"] ={["c"] = "vc",
				["si"] = "檢查同步頻道裡玩家的SW版本。",
	},
	["syncKick"] ={["c"] = "kick",
				["si"] = "從同步頻道中踢除一個玩家。",
				["u"] = "用法："..SW_RootSlashes[1].." 踢除玩家的名字",
	},
	["resetVote"] ={["c"] = "rv",
				["si"] = "開始重置同步投票。",
	},
};

function SW_FixLogStrings(str)
	-- almost all strings don't have spaces before and after %d, but we need those
	-- %s,%d 前後加空格，避免玩家命名為 X的X；X對X；X擊中X 等名字 
	-- thanks for these, I'm just assuming they work for this locale :) 
	if SW_ZH_FIXSTRINGS then
		str = string.gsub(str, "(%%%d?$?s)([^%s+].)", "%1 %2");
		str = string.gsub(str, "(.[^%s+])(%%%d?$?s)", "%1 %2");
		str = string.gsub(str, "(.[^%s+])(%%%d?$?d)", "%1 %2");
		return string.gsub(str, "(%%%d?$?d)([^%s+].)", "%1 %2");
	else
		return str;
	end
end
-- this MUST go at the end of a localization
-- Again if you create a localization put SW_mergeLocalization(); at the end!!!
SW_mergeLocalization();
end