Prowler 1.7
By Umberto Brisas

This add-on reproduces the bar switch that happens when a Rogue goes into Stealth but with Prowl. 
It does so by switching pages on the regular bars.

Currently is configured to switch from page 1 to page 2 when Prowl is activated. 
To modify your main page and the one to switch to, use /Prowler ingame to open the GUI.

Features:
- Keybinds for shifting into every form.
- Keybind for BestForm, shapeshift you to Travel or Aquatic form depending on if you are on land or swiming
  (Aquatic form only work when breath bar is showing).
- Keybind for shift into Cat and Prowl.
- Keybind for shift into Bear and Charge.
- Restore your last used action bar when switching out of Cat form or use your main bar always.

Sliders and Checkboxes:
There are many sliders and checkboxes when you open Prowler GUI. I will explain what's the meaning for each.

1) Main Bar Slider:
This slider allow you to choose which action bar will be your main action bar, where all your offensive/defensive/whatever
spells you use normaly.

2) Prowl Bar Slider:
This one choose the bar that will be used when prowling, similar to rogues when the stealth and where all your openers are.
Is recomendable to set it to a diferent bar than the main bar.

3) Cat Mode Slider:
This slider changes the behaviour of the "Cat & Prowl" keybind.

4) MoveAnything! fix Checkbox:
This one should be enabled only if you have modified your action bar using MoveAnything! addon. If not when shifting out of
cat you wont be able to see your action bar.

5) Using Main AB / Using Prev AB Checkbox:
While uncheked, when shifting out of bear or cat, you will go back to your Main Action Bar (set on slider 1). If checked,
the addon will remember your last used action bar and will return to that specific bar when shifting out of bear or cat.

6) Bear Only / Bear & Charge Checkbox:
This checkbox controls the behaviour for "Bear & Charge" keybind. When checked you can shift to bear and on a second press
of the keybind use Feral Charge. If uncheked you will only shift to bear.

7) Prowler Enabled / Prowler Disabled:
As it name says enables or disables Prowler. Keybinds will still continue to work, but page changes when prowling and such
won't happen.

8) Prowler Locked / Prowler Unlocked:
Lock/Unlock Prowler window. It's just a cosmetical feature I left from when I was learning how to make frames :P


Macro Functions:
- Shapeshift('form') - Will dismount and shift to the desired form. If you are in other form it will turn 
  yourself to human and on a second press to the desired form.
- CurrentForm() - Search for the active form and return it's name, if there's no active form it returns Humanoid Form.
- SearchForm('form') - Return the position of the desired form on the shapeshift bar.

Forms: 
I've set some variables to help with the functions above, they are set to work with your client language.
- Bear = Bear form in english/french/german
- Cat = Cat form in english/french/german
- Aqua = Aquatic form in english/french/german
- Travel = Travel form in english/french/german
- Human = Humanoid Form (same for all 3 languages)

Macro example: 
/script if (CurrentForm() ~= Human) then Shapeshift(Human) else Whatever() end
/script if (CurrentForm() ~= Bear) then Shapeshift(Bear) else DoOtherThing() end

As you can see those variables don't need to be quoted as they contain the name of the form depending on your 
client localization.

Also I've modified Deshift addon to work with Prowler instead of Swiftshift addon. It's included in this last version. 
It will react to some events and act acording to the situation, for example: Trying to Maul while in Cat Form will bring 
you to Human Form on a first press, to Bear Form in a second press and Maul on a third press.

IsMounted have been introduced as a requiered dependancie to work. It's suplied with the package.


Known Issues
- MoveAnything! fix might be laggy at times
- Some users might have problems with the bar changing feature, report it if its your case with feedback like 
  client language, level, bar mods you use, etc, everything.

P.D. - I recived feedback about making Prowler use diferent ids on the Prowler Bar like other Bar mods do, but that's 
beyond my knowledge for now and also I don't have the time to do it. I'd recomend those users to try some mods the 
like of BibMod, CT_Barmod and some others. I'm sure those would fulfill your desires and more :P

Change Log:

Prowler 1.7c
-Fixed IsMounted addon, Dismounting is back.

Prowler 1.7b
- Made MoveAnything! fix a bit less laggy
- Fixed the problem with Bear form in French (or so I hope) thanks to Effixos

Prowler 1.7a
- Fixed automatically changing back to main bar when reciving a new buff/debuff

Prowler 1.7
- Modified Cat & Prowl function to have the following behaviours chosen from the new slider introduced:
1) Shapeshift to cat only
2) Shapeshift to cat and prowl, but not unprowl.
3) Shapeshift to cat and prowl and unprowl.
- Made IsMounted addon a requiered dependancie (very lightweight and solved perfectly my problems with the dismount feature)

Prowler 1.6c
- Back to saving globaly for all character since the SavePerCharacter wasn't working, at least for me.

Prowler 1.6b
- Updated with cosmetical tweaks to the GUI. Green means enabled, red disabled.
- Prowler now saves variable per character.

Prowler 1.6a
- Fixed a problem with the bar-turning feature when shifting back to human from cat & prowl

Prowler 1.6
- Added Keybind for Bear & Charge (only if you have the skill)
- Added checkbox to enable/disable the Bear & Charge
- Attempt to fix problems with french client (report if it work :P)
- Now, when shifting to bear, Prowler will turn to page 1 as shifting to cat does

Prowler 1.5c
- Trying to fix the "Use Previous actionbar" feature broke the fix made on 1.5a, all should be working now.

Prowler 1.5b
- Trying to fix the page turning problems I broke the "Use Previous actionbar" feature. It's fixed now.

Prowler 1.5a
- Atempt to fix the page turning problem people seems to have.

Prowler 1.5
- Upddated TOC for 1.9
- Added a dismount function, now if mounted while using a shapeshift it will dismount on first press and on 
  a second press will shapeshift you.

Prowler 1.4d
- Fixed another bug on the german localization... Yay fix on the fly :S

Prowler 1.4c
- Broke the Cat & Prowl Function, Its fixed now

Prowler 1.4b
- Fixed a buf with CurrentForm() function and variables to use in macros
- Tweaked a little bit MoveAnything! fix to make it a bit less laggy

Prowler 1.4a
- Accidentaly reintroduced the MoveAnything! bug, it should be fixed now and clicks are removed, it might be a 
  bit laggy at times, though it might be my lazy computer

Prowler 1.4
- Clarified Text on the checkbuttons

Proler v1.3
- Cut down the clicks heard when shifting to Human when the MoveAnything! fix is enabled from 2-3 to only 1
- Altered ActionBar handling when shifting to Cat. Now Prowler will always go to your first ActionBar when 
  shifting to Cat but will go back to your previous ActionBar or the Main ActionBar depending on the option 
  selected when going back to human.

Prowler v1.2
- Updated TOC to work with 1.8.
- Removed Slash commands and added a GUI. /Prowler to use it
- Added checkbox in the GUI to disable the addon
- Added checkbox to restore the last used action bar when switching our of cat form when enabled or go to the 
  main action bar if disabled
- Remake of 60% of the code to be even less laggy (instead of calling functions over and over now I use tables 
  that update every time an event is fired)
- Tried to fix the problem with MoveAnything! addon
- Added a checkbox on the UI to disable the fix

Prowler v1.1
- Updated TOC to work with 1.7.
- Added several functions for macros (check info above).
- Modified and added Deshift Addon to work with Prowler.

Prowler v1.0
- Added Best Form Keybind

Prowler v0.9a
- Added french localization (Thanks to Pherus)

Prowler v0.9
- Added keybind to turn into Cat Form and Prowl.
- Added keybinds to shift to other forms.

Prowler v0.8
- Fixed why it might not work for everyone.

Prowler v0.7
- Fixed a Print function error. Replaced Print for my own Prowler_Print function.

Prowler v0.6
- Added Slash Commands to modify the main and prowl bars without having to mess with the lua file. Check /Prowler for help.

Prowler v0.5
- General TOC update to work with 1.6

Prowler v0.4
- Fixed localization typo for french users.

Prowler v0.3
- Added a check that toggles the mod off if the player is not a druid. It's very rough too, but works <blush>

Prowler v0.2
- Added a very rough German and French localization. Don't ask me for any better yet as I'm still learning :P

Prowler v0.1
- Initial Release