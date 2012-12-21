--[[ TinyTip by Thrae
-- 
--
-- English Localization (Default)
-- For TinyTipChat
--
-- TinyTipChatLocale should be defined in your FIRST localization
-- code.
--
-- Note: Other localization is in TinyTipLocale_enEN.
-- 
--]]

if TinyTipChatLocale then
	TinyTipChatLocale_MenuTitle = "TinyTip Options"

	TinyTipChatLocale_On = "On"
	TinyTipChatLocale_Off = "Off"
	TinyTipChatLocale_GameDefault = "Game's Default"
	TinyTipChatLocale_TinyTipDefault = "TinyTip's Default"

	if getglobal("TinyTipAnchorExists") then
		TinyTipChatLocale_Opt_Main_Anchor			= "Anchoring"
		TinyTipChatLocale_Opt_MAnchor					= "Unit Anchor"
		TinyTipChatLocale_Opt_FAnchor					= "Frame Anchor"
		TinyTipChatLocale_Opt_MOffX						= "Unit Offset [X]"
		TinyTipChatLocale_Opt_MOffY						= "Unit Offset [Y]"
		TinyTipChatLocale_Opt_FOffX						= "Frame Offset [X]"
		TinyTipChatLocale_Opt_FOffY						= "Frame Offset [Y]"
		TinyTipChatLocale_Opt_AnchorAll				= "Anchor Custom Tooltips"
		TinyTipChatLocale_Opt_AlwaysAnchor		= "Always Anchor GameTooltip"

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

		TinyTipChatLocale_Anchor_Cursor = "CURSOR"
		TinyTipChatLocale_Anchor_Sticky = "STICKY"

		TinyTipChatLocale_Desc_Main_Anchor = "Set the tooltip's positioning."
		TinyTipChatLocale_Desc_MAnchor = "Set the anchor for the tooltip when mousing over units in the world frame."
		TinyTipChatLocale_Desc_FAnchor = "Set the anchor for the tooltip when mousing over ANY frame (except the WorldFrame)."
		TinyTipChatLocale_Desc_MOffX = "Set the horizontal offset from the anchor point for units."
		TinyTipChatLocale_Desc_MOffY = "Set the vertical offset from the anchor point for units."
		TinyTipChatLocale_Desc_FOffX = "Set the horizontal offset from the anchor point when mousing over ANY frame."
		TinyTipChatLocale_Desc_FOffY = "Set the vertical offset from the anchor point when mousing over ANY frame."
		TinyTipChatLocale_Desc_AnchorAll = "Apply Custom Anchoring to ALL Frame tooltips using GameTooltip_SetDefaultAnchor, not just GameTooltip."
		TinyTipChatLocale_Desc_AlwaysAnchor = "Force Frame Anchoring whenever the GameTooltip shows up. This can be used with mineral veins, etc. and any frame that uses GameTooltip."

		if getglobal("GetAddOnMetadata")("TinyTipExtras", "Title") then
			TinyTipChatLocale_Opt_ETAnchor				= "Extra Tooltip Anchor"
			TinyTipChatLocale_Opt_ETOffX					= "Extra Tooltip Offset [X]"
			TinyTipChatLocale_Opt_ETOffY					= "Extra Tooltip Offset [Y]"
			TinyTipChatLocale_Desc_ETAnchor 			= "Set the anchor for the Extra Tooltip."
			TinyTipChatLocale_Desc_ETOffX					= "Set the horizontal offset from the anchor point for the Extra Tooltip."
			TinyTipChatLocale_Desc_ETOffY					= "Set the vertical offset from the anchor point for the Extra Tooltip."

			TinyTipChatLocale_Opt_PvPIconAnchor1	= "PvP Rank Icon Anchor"
			TinyTipChatLocale_Opt_PvPIconAnchor2	= "PvP Rank Icon Relative Anchor"
			TinyTipChatLocale_Opt_PvPIconOffX			= "PvP Rank Icon Offset [X]"
			TinyTipChatLocale_Opt_PvPIconOffY			= "PvP Rank Icon Offset [Y]"

			TinyTipChatLocale_Desc_PvPIconAnchor1	= "Set the anchor for the PvP Rank Icon."
			TinyTipChatLocale_Desc_PvPIconAnchor2	= "Set the relative anchor for the PvP Rank Icon."
			TinyTipChatLocale_Desc_PvPIconOffX		= "Set the horizontal offset from the anchor point for the PvP Rank Icon."
			TinyTipChatLocale_Desc_PvPIconOffY		= "Set the vertical offset from the anchor point for the PvP Rank Icon."

			TinyTipChatLocale_Opt_RTIconAnchor1		= "Raid Target Icon Anchor"
			TinyTipChatLocale_Opt_RTIconAnchor2		= "Raid Target Icon Relative Anchor"
			TinyTipChatLocale_Opt_RTIconOffX			= "Raid Target Icon Offset [X]"
			TinyTipChatLocale_Opt_RTIconOffY			= "Raid Target Icon Offset [Y]"

			TinyTipChatLocale_Desc_RTIconAnchor1	= "Set the anchor for the Raid Target Icon."
			TinyTipChatLocale_Desc_RTIconAnchor2	= "Set the relative anchor for the Raid Target Icon."
			TinyTipChatLocale_Desc_RTIconOffX			= "Set the horizontal offset from the anchor point for the Raid Target Icon."
			TinyTipChatLocale_Desc_RTIconOffY			= "Set the vertical offset from the anchor point for the Raid Target Icon."

			TinyTipChatLocale_Opt_BuffAnchor1			= "Buff Anchor"
			TinyTipChatLocale_Opt_BuffAnchor2			= "Buff Relative Anchor"
			TinyTipChatLocale_Opt_BuffOffX				= "Buff Offset [X]"
			TinyTipChatLocale_Opt_BuffOffY				= "Buff Offset [Y]"

			TinyTipChatLocale_Opt_DebuffAnchor1		= "Debuff Anchor"
			TinyTipChatLocale_Opt_DebuffAnchor2		= "Debuff Relative Anchor"
			TinyTipChatLocale_Opt_DebuffOffX			= "Debuff Offset [X]"
			TinyTipChatLocale_Opt_DebuffOffY			= "Debuff Offset [Y]"

			TinyTipChatLocale_Desc_BuffAnchor1	= "Set the anchor for the Buff Icons."
			TinyTipChatLocale_Desc_BuffAnchor2	= "Set the relative anchor for the Buff Icons."
			TinyTipChatLocale_Desc_BuffOffX			= "Set the horizontal offset from the anchor point for the Buff Icons."
			TinyTipChatLocale_Desc_BuffOffY			= "Set the vertical offset from the anchor point for the Buff Icons."

			TinyTipChatLocale_Desc_DebuffAnchor1	= "Set the anchor for the Debuff Icons."
			TinyTipChatLocale_Desc_DebuffAnchor2	= "Set the relative anchor for the Debuff Icons."
			TinyTipChatLocale_Desc_DebuffOffX			= "Set the horizontal offset from the anchor point for the Debuff Icons."
			TinyTipChatLocale_Desc_DebuffOffY			= "Set the vertical offset from the anchor point for the Debuff Icons."
		end
	end

	TinyTipChatLocale_Opt_Main_Text					= "Text"
	TinyTipChatLocale_Opt_HideLevelText			= "Hide Level Text"
	TinyTipChatLocale_Opt_HideRace					= "Hide Race and Creature Type Text"
	TinyTipChatLocale_Opt_KeyElite					= "Use Classification Keys"
	TinyTipChatLocale_Opt_PvPRank						= "PvP Rank"
	TinyTipChatLocale_Opt_HideGuild					= "Hide Guild Text"
	TinyTipChatLocale_Opt_LevelGuess				= "Level Guestimate"
	TinyTipChatLocale_Opt_ReactionText			= "Show Reaction Text"

	TinyTipChatLocale_Desc_Main_Text = "Change what text is displayed inside the unit tooltip."
	TinyTipChatLocale_Desc_HideLevelText = "Toggle whether to hide the level text."
	TinyTipChatLocale_Desc_HideRace = "Toggle whether to hide a player's race or a creature's type."
	TinyTipChatLocale_Desc_KeyElite = "Use * for Elite, ! for Rare, !* for Rare Elite, and ** for World Boss."
	TinyTipChatLocale_Desc_PvPRank = "Set the options for the PvP Rank to be shown in text."
	TinyTipChatLocale_Desc_HideGuild = "Toggle whether to hide the guild name."
	TinyTipChatLocale_Desc_ReactionText = "Toggle whether to show the reaction text (Friendly, Hostile, etc.)"
	TinyTipChatLocale_Desc_LevelGuess = "Toggle whether to show >(Your Level +10) instead of ?? for unknown levels."

	TinyTipChatLocale_Opt_Main_Appearance			= "Appearance"
	TinyTipChatLocale_Opt_Scale								= "Scale"
	TinyTipChatLocale_Opt_Fade								= "FadeOut Effect"
	TinyTipChatLocale_Opt_BGColor							= "Backdrop Coloring"
	TinyTipChatLocale_Opt_Border							= "Border Coloring"
	TinyTipChatLocale_Opt_SmoothBorder				= "Smooth Out Border And Background"
	TinyTipChatLocale_Opt_Friends							= "Coloring For Friends and Guildmates"
	TinyTipChatLocale_Opt_HideInFrames				= "Hide Tooltip For Unit Frames"
	TinyTipChatLocale_Opt_FormatDisabled			= "Disable Tooltip Formating"
	TinyTipChatLocale_Opt_Compact							= "Display Compact Tooltip"

	TinyTipChatLocale_ChatIndex_PvPRank = { 
		[1] = TinyTipChatLocale_Off, 
		[2] = "Show Rank Name",
		[3] = "Show Rank Number after Name"
	}

	TinyTipChatLocale_ChatIndex_Fade = {
		[1] = "Always FadeOut",
		[2] = "Never FadeOut"
	}

	TinyTipChatLocale_ChatIndex_BGColor = {
		[1] = TinyTipChatLocale_GameDefault,
		[2] = "Color NPCs like PCs",
		[3] = "Always Black"
	}

	TinyTipChatLocale_ChatIndex_Border = {
		[1] = TinyTipChatLocale_GameDefault,
		[2] = "Hide Border"
	}

	TinyTipChatLocale_ChatIndex_Friends = {
		[1] = "Color Only Name",
		[2] = "Don't Color"
	}

	TinyTipChatLocale_Desc_Main_Appearance = "Set the look and behavior of the tooltip."
	TinyTipChatLocale_Desc_Fade = "Toggle whether to let the tooltip fade out or simply hide."
	TinyTipChatLocale_Desc_Scale =  "Set the scale of the tooltip (and attached icons)."
	TinyTipChatLocale_Desc_BGColor = "Set the color scheme for the unit tooltip's backdrop."
	TinyTipChatLocale_Desc_Border = "Set the color scheme for the unit tooltip's border."
	TinyTipChatLocale_Desc_SmoothBorder = "Toogle whether to change the default alpha and size of the tooltip's border and background."
	TinyTipChatLocale_Desc_Friends = "Set whether to color the backdrop or name differently for friends and guildmates."
	TinyTipChatLocale_Desc_HideInFrames = "Hide the tooltip while mousing over unit frames."
	TinyTipChatLocale_Desc_FormatDisabled = "Disable TinyTip's special tooltip formating."
	TinyTipChatLocale_Desc_Compact = "Compact the tooltip without changing its scale."

	if getglobal("GetAddOnMetadata")("TinyTipExtras", "Title") then
		TinyTipChatLocale_Opt_PvPIconScale	= "PvP Icon Scale"
		TinyTipChatLocale_Opt_RTIconScale		= "Raid Target Icon Scale"
		TinyTipChatLocale_Opt_BuffScale			= "Buff and Debuff Icon Scale"

		TinyTipChatLocale_Desc_PvPIconScale		= "Set the scale of the PvP Icon."
		TinyTipChatLocale_Desc_RTIconScale		= "Set the scale of the Raid Target Icon."
		TinyTipChatLocale_Desc_BuffScale			= "Set the scale of the Buff And Debuff Icons."

		TinyTipChatLocale_Opt_Main_Targets				= "Target Of ..."
		TinyTipChatLocale_Opt_ToT									= "Tooltip's Unit"
		TinyTipChatLocale_Opt_ToP									= "Party"
		TinyTipChatLocale_Opt_ToR									= "Raid"

		TinyTipChatLocale_ChatIndex_ToT = {
			[1] = "Show Tooltip Unit's Target In New Line",
			[2] = "Show Target On Same Line As UnitName"
		}

		TinyTipChatLocale_ChatIndex_ToP = {
			[1] = "Show Each Name",
			[2] = "Show # Of Players"
		}

		TinyTipChatLocale_ChatIndex_ToR = {
			[1] = "Show # Of Players",
			[2] = "Show Count Of Each Class",
			[3] = "Show ALL Names"
		}

		TinyTipChatLocale_Desc_Main_Targets = "Add target of target information to the unit tooltip."
		TinyTipChatLocale_Desc_ToT = "Set whether to show the name of tooltip unit's target."
		TinyTipChatLocale_Desc_ToP = "Set the options for seeing if anyone in your party is targeting the tooltip's unit."
		TinyTipChatLocale_Desc_ToR = "Set the options for seeing if anyone in your raid is targeting the tooltip's unit."

		TinyTipChatLocale_Opt_Main_Extras					= "Extras"
		TinyTipChatLocale_Opt_PvPIcon							= "Show PvP Rank Icon"
		TinyTipChatLocale_Opt_ExtraTooltip				= "TinyTip's Extra Tooltip"
		TinyTipChatLocale_Opt_Buffs								= "Buffs"
		TinyTipChatLocale_Opt_Debuffs							= "Debuffs"
		TinyTipChatLocale_Opt_ManaBar					= "Show Mana StatusBar"
		TinyTipChatLocale_Opt_RTIcon					= "Show Raid Target Icon"

		TinyTipChatLocale_ChatIndex_ExtraTooltip	= {
			[1] = "Show Other Addons Info",
			[2] = "Show Other Addons & TinyTip's Extra Info"
		}

		TinyTipChatLocale_ChatIndex_Buffs = {
			[1] = "Show 8 Buffs",
			[2] = "Show Only Castable Buffs",
			[3] = "Show Count of Castable Buffs in tooltip"
		}

		TinyTipChatLocale_ChatIndex_Debuffs = {
			[1] = "Show 8 Debuffs",
			[2] = "Show Only Dispellable Debuffs",
			[3] = "Show Count of Dispellable Debuffs in tooltip",
			[4] = "Show Count of each type of Dispellable Debuff in tooltip",
			[5] = "Show Count of ALL types of Debuffs in tooltip"
		}

		TinyTipChatLocale_Desc_Main_Extras = "Extra features not included in TinyTip core."
		TinyTipChatLocale_Desc_PvPIcon = "Toggle whether to show an icon for the player's PvP rank to the left of the tooltip."
		TinyTipChatLocale_Desc_ExtraTooltip = "Add information from other addons and/or TinyTip into a separate tooltip."
		TinyTipChatLocale_Desc_Buffs			= "Show information about a unit's buffs."
		TinyTipChatLocale_Desc_Debuffs		= "Show information about a unit's debuffs."
		TinyTipChatLocale_Desc_ManaBar		= "Show a status bar for mana below the health bar."
		TinyTipChatLocale_Desc_RTIcon			= "Show the raid target icon for the tooltip's unit, if it exists."
	end

	TinyTipChatLocale_Opt_Profiles = "Save Settings Per Character"
	TinyTipChatLocale_Desc_Profiles = "Toggle whether to save your settings per character or globally."

	TinyTipChatLocale_Opt_Main_Default = "Reset Options"
	TinyTipChatLocale_Desc_Main_Default = "Return this addon's settings back to their defaults."

	-- slash command-related stuff
	TinyTipChatLocale_DefaultWarning = "Are you SURE you want to return your settings to their default values? Type in "
	TinyTipChatLocale_NotValidCommand = "is not a valid command."

	TinyTipChatLocale_Confirm = "confirm" -- must be lowercase!
	TinyTipChatLocale_Opt_Slash_Default = "default" -- ditto

	-- we're done with this.
	TinyTipChatLocale = nil
end
