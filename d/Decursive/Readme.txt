Decursive 1.9.7 (main download: http://ui.worldofwar.net/ui.php?id=2506 )

(this description in mainly the original one written by Quu at http://ui.worldofwar.net/ui.php?id=997 )

This is a cleaning mod. Its job it to help a class that can remove debuffs, do it with ease. Load the mod, bind a key (or create a macro '/decursive') and run, no further configuration or editing needed, it auto configures. Run the mod when ever you wish to cleanse a status ailment, or even think one might be on your target, party, or even raid party, if nothing is cleaned, there is no penalty or cool down.

Currently Decursive is configured to automatically select Druid, Priest, Mage, Paladin, Shaman, Felhunter, and Doomguard cleansing spells. The spell choice is done intelligently, only casting the level or specific version needed, saving mana. Items might be added in the future. If you are a warlock, 'Range' and 'mana' are not checked with your felhunter or doomguard

When you do a cleanse, the following logic is run
* Check target for curable effect, cure if found
* Check priority list (in order) for curable effect, cure if found
* Check self for curable effect, cure if found
* Check party members for curable effect, cure if found
* Check raid members for curable effect, cure if found
* Check pet for curable effect, cure if found (for future felhunters)
* Check party and then raid pets for curable effect, cure if found
(If you are not in a party, or not in a raid, it will skip the party and raid sections)

If after all of this, if nothing is found it will say 'Nothing cleaned' in the system window. If it is unable to target someone it will say so in the system window. When it tries to clean an ailment, it will say so in the system window. If the user is under the effect of an Abolish Poison/Disease it will not further cast remove poison or disease, it will instead skip them and keep searching.

Decursive also have a skip list, people in this list will be ignored.

If the mod tries to cast a curable effect on a party member, but it fails (not in line of sight, etc), it will then put that unit on a blacklist for five seconds. Being on the blacklist means you get cured last. This is to keep Decursive from getting 'stuck' on a player who is out of range/behind a wall, etc. (Decursive will never put the current player to the blacklist)

If the mod comes across an ignorable ailment, it prints what it is and who it is on, but then moves on. As I get more ignorable ailments I will add them to the internal arrays.

This is not a client/server setup... Only the curing classes need to have this mod, nothing is required for a recipient.


COMMANDS YOU CAN USE:
/dcrshow
---> To show main Decursive UI (preferred) NOTE THAT FOR DECURSIVE TO WORK AT ITS FULL POTENTIAL, ITS WINDOW MUST BE PRESENT.
/decursive
---> To clean someone, you can make a macro with this command but it's easier to bind a key such as the key '~'just beneath the [escape] key on a qwerty keyboard.
/dcrreset
---> To reset Decursive windows position to the middle of your screen (useful when you loose the frame)
/dcrpradd
---> Add the current target to the priority list
/dcrprclear
---> clear the priority list
/dcrprshow
---> Display the priority list UI (where you can add,delete,clear)
/dcrskadd
---> Add the current target to the skip list
/dcrskclear
---> Clear the skip list
/dcrskshow
---> Display the skip list UI (where you can add,delete,clear)

NOTE that all these commands can be bond to a key.

OPTIONS YOU CAN SET:
(on Decursive UI click on 'O' to display the option panel)

- "Print messages in default chat" (defaults to off)
Will display messages in your default chat window (can spam a lot)

- "Print messages in the window" (defaults to on)
Will print messages in the main game window, messages stay for 2 seconds on the screen and fade out.
You can choose where those messages are displayed by moving the "Anchor".
To display and move the anchor, push the button 'A' in the top right corner of the option window.
(Note that the messages start to be displayed far under the Anchor)

- "Print error messages" (defaults to on)
Error messages (out of range, out of mana etc...) will be displayed in red.

- "The amount of afflicted to show" (slider, defaults to 5 maximum is 15)
This set the numbers of afflicted persons shown in Decursive live list.

- "Seconds on the blacklist" (slider, defaults to 5 seconds)
When someone is blacklisted, he will stay in the blacklist for this amount of time.

- "Seconds between live scans" (slider, defaults to 0.2)
Decursive needs to scan each member of your raid/party, this option sets how often.
Note that the higher the value is the longer Decursive will take time to detect afflicted people.
If you have a slow frame rate you can try higher values.

- "Check for Abolish before curing" (defaults to on)
Before curing poison or diseases, Decursive will check if there is not an "Abolish" type spell on the unit to cure.

- "Always use the highest spell rank." (defaults to on)
Decursive will always use your higher spell to decurse.
If set to off, Decursive will use your lower spell unless several debuffs are found.

- "Cure in a random order" (defaults to off) (not recommended)
This options will cure in a random order instead of the intelligent one.
Note that I do not recommend this option at all, it's not optimized (it will be fixed in version 2.0)

- "Scan and cure pets" (defaults to on)
Decursive will scan and cure pets of your raid/party.

- "Ignore Stealthed Units" (defaults to off)
Decursive will not cure stealthed units. (may slow down decurse and impact performances if turned on)

- "Play a sound when there is someone to cure"  (defaults to on)
Decursive will make a sound if there is someone to cure.

- "Don't blacklist priority list names"  (defaults to off)
If checked, Decursive will NEVER add players in your priority list to the blacklist. NOTE that if one of them is out of line sight, Decursive will get stuck on him...

