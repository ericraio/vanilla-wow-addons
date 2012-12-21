
TITAN_ITEMDED_ID = "ItemDed";

ITEMDED_WARN_THRESHOLD = 4;

-- Local variables
local TitanItemDed_isLoaded = false;
local TitanItemDed_ignored = {};
local TitanItemDed_ItemList = {}; 
local PlayerIdent = GetCVar("RealmName").. UnitName("player");
local TPID_Color = {
	{"ff9d9d9d", "Junk"},			-- gray
	{"ffffffff", "Common"},		-- white
	{"ff1eff00", "Uncommon"},	-- green
	{"ff0070dd", "Rare"},			-- blue
	{"ffa335ee", "Epic"},			-- purple
};

function TitanItemDed_OnLoad()
	this.registry = { 
		id = TITAN_ITEMDED_ID,
		menuText = TITAN_ITEMDED_MENU_TEXT, 
		buttonTextFunction = "TitanPanelItemDedButton_GetButtonText", 
		tooltipTitle = TITAN_ITEMDED_TOOLTIP_TITLE,
		tooltipTextFunction = "TitanPanelItemDedButton_GetTooltipText", 
		icon = "",	
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowChatFeedback = 1
		}
	};
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("MERCHANT_SHOW");
end

function TitanPanelItemDedButton_UpdateIcon()
	TitanItemDed_MakeList();

	local button = TitanUtils_GetButton(TITAN_ITEMDED_ID, true);
	
	if (TitanItemDed_ItemList[1]) then
		button.registry.icon = TitanItemDed_ItemList[1].tex;
	else
		button.registry.icon = "";
	end
	
	TitanPanelButton_UpdateButton(TITAN_ITEMDED_ID);
end

function TitanPanelItemDedButton_GetButtonText(id)
	local numempty = TitanItemDed_GetEmpties();
	local itemtext;
	local numtxt = "(".. numempty.. ")";

	if (TitanItemDed_ItemList[1]) then
		itemtext = TitanItemDed_ItemList[1].fullname.. " ";
	else
		itemtext = "No Item ";
	end
		
	if (numempty < ITEMDED_WARN_THRESHOLD) then
		numtxt = TitanUtils_GetRedText(numtxt);
	else
		numtxt = TitanUtils_GetNormalText(numtxt);
	end
	
	return itemtext, numtxt;
end

function TitanPanelItemDedButton_GetTooltipText()
	local retstr = TITAN_ITEMDED_TOOLTIP_BAGS;

	if (TitanItemDed_ItemList[1]) then
		if (MerchantFrame:IsVisible()) then
			retstr = retstr.. TITAN_ITEMDED_TOOLTIP_SELL;
			retstr = retstr.. TITAN_ITEMDED_TOOLTIP_IGNORE;		
		else
			retstr = retstr.. TITAN_ITEMDED_TOOLTIP_DESTROY;
			retstr = retstr.. TITAN_ITEMDED_TOOLTIP_IGNORE;
		end

		for i,entry in TitanItemDed_ItemList do
			retstr = retstr.. entry.fullname.. "\t".. TitanItemDed_GetTextGSC(entry.price)..  "\n";
		end
	else
		retstr = retstr.. TITAN_ITEMDED_NOITEMDESTROY;
	end
	
	return retstr;	
end

function TitanItemDed_OnEvent()
	if (event == "VARIABLES_LOADED") then
		TitanItemDed_Init();
		TitanItemDed_isLoaded = true;
		TitanPanelItemDedButton_UpdateIcon();
	end
	if (event == "BAG_UPDATE") then
		TitanPanelItemDedButton_UpdateIcon();
	end
end

function TitanPanelRightClickMenu_PrepareItemDedMenu()
	if (not TitanItemDed_isLoaded) then return; end
	
	local info;
	
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_ITEMDED_ID].menuText);
	TitanPanelRightClickMenu_AddSpacer();		
	
	if (MerchantFrame:IsVisible() and (not IsAddOnLoaded("Sell-O-Matic"))) then 
		info = {};
		info.text = "Sell All Junk";
		info.func = TitanItemDed_SellJunk;
		UIDropDownMenu_AddButton(info);
	end

	info = {};
	if (MerchantFrame:IsVisible()) then info.text = "Sell Item";
	else info.text = "Drop Item"; end
	info.func = TitanItemDed_Listman;
	info.value = "t";
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();		

	info = {};
	info.text = "Ignore";
	info.value = "i";
	info.func = TitanItemDed_Listman;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Ignore Always";
	info.value = "ia";
	info.func = TitanItemDed_Listman;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();		

	info = {};
	info.text = "Reset Current";
	info.value = "r";
	info.func = TitanItemDed_Listman;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "Reset All";
	info.value = "ra";
	info.func = TitanItemDed_Listman;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();	
	
	local i;
	local a = {"Junk", "Common", "Uncommon", "Rare", "Epic"};
	TitanPanelRightClickMenu_AddTitle("Threshold");
	for i=1,5 do
		info = {};
		info.text = "|c".. TPID_Color[i][1].. TPID_Color[i][2];
		info.value = i;
		info.func = TitanItemDed_SetThreshold;
		info.checked = (i == TitanItemDedSettings[PlayerIdent].Threshold);
		UIDropDownMenu_AddButton(info);
	end
	
	TitanPanelRightClickMenu_AddSpacer();		
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_ITEMDED_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ITEMDED_ID);

	info = {};
	info.text = "Chat Feedback";
	info.value = "ShowChatFeedback";
	info.func = TitanItemDed_ToggleChatback;
	info.checked = TitanGetVar(TITAN_ITEMDED_ID, "ShowChatFeedback");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();		
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_ITEMDED_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end


function TitanItemDed_ToggleChatback()
	TitanToggleVar(TITAN_ITEMDED_ID, "ShowChatFeedback");
end

function TitanItemDed_OnClick(button)
	if (button == "LeftButton") then
		if(IsShiftKeyDown()) then
			TitanItemDed_Listman("t");
		else
			OpenAllBags();
		end
	end
end

function TitanItemDed_OnDoubleClick(button)
	if (button == "LeftButton") then
		if(IsAltKeyDown()) then
			TitanItemDed_Listman("ia");
		else
			TitanItemDed_Listman("i");
		end
	end
end

function TitanItemDed_SetThreshold()
	local t = {
		["Junk"] = 5,
		["Common"] = 4,
		["Uncommon"] = 3,
		["Rare"] = 2,
		["Epic"] = 1,
	};
	TitanItemDedSettings[PlayerIdent].Threshold = this.value;

	local str = "|c".. TPID_Color[this.value][1].. TPID_Color[this.value][2];
	TitanItemDed_Chatback("Threshold set to ".. str);

	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_Chatback(str)
	if (TitanGetVar(TITAN_ITEMDED_ID, "ShowChatFeedback")) then
		DEFAULT_CHAT_FRAME:AddMessage("<ItemDed> ".. str);
	end
end

function TitanItemDed_GetFullName(name, qual)
	return "|c".. TPID_Color[qual][1].. 
		"[".. name.. "]".. FONT_COLOR_CODE_CLOSE;
end

function TitanItemDed_MakeList()
	TitanItemDed_ItemList = {};
	
	for bag=0,NUM_BAG_FRAMES do
		for slot=1,GetContainerNumSlots(bag) do
		  local price = nil;
		  local item_name = TitanItemDed_GetItemName(bag, slot);
      local item_texture, stackCount = GetContainerItemInfo(bag, slot);

		  if (item_name and stackCount) then
		  	if (TitanItemDed_items[item_name]) then
					price = TitanItemDed_items[item_name];
				end

				if (price) then price = price * stackCount; end

				if (price) then
					if TitanItemDed_IsDroppable(bag, slot) then
						local qual = TitanItemDed_GetQuality(bag, slot);
						
						local n = {};
						n.price = price;
						n.name = item_name;
						n.fullname = TitanItemDed_GetFullName(item_name, qual).. " x".. stackCount;
						n.stack = stackCount;
						n.bag = bag;
						n.slot = slot;
						n.tex = item_texture;
						table.insert(TitanItemDed_ItemList, n);
					end
				end
			end

			if (ID_Debug and item_name and item_isGray and price) then debug_message(item_name, price.." Gray");	end		
			if (ID_Debug and item_name and item_isGray == false and price) then debug_message(item_name, price); end
		end
	end
	
	table.sort(TitanItemDed_ItemList, function(a,b) return a.price<b.price end);
end

function TitanItemDed_Init()
	if (TitanItemDed_alwaysIgnored == nil) then TitanItemDed_alwaysIgnored = {}; end
	if (TitanItemDed_newItems == nil) then TitanItemDed_newItems = {}; end
	TitanItemDed_CleanSaved();
	
	if (TitanItemDedSettings == nil) then
		TitanItemDedSettings = {};
	end

	if (TitanItemDedSettings[PlayerIdent] == nil) then
		TitanItemDedSettings[PlayerIdent] = {};
		TitanItemDedSettings[PlayerIdent].Ignored = {};
		TitanItemDedSettings[PlayerIdent].Threshold = 1;
	end

	if (TitanItemDedSettings[PlayerIdent].Ignored == nil) then
		TitanItemDedSettings[PlayerIdent].Ignored = {};
	end

	if (TitanItemDedSettings[PlayerIdent].Threshold == nil) then
		TitanItemDedSettings[PlayerIdent].Threshold = 1;
	end

	if (not TitanItemDed_unknowns) then
		TitanItemDed_unknowns = {};
	end
			
	TitanPanelItemDedButton_UpdateIcon();
	
	return;
end

function TitanItemDed_Listman(cmd, itemidx)
	local act = cmd;
	local item = TitanItemDed_ItemList[itemidx];
	if (not act) then act = this.value; end
	if (not item) then item = TitanItemDed_ItemList[1]; end
	
	if (act == "i") then
		if item then TitanItemDed_ignored[item.name] = 1; end
		if item then TitanItemDed_Chatback(item.name.." is now ignored."); 
		else TitanItemDed_Chatback("Nothing to ignore!"); end
	end
	if (act == "ia") then
		if item then TitanItemDedSettings[PlayerIdent]["Ignored"][item.name] = 1; end
		if item then TitanItemDed_Chatback(item.name.." is now always ignored.");
		else TitanItemDed_Chatback("Nothing to ignore!"); end
	end
	if (act == "r") then
		TitanItemDed_ignored = {};
		TitanItemDed_Chatback("Current ignored items reset.");
	end
	if (act == "ra") then
		TitanItemDed_ignored = {};
		TitanItemDedSettings[PlayerIdent]["Ignored"] = {};
		TitanItemDed_Chatback("Always ignored items reset.");
	end
	if (act == "t") then
		if item then 
			if (MerchantFrame:IsVisible()) then
				UseContainerItem(item.bag, item.slot);
			else
				TitanItemDed_Chatback("Deleting "..item.fullname.." worth "..item.price);
				PickupContainerItem(item.bag, item.slot);
				DeleteCursorItem();
			end
		else
			TitanItemDed_Chatback(TITAN_ITEMDED_NOITEMDESTROY);
		end
	end
	
	TitanPanelItemDedButton_UpdateIcon();
end

function TitanItemDed_SellJunk()
	for bag=0,NUM_BAG_FRAMES do
		for slot=1,GetContainerNumSlots(bag) do
			local qual = TitanItemDed_GetQuality(bag, slot);
			
			if (qual) then
				if ((qual == 1) and (MerchantFrame:IsVisible())) then
					UseContainerItem(bag, slot);
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Bag Search functions
-------------------------------------------------------------------------------

function TitanItemDed_GetItemName(bag, slot)
  local linktext = nil;
  
  if (bag == -1) then
    linktext = GetInventoryItemLink("player", slot);
  else
    linktext = GetContainerItemLink(bag, slot);
  end

  if linktext then
    local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
    return name;
  else
    return nil;
  end
end

function TitanItemDed_GetQuality(bag, slot)
  local link = nil;
	local color = nil;
  
  if (bag == -1) then
    link = GetInventoryItemLink("player", slot);
  else
    link = GetContainerItemLink(bag, slot);
  end

	if (link) then
		for color, _, _ in string.gfind(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
			for i,c in TPID_Color do
				if (c[1] == color) then
					return i;
				end
			end
		end
	end
	
	return nil;
end

function TitanItemDed_IsDroppable(bag, slot)
	local itemname = TitanItemDed_GetItemName(bag, slot);
	
	if TitanItemDed_ignored[itemname] then return false; end;
	if TitanItemDedSettings[PlayerIdent]["Ignored"][itemname] then return false; end;
	if (TitanItemDed_GetQuality(bag, slot) > TitanItemDedSettings[PlayerIdent].Threshold) then return false; end;
	
	return true;
end

function TitanItemDed_GetEmpties()
	local numempty = 0;
	
	for bag=0,NUM_BAG_FRAMES do
		if (TitanItemDed_IsAmmoBag(bag)) then
			-- Do Nothing
		else
			for slot=1,GetContainerNumSlots(bag) do
			  local item_name = TitanItemDed_GetItemName(bag, slot);
			  if (not item_name) then numempty = numempty+1; end
			end
		end
	end
	
	return numempty;
end

function TitanItemDed_IsAmmoBag(bag)
	local bagname = GetBagName(bag);
	
	if (bagname) then
	  if (string.find(bagname, "Quiver") or string.find(bagname, "Ammo") or string.find(bagname, "Bandolier")) then
			return true;
	  end
	end
	  
  return false;
end

-------------------------------------------------------------------------------
-- Gold formatting code, shamelessly "borrowed" from Auctioneer
-------------------------------------------------------------------------------

function TitanItemDed_GetGSC(money)
	if (money == nil) then money = 0; end
	local g = math.floor(money / 10000);
	local s = math.floor((money - (g*10000)) / 100);
	local c = math.floor(money - (g*10000) - (s*100));
	return g,s,c;
end

GSC_GOLD="ffd100";
GSC_SILVER="e6e6e6";
GSC_COPPER="c8602c";
GSC_START="|cff%s%d|r";
GSC_PART=".|cff%s%02d|r";
GSC_NONE="|cffa0a0a0none|r";

function TitanItemDed_GetTextGSC(money)
	local g, s, c = TitanItemDed_GetGSC(money);
	local gsc = "";
	if (g > 0) then
		gsc = format(GSC_START, GSC_GOLD, g);
		if ((s > 0) or (c > 0)) then
			if (c > 50) then s = s+1; end
			gsc = gsc..format(GSC_PART, GSC_SILVER, s);
		end
	elseif (s > 0) then
		gsc = format(GSC_START, GSC_SILVER, s);
		if (c > 0) then
			gsc = gsc..format(GSC_PART, GSC_COPPER, c);
		end
	elseif (c > 0) then
		gsc = gsc..format(GSC_START, GSC_COPPER, c);
	else
		gsc = GSC_NONE;
	end

	return gsc;
end

-------------------------------------------------------------------------------
-- External Mod search functions
-------------------------------------------------------------------------------

function TitanItemDed_GetEconPrice(item_name)
	if (WOWEcon_Prices[item_name]) then return WOWEcon_Prices[item_name][1]; end
	return nil;
end

function TitanItemDed_CmdScan()
	-- Scan WoWEcon's list, if it exists
	if (WOWEcon_Prices) then
		for item in WOWEcon_Prices do
			if ( (WOWEcon_Prices[item][1]) and (TitanItemDed_newItems[item] == nil) and (TitanItemDed_items[item] == nil) ) then
				if (WOWEcon_Prices[item][1] > 0) then
					TitanItemDed_newItems[item] = WOWEcon_Prices[item][1];
				end
			end
		end
	end
end

function TitanItemDed_CleanSaved()
	local oldNews = TitanItemDed_newItems;
	TitanItemDed_newItems = {};
	
	for item in oldNews do
		if (not TitanItemDed_items[item]) then
			TitanItemDed_newItems[item] = oldNews[item];
		end
	end
end

