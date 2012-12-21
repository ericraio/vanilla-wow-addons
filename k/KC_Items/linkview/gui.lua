local locals = KC_ITEMS_LOCALS.modules.linkview

local frame = AceGUI:new()
local config = {
	name	  = "KC_LinkviewFrame",
	type	  = ACEGUI_DIALOG,
	title	  = locals.gui.title,
	isSpecial = TRUE,
	width	  = 375,
	height	  = 500,
	OnShow	  = "Build",
	OnHide	  = "Cleanup",
	elements  = {
		SortBox	 = {
			type	 = ACEGUI_OPTIONSBOX,
			title	 = locals.gui.sortopt,
			width	 = 351,
			height	 = 46,
			anchors	 = {
				topleft	= {xOffset = 12, yOffset = -37}
			},
			elements = {
				Tier1	 = {
					type	 = ACEGUI_DROPDOWN,
					title	 = locals.gui.tier1,
					width	 = 103,
					height	 = 26,
					anchors	 = {
						topleft = {xOffset = 5, yOffset = -15}
					},
					fill	 = "FillSortDrops",
				},
				Tier2	 = {
					type	 = ACEGUI_DROPDOWN,
					title	 = locals.gui.tier2,
					width	 = 103,
					height	 = 26,
					anchors	 = {
						left = {relTo = "$parentTier1", relPoint = "right", xOffset = 4, yOffset = 0}
					},
					fill	 = "FillSortDrops",
				},
				Tier3	 = {
					type	 = ACEGUI_DROPDOWN,
					title	 = locals.gui.tier3,
					width	 = 103,
					height	 = 26,
					anchors	 = {
						left = {relTo = "$parentTier2", relPoint = "right", xOffset = 4, yOffset = 0}
					},
					fill	 = "FillSortDrops",
				},
				Order  = {
					type	 = ACEGUI_BUTTON,
					title	 = "^",
					width	 = 20,
					height	 = 24,
					anchors	 = {
						left = {relTo = "$parentTier3", relPoint = "right", xOffset = 1, yOffset = 0}
					},
					disabled = FALSE,
					OnClick	 = "Sort"
				},
			},
		},
		ItemsCount = {
			type	 = ACEGUI_BUTTON,
			title	 = "",
			width	 = 320,
			height	 = 16,
			anchors	 = {
				bottomright = {relTo = "$parentItems", relPoint = "topright", xOffset = -5, yOffset = -1}
			},
			disabled = TRUE,
		},
		Items	 = {
			type	 = ACEGUI_LISTBOX,
			title	 = locals.gui.items,
			width	 = 351,
			height	 = 320,
			anchors	 = {
				topleft = {relTo = "$parentSortBox", relPoint = "bottomleft", xOffset = 0, yOffset = -14}
			},
			fill		= "FillItemsListBox",
			OnItemEnter = "OnItemEnter",
			OnItemLeave = "OnItemLeave",
			OnSelect	= "OnSelect",
		},
		SearchBox	 = {
			type	 = ACEGUI_OPTIONSBOX,
			title	 = locals.gui.searchopt,
			width	 = 251,
			height	 = 50,
			anchors	 = {
				bottomleft	= {relPoint = "bottomleft", xOffset = 12, yOffset = 16}
			},
			elements = {
				SearchText = {
					type			= ACEGUI_INPUTBOX,
					title			= locals.gui.searchtxt,
					width			= 165 ,
					height			= 26,
					anchors			= {
						left  = {relPoint = "left", xOffset = 12, yOffset = -5}					
					},
					disabled = FALSE,
					OnEnterPressed	= "SimpleSearch"
				},
				SearchButton  = {
					type	 = ACEGUI_BUTTON,
					title	 = locals.gui.search,
					width	 = 68,
					height	 = 22,
					anchors	 = {
						bottomleft = {relTo = "$parentSearchText", relPoint = "bottomright", xOffset = -3, yOffset = 2}
					},
					disabled = FALSE,
					OnClick	 = "SimpleSearch"
				},
			},
		},
		AdvSearchButton  = {
			type	 = ACEGUI_BUTTON,
			title	 = locals.gui.advsearch,
			width	 = 98,
			height	 = 22,
			anchors	 = {
				bottomleft = {relTo = "$parentClose", relPoint = "topleft", xOffset = 0, yOffset = -1}
			},
			disabled = FALSE,
			OnClick	 = "AdvSearch"
		},
	}
}

frame:Initialize(KC_Linkview, config)
KC_Linkview.gui = frame

function frame:OnItemEnter()
	if (not self.idTable) then return; end
	GameTooltip:SetOwner(this, "ANCHOR_" .. strupper(self.app:GetOpt(self.app.optPath, "side") or "LEFT"));
	GameTooltip:SetHyperlink(self.idTable[this.rowID])
	local _,_,_,_,_,_,_,_,texture = GetItemInfo(self.idTable[this.rowID])
	KC_LinkviewIconTexture:SetTexture(texture)
	KC_LinkviewIcon:Show()
end

function frame:OnItemLeave()
	KC_LinkviewIcon:Hide()
	GameTooltip:Hide()
end

function frame:FillSortDrops()
	return locals.gui.sortlist
end

function frame:FillItemsListBox()
	return self.sortedTable or {locals.gui.please};
end

function frame:BuildSearchTable(pattern)
	
	local id, name, matches
	self.totalLinks		= 0
	self.goodLinks		= 0
	self.matchedLinks	= 0
	self.searchTable	= {}

	for id in KC_ItemsDB do
		if (tonumber(id)) then
			local info = self.app.common:GetItemInfo(tostring(id))
			name = self.app.common:GetItemInfo(id)["cname"]

			self.app.gui.totalLinks = self.app.gui.totalLinks + 1
			self.app.gui.goodLinks = name and self.app.gui.goodLinks + 1 or self.app.gui.goodLinks
			
			if ((name) and strfind(strlower(name or ""), strlower(pattern or ""))) then
				self.searchTable[id] = name
				self.matchedLinks = self.matchedLinks + 1
				table.setn(self.searchTable, self.matchedLinks)
			end

		end
	end
	self:Build()
end

function frame:BuildSortedTable()
	if (not self.searchTable or getn(self.searchTable) == 0) then self.sortedTable = {locals.gui.nothing}; self.idTable = nil; return; end
	
	self.sortedTable = {} 
	self.idTable = {}

	local crossTable, sortTable = {}, {}
	
	local method1 = self.SortBox.Tier1:GetValue()
	local method2 = self.SortBox.Tier2:GetValue()
	local method3 = self.SortBox.Tier3:GetValue()
	local method4 = (method1 and method2 and method3) and "" or locals.gui.name
	local x = 1

	for id in self.searchTable do
		local data = self.app.common:GetItemInfo(id)
		local key = (data[locals.gui.translist[method1]] or "") .. (data[locals.gui.translist[method2]] or "") .. (data[locals.gui.translist[method3]] or "") .. (data[locals.gui.translist[method4]] or "")
		local orgkey = key

		while (crossTable[key]) do
			key = orgkey .. x
			x = x + 1
		end
		tinsert(sortTable, key)
		crossTable[key] = id
	end
	
	sort(sortTable)

	for id, value in sortTable do
		tinsert(self.sortedTable, self.searchTable[crossTable[value]])
		tinsert(self.idTable, self.app.common:GetHyperlink(crossTable[value]))
	end
end

function frame:SimpleSearch()
	local pattern = self.SearchBox.SearchText:GetValue()
	pattern = pattern and ace.trim(pattern) or nil
	self:BuildSearchTable(pattern)
	self:BuildSortedTable()
	self.Items:ClearList()
	self.Items:Update()
end

function frame:Sort()
	self:BuildSortedTable()
	self.Items:ClearList()
	self.Items:Update()
end

function frame:AdvSearch()
	if (KC_AdvSearchFrame:IsVisible()) then
		self.app.advsearch:Hide()
		self.SearchBox.SearchText:Enable()
		self.SearchBox.SearchButton:Enable()
	else
		self.app.advsearch:Show()
		self.SearchBox.SearchText:Disable()
		self.SearchBox.SearchButton:Disable()
	end
end

function frame:Build()
	for i = 1, 18 do
		self.Items["Row"..i]:RegisterForClicks("LeftButtonDown", "RightButtonDown")
	end
	self.ItemsCount:SetValue(format(locals.gui.stats, self.totalLinks or "0", self.goodLinks or "0", self.matchedLinks or "0") or "");
end

function frame:Cleanup()
	self.totalLinks		= 0
	self.goodLinks		= 0
	self.matchedLinks	= 0
	self.searchTable	= nil
	self.idTable		= nil
	self.sortedTable	= nil
	self.Items:ClearList()
	self.app.advsearch:Hide()
end

function frame:OnSelect()
	if (not self.idTable) then return; end
	local id = self.idTable[this.rowID]

	if (arg1 ~= "LeftButton") then
		
	elseif( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then
		ChatFrameEditBox:Insert(self.app.common:GetTextLink(id))
	elseif (IsControlKeyDown()) then
		DressUpItemLink(id)
	else
		SetItemRef(id, self.app.common:GetTextLink(id), arg1)
	end
end