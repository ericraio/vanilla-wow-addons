
	Name:		MobHealth2
	Version:	2.6
	Author:		Wyv (wyv@wp.pl)
	Description:	Displays health value for mobs.
			Original version by Telo.
	URL:		http://www.curse-gaming.com/mod.php?addid=1087
			http://ui.worldofwar.net/ui.php?id=681
			http://www.wowinterface.com/downloads/fileinfo.php?id=3938

Main function:
display numerical value for currently selected target's hit points.

Features (and how does it differ from MobHealth):
* smaller memory footprint and per sec memory allocation than mobhealth
* works with all language versions
* is almost perfectly accurate - works in groups and when fighting a lot of mobs with same name and lvl
* backwards compatible with mobhealth - all mods that use information from it (for example MobInfo) still work
* uses database that mobhealth already created
* works even with Combat messages disabled
* includes function for easy access to current target's HP from macros and other scripts
* also workes when fighting other players

Instalation:
If you have earlier version of mobhealth installed either delete it, or overwrite it with this one. There is no need to keep both mobhealth1 and mobhealth2. They use same database, so going from mobhealth1 -> mobhealth2 or the other way is safe (you will not lose your old data).
You might want to use /mobhealth2 reset - if your old mob hp data from mobhealth1 is very inaccurate.
After coping to your addons/ folder, there is no other configuration that needs to be done. It JustWorks(tm). After you start to fight any mob you should see it's health displayed on target hp bar.

Note:
At first HP of mob will change a lot, but over time those changes will decrease. After killing around 100 mobs of same type and lvl their max hp will no longer update, even tho it should already almost not change at all after killing 10 or so. You don't have to worry about that - even when fighting your first mob it should be fairly accurate after first attack.

Note2:
Since ui.worldofwar.net doesn't allow uploading more than 1 file per addond - you have to use curse-gaming site to get optional download to make players HP saved between sessions or version with new font.


For normal use you don't need to do anything.
Hitting mob 1 time should be sufficient to display it's HP (in target frame).
When you fight longer it becomes more accurate.

From version 2.5 it also workes for players
(but HP data is not saved between sessions for players
 - it wouldn't make sense)

MobHealth2 commands:
  /mobhealth2 pos [position]
    set position to [position]
    (relative to target frame, default 22, you can also use negative numbers)
  /mobhealth2 stablemax
    updates Max mob HP less often (only in first battle with mob
    and between battles)
  /mobhealth2 unstablemax
    always updates Max mob HP
  /mobhealth2 reset all
    clears whole database!
  /mobhealth2 reset/del/delete/rem/remove/clear
    clear data for current target


NOTE:
Rename file MobHealth_save_players.toc to MobHealth.toc if you wish to save player HP data between sessions.