rpgo-CharacterProfiler: Character Profiler: WoW Addon
http://www.rpgoutfitter.com/CharacterProfiler/

PREAMBLE:
rpgo-CharacterProfiler is a World of Warcraft addon that grabs character info.

DESCRIPTION:
rpgo-CharacterProfiler is a World of Warcraft addon that grabs character info including 	stats, equipment, inventory (bags & bank), trade skills. This is saved in your savedvariables.lua in the myProfile block (as the old CharacterProfiler was). This information can then be uploaded to a website to display your character info.

USAGE:
unlike the old CharacterProfiler, this one uses our SmartScan... to Scan-as-you-Play. this should run hands-free, updating as needed. 
--'save' button. Character -> Save Button (top left). This will export all info available (not the bank or trades). 
--chat '/' commands with '/cp'

TIPS to get a complete extract quickly:
new character profiles:
--for a full char extract, start by hitting your character view ('C'), then your bank, and each profession, or use the save button.
--after a patch or removal of /wdb folder:
--to get a full character extract, you want to do the above, but twice. hit '/cp show' to see whats been extracted to make sure its all there.
--wow-patches remove the game cache files (*.wdb). these files store info on your items, quests, skills etc. 
after this, it should scan keeping your profile up-to-date. 

'/' COMMANDS:
	'/cp' or '/profiler'
	'/cp [on|off]'
		-- turns on|off
	'/cp export'
		-- force export
	'/cp show'
		-- show current session scan
	'/cp lite [on|off]'
		-- turns on|off lite scanning","this will disable scanning while in raid or instance
	'/cp compat [on|off]'
		-- turns on|off 1.7 compatibility","this will stop saving myProfile in savedvariables.lua
	'/cp purge [all|server|char]'

HISTORY:
full history available at: http://www.rpgoutfitter.com/CharacterProfiler/#history

ADDON LICENSE
http://rpgoutfitter.com/addons/license.cfm
All RPG Outfitter add ons for World of Warcraft are provided free of charge. 

You are free to copy, distribute, display, and perform these addons and to make derivative addons under the following conditions:
--Attribution. You must attribute all add ons in the manner specified by RPG Outfitter.
--Noncommercial. You may not use these add ons for commercial purposes.
--Share Alike. If you alter, transform, or build upon these add ons, you may distribute the resulting add on only under a license identical to this one.
--For any reuse or distribution, you must make clear to others the license terms of these add ons. Any of these conditions can be waived if you get permission from RPG Outfitter.
Your fair use and other rights are in no way affected by the above.

COPYRIGHT
All World or Warcraft game related content and images are the property of Blizzard Entertainment, Inc. and protected by U.S. and international copyright laws. The Addon (code and supporting files) is property of RPG Outfitter and protected by U.S. and international copyright laws. 
