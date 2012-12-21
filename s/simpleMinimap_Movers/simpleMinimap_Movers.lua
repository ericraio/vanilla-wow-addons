simpleMinimap_Movers = simpleMinimap:NewModule("movers")
local L = AceLibrary("AceLocale-2.1"):GetInstance("simpleMinimap_Movers", true)
--
function simpleMinimap_Movers:OnInitialize()
	self.db = simpleMinimap:AcquireDBNamespace("movers")
	self.movers = {
		QuestWatchFrame = "smmQuestMover",
		DurabilityFrame = "smmDollMover",
		QuestTimerFrame = "smmTimerMover",
		smmCaptureMover = "smmCaptureMover"
	}
	self.framesDefault = {
		QuestWatchFrame = { anchor=MinimapCluster, point="TOPRIGHT", rpoint="BOTTOMRIGHT", x=0, y=10 },
		DurabilityFrame = { anchor=MinimapCluster, point="TOPRIGHT", rpoint="BOTTOMRIGHT", x=40, y=15 },
		QuestTimerFrame = { anchor=MinimapCluster, point="TOPRIGHT", rpoint="BOTTOMRIGHT", x=10, y=0 },
		smmCaptureMover = { anchor=MinimapCluster, point="TOPRIGHT", rpoint="BOTTOMRIGHT", x=10, y=15 }
	}
	self.defaults = { enabled=true, framePos={} }
	self.options = {
		type="group", name=L.movers, desc=L.movers_desc,
		args={
			title={
				type="header", order=1, name="simpleMinimap |cFFFFFFCC"..L.movers
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
				type="header", order=4, name="---"
			},
			hide={
				type="toggle", order=10, name=L.hide, desc=L.hide_desc,
				get=function() return(self.db.profile.hide) end,
				set=function(x) self.db.profile.hide=x self:UpdateScreen() end
			}
		}
	}
	simpleMinimap.options.args.modules.args.movers = self.options
	simpleMinimap:RegisterDefaults("movers", "profile", self.defaults)
	for n, f in pairs(self.movers) do
		local movee, mover = getglobal(n), getglobal(f)
		mover:SetScript("OnDragStart", function() self:FrameDrag(true) end)
		mover:SetScript("OnDragStop", function() self:FrameDrag(false) end)
		mover:RegisterForDrag("LeftButton")
		mover.smmMover = n
		mover:SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_CURSOR") GameTooltip:SetText(L.drag.." |cFFFFFF99"..this.smmMover)	end)
		mover:SetScript("OnLeave", function() GameTooltip:Hide() end)
		mover:SetAlpha(0.4)
		movee:SetMovable(true)
	end
end
--
function simpleMinimap_Movers:OnEnable()
	if(self.db.profile.enabled) then
		self:RegisterEvent("UPDATE_WORLD_STATES")
		self:UpdateScreen()
	else
		simpleMinimap:ToggleModuleActive(self, false)
	end
end
--
function simpleMinimap_Movers:OnDisable()
	self:UpdateScreen()
end
--
function simpleMinimap_Movers:FrameDrag(kick)
	local f = getglobal(this.smmMover)
	if(kick and not simpleMinimap.db.profile.lock) then
		f.isMoving = true
		f:StartMoving()
		GameTooltip:Hide()
	elseif(f.isMoving) then
		f.isMoving = false
		f:StopMovingOrSizing()
		self.db.profile.framePos[this.smmMover] = {}
		self.db.profile.framePos[this.smmMover].x, self.db.profile.framePos[this.smmMover].y = f:GetCenter()
	end
end
--
function simpleMinimap_Movers:UpdateScreen()
	for n, f in pairs(self.movers) do
		local movee, mover = getglobal(n), getglobal(f)
		if(simpleMinimap:IsModuleActive(self) and self.db.profile.framePos[n]) then
			simpleMinimap:LockFrame(movee)
			movee:smm_ClearAllPoints()
			movee:smm_SetPoint("CENTER", UIParent, "BOTTOMLEFT", self.db.profile.framePos[n].x, self.db.profile.framePos[n].y)
		elseif(movee.smmTouched) then
			simpleMinimap:UnlockFrame(movee)
			movee:ClearAllPoints()
			movee:SetPoint(self.framesDefault[n].point, self.framesDefault[n].anchor, self.framesDefault[n].rpoint, self.framesDefault[n].x, self.framesDefault[n].y)
			movee:SetUserPlaced(false)
		end
		if(simpleMinimap:IsModuleActive(self) and not self.db.profile.hide and not simpleMinimap.db.profile.lock) then
			mover:Show()
		else
			mover:Hide()
		end
	end
end
--
function simpleMinimap_Movers:UPDATE_WORLD_STATES()
	for i = 1, NUM_EXTENDED_UI_FRAMES do
		local frame = getglobal("WorldStateCaptureBar"..i)
		if(frame) then
			if(simpleMinimap:IsModuleActive(self)) then
				if(not frame.smmTouched) then
					simpleMinimap:LockFrame(frame)
					frame:smm_ClearAllPoints()
					frame:smm_SetPoint("Center", smmCaptureMover)
				end
			elseif(frame.smmTouched) then
				simpleMinimap:UnlockFrame(frame)
			end
		end
	end
end