C'Thun Warner 1.06


Author:
-----------------
Alason aka Freddy
http://black-fraternity.de (PM to Alason)
CThunWarner@freddy.eu.org


Maintainer:
-----------------
Cootie <villain>, Whisperwind realm
PM Cootie @ curse-gaming.com


Installation:
-----------------
Extract the .zip archive into your \World of Warcraft\Interface\AddOns directory.

Type /ctw to activate C'Thun Warner, when needed.


Notes:
-----------------
Provides information for C'Thun raids.

There is an icon that changes in color:
Red: DANGER! Risking a chain beam. Move.
Green: Safe. Everyone is 10 yards away.

Players too close are shown in a list. There is an audible beep.

Phase 2 will list players in the stomach.

The lists are color-coded. Anyone in your party is listed in purple.

An alarm will sound and a timer will start when C'Thun is weakened.


Commands:
-----------------
/ctw on/off
-- Turn C'Thun Warner on or off.

/ctw alarm on/off
-- Turn the alarm sound for the weakened phase on or off (default on).

/ctw sound on/off
-- Turn the beeping sound on or off (default on).

/ctw timer on/off
-- Turn the timer for the weakened phase on or off (default on).

/ctw soundphase2 on/off
-- Turn the beeping sound on or off for phase 2 (default off).

/ctw list 0..40
-- Set how many players are shown in the range check (default 4). 0 disables all lists.

/ctw scale 1..20
-- Set the scale of the icon (default 2).

/ctw reset
-- Reset the default position and scale of the icon.

/ctw lock
-- Lock the icon so that it is not moveable with a mouse.

/ctw unlock
-- Unlock the icon so it is moveable with a mouse.

/ctw fake
-- Fake the full frame to help orient it.

/ctw check
-- Check the raid for C'Thun Warner. Only works with versions 1.06 and up.
** When used by a raid leader or assistant in AQ, C’Thun Warner will turn on for all raid members.

/ctw ooc
-- Reset sound if unwarranted beeping occurs.
** To minimize occurrences, turn off C'Thun Warner if not raiding C'Thun and stay in range of Eye of C'Thun when it dies.

/ctw help
-- Show the command list in the game, without these descriptions.


Changes:
-----------------

Version 1.06
- Old settings will be lost. Settings are now saved per character.
- Changed text. New command feedback. New tooltip color-code.
- Changed scale default. Default is now 2. Old default was 1.
- Fixed the alarm and timer for the weakened phase.
- Fixed beeping sound after a raid wipe.
- Added C'Thun Warner auto-closes on victory.
- Added "/ctw check" Ready Check.
- Added "/ctw lock" to saved settings.
- Added "/ctw alarm on/off" command and a saved setting.
- Added "/ctw timer on/off" command and a saved setting.
- Added "/ctw fake" command.
- Added "/ctw help" command list.


History:
-----------------

Version 1.05
- Removed 5 yards check
- Wont check distance for pet's any longer
- Wont check if a player is in the stomach if he's death
- Changed toc to 11200
- Wont show debuff count, due to it was often incorrect

Version 1.04
- Renamed addon to CThunWarner
- Removed the mouse over tooltip
- Added timer and alarm sound for weakened phase
- Added list with players who are currently in the stomach of C'Thun (red colored name means the player is in your party)
- "/ctw soundphase2 on/off" added, allowes you to disable sound in phase 2
- "/ctw ooc" added, sometimes it doesn't stop beeping, this helps

Version 1.03
- Range 5-10y => Button will become yellow and it will beep normal (once a second)
- Range 0-5y => Button will become red and it will beep very fast (twice a second)
- "/ctr list 0-40" added, shows an always visible list of players which are to near to, you can set a max count of palyers to show
- "/ctr lock" added
- "/ctr unlock" added

Version 1.02
- Wont check own pets anymore
- "/ctr scale" added

Version 1.01
- Pets will be checked now
- Only living players will be checked
- Changed range to 10y
- Fixed beep sound
- Added "/ctr reset" to reset the position
