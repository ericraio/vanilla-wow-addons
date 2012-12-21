----------------------------
====--- SuperInspect ---====
======---- V 1.16 ----======
====---- by Chester ----====
----------------------------
---chester.dent@gmail.com---

Ever wish you could check out that cool sword or helmet model that guy had without following him around and trying to move your camera just right to get a good look?  Ever wish you could get up close and personal with that awsome shield model without having the owner think you are stalking them?  Ever wish you could freely view that really cool looking mob from a safe distace?  Ever just wanted to view a really nice character model at your leisure without having to navigate your character to do it?  SuperInspect is for you....

== What is SuperInspect? ==
SuperInspect replaces the default inspect window with one that gives you these features:
-Inspect your target as long as you can target them
-Continue inspecting even if you've lost your target
-Show bonuses awarded to your target by the items they have equiped
-Colored borders for displayed items that indicate their quality
-Freely rotate, pan and zoom the model with your mouse
-Display NPCs
-Display Hostile Players
-Display yourself
-Gives each unit a nice background
-Toggle the display of inventory items and/or honor information
-Draggable, scaleable window
-Bind a key to inspect or view quickly
-Maximizes the window space for better model viewing

== How to Use ==
Inspect your targets as usual OR if you wish to also check out NPCs (recommended): 
Go to "Main Menu" then "Key Bindings" and scroll down until you find the SuperInspect entry.  Bind a key to "Inspect Target".  Select a target, hit that key and the SuperInspect window will appear (try targeting NPCs or if you can't find a target, target yourself with F1).

When the SuperInspect window is up, dragging the model with your Left-Mouse Button rotates the model, dragging with your Right-Mouse Button pans the model and MouseWheel zooms in and out.

If you wish to scale the window and/or drag it to some other position, see the slash commands below.  Once you've turned off default mode, you can drag the frame around by clicking and dragging on the top part of the frame.


== Options ==
-To show the available options, type:
/superinspect
--------------------------------
/superinspect reset - reset the frame to the center of your screen
/superinspect scale [number] - change the scale of the frame (ex: /superinspect scale 0.8)
/superinspect defaulttoggle - toggle default mode on/off (when on, SI acts like the default inspect window. when off, you can drag and scale the window)
/superinspect itembgtoggle - toggle the art used to display quality color of items
/superinspect durabilitytoggle - toggle durability info that is shown when inspecting yourself
/superinspect sound - toggle the open and close window sound


==== READ ME ====
TRANSLATORS NEEDED!
The item bonus part of SuperInspect relies heavily on parsing the text of items and doing something with that text.  English is easy, I speak english and run an english client.  But German and French are not that easy.  I don't speak either language very well and I don't have those clients.  As a result, german and french item bonuses could be incorrect (and probably are...definitely french).  So help me out!  German and French users, look at localization_UI help me make SuperInspect work perfect for users other than english!  Thanks! 


---Known Issues
-if you inspect a player who is wearing a set piece that you have equipped, item bonuses for that player may not display correctly
-Some small or large NPCs will show offset in the window frame

--- ADDITIONAL CREDITS
crowley@headshot.de (of TitanItemBonuses fame) - parsing code for the item bonuses
Sasmira ( Cosmos Team ) - french translation
g3gg0 - additional itembonus parsing code and german translations
Ghost - additional testing and german translations

--- CHANGELIST
04/04/06 - v1.17
-removed some debugging text from the default chat frame (whoops)

04/04/06 - v1.16
-updated toc for new patch
-fixed item bonuses window not displaying
-detectable set bonuses are now properly calculated into the item bonuses stats window
-new translations

02/26/06 - v1.15
-fixed 'table' error seen when inspecting someone with "Brilliant Mana Oil" or "Brilliant Wizard Oil"
-you can now drop items onto the SI window as well as drag item off if you are inspecting yourself (like your standard paperdoll frame)

02/16/06 - v1.14
-fixed error on inspecting for the first time where it was trying to load a function that wasn't loaded yet
-npc's will no longer report -1 for their level
-npc's will now report Boss, Rare, etc next to their level
-you can now safely dressup and link items in the inspect window even if you don't have a target or the target is far away

02/14/06 - v1.13
FIXES:
-fixed lifetime rank only showing current rank
-fixed rank title on opposite faction members not being localized
-fixed buttons not using localized strings
-fixed a few more patterns
-fixed item bonus window not drawing correctly on top of buttons
-fixed an error where a function would get called before the addon loaded
-SuperInspcet and AuperInspect_UI are now dependent on each other
-SuperInspect_UI is now called such in the addons window
-added a hack on my end to fix incompatibility with QuickInspect 
-fixed a few bad german translations (though I can't test, so I have no clue if they are fixed)
NEW:
-if you hit the hotkey with no target selected, it will autoselect yourself
-item durability information is now displayed for you own items (if they are starting to wear down)
-there is now a "compare" button on the item bonuses frame (click it to cope info to the compare frame to temporarily save and compare with another player)
-all known MobInfo2 information displayed now for npc's that you have MobInfo2 data on.  If you don't have MobInfo2 installed or don't have data on the mob, the window will not display.
-added a frame opening and closing sound (off by default).  If you would like to enable this, type: /superinspect sound

02/05/06 - v1.12
-new scan tokens and patterns added to catch missing ZG enchants as well as a lot of others enchants and bonuses that were missed
-SI now reports Ranged Damage bonuses due to Scopes
-SI now reports Weapon Damage bonuses
-Armor label now correctly reports as "Reinforced Armor"
-SI SHOULD no longer scan set items more than once when you are inspecting yourself
-more german translations and testing thanks to g3gg0 
-seperated out block amounts and chance to block and added more patterns to catch block amounts
-item bonus frame will now draw on top of the item buttons if it extends that far down
-SuperInpsect is now LoadOnDemand which means the UI will not load until you access it the first time
-made the item bonus text a tad bigger again
-fixed spell chance to hit recording as spell crit
-the 3d model will now update properly when its appearance changes (due to an inventory change)


02/04/06 - v1.11
-item bonuses now update when your target updates their equiped items
-small or large models will now show up in the frame (but sometimes offest, not sure how to fix this yet)
-incorporated g3gg0's additional parsing code which lets ZG enchants show up
-fixed parshing code which preventing some enchants and equip bonuses from showing up
-moved all text in the localization file for translation (HINT HINT to my far seas friends!) - a few stats will still show incorrectly for non-english users until these translations are made
-added +'s to resist stats and removed the number if it was 0 (reduces confusion)
-added title to the item bonus window to help reduce confusion
-added set infomation to the bonus window which shows up as "Set Name (x/x)" so you can see how many pieces they have equipped of a certain set
-the item bonus window now scales with the text to cover the cases where the information overlapped the frame size

02/02/06 - v1.1
-Added toggleable item bonus frame
--Full credit for the item bonus parsing code goes to crowley@headshot.de
-Frame art has changed to use a Blizzard style one
-Frame size has increased a tad to match Blizzard's size (will fix the MoveAnything bug)
-You can now continue viewing a player's items even if you've lost your target
-Added portrait art
-Reenabled the option to inspect honor on player's of the opposite faction
-Viewing an enemy player with a level much hiher than yours now no longer shows "-1"

01/29/06 - v1.03
-the ESC key now closes the window in non-default mode
-Tooltips now anchor to the buttons if you don't have TipBuddy installed
-FrameStrata increased so it will draw on top of normal UI elements
-item quality default art style now changed to a border
-custom tgas converted to blps (less memory)
-added new script command (itembgtoggle) that lets you toggle between the tabs and the borders (pick which one you like best and let me know)
-if you are out of range of an honor request, the button will now be disabled
-if you gather honor on a player and move out of range or lose your target, you will still be able to see that player's honor (will reset when you change targets)
-if you have the honor window open and change targets (while in inspect honor range), the honor window will stay up and request honor info from you new target right away
-added a percentage number to the Rank bar in the honor frame
-inventory frame will now hide and disable when you lose your target (until I get the code in that saves this info so you can brose even after you've lost your target)

01/27/06 - v1.02
-tiny fix for your keys not working when the window was open

01/27/06 - v1.01
-added 'default mode' (slash command 'defaulttoggle') which is that mode it starts off in now
--this mode will function exactly like the blizzard default inspect frame as far as positioning, scale and hitting esc to hide
-fixed items not showing tooltips if you moved the model around sometimes
-added guild rank info
-fixed strata of buttons so they don't float over everything else
-moved buttons to bottom of frame to make room for guild ranks
-added small indicator to the top right of the item icons to indicate quality (just trying this out, feedback appreciated)

-The feedback has been great!  I'm working on a feature list that I'd like to add including percentage for honor, saving item info (when you lose your target), item bonus sums and lots more options.  Thanks everyone!

01/26/06 - v1.0
-Released 