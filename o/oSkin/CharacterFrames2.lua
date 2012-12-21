local _G = getfenv(0)
-- Frame multipliers
local FxMult, FyMult = 0.9, 0.84
-- Frame Tab multipliers
local FTxMult, FTyMult = 0.5, 0.75

function oSkin:InspectFrame()
	if not self.db.profile.Inspect or self.initialized.Inspect then return end
	self.initialized.Inspect = true

	-- hook this to move PVP title
	self:Hook("InspectHonorFrame_Update", function()
		self:Debug("InspectHonorFrame_Update")
		self.hooks.InspectHonorFrame_Update()
		self:moveObject(_G["InspectHonorFrameCurrentPVPTitle"], "-", 5, "+", 20)
		end) 

	-- Blow up the Blizz Art
	self:removeRegions(_G["InspectFrame"], {1})
	self:removeRegions(_G["InspectPaperDollFrame"], {1, 2, 3, 4})
	self:removeRegions(_G["InspectHonorFrame"], {1, 2, 3, 4, 5, 6, 7, 8})

	_G["InspectModelRotateLeftButton"]:Hide()
	_G["InspectModelRotateRightButton"]:Hide()

	_G["InspectFrame"]:SetWidth(_G["InspectFrame"]:GetWidth() * FxMult)
	_G["InspectFrame"]:SetHeight(_G["InspectFrame"]:GetHeight() * FyMult)

	local xOfs, yOfs = 5, 20
	self:moveObject(_G["InspectFrameCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["InspectNameText"], nil, nil, "-", 32)
	self:moveObject(_G["InspectModelFrame"], nil, nil, "+", yOfs)
	self:moveObject(_G["InspectHeadSlot"], nil, nil, "+", yOfs)
	self:moveObject(_G["InspectHandsSlot"], "-", 15, "+", yOfs)
	self:moveObject(_G["InspectMainHandSlot"], nil, nil, "-", 38)

	-- Honor Frame
	self:moveObject(_G["InspectHonorFrameCurrentSessionTitle"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["InspectHonorFrameProgressBar"], "-", xOfs, "+", yOfs)
	self:glazeStatusBar(_G["InspectHonorFrameProgressBar"], - 2)

	-- Frame Tabs
	for i = 1, 2 do
		local tabName = _G["InspectFrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is text, 8 is highlight
		if i == 1 then
			self:moveObject(tabName, nil, nil, "-", 70)
		else
			self:moveObject(tabName, "+", 11, nil, nil)
		end
		self:applySkin(tabName)
	end

	self:applySkin(_G["InspectFrame"])
	
end

function oSkin:FriendsFrame()
	if not self.db.profile.FriendsFrame or self.initialized.FriendsFrame then return end
	self.initialized.FriendsFrame = true

	self:Hook("FriendsFrame_ShowSubFrame", function(frameName)
		self:Debug("FriendsFrame_ShowSubFrame: [%s]", frameName)
		self.hooks.FriendsFrame_ShowSubFrame(frameName)
		for i, v in FRIENDSFRAME_SUBFRAMES do
			-- handle Friends and Ignore on the same Tab
			j = ( i > 1 and i - 1 or i)
			if v == "CT_RAOptionsFrame" then PanelTemplates_TabResize(0, _G["FriendsFrameTab"..j], nil, 65) end
		end 
		end)
	self:hookDDScript(WhoFrameDropDownButton)	
	self:hookDDScript(GuildControlPopupFrameDropDownButton)	
	self:Hook("GuildStatus_Update", function()
		self:Debug("GuildStatus_Update")
		self.hooks.GuildStatus_Update()
		local _, _, _, xOfs, _ = _G["GuildFrameGuildListToggleButton"]:GetPoint()
		if xOfs == 284 then
			self:moveObject(_G["GuildFrameGuildListToggleButton"], "+", 23, "-", 46)  
		else
			self:moveObject(_G["GuildFrameGuildListToggleButton"], nil, nil, "-", 46)
		end
		end)
	
-->>-- Friends Frame
	self:keepRegions(_G["FriendsFrame"], {6}) -- N.B. 6 is the text region
	
	_G["FriendsFrame"]:SetWidth(_G["FriendsFrame"]:GetWidth() * FxMult)
	_G["FriendsFrame"]:SetHeight(_G["FriendsFrame"]:GetHeight() * FyMult)
	
  	self:moveObject(_G["FriendsFrameTitleText"], nil, nil, "+", 6)  
  	self:moveObject(_G["FriendsFrameCloseButton"], "+", 30, "+", 8)  
  
	self:skinFFToggleTabs("FriendsFrameToggleTab") --N.B. Prefix string
		
--	FriendsDropDown
--	FriendsListFrame

  	self:moveObject(_G["FriendsFrameAddFriendButton"], "-", 9, "-", 70)  
  	self:moveObject(_G["FriendsFrameFriendButton1"], nil, nil, "+", 15)  
	
	self:removeRegions(_G["FriendsFrameFriendsScrollFrame"])
  	self:moveObject(_G["FriendsFrameFriendsScrollFrame"], "+", 35, "+", 14)  
	self:skinScrollBar(_G["FriendsFrameFriendsScrollFrame"])
	
-->>--	Ignore Frame	
	self:keepRegions(_G["IgnoreListFrame"], {6}) -- N.B. 6 is the text region
	
	_G["IgnoreListFrame"]:SetWidth(_G["IgnoreListFrame"]:GetWidth() * FxMult)
	_G["IgnoreListFrame"]:SetHeight(_G["IgnoreListFrame"]:GetHeight() * FyMult)
	
    self:skinFFToggleTabs("IgnoreFrameToggleTab") --N.B. Prefix string
		
  	self:moveObject(_G["FriendsFrameIgnorePlayerButton"], "-", 7, "-", 70)  
 	self:moveObject(_G["FriendsFrameIgnoreButton1"], nil, nil, "+", 15)  
	
	self:removeRegions(_G["FriendsFrameIgnoreScrollFrame"])
  	self:moveObject(_G["FriendsFrameIgnoreScrollFrame"], "+", 35, "+", 14)  
	self:skinScrollBar(_G["FriendsFrameIgnoreScrollFrame"])
	
-->>--	WhoFrame
	_G["WhoFrame"]:SetWidth(_G["WhoFrame"]:GetWidth() * FxMult)
	_G["WhoFrame"]:SetHeight(_G["WhoFrame"]:GetHeight() * FyMult)
	
	self:skinFFColHeads("WhoFrameColumnHeader") --N.B. Prefix string

	self:keepRegions(_G["WhoFrameDropDown"], {4}) -- N.B. region 4 is text
  	self:moveObject(_G["WhoFrameDropDown"], "+", 5, "+", 1)  
 	self:moveObject(_G["WhoFrameButton1"], nil, nil, "+", 15)  
	
	self:removeRegions(_G["WhoListScrollFrame"])
  	self:moveObject(_G["WhoListScrollFrame"], "+", 35, "+", 20)  
	self:skinScrollBar(_G["WhoListScrollFrame"])
	
  	self:moveObject(_G["WhoFrameEditBox"], "+", 20, "-", 65)  
	local left, right, top, bottom = _G["WhoFrameEditBox"]:GetTextInsets()
	_G["WhoFrameEditBox"]:SetTextInsets(left + 5, right + 5, top, bottom)
	_G["WhoFrameEditBox"]:SetWidth(_G["WhoFrameEditBox"]:GetWidth() + 30)
	_G["WhoFrameEditBox"]:SetHeight(_G["WhoFrameEditBox"]:GetHeight() - 5)
	self:applySkin(_G["WhoFrameEditBox"])
	
	self:moveObject(_G["WhoFrameTotals"], nil, nil, "-", 66)
  	self:moveObject(_G["WhoFrameGroupInviteButton"], "+", 30, "-", 71)  
	
-->>--	GuildFrame
	_G["GuildFrame"]:SetWidth(_G["GuildFrame"]:GetWidth() * FxMult)
	_G["GuildFrame"]:SetHeight(_G["GuildFrame"]:GetHeight() * FyMult)
		
	-- show offline members text and checkbox
	self:removeRegions(_G["GuildFrameLFGFrame"])
  	self:moveObject(_G["GuildFrameLFGButton"], "+", 42, "+", 12)  
	
	self:skinFFColHeads("GuildFrameColumnHeader") --N.B. Prefix string
	self:skinFFColHeads("GuildFrameGuildStatusColumnHeader") --N.B. Prefix string

	self:removeRegions(_G["GuildListScrollFrame"])
  	self:moveObject(_G["GuildListScrollFrame"], "+", 35, "+", 20)  
	self:skinScrollBar(_G["GuildListScrollFrame"])
	
  	self:moveObject(_G["GuildFrameTotals"], "+", 10, "-", 86)  
  	self:moveObject(_G["GuildFrameNotesLabel"], "-", 8, nil, nil)  
  	self:moveObject(_G["GuildFrameControlButton"], "+", 30, "-", 71)  
	
	-- where should this be moved to ?, if anywhere	
--	self:moveObject(_G["GuildMOTDEditButton"], nil, nil, nil, nil) 

	-- Guild Control Popup Frame
	self:keepRegions(_G["GuildControlPopupFrame"], {5, 6}) --N.B. regions 5 & 6 are text
  	self:moveObject(_G["GuildControlPopupFrame"], "+", 30, nil, nil)  
	
--	GuildControlPopupFrameCheckboxes
	self:keepRegions(_G["GuildControlPopupFrameDropDown"], {4}) -- N.B. region 4 is text
	self:removeRegions(_G["GuildControlPopupFrameEditBox"], {6, 7}) -- N.B. all other regions are required
	local left, right, top, bottom = _G["GuildControlPopupFrameEditBox"]:GetTextInsets()
	_G["GuildControlPopupFrameEditBox"]:SetTextInsets(left + 5, right + 5, top, bottom)
	_G["GuildControlPopupFrameEditBox"]:SetWidth(_G["GuildControlPopupFrameEditBox"]:GetWidth() + 30)
	_G["GuildControlPopupFrameEditBox"]:SetHeight(_G["GuildControlPopupFrameEditBox"]:GetHeight() - 5)
	self:applySkin(_G["GuildControlPopupFrameEditBox"])
  	self:applySkin(_G["GuildControlPopupFrame"])

--	GuildInfoFrame	
	self:keepRegions(_G["GuildInfoFrame"], {2}) -- N.B. region 2 is text
  	self:moveObject(_G["GuildInfoTitle"], nil, nil, "+", 3)  
	
	self:removeRegions(_G["GuildInfoFrameScrollFrame"])
	self:skinScrollBar(_G["GuildInfoFrameScrollFrame"])
		
	self:applySkin(_G["GuildInfoTextBackground"])
  	self:applySkin(_G["GuildInfoFrame"])

--	GuildMemberDetailFrame
	self:keepRegions(_G["GuildMemberDetailFrame"], {10, 11, 12, 13, 14, 15, 16, 17, 18}) -- N.B. regions 10-18 are text	
  	self:moveObject(_G["GuildMemberDetailFrame"], "+", 28, nil, nil)  
	self:moveObject(_G["GuildFramePromoteButton"], nil, nil, "-", 30)
  	self:applySkin(_G["GuildMemberDetailFrame"])

-->>--	Raid Frame
  	self:moveObject(_G["RaidFrameConvertToRaidButton"], "-", 30, "+", 10)  
	
	if IsAddOnLoaded("Blizzard_RaidUI") then
 		self:moveObject(_G["RaidFrameAddMemberButton"], "-", 40, "+", 10)
		self:moveObject(_G["RaidGroup1"], "-", 7, "+", 8)
	end

--	RaidInfoFrame
	self:keepRegions(_G["RaidInfoFrame"], {12, 13, 14, 15}) -- N.B. regions 12-15 are text
  	self:moveObject(_G["RaidInfoFrame"], "+", 35, nil, nil)  
	self:removeRegions(_G["RaidInfoScrollFrame"])
  	self:moveObject(_G["RaidInfoScrollFrame"], "+", 5, nil, nil)  
	self:skinScrollBar(_G["RaidInfoScrollFrame"])
 	self:applySkin(_G["RaidInfoFrame"])
 	
-->>-- Frame Tabs
    for i=1, (IsAddOnLoaded("CT_RaidAssist") and 5 or 4) do
		self:keepRegions(_G["FriendsFrameTab"..i], {7, 8}) -- N.B. region 7 is the Text, 8 is the highlight
		if i == 1 then
			self:moveObject(_G["FriendsFrameTab"..i], "-", 3, "-", 72)  
		else
			self:moveObject(_G["FriendsFrameTab"..i], "+", 9, nil, nil)  
		end
		self:applySkin(_G["FriendsFrameTab"..i])
	end

  	self:applySkin(_G["FriendsFrame"])

end

function oSkin:skinFFToggleTabs(tabName)
	self:Debug("skinFFToggleTabs: [%s]", tabName)

	for i = 1, 2 do
		local togTab = _G[tabName..i]
   		self:keepRegions(_G[tabName..i], {7, 8}) -- N.B. regions 7 & 8 are text/scripts
		_G[tabName..i]:SetHeight(_G[tabName..i]:GetHeight() - 5)
		if i == 1 then
			self:moveObject(_G[tabName..i], nil, nil, "+", 3)  
		else
			self:moveObject(_G[tabName..i])
		end
		self:moveObject(_G[tabName..i.."Text"], "-", 2, "+", 3)
		self:moveObject(_G[tabName..i.."HighlightTexture"], "-", 2, "+", 5)
  		self:applySkin(togTab)
  	end
	
end

function oSkin:skinFFColHeads(buttonName)
	self:Debug("skinFFColHeads: [%s]", buttonName)

	for i = 1, 4 do
		self:keepRegions(_G[buttonName..i], {4}) -- N.B. region 4 is text
		if i == 1 then
			self:moveObject(_G[buttonName..i], nil, nil, "+", 25)  
		else
			self:moveObject(_G[buttonName..i])
		end
		self:applySkin(_G[buttonName..i])
	end
	
end

function oSkin:TradeFrame()
	if not self.db.profile.TradeFrame or self.initialized.TradeFrame then return end
	self.initialized.TradeFrame = true

	self:keepRegions(_G["TradeFrame"], {7, 8, 9, 10}) -- N.B. regions 7-10 are text

	_G["TradeFrame"]:SetWidth(_G["TradeFrame"]:GetWidth() - 20)
	_G["TradeFrame"]:SetHeight(_G["TradeFrame"]:GetHeight() - 80)

	self:moveObject(_G["TradeFrameRecipientNameText"], nil, nil, "+", 6)
	self:moveObject(_G["TradeFramePlayerNameText"], nil, nil, "+", 6)

	-- move everything up
	local yOfs = 40
	self:moveObject(_G["TradeFramePlayerEnchantText"], nil, nil, "+", yOfs)
	self:moveObject(_G["TradeHighlightPlayer"], nil, nil, "+", yOfs)
	self:moveObject(_G["TradeHighlightRecipient"], nil, nil, "+", yOfs)
	self:moveObject(_G["TradeRecipientItem1"], nil, nil, "+", yOfs)
	self:moveObject(_G["TradePlayerItem1"], nil, nil, "+", yOfs)
	self:moveObject(_G["TradeRecipientMoneyFrame"], "+", 20, "+", yOfs)
	self:moveObject(_G["TradePlayerInputMoneyFrame"], nil, nil, "+", yOfs)

	self:moveObject(_G["TradeFrameTradeButton"], "+", 20, "-", 44)
	self:moveObject(_G["TradeFrameCloseButton"], "+", 26, "+", 8)

	self:applySkin(_G["TradeFrame"])

end

function oSkin:QuestLog()
	if not self.db.profile.QuestLog or self.initialized.QuestLog then return end
	self.initialized.QuestLog = true

	self:Hook("QuestLog_UpdateQuestDetails", function(doNotScroll)
		self:Debug("QuestLog_UpdateQuestDetails")
		self.hooks.QuestLog_UpdateQuestDetails(doNotScroll)
		for i = 1, 10 do
    		local r, g, b, a = _G["QuestLogObjective"..i]:GetTextColor()
    		_G["QuestLogObjective"..i]:SetTextColor(0.7 - r, 0.7 - g, 0)
    	end
    	local r, g, b, a = _G["QuestLogRequiredMoneyText"]:GetTextColor()
    	_G["QuestLogRequiredMoneyText"]:SetTextColor(0.7 - r, 0.7 - g, 0)
    	_G["QuestLogRewardTitleText"]:SetTextColor(0.8,0.8,0)
    	_G["QuestLogItemChooseText"]:SetTextColor(0.7,0.7,0)
    	_G["QuestLogItemReceiveText"]:SetTextColor(0.7,0.7,0)
		end)
	
	self:keepRegions(_G["QuestLogFrame"], {1, 7, 11}) -- N.B. region 1 is dummy, regions 7 & 11 are text
	_G["QuestLogFrame"]:SetWidth(_G["QuestLogFrame"]:GetWidth() - 40)
	_G["QuestLogFrame"]:SetHeight(_G["QuestLogFrame"]:GetHeight() - 70)

	self:moveObject(_G["QuestLogTitleText"], nil, nil, "+", 10)
	self:moveObject(_G["QuestLogFrameCloseButton"], "+", 28, "+", 8)

	-- movement values
	local xOfs, yOfs = 8, 24

	self:moveObject(_G["QuestLogExpandButtonFrame"], "-", xOfs, "+", yOfs)
	self:keepRegions(_G["QuestLogCollapseAllButton"], {4, 6}) -- N.B. region 4 is button, 6 is text
--	self:moveObject(_G["QuestLogCollapseAllButton"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["QuestLogQuestCount"], nil, nil, "+", 20)

	self:keepRegions(_G["EmptyQuestLogFrame"], {5}) -- N.B. region 5 is text
--	QuestLogNoQuestsText

--	QuestLogHighlightFrame
	self:moveObject(_G["QuestLogTitle1"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["QuestLogListScrollFrame"], "-", xOfs, "+", yOfs)

	_G["QuestLogQuestTitle"]:SetTextColor(0.8,0.8,0)
	_G["QuestLogObjectivesText"]:SetTextColor(0.7,0.7,0)

	for i = 1, 10 do
   		local r, g, b, a = _G["QuestLogObjective"..i]:GetTextColor()
   		_G["QuestLogObjective"..i]:SetTextColor(0.7 - r, 0.7 - g, 0)
   	end

--	_G["QuestLogTimerText"]:SetTextColor(0.8,0.8,0)
	
	self:skinScrollBar(_G["QuestLogListScrollFrame"])
	self:skinScrollBar(_G["QuestLogDetailScrollFrame"])
	
--	QuestLogRequiredMoneyText

	_G["QuestLogDescriptionTitle"]:SetTextColor(0.8,0.8,0)
	_G["QuestLogQuestDescription"]:SetTextColor(0.7,0.7,0)
	
--	QuestLogItem1-10
--	QuestLogMoneyFrame
--	QuestLogRequiredMoneyFrame
		
	self:moveObject(_G["QuestLogFrameAbandonButton"], "-", 12, "-", 47)
	self:moveObject(_G["QuestFrameExitButton"], "+", 32, "-", 47)

	self:applySkin(_G["QuestLogFrame"])
	
end
