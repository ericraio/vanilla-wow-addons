 -- Variables
CT_RATarget = { 
	["MainTanks"] = { }
};

-- Event handler
function CT_RATarget_OnEvent(event)
	if ( event == "PLAYER_TARGET_CHANGED" ) then
		CT_RATargetFrameCurrentTarget:SetText("Current Target: |c00FFFFFF" .. (UnitName("target") or "<No Target>") .. "|r");
		CT_RATarget_UpdateInfoBox();
	elseif ( event == "RAID_ROSTER_UPDATE" ) then
		for k, v in CT_RATarget.MainTanks do
			if ( UnitName("raid" .. ( v[1] or "")) ~= v[2] ) then
				for i = 1, GetNumRaidMembers(), 1 do
					if ( UnitName("raid" .. i) == v[2] ) then
						CT_RATarget.MainTanks[k][1] = i;
						break;
					end
				end
			end
		end
	end
end

-- Update handler
function CT_RATarget_OnUpdate(elapsed)
	if ( CT_RATarget.holdInfo ) then
		CT_RATarget.holdInfo = CT_RATarget.holdInfo - elapsed;
		if ( CT_RATarget.holdInfo <= 0 ) then
			CT_RATarget.holdInfo = nil;
			CT_RATarget_UpdateInfoBox();
		end
	end
	this.elapsed = this.elapsed - elapsed;
	if ( this.elapsed <= 0 ) then
		this.elapsed = 0.5;
		if ( not CT_RATarget.holdInfo ) then
			CT_RATarget_UpdateInfoBox();
		end
		CT_RATarget_UpdateStats();
	end
	if ( CT_RATarget.waitingForAssist ) then
		CT_RATarget.waitingForAssist[1] = CT_RATarget.waitingForAssist[1] - elapsed;
		if ( floor(CT_RATarget.waitingForAssist[1]+elapsed) > floor(CT_RATarget.waitingForAssist[1]) ) then
			CT_RATarget_CheckAssist();
		end
		if ( CT_RATarget.waitingForAssist and CT_RATarget.waitingForAssist[1] <= 0 ) then
			CT_RATarget.waitingForAssist = nil;
			CT_RATarget_UpdateInfoBox();
		end
	end
	if ( CT_RATarget.assistPerson ) then
		CT_RATarget.assistPerson[2] = CT_RATarget.assistPerson[2] - elapsed;
		if ( CT_RATarget.assistPerson[2] <= 0 ) then
			CT_RA_AssistFrame:Hide();
			CT_RATarget.assistPerson = nil;
		end
	end
end

-- Loading procedure
function CT_RATarget_OnLoad()
	this.elapsed = 0.5;
	this:SetBackdropColor(0, 0, 0, 0.8);
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	for i = 1, 10, 1 do
		getglobal(this:GetName() .. "MT" .. i .. "Text"):SetText("MT #" .. i .. ":");
		getglobal(this:GetName() .. "Target" .. i .. "Text"):SetText("Target #" .. i .. ":");
	end
	CT_RATarget_UpdateInfoBox();
end

-- General function to set the info box text
function CT_RATarget_UpdateInfoBox()
	if ( CT_RATarget.holdInfo ) then
		return;
	end
	CT_RATargetFrame.targetFunction = "CT_RATarget_AssistMT";
	CT_RATargetFrame.rightClickFunction = nil;
	CT_RATargetFrame.mtFunction = "CT_RATarget_TargetMT";
	local text = CT_RATargetFrameInfoBoxText;
	local var = CT_RATarget;
	if ( var.waitingForAssist and UnitInRaid("player") ) then
		text:SetText("Waiting for |c00FFFFFF" .. var.waitingForAssist[2] .. "|r to assist, |c00FFFFFF" .. ceil(var.waitingForAssist[1]) .. "|r seconds remaining.\nClick here to cancel.");
		CT_RATargetFrame.targetFunction = "CT_RATarget_MTAssist";
		CT_RATargetFrameInfoBox.clickFunction = "CT_RATarget_CancelAssist";
		CT_RATargetFrameInfoBox.lock = nil;
		if ( CT_RATargetFrameInfoBox.isOver ) then
			CT_RATargetFrameInfoBoxMouseOver:Show();
		end
	elseif ( UnitExists("target") and UnitInRaid("player") ) then
		if ( UnitCanAttack("player", "target") and UnitInRaid("player") ) then
			CT_RATargetFrame.targetFunction = "CT_RATarget_MTAssist";
			local hasMainTankWithoutTarget, hasTargetAsTarget;
			local hasSeveralAsTarget = { };
			if ( var.MainTanks ) then
				-- Find the first MT with no target
				for k, v in var.MainTanks do
					if ( v[1] ) then
						if ( UnitName("raid" .. v[1]) ~= v[2] ) then
							for i = 1, GetNumRaidMembers(), 1 do
								if ( UnitName("raid" .. i) == v[2] ) then
									v[1] = i;
									break;
								end
							end
						end
						if ( UnitName("raid" .. v[1]) == v[2] and not hasMainTankWithoutTarget and not UnitIsUnit("player", "raid" .. v[1]) ) then
							if ( not UnitExists("raid" .. v[1] .. "target") ) then
								hasMainTankWithoutTarget = { k, v[2] };
							end
						end
						if ( UnitExists("raid" .. v[1] .. "target") and UnitIsUnit("target", "raid" .. v[1] .. "target") and not hasTargetAsTarget ) then
							hasTargetAsTarget = { k, v[2], v[1] };
						elseif ( hasTargetAsTarget and UnitIsUnit("raid" .. v[1] .. "target", "raid" .. hasTargetAsTarget[3] .. "target") ) then
							tinsert(hasSeveralAsTarget, v[2]);
						end
					end
				end
			end
			if ( hasTargetAsTarget and UnitName("player") ~= hasTargetAsTarget[2] ) then
				CT_RATargetFrame.rightClickFunction = "CT_RATarget_MTAssist";
				CT_RATargetFrame.targetFunction = "CT_RATarget_AssistMT";
				if ( hasSeveralAsTarget ) then
					local tempText = "";
					for k, v in hasSeveralAsTarget do
						if ( strlen(tempText) > 0 ) then
							tempText = tempText .. ", ";
						end
						tempText = tempText .. "|c00FFFFFF" .. v .. "|r";
					end
					if ( strlen(tempText) > 0 ) then
						text:SetText("Several people have that target:\n|c00FFFFFF" .. hasTargetAsTarget[2] .. "|r, " .. tempText .. ".\nRight-click a target ID to have that MT assist you.");
					else
						text:SetText("That is |c00FFFFFF" .. hasTargetAsTarget[2] .. "|r's target.\nRight-click a target ID to have that MT assist you.");
					end
				else
					text:SetText("That is |c00FFFFFF" .. hasTargetAsTarget[2] .. "|r's target.\nRight-click a target ID to have that MT assist you.");
				end
				CT_RATargetFrameInfoBox.lock = 1;
				CT_RATargetFrameInfoBoxMouseOver:Hide();
			elseif ( hasMainTankWithoutTarget ) then
				text:SetText("Click a target ID to set that MT's target to |c00FFFFFF" .. UnitName("target") .. "|r.\nClick here to set |c00FFFFFF" .. hasMainTankWithoutTarget[2] .. "|r's target to |c00FFFFFF" .. UnitName("target") .. "|r.");		
				CT_RATargetFrameInfoBox.clickFunction = "CT_RATarget_MTAssist";
				CT_RATargetFrameInfoBox.functionArg = hasMainTankWithoutTarget[1];
				CT_RATargetFrameInfoBox.lock = nil;
				if ( CT_RATargetFrameInfoBox.isOver ) then
					CT_RATargetFrameInfoBoxMouseOver:Show();
				end
			elseif ( var.MainTanks and var.MainTanks[10] and UnitExists("raid" .. var.MainTanks[10][1] .. "target") ) then
				text:SetText("Click a target ID to set that MT's target to |c00FFFFFF" .. UnitName("target") .. "|r.");
				CT_RATargetFrame.targetFunction = "CT_RATarget_MTAssist";
				CT_RATargetFrameInfoBox.lock = 1;
				CT_RATargetFrameInfoBoxMouseOver:Hide();
			elseif ( getn(var.MainTanks) > 0 ) then
				text:SetText("Every MT has a target.\nClick a target ID to have that MT assist you.");
				CT_RATargetFrame.targetFunction = "CT_RATarget_MTAssist";
				CT_RATargetFrameInfoBox.lock = 1;
				CT_RATargetFrameInfoBoxMouseOver:Hide();
			else
				text:SetText("Please specify more Main Tanks.");
				CT_RATargetFrameInfoBox.lock = 1;
				CT_RATargetFrameInfoBoxMouseOver:Hide();
			end
		elseif ( UnitInRaid("target") ) then
			local hasSet;
			for k, v in var.MainTanks do
				if ( v[2] == UnitName("target") ) then
					text:SetText("Right-click a MT ID to remove that MT from the list.\nClick here to remove |c00FFFFFF" .. UnitName("target") .. "|r from the MT list.");
					hasSet = k;
					CT_RATargetFrame.mtFunction = "CT_RATarget_SetMT";
					if ( CT_RATargetFrame.MTOver ) then
						CT_RATargetFrame.MTOver:Show();
					end
					CT_RATargetFrameInfoBox.clickFunction = "CT_RATarget_RemoveMT";
					CT_RATargetFrameInfoBox.functionArg = k;
					CT_RATargetFrameInfoBox.lock = nil;
					if ( CT_RATargetFrameInfoBox.isOver ) then
						CT_RATargetFrameInfoBoxMouseOver:Show();
					end
					break;
				end
			end
			if ( not hasSet ) then
				local nextMT = 1;
				if ( var.MainTanks ) then
					nextMT = getn(var.MainTanks)+1;
				end
				if ( nextMT > 10 ) then
					text:SetText("You already have |c00FFFFFF10|r assigned main tanks.\nClick a MT to set |c00FFFFFF" .. UnitName("target") .. "|r as that MT.");
					CT_RATargetFrame.mtFunction = "CT_RATarget_SetMT";
					if ( CT_RATargetFrame.MTOver ) then
						CT_RATargetFrame.MTOver:Show();
					end
					CT_RATargetFrameInfoBox.lock = 1;
					CT_RATargetFrameInfoBoxMouseOver:Hide();
				else
						text:SetText("Click a MT ID to set |c00FFFFFF" .. UnitName("target") .. "|r as that MT.\nClick here to set |c00FFFFFF" .. UnitName("target") .. "|r as MT |c00FFFFFF#" .. nextMT .. "|r.");
						CT_RATargetFrameInfoBox.clickFunction = "CT_RATarget_SetMT";
						CT_RATargetFrame.mtFunction = "CT_RATarget_SetMT";
						if ( CT_RATargetFrame.MTOver ) then
							CT_RATargetFrame.MTOver:Show();
						end
						CT_RATargetFrameInfoBox.functionArg = nextMT;
						CT_RATargetFrameInfoBox.lock = nil;
						if ( CT_RATargetFrameInfoBox.isOver ) then
							CT_RATargetFrameInfoBoxMouseOver:Show();
						end
				end
			end
		else
			text:SetText("Unknown target. Please select a hostile mob or a player in your raid.");
			CT_RATargetFrameInfoBox.lock = 1;
			CT_RATargetFrameInfoBoxMouseOver:Hide();
		end
	elseif ( not UnitInRaid("player") ) then
		text:SetText("The Target Management system requires a raid group.");
		CT_RATargetFrameInfoBox.lock = 1;
		CT_RATargetFrameInfoBoxMouseOver:Hide();
	else
		text:SetText("Please select a target to use the Target Management system.");
		CT_RATargetFrameInfoBox.lock = 1;
		CT_RATargetFrameInfoBoxMouseOver:Hide();
	end
end

function CT_RATarget_UpdateStats()
	for k, v in CT_RATarget.MainTanks do
		if ( v[1] ) then
			if ( UnitName("raid" .. v[1]) ~= v[2] ) then
				for i = 1, GetNumRaidMembers(), 1 do
					if ( UnitName("raid" .. i) == v[2] ) then
						CT_RATarget.MainTanks[k][1] = i;
						break;
					end
				end
			end
		end
	end
	local errorColors = {
		{ 1, 0, 0 },
		{ 0.5, 0, 0.5 },
		{ 0, 0, 1 },
		{ 0, 0.5, 0.5 },
		{ 0, 1, 0 }
	};
	local errors = { };
	for i = 1, 10, 1 do
		getglobal("CT_RATargetFrameTarget" .. i .. "Error"):Hide();
		local mtText = getglobal("CT_RATargetFrameMT" .. i .. "Text");
		local targetText = getglobal("CT_RATargetFrameTarget" .. i .. "Text");
		if ( CT_RATarget.MainTanks[i] ) then
			for k, v in CT_RATarget.MainTanks do
				if ( v[1] ) then
					if ( k ~= i and UnitExists("raid" .. CT_RATarget.MainTanks[i][1] .. "target") and UnitIsUnit("raid" .. v[1] .. "target", "raid" .. CT_RATarget.MainTanks[i][1] .. "target") ) then
						local currIndex;
						local minVal, maxVal = min(k, i), max(k, i);
						for key, val in errors do
							for index, value in val do
								if ( value == minVal ) then
									currIndex = { key, 1 };
									break;
								elseif ( value == maxVal ) then
									currIndex = { key, 2 };
								end
							end
							if ( currIndex ) then
								break;
							end
						end
						if ( currIndex and currIndex[2] == 1 ) then
							tinsert(errors[currIndex[1]], maxVal);
						elseif ( currIndex and currIndex[2] == 2 ) then
							tinsert(errors[currIndex[1]], minVal);
						elseif ( errors[min(k, i)] ) then
							tinsert(errors[minVal], maxVal);
						else
							errors[minVal] = { maxVal };
						end
					end
				end
			end
			mtText:SetText("MT #" .. i .. ": |c00FFFFFF" .. CT_RATarget.MainTanks[i][2] .. "|r");
			targetText:SetTextColor(1, 0.82, 0);
			getglobal("CT_RATargetFrameTarget" .. i).lock = nil;
			if ( getglobal("CT_RATargetFrameTarget" .. i).isOver ) then
				getglobal("CT_RATargetFrameTarget" .. i .. "MouseOver"):Show();
			end
			if ( UnitName("raid" .. CT_RATarget.MainTanks[i][1] .. "target") ) then
				targetText:SetText("Target #" .. i .. ": |c00FFFFFF" .. UnitName("raid" .. CT_RATarget.MainTanks[i][1] .. "target"));
			else
				targetText:SetText("Target #" .. i .. ": |c00FFFFFF<No Target>|r");
			end
		else
			getglobal("CT_RATargetFrameTarget" .. i .. "MouseOver"):Hide();
			getglobal("CT_RATargetFrameTarget" .. i).lock = 1;
			mtText:SetText("MT #" .. i .. ": |c00FFFFFF<No MT Assigned>|r");
			targetText:SetTextColor(0.3, 0.3, 0.3);
			targetText:SetText("Target #" .. i .. ": No MT Assigned");
		end
	end
	local id = 0;
	for k, v in errors do
		if ( id < 5 ) then
			id = id + 1;
			for key, val in v do
				getglobal("CT_RATargetFrameTarget" .. val .. "Error"):Show();
				getglobal("CT_RATargetFrameTarget" .. val .. "Error"):SetVertexColor(errorColors[id][1], errorColors[id][2], errorColors[id][3]);
			end
			getglobal("CT_RATargetFrameTarget" .. k .. "Error"):Show();
			getglobal("CT_RATargetFrameTarget" .. k .. "Error"):SetVertexColor(errorColors[id][1], errorColors[id][2], errorColors[id][3]);
		end
	end
end

function CT_RATarget_SetMT(id)
	if ( UnitExists("target") and UnitInRaid("target") ) then
		for k, v in CT_RATarget.MainTanks do
			if ( v[2] == UnitName("target") ) then
				CT_RATarget_TargetMT(id);
				return;
			end
		end
		CT_RA_MainTanks[id] = UnitName("target");
		for i = 1, GetNumRaidMembers(), 1 do
			if ( UnitIsUnit("target", "raid" .. i) ) then
				CT_RATarget.MainTanks[id] = { i, UnitName("target") };
				break;
			end
		end
		CT_RA_AddMessage("SET " .. id .. " " .. UnitName("target"));
		CT_RATarget.holdInfo = 2;
		CT_RATargetFrameInfoBoxText:SetText("Successfully set |c00FFFFFF" .. UnitName("target") .. "|r as MT |c00FFFFFF#" .. id .. "|r.");
		CT_RATargetFrameInfoBox.lock = 1;
		CT_RATargetFrameInfoBoxMouseOver:Hide();
	end
	CT_RATarget_UpdateStats();
end

function CT_RATarget_RemoveMT(id)
	if ( CT_RATarget.MainTanks[id] ) then
		CT_RATarget.holdInfo = 2;
		CT_RATargetFrameInfoBoxText:SetText("Successfully removed |c00FFFFFF" .. CT_RATarget.MainTanks[id][2] .. "|r from the MT list.");
	end
	CT_RATargetFrameInfoBox.lock = 1;
	CT_RATargetFrameInfoBoxMouseOver:Hide();
	if ( CT_RA_MainTanks[id] ) then
		CT_RA_AddMessage("R " .. CT_RA_MainTanks[id]);
	end
	CT_RA_MainTanks[id] = nil;
	CT_RATarget.MainTanks[id] = nil;
	CT_RATarget_UpdateStats();
end

function CT_RATarget_MTAssist(id)
	if ( CT_RATarget.MainTanks[id] and CT_RA_Level >= 1 and not UnitIsUnit("player", "raid" .. CT_RATarget.MainTanks[id][1]) ) then
		for k, v in CT_RATarget.MainTanks do
			if ( UnitIsUnit("target", "raid" .. v[1] .. "target") and not UnitIsUnit("player", "raid" .. v[1]) ) then
				return;
			end
		end
		if ( not CT_RA_Stats[CT_RATarget.MainTanks[id][2]] or not CT_RA_Stats[CT_RATarget.MainTanks[id][2]]["Reporting"] or not CT_RA_Stats[CT_RATarget.MainTanks[id][2]]["Version"] or CT_RA_Stats[CT_RATarget.MainTanks[id][2]]["Version"] < 1.4 ) then
			SendChatMessage("<CTRaid> Please assist me in order to get your assigned target.", "WHISPER", nil, CT_RATarget.MainTanks[id][2]);
			SendChatMessage("<CTRaid> " .. CT_RATarget.MainTanks[id][2] .. ", please assist me in order to get your assigned target.", "RAID");
		end
		if ( CT_RA_HMark ) then
			CastSpell(CT_RA_HMark[1], CT_RA_HMark[2]);
		end
		CT_RA_AddMessage("ASSISTME " .. CT_RATarget.MainTanks[id][2]);
		CT_RATarget.waitingForAssist = { 20, CT_RATarget.MainTanks[id][2], CT_RATarget.MainTanks[id][1], id } ;
		CT_RATarget_UpdateInfoBox();
	end
end

function CT_RATarget_TargetMT(id)
	if ( CT_RATarget.MainTanks[id] ) then
		TargetUnit("raid" .. CT_RATarget.MainTanks[id][1]);
		CT_RATarget_UpdateInfoBox();
	end
end

function CT_RATarget_AssistMT(id)
	if ( CT_RATarget.MainTanks[id] ) then
		AssistUnit("raid" .. CT_RATarget.MainTanks[id][1]);
		CT_RATarget_UpdateInfoBox();
	end
end

function CT_RATarget_CancelAssist()
	CT_RA_AddMessage("STOPASSIST " .. CT_RATarget.waitingForAssist[2]);
	CT_RATarget.waitingForAssist = nil;
	CT_RATarget_UpdateInfoBox();
end

function CT_RATarget_CheckAssist()
	if ( CT_RATarget.waitingForAssist and UnitIsUnit("target", "raid" .. CT_RATarget.waitingForAssist[3] .. "target") ) then
		CT_RATarget.holdInfo = 0.75;
		CT_RATargetFrameInfoBoxText:SetText("|c00FFFFFF" .. CT_RATarget.waitingForAssist[2] .. "|r (MT |c00FFFFFF#" .. CT_RATarget.waitingForAssist[4] .. "|r) has acquired your target.");
		CT_RATarget.waitingForAssist = nil;
		CT_RATargetFrameInfoBox.lock = 1;
		CT_RATargetFrameInfoBoxMouseOver:Hide();
	end
end

-- Slash command
CT_RA_RegisterSlashCmd("/tm", "Shows the Target Management dialog.", 15, "TM", function()
	if ( CT_RA_Level >= 1 ) then
		if ( CT_RATargetFrame:IsVisible() ) then
			HideUIPanel(CT_RATargetFrame);
		else
			ShowUIPanel(CT_RATargetFrame);
		end
	else
		CT_RA_Print("<CTRaid> You have to be promoted or leader to do that!", 1, 0.5, 0);
	end
end, "/tm");

-- Add to UISpecialFrames
tinsert(UISpecialFrames, "CT_RATargetFrame");