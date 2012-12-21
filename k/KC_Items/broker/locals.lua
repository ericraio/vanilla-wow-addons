KC_ITEMS_LOCALS.modules.broker = {}
local locals = KC_ITEMS_LOCALS.modules.broker

if( not ace:LoadTranslation("KC_Broker") ) then

locals.name			= "KC_Broker"
locals.description	= "Auction Broker"

locals.modes = {}
locals.modes.smart  = "Smart"
locals.modes.memory = "Memory"
locals.modes.mixed  = "Mixed"
locals.modes.vendor = "Vendor"
locals.modes.none	= "None"
locals.modes.all    = format("%s %s %s %s %s", locals.modes.mixed, locals.modes.smart, locals.modes.memory, locals.modes.vendor, locals.modes.none)

locals.labels = {}
locals.labels.guidebase = "%s[Already Known] %s[Vendor Bait] %s[Cheap Buyout] %s[Cheap Bid]"

locals.errors = {}
locals.errors.amount = "The amount entered is invalid. Must be either in percentage format - 95% - or in decimal format - .95"
locals.errors.mode   = "You have entered an invalid mode.  Pleasee type /kci broker autofillmode to get a list of the valid modes."
locals.errors.color  = "Color codes must be entered in as three sets of numbers between 1-255 representing red green blue.  example: 25 25 255 is a dark blue."

locals.msgs = {}
locals.msgs.amount		= "Autofill's Smart Mode's Cut"
locals.msgs.mode		= "Autofill's Mode is"
locals.msgs.autofill	= "Autofill of auction values is"
locals.msgs.remduration = "Rembering last auction duration is"
locals.msgs.skipmem		= "Skipping price memory when using mixed mode is"
locals.msgs.ahcolor		= "Coloring of Auction House items is"
locals.msgs.colorcode   = "%s is now set to %sthis color."

-- Chat handler locals
locals.chat = {
	option	= "broker",
	desc	= "Broker related commands.",
	args	= {
		{
			option = "autofill",
			desc   = "Toggles use of autofill.",
			method = "TogAutofill"
		},
		{
			option = "skipmem",
			desc   = "Toggles if Broker should skip item memory when using mixed mode for autofill.",
			method = "SkipMem"
		},
		{
			option = "setcut",
			desc   = "Sets cut percentage used to adjust smart mode's value.  \n               Must be formatted as either '90%' or as .90.",
			method = "SetCut",
			input  = true,
		},
		{
			option = "autofillmode",
			desc   = "Sets the mode autofill uses to calculate prices.",
			method = "SetMode",
			input  = true,
			args   = {
				{
					option = locals.modes.mixed,
					desc   = "Will attempt to use all other modes in the following sequence: Memory, Smart, Vendor, None.",
				},
				{
					option = locals.modes.memory,
					desc   = "Will only fill in prices if you have sold the item before.  Will still suggest buyout price for items though.",
				},
				{
					option = locals.modes.smart,
					desc   = "Will fill in prices based on market average if auction house data is available; otherwise it will suggest a simple buyout. (requires the Auction module)",
				},
				{
					option = locals.modes.vendor,
					desc   = "Will fill in prices based on what a vendor will pay for it; otherwise it will suggest a simple buyout. (requires the SellValue module)",
				},
				{
					option = locals.modes.none,
					desc   = "Will only suggest a buyout value.",
				},
			}
		},
		{
			option = "remduration",
			desc   = "Toggles if Broker remembers the last auction duration you used.",
			method = "RememberDuration"
		},
		{
			option = "ahcolor",
			desc   = "Toggles if Broker will color code auctions that are a good deal.",
			method = "AHColor"
		},
		{
			option = "setahcolor",
			desc   = "Set the indivdual color codes.",
			args   = {
				{
					option = "known",
					desc   = "The color for recepies that you already know.",
					input  = true,
					method = "SetKnownColor",
				},
				{
					option = "vendor",
					desc   = "The color for items that you can vendor for more money.",
					input  = true,
					method = "SetVendorColor",
				},
				{
					option = "buy",
					desc   = "The color for items whose buyout is less than the threshold precentage.",
					input  = true,
					method = "SetBuyColor",
				},
				{
					option = "min",
					desc   = "The color for items whose min is less than the threshold precentage.",
					input  = true,
					method = "SetMinColor",
				},
			},
		},
	},  
}

end