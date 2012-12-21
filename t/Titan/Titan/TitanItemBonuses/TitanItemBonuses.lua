TITAN_ITEMBONUSES_ID = "ItemBonuses";

TitanItemBonuses_colors = {
	X = 'FFD200',  -- attributes
	Y = '20FF20',  -- skills
	M = 'FFFFFF',  -- melee
	R = '00C0C0',  -- ranged
	C = 'FFFF00',  -- spells
	A = 'FF60FF',  -- arcane
	I = 'FF3600',  -- fire
	F = '00C0FF',  -- frost
	H = 'FFA400',  -- holy
	N = '00FF60',  -- nature
	S = 'AA12AC',  -- shadow
	L = '20FF20',  -- life
	P = '6060FF',  -- mana
};

TITAN_ITEMBONUSES_EFFECTS = {
	{ effect = "STR",				format = "+%d",		short = "XSTR",	cat = "ATT" },
	{ effect = "AGI",				format = "+%d",		short = "XAGI",	cat = "ATT" },
	{ effect = "STA",				format = "+%d",		short = "XSTA",	cat = "ATT" },
	{ effect = "INT",				format = "+%d",		short = "XINT",	cat = "ATT" },
	{ effect = "SPI",				format = "+%d",		short = "XSPI",	cat = "ATT" },
	{ effect = "ARMOR",				format = "+%d",		short = "XARM",	cat = "ATT" },

	{ effect = "ARCANERES",			format = "+%d",		short = "AR",	cat = "RES" },
	{ effect = "FIRERES",			format = "+%d",		short = "IR",	cat = "RES" },
	{ effect = "NATURERES", 		format = "+%d",		short = "NR",	cat = "RES" },
	{ effect = "FROSTRES",			format = "+%d",		short = "FR",	cat = "RES" },
	{ effect = "SHADOWRES",			format = "+%d",		short = "SR",	cat = "RES" },

	{ effect = "DEFENSE",			format = "+%d",		short = "YDEF",	cat = "SKILL" },
	{ effect = "MINING",			format = "+%d",		short = "YMIN",	cat = "SKILL" },
	{ effect = "HERBALISM",			format = "+%d",		short = "YHER",	cat = "SKILL" },
	{ effect = "SKINNING", 			format = "+%d",		short = "YSKI",	cat = "SKILL" },
	{ effect = "FISHING",			format = "+%d",		short = "YFIS",	cat = "SKILL" },

	{ effect = "ATTACKPOWER", 		format = "+%d",		short = "MA",	cat = "BON" },
	{ effect = "CRIT",				format = "+%d%%",	short = "MC",	cat = "BON" },
	{ effect = "BLOCK",				format = "+%d%%",	short = "MB",	cat = "BON" },
	{ effect = "DODGE",				format = "+%d%%",	short = "MD",	cat = "BON" },
	{ effect = "PARRY", 			format = "+%d%%",	short = "MP",	cat = "BON" },
	{ effect = "TOHIT", 			format = "+%d%%",	short = "MH",	cat = "BON" },
	{ effect = "RANGEDATTACKPOWER", format = "+%d",		short = "RA",	cat = "BON" },
	{ effect = "RANGEDCRIT",		format = "+%d%%",	short = "RC",	cat = "BON" },

	{ effect = "DMG",				format = "+%d",		short = "CD",	cat = "SBON" },
	{ effect = "HEAL",				format = "+%d",		short = "CH",	cat = "SBON"},
	{ effect = "HOLYCRIT", 			format = "+%d%%",	short = "CHC",	cat = "SBON" },
	{ effect = "SPELLCRIT", 		format = "+%d%%",	short = "CSC",	cat = "SBON" },
	{ effect = "SPELLTOHIT", 		format = "+%d%%",	short = "CSH",	cat = "SBON" },
	{ effect = "ARCANEDMG", 		format = "+%d",		short = "AD",	cat = "SBON" },
	{ effect = "FIREDMG", 			format = "+%d",		short = "ID",	cat = "SBON" },
	{ effect = "FROSTDMG",			format = "+%d",		short = "FD",	cat = "SBON" },
	{ effect = "HOLYDMG",			format = "+%d",		short = "HD",	cat = "SBON" },
	{ effect = "NATUREDMG",			format = "+%d",		short = "ND",	cat = "SBON" },
	{ effect = "SHADOWDMG",			format = "+%d",		short = "SD",	cat = "SBON" },

	{ effect = "HEALTH",			format = "+%d",		short = "LP",	cat = "OBON" },
	{ effect = "HEALTHREG",			format = "%d HP/5s",short = "LR",	cat = "OBON" },
	{ effect = "MANA",				format = "+%d",		short = "PP",	cat = "OBON" },
	{ effect = "MANAREG",			format = "%d MP/5s",short = "PR",	cat = "OBON" },
};

TITAN_ITEMBONUSES_CATEGORIES = {'ATT', 'BON', 'SBON', 'RES', 'SKILL', 'OBON'};

TitanItemBonuses_active = nil;

function TitanPanelItemBonusesButton_OnLoad()
	this.registry = {
		id = TITAN_ITEMBONUSES_ID,
		builtIn = 1,
		version = "0.9.1800",
		menuText = TITAN_ITEMBONUSES_TEXT,
		buttonTextFunction = "TitanPanelItemBonusesButton_GetButtonText",
		tooltipTitle = TITAN_ITEMBONUSES_TEXT,
		tooltipTextFunction = "TitanPanelItemBonusesButton_GetTooltipText",
		icon = "Interface\\Icons\\Spell_Nature_EnchantArmor.blp";
		iconWidth = 16,
		savedVariables = {
			ShowLabelText = 1,
			ShowColoredText = TITAN_NIL,
			ShowIcon = 1,
			shortdisplay = TITAN_NIL,
			displaybonuses = {},
		}
	};

	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function TitanPanelItemBonusesButton_OnEvent() 
	if (event == "PLAYER_ENTERING_WORLD") then
		TitanItemBonuses_active = 1;
	end
end

function TitanPanelItemBonusesButton_FormatShortText(short,val)
	local color = 'FFFFFF';
	local text = string.sub(short,2);
	local colorcode = string.sub(short,1,1);
	if(TitanItemBonuses_colors[colorcode]) then
		color = TitanItemBonuses_colors[colorcode];
	end;
	if(val) then
		return '|cff'.. color .. val .. FONT_COLOR_CODE_CLOSE
	else 
		return '|cff'.. color .. text .. FONT_COLOR_CODE_CLOSE
	end;
end


function TitanPanelItemBonusesButton_GetButtonText(id)

	local title = TITAN_ITEMBONUSES_TEXT;
	local text = "";
	local disp = TitanGetVar(TITAN_ITEMBONUSES_ID, "displaybonuses");
	-- preventing getting inaccessible due to no display at all
	if(	(not disp or (table.getn(disp) == 0 ) or not BonusScanner or not BonusScanner.active)
		and not TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowLabelText")
		and not TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowIcon")) then
		TitanSetVar(TITAN_ITEMBONUSES_ID, "ShowLabelText", 1);
		TitanPanelButton_UpdateButton(TITAN_ITEMBONUSES_ID);
	end;

	if(not BonusScanner or not BonusScanner.active) then
		return TITAN_ITEMBONUSES_TEXT,"";
	end
	
	local i,d,e;
	local liste = {};
	for i,d in disp do
		e = TITAN_ITEMBONUSES_EFFECTS[d];
		if(TitanGetVar(TITAN_ITEMBONUSES_ID, "shortdisplay")) then
			title = TitanPanelItemBonusesButton_FormatShortText(e.short);
		else
			title = BONUSSCANNER_NAMES[e.effect]..": ";
		end
		if(BonusScanner.bonuses[e.effect]) then
			val = BonusScanner.bonuses[e.effect];
		else
			val = 0;
		end
   		text = format(e.format,val);
		if(TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowColoredText")) then
			text = TitanPanelItemBonusesButton_FormatShortText(e.short,text);
		end;
		table.insert(liste,title);
		table.insert(liste,TitanUtils_GetHighlightText(text));
	end;

	if(table.getn(liste) == 0) then
		return TITAN_ITEMBONUSES_TEXT,"";
	end
	return unpack(liste);
end

function TitanPanelItemBonusesButton_isdisp(val)
	local disp = TitanGetVar(TITAN_ITEMBONUSES_ID, "displaybonuses");
	local i,d;
	for i,d in disp do
		if(d==val) then
			return 1;
		end
	end
	return nil;
end

function TitanPanelItemBonusesButton_hasdisp()
	local disp = TitanGetVar(TITAN_ITEMBONUSES_ID, "displaybonuses");
	if(not disp) then
		return nil;
	end
	return table.getn(disp) > 0;
end


function TitanPanelItemBonusesButton_GetTooltipText()

	if(not BonusScanner or not BonusScanner.active) then
		return "\n" ..TITAN_ITEMBONUSES_BONUSSCANNER_MISSING;
	end

	local retstr,cat,val = "","","","";
	local i;

	for i,e in TITAN_ITEMBONUSES_EFFECTS do

		if(BonusScanner.bonuses[e.effect]) then
			if(e.format) then
		   		val = format(e.format,BonusScanner.bonuses[e.effect]);
			else
				val = BonusScanner.bonuses[e.effect];
			end;
			if(e.cat ~= cat) then
				cat = e.cat;
				if(retstr ~= "") then
					retstr = retstr .. "\n"
				end
				retstr = retstr .. "\n" .. TitanUtils_GetGreenText(getglobal('TITAN_ITEMBONUSES_CAT_'..cat)..":");
			end
			
			retstr = retstr.. "\n".. BONUSSCANNER_NAMES[e.effect]..":\t".. TitanUtils_GetHighlightText(val);
		end
	end
	return retstr;
end

function TitanPanelItemBonuses_Update()
	oldBonusScanner_Update();
	if(TitanItemBonuses_active) then
		TitanPanelButton_UpdateButton(TITAN_ITEMBONUSES_ID);
	end
end

oldBonusScanner_Update = BonusScanner_Update;
BonusScanner_Update = TitanPanelItemBonuses_Update;

function TitanPanelRightClickMenu_PrepareItemBonusesMenu()
	local id = "ItemBonuses";
	local info = {};
	local i,cat,disp,val;

	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		for i,e in TITAN_ITEMBONUSES_EFFECTS do
			if(e.cat == this.value) then
				info = {};
				info.text = '[' .. TitanPanelItemBonusesButton_FormatShortText(e.short) .. '] ' .. BONUSSCANNER_NAMES[e.effect];
				if(BonusScanner.bonuses[e.effect]) then
					val = BonusScanner.bonuses[e.effect];
			   		info.text = info.text .. " (".. format(e.format,val).. ")";
			   	end
				info.value = i;
				info.func = TitanPanelItemBonuses_SetDisplay;
				info.checked = TitanPanelItemBonusesButton_isdisp(i);
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	else
	
		if(not BonusScanner or not BonusScanner.active) then
			TitanPanelRightClickMenu_AddToggleIcon(TITAN_ITEMBONUSES_ID);
			TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ITEMBONUSES_ID);
			TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);	
		else
			TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_ITEMBONUSES_ID].menuText);
			TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
	
			info = {};
			info.text = TITAN_ITEMBONUSES_DISPLAY_NONE;
			info.value = 0;
			info.func = TitanPanelItemBonuses_SetDisplay;
			disp = TitanGetVar(TITAN_ITEMBONUSES_ID, "displaybonuses");
			info.checked = not TitanPanelItemBonusesButton_hasdisp();
			UIDropDownMenu_AddButton(info);
			
			for i,cat in TITAN_ITEMBONUSES_CATEGORIES do
				info = {};
				info.text = getglobal('TITAN_ITEMBONUSES_CAT_'..cat);
				info.hasArrow = 1;
				info.value = cat;
				UIDropDownMenu_AddButton(info);
			end;
	
			TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
	
			TitanPanelRightClickMenu_AddToggleIcon(TITAN_ITEMBONUSES_ID);
			TitanPanelRightClickMenu_AddToggleVar(TITAN_ITEMBONUSES_SHORTDISPLAY, TITAN_ITEMBONUSES_ID,'shortdisplay');
			TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ITEMBONUSES_ID);
			TitanPanelRightClickMenu_AddToggleColoredText(TITAN_ITEMBONUSES_ID);
			TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
		end
			
	end
end

function TitanPanelItemBonuses_SetDisplay()
	local db = TitanGetVar(TITAN_ITEMBONUSES_ID, "displaybonuses");
	local i,d,found;
	if(this.value == 0) then
		TitanSetVar(TITAN_ITEMBONUSES_ID, "displaybonuses", {});
	else
		found = 0;
		for i,d in db do
			if(d == this.value)then
				found = i;
			end
		end
		if(found > 0) then
			table.remove(db,found)
		else
			while(table.getn(db)>3) do
				table.remove(db);
			end;
			table.insert(db,this.value);
		end
		TitanSetVar(TITAN_ITEMBONUSES_ID, "displaybonuses", db);
	end;
	TitanPanelButton_UpdateButton(TITAN_ITEMBONUSES_ID);
end
