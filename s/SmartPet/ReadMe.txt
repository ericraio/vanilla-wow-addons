SmartPet V2.2 (EN,DE,FR) Written By Gathirer Based on code by Dreyruugr.

A Hunter addon to help your pet out. Continuing the legacy of Dreyruugr's original addon. Now with limited Warlock support.

Features:
* Graphical User Interface to make the user of the addon easier

* <NEW> The Button:  A one key keybinding to give a pet attack, pet recall commands depending on when pressed

* Taunt Management: Enabling this will ensure that your pet always has enough focus to Cower or Growl. Each time you enter combat, your pet will make use of the abilities that were set to Autocast when combat started, while maintaining enough focus to growl or cower every 5 seconds. After combat ends, abilities that were disabled by the focus manager during combat will be re-enabled.

* Smart Focus Management: Enabling this will attempt to maximize your pets DPS output by automatically enabling and disabling burst and sustained damage abilities at the appropriate time.

* Health Warning: Enabling this will send a message to a selected channel if your pets health drops below the specified amount. <Warlock Useable>

* Auto Cower: Enabling this will cause your pet to cower when its health drops below the specified amount.

* <UPDATED> No Chase: Enabling this will attempt to prevent your pet from chasing fleeing targets. Only works if you and your pet are fighting the same target. (No longer Automatic - needs a keypress as of Patch 1.6) <Warlock Useable>

* PVP Taunt Management:  When commanding your pet to attack a PVP enabled player, smart pet will automatically toggle off any taunt, detaunts, and autocower that are enabled. Upon the pet's exiting from combat these modes will reset themselves to pre PVP settings. Note: Will not trigger when attacking PVP enabled NPC's. 

* <Updated> Change pet’s orders (Follow/Stay) and mood (Passive/Defensive) on Scatter shot

* Break off a pet's attack and have it return to you by issuing a pet attack command with no target selected

* By targeting a friendly player and issuing a pet attack command, you and your pet will assist the target

* Have the character say a phrase when sending you pet into battle <Replaces the need for Rauen's Pet Attack due to incompatibilities between it and SmartPet>

* Chose a spell and have it cast when ordering pet to attack

Installation:
Unzip into <WoW Install Dir>\Interface\AddOns

Usage:
Type /smartpet or /sp  to bring up the User Interface

From there you can enable the various features by checking the appropriate box

*SmartPet Enabled:	Turns on/off the SmartPet Addon (if off the majority of the options below will be hidden)
*Show Gui Icon:		Toggles the button for the Gui located next to the pet bar on/off
*Enable ToolTips:	Toggles the tooltips for the check boxes above the pet Bar on/off

*Give Alert on Attack:	Have your character make an announcement on the SAY channel before attacking <Like Rauens PetAttack>
*Use SmartFocus		Has SmartPet mannage the pets focus
*Use Dive/Dash on attack:  Has your pet cast dash/dive when entering into combat
*Enable NoChase:	Has your pet stop attacking if the target flees (See Notes Below)
*Show Recall Warning:	Displays an on screen warning to let you know to recall your pet
*Use AutoCower:		Has your pet switch to cower mode when its health falls below a certain %
*AutoCower%:		Percent of health left before switching to auto cower
*Cast Spell on attack:	Drag a spell from your spell list onto the box and that spell will be cast when you give the pet attack command <Like Rauens PetAttack>
*Use Scatter Call Off:   Issues a PetFollow() command when you use scattershot (See Notes Below)
*Defend/Passive & Stay/Follow:  What pets setting will be set to with Scatter Shot Call Off
*Use AutoWarn:		Makes an announcement letting others know that your pet needs healing
*AutoWarn%:		Percent of health left before making warning
*Say/Party/Guild/Raid/Channel:	What channel AutoWarn will use (These are only visible if Use AutoWarn is enabled)

Changes Due to Patch 1.6
KeyMinder - If you are useing KeyMinder with an automatic key masher running in the background then everything should work as in previous versions and you can disable the Show Recall Warning. **Note I am not advocating the use of an automatic key masher. Use of one could possibly be in violation of Blizzard's TOS and could result in account banning/cancelation.**


NoChase:  Now to have the pet break off attack when its target flees now requires a key press. When the  message appear on screen telling you to recall your pet then press the key that you have “The Button” bound to or press KeyMinder's "Wack that key" binding and your pet will recall.

Scatter Shot Call off:  To use the scatter shot call off bind a key to the "Scatter Shot Call Off” in the key binding menu or make a macro with the line “/script SmartPetScatterShot()” .  Using this macro or the key binding will cast ScatterShot then set your pet’s actions to what you have chosen in the SmartPet Option menu.

Known Issues:
-Not compatible with Rauen's PetAttack
-Occasionally the checkboxes above the PetBar will not appear after switching pets. To fix this enter the options menu and disable then enable SmartPet
-Occasionally you might get a "Spell not ready" error, this is from the casting of dash/dive which trigger the global 1 second delay


SmartPet FAQ
Q- Why is SmartPet NoChase nolonger working
A- In Blizzard's 1.6 patch the changed the code so that pet action commands needed to be trigered by a keypress and could not be triggered automaticly in code as in previous versions

Q- Why is Skill X auto casting when it is not on the pet action bar?
A- This is a bug with WOW introduced with Patch 1.4 and has nothing to do with smartpet.

Q- My pet is not holding agro anymore.
A- Is smartpet enabled, growl on the action bar, and the check box over it checked.  If yes, check the combat log to verify that growl is being cast. If it is being cast then there are 2 possible causes. 
1) Cower is removed from the pet action bar, and is auto casting due to the WOW bug
2) Your pet might need to learn the next rank of growl. As the pet’s level increases growl’s effectiveness starts to diminish until the next rank of growl is learned.

Q- I have the NoChase feature selected and I am fighting mob A and my pet is fighting mob B.  Mob A runs away and my pet stops attacking mob B.  Why is this?
A- This scenario should only happen if mob A & B have the same name.  This is due to WOW does not give any way to differentiate between any group of mobs with the same name. I am working on changeing it so this will no longer happen.

Q- The check boxes are not showing above the pet skills.
A- This happens every so often, but I still have not found the cause.  Disabling then re-enabling smartpet should fix the problem.

Q- Why do you have the pet taunt management use claw for 12 seconds then switch to bite?
A- That is how the original author chose to implement it.  I remember reading somewhere that this gives the optimal sustained pet DPS. I have modified it so that the taunt manager will continusly use claw and toggle bite when involved in PVP to optimise the burst DPS.

Q- I've noticed that the tick boxes above claw and bite do not display unless I also have growl or cower checked. Why is this?
A- What has happened is SmartFocus has been turned off. If SmartFocus is enabled and you have the ticks over growl/cower, bite, claw on; when you attack SmartPet disables Bite and will have your pet use claw for the first 12 seconds of combat then switch to using bite. If it is disabled then your pet will go into combat using both Bite & Claw and SmartPet will not disable claw & bite except to reserve focus to cast growl/cower.



Thanks to the following:
- Dreyruugr for coding the original SmartPet that this is based on
- Ghanid for the code needed for localization & German client translations
- Everyone who has left feedback & support for this project

Future goals for SmartPet 
(NOTE:  This list is not in any order, nor is there a timeframe for implementing them & not
everything might make it into the addon)
- Integrate the defunct PetDefend mod
- Implementing management new pet skills 
- Better focus management with more user customization
- Pet Action Bar upgrades
- Checks to stop attack if target is charmed/stunned/sheeped/ect.
