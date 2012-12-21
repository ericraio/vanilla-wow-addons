-- Version : Korean
-- Maintained by eerieN
-- Last Update : 09/23/2005

if (GetLocale() == "koKR") then
	-- "Bonus" inventory types
	-- WARNING: these lines must match the text displayed by the client exactly.
	-- Can't use arbitrary phrases. Edit and translate with care.
	EQUIPCOMPARE_INVTYPE_WAND = "마법봉";
	EQUIPCOMPARE_INVTYPE_GUN = "총";
	EQUIPCOMPARE_INVTYPE_GUNPROJECTILE = "탄환";
	EQUIPCOMPARE_INVTYPE_BOWPROJECTILE = "화살";
	EQUIPCOMPARE_INVTYPE_CROSSBOW = "석궁";
	EQUIPCOMPARE_INVTYPE_THROWN = "투척류";

	-- Usage text
	EQUIPCOMPARE_USAGE_TEXT = { "EquipCompare "..EQUIPCOMPARE_VERSIONID.." 도움말 :",
								"아이템을 비교하기 쉽도록 착용 중인 아이템을 툴팁 옆에 보여준다.",
								"명령어 :",
								"/eqc 	       - 아이템 비교 켜기/끄기",
								"/eqc [on|off] - 아이템 비교 켜기/끄기",
								"/eqc control  - 컨트롤 키 모드 켜기/끄기",
							  	"/eqc cv       - CharactersViewer 와 호환 모드 켜기/끄기",
							  	"/eqc alt      - CharactersViewer 와 호환을 위한 알트 키 모드 켜기/끄기",
								"/eqc shift    - 툴팁 창이 너무 길 경우 툴팁을 위로 이동 켜기/끄기",
								"/eqc help     - 도움말",
								"(/eqc 대신에 /equipcompare 사용 가능)" };

	-- Feedback text
	EQUIPCOMPARE_HELPTIP = "(도움말을 보시려면 /equipcompare help 또는 /eqc help 를 치세요)";
	EQUIPCOMPARE_TOGGLE_ON = "EquipCompare 켜짐";
	EQUIPCOMPARE_TOGGLE_OFF = "EquipCompare 꺼짐";
	EQUIPCOMPARE_TOGGLECONTROL_ON = "컨트롤 키 모드 켜짐";
	EQUIPCOMPARE_TOGGLECONTROL_OFF = "컨트롤 키 모드 꺼짐";
	EQUIPCOMPARE_TOGGLECV_ON = "CharactersViewer 와 호환 모드 켜짐";
	EQUIPCOMPARE_TOGGLECV_OFF = "CharactersViewer 와 호환 모드 꺼짐";
	EQUIPCOMPARE_TOGGLEALT_ON = "CharactersViewer 를 위한 알트 키 모드 켜짐";
	EQUIPCOMPARE_TOGGLEALT_OFF = "CharactersViewer 를 위한 알트 키 모드 꺼짐";
	EQUIPCOMPARE_SHIFTUP_ON = "툴팁 위로 이동 기능 켜짐";
	EQUIPCOMPARE_SHIFTUP_OFF = "툴팁 위로 이동 기능 꺼짐";

	-- Cosmos configuration texts
	EQUIPCOMPARE_COSMOS_SECTION = "EquipCompare";
	EQUIPCOMPARE_COSMOS_SECTION_INFO = "아이템을 비교하기 쉽게 착용 중인 아이템을 보여주는 기능입니다.";
	EQUIPCOMPARE_COSMOS_HEADER = "EquipCompare "..EQUIPCOMPARE_VERSIONID;
	EQUIPCOMPARE_COSMOS_HEADER_INFO = "아이템을 비교하기 쉽게 착용 중인 아이템을 보여주는 기능입니다.";
	EQUIPCOMPARE_COSMOS_ENABLE = "EquipCompare 켜기";
	EQUIPCOMPARE_COSMOS_ENABLE_INFO = "이 옵션을 켜면 아이템에 마우스를 올려놓을 경우 그 아이템에 대응하는 현재 착용 중인 아이템을 보여줍니다.";
	EQUIPCOMPARE_COSMOS_CONTROLMODE = "컨트롤 키 모드 켜기";
	EQUIPCOMPARE_COSMOS_CONTROLMODE_INFO = "이 옵션을 켜면 컨트롤 키를 누르고 있을 때만 착용중인 아이템을 보여줍니다.";
	EQUIPCOMPARE_COSMOS_CVMODE = "CharactersViewer 와 호환 모드 켜기";
	EQUIPCOMPARE_COSMOS_CVMODE_INFO = "이 옵션을 켜면 현재 캐릭터의 아이템 대신에 CharactersViewer 에서 선택된 캐릭터가 착용 중인 아이템을 보여줍니다.";
	EQUIPCOMPARE_COSMOS_ALTMODE = "CharactersViewer 를 위한 알트 키 모드 켜기";
	EQUIPCOMPARE_COSMOS_ALTMODE_INFO = "이 옵션을 켜면 알트 키를 누르고 있을 때만 CharactersViewer 에서 선택된 캐릭터가 착용 중인 아이템을 보여줍니다.";
	EQUIPCOMPARE_COSMOS_SHIFTUP = "툴팁 위로 이동 기능 켜기"
	EQUIPCOMPARE_COSMOS_SHIFTUP_INFO = "이 옵션을 켜면 툴팁의 위치를 위로 옮겨 주어, 툴팁 창이 너무 길어 메인 툴팁의 아래부분이 잘리는 것을 방지해줍니다.";
	EQUIPCOMPARE_COSMOS_SLASH_DESC = "EquipCompare 켜기/끄기 기능을 활성화. 도움말을 보시려면 /equipcompare help 를 치세요."

	-- Misc labels
	EQUIPCOMPARE_EQUIPPED_LABEL = "착용 중인 아이템";
	EQUIPCOMPARE_GREETING = "아이템 비교 "..EQUIPCOMPARE_VERSIONID.." 로딩 완료";

end
