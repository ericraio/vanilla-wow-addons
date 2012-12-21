DRUIDBAR_CHAT_COMMAND_USAGE	= "Commands: /DruidBar or /dbar.\n/dbar function to see behavioral parameters\n/dbar cosmetic to see cosmetic parameters.";
DRUIDBAR_CHAT_FUNCTIONAL_USAGE 	= "Functional Parameters: [Toggle/Update/Lock/Hide/Replace/EZShift/kmg/best/message]";
DRUIDBAR_CHAT_COSMETIC_USAGE	= "Cosmetic Parameters: [barcolor/ShowText/Percent/Changex (1-??)/Changey (1-??)/PlayerFrame/TextType/TextColor]\ntype /dbar textcolor for more info on it";
DRUIDBAR_CHAT_TEXTCOLOR_USE	= "TextColor use: /dbar textcolor -color- (\"original, red, orange, yellow, green, blue, purple, black, white\")\n/dbar textcolor [r/g/b] (0.00 to 1.00)\n/dbar textcolor set # # #";
DRUIDBAR_DRUIDCLASS	= "Druid";
DRUIDBAR_INNERVATE	= "Innervate";
DRUIDBAR_FORM = "Form";
DRUIDBAR_FORMX = "Aquatic";
DRUIDBAR_FORMX2 = "Travel";
BINDING_HEADER_DRUIDBAR = "Druid Bar";
BINDING_NAME_DruidBarBest = "Best Form";
DRUIDBAR_REGEN1 = "Equip: Restores %d+ mana per 5 sec.";
DRUIDBAR_REGEN2 = "Mana Regen %d+ per 5 sec.";
DRUIDBAR_REGEN3 = "Equip: Restores (%d+) mana per 5 sec."
DRUIDBAR_REGEN4 = "Mana Regen (%d+) per 5 sec.";
DRUIDBAR_CAT_FORM = "cat form";

DRUIDBAR_BEAR_FORM = "bear form";

DRUIDBAR_MANA_DELIM = " ";
DRUIDBAR_META = "Metamorphosis Rune";

if ( GetLocale() == "frFR" ) then
	DRUIDBAR_DRUIDCLASS	= "Druide";
	DRUIDBAR_INNERVATE = "Innervation";
	DRUIDBAR_FORM = "Forme";
	DRUIDBAR_FORMX = "aquatique";
	DRUIDBAR_FORMX2 = "voyage";
	BINDING_NAME_DruidBarBest = "Meilleure Forme";
	DRUIDBAR_REGEN1 = "Equip\195\169 : Rend %d+ points de mana toutes les 5 secondes."
	DRUIDBAR_REGEN2 = "R\195\169cup. mana %d+/5 sec."
	DRUIDBAR_REGEN3 = "Equip\195\169 : Rend (%d+) points de mana toutes les 5 secondes."
	DRUIDBAR_REGEN4 = "R\195\169cup. mana (%d+)/5 sec.";
	DRUIDBAR_CAT_FORM = "f\195\169lin";
	DRUIDBAR_BEAR_FORM = "d'ours";
	DRUIDBAR_MANA_DELIM = ":";
elseif ( GetLocale() == "deDE" ) then
	DRUIDBAR_DRUIDCLASS	= "Druide";
	DRUIDBAR_INNERVATE = "Anregen";
	DRUIDBAR_FORM = "gestalt"
	DRUIDBAR_FORMX = "Wasser";
	DRUIDBAR_FORMX2 = "Reise";
	DRUIDBAR_REGEN1 = "Anlegen: Stellt alle 5 Sek. %d+ Punkt(e) Mana wieder her.";
	DRUIDBAR_REGEN2 = "Manaregeneration %d+ per 5 Sek.";
	DRUIDBAR_REGEN3 = "Anlegen: Stellt alle 5 Sek. (%d+) Punkt(e) Mana wieder her.";
	DRUIDBAR_REGEN4 = "Manaregeneration (%d+) per 5 Sek.";
	DRUIDBAR_CAT_FORM = "rengestalt";
	DRUIDBAR_BEAR_FORM = "katzengestalt";
	DRUIDBAR_MANA_DELIM = " ";
elseif GetLocale() == "zhTW" then
	DRUIDBAR_DRUIDCLASS	= "德魯伊";
	DRUIDBAR_INNERVATE = "啟動";
	DRUIDBAR_FORM = "形態"
	DRUIDBAR_FORMX = "水棲";
	DRUIDBAR_FORMX2 = "族行";
	BINDING_NAME_DruidBarBest = "最佳形態";
	DRUIDBAR_REGEN1 = "裝備︰ 每5秒恢復%d+點法力值。";
	DRUIDBAR_REGEN2 = "每5秒恢復%d+點法力值。";
	DRUIDBAR_REGEN3 = "裝備︰ 每5秒恢復(%d+)點法力值。"
	DRUIDBAR_REGEN4 = "每5秒恢復(%d+)點法力值。";
	DRUIDBAR_CAT_FORM = "獵豹形態";
	DRUIDBAR_BEAR_FORM = "熊形態";
	DRUIDBAR_MANA_DELIM = "法力";
elseif GetLocale() == "zhCN" then
	DRUIDBAR_DRUIDCLASS	= "德鲁伊";
	DRUIDBAR_INNERVATE	= "激活";
	DRUIDBAR_FORM = "形态";
	DRUIDBAR_FORMX = "水栖";
	DRUIDBAR_FORMX2 = "旅行";
	DRUIDBAR_REGEN1 = "装备： 每5秒恢复%d+点法力值。";
	DRUIDBAR_REGEN2 = "每5秒恢复%d+点法力值。";
	DRUIDBAR_REGEN3 = "装备： 每5秒恢复(%d+)点法力值。"
	DRUIDBAR_REGEN4 = "每5秒恢复(%d+)点法力值。";
	DRUIDBAR_CAT_FORM = "猎豹形态";
	
	DRUIDBAR_BEAR_FORM = "熊形态";
	
	DRUIDBAR_MANA_DELIM = "法力值";
	DRUIDBAR_META = "变形符文";
end
