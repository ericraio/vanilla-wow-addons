cgc = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceConsole-2.0", "AceDebug-2.0", "AceEvent-2.0", "AceHook-2.0")

-- Dewdrop: handles our dropdown
local dewdrop =  AceLibrary("Dewdrop-2.0")

-- Our container for all frames.
local frames = {}

-- The search type should default to "by name"
cgc:RegisterDB("cgCraftyDB")
cgc:RegisterDefaults('profile', {
    searchType = {},
	searchHistory = {},
})

function cgc:OnInitialize()
	self:SetDebugging(false)
	self:RegisterChatCommand({ "/cgcrafty", "/cgc" }, nil)
	
	-- Tradeskill frame references
	frames.trade = {}
	frames.trade.elements = {
		["Main"] 		= "TradeSkillFrame",
		["Title"] 		= "TradeSkillFrameTitleText",
		["Scroll"]		= "TradeSkillListScrollFrame",
		["ScrollBar"] 	= "TradeSkillListScrollFrameScrollBar",
		["Highlight"]	= "TradeSkillHighlightFrame",
		["CollapseAll"] = "TradeSkillCollapseAllButton",
	}
	frames.trade.anchor = "TradeSkillCreateAllButton"
	frames.trade.anchor_offset_x = -9
	frames.trade.anchor_offset_y = -8
	frames.trade.update	 = "TradeSkillFrame_Update"

	-- Crafting frame references
	frames.craft = {}
	frames.craft.elements = {
		["Main"] 		= "CraftFrame",
		["Title"]		= "CraftFrameTitleText",
		["Scroll"] 		= "CraftListScrollFrame",
		["ScrollBar"] 	= "CraftListScrollFrameScrollBar",
		["Highlight"] 	= "CraftHighlightFrame",
	}
	frames.craft.anchor = "CraftCancelButton"
	frames.craft.anchor_offset_x = 6
	frames.craft.anchor_offset_y = -8
	frames.craft.update = "CraftFrame_Update"
	
	-- Setup some closures for use later.
	-- History search text setting variable get/save
	self.getHistory = function(var)	return self.db.profile.searchHistory[var] end
	self.setHistory = function(val) self.db.profile.searchHistory[self.lastSearchTrade or getglobal(self.currentFrame.elements.Title):GetText()] = val end
	self.clearHistory = function() self.db.profile.searchHistory = {} end
	-- History search type setting variable get/save
	self.getSearchType = function(val) return self.db.profile.searchType[getglobal(self.currentFrame.elements.Title):GetText()] or self.LOCALS.FRAME_SEARCH_TYPES[val] end
	self.setSearchType = function(val) self.db.profile.searchType[getglobal(self.currentFrame.elements.Title):GetText()] = val end
	
	-- Search Text
	self.searchText = nil
	-- Clear our the search history
	self.clearHistory()
	-- Handler for the currently opened frame.
	self.currentFrame = nil
end

function cgc:OnEnable()
	self:Debug("OnEnable called.")
	
	-- Tradeskill window --
	self:RegisterEvent("TRADE_SKILL_SHOW")
	-- Enchanting window --
	self:RegisterEvent("CRAFT_SHOW")
	
	if not self.frame then
		self:Debug("Creating cgcFrame.")
		-- Create main frame 
		self.frame = CreateFrame("Frame", "cgcFrame", UIParent)
		self.frame:Hide()
		-- Set main frame properties
		self.frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
		self.frame:SetWidth(342)  
		self.frame:SetHeight(45)
		self.frame:SetFrameStrata("MEDIUM")
		self.frame:SetMovable(false)
		self.frame:EnableMouse(true)
		-- Set the main frame backdrop
		self.frame:SetBackdrop({
				bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 32,
				edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", edgeSize = 20,
				insets = {left = 5, right = 6, top = 6, bottom = 5},
		})
		self.frame:SetBackdropColor(1, 1, 1, 1)
		self.frame:SetBackdropBorderColor(0, .8, 0, 1)
		self.frame:SetScript("OnShow", function() self:OnShow() end)
		
		-- Create sub-frames
		-- Editbox for search text
		self.frame.SearchBox = CreateFrame("EditBox", nil, self.frame, "InputBoxTemplate")
		self.frame.SearchBox:SetAutoFocus(false)
		self.frame.SearchBox:SetWidth(110)
		self.frame.SearchBox:SetHeight(20)
		self.frame.SearchBox:SetPoint("LEFT", self.frame, "LEFT", 20, 0)
		self.frame.SearchBox:SetBackdropColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b)
		self.frame.SearchBox:SetBackdropBorderColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b)
		self.frame.SearchBox:SetScript("OnEnterPressed", function() self:Search(this:GetText()) end)
		
		-- Reset Button
		self.frame.ResetButton = CreateFrame("Button", nil, self.frame, "GameMenuButtonTemplate")
		self.frame.ResetButton:SetWidth(20)
		self.frame.ResetButton:SetHeight(25)
		self.frame.ResetButton:SetPoint("RIGHT", self.frame, "RIGHT", -15, 0)
		self.frame.ResetButton:SetText(self.LOCALS.FRAME_RESET_TEXT)
		self.frame.ResetButton:SetScript("OnClick", function() self:Reset() end)
		
		-- Submit Button
		self.frame.SubmitButton = CreateFrame("Button", nil, self.frame, "GameMenuButtonTemplate")
		self.frame.SubmitButton:SetWidth(20)
		self.frame.SubmitButton:SetHeight(25)
		self.frame.SubmitButton:SetPoint("RIGHT", self.frame.ResetButton, "LEFT", -10, 0)
		self.frame.SubmitButton:SetText(self.LOCALS.FRAME_SUBMIT_TEXT)
		self.frame.SubmitButton:SetScript("OnClick", function() self:Search(self.frame.SearchBox:GetText()) end)
	
		-- SearchType dropdown button to show the menu when clicked.
		self.frame.SearchTypeButton = CreateFrame("Button", nil, self.frame, "GameMenuButtonTemplate")
		self.frame.SearchTypeButton:SetWidth(70)
		self.frame.SearchTypeButton:SetHeight(25)
		self.frame.SearchTypeButton:SetPoint("LEFT", self.frame.SearchBox, "RIGHT", 8, 0)
		self.frame.SearchTypeButton:SetText("Type")
		self.frame.SearchTypeButton:SetScript("OnClick", function() 
				if ( dewdrop:IsOpen(self.frame.SearchTypeButton) ) then 
					dewdrop:Close()	
				else 
					dewdrop:Open(self.frame.SearchTypeButton) 
				end
			end
		)	
		
		-- Create the SearchType dropdown menu
		dewdrop:Register(self.frame.SearchTypeButton,
			'point', function (parent)
				return "TOPLEFT", "BOTTOMLEFT"
			end,
			'dontHook', true,
			'children', function ()
				dewdrop:AddLine(
					'text', cgc.LOCALS.FRAME_SEARCH_TYPE_TITLE,
					'isTitle', true
				)
				for i,type in self.LOCALS.FRAME_SEARCH_TYPES do
					dewdrop:AddLine(
						'text', type,
						'func', function(val)
							self.setSearchType(val)
							self.frame.SearchTypeButton:SetText(val)
						end,
						'arg1', type,
						'tooltipTitle', type,
						'tooltipText', self.LOCALS.FRAME_SEARCH_TYPES_DESC[i],
						'closeWhenClicked', true
					)
				end
			end
		)
		
		-- Link Reagents dropdown button to show the menu when clicked.
		self.frame.LinkReagentButton = CreateFrame("Button", nil, self.frame, "GameMenuButtonTemplate")
		self.frame.LinkReagentButton:SetWidth(50)
		self.frame.LinkReagentButton:SetHeight(25)
		self.frame.LinkReagentButton:SetPoint("LEFT", self.frame.SearchTypeButton, "RIGHT", 8, 0)
		self.frame.LinkReagentButton:SetText(self.LOCALS.FRAME_LINK_REAGENTS)
		self.frame.LinkReagentButton:SetScript("OnClick", function() 
				if ( dewdrop:IsOpen(self.frame.LinkReagentButton) ) then 
					dewdrop:Close()	
				else 
					dewdrop:Open(self.frame.LinkReagentButton) 
				end
			end
		)
		
		-- Create the LinkReagents dropdown menu
		dewdrop:Register(self.frame.LinkReagentButton,
			'point', function (parent)
				return "TOPLEFT", "BOTTOMLEFT"
			end,
			'dontHook', true,
			'children', function ()
				dewdrop:AddLine(
					'text', cgc.LOCALS.FRAME_LINK_REAGENTS_TITLE,
					'isTitle', true
				)
				for i,channel in self.LOCALS.FRAME_LINK_TYPES do
					-- There are two types lines: 
					-- 1. Those that are straightforward and do not require user input
					-- 2. Those that require the user to input information to take it a step further.
					-- channel[1] is the "common name"
					-- channel[2] is the "channel"
					-- channel[3] is the "desc"
					if ( channel[2] ~= "WHISPER" and channel[2] ~= "CHANNEL" ) then
						dewdrop:AddLine(
							'text', channel[1],
							'func', function(val)
								self:SendReagentsMessage(val, nil)
							end,
							'arg1', channel[2],
							'closeWhenClicked', true
						)
					else
						dewdrop:AddLine(
							'text', channel[1],
							'hasArrow', true,
							'hasEditBox', true,
							'tooltipTitle', channel[1],
							'tooltipText', channel[3],
							'editBoxFunc', function(channel, text)
								self:SendReagentsMessage(channel, text)
							end,
							'editBoxArg1', channel[2]
						)
					end
				end
			end
		)
	end
	
	-- If the mod was disabled when WoW loaded, then the main frame will not be visible. So we'll make it visible again.
	if ( getglobal(frames.trade.elements.Main) and getglobal(frames.trade.elements.Main):IsShown() ) then
		cgc:TRADE_SKILL_SHOW()
	elseif ( getglobal(frames.craft.elements.Main) and getglobal(frames.craft.elements.Main):IsShown() ) then
		cgc:CRAFT_SHOW()
	end
end

function cgc:OnDisable()
	if self.frame then
		self.frame:Hide()
	end
	
	-- Clear our search history and current search text.
	self.clearHistory()
	self.searchText = ""
	
	-- Finally, update the trade/craft windows just in case we have any lingering search results.
	if ( self.hooks and self.hooks[frames.trade.update] ) then
		getglobal(frames.trade.update)()
	end
	
	if ( self.hooks and self.hooks[frames.craft.update] ) then
		getglobal(frames.craft.update)()
	end
end

function cgc:OnShow()
	self:Debug("OnShow called.")
	-- Insert previous search text, if any.
	if self.searchText ~= nil then
		self.frame.SearchBox:SetText(self.searchText)
	end
	
	self:Debug("OnShowCurrentWindow:"..getglobal(self.currentFrame.elements.Title):GetText())
	-- Update the "Type" dropdown so that it reflects the current searchType or "Name" by default.
	if ( self.getSearchType() ~= nil ) then
		self.frame.SearchTypeButton:SetText(self.getSearchType())
	else
		self.frame.SearchTypeButton:SetText(self.getSearchType(1))
	end
end
	
function cgc:CRAFT_SHOW()
	self:Debug("Crafting window open.")
	-- first time window has been opened
	if ( not self.hooks or not self.hooks[frames.craft.update] ) then
		self:Debug("First time crafting window has opened, register close and hooking the update.")
		self:RegisterEvent("CRAFT_CLOSE", "OnClose")
		self:Hook(frames.craft.update, function () self:Update(true) end)
	end
	
	-- Have to set our current frame for the widgets that load.
	self.currentFrame = frames.craft
	
	-- Is the tradeskill window open? If so we'll need to close it.
	if ( getglobal(frames.trade.elements.Main) and getglobal(frames.trade.elements.Main):IsShown() ) then
		getglobal(frames.trade.elements.Main):Hide()
	end
	
	-- We need to dynmically position the addon because the trade/craft anchors are different.
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOPRIGHT", frames.craft.anchor, "BOTTOMRIGHT" , frames.craft.anchor_offset_x, frames.craft.anchor_offset_y)
	-- Check if the frame was already shown, which means they just changed tradeskills and no update with the OnShow.
	-- Otherwise, lets just show the frame.
	if ( self.frame:IsShown() ) then
		self:OnShow()
	else
		self.frame:Show()
	end

	-- Run our update.
	self:Update(true)
end

function cgc:TRADE_SKILL_SHOW()
	self:Debug("Tradeskill window open.")
	-- first time window has been opened
	if ( not self.hooks or not self.hooks[frames.trade.update] ) then
		self:Debug("First time trade skill window has opened, register close and hooking the update.")
		self:RegisterEvent("TRADE_SKILL_CLOSE", "OnClose")
		self:Hook(frames.trade.update, function () self:Update() end)
		
		-- Check if AutoCraft exists, if it does we're going to have to anchor to something different.
		if ( AutoCraftFrame ) then 
			frames.trade.anchor = "AutoCraftRunAutomatically"
			frames.trade.anchor_offset_x = -7
		end
	end
		
	-- Have to set our current frame for the widgets that load.
	self.currentFrame = frames.trade
	
	-- Is the crafting window open? If so we'll need to close it.
	if ( getglobal(frames.craft.elements.Main) and getglobal(frames.craft.elements.Main):IsShown() ) then
		getglobal(frames.craft.elements.Main):Hide()
	end
	
	-- We need to dynmically position the addon because the trade/craft anchors are different.
	self.frame:ClearAllPoints()
	self.frame:SetPoint("TOPLEFT", getglobal(frames.trade.anchor), "BOTTOMLEFT" , frames.trade.anchor_offset_x, frames.trade.anchor_offset_y)
	-- Check if the frame was already shown, which means they just changed tradeskills and no update with the OnShow.
	-- Otherwise, lets just show the frame.
	if ( self.frame:IsShown() ) then
		self:OnShow()
	else
		self.frame:Show()
	end
	
	-- Run the update.
	self:Update()
end

function cgc:OnClose()
	self:Debug("Tradeskill/Craft window close.")
	self.frame:Hide()
end

function cgc:Update(craft) 
	self:Debug("cgc:Update called.")

	-- Update the search history and searh type dropdown
	self.setHistory(self.searchText)
	-- The user has changed their trade window, reset the search text if they haven't searched before
	if ( not self.lastSearchTrade or self.lastSearchTrade ~= getglobal(self.currentFrame.elements.Title):GetText() ) then
		-- Now we update last searched to the current trade/craft type/window name
		self.lastSearchTrade = getglobal(self.currentFrame.elements.Title):GetText()
		-- Does old text for the current window exist? 
		if ( self.getHistory(self.lastSearchTrade) ) then
			self:Debug("Found history: "..self.lastSearchTrade)
			self.searchText = self.getHistory(self.lastSearchTrade)
		else
			self:Debug("No history, searchText=''")
			self.searchText = ""
		end
		-- Finally, update the actual searchbox.
		self.frame.SearchBox:SetText(self.searchText)
	end
	
	-- The user has decided to search for 
	if ( self:GetSearchText() and getglobal(self.currentFrame.elements.Main):IsShown() ) then
		local searchType = self.getSearchType()
		local skillOffset = FauxScrollFrame_GetOffset(getglobal(self.currentFrame.elements.Scroll))	
		local skillButton = nil
		
		-- Keeps the list from being rebuilt unncessarily when the user is scrolling through search results.
		if ( self.found and getn(self.found) == 0 ) then
			if ( searchType == "Reagent" ) then
				-- search by reagent results
				self:BuildListByReagent(self:GetSearchText(), craft)
			elseif ( searchType == "Requires" ) then
				-- search by requires results
				self:BuildListByRequire(self:GetSearchText(), craft)
			else
				-- search by name results
				self:BuildListByName(self:GetSearchText(), craft)
			end
		end
						
		-- If we're doing tradeskills, we don't have categories, so we don't need a collapse.
		if ( not craft ) then
			getglobal(frames.trade.elements.CollapseAll):Disable();
		end
		
		-- Update the scroll frame.
		FauxScrollFrame_Update(getglobal(self.currentFrame.elements.Scroll), getn(self.found), (craft and CRAFTS_DISPLAYED or TRADE_SKILLS_DISPLAYED), (craft and CRAFT_SKILL_HEIGHT or TRADE_SKILL_HEIGHT), nil, nil, nil, getglobal(self.currentFrame.elements.Highlight), 293, 316 )
		getglobal(self.currentFrame.elements.Highlight):Hide()
		
		if ( getn(self.found) > 0 ) then
			-- Do the actual display of the list now.
			for i=1, (craft and CRAFTS_DISPLAYED or TRADE_SKILLS_DISPLAYED), 1 do
				local skillIndex = i + skillOffset
				skillButton = getglobal((craft and "Craft" or "TradeSkillSkill")..i)
				
				if ( i <= getn(self.found) ) then
					-- Set button widths if scrollbar is shown or hidden
					if ( getglobal(self.currentFrame.elements.Scroll):IsVisible() ) then
						skillButton:SetWidth(293)
					else
						skillButton:SetWidth(323)
					end
					
					self:Debug("self.found["..skillIndex.."].type="..self.found[skillIndex].type)
					local color = (craft and CraftTypeColor[self.found[skillIndex].type] or TradeSkillTypeColor[self.found[skillIndex].type])
					if ( color ) then
						skillButton:SetTextColor(color.r, color.g, color.b)
					end
					skillButton:SetID(self.found[skillIndex].index)
					skillButton:Show()
					
					if ( self.found[skillIndex].name == "" ) then
						return
					end
					
					skillButton:SetNormalTexture("")
					getglobal((craft and "Craft" or "TradeSkillSkill")..i.."Highlight"):SetTexture("")
					if ( self.found[skillIndex].available == 0 ) then
						skillButton:SetText(" "..self.found[skillIndex].name)
					else
						skillButton:SetText(" ".. self.found[skillIndex].name .." [".. self.found[skillIndex].available .."]")
					end
					
					-- Place the highlight and lock the highlight state
					if ( (craft and GetCraftSelectionIndex() or GetTradeSkillSelectionIndex()) == self.found[skillIndex].index ) then
						getglobal(self.currentFrame.elements.Highlight):SetPoint("TOPLEFT", skillButton, "TOPLEFT", 0, 0)
						getglobal(self.currentFrame.elements.Highlight):Show()
						skillButton:LockHighlight()
						-- Setting the num avail so the create all button works for tradeskills
						if (not craft and getglobal(frames.trade.elements.Main)) then
							getglobal(self.currentFrame.elements.Main).numAvailable = self.found[skillIndex].available
						end
					else
						-- The highlight is shown, but it's on an entry that we haven't selected. Probably a remnant from a selection before we did our search,
						-- so we'll go ahead and hide the frame.
						if ( not self:SelectionInList(skillOffset, craft)  ) then
							getglobal(self.currentFrame.elements.Highlight):Hide()
						end
						skillButton:UnlockHighlight()
					end
				else
					skillButton:Hide()					
				end
			end
		else
			getglobal(self.currentFrame.elements.Scroll):Hide()
			for i=1, (craft and CRAFTS_DISPLAYED or TRADE_SKILLS_DISPLAYED), 1 do
				skillButton = getglobal((craft and "Craft" or "TradeSkillSkill")..i)
				
				skillButton:SetWidth(323)
				skillButton:SetTextColor(1, 1, 1)
				skillButton:SetID(1)
				skillButton:SetNormalTexture("")
				getglobal((craft and "Craft" or "TradeSkillSkill")..i.."Highlight"):Hide()
				skillButton:UnlockHighlight();
				skillButton:Show()
				
				if ( i == 1 ) then
					getglobal(self.currentFrame.elements.Highlight):Hide()
					skillButton:SetText(self.LOCALS.FRAME_NO_RESULTS)
				else 
					skillButton:SetText("")
				end
			end
		end
	else
		cgc:Debug("Calling original update functions:"..(craft and frames.craft.update or frames.trade.update))
		self.hooks[ craft and frames.craft.update or frames.trade.update ].orig()
	end
end

----------------------------------------
-- Retrieve the current searchText.
function cgc:GetSearchText()
	-- The second argument is a search with only spaces.
	if ( self.searchText ~= nil and string.len(string.gsub(self.searchText, "%s", "")) > 0 ) then
		return self.searchText
	else
		return false
	end
end

----------------------------------------
-- Begin the search and clear out the scrolling frame so it's not out of position.
function cgc:Search(searchText)
	self:Debug("Search called; currentFrame="..self.currentFrame.elements.Main)
	self.searchText = self.frame.SearchBox:GetText()
	-- Need to reset / create our self.found array.
	self.found = {}
	
	self.frame.SearchBox:ClearFocus()
	-- We have to clear the offset on the scroll frame, otherwise we error out and it's misscrolled.
	-- self.currentFrame = (getglobal(frames.craft.elements.Main) and getglobal(frames.craft.elements.Main):IsShown() and "CraftListScrollFrame" or getglobal(frames.trade.elements.Main) and getglobal(frames.trade.elements.Main):IsShown() and "TradeSkillListScrollFrame"
	FauxScrollFrame_SetOffset(getglobal(self.currentFrame.elements.Main), 0)
	getglobal(self.currentFrame.elements.ScrollBar):SetValue(0)
	-- Finally, do the update.
	self:Update(getglobal(frames.craft.elements.Main) and getglobal(frames.craft.elements.Main):IsShown())
end

----------------------------------------
-- Reset the skill frames.
function cgc:Reset()
	self.searchText = ""
	self.frame.SearchBox:ClearFocus();
	self.frame.SearchBox:SetText(self.searchText);
	self.clearHistory()
	self:Update(getglobal(frames.craft.elements.Main) and getglobal(frames.craft.elements.Main):IsShown())
end

--[[ ---------------------------------------------------------------------------------------------------- ]]--
-- Building functions which do the bulk work of this mod.  They traverse through the current skill opened
-- and check for any matches against the users requested searchText, or build chat links to be sent
-- through SendChatMessage()
--[[ ---------------------------------------------------------------------------------------------------- ]]--

----------------------------------------
-- Build search list by item name.
function cgc:BuildListByName(searchText, craft)
	local foundIndex = 0
	self.found = {}
	
	if ( craft ) then
		self:Debug("BuildingListByName for crafting.")
	end
	
	local skillName, skillType, numAvailable, isExpanded
	for i=1, (craft and GetNumCrafts() or GetNumTradeSkills()), 1 do
		if ( craft ) then
			skillName, _, skillType, numAvailable, isExpanded = GetCraftInfo(i)
		else
			skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(i)
		end
		
		if ( strfind(string.lower(skillName), string.lower(searchText)) and skillType ~= "header" ) then
			cgc:Debug("Match #"..foundIndex..": skillType="..skillType)
			foundIndex = foundIndex + 1
			self.found[foundIndex] = {}
			self.found[foundIndex] = {
				name			= skillName,
				type 			= skillType,
				available		= numAvailable,
				index 			= i
			}	
		elseif ( skillType == "header" and not isExpanded ) then
			-- We need to expand any unexpanded header types, otherwise we can't parse their sub data.
			ExpandTradeSkillSubClass(i)
		end
	end
	
	self:Debug("We found ".. foundIndex .." matches.")
end

----------------------------------------
-- Build search list by required.
function cgc:BuildListByRequire(searchText, craft)
	local foundIndex = 0
	self.found = {}

	local skillName, skillType, numAvailable, isExpanded
	local requires 	
	for i=1, (craft and GetNumCrafts() or GetNumTradeSkills()), 1 do
		if ( craft ) then
			skillName, _, skillType, numAvailable, isExpanded = GetCraftInfo(i)
			requires = GetCraftSpellFocus(i)
		else
			skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(i)
			requires = GetTradeSkillTools(i)
		end
		
		if ( requires and strfind(string.lower(BuildColoredListString(requires)), string.lower(searchText)) and skillType ~= "header" ) then
			self:Debug("Found matching require for '"..searchText.."': "..requires.." ")
			foundIndex = foundIndex + 1
			self.found[foundIndex] = {}
			self.found[foundIndex] = {
				name			= skillName,
				type 			= skillType,
				available		= numAvailable,
				index 			= i
			}	
		elseif ( skillType == "header" and not isExpanded ) then
			-- We need to expand any unexpanded header types, otherwise we can't parse their sub data.
			ExpandTradeSkillSubClass(i)
		end
	end
end

----------------------------------------
-- Build search list reagent name.
function cgc:BuildListByReagent(searchText, craft)
	local foundIndex = 0
	self.found = {}
	
	local skillName, skillType, numAvailable, isExpanded, reagentName
	for i=1, (craft and GetNumCrafts() or GetNumTradeSkills()), 1 do
		if ( craft ) then
			skillName, _, skillType, numAvailable, isExpanded = GetCraftInfo(i)
		else
			skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(i)
		end
		
		if ( skillType ~= "header" ) then
			for e=1, (craft and GetCraftNumReagents(i) or GetTradeSkillNumReagents(i)), 1 do
				if ( craft ) then
					reagentName, _, _, _ = GetCraftReagentInfo(i, e)
				else
					reagentName, _, _, _ = GetTradeSkillReagentInfo(i, e)
				end
				
				
				if ( reagentName and strfind(string.lower(reagentName), string.lower(searchText)) ) then
					foundIndex = foundIndex + 1
					self.found[foundIndex] = {}
					self.found[foundIndex] = {
						name			= skillName,
						type 			= skillType,
						available		= numAvailable,
						index 			= i
					}	
					-- Some reagents can share a similar name so if we already matched one, we can break here.
					break
				end
			end
		elseif ( skillType == "header" and not isExpanded ) then
			-- We need to expand any unexpanded header types, otherwise we can't parse their sub data.
			ExpandTradeSkillSubClass(i)
		end
	end
end

----------------------------------------
-- Utility function to reagent information to chat.
function cgc:SendReagentsMessage(channel, who)
	local sIndex, itemString
	local tempString = ""
	local reagentLinks = {}
	local reagentCounts = {}
	local craft = getglobal(frames.craft.elements.Main) and getglobal(frames.craft.elements.Main):IsShown()
	
	-- Figure out which window is open or exit function
	if ( getglobal(self.currentFrame.elements.Main):IsShown() ) then
		sIndex = craft and GetCraftSelectionIndex() or GetTradeSkillSelectionIndex()
		self:Debug("SRM: GetTradeSkillSelectionIndex="..GetTradeSkillSelectionIndex())
	else
		return
	end
	
	self:Debug("SRM: sIndex = "..sIndex)
	-- Double check the user has a skill selected.
	if ( sIndex > 0 ) then
		-- Insert the name first.
		itemString = craft and GetCraftItemLink(sIndex) or GetTradeSkillItemLink(sIndex)
		
		-- Cycle through all the reagents and get the required amounts for each into two nice arrays
		for rIndex=1, (craft and GetCraftNumReagents(sIndex) or GetTradeSkillNumReagents(sIndex)), 1 do
			if ( craft ) then
				reagentLinks[rIndex] = GetCraftReagentItemLink(sIndex, rIndex) 
				_, _, reagentCounts[rIndex], _ = GetCraftReagentInfo(sIndex, rIndex) 
			else
				reagentLinks[rIndex] = GetTradeSkillReagentItemLink(sIndex, rIndex)
				_, _, reagentCounts[rIndex], _ = GetTradeSkillReagentInfo(sIndex, rIndex) 
			end
		end
		
		-- Now we'll make strings out of them, 4 reagent links at a time and print them out when we reach our limit.
		
		for i=1, getn(reagentLinks) do 
			tempString = tostring(tempString) .. reagentLinks[i] .. "x" .. reagentCounts[i] .. " "
			if ( mod(i,3) == 0 or i == getn(reagentLinks) ) then
				-- Combine the item name, add (cont) if this is the second go round.
				tempString = itemString .. (i > 3 and " (cont) = " or " = ")  .. tempString
				SendChatMessage(tempString, channel, GetDefaultLanguage("player"), who)
				tempString = ""
			end
		end
	end
end

----------------------------------------
-- Utility function for Update(): checks to see if the selected item is currently visible in the scrolling frame.
function cgc:SelectionInList(skillOffset, craft)
	for i=skillOffset+1, skillOffset+(craft and CRAFTS_DISPLAYED or TRADE_SKILLS_DISPLAYED), 1 do
		if ( self.found[i] and self.found[i].index == (craft and GetCraftSelectionIndex() or GetTradeSkillSelectionIndex()) ) then
			return true
		end
	end
	
	return false
end