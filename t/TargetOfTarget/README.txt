TargetOfTarget -- Health of Target's Target, HoTT

Itchyban of Veeshan


http://www.curse-gaming.com/mod.php?addid=1161



v2.2 Beta 1 -- Highlights of Enhancements:

* Works for melee players
* Does not affect Combo Points
* Does not interrupt melee
* Does not affect "tab" targeting
* Is not interrupted by "glowy hand" spells
* Is not interrupted by inspecting another player
* Should have virtually no performance impact
* Health updates are immediate for raid/party members and pets
* Health updated for others should be highly reliable
* WYSIWYG positioning for custom UIs or "fixed" positioning
* "Plays with" AddOns such as DefendYourself



What It Does:


Gives you a small frame under the buffs of your target frame that indicates what your target's target (ToT) seems to be and a health bar for the ToT.

If you are the target of your unfriendly target, it will print

--- AGGRO --- AGGRO ---

in white in the area above the middle of the screen where you see errors like not enough mana or out or range. It does this only when the ToT changes from something else to you so you don't get spammed. (This message fades like any other "error" message, independently of you retaining or losing aggro from that target.)


Basic Usage:


/tot on    -- to enable (originally loads in the "off" mode)
/tot off   -- to disable

(or /toton and /totoff)

/tot help

/tot params -- WYSIWYG positioning and changing/disabling of aggro message



Click on the ToT area to target the ToT


A yellow name indicates that the ToT information is from the most-recent check.

A white name indicates that it has been held from the last time the mob had a target and that the target appears "stunned"


A green-to-red shaded health bar indicates that either the value is as fresh as WoW provides for your party, or is no more than 0.5 s old. 

A white shaded health bars indicates that the value is than 0.5 s old.
(Your self/target/party frames' health bars seem to be updated every 0.4 s while changing quickly in combat.)

Holding down the [Shift] key before you click to leave the character select screen (and keeping it down) will force HoTT to load in the "off" state.



Customization:

See CUSTOMIZATION.txt for settings for many common custon UIs as well as how to change or disable the aggro message.




General Warnings:


Stunned, Poly-ed, etc., mobs (and apparently even players) have no target, even if aggro. If a mob (NPC) that is "AffectingCombat" is your target and it has no target, then the last target is retained in the display (until the mob gets a new target). This is indicated by white colored text, instead of the usual yellow. For player targets, the display does not retain the "last known" target.




Known Issues:

* Behavior in duels and with non-PvP members of the opposite faction may be limited by the information that Blizzard supplies to the UI.  This has not been checked yet.



Questions, Suggestions, Bug Reports:

Please use /tot version 
and include the two version numbers it displays in your General chat with your report.




Special thanks to the great healers in Sovereign who inspired this, all those that tested and are continuing to test, and several contributors to the Blizzard boards (especially Iriel for some key insight into WoW event and Lua object mechanisms).







Changes:

TOT-2_2-BETA1
2005/06/08

* Rewritten to take advantage of the 1.5.0 API

* No target changes performed; related issues now moot, including:
- Melee use
- Combo Points
- TargetLastEnemy
- "Tab" targeting
- "Glowy Hand" spells
- Non-PvP members of opposite faction
- Target-changing AddOns such as DefendYourself
- "Load" should be no greater than adding an additional party member

* Name truncation added

* Health updates for raid/party members and pets as good as WoW provides

* Health updates for other ToT are generally as good as well

* "Touch-to-cast" added for ToT

* WYSIWYG positioning, no need to directly change variables

* AlternateUIs.lua and LocalUIs.lus no longer used or needed



TOT-1_1
2005/05/13

* Support for "highly modified" target frames

* Optional audible alert on aggro (user suggestion)

* Optional positioning near party frames (user suggestion)

* /tot and /hott commands added




TOT-1_0_1
2005/05/11

* Pauses when Inspect window is open

* Unreadable versions of HoTT_Settings are saved to HoTT_Settings_Unparsed




TOT-1_0
2005/05/10

* Saves and restores settings, including on/off state

* Responsiveness is vastly improved
  - Idle timer for "quiet" times
  - Detects your target entering combat if idling
  - Enters and leaves (paused) state immediately on detection

* Tab targeting briefly "holds off" ToT checks to allow cycling through targets

* Targeting yourself now properly indicates yourself as the ToT

* Display positioning now tracks buffs properly through target changes

* Resolved target-frame drop-down menu interruption

* [Shift] on load forces HoTT to start up in the "off" state




TOT_BETA-0_97s
2005/05/07

Minor feature patch, no changes beyond:

* Removes "swish-swish" sound when doing ToT checks

* Properly pauses when target menu is selected




TOT-BETA-0_97
2005/05/04

Initial public beta release.




Previously Resolved Issues:


* Targeting a stunned or Poly-ed mob after having a valid ToT from a different target should now respond with a target of the new target.

* Targeting a party member (i.e., clicking on their portrait or using F2-F5) that is not in the "local area" gives a "no target" message periodically. Fixed in 0.97

* While the frame should move down properly if your target has two rows of buffs, this has not been tested Tested, though bar may be in lowest position for some mobs not showing buffs. Fixed in 0.96.

* There seem to be some mobs where the frame seems lower than it should be by about half its current height. Fixed in 0.96.

* If they player has debuffs only (e.g., rez sickness) the frame will appear over them. Fixed in 0.96.

* When switching targets, the ToT may not update immediately, or show an unexpected name. Should be improved in 0.96.







$Header: /usr/local/cvsroot/WoW/Interface/AddOns/TargetOfTarget/README.txt,v 1.13 2005/06/08 16:23:39 jeff Exp $

