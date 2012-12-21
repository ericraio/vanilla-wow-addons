local L = AceLibrary("AceLocale-2.2"):new("Buffalo")

L:RegisterTranslations("koKR", function()
    return {
    	["Lock"] = "고정",
    	["When activated, the buff frames are locked and the reference frames are hidden"] = "활성화하면 버프창이 고정되고 기준창을 숨깁니다",
    	["Buffs"] = "버프",
    	["Scale"] = "크기",
    	["Scale Buff Icons"] = "버프 아이콘의 크기",
    	["Rows"] = "열",
    	["Number of Rows. Only applies when Growth Precedence is Vertical"] = "수평 우선 확장 기능을 껐을 경우에만 적용될 열의 수",
    	["Columns"] = "칸",
    	["Number of Columns. Only applies when Growth Precedence is Horizontal"] = "수평 우선 확장 기능을 켰을 경우에만 적용될 칸의 수",
    	["X-Padding"] = "가로 간격",
    	["Distance between columns"] = "칸 간의 간격",
    	["Y-Padding"] = "세로 간격",
    	["Distance between rows"] = "열 간의 간격",
    	["Horizontal Direction"] = "수평 방향",
    	["In which horizontal direction should the display grow?"] = "수평 진행방향을 어떤 방향으로 설정하시겠습니까?",
    	["To the left"] = "좌측으로",
    	["To the right"]="우측으로",
    	["Vertical Direction"] = "수직 방향",
    	["In which vertical direction should the display grow?"] = "수직 진행방향을 어떤 방향으로 설정하시겠습니까?",
    	["Upwards"] = "위",
		["Downwards"] = "아래",
		["Growth Precedence"] = "진행 우선순위",
		["In which direction should the display grow first (horizontally or vertically)?"] = "진행 방향을 어느 방향(수평/수직) 우선으로 적용하시겠습니까?",
		["Horizontally"] = "수평",
		["Vertically"] = "수직",
------------------------------------------------------ 15:44
		["Manipulate Buffs Display"] = "다중 버프 표시",
		["Control the distance between rows/columns"] = "열/칸 간의 거리 조절",
		["Padding"] = "간격",
		["Debuffs"] = "디버프",
		["Manipulate Debuffs Display"] = "다중 디버프 표시",
		["Scale Debuff Icons"] = "디버프 아이콘 표시",
		["Weapon Buffs"] = "무기 마법부여",
		["Manipulate Weapon Buffs Display"] = "자동 무기 마법부여 표시",
		["Reset"] = "초기화",
----------------------------------------------------
		["Hide"] = "숨김",
		["Hides these buff frames"] = "버프 프레임을 숨깁니다",
		["Verbose Timers"] = "시간표시 변경",
		["Replaces the default time format for timers with HH:MM or MM:SS"] = "HH:MM 또는 MM:SS 대신에 기본 시간표시 형태를 사용합니다",
-------------------------------------------------------
		["Flashing"] = "반짝임",
		["Toggle flashing on fading buffs"] = "버프 사라짐에 대한 반짝임 효과를 토글합니다",
		["Timers"] = "타이머",
		["Customize buff timers"] = "사용자 설정 버프 시간표시",
		["White Timers"] = "흰색 시간표시",
		["Use white timers instead of yellow ones"] = "노란색 대신에 흰색 시간표시를 사용합니다",
----------------------------------------------------
		["config"] = "설정",
		["Config"] = "환경설정",
-----------------------------------------------------------
    }
end)
