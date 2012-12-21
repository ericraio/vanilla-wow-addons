DART_VERSION = "1.52";
DART_DL_VERSION = 1.48;

BINDING_HEADER_DART = "Discord Art v"..DART_VERSION;
BINDING_HEADER_DART_TEXTURES = "Texture Bindings";
BINDING_NAME_DART_OPTIONS = "Toggle Options Window";
DART_ANCHORHEADER = "ANCHORS";
DART_ANCHORHEADER_FRAME = "Frame";
DART_ANCHORHEADER_POINT = "Point";
DART_ANCHORHEADER_TO = "To";
DART_ANCHORHEADER_X = "X";
DART_ANCHORHEADER_Y = "Y";
DART_CLICKTOSET = "Click to Set Texture";
DART_COORDSHEADER = "Coords:";
DART_COPYTEXT = "COPY";
DART_PASTETEXT = "PASTE";
DART_TEXTUREBROWSERHEADER = "TEXTURE BROWSER";

DART_TEXT = {
	Action = "Action",
	AddCondition = "Add Condition",
	AddTexture = "Add Texture",
	Alpha = "Alpha",
	Amount = "Amount",
	Appearance = "APPEARANCE",
	AutoLock = "Auto-Lock Dragging",
	Backdrp = "Backdrop",
	BackgroundAlpha = "Background Alpha",
	BackgroundColor = "Background Color",
	BackgroundTexture = "Background Texture",
	BlendMode = "Blend Mode:",
	BorderAlpha = "Border Alpha",
	BorderColor = "Border Color",
	BorderTexture = "Border Texture",
	BuffName = "Buff/Debuff",
	CantDeleteCurrent = "You cannot delete the profile currently in use.",
	CantDeleteDefault = "You cannot delete the default profile.",
	ChooseCondition = "Choose Condition:",
	ChooseResponse = "Choose Response:",
	Color = "Color",
	Comparison = "Comparison",
	Conditions = "CONDITIONS",
	Control = "Control",
	Create = "CREATE",
	CurrentProfile = "Curent Profile: |cFFCCCC00",
	Custom = "Custom",
	Default = "Default",
	Delete = "DELETE",
	Delete2 = "Delete",
	DisableMouse = "Disable Mouse",
	DisableMousewheel = "Disable Mousewheel",
	DragWarning = "Textures anchored to 2 or more points cannot be dragged.",
	DrawLayer = "Draw Layer:",
	EdgSize = "Edge Size",
	Edit = "Edit",
	File = "File",
	Font = "Font:",
	FontSize = "Font Size",
	Form = "Form",
	FrameFinder = "|cFFCCCC00Mouse Is Over This Frame:\n|cFFFFFFFF",
	FrameLevel = "Frame Level Offset",
	Height = "Height",
	Hide = "Hide",
	HideBackground = "Hide Background",
	HideText = "Hide Text",
	Highlight = "Highlight on Mouseover",
	HighlightAlpha = "Highlight Alpha",
	HLColor = "Highlight Color",
	HLTexture = "Highlight Texture",
	IgnoreGlobal = "Ignore Global Cooldown",
	InsetBottom = "Inset Bottom",
	InsetLeft = "Inset Left",
	InsetRight = "Inset Right",
	InsetTop = "Inset Top",
	JustifyH = "Horizontal Justification",
	JustifyV = "Vertical Justification",
	LockDragging = "Lock Dragging",
	MiscOptions = "Misc Options",
	MoveAnchor = "Move Anchor",
	Name = "Name:",
	NewProfile = "New Profile:",
	NewProfileCreated = "New profile created: ",
	Number = "Number",
	OptionsScale = "Options Scale",
	Overrides = "Overridden By:",
	Padding = "Padding",
	Parameters = "PARAMETERS:",
	Parent = "\n|cFFCCCC00Parent: |cFFFFFFFF",
	ParentFrame = "Parent Frame",
	ParentsParent = "\n|cFFCCCC00Parent's Parent: |cFFFFFFFF",
	PresetBackdrops = "Preset Backdrops",
	ProfileDeleted = "Profile deleted: ",
	ProfileLoaded = "Profile loaded: ",
	Response = "Response:",
	Scale = "Scale",
	Scripts = "SCRIPTS",
	SelectTexture = "Select Texture:",
	Set = "LOAD",
	SetProfile = "Set Profile:",
	Strata = "Frame Strata:",
	Text = "Text:",
	Text2 = "Text",
	TextAlpha = "Text Alpha",
	TextColor = "Text Color",
	TextHeight = "Text Height",
	Texture = "Texture ",
	Texture2 = "Texture",
	TextureColor = "Texture Color",
	TextureOptions = "Texture Options",
	TextWidth = "Text Width",
	Tile = "Tile",
	TileSize = "Tile Size",
	Type = "Type",
	Unit = "Unit",
	UnlockDragging = "Unlock Dragging",
	UpdatesPerSec = "Updates Per Second",
	Width = "Width",
	X1 = "ULx or X1",
	X2 = "ULy or X2",
	Y1 = "LLx or Y1",
	Y2 = "LLy or Y2",
	URX = "URx",
	URY = "URy",
	LRX = "LRx",
	LRY = "LRy",
	CoordX1 = "X1",
	CoordX2 = "X2",
	CoordY1 = "Y1",
	CoordY2 = "Y2",
	DefaultUI = "Default UI",
	MacroIcons = "Macro Icons",
	TextureTip = "Left-click to select.\nRight-click to 'sticky' texture stats.",
	CustomTextureTip = "\nMiddle-click or shift + right-click to delete."
}

DART_ANCHORS = {
		{ text = "TOPLEFT", value = 1 },
		{ text = "TOP", value = 2 },
		{ text = "TOPRIGHT", value = 3 },
		{ text = "LEFT", value = 4 },
		{ text = "CENTER", value = 5 },
		{ text = "RIGHT", value = 6 },
		{ text = "BOTTOMLEFT", value = 7 },
		{ text = "BOTTOM", value = 8 },
		{ text = "BOTTOMRIGHT", value = 9 }
	 }

DART_NUDGE_INDICES = {
	{ text=1, value=1 },
	{ text=2, value=2 },
	{ text=3, value=3 },
	{ text=4, value=4 },
	{ text="Text", value=5 }
}

DART_JUSTIFY_H = {
	{ text="LEFT", value=4 },
	{ text="CENTER", value=5 },
	{ text="RIGHT", value=6 }
}

DART_JUSTIFY_V = {
	{ text="TOP", value=2 },
	{ text="CENTER", value=5 },
	{ text="BOTTOM", value=8 }
}

DART_BACKDROPS = {
	{ text="Plain", value=1 },
	{ text="Tooltip", value=2 },
	{ text="Dialogue", value=3 },
	{ text="Slider", value=4 },
	{ text="Glue Tooltip", value=5 }
}

-- Globals, do not translate
DART_INDEX = nil;
DART_NUDGE_INDEX = 1;
DART_NUMBER_OF_SCRIPTS = 14;
DART_PROFILE_INDEX = nil;
DART_STICKY_TEXTURE = {file="", x1="0", x2="1", y1="0", y2="1", height="256", width="256"};
DART_TEXTURE_INDEX = 1;

DART_ATTACH_POINTS = { "TOPLEFT", "TOP", "TOPRIGHT", "LEFT", "CENTER", "RIGHT", "BOTTOMLEFT", "BOTTOM", "BOTTOMRIGHT" }
DART_NUDGE_TEXT = { "<", ">", "^", "v" }

DART_OPTIONS_SCALES = {
	{ text=100, value=1 },
	{ text=90, value=.9 },
	{ text=80, value=.8 },
	{ text=70, value=.7 },
	{ text=60, value=.6 },
	{ text=50, value=.5 },
	{ text=40, value=.4 },
	{ text=30, value=.3 },
	{ text=20, value=.2 },
	{ text=10, value=.1 }
}

DART_SCRIPT_LABEL = {
		"OnUpdate",
		"OnEvent",
		"OnEnter",
		"OnLeave",
		"OnShow",
		"OnHide",
		"OnClick",
		"OnMouseUp",
		"OnMouseDown",
		"KeybindingDown",
		"KeybindingUp",
		"OnMouseWheel",
		"OnReceiveDrag",
		"OnLoad"
}

DART_RESPONSES = {
	{ text="No Response", value=0, desc="No effect when the condition activates."},
	{ text="Hide", value=1, desc="Hides the texture."},
	{ text="Show", value=2, desc="Shows the texture."},
	{ text="Hide Other Texture", value=3, desc="Hide a texture besides this one."},
	{ text="Show Other Texture", value=4, desc="Show a texture besides this one."},
	{ text="Hide Text", value=5, desc="Hides the texture's text."},
	{ text="Show Text", value=6, desc="Shows the texture's text."},
	{ text="Move Down", value=7, desc="Moves the texture down the screen by the specified amount."},
	{ text="Move Left", value=8, desc="Moves the texture left on the screen by the specified amount."},
	{ text="Move Right", value=9, desc="Moves the texture right on the screen by the specified amount."},
	{ text="Move To", value=10, desc="Moves the texture to the specified x, y offset relative to its first anchor point."},
	{ text="Move Up", value=11, desc="Moves the texture up the screen by the specified amount."},
	{ text="Set Alpha", value=12, desc="Sets the transparency of the texture."},
	{ text="Set Background Alpha", value=13, desc="Sets the transparency of the texture's background."},
	{ text="Set Background Color", value=14, desc="Sets the color of the texture's background."},
	{ text="Set Background Padding", value=15, desc="Sets the distance between a texture's border and the main part of the texture."},
	{ text="Set Border Alpha", value=16, desc="Sets the transparency of the texture's border."},
	{ text="Set Border Color", value=17, desc="Sets the color of the texture's border."},
	{ text="Set Color", value=18, desc="Sets the texture's color."},
	{ text="Set Font Size", value=19, desc="Sets the font size of the texture's text."},
	{ text="Set Height", value=20, desc="Sets the texture's height."},
	{ text="Set Highlight Alpha", value=21, desc="Sets the transparency of the texture's highlight."},
	{ text="Set Highlight Color", value=22, desc="Sets the color of the texture's highlight."},
	{ text="Set Scale", value=23, desc="Sets the scale of the texture."},
	{ text="Set Text Alpha", value=24, desc="Sets the transparency of the texture's text."},
	{ text="Set Text Color", value=25, desc="Sets the color of the texture's text."},
	{ text="Set Text", value=26, desc="Sets the texture's text."},
	{ text="Set Texture", value=27, desc="Set a texture file for this texture to use."},
	{ text="Set Width", value=28, desc="Sets the texture's width."},
	{ text="Start Flashing", value=29, desc="Starts the texture blinking on and off."},
	{ text="Stop Flashing", value=30, desc="Stops the texture blinking on and off."},
}