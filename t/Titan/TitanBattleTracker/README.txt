MENU
----------------------------------------------------------------------

1. Installation
2. Shortcuts
3. TitanBG Options
4. Known Bugs
5. Technical Support

1. INSTALLATION
----------------------------------------------------------------------

STEP 1
Make sure you have Titan Panel installed correctly. Place the folders
found in the TitanBG zip file as indicated by the directory structure.
Once installed, it should look something like this.

World of Warcraft\Interface\Addons\TitanBG\TitanBG.toc
World of Warcraft\Interface\Addons\Titan\TitanBG\ ...

As you can see, there are two folders. One, containing ONLY
TitanBG.toc should be placed directly into the Addons folder. The
other should be placed within the Titan Panel folder.

STEP 2
Once you have installed the folders correctly, you will have to
restart World of Warcraft for it to recognise the changes.

STEP 3
TitanBG is now installed. To activate it on your Titan Panel, right
click the Titan Panel, scroll down to the Plugins > General option and
select TitanBG from the options menu. You will now see TitanBG active
on the Titan Panel.

2. SHORTCUTS
----------------------------------------------------------------------

Only works when the player is eligible to enter a battleground.

PAUSE/RESUME AUTO JOIN TIMER
 * LEFT CLICK on the addon in the Titan Panel.
Only works if the auto join functionality is enabled.

Only work when the player is located inside a battleground.

SHOW BATTLEGROUND SCORE PANEL
 * LEFT CLICK on the addon in the Titan Panel.
Only works if the minimap icon is not being shown.

SHOW BATTLEGROUND MINIMAP
 * HOLD SHIFT and LEFT CLICK on the addon in the Titan Panel.
Only works if the minimap icon is not being shown.

INVITE BATTLEGROUND MEMBERS
 * HOLD CTRL and LEFT CLICK on the addon in the Titan Panel.
Only works if the auto invite functionality is enabled.

3. TITANBG OPTIONS
----------------------------------------------------------------------

BATTLEGROUND OPTIONS > BATTLEGROUND OPTIONS

* Auto Join Battleground
This will automatically join you to the first battleground available.
If you are already in a battleground, this will not occur. The auto
join timer is set to ten seconds, however you may pause and resume the
timer at any point by left clicking on the addon in the Titan Panel.

* Auto Release
When you die in a battleground, this will automatically release your
ghost.

BATTLEGROUND OPTIONS > RAID OPTIONS

* Automatically Accept Invites
If you are invited to a group in a battleground, this will
automatically accept the invitation. However, if you have begun to
invite people on your own as this occurs, the invite will not be
automatic and you will still be asked for confirmation.

* Automatically Invite and Remove Players
Only works within the battleground and will allow you to invite all
the players in the battleground into a raid. It will automatically
form a raid from a party and once formed, will invite any players as
they enter the battlefield.

Therefore, to begin forming a raid, CTRL + LEFT CLICK on the addon
within the Titan Panel. This will first attempt to form a party of at
least two people. Once at least one person has accepted your
invitation, a raid will be created and the rest of the people in the
battleground will be invited.

If the addon fails to invite at least one of the people in the
battleground into a party, the auto invite sequence will be stopped.

* Automatically Promote All Members
Only works within the battleground. If you are a raid leader, it will
promote all other members to A.

* Automatically Set Loot to FFA
Only works within the battleground. If you are part of a raid and the
leader, this will automatically set loot to FFA.

* Automatically Disband/Leave Raid on Completion.
If you are a raid leader or officer, this will remove all members from
the group, except those that you joined the battleground with, once a
battleground is completed. If you were already in a group with
specific members, this will not remove them.

If you are not a leader or officer, or you left the battleground
before it was complete, this will then remove you alone from any raid
or group you are a party of.

While in a battleground, will remove any members found in the raid if
they leave the battleground. Works only if you are the raid leader or
officer.

DISPLAY OPTIONS

* Hide Minimap Battleground Icon
Will remove the battleground icon found on your minimap if you are in
a queue or in a battleground. If the icon is hidden and you are in a
battleground, LEFT CLICKing on the addon in the Titan Panel will show
the score screen. Holding SHIFT and LEFT CLICKing on the addon will
show the battleground minimap.

While the minimap icon is hidden, you will not be able to use it to
leave a queue. You may do so by viewing the TitanBG options and
selecting Queue Options.

* Hide Battleground Ready Popup
Will automatically hide the popup asking you if you want to join a
battleground or hide. The battleground ready sound will still play. If
you enable this option, you can still use TitanBG to join the
battleground by selecting Queue Options.

DISPLAY OPTIONS > BUTTON OPTIONS

Applies to the text located directly ON the Titan Panel and shows
information about the player if they are in a battleground. If not,
shows information about the battleground queues the player is
currently in.

DISPLAY OPTIONS > TOOLTIP OPTIONS

Applies to the text shown in the addon tooltip when the player is in a
battleground. Outside of a battleground, shows information about he
battleground queues the player is currently in.

QUEUE OPTIONS

When in at least one queue, will allow the player to join a
battleground if they are able, or leave the queue.

4. KNOWN BUGS
----------------------------------------------------------------------

* INVITED PERSON ALREADY IN A GROUP ERROR
Occasionally, you may receive an already in a group error from a
person you have invited and they insist they are not in a group. Get
them to type /script LeaveParty(); into their chat window. If this
doesn't work, they may have to relog and try again.

This is a Blizzard error.

* YOU ARE ALREADY IN A GROUP ERROR
Occurs occasionally when too many conflicting commands are returned.
For example, somebody accepts your group invite and you are forming a
group, at the same time you join another group. While safeguards have
been added to prevent this, if it does occur, relog and if necessary
type /script LeaveParty(); into your chat window to reset.

This is a Blizzard error, but caused occasionally by the addon when
Automatically Accept Invites or Automatically Invite Players is
enabled. Safeguards have been added.

* GROUP ALREADY FULL ERROR
If your group is not full and you are getting this message then an
error has occured on the server. I'm not really sure why this happens
or how to fix it, but it appears to be associated with quick mass
inviting of any kind. This is a problem with multiple addons, but is
caused by server side lag.

This is a Blizzard error.

* THE TOOLTIPS CUTS OFF INFORMATION
The Blizzard tooltips have a line limit and if the addon exceeds that
limit, lines will begin to be cut off. Try turning off some display
options.

5. TECHNICAL SUPPORT
----------------------------------------------------------------------

If the addon throws any errors or is not working as intended, please
post within the comments of the addon on the website where you
downloaded it. For example,
http://www.curse-gaming.com/en/wow/addons.html or
http://ui.WorldOfWar.net