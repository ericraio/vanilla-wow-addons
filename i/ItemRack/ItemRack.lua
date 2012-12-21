--[[ ItemRack 1.975 7/27/06 Gello ]]--

--[[ SavedVariables ]]--

ItemRack_Users = {} -- per-user bar settings (position, orientation, scale, locked status, bar contents)

ItemRack_Settings = {			-- These settings are for all users:
	TooltipFollow = "OFF",		-- whether tooltip shows at pointer or default position
	CooldownNumbers = "OFF",	-- whether cooldowns show a number overlay
	Soulbound = "OFF",			-- whether menu limits items to soulbound only
	Bindings = "OFF",			-- whether key bindings is displayed
	MenuShift = "OFF",			-- whether Shift key needs held to open the menu
	Notify = "OFF",				-- whether to notify when cooldowns finished on used items
	ShowEmpty = "ON",			-- whether to show empty slot in the menu
	FlipMenu = "OFF",			-- whether to display menu on the opposite side
	RightClick = "OFF",			-- whether right click sends to second slot
	TinyTooltip = "OFF",		-- whether to only display name, durability and cooldown in tooltip
	ShowTooltips = "ON",		-- whether to display tooltip at all
	RotateMenu = "OFF",			-- whether menu is rotated (temporary setting)
	ShowIcon = "ON",			-- whether to show the minimap button
	DisableToggle = "ON",		-- whether left-clicking disables the minimap button
	FlipBar = "OFF",			-- whether control appears on bottom or right bar grows other direction
	EnableEvents = "OFF",		-- whether automated event scrips run
	CompactList = "OFF",		-- whether saved sets list is compacted or not
	NotifyThirty = "ON",		-- whether notify happens at 30 seconds
	ShowAllEvents = "OFF",		-- whether to show all classes' events
	AllowHidden = "OFF",		-- whether to hide menu items with ALT+click
	LargeFont = "OFF",			-- whether event script font is large or small
	SquareMinimap = "OFF",		-- whether minimap button should go around square minimap
	BigCooldown = "OFF",		-- whether cooldown numbers are huge (like Cooldown Count)
	SetLabels = "ON",			-- whether labels show on set icons
	AutoToggle = "OFF",			-- whether sets automatically toggle when chosen
}

-- all event scripts are stored globally in this saved variable.  Defaults are in localization.lua
ItemRack_Events = {}

ItemRack_Version = 1.975

--[[ Local Variables ]]--

-- some mount textures share non-mount buff textures, if you run across one put it here
local problem_mounts = {
	["Interface\\Icons\\Ability_Mount_PinkTiger"] = 1,
	["Interface\\Icons\\Ability_Mount_WhiteTiger"] = 1,
	["Interface\\Icons\\Spell_Nature_Swiftness"] = 1,
	["Interface\\Icons\\INV_Misc_Foot_Kodo"] = 1,
	["Interface\\Icons\\Ability_Mount_JungleTiger"] =1,
}

local current_events_version = 1.975 -- use to control when to upgrade events

-- defaults for ItemRack_Users
local ItemRackOpt_Defaults = {
	MainOrient = "HORIZONTAL",  -- direction of main bar, "HORIZONTAL" or "VERTICAL", menu orient always opposite
	MainScale = 1,				-- scale 0-1 of main bar and menu bar
	XPos = 400,					-- left position of main bar
	YPos = 350,					-- top position of main bar
	Locked = "OFF",				-- lock status of main bar (for all intents menu always locked)
	Visible = "ON"				-- whether the bar should be drawn on the screen
}

local user = "default"  -- "Gello of Hyjal" or "Gello of Deathwing ", defined at PLAYER_LOGIN

ItemRack = {}

ItemRack.FrameToScale = nil -- holds frame being scaled for ScaleUpdate

ItemRack.BaggedItems = {} -- table containing items in bags to show in menu
ItemRack.NumberOfItems = 0 -- number of items in the menu
ItemRack.MaxItems = 30 -- maximum number of items that can display in the menu
ItemRack.InvOpen = nil -- which inventory slot has its menu open

ItemRack.TooltipOwner = nil -- (this) when tooltip created
ItemRack.TooltipType = nil -- "BAG" or "INVENTORY"
ItemRack.TooltipBag = nil -- bag number
ItemRack.TooltipSlot = nil -- bag or inventory slot number

ItemRack.CurrentTime = GetTime()

ItemRack.MainDock = "" -- "TOPLEFT" "BOTTOMRIGHT" etc
ItemRack.MenuDock = ""

ItemRack.Queue = {} -- [slot]="ItemName" if an item in queue, ie [13]="Arcanite Dragonling", [slot]=nil for no item in queue
ItemRack.NotifyList = {} -- ["item name"] = { bag=0-4, slot=1-x, inv=0-19, hadcooldown=true/nil }
ItemRack.AmmoCounts = {} -- ["Heavy Shot"]=200, ["Thorium Arrow"]=982, etc
ItemRack.TrinketsPaired = false -- true if the two trinkets are next to each other

ItemRack.KeyBindingsSettled = false

ItemRack.MenuDockedTo = nil -- "SET" for set window, "CHARACTERSHEET" for PaperDollFrame, nil for rack

ItemRack.SelectedEvent = 0 -- index in list of event selected

ItemRack.CanWearOneHandOffHand = nil -- whether player can wear one-hand in offhand (warrior, rogue, hunter)

ItemRack.Buffs = {} -- table indexed by buff names, whether a buff is on or not
ItemRack.BankedItems = {} -- items in the bank indexed by itemID
ItemRack.BankSlots = { -1,5,6,7,8,9,10 }

local eventList = {} -- note the departure from using the table for local values -- mod will be rewritten to a consistent style
local eventListSize = 1

local scratchTable = { {}, {} } -- for secondary sorts
local scratchTableSize = { 1, 1 }

--[[ reference tables ]]--

ItemRack.OptInfo = {
	["ItemRack_Control_Rotate"] = { text=ItemRackText.CONTROL_ROTATE_TEXT, tooltip=ItemRackText.CONTROL_ROTATE_TOOLTIP },
	["ItemRack_Control_Lock"] = { text=ItemRackText.CONTROL_LOCK_TEXT, tooltip=ItemRackText.CONTROL_LOCK_TOOLTIP },
	["ItemRack_Control_Options"] = { text=ItemRackText.CONTROL_OPTIONS_TEXT, tooltip=ItemRackText.CONTROL_OPTIONS_TOOLTIP },
	["ItemRack_Opt_TooltipFollow"] = { text=ItemRackText.OPT_TOOLTIPFOLLOW_TEXT, tooltip=ItemRackText.OPT_TOOLTIPFOLLOW_TOOLTIP, type="Check", info="TooltipFollow" },
	["ItemRack_Opt_CooldownNumbers"] = { text=ItemRackText.OPT_COOLDOWNNUMBERS_TEXT, tooltip=ItemRackText.OPT_COOLDOWNNUMBERS_TOOLTIP, type="Check", info="CooldownNumbers" },
	["ItemRack_Opt_Soulbound"] = { text=ItemRackText.OPT_SOULBOUND_TEXT, tooltip=ItemRackText.OPT_SOULBOUND_TOOLTIP, type="Check", info="Soulbound" },
	["ItemRack_Opt_Bindings"] = { text=ItemRackText.OPT_BINDINGS_TEXT, tooltip=ItemRackText.OPT_BINDINGS_TOOLTIP, type="Check", info="Bindings" },
	["ItemRack_Opt_MenuShift"] = { text=ItemRackText.OPT_MENUSHIFT_TEXT, tooltip=ItemRackText.OPT_MENUSHIFT_TOOLTIP, type="Check", info="MenuShift" },
	["ItemRack_Opt_Close"] = { text=ItemRackText.OPT_CLOSE_TEXT, tooltip=ItemRackText.OPT_CLOSE_TOOLTIP },
	["ItemRack_InvFrame_Resize"] = { text=ItemRackText.INVFRAME_RESIZE_TEXT, tooltip=ItemRackText.INVFRAME_RESIZE_TOOLTIP },
	["ItemRack_Opt_ShowEmpty"] = { text=ItemRackText.OPT_SHOWEMPTY_TEXT, tooltip=ItemRackText.OPT_SHOWEMPTY_TOOLTIP, type="Check", info="ShowEmpty" },
	["ItemRack_Opt_FlipMenu"] = { text=ItemRackText.OPT_FLIPMENU_TEXT, tooltip=ItemRackText.OPT_FLIPMENU_TOOLTIP, type="Check", info="FlipMenu" },
	["ItemRack_Opt_RightClick"] = { text=ItemRackText.OPT_RIGHTCLICK_TEXT, tooltip=ItemRackText.OPT_RIGHTCLICK_TOOLTIP, type="Check", info="RightClick" },
	["ItemRack_Opt_TinyTooltip"] = { text=ItemRackText.OPT_TINYTOOLTIP_TEXT, tooltip=ItemRackText.OPT_TINYTOOLTIP_TOOLTIP, type="Check", info="TinyTooltip" },
	["ItemRack_Opt_ShowTooltips"] = { text=ItemRackText.OPT_SHOWTOOLTIPS_TEXT, tooltip=ItemRackText.OPT_SHOWTOOLTIPS_TOOLTIP, type="Check", info="ShowTooltips" },
	["ItemRack_Opt_Notify"] = { text=ItemRackText.OPT_NOTIFY_TEXT, tooltip=ItemRackText.OPT_NOTIFY_TOOLTIP, type="Check", info="Notify" },
	["ItemRack_Opt_RotateMenu"] = { text=ItemRackText.OPT_ROTATEMENU_TEXT, tooltip=ItemRackText.OPT_ROTATEMENU_TOOLTIP, type="Check", info="RotateMenu" },
	["ItemRack_Sets_Close"] = { text=ItemRackText.SETS_CLOSE_TEXT, tooltip=ItemRackText.SETS_CLOSE_TOOLTIP },
	["ItemRack_Sets_NameLabel"] = { text=ItemRackText.SETS_NAMELABEL_TEXT, type="Label" },
	["ItemRack_Sets_HideSet"] = { text=ItemRackText.SETS_HIDESET_TEXT, tooltip=ItemRackText.SETS_HIDESET_TOOLTIP, type="Check" },
	["ItemRack_Sets_Tab1"] = { text=ItemRackText.SETS_TAB1_TEXT, tooltip=ItemRackText.SETS_TAB1_TOOLTIP, type="Tab" },
	["ItemRack_Sets_Tab2"] = { text=ItemRackText.SETS_TAB2_TEXT, tooltip=ItemRackText.SETS_TAB2_TOOLTIP, type="Tab" },
	["ItemRack_Sets_Tab3"] = { text=ItemRackText.SETS_TAB3_TEXT, tooltip=ItemRackText.SETS_TAB3_TOOLTIP, type="Tab" },
	["ItemRack_Opt_ShowIcon"] = { text=ItemRackText.OPT_SHOWICON_TEXT, tooltip=ItemRackText.OPT_SHOWICON_TOOLTIP, type="Check", info="ShowIcon" },
	["ItemRack_Opt_DisableToggle"] = { text=ItemRackText.OPT_DISABLETOGGLE_TEXT, tooltip=ItemRackText.OPT_DISABLETOGGLE_TOOLTIP, type="Check", info="DisableToggle" },
	["ItemRack_Sets_Lock"] = { text=ItemRackText.CONTROL_LOCK_TEXT, tooltip=ItemRackText.CONTROL_LOCK_TOOLTIP },
	["ItemRack_Sets_BindButton"] = { text=ItemRackText.SETS_BINDBUTTON_TEXT, tooltip=ItemRackText.SETS_BINDBUTTON_TOOLTIP, type="Label" },
	["ItemRack_Sets_SaveButton"] = { text=ItemRackText.SETS_SAVEBUTTON_TEXT, tooltip=ItemRackText.SETS_SAVEBUTTON_TOOLTIP, type="Label" },
	["ItemRack_Sets_RemoveButton"] = { text=ItemRackText.SETS_REMOVEBUTTON_TEXT, tooltip=ItemRackText.SETS_REMOVEBUTTON_TOOLTIP, type="Label" },
	["ItemRack_Opt_FlipBar"] = { text=ItemRackText.OPT_FLIPBAR_TEXT, tooltip=ItemRackText.OPT_FLIPBAR_TOOLTIP, type="Check", info="FlipBar" },
	["ItemRack_Opt_EnableEvents"] = { text=ItemRackText.OPT_ENABLEEVENTS_TEXT, tooltip=ItemRackText.OPT_ENABLEEVENTS_TOOLTIP, type="Check", info="EnableEvents" },
	["ItemRack_Opt_CompactList"] = { text=ItemRackText.OPT_COMPACTLIST_TEXT, tooltip=ItemRackText.OPT_COMPACTLIST_TOOLTIP, type="Check", info="CompactList" },
	["ItemRack_SavedSets_Close"] = { text=ItemRackText.OPT_SAVEDSETSCLOSE_TEXT, tooltip=ItemRackText.OPT_SAVEDSETSCLOSE_TOOLTIP },
	["ItemRack_Events_DeleteButton"] = { text=ItemRackText.EVENTSDELETE_TEXT, tooltip=ItemRackText.EVENTSDELETE_TOOLTIP },
	["ItemRack_Events_EditButton"] = { text=ItemRackText.EVENTSEDIT_TEXT, tooltip=ItemRackText.EVENTSEDIT_TOOLTIP },
	["ItemRack_Events_NewButton"] = { text=ItemRackText.EVENTSNEW_TEXT, tooltip=ItemRackText.EVENTSNEW_TOOLTIP },
	["ItemRack_EditEvent_Save"] = { text=ItemRackText.EVENTSSAVE_TEXT, tooltip=ItemRackText.EVENTSSAVE_TOOLTIP },
	["ItemRack_EditEvent_Test"] = { text=ItemRackText.EVENTSTEST_TEXT, tooltip=ItemRackText.EVENTSTEST_TOOLTIP },
	["ItemRack_EditEvent_Cancel"] = { text=ItemRackText.EVENTSCANCEL_TEXT, tooltip=ItemRackText.EVENTSCANCEL_TOOLTIP },
	["ItemRack_EventName"] = { text=ItemRackText.EVENTNAME_TEXT, tooltip=ItemRackText.EVENTNAME_TOOLTIP },
	["ItemRack_EventTrigger"] = { text=ItemRackText.EVENTTRIGGER_TEXT, tooltip=ItemRackText.EVENTTRIGGER_TOOLTIP },
	["ItemRack_EventDelay"] = { text=ItemRackText.EVENTDELAY_TEXT, tooltip=ItemRackText.EVENTDELAY_TOOLTIP },
	["ItemRack_Opt_NotifyThirty"] = { text=ItemRackText.OPT_NOTIFYTHIRTY_TEXT, tooltip=ItemRackText.OPT_NOTIFYTHIRTY_TOOLTIP, type="Check", info="NotifyThirty" },
	["ItemRack_Opt_ShowAllEvents"] = { text=ItemRackText.OPT_SHOWALLEVENTS_TEXT, tooltip=ItemRackText.OPT_SHOWALLEVENTS_TOOLTIP, type="Check", info="ShowAllEvents" },
	["ItemRack_ResetButton"] = { text=ItemRackText.RESETBUTTON_TEXT, tooltip=ItemRackText.RESETBUTTON_TOOLTIP },
	["ItemRack_Opt_AllowHidden"] = { text=ItemRackText.OPT_ALLOWHIDDEN_TEXT, tooltip=ItemRackText.OPT_ALLOWHIDDEN_TOOLTIP, type="Check", info="AllowHidden" },
	["ItemRack_Opt_LargeFont"] = { text=ItemRackText.OPT_LARGEFONT_TEXT, tooltip=ItemRackText.OPT_LARGEFONT_TOOLTIP, type="Check", info="LargeFont" },
	["ItemRack_ResetEventsButton"] = { text=ItemRackText.RESETEVENTSBUTTON_TEXT, tooltip=ItemRackText.RESETEVENTSBUTTON_TOOLTIP },
	["ItemRack_Opt_SquareMinimap"] = { text=ItemRackText.OPT_SQUAREMINIMAP_TEXT, tooltip=ItemRackText.OPT_SQUAREMINIMAP_TOOLTIP, info="SquareMinimap" },
	["ItemRack_Opt_BigCooldown"] = { text=ItemRackText.OPT_BIGCOOLDOWN_TEXT, tooltip=ItemRackText.OPT_BIGCOOLDOWN_TOOLTIP, info="BigCooldown" },
	["ItemRack_ShowHelmText"] = { text="Helm", type="Label" },
	["ItemRack_ShowCloakText" ] = { text="Cloak", type="Label" },
	["ItemRack_Opt_SetLabels"] = { text=ItemRackText.OPT_SETLABELS_TEXT, tooltip=ItemRackText.OPT_SETLABELS_TOOLTIP, info="SetLabels" },
	["ItemRack_Opt_AutoToggle"] = { text=ItemRackText.OPT_AUTOTOGGLE_TEXT, tooltip=ItemRackText.OPT_AUTOTOGGLE_TOOLTIP, info="AutoToggle" },
}

-- numerically indexed list of options for scrollable options window
ItemRack.OptScroll = {
	{ idx="ItemRack_Opt_ShowTooltips" },
	{ idx="ItemRack_Opt_TooltipFollow", dependency="ItemRack_Opt_ShowTooltips" },
	{ idx="ItemRack_Opt_TinyTooltip", dependency="ItemRack_Opt_ShowTooltips" },
	{ idx="ItemRack_Opt_ShowIcon" },
	{ idx="ItemRack_Opt_DisableToggle", dependency="ItemRack_Opt_ShowIcon" },
	{ idx="ItemRack_Opt_SquareMinimap", dependency="ItemRack_Opt_ShowIcon" },
	{ idx="ItemRack_Opt_Bindings" },
	{ idx="ItemRack_Opt_SetLabels" },
	{ idx="ItemRack_Opt_CooldownNumbers" },
	{ idx="ItemRack_Opt_BigCooldown", dependency="ItemRack_Opt_CooldownNumbers" },
	{ idx="ItemRack_Opt_Notify" },
	{ idx="ItemRack_Opt_NotifyThirty", dependency="ItemRack_Opt_Notify" },
	{ idx="ItemRack_Opt_MenuShift" },
	{ idx="ItemRack_Opt_AutoToggle" },
	{ idx="ItemRack_Opt_ShowEmpty" },
	{ idx="ItemRack_Opt_AllowHidden" },
	{ idx="ItemRack_Opt_Soulbound" },
	{ idx="ItemRack_Opt_RightClick" },
	{ idx="ItemRack_Opt_FlipMenu" },
	{ idx="ItemRack_Opt_RotateMenu" },
	{ idx="ItemRack_Opt_FlipBar" }
}

-- paperdoll_slot=frame name of the slot on the paperdoll frame (for alt+click purposes)
-- ["SlotName"]=1 for each allowable slot
-- swappable=1 for slots that can be swapped in combat
-- ignore_soulbound = ignore soulbound flag for this slot
ItemRack.Indexes = {
	[0] = { name=AMMOSLOT, paperdoll_slot="CharacterAmmoSlot", keybind="Use Ammo Item", ignore_soulbound=1, swappable=1, INVTYPE_AMMO=1 },
	[1] = { name=INVTYPE_HEAD, paperdoll_slot="CharacterHeadSlot", keybind="Use Head Item", INVTYPE_HEAD=1 },
	[2] = { name=INVTYPE_NECK, paperdoll_slot="CharacterNeckSlot", keybind="Use Neck Item", INVTYPE_NECK=1 },
	[3] = { name=INVTYPE_SHOULDER, paperdoll_slot="CharacterShoulderSlot", keybind="Use Shoulder Item", INVTYPE_SHOULDER=1 },
	[4] = { name=INVTYPE_BODY, paperdoll_slot="CharacterShirtSlot", keybind="Use Shirt Item", ignore_soulbound=1, INVTYPE_BODY=1 },
	[5] = { name=INVTYPE_CHEST, paperdoll_slot="CharacterChestSlot", keybind="Use Chest Item", INVTYPE_CHEST=1, INVTYPE_ROBE=1 },
	[6] = { name=INVTYPE_WAIST, paperdoll_slot="CharacterWaistSlot", keybind="Use Waist Item", INVTYPE_WAIST=1 },
	[7] = { name=INVTYPE_LEGS, paperdoll_slot="CharacterLegsSlot", keybind="Use Legs Item", INVTYPE_LEGS=1 },
	[8] = { name=INVTYPE_FEET, paperdoll_slot="CharacterFeetSlot", keybind="Use Feet Item", INVTYPE_FEET=1 },
	[9] = { name=INVTYPE_WRIST, paperdoll_slot="CharacterWristSlot", keybind="Use Wrist Item", INVTYPE_WRIST=1 },
	[10]= { name=INVTYPE_HAND, paperdoll_slot="CharacterHandsSlot", keybind="Use Hands Item", INVTYPE_HAND=1 },
	[11]= { name=INVTYPE_FINGER, paperdoll_slot="CharacterFinger0Slot", keybind="Use Top Finger Item", INVTYPE_FINGER=1 },
	[12]= { name=INVTYPE_FINGER, paperdoll_slot="CharacterFinger1Slot", keybind="Use Bottom Finger Item", INVTYPE_FINGER=1 },
	[13]= { name=INVTYPE_TRINKET, paperdoll_slot="CharacterTrinket0Slot", ignore_soulbound=1, keybind="Use Top Trinket Item", INVTYPE_TRINKET=1 },
	[14]= { name=INVTYPE_TRINKET, paperdoll_slot="CharacterTrinket1Slot", ignore_soulbound=1, keybind="Use Bottom Trinket Item", INVTYPE_TRINKET=1 },
	[15]= { name=INVTYPE_CLOAK, paperdoll_slot="CharacterBackSlot", keybind="Use Back Item", INVTYPE_CLOAK=1 },
	[16]= { name=INVTYPE_WEAPONMAINHAND, paperdoll_slot="CharacterMainHandSlot", keybind="Use Main-Hand Item", swappable=1, INVTYPE_WEAPONMAINHAND=1, INVTYPE_2HWEAPON=1, INVTYPE_WEAPON=1 },
	[17]= { name=INVTYPE_WEAPONOFFHAND, paperdoll_slot="CharacterSecondaryHandSlot", keybind="Use Off-Hand Item", swappable=1, INVTYPE_WEAPONOFFHAND=1, INVTYPE_SHIELD=1, INVTYPE_HOLDABLE=1, INVTYPE_WEAPON=1 },
	[18]= { name=INVTYPE_RANGED, paperdoll_slot="CharacterRangedSlot", keybind="Use Range Item", swappable=1, INVTYPE_RANGED=1, INVTYPE_RANGEDRIGHT=1, INVTYPE_THROWN=1, INVTYPE_RELIC=1 },
	[19]= { name=INVTYPE_TABARD, paperdoll_slot="CharacterTabardSlot", keybind="Use Tabard Item", ignore_soulbound=1, INVTYPE_TABARD=1 }
}

-- "add" or "remove" a frame from UISpecialFrames
local function make_escable(frame,add)
	local found
	for i in UISpecialFrames do
		if UISpecialFrames[i]==frame then
			found = i
		end
	end
	if not found and add=="add" then
		table.insert(UISpecialFrames,frame)
	elseif found and add=="remove" then
		table.remove(UISpecialFrames,found)
	end
end

local _,_,durability_pattern = string.find(DURABILITY_TEMPLATE,"(.+) .+/.+")
durability_pattern = durability_pattern or ""

-- dock-dependant offset and directions: MainDock..MenuDock
-- x/yoff   = offset MenuFrame is positioned to InvFrame
-- x/ydir   = direction items are added to menu
-- x/ystart = starting offset when building a menu, relativePoint MenuDock
-- mx/y     = offset MenuFrame is positioned to contents of InvFrame
local dock_stats = { ["TOPRIGHTTOPLEFT"] =		 { xoff=-4, yoff=0,  xdir=1,  ydir=-1, xstart=8,   ystart=-8,  mx=3,  my=8 },
					 ["BOTTOMRIGHTBOTTOMLEFT"] = { xoff=-4, yoff=0,  xdir=1,  ydir=1,  xstart=8,   ystart=44,  mx=3,  my=-8 },
					 ["TOPLEFTTOPRIGHT"] =		 { xoff=4,  yoff=0,  xdir=-1, ydir=-1, xstart=-44, ystart=-8,  mx=-2, my=8 },
					 ["BOTTOMLEFTBOTTOMRIGHT"] = { xoff=4,  yoff=0,  xdir=-1, ydir=1,  xstart=-44, ystart=44,  mx=-2, my=-8 },
					 ["TOPRIGHTBOTTOMRIGHT"] =   { xoff=0,  yoff=-4, xdir=-1, ydir=1,  xstart=-44,  ystart=44, mx=8,  my=3 },
					 ["BOTTOMRIGHTTOPRIGHT"] =   { xoff=0,  yoff=4,	 xdir=-1, ydir=-1, xstart=-44,  ystart=-8, mx=8,  my=-3 },
					 ["TOPLEFTBOTTOMLEFT"] =	 { xoff=0,  yoff=-4, xdir=1,  ydir=1,  xstart=8,   ystart=44,  mx=-8, my=2 },
					 ["BOTTOMLEFTTOPLEFT"] =	 { xoff=0,  yoff=4,  xdir=1,  ydir=-1, xstart=8,   ystart=-8,  mx=-8, my=-2 } }

-- returns info depending on current docking. ie: dock_info("xoff")
local function dock_info(which)

	local anchor = ItemRack.MainDock..ItemRack.MenuDock

	if dock_stats[anchor] and which and dock_stats[anchor][which] then
		return dock_stats[anchor][which]
	else
		return 0
	end
end

-- returns info depending on where the window is currently
-- since frame scales and positions can be nil at the most inconvenient times, it approximates
-- its corner based on settings and makes no assumptions that even UIParent exists
-- no argument : return corner window is in
-- "LEFTRIGHT" : return "LEFT" or "RIGHT"
-- "TOPBOTTOM" : return "TOP" or "BOTTOM"
local function corner_info(which)

	local length,cx,cy,xpoint,ypoint
	local vertside,horzside = "TOP","LEFT"
	local info

	if table.getn(ItemRack_Users[user].Bar)>0 then
		length = table.getn(ItemRack_Users[user].Bar)*40 + 32
		if ItemRack_Users[user].MainOrient=="HORIZONTAL" then
			cx = length
			cy = 55
		else
			cx = 55
			cy = length
		end
		xpoint = cx/2+(ItemRack_Users[user].XPos*ItemRack_Users[user].MainScale)
		ypoint = (ItemRack_Users[user].YPos*ItemRack_Users[user].MainScale)-cy/2

		if xpoint<(UIParent and UIParent:GetWidth()/2 or 512) then
			horzside = "LEFT"
		else
			horzside = "RIGHT"
		end

		if ypoint<(UIParent and UIParent:GetHeight()/2 or 386) then
			vertside = "BOTTOM"
		else
			vertside = "TOP"
		end
	end

	if which=="LEFTRIGHT" then
		info = horzside
	elseif which=="TOPBOTTOM" then
		info = vertside
	else
		info = vertside..horzside
	end

	return info

end

local inv_dock = {
	[0]  = { orient="HORIZONTAL", maindock="BOTTOMLEFT", menudock="TOPLEFT" },
	[1]  = { orient="VERTICAL", maindock="TOPLEFT", menudock="TOPRIGHT" },
	[2]  = { orient="VERTICAL", maindock="TOPLEFT", menudock="TOPRIGHT" },
	[3]  = { orient="VERTICAL", maindock="TOPLEFT", menudock="TOPRIGHT" },
	[4]  = { orient="VERTICAL", maindock="TOPLEFT", menudock="TOPRIGHT" },
	[5]  = { orient="VERTICAL", maindock="TOPLEFT", menudock="TOPRIGHT" },
	[6]  = { orient="VERTICAL", maindock="TOPRIGHT", menudock="TOPLEFT" },
	[7]  = { orient="VERTICAL", maindock="TOPRIGHT", menudock="TOPLEFT" },
	[8]  = { orient="VERTICAL", maindock="TOPRIGHT", menudock="TOPLEFT" },
	[9]  = { orient="VERTICAL", maindock="TOPLEFT", menudock="TOPRIGHT" },
	[10]  = { orient="VERTICAL", maindock="TOPRIGHT", menudock="TOPLEFT" },
	[11]  = { orient="VERTICAL", maindock="TOPRIGHT", menudock="TOPLEFT" },
	[12]  = { orient="VERTICAL", maindock="TOPRIGHT", menudock="TOPLEFT" },
	[13]  = { orient="VERTICAL", maindock="TOPRIGHT", menudock="TOPLEFT" },
	[14]  = { orient="VERTICAL", maindock="TOPRIGHT", menudock="TOPLEFT" },
	[15] = { orient="VERTICAL", maindock="TOPLEFT", menudock="TOPRIGHT" },
	[16] = { orient="HORIZONTAL", maindock="BOTTOMLEFT", menudock="TOPLEFT" },
	[17] = { orient="HORIZONTAL", maindock="BOTTOMLEFT", menudock="TOPLEFT" },
	[18] = { orient="HORIZONTAL", maindock="BOTTOMLEFT", menudock="TOPLEFT" },
	[19] = { orient="VERTICAL", maindock="TOPLEFT", menudock="TOPRIGHT" }
}

-- places the menu against the invslot
-- setframe = true when docking to set frame
function ItemRack_DockMenu(invslot,relativeTo)

	local attachTo = ((not relativeTo) and "ItemRackInv"..invslot) or (relativeTo=="TITAN" and "TitanPanelItemRackButton") or (relativeTo=="SET" and "ItemRack_Sets_Inv"..invslot) or (relativeTo=="MINIMAP" and "ItemRack_IconFrame") or ItemRack.Indexes[invslot].paperdoll_slot
	local item = getglobal(attachTo)
	local noflip = ItemRack_Settings.FlipMenu=="OFF"
	local corner=corner_info()
	local mainorient = ItemRack_Users[user].MainOrient
	local ynudge -- amount if any to nudge the y offset

	if relativeTo then
		ItemRack.MenuDockedTo = relativeTo
	end

	if relativeTo=="MINIMAP" then
		if (ItemRack_IconFrame:GetTop() or 0)<(UIParent:GetHeight() or 0)/2 then
			ItemRack.MainDock = "TOPLEFT"
			ItemRack.MenuDock = "BOTTOMLEFT"
			ynudge = -12
		else
			ItemRack.MainDock = "BOTTOMRIGHT"
			ItemRack.MenuDock = "TOPRIGHT"
			ynudge = 12
		end
	elseif relativeTo=="TITAN" then
		local xpos, ypos = GetCursorPosition()
		if ypos<400 then
			ItemRack.MainDock = "TOPLEFT"
			ItemRack.MenuDock = "BOTTOMLEFT"
			ynudge = 0
		else
			ItemRack.MainDock = "BOTTOMLEFT"
			ItemRack.MenuDock = "TOPLEFT"
			ynudge = 0
		end
	elseif mainorient=="HORIZONTAL" then
		if corner=="BOTTOMLEFT" then
			ItemRack.MainDock = noflip and "TOPLEFT" or "BOTTOMLEFT"
			ItemRack.MenuDock = noflip and "BOTTOMLEFT" or "TOPLEFT"
		elseif corner=="BOTTOMRIGHT" then
			ItemRack.MainDock = noflip and "TOPRIGHT" or "BOTTOMRIGHT"
			ItemRack.MenuDock = noflip and "BOTTOMRIGHT" or "TOPRIGHT"
		elseif corner=="TOPLEFT" then
			ItemRack.MainDock = noflip and "BOTTOMLEFT" or "TOPLEFT"
			ItemRack.MenuDock = noflip and "TOPLEFT" or "BOTTOMLEFT"
		else -- "TOPRIGHT"
			ItemRack.MainDock = noflip and "BOTTOMRIGHT" or "TOPRIGHT"
			ItemRack.MenuDock = noflip and "TOPRIGHT" or "BOTTOMRIGHT"
		end
	else
		if corner=="BOTTOMLEFT" then
			ItemRack.MainDock = noflip and "BOTTOMRIGHT" or "BOTTOMLEFT"
			ItemRack.MenuDock = noflip and "BOTTOMLEFT" or "BOTTOMRIGHT"
		elseif corner=="BOTTOMRIGHT" then
			ItemRack.MainDock = noflip and "BOTTOMLEFT" or "BOTTOMRIGHT"
			ItemRack.MenuDock = noflip and "BOTTOMRIGHT" or "BOTTOMLEFT"
		elseif corner=="TOPLEFT" then
			ItemRack.MainDock = noflip and "TOPRIGHT" or "TOPLEFT"
			ItemRack.MenuDock = noflip and "TOPLEFT" or "TOPRIGHT"
		else -- "TOPRIGHT"
			ItemRack.MainDock = noflip and "TOPLEFT" or "TOPRIGHT"
			ItemRack.MenuDock = noflip and "TOPRIGHT" or "TOPLEFT"
		end
	end

	if relativeTo=="SET" then
		ItemRack_MenuFrame:SetScale(ItemRack_SetsFrame:GetScale())
		ItemRack.MainDock = inv_dock[invslot].maindock
		ItemRack.MenuDock = inv_dock[invslot].menudock
	elseif relativeTo=="CHARACTERSHEET" then
		ItemRack_MenuFrame:SetScale(getglobal(ItemRack.Indexes[1].paperdoll_slot):GetScale())
		ItemRack.MainDock = inv_dock[invslot].maindock
		ItemRack.MenuDock = inv_dock[invslot].menudock
		if ItemRack.MainDock == "TOPLEFT" then
			-- horizontal menus always go to right on character sheet
			ItemRack.MainDock = "TOPRIGHT"
			ItemRack.MenuDock = "TOPLEFT"
		end
	else
		ItemRack_MenuFrame:SetScale(ItemRack_Users[user].MainScale)
	end

	ItemRack_MenuFrame:ClearAllPoints()
	ItemRack_MenuFrame:SetPoint(ItemRack.MenuDock,attachTo,ItemRack.MainDock,dock_info("mx"),dock_info("my")+ (ynudge and ynudge or 0))
end

-- v1="Left1" or "Right1" up to "Left30" or "Right30"
local function is_red(v1)

	local its_red,r,g,b = false

	r,g,b = getglobal("Rack_TooltipScanText"..v1):GetTextColor()
	if r>.9 and g<.2 and b<.2 then
		its_red = true
	end

	return its_red
end

-- returns true if the player can wear this item (no red text on its tooltip)
-- separated from get_item_info because tooltip scanning should be done only at utmost need
local function player_can_wear(bag,slot,invslot)

	local found,i,txt = false

	for i=2,15 do
		-- ClearLines doesn't remove colors, manually remove them
		getglobal("Rack_TooltipScanTextLeft"..i):SetTextColor(0,0,0)
		getglobal("Rack_TooltipScanTextRight"..i):SetTextColor(0,0,0)
	end
	Rack_TooltipScan:SetBagItem(bag,slot)

	for i=2,15 do
		txt = getglobal("Rack_TooltipScanTextLeft"..i):GetText()
		-- if either left or right text is red and this isn't a Durability x/x line, this item can't be worn
		if (is_red("Left"..i) or is_red("Right"..i)) and not string.find(txt,durability_pattern) and not string.find(txt,"^Requires") then
			found = true
		end
	end

	local _,_,_,itemType = Rack.GetItemInfo(bag,slot)
	if itemType=="INVTYPE_WEAPON" and invslot==17 and not ItemRack.CanWearOneHandOffHand then
		found = true
	end

	return not found
end

-- the old central info gatherer, now a wrapper to Rack.GetItemInfo
local function get_item_info(bag,slot)

	local texture,name,equipslot,soulbound,count

	if bag==20 then
		-- if querying set slot, return current set texture and name
		name = Rack.CurrentSet()
		texture = "Interface\\AddOns\\ItemRack\\ItemRack-Icon"
		if name and Rack_User[user].Sets[name] and not string.find(name,"^ItemRack") and not string.find(name,"^Rack-") then
			texture = Rack_User[user].Sets[name].icon
		else
			name = nil
		end
		return texture,name
	end

	texture,_,name,equipslot = Rack.GetItemInfo(bag,slot)
	if slot then
		_,count = GetContainerItemInfo(bag,slot)
	end
	if ItemRack_Settings.Soulbound=="ON" and name then
		local text
		if slot then
			Rack_TooltipScan:SetBagItem(bag,slot)
		else
			Rack_TooltipScan:SetInventoryItem("player",bag)
		end
		for i=2,5 do
			text = getglobal("Rack_TooltipScanTextLeft"..i):GetText() or ""
			if text==ITEM_SOULBOUND or text==ITEM_BIND_QUEST or text==ITEM_CONJURED then
				soulbound = true
			end
		end
	end

	return texture,name,equipslot,soulbound,count
end

local function cursor_empty()
	return not (CursorHasItem() or CursorHasMoney() or CursorHasSpell())
end

-- updates cooldown spinners in the menu
local function update_menu_cooldowns()

	local start, duration, enable

	if ItemRack.InvOpen then
		for i=1,ItemRack.NumberOfItems do
			if ItemRack.BaggedItems[i].bag then
				start, duration, enable = GetContainerItemCooldown(ItemRack.BaggedItems[i].bag,ItemRack.BaggedItems[i].slot)
				CooldownFrame_SetTimer(getglobal("ItemRackMenu"..i.."Cooldown"), start, duration, enable)
			else
				getglobal("ItemRackMenu"..i.."Time"):SetText("")
			end
		end
	end
end

-- updates cooldown spinners in the main bar
local function update_inv_cooldowns()

	local i, start, duration, enable

	if table.getn(ItemRack_Users[user].Bar)>0 then
		for i=1,table.getn(ItemRack_Users[user].Bar) do
			start, duration, enable = GetInventoryItemCooldown("player",ItemRack_Users[user].Bar[i])
			CooldownFrame_SetTimer(getglobal("ItemRackInv"..ItemRack_Users[user].Bar[i].."Cooldown"), start, duration, enable)
		end
	end

	update_menu_cooldowns()
end

-- call this when window has changed and cooldowns need redrawn
local function cooldowns_need_updating()
	Rack.StartTimer("CooldownUpdate",.25)
	ItemRack.CooldownsNeedUpdating = true
end

local function populate_baggeditems(idx,bag,slot,name,texture)

	if not ItemRack.BaggedItems[idx] then
		ItemRack.BaggedItems[idx] = {}
	end
	ItemRack.BaggedItems[idx].bag = bag
	ItemRack.BaggedItems[idx].slot = slot
	ItemRack.BaggedItems[idx].name = name
	ItemRack.BaggedItems[idx].texture = texture
end

-- to minimize garbage creation, tables are manipulated by copying values instead of tables
local function copy_baggeditems(source,dest)

	if not ItemRack.BaggedItems[dest] then
		ItemRack.BaggedItems[dest] = {}
	end
	ItemRack.BaggedItems[dest].bag = ItemRack.BaggedItems[source].bag
	ItemRack.BaggedItems[dest].slot = ItemRack.BaggedItems[source].slot
	ItemRack.BaggedItems[dest].name = ItemRack.BaggedItems[source].name
	ItemRack.BaggedItems[dest].texture = ItemRack.BaggedItems[source].texture
end

-- sorts menu up to stop_point, which is idx+1 usually (sort uses stop_point as a temp spot for swapping)
local function sort_menu(stop_point)

	local done,i=false

	if stop_point>2 then
		while not done do
			done = true
			for i=1,stop_point-2 do
				if ItemRack.BaggedItems[i].name > ItemRack.BaggedItems[i+1].name then
					copy_baggeditems(i,stop_point)
					copy_baggeditems(i+1,i)
					copy_baggeditems(stop_point,i+1)

					done = false
				end
			end
		end
	end

end

function ItemRack_CurrentSet()
	return Rack.CurrentSet()
end

-- builds a menu outward from invslot (0-19)
-- setframe = true if this is to dock to the set frame
function ItemRack_BuildMenu(invslot,relativeTo)

	local idx,i,j,k,item,texture,name,equipslot,soulbound,found = 1
	local mainorient = ItemRack_Users[user].MainOrient
	local bagStart,bagEnd = 0,4

	if relativeTo=="SET" or relativeTo=="CHARACTERSHEET" then
		-- if displaying to a set, then 
		mainorient = "VERTICAL"
		if invslot==0 or invslot==16 or invslot==17 or invslot==18 then
			mainorient = "HORIZONTAL"
		end
	elseif relativeTo=="MINIMAP" then
		mainorient = "HORIZONTAL"
	elseif relativeTo=="TITAN" then
		mainorient = "HORIZONTAL"
	end
	ItemRack_DockMenu(invslot,relativeTo)

	for i=1,table.getn(ItemRack_Users[user].Bar) do
		if invslot~=ItemRack_Users[user].Bar[i] then
			getglobal("ItemRackInv"..ItemRack_Users[user].Bar[i]):UnlockHighlight()
		else
			getglobal("ItemRackInv"..ItemRack_Users[user].Bar[i]):LockHighlight()
		end
	end

	if invslot==0 then
		-- if this is an ammo slot, clear totals
		for i in ItemRack.AmmoCounts do
			ItemRack.AmmoCounts[i] = 0
		end
	end

	if invslot<20 then

		if ItemRack.BankIsOpen then
			bagStart,bagEnd = -1,10
		end

		-- go through bags and gather items into .BaggedItems
		for i=bagStart,bagEnd do
			for j=1,GetContainerNumSlots(i) do
				texture,name,equipslot,soulbound,count = get_item_info(i,j)
				soulbound = soulbound or ItemRack.Indexes[invslot].ignore_soulbound -- pretend item soulbound if flagged to ignore_soulbound
				if (equipslot and ItemRack.Indexes[invslot][equipslot]) and (soulbound or ItemRack_Settings.Soulbound=="OFF") then
					if ItemRack_Settings.AllowHidden=="ON" and ItemRack_Users[user].Ignore[name] and not IsAltKeyDown() then
						-- skip items that are on ignore list
					elseif player_can_wear(i,j,invslot) then
						if invslot==0 and count then
							-- if this is an ammo slot menu
							ItemRack.AmmoCounts[name] = (ItemRack.AmmoCounts[name] or 0) + count
							found = false
							for k=1,(idx-1) do
								if ItemRack.BaggedItems[k].name==name then
									found=true
								end
							end
							if not found then
								populate_baggeditems(idx,i,j,name,texture)
								idx = idx + 1
							end					
						else
							populate_baggeditems(idx,i,j,name,texture)
							idx = idx + 1
						end
					end
				end
			end
		end
		sort_menu(idx)

		if ItemRack_Settings.ShowEmpty=="ON" and GetInventoryItemLink("player",invslot) and not (ItemRack_Settings.RightClick=="ON" and (invslot==13 or invslot==14)) then
			-- add an empty slot to the menu
			_,_,i = string.find(ItemRack.Indexes[invslot].keybind,"Use (.+) Item")
			_,j = GetInventorySlotInfo(string.gsub(ItemRack.Indexes[invslot].paperdoll_slot,"Character",""))
			populate_baggeditems(idx,nil,nil,"(empty)",j)
			idx = idx + 1
		end

	else
		-- this is a menu for sets
		-- go through sets and gather them into .BaggedItems
		for i in Rack_User[user].Sets do
			if not string.find(i,"^ItemRack") and not string.find(i,"^Rack-") and (not Rack_User[user].Sets[i].hide or IsAltKeyDown()) then
				populate_baggeditems(idx,nil,nil,i,Rack_User[user].Sets[i].icon)
				idx = idx + 1
			end
		end
		sort_menu(idx)
	end

	ItemRack.NumberOfItems = math.min(idx-1,ItemRack.MaxItems)

	if ItemRack.NumberOfItems<1 then
		-- user has no bagged items for this type
		ItemRack_MenuFrame:Hide()
	else
		-- display items outward from docking point
		local col,row,xpos,ypos = 0,0,dock_info("xstart"),dock_info("ystart")
		local max_cols = 1

		if ItemRack.NumberOfItems>24 then
			max_cols = 5
		elseif ItemRack.NumberOfItems>18 then
			max_cols = 4
		elseif ItemRack.NumberOfItems>12 then
			max_cols = 3
		elseif ItemRack.NumberOfItems>4 then
			max_cols = 2
		end

		for i=1,ItemRack.NumberOfItems do

			local item = getglobal("ItemRackMenu"..i.."Icon")
			item:SetTexture(ItemRack.BaggedItems[i].texture)
			-- grey menu item if it's on the ignore list (ALT key is down if it made it to BaggedItems)
			if ItemRack_Settings.AllowHidden=="ON" and (ItemRack_Users[user].Ignore[ItemRack.BaggedItems[i].name] or (Rack_User[user].Sets[ItemRack.BaggedItems[i].name] and Rack_User[user].Sets[ItemRack.BaggedItems[i].name].hide)) then
				SetDesaturation(item,1)
			else
				SetDesaturation(item,nil)
			end

			local item = getglobal("ItemRackMenu"..i)
			item:SetPoint("TOPLEFT","ItemRack_MenuFrame",ItemRack.MenuDock,xpos,ypos)

			if (mainorient=="HORIZONTAL" and ItemRack_Settings.RotateMenu=="OFF") or (mainorient=="VERTICAL" and ItemRack_Settings.RotateMenu=="ON") then
				xpos = xpos + dock_info("xdir")*40
				col = col + 1
				if col==max_cols then
					xpos = dock_info("xstart")
					col = 0
					ypos = ypos + dock_info("ydir")*40
					row = row + 1
				end
				item:Show()
			else
				ypos = ypos + dock_info("ydir")*40
				col = col + 1
				if col==max_cols then
					ypos = dock_info("ystart")
					col = 0
					xpos = xpos + dock_info("xdir")*40
					row = row + 1
				end
				item:Show()
			end
		end
		for i=(ItemRack.NumberOfItems+1),ItemRack.MaxItems do
			getglobal("ItemRackMenu"..i):Hide()
		end
		if col==0 then
			row = row-1
		end

		if (mainorient=="HORIZONTAL" and ItemRack_Settings.RotateMenu=="OFF") or (mainorient=="VERTICAL" and ItemRack_Settings.RotateMenu=="ON") then
			ItemRack_MenuFrame:SetWidth(12+(max_cols*40))
			ItemRack_MenuFrame:SetHeight(12+((row+1)*40))
		else
			ItemRack_MenuFrame:SetWidth(12+((row+1)*40))
			ItemRack_MenuFrame:SetHeight(12+(max_cols*40))
		end

		-- apply slot-dependant overlays, ammo count, set name and key bindings
		if invslot==0 then -- if this is an ammo slot, show counts
			for i=1,ItemRack.NumberOfItems do
				if ItemRack.AmmoCounts[ItemRack.BaggedItems[i].name] then
					getglobal("ItemRackMenu"..i.."Count"):SetText(ItemRack.AmmoCounts[ItemRack.BaggedItems[i].name])
				end
			end
		elseif invslot==20 then -- if this is a set slot, show names and bindings
			for i=1,ItemRack.NumberOfItems do
				name = ItemRack.BaggedItems[i].name
				if ItemRack.BankIsOpen and Rack.SetHasBanked(name) then
					getglobal("ItemRackMenu"..i.."Border"):Show()
					getglobal("ItemRackMenu"..i.."Icon"):SetVertexColor(.5,.5,.5)
				else
					getglobal("ItemRackMenu"..i.."Border"):Hide()
					getglobal("ItemRackMenu"..i.."Icon"):SetVertexColor(1,1,1)
				end
					
				item = getglobal("ItemRackMenu"..i.."Name")
				if ItemRack_Settings.SetLabels=="ON" then
					item:SetText(name)
					item:Show()
				else
					item:Hide()
				end
				item = getglobal("ItemRackMenu"..i.."HotKey")
				if Rack_User[user].Sets[name].key and ItemRack_Settings.Bindings=="ON" then
					_,_,j,k = string.find(Rack_User[user].Sets[name].key or "","(.).+(-.)")
					item:SetText((j or "")..(k or ""))
					item:Show()
				else
					item:Hide()
				end
			end
		else -- normal slot (1-19) has no overlays
			for i=1,ItemRack.NumberOfItems do
				getglobal("ItemRackMenu"..i.."Name"):SetText("")
				getglobal("ItemRackMenu"..i.."Count"):SetText("")
				getglobal("ItemRackMenu"..i.."HotKey"):SetText("")

				if ItemRack.BankedItems[ItemRack.BaggedItems[i].name] then
					getglobal("ItemRackMenu"..i.."Border"):Show()
					getglobal("ItemRackMenu"..i.."Icon"):SetVertexColor(.5,.5,.5)
				else
					getglobal("ItemRackMenu"..i.."Border"):Hide()
					getglobal("ItemRackMenu"..i.."Icon"):SetVertexColor(1,1,1)
				end
			end
		end

		ItemRack.InvOpen = invslot
		ItemRack_MenuFrame:Show()
		update_menu_cooldowns()
		Rack.StartTimer("CooldownUpdate",0) -- immediate cooldown update
		Rack.StartTimer("MenuFrame")

	end
end

-- for use with main/menu frames with UIParent parent when relocated by the mod, to register for layout-cache.txt
local function really_setpoint(frame,point,relativeTo,relativePoint,xoff,yoff)
	frame:SetPoint(point,relativeTo,relativePoint,xoff,yoff)
	ItemRack_Users[user].XPos = xoff
	ItemRack_Users[user].YPos = yoff
end

-- updates the image inside the minimap button depending on current set and disable toggle option ("Minimap set menu")
local function draw_minimap_icon()
	local setname = Rack.CurrentSet()

	if setname and Rack_User[user].Sets[setname] and ItemRack_Settings.DisableToggle=="ON" then
		ItemRack_IconFrame_Icon:SetTexture(Rack_User[user].Sets[setname].icon)
	else
		ItemRack_IconFrame_Icon:SetTexture("Interface\\AddOns\\ItemRack\\ItemRack-Icon")
	end
end

-- draws the inventory bar
local function draw_inv()

	local oldx = ItemRack_InvFrame:GetLeft() or ItemRack_Users[user].XPos
	local oldy = ItemRack_InvFrame:GetTop() or ItemRack_Users[user].YPos
	local oldcx = ItemRack_InvFrame:GetWidth() or 0
	local oldcy = ItemRack_InvFrame:GetHeight() or 0
	local bar = ItemRack_Users[user].Bar

	if not oldx or not oldy then
		return -- frame isn't fully defined yet, leave now
	end

	-- for a left-to-right horizontal configuration
	local cx,cy,i,item,texture,xspacer,yspacer = 56,56

	if ItemRack_Users[user].MainOrient=="HORIZONTAL" then
		-- horizontal from left to right
		xdir,ydir,corner,cornerTo,cornerStart,xdirStart,ydirStart,xadd,yadd = 4,0,"TOPRIGHT","TOPLEFT","TOPLEFT",10,-10,40,0

		if ItemRack_Settings.FlipBar=="ON" then
			-- horizontal from right to left
			xdir,ydir,corner,cornerTo,cornerStart,xdirStart,ydirStart,xadd,yadd = -4,0,"TOPLEFT","TOPRIGHT","TOPRIGHT",-10,-10,-40,0
		end

	else
		-- vertical from top to bottom
		xdir,ydir,corner,cornerTo,cornerStart,xdirStart,ydirStart,xadd,yadd = 0,-4,"BOTTOMLEFT","TOPLEFT","TOPLEFT",10,-10,0,40
		
		if ItemRack_Settings.FlipBar=="ON" then
			-- vertical from bottom to top
			xdir,ydir,corner,cornerTo,cornerStart,xdirStart,ydirStart,xadd,yadd = 0,4,"TOPLEFT","BOTTOMLEFT","BOTTOMLEFT",10,10,0,-40
		end
	end

	for i=0,20 do
		getglobal("ItemRackInv"..i):Hide()
	end
	ItemRack.TrinketsPaired = false -- changes to true if two trinkets are beside each other

	if table.getn(bar)>0 then
		item = getglobal("ItemRackInv"..bar[1])
		item:ClearAllPoints()
		item:SetPoint(cornerStart,"ItemRack_InvFrame",cornerStart,xdirStart,ydirStart)
		getglobal("ItemRackInv"..bar[1].."Icon"):SetTexture(get_item_info(bar[1]))
		item:Show()
		if ItemRack_Settings.RightClick=="ON" and (bar[1]==13 and bar[2]==14) then
			ItemRack.TrinketsPaired = true
		end
		for i=2,table.getn(bar) do
			xspacer,yspacer = 0,0
			if ItemRack_Settings.RightClick=="ON" and ((bar[i]==13 and bar[i+1] and bar[i+1]==14) or 
				(bar[i-1]==14 and bar[i-2] and bar[i-2]==13)) then
				ItemRack.TrinketsPaired = true
			end
			if ItemRack_Users[user].Spaces[bar[i-1]] then
				xspacer = xdir*2
				yspacer = ydir*2
			end
			item = getglobal("ItemRackInv"..bar[i])
			item:ClearAllPoints()
			item:SetPoint(cornerTo,"ItemRackInv"..bar[i-1],corner,xdir+xspacer,ydir+yspacer)
			getglobal("ItemRackInv"..bar[i].."Icon"):SetTexture(get_item_info(bar[i]))
			item:Show()
			cx = cx + math.abs(xadd) + math.abs(xspacer)
			cy = cy + math.abs(yadd) + math.abs(yspacer) -- was minus yspacer
		end
		ItemRack_InvFrame:SetWidth(cx)
		ItemRack_InvFrame:SetHeight(cy)

		if ItemRack_Settings.FlipBar=="ON" and oldcx>32 and oldcy>32 then
			-- if bar size changed (after being drawn before), and we're flipped, we need to shift it over
			ItemRack_InvFrame:ClearAllPoints()
			if ItemRack_Users[user].MainOrient=="HORIZONTAL" then
				oldx = oldx + (oldcx-cx)
			else
				oldy = oldy + (cy-oldcy)
			end
			really_setpoint(ItemRack_InvFrame,"TOPLEFT","UIParent","BOTTOMLEFT",oldx,oldy)
		end

		if ItemRack_Users[user].Visible~="OFF" then
			ItemRack_InvFrame:Show()
		end
		cooldowns_need_updating()
		Rack.StartTimer("CooldownUpdate",0)

		if ItemRack_Settings.SetLabels=="ON" then
			local currentset = Rack.CurrentSet()
			if currentset and Rack_User[user].Sets[currentset] then
				ItemRackInv20Name:SetText(currentset)
			else
				ItemRackInv20Name:SetText(ItemRackText.EMPTYSET)
			end
		else
			ItemRackInv20Name:SetText("")
		end
	else
		ItemRack_Users[user].Visible="OFF"
		ItemRack_InvFrame:Hide()
	end
	draw_minimap_icon()

	if ItemRack_UpdatePlugins then
		-- update plugin if it exists
		local setname = Rack.CurrentSet()
		if setname and ItemRack_Users[user].Sets[setname] then
			ItemRack_UpdatePlugins(setname,ItemRack_Users[user].Sets[setname].icon)
		else
			ItemRack_UpdatePlugins(nil,"Interface\\AddOns\\ItemRack\\ItemRack-Icon")
		end
	end

end

local function unlocked()
	return ItemRack_Users[user].Locked~="ON"
end

-- sets window lock "ON" or "OFF"
local function set_lock(arg1)

	ItemRack_Users[user].Locked = arg1

	if arg1=="ON" then
		ItemRack_InvFrame:SetBackdropColor(0,0,0,0)
		ItemRack_InvFrame:SetBackdropBorderColor(0,0,0,0)
		ItemRack_InvFrame_Resize:Hide()
		ItemRack_Control_Rotate:SetAlpha(.4)
		ItemRack_Control_Rotate:Disable()
	else
		ItemRack_InvFrame:SetBackdropColor(1,1,1,1)
		ItemRack_InvFrame:SetBackdropBorderColor(1,1,1,1)
		ItemRack_InvFrame_Resize:Show()
		ItemRack_Control_Rotate:SetAlpha(1)
		ItemRack_Control_Rotate:Enable()
		ItemRack_ControlFrame:Show()
		Rack.StartTimer("ControlFrame")
	end
end

-- called at startup, UPDATE_BINDINGS and option change to show/hide key bindings
local function update_keybindings()

	local i,modifier,key,text

	-- update bindings for inventory slots
	for i=0,19 do
		if ItemRack.Indexes[i].keybind and ItemRack_Settings.Bindings=="ON" then
			text = GetBindingKey(ItemRack.Indexes[i].keybind)
			_,_,modifier,key = string.find(text or "","(.).+(-.)")
			if modifier and key then
				text = modifier..key
			end
			getglobal("ItemRackInv"..i.."HotKey"):SetText(text)
		else
			getglobal("ItemRackInv"..i.."HotKey"):SetText("")
		end
	end

	-- update bindings for items on the rack
	ItemRack_AgreeOnKeyBindings()

end

local function move_control()

	local item = ItemRack_InvFrame

	ItemRack_Control_Rotate:ClearAllPoints()
	ItemRack_Control_Lock:ClearAllPoints()
	ItemRack_Control_Options:ClearAllPoints()

	if ItemRack_Users[user].MainOrient=="HORIZONTAL" then
		
		if ItemRack_Settings.FlipBar=="OFF" then
			ItemRack_Control_Rotate:SetPoint("TOPLEFT","ItemRack_InvFrame","TOPRIGHT",-2,-3)
		else
			ItemRack_Control_Rotate:SetPoint("TOPRIGHT","ItemRack_InvFrame","TOPLEFT",2,-3)
		end
		ItemRack_Control_Lock:SetPoint("TOPLEFT","ItemRack_Control_Rotate","BOTTOMLEFT")
		ItemRack_Control_Options:SetPoint("TOPLEFT","ItemRack_Control_Lock","BOTTOMLEFT")
	else
		if ItemRack_Settings.FlipBar=="OFF" then
			ItemRack_Control_Rotate:SetPoint("BOTTOMLEFT","ItemRack_InvFrame","TOPLEFT",3,-2)
		else
			ItemRack_Control_Rotate:SetPoint("TOPLEFT","ItemRack_InvFrame","BOTTOMLEFT",3,2)
		end
		ItemRack_Control_Lock:SetPoint("TOPLEFT","ItemRack_Control_Rotate","TOPRIGHT")
		ItemRack_Control_Options:SetPoint("TOPLEFT","ItemRack_Control_Lock","TOPRIGHT")
	end
end

-- moves the minimap icon to last position in settings or default angle of 45
local function move_icon()

	local xpos,ypos
	local angle = ItemRack_Settings.IconPos or 0

	if ItemRack_Settings.SquareMinimap=="ON" then
		-- brute force method until trig solution figured out - min/max a point on a circle beyond square
		xpos = 110 * cos(angle)
		ypos = 110 * sin(angle)
		xpos = math.max(-82,math.min(xpos,84))
		ypos = math.max(-86,math.min(ypos,82))
	else
		xpos = 80*cos(angle)
		ypos = 80*sin(angle)
	end

	ItemRack_IconFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-xpos,ypos-52)

end

local function initialize_data()

	-- if EquipSet isn't defined by some other mod, use it as an alias for ItemRack_EquipSet, since macros are limited by space
	EquipSet = EquipSet or ItemRack_EquipSet -- ItemRack_EquipSet
	SaveSet = SaveSet or ItemRack_SaveSet
	LoadSet = LoadSet or ItemRack_LoadSet
	ToggleSet = ToggleSet or ItemRack_ToggleSet
	IsSetEquipped = IsSetEquipped or ItemRack_IsSetEquipped

	-- create new user if one doesn't exist
	if not ItemRack_Users[user] then
		ItemRack_Users[user] = {} -- create new per-user setting
		ItemRack_Users[user].Inv = {} -- nil or 1, whether inv slot visible
		ItemRack_Users[user].Bar = {} -- 1-number of inventory bars on screen at once
		ItemRack_Users[user].Spaces = {} -- nil or true, whether a space should appear after this slot
		ItemRack_Users[user].Ignore = {} -- list of items to ignore on bar
		for i in ItemRackOpt_Defaults do
			ItemRack_Users[user][i] = ItemRackOpt_Defaults[i]
		end
	end
	-- upgrade old version data
	ItemRack_Settings.ShowEmpty = ItemRack_Settings.ShowEmpty or "OFF" -- 1.1
	ItemRack_Settings.FlipMenu = ItemRack_Settings.FlipMenu or "OFF" -- 1.1
	ItemRack_Settings.RightClick = ItemRack_Settings.RightClick or "OFF" -- 1.1
	ItemRack_Settings.TinyTooltip = ItemRack_Settings.TinyTooltip or "OFF" -- 1.2
	ItemRack_Settings.ShowTooltips = ItemRack_Settings.ShowTooltips or "ON" -- 1.2
	ItemRack_Settings.RotateMenu = ItemRack_Settings.RotateMenu or "OFF" -- 1.3
	ItemRack_Users[user].Spaces = ItemRack_Users[user].Spaces or {} -- 1.3
	ItemRack_Users[user].Sets = ItemRack_Users[user].Sets or {} -- 1.4
	ItemRack_Settings.ShowIcon = ItemRack_Settings.ShowIcon or "ON" -- 1.4
	ItemRack_Settings.DisableToggle = ItemRack_Settings.DisableToggle or "ON" -- 1.4
	ItemRack_Settings.FlipBar = ItemRack_Settings.FlipBar or "OFF" -- 1.5
	ItemRack_Users[user].Ignore = ItemRack_Users[user].Ignore or {} -- 1.5
	ItemRack_Settings.EnableEvents = ItemRack_Settings.EnableEvents or "OFF" -- 1.5
	ItemRack_Users[user].Events = ItemRack_Users[user].Events or {} -- 1.7
	ItemRack_Settings.CompactList = ItemRack_Settings.CompactList or "OFF" -- 1.7
	ItemRack_Settings.NotifyThirty = ItemRack_Settings.NotifyThirty or "OFF" -- 1.7
	ItemRack_Settings.ShowAllEvents = ItemRack_Settings.ShowAllEvents or "OFF" -- 1.7
	ItemRack_Settings.AllowHidden = ItemRack_Settings.AllowHidden or "OFF" -- 1.82
	ItemRack_Settings.LargeFont = ItemRack_Settings.LargeFont or "OFF" -- 1.9
	ItemRack_Settings.SquareMinimap = ItemRack_Settings.SquareMinimap or "OFF" -- 1.9
	ItemRack_Settings.BigCooldown = ItemRack_Settings.BigCooldown or "OFF" -- 1.9
	ItemRack_Settings.SetLabels = ItemRack_Settings.SetLabels or "ON" -- 1.91
	ItemRack_Settings.AutoToggle = ItemRack_Settings.AutoToggle or "OFF" -- 1.91

	local _,class = UnitClass("player")
	if class=="WARRIOR" or class=="ROGUE" or class=="HUNTER" then
		ItemRack.CanWearOneHandOffHand = 1
	end
end

local function initialize_display()

	-- set scale and position to last saved setting
	ItemRack_InvFrame:SetScale(ItemRack_Users[user].MainScale or 1)
	ItemRack_MenuFrame:SetScale(ItemRack_Users[user].MainScale or 1)
	ItemRack_InvFrame:ClearAllPoints()
	really_setpoint(ItemRack_InvFrame,"TOPLEFT","UIParent","BOTTOMLEFT",ItemRack_Users[user].XPos,ItemRack_Users[user].YPos)
	set_lock(ItemRack_Users[user].Locked)
	update_keybindings()

	ItemRackInv0Count:SetText(CharacterAmmoSlotCount:IsShown() and CharacterAmmoSlotCount:GetText() or "")

	for i in ItemRack.OptInfo do
		if ItemRack.OptInfo[i].type=="Check" and getglobal(i) then
			item = getglobal(i.."Text")
			item:SetText(ItemRack.OptInfo[i].text)
			item:SetTextColor(1,1,1)
			if ItemRack.OptInfo[i].info and ItemRack_Settings[ItemRack.OptInfo[i].info]=="ON" then
				getglobal(i):SetChecked(1)
			else
				getglobal(i):SetChecked(0)
			end
		end
		if ItemRack.OptInfo[i].type=="Label" then
			getglobal(i):SetText(ItemRack.OptInfo[i].text)
		end
	end

	if ItemRack_Users[user].Visible=="OFF" then
		ItemRack_InvFrame:Hide()
	end

	move_control() -- docks control buttons on edge of bar
	move_icon() -- moves minimap button

	if ItemRack_Settings.ShowIcon=="OFF" then
		ItemRack_IconFrame:Hide()
	else
		ItemRack_IconFrame:Show()
	end

	make_escable("ItemRack_SetsFrame","add")

	ItemRack_ChangeEventFont()

	for i=1,30 do
		getglobal("ItemRackMenu"..i.."Border"):SetVertexColor(.15,.25,1,1)
		getglobal("ItemRackMenu"..i.."Border"):Hide()
	end

	draw_inv() -- construct the bar
	ItemRack_SetAllCooldownFonts()
	Rack.StartTimer("CooldownUpdate")
end

-- returns true if no swaps are pending
local function all_items_unlocked()

	local i,j,bagged_item_locked,locked
	local bagStart,bagEnd = 0,4

	for i=0,19 do
		locked = locked or IsInventoryItemLocked(i)
	end

	for i=bagStart,bagEnd do
		for j=1,GetContainerNumSlots(i) do
			_,_,bagged_item_locked = GetContainerItemInfo(i,j)
			locked = locked or bagged_item_locked
		end
	end

	return not locked
end

-- displays a quick tooltip note under the sets window
local function sets_message(msg)

	local tooltip = ItemRack_Sets_Message

	tooltip:SetOwner(ItemRack_SetsFrame, "ANCHOR_NONE")
	tooltip:SetPoint("TOP", "ItemRack_SetsFrame", "BOTTOM", 0, 0)
	tooltip:AddLine(msg)
	tooltip:Show()
	tooltip:FadeOut()
end


--[[ Frame functions ]]--

function ItemRack_OnLoad()

	-- hook for ALT+click of inventory slots (to add inventory slots to rack)
	oldItemRack_PaperDollItemSlotButton_OnClick = PaperDollItemSlotButton_OnClick
	PaperDollItemSlotButton_OnClick = newItemRack_PaperDollItemSlotButton_OnClick

	-- hook for ALT+click of character model (to add set slot to rack)
	oldItemRack_CharacterModelFrame_OnMouseUp = CharacterModelFrame_OnMouseUp
	CharacterModelFrame_OnMouseUp = newItemRack_CharacterModelFrame_OnMouseUp

	-- hook for mouseover of character sheet item slots (to display menu)
	oldItemRack_PaperDollItemSlotButton_OnEnter = PaperDollItemSlotButton_OnEnter
	PaperDollItemSlotButton_OnEnter = newItemRack_PaperDollItemSlotButton_OnEnter

	-- hook for character sheet hiding (to hide menu)
	oldItemRack_PaperDollFrame_OnHide = PaperDollFrame_OnHide
	PaperDollFrame_OnHide = newItemRack_PaperDollFrame_OnHide

	oldItemRack_UseInventoryItem = UseInventoryItem
	UseInventoryItem = newItemRack_UseInventoryItem

	oldItemRack_UseAction = UseAction
	UseAction = newItemRack_UseAction

	this:RegisterEvent("PLAYER_LOGIN")
end

local function initialize_events(v1)

	local i,j

	ItemRack_DisableAllEvents()

	if v1 then
		ItemRack_Events = {}
		-- go through and remove all old items from sets
		for i in Rack_User do
			if Rack_User[i].Sets then
				for j in Rack_User[i].Sets do
					for k=0,19 do
						if Rack_User[i].Sets[j][k] then
							Rack_User[i].Sets[j][k].old = nil
						end
					end
				end
			end
		end
	end

	-- if the events doesn't have a version or it's an old events version, load defaults
	if not tonumber(ItemRack_Events.events_version) or ItemRack_Events.events_version<current_events_version then
		ItemRack_Events.events_version = current_events_version
		for i in ItemRack_DefaultEvents do
			ItemRack_Events[i] = {}
			ItemRack_Events[i].trigger = ItemRack_DefaultEvents[i].trigger
			ItemRack_Events[i].delay = ItemRack_DefaultEvents[i].delay
			ItemRack_Events[i].script = ItemRack_DefaultEvents[i].script
		end
	end

	-- if an event is removed, remove the associated sets from the user
	for i in ItemRack_Users do
		if ItemRack_Users[i].Events then
			for j in ItemRack_Users[i].Events do
				if not ItemRack_Events[j] then
					ItemRack_Users[i].Events[j] = nil
				end
			end
		end
	end

	if TITAN_RIDER_ID and (not TitanRider_EquipToggle or (TitanGetVar and TitanGetVar(TITAN_RIDER_ID,"EquipItems"))) then
		if ItemRack_Users[user].Events["Mount"] and ItemRack_Users[user].Events["Mount"].enabled then
			ItemRack_Users[user].Events["Mount"] = nil
		end
	end

	ItemRack_Events_ScrollFrameScrollBar:SetValue(0)
	ItemRack_Build_eventList()
	ItemRack_EnableAllEvents()
end

function ItemRack_OnEvent(event)

	if event=="UNIT_INVENTORY_CHANGED" then
		if arg1=="player" then
			Rack.StartTimer("InvUpdate")
		end
	elseif event=="PLAYER_AURAS_CHANGED" then
		ItemRack_BuffsChanged()

	elseif event=="UPDATE_BINDINGS" then
		update_keybindings()

	elseif event=="BANKFRAME_OPENED" then
		Rack.BankOpened()

	elseif event=="BANKFRAME_CLOSED" then
		Rack.BankClosed()

	elseif event=="BAG_UPDATE" then -- only enabled when bank is open
		Rack.PopulateBank()
		if ItemRack_MenuFrame:IsVisible() and ItemRack.InvOpen then
			ItemRack_BuildMenu(ItemRack.InvOpen,ItemRack.MenuDockedTo)
			if ItemRack.InvOpen==20 then
				local id = GetMouseFocus() and GetMouseFocus():GetID() or ""
				local menuItem = ItemRack.BaggedItems[id or ""]
				if menuItem and menuItem.name and Rack_User[user].Sets[menuItem.name] then
					ItemRack_Sets_Tooltip(menuItem.name,1)
				end
			end
		end

	elseif event=="PLAYER_LOGIN" then

		user = UnitName("player").." of "..GetRealmName()

		SlashCmdList["ItemRackCOMMAND"] = ItemRack_SlashHandler
		SLASH_ItemRackCOMMAND1 = "/itemrack"

		Rack.Initialize()

		initialize_data()
		initialize_events()

		ItemRack_InitializeKeyBindings() -- create key bindings for this user
		initialize_display()

		this:RegisterEvent("UNIT_INVENTORY_CHANGED")
		this:RegisterEvent("UPDATE_BINDINGS")

		RackFrame:RegisterEvent("PLAYER_REGEN_ENABLED") -- leaving combat
		RackFrame:RegisterEvent("PLAYER_UNGHOST") -- leaving ghost
		RackFrame:RegisterEvent("PLAYER_ALIVE") -- leaving death

		this:RegisterEvent("BANKFRAME_OPENED")
		this:RegisterEvent("BANKFRAME_CLOSED")

		if not ItemRack_Settings.Minimap then
			ItemRack_Settings.Minimap = {}
		end
	end
end

function ItemRack_SlashHandler(arg1)

	if arg1 and string.find(arg1,"equip") then
		local _,_,set = string.find(arg1,"equip (.+)")
		if not set then
			DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00Usage: /itemrack equip (set name)")
			DEFAULT_CHAT_FRAME:AddMessage("ie, /itemrack equip pvp gear")
		else
			ItemRack_EquipSet(set)
		end
		return
	elseif arg1 and string.find(arg1,"toggle") then
		local _,_,set = string.find(arg1,"toggle (.+)")
		if not set then
			DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00Usage: /itemrack toggle (set name)")
			DEFAULT_CHAT_FRAME:AddMessage("ie, /itemrack toggle pvp gear")
		else
			ItemRack_ToggleSet(set)
		end
		return
	end

	arg1 = string.lower(arg1)

	if not string.find(arg1,".+") then
		ItemRack_Toggle()
	elseif arg1=="reset everything" then
		StaticPopupDialogs["ITEMRACKRESET"] = {
			text = "Are you sure you want to wipe all ItemRack sets, events and settings?\nThis will restore to default and then Reload the UI.",
			button1 = "Yes", button2 = "No", showAlert=1, timeout = 0, whileDead = 1,
			OnAccept = function() ItemRack_Users=nil ItemRack_Events=nil ItemRack_Settings=nil Rack_User=nil ReloadUI() end,
		}
		StaticPopup_Show("ITEMRACKRESET")
	elseif string.find(arg1,"^reset") then
		if string.find(arg1,"reset event") then
			-- /itemrack reset event will initialize events
			initialize_events("reset")
			ItemRack_Events_ScrollFrameScrollBar:SetValue(0)
			if ItemRack_SetsFrame:IsVisible() then
				sets_message("Default events reset.")
			end
		else
			-- /itemrack reset will reset the bar
			ItemRack_Reset()
		end
	elseif arg1=="lock" then
		set_lock("ON")
	elseif arg1=="unlock" then
		set_lock("OFF")
	elseif string.find(arg1,"scale") then
		local _,_,newscale = string.find(arg1,"scale (.+)")
		if not tonumber(newscale) then
			DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00Usage: /itemrack scale (number)")
			DEFAULT_CHAT_FRAME:AddMessage("ie, /itemrack scale 0.85")
		else
			ItemRack.FrameToScale = ItemRack_InvFrame
			ItemRack_ScaleFrame(newscale)
			ItemRack_Users[user].MainScale = ItemRack_InvFrame:GetScale()
			cooldowns_need_updating()
		end
	elseif string.find(arg1,"^opt") then
		ItemRack_Sets_Toggle()
	elseif arg1=="debug" then
		ItemRack_ListEvents()
		DEFAULT_CHAT_FRAME:AddMessage("Events version: "..tostring(ItemRack_Events.events_version))
		DEFAULT_CHAT_FRAME:AddMessage("ItemRack version: "..tostring(ItemRack_Version))
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00ItemRack usage:")
		DEFAULT_CHAT_FRAME:AddMessage("/itemrack : toggle the window")
		DEFAULT_CHAT_FRAME:AddMessage("/itemrack reset : reset window")
		DEFAULT_CHAT_FRAME:AddMessage("/itemrack lock or unlock : toggles window lock")
		DEFAULT_CHAT_FRAME:AddMessage("/itemrack scale (number) : sets an exact scale")
		DEFAULT_CHAT_FRAME:AddMessage("/itemrack equip (set name) : equips a set")
		DEFAULT_CHAT_FRAME:AddMessage("/itemrack toggle (set name) : equips/unequips set")
		DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00Alt+click item slots in the character window to add/remove items.\nWhile locked, hold ALT over the window to access control buttons.")
	end
end

--[[ Main bar add/remove functions ]]--

function ItemRack_Reset()

	local i
	-- restore user settings to default (but keep bar contents)
	for i in ItemRackOpt_Defaults do
		ItemRack_Users[user][i] = ItemRackOpt_Defaults[i]
	end
	initialize_data()
	initialize_display()
	initialize_events()
	ItemRack_SetsFrame:ClearAllPoints()
	ItemRack_SetsFrame:SetPoint("CENTER","UIParent","CENTER")
end

local function remove_inv(id)

	local i

	getglobal("ItemRackInv"..id):Hide()
	ItemRack_Users[user].Inv[id] = nil
	for i=1,table.getn(ItemRack_Users[user].Bar) do
		if ItemRack_Users[user].Bar[i]==id then
			table.remove(ItemRack_Users[user].Bar,i)
		end
	end
	draw_inv()
end

--[[ Hooked functions ]]--

-- if action is currently equipped, then reflect its use to the mod
function newItemRack_UseAction(slot,checkCursor,onSelf)

	if IsEquippedAction(slot) and cursor_empty() then
		Rack_TooltipScan:SetAction(slot)
		local usedName = Rack_TooltipScanTextLeft1:GetText()

		local i,name,foundSlot

		-- look for a worn item with same name as clicked item
		for i=1,20 do
			Rack_TooltipScan:SetInventoryItem("player",i)
			name = Rack_TooltipScanTextLeft1:GetText()
			if name==usedName then
				foundSlot = i -- found this item in slot i
				i = 21 -- whimpy break
			end
		end

		if foundSlot and GetActionCooldown(slot)==0 then
			ItemRack_ReactUseInventoryItem(foundSlot)
		end

	end

	oldItemRack_UseAction(slot,checkCursor,onSelf)

end

-- Inv slots are added by ALT+clicking the paper doll
function newItemRack_PaperDollItemSlotButton_OnClick(button, ignoreShift)

	if IsAltKeyDown() then
		local item = string.gsub(tostring(this:GetName()),"Character","")
		local id,texture = GetInventorySlotInfo(item)

		if ItemRack_Users[user].Inv[id] then
			remove_inv(id)
		else
			ItemRack_Users[user].Visible="ON"
			ItemRack_Users[user].Inv[id] = 1
			getglobal("ItemRackInv"..id.."Icon"):SetTexture(texture)
			table.insert(ItemRack_Users[user].Bar,id)
			draw_inv()
		end
	else
		oldItemRack_PaperDollItemSlotButton_OnClick(button, ignoreShift)
	end
	
end

-- set slot is added by ALT+clicking the paper doll character model
function newItemRack_CharacterModelFrame_OnMouseUp(button)

	if IsAltKeyDown() then
		if ItemRack_Users[user].Inv[20] then
			remove_inv(20)
		else
			ItemRack_Users[user].Visible="ON"
			ItemRack_Users[user].Inv[20]=1
			table.insert(ItemRack_Users[user].Bar,20)
			draw_inv()
		end
	else
		oldItemRack_CharacterModelFrame_OnMouseUp(button)
	end

end

function newItemRack_PaperDollItemSlotButton_OnEnter()

	local id,i = this:GetName()

	oldItemRack_PaperDollItemSlotButton_OnEnter()

	if IsAltKeyDown() then
		for i=0,19 do
			if ItemRack.Indexes[i].paperdoll_slot==id then
				id = i
				i = 20 -- whimpy break
			end
		end

		if tonumber(id) and not InRepairMode() then
			ItemRack_BuildMenu(id,"CHARACTERSHEET")
		end
	end
end

function newItemRack_PaperDollFrame_OnHide()

	if ItemRack.MenuDockedTo=="CHARACTERSHEET" then
		ItemRack_MenuFrame:Hide()
	end

	oldItemRack_PaperDollFrame_OnHide()
end

--[[ Inv Movement ]]--

function ItemRack_InvFrame_OnMouseDown(arg1)

	if arg1=="LeftButton" and ItemRack_Users[user].Locked=="OFF" then
		this:StartMoving()
	end
end

function ItemRack_InvFrame_OnMouseUp(arg1)

	if arg1=="LeftButton" then
		this:StopMovingOrSizing()
		ItemRack_Users[user].XPos = ItemRack_InvFrame:GetLeft()
		ItemRack_Users[user].YPos = ItemRack_InvFrame:GetTop()
		cooldowns_need_updating()
	end
end

function ItemRack_Toggle()
	if ItemRack_InvFrame:IsVisible() then
		ItemRack_Users[user].Visible="OFF"
		ItemRack_InvFrame:Hide()
	else
		ItemRack_Users[user].Visible="ON"
		ItemRack_InvFrame:Show()
	end
end

--[[ Inventory changes ]]--

-- any inventory changes will cause this OnUpdate to start counting.  After InvUpdateLimit, it processes the inventory change
function ItemRack_InvUpdate_OnUpdate()

	if SpellIsTargeting() then
		-- if we're in disenchant/enchant/applying poison/sharpening stone/etc, check back later. do nothing for now
		Rack.StartTimer("InvUpdate",1)
	else

		local i,j
		local bagStart,bagEnd = 0,4

		Rack.StopTimer("InvUpdate")
		ItemRack.Swapping = false

		draw_inv()

		if ItemRack_Users[user].Inv[0] then
			-- update ammo count
			ItemRackInv0Count:SetText(CharacterAmmoSlotCount:IsShown() and CharacterAmmoSlotCount:GetText() or "")
		end

		if table.getn(ItemRack_Users[user].Bar)>0 then
			for i=1,table.getn(ItemRack_Users[user].Bar) do
				getglobal("ItemRackInv"..ItemRack_Users[user].Bar[i]):SetChecked(0)
				SetDesaturation(getglobal("ItemRackInv"..ItemRack_Users[user].Bar[i].."Icon"),nil)
			end
		end

		-- if set builder is up, change the inventory to reflect the change
		if ItemRack_SetsFrame:IsVisible() then
			for i=0,19 do
				SetDesaturation(getglobal("ItemRack_Sets_Inv"..i.."Icon"),nil)
			end
			ItemRack_Sets_UpdateInventory()
		end

		if ItemRack.InvOpen then
			if ItemRack_Settings.RightClick=="ON" and ItemRack.InvOpen==13 then
				ItemRack.InvOpen = 14
			end
			ItemRack_BuildMenu(ItemRack.InvOpen)
		end

	end
end

--[[ Scaling ]]--

function ItemRack_StartScaling(arg1)
	if arg1=="LeftButton" and unlocked() then
		this:LockHighlight()
		ItemRack.FrameToScale = this:GetParent()
		ItemRack.ScalingWidth = this:GetParent():GetWidth()
		ItemRack_MenuFrame:Hide()
		Rack.StartTimer("ScaleUpdate")
	end
end

function ItemRack_StopScaling(arg1)
	if arg1=="LeftButton" then
		Rack.StopTimer("ScaleUpdate")
		ItemRack.FrameToScale = nil
		cooldowns_need_updating()
		this:UnlockHighlight()
		if this:GetParent():GetName() == "ItemRack_InvFrame" then
			ItemRack_Users[user].MainScale = ItemRack_InvFrame:GetScale()
		end
	end
end

function ItemRack_ScaleFrame(scale)
	local frame = ItemRack.FrameToScale
	local oldscale = frame:GetScale() or 1
	local framex = (frame:GetLeft() or ItemRack_Users[user].XPos)* oldscale
	local framey = (frame:GetTop() or ItemRack_Users[user].YPos)* oldscale

	frame:SetScale(scale)
	really_setpoint(ItemRack_InvFrame,"TOPLEFT","UIParent","BOTTOMLEFT",framex/scale,framey/scale)
end

--[[ Clicks ]]--

-- uses inventory slot v1 (0-19) can be called from key binding and slot doesn't need to be on the bar
function ItemRack_UseItem(v1)

	if SpellIsTargeting() and v1~=0 then -- if poison or sharpening stone being applied (and not an ammo slot)
		PickupInventoryItem(v1)
	elseif v1 and not MerchantFrame:IsVisible() then
		UseInventoryItem(v1)
	end
end

function ItemRack_ReactUseInventoryItem(slot)

	if ItemRack_Users[user].Inv[slot] then
		getglobal("ItemRackInv"..slot):SetChecked(1)
	end
	Rack.StartTimer("InvUpdate",1.5) -- extra long wait

	_,_,item = string.find(GetInventoryItemLink("player",slot) or "","^.*%[(.*)%].*$")
	if ItemRack_Settings.Notify=="ON" and item then
		ItemRack.NotifyList[item] = { bag=nil, slot=nil, inv=slot }
	end
	if ItemRack_Settings.EnableEvents and item then
		local holdarg1,holdarg2 = arg1,arg2
		arg1 = item
		arg2 = slot
		ItemRack_RegisterFrame_OnEvent("ITEMRACK_ITEMUSED")
		arg1 = holdarg1
		arg2 = holdarg2
	end
end

-- hook for UseInventoryItem
function newItemRack_UseInventoryItem(slot)
	local cooldown = GetInventoryItemCooldown("player",slot)
	oldItemRack_UseInventoryItem(slot) -- call original UseInventoryItem
	if cooldown==0 then
		ItemRack_ReactUseInventoryItem(slot) -- tell the mod an item was used
	end
end

function ItemRack_Inv_OnClick(arg1)

	local id = this:GetID()

	this:SetChecked(0)

	if id==20 and not IsAltKeyDown() then
		if arg1=="RightButton" then
			ItemRack_Sets_Toggle(2)
		else
			local setname = Rack.CurrentSet()
			if setname and Rack_User[user].Sets[setname] then
				if IsShiftKeyDown() then
					Rack.UnequipSet(setname)
				else
					ItemRack_EquipSet(setname)
				end
			end
		end
	elseif arg1=="RightButton" and IsAltKeyDown() and ItemRack_Users[user].Locked=="OFF" then
		-- toggle space after item
		ItemRack_Users[user].Spaces[id] = not ItemRack_Users[user].Spaces[id]
		draw_inv()
	elseif arg1=="LeftButton" and IsAltKeyDown() and ItemRack_Users[user].Locked=="OFF" then
		-- if Alt is down, remove the item from the bar
		if ItemRack_Users[user].Inv[id] then
			remove_inv(id)
			ItemRack_MenuFrame:Hide()
		end
	elseif arg1=="LeftButton" and IsShiftKeyDown() and ChatFrameEditBox:IsVisible() then
		-- if Shift is down, link the item to chat
		ChatFrameEditBox:Insert(GetInventoryItemLink("player",id))
	else
		-- otherwise use the item
		ItemRack_UseItem(id)
	end
end

--[[ Menu ]]--

function ItemRack_Inv_OnEnter()
	local id = this:GetID()

	ItemRack_Inv_Tooltip()

	ItemRack.MenuDockedTo = nil
	if not Rack.TimerEnabled("ScaleUpdate") then
		if IsShiftKeyDown() or ItemRack_Settings.MenuShift=="OFF" then
			if ItemRack_Settings.RightClick=="ON" and (id==13 or id==14) and ItemRack.TrinketsPaired then
				if ItemRack_Users[user].MainOrient=="HORIZONTAL" and corner_info("LEFTRIGHT")=="LEFT" then
					id = 13
				elseif ItemRack_Users[user].MainOrient=="HORIZONTAL" and corner_info("LEFTRIGHT")=="RIGHT" then
					id = 14
				elseif ItemRack_Users[user].MainOrient=="VERTICAL" and corner_info("TOPBOTTOM")=="TOP" then
					id = 13
				else
					id = 14
				end
			end
			ItemRack_BuildMenu(id)
		end
		if IsAltKeyDown() then
			ItemRack_ControlFrame:Show()
			Rack.StartTimer("ControlFrame")
		end
	end
end

function ItemRack_Menu_OnClick(arg1)

	local id,i,unqueue = this:GetID()
	local name = ItemRack.BaggedItems[id].name

	this:SetChecked(0)

	if SpellIsTargeting() or CursorHasItem() then return end -- prohibit swaps while in spell target/disenchant mode

	if ItemRack.BankIsOpen then
		if ItemRack.InvOpen~=20 then
			Rack.ClearLockList()
			local bag,slot
			if ItemRack.BankedItems[name] then
				bag,slot = Rack.FindSpace()
				if bag then
					PickupContainerItem(ItemRack.BaggedItems[id].bag,ItemRack.BaggedItems[id].slot)
					PickupContainerItem(bag,slot)
				else
					Rack.NoMoreRoom()
				end
			else
				bag,slot = Rack.FindSpace(1)
				if bag then
					PickupContainerItem(ItemRack.BaggedItems[id].bag,ItemRack.BaggedItems[id].slot)
					PickupContainerItem(bag,slot)
				else
					Rack.NoMoreRoom()
				end
				-- *** swap from bag to bank
			end
		else
			if Rack.SetHasBanked(name) then
				Rack.PullSetFromBank(name)
			else
				Rack.PushSetToBank(name)
			end
		end
		return
	end

	if ItemRack_Settings.RightClick=="ON" and arg1=="LeftButton" and ItemRack.InvOpen==14 then
		ItemRack.InvOpen = 13
	elseif ItemRack_Settings.RightClick=="ON" and arg1=="RightButton" and ItemRack.InvOpen==13 then
		ItemRack.InvOpen = 14
	end

	if (ItemRack_Settings.AllowHidden=="ON" or ItemRack.InvOpen==20) and IsAltKeyDown() and ItemRack.MenuDockedTo~="CHARACTERSHEET" then

		if ItemRack.InvOpen==20 then
			-- sets ignore flag is with the set
			if Rack_User[user].Sets[name].hide then
				Rack_User[user].Sets[name].hide = nil
			else
				Rack_User[user].Sets[name].hide = 1
			end
		elseif not ItemRack.BaggedItems[id].bag then
			-- empty slot, do nothing
		elseif ItemRack_Users[user].Ignore[ItemRack.BaggedItems[id].name] then
			ItemRack_Users[user].Ignore[ItemRack.BaggedItems[id].name] = nil
		else
			ItemRack_Users[user].Ignore[ItemRack.BaggedItems[id].name] = 1
		end
		ItemRack_BuildMenu(ItemRack.InvOpen,ItemRack.MenuDockedTo)

	elseif arg1=="LeftButton" and IsShiftKeyDown() and ChatFrameEditBox:IsVisible() then
		-- if linking a menu item with shift+left click
		ChatFrameEditBox:Insert(GetContainerItemLink(ItemRack.BaggedItems[id].bag,ItemRack.BaggedItems[id].slot))

	elseif ItemRack.InvOpen==20 then
		-- if selecting a set menu item
		if ItemRack.BaggedItems[id].name then
			if (not UnitAffectingCombat("player") and not Rack.IsPlayerReallyDead()) and (IsShiftKeyDown() or ItemRack_Settings.AutoToggle=="ON") then
				-- toggle set if shift key is down or AutoToggle on
				ItemRack_ToggleSet(ItemRack.BaggedItems[id].name)
			else -- otherwise equip it
				ItemRack_EquipSet(ItemRack.BaggedItems[id].name)
			end
			ItemRack_MenuFrame:Hide()
			Rack.StartTimer("InvUpdate",1) -- extra long wait, force an update, set may not swap
		end

	elseif (UnitAffectingCombat("player") and not ItemRack.Indexes[ItemRack.InvOpen].swappable) or Rack.IsPlayerReallyDead() then
		-- if selecting a menu item while dead
		if ItemRack.BaggedItems[id].name=="(empty)" then
			Rack.AddToCombatQueue(ItemRack.InvOpen,0)
		else
			local _,itemID = Rack.GetItemInfo(ItemRack.BaggedItems[id].bag,ItemRack.BaggedItems[id].slot)
			Rack.AddToCombatQueue(ItemRack.InvOpen,itemID)
		end
		ItemRack_MenuFrame:Hide()

	elseif ItemRack.InvOpen and cursor_empty() and not SpellIsTargeting() then
		-- if this is a normal swap of a single item out of combat and the cursor is free/not doing anything

		ItemRack.Swapping = true
		if ItemRack.BaggedItems[id].bag then
			-- find out if incoming item is two-hand or offhand that may leave a loose item in bags for later move
			local _,_,equipslot = get_item_info(ItemRack.BaggedItems[id].bag,ItemRack.BaggedItems[id].slot)
			if equipslot=="INVTYPE_2HWEAPON" then
				if GetInventoryItemLink("player",17) then
					-- something is in offhand slot, move it out
					Rack.ClearLockList()
					bag,slot = Rack.FindSpace()
					if not bag then
						UIErrorsFrame:AddMessage(ERR_INV_FULL,1,.1,.1,1,UIERRORS_HOLD_TIME)
					else
						PickupInventoryItem(17)
						PickupContainerItem(bag,slot)
					end
				end
			end
			PickupContainerItem(ItemRack.BaggedItems[id].bag,ItemRack.BaggedItems[id].slot)
			PickupInventoryItem(ItemRack.InvOpen)
		else
			local j,bag,slot
			-- swapping to an empty slot, create freespace
			Rack.ClearLockList()
			bag,slot = Rack.FindSpace()
			if not bag then
				UIErrorsFrame:AddMessage(ERR_INV_FULL,1,.1,.1,1,UIERRORS_HOLD_TIME)
			else
				PickupInventoryItem(ItemRack.InvOpen)
				PickupContainerItem(bag,slot)
			end
		end
		SetDesaturation(getglobal("ItemRackInv"..ItemRack.InvOpen.."Icon"),1)

		if ItemRack_SetsFrame:IsVisible() then
			SetDesaturation(getglobal("ItemRack_Sets_Inv"..ItemRack.InvOpen.."Icon"),1)
		end

		if not IsShiftKeyDown() or ItemRack_Settings.RightClick=="OFF" then
			ItemRack_MenuFrame:Hide()
		end
		Rack.StartTimer("InvUpdate",1.25)

	end
end

function ItemRack_MenuFrame_OnShow()
	Rack.StartTimer("MenuFrame")
end

function ItemRack_MenuFrame_OnHide()

	Rack.StopTimer("MenuFrame")
	local i
	for i=0,20 do
		getglobal("ItemRackInv"..i):UnlockHighlight()
	end
	ItemRack.InvOpen = nil
end

--[[ Tooltips ]]--

function ItemRack_Inv_Tooltip()

	local id = this:GetID()

	if Rack.TimerEnabled("ScaleUpdate") or ItemRack_Settings.ShowTooltips=="OFF" then
		return
	end

	if id==20 then
		-- if mouseover set on bar, display current set tooltip
		ItemRack_Sets_Tooltip(Rack.CurrentSet())
	else
		-- otherwise set up tooltip for an inventory item
		ItemRack.TooltipOwner = this
		ItemRack.TooltipType = "INVENTORY"
		ItemRack.TooltipSlot = id

		ItemRack.TooltipBag = Rack.GetNameByID(Rack.CombatQueue[id])

		Rack.StartTimer("TooltipUpdate",0)
	end
end

function ItemRack_Menu_Tooltip()

	local id = this:GetID()

	if Rack.TimerEnabled("ScaleUpdate") or ItemRack_Settings.ShowTooltips=="OFF" then
		return
	end

	if ItemRack.InvOpen==20 then
		-- if a sets menu, display set tooltip
		ItemRack_Sets_Tooltip(ItemRack.BaggedItems[id].name)

	elseif ItemRack.BaggedItems[id].bag then
		-- otherwise set up tooltip for a bagged item
		ItemRack.TooltipOwner = this
		ItemRack.TooltipType = "BAG"
		ItemRack.TooltipBag = ItemRack.BaggedItems[id].bag
		ItemRack.TooltipSlot = ItemRack.BaggedItems[id].slot

		Rack.StartTimer("TooltipUpdate",0)
	end
end

function ItemRack_ClearTooltip()

	GameTooltip:Hide()
	ItemRack.TooltipType = nil
	Rack.StopTimer("TooltipUpdate")
	if not ItemRack.InvOpen then
		ItemRack_MenuFrame_OnHide()
	end
end

local function set_tooltip_anchor(owner)

	if ItemRack.MenuDockedTo=="CHARACTERSHEET" and ItemRack.InvOpen then
		-- if this is a tooltip of an item docked to character sheet, anchor it to the paperdoll_slot
		GameTooltip:SetOwner(owner,"ANCHOR_RIGHT")
	elseif ItemRack_Settings.TooltipFollow=="ON" then
		if (owner:GetLeft() or 0)<400 then
			GameTooltip:SetOwner(owner,"ANCHOR_RIGHT")
		else
			GameTooltip:SetOwner(owner,"ANCHOR_LEFT")
		end
	else
		GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
	end
end

-- takes the currently-built tooltip and rebuilds with just name, durability and cooldown
local function shrink_tooltip()

	local nameline_line,durability_line,cooldown_line,tooltip_line,item_color

	name_line = GameTooltipTextLeft1:GetText()

	if name_line then

		for i=2,30 do
			tooltip_line = getglobal("GameTooltipTextLeft"..i):GetText() or ""
			if string.find(tooltip_line,durability_pattern) then
				durability_line = tooltip_line
			elseif string.find(tooltip_line,COOLDOWN_REMAINING) then
				cooldown_line = "|cFFFFFFFF"..tooltip_line
			end
		end

		if ItemRack.TooltipType=="BAG" then
			item_color = string.sub(GetContainerItemLink(ItemRack.TooltipBag,ItemRack.TooltipSlot) or "",1,10) or ""
		else
			item_color = string.sub(GetInventoryItemLink("player",ItemRack.TooltipSlot) or "",1,10) or ""
		end

		set_tooltip_anchor(ItemRack.TooltipOwner)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(item_color..name_line)
		GameTooltip:AddLine(durability_line)
		GameTooltip:AddLine(cooldown_line)
	end
end

--[[ Cooldowns ]]--

local function format_time(seconds)

	if seconds<60 then
		return math.floor(seconds+.5)..((ItemRack_Settings.BigCooldown=="ON") and "" or " s")
	else
		if seconds < 3600 then 
			return math.ceil((seconds/60)).." m"
		else
			return math.ceil((seconds/3600)).." h"
		end
	end

end

local function write_cooldown(where,start,duration)

	local cooldown = duration - (ItemRack.CurrentTime - start)

	if start==0 then
		where:SetText("")
	elseif cooldown<3 and not where:GetText() then
		-- this is a global cooldown. don't display it. not accurate but at least not annoying
	else
		where:SetText(format_time(cooldown))
	end
end

local function notify(v1)

	local text = string.format((ItemRack_Settings.NotifyThirty=="OFF") and ItemRackText.READY or ItemRackText.READYTHIRTY,v1 or "")

	if v1 then
		PlaySound("GnomeExploration")
		if SCT_Display then
			-- send via SCT if it exists
			SCT_Display(text,{r=.2,g=.7,b=.9})
		elseif SHOW_COMBAT_TEXT=="1" then
			CombatText_AddMessage(text, CombatText_StandardScroll, .2, .7, .9) -- or default UI's SCT
		else
			-- send vis UIErrorsFrame if SCT doesn't exit
			UIErrorsFrame:AddMessage(text,.2,.7,.9,1,UIERRORS_HOLD_TIME)
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cff33b2e5"..text)
		if ItemRack_Settings.EnableEvents then
			local holdarg1= arg1
			arg1 = v1
			ItemRack_RegisterFrame_OnEvent("ITEMRACK_NOTIFY")
			arg1 = holdarg1
		end
	end
end

-- populate ItemRack.NotifyList[v1] with the location of item named 'v1'
local function notify_find_item(v1)

	local found_inv,found_bag,found_slot = Rack.FindItem(nil,v1,"passive")

	if found_inv then
		ItemRack.NotifyList[v1].inv = found_inv
		ItemRack.NotifyList[v1].bag = nil
		ItemRack.NotifyList[v1].slot = nil
	elseif found_bag then
		ItemRack.NotifyList[v1].inv = nil
		ItemRack.NotifyList[v1].bag = found_bag
		ItemRack.NotifyList[v1].slot = found_slot
	else
		ItemRack.NotifyList[v1] = nil
	end
end

function ItemRack_CooldownUpdate_OnUpdate()

	if ItemRack.CooldownsNeedUpdating then
		ItemRack.CooldownsNeedUpdating = false
		update_inv_cooldowns()
	end

	if ItemRack_Settings.CooldownNumbers=="ON" then

		local i,start,duration
		ItemRack.CurrentTime = GetTime()

		if ItemRack_InvFrame:IsVisible() then
			for i=1,table.getn(ItemRack_Users[user].Bar) do
				start, duration = GetInventoryItemCooldown("player",ItemRack_Users[user].Bar[i])
				write_cooldown(getglobal("ItemRackInv"..ItemRack_Users[user].Bar[i].."Time"),start,duration)
			end
		end

		if ItemRack_MenuFrame:IsVisible() and ItemRack.InvOpen then
			for i=1,ItemRack.NumberOfItems do
				if ItemRack.BaggedItems[i].bag then
					start, duration = GetContainerItemCooldown(ItemRack.BaggedItems[i].bag,ItemRack.BaggedItems[i].slot)
					write_cooldown(getglobal("ItemRackMenu"..i.."Time"),start,duration)
				end
			end
		end

	end

	if ItemRack_Settings.Notify=="ON" then

		local i,name,start,duration,cooldown
		ItemRack.CurrentTime = GetTime()

		-- go down notify list and check up on each item used
		for i in ItemRack.NotifyList do
			if ItemRack.NotifyList[i].inv then
				_,_,name=string.find(GetInventoryItemLink("player",ItemRack.NotifyList[i].inv) or "","^.*%[(.*)%].*$")
			else
				_,_,name=string.find(GetContainerItemLink(ItemRack.NotifyList[i].bag,ItemRack.NotifyList[i].slot) or "","^.*%[(.*)%].*$")
			end
			if i ~= name then
				notify_find_item(i) -- item has moved, go find it!
			end

			if ItemRack.NotifyList[i] then -- if item still on person (wasn't banked)
				if ItemRack.NotifyList[i].inv then -- if it has an inventory spot
					start, duration = GetInventoryItemCooldown("player",ItemRack.NotifyList[i].inv)
				else -- otherwise it's in a bag
					start, duration = GetContainerItemCooldown(ItemRack.NotifyList[i].bag,ItemRack.NotifyList[i].slot)
				end
				cooldown = (start==0) and 0 or (duration - (ItemRack.CurrentTime - start))
					if cooldown>3 then
					ItemRack.NotifyList[i].hadcooldown = true
				end
					if ItemRack.NotifyList[i].hadcooldown and (cooldown==0 or (ItemRack_Settings.NotifyThirty=="ON" and cooldown<30)) then
					notify(i)
					ItemRack.NotifyList[i] = nil
				end
			end
		end
	end

end

function ItemRack_CooldownUpdate_OnHide()

	local i

	for i=0,19 do
		getglobal("ItemRackInv"..i.."Time"):SetText("")
	end
	for i=1,30 do
		getglobal("ItemRackMenu"..i.."Time"):SetText("")
	end
end

-- changes the cooldown number on button named "button" to big/small depending on .BigCooldown
function ItemRack_SetCooldownFont(button)

	local item = getglobal(button.."Time")

	if ItemRack_Settings.BigCooldown=="ON" then
		item:SetFont("Fonts\\FRIZQT__.TTF",16,"OUTLINE")
		item:SetTextColor(1,.82,0,1)
		item:ClearAllPoints()
		item:SetPoint("CENTER",button,"CENTER")
	else
		item:SetFont("Fonts\\ARIALN.TTF",14,"OUTLINE")
		item:SetTextColor(1,1,1,1)
		item:ClearAllPoints()
		item:SetPoint("BOTTOM",button,"BOTTOM")
	end
end

-- changes all cooldown fonts
function ItemRack_SetAllCooldownFonts()

	for i=0,20 do
		ItemRack_SetCooldownFont("ItemRackInv"..i)
	end
	for i=1,30 do
		ItemRack_SetCooldownFont("ItemRackMenu"..i)
	end
end

--[[ Options ]]--

function ItemRack_OnTooltip(v1,v2)

	if ItemRack_Settings.ShowTooltips=="ON" then
		set_tooltip_anchor(this)
		GameTooltip:AddLine(v1)
		GameTooltip:AddLine(v2,.8,.8,.8,1)
		GameTooltip:Show()
	end
end

function ItemRack_Opt_OnEnter()

	local id = this:GetName()

	if ItemRack.OptInfo[id] and not Rack.TimerEnabled("ScaleUpdate") then
		ItemRack_OnTooltip(ItemRack.OptInfo[id].text,ItemRack.OptInfo[id].tooltip)
	end
end

function ItemRack_Control_OnClick()

	local id = this:GetName()

	if id=="ItemRack_Control_Rotate" and ItemRack_Users[user].Locked=="OFF" then
		-- rotate the window
		ItemRack_Users[user].MainOrient = ItemRack_Users[user].MainOrient=="HORIZONTAL" and "VERTICAL" or "HORIZONTAL"
		ItemRack_MenuFrame:Hide()
		draw_inv()
		move_control()
	elseif id=="ItemRack_Control_Lock" or id=="ItemRack_Sets_Lock" then
		-- lock/unlock the window
		ItemRack_Users[user].Locked = ItemRack_Users[user].Locked=="ON" and "OFF" or "ON"
		set_lock(ItemRack_Users[user].Locked)
	elseif id=="ItemRack_Control_Options" then
		ItemRack_Sets_Toggle()
	end
end

function ItemRack_Opt_OnClick(overrideID)

	local id = overrideID or this:GetName()

	if ItemRack.OptInfo[id] and ItemRack.OptInfo[id].info then
		local info = ItemRack.OptInfo[id].info

		if this:GetChecked() then
			ItemRack_Settings[info] = "ON"
			PlaySound("igMainMenuOptionCheckBoxOn")
		else
			ItemRack_Settings[info] = "OFF"
			PlaySound("igMainMenuOptionCheckBoxOff")
		end

		if id=="ItemRack_Opt_Bindings" then
			update_keybindings()
		elseif id=="ItemRack_Opt_CooldownNumbers" then
			ItemRack_CooldownUpdate_OnHide()
			Rack.StartTimer("CooldownUpdate",0)
		elseif id=="ItemRack_Opt_RightClick" then
			draw_inv()
		elseif id=="ItemRack_Opt_ShowIcon" then
			if ItemRack_Settings[info]=="ON" then
				ItemRack_IconFrame:Show()
			else
				ItemRack_IconFrame:Hide()
			end
		elseif id=="ItemRack_Opt_FlipBar" then
			move_control()
			draw_inv()
		elseif id=="ItemRack_Opt_CompactList" then
			ItemRack_Sets_SavedScrollFrameScrollBar:SetValue(0)
			ItemRack_Sets_SavedScrollFrame_Update()
		elseif id=="ItemRack_Opt_EnableEvents" then
			sets_message((ItemRack_Settings.EnableEvents=="ON") and "Events enabled" or "Events disabled")
		elseif id=="ItemRack_Opt_DisableToggle" then
			draw_minimap_icon()
		elseif id=="ItemRack_Opt_ShowAllEvents" then
			ItemRack_Events_ScrollFrameScrollBar:SetValue(0)
			ItemRack_Build_eventList()
		elseif id=="ItemRack_Opt_LargeFont" then
			ItemRack_ChangeEventFont()
		elseif id=="ItemRack_Opt_SquareMinimap" then
			move_icon()
		elseif id=="ItemRack_Opt_BigCooldown" then
			ItemRack_SetAllCooldownFonts()
		elseif id=="ItemRack_Opt_SetLabels" then
			draw_inv()
		end
	end
end

function ItemRack_OptList_ScrollFrame_Update()

	local i, idx, item, optinfo, optscroll, opttext, optbutton
	local offset = FauxScrollFrame_GetOffset(ItemRack_OptList_ScrollFrame)

	FauxScrollFrame_Update(ItemRack_OptList_ScrollFrame, table.getn(ItemRack.OptScroll), 11, 19 )

	for i=1,11 do
		item = getglobal("ItemRackOptList"..i)
		idx = offset+i
		if idx<=table.getn(ItemRack.OptScroll) then
			optscroll = ItemRack.OptScroll[idx]
			optinfo = ItemRack.OptInfo[optscroll.idx]
			opttext = getglobal("ItemRackOptList"..i.."CheckButtonText")
			optbutton = getglobal("ItemRackOptList"..i.."CheckButton")
			opttext:SetText(optinfo.text)
			opttext:SetTextColor(1,1,1,1)
			optbutton:Enable()
			if optscroll.dependency then
				item:SetWidth(128)
				if ItemRack_Settings[ItemRack.OptInfo[optscroll.dependency].info]=="OFF" then
					opttext:SetTextColor(.5,.5,.5,1)
					optbutton:Disable()
				end
			else
				item:SetWidth(142)
			end
			if ItemRack_Settings[optinfo.info]=="ON" then
				optbutton:SetChecked(1)
			else
				optbutton:SetChecked(0)
			end
			item:Show()
		else
			item:Hide()
		end
	end

end

-- tooltip for scrolling options
function ItemRack_OptList_OnEnter()
	local idx = FauxScrollFrame_GetOffset(ItemRack_OptList_ScrollFrame) + this:GetParent():GetID()
	local optinfo = ItemRack.OptInfo[ItemRack.OptScroll[idx].idx]
	ItemRack_OnTooltip(optinfo.text,optinfo.tooltip)
end

-- onclick for scrolling options, gets name of option and sends to _Opt_OnClick to process
function ItemRack_OptList_OnClick()
	local idx = FauxScrollFrame_GetOffset(ItemRack_OptList_ScrollFrame) + this:GetParent():GetID()
	local optinfo = ItemRack.OptInfo[ItemRack.OptScroll[idx].idx]
	ItemRack_Opt_OnClick(ItemRack.OptScroll[idx].idx)
	ItemRack_OptList_ScrollFrame_Update()
end

-- sets the state of a checkbutton to nil, 0 or 1
function ItemRack_TriStateCheck_SetState(button,value)
	local label = getglobal(button:GetName().."Text")
	button.tristate = value
	if not value then
		button:SetCheckedTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
		button:SetChecked(1)
		label:SetTextColor(.5,.5,.5)
	elseif value==0 then
		button:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		button:SetChecked(0)
		label:SetTextColor(1,1,1)
	elseif value==1 then
		button:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		button:SetChecked(1)
		label:SetTextColor(1,1,1)
	end
end

-- rotates a checkbutton from indeterminate->unchecked->checked (for show helm/cloak)
function ItemRack_TriStateCheck_OnClick()
	if not this.tristate then
		ItemRack_TriStateCheck_SetState(this,0)
	elseif this.tristate==0 then
		ItemRack_TriStateCheck_SetState(this,1)
	elseif this.tristate==1 then
		ItemRack_TriStateCheck_SetState(this,nil)
	end
	ItemRack_TriStateCheck_Tooltip()
end

-- initializes tristate buttons to be indeterminate
function ItemRack_TriStateCheck_OnLoad()
	ItemRack_TriStateCheck_SetState(this,nil)
end

function ItemRack_TriStateCheck_Tooltip()
	local tristate_names = { ["nil"] = "Ignore", ["0"] = "Hide", ["1"] = "Show" }
	local which = (this==ItemRack_ShowHelm) and "Helm" or "Cloak"
	ItemRack_OnTooltip(which..": "..tristate_names[tostring(this.tristate)],"This determines if the "..string.lower(which).." is shown or hidden when equipped.")
end

--[[ Sets ]]--

ItemRack.SetBuild = {}

local function build_icon()

	local setname = ItemRack_Sets_Name:GetText()

	ItemRack_Sets_ChosenIcon:SetNormalTexture(ItemRack.SelectedIcon)
	ItemRack_Sets_ChosenIconName:SetText(setname)
	if Rack_User[user].Sets[setname] then
		local _,_,modifier,basekey = string.find(Rack_User[user].Sets[setname].key or "","(.).+(-.)")
		ItemRack_Sets_ChosenIconHotKey:SetText((modifier or "")..(basekey or ""))
	else
		ItemRack_Sets_ChosenIconHotKey:SetText("")
	end
end

-- initializes .SetIcons mostly, the list of icons for the set
function ItemRack_Sets_Initialize()

	local i

	ItemRack.SetIcons = {}

	for i=0,19 do
		-- add 20 spaces at start of list - this list is constructed once and only first 20 slots change
		table.insert(ItemRack.SetIcons,"")
	end

	for i=1,table.getn(ItemRackExtraIcons) do
		-- add ExtraIcons defined in ItemRackExtraIcons.lua
		table.insert(ItemRack.SetIcons,ItemRackExtraIcons[i])
	end
	for i=1,GetNumMacroIcons() do
		-- add the macro icons to choose from
		table.insert(ItemRack.SetIcons,GetMacroIconInfo(i))
	end

end

local function highlight_set_item(v1)

	if ItemRack.SetBuild[v1]==1 then
		getglobal("ItemRack_Sets_Inv"..v1.."Icon"):SetVertexColor(1,1,1,1)
		getglobal("ItemRack_Sets_Inv"..v1):SetAlpha(1)
		getglobal("ItemRack_Sets_Inv"..v1):LockHighlight()
	else
		getglobal("ItemRack_Sets_Inv"..v1.."Icon"):SetVertexColor(.4,.4,.4,1)
		getglobal("ItemRack_Sets_Inv"..v1):SetAlpha(.5)
		getglobal("ItemRack_Sets_Inv"..v1):UnlockHighlight()
	end
end

function ItemRack_Sets_UpdateInventory()

	local i,texture

	if not ItemRack.SetIcons then
		ItemRack_Sets_Initialize()
	end

	for i=0,19 do
		texture = GetInventoryItemTexture("player",i)
		if not texture then
			_,texture = GetInventorySlotInfo(string.gsub(ItemRack.Indexes[i].paperdoll_slot,"Character",""))
		end
		getglobal("ItemRack_Sets_Inv"..i.."Icon"):SetTexture(texture)
		ItemRack.SetIcons[i+1] = texture
		highlight_set_item(i)
	end
	ItemRack_Sets_ScrollFrame_Update()
end

function ItemRack_Sets_NewSet()

	local i,texture

	ItemRack_Sets_UpdateInventory()

	for i=0,19 do
		texture = GetInventoryItemTexture("player",i)
		if not texture then
			_,texture = GetInventorySlotInfo(string.gsub(ItemRack.Indexes[i].paperdoll_slot,"Character",""))
		end
		ItemRack.SetBuild[i] = ItemRack_Users[user].Inv[i] or 0
		highlight_set_item(i)
		ItemRack.SetIcons[i+1] = texture
	end

	ItemRack_Sets_Saved:Hide()
	ItemRack_Sets_Icons:Show() -- start out showing icons

	ItemRack.SelectedName = ""
	ItemRack_Sets_Name:SetText("")
	ItemRack.SelectedIcon = ItemRack.SetIcons[math.random(1,table.getn(ItemRack.SetIcons))]
	build_icon()

	ItemRack_TriStateCheck_SetState(ItemRack_ShowHelm,nil)
	ItemRack_TriStateCheck_SetState(ItemRack_ShowCloak,nil)

	for i=1,25 do
		getglobal("ItemRack_Sets_Icon"..i):UnlockHighlight()
	end

	ItemRack_Sets_NameLabel:SetText(ItemRackText.SETS_NAMELABEL_TEXT)
	ItemRack_Tab() -- flip to tab 2 (sets)

	ItemRack_SetsFrame:Show()
	ItemRack_Sets_Name:ClearFocus()

end

local function validate_set_buttons()

	local setname,found = ItemRack_Sets_Name:GetText()

	if Rack_User[user].Sets[setname] then
		ItemRack_Sets_RemoveButton:Enable()
		ItemRack_Sets_BindButton:Enable()
		ItemRack_Sets_HideSet:Enable()
		ItemRack_Sets_HideSetText:SetTextColor(1,1,1)
	else
		ItemRack_Sets_RemoveButton:Disable()
		ItemRack_Sets_BindButton:Disable()
		ItemRack_Sets_HideSet:Disable()
		ItemRack_Sets_HideSetText:SetTextColor(.4,.4,.4)
	end

	for i=0,19 do
		found = found or (ItemRack.SetBuild[i]==1)
	end
	setname = (found and setname) or nil

	if setname and string.len(setname)>0 then
		ItemRack_Sets_SaveButton:Enable()
	else
		ItemRack_Sets_SaveButton:Disable()
	end

	build_icon()
end

function ItemRack_Sets_InvToggle()

	local id = this:GetID()

	this:SetChecked(0)
	ItemRack.SetBuild[id] = 1-(ItemRack.SetBuild[id] or 0)

	highlight_set_item(id)

	if IsAltKeyDown() then

		if ItemRack_Users[user].Inv[id] and ItemRack.SetBuild[id]==0 then
			remove_inv(id)
		elseif not ItemRack_Users[user].Inv[id] and ItemRack.SetBuild[id]==1 then
			ItemRack_Users[user].Visible="ON"
			ItemRack_Users[user].Inv[id] = 1
			getglobal("ItemRackInv"..id.."Icon"):SetTexture(get_item_info(id))
			table.insert(ItemRack_Users[user].Bar,id)
			draw_inv()
		end
	end

	if ItemRack.SetBuild[id]==1 then
		ItemRack_BuildMenu(id,"SET")
	end

	validate_set_buttons()
end

function ItemRack_Sets_ScrollFrame_Update()

	local i, item, texture, idx
	local offset = FauxScrollFrame_GetOffset(ItemRack_Sets_ScrollFrame)

	FauxScrollFrame_Update(ItemRack_Sets_ScrollFrame, ceil(table.getn(ItemRack.SetIcons) / 5) , 5, 24 )
	
	for i=1,25 do
		item = getglobal("ItemRack_Sets_Icon"..i)
		idx = (offset*5) + i
		if idx<=table.getn(ItemRack.SetIcons) then
			texture = ItemRack.SetIcons[idx]
			item:SetNormalTexture(texture)
			item:SetPushedTexture(texture)
			item:Show()
		else
			item:Hide()
		end
		if ItemRack.SetIcons[idx]==ItemRack.SelectedIcon then
			item:LockHighlight()
		else
			item:UnlockHighlight()
		end
	end
end

function ItemRack_Sets_Icon_OnClick()

	local id = this:GetID()
	local offset = FauxScrollFrame_GetOffset(ItemRack_Sets_ScrollFrame)
	local idx = offset*5+id

	if idx<=table.getn(ItemRack.SetIcons) then
		ItemRack.SelectedIcon = ItemRack.SetIcons[idx]
		ItemRack_Sets_ScrollFrame_Update()
	end
	build_icon()
end

function ItemRack_Sets_Name_OnTextChanged()

	ItemRack.SelectedName = ItemRack_Sets_Name:GetText()
	ItemRack_Sets_ChosenIconName:SetText(ItemRack.SelectedName)
	validate_set_buttons()
end

-- save button clicked
function ItemRack_Sets_Save_OnClick()

	local setname = ItemRack_Sets_Name:GetText()
	local itemcount, itemname, itemslot = 0
	local oldkey, oldkeyindex

	ItemRack_Sets_Name:ClearFocus()

	-- if a 2H weapon in mainhand, ignore offhand (don't try to equip empty slot to offhand)
	_,_,itemslot = get_item_info(16)
	if itemslot=="INVTYPE_2HWEAPON" then
		ItemRack.SetBuild[17] = nil
	end

	if string.len(setname)>0 then
		if Rack_User[user].Sets[setname] then
			-- grab old key binding before recreating set
			oldkey = Rack_User[user].Sets[setname].key
			oldkeyindex = Rack_User[user].Sets[setname].keyindex
		end
		Rack_User[user].Sets[setname] = { icon=ItemRack.SelectedIcon, key=oldkey, keyindex=oldkeyindex }
		for i=0,19 do
			if ItemRack.SetBuild[i]==1 then
				Rack_User[user].Sets[setname][i] = {}
				itemcount = itemcount + 1
				_,itemname = get_item_info(i)
				Rack_User[user].Sets[setname][i].name = itemname or "(empty)"
				_,Rack_User[user].Sets[setname][i].id = Rack.GetItemInfo(i)
			end
		end
		sets_message(string.format(ItemRackText.SAVED,setname,itemcount))
		Rack_User[user].Sets[setname].hide = ItemRack_Sets_HideSet:GetChecked()
		Rack_User[user].Sets[setname].showhelm = ItemRack_ShowHelm.tristate
		Rack_User[user].Sets[setname].showcloak = ItemRack_ShowCloak.tristate
	end
	draw_minimap_icon()
	validate_set_buttons()
end

-- equips a set by name, usable in macros. now a wrapper to Rack.EquipSet()
function ItemRack_EquipSet(setname)

	if not setname and ItemRack.EventSetName then
		setname = ItemRack.EventSetName
	end

	Rack.EquipSet(setname)
end

-- hitting the dropdown button toggles between icons and savedsets
function ItemRack_Sets_DropDownButton_OnClick()

	ItemRack_Sets_Name:ClearFocus()
	ItemRack_Sets_Build_Dropdown()
	ItemRack_Sets_SubFrame2:Hide()
	ItemRack_Sets_SubFrame4:Hide()
	ItemRack_Sets_SetSelect:Show()
	ItemRack_Sets_Saved:Show()
end

-- clicking one of the drop-down saved sets
function ItemRack_Sets_Saved_OnClick(arg1)

	local id = this:GetID()
	local idx = FauxScrollFrame_GetOffset(ItemRack_Sets_SavedScrollFrame) + id
	local i,setname

	ItemRack_Sets_SetSelect:Hide()

	if ItemRack.SetsListSize<2 then
		-- do nothing
	elseif ItemRack.SelectedTab==2 then
		-- chose a set from the Sets tab (SubFrame2)
		setname = ItemRack.SetsList[idx].Name
		ItemRack_Sets_Name:SetText(setname)
		ItemRack.SelectedIcon = ItemRack.SetsList[idx].Icon
		ItemRack.SelectedName = setname
		build_icon()
		for i=0,19 do
			ItemRack.SetBuild[i] = Rack_User[user].Sets[setname][i] and 1 or 0
			highlight_set_item(i)
		end
		ItemRack_Sets_HideSet:SetChecked(Rack_User[user].Sets[setname].hide)
		ItemRack_TriStateCheck_SetState(ItemRack_ShowHelm,Rack_User[user].Sets[setname].showhelm)
		ItemRack_TriStateCheck_SetState(ItemRack_ShowCloak,Rack_User[user].Sets[setname].showcloak)
		ItemRack_EquipSet(setname)
	elseif ItemRack.SelectedTab==4 then
		-- chose a set from the Events tab (SubFrame4)
		setname = ItemRack.SetsList[idx].Name
		if not ItemRack_Users[user].Events[eventList[ItemRack.SelectedEvent].name] then
			ItemRack_Users[user].Events[eventList[ItemRack.SelectedEvent].name] = { setname=setname, enabled=1 }
		else
			ItemRack_Users[user].Events[eventList[ItemRack.SelectedEvent].name].setname = setname
		end
		ItemRack_Build_eventList()
	end

end

-- gather all sets into a numerically-indexes list to be used by SavedScrollFrame
function ItemRack_Sets_Build_Dropdown()

	local idx,i,j,count=1

	ItemRack.SetsList = ItemRack.SetsList or {}

	for i in Rack_User[user].Sets do
		if not string.find(i,"^ItemRack-") and not string.find(i,"^Rack-") then -- skip special sets (ItemRack-Queue and ItemRack-Normal)
			count = 0
			ItemRack.SetsList[idx] = ItemRack.SetsList[idx] or {}
			ItemRack.SetsList[idx].Icon = Rack_User[user].Sets[i].icon
			ItemRack.SetsList[idx].Name = i
			for j=0,19 do
				if Rack_User[user].Sets[i][j] then
					count = count + 1
				end
			end
			ItemRack.SetsList[idx].Count = string.format(ItemRackText.COUNTFORMAT,count)
			ItemRack.SetsList[idx].Key = Rack_User[user].Sets[i].key
			ItemRack.SetsList[idx].Hide = Rack_User[user].Sets[i].hide

			idx = idx +1
		end
	end
	ItemRack.SetsListSize = idx

	-- sort drop-down list alphabetically
	table.sort(ItemRack.SetsList,function(e1,e2) if e1 and e2 and (e1.Name<e2.Name) then return true else return false end end)
	ItemRack_Sets_SavedScrollFrameScrollBar:SetValue(0)
	ItemRack_Sets_SavedScrollFrame_Update()

end

-- scrollbar update for saved sets (dropdown)
function ItemRack_Sets_SavedScrollFrame_Update()

	local i, idx, item
	local offset = FauxScrollFrame_GetOffset(ItemRack_Sets_SavedScrollFrame)

	local listsize,listheight,liststub,compact = 8,28,"ItemRack_Sets_Saved",nil

	for i=1,8 do
		getglobal("ItemRack_Sets_Saved"..i):Hide()
	end
	for i=1,11 do
		getglobal("ItemRack_Sets_Compact"..i):Hide()
	end

	if ItemRack_Settings.CompactList=="ON" then
		listsize,listheight,liststub,compact = 11,21,"ItemRack_Sets_Compact",1
	end

	FauxScrollFrame_Update(ItemRack_Sets_SavedScrollFrame, ItemRack.SetsListSize-1, listsize, listheight )

	for i=1,listsize do
		idx = offset + i
		if idx<ItemRack.SetsListSize then
			getglobal(liststub..i.."Name"):SetText(ItemRack.SetsList[idx].Name)
			getglobal(liststub..i.."Icon"):SetTexture(ItemRack.SetsList[idx].Icon)
			if not compact then
				getglobal(liststub..i.."Count"):SetText(ItemRack.SetsList[idx].Count)
				getglobal(liststub..i.."Key"):SetText(ItemRack.SetsList[idx].Key)
			end
			if Rack_User[user].Sets[ItemRack.SetsList[idx].Name].hide then
				getglobal(liststub..i.."Name"):SetTextColor(.5,.5,.5)
				if not compact then
					getglobal(liststub..i.."Count"):SetTextColor(.5,.5,.5)
					getglobal(liststub..i.."Key"):SetTextColor(.5,.5,.5)
				end
			else
				getglobal(liststub..i.."Name"):SetTextColor(1,1,1)
				if not compact then
					getglobal(liststub..i.."Count"):SetTextColor(1,1,1)
					getglobal(liststub..i.."Key"):SetTextColor(1,1,1)
				end
			end
			getglobal(liststub..i):Show()
		else
			getglobal(liststub..i):Hide()
		end
	end

	if ItemRack.SetsListSize<=1 then
		ItemRack_Sets_Saved1Icon:SetTexture("")
		ItemRack_Sets_Saved1Name:SetText(ItemRackText.NOSAVEDSETS)
		ItemRack_Sets_Saved1Count:SetText("")
		ItemRack_Sets_Saved1Key:SetText("")
		ItemRack_Sets_Saved1:Show()
		for i=2,8 do
			getglobal("ItemRack_Sets_Saved"..i):Hide()
		end
		for i=1,11 do
			getglobal("ItemRack_Sets_Compact"..i):Hide()
		end
	end

end

-- displays a tooltip of a set's contents, set show_contents to override TinyTooltip option
function ItemRack_Sets_Tooltip(setname,show_contents)

	local count,missing,r,g,b,i,name,inv,bag = 0,0

	setname = setname or ItemRack.SelectedName

	if setname and Rack_User[user].Sets[setname] then

		set_tooltip_anchor(this)
		GameTooltip:AddLine(string.format(ItemRackText.SETTOOLTIPFORMAT,setname))
		for i=0,19 do
			if Rack_User[user].Sets[setname][i] then
				name = Rack_User[user].Sets[setname][i].name or "(empty)"
				count = count + 1
				inv,bag = Rack.FindItem(nil,name,"passive")
				if ItemRack.BankedItems[name] then
					r,g,b = .3,.5,1
				elseif inv or bag or name=="(empty)" then
					r,g,b = .85,.85,.85
				else
					r,g,b = 1,.1,.1 -- mark missing items red
					missing = missing + 1
				end
				if ItemRack_Settings.TinyTooltip=="OFF" or show_contents then
					GameTooltip:AddLine(ItemRack.Indexes[i].name..": "..tostring(name),r,g,b)
				end
			end
		end
		if ItemRack_Settings.TinyTooltip=="ON" and not show_contents then
			-- if Tiny Tooltip enabled, just show a count
			GameTooltip:AddLine(string.format(ItemRackText.SETTOOLTIPCOUNT,count),.85,.85,.85)
			if missing>0 then
				GameTooltip:AddLine(string.format(ItemRackText.SETTOOLTIPMISSING,missing),1,.1,.1)
			end
		end
		GameTooltip:Show()
	end
end	

-- tooltips displaying contents of a set in the dropdown list
function ItemRack_Sets_Saved_OnEnter()

	if ItemRack.SetsListSize>1 then
		local id = this:GetID()
		local idx = FauxScrollFrame_GetOffset(ItemRack_Sets_SavedScrollFrame) + id
		local setname = ItemRack.SetsList[idx].Name
		ItemRack_Sets_Tooltip(setname,1) -- ,1 forces contents to show in tooltip
	end
end

--[[ Key bindings ]]--

-- returns a number 1-10 (or MaxKeyBindings) of an available key binding, nil if none are free
local function get_free_binding()

	local i,j,found,freeindex

	for i=1,ItemRackText.MaxKeyBindings do
		found = false
		for j in Rack_User[user].Sets do
			if Rack_User[user].Sets[j].keyindex == i then
				found = true
			end
		end
		if not found then
			freeindex = i
			i = ItemRackText.MaxKeyBindings+1 -- whimpy break
		end
	end

	return freeindex
end

-- removes a key by index, 1-10 (or .MaxKeyBindings)
local function unbind_key_index(idx)

	if idx then
		local oldkey = GetBindingKey("EQUIPSET"..idx)
		if oldkey then
			SetBinding(oldkey)
			setglobal("BINDING_NAME_EQUIPSET"..idx,string.format(ItemRackText.BINDINGFORMAT,idx))
		end
	end
end

-- removes old key bindings, for initialization and preparation to bind a key
-- if no setname given, then all keys are unbound
local function unbind_keys(setname)

	local idx

	if not setname then
		for idx=1,ItemRackText.MaxKeyBindings do
			unbind_key_index(idx)
		end
	else
		idx = Rack_User[user].Sets[setname].keyindex
		unbind_key_index(idx)
	end
	SaveBindings(GetCurrentBindingSet())

end	

-- this takes the current key bindings and updates the .Sets info -- usually as a result of user changing bindings outside the mod
function ItemRack_AgreeOnKeyBindings()
	local i,oldkey,setname

	if ItemRack.KeyBindingsSettled then
		-- don't do this at startup, wait until we had a chance to initialize this player's keys

		for i in Rack_User[user].Sets do
			Rack_User[user].Sets[i].key = nil
			Rack_User[user].Sets[i].keyindex = nil
		end

		for i=1,10 do
			oldkey = GetBindingKey("EQUIPSET"..i)
			if oldkey then
				_,_,setname = string.find(getglobal("BINDING_NAME_EQUIPSET"..i) or "",ItemRackText.BINDINGSEARCH)
				if setname and Rack_User[user].Sets[setname] then
					Rack_User[user].Sets[setname].key = oldkey
					Rack_User[user].Sets[setname].keyindex = i
				end
			end
		end
	end
end

-- removes the currently selected set
function ItemRack_Sets_Remove_OnClick()

	if Rack_User[user].Sets[ItemRack.SelectedName] then
		unbind_keys(ItemRack.SelectedName)
		Rack_User[user].Sets[ItemRack.SelectedName] = nil
		sets_message(string.format(ItemRackText.SETREMOVE,ItemRack.SelectedName))
		local i
		-- if an event has this set, remove the association
		for i in ItemRack_Users[user].Events do
			if ItemRack_Users[user].Events[i].setname==ItemRack.SelectedName then
				ItemRack_Users[user].Events[i] = nil
			end
		end
		ItemRack.SelectedName=nil
		ItemRack_Sets_Name:SetText("")
		build_icon()
		validate_set_buttons()
		ItemRack_Build_eventList()
	end
end

function ItemRack_UseSetBinding(v1)

	local i,setname

	-- look for sets with this key index
	for i in Rack_User[user].Sets do
		if Rack_User[user].Sets[i].keyindex == v1 then
			setname = i
		end
	end

	-- if we found a set with this key index, equip it
	if setname then
		ItemRack_EquipSet(setname)
	end
end

local function bind_key_to_set(key,setname)

	-- check if another set has this key binding
	local i
	for i in Rack_User[user].Sets do
		if Rack_User[user].Sets[i].key == key then
			unbind_keys(i) -- remove the other set's key binding if so
			Rack_User[user].Sets[i].keyindex = nil -- remove them from our table
			Rack_User[user].Sets[i].key = nil
		end
	end

	-- get the next free key binding
	local idx = Rack_User[user].Sets[setname].keyindex or get_free_binding()

	if idx then -- if we previously had a key binding or there's space for a new one, continue
			-- associate the key and index (1-10) with the set
		Rack_User[user].Sets[setname].key = key
		Rack_User[user].Sets[setname].keyindex = idx
		-- release any binding this key previously had
		unbind_keys(setname)

		-- finally bind the key
		ItemRack.KeyBindingsSettled = nil -- don't do an agree on key bindings until set
		local success = SetBinding(key,"EQUIPSET"..idx)
		if success then
			setglobal("BINDING_NAME_EQUIPSET"..idx,string.format(ItemRackText.BINDINGFORMAT,setname))
			sets_message(string.format(ItemRackText.BINDSET,key))
		else
			-- couldn't bind the key, forget we tried (should never get to this part)
			Rack_User[user].Sets[setname].key = nil
			Rack_User[user].Sets[setname].keyindex = nil
		end
		ItemRack.KeyBindingsSettled = 1
		SaveBindings(GetCurrentBindingSet())
		ItemRack_KeyBindFrame:Hide()
	end
end

-- hitting a key when "Press a key" mode up
function ItemRack_Sets_KeyBind_OnKeyDown(arg1)

	local setname = ItemRack.SelectedName

	if arg1=="ESCAPE" then
		sets_message(ItemRackText.BINDCLEAR)
		ItemRack_KeyBindFrame:Hide()

		-- if this set has a key, restore its name and release the key binding
		unbind_keys(setname)
		Rack_User[user].Sets[setname].key = nil
		Rack_User[user].Sets[setname].keyindex = nil

	elseif arg1~="SHIFT" and arg1~="ALT" and arg1~="CTRL" then
		local key = arg1
		if IsShiftKeyDown() then
			key = "SHIFT-"..key
		elseif IsAltKeyDown() then
			key = "ALT-"..key
		elseif IsControlKeyDown() then
			key = "CTRL-"..key
		end

		local action
		action = GetBindingAction(key)
		if action and action~="" then
			StaticPopupDialogs["ITEMRACKKEYCONFIRM"] = {
				text = key.." is already used for "..tostring(getglobal("BINDING_NAME_"..action)).."\n\nOverwrite?",
				button1 = "Yes",
				button2 = "No",
				OnAccept = function() bind_key_to_set(key,setname) end,
				OnCancel = function() sets_message("No key binding set.") end,
				timeout = 0,
				whileDead = 1
			}
			StaticPopup_Show("ITEMRACKKEYCONFIRM")
		else
			bind_key_to_set(key,setname)
		end
	end

	build_icon()

end

function ItemRack_InitializeKeyBindings()

	local i, keyidx

	unbind_keys() -- remove all 10 keybindings (from previous users perhaps)

	for i in Rack_User[user].Sets do
		keyidx = Rack_User[user].Sets[i].keyindex
		if keyidx then
			setglobal("BINDING_NAME_EQUIPSET"..keyidx,string.format(ItemRackText.BINDINGFORMAT,i))
			SetBinding(Rack_User[user].Sets[i].key,"EQUIPSET"..keyidx)
		end
	end
	SaveBindings(GetCurrentBindingSet())
	ItemRack.KeyBindingsSettled = true
end

function ItemRack_Sets_Inv_OnEnter()

	local id = this:GetID()

	if ItemRack.SetBuild and ItemRack.SetBuild[id]==1 then
		ItemRack_BuildMenu(id,"SET")
	end

end

function ItemRack_Sets_ChosenIcon_OnClick()

	if IsAltKeyDown() then

		if ItemRack_Users[user].Inv[20] then
			remove_inv(20)
		elseif not ItemRack_Users[user].Inv[20] then
			ItemRack_Users[user].Visible="ON"
			ItemRack_Users[user].Inv[20] = 1
			ItemRackInv20Icon:SetTexture(get_item_info(20))
			table.insert(ItemRack_Users[user].Bar,20)
			draw_inv()
		end
	end

	validate_set_buttons()
end

--[[ Minimap button ]]--

function ItemRack_Sets_Toggle(v1)

	if v1 then
		if not getglobal("ItemRack_Sets_SubFrame"..v1):IsVisible() then
			ItemRack_SetsFrame:Hide()
		end
	end

	if ItemRack_SetsFrame:IsVisible() then
		ItemRack_SetsFrame:Hide()
	else
		ItemRack_Sets_NewSet()
	end
	if v1 then
		ItemRack_Tab(v1)
	end
end

-- when user clicks the minimap button
function ItemRack_IconFrame_OnClick(arg1)

	if arg1=="LeftButton" and ItemRack_Settings.DisableToggle=="OFF" then
		-- toggle bar
		ItemRack_Toggle()
	elseif arg1=="LeftButton" then
		-- toggle menu		
		if ItemRack_MenuFrame:IsVisible() then
			ItemRack_MenuFrame:Hide()
		else
			ItemRack_BuildMenu(20,"MINIMAP")
		end
	else
		ItemRack_Sets_Toggle()
	end

end

--[[ Tabs ]]--

function ItemRack_Tab(v1)

	ItemRack_Sets_SetSelect:Hide()
	ItemRack_EditEvent:Hide()
	ItemRack.SelectedTab = (v1 or ItemRack.SelectedTab) or 1
	for i=1,4 do
		getglobal("ItemRack_Sets_Tab"..i):UnlockHighlight()
		getglobal("ItemRack_Sets_SubFrame"..i):Hide()
	end
	getglobal("ItemRack_Sets_Tab"..ItemRack.SelectedTab):LockHighlight()
	getglobal("ItemRack_Sets_SubFrame"..ItemRack.SelectedTab):Show()
end

-- when set chooser dropdown shown
function ItemRack_SetSelect_OnShow()
  -- remove ItemRack_SetsFrame from UISpecialFrames and add ItemRack_Sets_SetSelect
	make_escable("ItemRack_SetsFrame","remove")
	make_escable("ItemRack_Sets_SetSelect","add")
end

-- when set chooser dropdown hidden
function ItemRack_SetSelect_OnHide()
	-- remove ItemRack_Sets_SetSelect from UISpecialFrames and add ItemRack_SetsFrame
	make_escable("ItemRack_Sets_SetSelect","remove")
	make_escable("ItemRack_SetsFrame","add")
	getglobal("ItemRack_Sets_SubFrame"..ItemRack.SelectedTab):Show()
end

-- when event editor shown
function ItemRack_EditEvent_OnShow()
	ItemRack_Sets_SubFrame4:Hide()
	make_escable("ItemRack_SetsFrame","remove")
	make_escable("ItemRack_EditEvent","add")
end

-- when event editor hidden
function ItemRack_EditEvent_OnHide()
	make_escable("ItemRack_EditEvent","remove")
	make_escable("ItemRack_SetsFrame","add")
	ItemRack_Sets_SubFrame4:Show()
end

-- when the sets frame is hidden, enable all events if events are on
function ItemRack_SetsFrame_OnHide()
	ItemRack_MenuFrame:Hide()
	ItemRack_EnableAllEvents()
end

-- when the sets frame is shown, disable all events
function ItemRack_SetsFrame_OnShow()
	if not ItemRack.SetIcons then
		ItemRack_Sets_Initialize()
	end
	ItemRack_DisableAllEvents()
	if ItemRack_Settings.EnableEvents=="ON" then
		sets_message(ItemRackText.EVENTSSUSPENDED)
	end
end

--[[ Events ]]--

local function check_for_titanrider()

	if TITAN_RIDER_ID and (not TitanRider_EquipToggle or (TitanGetVar and TitanGetVar(TITAN_RIDER_ID,"EquipItems"))) then
		StaticPopupDialogs["ITEMRACK_TITANRIDER"] = {
			text = "It appears you have Titan Rider (a module of Titan Panel) enabled.  Do not use this Mount event with Titan Rider enabled or it will create a mess (items on cursor, gear swapping back).",
			button1 = "Ok", timeout = 0, whileDead = 1, showAlert = 1, hideOnEscape = 1 }
		StaticPopup_Show("ITEMRACK_TITANRIDER")
		return 1
	else
		return nil
	end
end

-- changes the font size in the event edit window
function ItemRack_ChangeEventFont()
	if ItemRack_Settings.LargeFont=="ON" then
		ItemRack_EventScript:SetFont("Fonts\\ARIALN.TTF",15)
	else
		ItemRack_EventScript:SetFont("Fonts\\FRIZQT__.TTF",11)
	end
end

-- builds eventList, a numerically-indexed list of events and their associated sets
function ItemRack_Build_eventList()

	local i
	eventListSize = 1
	local oldeventname,eventname

	if ItemRack.SelectedEvent>0 then
		-- remember old selected event, it may move in the list
		oldeventname = eventList[ItemRack.SelectedEvent].name
	end

	scratchTableSize[1] = 1 -- size of each table for secondary sort
	scratchTableSize[2] = 1

	-- problems with secondary sort, so doing one manually - first split events into two tables: ones with a setname, ones without
	for i in ItemRack_Events do
		-- first split 
		if i~="events_version" then
			_,_,class = string.find(i,"^(.+)%:")
			if ItemRack_Settings.ShowAllEvents=="ON" or (not class or class==UnitClass("player")) then
				if ItemRack_Users[user].Events[i] and Rack_User[user].Sets[ItemRack_Users[user].Events[i].setname] then
					scratchTable[1][scratchTableSize[1]] = i
					scratchTableSize[1] = scratchTableSize[1] + 1
				else
					scratchTable[2][scratchTableSize[2]] = i
					scratchTableSize[2] = scratchTableSize[2] + 1
				end
			end
		end
	end
	scratchTable[1][scratchTableSize[1]] = nil
	scratchTable[2][scratchTableSize[2]] = nil

	-- sort each half
	table.sort(scratchTable[1],function(e1,e2) return e1 and e2 and e1<e2 end)
	table.sort(scratchTable[2],function(e1,e2) return e1 and e2 and e1<e2 end)

	-- merge the halves
	eventListSize = 1
	for i=1,scratchTableSize[1]-1 do
		eventname = scratchTable[1][i]
		eventList[eventListSize] = eventList[eventListSize] or {}
		eventList[eventListSize].name = eventname
		eventList[eventListSize].trigger = ItemRack_Events[eventname].trigger
		eventList[eventListSize].delay = ItemRack_Events[eventname].delay
		eventList[eventListSize].script = ItemRack_Events[eventname].script
		eventList[eventListSize].setname = ItemRack_Users[user].Events[eventname].setname
		eventList[eventListSize].texture = Rack_User[user].Sets[eventList[eventListSize].setname].icon
		eventList[eventListSize].enabled = ItemRack_Users[user].Events[eventname].enabled
		eventListSize = eventListSize + 1
	end
	for i=1,scratchTableSize[2]-1 do
		eventname = scratchTable[2][i]
		eventList[eventListSize] = eventList[eventListSize] or {}
		eventList[eventListSize].name = eventname
		eventList[eventListSize].trigger = ItemRack_Events[eventname].trigger
		eventList[eventListSize].delay = ItemRack_Events[eventname].delay
		eventList[eventListSize].script = ItemRack_Events[eventname].script
		eventList[eventListSize].setname = nil
		eventList[eventListSize].texture = nil
		eventList[eventListSize].enabled = nil
		eventListSize = eventListSize + 1
	end

	ItemRack.SelectedEvent=0
	for i=1,eventListSize-1 do
		if eventList[i].name==oldeventname then
			ItemRack.SelectedEvent = i
		end
	end

	ItemRack_Validate_EventList_Buttons()
	ItemRack_Events_ScrollFrame_Update()
end

-- update for the list of events scrollframe
function ItemRack_Events_ScrollFrame_Update()

	local i, texture, idx, button, icon, enable, name
	local offset = FauxScrollFrame_GetOffset(ItemRack_Events_ScrollFrame)

	FauxScrollFrame_Update(ItemRack_Events_ScrollFrame, eventListSize-1, 7, 26 )
	
	for i=1,7 do
		idx = offset + i
		button = getglobal("ItemRack_Event"..i)
		if idx<eventListSize then
			if ItemRack_Settings.ShowAllEvents=="ON" then
				getglobal("ItemRack_Event"..i.."Name"):SetText(eventList[idx].name)
			else
				_,_,name = string.find(eventList[idx].name,"^.+%:(.+)")
				name = name or eventList[idx].name
				getglobal("ItemRack_Event"..i.."Name"):SetText(name)
			end
			icon = getglobal("ItemRack_Event"..i.."Icon")
			enable = getglobal("ItemRack_Event"..i.."Enable")
			if eventList[idx].setname then
				icon:SetNormalTexture(eventList[idx].texture)
				icon:SetPushedTexture(eventList[idx].texture)
				enable:SetChecked(eventList[idx].enabled)
				enable:Show()
			else
				icon:SetNormalTexture("Interface\\Icons\\INV_Misc_QuestionMark")
				icon:SetPushedTexture("Interface\\Icons\\INV_Misc_QuestionMark")
				enable:Hide()
			end
			button:Show()
		else
			button:Hide()
		end
		if idx==ItemRack.SelectedEvent then
			button:LockHighlight()
		else
			button:UnlockHighlight()
		end
	end
end

-- onclick for events in the list, to lock highlight
function ItemRack_EventsList_OnClick(arg1)

	local idx = this:GetID() + FauxScrollFrame_GetOffset(ItemRack_Events_ScrollFrame)

	if idx<eventListSize then
		ItemRack.SelectedEvent = (ItemRack.SelectedEvent==idx) and 0 or idx
	end
	ItemRack_Validate_EventList_Buttons()
	ItemRack_Events_ScrollFrame_Update()
end

-- returns the eventList index for the *parent* of "this"
local function event_idx()
	return this:GetParent():GetID() + FauxScrollFrame_GetOffset(ItemRack_Events_ScrollFrame)
end

function ItemRack_EventsList_EnableOnClick()

	local idx = event_idx()

	if idx<eventListSize then
		local eventname = eventList[idx].name
		if not ItemRack_Users[user].Events[eventname] then
			ItemRack_Users[user].Events[eventname] = {}
		end
		ItemRack_Users[user].Events[eventname].enabled = this:GetChecked()
		if eventname=="Mount" and check_for_titanrider() then
			ItemRack_Users[user].Events[eventname].enabled = nil
		end
	end
	ItemRack_Build_eventList()
end

-- onenter of an event icon either a tooltip for an undefined event or the contents of the set
function ItemRack_EventsListIcon_OnEnter()

	local idx = event_idx()

	if idx<eventListSize then
		local setname = eventList[idx].setname
		if not setname then
			ItemRack_OnTooltip(ItemRackText.UNDEFINEDEVENT_TEXT,ItemRackText.UNDEFINEDEVENT_TOOLTIP)
		else
			ItemRack_Sets_Tooltip(setname)
		end
	end
end

function ItemRack_Validate_EventList_Buttons()

	if ItemRack.SelectedEvent==0 then
		ItemRack_Events_DeleteButton:Disable()
		ItemRack_Events_EditButton:Disable()
	else
		ItemRack_Events_DeleteButton:Enable()
		ItemRack_Events_EditButton:Enable()
	end
end

-- clicking event icon summons set selection window
function ItemRack_EventsListIcon_OnClick()

	local idx = event_idx()

	if idx<eventListSize then
		if eventList[idx].name=="Mount" and check_for_titanrider() then
			return
		else
			ItemRack.SelectedEvent = idx
			ItemRack_Events_ScrollFrame_Update()
			ItemRack_Validate_EventList_Buttons()
			ItemRack_Sets_DropDownButton_OnClick()
		end
	end
end

-- handler for buttons clicked in the events pane
function ItemRack_EventButtons(v1)

	local i
	local others = ""

	if v1=="Delete" then
		local eventname = eventList[ItemRack.SelectedEvent].name

		ItemRack_DisableEvent(eventname)

		i = ItemRack_Users[user].Events[eventname]
		ItemRack_Users[user].Events[eventname] = nil

		if not i then

			for i in ItemRack_Users do
				if ItemRack_Users[i].Events and ItemRack_Users[i].Events[eventname] then
					others = others..i..", "
				end
			end

			if others=="" then
				sets_message("\""..eventname.."\" removed completely.")
				ItemRack_Events[eventname] = nil
			else
				others = string.gsub(others,", $","")
				sets_message("\""..eventname.."\" is used by: "..others)
			end
		else
			sets_message("\""..eventname.."\" disassociated.")
		end
		ItemRack_Events_ScrollFrameScrollBar:SetValue(0)
	elseif v1=="New" then
		ItemRack_EventScript:SetText("")
		ItemRack_EventName:SetText("")
		ItemRack_EventTrigger:SetText("")
		ItemRack_EventDelay:SetText("")
		ItemRack_EditEvent:Show()
		ItemRack_EventName:SetFocus()
	elseif v1=="Edit" then
		if ItemRack.SelectedEvent==0 then
			-- if we're here and SelectedEvent==0, it was a double-click to a selected event. Reselect it
			ItemRack_EventsList_OnClick("LeftButton")
		end
		-- if SelectedEvent defined, then either edit button or double-click to previously unselected event
		local eventname = eventList[ItemRack.SelectedEvent].name

		ItemRack_EventScript:SetText(ItemRack_Events[eventname].script or "")
		ItemRack_EventName:SetText(eventname)
		ItemRack_EventTrigger:SetText(ItemRack_Events[eventname].trigger or "")
		ItemRack_EventDelay:SetText(ItemRack_Events[eventname].delay or "")
		ItemRack_EditEvent:Show()
		ItemRack_EventScript:SetFocus()

	elseif v1=="Save" then
		local eventname = eventList[ItemRack.SelectedEvent] and eventList[ItemRack.SelectedEvent].name
		local name = ItemRack_EventName:GetText()
		if name and string.len(name)>0 then
			if not ItemRack_Events[name] then
				ItemRack_Events[name] = {}
			end
			ItemRack_Events[name].script = ItemRack_EventScript:GetText()
			ItemRack_Events[name].trigger = ItemRack_EventTrigger:GetText()
			ItemRack_Events[name].delay = tonumber(ItemRack_EventDelay:GetText()) or 0
			sets_message("Event \""..name.."\" saved.")
			ItemRack_EditEvent:Hide()
		else
			sets_message("Event not saved.  Need a name at least.")
		end
	elseif v1=="Test" then
		RunScript(ItemRack_EventScript:GetText() or "")
	end
	ItemRack_Build_eventList()
end

--[[ Event Registration ]]--

ItemRack.Register = {} -- game events (UNIT_AURA, etc) are stored here

-- debug function, to list registered game events and the mod events they are for
function ItemRack_ListEvents()
	local i,j,foundtrigger,foundevent

	for i in ItemRack.Register do
		foundtrigger=1
		foundevent=nil
		DEFAULT_CHAT_FRAME:AddMessage("__"..i.."__")
		for j in ItemRack.Register[i] do
			foundevent=1
			DEFAULT_CHAT_FRAME:AddMessage(j)
		end
		if not foundevent then
			DEFAULT_CHAT_FRAME:AddMessage("none")
		end
	end
	if not foundtrigger then
		DEFAULT_CHAT_FRAME:AddMessage("No events registered.")
	end
end

-- enables a specific eventname ("Riding","Warrior:Berserk",etc)
function ItemRack_EnableEvent(eventname)

	if not ItemRack_Events[eventname] then return end

	local trigger = ItemRack_Events[eventname].trigger

	if not ItemRack.Register[trigger] then
		ItemRack_RegisterFrame:RegisterEvent(trigger)
		ItemRack.Register[trigger] = {}
	end
	ItemRack.Register[trigger][eventname] = 1
end

-- disables a sepcific eventname ("Riding","Warrior:Berserk",etc)
function ItemRack_DisableEvent(eventname)

	if not ItemRack_Events[eventname] then return end

	local trigger = ItemRack_Events[eventname].trigger
	local has_event,i

	if ItemRack.Register[trigger] then
		ItemRack.Register[trigger][eventname] = nil
		for i in ItemRack.Register[trigger] do has_event=1 end
		if not has_event then
			ItemRack_RegisterFrame:UnregisterEvent(trigger)
			ItemRack.Register[trigger] = nil
		end
	else
		ItemRack_RegisterFrame:UnregisterEvent(trigger)
	end
end

-- use this to initialize, enable or refresh Register
function ItemRack_EnableAllEvents()
	local i

	if ItemRack_Settings.Notify=="OFF" then
		-- if notify is off, see if any ITEMRACK_NOTIFY events are registered and turn on notify
		for i in ItemRack_Users[user].Events do
			if ItemRack_Users[user].Events[i].enabled and ItemRack_Events[i].trigger=="ITEMRACK_NOTIFY" then
				ItemRack_Settings.Notify="ON"
--				ItemRack_Opt_Notify:SetChecked(1)
				DEFAULT_CHAT_FRAME:AddMessage("ItemRack: Notify has been turned on for Event: |cFFFFFF00"..i)
			end
		end
	end

	if ItemRack_Settings.EnableEvents=="ON" then
		for i in ItemRack_Users[user].Events do
			if ItemRack_Users[user].Events[i].enabled then
				ItemRack_EnableEvent(i)
			else
				ItemRack_DisableEvent(i)
			end
		end
		ItemRackFrame:RegisterEvent("PLAYER_AURAS_CHANGED")
	else
		ItemRack_DisableAllEvents()
	end
end

-- use this to trun off all event watching.
function ItemRack_DisableAllEvents()
	local i

	for i in ItemRack_Users[user].Events do
		ItemRack_DisableEvent(i)
	end
	ItemRackFrame:UnregisterEvent("PLAYER_AURAS_CHANGED")
end

--[[ Event Processing ]]--

ItemRack.EventQueue = {} -- indexed by events ("Riding", "Warrior:Battle") of GetTime()+delay to run

-- these two holders of arg1 and arg2 are separate for minimal processing to happen
-- a loop holding arg1-9 in a table takes 3.1 seconds for 100k iterations
-- storing just the first two values and moving on drops processing to 0.28 seconds
ItemRack.EventQueueArg1 = {} -- indexed by events also, values of arg1
ItemRack.EventQueueArg2 = {} -- indexed by events also, values of arg2

-- runs the eventname script, event = "Riding", "Warrior:Battle", etc
local function run_event_script(eventname)

	if eventname and ItemRack_Users[user].Events[eventname] then
		ItemRack.EventSetName = ItemRack_Users[user].Events[eventname].setname
		ItemRack.EventEventName = eventname
		if ItemRack.EventSetName then
			RunScript(ItemRack_Events[eventname].script)
			ItemRack.EventSetName = nil
			ItemRack.EventEventName = nil
		end
	end
end

-- events("triggers") defined in game go through here
function ItemRack_RegisterFrame_OnEvent(event)
	local i,j

	if ItemRack.Register[event] then
		for i in ItemRack.Register[event] do
			if ItemRack_Events[i].delay==0 then
				-- EventSetName is the name of the set to use for EquipSet(), it's the set associated with the event
				run_event_script(i)
			else
				ItemRack.EventQueue[i] = GetTime()+ItemRack_Events[i].delay
				ItemRack.EventQueueArg1[i] = arg1
				ItemRack.EventQueueArg2[i] = arg2
				ItemRack_RegisterFrame:Show() -- turn on OnUpdate
			end
		end
	end
end

local register_timer = 0
function ItemRack_RegisterFrame_OnUpdate()

	local i

	-- check every .25 seconds if time has elapsed for events with a delay
	register_timer = register_timer + arg1
	if register_timer > .25 then
		register_timer = 0
		local current_time = GetTime()
		local queue_exists = nil
		for i in ItemRack.EventQueue do
			queue_exists = 1 -- something is in the queue
			if ItemRack.EventQueue[i]<current_time then
				local holdarg1,holdarg2 = arg1,arg2
				arg1 = ItemRack.EventQueueArg1[i]
				arg2 = ItemRack.EventQueueArg2[i]
				run_event_script(i)
				arg1 = holdarg1
				arg2 = holdarg2
				ItemRack.EventQueue[i] = nil
			end
		end
		if not queue_exists then
			ItemRack_RegisterFrame:Hide() -- shut down OnUpdates when nothing left to process
		end
	end
end

-- saves the items currently worn that EventSetName defines into a set named "ItemRack-Saved"
-- a parameter passed will use the passed setname, for use in macros, ie SaveSet("pvp")
function ItemRack_SaveSet(v1)
-- NO LONGER NEEDED: EquipSet saves what was worn previously
end

-- equips the items previous saved in SaveSet(). it only equips items in the slots associated with the set
-- a parameter passed will use the passed setname, for use in macros, ie LoadSet("pvp")
function ItemRack_LoadSet(setname)

	if not setname and ItemRack.EventSetName then
		setname = ItemRack.EventSetName
	end

	Rack.UnequipSet(setname)
end

function ItemRack_ToggleEvents()

	if ItemRack_Settings.EnableEvents=="OFF" then
		ItemRack_Settings.EnableEvents="ON"
		ItemRack_Opt_EnableEvents:SetChecked(1)
		ItemRack_EnableAllEvents()
		DEFAULT_CHAT_FRAME:AddMessage("|cFF66AAFFItemRack Automatic Events are now |cFF55FF55ON")
	else
		ItemRack_Settings.EnableEvents="OFF"
		ItemRack_Opt_EnableEvents:SetChecked(nil)
		ItemRack_DisableAllEvents()
		DEFAULT_CHAT_FRAME:AddMessage("|cFF66AAFFItemRack Automatic Events are now |cFFFF5555OFF")
	end
end

function ItemRack_EventsList_OnEnter()
	local idx,notes = this:GetID() + FauxScrollFrame_GetOffset(ItemRack_Events_ScrollFrame)

	if eventList[idx].name and ItemRack_Settings.ShowTooltips=="ON" then
		set_tooltip_anchor(this)
		GameTooltip:AddLine(eventList[idx].name)
		if eventList[idx].setname then
			GameTooltip:AddLine("Set: "..eventList[idx].setname)
		end
		_,_,notes = string.find(eventList[idx].script or "","--%[%[(.+)%]%]")
		if notes then
			GameTooltip:AddLine(notes,.8,.8,.8,1)
		end
		GameTooltip:Show()
	end
end

-- toggles a set, remembering what it wore previous to equipping the set
function ItemRack_ToggleSet(setname)
	Rack.ToggleSet(setname)
end

--[[ Event script helper functions

	These are not necessary.  They can be completely encapsulated in the scripts themselves.  They're here for convenience. ]]

-- this is a special function to use for mount events. returns true if player is mounted, nil otherwise
-- pass a non-nil value for v1 to do a slow/thorough scan
function ItemRack_PlayerMounted(v1)

	local i,buff,mounted

	for i=1,24 do
		buff = UnitBuff("player",i)
		if buff then
			if problem_mounts[buff] or v1 or string.find(buff,"QirajiCrystal_") then
				-- hunter could be in group, could be warlock epic mount etc, check if this is truly a mount
				-- or if v1 is set to true, always check every buff. sigh this is slow but really no way around it without more data from users
				Rack_TooltipScan:SetUnitBuff("player",i)
				if string.find(Rack_TooltipScanTextLeft2:GetText() or "",ItemRackText.MOUNTCHECK) then
					mounted = true
					i = 25
				end
			elseif string.find(buff,"Mount_") then
				mounted = true
				i = 25
			end
		else
			i = 25
		end
	end

	return mounted
end

-- returns the name of the form the player is in
function ItemRack_GetForm()

	local i,name,form

	for i=1,GetNumShapeshiftForms() do
		_,name,is_active = GetShapeshiftFormInfo(i)
		if is_active then
			form = name
		end
	end
	return form
end

-- gathers active buffs into ItemRack.Buffs and sends it via RegisterFrame for events
function ItemRack_BuffsChanged()
	local buffName,buffTexture
	for i in ItemRack.Buffs do
		ItemRack.Buffs[i] = nil
	end
	for i=1,24 do
		Rack_TooltipScan:SetUnitBuff("player",i)
		buffName = Rack_TooltipScanTextLeft1:GetText()
		buffTexture = UnitBuff("player",i)
		if buffTexture then
			ItemRack.Buffs[buffName] = 1
			ItemRack.Buffs[buffTexture] = 1
		else
			break
		end
	end
	local oldarg1 = arg1
	arg1=ItemRack.Buffs
	ItemRack_RegisterFrame_OnEvent("ITEMRACK_BUFFS_CHANGED")
	arg1 = oldarg1
end

-- returns 1 if all pieces of setname are equipped, nil otherwise
function ItemRack_IsSetEquipped(setname)
	return Rack.IsSetEquipped(setname)
end

-- returns three parameters: table of sets, current set name, current set texture
function ItemRack_GetUserSets()
	local texture = "Interface\\AddOns\\ItemRack\\ItemRack-Icon"
	local setname = ItemRack_CurrentSet()
	if setname and Rack_User[user].Sets[setname] and not string.find(setname,"^Rack") and not string.find(setname,"^ItemRack") then
		texture = Rack_User[user].Sets[setname].icon
	end
	return Rack_User[user].Sets, setname, texture
end

--[[ Rack 2.0 code begins here ]]--

--[[ There is some redundancy because everything that follows is a part of ItemRack 2.0.
	 Everything above this section will be scrapped for 2.0 ]]

Rack = {
	version = 1.9,
	debug = nil,

	TimerPool = {}, -- timer tables added here ["InvUpdate"]={timer,limit,func,rep}

	SetSwapping = nil, -- name of a set currently being swapped
	SwapList = {}, -- individual item swap details go here
	LockList = {}, -- tables of bags where slots are locked (to be skipped in FindItem and FindSpace)
	CombatQueue = {} -- table of items to swap in when dropping out of combat/death
}

Rack.SlotInfo = {
	[0] = { name="AmmoSlot", swappable=1, INVTYPE_AMMO=1 },
	[1] = { name="HeadSlot", INVTYPE_HEAD=1 },
	[2] = { name="NeckSlot", INVTYPE_NECK=1 },
	[3] = { name="ShoulderSlot", INVTYPE_SHOULDER=1 },
	[4] = { name="ShirtSlot", INVTYPE_BODY=1 },
	[5] = { name="ChestSlot", INVTYPE_CHEST=1, INVTYPE_ROBE=1 },
	[6] = { name="WaistSlot", INVTYPE_WAIST=1 },
	[7] = { name="LegsSlot", INVTYPE_LEGS=1 },
	[8] = { name="FeetSlot", INVTYPE_FEET=1 },
	[9] = { name="WristSlot", INVTYPE_WRIST=1 },
	[10] = { name="HandsSlot", INVTYPE_HAND=1 },
	[11] = { name="Finger0Slot", INVTYPE_FINGER=1 },
	[12] = { name="Finger1Slot", INVTYPE_FINGER=1 },
	[13] = { name="Trinket0Slot", INVTYPE_TRINKET=1 },
	[14] = { name="Trinket1Slot", INVTYPE_TRINKET=1 },
	[15] = { name="BackSlot", INVTYPE_CLOAK=1 },
	[16] = { name="MainHandSlot", swappable=1, INVTYPE_WEAPONMAINHAND=1, INVTYPE_2HWEAPON=1, INVTYPE_WEAPON=1 },
	[17] = { name="SecondaryHandSlot", swappable=1, INVTYPE_WEAPON=1, INVTYPE_WEAPONOFFHAND=1, INVTYPE_SHIELD=1, INVTYPE_HOLDABLE=1 },
	[18] = { name="RangedSlot", swappable=1, INVTYPE_RANGED=1, INVTYPE_THROWN=1, INVTYPE_RANGEDRIGHT=1 },
	[19] = { name="TabardSlot", INVTYPE_TABARD=1 },
}

--[[ Initialization ]]

function Rack.Initialize()

	for i=0,19 do Rack.SwapList[i]={} end -- create blank SwapList table
	for i=-2,10 do Rack.LockList[i]={} end -- create a blank Locked table

	if not Rack_User then
		Rack_User = {}
		Rack.ConvertOldSets()
	end

	if not Rack_User[user] then
		Rack_User[user] = { Sets={}, CurrentSet=nil }
	end

	Rack_User[user].Sets["Rack-CombatQueue"] = {}
	for i=0,19 do
		Rack_User[user].Sets["Rack-CombatQueue"][i] = { id=nil, name=nil }
	end

	-- note: these timers are added to a pool, they don't affect processing time unless started
	Rack.CreateTimer("WaitToIterate",Rack.IterateWait,1) -- itemlock iterate pause
	Rack.CreateTimer("IconDragging",Rack.IconDragging,0,1) -- minimap button dragging
	Rack.CreateTimer("ScaleUpdate",Rack.ScaleUpdate,.1,1) -- scaling
	Rack.CreateTimer("TooltipUpdate",Rack.TooltipUpdate,1,1) -- tooltip update
	Rack.CreateTimer("ControlFrame",Rack.ControlFrame,.75,1) -- controls on bar
	Rack.CreateTimer("CooldownUpdate",ItemRack_CooldownUpdate_OnUpdate,1,1) -- cooldown/notify
	Rack.CreateTimer("MenuFrame",Rack.MenuFrame,.25,1) -- menu mouseover check
	Rack.CreateTimer("InvUpdate",ItemRack_InvUpdate_OnUpdate,.25,1) -- inventory throttle
end

function Rack.OnEvent()

	if event=="ITEM_LOCK_CHANGED" then
		Rack.OnItemLockChanged()
	elseif (event=="PLAYER_REGEN_ENABLED" or event=="PLAYER_UNGHOST" or event=="PLAYER_ALIVE") and (not Rack.IsPlayerReallyDead() and not UnitAffectingCombat("player")) then
		-- player is coming out of combat or being res'ed.  EquipSet the CombatQueue
		local somethingQueued
		for i=0,19 do
			if Rack.CombatQueue[i] then
				Rack_User[user].Sets["Rack-CombatQueue"][i].id=Rack.CombatQueue[i]
				Rack.CombatQueue[i] = nil
				somethingQueued = 1
			else
				Rack_User[user].Sets["Rack-CombatQueue"][i].id = nil
				Rack_User[user].Sets["Rack-CombatQueue"][i].name = nil
			end
			getglobal("ItemRackInv"..i.."Queue"):Hide()
			getglobal(ItemRack.Indexes[i].paperdoll_slot.."Queue"):Hide()
		end
		if somethingQueued then
			Rack.EquipSet("Rack-CombatQueue")
		end
	end
end

--[[ Item information ]]

-- returns itemTexture, itemID, itemName, itemSlot of an item in container(bag,slot) or inventory("player",bag)
function Rack.GetItemInfo(bag,slot)
	local i,j,id,itemLink,itemID,itemSlot,itemTexture,itemName

	if slot then -- this is a container item
		itemLink = GetContainerItemLink(bag,slot)
	else
		itemLink = GetInventoryItemLink("player",bag)
	end

	if itemLink then
		_,_,id = string.find(itemLink,"(item:%d+:%d+:%d+:%d+)")
		_,_,itemID = string.find(id or "","item:(%d+:%d+:%d+):%d+")
		itemName,_,_,_,_,_,_,itemSlot,itemTexture = GetItemInfo(id)
	elseif not slot then -- if no link and this is an inventory slot, missing or ammo
		_,itemTexture = GetInventorySlotInfo(Rack.SlotInfo[bag].name) -- get paperdoll texture
		itemID = 0 -- assume empty slot
		if bag==0 then -- this is an ammo slot
			local ammoTexture = GetInventoryItemTexture("player",0)
			if ammoTexture then
				Rack_TooltipScan:SetInventoryItem("player",0)
				itemName = Rack_TooltipScanTextLeft1:GetText()
				for i=0,4 do -- look through containers to get itemID of this ammo
					for j=1,GetContainerNumSlots(i) do
						if itemName==Rack.GetContainerItemName(i,j) then
							_,itemID,_,itemSlot = Rack.GetItemInfo(i,j)
							i,j = 99,99
						end
					end
				end
				itemTexture = ammoTexture
			end
		end
	end

	return itemTexture, itemID, itemName, itemSlot
end

-- returns the name of an item in bag,slot
function Rack.GetContainerItemName(bag,slot)
	local _,_,name = string.find(GetContainerItemLink(bag,slot) or "","%[(.+)%]")
	return name
end

-- converts a name to an itemID by searching through inventory, bags and bank for the item
function Rack.GetItemID(itemName)

	local inv,bag,slot = Rack.FindItem(nil,itemName)
	local itemID

	if inv then
		_,itemID = Rack.GetItemInfo(inv)
	elseif bag and slot then
		_,itemID = Rack.GetItemInfo(bag,slot)
	end

	return itemID
end

-- returns the name and texture of an item by its itemID
function Rack.GetNameByID(itemID)
	local name,texture
	local _,_,id = string.find(itemID or "","(%d+):%d+:%d+")
	name,_,_,_,_,_,_,_,texture = GetItemInfo(id or "")
	if itemID==0 then
		name = "(empty)"
		texture = "Interface\\PaperDoll\\UI-Backpack-EmptySlot"
	end
	return name,texture
end

-- returns true if the bagid (0-4) is a normal "Container", as opposed to quivers and ammo pouches
function Rack.ValidBag(bagid)

	local linkid,bagtype,legal

	if bagid==0 or bagid==-1 then
		legal = true
	else
		local invID = ContainerIDToInventoryID(bagid)
		_,_,linkid = string.find(GetInventoryItemLink("player",invID) or "","item:(%d+)")
		if linkid then
			_,_,_,_,_,bagtype = GetItemInfo(linkid)
			if bagtype==ItemRackText.INVTYPE_CONTAINER then -- "Bag" for enUS clients, "Container" for other clients
				legal = true -- this is a true container
			end
		end
	end

	return legal
end

function Rack.FindSpaceInBag(bag)
	if Rack.ValidBag(bag) then
		for j=1,GetContainerNumSlots(bag) do
			if not Rack.LockList[bag][j] and not GetContainerItemLink(bag,j) then
				return j
			end
		end
	end
end

-- pass a value for bank to find a free bank slot
function Rack.FindSpace(bank)
	local slot
	if bank and ItemRack.BankIsOpen then -- search bank
		for _,i in ItemRack.BankSlots do
			slot = Rack.FindSpaceInBag(i)
			if slot then
				Rack.LockList[i][slot] = 1
				return i,slot
			end
		end
	else
		for i=4,0,-1 do
			slot = Rack.FindSpaceInBag(i)
			if slot then
				Rack.LockList[i][slot] = 1
				return i,slot
			end
		end
	end
end

-- clears locks on all bag slots
function Rack.ClearLockList(bag,slot)
	if not bag then
		for i=-2,10 do
			for j in Rack.LockList[i] do
				Rack.LockList[i][j] = nil
			end
		end
	else
		Rack.LockList[bag][slot] = nil
	end
end

-- returns inv,bag,slot of an itemID, or itemName if itemID doesn't exist
function Rack.FindItem(itemID,itemName,passive)

	local bagStart,bagEnd,i,j,id,name = 0,4
	local inv,bag,slot

	if itemID then

		for i=bagStart,bagEnd do -- check bags for itemID
			for j=1,GetContainerNumSlots(i) do
				if not Rack.LockList[i][j] or passive then
					_,id = Rack.GetItemInfo(i,j)
					if id==itemID then
						bag,slot = i,j
						i,j = 99,99
					end
				end
			end
		end

		if not bag then
			for i=0,19 do -- if not in bags, check on person for itemID
				if not Rack.LockList[-2][i] or passive then
					_,id = Rack.GetItemInfo(i)
					if id==itemID then
						inv = i
						i = 99
					end
				end
			end
		end
	end

	-- if an exact itemID match wasn't found, search by name
	if not inv and not bag and not slot then
		itemName = itemName or Rack.GetNameByID(itemID)
		if itemName then

			for i=bagStart,bagEnd do -- check bags for itemID
				for j=1,GetContainerNumSlots(i) do
					if not Rack.LockList[i][j] or passive then
						_,_,name = Rack.GetItemInfo(i,j)
						if name==itemName then
							bag,slot = i,j
							i,j = 99,99
						end
					end
				end
			end

			if not bag then
				for i=0,19 do -- check on person for itemName
					if not Rack.LockList[-2][i] or passive then
						_,_,name = Rack.GetItemInfo(i)
						if name==itemName then
							inv = i
							i = 99
						end
					end
				end
			end
		end
	end

	return inv,bag,slot
end

-- performs a FindItem on a set entry ([0]-[19]) and updates itemid if one wasn't there
function Rack.FindSetItem(setslot)
	local inv,bag,slot = Rack.FindItem(setslot.id,setslot.name)
	if not setslot.id and setslot.name and (inv or bag or slot) then
		setslot.id = Rack.GetItemID(setslot.name)
	end
	return inv,bag,slot
end

function Rack.InvToInvSwap(inv1,inv2)

	local swap = Rack.SwapList

	if swap[inv1].sourceInv==inv2 and swap[inv2].sourceInv==inv1 then
		PickupInventoryItem(inv1)
		PickupInventoryItem(inv2)
		Rack.ClearSwapListEntry(inv1)
		Rack.ClearSwapListEntry(inv2)
	end
end


--[[ Queue maintenance

	To prevent garbage creation in creating/destroying multi-level tables, queue entries are reused and only
	the index to that queue entry is created/destroyed.

	.SwapQueue is where the tables sit, indexed arbitrarily by the first available one returned by GetFreeQueueEntry
	.SwapQueueOrder is a numerically-indexed table of indexes into .SwapQueue in the order the swap should happen
]]

Rack.SwapQueue = { [1]={ direction = "END" } } -- numerically-indexed queue of swaps to perform
Rack.SwapQueueOrder = {} -- numerically-indexed queue of numbers in the order they're to be performed

-- wipes out an entry without creating garbage
function Rack.ClearQueueEntry(idx)

	Rack.SwapQueue[idx].direction = nil
	Rack.SwapQueue[idx].setname = nil
	for i=0,19 do
		Rack.SwapQueue[idx][i].id = nil
		Rack.SwapQueue[idx][i].fromBag = nil
		Rack.SwapQueue[idx][i].fromSlot = nil
	end
end

-- creates a new table and sub-table queue entries, only call when entry didn't exist before
function Rack.ConstructQueueEntry(idx)
	Rack.SwapQueue[idx] = {}
	for i=0,19 do
		Rack.SwapQueue[idx][i] = {}
	end
end

-- get first available index into SwapQueue for use for a set. to avoid garbage creation these are reused
function Rack.GetFreeQueueEntry()
	local i,found = 1,1

	while found do
		found = Rack.SwapQueue[i]
		if found and not found.direction then
			return i
		end
		i = i + 1
	end
	i = i - 1 -- backtrack to last available entry

	Rack.ConstructQueueEntry(i)
	return i
end

-- adds the .SwapQueue idx to the end of the QueueOrder
function Rack.AddQueueEntry(idx)
	table.insert(Rack.SwapQueueOrder,idx)
end

-- removes the .SwapQueue idx from QueueOrder and clears the .SwapQueue entry
function Rack.RemoveQueueEntry(idx)
	for i=1,table.getn(Rack.SwapQueueOrder) do
		if Rack.SwapQueueOrder[i]==idx then
			table.remove(Rack.SwapQueueOrder,i)
			Rack.ClearQueueEntry(idx)
			return
		end
	end
end

-- this sorts the queue, moving all NEWSETs to the end
function Rack.SortQueue()

	if table.getn(Rack.SwapQueueOrder)>1 then
		local found,temp = 1
		local queue = Rack.SwapQueueOrder
		-- simple shell sort (this is a small, 5-6 max typically) table of indexes that must remain in order otherwise
		while found do
			found = nil
			for i=1,(table.getn(queue)-1) do
				if Rack.SwapQueue[queue[i]].direction=="NEWSET" and Rack.SwapQueue[queue[i+1]].direction~="NEWSET" then
					temp = queue[i]
					queue[i] = queue[i+1]
					queue[i+1] = temp
					found = 1
				end
			end
		end
	end
end

--[[ Set Maintenance

	Sets are tables in Rack_User[user].Sets[setname] structured as:
	{ hide=1/nil, icon="Interface\\Icons\\etc", ["0"]={id=string,name=string,old=string} }
	id = itemID for the item to wear in the set, 0 for (empty) (can be nil)
	name = name of the item to wear in the set, (empty) for empty
	old = itemID for the item worn in this slot prior to this set equipped, usually nil
]]

-- this converts all sets from ItemRack_Users
function Rack.ConvertOldSets()

	local old,new

	DEFAULT_CHAT_FRAME:AddMessage("Performing one-time conversion of ItemRack sets.")
	for u in ItemRack_Users do
		if not Rack_User[u] then
			Rack_User[u] = { Sets={} }
		end
		Rack_User[u].CurrentSet = ItemRack_Users[u].CurrentSet
		for sets in ItemRack_Users[u].Sets do
			if not Rack_User[u].Sets[sets] then
				Rack_User[u].Sets[sets] = {}
			end
			old = ItemRack_Users[u].Sets[sets]
			new = Rack_User[u].Sets[sets]

			for i=0,19 do
				if old[i] then
					new[i] = { name=old[i] }
					if old[i]=="(empty)" then
						new[i].id = 0
					else
						new[i].id = Rack.GetItemID(old[i]) or nil
					end
				end
			end
			new.icon = old.icon
			new.hide = old.hide
			new.key = old.key
			new.keyindex = old.keyindex
		end
	end
end

function Rack.ClearSwapListEntry(idx)
	Rack.SwapList[idx].needsSwap = nil
	Rack.SwapList[idx].sourceInv = nil
	Rack.SwapList[idx].sourceBag = nil
	Rack.SwapList[idx].sourceSlot = nil
	Rack.SwapList[idx].direction = nil
	Rack.SwapList[idx].desiredName = nil
	Rack.SwapList[idx].needsEmptied = nil
end

-- returns the currently worn set, or last set worn
function Rack.CurrentSet()
	return Rack_User[user].CurrentSet
end

--[[ EquipSet
	This function takes a setname and then equips the set, saving what it's replacing within the set.
]]

function Rack.EquipSet(setname)

	local i,bag,slot,id,swap,idx
	local mustWait -- flag that this swap must happen in stages (INV needs to move out of the way)
	local set = Rack_User[user].Sets[setname]
	local hasTWOHAND, hasINVTOBAG, hasINVTOINV, hasBAGTOINV, hasAMMO
	local missing = "ItemRack could not find: "
	local invStart,invEnd = 1,19 -- changes to 16,18 if in combat

	if not set then
		DEFAULT_CHAT_FRAME:AddMessage("Rack: Set \""..setname.."\" doesn't exist.")
		return
	end

	if Rack.IsSetEquipped(setname) then
		if not string.find(setname,"^Rack-") and not string.find(setname,"^ItemRack") then
			Rack_User[user].CurrentSet = setname
		end
		Rack.StartTimer("InvUpdate")
		return
	end

	Rack.ClearLockList()

	if Rack.SetSwapping==setname then
		Rack.OnItemLockChanged() -- if trying to swap this already, move along in queue
		return
	end

	if (Rack.SetSwapping or Rack.IsPlayerReallyDead()) and not UnitAffectingCombat("player") then
		-- come back later, an EquipSet is in progress
		idx = Rack.GetFreeQueueEntry()
		Rack.AddQueueEntry(idx)
		Rack.SwapQueue[idx].direction = "NEWSET"
		Rack.SwapQueue[idx].setname = setname
		return
	end

	-- pre-scan for items that don't need to move
	for i=0,19 do
		_,id = Rack.GetItemInfo(i)

		if set[i] and (set[i].id or set[i].name) then
			Rack.FindSetItem(set[i])
			if set[i].id==id then
				Rack.LockList[-2][i] = 1
			else
				set[i].old = id -- store what was there previously
			end
		end
		Rack.ClearSwapListEntry(i)
	end

	if UnitAffectingCombat("player") then -- player is in combat
		for i=1,19 do
			if set[i] and set[i].id and not Rack.SlotInfo[i].swappable then
				Rack.AddToCombatQueue(i,set[i].id)
			end
		end
		invStart,invEnd = 16,18 -- restrict swap to weapons only
	elseif Rack.IsPlayerReallyDead() then -- player is dead
		for i=0,19 do
			if set[i] and set[i].id then
				Rack.AddToCombatQueue(i,set[i].id)
			end
		end
		return
	end

	-- determine what needs swapped and populate Rack.SwapList
	-- skipping ammo slot the black sheep of inventory slots
	for i=invStart,invEnd do
		if set[i] and set[i].id then
			_,id = Rack.GetItemInfo(i)
			if id~=set[i].id then
				swap = Rack.SwapList[i]
				swap.needsSwap = 1
				swap.desiredName = Rack.GetNameByID(set[i].id)
				if set[i].id==0 then -- empty slot
					swap.direction="INVTOBAG"
					swap.needsEmptied = 1
					hasINVTOBAG = 1
				else
					inv,bag,slot = Rack.FindSetItem(set[i])
					if inv then -- found it in another inventory slot
						Rack.LockList[-2][inv] = 1
						_,_,_,sourceEquipSlot = Rack.GetItemInfo(inv)
						_,_,_,destEquipSlot = Rack.GetItemInfo(i)
						swap.direction="INVTOINV" -- if the item can exist in both slots
						swap.sourceInv = inv
						hasINVTOINV = 1
						if destEquipSlot and sourceEquipSlot and not (Rack.SlotInfo[i][sourceEquipSlot] and Rack.SlotInfo[inv][destEquipSlot]) then
							swap.needsEmptied = 1
							hasINVTOBAG = 1
						end
					elseif bag and slot then -- found it in a bag slot
						Rack.LockList[bag][slot] = 1
						swap.direction="BAGTOINV"
						swap.sourceBag = bag
						swap.sourceSlot = slot
						if i==16 then -- this is a mainhand weapon
							_,_,_,slot = Rack.GetItemInfo(swap.sourceBag,swap.sourceSlot)
							if slot=="INVTYPE_2HWEAPON" and GetInventoryItemLink("player",17) then
								hasTWOHAND = 1 -- flag a 2h swap in this set if there's an offhand equipped
								if not set[17] then
									set[17] = {}
								end
								set[17].id = 0
								Rack.SwapList[17].needsEmptied = 1
							end
						end
						hasBAGTOINV = 1
					else -- couldn't find it
						missing = missing..tostring(swap.desiredName)..", "
						swap.needsSwap = nil
					end
				end
			end
		elseif set[i] and set[i].name then -- item has no id yet, not seen since conversion
			missing = missing..tostring(set[i].name)..", "
		end
	end

	if missing~="ItemRack could not find: " then
		DEFAULT_CHAT_FRAME:AddMessage(string.gsub(missing,", $",""))
	end

	-- at this stage, Rack.SwapList[0]-[19] is populated

	-- INVTOBAG and .needsEmptied swaps first
	if hasINVTOBAG then
		idx = Rack.GetFreeQueueEntry()
		Rack.AddQueueEntry(idx)
		Rack.SwapQueue[idx].direction = "INVTOBAG"
		Rack.SwapQueue[idx].setname = setname
		for i=0,19 do
			if Rack.SwapList[i].needsEmptied then
				Rack.SwapQueue[idx][i].id = 0
			end
		end
	end

	-- INVTOINV swaps next
	if hasINVTOINV then
		idx = Rack.GetFreeQueueEntry()
		Rack.AddQueueEntry(idx)
		Rack.SwapQueue[idx].direction = "INVTOINV"
		Rack.SwapQueue[idx].setname = setname
		for i=0,19 do
			if Rack.SwapList[i].direction=="INVTOINV" then
				Rack.SwapQueue[idx][i].id = set[i].id
				Rack.SwapQueue[idx][i].fromSlot = Rack.SwapList[i].sourceInv
			end
		end
	end

	-- BAGTOINV swaps last (90% of swaps this is only bit that queues)
	if hasBAGTOINV then
		idx = Rack.GetFreeQueueEntry()
		Rack.AddQueueEntry(idx)
		Rack.SwapQueue[idx].direction = "BAGTOINV"
		Rack.SwapQueue[idx].setname = setname
		for i=0,19 do
			if Rack.SwapList[i].direction=="BAGTOINV" then
				Rack.SwapQueue[idx][i].id = set[i].id
				Rack.SwapQueue[idx][i].fromBag = Rack.SwapList[i].sourceBag
				Rack.SwapQueue[idx][i].fromSlot = Rack.SwapList[i].sourceSlot
			end
		end
	end

	-- now deal with ammo why oh why can't this slot be normal
	-- perform ammo swaps directly. since it never takes up a new bag slot it's ok to do pickups and move on
	if set[0] and set[0].id then
		_,id = Rack.GetItemInfo(0)
		if id~=set[0].id then
			if set[0].id==0 then -- unequip ammo
				bag,slot = Rack.FindSpace()
				if bag then
					PickupInventoryItem(0)
					PickupContainerItem(bag,slot)
				end
			else
				_,bag,slot = Rack.FindSetItem(set[0])
				if bag then
					PickupContainerItem(bag,slot)
					PickupInventoryItem(0)
				end
			end
		end
	end

	Rack_User[user].Sets[setname].oldsetname = Rack_User[user].CurrentSet

	if Rack_User[user].Sets[setname].showhelm then
		ShowHelm(Rack_User[user].Sets[setname].showhelm)
	end
	if Rack_User[user].Sets[setname].showcloak then
		ShowCloak(Rack_User[user].Sets[setname].showcloak)
	end

	-- at last, perform the swaps by iterating over the queue
	Rack.IterateSwapQueue()

end

-- waits for some timed reason to do another iteration. for now just to check SpellIsTargeting once a second
function Rack.IterateWait()

	if SpellIsTargeting() or CursorHasItem() then
		Rack.StartTimer("WaitToIterate",1)
	else
		Rack.StopTimer("WaitToIterate")
		Rack.IterateSwapQueue()
	end
end

function Rack.ShutdownQueue()
	RackFrame:UnregisterEvent("ITEM_LOCK_CHANGED")
	Rack.SetSwapping = nil
	for i=1,table.getn(Rack.SwapQueueOrder) do
		Rack.RemoveQueueEntry(Rack.SwapQueueOrder[i])
	end
end

-- this function grabs the next swap QueueEntry and performs the swap
-- swaps only happen one direction at a time: INVTOBAG->INVTOINV->BAGTOINV
-- complex swaps can require running this a few times
function Rack.IterateSwapQueue()

	if table.getn(Rack.SwapQueueOrder)<1 then
		-- if queue is empty, unregister and leave
		Rack.SetSwapping = nil
		RackFrame:UnregisterEvent("ITEM_LOCK_CHANGED")
		return
	
	elseif SpellIsTargeting() or CursorHasItem() then
		-- check if in Spell Targeting mode to prevent disenchants/enchants
		Rack.StartTimer("WaitToIterate")
		return

	elseif Rack.IsPlayerReallyDead() then
		-- if player is dead, they can't swap anything, leave for now
		return

	else

		Rack.SortQueue() -- move NEWSETs to end of queue

		local bag,slot,id
		local idx = Rack.SwapQueueOrder[1]
		local queue = Rack.SwapQueue[idx]

		if queue.direction == "NEWSET" then
			Rack.SetSwapping = nil
			local setname = queue.setname
			Rack.RemoveQueueEntry(idx)
			RackFrame:UnregisterEvent("ITEM_LOCK_CHANGED")
			Rack.EquipSet(setname)

		else

			-- something to process
			RackFrame:RegisterEvent("ITEM_LOCK_CHANGED")

			Rack.SetSwapping = Rack.SwapQueue[idx].setname

			Rack.ClearLockList()

			if queue.direction == "INVTOBAG" then
				for i=0,19 do
					if queue[i].id==0 then
						bag,slot = Rack.FindSpace()
						if bag then
							queue[i].fromBag = bag
							queue[i].fromSlot = slot
							PickupInventoryItem(i)
							PickupContainerItem(bag,slot)
						else
							Rack.NoMoreRoom()
							queue[i].id = nil
							queue[i].fromBag = nil
							queue[i].fromSlot = nil
							Rack.ShutdownQueue() -- we ran out of room, stop all swaps now
						end
					end
				end
			elseif queue.direction == "INVTOINV" then
				for i=0,19 do
					if queue[i].fromSlot then
						PickupInventoryItem(queue[i].fromSlot)
						PickupInventoryItem(i)
					end
				end
			elseif queue.direction == "BAGTOINV" then
				for i=0,19 do
					if queue[i].fromBag then
						_,id = Rack.GetItemInfo(queue[i].fromBag,queue[i].fromSlot)
						if id == queue[i].id then
							PickupContainerItem(queue[i].fromBag,queue[i].fromSlot)
							PickupInventoryItem(i)
						else
							-- didn't find it at same bag spot when queued
							_,bag,slot = Rack.FindSetItem(queue[i])
							if bag then
								queue[i].fromBag = bag
								queue[i].fromSlot = slot
								PickupContainerItem(bag,slot)
								PickupInventoryItem(i)
							else
								queue[i].id = nil -- forget we tried
								queue[i].fromBag = nil
								queue[i].fromSlot = nil
							end
						end
					end
				end
			end
		end
	end

end

--[[ Debug ]]--

function Rack.PrintSet(setname)

	local i,j
	for i=0,19 do
		j=Rack_User[user].Sets[setname]
		if j and j[i] then DEFAULT_CHAT_FRAME:AddMessage(Rack.SlotInfo[i].name..": "..tostring(j[i].id).." : "..tostring(Rack.GetNameByID(j[i].id)).." old:"..tostring(j[i].old)) end
	end
end

function Rack.PrintQueue()

	local txt = ""

	local function debug(msg)
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end

	debug("__ Rack.PrintQueue() __")
	debug("table.getn(Rack.SwapQueueOrder)="..tostring(table.getn(Rack.SwapQueueOrder)))
	txt = "Rack.SwapQueueOrder = { "
	for i=1,table.getn(Rack.SwapQueueOrder) do
		txt = txt.."["..i.."]="..tostring(Rack.SwapQueueOrder[i])..", "
	end
	txt = txt.."}"
	debug(txt)
	txt = "Rack.SwapQueue = { "
	for i in Rack.SwapQueue do
		txt = txt.."["..i.."]= { direction="..tostring(Rack.SwapQueue[i].direction)..", "
		txt = txt.."setname="..tostring(Rack.SwapQueue[i].setname)..", "
		for j=0,19 do
			if Rack.SwapQueue[i][j] and Rack.SwapQueue[i][j].id then
				txt = txt.."["..j.."]="..Rack.SwapQueue[i][j].id..", "
				txt = txt.."fromBag="..tostring(Rack.SwapQueue[i][j].fromBag)..", "
				txt = txt.."fromSlot="..tostring(Rack.SwapQueue[i][j].fromSlot)..", "
			end
		end
		txt = txt .."} "
	end
	txt = txt.."}"
	debug(txt)

end

--[[ Locks ]]--

-- returns true if anything is locked
function Rack.AnyLocked()

	local locked,isLocked

	for i=0,19 do
		if IsInventoryItemLocked(i) then
			locked = 1
			i = 99
		end
	end

	if not locked then
		for i=0,4 do
			for j=1,GetContainerNumSlots(i) do
				_,_,isLocked = GetContainerItemInfo(i,j)
				if isLocked then
					locked = 1
					i,j=99,99
				end
			end
		end
	end

	return locked
end

-- when an iteration begins, on each ITEM_LOCK_CHANGED check if the swaps are done
-- if so, remove the current queue entry and go to the next one
-- this is where swaps end
function Rack.OnItemLockChanged()

	if not Rack.SwapQueueOrder[1] then
		Rack.SetSwapping = nil
		RackFrame:UnregisterEvent("ITEM_LOCK_CHANGED")
		return
	end

	if not Rack.AnyLocked() then
		local setname = Rack.SwapQueue[Rack.SwapQueueOrder[1]].setname
		if not string.find(setname,"^Rack-") and not string.find(setname,"^ItemRack") then
			Rack_User[user].CurrentSet = setname
		end
		Rack.RemoveQueueEntry(Rack.SwapQueueOrder[1])
		Rack.IterateSwapQueue()
	end	
end

--[[ Combat/Death Queue Processing ]]

function Rack.IsPlayerReallyDead()
	local dead = UnitIsDeadOrGhost("player")
	local _,class = UnitClass("player")
	if class~="HUNTER" then
		return dead
	end
	for i=1,24 do
		if UnitBuff("player",i)=="Interface\\Icons\\Ability_Rogue_FeignDeath" then
			dead = nil -- player is just FD, not really dead
		end
	end
	return dead
end

-- adds an item 'id' to 'slot' queue for post-combat/death swap
function Rack.AddToCombatQueue(slot,id)
	local button = getglobal("ItemRackInv"..slot.."Queue")
	local paperdoll = getglobal(ItemRack.Indexes[slot].paperdoll_slot.."Queue")
	local _,wornId = Rack.GetItemInfo(slot)
	if Rack.CombatQueue[slot]==id or id==wornId then
		Rack.CombatQueue[slot] = nil
		button:Hide()
		paperdoll:Hide()
	elseif id and id~=wornId then
		Rack.CombatQueue[slot] = id
		local _,texture = Rack.GetNameByID(id)
		button:SetTexture(texture)
		button:Show()
		paperdoll:SetTexture(texture)
		paperdoll:Show()
	end
end

--[[ EquipSet wrappers ]]--

-- returns true if the entire set is currently worn
function Rack.IsSetEquipped(setname)

	local set,missing,id = Rack_User[user].Sets[setname or ""]

	if set then
		for i=0,19 do
			if set[i] then
				-- if item queued, check queued item instead of GetItemInfo
				if Rack.CombatQueue[i] then
					id = Rack.CombatQueue[i]
				else
					_,id = Rack.GetItemInfo(i)
				end
				if set[i].id ~= id then
					missing = 1
				end
			end
		end
	end
	return set and not missing
end

-- equips a set if it's worn, unequips it if not
function Rack.ToggleSet(setname)

	if Rack_User[user].Sets[setname or ""] then
		if Rack.IsSetEquipped(setname) then
			Rack.UnequipSet(setname)
		else
			Rack.EquipSet(setname)
		end
	end
end

-- This function creates a set of all the items replaced by setname, and then does does an .EquipSet()
function Rack.UnequipSet(setname)

--	if not Rack.IsSetEquipped(setname) then
--		return
--	end

	local unequip_setname = "Rack-Unequip-"..setname
	Rack_User[user].Sets[unequip_setname] = {}
	local old = Rack_User[user].Sets[setname]
	local new = Rack_User[user].Sets[unequip_setname]

	for i=0,19 do
		if old[i] and old[i].old then
			new[i] = { id=old[i].old }
			old[i].old = nil -- comment this line when a mechanism to catch enchant changes
		end
	end

	Rack.EquipSet(unequip_setname)
	if old.oldsetname and not string.find(old.oldsetname,"^Rack") and not string.find(old.oldsetname,"^ItemRack") then
		Rack_User[user].CurrentSet = Rack_User[user].Sets[setname].oldsetname
	end
	Rack_User[user].Sets[setname].oldsetname = nil
end

--[[ Timer maintenance

	The goal is to reduce the processing of timer checks to as little as possible.  One OnUpdate is a central
	repository of this mod's timers.
]]


function Rack.CreateTimer(name,func,limit,rep)
	Rack.TimerPool[name] = { func=func, limit=limit, timer=limit, rep=rep, enabled=nil }
end

function Rack.StartTimer(name,timer)
	Rack.TimerPool[name].timer = timer or Rack.TimerPool[name].limit
	Rack.TimerPool[name].enabled = 1
	RackFrame:Show()
end

function Rack.StopTimer(name)
	Rack.TimerPool[name].enabled = nil
	Rack.ClearStoppedTimers()
end

function Rack.ClearStoppedTimers()
	local stuffLeft
	for i in Rack.TimerPool do
		stuffLeft = stuffLeft or Rack.TimerPool[i].enabled
	end
	if not stuffLeft then
		RackFrame:Hide()
	end
end

function Rack.TimerEnabled(name)
	if Rack.TimerPool[name] and Rack.TimerPool[name].enabled then
		return 1
	else
		return nil
	end
end

function Rack.OnUpdate()

	local clock,stopped
	local elapse = tonumber(arg1) or 0.1

	for i in Rack.TimerPool do
		clock = Rack.TimerPool[i]
		if clock.enabled then
			clock.timer = clock.timer - elapse
			if clock.timer<0 then
				if clock.rep then
					clock.timer = clock.limit -- rewind to start if 'rep' set
				else
					clock.enabled = nil
					stopped = 1
				end
				clock.func()
			end
		end
	end
	if stopped then
		Rack.ClearStoppedTimers()
	end

end

--[[ old OnUpdates : now gathered under Rack.Timers ]]

-- formerly ItemRack_IconDraggingFrame_OnUpdate
function Rack.IconDragging()
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/Minimap:GetEffectiveScale()+70
	ypos = ypos/Minimap:GetEffectiveScale()-ymin-70

	ItemRack_Settings.IconPos = math.deg(math.atan2(ypos,xpos))
	move_icon()
end
ItemRack_IconDraggingFrame_OnUpdate = Rack.IconDragging -- legacy

-- formerly ItemRack_ScaleUpdate_OnUpdate
function Rack.ScaleUpdate()
	local frame = ItemRack.FrameToScale
	local oldscale = frame:GetEffectiveScale()
	local framex, framey, cursorx, cursory = frame:GetLeft()*oldscale, frame:GetTop()*oldscale, GetCursorPosition()

	if (cursorx-framex)>32 then
		local newscale = (cursorx-framex)/ItemRack.ScalingWidth
		ItemRack_ScaleFrame(newscale)
	end
end

-- formerly ItemRack_TooltipUpdate_OnUpdate
function Rack.TooltipUpdate()
	if ItemRack.TooltipType then

		local cooldown

		set_tooltip_anchor(ItemRack.TooltipOwner)

		if ItemRack.TooltipType=="BAG" then
			if ItemRack.TooltipBag==-1 then
				local _,_,id = string.find(GetContainerItemLink(ItemRack.TooltipBag,ItemRack.TooltipSlot) or "","item:(%d+)")
				if id then
					_,id = GetItemInfo(id)
					if id then
						-- :SetBagItem doesn't appear to work for -1 bank slot
						GameTooltip:SetHyperlink(id)
					end
				end
			else
				GameTooltip:SetBagItem(ItemRack.TooltipBag,ItemRack.TooltipSlot)
			end
			cooldown = GetContainerItemCooldown(ItemRack.TooltipBag,ItemRack.TooltipSlot)
			if ItemRack_Settings.TinyTooltip=="ON" and not IsAltKeyDown() then
				shrink_tooltip()
			end
		elseif ItemRack.TooltipType=="INVENTORY" then
			GameTooltip:SetInventoryItem("player",ItemRack.TooltipSlot)
			cooldown = GetInventoryItemCooldown("player",ItemRack.TooltipSlot)
			if ItemRack_Settings.TinyTooltip=="ON" and not IsAltKeyDown() then
				shrink_tooltip()
			end
			if ItemRack.TooltipBag then
				GameTooltip:AddLine(string.format(ItemRackText.QUEUED,ItemRack.TooltipBag))
			end
		end
		GameTooltip:Show()
		if cooldown==0 then
			-- stop updates if this item has no cooldown
			Rack.StopTimer("TooltipUpdate")
		end
	end
end

-- formerly ItemRack_ControlFrame_OnUpdate
function Rack.ControlFrame()
	if ItemRack_Users[user].Locked=="ON" and not IsAltKeyDown() then
		Rack.StopTimer("ControlFrame")
		ItemRack_ControlFrame:Hide()
	end
end

Rack.MenuFrameSources = { "ItemRack_InvFrame", "ItemRack_MenuFrame", "ItemRack_IconFrame",
						  "TitanPanelItemRackButton" }

-- formerly ItemRack_MenuFrame_OnUpdate
function Rack.MenuFrame()

	local over,frame
	
	for i=1,table.getn(Rack.MenuFrameSources) do
		frame = getglobal(Rack.MenuFrameSources[i])
		over = over or (frame and MouseIsOver(frame))
	end

	if MouseIsOver(ItemRack_SetsFrame) and
	  (string.sub(GetMouseFocus():GetName() or "",1,17)=="ItemRack_Sets_Inv") and
	  GetMouseFocus():GetAlpha()>.5 then
		over = 1
	end

	if not over then
		ItemRack_MenuFrame:Hide()
	end
end

--[[ Bank support ]]

function Rack.PopulateBank()
	Rack.UnpopulateBank()
	local itemLink,itemID,itemName,equipLoc
	for i=1,table.getn(ItemRack.BankSlots) do
		for j=1,GetContainerNumSlots(ItemRack.BankSlots[i]) do
			itemLink = GetContainerItemLink(ItemRack.BankSlots[i],j) or ""
			_,_,itemID = string.find(itemLink,"item:(%d+)")
			if itemID then
				itemName,_,_,_,_,_,_,equipLoc = GetItemInfo(itemID)
				if equipLoc and equipLoc~="" then
					ItemRack.BankedItems[itemName] = 1
				end
			end
		end
	end
end

function Rack.UnpopulateBank()
	for i in ItemRack.BankedItems do
		ItemRack.BankedItems[i] = nil
	end
end

function Rack.BankOpened()
	Rack.PopulateBank()
	ItemRack.BankIsOpen = 1
	ItemRackFrame:RegisterEvent("BAG_UPDATE")
end

function Rack.BankClosed()
	ItemRack.BankIsOpen = nil
	ItemRack_MenuFrame:Hide()
	Rack.UnpopulateBank()
	ItemRackFrame:UnregisterEvent("BAG_UPDATE")
end

function Rack.SetHasBanked(setname)
	if not setname or not Rack_User[user].Sets[setname] then return end
	local name,item
	for i=0,19 do
		item = Rack_User[user].Sets[setname][i]
		if item and item.name and ItemRack.BankedItems[item.name] then
			return 1
		end
	end
end

function Rack.FindBankedItem(name)
	for _,i in ItemRack.BankSlots do
		for j=1,GetContainerNumSlots(i) do
			if strfind(GetContainerItemLink(i,j) or "",name,1,1) then
				return i,j
			end
		end
	end
end

function Rack.PullSetFromBank(setname)
	Rack.ClearLockList()
	local set = Rack_User[user].Sets[setname]
	if not set or SpellIsTargeting() or CursorHasItem() then return end
	local bag,slot,freeBag,freeSlot
	for i=0,19 do
		if set[i] then
			if ItemRack.BankedItems[set[i].name] then
				bag,slot = Rack.FindBankedItem(set[i].name)
				if bag then
					freeBag,freeSlot = Rack.FindSpace()
					if freeBag then
						PickupContainerItem(bag,slot)
						PickupContainerItem(freeBag,freeSlot)
					else
						Rack.NoMoreRoom()
						return
					end
				end
			end
		end
	end
end

function Rack.PushSetToBank(setname)
	Rack.ClearLockList()
	local set = Rack_User[user].Sets[setname]
	if not set or SpellIsTargeting() or CursorHasItem() then return end
	local bag,slot,freeBag,freeSlot
	for i=0,19 do
		if set[i] then
			freeBag,freeSlot = Rack.FindSpace(1)
			if freeBag then
				inv,bag,slot = Rack.FindItem(set[i].id,set[i].name)
				if inv then
					PickupInventoryItem(inv)
					PickupContainerItem(freeBag,freeSlot)
				elseif bag then
					PickupContainerItem(bag,slot)
					PickupContainerItem(freeBag,freeSlot)
				end
			else
				Rack.NoMoreRoom()
				return
			end
		end
	end
end

function Rack.NoMoreRoom()
	DEFAULT_CHAT_FRAME:AddMessage("ItemRack: Not enough room to complete the swap.")
end
