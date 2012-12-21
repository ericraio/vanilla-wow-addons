AH_Mailcollect = {ACEUTIL_VERSION = 1.01}

if not ace:LoadTranslation("AH_MailCollect") then
AH_MailCollectLocals = {}

--[[ ================================================= ]]--
--  Section I: The Chat Options.						  --
--[[ ================================================= ]]--

AH_MailCollectLocals.ChatCmd = {"/ahmailcollect", "/amc"}

AH_MailCollectLocals.ChatOpt = {
{
		option		= "summary",
		desc		= "Toggles showing a summary of total money received.",
		method		= "ToggleGainLossSummaryMail",
		args		= {
			{
				option   = "help",
				desc	 = "Allows you to toggle whether or not to show a summary of total money received from your Inbox after closing the mailbox window."
			}
		}
	},
{
		option		= "verbose",
		desc		= "Toggles showing each money amount as it's processed from mail.",
		method		= "ToggleGainLossDisplayMail",
		args		= {
			{
				option   = "help",
				desc	 = "Allows you to toggle whether or not to show a detailed list of money amounts received from your Inbox as it's being processed."
			}
		}
	},
{
		option		= "items",
		desc		= "Toggles whether or not to loot item attachments when opening messages.",
		method		= "ToggleLootItems",
		args		= {
			{
				option   = "help",
				desc	 = "Allows you to toggle whether or not to automatically retrieve items from your inbox messages when you right-click on them.",
			}
		}
	},
{
		option		= "auctionitems",
		desc		= "Toggles whether or not to loot all auction item attachments when opening messages.",
		method		= "ToggleAuctionItems",
		args		= {
			{
				option   = "help",
				desc	 = "Allows you to toggle whether or not to automatically retrieve all Auction items from your messages when you open the inbox.",
			}
		}
	},
{
		option		= "deleteall",
		desc		= "Toggles whether or not to delete messages with attachments sent to you by others after looting.",
		method		= "ToggleDeleteAllMail",
		args		= {
			{
				option   = "help",
				desc	 = "Allows you to toggle whether or not to automatically delete a message with an item sent to you by anotherh player after you retreive the item from your inbox message.  In some cases you may want to keep the test in the message and not delete right away, so this is an option.",
			}
		}
	},
}

--[[ ================================================= ]]--
-- Section II: AddOn Information.						--
--[[ ================================================= ]]--

AH_MailCollectLocals.Name		= "AH_MailCollect"
AH_MailCollectLocals.Version		= "0.9"
AH_MailCollectLocals.Description	= "Automatically collects money from all successful auctions in your mailbox."
AH_MailCollectLocals.ReleaseDate	= "04.28.06"

--[[ ================================================= ]]--
-- Section III: Register Global Variables.			   --
--[[ ================================================= ]]--

ace:RegisterGlobals({
	version = AH_Mailcollect.ACEUTIL_VERSION,

    -- A list of hexadecimal values that can be used for conversion of a 0-15
    -- decimal value into hex. Use: ACE_HEX[int+1]
    ACEG_HEX = {0,1,2,3,4,5,6,7,8,9,"a","b","c","d","e","f"},

	-- Value maps for use in displaying values in a more readable format.
	ACEG_MAP_ONOFF	 = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},

    -- Standard gold, silver, and copper colors in hex format.
    ACEG_COLOR_HEX_GOLD   = "ffd700",
    ACEG_COLOR_HEX_SILVER = "c7c7cf",
    ACEG_COLOR_HEX_COPPER = "eda55f",

    -- References for the first letters of the words gold, silver, and copper that
    -- can be used for localization purposes.
    ACEG_LETTER_GOLD   = "g",
    ACEG_LETTER_SILVER = "s",
    ACEG_LETTER_COPPER = "c",
})

AH_MailCollectLocals.TEXT_DISPLAY_MAIL		= "Display each gain at the mailbox."
AH_MailCollectLocals.TEXT_SUM_MAIL			= "Summary of all money received."
AH_MailCollectLocals.TEXT_DELETE_ALL		= "Delete messages from other players with an item after loot."
AH_MailCollectLocals.TEXT_SUM_MAIL			= "Summary of all money received."
AH_MailCollectLocals.TEXT_LOOT_ITEMS		= "Retrieve items from a message automatically on right-click."
AH_MailCollectLocals.TEXT_AUCTION_ITEMS	= "Retrieve all Auction items automatically when opening the mailbox."

AH_MailCollectLocals.GAINED_MSG	 			= "%s received."
AH_MailCollectLocals.GAINED_SUM_MSG	 	= "You gained a total of %s."
AH_MailCollectLocals.LOST_CASH_MSG		 	= "You lost %s."
AH_MailCollectLocals.LOST_SUM_MSG		 	= "You lost a total of %s."
AH_MailCollectLocals.TEXT_INV_FULL		 	= "Your inventory is full!"

-- AH_MailCollectLocals.AUCTION_SUCCESS_MSG	= "Auction successful"
-- AH_MailCollectLocals.AUCTION_OUTBID_MSG		= "Outbid"
-- AH_MailCollectLocals.AUCTION_WON_MSG		= "Auction won"

end