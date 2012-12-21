-- Interrupt support

lazyr.interrupt = {}

lazyr.interrupt.targetCasting = nil
lazyr.interrupt.castingDetectedAt = 0
lazyr.interrupt.lastSpellInterrupted = nil


function lazyr.interrupt.OnChatMsgSpell(arg1)
   local tName = UnitName("target")
   if (tName) then
      for idx, pat in { lrLocale.SPELLCASTOTHERSTART, lrLocale.SPELLPERFORMOTHERSTART } do
         for mob, spell in string.gfind(arg1, pat) do
            if (mob == tName) then
               lazyr.d("Detected your target is casting "..spell..", will suggest Interrupt.")
               if (lazyr.perPlayerConf.showTargetCasts) then
                  lazyr.p(tName.." is casting "..spell..".")
               end
               lazyr.interrupt.targetCasting = spell
               lazyr.interrupt.castingDetectedAt = GetTime()
               return
            end
         end
      end
   end
end


-- Interrupt Criteria Edit Box

lazyr.iceb = {}

lazyr.iceb.cancelEdit = false

function lazyr.iceb.OnShow()
   local text = table.concat(lrConf.interruptExceptionCriteria, "\n")
   LazyRogueInterruptExceptionCriteriaEditFrameForm:SetText(text)
end

function lazyr.iceb.OnHide()
   if (lazyr.iceb.cancelEdit) then
      lazyr.iceb.cancelEdit = false
      return
   end

   local text = LazyRogueInterruptExceptionCriteriaEditFrameForm:GetText()

   local args = {}
   for arg in string.gfind(text, "[^\r\n]+") do
      table.insert(args, arg)
   end
   lrConf.interruptExceptionCriteria = args

   lazyr.p("Global interrupt criteria updated.")
   lazyr.ParseForm(args)
end


