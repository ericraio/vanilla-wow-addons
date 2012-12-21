--[[
  WeaponQuickSwap - by CapnBry
  A script for moving weapons by name between hands, taking slot locking into account.
  
  Public Domain.  Feel free to use any of this code or ideas in your own mods
--]]

-- Unit variable to hold the stack of weapon swaps
local wswap = nil;
local WeaponSwap_IsSwapping = nil;
local WeaponSwap_IsInSwapIteration = nil;

--
-- "Exported" functions for the user
--
function MageWeaponSwap(...)
	-- insert them backwards!  off, main like a stack
  table.insert(arg, 1, 18);
  table.insert(arg, 1, 16);
	return WeaponQuickSwap_WeaponSwapCommon(arg);  
end

function WeaponSwap(...)
	-- insert them backwards!  off, main like a stack
	table.insert(arg, 1, 17);
  table.insert(arg, 1, 16);
	return WeaponQuickSwap_WeaponSwapCommon(arg);  	
end

function WeaponSwap_Reset()
	wswap = nil;
	WeaponSwap_IsSwapping = nil;
	WeaponSwap_IsInSwapIteration = nil;
end

--
-- Internal functions and callbacks
--
function WeaponQuickSwap_OnLoad()
	if not Print then Print = function (x)
    ChatFrame1:AddMessage(x, 1.0, 1.0, 1.0);
  	end
  end

	if not WeaponSetsExchange then WeaponSetsExchange = WeaponSwap; end;
	
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
  this:RegisterEvent("PLAYER_LEAVING_WORLD");
end

function WeaponQuickSwap_OnEvent(...)
  if arg[1] == "ITEM_LOCK_CHANGED" and not arg[2] then
		return WeaponQuickSwap_ExecuteSwapIteration();  	
  end
  if arg[1] == "PLAYER_ENTERING_WORLD" then
  	return WeaponSwap_RegisterEvents();
	end
  if arg[1] == "PLAYER_LEAVING_WORLD" then
  	return WeaponSwap_UnregisterEvents();
	end
end

local function swaplist_push(list, sb, si, db, di)
  list = { next = list, sb = sb, si = si, db = db, di = di };
  return list;
end

local function swaplist_popfirst(list)
  if not list then return; end

  list = list.next;
  return list;
end

function WeaponSwap_RegisterEvents()
  WeaponQuickSwapFrame:RegisterEvent("ITEM_LOCK_CHANGED");
	--this:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
  --this:RegisterEvent("BAG_UPDATE");
  --this:RegisterEvent("UNIT_INVENTORY_CHANGED");
  --this:RegisterEvent("UNIT_MODEL_CHANGED");
end

function WeaponSwap_UnregisterEvents()
  WeaponQuickSwapFrame:UnregisterEvent("ITEM_LOCK_CHANGED");
end

function WeaponQuickSwap_ItemIsLocked(bag,slot)
	if bag == -1 and slot == -1 then return nil; end

	if bag == -1 then
    return IsInventoryItemLocked(slot);
  else
  	local _,_,retval = GetContainerItemInfo(bag,slot);
  	return retval;
  end
end

function WeaponQuickSwap_AnyItemLocked()
	-- Checks all the bags and the 3 equip slots to see if any slot is still locked
  for i=0,NUM_BAG_FRAMES do
    for j=1,GetContainerNumSlots(i) do
	  	local _,_,retVal = GetContainerItemInfo(i,j);
	  	if retVal then
	  		return retVal;
	  	end
	  end
  end

	return IsInventoryItemLocked(16) or IsInventoryItemLocked(17) or IsInventoryItemLocked(18);
end

function WeaponQuickSwap_ExecuteSwapIteration()
	-- I would love to critical section this code:
	--   It is called from the ITEM_LOCK_CHANGED notify, but calling Pickup*Item() 
	--   creates a notify, so we can get a stack overflow
	if WeaponSwap_IsInSwapIteration then return; end
	WeaponSwap_IsInSwapIteration = 1;
	
  if not wswap then 
  	if WeaponSwap_IsSwapping and not WeaponQuickSwap_AnyItemLocked() then
			WeaponSwap_IsInSwapIteration = nil;
  		return WeaponQuickSwap_OnSwapComplete();
  	end

		WeaponSwap_IsInSwapIteration = nil;
  	return;
	end

  -- As of 1.10 it seems that sometimes just checking the source and destination
  -- isn't enough, and we can't move an item if /anything/ is locked
	--if WeaponQuickSwap_ItemIsLocked(wswap.sb, wswap.si) or
  --	WeaponQuickSwap_ItemIsLocked(wswap.db, wswap.di) then
	if WeaponQuickSwap_AnyItemLocked() then
		WeaponSwap_IsInSwapIteration = nil;
		return;
	end

	if wswap.sb == -1 then
  	PickupInventoryItem(wswap.si);
  else
  	PickupContainerItem(wswap.sb, wswap.si);
	end

  if wswap.db == -1 then
    if wswap.di == -1 then
    	PutItemInBackpack();
    else
	  	PickupInventoryItem(wswap.di);
    end
  else
  	PickupContainerItem(wswap.db, wswap.di);
  end

  wswap = swaplist_popfirst(wswap);
  if wswap and not WeaponQuickSwap_PerformSlowerSwap then
		WeaponSwap_IsInSwapIteration = nil;
  	return WeaponQuickSwap_ExecuteSwapIteration();
  end
	
	WeaponSwap_IsInSwapIteration = nil;
end

function WeaponQuickSwap_OnSwapComplete()
	-- this is just here to allow people to hook the completion event

	-- DebugStop
	-- Print("Swap is complete");
	return WeaponSwap_Reset();
end

function WeaponQuickSwap_OnSwapError(error)
	-- this is just here to allow people to hook the completion event
	Print(error);

	return WeaponSwap_Reset();
end

function WeaponQuickSwap_GetItemName(bag, slot)
  local linktext = nil;
  
  if (bag == -1) then
  	linktext = GetInventoryItemLink("player", slot);
  else
  	linktext = GetContainerItemLink(bag, slot);
  end

  if linktext then
    -- local _,_,name = string.find(linktext, "(%b[])");
    local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
    return name;
  else
    return "";
  end
end

function WeaponQuickSwap_FindItem(name, skipcount)
	skipcount = skipcount or 0;
	
	-- First check the inventory slots 16, 17 and 18
  for i= 16,18,1 do
    if (WeaponQuickSwap_GetItemName(-1,i) == name) then 
    	if skipcount == 0 then return -1,i; end
    	skipcount = skipcount - 1;
    end
  end

  -- not found check bags
  for i=NUM_BAG_FRAMES,0,-1 do
    for j=GetContainerNumSlots(i),1,-1 do
	    if (WeaponQuickSwap_GetItemName(i,j) == name) then 
	    	if skipcount == 0 then return i,j; end
	    	skipcount = skipcount - 1;
	    end
    end
  end

  -- not found return nil,nil implicitly
end

function WeaponQuickSwap_FindLastEmptyBagSlot(skipcount, bag_affinity, slot_affinity)
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

	-- no affinity, chek all bags
  for i=NUM_BAG_FRAMES,0,-1 do
  	-- but skip any bag we already have affinity for (because it might have 
  	-- already modified skipcount 
  	if bag_affinity ~= i then
	   	-- Make sure this isn't a quiver, those won't hold shit
  	 	local bagName = GetBagName(i);
   		if bagName and not (
   			string.find(bagName, "Quiver") or 
   			string.find(bagName, "Ammo Pouch") or
   			string.find(bagName, "Shot Pouch")
   			) then
	    	for j=GetContainerNumSlots(i),1,-1 do
		    	if not GetContainerItemInfo(i,j) then
    	  		if skipcount == 0 then return i,j; end
      	  	skipcount = skipcount - 1;
      		end  -- if empty
    		end  -- for slots
    	end  -- if normal bag
    end -- if not affinity bag
  end  -- for bags

  -- not found return nil,nil implicitly
end

function WeaponQuickSwap_FindCurrentSetIndex(mainhandslot, offhandslot, startIndex, setsList)
	-- loop through the paramters and find what we have in our hands  
  local main, off;
  local argidx = startIndex;
  local retVal;
	while setsList[argidx] do
  	main, off = setsList[argidx], setsList[argidx+1];
  	
		if not main then break; end
		
	  -- don't need to specify the offhand if this is just a single deal
  	if not off then off = ""; end

  	--Print("Checking:"..main..","..off);
  	
		if WeaponQuickSwap_ItemNameMatches(-1, mainhandslot, main) and 
  		WeaponQuickSwap_ItemNameMatches(-1, offhandslot, off) then
  		-- DebugStop
  		--Print("Found currently equipped set idx:"..argidx);
  		retVal = argidx;
  		break;
  	end

  	argidx = argidx + 2;
  end
  
  return retVal;
end

function WeaponQuickSwap_ItemNameMatches(bag, slot, name)
	if name == "*" or WeaponQuickSwap_GetItemName(bag, slot) == name then 
		return true;
	end
	
	-- Support for Shadowstrike/Thunderstrike renaming weapons
	return nil;
end

function WeaponQuickSwap_WeaponSwapCommon(arg)
  -- I explicitly use arg as a parameter instead of ... to prevent
  -- having to call unpack on the arg list from the caller

	if WeaponSwap_IsSwapping then 
		if not (WeaponSwap_IsInSwapIteration or WeaponQuickSwap_AnyItemLocked()) then
			Print("IsSwapping == true, IsInIteration == false, no items locked");
		end
		
		-- DebugStop
		--Print("Bailing out, swap is in progress");
		return;
	end

	WeaponSwap_IsSwapping = 1;
	wswap = nil;
	WeaponQuickSwap_PerformSlowerSwap = nil;
	--if CursorHasItem() then ResetCursor() end

  local mainhandslot, offhandslot = arg[1], arg[2];
  local main, off;

	--Print("Hands are:"..mainhandslot..","..offhandslot);
  local matchingsetidx = WeaponQuickSwap_FindCurrentSetIndex(mainhandslot, offhandslot, 3, arg);
	
	-- if we found a match, and there is at least one weapon speficied in the next
	-- set, then use that set.  Else use the first 2
	if matchingsetidx and arg[matchingsetidx+2] then
  	main, off = arg[matchingsetidx+2], arg[matchingsetidx+3];
  else
  	main, off = arg[3], arg[4];
  end

	--Print("Picking:"..main..","..off);
  -- don't need to specify the offhand if this is just a single deal
  if not off then off = ""; end
  
  if not main then
  	return WeaponQuickSwap_OnSwapError("No weapons set found to switch.  Not enough arguments?");
  end
  
  -- see what's already set up
  local m_ok = WeaponQuickSwap_ItemNameMatches(-1, mainhandslot, main);
  local o_ok = WeaponQuickSwap_ItemNameMatches(-1, offhandslot, off);
  
  local m_sb, m_si = -1, mainhandslot;
  if not m_ok then 
  	if main == "" then
  		m_sb, m_si = -1, -1;
  	else
  		m_sb, m_si = WeaponQuickSwap_FindItem(main);
  		-- if FindItem returned the offhand weapon and it is already ok
  		-- don't remove it.  Look harder
  		if o_ok and m_sb == -1 and m_si == offhandslot then
  			m_sb, m_si = WeaponQuickSwap_FindItem(main, 1);
  		end
  	end
  	if not (m_sb and m_si) then
			return WeaponQuickSwap_OnSwapError("Can not find mainhand item: "..main);
  	end
  end -- if not m_ok

  local multiinst;
  -- if you're using 2 of the same weapon FindItem needs to 
  -- know not to just return the first
  if main == off then multiinst = 1; else multiinst = 0; end
  
  local o_sb, o_si = -1, offhandslot;
  if not o_ok then 
  	if off == "" then
    	o_sb, o_si = -1, -1;
  	else
  		o_sb, o_si = WeaponQuickSwap_FindItem(off, multiinst);
  		-- note that here we don't have to "look harder" because
  		-- that would mean that both weapons are the same so multinst
  		-- would already be set to 1
  	end
  	if not (o_sb and o_si) then
			return WeaponQuickSwap_OnSwapError("Can not find offhand item: "..off);
  	end
  end  -- if not o_ok

	-- Moving both hands from bags, that's easy
  if m_sb ~= -1 and o_sb ~= -1 then
  	-- Load main first because if it is a 2h and we try to load offhand
  	-- we get a "Cannot Equip that with a Two-handed weapon" error
  	PickupContainerItem(m_sb, m_si);
    PickupInventoryItem(mainhandslot);
  	PickupContainerItem(o_sb, o_si);
    PickupInventoryItem(offhandslot);
		WeaponQuickSwap_LastOffSource = { bag = o_sb, slot = o_si }; 
    return;
  end

  -- Simple hand swap
  if m_sb == -1 and m_si == offhandslot and o_sb == -1 and o_si == mainhandslot then
  	PickupInventoryItem(mainhandslot);
    PickupInventoryItem(offhandslot);
    return;
  end

  -- Push the list.  We want to:
  -- Take the mainhand weapon out if it isn't going to offhand
  -- Move from wherever to the offhand.  If offhand is supposed to be empty, empty it.
  -- Install the main hand weapon.  No blank main hand is supported unless are going to be.
  --
  -- Do it backward, the swaplist is a stack

  local skipcount = 0;
  
  -- Install main hand
  if not m_ok then
  	-- if nothing going to the main hand
    if (m_sb == -1 and m_si == -1) then
    	-- and the main is not going to the off: put it in a bag
    	if not (o_sb == -1 and o_si == mainhandslot) then
        local bb, bi = WeaponQuickSwap_FindLastEmptyBagSlot(skipcount);
        if not (bb and bi) then 
        	return WeaponQuickSwap_OnSwapError("Not enough empty bag slots to perform swap."); 
        end
        skipcount = skipcount + 1;
    		wswap = swaplist_push(wswap, -1, mainhandslot, bb, bi);
    		
    		-- when moving A,"" -> "",B where A is a 2h, the offhand doesn't lock properly
    		-- so work around it by swapping slowly (only one swap per lock notify)
    		WeaponQuickSwap_PerformSlowerSwap = true;
      end
    else
		  wswap = swaplist_push(wswap, m_sb, m_si, -1, mainhandslot);
    end
  end
  
  -- Load offhand if not already there
  if not o_ok then
    if (o_sb == -1 and o_si == -1) then
      if not (m_sb == -1 and m_si == offhandslot) then
   
        local bb, bi;
				if WeaponQuickSwap_LastOffSource then
        	bb, bi = WeaponQuickSwap_FindLastEmptyBagSlot(skipcount, 
        		WeaponQuickSwap_LastOffSource.bag, WeaponQuickSwap_LastOffSource.slot);
        else
        	bb, bi = WeaponQuickSwap_FindLastEmptyBagSlot(skipcount);
        end
        
        if not (bb and bi) then 
        	return WeaponQuickSwap_OnSwapError("Not enough empty bag slots to perform swap."); 
        end
        skipcount = skipcount + 1;
    		wswap = swaplist_push(wswap, -1, offhandslot, bb, bi);
      end
    else
      -- if the main hand weapon is coming from the offhand slot
      -- we need to fix up its source to be where the offhand is 
      -- GOING to be after the bag->off swap
    	if wswap and (m_sb == -1 and m_si == offhandslot) then
    		wswap.sb = o_sb;
    		wswap.si = o_si;
    		-- don't set o_sb, o_si they're tested later
    	end
    	
		  wswap = swaplist_push(wswap, o_sb, o_si, -1, offhandslot);
    end
  end
  
  -- Special Case: Moving off to main, and not main to off
  -- This is because maybe the main hand weapon is main only
  if (m_sb == -1 and m_si == offhandslot) and not (o_sb == -1 and o_si == mainhandslot) then
    local bb, bi = WeaponQuickSwap_FindLastEmptyBagSlot(skipcount);
    if not (bb and bi) then 
    	return WeaponQuickSwap_OnSwapError("Not enough empty bag slots to perform swap."); 
    end
    skipcount = skipcount + 1;
  	wswap = swaplist_push(wswap, -1, mainhandslot, bb, bi);
  end

  -- Same thing for off hand
  if (o_sb == -1 and o_si == mainhandslot) and not (m_sb == -1 and m_si == offhandslot) then
    local bb, bi = WeaponQuickSwap_FindLastEmptyBagSlot(skipcount);
    if not (bb and bi) then 
    	return WeaponQuickSwap_OnSwapError("Not enough empty bag slots to perform swap."); 
    end
    skipcount = skipcount + 1;
  	wswap = swaplist_push(wswap, -1, 17, bb, bi);
  end

	if o_sb ~= -1 then 
		WeaponQuickSwap_LastOffSource = { bag = o_sb, slot = o_si }; 
	end
	
	-- DebugStop
	--Print("Starting SwapIterations");
  -- Start moving
	return WeaponQuickSwap_ExecuteSwapIteration(); 
end
