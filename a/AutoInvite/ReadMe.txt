AutoInvite Readme File
Original Version by Ayradyss, modified by Nathanmx
Version 0.5

Introducing AutoInvite, for those who want a quick way to invite friends to their group or raid!

Essentially, whenever someone whispers you and that whisper contains a customizable keyword (it can be mixed in among other things), you'll automatically issue a group or raid invite to them [if you're allowed to].
AutoInvite loads defaulted to on, party invites, using the keyword "invite me".

Usage: /autoinvite or /ai <options>
	/ai alist : invites people from the A priority list
	/ai blist : invite people from the B priority list
	/ai status : Displays the current options setting.
	/ai on|off : Turns AutoInvite's automatic invite issuing on or off.
	/ai party|raid: changes the group checking: "Party" mode is made for five-man groups only, "Raid" mode handles 40-man raid groups.  There's not a lot of difference, else.
	/ai anything else at all: sets the invite keyword to whatever you input.  These are -not- case-sensitive.


Version log: 
	0.1 : Initial public release
	0.2 : Fixed a bug involving AutoInvite not recognizing party mode properly.
		Added auto-convert to raid functionality when you're in raid mode, partied, and invite a 6th person.
	0.3 : Updated to 1500 patch. 
		Now supporting raid officer invites too :)
	0.4 : Updated to 1700 patch. 
		Now using the New And Shiny way of loading properly!
	0.5 : Updated 1.8.1 patch
		Can mass invite people via a preset list (alist and blist)