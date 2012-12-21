local L = AceLibrary("AceLocale-2.0"):new("KCIFu")

-- English / US translation
L:RegisterTranslations("enUS", function () return {
	["Caption"] = "KC Items",
	["ShortCaption"] = "KCI",
	["ClickTooltip"] = "Click to open Linkview window",
	
	-- Statistic --
	["Stats"] = "Statistic: Known Items",
	["Stats_Items"] = "Total Items",
	["Stats_Sell"] = "Sell Prices",
	["Stats_Buy"] = "Buy Prices",
	["Stats_NoItems"] = "Empty database ...",
	
	-- Menu Items --
	["UseShortCaption"] = "Use brief caption",
	
	-- Auction --
	["Menu_Auction"] = "Auction",
	["Menu_Auction_Short"] = "Use brief captions",
	["Menu_Auction_Bid"]   = "Show current Bid",
	["Menu_Auction_Stats"] = "Show item statistic",
	
	-- Broker --
	["Menu_Broker"] = "Broker",
	["Menu_Broker_AF"] = "Enable suggesting prices",
	["Menu_Broker_AF_Mode"] = "Suggest mode:",
	["Menu_Broker_AF_Mixed"]   = "Mixed (Memory, Smart, Vendor, None)",
	["Menu_Broker_AF_Memory"]  = "Memory (based on last rate)",
	["Menu_Broker_AF_Smart"]   = "Smart (based on market average)",
	["Menu_Broker_AF_Vendor"]  = "Vendor (based on vendor price)",
	["Menu_Broker_AF_None"]    = "None (suggest only buyout)",
	["Menu_Broker_AF_SkipMem"] = "Skip \"Memory\" in \"Mixed\" Mode",
	["Menu_Broker_Remdur"] = "Remember last auction duration",
	["Menu_Broker_Cut"] = "Auction cut in \"Smart\" mode (%)",
	["Menu_Broker_Colorize"] = "Colorize Auction",
	["Menu_Broker_AHColors"] = "Auction Colors:",
	["Menu_Broker_AHC_Known"] = "Known recipes",
	["Menu_Broker_AHC_Sell"] = "Vendor will pay more",
	["Menu_Broker_AHC_Buy"] = "Best Buyout",
	["Menu_Broker_AHC_Min"] = "Best Bid",
		
	-- Chatlink --
	["Menu_ChatLink"] = "Chatlink",
	["Menu_ChatLink_Enable"] = "Convert [text] to |cff00ff00[link]|r when typing",
	
	["Menu_ItemInfo"] = "Item Info",
	["Menu_ItemInfo_Enable"] = "Show additional information",
	
	-- Tooltip --
	["Menu_Tooltip"] = "Tooltip",
	["Menu_Tooltip_Mode"] = "Display Mode:",
	["Menu_Tooltip_Separated"] = "Separated",
	["Menu_Tooltip_Merged"]    = "Merged",
	["Menu_Tooltip_Splitline"] = "Split info to sides",
	["Menu_Tooltip_Separate"] = "Separate by empty lines",
	["Menu_Tooltip_Moneyframe"] = "Money as icons",
	
	-- SellValue -- 
	["Menu_SellValue"] = "Sell Value",
	["Menu_SellValue_Enable"] = "Show vendor price",	
	["Menu_SellValue_Short"] = "Use brief captions",
	["Menu_SellValue_single"] = "Show price for a single item",
	
	["dummy"] = ''
} end)