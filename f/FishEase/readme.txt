FishEase
by Aalny
version 1.2.7
(forked from Mugendai's original TackleBox included with Cosmos)

Download Location:
http://wow.dvolve.net/dropbox/wow/FishEase_1.2.7.zip
Mirrors:
http://www.wowinterface.com/list.php?skinnerid=14585
http://www.wowguru.com/ui/author/aalnydara/
http://www.curse-gaming.com/mod.php?authorid=1215

---------------------------------------------------------------------------
Description

This Addon helps people use the Fishing tradeskill more efficiently by
making it easy to cast and easy to switch between fishing gear and normal
gear.  When a fishing pole is equipped, right clicking will cause the
player to cast their line.  Also, clicking on the bobber will automatically
recast the line.  Type "/fishease help" in game for instructions on how 
to use the features.

It should be noted that Mugendai's original TackleBox from Cosmos was the 
starting point in making this version.  Many, many thanks to Mugendai and 
all those who helped write that original version.


---------------------------------------------------------------------------
Features

* EasyCast allows right-click casting while a fishing pole is equipped.
* FastCast allows automatic recasting after clicking the bobber.
* ShiftCast makes it so the Shift key must be pressed to use EasyCast.
* Switch command allows swapping between normal and fishing gear sets.
* Reset command clears all saved gear sets.
* Key bindings are available both to swap gear and cast your line. The key
  to cast your line will attempt to swap to your fishing gear first if
  needed.
  

---------------------------------------------------------------------------
Known Issues

* The German and French clients work. However, most of the French and some
  of the German output text is still in english. I don't have those clients
  to test with and I don't speak either language so I'll need help 
  translating.
* FastCast and ShiftCast are both dependent on EasyCast.  So if EasyCast is 
  off, FastCast and ShiftCast settings are ignored.


---------------------------------------------------------------------------
History

1.2.7
* Updated toc for 1.8.0 patch.

1.2.6
* Added support for boots in the fishing gear set due to the new boots,
  Nat Pagle's Extreme Anglin' Boots, from the fishing competition.
* Added key binding to cast your line.  If your fishing pole is not equipped
  when you press the key, it will swap your gear for you instead.

1.2.5
* Updated toc for 1.7.0 patch.

1.2.4
* Added a direct key binding to swap between fishing gear and normal gear.
  so you don't have to waste a macro slot anymore for the slash command.
  Suggested by Gohei27.
* Removed load spam.

1.2.3
* Updated toc for 1.6.0 patch.

1.2.2
* Fixed a bug for people using Click-to-Move.  It is now disabled while
  you're holding a fishing pole if EasyCast is enabled.  Thanks to Novbre 
  and nranking for the heads up.

1.2.1
* Fixed a bug where only 1 of 2 identical dual-weilded weapons would be
  re-equipped using the switch command.  Thanks to Richard for the heads up.
* Fixed a bug that would popup a nil error when fighting/looting while
  unarmed.  Thanks to Moonshadow for the heads up.

1.2
* Renamed Addon from TackleBoxSA to FishEase to avoid confusion with
  TackleBox in Cosmos and to try and make sure there are no namespace
  conflicts. (yes, it's a silly name, but my girlfriend thought it was cute)
* Code performance tweaks here and there.
* Fishing skill location is updated on spell update event rather than
  checking for every cast.
* Fishing skill location is searched for by icon texture rather than
  name which gets rid of another localization challenge.
* Fishing pole is now recognized by Texture rather than itemID. Not only
  does this automatically add support for the new pole, 
  "Nat Pagle's Extreme Angler FC-5000", but it also theoretically supports
  any other new poles that find their way into the game.
* Re-added hats to the saved gear sets per the request of some roleplaying
  type people who like a different look when they're fishing.
* Added a new "Shift Cast" toggle that when turned on requires the Shift
  key to be held down when casting with a right-click.  This is turned off
  by default.  To change the setting, use the /fe shiftcast command.

1.1
* Updated toc for 1.5.0 patch
* Gear sets and casting options are now saved per character. Sorry about 
  the delay on this one.  The 1.5 patch fixed the Lua environment in such 
  a way that doing this is much easier now than it would've been before.

1.0.3
* Thanks to Sylvaninox for providing more of the French translation.
* Minor internal code changes and some prep for per-character data saving.

1.0.2
* Thanks to Maischter for providing a more complete German translation.
* Fixes some string formatting so the translations would work better.

1.0.1
* Fixed an annoying bug that would reset your gear sets on every login.
  (forgot to remove some old code)
* Fixed a minor bug that would cause the saved gear sets to get confused
  if your saved main hand weapon was 2h and then you switched to 1h+shield
  combo.  Only the shield would end up getting equipped.

1.0
* Initial fork from TackleBox version 4150 on Curse-Gaming:
  http://www.curse-gaming.com/mod.php?addid=97
* Removed all remaining Cosmos related code
* Easycast and Fastcast are now on by default
* Since apparently the Lucky Fishing Hat doesn't exist in game anymore,
  hat saving has been replaced with glove saving because you can get
  gloves enchanted with fishing skill.
* Changed the core method used to find, examine, and equip items.  It now
  uses the item ID from the item link rather than the item tooltip.  This
  was primarily because searching for fishing poles based on tooltip was 
  problematic in different locales.  The change also has the pleasant 
  side effect that MUCH less data needs to be saved in SavedVariables.lua.
* Simplified the slash command processing code a bit.
* No more automatic macro creation because it was buggy and unneccesary.
  You can create your own macro with "/fe switch"
* The command help text was tweaked a bit for clarity and formatting.
* Renamed most of the internal variables so that theoretically nothing
  will conflict if the user has the Cosmos version installed as well.
  However, there will still most likely be issues because the slash
  commands are the same and who knows what'll happen if two addons
  try to do the same thing at the same time.
