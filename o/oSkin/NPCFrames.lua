local _G = getfenv(0)
-- Frame multipliers
local FxMult, FyMult = 0.9, 0.84
-- Frame Tab multipliers
local FTxMult, FTyMult = 0.5, 0.75
-- Character subframe names

function oSkin:merchantFrames()
	if not self.db.profile.MerchantFrames or self.initialized.MerchantFrames then return end
	self.initialized.MerchantFrames = true

	self:keepRegions(_G["MerchantFrame"], {6, 7, 8}) -- N.B. regions 6-8 are text

	_G["MerchantFrame"]:SetWidth(_G["MerchantFrame"]:GetWidth() * FxMult)
	_G["MerchantFrame"]:SetHeight(_G["MerchantFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["MerchantNameText"], nil, nil, "+", 6)
	self:moveObject(_G["MerchantFrameCloseButton"], "+", 28, "+", 8)

	self:moveObject(_G["MerchantItem1"], "-", 6, "+", 30)

	self:moveObject(_G["MerchantPageText"], "+", 12, "-", 59)
	self:moveObject(_G["MerchantPrevPageButton"], "-", 5, "-", 60)
	self:moveObject(_G["MerchantNextPageButton"], "-", 5, "-", 60)

	self:moveObject(_G["MerchantRepairText"], nil, nil, "-", 58)
	self:moveObject(_G["MerchantRepairAllButton"], nil, nil, "-", 58)
	self:moveObject(_G["MerchantBuyBackItem"], nil, nil, "-", 5)
	self:moveObject(_G["MerchantMoneyFrame"], "+", 30, "-", 58)


	for i = 1, 2 do
		local tabName = _G["MerchantFrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is text, 8 is highlight
		if i == 1 then
			self:moveObject(tabName, nil, nil, "-", 55)
		else
			self:moveObject(tabName, "+", 12, nil, nil)
		end
		self:applySkin( _G["MerchantFrameTab"..i])
	end

	self:applySkin( _G["MerchantFrame"])

end

function oSkin:GossipFrame()
	if not self.db.profile.GossipFrame or self.initialized.GossipFrame then return end
	self.initialized.GossipFrame = true
	
	self:removeRegions(_G["GossipFrame"])
	
	_G["GossipFrame"]:SetWidth(_G["GossipFrame"]:GetWidth() * FxMult)
	_G["GossipFrame"]:SetHeight(_G["GossipFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["GossipFrameNpcNameText"], nil, nil, "+", 15)
	self:moveObject(_G["GossipFrameCloseButton"], "+", 24, "+", 12)
	self:removeRegions(_G["GossipFrameGreetingPanel"])
	self:moveObject(_G["GossipFrameGreetingGoodbyeButton"], "+", 28, "-", 64)

	_G["GossipGreetingText"]:SetTextColor(0.8,0.8,0)

	for i = 1, NUMGOSSIPBUTTONS do
		_G["GossipTitleButton"..i]:SetTextColor(0.7,0.7,0)
	end 

	self:moveObject(_G["GossipGreetingScrollFrame"], "-", 12, "+", 30)
	self:skinScrollBar(_G["GossipGreetingScrollFrame"])
	
	self:applySkin(_G["GossipFrame"])

end

function oSkin:ClassTrainer()
	if not self.db.profile.ClassTrainer or self.initialized.ClassTrainer then return end
	self.initialized.ClassTrainer = true

	self:hookDDScript(ClassTrainerFrameFilterDropDownButton)	
	
	self:keepRegions(_G["ClassTrainerFrame"], {6, 7}) -- N.B. 6 & 7 are text regions
	
	_G["ClassTrainerFrame"]:SetWidth(_G["ClassTrainerFrame"]:GetWidth()* FxMult)
	_G["ClassTrainerFrame"]:SetHeight(_G["ClassTrainerFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["ClassTrainerNameText"], nil, nil, "+", 6)
	self:moveObject(_G["ClassTrainerGreetingText"], "-", 35, nil, nil)
	self:moveObject(_G["ClassTrainerFrameCloseButton"], "+", 28, "+", 8)

	self:removeRegions(_G["ClassTrainerExpandButtonFrame"])
	self:moveObject(_G["ClassTrainerExpandButtonFrame"], nil, nil, "+", 10)

	self:keepRegions(_G["ClassTrainerFrameFilterDropDown"], {4}) -- N.B. 4 is the text region
	self:moveObject(_G["ClassTrainerFrameFilterDropDown"], nil, nil, "+", 10)
	self:moveObject(_G["ClassTrainerSkill1"], nil, nil, "+", 10)
	
	self:removeRegions(_G["ClassTrainerListScrollFrame"])
	self:moveObject(_G["ClassTrainerListScrollFrame"], "+", 35, "+", 10)
	self:skinScrollBar(_G["ClassTrainerListScrollFrame"])

	self:removeRegions(_G["ClassTrainerDetailScrollFrame"])
	self:skinScrollBar(_G["ClassTrainerDetailScrollFrame"])

	self:moveObject(_G["ClassTrainerMoneyFrame"], nil, nil, "-", 74)
	self:moveObject(_G["ClassTrainerTrainButton"], "-", 10, "+", 10)
	self:moveObject(_G["ClassTrainerCancelButton"], "-", 10, "+", 10)
	
	self:applySkin(_G["ClassTrainerFrame"])

end

function oSkin:TradeSkill()
	if not self.db.profile.TradeSkill or self.initialized.TradeSkill then return end
	self.initialized.TradeSkill = true

	self:hookDDScript(TradeSkillSubClassDropDownButton)	
	self:hookDDScript(TradeSkillInvSlotDropDownButton)	

	self:keepRegions(_G["TradeSkillFrame"], {6}) -- N.B. region 6 is text
	
	_G["TradeSkillFrame"]:SetWidth(_G["TradeSkillFrame"]:GetWidth() * FxMult)
	_G["TradeSkillFrame"]:SetHeight(_G["TradeSkillFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["TradeSkillFrameTitleText"], nil, nil, "+", 8)
	self:moveObject(_G["TradeSkillFrameCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["TradeSkillRankFrame"], "-", 40, "+", 8)
	self:removeRegions(_G["TradeSkillRankFrameBorder"], {1}) -- N.B. region 2 is bar texture
	self:glazeStatusBar(_G["TradeSkillRankFrame"], 0)
	
	self:removeRegions(_G["TradeSkillExpandButtonFrame"])
	self:moveObject(_G["TradeSkillExpandButtonFrame"], nil, nil, "+", 12)

	self:keepRegions(_G["TradeSkillSubClassDropDown"], {4}) -- N.B. 4 is the text region
	self:keepRegions(_G["TradeSkillInvSlotDropDown"], {4}) -- N.B. 4 is the text region
	self:moveObject(_G["TradeSkillInvSlotDropDown"], "+", 20, "+", 12)

	self:moveObject(_G["TradeSkillSkill1"], nil, nil, "+", 12)
	self:removeRegions(_G["TradeSkillListScrollFrame"])
	self:moveObject(_G["TradeSkillListScrollFrame"], "+", 35, "+", 12)
	self:skinScrollBar(_G["TradeSkillListScrollFrame"])

	self:removeRegions(_G["TradeSkillDetailScrollFrame"])
	self:moveObject(_G["TradeSkillDetailScrollFrame"], "-", 4, "+", 12)
	self:skinScrollBar(_G["TradeSkillDetailScrollFrame"])
	
	self:moveObject(_G["TradeSkillCreateButton"], "-", 10, "+", 10)
	self:moveObject(_G["TradeSkillCancelButton"], "-", 7, "+", 10)

	self:applySkin(_G["TradeSkillFrame"])

end

function oSkin:CraftFrame()
	if not self.db.profile.CraftFrame or self.initialized.CraftFrame then return end
	self.initialized.CraftFrame = true

	self:keepRegions(_G["CraftFrame"], {6, 11, 12}) -- N.B. 6, 11 & 12 are text regions
	
	_G["CraftFrame"]:SetWidth(_G["CraftFrame"]:GetWidth() * FxMult)
	_G["CraftFrame"]:SetHeight(_G["CraftFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["CraftFrameTitleText"], nil, nil, "+", 6)
	self:moveObject(_G["CraftFrameCloseButton"], "+", 28, "+", 8)

	self:removeRegions(_G["CraftRankFrameBorder"])
	self:moveObject(_G["CraftRankFrame"], "-", 40, nil, nil)
	self:glazeStatusBar(_G["CraftRankFrame"], 0)
	
	self:removeRegions(_G["CraftExpandButtonFrame"])
	self:moveObject(_G["Craft1"], nil, nil, "+", 20)

	self:removeRegions(_G["CraftListScrollFrame"])
	self:moveObject(_G["CraftListScrollFrame"], "+", 35, "+", 20)
	self:skinScrollBar(_G["CraftListScrollFrame"])

	self:removeRegions(_G["CraftDetailScrollFrame"])
	self:moveObject(_G["CraftDetailScrollFrame"], "-", 4, "+", 10)
	self:skinScrollBar(_G["CraftDetailScrollFrame"])

	self:moveObject(_G["CraftCreateButton"], "-", 10, "+", 10)
	self:moveObject(_G["CraftCancelButton"], "-", 10, "+", 10)
	
	self:applySkin(_G["CraftFrame"])

end

function oSkin:TaxiFrame()
	if not self.db.profile.TaxiFrame or self.initialized.TaxiFrame then return end
	self.initialized.TaxiFrame = true
	
	self:keepRegions(_G["TaxiFrame"], {6, 7}) -- N.B. region 6 is TaxiMerchant, 7 is the TaxiMap overlay

	_G["TaxiFrame"]:SetWidth(_G["TaxiFrame"]:GetWidth() * FxMult)
	_G["TaxiFrame"]:SetHeight(_G["TaxiFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["TaxiMerchant"], nil, nil, "+", 6)
	self:moveObject(_G["TaxiCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["TaxiMap"], "+", 12, "+", 25)
	self:moveObject(_G["TaxiRouteMap"], "+", 12, "+", 25)
	
	self:applySkin(_G["TaxiFrame"])

end

function oSkin:QuestFrame()
	if not self.db.profile.QuestFrame or self.initialized.QuestFrame then return end
	self.initialized.QuestFrame = true

	-- hook OnShow methods to change text colour
	self:Hook("QuestFrameRewardPanel_OnShow")
	self:Hook("QuestFrameProgressPanel_OnShow")
	self:Hook("QuestFrameGreetingPanel_OnShow")
	self:Hook("QuestFrameDetailPanel_OnShow")

	self:removeRegions(_G["QuestFrame"])
	
	_G["QuestFrame"]:SetWidth(_G["QuestFrame"]:GetWidth() * FxMult)
	_G["QuestFrame"]:SetHeight(_G["QuestFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["QuestFrameNpcNameText"], nil, nil, "+", 15)
	self:moveObject(_G["QuestFrameCloseButton"], "+", 24, "+", 12)

	-- QF Reward Panel
	self:removeRegions(_G["QuestFrameRewardPanel"])
	self:moveObject(_G["QuestFrameCancelButton"], "+", 28, "-", 64)
	self:moveObject(_G["QuestFrameCompleteQuestButton"], "-", 10, "-", 64)
	self:moveObject(_G["QuestRewardScrollFrame"], "-", 12, "+", 30)
	self:skinScrollBar(_G["QuestRewardScrollFrame"])
	
	-- QF Progress
	self:removeRegions(_G["QuestFrameProgressPanel"])
	self:moveObject(_G["QuestFrameGoodbyeButton"], "+", 28, "-", 64)
	self:moveObject(_G["QuestFrameCompleteButton"], "-", 10, "-", 64)
	self:moveObject(_G["QuestProgressScrollFrame"], "-", 12, "+", 30)
	self:skinScrollBar(_G["QuestProgressScrollFrame"])
	
	-- QF Detail Panel
	self:removeRegions(_G["QuestFrameDetailPanel"])
	self:moveObject(_G["QuestFrameDeclineButton"], "+", 28, "-", 64)
	self:moveObject(_G["QuestFrameAcceptButton"], "-", 10, "-", 64)
	self:moveObject(_G["QuestDetailScrollFrame"], "-", 12, "+", 30)
	self:skinScrollBar(_G["QuestDetailScrollFrame"])

-- QF Greeting Panel	
	self:removeRegions(_G["QuestFrameGreetingPanel"])
	self:moveObject(_G["QuestFrameGreetingGoodbyeButton"], "+", 28, "-", 64)
	self:moveObject(_G["QuestGreetingScrollFrame"], "-", 12, "+", 30)
	self:skinScrollBar(_G["QuestGreetingScrollFrame"])

	self:applySkin( _G["QuestFrame"])

end

function oSkin:QuestFrameRewardPanel_OnShow()

	self.hooks.QuestFrameRewardPanel_OnShow()

	_G["QuestRewardTitleText"]:SetTextColor(0.8,0.8,0)
	_G["QuestRewardText"]:SetTextColor(0.8,0.8,0)
	_G["QuestRewardRewardTitleText"]:SetTextColor(0.8,0.8,0)
	_G["QuestRewardItemChooseText"]:SetTextColor(0.8,0.8,0)
	_G["QuestRewardItemReceiveText"]:SetTextColor(0.8,0.8,0)
	_G["QuestRewardSpellLearnText"]:SetTextColor(0.8,0.8,0)

	for i = 1, MAX_NUM_ITEMS do
		_G["QuestRewardItem"..i]:SetTextColor(0.7,0.7,0)
	end 

end

function oSkin:QuestFrameProgressPanel_OnShow()

	self.hooks.QuestFrameProgressPanel_OnShow()

	_G["QuestProgressTitleText"]:SetTextColor(0.8,0.8,0)
	_G["QuestProgressText"]:SetTextColor(0.8,0.8,0)
	_G["QuestProgressRequiredItemsText"]:SetTextColor(0.8,0.8,0)
	_G["QuestProgressRequiredMoneyText"]:SetTextColor(0.8,0.8,0)

	for i = 1, MAX_REQUIRED_ITEMS do
		_G["QuestProgressItem"..i]:SetTextColor(0.7,0.7,0)
	end 

end

function oSkin:QuestFrameGreetingPanel_OnShow()

	self.hooks.QuestFrameGreetingPanel_OnShow()

	_G["GreetingText"]:SetTextColor(0.8,0.8,0)
	_G["CurrentQuestsText"]:SetTextColor(0.8,0.8,0)
	_G["AvailableQuestsText"]:SetTextColor(0.8,0.8,0)

	for i = 1, MAX_NUM_QUESTS do
		_G["QuestTitleButton"..i]:SetTextColor(0.7,0.7,0)
	end	

end

function oSkin:QuestFrameDetailPanel_OnShow()

	self.hooks.QuestFrameDetailPanel_OnShow()

	_G["QuestTitleText"]:SetTextColor(0.8,0.8,0)
	_G["QuestDescription"]:SetTextColor(0.8,0.8,0)
	_G["QuestDetailObjectiveTitleText"]:SetTextColor(0.8,0.8,0)
	_G["QuestObjectiveText"]:SetTextColor(0.8,0.8,0)

	_G["QuestDetailRewardTitleText"]:SetTextColor(0.8,0.8,0)
	_G["QuestDetailItemChooseText"]:SetTextColor(0.8,0.8,0)
	_G["QuestDetailItemReceiveText"]:SetTextColor(0.8,0.8,0)
	_G["QuestDetailSpellLearnText"]:SetTextColor(0.8,0.8,0)

	for i = 1, MAX_NUM_ITEMS do
		_G["QuestDetailItem"..i]:SetTextColor(0.7,0.7,0)
	end 

end

function oSkin:Battlefields()
	if not self.db.profile.Battlefields or self.initialized.Battlefields then return end
	self.initialized.Battlefields = true

	self:removeRegions(_G["BattlefieldFrame"], {1, 2, 3, 4, 5}) -- N.B. other regions are text
	
	_G["BattlefieldFrame"]:SetWidth(_G["BattlefieldFrame"]:GetWidth() * FxMult)
	_G["BattlefieldFrame"]:SetHeight(_G["BattlefieldFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["BattlefieldFrameFrameLabel"], nil, nil, "+", 6)
	self:moveObject(_G["BattlefieldFrameCloseButton"], "+", 26, "+", 6)
	self:moveObject(_G["BattlefieldFrameCancelButton"], "-", 10, "+", 10)

	local xOfs, yOfs = 12, 20
	self:moveObject(_G["BattlefieldFrameNameHeader"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["BattlefieldZone1"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["BattlefieldFrameZoneDescription"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["BattlefieldListScrollFrame"], "-", xOfs, "+", yOfs)
	self:skinScrollBar(_G["BattlefieldListScrollFrame"])

	_G["BattlefieldFrameZoneDescription"]:SetTextColor(0.7,0.7,0)

	self:applySkin(_G["BattlefieldFrame"])

end
