BuffAhoy by Theck
version 1.45

    http://www.frontiernet.net/~gehring/BuffAhoy.htm

BuffAhoy is a casting suite for paladins and other spellcasters.  As of version 0.9, it now has a graphical
interface, which can be brought up via a slash command or bound to a hotkey through the Key Bindings interface.
This readme will be split into two parts, the first describing how to use the GUI, and the second describing
the functions this AddOn adds that can be used in macros.


    This AddOn makes extensive use of two features that are not native to WoW:

	Passive Party Targetting(TM)(ok not really TM)(i actually stole this from one of the stickied
	forum threads):
	  The passive party targetting, or PPT system, uses a variable to make it possible to cast
	  many spells on a party member while in combat, without switching away from your current 
	  target.  It's used in many of these functions, and requires that you bind keys to the four
	  PartyTarget#() functions (bindable through the Key Bindings interface).  I've found this
	  immensely useful -- it required a little shift of my usual play habits, but after you get
	  used to it it's much faster and easier than trying to click around and change targets all
	  the time.  It is (for the most part) optional, though i haven't gone to the trouble to code
	  each function so that it is actually disabled (if you don't want this, why are you downloading
	  the AddOn anyway?).  If people request this ability in the future, i might put some time into it,
	  but for now that's how it is.  Read the spell descriptions and you'll understand how PPT works.

------NOTE:  	As of version 1.4, it IS possible to get PPT and Telo's SelfCast to work together.  It only requires a simple addition
		to the SelfCast.lua file.  Just open the file, scroll down to the end, hit return a few times and add the following text:

			function BA_UseAction(id, type, self)
				lOriginal_UseAction(id, type, self);
			end

		This way, you can use BuffAhoy with PPT enabled and still use SelfCast.


	  Also i'd like to mention one "bug" with the PPT system:  So far i have not been able to get it to
	  recognize when the target is out of range, so often it will attempt to cast the spell and find out
	  the target is out of range, and thus fail, but still report to the party that the spell has been cast.
	  I'm pretty sure there's no way around this, because of the way the PPT system works and the limitations
	  of the API functions blizzard makes available to us.

	SmartCasting(TM)(again, not really)(very similar to Telo's SelfCast, but kinda different)
	  SmartCasting is similar to the SelfCast AddOn by Telo, but it's got 2 major differences:
		1) SelfCast uses Alt to cast on yourself
		2) SelfCast affects all spells  -- In this addon, only certain functions use the 
		   SmartCast system, others don't.  The readme should mention which ones do and don't.

	  My play style centers around Shift as my self-cast button, so that's what i've used in this
	  Addon.  You can choose Shift or Alt to be your self-cast button in the Options section of the GUI.  
	  The default is Alt.

     slash commands:
     	"/ba toggle"  will toggle all verbosity settings (this isn't really that useful, but it's there if you want it)
     	"/ba config"  will bring up both BuffAhoy configuration panels ('/ba buffs' and '/ba caster' still work, for legacy users)
     	"/ba help"    will display a very brief list of slash commands


I.  Quick-start guide to BuffAhoy.
  This will give you step by step instructions on how to get BuffAhoy set up for the first time.  

   1.  	Open the BuffAhoy zip file, and extract the contents to "C:\Program Files\World of Warcraft\Interface\Addons\".
	This should create a BuffAhoy folder underneath the AddOns folder.  Inside the BuffAhoy folder there should be 
	7 files.  If it looks like you've done this correctly, move on to step 2.
   2.	Start the game.  When you log into the server, you should see a message in the Chat log that says "Theck's BuffAhoy
	Loaded".  If you don't see this, go back to step 1.  If you do, or you're not sure, type "/ba config" at the chat
	line.  This should bring up the BuffAhoy configuration panel, if it doesn't, then go back to step 1.
   3.	Open your spellbook, and drag spells into the buffing configuration slots for each class.  You can also drag spells
	into any of the other functions in the interface.  If you're using a SelfCast addon, then you may want to disable
	PPT in the interface by unchecking "PPT enabled", or disable your SelfCast addon.
   4.	Now open the Key Bindings menu (Escape->Key Bindings) and scroll down to the "BuffAhoy Binds" section.  Bind keys to
	the following functions:
		Buff Sequence 1
		BuffAhoy Config
	you can also bind keys to any other functions you want to use.  If you intend on using the Passive Party Targetting
	system (read below), then bind keys to the PPT targetting functions (i.e. PPT Target Party 1, etc).
   5.	Close the key bindings menu, and start using BuffAhoy!



II. The BuffAhoy GUI

  To use BuffAhoy through the GUI, go to Key Bindings and bind a key to "BuffAhoy Config" and then bring up
  one of the configuration panels.  Alternatively, you can type '/ba config' to bring up the configuration panel.  You can select 
  the particular functions you want to edit with the "BuffAhoy Navigation" dropdown box.  You can drag spells from your spellbook 
  into the slots in any of the sections, referred to as "panes" from here on.

  The Reset Button
    	The button to the left of the Exit button on the GUI will reset the entire frame (removing all spells from
     	their slots).  Not sure how useful this is, but it's there if you want it.

  The Verbosity Mode dropdown
	The verbosity mode dropdown box will change the channel to which verbose functions will send their messages.  This 
	defaults to "party" every time you start the game.  Options are "Party", "Raid", and "Say".

1.  The BuffCasting Pane

  The Buffcast pane has functions mostly applicable to Paladins and Druids, but any class can use them.

  The 'Buffing Mode' dropdown box toggles between Individualized buffing mode and Class-based Buffing mode.  In individualized 
  mode, you can specify which buff each party member gets, in order, for 1 buff sequence, as well as 2 buff sequences that cast 
  the same 1 buff on each party member.  In Class-based buffing mode, a different interface is brought up, which lets you 
  specify 1 buff for each class type in the first sequence, as well as 2 sequences which apply the same buff to the entire party
  or raid group.  Note that Class-based mode works in raids or regular parties, while Individualized Mode is only for regular parties.
  To use these you must bind keys to "Buff Sequence 1" through "Buff Sequence 3" in the Key Bindings page.

  Using BuffCast Sequences:    
	Individualized Mode:  The first sets of buttons next to "Buffs" are the buffs you will cast on yourself, each party 
	member, and each party pet, as labelled above each slot.  To use BuffCast, you must bind a key to "Buff Sequence 1" 
	in the Key Bindings control panel (through the main interface).  Pressing that button several times sequentially will 
	buff each party member with the buff located in that GUI slot.  

	The set of slots below sequence 1 are unused at this point, and are a place to put extra buffs from your spellbook so you
	can switch buffs around quickly without having to open your spellbook.

	BuffCast Sequences 2 and 3 will try and buff the entire party with the same buff (you still need to press the
	button multiple times, of course).

     	BuffCast will automatically try and buff pets if a spell is put in the "pets" slot.  It checks for pets every time combat
	ends, so it will usually be up-to-date.  You can bind a key to the 'PetCheck()' function in the GUI if you want to run
	petcheck other times (for example, if someone's pet has died during combat and they resummon it before you start buffing.

     	BuffCast has several verbosity options.  The check buttons below the second set of buffs allow you to choose
	either Verbose, Quiet, or Silent (both unchecked) modes.  

 	Class-Based Mode:   The 8 slots in sequence 1 are labelled according to class type.  Drag a buff into
	each slot to specify what buff that class will receive when you run Buff Sequence 1.  Sequences 2 
	and 3 will buff every raid or party member with the buff in the Seq. 2 or Seq. 3 slot.  The verbosity settings are 
	identical to that of BuffCast.
     

2.  The Multi/ShoutCast pane

  The Multicast pane has functions that are more useful to casters like Mages and Warlocks, but any class can use them.

 a)  Using MultiCast Sequences:     The two sets of buttons next to "MultiCast" are the spells you will cast sequentially.  
	To use MultiCast, you must bind a key to "MultiCast Sequence 1" or "MultiCast Sequence 2" in the Key Bindings control panel 
	(through the main interface).  Pressing that button several times sequentially will cast the next spell on the list.

     	The MultiCast slots generally assume that you are targetting a hostile unit, though if you do not have one targetted they
	will still attempt to cast using the PPT system.  The checkbox at the top allows you to enable or disable Verbosity in the 
	Multicast sequences. 

------ NOTE THAT MULTICAST SEQUENCES USE A MODIFIED VERSION THE PPT SYSTEM THAT WILL CAST ON HOSTILE TARGETS!!

 b)  Using ShoutCast buttons:	    The four buttons below MultiCast are ShoutCast buttons.  Spells placed in these slots will be
     	cast using the ShoutCast algorithm, which announces to the party what spell you are casting and the target of the spell.  
	The checkboxes to the right toggle the verbosity (in case you only want to use the slot for selfcasting) and whether the
	slot uses the SmartCast algorithm.  Note that the "SmartCast enabled" setting will override this, if it's disabled.

------ NOTE THAT SHOUTCAST BUTTONS USE A MODIFIED VERSION THE PPT SYSTEM THAT WILL CAST ON HOSTILE TARGETS!!

3.  The Utility pane

  The Utility Pane has six "Utility Spell" slots:  There are 6 slots, named "Heal 1", "Heal 2", "Heal 3", "Cleanse 1", "Cleanse 2",
  and "Protect".  These are slots that are designed for utility spells, appropriate to the names.  You can drag any spell to 
  these slots, of course, the names are just a suggestion.

  The check boxes to the right toggle the verbosity and whether the spell uses the SmartCast algorithm.  Note that disabling the
  "SmartCast enabled" checkbox in the Options pane will override the individual ones.

	These slots use the Passive Party Targetting system, so here is a quick description of how it works.  First,
     	bind a key to the "Target Party 1" through "Target Party 4" functions through the Key Binding configuration.
     
     	Now, if you are targetting a friendly target and press the button bound to "Heal 1", you will heal that
     	target (whether they are in your party or not).
     	If you instead target a hostile target, or no target at all, it will cast the heal spell on the current
     	"PartyTarget".  You can set the "PartyTarget" by pressing the keys bound to the "Target Party #" functions.
        example:  if F3 is bound to "Target Party 3", and "H" is bound to "Heal 1", then the sequence:
	F3, H
	will set the 3rd party member as the passive target and cast the healing spell on them, without breaking
        your current combat target.  Party member 3 will remain the passive party target until one of the other
        "Target Party #" functions are called (by pressin the appropriate key bind).
	
	These slots also (optionally) use the SmartCast algorithm, so if you're holding the smartcast key while pressing the 
	button bound to this function, you will cast the spell on yourself instead.  You can disable this by unchecking the 
	checkbox next to the button.


	Using Protect:
     	The button beneath "Protect" is the button used in the verbose protection function, Protectzor.  You should
     	drag a protection spell (paladins: Blessing of Protection, other classes: ?) to this slot, and bind a key
     	to "Protect Party member" in the Key Bindings Config.

	A special mention needs to be made of this slot, because it is designed for a paladin's Blessing of Protection.
	BoP is only castable on party members, so the logic used for this slot reflects that, and will give you an error
	message if you try and use it on other people.  Keep this in mind if you decide to use this slot for a spell'
	that doesn't have this limitation.


4.  The Options Pane

  The Options pane contains all of the major options for BuffAhoy.  Here's a rundown of the options:

	a) PPT Enabled	     		    --	This Option will enable or disable the Passive Party Targetting system.  See above 
				for a description of how PPT works.  If you disable this, BuffAhoy will actively target everything.

	b) SmartCast Enabled 		    --	This Option enables or disables the BuffAhoy SmartCast algorithm, which 
				auto-targets you if the SmartCast button is held down.  The SmartCast button can be chosen by the 
				dropdown box to the right of this option, you can use either Alt or Shift.  Remember that 
				SmartCast ONLY applies to certain functions in BuffAhoy, not all spells cast.

	c) Wait on Mana/Range when Buffing  -- 	This option will cause you to target each player during a buffcast sequence when 
				outside of combat.  As a result, it will wait until you have enough mana and your target is 
				in range.  This is useful if you don't want to skip someone while buffing because they're out 
				of range.  Again, this only activates if you're outside of combat.

	d) Verbose Multicasting		    --	This option will make multicast sequences verbose, thus announcing each spell
				in the sequence.

	e) Enable Status Messages	    -- 	This option will toggle the chat frame status messages for cooldown and mana checks
				(i.e., this will disable the "Patience, young padawan" message).

	f) Enable Failure/Interruption Messages	
					    --	This option will toggle the "Spell Failed", "Spell Interrupted", and "Spell Delayed"
				messages that occur for verbose functions when the appropriate events happen.

	g) Force Class-Based Buffing to ignore Raid
					    --  This option will force the Class-Based buffing algorithm to buf only your immediate
				party, even if you're in a raid group.
	
	h) Show PPT Frame		    --  This toggles the visibility of the PPT Frame.  The PPT frame is a draggable box
				that shows the name of the current target of the PPT system.  It's mostly for reference, so you can
				see at a glance who you'll cast on when you use a BuffAhoy PPT-enabled function.

------- EVERYTHING BELOW THIS LINE IS FOR ADVANCED OR LEGACY USERS.  IF YOU ARE NOT ADEPT AT MACROS, IT'S PROBABLY NOT WORTH YOUR TIME TO READ THE REST OF THE README --------


III.  The BuffAhoy Macro Interface

    All of the major functions which can be bound via keys can also be called with a slash command, such as:

	/ba buff1	(Buff Sequence 1)

    the other functions are as follows:
	/ba buff2	(Buff Sequence 2)
	/ba buff3	(Buff Sequence 3)
	/ba heal1	(Heal 1)
	  - /ba heal3	  - (Heal 4)
	/ba cleanse1	(Cleanse 1)
	  - /ba cleanse2  - (Cleanse 2)
	/ba protect	(Protect)
	/ba multi1	(Multicast Seq 1)
	/ba multi2	(Multicast seq 2)
	/ba shout1	(shoutcast 1)
	  - /ba shout4 	  -(shoutcast 4)

    Alternatively, you can access the base logic functions as described below.

    BuffAhoy adds the following functions, which can be called in macros:

  Macro-Enabled Functions:  (NOTE, this list is out of date as of 4/12/05, i'll try and update it by the next patch.  In particular, it omits BBoC)
    Cleanzor()		Cleansing script
    Healzor()		Healing script	
    BuffCast()		Buff casting sequencer for whole party
    Protectzor()	Protection script
    Smartzor()		Smartcasing script
    ShoutCast()		Verbose Casting - announces the target and spell being cast to party
    MultiCast()		Casting Sequencer, basically CastAway using action id's instead of names
    MultiShoutCast()	Verbose Casting Sequencer, read the description
    BandAid()		Action/Bandage script, designed for a rogue, but included for fun
    UsableCheck()	Checks to see if a spell is usable (mana/cooldown/range checks).
    PetCheck()		Function that checks the party for pets, should be run before BuffCast
    PartyTarget1() - 
      PartyTarget4() 	Party Targetting functions to work with Cleanzor,Healzor, SmartCast,etc
                        Sets PartyTarget variable to one of the party members  (PPT system)
    PetTarget1()-
      PetTarget4()	Pet Targetting functions for the PPT system
    PetTargetMine()	Pet Targetting function for the PPT system


    To use the macro version of BuffAhoy, bind keys to the four Party Target functions and PetCheck() in the 
    Key Bindings page, and then create a macro and type in the appropriate syntax:

    /script Cleanzor(spellid)
        1 optional argument.
	Required:
	spellid  is the action bar id of your Cleanse spell.  It is only needed if you want the castable
	checks (i.e. checks for enough mana, cooldown, and range) to work.  Except that at the moment 
	they don't.  Oops.  Working on this.

	This script casts Cleanse on current target if it is friendly, or yourself if shift
        is being held down  (using the SmartCast system).  If target is hostile or there is no target, it will cast the spell 
        on the current party target (without breaking combat!).  This is basically Smartzor() but with
	a customized party message.  
	
	This script can be run in verbose or silent mode.  In silent mode, the party message is omitted. 
	This is togglable through the GUI



    /script Healzor(spellid, "Spellname(Rank X)")
	1 required argument, 1 optional argument.
	Required:
	spellid  is the action bar id of the heal spell you want to cast.  
	Optional:
	"Spellname(Rank X)"  is the name of a healing spell you know, but do not have in your action bar.
	To use this optional argument, you must set the first argument to zero.  Also note that using this 
	optional argument will disable the castable checks (mana, cooldown, and range).

	This will cast that spell on the current target if it is friendly.  If the target is hostile or 
	there is no target, it will cast the spell on the current party target (without breaking combat!).  
	This script is also verbose, in that it tells the party who you're trying to heal, or that you 
	do not have mana to heal them.

	    example:  /script Healzor(12)
	will cast the spell in slot 12 on the appropriate target, and announce to the party the name
	of the character you are healing.

	    example:  /script Healzor(0, "Flash of Light(Rank 3)")  
        will cast a rank 3 Flash of light on the target.  This will become more useful if i get around to
	implementing the system i eventually hope to use, that would cast the highest level heal spell
	the caster currently knows as a default.  Maybe i'll get around to that next patch.

	This script can be run in verbose or silent mode.  In silent mode, the party message is omitted.  
	The verbosity can be toggled via the GUI.



    /script BuffCast("Name", timeout, petbuff, yourbuff, party1buff, party2buff, party3buff, party4buff)
	3 required arguments, 1-5 optional arguments.
	Required:
        "Name"  is the name of the current buffset (makes it possible to have several different buff 
           arrangements).  This is identical to the format of CastAway and serves the same purpose.
        timeout is the time (in seconds) before the script resets to targetting you again
        petbuff is the number of the action you want to perform on all party pets
           (i.e. if Blessing of Might is on your Action Bar in slot 4, then making this value 4 will
           cause all party pets to receive that blessing).  This works with the bindings in Flexbar.
           To use actions on other bars, add 12 for each bar you've scrolled (ex. first bar is 1-12,
           second is 13-24, etc).
	Optional:
        yourbuff  is the number of the action you want to perform on yourself (see above)
        party1buff  is the number of the action to be taken for party member 1
        party2buff  is the number of the action to be taken for party member 2
        party3buff  (see above)
        party4buff  (see above)

	This script will cast the predefined buffs (passed as arguments to the function) on the respective party
	member.  
        This script is also "smart", in the sense that it will automatically cast buffs on each party 
	member's pet.  For this to work, the PetCheck() function has to be run at least once so that the 
	function knows what pets the party has.  Read the description for PetCheck() for more information.

	It will also not attempt to cast a buff if the action is not usable, costs too much mana,
	is still cooling down, or is trying to target a party member that doesn't exist.  It is NOT smart enough
	to avoid trying to cast if your target is out of range however.

        To use this function, you must press the key bound to this macro once for each party member 
        and pet (including yourself).

        example Macro:
          /script BuffCast("defaultBuff", 20, 4, 5, 6, 86, 32)
          This will cast the spell in Action Slot 4 on all party pets, Action Slot 5 on you, action 
          slot 6 on party member 1, 6 on party member 2, 86 on party member 3, and 32 on party member 4. 

	This script can be run in verbose, quiet or silent mode.  In silent mode, the party messages are omitted,
	while in quiet mode the messages are instead sent to the default chat frame (only visible to you).  
	The verbosity can be toggled in the GUI.


    /script Protectzor(spellid)  
	1 required argument.
	Required:
	spellid is the action bar id of the protection spell you want to cast

	This string is a verbose script for casting a Blessing of Protection spell on a party member. 
	It doesn't use the SmartCast system, but it does use the PPT system (so you can protect someone
	while in combat without breaking target, but you can't use this one on yourself).  I might add
	the smartcast functionality in the future, but for right now it's disabled (mostly because my personal keybind
	for this involves Shift).

	This script can be run in verbose or silent mode.  In silent mode, the party message is omitted.  
	The verbosity can be toggled in the GUI.


    /script SmartPPT(spellid, saystring, verbose, smart)
	1 required argument, 3 optional arguments.
	Required:
	spellid  is the action bar id of the spell spell you want to cast.  
	Optional:
	"saystring"  is a string that is used in the party chat statement made by this script
	verbose is a toggle for verbosity, if set to 1 the script will be verbose.  If set to 0 this 
	  will disable the verbosity of the function.
	smart is a toggle for smartcastability, if set to 0 the script will NOT use the smartcast algorithm.
        
	This script is a smart-cast script.  It will cast the spell in Action Slot spellid on the current 
        target if it is friendly, or yourself if shift is being held down.  If the current target is 
        hostile or there is no target, it will cast the spell on the current party target (without 
        breaking combat!).  This is also verbose for the party (it will report your action to the 
        whole party), and should give you error messages if the action isn't usable due to cooldown,
	mana, or range (though the range check doesn't work with the Passive Party Targetting system
	yet).

	example:
	  /script SmartPPT(8, "Casting the Best Spell Ever on")
        will cast the spell in action slot 8 on the appropriate target (read above), and send the
	following message to the party (lets assume your target's name is Bob):
	"Casting the Best Spell Ever on Bob"
	Since verbose and smart are omitted, they will default to true (1)
	  
        note that you can omit "saystring", which will just shut off the party message

     
    /script ShoutCast(spellid, "saystring", verbose, smart))
	1 required argument, 3 optional argument.
	Required:
	spellid  is the action bar id of the spell you want to cast.  
	Optional:
	"saystring"  is a string that is used in the party chat statement made by this script
	verbose is a toggle for verbosity, if set to 1 the script will be verbose.  If set to 0 this 
	  will disable the verbosity of the function.
	smart is a toggle for smartcastability, if set to 0 the script will NOT use the smartcast algorithm.
        
        This script is a verbose casting script.  It will inform the party of the target of the current
        spell, as well as a user-defined string describing what you're casting.  You're probably asking
	yourself what the difference is between this and Smartzor().  The answer is that this does NOT
	use the Smart Casting or Passive Party Targetting systems.  This is for spells like Polymorph,
	which you wouldn't use on a friendly or party member.

        example Macro:
          /script ShoutCast(4, "My Favorite Spell")
          This will cast the spell in action slot 4 and send the following message to party chat
          (assuming you're targetting me, and i'm not on your faction):
          "Casting My Favorite Spell on Theck"

        note that you can omit "saystring", which will just shut off the party message (making the
        function rather useless).  Also, omitting verbose and smart defaults them to true (1)


    /script MultiCast("Name", timeout, spell1, spell2, ...)
	2 required arguments, 1-? optional arguments.
	Required:
        "Name"  is the name of the current buffset (makes it possible to have several different buff 
           arrangements).  This is identical to the format of CastAway and serves the same purpose.
        timeout  is the time (in seconds) before the script resets to step 1
	Optional:
        spell1, spell2, ...  are the numbers of the action bar slots of the spells to be cast, in the order
          they are listed in the macro.

        This script will cast spell1 on the first keypress, spell2 on the second keypress, etc.  It will
        recycle back to spell1 at the end of the list, or after a period of inactivity set by the 
        "timeout" variable (in seconds).  This is functionally identical to CastAway, but it uses Action
        ids instead of Spell Names.  While i say there are only 2 required arguments, this is completely
	useless unless you use at least 2 spells, bringing the total to 4 arguments.
	
	example Macro:
	  /script MultiShoutCast("SpellSequence", 20, 8, 9, 10)
	will do the following:
	  First Keypress:
		Casts the spell in action slot 8
	  Second Keypress:
		Casts the spell in action slot 9
	  Third Keypress:
		Casts the spell in action slot 10

    /script MultiShoutCast("Name", timeout, spell1, "saystring1", spell2, "saystring2", ...)
	2 required arguments, 1-? optional arguments.
	Required:
        "Name"  is the name of the current buffset (makes it possible to have several different buff 
           arrangements).  This is identical to the format of CastAway and serves the same purpose.
        timeout  is the time (in seconds) before the script resets to step 1
	Optional:
        spell1, spell2, ...  are the numbers of the action bar slots of the spells to be cast, in the order
          they are listed in the macro.
        "saystring1","saystring2", ...  are strings used in the party chat statements made by this script

        This script will cast spell1 on the first keypress, spell2 on the second keypress, etc.  It will
        recycle back to spell1 at the end of the list, or after a period of inactivity set by the 
        "timeout" variable (in seconds).  What makes this different than MultiCast() is that this script
	is also verbose, so it will send messages to the party when you are casting each spell.  Replacing the
	"saystring#" argument with nil will result in no message for that step.

	example Macro:
	  /script MultiShoutCast("FunSequence", 20, 8, "First Spell", 9, nil, 10, "Third Spell")
	will do the following:
	  First Keypress:
		Casts the spell in action slot 8
		Sends Message to the party: "Casting First Spell on TargetName"
	  Second Keypress:
		Casts the spell in action slot 9
	  Third Keypress:
		Casts the spell in action slot 10
		Sends message to the party: "Casting Third Spell on TargetName"

  /script UsableCheck(spellid, verbose, "manastring", "cdstring", "oorstring")
	1 required argument, 4 optional arguments.
	Required:
	spellid is the id number of the action bar slot of the spell being checked.
	Optional:
	verbose is a toggle for verbosity of the function.  If a 1 is passed, it will give feedback in
	  the default chat frame or party chat depending on whether a string is passed in one of the next three arguments
	"manastring" is a string that is used in the party chat announcement for an out of mana error
	"cdstring"  is a string that is used in the party chat announcement for a cooldown error
	"oorstring"  is a string that is used in the party chat announcement for an out of range error

	This function returns true if the slot is usable, else it returns nil.

  /script BandAid("SpellName(Rank X)", bag, slot)
	3 required arguments.
	Required:
        "SpellName(Rank X)" is a spell or ability known by the player
        bag, slot are the bag/slot coordinates of the bandages in your inventory.  Bags start at
          0 (backpack) and go to 4.  Slot ids are counted from the top left slot calendar-style, 
          starting with 1.  so 0,3 would be the 3rd slot across the top row in your backpack, and 
          3,1 would be the top left slot of your third bag.

        This script is similar to the BuffCast script, except it toggles between 2 actions, one of which
        is a spell or ability and the second of which is the use of an item on yourself from a particular
        location in your backpack.  To use this, press the key bound to this macro twice AFTER highlighting
        your target.  The first press will cast the desired spell on the target (if possible), and the
        second press will attempt to use the item in your inventory at location (bag, slot) on yourself.
	This was written for a Rogue who wanted to Gouge and then Bandage right afterwards. 

  /script RaidCheck(loud)
	1 optional argument.
	Optional:
	loud is either 1 or 0 -- when set to 1, the function runs silently, when set to 0, it will spit out the name
	and level of every raid member to the Default Chat Frame.

  /script RaidCast(cast_id, timeout, id)
	2 required arguments, 1 optional argument.
	Required:
	cast_id is a string describing the sequence, only used to create the data array
	timeout is an integer number of seconds before the sequence will reset
	Optional:
	id is the action bar slot of a buff.  This is used to override the class-based buffing that is the default
	mode for RaidCast.  If id is non-nil, it will attempt to buff every raid member with the spell in slot id.
	
	Note that you cannot call this function without using the action bar slots if you want to use the class-based
	buffing algorithm.

Bindable Functions:

  PetCheck()
	No arguments
	This script will check the party for pets.  It does this by trying to target each party member's pet, and 
	storing the names it finds in an array that gets used in BuffCast.  It will check to see if you have a hostile
	target first, and if so, it will restore that target after it checks the party for pets (though it won't 
	attack that target afterwards).  I considered running this every time BuffCast was used, but i decided against
	it so that BuffCast could be cast in combat without ever breaking target.  

	As a result, this should be used once before BuffCast is used (otherwise it won't try and buff pets).  However,
	it does NOT need to be cast before every buff -- as long as the party's pets haven't changed, running PetCheck() 
	again won't do anything useful for you.

	Any time a party member gets a new pet, or loses a pet, or changes a pet, PetCheck() should be run so that 
	BuffCast can accurately buff the party.


  PartyTarget1()
	This will set the PartyTarget (the passive target for PPT-enabled scripts) to party member 1.  If the 
	"PPT Enabled" box is unchecked, this will actively target the respective party member. 	


  PartyTarget2()	
	See above, but replace 1 with 2 everywhere.  Same goes for 3 and 4.


  PetTarget1()
	This will set the PartyTarget to the first party member's pet (not counting yourself).  Same goes for 2-4.

  PetTargetMine()
	This will set your pet to be the current PartyTarget.