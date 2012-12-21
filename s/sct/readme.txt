***********************************
Scrolling Combat Text Versions 5.0
***********************************

Website - http://grayhoof.wowinterface.com/

What is it? - A fairly simple but very configurable mod that adds damage, heals, and events (dodge, parry, windfury, etc...) as scrolling text above you character model, much like what already happens above your target. This makes it so you do not have to watch (or use) your regular combat chat window and gives it a "Final Fantasy" feel. 

Why use 5.0 over WoW's new built in Floating Combat Text ? - SCT 5.0 is a complete rewrite of the mod from the ground up. Its is now based in the Ace2 framework and rewitten with more performance in mind. On top of that, it offers features far above and beyond what WoW's FCT can do. FCT is great if you just need a lightweight SCT with limited options, but using SCT's new Lightmode can get you the same performance with almost all of SCT's normal features. 

What can it do? 

- Damage messages
- Heals (incoming and outgoing) and Overhealing (with healer ID's), with filtering for small heals.
- Spell Damage/Resists and Damage Type
- All "Miss" events (dodge, block, immune, etc...)
- Custom Colors for all text events
- Config file to setup custom events (self and target), capture data, and display it.
- Debuff/Buff gain and loss Messages
- Low Health and Mana Warnings with values, and optional sounds
- Rage/Mana/Energy Gains
- Enter and Leave Combat Messages
- Rogue Combo Points, 5 CP Alert Message
- Class Skill alerts (Execute, Overpower, CounterAttack, etc...)
- Honor, Reputation, Skill Gain
- Six Animation Types (Verticle, Rainbow, Horizontal, Angled Down, Angled Up, Sprinkler)
- Four Fonts
- Two seperate Animation frames, each with their own settings. Assign any Event to either.
- Ability to flag any event as critical or as a text messages
- Sliders for text size, opacity, animation speed, movement speed, and on screen placement (with custom editbox)
- Lightmode, for when you care most about performance (at the loss of a few features).
- Now Based in Ace2.
- CTMod, MyAddons, Cosmos, Cosmos2 support
- Settings saved per character by default, but supports all Ace2 Profiles
- Load/Delete settings from another character. Load built in Profiles.
- Localized to work in almost all WoW clients.

How do I use it? - First unzip it into your interface\addons directory. For more info on installing, please read install.txt. Now just run WoW and once logged in, type /sctmenu to get the options screen. 

SCT_EVENT_CONFIG.LUA is used to setup custom message events. Please open up the file (notepad, etc...) and read the opening section to understand how to use it all. PLEASE NOTE - THIS IS THE MOST IMPORTANT FILE IN SCT. IF YOU DON'T READ IT AND USE IT, THEN YOU ARE MISSING OUT ON A TON OF WHAT SCT HAS TO OFFER IN CUSTOMIZATION

/sctdisplay is used to create your own custom messages. 
Useage:
/sctdisplay 'message' red(0-10) green(0-10) blue(0-10)
Example: /sctdisplay 'Heal Me' 10 0 0 - This will display 'Heal Me' in bright red

FAQ
How do I get My Crits or My Hits to show? I would suggest you get SCTD: http://www.wowinterface.com/downloads/fileinfo.php?id=4913

My custom event doesn't work. What's wrong? - Make sure you have the text exactly right, punctuation and capitalization matters. If you need help learning how to capture data, please see the examples or try this site http://lua-users.org/wiki/PatternsTutorial. If its still not working, please read about SCT_Event_Debug and SCT_Event_List in the bottom half of SCT_EVENT_CONFIG.LUA to learn how to add almost any chat event to SCT's search capabilities

How do I change the text for parry, block, etc...? - open up the localiztions.lua file and look for the event you want to change. Then change the text to whatever you like. As of 4.1, you may also now add a custom event for these. As of 5.0 You will get notifications automatically for event specfic skills like Overpower, CounterAttack, etc...

How do I get get text to scroll? I only see numbers! - Make sure the "Show Events as Message" option is unchecked. This is only if you want events to appear as static text (not scrolling/animated)

I don't understand what the 2 frames are for! - Each frame lets you set different features. So you can set frame one using Sprinker animation and Default font, while frame 2 can be using Veritcle animation and Adventure font. You can then assign each event to a specfic frame using the radio buttons next to the events.

There's too many options. Help someone new see how things work! - Try out some of the new built in profiles. While on the options screen, click the "Profiles" button. At the top of the window will be a listing of some default profiles to try out. Maybe you'll fine one you like or it will spark some ideas for you to try.

How do I change the fonts? - You can now select from four fonts on the options page. You can also change the font of message and apply the font to the in game damage font used for your damage (requires relog)

I have Light mode on, and spell crits appear as melee damage! - This is currently a WoW bug. If you really need to know its a spell, don't use light mode =)

Support
Please post all errors and suggestions on http://grayhoof.wowinterface.com/ using the provided forms.
Please post all questions and comments on the offical SCT thread.

Version History
5.0 - Complete rewrite using Ace2 and ParserLib with more performance in mind. Two seperate animation frames. Angled Up, Sprinkler, and Flash Crit animations. New Skill event. Seperate Buff and Debuff fading. Sounds to health/mana warnings. Color spell damage by spell type. Toggle for Custom events (improves performance when off). Light mode, users WoW's new built in events to gain performance, at the cost of a few features. Sample messages when changing options. Editboxes to position sliders. Sounds to custom events. Healer filter option.
4.131 - Very minor bug fixes and updates.
4.13 - Made options frame its own LoadOnDemand mod, options frame is now moveable, added ability to set animation type for custom events, minor buf fixes and tweaks
4.12 - Mainly just bug fixes and code changes needed for SCTD and other future mods.
4.11 - Added your overhealing, all power gains, and FPS mode as options, Added various new damage/power events, Added CTMod support, changed underlying option format for better saving size, added enter/leave world event optimization, Added Spanish support, various minor bug fixes and tweaks.
4.1 - Added Message options for all events, Added Healer ID, Added Your Heals and Skill gain as events, Added new globalization event parser, Added FD check for hunters and low warnings, added most all chat events to a new sct_event_config variable for searching on custom events, added debug code to show chat events, added ismsg for custom events, Added message text options for positioning, fade duration, size, and font, localized option page, added flag to set in game damage to same font as SCT, many other minor tweaks and changes.
4.01 - Fixed rainbow text fade point, Fixed horizontal text Y offset, Improved Execute/Wrath messages, fixed custom events not occuring in index order, fixed resets when massive spam, made resets alpha based
4.0 - Added 3 new animations, 3 new fonts, text positioning, Execute/Wrath events, Reputation events, crit flag for all events, New Profile load/delete, better font sizing, font Outline options, font Direction options, removed troll berzerk message. Special Thanks to Dennie for his Chinese Version of SCT that provided the inspiration for most of these changes.

For full version history, please see here: http://grayhoof.wowinterface.com/portal.php?&id=41&pageid=11