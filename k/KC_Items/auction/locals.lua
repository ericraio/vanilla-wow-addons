KC_ITEMS_LOCALS.modules.auction = {}
local locals = KC_ITEMS_LOCALS.modules.auction

if( not ace:LoadTranslation("KC_Auction") ) then

locals.name			= "KC_Auction"
locals.description	= "Keeps Track of Auction Data"

locals.labels = {}
locals.labels.all = "All"
locals.labels.scan = "Scan"
locals.labels.stopscan = "Stop Scan"

locals.labels.min = {}
locals.labels.min.short = "|cff00ffffMin (|r%s|cff00ffff)|r"
locals.labels.min.long  = "|cff00ffffMinBid|r "
locals.labels.buy = {}
locals.labels.buy.short = "|cff00ffffBid (|r%s|cff00ffff)|r"
locals.labels.buy.long	= "|cff00ffffBuyout|r "
locals.labels.bid = {}
locals.labels.bid.short = "|cff00ffffBuy (|r%s|cff00ffff)|r"
locals.labels.bid.long  = "|cff00ffffActual Bid|r "

locals.labels.stats		= "|cff00ffffSeen |r%s|cff00ffff times, in Avg Stacks of |r%s"
locals.labels.header	= "|cff00ffffAuction prices for (|r%s|cff00ffff)"

locals.sep		= "-";
locals.sepcolor = "|cff00ffff";

locals.auction = {}
locals.auction.cantscan  = "Must have the auction house window open during a scan."

locals.auction.base = format(ACE_CMD_RESULT, KC_Items.name, KC_ITEMS_LOCALS.msg.color)
locals.auction.notargets	= format("%s%s", locals.auction.base, "You must have at least one category selected to perform a scan.")
locals.auction.scanning		= format("%s%s", locals.auction.base, "Is currently scanning page %s of %s of the \"%s\" category.")
locals.auction.settingup	= format("%s%s", locals.auction.base, "Is setting up to scan the marked categories.")
locals.auction.done			= format("%s%s", locals.auction.base, "Scanning has been completed.")
locals.auction.canceled		= format("%s%s", locals.auction.base, "Scanning has been cancled.")

locals.msg = {}
locals.msg.short	= "Short display mode"
locals.msg.single	= "Display of single prices"
locals.msg.bid		= "Display of bid price"
locals.msg.stats	= "Display of item's stats"


-- Chat handler locals
locals.chat = {
	option	= "auction",
	desc	= "Auction scanning related commands.",
	args	= {
		{
			option = "short",
			desc   = "Toggles use of the short display mode.",
			method = "short"
		},
		{
			option = "single",
			desc   = "Toggles display of the single price.",
			method = "single"
		},
		{
			option = "showbid",
			desc   = "Toggles display of the bid average.",
			method = "showbid"
		},
		{
			option = "showstats",
			desc   = "Toggles display of the item's stats.",
			method = "showstats"
		},
	},  
}

end
