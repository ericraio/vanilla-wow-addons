--[[ TinyTip by Thrae
-- 
--
-- Simplified Chinese Localization
-- For TinyTipChat
--
-- Any wrong words, change them here.
-- 
-- TinyTipChatLocale should be defined in your FIRST localization
-- code.
--
-- Note: Other localization is in TinyTipLocale_zhCN.
-- 
-- Contributors: hk2717
--]]

if TinyTipChatLocale and TinyTipChatLocale == "zhCN" then
	TinyTipChatLocale_MenuTitle = "TinyTip设置"

	TinyTipChatLocale_On = "开启"
	TinyTipChatLocale_Off = "关闭"
	TinyTipChatLocale_GameDefault = "游戏默认"
	TinyTipChatLocale_TinyTipDefault = "TinyTip默认"

	if getglobal("TinyTipAnchorExists") then
		TinyTipChatLocale_Opt_Main_Anchor			= "锚点"
		TinyTipChatLocale_Opt_MAnchor					= "人物信息条锚点"
		TinyTipChatLocale_Opt_FAnchor					= "框体信息条锚点"
		TinyTipChatLocale_Opt_MOffX						= "人物信息条偏移量[X]"
		TinyTipChatLocale_Opt_MOffY						= "人物信息条偏移量[Y]"
		TinyTipChatLocale_Opt_FOffX						= "框体信息条偏移量[X]"
		TinyTipChatLocale_Opt_FOffY						= "框体信息条偏移量[Y]"
		TinyTipChatLocale_Opt_AnchorAll				= "将自定义信息条依附锚点"
		TinyTipChatLocale_Opt_AlwaysAnchor		= "总是将游戏信息条依附锚点"

		TinyTipChatLocale_ChatMap_Anchor = {
			["LEFT"]				= "左端", 
			["RIGHT"]				= "右端", 
			["BOTTOMRIGHT"]	= "右下角", 
			["BOTTOMLEFT"]	= "左下角", 
			["BOTTOM"]			= "底端", 
			["TOP"]					= "顶端", 
			["TOPLEFT"] 		= "左上角", 
			["TOPRIGHT"] 		= "右上角",
			["CENTER"]			= "中央"
		}

		TinyTipChatLocale_Anchor_Cursor = "鼠标"
		TinyTipChatLocale_Anchor_Sticky = "依附"

		TinyTipChatLocale_Desc_Main_Anchor = "设置信息条位置。"
		TinyTipChatLocale_Desc_MAnchor = "设置鼠标移经人物时显示的信息条的锚点位置 。"
		TinyTipChatLocale_Desc_FAnchor = "设置鼠标移经任何框体时显示的信息条的锚点位置。（世界框体除外）"
		TinyTipChatLocale_Desc_MOffX = "设置人物信息条相对于锚点的水平偏移量。"
		TinyTipChatLocale_Desc_MOffY = "设置人物信息条相对于锚点的垂直偏移量。"
		TinyTipChatLocale_Desc_FOffX = "设置框体信息条相对于锚点的水平偏移量。"
		TinyTipChatLocale_Desc_FOffY = "设置框体信息条相对于锚点的垂直偏移量。"
		TinyTipChatLocale_Desc_AnchorAll = "将自定义锚点设置应用于所有使用游戏默认锚点的框体信息条。"
		TinyTipChatLocale_Desc_AlwaysAnchor = "强制性对任何游戏信息条应用自定义锚点设置，包括矿点等的信息条和任何游戏信息条。"

		if getglobal("GetAddOnMetadata")("TinyTipExtras", "Title") then
			TinyTipChatLocale_Opt_ETAnchor				= "额外信息条锚点"
			TinyTipChatLocale_Opt_ETOffX					= "额外信息条偏移量[X]"
			TinyTipChatLocale_Opt_ETOffY					= "额外信息条偏移量[Y]"
			TinyTipChatLocale_Desc_ETAnchor 			= "设置额外信息条的锚点位置。"
			TinyTipChatLocale_Desc_ETOffX					= "设置额外信息条相对于锚点的水平偏移量。"
			TinyTipChatLocale_Desc_ETOffY					= "设置额外信息条相对于锚点的垂直偏移量。"

			TinyTipChatLocale_Opt_PvPIconAnchor1	= "军衔图标锚点"
			TinyTipChatLocale_Opt_PvPIconAnchor2	= "军衔图标相对锚点"
			TinyTipChatLocale_Opt_PvPIconOffX			= "军衔图标偏移量[X]"
			TinyTipChatLocale_Opt_PvPIconOffY			= "军衔图标偏移量[Y]"

			TinyTipChatLocale_Desc_PvPIconAnchor1	= "设置军衔图标的锚点位置。"
			TinyTipChatLocale_Desc_PvPIconAnchor2	= "设置军衔图标的相对锚点位置。"
			TinyTipChatLocale_Desc_PvPIconOffX		= "设置军衔图标相对于锚点的水平偏移量。"
			TinyTipChatLocale_Desc_PvPIconOffY		= "设置军衔图标相对于锚点的垂直偏移量。"

			TinyTipChatLocale_Opt_RTIconAnchor1		= "团队目标图标锚点"
			TinyTipChatLocale_Opt_RTIconAnchor2		= "团队目标图标相对锚点"
			TinyTipChatLocale_Opt_RTIconOffX			= "团队目标图标偏移量[X]"
			TinyTipChatLocale_Opt_RTIconOffY			= "团队目标图标偏移量[Y]"

			TinyTipChatLocale_Desc_RTIconAnchor1	= "设置团队目标图标的锚点位置。"
			TinyTipChatLocale_Desc_RTIconAnchor2	= "设置团队目标图标的相对锚点位置。"
			TinyTipChatLocale_Desc_RTIconOffX			= "设置团队目标图标相对于锚点的水平偏移量。"
			TinyTipChatLocale_Desc_RTIconOffY			= "设置团队目标图标相对于锚点的垂直偏移量。"

			TinyTipChatLocale_Opt_BuffAnchor1			= "增益效果图标锚点"
			TinyTipChatLocale_Opt_BuffAnchor2			= "增益效果图标相对锚点"
			TinyTipChatLocale_Opt_BuffOffX				= "增益效果图标偏移量[X]"
			TinyTipChatLocale_Opt_BuffOffY				= "增益效果图标偏移量[Y]"

			TinyTipChatLocale_Opt_DebuffAnchor1		= "不良效果图标锚点"
			TinyTipChatLocale_Opt_DebuffAnchor2		= "不良效果图标相对锚点"
			TinyTipChatLocale_Opt_DebuffOffX			= "不良效果图标偏移量[X]"
			TinyTipChatLocale_Opt_DebuffOffY			= "不良效果图标偏移量[Y]"

			TinyTipChatLocale_Desc_BuffAnchor1	= "设置增益效果图标的锚点位置。"
			TinyTipChatLocale_Desc_BuffAnchor2	= "设置增益效果图标的相对锚点位置。"
			TinyTipChatLocale_Desc_BuffOffX			= "设置增益效果图标相对于锚点的水平偏移量。"
			TinyTipChatLocale_Desc_BuffOffY			= "设置增益效果图标相对于锚点的垂直偏移量。"

			TinyTipChatLocale_Desc_DebuffAnchor1	= "设置不良效果图标的锚点位置。"
			TinyTipChatLocale_Desc_DebuffAnchor2	= "设置不良效果图标的相对锚点位置。"
			TinyTipChatLocale_Desc_DebuffOffX			= "设置不良效果图标相对于锚点的水平偏移量。"
			TinyTipChatLocale_Desc_DebuffOffY			= "设置不良效果图标相对于锚点的水平偏移量。"
		end
	end

	TinyTipChatLocale_Opt_Main_Text					= "文本"
	TinyTipChatLocale_Opt_HideLevelText			= "隐藏等级信息"
	TinyTipChatLocale_Opt_HideRace					= "隐藏职业和生物类型信息"
	TinyTipChatLocale_Opt_KeyElite					= "启用分类标识"
	TinyTipChatLocale_Opt_PvPRank						= "军衔信息"
	TinyTipChatLocale_Opt_HideGuild					= "隐藏公会信息"
	TinyTipChatLocale_Opt_LevelGuess				= "猜测等级"
	TinyTipChatLocale_Opt_ReactionText			= "显示态度信息"

	TinyTipChatLocale_Desc_Main_Text = "设置人物信息条中显示的文本信息。"
	TinyTipChatLocale_Desc_HideLevelText = "切换是否隐藏等级信息。"
	TinyTipChatLocale_Desc_HideRace = "切换是否隐藏玩家职业和生物类型信息。"
	TinyTipChatLocale_Desc_KeyElite = "以*标识精英生物，以!标识稀有生物，以!*标识稀有精英生物，以**标识世界首领。"
	TinyTipChatLocale_Desc_PvPRank = "设置军衔信息显示方式。"
	TinyTipChatLocale_Desc_HideGuild = "切换是否隐藏公会名字。"
	TinyTipChatLocale_Desc_ReactionText = "切换是否显示态度信息。（友好，敌对等等。）"
	TinyTipChatLocale_Desc_LevelGuess = "切换是以(你的等级 +10)还是以??显示等级高出你10级以上的生物。"

	TinyTipChatLocale_Opt_Main_Appearance			= "外观"
	TinyTipChatLocale_Opt_Scale								= "缩放"
	TinyTipChatLocale_Opt_Fade								= "淡出效果"
	TinyTipChatLocale_Opt_BGColor							= "背景颜色"
	TinyTipChatLocale_Opt_Border							= "边框颜色"
	TinyTipChatLocale_Opt_SmoothBorder				= "平滑过度边框与背景"
	TinyTipChatLocale_Opt_Friends							= "以特别的颜色显示好友和同公会成员"
	TinyTipChatLocale_Opt_HideInFrames				= "隐藏人物头像信息条"
	TinyTipChatLocale_Opt_FormatDisabled			= "禁用信息条排版"
	TinyTipChatLocale_Opt_Compact							= "显示袖珍型信息条"

	TinyTipChatLocale_ChatIndex_PvPRank = { 
		[1] = TinyTipChatLocale_Off, 
		[2] = "显示军衔名",
		[3] = "在名字后面显示军衔名"
	}

	TinyTipChatLocale_ChatIndex_Fade = {
		[1] = "总是淡出",
		[2] = "从不淡出"
	}

	TinyTipChatLocale_ChatIndex_BGColor = {
		[1] = TinyTipChatLocale_GameDefault,
		[2] = "以玩家方式显示NPC",
		[3] = "总是黑色"
	}

	TinyTipChatLocale_ChatIndex_Border = {
		[1] = TinyTipChatLocale_GameDefault,
		[2] = "隐藏边框" 
	}

	TinyTipChatLocale_ChatIndex_Friends = {
		[1] = "只对名字上色",
		[2] = "不上色"
	}

	TinyTipChatLocale_Desc_Main_Appearance = "设置信息条外观与行为。"
	TinyTipChatLocale_Desc_Fade = "切换是让信息条逐渐淡出还是直接消失。"
	TinyTipChatLocale_Desc_Scale =  "设置信息条的缩放比例。（包括附带的图标）"
	TinyTipChatLocale_Desc_BGColor = "设置人物信息条背景的颜色方案。"
	TinyTipChatLocale_Desc_Border = "设置人物信息条边框的颜色方案。"
	TinyTipChatLocale_Desc_SmoothBorder = "切换是否改变信息条背景和边框的默认透明度。"
	TinyTipChatLocale_Desc_Friends = "设置是否使用特别的颜色显示好友和同公会成员的名字或信息条背景。"
	TinyTipChatLocale_Desc_HideInFrames = "当鼠标移经人物头像时隐藏信息条。"
	TinyTipChatLocale_Desc_FormatDisabled = "禁用TinyTip信息条排版。"
	TinyTipChatLocale_Desc_Compact = "在不改变缩放比例的情况下袖珍化的信息条。"

	if getglobal("GetAddOnMetadata")("TinyTipExtras", "Title") then
		TinyTipChatLocale_Opt_PvPIconScale	= "军衔图标缩放"
		TinyTipChatLocale_Opt_RTIconScale		= "团队目标图标缩放"
		TinyTipChatLocale_Opt_BuffScale			= "增益与不良效果图标缩放"

		TinyTipChatLocale_Desc_PvPIconScale		= "设置军衔图标缩放比例。"
		TinyTipChatLocale_Desc_RTIconScale		= "设置团队目标图标缩放比例。"
		TinyTipChatLocale_Desc_BuffScale			= "设置增益与不良效果图标缩放比例。"

		TinyTipChatLocale_Opt_Main_Targets				= "目标信息"
		TinyTipChatLocale_Opt_ToT									= "信息条人物"
		TinyTipChatLocale_Opt_ToP									= "小队"
		TinyTipChatLocale_Opt_ToR									= "团队"

		TinyTipChatLocale_ChatIndex_ToT = {
			[1] = "另起一行显示其目标",
			[2] = "在同一行显示其目标"
		}

		TinyTipChatLocale_ChatIndex_ToP = {
			[1] = "显示每个玩家的名字",
			[2] = "只显示玩家数量"
		}

		TinyTipChatLocale_ChatIndex_ToR = {
			[1] = "只显示玩家数量",
			[2] = "显示每个职业的玩家数量",
			[3] = "显示所有玩家的名字"
		}

		TinyTipChatLocale_Desc_Main_Targets = "给人物信息条添加目标的目标信息。"
		TinyTipChatLocale_Desc_ToT = "设置是否显示信息条对应人物的目标的名字。"
		TinyTipChatLocale_Desc_ToP = "设置关注信息条对应人物的小队对友的显示。"
		TinyTipChatLocale_Desc_ToR = "设置关注信息条对应人物的团队对友的显示。"

		TinyTipChatLocale_Opt_Main_Extras					= "额外功能"
		TinyTipChatLocale_Opt_PvPIcon							= "显示军衔图标"
		TinyTipChatLocale_Opt_ExtraTooltip				= "TinyTip额外信息条"
		TinyTipChatLocale_Opt_Buffs								= "增益效果"
		TinyTipChatLocale_Opt_Debuffs							= "不良效果"
		TinyTipChatLocale_Opt_ManaBar					= "显示法力状态条"
		TinyTipChatLocale_Opt_RTIcon					= "显示团队目标图标"

		TinyTipChatLocale_ChatIndex_ExtraTooltip	= {
			[1] = "显示其他插件的信息",
			[2] = "以额外信息条显示TinyTip与其他插件的额外信息"
		}

		TinyTipChatLocale_ChatIndex_Buffs = {
			[1] = "显示8个增益效果",
			[2] = "只显示你能施放的增益效果",
			[3] = "显示你能施放的增益效果的计数"
		}

		TinyTipChatLocale_ChatIndex_Debuffs = {
			[1] = "显示8个不良效果",
			[2] = "只显示你能驱散的不良效果",
			[3] = "显示你能驱散的不良效果的计数",
			[4] = "显示你能驱散的每个类型的不良效果的计数",
			[5] = "显示你能驱散的全部类型的不良效果的计数"
		}

		TinyTipChatLocale_Desc_Main_Extras = "TinyTip核心不支持的额外功能。"
		TinyTipChatLocale_Desc_PvPIcon = "切换是否在信息条左端显示玩家的军衔图标。"
		TinyTipChatLocale_Desc_ExtraTooltip = "以额外信息条显示TinyTip与其他插件的额外信息。"
		TinyTipChatLocale_Desc_Buffs			= "显示人物的增益效果信息。"
		TinyTipChatLocale_Desc_Debuffs		= "显示人物的不良效果信息。"
		TinyTipChatLocale_Desc_ManaBar		= "在生命条下增加法力条的显示。"
		TinyTipChatLocale_Desc_RTIcon			= "显示信息条对应人物的团队目标图标。"
	end

	TinyTipChatLocale_Opt_Profiles = "为每个人物单独保存设置"
	TinyTipChatLocale_Desc_Profiles = "切换是否为每个人物单独保存设置。"

	TinyTipChatLocale_Opt_Main_Default = "重置设置"
	TinyTipChatLocale_Desc_Main_Default = "将插件设置重置为默认状态。"

	-- slash command-related stuff
	TinyTipChatLocale_DefaultWarning = "确定要将插件设置重置为默认值吗？请输入："
	TinyTipChatLocale_NotValidCommand = "不是一条有效的命令。"

	TinyTipChatLocale_Confirm = "confirm" -- must be lowercase!
	TinyTipChatLocale_Opt_Slash_Default = "default" -- ditto

	-- we're done with this.
	TinyTipChatLocale = nil
end
