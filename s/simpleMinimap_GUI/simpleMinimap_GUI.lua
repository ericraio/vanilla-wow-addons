simpleMinimap_GUI = simpleMinimap:NewModule("gui")
local L = AceLibrary("AceLocale-2.1"):GetInstance("simpleMinimap_GUI", true)
local dewdrop = AceLibrary("Dewdrop-2.0")
--
function simpleMinimap_GUI:OnInitialize()
	self.db = simpleMinimap:AcquireDBNamespace("gui")
	self.buttons = { "LeftButton", "MiddleButton", "RightButton", "Button4", "Button5" }
	self.defaults = { enabled = true, button = 3 }
	self.options = {
		type="group", name=L.gui, desc=L.gui_desc,
		args={
			title={
				type="header", order=1, name="simpleMinimap |cFFFFFFCC"..L.gui
			},
			spacer1={
				type="header", order=2
			},
			enabled={
				type="toggle", order=3, name=L.enabled, desc=L.enabled_desc,
				get=function() return(self.db.profile.enabled) end,
				set=function(x) self.db.profile.enabled=x simpleMinimap:ToggleModuleActive(self,x) end
			},
			spacer2={
				type="header", order=4, name = "---"
			},
			mouse={
				type="group", order=10, name=L.mouse, desc=L.mouse_desc,
				args = {
					["1"]={
						type= "toggle", order=1, name=self.buttons[1], desc=self.buttons[1],
						get=function() return(self.db.profile.button==1) end,
						set=function() self.db.profile.button=1 end
					},
					["2"]={
						type= "toggle", order=2, name=self.buttons[2], desc=self.buttons[2],
						get=function() return(self.db.profile.button==2) end,
						set=function() self.db.profile.button=2 end
					},
					["3"]={
						type= "toggle", order=3, name=self.buttons[3], desc=self.buttons[3],
						get=function() return(self.db.profile.button==3) end,
						set=function() self.db.profile.button=3 end
					},
					["4"]={
						type="toggle", order=4, name=self.buttons[4], desc=self.buttons[4],
						get=function() return(self.db.profile.button==4) end,
						set=function() self.db.profile.button=4 end
					},
					["5"]={
						type="toggle", order=5, name=self.buttons[5], desc=self.buttons[5],
						get=function() return(self.db.profile.button==5) end,
						set=function() self.db.profile.button=5 end
					}
				}
			}
		}
	}
	simpleMinimap.options.args.modules.args.gui = self.options
	simpleMinimap:RegisterDefaults("gui", "profile", self.defaults)
end
--
function simpleMinimap_GUI:OnEnable()
	if(self.db.profile.enabled) then
		Minimap:SetScript("OnMouseUp", function()
			if(arg1 == self.buttons[self.db.profile.button]) then
				dewdrop:Open(MinimapCluster)
			else
				return(Minimap_OnClick())
			end
		end)
		dewdrop:Register(MinimapCluster,
			'children', function()
				dewdrop:FeedAceOptionsTable(simpleMinimap.options)
			end,
			'point', function(parent)
				if parent:GetTop() < GetScreenHeight() / 2 then
					return 'BOTTOM', 'TOP'
				else
					return 'TOP', 'BOTTOM'
				end
			end,
			'cursorX', true
		)
	else
		simpleMinimap:ToggleModuleActive(self, false)
	end
end
--
function simpleMinimap_GUI:OnDisable()
	Minimap:SetScript("OnMouseUp", function() Minimap_OnClick() end)
	dewdrop:Close()
	dewdrop:Unregister(MinimapCluster)
end