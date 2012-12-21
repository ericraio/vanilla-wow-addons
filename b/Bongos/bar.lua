--[[
	Bongos Bar 
		A customizable container frame object
	
	BongosBar.sets = {
		scale (a float ranging from 0 to <1, or nil)
			the bar's scale, relative to UIParent
		alpha (a float ranging from 0 to <1, or nil)
			the bar's opacity
		vis (flag)
			is the bar shown or not
		anchor (string or nil) 
			what bar we're attached to, and the point
		--any other bar settings
	}
--]]

local STICKY_TOLERANCE = 16; --how close one bar has to be to another in order to attempt auto anchoring

local barList = {}; --indexed by barID, any bongos bars currently in use
local deletedBars = {}; --indexed by name, any bongos bars we've deleted

--[[ Drag Button Functions ]]--

local function DragButton_OnMouseDown()
	this:GetParent():StartMoving();
	GameTooltip:Hide();
end

local function DragButton_OnMouseUp()
	this:GetParent():StopMovingOrSizing();
	BBar.TryToStick(BBar.IDToBar(this:GetText()));
end

local function DragButton_OnEnter()
	if this:GetScript("OnClick") then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT")
		if not tonumber(this:GetText()) then
			GameTooltip:SetText(this:GetText() .. " bar", 1, 1, 1);
		else
			GameTooltip:SetText("actionbar " .. this:GetText(), 1, 1, 1);
		end
		GameTooltip:AddLine("<Right Click> to Configure");
		GameTooltip:Show();
	end
end

local function DragButton_OnLeave()
	GameTooltip:Hide();
end

local function AddDragButton(parent, menuFunc)
	local button = CreateFrame("Button", parent:GetName() .. "DragButton", parent);
	
	button:SetPoint("TOPLEFT", parent, "TOPLEFT", -2, 2);
	button:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 2, -2);
	button:SetFrameLevel(parent:GetFrameLevel() + 3);
	button:SetClampedToScreen(true);
	
	button:SetTextFontObject(GameFontNormalLarge);
	button:SetHighlightTextColor(1, 1, 1);
	button:SetText(parent.id);

	local normalTexture = button:CreateTexture();
	normalTexture:SetTexture(0, 0, 0, 0.4);
	normalTexture:SetAllPoints(button);
	
	local highlightTexture = button:CreateTexture();
	highlightTexture:SetTexture(0.2, 0.4, 0.8, 0.2);
	highlightTexture:SetAllPoints(button);
	button:SetHighlightTexture(highlightTexture);
	
	button:SetScale(1/parent:GetScale());
	button:RegisterForClicks("LeftButtonDown", "LeftButtonUp", "RightButtonUp");
	button:SetScript("OnMouseDown", DragButton_OnMouseDown);
	button:SetScript("OnMouseUp", DragButton_OnMouseUp);
	button:SetScript("OnEnter", DragButton_OnEnter);
	button:SetScript("OnLeave", DragButton_OnLeave);
	
	if menuFunc then
		button:SetScript("OnClick", function()
			if arg1 == "RightButton" then
				menuFunc(button:GetParent())
			end
		end);
	end
	
	button:Hide();
end

--updates the drag button color of a given bar if its attached to another bar
local function UpdateDragButtonColor(bar)
	if bar.sets.anchor then
		getglobal(bar:GetName() .. "DragButton"):SetTextColor(0.5, 0.5, 1);
	else
		getglobal(bar:GetName() .. "DragButton"):SetTextColor(1, 0.82, 0);
	end
end

--[[ Bar Retrieval ]]--

local function GetDeletedBar(barName)
	deletedBars[barName] = nil;
	local bar = getglobal(barName);
	bar:SetParent(UIParent);
	return bar;
end

--[[ Usable BBar Functions ]]--

BBar = {
	--[[ Constructor]]--
	
	Create = function(barID, name, sets, menuFunc, alwaysShow, onDeleteFunc)
		assert(barID and name, "Usage: BBar.Create(barID, \"name\" [, \"settings\"] [, menuFunc] [,alwaysShow])");
		assert(not barList[barID], "BarID '" .. barID .. "' is already in use.");
		
		local bar;
		if getglobal(name) then
			--we're reusing a previously created bongos bar
			if deletedBars[name] then
				bar = GetDeletedBar(name);
				bar.id = barID;
				if menuFunc then
					getglobal(bar:GetName() .. "DragButton"):SetScript("OnClick", function()
						if arg1 == "RightButton" then
							menuFunc(this:GetParent())
						end
					end);
				end
			else
				error("Attempted to create preexisting frame '" .. name .. "'.");
			end
		--we're creating a new bar
		else
			bar = CreateFrame("Frame", name, UIParent);
			bar.id = barID;
			AddDragButton(bar, menuFunc);
		end
		
		bar:SetClampedToScreen(true);
		bar:SetMovable(true);
		if alwaysShow then
			bar.alwaysShow = 1;
		end
		bar.OnDelete = onDeleteFunc;
		
		local settings;
		if sets then
			settings = getfield(sets);
			bar.setsGlobal = sets;
		end
		if not settings then
			local defaults = BProfile.GetDefaultValue(sets);
			if defaults then
				bar.sets = defaults;
			elseif not bar.alwaysShow then
				bar.sets = {vis = 1};
			else
				bar.sets = {};
			end
			
			if sets then
				setfield(sets, bar.sets);
			end
		else
			bar.sets = settings;
		end		
		BBar.LoadSettings(bar);	
		barList[barID] = bar;
		
		return bar;
	end,

	--[[ Destructor ]]--
	
	Delete = function(barID)
		assert(barID, "Usage: BBar.Create(barID)");
		
		local bar = barList[barID];
		if bar then
			if bar.OnDelete then
				bar:OnDelete()
			end
			--delete all bar saved settings, remove it from the list of used IDs
			barList[barID] = nil;
			setfield(bar.setsGlobal, nil)
			bar.sets = nil;
			bar.setsGlobal = nil;
			bar.id = nil;
			bar.alwaysShow = nil;
			bar:UnregisterAllEvents();
			
			--hide the bar, then reanchor all bars
			bar:SetParent(nil);
			bar:ClearAllPoints();
			bar:SetUserPlaced(false);
			bar:Hide();
			BBar.ForAll(BBar.Reanchor);
			
			--add the bar to the deleted bars list
			deletedBars[bar:GetName()] = true;
		end
	end,

	--[[ Visibility ]]--
	
	Show = function(bar, save)
		if not bar.alwaysShow then
			bar:Show();
			if save then
				bar.sets.vis = 1;
			end
		end
	end,

	Hide = function(bar, save)
		if not bar.alwaysShow then
			bar:Hide();
			if save then
				bar.sets.vis = nil;
			end
		end
	end,

	Toggle = function(bar, save)
		if bar:IsShown() then
			BBar.Hide(bar, save);
		else
			BBar.Show(bar, save);
		end
	end,

	--[[ Movement ]]--
	
	Lock = function(bar)
		getglobal(bar:GetName() .. "DragButton"):Hide();
	end,

	Unlock = function(bar)
		getglobal(bar:GetName() .. "DragButton"):Show();
	end,

	--[[ Configuration ]]--
	
	--set bar scale
	SetScale = function(bar, scale, save)
		Infield.Scale(bar, scale or 1);
		getglobal(bar:GetName() .. "DragButton"):SetScale(1/bar:GetScale());
		BBar.Reanchor(bar);
		if save then
			if scale == 1 then
				bar.sets.scale = nil;
			else
				bar.sets.scale = scale;
			end
		end
	end,

	--set bar opacity
	SetAlpha = function(bar, alpha, save)
		bar:SetAlpha(alpha or 1);
		getglobal(bar:GetName() .. "DragButton"):SetAlpha(1);
		if save then
			if alpha == 1 then
				bar.sets.alpha = nil
			else
				bar.sets.alpha = alpha;
			end
		end
	end,

	--try to anchor the bar to any bar its near
	TryToStick = function(bar)
		if BongosSets.sticky then
			bar.sets.anchor = nil;
			for _, otherBar in pairs(barList) do
				if otherBar:IsShown() then
					local point = FlyPaper.Stick(bar, otherBar, STICKY_TOLERANCE, 2, 2);
					if point then
						bar.sets.anchor = otherBar.id .. point;
						break;
					end
				end
			end
		end
		UpdateDragButtonColor(bar);
	end,

	--[[ Load Settings  ]]--
	
	--load all default bar settings
	LoadSettings = function(bar)
		--set visibility
		if not(bar.sets.vis or bar.alwaysShow) then
			bar:Hide();
		else
			bar:Show();
		end
		--set opacity
		if bar.sets.alpha then
			BBar.SetAlpha(bar, bar.sets.alpha);
		end
		--set position
		if bar.sets.x and bar.sets.y then
			--this handles rescaling, so we don't rescale if we're loading the bar's position
			BBar.Reposition(bar);
		--set scale
		elseif bar.sets.scale then
			BBar.Rescale(bar, bar.sets.scale);
		end
		if not BongosSets.locked then
			BBar.Unlock(bar);
		end
	end,

	--rescale the bar, but without auto repositioning
	Rescale = function(bar)
		bar:SetScale(bar.sets.scale or 1);
		getglobal(bar:GetName() .. "DragButton"):SetScale(1/bar:GetScale());
	end,

	--place the bar at it's save'd position.  This is ment to be used in combination with BProfile
	Reposition = function(bar)
		BBar.Rescale(bar);
		
		bar:ClearAllPoints();
		bar:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", bar.sets.x, bar.sets.y);
		bar:SetUserPlaced(true);
		bar.sets.x = nil;
		bar.sets.y = nil;
	end,

	--try to reanchor the bar
	Reanchor = function(bar)
		local otherBar, point = BBar.GetAnchor(bar);
		if BongosSets.sticky and otherBar then
			if not FlyPaper.StickToPoint(bar, otherBar, point, 2, 2) then
				bar.sets.anchor = nil;
			end
		else
			bar.sets.anchor = nil;
		end
		UpdateDragButtonColor(bar);
	end,

	--[[ Conversions ]]--
	
	GetID = function(bar)
		return bar.id;
	end,

	GetAnchor = function(bar)
		local anchorString = bar.sets.anchor;
		if anchorString then
			local pointStart = strlen(anchorString) - 1;
			return BBar.IDToBar(strsub(anchorString, 1, pointStart - 1)), strsub(anchorString, pointStart);
		end
	end,

	--takes a barID, and returns
	IDToBar = function(barID)
		if tonumber(barID) then
			return barList[tonumber(barID)];
		end
		return barList[barID];
	end,

	--[[ Higher Order Functions ]]--
	
	--performs action(bar, arg1, arg2, ...) to every bongos bar
	ForAll = function(action, ...)
		for _,bar in pairs(barList) do
			action(bar, unpack(arg));
		end
	end,

	--performs action(barID, arg1, arg2, ...) to every bongos bar ID
	ForAllIDs = function(action, ...)
		for id in barList do
			action(id, unpack(arg));
		end
	end,

	GetAll = function()
		local list = {};
		for _, bar in pairs(barList) do
			table.insert(list, bar)
		end
		return list;
	end,
}

Infield.AddRescaleAction(function()
	BBar.ForAll(BBar.Rescale);
	BBar.ForAll(BBar.Reanchor);
end)