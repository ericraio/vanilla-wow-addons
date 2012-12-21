local _G = getfenv(0)
-- Frame multipliers
local FxMult, FyMult = 0.9, 0.84
-- Frame Tab multipliers
local FTxMult, FTyMult = 0.5, 0.75
-- Character subframe names

function oSkin:menuFrames()
	if not self.db.profile.MenuFrames or self.initialized.MenuFrames then return end
	self.initialized.MenuFrames = true
	
	self:hookDDScript(OptionsFrameResolutionDropDownButton)	
	self:hookDDScript(OptionsFrameRefreshDropDownButton)	
	self:hookDDScript(OptionsFrameMultiSampleDropDownButton)	

	self:applySkin(_G["GameMenuFrame"], 1, nil, nil, 100)

--	Video Options
    self:applySkin(_G["OptionsFrame"], 1, nil, nil, 300)

	self:keepRegions(_G["OptionsFrameResolutionDropDown"], {4}) -- N.B. region 4 is text
	self:keepRegions(_G["OptionsFrameRefreshDropDown"], {4}) -- N.B. region 4 is text
	self:keepRegions(_G["OptionsFrameMultiSampleDropDown"], {4}) -- N.B. region 4 is text
    
    self:applySkin(_G["OptionsFrameDisplay"])
	self:applySkin(_G["OptionsFrameWorldAppearance"])
	self:applySkin(_G["OptionsFrameBrightness"])
	self:applySkin(_G["OptionsFramePixelShaders"])
	self:applySkin(_G["OptionsFrameMiscellaneous"])

--	Sound
    self:applySkin(_G["SoundOptionsFrame"], 1, nil, nil, 100)

--	Interface
	self:HookScript(UIOptionsFrameTab1, "OnClick", function()
		self:Debug("UIOFT1_OnClick")
		self.hooks[UIOptionsFrameTab1].OnClick()
		self:moveObject(_G["UIOptionsFrameTab2"], nil, nil, "+", 1)
		end)
	self:HookScript(UIOptionsFrameTab2, "OnClick", function()
		self:Debug("UIOFT2_OnClick")
		self.hooks[UIOptionsFrameTab2].OnClick()
		self:moveObject(_G["UIOptionsFrameTab2"], nil, nil, "-", 1)
		end)
	self:hookDDScript(UIOptionsFrameClickCameraDropDownButton)	
	self:hookDDScript(UIOptionsFrameTargetofTargetDropDownButton)	
	self:hookDDScript(UIOptionsFrameCombatTextDropDownButton)	

	self:keepRegions(_G["UIOptionsFrame"], {1}) -- N.B. region 1 is text
	-- change this to allow Frames to be resized
	_G["UIOptionsFrame"]:SetParent(_G["GameMenuFrame"]:GetParent())

	-- get the title text and move it
	for i,v in ipairs({ _G["UIOptionsFrame"]:GetRegions() }) do
		-- region 1 is the title
		if i == 1  then
			self:moveObject(v, nil, nil, "-", 170)
			break
		end
	end

	-- change these to allow the buttons to work
	_G["UIOptionsFrameDefaults"]:SetFrameStrata(_G["GameMenuFrame"]:GetFrameStrata())
	_G["UIOptionsFrameOkay"]:SetFrameStrata(_G["GameMenuFrame"]:GetFrameStrata())
	_G["UIOptionsFrameCancel"]:SetFrameStrata(_G["GameMenuFrame"]:GetFrameStrata())

	-- find the Close button and move it
	for i,v in ipairs({ _G["UIOptionsFrame"]:GetChildren() }) do
		local point, relativeTo, relativePoint, xOfs, yOfs = v:GetPoint()
		if point == "TOPRIGHT" and relativeTo:GetName() == "BasicOptions" then
			v:SetFrameStrata(_G["GameMenuFrame"]:GetFrameStrata())
			self:moveObject(v, "-", 8, "-", 8)
		end
	end
	
--	BasicOptions
	_G["BasicOptions"]:SetWidth(_G["BasicOptions"]:GetWidth() * 0.95)
	_G["BasicOptions"]:SetHeight(_G["BasicOptions"]:GetHeight() * FyMult)
	self:keepRegions(_G["UIOptionsFrameClickCameraDropDown"], {4}) -- N.B. region 4 is text
	self:applySkin(_G["BasicOptionsGeneral"])
	self:applySkin(_G["BasicOptionsDisplay"])
	self:applySkin(_G["BasicOptionsCamera"])
	self:applySkin(_G["BasicOptionsHelp"])
	self:applySkin(_G["BasicOptions"])
	
--	AdvancedOptions
	_G["AdvancedOptions"]:SetWidth(_G["AdvancedOptions"]:GetWidth() * 0.95)
	_G["AdvancedOptions"]:SetHeight(_G["AdvancedOptions"]:GetHeight() * FyMult)
	self:keepRegions(_G["UIOptionsFrameTargetofTargetDropDown"], {4}) -- N.B. region 4 is text
	self:keepRegions(_G["UIOptionsFrameCombatTextDropDown"], {4}) -- N.B. region 4 is text
	self:applySkin(_G["AdvancedOptionsActionBars"])
	self:applySkin(_G["AdvancedOptionsChat"])
	self:applySkin(_G["AdvancedOptionsRaid"])
	self:applySkin(_G["AdvancedOptionsCombatText"])
	self:applySkin(_G["AdvancedOptions"])
	
	for i = 1, 2 do
		local tabName = _G["UIOptionsFrameTab"..i]
   		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is text, 8 is highlight
		tabName:SetFrameStrata(_G["GameMenuFrame"]:GetFrameStrata())
		tabName:SetHeight(tabName:GetHeight() * FTyMult)
		if i == 2 then 
			self:moveObject(tabName, nil, nil, "+", 1)
		end
		self:moveObject(_G[tabName:GetName().."Text"], nil, nil, "+", 5)
		self:moveObject(_G[tabName:GetName().."HighlightTexture"], nil, nil, "+", 8)
  		self:applySkin(tabName)
  	end

--	Others 
    self:applySkin(_G["ScriptErrors"])
    self:applySkin(_G["ColorPickerFrame"], 1, nil, nil, 100)

	if IsAddOnLoaded("Blizzard_MacroUI") then self:MacroFrame() end
	if IsAddOnLoaded("Blizzard_BindingUI") then self:KeyBindingFrame() end
	
end

function oSkin:MacroFrame()
	if not self.db.profile.MenuFrames or self.initialized.MacroFrame then return end
	self.initialized.MacroFrame = true

	self:keepRegions(_G["MacroFrame"], {6, 9, 10, 11 ,12}) -- N.B. regions 6, 9-12 are text
	_G["MacroFrame"]:SetWidth(_G["MacroFrame"]:GetWidth() * FxMult)
	_G["MacroFrame"]:SetHeight(_G["MacroFrame"]:GetHeight() * FyMult)

	for i = 1, 2 do
		local tabName = _G["MacroFrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is text, 8 is highlight
		self:moveObject(_G[tabName:GetName().."Text"], nil, nil, "+", 5)
		self:moveObject(_G[tabName:GetName().."HighlightTexture"], nil, nil, "+", 8)
		self:applySkin(tabName)
	end
		

	self:moveObject(_G["MacroFrameCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["MacroButton1"], "-", 10, nil, nil)
	self:moveObject(_G["MacroFrameSelectedMacroBackground"], nil, nil, "+", 10)
	self:moveObject(_G["MacroFrameTextBackground"], nil, nil, "+", 10)
	self:moveObject(_G["MacroDeleteButton"], "-", 10, "-", 72)
	self:moveObject(_G["MacroNewButton"], "-", 4, "+", 10)
	self:moveObject(_G["MacroExitButton"], "-", 4, "+", 10)
	self:moveObject(_G["MacroFrameCharLimitText"], nil, nil, "-", 75)
	
	self:skinScrollBar(_G["MacroFrameScrollFrame"])
	self:applySkin(_G["MacroFrameTextBackground"])
	self:applySkin(_G["MacroFrame"])
	
	-- Macro Popup Frame
	self:keepRegions(_G["MacroPopupFrame"], {5, 6}) -- N.B. regions 5 & 6 are text
	_G["MacroPopupFrame"]:SetWidth(_G["MacroPopupFrame"]:GetWidth() * FxMult)
	_G["MacroPopupFrame"]:SetHeight(_G["MacroPopupFrame"]:GetHeight() - 20) -- N.B. must be absolute not multiple
	self:moveObject(_G["MacroPopupFrame"], "+", 40, nil, nil)

	local xOfs, yOfs = 5, 15
	self:moveObject(_G["MacroPopupEditBox"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["MacroPopupScrollFrame"], "+", 10, "+", yOfs)
	self:moveObject(_G["MacroPopupButton1"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["MacroPopupCancelButton"], nil, nil, "-", 4)
	
	for i,v in ipairs({ _G["MacroPopupFrame"]:GetRegions() }) do
		-- regions 5 & 6 are text
		if i == 5  or i == 6 then
			self:moveObject(v, "-", xOfs, "+", yOfs)
		end
	end

	self:removeRegions(_G["MacroPopupScrollFrame"])
	self:skinScrollBar(_G["MacroPopupScrollFrame"])
	self:applySkin(_G["MacroPopupFrame"])
	
end

function oSkin:KeyBindingFrame()
	if not self.db.profile.MenuFrames or self.initialized.KeyBindingFrame then return end
	self.initialized.KeyBindingFrame = true
	
	self:keepRegions(_G["KeyBindingFrame"], {7, 8, 9, 10, 12}) -- N.B. regions 7-10 & 12 are text
	_G["KeyBindingFrame"]:SetWidth(_G["KeyBindingFrame"]:GetWidth() * 0.95)
	-- N.B. Don't change Height
	
	self:moveObject(_G["KeyBindingFrameHeaderText"], nil, nil, "-", 8)
	self:moveObject(_G["KeyBindingFrameCharacterButton"], "+", 30, "+", 5)
	self:moveObject(_G["KeyBindingFrameOutputText"], nil, nil, "-", 10)
	self:moveObject(_G["KeyBindingFrameDefaultButton"], nil, nil, "-", 14)
	self:moveObject(_G["KeyBindingFrameCancelButton"], "+", 40, "-", 14)
	
	self:removeRegions(_G["KeyBindingFrameScrollFrame"])
	self:skinScrollBar(_G["KeyBindingFrameScrollFrame"])
	
	self:applySkin(_G["KeyBindingFrame"])

end

function oSkin:makeModelFramesRotatable()
--[[
[12:55:21] <dreyruugr> http://ace.pastey.net/551
[12:55:42] <dreyruugr> That should do framerate independant rotation of the model, based on how much the mouse moves
[13:12:43] <dreyruugr> Gngsk: http://ace.pastey.net/552 - This doesn't work quite right, but if you work on it you'll be able to zoom in on the character's face using the y offset of the mouse

This does the trick, but it might be worth stealing chester's code from SuperInspect

]]

-- Click to drag Modelframes

	self:Hook("Model_RotateLeft")
	self:Hook("Model_RotateRight")
	self:makeMFRotatable(_G["CharacterModelFrame"])
	self:makeMFRotatable(_G["PetModelFrame"])
	self:makeMFRotatable(_G["DressUpModel"])
	self:makeMFRotatable(_G["PetStableModel"])
	
end

function oSkin:makeMFRotatable(frame)
	--frame:EnableMouseWheel(true)
	frame:EnableMouse(true)
	frame.draggingDirection = nil
	frame.cursorPosition = { }

	frame:SetScript("OnUpdate", function()
		if this.dragging then
			local x,y = GetCursorPosition()
			if this.cursorPosition.x > x then
				Model_RotateLeft(frame, (this.cursorPosition.x - x) * arg1)
			elseif this.cursorPosition.x < x then
				Model_RotateRight(frame, (x - this.cursorPosition.x) * arg1)
			end

			this.cursorPosition.x, this.cursorPosition.y = GetCursorPosition()
		end
	end)

	frame:SetScript("OnMouseDown", function()
		if arg1 == "LeftButton" then
			this.dragging = true
			this.cursorPosition.x, this.cursorPosition.y = GetCursorPosition()
		end
	end)

	frame:SetScript("OnMouseUp", function()
		if this.dragging then
			this.dragging = false
			this.cursorPosition.x, this.cursorPosition.y = nil
		end
	end)

	--[[ MouseWheel to zoom Modelframe - in/out works, but needs to be fleshed out
	frame:SetScript("OnMouseWheel", function()
		local xPos, yPos, zPos = frame:GetPosition() 
		if arg1 == 1 then 
			frame:SetPosition(xPos+00.1, 0, 0)
		else
			frame:SetPosition(xPos-00.1, 0, 0)
		end 
	end) ]]
end

function oSkin:Model_RotateLeft(model, rotationIncrement)
	if ( not rotationIncrement ) then
		rotationIncrement = 0.03
	end
	model.rotation = model.rotation - rotationIncrement
	model:SetRotation(model.rotation)
	--PlaySound("igInventoryRotateCharacter")
end

function oSkin:Model_RotateRight(model, rotationIncrement)
	if ( not rotationIncrement ) then
		rotationIncrement = 0.03
	end
	model.rotation = model.rotation + rotationIncrement
	model:SetRotation(model.rotation)
	--PlaySound("igInventoryRotateCharacter")
end

function oSkin:BankFrame()
	if not self.db.profile.BankFrame or self.initialized.BankFrame then return end
	self.initialized.BankFrame = true

	self:removeRegions(_G["BankFrame"], {1, 2}) -- N.B. regions 3-5 are text

	_G["BankFrame"]:SetWidth(_G["BankFrame"]:GetWidth() * FxMult)
	_G["BankFrame"]:SetHeight(_G["BankFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["BankFrameTitleText"], nil, nil, "-", 35)
	self:moveObject(_G["BankCloseButton"], "+", 28, "+", 6)
	self:moveObject(_G["BankFrameItem1"], "-", 10, nil, nil)
	
	for i,v in ipairs({ _G["BankFrame"]:GetRegions() }) do
		-- regions 4 and 5 hold the slot text
		if i == 4  or i == 5 then
			self:moveObject(v, "+", 10, "-", 40)
		end
	end

	self:moveObject(_G["BankFramePurchaseInfo"], nil, nil, "-", 40)
	self:moveObject(_G["BankFrameMoneyFrame"], nil, nil, "_", 90)

	self:applySkin(_G["BankFrame"])
	
end

function oSkin:MailFrame()
	if not self.db.profile.MailFrame or self.initialized.MailFrame then return end
	self.initialized.MailFrame = true
	
	self:Hook("OpenMail_Update", function()
		self:Debug("OpenMail_Update")
		self.hooks.OpenMail_Update()
		self:moveObject(_G["OpenMailAttachmentText"], nil, nil, "-", 70)
		end)
		
	self:removeRegions(_G["MailFrame"])
	_G["MailFrame"]:SetWidth(_G["MailFrame"]:GetWidth() * FxMult)
	_G["MailFrame"]:SetHeight(_G["MailFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["InboxCloseButton"], "+", 28, "+", 8)
	
-->>--	Inbox Frame	
	self:moveObject(_G["InboxTitleText"], "-", 15, "+", 6)
	self:moveObject(_G["InboxCurrentPage"], nil, nil, "+", 12)
	
	for i = 1, 7 do
		self:removeRegions(_G["MailItem"..i], {2, 3}) -- N.B. regions 1, 4 & 5 are text
	end
	
	local xOfs, yOfs = 5, 20	
	self:moveObject(_G["MailItem1"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["InboxPrevPageButton"], "-", xOfs, "+", yOfs / 2)
	self:moveObject(_G["InboxNextPageButton"], "-", xOfs, "+", yOfs / 2)
		
-->>--	Send Mail Frame
	local xOfs, yOfs = 5, 10	
	self:removeRegions(_G["SendMailFrame"], {4, 5}) -- N.B. regions 1, 2 & 3 are text
	self:moveObject(_G["SendMailTitleText"], "-", 15, "+", 6)	
	self:removeRegions(_G["SendMailScrollFrame"], {3, 4}) -- N.B. regions 1 & 2 are the background
	for _, v in { _G["SendMailScrollFrame"], _G["SendMailNameEditBox"], _G["SendMailCostMoneyFrame"],
				  _G["SendMailPackageButton"], _G["SendMailMoneyFrame"], _G["SendMailCancelButton"] } do
		self:moveObject(v, "-", xOfs, "+", yOfs)
	end
	self:skinScrollBar(_G["SendMailScrollFrame"])
	
-->>--	Open Mail Frame
	self:keepRegions(_G["OpenMailFrame"], {6, 7, 8, 9, 10, 11}) -- N.B. regions 6 - 11 are text
	_G["OpenMailFrame"]:SetWidth(_G["OpenMailFrame"]:GetWidth() * FxMult)
	_G["OpenMailFrame"]:SetHeight(_G["OpenMailFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["OpenMailCloseButton"], "+", 28, "+", 8)
	
	self:moveObject(_G["OpenMailTitleText"], nil, nil, "-", 30)	
	self:moveObject(_G["OpenMailSenderLabel"], "-", 5, "+", 10)
	self:moveObject(_G["OpenMailSubjectLabel"], "-", 5, "+", 10)
	self:moveObject(_G["OpenMailScrollFrame"], "-", 5, "+", 10)	
	self:removeRegions(_G["OpenMailScrollFrame"], {1, 2}) -- N.B. regions 3 & 4 are the background
	self:skinScrollBar(_G["OpenMailScrollFrame"])

	self:moveObject(_G["OpenMailCancelButton"], "+", 30, "-", 72)

	self:applySkin(_G["OpenMailFrame"])
	
-->>--	FrameTabs
	for i = 1, 2 do
		self:keepRegions(_G["MailFrameTab"..i], {7, 8}) -- N.B. region 7 is text, 8 is highlight
		if i == 1 then
			self:moveObject(_G["MailFrameTab"..i], nil, nil, "-", 70)
		else
			self:moveObject(_G["MailFrameTab"..i], "+", 4, nil, nil)
		end
		self:applySkin(_G["MailFrameTab"..i])
	end
	
	self:applySkin(_G["MailFrame"])
	
end

function oSkin:AuctionFrame()
	if not self.db.profile.AuctionFrame or self.initialized.AuctionFrame then return end
	self.initialized.AuctionFrame = true
	
	self:Hook("FilterButton_SetType")
	self:hookDDScript(BrowseDropDownButton)	

-->>--	All Tabs	
	self:removeRegions(_G["AuctionFrame"])
	_G["AuctionFrame"]:SetHeight(_G["AuctionFrame"]:GetHeight() - 6)
	
	self:moveObject(_G["AuctionFrameCloseButton"], "-", 4, "+", 8)

	for i = 1, 3 do
		self:keepRegions(_G["AuctionFrameTab"..i], {7, 8}) -- N.B. region 7 is the Text, 8 is the highlight
		if i == 1 then 
			self:moveObject(_G["AuctionFrameTab"..i], nil, nil, "-", 4)
		else
			self:moveObject(_G["AuctionFrameTab"..i], "+", 3, nil, nil)
		end
		self:applySkin(_G["AuctionFrameTab"..i])
		 
	end
	
	self:moveObject(_G["AuctionFrameMoneyFrame"], nil, nil, "-", 6)
   
-->>--	Browse Frame
	self:moveObject(_G["BrowseTitle"], nil, nil, "+", 6)

	self:removeRegions(_G["BrowseFilterScrollFrame"])
	self:skinScrollBar(_G["BrowseFilterScrollFrame"])
	
	self:removeRegions(_G["BrowseScrollFrame"])
	self:skinScrollBar(_G["BrowseScrollFrame"])
	
	for i=1,15 do
		self:removeRegions(_G["AuctionFilterButton"..i], {1, 2})
		self:applySkin(_G["AuctionFilterButton"..i])
	end
   
	self:removeRegions(_G["BrowseDropDown"], {1, 2, 3}) -- N.B. region 4 is text
	self:moveObject(_G["BrowseDropDownName"], "+", 40, nil, nil)

	for _,v in {_G["BrowseQualitySort"], _G["BrowseLevelSort"], _G["BrowseDurationSort"],
				_G["BrowseHighBidderSort"], _G["BrowseCurrentBidSort"] } do
		self:removeRegions(v, {1, 2, 3})
		self:applySkin(v)
	end
	

-->>--	Bid Frame
	self:moveObject(_G["BidTitle"], nil, nil, "+", 6)
	
	self:removeRegions(_G["BidScrollFrame"])
	self:skinScrollBar(_G["BidScrollFrame"])
		
	for _,v in {_G["BidQualitySort"],_G["BidLevelSort"], _G["BidDurationSort"], _G["BidBuyoutSort"],
				_G["BidStatusSort"], _G["BidBidSort"],} do
		self:removeRegions(v, {1, 2, 3})
		self:applySkin(v)
	end


-->>--	Auctions Frame
	self:moveObject(_G["AuctionsTitle"], nil, nil, "+", 6)
		
	_G["AuctionsItemButton"]:SetWidth(_G["AuctionsItemButton"]:GetWidth() + 10)
	_G["AuctionsItemButton"]:SetHeight(_G["AuctionsItemButton"]:GetHeight() + 10)
	self:applySkin(_G["AuctionsItemButton"])

	self:removeRegions(_G["AuctionsScrollFrame"])
	self:skinScrollBar(_G["AuctionsScrollFrame"])
	
	for _,v in {_G["AuctionsQualitySort"], _G["AuctionsDurationSort"], _G["AuctionsHighBidderSort"], 
				_G["AuctionsBidSort"] } do
		self:removeRegions(v, {1, 2, 3})
		self:applySkin(v)
	end
	
	self:applySkin(_G["AuctionFrame"])
	
-->>--	AuctionDressUpFrame
	
	self:removeRegions(_G["AuctionDressUpFrame"], {1, 2}) --N.B. regions 3 & 4 are the background
	_G["AuctionDressUpFrame"]:SetWidth(_G["AuctionDressUpFrame"]:GetWidth() - 6)
	_G["AuctionDressUpFrame"]:SetHeight(_G["AuctionDressUpFrame"]:GetHeight() - 13)
	self:moveObject(_G["AuctionDressUpBackgroundTop"], nil, nil, "+", 8)

	_G["AuctionDressUpModelRotateLeftButton"]:Hide()
	_G["AuctionDressUpModelRotateRightButton"]:Hide()
	
	self:removeRegions(_G["AuctionDressUpFrameCloseButton"], {2, 3, 4}) -- N.B. region 1 is the button artwork

	self:applySkin(_G["AuctionDressUpFrame"])	

end

function oSkin:FilterButton_SetType(button, type, text, isLast)

	local normalText = getglobal(button:GetName().."NormalText")
	local normalTexture = getglobal(button:GetName().."NormalTexture")
	local line = getglobal(button:GetName().."Lines")

	if ( type == "class" ) then
		button:SetText(text)
		normalText:SetPoint("LEFT", button, "LEFT", 4, 0)
		--normalTexture:SetAlpha(1.0)
		line:Hide()
	elseif ( type == "subclass" ) then
		button:SetText(HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE)
		--button:SetText("|cff007FFF"..text.."|r")
		normalText:SetPoint("LEFT", button, "LEFT", 12, 0)
		--normalTexture:SetAlpha(0.4)
		line:Hide()
	elseif ( type == "invtype" ) then
		button:SetText(HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE)
		normalText:SetPoint("LEFT", button, "LEFT", 20, 0)
		normalTexture:SetAlpha(0.0)
		if ( isLast ) then
			line:SetTexCoord(0.4375, 0.875, 0, 0.625)
		else
			line:SetTexCoord(0, 0.4375, 0, 0.625)
		end
		line:Show()
	end

	button.type = type

end
