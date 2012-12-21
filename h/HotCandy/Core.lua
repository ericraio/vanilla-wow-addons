HotCandy = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDebug-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "CandyBar-2.0")

local compost = AceLibrary:HasInstance("Compost-2.0") and AceLibrary("Compost-2.0")
--local paint = AceLibrary("PaintChips-2.0")
local BS = AceLibrary("Babble-Spell-2.2")
local gratuity = AceLibrary("Gratuity-2.0")
--local seea = AceLibrary("SpecialEvents-Aura-2.0")

local function getnewtable() return compost and compost:Acquire() or {} end
local function reclaimtable(t) if compost then compost:Reclaim(t) end end

HotCandy.version = "0.1." .. string.sub("$Revision: 12273 $", 12, -3)
HotCandy.date = string.sub("$Date: 2006-09-30 04:50:40 +0200 (Sa, 30 Sep 2006) $", 8, 17)

function HotCandy:OnInitialize()
	self:RegisterDB("HotCandyDB")
	self:RegisterDefaults("profile", {
		growup = false,
		bonus = {druidt2 = false, priestt2 = false},
	})
	
	self.options = {
		type = "group",
		args = {
			anchor = {
				name = "Show Anchor",
				desc = "Show the Anchor for moving the Bars",
				type = "execute",
				func = "ShowAnchors",
			},
			growup = {
				name = "Grow Up",
				desc = "Toggle Grow Up of the Bars",
				type = "toggle",
				get = function()
					return self.db.profile.growup
				end,
				set = function(v)
					self.db.profile.growup = v
				end,
			},
			bonus = {
				type = "group",
				name = "Bonus",
				desc = "Configure Set Bonus attributes",
				args = {
					druid = {
						name = "Druid T2 Rejuvenation Bonus",
						desc = "Toggle the Druid T2 Bonus on/off",
						type = "toggle",
						get = function()
							return self.db.profile.bonus.druidt2
						end,
						set = function(v)
							self.db.profile.bonus.druidt2 = v
							if self.db.profile.bonus.druidt2 then
								self.track['Rejuvenation'] = 15
							else
								self.track['Rejuvenation'] = 12
							end
						end,
					},
					priest = {
						name = "Priest T2 Greater Heal Bonus",
						desc = "Toggle the Priest T2 Bonus on/off",
						type = "toggle",
						get = function()
							return self.db.profile.bonus.priestt2
						end,
						set = function(v)
							self.db.profile.bonus.priestt2 = v
							if self.db.profile.bonus.priestt2 then
								self.track['Greater Heal'] = 15
							else
								self.track['Greater Heal'] = nil
							end
						end,
					},
				}
			},
		}
	}
	
	self:RegisterChatCommand({ "/hot", "/hotcandy" }, self.options )
	
	self.spell = {}
	self:SetupFrames()
	
	-- spell = duration
	self.track = {
		[BS['Rejuvenation']] = self.db.profile.bonus.druidt2 and 15 or 12,
		[BS['Regrowth']] = 21,
		[BS['Renew']] = 15,
		[BS['Greater Heal']] = self.db.profile.bonus.priestt2 and 15 or nil,
	}
	self:DoHooking()
end

function HotCandy:OnEnable()
	--self:SetDebugging(true)
	--self:SetDebugLevel(3)
	self:RegisterEvent("SPELLCAST_FAILED", "SpellCastEvent")
	self:RegisterEvent("SPELLCAST_STOP", "SpellCastEvent")
	self:RegisterEvent("SPELLCAST_INTERRUPTED", "SpellCastEvent")
end

function HotCandy:SpellCastEvent()
	if ( event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" ) and self.spell.EndCast then
		self.spell.Casting = nil
		self.spell.Target = nil
		self.spell.EndCast = nil
	elseif event == "SPELLCAST_STOP" and self.spell.EndCast then
		self:LevelDebug(2, "SPELLCAST_STOP", self.spell.EndCast, self.spell.Target)
		self:FireSpell(self.spell.EndCast, self.spell.Target)
		self.spell.Casting = nil
		self.spell.Target = nil
		self.spell.EndCast = nil
	end
end

function HotCandy:FireSpell(spellName, spellTarget)
	if self.track[spellName] then
		self:LevelDebug(3, "FireSpell", spellName, spellTarget)
		self:ShowCandyBar(spellName.." - "..(spellTarget or ""), self.track[spellName], BS:GetSpellIcon(spellName), "green", "yellow", "orange", "red")
	end
end

function HotCandy:ShowCandyBar(text, time, icon, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	local id = "HotCandy"..text
	local u = self.db.profile.growup
	self:RegisterCandyBarGroup("HotCandyGroup")
	self:SetCandyBarGroupPoint("HotCandyGroup", u and "BOTTOM" or "TOP", self.frames.anchor, u and "TOP" or "BOTTOM", 0, 0)
	self:SetCandyBarGroupGrowth("HotCandyGroup", u)
	
	self:RegisterCandyBar(id, time, text, icon, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10)
	self:RegisterCandyBarWithGroup(id, "HotCandyGroup")
	self:SetCandyBarTexture(id, "Interface\\Addons\\HotCandy\\textures\\default")
	self:SetCandyBarFade(id, 5)
	self:StartCandyBar(id, true)
end
