-- SCT localization information
-- Korean Locale
-- Initial translation by SayClub, Next96
-- Translation by SayClub, Next96
-- Date 2006/08/02

if GetLocale() ~= "koKR" then return end

--Locals
SCT.LOCALS.MSG_EXAMPLE = "SCT 메시지";

-- Static Messages
SCT.LOCALS.LowHP= "체력 낮음!";					-- Message to be displayed when HP is low
SCT.LOCALS.LowMana= "마나 낮음!";					-- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*";								-- Icon to show self hits
SCT.LOCALS.Combat = "+전투시작";						-- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "-전투종료";					-- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "연계 포인트";			  		-- Message to be displayed when gaining a combo point
SCT.LOCALS.FiveCPMessage = "포인트 마무리!"; -- Message to be displayed when you have 5 combo points
SCT.LOCALS.ExtraAttack = "추가 공격!"; -- Message to be displayed when time to execute

--Option messages
SCT.LOCALS.STARTUP = "전투 메시지 확장 "..SCT.Version.." 이 로드되었습니다. /sctmenu 명령으로 설정 창을 열 수 있습니다.";
SCT.LOCALS.Option_Crit_Tip = "이 전투 상황 메시지를 치명타 메시지와 같은 형태로 표시합니다.";
SCT.LOCALS.Option_Msg_Tip = "이 전투상황을 화면 위에 크게 표시합니다.";
SCT.LOCALS.Frame1_Tip = "이벤트를 ANIMATION FRAME 1에 표시합니다.";
SCT.LOCALS.Frame2_Tip = "이벤트를 ANIMATION FRAME 2에 표시합니다.";

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00전투메시지 확장 경고|r\n\n전투메시지 확장 설정 파일이 현재 버전과 일치하지 않습니다. 에러 또는 비정상적인 작동을 해결하려면, 초기화 버튼을 누르거나 |cff00ff00/sctreset|r 명령어를 입력하여 설정을 초기화 해주세요.";
SCT.LOCALS.Load_Error = "|cff00ff00SCT 옵션들을 불려오는데 오류가 발생하였습니다. SCT가 작동하지 않을 수 있습니다.|r";

--nouns
SCT.LOCALS.TARGET = "대상이 ";
SCT.LOCALS.PROFILE = "전투 메시지 확장 프로파일 로딩: |cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "전투 메시지 확장 프로파일 삭제: |cff00ff00";
SCT.LOCALS.PROFILE_NEW = "전투 메시지 확장 새 프로파일: |cff00ff00";
SCT.LOCALS.WARRIOR = "전사";
SCT.LOCALS.ROGUE = "도적";
SCT.LOCALS.HUNTER = "사냥꾼";
SCT.LOCALS.MAGE = "마법사";
SCT.LOCALS.WARLOCK = "흑마법사";
SCT.LOCALS.DRUID = "드루이드";
SCT.LOCALS.PRIEST = "사제";
SCT.LOCALS.SHAMAN = "주술사";
SCT.LOCALS.PALADIN = "성기사";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "명령어: \n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay '할말' (하얀색으로 표시)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay '할말' 빨간색(0-10) 녹색(0-10) 파란색(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "예: /sctdisplay '치료좀' 10 0 0\n밝은 빨간색으로 '치료좀' 이라는 문구를 표시합니다.\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "색 예제: 빨간색 = 10 0 0, 녹색 = 0 10 0, 파란색 = 0 0 10,\n노란색 = 10 10 0, 보라색 = 10 0 10, 하늘색 = 0 10 10";

--Fonts
SCT.LOCALS.FONTS = { 
	[1] = { name="기본값", path="Fonts\\2002.TTF"},
	[2] = { name="기본값(굵게)", path="Fonts\\2002b.TTF"},
	[3] = { name="데미지폰트", path="Fonts\\K_Damage.TTF"},
	[4] = { name="퀘스트폰트", path="Fonts\\K_Pagetext.TTF"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME			= "전투 메시지 확장".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCT.LOCALS.CB_LONG_DESC	= "유용한 전투 메시지를 팝업 시킵니다. - 사용해 보세요!";
SCT.LOCALS.CB_ICON			= "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"