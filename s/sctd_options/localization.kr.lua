-- SCT localization information
-- Korean Locale
-- Initial translation by SayClub, Next96
-- Translation by SayClub, Next96
-- Date 2006/08/09

if GetLocale() ~= "koKR" then return end

	--Event and Damage option values
	SCT.LOCALS.OPTION_EVENT101 = {name = "공격력", tooltipText = "적이 피해를 입었을 때 머리 위에 피해 수치를 표시합니다."};
	SCT.LOCALS.OPTION_EVENT102 = {name = "주기적인 피해", tooltipText = "분쇄나 저주와 같은 주기적인 주문 효과에 의한 피해의 표시 여부를 설정합니다."};
	SCT.LOCALS.OPTION_EVENT103 = {name = "주문/스킬 공격력", tooltipText = "자신의 주문/스킬 공격력 수치를 표시합니다."};
	SCT.LOCALS.OPTION_EVENT104 = {name = "소환수 공격력", tooltipText = "자신의 소환물이 적에게 피해를 입히는 피해의 여부 여부를 설정합니다."};
	SCT.LOCALS.OPTION_EVENT105 = {name = "치명타 색상", tooltipText = "치명타에 색상을 지정할 수 있습니다."};

	--Check Button option values
	SCT.LOCALS.OPTION_CHECK101 = { name = "SCTD 켜기", tooltipText = "SCT - 공격력 메시지 기능을 사용합니다."};
	SCT.LOCALS.OPTION_CHECK102 = { name = "메시지에 * 테두리 표시", tooltipText = "모든 공격력 메시지에 * 표 테두리를 표시합니다."};
	SCT.LOCALS.OPTION_CHECK103 = { name = "주문 속성 표시", tooltipText = "피해 주문의 속성을 표시합니다."};
	SCT.LOCALS.OPTION_CHECK104 = { name = "주문/스킬 이름", tooltipText = "주문/스킬 이름의 표시 여부를 설정합니다."};
	SCT.LOCALS.OPTION_CHECK105 = { name = "주문 저항", tooltipText = "주문에 대한 저항 메시지를 표시합니다."};
	SCT.LOCALS.OPTION_CHECK106 = { name = "대상 이름", tooltipText = "대상 이름을 메시지에 표시합니다."};
	SCT.LOCALS.OPTION_CHECK107 = { name = "WoW 공격력 메시지 끄기", tooltipText = "기본 WoW 공격력 메시지를 끕니다.\n\n주의: 이것은 게임 설정에서 고급 설정 아래에 있는 디스플레이 설정부분의 공격력 체크 박스와 같은 기능을 합니다. 그곳에 가시면 더 많은 설정을 할 수 있습니다."};
	SCT.LOCALS.OPTION_CHECK108 = { name = "대상만 표시", tooltipText = "현재 캐릭터의 대상에 대해서만 공격력을 표시할 것인지 선택합니다. AE 효과는 보여주지 않습니다만 동일한 이름의 몬스터에게는 표시될 수 있습니다."};
	SCT.LOCALS.OPTION_CHECK109 = { name = "PvP에 표시", tooltipText = "공격력을 PvP시에 표시할 것인지 선택합니다. PvP 서버에서는 그다지 유용하지는 않습니다."};
	SCT.LOCALS.OPTION_CHECK110 = { name = "SCT 움직임 사용", tooltipText = "SCT의 공격력 움직임(애니메이션)을 사용합니다. 선택하면 모든 메시지가 SCT 설정에 따라 표시됩니다."};
	SCT.LOCALS.OPTION_CHECK111 = { name = "치명타 고정 사용", tooltipText = "공격력이 치명타일 경우 화면에 고정합니다."};
	SCT.LOCALS.OPTION_CHECK112 = { name = "주문 색상 표시", tooltipText = "주문 피해량을 속성에 따라 색상으로 표시합니다. (색상은 선택 불가능)"};
	SCT.LOCALS.OPTION_CHECK113 = { name = "메시지 아래로 스크롤", tooltipText = "전투 메시지가 위에서 아래 방향으로 스크롤 됩니다."};

	--Slider options values
	SCT.LOCALS.OPTION_SLIDER101 = { name="메시지 X 좌표 위치", minText="-600", maxText="600", tooltipText = "메시지 중심축의 위치를 조정합니다."};
	SCT.LOCALS.OPTION_SLIDER102 = { name="메시지 Y 좌표 위치", minText="-600", maxText="600", tooltipText = "메시지 중심축의 위치를 조정합니다."};
	SCT.LOCALS.OPTION_SLIDER103 = { name="메시지 사라짐 속도", minText="빠르게", maxText="느리게", tooltipText = "메시지가 사라질 때 속도를 조정합니다."};
	SCT.LOCALS.OPTION_SLIDER104 = { name="메시지 크기", minText="작게", maxText="크게", tooltipText = "메시지의 크기를 조정합니다."};
	SCT.LOCALS.OPTION_SLIDER105 = { name="메시지 투명도", minText="0%", maxText="100%", tooltipText = "메시지틔 투명도를 조정합니다."};

	--Misc option values
	SCT.LOCALS.OPTION_MISC101 = {name="SCTD 설정 "..SCTD.Version};
	SCT.LOCALS.OPTION_MISC102 = {name="닫기", tooltipText = "모든 현재 설정을 저장하고 설정 메뉴를 닫습니다."};
	SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "SCT - 공격력 설정 메뉴를 엽니다."};
	SCT.LOCALS.OPTION_MISC104 = {name="공격력 이벤트", tooltipText = ""};
--	SCT.LOCALS.OPTION_MISC104 = {name="Damage Events", tooltipText = ""};
	SCT.LOCALS.OPTION_MISC105 = {name="화면 설정", tooltipText = ""};
	SCT.LOCALS.OPTION_MISC106 = {name="프레임 설정", tooltipText = ""};

	--Animation Types
	SCT.LOCALS.OPTION_SELECTION101 = { name="공격력 글꼴", tooltipText = "사용할 공격력 글꼴을 선택합니다.", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
	SCT.LOCALS.OPTION_SELECTION102 = { name="공격력 글꼴 테두리", tooltipText = "공격력 글꼴의 테두리 형태를 선택합니다.", table = {[1] = "없음",[2] = "얇게",[3] = "두껍게"}};
	SCT.LOCALS.OPTION_SELECTION103 = { name="공격력 움직임 형태", tooltipText = "움직임 형태를 선택합니다. SCT와는 다른 형태를 선택해야 알아보기 쉬울 것입니다.", table = {[1] = "세로 (보통)",[2] = "무지개",[3] = "가로",[4] = "모나게"}};
	SCT.LOCALS.OPTION_SELECTION104 = { name="공격력 양쪽 형태", tooltipText = "양쪽으로 스크롤되는 움직임 형태를 선택합니다.", table = {[1] = "교차",[2] = "공격력 왼쪽",[3] = "공격력 오른쪽", [4] = "모두 왼쪽", [5] = "모두 오른쪽"}};
--	SCT.LOCALS.OPTION_SELECTION104 = { name="Damage Side Style", tooltipText = "How side scrolling text should display", table = {[1] = "Alternating",[2] = "Damage Left",[3] = "Damage Right", [4] = "All Left", [5] = "All Right"}};