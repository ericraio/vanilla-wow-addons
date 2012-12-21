local L = AceLibrary("AceLocale-2.0"):new("FuBar_GarbageFu")
local Tablet = AceLibrary("Tablet-2.0");
local dewdrop = AceLibrary("Dewdrop-2.0");
local compost = AceLibrary("Compost-2.0");
local abacus = AceLibrary("Abacus-2.0");
local PeriodicTable = PeriodicTableEmbed:GetInstance("1");

GarbageFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "AceDebug-2.0");
GarbageFu.version = "1.0." .. string.sub("$Revision: 10349 $", 12, -3);
GarbageFu.date = string.sub("$Date: 2006-09-06 11:24:19 -0700 (Wed, 06 Sep 2006) $", 8, 17);
GarbageFu.hasIcon = true;
GarbageFu.clickableTooltip = true;
GarbageFu.overrideMenu = true;
GarbageFu.printFrame = DEFAULT_CHAT_FRAME;
GarbageFu.debugFrame = DEFAULT_CHAT_FRAME;

GarbageFu:RegisterDB("GarbageFuDB");
GarbageFu:RegisterDefaults("profile", {
	moneyformat = 1,
	namelength = 32,
	ignoreammobag = true,
	ignoreherbbag = false,
	ignoresoulbag = false,
	ignoreenchbag = false,
	sellallbutton = true,
	sellonlygrey = true,
	pricetype = false,
	garbageprices = false,
	itemicon = false,
	version = "",
	textcolor = { r=0.2, g=0.8, b=1 };
	threshold = 0,
	dropsets = {},
	dropitem = {},
	keepsets = {},
	keepitem = {},
});

GarbageFu:RegisterDefaults("account", {
	overrideprices = {};
});

------------------------------------------------------------------------------------------------------
-- Simple Property functions
------------------------------------------------------------------------------------------------------

function GarbageFu:IsAutodrop()
	return self.db.profile.autodrop;
end

function GarbageFu:ToggleAutodrop()
	self.db.profile.autodrop = not self.db.profile.autodrop;
end

function GarbageFu:GetDropThreshold()
	return self.db.profile.threshold;
end

function GarbageFu:IsDropThreshold(value)
	return self.db.profile.threshold == tonumber(value);
end

function GarbageFu:SetDropThreshold(value)
	self.db.profile.threshold = tonumber(value);
	self:UpdateDisplay();
end

function GarbageFu:GetMoneyFormat(value)
	return self.db.profile.moneyformat;
end

function GarbageFu:SetMoneyFormat(value)
	self.db.profile.moneyformat = tonumber(value);
	self:UpdateDisplay();
end

function GarbageFu:GetNameLength(value)
	return self.db.profile.namelength;
end

function GarbageFu.SetNameLength(self,value)
	self.db.profile.namelength = value;
	self:UpdateText();
end

function GarbageFu:IsIgnoringAmmoBag()
	return self.db.profile.ignoreammobag;
end

function GarbageFu:ToggleIgnoreAmmoBag()
	self.db.profile.ignoreammobag = not self.db.profile.ignoreammobag;
	self:InitBagScan();
end

function GarbageFu:IsIgnoringHerbBag()
	return self.db.profile.ignoreherbbag;
end

function GarbageFu:ToggleIgnoreHerbBag()
	self.db.profile.ignoreherbbag = not self.db.profile.ignoreherbbag;
	self:InitBagScan();
end

function GarbageFu:IsIgnoringSoulBag()
	return self.db.profile.ignoresoulbag;
end

function GarbageFu:ToggleIgnoreSoulBag()
	self.db.profile.ignoresoulbag = not self.db.profile.ignoresoulbag;
	self:InitBagScan();
end

function GarbageFu:IsIgnoringEnchBag()
	return self.db.profile.ignoreenchbag;
end

function GarbageFu:ToggleIgnoreEnchBag()
	self.db.profile.ignoreenchbag = not self.db.profile.ignoreenchbag;
	self:InitBagScan();
end

function GarbageFu:IsSafeToDelete()
	return self.vars.safedelete;
end

function GarbageFu:SetSafeToDelete(value)
	self.vars.safedelete = value;
end

function GarbageFu:IsSellAllButton()
	return self.db.profile.sellallbutton;
end

function GarbageFu:ToggleSellAllButton()
	self.db.profile.sellallbutton = not self.db.profile.sellallbutton;
	if self.db.profile.sellallbutton then
		MerchantFrame.sellAllButton:Show();
	else
		MerchantFrame.sellAllButton:Hide();
	end
end

function GarbageFu:IsItemIcon()
	return self.db.profile.itemicon;
end

function GarbageFu:ToggleItemIcon()
	self.db.profile.itemicon = not self.db.profile.itemicon;
	self:UpdateText();
end
	
function GarbageFu:IsPriceType()
	return self.db.profile.pricetype;
end

function GarbageFu:TogglePriceType()
	self.db.profile.pricetype = not self.db.profile.pricetype;
	self:UpdateTooltip();
end
	
function GarbageFu:IsSellOnlyGrey()
	return self.db.profile.sellonlygrey;
end

function GarbageFu:ToggleSellOnlyGrey()
	self.db.profile.sellonlygrey = not self.db.profile.sellonlygrey;
end

function GarbageFu:IsUsingGarbagePrices()
	return self.db.profile.garbageprices;
end

function GarbageFu:ToggleUseGarbagePrices()
	self.db.profile.garbageprices = not self.db.profile.garbageprices;
	if ( self.db.profile.garbageprices ) then
		self.db.profile.garbageprices = self:LoadGarbagePrices();
	else
		self.vars.vendorprices = nil;
		self.vars.pricecache = self:Table(self.vars.pricecache);
	end
	self:InitBagScan();
end
	
------------------------------------------------------------------------------------------------------
-- A little more complicate property functions
------------------------------------------------------------------------------------------------------

function GarbageFu:IsDropItem(itemid)
	if (self.db.profile.dropitem[itemid]) then return true end
end

function GarbageFu:ToggleDropItem(itemid)
	if (self.db.profile.dropitem[itemid]) then
		self.db.profile.dropitem[itemid] = nil;
	else
		self.db.profile.dropitem[itemid] = true;
		self.db.profile.keepitem[itemid] = nil;
	end
	self:UpdateDisplay();	
end

function GarbageFu:IsKeepItem(itemid)
	if (self.db.profile.keepitem[itemid]) then return true end
end

function GarbageFu:ToggleKeepItem(itemid)
	if (self.db.profile.keepitem[itemid]) then
		self.db.profile.keepitem[itemid] = nil;
	else
		self.db.profile.keepitem[itemid] = true;
		self.db.profile.dropitem[itemid] = nil;
	end
	self:UpdateDisplay();	
end

------------------------------------------------------------------------------------------------------
-- Constant data
------------------------------------------------------------------------------------------------------

GarbageFu.vars = {};
GarbageFu.vars.moneyformats = {
	{ name=L["Condensed"], ex=abacus:FormatMoneyCondensed(123456,true,true) },
	{ name=L["Short"], ex=abacus:FormatMoneyShort(123456,true,true) },
	{ name=L["Full"], ex=abacus:FormatMoneyFull(123456,true,true) },
	{ name=L["Extended"], ex=abacus:FormatMoneyExtended(123456,true,true) },
}
GarbageFu.vars.sets = {
	{id="foodall", name=L["Food"], order=1, sub = { 
		{id="food", name=L["Normal Food"], order=1 },
		{id="foodbonus", name=L["Bonus Food"], order=2 },
		{id="foodstat", name=L["Stat Food"], order=3 },
		{id="foodbreadconjured", name=L["Conjured Bread"], order=4 },
		{id="foodraw", name=L["Raw Food"], order=5 },
		{id="foodclassbread", name=L["Bread"], order=6 },
		{id="foodclassfish", name=L["Fish"], order=7 },
		{id="foodclassmeat", name=L["Meat"], order=8 },
		{id="foodclasscheese", name=L["Cheese"], order=9 },
		{id="foodclassfruit", name=L["Fruit"], order=10 },
		{id="foodclassfungus", name=L["Fungus"], order=11 },
	}, },
	{id="waterall", name=L["Water"], order=2, sub = {
		{id="water", name=L["Normal Water"], order=1 },
		{id="waterperc", name=L["Percent Water"], order=2 },
		{id="waterconjured", name=L["Conjured Water"], order=3 },
	}, },
	{id="booze", name=L["Booze"], order=3 },
	{id="tradeskills", name=L["Tradeskill"], order=4, sub = {
		{id="tradeskillalchemy", name=L["Alchemy"], order=1 },
		{id="tradeskillblacksmithing", name=L["Blacksmithing"], order=2 },
		{id="tradeskillcooking", name=L["Cooking"], order=3 },
		{id="tradeskillenchanting", name=L["Enchanting"], order=4 },
		{id="tradeskillengineering", name=L["Engineering"], order=5 },
		{id="tradeskillfirstaid", name=L["First Aid"], order=6 },
		{id="tradeskillleatherworking", name=L["Leatherworking"], order=7 },
		{id="tradeskilltailoring", name=L["Tailoring"], order=8 },
		{id="tradeskillpoison", name=L["Poison"], order=9 },
		{id="tradeskillsmelting", name=L["Smelting"], order=10 },
	}, },
	{id="tradeskilltools", name=L["Tradeskill Tools"], order=5 },
	{id="gatherskill", name=L["Gathered"], order=6, sub = {
		{id="gatherskillfishing", name=L["Fishing"], order=1 },
		{id="gatherskilldisenchant", name=L["Disenchant"], order=2 },
		{id="gatherskillherbalism", name=L["Herbalism"], order=3 },
		{id="gatherskillmining", name=L["Mining"], order=4 },
		{id="gatherskillskinning", name=L["Skinning"], order=5 },
	}, },
	{id="ammo", name=L["Ammunition"], order=7 },
	{id="bandages", name=L["Bandages"], order=8 },
	{id="explosives", name=L["Explosives"], order=9 },
	{id="faire", name=L["Darkmoon Fair"], order=10 },
	{id="fireworks", name=L["Fireworks"], order=11 },
	{id="poisons", name=L["Poisons"], order=12 },
	{id="potionall", name=L["Potions"], order=13, sub = {
		{id="potionhealall", name=L["Heal Potions"], order=1 },
		{id="potionmanaall", name=L["Mana Potions"], order=2 },
		{id="potionrage", name=L["Rage Potions"], order=3 },
		{id="potioncure", name=L["Cure Potions"], order=4 },
		{id="potionbuff", name=L["Buff Potions"], order=5 },
	}, },
	{id="scrolls", name=L["Scrolls"], order=14 },
	{id="reagent", name=L["Reagents"], order=15, sub = {
		{id="reagentpaladin", name=L["Paladin"], order=1 },
		{id="reagentdruid", name=L["Druid"], order=2 },
		{id="reagentmage", name=L["Mage"], order=3 },
		{id="reagentpriest", name=L["Priest"], order=4 },
		{id="reagentrogue", name=L["Rogue"], order=5 },
		{id="reagentshaman", name=L["Shaman"], order=6 },
		{id="reagentwarlock", name=L["Warlock"], order=7 },
	}, },
	{id="weapontempenchants", name=L["Weapon Enchants"], order=16 },
	{id="mounts", name=L["Mounts"], order=17 },
	{id="minipetall", name=L["Mini Pets"], order=18 },
}

------------------------------------------------------------------------------------------------------
-- FuBar required functions
------------------------------------------------------------------------------------------------------

function GarbageFu:OnInitialize()
	-- Put stuff that only neeeds to be done once here
	self.vars.bags = self:Table();
	self.vars.items = self:Table();
	self.vars.colors = self:Table();
	self.vars.pricecache = self:Table();
	-- Get Item quality colors
	for i=0,6 do
		self.vars.colors[i] = self:Table();
		self.vars.colors[i].r, self.vars.colors[i].g, self.vars.colors[i].b, self.vars.colors[i].hex = GetItemQualityColor(i);
		self.vars.colors[i].desc = getglobal("ITEM_QUALITY".. i.. "_DESC");
	end
	-- Create Static dialog for Reset Settings
	StaticPopupDialogs["GARBAGEFU_RESET"] = {
  	text = L["Are you sure you want to reset all your settings for GarbageFU?"],
  	button1 = TEXT(ACCEPT),
  	button2 = TEXT(CANCEL),
  	OnAccept = function() GarbageFu.SettingsReset(self)	end,
	  timeout = 0,
	  whileDead = 1,
 		hideOnEscape = 1
	};
	-- Sort Sets tables
	for i,s in self.vars.sets do
		if s.sub then table.sort(s.sub,function(a,b) return a.order<b.order end) end
	end
	table.sort(self.vars.sets,function(a,b) return a.order<b.order end)
	-- Create the SellAllButton
	self:MakeSellAllButton()
	if self:IsUsingGarbagePrices() then
		self:LoadGarbagePrices();
	end
	-- Store AddOn version. In case we need to check it in the future for upgrades.
	self.db.profile.version = self.version;
end

function GarbageFu:OnEnable()
	-- Stuff that needs to be done every time the mod is enabled
	self:SetSafeToDelete(false);
	if self:IsSellAllButton() then
		MerchantFrame.sellAllButton:Show();
	end
	self:InitBagScan();
	self:MakeSetsTables();
	self:OnEnteringWorld();
	self:SetSafeToDelete(true);
end

function GarbageFu:OnDisable()
	self:SetSafeToDelete(false);
	MerchantFrame.sellAllButton:Hide();
end

function GarbageFu:OnDataUpdate()
end

function GarbageFu:OnTextUpdate()
	self:DebugPrint("OnTextUpdate");
	local item = self:GetFirstDroppableItem();
	if item then
		local text = "";
		if ( string.len(item.name) > self:GetNameLength() ) then
			text = self.vars.colors[item.qual].hex..string.sub(item.name, 1, self:GetNameLength()-2).."..".."|r";
		else
			text = self.vars.colors[item.qual].hex..item.name.."|r";
		end
		if ( item.maxstack > 1 ) then
			text = text.." |cffffff00x"..tostring(item.stack).."|r";
		end
		text = text.." "..self:GetMoneyString(item.totvalue);
		self:SetText(text);
		if self:IsItemIcon() then self:SetIcon(item.tex) else self:SetIcon(true) end
	else
		self:SetText("GarbageFu");
		self:SetIcon(true);
	end
	if self:IsThereItemsToSell() then
		MerchantFrame.sellAllButton:Enable();
	else
		MerchantFrame.sellAllButton:Disable();
	end
end

function GarbageFu:OnTooltipUpdate()
	self:DebugPrint("OnTooltipUpdate");
	local cat;
	if self:IsPriceType() then
		cat = Tablet:AddCategory('columns', 3)
	else
		cat = Tablet:AddCategory('columns', 2)
	end	
	for i,item in self.vars.items do
		if self:IsItemDroppable(item) then
			local stacktext = "|r";
			if ( item.maxstack > 1 ) then
				stacktext = stacktext .. "|r |cffffff00("..tostring(item.stack).."/"..tostring(item.maxstack)..")|r";
			end
			local moneytext = self:GetMoneyString(item.totvalue)
			cat:AddLine(
				'text', self.vars.colors[item.qual].hex..item.name..stacktext, 
				'text2', moneytext, 
				'text3', item.pricetype, 
				'hasCheck', true, 'checked', true, 'checkIcon', item.tex,
				'func', 'OnClickItem', 'arg1', self, 'arg2', item
			)
		end
	end
	if MerchantFrame:IsVisible() then
		Tablet:SetHint(L["Shift-Click to sell item\nControl-Click to add item to keep list"]);
	else
		Tablet:SetHint(L["Shift-Click to drop item\nControl-Click to add item to keep list"]);
	end
end

function GarbageFu:OnMenuRequest(level, value, inTooltip, value2)
	if value then
		if value2 then
			self:DebugPrint("OnMenuRequest level="..level.." value="..value.." value2="..value2);
		else
			self:DebugPrint("OnMenuRequest level="..level.." value="..value);
		end
	else
		self:DebugPrint("OnMenuRequest level="..level);
	end
	if ( level == 1 ) then
		local item = self:GetFirstDroppableItem();
		if item then
			local text = self.vars.colors[item.qual].hex..item.name.."|r";
			if ( item.maxstack > 1 ) then
				text = text.." |cffffff00x"..tostring(item.stack).."|r";
			end
			dewdrop:AddLine('text', text..' '..self:GetMoneyString(item.totvalue), 
				'notClickable', true,	'checked', true, 'checkIcon', item.tex );
			local text = MerchantFrame:IsVisible() and L["Sell this item"] or L["Drop this item"];
			dewdrop:AddLine('text', text, 'arg1', self, 'func', 'DropFirstItem', 'tooltipTitle', text,
				'tooltipText', L["Drops this item, or sells it if the vendor window is open"] );
			if ( item.qual > 0 ) then
				dewdrop:AddLine('text', L["Keep this item"], 'arg1', self, 'func', 'KeepFirstItem',
					'tooltipTitle', L["Keep this item"], 'tooltipText', L["Adds this item to the keep items list"]);
			end
			if MerchantFrame:IsVisible() and self:IsThereItemsToSell() then
				local sellValue = self:GetSellValue();
				GameTooltip:AddLine(L["Value:"].." "..self:GetMoneyString(sellValue));
				if self:IsSellOnlyGrey() then
					dewdrop:AddLine('text', L["Sell all grey items"].." "..self:GetMoneyString(sellValue), 
						'arg1', self, 'func', 'SellAllItems',
						'tooltipTitle', L["Sell all grey items"], 'tooltipText', L["SellsAll TooltipText2"],
						'closeWhenClicked', true );
				else
					dewdrop:AddLine('text', L["Sell all garbage items"].." "..self:GetMoneyString(sellValue), 
						'arg1', self, 'func', 'SellAllItems',
						'tooltipTitle', L["Sell all garbage items"], 'tooltipText', L["SellsAll TooltipText1"],
						'closeWhenClicked', true );
				end
			end
			if ( item.qual > 0 or item.totvalue == 0 or self.db.account.overrideprices[item.id]) then
				dewdrop:AddLine('text', L["Edit value for this item"], 'hasArrow', true,
					'hasEditBox', true, 'editBoxText', tostring(item.value),
					'editBoxArg1', self, 'editBoxFunc', GarbageFu.SetFirstItemValue, 
					'editBoxChangeArg1', self, 'editBoxChangeFunc', GarbageFu.ValidateValue,
					'tooltipTitle', L["Edit value for this item"], 'tooltipText', L["Value TooltipText"] );
			end
			dewdrop:AddLine();
		end
		dewdrop:AddLine('text', L["Drop"], 'hasArrow', true, 'value', 'drop' );
		dewdrop:AddLine('text', L["Keep"], 'hasArrow', true, 'value', 'keep' );
		dewdrop:AddLine('text', L["Edit item values"], 'hasArrow', true, 'value', 'itemvalue' );
		dewdrop:AddLine();
		dewdrop:AddLine('text', L["Options"], 'hasArrow', true, 'value', 'options' );
	elseif ( level == 2 ) then
		if ( value == 'drop' ) then
			dewdrop:AddLine('text', L["Drop"], "isTitle", true );
			dewdrop:AddLine('text', L["Drop Sets"], 'hasArrow', true, 'value', 'dropsets' );
			dewdrop:AddLine('text', L["Drop Items"], 'hasArrow', true, 'value', 'dropitem' );
		elseif ( value == 'keep' ) then
			dewdrop:AddLine('text', L["Keep"], "isTitle", true );
			dewdrop:AddLine('text', L["Keep Sets"], 'hasArrow', true, 'value', 'keepsets' );
			dewdrop:AddLine('text', L["Keep Items"], 'hasArrow', true, 'value', 'keepitem' );
		elseif ( value == 'itemvalue' ) then
			-- Edit item values
			dewdrop:AddLine('text', L["Edit item values"], "isTitle", true );
			local tbl = self:GetCustomItemValueTable();
			for _,i in tbl do
				dewdrop:AddLine('text', self.vars.colors[i.qual].hex .. i.name, 
					'checked', self.db.account.overrideprices[i.id] ~= nil, 'hasArrow', true, 'hasEditBox', true,
					'editBoxText', tostring(i.value),
					'editBoxArg1', self, 'editBoxArg2', i.id, 'editBoxFunc', GarbageFu.SetItemValue, 
					'editBoxChangeArg1', self, 'editBoxChangeFunc', GarbageFu.ValidateValue,
					'tooltipTitle', L["Edit value for this item"], 'tooltipText', L["Value TooltipText"]);
			end
			--compost:Reclaim(tbl,2);
			--tbl = nil;
		elseif ( value == 'options' ) then
			dewdrop:AddLine('text', L["Drop Threshold"], 'hasArrow', true, 'value', 'threshold' );
			dewdrop:AddLine('text', L["Money Format"], 'hasArrow', true, 'value', 'moneyformat' );
			dewdrop:AddLine('text', L["Max Item Name Length"], 'hasArrow', true, 
				'hasSlider', true, 'sliderMin', 5, 'sliderMax', 32, 'sliderStep', 1,
				'sliderValue', self:GetNameLength(), 
				'sliderFunc', GarbageFu.SetNameLength, 'sliderArg1', self );
			dewdrop:AddLine('text', L["Sell All Button on Merchant Window"], 'checked', self:IsSellAllButton(), 
				'arg1', self, 'func', 'ToggleSellAllButton',
				'tooltipTitle', L["Sell All Button on Merchant Window"], 'tooltipText', L["SellAllButton TooltipText"]);
			dewdrop:AddLine('text', L["Only Autosell Grey Items"], 'checked', self:IsSellOnlyGrey(), 
				'arg1', self, 'func', 'ToggleSellOnlyGrey',
				'tooltipTitle', L["Only Autosell Grey Items"], 'tooltipText', L["OnlyGrey TooltipText"]);
			dewdrop:AddLine('text', L["Use Items Icon on Toolbar"], 'checked', self:IsItemIcon(), 
				'arg1', self, 'func', 'ToggleItemIcon');
			dewdrop:AddLine('text', L["Show Price Type in Tooltip"], 'checked', self:IsPriceType(), 
				'arg1', self, 'func', 'TogglePriceType');
			dewdrop:AddLine('text', L["Use GarbageFu Prices"], 'checked', self:IsUsingGarbagePrices(), 
				'arg1', self, 'func', 'ToggleUseGarbagePrices',
				'disabled', not self:IsGarbagePricesAvailable(),
				'tooltipTitle', L["Use GarbageFu Prices"], 'tooltipText', L["GarbageFu_Prices ToltipText"]);
			dewdrop:AddLine('text', L["Ignore Ammo Bags"], 'checked', self:IsIgnoringAmmoBag(), 
				'arg1', self, 'func', 'ToggleIgnoreAmmoBag');
			dewdrop:AddLine('text', L["Ignore Herb Bags"], 'checked', self:IsIgnoringHerbBag(), 
				'arg1', self, 'func', 'ToggleIgnoreHerbBag');
			dewdrop:AddLine('text', L["Ignore Soulshard Bags"], 'checked', self:IsIgnoringSoulBag(), 
				'arg1', self, 'func', 'ToggleIgnoreSoulBag');
			dewdrop:AddLine('text', L["Ignore Enchanting Bags"], 'checked', self:IsIgnoringEnchBag(), 
				'arg1', self, 'func', 'ToggleIgnoreEnchBag');
			--dewdrop:AddLine('text', L["Rescan"], 'arg1', self, 'func', 'InitBagScan' );
			dewdrop:AddLine('text', L["Reset"], 'arg1', "GARBAGEFU_RESET", 'func', StaticPopup_Show, 'closeWhenClicked', true );
			dewdrop:AddLine();
			self:AddImpliedMenuOptions(2);
		end
	elseif ( level == 3 ) then
		if (value2 == 'drop') then
			if ( value == 'dropsets' ) then
				-- Drop - Sets
				dewdrop:AddLine('text', L["Drop Sets"], "isTitle", true );
				for n,i in self.vars.sets do
					local checked = self:IsDropSet(n);
					local checkIcon = "Interface\\Buttons\\UI-CheckBox-Check" 
					if self:IsChildDropSet(n) then
						checked = true;
						checkIcon = "Interface\\Buttons\\UI-CheckBox-Check-Disabled"
					end
					dewdrop:AddLine('text', i.name, 
						'checked', checked, 'checkIcon', checkIcon,
						'disabled', self:IsKeepSet(n),
						'hasArrow', i.sub ~= nil, 'value', n,
						'arg1', self, 'arg2', n, 'func', 'ToggleDropSets' );
				end
			elseif ( value == 'dropitem' ) then
				-- Drop - Items
				dewdrop:AddLine('text', L["Drop Items"], "isTitle", true );
				local tbl = self:GetDropItemTable();
				for _,i in tbl do
					dewdrop:AddLine('text', self.vars.colors[i.qual].hex .. i.name, 
						'checked', self:IsDropItem(i.id),
						'arg1', self, 'arg2', i.id, 'func', 'ToggleDropItem');
				end
				--compost:Reclaim(tbl,2);
				--tbl = nil;
			end
		elseif (value2 == 'keep') then 
			if ( value == 'keepsets' ) then
				-- Keep - Sets
				dewdrop:AddLine('text', L["Keep Sets"], "isTitle", true );
				for n,i in self.vars.sets do
					local checked = self:IsKeepSet(n);
					local checkIcon = "Interface\\Buttons\\UI-CheckBox-Check" 
					if self:IsChildKeepSet(n) then
						checked = true;
						checkIcon = "Interface\\Buttons\\UI-CheckBox-Check-Disabled"
					end
					dewdrop:AddLine('text', i.name, 
						'checked', checked, 'checkIcon', checkIcon,
						'disabled', self:IsDropSet(n),
						'hasArrow', i.sub ~= nil, 'value', n,
						'arg1', self, 'arg2', n, 'func', 'ToggleKeepSets' );
				end
			elseif ( value == 'keepitem' ) then
				-- Keep - Items
				dewdrop:AddLine('text', L["Keep Items"], "isTitle", true );
				local tbl = self:GetKeepItemTable();
				for _,i in tbl do
					dewdrop:AddLine('text', self.vars.colors[i.qual].hex .. i.name, 
						'checked', self:IsKeepItem(i.id),
						'arg1', self, 'arg2', i.id, 'func', 'ToggleKeepItem');
				end
				--compost:Reclaim(tbl,2);
				--tbl = nil;
			end
		elseif ( value2 == 'options' ) then
			if ( value == 'threshold' ) then
				dewdrop:AddLine('text', L["Drop Threshold"], "isTitle", true );
				for a=0,6 do
					dewdrop:AddLine('text', self.vars.colors[a].hex..self.vars.colors[a].desc.."|r",
						'checked', a == self:GetDropThreshold(),
						'arg1', self, 'arg2', a, 'isRadio', true, 
						'func', 'SetDropThreshold' );
				end
			elseif ( value == 'moneyformat' ) then
				dewdrop:AddLine('text', L["Money Format"], "isTitle", true );
				for a,f in self.vars.moneyformats do
					dewdrop:AddLine('text', f.name.."\t"..f.ex,
						'checked', a == self:GetMoneyFormat(),
						'arg1', self, 'arg2', a, 'isRadio', true, 
						'func', 'SetMoneyFormat' );
				end
			else
				self:AddImpliedMenuOptions(2);
			end
		end
	elseif ( level == 4 ) then
		if ( value2 == 'dropsets' ) then
			dewdrop:AddLine('text', L["Drop Set"].." "..self.vars.sets[value].name, "isTitle", true );
			for n,i in self.vars.sets[value].sub do
				dewdrop:AddLine('text', i.name, 
					'checked', self:IsDropSet(value,n),
					'disabled',self:IsKeepSet(value,n),
					'arg1', self, 'arg2', value, 'arg3', n, 'func', 'ToggleDropSets' );
			end
		elseif ( value2 == 'keepsets' ) then
			dewdrop:AddLine('text', L["Keep Set"].." "..self.vars.sets[value].name, "isTitle", true );
			for n,i in self.vars.sets[value].sub do
				dewdrop:AddLine('text', i.name, 
					'checked', self:IsKeepSet(value,n),
					'disabled', self:IsDropSet(value,n),
					'arg1', self, 'arg2', value, 'arg3', n, 'func', 'ToggleKeepSets' );
			end
		end
	end
end

function GarbageFu:OnClick(button)
	if IsShiftKeyDown() then
		self:DropFirstItem();
	end
	if IsControlKeyDown() then
		self:KeepFirstItem();
	end
end

------------------------------------------------------------------------------------------------------
-- Event functions
------------------------------------------------------------------------------------------------------

function GarbageFu:OnClickItem(item)
	if IsShiftKeyDown() then
		self:DropItem(item);
	end
	if IsControlKeyDown() then
		self:KeepItem(item);
	end
end

function GarbageFu:OnEnteringWorld()
	self:RegisterEvent("BAG_UPDATE","OnBagUpdate");
	self:RegisterEvent("MERCHANT_SHOW","OnMerchantOpen");
	self:RegisterEvent("MERCHANT_CLOSED","OnMerchantClose");
	self:RegisterEvent("PLAYER_LEAVING_WORLD","OnLeavingWorld");
	if self:IsEventRegistered("PLAYER_ENTERING_WORLD") then self:UnregisterEvent("PLAYER_ENTERING_WORLD") end
end

function GarbageFu:OnLeavingWorld()
	self:RegisterEvent("PLAYER_ENTERING_WORLD","OnEnteringWorld");
	if self:IsEventRegistered("BAG_UPDATE") then self:UnregisterEvent("BAG_UPDATE") end
	if self:IsEventRegistered("MERCHANT_SHOW") then self:UnregisterEvent("MERCHANT_SHOW") end
	if self:IsEventRegistered("MERCHANT_CLOSED") then self:UnregisterEvent("MERCHANT_CLOSED") end
	if self:IsEventRegistered("PLAYER_LEAVING_WORLD") then self:UnregisterEvent("PLAYER_LEAVING_WORLD") end
end

function GarbageFu:OnBagUpdate(bag)
--	local bag = arg1;
	self:DebugPrint("OnBagUpdate bag="..tostring(bag));
	if ( not bag or bag < 0 or bag > 4 ) then return end
	if ( self.vars.bags[bag].bagName ~= GetBagName(bag) ) then -- Houston, we got a problem
		self:DebugPrint("New or changed bag detected. Doing a full scan");
		self:InitBagScan(); -- New or changed bag detected. Do a full scan
		return
	end
	if self.vars.bags[bag].ignore then return end
	self:SetSafeToDelete(false);
	for slot=1,self.vars.bags[bag].numSlots do
		if not self.vars.bags[bag][slot] then self.vars.bags[bag][slot] = self:Table() end
		local link = GetContainerItemLink(bag, slot);
		local _, stack = GetContainerItemInfo(bag, slot);
		if ( link ~= self.vars.bags[bag][slot].link or stack ~= self.vars.bags[bag][slot].stack ) then
			self.vars.bags[bag][slot].link = link;
			self.vars.bags[bag][slot].stack = stack;
			self:UpdateItem(bag,slot);
			self:SortItems();
			self:UpdateDisplay();
		end
	end
	self:SetSafeToDelete(true);
end

------------------------------------------------------------------------------------------------------
-- Core functions
------------------------------------------------------------------------------------------------------

function GarbageFu:InitBagScan()
	self:SetSafeToDelete(false);
	self.vars.items = self:Table(self.vars.items,3);
	for bag=0,4 do
		self.vars.bags[bag] = self:Table(self.vars.bags[bag],3);
		self.vars.bags[bag].numSlots = GetContainerNumSlots(bag);
		self.vars.bags[bag].bagName = GetBagName(bag);
		self.vars.bags[bag].ignore = self:IgnoreBag(bag);
		if not self.vars.bags[bag].ignore then
			for slot=1,self.vars.bags[bag].numSlots do
				self.vars.bags[bag][slot] = self:Table(self.vars.bags[bag][slot],2);
				self.vars.bags[bag][slot].link = GetContainerItemLink(bag, slot)
				_, self.vars.bags[bag][slot].stack = GetContainerItemInfo(bag, slot)
				self:UpdateItem(bag,slot);
			end
		end
	end
	self:SortItems();
	self:UpdateDisplay();
	self:SetSafeToDelete(true);
end

function GarbageFu:UpdateItem(bag, slot)
	local itemidx = nil;
	local item = nil;
	for a,i in self.vars.items do
		if( i.bag == bag and i.slot == slot ) then
			itemidx = a;
			item = i;
			break;
		end
	end
	if ( self.vars.bags[bag][slot].link ) then
		if ( not item ) then item = self:Table() end
		item.bag = bag;
		item.slot = slot;
		item.stack = self.vars.bags[bag][slot].stack;
		if ( item.link ~= self.vars.bags[bag][slot].link ) then
			item.link = self.vars.bags[bag][slot].link;
			item.id, item.code, item.name, item.color = self:GetItemId(item.link);
			if ( item.id ) then
				_, _, item.qual, _, _, _, item.maxstack, _, item.tex = GetItemInfo(item.id);
				if not item.qual then --- Item not in local cache
					item.qual = self:GetItemQualFromColor(item.color);
					item.tex = "Interface\\Icons\\INV_Misc_QuestionMark.blp";
					item.maxstack = 0;
					item.notseen = true;
				else
					item.notseen = nil;
				end
				self:GetItemValue(item);
			else
				item.notseen = true;
			end
		else -- Just new stack size, recalc totvalue
			if ( item.value ) then
				item.totvalue = item.value * item.stack;
			end
		end		
		if ( not itemidx ) then
			table.insert(self.vars.items, item);
		end		
	elseif ( itemidx ) then
		compost:Reclaim(table.remove(self.vars.items, itemidx),2);
	end
end

local function ItemSortFunc(item1, item2)
	if item1.notseen then return false end
	if item2.notseen then return true end
	if ( item1.totvalue < item2.totvalue ) then return true end
	if ( item1.totvalue == item2.totvalue ) then
		if ( item1.id < item2.id ) then return true end
	end
	return false
end

function GarbageFu:SortItems()
	table.sort(self.vars.items, ItemSortFunc);
end

function GarbageFu:GetItemId(link)
  if link then
		local _, _, color, code, id, name = string.find(link, "|cff(%x%x%x%x%x%x)|Hitem:((%d+):%d+:%d+:%d+)|h%[(.+)%]|h|r")
		return tonumber(id), code, name, color
  end
end

function GarbageFu:GetItemQualFromColor(color)
	for i,c in self.vars.colors do
		if ( color == string.sub(c.hex,5) ) then return i end
	end
end


-- Check if an item is elegiable for drop
function GarbageFu:IsItemDroppable(item)
	if (item.notseen) then self:UpdateItem(item.bag,item.slot) end -- Not seen item. Try again.
	if (item.notseen) then return false end -- Still not seen.
	if (item.totvalue == 0 and item.qual > 0) then return false end -- All items above poor quality without price is not dropped for saftey reasons
	if (self.db.profile.keepitem[item.id]) then return false end
	if (self.db.profile.dropitem[item.id]) then return true end
	if self:IsItemInKeepSets(item.id) then return false end
	if self:IsItemInDropSets(item.id) then return true end
	if (item.qual <= self:GetDropThreshold()) then return true end
	return false
end

function GarbageFu:GetFirstDroppableItem()
	for i,item in self.vars.items do
		if self:IsItemDroppable(item) then
			return item
		end
	end
end

------------------------------------------------------------------------------------------------------
-- Drop down menu functions
------------------------------------------------------------------------------------------------------

function GarbageFu:GetDropItemTable()
	self.vars.temptbl = self:Table(self.vars.temptbl);
--	local tbl = {};
	local tbl2 = self:Table();
	-- Start with itemid's listed as drop
	for i,_ in self.db.profile.dropitem do
		local item = self:Table();
		item.id = i;
		item.name,_,item.qual = GetItemInfo(i);
		if item.name then
			table.insert(self.vars.temptbl,item);
			tbl2[i] = true;
		else
			compost:Reclaim(item,1);
			item = nil;
		end
	end
	-- Add items in inventory with a qual over drop threshold or in keep sets
	for _,i in self.vars.items do
		if ( not i.notseen and not tbl2[i.id] and i.totvalue > 0 and
				 (i.qual>self:GetDropThreshold() or self:IsItemInKeepSets(i.id)) and
				 not self:IsItemInDropSets(i.id)) then
			local item = self:Table();
			item.id = i.id;
			item.name = i.name;
			item.qual = i.qual;
			table.insert(self.vars.temptbl,item);
			tbl2[i.id] = true;
		end
	end
	compost:Reclaim(tbl2,2);
	tbl2 = nil;
	table.sort(self.vars.temptbl,function(a,b) return a.name<b.name end);
	return self.vars.temptbl
end

function GarbageFu:GetKeepItemTable()
	self.vars.temptbl = self:Table(self.vars.temptbl);
	local tbl2 = self:Table();
	-- Start with itemid's listed as keep
	for i,_ in self.db.profile.keepitem do
		local item = self:Table();
		item.id = i;
		item.name,_,item.qual = GetItemInfo(i);
		if item.name then
			table.insert(self.vars.temptbl,item);
			tbl2[i] = true;
		else
			compost:Reclaim(item,1);
			item = nil;
		end
	end
	-- Add items in inventory with a qual eq or below drop threshold or in drop sets. Not poor quality items
	for _,i in self.vars.items do
		if ( not i.notseen and i.totvalue > 0 and i.qual > 0 and not tbl2[i.id] and 
				 (i.qual<=self:GetDropThreshold() or self:IsItemInDropSets(i.id)) and
				 not self:IsItemInKeepSets(i.id)) then
			local item = self:Table();
			item.id = i.id;
			item.name = i.name;
			item.qual = i.qual;
			table.insert(self.vars.temptbl,item);
			tbl2[i.id] = true;
		end
	end
	compost:Reclaim(tbl2,2);
	tbl2 = nil;
	table.sort(self.vars.temptbl,function(a,b) return a.name<b.name end);
	return self.vars.temptbl
end

function GarbageFu:GetCustomItemValueTable()
	self.vars.temptbl = self:Table(self.vars.temptbl);
	local tbl2 = self:Table();
	-- Start with itemid's with a custom price
	for i,v in self.db.account.overrideprices do
		local item = self:Table();
		item.id = i;
		item.value = v;
		item.name,_,item.qual = GetItemInfo(i);
		if item.name then
			table.insert(self.vars.temptbl,item);
			tbl2[i] = true;
		else
			compost:Reclaim(item,1);
			item = nil;
		end
	end
	-- Add items in inventory. Not poor quality items that already have a price
	for _,i in self.vars.items do
		if ( not i.notseen and not tbl2[i.id] and (i.qual > 0 or i.totvalue == 0)) then
			local item = self:Table();
			item.id = i.id;
			item.name = i.name;
			item.qual = i.qual;
			item.value = i.value;
			if not item.value then item.value = 0 end
			table.insert(self.vars.temptbl,item);
			tbl2[i.id] = true;
		end
	end
	compost:Reclaim(tbl2,2);
	tbl2 = nil;
	table.sort(self.vars.temptbl,function(a,b) return a.name<b.name end);
	return self.vars.temptbl
end

function GarbageFu:KeepFirstItem()
	local item = self:GetFirstDroppableItem();
	if item then
		self:KeepItem(item);
	end
end

function GarbageFu:KeepItem(item)
	if item then
		self:ToggleKeepItem(item.id);
		self:MyPrint(L["Adding %s to keep item list"], item.link );
	end
end

function GarbageFu:DropFirstItem()
	local item = self:GetFirstDroppableItem();
	if item then
		self:DropItem(item);
	end
end

function GarbageFu:DropItem(item)
	if not item or not item.bag or not item.slot then return end
	if not self:IsSafeToDelete() then return end
	if self:IsItemDroppable(item) then
		if (MerchantFrame:IsVisible()) then
			self:MyPrint(L["Selling x%s %s worth %s"], item.stack, item.name, self:GetMoneyString(item.totvalue) );
			UseContainerItem(item.bag, item.slot)
			self:SetSafeToDelete(false);
		else
			self:MyPrint(L["Dropping x%s %s worth %s"], item.stack, item.name, self:GetMoneyString(item.totvalue) );
			PickupContainerItem(item.bag, item.slot)
			DeleteCursorItem();
			self:SetSafeToDelete(false);
		end
	end
end

function GarbageFu:SettingsReset()
	self:ResetDB('profile');
	self:ResetDB('account');
	self.vars.dropsets = self:Table(self.vars.dropsets,1);
	self.vars.keepsets = self:Table(self.vars.keepsets,1);
	self:UpdateDisplay();
end

function GarbageFu:GetMoneyString(value)
	if ( value == 0 ) then
		return "|cffffcc00??|r"; -- No price
	elseif ( self.db.profile.moneyformat == 1 ) then
		return abacus:FormatMoneyCondensed(value,true,true)
	elseif ( self.db.profile.moneyformat == 2 ) then
		return abacus:FormatMoneyShort(value,true,true)
	elseif ( self.db.profile.moneyformat == 3 ) then
		return abacus:FormatMoneyFull(value,true,true)
	else
		return abacus:FormatMoneyExtended(value,true,true)
	end
end

------------------------------------------------------------------------------------------------------
-- Sets functions
------------------------------------------------------------------------------------------------------

function GarbageFu:IsItemInSet(itemId,set)
	local val,set = PeriodicTable:ItemInSet(itemId,set);
	if set then return true end
end

-- Check if item is in one of the sets selected for drop.
function GarbageFu:IsItemInDropSets(itemid)
	local val,set = PeriodicTable:ItemInSet(itemid,self.vars.dropsets);
	if set then return true end
end

-- Check if item is in one of the sets selected for keep.
function GarbageFu:IsItemInKeepSets(itemid)
	local val,set = PeriodicTable:ItemInSet(itemid,self.vars.keepsets);
	if set then return true end
end

function GarbageFu:IsDropSet(set,subset)
	local setid = self.vars.sets[set].id;
	if subset then
		local subsetid = self.vars.sets[set].sub[subset].id;
		return self.db.profile.dropsets[setid] or self.db.profile.dropsets[subsetid];
	end
	return self.db.profile.dropsets[setid];
end

function GarbageFu:IsChildDropSet(set)
	if self.vars.sets[set].sub then
		for _,s in self.vars.sets[set].sub do
			if self.db.profile.dropsets[s.id] then
				return true;
			end
		end
	end
end

-- Converts self.db.profile.dropsets into self.vars.dropsets
-- Needed because self.db.profile.dropsets is index by name and self.vars.dropsets needs to be indexed by number with names as string.
function GarbageFu:MakeSetsTables()
	self.vars.dropsets = self:Table(self.vars.dropsets,1);
	for n,_ in self.db.profile.dropsets do
		table.insert(self.vars.dropsets,n);
	end
	self.vars.keepsets = self:Table(self.vars.keepsets,1);
	for n,_ in self.db.profile.keepsets do
		table.insert(self.vars.keepsets,n);
	end
end

function GarbageFu:ToggleDropSets(set,subset)
	self:DebugPrint("ToggleDropSets(set) set="..tostring(set).." subset="..tostring(subset));
	local setid = self.vars.sets[set].id;
	if subset then																	-- Clicked a child
		local subsetid = self.vars.sets[set].sub[subset].id;
		if self.db.profile.dropsets[setid] then  			-- Check if parent is set
			self.db.profile.dropsets[setid] = nil; 					-- Clear parent
			for _,s in self.vars.sets[set].sub do
				self.db.profile.dropsets[s.id] = true; 				-- Set all children
			end
		end
		if self.db.profile.dropsets[subsetid] then		-- Reverse child
			self.db.profile.dropsets[subsetid] = nil;
		else	
			self.db.profile.dropsets[subsetid] = true;
		end
		local allset = true;
		for _,s in self.vars.sets[set].sub do
			if not self.db.profile.dropsets[s.id] then 	-- Check if all children are set
				allset = false;
				break;
			end
		end
		if allset then																-- All children are set
			self.db.profile.dropsets[setid] = true; 				-- set parent
			for i,s in self.vars.sets[set].sub do
				self.db.profile.dropsets[s.id] = nil;	  			-- And clear all children
			end
		end
	else																						-- Clicked a parent or a single
		if self.db.profile.dropsets[setid] then				-- Reverse it
			self.db.profile.dropsets[setid] = nil;
		else
			self.db.profile.dropsets[setid] = true;
			if self.vars.sets[set].sub then							-- If it is a parent
				for _,s in self.vars.sets[set].sub do							-- Clear all children for both drop and keep
					self.db.profile.dropsets[s.id] = nil;
					self.db.profile.keepsets[s.id] = nil;
				end
			end
		end
	end
	self:MakeSetsTables();
	self:UpdateDisplay();
end

function GarbageFu:IsKeepSet(set,subset)
	local setid = self.vars.sets[set].id;
	if subset then
		local subsetid = self.vars.sets[set].sub[subset].id;
		return self.db.profile.keepsets[setid] or self.db.profile.keepsets[subsetid];
	end
	return self.db.profile.keepsets[setid];
end

function GarbageFu:IsChildKeepSet(set)
	if self.vars.sets[set].sub then
		for _,s in self.vars.sets[set].sub do
			if self.db.profile.keepsets[s.id] then
				return true;
			end
		end
	end
end

function GarbageFu:ToggleKeepSets(set,subset)
	self:DebugPrint("ToggleKeepSets(set) set="..tostring(set).." subset="..tostring(subset));
	local setid = self.vars.sets[set].id;
	if subset then																	-- Clicked a child
		local subsetid = self.vars.sets[set].sub[subset].id;
		if self.db.profile.keepsets[setid] then  			-- Check if parent is set
			self.db.profile.keepsets[setid] = nil; 					-- Clear parent
			for _,s in self.vars.sets[set].sub do
				self.db.profile.keepsets[s.id] = true; 				-- Set all children
			end
		end
		if self.db.profile.keepsets[subsetid] then		-- Reverse child
			self.db.profile.keepsets[subsetid] = nil;
		else	
			self.db.profile.keepsets[subsetid] = true;
		end
		local allset = true;
		for _,s in self.vars.sets[set].sub do
			if not self.db.profile.keepsets[s.id] then 	-- Check if all children are set
				allset = false;
				break;
			end
		end
		if allset then																-- All children are set
			self.db.profile.keepsets[setid] = true; 				-- set parent
			for i,s in self.vars.sets[set].sub do
				self.db.profile.keepsets[s.id] = nil;	  			-- And clear all children
			end
		end
	else																						-- Clicked a parent or a single
		if self.db.profile.keepsets[setid] then				-- Reverse it
			self.db.profile.keepsets[setid] = nil;
		else
			self.db.profile.keepsets[setid] = true;
			if self.vars.sets[set].sub then							-- If it is a parent
				for _,s in self.vars.sets[set].sub do					-- Clear all children for both drop and keep
					self.db.profile.keepsets[s.id] = nil;
					self.db.profile.dropsets[s.id] = nil;
				end
			end
		end
	end
	self:MakeSetsTables();
	self:UpdateDisplay();
end

------------------------------------------------------------------------------------------------------
-- Special bag functions
------------------------------------------------------------------------------------------------------

function GarbageFu:GetBagId(bag)
	local slotId = ContainerIDToInventoryID(bag);
	local bagLink = GetInventoryItemLink("player",slotId);
	local bagId = self:GetItemId(bagLink);
	return bagId;
end

function GarbageFu:IsBagAmmoBag(bagId)
	return self:IsItemInSet(bagId, {"bagsammo","bagsquiver"});
end

function GarbageFu:IsBagHerbBag(bagId)
	return self:IsItemInSet(bagId, "bagsherb");
end

function GarbageFu:IsBagSoulBag(bagId)
	return self:IsItemInSet(bagId, "bagssoul");
end

function GarbageFu:IsBagEnchBag(bagId)
	return self:IsItemInSet(bagId, "bagsench");
end

function GarbageFu:IgnoreBag(bag)
	local bagId = self:GetBagId(bag);
	if ( self:IsIgnoringAmmoBag() and self:IsBagAmmoBag(bagId) ) then return true end
	if ( self:IsIgnoringHerbBag() and self:IsBagHerbBag(bagId) ) then return true end
	if ( self:IsIgnoringSoulBag() and self:IsBagSoulBag(bagId) ) then return true end
	if ( self:IsIgnoringEnchBag() and self:IsBagEnchBag(bagId) ) then return true end
end

------------------------------------------------------------------------------------------------------
-- Sell Items functions
------------------------------------------------------------------------------------------------------

function GarbageFu:IsItemSellable(item)
	if ( item.qual == 0 or ( not self:IsSellOnlyGrey() and self:IsItemDroppable(item))) then
		return true;
	end
	return false;
end

function GarbageFu:IsThereItemsToSell()
	for _,item in pairs(self.vars.items) do
		if self:IsItemSellable(item) then
			return true;
		end
	end
	return false;
end

function GarbageFu:GetSellItems()
	local sellItems = self:Table();
	local sellValue = 0;
	for _,item in pairs(self.vars.items) do
		if self:IsItemSellable(item) then
			table.insert(sellItems,item);
			sellValue = sellValue + item.totvalue;
		end
	end
	return sellItems, sellValue;
end

function GarbageFu:GetSellValue()
	local sellValue = 0;
	for _,item in pairs(self.vars.items) do
		if self:IsItemSellable(item) then
			sellValue = sellValue + item.totvalue;
		end
	end
	return sellValue;
end

function GarbageFu:SellAllItems()
	if ( not self:IsEventScheduled("SellItem") ) then
		if self.vars.sellitems then compost:Reclaim(self.vars.sellitems) end
		self.vars.sellitems, self.vars.sellvalue = self:GetSellItems();
		if self.vars.sellitems[1] then
			self:ScheduleRepeatingEvent("SellItem", self.SellItemEvent, 0.5, self);
		end
	end
end

function GarbageFu:SellItemEvent()
	local item = self.vars.sellitems[1];
	if ( item and MerchantFrame:IsVisible() ) then  
		if self:IsSafeToDelete() then
			self:SetSafeToDelete(false);
			self:MyPrint(L["Selling x%s %s worth %s"], item.stack, item.name, self:GetMoneyString(item.totvalue) );
			UseContainerItem(item.bag, item.slot)
			table.remove(self.vars.sellitems,1);
		end
	else -- No more items or Merchant frame closed
		if ( not item ) then
			self:MyPrint(L["All items sold."]);
			MerchantFrame.sellAllButton:Disable();
		end
		self:CancelScheduledEvent("SellItem");
		return
	end
end

function GarbageFu:OnMerchantOpen()
	if self:IsThereItemsToSell() then
		MerchantFrame.sellAllButton:Enable();
	else
		MerchantFrame.sellAllButton:Disable();
	end
end

function GarbageFu:OnMerchantClose()
	if ( self:IsEventScheduled("SellItem") ) then
		self:CancelScheduledEvent("SellItem");
	end
end

local buttonSize = 32
function GarbageFu:MakeSellAllButton()
	if not MerchantFrame.sellAllButton then
		local sellAllButton = CreateFrame("Button", "GarbageFu_SellItemButton", MerchantFrame)
		MerchantFrame.sellAllButton = sellAllButton
		sellAllButton:SetWidth(buttonSize)
		sellAllButton:SetHeight(buttonSize)
		local texture = sellAllButton:CreateTexture()
		texture:SetWidth(buttonSize * 1.6458333)
		texture:SetHeight(buttonSize * 1.6458333)
		texture:SetPoint("CENTER", sellAllButton, "CENTER")
		texture:SetTexture("Interface\\Buttons\\UI-Quickslot2")
		sellAllButton:SetNormalTexture(texture)
		local texture = sellAllButton:CreateTexture(nil, "BACKGROUND")
		texture:SetTexture("Interface\\AddOns\\FuBar_GarbageFu\\icon.tga")
		texture:SetAllPoints(sellAllButton)
		sellAllButton:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
		local texture = sellAllButton:CreateTexture()
		texture:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
		texture:SetAllPoints(sellAllButton)
		sellAllButton:SetHighlightTexture(texture)
		local texture = sellAllButton:CreateTexture()
		texture:SetTexture("Interface\\AddOns\\FuBar_GarbageFu\\icon.tga")
		texture:SetDesaturated(true)
		texture:SetAllPoints(sellAllButton)
		sellAllButton:SetDisabledTexture(texture)
		sellAllButton:SetPoint("TOPRIGHT", MerchantFrame, "TOPRIGHT", -44, -38)
		sellAllButton:SetScript("OnClick", function()
			self:SellAllItems()
		end)
		sellAllButton:SetScript("OnEnter", function()
			self:SellAllButtonOnEnter(this)
		end)
		sellAllButton:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
		local texture = sellAllButton:CreateTexture(nil, "ARTWORK")
		texture:SetTexture(0, 0, 0, 0.5)
		texture:SetAllPoints(sellAllButton)
		local button_Enable = sellAllButton.Enable
		function sellAllButton:Enable()
			button_Enable(self)
			texture:Hide()
		end
		local button_Disable = sellAllButton.Disable
		function sellAllButton:Disable()
			button_Disable(self)
			texture:Show()
		end
		MerchantFrame.sellAllButton:Disable()
	end	
end

function GarbageFu:SellAllButtonOnEnter(button)
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	if self:IsSellOnlyGrey() then
		GameTooltip:SetText(L["Sell all grey items"]);
		GameTooltip:AddLine(L["SellsAll TooltipText2"]);
	else
		GameTooltip:SetText(L["Sell all garbage items"]);
		GameTooltip:AddLine(L["SellsAll TooltipText1"]);
	end
	local sellValue = self:GetSellValue();
	GameTooltip:AddLine(L["Value:"].." "..self:GetMoneyString(sellValue));
	GameTooltip:Show()
end

------------------------------------------------------------------------------------------------------
-- Item Price functions
------------------------------------------------------------------------------------------------------

-- Get item value. Doh!
function GarbageFu:GetItemValue(item)
	if item.id and item.qual and item.code then
		item.value, item.pricetype = self:GetUserOverridePrice(item.id)
		if not item.value then item.value, item.pricetype = self:GetKCIVendorPrice(item.id) end
		if not item.value then item.value, item.pricetype = self:GetInformantVendorPrice(item) end
		if not item.value then item.value, item.pricetype = self:GetWoWEconVendorPrice(item) end
		if not item.value then item.value, item.pricetype = self:GetItemSyncVendorPrice(item.link) end
		if not item.value then item.value, item.pricetype = self:GetPriceMasterVendorPrice(item.id) end
		if not item.value then item.value, item.pricetype = self:GetLudwigSellValueVendorPrice(item.id) end
		if not item.value then item.value, item.pricetype = self:GetLocalVendorPrice(item.id) end
	end
	
	if item.value then
		item.totvalue = item.value * item.stack;
	else
		item.value = 0; -- No item value know
		item.totvalue = 0; -- No item value know
	end		
end

-- Price Types. First char: U = User, V = Vendor, A = Auction
--              Second char: Addon the price was gotten from.
--						K = KC_Items, W = WoWEcon, I = Informant, P = PriceMaster, L = Ludwig, T = Local table

-- Get item price from the User Override table
function GarbageFu:GetUserOverridePrice(itemid)
	if self.db.account.overrideprices[itemid] then
		return self.db.account.overrideprices[itemid], "|cffff7700UO|r"
	end
end

-- KC_Items
function GarbageFu:GetKCIVendorPrice(itemid)
	local kv, vs
	if not KC_ItemsDB then return end
	kv = KC_ItemsDB[itemid]
	if kv then _, _, vs = string.find(kv, ",(%d+),%d+") end
	if (vs and vs ~= "0") then return tonumber(vs), "|cff0077ffVK|r" end
end

-- Auctioneer/Informant
function GarbageFu:GetInformantVendorPrice(item)
	if not Informant then return end
	local itemData = Informant.GetItem(item.id)
	if (itemData and itemData['buy'] and itemData['buy'] ~= 0) then return itemData['sell'], "|cff0077ffVI" end
end

-- WoWEcon
function GarbageFu:GetWoWEconVendorPrice(item)
	if not WOWEcon_Enabled then return end
	local price =	WOWEcon_GetVendorPrice_ByLink(item.link);
	if price and price > 0 then return price, "|cff0077ffVW|r" end
end

-- PriceMaster doesn't have a price asking function, so we have to tap directly in to it's data. Ugly!
function GarbageFu:GetPriceMasterVendorPrice(itemid)
	if ( CompletePrices and CompletePrices[itemid] and CompletePrices[itemid].p ) then
		return CompletePrices[itemid].p, "|cff0077ffVP|r" 
	end
end

-- Ludwig_SellValue
function GarbageFu:GetLudwigSellValueVendorPrice(itemid)
	local items = tostring(itemid)
	if ( Ludwig_SellValues and Ludwig_SellValues[items] ) then
		return Ludwig_SellValues[items], "|cff0077ffVL|r"
	end
end

function GarbageFu:GetItemSyncVendorPrice(itemlink)
	if (not ISync) then return end;
		local price = tonumber(ISync:FetchDB(ISync:GetCoreID(itemlink), "price"));
	if price and price > 0 then return price, "|cff0077ffVS|r" end
end

-- Look it up in our own price table
function GarbageFu:GetLocalVendorPrice(itemid)
	if not self.vars.vendorprices then return end

	if self.vars.pricecache[itemid] then return self.vars.pricecache[itemid], "|cff0077ffVT|r" end

	local _, _, price = string.find(self.vars.vendorprices, " "..itemid..":(%d+)")
	if price then
		self.vars.pricecache[itemid] = tonumber(price)
		return self.vars.pricecache[itemid], "|cff0077ffVT|r"
	end
end

-- Check that we got a numeric value from the editbox.
function GarbageFu.ValidateValue(self, value)
	self:DebugPrint( "ValidateValue value="..tostring(value));
	local res = ""
	for s in string.gfind(value, "(%d*).-(%d*)") do
	    res=res..s    
	end
	return res
end

-- Stores a new User Override price for the top item.
function GarbageFu.SetFirstItemValue(self, value)
	local item = self:GetFirstDroppableItem();
	if item then
		GarbageFu.SetItemValue(self, item.id, value);
	end
end

-- Stores a new User Override price for an item, or removing it.
function GarbageFu.SetItemValue(self, itemid, value)
	value = tonumber(value);
	if itemid then
		self:DebugPrint( "SetItemValue value="..tostring(value).."itemid="..tostring(itemid));
		if ( not value or value == 0 ) then
			if self.db.account.overrideprices[itemid] then
				self.db.account.overrideprices[itemid] = nil;
				local name = GetItemInfo(itemid);
				self:MyPrint(L["Removing custom price for %s."], name);
			end
		else
			self.db.account.overrideprices[itemid] = value;
				local name = GetItemInfo(itemid);
			self:MyPrint(L["Setting price for %s to %s."], name, self:GetMoneyString(value));
		end
		self:UpdateItemValue(itemid)
		self:SortItems();
		self:UpdateDisplay();
	end
end

-- Updates all occurances of itemid in the inventory with a new price.
function GarbageFu:UpdateItemValue(itemid)
	for _, item in self.vars.items do
		if ( item.id == itemid ) then
			self:GetItemValue(item);
		end
	end
end

-- Load our own price table.
function GarbageFu:LoadGarbagePrices(db)
	if not IsAddOnLoaded("FuBar_GarbageFu_Prices") then
		local res,reason = LoadAddOn("FuBar_GarbageFu_Prices");
	end
	if GarbageFu_PriceDb then		
		self.vars.vendorprices = GarbageFu_PriceDb;
		return true;
	elseif GarbageFu_PriceTbl then
		self.vars.vendorprices = "";
		self.vars.pricecache = GarbageFu_PriceTbl;
	else
	 	self:MyPrint(L["Can't load FuBar_GarbageFu_Price. Check that it exists and are enabled"]);
	 	return;
	end
end

function GarbageFu:IsGarbagePricesAvailable()
	local name, title, notes, enabled, loadable, reason = GetAddOnInfo("FuBar_GarbageFu_Prices");
	return not reason;
end

------------------------------------------------------------------------------------------------------
-- Compost interface
------------------------------------------------------------------------------------------------------

-- Method that will get a table from compost. If a table is passed in it will be erased and return.
-- If a depth is specified then any subtables will be reclaimed by compost before erasing the table and returning it.
function GarbageFu:Table(t,depth)
	if t then
		if type(t) ~= "table" then 
			error("GarbageFu:Table called with a none table as input");
			return
		end
		if depth and depth > 0 then
			for i in pairs(t) do
				if type(t[i]) == "table" then 
					compost:Reclaim(t[i], depth - 1 );
				end
			end
		end
		return compost:Erase(t);
	else
		return compost:GetTable();
	end
end

------------------------------------------------------------------------------------------------------
-- Chat output functions
------------------------------------------------------------------------------------------------------

function GarbageFu:DebugPrint(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	if self.CustomDebug then
		self:CustomDebug(1, 0.5, 0, nil, nil, nil, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
	end
end

function GarbageFu:MyPrint(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	self:CustomPrint(self.db.profile.textcolor.r, self.db.profile.textcolor.g, self.db.profile.textcolor.b, nil, nil, nil, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
end
