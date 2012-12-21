
--Event and Damage option values
SCT.LOCALS.OPTION_EVENT101 = {name = "Melee Damage", tooltipText = "Enables or Disables showing your melee damage"};
SCT.LOCALS.OPTION_EVENT102 = {name = "Periodic Damage", tooltipText = "Enables or Disables showing your periodic damage"};
SCT.LOCALS.OPTION_EVENT103 = {name = "Spell/Skill Damage", tooltipText = "Enables or Disables showing your spell/skill damage"};
SCT.LOCALS.OPTION_EVENT104 = {name = "Pet Damage", tooltipText = "Enables or Disables showing your pet's damage"};
SCT.LOCALS.OPTION_EVENT105 = {name = "Color Crits", tooltipText = "Enables or Disables making your crits the selected color"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK101 = { name = "Enable SCTD", tooltipText = "Enables or Disables SCT - Damage"};
SCT.LOCALS.OPTION_CHECK102 = { name = "Flag Damage", tooltipText = "Enables or Disables placing a * around all damage"};
SCT.LOCALS.OPTION_CHECK103 = { name = "Spell Type", tooltipText = "Enables or Disables showing spell damage type"};
SCT.LOCALS.OPTION_CHECK104 = { name = "Spell Name", tooltipText = "Enables or Disables showing the spell/skill name"};
SCT.LOCALS.OPTION_CHECK105 = { name = "Resists", tooltipText = "Enables or Disables showing your resisted damage"};
SCT.LOCALS.OPTION_CHECK106 = { name = "Target Name", tooltipText = "Enables or Disables showing the targets name"};
SCT.LOCALS.OPTION_CHECK107 = { name = "Disable WoW Damage", tooltipText = "Enables or Disables showing the built in WoW target damage.\n\nNOTE: This is the exact same as the check boxes under the Advanced Options in Interface Options. You have more control over it there."};
SCT.LOCALS.OPTION_CHECK108 = { name = "Only Target", tooltipText = "Enables or Disables showing damage done to your current target only. AE effects are not shown, unless multiple targets have the same name."};
SCT.LOCALS.OPTION_CHECK109 = { name = "Enable During PVP", tooltipText = "Enables WoW Damage and turns off SCTD during PvP. Probably not useful on PvP Servers."};
SCT.LOCALS.OPTION_CHECK110 = { name = "Use SCT Animation", tooltipText = "Enables using SCT animation instead of the message style text"};
SCT.LOCALS.OPTION_CHECK111 = { name = "Sticky Crit", tooltipText = "Enables using having critical hits stick. When off, crits display with +1236+, etc.. "};
SCT.LOCALS.OPTION_CHECK112 = { name = "Spell Color", tooltipText = "Enables or Disables showing spell damage in colors per spell class (colors not configurable)"};
SCT.LOCALS.OPTION_CHECK113 = { name = "Damage Text Down", tooltipText = "Enables or Disables scrolling text downwards"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER101 = { name="Center X Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the text center"};
SCT.LOCALS.OPTION_SLIDER102 = { name="Center Y Position", minText="-400", maxText="400", tooltipText = "Controls the placement of the text center"};
SCT.LOCALS.OPTION_SLIDER103 = { name="Fade Speed", minText="Faster", maxText="Slower", tooltipText = "Controls the speed that messages fade"};
SCT.LOCALS.OPTION_SLIDER104 = { name="Font Size", minText="Smaller", maxText="Larger", tooltipText = "Controls the size of the text"};
SCT.LOCALS.OPTION_SLIDER105 = { name="Opacity", minText="0%", maxText="100%", tooltipText = "Controls the opacity of the text"};

--Misc option values
SCT.LOCALS.OPTION_MISC101 = {name="SCTD Options "..SCTD.Version};
SCT.LOCALS.OPTION_MISC102 = {name="Close", tooltipText = "Saves all current settings and close the options"};
SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "Open SCT - Damage option menu"};
SCT.LOCALS.OPTION_MISC104 = {name="Damage Events", tooltipText = ""};
SCT.LOCALS.OPTION_MISC105 = {name="Display Options", tooltipText = ""};
SCT.LOCALS.OPTION_MISC106 = {name="Frame Options", tooltipText = ""};

--Animation Types
SCT.LOCALS.OPTION_SELECTION101 = { name="Damage Font", tooltipText = "What font to use for messages", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION102 = { name="Damage Font Outline", tooltipText = "What font outline to use for messages", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};
SCT.LOCALS.OPTION_SELECTION103 = { name="Damage Animation Type", tooltipText = "Which animation type to use.", table = {[1] = "Vertical (Normal)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down",[5] = "Angled Up",[6] = "Sprinkler"}};
SCT.LOCALS.OPTION_SELECTION104 = { name="Damage Side Style", tooltipText = "How side scrolling text should display", table = {[1] = "Alternating",[2] = "Damage Left",[3] = "Damage Right", [4] = "All Left", [5] = "All Right"}};
