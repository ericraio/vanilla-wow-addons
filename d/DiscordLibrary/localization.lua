DL_VERSION = 1.46;

DL_INCOMBAT = nil;
DL_ATTACKING = nil;
DL_REGEN = true;
DL_PETATTACKING = nil;
DL_INIT_FUNCTIONS_INDEX = 0;
DL_FRAME_FUNCTIONS_INDEX = 0;
DL_BUFFS = {};
DL_DEBUFFS = {};
DL_STATUS = {};
DL_ERRORS_QUEUE = {};
DL_NUM_ACTIONS = 120;

DL_COPYTEXT = "COPY";
DL_PASTETEXT = "PASTE";
DL_CREATETEXT = "CREATE";
DL_LOADTEXT = "LOAD";
DL_DELETETEXT = "DELETE";
DL_PROWL = "Prowl";

DL_TEXT = {
	Humanoid = "Humanoid",
	Dodge = " dodge",
	Block = " block",
	Parry = " parrie"
}

DL_FRAMESTRATAS = {
	{ text="BACKGROUND", value = "BACKGROUND" },
	{ text="LOW", value = "LOW" },
	{ text="MEDIUM", value = "MEDIUM" },
	{ text="HIGH", value = "HIGH" },
	{ text="DIALOG", value = "DIALOG" }
}

DL_DRAWLAYERS = {
	{ text="BACKGROUND", value="BACKGROUND" },
	{ text="BORDER", value="BORDER" },
	{ text="ARTWORK", value="ARTWORK" },
	{ text="OVERLAY", value="OVERLAY" },
	{ text="HIGHLIGHT", value="HIGHLIGHT" }
}

DL_BLENDMODES = {
	{ text="DISABLE", value="DISABLE" },
	{ text="BLEND", value="BLEND" },
	{ text="ALPHAKEY", value="ALPHAKEY" },
	{ text="ADD", value="ADD" },
	{ text="MOD", value="MOD" },
}

DL_JUSTIFY_H = {
	{ text="LEFT", value="LEFT" },
	{ text="CENTER", value="CENTER" },
	{ text="RIGHT", value="RIGHT" }
}

DL_JUSTIFY_V = {
	{ text="TOP", value="TOP" },
	{ text="CENTER", value="CENTER" },
	{ text="BOTTOM", value="BOTTOM" }
}

DL_ANCHORS = {
		{ text = "TOPLEFT", value = "TOPLEFT" },
		{ text = "TOP", value = "TOP" },
		{ text = "TOPRIGHT", value = "TOPRIGHT" },
		{ text = "LEFT", value = "LEFT" },
		{ text = "CENTER", value = "CENTER" },
		{ text = "RIGHT", value = "RIGHT" },
		{ text = "BOTTOMLEFT", value = "BOTTOMLEFT" },
		{ text = "BOTTOM", value = "BOTTOM" },
		{ text = "BOTTOMRIGHT", value = "BOTTOMRIGHT" }
	 };

DL_BACKDROPS = {
	{ text="Plain", value=1 },
	{ text="Tooltip", value=2 },
	{ text="Dialogue", value=3 },
	{ text="Slider", value=4 },
	{ text="Glue Tooltip", value=5 }
}

DL_VALID_ANCHOR = {
	TOPLEFT = true,
	TOP = true,
	TOPRIGHT = true,
	LEFT = true,
	CENTER = true,
	RIGHT = true,
	BOTTOMLEFT = true,
	BOTTOM = true,
	BOTTOMRIGHT = true
}

DL_FORMS = {
	{ text = "Humanoid", value = 0 }
}

DL_OPTIONS_SCALES = {
	{ text=50,value=50 },
	{ text=60,value=60 },
	{ text=70,value=70 },
	{ text=80,value=80 },
	{ text=90,value=90 },
	{ text=100,value=100 }
}

DL_TARGET_PARAMS = {
	{ text="Player", value = 1 },
	{ text="NPC", value = 2 },
	{ text="Hostile", value = 3 },
	{ text="Friendly", value = 4 },
	{ text="Hostile Player", value = 5 },
	{ text="Friendly Player", value = 6 },
	{ text="Spellcaster", value = 7 }
}

DL_COMPARE_MENU = {
	{ text = ">", value = 1 },
	{ text = ">=", value = 2 },
	{ text = "=", value = 3 },
	{ text = "<=", value = 4 },
	{ text = "<", value = 5 }
}

DL_OUTLINES = {
	{ text="NONE", value="NONE" },
	{ text="NORMAL", value="NORMAL" },
	{ text="THICK", value="THICK" }
}

DL_EDGE_FILES = {
	{ text="Plain", value="Interface\\AddOns\\DiscordLibrary\\PlainBackdrop" },
	{ text="Tooltip", value="Interface\\Tooltips\\UI-Tooltip-Border" },
	{ text="Dialog", value="Interface\\DialogFrame\\UI-DialogBox-Border" },
	{ text="Slider", value="Interface\\Buttons\\UI-SliderBar-Border" },
	{ text="Glue Tooltip", value="Interface\\Glues\\Common\\Glue-Tooltip-Border" },
	{ text="Party Border", value="Interface\\CharacterFrame\\UI-Party-Border" }
}

DL_ORIENTATIONS = {
	{ text="Horizontal", value="HORIZONTAL" },
	{ text="Vertical", value="VERTICAL" },
}

DL_INVENTORY_SLOTS = { "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot", "RangedSlot", "AmmoSlot" };