--
-- Spanish localization for MobInfo2
--
-- Spanish version of WoW does not yet exist. Therefore the "GetLocale()"
-- mechanism can not yet be used.
--

-- to enable Spanish remove the comment tag (ie. the "--") from the NEXT line
--ENABLE_SPANISH = true


if ENABLE_SPANISH then
-- if ( GetLocale() == "esES" ) then

MI_DESCRIPTION = "Añade informacion sobre mobs para el tooltip y añade la informacion salud/mana al marco del objetivo";

MI_MOB_DIES_WITH_XP = "(.+) muere, ganas (%d+) experiencia";
MI_MOB_DIES_WITHOUT_XP = "(.+) muere";
MI_PARSE_SPELL_DMG = "(.+) de (.+) te golpea por (%d+)";
MI_PARSE_BOW_DMG = "(.+) de (.+) te golpea por (%d+)";
MI_PARSE_COMBAT_DMG = "(.+) te golpea por (%d+)";
MI_PARSE_SELF_MELEE = "Golpeas (.+) por (%d+)";
MI_PARSE_SELF_MELEE_CRIT = "Ataque critico a (.+) por (%d+)";
MI_PARSE_SELF_SPELL = "Tu (.+) golpea a (.+) por (%d+)";
MI_PARSE_SELF_SPELL_CRIT = "Tu (.+) hace critico a (.+) por (%d+)";
MI_PARSE_SELF_BOW = "Tus(.+) golpean a (.+) por (%d+)";
MI_PARSE_SELF_BOW_CRIT = "Tus (.+) hacen critico a (.+) por (%d+)";
MI_PARSE_SELF_PET = "(.+) golpea (.+) por (%d+)";
MI_PARSE_SELF_PET_CRIT = "(.+) hace critico (.+) por (%d+)";
MI_PARSE_SELF_PET_SPELL = "(.+) de (.+) golpea a (.+) por (%d+)";
MI_PARSE_SELF_PET_SPELL_CRIT = "(.+) de (.+) hace critico a (.+) por (%d+)";
MI_PARSE_SELF_SPELL_PERIODIC = "(.+) sufre (%d+) (.+) de daño hacia tu (.+)";

MI_TXT_GOLD   = " Oro";
MI_TXT_SILVER = " Plata";
MI_TXT_COPPER = " Bronce";

MI_TXT_CONFIG_TITLE		= "Opciones de MobInfo 2 ";
MI_TXT_WELCOME          = "Bienvenido a MobInfo 2";
MI_TXT_OPEN				= "Abrir";
MI_TXT_CLASS			= "Clase ";
MI_TXT_HEALTH			= "Salud ";
MI_TXT_MANA				= "Mana ";
MI_TXT_XP				= "XP ";
MI_TXT_KILLS			= "Muertes ";
MI_TXT_DAMAGE			= "Daño + [DPS] ";
MI_TXT_TIMES_LOOTED		= "Saqueado veces ";
MI_TXT_EMPTY_LOOTS		= "Saqueos vacios ";
MI_TXT_TO_LEVEL			= "# para nivel";
MI_TXT_QUALITY			= "Calidad ";
MI_TXT_CLOTH_DROP		= "Ropa recogida ";
MI_TXT_COIN_DROP		= "Mejor dinero ";
MI_TEXT_ITEM_VALUE		= "Mejor valor de objeto ";
MI_TXT_MOB_VALUE		= "Valor total de Mob ";
MI_TXT_COMBINED			= "Combinado: ";
MI_TXT_MOB_DB_SIZE		= "Tamaño base de datos de MobInfo2:  ";
MI_TXT_HEALTH_DB_SIZE	= "Tamaño base de datos de Salud:  ";
MI_TXT_PLAYER_DB_SIZE	= "Tamaño base de datos de Salud de jugador:  ";
MI_TXT_ITEM_DB_SIZE		= "Tamaño base de datos de objetos:  ";
MI_TXT_CUR_TARGET		= "Actual objetivo:  ";
MI_TXT_MH_DISABLED		= "MobInfo ADVERTENCIA: Encontrado el AddOn MobHealth separado. El MobHealth interno se ha desactivado hasta que se borre el MobHealth separado.";
MI_TXT_MH_DISABLED2		= (MI_TXT_MH_DISABLED.."\n\n No vas a perder tus datos por activar MobHealth.\n\nBeneficios: salud/mana movibles y adaptados fuente y tamaño");
MI_TXT_CLR_ALL_CONFIRM	= "Realmente quieres borrar la siguiente operacion?: ";
MI_TXT_SEARCH_LEVEL		= "Nivel Mob:";
MI_TXT_SEARCH_MOBTYPE	= "Tipo de Mob:";
MI_TXT_SEARCH_LOOTS		= "Saqueo Mob:";
MI_TXT_TRIM_DOWN_CONFIRM = "ADVERTENCIA: este es un inmediato y permanente borrado. De veras quieres realizar el borrado?"
MI_TXT_CLAM_MEAT		= "Clam Meat"
MI_TXT_SHOWING			= "Muestra lista: "
MI_TXT_DROPPED_BY		= "Saqueado por "
MI_TXT_LOCATION			= "Localización: "
BINDING_HEADER_MI2HEADER	= "MobInfo 2"
BINDING_NAME_MI2CONFIG	= "Abrir opciones de MobInfo2"

MI2_FRAME_TEXTS = {};
MI2_FRAME_TEXTS["MI2_FrmTooltipOptions"]	= "Opciones cuadro de texto de Mob";
MI2_FRAME_TEXTS["MI2_FrmHealthOptions"]		= "Opciones de MobHealth";
MI2_FRAME_TEXTS["MI2_FrmDatabaseOptions"]	= "Opciones de Base de Datos";
MI2_FRAME_TEXTS["MI2_FrmHealthValueOptions"]= "Valor de Salud";
MI2_FRAME_TEXTS["MI2_FrmManaValueOptions"]	= "Valor de Mana";
MI2_FRAME_TEXTS["MI2_FrmSearchOptions"]		= "Opciones de busqueda";
MI2_FRAME_TEXTS["MI2_FrmSearchLevel"]		= "Nivel del Mob";
MI2_FRAME_TEXTS["MI2_FrmItemTooltip"]		= "Opciones Cuadro de Texto de Objeto";
MI2_FRAME_TEXTS["MI2_FrmImportDatabase"]	= ">>>Import External MobInfo Database"

--
-- This section defines all buttons in the options dialog
--   text : the text displayed on the button
--  help : the (short) one line help text for the button
--   info : additional multi line info text for button
--      info is displayed in the help tooltip below the "help" line
--      info is optional and can be omitted if not required
--

MI2_OPTIONS = {};

MI2_OPTIONS["MI2_OptSearchMinLevel"] = 
{ text = "Min"; help = "nivel minimo mob para opciones de busqueda"; }

MI2_OPTIONS["MI2_OptSearchMaxLevel"] = 
{ text = "Max"; help = "nivel maximo mob para opciones de busqueda (debe ser < 66)"; }

MI2_OPTIONS["MI2_OptSearchNormal"] = 
{ text = "Normal"; help = "incluye mobs de tipo normal en los resultados de la busqueda"; }

MI2_OPTIONS["MI2_OptSearchElite"] = 
{ text = "Elite"; help = "incluye mobs de tipo elite en los resultados de la busqueda"; }

MI2_OPTIONS["MI2_OptSearchBoss"] = 
{ text = "Jefazo"; help = "incluye mobs jefazos en los resultados de la busqueda"; }

MI2_OPTIONS["MI2_OptSearchMinLoots"] = 
{ text = "Min"; help = "numero minimo de veces que se ha saqueado un mob"; }

MI2_OPTIONS["MI2_OptSearchMobName"] = 
{ text = "Nombre Mob"; help = "nombre completo o parcial para buscar";
info = 'Leave empty to not retrict search to specific items\nEntering "*" selects all items.'; }

MI2_OPTIONS["MI2_OptSearchItemName"] = 
{ text = "Nombre objeto"; help = "nombre completo o parcial del objeto a buscar";
info = 'leave empty to search for all item names'; }

MI2_OPTIONS["MI2_OptSortByValue"] = 
{ text = "Por recompensa"; help = "Clasifica los resultados de busqueda por recompensa";
info = 'Sort the mobs by the profit you can make from killing them.'; }

MI2_OPTIONS["MI2_OptSortByItem"] = 
{ text = "Por objetos"; help = "Clasifica los resultados de busqueda por numero de veces que se cuenta el objeto";
info = 'Sort the Mobs by how many of the specified item(s) they drop.'; }

MI2_OPTIONS["MI2_OptItemTooltip"] = 
{ text = "Mostrar mobs en cuadro de texto"; help = "Muestra los nombres de los que arrojan un objeto en cuadro de texto del objeto";
info = "Muestra el nombre de todos los Mobs que han arrojado multitude objetos\nen el cuadro dialogo del objeto. Por cada objeto lista la cantidad\narrojada por el Mob con porcentajes." }

MI2_OPTIONS["MI2_OptCompactMode"] = 
{ text = "Compactar Cuadro de Texto"; help = "Activa un cuadro de de texto compacto que dispone de 2 valores por linea en el cuadro de texto";
info = "Compactar tooltip uses short abbreviated texts for the tooltip desriptions.\nTo disable a tolltip line both entries on that line must be disabled." }

MI2_OPTIONS["MI2_OptDisableMobInfo"] = 
{ text = "Desactivar info"; help = "Desactiva mostrar Mob info en el Cuadro de Texto";
info = "Desactivar toda la informacion sobre Mobs." }

MI2_OPTIONS["MI2_OptShowClass"] = 
{ text = "Mostrar clases"; help = "Muestra la clase del Mob"; }

MI2_OPTIONS["MI2_OptShowHealth"] = 
{ text = "Vida"; help = "Muestra info de la vida del mob (actual/max)"; }

MI2_OPTIONS["MI2_OptShowMana"] = 
{ text = "Mana"; help = "Muestra mana/furia/energ�-a info del Mob (actual/max)"; }

MI2_OPTIONS["MI2_OptShowXp"] = 
{ text = "Exp"; help = "Muestra el numero de puntos de experiencia que obtuviste de este";
info = "Esta es la ultima y actual experiencia que te dio el mob.\n(no se muestran los Mobs que son grises para ti)" }

MI2_OPTIONS["MI2_OptShowNo2lev"] = 
{ text = "Numero para nivel"; help = "Muestra el numero de muertes necesarias para subir un nivel";
info = "Este te indica cuantas veces tienes que matar al\nmismo Mob recien matado para alcanzar el siguiente nivel\n(no se muestran los Mobs que son grises para ti)" }

MI2_OPTIONS["MI2_OptShowDamage"] = 
{ text = "Mostrar Daño / DPS"; help = "Muestra rango de daño Mob (Min/Max) y DPS (daño por segundo)"; 
info = "Rango de daño y DPS es calculado y separado separada mente por personaje.\nDPS se actualizan y guardan lentamente después de cada pelea." }

MI2_OPTIONS["MI2_OptShowCombined"] = 
{ text = "Mostrar Info Combinada"; help = "Muestra en modo mensaje combinado en el Cuadro de Texto";
info = ">>>Show a mesage in the tooltip indicating that combined mode\nis active and listing all mob levels that have been combined\ninto one tooltip." }

MI2_OPTIONS["MI2_OptShowKills"] = 
{ text = "Muertes"; help = "Muestra el numero de veces que matastaste al Mob";
info = "The kill count is calculated and stored\nseparately per char." }

MI2_OPTIONS["MI2_OptShowLoots"] = 
{ text = "Total de Saqueos"; help = ">>>Show number of times a Mob has been looted"; }

MI2_OPTIONS["MI2_OptShowCloth"] = 
{ text = "Cogida de ropa"; help = "Muestra cuantas veces has obtenido ropa en el saqueo"; }

MI2_OPTIONS["MI2_OptShowEmpty"] = 
{ text = "Saqueos vacios"; help = ">>>Show number of empty corpses found (num/percent)";
info = "Este contador se incrementa cuando abres\n un cuerpo que no tiene nada." }

MI2_OPTIONS["MI2_OptShowTotal"] = 
{ text = "Valor total"; help = "Muestra mayor valor total de Mob";
info = "Esta es la suma del dinero y \ny el valor de objetos." }

MI2_OPTIONS["MI2_OptShowCoin"] = 
{ text = "Mayor Dinero"; help = "Muestra la mejor moneda arrojada por Mob";
info = "El valor total de moneda es acumulado y dividido\npor el contador de saqueos.\n(no se muestra si el valor de moneda es 0)" }

MI2_OPTIONS["MI2_OptShowIV"] = 
{ text = "Mayor valor de objeto"; help = "Muestra el mayor valor de objeto de Mob";
info = "El valor total de objetos es acumulable\npor el contador de saqueo.\n(no se muestra con valor 0)" }

MI2_OPTIONS["MI2_OptShowQuality"] = 
{ text = "Calidad del saqueo"; help = "Muestra la calidad del saqueo y porcentaje";
info = "Esto cuenta cuantos objetos de las 5 categorias de calidad\nte ha dado un Mob al saquearlo. Categorias con 0 arrojado no\nse muestran. El porcentaje es la posibilidad de conseguir\nun objeto de un monstruo de la rareza especifica como saqueo." }

MI2_OPTIONS["MI2_OptShowLocation"] = 
{ text = "Mostrar localizacion"; help = "Muestra la localizacion de donde esta el Mob";
info = "Guardar datos debe ser ACTIVADO para que funcione."; }

MI2_OPTIONS["MI2_OptShowItems"] = 
{ text = "Detalles del saqueo"; help = "Muestra nombre y cantidad de los objetos del saqueo";
info = "Guardar datos de objetos saqueo debe estar ACTIVADO para que funcione"; }

MI2_OPTIONS["MI2_OptShowClothSkin"] = 
{ text = "Cloth and Skinning Loot"; help = ">>>Show names and amount of all cloth and skinning loot items";
info = ">>>Recording loot item data must be ENABLED for this to work"; }

MI2_OPTIONS["MI2_OptSaveItems"] = 
{ text = "Guardar calidad de objetos del Mob:"; help = "Habilita esto para guardar detalles de objetos de saqueo de Mobs.";
info = "Puedes elegir el nivel de la calidad de objetos para guardar"; }

MI2_OPTIONS["MI2_OptShowBlankLines"] = 
{ text = "Mostrar lineas blancas"; help = "Muestra lineas en blanco en el Cuadro de Texto";
info = "Las lineas en blanco se introducen para mejorar la lectura \ncreando secciones en el Cuadro de Texto" }

MI2_OPTIONS["MI2_OptCombinedMode"] = 
{ text = "Combinar mobs iguales"; help = "Combina datos para Mob con el mismo nombre";
info = "Combina de modo que acumulara los datos para Mobs\ncon el mismo nombre pero de diferente nivel. Cuando esta activo un\nindicador se muestra en Cuadro de Texto" }

MI2_OPTIONS["MI2_OptKeypressMode"] = 
{ text = "Presionar ALT para MobInfo"; help = "Solo se muestra MobInfo en Cuadro de Texto cuando pulsas la tecla ALT"; }

MI2_OPTIONS["MI2_OptItemFilter"] = 
{ text = "Filtrar saqueo de Objetos"; help = "Establece filtrado de expresión para objetos saqueados en Cuadros de Textos";
info = "Sirve para hacer un filtro. Por ejemplo si pones 'monkey' solo se monstraran objetos en que sale esa palabra. Para mostrar todos dejar vacio." }

MI2_OPTIONS["MI2_OptSavePlayerHp"] = 
{ text = "Guardar base de datos de Salud de pjs permanentemente"; help = "Guarda permanentemente salud de jugador en batallas PvP.";
info = "Normalmente los datos de salud de jugador de batallas PvP son descartadas despues de \nuna sesion. Ajustando esta opcion te permite guardar datos." }

MI2_OPTIONS["MI2_OptAllOn"] = 
{ text = "Todo ON"; help = "Activa todas las opciones MobInfo"; }

MI2_OPTIONS["MI2_OptAllOff"] = 
{ text = "Todo OFF"; help = "Desactiva todas las opciones de MobInfo"; }

MI2_OPTIONS["MI2_OptMinimal"] = 
{ text = "Minimo"; help = "Pone el MobInfo con las opciones minimas"; }

MI2_OPTIONS["MI2_OptDefault"] = 
{ text = "Por defecto"; help = "Establece las opciones por defecto"; }

MI2_OPTIONS["MI2_OptBtnDone"] = 
{ text = "Hecho"; help = "Cierra MobInfo"; }

MI2_OPTIONS["MI2_OptStableMax"] = 
{ text = "Muestra vida maxima estable"; help = "Muestra una estable salud maxima en el marco del objetivo";
info = "Cuando actives mostrar maxima salud en la\nventana objetivo durante una batalla.\nEl valor actualizado es mostrado cuando empieza la siguiente batalla."; }

MI2_OPTIONS["MI2_OptTargetHealth"] = 
{ text = "Mostrar valor de Vida"; help = "Muestra el valor de la vida en el marco del objetivo"; }

MI2_OPTIONS["MI2_OptTargetMana"] = 
{ text = "Mostrar valor de Mana"; help = "Muestra el valor de mana en el marco del objetivo"; }

MI2_OPTIONS["MI2_OptHealthPercent"] = 
{ text = "Mostrar porcentaje"; help = "Agrega un porcentaje de la vida en el marco del objetivo"; }

MI2_OPTIONS["MI2_OptManaPercent"] = 
{ text = "Mostrar porcentaje"; help = "Agrega un porcentaje de mana en el marco del objetivo"; }

MI2_OPTIONS["MI2_OptHealthPosX"] = 
{ text = "Posicion Horizontal"; help = "Ajusta la posicion horizontal de la vida en el marco del objetivo"; }

MI2_OPTIONS["MI2_OptHealthPosY"] = 
{ text = "Posicion Vertical"; help = "Ajusta la posicion vertical de la vida en el marco del objetivo"; }

MI2_OPTIONS["MI2_OptManaPosX"] = 
{ text = "Posicion Horizontal"; help = "Ajusta la posicion horizontal de la mana en el marco del objetivo"; }

MI2_OPTIONS["MI2_OptManaPosY"] = 
{ text = "Posicion Vertical"; help = "Ajusta la posicion horizontal del mana en el marco del objetivo"; }

MI2_OPTIONS["MI2_OptTargetFont"] = 
{ text = "Fuente"; help = "Establece la letra de los valores vida/mana";
choice1= "Numero de Fuente"; choice2="GameFont"; choice3="ItemTextFont" }

MI2_OPTIONS["MI2_OptTargetFontSize"] = 
{ text = "Tamaño de Fuente"; help = "Fija el tamaño de la letra en los valores vida/mana"; }

MI2_OPTIONS["MI2_OptClearTarget"] = 
{ text = "Borrar datos de Objetivo"; help = "Borra los datos del objetivo actual de la Base de Datos."; }

MI2_OPTIONS["MI2_OptClearMobDb"] = 
{ text = "Purgar base de datos"; help = "Borra los datos completos de mobs de la Base de Datos."; }

MI2_OPTIONS["MI2_OptClearHealthDb"] = 
{ text = "Purgar base de datos"; help = "Borra los datos de la vida de la Base de Datos."; }

MI2_OPTIONS["MI2_OptClearPlayerDb"] = 
{ text = "Purgar base de datos"; help = "Borrar datos de la vida de los jugadores."; }

MI2_OPTIONS["MI2_OptSaveBasicInfo"] = 
{ text = "Guardar Mob Info basico"; help = ">>>Record a set of basic mob information.";
info = ">>>Basic mob info includes: xp, mob type, counters for: loot, empty loot, cloth, money, items value"; }

MI2_OPTIONS["MI2_OptSaveCharData"] = 
{ text = "Guardar datos de un pj especifico"; help = "Guarda todos los datos Mob espeficifcos por cada personaje.";
info = "Con esto activas o desactivas el guardado de los s.s datos:\nnumber of kills, min/max damage, DPS (damage per sec)\n\nThis data is saved separately for each character. Saving it can\nonly be enabled/disabled for the entire set of 4 values"; }

MI2_OPTIONS["MI2_OptSaveLocation"] = 
{ text = "Guardar datos de localizacion de Mobs"; help = "Recuerda las areas y coordenadas donde necontrar los Mobs." }

MI2_OPTIONS["MI2_OptItemsQuality"] = 
{ text = "Guardar calidad"; help = "Guarda detalles decalidad de objeto seleccionado o mejor.";
choice1 = "Gris y mejor"; choice2="Blanco y mejor"; choice3="Verde y mejor" }

MI2_OPTIONS["MI2_OptTrimDownMobData"] = 
{ text = "Reducir tamaño de base de datos"; help = "Reduce el tamaño de la Base de Datos de Mobs borrando datos sin importancia";
info = "Datos sin importancia son todos los datos que no marcas para\nguardarse."; }

MI2_OPTIONS["MI2_OptImportMobData"] = 
{ text = "Start the Import"; help = ">>>Import an external Mob Database into your own Mob Database";
info = ">>>IMPORTANT: please read the import instructions !\nALWAYS backup your own Mob database BEFORE import !"; }

MI2_OPTIONS["MI2_OptDeleteSearch"] = 
{ text = "DELETE"; help = ">>>Deletes all Mobs in the search result list from the MobInfo database.";
info = ">>>WARNING: this operation can not be undone.\nPlease use carefully !\nYou might want to backup your MobInfo database before deleting Mobs."; }

MI2_OPTIONS["MI2_OptImportOnlyNew"] = 
{ text = "Import only unknown Mobs"; help = ">>>Import only Mobs that do not exist in your own database";
info = ">>>Activating this option prevents that the data of existing Mobs\nis modified. Only unknown (ie. new) Mobs will get imported. This\nallows importing partially overlapping database without causing\nconsistency problems."; }

MI2_OPTIONS["MI2_MainOptionsFrameTab1"] = 
{ text = "Cuadro de Texto"; help = "Fija las opciones para mostrar MobInfo en Cuadro de Texto"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab2"] = 
{ text = "Salud/Mana"; help = "Fija opciones para mostrar vida/mana en el marco objetivo"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab3"] = 
{ text = "Base de Datos"; help = "Opciones de Base de Datos"; }

MI2_OPTIONS["MI2_MainOptionsFrameTab4"] = 
{ text = "Buscar"; help = "Busca en la base de datos"; }

MI2_OPTIONS["MI2_SearchResultFrameTab1"] = 
{ text = "Lista de Mobs"; help = "Muestra la lista de Mobs"; }

MI2_OPTIONS["MI2_SearchResultFrameTab2"] = 
{ text = "Lista de Objetos"; help = "Muestra la lista de objetos"; }

end

