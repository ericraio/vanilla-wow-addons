simpleMinimap_Pings = simpleMinimap:NewModule("pings")
local L = AceLibrary("AceLocale-2.1"):GetInstance("simpleMinimap_Pings", true)
--
function simpleMinimap_Pings:OnInitialize()
	self.db = simpleMinimap:AcquireDBNamespace("pings")
	self.positions = {
		{ "BOTTOM", "BOTTOM" },
		{ "TOP", "BOTTOM" },
		{ "TOP", "TOP" },
		{ "BOTTOM", "TOP" }
	}
	self.defaults = { enabled=true, position=3, alpha=0.9, scale=0.85 }
	self.options = {
		type="group", name=L.pings, desc=L.pings_desc,
		args={
			title = {
				type="header", order=1, name="simpleMinimap |cFFFFFFCC"..L.pings
			},
			spacer1={
				type="header", order=2
			},
			enabled={
				type="toggle", order=3, name= L.enabled, desc=L.enabled_desc,
				get=function() return(self.db.profile.enabled) end,
				set=function(x) self.db.profile.enabled=x simpleMinimap:ToggleModuleActive(self, x) end
			},
			spacer2={
				type="header", order=4, name="---"
			},
			alpha={
				type="range", order=10, name=L.alpha, desc=L.alpha_desc,
				min=0, max=1, step=0.05, isPercent=true,
				get=function() return(self.db.profile.alpha) end,
				set=function(x) self.db.profile.alpha=x smmPingFrame:SetAlpha(x) end
			},
			position = {
				type="group", order=11, name=L.position, desc=L.position_desc,
				args = {
					["1"]={
						type= "toggle", order=1, name=L.position1, desc=L.position1_desc,
						get=function() return(self.db.profile.position==1) end,
						set=function() self.db.profile.position=1 self:UpdateScreen() end
					},
					["2"]={
						type="toggle", order=2, name=L.position2, desc=L.position2_desc,
						get=function() return(self.db.profile.position==2) end,
						set=function() self.db.profile.position=2 self:UpdateScreen() end
					},
					["3"]={
						type= "toggle", order=3, name=L.position3, desc=L.position3_desc,
						get=function() return(self.db.profile.position==3) end,
						set=function() self.db.profile.position=3 self:UpdateScreen() end
					},
					["4"]={
						type="toggle", order=4, name=L.position4, desc=L.position4_desc,
						get=function() return(self.db.profile.position==4) end,
						set=function() self.db.profile.position=4 self:UpdateScreen() end
					}
				}
			},
			scale={
				type= "range", order=12, name=L.scale, desc=L.scale_desc,
				min=0.5, max=2, step=0.05,
				get=function() return(self.db.profile.scale) end,
				set=function(x) self.db.profile.scale=x smmPingFrame:SetScale(x) end
			}
		}
	}
	simpleMinimap.options.args.modules.args.pings = self.options
	simpleMinimap:RegisterDefaults("pings", "profile", self.defaults)
	smmPingFrame:SetScale(self.db.profile.scale)
	smmPingFrame:SetAlpha(self.db.profile.alpha)
	self:UpdateScreen()
end
--
function simpleMinimap_Pings:OnEnable()
	if(self.db.profile.enabled) then
		self:RegisterEvent("MINIMAP_PING")
	else
		simpleMinimap:ToggleModuleActive(self, false)
	end
end
--
function simpleMinimap_Pings:OnDisable()
end
--
function simpleMinimap_Pings:UpdateScreen()
	smmPingFrame:ClearAllPoints()
	smmPingFrame:SetPoint(self.positions[self.db.profile.position][1], "Minimap", self.positions[self.db.profile.position][2])
end
--
function simpleMinimap_Pings:MINIMAP_PING()
	if(not UnitIsUnit(arg1, "player")) then
		smmPingFrameText:SetText(L.ping_by.." |cFFFFFFCC"..UnitName(arg1))
		smmPingFrame:SetWidth(smmPingFrameText:GetWidth() + 16)
		smmPingFrame:SetHeight(smmPingFrameText:GetHeight() + 12)
		smmPingFrame:Show()
	else
		smmPingFrame:Hide()
	end
end
