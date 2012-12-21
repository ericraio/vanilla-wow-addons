------------------------------------------------------
Fizzwidget AutoCraft
by Gazmik Fizzwidget
http://www.fizzwidget.com/autocraft
gazmik@fizzwidget.com
------------------------------------------------------

So, I was playing my favorite strategy game with my good friend Marin Noggenfogger the other day, and I was struck with a brilliant idea for how to design a device that keeps track of what things you'll build next! I had to run off to my workshop and get started on it right away. (Besides, good old Marin was never going to find my last peon anyway...)

The result: the Automatronic Craftobot 100! (Or AutoCraft, for short.) This handy automaton takes care of repetitive crafting tasks for you!

------------------------------------------------------

INSTALLATION: Put this folder into your World Of Warcraft/Interface/AddOns folder and launch WoW.

FEATURES: 
- This addon changes the "Create" and "Create All" buttons in the trade skill window to become "Queue" and "Queue All". They work just as before... except you can also them click them again once you're already working on a product, and they'll queue the additional item(s) to be automatically produced as soon as the current item(s) are finished. 
- There's also a "Queue Everything" button -- click it to automatically queue up all the items you can currently create. ("Everything" actually means "everything currently in the window"... for example, if you're a tailor, switch to showing only the Trade Goods group and hit "Queue Everything" and it'll convert all your cloth to bolts without trying to also do something else.) 
- You can queue several items you have the reagents for even if you're currently unable to produce them (e.g. on a wind rider or gryphon, a smith away from a forge) and then make them all once you're ready, or pause queued work and resume it later if you need to stop for a break. The "Run Queue Automatically" checkbox controls whether we'll try to start working on items as soon as they're queued or wait until you press the "Run Queue" button yourself.
- There's also a "Buy" button; if you speak to a vendor while keeping your tradeskill window open, clicking this will automatically find and buy whatever reagents are needed for the selected item. (It works like the "Queue" button, too, so you can type in a number and buy enough reagents for that many items.) For example, a tailor who wants to make five Mageweave Bags and has three Silken Thread on hand can type "5" in the text box and press "Buy", and we'll automatically buy seven Silken Thread (assuming they have Mageweave Bag selected and are talking to a vendor who sells Silken Thread).

Queued items are shown as icons above the crafting progress bar, and you can click an icon to cancel production of the item(s) it represents. 

CAVEATS, KNOWN BUGS, ETC.: 
	- Doesn't work with Enchanting. (At least, not yet. I'm not sure it's worth it, either, as there aren't many items created by enchanting, much less situations where one often wants to create several in a row.)
	- "Queue Everything" works from bottom to top, so it may not actually end up trying to make everything that shows as available as of when you click the button. For example, if your beginning tailor has one Bolt of Linen Cloth and one Coarse Thread, the window will show Brown Linen Vest, Simple Linen Pants, and Linen Cloak as available... but if you click "Queue Everything", we'll start on the Linen Cloak, which will use up all the reagents we have on hand, so we won't queue Simple Linen Pants or Brown Linen Vest. Alt-clicking (or Option-clicking) the button will reverse the order -- working from the top to the bottom of the list -- but the same logic applies; once something is queued, the reagents it uses are unavailable for further queueing.
	
------------------------------------------------------
VERSION HISTORY

v. 11200.1 - 2006/08/22
- Updated TOC to reflect compatibility with WoW patch 1.12. (No actual changes.)

v. 11100.1 - 2006/06/20
- Updated TOC to reflect compatibility with WoW patch 1.11. (No actual changes were needed.)
- KNOWN ISSUE: WoW patch 1.10.x broke AutoCraft's ability to advance the queue automatically. I'm looking into possible resolutions for this issue, but for the time being you'll need to press "Run Queue" to move on to the next stack of items once one is finished.

v. 11000.1 - 2006/03/28
- Updated TOC to reflect compatibility with WoW patch 1.10. (No actual changes were needed.)
- Minor improvements to utility code shared across Fizzwidget addons.

See http://fizzwidget.com/notes/autocraft/ for older release notes.