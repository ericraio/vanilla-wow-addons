-- Support for Fishing Holes

FishingBuddy.FishingHoles = {};

-- Let's store fishing holes like this
-- FishingBuddy_Info["FishingHoles"][ZONE]
-- Store everything to two digits?

local function IsFishingHole()
   if ( GameTooltip:IsVisible() ) then
      local text = getglobal("GameTooltipTextLeft1");
      if ( text ) then
         text = text:GetText();
         -- let a partial match work (for translations)
         if ( string.find(text, FishingBuddy.SCHOOL_OF) ) then
            local s,e = string.find(text, FishingBuddy.SCHOOL_OF.." ");
            if ( s ) then
               if ( s > 1 ) then
                  text = string.sub(text, 1, s-1)..string.sub(fishie, e+1);
               else
                  text = string.sub(text, e+1);
               end
            else
               s,e = string.find(text, " "..FishingBuddy.SCHOOL_OF);
               if ( s ) then
                  text = string.sub(text, 1, s-1)..string.sub(text, e+1);
               end
            end
            return text;
         end
      end
   end
   return nil;
end

FishingBuddy.FishingHoles.CheckFishingHole = function()
   local holename = IsFishingHole();
   if ( holename ) then
      -- find the name of the fish in our database if we can
      -- if not, we can find it later, when we catch one
      -- need translations for the other kinds of fishing holes
   end
end
