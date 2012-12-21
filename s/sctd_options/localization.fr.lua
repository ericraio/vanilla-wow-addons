
if GetLocale() ~= "frFR" then return end

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT101 = {name = "Dommages De M\195\170l\195\169e", tooltipText = "Permet ou neutralise montrer vos dommages de m\195\170l\195\169e"};
SCT.LOCALS.OPTION_EVENT102 = {name = "Dommages P\195\169riodiques", tooltipText = "Permet ou neutralise montrer vos dommages p\195\169riodiques"};
SCT.LOCALS.OPTION_EVENT103 = {name = "Dommages De Charme", tooltipText = "Permet ou neutralise montrer vos dommages de charme"};
SCT.LOCALS.OPTION_EVENT104 = {name = "Dommages D\'Animal", tooltipText = "Permet ou neutralise montrer les dommages de votre animal de compagnie"};
SCT.LOCALS.OPTION_EVENT105 = {name = "Color Crits", tooltipText = "Enables or Disables making your crits teh selected color"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK101 = { name = "Permettez SCT - Damage", tooltipText = "Permet ou neutralise SCT - Damage"};
SCT.LOCALS.OPTION_CHECK102 = { name = "Dommages De Drapeau", tooltipText = "Permet ou neutralise placer a * autour de tous les dommages"};
SCT.LOCALS.OPTION_CHECK103 = { name = "Type De Charme", tooltipText = "Permet ou neutralise montrer le type de dommages de charme"};
SCT.LOCALS.OPTION_CHECK104 = { name = "Nom De Charme", tooltipText = "Permet ou neutralise montrer le nom de charmee"};
SCT.LOCALS.OPTION_CHECK105 = { name = "R\195\169siste", tooltipText = "Permet ou neutralise montrer vos dommages r\195\169sist\195\169s"};
SCT.LOCALS.OPTION_CHECK106 = { name = "Nom De Cible", tooltipText = "Permet ou neutralise montrer le nom de cibles"};
SCT.LOCALS.OPTION_CHECK107 = { name = "Neutralisez les dommages de WoW", tooltipText = "Permet ou neutralise montrer construit dans des dommages de cible de d\195\169faut de WoW.\n\nNOTE : C\'est l\'exact m\195\170mes que les bo\195\174tes de contr\195\180le sous les options avanç\195\169es dans des options d\'interface. Vous avez plus de contr\195\180le de lui l\195\160."};
SCT.LOCALS.OPTION_CHECK108 = { name = "Only Target", tooltipText = "Enables or Disables showing damage done to your current target only. AE effects are not shown, unless multiple targets have the same name."};
SCT.LOCALS.OPTION_CHECK109 = { name = "Enable During PVP", tooltipText = "Enables WoW Damage and turns off SCTD during PvP. Probably not useful on PvP Servers."};
SCT.LOCALS.OPTION_CHECK110 = { name = "Use SCT Animation", tooltipText = "Enables using SCT for damage animation. When enabled, ALL CONTROL OVER THE TEXT IS DONE BY SCT. Please use SCT for configuring the text how you like."};
SCT.LOCALS.OPTION_CHECK111 = { name = "Sticky Crit", tooltipText = "Enables using having critical hits stick. When off, crits display with +1236+, etc.. "};
SCT.LOCALS.OPTION_CHECK112 = { name = "Spell Color", tooltipText = "Enables or Disables showing spell damage in colors per spell class (colors not configurable)"};
SCT.LOCALS.OPTION_CHECK113 = { name = "Damage Text Down", tooltipText = "Enables or Disables scrolling text downwards"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER101 = { name="Position Centrale De X", minText="-600", maxText="600", tooltipText = "Commande le placement du centre des textes"};
SCT.LOCALS.OPTION_SLIDER102 = { name="Position Centrale De Y", minText="-400", maxText="400", tooltipText = "Commande le placement du centre des textes"};
SCT.LOCALS.OPTION_SLIDER103 = { name="Se fanent La Vitesse", minText="rapidement", maxText="lent", tooltipText = "Commande la vitesse que les messages se fanent"};
SCT.LOCALS.OPTION_SLIDER104 = { name="Taille De Police", minText="petit", maxText="grand", tooltipText = "Commande la taille du texte"};

--Misc option values
SCT.LOCALS.OPTION_MISC101 = {name="SCTD Options "..SCTD.Version};
SCT.LOCALS.OPTION_MISC102 = {name="Fin", tooltipText = "Sauve tous les arrangements courants et cl\195\180ture les options"};
SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "Ouvrez le menu d\'option"};
SCT.LOCALS.OPTION_MISC104 = {name="Damage Events", tooltipText = ""};
SCT.LOCALS.OPTION_MISC105 = {name="Display Options", tooltipText = ""};
SCT.LOCALS.OPTION_MISC106 = {name="Frame Options", tooltipText = ""};

--Animation Types
SCT.LOCALS.OPTION_SELECTION101 = { name="Police De Dommages", tooltipText = "Quelle police \195\160 employer pour des messages", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name}};
SCT.LOCALS.OPTION_SELECTION102 = { name="Contour De Police De Dommages", tooltipText = "Quel contour de police \195\160 employer pour des messages", table = {[1] = "Aucun",[2] = "Mince",[3] = "Profond\195\169ment"}};
SCT.LOCALS.OPTION_SELECTION103 = { name="Damage Animation Type", tooltipText = "Which animation type to use. Its HIGHLY recommended you use a different animation here than you use with SCT.", table = {[1] = "Vertical (Normal)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down",[5] = "Angled Up",[6] = "Sprinkler"}};
SCT.LOCALS.OPTION_SELECTION104 = { name="Damage Side Style", tooltipText = "How side scrolling text should display", table = {[1] = "Alternating",[2] = "Damage Left",[3] = "Damage Right", [4] = "All Left", [5] = "All Right"}};

