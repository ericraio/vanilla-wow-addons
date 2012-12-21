TITAN_ITEMBONUSES_ID = "ItemBonuses";

TitanItemBonuses_bonuses = {};
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
			ShowColoredText = 0,
			ShowIcon = 1,
			shortdisplay = 0,
			displaybonuses = {},
		}
	};

	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
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
	if(	(not disp or (table.getn(disp) == 0))
		and not TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowLabelText")
		and not TitanGetVar(TITAN_ITEMBONUSES_ID, "ShowIcon")) then
		TitanSetVar(TITAN_ITEMBONUSES_ID, "ShowLabelText", 1);
		TitanPanelButton_UpdateButton(TITAN_ITEMBONUSES_ID);
	end;
	
	local i,d,e;
	local liste = {};
	for i,d in disp do
		e = TITAN_ITEMBONUSES_EFFECTS[d];
		if(TitanGetVar(TITAN_ITEMBONUSES_ID, "shortdisplay")) then
			title = TitanPanelItemBonusesButton_FormatShortText(e.short);
		else
			title = e.name..": ";
		end
		if(TitanItemBonuses_bonuses[e.effect]) then
			val = TitanItemBonuses_bonuses[e.effect];
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
	local retstr,cat,val = "","","","";
	local i;

	for i,e in TITAN_ITEMBONUSES_EFFECTS do

		if(TitanItemBonuses_bonuses[e.effect]) then
			if(e.format) then
		   		val = format(e.format,TitanItemBonuses_bonuses[e.effect]);
			else
				val = TitanItemBonuses_bonuses[e.effect];
			end;
			if(e.cat ~= cat) then
				cat = e.cat;
				if(retstr ~= "") then
					retstr = retstr .. "\n"
				end
				retstr = retstr .. "\n" .. TitanUtils_GetGreenText(getglobal('TITAN_ITEMBONUSES_CAT_'..cat)..":");
			end
			
			retstr = retstr.. "\n".. e.name..":\t".. TitanUtils_GetHighlightText(val);
		end
	end
	return retstr;
end

function TitanPanelItemBonusesButton_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD") then
		TitanItemBonuses_active = 1;
	end
	if (((event == "PLAYER_ENTERING_WORLD") or (event == "UNIT_INVENTORY_CHANGED")) and TitanItemBonuses_active) then
		TitanPanelItemBonuses_CalcValues();
		TitanPanelButton_UpdateButton(TITAN_ITEMBONUSES_ID);
	end
end

function TitanPanelRightClickMenu_PrepareItemBonusesMenu()
	local id = "ItemBonuses";
	local info = {};
	local i,cat,disp,val;

	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		for i,e in TITAN_ITEMBONUSES_EFFECTS do
			if(e.cat == this.value) then
				info = {};
				info.text = '[' .. TitanPanelItemBonusesButton_FormatShortText(e.short) .. '] ' .. e.name;
				if(TitanItemBonuses_bonuses[e.effect]) then
					val = TitanItemBonuses_bonuses[e.effect];
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


function TitanPanelItemBonuses_CalcValues()
	
	BonusScanner_ScanAll();
	TitanItemBonuses_bonuses = BonusScanner_bonuses;
end

