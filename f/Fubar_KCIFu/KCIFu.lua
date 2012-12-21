local Tablet = AceLibrary("Tablet-2.0") -- Nice Tooltips
local Dewdrop = AceLibrary("Dewdrop-2.0") -- and Menus
local L = AceLibrary("AceLocale-2.0"):new("KCIFu")

KCIFu = AceLibrary("AceAddon-2.0"):new("AceDB-2.0","FuBarPlugin-2.0")

KCIFu.version = "2.0"
KCIFu.date    = "2006-09-08"
KCIFu.hasIcon = true
KCIFu.cannotDetachTooltip = true
KCIFu.cannotAttachToMinimap = true

KCIFu:RegisterDB("KCIFuDB")
KCIFu:RegisterDefaults("profile", {
	UseShortCaption = false
})

function KCIFu:UseShortCaption ()
	return self.db.profile.UseShortCaption
end

function KCIFu:ToggleCaption () 
	self.db.profile.UseShortCaption = not self.db.profile.UseShortCaption
	self:Update()
end

function KCIFu:OnTextUpdate()
	if self:UseShortCaption() then
		self:SetText(L["ShortCaption"])
	else
		self:SetText(L["Caption"])
	end
end

function KCIFu:OnClick() 
	if KC_Linkview ~= nil then
		KC_Linkview:show()
	end
end

function KCIFu:OnTooltipUpdate()
	-- With 2 Columns, Left values - yellow, right - white
	local TipCategory = Tablet:AddCategory("text", L["Stats"], "columns", 2, 
											'child_textR', 1,'child_textG', 1,'child_textB', 0,
											'child_text2R', 1,'child_text2G', 1,'child_text2B', 1
										)
	local _,sSubCount,_,_,sSellPercent,sBuyPercent = KC_Common:Explode(KC_Common.app.db:get("stats"), ",")
	if (type(sSellPercent) ~= "string") then 
		TipCategory:AddLine('text', L["Stats_Items"] , 'text2', sSubCount)
		TipCategory:AddLine('text', L["Stats_Sell"]  , 'text2', format('%s (%s%%)',floor(sSubCount * (sSellPercent/100)), sSellPercent))
		TipCategory:AddLine('text', L["Stats_Buy"]   , 'text2', format('%s (%s%%)',floor(sSubCount * (sBuyPercent/100)), sBuyPercent))
	else
		TipCategory:AddLine('text', L["Stats_NoItems"])
	end
	if ( KC_Linkview ~= nil ) then
		Tablet:SetHint(L["ClickTooltip"]);
	end
end


function KCIFu:OnMenuRequest(mLevel,mValue)
	if mLevel == 1 then
		-- Primary Items
		if KC_Auction ~= nil then 
			Dewdrop:AddLine("text", L["Menu_Auction"], "hasArrow", true, "value", "Menu_Auction")
		end
		if KC_Broker ~= nil then 
			Dewdrop:AddLine("text", L["Menu_Broker"] , "hasArrow", true, "value", "Menu_Broker")
		end
		if KC_ChatLink ~= nil then
			Dewdrop:AddLine("text", L["Menu_ChatLink"], "hasArrow", true, "value", "Menu_ChatLink")
		end
		if KC_ItemInfo ~= nil then 
			Dewdrop:AddLine("text", L["Menu_ItemInfo"], "hasArrow", true, "value", "Menu_ItemInfo")
		end
		if KC_Tooltip ~= nil then 
			Dewdrop:AddLine("text", L["Menu_Tooltip"], "hasArrow", true, "value", "Menu_Tooltip")
		end
		if KC_SellValue ~= nil then
			Dewdrop:AddLine("text", L["Menu_SellValue"], "hasArrow", true, "value", "Menu_SellValue")
		end
		
		Dewdrop:AddLine()
		Dewdrop:AddLine("text", L["UseShortCaption"], "arg1", KCIFu, "func", "ToggleCaption", "checked", self:UseShortCaption())
		Dewdrop:AddLine()
		
	elseif mLevel == 2 then
		if mValue == "Menu_Auction" then
			-- Auction Module Settings
			Dewdrop:AddLine("text", L["Menu_Auction_Short"],
							"arg1", KC_Auction,
							"func", "short",
							"checked", (KC_Auction:GetOpt(KC_Auction.optPath, "short") == 1))
			Dewdrop:AddLine("text", L["Menu_Auction_Bid"],
							"arg1", KC_Auction,
							"func", "showbid",
							"checked", (KC_Auction:GetOpt(KC_Auction.optPath, "showbid") == 1))
			Dewdrop:AddLine("text", L["Menu_Auction_Stats"],
							"arg1", KC_Auction,
							"func", "showstats",
							"checked", (KC_Auction:GetOpt(KC_Auction.optPath, "showstats") == 1))
		elseif mValue == "Menu_Broker" then
			Dewdrop:AddLine("text", L["Menu_Broker_AF"],
							"arg1", KC_Broker,
							"func", "TogAutofill",
							"checked", (KC_Broker:GetOpt(KC_Broker.optPath, "autofill") == 1))
			--Dewdrop:AddLine()
			Dewdrop:AddLine("text",L["Menu_Broker_AF_Mode"],
							"isTitle", true,
							"disabled", (KC_Broker:GetOpt(KC_Broker.optPath, "autofill") ~= 1))
			Dewdrop:AddLine("text",L["Menu_Broker_AF_Mixed"],
							"isRadio", true,
							"disabled", (KC_Broker:GetOpt(KC_Broker.optPath, "autofill") ~= 1),
							"checked", (KC_Broker:GetOpt(KC_Broker.optPath, "fillmode") == KC_ITEMS_LOCALS.modules.broker.modes.mixed),
							"arg1", KC_Broker,
							"func", "SetMode",
							"arg2", "mixed")
			Dewdrop:AddLine("text",L["Menu_Broker_AF_Memory"],
							"isRadio", true,
							"disabled", (KC_Broker:GetOpt(KC_Broker.optPath, "autofill") ~= 1),
							"checked", (KC_Broker:GetOpt(KC_Broker.optPath, "fillmode") == KC_ITEMS_LOCALS.modules.broker.modes.memory),
							"arg1", KC_Broker,
							"func", "SetMode",
							"arg2", "memory")							
			Dewdrop:AddLine("text",L["Menu_Broker_AF_Smart"],
							"isRadio", true,
							"disabled", (KC_Broker:GetOpt(KC_Broker.optPath, "autofill") ~= 1),
							"checked", (KC_Broker:GetOpt(KC_Broker.optPath, "fillmode") == KC_ITEMS_LOCALS.modules.broker.modes.smart),
							"arg1", KC_Broker,
							"func", "SetMode",
							"arg2", "smart")
			Dewdrop:AddLine("text",L["Menu_Broker_AF_Vendor"],
							"isRadio", true,
							"disabled", (KC_Broker:GetOpt(KC_Broker.optPath, "autofill") ~= 1),
							"checked", (KC_Broker:GetOpt(KC_Broker.optPath, "fillmode") == KC_ITEMS_LOCALS.modules.broker.modes.vendor),
							"arg1", KC_Broker,
							"func", "SetMode",
							"arg2", "vendor")
			Dewdrop:AddLine("text",L["Menu_Broker_AF_None"],
							"isRadio", true,
							"disabled", (KC_Broker:GetOpt(KC_Broker.optPath, "autofill") ~= 1),
							"checked", (KC_Broker:GetOpt(KC_Broker.optPath, "fillmode") == KC_ITEMS_LOCALS.modules.broker.modes.none),
							"arg1", KC_Broker,
							"func", "SetMode",
							"arg2", "none")
			Dewdrop:AddLine("text", L["Menu_Broker_Cut"],
							"hasSlider" , true, "hasArrow", true,
							"disabled",  (KC_Broker:GetOpt(KC_Broker.optPath, "autofill") ~= 1) or ((KC_Broker:GetOpt(KC_Broker.optPath, "fillmode") ~= KC_ITEMS_LOCALS.modules.broker.modes.mixed) and (KC_Broker:GetOpt(KC_Broker.optPath, "fillmode") ~= KC_ITEMS_LOCALS.modules.broker.modes.smart)),
							"sliderMin", 50,
							"sliderMax", 150,
							"sliderValue", ((KC_Broker:GetOpt(KC_Broker.optPath, "cut") or 1) * 100),
							"sliderFunc", function(value) 
								-- suppress multiple messages
								KC_Broker:SetOpt(KC_Broker.optPath,"cut", floor(value) / 100)								
							end)
			Dewdrop:AddLine("text", L["Menu_Broker_AF_SkipMem"],
							"arg1", KC_Broker,
							"func", "SkipMem",
							-- Disabled when Autofill Off or Mode not Mixed
							"disabled",  (KC_Broker:GetOpt(KC_Broker.optPath, "autofill") ~= 1) or (KC_Broker:GetOpt(KC_Broker.optPath, "fillmode") ~= KC_ITEMS_LOCALS.modules.broker.modes.mixed),
							"checked", (KC_Broker:GetOpt(KC_Broker.optPath, "skipmem") == 1))
							
			Dewdrop:AddLine()
			Dewdrop:AddLine("text", L["Menu_Broker_Remdur"],
							"checked", (KC_Broker:GetOpt(KC_Broker.optPath, "remduration") == 1),
							"arg1", KC_Broker,
							"func", "RememberDuration")
							
			Dewdrop:AddLine()		
			Dewdrop:AddLine("text", L["Menu_Broker_Colorize"],
							"checked", KC_Broker:GetOpt(KC_Broker.optPath,"ahcolor"),
							"arg1", KC_Broker,
							"func", "AHColor")
			Dewdrop:AddLine("text", L["Menu_Broker_AHColors"],
							"isTitle", true,
							"disabled", not KC_Broker:GetOpt(KC_Broker.optPath,"ahcolor") )
							
			-- get colors
			local knownColor	= {KC_Broker.common:Explode(KC_Broker:GetOpt(KC_Broker.optPath, "knownColor") or ".1!.1!1", "!")}
			local sellColor		= {KC_Broker.common:Explode(KC_Broker:GetOpt(KC_Broker.optPath, "sellColor")  or "1!.5!.8", "!")}
			local buyColor		= {KC_Broker.common:Explode(KC_Broker:GetOpt(KC_Broker.optPath, "buyColor")   or "1!1!0", "!")}
			local minColor		= {KC_Broker.common:Explode(KC_Broker:GetOpt(KC_Broker.optPath, "minColor")   or "0!.8!1", "!")}			
			-- Known Color
			
			Dewdrop:AddLine("text", L["Menu_Broker_AHC_Known"],
							"hasColorSwatch", true,
							"disabled", not KC_Broker:GetOpt(KC_Broker.optPath,"ahcolor"),
							"r", knownColor[1], "g", knownColor[2], "b", knownColor[3],
							"colorFunc", function (r,g,b) KCIFu:SetBrokerColor("knownColor", r,g,b) end)
							
			Dewdrop:AddLine("text", L["Menu_Broker_AHC_Sell"],
							"hasColorSwatch", true,
							"disabled", not KC_Broker:GetOpt(KC_Broker.optPath,"ahcolor"),
							"r", sellColor[1], "g", sellColor[2], "b", sellColor[3],
							"colorFunc", function (r,g,b) KCIFu:SetBrokerColor("sellColor", r,g,b) end)
							
			Dewdrop:AddLine("text", L["Menu_Broker_AHC_Buy"],
							"hasColorSwatch", true,
							"disabled", not KC_Broker:GetOpt(KC_Broker.optPath,"ahcolor"),
							"r", buyColor[1], "g", buyColor[2], "b", buyColor[3],
							"colorFunc", function (r,g,b) KCIFu:SetBrokerColor("buyColor", r,g,b) end)
							
			Dewdrop:AddLine("text", L["Menu_Broker_AHC_Min"],
							"hasColorSwatch", true,
							"disabled", not KC_Broker:GetOpt(KC_Broker.optPath,"ahcolor"),
							"r", minColor[1], "g", minColor[2], "b", minColor[3],
							"colorFunc", function (r,g,b) KCIFu:SetBrokerColor("minColor", r,g,b) end)
		
		elseif mValue == "Menu_ChatLink" then
			Dewdrop:AddLine("text", L["Menu_ChatLink_Enable"],
							"checked", KC_ChatLink.app:ModEnabled(KC_ChatLink),
							"arg1", KC_ChatLink,
							"func", "Toggle")		

		elseif mValue == "Menu_ItemInfo" then
			-- Item Info Settings
			Dewdrop:AddLine("text",L["Menu_ItemInfo_Enable"],
							"checked", (KC_ItemInfo.app:ModEnabled(KC_ItemInfo)),
							"arg1", KC_ItemInfo,
							"func", "Toggle")
		
		elseif mValue == "Menu_Tooltip" then
			-- Tooltip Module Settings
			Dewdrop:AddLine("text", L["Menu_Tooltip_Mode"],
							"isTitle", true)
			Dewdrop:AddLine("text", L["Menu_Tooltip_Separated"],
							"isRadio", true,
							"arg1", KC_Tooltip,
							"func", "modeswitch",
							"checked", (KC_Tooltip:GetOpt(KC_Tooltip.optPath, "separated") == 1))
			Dewdrop:AddLine("text", L["Menu_Tooltip_Merged"],
							"isRadio", true,
							"arg1", KC_Tooltip,
							"func", "modeswitch",
							"checked", (KC_Tooltip:GetOpt(KC_Tooltip.optPath, "separated") ~= 1))
			Dewdrop:AddLine()
			Dewdrop:AddLine("text", L["Menu_Tooltip_Splitline"],
							"arg1", KC_Tooltip,
							"func", "splitline",
							"checked", (KC_Tooltip:GetOpt(KC_Tooltip.optPath, "splitline") == 1))
			Dewdrop:AddLine("text", L["Menu_Tooltip_Separate"],
							"arg1", KC_Tooltip,
							"func", "separatortog",
							"checked", (KC_Tooltip:GetOpt(KC_Tooltip.optPath, "separator") == 1))
			Dewdrop:AddLine("text", L["Menu_Tooltip_Moneyframe"],
							"arg1", KC_Tooltip,
							"func", "moneyframe",
							"checked", (KC_Tooltip:GetOpt(KC_Tooltip.optPath, "moneyframe") == 1))

		elseif mValue == "Menu_SellValue" then
			-- SellValue Module Settings
			Dewdrop:AddLine("text", L["Menu_SellValue_Enable"],
							"arg1", KC_SellValue,
							"func", "Toggle",
							"checked", KC_SellValue.app:ModEnabled(KC_SellValue))
			Dewdrop:AddLine("text", L["Menu_SellValue_Short"],
							"arg1", KC_SellValue,
							"func", "short",
							"checked", (KC_SellValue:GetOpt(KC_SellValue.optPath, "short") == 1))

		end -- selection of mValue
	end -- end selection of mLevel
end

function KCIFu:SetBrokerColor(colorType, r, g, b)
	KC_Broker:SetOpt(KC_Broker.optPath, colorType, format("%s!%s!%s", r, g, b))
	KC_Broker:UpdateGuide()
	if BrowseTitle then
		BrowseTitle:SetText(format("%s  -  %s", KC_Broker.BrowseTitle, KC_ITEMS_LOCALS.modules.broker.labels.guide))
	end
end