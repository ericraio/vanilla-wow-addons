--[[--------------------------------------------------------------------------------
  ItemSync Chinese Localization

  Author:  Derkyle
  Website: http://www.manaflux.com
  
  Chinese Translation By: Kadora (@Wrath of Titans)
-----------------------------------------------------------------------------------]]


if (GetLocale()=="zhCN") then
	ISYNC_COST      	= "出售价格 ";
	ISYNC_VENDORCOST      	= "购买价格 ";
	ISYNC_NOSELLPRICE	= "无售价信息";
	
	ISYNC_SHOWVALID		= "有效";
	ISYNC_SHOWINVALID	= "无效";
	ISYNC_SHOWSUBITEM	= "-Sub Item-";
	ISYNC_SHOWSUBITEM2	= "-Name Unknown-";
	
	ISYNC_SHOWINVALID_BUTTON = "显示无效物品";

	ISYNC_SLASHRESETWINDOWS = "Reset All Windows";
	
	ISYNC_ITEMISINVALID_TOOLTIP1 = "<物品无效>";
	ISYNC_ITEMISINVALID_TOOLTIP2 = "Note: There may be a chance that\nthe item is now valid.  Pass your\nmouse over the link again to check.\nIf you see the actual tooltip then\nthe item is now valid. [REFRESH]";
	ISYNC_ITEMISINVALID_TOOLTIP3 = "\n\nWARNING: YOU MAY GET\nDISCONNECTED!\nUSE AT YOUR OWN RISK!";
	ISYNC_ITEMISINVALID_TOOLTIP4 = "|c00FF9900Click Link:|r|c00BDFCC9 Send to ItemID Tool.|r";

	ISYNC_OPT_MONEY1 = "|c00FFFFFF1|r|c00E2CD54g|r |c00FFFFFF1|r|c00AEAEAEs|r |c00FFFFFF1|r|c00D7844Dc|r";
	ISYNC_OPT_MONEY2 = "|c00FFFFFF1|r |c00E2CD54g|r |c00FFFFFF1|r |c00AEAEAEs|r |c00FFFFFF1|r |c00D7844Dc|r";
	ISYNC_OPT_MONEY3 = "|c00FFFFFF1|r|c00E2CD54[g]|r |c00FFFFFF1|r|c00AEAEAE[s]|r |c00FFFFFF1|r|c00D7844D[c]|r";
	ISYNC_OPT_MONEY4 = "|c00FFFFFF1|r|c00E2CD54[G]|r |c00FFFFFF1|r|c00AEAEAE[S]|r |c00FFFFFF1|r|c00D7844D[C]|r";
	ISYNC_OPT_MONEY5 = "|c00FFFFFF1|r |c00E2CD54[g]|r |c00FFFFFF1|r |c00AEAEAE[s]|r |c00FFFFFF1|r |c00D7844D[c]|r";
	ISYNC_OPT_MONEY6 = "|c00FFFFFF1|r |c00E2CD54[G]|r |c00FFFFFF1|r |c00AEAEAE[S]|r |c00FFFFFF1|r |c00D7844D[C]|r";
	ISYNC_OPT_MONEY7 = "|c00E2CD541|r|c00FFFFFF.|r|c00AEAEAE2|r|c00FFFFFF.|r|c00D7844D3|r";

	ISYNC_NEWITEMS = "|c00FF9933New Items Available! (Click Refresh)|r";

	ISYNC_OPTGOLD1 = "金";
	ISYNC_OPTGOLD2 = "G";
	ISYNC_OPTSILVER1 = "银";
	ISYNC_OPTSILVER2 = "S";
	ISYNC_OPTCOPPER1 = "铜";
	ISYNC_OPTCOPPER2 = "C";

	ISYNC_SORT_NAME = "名称排序";
	ISYNC_SORT_RARITY = "稀有度排序";
	
	ISYNC_BT_QUICKSEARCH = "Quick Search";
	ISYNC_BT_SEARCH = "搜索";
	ISYNC_BT_REFRESH = "刷新";
	ISYNC_BT_OPTIONS = "选项";
	ISYNC_BT_FILTERS = "过滤";
	ISYNC_BT_BAGVIEW = "背包察看";
	ISYNC_BT_MODS = "插件";
	ISYNC_BT_MAIN = "主窗口";
	ISYNC_BT_ITEMID = "物品ID";
	ISYNC_BT_MINIMAP = "Minimap";
	ISYNC_BT_FAVORITES = "Favorites";
	ISYNC_BT_PURGE = "Purge";
	
	ISYNC_MAIN_HEADER_OPTIONS = "选项";
	ISYNC_MAIN_HEADER_OPTIONSMOD = "插件选项";
	ISYNC_MAIN_HEADER_OPTIONSSERVERS = "服务器";
	ISYNC_MAIN_HEADER_OPTIONSCLEAN = "整理";
	ISYNC_MAIN_HEADER_OPTIONSGENERAL = "General";
	
	ISYNC_MONEYDISPLAY_HEADER = "显示钱币";
	
	ISYNC_FILTER_HEADER1 = "根据稀有度过滤";
	ISYNC_FILTER_HEADER2 = "根据稀有度清空";
	ISYNC_FILTER_HEADER3 = "清空无效物品";
	ISYNC_FILTER_HEADER4 = "清除重复物品";
	
	ISYNC_OPTIONS_HEADER1 = "出售价格";
	ISYNC_OPTIONS_HEADER1_SUB1 = "在提示中显示出售价格。";

	ISYNC_OPTIONS_HEADER2 = "购买价格";
	ISYNC_OPTIONS_HEADER2_SUB1 = "在提示中显示购买价格。";
	
	ISYNC_OPTIONS_HEADER3 = "物品数量框";
	ISYNC_OPTIONS_HEADER3_SUB1 = "显示物品数量框。";
	
	ISYNC_OPTIONS_HEADER4 = "数据优化";
	
	ISYNC_OPTIONS_HEADER5 = "钱币显示";
	ISYNC_OPTIONS_HEADER5_SUB1 = "用钱币图标显示金钱。";

	ISYNC_OPTIONS_OPTIMIZE = "优化";
	
	ISYNC_OPTIONS_MODS_HEADER1 = "AuctionMatrix/AuctionSync";
	ISYNC_OPTIONS_MODS_HEADER2 = "Auctioneer/Enchantrix";
	ISYNC_OPTIONS_MODS_HEADER3 = "Reagent Info";
	ISYNC_OPTIONS_MODS_HEADER4 = "Quality Alert";
	ISYNC_OPTIONS_MODS_HEADER5 = "Invalid Alert";
	ISYNC_OPTIONS_MODS_HEADER6 = "AllInOneInventory";
	ISYNC_OPTIONS_MODS_HEADER7 = "MyInventory";
	
	ISYNC_OPTIONS_MODS_HEADER1_SUB1 = "将物品数据发送到AM/AS。";
	ISYNC_OPTIONS_MODS_HEADER2_SUB1 = "将物品数据发送到Auctioneer/Enchantrix。";
	ISYNC_OPTIONS_MODS_HEADER3_SUB1 = "将物品数据发送到Reagent Info。";
	ISYNC_OPTIONS_MODS_HEADER4_SUB1 = "显示质量预警信息。";
	ISYNC_OPTIONS_MODS_HEADER5_SUB1 = "显示无效物品处理信息。";
	ISYNC_OPTIONS_MODS_HEADER6_SUB1 = "将物品数据发送到AllInOneInventory。";
	ISYNC_OPTIONS_MODS_HEADER7_SUB1 = "将物品数据发送到MyInventory。";


	ISYNC_OPTIONS_SERVER_BUTTON = "服务器";
	ISYNC_OPTIONS_SERVER_HEADER1 = "合并各服务器数据库";
	ISYNC_OPTIONS_SERVER_HEADER1_SUB1 = "在不同的服务器上使用同一数据库。";
	ISYNC_OPTIONS_SERVER_MERGECOMPLETE = "合并成功。";

	ISYNC_BV_HELP = "显示堆叠物品总数";
	ISYNC_BV_HELP2 = "隐藏空价格";
	ISYNC_BV_HELP3 = "价格排序";
	ISYNC_BV_HELP4 = "稀有度排序";
	
	ISYNC_OPTIMIZE_TEXT      	= "正在优化";
	ISYNC_OPTIMIZE_COMPLETE      	= "优化完成";
	
	ISYNC_CLEANDB = "整理";
	ISYNC_CLEANDB_HEADER = "整理物品数据库！";
	ISYNC_CLEANDB_TOOLTIP = "进行简单的数据库整理.\n将无效物品同有效物品分开";
	ISYNC_CLEAN_SUCCESS = "整理完毕。";
	
	ISYNC_OPTIONS_CLEAN_HEADER1 = "提示物品纹理图标";
	ISYNC_OPTIONS_CLEAN_HEADER1_SUB1 = "在提示中显示物品纹理图标。";

	ISYNC_OPTIONS_CLEAN_HEADER2 = "ItemSync MouseOver Inspect";
	ISYNC_OPTIONS_CLEAN_HEADER2_SUB1 = "Enable |c00A2D96F(MAY cause lag)|r";

	ISYNC_OPTIONS_GENERAL_HEADER1 = "ItemSync Chat Type Links";
	ISYNC_OPTIONS_GENERAL_HEADER1_SUB1 = "Enable the use of Type Links while typing.";
	
	ISYNC_MINIMAPBUTTON_HEADER = "ItemSync小地图按钮";
	ISYNC_MINIMAPBUTTON_TOOLTIP = "这个选项允许你显示/隐藏小地图按钮\n和设置小地图按钮的位置。";
	ISYNC_MINIMAPBUTTON_SLIDERTEXT = "设置小地图按钮位置。";
	ISYNC_MINIMAPBUTTON_CHECKBUTTON = "显示ItemSync小地图按钮";
	
	ISYNC_ITEMIDFRAME_WARNING = "|c00FF0000警告: ItemSync的作者不对任何掉线现象负责！|r\n|c00A2D96F后果自负！|r";
	ISYNC_ITEMID_GREENBUTTON_WARNING = "|c00A2D96FThis item was inputed\nusing the ItemID tool.|r\n\n|c00FF0000The Creator of ItemSync\ntakes no responsibility in\ndisconnections caused by\nitems inputted by the\nuser themselves.|r";

	ISYNC_DELETEITEM_MSG_PART1 = "你确定要删除吗？";
	ISYNC_DELETEITEM_MSG_PART2 = "注意：此操作不可还原！";

	ISYNC_QUALITY_CHANGE1 = "|c00A2D96FItemSync: Quality for [|c00FF9900";
	ISYNC_QUALITY_CHANGE2 = "|r|c00A2D96F] has been updated.  Please refresh to view new quality.|r";

	ISYNC_DBUPDATE = "Database Update";
	ISYNC_DBUPDATE_INFO = "|c00FFFFFFItemSync must upgrade the database.|r\n|c00FF0000If you don't, ItemSync will be disabled.|r";
	
	ISYNC_PURGEDB = "Purge Database";
	ISYNC_PURGEDB_HEADER = "RESET/PURGE ITEM DATABASE";
	ISYNC_PURGEDB_TOOLTIP = "This will purge the entire item database.\n\n|c00FF0000NOTE: This is irreverable!\n[You cannot -UNDO- basically]!|r";

	ISYNC_CLEANER_HEADER = "Invalid Cleaner";
	ISYNC_CLEANER_BUTTON = "Start Cleaning";
	ISYNC_CLEANER_TOOLTIP = "Will run through all the invalids\nand attempt to validate them.n\n\n|c00FF0000WARNING: The creator of\nItemSync is not responsible\nfor any disconnections\nthat may occur!";
	ISYNC_CLEANER_COMPLETE = "Invalid cleaning process is complete.";

	ISYNC_HELPBUTTON = "[帮助]";
	ISYNC_HELPPANEL_TOOLTIP = "打开帮助窗口。";
	ISYNC_HELPPANEL_DESC = "欢迎使用ItemSync。ItemSync是一个收集你碰到所有物品的强大插件。如果ItemSync不能判断物品，它会将物品放在无效物品列表中，以便以后处理。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n|c00FF0000稀有度下拉菜单：|r\n允许你按照选定的方法排列物品列表。\n\n|c00FF0000刷新按钮：|r\n按照上次选定的方法刷新物品列表。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n|c00FF0000搜索按钮：|r\n允许你使用不同的选项搜索物品数据库。\n\n|c00FF0000显示无效物品：|r\n显示ItemSync存储的无效物品列表。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n|c00FF0000过滤按钮：|r\n允许你访问过滤面板。\n\n|c00FF0000背包察看：|r\n打开一个显示你所有物品及其售价的窗口。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n|c00FF0000选项按钮：|r\n允许你访问选项面板。\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF搜索选项：|r\n\n你可以使用多种可选项来自定义搜索。如果你想贴出搜索出的物品信息，只需要关闭搜索窗口，然后从物品列表中Shift+左击来发布物品信息。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."一旦你关闭主窗口，搜索结果会消失。主窗口将被刷新，以显示所有物品。\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF过滤选项：|r\n\n在这个窗口里，你可以设置ItemSync抓取何种稀有度的物品。注意：这无论如何都不会过滤主窗口中的物品显示。它只是告诉ItemSync你想要它以后存储何种质量的物品而已。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n在这个面板里，也有一些清除选项。请谨慎使用这些功能，因为它们将不可还原。当你清除重复物品时，它会从有效物品库和无效物品库中清除所有重复的该件物品。当你清除无效物品时同样如此";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n千万小心使用稀有度清除。它不会给你警告，而是清除所有你选中的稀有度物品。如果你选错了也无法还原。\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF背包察看：|r\n\n这个窗口允许你察看你拥有的所有有价值的物品。你有若干可用选项，包括根据稀有度和价格排序。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n注意：你需要先同一个商人交易才能在背包察看中列出物品。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n背包察看同其他任何一个背包一样。你可以修理、出售、使用物品。把它当成你的另一个整合背包吧。\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF选项菜单：|r\n\n这个窗口允许你修改ItemSync的一些可视效果。你可以打开/关闭物品售卖价格。你甚至可以选择钱币是以文本方式还是图标方式显示。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n文本方式和图标方式不能并存。请注意许多插件使用小提示窗，而ItemSync不可能完全和它们兼容。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n注意：你勾选售卖价格选项之后才会显示钱币价格。\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF选项插件菜单:|r\n\n这个窗口允许你设置ItemSync将数据发送到哪些插件。这些功能可以大大增加其他插件的功能。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n请注意关闭这些选项，就会停止数据的发送。如果因为某些原因，另一个插件仍可以得到信息并放到小提示窗里，那是因为那个插件链接到了ItemSync里。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n这表示那个插件已经能够使用一些ItemSync的功能。那样就不需要ItemSync来发送信息了。最简单的解决方式是关闭相应的发送选项。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n如果你不希望出现任何关于质量改变或者处理无效物品的报告，那么可以关闭相应选项。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n|c00A2D96F优化按钮：|r\n\n允许ItemSync仔细检查你的所有物品数据，以察看它们是否有效。这个选项-同时-会更新没件物品的搜索特性，使他们更容易被搜索到。";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n\n优化也会清理数据库，把无效物品和有效物品分开。这是一个不错的功能，推荐不时地使用它，特别在魔兽升级补丁生效后。\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFF==============================|r\n\n";
	ISYNC_HELPPANEL_DESC = ISYNC_HELPPANEL_DESC.."\n|c00FFFFFFHow can I add items while I type?|r\n\nIt's simple just type it out within brackets as you go.  So if you type [copper bar] it will replace it with the actual link.  It's not case sensative so don't worry.\n\nNOTE: Make sure you have ItemSync Type Links enabled under the general tab of the options panel.\n\n";
	
	
	ISYNC_HELP_SUB1 = "这一选项允许ItemSync只抓取你选定的稀有度物品。\n\n|c00FF0000注意：它不会排列或过滤主物品列表！|r";
	ISYNC_HELP_SUB2 = "这会删除有效或无效物品库中的任意质量的重复物品。\n\n|c00FF0000注意: 这一步不可还原！|r";
	ISYNC_HELP_SUB3 = "这会清除所有无效物品。\n\n|c00FF0000注意: 这一步不可还原！|r";
	ISYNC_HELP_SUB4 = "这会根据选定的稀有度清除物品。\n\n|c00FF0000注意: 这一步不可还原！|r";
	ISYNC_HELP_SUB5 = "选择钱币的显示格式。";
	ISYNC_HELP_SUB6 = "选择是否显示物品数量框。";
	ISYNC_HELP_SUB7 = "选择是否显示物品购买价格。";
	ISYNC_HELP_SUB8 = "选择是否显示物品出售价格。";
	ISYNC_HELP_SUB9 = "优化：允许整理物品质量并更新有效和无效物品列表。";
	ISYNC_HELP_SUB10 = "选择这个选项将允许ItemSync发送信息到AuctionMatrix供其处理。";
	ISYNC_HELP_SUB11 = "选择这个选项将允许ItemSync发送信息到Auctioneer/Enchantrix供其处理。";
	ISYNC_HELP_SUB12 = "选择这个选项将允许ItemSync发送信息到Reagent Info供其处理。";
	ISYNC_HELP_SUB13 = "选择是否想要显示物品质量改变报告。";
	ISYNC_HELP_SUB14 = "选择是否想要显示无效物品被处理为有效的报告。";
	ISYNC_HELP_SUB15 = "选择是否想要显示钱币显示方式切换的报告。";
	ISYNC_HELP_SUB16 = "这会合并ItemSync数据库。\n这将允许你在多个服务器使用同一个数据库。\n\n|c00FF0000注意: 这一步不可还原！|r";
	ISYNC_HELP_SUB17 = "选择是否发送提示数据到AllInOneInventory.";
	ISYNC_HELP_SUB18 = "选择是否发送提示数据到MyInventory.";
	ISYNC_HELP_SUB19 = "选择是否在物品提示左边显示物品纹理图标。";
	ISYNC_HELP_SUB20 = "If this option is enabled\nthen any items you type via\nchat within brackets will be\nreplaced with a clickable item link.\n\n|c00A2D96FExample: [copper bar]\nwould be replaced with\nthe actual clickable item link.|r";
	ISYNC_HELP_SUB21 = "If this option is enabled,\nthen itemsync will gather\nitems by inspecting players\nwhen you pass your mouse\nover them.\n\n|c00A2D96FNote: This may case lag!|r";

	
	ISYNC_OLDDBDELETED = "旧数据库已被删除。已经建立一个正确格式的新数据库。";
	
	ISYNC_DUPEITEMDELETED = "重复物品已被删除";
	ISYNC_INVALIDPURGESUCCESS = "无效物品已被清除";
	ISYNC_FILTERPURGESUCCESS = "物品已被清除";
	ISYNC_FILTERINVALIDSELECTION = "无效质量选择";
	
	ISYNC_FILTER_INVALIDCHANGED = "一些无效物品已经有效。请按刷新察看这些物品。";
	
	ISYNC_FILTER_SELECT1 = "|cff9d9d9d粗糙|r";
	ISYNC_FILTER_SELECT2 = "|cffffffff普通|r";
	ISYNC_FILTER_SELECT3 = "|cff1eff00优秀|r";
	ISYNC_FILTER_SELECT4 = "|cff0070dd精良|r";
	ISYNC_FILTER_SELECT5 = "|cffa335ee史诗|r";
	ISYNC_FILTER_SELECT6 = "|cffff8000逆天|r";
	ISYNC_FILTER_SELECT7 = "|cff57BDFB未知|r";

	ISYNC_DELETE_MSGRETAKE = "|c00A2D96F"..ISYNC_DELETEITEM_MSG_PART1.." \n[|r%s|c00A2D96F]?|r|c00FF0000\n"..ISYNC_DELETEITEM_MSG_PART2..".|r";
	ISYNC_DELETE_ITEMMSG = "Item Deleted (Click Refresh)";

	ISYNC_ADDEDTOFAV = "|c00FFFFFFAdded|r|c00FA747B to Favorites";
	ISYNC_FAV_HELP = "|c00FFFFFFHow to add to Favorites:|r\nControl+Shift+Right-Click any item on the main ItemSync window.\n\n|c00FFFFFFHow to remove an item:|r\nClick on the small minus button next to the item to remove it.\n\n|c00FFFFFFHow to link an item:|r\nYou can link any item exactly the same way, as on the main ItemSync window.";
	ISYNC_FAV_CLICKREMOVE_TOOLTIP = "|c00FC5252Click to -REMOVE-:|r\n";
	ISYNC_REMFAV = "|c00FFFFFFRemoved|r|c00FA747B from Favorites";
	ISYNC_FAV_PURGECHK = "|c00FFFF00Are you sure you want to purge this users favorites?|r\n\n|c00FF0000NOTE: This is irreverable!\n[You cannot -UNDO- basically]!|r";

	StaticPopupDialogs["ISYNC_PURGEFAVITEM_CONFIRM"] = {
			text = TEXT(""),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				ISync:Fav_Purge();

			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};


	StaticPopupDialogs["ISYNC_DELETEITEM_CONFIRM"] = {
			text = TEXT(""),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				ISync:DeleteItem();

			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};

	StaticPopupDialogs["ISYNC_CLEANER_CONFIRM"] = {
			text = TEXT("|c00A2D96F\nAre you sure you want to run the Invalid Cleaner?\n|c00FF0000WARNING: YOU MAY DISCONNECT!!!."),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: Invalid cleaning process has begun!  The progress bar should be at the center of your screen.  It may be behind some windows.");	
				if(ISync and ISync.InvCleaner) then ISync:InvCleaner(0); end
				
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};

	StaticPopupDialogs["ISYNC_OPTIMIZE_CONFIRM"] = {
			text = TEXT("|c00A2D96F\n你确定想要优化吗？\n注意：这个过程不能停止。"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: 正在开始优化！进度条应该在屏幕中央，可能在一些窗口后面。");	
				if(ISync and ISync.Optimize) then ISync:Optimize(0); end
				
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};
	
	StaticPopupDialogs["ISYNC_PURGEDATA_CONFIRM"] = {
			text = TEXT("|c00FF0000\n这一步不可还原！！\n\n你确定想要清除数据库吗？\n\n注意：这个动作不能还原！"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				if(ISync) then ISync:FilterPurge(); end
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};
	
	StaticPopupDialogs["ISYNC_PURGEINVALID_CONFIRM"] = {
			text = TEXT("|c00FF0000\n这一步不可还原！！\n\n你确定想要清除无效物品吗？\n\n注意：这个动作不能还原！"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				if(ISync) then ISync:FilterPurgeInvalid(); end
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};
	

	StaticPopupDialogs["ISYNC_MERGEDB_CONFIRM"] = {
			text = TEXT("|c00FF0000\nThis is Irreverable!\n\nAre you sure you want\n to |c00A2D96FMERGE THE DATABASE|r|c00FF0000?\n\nNOTE: This action cannot be undone!"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

					ISync:SetVar({"OPT","SERVER_MERGE"}, 1, "TRUE");
					
					ISYNC_REALM_NUM = ISync:GrabDataProfile();
					
					ISync:Filter_MergeDB(); 
		
					getglobal("ISYNC_Options_General_MergeDBCheckButton1"):SetChecked(1);
				
			end,
			OnCancel = function()

					ISync:SetVar({"OPT","SERVER_MERGE"}, 0, "TRUE");
					
					ISYNC_REALM_NUM = ISync:GrabDataProfile();
					
					getglobal("ISYNC_Options_General_MergeDBCheckButton1"):SetChecked(0);
				
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};
	
	
	
	StaticPopupDialogs["ISYNC_MERGEDB_UNCHECKCONFIRM"] = {
			text = TEXT("|c00FF0000\nAre you sure you want ItemSync to seperate your databases?|r"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

					ISync:SetVar({"OPT","SERVER_MERGE"}, 0, "TRUE");
					
					ISYNC_REALM_NUM = ISync:GrabDataProfile();
					
					getglobal("ISYNC_Options_General_MergeDBCheckButton1"):SetChecked(0);
				
			end,
			OnCancel = function()

					getglobal("ISYNC_Options_General_MergeDBCheckButton1"):SetChecked(1);
				
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};


	-----------------------
	--THIS IS FOR PURGING!!
	-----------------------
	
	StaticPopupDialogs["ISYNC_PURGE1_CONFIRM"] = {
			text = TEXT("|c00FF0000\nThis is Irreverable!\n\nAre you sure you want\n to |c00A2D96FPURGE THE DATABASE|r|c00FF0000?\n\nNOTE: This action cannot be undone!"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				StaticPopup_Show("ISYNC_PURGE2_CONFIRM");
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};
	
	
	
	StaticPopupDialogs["ISYNC_PURGE2_CONFIRM"] = {
			text = TEXT("|c00FF0000\nThis is your last chance!\n\nAre you absolutely sure you want\n to |c00A2D96FPURGE THE DATABASE|r|c00FF0000?\n\nNOTE: There is no turning back!"),
			button1 = TEXT(OKAY),
			button2 = TEXT(CANCEL),
			OnAccept = function()

				ISyncDB = nil;
				ISyncDB = nil; --just in case
				ISyncDB = nil; --just in case
	
				if(ISync_SortIndex) then ISync_SortIndex = nil; end
				if( not ISyncDB ) then ISyncDB = { }; end
				if( not ISyncDB[ISYNC_REALM_NUM] ) then ISyncDB[ISYNC_REALM_NUM] = { }; end

				HideUIPanel(ISync_OptionsFrame);
				HideUIPanel(ISync_BV_Frame);
				HideUIPanel(ISync_FiltersFrame);
				HideUIPanel(ISync_FavFrame);
				HideUIPanel(ISync_SearchFrame);
				HideUIPanel(ISync_MainFrame);
								
				ISYNC_SHOWSEARCH_CHK = 0;
				ISync:Main_Refresh();
				ISync:BV_Refresh();
				
				
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: Item database has been purged.");
				
				
			end,
			showAlert = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
			interruptCinematic = 1
	};
	
	
	-----------------------
	--THIS IS FOR PURGING!!
	-----------------------


	ISYNC_DD_SORT = {
		{ name = ISYNC_SORT_NAME, sortType = "name" },
		{ name = ISYNC_SORT_RARITY, sortType = "rarity" },
	};
	
	
	ISYNC_SEARCH_TITLE = "ItemSync搜索";
	ISYNC_SEARCH_HELP  = "选择你要的搜索范围.";
	ISYNC_SEARCH_HELP1 = "部位:";
	ISYNC_SEARCH_HELP2 = "武器:";
	ISYNC_SEARCH_HELP3 = "专业技能:";
	ISYNC_SEARCH_HELP4 = "防甲:";
	ISYNC_SEARCH_HELP5 = "盾牌:";
	ISYNC_SEARCH_HELP6 = "名称:";
	ISYNC_SEARCH_HELP7 = "稀有度:";
	ISYNC_SEARCH_HELP8 = "等级:";

	ISYNC_SEARCH_BT1   = "搜索";
	ISYNC_SEARCH_BT2   = "重置";
	ISYNC_SEARCH_BT3   = "关闭";

	ISYNC_CROSSBOW_TEXT = "弩";
	ISYNC_GUN_TEXT = "枪械";
	ISYNC_THROWN_TEXT = "投掷武器";
	ISYNC_WAND_TEXT = "魔杖";

	ISYNC_REQUIRE_FIND = "需要(.+)";
	ISYNC_REQUIRE_FIND2 = "等级 (%d+)";
	ISYNC_REQUIRE_FIND3 = "(.+)（(%d+)）";
	
	ISYNC_S_USE = "使用";
	ISYNC_S_EQUIP = "装备";
	ISYNC_S_PASSIVE = "被动";
	ISYNC_S_COH = "击中时可能";
	ISYNC_S_REQUIRES = "需要";
	ISYNC_S_RACES = "种族";
	ISYNC_S_CLASSES = "职业";
	ISYNC_S_ALLSTAT = "所有属性";


	ISYNC_DD_LOCATION = {
		{ name = "NONE", sortType = "NONE" },
		{ name = "副手物品", sortType = "副手物品" },
		{ name = "背部", sortType = "背部" },
		{ name = "单手", sortType = "单手" },
		{ name = "双手", sortType = "双手" },
		{ name = "副手", sortType = "副手" },
		{ name = "手腕", sortType = "手腕" },
		{ name = "胸部", sortType = "胸部" },
		{ name = "腿部", sortType = "腿部" },
		{ name = "脚", sortType = "脚" },
		{ name = "衬衣", sortType = "衬衣" },
		{ name = "远程", sortType = "远程" },
		{ name = "主手", sortType = "主手" },
		{ name = "腰部", sortType = "腰部" },
		{ name = "头部", sortType = "头部" },
		{ name = "手指", sortType = "手指" },
		{ name = "手", sortType = "手" },
		{ name = "肩部", sortType = "肩部" },
		{ name = "饰品", sortType = "饰品" },
		{ name = "公会徽章", sortType = "公会徽章" },
		{ name = "颈部", sortType = "颈部" },
	};


	ISYNC_WeaponLocation = { };
	ISYNC_WeaponLocation["副手物品"] = 1;
	ISYNC_WeaponLocation["背部"] = 2;
	ISYNC_WeaponLocation["单手"] = 3;
	ISYNC_WeaponLocation["双手"] = 4;
	ISYNC_WeaponLocation["副手"] = 5;
	ISYNC_WeaponLocation["手腕"] = 6;
	ISYNC_WeaponLocation["胸部"] = 7;
	ISYNC_WeaponLocation["腿部"] = 8;
	ISYNC_WeaponLocation["脚"] = 9;
	ISYNC_WeaponLocation["衬衣"] = 10;
	ISYNC_WeaponLocation["远程"] = 11;
	ISYNC_WeaponLocation["主手"] = 12;
	ISYNC_WeaponLocation["腰部"] = 13;
	ISYNC_WeaponLocation["头部"] = 14;
	ISYNC_WeaponLocation[ISYNC_GUN_TEXT] = 15;
	ISYNC_WeaponLocation["手指"] = 16;
	ISYNC_WeaponLocation["手"] = 17;
	ISYNC_WeaponLocation["肩部"] = 18;
	ISYNC_WeaponLocation[ISYNC_WAND_TEXT] = 19;
	ISYNC_WeaponLocation["饰品"] = 20;
	ISYNC_WeaponLocation["公会徽章"] = 21;
	ISYNC_WeaponLocation["颈部"] = 22;
	ISYNC_WeaponLocation[ISYNC_THROWN_TEXT] = 23;
	ISYNC_WeaponLocation[ISYNC_CROSSBOW_TEXT] = 24;



	ISYNC_DD_WEAPONS = {
		{ name = "NONE", sortType = "NONE" },
		{ name = "斧", sortType = "斧" },
		{ name = "弓", sortType = "弓" },
		{ name = "匕首", sortType = "匕首" },
		{ name = "锤", sortType = "锤" },
		{ name = "法杖", sortType = "法杖" },
		{ name = "剑", sortType = "剑" },
		{ name = ISYNC_GUN_TEXT, sortType = ISYNC_GUN_TEXT },
		{ name = ISYNC_WAND_TEXT, sortType = ISYNC_WAND_TEXT },
		{ name = ISYNC_THROWN_TEXT, sortType = ISYNC_THROWN_TEXT },
		{ name = "投掷武器", sortType = "投掷武器" },
		{ name = "长柄武器", sortType = "长柄武器" },
		{ name = ISYNC_CROSSBOW_TEXT, sortType = ISYNC_CROSSBOW_TEXT },
	};


	ISYNC_WeaponTypes = { };
	ISYNC_WeaponTypes["斧"] = 1;
	ISYNC_WeaponTypes["弓"] = 2;
	ISYNC_WeaponTypes["匕首"] = 3;
	ISYNC_WeaponTypes["锤"] = 4;
	ISYNC_WeaponTypes["法杖"] = 5;
	ISYNC_WeaponTypes["剑"] = 6;
	ISYNC_WeaponTypes[ISYNC_GUN_TEXT] = 7;
	ISYNC_WeaponTypes[ISYNC_WAND_TEXT] = 8;
	ISYNC_WeaponTypes[ISYNC_THROWN_TEXT] = 9;
	ISYNC_WeaponTypes["投掷武器"] = 10;
	ISYNC_WeaponTypes["长柄武器"] = 11;
	ISYNC_WeaponTypes[ISYNC_CROSSBOW_TEXT] = 12;



	ISYNC_DD_TRADESKILLS = {
		{ name = "NONE", sortType = "NONE" },
		{ name = "炼金术", sortType = "炼金术" },
		{ name = "锻造", sortType = "锻造" },
		{ name = "烹饪", sortType = "烹饪" },
		{ name = "附魔", sortType = "附魔" },
		{ name = "工程学", sortType = "工程学" },
		{ name = "制皮", sortType = "制皮" },
		{ name = "裁缝", sortType = "裁缝" },
	};


	ISYNC_TradeSkills = { };
	ISYNC_TradeSkills["炼金术"] = 1;
	ISYNC_TradeSkills["锻造"] = 2;
	ISYNC_TradeSkills["烹饪"] = 3;
	ISYNC_TradeSkills["附魔"] = 4;
	ISYNC_TradeSkills["工程学"] = 5;
	ISYNC_TradeSkills["制皮"] = 6;
	ISYNC_TradeSkills["裁缝"] = 7;


	ISYNC_DD_ARMOR = {
		{ name = "NONE", sortType = "NONE" },
		{ name = "布甲", sortType = "布甲" },
		{ name = "皮甲", sortType = "皮甲" },
		{ name = "锁甲", sortType = "锁甲" },
		{ name = "板甲", sortType = "板甲" },
	};


	ISYNC_ArmorTypes = { };
	ISYNC_ArmorTypes["布甲"] = 1;
	ISYNC_ArmorTypes["皮甲"] = 2;
	ISYNC_ArmorTypes["锁甲"] = 3;
	ISYNC_ArmorTypes["板甲"] = 4;



	ISYNC_DD_SHIELD = {
		{ name = "NONE", sortType = "NONE" },
		{ name = "小圆盾", sortType = "小圆盾" },
		{ name = "盾牌", sortType = "盾牌" },
	};


	ISYNC_ShieldTypes = { };
	ISYNC_ShieldTypes["小圆盾"] = 1;
	ISYNC_ShieldTypes["盾牌"] = 2;
	
	

	ISYNC_DD_RARITY = {
		{ name = "Any", sortType = "NONE" },
		{ name = "|cff9d9d9d粗糙|r", sortType = 0 },
		{ name = "|cffffffff普通|r", sortType = 1 },
		{ name = "|cff1eff00优秀|r", sortType = 2 },
		{ name = "|cff0070dd精良|r", sortType = 3 },
		{ name = "|cffa335ee史诗|r", sortType = 4 },
		{ name = "|cffff8000逆天|r", sortType = 5},
			
	};


	ISYNC_DD_LEVEL = {
		{ name = "Any", sortType = "NONE" },
		{ name = "1-5", sortType = 0 },
		{ name = "5-10", sortType = 1 },
		{ name = "10-15", sortType = 2 },
		{ name = "15-20", sortType = 3 },
		{ name = "20-25", sortType = 4 },
		{ name = "25-30", sortType = 5 },
		{ name = "30-35", sortType = 6 },
		{ name = "35-40", sortType = 7 },
		{ name = "40-45", sortType = 8 },
		{ name = "45-50", sortType = 9 },
		{ name = "50-55", sortType = 10 },
		{ name = "55-60", sortType = 11 },
		
			
	};
	
end