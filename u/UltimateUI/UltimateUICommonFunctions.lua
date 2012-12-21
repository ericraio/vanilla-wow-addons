--[[
	CommonFunctions
	
	This file is for commonly used functions available to any
	UltimateUI Mod. Thanks to Chitinous, Skrag and Thott for most of
	these functions. :-)

	by Alexander Brazie

  ]]--

DEBUG_CHAT_FRAME = ChatFrame1;

-- Output functions

	-- NOTE***  ChatTimeStamps is completely overloading this function when enabled
function Print(msg, r, g, b, frame, id) 
	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 1.0; end
	if (not frame) then frame = DEFAULT_CHAT_FRAME; end
	if (frame) then
		if (not id) then
			frame:AddMessage(msg,r,g,b);
		else
			frame:AddMessage(msg,r,g,b,id);
		end
	end
end

-- Prints a table in an organized format
function PrintTable(table, rowname, level) 
	if ( rowname == nil ) then rowname = "ROOT"; end
	if ( level == nil ) then level = 1; end

	local msg = "";
	for i=1,level, 1 do 
		msg = msg .. "   ";	
	end

	if ( table == nil ) then Print (msg.."["..rowname.."] := nil "); return end
	if ( type(table) == "table" ) then
		Print (msg..rowname.." { ");
		for k,v in table do
			PrintTable(v,k,level+1);
		end
		Print(msg.."} ");
	elseif (type(table) == "function" ) then 
		Print(msg.."["..rowname.."] => {{FunctionPtr*}}");
	elseif (type(table) == "userdata" ) then 
		Print(msg.."["..rowname.."] => {{UserData}}");
	elseif (type(table) == "boolean" ) then 
		local value = "true";
		if ( not table ) then
			value = "false";
		end
		Print(msg.."["..rowname.."] => "..value);
	else
		Print(msg.."["..rowname.."] => "..table);
	end
end

-- DebugPrint takes a message and a debug key. 
-- 
-- The default is "ULTIMATEUI_DEBUG", but you can set it to any 
-- value you like. The result is that if setglobal(debugkey,1); 
-- has been called, your debug message will be output.
--
function DebugPrint(msg, debugkey) 
	if ( not debugkey ) then debugkey = "ULTIMATEUI_DEBUG"; end

	if ( type(msg) == "string" ) then 
		if ( getglobal(debugkey) == 1 ) then
				Print("DBG: "..msg, 1, 1, .5, DEBUG_CHAT_FRAME);
		end
	end
end

-- Prints an error message
function ErrorPrint(msg)
	local info = ChatTypeInfo["YELL"];
	UIErrorsFrame:AddMessage(msg, info.r, info.g, info.b, 1.0, UIERRORS_HOLD_TIME);
end

-- Table functions
function GetIndexInList(list,item) 
	for k,v in list do 
		if ( v == item ) then return k; end
	end
	return -1;
end

-- Function Hooking (From ThottbotUtil.lua)

-- HookFunction("some_blizzard_function","my_function","before|after|hide")
-- calls "my_function" before/after "some_blizzard_function".
-- if type is "hide", calls "my_function" before all others, and only continues if it returns true
-- This method is used so the hook can be later undone without screwing up someone else's later hook.
HookFunction = function (...) 
	-- Sea.io.error (this:GetName(), " is using HookFunction, which is outdated. Please upgrade to -- Sea.util.hook!" );
	-- Sea.util.hook(unpack(arg));
end
-- same format as HookFunction
-- UnHookFunction = -- Sea.util.unhook;
-- Tooltip Scanning and Changing Functions

-- Clears a tooltip for usage.
function ClearTooltip(TooltipNameBase)
	for i=1, 15, 1 do
		getglobal(TooltipNameBase.."TextLeft"..i):SetText("");
		getglobal(TooltipNameBase.."TextRight"..i):SetText("");
	end

end

-- 
-- Prints an items' text into the chat window. 
-- 
function PrintItemText( bag, slot, TooltipNameBase )
	if ( TooltipNameBase == nil ) then 
		TooltipNameBase = "UltimateUITooltip";
	end

	local tooltip = getglobal (TooltipNameBase);
	
	--ClearToolTip(TooltipNameBase);
	tooltip:SetOwner( getglobal("UIParent"), "ANCHOR_CURSOR" );
	-- Sea.wow.tooltip.protectTooltipMoney();
	tooltip:SetBagItem( bag, slot );
	-- Sea.wow.tooltip.unprotectTooltipMoney();
	if( tooltip:IsVisible() ) then
		Print( "Visible tooltip" );
		tooltip:Hide();

		for i=1, tooltip:NumLines(), 1 do
			show = 0;
			str = "Left"..i..": ";
			str2 = getglobal(TooltipNameBase.."TextLeft"..i):GetText();
			if( str2 ~= nil ) then
				show = 1;
				str = str..str2;
			end
			str = str.." Right"..i..": ";
			str2 = getglobal(TooltipNameBase.."TextRight"..i):GetText();
			if( str2 ~= nil ) then
				show = 1;
				str = str..str2;
			end
			if( show == 1 ) then Print( str ); end
		end
	end
end

-- Gets all lines out of a tooltip.
function ScanTooltip(TooltipNameBase)
	if ( TooltipNameBase == nil ) then 
		TooltipNameBase = "UltimateUITooltip";
	end
	
	local strings = {};
	for idx = 1, 10 do
		local textLeft = nil;
		local textRight = nil;
		ttext = getglobal(TooltipNameBase.."TextLeft"..idx);
		if(ttext and ttext:IsVisible() and ttext:GetText() ~= nil)
		then
			textLeft = ttext:GetText();
		end
		ttext = getglobal(TooltipNameBase.."TextRight"..idx);
		if(ttext and ttext:IsVisible() and ttext:GetText() ~= nil)
		then
			textRight = ttext:GetText();
		end
		if (textLeft or textRight)
		then
			strings[idx] = {};
			strings[idx].left = textLeft;
			strings[idx].right = textRight;
		end
	end
	
	return strings;
end

function GetItemName(bag, slot)
	local name = "";
	local strings = nil;
	if ( bag > -1 ) then
		strings = GetItemInfoStrings(bag, slot, "UltimateUITooltip");
	else
		-- Sea.wow.tooltip.protectTooltipMoney();
		local hasItem, hasCooldown = UltimateUITooltip:SetInventoryItem("player", slot);
		-- Sea.wow.tooltip.unprotectTooltipMoney();
		strings = ScanTooltip("UltimateUITooltip");
		if ( not hasItem) then
			if ( strings[1] ) then
				strings[1].left = "";
			end
		end
	end
	-- Determine if the item is an ore, gem or herb
	if ( strings[1] ) then
		name = strings[1].left;
	end
	return name;
end

--Sets the tooltip relative to the owner in a position
--appropriate for where the owner is on the screen.
--owner - optional, the owner object, defaults to this
--tooltip, optional, the tooltip to set, defaults to GameTooltip
--setX, optional, sets the x offset(flipped based on screen corner)
--setY, optional, sets the y offset(flipped based on screen corner)
function SmartSetOwner(owner, tooltip, setX, setY)
 	if (not owner) then
 		owner = this;
 	end
 	if (not tooltip) then
 		tooltip = GameTooltip;
 	end
 	if (not setX) then
 		setX = 0;
 	end
 	if (not setY) then
 		setY = 0;
 	end
 	if (owner and (owner ~= UIParent)) then
		local x,y = owner:GetCenter();
		local left = owner:GetLeft();
		local right = owner:GetRight();
		local top = owner:GetTop();
		local bottom = owner:GetBottom();
		local screenWidth = UIParent:GetWidth();
		local screenHeight = UIParent:GetHeight();
		local scale = owner:GetScale();
		if (x~=nil and y~=nil and left~=nil and right~=nil and top~=nil and bottom~=nil and screenWidth>0 and screenHeight>0) then
			setX = setX * scale;
			setY = setY * scale;
			x = x * scale;
			y = y * scale;
			left = left * scale;
			right = right * scale;
			width = right - left;
			top = top * scale;
			bottom = bottom * scale;
			local anchorPoint = "";
			if (y <= (screenHeight * (1/2))) then
				top = top + setY;
				anchorPoint = "TOP";
				if (top < 0) then
					setY = setY - top;
				end
			else
				setY = -setY;
				bottom = bottom + setY;
				anchorPoint = "BOTTOM";
				if (bottom > screenHeight) then
					setY = setY + (screenHeight - bottom);
				end
			end
			
			if (x <= (screenWidth * (1/2))) then
				left = left + setX;
				if (anchorPoint == "BOTTOM") then
					anchorPoint = anchorPoint.."RIGHT";
					setX = setX - width;
					if (left < 0) then
						setX = setX - left;
					end
				else
					anchorPoint = anchorPoint.."LEFT";
					if (left < 0) then
						setX = setX - left;
					end
				end
			else
				setX = -setX;
				right = right + setX;
				if (anchorPoint == "BOTTOM") then
					anchorPoint = anchorPoint.."LEFT";
					setX = setX + width;
					if (right > screenWidth) then
						setX = setX - (right - screenWidth);
					end
				else
					anchorPoint = anchorPoint.."RIGHT";
					if (right > screenWidth) then
						setX = setX + (screenWidth - right);
					end
				end
			end
			
			if (anchorPoint == "") then
				anchorPoint = "TOPLEFT";
			end
			scale = tooltip:GetScale();
			if (scale) then
				setX = setX / scale;
				setY = setY / scale;
			end
			tooltip:SetOwner(owner, "ANCHOR_"..anchorPoint, setX, setY);
		end
	elseif (owner == UIParent) then
		local x,y = GetCursorPosition();
		local width = tooltip:GetWidth();
		local height = tooltip:GetHeifht();
		local screenWidth = UIParent:GetWidth();
		local screenHeight = UIParent:GetHeight();
		local scale = owner:GetScale();
		if (x~=nil and y~=nil and width and height and screenWidth>0 and screenHeight>0) then
			setX = setX * scale;
			setY = setY * scale;
			x = x * scale;
			y = y * scale;
			width = width * scale;
			height = height * scale;
			local anchorPoint = "";
			if (y <= (screenHeight * (1/2))) then
				local top = (y + height) + setY;
				if (top < 0) then
					setY = setY - top;
				end
			else
				setY = -setY;
				local bottom = (y - height) + setY;
				setY = setY - height;
				if (bottom > screenHeight) then
					setY = setY + (screenHeight - bottom);
				end
			end
			
			if (x <= (screenWidth * (1/2))) then
				local left = x + setX;
				setX = setX + (width / 2);
				if (left < 0) then
					setX = setX - left;
				end
			else
				setX = -setX;
				local right = x + setX;
				setX = setX - (width / 2);
				if (right > screenWidth) then
					setX = setX - (right - screenWidth);
				end
			end
			
			scale = tooltip:GetScale();
			if (scale) then
				setX = setX / scale;
				setY = setY / scale;
			end
			tooltip:SetOwner(owner, "ANCHOR_CURSOR", setX, setY);
		end
	else
		tooltip:SetOwner(owner, "ANCHOR_TOPLEFT");
	end
end

-- Obtains all information about a bag/slot and returns it as an array 
function GetItemInfoStrings(bag,slot, TooltipNameBase)
	if ( TooltipNameBase == nil ) then 
		TooltipNameBase = "UltimateUITooltip";
	end

	ClearTooltip(TooltipNameBase);

	local tooltip = getglobal(TooltipNameBase);
	
	-- Open tooltip & read contents
	-- Sea.wow.tooltip.protectTooltipMoney();
	tooltip:SetBagItem( bag, slot );
	-- Sea.wow.tooltip.protectTooltipMoney();
	local strings = ScanTooltip(TooltipNameBase);

	-- Done our duty, send report
	return strings;
end

-- Item Classification
-- Thanks to Zatharas, Narands, Xdra, Mirodin and Reima for this list
HerbList = { 
	"Peacebloom", 
	"Silverleaf", 
	"Snakeroot", 
	"Magebloom", 
	"Bruiseweed", 
	"Swiftthistle",
	"Fadeleaf", 
	"Briarthorn", 
	"Kingsblood",
	"Wild Steelbloom",
	"Grave Moss", 
	"Liferoot",
	"Firebloom",
	"Goldthorn",
	"Stranglekelp",
	"Khadgar's Whiskers"
};
-- Baccarus for Truesilver
OreList = {
	"Copper Ore",
	"Tin Ore",
	"Silver Ore",
	"Mithril Ore",
	"Iron Ore",
	"Gold Ore",
	"Truesilver Ore",
	"Thorium Ore"
};
-- Melwein for Malachite
GemList = {
	"Malachite",
	"Pearl",
	"Moss Agate",
	"Tigerseye", 
	"Citrine",
	"Jade",
	"Shadowgem",
	"Aquamarine",
	"Blue Pearl",
	"Star Ruby"
};
-- Potion List ugh...
-- Thanks to Zatharas for linking holy spring water
PotionList = {
	"Potion",
	"Elixir",
	"Oil",
	"Holy Spring Water"
};
-- Tailoring List... ugh...
-- Thanks to Able for Silk (Spider etc)
TailorList = { 
	"Bolt",
	"Cloth",
	"Thread",
	"Dye",
	"Silk",
	"Bleach",
	"Magewave",
	"Runecloth",
	"Felcloth"
}
-- Leathercrafting ... ugh...
LeatherList = {
	"Leather",
	"Hide",
	"Scales"
};
-- Fishing 
FishingList = {
	"Bauble",
	"Nightcrawler",
	"Fishing Pole",
	"Fish Attractor"
};
-- Warlock Items
WarlockList = {
	"Soul Shard",
	"Healthstone",
	"Manastone",
	"Soulstone"
};
-- Shaman Items
ShamanList = {
	"Earth Totem",
	"Fire Totem",
	"Water Totem",
	"Air Totem",
	"Sapta"
};

-- And the worst ones: (Prepare for bad humor)

-- HP restoring items
FoodList = {
	"Bread", -- Boring but important first
	"Cornbread",
	"Haunch",
	"Mutton Chop",
	"Hog Shank",
	"Tough Jerky",
	"Stormwind Brie", -- What is Brie anyways?
	"Aged Cheddar",
	"Alterac Swiss",
	"Apple",
	"Watermelon",
	"Banana",
	"Ham Steak", -- I Love Ham Steak!
	"Dalaran Sharp", -- Ouch
	"Bleu", -- Ewwww Bleu cheese
	"Dwarven Mild", -- About time them dorfs got it right
	"Wolf Meat", -- Hawooooo
	"Roasted Boar Meat",
	"Mackerel", 
	"Smallfish",
	"Kaldorei Caviar",
	"Scorpid Surprise",
	"Beer Basted",
	"Smoked Bear Meat",
	"Roasted Kodo Meat",
	"Mud Snapper",
	"Rainbow Fin Albacore",
	"Halibut",
	"Strider Stew",
	"Fillet of Frenzy",
	"Boiled Clams",
	"Goretusk Liver Pie",
	"Loch Frenzy Delights",
	"Coyote Steak",
	"Blood Sausage",
	"Westfall Stew",
	"Crab Cake",
	"Crispy Lizard",
	"Pork Ribs",
	"Croclist Steak",
	"Savory Deviate",
	"Scorpid Surprise",
	"Cooked Crab Claw",
	"Dig Rat Stew",
	"Murloc Fin Soup",
	"Clam Chowder",
	"Seasoned Wolf",
	"Spider Cake",
	"Bear Steak",
	"Venison",
	"Pork Ribs",
	"Gumbo",
	"Lion Chops",
	"Goblin Deviled",
	"Omelet",
	"Tasty Lion Steak",
	"Barbecued Buzzard",
	"Giant Clam Scorcho",
	"Soothing Turtle",
	"Rockscale Cod",
	"Cave Mold",
	"eckled Mushroom",
	"Mushroom Cap",
	"Bolete",
	"Morel",
	"Truffle",
	"Strider Stew",
	"Mystery Stew",
	"Roast Raptor",
	"Carrion Surprise",
	"Dragonbreath Chi",
	"Spiced Chi",
	"Monster Om",
	"Spiced Wolf",
	"Goldthorn Tea",
	"Squid",
	"Pumpkin",
	"Ice Cream" -- Tigule's specialty
};
-- Mana restoring items
DrinkList = {
	"Cherry Grog", -- The ONE AND ONLY BABY!	
	"Moonberry Juice",
	"Cold Milk",
	"Melon Juice",
	"Sweet Nectar",
	"Spring Water",
	"Glory Dew"
};

-- Checks if any item from a list is in a specified word

function IsListItemInWord(list, word) 
	for k,v in list do
		if ( string.find(word,v) ~= nil ) then
			return true;
		end
	end
	return false;
end

-- This function obtains all the information you could ever want about an item... 
--  ... if its available.
--
--  classification, name, quality, itemCount, leftString, rightString, minLevel, unique, soulbound, bindsOnPickup, bindsOnEquip, questItem;
function ClassifyItem(bag, slot, TooltipNameBase)
	if ( TooltipNameBase == nil ) then 
		TooltipNameBase = "UltimateUITooltip";
	end
	
	local strings = GetItemInfoStrings(bag, slot, TooltipNameBase);
	local classification = "Misc";
	local leftString, rightString, minLevel;
	local unique = false;
	local soulbound = false;
	local bindsOnPickup = false;
	local bindsOnEquip = false;
	local questItem = false;
	local isHerb = false;
	local isGem = false;
	local isOre = false;
	local isLeather = false;
	local isTailor = false;
	local isFishing = false;
	local isFood = false;
	local isDrink = false;
	local isShaman = false;
	local isWarlock = false;
	local isJunk = false;
	local engineering = false;
	local firstaid = false;
	local classitem = false;
	local class = "";
	local texture, itemCount, locked, quality = GetContainerItemInfo(bag,slot);
	local name = "";
	-- Look for the target line that identifies an item; it'll either be line 2, 3, or 4.

	-- Determine if the item is an ore, gem or herb
	if ( strings[1] ) then
		name = strings[1].left;
	end
	
	isHerb = IsListItemInWord(HerbList, name);
	isGem  = IsListItemInWord(GemList, name);
	isOre  = IsListItemInWord(OreList, name);
	isLeather = IsListItemInWord(LeatherList, name);
	isFishing = IsListItemInWord(FishingList, name);
	isTailor = IsListItemInWord(TailorList, name);
	isPotion = IsListItemInWord(PotionList, name);
	isFood = IsListItemInWord(FoodList, name);
	isDrink = IsListItemInWord(DrinkList, name);
	isShaman = IsListItemInWord(ShamanList, name);
	isWarlock = IsListItemInWord(WarlockList, name);

	if ( ( quality ) and ( quality < 0 ) ) then 
		isJunk = true;
	end

	for i = 2, 5, 1 do
		if (not strings[i])
		then
			break;
		end
		if (strings[i].left == ITEM_UNIQUE or strings[i].left == ITEM_UNIQUE_MULTIPLE ) then unique = true; end
		if (strings[i].left == ITEM_SOULBOUND ) then soulbound = true; end
		if (strings[i].left == ITEM_BIND_ON_PICKUP ) then bindsOnPickup = true; end
		if (strings[i].left == ITEM_BIND_ON_EQUIP ) then bindsOnEquip = true; end
		if (strings[i].left == ITEM_BIND_QUEST ) then questItem = true; end

		if (string.find(strings[i].left,"First Aid", 0, true ) ) then firstaid = true; end
		if (string.find(strings[i].left,"Engineering", 0, true ) ) then engineering = true; end
		if (string.find(strings[i].left,"Classes:", 0, true ) ) then classitem = true; class = string.sub(strings[i].left, string.find(strings[i].left,":", 0, true )+2); end
		
		if (strings[i].left and
			strings[i].left ~= ITEM_UNIQUE and
			strings[i].left ~= ITEM_SOULBOUND and
			strings[i].left ~= ITEM_BIND_ON_EQUIP and
			strings[i].left ~= ITEM_BIND_ON_PICKUP and
			strings[i].left ~= ITEM_BIND_QUEST)
		then
			leftString = strings[i].left;
			rightString = strings[i].right;
			break;
		end
	end
	
	-- Find last line
	local lastLine;
	for i = 1, 10, 1 do
		if (strings[i] and strings[i].left)
		then
			lastLine = strings[i].left;
		else
			break;
		end
	end

	-- look at last line to see if it's a level requirement
	local minLevel = 0;
	if (lastLine)
	then
		local index, length, levelString = string.find(lastLine, "^Requires Level (%d+)$");
		if (index)
		then
			minLevel = MakeIntFromString(levelString);
		end
	end
	
	-- classify item based on found strings
	if (leftString)
	then
		if (leftString == "Main Hand" or
			leftString == "Two-Hand" or
			leftString == "One-Hand")
		then
			classification = "Weapon";
		elseif (leftString == "Head" or
			leftString == "Hand" or
			leftString == "Waist" or
			leftString == "Shoulders" or
			leftString == "Legs" or
			leftString == "Back" or
			leftString == "Feet" or
			leftString == "Chest" or
			leftString == "Wrist")
		then
			classification = "Armor";
		elseif (leftString == "Off Hand")
		then
			classification = "Shield";
		elseif (leftString == "Wand" or
			leftString == "Ranged" or
			leftString == "Gun" )
		then
			classification = "Ranged";
		elseif (leftString == "Projectile") 
		then
			classification = "Ammo";
		elseif (leftString == "Shirt" or
			leftString == "Tabard" or
			leftString == "Finger" or
			leftString == "Neck" or
			leftString == "Trinket" or
			leftString == "Held In Hand")
		then
			classification = "Clothing";
		end
	end
	if ( classification == "Misc" ) then
		if ( isGem ) then classification = "Gem"; end
		if ( isOre ) then classification = "Ore"; end
		if ( isHerb ) then classification = "Herb"; end
		if ( engineering ) then classification = "Engineering"; end
		if ( firstaid ) then classification = "First Aid"; end
		if ( isLeather ) then classification = "Leather"; end
		if ( isTailor ) then classification = "Thread"; end
		if ( isPotion ) then classification = "Potion"; end
		if ( isFishing ) then classification = "Fishing"; end
		if ( isFood ) then classification = "Food"; end
		if ( isDrink ) then classification = "Drink"; end
		if ( isShaman ) then classification = "Shaman"; end
		if ( isWarlock ) then classification = "Warlock"; end
		if ( classitem ) then classification = class; end
		if ( questItem ) then classification = "QuestItem"; end
		if ( isJunk ) then classification = "Junk"; end
	end 

	return classification, name, quality, itemCount, leftString, rightString, minLevel, unique, soulbound, bindsOnPickup, bindsOnEquip, questItem;
end

-- String Functions

function MakeIntFromString(str)
	DebugPrint("MakeIntFromString("..str..")", 4);
	local remain = str;
	local amount = 0;
	while (remain ~= "") do
		amount = amount * 10;
		amount = amount + (string.byte(strsub(remain, 1, 1)) - string.byte("0"));
		remain = strsub(remain, 2);
	end
	DebugPrint("MakeIntFromStr("..str..") = "..amount, 4);
	return amount;
end

function MakeIntFromHexString(str)
	DebugPrint("MakeIntFromHexString("..str..")", 4);
	local remain = str;
	local amount = 0;
	while (remain ~= "") do
		amount = amount * 16;
		local byteVal = string.byte(strupper(strsub(remain, 1, 1)));
		if (byteVal >= string.byte("0") and byteVal <= string.byte("9"))
		then
			amount = amount + (byteVal - string.byte("0"));
		elseif (byteVal >= string.byte("A") and byteVal <= string.byte("F"))
		then
			amount = amount + 10 + (byteVal - string.byte("A"));
		end
		remain = strsub(remain, 2);
	end
	DebugPrint("MakeIntFromHexStr("..str..") = "..amount, 4);
	return amount;
end

function MakeHexStringFromInt(intval, minlength)
	return string.format("%"..minlength.."x", intval );
end

function EscapeString(plainString, disallowedChars)
	-- yay URL-encoding
	local str = "";
	local remain = plainString;
	disallowedChars = disallowedChars.."%";
	while (remain ~= "") do
		local char = strsub(remain, 1, 1);
		if (string.find(disallowedChars, char, 1, true))
		then
			str = str.."%";
			local hexRepresentation = string.format("%02x", string.byte(char));
			str = str..hexRepresentation;
		else
			str = str..char;
		end
		remain = strsub(remain, 2);
	end
	return str;
end

function UnescapeString(escapedString)
	local str = "";
	local remain = escapedString;
	while (remain ~= "") do
		local char = strsub(remain, 1, 1);
		if (char == "%")
		then
			str = str..string.char(MakeIntFromHexString(strsub(remain, 2, 3)));
			remain = strsub(remain, 4);
		else
			str = str..char;
			remain = strsub(remain, 2);
		end
	end
	return str;
end

-- Converts numeric time into readable time.
function GetTimeString(time)
	if (time < 0)
	then
		time = 0;
	end

	local seconds = mod(floor(time), 60);
	if (seconds < 10)
	then
		seconds = "0"..seconds;
	end
	local minutes = mod(floor(time/60), 60);
	local hours = floor(time/(60*60));
	
	local timeString;
	if (hours > 0)
	then
		if (minutes < 10)
		then
			minutes = "0"..minutes;
		end
		timeString = hours..":"..minutes..":"..seconds;
	else
		timeString = minutes..":"..seconds;
	end
	return timeString;
end


function GetRGBAFromHexColor(hexColor)
	local alpha = MakeIntFromHexString(strsub(hexColor, 1, 2)) / 256;
	local red = MakeIntFromHexString(strsub(hexColor, 3, 4)) / 256;
	local green = MakeIntFromHexString(strsub(hexColor, 5, 6)) / 256;
	local blue = MakeIntFromHexString(strsub(hexColor, 7, 8)) / 256;
	return red, green, blue;
end		

-- Mathematical Functions (yuck!)
function CheckBits(field, bits)
	local result = true;
	while (bits > 0) do
		if (mod(bits, 2) > 0)
		then
			if (mod(field, 2) == 0)
			then
				result = false;
				break;
			end
		end
		field = floor(field / 2);
		bits = floor(bits / 2);
	end
	return result;
end


function SetBit(field, bit)
	local source = 2^31; -- 1 in highest-order bit
	local shiftCount = 1;
	local result = 0;
	while (bit > 0) do
		result = floor(result / 2);
		-- if we're about to shift off a 1, put a 1 on the destination.
		if ((mod(bits, 2) == 1) or (mod(field, 2) == 1))
		then
			result = result + source;
		end
		field = floor(field / 2);
		bits = floor(bits / 2);
		shiftCount = shiftCount + 1;
	end
	for i = shiftCount, 32, 1 do
		result = floor(result / 2);
		-- if we're about to shift off a 1, put a 1 on the destination.
		if (mod(bits, 2) == 1)
		then
			result = result + source;
		end
		field = floor(field / 2);
	end
	return result;
end

function ClearBit(field, bit)
	local source = 2^31; -- 1 in highest-order bit
	local shiftCount = 1;
	local result = 0;
	while (bit > 0) do
		result = floor(result / 2);
		-- if we're about to shift off a 1, put a 1 on the destination. AS LONG AS this is not the bit to clear
		if ((mod(field, 2) == 1) and not (mod(bit, 2) == 1))
		then
			result = result + source;
		end
		field = floor(field / 2);
		bits = floor(bits / 2);
		shiftCount = shiftCount + 1;
	end
	for i = shiftCount, 32, 1 do
		result = floor(result / 2);
		-- if we're about to shift off a 1, put a 1 on the destination.
		if (mod(bits, 2) == 1)
		then
			result = result + source;
		end
		field = floor(field / 2);
	end
	return result;
end

function UnitFaction(who)
	local faction;
	local race = UnitRace(who);
	local HordeRaces = {"Orc", "Tauren", "Troll", "Undead" };

	for index, hordeRace in HordeRaces do
		if (race == hordeRace)
		then
			return 1; -- Horde
		end
	end
	return 0; -- Alliance
end

function BaseConversion(input, inputBase, outputBase)
-----------------------------------------------------------
--               Function made by KaTTaNa !              -- 
--               --------------------------              --
--   http://www.wc3sear.ch/index.php?p=JASS&ID=37&sid=   --
--               --------------------------              --
--               Converted in LUA by vjeux               --
--                                                       --
-- Usage : BaseConversion(255, 10, 16)                   --
-- => Return "ff"                                        --
--                                                       --
-- Usage : BaseConversion("ff", 16, 10)                  --
-- => Return "10"                                        --
-----------------------------------------------------------
    local charMap = "0123456789abcdefghijklmnopqrstuvwxyz~!@#$%^&*()_+-=[]";
    local s;
    local result = "";
    local val = 0;
    local i;
    local p = 0;
    local pow = 1;
    local sign = "";

    if ( inputBase < 2 or inputBase > strlen(charMap) or outputBase < 2 or outputBase > strlen(charMap) ) then
        -- Bases are invalid or out of bounds
        return "Invalid bases given";
    end
    if ( strsub(input, 1, 1) == "-" ) then
        sign = "-";
        input = strsub(input, 1, strlen(input));
    end
    i = strlen(input);
    -- Get the integer value of input
    while (i > 0) do
        s = strsub(input, i, i);
        p = 0;
		local bool = false;
        while (bool == false) do
            if ( p >= inputBase ) then
                -- Input cannot match base
                return "Input does not match base!\n P = "..p;
            end
			if ( s == strsub(charMap, p+1, p+1) ) then
                val = val + pow * p;
                pow = pow * inputBase;
                bool = true;
            end
            p = p + 1;
        end
        i = i - 1;
    end
    while (val > 0) do
        p = mod(val, outputBase);
        result = strsub(charMap, p+1, p+1)..result;
        val = val / outputBase;
    end

	for i = 1, strlen(result), 1 do
		if (strsub(result, 1, 1) == "0") then
			result = strsub(result, 2, strlen(result));
		else
			return sign..result
		end
	end

	if (strlen(sign..result) == 0) then 
		return "0";
	else
		return sign..result.."-"..strlen(sign..result);
	end
end


-- Thott's personalized functions
function dbanner(...)
  if ( (Thottbot) and (Thottbot.Debug) ) then
    UIErrorsFrame:AddMessage(join(arg,""), 0.9, 0.9, 0.0, 1.0, UIERRORS_HOLD_TIME);			  					
    dprint(join(arg,""));
  end
end
function banner(...)
  UIErrorsFrame:AddMessage(join(arg,""), 0.9, 0.9, 0.0, 1.0, UIERRORS_HOLD_TIME);			  					
end
function dbyte(c)
  return string.format("<%02X>",string.byte(c));
end
--function dprint_runqueue()
--  if(dprint_nextmsg) then
--    print2(dprint_nextmsg);
--    dprint_nextmsg = nil;
--  end
--  if(dprint_queue and dprint_queue[1]) then
--    local msg = table.remove(dprint_queue,1);
--    dprint_nextmsg = msg;
--    msg = string.gsub(msg,"([^%w%s])",dbyte)
--    print2("Next: ",msg);
--    UltimateUI_Schedule(0.01,dprint_runqueue);
--    dprint_queue_scheduled = true;
--  else
--    dprint_queue_scheduled = false;
--  end
--end
function dprint(...)
  if ( ( Thottbot ) and (Thottbot.Debug) ) then
    local msg = join(arg,"");
    msg = string.gsub(msg,"|","<pipe>");
    msg = string.gsub(msg,"([^%w%s%a%p])",dbyte);
    if(Thottbot.DebugFrame) then
      printframe(Thottbot.DebugFrame,msg);
    else
      print2(msg);
    end
--    if(not dprint_queue) then
--      dprint_queue = {};
--    end
--    table.insert(dprint_queue,join(arg,""));
--    if(not dprint_queue_scheduled) then
--      dprint_queue_scheduled = true;
--      UltimateUI_Schedule(0.01,dprint_runqueue);
--      -- 68.94.173.94
--    end
  end
end
--    Thottbot.PrintCount = Thottbot.PrintCount + 1;
--    if(Thottbot.PrintCount < 60) then
--      for key,value in arg do
--        arg[key] = string.gsub(value,"[^%w%s%p]",".");
--      end
--      print2(Thottbot.PrintCount,":",join(arg,""));
function dprint1(...)
  if ( (Thottbot) and (Thottbot.Debug) ) then
    print1(join(arg,""));
  end
end
function split(s,seperator)
  local t = {};
  t.n = 0;
  for value in string.gfind(s,"[^"..seperator.."]+") do
    t.n = t.n + 1;
    t[t.n] = value;
  end
  return t;
end
function join(list,seperator)
  local i;
  local c = "";
  local msg = "";
  if(type(list) ~= "table") then
    dbanner("unknown type ",type(list)," table passed to join, seperator ",seperator);
    return;
  end
  if(not list.n) then
    dbanner("ERROR: no .n variable in list!");
    return "";
  end
  for i=1, list.n, 1 do
    if(list[i]) then
      if(type(list[i]) ~= "string" and type(list[i]) ~= "number") then
        dbanner("found ",type(list[i])," in list!");
        msg = msg .. c .. "(" .. type(list[i]) .. ")";
      else
	msg = msg .. c .. list[i];
      end
    else
      msg = msg .. c .. "(nil)";
    end
    c = seperator;
  end
  return msg;
end
function dprintlist(list)
  if ( (Thottbot) and (Thottbot.Debug) ) then
    if(list) then
      dprint(join(list,","));
    else
      dprint("nil list");
    end
  end
end
function dprintcomma(...)
  dprint(join(arg,","));
end
function printframe(frame,...)
  if(frame) then
    frame:AddMessage(join(arg,""), 1.0, 1.0, 0.0);
  end
end
function print2(...)
  if(ChatFrame2) then
    ChatFrame2:AddMessage(join(arg,""), 1.0, 1.0, 0.0);
  end
end
function print1(...)
  if(ChatFrame1) then
    ChatFrame1:AddMessage(join(arg,""), 1.0, 1.0, 0.0);
  end
end
function push(t,v)
  if(not t or not t.n) then
    dbanner("Bad table passed to push");
    return nil;
  end
  t.n = t.n+1;
  t[t.n] = v;
end
function pop(t)
  if(not t or not t.n) then
    dbanner("Bad table passed to push");
    return nil;
  end
  local v = t[t.n];
  t.n = t.n - 1;
  return v;
end
function push2(t,x,y)
  if(not t or not t.n) then
    dbanner("Bad table passed to push2");
    return nil;
  end
  t.n = t.n+1;
  t[t.n] = x;
  t.n = t.n+1;
  t[t.n] = y;
end
function pop2(t)
  if(not t or not t.n) then
    --dbanner("Bad table passed to pop2");
    return nil;
  end
  if(t.n < 2) then
    return nil;
  end
  local tt = {};
  tt.n = 2;
  tt[1] = t[t.n-1];
  tt[2] = t[t.n];
  t.n = t.n - 2;
  return tt;
end
function fixnil(...)
  for i=1, arg.n, 1 do
    if(not arg[i]) then
      arg[i] = "(nil)";
    end
  end
  return arg;
end
function fixnilempty(...)
  for i=1, arg.n, 1 do
    if(not arg[i]) then
      arg[i] = "";
    end
  end
  return arg;
end
function fixnilzero(...)
  for i=1, arg.n, 1 do
    if(not arg[i]) then
      arg[i] = 0;
    end
  end
  return arg;
end
function HookHandler(name,arg)
  --dprint("HookHandler ",name);
  local called = false;
  local continue = true;
  local retval;
  for key,value in Hooks[name].hide do
    if(type(value) == "function") then
      --dprint("calling before ",name);
      if(not value(unpack(arg))) then
        continue = false;
      end
      called = true;
    end
  end
  if(not continue) then
    dprint("hide returned false, aborting call to ",name);
    return;
  end
  for key,value in Hooks[name].before do
    if(type(value) == "function") then
      --dprint("calling before ",name);
      value(unpack(arg));
      called = true;
    end
  end
  --dprint("calling original ",name);
  retval = Hooks[name].orig(unpack(arg));
  for key,value in Hooks[name].after do
    if(type(value) == "function") then
      --dprint("calling after ",name);
      value(unpack(arg));
      called = true;
    end
  end
  if(not called) then
    dprint("no hooks left for ",name,", clearing");
    setglobal(name,Hooks[name].orig);
    Hooks[name] = nil;
  end
  return retval;
end

-- Thanks to George Warner for suggesting this refactoring suggestion... as always, I modified it a bit :) /sarf
-- Source : http://www.ultimateuiui.org/cgi-bin/bugzilla/show_bug.cgi?id=158
function UltimateUI_IsUltimateUIUser(name)
	if ( not name ) then return false; end
	if ( UltimateUIMaster_UltimateUIUsers ) then
		if ( UltimateUIMaster_UltimateUIUsers[name] ) then 
			return true;
		end
	end
	return false;
end

-- helper function - returns value as a byte
function UltimateUI_GetByteValue(pValue)
	local value = tonumber(pValue);
	if ( value <= 0 ) then return 0; end
	if ( value >= 255 ) then return 255; end
	return value;
end


-- Yet another function from George Warner, modified a bit to fit my own nefarious purposes. 
-- It can now accept r, g and b specifications, too (leaving out a), as well as handle 255 255 255
-- Source : http://www.ultimateuiui.org/cgi-bin/bugzilla/show_bug.cgi?id=159
function UltimateUI_GetColorFormatString(a, r, g, b)
	local percent = false;
	if ( ( ( not b ) or ( b <= 1 ) ) and ( a <= 1 ) and ( r <= 1 ) and ( g <= 1) ) then percent = true; end
	if ( ( not b ) and ( a ) and ( r ) and ( g ) ) then b = g; g = r; r = a; if ( percent ) then a = 1; else a = 255; end end
	if ( percent ) then a = a * 255; r = r * 255; g = g * 255; b = b * 255; end
	a = UltimateUI_GetByteValue(a); r = UltimateUI_GetByteValue(r); g = UltimateUI_GetByteValue(g); b = UltimateUI_GetByteValue(b);
	
	return format("|c%02X%02X%02X%02X%%s|r", a, r, g, b);
end


-- global localization string functions START

function loc_format(...)
  ret = arg[1];
  for i=2, arg.n, 1 do
    ret = string.gsub (ret, "<"..(i-1)..">", arg[i]);
  end
  return ret;
end

function loc_read(str, fmt, ord, n)
  local ret = {};
  fmt1 = string.gsub (fmt, "%b<>", "(.+)");
  for i=1, n, 1 do
    ret[ord[i]] = string.gsub(str, fmt1, "%"..i);
  end
  return unpack(ret);
end

-- global localization string functions END

--Returns true if variable is not nill and a table
function isTable(var)
	if (var and (type(var) == "table")) then
		return true;
	end
	return false;	
end

function MakeHyperLink(type, name, color)
	local link = "["..name.."]";
	if (color) then
		link = "|cFF"..color.."["..name.."]|r";
	end
	return "|H"..type.."|h"..link.."|h";
end

-- elite frame functions

function UUISetElite()
	PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
end