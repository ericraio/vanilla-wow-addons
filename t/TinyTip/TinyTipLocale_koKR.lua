--[[ TinyTip by Thrae
-- 
-- Korean Localization
-- 
-- TinyTipLocale should be defined in your FIRST included
-- localization file.
--
-- Note: Localized slash commands are in TinyTipChatLocale_koKR.
--
--]]

if TinyTipLocale and TinyTipLocale == "koKR" then
	-- slash commands
	SLASH_TINYTIP1 = "/툴팁"
	SLASH_TINYTIP2 = "/ttip"

	-- TinyTipUtil 
	TinyTipLocale_InitDB1		= "프로필이 없습니다. 기본으로 설정하겠습니다."
	TinyTipLocale_InitDB2		= "기본 설정."
	TinyTipLocale_InitDB3		= "새로운 버전의 자료가 있습니다. 이 자료로 바꾸겠습니다."
	TinyTipLocale_InitDB4		= "새로운 버전으로 변경했습니다."
	TinyTipLocale_InitDB5		= "준비."

	TinyTipLocale_DefaultDB1	= "모든 설정을 기본으로 초기화합니다."
	TinyTipLocale_DefaultDB2	= "오류 - 자료 버전이 일치하지 않습니다."

	-- TinyTip core
	TinyTipLocale_Tapped		= "선점"
	TinyTipLocale_RareElite		= string.format("%s %s", getglobal("ITEM_QUALITY3_DESC"), getglobal("ELITE") )

	TinyTipLocale_Level = getglobal("LEVEL")

	TinyTipLocale = nil -- we no longer need this
end
