--[[

  TradesBar for WoW (World of Warcraft)
    Desc:  A row of buttons for your Trades Skills

  LIST OF AUTHORS and FIXERS
  Author 1:  CRiSPyToWN  "Iling on Skywall(Nightelf)"
  German Tanslator1: Farook of wowinterface.com forum
  German Tanslator2: Vivalos of wowinterface.com forum
  French Tanslator1: Trucifix of ui.worldofwar.net
  French Tanslator2: obockstal of ui.worldofwar.net

  VERSION HISTORY
  1.90b: Author 1
   ~Removed the message that appears in realm change and loadup
   ~Fixed for version WoW Patch 1.11

  1.90b: Author 1
   ~Fixed bug with hard coded id number for the id number of fishing.  This
    should not have been because different people have different ID for their
    spells
   
  1.85b: Author 1
   ~Fixed local for German and French.
   ~Added in support for FishingBuddy. (It is not required!!!)
  
  1.80b: Author 1
   ~Added in feature to Hide/Unhide bar when in and out of combat.
  
  1.70b: Author 1
   ~Find Treasure skill.
   ~Fix Hide/Unhide Bar Issue for mount/unmount and possibly when you switch
    zones.
   ~Fixed local for Engineering in French.
   ~Fixed local for the feature that speciality trades override the default
    trade for French and German. It already worked fine for English peeps.
   ~Added binding for all major trades and skills. I didn't add in Speciality
    trades because when you open the normal window it is the same as if you
    opened the speciality window.
   ~Cleaned up code so it now loads under 0.030 seconds on average.
   
  1.65b: Author 1
   ~Fixed version number for 1.10 series

  1.60b: Author 1
   ~Fixed German support for Pick Pocket -Thanks Farook
   ~Fixed French support for Smelting and Skinning -Thanks Trucifix
   ~Fixed new config window to load saved settings

  1.50b: Author 1
   ~Addedin French Support -Thanks to Trucifix
   ~New config window
   ~Added in the ability to enable/disable a button of choice   

  1.40b: Author 1
   ~Fix Lockpicking
   ~Added Pick Pocket (needs tranlation to german)
   
  1.35b: Author 1
   ~Finished adding in support for German -Thanks to Farook

  1.30b: Author 1
   ~Added in
     Basic Campfire
     Lockpicking
   ~Added in some support for German -Thanks to Farook
   ~Started to add Key Binding Support to this add-on
     Open Config
     Hide/Unhide TradesBar bar
     
  1.20b: Author 1
   ~Fixed it so that the specialty trade will overpower the normal button for that trade
   ~Fixed the code that echoed out the location of the bar in the chat window
   ~Added in Hide/unhide of window
   ~Added in support to change the order of the button from alphabetically A-Z to alphabetically Z-A
   ~Added in "Find Minerals" and "Find Herbs" and "Disenchant"
   
  1.10b: Author 1
   ~Added in  
     Smelting
     Gnome Engineering 
     Goblin Engineering 
     Dragonscale Leatherworking 
     Elemental Leatherworking 
     Tribal Leatherworking 
     Shadoweave Tailoring
     Poisons (because it was asked for)
   ~Fixed a few minor bugs
   
  1.00b: Author 1
   ~Has the basic functionality
   


1. To install copy the folder TradesBar and place this in your World of warcraft interface addons folder.

   EXAMPLE:
    C:\..\World of Warcraft\Interface\AddOns\TradesBar

2. Start WoW and Enjoy the extra buttons and the ones that were freed :-Þ


NOTES:
------

1. Move the box by Ctrl + right click and drag
2. commands...
   /tradesbar help
   /tradesbar config
3. FishingBuddy Support. (Not Required Add-on!!!)   



List of Trades Supported (not in this order)
------------------------

1.  Alchemy
2.  Blacksmithing
3.  Cooking
4.  Enchanting
5.  Engineering
6.  First Aid
7.  Fishing
8.  Herbalism
9.  Leatherworking
10. Skinning
11. Tailoring
12. Smelting
13. Gnome Engineering 
14. Goblin Engineering 
15. Dragonscale Leatherworking 
16. Elemental Leatherworking 
17. Tribal Leatherworking 
18. Shadoweave Tailoring
19. Poisons (because it was asked for)
20. Find Minerals
21. Find Herbs
22. Disenchant
23. Lockpicking
24. Basic Campfire
25. Find Treasure




SPECIAL THANKS
--------------

   1. Murkeli

          * Author of 'TrackBar'
          * I learned alot from reading your code. :-)

   2. Permetheus

          * Author of 'AspectBar' and 'TrapBar' for the idea.
          * I learned alot from reading your code. TY so much for those great mods/addons :-)

   3. Eebok on 'Skywall' for all the support
   4. Farook for being the first person to help with translations... IE: to German
   5. Trucifix for helping with translations... IE: to French
   6. and to all the Peeps that might find this mod of some use :-)


ENJOY ALL!!!

]]--
