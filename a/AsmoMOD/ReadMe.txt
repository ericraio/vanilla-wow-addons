-==AsmoMOD Features==-
- Automatically use the PvP Trinket when you lose control of your char (Works for fear/stun/charm/sleep/etc), but if you have WoTF it will use that first to dispel fear/charm.
- Mana Conservation by cancelling healing spells if your target's health is above a set percentage (See commmands for more detail).
- Automatically repair when you talk to a merchant.
- Automatically join groups when invited.
- Automatically join battlegrounds when the box pops up (No more hearing "I was afk and missed the queue, sorry guys").
- Automatically release in battlegrounds to speed up ress time.
- Automatically accept ressurects.
- Automatically accept summons.
- Automatically cast find herbs/minerals so that it is always on you.
- Reset groups with the push of a button.
- Automatically use Riposte if you are a rogue.
- Automatically use Execute if you are a warrior.
- Automatically use Overpower if you are a warrior (And in the correct stance to use it).
- Automatically use NS heals or NS chain lightning at the push of a button. If you were targeting nothing or an enemy NSheal heals you, or if you are targeting an ally it heals them. It then targets whatever you were targeting before you used the function, and if what you were targeting died, the nearest enemy. 
- Automatically use Feign Death + Trap in easy slashcommand form.
- Automatically cast NS heal on yourself if your health drops below a set percentage.
- UI Menu so that each feature can be turned on and off individually.

-==Commands==-
- To open the menu simply type /asmo
- Type /asinvite PLAYERNAME to reset an instance with the help of an ungrouped player.
- To use NS-heal simply make a macro that says /nsheal.  Just put it on your hotbar and click/press it to execute.
- To use NS-lightning simply make a macro that says /nslight.  Just put it on your hotbar and click/press it to execute.
- To use feign+trap simply make a macro that says /feigntrap.  Just put it on your hotbar and click/press it to execute.
- Mana Conserve works the same way all the other automatic functions do, you push any key on the hotbar to execute its check.  So if you are spamming a heal button on your target, and the target's health drops below a set percentage, it cancels the spell.  This is done auto-matically if the feature is enabled.  Please note that this STILL allows you to pre-heal, because if you do not push the healing button a second time after the initial cast then the spell will not be cancelled.

*NOTE: For the Auto-PvP trinket, Auto-Riposte, Auto-Execute, Auto-Overpower and Auto-NSHeal features you must push/click ANY key on any of your hotbars for them to execute.  As most players are spamming keys, this should be unnoticeable. Zooming in and out will also cause them to execute.

-==Changelog==-
v1.82 
- Zoom in and zoom out should now execute all automatic functions as well as any key on your hotbar.
- Updated the toc for patch v1.11 of WoW.

v1.81
- Auto-PvP Trinket will now also work for alliance.
- Improved Auto-Riposte coding slightly for efficiency.  Users should now notice riposte casting only when it is useable and you have enough energy.
- Automatic casting of find herbs/minerals will no longer cast in BGs, or while in combat.  It will now wait until you are not in a BG and not in combat to cast the spell.
- Auto-overpower added upon request.

v1.80
- Auto-NSheal now works while moving.
- The PvP Trinket should now correctly execute 100% of the time.
- SpellID functions were changed to totally eliminate errors when options were enabled for incorrect classes.
- Feign+Trap slashcommand added.
- Auto-cast of find herbs/minerals added.
- Mana Conservation added!

v1.70
Several features were drastically changed due to blizzard's removal of movement hooks.
- Auto-Riposte, Auto-Execute, and Auto-Wotf/PvP Trinket were switched from movehooks to hotbar actions.  Now instead of movement keys and right-click you must push any button on your hotbar to execute these functions.
- NSHeal and NSLightning were removed from hooks alltogether, they now work independently.
- Auto-NSHeal was added.
- Several features were removed that blizzard has patched into the game themselves.

v1.62
- Nsheal and nslight were broken with the UI menu, they are now fixed.
- Fixed a problem where if you switch accounts several times(And AsmoMOD had never been used on one account) you would get error boxes.

v1.61
- Updated for patch 1.9 of WoW (The Battlefield features were producing errors based on blizzard's new multiple queue system).

v1.6
- Added a UI menu to make management of functions much easier.
- Improved the auto-reset group command to work more efficiently.
- Changed auto-execute coding slightly.
- Added the ability to disable nsheal and nslightning directly to eliminate errors.
- Fixed errors where if you enabled riposte, execute, nsheal, and nslightning it would not take effect until next reload.

v1.5
- Added support for WoTF/PvP Trinket to get you out all charm effects.
- Added auto-execute for warriors.
- Reduced the size of command inputs to make the mod easier to use.

v1.41
- Fixed an error where if auto-join groups was disabled the window would still be hidden from the user.
- Fixed an error where if you were not a rogue you would get errors onload.
- Right-clicks should now execute auto-riposte and NS spells as was originally intended.

v1.4
- Fixed an error where the dialogue box would not disappear for the automatic accepting of summons.
- Improved riposte detection so that it would execute more frequently.
- Improved performance by moving find spell ID functions to the load event.
- Added automatic NS + heals and NS + chainlightnings.
- Changed the way variables are loaded to eliminate errors on load.
- Added cost to the repaired items message.

v1.3
- Fixed a bug where the PvP Trinket would not execute correctly if you were polymorphed.
- Fixed the automatically reset group function. It should now work correctly.

v1.2
- Added Automatic use of WoTF/PvP trinekt.
- Added Automatic use of Riposte.
- Fixed one or two minor bugs.

v1.1
- Fixed a bug that was causing merchant repair to work incorrectly.

v1.0
- AsmoMOD first created, enjoy!