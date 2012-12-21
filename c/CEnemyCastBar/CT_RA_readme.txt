Natur EnemyCastBar

Description for optional CT_RA support.
---------------------------------------

Since version 3.0.0 CECB detects the CT_RA channel broadcast and parses the broadcasted (+Party, +Raid) channel for CECB commands.

CT_RA/ Bossmods may post commands to the channel by using "CT_RA_SendMessage":
--------------------------------------------------------
--> CT_RA_SendMessage(".countmin 2 Time until Spawn",1);
--------------------------------------------------------
Important: Use the ",1" to force this message! Otherwise sometimes the bars won't be updated.

I strongly suggest that only promoted players or the leader of CT_RA are allowed to print messages
to the CT_RA channel by software to reduce traffic which might cause lag!


The currently supported commands are:
.countsec sss label
.countmin mmm label
.repeat sss label
.stopcount label

-> .countsec triggers a grey bar with a 'sss' seconds timer and the spellname 'label' (which is the first part of the label)
-> .countmin triggers a grey bar with a 'mmm' minutes timer and the spellname 'label' (which is the first part of the label)
-> .repeat triggers a grey bar with a 'sss' seconds timer and the spellname 'label' (which is the first part of the label),
but this one starts from the beginning after the total time has passed
-> .stopcount is able to delete bars which full label inherits a part of 'label'.
So a bar with the label "Firemaw - (30 Seconds)" will be deleted by '.stopcount maw' or '.stopcount 30'.
The command '.stopcount all' deletes all grey bars at once.

New with version (3.5.3):
.cecbspell MobName, SpellName, Type, ClientLang, Latency

-> .cecbspell triggers a bar from the CECB spell database.
Example: ".cecbspell Ragnaros, Sons of Flame, pve, enUS, 100" (currently triggered by the CECB engine ;-) )
This should only be used for spells the CECB engine won't detect itself. Ideal for remotely triggered castbars!


Remember:
---------
* The CECB channel .commands are put through a unique check, so that only one bar with the same SPELL (first part of the label) is shown at once. If one grey bar with the same name is active it will be updated/restartet!
So many users who post an automated message (e.g. '.countsec 35 Until Start') will only trigger ONE CastBar for all channel users!
* If the broadcast was detected by CECB, CECB will send the following message to the CT_RA channel:
"<CECB> CT_RA Channel detected. Natur CECBVersion" (CECBVersion = version the player uses, e.g. "3.3.0, enUS")
* CECB will gsub '$' to 's' and '§' to 'S' because "CT_RA_SendMessage" has transcoded those chars before. So you have not to worry about that^^

But please try to avoid channel spamming! Keep the traffic as low as possible please ;-)



--------------- ==AUTOMATIC BC== ----------------
-------------------------------------------------
Some words to the automatic broadcasting feature:
(New with Natur 3.3.0+)
-------------------------------------------------
# Broadcasting is only allowed if you joined a valid CT_RA Channel (through CT_RA channel broadcast). Broadcasting will be set to disabled after a relogin. (The channel is saved.)
# Only Raidspells and -Debuffs plus Debuffs like "Polymorph" and their fade plus the mobs death (if needed) will be broadcasted.
# I suggest that only a handful people broadcast the spells to keep channel traffic as low as possible: The MT, a healer and the raidleader. So hopefully a big radius of combatlog messages is catched.
# Users with a latency more than 500ms won't broadcast to not delay the timer too much.
# The taunt MTs for Firemaw might want to disable this function periodically to achieve the highest accuracy for this encounter.
# You have to turn these specific spell categories on to broadcast the above spell categories.
# To reduce broadcast traffic the same broadcast won't be directly repeated within a short peroid of time (< 5 seconds)! (Same with received packets.)
# If sender and receiver have a client of different language then broadcasts won't be accepted
Although I tried my best to add a feature like this, expect no wonders and don't fear strange castbar behaviors! Otherwise don't use it ;-)

