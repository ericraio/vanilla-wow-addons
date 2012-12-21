
  Recap 3.32

This AddOn will track and summarize the damage dealt and received by every participant in a fight around the user.

__ New in 3.32 __
- Displaced text back in minimized view
- Scrollwheel works on lists
- All combat events unregister when paused

__ Useage __

Once installed, use /recap to summon or dismiss the window. Alternately, you can set up a key binding in options to toggle the window.

There are three states to the mod indicated by the color of the light in the upper left of the window:
Red (Stopped): The mod is currently paused and inert. Fight logging is suspended.
Off (Idle): The mod is currently idle and waiting for a fight to begin.
Green (Active): The mod is actively watching a fight and accumulating totals.

There are two forms of the window toggled by the minimize button:
Minimized: This form is a single bar of DPS numbers. Updated in realtime.
Maximized: This form shows the data in a list. Updated at the end of each fight.

There are three views of the data in maximized form:
Last Fight (Green titlebar): This is the damage detail of every participant in only the last fight.
All Fights (Red titlebar): This is the damage detail of every participant in all fights since you last reset.
Personal Details (Blue titlebar): This is a breakdown of your spells and abilities independent of fights.

The buttons along the top are, right to left:
Minimize: This will minimize/restore the window from list to minimized form. You can choose what elements to display in each form in the options window.
Close: This will hide the window. If the mod is idle or active, fight logging will still continue.
Pin: This will toggle a lock to permit/prevent the window from being moved. If you choose to hide all buttons in minimized view, right-click of the minimized window is the same as pushing the pin button.
Pause/Resume: This will suspend or resume fight logging. If you are currently in a fight it will update the totals of the fight up to that point.
Options: This will bring up the options window.
Last/All: This will toggle between Last Fight and All Fights views.
Personal Details: This will toggle the view to your personal details view and back to all combatants. (for now only usable when not in Light Data Mode)

In Last/All views you can sort each column by clicking its header. Click it once to sort by descending values or click again to reverse directions.

In general, the colors used are:
Green: Outgoing damage.  This is the damage caused by your group/raid to others.
Red: Incoming damage.  This is the damage caused by others to your group/raid.
Blue: Healing.  This is the amount of healing going to others.
Green is also used to note a friendly combatant.  This is generally those in group/raid and their pets, but you can add others manually.

__ Reporting To Chats (/w, /p, /g, /ra, etc) __

The standard method of sending information to chats is by linking, the same as you would a quest or item. Everything that highlights when you mouseover (aside from options) is linkable in this way. Begin a chat and then shift+click the information and it will insert into your /w, /p, /ra, /g or whatever mode you want to send.  

For instance if you're looking at the details of Gello's Fire Blast and want to /p its crit rate to group, you would /p then shift+click Gello's Crit% under Fire Blast.  It will now say:
[Party] [You]: Gello's Crit Rate for Fire Blast: 7.8%

Or you can shift+click Fire Blast itself and it will say:
[Party] [You]: Gello's Fire Blast did 12598 damage (24% of their damage)

Or you can shift+click the Totals header in his details:
[Party] [You]: __ Gello's Effects __
[Party] [You]: Fireball: 52345 (46%)
[Party] [You]: Scorch: 49821 (30%)
[Party] [You]: Fire Blast: 12598 (24%)

Or you can shift+click Gello himself and it will say:
[Party] [You]: Gello took 16703 damage and dealt 51624 damage over 13:22 for 64.4 DPS (max hit 386) for All Fights

You can shift+click the damage out column header ("Out" on main window) and it will say:
[Party] [Gello]: __ Damage Dealt for All Fights __
[Party] [Gello]: 1. Gello: 51624 (64.4%)
[Party] [Gello]: 2. Arcanite Dragonling: 18838 (23.5%)
[Party] [Gello]: 3. Battle Chicken: 117364 (12.1%)

If you uncheck 'Report in multiple rows' in the Report tab in options, reports will attempt to link to a single line:
[Party] [Gello] Gello's Effects: [Fireball 52345 (46%)] [Scorch 49821 (30%)] [Fire Blast 12598 (24%)]
[Party] [Gello] Damage Dealt for All Fights: [1. Gello 51624 (64.4%)] [2. Arcanite Dragonling 18838 (23.5%)] [3.Battle Chicken 117364 (12.1%)]

If the text would exceed a single line, including whatever you've typed into the chat already, it will send what it can fit to chats and then automatically send another line with the rest of the information, repeating as necessary.

At the Report tab in options, you can also choose to automatically post changes in leadership of a stat after each fight.

You can also choose to automatically report the results of the last fight.  Be considerate when using this option as it can really be annoying.  I suggest:
1. /join a new channel, like MyDPSSpam
2. Set recap to send auto-posts to MyDPSSpam
3. Ask those interested to join that channel

__ Details Panel __

This additional window initially acts like a tooltip in that it will reveal extra information when you mouseover a combatant in the list, then dismiss when you leave the window.  Selecting a combatant will lock the details to that combatant. 

You can move it to any part of the screen, or align it to an edge of the recap window and it will dock to move with the main window.

The details panel is broken into three tabs:
Summary (book icon): This is the last/all fight data you would see if you had all columns turned on.
Damage (sword icon): This is a breakdown of outgoing damage/heals by effect for each combatant.  Selecting an effect will fill in further details in the lower part of the panel.
Tanking (shield icon): This is a breakdown of incoming damage and misses.

By default, the list of effects in the Damage pane shows their total damage(or healing) and its contribution.  You can right-click the header and choose which stat to show in its place: Total, Max Hit, Average Hit, Crit Rate, Miss/Overheal Rate.

As mentioned above, every field that's highlightable in the details panel can be linked to chats (including the details header to link a summary of all effects).  Tooltips explain what each value means.

When Light Data Mode is enabled in options, only the summary tab works in details.

__ Fight Definition __

- By default, a fight is defined from the moment damage is first attempted around you to when you leave combat mode. In options you can choose to wait until you enter combat to begin logging, or let logging expire after a period of inactivity.
- Within the fight, the total duration is from the first attempted point of damage to the last attempted point of damage dealt by anyone, friend or foe.
- Within that total duration, each combatant's time fighting is defined from the first attempted point of damage to the last attempted point of damage that individual dealt to anyone, friend or foe.

__ Damage Per Second __

- Damage Per Second uses the durations mentioned above. One timer for a total fight duration, friend or foe. And separate timers for each individual combatant.
- The state of your in-game combat mode has little bearing on fight durations except as a convenient stopping point to update totals.
- Initial casting times and misses/resists of effects that have been known to do damage will trigger the timer to start.  Resists or misses at the end of a fight will extend that individual's time fighting.  Casting times are now included in the duration.
- There is a conspicuous lack of DPS Incoming except as a total. This is because each individual's timer is from the first to last attempted point of damage they dealt to others. Others dealing damage to them will not affect their fight time.
- When a combatant only does damage once in a fight, their fight time is zero, hence their DPS will be zero as well. You can choose to hide these hits in options, but the damage dealt will still be accumulated into totals. (Total damage is a far better metric for group/raid contribution)
- In 3.2 there is a new DPS column: DPS vs All.  This is the damage over the total fight duration, friend or foe.  Note that if you don't reset just before an instance/raid, the DPS vs All will have little meaning for that instance/raid.

__ Melee vs Non-Melee, Misses __

Melee: Everytime you see a stat for Melee, it means pure melee with a weapon.  It does NOT include physical effects such as Heroic Strike, Sinister Strike or Eviscerate.  Yes, Heroic Strike says it will make your next melee hit for X, but when your next melee happens it is Heroic Strike doing the damage, not melee.
Non-Melee: This is all forms of damage that are not pure melee.  This includes Heroic Strike and other physical effects, as well as spells, ranged shots, damage shields, etc.

The combat log makes a distinction between melee vs non-melee, but unfortunately it does not make a distinction between physical and spell non-melee.  Because of this, if we pretend Heroic Strike is a melee effect, then we have to pretend Frost Bolt is a melee effect which it's not.

To hopefully make the data more meaningful: Dodge/Parry/Block only apply to Melee.  Physical non-melee effects do not report the dodge/parry/block at this time.  This may change.

When I add a separate timer for damage incoming, then a lot of this will become moot, as we can then track the number of dodges etc per hour instead of per attempt.  There are rumors of the combat log spam changing in the near future, so these definitions and what's tracked may change.

__ Overhealing __

New in 3.1 is an attempt to estimate overhealing.  This is largely based on a method Faydra posted on the WoW forums that works like this:
1. Once per fight, the current hp/max hp of each group/raid member is stored.
2. As the fight happens, the current hp is adjusted based on damage and healing occuring.
3. When it thinks a heal will fill a group/raidmember's hp to max, it clips the value to what would make it max, uses that for its heal and adds the rest to an overheal counter.
4. When in doubt, ie, if a groupmember ran far away so it's possible damage/healing spam aren't visible and then they run back for a heal (or much more likely the healer plays Chase-The-Fleeing-Minimap-Dots-To-Heal), it will credit the full amount for the heal.
5. For now, full heals are credited in the first fight a combatant appears.

For intance, if a priest were to cast Prayer of Healing on this group:

player: 4000/4000 life (missing 0hp)
party1: 4500/5000 life (missing 500hp)
party2: 3250/3500 life (missing 250hp)
party3: 2000/5000 life (missing 3000hp)
party4: 5000/5000 life (missing 0hp)

and the Prayer of Healing healed each player 600, it would report 1350hp healed. 500 for party1, 250 for party2, and the full amount (600) for party3.  1650hp would be the overhealing amount, or 55%.

__ Resetting Totals __

In the lower left of the window is a red reset button.

- If you are in All Fights view, hitting this button will wipe all current fight data. You can reasonably store hundreds of combatants in the accumulated totals, but it can make for some excessive scrolling and the amount of data that builds up can get rather large.  Periodically you can save these into fight data sets if you really don't want to lose the data.
- If you are in Last Fight view, hitting this button will wipe only the last fight's data and remove them from the accumulated totals. Any new max hit in the last fight will not be reverted in that combatant's accumulated totals.
- If you are in Personal Details view, hitting this button will wipe only your personal details.  Otherwise they will persist even after resetting Last/All Fights.

You can also reset individual combatants and effects by right-click and choosing Reset in the menu that appears.  Individual resets use the same rule as the reset button: In Last Fight view, it will rollback that combatant one fight.  In All Fights view, it will reset that combatant's data entirely.  In Personal View, it will reset that effect.

__ Display Options __

In the Minimized and Maximized views you can turn nearly element on and off by right-clicking a header (or the window itself while minimized) and checking which to display.

In the screenshot above of the minimized view is an example. You can turn on or off any number of elements and the window will resize to only the elements you choose. You can display just your DPS and buttons, just the status light, total DPS in and total DPS out, etc etc.

In list view you can turn on or off the columns to display. The window will resize for only the columns checked in options.

It will continue to accumulate totals for elements you choose to hide. So you can turn columns off without affecting any fight data should you want to go back and look at them later.

In the minimized view there are only three numbers shown:
- Your DPS: Colored white, this is your personal DPS including your pet if it was alive at the end of a fight.
- DPS In: Colored red, this is the total DPS incoming to all friendly combatants. The damage the group/raid received from others.
- DPS Out: Colored green, this is the total DPS out of all friendly combatants. The damage the group/raid dealt to others.

The DPS values reflect the view state you're in: Last Fight or All Fights.

Because the window resizes a lot in different directions, it will always make sure it's on the screen. But it doesn't watch all the other mods on your screen to make sure it's exactly visible. In the event you lose the window from its gyrations, /recap reset will bring it back to center.

__ Friendly Combatants __

This mod makes an assumption that anyone in the group or raid is a friendly combatant. To the best of its ability it will attempt to note them as one. There may be times when it misses a combatant. For instance if a groupmate goes LD in the middle of the first fight, or if they were added to the raid by a raidleader and the mod got notification of the change but before they actually joined, etc. In this event you can right-click the combatants name then choose 'Add Friend' to add them. Generally for group/raid members you only need to do another fight and it will catch them.

It won't catch things such as Barov trinkets, engineered combat pets, etc. There will always be some burden on the user to manage who is flagged a friend and who isn't. Right-click a name to toggle its friend status.

If a groupmate charms a mob and it appears as a friendly combatant, this is not a bug. The mod cannot make distinctions like this. It does not scrutinize charms, possessions, etc. Remember the burden of picking your friends is on you. Right-click a name in the list to toggle its friend status.

__ Fight Data Sets __

New in 2.0 is Fight Data Sets. These are designed to archive fight data that are no longer pertinent but you wish to save.  You can save an unlimited number of sets. A scrollbar will appear when you get over five.

For instance, if you've just finished a raid in UBRS and want to save the data for a future raid, you can go into options, enter UBRS or any name into the edit box and hit Save. At this point you can reset from the main window and start a new slate, or you can continue to accumulate totals. New data will not be saved until you save again.

The information saved is only the "All Fights" totals for each combatant. It's saved in a format that should be easy on SavedVariables.lua.

All data sets are available to all characters. If you're on an alt, you can pull up a data set created by another character.

__ Memory Use __

As a data-gathering mod, this will use more memory than your usual addon.  But it's not a large amount.  My UI memory remains below 15mb and I've got Gatherer and a bunch of other mods loaded.  Whenever possible, this mod attempts to keep memory impact to a minimum: tables are reused instead of recreated, string construction is kept to a minimum, everything that goes on in OnUpdate is mindful of its impact, changes that affect parsing such as the overheals are tested, and mostly the stowing away of character sessions into fight data sets has made an enormous reduction in memory use.  But I'm not naive to think it's perfect or done nearly as well as it can be.  While I work on that (and open to suggestions: email gello.biafra@gmail.com ), some things you can do to trim how much memory Recap uses:

1. Global settings: If you have a ton of alts, not only is the mod storing all 50-60 character options per character, but it's saving a compacted snapshot of each characters' last session.  So that when you log in on your rogue alt you will see their last combatants view.  With global settings enabled, all characters will share the same settings and combatants view and it will discard the rest.

2. Light data mode: The damage details and misses accumulate into separate tables.  Like the normal data, these are stored into fight data sets also.  Turning on Light Data Mode will discard the detailed tables and strip the details from that characters.  Unlike Global Settings, this is a per-character setting.  You can choose to accumulate details on your main and put all your alts on Light Data Mode.

3. Save to fight data sets: Each combatant exists in a table so it can be directly referenced while the game is running.  When this table gets gargantuan (ie, a couple thousand combatants for letting the mod run without intervention for a month), it can take up a lot more space than it needs.  Frequently saving to data sets and resetting will keep the operating memory use low.

4. Remove old data: I have data sets that are pretty old mostly for testing purposes.  If you no longer need a data set, deleting it will free up the little memory it uses.  If you want you can go to Report tab and Write to WOWChatLog.txt to create a copy to archive.

5. Reset: If you're not really attached to the data you've gathered, reset often will keep memory use very low.  It will also make the mod much more usable since the data will be pertinent to the session you just finished. (tho there's very good reasons to let it run for a long time for testing)

__ Future Plans __

- Syncronize data with other users
- "LOD" for data: Self->Friendly->All->Incoming->Outgoing
- Rebuild the list construction method
- "Copy" effects ability, to compare effects
- More optimizations (make functions local, etc)
- Track total blocked and absorbed damage
- Change fonts in 1.7 client (swoon)
- More customization of details panel
- Ability to go back multiple fights
- Allow retroactively unmerging pets from owners
- Fight data sets for individuals
- "Quick save"/"Quick load" fight data sets
- Options to create a format for log reports
- Continually update list view

__ FAQ: Personal Details __

Q: What's the different between the personal details and the detail panel information for me?
A: The detail panel is tied to All Fights currently loaded.  The personal details is independent of all fights, so you can reset often and not lose your own crit rate etc information.

Q: How do I get the personal details?
A: Click the left-most "sword" button along the top of the window.  This will switch to Personal Details view with a blue titlebar.

Q: The personal details button is missing.
A: Either the window is minimized or you are in Light Data Mode.  For now, personal details only accumulate when Light Data Mode is off.

Q: I've stopped using Light Data Mode and I see personal details are still there.  Has it been accumulating all this time?
A: Not while you were in Light Data Mode.  But the information didn't go away.  This is a trivial amount of data so it's safe to carry around.  In the near future, Recap will have several options on what to track and Personal Details will be one option independent of other detail logging.

Q: I charmed a mob and now it's in my personal details.  I don't want to reset my details.  Is it stuck there forever?
A: Nope.  Right-click the effect and then "Reset Effect" will remove it without affecting the rest.

__ FAQ: Pets __

Q: It's missing late raid members and it doesn't pick up pets at all.
A: Unfortunately, the burden is on the user to make sure all friends are accounted for. The mod makes a fair attempt but it can't know the intended purpose of a name just by its name. The next content patch will make this a lot smoother but there will always be some work involved.

Q: Are pets included in DPS?
A: If you have 'Merge pets with owners' checked in options, then yes but only for friendly pets.  Otherwise the only time a pet is included with a player is "Your DPS" in the minimized window.

Q: When I merge pets, then later unmerge them, they're not separate.
A: When you turn on the merge option, pets only exist as a pointer to their owner.  When you turn off the merge option, pets will begin accumulating totals as if they just entered the fight.  This will be changing in a future version.

Q: In my raid we have two pets named Wolf.  The mod is showing them as one pet under one hunter.
A: Unfortunately this mod can't tell which Wolf is fighting from the combat spam.  In raids with pets of the same name, merging pets won't work.

Q: Do miss details include pets when I have pets merging?
A: At this time they do not.

__ FAQ: Healing __

Q: Healing is finally there, but why no HPS?
A: Like Damage In, there is no separate timer for heals. So there cannot be an accurate HPS.

Q: Is the Heal column the amount a player is healed or the amount that player heals others?
A: It's the amount that player heals others. The Damage In column would mirror "Heals In" enough that I felt it wasn't needed.

Q: Is there any way to turn overhealing tracking off?
A: Not at this time.  It does it in a very non-invasive manner and will  give full credit for a heal when in doubt, so it seems safe to keep it on all the time.  If there's any reason to make it an option let me know.

Q: What are situations when overheal can kick in when it shouldn't?
A: When someone takes environmental damage, like from firepots, lava, drowning or the small stealth hp loss when you get a stamina buff.

Q: The mod is reporting 100% healing when it clearly shouldn't have.
A: It will always credit full heals to someone who has just entered a fight.  This part is being rewritten so it will change.

Q: Overhealing in "Last Fight" view is wrong.
A: This mod doesn't track details for each fight.  The overhealing column reflects your 'All Fight' view.

Q: This mod isn't showing me despite the fact that I spent every second of every fight healing.
A: This mod is centered around damage.  For now, you will need to do damage to show up.  This will change to show the unfortunate healers who don't get to nuke.

__ FAQ: WOWChatLog.txt and Clipboard __

Q: I hit Write to WOWChatLog.txt.  It said it was written.  So where is it?
A: When you log out, in your World of Warcraft/Logs directory there should be a WOWChatLog.txt file.  This writes up to 30 combatants at the moment, since this information goes through chats and excessive spamming will disconnect you.  You can write multiple logs before logging out, and each report will append to the log.

Q: The Write to WOWChatLog button is stuck in "Aquiring channel..."
A: It means it requested to join a channel but you're not getting in.  Generally if it gets stuck like this you won't be able to get in that channel until you reload the UI (log out/in or /script ReloadUI).

Q: Can I pick a filename?
A: No.  Mods cannot make their own files.  This uses a chat logging feature of the UI to create a file on the spot.

Q: I wrote to Clipboard and some window with garbled text appeared.
A: This is the text you copy to clipboard.  Mods can't create files so this is an alternative to WOWChatLog.txt.  Press CTRL+C to copy the highlighted text, then go to another window like Notepad and CTRL+V to paste the information there.

Q: Can't you make the mod hit CTRL+C for me?
A: Nope and likely no mod will ever be able to by design.

Q: If I write in HTML format, can I post it on my guild's forum?
A: If your guild's board supports HTML (most do) then you can.  Even the WOWChatLog.txt you can copy/paste.  Tho you may want to cut the first lines up until just before the <table> tag.  The extra text in the beginning can't be <-- commented out --> like the timestamps for the rest of the lines.

Q: I post it on my web page and there's like three pages of whitespace before the table starts.
A: In many forums even nowadays, if you don't put the <table> immediately after text it will add an incredible amount of whitespace.  Instead of:
Last night's Gnomeregan Raid:
<table><tr align="center"><etc...etc...

Use: Last night's Gnomeregan Raid:<table><tr align="center"><etc...etc...

Q: Can I change the HTML format?
A: Yep.  In localization.lua, ctrl+F to "HTMLHeader" and you'll see the four format strings: HTMLHeader, HTMLFormat, HTMLPrefix, HTMLSuffic

__ FAQ: Appearance __

Q: The "Grow Upwards" and "Grow Leftwards" options are gone.  How do I change direction the window grows?
A: In the Display tab, the growth is now determined by which Anchor you choose.  There's a small window with 4 minimize buttons around the corner.  Click the button you want to be the anchor from which the window grows.

Q: Where'd the minimize button go?
A: Check all corners of the window.  Based on the directions you have the window grow, the minimize button will move so that it's always under the pointer when you minimize/maximize the window.  While Auto Minimize is enabled, the minimize button will disappear entirely.

Q: How come some combatants are missing class and faction icons?
A: This mod takes a passive approach to gathering data.  It watches combat spam and mouseover.  If someone is fighting nearby and the fight ended before you got to mouseover them, it can't know what class or faction they were.

Q: Why is the Heal %, Damage In % and Damage Out % blank for non-friendly combatants?
A: The totals are only accumulated for friendly combatants.  I may in the future total up non-friendly data but for now it has no "whole" to be a percentage of.

Q: How do I get it to look like...?
A: In options, the display tab.  You can turn many elements on and off.  Lately I turn all columns off so it's just the name, and then mouseover the names for details.  You can also right-click headers to turn parts off and on.

Q: I turned gauges on in options, but I don't see them or a way to pick which to display.
A: Currently there are only gauges for damage in, damage out and healing.  Sort by one of these methods and you'll see the gauges beneath friendly combatants.

__ FAQ: Misc ___

Q: When I log in, it shows a warning saying I have a lot of combatants.  Is this bad?
A: Not really.  The warning is primarily there to make those unaware of the mod that they may have data accumulating and they don't even know it.  If you're reading this then you are aware of the mod so it's perfectly safe to turn the warning message off in Options->Settings->Data Options.

Q: Does this track absorbed/blocked information that's now showing up in 1.6 client?
A: Not yet.  It will soon(tm).  For now it discards blocked, absorbed and resisted damage.

Q: I have old data that appears to have ticks, but they are average/max of 0.  Is this a bug?
A: It's not a bug.  Since 3.0 when details started being tracked, ticks were always differentiated from crittable hits.  However to lessen the confusion, ticks are now their own separate damage group and will accumulate separate info.  Unfortunately old tick damage data will still be rolled into "Hits".

Q: Are shaman totems included with owner?
A: They are not, sorry.  I'm open to suggestions on how to include them, given that damage information comes from the combat spam.

Q: How do I make the window go away on its own?
A: Under options, three settings you may want to play with are Auto Fade, Hide When Entering Combat and Auto Minimize.

Q: The "Show only unique combatants" option is hiding bosses/other players/etc.
A: All this option does is limit the list to others that have died only once, and friendly combatants irregardless of deaths. It's meant for only watching boss fights in instance runs after you've killed them. If you rarely reset totals before an instance run (or rarely do instance runs), this option will have little/no value.

Q: I see effects like Immolate and Moonfire are accumulating crits, but these are dots. Is this accurate?
A: Yes.  The initial cast of some dots like Immolate have a DD component that can crit.  This mod keeps track of crit candidates as well as total hits to give an accurate crit rate.

Q: What happened to the option to merge fight data sets?
A: This is (still) disabled temporarily.  It will be back in a future version.  A rewrite of the save/loading bits need to be done to handle details merging.

Q: Are there any slash commands?
A: Just a few:
/recap to pull up or dismiss the mod.
/recap reset to restore the window to the center of the screen.
/recap options to pull up or dismiss the options window.

Q: I found a bug!
A: You can post bugs for English versions and feature requests for English versions here or email me at gello.biafra@gmail.com.  Thanks!

Revision history:

3.32, 1/16/06 - bug fixed: displaced text back in window, scrollwheel will scroll windows, changed: when paused, all combat events unregistered
3.31, 7/25/05 - bug fixed: display fixed going last/all while minimized in self view, correct effect always links from personal view now
3.3, 7/21/05 - optimizations: forced save/load at startup only happens on version change/new user, a data set copy of the live data will no longer be kept, ignore flag is now nil or true, added: gauges for all columns, personal details view is back, option to warn on large amounts of data (on by default), changed: grouped buttons into less blps, doubled viewable data sets, recap.DataVersion now follows current mod version, lines linked to chats that exceed 255 characters are broken into multiple chunks, bugs fixed: max hit overview includes max tick, pet tick detail stored on owner when pets merge, error fixed with pets in first fight of session, can no longer link -- entries, linking DmgIn% Out% Heal% now formats properly
3.22,7/14/05 - bug fixed: light data mode warning is back
3.21,7/12/05 - bug fixed: nil error fixed for initial conversions without data sets
3.2, 7/12/05 - added: DPS vs All column, tick damage/avg/max, overhealing column, initial casting times included in DPS durations, report to clipboard, HTML report option. optimized: idle OnUpdates only happen while fighting, initial values are nil instead of 0, data sets' incoming and detail compressed more, changed: hits vs crits vs ticks broken apart further, options drop from savedvariables if no longer used, bugs fixed: gauges always stretch full width. updated .toc
3.12 7/6/05 - bugs fixed: wowchatlog flow changed to fix spam some see, removed attempt to clean .Self for users who had errors in 3.1.
3.11 7/4/05 - bug fixed: option types load from defaults to prevent errors from .DataVersions updating but not changing types. German localization back to globalstrings for time being. Abilitity to localize variations of self pronoun.
3.1  7/2/05 - added: global settings option, #misses in damage details, right-click headers to turn columns on/off, heals clipped to actual amounts when possible, overhealing tracked per heal in details, numbered list column, ability to list/link crits/avg/max/miss in place of total damage in outgoing details, changed: gauges based off actual amounts instead of %, windows made toplevel again, rearranged outgoing details, healing is tracked outside of fights, grow left/upwards options moved to display tab as "anchors", effect to/from ignored combatants completely tossed out, long names will show a tooltip of the name, bugs fixed: (%d absorbed) won't show in effects
3.02,6/24/05 - changed: filters now convert globalstrings, test version
3.0, 6/24/05 - added: misses and damage detail tracked for all combatants, dockable details panel, auto minimize, light data mode, autopost leader, gauges, write to log. changed: minimize moves with anchor, shift+Lclick/Rclick in main window reversed, bug fixed: FD detected for hunters. removed: merge option in data sets temporarily removed.
2.64, 6/9/05 - bug fixed: when pets merge, party/raidmembers are shown correctly. added: in fight data sets, combatants are numbered x(y), y being friendly combatants in that set. toc changed to 1500
2.63, 6/6/05 - changed: German heal localization reverted to 2.6. No other changes.
2.61- 6/1/05 - bugs fixed: fixed total time reloading bug, added a few pixels back to max hit column, right-click menu works now with different scaling, French heal/death/icon localization by Fabinou.  German heal filter reordered by Maischter.
2.6 - 5/22/05 - optimized: data restructured to take up less space with greater flexibility for changes. added: merge pets option (needs 1.5 client), faction, class, % heal/dmgin/dmgout columns, maximum rows option, auto-post of ranks each fight option, option to make backdrop transparent while minimized, titan plugin, changed: right-click to toggle friends now a drop down to toggle friend, reset or ignore bugs fixed: effects with (x absorbed) won't be separate, infobar plugin will update in realtime always, effects that both damage and heal will be separate in details
2.5 - 5/6/05 - bug fixed: report by rows will work for all clients/factions, added: details view to show crits and damage/healing/effect, colored titlebars for current view, changed: infobar updates in realtime
2.43 - 5/4/05 - bug fixed: Self for first time users, added: French healing and death localization by Fabinou
2.42 - 5/4/05 - added: option to shift+click header into rows or one line, preliminary effects tracking for self/pet for localization
2.41 - 5/4/05 - bug fixed: 11th+ entry will shift+click ok now
2.4 - 5/3/05  - added: deaths and heals columns, option to hide yard trash, changed: if window hidden will remain hidden on login, reset button, shift+click of header will be much more readable, minimized dps values update in realtime, German localization update by Mojo, made data set edit box more noticable
2.31- 4/29/05 - bug fixed: german localization string by IceH
2.3 - 4/28/05 - bug fixed: verbose link. added: German localization by Mojo.
2.2 - 4/27/05 - bugs fixed: missing You suffer filter, trailing damage in absorbed hits. added: French localization by Oxman
2.0 - 4/24/05 - optimizations: data and fight flow restructured into separate tables so minimum calculations/allocations needed, changed sort method for drastic speed improvements, calculations performed only when needed. changed: window growth is no longer automatic but in options, pin button only serves to lock window now. removed: compact mode (obsolete), dps is always adjusted per combatant, reset totals for each fight removed.  added: fight data sets, idle timer to end fights, custom list views, more shift+click views, max hits, 
1.42- 4/15/05 - changed: initialization delayed until UnitName("player") is valid.
1.4 - 4/14/05 - added: option to fade window, option to show only friends, option to show only fights with duration, localization.lua, /recap reset, changed: if reset totals unchecked fights begin at first hit by anyone, enabled pause during Active mode, merged pets and owners in personal DPS (white DPS), friends checked more frequently, window will grow upwards if in bottom half of screen, if pinned recap will show at startup, switched logging method from chatframe event hook to registering for every damage event.
1.3 - 4/12/05 - bugs fixed: client crash with gypsy general, infobar not updating on adjust dps change, added: myAddOn entry, fade on post-fight update, changed: made "pin" rules consistent across all views
1.2 - 4/11/05 - added plugin for Telo's Infobar to show DPS
1.1 - 4/10/05 - added option to let totals accumulate, added time column, overhauled list functionality, added shift+click to "link" DPS, added compact minimized view, added the ability to grab names from raid
1.0 - 3/28/05 - initial release


Fight Data Set format for v3.2+:

There are three segments: totals^incoming^[detail1][detail2][detail3][etc]

totals format: friend dmgin dmgout max heal kills time.f ~faction class level
example: true 100 500 50 200 1 180.541 ~0 9 60

incoming format: ^a###a###a###^
example: ^c20e1f2m2^

a:MeleeDamage
b:MeleeMax
c:MeleeHits
d:MeleeCrits
e:MeleeMissed
f:MeleeDodged
g:MeleeParried
h:MeleeBlocked
i:NonMeleeDamage
j:NonMeleeMax
k:NonMeleeHits
l:NonMeleeCrits
m:NonMeleeMissed

details format: [aName>a###a###a###]
example: [1Mind Blast>d888n1x888m2]

First a is type: 1=damage, 2=pet damage, 3=heal, 4=pet heal

d:HitsDmg
n:Hits
x:HitsMax
D:CritsDmg
N:Crits
X:CritsMax
e:CritsEvents
m:Missed
t:TicksDmg
T:TicksMax
