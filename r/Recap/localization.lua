
--[[ Miscellaneous variables and localization strings for Recap 3.3 ]]

recap_temp = {}; -- global values that don't go to savedvariables

--[[ Filter method  ]]

-- filter method largely taken from Telo's MobHealth. source=6 when it's the player
-- effect=7 when it's Melee, effect=8 when it's a damage shield
-- crit identifies which events can crit. crit=1 is a crit, crit=0 not a crit
-- miss: 9=miss/deflect/resist, 10=dodge, 11=parry, 12=block
-- 13 = 0 (for damage)
recap_temp.Filter = {
		{ source=6, dest=2, damage=3, effect=1, crit=0, pattern=SPELLLOGSELFOTHER }, -- Your (.+) hits (.+) for (%d+)
		{ source=6, dest=2, damage=3, effect=1, crit=1, pattern=SPELLLOGCRITSELFOTHER }, -- Your (.+) crits (.+) for (%d+)
		{ source=6, dest=2, damage=3, effect=1, pattern=SPELLSPLITDAMAGESELFOTHER }, -- Your (.+) causes (.+) (%d+) damage
		{ source=3, dest=6, damage=1, effect=4, pattern=PERIODICAURADAMAGEOTHERSELF }, -- You suffer (%d+) (.+) damage from (.+)'s (.+)
		{ source=6, dest=1, damage=2, effect=4, pattern=PERIODICAURADAMAGESELFOTHER }, -- (.+) suffers (%d+) (.+) damage from your (.+)
		{ source=6, dest=3, damage=1, effect=8, pattern=DAMAGESHIELDSELFOTHER }, -- You reflect (%d+) (.+) damage to (.+)
		{ source=6, dest=1, damage=2, effect=7, crit=0, pattern=COMBATHITSELFOTHER }, -- You hit (.+) for (%d+)
		{ source=6, dest=1, damage=2, effect=7, crit=1, pattern=COMBATHITCRITSELFOTHER }, -- You crit (.+) for (%d+)
		{ source=1, dest=3, damage=4, effect=2, crit=0, pattern=SPELLLOGOTHEROTHER }, -- (.+)'s (.+) hits (.+) for (%d+)
		{ source=1, dest=3, damage=4, effect=2, crit=1, pattern=SPELLLOGCRITOTHEROTHER }, -- (.+)'s (.+) crits (.+) for (%d+)
		{ source=1, dest=3, damage=4, effect=2, pattern=SPELLSPLITDAMAGEOTHEROTHER }, -- (.+)'s (.+) causes (.+) (%d+) damage
		{ source=1, dest=4, damage=2, effect=8, pattern=DAMAGESHIELDOTHEROTHER }, -- (.+) reflects (%d+) (.+) damage to (.+)
		{ source=4, dest=1, damage=2, effect=5, pattern=PERIODICAURADAMAGEOTHEROTHER }, -- (.+) suffers (%d+) (.+) damage from (.+)'s (.+)
		{ source=1, dest=2, damage=3, effect=7, crit=0, pattern=COMBATHITOTHEROTHER }, -- (.+) hits (.+) for (%d+)
		{ source=1, dest=2, damage=3, effect=7, crit=1, pattern=COMBATHITCRITOTHEROTHER }, -- (.+) crits (.+) for (%d+)

		{ source=1, dest=3, effect=2, miss=9, pattern=SPELLMISSOTHEROTHER }, -- (.+)'s (.+) missed (.+)
		{ source=1, dest=6, effect=2, miss=9, pattern=SPELLMISSOTHERSELF }, -- (.+)'s (.+) misses you
		{ source=6, dest=2, effect=1, miss=9, pattern=SPELLMISSSELFOTHER }, -- Your (.+) missed (.+)
		{ source=1, dest=6, effect=7, miss=9, pattern=MISSEDOTHERSELF }, -- (.+) misses you
		{ source=1, dest=2, effect=7, miss=9, pattern=MISSEDOTHEROTHER }, -- (.+) misses (.+)
		{ source=6, dest=1, effect=7, miss=9, pattern=MISSEDSELFOTHER }, -- You miss (.+)
		{ source=1, dest=3, effect=2, miss=9, pattern=SPELLRESISTOTHEROTHER }, -- (.+)'s (.+) was resisted by (.+)
		{ source=1, dest=6, effect=2, miss=9, pattern=SPELLRESISTOTHERSELF }, -- (.+)'s (.+) was resisted
		{ source=6, dest=2, effect=1, miss=9, pattern=SPELLRESISTSELFOTHER }, -- Your (.+) was resisted by (.+)
		{ source=1, dest=3, effect=2, miss=9, pattern=SPELLDEFLECTEDOTHEROTHER }, -- (.+)'s (.+) was deflected by (.+)
		{ source=1, dest=6, effect=2, miss=9, pattern=SPELLDEFLECTEDOTHERSELF }, -- (.+)'s (.+) was deflected
		{ source=6, dest=2, effect=1, miss=9, pattern=SPELLDEFLECTEDSELFOTHER }, -- Your (.+) was deflected by (.+)
		{ source=1, dest=6, effect=7, miss=10, pattern=VSDODGEOTHERSELF }, -- (.+) attacks. You dodge
		{ source=1, dest=2, effect=7, miss=10, pattern=VSDODGEOTHEROTHER }, -- (.+) attacks. (.+) dodges
		{ source=6, dest=1, effect=7, miss=10, pattern=VSDODGESELFOTHER }, -- You attack. (.+) dodges
		{ source=1, dest=6, effect=7, miss=11, pattern=VSPARRYOTHERSELF }, -- (.+) attacks. You parry
		{ source=1, dest=2, effect=7, miss=11, pattern=VSPARRYOTHEROTHER }, -- (.+) attacks. (.+) parries
		{ source=6, dest=1, effect=7, miss=11, pattern=VSPARRYSELFOTHER }, -- You attack. (.+) parries
		{ source=6, dest=1, effect=7, miss=12, pattern=VSBLOCKSELFOTHER }, -- You attack. (.+) blocks
		{ source=1, dest=6, effect=7, miss=12, pattern=VSBLOCKOTHERSELF }, -- (.+) attacks. You block
		{ source=1, dest=2, effect=7, miss=12, pattern=VSBLOCKOTHEROTHER }, -- (.+) attacks. (.+) blocks

		{ source=1, dest=6, damage=13, effect=2, pattern=SPELLCASTOTHERSTART } -- (.+) begins to cast (.+)
}	
recap_temp.FilterSize = 37; -- number of filters, change to recap_temp.Filter size

-- separate filter for heals, processed apart from damage hits from above
-- but same rules: source=6 is player, effect=7 is melee, effect=8 is damage shield, crit=0/1 for crits
recap_temp.HealFilter = {
		{ source=2, dest=6, heal=1, effect=3, pattern=PERIODICAURAHEALOTHERSELF }, -- You gain (%d+) health from (.+)'s (.+)
		{ source=6, dest=6, heal=1, effect=2, pattern=PERIODICAURAHEALSELFSELF }, -- You gain (%d+) health from (.+)
		{ source=6, dest=1, heal=2, effect=3, pattern=PERIODICAURAHEALSELFOTHER }, -- (.+) gains (%d+) health from your (.+)
		{ source=3, dest=1, heal=2, effect=4, pattern=PERIODICAURAHEALOTHEROTHER }, -- (.+) gains (%d+) health from (.+)'s (.+)
		{ source=6, dest=2, heal=3, effect=1, crit=1, pattern=HEALEDCRITSELFOTHER }, -- Your (.+) critically heals (.+) for (%d+)
		{ source=6, dest=2, heal=3, effect=1, crit=0, pattern=HEALEDSELFOTHER }, -- Your (.+) heals (.+) for (%d+)
		{ source=1, dest=3, heal=4, effect=2, crit=1, pattern=HEALEDCRITOTHEROTHER }, -- (.+)'s (.+) critically heals (.+) for (%d+)
		{ source=1, dest=3, heal=4, effect=2, crit=0, pattern=HEALEDOTHEROTHER } }; -- (.+)'s (.+) heals (.+) for (%d+)
recap_temp.HealFilterSize = 8;

recap_temp.DeathFilter = {
		{ victim=6, pattern=UNITDIESSELF }, -- You die
		{ victim=1, pattern=ERR_PLAYER_DIED_S }, -- (.+) has died
		{ victim=1, pattern=UNITDIESOTHER } }; -- (.+) dies
recap_temp.DeathFilterSize = 3;

--[[ Tooltips, option indexes ]]

-- First field each line MUST NOT CHANGE (they are option id's)
-- the order MUST NOT CHANGE until HeaderTime.  They are in the order of GetID values
recap_temp.OptList = {
	{ "UseColor", "Use Color", "When checked, friendly combatants and damage dealt to others are colored green, incoming damage is colored red." },
	{ "GrowUpwards", "Expand Window Up", "When checked, the window's bottom edge will remain anchored while the top edge resizes." },
	{ "GrowLeftwards", "Expand Window Left", "When checked, the window's right edge will remain anchored while the left edge resizes." },
	{ "ShowTooltips", "Show Tooltips", "When checked, tooltips like the one you're reading will be shown." },
	{ "AutoHide", "Auto Hide Entering Combat", "When checked, and the window isn't minimized, it will hide when a fight begins and reappear when the fight ends." },
	{ "AutoFade", "Auto Fade Window", "When checked, and the window isn't minimized, the window will fade after your mouse leaves the window." },
	{ "LimitFights", "Limit Fights to Combat", "When checked, fight logging will not begin until you enter combat mode.  Recommended Off unless you don't want to log fights around you." },
	{ "HideZero", "Show Only Fights With Duration", "When checked, fights without a duration will not be shown.  Use this to hide damage done to totems, critters, etc." },
	{ "HideFoe", "Show Only Friendly Combatants", "When checked, only fight information from friendly combatants will be shown.  Right-click a name to toggle its friend/foe status." },
	{ "IdleFight", "End Fight If Idle", "When checked, fights will end if no hits happen for a length of time." },
	{ "Time", "Display Time", "When checked, each combatants' time fighting will be displayed in the list." },
	{ "MaxHit", "Display Max Hit", "When checked, each combatants' max hit will be displayed in the list." },
	{ "DmgIn", "Display Damage In", "When checked, each combatants' total damage received will be displayed in the list." },
	{ "DmgOut", "Display Damage Out", "When checked, each combatants' total damage dealt to others will be displayed in the list." },
	{ "DPS", "Display DPS", "When checked, each combatants' damage per second dealt to others will be displayed in the list." },
	{ "DPSIn", "Display Total DPS In", "When checked, the total damage per second friendly combatants received will be displayed in totals." },
	{ "MinStatus", "Display Status While Minimized", "When checked, the status light will remain visible while minimized." },
	{ "MinView", "Display Last/All While Minimized", "When checked, a small label indicating if you are watching the Last Fight or All Fights will be visible while minimized." },
	{ "MinYourDPS", "Display Your DPS While Minimized", "When checked, your DPS will be displayed in minimized view." },
	{ "MinDPSIn", "Display Total DPS In While Minimized", "When checked, the total damage per second friendly combatants received will be displayed in minimized view." },
	{ "MinDPSOut", "Display Total DPS Out While Minimized", "When checked, the total damage per second friendly combatants dealt to others will be displayed in minimized view." },
	{ "MinButtons", "Display Buttons While Minimized", "When checked, the buttons along the top-right edge (Close, Pin, Pause, Options, Last/All) will remain visible in minimized view." },
	{ "TooltipFollow", "Tooltips At Pointer", "When checked, tooltips will follow the pointer instead of using the default tooltip placement. Note: Many mods override default tooltip behavior." },
	{ "SaveFriends", "Only Save Friends", "When checked, only combatants currently marked as a friend will be saved to fight data sets.  To change the friend status of a combatant, right-click their name." },
	{ "ReplaceSet", "Replace Existing Data", "When checked, sets saved and loaded will replace existing data.  Otherwise the data will merge." },
	{ "Heal", "Display Heals", "When checked, each combatants' heals will be displayed in the list." },
	{ "Kills", "Display Deaths", "When checked, the number of deaths for each combatant will be displayed in the list." },
	{ "HideYardTrash", "Show Only Unique Combatants", "When checked, non-friendly combatants that have died more than once will be hidden.  Useful in single instance runs to hide yard trash or common mobs." },
	{ "SpamRows", "Report Rankings in Rows", "When checked, shift+click on a header with the chat bar up will post the top ten ranking in rows instead of one line, for readability at the expense of spam." },
	{ "Faction", "Display Level/Faction", "When checked, if a combatant's faction and level are known it will be displayed by their name." },
	{ "Class", "Display Class", "When checked, if a combatant's class is known its icon will be displayed by their name." },
	{ "HealP", "Display Heals %", "When checked, a percentage of total friendly heals will be displayed for each friendly combatant." },
	{ "DmgInP", "Display Damage In %", "When checked, a percentage of total friendly damage received will be displayed for each friendly combatant." },
	{ "DmgOutP", "Display Damage Out %", "When checked, a percentage of total friendly damage dealt to others will be displayed for each friendly combatant." },
	{ "AutoPost", "Auto Post Results", "When checked, a summary will be reported at the end of each fight to the channel selected below." },
	{ "MinBack", "Display Back While Minimized", "When checked, the background will remain opaque in minimized view." },
	{ "MergePets", "Merge Pets With Owners", "When checked, from that point on, all friendly pet damage will be credited to its owner.  When unchecked, from that point on, all friendly pet damage will be credited to the pet." },
	{ "AutoMinimize", "Auto Minimize", "When checked, the window will minimize automically when the pointer leaves the window, and expand when the pointer enters the window.  Holding the Shift key or selecting a combatant will override this behavior." },
	{ "ShowPanel", "Show Details", "When checked, a side panel showing more detailed information will be shown as you move the pointer over combatants.  Select a combatant to lock the panel.  In Light Data Mode, only the Summary details will be available." },
	{ "LightData", "Light Data Mode", "When checked, extra information such as misses and damage breakdowns will not be collected or stored.\n\nWhen unchecked, misses and damage details will accumulate into the Details panel.\n\nNote: For now, Personal Details will not accumulate while in Light Data Mode." },
	{ "ShowGauges", "Show Gauges", "When checked, gauges will appear behind friendly combatants for a visual indicator of damage or healing.\n\nCurrently gauges only work for damage in, damage out and healing.  To choose which gauges to use, sort by one of those three methods.\n\nYou can sort by clicking on the header above the column, ie Heal, In, Out or %." },
	{ "AutoLeader", "Auto Post New Leaders", "When checked, changes in leadership of the stat chosen below will be automatically posted to the selected channel." },
	{ "Ranks", "Numbered List", "When checked, the list will be numbered." },
	{ "DPSvsAll", "Display DPS vs All", "When checked, a DPS value will be displayed reflecting each individual's damage over the total time everyone was fighting." },
	{ "Over", "Overhealing", "When checked, an estimated overhealing percentage will be displayed per friendly combatant for All Fights.\n\nRemember: Mana-efficient healers use the slow beefy heals.  Paladins and other healers snipering small fast heals while the better heals are incoming are going to unfairly make the mana-efficient healer look worse than the mana-inefficient snipers.\n\nDo not use this as a gauge of healer capability or contribution." },
	{ "HTML", "Format in HTML", "When checked, logs written to WOWChatLog.txt or the clipboard will be formatted into a simple HTML table.  When HTML is written to WOWChatLog.txt, only up to 15 combatants are written instead of 30 due to the extra tags." },
	{ "WriteFriends", "Write Only Friends", "When checked, logs will only be written for friendly combatants." },
	{ "ETotal", "Display Totals", "When checked, the total damage or healing for each effect will be shown in personal details." },
	{ "ETotalP", "Display Total Contribution", "When checked, the contribution of this effect to the whole will be shown in personal details." },
	{ "EHits", "Display Hits", "When checked, the number of non-crit hits will be shown in personal details." },
	{ "EHitsAvg", "Display Average Hit", "When checked, the average non-crit hit will be shown in personal details." },
	{ "EHitsMax", "Display Max Hit", "When checked, the maximum non-crit hit will be shown in personal details." },
	{ "ETicks", "Display Ticks", "When checked, the number of ticks will be shown in personal details." },
	{ "ETicksAvg", "Display Average Tick", "When checked, the average tick amount will be shown in personal details." },
	{ "ETicksMax", "Display Max Tick", "When checked, the maximum tick amount will be shown in personal details." },
	{ "ECrits", "Display Crits", "When checked, the number of crits will be shown in personal details." },
	{ "ECritsAvg", "Display Average Crit", "When checked, the average crit will be shown in personal details." },
	{ "ECritsMax", "Display Max Crit", "When checked, the maximum crit will be shown in personal details." },
	{ "ECritsP", "Display Crit Rate", "When checked, the crit rate for each effect will be shown in personal details." },
	{ "EMiss", "Display Misses", "When checked, the number of misses for each effect will be shown in personal details.  For non-melee this is miss, deflects and resists.  For melee this includes block, parry and dodge." },
	{ "EMissP", "Display Miss Rate", "When checked, the miss rate for each effect will be shown in personal details." },
	{ "EMaxAll", "Display Maximum Damage", "When checked, the maximum damage from a single hit, tick or crit for each effect will be shown in personal details." },
	{ "WarnData", "Warn When Data Grows Too Large", "When checked, a message will remind you on login when your live data contains more than 500 combatants.\n\nRecap can function perfectly fine with over 500 combatants, but some users may not be aware that they are accumulating a lot of data they may not be interested in." },

	-- tooltips that don't change can go below in any order. ensure future options go above these
	{ "HeaderTime", "Fight Time", "This is the time each combatant fought from their first point of damage to their last." },
	{ "HeaderMaxHit", "Max Hit", "This is the maximum damage each combatant dealt to others in a single hit or spell." },
	{ "HeaderDmgIn", "Damage In", "This is the damage received (tanked) by each combatant." },
	{ "HeaderDmgOut", "Damage Out", "This is the damage dealt to others by each combatant." },
	{ "HeaderDPS", "Individual DPS", "This is the personal Damage Per Second dealt to others by each combatant, based on the duration from their first to last attempted point of damage." },
	{ "HeaderHeal", "Heals Out", "This is the hit points healed by this combatant." },
	{ "HeaderKills", "Death Count", "This is the number of times this combatant died within logging distance." },
	{ "Options", "Open Options", "Summon or dismiss the options window to change settings or manage fight data sets." },
	{ "TooltipMinYourDPS", "Your DPS", "This is your personal DPS, including pet." },
	{ "TooltipMinDPSIn", "DPS In", "This is the total damage received by friendly combatants." },
	{ "TooltipMinDPSOut", "DPS Out", "This is the total damage dealt to others from friendly combatants." },
	{ "AutoFadeSlider", "Auto Fade Timer", "This is the time before the window fades after you leave it if Auto Fade Window is checked." },
	{ "IdleFightSlider", "Fight Idle Timer", "This is the idle time before a fight will end if End Fight If Idle is checked." },
	{ "MinPinned", "Window Pinned", "This window is now locked to this position.  Right-click again to make it movable." },
	{ "MinUnpinned", "Window Unpinned", "This window is now unlocked and movable.  Right-click again to lock it in position." },
	{ "ExitRecap", "Exit Recap", "Fight monitoring is suspended. Click here to shut down Recap completely." },
	{ "HideWindow", "Hide Window", "Continue monitoring fights, but hide this window." },
	{ "ExpandWindow", "Expand Window", "Expand window to show fight details." },
	{ "MinimizeWindow", "Minimize Window", "Minimize window and hide fight details." },
	{ "UnPinWindow", "Unpin Window", "Allow window to be moved." },
	{ "PinWindow", "Pin Window", "Prevent window from being moved." },
	{ "Resume", "Resume Monitoring", "Fight logging is currently suspended.  Click here to start watching fights." },
	{ "PauseMonitoring", "Pause Monitoring", "Click here to stop watching fights.  If you dismiss Recap while paused, it will not attempt to log any fights until you summon it." },
	{ "ShowAllFights", "Show All Fights", "Currently the window is displaying the result of the last fight.  Click here to show all fights since last reset." },
	{ "ShowLastFight", "Show Last Fight", "Currently the window is displaying all fights since the last reset.  Click here to show only the last fight." },
	{ "CombatLast", "Combatants for Last Fight", "This is a list of all combatants that did damage in the last fight.  To change a friend status, right-click the name." },
	{ "CombatAll", "Combatants for All Fights", "This is a list of all combatants that did damage since your last reset.  The change a friend status, right-click the name." },
	{ "ResetLastFight", "Reset Last Fight", "This will wipe the fight data for just the last fight.  Note: Max hits and Overheals can only be reset by resetting All Fights." },
	{ "ResetAllTotals", "Reset All Totals", "This will wipe all active fight data for all combatants, except for those stored in Fight Data Sets and Personal Details.  Fight Data Sets can only be deleted from within options.  Personal Details can only be reset while they are visible." },
	{ "SaveSet", "Save Fight Data Set", "Click here to save the current fight data." },
	{ "LoadSet", "Load Fight Data Set", "Click here to load the selected fight data." },
	{ "DeleteSet", "Delete Fight Data Set", "Click here to delete the selected fight data set." },
	{ "DataSetEdit", "Fight Data Set Name", "Select a data set listed above or enter a new name here to create a new data set." },
	{ "OptExit", "Exit Recap", "Suspend fight monitoring and exit Recap completely."},
	{ "HeaderHealP", "% Heals", "This is the percent of total heals for each friendly combatant." },
	{ "HeaderDmgInP", "% Damage In", "This is the percent of total for each friendly combatants' damage received." },
	{ "HeaderDmgOutP", "% Damage Out", "This is the percent of total for each friendly combatants' damage dealt to others." },
	{ "OptTab1", "Display Options", "These options define what elements of the window to display in its various forms.\n\nNote: None of the display settings affect data.  You can turn off everything for normal use, and later reveal elements you want to see." },
	{ "OptTab2", "General Settings", "These options define window behavior, limits to data and miscellaneous options." },
	{ "OptTab3", "Fight Data Sets", "Here you can manage Fight Data Sets.  Fight Data Sets are compact archives of the 'All Fights' view." },
	{ "MaxRowsSlider", "Maximum Rows", "Adjust this to change the maximum rows the window can grow." },
	{ "MaxRankSlider", "Maximum Rank", "This adjusts a limit on how many combatants to report to chat." },
	{ "PanelClose", "Close Panel", "Hide this details panel.  Information will still be accumulated while this is hidden.  To stop accumulating detailed information, check 'Light Data Mode' in options." },
	{ "PanelEntry1", "Incoming Melee Damage", "This is the melee damage others dealt to this combatant." },
	{ "PanelEntry2", "Incoming Melee Rate", "This is the relative amount of melee taken compared to non-melee." },
	{ "PanelEntry3", "Incoming Melee Hits", "This is the number of non-crit hit received by others' melee." },
	{ "PanelEntry4", "Incoming Melee Hits Rate", "This is the relative amount of non-crit hits received by others' melee." },
	{ "PanelEntry5", "Incoming Melee Missed", "This is the number of times this combatant was missed from others' melee, including dodge, block and parry." },
	{ "PanelEntry6", "Incoming Melee Missed Rate", "This is the relative amount of times this combatant was missed from others' melee, include dodge, block and parry." },
	{ "PanelEntry7", "Incoming Melee Crits", "This is the number of crits received by others' melee." },
	{ "PanelEntry8", "Incoming Melee Crits Rate", "This is the relative amount of crits received by others' melee." },
	{ "PanelEntry9", "Incoming Non-Melee Damage", "This is the non-melee damage others dealt to this combatant, including physical non-melee." },
	{ "PanelEntry10", "Incoming Non-Melee Damage Rate", "This is the relative amount of non-melee damage taken compared to melee." },
	{ "PanelEntry11", "Incoming Non-Melee Hits", "This is the number of non-crit hits received by others' non-melee." },
	{ "PanelEntry12", "Incoming Non-Melee Hits Rate", "This is the relative amount of non-crit hits received by others' non-melee." },
	{ "PanelEntry13", "Incoming Non-Melee Missed", "This is the number of times this combatant resisted, deflected or was missed from others' non-melee attacks. (dodge, block, parry not included)" },
	{ "PanelEntry14", "Incoming Non-Melee Missed Rate", "This is the relative amount of times this combatant resisted, deflected or was missed from others' non-melee attacks. (dodge, block, parry not included)" },
	{ "PanelEntry15", "Incoming Non-Melee Crits", "This is the number of crits received by others' non-melee." },
	{ "PanelEntry16", "Incoming Non-Melee Crits Rate", "This is the relative amount of crits received by others' non-melee." },
	{ "PanelEntry17", "Incoming Melee Average", "This is the average melee damage received in one attack." },
	{ "PanelEntry18", "Incoming Non-Melee Average", "This is the average non-melee damage received in one attack." },
	{ "PanelEntry19", "Incoming Melee Max", "This is the maximum melee damage received in one attack." },
	{ "PanelEntry20", "Incoming Non-Melee Max", "This is the maximum non-melee damage received in one attack." },
	{ "PanelEntry21", "Incoming Melee Missed", "This is the pure melee misses from others' melee attempts." },
	{ "PanelEntry22", "Incoming Melee Dodged", "This is the pure melee dodged from others' melee attempts." },
	{ "PanelEntry23", "Incoming Melee Parried", "This is the pure melee parried from others' melee attempts." },
	{ "PanelEntry24", "Incoming Melee Blocked", "This is the pure melee blocked from others' melee attempts." },
	{ "PanelTab1", "Incoming Details: Tanking", "This panel will show information on incoming damage and misses to this combatant." },
	{ "PanelTab2", "Outgoing Details: Damage", "This panel will show information on outgoing damage and heals from this combatant." },
	{ "PanelTab3", "All Details: Summary", "This panel will show a summary of information about this combatant." },
	{ "PanelTabDisabled1", "Incoming Details: Tanking (Disabled)", "You are currently in Light Data Mode.  Tanking details are not collected.  Uncheck Light Data Mode in options to collect incoming damage and misses to each combatant." },
	{ "PanelTabDisabled2", "Incoming Details: Damage (Disabled)", "You are currently in Light Data Mode.  Damage details are not collected.  Uncheck Light Data Mode in options to collect outgoing damage details for each combatant." },
	{ "PanelEntry25", "Time (Last Fight)", "Time fighting in last fight." },
	{ "PanelEntry26", "Max Hit (Last Fight)", "Maximum hit dealt in last fight." },
	{ "PanelEntry27", "Deaths (Last Fight)", "Number of times died in last fight." },
	{ "PanelEntry28", "Heals (Last Fight)", "Total healed others in last fight." },
	{ "PanelEntry29", "Damage In (Last Fight)", "Total damage received in last fight." },
	{ "PanelEntry30", "Damage Out (Last Fight)", "Total damage dealt to others in last fight." },
	{ "PanelEntry31", "DPS (Last Fight)", "DPS for last fight." },
	{ "PanelEntry35", "Time (All Fights)", "Time fighting in all fights." },
	{ "PanelEntry36", "Max Hit (All Fights)", "Maximum hit dealt in all fights." },
	{ "PanelEntry37", "Deaths (All Fights)", "Number of times died in all fights." },
	{ "PanelEntry38", "Heals (All Fights)", "Total healed others in all fights." },
	{ "PanelEntry39", "Damage In (All Fights)", "Total damage received in all fights." },
	{ "PanelEntry40", "Damage Out (All Fights)", "Total damage dealt to others in all fights." },
	{ "PanelEntry41", "DPS (All Fights)", "DPS for all fights." },
	{ "PanelEntry45", "Total Damage", "Total damage dealt by this effect." },
	{ "PanelEntry46", "Number of Hits", "Number of times this effect landed without a crit." },
	{ "PanelEntry47", "Number of Crits", "Number of times this effect landed with a crit." },
	{ "PanelEntry48", "Average Hit", "The average non-crit damage from this effect in one attack." },
	{ "PanelEntry49", "Average Crit", "The average crit damage from this effect in one attack." },
	{ "PanelEntry50", "Max Hit", "The maximum non-crit damage from this effect in one attack." },
	{ "PanelEntry51", "Max Crit", "The maximum crit damage from this effect in one attack." },
	{ "PanelEntry52", "Misses", "The amount and percent of hits attempts that missed.  For melee this is miss, block, parry and dodge. For non-melee this is miss, resist and deflect." },
	{ "PanelEntry53", "Crit Rate", "The relative amount of crits per hits." },
	{ "PanelEntry54", "Number of Ticks", "Number of times someone suffered damage or gained health as a result of this effect." },
	{ "PanelEntry55", "Average Tick", "The average damage or healing this effect applied per tick." },
	{ "PanelEntry56", "Max Tick", "The maximum damage or healing this effect applied per tick." },
	{ "PanelEntryOverheal", "Overhealing", "This is an estimated total of hp that landed but didn't heal.  ie, a warrior at 4750/5000 life receives a heal for 1000, bringing them to 5000/5000.  750hp were overhealed: 1000hp heal minus 250hp hp applied." },
	{ "WriteLog", "Write to Log", "This will save the current combatants to a file named WOWChatLog.txt in WoW's Logs folder. It has some limitations imposed by the game:\n- Only up to 30 combatants are written.\n- Clicking this many times in a short period will disconnect you due to spam.\n-The results will only be available at the end of a session when you log out. (UI Reloads won't force a write).\n- You can write several logs and they will append to the end.\n\nFor raid results or large lists, use Write to Clipboard instead." },
	{ "UseOneSettings", "Use Global Settings", "By default, settings and combatants are saved per character.  Checking this will use the current settings and combatants across all characters.\n\nNote: Settings and combatants currently stored on other characters will be deleted.\n\nThis option has no effect on the personal effect details.  Those are always player-specific." },
	{ "MenuAdd", "Add Friend", "Add this combatant to the list of friendly combatants." },
	{ "MenuDrop", "Drop Friend", "Remove this combatant from the list of friendly combatants." },
	{ "MenuReset", "Reset Combatant", "Reset this combatant.  In All Fights view this will reset their totals and details.  In Last Fight view it will just remove the last fight from totals." },
	{ "MenuIgnore", "Ignore Combatant", "Remove this combatant and ignore future occurances until reset." },
	{ "RecapAnchorTopLeft", "Anchor Top Left", "Anchor the window to grow from the top left." },
	{ "RecapAnchorTopRight", "Anchor Top Right", "Anchor the window to grow from the top right." },
	{ "RecapAnchorBottomLeft", "Anchor Bottom Left", "Anchor the window to grow from the bottom left." },
	{ "RecapAnchorBottomRight", "Anchor Bottom Right", "Anchor the window to grow from the bottom right." },
	{ "Total", "Effects", "This is the total damage or healing this effect accumulated since last reset." },
	{ "Max", "Max Hit", "This is the maximum damage or healing this effect dealt in one attack since last reset." },
	{ "Avg", "Average Hit", "This is the average damage or healing this effect dealt in one attack since last reset." },
	{ "Crits", "Crit Rate", "This is the average crit rate of this effect since last reset." },
	{ "Miss", "Miss Rate/Overhealing", "For damage effects, this is the miss rate of the effect.  For heals, this is the overheal rate of the effect." },
	{ "Contribution", "Contribution", "This is the relative amount each effect contributed to the combatant's damage or healing." },
	{ "HeaderDPSvsAll", "DPS vs All", "This is the Damage Per Second each combatant dealt over the total duration of everyone fighting." },
	{ "HeaderOver", "Overhealing", "This is an estimated overhealing percentage per friendly combatant for All Fights.\n\nRemember: Mana-efficient healers use the slow beefy heals.  Other healers snipering small fast heals while the better heals are incoming are going to unfairly make the mana-efficient healer look worse than the mana-inefficient snipers.\n\nDo not use this as a gauge of healer capability or contribution." },
	{ "WriteClip", "Write to Clipboard", "This will copy the current combatants to a window from which you can copy to other programs like Notepad or web forums." },
	{ "ShowSelfView", "Show Personal Details", "This will display your damage and healing details in the main window." },
	{ "HideSelfView", "Hide Personal Details", "This will dismiss your personal damage and healing details and return to all combatants in the main window." },
	{ "ResetSelfView", "Reset Personal Details", "This will wipe all personal damage and healing details accumulated in this window.  Your information in the detail panel will not be affected." },
	{ "ResetEffect", "Reset Effect", "This will reset this effect only from personal details." },
	{ "HeaderEName", "Spell or Ability", "These are the effects you've used since you last reset.  Damaging effects are green, heals are blue." },
	{ "HeaderETotal", "Effect Totals", "This is the total amount of each effects' damage or heals since you last reset." },
	{ "HeaderETotalP", "Effect Contributions", "This is the contribution of each effect to the total damage or heals since you last reset." },
	{ "HeaderEMaxAll", "Max Damage or Heals", "This is the maximum damage or healing done by each effect in one hit, tick or crit." },
	{ "HeaderEHits", "Number of Hits", "This is the number of times each effect hit without a crit." },
	{ "HeaderEHitsAvg", "Average Hits", "This is the average damage or healing per non-crit hit of each effect." },
	{ "HeaderEHitsMax", "Max Hits", "This is the maximum damage or healing in a single non-crit hit of each effect." },
	{ "HeaderETicks", "Number of Ticks", "This is the number of times each effect ticked for damage or healing." },
	{ "HeaderETicksAvg", "Average Ticks", "This is the average damage or healing per tick of each effect." },
	{ "HeaderETicksMax", "Max Ticks", "This is the maximum damage or healing from a single tick of each effect." },
	{ "HeaderECrits", "Number of Crits", "This is the number of times each effect crit." },
	{ "HeaderECritsAvg", "Average Crits", "This is the average damage or healing per crit of each effect." },
	{ "HeaderECritsMax", "Max Crits", "This is the maximum damage or healing from a single crit of each effect." },
	{ "HeaderECritsP", "Crit Rates", "This is the crit rate of each effect, a percentage to crittable hits.  Ticks cannot crit and are not included." },
	{ "HeaderEMiss", "Misses", "This is the number of times each effect missed.  This includes miss, resist and deflect for non-melee, and also dodge, parry and block for melee." },
	{ "HeaderEMissP", "Miss Rates", "This is the percentage of attempted hits that missed for each effect." }
  };

-- misc localization strings
recap_temp.Local = {
    VerboseLinkStart = "%s took %s damage and dealt %s damage over %s for %s DPS (max hit %d)",
    Pronoun = "you",  -- Used when player is the recipient of damage "An orc hits you for 5"
    LastAll = { Last="Last Fight", All="All Fights" },
    LinkRank = { Time="Time Fighting", MaxHit="Max Hit", DmgIn="Damage Tanked", DmgOut="Damage Dealt", DPS="DPS", Heal="Healing", Kills="Deaths", HealP="Healing", DmgInP="Damage Tanked", DmgOutP="Damage Dealt", DPSvsAll="DPS vs All", Over="Estimated Overhealing" },
    StatusTooltip = "When this light is red, fight monitoring is suspended.\n\nWhen this light is green, a fight is currently being monitored.\n\nWhen this light is off, Recap is idle and waiting for a fight to begin.\n",
    RankUsage = "To copy a recap to chat, begin a chat and then shift+click. ie:\n|cFFAAAAFF/p (shift+click on Time)|cFFFFFFFF <- sends a ranking of times to /p\n|cFFFF8000/ra (shift+click on DPS)|cFFFFFFFF <- sends a ranking of DPS to /ra",
	ListMenu = { Add =    { "Add Friend", "Add %s", "Add %s to the list of friends." },
				 Drop =   { "Drop Friend", "Drop %s", "Remove %s from the list of friends."},
				 Reset =  { "Reset", "Reset %s", "Reset stats for %s." },
				 Ignore = { "Ignore", "Ignore %s", "Ignore %s from now until next reset." } },
	SkipChannels = { "General", "Trade", "WorldDefense", "LocalDefense", "LookingForGroup" },
	Possessive = "'s ",
	HealDetailLink = "%s's %s healed %s hp (%s of their heals)",
	DamageDetailLink = "%s's %s did %s damage (%s of their damage)",
	ConfirmLightData = "You've chosen to enable Light Data Mode.\n\nIf you accept, the UI will be reloaded to purge extraneous detail.",
	ConfirmHeavyData = "You've chosen to disable Light Data Mode.\n\nIf you accept, the UI will be reloaded to initialize detail logging.",
	LogHeader = "__ Recap generated by %s for %s on %s in %s __",
	LogFormat = "%25s ! %2s %3s !%8s !%8s %4s !%8s %4s !%8s %4s !%5s !%6s",
	Log = { "Name", "Lv","Cls", "Time", "Healing", "%%", "Tanking", "%%", "Damage", "%%", "Max", "DPS" },
	HTMLHeader = "<tr><td colspan=\"12\">Recap generated by %s for %s on %s in %s</td></tr>",
	HTMLFormat = "<tr align=\"right\"><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s<td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>",
	HTMLPrefix = "<table CELLPADDING=\"2\">",
	HTMLSuffix = "</table>",
	FailedChannel = "Failed to join channel %s.  No log created.  The most likely cause is server lag.  You can manually join %s and try again.",
	NoFreeChannels = "There are no channels free to create a log.  Leave a channel and try again.",
	LogWritten = "Recap written to WOWChatLog.txt",
	ConfirmGlobalSettings = "You've chosen to enable global settings.\n\nIf you accept, the UI will be reloaded and information specific to other characters will be lost.",
	ConfirmSeparateSettings = "You've chosen to disable global settings.\n\nIf you accept, the UI will be reloaded and other characters will store data separately.",
	SelfPronouns = { ["you"]=1, ["Euc"]=1, ["Euch"]=1, ["vous"]=1 },
	DataConvert = "|cFFFF44FFRecap: Successfuly converted data sets to 3.2.  Before:%d After:%d Change:-%d (%.1f%%)",
	MyGodStop = "WARNING: Recap is not localized.\nExpect many errors.  These are not bugs.  They are proof of lack of localization.\nRemove the folder Interface\\AddOns\\Recap to uninstall.",
	LotsOfDataWarning = "Recap has %d combatants in the \"live\" data.  This is a lot.\n\nThis message doesn't mean you are out of memory.  It's just for your information.  You can turn this warning off in Options->Settings->Data Options in Recap.\n\nTo summon Recap if you don't see it: /recap then click the Options button along the top.\n\nIf you don't want Recap to always be on and accumulate data, Pause it when not in use.\n\nFrequent use of the Reset button, Fight Data Sets and Pause will keep memory use to a minimum."
  };

BINDING_HEADER_RECAP = "Recap";

-- add local "You" and "you" if not explicitly declared
recap_temp.Local.SelfPronouns[YOU] = 1
recap_temp.Local.SelfPronouns[string.lower(YOU)] = 1

--[[ localized strings for the xml labels ]]

-- Recap.xml
RECAP_RECAP = "Recap"
RECAP_RESET = "Reset"
RECAP_COMBATANTS = "Combatants"
RECAP_DIED = "Died"
RECAP_TIME = "Time"
RECAP_HEAL = "Heal"
RECAP_IN = "In"
RECAP_OUT = "Out"
RECAP_MAX = "Max"
RECAP_DPS = "DPS"
RECAP_DPS_ALL = "DPS+"
RECAP_MISS = "Miss"


-- RecapOptions.xml : Display
RECAP_SET_NAME = "Set Name"
RECAP_SAVED = "Saved"
RECAP_RECAP_OPTIONS = "Recap Options"
RECAP_DISPLAY = "Display"
RECAP_SETTINGS = "Settings"
RECAP_DATA_SETS = "Data Sets"
RECAP_REPORTS = "Reports"
RECAP_OK = "Ok"
RECAP_EXIT = "Exit"
RECAP_DISPLAY_IN_LIST = "Display In List"
RECAP_NUMBERED_LIST = "Numbered List"
RECAP_LEVEL_FACTION = "Level/Faction"
RECAP_CLASS = "Class"
RECAP_DEATHS = "Deaths"
RECAP_HEALS = "Heals"
RECAP_HEALS_P = "Heals %"
RECAP_DAMAGE_IN = "Damage In"
RECAP_DAMAGE_IN_P = "Damage In %"
RECAP_DAMAGE_OUT = "Damage Out"
RECAP_DAMAGE_OUT_P = "Damage Out %"
RECAP_MAX_HIT = "Max Hit"
RECAP_TOTAL_DPS_IN = "Total DPS In"
RECAP_DPS_VS_ALL = "DPS vs All"
RECAP_OVERHEALING = "Overhealing"
RECAP_DISPLAY_MINIMIZED = "Display Minimized"
RECAP_STATUS_LIGHT = "Status Light"
RECAP_LAST_ALL = "Last/All"
RECAP_YOUR_DPS = "Your DPS"
RECAP_TOTAL_DPS_IN = "Total DPS In"
RECAP_TOTAL_DPS_OUT = "Total DPS Out"
RECAP_BUTTONS = "Buttons"
RECAP_BACKGROUND = "Background"
RECAP_MAXIMUM_ROWS = "Maximum Rows"
RECAP_SHOW_GAUGES = "Show Gauges"
RECAP_ANCHOR = "Anchor"
RECAP_DISPLAY_PERSONAL_DETAILS = "Personal Details"
RECAP_SELF_ETOTAL = "Total"
RECAP_SELF_ETOTALP = "Total %"
RECAP_SELF_EHITS = "Hits"
RECAP_SELF_EHITSAVG = "Avg Hit"
RECAP_SELF_EHITSMAX = "Max Hit"
RECAP_SELF_ETICKS = "Ticks"
RECAP_SELF_ETICKSAVG = "Avg Tick"
RECAP_SELF_ETICKSMAX = "Max Tick"
RECAP_SELF_ECRITS = "Crits"
RECAP_SELF_ECRITSAVG = "Avg Crit"
RECAP_SELF_ECRITSMAX = "Max Crit"
RECAP_SELF_ECRITSP = "Crit %"
RECAP_SELF_EMISS = "Misses"
RECAP_SELF_EMISSP = "Miss %"
RECAP_SELF_EMAXALL = "Max Damage"
-- RecapOptions.xml : Settings
RECAP_WINDOW_OPTIONS = "Window Options"
RECAP_USE_COLOR = "Use Color"
RECAP_SHOW_TOOLTIPS = "Show Tooltips"
RECAP_TOOLTIPS_AT_POINTER = "Tooltips at Pointer"
RECAP_SHOW_DETAILS = "Show Details"
RECAP_AUTO_HIDE_IN_COMBAT = "Auto Hide In Combat"
RECAP_AUTO_MINIMIZE = "Auto Minimize"
RECAP_AUTO_FADE_WINDOW = "Auto Fade Window"
RECAP_FIGHT_OPTIONS = "Fight Options"
RECAP_LIMIT_FIGHTS_TO_COMBAT = "Limit Fights to Combat"
RECAP_ONLY_FIGHTS_WITH_DURATION = "Only Fights With Duration"
RECAP_ONLY_FRIENDLY_COMBATANTS = "Only Friendly Combatants"
RECAP_ONLY_UNIQUE_COMBATANTS = "Only Unique Combatants"
RECAP_MERGE_PETS_WITH_OWNERS = "Merge Pets With Owners"
RECAP_END_FIGHT_IF_IDLE = "End Fight If Idle"
RECAP_DATA_OPTIONS = "Data Options"
RECAP_LIGHT_DATA_MODE = "Light Data Mode"
RECAP_USE_GLOBAL_SETTINGS = "Use Global Settings"
RECAP_WARN_DATA = "Warn On Data Growing Too Large"
-- RecapOptions.xml : Data Sets
RECAP_FIGHT_DATA_SETS = "Fight Data Sets"
RECAP_ONLY_SAVE_FRIENDLY_COMBATANTS = "Only Save Friendly Combatants"
RECAP_REPLACE_ANY_EXISTING_DATA = "Replace Any Existing Data"
RECAP_SAVE = "Save"
RECAP_LOAD = "Load"
RECAP_DELETE = "Delete"
-- RecapOptions.xml : Reports
RECAP_FIGHT_REPORTING = "Fight Reporting"
RECAP_REPORT_RANKS_IN_MULTIPLE_ROWS = "Report in Multiple Rows (Shift+Click and Autopost)"
RECAP_AUTOMATICALLY_POST_RANKS_AFTER_EACH_FIGHT = "Automatically Post Ranks After Each Fight"
RECAP_REPORT = "Report:"
RECAP_TO = "To:"
RECAP_AUTOMATICALLY_POST_CHANGES_IN_LEADERSHIP = "Automatically Post Changes in Leadership"
RECAP_SAVE_TO_WOWCHATLOG_TXT = "Write to WOWChatLog.txt"
-- RecapOptions.xml : Clipboard
RECAP_CLIP_EXPLANATION = "Press CTRL+C to copy the selected text to the clipboard.\nThen go to another window like Notepad or a web forum and CTRL+V to paste it there.  Hit ESC or click Ok when done."
RECAP_CHANNEL_JOINED_WRITING = "Channel joined. Writing..."
RECAP_ACQUIRING_CHANNEL = "Acquiring channel..."
RECAP_SAVE_TO_CLIPBOARD_TXT = "Write to Clipboard"
RECAP_FORMAT_IN_HTML = "Format in HTML"
RECAP_WRITE_ONLY_FRIENDLY = "Write Only Friendly Combatants"

-- RecapPanel.xml
RECAP_INCOMING = "Incoming"
RECAP_DAMAGE = "Damage"
RECAP_HITS = "Hits"
RECAP_MISSED = "Missed"
RECAP_CRITS = "Crits"
RECAP_AVERAGE = "Average"
RECAP_MELEE = "Melee"
RECAP_NON_MELEE = "Non-Melee"
RECAP_INCOMING_MELEE_MISSED_DETAIL = "Incoming Melee Missed Detail"
RECAP_MISSED = "Missed"
RECAP_DODGED = "Dodged"
RECAP_PARRIED = "Parried"
RECAP_BLOCKED = "Blocked"
RECAP_SPELL_OR_ABILITY = "Spell or Ability"
RECAP_TOTAL = "Total"
RECAP_MISSES = "Misses"
RECAP_AVG = "Avg"
RECAP_CRIT_P = "Crit%"
RECAP_SUMMARY = "Summary"
RECAP_LAST_FIGHT = "Last Fight"
RECAP_ALL_FIGHTS = "All Fights"
RECAP_DMG_IN = "Dmg In"
RECAP_DMG_OUT = "Dmg Out"
RECAP_TICKS = "Ticks"

--[[ -------- DO NOT LOCALIZE THE FOLLOWING SECTION --------- ]]

--[[ Defaults ]]

recap_temp.DefaultOpt = {
		-- window state settings
		["View"] = 				{ type="Button", value="All" },
		["SelfView"] =			{ type="Flag", value=false },
		["SortBy"] =			{ type="Flag", value="Name" },
		["SortDir"] =			{ type="Flag", value=true },
		["State"] =				{ type="Flag", value="Idle" },
		["Visible"] =			{ type="Flag", value=true },
		["Minimized"] = 		{ type="Button", value=false },
		["Pinned"] = 			{ type="Button", value=false },
		["Paused"] =			{ type="Button", value=false },
		["PanelView"] =			{ type="Flag", value=1 }, -- current panel tab
		["PanelDetail"] =		{ type="Flag", value="Total" }, -- chosen detail stat column
		["PanelAnchor"] =		{ type="Flag", value=false, Main="TOPLEFT", Panel="TOPRIGHT" };
		["GrowUpwards"] =		{ type="Flag", value=false },
		["GrowLeftwards"] =		{ type="Flag", value=true },
		-- user settings options
		["UseColor"] =			{ type="Check", value=true },
		["ShowTooltips"]=		{ type="Check", value=true },
		["TooltipFollow"] =		{ type="Check", value=false },
		["AutoHide"] =			{ type="Check", value=false },
		["AutoFade"] =			{ type="Check", value=false },
		["AutoFadeTimer"] =		{ type="Slider", value=5 },
		["LimitFights"] =		{ type="Check", value=false },
		["HideZero"] =			{ type="Check", value=false },
		["HideFoe"] = 			{ type="Check", value=false },
		["HideYardTrash"] = 	{ type="Check", value=false },
		["MergePets"] =			{ type="Check", value=false },
		["IdleFight"] =			{ type="Check", value=true },
		["IdleFightTimer"] = 	{ type="Slider", value=15 },
		["MaxRows"] =			{ type="Slider", value=10 },
		["AutoMinimize"] =		{ type="Check", value=false },
		["ShowPanel"] =			{ type="Check", value=true },
		["ShowGauges"] =		{ type="Check", value=true },
		["LightData"] =			{ type="Check", value=false },
		["AutoLeader"] =		{ type="Check", value=false },
		["HTML"] =				{ type="Check", value=false },
		["WriteFriends"] =		{ type="Check", value=false },
		["WarnData"] =			{ type="Check", value=true },
		-- fight reporting
		["SpamRows"] = 			{ type="Check", value=false },
		["MaxRank"] =			{ type="Slider", value=5 },
		["AutoPost"] =			{ type="Check", value=false, Channel="Self", Stat="DPS" },
		-- fight data sets
		["SaveFriends"] = 		{ type="Check", value=false },
		["ReplaceSet"] = 		{ type="Check", value=true },
		-- list elements
		["Ranks"] =				{ type="Check", value=false, width=20 },
		["Faction"] = 			{ type="Check", value=false, width=14 },
		["Class"] = 			{ type="Check", value=true, width=14 },
		["Kills"] =				{ type="Check", value=false, width=28 },
		["Time"] = 				{ type="Check", value=true, width=45 },
		["Heal"] =				{ type="Check", value=false, width=62 },
		["HealP"] =				{ type="Check", value=false, width=32 },
		["Over"] =				{ type="Check", value=false, width=32 },
		["DmgIn"] = 			{ type="Check", value=true, width=62 },
		["DmgInP"] =			{ type="Check", value=false, width=32 },
		["DmgOut"] =			{ type="Check", value=true, width=62 },
		["DmgOutP"] =			{ type="Check", value=false, width=32 },
		["MaxHit"] = 			{ type="Check", value=true, width=34 },
		["DPS"] = 				{ type="Check", value=true, width=45 },
		["DPSIn"] = 			{ type="Check", value=true },
		["DPSvsAll"] =			{ type="Check", value=false, width=45 },
		-- minimized elements
		["MinStatus"] = 		{ type="Check", value=true, minwidth=16 },
		["MinView"] = 			{ type="Check", value=false, minwidth=35 },
		["MinYourDPS"] = 		{ type="Check", value=true, minwidth=45 },
		["MinDPSIn"] = 			{ type="Check", value=false, minwidth=45 },
		["MinDPSOut"] = 		{ type="Check", value=false, minwidth=45 },
		["MinButtons"] = 		{ type="Check", value=false },
		["MinBack"] =			{ type="Check", value=true },
		-- person details elements
		["ETotal"] =			{ type="Check", value=true, ewidth=62 },
		["ETotalP"] =			{ type="Check", value=true, ewidth=32 },
		["EMaxAll"] =			{ type="Check", value=true, ewidth=35 },
		["EHits"] =				{ type="Check", value=false, ewidth=45 },
		["EHitsAvg"] =			{ type="Check", value=false, ewidth=35 },
		["EHitsMax"] =			{ type="Check", value=false, ewidth=35 },
		["ETicks"] =			{ type="Check", value=false, ewidth=45 },
		["ETicksAvg"] =			{ type="Check", value=false, ewidth=35 },
		["ETicksMax"] =			{ type="Check", value=false, ewidth=35 },
		["ECrits"] =			{ type="Check", value=false, ewidth=45 },
		["ECritsAvg"] =			{ type="Check", value=false, ewidth=35 },
		["ECritsMax"] =			{ type="Check", value=false, ewidth=35 },
		["ECritsP"] =			{ type="Check", value=true, ewidth=40 },
		["EMiss"] =				{ type="Check", value=false, ewidth=45 },
		["EMissP"] =			{ type="Check", value=true, ewidth=40 }
};

recap_temp.DefaultDetails = {
		Hits = 0,
		HitsDmg = 0,
		HitsMax = 0,
		Crits = 0,
		CritsEvents = 0, -- crit candidates
		CritDmg = 0,
		CritsMax = 0,
		Mitigated = 0,
		Missed = 0,
		Immune = 0
}

--[[ Misc variables ]]

recap_temp.Loaded = false;
recap_temp.Player = nil;
recap_temp.Server = nil;
recap_temp.p = nil;
recap_temp.Last = {}; -- last fight indexed by name
recap_temp.List = {}; -- constructed display list, numerically indexed
recap_temp.ListSize = 0; -- number of .List values
recap_temp.SelfList = {}; -- list for damage breakdown
recap_temp.SelfListSize = 0;
recap_temp.FightStart = 0; -- time fight started
recap_temp.FightEnd = 0; -- time fight ended
recap_temp.IdleTimer = -1; -- 0+ = time since last hit happened
recap_temp.FadeTimer = -1; -- 0+ = time since left window
recap_temp.UpdateTimer = 0; -- 0+ = time since last window update
recap_temp.ColorDmgIn =  { r=0.90, g=0.25, b=0.25 };
recap_temp.ColorDmgOut = { r=0.25, g=0.90, b=0.25 };
recap_temp.ColorHeal =	 { r=0.50, g=0.75, b=1.00 };
recap_temp.ColorGreen =  { r=0.25, g=0.90, b=0.25 };
recap_temp.ColorRed =    { r=0.90, g=0.25, b=0.25 };
recap_temp.ColorWhite =  { r=0.85, g=0.85, b=0.85 };
recap_temp.ColorBlue =	 { r=0.25, g=0.75, b=1.00 };
recap_temp.ColorNone =   { r=1.00, g=0.82, b=0.00 };
recap_temp.ColorCyan =   { r=0.65, g=1.00, b=1.00 };
recap_temp.ColorYellow = { r=1.00, g=1.00, b=0.65 };
recap_temp.ColorLime =   { r=0.65, g=1.00, b=0.65 };
recap_temp.ColorPink =   { r=1.00, g=0.65, b=1.00 };
recap_temp.FightSets = {}; -- list of fight data sets
recap_temp.FightSetsSize = 1; -- size of fight list
recap_temp.FightSetSelected = 0;
recap_temp.FilterIndex = {}; -- list to hold filter finds
recap_temp.MinTime = 0.9; -- threshhold to calculate DPS (still accumulates time)
recap_temp.UpdateDuration = 0; -- minimized update total time
recap_temp.UpdateDmgIn = 0; -- minimized update total dmg in
recap_temp.UpdateDmgOut =0; -- minimized update total dmg out
recap_temp.Selected = 0; -- index in .List of currently selected combatant, 0 for none
recap_temp.DetailSelected = 0; -- index in .Detail of currently selected detail, 0 for none
recap_temp.GaugeWidth = 100; -- max width of gauges
recap_temp.GaugeMax = 0; -- highest value from which gauges are adjusted
recap_temp.GaugeBy = nil -- "DmgInP" "DmgOutP" or "HealP"
recap_temp.Leader = nil -- name of current stat leader
recap_temp.MaxLogLines = 30; -- maximum number of lines to write to log
recap_temp.Writing = false; -- whether we are currently writing to WOWChatLog.txt

-- context menus, used by RecapCreateMenu()
recap_temp.ColumnMenu = { {Text="Numbered List",Info="Ranks"}, {Text="Level/Faction",Info="Faction"}, {Text="Class",Info="Class"}, { Text="Deaths",Info="Kills"},
						  {Text="Time",Info="Time"}, {Text="Heal",Info="Heal"}, { Text="Heal %",Info="HealP"}, {Text="Overheal",Info="Over"},
						  {Text="Damage In",Info="DmgIn"}, {Text="Damage In %",Info="DmgInP"}, {Text="Damage Out",Info="DmgOut"},
						  {Text="Damage Out %",Info="DmgOutP"}, {Text="Max Hit",Info="MaxHit"}, {Text="DPS",Info="DPS"},
						  {Text="DPS vs All",Info="DPSvsAll"}, {Text="Total DPS In",Info="DPSIn"} };
recap_temp.MinMenu = { {Text="Lock Window", Info="Pin"}, {Text="Status Light",Info="MinStatus"}, {Text="Last/All",Info="MinView"},
					   {Text="Your DPS",Info="MinYourDPS"}, {Text="Total DPS In",Info="MinDPSIn"}, {Text="Total DPS Out",Info="MinDPSOut"},
					   {Text="Buttons",Info="MinButtons"}, {Text="Background",Info="MinBack"} };
recap_temp.AddMenu = { {Text="Add Friend",Info="MenuAdd"}, {Text="Reset",Info="MenuReset"}, {Text="Ignore",Info="MenuIgnore"} };
recap_temp.DropMenu = { {Text="Drop Friend",Info="MenuDrop"}, {Text="Reset",Info="MenuReset"}, {Text="Ignore",Info="MenuIgnore"} };
recap_temp.DetailMenu = { {Text="Total Damage",Info="Total"}, {Text="Average Hit",Info="Avg"}, {Text="Max Hit",Info="Max"}, {Text="Crit Rate",Info="Crits"}, {Text="Miss/Overheal",Info="Miss"} };
recap_temp.Menu = recap_temp.ColumnMenu; -- current dropdown menu
recap_temp.EffectMenu = { {Text="Reset Effect",Info="ResetEffect"} }
recap_temp.EffectOptMenu = { {Text="Total",Info="ETotal"}, {Text="Total %",Info="ETotalP"}, {Text="Max Dmg",Info="EMaxAll"},
							 {Text="Hits",Info="EHits"}, {Text="Avg Hit",Info="EHitsAvg"}, {Text="Max Hit",Info="EHitsMax"},
							 {Text="Ticks",Info="ETicks"}, {Text="Avg Tick",Info="ETicksAvg"}, {Text="Max Tick",Info="ETicksMax"},
							 {Text="Crits",Info="ECrits"}, {Text="Avg Crit",Info="ECritsAvg"}, {Text="Max Crit",Info="ECritsMax"},
							 {Text="Crit Rate",Info="ECritsP"}, {Text="Misses",Info="EMiss"}, {Text="Miss Rate",Info="EMissP"} }


recap_temp.ClassIcons = {
	["WARRIOR"] = { left=0.025, right=0.225, top=0.025, bottom=0.225 },
	["MAGE"] = { left=0.275, right=0.475, top=0.025, bottom=0.225 },
	["ROGUE"] = { left=0.525, right=0.725, top=0.025, bottom=0.225 },
	["DRUID"] = { left=0.775, right=0.975, top=0.025, bottom=0.225 },
	["HUNTER"] = { left=0.025, right=0.225, top=0.275, bottom=0.475 },
	["SHAMAN"] = { left=0.275, right=0.475, top=0.275, bottom=0.475 },
	["PRIEST"] = { left=0.525, right=0.725, top=0.275, bottom=0.475 },
	["WARLOCK"] = { left=0.775, right=0.975, top=0.275, bottom=0.475 },
	["PALADIN"] = { left=0.025, right=0.225, top=0.525, bottom=0.725 },
	["Pet"] = { left=0.275, right=0.475, top=0.525, bottom=0.725 }
};

recap_temp.FactionIcons = {
	["Alliance"] = "Interface\\TargetingFrame\\UI-PVP-Alliance",
	["Horde"] = "Interface\\TargetingFrame\\UI-PVP-Horde"
};

-- auto-post drop down choices
recap_temp.StatDropList = {	"DPS", "Damage", "Tanking", "Healing" };
recap_temp.ChannelDropList = { "Self", "Party", "Say", "Raid", "Guild" }; 

-- to help keep saved sets from bloat, commonly used strings will be replaced
-- with indexes to this table.  The indexes need to remain in this order.  Add
-- new keys to the end.
recap_temp.Keys = {
	"Alliance", "Horde",
	"WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER",
	"SHAMAN", "PRIEST", "WARLOCK", "PALADIN", "Pet"
}

-- converts string.format to a string.find pattern: "%s hits %s for %d." to "(.+) hits (.+) for (%d+)"
local function Recap_Localize(filter)

	local i,k,field,idx;

	for i in filter do
		filter[i].pattern = string.gsub(filter[i].pattern,"%.$",""); -- strip trailing .
		filter[i].pattern = string.gsub(filter[i].pattern,"%%s","(.+)"); -- %s to (.+)
		filter[i].pattern = string.gsub(filter[i].pattern,"%%d","(%%d+)"); -- %d to (%d+)
		if string.find(filter[i].pattern,"%$") then
			-- entries need reordered, ie: SPELLMISSOTHEROTHER = "%2$s von %1$s verfehlt %3$s.";

			field = {}; -- fills with ordered list of $s as they appear
			idx = 1; -- incremental index into field[]

			for k in string.gfind(filter[i].pattern,"%%(%d)%$.") do
				field[idx] = k;
				idx = idx + 1
			end
			for k in filter[i] do
				if tonumber(filter[i][k]) and tonumber(filter[i][k])<6 then
					filter[i][k] = tonumber(field[filter[i][k]])
				end
			end

			filter[i].pattern = string.gsub(filter[i].pattern,"%%%d%$s","(.+)");
			filter[i].pattern = string.gsub(filter[i].pattern,"%%%d%$d","(%%d+)");
		end
	
	end

end

-- convert GlobalString patterns to string.find-usable patterns for all filters
Recap_Localize(recap_temp.Filter)
Recap_Localize(recap_temp.HealFilter)
Recap_Localize(recap_temp.DeathFilter)

if ((GetLocale()=="frFR") or (GetLocale()=="deDE")) and UIErrorsFrame then
	UIErrorsFrame:AddMessage(recap_temp.Local.MyGodStop)
end

