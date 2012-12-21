klhtm.string.data["koKR"] =

{
	["binding"] =
	{
		hideshow = "창 숨기기/보기",
		stop = "비상중단",
		mastertarget = "주타겟 설정/해제",
		resetraid = "레이드 위협수준 리셋",
	},
	["spell"] =
	{
		["heroicstrike"] = "영웅의 일격",
		["maul"] = "후려치기",
		["swipe"] = "휘둘러치기",
		["shieldslam"] = "방패 밀쳐내기",
		["revenge"] = "복수",
		["shieldbash"] = "방패 가격",
		["sunder"] = "방어구 가르기",
		["feint"] = "교란",
		["cower"] = "웅크리기",
		["taunt"] = "도발",
		["growl"] = "포효",
		["vanish"] = "소멸",
		["frostbolt"] = "얼음 화살",
		["fireball"] = "화염구",
		["arcanemissiles"] = "신비한 화살",
		["scorch"] = "불태우기",
		["cleave"] = "회전베기",

		-- Items / Buffs:
		["arcaneshroud"] = "신비의 장막",
		["reducethreat"] = "위협 수준 감소",

		-- new in R16
		["holynova"] = "신성한 폭발", -- no heal or damage threat
		["siphonlife"] = "생명력 착취", -- no heal threat
		["drainlife"] = "생명력 흡수", -- no heal threat
		["deathcoil"] = "죽음의 고리",

		-- no threat for fel stamina. energy unknown.
		--["felstamina"] = "마의 체력",
		--["felenergy"] = "마의 에너지",

		["bloodsiphon"] = "생명력 착취", -- poisoned blood vs Hakkar


		["lifetap"] = "생명력 전환", -- no mana gain threat
		["holyshield"] = "신성한 방패", -- multiplier
		["tranquility"] = "평온",
		["distractingshot"] = "견제 사격",
		["earthshock"] = "대지 충격",
		["rockbiter"] = "대지의 무기",
		["fade"] = "소실",
		["thunderfury"] = "우레폭풍", --퓨리 발동효과 -확인

		-- Spell Sets
		-- warlock descruction
		["shadowbolt"] = "어둠의 화살",
		["immolate"] = "제물",
		["conflagrate"] = "점화",
		["searingpain"] = "불타는 고통",
		["rainoffire"] = "불의 비",
		["soulfire"] = "영혼의 불꽃",
		["shadowburn"] = "어둠의 연소",
		["hellfire"] = "지옥의 불길",

		-- mage offensive arcane
		["arcaneexplosion"] = "신비한 폭발",
		["counterspell"] = "마법 반사",

		-- priest shadow
		["mindblast"] = "정신 분열",
	},
	["power"] =
	{
		["mana"] = "마나",
		["rage"] = "분노",
		["energy"] = "기력",
	},
	["threatsource"] = -- these values are for user printout only
	{
		["powergain"] = "파워 획득",
		["total"] = "합",
		["special"] = "기술/마법",
		["healing"] = "치유",
		["dot"] = "DOT",
		["threatwipe"] = "NPC 주문",
		["damageshield"] = "피해 보호막",
		["whitedamage"] = "평타",
	},
	["talent"] = -- these values are for user printout only
	{
		["defiance"] = "도전",
		["impale"] = "꿰뚫기",
		["silentresolve"] = "무언의 결심",
		["frostchanneling"] = "냉기계 정신집중",
		["burningsoul"] = "불타는 영혼",
		["healinggrace"] = "회복의 토템", --주술사 몰라-_-;;
		["shadowaffinity"] = "암흑 마법 친화",
		["druidsubtlety"] = "미묘함",
		["feralinstinct"] = "야생의 본능",
		["ferocity"] = "야수의 본성",
		["savagefury"] = "맹렬한 격노",
		["tranquility"] = "평온 연마",
		["masterdemonologist"] = "악령술의 대가",
		["arcanesubtlety"] = "신비한 미묘함",
		["righteousfury"] = "정의의 격노 연마",
	},
	["threatmod"] = -- these values are for user printout only
	{
		["tranquilair"] = "평온의 토템",
		["salvation"] = "구원의 축복",
		["battlestance"] = "전투 태세",
		["defensivestance"] = "방어 태세",
		["berserkerstance"] = "광폭 태세",
		["defiance"] = "도전",
		["basevalue"] = "기본 값",
		["bearform"] = "곰 변신",
		["glovethreatenchant"] = "장갑에 위협수준 증가 마법부여",
		["backthreatenchant"] = "망토에 위협수준 감소 마법부여",
	},
	["sets"] =
	{
		["bloodfang"] = "붉은송곳니",
		["nemesis"] = "천벌",
		["netherwind"] = "소용돌이",
		["might"] = "투지",
		["arcanist"] = "신비술사",
	},
	["boss"] =
	{
		["speech"] =
		{
	  	["razorphase2"] = "수정 구슬의 지배 마력이 빠져나가자 도망칩니다.",
  		["onyxiaphase3"] = "혼이 더 나야 정신을 차리겠구나!",
			["thekalphase2"] = "시르밸라시여, 분노를 채워 주서소!",
			["rajaxxfinal"] = "건방진...  내 친히 너희를 처치해주마!",
			["azuregosport"] = "오너라, 조무래기들아! 덤벼봐라!",
			["nefphase2"] = "불타라! 활활! 불타라!",
		},
		-- Some of these are unused. Also, if none is defined in your localisation, they won't be used,
		-- so don't worry if you don't implement it.
		["name"] =
		{
			["rajaxx"] = "장군 라작스",
		  ["onyxia"] = "오닉시아",
	  	["ebonroc"] = "에본로크",
  		["razorgore"] = "폭군 서슬송곳니",
			["thekal"] = "대사제 데칼",
			["shazzrah"] = "샤즈라",
			["twinempcaster"] = "제왕 베클로어",
			["twinempmelee"] = "제왕 베크닐라쉬",
			["noth"] = "역병술사 노스",
		},
		["spell"] =
		{
			["shazzrahgate"] = "샤즈라의 문", -- "Shazzrah casts Gate of Shazzrah."
			["wrathofragnaros"] = "라그나로스의 징벌", -- "Ragnaros's Wrath of Ragnaros hits you for 100 Fire damage."
			["timelapse"] = "시간의 쇠퇴", -- "You are afflicted by Time Lapse."
  		["knockaway"] = "날려버리기",
	  	["wingbuffet"] = "폭풍 날개",
		  ["burningadrenaline"] = "불타는 아드레날린",
		  ["twinteleport"] = "쌍둥이 순간이동",
			["nothblink"] = "점멸",
			["sandblast"] = "모래 돌풍",
		}
	},
	["misc"] =
	{
		["imp"] = "임프", -- UnitCreatureFamily("pet")
		["spellrank"] = "(%d+) 레벨", -- second value of GetSpellName(x, "spell")
		["aggrogain"] = "어그로획득",
	},
	-- labels and tooltips for the main window
	["gui"] = {
		["raid"] = {
			["head"] = {
				-- column headers for the raid view
				["name"] = "이름",
				["threat"] = "위협수준",
				["pc"] = "%최대",
			},
			["stringshort"] = {
				-- tooltip titles for the bottom bar strings
				["tdef"] = "위협차",
				["targ"] = "주타겟",
			},
			["stringlong"] = {
				-- tooltip descriptions for the bottom bar strings
				["tdef"] = "",
				["targ"] = "%s에 대한 위협수준."
			},
		},
		["self"] = {
			["head"] = {
				-- column headers for the self view
				["name"] = "이름",
				["hits"] = "횟수",
				["rage"] = "분노",
				["dam"] = "피해",
				["threat"] = "위협수준",
				["pc"] = "%T",
			},
			-- text on the self threat reset button
			["reset"] = "Reset",
		},
		["title"] = {
			["text"] = {
				-- the window titles
				["long"] = "KTM %d.%d",
				["short"] = "KTM",

			},
			["buttonshort"] = {
				-- the tooltip titles for command buttons
				["close"] = "닫기",
				["min"] = "최소화",
				["max"] = "최대화",
				["self"] = "개별창",
				["raid"] = "레이드창",
				["pin"] = "핀고정",
				["unpin"] = "핀풀림",
				["opt"] = "옵션",
				["targ"] = "주타겟",
				["clear"] = "리셋",
			},
			["buttonlong"] = {
				-- the tooltip descriptions for command buttons
				["close"] = "위협수준 데이터는 여전히 파티나 레이드에 보내짐",
				["min"] = "",
				["max"] = "",
				["self"] = "개별 위협수준을 보임",
				["raid"] = "레이드 위협수준을 보임",
				["pin"] = "이동을 방지",
				["unpin"] = "이동을 허용",
				["opt"] = "",
				["targ"] = "현재대상을 주타겟으로 설정. 대상이 없으면 주타겟을 초기화. 공대장이나 승급자만 설정가능.",
				["clear"] = "모든 플레이어의 위협수준을 초기화. 공대장이나 승급자만 설정가능.",
			},
			["stringshort"] = {
				-- the tooltip titles for titlebar strings
				["threat"] = "위협수준",
				["tdef"] = "위협차",
				["rank"] = "위협순위",
				["pc"] = "위협%",
			},
			["stringlong"] = {
				-- the tooltip descriptions for titlebar strings
				["threat"] = "리셋화 축적된 위협수준",
				["tdef"] = "타겟과 자신의 위협수준 차이값",
				["rank"] = "위협리스트중 자신의 순위",
				["pc"] = "타겟의 위협수준대비 자신의 위협수준 %",
			},
		},
	},
	-- labels and tooltips for the options gui
	["optionsgui"] = {
		["buttons"] = {
			-- the options gui command button labels
			["gen"] = "일반",
			["raid"] = "레이드",
			["self"] = "개별",
			["close"] = "닫기",
		},
		-- the labels for option checkboxes and headers
		["labels"] = {
			-- the title description for each option page
			["titlebar"] = {
				["gen"] = "일반옵션",
				["raid"] = "레이드옵션",
				["self"] = "개별옵션",
			},
			["buttons"] = {
				-- the names of title bar command buttons
				["pin"] = "핀",
				["opt"] = "옵션",
				["view"] = "뷰변경",
				["targ"] = "주타겟",
				["clear"] = "레이드 위협수준 리셋",
			},
			["columns"] = {
				-- names of columns on the self and raid views
				["hits"] = "횟수",
				["rage"] = "분노",
				["dam"] = "피해",
				["threat"] = "위협수준",
				["pc"] = "% 위협수준",
			},
			["options"] = {
				-- miscelaneous option names
				["hide"] = "0 위협수준은 숨김",
				["abbreviate"] = "큰수치간략화",
				["resize"] = "프레임 크기조절",
				["aggro"] = "어그로 재표시",
				["rows"] = "최대 행표시",
				["scale"] = "프레임 크기",
				["bottom"] = "하단바를 숨김",
			},
			["minvis"] = {
				-- the names of minimised strings
				["threat"] = "위협수준 최소화", -- dodge...
				["rank"] = "위협순위",
				["pc"] = "위협%",
				["tdef"] = "위협차이",
			},
			["headers"] = {
				-- headers in the options gui
				["columns"] = "열 표시",
				["strings"] = "최소화시 표시값",
				["other"] = "기타 옵션",
				["minvis"] = "최소화시 버튼",
				["maxvis"] = "최대화시 버튼",
			},
		},
		-- the tooltips for some of the options
		["tooltips"] = {
			-- miscelaneous option descriptions
			["raidhide"] = "체크시, 어그로가 0인 플레이어는 목록에서 제외됨.",
			["selfhide"] = "체크시, 위협수준이 0인 항목은 표시가 안됨.",
			["abbreviate"] = "체크시, 천이 넘아가는 수치는 뒤에 k가 붙어서 간략히 표시됨. 예) '15400'는 '15.4k'로 표시됨.",
			["resize"] = "체크시, 표시행수가 애드온이 깔린 플레이어수이 맞추어서 적어짐.",
			["aggro"] = "체크시, 위협한계치가 레이드뷰에 첨가됨. 주타겟이 설정되었을 시 가장 정확함.",
			["rows"] = "레이드 화면에 보여지는 최대 플레이어수",
			["bottom"] = "체크시, 위협차이와 주타겟을 보여주는 하단바가 숨겨짐.",
		},
	},
	["print"] =
	{
		["main"] =
		{
			["startupmessage"] = "KLHThreatMeter(Release |cff33ff33%s|r Revision |cff33ff33%s|r)가 로딩됨. 도움말은 |cffffff00/ktm|r 을 치십시오.",
		},
		["data"] =
		{
			["abilityrank"] = "당신의 %s 기술은 %s레벨입니다.",
			["globalthreat"] = "당신의 포괄적인 위협수준 배율은 %s입니다.",
			["globalthreatmod"] = "%s에 의한 위협수준 배율은 %s입니다.",
			["multiplier"] = "%s|1으로써;로써;, %s 기술에 의한 위협수준 배율은 %s입니다.",
			["damage"] = "데미지",
			["shadowspell"] = "암흑 주문",
			["arcanespell"] = "아케인 주문",
			["holyspell"] = "신성 주문",
			["setactive"] = "%s %d 셋템이 활성화 : %s.",
			["true"] = "옳음",
			["false"] = "틀림",
			["healing"] = "당신의 치유는 %s 위협수준을 발생시킨다.(포괄적인 위협수준 배율을 적용하기전).",
			["talentpoint"] = "특성포인트 %d : %s 기술.",
			["talent"] = "%d %s 특성 발견.",
			["rockbiter"] = "당신의 %d레벨의 대지의 무기는 근접공격이 성공할 시, %d 위협수준이 추가된다.",
		},
		-- new in R17.7
		["boss"] =
		{
			["automt"] = "주타겟이 자동적으로 %s|1으로;로; 설정되었습니다.",
			["spellsetmob"] = "%1$s님이 %3$s의 %4$s 기술의 %2$s 변수값을 %6$s에서 %5$s으로 설정합니다.",
			["spellsetall"] = "%1$s님이 %3$s 기술의 %2$s 변수값을 %5$s에서 %4$s으로 설정합니다.",
			["reportmiss"] = "%s님이 %s의 %s 기술이 자신을 빛맞추었다고 보고합니다.",
			["reporttick"] = "%s님이 %s의 %s 기술이 자신을 맞추었다고 보고합니다. %s틱동안 피해를 당했으며, %s틱동안 더 영향을 받을 것입니다.",
			["reportproc"] = "%s님이 %s의 %s 기술이 위협수준을 %s에서 %s으로 변경시켰다고 보고합니다.",
			["bosstargetchange"] = "%s|1이;가; 타겟을 %s(%s 위협수준)에서 %s (%s 위협수준)으로 변경하였습니다.",
			["autotargetstart"] = "미터기가 자동적으로 주타겟을 비우고 타겟으로 한 다음 월드보스몹을 주타겟으로 설정할 것입니다.",
			["autotargetabort"] = "주타겟이 이미 월드보스인 %s|1으로;로; 설정되었습니다.",
		},

		["network"] =
		{
			["newmttargetnil"] = "주타겟을 %s|1으로;로; 설정할 수 없습니다. %s님은 타겟이 없습니다.",
			["newmttargetmismatch"] = "%s님이 주타겟을 %s|1으로;로; 설정하였습니다, 하지만 현재 자신의 대상은 %s입니다. 자신의 대상을 사용하려 했다면, 확인하십시요!",
			["mtpollwarning"] = "당신의 주타겟이 %s|1으로;로; 업데이트되었지만, 확신할 수 없습니다. 정확하지 않다면, %s님에게 주타겟을 재개시하도록 요청하십시오.",
			["threatreset"] = "%ss님이 레이드 어그로미터가 리셋함.",
			["newmt"] = "%2$s님이 주타겟을 %1$s|1으로;로; 설정함.",
			["mtclear"] = "%s님이 주타겟을 초기화함.",
			["knockbackstart"] = "NPC 주문 리포팅을 %s님이 활성화함.",
			["knockbackstop"] = "NPC 주문 리포팅을 %s님이 비활성화함.",
			["aggrogain"] = "%s님이 %d의 위협수준으로 어그로를 얻었습니다.",
			["aggroloss"] = "%s님이 %d의 위협수준으로 어그로를 잃었습니다.",
			["knockback"] = "%s님이 knockback 당했다고 보고됩니다. 그의 위협수준이 %d만큼 다운되었습니다.",
			["knockbackstring"] = "%s님이 knockback 문자열이 '%s'이라고 보고했습니다.",
			["upgraderequest"] = "%s님이 KLHThreatMeter 버젼 %s으로 업그레이드하라는 요청이 있습니다. 현재 사용하는 버젼은 %s입니다..",
			["remoteoldversion"] = "%s님이 오래된 KLHThreatMeter 버젼 %s을 사용하고 있습니다. 버젼 %s으로 업그레이드하라고 알려주십시오.",
			["knockbackvaluechange"] = "|cffffff00%s|r님이 %s의 |cffffff00%s|r 공격의 위협수준 감소를 |cffffff00%d%%|r로 셋팅했습니다.",
			["raidpermission"] = "공대장이나 승급자만이 수행가능함.",
			["needmastertarget"] = "주타겟을 먼저 설정해야 함!",
			["knockbackinactive"] = "Knockback discovery가 공격대에서 활성화되지 못함.",
			["versionrequest"] = "레이드로부터 버젼정보를 요청중. 3초정도의 응답시간.",
			["versionrecent"] = "release %s을 사용하는 사람: { ",
			["versionold"] = "이전 버젼을 사용하는 사람: { ",
			["versionnone"] = "KLHThreatMeter을 사용하지 않거나, CTRA채널이 틀린 사람: { ",
			["channel"] =
			{
				ctra = "CTRA Channel",
				ora = "oRA Channel",
				manual = "Manual Override",
			},
			needtarget = "대상이 있어야 주타겟으로 선택 가능합니다.",
			upgradenote = "이전버젼을 업그레이드하라고 알리게 됩니다.",
			advertisestart = "어그로를 끄는 사람에게 KLHThreatMeter를 사용하라는 말을 지금부터 광고하게 됩니다.",
			advertisestop = "KLHThreatMeter에 대한 광고 중단.",
			advertisemessage = "KLHThreatMeter를 사용하셨다면, %s의 어그로를 끌지 않았을 것입니다.",
		}
	}
}


