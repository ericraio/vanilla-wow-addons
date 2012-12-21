function mgames_OnLoad()
	
	--slash command
	SLASH_MinigamesUI1 = "/minig"
	SLASH_MinigamesUI2 = "/minigames"
	SLASH_MinigamesUI3 = "/minigamesui"
	SlashCmdList["MinigamesUI"] = function(msg)
		mgames_SlashCommand(msg)
	end
    --Speicherort erstellen, wenn nicht vorhanden // erster start
    if (MinigamesUI == nil) then
    	MinigamesUI = {}
    	MinigamesUI.minimap = 1
    	MinigamesUI.version = 2.1
    	MinigamesUI.game = 1
    end
    --startup
	MinigamesUI.UI = false
	MinigamesUI.minimapUI = false
	MinigamesUI.minimap_move = false
	MinigamesUI.credit = false
	mgames_minigames_addonloaded()
	mgames_minimap_Toggle()
end

function mgames_SlashCommand(msg)
	mgames_Toggle()
end

function mgames_Show()
	mgames_rf:SetHeight(165)
    mgames_rf:SetWidth(200)
	mgames_string1:SetText("Choose the game")
	mgames_string2:SetText("Minimap:")
	mgames_string2:SetPoint("BOTTOMRIGHT", -45, 23)
	mgames_button3:SetPoint("BOTTOM", -64+25/2+3, 15)
	mgames_button1:Show()
	mgames_button2:Show()
	mgames_checkbox:Show()
	mgames_dropdown:Show()
	
end

function mgames_credit_Show()
	mgames_rf:SetHeight(250)
    mgames_rf:SetWidth(240)	
	mgames_button1:Hide()
	mgames_button2:Hide()
	mgames_checkbox:Hide()
	mgames_dropdown:Hide()
	mgames_string1:SetText(mgames_credit_text())
	mgames_string2:SetText("MinigamesUI by Rewad")
	mgames_string2:SetPoint("BOTTOMRIGHT", -15, 23)
	mgames_button3:SetPoint("BOTTOM", -80+25/2+3, 15)
	MinigamesUI.credit = true
end

function mgames_Toggle()
	if (MinigamesUI.UI) then
		if (mgames:IsShown()) then
			mgames:Hide()
		else
			mgames:Show()
		end
	else
		mgames_UI_Create()
		mgames_Show()
	end
end

function mgames_minimap_Toggle()
	if (MinigamesUI.minimap == 1) then
		if (MinigamesUI.minimapUI) then
			mgames_minimap:Show()
		else
			mgames_minimap_UI_Create()
		end
	else
		if (MinigamesUI.minimapUI) then
			mgames_minimap:Hide()
		end
	end
end

function mgames_UI_Create()

	CreateFrame("Frame", "mgames", UIParent)
	mgames:EnableMouse(true)
	mgames:SetMovable(true)
	mgames:SetScript("OnMouseDown", function() if (arg1 == "LeftButton") then this:StartMoving() end end)
	mgames:SetScript("OnMouseUp", function() if (arg1 == "LeftButton") then this:StopMovingOrSizing() end end)
	mgames:SetPoint("CENTER", 0, 100)
	mgames:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 25, insets = { left = 6, right = 6, top = 6, bottom = 6 }})
	mgames:SetFrameLevel(2)
	mgames:SetHeight(40)
    mgames:SetWidth(130)
			
	mgames:CreateTexture("mgames_textur", "BACKGROUND")
	mgames_textur:SetTexture(0, 0, 0, 1)	
	mgames_textur:SetHeight(40-12)
    mgames_textur:SetWidth(130-12)
    mgames_textur:SetPoint("CENTER", 0, 0)
    
	mgames:CreateFontString("mgames_text")
	mgames_text:SetFontObject(GameFontNormal)
	mgames_text:SetText("MiniGames v"..MinigamesUI.version)
	mgames_text:SetPoint("CENTER", 0, 1)
	
	CreateFrame("Frame", "mgames_rf", mgames)
	mgames_rf:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 25, insets = { left = 6, right = 6, top = 6, bottom = 6 }});
	mgames_rf:SetFrameLevel(1)
	mgames_rf:SetPoint("TOP", "mgames", 0, -15);
	
	mgames_rf:CreateFontString("mgames_string1")
	mgames_string1:SetFontObject(ChatFontNormal)
	mgames_string1:SetPoint("TOP", 0, -25)
	
	CreateFrame("Button", "mgames_dropdown", mgames_rf, "UIDropDownMenuTemplate")
	mgames_dropdown:SetPoint("TOP", 0, -45)
	UIDropDownMenu_SetWidth(150, mgames_dropdown)
    UIDropDownMenu_Initialize(mgames_dropdown, mgames_dropdown_Initialize)

	CreateFrame("Button", "mgames_button1", mgames_rf, "GameMenuButtonTemplate")
	mgames_button1:SetPoint("TOP", -35+25/2+3, -80)
	mgames_button1:SetHeight(30)
    mgames_button1:SetWidth(130)
    mgames_button1:SetText("Play!")
	mgames_button1:SetScript("OnClick", function() mgames_button1_OnClick() end)
    
	CreateFrame("Button", "mgames_button2", mgames_rf, "GameMenuButtonTemplate")
	mgames_button2:SetPoint("TOP", 68, -80)
	mgames_button2:SetHeight(30)
    mgames_button2:SetWidth(30)
    mgames_button2:SetText("?")
    mgames_button2:SetScript("OnClick", function() mgames_button2_OnClick() end)
    
	CreateFrame("Button", "mgames_button3", mgames_rf, "GameMenuButtonTemplate")
	mgames_button3:SetHeight(30)
    mgames_button3:SetWidth(70)
    mgames_button3:SetText("Close")
	mgames_button3:SetScript("OnClick", function() mgames_button3_OnClick() end)

	mgames_rf:CreateFontString("mgames_string2")
	mgames_string2:SetFontObject(ChatFontNormal)

	CreateFrame("CheckButton", "mgames_checkbox", mgames_rf, "OptionsCheckButtonTemplate")
	mgames_checkbox:SetPoint("BOTTOM", 70, 15)
	mgames_checkbox:SetHeight(30)
    mgames_checkbox:SetWidth(30)
    mgames_checkbox:SetScript("OnClick", function() mgames_checkbox_OnClick() end) 

    --voreinstellungen
	UIDropDownMenu_SetSelectedID(mgames_dropdown, MinigamesUI.game)
	mgames_checkbox:SetChecked(MinigamesUI.minimap)
	if (mgames_minigames_addonloadedliste[MinigamesUI.game] == false) then
		mgames_button1:Disable()
	end
	MinigamesUI.UI = true
end

function mgames_minimap_UI_Create ()	
	mgames_minimap:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	mgames_minimap:SetScript("OnMouseUp", function() mgames_minimap_OnMouseUp() end)
	mgames_minimap:SetScript("OnMouseDown", function() mgames_minimap_OnMouseDown() end)
	mgames_minimap:SetScript("OnEnter", function() mgames_minimap_tooltip_Show() end)
	mgames_minimap:SetScript("OnLeave", function() GameTooltip:Hide() end)
	MinigamesUI.minimapUI = true
	mgames_minimap:Show()
end

function mgames_minimap_OnMouseUp()
	if ( arg1 == "LeftButton" ) then
		mgames_Toggle()
	elseif ( arg1 == "RightButton" ) then
		if (MinigamesUI.minimap_move) then
			MinigamesUI.minimap_move = false
			mgames_minimap:StopMovingOrSizing()
		else
			mgames_game_Go()
		end
	end
end

function mgames_minimap_OnMouseDown()
	if (arg1 == "RightButton" and IsControlKeyDown()) then
		MinigamesUI.minimap_move = true
		mgames_minimap:StartMoving()
	end
end

function mgames_minimap_tooltip_Show()
	GameTooltip:SetOwner(this, "ANCHOR_LEFT")
	GameTooltip:ClearLines()
	GameTooltip:SetText("MiniGames")
	GameTooltip:AddLine("Left-click: toggle menue",0.8,0.8,0.8,1)
	GameTooltip:AddLine("Right-click: quick play",0.8,0.8,0.8,1)
	GameTooltip:AddLine("Ctrl + right-click: move button",0.8,0.8,0.8,1)
	GameTooltip:Show()
end

function mgames_dropdown_Initialize()
	mgames_minigames()
	for i = 1, getn(mgames_minigamesliste), 1 do
		local info = {
			text = mgames_minigamesliste[i];
			func = mgames_dropdown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function mgames_dropdown_OnClick()
	i = this:GetID()
	UIDropDownMenu_SetSelectedID(mgames_dropdown, i)
	MinigamesUI.game = i
	if (mgames_minigames_addonloadedliste[MinigamesUI.game] == false) then
		mgames_button1:Disable()
	else
		mgames_button1:Enable()
	end
end

function mgames_checkbox_OnClick()
	MinigamesUI.minimap = mgames_checkbox:GetChecked()
	mgames_minimap_Toggle()
end

function mgames_button3_OnClick()
	if (MinigamesUI.credit == false) then
		mgames_Toggle()
	else
		mgames_Show()
		MinigamesUI.credit = false
	end
end

function mgames_button2_OnClick()
	mgames_credit_Show()
end

function mgames_button1_OnClick()
	mgames_Toggle()
	mgames_game_Go()
end

function mgames_minigames_addonloaded()
	mgames_minigames_addon()
	mgames_minigames_addonloadedliste = {}
	for i=1, table.getn(mgames_minigames_addonliste) do
		if (IsAddOnLoaded(mgames_minigames_addonliste[i])) then
	  		table.insert(mgames_minigames_addonloadedliste, true)
	  	else
	  		table.insert(mgames_minigames_addonloadedliste, false)
		end
	end
end
