local L = AceLibrary("AceLocale-2.2"):new("FuBar_ToFu")

L:RegisterTranslations("koKR", function() return {
	["Current Flight"] = "현재 비행",
	["Previous Flight"] = "이전 비행",

	["From"] = "출발지",
	["To"] = "목적지",
	["Cost"] = "비용",
	["Time Taken"] = "소요 시간",
	["Average Time"] = "평균 시간",

	["Not in flight"] = "비행 이력 없음",
	["No previous flight"] = "이전 비행 없음",
	
	["Click to copy the time remaining in flight to the chatbox."] = "클릭하면 남은 비행 시간을 대화창에 복사합니다.",
	
	["Takes"] = "소요",
	["Flown %s times"] = "%s 회 비행",
	
	["Data"] = "자료",
	["Various options to do with saved flight data"] = "저장된 비행 자료에 다양한 설정을 적용합니다",
	
	['Default Data'] = "기본 자료",
	["Load the default flight-time dataset."] = "기본 비행시간 자료를 불러옵니다.",
	
	["Delete *ALL* saved flight path data for your faction."] = "현재 진영에서 저장된 비행 경로를 모두 삭제합니다.",
	["Clear Data"] = "자료 삭제",
	
	["Hooks"] = "외부모듈",
	["Other addons to hook into"] = "외부 애드온을 이용합니다.",
	
	["estimated"] = "(소요)",
	["reversed"] = "(반대)",
	["So Far"] = "이상",
} end)
