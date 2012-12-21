--
-- EquipCompare localization information
--
-- Contents:
-- * Localized versions of item names that are not available by default from Blizzard
-- * Usage information
-- * Slash command feedback texts
-- * Khaos/Cosmos labels and information
-- * Miscellaneous labels
--
-- Supported languages:
-- English, French, German, Korean, Simplified Chinese, Traditional Chinese
--
-- Non-english localizations are placed in seperate files.
--

-- Version ID
EQUIPCOMPARE_VERSIONID = "2.9.7";

-- "Bonus" inventory types
-- WARNING: these lines must match the text displayed by the client exactly.
-- Can't use arbitrary phrases. Edit and translate with care.
EQUIPCOMPARE_INVTYPE_WAND = "Wand";
EQUIPCOMPARE_INVTYPE_GUN = "Gun";
EQUIPCOMPARE_INVTYPE_GUNPROJECTILE = "Projectile";
EQUIPCOMPARE_INVTYPE_BOWPROJECTILE = "Projectile";
EQUIPCOMPARE_INVTYPE_CROSSBOW = "Crossbow";
EQUIPCOMPARE_INVTYPE_THROWN = "Thrown";

-- Usage text
EQUIPCOMPARE_USAGE_TEXT = { "EquipCompare "..EQUIPCOMPARE_VERSIONID.." Usage:",
						  	"Hover over items to compare them easily with ones you have equipped.",
						  	"Slash Commands:",
						  	"/eqc          - toggle EquipCompare on/off",
						  	"/eqc [on|off] - turn EquipCompare on|off",
						  	"/eqc control  - toggle Control key mode on/off",
						  	"/eqc cv       - toggle integration with CharactersViewer",
						  	"/eqc alt      - toggle Alt key mode on/off",
							"/eqc shift    - toggle shifting tooltips up when too tall",
						  	"/eqc help     - this text",
						  	"(You can use /equipcompare instead of /eqc)" }

-- Feedback text
EQUIPCOMPARE_HELPTIP = "(Type /equipcompare help for usage)";
EQUIPCOMPARE_TOGGLE_ON = "EquipCompare is now enabled.";
EQUIPCOMPARE_TOGGLE_OFF = "EquipCompare is now disabled.";
EQUIPCOMPARE_TOGGLECONTROL_ON = "EquipCompare Ctrl mode enabled.";
EQUIPCOMPARE_TOGGLECONTROL_OFF = "EquipCompare Ctrl mode disabled.";
EQUIPCOMPARE_TOGGLECV_ON = "EquipCompare integration with CharactersViewer enabled.";
EQUIPCOMPARE_TOGGLECV_OFF = "EquipCompare integration with CharactersViewer disabled.";
EQUIPCOMPARE_TOGGLEALT_ON = "EquipCompare Alt mode enabled.";
EQUIPCOMPARE_TOGGLEALT_OFF = "EquipCompare Alt mode disabled.";
EQUIPCOMPARE_SHIFTUP_ON = "EquipCompare shifting tooltips up.";
EQUIPCOMPARE_SHIFTUP_OFF = "EquipCompare not shifting tooltips up.";

-- Cosmos configuration texts
EQUIPCOMPARE_COSMOS_SECTION = "EquipCompare";
EQUIPCOMPARE_COSMOS_SECTION_INFO = "Options for Equipment Comparison tooltips.";
EQUIPCOMPARE_COSMOS_HEADER = "EquipCompare "..EQUIPCOMPARE_VERSIONID;
EQUIPCOMPARE_COSMOS_HEADER_INFO = "Options for Equipment Comparison tooltips.";
EQUIPCOMPARE_COSMOS_ENABLE = "Enable Equipment Comparison tooltips";
EQUIPCOMPARE_COSMOS_ENABLE_INFO = "By enabling this option you get extra tooltips when hovering "..
								  "over items, showing the statistics of the corresponding "..
								  "currently equipped item.";
EQUIPCOMPARE_COSMOS_CONTROLMODE = "Enable Control key mode";
EQUIPCOMPARE_COSMOS_CONTROLMODE_INFO = "By enabling this option you get the extra "..
										"tooltips only whilst holding the Control key down.";
EQUIPCOMPARE_COSMOS_CVMODE = "Enable integration with CharactersViewer (if present)";
EQUIPCOMPARE_COSMOS_CVMODE_INFO = "If enabled, the comparison tooltips show the inventory of the "..
										"character selected in CharactersViewer, instead of the "..
										"player's inventory.";
EQUIPCOMPARE_COSMOS_ALTMODE = "Enable Alt key mode for CharactersViewer";
EQUIPCOMPARE_COSMOS_ALTMODE_INFO = "If enabled, you get comparison tooltips for the "..
										"character selected in CharactersViewer only if you "..
										"hold the Alt key down.";
EQUIPCOMPARE_COSMOS_SHIFTUP = "Shift comparison tooltips up if necessary"
EQUIPCOMPARE_COSMOS_SHIFTUP_INFO = "If enabled, the comparison tooltips will be shifted "..
										"upwards if their bottom would go below the bottom "..
										"of the main tooltip.";
EQUIPCOMPARE_COSMOS_SLASH_DESC = "Allows you to turn EquipCompare on and off. Type /equipcompare help for usage."

-- Misc labels
EQUIPCOMPARE_EQUIPPED_LABEL = "Currently Equipped";
EQUIPCOMPARE_GREETING = "EquipCompare "..EQUIPCOMPARE_VERSIONID.." Loaded. Enjoy.";
