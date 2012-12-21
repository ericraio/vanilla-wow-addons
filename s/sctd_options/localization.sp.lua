
if GetLocale() ~= "spSP" then return end

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT101 = {name = "Da\195\177os Del Melee", tooltipText = "Permite o inhabilita demostrar su da\195\177o del melee"};
SCT.LOCALS.OPTION_EVENT102 = {name = "Da\195\177os Peri\195\179dica", tooltipText = "Permite o inhabilita demostrar su da\195\177o peri\195\179dico"};
SCT.LOCALS.OPTION_EVENT103 = {name = "Da\195\177os Del Encanto", tooltipText = "Permite o inhabilita demostrar su da\195\177o del encanto"};
SCT.LOCALS.OPTION_EVENT104 = {name = "Da\195\177os Del Animal dom\195\169stico", tooltipText = "Permite o inhabilita demostrar el da\195\177o de su animal dom\195\169stico"};
SCT.LOCALS.OPTION_EVENT105 = {name = "Color Crits", tooltipText = "Enables or Disables making your crits teh selected color"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK101 = { name = "Permita El Da\195\177o de SCT", tooltipText = "Permite o inhabilita da\195\177o de SCT"};
SCT.LOCALS.OPTION_CHECK102 = { name = "Da\195\177os De la Bandera", tooltipText = "Permite o inhabilita la colocaci\195\179n de a * alrededor de todo el da\195\177o"};
SCT.LOCALS.OPTION_CHECK103 = { name = "Tipo Del Encanto", tooltipText = "Permite o inhabilita demostrar el tipo del da\195\177os del encanto"};
SCT.LOCALS.OPTION_CHECK104 = { name = "Nombre Del Encanto", tooltipText = "Permite o inhabilita demostrar el nombre del encanto"};
SCT.LOCALS.OPTION_CHECK105 = { name = "Resiste", tooltipText = "Permite o inhabilita demostrar su da\195\177o resistido"};
SCT.LOCALS.OPTION_CHECK106 = { name = "Nombre De la Blanco", tooltipText = "Permite o inhabilita demostrar el nombre de las blancos"};
SCT.LOCALS.OPTION_CHECK107 = { name = "Inhabilite El Da\195\177o de WoW", tooltipText = "Permite o inhabilita demostrar construido en da\195\177o de la blanco de WoW.\n\nNOTA: \195\169ste es el exacto iguales que las cajas de cheque bajo opciones avanzadas en opciones de interfaz. Usted tiene m\195\161s control sobre \195\169l allí."};
SCT.LOCALS.OPTION_CHECK108 = { name = "Only Target", tooltipText = "Enables or Disables showing damage done to your current target only. AE effects are not shown, unless multiple targets have the same name."};
SCT.LOCALS.OPTION_CHECK109 = { name = "Enable During PVP", tooltipText = "Enables WoW Damage and turns off SCTD during PvP. Probably not useful on PvP Servers."};
SCT.LOCALS.OPTION_CHECK110 = { name = "Use SCT Animation", tooltipText = "Enables using SCT for damage animation. When enabled, ALL CONTROL OVER THE TEXT IS DONE BY SCT. Please use SCT for configuring the text how you like."};
SCT.LOCALS.OPTION_CHECK111 = { name = "Sticky Crit", tooltipText = "Enables using having critical hits stick. When off, crits display with +1236+, etc.. "};
SCT.LOCALS.OPTION_CHECK112 = { name = "Spell Color", tooltipText = "Enables or Disables showing spell damage in colors per spell class (colors not configurable)"};
SCT.LOCALS.OPTION_CHECK113 = { name = "Damage Text Down", tooltipText = "Enables or Disables scrolling text downwards"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER101 = { name="Posici\195\179n De centro De X", minText="-600", maxText="600", tooltipText = "Controla la colocaci\195\179n del centro del texto"};
SCT.LOCALS.OPTION_SLIDER102 = { name="Posici\195\179n De centro De Y", minText="-400", maxText="400", tooltipText = "Controla la colocaci\195\179n del centro del texto"};
SCT.LOCALS.OPTION_SLIDER103 = { name="Se descolora La Velocidad", minText="r\195\161pidamente", maxText="lento", tooltipText = "Controla la velocidad que se descoloran los mensajes"};
SCT.LOCALS.OPTION_SLIDER104 = { name="Tama\195\177o De Fuente", minText="peque\195\177o", maxText="grande", tooltipText = "Controla el tama\195\177o del texto"};

--Misc option values
SCT.LOCALS.OPTION_MISC101 = {name="SCTD Opciones "..SCTD.Version};
SCT.LOCALS.OPTION_MISC102 = {name="Cierre", tooltipText = "Ahorra todos los ajustes actuales y cierra las opciones"};
SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "Abra el menú de la opci\195\179n de SCTD"};
SCT.LOCALS.OPTION_MISC104 = {name="Damage Events", tooltipText = ""};
SCT.LOCALS.OPTION_MISC105 = {name="Display Options", tooltipText = ""};
SCT.LOCALS.OPTION_MISC106 = {name="Frame Options", tooltipText = ""};

--Animation Types
SCT.LOCALS.OPTION_SELECTION101 = { name="Fuente Del Da\195\177os", tooltipText = "Qu\195\169 fuente a utilizar para los mensajes", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION102 = { name="Contorno De la Fuente Del Da\195\177os", tooltipText = "Qu\195\169 contorno de la fuente a utilizar para los mensajes", table = {[1] = "Ninguno",[2] = "Fino",[3] = "Densamente"}};
SCT.LOCALS.OPTION_SELECTION103 = { name="Damage Animation Type", tooltipText = "Which animation type to use. Its HIGHLY recommended you use a different animation here than you use with SCT.", table = {[1] = "Vertical (Normal)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down",[5] = "Angled Up",[6] = "Sprinkler"}};
SCT.LOCALS.OPTION_SELECTION104 = { name="Damage Side Style", tooltipText = "How side scrolling text should display", table = {[1] = "Alternating",[2] = "Damage Left",[3] = "Damage Right", [4] = "All Left", [5] = "All Right"}};
