Low Health Warning:
This addon adds a visual fullscreen effects when your health or mana dips below certain values. It is meant to alert you, and it will not automatically drink a potion or whisper your local healer for aid. If you manage to miss the effect, it will try harder when you get below a critical value. Sounds like nothing special? Well, you really have to see it in action.

See screenshot for a preview of the effect; it will flash in and out along the edge of your WorldFrame. The mana effect is identical but blue.

Behind the scenes:
The textures and methods for animation used are already in the game data files, which makes this small addon quite powerful. It also means that credit should go to the Blizzard designers. Their purpose with these effects were almost the same as mine (the blue effect I use for low mana is meant to show when you get stunned or in other ways lose control of your character). They left the effects hidden and deactivated though, and I thought it could be a good idea to make them usable.

Usage:
/lowhealth: open configuration window. All settings can be changed here.

Changelog:
Version 2.0 (11000):
  - The addon is now known as Low Health Warning.
  - Feature: Heartbeat sound effect; slight impact on performance due to OnUpdate usage.
  - Feature: Health and mana flashes can now be set to use a 'variable beat' algorithm, similar to the one the heartbeat sound is using. This will, under most conditions, keep the flashing and the heartbeat synchronized.
  - Feature: Added option to do the /healme emote when health is critical (disabled by default)
  - Update: All three effects (sound, health, and mana) can now individually be set to In Combat Only.
  - Update: Revamped settings window, settings code and localization. I need help to translate some strings again (see localization.lua).
  - Update: You can now disable the low health warning while keeping the mana warning active.

Version 1.6.2 (11000)
  - Fix: the 'In combat only' setting now works again (I broke it in 1.6.1).

Version 1.6.1 (11000)
  - Update TOC to 1.10.

Version 1.6 (10900)
  - Localization: Korean translation added (thanks Mars!).

Version 1.5 (10900)
  - Localization: French translation added (thanks Trucifix!).
  - Localization: German translation added (thanks Myr of Gul'dan!).

Version 1.4 (10900)
 - Fix: Transitions between critical to regular flashes are smooth now.
 - Quirk: Configuration window now opens on '/lowlife' too.
 - Localization: All strings can now be localized. See localization.lua for details.

Version 1.3 (10900)
  - New feature: Mana warning can now be disabled.
  - New feature: Combat only mode
  - Fix: Druids should no longer see the mana flash while shapeshifted.

Version 1.2c (10900)
  - Fix: The health flash is now correctly showing.
  - Fix: Removed debug calls (probably caused nil value errors).

Version 1.2 (10900)
  - New feature: A configuration window:
      * Command: /lowlife settings
      * Toggle the addon on or off.
      * Regular and critical thresholds for both health and mana.
  - Fix: Both flashes are now correctly positioned.
  - Improvement: Alot of code has been improved.
  - Localization: Added basic localization.

Version 1.1 (10900)
  - Two thresholds; one regular (at 30%) and one critical (at 15%).
  - A blue effect for casters.

Contact:
You can send questions, comments, or complaints to silentaddons@gmail.com