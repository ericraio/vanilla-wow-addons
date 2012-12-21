local L = AceLibrary("AceLocale-2.0"):new("FruityLoots")
FruityLoots = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")

	function FruityLoots:OnInitialize()
		self:RegisterDB("FruityLootsDB")
		self:RegisterChatCommand({ "/floots", "/fruityloots" }, {
			desc = self.notes,
			type = "group",
			args = {		
				mode = {
					name = L"Once", 
					desc = L"Once",
					type = "toggle",
					get = function() return self.db.profile.Once end,
					set = function(v)
						self.db.profile.Once = v
					end,
				}
			}
		})
	end

	function FruityLoots:OnEnable()
		UIPanelWindows["LootFrame"] = nil
		LootFrame:SetMovable(1)
		LootFrame:SetFrameStrata("DIALOG")
		LootFrame:SetScript("OnMouseUp", function () this:StopMovingOrSizing() end)
		LootFrame:SetScript("OnMouseDown", function () this:StartMoving() end)
		self:RegisterEvent("LOOT_OPENED", "ItemUnderCursor")
		self:RegisterEvent("LOOT_SLOT_CLEARED", "ItemUnderCursor")
		self:RegisterEvent("LOOT_CLOSED")
	end

	function FruityLoots:OnDisable()
		self:UnregisterAllEvents()
	end


--[[------------------------------------------------------
	Main Function taken and improved from Telo's QuickLoot
----------------------------------------------------------]]

	function FruityLoots:ItemUnderCursor()
		self:AutoClose()
		if self.called then return end
		self.called = nil
		local x, y = GetCursorPosition()
		local s = LootFrame:GetEffectiveScale()
		x = x / s
		y = y / s
		for i = 1, LOOTFRAME_NUMBUTTONS, 1 do
			local button = getglobal("LootButton"..i)
			if button:IsVisible() then
				x = x - 29
				y = y + 66 + (40 * i)
				self:LootFrame_SetPoint(x,y)
				if self.db.profile.Once then self.called = true return end
					return
			end 
		end
		if LootFrameDownButton:IsVisible() then
			x = x - 158
			y = y + 223
			self:LootFrame_SetPoint(x,y)
		end
	end
	
	function FruityLoots:LOOT_CLOSED()
		 self.called = nil
	end
	
-- code submitted by hshh on www.wowace.com
	function FruityLoots:LootFrame_SetPoint(x, y)
		local screenWidth = GetScreenWidth()
		if (UIParent:GetWidth() > screenWidth) then screenWidth = UIParent:GetWidth() end
		local screenHeight = GetScreenHeight()
-- LootFrame is set to 256 wide in the xml file, but is actually only 191 wide
-- This is based on calculation envolving the offset on the close button:
-- The height is always 256, which is the correct number.
		local windowWidth = 191
		local windowHeight = 256
		if (x + windowWidth) > screenWidth then x = screenWidth - windowWidth end
		if y > screenHeight then y = screenHeight end
		if x < 0 then x = 0 end
		if (y - windowHeight) < 0 then y = windowHeight end
		LootFrame:ClearAllPoints()
		LootFrame:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", x, y)
	end

	function FruityLoots:AutoClose()
		if GetNumLootItems() == 0 then HideUIPanel(LootFrame) return end
	end