--[[ TinyTip by Thrae
-- 
--
-- Korean Localization
-- For TinyTipChat
--
-- Any wrong words, change them here.
-- 
-- TinyTipChatLocale should be defined in your FIRST localization
-- code.
--
-- Note: Other localization is in TinyTipLocale_koKR.
-- 
-- Contributors: Jspark
--]]


if TinyTipChatLocale and TinyTipChatLocale == "koKR" then
	TinyTipChatLocale_MenuTitle = "TinyTip 설정"

	TinyTipChatLocale_On = "켜기"
	TinyTipChatLocale_Off = "끄기"
	TinyTipChatLocale_GameDefault = "게임 기본 설정"
	TinyTipChatLocale_TinyTipDefault = "TinyTip의 기본 설정"

	if getglobal("TinyTipAnchorExists") then
		TinyTipChatLocale_Opt_Main_Anchor			= "위치"
		TinyTipChatLocale_Opt_MAnchor					= "유닛 위치"
		TinyTipChatLocale_Opt_FAnchor					= "프레임 위치"
		TinyTipChatLocale_Opt_MOffX						= "유닛 좌표 [X]"
		TinyTipChatLocale_Opt_MOffY						= "유닛 좌표 [Y]"
		TinyTipChatLocale_Opt_FOffX						= "프레임 좌표 [X]"
		TinyTipChatLocale_Opt_FOffY						= "프레임 좌표 [Y]"
		TinyTipChatLocale_Opt_AnchorAll				= "사용자 툴팁 위치"
		TinyTipChatLocale_Opt_AlwaysAnchor		= "항상 게임툴팁 위치"

		TinyTipChatLocale_ChatMap_Anchor = {
			["LEFT"]				= "LEFT", 
			["RIGHT"]				= "RIGHT", 
			["BOTTOMRIGHT"]	= "BOTTOMRIGHT", 
			["BOTTOMLEFT"]	= "BOTTOMLEFT", 
			["BOTTOM"]			= "BOTTOM", 
			["TOP"]					= "TOP", 
			["TOPLEFT"] 		= "TOPLEFT", 
			["TOPRIGHT"] 		= "TOPRIGHT",
			["CENTER"]			= "CENTER"
		}

		TinyTipChatLocale_Anchor_Cursor = "커서"
		TinyTipChatLocale_Anchor_Sticky = "붙임"

		TinyTipChatLocale_Desc_Main_Anchor = "툴팁의 위치 설정"
		TinyTipChatLocale_Desc_MAnchor = "유닛에 마우스를 올렸을 때 나타나는 툴팁의 위치 설정(in the world frame)"
		TinyTipChatLocale_Desc_FAnchor = "프레임에 마우스를 올렸을때 툴팁의 위치 설정(except the WorldFrame)"
		TinyTipChatLocale_Desc_MOffX = "유닛 툴팁의 가로 좌표 설정"
		TinyTipChatLocale_Desc_MOffY = "유닛 툴팁의 세로 좌표 설정"
		TinyTipChatLocale_Desc_FOffX = "프레임에 마우스를 올렸을 때 툴팁의 가로 좌표 설정"
		TinyTipChatLocale_Desc_FOffY = "프레임에 마우스를 올렸을 때 툴팁의 세로 좌표 설정"
		TinyTipChatLocale_Desc_AnchorAll = "GameTooltip_SetDefaultAnchor를 사용하는 모든 툴팁에 사용자 위치 적용, not just GameTooltip."
		TinyTipChatLocale_Desc_AlwaysAnchor = "GameTooltip이 나타날 때 강제로 위치를 지정합니다."

		if getglobal("GetAddOnMetadata")("TinyTipExtras", "Title") then
			TinyTipChatLocale_Opt_ETAnchor				= "기타 툴팁 위치"
			TinyTipChatLocale_Opt_ETOffX					= "기타 툴팁 좌표 [X]"
			TinyTipChatLocale_Opt_ETOffY					= "기타 툴팁 좌표 [Y]"
			TinyTipChatLocale_Desc_ETAnchor 			= "기타 툴팁의 위치 설정"
			TinyTipChatLocale_Desc_ETOffX					= "기타 툴팁의 가로 좌표 설정"
			TinyTipChatLocale_Desc_ETOffY					= "프레임에 마우스를 올렸을 때 툴팁의 가로 좌표 설정"

			TinyTipChatLocale_Opt_PvPIconAnchor1	= "PvP 계급 아이콘 위치"
			TinyTipChatLocale_Opt_PvPIconAnchor2	= "PvP 계급 아이콘 위치 관계"
			TinyTipChatLocale_Opt_PvPIconOffX			= "PvP 계급 아이콘 좌표 [X]"
			TinyTipChatLocale_Opt_PvPIconOffY			= "PvP 계급 아이콘 좌표 [Y]"

			TinyTipChatLocale_Desc_PvPIconAnchor1	= "PvP 계급 아이콘 위치 설정"
			TinyTipChatLocale_Desc_PvPIconAnchor2	= "PvP 계급 아이콘 위치 관계 설정"
			TinyTipChatLocale_Desc_PvPIconOffX		= "PvP 계급 아이콘 가로 위치 좌표 설정"
			TinyTipChatLocale_Desc_PvPIconOffY		= "PvP 계급 아이콘 세로 위치 좌표 설정"

			TinyTipChatLocale_Opt_RTIconAnchor1		= "공격대 대상 아이콘 위치"
			TinyTipChatLocale_Opt_RTIconAnchor2		= "공격대 대상 아이콘 위치 관계"
			TinyTipChatLocale_Opt_RTIconOffX			= "공격대 대상 아이콘 좌표 [X]"
			TinyTipChatLocale_Opt_RTIconOffY			= "공격대 대상 아이콘 좌표 [Y]"

			TinyTipChatLocale_Desc_RTIconAnchor1	= "공격대 대상 아이콘 위치 설정"
			TinyTipChatLocale_Desc_RTIconAnchor2	= "공격대 대상 아이콘 위치 관계 설정"
			TinyTipChatLocale_Desc_RTIconOffX			= "공격대 대상 아이콘 가로 위치 좌표 설정"
			TinyTipChatLocale_Desc_RTIconOffY			= "공격대 대상 아이콘 세로 위치 좌표 설정"

			TinyTipChatLocale_Opt_BuffAnchor1			= "버프 위치"
			TinyTipChatLocale_Opt_BuffAnchor2			= "버프 위치 관계"
			TinyTipChatLocale_Opt_BuffOffX				= "버프 좌표 [X]"
			TinyTipChatLocale_Opt_BuffOffY				= "버프 좌표 [Y]"

			TinyTipChatLocale_Opt_DebuffAnchor1		= "디버프 위치"
			TinyTipChatLocale_Opt_DebuffAnchor2		= "디버프 위치 관계"
			TinyTipChatLocale_Opt_DebuffOffX			= "디버프 좌표 [X]"
			TinyTipChatLocale_Opt_DebuffOffY			= "디버프 좌표 [Y]"

			TinyTipChatLocale_Desc_BuffAnchor1	= "버프 아이콘 위치 설정"
			TinyTipChatLocale_Desc_BuffAnchor2	= "버프 아이콘 위치 관계 설정"
			TinyTipChatLocale_Desc_BuffOffX			= "버프 아이콘 가로 위치 좌표 설정"
			TinyTipChatLocale_Desc_BuffOffY			= "버프 아이콘 세로 위치 좌표 설정"

			TinyTipChatLocale_Desc_DebuffAnchor1	= "디버프 아이콘 위치 설정"
			TinyTipChatLocale_Desc_DebuffAnchor2	= "디버프 아이콘 위치 관계 설정"
			TinyTipChatLocale_Desc_DebuffOffX			= "디버프 아이콘 가로 위치 좌표 설정"
			TinyTipChatLocale_Desc_DebuffOffY			= "디버프 아이콘 세로 위치 좌표 설정"
		end
	end

	TinyTipChatLocale_Opt_Main_Text					= "텍스트"
	TinyTipChatLocale_Opt_HideLevelText			= "레벨 텍스트 숨김"
	TinyTipChatLocale_Opt_HideRace						= "종족 텍스트 숨김"
	TinyTipChatLocale_Opt_KeyElite					= "등급 사용"
	TinyTipChatLocale_Opt_PvPRank						= "PvP 계급"
	TinyTipChatLocale_Opt_HideGuild					= "길드 텍스트 숨김"
	TinyTipChatLocale_Opt_LevelGuess				= "레벨 추측"
	TinyTipChatLocale_Opt_ReactionText			= "우호도 텍스트 표시"
	TinyTipChatLocale_Opt_KeyServer						= "서버명 대신 (*) 표시"

	TinyTipChatLocale_Desc_Main_Text = "유닛 툴팁의 내부에 표시되는 텍스트 변경"
	TinyTipChatLocale_Desc_HideLevelText = "레벨 텍스트 숨기기 설정"
	TinyTipChatLocale_Desc_HideRace = "플레이어의 종족 숨기기 설정"
	TinyTipChatLocale_Desc_KeyElite = "* : 정예, ! : 희귀, !* : 희귀 정예, ** : 월드 보스"
	TinyTipChatLocale_Desc_PvPRank = "PvP 계급을 텍스트에 표시 하기위한 옵션 설정"
	TinyTipChatLocale_Desc_HideGuild = "길드 이름 숨기기 설정"
	TinyTipChatLocale_Desc_ReactionText = "우호도 텍스트 표시 설정(우호적, 적대정, 등.)"
	TinyTipChatLocale_Desc_LevelGuess = "알수 없는 레벨 ?? 대신 당신의 레벨 +10으로 표시 설정"
	TinyTipChatLocale_Desc_KeyServer = "다른 서버의 대상 이름 다음에 (*)를 표시합니다."

	TinyTipChatLocale_Opt_Main_Appearance			= "형태"
	TinyTipChatLocale_Opt_Scale								= "크기"
	TinyTipChatLocale_Opt_Fade								= "서서히 사라짐 효과"
	TinyTipChatLocale_Opt_BGColor							= "배경 색상화"
	TinyTipChatLocale_Opt_Border							= "테두리 색상화"
	TinyTipChatLocale_Opt_SmoothBorder				= "부드러운 테두리와 배경"
	TinyTipChatLocale_Opt_Friends					= "우호도 특정 색상화"
	TinyTipChatLocale_Opt_HideInFrames				= "유닛 프레임을 위한 툴팁 숨김"
	TinyTipChatLocale_Opt_FormatDisabled			= "툴팁 형식화 비활성화"
	TinyTipChatLocale_Opt_Compact							= "작은 툴팁 표시"

	TinyTipChatLocale_ChatIndex_PvPRank = { 
		[1] = TinyTipChatLocale_Off, 
		[2] = "계급 이름 표시" ,
		[3] = "이름 뒤에 계급 번호 표시"
	}

	TinyTipChatLocale_ChatIndex_Fade = {
		[1] = "항상 서서히 사라짐",
		[2] = "즉시 사라짐"
	}

	TinyTipChatLocale_ChatIndex_BGColor = {
		[1] = TinyTipChatLocale_GameDefault,
		[2] = "NPC 색상과 같은 색을 사용",
		[3] = "항상 검은색"
	}

	TinyTipChatLocale_ChatIndex_Border = {
		[1] = TinyTipChatLocale_GameDefault,
		[2] = "테두리 숨김"
	}

	TinyTipChatLocale_ChatIndex_Friends = {
		[1] = "이름 색상만",
		[2] = "색상 사용 않함"
	}

	TinyTipChatLocale_Desc_Main_Appearance = "툴팁의 형태와 동작 설정"
	TinyTipChatLocale_Desc_Fade = "툴팁이 서서히 사라지거나 즉시 사라지는것을 설정"
	TinyTipChatLocale_Desc_Scale =  "툴팁의 크기 설정"
	TinyTipChatLocale_Desc_BGColor = "유닛 툴팁의 배경을 위한 색상 설정"
	TinyTipChatLocale_Desc_Border = "유닛 툴팁의 테두리를 위한 색상 설정"
	TinyTipChatLocale_Desc_SmoothBorder = "기본 투명도와 툴팁의 테두리와 배경의 크기를 변경합니다."
	TinyTipChatLocale_Desc_Friends = "친구나 길드원을 위해 각각의 색상 배경 사용"
	TinyTipChatLocale_Desc_HideInFrames = "유닛 프레임에 마우스를 올렸을 때 툴팁 숨김"
	TinyTipChatLocale_Desc_FormatDisabled = "TinyTip의 특별한 툴팁 형식화 비활성화"
	TinyTipChatLocale_Desc_Compact = "크기 변경 하지 않고 툴팁을 작게 합니다."


	if getglobal("GetAddOnMetadata")("TinyTipExtras", "Title") then
		TinyTipChatLocale_Opt_PvPIconScale	= "PvP 아이콘 크기"
		TinyTipChatLocale_Opt_RTIconScale		= "공격대 대상 아이콘 크기"
		TinyTipChatLocale_Opt_BuffScale			= "버프/디버프 아이콘 크기"

		TinyTipChatLocale_Desc_PvPIconScale		= "PvP 아이콘 크기 설정"
		TinyTipChatLocale_Desc_RTIconScale		= "공격대 대상 아이콘 크기 설정"
		TinyTipChatLocale_Desc_BuffScale			= "버프/디버프 아이콘 크기 설정"

		TinyTipChatLocale_Opt_Main_Targets				= "대상 관련..."
		TinyTipChatLocale_Opt_ToT									= "툴팁 유닛의 대상 표시"
		TinyTipChatLocale_Opt_ToP									= "파티"
		TinyTipChatLocale_Opt_ToR									= "공격대"

		TinyTipChatLocale_ChatIndex_ToT = {
			[1] = "새 라인에 유닛의 대상 툴팁 표시",
			[2] = "유닛이름 라인에 대상 표시"
		}

		TinyTipChatLocale_ChatIndex_ToP = {
			[1] = "각각의 이름 표시",
			[2] = "플레이어의 # 표시"
		}

		TinyTipChatLocale_ChatIndex_ToR = {
			[1] = "플레이어의 # 표시",
			[2] = "각 클래스의 개수 표시",
			[3] = "모든 이름 표시"
		}

		TinyTipChatLocale_Desc_Main_Targets = "유닛 툴팁에 대상의 대상 정보 추가"
		TinyTipChatLocale_Desc_ToT = "툴팁 유닛의 대상의 이름 표시 설정"
		TinyTipChatLocale_Desc_ToP = "툴팁의 유닛이 파티원을 대상으로 하였다면 표시하기 위한 옵션을 설정"
		TinyTipChatLocale_Desc_ToR = "툴팁의 유닛이 공격대원을 대상으로 하였다면 표시하기 위한 옵션을 설정"

		TinyTipChatLocale_Opt_Main_Extras					= "기타"
		TinyTipChatLocale_Opt_PvPIcon							= "PvP 계급 아이콘 표시"
		TinyTipChatLocale_Opt_ExtraTooltip				= "TinyTip의 기타 툴팁"
		TinyTipChatLocale_Opt_Buffs								= "버프"
		TinyTipChatLocale_Opt_Debuffs							= "디버프"
		TinyTipChatLocale_Opt_ManaBar					= "마나 상태바 표시"
		TinyTipChatLocale_Opt_RTIcon					= "공격대 대상 아이콘 표시"

		TinyTipChatLocale_ChatIndex_ExtraTooltip	= {
			[1] = "기타 애드온 정보 표시",
			[2] = "기타 애드온 & TinyTip의 기타 정보 표시"
		}

		TinyTipChatLocale_ChatIndex_Buffs = {
			[1] = "버프 8개를 표시",
			[2] = "시전 가능한 버프만 표시",
			[3] = "툴팁에 시전 가능한 버프의 숫자를 표시"
		}

		TinyTipChatLocale_ChatIndex_Debuffs = {
			[1] = "디버프 8개를 표시",
			[2] = "치료 가능한 디버프만 표시",
			[3] = "툴팁에 치료 가능한 디버프의 숫자를 표시",
			[4] = "툴팁에 치료 가능한 디버프의 각 유형에 따른 치료 가능 숫자를 표시",
			[5] = "툴팁에 치료 가능한 디버프의 모든 유형에 따른 치료 가능 숫자를 표시"
		}

		TinyTipChatLocale_Desc_Main_Extras = "유닛 툴팁에 기타 텍스쳐 추가"
		TinyTipChatLocale_Desc_PvPIcon = "툴팁의 왼쪽에 플레이어의 PvP 계급 아이콘 표시 설정"
		TinyTipChatLocale_Desc_ExtraTooltip = "다른 애드온 그리고/혹은 TinyTip으로 부터 분리된 툴팁에 정보를 추가."
		TinyTipChatLocale_Desc_Buffs			= "유닛의 버프에 관한 정보를 표시."
		TinyTipChatLocale_Desc_Debuffs		= "유닛의 디버프에 관한 정보를 표시."
		TinyTipChatLocale_Desc_ManaBar		= "체력바 아래에 마나 상태바를 표시."
		TinyTipChatLocale_Desc_RTIcon			= "만일 있다면, 툴팁의 유닛을 위한 공격대 대상 아이콘을 표시."
	end

	TinyTipChatLocale_Opt_Profiles = "각 케릭터당 설정을 저장"
	TinyTipChatLocale_Desc_Profiles = "각 케릭터당 혹은 전체 케릭터의 설정을 저장 할지의 여부를 전환."

	TinyTipChatLocale_Opt_Main_Default = "설정 초기화"
	TinyTipChatLocale_Desc_Main_Default = "이 애드온의 설정을 기본으로 되돌림"

	-- slash command-related stuff
	TinyTipChatLocale_DefaultWarning = "당신의 설정을 기본값으로 되돌리시겠습니까? Type in "
	TinyTipChatLocale_NotValidCommand = "는 허용되지 않는 명령어 입니다."

	TinyTipChatLocale_Confirm = "confirm" -- must be lowercase!
	TinyTipChatLocale_Opt_Slash_Default = "기본" -- ditto

	-- we're done with this.
	TinyTipChatLocale = nil
end
