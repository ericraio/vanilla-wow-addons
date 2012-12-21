
--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "Damage", tooltipText = "Enables or Disables melee and misc. (fire, fall, etc...) damage"};
SCT.LOCALS.OPTION_EVENT2 = {name = "Misses", tooltipText = "Enables or Disables melee misses"};
SCT.LOCALS.OPTION_EVENT3 = {name = "Dodges", tooltipText = "Enables or Disables melee dodges"};
SCT.LOCALS.OPTION_EVENT4 = {name = "Parries", tooltipText = "Enables or Disables melee parries"};
SCT.LOCALS.OPTION_EVENT5 = {name = "Blocks", tooltipText = "Enables or Disables melee blocks and partial blocks"};
SCT.LOCALS.OPTION_EVENT6 = {name = "Spell Damage", tooltipText = "Enables or Disables spell damage"};
SCT.LOCALS.OPTION_EVENT7 = {name = "Spell Heals", tooltipText = "Enables or Disables spell heals"};
SCT.LOCALS.OPTION_EVENT8 = {name = "Spell Resists", tooltipText = "Enables or Disables spell resists"};
SCT.LOCALS.OPTION_EVENT9 = {name = "Debuffs", tooltipText = "Enables or Disables showing when you get debuffs"};
SCT.LOCALS.OPTION_EVENT10 = {name = "Absorb/Misc", tooltipText = "Enables or Disables showing when damage is absorbed, reflected, immune, etc..."};
SCT.LOCALS.OPTION_EVENT11 = {name = "Low HP", tooltipText = "Enables or Disables showing when you have low health"};
SCT.LOCALS.OPTION_EVENT12 = {name = "Low Mana", tooltipText = "Enables or Disables showing when you have low mana"};
SCT.LOCALS.OPTION_EVENT13 = {name = "Power Gains", tooltipText = "Enables or Disables showing when you gain Mana, Rage, Energy from potions, items, buffs, etc...(Not regular regen)"};
SCT.LOCALS.OPTION_EVENT14 = {name = "Combat Flags", tooltipText = "Enables or Disables showing when you enter or leave combat"};
SCT.LOCALS.OPTION_EVENT15 = {name = "Combo Points", tooltipText = "Enables or Disables showing when you gain combo points"};
SCT.LOCALS.OPTION_EVENT16 = {name = "Honor Gain", tooltipText = "Enables or Disables showing when you gain Honor Contribution points"};
SCT.LOCALS.OPTION_EVENT17 = {name = "Buffs", tooltipText = "Enables or Disables showing when you gain buffs"};
SCT.LOCALS.OPTION_EVENT18 = {name = "Buff Fades", tooltipText = "Enables or Disables showing when you lose buffs"};
SCT.LOCALS.OPTION_EVENT19 = {name = "Active Skills", tooltipText = "Enables or Disables alerting when a skill becomes active (Execute, Mongoose Bite, Hammer of Wrath, etc...)"};
SCT.LOCALS.OPTION_EVENT20 = {name = "Reputation", tooltipText = "Enables or Disables showing when you gain or lose Reputation"};
SCT.LOCALS.OPTION_EVENT21 = {name = "Your Heals", tooltipText = "Enables or Disables showing how much you heal others for"};
SCT.LOCALS.OPTION_EVENT22 = {name = "Skills", tooltipText = "Enables or Disables showing when you gain Skill points"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "Enable Scrolling Combat Text", tooltipText = "Enables or Disables the Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK2 = { name = "Flag Combat Text", tooltipText = "Enables or Disables placing a * around all Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK3 = { name = "Show Healers", tooltipText = "Enables or Disables showing who or what heals you."};
SCT.LOCALS.OPTION_CHECK4 = { name = "Scroll Text Down", tooltipText = "Enables or Disables scrolling text downwards"};
SCT.LOCALS.OPTION_CHECK5 = { name = "Sticky Crits", tooltipText = "Enables or Disables having critical hits/heals stick above your head"};
SCT.LOCALS.OPTION_CHECK6 = { name = "Spell Damage Type", tooltipText = "Enables or Disables showing spell damage type"};
SCT.LOCALS.OPTION_CHECK7 = { name = "Apply Font to Damage", tooltipText = "Enables or Disables changing the in game damage font to match the font used for SCT Text.\n\nIMPORTANT: YOU MUST LOG OUT AND BACK IN FOR THIS TO TAKE EFFECT. RELOADING THE UI WON'T WORK"};
SCT.LOCALS.OPTION_CHECK8 = { name = "Show all Power Gain", tooltipText = "Enables or Disables showing all power gain, not just those from the chat log\n\nNOTE: This is dependent on the regular Power Gain event being on, is VERY SPAMMY, and sometimes acts strange for Druids just after shapeshifting back to caster form."};
SCT.LOCALS.OPTION_CHECK9 = { name = "FPS Independent Mode", tooltipText = "Enables or Disables making the animation speed use your FPS or not. When on, makes the animations more consistent and greatly speeds them up on slow machines or in laggy situations."};
SCT.LOCALS.OPTION_CHECK10 = { name = "Show Overhealing", tooltipText = "Enables or Disables showing how much you overheal for against you or your targets. Dependent on 'Your Heals' being on."};
SCT.LOCALS.OPTION_CHECK11 = { name = "Alert Sounds", tooltipText = "Enables or Disables playing sounds for warning alerts."};
SCT.LOCALS.OPTION_CHECK12 = { name = "Spell Damage Colors", tooltipText = "Enables or Disables showing spell damage in colors per spell class (colors not configurable)"};
SCT.LOCALS.OPTION_CHECK13 = { name = "Enable Custom Events", tooltipText = "Enables or Disables using custom events. When disabled, much less memory is consumed by SCT."};
SCT.LOCALS.OPTION_CHECK14 = { name = "Enable Light Mode", tooltipText = "Enables or Disables SCT Light Mode. Light mode uses built in WoW Events for most SCT events and reduces combat log parsing. This means faster performance overall, but at a cost of a few features, including Custom Events.\n\nPLEASE be aware these WoW events do not provide as much feedback as the combat log and can be BUGGY."};
SCT.LOCALS.OPTION_CHECK15 = { name = "Flash", tooltipText = "Makes sticky crits 'Flash' into view."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="Text Animation Speed", minText="Faster", maxText="Slower", tooltipText = "Controls the speed at which the text animation scrolls"};
SCT.LOCALS.OPTION_SLIDER2 = { name="Text Size", minText="Smaller", maxText="Larger", tooltipText = "Controls the size of the scrolling text"};
SCT.LOCALS.OPTION_SLIDER3 = { name="HP %", minText="10%", maxText="90%", tooltipText = "Controls the % of health needed to give a warning"};
SCT.LOCALS.OPTION_SLIDER4 = { name="Mana %",  minText="10%", maxText="90%", tooltipText = "Controls the % of mana needed to give a warning"};
SCT.LOCALS.OPTION_SLIDER5 = { name="Text Opacity", minText="0%", maxText="100%", tooltipText = "Controls the opacity of the text"};
SCT.LOCALS.OPTION_SLIDER6 = { name="Text Movement Distance", minText="Smaller", maxText="Larger", tooltipText = "Controls the movement distance of the text between each update"};
SCT.LOCALS.OPTION_SLIDER7 = { name="Text Center X Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the text center"};
SCT.LOCALS.OPTION_SLIDER8 = { name="Text Center Y Position", minText="-400", maxText="400", tooltipText = "Controls the placement of the text center"};
SCT.LOCALS.OPTION_SLIDER9 = { name="Message Center X Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the message center"};
SCT.LOCALS.OPTION_SLIDER10 = { name="Message Center Y Position", minText="-400", maxText="400", tooltipText = "Controls the placement of the message center"};
SCT.LOCALS.OPTION_SLIDER11 = { name="Message Fade Speed", minText="Faster", maxText="Slower", tooltipText = "Controls the speed that messages fade"};
SCT.LOCALS.OPTION_SLIDER12 = { name="Message Size", minText="Smaller", maxText="Larger", tooltipText = "Controls the size of the message text"};
SCT.LOCALS.OPTION_SLIDER13 = { name="Healer Filter", minText="0", maxText="500", tooltipText = "Controls the minimum amount a heal needs to heal you for to appear in SCT. Good for filtering out frequent small heals like Totems, Blessings, etc..."};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="SCT Options "..SCT.Version, tooltipText = "Left Click to Drag"};
SCT.LOCALS.OPTION_MISC2 = {name="Event Options"};
SCT.LOCALS.OPTION_MISC3 = {name="Frame 1 Options"};
SCT.LOCALS.OPTION_MISC4 = {name="Misc. Options"};
SCT.LOCALS.OPTION_MISC5 = {name="Warning Options"};
SCT.LOCALS.OPTION_MISC6 = {name="Animation Options"};
SCT.LOCALS.OPTION_MISC7 = {name="Select Player Profile"};
SCT.LOCALS.OPTION_MISC8 = {name="Save & Close", tooltipText = "Saves all current settings and close the options"};
SCT.LOCALS.OPTION_MISC9 = {name="Reset", tooltipText = "-Warning-\n\nAre you sure you want to reset SCT to defaults?"};
SCT.LOCALS.OPTION_MISC10 = {name="Profiles", tooltipText = "Select another characters profile"};
SCT.LOCALS.OPTION_MISC11 = {name="Load", tooltipText = "Load another characters profile for this character"};
SCT.LOCALS.OPTION_MISC12 = {name="Delete", tooltipText = "Delete a characters profile"}; 
SCT.LOCALS.OPTION_MISC13 = {name="Cancel", tooltipText = "Cancel Selection"};
SCT.LOCALS.OPTION_MISC14 = {name="Frame 1", tooltipText = ""};
SCT.LOCALS.OPTION_MISC15 = {name="Messages", tooltipText = ""};
SCT.LOCALS.OPTION_MISC16 = {name="Message Options"};
SCT.LOCALS.OPTION_MISC17 = {name="Spell Options"};
SCT.LOCALS.OPTION_MISC18 = {name="Misc.", tooltipText = ""};
SCT.LOCALS.OPTION_MISC19 = {name="Spells", tooltipText = ""};
SCT.LOCALS.OPTION_MISC20 = {name="Frame 2", tooltipText = ""};
SCT.LOCALS.OPTION_MISC21 = {name="Frame 2 Options", tooltipText = ""};
SCT.LOCALS.OPTION_MISC22 = {name="Classic Profile", tooltipText = "Load the Classic profile. Makes SCT act very close to how it used to by default"};
SCT.LOCALS.OPTION_MISC23 = {name="Performance Profile", tooltipText = "Load the Performance profile. Selects all the settings to get the best performance out of SCT"};
SCT.LOCALS.OPTION_MISC24 = {name="Split Profile", tooltipText = "Load the Split profile. Makes Incoming damage and events appear on the right side, and Incoming heals and buffs on the left side."};
SCT.LOCALS.OPTION_MISC25 = {name="Grayhoof Profile", tooltipText = "Load Grayhoof's profile. Sets SCT to act how Grayhoof sets his."};
SCT.LOCALS.OPTION_MISC26 = {name="Built In Profiles", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="Split SCTD Profile", tooltipText = "Load Split SCTD profile. If you have SCTD installed, makes Incoming events appear on the right side, and Outgoing events appear on the left side, and misc appear on top."};

--Animation Types
SCT.LOCALS.OPTION_SELECTION1 = { name="Animation Type", tooltipText = "Which animation type to use", table = {[1] = "Vertical (Normal)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down", [5] = "Angled Up", [6] = "Sprinkler"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="Side Style", tooltipText = "How side scrolling text should display", table = {[1] = "Alternating",[2] = "Damage Left",[3] = "Damage Right", [4] = "All Left", [5] = "All Right"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="Font", tooltipText = "What font to use", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION4 = { name="Font Outline", tooltipText = "What font outline to use", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="Message Font", tooltipText = "What font to use for messages", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION6 = { name="Message Font Outline", tooltipText = "What font outline to use for messages", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};
