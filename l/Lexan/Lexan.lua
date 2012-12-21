--[[
	Lexan!
		BULLETPROOF GLASS ON YOUR AH, BANK AND MAIL WINDOWS!
</needless cheesiness>

By Neronix (Hellscream EU, neronix@gmail.com)
Portions of the AH protector code from Auctioneer
This mod is licensed under the GNU GPL
--]]

Lexan = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceConsole-2.0")

function Lexan:OnInitialize()
	-- No config table --> New user --> Create table and set default
    if ( not LexanConfig ) then
        LexanConfig = {
			Esc = false
        }
    end
	
	Lexan:RegisterChatCommand({ "/lexan" }, {
	desc = self.notes,
	type = "group",
	args = {
		esc = {
			name = 'Use Esc',
			desc = 'Toggle the ability for the Esc button to close the AH window',
			type = 'toggle',
			get = function() return LexanConfig.Esc; end,
			set = function(val) LexanConfig.Esc = val end,
		}
	}
})
end

function Lexan:OnEnable()
    self:Hook("ToggleGameMenu") -- Allows us to handle Esc closing the AH window
    self:Hook("ToggleWorldMap") -- Tame that mappy bitch!
    
    self:RegisterEvent("AUCTION_HOUSE_SHOW")
    self:RegisterEvent("AUCTION_HOUSE_CLOSED")
    
    -- If 1, then the user blocked trades him/herself, meaning we don't need to handle it.
    if ( GetCVar("BlockTrades") == "0" ) then
    
        self:RegisterEvent("MAIL_SHOW", "AntiTrade_ON")
        self:RegisterEvent("MAIL_CLOSED", "AntiTrade_OFF")
        self:RegisterEvent("BANKFRAME_OPENED", "AntiTrade_ON")
        self:RegisterEvent("BANKFRAME_CLOSED", "AntiTrade_OFF")
    end    
end

function Lexan:OnDisable() -- Just in case that the luser disables while protection is enforced, for whatever strange reason...
    self:AH_OFF()
    self:AntiTrade_OFF()
end

-- ToggleGameMenu is what Esc is bound to by default
function Lexan:ToggleGameMenu(clicked)
    -- If the user wants Esc to close the AH window, and the AH window's open,
    -- Then do the standard protection disabling routine and let the normal esc stuff handle everything else
    if LexanConfig.Esc == true and Lexan.AHProtected == true then
        self:AH_OFF()
    end
    self.hooks["ToggleGameMenu"].orig(clicked)
end

function Lexan:ToggleWorldMap()
    -- Prevents conflicts with MetaMap
    if METAMAP_VERSION then
        MetaMap_ToggleFrame(WorldMapFrame)

    -- Prevents conflicts with Atlas' world map replacer. If they're around, then let Atlas handle it
	elseif AtlasOptions and Atlas_ReplaceWorldMap() == true then
        Atlas_Toggle()
	
	-- End of anti-conflict stuff
	
	-- Instead of putting the frame through the UIPanels system, we just do shit the basic way :P
    -- I.e. instead of Show/HideUIPanel, we just do Frame:Show/Hide
	
	-- Hide
	elseif WorldMapFrame:IsVisible() then
        WorldMapFrame:Hide()
	
	-- Show
    else
        WorldMapFrame:EnableMouse(1) -- This prevents tooltips from stuff underneath the world map appearing when the world map is on
		SetupWorldMapScale(WorldMapFrame)
        WorldMapFrame:Show()
	end
end

function Lexan:AUCTION_HOUSE_SHOW()
    
    -- Checking for presence of AuctionFrame (Can't do shit without it :P)
    if AuctionFrame and AuctionFrame:IsShown() and not self.AHProtected then

		-- We're protecting, so...
		self.AHProtected = true

		-- If the frame is the current doublewide frame, then clear the doublewide
		if ( GetDoublewideFrame() == AuctionFrame ) then
			SetDoublewideFrame(nil)
		end

		-- Remove AuctionFrame from the window handling system
		-- Essentially the part we've been waiting for...
		UIPanelWindows["AuctionFrame"] = nil

		-- Protection done!!
    end
end
        
function Lexan:AUCTION_HOUSE_CLOSED()

    -- For a start, is protection even on?
    if ( self.AHProtected ) and ( AuctionFrame) then

        self.AHProtected = false

        -- Put the frame back into the UI window handling system
        UIPanelWindows["AuctionFrame"] = { area = "doublewide", pushable = 0 };
        if ( AuctionFrame:IsVisible() ) then
                SetDoublewideFrame(AuctionFrame)
        end
    end
end

function Lexan:AntiTrade_ON()
    if ( GetCVar("BlockTrades") == "0" ) and ( not self.TradesBlockedByUser ) then

        -- Just in case the luser logs out via chat command in a city with the
        -- windows open, which would cause trades to remain blocked. Not good :P
        self:RegisterEvent("PLAYER_LEAVING_WORLD", "AntiTrade_OFF") 
        
        SetCVar("BlockTrades", "1")
        self.TradesBlockedByMod = true
    end
end

function Lexan:AntiTrade_OFF()
    if ( self.TradesBlockedByMod ) then
        self:UnregisterEvent("PLAYER_LEAVING_WORLD") -- We don't need it anymore for now

        SetCVar("BlockTrades", "0")
        self.TradesBlockedByMod = false
    end
end