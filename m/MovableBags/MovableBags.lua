--[[  MovableBags.lua
			Author: Pos
			Version 1.1a

			24/12/2004 - Initial Release
			24/12/2004 - Updated to include bank bags
			25/12/2004 - bug fixes and streamlined code
			01/01/2005 - fix for dead areas on screen
			02/01/2005 - Better Default Positions
			13/01/2005 - Fixed up by CTMod developers
]]

MOVABLEBAGS_NUMBAGS = 11;
MOVABLEBAGS_LOWID = 0;
MOVABLEBAGS_HIGHID = 10;
MovableBags_Config = { };

-- 0-4 are the normal bags, 5-10 are bank bags
MovableBags_DefaultPositions = {
	[-2] = { "BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -250, 650 },
	[0] = { "BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -50, 300 },
	[1] = { "BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -250, 300 },
	[2] = { "BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -450, 300 },
	[3] = { "BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -50, 500 },
	[4] = { "BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -250, 500 },
	[5] = { "TOPLEFT", "UIParent", "TOPLEFT", 50, -650 },
	[6] = { "TOPLEFT", "UIParent", "TOPLEFT", 250, -650 },
	[7] = { "TOPLEFT", "UIParent", "TOPLEFT", 450, -650 },
	[8] = { "TOPLEFT", "UIParent", "TOPLEFT", 650, -650 },
	[9] = { "TOPLEFT", "UIParent", "TOPLEFT", 400, -50 },
	[10] = { "TOPLEFT", "UIParent", "TOPLEFT", 400, -300 },
};
	
function MovableBags_updateContainerFrameAnchors()
	movablebags_oldupdateContainerFrameAnchors();
	
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local containerFrame = getglobal("ContainerFrame"..i);
		local id = containerFrame:GetID();
		if ( MovableBags_DefaultPositions[id] ) then
			containerFrame:ClearAllPoints();
			containerFrame:SetPoint("TOPRIGHT","Bag"..id.."Mover","TOPRIGHT",34,0);
		end
	end
end

--called to update the visibility of the movers, depending on locked status and visibility of the bags
function MovableBags_UpdateVisible()
	local i = 0;
	MovableBags_HideAll();
	
	if(MovableBags_Config.Mode == "Locked") then
		--no checking if bags are visible to show movers
		return;
	end 
	
	for i=1, NUM_CONTAINER_FRAMES, 1 do
		local containerFrame = getglobal("ContainerFrame"..i);
		local id = containerFrame:GetID();
		if ( MovableBags_DefaultPositions[id] ) then
			local mover = getglobal("Bag"..id.."Mover");
			if (containerFrame:IsVisible() ) then
				mover:Show();
			end
		end
	end
end

function MovableBags_HideAll()
	for k, v in MovableBags_DefaultPositions do
		local mover = getglobal("Bag"..k.."Mover");
		mover:Hide();
	end
end

--hooks into the containerframes on show/hide, to show/hide the movers
function MovableBags_ContainerFrame_OnHide()
	movablebags_oldContainerFrame_OnHide();
	if ( this:GetID() < MOVABLEBAGS_NUMBAGS ) then
		local mover = getglobal("Bag"..this:GetID().."Mover");
		if ( not mover and this:GetID() == KEYRING_CONTAINER ) then
			MovableBags_UpdateVisible();
			return;
		end
		mover:Hide();
	end
end

function MovableBags_ContainerFrame_OnShow()
	movablebags_oldContainerFrame_OnShow();
	if ( this:GetID() < MOVABLEBAGS_NUMBAGS and MovableBags_Config.Mode == "Movable") then
		local mover = getglobal("Bag"..this:GetID().."Mover");
		if ( not mover and this:GetID() == KEYRING_CONTAINER ) then
			local shownContainerID = IsBagOpen(KEYRING_CONTAINER);
			mover = getglobal("Bag"..shownContainerID.."Mover");
		end
		mover:Show();
	end
end

function MovableBags_OnLoad() 
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	
	

end

function MovableBags_OnEvent()
		if (event == "VARIABLES_LOADED") then
			
			SlashCmdList["MOVABLEBAGS"] = MovableBags_SlashHandler;
			SLASH_MOVABLEBAGS1 = "/movablebags";
			SLASH_MOVABLEBAGS2 = "/bags";
			
			MovableBags_UpdateVisible();
			--function hooks
			--hooking in VARIABLES_LOADED so if something else hooks the functions, hopefully they do it before me, so they dont interfere
			movablebags_oldupdateContainerFrameAnchors = updateContainerFrameAnchors;
			updateContainerFrameAnchors = MovableBags_updateContainerFrameAnchors;
			
			movablebags_oldContainerFrame_OnShow = ContainerFrame_OnShow;
			ContainerFrame_OnShow = MovableBags_ContainerFrame_OnShow;
			
			movablebags_oldContainerFrame_OnHide = ContainerFrame_OnHide;
			ContainerFrame_OnHide = MovableBags_ContainerFrame_OnHide;
			return;
	end
end


function MovableBags_SlashHandler(arg)
	arg = string.lower(arg);
	
	if (arg == "lock") then
		MovableBags_Config.Mode = "Locked";
		MovableBags_UpdateVisible();
		DEFAULT_CHAT_FRAME:AddMessage("Bags are now LOCKED");
	elseif (arg == "unlock") then
		MovableBags_Config.Mode = "Movable";
		MovableBags_UpdateVisible();
		DEFAULT_CHAT_FRAME:AddMessage("Bags are now UNLOCKED");
	elseif (arg == "reset") then
		for i=0,10,1 do
			local mover = getglobal("Bag"..i.."Mover");
			local pos = MovableBags_DefaultPositions[i];
			mover:ClearAllPoints();
			mover:SetPoint(pos[1],pos[2],pos[3],pos[4],pos[5]);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Usage: /movablebags unlock | lock | reset");
		DEFAULT_CHAT_FRAME:AddMessage("unlock lets you move the bags around independantly of each other (default)");
		DEFAULT_CHAT_FRAME:AddMessage("lock locks the bags into the position you last moved them to");
		DEFAULT_CHAT_FRAME:AddMessage("Reset will return all bags to the default positions");
		DEFAULT_CHAT_FRAME:AddMessage("Bags are currently "..MovableBags_Config.Mode);
	end

end

function MovableBags_Function(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_Print("<CTMod> Bags are now movable.", 1.0, 1.0, 0);
		for i=0,10,1 do
			getglobal("Bag"..i.."Mover"):Show();
		end
		MovableBags_Config.Mode = "Movable";
		MovableBags_UpdateVisible();
	else
		CT_Print("<CTMod> Bags are now locked to their positions.", 1.0, 1.0, 0);
		for i=0,10,1 do
			getglobal("Bag"..i.."Mover"):Hide();
		end
		MovableBags_Config.Mode = "Locked";
	end
end
function MovableBags_InitFunction(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		for i=0,10,1 do
			getglobal("Bag"..i.."Mover"):Show();
		end
		MovableBags_Config.Mode = "Movable";
		MovableBags_UpdateVisible();
	else
		for i=0,10,1 do
			getglobal("Bag"..i.."Mover"):Hide();
		end
		MovableBags_Config.Mode = "Locked";
	end
end

function MovableBags_ResetPositions()
	CT_Print("<CTMod> Bag positions have been reset.", 1, 1, 0);
	for i=0,10,1 do
		local mover = getglobal("Bag"..i.."Mover");
		local pos = MovableBags_DefaultPositions[i];
		mover:ClearAllPoints();
		mover:SetPoint(pos[1],pos[2],pos[3],pos[4],pos[5]);
	end
end

if ( CT_RegisterMod ) then
	CT_RegisterMod("Movable Bags", "Unlocks bags", 5, "Interface\\Icons\\INV_Misc_Bag_10", "Allows you to move your bags wherever you want them.\nMove by holding and dragging the bag nameplate.", "off", nil, MovableBags_Function, MovableBags_InitFunction);
	CT_RegisterMod("Reset Bags", "Resets bags", 5, "Interface\\Icons\\INV_Misc_Bag_10_Green", "Resets the bag position to the default positions.", "switch", nil, MovableBags_ResetPositions);
end