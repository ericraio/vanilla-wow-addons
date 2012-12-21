--[[

FixCTGroups v0.2b by Tim Mullin

This mod simply lines up the CT_RaidAssist group frames nicely.
You no longer need to try to align them perfectly manually. It
also allows you to drag a group  and drag the rest of the groups
with it.

Use /fixctroups, /fctg or /ctg to bring up the configuratioin frame.

If you wish to be able to drag each group individually again,
check the box next to Default CTRA Style.

A checkbox is provided to hide or show all groups at once as a
conveinance, it functions exactly the same as the Show All Groups
checkbox on the CTRaid tab.

Click the Groups button to bring up the Group Positioning frame.
Here you can drag and drop groups to set up their relative positions.
All vertically and horizontally adjacent groups (not diagonal) will 
be linked together. The groups can be dragged in a similar manner to 
how one drags raid members into different groups.

You can create smaller groupings of groups that can be seperately
moved by leaving space between the groups. For example,
........
........
........
.12..56.
.34..78.
........
........
........

The Group Positioning frame serves only to define the relationships
between groups. It does not determine the position of the groups
onscreen. If you have an arrangement, it does not matter how many
blank spaces surround it,
........
.1234...
.5678...
........
........
........
........

appears the same onscreen as

........
........
........
..1234..
..5678..
........
........
........

Likewise, if you have several smaller groupings of groups, it does
not matter how many blank spaces are between them, the onscreen
position will be the same and controlled by where you drag that
group to.

Note that only rectangular arrangements of groups work at this time.
Some arrangements may produce unexpected results. If anything gets
really screwed up, just click the Defaults button.

Example arrangements that should work:
1234
5678

12 56
34 78

15
26
37
48

Example arrangements that might not work (where . means an empty slot)
123 ..5
4.. 678

12 34
5. .6
7. .8

]]

FIXCTGROUPSVERSION = "0.2b";

local FixCTGroupsVariablesLoaded = false;

local FixCTGroupsDefaultConfig = {
	ctradefault = 0,
	linkall = 1,
	dx = -3,
	dy = -20,
	groups = {
		[ 1] = 0, [ 2] = 0, [ 3] = 0, [ 4] = 0, [ 5] = 0, [ 6] = 0, [ 7] = 0, [ 8] = 0, 
		[ 9] = 0, [10] = 0, [11] = 0, [12] = 0, [13] = 0, [14] = 0, [15] = 0, [16] = 0, 
		[17] = 0, [18] = 0, [19] = 0, [20] = 0, [21] = 0, [22] = 0, [23] = 0, [24] = 0, 
		[25] = 0, [26] = 0, [27] = 1, [28] = 2, [29] = 3, [30] = 4, [31] = 0, [32] = 0, 
		[33] = 0, [34] = 0, [35] = 5, [36] = 6, [37] = 7, [38] = 8, [39] = 0, [40] = 0, 
		[41] = 0, [42] = 0, [43] = 0, [44] = 0, [45] = 0, [46] = 0, [47] = 0, [48] = 0, 
		[49] = 0, [50] = 0, [51] = 0, [52] = 0, [53] = 0, [54] = 0, [55] = 0, [56] = 0, 
		[57] = 0, [58] = 0, [59] = 0, [60] = 0, [61] = 0, [62] = 0, [63] = 0, [64] = 0
	}
};

function FixCTGroupsInit()
	local k, v;

	-- set up config
	if not FixCTGroupsConfig then
		FixCTGroupsConfig = { };
	end

	for k, v in pairs(FixCTGroupsDefaultConfig) do
		if k ~= "groups" and not FixCTGroupsConfig[k] then
			FixCTGroupsConfig[k] = v;
		end
	end

	if not FixCTGroupsConfig.groups then
		FixCTGroupsConfig.groups = { };

		for k, v in pairs(FixCTGroupsDefaultConfig.groups) do
			FixCTGroupsConfig.groups[k] = v;
		end
	end

	-- set up slash command
	SlashCmdList["FIXCTGROUPS"] = function(msg)
		DEFAULT_CHAT_FRAME:AddMessage("FixCTGroups v"..FIXCTGROUPSVERSION, 1, 1, 1);
		FixCTGroupsConfigFrame:Show();
	end
	SLASH_FIXCTGROUPS1 = "/fixctgroups";
	SLASH_FIXCTGROUPS2 = "/fctg";
	SLASH_FIXCTGROUPS3 = "/ctg";

	FixCTGroupsConfigChanged();

	FixCTGroupsVariablesLoaded = true;
end

function FixCTGroupsClearPoints()
	local f;

	for i = 2, 8 do
		f = getglobal("CT_RAGroup"..i);
		f:ClearAllPoints();
	end
end

function FixCTGroupsArrangeGroups()
	local i, group, left, up, right, down;
	local c = FixCTGroupsConfig;
	local g = c.groups;
	local p = "FixCTGroups";

	-- reset then fix it
	FixCTGroupsCTRADefault();

	for i = 1, 64 do
		if g[i] ~= 0 then
			--ezheal_msg("i: "..i.."; group: "..g[i]);
			group = getglobal("CT_RAGroup"..g[i]);

			-- is there a group to the left of this one?
			if (i > 1) and (math.mod(i - 1, 8) ~= 0) and (g[i - 1] ~= 0) then
				left = getglobal("CT_RAGroup"..g[i - 1]);
			else
				left = nil;
			end

			-- is there a group above this one?
			if (i > 8) and (g[i - 8] ~= 0) then
				up = getglobal("CT_RAGroup"..g[i - 8]);
			else
				up = nil;
			end

--[[			if i < 64 and math.mod(i, 8) ~= 0 and g[i + 1] ~= 0 then
				right = getglobal("CT_RAGroup"..g[i + 1]);
			else
				right = nil;
			end

			if i < 57 and g[i + 8] ~= 0 then
				down = getglobal("CT_RAGroup"..g[i + 8]);
			else
				down = nil;
			end
]]
			if left or up --[[or right or down]] then
				group:ClearAllPoints();

				if left then
					--ezheal_msg(group:GetName().."'s left is "..left:GetName());
					group:SetPoint("TOPLEFT", left, "TOPRIGHT", c.dx, 0);
				end

				if up then
					--ezheal_msg(group:GetName().."'s up is "..up:GetName());
					group:SetPoint("TOPRIGHT", up, "BOTTOMRIGHT", 0, 0-c.dy);
				end

--[[				if right then
					group:SetPoint("BOTTOMRIGHT", right, "BOTTOMLEFT", c.dx, 0);
				end

				if down then
					group:SetPoint("BOTTOMLEFT", down, "TOPLEFT", 0, 0-c.dy);
				end]]
			end

		end
	end
end

function FixCTGroupsXLink(f, g)
	f:ClearAllPoints();
	f:SetPoint("TOPLEFT", g, "TOPRIGHT", FixCTGroupsConfig.dx, 0);
end

function FixCTGroupsYLink(f, g)
	f:ClearAllPoints();
	f:SetPoint("TOPLEFT", g, "BOTTOMLEFT", 0, 0-FixCTGroupsConfig.dy);
end

function FixCTGroupsConfigFrameOnShow()
	local f = FixCTGroupsConfigFrame;
	local c = FixCTGroupsConfig;

	if not FixCTGroupsVariablesLoaded then
		f:Hide();
		return;
	end

	getglobal(f:GetName().."SpacingX"):SetValue(c.dx);
	getglobal(f:GetName().."SpacingY"):SetValue(c.dy);

	getglobal(f:GetName().."CTRADefault"):SetChecked(c.ctradefault);
	--getglobal(f:GetName().."LinkAllGroups"):SetChecked(c.linkall);
	getglobal(f:GetName().."ShowGroups"):SetChecked(CT_RACheckAllGroups:GetChecked());
end

function FixCTGroupsSetDefaultConfig()
	local k, v;

	if not FixCTGroupsVariablesLoaded then
		return;
	end

	for k, v in pairs(FixCTGroupsDefaultConfig) do
		if k ~= "groups" then
			FixCTGroupsConfig[k] = v;
		end
	end

	FixCTGroupsConfig.groups = nil;
	FixCTGroupsConfig.groups = { };

	local i;
		
	for k, v in pairs(FixCTGroupsDefaultConfig.groups) do
		FixCTGroupsConfig.groups[k] = v;
	end

	FixCTGroupsConfigChanged();
end

function FixCTGroupsConfigFrameOptionOnClick()
	local c = FixCTGroupsConfig;

	if not FixCTGroupsVariablesLoaded then
		this:GetParent():Hide();
		return;
	end

	local name = this:GetName();
	local parent = this:GetParent():GetName();

	if name == parent.."SpacingX" then
		c.dx = this:GetValue();
	elseif name == parent.."SpacingY" then
		c.dy = this:GetValue();
	elseif name == parent.."CTRADefault" then
		c.ctradefault = this:GetChecked();
	elseif name == parent.."LinkAllGroups" then
		c.linkall = this:GetChecked();
	elseif name == parent.."ShowGroups" then
		CT_RACheckAllGroups:SetChecked(getglobal(parent.."ShowGroups"):GetChecked());
		CT_RA_CheckAllGroups();
	end

	FixCTGroupsConfigChanged();
end

function FixCTGroupsConfigChanged()
	local fn = nil;
	local c = FixCTGroupsConfig;

	FixCTGroupsConfigFrameOnShow();

	if c.ctradefault == 1 then
		FixCTGroupsCTRADefault();
	else
		FixCTGroupsArrangeGroups();
	end
end

-- mimic what happens when ctraid loads to make each
-- group draggable
function FixCTGroupsCTRADefault()
	local f, g;

	for i = 1, 8 do
		f = getglobal("CT_RAGroup"..i);
		g = getglobal("CT_RAGroupDrag"..i);

		CT_RA_LinkDrag(f, g, "TOP", "TOP", 0, 10);
	end
end


-------------------------
-- functions for the group cells frame
-------------------------

local FIXCTGROUPS_MOVING_GROUP = nil;
local FIXCTGROUPS_TARGET_SLOT = nil;

function FixCTGroupsCellsFrameOnShow()
	local i, slot, button;
	local p = "FixCTGroupsCellsFrameCell";

	for i = 1, 64 do
		slot = getglobal(p.."Slot"..i);
		slot.button = nil;

		if FixCTGroupsConfig.groups[i] and FixCTGroupsConfig.groups[i] ~= 0 then
			button = getglobal(p..FixCTGroupsConfig.groups[i]);
			
			button.slot = slot;
			slot.button = button;

			button:ClearAllPoints();
			button:SetPoint("TOPLEFT", slot, "TOPLEFT", 0, 0);
		end
	end
end

function FixCTGroupsCellsFrameOnHide()
	local i, f;

	for i = 1, 64 do
		f = getglobal("FixCTGroupsCellsFrameCellSlot"..i);

		if f.button then
			FixCTGroupsConfig.groups[i] = tonumber(getglobal(f.button:GetName().."Label"):GetText());
		else
			FixCTGroupsConfig.groups[i] = 0;
		end
	end

	FixCTGroupsConfigChanged();
end

function FixCTGroupsCellOnDragStart()
	local cursorX, cursorY = GetCursorPosition();
	this:SetBackdropColor(this.hover.r, this.hover.g, this.hover.b);
	this:SetFrameLevel(this:GetFrameLevel() + 10);
	this:ClearAllPoints();
	this:SetPoint("CENTER", nil, "BOTTOMLEFT", cursorX*GetScreenWidthScale(), cursorY*GetScreenHeightScale());
	this:StartMoving();
	FIXCTGROUPS_MOVING_GROUP = this;
end

function FixCTGroupsCellOnDragStop(raidButton)
	if ( not raidButton ) then
		raidButton = this;
	end
	
	raidButton:StopMovingOrSizing();
	raidButton:SetBackdropColor(raidButton.bg.r, raidButton.bg.g, raidButton.bg.b);
	raidButton:SetFrameLevel(raidButton:GetFrameLevel() - 10);
	FIXCTGROUPS_MOVING_GROUP = nil;

	if ( FIXCTGROUPS_TARGET_SLOT and FIXCTGROUPS_TARGET_SLOT:GetID() ~= raidButton.slot:GetID() ) then
		if (FIXCTGROUPS_TARGET_SLOT.button) then
			--ezheal_msg("currently a button there");
			local oldButton = FIXCTGROUPS_TARGET_SLOT.button;
			local newSlot   = FIXCTGROUPS_TARGET_SLOT;
			local oldSlot   = raidButton.slot;

			oldButton:SetPoint("TOPLEFT", raidButton.slot, "TOPLEFT", 0, 0);
			oldButton:SetBackdropColor(oldButton.bg.r, oldButton.bg.g, oldButton.bg.b);
			oldButton.slot = oldSlot;
			oldSlot.button = oldButton;

			raidButton:SetPoint("TOPLEFT", newSlot, "TOPLEFT", 0, 0);
			raidButton.slot   = newSlot;
			newSlot.button = raidButton;
		else
			--ezheal_msg("no button there");
			local newSlot = FIXCTGROUPS_TARGET_SLOT;
			local oldSlot = raidButton.slot;

			newSlot:UnlockHighlight();

			raidButton:SetPoint("TOPLEFT", newSlot, "TOPLEFT", 0, 0);
			oldSlot.button = nil;

			newSlot.button = raidButton;

			raidButton.slot = newSlot;
		end
	else
		if ( FIXCTGROUPS_TARGET_SLOT ) then
			-- dragged to same slot it was already on
			--ezheal_msg("same slot as before");
			local slot = FIXCTGROUPS_TARGET_SLOT;
			slot:SetBackdropColor(slot.bg.r, slot.bg.g, slot.bg.b);
			slot:UnlockHighlight();
		end
		raidButton:SetPoint("TOPLEFT", raidButton.slot, "TOPLEFT", 0, 0);
	end
end

function FixCTGroupsCellsFrameOnUpdate(elapsed)
	if ( FIXCTGROUPS_MOVING_GROUP ) then
		local button, slot;
		FIXCTGROUPS_TARGET_SLOT = nil;

		for i = 1, 64 do
			slot = getglobal("FixCTGroupsCellsFrameCellSlot"..i);
			button = slot.button;

			if ( MouseIsOver(slot) ) then
				FIXCTGROUPS_TARGET_SLOT = slot;

				slot:SetBackdropColor(slot.hover.r, slot.hover.g, slot.hover.b);
				slot:LockHighlight();

				if button and button ~= FIXCTGROUPS_MOVING_GROUP then
					button:SetBackdropColor(slot.hover.r, slot.hover.g, slot.hover.b);
				end
			else
				slot:SetBackdropColor(slot.bg.r, slot.bg.g, slot.bg.b);
				slot:UnlockHighlight();

				if button and button ~= FIXCTGROUPS_MOVING_GROUP then
					button:SetBackdropColor(button.bg.r, button.bg.g, button.bg.b);
				end
			end
		end
	end
end
