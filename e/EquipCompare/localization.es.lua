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
-- English, French, German, Spanish
--
-- French and German localization are placed in seperate files.
--

-- Version ID
EQUIPCOMPARE_VERSIONID = "2.9.5";

-- "Bonus" inventory types
-- WARNING: these lines must match the text displayed by the client exactly.
-- Can't use arbitrary phrases. Edit and translate with care.
EQUIPCOMPARE_INVTYPE_WAND = "Barita";
EQUIPCOMPARE_INVTYPE_GUN = "Pistola";
EQUIPCOMPARE_INVTYPE_GUNPROJECTILE = "Proyectil";
EQUIPCOMPARE_INVTYPE_BOWPROJECTILE = "Proyectil";
EQUIPCOMPARE_INVTYPE_CROSSBOW = "Bayesta";
EQUIPCOMPARE_INVTYPE_THROWN = "Arma a distancia";

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
EQUIPCOMPARE_TOGGLE_ON = "EquipCompare esta ahora habilitado.";
EQUIPCOMPARE_TOGGLE_OFF = "EquipCompare esta ahora deshabilitado.";
EQUIPCOMPARE_TOGGLECONTROL_ON = "EquipCompare modo Ctrl habilitado.";
EQUIPCOMPARE_TOGGLECONTROL_OFF = "EquipCompare modo Ctrl deshabilitado.";
EQUIPCOMPARE_TOGGLECV_ON = "EquipCompare integrado con CharactersViewer habilitado.";
EQUIPCOMPARE_TOGGLECV_OFF = "EquipCompare integrado con CharactersViewer deshabilitado.";
EQUIPCOMPARE_TOGGLEALT_ON = "EquipCompare modo Alt habilitado.";
EQUIPCOMPARE_TOGGLEALT_OFF = "EquipCompare modo Alt deshabilitado.";
EQUIPCOMPARE_SHIFTUP_ON = "EquipCompare shifting tooltips up.";
EQUIPCOMPARE_SHIFTUP_OFF = "EquipCompare not shifting tooltips up.";

-- Cosmos configuration texts
EQUIPCOMPARE_COSMOS_SECTION = "EquipCompare";
EQUIPCOMPARE_COSMOS_SECTION_INFO = "Opciones para herramientas de comparacion de equipos.";
EQUIPCOMPARE_COSMOS_HEADER = "EquipCompare "..EQUIPCOMPARE_VERSIONID;
EQUIPCOMPARE_COSMOS_HEADER_INFO = "Opciones para herramientas de comparacion de equipos.";
EQUIPCOMPARE_COSMOS_ENABLE = "Habilitadas herramientas de comparacion de equipos";
EQUIPCOMPARE_COSMOS_ENABLE_INFO = "Esta habilitada esta opcion para obtener extra de herramientas"..
								  "sobre objetos, proyectar las estadisticas correspondientes"..
								  "actualmente equipado.";
EQUIPCOMPARE_COSMOS_CONTROLMODE = "Habilitado control del teclado";
EQUIPCOMPARE_COSMOS_CONTROLMODE_INFO = "Esta habilitada esta opcion para obtenter el extra "..
										"tooltips only whilst holding the Control key down.";
EQUIPCOMPARE_COSMOS_CVMODE = "Habilitar integracion con CharactersViewer (if present)";
EQUIPCOMPARE_COSMOS_CVMODE_INFO = "Si se habilita, Las herramientas de comparacion se muestran en el inventario del "..
										"caracter seleccionado en CharactersViewer, instalado en el "..
										"inventorio del jugador.";
EQUIPCOMPARE_COSMOS_ALTMODE = "habilitado modo Alt para CharactersViewer";
EQUIPCOMPARE_COSMOS_ALTMODE_INFO = "Si se habilita, obtienes las herramientas de comparacion para el "..
										"caracter seleccionado en CharactersViewer solo si tu "..
										"hold the Alt key down.";
EQUIPCOMPARE_COSMOS_SHIFTUP = "Shift comparison tooltips up if necessary"
EQUIPCOMPARE_COSMOS_SHIFTUP_INFO = "If enabled, the comparison tooltips will be shifted "..
										"upwards if their bottom would go below the bottom "..
										"of the main tooltip.";
EQUIPCOMPARE_COSMOS_SLASH_DESC = "Allows you to turn EquipCompare on and off. Type /equipcompare help for usage."

-- Misc labels
EQUIPCOMPARE_EQUIPPED_LABEL = "Actualmente equipado";
EQUIPCOMPARE_GREETING = "EquipCompare "..EQUIPCOMPARE_VERSIONID.." Loaded. Enjoy.";
