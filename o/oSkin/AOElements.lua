local _G = getfenv(0)
-- Frame multipliers
local FxMult, FyMult = 0.9, 0.84
-- Frame Tab multipliers
local FTxMult, FTyMult = 0.5, 0.75
-- Character subframe names

function oSkin:Skin_OneBag()
	if not self.db.profile.ContainerFrames or self.initialized.OneBag then return end
	self.initialized.OneBag = true

	self:applySkin(_G["OneBagFrame"], nil, nil, _G["OneBag"].db.profile.colors.bground.a, 200)
	if _G["OneRingFrame"] then self:applySkin(_G["OneRingFrame"], nil, nil, _G["OneRing"].db.profile.colors.bground.a, 100) end
	if _G["OneViewFrame"] then self:applySkin(_G["OneViewFrame"], nil, nil, _G["OneView"].db.profile.colors.bground.a, 200) end

end

function oSkin:Skin_OneBank()
	if not self.db.profile.BankFrame or self.initialized.OneBank then return end
	self.initialized.OneBank = true

	self:applySkin(_G["OneBankFrame"], nil, nil, _G["OneBank"].db.profile.colors.bground.a, 300) 

end

function oSkin:EnhancedStackSplit()
	if not self.db.profile.StackSplit then return end

	_G["StackSplitFrame"]:SetHeight(_G["StackSplitFrame"]:GetHeight() + 40)

	self:moveObject(_G["StackSplitText"], nil, nil, "+", 20)	
	self:moveObject(_G["StackSplitLeftButton"], "+", 5, "+", 20)	
	self:moveObject(_G["StackSplitRightButton"], "-", 5, "+", 20)	
	self:moveObject(_G["StackSplitOkayButton"], nil, nil, "+", 36)	
	self:moveObject(_G["StackSplitCancelButton"], nil, nil, "+", 36)	

	self:removeRegions(_G["EnhancedStackSplitFrame"], {1})

	for i = 1, 6 do
		self:moveObject(_G["EnhancedStackSplitButton"..i], "-", 6, "+", 24)	
	end

	self:moveObject(_G["EnhancedStackSplitMaxTextFrame"], nil, nil, "+", 20)
	self:moveObject(_G["EnhancedStackSplitModeTXTButton"], "-", 5, "+", 22)
	
end

function oSkin:GMail()
	if not self.db.profile.MailFrame then return end
	
	self:keepRegions(_G["MailFrameTab3"], {7, 8}) -- N.B. region 7 is text, 8 is highlight
	self:moveObject(_G["MailFrameTab3"], "+", 4, nil, nil)
	self:applySkin(_G["MailFrameTab3"])
	
	self:moveObject(_G["GMailInboxOpenSelected"], "-", 20, "+", 5)
	self:moveObject(_G["GMailInboxOpenAllButton"], "-", 20, "+", 5)

	--	reset MailItem1 position
	self:moveObject(_G["MailItem1"], "-", 5, "-", 5)
	
	-- skin the frame
	self:removeRegions(_G["GMailFrame"], {4, 5}) -- N.B. regions 1, 2 & 3 are text
	_G["GMailFrame"]:SetWidth(_G["GMailFrame"]:GetWidth() * FxMult)
	_G["GMailFrame"]:SetHeight(_G["GMailFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["GMailTitleText"], "+", 5, "-", 35)
	self:moveObject(_G["GMailNameEditBox"], "-", 5, "+", 10)
	self:moveObject(_G["GMailCostMoneyFrame"], "+", 40, "+", 10)
	self:moveObject(_G["GMailMoneyFrame"], "-", 5, "-", 72)
	self:moveObject(_G["GMailCancelButton"], "+", 34, "-", 72)
	self:applySkin(_G["GMailFrame"])

	-- skin the accept send frame
	self:keepRegions(_G["GMailAcceptSendFrame"], {11, 12, 13, 14})-- N.B. regions 11 - 14 are text
	self:applySkin(_G["GMailAcceptSendFrame"], 1)

	self:moveObject(_G["GMailStatusText"], nil, nil, "-", 65)
	self:moveObject(_G["GMailAbortButton"], nil, nil, "-", 70)
	
	self:moveObject(_G["GMailButton1"], "-", 10, "+", 20)
	
	-- skin the OpenAll frame
	self:keepRegions(_G["GMailInboxOpenAll"], {11, 12, 13, 14})-- N.B. regions 11 - 14 are text
	self:applySkin(_G["GMailInboxOpenAll"], 1)
	
end

function oSkin:ViewPort()
	if not self.db.profile.ViewPort.shown or self.initialized.ViewPort then return end
	self.initialized.ViewPort = true

	WorldFrame:SetPoint("TOPLEFT", 0, -(self.db.profile.ViewPort.top * self.db.profile.ViewPort.scaling))
	WorldFrame:SetPoint("BOTTOMRIGHT", -0, (self.db.profile.ViewPort.bottom * self.db.profile.ViewPort.scaling))
	
end

function oSkin:ViewPort_top()
	if not self.db.profile.ViewPort.shown then return end

	WorldFrame:SetPoint("TOPLEFT", 0, -(self.db.profile.ViewPort.top * self.db.profile.ViewPort.scaling))
	
end

function oSkin:ViewPort_bottom()
	if not self.db.profile.ViewPort.shown then return end

	WorldFrame:SetPoint("BOTTOMRIGHT", -0, (self.db.profile.ViewPort.bottom * self.db.profile.ViewPort.scaling))
	
end

function oSkin:ViewPort_reset()

	self.initialized.ViewPort = nil
    WorldFrame:SetPoint("TOPLEFT", 0, -0)
	WorldFrame:SetPoint("BOTTOMRIGHT", -0, 0)
	
end

function oSkin:TopFrame()
	if not self.db.profile.TopFrame.shown or self.initialized.TopFrame then return end
	self.initialized.TopFrame = true

	local frame = CreateFrame("Frame", "TopFrame", UIParent)
	frame:SetFrameStrata("BACKGROUND")
	frame:SetFrameLevel(0)
	frame:EnableMouse(false)
	frame:SetMovable(false)
	frame:SetWidth(self.db.profile.TopFrame.width or 1920)
	frame:SetHeight(self.db.profile.TopFrame.height or 100)
	frame:ClearAllPoints()
	if self.db.profile.TopFrame.xyOff then 
		frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -6, 6)
	else
		frame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -3, 3)
	end
	self.topframe = frame
	
	oSkin:applySkin(frame, 1, nil, nil, self.db.profile.TopFrame.fheight)
	
end

function oSkin:BottomFrame()
	if not self.db.profile.BottomFrame.shown or self.initialized.BottomFrame then return end
	  self.initialized.BottomFrame = true

	local frame = CreateFrame("Frame", "BottomFrame", UIParent)
	frame:SetFrameStrata("BACKGROUND")
	frame:SetFrameLevel(0)
	frame:EnableMouse(false)
	frame:SetMovable(false)
	frame:SetWidth(self.db.profile.BottomFrame.width or 1920)
	frame:SetHeight(self.db.profile.BottomFrame.height or 200)
	frame:ClearAllPoints()
	if self.db.profile.TopFrame.xyOff then 
		frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -6, -6)
	else
		frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", -3, -3)
	end
	
	self.bottomframe = frame
	
	oSkin:applySkin(frame, 1, nil, nil, self.db.profile.BottomFrame.fheight)

end

function oSkin:SuperInspectFrame()
	if not self.db.profile.Inspect or self.initialized.SuperInspect then return end
	self.initialized.SuperInspect = true
	
	self:removeRegions(_G["SuperInspectFrameHeader"], {1, 2, 3, 4})
	self:removeRegions(_G["SuperInspect_ItemBonusesFrame"], {1})
	self:removeRegions(_G["SuperInspect_COHBonusesFrame"], {1})
	self:removeRegions(_G["SuperInspect_USEBonusesFrame"], {1})
	self:removeRegions(_G["SuperInspect_SnTBonusesFrame"], {1})
	
	self:removeRegions(_G["SuperInspect_HonorFrame"], {1})
	self:glazeStatusBar(_G["SuperInspect_HonorFrameProgressBar"], -2)
	
	self:removeRegions(_G["SuperInspect_ItemBonusesFrameCompare"], {1})
	
	self:removeRegions(_G["SuperInspect_Button_ShowHonor"], {2, 4})
	self:removeRegions(_G["SuperInspect_Button_ShowBonuses"], {2, 4})
	self:removeRegions(_G["SuperInspect_Button_ShowMobInfo"], {2, 4})
	self:removeRegions(_G["SuperInspect_Button_ShowItems"], {2, 4})
	
	-- Hide frames we don't need
	_G["SuperInspect_BackgroundTopLeft"]:Hide()
	_G["SuperInspect_BackgroundTopRight"]:Hide()
	_G["SuperInspect_BackgroundBotLeft"]:Hide()
	_G["SuperInspect_BackgroundBotRight"]:Hide()
	
	-- Resize
	_G["SuperInspectFrameHeader"]:SetWidth(SuperInspectFrameHeader:GetWidth()-20)
	_G["SuperInspectFrameHeader"]:SetHeight(SuperInspectFrameHeader:GetHeight()-62)
	
	-- Reposition
	_G["SuperInspectFrameHeader_CloseButton"]:ClearAllPoints()
	
	_G["SuperInspectFrameHeader_CloseButton"]:SetPoint("CENTER", _G["SuperInspectFrame"], "TOPRIGHT", -20, -20)
	
	-- Skin
	self:applySkin(_G["SuperInspectFrame"])
	self:applySkin(_G["SuperInspect_ItemBonusesFrame"], nil, 0.6, 0.6)
	self:applySkin(_G["SuperInspect_COHBonusesFrame"], nil, 0.6, 0.6)
	self:applySkin(_G["SuperInspect_USEBonusesFrame"], nil, 0.6, 0.6)
	self:applySkin(_G["SuperInspect_SnTBonusesFrame"], nil, 0.6, 0.6)
	
	self:applySkin(_G["SuperInspect_HonorFrame"])
	
	self:applySkin(_G["SuperInspect_ItemBonusesFrameCompare"])
	
	self:applySkin(_G["SuperInspect_BonusFrameParentTab1"])
	self:applySkin(_G["SuperInspect_BonusFrameParentTab2"])
	self:applySkin(_G["SuperInspect_BonusFrameParentTab3"])
	self:applySkin(_G["SuperInspect_BonusFrameParentTab4"])
	
	self:applySkin(_G["SuperInspect_Button_ShowHonor"])
	self:applySkin(_G["SuperInspect_Button_ShowBonuses"])
	self:applySkin(_G["SuperInspect_Button_ShowMobInfo"])
	self:applySkin(_G["SuperInspect_Button_ShowItems"])
	
	_G["SuperInspectFramePortrait"]:SetAlpha(0)
	
end

function oSkin:CTRA()
	if not self.db.profile.FriendsFrame then return end

	self:hookDDScript(CT_RAMenuFrameGeneralDisplayHealthDropDownButton)	
	self:hookDDScript(CT_RAMenuFrameGeneralMiscDropDownButton)	
	self:hookDDScript(CT_RAMenuFrameBuffsBuffsDropDownButton)	

	self:moveObject(_G["CT_RAOptionsButton"], "-", 40, "+", 10)
	self:moveObject(_G["CT_RACheckAllGroups"], "-", 40, "+", 10)
	self:moveObject(_G["CT_RAOptionsFrameCheckAllGroupsText"], "-", 40, "+", 10)
	self:moveObject(_G["CT_RAOptionsGroup1"], "-", 7, "+", 8)

	self:removeRegions(_G["CT_RAMenuFrame"], {1, 2, 3, 4, 5, 6, 7}) -- N.B. region 8 is text
	self:moveObject(_G["CT_RAMenuFrameHeader"], nil, nil, "-", 8)
	self:moveObject(_G["CT_RAMenuFrameCloseButton"], "+", 40, "+", 2)
	self:applySkin(_G["CT_RAMenuFrame"])
	
	self:removeRegions(_G["CT_RAMenuFrameGeneralDisplayHealthDropDown"], {1, 2, 3}) -- N.B. region 4 is text
	self:removeRegions(_G["CT_RAMenuFrameGeneralMiscDropDown"], {1, 2, 3}) -- N.B. region 4 is text
	self:removeRegions(_G["CT_RAMenuFrameBuffsBuffsDropDown"], {1, 2, 3}) -- N.B. region 4 is text

-->>--	Debuff Frame
	for _, n in {"NameEB", "DebuffTitleEB", "DebuffTypeEB", "DebuffDescriptEB" } do
		self:removeRegions(_G["CT_RAMenuFrameDebuffSettings"..n], {6, 7, 8}) -- N.B. regions 1-5 are text/scripts
	  	self:moveObject(_G["CT_RAMenuFrameDebuffSettings"..n], "+", 5, "+", 0)  
		local left, right, top, bottom = _G["CT_RAMenuFrameDebuffSettings"..n]:GetTextInsets()
		_G["CT_RAMenuFrameDebuffSettings"..n]:SetTextInsets(left + 5, right + 5, top, bottom)
		_G["CT_RAMenuFrameDebuffSettings"..n]:SetWidth(_G["CT_RAMenuFrameDebuffSettings"..n]:GetWidth() + 10)
		self:applySkin(_G["CT_RAMenuFrameDebuffSettings"..n])
	end
	
	self:skinScrollBar(_G["CT_RAMenuFrameDebuffUseScrollFrame"])
	
-->>--	Priority Frame	
	self:removeRegions(_G["CT_RA_PriorityFrame"], {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}) -- N.B. regions 12 & 13 are text
	self:moveObject(_G["CT_RA_PriorityFrameTitle"], nil, nil, "-", 8)
	self:applySkin(_G["CT_RA_PriorityFrame"])
	
	self:removeRegions(_G["CT_RAMenu_NewSetFrame"], {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}) -- N.B. regions 11-13 are text
	self:moveObject(_G["CT_RAMenu_NewSetFrameTitle"], nil, nil, "-", 8)
	self:applySkin(_G["CT_RAMenu_NewSetFrame"])

-->>--	Option Sets Frame	
	self:removeRegions(_G["CT_RAMenu_NewSetFrameNameEB"], {6, 7, 8}) -- N.B. regions 1-5 are text/scripts
  	self:moveObject(_G["CT_RAMenu_NewSetFrameNameEB"], "+", 5, "-", 10)  
    local left, right, top, bottom = _G["CT_RAMenu_NewSetFrameNameEB"]:GetTextInsets()
    _G["CT_RAMenu_NewSetFrameNameEB"]:SetTextInsets(left + 5, right + 5, top, bottom)
    _G["CT_RAMenu_NewSetFrameNameEB"]:SetWidth(_G["CT_RAMenu_NewSetFrameNameEB"]:GetWidth() + 10)
    self:applySkin(_G["CT_RAMenu_NewSetFrameNameEB"])
	
end

function oSkin:FramesResized_TradeSkillUI()
	if not self.db.profile.TradeSkill then return end

	self:removeRegions(_G["TradeSkillFrame_MidTextures"])
	self:removeRegions(_G["TradeSkillListScrollFrame_MidTextures"])   
	
	self:removeRegions(_G["TradeSkillDetailScrollFrame"])
	self:moveObject(_G["TradeSkillDetailScrollFrame"], "-", 5, nil, nil)
	self:skinScrollBar(_G["TradeSkillDetailScrollFrame"])
	
	self:moveObject(_G["TradeSkillCreateButton"], "-", 10, "-", 70)
	self:moveObject(_G["TradeSkillCancelButton"], "-", 7, "-", 70)
	
end

function oSkin:FramesResized_CraftUI()
	if not self.db.profile.CraftFrame then return end
	
	self:removeRegions(_G["CraftFrame_MidTextures"])
	self:removeRegions(_G["CraftListScrollFrame_MidTextures"])   
	
	self:moveObject(_G["CraftCreateButton"], "-", 10, "-", 70)
	self:moveObject(_G["CraftCancelButton"], "-", 10, "-", 70)
	
end

function oSkin:FramesResized_QuestLog()
	if not self.db.profile.QuestLog then return end
	
	self:removeRegions(_G["QuestLogFrame_MidTextures"])

end

function oSkin:Skin_EnhancedTradeSkills() 
	if not self.db.profile.TradeSkill then return end

	self:moveObject(_G["ETS_FILTERSONOFF"], "-", 20, nil, nil)
	
end

function oSkin:Skin_EnhancedTradeCrafts() 
	if not self.db.profile.CraftFrame then return end
	
	self:moveObject(_G["ETS_CFILTERSONOFF"], "-", 10, "-", 72)
	
end

function oSkin:AutoProfit()
	if not self.db.profile.MerchantFrames then return end
	
	self:moveObject(_G["TreasureModel"], nil, nil, "+", 28)
	self:moveObject(_G["AutosellButton"], nil, nil, "+", 28)

end

function oSkin:FuBar_GarbageFu()
	if not self.db.profile.MerchantFrames then return end
	
	self:moveObject(_G["GarbageFu_SellItemButton"], nil, nil, "+", 28)

end

function oSkin:GFW_AutoCraft()
	if not self.db.profile.TradeSkill then return end

	_G["TradeSkillFrame"]:SetHeight(_G["TradeSkillFrame"]:GetHeight() + 40)
	self:removeRegions(_G["AutoCraftBackground"])

end

function oSkin:MetaMap()
	if not self.db.profile.WorldMap then return end

	self:hookDDScript(MetaMapFrameDropDownButton)	

	self:Hook("MetaMapMenu_OnShow", function(mode)
		self.hooks.MetaMapMenu_OnShow(mode)
		self:keepRegions(_G["MetaMapMenu"], {1}) -- N.B. region 1 is text
		self:applySkin(_G["MetaMapMenu"])
		end)
		
	for i = 1, 6 do
		local tabName = _G["MetaMap_DialogFrameTab"..i]	
		self:HookScript(tabName, "OnShow", function()
			self:Debug(tabName:GetName().."OnShow")
			self.hooks[tabName].OnShow()
			tabName:SetWidth(tabName:GetWidth() * 0.85)
			end)
	end

	self:keepRegions(_G["MetaMapFrameDropDown"], {4}) -- N.B. region 4 is text
	self:moveObject(_G["WorldMapFrameCloseButton"], "-", 10, "-", 5)
	self:applySkin(_G["MetaMapTopFrame"])

	self:moveObject(_G["MetaMapSliderMenu"], nil, nil, "-", 10)
	self:applySkin(_G["MetaMapSliderMenu"])
		
	for i = 1, 6 do
		local tabName = _G["MetaMap_DialogFrameTab"..i]
		self:keepRegions(tabName, {7}) -- N.B. region 7 is text
		tabName:SetHeight(tabName:GetHeight() * (FTyMult + FTyMult))
		if i == 1 then 
			self:moveObject(tabName, nil, nil, "_", 8) 
		else
			self:moveObject(tabName, "+", 15, nil, nil) 
		end
		self:applySkin(tabName)
	end

	self:moveObject(_G["MetaMap_CloseButton"], nil, nil, "_", 2)

	self:applySkin(_G["MetaMap_DialogFrame"], 1)

end

function oSkin:LootLink() 

	self:hookDDScript(LootLinkFrameDropDownButton)
	self:hookDDScript(LLS_BindsDropDownButton)
	self:hookDDScript(LLS_RarityDropDownButton)
	self:hookDDScript(LLS_LocationDropDownButton)
	self:hookDDScript(LLS_TypeDropDownButton)
	self:hookDDScript(LLS_SubtypeDropDownButton)
	self:hookDDScript(LLO_RarityDropDownButton)
	
--	self:moveObject(_G["LootLinkTitleText"], "+", 100, "+", 300)

--	self:removeRegions(_G["LootLinkUpdateFrame"])
	self:removeRegions(_G["LootLinkFrame"], {2, 3, 4, 5})
--	self:removeRegions(_G["LootLinkHighlightFrame"])

	_G["LootLinkFrame"]:SetWidth(_G["LootLinkFrame"]:GetWidth() - 30)
	_G["LootLinkFrame"]:SetHeight(_G["LootLinkFrame"]:GetHeight() - 70)

	self:moveObject(_G["LootLinkFrameCloseButton"], "+", 15, nil, nil)
	self:moveObject(_G["LootLinkTitleText"], "+", 15, nil, nil)

	self:removeRegions(_G["LootLinkListScrollFrame"])
	self:skinScrollBar(_G["LootLinkListScrollFrame"])

	self:skinTooltip(LootLinkTooltip)
	self:skinTooltip(LLHiddenTooltip)

	self:applySkin(_G["LootLinkFrame"], {2, 3, 4, 5})
--	self:applySkin(_G["LootLinkHighlightFrame"])
	self:applySkin(_G["LootLinkSearchFrame"])
	self:applySkin(_G["LootLinkOptionsFrame"])	
--	self:applySkin(_G["LootLinkUpdateFrame"])

end

function oSkin:Possessions() 

	self:hookDDScript(Possessions_CharDropDownButton)
	self:hookDDScript(Possessions_LocDropDownButton)
	self:hookDDScript(Possessions_SlotDropDownButton)
	
	self:removeRegions(_G["Possessions_IC_ScrollFrame"])
	self:skinScrollBar(_G["Possessions_IC_ScrollFrame"])
	
	self:applySkin(_G["Possessions_Frame"])

end

function oSkin:EQL3Frame()
	if not self.db.profile.QuestLog or self.initialized.QuestLog then return end
	self.initialized.QuestLog = true
	
	self:Hook("QuestLog_UpdateQuestDetails", function(doNotScroll)
		self:Debug("QuestLog_UpdateQuestDetails")
		self.hooks.QuestLog_UpdateQuestDetails(doNotScroll)
		for i = 1, 10 do
		    local r, g, b, a = _G["EQL3_QuestLogObjective"..i]:GetTextColor()
		    _G["EQL3_QuestLogObjective"..i]:SetTextColor(0.7 - r, 0.7 - g, 0)
		end
		local r, g, b, a = _G["EQL3_QuestLogRequiredMoneyText"]:GetTextColor()
		_G["EQL3_QuestLogRequiredMoneyText"]:SetTextColor(0.7 - r, 0.7 - g, 0)
		_G["EQL3_QuestLogRewardTitleText"]:SetTextColor(0.8,0.8,0)
		_G["EQL3_QuestLogItemChooseText"]:SetTextColor(0.7,0.7,0)
		_G["EQL3_QuestLogItemReceiveText"]:SetTextColor(0.7,0.7,0)
		end)
	
	self:removeRegions(_G["EQL3_QuestLogFrame"])
	self:removeRegions(_G["EQL3_QuestLogFrame_Description"])
	self:keepRegions(_G["EQL3_QuestLogFrame_Details"], {1,2,6})
	self:removeRegions(_G["EQL3_QuestFrameOptionsButton"],{2,4})
	self:removeRegions(_G["EQL3_QuestFramePushQuestButton"],{2,4})
	self:removeRegions(_G["EQL3_QuestLogFrameAbandonButton"],{2,4})
	self:removeRegions(_G["EQL3_QuestLogDetailScrollFrame"])
	
	self:moveObject(_G["EQL3_QuestLogFrameCloseButton"], "+", 25, nil, nil)
	self:moveObject(_G["EQL3_QuestLogFrameAbandonButtonText"], nil, nil, "+", 2)
	self:moveObject(_G["EQL3_QuestFramePushQuestButtonText"], nil, nil, "+", 2)
	self:moveObject(_G["EQL3_QuestFrameOptionsButtonText"], nil, nil, "+", 2)
	self:moveObject(_G["EQL3_QuestLogDetailScrollFrame"], "+", 40, nil, nil)
	
	_G["EQL3_QuestLogFrame_Description"]:SetWidth(_G["EQL3_QuestLogFrame_Description"]:GetWidth() + 40)
	_G["EQL3_QuestLogFrame"]:SetWidth(_G["EQL3_QuestLogFrame"]:GetWidth() - 20)
	
	_G["EQL3_QuestLogTitleText"]:ClearAllPoints()
	_G["EQL3_QuestLogTitleText"]:SetPoint("TOPLEFT", _G["EQL3_QuestLogFrame"], "TOPLEFT", 15, -10)
	
	_G["EQL3_QuestLogVersionText"]:ClearAllPoints()
	_G["EQL3_QuestLogVersionText"]:SetPoint("TOPLEFT", _G["EQL3_QuestLogTitleText"], "TOPRIGHT", -100, 0)
	
	_G["EQL3_QuestLogQuestCount"]:ClearAllPoints()
	_G["EQL3_QuestLogQuestCount"]:SetPoint("TOPLEFT", _G["EQL3_QuestLogTrackTitle"], "TOPRIGHT", 40, 0)
	
	
	_G["EQL3_QuestLogQuestTitle"]:SetTextColor(0.8,0.8,0)
	_G["EQL3_QuestLogObjectivesText"]:SetTextColor(0.7,0.7,0)
	_G["EQL3_QuestLogDescriptionTitle"]:SetTextColor(0.8,0.8,0)
	_G["EQL3_QuestLogQuestDescription"]:SetTextColor(0.7,0.7,0)
	
	self:skinScrollBar(_G["EQL3_QuestLogListScrollFrame"])
	self:skinScrollBar(_G["EQL3_QuestLogDetailScrollFrame"])
	
	self:applySkin(_G["EQL3_QuestLogFrame"])
	self:applySkin(_G["EQL3_QuestFrameOptionsButton"])
	self:applySkin(_G["EQL3_QuestFramePushQuestButton"])
	self:applySkin(_G["EQL3_QuestLogFrameAbandonButton"])
	self:applySkin(_G["EQL3_QuestLogFrame_Description"])
	
    self:removeRegions(_G["EQL3_OptionsFrame"], {1}) --  region 2 is the title
    self:removeRegions(_G["EQL3_OptionsFrame_Button_RestoreColors"],{2,4})
    self:removeRegions(_G["EQL3_OptionsFrame_Button_RestoreTracker"],{2,4})
    self:removeRegions(_G["EQL3_OptionsFrame_Button_QuestLog"],{2,4})
    
    self:applySkin(_G["EQL3_OptionsFrame"])
    self:applySkin(_G["EQL3_OptionsFrame_Button_RestoreColors"])
    self:applySkin(_G["EQL3_OptionsFrame_Button_RestoreTracker"])
    self:applySkin(_G["EQL3_OptionsFrame_Button_QuestLog"])
    
end

function oSkin:BattleChat() 

	self:applySkin(_G["BattleChat"].frame)
	BattleChat.frame:SetBackdropColor(0, 0, 0, BattleChat.db.profile.alpha * 0.01)
	BattleChat.frame:SetBackdropBorderColor(0, 0, 0, BattleChat.db.profile.alpha * 0.01 * 4/3)

end

function oSkin:KombatStats() 

	oSkin:applySkin(KombatStatsFrame)
	if KombatStats.dpsButton then 
		oSkin:applySkin(KombatStats.dpsButton)
	end

end

function oSkin:FruityLoots_LF_SetPoint(obj, flx, fly)
	
	local screenWidth = GetScreenWidth()
	if (UIParent:GetWidth() > screenWidth) then screenWidth = UIParent:GetWidth() end
	local screenHeight = GetScreenHeight()
-- LootFrame is set to 256 wide in the xml file, but is actually only 191 wide
-- This is based on calculation envolving the offset on the close button:
-- The height is always 256, which is the correct number.
	local windowWidth = 191
	local windowHeight = 256
	if (flx + windowWidth) > screenWidth then flx = screenWidth - windowWidth end
	if fly > screenHeight then fly = screenHeight end
	if flx < 0 then flx = 0 end
	if (fly - windowHeight) < 0 then fly = windowHeight end

	_G["LootFrame"]:ClearAllPoints()
	_G["LootFrame"]:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", flx, fly - 44)

end

function oSkin:FramesResized_LootFrame()
	if not self.db.profile.LootFrame then return end
	
	for i = 5, NUM_GROUP_LOOT_FRAMES do
		_G["LootButton"..i]:ClearAllPoints()
		_G["LootButton"..i]:SetPoint("TOP", _G["LootButton"..i - 1], "BOTTOM", 0, -4)
   	end

end

function oSkin:skinMCP()

	if _G["MCPAddonSetDropDown"] then 
		-- Rophy's version on the SVN
		self:hookDDScript(MCPAddonSetDropDownButton)
		self:keepRegions(_G["MCPAddonSetDropDown"], {4}) -- N.B. region 4 is text
		self:moveObject(_G["MCPAddonSetDropDown"], nil, nil, "-", 13)
		self:moveObject(_G["MCP_AddonListDisableAll"], nil, nil, nil, nil)
		self:moveObject(_G["MCP_AddonListEnableAll"], nil, nil, nil, nil)
		self:moveObject(_G["MCP_AddonListSaveSet"], nil, nil, "-", 10)
		self:moveObject(_G["MCP_AddonList_ReloadUI"], nil, nil, "-", 10)
	else
		-- standard version from Curse
		self:hookDDScript(MCP_AddonList_ProfileSelectionButton)	
		self:keepRegions(_G["MCP_AddonList_ProfileSelection"], {4}) -- N.B. region 4 is text
		self:moveObject(_G["MCP_AddonList_ProfileSelection"], nil, nil, "-", 13)
		self:moveObject(_G["MCP_AddonList_EnableAll"], "+", 30, "+", 5)
		self:moveObject(_G["MCP_AddonList_DisableAll"], "+", 30, "+", 5)
		self:moveObject(_G["MCP_AddonList_SaveProfile"], "+", 40, "-", 10)
		self:moveObject(_G["MCP_AddonList_DeleteProfile"], "+", 40, "-", 10)
		self:moveObject(_G["MCP_AddonList_ReloadUI"], "+", 30, "+", 5)
	end
	
	-- change the scale to match other frames
	_G["MCP_AddonList"]:SetScale(_G["GameMenuFrame"]:GetEffectiveScale())
	
	self:keepRegions(_G["MCP_AddonList"], {8}) -- N.B. region 8 is the title
	_G["MCP_AddonList"]:SetWidth(_G["MCP_AddonList"]:GetWidth() * FxMult)
	_G["MCP_AddonList"]:SetHeight(_G["MCP_AddonList"]:GetHeight() * FyMult)

	-- resize the frame's children to match the frame size
	for i, v in ipairs({ _G["MCP_AddonList"]:GetChildren() }) do
		v:SetWidth(v:GetWidth() * FxMult)
		v:SetHeight(v:GetHeight() * FyMult)
	end
	
	self:moveObject(_G["MCP_AddonListCloseButton"], "+", 40, nil, nil)
	self:moveObject(_G["MCP_AddonListEntry1"], nil, nil, "+", 10)
	self:removeRegions(_G["MCP_AddonList_ScrollFrame"])
	self:moveObject(_G["MCP_AddonList_ScrollFrame"], "+", 26, "+", 7)
	_G["MCP_AddonList_ScrollFrame"]:SetHeight(_G["MCP_AddonList_ScrollFrame"]:GetHeight() + 10)
	self:skinScrollBar(_G["MCP_AddonList_ScrollFrame"])
	
	self:applySkin(_G["MCP_AddonList"], 1)
		
end


function oSkin:CT_MailMod()
	if not self.db.profile.MailFrame then return end
	
	self:keepRegions(_G["MailFrameTab3"], {7, 8}) -- N.B. region 7 is text, 8 is highlight
	self:moveObject(_G["MailFrameTab3"], "+", 4, nil, nil)
	self:applySkin(_G["MailFrameTab3"])

	self:moveObject(_G["CT_MMInboxOpenSelected"], "-", 20, "+", 5)
	self:moveObject(_G["CT_MMInboxOpenAll"], "-", 20, "+", 5)

	--	reset MailItem1 position
	self:moveObject(_G["MailItem1"], "-", 5, "-", 5)
	
	-- skin the frame
	self:removeRegions(_G["CT_MailFrame"], {4, 5}) -- N.B. regions 1, 2 & 3 are text
	_G["CT_MailFrame"]:SetWidth(_G["CT_MailFrame"]:GetWidth() * FxMult)
	_G["CT_MailFrame"]:SetHeight(_G["CT_MailFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["CT_MailTitleText"], "+", 5, "-", 35)
	self:moveObject(_G["CT_MailNameEditBox"], "-", 5, "+", 10)
	self:moveObject(_G["CT_MailCostMoneyFrame"], "+", 40, "+", 10)
	self:moveObject(_G["CT_MailMoneyFrame"], "-", 5, "-", 72)
	self:moveObject(_G["CT_MailCancelButton"], "+", 34, "-", 72)
	self:applySkin(_G["CT_MailFrame"])

	-- skin the accept send frame
	self:keepRegions(_G["CT_Mail_AcceptSendFrame"], {11, 12, 13, 14})-- N.B. regions 11 - 14 are text
	self:applySkin(_G["CT_Mail_AcceptSendFrame"], 1)

	self:moveObject(_G["CT_MailStatusText"], nil, nil, "-", 65)
	self:moveObject(_G["CT_MailAbortButton"], nil, nil, "-", 70)
	
	self:moveObject(_G["CT_MailButton1"], "-", 10, "+", 20)
	
	-- skin the OpenAll frame
	self:keepRegions(_G["CT_MMInbox_OpenAll"], {11, 12, 13, 14})-- N.B. regions 11 - 14 are text
	self:applySkin(_G["CT_MMInbox_OpenAll"], 1)

end

function oSkin:ItemSync() 

	self:hookDDScript(ISync_MainFrame_DropDownButton)
	self:hookDDScript(ISync_Location_DropDownButton)
	self:hookDDScript(ISync_Rarity_DropDownButton)
	self:hookDDScript(ISync_Weapons_DropDownButton)
	self:hookDDScript(ISync_Level_DropDownButton)
	self:hookDDScript(ISync_Tradeskills_DropDownButton)
	self:hookDDScript(ISync_Armor_DropDownButton)
	self:hookDDScript(ISync_Shield_DropDownButton)
	self:hookDDScript(ISync_FavFrame_DropDownButton)
	self:hookDDScript(ISync_FilterPurgeRare_DropDownButton)
	
	for i = 1, 4 do
	  self:removeRegions(_G["ISync_OptionsFrameTab"..i], {1, 2, 3, 4})
	  self:moveObject(_G["ISync_OptionsFrameTab"..i], "+", 15, nil, nil)
	  self:applySkin(_G["ISync_OptionsFrameTab"..i])
	end
	
	self:applySkin(_G["ISync_MainFrame"])
	self:applySkin(_G["ISync_SearchFrame"])
	self:applySkin(_G["ISync_BV_Frame"])
	self:applySkin(_G["ISync_FavFrame"])
	self:applySkin(_G["ISync_FiltersFrame"])
	self:applySkin(_G["ISync_OptionsFrame"])

end

function oSkin:Skin_aftte()

	bd = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	}

	self:applySkin(_G["aftt_descriptFrame"], nil, nil, nil, nil, bd)
	self:applySkin(_G["aftt_targettargetframe"], nil, nil, nil, nil, bd)
	self:applySkin(_G["aftt_tooltipFrame"], nil, nil, nil, nil, bd)
end

function oSkin:EasyUnlock()

	self:Hook("EasyUnlock_DoFrameCheck", function()
		self.hooks.EasyUnlock_DoFrameCheck()
		self:moveObject(_G["TradeFrameTradeButton"], "+", 20, "-", 40)
		end)
		
end
