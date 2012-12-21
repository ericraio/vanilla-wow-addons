----------------------------
=====---- TipBuddy ----=====
=====----- V 2.22 -----=====
====---- by Chester ----====
----------------------------
---chester.dent@gmail.com---


---- SLASH COMMANDS

/tipbuddy
/tbuddy
/tip
- toggles the options window

/tipbuddy resetanchor
- resets the TipBuddyAnchor position to its default (use this if it goes offscreen)



---- MENU
- To access the menu: 
- Use the slash command above (/tip) OR
- Hit ESC to bring up the default WoW options menu THEN
- Click the TipBuddy button attached to the right of the default menu




---- USING VARIABLE CODES
- Here are some examples for setting up your custom tooltips:

What you enter:
@Crn<pr>$pr </pr>$nm
<gu>@Crg< $gu ></gu>
Level @Cdf$lv @Cwt$rc @Ccl$cl
$fa

What you might see:
First Sargeant Chester
< Not Goon Squad >
Level 57 Orc Warrior
Horde

- Using the color codes:
The color codes are a way for you to color all text after the code in a certain way.  Using the example above, we put @Crn at the beginning of the first line.  What that will do is color all text after it based on the unit's reaction towards you (by default, red=hostile, green=friendly pvp, etc).  If we wanted our text to be colored based on what class the unit was, we would put @Ccl before the text we wanted to color.

The coloring will apply to ALL text after the code until one of two things happen.  First is if a new line is created (you hit Enter in the editbox or use the codes $nl or \n).  Second is if another color code is defined after the first, the new one will start coloring the following text its own way.

- Using Tags:
<gu>@Crg< $gu ></gu>         <-- this line uses tags (the <gu> and </gu>)
Tags are a way to make a bunch of additional text or color not show up if the variable you are interested in returns nil.  Using the example above, you'll notice that the whole line is enclosed in a set of tags similar to html tags, but the tag name matches a variable inside of it ($gu).  What that means is, if the $gu (player guild) returns nil (meaning that the player is not in a guild), everything within those tags will not be displayed.  The tags NEED to match the variable name that you want to tie it to (minus the $ character) or it won't work.  This applies for coloring as well.  If the player is not in a guild and you have this: @Crg<<gu> $gu </gu>>  what will be displayed is this: <> colored using the @Crg coloring.  Make sure to include everything you want to use to display a variable inside the tags.





Thanks to:
Medici of Eredar (German Translations)
Frosty (for fixing a bug, when I was in dial-up Hell)
Skeeve (additional fixes)
Lozareth (allowing me to use his Variables code as a template for mine)
Quindo Ma from worldofwar (for obtaining a full list of NPC city factions)

--- CHANGELIST
6/25/06 - v2.22
-blizzard's default tooltip should no longer show in the lower right corner of the screen when mousing over units
-city factions should now all show properly (for now) - thanks to Quindo Ma for obtaining a full list of NPC city factions and finding a bug in my code
-your personal pet should now always fall into the catagory of Friendly Pet
-updated the toc

5/23/06 - v2.21
-fixed GameTooltip SetOwner hooks potentially not hooking before the unhooked function was called
-fixed blank grey tooltip showing in upper right corner of screen at login or ReloadUI 

5/22/06 - v2.209
-fixed potential disaster where every UNI_HEALTH event was modifying the tooltip for that unit (yikes)
-fixed "Equipped" tooltip not cooperating with Auctioneer and EhnTooltip
--GameTooltip will now scale to default size whenever EhnTooltip is being used (so the scaling is correct with those mods)

5/21/06 - v2.208
-another fix for "Currently Equipped" frame not showing in AH

5/21/06 - v2.207
-"Currently Equipped" frame (that shows in AH) not displaying properly SHOULD now be fixed now
-fixed SetPoint error that showed on frames with no names (for real this time)
-fixed party frames health bars not updating correctly
-fixed fading unit frames sticking around and getting button text if you moused over a button while a unit frame tooltip was still visible

5/19/06 - v2.206
-fixed SetPoint error that showed on frames with no names (such as the "Pass" frame)
-fixed tooltips going offscreen, offsetting incorrectly if you had your tooltip scale set to something other than 1.0
-fixed background colors not working when you had the blizdefault option set
-fixed uRace error
-added a "Keep All Tooltips On Screen" option (under General) so users can toggle this feature 

5/17/06 - v2.205
-fixed errors produced when SetOwner was called with no anchor position passed (2534: bad argument #1 to gsub' (string expected, got nil))
-fixed TipBuddy trying to fix positions of tooltips when it shouldn't be
--tooltip positions set by other mods will no longer be modified UNLESS they extend off screen

5/13/06 - v2.204
-fixed more issues with tooltips created by other mods not displaying properly

5/13/06 - v2.203
-fixed tooltips created from other mods screwing up (titan, etc)
--tooltips created by other mods that extend off the screen are now brought back in by TipBuddy.
--these repositioned tooltips will never be positioned by TipBuddy UNLESS they extend outside your screen

5/11/06 - v2.202
-fixed pvp flag not going away properly in some cases
-fixed player's location not showing when mousing over party frames
-fixed known error when trying to index unknown fields
-fixed itemsync adding a ton of blank lines to the tooltip when right-clicking vendors
-fixed tooltips in the upper, upper-right corners of screen not anchoring properly
-tooltips created by default blizzard frames AND other mods that can go offscreen are now repositioned by TipBuddy so they can never go offscreen
--basically this means that you will never have a tooltip hanging off the screen unreadable ever again
-added new advanced variable '$gt' which returns the player's title rank in their guild
--common usage of this might be '<gu>@Crg<$gt of $gu> </gu>'

5/09/06 - v2.201
-fixed error where debugging display function was commented out

5/09/06 - v2.2
-rewrote most of the visibility code to work better with Bliz's new tooltip rules and with other mods
-default tooltip will now fade following the same rules as the compact fade (delay + fade time)
-city faction coloring now works
-other info will show up properly again in compact mode
-fixed buff issues
-compatibility with other mods should be much better now
-fixed the $tp (tapped) code producing an error
-reorganized options panel a bit
-fixed a few typos in options tooltip text
-updated toc


4/07/06 - v2.103beta
-more fixes

4/03/06 - v2.102beta
-optimizations to improve performance
-fixes for the new patch (mostly related to Tooltips clearing when hidden and the 'Show' call)
-MobInfo2 text and all additional text will now show up properly again in compact mode


3/19/06 - v2.1
-fixed compact mode never showing DoubleLine tooltips (all MobInfo and other mods info will now always show in compact mode)
-fixed Civilian, Skinnable and Resurectable (as well as all other additional tooltip text) not showing up in the proper color that they should

3/14/06 - v2.09
-fixed error with line 1119: attempt to compare nil with number
-your pet's health text will now report as the actual number while other people's pets will report as a percentage
-decreased step value of the gametooltip scale slider (it now steps in 0.5 increments)

3/13/06 - v2.08
-fixed tooltips fading (not hiding) on mobs with a dash in their name
-fixed Line: 949 error (TipBuddy.gtt_numlines error)
-fixed Line: 1090 error (TipBuddy.gtt_lastline error)
-fixed compact mode not showing all extra info (truncating to one line) 

3/12/06 - v2.07
-fixed single line tooltip text (super long tooltip text with no line breaks)
-fixed Line: 2063 error
-fixed Line: 1084 error

3/10/06 - v2.06
-fixed stack overflow error
-fixed problem with DE users where 'LEVEL' wasn't getting parsed properly (Skeeve)
-fixed problem with tooltips losing thier carrige returns (tooltip info would show in one line) - if you still see this problem, let me know.  it is most likely caused by another mod.

3/10/06 - v2.05
-fixed error "TipBuddy.lua: 1946: attempt to call global 'lGameTooltip_OnShow_Orig' (a nil value)"

3/10/06 - v2.04
-fixed special characters causing the gametooltip to not hide or fade improperly (Elkano)
-fixed TipBuddy not releasing the GameTooltip's OnShow so other mods can use it (Skeeve)
-increased the number of extra line the Compact mode can display to 20 (Skeeve)
-Compact mode will now properly display lines added to the tooltip after TipBuddy has created it (fixed MonkeyQuest quest info not showing up as well as various tooltip note mods, etc)

1/13/06 - v2.03
-fixed scaling issues for default tips (the slider was reporting the wrong number so a setting of 1.2 was actually about 1.0) 
  - YOU WILL HAVE TO RESCALE YOUR TIPS THIS UPDATE (but they will be correct from now on)
-added a new checkbox for the Target's Target option which will put that info on a seperate line 
  - (to prevent tips from getting super long if both units had long names)
-"Unknown Entity" will no longer show up as someone's target
-guild background and border colors will now display properly
-fixed tooltip info growing and repeating when on dead players 
  - (this change caused me to revert the feature that updates the tooltips on unit deaths.  I tested Blizzard's default tooltip and they exhibit the same behavior.  Since this feature caused the other bug, I choose the lesser of two evils)
-added a button to the options menu that will reset the TipBuddyAnchor's position
-moved some things around in the options menu to hopefully make them easier to find
-TB is now taking more advantage of GlobalStrings and less on local localization, thus making TB more compatible with clients that aren't US, DE, or FR.

1/12/06 - v2.02
X-fixed Tip Style settings not saving properly (if you select Compact, it will now save like it should)
-fixed non-unit anchor positions not saving properly
-fixed Compact tooltip background colors not displaying how they should (all bg colors should work now)
-fixed old stale info showing up in the bottom right slot of Compact tips
-fixed text placement/drawing issues with certain mobs, when using MobInfo2 (like the Bloodsail Buccaneers)
-fixed error "1753: attempt to index local `tip' (a nil value)"

1/10/06 - v2.01
-fixed error when mousing over pet or party frame if they were far away and the server didn't return a class value
-fixed  "Civilian" not showing properly in compact model
-fixed color coding for Civilian, Skinning and Resurrectable not showing properly
-fixed tooltip not refreshing on mob death
-fixed the compact's border not showing
-fixed the tooltip background not using the correct texture (backgrounds will now use the full range of alpha, you may have to adjust your alpha settings)
-fixed debuff icons showing up offset from the tooltip if you hid the healthbar


1/7/06 - v2.0
NEW:
-Compact mode now will display 'extra' info (hunter's 'Beast Lore', anything that's added by other tooltips, party member locations, etc)
-Advanced Mode.  Which lets you create your own custom tooltip info and text using a variable system similar to DUF (PLEASE READ THE README FOR INFO)
-New options for tooltip background and border coloring.
-You can now set your background or borders to display with a custom color and alpha, color based on difficulty or color based on reaction (background and borders are independent of each other so you can set them to do different things)
-You can now set a custom color for the background and borders of your non-unit tooltips (buttons, icons, items, spells, etc)
-You can now set corpse tooltip styles and options (same as all other types, including compact)
-All new Options Menu design which should make things easier to find as well as understand
-More things I probably forgot to document!

FIXES:
-fixed scaling issues introduced by new patch
-Turning off the health bar now turns it off in the Default mode as well as Compact
-Civilian will now properly show in all tip styles
-lots and lots of others

10/27/05 - v1.83
-quick fix for MobInfo2 health not updating properly
-updated toc
-TipBuddy 2.0 coming soon

10/2/05 - v1.82
-fixed bug with default tooltip scaling starting off incorrect if you either downloaded for the first time or upgraded from a version pre-1700
-reorganized initialization of variables and some general code 
-fixed an error with a saved variable which could cause an error and reset your saved settings
---if you get an error after updating to this version, you will need to either reset your settings using the options menu or delete your saved variables file.  I apologize for this inconvinience.
-new code for new features are also included in this version, but are not exposed.  I wanted to get this version out to fix up all those folks getting the savedvariables error.  Look for some cool new functionality and all new customization features next version!

9/20/05 - v1.81
-fixed error with corpses if you didn't have a mobhealth addon
-fixed health/mana text showing on corpses

9/20/05 - v1.8
NEW FEATURES
+ added scaling functionality for your default tooltips.  You can now scale it up or down regardless of your UI Scale.  This affects all of your default tooltips so it's great for users with sight problems.
+ added display of your selected unit's target.  Your target's target will be displayed next to their name and will be color coded based on the type of unit they have selected:
red    = enemy
blue   = non-hostile npc
green  = friendly player
purple = party member
white  = YOU!
(these can all be enabled or disabled per unit type via the options menu)
+ added the ability to display the difficulty color as your tooltip background.  You now have a choice whether you want the tooltip background colors to be custom per unit type or to always display as the difficulty color 
(red=impossible, green=easy, grey=trivial, etc)
+ added support for the mobhealth database
+ added the option to turn on the health and mana txt which gets overlayed on top of the health and mana bars
(by default it will display the percentage [90%] unless you have one of the mobhealth mods installed and have data on that unit.  It will then display in mobhealth fashion as: 1393/1548
(both of these can all be enabled or disabled individually per unit type via the options menu)
+ added the ability to toggle showing text instead of the faction symbol.  This will display "PvP" or "FFA" in big bold letters instead of displaying the faction symbol.
(this can be enabled or disabled per unit type via the options menu)
+ increased the range in which you can offset your tooltips from your cursor

FIXES/CHANGES
- lots of small fixes, code reorganization and some minor cleanup.
- reorganized options menu slightly and put the "Compact Only" options in its own section.  If you are looking for it, click on the COMPACT ONLY header.
- a bunch of the new options mentioned above are now selectable from a new 'pop-up' window that pops up when you mouse over the little note to the left of the related checkbox.
- TipBuddy will now properly display text in both the left and right tooltip lines.


9/15/05 - v1.791
-additional fixes by Skeeve (not chester...Thanks Skeeve!)

9/15/05 - v1.79
-fixed 2112 error in new patch (by Frosty)
-updated toc

7/16/05 - v1.78
-fixed line 1456 error finding nil 'gtt_name'

7/13/05 - v1.77
-updated version number

7/7/05 - v1.76
-fixed lines being added every frame on unit frames with default unitframe setup
-fixed tooltips for buttons not showing right away if you quickly moused over a unit then a button
-fixed known nil 'find' errors
-fixed getting extra default info if you moused over a unit and then another with the exact same name

7/6/05 - v1.75
-fixed nil error people would see occasionally when leaving a unit
-fixed hunter's Beast Lore info not all showing properly in the tooltip
-^^ this also fixes a few issues with all info not showing in tips sometimes
-cleaned out a bunch of cruddy old code

6/22/05 - v1.74
-think I fixed a nil error people were getting with last version (please keep your eyes out)
-added cursor tooltip offsets
IMPORTANT:  If you had your tooltip attached to the cursor and did not have it attached to the top, you will have to go into the options and set an offset that works for you (it default to 0,0 on startup of this version)
-added two new sliders to the options menu which control X and Y offsets for the cursor attachment
-reorganized the options menu a bit
-re-enabled compact mode tips to show 'extra' information in them
IMPORTANT: I am not currentlty supporting this 100% which is why I made the options for this command line only (you won't find options in the options menu for it).  I just wanted to get it back in so people could use it and play with it before I could devote large amounts of time to make it work well.

The command is:
"/tipbuddy extras {type}"
-Valid arguments for {type}:
on  -- (turns all on)
off -- (turns all off)
pc_friend
pc_enemy
pc_party
pet_friend
pet_enemy
npc_friend
npc_enemy
npc_neutral

Please type in the 'type' argument exactly how you see it above.

6/21/05 - v1.73
-fixed line doubling if you had any other mod installed which modified the tooltip's name
-fixed fade not working if you had another mod installed that did the same

6/18/05 - v1.72
-fixed error that showed up sometimes relating to tipbuddy compact mode fading out
-fixed chat debugging causing all chat channels to move up a number

6/16/05 - v1.71
-non-unit worlds tips (mailboxes, anvils, etc) will now follow the same anchoring rules that you set for unit tips
-non-unit world tips also will now fade or hide depending on how you have it set for the 'default' tips
-fixed a concatenate error some people were seeing

6/14/05 - v1.7
-compact mode text if no longer set to different alphas, all alphas are now at the highest (makes for crisper text)
-fixed some incorrect translations for germans (pets should now display properly)
-Unit tooltip position is now seperated from non-unit position
--this means you can set your tip to be anchored with units, but still have it follow the cursor on buttons if you like
-fixed an error that would clear out tooltip lines causing some info to not show
--this should also fix another case of double lines
-added new console command 'blizdefault'
--by typing "/tip blizdefault" any tooltip that you have set to use the default mode will now be displayed with the Blizzard Default style tooltips (all TB anchoring still works though)

6/10/05 - v1.691
-fixed error you would get on startup when users were using the anchored mode
-also fixes 'color' errors you would get related to the same problem

6/10/05 - v1.69
-fixed default tooltip not showing for the first time if your first mouseover was a unit
-fixed tooltip floating for buttons if they were attached to cursor and you hadnt moused over a unit yet
-fixed error on new partypet frames
-fixed location showing twice sometimes for party member frames
-fixed errors relating to not finding gtt_guild and gtt_class

6/09/05 - v1.682
-French localisation is now complete thanks to Feu and Gaysha
--should fix text doubling up errors for french users
-new toc version number
--(reverted from v1.69 due to overflow error)

6/07/05 - v1.68
-removed some accidental debug info

6/07/05 - v1.67
-fixed super long tooltips when mousing over target and player frames
-tooltip clipping is now pixel perfect and should work on all machines (some user were seeing weird offsets, tooltip floating relative to your cursor and the clipping on the right side of the screen not working, this should all be fixed now)
-added new option (as well as new dropdown menu) that lets you anchor your nonunit tooltips in a 'smart' way (tooltips will try to anchor to the object you have your mouse over in a smart position relative to that object)

6/05/05 - v1.66
-fixed Skinnable and Resurectable text not showing for corpses
-fixed an error that would sometimes show during combat (Line: 1180)

6/04/05 - v1.65
-fixed another case of class text showing twice as well as increasing in lines

6/04/05 - v1.64
-fixed class text doubling up for friendly players

6/04/05 - v1.63
-fixed titles not showing up for NPC's

6/03/05 - v1.62
-fixed TipBuddy clearing other mod's info that was put in the tooltip
--this makes MobInfo, MonkeyQuest and other mods qhich unitlize the tooltip compatible with TipBuddy again
-added two new anchor positions to the TipBuddyAnchor (Top Center and Bottom Center)
-added the option to have non-unit tooltips (UberTips) anchored to the TipBuddyAnchor instead of the cursor always (click the "Anchor Non-Unit Tips" box in the options)
-think I also fixed an error with class info (attempt to concatonate field gtt_class(a nil value))

6/02/05 - v1.61
-fixed default tooltip's size getting huge when opening your bags if you had bags that did not take up a second column (this also fixes the crashes some would see in the same case)
-fixed party members location not showing in some cases when you moused over their unit frame
-fixed guildmate text color not working
-fixed 'tapped by player' and 'tapped by other' text color not working properly

5/31/05 - v1.6
-the case of the disappearing tooltip has been solved
-fixed compact tooltip disappearing at inopportune times
-added ability to toggle rank icons for players in options menu
-added ability to toggle ranks names in the options menu
-by popular demand, added a new neutral tab for npc's which are neutral to you
--this enables you to set background colors as well as pick what text you want displayed for neutral NPCs
-fixed TipBuddy's background color of tooltip carrying over to an item tooltip in certain cases
-fixed icons sometimes going away if you recieved an event (such as mana) when yout mouse was over that unit (this is fixed for the player as well)
-fixed party frame tooltips showing the wrong unit type
-fixed party member frame tooltip's location not showing if guild was turned on
-fixed the first line of additional tooltip text sometimes getting removed
-fixed level text overlapping title text for some pets in certain cases
-fixed selected guildmate text color not working properly
-fixed a case where guild text would get inserted (and doubled up) when there was none
-Thanks so much to everyone who offered to test this version!

5/27/05 - v1.59b
-fixed compact mode disappearing at random times
-fixed error when mousing over party frame when they were at a distance and you had ranknames on
-fixed buffs, ranks, and faction icon not showing at times
-fixed the above not going away sometimes
-buffs, rankicon, and faction icon now fade properly with the frame they are attached to
-fixed gametooltip frames sometimes showing then disappearing if you moused over then when the previous visible frame was the compact version
-fixed "Skinnable" text not properly showing its difficulty color
-cleaned up quite a bit of code
-added an "Apply" button to the options menu as well as improved button placement
-Options menu now has a "Reset" button that when pressed, prompts you if you really want to reset
-dead player corpses should now should guild if they have one

5/23/05 - v1.58b
-fixed 'elapsed' error you would get when entering inns, etc.

5/23/05 - v1.57b
-fixed background color buttons not being clickable
-fixed same faction level color not working
-fixed level 'con' color for standard and trivial showing the wrong colors
-fixed color picker frame not keeping focus if you clicked off it
-fixed being able to click the frames under the color picker frame
-fixed an error when mousing over party member frames in certain situations
-fixed TipBuddyAnchor starting off the screen under certain circumstances
--"/tipbuddy resetanchor" still works if you get the anchor in a bad spot
-hunter's pet info should now work properly with TipBuddy
-fixed tooltip going crazy/crashing when it was up and you would talk to a vendor or open a bag
-fixed german 'civilian' translation showing incorrectly

5/17/05 - v1.56b
-fixed variables saving poorly which cause a billion errors on startup
(fixes all known errors on mouseover)
-fixed TipBuddyAnchor showing in a bad position when it was first shown
-fixed case where TipBuddyAnchor was never shown at all
(fixed tooltips not drawing or positoned strangely when anchored to the anchor.  If you cannot get your anchor to show, type this: /tipbuddy resetanchor)
-added /'resetanchor' command to reset your anchor position if you get it in a bad spot
-fixed icons getting stuck to frame when it dissapeared
(they don't fade out yet with the frame yet.  I have a solution for this, will be next version)
-fixed tooltip background color from units persisting to your next item tooltip
-fixed German translation of Civilian (I think. Medici, can you test this for me?) 


5/17/05 - v1.55b
-update city tonight!
-fixed color boxes not being selectable
-menu window now closes when TipBuddy options window closes (sorry myAddons author)
-corpses should now display with the default tooltip no matter what now
-TipBuddy menu icon now never goes away

5/17/05 - v1.54b
-quick fix to show mana properly again (fixes ManaTextColor error)
-added the option to set the Default mode tooltip to use the Bliz fade (off by default)
-Bonus Feature: TipBuddy now supports myAddons!  Huzzah!

5/16/05 - v1.53b
--CHANGES/ADDITIONS
-TipBuddy's new default mode now uses the tried and true GameTooltip (with most of the TipBuddy features!)
-all mods that add info to the tooltip are now consistently compatible with the default mode (MobInfo, etc)
-mousing over unit frames (targetframe, party frames) will now show TipBuddy
-you can now choose the text colors for all text TipBuddy shows
-added new menu window for choosing text colors
-TipBuddy is now localized for German users (thanks to Medici! now if anyone knows any French users...)
-Default mode for the tooltip now goes away when you are not on a unit (I will add an option to show the default 'fading' in the next version)
-tooltip border is now the default light grey
--FIXES
-color picker frame now overlays other menu frames
-closing color picker frame takes you back to previous menu now
-optimized TipBuddy pretty severely so it now uses MUCH less memory when running
-fixed civilian text not showing up
-fixed tooltip being blank on start if you used the anchor
-fixed pets showing up as friendly pcs (fixes pets showing their class type as 'Warrior')
-removed slash command /tb as to not conflict with TackleBox (replaced with /tbuddy)
-a few other small things not worth mentioning

5/09/05 - v1.51
-added option for color coded class text
-fixed city faction text showing in the wrong place sometimes
-fixed city faction text thinking there was some when there wasn't with AF_Tooltip installed
-fixed error 'Civilian' checking when AF_Tooltip was installed
-removed Rank Titles in player names by default
-->if you like them displayed you can reenable them by typing "/tb rankname"
-the con coloring system (for level and class text) will now display for friendly players who are flagged for PvP.  Unless you are using the class color coding, then it will only display for the level text
-did a bit of an slight overhaul on text colors and display to make them easier to read
-changed default settings to be more appealing
-optimized code a bit

-->On the Horizon:
-looking into making a "Light" version that uses the default GameTooltip

5/04/05 - v1.50
-TipBuddy no longer shows a skull when your target's level is out of range
(now shows ?? as it was much easier to display elites, rares and bosses this way.  Plus a lot of people seemed to prefer the ?? to the skull graphic)
-Elites are now indicated for friendlies as well as enemies (with a '+')
-Rares, RareElites and Bosses for both friendly and enemy mobs are now indicated (with bright white letters)
-fixed City Faction not showing up for NPCs
-adjusted horizontal sizing math to consider boss and rare text
-TipBuddyAnchor will now not show everytime you load the game when you are using it
-TipBuddyAnchor will now only show the first time you click the option to use it (keeps from having to close it every time you change your options)
-added a button so you can display TipBuddyAnchor at any time from the options menu
-changed tooltips to reflect above changes

5/02/05 - v1.49
-fixed line 655 error on units/pets
-fixed tipbuddy hogging the OnHide and OnEvent for GameTooltip
(auctioneer, lootlink, reagent info, etc should now all show properly)

4/29/05 - v1.48
-names now display rank titles (if available)
-rank icon now diplays to the left of the name
-"Civilian" now properly shows up
-fixed issue with play controlled pets producing an error
-fixed a few other nil errors

4/20/05 - v1.47
-added additional infro to "Race" tooltip checkbox
-internally setup a debugging message system
-fixed another error on pets/totems
-increased total buff/debuff icons displayed to 8
-disabled "Extras" option until a better solution is found
-fixed an error where some units dont properly return their faction
-fixed tooltips not properly clipping to the bottom of the screen
-adjusted disnaces a bit to where the tooltips clip to screen edges

4/20/05 - v1.46
-fixed another error on pets and totems
-added another check to playercontrolled units for title names (fixes MiniDiablo title not showing) ^_^

4/19/05 - v1.45
-added the option to show race for players
-options menu now reflects this with a new checkbox
-fixed manabar not updating when mousing over new units
-warriors with no rage now won't show an empty manabar


4/16/05 - v1.44
-fixed all settings resetting with each new version
-fixed background colors not saving
-default tooltip background color follows TipBuddy settings now if TipBuddy is turned off
-renamed 'Disable All' checkbox to 'Disable TipBuddy' to avoid some confusion that was happening
-moved color picker boxes

4/16/05 - v1.43
-fixed error on enemy NPCs when cityfac was on when there was none

4/15/05 - v1.42
-new check to fix errors on pets and some npcs
-friendly units classes now don't use con coloring system
-increased minimum frame size so the frame doesn't get too small on small named units
-fixed health and mana bars sometimes not sizing properly + improved positioning
-TipBuddyAnchor tooltip now attaches to itself using the current rules set
-TipBuddyAnchor tooltip now goes away when you bring up the dropdown

4/8/05 - v1.41
-GameTooltip now defaults to following the same anchor setup as TipBuddy
--(anchored to cursor or to TipBuddyAnchor)
-new initialization setup which puts you in synch with the latest variables
-all tooltip types can now be attached to cursor or tipbuddy with their position configured
-added dropdown to options to allow tooltip position in raltion to cursor
-TipBuddyAnchor now has drop down which lets you set tooltip position in relation ot it
-a few options went away
-TipBuddyAnchor now sparkles when it shows to keep track of it
-TipBuddyAnchor now fades out when your mouse isnt over it
-disabling TipBuddy for a certain target type will now show the default tooltip in its place

4/3/05 - v1.36
-fixed not creating table entry for new bgcolors and saved variables
(fixed bgcolor error if you had an older version and recently updated)

4/3/05 - v1.35
-added ability to set background color for all unit types
-added options to pick background colors that uses color picker
-rearranged options menu checkboxes to optimize space a bit
-added ability to select a unique background color for units which are in the same guild as 
you

4/2/05 - v1.34
-added option to turn off WoW's default tooltips for units (when TipBuddy is visible)
-tweaked color scheme for names

4/2/05 - v1.33
-fixed Corpse text showing up
-fixed tip updating on unit (if you moused over during a delay) even if you had that type disabled
-if a creature has no class or family and is defined as "Not specified" for CreatureType, I now report it as "Creature"
-fixed typo in readme.txt

4/1/05 - v1.32
-Added TipBuddyAnchor
-added options to use TipBuddyAnchor
--enables you to anchor TipBuddy to the anchor and position it anywhere on screen
-TipBuddy now has a delay for going away
-added option to set the delay time (0-4 seconds) 
-TipBuddy now fades out after the delay
-added option to set the fade time (0-4 seconds)
-enabled you to bring up chat when options window is open
-enabled you to take a screenshot with options window open
-added a readme.txt
-added slash commands to bring up the options menu: 
--/tipbuddy or /tip

4/1/05 - v1.31
-Fixed font size scaling badly
-Increased font size scale range (can now get smaller and much bigger)
--Default scale increased a tad