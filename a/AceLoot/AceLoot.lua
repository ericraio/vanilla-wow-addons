AceLoot = {}

-- German Localization
	function AceLoot_Locals_deDE()
	
		AceLoot.Const = {
			CmdOptions = {
		 		{	option	=	"mode",
		 			desc		=	"Nur einmal positionieren.",
		 			method	=	"Toggle",
		 		}
		 	},
			Chat = {
				Toggle   = "Nur einmal positionieren."
			}
		}
		
	 	ace:RegisterGlobals({
							version			=	2.0,
							translation	= "deDE",
							ACEG_ON  		= "|cff00ff00An|r",
							ACEG_OFF	 	= "|cffff5050Aus|r",
	 	})
	end
	
-- English Localization
	if not ace:LoadTranslation("AceLoot") then
	
		AceLoot.Const = {
			CmdOptions = {
		 		{	option	=	"mode",
		 			desc		=	"Only position once.",
		 			method	=	"Toggle",
		 		}
		 	},
			Chat = {
				Toggle   = "Only position once."
			}
		}
		
	 	ace:RegisterGlobals({
							version			=	2.0,
								ACEG_ON   = "|cff00ff00On|r",
								ACEG_OFF 	= "|cffff5050Off|r",
	 	})
	end

-- MainCode
	local const = AceLoot.Const
	
AceLoot.Obj			= AceAddon:new({
	name					= "AceLoot",
	version       = " a./R9." .. string.sub("$Revision: 3091 $", 12, -3), 
	releaseDate   = string.sub("$Date: 2006-06-21 20:52:26 +0200 (Mi, 21 Jun 2006) $", 8, 17), 
	author				= "Neriak",
	email					= "pk@neriak.de",
	website				= "http://neriak_x.wowinterface.com",
	aceCompatible	= 103,
	category			= ACE_CATEGORY_INTERFACE,
	db						= AceDatabase:new("AceLootDB"),
	cmd						= AceChatCmdClass:new({"/aceloot", "/al"},const.CmdOptions),


--[[---------------------------
 Hooking and Event Registration
-----------------------------]]

	Enable = function(self)
		UIPanelWindows["LootFrame"] = nil
		LootFrame:SetMovable(1)
		LootFrame:SetFrameStrata("DIALOG")
		LootFrame:SetScript("OnMouseUp", function () this:StopMovingOrSizing() end)
		LootFrame:SetScript("OnMouseDown", function () this:StartMoving() end)
		self:RegisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("PLAYER_LEAVING_WORLD")
		self:Reg()
	end,

	PLAYER_ENTERING_WORLD = function(self)
		self:Reg()
	end,
	
	PLAYER_LEAVING_WORLD = function(self)
		self:UnregisterEvent("LOOT_OPENED")
		self:UnregisterEvent("LOOT_SLOT_CLEARED")
		self:UnregisterEvent("LOOT_CLOSED")

		self.registered = nil
	end,
	
	Reg = function(self)
		if self.registered then self:debug("Events already registered") return end
		self:RegisterEvent("LOOT_OPENED", "ItemUnderCursor")
		self:RegisterEvent("LOOT_SLOT_CLEARED", "ItemUnderCursor")
		self:RegisterEvent("LOOT_CLOSED")
		self.registered = true
	end,
	
--[[----------------------------------------------------
	Main Function taken and improved from Telo's QuickLoot
------------------------------------------------------]]

	ItemUnderCursor = function(self)
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
				if self:IsOnce() then self.called = true return end
					return
			end 
		end
		if LootFrameDownButton:IsVisible() then
			x = x - 158
			y = y + 223
			self:LootFrame_SetPoint(x,y)
		end
	end,
	
	LOOT_CLOSED = function(self)
	 self.called = nil
	end,
	
-- code submitted by hshh on www.wowace.com
	LootFrame_SetPoint = function(self, x, y)
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
	end,

	AutoClose = function(self)
		if GetNumLootItems() == 0 then
			HideUIPanel(LootFrame)
				return 
		end
	end,
	
	IsOnce = function(self)
		return self:Get("Once")
	end,
	
	Toggle = function(self)
		self:Tog("Once", const.Chat.Toggle.." [%s]")
	end,
	
	Report = function(self)
		self.cmd:report({
			{text=const.Chat.Toggle, val= self:Get("Once") and 1 or 0, map = ACEG_MAP_ONOFF}
		})
	end
})

--[[------------------------
	The End -> Register Object
--------------------------]]
AceLoot.Obj:RegisterForLoad()

-- The Util Functions
	ace:RegisterFunctions(AceLoot.Obj,{
		version= 1.3,
			Get = function(self, var)	if type(self) == "string" then ace:print("! ERROR: "..self)	end	
				return self.db:get(self.profilePath, var)	end,
			Set = function(self, var, val) self.db:set(self.profilePath, var, val) end,
			Tog = function(self, var, c) self.cmd:result(format(c, self.db:toggle(self.profilePath, var) and ACEG_ON or ACEG_OFF))	end
	})
