KC_ITEMS_LOCALS.modules.linkview = {}
local locals = KC_ITEMS_LOCALS.modules.linkview

if( not ace:LoadTranslation("KC_Linkview") ) then

locals.name			= "KC_Linkview"
locals.description	= "Allows you to view your link database."

locals.msg = {}
locals.msg.tooltip = "Tooltip is now set to show on the"

locals.gui = {}
locals.gui.title		= "KC_Linkview"
locals.gui.items		= "Items"
locals.gui.sortopt		= "Sort Options"
locals.gui.searchopt	= "Search Options"
locals.gui.searchtxt	= "Search Text"
locals.gui.search		= "Search"
locals.gui.advsearch	= "Adv Search"
locals.gui.tier1		= "Tier 1"
locals.gui.tier2		= "Tier 2"
locals.gui.tier3		= "Tier 3"
locals.gui.please		= "Please Search"
locals.gui.nothing		= "Nothing Found"

locals.gui.name			= "Name"
locals.gui.quality		= "Quality"
locals.gui.class		= "Class"
locals.gui.type			= "Type"
locals.gui.slot			= "Slot"
locals.gui.level		= "Level"

locals.gui.stats		= "Total Links: %s | Good Links: %s | Matches: %s"

locals.gui.sortlist = {
	{val=locals.gui.name	,tip="Sorts an item by its name."},
	{val=locals.gui.quality	,tip="Sorts an item by its quality."},
	{val=locals.gui.class	,tip="Sorts an item by its class."},
	{val=locals.gui.type	,tip="Sorts an item by its type."},
	{val=locals.gui.slot	,tip="Sorts an item by its slot."},
	{val=locals.gui.level	,tip="Sorts an item by its level."},
}

locals.adv = {}
locals.adv.title		= "Advanced Search"
locals.adv.ext			= "Search Item Suffixes"
locals.adv.options		= "Search Options"
locals.adv.reset		= "Reset"

-- Do not localize cross
locals.adv.cross = {
	Armor			= "Cloth Leather Mail Plate Shields Miscellaneous",
	Container		= "Bag Soul Bag",
	Projectile		= "Arrow Bullet",
	Quiver			= "Quiver Ammo Pouch",
	Recipe			= "Alchemy Blacksmithing Book Cooking Enchanting Engineering First Aid Fishing Leatherworking Tailoring",
	["Trade Goods"] = "Explosives Devices Trade Goods Parts",
	Weapons			= "Bows Crossbows Daggers Fist Weapons Fishing Pole Guns One-Handed Axes One-Handed Maces One-Handed Swords Polearms Staves Thrown Two-Handed Axes Two-Handed Maces Two-Handed Swords Wands",
}

-- Do not localize the translist
locals.gui.translist = {}
locals.gui.translist[locals.gui.name]		= "name"
locals.gui.translist[locals.gui.quality]	= "squality"
locals.gui.translist[locals.gui.class]		= "class"
locals.gui.translist[locals.gui.type]		= "subclass"
locals.gui.translist[locals.gui.slot]		= "location"
locals.gui.translist[locals.gui.level]		= "minlevel"



-- Chat handler locals
locals.chat = {
	option	= "linkview",
	desc	= "Functions relating to the linkview window.",
	args	= {
		{
			option = "open",
			desc   = "Toggles view of the linkview window.",
			method = "show"
		},
		{
			option = "side",
			desc   = "Toggles which side of the linkview window the tooltip will be displayed.",
			method = "side"
		},
	},  
}

end
