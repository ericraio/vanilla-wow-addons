
PartySpotter v2.52.11200 - Telic of Dragonblight (EU)
----------------------------------------------------

Small, standalone Modification that highlights which people on the WorldMap are in your Party, and which are in your Raid Group.

To take full advantage of this AddOn's features, don't forget to use the provided Key bindings to cycle through the main modes :)

Can highight different raid groups, friends, ignores, guild members, the raid leader, or any individual player you specify, as long as they are in the same party/raid, or in the same BattleGround.

Developed mainly because in BattleGrounds, EVERYONE is represented with the same default Yellow Icon, and you can't tell who you are grouped with easily.

Localisation : German, French.





Basic Features
--------------

With this AddOn installed, then when the WorldMap is displayed, PartySpotter will update it every second (definable by the user) :

- If you are in a Party, party members are highlighted with a Blue Icon

- If you are in a Raid, then people in your party/sub-group are still highlighed with a Blue Icon, and other Raid members are highlighted with an Orange Icon

- People not in your Party / Raid Group are still highlighted with the default Yellow Icon

- Party Member Icons will always be displayed on top of other player icons. e.g. When in a Raid, then the Icons displaying Party members (i.e. members of your Raid sub-group) are ALWAYS displayed on Top, and should always be visible




-------------------------------------
ADVANCED Features Added in v2.00.1800
-------------------------------------

Hopefully, version 2 should work with ALL clients.

Note: where ever I say "Map Key", you can substitute "Map Legend" if you are more familiar with that terminology ;)



- Can now show each sub-group in a Raid as a different colour  (/pspot showgroups icons)  { See the "What Colour Group am I in?" section of the PartySpotter Readme.txt file }

- OR can show each sub-group in a Raid as a numbered icon, showing exactly which sub-group it belongs to   (/pspot showgroups numbers)

- Or turn off sub-group highlights and use simple version 1 functionality to highlight your Party with Blue, and all other Raid members with Orange (/pspot showgroups off)

- PartySpotter Icons now show on BattleField MiniMap

- PartySpotter Icons now show on AlphaMap         : For full compatibility, AlphaMap must be updated to "AlphaMap (Fan's Update)" which I have released as an unofficial update with full disclaimer and apology to original author Jeremy Walsh.  I have only released this version because AlphaMap no longer seems to be supported by the original author, and full credit should go to them.  The version I have released has NO dependancy on PartySpotter, and can be used instead of the original AlphaMap without PartySpotter installed. You will still need PartySpotter to see different unit icons - See the AlphaMap section of the PartySpotter Readme.txt file for more details.

PartySpotter does have limited support for original Alphamap (but must be in a Party/Raid before you will see any unit icons within BattleGrounds.)


- Added a PartySpotter Map Key visible on the WorldMap or AlphaMap when in a Raid, showing which icons/colours represent which Raid Groups. This key is only visible when you have decided to represent each Raid sub-group with a different coloured/numbered icon.

- Click on a particular Raid Group on the PartySpotter Map Key to highlight that Group on the WorldMap/AlphaMap and make sure it becomes visible if it was previously obscured by other player icons. Click on the same group again to stop highlighting a particular group.

- The PartySpotter Map Key is draggable, and will remember where you last positioned it. (The WorldMap and AlphaMap map keys are independant of each other.)

- Added Command line functions to highlight special units. Options are as follows :
1.) /pspot showfriends   to TOGGLE the highlighting of Friends with a     Green icon with exclamation mark !

2.) /pspot showignores   to TOGGLE the highlighting of Ignores with a     Red   icon with exclamation mark !	(Compatible with InfiniteIgnore)

3.) /pspot showguild     to TOGGLE the highlighting of Guild mates with a Blue  icon with exclamation mark !


- Added key binding to cycle through the main PartySpotter modes
1.) Show Coloured Raid sub-groups
2.) Show Numbered Raid sub-groups
3.) Don't show Raid sub-groups

- Added key binding to cycle through the PartySpotter highlighting functions
1.) Friends
2.) Ignores
3.) Guild mates
4.) No Highlighting

- Highlights of Friends/Ignores/Guild should take priority over other icons, so if you can't find a particular unit/group, make sure you disable Friend/Ignore/Guild highlighting


--------------------------------------
ADVANCED Features Added in v2.50.11000
--------------------------------------

- Can now highlight the Raid Leader when you are in a Raid   "/pspot -l" toggles this function
- Can now highlight an individual player, so that you no longer have to mouse over lots of units to find a single unit    "/pspot -t <name>"



Should be compatible with ALL Clients ( although not tested yet, so this is an educated guess ;)
Please e-mail me if you find this AddOn is or is not compatible with a certain client.

Welcome any and all help with localisation of the few English words used :)

( This AddOn only needs to be installed on your machine to work and display other party members/raid members correctly.  i.e. it does NOT need to be installed on other member's machines for you to see them with a different coloured icon. Obviously, they can install it as well, and they will then see you displayed with a different colour ;)





Slash Commands
--------------

/pspot        : Displays the status of PartySpotter, and this list of Commands

/pspot 0      : Disable PartySpotter  (i.e. /pspot followed by a zero)

/pspot <1 - 9>  : Enable PartySpotter and set the delay between WorldMap Updates in seconds. (It is possible to use a decimal point and set this vaue to 0.5, or 3.6 for example)  Default value at install is 1.

/pspot showgroups icons : If in a Raid, then people in different sub-groups will be represented by different coloured icons

/pspot showgroups numbers : If in a Raid, then people in different sub-groups will be represented by icons clearly marked with their group number

/pspot showgroups off : If in a Raid, then people in different sub-groups will be represented by the same Orange icon. Your local Party/group members are still highlighted differently as Blue

/pspot showfriends : to TOGGLE the highlighting of Friends

/pspot showignores : to TOGGLE the highlighting of Ignores

/pspot showguild   : to TOGGLE the highlighting of Guild mates

/pspot -l 	   : to TOGGLE the highlighting of your Raid leader (Marked by a Red "1")

/pspot -t <name>   : will highlight the specified individual, so that you don't have to mouse over lots of icons to find one single person (Marked by a Red "X")

/pspot -t	   : leaving the name blank, will cancel the highlighting of any individual player

/pspot reset : reset all defaults, and anchor the map keys to the default map positions




What Colour Group Am I In ?
---------------------------

Whether you are in a Party, or Raid, your local Party/Group Members are ALWAYS displayed with a Blue Icon.

If you are moved to a different sub-group within the Raid, then that group becomes represented by the Blue Icon, and the colour of the other sub-groups is shifted to accommodate this.  The PartySpotter Map Key will always show which Raid sub-group your local blue icons belong to, and which of the other sub-groups are represented by which other icons.

I have not included the ability to change the default colours of Icons. If you feel strongly that this would be useful, then e-mail at the contact address below :)  The more e-mail requests I get the more strongly I'll consider adding the feature.




AlphaMap (Fan's Update)
-----------------------

Again, apologies to the original author (Jeremy Walsh), if I am stepping on his toes :(

All I have done is bring AlphaMap back in to line with the current version of the WorldMapFrame.
It is in no way dependant on PartySpotter to work correctly, and PartySpotter is in no way dependant on ANY version of AlphaMap.
There is NO PartySpotter specific code in my release of AlphaMap, and I am 99% certain that if the original author releases his own up to date version, then PartySpotter will work with that release, and people can forget about my "Fan's Update" ;)
Here are the updates I have added to AlphaMap :

1.)  All team mates of your faction are now visible in BattleGrounds, whether or not they
are in your Party/Raid  ( This is NOT PartySpotter functionality - just the default Icons )

2.)  Improved the Units Tooltips code, to display a list of player names under the mouse
as per the tooltips on other maps. Instead of just a single player name.

3.)  Added BattleGround Flag/Objective statuses

4.)  As a consequence of the above - has full support for the PartySpotter AddOn


Please Note : PartySpotter will still work with the original AlphaMap, but you will only see people in your Party/Raid, as the original AlphaMap does not display BattleGround team mates that are not in your Party/Raid groups.






Change History
--------------

Changes in v2.52.11200 from v2.52.11100
---------------------------------------

- Simply a .toc update



Changes in v2.52.11100 from v2.52.11000
---------------------------------------

- simply a toc update


Changes in v2.52.11000 from v2.51.11000
---------------------------------------

- "/pspot reset" now stops the highlighting of Raid Leaders and any individually highlighted player


Changes in v2.51.11000 from v2.50.11000
---------------------------------------

- Completed French Localisation


Changes in v2.50.11000 from v2.10.1900
--------------------------------------

- added a new "/pspot -l" command allowing the Raid leader to be highlighted
- added a new "/pspot -t <Player Name>" command allowing an individual player to be highlighted
- updated for the WoW 1.10 patch
- fixed a bug that prevented group/party icons displaying when players are in different map zones


Changes in v2.10.1900 from v2.03.1900
-------------------------------------

- added a "/pspot reset" command to restore defaults and anchor map legends to default map locations
- fixed a memory leak issue which should improve performance


Changes in v2.03.1800
---------------------

- Version 2.01.1800 with French Localisation added.


Changes in v2.02.1800
---------------------

- Version 2.01.1800 with German Localisation added.


Changes in v2.01.1800
---------------------

- Fixed a problem when re-logging while already in a Raid group
- Prevented the display of the AlphaMap map-key when AlphaMap AddOn is not present


Changes in v2.00.1800
---------------------

- See Advanced Features section above for all changes made for Version 2


Changes in v1.01.1800 from v1.00.1800
-------------------------------------

- German Localisation of version 1.00




Contact
-------

telic@hotmail.co.uk