CT_MovableParty_IsInstalled = 1; -- For CT_BarMod

CT_oldPMF_UM = PartyMemberFrame_UpdateMember;
function CT_newPMF_UM()
	CT_oldPMF_UM();
	if ( this:IsVisible() and CT_MF_ShowFrames ) then
		getglobal("CT_MovableParty" .. this:GetID() .. "_Drag"):Show();
	else
		getglobal("CT_MovableParty" .. this:GetID() .. "_Drag"):Hide();
	end
end
PartyMemberFrame_UpdateMember = CT_newPMF_UM;

CT_AddMovable("CT_MovableParty1_Drag", CT_MP_PARTY1, "TOPLEFT", "TOPLEFT", "UIParent", 50, -131, CT_MovableParty_UpdateMembers, function()
	if ( CT_BarMod_SidebarMoved and CT_CheckLSidebar ) then
		CT_MovableParty.reset = 0.1;
	end
end);

CT_AddMovable("CT_MovableParty2_Drag", CT_MP_PARTY2, "TOPLEFT", "TOPLEFT", "CT_MovableParty1_Drag", 0, -63, CT_MovableParty_UpdateMembers, function()
	if ( CT_BarMod_SidebarMoved and CT_CheckLSidebar ) then
		CT_MovableParty.reset = 0.1;
	end
end);

CT_AddMovable("CT_MovableParty3_Drag", CT_MP_PARTY3, "TOPLEFT", "TOPLEFT", "CT_MovableParty2_Drag", 0, -63, CT_MovableParty_UpdateMembers, function()
	if ( CT_BarMod_SidebarMoved and CT_CheckLSidebar ) then
		CT_MovableParty.reset = 0.1;
	end
end);

CT_AddMovable("CT_MovableParty4_Drag", CT_MP_PARTY4, "TOPLEFT", "TOPLEFT", "CT_MovableParty3_Drag", 0, -63, CT_MovableParty_UpdateMembers, function()
	if ( CT_BarMod_SidebarMoved and CT_CheckLSidebar ) then
		CT_MovableParty.reset = 0.1;
	end
end);

function CT_MovableParty_UpdateMembers()
	for i = 1, 4, 1 do
		if ( i <= GetNumPartyMembers() and CT_MF_ShowFrames ) then
			getglobal("CT_MovableParty" .. i .. "_Drag"):Show();
		else
			getglobal("CT_MovableParty" .. i .. "_Drag"):Hide();
		end
	end
end

function CT_MovableParty_OnUpdate(elapsed)
	if ( this.reset ) then
		this.reset = this.reset - elapsed;
		if ( this.reset <= 0 ) then
			this.reset = nil;
			CT_BarMod_SidebarMoved = 0;
			CT_CheckLSidebar();
		end
	end
end