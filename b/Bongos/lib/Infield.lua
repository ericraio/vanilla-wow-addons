--[[
	Infield.lua
		A library of functions to keep frames within the UIParent's bounds
--]]

--constants
local VERSION = 60825;

if Infield and Infield.version >= VERSION then return; end

local UPDATE_INTERVAL = 1;

--[[ Local Functions ]]--

local function RegisterScaleEvents()
	--set the onupdate function
	InfieldUpdater:SetScript("OnEvent", function()
		local uiScale = UIParent:GetScale();
		if this.currentScale ~= uiScale then
			for _, action in pairs(Infield.rescaleList) do
				action();
			end	
			this.currentScale = uiScale;
		end
	end);
	InfieldUpdater:RegisterEvent("PLAYER_ENTERING_WORLD");
	InfieldUpdater:RegisterEvent("CVAR_UPDATE");
end

--returns the adjusted x and y coordinates for a frame when scaled, keeping the topleft of the frame in the same relative spot
local function GetAdjustedCoords(frame, nScale)
	if not ( frame:GetLeft() and frame:GetTop() ) then
		return;
	end
	return frame:GetLeft() * frame:GetScale() / nScale, frame:GetTop() * frame:GetScale() / nScale;
end

--[[ Update or Load Infield's Functions ]]--

--create a new infield instance
if not Infield then
	Infield = { rescaleList = {} };
--do stuff needed to be done on a version change
else
	local resList = Infield.rescaleList;
	Infield = { rescaleList = resList };

	if InfieldUpdater and InfieldUpdater:GetScript("OnUpdate") then
		InfieldUpdater:Hide();
		InfieldUpdater:SetScript("OnUpdate", nil);
		InfieldUpdater.elapsed = nil;
		RegisterScaleEvents();
	end
end
Infield.version = VERSION;

--Add a function to execute when the UI scale changes
--This must be added before the PLAYER_LOGIN event takes place to detect the startup rescale.
Infield.AddRescaleAction = function(funct)
	table.insert(Infield.rescaleList, funct);
end

--Sets <frame>'s scale <scale>, and repositions the frame if its out of the viewable screen area
Infield.Scale = function(frame, scale)
	local x, y = GetAdjustedCoords(frame, scale);
	
	frame:SetScale(scale);
	if x and y then
		Infield.Place(frame, "TOPLEFT", UIParent, "BOTTOMLEFT", x, y);
	end
end

--Places a frame at a location and repositions it so that it is not outside of the UIParent
--Syntax is similar to Frame:SetScale()
Infield.Place = function(frame, point, parent, relPoint, x, y)
	frame:ClearAllPoints();
	frame:SetPoint(point, parent, relPoint, x, y);
	Infield.Reposition(frame, UIParent);
end

--Moves a frame within the bounds of parent if its out of bounds
Infield.Reposition = function(frame, parent)
	if frame:GetBottom() and frame:GetTop() and frame:GetLeft() and frame:GetRight() then
		local xoff = 0;
		local yoff = 0;
		local ratio = frame:GetScale();
		
		--check and see if the frame is off the screen
		--Y bounds checking
		if frame:GetBottom() < 0 then
			yoff = 0 - frame:GetBottom();
		elseif frame:GetTop()  > (parent:GetTop() / ratio) then
			yoff = (parent:GetTop() / ratio) - frame:GetTop();
		end

		--X bounds checking
		if frame:GetLeft() < 0 then
			xoff = 0  - frame:GetLeft();
		elseif frame:GetRight()  > (parent:GetRight() / ratio) then
			xoff = (parent:GetRight() / ratio) - frame:GetRight();
		end
		
		--Reposition if anything was out of bounds
		if xoff ~= 0 or yoff ~= 0 then
			local x = frame:GetLeft() + xoff;
			local y = frame:GetTop() + yoff;
			
			frame:ClearAllPoints();
			frame:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", x , y);
		end
	end
end

--create the frame
if not InfieldUpdater then 
	CreateFrame("Frame", "InfieldUpdater");
	RegisterScaleEvents();
end