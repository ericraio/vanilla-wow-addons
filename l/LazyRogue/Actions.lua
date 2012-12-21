-- Action Objects

function lazyr.GetActionNameFromTooltip(actionSlot)
   LazyRogue_Tooltip:ClearLines()
   LazyRogue_Tooltip:SetAction(actionSlot)
   return LazyRogue_TooltipTextLeft1:GetText()
end

lazyr.Action = {}
function lazyr.Action:New(code, name, texture, interrupts)
   local obj = {}
   setmetatable(obj, { __index = self })
   obj.code = code
   obj.name = name
   obj.texture = texture
   obj.interrupts = interrupts
   obj.slot = nil
   obj.rank = nil
   obj.everyTimer = 0
   return obj
end
function lazyr.Action:GetSlot()
   if (not self.slot) then
      for slot = 1, 120 do 
         local thisTexture = GetActionTexture(slot)
         if (thisTexture) then 
            --
            -- Sigh.  We need to be careful of localization here.  The bad thing about the
            -- Action class is we don't account for localization (yet), so we have to watch 
            -- when when actually try to match tooltips to self.name.
            --
            -- 1. if we have a texture, match it (and it only, no tooltip).  Ignore macros.
            --    This will be the common case of the built-in actions.
            -- 2. if we don't have a texture, then use tooltips.  Macros okay.  This will
            --    be the case for user action=<action> actions.
            --
            if (self.texture) then
               if (not GetActionText(slot)) then -- ignore any Player macros :-)
                  if (thisTexture and string.find(thisTexture, self.texture)) then 
                     lazyr.d("found "..self.name.." at slot "..slot)
                     self.slot = slot
                     break
                  end
               end
            else
               if (lazyr.GetActionNameFromTooltip(slot) == self.name) then
                  lazyr.d("found "..self.name.." at slot "..slot)
                  self.slot = slot
                  break
               end
            end
         end
      end
   end
   if (not self.slot) then
      lazyr.p("Couldn't find "..self.name.." on your action bar, PLEASE ADD IT.")
      return nil
   end
   return self.slot
end
function lazyr.Action:Use()
   if (self:GetSlot()) then
      local inRange = IsActionInRange(self.slot)
      if (IsUsableAction(self.slot) == 1 and
          GetActionCooldown(self.slot) == 0 and   -- not in cooldown
          not IsCurrentAction(self.slot) and      -- not already being used
          (inRange == 1 or inRange == nil)) then
         if (not lazyr.mock) then
            lazyr.d("Action: "..self.name)
            UseAction(self.slot)
            if (self.interrupts and lazyr.interrupt.targetCasting) then
               lazyr.interrupt.lastSpellInterrupted = lazyr.interrupt.targetCasting
               lazyr.interrupt.targetCasting = nil
            end
            lazyr.recordAction(self.code)
            self.everyTimer = GetTime()
         end
         return true
      end
      return false
   end
end
function lazyr.Action:GetRank()
   if (not self.rank) then
      local i = 1
      while true do
         local texture = GetSpellTexture(i, BOOKTYPE_SPELL)
         if (not texture) then
            break
         end
         if (string.find(texture, self.texture)) then
            local spellNameEn, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
            lazyr.re(spellRank, "(%d+)")
            self.rank = tonumber(lazyr.match1)
            break
         end
         i = i + 1
      end
   end
   if (not self.rank) then
      lazyr.p("Couldn't find "..self.name.." in your spell book.")
      return 0
   end
   return self.rank
end

lazyr.actions = {}
lazyr.actions.adrenalineRush = lazyr.Action:New("adrenaline",    "Adrenaline Rush", "Spell_Shadow_ShadowWordDominate")
lazyr.actions.ambush         = lazyr.Action:New("ambush",        "Ambush",          "Ability_Rogue_Ambush")
lazyr.actions.berserking     = lazyr.Action:New("berserking",    "Berserking",      "Racial_Troll_Berserk")
lazyr.actions.backstab       = lazyr.Action:New("bs",            "Backstab",        "Ability_BackStab")
lazyr.actions.bladeFlurry    = lazyr.Action:New("bladeFlurry",   "Blade Flurry",    "Ability_Warrior_PunishingBlow")
lazyr.actions.blind          = lazyr.Action:New("blind",         "Blind",           "Spell_Shadow_MindSteal", true)
lazyr.actions.cheapShot      = lazyr.Action:New("cs",            "Cheap Shot",      "Ability_CheapShot", true)
lazyr.actions.coldBlood      = lazyr.Action:New("coldBlood",     "Cold Blood",      "Spell_Ice_Lament")
lazyr.actions.evasion        = lazyr.Action:New("evasion",       "Evasion",         "Spell_Shadow_ShadowWard")
lazyr.actions.eviscerate     = lazyr.Action:New("evisc",         "Eviscerate",      "Ability_Rogue_Eviscerate")
lazyr.actions.exposeArmor    = lazyr.Action:New("expose",        "Expose Armor",    "Ability_Warrior_Riposte")
lazyr.actions.feint          = lazyr.Action:New("feint",         "Feint",           "Ability_Rogue_Feint")
lazyr.actions.garrote        = lazyr.Action:New("garrote",       "Garrote",         "Ability_Rogue_Garrote")
lazyr.actions.ghostlyStrike  = lazyr.Action:New("ghostly",       "Ghostly Strike",  "Spell_Shadow_Curse")
lazyr.actions.gouge          = lazyr.Action:New("gouge",         "Gouge",           "Ability_Gouge", true)
lazyr.actions.hemorrhage     = lazyr.Action:New("hemo",          "Hemorrhage",      "Spell_Shadow_LifeDrain")
lazyr.actions.kick           = lazyr.Action:New("kick",          "Kick",            "Ability_Kick", true)
lazyr.actions.kidneyShot     = lazyr.Action:New("ks",            "Kidney Shot",     "Ability_Rogue_KidneyShot", true)
lazyr.actions.pickPocket     = lazyr.Action:New("pickPocket",    "Pick Pocket",     "INV_Misc_Bag_11")
lazyr.actions.premeditation  = lazyr.Action:New("premeditation", "Premeditation",   "Spell_Shadow_Possession")
lazyr.actions.preparation    = lazyr.Action:New("preparation",   "Preparation",     "Spell_Shadow_AntiShadow")
lazyr.actions.riposte        = lazyr.Action:New("riposte",       "Riposte",         "Ability_Warrior_Challange")
lazyr.actions.rupture        = lazyr.Action:New("rupture",       "Rupture",         "Ability_Rogue_Rupture")
lazyr.actions.sap            = lazyr.Action:New("sap",           "Sap",             "Ability_Sap")
lazyr.actions.sinisterStrike = lazyr.Action:New("ss",            "Sinister Strike", "Spell_Shadow_RitualOfSacrifice")
lazyr.actions.sliceNDice     = lazyr.Action:New("snd",           "Slice and Dice",  "Ability_Rogue_SliceDice")
lazyr.actions.sprint         = lazyr.Action:New("sprint",        "Sprint",          "Ability_Rogue_Sprint")
lazyr.actions.stealth        = lazyr.Action:New("stealth",       "Stealth",         "Ability_Stealth")
lazyr.actions.vanish         = lazyr.Action:New("vanish",        "Vanish",          "Ability_Vanish")
lazyr.actions.humanRacial    = lazyr.Action:New("perception",    "Perception",      "Spell_Nature_Sleep")
lazyr.actions.dwarfRacial    = lazyr.Action:New("stoneForm",     "Stoneform",       "Spell_Shadow_UnholyStrength")
lazyr.actions.gnomeRacial    = lazyr.Action:New("escapeArtist",  "Escape Artist",   "Ability_Rogue_Trip")
lazyr.actions.orcRacial      = lazyr.Action:New("bloodFury",     "Blood Fury",      "Racial_Orc_BerserkerStrength")
lazyr.actions.taurenRacial   = lazyr.Action:New("warStomp",      "War Stomp",       "Ability_WarStomp", true)
lazyr.actions.undeadRacial   = lazyr.Action:New("forsaken",      "Will of the Forsaken", "Spell_Shadow_RaiseDead")
lazyr.actions.throw          = lazyr.Action:New("throw",         "Throw",           "Ability_Throw")
lazyr.actions.bow            = lazyr.Action:New("bow",           "Shoot Bow",       "Ability_Marksmanship")
lazyr.actions.gun            = lazyr.Action:New("gun",           "Shoot Gun",       "Ability_Marksmanship")
lazyr.actions.crossbow       = lazyr.Action:New("crossbow",      "Shoot Crossbow",  "Ability_Marksmanship")
lazyr.actions.cannibalize    = lazyr.Action:New("cannibalize",   "Cannibalize",     "Ability_Racial_Cannibalize")

lazyr.otherActions = {}

function lazyr.DeCacheActionSlotIds()
   for idx, action in lazyr.actions do
      action.slot = nil
   end
   for idx, action in lazyr.otherActions do
      action.slot = nil
   end
end
function lazyr.DeCacheActionRanks()
   for idx, action in lazyr.actions do
      action.rank = nil
   end
   for idx, action in lazyr.otherActions do
      action.rank = nil
   end
end


-- ComboAction Objects

lazyr.ComboAction = {}
function lazyr.ComboAction:New(code, name, ...)
   local obj = {}
   setmetatable(obj, { __index = self })
   obj.code = code
   obj.name = name
   obj.actions = {}
   for i = 1, arg.n do
      table.insert(obj.actions, arg[i])
   end
   obj.everyTimer = 0
   return obj
end
function lazyr.ComboAction:Use()
   -- first pass, don't really perform the actions, just see if they're all ready
   local origMock = lazyr.mock
   lazyr.mock = true
   for idx, action in self.actions do
      if (not action:Use()) then
         lazyr.mock = origMock
         return false
      end
   end
   lazyr.mock = origMock

   if (not lazyr.mock) then
      local first = true
      for idx, action in self.actions do
         if (first) then
            first = false
         else
            SpellStopCasting()
         end
         action:Use()
      end

      lazyr.recordAction(self.code)
      self.everyTimer = GetTime()
   end

   return true
end

lazyr.comboActions = {}
lazyr.comboActions.cbEvisc = lazyr.ComboAction:New("cbEvisc", "CB+Eviscerate", lazyr.actions.coldBlood, lazyr.actions.eviscerate)
lazyr.comboActions.cbAmbush = lazyr.ComboAction:New("cbAmbush", "CB+Ambush", lazyr.actions.coldBlood, lazyr.actions.ambush)

-- Form Objects

lazyr.SetForm = {}
function lazyr.SetForm:New(code, name)
   local obj = {}
   setmetatable(obj, { __index = self})
   obj.code = code
   obj.name = name
   obj.everyTimer = 0
   return obj
end
function lazyr.SetForm:Use()
   lazyr.SlashCommand("default "..self.name)
   lazyr.recordAction(self.code)
   self.everyTimer = GetTime()
   return true
end

lazyr.forms = {}
lazyr.forms.default = lazyr.SetForm:New("default", "lazy1")

-- Equip objects

lazyr.EquipItem = {}
function lazyr.EquipItem:New(code, name, id, equipSlot)
   local obj ={}
   setmetatable(obj, { __index = self })
   obj.code = code
   obj.name = name
   obj.id = id
   obj.equipSlot = equipSlot
   obj.everyTimer = 0
   return obj
end
function lazyr.EquipItem:Use()
   local bag, slot
   for bag = 4, 0, -1 do
      for slot = 1, GetContainerNumSlots(bag) do
         local link = GetContainerItemLink(bag, slot)
         if (link) then
            local id, name = lazyr.IdAndNameFromLink(link)
            if (id) then
               -- self.id might be nil, in which case match by name
               if ((self.id and id == self.id) or string.lower(name) == string.lower(self.name)) then
                  if (not lazyr.mock) then
                     PickupContainerItem(bag, slot)
                     EquipCursorItem(self.equipSlot)
                     lazyr.recordAction(self.code)
                     self.everyTimer = GetTime()
                  end
                  return true
               end
            end
         end
      end
   end
   return false
end

lazyr.mainHandItems = {}
lazyr.offHandItems = {}

-- Item Objects

lazyr.Item = {}
function lazyr.Item:New(code, name, id, equippedOnly)
   local obj = {}
   setmetatable(obj, { __index = self })
   obj.code = code
   obj.name = name
   obj.id = id
   obj.equippedOnly = equippedOnly
   obj.everyTimer = 0
   return obj
end
function lazyr.Item:Use()
   -- check equipped items first
   for slot = 0, 19 do
      local link = GetInventoryItemLink("player", slot)
      if (link) then
         local id, name = lazyr.IdAndNameFromLink(link)
         if (id) then
            -- self.id might be nil, in which case match by name
            if ((self.id and id == self.id) or string.lower(name) == string.lower(self.name)) then
               if (GetInventoryItemCooldown("player", slot) == 0) then
                  if (not lazyr.mock) then
                     lazyr.d("Using item: "..self.name.."("..lazyr.nonil(self.id)..") at equipped slot: "..slot)
                     UseInventoryItem(slot)
                     lazyr.recordAction(self.code)
                     self.everyTimer = GetTime()
                     if (SpellIsTargeting()) then
                        SpellTargetUnit("player")
                     end
                  end
                  return true
               end
            end
         end
      end
   end
   
   if (not self.equippedOnly) then
      local bag, slot
      for bag = 4, 0, -1 do
         for slot = 1, GetContainerNumSlots(bag) do
            local link = GetContainerItemLink(bag, slot)
            if (link) then
               local id, name = lazyr.IdAndNameFromLink(link)
               if (id) then
                  -- self.id might be nil, in which case match by name
                  if ((self.id and id == self.id) or string.lower(name) == string.lower(self.name)) then
                     if (GetContainerItemCooldown(bag, slot) == 0) then
                        if (not lazyr.mock) then
                           lazyr.d("Using item: "..self.name.."("..
                                   lazyr.nonil(self.id)..") at bag/slot slot: "..bag.."/"..slot)
                           UseContainerItem(bag,slot)
                           lazyr.recordAction(self.code)
                           self.everyTimer = GetTime()
                           if (SpellIsTargeting()) then
                              SpellTargetUnit("player")
                           end
                        end
                        return true
                     end
                  end
               end
            end
         end
      end
   end
    
   return false
end

lazyr.items = {}
lazyr.items.thistleTea = lazyr.Item:New("tea", "Thistle Tea", 7676)

lazyr.equippedItems = {}


-- PseudoAction Objects

lazyr.PseudoAction = {}
function lazyr.PseudoAction:New(code, name)
   local obj = {}
   setmetatable(obj, { __index = self })
   obj.code = code
   obj.name = name
   obj.everyTimer = 0
   return obj
end
function lazyr.PseudoAction:Use()
   -- all PseudoAction instances must define their own Use() method
   -- remember, reset everyTimer in each
end

lazyr.pseudoActions = {}

lazyr.pseudoActions.targetAssist = lazyr.PseudoAction:New("targetAssist", "Target Assist")
function lazyr.pseudoActions.targetAssist:Use()
   -- this pseudo action always succeeds, so no action after it will be executed
   if (lazyr.mock) then
      -- this needs work
      return false
   end
   tmpTarget = UnitName("target")
   TargetByName(tostring(lazyr.assistName), true)
   if UnitName("targettarget")==tmpTarget and UnitName("targettarget")~=nil then       
      TargetLastTarget() 
      return false
   end
   if lazyr.assistName~=nil then
      ClearTarget()
      AssistByName(lazyr.assistName)
      if UnitName("target")==nil then
         TargetByName(tostring(lazyr.assistName), true)
         if UnitExists("target") then
            lazyr.d("Waiting for target to be chosen...")
            return true
         else
            lazyr.p("Assist target seams to be out of range, please update with /lr assist <assist name>")
            return false
         end
      else
         lazyr.d("Assisting "..lazyr.assistName)
         lazyr.recordAction(self.code)
         self.everyTimer = GetTime()
         return true
      end
      
   else
      lazyr.p("Assist target not set please update with /lr assist <assist name>")
      return false
   end 
end

lazyr.pseudoActions.targetNearest = lazyr.PseudoAction:New("targetNearest", "Target Nearest")
function lazyr.pseudoActions.targetNearest:Use()
   -- this pseudo action always succeeds, so no action after it will be executed
   if (lazyr.mock) then
      -- this needs work
      return false
   end
   TargetNearestEnemy()
   
   lazyr.recordAction(self.code)
   self.everyTimer = GetTime()
   return true
end

lazyr.pseudoActions.autoAttack = lazyr.PseudoAction:New("autoAttack", "Auto Target/Attack")
function lazyr.pseudoActions.autoAttack:Use()
   if (not lazyr.IsAutoAttacking()) then
      if (not lazyr.mock) then
         lazyr.StartAutoAttack()
         lazyr.recordAction(self.code)
         self.everyTimer = GetTime()
      end
      return true
   end
   
   return false
end

lazyr.pseudoActions.stop = lazyr.PseudoAction:New("stop", "Stop")
function lazyr.pseudoActions.stop:Use()
   -- this pseudo action always succeeds, so no action after it will be executed
   --lazyr.recordAction(self.code)
   if (not lazyr.mock) then
      self.everyTimer = GetTime()
   end
   return true
end

lazyr.pseudoActions.stopAll = lazyr.PseudoAction:New("stopAll", "Stop All")
function lazyr.pseudoActions.stopAll:Use()
   if (not lazyr.mock) then
      if (lazyr.IsAutoAttacking()) then
         lazyr.d("Stopping auto-attack...")
         lazyr.StopAutoAttack()
      end
      --lazyr.recordAction(self.code)
      self.everyTimer = GetTime()
   end
   return true
end

lazyr.pseudoActions.dismount = lazyr.PseudoAction:New("dismount", "Dismount")
function lazyr.pseudoActions.dismount:Use()
   if (not lazyr.mock) then
      local index = lazyr.masks.PlayerMountedIndex()
      if (index) then
         CancelPlayerBuff(index)
      end
      lazyr.recordAction(self.code)
      self.everyTimer = GetTime()
   end
   return true
end

-- this pseudo action is just for testing criteria
lazyr.pseudoActions.ping = lazyr.PseudoAction:New("ping", "Ping")
function lazyr.pseudoActions.ping:Use()
   if (not lazyr.mock) then
      lazyr.chat("ping")
      --lazyr.recordAction(self.code)
      self.everyTimer = GetTime()
   end
   return true
end


lazyr.pseudoActions.sayIn = lazyr.PseudoAction:New("sayIn", "Say In ...")
function lazyr.pseudoActions.sayIn:Use()
   if (not lazyr.mock) then
      SendChatMessage(lazyr.sayInMessage,lazyr.sayInChannel)
      self.everyTimer = GetTime()
   end
   return true
end


function lazyr.PickupPoison(name)
   local i, itemLink, bagSlots, bagId, icon, quantity;
   for i=0, 4 do
      itemLink = nil;
      bagSlots = GetContainerNumSlots(i);
      if (bagSlots > 0) then
         for j=1, bagSlots do
            itemLink = nil;
            itemLink = GetContainerItemLink(i, j);
            if (itemLink) then
               local _, _, itemName = string.find(itemLink, "%[(.*)%]");
               if (itemName ~= nil and itemName == name) then
                  lazyr.d("Found "..name);
                  UseContainerItem(i, j);
                  return;
               end
            end
         end
      end
   end
end

lazyr.poisonsUse ={}
lazyr.applyPoison ={}

function lazyr.applyPoison:New(poisonName, equipSlot)
   local obj ={}
   setmetatable(obj, { __index = self })
   obj.psnName = poisonName
   obj.psnDst = equipSlot
   obj.everyTimer = 0
   return obj
end

function lazyr.applyPoison:Use()
   local poison = self.psnName
   local slotgiven = self.psnDst
   if (slotgiven == "OffHand") then
      slot = "SecondaryHandSlot";
   else 
      slot = "MainHandSlot";
   end
   poison=gsub (poison, "[%[%]]", "")
   lazyr.PickupPoison(poison);
   PickupInventoryItem(GetInventorySlotInfo(slot));
   -- If the pickup failed we will now have the weapon on our cursor
   if (CursorHasItem()) then
      PickupInventoryItem(GetInventorySlotInfo(slot));
   end
   self.everyTimer = GetTime()
   return true
end



function lazyr.ResetEveryTimers()
   local now = GetTime()
   for idx, action in lazyr.actions do
      action.everyTimer = now
   end
   for idx, action in lazyr.comboActions do
      action.everyTimer = now
   end
   for idx, action in lazyr.items do
      action.everyTimer = now
   end
   for idx, action in lazyr.pseudoActions do
      action.everyTimer = now
   end
end

lazyr.actionHistory = {}
function lazyr.recordAction(action)
   -- add to the front, remove from the end
   table.insert(lazyr.actionHistory, 1, action)
   local size = table.getn(lazyr.actionHistory)
   if (size > 25) then
      local difference = size - 25
      local i
      for i = 1, difference do
         table.remove(lazyr.actionHistory)
      end
   end
end


