-- SCT localization information
-- Korean Locale
-- Initial translation by Next96, SayClub
-- Translation by Next96
-- Date 08/09/2006

if GetLocale() ~= "koKR" then return end

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "피해량", tooltipText = "근접 및 기타(화염, 낙하, 등등...) 피해를 표시합니다."};
SCT.LOCALS.OPTION_EVENT2 = {name = "빗맞힘", tooltipText = "근접공격 빗맞힘 메시지 표시합니다."};
SCT.LOCALS.OPTION_EVENT3 = {name = "피함", tooltipText = "근접공격 피함 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT4 = {name = "막음", tooltipText = "근접공격 막음 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT5 = {name = "방어함", tooltipText = "근접공격 방어함 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT6 = {name = "주문 피해량", tooltipText = "주문에 의한 피해를 표시합니다."};
SCT.LOCALS.OPTION_EVENT7 = {name = "치유량", tooltipText = "주문에 의한 치유량을 표시합니다."};
SCT.LOCALS.OPTION_EVENT8 = {name = "주문 저항", tooltipText = "주문에 대한 저항 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT9 = {name = "디버프", tooltipText = "디버프에 걸렸을 때 표시합니다."};
SCT.LOCALS.OPTION_EVENT10 = {name = "흡수함", tooltipText = "몹의 데미지를 흡수할 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT11 = {name = "체력 낮음", tooltipText = "체력이 낮은 상태일 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT12 = {name = "마나 낮음", tooltipText = "마나가 낮은 상태일 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT13 = {name = "기력/분노 생성", tooltipText = "물약,아이템,버프 등으로 인해\n마나, 분노, 기력등이 생성될 때\n메시지를 표시합니다.(정기적인 생성은 제외)"};
SCT.LOCALS.OPTION_EVENT14 = {name = "전투 상태", tooltipText = "전투중 상태에 들어가거나\n전투중 상태를 벗어날 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT15 = {name = "연계 포인트", tooltipText = "연계 포인트가 모일때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT16 = {name = "명예 점수", tooltipText = "명예 점수를 획득시 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT17 = {name = "버프 걸림", tooltipText = "버프에 걸렸을 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT18 = {name = "버프 사라짐", tooltipText = "버프가 사라질 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT19 = {name = "기술 피해량", tooltipText = "캐릭터의 직업 기술 피해량을 표시합니다. (마무리 일격, 천벌의 망치, 살쾡이의 이빨 등등)"};
SCT.LOCALS.OPTION_EVENT20 = {name = "평판", tooltipText = "평판을 획득하거나 또는 평판이 감소할 때 메시지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT21 = {name = "자신의 치유량", tooltipText = "다른 사람에게 얼마나 치유를 했는지를 표시합니다."};
SCT.LOCALS.OPTION_EVENT22 = {name = "숙련도", tooltipText = "기술에 대한 숙련도가 증가했을 때 표시합니다."};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "전투 메시지 확장 켜기", tooltipText = "전투 메시지 확장 기능을 사용합니다."};
SCT.LOCALS.OPTION_CHECK2 = { name = "메시지에 * 테두리 표시", tooltipText = "전투 메시지에 * 표 테두리를 표시합니다."};
SCT.LOCALS.OPTION_CHECK3 = { name = "치유한 사람 표시", tooltipText = "당신에게 누가 어떤 주문으로 치유를 했는지 표시합니다."};
SCT.LOCALS.OPTION_CHECK4 = { name = "메시지 아래로 스크롤", tooltipText = "전투 메시지가 위에서 아래 방향으로 스크롤 됩니다."};
SCT.LOCALS.OPTION_CHECK5 = { name = "치명타 메시지 고정", tooltipText = "치명타 및 극대화 메시지를 자신의 머리 위치에 고정시킵니다."};
SCT.LOCALS.OPTION_CHECK6 = { name = "피해 주문 속성 표시", tooltipText = "피해 주문의 속성을 표시합니다."};
SCT.LOCALS.OPTION_CHECK7 = { name = "피해량에 쓰이는 글꼴 변경", tooltipText = "피해량에 쓰이는 글꼴을 전투메시지 확장에서 사용중인 글꼴로 변경합니다.\n\n알림: 이 기능을 적용하려면 설정 후 반드시 재접속 해야합니다. UI 재실행으로는 작동하지 않습니다."};
SCT.LOCALS.OPTION_CHECK8 = { name = "모든 생성 표시", tooltipText = "전투창에 표시되지 않는 마나/기력/분노 생성도 모두 표시합니다.\n\n알림: 정규 생성 이벤트에 의존성을 가지고 작동하기 때문에 스팸성이 매우 강합니다. 그리고 드루이드가 변신 직후 다시 변신을 풀 때 종종 오작동 하는 경우가 있습니다."};
SCT.LOCALS.OPTION_CHECK9 = { name = "독립적 FPS 모드", tooltipText = "동작 속도를 자신의 FPS에 맞추어 변경합니다. 옵션을 켰을 때, 시스템 사양이 낮거나 랙이 심한 상황에서 스크롤 애니메이션이 보다 고정적이고 빠르게 올라갑니다."};
SCT.LOCALS.OPTION_CHECK10 = { name = "과도한 치유량 표시", tooltipText = "자신 또는 대상에게 얼마나 과도한 치유를 하는지 표시합니다. '자신이 치유한 양' 설정에 의존성을 가지고 있습니다."};
SCT.LOCALS.OPTION_CHECK11 = { name = "소리로 경고", tooltipText = "경고 알림할 때 소리를 사용할 것인지 선택합니다."};
SCT.LOCALS.OPTION_CHECK12 = { name = "주문 피해량 색상 표시", tooltipText = "주문 피해량을 속성에 따라 색상으로 표시합니다. (색상은 선택 불가능)"};
SCT.LOCALS.OPTION_CHECK13 = { name = "사용자 이벤트 사용하기", tooltipText = "사용자 이벤트를 사용할 것인지 선택합니다. 사용하지 않으면 SCT의 메모리 점유율이 낮아집니다."};
SCT.LOCALS.OPTION_CHECK14 = { name = "라이트모드 사용", tooltipText = "라이트 모드를 사용할 것인지 선택합니다. 라이트모드는 와우의 기본 이벤트만을 표시하며, 전투로그 파싱을 최소화합니다. 이렇게하면 SCT의 성능이 향상됩니다."};
SCT.LOCALS.OPTION_CHECK15 = { name = "플래시효과", tooltipText = "치명타 메시지에 플래시효과를 표시합니다."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="메시지 스크롤 속도조정", minText="빠름", maxText="느림", tooltipText = "글씨 스크롤 속도를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER2 = { name="글씨 크기", minText="작게", maxText="크게", tooltipText = "글씨 크기를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER3 = { name="체력 %", minText="10%", maxText="90%", tooltipText = "체력이 몇 % 가 되면 경고 메시지를 출력할 지 조정합니다."};
SCT.LOCALS.OPTION_SLIDER4 = { name="마나 %",  minText="10%", maxText="90%", tooltipText = "마나가 몇 % 가 되면 경고 메시지를 출력할 지 조정합니다."};
SCT.LOCALS.OPTION_SLIDER5 = { name="글씨 투명도", minText="0%", maxText="100%", tooltipText = "글씨의 투명도를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER6 = { name="메시지 스크롤 거리조정", minText="작게", maxText="크게", tooltipText = "각 메시지가 갱신될 때 글자의 스크롤 범위를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER7 = { name="글자 X 좌표 위치", minText="-300", maxText="300", tooltipText = "글자의 중심축이 위치할 곳을 조정합니다."};
SCT.LOCALS.OPTION_SLIDER8 = { name="글자 Y 좌표 위치", minText="-300", maxText="300", tooltipText = "글자의 중심축이 위치할 곳을 조정합니다."};
SCT.LOCALS.OPTION_SLIDER9 = { name="메시지 X 좌표 위치", minText="-600", maxText="600", tooltipText = "메시지 중심축의 위치를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER10 = { name="메시지 Y 좌표 위치", minText="-600", maxText="600", tooltipText = "메시지 중심축의 위치를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER11 = { name="메시지 사라짐 속도", minText="빠름", maxText="느림", tooltipText = "메시지가 사라질 때 속도를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER12 = { name="메시지 크기", minText="작게", maxText="크게", tooltipText = "메시지의 크기를 조정합니다."};
SCT.LOCALS.OPTION_SLIDER13 = { name="Healer Filter", minText="0", maxText="500", tooltipText = "Controls the minimum amount a heal needs to heal you for to appear in SCT. Good for filtering out frequent small heals like Totems, Blessings, etc..."};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="전투 메시지 설정 "..SCT.Version, tooltipText = "왼쪽 클릭 이동"};
SCT.LOCALS.OPTION_MISC2 = {name="이벤트 설정"};
SCT.LOCALS.OPTION_MISC3 = {name="글자 설정"};
SCT.LOCALS.OPTION_MISC4 = {name="기타 설정"};
SCT.LOCALS.OPTION_MISC5 = {name="경고 설정"};
SCT.LOCALS.OPTION_MISC6 = {name="글자 움직임 설정"};
SCT.LOCALS.OPTION_MISC7 = {name="프로파일 선택"};
SCT.LOCALS.OPTION_MISC8 = {name="저장 & 닫기", tooltipText = "현재 모든 설정을 저장하고 설정창을 닫습니다."};
SCT.LOCALS.OPTION_MISC9 = {name="초기화", tooltipText = "-경고-\n\n정말로 전투메시지 확장의 설정을 초기화 하시겠습니까?"};
SCT.LOCALS.OPTION_MISC10 = {name="프로파일", tooltipText = "다른 캐릭터의 프로파일을 선택합니다."};
SCT.LOCALS.OPTION_MISC11 = {name="불러오기", tooltipText = "다른 캐릭터의 프로파일을 이 캐릭터의 프로파일로 불러옵니다."};
SCT.LOCALS.OPTION_MISC12 = {name="삭제", tooltipText = "캐릭터 프로파일을 삭제합니다."}; 
SCT.LOCALS.OPTION_MISC13 = {name="취소", tooltipText = "선택을 취소합니다."};
SCT.LOCALS.OPTION_MISC14 = {name="글자", tooltipText = ""};
SCT.LOCALS.OPTION_MISC15 = {name="메시지", tooltipText = ""};
SCT.LOCALS.OPTION_MISC16 = {name="메시지 설정"};
SCT.LOCALS.OPTION_MISC17 = {name="주문 설정"};
SCT.LOCALS.OPTION_MISC18 = {name="기타 주문 설정", tooltipText = ""};
SCT.LOCALS.OPTION_MISC19 = {name="주문들", tooltipText = ""};
SCT.LOCALS.OPTION_MISC20 = {name="글자2", tooltipText = ""};
SCT.LOCALS.OPTION_MISC21 = {name="글자2 설정", tooltipText = ""};
SCT.LOCALS.OPTION_MISC22 = {name="기본 프로파일", tooltipText = "기존의 프로파일 설정"};
SCT.LOCALS.OPTION_MISC23 = {name="최소 프로파일", tooltipText = "성능 향상을 위한 프로파일. 가장 기본적인 sct만을 표시하도록 설정된 프로파일 설정"};
SCT.LOCALS.OPTION_MISC24 = {name="분할 프로파일", tooltipText = "분할된 프로파일. 피해 데미지와 이벤트를 오른쪽에, 치유와 버프를 왼쪽에 표시하는 프로파일 설정"};
SCT.LOCALS.OPTION_MISC25 = {name="Grayhoof 프로파일", tooltipText = "제작자의 프로파일 설정"};
SCT.LOCALS.OPTION_MISC26 = {name="프로파일 선택", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="SCTD 프로파일", tooltipText = "SCTD 프로파일을 불러옵니다. SCTD를 설치했다면 피해 데미지는 오른쪽에 공격 데미지는 왼쪽에 표시합니다. 그리고 나머지는 상단에 표시합니다."};

--Animation Types
SCT.LOCALS.OPTION_SELECTION1 = { name="움직임 형태", tooltipText = "글자의 움직임 형태를 선택합니다.", table = {[1] = "세로 (보통)",[2] = "무지개",[3] = "가로",[4] = "모나게"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="옆면 스크롤 형태", tooltipText = "옆면의 움직이는 글자의 표시형태를 설정합니다.", table = {[1] = "교차",[2] = "피해량을 왼쪽에",[3] = "피해량을 오른쪽에"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="글꼴", tooltipText = "사용할 글꼴을 선택합니다.", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION4 = { name="글꼴 테두리", tooltipText = "글꼴의 테두리 형태를 선택합니다.", table = {[1] = "없음",[2] = "얇게",[3] = "두껍게"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="메시지 글꼴", tooltipText = "메시지에 쓰일 글꼴을 선택합니다.", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION6 = { name="메시지 글꼴 테두리", tooltipText = "메시지의 테두리 형태를 선택합니다.", table = {[1] = "없음",[2] = "얇게",[3] = "두껍게"}};
