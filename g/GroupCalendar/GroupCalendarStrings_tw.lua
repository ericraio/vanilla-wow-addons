-- File containing localized strings
-- Translation : zhTW - Aska (20051222)

if GetLocale() == "zhTW" then
	-- Chinese Traditional localized variables

	GroupCalendar_cTitle = "團體行事曆 v%s";

	GroupCalendar_cSun = "日";
	GroupCalendar_cMon = "一";
	GroupCalendar_cTue = "二";
	GroupCalendar_cWed = "三";
	GroupCalendar_cThu = "四";
	GroupCalendar_cFri = "五";
	GroupCalendar_cSat = "六";

	GroupCalendar_cSunday = "星期日";
	GroupCalendar_cMonday = "星期一";
	GroupCalendar_cTuesday = "星期二";
	GroupCalendar_cWednesday = "星期三";
	GroupCalendar_cThursday = "星期四";
	GroupCalendar_cFriday = "星期五";
	GroupCalendar_cSaturday = "星期六";

	GroupCalendar_cSelfWillAttend = "%s會出席";

	GroupCalendar_cMonthNames = {"1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"};
	GroupCalendar_cDayOfWeekNames = {GroupCalendar_cSunday, GroupCalendar_cMonday, GroupCalendar_cTuesday, GroupCalendar_cWednesday, GroupCalendar_cThursday, GroupCalendar_cFriday, GroupCalendar_cSaturday};

	GroupCalendar_cLoadMessage = "團體行事曆已載入。使用 /calendar 來瀏覽行事曆";
	GroupCalendar_cInitializingGuilded = "團體行事曆: 替已有公會的玩家進行初始化設定";
	GroupCalendar_cInitializingUnguilded = "團體行事曆: 指沒有公會的玩家進行初始化設定";
	GroupCalendar_cLocalTimeNote = "(%s 本地)";

	GroupCalendar_cOptions = "設定...";

	GroupCalendar_cCalendar = "行事曆";
	GroupCalendar_cChannel = "頻道";
	GroupCalendar_cTrust = "信任";
	GroupCalendar_cAbout = "關於";

	GroupCalendar_cUseServerDateTime = "使用伺服器日期與時間";
	GroupCalendar_cUseServerDateTimeDescription = "啟動此功能將會以伺服器的日期與時間來顯示活動資訊，若關閉此功能則會以您的電腦日期及時間來顯示。";

	GroupCalendar_cChannelConfigTitle = "資料頻道設定";
	GroupCalendar_cChannelConfigDescription = "行事曆頻道用來傳送及接收玩家之間的活動，所有在頻道的人都能瀏灠您的活動。若想替您的行事曆保密就必須設定密碼。";
	GroupCalendar_cAutoChannelConfig = "自動頻道設定";
	GroupCalendar_cManualChannelConfig = "手動頻道設定";
	GroupCalendar_cStoreAutoConfig = "自動儲存設定到玩家訊息";
	GroupCalendar_cAutoConfigPlayer = "玩家名稱:";
	GroupCalendar_cApplyChannelChanges = "套用";
	GroupCalendar_cAutoConfigTipTitle = "自動頻道設定";
	GroupCalendar_cAutoConfigTipDescription = "自動從公會資訊中取得頻道資訊。您必須是公會成員，此功能必須在公會幹部設定後方可使用。";
	GroupCalendar_cManualConfigTipDescription = "允許您手動輸入頻道及密碼資料。";
	GroupCalendar_cStoreAutoConfigTipDescription = "允許公會幹部將頻道設置資訊存到指定成員的玩家資訊中。";
	GroupCalendar_cAutoConfigPlayerTipDescription = "玩家在公會資訊中包含頻道設置資料。";
	GroupCalendar_cChannelNameTipTitle = "頻道名稱";
	GroupCalendar_cChannelNameTipDescription = "頻道名稱用來傳送及接收其他玩家的活動資料。";
	GroupCalendar_cConnectChannel = "連線";
	GroupCalendar_cDisconnectChannel = "中斷連線";
	GroupCalendar_cChannelStatus =
	{
		Starting = {mText = "狀態: 啟動中...", mColor = {r = 1, g = 1, b = 0.3}},
		Connected = {mText = "狀態: 資料頻道已連接", mColor = {r = 0.3, g = 1, b = 0.3}},
		Disconnected = {mText = "狀態: 資料頻道尚未連接", mColor = {r = 1, g = 0.5, b = 0.2}},
		Initializing = {mText = "狀態: 初始化資料頻道", mColor = {r = 1, g = 1, b = 0.3}},
		Error = {mText = "錯誤: %s", mColor = {r = 1, g = 0.2, b = 0.4}},
	};

	GroupCalendar_cConnected = "已連線";
	GroupCalendar_cDisconnected = "已中斷連線";
	GroupCalendar_cTooManyChannels = "您已經到達頻道的加入上限";
	GroupCalendar_cJoinChannelFailed = "不明原因引致無法加入頻道";
	GroupCalendar_cWrongPassword = "密碼錯誤";
	GroupCalendar_cAutoConfigNotFound = "找不到公會設置資料";
	GroupCalendar_cErrorAccessingNote = "無法接收設置資料";

	GroupCalendar_cTrustConfigTitle = "信任設定";
	GroupCalendar_cTrustConfigDescription = "允許您控制能夠檢視活動的人。行事曆本身並無限制誰能夠檢視活動，設定密碼就能有效限制能夠檢視行事曆的人。";
	GroupCalendar_cTrustGroupLabel = "信任:";
	GroupCalendar_cEvent = "活動";
	GroupCalendar_cAttendance = "出席";

	GroupCalendar_cAboutTitle = "關於團體行事曆";
	GroupCalendar_cTitleVersion = "團體行事曆 v"..gGroupCalendar_VersionString;
	GroupCalendar_cAuthor = "由 Thunderlord 的 Baylord 設計及編寫";
	GroupCalendar_cTestersTitle = "測試人員";

	GroupCalendar_cSpecialThanksTitle = "特別鳴謝";

	GroupCalendar_cGuildURL = "http://www.royaltia.com";
	GroupCalendar_cRebuildDatabase = "重新建立資料庫";
	GroupCalendar_cRebuildDatabaseDescription = "重新建立活動資料庫給您的角色。有助解決無法觀看所有活動的問題，但是此舉動可能有機會會遺失出席回覆的資訊。";

	GroupCalendar_cTrustGroups =
	{
		"所有存取資料頻道的玩家",
		"公會成員",
		"僅限下列名單列出的玩家"
	};

	GroupCalendar_cTrustAnyone = "信任所有存取資料頻道的玩家";
	GroupCalendar_cTrustGuildies = "信任我的公會成員";
	GroupCalendar_cTrustMinRank = "最低階級需求:";
	GroupCalendar_cTrustNobody = "只信任下列名單中列出的玩家";
	GroupCalendar_cTrustedPlayers = "信任的玩家";
	GroupCalendar_cExcludedPlayers = "例外的玩家"
	GroupCalendar_cPlayerName = "玩家名稱:";
	GroupCalendar_cAddTrusted = "信任";
	GroupCalendar_cRemoveTrusted = "移除";
	GroupCalendar_cAddExcluded = "例外";

	CalendarEventViewer_cTitle = "檢示活動";
	CalendarEventViewer_cDone = "完成";

	CalendarEventViewer_cLevelRangeFormat = "等級 %i 至 %i";
	CalendarEventViewer_cMinLevelFormat = "等級 %i 或以上";
	CalendarEventViewer_cMaxLevelFormat = "等級 %i 或以下";
	CalendarEventViewer_cAllLevels = "所有等級";
	CalendarEventViewer_cSingleLevel = "只限等級 %i";

	CalendarEventViewer_cYes = "嗯! 我會出席此活動";
	CalendarEventViewer_cNo = "不. 我不會出席此活動";

	CalendarEventViewer_cResponseMessage =
	{
		"狀態: 沒有回應",
		"狀態: 等候確認",
		"狀態: 已確認 - 已接受",
		"狀態: 已確認 - 等候中",
		"狀態: 已確認 - 被拒絕",
	};

	CalendarEventEditorFrame_cTitle = "新增/修改活動";
	CalendarEventEditor_cDone = "完成";
	CalendarEventEditor_cDelete = "刪除";

	CalendarEventEditor_cConfirmDeleteMsg = "刪除 \"%s\"?";

	-- Event names

	GroupCalendar_cGeneralEventGroup = "綜合";
	GroupCalendar_cDungeonEventGroup = "地下城";
	GroupCalendar_cBattlegroundEventGroup = "戰場";

	GroupCalendar_cMeetingEventName = "約會";
	GroupCalendar_cBirthdayEventName = "生日";

	GroupCalendar_cAQREventName = "安其拉 (廢墟)";
	GroupCalendar_cAQTEventName = "安其拉 (神殿)";
	GroupCalendar_cBFDEventName = "黑暗深淵";
	GroupCalendar_cBRDEventName = "黑石深淵";
	GroupCalendar_cUBRSEventName = "黑石塔上層";
	GroupCalendar_cLBRSEventName = "黑石塔";
	GroupCalendar_cBWLEventName = "黑翼之巢";
	GroupCalendar_cDeadminesEventName = "死亡礦坑";
	GroupCalendar_cDMEventName = "厄運之槌";
	GroupCalendar_cGnomerEventName = "諾姆瑞根";
	GroupCalendar_cMaraEventName = "瑪拉頓";
	GroupCalendar_cMCEventName = "熔火之心";
	GroupCalendar_cOnyxiaEventName = "奧尼西亞洞穴";
	GroupCalendar_cRFCEventName = "怒焰裂谷";
	GroupCalendar_cRFDEventName = "剃刀高地";
	GroupCalendar_cRFKEventName = "剃刀沼澤";
	GroupCalendar_cSMEventName = "血色修道院";
	GroupCalendar_cScholoEventName = "通靈學院";
	GroupCalendar_cSFKEventName = "影牙城堡";
	GroupCalendar_cStockadesEventName = "監獄";
	GroupCalendar_cStrathEventName = "斯坦索姆";
	GroupCalendar_cSTEventName = "阿塔哈卡神廟";
	GroupCalendar_cUldEventName = "奧達曼";
	GroupCalendar_cWCEventName = "哀嚎洞穴";
	GroupCalendar_cZFEventName = "祖爾法拉克";
	GroupCalendar_cZGEventName = "祖爾格拉布";

	GroupCalendar_cABEventName = "阿拉希盆地";
	GroupCalendar_cAVEventName = "奧特藺克山谷";
	GroupCalendar_cWSGEventName = "戰歌峽谷";

	GroupCalendar_cZGResetEventName = "Zul'Gurub Resets";
	GroupCalendar_cMCResetEventName = "Molten Core Resets";
	GroupCalendar_cOnyxiaResetEventName = "Onyxia Resets";
	GroupCalendar_cBWLResetEventName = "Blackwing Lair Resets";
	GroupCalendar_cAQRResetEventName = "Ahn'Qiraj Ruins Resets";
	GroupCalendar_cAQTResetEventName = "Ahn'Qiraj Temple Resets";

	GroupCalendar_cTransmuteCooldownEventName = "Transmute Available";
	GroupCalendar_cSaltShakerCooldownEventName = "Salt Shaker Available";
	GroupCalendar_cMoonclothCooldownEventName = "Mooncloth Available";
	GroupCalendar_cSnowmasterCooldownEventName = "SnowMaster 9000 Available";

	GroupCalendar_cPersonalEventOwner = "Private";

	GroupCalendar_cRaidInfoMCName = GroupCalendar_cMCEventName;
	GroupCalendar_cRaidInfoOnyxiaName = GroupCalendar_cOnyxiaEventName;
	GroupCalendar_cRaidInfoZGName = GroupCalendar_cZGEventName;
	GroupCalendar_cRaidInfoBWLName = GroupCalendar_cBWLEventName;
	GroupCalendar_cRaidInfoAQRName = "安其拉";
	GroupCalendar_cRaidInfoAQTName = GroupCalendar_cAQTEventName;
	
	-- Race names

	GroupCalendar_cDwarfRaceName = "矮人";
	GroupCalendar_cGnomeRaceName = "地精";
	GroupCalendar_cHumanRaceName = "人類";
	GroupCalendar_cNightElfRaceName = "夜精靈";
	GroupCalendar_cOrcRaceName = "獸人";
	GroupCalendar_cTaurenRaceName = "牛頭人";
	GroupCalendar_cTrollRaceName = "食人妖";
	GroupCalendar_cUndeadRaceName = "不死族";
	GroupCalendar_cBloodElfRaceName = "血精靈";
	GroupCalendar_cDraeneiRaceName = "不死族";

	-- Class names

	GroupCalendar_cDruidClassName = "德魯伊";
	GroupCalendar_cHunterClassName = "獵人";
	GroupCalendar_cMageClassName = "法師";
	GroupCalendar_cPaladinClassName = "聖騎士";
	GroupCalendar_cPriestClassName = "牧師";
	GroupCalendar_cRogueClassName = "盜賊";
	GroupCalendar_cShamanClassName = "薩滿";
	GroupCalendar_cWarlockClassName = "術士";
	GroupCalendar_cWarriorClassName = "戰士";

	-- Plural forms of class names

	GroupCalendar_cDruidsClassName = "德魯伊";
	GroupCalendar_cHuntersClassName = "獵人";
	GroupCalendar_cMagesClassName = "法師";
	GroupCalendar_cPaladinsClassName = "聖騎士";
	GroupCalendar_cPriestsClassName = "牧師";
	GroupCalendar_cRoguesClassName = "盜賊";
	GroupCalendar_cShamansClassName = "薩滿";
	GroupCalendar_cWarlocksClassName = "術士";
	GroupCalendar_cWarriorsClassName = "戰士";

	-- Label forms of the class names for the attendance panel.  Usually just the plural
	-- form of the name followed by a colon

	GroupCalendar_cDruidsLabel = GroupCalendar_cDruidsClassName..":";
	GroupCalendar_cHuntersLabel = GroupCalendar_cHuntersClassName..":";
	GroupCalendar_cMagesLabel = GroupCalendar_cMagesClassName..":";
	GroupCalendar_cPaladinsLabel = GroupCalendar_cPaladinsClassName..":";
	GroupCalendar_cPriestsLabel = GroupCalendar_cPriestsClassName..":";
	GroupCalendar_cRoguesLabel = GroupCalendar_cRoguesClassName..":";
	GroupCalendar_cShamansLabel = GroupCalendar_cShamansClassName..":";
	GroupCalendar_cWarlocksLabel = GroupCalendar_cWarlocksClassName..":";
	GroupCalendar_cWarriorsLabel = GroupCalendar_cWarriorsClassName..":";

	GroupCalendar_cTimeLabel = "時間:";
	GroupCalendar_cDurationLabel = "需時:";
	GroupCalendar_cEventLabel = "活動:";
	GroupCalendar_cTitleLabel = "標題:";
	GroupCalendar_cLevelsLabel = "等級:";
	GroupCalendar_cLevelRangeSeparator = "至";
	GroupCalendar_cDescriptionLabel = "內容:";
	GroupCalendar_cCommentLabel = "備註:";

	CalendarEditor_cNewEvent = "新活動...";
	CalendarEditor_cEventsTitle = "活動";

	GroupCalendar_cGermanTranslation = "德文翻譯由 Silver Hand 的 Palyr 提供";
	GroupCalendar_cFrenchTranslation = "法文翻譯由 Dalaran (EU) 的 Kisanth 提供";
	GroupCalendar_cChineseTranslation = "中文翻譯由 Royaltia (HK) 的 Aska 提供";

	CalendarEventEditor_cNotAttending = "不出席";
	CalendarEventEditor_cConfirmed = "已確定";
	CalendarEventEditor_cDeclined = "已拒絕";
	CalendarEventEditor_cStandby = "在等候名單";
	CalendarEventEditor_cPending = "懸而未決";
	CalendarEventEditor_cUnknownStatus = "不明 %s";

	GroupCalendar_cChannelNameLabel = "頻道名稱:";
	GroupCalendar_cPasswordLabel = "密碼:";

	GroupCalendar_cTimeRangeFormat = "%s至%s";

	GroupCalendar_cPluralMinutesFormat = "%d分鐘";
	GroupCalendar_cSingularHourFormat = "%d小時";
	GroupCalendar_cPluralHourFormat = "%d小時";
	GroupCalendar_cSingularHourPluralMinutes = "%d小時%d分鐘";
	GroupCalendar_cPluralHourPluralMinutes = "%d小時%d分鐘";

	GroupCalendar_cLongDateFormat = "$year".."年".."$month".."$day".."日";
	GroupCalendar_cShortDateFormat = "$day/$monthNum";
	GroupCalendar_cLongDateFormatWithDayOfWeek = "$dow $year".."年".."$month".."$day".."日";

	GroupCalendar_cNotAttending = "不出席";
	GroupCalendar_cAttending = "出席";
	GroupCalendar_cPendingApproval = "等待審批";

	GroupCalendar_cQuestAttendanceNameFormat = "$name ($level $race)";
	GroupCalendar_cMeetingAttendanceNameFormat = "$name ($level $class)";

	GroupCalendar_cNumAttendeesFormat = "%d 位出席";

	BINDING_HEADER_GROUPCALENDAR_TITLE = "團體行事曆";
	BINDING_NAME_GROUPCALENDAR_TOGGLE = "打開/關閉團體行事曆";
end
