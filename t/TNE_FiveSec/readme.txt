
Introduction:
FiveSec monitors your mana regeneration. It displays a bar — similar to the casting bar that shows when you cast a spell or use your hearthstone — when your mana regeneration is disabled. It is meant as an aid for casters to use their mana better.

Each spell you cast disables your mana regeneration for 5 seconds. If you are about to cast two spells - one with casting time and one instant — it is better to begin with the slow spell. Regeneration is active until the slow spell is completed, and the instant spell will only add a split second to the five you already got.

Configuration:
No initial configuration is needed to use FiveSec.

Commands (use /fivesec or /fs):
/fivesec on|off: Enable or disable FiveSec. 
/fivesec mode standard|reverse: Switch between increasing/decreasing bar
/fivesec reset: Restore position above the casting bar. 
/fivesec move on|off: Toggle on or off to move the frame.
/fivesec hidden on|off: Toggle 'passive' mode on or off (for Perl users).
/fivesec alpha 0.1-1.0: Set bar transparency.
/fivesec scale 0.5-2.0: Set bar scale (default scale is 0.8).
/fivesec about: Show addon information.

Localization:
FiveSec is currently only in English. Open localization.lua for further details if you want to contribute with translations.

Homepage:
http://www.curse-gaming.com/mod.php?addid=3319

Contact:
You can send questions and comments to silentaddons@gmail.com


Changelog:
Version 2.1.2 (11000)
 - Fix: An (experimental) fix for channeled spells.
 - Fix: Alpha values will be saved between session as intended.

Version 2.1.1 (11000)
 - Feature: The bar is smaller by default, and can now be scaled using /fs scale <0.5 to 2.0> (standard scale is 0.8).
 - Feature: You can change alpha value of the bar using /fs alpha <0.1 to 1.0> (default alpha is 1.0).
 - Feature: It's possible to change the timer format with /fs fraction on|off (default is on).
 - Update: OnUpdate limited to 25 updates per second (reduced to 10 updates per second in hidden mode).
 - Fix: Restored on-next-melee (Raptor Strike) detection.
 - Fix: The bar will no longer display after the next action when a spell has failed.
 - Fix: Adjusted a few minor bar behaviour bugs.

Version 2.1.0 (11000)
 - Feature: FiveSec now displays the time remaining to the next tick of mana.
 - Feature: The bar is green instead of blue when you have a buff which enables mana regeneration (Aura of the Blue Dragon, Innervate, Spirit Tap)
 - Feature: A 'passive' mode to make the bar go away while keeping the FiveSec functionality (for Perl users, /fs hidden on|off)
 - Added: Advanced slash commands to link/anchor the bar to another frame (/fs link targetFrame, /fs anchor point target targetPoint x y)
 - Removed: Selfcasting (it's out of scope for this addon).

Version 2.0.1 (11000):
 - Fix: Corrected a bug that prevented the bar to display under certain conditions.

Version 2.0.0 (11000):
 - Fix: FiveSec no longer requires 'Enhanced tooltips' to work.
 - Note: Any saved variables from version 1.x will be removed due to code changes.
 - Update: Changed TOC version to 1.10.
 - Update: A new mode allows you to move the FiveSec bar easier than before.
 - New: FiveSec will now automatically detect if you use mana and enable or disable itself:
     * Shapeshifting druids will save some minor CPU power when in furry forms,
     * Energy and rage users shouldn't be using FiveSec in the first place.
 - New: Integrated 'right-click selfcast'. Right-click any action to cast on yourself.
 - Experimental: FiveSec will now automatically interrupt when you gain the Blue Dragon aura or Innervate.
 - Fix: Revamped spell interruption detection (it works without movement hooks now):
     * Expect a small delay (at most 0.5 seconds) before new casts or interrupts affect the bar.
 - Update: Changing mode between reverse/standard is smoother now.
 - Update: Fading is now handled by Blizzard UI code.
 - Update: Changed the name of two global variables:
     * REGENERATING_MANA: true if mana regeneration is enabled,
     * TOTAL_MANA_REGENERATED: how much mana gained or lost since regeneration was enabled/disabled.
 - Update: Now using a later version of utilities shared with my other addons.
 - New: Added commands: /fs move on|off, /fs selfcast on|off
