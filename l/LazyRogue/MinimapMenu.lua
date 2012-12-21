-- Minimap Button Handling

lazyr.mm = {}


function lazyr.mm.OnLoad()
   local junk, englishClass = UnitClass("player")
   if (englishClass ~= "ROGUE") then
      return
   end
   this:SetFrameLevel(this:GetFrameLevel()+1)
   this:RegisterForClicks("LeftButtonDown", "RightButtonDown")
   this:RegisterEvent("VARIABLES_LOADED")
end

function lazyr.mm.OnClick(button)
   if (button == "LeftButton") then
      -- Toggle menu
      local menu = getglobal("LazyRogueMinimapMenu")
      menu.point = "TOPRIGHT"
      menu.relativePoint = "CENTER"
      ToggleDropDownMenu(1, nil, menu, "LazyRogueMinimapButton", -120, 0)
   end
end

function lazyr.mm.OnEvent()
   lazyr.mm.UpdateMinimap()
   if (lazyr.perPlayerConf.mmIsVisible) then
      this:Show()
      LazyRogueMinimapButton:Show()
   else
      this:Hide()
      LazyRogueMinimapButton:Hide()
   end
end

function lazyr.mm.OnEnter()
   GameTooltip:SetOwner(this, "ANCHOR_LEFT")
   GameTooltip:SetText("LazyRogue")
   local defaultForm = lazyr.perPlayerConf.defaultForm
   if (not defaultForm) then
      defaultForm = "(none)"
   end
   GameTooltip:AddLine("Current Form: "..defaultForm)
   GameTooltip:AddLine("Left-click to choose your form.")
   GameTooltip:AddLine("Right-click and drag to move this button.")
   GameTooltip:Show()
end

function lazyr.mm.UpdateMinimap()
   lazyr.mm.MoveButton()
   if (Minimap:IsVisible()) then
      LazyRogueMinimapButton:EnableMouse(true)
      LazyRogueMinimapButton:Show()
      LazyRogueMinimapFrame:Show()
   else
      LazyRogueMinimapButton:EnableMouse(false)
      LazyRogueMinimapButton:Hide()
      LazyRogueMinimapFrame:Hide()
   end
end

function lazyr.mm.Menu_Initialize()
   if (not lazyr.perPlayerConf) then
      -- just loading, skip it for now
      return
   end
   if (UIDROPDOWNMENU_MENU_LEVEL == 1) then

      local formNames = {}
      for form, actions in lrConf.forms do
         table.insert(formNames, form)
      end

      table.sort(formNames)

      local info = {}
      info.isTitle = 1
      info.text = "LazyRogue v"..lazyr.version
      UIDropDownMenu_AddButton(info)

      for idx, formName in formNames do
         local actions = lrConf.forms[formName]
         local info = {}
         info.text = formName
         info.value = formName
         info.func = lazyr.mm.Menu_ClickFunc(formName)
         info.checked = (lazyr.perPlayerConf.defaultForm and lazyr.perPlayerConf.defaultForm == formName)
         info.keepShownOnClick = 1
         info.hasArrow = 1
         info.tooltipTitle = formName
         info.tooltipText = ""
         for idx, action in actions do
            info.tooltipText = info.tooltipText.."\n- "..action
         end
         UIDropDownMenu_AddButton(info)
      end

      info = {}
      info.text = "< Create new form >"
      info.func = lazyr.mm.Menu_ClickSubFunction("New")
      UIDropDownMenu_AddButton(info)

      info = {}
      info.text = "< Options >"
      info.value = "Options"
      info.keepShownOnClick = 1
      info.hasArrow = 1
      UIDropDownMenu_AddButton(info)

      info = {}
      info.text = "< Eviscerate Options >"
      info.value = "Eviscerates"
      info.keepShownOnClick = 1
      info.hasArrow = 1
      UIDropDownMenu_AddButton(info)

      info = {}
      info.text = "< Cast Interrupt Options >"
      info.value = "Interrupts"
      info.keepShownOnClick = 1
      info.hasArrow = 1
      UIDropDownMenu_AddButton(info)

      info = {}
      info.text = "< Debugging >"
      info.value = "Debugging"
      info.keepShownOnClick = 1
      info.hasArrow = 1
      UIDropDownMenu_AddButton(info)

      info = {}
      info.text = "< About >"
      info.func = lazyr.mm.Menu_ClickSubFunction("About")
      UIDropDownMenu_AddButton(info)

   elseif (UIDROPDOWNMENU_MENU_LEVEL == 2) then
      if (UIDROPDOWNMENU_MENU_VALUE == "Options") then

         local info = {}
         info.isTitle = 1
         info.text = "LazyRogue Options"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Auto-Target"
         if (lazyr.perPlayerConf.autoTarget) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("AutoTarget")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         
         local info = {}
         info.text = "... and initiate Auto-Attack"
         if (lazyr.perPlayerConf.initiateAutoAttack) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("InitiateAutoAttack")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         
         local info = {}
         info.text = "Show Minion"
         if (lazyr.perPlayerConf.minionIsVisible) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("Show Minion")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         
         local info = {}
         info.text = "... Only in combat"
         if (lazyr.perPlayerConf.minionHidesOutOfCombat) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("Show Minion in Combat")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Show Deathstimator Minion"
         if (lazyr.perPlayerConf.deathMinionIsVisible) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("Show Death Minion")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         
         local info = {}
         info.text = "... Only in combat"
         if (lazyr.perPlayerConf.deathMinionHidesOutOfCombat) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("Show Death Minion in Combat")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.isTitle = 1
         info.text = "Deathstimator sample window:"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         for idx, i in {3, 5, 10, 15, 30, 60} do
            local info = {}
            info.text = "... "..i.."s"
            if (lazyr.perPlayerConf.healthHistorySize == i) then
               info.checked = true
            end
            info.keepShownOnClick = 1
            info.func = lazyr.mm.Menu_ClickSubFunction("Deathstimate "..i)
            UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         end

      elseif (UIDROPDOWNMENU_MENU_VALUE == "Eviscerates") then

         local info = {}
         info.isTitle = 1
         info.text = "Eviscerate Options"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Use Eviscerate Tracking"
         if (lazyr.perPlayerConf.useEviscTracking) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("Use Eviscerate Tracking")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "... Include Crits (may skew kill shots)"
         if (lazyr.perPlayerConf.trackEviscCrits) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("Track Eviscerate Crits")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.isTitle = 1
         info.text = "Eviscerate sample window:"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         for idx, i in {10, 25, 50, 100} do
            local info = {}
            info.text = "... Last "..i.." Eviscerates"
            if (lazyr.perPlayerConf.eviscerateSample == i) then
               info.checked = true
            end
            info.keepShownOnClick = 1
            info.func = lazyr.mm.Menu_ClickSubFunction("Eviscerate Sample "..i)
            UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         end

         local info = {}
         info.isTitle = 1
         info.text = "Eviscerate Stats"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         
         local info = {}
         info.isTitle = 1
         info.text = "Observed/Optimal => % (# seen)"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         
         local info = {}
         info.isTitle = 1

         for cp = 1, 5 do
            local expectedDamage = lazyr.masks.CalculateBaseEviscDamage(cp)
            if (not expectedDamage) then
               break
            end
            local observedDamage, observedCt = lazyr.et.GetEviscTrackingInfo(cp)
            local ratio = observedDamage / expectedDamage
            info.text = cp.."cp: "..
               string.format("%.1f", observedDamage)..
               "/"..string.format("%.1f", expectedDamage)..
               " => "..string.format("%.1f", (ratio * 100)).."%"..
               " ("..observedCt.." seen)"

            -- TBD: tooltip
            --info.tooltipTitle = "Eviscerate Stats ("..i.."cp)"
            --local text = observedCt.." Eviscerates observed."
            --text = text.."\nAveraging "..observedDamage.." damage"
            --text = text.."\nThe documented "..observedDamage.." damage"
            --info.tooltipText = text

            UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         end

         local info = {}
         info.text = "< Reset >"
         info.func = lazyr.mm.Menu_ClickSubFunction("Reset Eviscerate Stats")
         -- TBD:
         --info.keepShownOnClick = 1
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

      elseif (UIDROPDOWNMENU_MENU_VALUE == "Interrupts") then

         local info = {}
         info.isTitle = 1
         info.text = "Cast Interrupt Options"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "< Edit Interrupt Exception Criteria >"
         info.func = lazyr.mm.Menu_ClickSubFunction("Global Interrupt Criteria")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.isTitle = 1
         local lastInterrupted
         if (lazyr.interrupt.lastSpellInterrupted) then
            lastInterrupted = lazyr.interrupt.lastSpellInterrupted
         else
            lastInterrupted = "(none)"
         end
         info.text = "Last interrupted: "..lastInterrupted
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "< ... Don't interrupt it again >"
         info.func = lazyr.mm.Menu_ClickSubFunction("noLongerInterruptLastInterrupted")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

      elseif (UIDROPDOWNMENU_MENU_VALUE == "Debugging") then

         local info = {}
         info.isTitle = 1
         info.text = "Debugging Options"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Log when target casts"
         if (lazyr.perPlayerConf.showTargetCasts) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("showTargetCasts")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Show why when -ifTargetCCd is true"
         if (lazyr.perPlayerConf.showReasonForTargetCCd) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("showReasonForTargetCCd")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "< Action History >"
         info.value = "History"
         info.keepShownOnClick = 1
         info.hasArrow = 1
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

         local info = {}
         info.text = "Internal LazyRogue debugging (noisy)"
         if (lazyr.perPlayerConf.debug) then
            info.checked = true
         end
         info.keepShownOnClick = 1
         info.func = lazyr.mm.Menu_ClickSubFunction("debug")
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)

      else
         -- a submenu of a form
         for idx, op in {"Edit", "Copy", "Delete"} do
            local info = {}
            info.text = "< "..op.." >"
            info.func = lazyr.mm.Menu_ClickSubFunction(op, UIDROPDOWNMENU_MENU_VALUE)
            UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         end
      end

   elseif (UIDROPDOWNMENU_MENU_LEVEL == 3) then
      if (UIDROPDOWNMENU_MENU_VALUE == "History") then
         local info = {}
         info.isTitle = 1
         info.text = "Action History"
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         for idx, action in ipairs(lazyr.actionHistory) do
            info.text = idx..". "..action
            UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
         end
      end
   end
end

function lazyr.mm.Menu_ClickFunc(form)
   return function() 
             lazyr.SlashCommand("default "..form) 
             CloseDropDownMenus()
             LazyRogueMinimapButton:Click()
             -- This is a hack to deal with the code in UIDropDownMenu.lua.
             -- This makes it so if a button was already checked, it remains checked,
             -- which is what I want.
             if (this.checked) then
                this.checked = nil
             end
          end
end

function lazyr.mm.Menu_ClickSubFunction(op, form)
   return function()
             if (not form) then
                form = ""
             end
             if (op == "New" or op == "Edit") then
                lazyr.SlashCommand("edit "..form)
                CloseDropDownMenus()
                LazyRogueMinimapButton:Click()
             elseif (op == "Copy") then
                local newName
                for i = 1, 10 do
                   newName = form.."-"..i
                   if (not lrConf.forms[newName]) then
                      lazyr.SlashCommand("copy "..form.." "..newName)
                      break
                   end
                end
                CloseDropDownMenus()
                LazyRogueMinimapButton:Click()
             elseif (op == "Delete") then
                lazyr.SlashCommand("clear "..form)
                CloseDropDownMenus()
                LazyRogueMinimapButton:Click()

             elseif (op == "About") then
                lazyr.SlashCommand("about")

             elseif (op == "AutoTarget") then
                lazyr.SlashCommand("autoTarget")
                lazyr.mm.RefreshMenu2("Options")

             elseif (op == "InitiateAutoAttack") then
                lazyr.SlashCommand("initiateAutoAttack")
             elseif (op == "Show Minion") then
                if (lazyr.perPlayerConf.minionIsVisible) then
                   lazyr.SlashCommand("dismiss")
                else
                   lazyr.SlashCommand("summon")
                end
             elseif (op == "Show Minion in Combat") then
                lazyr.SlashCommand("hideMinionOutOfCombat")
             elseif (op == "Show Death Minion") then
                if (lazyr.perPlayerConf.deathMinionIsVisible) then
                   lazyr.SlashCommand("dismissDeath")
                else
                   lazyr.SlashCommand("summonDeath")
                end
             elseif (op == "Show Death Minion in Combat") then
                lazyr.SlashCommand("hideDeathMinionOutOfCombat")
             elseif (op == "Deathstimate 3") then
                lazyr.perPlayerConf.healthHistorySize = 3
                lazyr.mm.RefreshMenu("Options")
             elseif (op == "Deathstimate 5") then
                lazyr.perPlayerConf.healthHistorySize = 5
                lazyr.mm.RefreshMenu("Options")
             elseif (op == "Deathstimate 10") then
                lazyr.perPlayerConf.healthHistorySize = 10
                lazyr.mm.RefreshMenu("Options")
             elseif (op == "Deathstimate 15") then
                lazyr.perPlayerConf.healthHistorySize = 15
                lazyr.mm.RefreshMenu("Options")
             elseif (op == "Deathstimate 30") then
                lazyr.perPlayerConf.healthHistorySize = 30
                lazyr.mm.RefreshMenu("Options")
             elseif (op == "Deathstimate 60") then
                lazyr.perPlayerConf.healthHistorySize = 60
                lazyr.mm.RefreshMenu("Options")

             elseif (op == "Reset Eviscerate Stats") then
                lazyr.SlashCommand("resetEviscerateStats")
             elseif (op == "Use Eviscerate Tracking") then
                lazyr.SlashCommand("useEviscerateTracking")
             elseif (op == "Track Eviscerate Crits") then
                lazyr.SlashCommand("trackEviscCrits")
             elseif (op == "Eviscerate Sample 10") then
                lazyr.perPlayerConf.eviscerateSample = 10
                lazyr.mm.RefreshMenu("Eviscerates")
             elseif (op == "Eviscerate Sample 25") then
                lazyr.perPlayerConf.eviscerateSample = 25
                lazyr.mm.RefreshMenu("Eviscerates")
             elseif (op == "Eviscerate Sample 50") then
                lazyr.perPlayerConf.eviscerateSample = 50
                lazyr.mm.RefreshMenu("Eviscerates")
             elseif (op == "Eviscerate Sample 100") then
                lazyr.perPlayerConf.eviscerateSample = 100
                lazyr.mm.RefreshMenu("Eviscerates")

             elseif (op == "Global Interrupt Criteria") then
                lazyr.SlashCommand("interruptExceptionCriteria")
             elseif (op == "noLongerInterruptLastInterrupted") then
                lazyr.SlashCommand("noLongerInterruptLastInterrupted")


             elseif (op == "debug") then
                lazyr.SlashCommand("debug")
             elseif (op == "showTargetCasts") then
                lazyr.SlashCommand("showTargetCasts")
             elseif (op == "showReasonForTargetCCd") then
                lazyr.SlashCommand("showReasonForTargetCCd")
             end
          end
end

function lazyr.mm.RefreshMenu(which)
   UIDropDownMenu_Initialize(LazyRogueMinimapMenu, lazyr.mm.Menu_Initialize, which)
   -- again, a hack to deal with the code in UIDropDownMenu.lua.
   if (this.checked) then
      this.checked = nil
   end
end

function lazyr.mm.RefreshMenu2(which)
   UIDropDownMenu_Initialize(LazyRogueMinimapMenu, lazyr.mm.Menu_Initialize, which)
   -- again, a hack to deal with the code in UIDropDownMenu.lua.
   if (this.checked) then
      this.checked = nil
   else
      this.checked = true
   end
end

-- Thanks to Yatlas for this code
function lazyr.mm.Button_BeingDragged()
    -- Thanks to Gello for this code
    local xpos,ypos = GetCursorPosition() 
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() 

    xpos = xmin-xpos/UIParent:GetScale()+70 
    ypos = ypos/UIParent:GetScale()-ymin-70 

    lazyr.mm.Button_SetPosition(math.deg(math.atan2(ypos,xpos)))
end

function lazyr.mm.Button_SetPosition(v)
    if(v < 0) then
        v = v + 360
    end

    lazyr.perPlayerConf.minimapButtonPos = v
    lazyr.mm.MoveButton()
end

function lazyr.mm.MoveButton()
   local where = lazyr.perPlayerConf.minimapButtonPos
   LazyRogueMinimapFrame:ClearAllPoints()
   LazyRogueMinimapFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",
                                  52 - (80 * cos(where)),
                                  (80 * sin(where)) - 52)
end

