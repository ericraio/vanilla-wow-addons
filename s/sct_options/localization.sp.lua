-- SCT localization information
-- Spanish Locale
-- Translation by JSR1976

if GetLocale() ~= "spSP" then return end

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "Daño", tooltipText = "Activa o desactiva daño melee y varios. (fuego, caida, etc...)"};
SCT.LOCALS.OPTION_EVENT2 = {name = "Fallos", tooltipText = "Activa o desactiva fallos melee"};
SCT.LOCALS.OPTION_EVENT3 = {name = "Regates", tooltipText = "Activa o desactiva los regates melee"};
SCT.LOCALS.OPTION_EVENT4 = {name = "Parries", tooltipText = "Activa o desactiva melee parries"};
SCT.LOCALS.OPTION_EVENT5 = {name = "Bloqueos", tooltipText = "Activa o desactiva los bloqueos melee o los bloqueos parciales melee"};
SCT.LOCALS.OPTION_EVENT6 = {name = "Daño Hechizos", tooltipText = "Activa o desactiva el daño de hechizos"};
SCT.LOCALS.OPTION_EVENT7 = {name = "Hecizos Curativos", tooltipText = "Activa o desactiva los hechizos curativos"};
SCT.LOCALS.OPTION_EVENT8 = {name = "Resistencia Hechizos", tooltipText = "Activa o desactiva la Resistencia a hechizos"};
SCT.LOCALS.OPTION_EVENT9 = {name = "Debuffs", tooltipText = "Activa o desactiva mostrar cuando tienes debuffs"};
SCT.LOCALS.OPTION_EVENT10 = {name = "Absorber", tooltipText = "Activa o desactiva mostrar el daño absorbido de monstruos"};
SCT.LOCALS.OPTION_EVENT11 = {name = "Salud Baja", tooltipText = "Activa o desactiva mostrar cuando tengas salud baja"};
SCT.LOCALS.OPTION_EVENT12 = {name = "Mana Bajo", tooltipText = "Activa o desactiva mostrar cuando tienes el mana bajo"};
SCT.LOCALS.OPTION_EVENT13 = {name = "Ganando Poder", tooltipText = "active o desactiva mostrar cuando ganas Mana, Furia o Energia de pociones, objetos, buffs, etc...(No regeneraciñn regular)"};
SCT.LOCALS.OPTION_EVENT14 = {name = "Coletillas Combate", tooltipText = "Activa o desactiva mostrar cuando entras o sales de combate"};
SCT.LOCALS.OPTION_EVENT15 = {name = "Puntos Combo", tooltipText = "Activa o desactiva mostrar cuando ganas puntos de combo"};
SCT.LOCALS.OPTION_EVENT16 = {name = "Honor Ganado", tooltipText = "Activa o desactiva mostrar cuando ganas Puntos de contribucion de Honor"};
SCT.LOCALS.OPTION_EVENT17 = {name = "Buffs", tooltipText = "Activa o desactiva mostrar cuando ganas bufss"};
SCT.LOCALS.OPTION_EVENT18 = {name = "Buff Fades", tooltipText = "Activa o desactiva mostrar cuando pierdes buffs"};
SCT.LOCALS.OPTION_EVENT19 = {name = "Ejecuta/Cólera", tooltipText = "Activa o desactiva alerter cuando Ejecutar o Martillo de Cólera (Guerrero/Paladin solo)"};
SCT.LOCALS.OPTION_EVENT20 = {name = "Reputación", tooltipText = "Activa o desactiva mostrar cuando ganas o pierdes reputación"};
SCT.LOCALS.OPTION_EVENT21 = {name = "Tus Curas", tooltipText = "Activa o desactiva mostrar cuando curas a otros por"};
SCT.LOCALS.OPTION_EVENT22 = {name = "Habilidades", tooltipText = "Activa o desactiva mostrar cuando ganas puntos de habilidades"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "Activa Scrolling Combat Text", tooltipText = "Activa o desactiva Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK2 = { name = "Coletilla Texto Combate", tooltipText = "Activa o desactiva poner un * alrededor de todos all Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK3 = { name = "Muestra Curadores", tooltipText = "Activa o desactiva quien o que te cura."};
SCT.LOCALS.OPTION_CHECK4 = { name = "Scroll Texto Abajo", tooltipText = "Activa o desactiva scrolling texto hacia abajo"};
SCT.LOCALS.OPTION_CHECK5 = { name = "Sticky Crits", tooltipText = "Activa o desactiva poner golpes/curas criticas sobre tu cabeza"};
SCT.LOCALS.OPTION_CHECK6 = { name = "Tipo Daño Hechizo", tooltipText = "Activa o desactiva mostrar tipo daño de hechizo"};
SCT.LOCALS.OPTION_CHECK7 = { name = "Aplica Letra a Daño", tooltipText = "Activa o desactiva cambiar la letra de daño del juego por la letra usada por SCT .\n\nIMPORTANTE: TIENES QUE SALIR Y VOLVER A ENTRAR PARA QUE FUNCIONE. RECARGANDO EL UI NO FUNCIONARA"};
SCT.LOCALS.OPTION_CHECK8 = { name = "Show all Power Gain", tooltipText = "Enables or Disables showing all power gain, not just those from the chat log\n\nNOTE: This is dependent on the regular Power Gain event being on, is VERY SPAMMY, and sometimes acts strange for Druids just after shapeshifting back to caster form."};
SCT.LOCALS.OPTION_CHECK9 = { name = "FPS Independent Mode", tooltipText = "Enables or Disables making the animation speed use your FPS or not. When on, makes the animations more consistent and greatly speeds them up on slow machines or in laggy situations."};
SCT.LOCALS.OPTION_CHECK10 = { name = "Show Overhealing", tooltipText = "Enables or Disables showing how much you overheal for against you or your targets. Dependent on 'Your Heals' being on."};
SCT.LOCALS.OPTION_CHECK11 = { name = "Alert Sounds", tooltipText = "Enables or Disables playing sounds for warning alerts."};
SCT.LOCALS.OPTION_CHECK12 = { name = "Spell Damage Colors", tooltipText = "Enables or Disables showing spell damage in colors per spell class (colors not configurable)"};
SCT.LOCALS.OPTION_CHECK13 = { name = "Enable Custom Events", tooltipText = "Enables or Disables using custom events. When disabled, much less memory is consumed by SCT."};
SCT.LOCALS.OPTION_CHECK14 = { name = "Enable Light Mode", tooltipText = "Enables or Disables SCT Light Mode. Light mode uses built in WoW Events for most SCT events and reduces combat log parsing. This means faster performance overall, but at a cost of a few features, including Custom Events.\n\nPLEASE be aware these WoW events do not provide as much feedback as the combat log and can be BUGGY."};
SCT.LOCALS.OPTION_CHECK15 = { name = "Flash", tooltipText = "Makes sticky crits 'Flash' into view."};
SCT.LOCALS.OPTION_SLIDER13 = { name="Healer Filter", minText="0", maxText="500", tooltipText = "Controls the minimum amount a heal needs to heal you for to appear in SCT. Good for filtering out frequent small heals like Totems, Blessings, etc..."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="Velocidad Animación Texto", minText="Rapido", maxText="Lento", tooltipText = "Controla la velocidad de la animacion del texto"};
SCT.LOCALS.OPTION_SLIDER2 = { name="Tamaóo Texto", minText="Pequeóo", maxText="Grande", tooltipText = "Controla el tamaóo del texto"};
SCT.LOCALS.OPTION_SLIDER3 = { name="HP %", minText="10%", maxText="90%", tooltipText = "Controla el % de salud necesario para dar aviso"};
SCT.LOCALS.OPTION_SLIDER4 = { name="Mana %",  minText="10%", maxText="90%", tooltipText = "Controla el % de mana necesario para dar aviso"};
SCT.LOCALS.OPTION_SLIDER5 = { name="Opacidad Texto", minText="0%", maxText="100%", tooltipText = "Controla la opcaidad del texto"};
SCT.LOCALS.OPTION_SLIDER6 = { name="Distancia Movimiento Texto", minText="Pequeóo", maxText="Grande", tooltipText = "Controla la distancia de movimiento entre cada actualización de texto"};
SCT.LOCALS.OPTION_SLIDER7 = { name="Centro Posición X Texto", minText="-600", maxText="600", tooltipText = "Controla el emplazamiento del centro del texto"};
SCT.LOCALS.OPTION_SLIDER8 = { name="Centro Posición Y Texto", minText="-400", maxText="400", tooltipText = "Controla el emplazamiento del centro del texto"};
SCT.LOCALS.OPTION_SLIDER9 = { name="Centro Posición X Mensajes", minText="-600", maxText="600", tooltipText = "Controla el emplazamiento de los mensaje de texto"};
SCT.LOCALS.OPTION_SLIDER10 = { name="Centro Posición Y Mensajes", minText="-400", maxText="400", tooltipText = "Controla el emplazamiento de los mensajes de texto"};
SCT.LOCALS.OPTION_SLIDER11 = { name="Velocidad Mensajes Fade", minText="Rapido", maxText="Lento", tooltipText = "Controla la velocidad de los mensajes fade"};
SCT.LOCALS.OPTION_SLIDER12 = { name="Tamaño Mensajes", minText="Pequeño", maxText="Grande", tooltipText = "Controla el tamaño de los mensajes de texto"};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="SCT Opciones "..SCT.Version};
SCT.LOCALS.OPTION_MISC2 = {name="Opciones Eventos"};
SCT.LOCALS.OPTION_MISC3 = {name="Opciones Texto"};
SCT.LOCALS.OPTION_MISC4 = {name="Opciones Varios"};
SCT.LOCALS.OPTION_MISC5 = {name="Opciones Avisos"};
SCT.LOCALS.OPTION_MISC6 = {name="Opciones Animación"};
SCT.LOCALS.OPTION_MISC7 = {name="Selecciona Archivo"};
SCT.LOCALS.OPTION_MISC8 = {name="Guarda y Cierra", tooltipText = "Guarda todos los ajustes actuales y cierra las opciones"};
SCT.LOCALS.OPTION_MISC9 = {name="Resetea", tooltipText = "-Aviso-\n\nEstas seguro de querer resetear el SCT por defecto?"};
SCT.LOCALS.OPTION_MISC10 = {name="Selecciona", tooltipText = "Selecciona otros archive de personaje"};
SCT.LOCALS.OPTION_MISC11 = {name="Carga", tooltipText = "Carga otro archive de personaje"};
SCT.LOCALS.OPTION_MISC12 = {name="Borra", tooltipText = "Borra archive personaje"}; 
SCT.LOCALS.OPTION_MISC13 = {name="Cancela", tooltipText = "Cancela Selección"};
SCT.LOCALS.OPTION_MISC14 = {name="Texto", tooltipText = ""};
SCT.LOCALS.OPTION_MISC15 = {name="Mensajes", tooltipText = ""};
SCT.LOCALS.OPTION_MISC16 = {name="Opciones Mensaje"};
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
SCT.LOCALS.OPTION_SELECTION1 = { name="Tipo Animación", tooltipText = "Que tipo de animación usar", table = {[1] = "Vertical (Normal)",[2] = "Arcoiris",[3] = "Horizontal",[4] = "Angled Down", [5] = "Angled Up", [6] = "Sprinkler"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="Estilo Lateral", tooltipText = "Como mostrar el lado scrolling texto", table = {[1] = "Alternando",[2] = "Daño Izq.",[3] = "Daño Dcha."}};
SCT.LOCALS.OPTION_SELECTION3 = { name="Letra", tooltipText = "Que letra usar", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION4 = { name="Controno Letra", tooltipText = "Que contorno letra usar", table = {[1] = "Ninguno",[2] = "Fino",[3] = "Grueso"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="Letra Mensaje", tooltipText = "Que letra usar para mensajes", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION6 = { name="Controno Letra Mensajes", tooltipText = "Que contorno de letra usar para mensajes", table = {[1] = "Ninguno",[2] = "Fino",[3] = "Grueso"}};
