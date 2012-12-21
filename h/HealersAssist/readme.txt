  Healers Assist by Kiki - European Cho'gall


/* ********************************************** 
**  Features :
********************************************** */
  The addon is splitted in two main parts : Healers View, and Emergency View
    - Healers view (only shows healers in your group/raid AND in the same channel) :
      - You can configure how many healers you want to see in the list (from 1 to 16)
        -> You can collapse the whole list with a small checkbox above the list (collapse = 1 healer in the list)
      - Current mana bar in blue
      - Cooldown of some spells (Divine intervention, Divine Shield, Innervate, Rebirth, Lightwell, Reincarnation)
      - Healer that received one of the previous cooldown spells blinking in red
      - Current spell the healer is casting with progression bar, and an estimation of the incoming heal value (computed using +heal bonuses, talents, and blessing of light)
      - Current target for spell with health bar in green
        -> Name of the target will scale from white to red, depending on how much your spell will overheal (red=100% overheal, white=0%)
      - Short name of the spell, or spell failed reason if the cast failed
      - When a spell cast completed, the healed value is shown (with a "C:" if the spell has crit)
    - Emergency view (almost like CTRaid emergency monitor)
      - You can configure how many targets you want to see in the list (from 0 to 6) -> Set it to 0 to fully hide the emergency list
      - Targets that need to be healed, with name class-colored, and health bar in green (with missing HP or current health% if target out-of-raid or NPC)
        -> Target name is shown in blue, if you are currently casting a spell on him
      - Count of healers currently casting on this target
      - Estimated incoming heal value (summ of all estimated heal on this target)
      - Possibility to filter by groups and/or classes (configured in the options)
      - You can clic a target to select it, or if you have CastParty installed, it will use Castparty buttons modifier

  There are two sorting modes for the healers view, but you are always the first in the list :
    - By casting order
      1) First are healers with the same target than you
      2) Then healers who's spell completed
      3) Then healers who's spell will complete before the others
    - By alphabetic order
  You can change the sorting mode, by clicking on a column title :
    - Clicking on "Healer's name column title" will sort using alphabetic order
    - Clicking on any other column title will sort using Casting order

  The emergency view is sorted like this :
    - Players with less life (sorted by percentage), BUT if someone is casting on him the estimated heal value is added to it's current health
      -> Someone with 10% life but +20% health incoming, will not show before someone with 20% life and no incoming heal.

  If you click on a cooldown spell that is ready and castable on others (innervate/rebirth/divine intervention), you will send a request for this spell to it's owner.
  The owner of the spell can :
    - Automatically refuse all requests for this spell (configured in the options)
    - Automatically accept requests from trusted healers (configured in the options - Configuration NOT YET AVAILABLE)
    - Otherwise, a popup window with Accept/Cancel will be displayed, asking for auto-cast of the spell on who
  If the owner automatically accepts this spell or clicked on the Accept button, the spell is directly casted on you
  
  You can now request a spell, even if you don't have Healers Assist installed !
  All you have to do is write a macro with inside :
    /script SendAddonMessage("HealAss","<HA7>09"..'\30'.."16"..'\30'.."Kiki","RAID")
  You just have to replace "Kiki" by the name of the player you want to request a spell (WARNING, Case sensitive !!), and change the SpellCode (the "16" value) according to :
   - Innervate : 16
   - Rebirth : 17
   - Divine Intervention : 81
   - Blessing of Protection : 87
   - Mana Tide Totem : 63
   - Light Well : 48
   - Power Infusion : 50

  The main window can be automatically opened when you are in a group/raid (configured in the options)
  You can assign a key to "open main window" and "open options window", from the Shortcut menu

  By clicking the "Rest" checkbox (topleft of the window), you notify other healers that you enter a mana regen cycle. While you stay in this mode, your mana bar will be flashing in the Healers list.
  You'll leave this mode (and informing other healers) :
    - If you uncheck the box
    - If you start casting a spell
    - If your mana bar is full


/* ********************************************** 
**  Known bugs :
********************************************** */


/* ********************************************** 
**  Thanks :
********************************************** */

  Thanks to Margouline for the initial idea (seing who is casting a spell on the MainTank)
  Thanks to all cobaye healers of my guild (Mainly Margouline, Kathrynn, Phalytcha, Aïneken, Koblar, Sainte, Siko, Bonhass, Gonzilla, Pitichat and all other ^^)
  Thanks to Artack for some code ripped from SWStats
  Thanks to Freddy for so many little code details and functions, and 'DE' localization, and so many great HA plugins
  Thanks to Decursive guys, for range checking code


/* ********************************************** 
**  Detecting HA from another addon :
********************************************** */
If you need to detect if Healers Assist is present from another addon, I suggest you test the presence of the variable HA_VERSION (a string)


/* ********************************************** 
**  Overriding default frame OnClick function :
********************************************** */
This is automatically done by HA if it detects CastParty or WatchDog (clicks are forwarded to either one of them).
If you want to change the default behaviour, you have to initialiaze the "HA_CustomOnClickFunction" variable to a function of the following prototype
  bool CallbackFunction(string ButtonEvent,string UnitID)
    - ButtonEvent is the button event that triggered the callback ("LeftButtonDown", "RightButtonDown", ...)
    - UnitID is the unit id the click applies to ("player", "party1", "raid25", ...)
    - The function must return a boolean value : True if it has processed the message, False otherwise


/* ********************************************** 
**  Macro API :
********************************************** */
Command to select an emergency target :
---------------------------------------
 HA_SelectEmergency(pos)
  "pos" is the index (from 1 to 6, 1 being the highest priority)

Command to enter/leave regen mode :
-----------------------------------
 HA_SetRegenMode(state)
  "state" is either true (enter regen) or false (leave regen)



/* ********************************************** 
**  Plugins API :
********************************************** */

Plugin Entry points :
---------------------

OnSpellStart(healer,raider,SpellCode,SpellName,CastTime,Estimated,WillCrit,SpellRank)
OnSpellDelayed(healer,Value)
OnSpellHit(healer,raider,SpellCode,SpellName,Value,Crit,OverHealed,InstantSpell)
OnSpellHitInstant(healer,raider,SpellCode,SpellName,Duration,Estimated,SpellRank)
OnSpellFailed(healer,raider,SpellCode,IReason,Reason)
OnSpellHotTick(healer,raider,SpellCode,SpellName,Value,OverHealed)
OnEatHot(SpellCode,raider,HotFrom,HotStartTime,HotDuration) (HotStartTime was initialized using GetTime() function)
OnSpellCooldown(healer,raider,SpellCode,SpellName)
OnCooldownUpdate(healer,SpellCode,SpellName,Cooldown)

OnEvent(event,params)
OnGetHealersList
SortHealers
OnGetEmergencyList
SortEmergency

-----------------

Notes :
 - Don't rely on HA_Healers[HA_PlayerName] infos in the OnSpellHitInstant function, since it might not be initialized with correct values if instants are not activated in HA's config

Sending private plugin message between player :
-----------------------------------------------
A plugin that want to exchange data between players, must register the Plugin.OnPluginMessage function which prototypes :
 function OnPluginMessage(From,Params)
   - From       : String - Name of the player who sent the message
   - Params[1]  : String - Plugin name
   - Params[..] : Any    - Passed parameters

To send data to other players who have the plugin installed, it must call
 function HA_COM_PluginCommand(PluginName,...)
   - PluginName : String - Name of the plugin (same value as Plugin.Name)
   - ...        : Any    - Passed parameters


Using plugin to populate and/or sort Healers and/or Emergency list :
--------------------------------------------------------------------
You have the possibility to override both displayed rows and the way rows are sorted, for the Healers list (top one), and the Emergency list (bottom one).

1) Populate Healers list
 You must add the 'OnGetHealersList' hook to your plugin struct.
 This function takes no parameter, but must return a list of healers.
 This list must be populated using the table.insert() function, and each entry must contain a HA_Healers struct.
 If you want to use HA's default filter (that uses current configuration to filter classes), you can call the HA_DefaultFilter_Healer() function which takes a HA_Healers struct as parameter, and returns true ou false (true = Healer NOT filtered).
 If you don't use default filter function, you must AT LEAST check if HA_Healers[].Raider is nil (if nil, must NOT be added to the list)
 Example :
    local list = {};
    for name,tab in HA_Healers
    do
      if(HA_DefaultFilter_Healer(tab))
      then
        tinsert(list, tab);
      end
    end
    return list;

2) Custom sorting of Healers list
 You must add the 'SortHealers' hook to your plugin struct.
 This function is directly passed to the table.sort() function (see doc of table.sort) to sort the healers list. Either default one, or the one returned by 1).

3) Populate Emergency list
 You must add the 'OnGetEmergencyList' hook to your plugin struct.
 This function takes no parameter, but must return a list of raiders.
 This list must be populated using the table.insert() function, and each entry must contain a struct of :
  {
    raider -- A HA_Raiders struct
    total -- Total incoming heals. Must be computed using the HA_ComputeIncomingHeals function (takes a HA_Raiders struct as parameter, and returns the total incoming heal value)
  }
 If you want to use HA's default filter (that uses current configuration to filter classes, groups, range...), you can call the HA_DefaultFilter_Raider() function which takes a HA_Raiders struct as parameter, and returns true ou false (true = Raider NOT filtered).
 Example :
    local list = {};
    for name,tab in HA_Raiders
    do
      if(HA_DefaultFilter_Raider(tab))
      then
        total = HA_ComputeIncomingHeals(tab);
        tinsert(list, { raider = tab; total = total });
      end
    end
    return list;

4) Custom sorting of Emergency list
 You must add the 'SortEmergency' hook to your plugin struct.
 This function is directly passed to the table.sort() function (see doc of table.sort) to sort the emergency list. Either default one, or the one returned by 3).


/* ********************************************** 
**  ChangeLog :
********************************************** */
   - 2006/09/12 : 1.1
     - Fixed incorrect healing debuff detection of Nefarius encounter
   - 2006/08/31 :
     - Fixed Item Bonuses not correct with latest BonusScanner addon installed (Scan not done, if no other addon ask BS for a scan)
   - 2006/08/30 :
     - Fixed minor xml error (minimap button not highlighting correctly (thanks Kagar)
     - Fixed initialization issue, if not using GroupAnalyse addon
   - 2006/08/29 : 1.0 beta33
     - Increased protocol version to remove encoding of strings (no longer needed)
     - Fixed some init error
   - 2006/08/28 :
     - Updated the HA_RequestSpell function : Don't ask innervate to a morphed druid, except if only one available
     - Updated TOC for 1.12
     - Updated code to use the new AddOn specific channel
   - 2006/08/08 :
     - Added JustClick Addon support
   - 2006/07/31 :
     - Removed LayOnHands from SpellRequest, but added BlessingOfProtection instead
     - Added a new function : HA_RequestSpell(SpellName) : Request first available SpellName (like Innervate, PowerInfusion...)
   - 2006/07/26 :
     - Fixed 'Reason' string being always nil in 'OnSpellFailed' plugin call 
   - 2006/07/19 :
     - Fixed isfriend value (now using ischarmed instead, to filter mind controlled friendly players)
   - 2006/07/10 :
     - No longer sending data (except if really needed) when being AFK. Should prevent most of the "AFK/UNAFK" flood
   - 2006/07/06 :
     - Improved heal malus detection code (now possibility to use debuff name)
     - Added Chromaggus Green affliction
   - 2006/07/05 :
     - Added a new /ha command : "/ha msg <msg>" (see "/ha help")
   - 2006/07/04 :
     - Updated readme.txt file
     - Fixed debuff detection code (ebonroc/nefarius)
     - Added Naxxramas Necrotic Poison debuff detection (90% healing malus)
   - 2006/07/03 :
     - Added Abolish Disease spell
     - Optimized emergency list update
     - Fixed the EatHot function (in fact Swifthealing can consume the HoT of someone else, not only yours)
     - Added a new plugin callback : OnEatHot(SpellCode,raider,HotFrom,HotStartTime,HotDuration)
   - 2006/06/30 :
     - Re-enabled list update during health event
   - 2006/06/30 : 1.0 beta32
     - Fixed possible Warning message flood, if you are drunk
     - Removed GUI refresh every UNIT_HEALTH event (global performance increase)
     - Added a new function : HA_GetLocalInfos(SpellCode) : Returns a HA_Spells or HA_InstantSpells or HA_PassiveSpells struct, depending on the SpellCode value
     - Added a new parameter to the OnSpellHotTick plugin callback function : "OverHealed" value for the HoT tick
     - Added Librams detection (thanks to Freddy)
   - 2006/06/22 : 1.0 beta31
     - Updated TOC
     - Removed warning in _HA_EatHot function
     - Fixed DE/EN localization for new Swiftmend talent
     - Clean even more the code that populates/sorts the healers and emergency lists.
     - You now have the possibility to override both displayed rows and the way rows are sorted, for the Healers list (top one), and the Emergency list (bottom one) (see readme.txt file).
     - Fixed a bug where sometimes, you can see a *shadow* healer in the list
   - 2006/06/13 : 1.0 beta30
     - Now applying multiple heal bonus from talent all at once (like the game), instead of applying percents one after another (leading in a greater estimated value)
     - Since BonusScanner does not seem to be updated anymore, using by default HA's scanner now (I fixed few errors for French localization, that are still in BonusScanner).
   - 2006/06/12 :
     - Added hook to CastShapeshiftForm (to prevent weird bugs with spell request)
     - Automatically re-show SpellRequest dialog, if the cast failed for any reason (stun, silence, shapeshift)
     - Automatically calling HA_EVENT_RAIDER_JOINED and HA_EVENT_HEALER_JOINED events, when loading a plugin after joining a raid group
   - 2006/06/05 :
     - Added a new / command : /ha versions
     - Fixed overheal estimation using new health update code
   - 2006/06/02 :
     - Massive UI code cleanup for better CPU & memory performance
     - Added 2 new events (HA_EVENT_GUI_UPDATED_HEALERS and HA_EVENT_GUI_UPDATED_EMERGENCY) triggered right after lists redraw
     - Added 'healer' and 'raider' struct to healer and emergency lists buttons (respectively) for plugins access.
      -> Seek 'HAItem_X.infos' for HA_Healers struct (where X is the button number)
      -> Seek 'HAItemEmergency_X.infos' for HA_Raiders struct (where X is the button number)
   - 2006/06/01 :
     - Optimized some part of the code (and auto building localized spell names)
     - Fixed Swiftmend *eat* code (always eat Rejuv before regrowth)
     - Fixed possible lua error when joining the channel
   - 2006/05/31 :
     - Now supporting instant spells, as well as the new 1.11 Swiftmend spell
     - In debug mode (only), you can set MinPercent (emergency list) to 101% (always show a member, like yourself ^^)
     - Fixed "Lay on hands" showing for every class in Healer options window
     - Added a new Checkbox in Emergency options window : FilterRange (don't show in emergency list, members at more than 30 yards)
   - 2006/05/29 :
     - Now passing SpellName and SpellRank to plugins in UseAction,CastSpell, and CastSpellByName callbacks
   - 2006/05/22 :
     - Fixed possible lua errors (nil value) shortly after login (SpellRank being nil instead of 0)
     - Only showing "No HA version available" for healers in my raid
     - Now sending HoT ticks to other healers
   - 2006/05/19 :
     - Added Version message to the protocol
     - Added function HA_ShowVersions() to print HA's version of healers
     - Now handle HotTicks
     - Fixed lua errors because of old DivineShield cooldown updates
   - 2006/05/18 :
     - Fixed CurrentZone init error after a /reloadui
     - Removed DivineShield from the cooldown spells, and added LayOnHands instead (can be queried)
     - Added function HA_QuerySpell(SpellName,PlayerName) for macro users
     - Added missing priest spells (disease/magic dispel) and shaman's purge
     - Fixed group-heals OnHit (can now be used by Statistics plugins)
   - 2006/05/17 :
     - Now detecting Healing debuff from Texture then from current Zone (HA_HealDebuffs structure in localization.lua)
   - 2006/05/16 :
     - Added function HA_COM_Announce(Message) to send a message to all HA users in your raid
     - Added function HA_COM_PluginCommand(PluginName,...) to be used by plugins to send private data
       -> Plugins must register a new callback in order to process those messages : OnPluginMessage()
     - Fixed Emergency list possible error (showing you in the list if you are dead)
   - 2006/05/15 :
     - Changed order of groups in Emergency option window
   - 2006/05/03 : 1.0 beta28
     - Fixed HA_EVENT_RAIDER_LEFT event passing bad Raider Name
     - Added HA_RaidersByID array (global optimization)
   - 2006/05/02 :
     - Added support for WatchDog click casting
   - 2006/04/28 :
     - Now using CheckInteractDistance() for 30 yards requested spells (does not change your current target to do so)
     - Now retrieving channel members after a CTRaid channel sync
     - Added a new protocol message : Announce message (like CTRaid announces). Can be used by plugins
     - Added possibility to change backdrop opacity
       -> Added a new parameter to the HA_EVENT_WINDOW_SIZED event : Backdrop Alpha value (from 0 to 1)
   - 2006/04/26 :
     - Increased max healer lines to 16
   - 2006/04/24 :
     - Fixed "Not dead" issue when trying to request a Resurrection spell
     - Fixed "Healer joined, but class is not a healer" issue
   - 2006/04/20 : 1.0 beta27
     - Added optional dep to my new addon, in order to minimize raid freezes when a member joins/leaves/zones
     - Optimized PARTY_MEMBERS_CHANGED event
     - Fixed total nonsense introduced with the _HA_CurrentRaiderTarget variable
     - Now showing healer's subgrp, when he is in Resting mode (RAID only). Subgrp is shown in the "Target" column
     - Fixed +heal bonus not always correct after entering the world or zoning
     - Now using BonusScanner AddOn if present, instead of internal bonus scan
     - Fixed +heal bonus error in french localization (missing some enchants bonus)
   - 2006/04/17 :
     - Fixed SpellCasting reset at a wrong place
     - Fixed possible wrong target detection in SpellTargetUnit
   - 2006/04/14 :
     - Fixed manabar of healers not showing with correct alpha value, if HA's window alpha value is changed
     - Added profiling values (and a profiling plugin)
     - Added a new option (slider) in global options : Refresh rate for the UI
   - 2006/04/13 :
     - Fixed bug with incorrect estimated value when target has a heal debuf (like mortal-strike)
   - 2006/04/12 :
     - Added possibility to change HA's window opacity (global options)
       -> Added a new parameter to the HA_EVENT_WINDOW_SIZED event : Alpha value (from 0 to 1)
     - Fixed error in HA_EVENT_RAIDER_JOINED event
   - 2006/04/10 :
     - Added function : String HA_GetSpellClass(ISpell)
   - 2006/04/10 : 1.0 beta26
     - Changed SpellFailed message and callbacks. Now uses an International code (translate back to local error text with HA_GetLocalReason() function)
       -> See Spell failure codes in HA_spells.lua
       -> Upgraded protocol version
       -> Improved common failure messages in HA's window
     - Fixed SpellFailure message sent sometimes while it should not
     - Now correctly updating raiders info when HA's window is not visible (using shortcut to get emergency targets should not choose dead people anymore if the window is hidden)
     - Fixed issues with deleted plugins showing in plugins list
     - Added CastTime parameter to _HA_GetEstimated function (for futur usage)
     - Added Scale UI slider to main options (Thanks Calastir)
     - Fixed init error for HA_MaxRanks (thanks Freddy for the fix, it was your code after all ^^)
     - Added Hakkar and Instable force trinket support (not validated yet)
     - Added function : Boolean HA_IsSpellClass(ISpell,Class)
   - 2006/04/08 :
     - Fixed another bad START/STOP/HIT sequence
   - 2006/04/07 : 1.0 beta25
     - Added a new command to protocol, to fix some issues with spell_start/stop and non healing spells
     - Reworked the whole healer states (GUI). Added an intermediate state (STATE_STOP), this state always follow a STATE_START no matter what
     - All this changes will allow support for group spells (needed for statistics)
     - Added 2 new global variables : HA_MyselfHealer and HA_MyselfRaider (pointers to HA_Healers[HA_PlayerName] and HA_Raiders[HA_PlayerName])
     - Increased protocol version
   - 2006/04/06 :
     - Added field GroupHeal to HA_Healers[] struct
   - 2006/04/05 :
     - Fixed TargetName in some cases (mostly scripts)
     - Added power infusion into estimated value
     - Added MortalWound detection (not tested yet)
     - Added SpellRank to messages and callbacks (and stored in HA_Healers struct, as SpellRank)
   - 2006/04/03 : 1.0 beta24-2
     - Damned lua error
   - 2006/04/03 : 1.0 beta24
     - Fixed bug with regen mode state
     - You can now fully hide the Emergency window (set it to 0 lines shown)
     - Added possibility to call a Configure function for plugins
     - Added possibility to change order of plugins
     - Fixed a bug in emergency window : Sometimes wrong row displayed
     - You can now use the shortcuts to select emergency targets while HA's window is not visible (meaning HA_SelectEmergency() function)
     - Updated some plugin events
     - Now taking Mortal strike into account to estimate incoming heal value
     - Added HA_IsPlayerCasting() function for easy plugin access (returns true or false)
   - 2006/04/01 :
     - Fixed bug with start/stop/fail cast
   - 2006/03/31 :
     - Added missing priest/paladin/shaman spells to DE/EN localization (need DE translation)
     - Added priest PowerInfusion to requestSpell and cooldown icon
   - 2006/03/30 :
     - Optimized load time (and item swap lag) (up to 4sec of load time gained)
     - Fixed submenu (minimap icon) not showing at the correct position without TitanPanel (out of screen)
   - 2006/03/28 : 1.0 beta23
     - Added a new param to plugins : Anchors. Auto setting anchors for UI plugins, relative to the main frame (or other plugins), depending on the load order of the plugin (load order soon configurable)
   - 2006/03/27 :
     - Moved NonHeal spell reset into a more global function
     - If an estimate value is already found for yourself, don't increment count
     - Fixed death state detection
     - Showing overheal status (gradient from white to red) after a casted spell
     - Greatly improved HP/MP retrieval code
   - 2006/03/24 :
     - Added plugin configuration in the options
   - 2006/03/23 :
     - Fixed plugin loader
     - Disabling SpellRequest configuration for spells you don't have
     - Fixed HA window showing after zoning, if not grouped and "Auto open" option checked
   - 2006/03/22 : 1.0 beta22
     - Fully rewrote the configuration UI (but not finished yet) (massive cleanup)
   - 2006/03/21 :
     - Fixed more State reset errors, and fixed InRegen state possible issues
     - Cleanup some parts of the code
   - 2006/03/20 :
     - Rewrote Raiders/Healers initialization to better support new plugin system
     - Rethought plugin system, and improved it
     - Removed Stats from HA core, and moved to a plugin
     - Fixed 6th emergency line not visible (if set to 6 lines)
     - Not counting "group" spells in estimation (fixes issue with "Count" and "Estim." fields not always being reset)
     - Upgraded protocol to add WillCrit parameter in SpellStart command
     - Added support for Divine favor
     - New config option : NotifyRegen. If true, prints a message in chat when a healer enters mana regen state
   - 2006/03/17 :
     - Added plugin system
     - New plugin : Shows target of all healers and all emergency players
     - Fixed scrolling bar height when changing count of max healers
   - 2006/03/16 :
     - Added a new healer state 'Resting' and a checkbox to notify other healers you want to enter a mana regen cycle.
     - You can see healers in resting mode, with their flashing mana bar in the healers list
   - 2006/03/15 : 1.0 beta21
     - Removed target-change flood when detecting range for RequestedSpell, and removed restoring old target (cause spell to be incorrectly set)
     - No longer showing NotVisible (too far or under stealth and not targetable) units in the emergency monitor
     - Resetting HA_SpellTargetName after each SPELL_START and SPELL_STOP, whatever the spell was (a monitored one or not) -> Fixes issue with a SpellTargetUnit called with a non monitored spell, before a monitored one.
     - Check current state in HA_GUI_Process_SpellStart, it is was HA_STATE_CASTING, then force a UI failure -> Resets Estimates and Count on your previous target
     - Can't request for a resurrect spell when not dead nor *when alive* spell when you are dead, anymore
     - Added overhealing indication in Healers view : Color of your target will fade from white to red, depending on the % your spell will overheal (based on other healers current cast)
     - Showing Deficit value of the target you are casting on, in blue (instead of white)
     - Added possibility to change the max number of Healers and Emergency we want to see in the list (1-10 for healers, 1-6 for emergency)
       -> Not yet configurable from the options... will come (you can set it by hand by changing HA_Config.HealersLines and HA_Config.EmergLines)
       -> You can change the anchor by changing HA_Config.GrowUpwards (true or false)... will come in options soon
     - Added possibility to collapse all healers (except you) directly from the main window
     - Added possibility to lock/unlock the window, from the minimap icon submenu (right click the icon)
     - Fixed SpellRequest popup height
     - Added some text in the minimap icon tooltip
   - 2006/03/14 : 1.0 beta20
     - Temporary adding your current target (if friendly) in the emergency list. Allow monitoring of NPC
     - Added 5 keybindings to select the 5 first emergency targets
     - Retargeting previous target, after casting a RequestedSpell
     - Resetting Estimates count when a player dies.
     - Slight optimizations
     - Taking range into account in SpellRequest popup dialog (OK button greyed if not in range)
       -> Warning : you must have the spell in your action buttons, or if it's a macro the macro icon must be the same than the spell !
   - 2006/03/13 :
     - Fixed casting bars not correct when opening HA's window
     - Fixed non-healing spells not terminating
     - Added few statistics. Print with HA_PrintStats(HealerName), and reset with HA_ResetHealerStats(HealerName)... Only casted spells for the moment (no instant). MUCH MORE TO COME !
   - 2006/03/10 :
     - Not sending spellRequest if it's myself
     - Fixed target acquiring code
     - Fixed localization
   - 2006/03/09 : 1.0 beta19
     - Added readme.txt file
     - Fixed DE localization
     - Fixed Wrong spell rank used in some cases
     - Added possibility to "click" on a cooldown spell (innervate/divine intervention/..) to request it ! By default, all spells are blocked, and until it's in the configuration menu it will not work
   - 2006/03/08 :
     - Fixed missing localization string (priests, again)
     - Added TargetName mouseover detection code
     - Fixed missing Reincarnation spell cooldown
   - 2006/03/07 : 1.0 beta18-2
     - Removed 1.10 priest talents and spells from the HA_spell.lua file -> No more lua errors for priest, sorry
   - 2006/03/07 : 1.0 beta18
     - Added healing classes filtering in healer's list
     - Added in-game help, in options window (mouse over the [?] symbol)
     - Added key bindings to open/close HA main window and config window
   - 2006/03/06 :
     - Fixed missing localization strings
     - Fixed tooltip issue
     - Added DE localization (thanks Nathanos)
   - 2006/03/03 : 1.0 beta17
     - Added Paladin's Greater Blessing of Light support
     - Not showing players under mind control, in emergency list
     - Updating Raider's health, as soon as a Healer's spell cast completed
     - Reworked config GUI a little bit
     - Added possibility to filter Emergency list by class (and added classes in options)
     - Fixed Instant spells not showing for others, and fixed HoT spells not correctly showing according to the options
   - 2006/03/02 : 1.0 beta16
     - Full localization : Need US/UK testing before release
   - 2006/03/01 : 1.0 beta15
     - Now taking BlessingOfLight into account for estimated heal value
     - Now displaying cooldown values in min/sec instead of sec
     - Added possibility to filter Emergency window by groups
     - Added a *big* configuration window (right clic on the minimap icon for the menu)
   - 2006/02/28 : 1.0 beta14
     - Now taking Talents into account for estimated heal value
     - Added new Healers sorting type : If you clic on Healer's name column header, it will sort by alphabetic order, any other column header will sort by casting state
     - Added minimap icon : Left clic toggles HA's window, Right clic opens a sub menu
     - Not leaving CTRaid channel if it was HA's current channel, if you are trying to leave it
     - Automatically joining CTRaid channel at startup, if SyncWithCTRaid option enabled
   - 2006/02/27 : 1.0 beta13
     - Upgraded protocol to version 4 : Changed Innervate messages into generic cooldown spells and update messages
     - Display Cooldown spell's tooltip inside HA's window
     - Now displaying cooldowns for Shaman's reincarnation, paladin's divine intervention, and druid's rebirth
     - Now showing 2 cooldown spells. Needed for druid (innervate+rebirth) and paladin (divine shield/intervention)
     - Now showing 4 overtime spells in emergency targets
     - Now showing estimated heal value in the casting bar
     - Now showing (if activated in config) hot spells in 'spell' and 'Casting' columns
     - Added non-healing spells (like abolish poison/curse...), and showing them (if activated in config) in 'Spell' column
     - Auto-sync with CTRaid channel (if activated in config)
   - 2006/02/25 : 1.0 beta12
     - Fixed lua error in _HA_DecodeString
     - Upgraded protocol to version 3 : Now encoding strings in hexadecimal
   - 2006/02/24 : 1.0 beta11
     - Upgraded protocol to version 2 : Changed all SpellNames to SpellCodes (international values)
     - Now showing 3 Spells over time for each member of emergency monitor
     - Now showing a flashing red innervate icon, if a healer received an innervate
     - Now encoding all strings sent to the channel (to prevent drunk strings)
   - 2006/02/23 : 1.0 beta10
     - Added Innervate status to Healers list (if present, and cooldown if any)
     - Plays a sound when you receive an innervate, and print a message in chat window
     - Now sending instant spells (but not displayed yet)
   - 2006/02/22 :
     - Added "/ha debug" option
     - Added "/ha auto" option
     - Added "/ha channel" option
     - Not showing offline people in emergency window
     - Fixed initialization bug (lua error in HA_gui.lua)
     - Allow usage of the CTraid channel (need to auto-get it in the futur)
   - 2006/02/17 : 1.0 beta9
     - Fixed wrong target for spells, sometimes
     - Showing Rage/Energy background color for druids, instead of the blue mana background color
     - Fixed wrong base spell values
   - 2006/02/16 : 1.0 beta8
     - Takes +heal bonus into account for estimated heal value
     - Fixed dead status remaining after resurection
   - 2006/02/15 : 1.0 beta7
     - Fixed lines width too big (10pix)
     - Displaying dead healers in Red
     - Not showing dead raiders in emergency list
     - Fixed String width for long player names
     - Fixed target name and health not showing if not in group/raid
     - Taking Spell Ranks into account
     - Showing estimated incoming heal value
   - 2006/02/14 : 1.0 beta6
     - Fixed bug in SendSpellComplete function
     - Optimized and reworked Healers sorting function
     - Now filter real healers in list (priest,druid,paladin,shaman)
     - Added Emergency monitor, based of who is not currently healed then who have the less life
   - 2006/02/13 : 1.0 beta5
     - Reworked GUI : Now display Healer MP, Target HP. Now uses StatusBar component.
   - 2006/02/10 : 1.0 beta1
     - Module created. Initial version



