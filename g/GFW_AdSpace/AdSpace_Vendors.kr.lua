------------------------------------------------------
-- AdSpace_Vendors.lua
-- Originally based on the tables at http://members.cox.net/katy-w/Trades/Home.htm
-- Corrected / extended with info from http://wow.allakhazam.com and http://wowguru.com
------------------------------------------------------
-- LOCALIZATION NOTE: the english recipe names in here are just comments;
--  it won't do anything in-game if you translate them.
------------------------------------------------------

if (GetLocale() == "koKR") then

FAS_VendorLocations = {
-- not actually splitting this up by faction, but I've got it sorted that way in case I decide to later.
--	["Alliance"] = {
		["알렉산드라 볼레로"] = "스톰윈드",
		["트에이미 데이븐포"] = "붉은마루 산맥",
		["안드로드 패드랜"] = "아라시 고원",
		["블리모 가젯스프링"] = "아즈샤라",
		["봄부스 파인스핀들"] = "아이언포지",
		["브리에나 스타글로"] = "페랄라스",
		["캐서린 릴랜드"] = "스톰윈드",
		["클라이드 랜덜"] = "붉은마루 산맥",
		["하사관 블루스"] = "가시덤불 골짜기",
		["달리아"] = "잿빛 골짜기",
		["다니엘 집스티치"] = "그늘숲",
		["다리안 싱그"] = "스톰윈드",
		["데피아즈단 악덕업자"] = "서부 몰락지대",
		["데네브 워커"] = "아라시 고원",
		["드락 러프컷"] = "모단 호수",
		["드레이크 린드그렌"] = "엘윈숲",
		["드로브나르 스트롱브루"] = "아라시 고원",
		["엘리나"] = "다르나서스",
		["프래드 스위프트기어"] = "저습지",
		["기어커터 코그스피너"] = "아이언포지",
		["기젯 집코일"] = "동부 내륙지",
		["지나 맥그레거"] = "서부 몰락지대",
		["그레타 간터"] = "던 모로",
		["하몬 카른"] = "아라시 고원",
		["하르간"] = "동부 내륙지",
		["하클란 문그로브"] = "잿빛 골짜기",
		["하론 다크위브"] = "잿빛 골짜기",
		["헬단 게일송"] = "어둠의 해안",
		["헬레니아 올든"] = "먼지진흙 습지대",
		["자넷 호머스"] = "잊혀진 땅",
		["야노스 아이언윌"] = "아라시 고원",
		["제나빙크 파워심"] = "저습지",
		["랜 플레임스피너"] = "모단 호수",
		["예사라 코르델"] = "스톰윈드",
		["주비 가젯스프링"] = "아즈샤라",
		["카이타 딥포지"] = "스톰윈드",
		["켄로드 카본카"] = "스톰윈드",
		["카라 딥워터"] = "모단 호수",
		["Khole Jinglepocket"] = "스톰윈드",
		["크리곤 달손"] = "서부 몰락지대",
		["레어드"] = "어둠의 해안",
		["라르단"] = "잿빛 골짜기",
		["레오나드 포터"] = "서부 역병지대",
		["린디아 라본느"] = "힐스브래드 구릉지",
		["로간나스"] = "페랄라스",
		["말리젠"] = "악령의 숲",
		["마리아 루메르"] = "스톰윈드",
		["마브라린"] = "어둠의 해안",
		["미카 얀스"] = "힐스브래드 구릉지",
		["미스린디르"] = "다르나서스",
		["남도 비즈피즐"] = "놈리건",
		["난다르 브랜슨"] = "힐스브래드 구릉지",
		["나르 딥슬라이스"] = "아라시 고원",
		["네사 섀도송"] = "텔드랏실",
		["니나 라이트브루"] = "저주받은 땅",
		["니오마"] = "동부 내륙지",
		["니오마"] = "텔드랏실",
		["제단사 에릭"] = "아이언포지",
		["프랫 맥그루벤"] = "페랄라스",
		["랜 플레임스피너"] = "모단 호수",
		["루포 집코일"] = "동부 내륙지",
		["새노리온"] = "다르나서스",
		["샨드리나"] = "잿빛 골짜기",
		["셰리 집스티치"] = "그늘숲",
		["술리 배리피즈"] = "아이언포지",
		["스튜어트 플레밍"] = "저습지",
		["탄지 퍼들피즈"] = "아이언포지",
		["타린 바우던"] = "엘윈숲",
		["틸리 시슬퍼즈"] = "아이언포지",
		["트루크 와일드바이드"] = "동부 내륙지",
		["울샨"] = "잿빛 골짜기",
		["울시르"] = "다르나서스",
    ["바이안"] = "다르나서스",
		["발다론"] = "어둠의 해안",
		["비비안나"] = "페랄라스",
		["웨나 실크비어드"] = "저습지",
		["Wulmort Jinglepocket"] = "아이언포지",
		["샨다르 굿비어드"] = "모단 호수",
--	},
--	["Horde"] = {
		["애비게일 시엘"] = "티리스팔 숲",
		["알게르논"] = "언더시티",
		["앤드류 힐버트"] = "은빛 소나무숲",
		["발라이 로크웨인"] = "먼지진흙 습지대",
		["베일"] = "악령의 숲",
		["바나래쉬"] = "슬픔의 늪",
		["보르야"] = "오그리마",
		["브론크"] = "페랄라스",
		["크리스토프 제프코트"] = "힐스브래드 구릉지",
		["콘스턴스 브리스부아즈"] = "티리스팔 숲",
		["다니엘 바틀렛"] = "언더시티",
		["데락 나이트폴"] = "힐스브래드 구릉지",
		["민간인 조지 칸다테"] = "힐스브래드 구릉지",
		["가라쉬"] = "슬픔의 늪",
		["그호카"] = "먼지진흙 습지대",
		["그림탁"] = "듀로타",
		["하그루스"] = "오그리마",
		["한 롱캐스트 "] = "멀고어",
		["훌라마히"] = "불모의 땅",
		["잔디아"] = "버섯구름 봉우리",
		["장도르 스위프트스트라이더"] = "페랄라스",
		["지다"] = "돌발톱 산맥",
		["조셉 무어"] = "언더시티",
		["준하"] = "아라시 고원",
		["키나"] = "아라시 고원",
		["킬리안 사나타"] = "은빛 소나무숲",
		["키리나"] = "잊혀진 땅",
		["키타스"] = "오그리마",
		["코르겔드"] = "오그리마",
		["쿨위아"] = "돌발톱 산맥",
		["레오 사른"] = "은빛 소나무숲",
		["릴리"] = "은빛 소나무숲",
		["리즈베스 크롬웰"] = "언더시티",
		["마후"] = "썬더 블러프",
		["말렌스웨인"] = "힐스브래드 구릉지",
		["마틴 트램블레이"] = "티리스팔 숲",
		["밀리 그레고리안"] = "언더시티",
		["몬타르"] = "버섯구름 봉우리",
		["무란"] = "잊혀진 땅",
		["나알 미스트러너"] = "썬더 블러프",
		["나타 던스트라이더"] = "썬더 블러프",
		["네리스트"] = "가시덤불 골짜기",
		["오그마르"] = "먼지진흙 습지대",
		["Penney Copperpinch"] = "오그리마",
		["라르타르"] = "슬픔의 늪",
		["로널드 버치"] = "언더시티",
		["세와 미스트러너"] = "썬더 블러프",
		["샨키스"] = "오그리마",
		["신드라 톨그래스"] = "페랄라스",
		["소빅"] = "오그리마",
		["수미"] = "오그리마",
		["타마르"] = "오그리마",
		["타리카"] = "불모의 땅",
		["타데우스 웨브"] = "언더시티",
		["텅크"] = "아라시 고원",
		["우톡"] = "가시덤불 골짜기",
		["바르"] = "가시덤불 골짜기",
		["웨르그 틱블레이드"] = "티리스팔 숲",
		["위크타르"] = "잿빛 골짜기",
		["워브 스트롱스티치"] = "페랄라스",
		["레이크"] = "불모의 땅",
		["울란"] = "잊혀진 땅",
		["우나 다크메인"] = "멀고어",
		["요나다"] = "불모의 땅",
		["잔소아"] = "듀로타",
		["자르그"] = "불모의 땅",
--	},
--	["Neutral"] = {
		["연금술사 페슬저그"] = "타나리스",
		["은빛병참장교 하사나"] = "티리스팔 숲",
		["은빛병참장교 라이트스파크"] = "서부 역병지대",
		["블릭스레즈 굿스티치"] = "가시덤불 골짜기",
		["블리즈틱"] = "그늘숲",
		["브로킨"] = "알터랙 산맥",
		["겁쟁이 크로스비"] = "가시덤불 골짜기",
		["크라즈크 스팍스"] = "가시덤불 골짜기",
		["다르날"] = "달의 숲",
		["더지 퀵클레이브"] = "타나리스",
		["에비 휠브루"] = "여명의 설원",
		["객스프로켓"] = "불모의 땅",
		["긱킥스"] = "타나리스",
		["글릭스 브루라이트"] = "가시덤불 골짜기",
		["그나즈 블런더플레임"] = "가시덤불 골짜기",
		["힘믹"] = "여명의 설원",
		["재비"] = "타나리스",
		["자킬리나 드라메트"] = "가시덤불 골짜기",
		["제이스 파레인"] = "동부 역병지대",
		["자즈릭"] = "황야의 땅",
		["진키 트위즐픽시트"] = "버섯구름 봉우리",
		["주타크"] = "가시덤불 골짜기",
		["칼단 펠문"] = "통곡의 동굴",
		["켈시 얀스"] = "가시덤불 골짜기",
		["킥니클"] = "불모의 땅",
		["킬륵스"] = "불모의 땅",
		["크나즈 블런더플레임"] = "가시덤불 골짜기",
		["크린클 굿스틸"] = "타나리스",
		["크직스"] = "그늘숲",
		["로크토스 아크바게이너"] = "검은바위 나락",
		["로렐라이 윈터송"] = "달의 숲",
		["마그누스 프로스트웨이크"] = "서부 역병지대",
		["마사트 탄드르"] = "슬픔의 늪",
		["마즈크 스나이프샷"] = "가시덤불 골짜기",
		["메일로쉬"] = "악령의 숲",
		["나르크"] = "가시덤불 골짜기",
		["네르갈"] = "운고로 분화구",
		["노인 헤밍"] = "가시덤불 골짜기",
		["플러거 스파즈링"] = "검은바위 나락",
		["퀴아"] = "여명의 설원",
		["병참장교 미란다 브리치락"] = "동부 역병지대",
		["래니크"] = "불모의 땅",
		["릭키즈"] = "가시덤불 골짜기",
		["리즈 루즈볼트"] = "알터랙 산맥",
		["셴드랄라 고대인"] = "혈투의 전장",
		["슈퍼 판매기 680"] = "잊혀진 땅",
		["비닉스"] = "돌발톱 산맥",
		["자동 판매기 1000"] = "잊혀진 땅",
		["비즈클릭"] = "타나리스",
		["시즈크 굿스티치"] = "가시덤불 골짜기",
		["시저 피즈볼트"] = "여명의 설원",
		["유카 스크류스피곳"] = "이글거리는 협곡",
		["잰 쉬브스프로켓"] = "힐스브래드 구릉지",
		["잔노크 하이드피이서"] = "실리더스",
		["자레나 크롬윈드"] = "가시덤불 골짜기",
		["직실"] = "힐스브래드 구릉지",
		["상인 린워쇼"] = "요잠바 섬",

		
-- Libram turnin NPCs
		["현자 리드로스"] = "혈투의 전장",
		["마스레디스 파이어스타"] = "이글거리는 협곡",

--	},
};

FAS_VendorInfo = {
	["Alliance"] = {
	-- Alchemy
		[9300]	= { "니나 라이트브루" },						-- Recipe: Elixir of Demonslaying
		[9301]	= { "마리아 루메르" },						-- Recipe: Elixir of Shadow Power
		[13478]	= { "술리 배리피즈" },					-- Recipe: Elixir of Superior Defense
		[6055]	= { "난다르 브랜슨" },						-- Recipe: Fire Protection Potion
		[5642]	= { "술리 배리피즈", "울시르" },			-- Recipe: Free Action Potion
		[6056]	= { "드로브나르 스트롱브루" },					-- Recipe: Frost Protection Potion
		[9302]	= { "로간나스" },							-- Recipe: Ghost Dye
		[5643]	= { "울시르" },								-- Recipe: Great Rage Potion
		[6053]	= { "샨다르 굿비어드" },					-- Recipe: Holy Protection Potion
		[6057]	= { "로간나스" },							-- Recipe: Nature Protection Potion
		[5640]	= { "데피아즈단 악덕업자", "샨다르 굿비어드", "하클란 문그로브" },	-- Recipe: Rage Potion
		[13477]	= { "울시르" },														-- Recipe: Superior Mana Potion
		
	-- Blacksmithing
		[12162]	= { "카이타 딥포지"},		-- Plans: Hardened Iron Shortsword
		[7995]	= { "하르간" },			-- Plans: Mithril Scale Bracers
		[10858]	= { "야노스 아이언윌" },	-- Plans: Solid Iron Maul

	-- Enchanting
		[6349]	= { "틸리 시슬퍼즈" },								-- Formula: Enchant 2H Weapon - Lesser Intellect
		[11223]	= { "미스린디르" },									-- Formula: Enchant Bracer - Deflection
		[11163]	= { "미카 얀스" },									-- Formula: Enchant Bracer - Lesser Deflection
		[11101]	= { "달리아" },											-- Formula: Enchant Bracer - Lesser Strength
		[6342]	= { "예사라 코르델", "틸리 시슬퍼즈", "바이안" },	-- Formula: Enchant Chest - Minor Mana
		[11039]	= { "달리아" },											-- Formula: Enchant Cloak - Minor Agility
		[11152]	= { "타린 바우던" },									-- Formula: Enchant Gloves - Fishing
		[16217]	= { "미스린디르" },									-- Formula: Enchant Shield - Greater Stamina

	-- Engineering
		[18649]	= { "다리안 싱그", "기어커터 코그스피너" },	-- Schematic: Blue Firework
		[10607]	= { "주비 가젯스프링" },						-- Schematic: Deepdive Helmet
		[7560]	= { "기어커터 코그스피너" },					-- Schematic: Gnomish Universal Remote
		[13309]	= { "프래드 스위프트기어" },						-- Schematic: Lovingly Crafted Boomstick
		[14639]	= { "프래드 스위프트기어", "남도 비즈피즐" },	-- Schematic: Minor Recombobulator
		[10609]	= { "루포 집코일" },							-- Schematic: Mithril Mechanical Dragonling
		[16041]	= { "기어커터 코그스피너" },					-- Schematic: Thorium Grenade
		[16042]	= { "기어커터 코그스피너" },					-- Schematic: Thorium Widget

	-- Leatherworking
		[18949]	= { "새노리온" },						-- Pattern: Barbaric Bracers
		[5973]	= { "하몬 카른", "라르단" },			-- Pattern: Barbaric Leggings
		[7289]	= { "클라이드 랜덜" },					-- Pattern: Black Whelp Cloak
		[15751]	= { "블리모 가젯스프링" },				-- Pattern: Blue Dragonscale Breastplate
		[15729]	= { "블리모 가젯스프링" },				-- Pattern: Chimeric Gloves
		[7613]	= { "웨나 실크비어드" },				-- Pattern: Green Leather Armor
		[7451]	= { "프랫 맥그루벤", "새노리온" },	-- Pattern: Green Whelp Bracers
		[18731]	= { "봄부스 파인스핀들" },				-- Pattern: Heavy Leather Ball
		[7361]	= { "하론 다크위브" },				-- Pattern: Herbalist's Gloves
		[15735]	= { "기젯 집코일" },					-- Pattern: Ironfeather Shoulders
		[15734]	= { "프랫 맥그루벤" },				-- Pattern: Living Shoulders
		[5786]	= { "지나 맥그레거", "마브라린" },		-- Pattern: Murloc Scale Belt
		[5789]	= { "헬레니아 올든" },					-- Pattern: Murloc Scale Bracers
		[5787]	= { "지나 맥그레거", "마브라린" },		-- Pattern: Murloc Scale Breastplate
		[8409]	= { "니오마" },							-- Pattern: Nightscape Shoulders
		[13288]	= { "안드로드 패드랜" },					-- Pattern: Raptor Hide Belt
		[7290]	= { "웨나 실크비어드" },				-- Pattern: Red Whelp Gloves
		[15741]	= { "레오나드 포터" },					-- Pattern: Stormshroud Pants
		[5788]	= { "미카 얀스" },					-- Pattern: Thick Murloc Armor
		[8385]	= { "프랫 맥그루벤" },				-- Pattern: Turtle Scale Gloves
		[15725]	= { "레오나드 포터" },					-- Pattern: Wicked Leather Gauntlets
		
	-- Tailoring
		[7089]	= { "브리에나 스타글로" },														-- Pattern: Azure Silk Cloak
		[7114]	= { "웨나 실크비어드" },														-- Pattern: Azure Silk Gloves
		[6272]	= { "드레이크 린드그렌", "엘리나" },												-- Pattern: Blue Linen Robe
		[6270]	= { "타린 바우던", "발다론" },												-- Pattern: Blue Linen Vest
		[6274]	= { "지나 맥그레거", "알렉산드라 볼레로" },										-- Pattern: Blue Overalls
		[14627]	= { "다니엘 집스티치" },														-- Pattern: Bright Yellow Shirt
		[6401]	= { "셰리 집스티치" },														-- Pattern: Dark Silk Shirt
		[6275]	= { "엘리나", "제나빙크 파워심", "랜 플레임스피너", "셰리 집스티치" },	-- Pattern: Greater Adept's Robe
		[4355]	= { "미카 얀스" },															-- Pattern: Icy Cloak
		[10314]	= { "제단사 에릭" },															-- Pattern: Lavender Mageweave Shirt
		[10311]	= { "엘리나" },																	-- Pattern: Orange Martial Shirt
		[10317]	= { "제단사 에릭" },															-- Pattern: Pink Mageweave Shirt
		[5771]	= { "지나 맥그레거", "발다론" },												-- Pattern: Red Linen Bag
		[5772]	= { "트에이미 데이븐포", "제나빙크 파워심",  "랜 플레임스피너", "발다론" },	-- Pattern: Red Woolen Bag
		[10326]	= { "제단사 에릭" },															-- Pattern: Tuxedo Jacket
		[10323]	= { "제단사 에릭" },															-- Pattern: Tuxedo Pants
		[10321]	= { "제단사 에릭" },															-- Pattern: Tuxedo Shirt
		[10325]	= { "알렉산드라 볼레로" },														-- Pattern: White Wedding Dress

	-- Cooking
		[16072]	= { "샨드리나" },													-- Expert Cookbook
		[13949]	= { "비비안나" },													-- Recipe: Baked Salmon
		[4609]	= { "나르 딥슬라이스" },												-- Recipe: Barbecued Buzzard Wing
		[2889]	= { "켄로드 카본카" },												-- Recipe: Beer Basted Boar Ribs
		[3734]	= { "울샨" },													-- Recipe: Big Bear Steak
		[3679]	= { "켄로드 카본카" },												-- Recipe: Blood Sausage
		[6325]	= { "캐서린 릴랜드", "그레타 간터", "카라 딥워터", "니오마", "타린 바우던" },	-- Recipe: Brilliant Smallfish
		[6330]	= { "캐서린 릴랜드", "린디아 라본느", "타린 바우던" },		-- Recipe: Bristle Whisker Catfish
		[5528]	= { "헬단 게일송", "크리곤 달손" },							-- Recipe: Clam Chowder
		[2698]	= { "켄로드 카본카" },												-- Recipe: Cooked Crab Claw
		[3681]	= { "켄로드 카본카" },												-- Recipe: Crocolisk Gumbo
		[3678]	= { "켄로드 카본카" },												-- Recipe: Crocolisk Steak
		[3682]	= { "켄로드 카본카" },												-- Recipe: Curiously Tasty Omelet
		[12239]	= { "헬레니아 올든" },												-- Recipe: Dragonbreath Chili
		[17201]	= { "Khole Jinglepocket", "Wulmort Jinglepocket" },					-- Recipe: Egg Nog
		[5485]	= { "레어드" },														-- Recipe: Fillet of Frenzy
		[17200]	= { "Khole Jinglepocket", "Wulmort Jinglepocket" },					-- Recipe: Gingerbread Cookie
		[3683]	= { "켄로드 카본카" },												-- Recipe: Gooey Spider Cake
		[2697]	= { "켄로드 카본카" },												-- Recipe: Goretusk Liver Pie
		[12240]	= { "자넷 호머스" },												-- Recipe: Heavy Kodo Stew
		[12229]	= { "비비안나" },													-- Recipe: Hot Wolf Ribs
		[12231]	= { "하사관 블루스" },												-- Recipe: Jungle Stew
		[5489]	= { "울샨" },													-- Recipe: Lean Venison
		[13947]	= { "비비안나" },													-- Recipe: Lobster Stew
		[6329]	= { "카라 딥워터" },											-- Recipe: Loch Frenzy Delight
		[6328]	= { "카라 딥워터", "니오마", "탄지 퍼들피즈", "타린 바우던" },	-- Recipe: Longjaw Mud Snapper
		[13948]	= { "비비안나" },													-- Recipe: Mightfish Steak
		[17062]	= { "헬단 게일송", "린디아 라본느", "스튜어트 플레밍", "탄지 퍼들피즈" },	-- Recipe: Mithril Head Trout
		[16110]	= { "말리젠" },													-- Recipe: Monster Omelet
		[3680]	= { "켄로드 카본카" },												-- Recipe: Murloc Fin Soup
		[12233]	= { "헬레니아 올든", "자넷 호머스" },								-- Recipe: Mystery Stew
		[6368]	= { "캐서린 릴랜드" , "헬단 게일송", "크리곤 달손" , "네사 섀도송" , "스튜어트 플레밍" },	-- Recipe: Rainbow Fin Albacore
		[2699]	= { "켄로드 카본카" },												-- Recipe: Redridge Goulash
		[12228]	= { "하사관 블루스", "하몬 카른" , "헬레니아 올든" },			-- Recipe: Roast Raptor
		[6369]	= { "헬단 게일송", "린디아 라본느" , "스튜어트 플레밍" , "탄지 퍼들피즈" },	-- Recipe: Rockscale Cod
		[2701]	= { "켄로드 카본카" },												-- Recipe: Seasoned Wolf Kabob
		[6326]	= { "크리곤 달손", "네사 섀도송", "탄지 퍼들피즈" },	-- Recipe: Slitherskin Mackerel
		[6892]	= { "드락 러프컷" },												-- Recipe: Smoked Bear Meat
		[16111]	= { "크리곤 달손" },											-- Recipe: Spiced Chili Crab
		[2700]	= { "켄로드 카본카" },												-- Recipe: Succulent Pork Ribs
		[18046]	= { "트루크 와일드바이드" },												-- Recipe: Tender Wolf Steak
		[728]	= { "켄로드 카본카" },												-- Recipe: 서부 몰락지대 Stew
		
	-- First Aid
		[16084]	= { "데네브 워커" },	-- Expert First Aid - Under Wraps
		[16112]	= { "데네브 워커" },	-- Manual: Heavy Silk Bandage
		[16113]	= { "데네브 워커" },	-- Manual: Mageweave Bandage
	},
	
	["Horde"] = {
	-- Alchemy
		[9300]	= { "라르타르" },				-- Recipe: Elixir of Demonslaying
		[9301]	= { "알게르논" },			-- Recipe: Elixir of Shadow Power
		[13478]	= { "코르겔드" },			-- Recipe: Elixir of Superior Defense
		[6055]	= { "지다" },				-- Recipe: Fire Protection Potion
		[5642]	= { "코르겔드" },			-- Recipe: Free Action Potion
		[9302]	= { "브론크" },				-- Recipe: Ghost Dye
		[5643]	= { "하그루스" },				-- Recipe: Great Rage Potion
		[6053]	= { "훌라마히" },			-- Recipe: Holy Protection Potion
		[6057]	= { "브론크" },				-- Recipe: Nature Protection Potion
		[5640]	= { "하그루스" },				-- Recipe: Rage Potion
		[6068]	= { "몬타르" },			-- Recipe: Shadow Oil
		[6054]	= { "크리스토프 제프코트" },	-- Recipe: Shadow Protection Potion
		[13477]	= { "알게르논" },			-- Recipe: Superior Mana Potion
		
	-- Blacksmithing
		[12162]	= { "수미" },		-- Plans: Hardened Iron Shortsword
		[12164]	= { "바르" },		-- Plans: Massive Iron Axe
		[7995]	= { "가라쉬" },	-- Plans: Mithril Scale Bracers
		[10858]	= { "무란" },		-- Plans: Solid Iron Maul

	-- Enchanting
		[6349]	= { "키타스", "레오 사른", "나타 던스트라이더" },						-- Formula: Enchant 2H Weapon - Lesser Intellect
		[6377]	= { "나타 던스트라이더" },											-- Formula: Enchant Boots - Minor Agility
		[11223]	= { "바나래쉬" },													-- Formula: Enchant Bracer - Deflection
		[11163]	= { "키나" },														-- Formula: Enchant Bracer - Lesser Deflection
		[11101]	= { "쿨위아" },														-- Formula: Enchant Bracer - Lesser Strength
		[6346]	= { "키타스", "릴리" },											-- Formula: Enchant Chest - Lesser Mana
		[6342]	= { "키타스", "레오 사른", "릴리", "나타 던스트라이더", "타데우스 웨브" },	-- Formula: Enchant Chest - Minor Mana
		[11039]	= { "쿨위아" },														-- Formula: Enchant Cloak - Minor Agility
		[16217]	= { "다니엘 바틀렛" },											-- Formula: Enchant Shield - Greater Stamina
		
	-- Engineering
		[18647]	= { "소빅" },	-- Schematic: Red Firework
		[16041]	= { "소빅" },	-- Schematic: Thorium Grenade
		[16042]	= { "소빅" },	-- Schematic: Thorium Widget

	-- Leatherworking
		[18949]	= { "조셉 무어" },								-- Pattern: Barbaric Bracers
		[5973]	= { "잔디아", "키나" },							-- Pattern: Barbaric Leggings
		[7613]	= { "민간인 조지 칸다테" },							-- Pattern: Green Leather Armor
		[7451]	= { "장도르 스위프트스트라이더", "조셉 무어" },		-- Pattern: Green Whelp Bracers
		[18731]	= { "타마르" },										-- Pattern: Heavy Leather Ball
		[15734]	= { "장도르 스위프트스트라이더" },						-- Pattern: Living Shoulders
		[5786]	= { "앤드류 힐버트" },								-- Pattern: Murloc Scale Belt
		[5787]	= { "앤드류 힐버트" },								-- Pattern: Murloc Scale Breastplate
		[8409]	= { "장도르 스위프트스트라이더", "워브 스트롱스티치" },	-- Pattern: Nightscape Shoulders
		[13287]	= { "텅크" },										-- Pattern: Raptor Hide Harness
		[15741]	= { "웨르그 틱블레이드" },							-- Pattern: Stormshroud Pants
		[5788]	= { "크리스토프 제프코트" },							-- Pattern: Thick Murloc Armor
		[8385]	= { "장도르 스위프트스트라이더" },						-- Pattern: Turtle Scale Gloves
		[15725]	= { "웨르그 틱블레이드" },							-- Pattern: Wicked Leather Gauntlets
		
	-- Tailoring
		[7089]	= { "준하" },													-- Pattern: Azure Silk Cloak
		[7114]	= { "키리나" },												-- Pattern: Azure Silk Gloves
		[6272]	= { "앤드류 힐버트", "레이크" },								-- Pattern: Blue Linen Robe
		[6270]	= { "보르야", "콘스턴스 브리스부아즈", "레이크" },					-- Pattern: Blue Linen Vest
		[6274]	= { "보르야", "말렌스웨인", "요나다" },						-- Pattern: Blue Overalls
		[6401]	= { "말렌스웨인" },											-- Pattern: Dark Silk Shirt
		[6275]	= { "밀리 그레고리안" },										-- Pattern: Greater Adept's Robe
		[4355]	= { "그호카" },												-- Pattern: Icy Cloak
		[10314]	= { "보르야" },													-- Pattern: Lavender Mageweave Shirt
		[10311]	= { "마후" },													-- Pattern: Orange Martial Shirt
		[10317]	= { "보르야" },													-- Pattern: Pink Mageweave Shirt
		[5771]	= { "앤드류 힐버트", "마후" },									-- Pattern: Red Linen Bag
		[5772]	= { "보르야", "마후", "밀리 그레고리안", "레이크", "요나다" },	-- Pattern: Red Woolen Bag
		[10326]	= { "밀리 그레고리안" },										-- Pattern: Tuxedo Jacket
		[10323]	= { "밀리 그레고리안" },										-- Pattern: Tuxedo Pants
		[10321]	= { "밀리 그레고리안" },										-- Pattern: Tuxedo Shirt
		[10325]	= { "마후" },													-- Pattern: White Wedding Dress

	-- Cooking
		[16072]	= { "울란" },									-- Expert Cookbook
		[13949]	= { "신드라 톨그래스" },						-- Recipe: Baked Salmon
		[6325]	= { "한 롱캐스트 ", "마틴 트램블레이", "세와 미스트러너", "리즈베스 크롬웰" },	-- Recipe: Brilliant Smallfish
		[6330]	= { "데락 나이트폴", "나알 미스트러너", "세와 미스트러너", "로널드 버치" },	-- Recipe: Bristle Whisker Catfish
		[12232]	= { "바나래쉬", "키리나", "오그마르" },		-- Recipe: Carrion Surprise
		[12226]	= { "애비게일 시엘" },							-- Recipe: Crispy Bat Wing
		[5488]	= { "타리카" },								-- Recipe: Crispy Lizard Tail
		[3682]	= { "키나", "네리스트" },						-- Recipe: Curiously Tasty Omelet
		[12239]	= { "오그마르" },								-- Recipe: Dragonbreath Chili
		[17201]	= { "Penney Copperpinch" },						-- Recipe: Egg Nog
		[17200]	= { "Penney Copperpinch" },						-- Recipe: Gingerbread Cookie
		[12240]	= { "키리나" },								-- Recipe: Heavy Kodo Stew
		[20075]	= { "오그마르" },								-- Recipe: Heavy Crocolisk Stew
		[3735]	= { "자르그" },									-- Recipe: Hot Lion Chops
		[12229]	= { "신드라 톨그래스" },						-- Recipe: Hot Wolf Ribs
		[12231]	= { "네리스트" },								-- Recipe: Jungle Stew
		[13947]	= { "신드라 톨그래스" },						-- Recipe: Lobster Stew
		[6328]	= { "한 롱캐스트 ", "킬리안 사나타", "나알 미스트러너", "리즈베스 크롬웰" },	-- Recipe: Longjaw Mud Snapper
		[13948]	= { "신드라 톨그래스" },						-- Recipe: Mightfish Steak
		[17062]	= { "샨키스", "위크타르", "울란" },			-- Recipe: Mithril Head Trout
		[16110]	= { "베일" },									-- Recipe: Monster Omelet
		[6368]	= { "킬리안 사나타", "샨키스", "잔소아", "로널드 버치" },	-- Recipe: Rainbow Fin Albacore
		[12228]	= { "키나", "네리스트", "오그마르" },			-- Recipe: Roast Raptor
		[5484]	= { "우나 다크메인" },							-- Recipe: Roasted Kodo Meat
		[6369]	= { "샨키스", "위크타르", "울란" },			-- Recipe: Rockscale Cod
		[5483]	= { "그림탁" },								-- Recipe: Scorpid Surprise
		[6326]	= { "마틴 트램블레이", "잔소아" },				-- Recipe: Slitherskin Mackerel
		[6892]	= { "앤드류 힐버트" },							-- Recipe: Smoked Bear Meat
		[16111]	= { "바나래쉬", "우톡" },						-- Recipe: Spiced Chili Crab
		[5486]	= { "타리카" },								-- Recipe: Strider Stew
		
	-- First Aid
		[16084]	= { "발라이 로크웨인", "그호카" },	-- Expert First Aid - Under Wraps
		[16112]	= { "발라이 로크웨인", "그호카" },	-- Manual: Heavy Silk Bandage
		[16113]	= { "발라이 로크웨인", "그호카" },	-- Manual: Mageweave Bandage
	},
	
	["Neutral"] = {
	-- Alchemy
		[13501]	= { "마그누스 프로스트웨이크" },						-- Recipe: Major Mana Potion
		[13485]	= { "마그누스 프로스트웨이크" },						-- Recipe: Transmute Water to Air
		[13482]	= { "은빛병참장교 하사나", "은빛병참장교 라이트스파크", "병참장교 미란다 브리치락" },	-- Recipe: Transmute Air to Fire
		[13484]	= { "메일로쉬" },								-- Recipe: Transmute Earth to Water
		[13483]	= { "플러거 스파즈링" },						-- Recipe: Transmute Fire to Earth
		[20013]	= { "상인 린워쇼" },					-- Recipe: Living Action Potion
		[20011]	= { "상인 린워쇼" },					-- Recipe: Mageblood Potion
		[20014]	= { "상인 린워쇼" },					-- Recipe: Major Troll's Blood Potion
		[20012]	= { "상인 린워쇼" },					-- Recipe: Greater Dreamless Sleep Potion

		[5642]	= { "자동 판매기 1000" },						-- Recipe: Free Action Potion
		[14634]	= { "브로킨" },								-- Recipe: Frost Oil
		[6056]	= { "글릭스 브루라이트" },							-- Recipe: Frost Protection Potion
		[5643]	= { "자동 판매기 1000" },						-- Recipe: Great Rage Potion
		[6053]	= { "크직스" },									-- Recipe: Holy Protection Potion
		[13480]	= { "에비 휠브루" },							-- Recipe: Major Healing Potion
		[6057]	= { "글릭스 브루라이트", "연금술사 페슬저그"},	-- Recipe: Nature Protection Potion
		[9303]	= { "연금술사 페슬저그" },					-- Recipe: Philosophers' Stone
		[5640]	= { "래니크" },									-- Recipe: Rage Potion
		[6068]	= { "블리즈틱" },								-- Recipe: Shadow Oil
		[12958]	= { "연금술사 페슬저그" },					-- Recipe: Transmute Arcanite
		[9304]	= { "연금술사 페슬저그" },					-- Recipe: Transmute Iron to Gold
		[9305]	= { "연금술사 페슬저그" },					-- Recipe: Transmute Mithril to Truesilver
		
	-- Blacksmithing
		[8030]	= { "마그누스 프로스트웨이크" },		-- Plans: Ebon Shiv
		[12823]	= { "마그누스 프로스트웨이크" },		-- Plans: Huge Thorium Battleaxe
		[12819]	= { "마그누스 프로스트웨이크" },		-- Plans: Ornate Thorium Handaxe
		[12703]	= { "마그누스 프로스트웨이크" },		-- Plans: Storm Gauntlets
		[19208]	= { "로크토스 아크바게이너" },	-- Plans: Black Amnesty
		[19209]	= { "로크토스 아크바게이너" },	-- Plans: Blackfury
		[19211]	= { "로크토스 아크바게이너" },	-- Plans: Blackguard
		[17051]	= { "로크토스 아크바게이너" },	-- Plans: Dark Iron Bracers
		[17060]	= { "로크토스 아크바게이너" },	-- Plans: Dark Iron Destroyer
		[19207]	= { "로크토스 아크바게이너" },	-- Plans: Dark Iron Gauntlets
		[19206]	= { "로크토스 아크바게이너" },	-- Plans: Dark Iron Helm
		[17052]	= { "로크토스 아크바게이너" },	-- Plans: Dark Iron Leggings
		[17059]	= { "로크토스 아크바게이너" },	-- Plans: Dark Iron Reaver
		[19210]	= { "로크토스 아크바게이너" },	-- Plans: Ebon Hand
		[17049]	= { "로크토스 아크바게이너" },	-- Plans: Fiery Chain Girdle
		[17053]	= { "로크토스 아크바게이너" },	-- Plans: Fiery Chain Shoulders
		[19212]	= { "로크토스 아크바게이너" },	-- Plans: Nightfall
		[19202]	= { "메일로쉬" },				-- Plans: Heavy Timbermaw Belt
		[19203]	= { "은빛병참장교 하사나", "은빛병참장교 라이트스파크", "병참장교 미란다 브리치락" },	-- Plans: Girdle of the Dawn
		[19205]	= { "은빛병참장교 하사나", "은빛병참장교 라이트스파크", "병참장교 미란다 브리치락" },	-- Plans: Gloves of the Dawn
		[19781]	= { "상인 린워쇼" },	-- Plans: Darksoul Shoulders
		[19780]	= { "상인 린워쇼" },	-- Plans: Darksoul Leggings
		[19779]	= { "상인 린워쇼" },	-- Plans: Darksoul Breastplate
		[19778]	= { "상인 린워쇼" },	-- Plans: Bloodsoul Gauntlets
		[19777]	= { "상인 린워쇼" },	-- Plans: Bloodsoul Shoulders
		[19776]	= { "상인 린워쇼" },	-- Plans: Bloodsoul Breastplate
		
		[6047]	= { "크린클 굿스틸" },	-- Plans: Golden Scale Coif
		[12162]	= { "주타크" },				-- Plans: Hardened Iron Shortsword
		[12164]	= { "자킬리나 드라메트" },	-- Plans: Massive Iron Axe
		[12163]	= { "자레나 크롬윈드" },	-- Plans: Moonsteel Broadsword
		[10858]	= { "자즈릭" },			-- Plans: Solid Iron Maul

	-- Enchanting
		[19449]	= { "로크토스 아크바게이너" },	-- Formula: Enchant Weapon - Mighty Intellect
		[19448]	= { "로크토스 아크바게이너" },	-- Formula: Enchant Weapon - Mighty Spirit
		[19444]	= { "로크토스 아크바게이너" },	-- Formula: Enchant Weapon - Strength
		[19445]	= { "메일로쉬" },				-- Formula: Enchant Weapon - Agility
		[19447]	= { "은빛병참장교 하사나", "은빛병참장교 라이트스파크", "병참장교 미란다 브리치락" },	-- Formula: Enchant Bracer - Healing
		[19446]	= { "은빛병참장교 하사나", "은빛병참장교 라이트스파크", "병참장교 미란다 브리치락" },	-- Formula: Enchant Bracer - Mana Regeneration

		[6377]	= { "직실" },					-- Formula: Enchant Boots - Minor Agility
		[16221]	= { "퀴아" },					-- Formula: Enchant Chest - Major Health
		[16224]	= { "로렐라이 윈터송" },		-- Formula: Enchant Cloak - Superior Defense
		[16243]	= { "로렐라이 윈터송" },		-- Formula: Runed Arcanite Rod

	-- Engineering
		[20001]	= { "상인 린워쇼" },	-- Schematic: Bloodvine Lens
		[20000]	= { "상인 린워쇼" },	-- Schematic: Bloodvine Goggles

		[13310]	= { "마즈크 스나이프샷", "슈퍼 판매기 680" },				-- Schematic: Accurate Scope
		[10602]	= { "크나즈 블런더플레임", "유카 스크류스피곳" },			-- Schematic: Deadly Scope
		[16050]	= { "시저 피즈볼트" },								-- Schematic: Delicate Arcanite Converter
		[7742]	= { "잰 쉬브스프로켓" },								-- Schematic: Gnomish Cloaking Device
		[7560]	= { "진키 트위즐픽시트" },							-- Schematic: Gnomish Universal Remote
		[7561]	= { "크직스", "슈퍼 판매기 680", "비닉스", "직실" },	-- Schematic: Goblin Jumper Cables
		[18648]	= { "크라즈크 스팍스", "객스프로켓" },					-- Schematic: Green Firework
		[18652]	= { "시저 피즈볼트" },								-- Schematic: Gyrofreeze Ice Reflector
		[13308]	= { "리즈 루즈볼트", "슈퍼 판매기 680" },				-- Schematic: Ice Deflector
		[13309]	= { "진키 트위즐픽시트" },							-- Schematic: Lovingly Crafted Boomstick
		[16046]	= { "시저 피즈볼트" },								-- Schematic: Masterwork Target Dummy
		[13311]	= { "그나즈 블런더플레임" },								-- Schematic: Mechanical Dragonling
		[18656]	= { "시저 피즈볼트" },								-- Schematic: Powerful Seaforium Charge
		[16047]	= { "시저 피즈볼트" },								-- Schematic: Thorium Tube
		[18651]	= { "마즈크 스나이프샷" },									-- Schematic: Truesilver Transformer

	-- Leatherworking
		[17025]	= { "로크토스 아크바게이너" },	-- Pattern: Black Dragonscale Boots
		[19331]	= { "로크토스 아크바게이너" },	-- Pattern: Chromatic Gauntlets
		[19332]	= { "로크토스 아크바게이너" },	-- Pattern: Corehound Belt
		[17022]	= { "로크토스 아크바게이너" },	-- Pattern: Corehound Boots
		[19330]	= { "로크토스 아크바게이너" },	-- Pattern: Lava Belt
		[19333]	= { "로크토스 아크바게이너" },	-- Pattern: Molten Belt
		[17023]	= { "로크토스 아크바게이너" },	-- Pattern: Molten Helm
		[19326]	= { "메일로쉬" },				-- Pattern: Might of the Timbermaw
		[15742]	= { "메일로쉬" },				-- Pattern: Warbear Harness
		[15754]	= { "메일로쉬" },				-- Pattern: Warbear Woolies
		[19328]	= { "은빛병참장교 하사나", "은빛병참장교 라이트스파크", "병참장교 미란다 브리치락" },	-- Pattern: Dawn Treaders
		[19329]	= { "은빛병참장교 하사나", "은빛병참장교 라이트스파크", "병참장교 미란다 브리치락" },	-- Pattern: Golden Mantle of the Dawn
		[19771]	= { "상인 린워쇼" },		-- Pattern: Primal Batskin Bracers
		[19773]	= { "상인 린워쇼" },		-- Pattern: Blood Tiger Shoulders
		[19770]	= { "상인 린워쇼" },		-- Pattern: Primal Batskin Gloves
		[19772]	= { "상인 린워쇼" },		-- Pattern: Blood Tiger Breastplate
		[19769]	= { "상인 린워쇼" },		-- Pattern: Primal Batskin Jerkin

		[15759]	= { "플러거 스파즈링" },			-- Pattern: Black Dragonscale Breastplate
		[6474]	= { "칼단 펠문" },			-- Pattern: Deviate Scale Cloak
		[6475]	= { "칼단 펠문" },			-- Pattern: Deviate Scale Gloves
		[15758]	= { "네르갈" },						-- Pattern: Devilsaur Gauntlets
		[7362]	= { "직실" },						-- Pattern: Earthen Leather Shoulders
		[15740]	= { "퀴아" },						-- Pattern: Frostsaber Boots
		[14635]	= { "릭키즈", "자동 판매기 1000" },	-- Pattern: Gem-studded Leather Belt
		[15726]	= { "마사트 탄드르" },				-- Pattern: Green Dragonscale Breastplate
		[7613]	= { "자동 판매기 1000" },			-- Pattern: Green Leather Armor
		[7451]	= { "자동 판매기 1000" },			-- Pattern: Green Whelp Bracers
		[15724]	= { "잔노크 하이드피이서" },			-- Pattern: Heavy Scorpid Bracers
		[15762]	= { "잔노크 하이드피이서" },			-- Pattern: Heavy Scorpid Helm
		[5789]	= { "블릭스레즈 굿스티치" },			-- Pattern: Murloc Scale Bracers
		[15756]	= { "제이스 파레인" },				-- Pattern: Runic Leather Headband
		[18239]	= { "릭키즈" },						-- Pattern: Shadowskin Gloves
		[5788]	= { "블릭스레즈 굿스티치" },			-- Pattern: Thick Murloc Armor
		
	-- Tailoring
		[17018]	= { "로크토스 아크바게이너" },	-- Pattern: Flarecore Gloves
		[19220]	= { "로크토스 아크바게이너" },	-- Pattern: Flarecore Leggings
		[17017]	= { "로크토스 아크바게이너" },	-- Pattern: Flarecore Mantle
		[19219]	= { "로크토스 아크바게이너" },	-- Pattern: Flarecore Robe
		[19215]	= { "메일로쉬" },				-- Pattern: Wisdom of the Timbermaw
		[19216]	= { "은빛병참장교 하사나", "은빛병참장교 라이트스파크", "병참장교 미란다 브리치락" },	-- Pattern: Argent Boots
		[19217]	= { "은빛병참장교 하사나", "은빛병참장교 라이트스파크", "병참장교 미란다 브리치락" },	-- Pattern: Argent Shoulders
		[19766]	= { "상인 린워쇼" },		-- Pattern: Bloodvine Boots
		[19765]	= { "상인 린워쇼" },		-- Pattern: Bloodvine Leggings
		[19764]	= { "상인 린워쇼" },		-- Pattern: Bloodvine Vest

		[10318]	= { "겁쟁이 크로스비" },						-- Pattern: Admiral's Hat
		[10728]	= { "나르크" },									-- Pattern: Black Swashbuckler's Shirt
		[6272]	= { "래니크" },									-- Pattern: Blue Linen Robe
		[7087]	= { "슈퍼 판매기 680", "시즈크 굿스티치" },	-- Pattern: Crimson Silk Cloak
		[7088]	= { "비즈클릭" },								-- Pattern: Crimson Silk Robe
		[6401]	= { "슈퍼 판매기 680" },						-- Pattern: Dark Silk Shirt
		[14630]	= { "슈퍼 판매기 680", "시즈크 굿스티치" },	-- Pattern: Enchanter's Cowl
		[14483]	= { "로렐라이 윈터송" },						-- Pattern: Felcloth Pants
		[6275]	= { "래니크" },									-- Pattern: Greater Adept's Robe
		[18487]	= { "셴드랄라 고대인" },				-- Pattern: Mooncloth Robe
		[14526]	= { "퀴아", "에비 휠브루" },					-- Pattern: Mooncloth
		[5772]	= { "킥니클", "직실" },						-- Pattern: Red Woolen Bag
		[14468]	= { "퀴아" },									-- Pattern: Runecloth Bag
		[14488]	= { "다르날" },								-- Pattern: Runecloth Boots
		[14472]	= { "다르날" },								-- Pattern: Runecloth Cloak
		[14481]	= { "퀴아" },									-- Pattern: Runecloth Gloves
		[14469]	= { "다르날" },								-- Pattern: Runecloth Robe

	-- Cooking
		[4609]	= { "슈퍼 판매기 680" },	-- Recipe: Barbecued Buzzard Wing
		[3734]	= { "슈퍼 판매기 680" },	-- Recipe: Big Bear Steak
		[6330]	= { "킬륵스" },				-- Recipe: Bristle Whisker Catfish
		[12232]	= { "자동 판매기 1000" },	-- Recipe: Carrion Surprise
		[13940]	= { "켈시 얀스" },		-- Recipe: Cooked Glossy Mightfish
		[12239]	= { "슈퍼 판매기 680" },	-- Recipe: Dragonbreath Chili
		[13941]	= { "켈시 얀스" },		-- Recipe: Filet of Redgill
		[6039]	= { "켈시 얀스" },		-- Recipe: Giant Clam Scorcho
		[13942]	= { "긱킥스" },				-- Recipe: Grilled Squid
		[12240]	= { "자동 판매기 1000" },	-- Recipe: Heavy Kodo Stew
		[3735]	= { "자동 판매기 1000" },	-- Recipe: Hot Lion Chops
		[13943]	= { "켈시 얀스" },		-- Recipe: Hot Smoked Bass
		[12229]	= { "슈퍼 판매기 680" },	-- Recipe: Hot Wolf Ribs
		[12231]	= { "자동 판매기 1000" },	-- Recipe: Jungle Stew
		[5489]	= { "자동 판매기 1000" },	-- Recipe: Lean Venison
		[12227]	= { "슈퍼 판매기 680" },	-- Recipe: Lean Wolf Steak
		[17062]	= { "켈시 얀스" },		-- Recipe: Mithril Head Trout
		[16110]	= { "힘믹", "퀴아" },		-- Recipe: Monster Omelet
		[12233]	= { "슈퍼 판매기 680" },	-- Recipe: Mystery Stew
		[13945]	= { "긱킥스" },				-- Recipe: Nightfin Soup
		[13946]	= { "긱킥스" },				-- Recipe: Poached Sunscale Salmon
		[6368]	= { "킬륵스" },				-- Recipe: Rainbow Fin Albacore
		[12228]	= { "자동 판매기 1000" },	-- Recipe: Roast Raptor
		[6369]	= { "켈시 얀스" },		-- Recipe: Rockscale Cod
		[13939]	= { "긱킥스" },				-- Recipe: Spotted Yellowtail
		[18046]	= { "더지 퀵클레이브" },	-- Recipe: Tender Wolf Steak
		[16767]	= { "재비" },				-- Recipe: Undermine Clam Chowder

	-- Fishing
		[16083]	= { "노인 헤밍" },	-- Expert Fishing - The Bass and You
		
	-- First Aid
		[19442]	= { "은빛병참장교 하사나", "은빛병참장교 라이트스파크", "병참장교 미란다 브리치락" },	-- Formula: Powerful anti-venom

	},
};

FAS_LibramInfo = {
	[18333] = { name="현자 리드로스", bonus="+8 치유 효과와 주문의 피해" },	-- Libram of Focus
	[18334] = { name="현자 리드로스", bonus="+1% 회피율" },					-- Libram of Protection
	[18332] = { name="현자 리드로스", bonus="+1% 공격속도" },					-- Libram of Rapidity
	[11736] = { name="마스레디스 파이어스타", bonus="+20 화염저항" },		-- Libram of Resilience
	[11732] = { name="마스레디스 파이어스타", bonus="+150 마나" },					-- Libram of Rumination
	[11734] = { name="마스레디스 파이어스타", bonus="+125 방어도" },				-- Libram of Tenacity
	[11737] = { name="마스레디스 파이어스타", bonus="+8 원하는 스탯 한가지" },		-- Libram of Voracity
	[11733] = { name="마스레디스 파이어스타", bonus="+100 생명력" },				-- Libram of Constitution
};

FAS_OtherItemInfo = {
	[11404]	= DARKMOON,		-- Evil Bat Eye
	[5117]	= DARKMOON,		-- Vibrant Plume
	[11407]	= DARKMOON,		-- Torn Bear Pelt
	[4582]	= DARKMOON,		-- Soft Bushy Tail
	[5134]	= DARKMOON,		-- Small Furry Paw
};

end