------------------------------------------------------
-- localization.lua
-- English strings by default, localizations override with their own.
------------------------------------------------------

FAS_Localized = {};		-- this line doesn't need localization, it just lets us use FAS_Localized below.

	SOLD_FOR_PRICE_BY = "Sold for %s by";					-- prefix to vendor info when price is shown
	SOLD_BY = "Sold by";									-- prefix to vendor info when no price is shown
	RETURN_TO = "Return to";								-- prefix to info for librams
	ARCANUM_FORMAT = "Reward: %s enchantment";				-- bonus info for librams
	VENDOR_LOCATION_FORMAT = "%s, %s";						-- format for showing vendor name and location
	FAS_FACTION_REWARDS = "%s Rewards:";
	FAS_FACTION_REWARDS_COUNT = "%d %s Rewards";
	FAS_TURNIN = "Faction turnin for";
	FAS_WITH = "also requires";
	
-- notes for other items
	DARKMOON = "Bring to Darkmoon Faire, win prizes!";
	
-- notes for vendors with special availability
	SEASONAL_VENDOR = "(Seasonal vendor)";
	SCHOLO_QUEST = "Requires Spectral Essence";

-- non-nil note so vendors in instances are highlighted in a different color
-- but no actual note text because it'd be cheesy to give too much away...	
	BRD_BARKEEP = "";
	DM_LIBRARY = "";
	
-- non-nil note for faction recipes so it gets a different color
-- no actual note because it's part of the base tooltip now.
	REQ_FACTION = "";
	
-- notes for items only available once you have a certain reputation standing
	THORIUM_FRIENDLY = "Requires Thorium Brotherhood - "..FACTION_STANDING_LABEL5;
	THORIUM_HONORED = "Requires Thorium Brotherhood - "..FACTION_STANDING_LABEL6;
	THORIUM_REVERED = "Requires Thorium Brotherhood - "..FACTION_STANDING_LABEL7;
	THORIUM_EXALTED = "Requires Thorium Brotherhood - "..FACTION_STANDING_LABEL8;

	TIMBERMAW_FRIENDLY = "Requires Timbermaw Furbolgs - "..FACTION_STANDING_LABEL5;

-- Faction names
	AD_FACTION = "Argent Dawn";
	ZG_FACTION = "Zandalar Tribe";
	AQ20_FACTION = "Cenarion Circle";
	AQ40_FACTION = "Brood of Nozdormu";
	
-- localized class names
	PALADIN = "Paladin";
	SHAMAN = "Shaman";
	MAGE = "Mage";
	PRIEST = "Priest";
	WARLOCK = "Warlock";
	WARRIOR = "Warrior";
	HUNTER = "Hunter";
	ROGUE = "Rogue";
	DRUID = "Druid";

-- localized weapon types
	STAFF = "Staff";
	MACE = "Mace";
	AXE = "Axe";
	GUN = "Gun";
	DAGGER = "Dagger";
	SHIELD = "Shield";
	SWORD = "Sword";

FAS_OPTIONS = "AdSpace Options";
FAS_OPTIONS_GENERAL = "Add info to tooltips for items:";
FAS_OPTION_RECIPES = "Recipes available from NPC vendors";
FAS_OPTION_RECIPE_COST = "Show vendor price for recipes";
FAS_OPTION_LIBRAM = "Librams (turnin NPC and reward info)";
FAS_OPTION_DARKMOON = "Grey items with Darkmoon Faire rewards";
FAS_OPTION_AD = "Items turned in for Seals of the Dawn/Crusade";

FAS_OPTIONS_RAID = "And for special raid loot:";
FAS_OPTION_ZG = "Zul'Gurub";
FAS_OPTION_ZG_FACTION = "(Zandalar Tribe rewards)";
FAS_OPTION_AQ20 = "Ruins of Ahn'Qiraj";
FAS_OPTION_AQ20_FACTION = "(AQ20 Cenarion Circle rewards)";
FAS_OPTION_AQ40 = "Ahn'Qiraj";
FAS_OPTION_AQ40_FACTION = "(AQ40 Brood of Nozdormu rewards)";
FAS_OPTION_POST_RAID = "Post to raid chat when getting info via '/ads [link]'";

if ( GetLocale() == "deDE" ) then

	SOLD_FOR_PRICE_BY = "Verkauft um %s von";					-- prefix to vendor info when price is shown
	SOLD_BY = "Verkauft von";									-- prefix to vendor info when no price is shown
	RETURN_TO = "Zurückkehren zu";								-- prefix to info for librams
	ARCANUM_FORMAT = "Belohnung: %s Verzauberung";				-- bonus info for librams
	VENDOR_LOCATION_FORMAT = "%s, %s";						-- format for showing vendor name and location
	
-- notes for other items
	DARKMOON = "Zum Dunkelmond-Jahrmarkt bringen und Belohnungen abholen!";
	
-- notes for vendors with special availability
	SEASONAL_VENDOR = "(Saisonaler Verkäufer)";
	SCHOLO_QUEST = "Benötigt Spektrale Essenz";
	
-- notes for items only available once you have a certain reputation standing
	THORIUM_FRIENDLY = "Benötigt Thorium-Bruderschaft - "..FACTION_STANDING_LABEL5;
	THORIUM_HONORED = "Benötigt Thorium-Bruderschaft - "..FACTION_STANDING_LABEL6;
	THORIUM_REVERED = "Benötigt Thorium-Bruderschaft - "..FACTION_STANDING_LABEL7;
	THORIUM_EXALTED = "Benötigt Thorium-Bruderschaft - "..FACTION_STANDING_LABEL8;

	TIMBERMAW_FRIENDLY = "Benötigt Die Holzschlundfeste - "..FACTION_STANDING_LABEL5;

-- localized zone names (only those that differ from the enUS version should be present)
	FAS_Localized["Alterac Mountains"] = "Das Alteracgebirge";
	FAS_Localized["Arathi Highlands"] = "Das Arathihochland";
	FAS_Localized["Badlands"] = "Das Ödland";
	FAS_Localized["Blackrock Depths"] = "Blackrocktiefen";
	FAS_Localized["Blasted Lands"] = "Die verwüsteten Lande";
	FAS_Localized["Burning Steppes"] = "Die brennende Steppe";
	FAS_Localized["Dustwallow Marsh"] = "Die Marschen von Dustwallow";
	FAS_Localized["Eastern Plaguelands"] = "Die östlichen Pestländer";
	FAS_Localized["Elwynn Forest"] = "Der Wald von Elwynn";
	FAS_Localized["Hillsbrad Foothills"] = "Die Vorgebirge von Hillsbrad";
	FAS_Localized["Redridge Mountains"] = "Das Redridgegebirge";
	FAS_Localized["Silverpine Forest"] = "Der Silberwald";
	FAS_Localized["Stonetalon Mountains"] = "Das Steinkrallengebirge";
	FAS_Localized["Stormwind City"] = "Stormwind";
	FAS_Localized["Stranglethorn Vale"] = "Stranglethorn";
	FAS_Localized["Swamp of Sorrows"] = "Die Sümpfe des Elends";
	FAS_Localized["The Barrens"] = "Das Brachland";
	FAS_Localized["The Hinterlands"] = "Das Hinterland";
	FAS_Localized["Tirisfal Glades"] = "Tirisfal";
	FAS_Localized["Un'Goro Crater"] = "Der Un'Goro Krater";
	FAS_Localized["Wailing Caverns"] = "Die Höhlen des Wehklagens";
	FAS_Localized["Western Plaguelands"] = "Die westlichen Pestländer";
	FAS_Localized["Wetlands"] = "Das Sumpfland";
	
-- localized NPC names (only those that differ from the enUS version should be present)
	FAS_Localized["Alchemist Pestlezugg"] = "Alchimist Pestlezugg";
	FAS_Localized["Argent Quartermaster Hasana"] = "Argentum-Rüstmeister Hasana";
	FAS_Localized["Argent Quartermaster Lightspark"] = "Argentum-Rüstmeister Lightspark";
	FAS_Localized["Defias Profiteer"] = "Defias-Schieber";
	FAS_Localized["Lorekeeper Lydros"] = "Wissenswächter Lydros";
	FAS_Localized["Outfitter Eric"] = "Ausstatter Eric";
	FAS_Localized["Quartermaster Miranda Breechlock"] = "Rüstmeisterin Miranda Breechlock";
	FAS_Localized["Rin'wosho the Trader"] = "Rin'wosho der Händler";

-- localized libram descriptions 
	FAS_Localized["+1% Dodge"] = "+1% Ausweichen";
	FAS_Localized["+1% Haste"] = "+1% Angriffsgeschwindigkeit";
	FAS_Localized["+100 Health"] = "+100 Gesundheit";
	FAS_Localized["+125 Armor"] = "+125 Rüstung";
	FAS_Localized["+20 Fire Resistance"] = "+20 Feuer Resistenz";
	FAS_Localized["+8 Spell damage/healing"] = "+8 Zauberschaden/Heilung";
	FAS_Localized["+8 any single stat"] = "+8 alle Werte";

-- localized special raid loot tokens
	FAS_Localized["Zulian Coin"]		=	"Zulianische Münze";
	FAS_Localized["Razzashi Coin"]		=	"Münze der Razzashi";
	FAS_Localized["Hakkari Coin"]		=	"Münze der Hakkari";
	FAS_Localized["Gurubashi Coin"]		=	"Münze der Gurubashi";
	FAS_Localized["Vilebranch Coin"]	=	"Münze der Vilebranch";
	FAS_Localized["Witherbark Coin"]	=	"Münze der Witherbark";
	FAS_Localized["Sandfury Coin"]		=	"Münze der Sandfury";
	FAS_Localized["Skullsplitter Coin"]	=	"Münze der Skullsplitter";
	FAS_Localized["Bloodscalp Coin"]	=	"Münze der Bloodscalp";
            
	FAS_Localized["Red Hakkari Bijou"]		=	"Rotes Schmuckstück der Hakkari";
	FAS_Localized["Blue Hakkari Bijou"]		=	"Blaues Schmuckstück der Hakkari";
	FAS_Localized["Yellow Hakkari Bijou"]	=	"Gelbes Schmuckstück der Hakkari";
	FAS_Localized["Orange Hakkari Bijou"]	=	"Orangefarbenes Schmuckstück der Hakkari";
	FAS_Localized["Green Hakkari Bijou"]	=	"Grünes Schmuckstück der Hakkari";
	FAS_Localized["Purple Hakkari Bijou"]	=	"Lilanes Schmuckstück der Hakkari";
	FAS_Localized["Bronze Hakkari Bijou"]	=	"Bronzefarbenes Schmuckstück der Hakkari";
	FAS_Localized["Silver Hakkari Bijou"]	=	"Silbernes Schmuckstück der Hakkari";
	FAS_Localized["Gold Hakkari Bijou"]		=	"Goldenes Schmuckstück der Hakkari";
            
	FAS_Localized["Primal Hakkari Bindings"]	=	"Urzeitliche Hakkaribindungen";
	FAS_Localized["Primal Hakkari Armsplint"]	=	"Urzeitliche Hakkariarmsplinte";
	FAS_Localized["Primal Hakkari Stanchion"]	=	"Urzeitliche Hakkaristütze";
	FAS_Localized["Primal Hakkari Girdle"]		=	"Urzeitlicher Hakkarigurt";
	FAS_Localized["Primal Hakkari Sash"]		=	"Urzeitliche Hakkarischärpe";
	FAS_Localized["Primal Hakkari Shawl"]		=	"Urzeitlicher Hakkarischal";
	FAS_Localized["Primal Hakkari Tabard"]		=	"Urzeitlicher Hakkariwappenrock";
	FAS_Localized["Primal Hakkari Kossack"]		=	"Urzeitlicher Hakkarikosak";
	FAS_Localized["Primal Hakkari Aegis"]		=	"Urzeitliche Aegis der Hakkari";
            
	FAS_Localized["Qiraji Magisterial Ring"]	=	"Gebieterring der Qiraji";
	FAS_Localized["Qiraji Ceremonial Ring"]		=	"Zeremonienring der Qiraji";
	FAS_Localized["Qiraji Martial Drape"]		=	"Kampftuch der Qiraji";
	FAS_Localized["Qiraji Regal Drape"]			=	"Hoheitstuch der Qiraji";
	FAS_Localized["Qiraji Spiked Hilt"]			=	"Stachelgriff der Qiraji";
	FAS_Localized["Qiraji Ornate Hilt"]			=	"Verschnörkelter Griff der Qiraji";
            
	FAS_Localized["Imperial Qiraji Armaments"]	=	"Imperiale Qirajiwaffe";
	FAS_Localized["Imperial Qiraji Regalia"]	=	"Imperiale Qirajiinsignie";
            
	FAS_Localized["Qiraji Bindings of Command"]		=	"Befehlsbindungen der Qiraji";
	FAS_Localized["Qiraji Bindings of Dominance"]	=	"Dominanzbindungen der Qiraji";
	FAS_Localized["Ouro's Intact Hide"]				=	"Ouros intakte Haut";
	FAS_Localized["Skin of the Great Sandworm"]		=	"Haut des großen Sandwurms";
	FAS_Localized["Vek'lor's Diadem"]				=	"Vek'lors Diadem";
	FAS_Localized["Vek'nilash's Circlet"]			=	"Vek'nilashs Reif";
	FAS_Localized["Carapace of the Old God"]		=	"Knochenpanzer des alten Gottes";
	FAS_Localized["Husk of the Old God"]			=	"Hülle des alten Gottes";
            
	FAS_Localized["Stone Scarab"]	=	"Steinskarabäus";
	FAS_Localized["Gold Scarab"]	=	"Goldskarabäus";
	FAS_Localized["Silver Scarab"]	=	"Silberskarabäus";
	FAS_Localized["Bronze Scarab"]	=	"Bronzeskarabäus";
	FAS_Localized["Crystal Scarab"]	=	"Kristallskarabäus";
	FAS_Localized["Clay Scarab"]	=	"Tonskarabäus";
	FAS_Localized["Bone Scarab"]	=	"Knochenskarabäus";
	FAS_Localized["Ivory Scarab"]	=	"Elfenbeinskarabäus";
            
	FAS_Localized["Azure Idol"]			=	"Azurgötze";
	FAS_Localized["Onyx Idol"]			=	"Onyxgötze";
	FAS_Localized["Lambent Idol"]		=	"Züngelnder Götze";
	FAS_Localized["Amber Idol"]			=	"Bernsteingötze";
	FAS_Localized["Jasper Idol"]		=	"Jaspisgötze";
	FAS_Localized["Obsidian Idol"]		=	"Obsidiangötze";
	FAS_Localized["Vermillion Idol"]	=	"Zinnobergötze";
	FAS_Localized["Alabaster Idol"]		=	"Alabastergötze";
            
	FAS_Localized["Idol of the Sun"]	=	"Götze der Sonne";
	FAS_Localized["Idol of Night"]		=	"Götze der Nacht";
	FAS_Localized["Idol of Death"]		=	"Götze des Todes";
	FAS_Localized["Idol of the Sage"]	=	"Götze der Weisen";
	FAS_Localized["Idol of Rebirth"]	=	"Götze der Wiedergeburt";
	FAS_Localized["Idol of Life"]		=	"Götze des Lebens";
	FAS_Localized["Idol of Strife"]		=	"Götze des Kampfes";
	FAS_Localized["Idol of War"]		=	"Götze des Krieges";

end


if ( GetLocale() == "koKR" ) then

	SOLD_FOR_PRICE_BY = "상점가격 %s 판매:";					-- prefix to vendor info when price is shown
	SOLD_BY = "[판매]";									-- prefix to vendor info when no price is shown
	RETURN_TO = "보상 NPC: ";								-- prefix to info for librams
	ARCANUM_FORMAT = "최종보상: %s - 마법부여 가능";				-- bonus info for librams
	VENDOR_LOCATION_FORMAT = "%s (%s)";						-- format for showing vendor name and location
	
-- notes for other items
	DARKMOON = "다크문상품권 교환용";
	
-- notes for vendors with special availability
	SEASONAL_VENDOR = "(계절 임시상인)";
	SCHOLO_QUEST = "카엘다로우 영원정수 착용 필요";
	
-- notes for items only available once you have a certain reputation standing
	THORIUM_FRIENDLY = "토륨대장조합 평판필요 - "..FACTION_STANDING_LABEL5;
	THORIUM_HONORED = "토륨대장조합 평판필요 - "..FACTION_STANDING_LABEL6;
	THORIUM_REVERED = "토륨대장조합 평판필요 - "..FACTION_STANDING_LABEL7;
	THORIUM_EXALTED = "토륨대장조합 평판필요 - "..FACTION_STANDING_LABEL8;

	TIMBERMAW_FRIENDLY = "나무구렁펄볼그 평판필요 - "..FACTION_STANDING_LABEL5;

-- localized zone names (only those that differ from the enUS version should be present)
	FAS_Localized["Alterac Mountains"] = "알터랙 산맥";
	FAS_Localized["Arathi Highlands"] = "아라시 고원";
	FAS_Localized["Ashenvale"] = "잿빛 골짜기";
	FAS_Localized["Azshara"] = "아즈샤라";
	FAS_Localized["Badlands"] = "황야의 땅";
	FAS_Localized["Blackrock Depths"] = "검은바위 나락";
	FAS_Localized["Blasted Lands"] = "저주받은 땅";
	FAS_Localized["Burning Steppes"] = "이글거리는 협곡";
	FAS_Localized["Darkshore"] = "어둠의 해안";
	FAS_Localized["Darnassus"] = "다르나서스";
	FAS_Localized["Desolace"] = "잊혀진 땅";
	FAS_Localized["Dire Maul"] = "혈투의 전장";
	FAS_Localized["Dun Morogh"] = "던 모로";
	FAS_Localized["Durotar"] = "듀로타";
	FAS_Localized["Duskwood"] = "그늘숲";
	FAS_Localized["Eastern Plaguelands"] = "동부 역병지대";
	FAS_Localized["Elwynn Forest"] = "엘윈숲";
	FAS_Localized["Felwood"] = "악령의 숲";
	FAS_Localized["Feralas"] = "페랄라스";
	FAS_Localized["Gnomeregan"] = "놈리건";
	FAS_Localized["Hillsbrad Foothills"] = "힐스브래드 구릉지";
	FAS_Localized["Ironforge"] = "아이언포지";
	FAS_Localized["Loch Modan"] = "모단 호수";
	FAS_Localized["Moonglade"] = "달의 숲";
	FAS_Localized["Mulgore"] = "멀고어";
	FAS_Localized["Orgrimmar"] = "오그리마";
	FAS_Localized["Redridge Mountains"] = "붉은마루 산맥";
	FAS_Localized["Silithus"] = "실리더스";
	FAS_Localized["Silverpine Forest"] = "은빛 소나무숲";
	FAS_Localized["Stonetalon Mountains"] = "돌발톱 산맥";
	FAS_Localized["Stormwind City"] = "스톰윈드";
	FAS_Localized["Stranglethorn Vale"] = "가시덤불 골짜기";
	FAS_Localized["Swamp of Sorrows"] = "슬픔의 늪";
	FAS_Localized["Tanaris"] = "타나리스";
	FAS_Localized["Teldrassil"] = "텔드랏실";
	FAS_Localized["The Barrens"] = "불모의 땅";
	FAS_Localized["The Hinterlands"] = "동부 내륙지";
	FAS_Localized["Thousand Needles"] = "버섯구름 봉우리";
	FAS_Localized["Thunder Bluff"] = "썬더 블러프";
	FAS_Localized["Tirisfal Glades"] = "티리스팔 숲";
	FAS_Localized["Un'Goro Crater"] = "운고로 분화구";
	FAS_Localized["Undercity"] = "언더시티";
	FAS_Localized["Wailing Caverns"] = "통곡의 동굴";
	FAS_Localized["Western Plaguelands"] = "서부 역병지대";
	FAS_Localized["Westfall"] = "서부 몰락지대";
	FAS_Localized["Wetlands"] = "저습지";

-- localized NPC names (only those that differ from the enUS version should be present)
	FAS_Localized["Abigail Shiel"] = "애비게일 시엘";
	FAS_Localized["Alchemist Pestlezugg"] = "연금술사 페슬저그";
	FAS_Localized["Alexandra Bolero"] = "알렉산드라 볼레로";
	FAS_Localized["Algernon"] = "알게르논";
	FAS_Localized["Amy Davenport"] = "트에이미 데이븐포";
	FAS_Localized["Andrew Hilbert"] = "앤드류 힐버트";
	FAS_Localized["Androd Fadran"] = "안드로드 패드랜";
	FAS_Localized["Argent Quartermaster Hasana"] = "은빛병참장교 하사나";
	FAS_Localized["Argent Quartermaster Lightspark"] = "은빛병참장교 라이트스파크";
	FAS_Localized["Balai Lok'Wein"] = "발라이 로크웨인";
	FAS_Localized["Bale"] = "베일";
	FAS_Localized["Banalash"] = "바나래쉬";
	FAS_Localized["Blimo Gadgetspring"] = "블리모 가젯스프링";
	FAS_Localized["Blixrez Goodstitch"] = "블릭스레즈 굿스티치";
	FAS_Localized["Bliztik"] = "블리즈틱";
	FAS_Localized["Bombus Finespindle"] = "봄부스 파인스핀들";
	FAS_Localized["Borya"] = "보르야";
	FAS_Localized["Brienna Starglow"] = "브리에나 스타글로";
	FAS_Localized["Bro'kin"] = "브로킨";
	FAS_Localized["Bronk"] = "브론크";
	FAS_Localized["Catherine Leland"] = "캐서린 릴랜드";
	FAS_Localized["Christoph Jeffcoat"] = "크리스토프 제프코트";
	FAS_Localized["Clyde Ranthal"] = "클라이드 랜덜";
	FAS_Localized["Constance Brisboise"] = "콘스턴스 브리스부아즈";
	FAS_Localized["Corporal Bluth"] = "하사관 블루스";
	FAS_Localized["Cowardly Crosby"] = "겁쟁이 크로스비";
	FAS_Localized["Crazk Sparks"] = "크라즈크 스팍스";
	FAS_Localized["Dalria"] = "달리아";
	FAS_Localized["Daniel Bartlett"] = "다니엘 바틀렛";
	FAS_Localized["Danielle Zipstitch"] = "다니엘 집스티치";
	FAS_Localized["Darian Singh"] = "다리안 싱그";
	FAS_Localized["Darnall"] = "다르날";
	FAS_Localized["Defias Profiteer"] = "데피아즈단 악덕업자";
	FAS_Localized["Deneb Walker"] = "데네브 워커";
	FAS_Localized["Derak Nightfall"] = "데락 나이트폴";
	FAS_Localized["Dirge Quikcleave"] = "더지 퀵클레이브";
	FAS_Localized["Drac Roughcut"] = "드락 러프컷";
	FAS_Localized["Drake Lindgren"] = "드레이크 린드그렌";
	FAS_Localized["Drovnar Strongbrew"] = "드로브나르 스트롱브루";
	FAS_Localized["Dustwallow Marsh"] = "먼지진흙 습지대";
	FAS_Localized["Elynna"] = "엘리나";
	FAS_Localized["Evie Whirlbrew"] = "에비 휠브루";
	FAS_Localized["Fradd Swiftgear"] = "프래드 스위프트기어";
	FAS_Localized["Gagsprocket"] = "객스프로켓";
	FAS_Localized["Gearcutter Cogspinner"] = "기어커터 코그스피너";
	FAS_Localized["George Candarte"] = "민간인 조지 칸다테";
	FAS_Localized["Gharash"] = "가라쉬";
	FAS_Localized["Ghok'kah"] = "그호카";
	FAS_Localized["Gigget Zipcoil"] = "기젯 집코일";
	FAS_Localized["Gikkix"] = "긱킥스";
	FAS_Localized["Gina MacGregor"] = "지나 맥그레거";
	FAS_Localized["Glyx Brewright"] = "글릭스 브루라이트";
	FAS_Localized["Gnaz Blunderflame"] = "그나즈 블런더플레임";
	FAS_Localized["Gretta Ganter"] = "그레타 간터";
	FAS_Localized["Grimtak"] = "그림탁";
	FAS_Localized["Hagrus"] = "하그루스";
	FAS_Localized["Hammon Karwn"] = "하몬 카른";
	FAS_Localized["Harggan"] = "하르간";
	FAS_Localized["Harklan Moongrove"] = "하클란 문그로브";
	FAS_Localized["Harlown Darkweave"] = "하론 다크위브";
	FAS_Localized["Harn Longcast"] = "한 롱캐스트 ";
	FAS_Localized["Heldan Galesong"] = "헬단 게일송";
	FAS_Localized["Helenia Olden"] = "헬레니아 올든";
	FAS_Localized["Himmik"] = "힘믹";
	FAS_Localized["Hula'mahi"] = "훌라마히";
	FAS_Localized["Jabbey"] = "재비";
	FAS_Localized["Jandia"] = "잔디아";
	FAS_Localized["Janet Hommers"] = "자넷 호머스";
	FAS_Localized["Jangdor Swiftstrider"] = "장도르 스위프트스트라이더";
	FAS_Localized["Jannos Ironwill"] = "야노스 아이언윌";
	FAS_Localized["Jaquilina Dramet"] = "자킬리나 드라메트";
	FAS_Localized["Jase Farlane"] = "제이스 파레인";
	FAS_Localized["Jazzrik"] = "자즈릭";
	FAS_Localized["Jeeda"] = "지다";
	FAS_Localized["Jennabink Powerseam"] = "제나빙크 파워심";
	FAS_Localized["Jessara Cordell"] = "예사라 코르델";
	FAS_Localized["Jinky Twizzlefixxit"] = "진키 트위즐픽시트";
	FAS_Localized["Joseph Moore"] = "조셉 무어";
	FAS_Localized["Jubie Gadgetspring"] = "주비 가젯스프링";
	FAS_Localized["Jun'ha"] = "준하";
	FAS_Localized["Jutak"] = "주타크";
	FAS_Localized["Kaita Deepforge"] = "카이타 딥포지";
	FAS_Localized["Kalldan Felmoon"] = "칼단 펠문";
	FAS_Localized["Keena"] = "키나";
	FAS_Localized["Kelsey Yance"] = "켈시 얀스";
	FAS_Localized["Kendor Kabonka"] = "켄로드 카본카";
	FAS_Localized["Khara Deepwater"] = "카라 딥워터";
	FAS_Localized["Kiknikle"] = "킥니클";
	FAS_Localized["Killian Sanatha"] = "킬리안 사나타";
	FAS_Localized["Kilxx"] = "킬륵스";
	FAS_Localized["Kireena"] = "키리나";
	FAS_Localized["Kithas"] = "키타스";
	FAS_Localized["Knaz Blunderflame"] = "크나즈 블런더플레임";
	FAS_Localized["Kor'geld"] = "코르겔드";
	FAS_Localized["Kriggon Talsone"] = "크리곤 달손";
	FAS_Localized["Krinkle Goodsteel"] = "크린클 굿스틸";
	FAS_Localized["Kulwia"] = "쿨위아";
	FAS_Localized["Kzixx"] = "크직스";
	FAS_Localized["Laird"] = "레어드";
	FAS_Localized["Lardan"] = "라르단";
	FAS_Localized["Leo Sarn"] = "레오 사른";
	FAS_Localized["Leonard Porter"] = "레오나드 포터";
	FAS_Localized["Lilly"] = "릴리";
	FAS_Localized["Lindea Rabonne"] = "린디아 라본느";
	FAS_Localized["Lizbeth Cromwell"] = "리즈베스 크롬웰";
	FAS_Localized["Logannas"] = "로간나스";
	FAS_Localized["Lokhtos Darkbargainer"] = "로크토스 아크바게이너";
	FAS_Localized["Lorekeeper Lydros"] = "현자 리드로스";
	FAS_Localized["Lorelae Wintersong"] = "로렐라이 윈터송";
	FAS_Localized["Magnus Frostwake"] = "마그누스 프로스트웨이크";
	FAS_Localized["Mahu"] = "마후";
	FAS_Localized["Mallen Swain"] = "말렌스웨인";
	FAS_Localized["Malygen"] = "말리젠";
	FAS_Localized["Maria Lumere"] = "마리아 루메르";
	FAS_Localized["Martine Tramblay"] = "마틴 트램블레이";
	FAS_Localized["Masat T'andr"] = "마사트 탄드르";
	FAS_Localized["Mathredis Firestar"] = "마스레디스 파이어스타";
	FAS_Localized["Mavralyn"] = "마브라린";
	FAS_Localized["Mazk Snipeshot"] = "마즈크 스나이프샷";
	FAS_Localized["Meilosh"] = "메일로쉬";
	FAS_Localized["Micha Yance"] = "미카 얀스";
	FAS_Localized["Millie Gregorian"] = "밀리 그레고리안";
	FAS_Localized["Montarr"] = "몬타르";
	FAS_Localized["Muuran"] = "무란";
	FAS_Localized["Mythrin'dir"] = "미스린디르";
	FAS_Localized["Naal Mistrunner"] = "나알 미스트러너";
	FAS_Localized["Namdo Bizzfizzle"] = "남도 비즈피즐";
	FAS_Localized["Nandar Branson"] = "난다르 브랜슨";
	FAS_Localized["Narj Deepslice"] = "나르 딥슬라이스";
	FAS_Localized["Narkk"] = "나르크";
	FAS_Localized["Nata Dawnstrider"] = "나타 던스트라이더";
	FAS_Localized["Nergal"] = "네르갈";
	FAS_Localized["Nerrist"] = "네리스트";
	FAS_Localized["Nessa Shadowsong"] = "네사 섀도송";
	FAS_Localized["Nina Lightbrew"] = "니나 라이트브루";
	FAS_Localized["Nioma"] = "니오마";
	FAS_Localized["Nyoma"] = "니오마";
	FAS_Localized["Ogg'marr"] = "오그마르";
	FAS_Localized["Old Man Heming"] = "노인 헤밍";
	FAS_Localized["Outfitter Eric"] = "제단사 에릭";
	FAS_Localized["Plugger Spazzring"] = "플러거 스파즈링";
	FAS_Localized["Pratt McGrubben"] = "프랫 맥그루벤";
	FAS_Localized["Qia"] = "퀴아";
	FAS_Localized["Quartermaster Miranda Breechlock"] = "병참장교 미란다 브리치락";
	FAS_Localized["Ranik"] = "래니크";
	FAS_Localized["Rann Flamespinner"] = "랜 플레임스피너";
	FAS_Localized["Rartar"] = "라르타르";
	FAS_Localized["Rikqiz"] = "릭키즈";
	FAS_Localized["Rin'wosho the Trader"] = "상인 린워쇼";
	FAS_Localized["Rizz Loosebolt"] = "리즈 루즈볼트";
	FAS_Localized["Ronald Burch"] = "로널드 버치";
	FAS_Localized["Ruppo Zipcoil"] = "루포 집코일";
	FAS_Localized["Saenorion"] = "새노리온";
	FAS_Localized["Sewa Mistrunner"] = "세와 미스트러너";
	FAS_Localized["Shandrina"] = "샨드리나";
	FAS_Localized["Shankys"] = "샨키스";
	FAS_Localized["Sheendra Tallgrass"] = "신드라 톨그래스";
	FAS_Localized["Shen'dralar Provisioner"] = "셴드랄라 고대인";
	FAS_Localized["Sheri Zipstitch"] = "셰리 집스티치";
	FAS_Localized["Soolie Berryfizz"] = "술리 배리피즈";
	FAS_Localized["Sovik"] = "소빅";
	FAS_Localized["Stuart Fleming"] = "스튜어트 플레밍";
	FAS_Localized["Sumi"] = "수미";
	FAS_Localized["Super-Seller 680"] = "슈퍼 판매기 680";
	FAS_Localized["Tamar"] = "타마르";
	FAS_Localized["Tansy Puddlefizz"] = "탄지 퍼들피즈";
	FAS_Localized["Tari'qa"] = "타리카";
	FAS_Localized["Thaddeus Webb"] = "타데우스 웨브";
	FAS_Localized["Tharynn Bouden"] = "타린 바우던";
	FAS_Localized["Tilli Thistlefuzz"] = "틸리 시슬퍼즈";
	FAS_Localized["Truk Wildbeard"] = "트루크 와일드바이드";
	FAS_Localized["Tunkk"] = "텅크";
	FAS_Localized["Ulthaan"] = "울샨";
	FAS_Localized["Ulthir"] = "울시르";
	FAS_Localized["Uthok"] = "우톡";
	FAS_Localized["Vaean"] = "바이안";
	FAS_Localized["Valdaron"] = "발다론";
	FAS_Localized["Veenix"] = "비닉스";
	FAS_Localized["Vendor-Tron 1000"] = "자동 판매기 1000";
	FAS_Localized["Vharr"] = "바르";
	FAS_Localized["Vivianna"] = "비비안나";
	FAS_Localized["Vizzklick"] = "비즈클릭";
	FAS_Localized["Wenna Silkbeard"] = "웨나 실크비어드";
	FAS_Localized["Werg Thickblade"] = "웨르그 틱블레이드";
	FAS_Localized["Wik'Tar"] = "위크타르";
	FAS_Localized["Winterspring"] = "여명의 설원";
	FAS_Localized["Worb Strongstitch"] = "워브 스트롱스티치";
	FAS_Localized["Wrahk"] = "레이크";
	FAS_Localized["Wulan"] = "울란";
	FAS_Localized["Wunna Darkmane"] = "우나 다크메인";
	FAS_Localized["Xandar Goodbeard"] = "샨다르 굿비어드";
	FAS_Localized["Xizk Goodstitch"] = "시즈크 굿스티치";
	FAS_Localized["Xizzer Fizzbolt"] = "시저 피즈볼트";
	FAS_Localized["Yonada"] = "요나다";
	FAS_Localized["Yuka Screwspigot"] = "유카 스크류스피곳";
	FAS_Localized["Zan Shivsproket"] = "잰 쉬브스프로켓";
	FAS_Localized["Zannok Hidepiercer"] = "잔노크 하이드피이서";
	FAS_Localized["Zansoa"] = "잔소아";
	FAS_Localized["Zarena Cromwind"] = "자레나 크롬윈드";
	FAS_Localized["Zargh"] = "자르그";
	FAS_Localized["Zixil"] = "직실";

-- localized libram descriptions
	FAS_Localized["+8 any single stat"] = "+8 원하는 스탯 한가지";
	FAS_Localized["+100 Health"] = "+100 생명력";
	FAS_Localized["+150 Mana"] = "+150 마나";
	FAS_Localized["+20 Fire Resistance"] = "+20 화염저항";
	FAS_Localized["+125 Armor"] = "+125 방어도";
	FAS_Localized["+1% Haste"] = "+1% 공격속도";
	FAS_Localized["+1% Dodge"] = "+1% 회피율";
	FAS_Localized["+8 Spell damage/healing"] = "+8 치유 효과와 주문의 피해";

-- localized special raid loot tokens
	FAS_Localized["Zulian Coin"]		=	"줄리안부족 주화";
	FAS_Localized["Razzashi Coin"]		=	"래즈자쉬부족 주화";
	FAS_Localized["Hakkari Coin"]		=	"학카리부족 주화";
	FAS_Localized["Gurubashi Coin"]		=	"구루바시부족 주화";
	FAS_Localized["Vilebranch Coin"]	=	"썩은가지부족 주화";
	FAS_Localized["Witherbark Coin"]	=	"마른나무껍질부족 주화";
	FAS_Localized["Sandfury Coin"]		=	"성난모래부족 주화";
	FAS_Localized["Skullsplitter Coin"]	=	"백골가루부족 주화";
	FAS_Localized["Bloodscalp Coin"]	=	"붉은머리부족 주화";
            
	FAS_Localized["Red Hakkari Bijou"]		=	"붉은색 학카리 장신구";
	FAS_Localized["Blue Hakkari Bijou"]		=	"파란색 학카리 장신구";
	FAS_Localized["Yellow Hakkari Bijou"]	=	"노란색 학카리 장신구";
	FAS_Localized["Orange Hakkari Bijou"]	=	"주황색 학카리 장신구";
	FAS_Localized["Green Hakkari Bijou"]	=	"녹색 학카리 장신구";
	FAS_Localized["Purple Hakkari Bijou"]	=	"보라색 학카리 장신구";
	FAS_Localized["Bronze Hakkari Bijou"]	=	"청동색 학카리 장신구";
	FAS_Localized["Silver Hakkari Bijou"]	=	"은색 학카리 장신구";
	FAS_Localized["Gold Hakkari Bijou"]		=	"황금색 학카리 장신구";
            
	FAS_Localized["Primal Hakkari Bindings"]	=	"고대 학카리 팔보호구";
	FAS_Localized["Primal Hakkari Armsplint"]	=	"고대 학카리 어깨갑옷";
	FAS_Localized["Primal Hakkari Stanchion"]	=	"고대 학카리 손목갑옷";
	FAS_Localized["Primal Hakkari Girdle"]		=	"고대 학카리 벨트";
	FAS_Localized["Primal Hakkari Sash"]		=	"고대 학카리 장식띠";
	FAS_Localized["Primal Hakkari Shawl"]		=	"고대 학카리 어깨걸이";
	FAS_Localized["Primal Hakkari Tabard"]		=	"고대 학카리 휘장";
	FAS_Localized["Primal Hakkari Kossack"]		=	"고대 학카리 조끼";
	FAS_Localized["Primal Hakkari Aegis"]		=	"고대 학카리 아이기스";
            
	FAS_Localized["Qiraji Magisterial Ring"]	=	"권위의 퀴라지 반지";
	FAS_Localized["Qiraji Ceremonial Ring"]		=	"의식의 퀴라지 반지";
	FAS_Localized["Qiraji Martial Drape"]		=	"전쟁의 퀴라지 망토";
--	FAS_Localized["Qiraji Regal Drape"]			=	"xxxxx";
	FAS_Localized["Qiraji Spiked Hilt"]			=	"못박힌 퀴라지 자루";
	FAS_Localized["Qiraji Ornate Hilt"]			=	"화려한 퀴라지 자루";
            
	FAS_Localized["Imperial Qiraji Armaments"]	=	"제국의 퀴라지 무기";
--	FAS_Localized["Imperial Qiraji Regalia"]	=	"xxxxx";
            
	FAS_Localized["Qiraji Bindings of Command"]		=	"지휘의 퀴라지 팔보호구";
--	FAS_Localized["Qiraji Bindings of Dominance"]	=	"xxxxx";
	FAS_Localized["Ouro's Intact Hide"]				=	"온전한 아우로의 가죽";
--	FAS_Localized["Skin of the Great Sandworm"]		=	"xxxxx";
--	FAS_Localized["Vek'lor's Diadem"]				=	"xxxxx";
	FAS_Localized["Vek'nilash's Circlet"]			=	"베크닐라쉬의 관";
--	FAS_Localized["Carapace of the Old God"]		=	"xxxxx";
--	FAS_Localized["Husk of the Old God"]			=	"xxxxx";
            
	FAS_Localized["Stone Scarab"]	=	"돌 스카라베";
	FAS_Localized["Gold Scarab"]	=	"황금 스카라베";
	FAS_Localized["Silver Scarab"]	=	"은 스카라베";
	FAS_Localized["Bronze Scarab"]	=	"청동 스카라베";
	FAS_Localized["Crystal Scarab"]	=	"수정 스카라베";
	FAS_Localized["Clay Scarab"]	=	"찰흙 스카라베";
	FAS_Localized["Bone Scarab"]	=	"뼈 스카라베";
	FAS_Localized["Ivory Scarab"]	=	"상아 스카라베";
            
	FAS_Localized["Azure Idol"]			=	"청금석 우상";
	FAS_Localized["Onyx Idol"]			=	"마노 우상";
	FAS_Localized["Lambent Idol"]		=	"미명석 우상";
	FAS_Localized["Amber Idol"]			=	"호박석 우상";
	FAS_Localized["Jasper Idol"]		=	"벽옥 우상";
	FAS_Localized["Obsidian Idol"]		=	"흑요석 우상";
	FAS_Localized["Vermillion Idol"]	=	"단사 우상";
	FAS_Localized["Alabaster Idol"]		=	"설화석 우상";
            
	FAS_Localized["Idol of the Sun"]	=	"태양의 우상";
	FAS_Localized["Idol of Night"]		=	"밤의 우상";
	FAS_Localized["Idol of Death"]		=	"죽음의 우상";
	FAS_Localized["Idol of the Sage"]	=	"현자의 우상";
	FAS_Localized["Idol of Rebirth"]	=	"환생의 우상";
--	FAS_Localized["Idol of Life"]		=	"xxxxx";
--	FAS_Localized["Idol of Strife"]		=	"xxxxx";
	FAS_Localized["Idol of War"]		=	"전쟁의 우상";

end

if ( GetLocale() == "frFR" ) then

-- localized special raid loot tokens
	FAS_Localized["Zulian Coin"]		=	"Pièce zulienne";
	FAS_Localized["Razzashi Coin"]		=	"Pièce Razzashi";
	FAS_Localized["Hakkari Coin"]		=	"Pièce hakkari";
	FAS_Localized["Gurubashi Coin"]		=	"Pièce Gurubashi";
	FAS_Localized["Vilebranch Coin"]	=	"Pièce Vilebranch";
	FAS_Localized["Witherbark Coin"]	=	"Pièce Witherbark";
	FAS_Localized["Sandfury Coin"]		=	"Pièce Sandfury";
	FAS_Localized["Skullsplitter Coin"]	=	"Pièce Skullsplitter";
	FAS_Localized["Bloodscalp Coin"]	=	"Pièce Bloodscalp";
            
	FAS_Localized["Red Hakkari Bijou"]		=	"Bijou hakkari rouge";
	FAS_Localized["Blue Hakkari Bijou"]		=	"Bijou hakkari bleu";
	FAS_Localized["Yellow Hakkari Bijou"]	=	"Bijou hakkari jaune";
	FAS_Localized["Orange Hakkari Bijou"]	=	"Bijou hakkari orange";
	FAS_Localized["Green Hakkari Bijou"]	=	"Bijou hakkari vert";
	FAS_Localized["Purple Hakkari Bijou"]	=	"Bijou hakkari violet";
	FAS_Localized["Bronze Hakkari Bijou"]	=	"Bijou hakkari bronze";
	FAS_Localized["Silver Hakkari Bijou"]	=	"Bijou hakkari argenté";
	FAS_Localized["Gold Hakkari Bijou"]		=	"Bijou hakkari doré";
            
	FAS_Localized["Primal Hakkari Bindings"]	=	"Manchettes primordiales hakkari";
	FAS_Localized["Primal Hakkari Armsplint"]	=	"Brassards primordiaux hakkari";
	FAS_Localized["Primal Hakkari Stanchion"]	=	"Etançon primordial hakkari";
	FAS_Localized["Primal Hakkari Girdle"]		=	"Ceinturon primordial hakkari";
	FAS_Localized["Primal Hakkari Sash"]		=	"Echarpe primordiale hakkari";
	FAS_Localized["Primal Hakkari Shawl"]		=	"Châle primordial hakkari";
	FAS_Localized["Primal Hakkari Tabard"]		=	"Tabard primordial hakkari";
	FAS_Localized["Primal Hakkari Kossack"]		=	"Casaque primordiale hakkari";
	FAS_Localized["Primal Hakkari Aegis"]		=	"Egide primordiale hakkari";
            
	FAS_Localized["Qiraji Magisterial Ring"]	=	"Anneau de magistrat qiraji";
	FAS_Localized["Qiraji Ceremonial Ring"]		=	"Anneau de cérémonie qiraji";
	FAS_Localized["Qiraji Martial Drape"]		=	"Drapé martial qiraji";
	FAS_Localized["Qiraji Regal Drape"]			=	"Drapé royal qiraji";
	FAS_Localized["Qiraji Spiked Hilt"]			=	"Drapé royal qiraji";
	FAS_Localized["Qiraji Ornate Hilt"]			=	"Manche orné";
            
	FAS_Localized["Imperial Qiraji Armaments"]	=	"Armes impériales qiraji";
	FAS_Localized["Imperial Qiraji Regalia"]	=	"Tenue de parade impériale qiraji";
            
	FAS_Localized["Qiraji Bindings of Command"]		=	"Manchettes de commandement qiraji";
	FAS_Localized["Qiraji Bindings of Dominance"]	=	"Manchettes de domination qiraji";
	FAS_Localized["Ouro's Intact Hide"]				=	"Peau intacte d'Ouro";
	FAS_Localized["Skin of the Great Sandworm"]		=	"Peau du Grand ver des sables";
	FAS_Localized["Vek'lor's Diadem"]				=	"Diadème de Vek'lor";
	FAS_Localized["Vek'nilash's Circlet"]			=	"Diadème de Vek'nilash";
	FAS_Localized["Carapace of the Old God"]		=	"Carapace du Dieu très ancien";
	FAS_Localized["Husk of the Old God"]			=	"Carcasse du Dieu très ancien";
            
	FAS_Localized["Stone Scarab"]	=	"Scarabée de pierre";
	FAS_Localized["Gold Scarab"]	=	"Scarabée d'or";
	FAS_Localized["Silver Scarab"]	=	"Scarabée d'argent";
	FAS_Localized["Bronze Scarab"]	=	"Scarabée de bronze";
	FAS_Localized["Crystal Scarab"]	=	"Scarabée de cristal";
	FAS_Localized["Clay Scarab"]	=	"Scarabée d'argile";
	FAS_Localized["Bone Scarab"]	=	"Scarabée d'os";
	FAS_Localized["Ivory Scarab"]	=	"Scarabée d'ivoire";
            
	FAS_Localized["Azure Idol"]			=	"Idole azur";
	FAS_Localized["Onyx Idol"]			=	"Idole d'onyx";
	FAS_Localized["Lambent Idol"]		=	"Idole brillante";
	FAS_Localized["Amber Idol"]			=	"Idole d'ambre";
	FAS_Localized["Jasper Idol"]		=	"Idole de jaspe";
	FAS_Localized["Obsidian Idol"]		=	"Idole d'obsidienne";
	FAS_Localized["Vermillion Idol"]	=	"Idole vermillon";
	FAS_Localized["Alabaster Idol"]		=	"Idole d'albâtre";
            
	FAS_Localized["Idol of the Sun"]	=	"Idole du soleil";
	FAS_Localized["Idol of Night"]		=	"Idole de la nuit";
	FAS_Localized["Idol of Death"]		=	"Idole de la mort";
	FAS_Localized["Idol of the Sage"]	=	"Idole du sage";
	FAS_Localized["Idol of Rebirth"]	=	"Idole de la renaissance";
	FAS_Localized["Idol of Life"]		=	"Idole de la vie";
	FAS_Localized["Idol of Strife"]		=	"Idole de la lutte";
	FAS_Localized["Idol of War"]		=	"Idole de la guerre";

end
