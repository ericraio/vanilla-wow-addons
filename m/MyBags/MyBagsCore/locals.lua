-- Version : English - Ramble 
-- Translation : none
ace:RegisterGlobals({
	version	= 1.0,

	ACEG_TEXT_AMMO		   = "Ammo",
	ACEG_TEXT_QUIVER	   = "Quiver",
	ACEG_TEXT_SOUL		   = "Soul Bag",
	ACEG_TEXT_ENCHANT    = "Enchanting Bag",
	ACEG_TEXT_ENGINEER   = "Engineering Bag",
	ACEG_TEXT_HERB       = "Herb Bag",
	ACEG_TEXT_NOW_SET_TO = "is now set to",
	ACEG_TEXT_DEFAULT	 = "default",
	ACEG_DISPLAY_OPTION  = "[|cfff5f530%s|r]",
	ACEG_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},
})
-- Ammo, Quiver, Soul Bag, Enchanting Bag, Herbalism Bag,  -- confirmed working
-- Engineering Bag -- subclass taken from links, I have never seen any

--MyInventory Title
MYBAGS_TITLE0 = ""
MYBAGS_TITLE1 = "%s's "
MYBAGS_TITLE2 = "%s of %s's "

MYBAGS_SLOTS_DD  = "%d/%d Slots";
-- SLASHCOMMANDS

--KEYBINDINGS
BINDING_HEADER_MYBAGSHEADER	= "My Bags"
BINDING_NAME_MYINVENTORY		= "My Inventory Toggle"
BINDING_NAME_MYBANK				= "My Bank Toggle"
BINDING_NAME_MYEQUIPMENT		= "My Equipment Toggle"


--OPTION TOGGLE MESSAGES

MYBAGS_CMD_OPT_TOGGLE = {
	option = "tog",
	desc   = "Toggle the frame",
	method = "Toggle"
}
MYBAGS_CMD_OPT_COLUMNS = {
	option = "cols",
	desc   = "Resize the frame",
	method = "SetColumns"
}
MYBAGS_CMD_OPT_REPLACE = {
	option = "replace",
	desc   = "Set replacing of default bags",
	method = "SetReplace"
}
MYBAGS_CMD_OPT_BAG = {
	option = "bag",
	desc   = "Toggle between bag button view options",
	method = "SetBagDisplay",
	input  = TRUE,
	args = {
		{
			option = "bar",
			desc   = "Bags are dispalyed as a bar on top of the frame",
		},
		{
			option = "before",
			desc   = "Bag icons are places in the frame before bag slots",
		},
		{
			option = "none",
			desc   = "Bags are hidden from the frame",
		}
	}
}
MYBAGS_CMD_OPT_GRAPHICS = {
	option = "back",
	desc   = "Toggle window background options",
	method = "SetGraphicsDisplay",
	input  = TRUE,
	args = {
		{
			option = "default",
			desc   = "Semi-transparent minimalistic background",
		},
		{
			option = "art",
			desc   = "Blizard style artwork",
		},
		{
			option = "none",
			desc   = "Disable background",
		}
	}
}
MYBAGS_CMD_OPT_HIGHLIGHT = {
	option = "highlight",
	desc   = "Toggle Highlighting options",
	method = "SetHighlight",
	input = TRUE,
	args = {
		{
			option = "items",
			desc   = "Highlight items when you mouse over bag slots"
		},
		{
			option = "bag",
			desc   = "Highlight bag when you mouse over an item"
		}
	}
}
MYBAGS_CMD_OPT_FREEZE = {
	option = "freeze",
	desc   = "Keep window from closing when you leave vendors or bank",
	method = "SetFreeze",
	input  = TRUE,
	args = {
		{
			option = "always",
			desc   = "Always leave the bag open",
		},
		{
			option = "sticky",
			desc   = "Only leave open if manually opened",
		},
		{
			option = "none",
			desc   = "Let the UI close the window",
		}
	}
}
MYBAGS_CMD_OPT_NOESC = {
	option = "noesc",
	desc   = "Remove frame from the list of UI managed files, to be used with freeze",
	method = "SetNoEsc"
}
MYBAGS_CMD_OPT_LOCK = {
	option = "lock",
	desc   = "Keep the window from moving",
	method = "SetLock"
}
MYBAGS_CMD_OPT_TITLE = {
	option = "title",
	desc   = "Show/Hide the title",
	method = "SetTitle"
}
MYBAGS_CMD_OPT_CASH = {
	option = "cash",
	desc   = "Show/Hide the money display",
	method = "SetCash"
}
MYBAGS_CMD_OPT_BUTTONS = {
	option = "buttons",
	desc   = "Show/Hide the close and lock buttons",
	method = "SetButtons"
}
MYBAGS_CMD_OPT_AIOI = {
	option = "aioi",
	desc   = "Toggle partial row placement at bottom left or upper right",
	method = "SetAIOI"
}
MYBAGS_CMD_OPT_REVERSE = {
	option = "reverse",
	desc   = "Toggle order of bags (item order within bags is unchanged)",
	method = "SetReverse"
}
MYBAGS_CMD_OPT_BORDER = {
	option = "quality",
	desc   = "Highlight items based on quality",
	method = "SetBorder"
}
MYBAGS_CMD_OPT_PLAYERSEL = {
	option = "player",
	desc   = "Show/Hide the offline player selection box",
	method = "SetPlayerSel"
}
MYBAGS_CMD_OPT_COMPANION = {
	option = "companion",
	desc   = "Open/close MyInventory with bank, mail and trade windows",
	method = "SetCompanion"
}
MYBAGS_CMD_OPT_COUNT = {
	option = "count",
	desc   = "Toggles between item count display modes",
	method = "SetCount",
	input  = TRUE,
	args   = {
		{
			option = "free",
			desc   = "Count free slots"
		},
		{
			option = "used",
			desc   = "Count used slots"
		},
		{
			option = "none",
			desc   = "Disable slot display"
		}
	}
}
MYBAGS_CMD_OPT_SCALE = {
	option = "scale",
	desc = "Sets the Scale for the frame",
	method = "SetScale",
}
MYBAGS_CMD_OPT_STRATA = {
	option = "strata",
	desc = "Sets the Strata for the frame",
	method = "SetStrata",
	input = TRUE,
	args = {
		{ option = "background", },
		{ option = "low", },
		{ option = "medium", },
		{ option = "high", },
		{ option = "dialog", },
--		{ option = "fullscreen", },
--		{ option = "fullscreen_dialog", },
--		{ option = "tooltip", },
	}
}
MYBAGS_CMD_OPT_ANCHOR = {
	option = "anchor",
	desc = "Sets the anchor point for the frame",
	method = "SetAnchor",
	input = TRUE,
	args = {
		{
			option = "bottomleft",
			desc = "Frame grows from bottom left",
		},
		{
			option = "bottomright",
			desc = "Frame grows from bottom right",
		},
		{
			option = "topleft",
			desc = "Frame grows from top left",
		},
		{
			option = "topright",
			desc = "Frame grows from top right",
		},
	}
}
MYBAGS_CMD_RESET = {
	option = "reset",
	desc = "Resets elements of the addon", 
	input = TRUE,
	args = {
		{
			option = "settings",
			desc = "Reset all settings to default",
			method = "ResetSettings",
		},
		{
			option = "anchor",
			desc = "Reanchors the frame to it's default position",
			method = "ResetAnchor",
		},
	}
}
MYBAGS_CMD_OPT_SLOTCOLOR = {
	option = "slotcolor",
	desc = "Set the slot color for specialty bags", 
	method = "SetSpecialtyBagSlotColor",
	input = TRUE,
	args = {
		{
			option = "default",
			desc = "Set slot coloring for normal bags",
		},
		{
			option = "ammo",
			desc = "Set slot coloring for Ammo Bags and Quivers",
		},
		{
			option = "soul",
			desc = "Set slot coloring for Soul Shard Bags",
		},
		{
			option = "enchant",
			desc = "Set slot coloring for Enchanting Bags",
		},
		{
			option = "engineer",
			desc = "Set slot coloring for Engineering Bags",
		},
		{
			option = "herb",
			desc = "Set slot coloring for Herbalism Bags",
		},
		{
			option = "keyring",
			desc = "Set slot coloring for the KeyRing Bag",
		},
	}
}
