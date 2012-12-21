--Immunity Code - Thanks to Astryl - http://www.curse-gaming.com/en/wow/addons-3321-1-feralskills.html
	
function lazyr.WatchForImmunes(text)
   if (lrLocale.IMMUNE) then
      if (not lrLocale.ImmunityProblemCreatures) then
         lazyr.d("Immune tracking is not 100% supported for your locale.")
      end
      for spell, creature in string.gfind(text, lrLocale.IMMUNE) do
         --Ignore non-targets (or at least, try, based on name), banished targets, 
         -- or known problematic targets (targets that have temporary immunities)		
         if (UnitName('target') ~= creature or lazyr.masks.HasBuffOrDebuff("target", "debuff", nil, "Cripple", nil)) then 
            return
         end
         for _, problemCreature in lrLocale.ImmunityProblemCreatures do 
            if string.find(creature, problemCreature) then 
               return 
            end 
         end
         if UnitIsPlayer("target") then
            return
         end
         lazyr.d("IMMUNITY DETECTED! Spell: "..spell.."      Creature: "..creature)
         if not lazyr.perPlayerConf.Immunities[spell] then
            lazyr.perPlayerConf.Immunities[spell] = {};
         end
         lazyr.perPlayerConf.Immunities[spell][creature] = true;
      end
   end
end

