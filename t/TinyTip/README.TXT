What is TinyTip? Well, it started out as just a simple upgrade over AF_Tooltip_Mini and exploded from there. Now it shares no code with what it used to be, becoming something more, while still staying true to its name. The core of TinyTip is basically just an upgrade over AF_Tooltip_Mini, a small file around 24KB. The more modules you allow to load, the more this value increases. The goal of TinyTip is to allow you to mix and match your modules while keeping the smallest memory footprint possible. All files except TinyTip.lua and its locale files are optional. You can take a look below, I've listed the optional files as "not required". If you don't use a file's features, you can safely remove it from the TOC.

Anyway, as you can guess, TinyTip changes the look of your GameTooltip. Here are the features found in core:

--------------------------------------------------------------------------------------
TinyTip (core)
--------------------------------------------------------------------------------------

In TinyTip.lua (required)
- Name, backdrop, and border (optional) colouring by reaction (Hostile, Friendly, etc.)
- Class coloured with raid colours.
- Level coloured by difficulty.
- Creature Type (Imp, Cat) given for Pets.
- UnitClassification (Humanoid, Undead, etc.) given for NPCs.
- Elite Status (Elite, Rare, WorldBoss, Rare Elite) added when applicable.
- (Tapped) for Tapped, (Corpse) for Corpse

- Optional Guild Names displayed. (on by default)
- Optional backdrop coloring for friends and guildies. (on by default)
- Optional Honor Rank Name or Number. (on by default)
- Optional "Hostile", "Friendly", etc. reaction text for the colour-blind. (off by default)
- Optional Compact Tooltip mode.
- English, German, French, and Chinese localization, and partial support for other clients.


In Embedded TinyTipAnchor.lua (not required)
- Positioning Options (Anchoring, Offsets)


-----------------------------------------------------------------------
In LoadOnDemand Addon TinyTipExtras

Note: Only loaded if you use at least one of the options included.
-----------------------------------------------------------------------

In TinyTipTargets.lua (TinyTipExtras, not required)
- TargetOfTarget information - what is this tooltip's unit targeting?
- Search through Party members targeting this unit, or...
- Search through Raid members targeting this unit.

In TinyTipIcons.lua (TinyTipExtras, not required)
- PvP Rank Icon
- Buffs and Debuffs
- Raid Target Icon

In TinyTipExtras.lua (required)
- Mana/Rage/Energy Bar
- Extra Tooltip which can show other addon's and TinyTip's information


-----------------------------------------------------------------------
In LoadOnDemand Addon TinyTipOptions

GUI Options, use /tinytip or /ttip to bring up the menu.
Only loaded if you use that slash command.
-----------------------------------------------------------------------


-----------------------------------------------------------------------
Troubleshooting
-----------------------------------------------------------------------

Q: TinyTip is preventing another tooltip addon from working.
A: Go into that other addon's TOC file and add/change this line to include TinyTip.

## OptionalDeps:

Q: Help! I'm getting incredibly long / infinite load times with TinyTipExtras / TinyTipOptions!
A: There is a bug with Ace2 addons (specifically, AceLibrary) which was fixed in the latest revision. If possible, update your addons.

Q: I'm getting an error from TinyTip, or an option isn't working right.
A: 1) Check my WoWI portal to see if it's a known issue, and for updates.
   2) Maybe your files are corrupt. Delete TinyTip, TinyTipExtras, and TinyTipOptions, then re-download them and install from stratch.
   3) Your Saved Variable database may have gotten corrupt somehow. Try using /tinytip default and then /tinytip confirm to reset it.
   4) If resetting your options doesn't work, exit WoW, delete all your Saved Variable files for TinyTip (global and per character), then restart WoW.
   5) Leave a bug report on my WoWI portal.

Q: Where's the secret cow option?
A: There is no secret cow option.

