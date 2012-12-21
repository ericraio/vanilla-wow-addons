-- Auto-attack support

-- Thanks to FeralSkills for the idea on how to do this
function lazyr.IsAutoAttacking()
   if (not lazyr.attackSlot) then
      for i = 1, 120 do
         if (IsAttackAction(i)) then
            lazyr.attackSlot = i
            break
         end
      end
   end
   if (not lazyr.attackSlot) then
      lazyr.p("Couldn't find Attack action on your action bar, PLEASE ADD IT.")
      return false
   end
   return (IsCurrentAction(lazyr.attackSlot) == 1)
end

function lazyr.StartAutoAttack()
   if (not lazyr.IsAutoAttacking()) then
      AttackTarget()
   end
end

function lazyr.StopAutoAttack()
   if (lazyr.IsAutoAttacking()) then
      AttackTarget()
   end
end


