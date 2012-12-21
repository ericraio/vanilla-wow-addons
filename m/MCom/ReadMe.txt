--About--
 MCom provides several functions designed to lower the amount of code required to make an addon be configurable.  It helps to handle the things that need to go on to handle user input, either via console or via some GUI(like Cosmos or Khaos).

 It aims mainly at tasks that are repeated in multiple places in every addon.  Any addon that wants to have chat commands needs a chat handler, and functions for each command it can accept.  It also needs functions for updating the variables that have to do with configuration.  Addons may also need wrapper functions for a GUI interface.  They may also need to have multiple registers to support multiple GUIs, such as Cosmos and Khaos.

 These things are all handled by MCom either by registering with it for such functions, or by calling functions that do the repetative part.

 Have a look at the source code of MCom.lua for detailed comment explainations for usage of all MCom functions.

--Installation Info--
 MCom is designed to be embeded inside addons, users should not need to get MCom, it is only for developers.
 To use MCom in your addon, simply copy the MCom folder into your addon.  Modify your toc file to have an optional dependancy on MCom, and add an include to your toc file for it, like this: MCom\MCom.xml

--Dependencies--
 Optional: Sea, Sky, Cosmos, Khaos, myAddOns

--Author Info--
 By: Mugendai
 Contact: mugekun@gmail.com

--Change Log--
v1.49:
-safeLoad now works more appropriately with the new per addon settings methodology
v1.48:
-Updated for 1.8 patch
-Updated the Sea unhook wrapper to match up with 1.05
v1.47:
-Updated the Sea hook wrapper to match up with 1.04
v1.46:
-Added support for new myAddOns version 2.2, this includes new variables for date, author, email, etc...
 NOTE: For your addon to work properly with myAddOns the uisec, or uiseclabel used to register with MCom for myAddOns must be identical to the name in the TOC file.  You can use reglist.addonname to force this if neccisary.
v1.45:
-Fixed bug where uiname was not being imported for slash command output when no slash command name was given
v1.44:
-Fixed a bug where an error would occur, if Sea didn't exist
v1.43:
-Signifigantly improved the appearance of the TextFrame dialog used for displaying help info
v1.42:
-Fixed case-insensitive setting of choice/pulldowns from slash commands
v1.41:
-Fixed Khaos option set usage even more, was missing several options
-Fixed default and disabled states of checkboxes, and pulldowns
-Added uidep for setting Khaos dependencies
v1.4:
-Updated for 1.7 patch
-Updated the hook handler to match current Sea version in the since that it properly returns for normal functions, as well as handles event hooks
-Added anyupdate which works like update and noupdate, but occurs whether or not the variable was updated, on an attempted update
-Fixed Khaos optionset registration to work as it should.  You can now pass MCom options in the initial registration of a khaos optionset, and those options will be applied to all options in the khaos optionset
-Opacity values will now show as 100% if they are nil
-Fixed MCOM_CHOICET/K_PULLDOWN to work properly now
-Added default Khaos feedback messages for all option types
-Fixed ability to pass uisetup
-Slider min and max are now only set if the option is a slider type
-Added ability to set an unput box's callOn, via uicallon
-addSlashCom and addSlashSubCom now accept min and max values for display purposes for numbers
-textFrame will now default to having a black background if no material is passed, this also applies to the help and slashcommand list display, should be easier to read now
-Slash command help will now display the minimum and maximum values of number options
-number and choice types will now show valid examples if available
-Added a couple more Sea wrapper functions to handle some of the new stuff:
  MCom.math.hexFromInt, MCom.string.colorToString
-Fixed a bug in updateUI that would make it not work when updating a single subcommand
-Fixed importing of difficulty from a Khaos option
v1.37:
-cominmul will now be set based on commul if commul was passed and cominmul was not
-If a Cosmos option type is passed in to a Khaos setup, if no func was passed but uifunc was, a func for slash commands will be generated using the uifunc
v1.36:
-UISection was being improperly handled in the case of imported Cosmos options, this is fixed now.
v1.35:
-The list of safeLoad configs will now be deleted once no longer needed
v1.34:
-Added a new function safeLoad, which will store the current table based config variable as defaults, and will then load in the these defaults to any entries that got set to nil on VARIABLES_LOADED
-German localization has been updated thanks to StarDust
v1.33
-Help button will now inherit difficulty from the option it is registered with.
v1.32
-Updated to 1600
-New function registerVarsLoaded, replacement for registerForLoad.  The new function will call the callback passed whether there is a UI or not, and will pass what method of load occured.
-registerForLoad, and varsLoaded are now depricated
-Improved the appearance of the help screen, by changing the default look to "Stone"
-Added textname to smartRegister, used to specify the name to show in slash command output.  This can be used instead of textbool, textnum, etc...
-commul will now properly effect display of slash output
-commul added to slash command registration
-Added ability to choose the material for textFrame(changes the look of the frame, default is now stone instead of parchment)
-Added ability to choose the scaling of the text in textFrame, defaults to 85% normal size
-frameStatus now properly handles being closed
-Localized On/Off in slash commands
-The slash command help will now show the current state of all sub slash commands, and is also reformated in what is hopefully an easier to read form
-In the case that a command was registered, without registering for Cosmos at the same time, the uivar did not get properly converted to have COS_ in it, in the case that it didn't already have it.  This is now fixed, so long as Cosmos is found, and Khaos is not, COS_ will be added to uivar if it isn't there.
-Added defaults for uimul and commul
-Improved slash command help
-Added textshow to registerSmart, if true, then the text will be printed even if there is a UI
-printStatus now has an extra argument, show, if true, then the text will be printed even if there is a UI
-Added callHook, runs the origional of a hooked function
-Added missing MCom.util.hookHandler, Sea wrapper, and revamped hook wrappers
-Updated to use Legorols new string variable code, and split code, when it isn't evailable in Sea.  Instead of my code that required storing of the functions, for GC efficiency
-Renamed stringToVar to getStringVar for consistancy, stringToVar is still available as an alias, for comptability
-Added support for myAddOns
-stringToVar and setStringVar now have an option to store the function, for improved GC handling
v1.23
-Improved stringToVar and setStringVar
-Added stringVarToGetFunc and stringVarToSetFunc, which are like stringToVar and setStringVar, but instead, they return a function, that you can call to get or set.  The reason for this is that origional functions have to generate GCs.. while the functions the new functions returns, don't.  So you use these functions to get function, and store those functions and use them.  I think I explained this better in the code comments.
v1.22:
-Fixed bugs with registering for load in Khaos
-Added a new function textFrame which displays the passed text in a multipage scrollable dialog
-Slash command help is now shown in a dialog
-Added ability to pass info for setting up a help dialog to smartRegister, see infotext
v1.1:
-Fixed a few bugs here and there, mostly with slash commands, and slash command output.
-Added a set of functions to facilatate in storing/loading variables on a per realm, per character basis, for when no UI is available.  The functions are designed with the notion that it's best to use the UI if it is there, and have convience to avoid messing with any UI behavior.  It for instance makes it very simple to not even load any vars at all if the UI isn't around.  Any mod that uses this, has to do the registering and waiting for correct data, and calling the storage and loading, etc themselves, this is not a full on system, just convience functions.