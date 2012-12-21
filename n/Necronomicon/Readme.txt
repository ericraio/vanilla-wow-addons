Necronomicon is a Necrosis lookalike. It has about all the functionality of
Necrosis Lite. And the looks as well. But it's coded from scratch and only
uses the excellent graphics of Necrosis. It is written with effeciency in
mind and should not eat boatloads of memory.

Necromicon has a shardcounter, healthstone creation/using/trading,
summoning, mount button, a pet menu and spell timers.

There is currently only one option to the slashcommands. /necro reset
Which will reset the frames to their current position.

Future additions will be:
- Optional tooltips when hovering the buttons (pro locks don't need those,
so they can be turned off)
- Shading of buttons that have a cooldown (healthstone used etc).
- Detection of AQ mount for AQ40 so it'll work with the mount button.

What will I not code:
- Extra bloat and too many config options. Don't like it, don't use it.
- Servitude like functionality. Real warlocks manage their pets themselves.
- Shard sorting/destroying etc. Get a shardbag and use it.

Dependancies: Ace, Timex

Blue/Turquois/Orange/Rose/Violet/X Textures are curtsey of Eliah, from
EU-Ner'zhul server and Necrosis LDC. Credits go to them.

CHANGELOG:

Version 0.6
- Added keybindings for most important functions.
- Added frame locking /necro lock.
- Added 6 textures from Necrosis LDC, credits go to Lomig and his team.
/necro texture.
- Fixed several bugs in the spell timers.
- Cleaned up the localization files some more.

Version 0.5
- Rewrote most of the spell detection code. It's a lot cleaner now.
- Rewrote the structure of the localization files. It's a lot cleaner now.
- Added German and French localization: These need testing!
- Added resisted and immune checks for the spell timers
- Added Curse of Tongues to the spelltimers
- Fixed the Soulstone aborted detection, it wasn't working before.

Version 0.4.1
- Fixed stupid typo.

Version 0.4
- Added soulstone expired and shadowtrance sounds. Off by default. /necro to
see the options.
- Added Fear and Death Coil timers.
- Added Fel Domination key modifier. You can now set ctrl, alt or shiftclick
to fel domination + summon
in the pet menu. Off by default.
- Added Close on Click option for the pet menu. Off by default.

Version 0.3.2
- It's getting old, but another fix for tooltips and action bars.

Version 0.3.1
- Remove the return hooks. Read in the SuperSelfCast thread it might cause
problems. Seems to
work fine for me still.
- Calling the original functions at the top of the hooks now.

Version 0.3
- Another attempt at fixing the actionbar tooltip problems. When there is no
lefttext on the tooltip
it should now give an error in the chatframe. I don't get the erors myself
so it's hard to test 

Version 0.2
- Hopefully fixed the tooltip problems
- Fixed a typo in the spell rollback when cancelling a spell
- Added b+ for Worldboss, r+ for rare elite, + for elite and r for rare to
the spelltimers

Version 0.1
- Initial Release