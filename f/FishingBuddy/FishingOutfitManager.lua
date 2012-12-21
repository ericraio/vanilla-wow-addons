-- Manage outfits, whether they're from OutfitDisplayFrame or something else
FishingBuddy.OutfitManager = {};

-- Inferred from Draznar's Fishing FAQ
local Accessories = {
   [19979] = { ["n"] = "Hook of the Master Angler", ["score"] = 5, },
   [19947] = { ["n"] = "Nat Pagle's Broken Reel", ["score"] = 4, },
   [19972] = { ["n"] = "Lucky Fishing Hat", ["score"] = 5, },
   [7996] = { ["n"] = "Lucky Fishing Hat", ["score"] = 5, },
   [8749] = { ["n"] = "Crochet Hat", ["score"] = 3, },
   [19039] = { ["n"] = "Zorbin's Water Resistant Hat", ["score"] = 3, },
   [3889] = { ["n"] = "Russet Hat", ["score"] = 3, },
   [14584] = { ["n"] = "Dokebi Hat", ["score"] = 2, },
   [4048] = { ["n"] = "Emblazoned Hat", ["score"] = 1, },
   [10250] = { ["n"] = "Masters Hat of the Whale", ["score"] = 1, },
   [9508] = { ["n"] = "Mechbuilder's Overalls", ["score"] = 3, },
   [6263] = { ["n"] = "Blue Overalls", ["score"] = 4, },
   [3342] = { ["n"] = "Captain Sander's Shirt", ["score"] = 4, },
   [5107] = { ["n"] = "Deckhand's Shirt", ["score"] = 2, },
   [6795] = { ["n"] = "White Swashbuckler's Shirt", ["score"] = 1, },
   [2576] = { ["n"] = "White Linen Shirt", ["score"] = 1, },
   [6202] = { ["n"] = "Fingerless Gloves", ["score"] = 3, },
   [792] = { ["n"] = "Knitted Sandals", ["score"] = 4, },
   [1560] = { ["n"] = "Bluegill Sandals", ["score"] = 4, },
   [13402] = { ["n"] = "Timmy's Galoshes", ["score"] = 2, },
   [10658] = { ["n"] = "Quagmire Galoshes", ["score"] = 2, },
   [1678] = { ["n"] = "Black Ogre Kickers", ["score"] = 1, },
   [19969] = { ["n"] = "Nat Pagle's Extreme Anglin' Boots", ["score"] = 5, },
   [15405] = { ["n"] = "Shucking Gloves", ["score"] = 5, },
   [15406] = { ["n"] = "Crustacean Boots", ["score"] = 3, },
   [3287] = { ["n"] = "Tribal Pants", ["score"] = 2, },
   [5310] = { ["n"] = "Sea Dog Britches", ["score"] = 4, },
}

FishingBuddy.OutfitManager.ItemStylePoints = function(itemno, enchant)
   local points = 0;
   if ( itemno ) then
      itemono = tonumber(itemno);
      enchant = tonumber(enchant);
      if (Accessories[itemno]) then
	 points = points + Accessories[itemno].score;
      end
      if ( enchant == 846 ) then
         -- bonus for being enchanted with Fishing +2
         points = points + 2;
      end
   end
   return points;
end

local CheckSwitch = nil;

-- update the watcher when we're done switching outfits
FishingBuddy.OutfitManager.WaitForUpdate =
   function(arg1)
      local hasPole = FishingBuddy.IsFishingPole();
      if ( hasPole == CheckSwitch ) then
	 FishingOutfitUpdateFrame:Hide();
	 FishingBuddy.FishingMode();
      end
   end

FishingBuddy.OutfitManager.CheckSwitch = function(topole)
   CheckSwitch = topole;
   FishingOutfitUpdateFrame:Show();
end

FishingBuddy.OutfitManager.Switch = function(outfitname)
   if ( OutfitDisplayFrame_OnLoad ) then
      FishingBuddy.OutfitFrame.Switch();
   else
      local vOut, vCat, vInd = Outfitter_FindOutfitByStatId(Outfitter_cFishingStatName);
      if ( vOut ) then
	 if ( FishingBuddy.IsFishingPole() ) then
	    Outfitter_RemoveOutfit(vOut);
	    FishingBuddy.OutfitManager.CheckSwitch(false);
	 else
	    vOut.Disabled = nil;
	    Outfitter_WearOutfit(vOut, vCat);
	    FishingBuddy.OutfitManager.CheckSwitch(true);
	 end
	 Outfitter_Update(true);
      end
   end
   -- if we're now sporting a fishing pole, let's go fishing
   FishingBuddy.FishingMode();
end

FishingBuddy.OutfitManager.HasManager = function()
   return ( OutfitDisplayFrame_OnLoad or Outfitter_OnLoad );
end

FishingBuddy.OutfitManager.Initialize = function()
   -- no outfit managers, no outfit switching
   if ( not FishingBuddy.OutfitManager.HasManager() ) then
      FishingBuddy.SetSetting("InfoBarClickToSwitch", 0);
      FishingBuddy.SetSetting("TitanClickToSwitch", 0);
      FishingBuddy.SetSetting("MinimapClickToSwitch", 0);
   end
   if ( (not OutfitDisplayFrame_OnLoad) and Outfitter_OnLoad ) then
      -- create the default fishing outfit, if it doesn't exist
      if ( gOutfitter_Settings ) then
	 local vOut, vCat, vInd = Outfitter_FindOutfitByStatId(Outfitter_cFishingStatName);
	 local vName = "Fishing Buddy";
	 if ( not vOut ) then
	    vOut = Outfitter_GenerateSmartOutfit(vName, Outfitter_cFishingStatName, OutfitterItemList_GetEquippableItems(true));
	    if not vOut then
	       vOut = Outfitter_NewEmptyOutfit(vName);
	    end
	    
	    local vCategoryID = Outfitter_AddOutfit(vOut);
	 end
      end
   end
end

-- calculate scores based on Outfitter
local function StylePoints(outfit)
   local isp = FishingBuddy.OutfitManager.ItemStylePoints;
   local points = 0;
   if ( outfit )then
      for slot in outfit.Items do
	 points = points + isp(outfit.Items[slot].Code,
			       outfit.Items[slot].EnchantCode);
      end
   end
   return points;
end

local function BonusPoints(outfit, vStatID)
   local points = 0;
   if ( outfit )then
      for slot in outfit.Items do
	 if ( outfit.Items[slot][vStatID] ) then
	    points = points + outfit.Items[slot][vStatID];
	 end
	 -- Enternium Fishing Line
	 if ( outfit.Items[slot].EnchantCode == 2603 ) then
	    points = points + 5;
	 end
      end
   end
   return points;
end

-- Outfitter patches

function Outfitter_FindOutfitByStatId(pStatID)
   if not pStatID or pStatID == "" then
      return nil;
   end

   for vCategoryID, vOutfits in gOutfitter_Settings.Outfits do
      for vOutfitIndex, vOutfit in vOutfits do
	 if vOutfit.StatID and vOutfit.StatID == pStatID then
	    return vOutfit, vCategoryID, vOutfitIndex;
	 end
      end
   end

   -- return nil, nil, nil;
end

local Saved_OutfitterItem_OnEnter = OutfitterItem_OnEnter;
FishingBuddy.OutfitManager.OutfitterItem_OnEnter = function(pItem)
   Saved_OutfitterItem_OnEnter(pItem);
   if ( not pItem.isCategoryItem ) then
      local vOutfit = Outfitter_GetOutfitFromListItem(pItem);
      if ( vOutfit and vOutfit.StatID == Outfitter_cFishingStatName ) then
	 local vDescription;
	 local bp = BonusPoints(vOutfit, Outfitter_cFishingStatName);
	 if ( bp >= 0 ) then
	    bp = "+"..bp;
	 else
	    bp = 0 - bp;
	    bp = "-"..bp;
	 end
	 bp = Outfitter_cFishingStatName.." "..bp;
	 local sp = StylePoints(vOutfit);
	 local pstring;
	 if ( points == 1 ) then
	    pstring = FishingBuddy.POINT;
	 else
	    pstring = FishingBuddy.POINTS;
	 end
	 vDescription = string.format(FishingBuddy.CONFIG_OUTFITTER_TEXT,
				      bp, sp)..pstring;
	 GameTooltip_AddNewbieTip(vOutfit.Name, 1.0, 1.0, 1.0, vDescription, 1);
      end
   end
end
OutfitterItem_OnEnter = FishingBuddy.OutfitManager.OutfitterItem_OnEnter;
