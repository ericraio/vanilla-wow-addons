--[[

	Enchantrix v3.6.1 (Platypus)
	$Id: EnchantrixBarker.lua 933 2006-07-08 03:10:18Z mentalpower $

	By Norganna
	http://enchantrix.org/

	This is an addon for World of Warcraft that add a list of what an item
	disenchants into to the items that you mouse-over in the game.

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

]]

local priorityList = {};

local categories = { --TODO: Localize
	Bracer = {search = "Bracer", print = "Bracer" },
	Gloves = {search = "Gloves", print = "Gloves" },
	Boots = {search = "Boots", print = "Boots" },
	Shield = {search = "Shield", print = "Shield" },
	Chest = {search = "Chest", print = "Chest" },
	Cloak = {search = "Cloak", print = "Cloak" },
	TwoHanded = {search = "2H", print = "2H Weapon"},
	AnyWeapon = {search = "Enchant Weapon", print = "Any Weapon" }
};


local print_order = { 'Bracer', 'Gloves', 'Boots', 'Chest', 'Cloak', 'Shield', 'TwoHanded', 'AnyWeapon' }; --TODO: Localize

local attributes = { --TODO: Localize
	'intellect',
	'stamina',
	'spirit',
	'strength',
	'agility',
	'fire resistance',
	'resistance to fire',
	'resistance',
	'all stats',
	'mana',
	'health',
	'additional armor',
	'additional points of armor',
	'increase armor',
	'increase its armor',
	'absorption',
	'damage to beasts',
	'points? of damage',
	'\+[0-9]+ damage',
	'defense'
};

local short_attributes = { --TODO: Localize
	'INT',
	'STA',
	'SPI',
	'STR',
	'AGI',
	'fire res',
	'fire res',
	'all res',
	'all stats',
	'mana',
	'health',
	'armour',
	'armour',
	'armour',
	'armour',
	'DMG absorb',
	'Beastslayer',
	'DMG',
	'DMG',
	'DEF'
};

-- UI code


function EnchantrixBarker_OnEvent()
	--Enchantrix.Util.ChatPrint("GotUIEvent...");

	-- Returns "Enchanting" for enchantwindow and nil for Beast Training
	local craftName, rank, maxRank = GetCraftDisplaySkillLine()

	if craftName then
		--Enchantrix.Util.ChatPrint("Barker config is "..tostring(Enchantrix.Config.GetFilter('barker')) );
		if( event == "CRAFT_SHOW" ) then
			if( Enchantrix.Config.GetFilter('barker') and GetLocale() == "enUS" ) then
				Enchantrix_BarkerButton:Show();
				Enchantrix_BarkerButton.tooltipText = 'Posts a sales message to the Trade channel, if available.'; --TODO: Localize

				Enchantrix_BarkerOptionsButton:Show();
				Enchantrix_BarkerButton.tooltipText = 'Opens the barker options window.'; --TODO: Localize
			else
				Enchantrix_BarkerButton:Hide();
				Enchantrix_BarkerOptionsButton:Hide();
				Enchantrix_BarkerOptions_Frame:Hide();
			end
		elseif( event == "CRAFT_CLOSE" )then
			Enchantrix_BarkerButton:Hide();
			Enchantrix_BarkerOptionsButton:Hide();
			Enchantrix_BarkerOptions_Frame:Hide();
		end
	end
end

function Enchantrix_BarkerOptions_OnShow()
	Enchantrix_BarkerOptions_ShowFrame(1);
end

function Enchantrix_BarkerOnClick()
	--EnhTooltip.DebugPrint(Enchantrix_CreateBarker());
	local barker = Enchantrix_CreateBarker();
	local id = GetChannelName("Trade - City") --TODO: Localize
	EnhTooltip.DebugPrint("EnxBarker: Attempting to send barker", barker, "Trade Channel ID", id)

	if (id and (not(id == 0))) then
		if (barker) then
			SendChatMessage(barker,"CHANNEL", GetDefaultLanguage("player"), id);
		end
	else
		Enchantrix.Util.ChatPrint("Enchantrix: You aren't in a trade zone."); --TODO: Localize
	end
end

function Enchantrix.Barker.AddonLoaded()
	Enchantrix.Util.ChatPrint("Barker Loaded...");
	if( not EnchantConfig.barker ) then
		EnchantConfig.barker = {};
	end
	--EnchantConfig.barker = EnchantConfig.barker;
	if( not EnchantConfig.barker.profit_margin ) then
		EnchantConfig.barker.profit_margin = 10;
	end
	if( not EnchantConfig.barker.randomise ) then
		EnchantConfig.barker.randomise = 10;
	end
	if( not EnchantConfig.barker.lowest_price ) then
		EnchantConfig.barker.lowest_price = 100;
	end
end

local function relevel(frame)
	local myLevel = frame:GetFrameLevel() + 1
	local children = { frame:GetChildren() }
	for _,child in pairs(children) do
		child:SetFrameLevel(myLevel)
		relevel(child)
	end
end

local function craftUILoaded()
	Stubby.UnregisterAddOnHook("Blizzard_CraftUI", "Enchantrix")

	Enchantrix_BarkerButton:SetParent(CraftFrame);
	Enchantrix_BarkerButton:SetPoint("TOPRIGHT", CraftFrame, "TOPRIGHT", -40, -60 );

	Enchantrix_BarkerOptionsButton:SetParent(CraftFrame);
	Enchantrix_BarkerOptionsButton:SetPoint("BOTTOMRIGHT", Enchantrix_BarkerButton, "BOTTOMLEFT");

	Enchantrix_BarkerOptions_Frame:SetParent(CraftFrame);
	Enchantrix_BarkerOptions_Frame:SetPoint("TOPLEFT", CraftFrame, "TOPRIGHT");
	relevel(Enchantrix_BarkerOptions_Frame)
end

function EnchantrixBarker_OnLoad()
	Stubby.RegisterAddOnHook("Blizzard_CraftUI", "Enchantrix", craftUILoaded)
end



local config_defaults = {
	lowest_price = 5000,
	sweet_price = 50000,
	high_price = 500000,
	profit_margin = 10,
	highest_profit = 100000,
	randomise = 10,
	AnyWeapon = 100,
	TwoHanded = 90,
	Bracer = 70,
	Gloves = 70,
	Boots = 70,
	Chest = 70,
	Cloak = 70,
	Shield = 70,
	INT = 90,
	STA = 70,
	AGI = 70,
	STR = 70,
	SPI = 45,
	["all stats"] = 75,
	["all res"] = 55,
	armour = 65,
	["fire res"] = 85,
	mana = 35,
	health = 40,
	DMG = 90,
	DEF = 60,
	other = 70,
	factor_price = 20,
	factor_item = 40,
	factor_stat = 40
};

function Enchantrix_BarkerGetConfig( key )
	if( not EnchantConfig.barker ) then
		EnchantConfig.barker = {};
	end
	local config = EnchantConfig.barker;

	if( not config[key] ) then
		config[key] = config_defaults[key];
	end
	--Enchantrix.Util.ChatPrint("Getting config: "..key.." - "..config[key]);

	return config[key];
end

function Enchantrix_BarkerSetConfig( key, value )
	--Enchantrix.Util.ChatPrint("Setting config: "..key.." - "..value);
	if( not EnchantConfig.barker ) then
		EnchantConfig.barker = {};
	end
	local config = EnchantConfig.barker;

	config[key] = value;
end

function Enchantrix_BarkerOptions_TestButton_OnClick()
	--EnhTooltip.DebugPrint(Enchantrix_CreateBarker());
	local barker = Enchantrix_CreateBarker();
	local id = GetChannelName("Trade - City") --TODO: Localize
	EnhTooltip.DebugPrint("EnxBarker: Attempting to send test barker", barker, "Trade Channel ID", id)

	if (id and (not(id == 0))) then
		if (barker) then
			Enchantrix.Util.ChatPrint(barker);
		end
	else
		Enchantrix.Util.ChatPrint("Enchantrix: You aren't in a trade zone."); --TODO: Localize
	end
end


function Enchantrix_BarkerOptions_Factors_Slider_GetValue(id)
	if (not id) then
		id = this:GetID();
	end
	return Enchantrix_BarkerGetConfig(Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[id].key);
end

function Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged(id)
	if (not id) then
		id = this:GetID();
	end
	Enchantrix_BarkerSetConfig(Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[id].key, this:GetValue());
end

Enchantrix_BarkerOptions_ActiveTab = -1;

Enchantrix_BarkerOptions_TabFrames = { --TODO: Localize
	{
		title = 'Profit and Price Priorities',
		options = {
			{
				name = 'Profit Margin',
				tooltip = 'The percentage profit to add to the base mats cost.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'profit_margin',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Highest Profit',
				tooltip = 'The highest total cash profit to make on an enchant.',
				units = 'money',
				min = 0,
				max = 250000,
				step = 500,
				key = 'highest_profit',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Lowest Price',
				tooltip = 'The lowest cash price to quote for an enchant.',
				units = 'money',
				min = 0,
				max = 50000,
				step = 500,
				key = 'lowest_price',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Overall Price Priority',
				tooltip = 'This sets how important pricing is to the overall priority for advertising.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_price',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'PriceFactor SweetSpot',
				tooltip = 'This is used to prioritise enchants near this price for advertising.',
				units = 'money',
				min = 0,
				max = 500000,
				step = 5000,
				key = 'sweet_price',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'PriceFactor Highest',
				tooltip = 'Enchants receive a score of zero for price priority at or above this value.',
				units = 'money',
				min = 0,
				max = 1000000,
				step = 50000,
				key = 'high_price',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Random Factor',
				tooltip = 'The amount of randomness in the enchants chosen for the trade shout.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'randomise',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			}
		}
	},
	{
		title = 'Item Priorities',
		options = {
			{
				name = 'Overall Items Priority',
				tooltip = 'This sets how important the item is to the overall priority for advertising.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_item',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = '2H Weapon',
				tooltip = 'The priority score for 2H weapon enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'TwoHanded',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Any Weapon',
				tooltip = 'The priority score for enchants to any weapon.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'AnyWeapon',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Bracer',
				tooltip = 'The priority score for bracer enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'Bracer',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Gloves',
				tooltip = 'The priority score for glove enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'Gloves',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Boots',
				tooltip = 'The priority score for boots enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'Boots',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Chest',
				tooltip = 'The priority score for chest enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'Chest',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Cloak',
				tooltip = 'The priority score for cloak enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'Cloak',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Shield',
				tooltip = 'The priority score for shield enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'Shield',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			}
		}
	},
	{
		title = 'Stats 1',
		options = {
			{
				name = 'Overall Stats Priority',
				tooltip = 'This sets how important the stat is to the overall priority for advertising.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'factor_stat',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Intellect',
				tooltip = 'The priority score for Intellect enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'INT',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Strength',
				tooltip = 'The priority score for Strength enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'STR',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Agility',
				tooltip = 'The priority score for Agility enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'AGI',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Stamina',
				tooltip = 'The priority score for Stamina enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'STA',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Spirit',
				tooltip = 'The priority score for Spirit enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'SPI',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'All Stats',
				tooltip = 'The priority score for enchants that increase all stats.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'all stats',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			}
		}
	},
	{
		title = 'Stats 2',
		options = {
			{
				name = 'All Resistances',
				tooltip = 'The priority score for enchants that boost all resistances.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'all res',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Armour',
				tooltip = 'The priority score for Armour enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'armour',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Fire Resistance',
				tooltip = 'The priority score for Fire Resistance enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'INT',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Mana',
				tooltip = 'The priority score for Mana enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'mana',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Health',
				tooltip = 'The priority score for Health enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'health',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Damage',
				tooltip = 'The priority score for Damage enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'DMG',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Defense',
				tooltip = 'The priority score for Defense enchants.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'DEF',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
			{
				name = 'Other',
				tooltip = 'The priority score for enchants such as skinning, mining, riding etc.',
				units = 'percentage',
				min = 0,
				max = 100,
				step = 1,
				key = 'other',
				getvalue = Enchantrix_BarkerOptions_Factors_Slider_GetValue,
				valuechanged = Enchantrix_BarkerOptions_Factors_Slider_OnValueChanged
			},
		}
	}
};



function EnchantrixBarker_OptionsSlider_OnValueChanged()
	if Enchantrix_BarkerOptions_ActiveTab ~= -1 then
		--Enchantrix.Util.ChatPrint( "Tab - Slider changed: "..Enchantrix_BarkerOptions_ActiveTab..' - '..this:GetID() );
		Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[this:GetID()].valuechanged();
		value = this:GetValue();
		--Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[this:GetID()].getvalue();

		valuestr = EnchantrixBarker_OptionsSlider_GetTextFromValue( value, Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[this:GetID()].units );

		getglobal(this:GetName().."Text"):SetText(Enchantrix_BarkerOptions_TabFrames[Enchantrix_BarkerOptions_ActiveTab].options[this:GetID()].name.." - "..valuestr );
	end
end

function EnchantrixBarker_OptionsSlider_GetTextFromValue( value, units )

	local valuestr = ''

	if units == 'percentage' then
		valuestr = value..'%'
	elseif units == 'money' then
		local p_gold,p_silver,p_copper = EnhTooltip.GetGSC(value);

		if( p_gold > 0 ) then
			valuestr = p_gold.."g";
		end
		if( p_silver > 0 ) then
			valuestr = valuestr..p_silver.."s";
		end
	end
	return valuestr;
end


function Enchantrix_BarkerOptions_Tab_OnClick()
	--Enchantrix.Util.ChatPrint( "Clicked Tab: "..this:GetID() );
	Enchantrix_BarkerOptions_ShowFrame( this:GetID() )

end

function Enchantrix_BarkerOptions_ShowFrame( frame_index )
	Enchantrix_BarkerOptions_ActiveTab = -1
	for index, frame in pairs(Enchantrix_BarkerOptions_TabFrames) do
		if ( index == frame_index ) then
			--Enchantrix.Util.ChatPrint( "Showing Frame: "..index );
			for i = 1,10 do
				local slider = getglobal('EnchantrixBarker_OptionsSlider_'..i);
				slider:Hide();
			end
			for i, opt in pairs(frame.options) do
				local slidername = 'EnchantrixBarker_OptionsSlider_'..i
				local slider = getglobal(slidername);
				slider:SetMinMaxValues(opt.min, opt.max);
				slider:SetValueStep(opt.step);
				slider.tooltipText = opt.tooltip;
				getglobal(slidername.."High"):SetText();
				getglobal(slidername.."Low"):SetText();
				slider:Show();
			end
			Enchantrix_BarkerOptions_ActiveTab = index
			for i, opt in pairs(frame.options) do
				local slidername = 'EnchantrixBarker_OptionsSlider_'..i
				local slider = getglobal(slidername);
				slider:SetValue(opt.getvalue(i));
				getglobal(slidername.."Text"):SetText(opt.name..' - '..EnchantrixBarker_OptionsSlider_GetTextFromValue(slider:GetValue(),opt.units));
			end
		end
	end
end

function Enchantrix_BarkerOptions_OnClick()
	--Enchantrix.Util.ChatPrint("You pressed the options button." );
	Enchantrix_BarkerOptions_Frame:Show();
	--ShowUIPanel(Enchantrix_BarkerOptions_Frame);
end


function Enchantrix_CheckButton_OnShow()
end
function Enchantrix_CheckButton_OnClick()
end
function Enchantrix_CheckButton_OnEnter()
end
function Enchantrix_CheckButton_OnLeave()
end


-- end UI code


function Enchantrix_CreateBarker()
	local availableEnchants = {};
	local numAvailable = 0;
	local temp = GetCraftSkillLine(1);
	if Enchantrix_BarkerGetZoneText() then
		Enchantrix_ResetBarkerString();
		Enchantrix_ResetPriorityList();
		if (temp) then
			EnhTooltip.DebugPrint("Starting creation of EnxBarker")
			for index=1, GetNumCrafts() do
				local craftName, craftSubSpellName, craftType, numEnchantsAvailable, isExpanded = GetCraftInfo(index);
				--EnhTooltip.DebugPrint(GetCraftInfo(index))
				if((numEnchantsAvailable > 0) and (string.find(craftName, "Enchant"))) then --have reagents and it is an enchant
					--Enchantrix.Util.ChatPrint(""..craftName, 0.8, 0.8, 0.2);
					local cost = 0;
					for j=1,GetCraftNumReagents(index),1 do
						local a,b,c = GetCraftReagentInfo(index,j);
						reagent = GetCraftReagentItemLink(index,j);

						--EnhTooltip.DebugPrint("Adding: "..reagent.." - "..Enchantrix_GetReagentHSP(reagent).." x "..c.." = " ..(Enchantrix_GetReagentHSP(reagent)*c/10000));
						cost = cost + (Enchantrix_GetReagentHSP(reagent)*c);
					end

					local profit = cost * Enchantrix_BarkerGetConfig("profit_margin")*0.01;
					if( profit > Enchantrix_BarkerGetConfig("highest_profit") ) then
						profit = Enchantrix_BarkerGetConfig("highest_profit");
					end
					local price = Enchantrix_RoundPrice(cost + profit);

					local enchant = {
						index = index,
						name = craftName,
						type = craftType,
						available = numEnchantsAvailable,
						isExpanded = isExpanded,
						cost = cost,
						price = price,
						profit = price - cost
					};
					availableEnchants[ numAvailable] = enchant;

					EnhTooltip.DebugPrint(GetCraftDescription(index));
					local p_gold,p_silver,p_copper = EnhTooltip.GetGSC(enchant.price);
					local pr_gold,pr_silver,pr_copper = EnhTooltip.GetGSC(enchant.profit);
					--EnhTooltip.DebugPrint("Price: "..p_gold.."."..p_silver.."g, profit: "..pr_gold.."."..pr_silver.."g");

					Enchantrix_AddEnchantToPriorityList( enchant )
					--EnhTooltip.DebugPrint( "numReagents: "..GetCraftNumReagents(index) );
					numAvailable = numAvailable + 1;
				end
			end

			if numAvailable == 0 then
				Enchantrix.Util.ChatPrint("Enchantrix: You either don't have any enchants or don't have the reagents to make them."); --TODO: Localize
				return nil
			end

			for i,element in ipairs(priorityList) do
				EnhTooltip.DebugPrint(element.enchant.name);
				Enchantrix_AddEnchantToBarker( element.enchant );
			end

			return Enchantrix_GetBarkerString();

		else
			Enchantrix.Util.ChatPrint("Enchantrix: Enchant Window not open."); --TODO: Localize
		end
	end

	return nil
end



function Enchantrix_ScoreEnchantPriority( enchant )

	local score_item = 0;

	if Enchantrix_BarkerGetConfig( Enchantrix_GetItemCategoryKey(enchant.index) ) then
		score_item = Enchantrix_BarkerGetConfig( Enchantrix_GetItemCategoryKey(enchant.index) );
		score_item = score_item * Enchantrix_BarkerGetConfig( 'factor_item' )*0.01;
	end

	local score_stat = 0;

	if Enchantrix_BarkerGetConfig( Enchantrix_GetEnchantStat(enchant) ) then
		score_stat = Enchantrix_BarkerGetConfig( Enchantrix_GetEnchantStat(enchant));
	else
		score_stat = Enchantrix_BarkerGetConfig( 'other' );
	end

	score_stat = score_stat * Enchantrix_BarkerGetConfig( 'factor_stat' )*0.01;

	local score_price = 0;
	local price_score_floor = Enchantrix_BarkerGetConfig("sweet_price");
	local price_score_ceiling = Enchantrix_BarkerGetConfig("high_price");

	if enchant.price < price_score_floor then
		score_price = (price_score_floor - (price_score_floor - enchant.price))/price_score_floor * 100;
	elseif enchant.price < price_score_ceiling then
		range = (price_score_ceiling - price_score_floor);
		score_price = (range - (enchant.price - price_score_floor))/range * 100;
	end

	score_price = score_price * Enchantrix_BarkerGetConfig( 'factor_price' )*0.01;
	score_total = (score_item + score_stat + score_price);

	return score_total * (1 - Enchantrix_BarkerGetConfig("randomise")*0.01) + math.random(300) * Enchantrix_BarkerGetConfig("randomise")*0.01;
end

function Enchantrix_ResetPriorityList()
	priorityList = {};
end

function Enchantrix_AddEnchantToPriorityList(enchant)

	local enchant_score = Enchantrix_ScoreEnchantPriority( enchant );

	for i,priorityentry in ipairs(priorityList) do
		if( priorityentry.score < enchant_score ) then
			table.insert( priorityList, i, {score = enchant_score, enchant = enchant} );
			return;
		end
	end

	table.insert( priorityList, {score = enchant_score, enchant = enchant} );
end


function Enchantrix_RoundPrice( price )

	local round

	if( price < 5000 ) then
		round = 1000;
	elseif ( price < 20000 ) then
		round = 2500;
	else
		round = 5000;
	end

	odd = math.mod(price,round);

	price = price + (round - odd);

	if( price < Enchantrix_BarkerGetConfig("lowest_price") ) then
		price = Enchantrix_BarkerGetConfig("lowest_price");
	end

	return price
end

function Enchantrix_GetReagentHSP( itemLink )

	local itemID = Enchantrix.Util.GetItemIdFromLink(itemLink);
	local itemKey = string.format("%s:0:0", itemID);


	-- Work out what version if any of auctioneer is installed
	local auctVerStr;
	if (not Auctioneer) then
		auctVerStr = AUCTIONEER_VERSION or "0.0.0";
	else
		auctVerStr = AUCTIONEER_VERSION or Auctioneer.Version or "0.0.0";
	end
	local auctVer = Enchantrix.Util.Split(auctVerStr, ".");
	local major = tonumber(auctVer[1]) or 0;
	local minor = tonumber(auctVer[2]) or 0;
	local rev = tonumber(auctVer[3]) or 0;
	if (auctVer[3] == "DEV") then rev = 0; minor = minor + 1; end
	local hsp = nil;

	if (major == 3 and minor == 0 and rev <= 11) then
		--Enchantrix.Util.ChatPrint("Calling Auctioneer_GetHighestSellablePriceForOne");

		if (rev == 11) then
			hsp = Auctioneer_GetHighestSellablePriceForOne(itemKey, false, Auctioneer_GetAuctionKey());
		else
			if (Auctioneer_GetHighestSellablePriceForOne) then
				hsp = Auctioneer_GetHighestSellablePriceForOne(itemKey, false);
			elseif (getHighestSellablePriceForOne) then
				hsp = getHighestSellablePriceForOne(itemKey, false);
			end
		end
	elseif (major == 3 and (minor > 0 and minor <= 3) and (rev > 11 and rev < 675)) then
		--Enchantrix.Util.ChatPrint("Calling GetHSP");
		hsp = Auctioneer_GetHSP(itemKey, Auctioneer_GetAuctionKey());
	elseif (major >= 3 and minor >= 3 and (rev >= 675 or rev == 0)) then
		--Enchantrix.Util.ChatPrint("Calling Statistic.GetHSP");
		hsp = Auctioneer.Statistic.GetHSP(itemKey, Auctioneer.Util.GetAuctionKey());
	else
		Enchantrix.Util.ChatPrint("Calling Nothing: "..major..", "..minor..", "..rev);
	end
	if hsp == nil then
		hsp = 0;
	end

	return hsp;
end

local barkerString = '';
local barkerCategories = {};

function Enchantrix_ResetBarkerString()
	barkerString = "("..Enchantrix_BarkerGetZoneText()..") Selling Enchants:"; --TODO: Localize
	barkerCategories = {};
end

local short_location = {
	Orgrimmar = 'Org',
	['Thunder Bluff'] = 'TB',
	Undercity = 'UC',
	['Stormwind City'] = 'SW',
	Darnassus = 'Dar',
	['City of Ironforge'] = 'IF'
};

function Enchantrix_BarkerGetZoneText()
	--Enchantrix.Util.ChatPrint(GetZoneText());
	return short_location[GetZoneText()];
end

function Enchantrix_AddEnchantToBarker( enchant )

	local currBarker = Enchantrix_GetBarkerString();

	local category_key = Enchantrix_GetItemCategoryKey( enchant.index )
	local category_string = "";
	local test_category = {};
	if barkerCategories[ category_key ] then
		for i,element in ipairs(barkerCategories[category_key]) do
			--Enchantrix.Util.ChatPrint("Inserting: "..i..", elem: "..element.index );
			table.insert(test_category, element);
		end
	end

	table.insert(test_category, enchant);

	category_string = Enchantrix_GetBarkerCategoryString( test_category );


	if string.len(currBarker) + string.len(category_string) > 255 then
		return false;
	end

	if not barkerCategories[ category_key ] then
		barkerCategories[ category_key ] = {};
	end

	table.insert( barkerCategories[ category_key ],enchant );

	return true;
end


function Enchantrix_GetBarkerString()
	local barker = ""..barkerString;

	for index, key in ipairs(print_order) do
		if( barkerCategories[key] ) then
			barker = barker..Enchantrix_GetBarkerCategoryString( barkerCategories[key] )
		end
	end

	return barker;
end

function Enchantrix_GetBarkerCategoryString( barkerCategory )
	local barkercat = ""
	barkercat = barkercat.." ["..Enchantrix_GetItemCategoryString(barkerCategory[1].index)..": ";
	for j,enchant in ipairs(barkerCategory) do
		if( j > 1) then
			barkercat = barkercat..", "
		end
		barkercat = barkercat..Enchantrix_GetBarkerEnchantString(enchant);
	end
	barkercat = barkercat.."]"

	return barkercat
end

function Enchantrix_GetBarkerEnchantString( enchant )
	local p_gold,p_silver,p_copper = EnhTooltip.GetGSC(enchant.price);

	enchant_barker = Enchantrix_GetShortDescriptor(enchant.index).." - ";
	if( p_gold > 0 ) then
		enchant_barker = enchant_barker..p_gold.."g";
	end
	if( p_silver > 0 ) then
		enchant_barker = enchant_barker..p_silver.."s";
	end
	--enchant_barker = enchant_barker..", ";
	return enchant_barker
end




function Enchantrix_GetItemCategoryString( index )

	local enchant = GetCraftInfo( index );

	for key,category in pairs(categories) do
		--Enchantrix.Util.ChatPrint( "cat key: "..key);
		if( string.find( enchant, category.search ) ~= nil ) then
			--Enchantrix.Util.ChatPrint( "cat key: "..key..", name: "..category.print..", enchant: "..enchant );
			return category.print;
		end
	end

	return 'Unknown';
end

function Enchantrix_GetItemCategoryKey( index )

	local enchant = GetCraftInfo( index );

	for key,category in pairs(categories) do
		--Enchantrix.Util.ChatPrint( "cat key: "..key..", name: "..category );
		if( string.find( enchant, category.search ) ~= nil ) then
			return key;
		end
	end

	return 'Unknown';

end

function EnchantrixBarker_GetCraftDescription( index )
	return GetCraftDescription(index) or "";
end

function Enchantrix_GetShortDescriptor( index )
	local long_str = string.lower(EnchantrixBarker_GetCraftDescription(index));

	for index,attribute in ipairs(attributes) do
		if( string.find( long_str, attribute ) ~= nil ) then
			statvalue = string.sub(long_str ,string.find(long_str,'[0-9]+[^%%]'));
			statvalue = string.sub(statvalue ,string.find(statvalue,'[0-9]+'));
			return "+"..statvalue..' '..short_attributes[index];
		end
	end
	local enchant = Enchantrix.Util.Split(GetCraftInfo(index), "-");

	return enchant[table.getn(enchant)];
end

function Enchantrix_GetEnchantStat( enchant )
	local index = enchant.index;
	local long_str = string.lower(EnchantrixBarker_GetCraftDescription(index));

	for index,attribute in ipairs(attributes) do
		if( string.find( long_str, attribute ) ~= nil ) then
			return short_attributes[index];
		end
	end
	local enchant = Enchantrix.Util.Split(GetCraftInfo(index), "-");

	return enchant[table.getn(enchant)];
end
