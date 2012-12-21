

XPERL_ADMIN_TITLE	= "X-Perl Raid Admin"

XPERL_MSG_PREFIX	= "|c00C05050X-Perl|r "
XPERL_COMMS_PREFIX	= "X-Perl"

-- Raid Admin
XPERL_BUTTON_ADMIN_PIN		= "Pin Window"
XPERL_BUTTON_ADMIN_LOCKOPEN	= "Lock Window Open"
XPERL_BUTTON_ADMIN_SAVE1	= "Save Roster"
XPERL_BUTTON_ADMIN_SAVE2	= "Saves the current roster layout with the name specified. If no name given, the current time will be used as the name"
XPERL_BUTTON_ADMIN_LOAD1	= "Load Roster"
XPERL_BUTTON_ADMIN_LOAD2	= "Load the selected roster. Any raid members of the saved roster who are no longer in the raid will be replaced by members of the same class who are not saved in the roster"
XPERL_BUTTON_ADMIN_DELETE1	= "Delete Roster"
XPERL_BUTTON_ADMIN_DELETE2	= "Delete the selected roster"
XPERL_BUTTON_ADMIN_STOPLOAD1	= "Stop Load"
XPERL_BUTTON_ADMIN_STOPLOAD2	= "Aborts the roster load procedure"

XPERL_LOAD			= "Load"

XPERL_SAVED_ROSTER		= "Saved roster called '%s'"
XPERL_ADMIN_DIFFERENCES		= "%d differences to current roster"
XPERL_NO_ROSTER_NAME_GIVEN	= "No roster name given"
XPERL_NO_ROSTER_CALLED		= "No roster saved called '%s'"

-- Item Checker
XPERL_CHECK_TITLE		= "X-Perl Item Check"

XPERL_RAID_TOOLTIP_NOCTRA	= "No CTRA Found"

XPERL_CHECK_DROPITEMTIP1	= "Drop Items"
XPERL_CHECK_DROPITEMTIP2	= "Items can be dropped into this frame and added to the list of queryable items.\rYou may also use the /raitem command as normal and items will also be added here and used in the future."
XPERL_CHECK_QUERY_DESC1		= "Query"
XPERL_CHECK_QUERY_DESC2		= "Performs item check (/raitem) on all ticked items\rQuery always gets current durablity, resistance and reagents information"
XPERL_CHECK_LAST_DESC1		= "Last"
XPERL_CHECK_LAST_DESC2		= "Re-tick the last search items"
XPERL_CHECK_ALL_DESC1		= ALL
XPERL_CHECK_ALL_DESC2		= "Tick all the items"
XPERL_CHECK_NONE_DESC1		= NONE
XPERL_CHECK_NONE_DESC2		= "Un-tick all the items"
XPERL_CHECK_DELETE_DESC1	= DELETE
XPERL_CHECK_DELETE_DESC2	= "Permenantly remove all the ticked items from the list"
XPERL_CHECK_REPORT_DESC1	= "Report"
XPERL_CHECK_REPORT_DESC2	= "Show report of the selected results to the raid chat"
XPERL_CHECK_REPORT_WITH_DESC1	= "With"
XPERL_CHECK_REPORT_WITH_DESC2	= "Report people with the item (or don't have the item equipped) to the raid chat. If an equipment scan has been performed, these results will be shown instead."
XPERL_CHECK_REPORT_WITHOUT_DESC1= "Without"
XPERL_CHECK_REPORT_WITHOUT_DESC2= "Report people without the item (or have the item equipped) to the raid chat"
XPERL_CHECK_SCAN_DESC1		= "Scan"
XPERL_CHECK_SCAN_DESC2		= "Will check anyone in raid within inspect range, to see whether they have the selected item equipped and indicate this on the player list. Move closer (10 yards) to people in the raid until all are checked."
XPERL_CHECK_SCANSTOP_DESC1	= "Stop Scan"
XPERL_CHECK_SCANSTOP_DESC2	= "Stop scanning player's equipment for the selected item"
XPERL_CHECK_REPORTPLAYER_DESC1	= "Report Player"
XPERL_CHECK_REPORTPLAYER_DESC2	= "Report selected player's details for this item or status to the raid chat"

XPERL_CHECK_BROKEN		= "Broken"
XPERL_CHECK_REPORT_DURABILITY	= "Average Raid Durability: %d%% and %d people with a total of %d broken items"
XPERL_CHECK_REPORT_PDURABILITY	= "%s's Durability: %d%% with %d broken items"
XPERL_CHECK_REPORT_RESISTS	= "Average Raid resists: %d "..SPELL_SCHOOL2_CAP..", %d "..SPELL_SCHOOL3_CAP..", %d "..SPELL_SCHOOL4_CAP..", %d "..SPELL_SCHOOL5_CAP..", %d "..SPELL_SCHOOL6_CAP
XPERL_CHECK_REPORT_PRESISTS	= "%s's Resists: %d "..SPELL_SCHOOL2_CAP..", %d "..SPELL_SCHOOL3_CAP..", %d "..SPELL_SCHOOL4_CAP..", %d "..SPELL_SCHOOL5_CAP..", %d "..SPELL_SCHOOL6_CAP
XPERL_CHECK_REPORT_WITH		= " - with: "
XPERL_CHECK_REPORT_WITHOUT	= " - without: "
XPERL_CHECK_REPORT_WITH_EQ	= " - with (or not equipped): "
XPERL_CHECK_REPORT_WITHOUT_EQ	= " - without (or equipped): "
XPERL_CHECK_REPORT_EQUIPED	= " : equipped: "
XPERL_CHECK_REPORT_NOTEQUIPED	= " : NOT equipped: "
XPERL_CHECK_REPORT_ALLEQUIPED	= "Everyone has %s equipped"
XPERL_CHECK_REPORT_ALLEQUIPEDOFF= "Everyone has %s equipped, but %d member(s) offline"
XPERL_CHECK_REPORT_PITEM	= "%s has %d %s in inventory"
XPERL_CHECK_REPORT_PEQUIPED	= "%s has %s equipped"
XPERL_CHECK_REPORT_PNOTEQUIPED	= "%s DOES NOT have %s equipped"

XPERL_CHECK_REPORT_WITHSHORT	= " : %d with"
XPERL_CHECK_REPORT_WITHOUTSHORT	= " : %d without"
XPERL_CHECK_REPORT_EQUIPEDSHORT	= " : %d equipped"
XPERL_CHECK_REPORT_NOTEQUIPEDSHORT	= " : %d NOT equipped"
XPERL_CHECK_REPORT_OFFLINE	= " : %d offline"
XPERL_CHECK_REPORT_TOTAL	= " : %d Total Items"
XPERL_CHECK_REPORT_NOTSCANNED	= " : %d un-checked"

XPERL_CHECK_LASTINFO		= "Last data received %sago"

XPERL_CHECK_AVERAGE		= "Average"
XPERL_CHECK_TOTALS		= "Total"
XPERL_CHECK_EQUIPED		= "Equipped"

XPERL_CHECK_SCAN_MISSING	= "Scanning inspectable players for item. (%d un-scanned)"

XPERL_REAGENTS			= {PRIEST = "Sacred Candle", MAGE = "Arcane Powder", DRUID = "Wild Thornroot",
					SHAMAN = "Ankh", WARLOCK = "Soul Shard", PALADIN = "Symbol of Divinity",
					ROGUE = "Flash Powder"}
