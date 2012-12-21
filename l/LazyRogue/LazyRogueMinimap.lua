-- Minimap Button Handling

lrmm = {}

function lrmm.OnLoad()
   local junk, englishClass = UnitClass("player")
   if (englishClass ~= "ROGUE") then
      return
   end
   this:SetFrameLevel(this:GetFrameLevel()+1)
   this:RegisterForClicks("LeftButtonDown", "RightButtonDown")
   this:RegisterEvent("VARIABLES_LOADED")
end

function lrmm.OnClick(button)
   if (button == "LeftButton") then
      -- Toggle menu
      local menu = getglobal("LazyRogueMinimapMenu")
      menu.point = "TOPRIGHT"
      menu.relativePoint = "CENTER"
      ToggleDropDownMenu(1, nil, menu, "LazyRogueMinimapButton", -120, 0)
   end
end

function lrmm.OnEvent()
   lrmm.UpdateMinimap()
   if (lrConf.mmIsVisible) then
      this:Show()
      LazyRogueMinimapButton:Show()
   else
      this:Hide()
      LazyRogueMinimapButton:Hide()
   end
end

function lrmm.OnEnter()
   GameTooltip:SetOwner(this, "ANCHOR_LEFT")
   -- TBD: localization
   GameTooltip:SetText("LazyRogue")
   GameTooltip:AddLine("Left-click to choose your form.")
   GameTooltip:AddLine("Right-click and drag to move this button.")
   GameTooltip:Show()
end

function lrmm.UpdateMinimap()
   lrmm.MoveButton()
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

function lrmm.Menu_Initialize()
   if (UIDROPDOWNMENU_MENU_LEVEL == 1) then

      local formNames = {}
      for form, actions in lrConf.forms do
         table.insert(formNames, form)
      end

      table.sort(formNames)

      local info = {}
      info.isTitle = 1
      info.text = "LazyRogue"
      UIDropDownMenu_AddButton(info)

      for idx, formName in formNames do
         local actions = lrConf.forms[formName]
         local info = {}
         info.text = formName
         info.value = formName
         info.func = lrmm.Menu_ClickFunc(formName)
         info.checked = (lrConf.defaultForm and lrConf.defaultForm == formName)
         info.keepShownOnClick = 1
         info.hasArrow = 1
         info.tooltipTitle = formName
         info.tooltipText = table.concat(actions, "\n")
         UIDropDownMenu_AddButton(info)
      end

      info = {}
      info.text = "< Create new form >"
      info.func = lrmm.Menu_ClickSubFunction("New")
      UIDropDownMenu_AddButton(info)

   elseif (UIDROPDOWNMENU_MENU_LEVEL == 2) then
      for idx, op in {"Edit", "Copy", "Delete"} do
         local info = {}
         info.text = op
         info.func = lrmm.Menu_ClickSubFunction(op, UIDROPDOWNMENU_MENU_VALUE)
         UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
      end
   end
end

function lrmm.Menu_ClickFunc(form)
   return function() 
             lr.SlashCommand("default "..form) 
             CloseDropDownMenus()
             LazyRogueMinimapButton:Click()
             -- This is a total hack to deal with the code in UIDropDownMenu.lua.
             -- This makes it so if a button was already checked, it remains checked,
             -- which is what I want.
             if (this.checked) then
                this.checked = nil
             end
          end
end

function lrmm.Menu_ClickSubFunction(op, form)
   return function()
             if (not form) then
                form = ""
             end
             if (op == "New" or op == "Edit") then
                lr.SlashCommand("edit "..form)
             elseif (op == "Copy") then
                local newName
                for i = 1, 10 do
                   newName = form.."-"..i
                   if (not lrConf.forms[newName]) then
                      lr.SlashCommand("copy "..form.." "..newName)
                      break
                   end
                end
             elseif (op == "Delete") then
                lr.SlashCommand("clear "..form)
             end
             CloseDropDownMenus()
             LazyRogueMinimapButton:Click()
          end
end

-- Thanks to Yatlas for this code
function lrmm.Button_BeingDragged()
    -- Thanks to Gello for this code
    local xpos,ypos = GetCursorPosition() 
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() 

    xpos = xmin-xpos/UIParent:GetScale()+70 
    ypos = ypos/UIParent:GetScale()-ymin-70 

    lrmm.Button_SetPosition(math.deg(math.atan2(ypos,xpos)))
end

function lrmm.Button_SetPosition(v)
    if(v < 0) then
        v = v + 360
    end

    lrConf.minimapButtonPos = v
    lrmm.MoveButton()
end

function lrmm.MoveButton()
   local where = lrConf.minimapButtonPos
   LazyRogueMinimapFrame:ClearAllPoints()
   LazyRogueMinimapFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",
                                  52 - (80 * cos(where)),
                                  (80 * sin(where)) - 52)
end

