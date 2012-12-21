TradeDispenser	Version 0.94
-------------------------------------------------------
Author:			Silas M.	aka 	Kaboom @ Arthas (EU)
Core: 			Tom C.  	aka 	Shag @ Arthas (EU)
Downloaded:		http://ui.worldofwar.net/ui.php?id=2203
-------------------------------------------------------	



COMMANDS:
---------
	Prefix:
		/tradeDispenser			Shows the Help-Text, and is used as prefix for more options
		/td				similar to /tradeDispenser
		
	Options:  (use Prefix + Option, e.g. "/td toggle")
		config				Toggles the ConfigFrame
		toggle				Activates/Deactivates the tradeDispenser
		broadcast			Broadcasts your Trade
		OSD				Toggles the OSD (shortcut-Buttons)
		verbose	X			Shows some or all DebugInfos. (Level X:  0=off,  3=ALL)
		about				Shows more informations to tradeDispenser





Additional Note:
----------------
	You can set some tradeprofiles depending on the customers class. 
	They can be sorted in 3 groups (sorted in order of priority)
		- All Classes
		- Class X   (e.g. Warrior)
		- Group Y 	(e.g. Melee)
	These 3 groups are ADDITIVE. if a warlock's gonna trade you, he'll get the stuff 
	you placed in all 3 groups (e.g. All Classes + Warlock + Caster)
	it would only trade the first 6 items the search-engine could find.
	
	thx goes to FrozenSolidOne @ Killrog(US). he helped me finding some bugs
	
	
	
THX goes to:
------------
- FrozenSolidOne @ Killrog(US)		-	he helped me finding a lot of bugs
- Mickeey @ ¶ þÇøÃÎ¾³Ö®Ê÷ (CN)	   			-	translatet the whole text to chineese
- Balzebeth @ Conseil des Ombres (EU) - translated the whole text to french


	

CHANGELOG:
==========--------------------------------------------
Symbols:
	+ 	Added Function
	-	Removed Code
	>	ToDo  (Reported Bugs, Requested Functions etc)
	o 	Bug Fixed
	* 	Other Changes

	
Version 0.94
------------
	+	Added the new FRENCH localisation. thx to Balzebeth
	
	
Version 0.93
------------
	* 	Updated Chinese-Loc
	o	Patch 1.11.2 causes a bug: its was not possible to spam the raid- or party-channel.
	    since the patch UnitInParty("player") always returns false. i changed the code of that part.
		

Version 0.91-0.92
-----------------
	o	Auto-Accept works again.
	o	Localisation fixed
	+	new slash-command: resetpos - moves all frames to their default-position
	*	made some minor fixes
	
	
Version 0.90
------------
	*	Updated TOC-version to be patch 1.11-ready
	+ 	If a trade's started by clicking on "trade", tD will not put items into the tradeframe. (inactive)
		but: this function does not work on dropping items on a player.
	
	
Version 0.89
------------
	+	3 Color-profiles for the 3 Racks implemented
	

Version 0.88
------------
	+	Fixed a glitch where tooltips could potentially show off-screen.
	
	
Version 0.86-0.87
-----------------
	o	disabling the OSD wont reset the settings any longer
	o	the registration-feature was broken
	o 	Closing the Full Config-Center's going to hide the SideFrames (Settings and TradeControl)
	*	Modified the Background-Texture (set an alpha)
	
	
Version 0.85
------------
	+	Now you could set up to 3 different Racks of Profiles
	*	new Background-Texture
	

Version 0.81
------------
	o	No Errors occurs on completely first installation of V0.80
	
	
Version 0.80
------------
	* 	reduction of the stored datas.
	* 	enhanched the banlist-functions
	+ 	raid/guildmembers can get items 4 free
	o 	min-level for trades can now set down to level 1
	
	
Version 0.76-0.77
-----------------
	o	some Bugs fixed
	
	
Version 0.75
------------
	+	New Feature: Banlist. You can ban players by name. (Ignorelist could be imported too)
	+	Countdown for open (unaccepted) trades
	*	tried to reduce the used memory and loading-time:
	*	events are only activated, if needed (e.g. if tD's running)
	*	some datas are now stored as "global" for all chars. (e.g. whispering messages or banlist)
	*	modified the colors of the OSD-buttons.
	
		
Version 0.65-0.70
-------------------
	+	KeyBindings added
	o	Small GUI-Bugfix in the OSD-frame
	o	fixed some small bugs
	
	
Version 0.60 & 0.61
-------------------
	*	Made a full rewrite of the code, and edited the way tD's saves its variables,
		the initialization of tD and some other handlings...
	o	bug fixed, if somebody trades you and goes out of range
	
	
Version 0.57 & 0.58
-------------------
	o	Minor GUI-bugfix
	*	Fixed some missing chineese-localisations
	
	
Version 0.56
------------
	o	Minor bugfix and small GUI-improvements
	*	DropDowns gets closed if the config-frame's hidden.
	

Version 0.55
------------
	+	UserProfiles: you can set different settings for each char
	+	Added Frame to configure some Whisper-Messages. 
	

Version 0.51
------------
	*	Chinese-Localisation added
	
	
Version 0.50
------------
	+	tD will remove people with a full inventory from the trade-list, so they could trade you again
		Thx to "Swiftstab" for giving the idea to solve this problem
	+ 	the OSD's position could be locked

	
Version 0.46
------------
	o	The Itemlink-Feature was bugged
	
	
Version 0.45		(made by Kaboom)
------------
	+	New Feature: Add ItemLinks into the BroadCast-Messages. Its just like adding items to your chat-channels. 
		(Shift + click on item)

	
Version 0.41		(made by Kaboom)
------------
		Just a small updates, some minor bugs fixed
	o	Error fixed: tradeDispenser_Settings.lua:55: Usage: SetText("text")
	o   Fixed the tradewindow while the Cursor's got an item. (strange effects before)

	
Version 0.40		(made by Kaboom)
------------
	* 	Fixed some Typos
	+	Option for showing some customer-information, if a tradewindow's opened
	o	Fixed Errormessage on Playerdeath, if AutoBroadcast was active.
	
	
Version 0.35		(made by Kaboom)
------------
	*	Modified the ColorPicker of the OSD-Backgroundcolor. its much easier now!
	+	Added Option to rotate the OSD by 90°
	*	Set the max of the Autobroadcast to 30 minutes.  (user request - for MC and BWL)
	o	Already registred player won't be blocked any longer, if the "registrate-customer-option" is deactivated.
	
	
Version 0.30		(made by Kaboom)
------------
	o	DoubleErrors by trading soulbounded items
	+	Money could seperately set for each profile items.
	+	Built-in Lag-Factor - Reduces the Errors on slow connections
	

Version 0.25		(made by Kaboom)
------------
	o	Major Bugfixes. I've got a lot of feedbacks and bugreports and could fix all reported bugs.
		Fixed: Auto-BroadCast, Auto-Accept, Horde-Language (Orcish)
	+	Re-Made the handling of the random broadcast-messages
	+	Auto-Accept could be disabled by an options
	+ 	You will target your customer - and retarget your enemy after trade
	
	
Version 0.20		(made by Kaboom)
------------
		First public release since version 0.0.0.7 @ www.curse-gaming.de
	>	now waiting for feedback and bug-reports.
	+	Verbose-Level-System shows you some debug-information


Version 0.13		(made by Kaboom)
------------
	+	profilspecific tradesystem. Traded items now depens of the customers class


Version 0.12		(made by Kaboom)
------------
	+	TradeControl-Module
	o	Fixed error-messages at first installation of this addon
	*	EditBox for broadcast-text moved to a separate frame.  -> more space

	
Version 0.11		(made by Kaboom)
------------
	+	Localisation: EN<->DE	
		Still waiting for a french loc!

	
Version 0.1		(made by Kaboom)
-----------
	* 	Changed the System of Version-Numbers to a common system  
		(Dummies could easier categorize the state of developement)
	+	OSD with 3 Buttons: Announce, Activate/Deactivate, Config
	+	Profile-specific AutoTrade
	+	Enhance announce-system by some configs
	*	Movable ConfigFrame
	>	Requested Function: Control the TradeTargets... 
		. Guild/Raid only
		. Limit the TradeRequests of each person until list gets reseted
		. Option to auto-trade only with HighLevels (e.g. 55+)
	
	
Version 0.0.0.7		(made by Shag)
---------------
	o	more bugfixes (works if the config. frame is hidden)
	o	fixed money input frame

	
Version 0.0.0.6		(made by Shag)
---------------
		I think, this was the first release...
		Implemented Functions:
			ConfigFrame for TradingStuff
			AutoAnnounce
			AutoTrade on TradeRequest (search the needet items in the inventory and put them in the tradeframe)
			and more
