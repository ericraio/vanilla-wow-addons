TODO
update readme on how to use "Super" macros

3.14a
fixed: count should show totalcount in all bags and slots
3.14
Include alias replacement from other mods (eg ASF, ChatAlias)
for any other alias addons, do SM_InsertAliasFunction(your_replacement_function, pos) inside your mod. pos must be -1 if the function removes newlines; otherwise leave out pos. make sure SuperMacro is loaded when this insertion is called, so make SM an optional dependency or after VARIABLES_LOADED.
stretched popup frame by two rows
fixed: tooltip with macro code still appear after leaving action button
fixed: sayrandom error
hide action text on discord bars
make minimap button toplevel
brighten rank text on tooltips
new function CancelBuff, unbuff, /unbuff, /smunbuff
fixed: set owner for SM_Tooltip
fixed: FindBuff should work better

SuperMacro v3.14 by Aquendyn

Installing SuperMacro:
Before you unzip, backup your old Bindings.xml and SM_Extend.lua that are in the SuperMacro folder (if you have on older version of SuperMacro).
Unzip the files into WoW/Interface/Addons . A new directory called SuperMacro will be automatically created, and the files will be extracted there.
Then, copy your backup Bindings.xml into SuperMacro folder, if you have one.
You may also create a text file called SM_Extend.lua and put extra long codes in there.

This addon provides a very much improved interface for macros. Its special functions includes the following, and probably more:
New SuperMacro frame shows all 18 global and 18 character macros. *
Work around the maximum macro character length of 256 characters (system limit).**
Run macros through keybinds*** and call other macros with RunMacro()****.
Some convenient slash commands and functions*****.
Put an item link or tradeskill recipe into the macro***** *.
Ingame extended LUA code editor***** **.
Options frame***** ***.
Also see functions.txt for user-friendly functions and slash commands that can be used in your macros.

* The new SuperMacro interface displays 18 (global) account macros on the left and 18 character-specific macros on the right. Buttons at the top create new macros for each category. Buttons on the bottom are, in order, delete macro; save macro; open SuperMacro options frame; delete extend; save extend; exit frame. Enter your macro in the left editbox, and your extended LUA codes and functions in the right editbox.

** The letter limit for the entire macro is 256. However, you can get around that if you use call it through another macro, or put long functions in SM_Extend.lua file, or use the in-game extend editor (explained further down in this document.)
Suppose macro 1 has more than 256 characters. If you put this directly on your action bar and try to activate it, you will get an error because the rest of the line beyond the 256th character will be cut off when the macro is saved. What you can do is break up the long macro into smaller parts, and have them call each other, like so (where macro 1 is named Macro1):
<code>
/script RunMacro("Macro1") --more scripting here
</code>
Then put this new macro on your action bar.

NOTE: Do not type the <code> </code> tags themselves, but type what is between them.

Alternatively, put extremely long functions in a file called SM_Extend.lua, which you have to create since the zip doesn't come with this file (so that it doesn't get overwritten when you unzip.)

You can also put global variables and constants in this file.

To define a function in a lua file:
<code>
function FunctionName(parameter1, parameter2, etc.)
	-- code goes here
	-- return variable
end
</code>

FOR EXAMPLE:

<code>
function FindTradeSkillIndex(tradeskill)
	if (TradeSkillFrame:IsVisible()) then
		for i=1,GetNumTradeSkills() do
			tsn,tst,tsx=GetTradeSkillInfo(i);
			if (tsn==tradeskill) then
				tsi=i;
				SelectTradeSkill(tsi);
				TradeSkillInputBox:SetNumber(tsx);
				TradeSkillFrame.numAvailable=tsx;
				return tsi, tsx;
			end
		end
	end
end
</code>

Then, your macro would look something like this:
<code>
/script CastSpellByName("First Aid")
/script tsi,tsx=FindTradeSkillIndex("Heavy Linen Bandage") if (tsx) then DoTradeSkill(tsi,tsx-1) end
</code>

If you change the file SM_Extend.lua while in-game, you need to reload your UI by closing your Macro frame, then entering /script ReloadUI() into the chat line--even better make a macro and keybind for this:
<code>
/script ReloadUI()
</code>

*** The default bindings for this addon provides entries for Macros #1 through #36. Using these as examples, you can add more keybinds by editing the bindings.xml file. Backup this file before you install a new version of SuperMacro. In addition, there are two special bindings for Attack and PetAttack. To use these two macros, you must first create macros for them.

For Attack, follow these instructions.
Make a macro called Attack (note caps) with this body:
<code>
/script if ( not PlayerFrame.inCombat ) then CastSpellByName("Attack") end
</code>
Now, you can assign a keybind for attack, and you can call this macro when executing other macros. For instance, suppose you want a macro to attack and to cast a spell. You can make a macro with this body:
<code>
/script RunMacro("Attack")
/cast Shadow Bolt
</code>

For PetAttack, do the following.
Make a macro called PetAttack (note caps) with this body:
<code>
/script CastPetAction(1);
</code>
Put the pet attack icon in the first slot on your pet action bar (should be there by default).
Now, you can assign a keybind to tell your pet to attack, and you can call this macro when executing other macros. For example, we can change the above example to this:
<code>
/script RunMacro("Attack");
/script RunMacro("PetAttack");
/cast Shadow Bolt
<code>

**** SuperMacro lets your macros call other macros with the special function RunMacro(index) or RunMacro("name"). If index is a number without quotes, it will call the macro in the order displayed in the macro frame. If you instead provide a name of the macro within quotes, you can call the macro if you know its name.
In Bindings.xml for this addon, you will notice bindings for RunMacro(1) through RunMacro(36). They will run the respective macro in the order that you see in the macro frame. Macros 1 to 18 are account macros, and Macros 19-36 are character-specific macros.If you add or delete macros, their order may change, so be careful here. You are free to edit those bindings to call your own macros.
You can use a macro to call other macros simply by providing the name of the other macro. When writing a macro, you will have something like this:
<code>
/script RunMacro("Attack");
</code>
where Attack can be replaced by the name of another macro.
You can also use Macro() in place of RunMacro() if you are close to 256 letter limit.

***** Slash commands
For complete info on slash commands and their corresponding LUA functions, read functions.txt.

Supermacro changes the /macro command so that you can run a macro from the chat line. Use /macro <macro_name>. This is equivalent to /script RunMacro("macro_name").
Ex. /macro Attack

NOTE: Running a macro or script from the chat line will not cast spells.

Another slash command is /supermacro. Just /supermacro shows help for SuperMacro options.

The first option is hideaction 1 or 0. For instance,
/supermacro hideaction 1
/supermacro hideaction 0
Setting it to 1 hides the macro names on action buttons, and 0 shows them. This option is saved between sessions under SM_VARS.hideAction.

Another option is printcolor <red> <green> <blue>. The red, green, and blue values are numbers from 0 to 1. This option changes the color of the text in the /print slash command.
Ex. /supermacro printcolor 1 .5 0.03
Ex. /supermacro printcolor default
The last line sets the color back to default color, which is white.

/supermacro macrotip 0-3
/supermacro macrotip 1 is default setting
0 is normal, 1 show spells only, 2 show macro code only, 3 show spells and/or macro
This replaces the text in the game tooltip when the cursor moves over the action bar buttons. Instead of just showing the macro name, you can choose to have it show the spell's name, if the macro casts a spell, or show the macro code. For option 3, it will try to show the spell first. If that fails, it will show the macro code.

These options and more can also be set in the SuperMacro options frame.

Slash commands for using and equipping items. Use these only when you want to equip or to use a single item. For more complex situations, use other addons.
/use,/smuse <item_name>
/equip,/smequip,/eq,/smeq <item_name>
/equipoff,/smequipoff,/eqoff,/smeqoff <item_name> to equip offhand
/unequip,/smunequip,/uneq,/smuneq <item_name>

You can item link into the macro. See next section for more on item links.
Make sure the /eq and the item link are on the same line.
Ex. 1
/eq [link] is good
Ex. 2
/eq
[link] is not good
Ex. 3
/use blazing wand
/smuse blazing wand
These two commands are equivalent. If another addon already took /use, you could use the /smuse. Same with /eq and /smeq and other commands.

To print some text to the default chat frame, you can use the /print command. Other people cannot see what is printed.
Ex. /print Hello, world.
The default color is white. You can change the color of this text with /supermacro printcolor <red> <green> <blue>
where each red, green, and blue value is between 0 and 1.

***** * Item links
You can get item links directly into a macro by using Alt-click on the item button. You can do this for container items, paperdoll items, bagslots, and tradeskills. Bagslots are the icons on the main menu bar.

To link tradeskills items, Alt-click on the skill in the top half of the frame, that is, where you would select the skill, or the icon. Ctrl-Alt-click will insert the recipe into the macro.

Shift-click on item or tradeskill will insert name, and Ctrl-Shift will insert the name inside quotes.

Since I was doing this anyway, you can also Shift-click on the skill in the same way to put it into the chat edit box (in addition to Shift-clicking on the icon). Ctrl-Shift-click will insert the recipe into chat edit box.

Similarly, you can Shift-click spells from the spell book to insert /cast <spellname>(<spellrank>). Ctrl-Shift-click to insert just the "<spellname>(<spellrank>)" (with quotes.) Alt-Shift-click on spell in spellbook to insert <spellname>(<spellrank>) (without quotes).

***** ** Ingame extend LUA code editor and SM_EXTEND.lua
The right edit box in SuperMacro frame is for extended codes that is associated with that macro. This is saved in SavedVariables under SM_EXTEND table, which is not associated with SM_EXTEND.lua in any way. Either way, these extended codes can be accessed by all macros, usually in the form of functions.

SM_EXTEND.lua does not come with the zip. If you choose to use this feature, you must create a text file and name it SM_EXTEND.lua . Any code you put in this file will be loaded when the addon is first loaded. Your code can be any length. However, if you edit this during playing, you have to reload UI for the changes to take effect.

The in-game extend editor does not need reloading, simply press the Save Extend button. However, the max length for each macro's extend is 7000 letters (not including the macro itself, which is a totally separate issue.) CAUTION, make sure your code has no errors before you close the macro frame.

There are also weird behaviors when you make a new macro or rename a macro.
When you create a new macro with the same name as an existing macro, it will inherit the same extend code from the existing macro.
When you rename a macro with a new name that is the same as another existing macro, the former's extend will be used for both. For example, if macro A has the extend code a=b, macro B has extend b=a, and you rename macro A to macro B, then both macros will now have extend a=b.

If a macro is deleted, the extend that goes with it is also deleted if there are no other macros with the same name.

Version History

3.14
Include alias replacement from other mods (eg ASF, ChatAlias)
for any other alias addons, do SM_InsertAliasFunction(your_replacement_function, pos) inside your mod. pos must be -1 if the function removes newlines; otherwise leave out pos. make sure SuperMacro is loaded when this insertion is called, so make SM an optional dependency or after VARIABLES_LOADED.
stretched popup frame by two rows
fixed: tooltip with macro code still appear after leaving action button
fixed: sayrandom error
hide action text on discord bars
make minimap button toplevel
brighten rank text on tooltips
new function CancelBuff, unbuff, /unbuff, /smunbuff
fixed: set owner for SM_Tooltip
fixed: FindBuff should work better

3.13
fixed: SM_Tooltip.lua:131: `then' expected near `return'

3.12
fixed: this is nil: SM_tooltip.lua line 81
fixed: body is nil for FindFirstSpell and FindFirstItem
caststop(spell [,...]) put in functions.txt

3.11
text and texture for supers returned for non-default action buttons.
tooltip for supers on action buttons.
optimize tooltip, cooldown and icon replacement.
per-character settings for supers on action bars.
option to check cooldown (may decrease framerate). must be on for auto-replace icons to work properly.

3.1 changes
change Print to Printd, other addons retain their Print if present, else Print works like Printd
Ctrl-Shift-click on spell in spellbook to insert "<spellname>(<spellrank>)" (with quotes).
Alt-Shift-click on spell in spellbook to insert <spellname>(<spellrank>) (without quotes).
Shift-click on item or tradeskill will insert name, and Ctrl-Shift-click will insert the name inside quotes.
CraftItem( skill, item, count), /craft, /smcraft
SayRandom(...), /sayrandom, /smsayrandom
Super tab to hold virtual macros (aka Super ones). You can make an unlimited number of "Super" macros, and each Super will hold 7000 characters. Drag them onto action bar as usual. Downside is you can't tell range or IsUsable from action buttons (won't fade out). Cooldown and tooltip still work.
There are new key bindings for the first ten SuperMacros. You can make your own bindings by copying the format of the default ones in Bindings.xml in SuperMacro folder. You could backup your old Bindings.xml and copy over the new bindings.
Function to run a Super is RunSuperMacro(supername | index).
Ex. RunSuperMacro(1);
Ex. RunSuperMacro("MySuperMacro");
You can place SuperMacros on action buttons, but swapping them around is not perfect. These problems may not be not fixable with LUA.
Read functions.txt for further explanations of these new commands: CraftItem, SayRandom, RunSuperMacro.

3.04 changes
fixed bug: tooltip
fixed bug: update buttons
SM_CastSpell renamed SM_FindSpell

3.03 changes
fixed bug: cooldown
fixed bug: /cast
moved menu button

3.0 changes
for 1.9 patch
lost blizzard_macroui dependency
lost unlimited macros
shortened versions of common functions (eg cast, stopcast, use, echo, send, pickup). read functions.txt
options frame
/supermacro options to open options frame
minimap button (optional)
tooltip, cooldown, and count about items and spells (tooltip optional)
action buttons replaced with appropriate icons (optional)
game menu button below Keybindings and above Macros
tooltip support for discordactionbars (untested)
documentation for user-friendly functions in functions.txt
SM_Channel(spell) for uninterrupted channeling, /smchan, /smchannel
/in seconds[+] command, /smin, SM_IN(seconds, command[, repeat])
/shift form
Right-click macro button in SuperMacro frame to run macro.

2.89 change
fixed self-cast
fixed item link from tradeskill
functions.txt lists convenient functions and slash commands
imported some functions from 1900 series
new functions: DoOrder, Pass, Fail

2.85 changes
fixed sending chat messages with \n from RunMacro
remove editing CastSpellByName
/cast to cast highest ranking spell if no rank specified
allows alias in macro (need more testing) [using my other addon Alias-Spellchecker aka ASF]
switch macros on actionbar with SetActionMacro( actionid, macro )

2.8 changes
actionbarbutton macro tooltips enhanced to show spell and/or macro code
slash command for macrotip options
fixed behavior regarding ingame extend
macroframe framestrata changed to high

2.7 changes
in-game extend code increased to 7000 characters (instead of 900)
shows extend character limit
## OptionalDeps: Blizzard_MacroUI

## 2.6 changes
added Macro() function:
Macro = RunMacro;
in-game extend editor (not same as SM_EXTEND.lua):
scripts written with in-game extend are saved in SavedVariables under SuperMacro.lua

## 2.5 changes
Max macro length decreased from 1023 to 256.
Interface updated to show 256 limit.
Makes use of SM_Extend.lua.
Due to the max macro length being shortened, make a file called SM_Extend.lua to define long functions and global variables, then call them from your macros. See example above (FindTradeSkillIndex).

## 2.4 changes
Item link to MacroFrame from container frame items, paperdoll items, bagslots, tradeskills using Alt-click.
Item link to ChatFrameEditBox from tradeskills using Shift-click.
Slash commands for using and equipping items.
/use,/smuse <item_name>
/equip,/smequip,/eq,/smeq <item_name>
/equipoff,/smequipoff,/eqoff,/smeqoff <item_name> to equip offhand
/unequip,/smunequip,/uneq,/smuneq <item_name>
/print,/smprint <text> to display text into chat frame.
/supermacro printcolor <red> <green> <blue> to change color used in /print.

