--[[
Flex Bar 
        Author:         Sean Kennedy (Based initially on Telo's sidebar)
        Version:        1.406:  08/25/2005

        Last Modified:
	08/25/2005
		1.  Fixed the Moving Buttons Issue (this includes related mouseenter, mouseleave, 
		    and movetomouse issues) 																		- Sherkhan
		2.  Added a 3rd Text field, [ text3, shadetext3, justifytext3] 										- Sherkhan
		3.  Added a Key Binding to show button information, specifically: ID, Remap ID, and Group ID
		    1st Press - shows the information. 2nd press - Restores previous button information. 
			Limitation: This functionality does not change text justification or color for the text fields 	- Sherkhan
		4.  Merge the changes for: Getting PlayerMiss to work for special attacks by Aranarth. 				- Sherkhan
		5.  Fixed a typo bug in the conditional for 'scaled' 												- Sherkhan 
		6.  Added more internal code to prevent Money line deletion in the tooltips 						- Sherkhan
		7.  Added a little more checking to skip code if a button is hidden 								- Sherkhan
	06/11/2005
		1.	Added the "Raid Safe" option to global options.  This will keep events for health/mana/buffs
			from firing for raid members or their pets.
		2.	Fixed bug with pet check code.
	06/10/2005
		1.	Fixed "mouseovepetr" bug, and a bug with raidpet > 9
		2.	Fixed a checktextsub call in UNIT_MANA and UNIT_HEALTH that was causing
			stutter in raids.
		3.	Fixed error when mousing over a settextured button
		4.	Fixed error when entering game already grouped.
		06/08/2005
			1.	REALLY fixed bug in targettarget code.
		06/07/2005
			1.	Fixed bug in targettarget code.
		06/07/2005
			1.	Reinstated WoW Client 1.5+ functionality
			2.	Updated TOC for WoW version 1.5
		06/01/2005
			1.	Changed text shading to hopefully fix flickering range text.
		05/22/2005
			1.	Completely seperated ACTIONBAR_UPDATE_USABLE, ACTIONBAR_UPDATE_COOLDOWN, 
				UPDATE_INVENTORY_ALERTS into seperate code blocks.  Changed the way UPDATE_COOLDOWN 
				detects whether it should call  UpdateCooldown.  
			2.	Implemented pet buttons.
			3.	Added an Auto-Item check to UPDATE_INVENTORY_ALERTS, MERCHANT_UPDATE, MERCHANT_CLOSED
			4.	Added <unitcode><gain | lose><buff | debuff | debufftype> events.
			5.	Added UnitClass<> conditional
			6.	Added PartyDebufftype conditional
			7. 	Changed itembuffs to raise the last item enchantment in the list as its target.
			8.	Fixed text2 not being saved properly
		05/18/2005
			1.	Move ACTIONBAR_UPDATE_USABLE out of the code block with ACTIONBAR_UPDATE_COOLDOWN
				so the frame stuttering fix for spells being interrupted doesn't break the cooldown spinner.
			2.	Added a delayed call to FB_ReformGroups() as a temporary workaround to MouseLeaveGroup bug
		05/17/2005
			1.	Changed Target events - now fired off PLAYER_TARGET_CHANGED.
				Will now fire lose target then gain target when you switch targets.  TargetReactionChanged is no more
				just use gain target.
			2.	Added TargetGainTarget, TargetLostTarget and TargetChangedTarget events.  NOTE:  There are limitations.
				While there are events for player's changing targets, there are no events for targettarget.  If the target 
				changes between two units of the same type with the same name (IE if you have your tank targetted and he
				switches between 1 riverpaw brute and another riverpaw brute) TargetChangedTarget will not fire, it
				can't detect it.
			3.	Changed GainPet/LosePet to not be polled.  Added the CreatureFamilyType as the target of GainPet (IE
				imp when an imp is summoned).  The drop down list in the Event Editor will be populated with the available
				targets as you summon/tame different types.  This event always fires if the pet events is set to low or high.
			4.	Added PetSummoned and PetDismissed events - these events have targets of the pet unitcode (IE: pet,
				partypet1-partypet4, raidpet1-raidpet40).  Setting the pet performance option to low will cause these to
				only fire for pet unit codes you have in your event list.
		05/10/2005
			1.	Added another check to CreateQuickDispatch to not error on non-standard events
			2.	Reverted some xml to try and fix cooldownspinner/count/hud bug
			3.	Added UnitCreatureType<[<unitcode> "creaturetype" ]> conditional - Thanks Stove.
			5.	Shift+Click on EDT in the event editor will create a new copy of that event at the 
				bottom of the list to edit.
			6.	Right Clicking an entry in the scripts menu will auto-matically load it.
			7.	Fixed target lists in EE for UnitDebuff and UnitDebufftype.
			8.	Added ability to escape single quotes inside a string with the \
				IE:  Runmacro Macro='/echo Dhargo\'s Test' will output Dhargo's Test.
				use this for things like 'Hunter\'s Mark' and the like.
				Known Issues that are unresolved:
				MouseLeaveGroup occasionally not working.  I can't reproduce this one.  Please
				turn on Safe load in global options and see if this helps.
				Text Color flickering when out of range - reproduced once, but not long enough to
				track down.
		05/07/2005
			1.	Fixed bug with /flexbar commands not working in runmacro off events.
				If anything ever breaks in runmacro on events - see the beginning of 
				FB_Execute_MultilineMacro
			2.	Fixed issue with Editing events where multi word targets were being munged.
			3.	Increased text length for textboxes in event editor.
			4.	Fixed CheckAllBuffs - it was raising GainBuff before the stored buffs were
				updated with any lost buffs.  It now raises all gain/lose buff/debuff/debufftypes
				at the end.  This may fix other problems reported with these as well.
			5.	Fixed issue with flexactions and hidegrid.
			6.	Excluded "player" from target list for Unitbuff/debuff/debufftype.
			7.	Added Drop Down Items option to Global Options - specifies how long the dropdown
				menus in the Event Editor should be.
			8.	Modified drop down menus to scroll whole pages.
			9.	Modified UnitDebufftype to raise if the number of a specifice debuff type increased or decreased.
			10.	Fixed GainDebufftype/UnitDebufftype to not raise on in-curables.
			11.	Fixed the conditional parser for not and or.
			12.	Made HasBuff/Debuff/Debufftype and UnitBuff/Debuff/Debufftype conditionals case insensitive.
			13.	Added check to PLAYER_ENTERING_WORLD - don't load profile if it's already loaded.
			14.	
		05/05/2005
			1.	Fixed UnitDebufftype to be raised correctly (it was accidentally working for
				debuffs going on, but not for them going off).
			2.	The conditions UnitBuff/UnitDebuff/UnitDebufftype will now be accurate when
				called from any of UnitBuff/UnitDebuff/UnitDebufftype events.
			3.	Fixed isusable, enoughmana, inrange, cooldownmet conditions - they were expecting
				a button ID not button # and the old way was Button # (as it is in the docs).
		05/05/2005
			1.	Changed CheckAllBuffs to only raise one UnitBuff, UnitDebuff, UnitDebufftype event
				no matter how many buffs changed (to take care of occurences like changing targets
				where it could be raise many times)
			2.	Fixed code with advanced buttons not firing from hotkey clicks
			3.	Fixed in= on events.  Was broken by code to reuse existing tables rather than create new ones.
			4.	Fixed Gain/Lose Debufftype and UnitDebuffType checking. 
			5.	CHANGED UnitDebuffTypes Conditional to UnitDebuffType ( for consistency )
			6.	Fixed UnitDebuffType description/example in docs.
			7.	Changed loadprofile timer to PLAYER_ENTERING_WORLD event to try and avoid
				incorrect group bounds set.
			8.	Changed ResetAll to get rid of any old (pre 1.32) profiles saved under the character name
				only - as they were being reloaded.
				
		05/03/2005
			1.	REALLY got the shade problems this time - tested all modes.
			2.	Added a check into CreateQuickDispatch to test for an event that is not in EventGroups
			3.	Fixed docs typo "flexmacro" not "flexbmacro" :/
			4.	Apparently fixed problem with Event Editor macro/script= fields
		05/02/2005
			1. 	Fixed UnitBuff/Debuff/Debufftype, HasBuff/Debuff/Debufftype conditionals.
			2.	Forced a check of buffs at profile loaded to preload buff table
			3.	Fixed error caused by 'ProfileLoaded' with a target
			4.	Fixed syntax in Condtional descriptions for multiple items.
		05/01/2005
			1. 	Fixed another bug stemming from trying to clean up color code.
			2.	Added ReloadUI back in to Resetall and into Restore.
		05/05/2005
			1.	Fixed initialization code for buttns 97-120 on existing profiles
			2.	Fixed color bug in shadetext/2
			3.	Added %player, %party1-%party4, %pet and %target to texture options
		04/05/2005
			1. 	Changed XML a little so that frame-coordinates are no longer stored in 
				the frame-layout.txt cache in WTF\Account\<account name>\<charactar name>
			2.	Changed Scripts save function to break large text blocks into 512 character
				chunks.  Saved variables seem to max out at ~950-970 characters in a string.
			3.	Added FastLoad as an option.  With the frame-layout.txt file gone, the need for
				delayed loading seems to be obviated.
			4.	*may* have fixed the error that leads to misplaced buttons on successive group
				auto-arrange/move commands in configs.
			5.	Added FB_Register()  to add new event handlers that process after any existing 
				handlers.
			6.	Added event "ComboPoints" - target is current number of combo points
			7.	Added conditions ComboPtsEQ<#>, ComboPtsLT<#> anc ComboPtsGT<#> - respectively 
				check to see if current combo points are equal to, less than or greater than the target.
			8.	Added event "UnitAffectingCombat", target is which unit to watch for.  Affecting combat
				seems to be a mix of GainAggro/Start Melee combat.
			9.  	Added conditional "AffectingCombat<unitcode>" - condition to check if a specific unit is 
				currently affecting combat.
			10.	Added test code for PLAYER_LOST_CONTROL and PLAYER_GAINED_CONTROL.  I
				believe that these  will fire when you are CC'd in some way.  Currently the code saves 
				the messages in FBScripts under the names "PLAYER_LOST_CONTROL" and 
				"PLAYER_GAINED_CONTROL".  If someone could please look at these after being
				feared, charmed or stunned and let me know if what, if any, info was recorded there
				I can implement these events.
			11.	Moved FBScripts editor to FlexBar_GUI.xml and FlexBar_GUI.lua.
			12.	Mostly fixed FBScripts editor's scrolling weirdness.
			13.	Moved seperate toggles (FBFastLoad, FBSafeLoad, FBTooltips, FBVerbose) into a table.
			14.	Implemented a simple GUI for toggles.
			15.	Fixed broken Mana/Health conditionals
			16.	Implemented a simple GUI to toggle on and off groups of events
			17.	Implemented GUI for Event Editing
			18.	Cleaned up Timer_Class code to prevent the steady dumping of memory onto the garbage heap.
			19.	Implemented the behnd the scenes code for AutoItems
			20.	Implemented the behind the scenes code for extending buffs/debuffs to party/target/pet
			21.	More stuff than I could keep track of :)
		04/03/2005
			1.	Fixed bug resulting from buffs cast before profile was loaded/
				or buff wearing off before profile was loaded.  -- one result is that
				these buffs will not be correct for the condition hasbuff<>
			2.  	Restored the Use button to being able to specify multiple buttons
			3.  	Added FB_CastSpellByName() and /fbcast (as slash command) -
				this addresses the issue with /cast and CastSpellByName() not
				working inside runmacro/runscript.
			4.	Added 2 commands for use with runscript/runmacro:
				SetTexture Button=# Texture=''
				Echo Button=<button numbers> base=#  --
				see help file for details
			5: 	Added Import button to scripts editor - allows you to import configs
				from FlexBar_Config.lua and run/edit/save into the FBScripts table.
		04/01/2005	1.   Fixed bug with resetting shade
					2.  Fixed bug with multiple calls to shade on events causing corruption
					     of the color data.
		04/01/2005	1.  Fixed bugs in UnitIsHostile/Friendly/Neutral conditions
					2.  Added /wait to macros.  Duration of wait is in tenths of a second. 
					     There is an added .1 second delay in addition to specified delay.
					3.  Added %fbe (last flexbar event) and %fbs (the source that raised
					     the last flexbar event).  Extra variables are extensible.
		03/29/2005	1.  Added RunMacro command
					2.  Added Restore  command
					3.  Changed WoW event handling to allow extension by 3rd parties within flexbar
					
		03/31/2005 	1.  Small bugfix with quickdispatch and no target specified.
		02/06/2005	1.  Completely reworked the data structure holding button state.  Somehow, in
					    in some cases it was getting munged.  This data structure is now independent
					    of the buttons (it used to be attached to the button itself) and is initialized
					    outside of any event code.
					2.  Reworked all the functions derived from Actionbar to take an explicit button
					    argument rather than rely on implicit 'this'.  In rare instances 'this' was becoming
					    nil.
					3.  Added ShiftKeyDown/Up AltKeyDown/Up and ControlKeyDown/Up events.
					4.  Added a notepad like editor window for script writing - scripts are stored
					     in FBScripts.
					5.  Added UnitDied/UnitRessed events
					6.  Added Runscript command
					7.  Finished Raise command
					8.  Implemented first iteration of conditionals.
		02/04/2005	1.  Changed the Profile Auto-load code to take into account new information regarding
					    checking for a valid character name and the UnregisterEvent() bug.  
						A.  The lost config bug should be gone.
						B.  The problems people experienced with the profile never loading
						     due to a conflict with other mods should be gone.
						C.   In  the event that VARIABLES_LOADED doesn't fire due to the above
						      Blizzard bug, a dialog box will show allowing the user to manually load
						      their profile.
		02/02/2005	1.  Fixed remap toggle ability.
					2.  Added checks to reduce FPS slowdonw when lots of buttons are visible.
						Default blizzard code reshades visible buttons every update, regardless of 
						whether they actually change state.  With lots of buttons on screen this may
						be computationally expensive.  Added a check to see if the button state had
						actually changed before shading.
					3.  Fixed the bug where I was incorrectly applying scale in the case of UIScale < 1.
						This fix will result in the buttons being smaller at the same scaling if you have
						Use UI Scale checked.
					4.  Added an optional reset='true' to scale
					5.  Fixed Horizontal/Vertical group to take UI scale into account.  If you change
					     UIScale, you will need to re-issue the auto-arrange commands to make them
					     look right.
		01/30/2005	1.  Added SaveProfile and LoadProfile to allow backing up and transporting full profiles across characters
					    on the same account.
		01/30/2005	1.  Made 2 changes to try and fix the lost configuration bug:
						A.  Added a 2nd check in Loadprofile for variables being loaded.  If they are not, it restarts the timer
						B.  Added the SafeLoad command, which requires manual loading of profiles
		01/25/2005	1.  Load profile timer now is set in Player Entering World event to ensure that settings
					    aren't lost
					2.  Added the reset parameter to shade to allow WoW's default shading on low mana
					     to work again.
					3.  You can now specify '' or even no text at all in /flexbar text to get rid of the text there.
					4.  You can now turn off button tooltips with /flexbar tooltip state='off' and state='on to 
					     turn them back on.
					5.  Some of the group bounds issues after auto-arranging groups should be solved.
					6.  Added leftbuttondown, up and click events when using a hotkey to activate a button
					7.  Fixed positioning on move to mouse and moverel when UI scale is not 1
		01/11/2005	Fixed 3 errors:
					1, hotkeys were not getting the right button - fixed
					2, the id map was being set incorrectly for druids and warriors
					3, after group auto-arrange group bounds were off.
					4, fixed ingame help for group auto-arrange
					
					Also added code to stop using implicit buttons and use an explicit button
					in  case this was getting munged somehow.  Still desperately seeking 
					cause of Mac crashes - hampered by lack of a mac :/
		01/16/2005	1.  Fixed hotkey problem that especially effected warriors
					2.  Added far more bounds checking to parameters with descriptive error messages
					3.  Added IsUsable, NotUsable, ManaAbove##, ManaBelow##, HealthFull, ManaFull
					     Mana events work for rage.  Probably energy too.
		01/13/2005	1.  FIXED MAC CRASH
					A huge thank you to Dagar for all his help in tracking this down.
		01/12/2005	1. Increased LoadProfile timer.  Was 10 seconds during development,
					dropped to 5 just two days to release -- seems to cause some shifting
					of buttons on load.
					2. Fixed small bug with key-binding text
					3. Fixed bug with setting up event for Use On=
					4. Fixed bug when auto-arranging buttons
					5. Fixed bug where FBEvents.n wasn't initialized - found out due to Cosmos.
					This is not a cosmos bug, but cosmos did something to point out a bug I'd 
					been getting away with.
					6. Made events and targets case insensitive.
					7. Added FlexBar_Config.lua file and LoadConfig command
					8. LoseAura was incorrectly being raised as LostAura.  For consistency, fixed that
					9. 7:00 pm - target is actually case insensitive now
					10. bug with buttons staying fixed to anchor after ungroup fixed.
		12/26/2004	Complete rewrite to facilitate new features and
					maintainablity
--]]
