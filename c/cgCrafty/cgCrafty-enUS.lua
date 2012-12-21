-- Version
cgc.Version = "2.0.14"

-- Locals
cgc.LOCALS = {}
cgc.LOCALS.DESCRIPTION = "Search the craft window for items by name or reagent."

-- Frame Strings
cgc.LOCALS.FRAME_SUBMIT_TEXT = "S"
cgc.LOCALS.FRAME_RESET_TEXT = "R"
cgc.LOCALS.FRAME_NO_RESULTS = "No results matched your search."
cgc.LOCALS.FRAME_LINK_REAGENTS_TITLE = "To which channel:"
cgc.LOCALS.FRAME_LINK_REAGENTS = "Link"
cgc.LOCALS.FRAME_LINK_TYPES = {
	[1] = {"Guild", "GUILD", nil},
	[2] = {"Party", "PARTY", nil}, 
	[3] = {"Say", "SAY", nil, },
	[4] = {"Whisper", "WHISPER", "Type the name of the player you would like to send the reagent/material information to."},
	[5] = {"Channel", "CHANNEL", "Type in which channel number you would like to post the information to.  Note: _NOT_ the channel name. So if trade is /2, type simply: 2"},
}
cgc.LOCALS.FRAME_SEARCH_TYPE_TITLE = "Search By:"
cgc.LOCALS.FRAME_SEARCH_TYPES = {
	[1] = "Name",
	[2] = "Reagent",
	[3] = "Requires",
}
cgc.LOCALS.FRAME_SEARCH_TYPES_DESC = {
	[1] = "Search by the name of the item in the trade/craft window.",
	[2] = "Reagent", "Search by the reagent that the item requires.",
	[3] = "Requires", "Search by the type of tools/items required to create the item.",
}


