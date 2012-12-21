if GetLocale() == "koKR" then	
	Outfitter_cTitle = "Outfitter";
	Outfitter_cTitleVersion = Outfitter_cTitle.." "..Outfitter_cVersion;

	Outfitter_cNameLabel = "이름:";
	Outfitter_cCreateUsingTitle = "최적화:";
	Outfitter_cUseCurrentOutfit = "현재 장비 세트 사용";
	Outfitter_cUseEmptyOutfit = "빈 장비 세트 만듬";

	Outfitter_cOutfitterTabTitle = "Outfitter";
	Outfitter_cOptionsTabTitle = "옵션";
	Outfitter_cAboutTabTitle = "정보";

	Outfitter_cNewOutfit = "신규 장비 세트";
	Outfitter_cRenameOutfit = "장비 세트 이름 변경";

	Outfitter_cCompleteOutfits = "완비 세트";
	Outfitter_cPartialOutfits = "Mix-n-match";
	Outfitter_cAccessoryOutfits = "보조 장비";
	Outfitter_cSpecialOutfits = "특수 조건";
	Outfitter_cOddsNEndsOutfits = "나머지 장비들";

	Outfitter_cNormalOutfit = "평상시";
	Outfitter_cNakedOutfit = "벗기";

	Outfitter_cFishingOutfit = "낚시";
	Outfitter_cHerbalismOutfit = "약초 채집";
	Outfitter_cMiningOutfit = "채광";
	Outfitter_cSkinningOutfit = "무두질";
	Outfitter_cFireResistOutfit = "화염 저항";
	Outfitter_cNatureResistOutfit = "자연 저항";
	Outfitter_cShadowResistOutfit = "암흑 저항";
	Outfitter_cArcaneResistOutfit = "비전 저항";
	Outfitter_cFrostResistOutfit = "냉기 저항";

	Outfitter_cArgentDawnOutfit = "은빛 여명회";
	Outfitter_cRidingOutfit = "말타기";
	Outfitter_cDiningOutfit = "음식 먹기";
	Outfitter_cBattlegroundOutfit = "전장";
	Outfitter_cABOutfit = "전장: 아라시 분지";
	Outfitter_cAVOutfit = "전장: 알터랙 계곡";
	Outfitter_cWSGOutfit = "전장: 전쟁노래 협곡";
	Outfitter_cCityOutfit = "마을 주변";

	Outfitter_cMountSpeedFormat = "이동 속도 (%d+)%%만큼 증가"; -- For detecting when mounted

	Outfitter_cBagsFullError = "Outfitter: 가방이 가득 차서 %s|1을;를; 벗을 수 없습니다.";
	Outfitter_cDepositBagsFullError = "Outfitter: 가방이 가득 차서 %s|1을;를; 벗을 수 없습니다.";
	Outfitter_cWithdrawBagsFullError = "Outfitter: 가방이 가득 차서 %s|1을;를; 벗을 수 없습니다.";
	Outfitter_cItemNotFoundError = "Outfitter: %s 아이템을 찾을 수 없습니다.";
	Outfitter_cItemAlreadyUsedError = "Outfitter: %s|1은;는; 이미 다른 슬롯에서 사용중이므로 %s 슬롯에 착용할 수 없습니다.";
	Outfitter_cAddingItem = "Outfitter: %s|1을;를 %s 세트에 추가합니다.";
	Outfitter_cNameAlreadyUsedError = "에러: 사용중인 이름입니다.";
	Outfitter_cNoItemsWithStatError = "경고: 해당 능력을 가진 아이템이 없습니다.";

	Outfitter_cEnableAll = "모두 활성화";
	Outfitter_cEnableNone = "모두 비활성화";

	Outfitter_cConfirmDeleteMsg = "%s 세트를 삭제 하시겠습니까?";
	Outfitter_cConfirmRebuildMsg = "%s 세트를 재구성 하시겠습니까?";
	Outfitter_cRebuild = "Rebuild";

	Outfitter_cWesternPlaguelands = "서부 역병지대";
	Outfitter_cEasternPlaguelands = "동부 역병지대";
	Outfitter_cStratholme = "스트라솔룸";
	Outfitter_cScholomance = "스칼로맨스";
	Outfitter_cNaxxramas = "낙스라마스";
	Outfitter_cAlteracValley = "알터랙 계곡";
	Outfitter_cArathiBasin = "아라시 분지";
	Outfitter_cWarsongGulch = "전쟁노래 협곡";
	Outfitter_cIronforge = "아이언포지";
	Outfitter_cCityOfIronforge = "아이언포지";
	Outfitter_cDarnassus = "다르나서스";
	Outfitter_cStormwind = "스톰윈드";
	Outfitter_cOrgrimmar = "오그리마";
	Outfitter_cThunderBluff = "썬더 블러프";
	Outfitter_cUndercity = "언더시티";

	Outfitter_cFishingPole = "낚싯대";
	Outfitter_cStrongFishingPole = "특튼한 낚싯대";
	Outfitter_cBigIronFishingPole = "큰 철재 낚싯대";
	Outfitter_cBlumpFishingPole = "블럼프가의 낚싯대";
	Outfitter_cNatPaglesFishingPole = "네트 페이글의 다낚아 FC-5000";
	Outfitter_cArcaniteFishingPole = "아케이나이트 낚싯대";

	Outfitter_cArgentDawnCommission = "은빛 여명회 위임봉";
	Outfitter_cSealOfTheDawn = "여명의 문장";
	Outfitter_cRuneOfTheDawn = "여명의 룬";

	Outfitter_cCarrotOnAStick = "당근 달린 지팡이";

	Outfitter_cItemStatFormats =
	{
		{Format = "체력 %+(%d+)", Types = {"Stamina"}},
		{Format = "지능 %+(%d+)", Types = {"Intellect"}},
		{Format = "민첩 %+(%d+)", Types = {"Agility"}},
		{Format = "힘 %+(%d+)", Types = {"Strength"}},
		{Format = "정신력 %+(%d+)", Types = {"Spirit"}},
		{Format = "방어도 %+(%d+)", Types = {"Armor"}},
		{Format = "방어 숙련도 %+(%d+)", Types = {"Defense"}},
		{Format = "Increased Defense %+(%d+)", Types = {"Defense"}},
		
		{Format = "%+(%d+) 체력", Types = {"Stamina"}},
		{Format = "%+(%d+) 지능", Types = {"Intellect"}},
		{Format = "%+(%d+) 민첩", Types = {"Agility"}},
		{Format = "%+(%d+) 힘", Types = {"Strength"}},
		{Format = "%+(%d+) 정신력", Types = {"Spirit"}},
		{Format = "(%d+) 방어도", Types = {"Armor"}},
		{Format = "%+(%d+) 전투력", Types = {"Attack"}},
		
		{Format = "모든 능력치 %+(%d+)", Types = {"Stamina", "Intellect", "Agility", "Strength", "Spirit"}},
		
		{Format = "마나 %+(%d+)", Types = {"Mana"}},
		{Format = "생명력 %+(%d+)", Types = {"Health"}},
		
		{Format = "매 5초마다 %+(%d+)의 마나", Types = {"ManaRegen"}},
		{Format = "매 5초마다 (%d+)의 마나가 회복됩니다.", Types = {"ManaRegen"}},
		
		{Format = "매 5초마다 %+(%d+)의 생명력", Types = {"HealthRegen"}},
		{Format = "매 5초마다 (%d+)의 생명력이 회복됩니다.", Types = {"HealthRegen"}},
		{Format = "Restores (%d+) health per 5 sec.", Types = {"HealthRegen"}},
		
		{Format = "최하급 탈것 속도 증가", Value = 3, Types = {"Riding"}},
		{Format = "미스릴 박차", Value = 3, Types = {"Riding"}},
		
		{Format = "화염 저항력 %+(%d+)", Types = {"FireResist"}},
		{Format = "자연 저항력 %+(%d+)", Types = {"NatureResist"}},
		{Format = "냉기 저항력 %+(%d+)", Types = {"FrostResist"}},
		{Format = "암흑 저항력 %+(%d+)", Types = {"ShadowResist"}},
		{Format = "비전 저항력 %+(%d+)", Types = {"ArcaneResist"}},
		{Format = "모든 저항력 %+(%d+)", Types = {"FireResist", "NatureResist", "FrostResist", "ShadowResist", "ArcaneResist"}},
		
		{Format = "무기 공격력 %+(%d+)", Types = {"MeleeDmg"}},
		{Format = "무기의 적중률이 (%d+)%%만큼 증가합니다.", Types = {"MeleeHit"}},
		{Format = "치명타를 적중시킬 확률이 (%d+)%%만큼 증가합니다.", Types = {"MeleeCrit"}},
		{Format = "공격을 회피할 확률이 (%d+)%%만큼 증가합니다.", Types = {"Dodge"}},
		{Format = "공격력 %+(%d+)", Types = {"MeleeDmg"}},
		{Format = "(%d+)의 피해 방어", Types = {"Block"}},
		{Format = "방어도 %+(%d+)", Types = {"Block"}},
		{Format = "방패의 피해 방어량이 (%d+)만큼 증가합니다.", Types = {"Block"}},
		
		{Format = "낚시 숙련도 %+(%d+)%.", Types = {"Fishing"}},
		{Format = "낚시 %+(%d+)", Types = {"Fishing"}},
		{Format = "약초 채집 %+(%d+)", Types = {"Herbalism"}},
		{Format = "채광 %+(%d+)", Types = {"Mining"}},
		{Format = "무두질 %+(%d+)", Types = {"Skinning"}},
		
		{Format = "주문이 극대화 효과를 낼 확률이(%d+)%%만큼 증가합니다.", Types = {"SpellCrit"}},
		{Format = "주문의 적중률이 (%d+)%%만큼 증가합니다.", Types = {"SpellHit"}},
		{Format = "모든 주문 및 효과에 의한 피해와 치유량이 최대 (%d+)만큼 증가합니다.", Types = {"SpellDmg", "ShadowDmg", "FireDmg", "FrostDmg", "ArcaneDmg", "NatureDmg", "Healing"}},
		{Format = "모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼 증가합니다.", Types = {"Healing"}},
		{Format = "치유 주문 %+(%d+)", Types = {"Healing"}},
		{Format = "%+(%d+) 치유 주문", Types = {"Healing"}},
		
		{Format = "%+(%d+) 화염 주문 공격력", Types = {"FireDmg"}},
		{Format = "%+(%d+) 암흑 주문 공격력", Types = {"ShadowDmg"}},
		{Format = "%+(%d+) 냉기 주문 공격력", Types = {"FrostDmg"}},
		{Format = "%+(%d+) 비전 주문 공격력", Types = {"ArcaneDmg"}},
		{Format = "%+(%d+) 자연 주문 공격력", Types = {"NatureDmg"}},

		{Format = "화염 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", Types = {"FireDmg"}},
		{Format = "암흑 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", Types = {"ShadowDmg"}},
		{Format = "냉기 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", Types = {"FrostDmg"}},
		{Format = "비전 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", Types = {"ArcaneDmg"}},
		{Format = "자연 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다.", Types = {"NatureDmg"}},
	};

	Outfitter_cAgilityStatName = "민첩";
	Outfitter_cArmorStatName = "방어도";
	Outfitter_cDefenseStatName = "방어 숙련도";
	Outfitter_cIntellectStatName = "지능";
	Outfitter_cSpiritStatName = "정신력";
	Outfitter_cStaminaStatName = "체력";
	Outfitter_cStrengthStatName = "힘";

	Outfitter_cManaRegenStatName = "마나 회복";
	Outfitter_cHealthRegenStatName = "생명력 회복";

	Outfitter_cSpellCritStatName = "주문 치명타";
	Outfitter_cSpellHitStatName = "주문 적중률";
	Outfitter_cSpellDmgStatName = "주문 공격력";
	Outfitter_cFrostDmgStatName = "냉기 주문 공격력";
	Outfitter_cFireDmgStatName = "화염 주문 공격력";
	Outfitter_cArcaneDmgStatName = "비전 주문 공격력";
	Outfitter_cShadowDmgStatName = "암흑 주문 공격력";
	Outfitter_cNatureDmgStatName = "자연 주문 공격력";
	Outfitter_cHealingStatName = "치유량";

	Outfitter_cMeleeCritStatName = "근접 치명타";
	Outfitter_cMeleeHitStatName = "근접 적중률";
	Outfitter_cMeleeDmgStatName = "근접 공격력";
	Outfitter_cAttackStatName = "전투력";
	Outfitter_cDodgeStatName = "회피";

	Outfitter_cArcaneResistStatName = "비전 저항력";
	Outfitter_cFireResistStatName = "화염 저항력";
	Outfitter_cFrostResistStatName = "냉기 저항력";
	Outfitter_cNatureResistStatName = "자연 저항력";
	Outfitter_cShadowResistStatName = "암흑 저항력";

	Outfitter_cFishingStatName = "낚시";
	Outfitter_cHerbalismStatName = "약초 채집";
	Outfitter_cMiningStatName = "채광";
	Outfitter_cSkinningStatName = "무두질";

	Outfitter_cOptionsTitle = "Outfitter Options";
	Outfitter_cShowMinimapButton = "미니맵 버튼 표시";
	Outfitter_cShowMinimapButtonOnDescription = "미니맵 버튼을 사용하지 않으려면 끕니다.";
	Outfitter_cShowMinimapButtonOffDescription = "미니맵 버튼을 사용하려면 켭니다.";
	Outfitter_cRememberVisibility = "망토와 투구 설정 기억";
	Outfitter_cRememberVisibilityOnDescription = "모든 망토와 투구에 대해서 동일한 설정을 하려면 끕니다.";
	Outfitter_cRememberVisibilityOffDescription = "각각의 망토와 투구에 대한 설정을 기억하려면 켭니다.";
	Outfitter_cShowHotkeyMessages = "단축키로 변경할때 보여주기";
	Outfitter_cShowHotkeyMessagesOnDescription = "단축키로 세트를 변경할때 메시지를 보지 않으려면 끕니다.";
	Outfitter_cShowHotkeyMessagesOffDescription = "단축키로 세트를 변경할때 메시지를 보려면 켭니다.";

	Outfitter_cEquipOutfitMessageFormat = "Outfitter: %s 장비됨";
	Outfitter_cUnequipOutfitMessageFormat = "Outfitter: %s 해제됨";

	Outfitter_cAboutTitle = "Outfitter 정보";
	Outfitter_cAuthor = "Designed and written by John Stephen";
	Outfitter_cTestersTitle = "Beta Testers";
	Outfitter_cTestersNames = "Airmid, Desiree, Fizzlebang, Harper, Kallah and Sumitra";
	Outfitter_cSpecialThanksTitle = "Special thanks for their support to";
	Outfitter_cSpecialThanksNames = "Brian, Dave, Glenn, Leah, Mark, The Mighty Pol, SFC and Forge";
	Outfitter_cGuildURL = "http://www.starfleetclan.com";
	Outfitter_cGuildURL2 = "http://www.forgeguild.com";

	Outfitter_cOpenOutfitter = "Outfitter 열기";

	Outfitter_cArgentDawnOutfitDescription = "이 세트는 역병지대에 있을 때 자동으로 착용 됩니다.";
	Outfitter_cRidingOutfitDescription = "이 세트는 탈것을 탈 때 자동으로 착용 됩니다.";
	Outfitter_cDiningOutfitDescription = "이 세트는 음식을 먹거나 음료를 마실 때 자동으로 착용 됩니다.";
	Outfitter_cBattlegroundOutfitDescription = "이 세트는 전장에 있을 때 자동으로 착용 됩니다.";
	Outfitter_cArathiBasinOutfitDescription = "이 세트는 아라시 분지에 있을 때 자동으로 착용 됩니다.";
	Outfitter_cAlteracValleyOutfitDescription = "이 세트는 알터랙 계곡에 있을 때 자동으로 착용 됩니다.";
	Outfitter_cWarsongGulchOutfitDescription = "이 세트는 전쟁노래 협곡에 있을 때 자동으로 착용 됩니다.";
	Outfitter_cCityOutfitDescription = "이 세트는 우호적인 대도시에 있을 때 자동으로 착용 됩니다.";

	Outfitter_cKeyBinding = "단축키";

	BINDING_HEADER_OUTFITTER_TITLE = Outfitter_cTitle;

	BINDING_NAME_OUTFITTER_OUTFIT1  = "세트 1";
	BINDING_NAME_OUTFITTER_OUTFIT2  = "세트 2";
	BINDING_NAME_OUTFITTER_OUTFIT3  = "세트 3";
	BINDING_NAME_OUTFITTER_OUTFIT4  = "세트 4";
	BINDING_NAME_OUTFITTER_OUTFIT5  = "세트 5";
	BINDING_NAME_OUTFITTER_OUTFIT6  = "세트 6";
	BINDING_NAME_OUTFITTER_OUTFIT7  = "세트 7";
	BINDING_NAME_OUTFITTER_OUTFIT8  = "세트 8";
	BINDING_NAME_OUTFITTER_OUTFIT9  = "세트 9";
	BINDING_NAME_OUTFITTER_OUTFIT10 = "세트 10";

	Outfitter_cDisableOutfit = "세트 사용 안함";
	Outfitter_cDisableOutfitInBG = "전장에서 사용 안함";
	Outfitter_cDisabledOutfitName = "%s (사용 안함)";

	Outfitter_cMinimapButtonTitle = "미니맵 버튼";
	Outfitter_cMinimapButtonDescription = "클릭 : 세트 선택, 드래그 : 미니맵 버튼 이동";

	Outfitter_cDruidClassName = "드루이드";
	Outfitter_cHunterClassName = "사냥꾼";
	Outfitter_cMageClassName = "마법사";
	Outfitter_cPaladinClassName = "성기사";
	Outfitter_cPriestClassName = "사제";
	Outfitter_cRogueClassName = "도적";
	Outfitter_cShamanClassName = "주술사";
	Outfitter_cWarlockClassName = "흑마법사";
	Outfitter_cWarriorClassName = "전자";

	Outfitter_cBattleStance = "전투 태세";
	Outfitter_cDefensiveStance = "방어 태세";
	Outfitter_cBerserkerStance = "광폭 태세";

	Outfitter_cWarriorBattleStance = "전사: 전투 태세";
	Outfitter_cWarriorDefensiveStance = "전사: 방어 태세";
	Outfitter_cWarriorBerserkerStance = "전사: 광폭 태세";

	Outfitter_cBearForm = "곰 변신";
	Outfitter_cCatForm = "표범 변신표범 변신";
	Outfitter_cAquaticForm = "바다표범 변신";
	Outfitter_cTravelForm = "치타 변신";
	Outfitter_cDireBearForm = "광포한 곰 변신";
	Outfitter_cMoonkinForm = "달빛야수 변신";

	Outfitter_cGhostWolfForm = "늑대 정령";

	Outfitter_cStealth = "은신";

	Outfitter_cDruidBearForm = "드루이드: 곰 변신";
	Outfitter_cDruidCatForm = "드루이드: 표범 변신";
	Outfitter_cDruidAquaticForm = "드루이드: 바다표범 변신";
	Outfitter_cDruidTravelForm = "드루이드: 치타 변신";
	Outfitter_cDruidMoonkinForm = "드루이드: 달빛야수 변신";

	Outfitter_cPriestShadowform = "사제: 어둠의 형상";

	Outfitter_cRogueStealth = "도적: 은신";

	Outfitter_cShamanGhostWolf = "주술사: 늑대 정령";

	Outfitter_cHunterMonkey = "사냥꾼: 원숭이의 상";
	Outfitter_cHunterHawk =  "사냥꾼: 매의 상";
	Outfitter_cHunterCheetah =  "사냥꾼: 치타의 상";
	Outfitter_cHunterPack =  "사냥꾼: 치타 무리의 상";
	Outfitter_cHunterBeast =  "사냥꾼: 야수의 상";
	Outfitter_cHunterWild =  "사냥꾼: 야생의 상";

	Outfitter_cMageEvocate = "마법사: 환기";

	Outfitter_cAspectOfTheCheetah = "치타의 상";
	Outfitter_cAspectOfThePack = "치타 무리의 상";
	Outfitter_cAspectOfTheBeast = "야수의 상";
	Outfitter_cAspectOfTheWild = "야생의 상";
	Outfitter_cEvocate = "환기";

	Outfitter_cCompleteCategoryDescripton = "모든 슬롯의 아이템에 관한 설정이 들어있는 완전한 장비 세트입니다.";
	Outfitter_cPartialCategoryDescription = "Mix-n-match의 장비 세트는 전부가 아닌 일부 슬롯만 가집니다. 장비 세트가 선택되면 이전에 선택되었던 보조 장비 세트 또는 Mix-n-match 세트를 대체하면서, 완비 세트에서 해당 아이템만을 교체합니다.";
	Outfitter_cAccessoryCategoryDescription = "보조 장비의 장비 세트는 전부가 아닌 일부 슬롯만 가집니다. Mix-n-match와는 다르게 이전에 선택되었던 보조 장비 세트 또는 Mix-n-match 세트를 대체하지 않고 추가로 완비 세트에서 해당 아이템을 교체합니다.";
	Outfitter_cSpecialCategoryDescription = "특수 조건의 장비 세트는 해당하는 조건을 충족시킬 경우 자동으로 착용됩니다.";
	Outfitter_cOddsNEndsCategoryDescription = "나머지 장비들의 아이템들은 장비 세트에 한번도 사용되지 않은 아이템들입니다.";

	Outfitter_cRebuildOutfitFormat = "%s 재구성";

	Outfitter_cTranslationCredit = " ";

	Outfitter_cSlotEnableTitle = "슬롯 활성화";
	Outfitter_cSlotEnableDescription = "슬롯을 활성화 하면 해당 장비 세트를 사용할때 같이 변경됩니다.";

	Outfitter_cFinger0SlotName = "첫번째 손가락";
	Outfitter_cFinger1SlotName = "두번째 손가락";

	Outfitter_cTrinket0SlotName = "첫번째 장신구";
	Outfitter_cTrinket1SlotName = "두번째 장신구";

	Outfitter_cOutfitCategoryTitle = "카테고리";
	Outfitter_cBankCategoryTitle = "은행";
	Outfitter_cDepositToBank = "모든 아이템을 은행으로";
	Outfitter_cDepositUniqueToBank = "특정 아이템을 은행으로";
	Outfitter_cWithdrawFromBank = "은행으로부터 아이템 회수";

	Outfitter_cMissingItemsLabel = "찾을 수 없는 아이템: ";
	Outfitter_cBankedItemsLabel = "은행에 있는 아이템: ";

	Outfitter_cRepairAllBags = "Outfitter: 모든 아이템 수리";

	Outfitter_cStatsCategory = "능력치";
	Outfitter_cMeleeCategory = "근접";
	Outfitter_cSpellsCategory = "주문과 치유";
	Outfitter_cRegenCategory = "회복";
	Outfitter_cResistCategory = "저항";
	Outfitter_cTradeCategory = "전문기술";

	Outfitter_cTankPoints = "탱크 포인트";
	Outfitter_cCustom = "사용자 설정";
end