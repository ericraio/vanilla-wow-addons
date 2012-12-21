------------------------------------------------------
Fizzwidget Enchant Seller
by Gazmik Fizzwidget
http://fizzwidget.com/enchantseller
gazmik@fizzwidget.com
------------------------------------------------------

Ah, crafting and commerce -- two Goblin inventions* that go great together! And yet, while business is booming for the artisans, gatherers, and commodity traders of Azeroth, a significant number of crafters are sadly lost when it comes to marketing their services. Too many times have I seen some poor schmuck get conned into paying far more than he should have to for an enchanter to make his weapon glow; and all too often I see budding enchanters driven into poverty by the costs of honing their skills. It's enough to make upstanding businessmen like myself nervous -- too many clueless traders is bad for the economy, you know -- so I had to do something about it.

This gizmo clips onto your Enchanting formula book; its sensors record every transaction you make that involves an enchantment, allowing it to provide advice on what you should charge for your services in the future. If you're also using my other amazing invention, ReagentCost, it'll also keep you updated on the current market prices of the materials for your enchantments, and help automate the tedium of advertising your services to other adventurers. Of course, it's still no substitute for real Goblin business sense (for that you'd need a real Goblin, and sharing all my moneymaking schemes would be bad for business), but you get what you pay for!

* Okay, okay... so maybe we weren't the ones bring these ideas to Azeroth -- but you can bet we've perfected them!

------------------------------------------------------

INSTALLATION: Put this folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

USAGE: Enchant Seller saves a description of whatever money and/or items are offered in return when you enchant someone's equipment via the trade window (or vice versa). This data is then summarized in your own Enchanting window: below the name (and rod requirement) of an enchantment, you'll see the average and median prices from your enchanting history, as well as a count of how many times you've traded that enchantment. (You can also query your enchant-trade history via chat commands; see below.)

CHAT COMMANDS:
	/enchantseller (or /es) <command>
where <command> can be any of the following:
	help - Print this list.
	status - Check current settings.
	gatherinfo on|off - enable/disable gathering info during trades
	price <enchant name> - Get a summary of trade prices for an enchant in the chat window.
	spam - Send a message advertising your currently available enchantments.
	whisper <player> [<slot>] - Send full enchantments menu to <player> via whisper. If <slot> is included, list only the enchantments for it (e.g. '2h weapon', 'bracer', 'cloak').
	channel <name> - Set chat channel for use with 'spam'. (Can also be 'say', 'party', etc.)
	showprices on|off - Include prices when advertising enchants.
	markup <number> - Mark up materials cost by <number> percent when calculating enchant prices.
	minprice <number> - Only advertise enchants you're selling for <number> or more. (In copper, so 1g = 10000.)

CAVEATS, ETC.: 
	- Enchant Seller currently stores references to any items traded when you enchant, but doesn't summarize them... there's not much space in the Enchanting window, and there's not a simple method to put a monetary value on an arbitrary set of items. (e.g., if someone trades 3x[Lifeless Stone], 4x[Mithril Bar], and a [Conk Hammer of the Monkey], how do you put that into a number? Use vendor prices, AH bids, or AH buyouts? Average or median?) I hope to provide some kind of useful summary in a future version. 

------------------------------------------------------
VERSION HISTORY

v. 11200.1 - 2006/08/22
- Updated TOC to reflect compatibility with WoW patch 1.12. (No actual changes.)

v. 11100.1 - 2006/06/20
- Updated TOC to reflect compatibility with WoW patch 1.11. (No actual changes were needed.)

v. 11000.1 - 2006/03/28
- Updated TOC to reflect compatibility with WoW patch 1.10. (No actual changes were needed.)
- Minor improvements to utility code shared across Fizzwidget addons.

See http://fizzwidget.com/notes/enchantseller/ for older release notes.