

local L = AceLibrary("AceLocale-2.0"):new("Detox")

L:RegisterTranslations("enUS", function() return {

	-- menu/options
	["Clean group"] = true,
	["Will attempt to clean a player in your raid/party."] = true,
	["Play sound if unit needs decursing"] = true,
	["Show detoxing in scrolling combat frame"] = true,
	["This will use SCT5 when available, otherwise Blizzards Floating Combat Text."] = true,
	["Seconds to blacklist"] = true,
	["Units that are out of Line of Sight will be blacklisted for the set duration."] = true,
	["Max debuffs shown"] = true,
	["Defines the max number of debuffs to display in the live list."] = true,
	["Update speed"] = true,
	["Defines the speed the live list is updated, in seconds."] = true,
	["Detaches the live list from the Detox icon."] = true,
	["Show live list"] = true,
	["Options for the live list."] = true,
	["Live list"] = true,

	-- Filtering
	["Filter"] = true,
	["Options for filtering various debuffs and conditions."] = true,
	["Debuff"] = true,
	["Filter by debuff and class."] = true,
	["Classes to filter for: %s."] = true,
	["Toggle filtering %s on %s."] = true,
	["Adds a new debuff to the class submenus."] = true,
	["Add"] = true,
	["Removes a debuff from the class submenus."] = true,
	["Remove %s from the class submenus."] = true,
	["Remove"] = true,
	["<debuff name>"] = true,
	["Filter stealthed units"] = true,
	["It is recommended not to cure stealthed units."] = true,
	["Filter Abolished units"] = true,
	["Skip units that have an active Abolish buff."] = true,
	["Filter pets"] = true,
	["Pets are also your friends."] = true,
	["Filter by type"] = true,
	["Only show debuffs you can cure."] = true,
	["Filter by range"] = true,
	["Only show units in range."] = true,

	-- Priority list
	["Priority"] = true,
	["These units will be priorized when curing."] = true,
	["Show priorities"] = true,
	["Displays who is prioritized in the live list."] = true,
	["Priorities"] = true,
	["Can't add/remove current target to priority list, it doesn't exist."] = true,
	["Can't add/remove current target to priority list, it's not in your raid."] = true,
	["%s was added to the priority list."] = true,
	["%s has been removed from the priority list."] = true,
	["Nothing"] = true,
	["Prioritize %s."] = true,
	["Every %s"] = true,
	["Prioritize every %s."] = true,
	["Groups"] = true,
	["Prioritize by group."] = true,
	["Group %s"] = true,
	["Prioritize group %s."] = true,
	["Class %s"] = true,

	-- bindings
	["Clean group"] = true,
	["Toggle target priority"] = true,
	["Toggle target class priority"] = true,
	["Toggle target group priority"] = true,

	-- spells and potions
	["Dreamless Sleep"] = true,
	["Greater Dreamless Sleep"] = true,
	["Ancient Hysteria"] = true,
	["Ignite Mana"] = true,
	["Tainted Mind"] = true,
	["Magma Shackles"] = true,
	["Cripple"] = true,
	["Frost Trap Aura"] = true,
	["Dust Cloud"] = true,
	["Widow's Embrace"] = true,
	["Curse of Tongues"] = true,
	["Sonic Burst"] = true,
	["Thunderclap"] = true,
	["Delusions of Jin'do"] = true,
	

	["Magic"] = true,
	["Charm"] = true,
	["Curse"] = true,
	["Poison"] = true,
	["Disease"] = true,

	["Cleaned %s"] = true,
	
	["Rank (%d+)"] = true

} end)
