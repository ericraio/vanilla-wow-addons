
	Name:		MobHealth2
	Version:	2.6
	Author:		Wyv (wyv@wp.pl)
	Description:	Displays health value for mobs.
			Original version by Telo.
	URL:		http://www.curse-gaming.com/mod.php?addid=1087
			http://ui.worldofwar.net/ui.php?id=681
			http://www.wowinterface.com/downloads/fileinfo.php?id=3938


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