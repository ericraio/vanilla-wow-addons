CountDoom v0.48
author: Justin Milligan
updated by: Scrum (Kilrogg server - Horde)

CountDoom is an Add-On for warlocks.  Originally, it only displayed a counter on the screen whenever a demon is enslaved. The goal was to give the warlock a warning as enslave approaches its maximum duration.

CountDoom can play sounds at specific times to grab your attention.  Currently, a sound may be played when a spell is getting close to wear off and when it finally wears off.

In order for CountDoom to play user defined sounds, you must place the .wav files in the
Interface/AddOns/CountDoom/ folder.  NOTE: In the original version, the .WAV files were located in /world of warcraft/Data folder.  The older folder is no longer used by this AddOn.  This zip contains 2 sample sound files, but feel free to use your own.

To tell CountDoom which sound files to play, you use the /countdoom or /cd commands:

To enable or disable CountDoom
/countdoom <enable|disable>

To toggle whether or not a sound is played at warning and end marks
/countdoom play

To toggle whether or not a message is displayed in the text window.  It cycles through 'never', 'local', 'party', 'raid' and 'all'.  Added in v48, ability to announce to a 'channel'.
/countdoom announce

To toggle whether or not a timer will flash when warning time exceeded.
/countdoom flash

To display spell information
/countdoom <spellabbreviation>

To toggle a spell timer (useful for disabling DoTs if tracked by another addon):
/countdoom <spellabbreviation> toggle

To move the timers around, you need to unlock the timer display.  This can only be accomplished via
/countdoom <unlock|lock>

To test out a timer without without expending mana or wasting a shard
/countdoom <spell abbreviation> <start|end>

To cycle through various layouts.  Cycles through horizontal, vertical and textonly layouts
/countdoom layout

To cycle through 3 different sizes (horizontal and vertical layouts only)
/countdoom scale

##NEW IN 48##
To add a delay before removing timers after leaving combat.
/countdoom ooc <seconds>

To add a delay before removing timers after expiration.
/countdoom expire <seconds>

To toggle enabling/disabling of fractional seconds display in timers.
/countdoom hseconds

To set the channel for announcing timer events
/countdoom channel <channel name>


DEBUG:
To test out the timer without wasting a shard.
/countdoom enslave <start|end>

Spell abbreviations:
banish - banish
coa - curse of agony
cod - curse of doom
coe - curse of elements
coex - curse of exhaustion
corruption - corruption
cos - curse of shadow
cot - curse of tongues
cow - curse of weakness
enslave - enslave
fear - fear
howl - howl
immolate - immolate
siphon - siphon life
coil - death coil
seduce - Succubus seduction
spelllock - Felhunter spell lock support


v0.48 updates:
- Support for 1.10 client.
- Removed CameraOrSelectOrMoveStart hooking since it is no longer viable.
- Hopefully, fixed icon problems causing crashes.
- Added fractional seconds support courtesy of FuNkY MoOsE.  This is short term logic.  Longer term will be customizable text capabilities.
- Added a script function to check if your target has a timed debuff.  TargetHasMyDebuff( spellAbbreviation ) will return true if you have an outstanding timer for your current target otherwise false.  Courtesy of guildmate Hexanna.
- Added a delay for out of combat.  It will wait N seconds before removing a timer.  During this time, the timer will go negative.  /
- Added channel announce support.  see /countdoom channel <channel name> and /countdoom announce.
- Added felhunter spell lock support
- Fixed problems with retrieving spell name and rank from tooltips in 1.10.
- Fixed some problems detecting curses on some non-english clients.
- Added support for conflagrate to remove immolate timers. (untested)

v0.47 updates:
- Support for 1.9 client
- Add text only timer descriptions.  Use /cd layout to cycle through layout modes.
- Add scale support.  Use /cd scale to cycle through 3 different scales.
- Add explicit deletion of timers.  Can shift-left click to delete a timer.
- Added GUI support for dragging / cycling layouts.
- Added different duration support for rank 1 versus rank 2 spells such as Banish.
- WAV files for timers now start with the spell abbreviation plus a suffix.  Example: enslavewarning.wav and enslaveend.wav

v0.46 updates:
- Resists and Immunes are better detected though not perfect.
- Added enable support
- Succubus seduction timing based on effect not casting.
- Support for 1.8 client.
- Added DeathCoil timer
- Added seduction timer changes based on Improved Succubus. (Thanks Morbain)
- Fixed several problems with spells in macros.
- A few compatibility fixes.


v0.45 updates: DOA.

v0.44 updates:
- Added preliminary support for Succubus Seduction. Might work for French UIs.  Need German translation.

v0.43 updates:
- Fixed problem with rapid spell casting losing a timer.
- added support for casting via macros using CastSpellByName.
- added 'Resist' support for spells.  See known issues below.

v0.42 updates:
- Fixed problem with interrupting a spell still showing timers.
- Fixed problem with targetting.  Targetting first tries last enemy then cycle 10 nearest enemies until and name/level match.
- added ability to toggle text flashing. '/cd flash' toggles flashing.
- added color coding to timer text.

v0.41 updates:
- Added German/French localization changes from user feedback.
- Updated README.TXT for command usage.

v0.40 updates:
- Added banish and DoT timers.
- Immune spell timers are removed.
- Resisted spell timers are NOT removed. Fixed in near future.
- Debuffs bumped off mobs are NOT removed and likely won't ever be.
- Added untested German / French client support.
- Added version 1600 client support.

v0.35 updates:
- Fixed compatibility issues with latest client patch.
- Added icon support.
- Changed architecture to support more warlock duration items (i.e. DoTs, etc.)
- Changed the commands to better align with future directions.
- Renamed the WAVs to better support future directions. (minute->warning) (break->end)

v0.3 updates:
- Fixed compatibility issues with latest client patch.
- Added a few debug commands to assist in testing w/o wasting a shard.
- Improved layout and text of counter.
- Added support for moving the counter to a new location.
- Moved .WAV file location to the AddOns/CountDoom folder.

Known issues:
- Banish that occurs immediately after a preceding banish (aka chain banishing) is sometimes discarded from the timers list because the banish detection logic checks debuffs on the target which could be late relative to the banish action wearing off.
- The method to remove timers for 'Resist' and 'Immune' key off chat combat messages.  If you are too far from the target, the message won't be seen and the timer won't be removed.
- Some spells are not being timed in all languages. Banish, Enslave Demon, Curse of Elements and Curse of Agony have been reported not working on the French version.

Todo:
- Add 'Evade' support.  'Your <spell> was evaded by <mob>.'

Credits:
Thanks to Justin for this valuable addon.  Also, thanks go out to the authors of the CT_timer mod.  I lifted the mouse dragging logic from that addon into this one.  Also, thanks to all the other addon makers out there.  Without yours, I surely wouldn't have updated this one.  

Final Note:
To my fellow warlocks out there on Kilrogg server, give me a hollar if you find my updates useful.  I have a few ideas on extensions to this but I'll wait to see if there is interest in this base addon.
