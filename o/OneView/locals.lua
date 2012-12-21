--$Id: locals.lua 8414 2006-08-19 04:48:29Z kaelten $-- 

-- zhCN localization by hk2717
-- deDE localization by Gamefaq

local L = AceLibrary("AceLocale-2.0"):new("OneView")

if GetLocale() == "zhCN" then 
    ONEVIEW_LOCALE_CONFIGMENU = "设置菜单" 
	ONEVIEW_LOCALE_CHARSELECT = "人物选择"
elseif GetLocale() == "deDE" then 
    
    ONEVIEW_LOCALE_CONFIGMENU = "Config-Menü" 
	ONEVIEW_LOCALE_CHARSELECT = "Buchstabe auserwählt"
    
else 
	ONEVIEW_LOCALE_CONFIGMENU = "Config Menu" 
	ONEVIEW_LOCALE_CHARSELECT = "Char Select"
end

L:RegisterTranslations("enUS", function()
    return {
		["Show the OneView Frame"]	= true,
		
		["Quiver"]	= true,
		["Soul Bag"]	= true,
		["Container"]	= true,
		["Bag"]	= true,
		
		["Backpack"] = true,
		["Turns display of your backpack on and off."] = true,
		["First Bag"] = true,
		["Turns display of your first bag on and off."] = true,
		["Second Bag"] = true,
		["Turns display of your second bag on and off."] = true,
		["Third Bag"] = true,
		["Turns display of your third bag on and off."] = true,
		["Fourth Bag"] = true,
		["Turns display of your fourth bag on and off."] = true,
		["First Bank Bag"] = true,
		["Second Bank Bag"] = true,
		["Third Bank Bag"] = true,
		["Fourth Bank Bag"] = true,
		["Fifth Bank Bag"] = true,
		["Turns display of your fifth bag on and off."] = true,
		["Sixth Bank Bag"] = true,
		["Turns display of your sixth bag on and off."] = true,
		
		["Remember"] = true,
		["Remember Selection"] = true,
		["Toggles wether to remember which was the last character you selected."] = true,
		["%s's Bank Bags"] = true,
		["%s's Bags"] = true,
		["%s/%s Slots"] = true,
		["%s/%s Ammo"] = true,
		["%s/%s Soul Shards"] = true,
		["%s/%s Profession Slots"] = true,
		["Characters on "] = true,
    }
end)

L:RegisterTranslations("zhCN", function()
    return {
		["Show the OneView Frame"]	= "显示OneView框体",
		
		["Quiver"]	= "箭袋",
		["Soul Bag"]	= "灵魂袋",
		["Container"]	= "背包",
		["Bag"]	= "包裹",
		
		["Backpack"] = "背包",
		["Turns display of your backpack on and off."] = "切换是否显示背包。",
		["First Bag"] = "第一个包",
		["Turns display of your first bag on and off."] = "切换是否显示第一个包。",
		["Second Bag"] = "第二个包",
		["Turns display of your second bag on and off."] = "切换是否显示第二个包。",
		["Third Bag"] = "第三个包",
		["Turns display of your third bag on and off."] = "切换是否显示第三个包。",
		["Fourth Bag"] = "第四个包",
		["Turns display of your fourth bag on and off."] = "切换是否显示第四个包。",
		["First Bank Bag"] = "第一个银行包",
		["Second Bank Bag"] = "第二个银行包",
		["Third Bank Bag"] = "第三个银行包",
		["Fourth Bank Bag"] = "第四个银行包",
		["Fifth Bank Bag"] = "第五个银行包",
		["Turns display of your fifth bag on and off."] = "切换是否显示第五个包。",
		["Sixth Bank Bag"] = "第六个银行包",
		["Turns display of your sixth bag on and off."] = "切换是否显示第六个包。",
		
		["Remember"] = "记忆",
		["Remember Selection"] = "记忆选择",
		["Toggles wether to remember which was the last character you selected."] = "切换是否记忆你选择的最后一个人物。",
		["%s's Bank Bags"] = "%s的银行",
		["%s's Bags"] = "%s的背包",
		["%s/%s Slots"] = "%s/%s背包",
		["%s/%s Ammo"] = "%s/%s弹药",
		["%s/%s Soul Shards"] = "%s/%s灵魂碎片",
		["%s/%s Profession Slots"] = "%s/%s专业袋",
		["Characters on "] = "人物所在服务器阵营：",
    }
end)

L:RegisterTranslations("deDE", function()
    return {
		["Show the OneView Frame"]	= "Zeige das OneView Fenster",
		
		["Quiver"]	= "K\195\182cher",
		["Soul Bag"]	= "Seelentasche",
		["Container"]	= "Beh\195\164lter",
		["Bag"]	= "Beh\195\164lter",
		
		["Backpack"] = "Rucksack",
		["Turns display of your backpack on and off."] = "Schaltet das Anzeigen des Rucksacks an und aus",
		["First Bag"] = "Erste Tasche",
		["Turns display of your first bag on and off."] = "Schaltet das Anzeigen der ersten Tasche an und aus",
		["Second Bag"] = "Zweite Tasche",
		["Turns display of your second bag on and off."] = "Schaltet das Anzeigen der zweiten Tasche an und aus",
		["Third Bag"] = "Dritte Tasche",
		["Turns display of your third bag on and off."] = "Schaltet das Anzeigen der dritten Tasche an und aus",
		["Fourth Bag"] = "Vierte Tasche",
		["Turns display of your fourth bag on and off."] = "Schaltet das Anzeigen der vierten Tasche an und aus",
		["First Bank Bag"] = "Erste Bank Tasche",
		["Second Bank Bag"] = "Zweite Bank Tasche",
		["Third Bank Bag"] = "Dritte Bank Tasche",
		["Fourth Bank Bag"] = "Vierte Bank Tasche",
		["Fifth Bank Bag"] = "F\195\188nfte Bank Tasche",
		["Turns display of your fifth bag on and off."] = "Schaltet das Anzeigen der f\195\188nften Bank Tasche an und aus",
		["Sixth Bank Bag"] = "Sechste Bank Tasche",
		["Turns display of your sixth bag on and off."] = "Schaltet das Anzeigen der sechsten Bank Tasche an und aus",
		
		["Remember"] = "Erinnern",
		["Remember Selection"] = "Merke Auswahl",
		["Toggles wether to remember which was the last character you selected."] = "Aktiviert das merken des von dir letzten ge\195\182ffneten Charakters",
		["%s's Bank Bags"] = "%s's Bank Taschen",
		["%s's Bags"] = "%s's Taschen",
		["%s/%s Slots"] = "%s's Pl\195\164tze",
		["%s/%s Ammo"] = "%s's Munition",
		["%s/%s Soul Shards"] = "%s's Seelensplitter",
		["%s/%s Profession Slots"] = "%s's Beruf Pl\195\164tze",
		["Characters on "] = "Charaktere auf ",
    }
end)