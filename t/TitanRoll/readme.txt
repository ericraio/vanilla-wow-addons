Titan Panel [Roll]

	author: QuippeR

	many thanks for code from:
			LootHog by Chompers
			ToggleMe by Taii

description:

This Titan Panel plugin catches dice rolls from the chat system. It displays the last roll 
(performers name and roll value) in Titan Panel, and hovering the plugin brings up a list 
of the latest catched rolls.
Dice rolls with the range of 1-100 are displayed in green, others in red with the minimum 
and maximum of the roll after the actual value.
Clicking on the text displayed performs a roll set up by the player.
Shift-clicking will erase the list.
Ctrl-clicking will erase the last roll.
Alt-clicking will announce the current winner. Announcement can be set up individually.

Announcement formatting:
 From the start to "$a" -should contain the text always displayed (prefix)
 "$a" to "$b" - should contain the text displayed when there are no rolls to announce
 "$b" to "$c" - should contain the text displayed when there are rolls
		you can use this symbols in this section
			"$w" - the name of the winner(s)
			"$r" - the winning roll
			"$n" - the number of rolls
			"$l" - a list of the rolls
 "$c" to the end - should contain the text displayed when there where bad rolls
		you can use this symbol in this section
			"$i" - a list of the players with invalid rolls

Example announcement: "Titan Panel[Roll] announcement: $aNo active rolls.$bThe winner is $w
			with a roll of $r. There were $n rolls registered.$c Invalid rolls
			were made by: $i"


----------------
version history:

v0.44b:
-bugfix: clearing the list should now work when no timeout is set

v0.44:
-changed toc version to 11000
-changed text shown on bar when no winner is available
-the plugin is now in the "Info" category
-bugfix: tooltip doesn't brake anymore after displaying 28 rolls. The addon hides some
 rolls instead. These rolls do still count when determining the winner!
-bugfix: the bar shows now multiple names if there were more players rolling the winning
 value.
-time passed since roll is now shown in a much better way
-Shift-LClick will not clean the list anymore, just move every roll to a timed out
 status. This will result in showing false values of time passed since roll though.

v0.43:
-changed .toc to Interface version 10900
-option to show time passed since roll

v0.42:
-changed .toc to Interface version 1800
-option to automatically erase timed out rolls from list
-announcement will now contain multiple names in the $w tag if there were more players
 rolling the same maximal value
-$l tag will now list 1-100 rolls between $b and $c tag (in format: "Player1 - 01,
 Player2 - 02, ...")
-list length can be now up to 40 (though tooltip isn't capable of listing more then ca. 25
 lines, making this function only usable in announcements)
-announcement gets printed in multiple lines if it's more then 255 characters long

v0.41:
-bugfix: plugin catches now dice rolls when "Process group members rolls only" is disabled
-bugfix: updated interface version number (well, lol)

v0.4:
-now contains german localization (thanks to Max Power!)
-added number of active (not timeoutted) rolls to the bar (in parentheses)
-option to only accept rolls from group (means party and raid) members
-option to ignore multirolls (second, third, fourth etc. rolls) of the same character
 (timeoutted rolls don't count as first rolls)
-alt-clicking the bar will now announce the current winner in a really flexible way
 (erasing the last roll will now be achieved by ctrl-clicking, while erasing the whole
 list stays on shift-click)
-option to only accept valid (1-100) rolls as winner (bar and announce too)
-plugin will roll 1-100 if it sees "!roll" in the say, party, raid or guild chat
 (autoroll anyone? :D)

v0.3:
-now compatible with french clients (thanks to Toblerone and Sasmira!)
-added the ability to choose what to roll on click (default is: 1-100; you must specify the
 arguments of a "/rnd" command in the textbox, left blank means 1-100)
-replace bad rolls works better (deletes all bad rolls of the performer and adds the new roll)
-you can set a timeout. older rolls (not valid because the timeout) are colored yellow. they
 are not parsed when determining the winner. they are not sorted when sort list by roll value
 is checked. they are not color coded in any way (bad roll, party member).
-you can now select how long your list should be (5-10-15-20-25 rolls)

v0.2:
-holding down Shift while clicking erases the list
-holding down Alt while clicking erases the last roll from list
-option to show highest roll on the bar (winner name is red if someone rolled bad [not 1-100])
-option to replace bad rolls (not 1-100) with rerolled good rolls
-option to sort list by roll value (older rolls get deleted, not lower ones; just like when 
 this option isn't checked)
-option to highlight party members rolls

v0.1:
-Initial release