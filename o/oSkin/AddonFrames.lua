local _G = getfenv(0)

function oSkin:AceEvent_FullyInitialized()

	self:RegisterEvent("RAID_ROSTER_UPDATE", "ReadyCheckFrame", true)
	self:RegisterEvent("ADDON_LOADED")

	self:characterFrames()
	self:PetStableFrame()
	self:SpellBookFrame()
	self:FriendsFrame()
	self:TradeFrame()
--	self:QuestLog() -- checked with EQL3 below

	self:Tooltips()
	self:MirrorTimers()
	self:QuestTimers()
	self:CastingBar()
	self:StaticPopups()
	self:ChatFrames()
	self:ChatTabs()
	self:ChatEditBox()
	self:LootFrame()
	self:GroupLoot()
	self:containerFrames()
	self:StackSplit()
	self:ItemText()
	self:WorldMap()

	self:menuFrames()
	self:BankFrame()
	self:MailFrame()
	self:makeModelFramesRotatable()
	
	self:merchantFrames()
	self:GossipFrame()
	self:TaxiFrame()
	self:QuestFrame()
	self:Battlefields()

	self:ViewPort()
	self:TopFrame()
    self:BottomFrame()
	
	-- used for Addons that aren't LoadOnDemand
	if IsAddOnLoaded("BugSack") then self:applySkin(_G["BugSackFrame"],nil,nil,nil,200) end
	if IsAddOnLoaded("OneBag") then self:Skin_OneBag() end
	if IsAddOnLoaded("OneBank") then self:Skin_OneBank() end
	if IsAddOnLoaded("GMail") then self:GMail() end
	if IsAddOnLoaded("CT_MailMod") then self:CT_MailMod() end
	if IsAddOnLoaded("EnhancedStackSplit") then self:EnhancedStackSplit() end
	if IsAddOnLoaded("CT_RaidAssist") then self:CTRA() end
    if IsAddOnLoaded("SuperInspect_UI") then self:SuperInspectFrame() end
	if IsAddOnLoaded("MCP") then self:skinMCP() end
	if IsAddOnLoaded("MyBags") then self:applySkin(_G["MyBankFrame"]) self:applySkin(_G["MyInventoryFrame"]) end
	if IsAddOnLoaded("EquipCompare") and self.db.profile.Tooltips then self:skinTooltip(ComparisonTooltip1) end
	if IsAddOnLoaded("EquipCompare") and self.db.profile.Tooltips then self:skinTooltip(ComparisonTooltip2) end
	if IsAddOnLoaded("AxuItemMenus") and self.db.profile.Tooltips then self:skinTooltip(ItemMenuTooltip) end
	if IsAddOnLoaded("EnhancedTradeSkills") then self:Skin_EnhancedTradeSkills() end
	if IsAddOnLoaded("EnhancedTradeSkills") then self:Skin_EnhancedTradeCrafts() end
	if IsAddOnLoaded("AutoProfit") then self:AutoProfit() end
	if IsAddOnLoaded("FuBar_GarbageFu") then self:FuBar_GarbageFu() end
	if IsAddOnLoaded("MetaMap") then self:MetaMap() end
	if IsAddOnLoaded("FramesResized_QuestLog") then self:FramesResized_QuestLog() end
	if IsAddOnLoaded("LootLink") then self:LootLink() end
	if IsAddOnLoaded("Possessions") then self:Possessions() end
	if IsAddOnLoaded("EQL3") then self:EQL3Frame() else self:QuestLog() end
	if IsAddOnLoaded("BattleChat") then self:BattleChat() end
	if IsAddOnLoaded("KombatStats") then self:KombatStats()	end
	if IsAddOnLoaded("FruityLoots") and self.db.profile.LootFrame then 
		self:Hook(FruityLoots ,"LootFrame_SetPoint", "FruityLoots_LF_SetPoint") end
	if IsAddOnLoaded("FramesResized_LootFrame") then self:FramesResized_LootFrame() end
	if IsAddOnLoaded("ItemSync") then self:ItemSync() end
	if IsAddOnLoaded("oCD") then self:applySkin(_G["oCDFrame"]) end
	if IsAddOnLoaded("GotWood") then self:applySkin(_G["GotWoodFrame"]) end
	if IsAddOnLoaded("aftt_extreme") then self:Skin_aftte() end
	if IsAddOnLoaded("EasyUnlock") then self:EasyUnlock() end
		
	-- skin TabletLib frames
	if AceLibrary:HasInstance("Tablet-2.0") then
		self:Hook(AceLibrary("Tablet-2.0"), "Open", function(tablet, parent)
			local ret = self.hooks[tablet].Open(tablet, parent)
			self:Skin_Tablet()
			return ret
			end)
		self:Hook(AceLibrary("Tablet-2.0"), "Detach", function(tablet, parent)
			local ret = self.hooks[tablet].Detach(tablet, parent)
			self:Skin_Tablet()
			return ret
			end)
		self:Skin_Tablet()
	end
	
end

function oSkin:ADDON_LOADED(arg1)
	-- used for LoadOnDemand Addons
	if arg1 == "Blizzard_RaidUI" then self:ReadyCheckFrame() end
	if arg1 == "Blizzard_MacroUI" then self:MacroFrame() end
	if arg1 == "Blizzard_BindingUI" then self:KeyBindingFrame() end
	if arg1 == "Blizzard_InspectUI" then self:InspectFrame() end
	if arg1 == "Blizzard_InspectUI" then self:makeMFRotatable(_G["InspectModelFrame"]) end
	if arg1 == "Blizzard_AuctionUI" then self:AuctionFrame() end
	if arg1 == "Blizzard_AuctionUI" then self:makeMFRotatable(_G["AuctionDressUpModel"]) end
	if arg1 == "Blizzard_TrainerUI" then self:ClassTrainer() end
	if arg1 == "Blizzard_TradeSkillUI" then self:TradeSkill() end
	if arg1 == "Blizzard_CraftUI" then self:CraftFrame() end
	if arg1 == "Blizzard_TalentUI" then self:TalentFrame() end
 	if arg1 == "Bagnon" and self.db.profile.ContainerFrames then self:applySkin(Bagnon) end
	if arg1 == "Banknon" and self.db.profile.ContainerFrames then self:applySkin(Banknon) end
	if arg1 == "SuperInspect_UI" then self:SuperInspectFrame() end
	if arg1 == "FramesResized_TradeSkillUI" then self:FramesResized_TradeSkillUI() end
	if arg1 == "FramesResized_CraftUI" then self:FramesResized_CraftUI() end
	if arg1 == "GFW_AutoCraft" then self:GFW_AutoCraft() end

end

local tabletsSkinned = {}

function oSkin:Skin_Tablet()
	if not self.db.profile.Tooltips then return end
	if _G["Tablet20Frame"] and not tabletsSkinned["Tablet20Frame"] then
		tabletsSkinned["Tablet20Frame"] = true
		local frame = _G["Tablet20Frame"]
		local r,g,b,a = frame:GetBackdropColor()
		self:applySkin(frame)
		local old_SetBackdropColor = frame.SetBackdropColor
		function frame:SetBackdropColor(r,g,b,a)
			old_SetBackdropColor(self,r,g,b,a)
			self.tfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, a)
		end
		frame:SetBackdropColor(r,g,b,a)
		frame:SetBackdropBorderColor(1,1,1,a)
	end
	local i = 1
	while _G["Tablet20DetachedFrame" .. i] do
		if not tabletsSkinned["Tablet20DetachedFrame" .. i] then
			local frame = _G["Tablet20DetachedFrame" .. i]
			local r,g,b,a = frame:GetBackdropColor()
			self:applySkin(frame)
			local old_SetBackdropColor = frame.SetBackdropColor
			function frame:SetBackdropColor(r,g,b,a)
				old_SetBackdropColor(self,r,g,b,a)
				self.tfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .25, .25, .25, a)
			end
			frame:SetBackdropColor(r,g,b,a)
			frame:SetBackdropBorderColor(1,1,1,a)
		end
		i = i + 1
	end
end
