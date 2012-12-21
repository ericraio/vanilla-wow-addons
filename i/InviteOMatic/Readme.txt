InviteOMatic - for all your invite needs!

by Gof
in 2006

(Tait of Aszune)


This addon is for all you raid/instance/bg group leaders out there. And for you who would just like to make it simple for your friends to group up with you.

Tired of getting 'Invite me!', 'Could you invite <insert name here> plz?', etc. ?

Then this mod is for you!!


Description:

Invite-O-Matic is a multipurpose invite addon for World of Warcraft,
featuring automatic inviting of players who whispers you a magic word.

"Invite me plz", "Could you invite <insert name here> plz", ect..

Invite-O-Matic will automatically invite a player if it thinks his whisper
is a group invite request, or even invite a 3. player if it thinks
that someone is asking you to invite someone else.

Invite-O-Matic also features BattleGround raid inviting and management,
it will automatically try to start a raid group opun entering a battleground.
And will invite every other player in the BG. It will also try to purge
offline players and players who leave the BG.

SlashCommands:
  Usage: /iom option vlaue
    Options:
      autoinvite on|off        -- Turns autoinvite on/off
      autopurge on|off 	       -- Turns autopurge on/off
      whisperinvite on|off     -- Turns whipserinviting on/off
      debug on|off 	       -- Turns debug messages on/off
      spam on|off	       -- Turns the invite spam on/off
      spammsg default|"newmsg" -- Sets the first invite spam message to newmsg
      aigmsg default|"newmsg"  -- Sets the aig spam message to newmsg
      magicword default|"word" -- Sets the magic invite word (REGEXP)
      resetaiglist 	       -- Resets the already in group list
      ignore playername        -- Ignores this player when doing invites
      removeignore playername  -- Removes this player from the ignorelist
      promote		       -- Promotes all raid members
      demote		       -- Demotes all raid members
      aigttl num 	       -- Set number of already in group retries to num");
      ignorettl num            -- Set number of ignore retries to num");
      declinettl num           -- Set number of decline retries to num");

Features:

 -Inviting of players who whisper a magic word.

 -Customization of the magic word (With LUA REGEXP).

 -Creating raids automatically in battlegrounds.

 -Managing raids, purging offline and leaving players in BattleGrounds.

 -Customizable, via the Khaos interface.

 -Customizable via slashcommands

 -Promote All, Demote All feature

Planned Features:

 -Auto negotiating between more players using Invite-O-Matic, so only
  one player has the raid group, and the other players backs off.

 -Auto purging isnt working 100% yet.

 -Better ignorelist

 -Own GUI to replace Khaos dependencie.

Optional Dependencies:
 Khaos - For GUI settings

Changelog:
v1.15a --> v1.16
Made the magic invite word customizable. Both via Khaos, and command line.
Fixed a bug that would make a nil error in khaos, (Line 802 release, and 806 in alpha).

v1.15 --> v1.15a
Fixed a small nil-error that was related to putting people on IOM-ignore.

v1.14a --> v1.15
Updated for 1.10 (Only updated .toc as everything else seemed to work ok)
Fixed ignore list, so you cant be invited by whispering, if you are on ignore list.

v1.14 --> v1.14a
Fixed stack overflow bug

v1.13 --> v1.14
Updatet Khaos OptionSet to use the new Multiline editboxes, so now changing your aig and invite msg via khaos is a bit easier.

v1.12b --> v1.13
Fixed some of the default values to a better value.
Made the number of aig, ignore and decline retries adjustable via slashcommands (For those without khaos)
Fixed a small error regarding setting number of retries to 0

v1.12a --> v1.12b
Unticking the addon in the khaos list should now preperly disable the mod.

v1.12 --> v1.12a
Fixed a couple of nil errors introduced in v1.12 and 1.11

v1.11 --> v1.12
Added Promote/Demote all feature, it is accesable via a slash command:
 /iom promote, /iom demote

v1.10d --> v1.11
Small fixes around the code, to hopefully fix some bugs related to compatibility with other mods.
Also made small changes to ignore, so people on ignore list should properly be ignored from all invite types.

v1.10c --> v1.10d
Fixed a critical bug that would make all mods using the function time() instead of GetTime() to malfunction after joining a BG.

v1.10b --> v1.10c
Corrected small bug that could give a nil error when manually inviting someone that is on decline list.

v1.10a --> v1.10b
Fixed a bug that made autoinvite cycles not work, if you had autoinvite off while joining a bg, and put it on while in there.

v1.10 --> v1.10a
Fixed a newly introduced bug when players decline an invitation.

v1.9 --> v1.10
Removed the dependencie on Chronos.

v1.8 --> v1.9
Quite a big bug corrected, i found out that InviteOMatic didnt save any settings if you didnt have Khaos, well now it does
And as a side effect the ignore list is now also saved between sessions.

v1.7a --> v1.8
Added possibility to change the spam messages that InviteOMatic sends.
Atm the editboxes in khaos are rather narrow, i am looking into this and trying to find a solution.

New commands:

/iom spammsg default|"newmsg"
/iom aigmsg default|"newmsg"

v1.7 --> v1.7a
Added option to toggle inviting via whisper, (Whispering the magic word invite)
 - And a new slash command to toggle this without khaos. ( /iom whisperinvite )

v1.6 --> v1.7
Added a simple Ignore-list (Will be better implementet later)

Usage:
  /iom ignore <playername>
  /iom removeignore <playername>

InviteOMatic will completely ignore players on this list.
Atm the list will NOT be saved between logs, but i am working on this, this is just a temporary solution.

v1.5 --> v1.6
When trying to purge someone it checks that you have inviting rights first, to prevent some errormessages.

v1.4 --> v1.5
Small fixes around whisper inviting, of people in BG's and when someone has reached the AIGList

v1.3b --> v1.4
Corrected an error in slashcommands, that gave a nil error on use

v1.3 --> v1.3b
Fixed a nil error, that sometimes occured

v1.2 --> v1.3
Slash commands now update the Khaos config as they should.
Forgot to update the actual version string.

v1.1c --> 1.2
Added slash commands for some of the options, see /iom help
NB The slash commands does not update the options in khaos (Havent figured that out yet)

v1.1b --> v1.1c

Fixed an error, from the previous fix =)

v1.1 --> v1.1b

Fixed a nil error, when you were not the leader, and still auto inviting

v1.0 --> v1.1

Fixed small error, preventing the correct default settings from appearing in khaos.

v0.1 --> v1.0

Added support for battleground inviting
Added support for customization via Khaos
Now depends on Chronos
Simple battleground purging (More to come)

v0.1

Initial release
Support for whisper inviting