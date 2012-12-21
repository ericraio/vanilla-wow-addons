simpleMinimap_Autozoom = simpleMinimap:NewModule("autozoom")
local L = AceLibrary("AceLocale-2.1"):GetInstance("simpleMinimap_Autozoom", true)
--
function simpleMinimap_Autozoom:OnInitialize()
	self.db = simpleMinimap:AcquireDBNamespace("autozoom")
	self.defaults = { enabled=true, time=20 }
	self.options = {
		type = "group", name=L.autozoom, desc=L.autozoom_desc,
		args = {
			title = {
				type="header", order=1, name="simpleMinimap |cFFFFFFCC"..L.autozoom
			},
			spacer1 = {
				type = "header", order=2
			},
			enabled = {
				type="toggle", order=3, name=L.enabled, desc=L.enabled_desc,
				get=function() return(self.db.profile.enabled) end,
				set=function(x) self.db.profile.enabled=x simpleMinimap:ToggleModuleActive(self,x) end
			},
			spacer2 = {
				type="header", order=4, name="---"
			},
			time = {
				type="range", order=10, name=L.time, desc=L.time_desc,
				min= 2, max=120, step=2,
				get=function() return(self.db.profile.time) end,
				set=function(x) self.db.profile.time=x end
			}
		}
	}
	simpleMinimap.options.args.modules.args.autozoom = self.options
	simpleMinimap:RegisterDefaults("autozoom", "profile", self.defaults)
end
--
function simpleMinimap_Autozoom:OnEnable()
	if(self.db.profile.enabled) then
		self:Hook("Minimap_ZoomIn")
		self:Hook("Minimap_ZoomOut")
		self:EventAutozoom()
	else
		simpleMinimap:ToggleModuleActive(self, false)
	end
end
--
function simpleMinimap_Autozoom:OnDisable()
	self:CancelAllScheduledEvents()
end
--
function simpleMinimap_Autozoom:EventAutozoom()
	Minimap:SetZoom(0)
	MinimapZoomOut:Disable()
	MinimapZoomIn:Enable()
end
--
function simpleMinimap_Autozoom:Minimap_ZoomIn()
	self:ScheduleEvent("smmAutozoom", self.EventAutozoom, self.db.profile.time, self)
	return self.hooks.Minimap_ZoomIn()
end
--
function simpleMinimap_Autozoom:Minimap_ZoomOut()
	self:ScheduleEvent("smmAutozoom", self.EventAutozoom, self.db.profile.time, self)
	return self.hooks.Minimap_ZoomOut()
end