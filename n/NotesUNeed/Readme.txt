
NotesUNeed v3.21.11000 - Telic of Dragonblight (EU)
--------------------------------------------------



Changes in v3.21.11000 from v3.21.1900
--------------------------------------

- Simply updated the toc file for latest WoW version 1.10





Changes in v3.21.1900 from v3.21.1900
-------------------------------------

- Fixed the problem of NotesUNeed notes linking to the wrong Map Notes, after deletion of a Map Note
- Fixed a Map Noting reporting error affecting users of MetaMap in locations where /quicknote will not function
- Adjusted Variable Initialisation for people upgrading from v2.50



Changes in v3.20.1900 from v3.16.1900
-------------------------------------

- Full MapNotes functionality now available to users of MetaMap. ( WorldMapTooltip can be scaled from NotesUNeed by clicking on the double-A button in the top right of NotesUNeed frames )
- Improved the ability to "re-link" NotesUNeed notes to existing WorldMap notes containing the name of the NotesUNeed note
- Adjusted Map Noting functionality to display the NotesUNeed note list frame even for single notes.

N.B. - remember that Alt-Clicking on a particular note's button in the NotesUNeed note list frame on the WorldMap will close the WorldMap and open the NotesUNeed note for editing; And Alt-Right Clicking will delete the link between the Map Note and the NotesUNeed note.

N.B.2. - NotesUNeed notes will still display if the WorldMapTooltip text is equal to the name of a NotesUNeed note. So Map Notes created independantly of the NotesUNeed note of the same name, can still cause the NotesUNeed tooltip to display on the World Map.

- Updated the scaling of Frames, Tooltips, and WorldMap Tooltips - you may need to re-adjust your scaling once after installing this update.
- Options Reset will now restore frames to their original positions
- Ensured the "Confirm Save at Account Level" frame is displayed even when trying to save without displaying the note, IF a Realm conflict exists.
- Fixed the display of Realms list in the "Confirm Save at Account Level" frame.


NOTE ON UPGRADING FROM MapNotes TO MetaMap
------------------------------------------
This warning message refers only to the links between NotesUNeed notes and MapNotes.  i.e. where you have used NotesUNeed to merge several notes on a single MapNote, resulting in the NotesUNeed note list frame being displayed on the WorldMap.

You will NOT lose any MapNotes, or MetaMap Notes, or NotesUNeed notes by upgrading to this version of NotesUNeed.  But the database links between NotesUNeed notes and MapNotes are at risk unless you take the following advice.
(As per normal functionality, even if links between NotesUNeed notes and MapNotes have been lost, if a MapNote has the same name as a NotesUNeed note, then the NotesUNeed tooltip will still display on the WorldMap when the WorldMap Tooltip displays.)

The Advice :
If you are moving from MapNotes to MetaMap and you wish to keep links between NotesUNeed notes and MapNotes, then you MUST keep MapNotes installed the first time that you run WoW with MetaMap installed.  i.e. you must follow the author of MetaMap's advice on how to migrate your MapNotes in to MetaMap. However, to ensure that you keep links between NotesUNeed notes and MapNotes, you MUST run both MetaMap and MapNotes at the same time the FIRST time that you run MetaMap; After which, you may uninstall MapNotes and forget about it.  If you uninstall MapNotes, and run MetaMap without it while NotesUNeed is installed, all links between NotesUNeed notes and MapNotes will be lost.  You may find that you can still go back and run MetaMap and MapNotes together to import your MapNotes in to MetaMap, BUT you will NOT be able to recover the links to NotesUNeed notes.
However, if you follow this advice, then you should notice no difference in the information being displayed when you start to use MetaMap, and all MapNotes and NotesUNeed tooltips should display as they did before.







Changes in v3.16.1900 from v3.15.1900
-------------------------------------

- Fixed the Auction House display of the NotesUNeed tooltip
(The display of the NotesUNeed tooltip in the Auction House can appear a little 'dislocated' sometimes. i.e. after viewing an item such as a ring, which has also displayed 2 additional tooltips showing currently equipped items.  Unfortunately, there doesn't seem to be much I can do about this at present, as I don't seem to be able to reliably determine when the extra tooltips are visible or not.  Basically, seems to be another quirk in the Blizzard UI that I can't explain. Anyway, I judge it to be a minor glitch, rather than a bug, so have not spent any more time on it. If anyone has a technical solution, let me know by e-mail please. )




Changes in v3.15.1900 from v3.12.1900
-------------------------------------

- Removed MapNotes version validation; No longer supported by original author so not much point. MapNotes is being updated in Cosmos.
This should remove the constant warning about the MapNotes version if using the Cosmos 1.9 compliant version.




Changes in v3.12.1900 from v3.11
--------------------------------

- Fixed the error when mousing over units on the Minimap (should fix other mouseover errors)




Changes in v3.11.1900 from v3.10
--------------------------------

- Fixed the error messages occurring when viewing Guild Members
- Increased the maximum scale of the Frames to 175%

v3.10.1900 released in response to WoW v1.9




Changes in v3.10.1800 from v3.00.1800
-------------------------------------

- Changed the way that the NotesUNeed tooltip is displayed in relation to the GameTooltip
- Alt Click on the Contact Microbutton to re-open the last Contact Note you had open
- Alt Click on the General Microbutton to re-open the last General Note you had open
- Key-binding to re-open the last note you had open, whether it be a Contact Note or a General Note
- In the NotesUNeed Search/Browse frame, Quests that are in your current character's Quest Log are now coloured Green
- In the NotesUNeed Search/Browse frame, Quests that your current character has abandoned are now coloured Red
- Some minor performance improving changes
- Fixed some minor FrameXML errors being reported, but which had no functional impact

(Tip: Don't forget that Shift-Clicking the Contact Microbutton will create a note for your current target without opening the note; A key-binding also exists for this functionality.)




Changes in v3.00.1800 from v2.51.1800
-------------------------------------

New Functionality in v3.00.1800
-------------------------------

The most significant change this version is integration with MapNotes - please see the MapNotes section of the Readme.txt for a detailed explanation. Currently, only tested with v1800.7 of MapNotes stand alone AddOn.
Highlights for ALL new features are as follows :

- Added the ability to generate MapNotes from Generic NotesUNeed Notes
- Added ability to automatically create a MapNote when noting NPCs.
- Added ability to auto MapNote Quest Giver NPCs when Accepting Quests
- Merge up to 5 NotesUNeed notes in one MapNote; new tooltip style frame displays list of all MERGED NotesUNeed Notes; Mouse-over to view individual NotesUNeed tooltips
- Alt-Left Click on a MERGED NotesUNeed map Note to close the WorldMap and Open the Note for editing.
- Alt-Right Click on a MERGED NotesUNeed map Note to delete the reference to that Note from the Map Note ( This does NOT delete the actual NotesUNeed Note OR the MapNote - it only removes the link between the MapNote and the NotesUNeed note so that the NotesUNeed note is no longer listed against this MapNote. )
- Added ability to scale up/down the WorldMap tooltips
- Can now see NotesUNeed tooltips for your character and party members on the WorldMap or Minimap
- Auto Note creation options are now set to "Off" by default to prevent creation of unwanted notes at first install
- Shortcut Hyperlink access by sending a list of the Hyperlinks within a Note to the Chat frame where they can be clicked upon. New button with "[]" symbols in top right cluster of buttons in Note Frame.
- Added a Shift-Alt Click ability to paste Hyperlinks in to Open NotesUNeed notes. If NO NotesUNeed note is open, then Shift-Alt-Clicking will open/create a note just as in earlier versions, but if a NotesUNeed note frame is already open, then the Item link will be pasted in to the text of the open note. If you have both a Generic Note and a Contact style note open at the same time, then by default, the Hyperlink will be pasted in to the Generic note's text.
- NPC Level "??" noted as such, instead of as -1
- Stopped the attempts to Ignore people who are on an Infinite Ignore AddOn list


Bug Fixes in v3.00.1800
-----------------------

- Adjusted the positioning of many of the tooltips
- Fixed a problem when creating a note for a Quest History entry whose associated Quest Note had been deleted
- Fixed a couple of minor error messages that had no functional impact






A Note on Moving between NotesUNeed Versions
--------------------------------------------

When upgrading to a new Version, or downgrading to a previous Version of NotesUNeed, please completely move/delete the NotesUNeed directory, before installing the alternate version. Do NOT simply rely on Overwriting previous files - for example, v1.11.1800 has an extra German localistion file that has not been designed for v2.xx.1800, and you leave it in place at your own risk. Similarly, if you are moving back to any v1.xx.1800 release from a v2.xx.1800 release, then there is a Bindings.xml file pointing to functions that do not exist in the earlier version.
Unzip overwriting one version in to another versions directory may not remove these extra files, which might cause unexpected errors - so please completely remove NotesUNeed from the Game's Addon folder before installing another version.

(btw, if you have created Account level notes in a v2.xx release and want to be able to see them in a v1.xx release you will have to resave them at Realm level. I am not going to guarantee that it is perfectly safe to move back to v1.xx after creating Notes with v2.xx, but I have found no problems so far, and any extra fields should simply be ignored - resaving Notes may result in the loss of some v2.xx fields and data, which you would no longer be able to see if you moved up to v2.xx again.)






Changes in v2.52.1800 from v2.51.1800
-------------------------------------

- Fixed a problem based on Class Trainer Frame not existing






Changes in v2.51.1800 from v2.50.1800
-------------------------------------

- Fixed the Game Freezing Issue on Login
- Fixed a problem with Quest Stage text being added to an existing Quest Note
- Prevented manual creation of a Quest History entry until a Quest Note is manually saved
- Added the name of the Targetted NPC and current location when accepting/handing in Quests





Changes in v2.50.1800 from v2.04.1800
-------------------------------------

- Improved the Searching feature to allow for text searching within filtered note sub-sets. (Including 2 tiered text search - please see Text Searches section of Readme.txt)
- Added Automatic Party Member Note Creation and count of how many times you party with a contact; Plus takes acount of logging on/off, and presence in Raid Groups to avoid repeated counting when joining someone already in your Raid group; Plus, added a button to manually reduce/reset the Party count.
- Changed Text Edit Box behaviour, to allow for movement while edit boxes are up. Controlled by a new CheckBox Option. When Checked, pressing Escape while Editing a note's Text, will lose focus, and allow you to move and interact with WoW, while the notes Edit Frame is Open. Pressing Escape again will close the note. The downside is that all NotesUNeed frames will then work off the same press of the Escape key, and pressing Escape to close a Frame will close both General and Contact note Frames and the Search Frame.)
- When the Merchant Frame is up and you have that merchant targetted, the NPC information gathered will include a list of that Merchants goods for sale and prices.
- Can now Alt-Click on Items in the Auction House to Create/Edit a NotesUNeed note on them (Shift-Alt-Click which is the standard NotesUNeed way of noting items will not work in the Auction Frame, so Alt & Click only, no Shift ) Please ensure you are over the Picture of the item and the Game Tooltip is showing before AltClicking, otherwise, the note created may be for the incorrect item. Please don't report this as a bug ;)
- Added an option to only show a minimised version of the NotesUNeed tooltip when you mouseover a target
- Added a Delete confirmation box. Must press <Enter> or click on confirmation Delete to delete a note. Can click on confirmation Cancel or press <Escape> key to cancel the delete. ( This is not controlled by an option - but I have tried to ensure that you should be able to press Escape/Enter to Cancel/Confirm the Delete; Note that if you shift focus to another Edit Box on screen while the Delete confirmation Frame is visible, then Escape and Enter will be captured by that Edit Box, and will no longer control confirmation/cancellation of note deletion. )
- Addressed an issue which may have been causing the game to freeze/hang on a small number of installations

GERMAN LOCALISATION
-------------------
- Included German Localisation, with Slash command functions to patch Notes saved in the English Version. See the Patching NotesUNeed Language section of the Readme.txt.








Changes in v2.04.1800 from v2.03.1800
-------------------------------------

- Fixed the issue of the Right-Click drop down menu not appearing in the Friend's Frame, when a NotesUNeed Contact note is open.

- ( Internal : standardised ALL function hooking )





Changes in v2.03.1800 from v2.02.1800
-------------------------------------

- Fixed a problem that can cause a corrupted NotesUNeed database when transmitting very large Notes via the Send Note functionality
(Please be aware that as well as the character limit in Text boxes, there also appears to be a WoW limit of 110 new line characters. If a note contains more carriage returns than this limit, then text AFTER this limit will be replaced by "..." on screen. I believe the text you enter is still recorded in WoW, but it is no longer visible. This seems to be a WoW Edit Box limitation, and I can't do anything about it so please don't ask ;)

- Added Version number to Options Frame




Changes in v2.02.1800 from v2.01.1800
-------------------------------------

- Pin Up NotesUNeed Tooltip will still display even when all other NotesUNeed tooltips have been turned off. So Mouse-Over dynamic tooltips will NOT display unless you check the option, but you can still see the pin up tooltip which only shows when the static Game Tooltip shows, or you manually Pin a note's tooltip to the screen.




Changes in v2.01.1800 from v2.00.1800
-------------------------------------

- The Tooltip checkbox/slash command now toggle ALL NotesUNeed tooltips, not just the help tips.
- New slash command and key binding for toggling the display of the Micro buttons  ( /nun -micro )





Changes in v2.00 from v1.08
---------------------------


Please Note every effort has been made to ensure that you will lose no notes or data by upgrading to Version 2 which is fully compatible with the previous version's notes, even with all the extra functionality and the extension to cover new note sub-types. However, I would still strongly advise that you back up your NotesUNeed.lua data file from the Saved Variables directory under your Account name in the WoW game folder, as I can not foresee all possible conflict issues, and if you have problems, your existing NotesUNeed data may be at risk.


New Functionality in v2.00
--------------------------

- Can now create Notes for  TARGETTED NPCs by clicking the Contact Microbutton (or typing    /nun -t   when you have an NPC targetted)

- Can now create Notes for Items by Shift-Alt-Clicking on Items in bags, or the character sheet, or Hyperlinks in the Chat Frame. See the Item Notes section of the Readme file.

- Can now create Notes on Quests in the Quest Log - See the Quests section of the Readme for further information

- New Buttons and Note Tooltips in the Friends, Ignores, Who, both Guild Panels, and the Quest Log Frames.

- NotesUNeed mouseover tooltips for Player Characters, NPCs, and Items.

- Can pin a NotesUNeed Tooltip to the screen so that information from that note is easily available while you play. This static tooltip also appears if you Shift-Click an item in the Chat frame that has a NotesUNeed note.

- Can control the size of the NotesUNeed Tooltip from the Options Frame and control the contents of the NotesUNeed tooltip. See the NotesUNeed Tooltips Section of the Readme file.

- Can now create Player Character Notes by Shift-Alt-Clicking on Player names in the Chat Frame.

- Can now create Player Character Notes from the command line for any character name without validation. See the Command Line and Creating Player Notes sections of the Readme file.

- Set NotesUNeed to automatically record Quest Notes and Quest History for your characters - See the Quest section of the Readme for further information

- Can now change the name of General Notes. ( You will not be allowed to change the name if a note already exists with that name )

- Can now save General Notes at account level to be viewed by your Alts from any server/realm. Set the default save level in the Options

- Can now send your NotesUNeed notes via chat channels to Raid, Party, Guild, Say, Whisper, Self.  A log of the last ten transmissions with a datestamp is kept via a new NotesUNeed Log type note, viewable in the search frame like any other Note. See the Send Notes Section of the Readme for further details.

- Filter your notes by any of the new Note types, Item Notes (ITM),  NPC Notes (NPC), Quest Notes (QST), Logs (LOG), or generic notes without any type. ( Obviously notes from previous versions will fall in to this last category, but it is possible to change a Notes type, and reclassify your existing notes )

- Browse your Quest History, including details of when and where you accepted, completed, and handed them in.

- When creating a note from a targetted Player Character (of your Faction), the Players equipment will be displayed in the new note.

- The NotesUNeed Frames and tooltips can now be scaled and moved.

- Key bindings have been added for toggling the Options screen, and for Capturing a NotesUNeed note for the current target without opening a Note Frame. This can also be achieved by Shift-Clicking the Contact Microbutton while targetting something.

- The Search Frame now displays extra information about notes, including the type; A tick beside a note indicates it has been saved at Account Level. This frame now shows the number of notes being displayed in the header. ( These rules differ slightly when viewing Quest History - see the Quests secion of the Readme )

- The Note editing windows display the number of characters used from the maximum available in the lower right hand corner of the scrolling edit box.

- Shift Click on a note in the Search Frame to output its title to the Chat message box

- Raid Frame Support ( No individual Raid Member buttons, but click on a Raid member in the Raid Frame and then click on the NotesUNeed  Button at the left end of the Friends Frame header to create/edit that player's note. Also, NotesUNeed tooltips will show when Mousing over Raid Members in the Raid Frame, or Over Party member Unit Frames )

- Limited support for Hyperlinks and Coloured Text within notes. See the Hyperlinks in NotesUNeed Notes section of the Readme file.



Modifications to Functionality in v2.00
---------------------------------------

- Only import Contacts to the Friends List that are in the Friends List of at least one Alt.
- The NotesUNeed 'Edit' Button on the FriendsFrame has been moved to a graphical button at the left side of the Frame Header.
- Increased the maximum possible size of notes to 5056. ( This does NOT increase the size of ALL notes, or mean you are using more memory, unless you FILL the note )










Changes in v1.08 from v1.07
---------------------------

- Fixed a problem with the Text search functionality beyond the 1012th character
- Fixed a small graphical glitch in the Edit Details Box in the Contact Note





Changes in v1.07 from v1.06
---------------------------

- Fixed the Self-Targetting Issue
- Fixed the Levelling message to report the new Level, not the Old ( Caused by changes in WoW Patch 1.8 ? )
- Fixed the Options Reset functionality to correctly set the Default options and refresh the Options Frame view




Changes in v1.06 from v1.05
---------------------------

- Fixed the error message that appears on levelling.




Changes in v1.05 from v1.04
---------------------------

- Very minor '.toc' file update for compatibility with WoW patch 1.8




Changes in v1.04 from v1.03
---------------------------

- Very minor change to make the default position for the Microbuttons near the Top Center of the screen. The default position now has no relationship with any other frame.




Changes in v1.03 from v1.02
---------------------------

- Note that installation of this version to replace an older version will NOT result in any loss of existing notes or data
- Fixed the problem of Text being truncated to 1012 characters by the WoW Saved Variables limit. Up to 4048 characters can now be entered and saved
- Stopped self targetting when exiting own note via Microbutton press
- Minor changes to make the hiding and showing of frames more consistent



Changes in v1.02 from v1.01
---------------------------

- Fixed the error being reported when logging in to a character in different Realms



Changes in v1.01 from v1.0
--------------------------

- Very minor change to display a border around the Microbuttons when the mouse pointer is over the frame. Hopefully should clear up any issues new users have with moving the panel, as it is the border which needs to be clicked to move the buttons, and this border was not previously visible.







General Description
-------------------

Searchable, feature rich Notes database allowing the player to keep notes on Friends, Ignores, Guild Mates, any player you party with or target, or any player at all, whether they belong to your Faction or the Opposing Faction; Or notes on NPCs, Items, Quests, or just General notes on any subject.
Share your Friends List between your Alts, and/or keep track of your Characters' Quest Histories.
A Very useful Search feature allowing the player to browse all notes, or search for Class, Profession, General notes, particular types of notes, or for any Free Text phrase !  So if you can't remember who it was who needed that Pristine Black Diamond, just search for Diamond and you will find the contact :)  Or if you are a Guild Master, now you can list all those members who are Enchanters that have +15 agility chant, or track which characters are alts of which members. Notes can be automatically maintained on Friends and Ignores and shared amongst your alts, allowing you to import your friends list to your brand new alt :)  A note for the character you play is also automatically generated, and keeps track of when and where you level up :)
Moveable, Scaleable Frames; As well as mouseover tooltips, pin up tooltips, key-bindings, and Shift-Alt-Click note creation.

The default position for the Microbuttons is near the Top Center of the screen.

PLEASE NOTE that you can't drag the Microbuttons if you have actually clicked on one of the buttons - they need to be dragged by the edge. There is a small transparent border surrounding the buttons and you need to click this to drag the frame, not the buttons themselves.


Key Features
------------

- New NotesUNeed Button on the Friend, Who, Ignore, Guild, and Quest frames allowing the creation/editing of a note

- A new movable and discrete panel of 4 buttons allowing immediate access via the mouse to the
        1. NotesUNeed Options
        2. Browse all notes
        3. Create/Edit Contact Note, depending on who you have targetted
        4. Create new General Note

- Create or Edit notes via Slash Commands

- Browse All notes, or Search by Class, Profession, Note Types such as Item/NPC/Quest, or search for any free text. Searches can be initiated from the NotesUNeed Options frame.

- When browsing, notes are sorted by your current player's Faction, then the opposing Faction, then General notes. Symbols clearly display whether a note is an Alliance Contact, a Horde Contact, or a General note, even detailing what kind of note and whether it is saved at Realm or Account level. Player Notes are kept at the Realm level and all are accessable by any alt of either faction on that Realm. Other notes can be kept at the Realm or Account level.

- Drop down boxes on the NotesUNeed Contact note frame reduce the amount of typing, when entering Class, Profession, Rank, etc. NotesUNeed will also try to automatically fill in as much information as possible for Contacts that are online, noting Race, Class, Sex, PvP Rank, Guild and Guild Rank ( Distance from target will reduce the amount of inormation that can be gathered )

- Use the "Target Info" and "Who Info" buttons to manually request a refresh of Race, Class, Sex, PvP Rank, Guild and Guild Rank. Again, this functionality is restricted by the underlying WoW functionality, and distance to target will reduce the amount of information. Target information includes all equipment.

- Allow NotesUNeed to automatically maintain notes on Friends and Ignores, and then use the NotesUNeed database to import Friends and Ignores to other alts.

- Allow NotesUNeed to automatically delete notes when Friends/Ignores are removed. ( Contact Notes will only be auto-deleted when that player is no longer a Friend/Ignore of ANY of your alts, AND the note was created automatically by NotesUNeed; So any note you manually Save will never be deleted automatically, as it is assumed that you will have saved that note for a different reason than simply tracking Friends/Ignores )

- Default headings exist in the Contact Note frame for Guild, Guild Rank, Real Name, e-mail, and Web address. However, these are user definable headings, and you can change these to be phone number rather than web address for example, or whatever you feel is more suitable for your needs; The Default headings can be changed for all your Contact notes, or you can change the headings for an individual Note if need be.  Please note that if you change the Guild and Guild Rank headings then the underlying details will NOT be automatically filled in by NotesUNeed.

- NotesUNeed will automatically generate a note for your character and will automatically record when and where you level up

- Allow NotesUNeed to automatically maintain Notes on Quests and Quest History for your Alts

- View mouseover tooltips containg NotesUNeed note details, and control what and how much is displayed.

- Add Timestamps and Location to notes (Location is always YOUR location.)

- See also New Functionality in the Version 2 notes above



Slash Commands
--------------

/nun   : Toggles the NotesUNeed Options window

/nun -h   : Displays this list of Slash commands

/nun <note title>   : Will attempt the following :
  1. Fetch a saved Contact note with that name
  2. Fetch a saved General note with that title
  3. Create a new Contact note if a player of that name is in your party/raid group or is within target range
  4. Toggles the NotesUNeed Options window

/nun -t	  : Fetches the saved Contact note for the current target, or creates a new one, or shows your own characters note if no valid target. Since v2.00.1800, this command will create notes for NPCs and populate some basic information about them.

/nun -g	  : Creates a new General Note, untitled.

/nun -g <note title>	: Fetches the existing General note with that title, or Creates a new General note with that title.

/nun -ch <name>		: Create a Horde Player Character note for the given name without validating it
/nun -ca <name>		: Create an Alliance Player Character note for the given name without validating it

/nun -tt	: Toggle NotesUNeed Tooltips on/off

/nun -micro	: Toggle the NotesUNeed Microbuttons panel hide/show






Text Searches
-------------
The Text search box is now visible in the Search Frame when filtering by most types of Notes, not just when specifically searching for Text. This means that after filtering for Quest Notes for example, you can then search for the phrase "Scorpid Sting" and NotesUNeed will search for that Text only in the Quest Notes you previously specified.

I have chosen not to blank the text search box on entry/exit, as it allows you to repeat the search without having to retype the text, and will not restrict your search results when filtering notes until after you click on the Search Button. The one exception to this rule is when you have specifically requested a text search from the Options Drop down, and not blanking the text box allows for the possibility of a 2 tiered text search as follows:
i.e. It is possible to search for 2 text words or phrases in the NotesUNeed notes, for example you might wish to view only notes containing the phrase "Big Sword", and then search among those notes for the word "Light". (Sorry that this isn't an obvious solution ;) First you must open up the Search Frame by clicking on the Browse All Microbutton, and entering some text in the Search Text Box (You don't have to Click on Search, or press <Enter>, just put the first text word/phrase you are searching for in the box). Next, open up the NotesUNeed Options Frame (the Search Frame will close automatically) and select Text from the Search For Drop Down selection box, and click on Search. NotesUNeed will filter All your notes based on the text you entered in the first Search Text box and list them for you.  Now you can enter a completely new word/phrase in the Search Text box, and NotesUNeed will only search amongst those Notes already returned after the first search.




Patching NotesUNeed Language
----------------------------

During Localisation, the order of the drop down boxes has been resequenced to be aplphabetically sorted based on the German translations. If you have been using an English only NotesUNeed v2.00.1800 to v2.04.1800 ( or any version 1 before v1.09.1800 ) on a German Client, then your Contact notes will have stored Class, Race, Professions, and PvP Ranks in a certain way; If you are now upgrading to v2.50.1800 with German Localistion, this data may display incorrectly in the Drop Down boxes in the Contact Notes for Horde and Alliance players. To fix this, you can use the following special Slash command, which will Patch ALL your NotesUNeed Player Notes. e.g. this should make sure that when you saved a player note as a "Rogue" on the English version, they will display properly as a "Schurke" in the German Localised Version.

/nun ->DE


If you need to move back to the English only version for any reason, I have also provided the following command to undo the patch and allow your data to display correctly again in a previous version without localisation :

/nun ->EN






Quests
------

NotesUNeed Quest Notes and Quest History

It is important to be clear that NotesUNeed keeps notes on Quests separate from a Player's Quest History.
A Quest Note is a normal NotesUNeed note detailing the Quest's name, description, objectives and rewards.
The Quest History recorded by NotesUNeed is not a normal NotesUNeed note, but simply a list of Quests with the associated location and time when they were accepted, completed, and handed in.

- new buttons allow notes to be made on the Quests in the Quest Log, similar in functionality to how the Friends Frame buttons work.

- a new option is available to allow NotesUNeed to automatically record a Quest Note whenever your Quest Log is updated, and also keep track of your characters' Quest History

- new search Options are available in the Options Frame to filter notes by type, including Quest Notes, or Quest History

- Quest Notes are notes like any other but with a type of "QST" allowing them to be filtered and examined separately

- It is also possible to Filter/Search by Quest History, but these are not NotesUNeed notes. When filtering by Quest History, you are simply viewing a list of the Quests you have had in your Quest Log. The Tooltip will no longer display the Quest Note tooltip, but will display the details of when and where you were when you Accepted, Completed, and Handed In the Quest. A tick beside the Quest name will indicate that that Quest has been Completed and Handed In and is no longer in your Quest Log. If you have the details of the Quest stored in a Quest Note, then a little note symbol will appear beside the entry, and clicking on the Quest will show the Quest Note. However, if you do not have a Quest Note for that particular quest (because you have deleted it), then no symbol appears beside the Quest name, and clicking on it will show a blank Quest Note.

- It is important to note that if you are Searching Quest History, and you raise the corresponding Quest Note, then clicking on Delete in the Note editing frame will no longer Delete the Quest Note, but will instead Delete the entry in your Quest History. To delete the Quest Note you would have to close the Quest History Search Frame, Search seperately for that Quest Note, and then delete the Note itself.

- Quest History entries are ONLY displayed when you choose to Filter specifcially for Quest History from the Options Frame. If you search for All, or Notes, or Quest Notes, you will NOT see any Quest History Entries - only actual Notes.

- The Quest Accepted Location and Datestamp will not necessarily  be accurate. For example, when you first install the mod, or when you first check the option to automatically record Quest Notes and History, then NotesUNeed will update your quest history on the next Quest Log Update, and all your current quests will be noted as accepted at that time and in that place. Similarly, abandoning a quest and accepting it again later will not update the accepted location or date unless you take the trouble to delete the Quest History entry for that quest after abandoning it.

- Due to some inconsistancies in the WoW treatment of Quest completion, it is not always possible for NotesUNeed to detect when a Quest is complete, or even handed in.

- The Quest History search will display the level of you character when that history entry was created. The level detailed within the Quest Note is the appropriate recommended difficulty level associated with that quest, not an individual player level.

- Quest History is sorted to show the most recently accepted Quests first

- Where a Quest has multiple stages under the same Quest name, and you have Auto-noting of Quests turned on, then NotesUNeed will try to append the details of the next stage of the Quest to the existing Quest note. Again, the WoW API does not always send notifcaion of stage completion, and details can not always be updated. Note that where you play through quest stages out of sequence by playing the same quest with different Alts at the same time, then the text in the note may also be listed out of sequence.

- Turning auto-noting of Quest Logs and History, off and on, while continuing to make progress in those quests may result in strange looking data, especially where quests being logged have multiple stages.




NotesUNeed Tooltips
-------------------

The contents of the NotesUNeed tooltips can be controlled in 2 different ways :

1.) Change a user-definable Heading in the Player Character Note to contain the word 'Tooltip' (not case-sensitive), and the corresponding Detail will be displayed in that Notes Tooltip.

2.) By default, the notes text will be displayed in the tooltip; But this can be restricted by using the tags  "TT::"  and  "::"  to start and end the text you wish displayed.
e.g. from the following :-     "Text I don't need to see in a tooltip TT::Useful Information:: followed by more unimportant text"         only "Useful Information" will show in the tooltip.




Send Notes via Channels
-----------------------

For the Player Character style notes, the information displayed in the drop down boxes and user definable buttons comes from the SAVED details of the note. If you show a note, change their Profession without Saving, then send the note, the profession actually sent will not be the one you just specified, but the one still saved.
However, during development I found that it was much more useful to be able to change the free text in the Edit Scroll boxes of both the Contact and General style notes, and send it without having to save the note first. I believe this could be more useful in the live version also, as you may wish to edit or censor certain details of a notes free text before you send it, without actually saving your changes.

The formatting of the text as it is being sent means that each line is prefixed with message key information, I did this to allow for the future possibility of sending a note to another NotesUNeed user, and allowing them to create a note from those details in their NotesUNeed database.

See also the Hyperlinks in NotesUNeed Notes section of the Readme file.




Creating Player Notes
---------------------

A player note can be created for any name without NotesUNeed validating the player name using the following commands :
/nun -ch <name>   for a Horde character note
/nun -ca <name>   for an Alliance character note

(the original    /nun -g <notename>    still exists for creating General Notes - it is recommended that for creating NPC notes you first target the NPC and use the    /nun -t    command or the Contact Microbutton to create NPC notes, as this will populate the note with some basic information about the NPC including your location )





Item Notes
----------

As well as creating notes from items in your own character sheet by Shift-Alt-Clicking on them, it is possible to create notes on items equipped by other people when the inspect frame is visible. For various reasons, the way to do this is not very intuitive, and you must Shift-Alt-Click the corresponding slot in your character sheet while the Inspect Frame is open.  i.e. to note the fantastic Staff that mage has equipped, you must have your character sheet up, as well as the Inspect frame for the mage. Now whey you Shift-Alt-Click on your equipped weapon slot, a note will be created for the inspected targets weapons slot. When the Inpsect frame is not visible, then you will create a note for your own equipped weapon.

When you create notes on items by Shift-Alt-Clicking on items in bags, character sheets, or Hyperlinks in the chat frame, then the note title is the Hyperlink for that Item. i.e. the coloured item name surrounded by square brackets.  However, to access the note from the command line you do not have to enter "/nun <Hyperlink>".
For example, if you have a note for the purple epic [High Warlord's Battle Axe], then you can access it from the command line by simply typing "/nun High Warlord's Battle Axe".




Hyperlinks in NotesUNeed Notes
------------------------------

Coloured text must be stripped of its colour before transmission via the Chat Channels, but coloured Hyperlinks CAN still be sent - NotesUNeed automatically "bleaches" text before transmission, but will leave Hyperlinks intact.

Unfortunately it is not possible to click on Hyperlinks in NotesUNeed notes. However, you can still access them via the Send Notes via Chat Channels functionality.
This is the main reason for including a Send to Self option.  If you are interested in a particular Hyperlinked Item's details in one of your notes, you can click on the Chat symbol in the upper right hand corner of the Note frame, choose the Option to send the Note to Self, and click on Transmit. The notes details will now be sent to your Default Chat Frame, where you will now be able to click on the Hyperlink as normal, or Shift-Alt-Click it to create a NotesUNeed note for that individual item containing all its details.



MapNotes
--------

I have integrated with the MapNotes standalone mod.
Versions of MapNotes that NotesUNeed has been tested with so far :
	1800.7


I check for the presence of the MapNotes_OnLoad function as evidence that MapNotes is installed.
I also check the version of MapNotes installed, and if it is not a version with which I have tested, then you get a popup box when you log in,  saying  "CAUTION: NotesUNeed not tested with the installed version of MapNotes" - this popup box should only appear once, and should NOT continue to appear every time you log in with those versions of NotesUNeed and MapNotes. Currently, I have only tested with v1800.7, but I will try to keep an eye out for future MapNotes releases, and try to keep NotesUNeed in sync with it.

The basic changes are that you can now create MapNotes from NotesUNeed, and when you hover over a MapNote icon whose Main line is equivalent to a NotesUNeed note title, then you will also see the NotesUNeed tooltip for that MapNote. This means that it will be possible to see the NotesUNeed tooltip for MapNotes that have already been created, as long as their name is the same as a NotesUNeed note.

I have used similar logic to that used by the MapNotesTarget AddOn, which can be used to create MapNotes for targetted NPCs. So, friendly NPCs create Green MapNotes, neutrals create Yellow, and enemy NPCs create Red MapNotes.  I have gone further, however, and you can create a MapNote from any Generic NotesUNeed note - default colour is green.

Also, if you are Auto-Noting quests, and have the flag to Auto-MapNote NPCs, then NotesUNeed will create a purple cross MapNote when ever you accept a new quest. ( I chose to implement similar logic to MapNotesTarget myself, rather than make NotesUNeed dependant upon it, mainly because, MapNotesTarget also adds profession/level to the MapNote name, which then breaks the link to the NotesUNeed notes, and stops the NotesUNeed tooltip displaying. Plus, I have also extended the functionality, so..... )

From a MapNotes point of view, the note Merging is basically the same as that found in the MapNotesTarget AddOn. MapNotes will reply with a warning if you are too close to an existing MapNote to create a new one for the NPC.  In that case, MapNotesTarget allows you to merge the NPC MapNote with the existing one, so if you had a note called  "NOTE1", and you were trying to create a new note for an NPC called "NOTE2", but were very close to "NOTE1", then you could choose to merge them and the MapNote would then be called  "NOTE1 | NOTE2".     Basically, I have done a similar thing with regard to the MapNote information with a couple of differences :

1.) I just merge notes automatically when you are too close to an existing one; Up to a maximum of 5 NotesUNeed notes can be merged/added to an existing MapNote. After 5 NotesUNeed merges, then you will just have to move a little bit away from the current MapNote to create a new one.

2.) I have added another tooltip window which will list the NotesUNeed notes that have been merged in one MapNote. To see the NotesUNeed tooltip for the individual notes, you need to move your cursor over this list of buttons.


MapNotes : PLEASE NOTE : MapNotes are basically stored at Account Level, while it is possible to create NotesUNeed notes at Realm, or Account level.  It is also possible to create MapNotes from NotesUNeed notes saved at either level; However, if you have a NotesUNeed note saved at Realm level, create a MapNote from it, then change Realms, you will not be able to see the associated NotesUNeed note tooltip.  In order to see NotesUNeed tooltips on any realm, you must save the NotesUNeed note at Account level.  So if you believe that a NotesUNeed tooltip is not being displayed when it should be, please check at what level it is saved, and which Realm you are currently on :)







Notes & Troubleshooting
-----------------------

1. Many of the NotesUNeed frames and the Pinned tooltip are now moveable and scaleable in Version 2. This means that they can disappear off screen when you increase their Scale, or the UI Scale from the WoW Video Options panel (or from the Titan panel).  If you are clicking on a button but the frame, or tooltip does not appear to be responding, try to reduce the NotesUNeed Frame/Tooltip scales, and/or the UI Scale temporarily (preferably as low as you can go), and see if the frame/tooltip now responds/appears.Once you have located the frame, move it towards the top left of the screen, and restore your UI scale to where you need it. If all else fails try resetting the NotesUNeed Options to their defaults, and then exiting WoW, entering the world without the NotesUNeed Addon loaded (preferably temporarily remove the NotesUNeed folder from the Addons folder completely while you log on),  then restore the NotesUNeed mod folder, and log on again. Hopefully, this should restore your NotesUNeed frames to their original position. The last resort after this is to edit/delete the "layout-cache.txt" file in the WoW\WTF\Account\<Account Name>\<Character Name> folder, and restart the game.

2. The "Who Info" button needs to be clicked at least twice to refresh the Race and Class on the Contact note window. This seems to be due to the way the /who command works in WoW and the amount of time needed to refresh the who list. Again, if enough people say it is a big problem, I might look at trying to ensure only 1 click of "Who Info" is required, but this can only fetch Race and Class, and I didn't think clicking the button until the data refreshes was too big a problem. Note that as with the "Target Info" button, the player needs to be on line to gather any useful data. Also, just like the normal /who command, there is a period of time after clicking the "Who Info" button a couple of times for one character, before it will respond again for another character. I can't do anything about the delay between /who commands as this is a characteristic of the WoW API, just try typing /who <character name> multiple times to see what I mean.

3. When importing players in to your Ignore list from the NotesUNeed database, note that a character needs to be on line to be succesfully ignored. This is a restriction of the WoW API.  Every time you log on, NotesUNeed will make another attempt to ignore any Contacts which it failed to ignore previously, but it will only attempt this once, as periodic background attempts to ignore these players would only generate puzzling "Player not found" messages in the chat window.








Contact for Feedback & Bug Reports
----------------------------------

telic@hotmail.co.uk



