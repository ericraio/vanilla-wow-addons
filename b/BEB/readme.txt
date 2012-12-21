Basic Experience Bar is a highly configurable add-on to cover (or replace if another add-on has hidden it) the default UI experience bar.

Author:
Name; futrtrubl. Email; author@beb.edowner.net Website; beb.edowner.net and forums.edowner.net


[b]Features;[/b]

-Now shows xp rate and time to level and other things, based on the xp this session.
-Profiles. You can now have you settings shared between chars. They can automatically update to any changes made to the profile on other chars or you can just load the settings and change them to your heart's content.
-Fully configurable text including position. The text can be sent to the chat EditBox with a left click on the bar too.
-Textures can be changed for all elements.
-You can change the color and transparency for ALL elements, and can define different colors and or transparencies for different levels of rest (unrested, rested, and fully rested)
-Almost all elements can be hidden or shown.
-By default uses default UI tick marks so when someone asks you how many "bars" you have left 'till you level, you will know.
-Has a rested experience bar and a marker to show how far into the next level (or the next after that) you will go with rested experience.
-Any element can be set to flash when resting.
-A GUI config screen that can be accessed by typing /beb or right clicking on the bar. The GUI config is also load on demand so it will only be loaded if you want to change something.
-Moveable.
-Resizable.

Instructions:
-Chat commands
/beb [defaults, help] which will respectively load the addons default settings or show the list of valid commands. /beb by itself will show the GUI config menu.
-Attaching to frames
Press enter if you type in any changes as nothing gets updated until then. BEB will notify you if the frame is not valid.
-Using custom textures
The default location for custom textures for BEB is the Textures folder within BEB's folder.
If the texture is in there you just need to enter its filename without its extension. If it is elsewhere you will need to enter its path, eg. Interface\\AddOns\\BEB\\Textures\\MyTexture
-Changing the bar's text
If you type in any changes press enter when done as changes will only take effect then. The drop down menu will insert the relevent text variable at the cursors position.
-Using profiles
Create - You must create a profile before you can do anything with profiles. When you create a profile it will be created with your current settings.
Use - If you "Use" a profile any changes you make will be automatically saved to the profile and any changes other chars make to the profile will be automatically loaded for the char.
Load - Loads the settings from a profile. Any changes you then make will NOT be saved back to the profile.
Save to - Saves the current settings to the profile.
Delete - Deletes a profile. Be careful with this, you will be able to delete profiles used by other chars.
- Strata and Level options
Strata and Level decide how windows and objects the game's UI stack. Objects with a higher Strata will be shown over objects with a lower Strata. If the objects have the same Strata the one with a higher Level number will be shown over objects with a lower Level.
egs, 2 Windows, A and B. If A has a Strata of Medium and a level of 2, and B has a strata of High and a level of 2 then B will cover A. If A has a strata of Medium and a level of 3, and B has a strata of Medium and a level of 2, A will cover B. If B's strata is changed to High then it will cover A even though A has a higher level.

Text Variables- If put in the bar's text area they will be replaced by the relevent value which will be updated as they change.
$plv	-	Character's level.
$cxp	-	Current xp for this level.
$mxp	-	Total xp needed for this level.
$rxp	-	Rested xp as reported by the game.
$Rxp	-	Actual current rested xp.
$Cxp	-	Total xp ever earned for this character.
$Mxp	-	Xp to go until you can earn no more.
$txp	-	Xp needed to level.
$Txp	-	Xp needed to reach level 60.
$pdl	-	Percent of the way through the current level.
$Pdl	-	Percent of the way to the end of level 60.
$ptl	-	Percent of the level left to complete.
$res	-	Shows 'Resting' if you are currently resting.
$rst	-	Shows 'Unrested', 'Rested' or 'Fully Rested'.
$ptx	-	Pet's current xp for this level.
$pty	-	Pet's total xp needed for this level.
$ppc	-	Pet's % of the way through the current level.
$ppn	-	Pet's % of the level left to complete.
$pxg	-	Pet's xp needed to level.
$tts	-	Time played this session.
$rss	-	Xp per second (session).
$rsm	-	Xp per minute (session).
$rsh	-	Xp per hour (session).
$tls	-	Time to level up (session).
$xts	-	Xp earned this session.
$prt	-	Percent of the way to being fully rested.
$pre	-	Percent of the way to the end of the level that's rested.
$nkx	-	Kills this session tbat gave XP.
$xpk	-	Average XP per kill this session. (ignores rested bonus)
$kls	-	Number of kills needed to level up (session). (ignores rested bonus)

Version history
0.87
Changed: Text var core, to pave the way for many more text elements.
Added: BEB will now warn you if BEBOptions failed to load if you hadn't set WoW to load out of date addons and BEBOptions has an incorrect version number.
Fixed: Error on German clients at BEBOptions.lua line 79 when opening the config menu.
Changed: Updated BEBOptions.toc to 10900
Changed: Performance tweaks.
0.86
Changed: Updated toc to 10900.
Changed: BEB now no longer handles disabling itself per character. You now do that from the addons screen from the character selection screen.
0.85
Fixed: BEB.lua line 57 error on quest turn in.
0.84
Added: Strata options.
Fixed: Bar not updating properly when the height and width are changed in the General section.
Added: 3 new text variables, $nkx, $xpk and $kls.
Fixed: Errors when using $tts or $tls.
Changed: Flash code, again, in preparation for new flash options.
Added: Titan bars to the drop down menu of frames you can attach to (if Titan is installed and enabled).
0.83
Added: Two new text vars.
Changed: Doubled the length (in letters) of the text string you can use.
0.82
Added: Level options for all elements, so you can adjust what each covers and what covers each element.
0.81
Fixed: Level 60 char issues.
0.8
Added: Two new bar textures.
Added: The player's unit frame in the attach to frame drop down menu.
Changed: Upped the bars max width to 2000 pixels.
Added: New exciting text variables. $tts, $rss, $rsm, $rsh, $tls and $xts all based on your xp gained this session.
0.73
Fixed: Issues using profiles.
0.72
Fixed: Text hiding when you deselect Show on Mouseover if you had logged in with it enabled.
Fixed: Show on mouseover checkbox not getting set to the current setting.
Fixed: BEB error when Show on mouseover is on for the Bar Text.
Fixed: Error in BEBOptions when Show on mouseover is on for the Bar Text. For real this time.
0.71beta
Fixed: Error when closing the color picker window.
Fixed: Color picker window Paste button error.
Fixed: Error in BEBOptions when Show on mouseover is on for the Bar Text.
Added: All elements can now flash when resting.
0.7beta
Fixed: Color button textures now update when the texture for the element is changed.
Fixed: Incorrect positioning if the attach point is CENTER and the attach to point is not CENTER.
Changed: Lots of code cleanup and streamlining. Due to this all settings will be wiped.
Added: Code to prepare for new features.
Changed: Made settings for each character PerCharacter. You should notice no change from this except slighty lower memory usage.
0.68
Fixed: Localization.lua line 171 error.
0.67
Fixed: Some localization stuff.
Fixed: BEB.lua line 227 nil error.
0.66beta
Added: Profiles
Fixed: Line 818 error when the bar is disabled for the character.
Added: ModWatcher friendliness.
Changed: Some text variables event cleanup.
0.65
Added: Text can now be attached to any side/corner of the bar, with any offset you'ld like.
0.64
Changed: More cosmetic changes to accomodate "longer" languages in the config menu.
Added: German localisation, thanks to Ovrak.
Added: Right clicking on the bar will now open and close the config screen.
Added: A new option to allow left clicking on the bar to insert the currently shown text into your chat EditBox.
0.63
Fixed: Size slider funkiness for the two ticks.
Changed: Config frame cosmetic changes.
0.62beta
Changed: Moved Localised text to the relevent addon.
Fixed: Crash when selecting a text variable from the DropDownMenu.
Changed: BEBOptions is now a Load On Demand AddOn.
0.61beta
Fixed: Other issues stemming from the problem fixed be the line bellow.
Fixed: Config frame showing when the UI is loaded and BEB has been disabled from the config frame.
Fixed: Line 636 and others, Bacground typo causing errors.
Fixed: Line 160 error when the UI is loaded and BEB has been disabled from its own config screen.
0.60beta
Added: Copy and Paste buttons on the Color Picker Frame. These were stolen from Lozareth of Discord fame with his implicit permission and then modified a bit.
Fixed: Oops, color settings for the glow around the rested tick, the one that flashes when you are resting, has been in and working since v0.4, but I forgot to put it in the config screen.
Added: Custom textures! If the texture is in the Textures folder in BEB's folder then you just need to put in the name of the file without extension. If it is elsewhere you will need to put in the full path, ie. Interface\\AddOns\\BEB\\Textures\\MyTexture
Added: Color options for the background. It has unrested, rested and fully rested colors now instead of just one.
Changed: The options screen has been broken out to its own addon in preparation for it being load on demand next version.
Added: Size and position options are now specific to each tick instead of being shared.

0.53
Quick fix: $plv and $mxp not updating on level up. This is WoW client issue.
0.52
Added: French localization.
0.51
Changed: Toc to mesh with new WoW patch (1.8)
Added: Small marker artwork for those that get assert errors on startup with 1024 pixel wide textures.
Added: Some pet experience text variables.
Changed: Some bits I had not made localizable.
0.5
Added: Full localizability (um, yeah that's a word). All I need now are translators. If you want to do a translation please contact me through my thread on http://www.discordmods.com/, ui.worldofwar.net or via e-mail at futrtrubl@hotmail.com.
Added: Configurable text!!! BEB will ONLY save and apply changes to the text when you press the Enter key while the edit box has focus.
Changed: More lua/xml cleanup.

0.481
Fixed: Text not showing at all.
0.48
Fixed: "BEBXpText" showing on the bar after relogging or reloading when the text is disabled.
0.47
Added: Attachment options in the config screen.
Changed: Lua and xml cleanup.
0.46
Added: Config Screen controls for positioning.
Fixed: Concatenate error at line 62 when you level and your xp for that lvl is different from the values in my mod.
0.45
Fixed: Issue with elements not changing color when they should.
0.44
Changed: Max bar width. Now you can go up to 1536 pixels wide, up from 1024.
0.43
Added: Percent of the way through the lvl to the text.
Fixed: Error at line 471/471 for lvl 59 chars, thanks to Repent.
0.42
Added: /beb help. Gives a list of valid commands.
Fixed: Indexing a nil error at line 492.
0.41
Fixed: Concatenate error at line 402 if you have the text showing on mouse over, are unrested and mouse over the bar.
0.4
Added: Way more color options for every element on the bar.
Fixed: Version updating. Should work perfectly now.
Added: New slash commands, /beb [defaults, enable, disable] which will respectively load the addons default settings, enable the addon or disable the addon.
Changed: The config screen. It has been completely revamped for better use of space, and better changing of some settings.
Changed: The way the bars render so that gradually show the textures instead of gradually stretching them. This means you can replace the default textures with your own textured textures and they will render attractively.
Changed: /beb. It now toggles the config frame so it will close it if it is already shown.
Fixed: Bar display problem with characters with 0 experience.
Fixed: Potential compare with nil error for people who have hidden the rested xp bar but not the rested xp tick mark.
Fixed: Typo introduced with the last fix, would give an unexpected symbol error at lines 332 and 345 for well rested lvl 60 and 59 chars respectively.
Fixed: LvL 60 errors at line 331 and lvl 59 errors in the 340s.

0.3
Fixed: Concatenate error at line 287 when unrested.
Added: Ability to resize the bar in the GUI config.
Added: Ability to change the bars font size in the GUI config.
Added: Ability to change the size of the tick marks in the GUI config.
Changed: The way the bars work, so that they look great when translucent. (Set with the opacity slider when you change the textures color)
Changed: The textures used so they play nice with resizing. Some textures will of course look... less than perfect, if you make them too big or too small.

0.2
Fixed: Potential infinite loop bug on login.
Added: Ability to change colors in the GUI config.
Changed: TOC to 1700

0.1
Release