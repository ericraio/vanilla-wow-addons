local locals = KC_ITEMS_LOCALS.modules.optimizer

KC_Optimizer = KC_ItemsModule:new({
	type		 = "optimizer",
	name		 = locals.name,
	desc		 = locals.description,
	cmdOptions	 = locals.chat,
	dependencies = {"common"},
	dataPath	 = {"optimizer"},
	optPath		 = {"optimizer", "options"},
})

KC_Items:Register(KC_Optimizer)

function KC_Optimizer:Enable()
	local version = KC_ItemsVersion or self:GetOpt(self.dataPath, "version") or 0
	if (version == ".94.2") then
		self:Msg(format(locals.msg.upgrade, version))
		self:Msg(locals.msg.complete)
	elseif (version == ".94.1") then
		self:Msg(format(locals.msg.upgrade, version))
		self:UpgradeDB()
		self:Msg(locals.msg.complete)
	elseif (version ~= self.app.version) then
		self:Msg(format(locals.msg.upgrade, locals.msg.unknown))
		self:UpgradeDB()
		self:Msg(locals.msg.complete)
	end
	self:ClearOpt(self.dataPath, "version")
	KC_ItemsVersion = self.app.version

	if (not StopTheLagness) then
		self:Hook("ContainerFrameItemButton_OnEnter", "CFIB_OnEnter")
		ContainerFrameItemButton_OnUpdate = KC_Optimizer.CFIB_OnUpdate
		self:HookScript(GameTooltip, "OnHide", "GameTooltipOnHide")		
	end
end

function KC_Optimizer:UpgradeDB()
	self.app.db:set("stats", "0,0,0,0,0,0")
	self.app.db:set("v")
	for i,v in KC_ItemsDB do
		if (strfind(i, ":")) then
			self.common:AddCode(i, self.common:Split(v, ":"))
			KC_ItemsDB[i] = nil;
		elseif (type(i) == "string") then
			KC_ItemsDB[i] = nil;
		end
	end
	self.common:RebuildStats()
end

function KC_Optimizer:ImportMasterDB()
	self.app.db:set("stats", "0,0,0,0,0,0")
	self.app.db:set("v")

	local KC_MasterDB = self:GetMasterDB()

	for i,v in KC_MasterDB do
		if (strfind(i, ":")) then
			self.common:AddCode(i, self.common:Split(v, ":"))
		else
			local list, sell, buy = self.common:Explode(v, ",")
			local codes = self.common:GetCodes(i, list)
			for i2,v2 in codes do
				self.common:AddCode(v2, sell, buy)
			end
		end
		KC_MasterDB[i] = nil
	end
	self.common:RebuildStats()
end

--killing the lag one step at a time.  Borrowed from StopTheLagness
function KC_Optimizer:CFIB_OnEnter(button)
	button = button or this
	self.currentBtn = button
	self.currentBtn._hasCooldown = GameTooltip:SetBagItem(button:GetParent():GetID(),button:GetID())
	self:CallHook("ContainerFrameItemButton_OnEnter", button)
end

function KC_Optimizer:GameTooltipOnHide()
	self.elapsed = 0
	self:CallScript(GameTooltip, "OnHide");
end

function KC_Optimizer.CFIB_OnUpdate()
	if( (this ~= KC_Optimizer.currentBtn) or (not KC_Optimizer.currentBtn) or (not KC_Optimizer.currentBtn._hasCooldown) ) then return end
	KC_Optimizer.elapsed = KC_Optimizer.elapsed + arg1
	if( KC_Optimizer.elapsed >= 1 ) then
		KC_Optimizer.elapsed	= 0
		KC_Optimizer:CFIB_OnEnter(KC_Optimizer.currentBtn)
	end
end