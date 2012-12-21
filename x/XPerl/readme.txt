A much enchanced version of Nymbia's Perl UnitFrames, with many many additions and improvements.

Much care has been taken with code size, memory load, memory usage per cycle and so on. LuaProfiler/OnEvent mods used extensively and regularly to ensure that X-Perl does not do more work than is absolutely necessary.

With that in mind, the event system was totally re-written, and is as kind to system performance as possible. The majority of events are disabled while zoning to alleviate any event backlog issues. And where most addons use 1 event handler per unit frame, which although standard, the alternative has improved X-Perl's performance. By using single main event handlers, we can route the events to appropriate units. So, for example, when a single UNIT_HEALTH update is fired, then just a single raid frame or party frame etc. gets the event, rather than 40 raid frame's handlers, 4 party and so on. Nymbia's Perl used to do a lot of crazy full frame udpates all over the place, eating away at CPU cycles. This was all fixed to only update what was necessary based on events.

Liberal usage of local functions to cut down compiled code size, and increase speed since functions are called directly rather than by name. Every time you have a global function, you have a global string name associated with it, so size in the global environment saved where possible.

Totally new options window including all X-Perl options and access via minimap icon.

Raid Frames, buff icons, MT list units and some other portions or X-Perl are Created on demand. Saving a lot of time and memory at system startup. Defering the creation of many parts of X-Perl to when they are actually required. And of course, most often outside of raids they are never required and are never created.

Pull out raid frame replacement (The thing you do when you drag out a class name or group title from the Blizzard Raid UI). Using the same raid frames templates as the other X-Perl raid frames, and replacing internally the code Blizzard uses to give pull out frames.

Raid pets can be view from the raid Pull Outs. Either Ctrl drag the class/group names from the Blizzard Raid UI, or use the dropdown menu of the pull out frame and select the Pets option. Pets will be shown for those units instead of their owners.

Raid Target icon support for Target, Target's Target, MT Targets.

Raid tooltip will show combat rezzers available (druids with Rebirth ready and any normal rezzers out of combat) if you bring up tooltip of a dead person (or very soon available).

'In-combat' indicators for Pet, Target, Target's Target, Party, Party pets, Raid, MT Targets.

3D Portraits for player, pet, target, party. Optional. Of course this may degrade your framerate somewhat because you are displaying more 3D character models that without this option. But some like it pretty, and it does look cool.

Red and Green combat flashes for frames when player, pet, target, party, partypets, raid take damage/heals. Useful indication of things happening.

Debuff Highlighs in standard debuff colours on all friendly frames. Priority given to show debuffs that YOU can cure first.

Added time left on party member/target buffs/debuffs when in a raid, these depend somewhat on CTRA/oRA sending appropriate information over the addon channel, although some of it can be determined at run time by X-Perl, when a player gets a buff for example, we know how long it should last, and therefor when it should expire.

Frames can now fade out when closing.

Target's Target history. Useful for catching those over agroers who's name only pops on target's target for a split second, now it'll build a small list of names under the target's target.

Configurable colours for borders and backgrounds. Including class coloured names, and configurable reaction colours.

Perl_RaidHelper sub-addon
-------------------------
Assists View
Will show anyone from raid assising you with your target, and can also show healers or all plus known enemies targetting you.
Tooltips for the same also available (on player and target frames) if you prefer to not use the main window.

Raid Helper
Replaces CTRA MT Targets window (or oRA MT Tank List, requires; oRA_MainTank to be loaded, but no others), and doubles as a replacement for the Perl RaidFrames warrior targets.
It also provides a list of known enemy units that are NOT targetted by tanks in the the MT List, and these can be auto targetting by hotkey which you can set up.
Indicator shows which target you are on.
Frames will be coloured to show if tanks have duplicate targets.

Perl_RaidAdmin sub-addon (WORK IN PROGRESS)
-------------------------------------------
Raid Admin
Save/Load raid roster setups
Only does direct save and load for the moment, but more to come (templates and such).

Item Check
Replacement for /raitem /radur /raresist /rareg. Use the old commands before, or drop items in the left item list.
Query button will perform /raitem on all ticked items (query always includes dur and resists) and you can then view and review all the results whenever, without having to re-query each item.
Includes everyone in raid, so you don't have to work out who doesn't have items, it'll list them with 0 instead of no entry.
Active Scanner to check raid member's equipment for the item selected. So you can be sure that people actually have the item worn (Onyxia Cloak for example), without having to go round single target inspecting everyone who 'forgot' to install CTRA for the 50th raid in a row.

Supported Addons
----------------
CT_RaidAssist / oRA. Shows tooltip info and player status, replaces MT Targets List, improves raid frames, shows player status, resurrection monitor, buff timers aware.
MobInfo-2 / MobHealth3 - Shows target health from MobHealth database.
DruidBar - Shows druid mana bar from DruidBar when shapeshifted.
CastParty, GenesisClicks, Clique, SmartHeal, GroupHeal, ClickHeal, Benecast, JustClick compatible.

TODO
----
Player Targets view to go with MT Targets.
Optional filter for the dmg overlay on target portrait to self damage only.

Known Issues
------------
Large non-standard fonts can exclude all text in frames. Please let me know which ones, where, when, what addon, settings etc.
Moving raid frames occasionally moves incorrect units when people join or leave the raid.
Raid buff tooltips sometimes incorrect. Working on this as top priority.

--
X-Perl by Zek <Blood Cult> - Bloodhoof-EU
