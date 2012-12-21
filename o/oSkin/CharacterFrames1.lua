local _G = getfenv(0)
-- Frame multipliers
local FxMult, FyMult = 0.9, 0.84
-- Frame Tab multipliers
local FTxMult, FTyMult = 0.5, 0.75
-- Character subframe names
local cfSubframes = {	"PaperDollFrame",
						"PetPaperDollFrame",
						"ReputationFrame",
						"SkillFrame",
						"HonorFrame"
					}

-- CharacterFrame / ReputationFrame / SkillFrame
function oSkin:characterFrames()
	if not self.db.profile.CharacterFrames or self.initialized.CharacterFrames then return end
	self.initialized.CharacterFrames = true

	-- hook this to adjust the widths of the Tabs
	self:Hook("CharacterFrame_ShowSubFrame", function(frameName)
		self:Debug("CF_SSF: [%s, %s, %s]", frameName, floor(_G["CharacterFrameTab1"]:GetWidth()), self.initialized.CF_SSF)
		self.hooks.CharacterFrame_ShowSubFrame(frameName)
		-- tabs need resizing each time they are reset and the ignore flag  is set
		if floor(_G["CharacterFrameTab1"]:GetWidth()) == 89 and self.initialized.CF_SSF
		then self.initialized.CF_SSF = nil end
		if self.initialized.CF_SSF then return end
		self.initialized.CF_SSF = true
		for i = 1, table.getn(CHARACTERFRAME_SUBFRAMES) do
    		local tabName = _G["CharacterFrameTab"..i]
			tabName:SetWidth(tabName:GetWidth() * 0.8)
		end
	end)
	-- hook this to move tabs when Pet is called
	self:Hook("PetTab_Update", function()
		self:Debug("PetTab_Update")
		self.hooks.PetTab_Update()
		local point,relativeTo,relativePoint,xOfs,yOfs = _G["CharacterFrameTab3"]:GetPoint()
		self:Debug("PTU: [%s, %s, %s, %s, %s]", point,relativeTo:GetName(),relativePoint,xOfs,yOfs)
		if floor(xOfs) == -17 then
			self:moveObject(_G["CharacterFrameTab3"], "+", 11, nil, nil)
			local tabName = _G["CharacterFrameTab2"]
			-- resize tab if required
			if floor(tabName:GetWidth()) == 57 then tabName:SetWidth(tabName:GetWidth() * 0.8) end
		end
		end)
		
	-- handle each frame
	self:CharacterFrame()
	self:PaperDollFrame()
	self:PetPaperDollFrame()
	self:ReputationFrame()
	self:SkillFrame()
	self:HonorFrame()

end

function oSkin:CharacterFrame()

	self:removeRegions(_G["CharacterFrame"])	

	_G["CharacterFrame"]:SetWidth(_G["CharacterFrame"]:GetWidth() * FxMult)
	_G["CharacterFrame"]:SetHeight(_G["CharacterFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["CharacterNameText"], nil, nil, "-", 30)
	self:moveObject(_G["CharacterFrameCloseButton"], "+", 28, "+", 8)

--	CharacterFrameTab1-5
	for i = 1, table.getn(CHARACTERFRAME_SUBFRAMES) do

    	local tabName = _G["CharacterFrameTab"..i]
		oSkin:keepRegions(tabName, {7, 8}) -- N.B. region 7 is the Text, 8 is the highlight
		if i == 1 then
			self:moveObject(tabName, nil, nil, "-", 71)
		else
			-- handle no pet out or not a pet class
			self:moveObject(tabName, "+", ((i == 3 and not HasPetUI()) and 0 or 11), nil, nil)
		end
		oSkin:applySkin(tabName)
	
	end

	self:applySkin(_G["CharacterFrame"])	

end

function oSkin:PaperDollFrame()

	self:keepRegions(_G["PaperDollFrame"], {5, 6, 7}) -- N.B. regions 5-7 are text
	
	_G["CharacterModelFrameRotateLeftButton"]:Hide()
	_G["CharacterModelFrameRotateRightButton"]:Hide()
	
	local xOfs, yOfs = 9, 20
	self:moveObject(_G["CharacterModelFrame"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["CharacterHeadSlot"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["CharacterHandsSlot"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["CharacterResistanceFrame"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["CharacterAttributesFrame"], "-", xOfs, "+", yOfs)

	self:moveObject(_G["CharacterMainHandSlot"], "-", 20, "-", 60)

	self:removeRegions(_G["CharacterAmmoSlot"], {1})
	
	self:applySkin(_G["PaperDollFrame"])

end

function oSkin:PetPaperDollFrame()

	self:removeRegions(_G["PetPaperDollFrame"], {1, 2, 3, 4}) -- N.B. regions 5-9 are text
	
	_G["PetModelFrameRotateLeftButton"]:Hide()
	_G["PetModelFrameRotateRightButton"]:Hide()
	
	self:moveObject(_G["PetNameText"], nil, nil, "-", 30)

	local xOfs, yOfs = 10, 25
	self:moveObject(_G["PetModelFrame"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["PetAttributesFrame"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["PetResistanceFrame"], "-", xOfs, "+", yOfs)
	
	-- move outside the Model Frame otherwise the tooltip doesn't work
	self:moveObject(_G["PetPaperDollPetInfo"], nil, nil, "+", 90)
	
	self:keepRegions(_G["PetPaperDollFrameExpBar"], {3, 4}) -- N.B. region 3 is text
	self:moveObject(_G["PetPaperDollFrameExpBar"], "-", 10, "-", 72)
	self:glazeStatusBar(_G["PetPaperDollFrameExpBar"], 0)

	self:moveObject(_G["PetTrainingPointText"], nil, nil, "-", 72)
	self:moveObject(_G["PetPaperDollCloseButton"], "-", 5, "+", 9)
	
	self:applySkin(_G["PetPaperDollFrame"])

end

function oSkin:ReputationFrame()

	self:keepRegions(_G["ReputationFrame"], {5, 6}) -- N.B. regions 5 & 6 are text
	
	local xOfs, yOfs = 5, 20
	self:moveObject(_G["ReputationFrameFactionLabel"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["ReputationFrameStandingLabel"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["ReputationBar1"], "-", xOfs, "+", yOfs)

	for i = 1 , NUM_FACTIONS_DISPLAYED do
		self:removeRegions(_G["ReputationBar"..i], {1, 2}) -- N.B. regions 3 & 4 are text
		self:glazeStatusBar(_G["ReputationBar"..i], 0)
	end

	self:removeRegions(_G["ReputationListScrollFrame"])
	self:moveObject(_G["ReputationListScrollFrame"], "+", 35, "+", 20)
	self:skinScrollBar(_G["ReputationListScrollFrame"])

	self:keepRegions(_G["ReputationDetailFrame"], {10, 11}) -- N.B. regions 10 & 11 are text
	self:moveObject(_G["ReputationDetailFrame"], "+", 30, nil, nil)
	self:applySkin(_G["ReputationDetailFrame"])
	
	self:applySkin(_G["ReputationFrame"])

end

function oSkin:SkillFrame()

	self:removeRegions(_G["SkillFrame"])
	
	local xOfs, yOfs = 5, 20
	self:removeRegions(_G["SkillFrameExpandButtonFrame"])
	self:moveObject(_G["SkillFrameExpandButtonFrame"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["SkillTypeLabel1"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["SkillRankFrame1"], "-", xOfs, "+", yOfs)
	
	self:removeRegions(_G["SkillListScrollFrame"])
	self:moveObject(_G["SkillListScrollFrame"], "+", 35, "+", 20)
	self:skinScrollBar(_G["SkillListScrollFrame"])

	for i = 1, SKILLS_TO_DISPLAY do
		self:removeRegions(_G["SkillRankFrame"..i.."Border"], {1}) -- N.B. region 2 is highlight
		self:glazeStatusBar(_G["SkillRankFrame"..i], 0)
	end
	
	self:removeRegions(_G["SkillDetailScrollFrame"])
	self:applySkin(_G["SkillDetailScrollFrame"])
	self:skinScrollBar(_G["SkillDetailScrollFrame"])
	
	self:removeRegions(_G["SkillDetailStatusBar"], {1, 4, 5}) -- N.B. regions 2 & 3 are text
	self:glazeStatusBar(_G["SkillDetailStatusBar"], 0)
	
	self:moveObject(_G["SkillFrameCancelButton"], "-", 5, "+", 9)
	
	self:applySkin(_G["SkillFrame"])

end

function oSkin:HonorFrame()

	self:removeRegions(_G["HonorFrame"], {1, 2, 3, 4, 7, 8, 9, 10}) -- N.B. other regions are text
	local xOfs, yOfs = 5, 20
	self:moveObject(_G["HonorFrameCurrentPVPTitle"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["HonorFrameProgressBar"], "-", xOfs, "+", yOfs)
	self:glazeStatusBar(_G["HonorFrameProgressBar"], 0)
	self:moveObject(_G["HonorFrameCurrentSessionTitle"], "-", xOfs, "+", yOfs)

	self:applySkin(_G["HonorFrame"])

end

function oSkin:PetStableFrame()
	if not self.db.profile.PetStableFrame or self.initialized.PetStableFrame then return end
	self.initialized.PetStableFrame = true

	self:removeRegions(_G["PetStableFrame"], {1, 2, 3, 4, 5})  -- N.B. regions 6-10 are text

	_G["PetStableFrame"]:SetWidth(_G["PetStableFrame"]:GetWidth() * FxMult)
	_G["PetStableFrame"]:SetHeight(_G["PetStableFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["PetStableFrameCloseButton"], "+", 28, "+", 8)
	
	_G["PetStableModelRotateLeftButton"]:Hide()
	_G["PetStableModelRotateRightButton"]:Hide()

	self:moveObject(_G["PetStableTitleLabel"], nil, nil, "+", 6)
	local xOfs, yOfs = 0, 60
	self:moveObject(_G["PetStableCurrentPet"], "-", xOfs, "-", yOfs)
	self:moveObject(_G["PetStableSlotText"], "-", xOfs, "-", yOfs)
	self:moveObject(_G["PetStableCostLabel"], "-", xOfs, "-", yOfs)
	self:moveObject(_G["PetStablePurchaseButton"], "-", xOfs, "-", yOfs)
	self:moveObject(_G["PetStableMoneyFrame"], "-", xOfs, "-", yOfs)

	-- move outside the Model Frame otherwise the tooltip doesn't work
	self:moveObject(_G["PetStablePetInfo"], nil, nil, "+", 90)

	self:applySkin(_G["PetStableFrame"])

end

function oSkin:SpellBookFrame()
	if not self.db.profile.SpellBookFrame or self.initialized.SpellBookFrame then return end
	self.initialized.SpellBookFrame = true

	self:keepRegions(_G["SpellBookFrame"], {6, 7}) -- N.B. regions 6 & 7 are text
	
	_G["SpellBookFrame"]:SetWidth(_G["SpellBookFrame"]:GetWidth() * 0.9)
	_G["SpellBookFrame"]:SetHeight(_G["SpellBookFrame"]:GetHeight() * 0.84)

	self:moveObject(_G["SpellBookCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["SpellBookTitleText"], nil, nil, "-", 25)

	self:moveObject(_G["SpellBookPageText"], nil, nil, "-", 70)
	self:moveObject(_G["SpellBookPrevPageButton"], "-", 20, "-", 70)
	self:moveObject(_G["SpellBookNextPageButton"], nil, nil, "-", 70)
	
	for i = 1, SPELLS_PER_PAGE do
        self:removeRegions(_G["SpellButton"..i], {1})
        if i == 1 then self:moveObject(_G["SpellButton"..i], "-" , 10, "+", 20) end
        _G["SpellButton"..i.."SpellName"]:SetTextColor(0.8,0.8,0)        
        _G["SpellButton"..i.."SubSpellName"]:SetTextColor(0.7,0.7,0)        
    end
    
	for i = 1, MAX_SKILLLINE_TABS do
		local tabName = _G["SpellBookSkillLineTab"..i]
        self:removeRegions(tabName, {1}) -- N.B. other regions are icon and highlight
        self:Debug("SBSLT: [%s, %s]", tabName:GetWidth(), tabName:GetHeight())
		tabName:SetWidth(tabName:GetWidth() * 1.25)
		tabName:SetHeight(tabName:GetHeight() * 1.25)
		if i == 1 then self:moveObject(tabName, "+", 28, nil, nil) end
        oSkin:applySkin(tabName)
    end
    
    for i = 1, 3 do
    	local tabName = _G["SpellBookFrameTabButton"..i]
		oSkin:keepRegions(tabName, {1, 3}) -- N.B. region 1 is the Text, 3 is the highlight
		tabName:SetWidth(tabName:GetWidth() * FTyMult)
		tabName:SetHeight(tabName:GetHeight() * FTxMult)
		local left, right, top, bottom = tabName:GetHitRectInsets()
		self:Debug("SBFTB: [%s, %s, %s, %s, %s]", i, left, right, top, bottom)
		tabName:SetHitRectInsets(left * FTyMult, right * FTyMult, top * FTxMult, bottom * FTxMult)
		
		if i == 1 then
			self:moveObject(tabName, "-", 18, "-", 70)
		else
			self:moveObject(tabName, "+", 15, nil, nil)
		end

		oSkin:applySkin(tabName)

	end   

	self:applySkin( _G["SpellBookFrame"])
	
end

function oSkin:TalentFrame()
	if not self.db.profile.TalentFrame or self.initialized.TalentFrame then return end
	self.initialized.TalentFrame = true

	self:Hook("TalentFrame_Update", function()
		self:Debug("TalentFrame_Update")
		self.hooks.TalentFrame_Update()
		for i = 1, MAX_TALENT_TABS do
			local tabName = _G["TalentFrameTab"..i]
			tabName:SetWidth(tabName:GetWidth() * FTyMult)
		end
		end)
		
	self:removeRegions(_G["TalentFrame"], {1, 2, 3, 4, 5, 11, 12, 13}) -- N.B. 6, 7, 8 & 9 are the background picture, 10, 14, 15 & 16 are text regions
	
	_G["TalentFrame"]:SetWidth(_G["TalentFrame"]:GetWidth() * FxMult)
	_G["TalentFrame"]:SetHeight(_G["TalentFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["TalentFrameTitleText"], nil, nil, "+", 6)
	self:moveObject(_G["TalentFrameCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["TalentFrameSpentPoints"], "-", 35, "+", 15)
	self:moveObject(_G["TalentFrameTalentPointsText"], "-", 10, "-", 70)
	self:moveObject(_G["TalentFrameBackgroundTopLeft"], "-", 10, "+", 15)
	
	self:removeRegions(_G["TalentFrameScrollFrame"])
	self:moveObject(_G["TalentFrameScrollFrame"], "+", 35, "+", 15)
	self:skinScrollBar(_G["TalentFrameScrollFrame"])

	self:moveObject(_G["TalentFrameCancelButton"], "-", 10, "+", 8)
	
    for i=1,MAX_TALENT_TABS do
		local tabName = _G["TalentFrameTab"..i]
		oSkin:keepRegions(tabName, {7, 8}) -- N.B. region 7 is text, 8 is highlight
		tabName:SetWidth(tabName:GetWidth() * FTyMult)

		if i == 1 then
			self:moveObject(tabName, "-", 8, "-", 71)
		else
			self:moveObject(tabName, "+", 10, nil, nil)
		end

		oSkin:applySkin(_G["TalentFrameTab"..i])
		 
	end   

	self:applySkin(_G["TalentFrame"])

end
