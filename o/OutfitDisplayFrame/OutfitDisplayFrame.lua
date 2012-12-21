OUTFITDISPLAYFRAME_VERSION = "0.5.6";
OUTFITDISPLAYFRAME_NAME = "Outfit Display Frame";
OUTFITDISPLAYFRAME_TITLE = OUTFITDISPLAYFRAME_NAME.." v"..OUTFITDISPLAYFRAME_VERSION;
OUTFITDISPLAYFRAME_BANKDELAY = 0.5;

local PlayerSlotNames = {
   [1] = { name = "HeadSlot", tooltip = HEADSLOT };
   [2] = { name = "NeckSlot", tooltip = NECKSLOT },
   [3] = { name = "ShoulderSlot", tooltip = SHOULDERSLOT },
   [4] = { name = "BackSlot", tooltip = BACKSLOT },
   [5] = { name = "ChestSlot", tooltip = CHESTSLOT },
   [6] = { name = "ShirtSlot", tooltip = SHIRTSLOT },
   [7] = { name = "TabardSlot", tooltip = TABARDSLOT },
   [8] = { name = "WristSlot", tooltip = WRISTSLOT },
   [9] = { name = "HandsSlot", tooltip = HANDSSLOT },
   [10] = { name = "WaistSlot", tooltip = WAISTSLOT },
   [11] = { name = "LegsSlot", tooltip = LEGSSLOT },
   [12] = { name = "FeetSlot", tooltip = FEETSLOT },
   [13] = { name = "Finger0Slot", tooltip = FINGER0SLOT },
   [14] = { name = "Finger1Slot", tooltip = FINGER1SLOT },
   [15] = { name = "Trinket0Slot", tooltip = TRINKET0SLOT },
   [16] = { name = "Trinket1Slot", tooltip = TRINKET1SLOT },
   [17] = { name = "MainHandSlot", tooltip = MAINHANDSLOT },
   [18] = { name = "SecondaryHandSlot", tooltip = SECONDARYHANDSLOT },
   [19] = { name = "RangedSlot", tooltip = RANGEDSLOT },
}

local SavedPickupContainerItem = nil;
local SavedPickupInventoryItem = nil;

local LastOffSource = nil;
local PerformSlowerSwap = false;
local BankIsOpen = false;

local function tonil(val)
   if ( not val ) then
      return "nil";
   else
      return val;
   end
end

local function Print(msg, r, g, b)
   if ( DEFAULT_CHAT_FRAME ) then
      if ( not r ) then
    DEFAULT_CHAT_FRAME:AddMessage(msg);
      else
    DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
      end
   end
end

-- Based on code in QuickMountEquip
local function SafeHookFunction(func, newfunc)
   local oldValue = getglobal(func);
   if ( oldValue ~= getglobal(newfunc) ) then
      setglobal(func, getglobal(newfunc));
      return true;
   end
   return false;
end

-- this really ought to be in a library somewhere
local function SplitLink(link)
   local _,_, color, item, name = string.find(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r");
   return color, item, name;
end

function OutfitDisplayFrame_OnLoad()
   local temp = PickupContainerItem;
   if ( SafeHookFunction("PickupContainerItem", "OutfitDisplayFrame_PickupContainerItem") ) then
      SavedPickupContainerItem = temp;
   end

         temp = PickupInventoryItem;
   if ( SafeHookFunction("PickupInventoryItem", "OutfitDisplayFrame_PickupInventoryItem") ) then
      SavedPickupInventoryItem = temp;
   end

   local parent = this:GetName();
   for i=1,19,1 do
      local slotName = PlayerSlotNames[i].name;
      local button = getglobal(parent..slotName);
      button.tooltip = PlayerSlotNames[i].tooltip;
      OutfitDisplayItemButton_Draw(button);
      PlayerSlotNames[i].id = GetInventorySlotInfo(slotName);
   end

   -- ideas borrowed from "WeaponQuickSwap - by CapnBry"
   this:RegisterEvent("ITEM_LOCK_CHANGED");
   this:RegisterEvent("BANKFRAME_OPENED");
   this:RegisterEvent("BANKFRAME_CLOSED");

   Print(OUTFITDISPLAYFRAME_TITLE.." loaded.");
end

local function DressUpItem(model, thing)
   if ( not model or not thing or thing == "" ) then
      return;
   end
   local item = gsub(thing, "(%d+).*", "%1", 1);
   model:TryOn(item);
end

local BankFrameClosedTime = 0;

function OutfitDisplayFrame_OnEvent(...)
   if ( arg[1] == "BANKFRAME_OPENED" or arg[1] == "BANKFRAME_CLOSED" ) then
      BankFrameIsOpen = ( arg[1] == "BANKFRAME_OPENED" );
      local frame = getglobal(this:GetName().."MessageUpdateFrame");
      if ( frame ) then
	 BankFrameClosedTime = OUTFITDISPLAYFRAME_BANKDELAY;
	 frame:Show();
      end
   elseif (arg[1] == "ITEM_LOCK_CHANGED") and not arg[2] then
      return OutfitDisplayFrame_ExecuteSwapIteration();
   end
end

function OutfitDisplayFrame_MessageUpdate(elapsed)
   BankFrameClosedTime = BankFrameClosedTime - elapsed;
   if ( BankFrameClosedTime <= 0 ) then
      this:Hide();
      OutfitDisplayFrame_UpdateMessage(this:GetParent());
      BankFrameClosedTime = 0;
   end
end

local function GetSlotButton(button, slotName)
   local parent = button:GetParent():GetName();
   return getglobal(parent..slotName);
end

local function IsItemOneHanded(item)
   if ( item ) then
      local _,_,_,_,_,_,_,bodyslot = GetItemInfo("item:"..item);
      if ( bodyslot ==  "INVTYPE_2HWEAPON" or bodyslot == INVTYPE_2HWEAPON ) then
	 return false;
      end
   end
   return true;
end

function OutfitDisplayFrame_CursorCanGoInSlot(button)
   if ( button.forced ) then
      return false;
   end
   local secondary = GetSlotButton(button, "SecondaryHandSlot");
   local mainbutton = GetSlotButton(button, "MainHandSlot");
   if ( button == secondary and mainbutton and mainbutton.item ) then
      return IsItemOneHanded(mainbutton.item);
   end
   return CursorCanGoInSlot(button:GetID())
end

-- much hackery to know what actually is in the cursor when somebody drops it on us
local OD_Track_Bag = nil;
local OD_Track_Slot = nil;

-- whatever we think the user picked up, apply it to our stuff
local function AcceptCursorItem(button)
   local parent = button:GetParent();
   local pname = parent:GetName();
   if ( not OutfitDisplayFrame_CursorCanGoInSlot(button) ) then
      button = nil;
      for i=1,19,1 do
	 local temp = getglobal(pname..PlayerSlotNames[i].name);
	 if ( temp and OutfitDisplayFrame_CursorCanGoInSlot(temp) ) then
	    button = temp;
	 end
      end
   end

   if ( button ) then
      local link, texture;
      if ( OD_Track_Bag ) then
	 link = GetContainerItemLink(OD_Track_Bag, OD_Track_Slot);
	 texture = GetContainerItemInfo(OD_Track_Bag, OD_Track_Slot);
      else
	 link = GetInventoryItemLink("player", OD_Track_Slot);
	 texture = GetInventoryItemTexture("player", OD_Track_Slot);
      end
      button.color, button.item, button.name = SplitLink(link);
      button.texture = texture;
      button.used = true;
      button.empty = nil;
      button.missing = false;
      if ( OD_Track_Bag and (OD_Track_Bag == BANK_CONTAINER or
			     OD_Track_Bag > NUM_BAG_SLOTS) ) then
	 button.banked = true;
      end
      OutfitDisplayItemButton_Change(button);
   end

   -- clear the cursor item
   if ( OD_Track_Bag ) then
      SavedPickupContainerItem(OD_Track_Bag, OD_Track_Slot);
   elseif ( OD_Track_Slot ) then
      SavedPickupInventoryItem(OD_Track_Slot);
   end
   OD_Track_Bag = nil;
   OD_Track_Slot = nil;
end

-- figure out what the user picked up, so that if they drop it on us we can deal with it
function OutfitDisplayFrame_TrackItemPickup(bag, slot)
   OD_Track_Bag = bag;
   OD_Track_Slot = slot;
end

function OutfitDisplayFrame_PickupContainerItem(bag, slot)
   if ( SavedPickupContainerItem ) then
      SavedPickupContainerItem(bag, slot);
   end
   OutfitDisplayFrame_TrackItemPickup(bag, slot);
end

function OutfitDisplayFrame_PickupInventoryItem(slot)
   if ( SavedPickupInventoryItem ) then
      SavedPickupInventoryItem(slot);
   end
   OutfitDisplayFrame_TrackItemPickup(nil, slot);
end

-- handle making the items in the outfit pane do nice things
function OutfitDisplayItemButton_OnEnter()
   if ( GameTooltip.finished ) then
      return;
   end
   GameTooltip.finished = 1;
   GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
   if (this.item) then
      local link = "item:"..this.item;
      if ( GetItemInfo(link) ) then
         GameTooltip:SetHyperlink(link);
      elseif ( this.name ) then
         GameTooltip:SetText(this.name);
      elseif ( this.tooltip ) then
         GameTooltip:SetText(this.tooltip);
      else
         GameTooltip:SetText("<unlinkable item>", 1, 0, 0);
      end
   elseif ( this.tooltip ) then
      GameTooltip:AddLine(this.tooltip);
   else
      local parentlen = string.len(this:GetParent():GetName())+1;
      local slotName = strsub(this:GetName(), parentlen);
      slotName = strsub(slotName, 1, string.len(slotName) - 4);
      this.tooltip = slotName;
      GameTooltip:AddLine(this.tooltip);
   end
   GameTooltip:AddLine(OUTFITDISPLAYFRAME_ALTCLICK,.8,.8,.8,1);
   GameTooltip:Show();
end

function OutfitDisplayItemButton_OnEvent(event)
   if ( event == "CURSOR_UPDATE" ) then
      if ( not this.forced ) then
	 if ((this.CursorCanGoInSlot and this.CursorCanGoInSlot(this)) or
	     OutfitDisplayFrame_CursorCanGoInSlot(this)) then
	    this:LockHighlight();
	 else
	    this:UnlockHighlight();
	 end
      end
   end
end

function OutfitDisplayItemButton_OnClick(clicked, ignoreModifiers)
   if ( clicked == "LeftButton" ) then
      if( not ignoreModifiers or ignoreModifiers == 0 ) then
	 if ( IsShiftKeyDown() ) then
	    if ( this.item and ChatFrameEditBox:IsVisible() ) then
	       local color = this.color;
	       if ( not color ) then
		  color = "ffffffff";
	       end
	       local link = "|c"..color.."|Hitem"..this.item.."|h["..this.name.."]|h|r";
	       ChatFrameEditBox:Insert(link);
	       return;
	    end
	 elseif ( IsAltKeyDown() ) then
	    OutfitDisplayItemButton_Clear(this, false, false);
	    OutfitDisplayItemButton_Change(this);
	    return;
	 end
      end
      -- fall through for drags and non-modified clicks
      if ( CursorHasItem() ) then
	 AcceptCursorItem(this);
      end
   end
end

function OutfitDisplayItemButton_OnLoad()
   local parentlen = string.len(this:GetParent():GetName())+1;
   local slotName = strsub(this:GetName(), parentlen);
   local id;
   local textureName;
   id, textureName = GetInventorySlotInfo(slotName);
   this:SetID(id);
   this.backgroundTextureName = textureName;
   SetItemButtonTexture(this, this.backgroundTextureName);
   this:RegisterForDrag("LeftButton");
   this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
   this:RegisterEvent("CURSOR_UPDATE");
end

function OutfitDisplayItemButton_Draw(button)
   if ( button.texture ) then
      SetItemButtonTexture(button, button.texture);
   else
      SetItemButtonTexture(button, button.backgroundTextureName);
   end
   if ( button.missing ) then
      SetItemButtonTextureVertexColor(button, 1.0, 0.1, 0.1);
   elseif ( button.banked ) then
      SetItemButtonTextureVertexColor(button, 0.1, 0.1, 1.0);
   else
      SetItemButtonTextureVertexColor(button, 1.0, 1.0, 1.0);
   end
   local checkbox = getglobal(button:GetName().."CheckBox");
   if (checkbox) then
      local pname = button:GetParent():GetName();
      local showhelm = getglobal(pname.."ShowHelm");
      local showcloak = getglobal(pname.."ShowCloak");
      if ( button.forced ) then
	 checkbox:SetChecked(true);
	 checkbox:Disable();
	 checkbox:Show();
      elseif ( button.empty or not button.used ) then
	 if ( checkbox.slotName == "HeadSlot" ) then
	    showhelm:Hide();
	    showhelm:SetChecked(false);
	 elseif ( checkbox.slotName == "BackSlot" ) then
	    showcloak:Hide();
	    showcloak:SetChecked(false);
	 end
	 checkbox:Enable();
	 checkbox:SetChecked(button.empty);
	 checkbox:Show();
      elseif ( button.used ) then
	 checkbox:Hide();
	 if ( checkbox.slotName == "HeadSlot" ) then
	    showhelm:Show();
	 elseif ( checkbox.slotName == "BackSlot" ) then
	    showcloak:Show();
	 end
      end
   end
end

function OutfitDisplayItemButton_Change(button)
   OutfitDisplayItemButton_Draw(button);
   -- handle two handed weapons
   local parent = button:GetParent();
   local pname = parent:GetName();
   local parentlen = string.len(pname)+1;
   local slotName = strsub(button:GetName(), parentlen);
   if ( slotName == "MainHandSlot" ) then
      local secondary = getglobal(pname.."SecondaryHandSlot");
      if ( not button.used and secondary.forced ) then
	 OutfitDisplayItemButton_Clear(secondary, false, false);
      elseif ( button.used and not IsItemOneHanded(button.item) ) then
	 OutfitDisplayItemButton_Clear(secondary, true);
	 secondary.forced = true;
      end
      OutfitDisplayItemButton_Draw(secondary);
   end
   OutfitDisplayFrame_UpdateMessage(parent);
   OutfitDisplayFrame_UpdateModel(parent, button);
   if( parent.OutfitChanged ) then
      parent.OutfitChanged( button );
   end
end

function OutfitDisplayItemButton_Clear(button, empty, used)
   button.name = nil;
   button.item = nil;
   button.texture = nil;
   button.color = nil;
   button.missing = nil;
   button.banked = nil;
   button.forced = nil;
   button.empty = empty;
   button.used = used or empty;
end

-- override ShowHelm and ShowCloak
function OutfitDisplayOverrideBox_OnLoad()
   local parentlen = string.len(this:GetParent():GetName())+1;
   this.slotName = strsub(this:GetName(), parentlen);
end

function OutfitDisplayOverrideBox_OnEnter()
   GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
   local text;
   if ( this.slotName == "ShowHelm" ) then
      text = OUTFITDISPLAYFRAME_OVERRIDEHELM;
   else
      text = OUTFITDISPLAYFRAME_OVERRIDECLOAK;
   end
   GameTooltip:SetText(text, nil, nil, nil, nil, 1);
   GameTooltip:Show();
end

-- check box handling
function OutfitDisplayCheckBox_OnEnter()
   GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
   GameTooltip:SetText(OUTFITDISPLAYFRAME_USECHECKBOX, nil, nil, nil, nil, 1);
   GameTooltip:Show();
end

function OutfitDisplayCheckBox_OnLoad()
   local parentlen = string.len(this:GetParent():GetName())+1;
   local name = strsub(this:GetName(), parentlen);
   this.slotName = strsub(name, 1, -9);
end

function OutfitDisplayCheckBox_OnClick()
   local pname = this:GetParent():GetName();
   local button = getglobal(pname..this.slotName);
   OutfitDisplayItemButton_Clear(button, this:GetChecked());
   OutfitDisplayItemButton_Change(button);
end

local function UpdateModel_ThisSlot(pname, model, idx)
   local slotName = PlayerSlotNames[idx].name;
   local what = getglobal(pname..slotName);
   local item = nil;
   if ( what and what.used ) then
      if ( not what.empty ) then
	 item = what.item;
      end
   else
      local slot = PlayerSlotNames[idx].id;
      local link = GetInventoryItemLink("player", slot);
      if ( link ) then
	 _, item, _ = SplitLink(link);
      end
   end
   if ( item ) then
      DressUpItem(model, item);
   end
end

function OutfitDisplayFrame_UpdateModel(frame, button)
   local pname = frame:GetName();
   local model = getglobal(pname.."Model");
   local empty = false;
   if ( not model ) then
      return;
   end
   if ( button and button.used ) then
      if ( button.empty and not button.forced ) then
	 empty = true;
      end
   else
      for i=1,19,1 do
	 local what = getglobal(pname..PlayerSlotNames[i].name);
	 if ( what and what.empty ) then
	    empty = true;
	 end
      end
   end
   if ( empty ) then
      model:Undress();
   end
   for i=19,1,-1 do
      UpdateModel_ThisSlot(pname, model, i);
   end
end

function OutfitDisplayFrame_SetOutfit(frame, outfit)
   if not outfit then
      return;
   end
   local pname = frame:GetName();
   for i=1,19,1 do
      local slotName = PlayerSlotNames[i].name;
      local button = getglobal(pname..slotName);
      if ( button and outfit[slotName] and outfit[slotName].used ) then
	 OutfitDisplayItemButton_Clear(button);
	 if ( outfit[slotName].used ) then
	    button.name = outfit[slotName].name;
	    button.item = outfit[slotName].item;
	    button.texture = outfit[slotName].texture;
	    button.color = outfit[slotName].color;
	    button.missing = outfit[slotName].missing;
	    button.banked = outfit[slotName].banked;
	    button.forced = outfit[slotName].forced;
	    button.empty = outfit[slotName].empty;
	    button.used = true;
	 else
	    OutfitDisplayItemButton_Clear(button, true, true);
	 end
	 OutfitDisplayItemButton_Draw(button);
      end
   end
   if ( outfit["Options"] ) then
      local showhelm = getglobal(pname.."ShowHelm");
      local showcloak = getglobal(pname.."ShowCloak");
      showhelm:SetChecked(outfit["Options"].helm);
      showcloak:SetChecked(outfit["Options"].cloak);
   end
   OutfitDisplayFrame_UpdateModel(frame);
   OutfitDisplayFrame_UpdateMessage(frame, outfit);
end

function OutfitDisplayFrame_GetOutfit(frame, puthere)
   local pname = frame:GetName();
   local outfit = puthere or nil;
   local showhelm = getglobal(pname.."ShowHelm");
   local showcloak = getglobal(pname.."ShowCloak");
   local setOptions = false;
   if not outfit then
      outfit = {};
   end
   outfit["Options"] = {};
   for i=1,19,1 do
      local slotName = PlayerSlotNames[i].name;
      local button = getglobal(pname..slotName);

      if ( button and button.used ) then
	 outfit[slotName] = {};
	 if ( not button.empty ) then
	    outfit[slotName].name = button.name;
	    outfit[slotName].item = button.item;
	    outfit[slotName].texture = button.texture;
	    outfit[slotName].color = button.color;
	    outfit[slotName].missing = button.missing;
	    outfit[slotName].banked = button.banked;
	    outfit[slotName].forced = button.forced;
	 end
	 outfit[slotName].empty = button.empty;
	 outfit[slotName].used = true;
	 if ( not button.empty ) then
	    if ( slotName == "HeadSlot" ) then
	       if ( showhelm and showhelm:GetChecked() ) then
		  outfit["Options"].helm = true;
		  setOptions = true;
	       end
	    elseif ( slotName == "BackSlot" ) then
	       if ( showcloak and showcloak:GetChecked() ) then
		  outfit["Options"].cloak = true;
		  setOptions = true;
	       end
	    end
	 end
      elseif ( outfit and outfit.used ) then
	 outfit[slotName] = nil;
      end
   end
   if ( not setOptions ) then
      outfit["Options"] = nil;
   end
   if ( outfit ) then
      -- check for two-handed weapon
      local mainhand = outfit["MainHandSlot"];
      if ( mainhand and not IsItemOneHanded(mainhand.item) ) then
	 outfit["SecondaryHandSlot"] = {};
	 outfit["SecondaryHandSlot"].forced = true;
	 outfit["SecondaryHandSlot"].empty = true;
	 outfit["SecondaryHandSlot"].used = true;
      end
   end
   return outfit;
end

function OutfitDisplayFrame_GetItemInfo(bag, slot)
   local link;
   local c, i, n;
   if ( bag ) then
      link = GetContainerItemLink (bag,slot);
   else
      link = GetInventoryItemLink("player", slot);
   end
   if (link) then
      c, i, n = SplitLink(link);
   end
   return c, i, n;
end

-- get a snapshot of the current state of the player
function OutfitDisplayFrame_GetBagInfo()
   local contents = {};
   local empties = {};

   local numSlots = 0;
   -- check each of the bags on the player
   for bag=0, NUM_BAG_FRAMES do
      -- get the number of slots in the bag (0 if no bag)
      numSlots = GetContainerNumSlots(bag);
      if (numSlots > 0) then
	 -- check each slot in the bag
	 for slot=1, numSlots do
	    local c, i, n = OutfitDisplayFrame_GetItemInfo(bag, slot);
	    if ( i ) then
	       contents[i] = {};
	       contents[i].bag = bag;
	       contents[i].slot = slot;
	       contents[i].color = c;
	       contents[i].name = n;
	    else
	       local what = {};
	       what.bag = bag;
	       what.slot = slot;
	       tinsert(empties, what);
	    end
	 end
      end
   end

   for idx=1,19,1 do
      local slot = PlayerSlotNames[idx].id;
      local c, i, n = OutfitDisplayFrame_GetItemInfo(nil, slot);
      if ( i ) then
	 contents[i] = {};
	 contents[i].slot = slot;
	 contents[i].color = c;
	 contents[i].name = n;
      end
   end

   return contents, empties;
end

-- look in a particular bag
local function CheckThisBag(bag, id, skipcount)
   -- get the number of slots in the bag (0 if no bag)
   local numSlots = GetContainerNumSlots(bag);
   if (numSlots > 0) then
      -- check each slot in the bag
      for slot=1, numSlots do
	 local c, i, n = OutfitDisplayFrame_GetItemInfo(bag, slot);
	 if ( i and id == i ) then
	    if ( skipcount == 0 ) then
	       return slot, skipcount;
	    end
	    skipcount = skipcount - 1;
	 end
      end
   end
   return nil, skipcount;
end

-- look for the outfit anywhere we can find it
local function FindThisItem(id, skipcount)
   if ( not id ) then
      return nil,nil,nil;
   end
   local skipcount = skipcount or 0;
   -- check each of the bags on the player
   for bag=0, NUM_BAG_FRAMES do
      local slot;
      slot, skipcount = CheckThisBag(bag, id, skipcount);
      if ( slot ) then
	 return bag, slot, false;
      end
   end

   for idx=1,19,1 do
      local slot = PlayerSlotNames[idx].id;
      local c, i, n = OutfitDisplayFrame_GetItemInfo(nil, slot);
      if ( (id and i and id == i) or (name and n and name == n) ) then
	 if ( skipcount == 0 ) then
	    return nil, slot, false;
	 end
	 skipcount = skipcount - 1;
      end
   end

   -- look in the bank
   -- Geez, this is ugly
   local bankbags = { BANK_CONTAINER, 5, 6, 7, 8, 9, 10 };
   for b=1,7 do
      local slot;
      slot, skipcount = CheckThisBag(bankbags[b], id, skipcount);
      if ( slot ) then
	 return bankbags[b], slot, true;
      end
   end
   -- return nil, nil, nil;
end

-- look for the outfit anywhere we can find it
-- we should look in the bank someday
function OutfitDisplayFrame_FindOutfit(outfit)
   -- look for every item, if we find everything return a table of locations
   -- otherwise don't return anything
   if ( not outfit ) then
      return nil;
   end
   local spots = { };
   for slotName in outfit do
      if ( outfit[slotName].use and not outfit[slotName].empty ) then
	 local bag, slot = FindThisItem( outfit[slotName].item );
	 if ( not bag and not slot ) then
	    spots = nil;
	    return nil;
	 else
	    spots[slotName] = { };
	    spots[slotName].bag = bag;
	    spots[slotName].slot = slot;
	 end
      end
   end
   return spots;
end

function OutfitDisplayFrame_CanFindOutfit(outfit)
   if ( not outfit ) then
      return false;
   end
   for slotName in outfit do
      if ( outfit[slotName].used and not outfit[slotName].empty ) then
	 local bag, slot = FindThisItem( outfit[slotName].item );
	 if ( not bag and not slot ) then
	    return false;
	 end
      end
   end
   return true;
end

local function CheckSwitchWillFail(frame, outfit)
   local contents, empties = OutfitDisplayFrame_GetBagInfo();
   local numfree = table.getn(empties);
   local needfree = 0;
   local missing = false;
   local banked = false;
   for i=1,19,1 do
      local slotName = PlayerSlotNames[i].name;
      local check;
      if ( outfit ) then
	 check = outfit[slotName];
      else
	 check = getglobal(frame:GetName()..slotName);
      end
      if ( check and check.used ) then
	 if ( not check.empty ) then
	    local bag, slot, inbank = FindThisItem( check.item );
	    if ( not bag and not slot ) then
	       -- pretend it's still in the bank and we just can't get it
	       if ( check.banked ) then
		  check.banked = true;
		  banked = true;
	       else
		  missing = true;
	       end
	       check.missing = not check.banked;
	    else
	       check.missing = nil;
	       check.banked = inbank;
	    end
	 else
	    local slot = PlayerSlotNames[i].id;
	    if ( OutfitDisplayFrame_GetItemInfo(nil, slot) ) then
	       needfree = needfree + 1;
	    end
	 end
      end
   end
   if ( missing ) then
      return OUTFITDISPLAYFRAME_ITEMSNOTFOUND;
   end
   if ( banked and not BankIsOpen ) then
      return OUTFITDISPLAYFRAME_ITEMSINBANK;
   end
   if ( needfree > numfree ) then
      return OUTFITDISPLAYFRAME_NOTENOUGHFREESPACE;
   end
   return nil;
end

function OutfitDisplayFrame_SwitchWillFail(frame, outfit)
   if ( not outfit ) then
      return OUTFITDISPLAYFRAME_INVALIDOUTFIT;
   end
   -- if we're swapping, fail early
   if ( OutfitDisplayFrame_IsSwapping() ) then
      return OUTFITDISPLAYFRAME_TOOFASTMSG;
   end
   return CheckSwitchWillFail(frame, outfit);
end

function OutfitDisplayFrame_IsWearing(outfit)
   if ( not outfit ) then
      return false;
   end
   for slotName in outfit do
      if ( outfit[slotName].used and not outfit[slotName].empty ) then
         local slot = GetInventorySlotInfo(slotName);
         local link = GetInventoryItemLink("player", slot);
         local foundit = false;
	 if ( link ) then
	    local color, item, name = SplitLink(link);
	    if ( item == outfit[slotName].item ) then
	       foundit = true;
	    end
	 end
	 if ( not foundit ) then
	    return false;
	 end
      end
   end
   return true;
end

function OutfitDisplayFrame_UpdateMessage(frame, outfit)
   if ( frame and outfit ) then
      local msg = CheckSwitchWillFail(frame, outfit);
      local messages = getglobal(frame:GetName().."Message");
      if ( msg ) then
	 messages:Show();
	 messages:SetText(msg);
	 messages:SetTextColor(1, 1, 1);
      else
	 messages:SetText("");
	 messages:Hide();
      end
   end
end

function OutfitDisplayFrame_GetSlotContents(slotName, returnEmpty)
   if ( slotName ~= "Options" ) then
      local slot = GetInventorySlotInfo(slotName);
      local link = GetInventoryItemLink("player", slot);
      if ( link ) then
	 local contents = {};
	 local color, item, name = SplitLink(link);
	 contents.item = item;
	 contents.name = name;
	 contents.color = color;
	 contents.texture = texture;
	 contents.used = true;
	 local bag, slot = FindThisItem( item );
	 contents.bag = bag;
	 contents.slot = slot;
	 return contents;
      end
   end
   -- return nil;
end

function OutfitDisplayFrame_GetWearing(check)
   local wearing = {};
   if ( check ) then
      for slotName in check do
	 wearing[slotName] = OutfitDisplayFrame_GetSlotContents(slotName);
      end
      -- make sure we pick up the off hand if we're going to put something
      -- two-handed in the main hand slot
      local mainhand = check["MainHandSlot"];
      local offhand = wearing["SecondaryHandSlot"];
      if ( not offhand and mainhand and not IsItemOneHanded(mainhand.item) ) then
	 wearing["SecondaryHandSlot"] = OutfitDisplayFrame_GetSlotContents("SecondaryHandSlot");
      end
   else
      for i=1,19,1 do
	 local slotName = PlayerSlotNames[i].name;
	 wearing[slotName] = OutfitDisplayFrame_GetSlotContents(slotName);
      end
   end
   if ( not ShowingCloak() or not ShowingHelm() ) then
      wearing["Options"] = {}
      wearing["Options"].cloak = not(not ShowingCloak());
      wearing["Options"].helm = not(not ShowingHelm());
   end
   return wearing;
end

function OutfitDisplayFrame_FindLastEmptyBagSlot(skipcount, bag_affinity, slot_affinity)
   skipcount = skipcount or 0;

   -- try to put the item in the requested affinity, if possible
   if bag_affinity and slot_affinity and 
      not GetContainerItemInfo(bag_affinity, slot_affinity) then
      return bag_affinity, slot_affinity;
   end

   -- if we couldn't get the bag and slot we wanted, just try the same bag
   if bag_affinity then
      for j=GetContainerNumSlots(bag_affinity),1,-1 do
	 if not GetContainerItemInfo(bag_affinity,j) then
	    if skipcount == 0 then return bag_affinity,j; end
	    skipcount = skipcount - 1;
	 end
      end
   end

   -- no affinity, check all bags
   for i=NUM_BAG_FRAMES,0,-1 do
      -- but skip any bag we already have affinity for (because it might have 
      -- already modified skipcount)
      if bag_affinity ~= i then
	 -- Make sure this isn't a quiver, those won't hold shit
	 local bagName = GetBagName(i);
	 if ( bagName ) then
	    local texture = GetInventoryItemTexture("player",
						    ContainerIDToInventoryID(i));
	    
	    if ( string.find(texture, "INV_Misc_Bag_%d") and not string.find(bagName, AMMOSLOT) ) then
	       for j=GetContainerNumSlots(i),1,-1 do
		  if not GetContainerItemInfo(i,j) then
		     if skipcount == 0 then return i,j; end
		     skipcount = skipcount - 1;
		  end  -- if empty
	       end  -- for slots
	    end  -- if normal bag
	 end -- if there is a bag
      end -- if not affinity bag
   end  -- for bags

   -- not found return nil,nil implicitly
end

-- okay, let's switch to the specified outfit
-- code liberally borrowed from "WeaponQuickSwap - by CapnBry"

-- list functions
local function swapentry_print(entry)
   if ( DEFAULT_CHAT_FRAME ) then
      local msg = "Entry "..tonil(entry.sb)..","..tonil(entry.si)..","..tonil(entry.db)..","..tonil(entry.di);
      DEFAULT_CHAT_FRAME:AddMessage(msg, 1.0,0,0);
   end      
end

local function swaplist_print(list)
   while ( list ) do
      swapentry_print(list);
      list = list.next;
   end
end

local function swaplist_push(list, sb, si, db, di, helm, cloak)
   list = { next = list, sb = sb, si = si, db = db, di = di,
      helm = helm, cloak = cloak };
   return list;
end

local function swaplist_popfirst(list)
   if not list then return; end
   list = list.next;
   return list;
end

-- Unit variable to hold the stack of swaps
local outfitswap = nil;

function OutfitDisplayFrame_IsSwapping()
   if ( outfitswap or OutfitDisplayFrame_AnyItemLocked() ) then
      return true;
   else
      return false;
   end
end

-- First we do everything except the main hand and secondary hand
-- Then we do the hard stuff

function OutfitDisplayFrame_ItemIsLocked(bag, slot)
   if not bag and not slot then
      return false;
   end

   if not bag then
      return IsInventoryItemLocked(slot);
   else
      local _,_,locked = GetContainerItemInfo(bag,slot);
      return locked;
   end
end

function OutfitDisplayFrame_AnyItemLocked()
-- Checks all the bags and the equipped slots to see if any are still locked
   for i=0,NUM_BAG_FRAMES do
      for j=1,GetContainerNumSlots(i) do
	 local _,_,locked = GetContainerItemInfo(i,j);
	 if ( locked ) then
	    return true;
	 end
      end
   end
   for i=1,19,1 do
      if ( IsInventoryItemLocked(PlayerSlotNames[i].id) ) then
	 return true;
      end
   end
   return false;
end

function OutfitDisplayFrame_ExecuteSwapIteration()
   if not outfitswap then
      PerformSlowerSwap = false;
      return;
   end

   if OutfitDisplayFrame_ItemIsLocked(outfitswap.sb, outfitswap.si) or
      OutfitDisplayFrame_ItemIsLocked(outfitswap.db, outfitswap.di) then
      return;
   end

   if not outfitswap.sb then
      SavedPickupInventoryItem(outfitswap.si);
   else
      SavedPickupContainerItem(outfitswap.sb, outfitswap.si);
   end

   if not outfitswap.db then
      if not outfitswap.di then
	 PutItemInBackpack();
      else
	 SavedPickupInventoryItem(outfitswap.di);
      end
   else
      SavedPickupContainerItem(outfitswap.db, outfitswap.di);
   end

   if ( outfitswap.cloak ~= nil ) then
      ShowCloak(outfitswap.cloak);
   elseif ( outfitswap.helm ~= nil ) then
      ShowHelm(outfitswap.helm);
   end

   outfitswap = swaplist_popfirst(outfitswap);
   if ( outfitswap and not PerformSlowerSwap ) then
      return OutfitDisplayFrame_ExecuteSwapIteration();
   end
end

function OutfitDisplayFrame_SwitchOne(outfit, index, skipcount, showhelm, showcloak)
   local slotName = PlayerSlotNames[index].name;
   if ( outfit and outfit[slotName] ) then
      local invslot = GetInventorySlotInfo(slotName);
      if ( outfit[slotName].empty ) then
	 local bag, slot = OutfitDisplayFrame_FindLastEmptyBagSlot(skipcount);
	 outfitswap = swaplist_push(outfitswap, nil, invslot, bag, slot);
	 skipcount = skipcount + 1;
      else
	 local helmflag, cloakflag;
	 if ( slotName == "HeadSlot" ) then
	    helmflag = showhelm;
	 elseif ( slotName == "BackSlot" ) then
	    cloakflag = showcloak;
	 end
	 local bag, slot = FindThisItem( outfit[slotName].item );
	 -- either we couldn't find it, or it's where it should be
	 if ( bag ~= nil or slot ~= invslot ) then
	    outfitswap = swaplist_push(outfitswap, bag, slot, nil, invslot, helmflag, cloakflag);
	 end
      end
   end
   return skipcount;
end

local function OnSwapError(error)
   outfitswap = nil;
   if ( UIErrorsFrame ) then
      UIErrorsFrame:AddMessage(error, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
   end
   return;
end

function OutfitDisplayFrame_SwitchOutfit(outfit)
   if ( CursorHasItem() or OutfitDisplayFrame_IsSwapping() ) then
      return OnSwapError(OUTFITDISPLAYFRAME_TOOFASTMSG); 
   end
   if ( not outfit ) then
      return OnSwapError(OUTFITDISPLAYFRAME_INVALIDOUTFIT);
   end

   -- might not need to swap slowly
   PerformSlowerSwap = false;

   -- need to check to see that we have enough room
   local old = OutfitDisplayFrame_GetWearing(outfit);

   local showcloak;
   local showhelm;
   if ( outfit["Options"] ) then
      showhelm = outfit["Options"].helm;
      showcloak = outfit["Options"].cloak;
   end

   -- do everything except weapon slots
   local skipcount = 0;
   for i=1,16,1 do
      skipcount = OutfitDisplayFrame_SwitchOne(outfit, i, skipcount, showhelm, showcloak);
   end
   OutfitDisplayFrame_SwitchOne(outfit, 19, skipcount);

   if ( not outfit["MainHandSlot"] and not outfit["SecondaryHandSlot"] ) then
      OutfitDisplayFrame_ExecuteSwapIteration(); 
      return old;
   end

   local mainhandslot = GetInventorySlotInfo("MainHandSlot");
   local secondaryslot = GetInventorySlotInfo("SecondaryHandSlot");
   local mainhand = outfit["MainHandSlot"];
   local offhand = outfit["SecondaryHandSlot"];
   -- now do hands
   local m_sb;
   local m_si;
   local o_sb;
   local o_si;
   local m_ok = not mainhand or not mainhand.item;
   local o_ok = not offhand or not offhand.item;

   if ( mainhand and mainhand.item ) then
      m_sb, m_si = FindThisItem(mainhand.item);
      m_ok = ( not m_sb and m_si == mainhandslot );
   end
   if ( offhand and offhand.item ) then
      local multiples = 0;
      if ( mainhand and mainhand.item == offhand.item ) then
	 multiples = 1;
      end
      o_sb, o_si = FindThisItem( offhand.item, multiples);
      o_ok = ( not o_sb and o_si == secondaryslot );
   end

   if ( not m_ok ) then
      -- do we need two of these?
      if ( o_ok and not m_sb and m_si == secondaryslot ) then
	 m_sb, m_si = FindThisItem( mainhand.item, 1);
      end
   end

   -- moving from bags
   if ( m_sb and o_sb ) then
      -- insert them backwards, since they get popped off
      -- main hand has to get done first in case it's currently
      -- a two hander
      outfitswap = swaplist_push(outfitswap, o_sb, o_si, nil, secondaryslot);
      outfitswap = swaplist_push(outfitswap, m_sb, m_si, nil, mainhandslot);
   elseif ( not m_sb and m_si == secondaryslot and not o_sb and o_si == mainhandslot ) then
      outfitswap = swaplist_push(outfitswap, nil, mainhandslot, nil, secondaryslot);
   else
      -- Install main hand
      if not m_ok then
	 -- if nothing going to the main hand
	 if ( not m_sb and not m_si ) then
	    -- and the main is not going to the off: put it in a bag
	    if not ( not o_sb and o_si == mainhandslot) then
	       local bb, bi = OutfitDisplayFrame_FindLastEmptyBagSlot(skipcount);
	       if not (bb and bi) then 
		  return OnSwapError(OUTFITDISPLAYFRAME_NOTENOUGHFREESPACE); 
	       end
	       skipcount = skipcount + 1;
	       outfitswap = swaplist_push(outfitswap, nil, mainhandslot, bb, bi);
	       -- when moving A,"" -> "",B where A is a 2h, the offhand
	       -- doesn't lock properly, so work around it by swapping
	       -- slowly (only one swap per lock notify)
	       PerformSlowerSwap = not IsItemOneHanded(mainhand.item);
	    end
	 else
	    outfitswap = swaplist_push(outfitswap, m_sb, m_si, nil, mainhandslot);
	 end
      end
  
      -- Load offhand if not already there
      if not o_ok then
	 if ( not o_sb and not o_si ) then
	    if not (not m_sb and m_si == secondaryslot) then
	       local bb, bi;
	       if LastOffSource then
		  bb, bi = OutfitDisplayFrame_FindLastEmptyBagSlot(skipcount, 
								   LastOffSource.bag, LastOffSource.slot);
	       else
		  bb, bi = OutfitDisplayFrame_FindLastEmptyBagSlot(skipcount);
	       end
	       
	       if not (bb and bi) then 
		  return OnSwapError(OUTFITDISPLAYFRAME_NOTENOUGHFREESPACE); 
	       end
	       skipcount = skipcount + 1;
	       outfitswap = swaplist_push(outfitswap, nil, secondaryslot, bb, bi);
	    end
	 else
	    -- if the main hand weapon is coming from the offhand slot
	    -- we need to fix up its source to be where the offhand is 
	    -- GOING to be after the bag->off swap
	    if outfitswap and ( not m_sb and m_si == secondaryslot) then
	       outfitswap.sb = o_sb;
	       outfitswap.si = o_si;
	       -- don't set o_sb, o_si they're tested later
	    end
	    
	    outfitswap = swaplist_push(outfitswap, o_sb, o_si, nil, secondaryslot);
	 end
      end

-- Special Case: Moving off to main, and not main to off
-- This is because maybe the main hand weapon is main only
      if (not m_sb and m_si == secondaryslot) and not ( not o_sb and o_si == mainhandslot) then
	 local bb, bi = OutfitDisplayFrame_FindLastEmptyBagSlot(skipcount);
	 if not (bb and bi) then 
	    return OnSwapError(OUTFITDISPLAYFRAME_NOTENOUGHFREESPACE); 
	 end
	 skipcount = skipcount + 1;
	 outfitswap = swaplist_push(outfitswap, nil, mainhandslot, bb, bi);
      end

      -- Same thing for off hand
      if (not o_sb and o_si == mainhandslot) and not (not m_sb and m_si == secondaryslot) then
	 local bb, bi = OutfitDisplayFrame_FindLastEmptyBagSlot(skipcount);
	 if not (bb and bi) then 
	    return OnSwapError(OUTFITDISPLAYFRAME_NOTENOUGHFREESPACE); 
	 end
	 skipcount = skipcount + 1;
	 outfitswap = swaplist_push(outfitswap, nil, mainhandslot, bb, bi);
      end

      if o_sb then 
	 LastOffSource = { bag = o_sb, slot = o_si }; 
      end
   end   
   -- Start moving
   OutfitDisplayFrame_ExecuteSwapIteration(); 
   return old;
end
