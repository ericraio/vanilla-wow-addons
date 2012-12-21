------------------------------------------------------
Fizzwidget Reagent Cost
by Gazmik Fizzwidget
http://fizzwidget.com/reagentcost
gazmik@fizzwidget.com
------------------------------------------------------

Once I'd enhanced my (already quite impressive, might I add) Enchant Seller gadget with the ability to estimate and report a total cost of materials for each enchantment, I knew I had to do the same for practitioners of other professions. After all, enchanters aren't the only crafters who'd benefit from a good helping of Goblin business sense!

Not only will this gizmo keep you informed on the current market price of the materials for all your trade skill recipes, it'll also help you choose which items are most profitable to produce for sale! Go make yourself some gold... and remember to tell the mount vendor Gazmik sent ya!

------------------------------------------------------

INSTALLATION: Put this folder into your World Of Warcraft/Interface/AddOns folder and launch WoW. You'll also need one of Auctioneer (http://www.auctioneeraddon.com), KC_Items (http://kaelcycle.wowinterface.com/), or AuctionMatrix (http://ui.worldofwar.net/ui.php?id=821) installed, if you haven't already. Also having ReagentData (http://www.tarys.com/reagents/) will help in some cases, but it isn't required.

USAGE: 
	- Your tradeskill windows will now display an estimated total cost of materials above the listing of required reagents for each recipe. The current market value of each reagent is calculated based on your auction scan data -- so, as is often the case with auction scanners, the more often you scan the AH, the more reliable your data will be. (A "confidence" percentage score is included in gray next to totals so you can get an idea of how reliable the auction data for a particular set of reagents is.) Auction price is only used for reagents not commonly sold by vendors; since it'd be silly to go looking for (for example) thread, vials, or flux at auction instead of buying from a vendor, the vendor price is used when totaling the cost of such reagents.
	- By typing `/reagentcost report`, you can get a list of all the items your tradeskills can produce ranked by estimated profitability, so you can see which items are worth making and selling on the AH and which (if you're not needing to make them for skill-ups) you might be better off selling the reagents for. By default, this list only includes items for which you have at least a minimal amount of auction data, and only items that can be auctioned for at least a break-even price. See "Chat Commands" below for options. (You'll notice the report also includes precentages in gray: this is the same "confidence" score as in the tradeskill windows.)

CHAT COMMANDS:
/reagentcost (or /rc) <command>
	- `help` - Print this helplist.
	- `status` - Check current settings.
	- `reset` - Reset to default settings.
	- `on|off` - Toggle displaying info in tradeskill windows.
	- `report [<skillname>]` - Output a list of the most profitable tradeskill items you can make. (Or only those produced through *skillname*.)
	- `minprofit <number>` - When reporting, only show items whose estimated profit is *number* or greater. (In copper, so 1g == 10000.)
	- `minprofit <number>%` - When reporting, only show items whose estimated profit exceeds its cost of materials by *number* percent or more.

------------------------------------------------------
VERSION HISTORY

v. 11200.1 - 2006/08/22
- Updated TOC to reflect compatibility with WoW patch 1.12. (No actual changes.)

v. 11100.1 - 2006/06/20
- Updated TOC to reflect compatibility with WoW patch 1.11. (No actual changes were needed.)
- KNOWN ISSUE: Reagent Cost is out of date with recent versions of KC_Items and AuctionMatrix; a new release to resume compatibility is forthcoming.

v. 11000.1 - 2006/03/28
- Updated TOC to reflect compatibility with WoW patch 1.10. (No actual changes were needed.)
- Minor changes for compatibility with KC_Items 0.94.x. (Thanks Jawynd!)
- Minor improvements to utility code shared across Fizzwidget addons.

See http://www.fizzwidget.com/notes/reagentcost/ for older release notes.
