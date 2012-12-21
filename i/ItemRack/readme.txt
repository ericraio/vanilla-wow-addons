This is a mod to make swapping equipment easier.  You add equipment slots to a bar and mouseover on the bar will create a menu of all items in your bags that can go in that slot.

__ New in 1.975 __
- Fix for drinking event
- Notifications will use default floating combat text if enabled
__ New in 1.974 __
- Changed toc (no need to download if you Load Out of Date and use 1.973. It was tested on PTR)
__ New in 1.973 __
- Fix for Evocation and Spirit Tap events causing errors on buff changes
- Evocation event will "unequip" when evocation ends
__ New in 1.972 __
- Fix for arg1 conflict errors
- Fix for potential bank swap error
__ New in 1.971 __
- Bank support for non-default banks
- Fix for druid/warrior forms in 1.12
__ New in 1.97 __
- Bank support
- New event: ITEMRACK_BUFFS_CHANGED (see readme.txt)
- Default events use ITEMRACK_BUFFS_CHANGED now

__ Banking __

1.97 introduces bank support to ItemRack.  When the bank is open:
- Items and sets containing items in the bank have a blue border in the menu.
- Select a banked item or set from the menu to pull it into your bags, space permitting.
- Select an unbanked item or set from the menu to push it to the bank, space permitting.

Note: If you have two items of the same name in bank, it will bank/unbank them fine from the individual slot menus but it won't correctly reflect both their banked status until both are out/in bank.  And grabbing sets with same names and different enchants will not be reliable yet.  The cure for this is coming.  It partly requires abandoning old sets which didn't store item id's which I'm not going to work around in 1.x since it will be moot soon.

__ ITEMRACK_BUFFS_CHANGED __

There are apparently a lot of people running multiple "buff" events, like innervate, drinking, evocation, spirit tap, etc.  To optimize these events, instead of each event doing a loop of all buffs, all buffs are gathered into a table and an ITEMRACK_BUFFS_CHANGED event is fired with arg1 pointing to a table indexed by buff names and buff textures.  To determine if a buff exists or not, replace loops like this:

trigger: PLAYER_AURAS_CHANGED
local f
for i=1,24 do
f=f or UnitBuff("player",i)=="Interface\\Icons\\INV_Misc_QuestionMark"
end
if f then
EquipSet()
end

With this:

trigger: ITEMRACK_BUFFS_CHANGED
if arg1["Interface\\Icons\\INV_Misc_QuestionMark"] then
EquipSet()
end

You can also use buff names too:

if arg1["Innervate"] then
EquipSet()
end

__ Setup __

Initially the ItemRack is empty.  You choose which armor slots to add to the bar with Alt+Click:

1. Open your character window ('C' is the default key)
2. Alt+Click equipment slots to the bar.  For instance: Alt+Click your helm to add the head slot to ItemRack.  Alt+Click it again to remove it.  You can add as many equipment slot as you want.
3. That's it really.  Mouseover that item and if any other item can go in that slot it will display it in a menu.

__ Customizing Display __

You move the window by dragging the black border of the bar.
You resize/scale the window by dragging the "grip" in the lower right corner of the bar.
You rotate the window by clicking the "rotate" button on the edge of the bar.

Once you have the bar positioned where you like, you can hit the "lock" button on the edge of the bar.  The buttons on the edge will disappear and the window cannot be moved.  However you can still add/remove items when the bar is locked.

To unlock the bar, hold Alt while you mouseover the bar.  The lock and option buttons will return.

__ Useage __

Mouseover an item in the bar and a menu will pop up of all items in your bags that can go in that slot.  Click the item in the menu and it will swap.

If an equipped item can be used, clicking the item on the bar (or its key binding) will use the item.

Default behavior is to only show Soulbound items in the menu.  You can turn this off in options, accessed by a button on the edge of the bar. (Hold Alt down if the bar is locked to get to the options button)

__ Sets __

To start making sets, left-click the ItemRack minimap button:
- Any slots on the rack are automatically marked active and will be highlighted.
- Darkened slots will not save with the set.
- You can toggle whether a slot will be active by clicking the slot.
- You can swap gear to active slots the same as you do from the rack. (mouseover menu)
- ALT+click works in the set builder same as character panel.
- You can save an unlimited number of sets, but only 30 max will show on the menu.
- Sets will not queue during death or combat (yet)
- Sets are saved per-character

To equip a set, there are three ways:
1. Add the Set "slot" to the rack by alt+clicking yourself in the character window. (or alt+click the set icon in the set builder).  Now you can swap sets the same as you swap individual items.  Mouseover the "Set" slot and it will display your saved sets to swap to.
2. Bind a key from the set builder.  Up to 10 sets (per character) can be directly bound to a key.  After you've saved a set, click 'Bind Key' and then choose a key to bind to the set.  You do not need to create any macros or action buttons.  Just hit the key to equip that set.
3. Make a macro.  In some cases you may want to situationally equip a set.  To do so in a macro, use /script EquipSet("setname").  For instance: /script if UnitClass("target")=="Priest" then EquipSet("1h+shield") end.

__ Events __

In the options window when you right-click the minimap button are three tabs.  All event setup is done in the Events tab.

Events are disabled initially.  To begin using events you need to enable it with the "Enable Events" checkbox at the top of the Events tab.  This is the "master switch".  You can set up a key binding to toggle all events on or off as well.

In that tab you'll see a list of events with a red question mark beside it.  Click the question mark to choose what set to equip for the event.  When you've chosen a set it will be enabled.  You won't be able to enable an event until you've associated a set for it. (even if the event script doesn't rely on a defined script)

To disable/enable a set with an associated event, uncheck the event.  Alternately, you can click Delete to remove the set association and have it drop down to the bottom of the list.

Deleting an event not associated with a set will completely remove it if no other characters use that event.

See events manual.txt for more information on creating/editing events.

There are two events this mod uses you won't find in the wiki:
ITEMRACK_NOTIFY : arg1 is the name of the item who's cooldown has finished
ITEMRACK_ITEMUSED : arg1 is the name of the item, arg2 is the slot that was used

__ Queued Items __

We can't swap non-weapon items when we're dead or in combat.  If you attempt to swap in either of these conditions, ItemRack will "queue" the items for immediate swap once you leave combat or return to life.

- The queued item will appear as a small inset into the slot it's going to.
- If you want to unqueue an item, reselect it again.
- If you want to queue the item to another slot (ie, ring from one finger to the other), select it for the other slot.
- The 'queue' is only one-item deep.  Meaning, once a queued item is equipped that queue is emptied.
- Selecting a series of items for a slot will only change the queued item.  It won't set up an order to them.
- You can queue as many armor slots as you want.  For instance if a druid is corpse camping you and you're paranoid enough to have a suit of Nature Resist gear in your bags, you can queue up the whole suit and it will swap in on revive.

In 1.7 you can now queue sets with these important notes:
- Empty slots in a set will not queue.
- If you are wearing an item that wants to go elsewhere in the queued set, that item will not be queued.
- Weapons never need to queue in combat, but will not queue in death either.
- To unqueue a set you've queued, select the set again.
- Queued sets will not show an inset in the set icon.  That set icon gets a lot of business and its sole purpose is to say what the previous equipped set was.  Don't attribute any other meaning to it.

__ Misc __

- You can directly Alt+Click the slot on the ItemRack to remove it.
- You can Alt+Click items or sets on the menu to hide/reveal them. (hold Alt down while you open the menu to see hidden items/sets)
- There are three buttons on the end of the ItemRack.  These are: Rotate, Lock and Options.
- Hold Alt while you moveover a locked bar to get at the lock/options buttons.
- In Options you can toggle things such as numbered cooldowns and whether to display only soulbound items.
- Key bindings are tied to the armor slot, not its placement on the bar.  For instance if you bind CTRL+H to 'Use Helm Item', CTRL+H will use the helm no matter where it exists on the bar.
- An item doesn't need to be on the bar to use its key binding.
- If the control buttons seem to disappear on you when moving the bar, check the other end of the bar.  ItemRack tries at all times to keep everything on the screen, and will rearrange parts of itself to accomplish this.
- In options you can prevent the menu from popping up unless Shift is down.
- If you lose the window or shrink it too much, "/itemrack reset" will restore the bar to default placement/size.
- The settings in the options window are global.  They will affect all characters.  Bar placement/size and contents are per-character.
- 'Notify When Ready' opetion will only notify for items you use or attempt to use in a session.
- Notifications will not be sent if the bar is off the screen.
- If TrinketMenu Mode is enabled and you have the top trinket and bottom trinket together on the bar, it will add spacers around them as needed.  A more flexible spacing method will be added in the future.
- To add a spacer after an item on the bar, while it's unlocked Alt+right click the item (temporary solution)

__ Future Plans __

- Swap gear from/to bank
- Items of same name with different enchants recognized
- Ability to break bar into pieces and independently rotate/scale/dock
- Separate mod into three modules: bar, sets, events

__ Plugin support __

1.8 of ItemRack adds a function TitanPanel, Infobar or any mod can use to work with ItemRack.  I had intended to make a Titan plugin for 1.8, but due to the disenchant issue this version has been rushed to post. (and not to mention there are tons of people who can make Titan plugins better than I can)  The function is: ItemRack_UpdatePlugins

When the bar is updated, ItemRack checks if this function exists, and if so it calls the function with these parameters:

ItemRack_UpdatePlugins(current_set_name,current_set_texture)

At any time you can query sets by calling:

table_of_sets, current_set_name, current_set_texture = ItemRack_GetUserSets()

The table is structured as:

table_of_all_sets = {
["First set name"] = {
[slotid] = "Item name", -- slotid is 0-19, the inventory slot id
[slotid] = "Item name",
[slotid] = "Item name",
["icon"] = "Interface\Icons\Icon_Path", -- the texture used for the set
["hide"] = 1 or nil -- whether the set is hidden on mouseover of the bar
}
["Second set name"] = {
[slotid] = "Item name", -- slotid is 0-19, the inventory slot id
[slotid] = "Item name",
[slotid] = "Item name",
["icon"] = "Interface\Icons\Icon_Path", -- the texture used for the set
["hide"] = 1 or nil -- whether the set is hidden on mouseover of the bar
}
}

Only slot ids that are in a set are in a set's table.  Empty slots are "(empty)".

__ FAQ __

Q: I have problems with the mount event.
A: If you have a recent Titan Panel installed, it includes a Titan Rider plugin that automatically swaps gear.  It will make a mess if both are running at once.  Disable one or the other.

Q: How do I move the minimap button?
A: Drag it like you would an ordinary window.

Q: Can I use this to swap weapons?
A: Yes you can do it several ways.  You can manually swap them directly on the bar or you can create a set for each weapon configuration.

Q: What about just swapping main-hand to right-hand?
A: For a specific swap like that just use: /script PickupInventoryItem(16) PickupInventoryItem(17), but as an example of using this mod in a macro: Create two sets, one named "Before" and another named "After".  Then create this macro:
/script if MainOffSwap then EquipSet("Before") MainOffSwap=false else EquipSet("After") MainOffSwap=true end

Q: Localization?
A: This should work on all clients except range and ammo slots need localized.  See the localization.lua for details.

Q: Can I add my own icon to use for sets?
A: Sure.  Make a 64x64 32-bit TGA and drop it in your Interface\Icons folder.  The icon will appear in the list of available icons.  For in-game icons, see the end of localization.lua.

Q: I locked the window but want to unlock it now to move/resize/rotate it.  How do I unlock with the lock button gone?
A: You can unlock via the lock in the upper right of the options window.  Or hold ALT while you mouseover the bar and the control buttons will return.

Q: I made a set containing just the carrot.  But my other characters don't see this set.
A: With rare exceptions (ie, carrot) various characters on an account rarely have the same gear.  So sets are stored separately per-character.

Q: What is the minimap icon supposed to be?
A: It's a weapon rack next to a crate. :P  But yeah it's awful and needs a new picture.

Q: Are there any slash commands?
A: A few, none of which are necessary to use the mod:
/itemrack : toggle the bar on/off
/itemrack reset : restore the window placement to a default state
/itemrack reset events : restore the events to their default
/itemrack reset everything : display a popup confirmation to reset sets, events, settings to default
/itemrack lock or unlock : toggles the lock to prevent moving/resizing the bar
/itemrack scale (number) : manually set scale to an exact number (0 to 1)
/itemrack opt : toggle the options window
/itemrack equip (set name) : equips a set
/itemrack debug : display a list of currently registered events

Special thanks to Leelaa and Isakur for the German and Tinou for the French localization.

1.974, 8/22/06, toc changed
1.973, 8/2/06, bugs fixed: changed evocation to ITEMRACK_BUFFS_CHANGED, changed Spirit Tab Begin arg1 to ItemRack.Buffs
1.972, 7/29/06, bug fixes: arg1 preserved through BuffsChanged, GetMouseFocus() could be nil in BAG_UPDATE
1.971, 7/28/06, bug fixes: changed BankFrame:IsVisible to a flag when bank open/closed, SPELLS_CHANGED events now PLAYER_AURAS_CHANGED for 1.12
1.97, 7/27/06, added: bank support, ITEMRACK_BUFFS_CHANGED
1.96, 4/20/06, bug fixed: 4606 error, checked if queue empty, changed: unequip will unequip whole set even if partial unequipped, reset events will nil .old itemid's in sets
1.95, 4/6/06, changes: IsSetEquipped "optimizations" removed, temporary events reverted to earlier versions, tooltip fix scaled back to one SetOwner, queuing a worn set clears queue for those slots, added: queued item insets to character sheet
1.94, 3/29/06, bug fix: menu not appearing on bar
1.93, 3/29/06, bug fixes: nil errors from tooltip changes, added: relic slot support
1.92, 3/20/06, bug fixes: attempt to fix arithmetic on string value 4706
1.91, 3/19/06, bug fixes: invalid key for 'next', couple nil errors, changed: mount event to old style, added: option ('Show set icon labels') to show/hide set labels, option ('Auto toggle sets') to auto toggle sets, shift on chosing set toggles set
1.9, 1/24/06, release of 1.891-1.897
1.897 (1.9 beta7) 2/24/06, bug fixed: queue jams (hopefully) gone for good, added: option to show/hide cloak/helm, AQ mount checks, changed: consolidated timers
1.896 (1.9 beta6) 2/21/06, bug fixed: new user and post-combat/death error
1.895 (1.9 beta5) 2/20/06, bug fixed: hide tradables fixed
1.894 (1.9 beta4) 2/19/06, changed: options to scrollable list, form events use IR_FORM global, combat/death queue redone to a single "set" instead of a full queue, alt+click on locked bar won't add/remove slots, one-hand won't show up in offhand for non-DW'ers, items clicked on cooldown won't appear to be used, added: square minimap, large cooldown, reset events
1.893 (1.9 beta3) 2/5/06, bug fixed: TrinketMenu Mode menu fixed if only trinkets on bar, added: Large font option for event script, changed: Event scripts overhauled for new EquipSet
1.892 (1.9 beta2) 1/29/06, bug fixed: non-standard bags recognized, old freespace code removed, 2h swaps on bar immediate move
1.891 (1.9 beta1) 1/28/06, changed: new EquipSet (enchants recognized), ^Requires dropped from "red" check, player-made events won't unregister on zoning, minimap button scaling fixed, /itemrack reset fixed
1.84, 1/20/06, bug fixed: menu update only checks MouseIsOver for plugin if it's installed
1.83, 1/19/06, added: titan support/docking, bug fixed: scroll wheel on lists, changed: checks for TitanRider enabled, events unregister/register on zoning
1.82, 1/16/06, changed: ALT+click/hide behavior made an option for all but sets (default off), bugs fixed: notify with no bar on screen should reliably fire, 2h->1h+offhand swaps will moved orphaned offhand to leftmost bag again
1.81, 1/14/06, bug fixed: Mount event
1.8, 1/12/06, added: IsSetEquipped(setname) returns true if all slots in a set are currently worn, error message when attempting to equip a set that doesn't exist, TitanPanel_ItemRackUpdate, note that events are suspended when set/event window up, bugs fixed: Disenchants/enchants/etc during gear swaps will abort the swap, Bloodvine will show up in menu on enUS clients, ammo count shows again, changed: initialization done in phases, removed cooldown boundry checks, tooltip scans changed to GetItemInfo, new events: Eating-Drinking, Low Mana, Skinning, Mage:Evocation, Priest:Spirit Tap Begin, Priest:Spirit Tap End
1.74, 1/8/06: bugs fixed: bags should work properly on deDE clients, set icon will remember last set when leaving an event, "Mount" event no longer disabled if TitanRider installed
1.73, 1/7/06: bugs fixed: Scrollbars enabled properly (the thumb will appear in 1.9.1 patch), Bindings saved using new SaveBindings, Soul Bags treated like quivers, ammo slot name lifted from tooltip for SaveSet, notify will happen if bar is off screen, changed: In TrinketMenu Mode, hold Shift to keep menu open on the bar, if any event uses ITEMRACK_NOTIFY trigger notify is automatically enabled, removed: check for TitanRider
1.72, 1/3/06: added: reset button added to options, bugs fixed: items used from action bars noticed by mod, users without SCT won't have notify messages "stick", scaling fixes for 1.9, removed scalebugfix (huzzah!)
1.71, 12/21/05: changed: inventory items used elsewhere in the UI reflects in the mod, arg1 and arg2 save on delayed events, added: ITEMRACK_ITEMUSED event (arg1=item name, arg2=item slot), Insignia Ready/Insignia Used events, examples for making scripts that swap on use, bugs fixed: added pink tiger to problem mounts
1.7, 12/8/05, added: events (see events manual.txt), sets queue, sets menu on minimap button, 30 second notify, French localization by Tinou, more slash commands (/itemrack help)
1.61, 11/02/05, bugs fixed: tooltip back to standard GameTooltip (should fix issues with Tipster, TipBuddy and other tooltip mods), set builder now updates properly when nothing on the bar
1.6, 10/31/05, bug fixed: error when items on notify queue are banked, "Container" in DE localized, added: menu pops up on character sheet, audible alert on notify, changed: ItemRack_CurrentSet made global
1.5, 10/5/05, bug fixed: pairs of items of same name with one worn swap, "Container" in German, added: Flip bar growth option, alt+click items in menu to hide them, changed: selecting set equips it
1.42, 10/2/05, bug fixed: two items of same name will swap in sets, key bindings in normal key binding window force to sets
1.41, 9/30/05, bug fixed: nil error on mouseover set icon
1.4, 9/30/05, added: sets, minimap button, /itemrack opt, help text, changed: using sharpening stones/poisons/enchants/etc will work on the bar, only wearable items will show in menu, options moved to a tab on sets window, bugs fixed: ghost countdowns for real
1.32, 9/18/05, bugs fixed: overhead errors fade normally, tabard on bar with cooldown/notify won't error, switching from 2h to 1h+shield queue works properly, swapping to empty won't attempt to put items in quivers, "ghost" cooldowns no longer show on empty slots, removed check for 1.7 in supposed client bug fix for 1.7 that never happened, changed: queues process as sets in stages
1.31, 9/8/05, bug fixed: rotate menu works when bar is horizontal
1.3, 9/7/05, added: German translation by Leelaa, Alt+right click an item will add a space after it, changed: right-click will activate an item same as left click, holding Alt while mouseover items will show full tooltip if Tiny Tooltips enabled, option TrinketMenu Clicks renamed TrinketMenu Mode, while TrinketMenu Mode enabled trinkets show as one menu, bugs fixed: overlapping tooltips, queue won't process upon FD, ammo count shows when adding to rack
1.21, 9/3/05, added: ammo shows quantity, changed: custom tooltip used instead of standard, bug fixed: thrown weapons recognized, multiple ammo stacks show as one in menu, error clicking empty slot with notify on, weapons will queue while dead
1.2, 9/3/05, added: options to hide tooltips or make them smaller, notify when items ready, /itemrack scale as alternative to set scale, changed: spacers to trinkets when TrinketMenu Clicks checked, OnUpdates given ItemRack_InvFrame parent, bugs fixed: mod hides when UI hidden, hunter FD won't block item swaps
1.1, 9/2/05, added: option to swap to empty slots, option to reverse menu growth, left/right-click trinkets options added, changed: "Soulbound Only" renamed to "Hide Tradables", some slots ignore soulbound flag now: trinket, ammo, shirt, tabard. quest and conjured items now show with 'Soulbound Only' on. bug fixed: items queued while dead will swap on res before release
1.0, 8/31/05, initial release
