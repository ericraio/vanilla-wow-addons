_____________________________________________________________________________________

Ace

Author:   Kaelten (kaelten@gmail.com)
Version:  1.3.1
Release:  5/12/2006
Website:  http://www.wowace.com
_____________________________________________________________________________________



Ace is a lightweight and powerful addon development system. It is a new approach to
addon development, a rethinking from the ground up. Ace provides developers with the
tools needed by most addons, freeing them from repeating common tasks and allowing
them to jump right into the creative part of building their addons.


_____________________________________________________________________________________

	FEATURES
_____________________________________________________________________________________

So what does Ace have to offer? Here is a brief list of its features:

	- Initializes the addon after variables and character data load.
	- Simple, flexible, and powerful data management.
	- Customizable chat command handling.
	- Improved function and method hooking.
	- Enhanced event handling with the ability to create custom events.
	- In-game addon disabling and enabling.
	- Easy saving of settings per character and per class.
	- Debug features with optional module.
	- Built-in myAddons support.

New features for 1.2! (Requires World of Warcraft client version 1.7+)

	- On-demand loading of addons. (Addons must support this specifically.)
	- New enable and disable features. (Require UI reload or game restart.)
	- Script hooking capabilities.

_____________________________________________________________________________________

	USAGE
_____________________________________________________________________________________

Ace provides some basic commands to the player for managing Ace-derived addons. To
use Ace for addon development, see the note below.

--------------
 ACE COMMANDS
--------------

/ace

Entered without options, this command will display a list of available options and
other available information.

/ace enable | disable <addon>

This is a "hard" enable or disable. It does the same thing as when you check or un-
check the addon's flag in the AddOns menu of your character screen. When you change
this status in game, you must restart the game or reload the UI for the change to
take effect.

/ace info

Display summary information about the addons installed and the loaded profile.

/ace list [<addon> | loadable | nonace]

Display a list of currently installed or loadable addons. If /ace list is typed
without additional parameters, it will display a list of all currently loaded Ace
addons.

Options:
	
	- <addon>	: Type the name of a specific addon to search for. If found, Ace
				  will display whatever information it can. For non-ace addons, or
				  addons that aren't currently loaded, this information will be
				  limited.
	- ace		: List only currently loaded Ace addons.
	- other		: List all other currently loaded addons.
	- loadable	: List all addons that are available to be loaded. This cannot
				  distinguish between Ace and other addons.

/ace load [auto | off] <addon>

Load the specified addon if it is not currently loaded. This command will load any
addon that is set for loading on demand, not just Ace addons.

Options:

	- auto	: Automatically load the addon on startup. This state is saved in the
			  current Ace profile, so you can auto-load addons per character or per
			  class.
	- off	: Turn off the automatic loading of an addon in the current Ace profile.
			  Note that the addon cannot be unloaded. It will still remain loaded
			  but will not load automatically the next time you restart the game.

/ace loadmsg (addon | none | sum)

Change the load message at game load. 'addon' will display a load message for every
addon. 'none' will display no load messages at all. 'sum' will display a summary of
the number of addons installed and the loaded profile. A summary is the default.

/ace profile (char | class | default) [<addon> | all]

Change the basic profile your character uses. A profile stores a specific set of
configurations for your addons. By default, the 'char' and 'class' profiles will
be created empty. You must add each addon to the profile individually. So, for
example, the first time you run "/ace profile char", that character's profile will
be empty, meaning you'll still be using all addons' default settings. If you then,
for example, type "/ace profile char coins", any setting changes you make to Coins
after that will be reflected in the character's profile and not the default profile.

Options:

	- char	  : Use a profile specific to the current character.
	- class   : Use a profile specific to the character's class. This profile can
				be shared by all characters of that class.
	- default : Use a default profile that will be shared by all characters if no
				specific profile is selected.

	Additional arguments usable with 'char' and 'class':
	
		- <addon> : An optional argument that lets you add an addon to the 'char'
					or 'class' profile. Once added to the profile, any changes you
					make to the addon will be specific to that character or the
					character's class.
		- all	  : Add every addon to the profile so that each will be customized
					in that profile.

-----------------------
 COMMON ADDON COMMANDS
-----------------------

There are common commands available to most, if not all, Ace addons. Addon authors
have some measure of control over these, however, so they may not be available in
all Ace addons.

/<cmd> ? or /<cmd> ? <option>

This is a help command that will display some extra detail on the addon itself or
on the command option you supply.

/<cmd> enable | disable

This allows the addon to be enabled or disabled in-game. The enabled/disabled state
will also be saved between game sessions. Disabling/enabling will save specific to
the profile you have loaded, so addons may be enabled or disabled for specific
characters or classes.

/<cmd> report

Not all addons will have this option available. If it is available, this will
display all of that addon's settings within the currently loaded profile.

_____________________________________________________________________________________

	DEVELOPMENT
_____________________________________________________________________________________

To use Ace for addon development, download the developer tool kit, which contains
documentation, examples, templates, and AceUtil, a unique, non-distributed library
of shareable functions.

_____________________________________________________________________________________

	CREDITS
_____________________________________________________________________________________

- Rowne for his Fetch and FetchDB, which AceState and AceDB, respectively, were
  derived from. While I claim some credit for adding my own ideas to AceDB's data-
  handling approach, it is primarily Rowne's concept. Rowne is a brilliant
  efficiency expert. His work is what inspired me to create Ace.
- Trimble, who got me started on Lua and addon development. His debug usage is what
  inspired my eventual implementation of debug handling in Ace.
- Danboo for his wonderfully efficient and elegent event handling technique. Even
  though his technique may not be readily recognizable in Ace's variation on it,
  the basic concept is still derived from his and would not exist if he hadn't
  first introduced his.
- Lazything for his suggestion in Rowne's Fetch forum on Curse to have an addon
  register itself for state initialization instead of needing its own frame. This
  little trick greatly reduces redundant code in addons' XML files.
- Derkyle, for code in his ItemsMatrix which inspired me to expand AceHook with the
  capability to hook object methods in addition to just functions.
- Neriak for the German translation.

_____________________________________________________________________________________

	SPECIAL THANKS
_____________________________________________________________________________________

The following people deserve very special thanks.

- Rowne, not just for the many excellent ideas of his I incorporated into Ace, but
  also for his support and feedback while helping me to test Ace and all my Ace
  addons. I can happily and gratefully say that Rowne is the first developer other
  than myself to adopt Ace. His conversion of all his addons to Ace was a great test
  run that helped stabalize and polish Ace for release.

- Kalia for her kind and patient support and testing of all my Ace addons. She
  helped polish these addons, stamp out bugs, and plug up some memory leaks.

- Kaelten for his contributions and help in testing Ace by adopting it for his
  addons. Also for several good suggestions for tweaks and additions to Ace,
  including the profile system.

_____________________________________________________________________________________

	VERSION HISTORY
_____________________________________________________________________________________

[5/12/2006] v1.3.1
(changed)
- Updated Toc Number for 1.10

[2006-1-4] v1.3 RC3
(changed)
- Changed a few errors to debug statements.  
- A few optimizations.
- Fixed a Hook Bug.

[2006-1-1] v1.3 RC2
(changed)
- Found a couple of errors in my AceHook implementation
- Scripts now use the new hook system.
- Removed file AceScript.lua

[2005-12-30] v1.3 RC1
(changed)
- The Hooking system has  been completely redone.  Fixing the memory leak.
- Hooking scripts has been unified with the hooking system.
- Ace.CopyTable() will not setn on the new table if the original was numerically indexed.
- MyAddons support has been completely updated.  myAddons v2.4 is now supported.  

[2005-10-11] v1.2.5
(changed)
- Updated for game patch 1.8
- Modified Ace's addon loading to handle Blizzard's new addons.

[2005-09-17] v1.2.4
(changed)
- Updated the German localization thanks to Neriak's translations.
(fixed)
- A bug that broke the use of AceDebug

[2005-09-15] v1.2.3
(fixed)
- A bug in the chat command registering that prevented an addon's additional
  commands from registering if the first one was already in use.

[2005-09-14] v1.2.2
(fixed)
- Supplied temporary function mappings for CmdEnable and CmdDisable, which were
  removed in 1.2, to support existing addons' use of these.

[2005-09-14] v1.2.1
(fixed)
- A typo in the myAddOns support
- Removed a leftover debugging statement.

[2005-09-13] v1.2
-----------------
 Feature Changes
-----------------
(chat commands)
- load : Load any addon (not just Ace addons) that can be loaded dynamically. Type
  /ace list loadable for a list of addons you can load. Note that addons must be
  modified to be loadable in this way, so you may not immediately be able to use
  this feature.
- enable/disable : These affect the flag that appears in the AddOn menu on the
  character login screen. They only toggle this flag. You will have to restart the
  game or reload the UI to load or unload the addon.
- list : This option has been modified.
	/ace list : Displays a list of all addons. For Ace addons, it will display their
				primary chat command.
	/ace list ace		: List only Ace addons.
	/ace list other 	: List non-Ace addons.
	/ace list loadable	: List addons that can be loaded dynamically, if any.
(new)
- German translation, much thanks to Neriak!
(changed)
- The standard enable/disable options available to most Ace addons' chat commands
  have been replaced with 'standby'. This is to avoid confusion with the new API
  enable/disable features provided in game patch 1.7. 'standby' functions the same
  as enable/disable did but instead acts as a toggle between these two states.
-------------
 API Changes
-------------
(added)
- Script handling support. This refers to the ability to add OnShow, OnClick, and
  other handlers to frame elements. This system works just like the hooking system
  for functions and methods. Addons now have the following methods available to
  them: HookScript, UnhookScript, UnhookAllScripts, and CallScript.
- An enabled event will now fire at game load for each enabled addon.
- New chat command methods:
	error()	 : Prefixes messages with a standard error text.
	msg()	 : Passes all arguments to format() then sends the results to the
			   cmd:result() method.
	status() : Displays a message in similar format to what cmd:report() uses. This
			   is to allow report labels to be reused for chat command feedback.
(changed)
- Base classes have been renamed. The "Class" part of each name has been dropped.
  For example, AceChatCmdClass is now AceChatCmd. The old names are mapped to the
  new, so existing addons will continue working. Use of these names is considered
  deprecated, so they may be removed in the future. This change was just to keep
  naming consistent in light of certain changes to addon declaration standards.
- The game state is initialized differently now to take advantage of ADDON_LOADED
  and to work more efficiently.
- AceDB:insert() will now create a table if the key being referenced does not exist.
- Localization functions will now be destroyed after they are used in order to clear
  even more memory.
- Simplified the way events are processed. Also separated the processing of custom
  events from real events in order to avoid variable clashing.
- Addons no longer require a description field. If left blank, Ace will supply the
  text from the notes section of the toc file. Keep in mind that addons which create
  "sub-addons" or applications (apps for short), such as OneBag, which provides both
  OneBag and OneBankBag will need to supply a separate description for the extra
  apps. Otherwise, each will share the same description.
- The defined chat commands now set an order of precedence. For example, if you
  define a list of chat commands such as COMMANDS = {"/mc", "/mycmd", "/mycommand"}
  then the Ace command object will attempt to use /mc as the primary command. If
  /mc is already registered by another addon, then /mycmd will be attempted. Each
  command will still be registered if possible, but now the first one that is able
  to be registered will be the one shown in Ace's addon lists and usage displays.
- The AceChatCmd:report() method now accept 'indent' as one of the configuration
  options in addition to 'text', 'val', and 'map'. 'indent' is an integer specifying
  the number of level to indent a report line.
