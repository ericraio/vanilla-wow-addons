BT2Dreamlayout = Bartender:NewModule("dreamlayout")

local _G = getfenv(0)

function BT2Dreamlayout:OnEnable()
	BT2DL = true
	self:CreateLayout() 
	self:ScheduleRepeatingEvent(self.BGCheck, 0.1, self)
	Bartender:Print("Dreamlayout enabled")
end

function BT2Dreamlayout:CreateLayout()
	for i=1,12 do
		Bartender:CreateFrame("B1B"..i)
		Bartender:CreateFrame("B2B"..i)
		Bartender:CreateFrame("B3B"..i)
		Bartender:CreateFrame("B4B"..i)
		Bartender:CreateFrame("B5B"..i)

		_G["B1B"..i]:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})		_G["B1B"..i]:SetBackdropColor(0,0,0,0.6)		_G["B1B"..i]:SetBackdropBorderColor(0.5, 0.5, 0, 0)		_G["B1B"..i]:SetPoint("TOPLEFT", "Bar1Button"..i, "TOPLEFT", -0.5, 0)		_G["B1B"..i]:SetPoint("BOTTOMRIGHT", "Bar1Button"..i, "BOTTOMRIGHT", 0.5, -0)
		_G["B1B"..i]:SetParent("Bar1")
		_G["B1B"..i]:SetFrameLevel(1)

		_G["B2B"..i]:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})		_G["B2B"..i]:SetBackdropColor(0,0,0,0.6)		_G["B2B"..i]:SetBackdropBorderColor(0.5, 0.5, 0, 0)		_G["B2B"..i]:SetPoint("TOPLEFT", "Bar2Button"..i, "TOPLEFT", -0.5, 0)		_G["B2B"..i]:SetPoint("BOTTOMRIGHT", "Bar2Button"..i, "BOTTOMRIGHT", 0.5, -0)
		_G["B2B"..i]:SetParent("Bar2")
		_G["B2B"..i]:SetFrameLevel(1)

		_G["B3B"..i]:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})		_G["B3B"..i]:SetBackdropColor(0,0,0,0.6)		_G["B3B"..i]:SetBackdropBorderColor(0.5, 0.5, 0, 0)		_G["B3B"..i]:SetPoint("TOPLEFT", "Bar3Button"..i, "TOPLEFT", -0.5, 0)		_G["B3B"..i]:SetPoint("BOTTOMRIGHT", "Bar3Button"..i, "BOTTOMRIGHT", 0.5, -0)
		_G["B3B"..i]:SetParent("Bar3")
		_G["B3B"..i]:SetFrameLevel(1)

		_G["B4B"..i]:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})		_G["B4B"..i]:SetBackdropColor(0,0,0,0.6)		_G["B4B"..i]:SetBackdropBorderColor(0.5, 0.5, 0, 0)		_G["B4B"..i]:SetPoint("TOPLEFT", "Bar4Button"..i, "TOPLEFT", -0.5, 0)		_G["B4B"..i]:SetPoint("BOTTOMRIGHT", "Bar4Button"..i, "BOTTOMRIGHT", 0.5, -0)
		_G["B4B"..i]:SetParent("Bar4")
		_G["B4B"..i]:SetFrameLevel(1)

		_G["B5B"..i]:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})		_G["B5B"..i]:SetBackdropColor(0,0,0,0.6)		_G["B5B"..i]:SetBackdropBorderColor(0.5, 0.5, 0, 0)		_G["B5B"..i]:SetPoint("TOPLEFT", "Bar5Button"..i, "TOPLEFT", -0.5, 0)		_G["B5B"..i]:SetPoint("BOTTOMRIGHT", "Bar5Button"..i, "BOTTOMRIGHT", 0.5, -0)
		_G["B5B"..i]:SetParent("Bar5")
		_G["B5B"..i]:SetFrameLevel(1)

		_G["Bar1Button"..i.."Icon"]:ClearAllPoints()		_G["Bar1Button"..i.."Icon"]:SetPoint("TOPLEFT", "B1B"..i, "TOPLEFT", 3, -3)		_G["Bar1Button"..i.."Icon"]:SetPoint("BOTTOMRIGHT", "B1B"..i, "BOTTOMRIGHT", -3, 3)

		_G["Bar2Button"..i.."Icon"]:ClearAllPoints()		_G["Bar2Button"..i.."Icon"]:SetPoint("TOPLEFT", "B2B"..i, "TOPLEFT", 3, -3)		_G["Bar2Button"..i.."Icon"]:SetPoint("BOTTOMRIGHT", "B2B"..i, "BOTTOMRIGHT", -3, 3)

		_G["Bar3Button"..i.."Icon"]:ClearAllPoints()		_G["Bar3Button"..i.."Icon"]:SetPoint("TOPLEFT", "B3B"..i, "TOPLEFT", 3, -3)		_G["Bar3Button"..i.."Icon"]:SetPoint("BOTTOMRIGHT", "B3B"..i, "BOTTOMRIGHT", -3, 3)

		_G["Bar4Button"..i.."Icon"]:ClearAllPoints()		_G["Bar4Button"..i.."Icon"]:SetPoint("TOPLEFT", "B4B"..i, "TOPLEFT", 3, -3)		_G["Bar4Button"..i.."Icon"]:SetPoint("BOTTOMRIGHT", "B4B"..i, "BOTTOMRIGHT", -3, 3)

		_G["Bar5Button"..i.."Icon"]:ClearAllPoints()		_G["Bar5Button"..i.."Icon"]:SetPoint("TOPLEFT", "B5B"..i, "TOPLEFT", 3, -3)		_G["Bar5Button"..i.."Icon"]:SetPoint("BOTTOMRIGHT", "B5B"..i, "BOTTOMRIGHT", -3, 3)

	end

	for i=1,10 do
		Bartender:CreateFrame("B6B"..i)
		Bartender:CreateFrame("B7B"..i)

		_G["B6B"..i]:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})		_G["B6B"..i]:SetBackdropColor(0,0,0,0.6)		_G["B6B"..i]:SetBackdropBorderColor(0.5, 0.5, 0, 0)		_G["B6B"..i]:SetPoint("TOPLEFT", "Bar6Button"..i, "TOPLEFT", -0.5, 0)		_G["B6B"..i]:SetPoint("BOTTOMRIGHT", "Bar6Button"..i, "BOTTOMRIGHT", 0.5, -0)
		_G["B6B"..i]:SetParent("Bar6")
		_G["B6B"..i]:SetFrameLevel(1)

		_G["B7B"..i]:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})		_G["B7B"..i]:SetBackdropColor(0,0,0,0.6)		_G["B7B"..i]:SetBackdropBorderColor(0.5, 0.5, 0, 0)		_G["B7B"..i]:SetPoint("TOPLEFT", "Bar7Button"..i, "TOPLEFT", -0.5, 0)		_G["B7B"..i]:SetPoint("BOTTOMRIGHT", "Bar7Button"..i, "BOTTOMRIGHT", 0.5, -0)
		_G["B7B"..i]:SetParent("Bar7")
		_G["B7B"..i]:SetFrameLevel(1)

		_G["Bar6Button"..i.."Icon"]:ClearAllPoints()		_G["Bar6Button"..i.."Icon"]:SetPoint("TOPLEFT", "B6B"..i, "TOPLEFT", 3, -3)		_G["Bar6Button"..i.."Icon"]:SetPoint("BOTTOMRIGHT", "B6B"..i, "BOTTOMRIGHT", -3, 3)

		_G["Bar7Button"..i.."Icon"]:ClearAllPoints()		_G["Bar7Button"..i.."Icon"]:SetPoint("TOPLEFT", "B7B"..i, "TOPLEFT", 3, -3)		_G["Bar7Button"..i.."Icon"]:SetPoint("BOTTOMRIGHT", "B7B"..i, "BOTTOMRIGHT", -3, 3)
	end

    for i=1,5 do
        Bartender:CreateFrame("B8B"..i)

        _G["B8B"..i]:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 1, edgeFile = "", edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0},})
        _G["B8B"..i]:SetBackdropColor(0,0,0,0.6)
        _G["B8B"..i]:SetBackdropBorderColor(0.5, 0.5, 0, 0)
        _G["B8B"..i]:SetPoint("TOPLEFT", "Bar8Button"..i, "TOPLEFT", -0.5, 0)
        _G["B8B"..i]:SetPoint("BOTTOMRIGHT", "Bar8Button"..i, "BOTTOMRIGHT", 0.5, -0)
        _G["B8B"..i]:SetParent("Bar8")
        _G["B8B"..i]:SetFrameLevel(1)

        _G["Bar8Button"..i.."Icon"]:ClearAllPoints()
        _G["Bar8Button"..i.."Icon"]:SetPoint("TOPLEFT", "B8B"..i, "TOPLEFT", 3, -3)
        _G["Bar8Button"..i.."Icon"]:SetPoint("BOTTOMRIGHT", "B8B"..i, "BOTTOMRIGHT", -3, 3)
    end
end

function BT2Dreamlayout:BGCheck()
	for i=1,12 do		local buttons1 = _G["Bar1Button"..i]		local buttons2 = _G["Bar2Button"..i]		local buttons3 = _G["Bar3Button"..i]		local buttons4 = _G["Bar4Button"..i]		local buttons5 = _G["Bar5Button"..i]		local background1 = _G["B1B"..i]		local background2 = _G["B2B"..i]		local background3 = _G["B3B"..i]		local background4 = _G["B4B"..i]		local background5 = _G["B5B"..i]		if ( not HasAction(ActionButton_GetPagedID(buttons1)) ) then			background1:Hide()
		else
			background1:Show()
		end		if ( not HasAction(ActionButton_GetPagedID(buttons2)) ) then			background2:Hide()
		else
			background2:Show()
		end		if ( not HasAction(ActionButton_GetPagedID(buttons3)) ) then			background3:Hide()
		else
			background3:Show()
		end		if ( not HasAction(ActionButton_GetPagedID(buttons4)) ) then			background4:Hide()
		else
			background4:Show()
		end		if ( not HasAction(ActionButton_GetPagedID(buttons5)) ) then			background5:Hide()
		else
			background5:Show()
		end	end

	amountofshapes = GetNumShapeshiftForms()
	for i=1,amountofshapes do
		local background6 = getglobal("B6B"..i)
		background6:Show()
	end
	emptyshape = amountofshapes + 1
	for i=emptyshape,10 do
		local background6 = getglobal("B6B"..i)
		background6:Hide()
	end

	for i = 1, 10 do 
		if (GetPetActionInfo(i)) then 
	        local background7 = getglobal("B7B"..i)
	        background7:Show()
		elseif (not GetPetActionInfo(i)) then
	        local background7 = getglobal("B7B"..i)
	        background7:Hide()
		end
	end
	Bartender:HideNormalTexture()
end
