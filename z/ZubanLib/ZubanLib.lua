--
-- ZubanLib Library Functions
-- Version: 0.1.2
-- Author: Zuban (chumpnet@hotmail.com)
--

ZubanLib = {
	Const = {
		Texture = {
			HAWK = "Interface\\Icons\\Spell_Nature_RavenForm";
			MONKEY = "Interface\\Icons\\Ability_Hunter_AspectOfTheMonkey";
			CHEETAH = "Interface\\Icons\\Ability_Mount_JungleTiger";
		};
	};
	
	-- action bar
	Action = {
		BAG_VALUE = -2;
		NUM_SLOTS = 120;
	};
	
	-- paper doll
	Inventory = {
		BAG_VALUE = -1;
		NUM_SLOTS = 18;
	};
	
	-- bags
	Container = {};
	
	-- spellbook
	Spell = {};
	
	-- buffs
	Buff = {};
	
	-- write
	IO = {
		Chat = {};
		Screen = {};
	};
	
	-- stores extra cursor values
	Cursor = {};
};

--
-- Util functions
--

-- 
-- http://lua-users.org/wiki/RetiredLuaFaq
--
function ZubanLib.Clone(t)	-- return a copy of the table t
	local new = {};		-- create a new table
	local i, v = next(t, nil);	-- i is an index of t, v = t[i]

	while i do
		if (type(v) == "table") then
			v = ZubanLib.Clone(v);
		end
	
		new[i] = v;
		i, v = next(t, i);	-- get next index
	end
	
	return new;
end

function ZubanLib.IsBoolean(value)
	return (value == true or value == false);
end
  
function ZubanLib.ToString(value)
	if (value == nil) then
		return "nil";
	elseif (ZubanLib.IsBoolean(value)) then
		if (value) then
			return "true";
		else
			return "false";
		end
	else
		return value;
	end
end

function ZubanLib.InCombat()
	if (MGplayer ~= nil) then
		-- compatibility with MiniGroup addon created by Kaitlin
		return MGplayer.inCombat;
	elseif (PlayerFrame ~= nil) then
		return PlayerFrame.inCombat;
	else
		return nil;
	end
end

function ZubanLib.SetScale(frame, scale)
	return frame:SetScale(UIParent:GetScale() * scale);
end

--
-- Action functions
--

function ZubanLib.Action.GoToPage(page)
	page = tonumber(page);
	
	if (page > 0) then
		if (CURRENT_ACTIONBAR_PAGE ~= page) then
			CURRENT_ACTIONBAR_PAGE = page;
			ChangeActionBarPage();
		end
	end
end

function ZubanLib.Action.FindSlotByName(name, rank)
	local textName, textRank;

	for slot = 1, ZubanLib.Action.NUM_SLOTS do
		GameTooltip:SetAction(slot);
		textName = GameTooltipTextLeft1:GetText();
		textRank = GameTooltipTextRight1:GetText();

		if (textName == name and (rank == nil or rank == "" or textRank == rank)) then
			return slot;
		end		
	end
	
	return nil;
end

function ZubanLib.Action.FindSlotByTexture(name)
	local count, text, texture;

	for slot = 1, ZubanLib.Action.NUM_SLOTS do
		count = GetActionCount(slot);
		text = GetActionText(slot);
		texture = GetActionTexture(slot);

		if (count == 0 and text == nil and texture == name) then
			return slot;
		end		
	end
	
	return nil;
end

--
-- Inventory functions
--

function ZubanLib.Inventory.FindSlotByName(name)
	local itemName;
	
	for slot = 1, ZubanLib.Inventory.NUM_SLOTS do
		itemName = GetInventoryItemName(slot);
		
		if(itemName == name) then
			return slot;
		end
	end
	
	return nil;
end

--
-- Container functions
--

function ZubanLib.Container.FindBagSlotByName(name)
	local itemLink;

	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			itemLink = GetContainerItemLink(bag, slot);

			if (itemLink) then
				--ZubanLib.IO.Chat.Write(itemLink);
				if (itemLink == name) then
					return bag, slot;
				end
			end
		end
	end

	return nil, nil;
end

function ZubanLib.Container.CountByName(name)
	local total = 0;
	local itemLink;
	local itemcount;
	
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			itemLink = GetContainerItemLink(bag, slot);

			if (itemLink ~= nil) then
				local _,_,itemLink = string.find(itemLink, "^.*%[(.*)%].*$");
				local _,_,name = string.find(name, "^.*%[(.*)%].*$");

				if  (itemLink == name) then
					_, itemcount = GetContainerItemInfo(bag, slot);
					total = total + itemcount;
				end
			end
		end
	end

	return total;
end

function ZubanLib.FindBagSlotByName(name)
	local slot = ZubanLib.Inventory.FindSlotByName(name);
	
	if (slot) then
		return ZubanLib.Inventory.BAG_VALUE, slot;
	else
		return ZubanLib.Container.FindSlotByName(name);
	end
end

--
-- spellbook functions
--

function ZubanLib.Spell.FindIDByName(name, subName, bookType)
	local numSkillLineTabs = GetNumSpellTabs();
	local tabName, texture, offset, numSpells;
	local skillLineTab;
	local spellName, subSpellName;

	if (not bookType) then
		bookType = BOOKTYPE_SPELL;
	end
	
	for i = 1, numSkillLineTabs do
		tabName, texture, offset, numSpells = GetSpellTabInfo(i);

		for id = offset + 1, offset + numSpells do
			spellName, subSpellName = GetSpellName(id, bookType);
			
			--ZubanLib.IO.Chat.Write(id.." "..spellName.." "..subSpellName.." "..name);
			
			if (spellName == name and (not subName or subName == subSpellName)) then
				return id;
			end
		end
	end
	
	return nil;
end

function ZubanLib.Spell.CastSpellByName(name, subName, bookType)
	if (not bookType) then
		bookType = BOOKTYPE_SPELL;
	end

	local id = ZubanLib.Spell.FindIDByName(name, subName, bookType);
	
	if (id) then
		return CastSpell(id, bookType);
	end
end

function ZubanLib.Buff.FindIDByTexture(name, unit)
	if (not unit) then
		unit = "player";
	end
	
	local id = 1;
	local buff = UnitBuff(unit, id);

	while (buff) do
		if (buff == name) then
			return id;
		end
		
		id = id + 1;
		buff = UnitBuff(unit, id);
	end
	
	return nil;
end

--
-- output functions
--

function ZubanLib.IO.Chat.Warn(message)
	ZubanLib.IO.Chat.Write(message, 1, 0.2, 0.2);
end

function ZubanLib.IO.Chat.Write(message, red, green, blue, frame)
	if (not red) then
		red = 1;
	end
    
	if (not green) then
		green = 1;
	end

	if (not blue) then
		blue = 1;
	end
	
	if (frame) then
		frame:AddMessage(message, red, green, blue, 1.0, UIERRORS_HOLD_TIME);
	elseif (DEFAULT_CHAT_FRAME)	then
		DEFAULT_CHAT_FRAME:AddMessage(message, red, green, blue);
	end
end

function ZubanLib.IO.Screen.Warn(message)
	ZubanLib.IO.Screen.Write(message, 1, 0.2, 0.2);
end

function ZubanLib.IO.Screen.Write(message, red, green, blue)
	ZubanLib.IO.Chat.Write(message, red, green, blue, UIErrorsFrame);
end

--
-- cursor object
--

local BasePickupContainer = PickupContainerItem;

function PickupContainerItem(bag, slot)
	local result = BasePickupContainer(bag, slot);
	
	if (CursorHasItem()) then
		ZubanLib.Cursor:PickupContainerItem(bag, slot);
	end
	
	return result;
end

local BasePickupAction = PickupAction;

function PickupAction(slot)
	ZubanLib.Cursor:PickupAction(slot);
	return BasePickupAction(slot);
end

local BasePickupSpell = PickupSpell;

function PickupSpell(id, bookType)
	local result = BasePickupSpell(id, bookType);

	if (CursorHasSpell()) then
		ZubanLib.Cursor:PickupSpell(id, bookType);
	end
	
	return result;
end

function ZubanLib.Cursor:PickupContainerItem(bag, slot)
	local link = GetContainerItemLink(bag, slot);
	local texture, itemcount, locked, quality, readable = GetContainerItemInfo(bag, slot);

	self.Attributes = {};
	self.Attributes.Location = "Container";
	self.Attributes.Name = link;
	self.Attributes.Bag = bag;
	self.Attributes.Slot = slot;
	self.Attributes.Texture = texture;
	self.Attributes.Count = itemcount;
	self.Attributes.Locked = locked;
	self.Attributes.Quality = quality;
	self.Attributes.Readable = readable;
	
	--self:Write();
end

function ZubanLib.Cursor:PickupAction(slot)
	local count = GetActionCount(slot);
	local text = GetActionText(slot);
	local texture = GetActionTexture(slot);

	self.Attributes = {};
	self.Attributes.Location = "Action";
	self.Attributes.Slot = slot;
	self.Attributes.Count = count;
	self.Attributes.Text = text;
	self.Attributes.Texture = texture;

	if (GameTooltip ~= nil) then
		GameTooltipTextLeft1:SetText("");
		GameTooltipTextRight1:SetText(""); -- clear the rank
		GameTooltip:SetAction(slot);

		local name = GameTooltipTextLeft1:GetText();
		local rank = GameTooltipTextRight1:GetText();
	
		self.Attributes.Name = name;
		self.Attributes.Rank = rank;
	
		--[[
		local lines = GameTooltip:NumLines();
		self.Attributes.Lines = lines;

		for i = 1, lines do
			textLeft = getglobal("GameTooltipTextLeft"..i);
			if (textLeft ~= nil) then
				self.Attributes["Left"..i] = textLeft:GetText();
			end
			
			textRight = getglobal("GameTooltipTextRight"..i);
			if (textRight ~= nil) then
				self.Attributes["Right"..i] = textRight:GetText();
			end
		end
		]]
	end
	
	--self:Write();
end

function ZubanLib.Cursor:PickupSpell(id, bookType)
	local name, rank = GetSpellName(id, bookType);
	local texture = GetSpellTexture(id, bookType);
	--local start, duration, enable = GetSpellCooldown (id, bookType);
	--local passive = IsSpellPassive(id, bookType);
	
	self.Attributes = {};
	self.Attributes.Location = "Spell";
	self.Attributes.ID = id;
	self.Attributes.BookType = bookType;
	self.Attributes.Name = name;
	self.Attributes.Rank = rank;
	self.Attributes.Texture = texture;
	--self.Attributes.Start = start;
	--self.Attributes.Duration = duration;
	--self.Attributes.Enable = enable;
	--self.Attributes.Passive = passive;

	--self:Write();
end

function ZubanLib.Cursor:Clear()
	self.Attributes = {};
end

function ZubanLib.Cursor.WriteAttribute(key, value)
	ZubanLib.IO.Chat.Write(ToString(key)..": "..ToString(value));
end

function ZubanLib.Cursor:Write()
	if (self.Attributes ~= nil) then
		table.foreach(self.Attributes, ZubanLib.Cursor.WriteAttribute);
	end
end
