--Reputation Mod

Reputations_Version="0.14";

Reputations = { };
--Default Values
Reputations_Enabled = 1; --Enabled
Reputations_Raw = 1;     --Raw Numbers
Reputations_Frame = 2;   --Combat Window
Reputations_Next = 1;    --Display reputation needed until next standing
Reputations_Notify = 1;  --Display reputation notifications
Reputations_Debug = 0;   --Debug Info: Displays Previous, New and Diff and each faction change
Reputations_Load = 1;    --Display reputation loaded message
Reputations_Repeat = 0;  --Display amount of repetitions needed until next standing

REPUTATIONS_CHAT_FRAME = getglobal("ChatFrame"..Reputations_Frame);

-- Maximum units for each standing
Units = { };
Units[1] = 36000; -- Hated
Units[2] = 3000; -- Hostile
Units[3] = 3000; -- Unfriendly
Units[4] = 3000; -- Neutral
Units[5] = 6000; -- Friendly
Units[6] = 12000; -- Honored
Units[7] = 21000; -- Revered
Units[8] = 1000; -- Exalted

-- Function Hooks
local lOriginal_ReputationFrame_Update;

-- Add entry into cosmos configuration
function Reputation_RegisterCosmos()
	if (Cosmos_RegisterConfiguration) then
		Cosmos_RegisterConfiguration(
			"COS_REPUTATION",
			"SECTION",
			REPUTATION_HEADER,
			REPUTATION_HEADER_INFO);
		Cosmos_RegisterConfiguration(
			"COS_REPUTATION_SECTION",
			"SEPERATOR",
			REPUTATION_HEADER,
			REPUTATION_HEADER_INFO);
		Cosmos_RegisterConfiguration(
			"COS_REPUTATION_ENABLE",
			"CHECKBOX",
			REPUTATION_ENABLE,
			REPUTATION_ENABLE_INFO,
			Reputation_Cosmos_Toggle,
			1);
		Cosmos_RegisterConfiguration(
			"COS_REPUTATION_LOADED",
			"CHECKBOX",
			REPUTATION_LOADED,
			REPUTATION_LOADED_INFO,
			Reputation_Load_Toggle,
			1);
		Cosmos_RegisterConfiguration(
			"COS_REPUTATION_RAW",
			"CHECKBOX",
			REPUTATION_RAW,
			REPUTATION_RAW_INFO,
			Reputation_Raw_Toggle,
			1);
		Cosmos_RegisterConfiguration(
			"COS_REPUTATION_CHATFRAME",
			"SLIDER",
			REPUTATION_FRAME,
			REPUTATION_FRAME_INFO,
			Reputation_ChatFrame_Change,
			0,
			2, --default
			1, --min
			7, --max
			"chatframe",
			1,
			1,
			"",
			1);
		Cosmos_RegisterConfiguration(
			"COS_REPUTATION_NOTIFY",
			"CHECKBOX",
			REPUTATION_NOTIFICATION,
			REPUTATION_NOTIFICATION_INFO,
			Reputation_Notify_Toggle,
			1);
		Cosmos_RegisterConfiguration(
			"COS_REPUTATION_STANDING",
			"CHECKBOX",
			REPUTATION_STANDING,
			REPUTATION_STANDING_INFO,
			Reputation_Next_Toggle,
			1);
		Cosmos_RegisterConfiguration(
			"COS_REPUTATION_REPEATING",
			"CHECKBOX",
			REPUTATION_REPEATING,
			REPUTATION_REPEATING_INFO,
			Reputation_Repeat_Toggle,
			1);
	end
end

-- Round function
function round(x)
	return floor(x+0.5);
end

function ReputationMod_OnLoad()
	--Slash command for Non-Cosmos users	
	SlashCmdList["REPUTATIONCOMMAND"] = Reputation_SlashHandler;
	SLASH_REPUTATIONCOMMAND1 = "/reputation";
	SLASH_REPUTATIONCOMMAND2 = "/rep";

	this:RegisterEvent("UPDATE_FACTION");
	this:RegisterEvent("VARIABLES_LOADED");  --Set hook if needed and check chat frame
	
	Reputation_RegisterCosmos();

	if( DEFAULT_CHAT_FRAME and Reputations_Load==1 ) then
		DEFAULT_CHAT_FRAME:AddMessage(format(REPUTATION_LOADED,Reputations_Version));
	end
end

local function ReputationMod_Update()
	local numFactions = GetNumFactions();
	local factionIndex, factionStanding, factionBar, factionHeader, color;
	local name, standingID, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed;
	local multiplier=100;
	local RepRemains
	for factionIndex=1, numFactions, 1 do
		name, _, standingID, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed = GetFactionInfo(factionIndex);
		if (not isHeader) then
			if (Reputations_Enabled==1) then
				if (Reputations[name] and Reputations_Notify==1) then
					local multiplier = 100;
					local RawTotal = 0;
					if (Reputations_Raw==1) then
						multiplier=Units[standingID];
					end
					if (Reputations[name].standingID == standingID) then
						local difference = (barValue - Reputations[name].Value)*multiplier;
						if ( Reputations_Raw == 1 ) then
							difference = round(difference);
						end
						if (difference > 0) then --Reputation went up
							REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_GAINED"..Reputations_Raw),name,difference), 0.5, 0.5, 1.0);
							if (standingID ~= 8) then
								RepRemains = (1-barValue)*multiplier;
								if (Reputations_Next==1) then
									if ( Reputations_Raw == 1 ) then
										RepRemains = round(RepRemains);
									end
									REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_NEEDED"..Reputations_Raw),RepRemains,getglobal("FACTION_STANDING_LABEL"..standingID+1),name), 1.0, 1.0, 0.0);
								end
								if (Reputations_Repeat==1) then
									RepRepeats = RepRemains/difference;
									if (RepRepeats > floor(RepRepeats)) then
										RepRepeats = ceil(RepRepeats);
									end
									REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_REPEATS"),RepRepeats,getglobal("FACTION_STANDING_LABEL"..standingID+1),name), 1.0, 1.0, 0.0);
								end
							end
						elseif (difference < 0) then --Reputation went down
							difference=abs(difference);
							REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_LOST"..Reputations_Raw),name,difference), 0.5, 0.5, 1.0);
							if (standingID ~= 1) then
								RepRemains = barValue*multiplier;
								if (Reputations_Next==1) then
									if ( Reputations_Raw == 1 ) then
										RepRemains = round(RepRemains);
									end
									REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_LEFT"..Reputations_Raw),RepRemains,getglobal("FACTION_STANDING_LABEL"..standingID-1),name), 1.0, 1.0, 0.0);
								end
								if (Reputations_Repeat==1) then
									RepRepeats = RepRemains/difference;
									if (RepRepeats > floor(RepRepeats)) then
										RepRepeats = ceil(RepRepeats);
									end
									REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_REPEATS"),RepRepeats,getglobal("FACTION_STANDING_LABEL"..standingID+1),name), 1.0, 1.0, 0.0);
								end
							end
						end
					elseif (Reputations[name].standingID < standingID) then --Reputation went up
						RepRemains = (1-barValue)*multiplier;
						if (Reputations_Raw==1) then
							RepRemains = round(RepRemains);
							for i=Reputations[name].standingID, standingID, 1 do
								if ( i == standingID ) then
									RawTotal = RawTotal+barValue*multiplier;
								elseif ( i == Reputations[name].standingID ) then
									RawTotal = RawTotal+(1-Reputations[name].Value)*Units[i];
								else
									RawTotal = RawTotal+Units[i];
								end
							end
							RawTotal = round(RawTotal);
						else
							RawTotal = (standingID-Reputations[name].standingID-Reputations[name].Value+barValue)*multiplier;
						end
						REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_GAINED"..Reputations_Raw),name,RawTotal), 0.5, 0.5, 1.0);
						REPUTATIONS_CHAT_FRAME:AddMessage(format(REPUTATION_REACHED,getglobal("FACTION_STANDING_LABEL"..standingID),name), 1.0, 1.0, 0.0);
						if (standingID ~= 8) then
							if (Reputations_Next==1) then
								REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_NEEDED"..Reputations_Raw),RepRemains,getglobal("FACTION_STANDING_LABEL"..standingID+1),name), 1.0, 1.0, 0.0);
							end
							if (Reputations_Repeat==1) then
								RepRepeats = RepRemains/RawTotal;
								if (RepRepeats > floor(RepRepeats)) then
									RepRepeats = ceil(RepRepeats);
								end
								REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_REPEATS"),RepRepeats,getglobal("FACTION_STANDING_LABEL"..standingID+1),name), 1.0, 1.0, 0.0);
							end
						end
						color=FACTION_BAR_COLORS[standingID];
						ZoneTextString:SetText(getglobal("FACTION_STANDING_LABEL"..standingID).."!");
						ZoneTextString:SetTextColor(color.r, color.g, color.b);
						SubZoneTextString:SetText(name);
						SubZoneTextString:SetTextColor(color.r, color.g, color.b);
						ZoneTextFrame.startTime=GetTime();
						SubZoneTextFrame.startTime=GetTime();
						ZoneTextFrame:Show();
						SubZoneTextFrame:Show();
						--UIErrorsFrame:AddMessage(getglobal("FACTION_STANDING_LABEL"..standingID).."!", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
					else --Reputation went down
						RepRemains = barValue*multiplier;
						if (Reputations_Raw==1) then
							RepRemains = round(RepRemains);
							for i=standingID, Reputations[name].standingID, 1 do
								if ( i == standingID ) then
									RawTotal = RawTotal+(1-barValue)*multiplier;
								elseif ( i == Reputations[name].standingID ) then
									RawTotal = RawTotal+Reputations[name].Value*Units[i];
								else
									RawTotal = RawTotal+Units[i];
								end
							end
							RawTotal = round(RawTotal);
						else
							RawTotal = (Reputations[name].standingID-standingID-barValue+Reputations[name].Value)*multiplier;
						end
						REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_LOST"..Reputations_Raw),name,RawTotal), 0.5, 0.5, 1.0);
						REPUTATIONS_CHAT_FRAME:AddMessage(format(REPUTATION_REACHED,getglobal("FACTION_STANDING_LABEL"..standingID),name), 1.0, 1.0, 0.0);
						if (standingID ~= 1) then
							if (Reputations_Next==1) then
								REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_LEFT"..Reputations_Raw),RepRemains,getglobal("FACTION_STANDING_LABEL"..standingID-1),name), 1.0, 1.0, 0.0);
							end
							if (Reputations_Repeat==1) then
								RepRepeats = RepRemains/RawTotal;
								if (RepRepeats > floor(RepRepeats)) then
									RepRepeats = ceil(RepRepeats);
								end
								REPUTATIONS_CHAT_FRAME:AddMessage(format(getglobal("REPUTATION_REPEATS"),RepRepeats,getglobal("FACTION_STANDING_LABEL"..standingID+1),name), 1.0, 1.0, 0.0);
							end
						end
						color=FACTION_BAR_COLORS[standingID];
						ZoneTextString:SetText(getglobal("FACTION_STANDING_LABEL"..standingID).."!");
						ZoneTextString:SetTextColor(color.r, color.g, color.b);
						SubZoneTextString:SetText(name);
						SubZoneTextString:SetTextColor(color.r, color.g, color.b);
						ZoneTextFrame.startTime=GetTime();
						SubZoneTextFrame.startTime=GetTime();
						ZoneTextFrame:Show();
						SubZoneTextFrame:Show();
					end
				else
					Reputations[name] = { };
				end
				if (Reputations_Debug == 1) then
					REPUTATIONS_CHAT_FRAME:AddMessage(format("%s-Old:%f New:%f Diff:%f",name,Reputations[name].Value,barValue,barValue-Reputations[name].Value));
				end
				Reputations[name].standingID = standingID;
				Reputations[name].Value = barValue;
				Reputations[name].atWarWith = atWarWith;
			end
		end
	end
end

function ReputationMod_OnEvent()
    if(event == "UPDATE_FACTION") then
    	ReputationMod_Update();
    end
    if(event == "VARIABLES_LOADED") then
			if (Reputations_Enabled==1) then
				--Hook ReputationFrame
				if (not lOriginal_ReputationFrame_Update) then		
					lOriginal_ReputationFrame_Update=ReputationFrame_Update;
					ReputationFrame_Update=ReputationFrame_Update_New;
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_MOD_ON);
				end
			else
				--Unhook ReputationFrame
				if (lOriginal_ReputationFrame_Update) then
					ReputationFrame_Update=lOriginal_ReputationFrame_Update;
					lOriginal_ReputationFrame_Update=nil;
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_MOD_OFF);
				end
			end
			if (Reputations_Frame > 0 and Reputations_Frame <= FCF_GetNumActiveChatFrames()) then
				REPUTATIONS_CHAT_FRAME = getglobal("ChatFrame"..Reputations_Frame);
			else
				REPUTATIONS_CHAT_FRAME = DEFAULT_CHAT_FRAME;
			end
		end
end

function Reputation_Toggle(toggle) --Toggle with notification
	if (toggle) then
		Reputations_Enabled = toggle;
		if (toggle==1) then
			--Hook ReputationFrame
			if (not lOriginal_ReputationFrame_Update) then		
				DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_MOD_ON);
				lOriginal_ReputationFrame_Update=ReputationFrame_Update;
				ReputationFrame_Update=ReputationFrame_Update_New;
			end
		else
			--Unhook ReputationFrame
			if (lOriginal_ReputationFrame_Update) then
				DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_MOD_OFF);
				ReputationFrame_Update=lOriginal_ReputationFrame_Update;
				lOriginal_ReputationFrame_Update=nil;
			end
		end		
	else
		if (Reputations_Enable == 1) then
			Reputations_Enable = 0;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_MOD_OFF);
			--Unhook ReputationFrame
			if (lOriginal_ReputationFrame_Update) then
				ReputationFrame_Update=lOriginal_ReputationFrame_Update;
				lOriginal_ReputationFrame_Update=nil;
			end
		else
			Reputations_Enable = 1;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_MOD_ON);
			--Hook ReputationFrame
			if (not lOriginal_ReputationFrame_Update) then
				lOriginal_ReputationFrame_Update=ReputationFrame_Update;
				ReputationFrame_Update=ReputationFrame_Update_New;
			end
		end
	end
	if (Cosmos_UpdateValue) then
		Cosmos_UpdateValue("COS_REPUTATION_ENABLE_X",CSM_CHECKONOFF,Reputations_Enable);
	end

end

function Reputation_Cosmos_Toggle(toggle) --Toggle without notification
		Reputations_Enabled = toggle;
		if (toggle==1) then
			--Hook ReputationFrame
			if (not lOriginal_ReputationFrame_Update) then		
				lOriginal_ReputationFrame_Update=ReputationFrame_Update;
				ReputationFrame_Update=ReputationFrame_Update_New;
			end
		else
			--Unhook ReputationFrame
			if (lOriginal_ReputationFrame_Update) then
				ReputationFrame_Update=lOriginal_ReputationFrame_Update;
				lOriginal_ReputationFrame_Update=nil;
			end
		end		
end

function Reputation_Load_Toggle(toggle)
	if (toggle) then
		Reputations_Load = toggle;
		if (toggle==1) then
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_LOAD_ON);
		else
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_LOAD_OFF);
		end
	else
		if (Reputations_Raw == 1) then
			Reputations_Load = 0;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_LOAD_OFF);
		else
			Reputations_Load = 1;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_LOAD_ON);
		end
	end
	if (Cosmos_UpdateValue) then
		Cosmos_UpdateValue("COS_REPUTATION_LOADED_X",CSM_CHECKONOFF,Reputations_Load);
	end
end

function Reputation_Raw_Toggle(toggle)
	if (toggle) then
		Reputations_Raw = toggle;
		if (toggle==1) then
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_RAW_NUMS);
		else
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_PCT_NUMS);
		end
	else
		if (Reputations_Raw == 1) then
			Reputations_Raw = 0;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_PCT_NUMS);
		else
			Reputations_Raw = 1;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_RAW_NUMS);
		end
	end
	if (Cosmos_UpdateValue) then
		Cosmos_UpdateValue("COS_REPUTATION_RAW_X",CSM_CHECKONOFF,Reputations_Raw);
	end
end

function Reputation_Debug_Toggle(toggle)
	if (toggle) then
		Reputations_Debug = toggle;
		if (toggle==1) then
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_DEBUG_ON);
		end
	else
		if (Reputations_Debug == 1) then
			Reputations_Debug = 0;
		else
			Reputations_Debug = 1;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_DEBUG_ON);
		end
	end
end

function Reputation_ChatFrame_Change(checked,value)  --Checked will always be 0
	if (value) then
		if (value > 0 and value <= FCF_GetNumActiveChatFrames()) then
			Reputations_Frame = value;
			REPUTATIONS_CHAT_FRAME = getglobal("ChatFrame"..Reputations_Frame);
			REPUTATIONS_CHAT_FRAME:AddMessage(REPUTATION_MOD_FRAME,1.0,1.0,0.0);
		else
			DEFAULT_CHAT_FRAME:AddMessage(format(REPUTATION_INVALID_FRAME,value));
			DEFAULT_CHAT_FRAME:AddMessage(format(REPUTATION_VALID_FRAMES,FCF_GetNumActiveChatFrames()));
		end	
	end
end

function Reputation_Notify_Toggle(toggle)
	if (toggle) then
		Reputations_Notify = toggle;
		if (toggle==1) then
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NOTIFY_ON);
		else
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NOTIFY_OFF);
		end
	else
		if (Reputations_Notify == 1) then
			Reputations_Notify = 0;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NOTIFY_OFF);
		else
			Reputations_Notify = 1;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NOTIFY_ON);
		end
	end
	if (Cosmos_UpdateValue) then
		Cosmos_UpdateValue("COS_REPUTATION_NOTIFY_X",CSM_CHECKONOFF,Reputations_Notify);
	end
end

function Reputation_Next_Toggle(toggle)
	if (toggle) then
		Reputations_Next = toggle;
		if (toggle==1) then
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NEXT_ON);
		else
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NEXT_OFF);
		end
	else
		if (Reputations_Next == 1) then
			Reputations_Next = 0;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NEXT_OFF);
		else
			Reputations_Next = 1;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NEXT_ON);
		end
	end
	if (Cosmos_UpdateValue) then
		Cosmos_UpdateValue("COS_REPUTATION_STANDING_X",CSM_CHECKONOFF,Reputations_Next);
	end
end

function Reputation_Repeat_Toggle(toggle)
	if (toggle) then
		Reputations_Repeat = toggle;
		if (toggle==1) then
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_REPEAT_ON);
		else
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_REPEAT_OFF);
		end
	else
		if (Reputations_Repeat == 1) then
			Reputations_Repeat = 0;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_REPEAT_OFF);
		else
			Reputations_Repeat = 1;
			DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_REPEAT_ON);
		end
	end
	if (Cosmos_UpdateValue) then
		Cosmos_UpdateValue("COS_REPUTATION_REPEATING_X",CSM_CHECKONOFF,Reputations_Repeat);
	end
end

function Reputation_SlashHandler(msg)
	local index, value;
	if (not msg or msg == "") then --Show Help
		for index, value in REPUTATION_HELP_TEXT do
			DEFAULT_CHAT_FRAME:AddMessage(value);
		end
	else
		local command=strlower(msg);
		if (command == REPUTATION_LIST) then
			local numFactions = GetNumFactions();
			local factionIndex, factionStanding, factionBar, factionHeader, color;
			local name, standingID, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed;
			for factionIndex=1, numFactions, 1 do
				name, _, standingID, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed = GetFactionInfo(factionIndex);
				if (not isHeader) then
					if (Reputations_Raw==1) then
						REPUTATIONS_CHAT_FRAME:AddMessage(format(name..":%d/%d",barValue*Units[standingID],Units[standingID]));
					else
						REPUTATIONS_CHAT_FRAME:AddMessage(format(name..":%.5f%%",barValue*100));
					end
				end
			end
		elseif (command == REPUTATION_ON) then
			Reputation_Toggle(1);
		elseif (command == REPUTATION_OFF) then
			Reputation_Toggle(0);
		elseif (command == REPUTATION_LOAD) then
			Reputation_Load_Toggle();
		elseif (command == REPUTATION_STATUS) then
			DEFAULT_CHAT_FRAME:AddMessage(format(REPUTATION_VERSION..".",Reputations_Version));
			if (Reputations_Enabled==1) then
				DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_MOD_ON);
				if (Reputations_Load==1) then
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_LOAD_ON);
				else
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_LOAD_OFF);
				end
				if (Reputations_Raw==1) then
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_RAW_NUMS);
				else
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_PCT_NUMS);
				end
				DEFAULT_CHAT_FRAME:AddMessage(format(REPUTATION_SEL_FRAME,Reputations_Frame));
				if (Reputations_Notify==1) then
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NOTIFY_ON);
				else
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NOTIFY_OFF);
				end
				if (Reputations_Next==1) then
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NEXT_ON);
				else
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_NEXT_OFF);
				end
				if (Reputations_Repeat==1) then
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_REPEAT_ON);
				else
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_REPEAT_OFF);
				end
				if (Reputations_Debug==1) then
					DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_DEBUG_ON);
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage(REPUTATION_MOD_OFF);
			end
		elseif (command == REPUTATION_PCT_RAW) then
			Reputation_Raw_Toggle();
		elseif (command == REPUTATION_DEBUG) then
			Reputation_Debug_Toggle();
		elseif (strfind(command,"^"..REPUTATION_FRAME.." ")) then
			local repchannel;
			_,_,repchannel = strfind(command,"^"..REPUTATION_FRAME.."%s+(%d+)%s*$");
			if (repchannel) then
				repchannel = tonumber(repchannel);
				Reputation_ChatFrame_Change(0,repchannel);				
			else
				DEFAULT_CHAT_FRAME:AddMessage(format(REPUTATION_INVALID_FRAME,value));
				DEFAULT_CHAT_FRAME:AddMessage(format(REPUTATION_VALID_FRAMES,FCF_GetNumActiveChatFrames()));
			end
		elseif (command == REPUTATION_NOTIFY) then
			Reputation_Notify_Toggle();
		elseif (command == REPUTATION_NEXT) then
			Reputation_Next_Toggle();
		elseif (command == REPUTATION_REPEAT) then
			Reputation_Repeat_Toggle();
		else --Help
			for index, value in REPUTATION_HELP_TEXT do
				DEFAULT_CHAT_FRAME:AddMessage(value);
			end
		end
	end
end

function ReputationFrame_Update_New()
	lOriginal_ReputationFrame_Update();
	local numFactions = GetNumFactions();
	local factionOffset = FauxScrollFrame_GetOffset(ReputationListScrollFrame);
	local factionIndex, factionStanding, standingID, barValue, isHeader;

	for i=1, NUM_FACTIONS_DISPLAYED, 1 do
		factionIndex = factionOffset + i;
		if ( factionIndex <= numFactions ) then
			_, _, standingID, barValue, _, _, isHeader = GetFactionInfo(factionIndex);
			if ( not isHeader ) then
				factionStanding = getglobal("FACTION_STANDING_LABEL"..standingID);
				if (Reputations_Raw==1) then
					getglobal("ReputationBar"..i.."FactionStanding"):SetText( factionStanding.." - "..round(barValue*Units[standingID]).."/"..Units[standingID]);
				else
					getglobal("ReputationBar"..i.."FactionStanding"):SetText( format(factionStanding.."  %.2f%%", barValue*100));
				end
			end
		end
	end
end
