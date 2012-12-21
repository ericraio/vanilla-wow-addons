-- LOAD LOCALISATION
if (GetLocale()=="deDE") then
	tradeDispenser_GetGerman()
elseif (GetLocale()=="zhCN") then
	tradeDispenser_GetChinese()
elseif (GetLocale()=="frFR") then
	tradeDispenser_GetFrench()
else tradeDispenser_GetEnglish()
end


function tradeDispenserVerbose(level, text)
	local temp=0;
	if (tD_GlobalDatas.Verbose) then	temp = tD_GlobalDatas.Verbose	end
    if (temp>=level) then
		DEFAULT_CHAT_FRAME:AddMessage(tradeDispenser_ProgName..": "..text)
	end
end


function tradeDispenserMessage(channel, message)
	channel = strupper(channel)
	if (channel=="WHISPER") then
		SendChatMessage(message, "WHISPER", tD_Loc[UnitFactionGroup("player")], tD_Temp.Target.Name)
	elseif (channel=="RAID" or channel=="PARTY" or channel=="GUILD" or channel=="YELL" or channel=="SAY") then
		SendChatMessage(message, channel);
	else
		tradeDispenserVerbose(0,"Error: cannot use channel '"..channel.."'") 
	end
end


function tradeDispenserPlaySound(frame)
	if (frame:GetFrameType()=="Button") then
		PlaySound("GAMEGENERICBUTTONPRESS")
	elseif (frame:GetFrameType()=="CheckButton") then
		if ( frame:GetChecked() ) then
			PlaySound("igMainMenuOptionCheckBoxOn");
		else
			PlaySound("igMainMenuOptionCheckBoxOff");
		end
	end
end



function tradeDispenserDrawTooltip(textfield)
	local i=0;
	GameTooltip:AddLine("|cFFFFFFFF"..textfield[i]);
	for i=1,table.getn(textfield) do
		GameTooltip:AddLine(textfield[i]);
	end						
	GameTooltip:Show();	
end

function tradeDispenserSetTooltipPosition(frame,mx,my)
	local lx,ly = frame:GetCenter();
	local px, py = UIParent:GetCenter();
	local pos, korrX, korrY = "ANCHOR_",1,1;
	if (ly>py) then pos=pos.."BOTTOM";             else  korrY=-1; 			end
	if (lx>px) then pos=pos.."LEFT";   korrX=-1;   else  pos=pos.."RIGHT";	end
	GameTooltip:SetOwner(frame,pos,mx*korrX,my*korrY);	
end


function tradeDispenser_Print(textfield)
	table.foreach(textfield, function(k,v) DEFAULT_CHAT_FRAME:AddMessage(v) end)
end

-- Hooked Function to check, if the PLAYER or the CLIENT has initiated the trade!
-- this is triggered BEFORE the event TradeShow gets fired
local OldInitiateTrade = InitiateTrade;
function InitiateTrade(UnitID)
	tradeDispenserVerbose(1,"Trade Started - triggered by hooked Function: InitiateTrade");
	tD_Temp.InitiateTrade=true;
	OldInitiateTrade(UnitID)
end

local OldBeginTrade = BeginTrade;
function BeginTrade()
	tradeDispenserVerbose(1,"Trade Started - triggered by hooked Function: BeginTrade");
	tD_Temp.InitiateTrade=true;
	OldBeginTrade()
end


function tradeDispenserUpdateMoney()
	tD_CharDatas.profile[tD_CharDatas.ActualRack][tD_CharDatas.ActualProfile].Charge = MoneyInputFrame_GetCopper(tradeDispenserMoneyFrame)
end


function tradeDispenserSplitMoney(money)
	local gold = floor(money / (COPPER_PER_GOLD))
	local silver = floor((money - (gold * COPPER_PER_GOLD)) / COPPER_PER_SILVER)
	local copper = mod(money, COPPER_PER_SILVER)
	return gold, silver, copper
end



function tradeDispenserCompile(slotID)
	if (tD_Temp.Slot[slotID].itemLink == nil) then
		return "deadlink",nil
	end
	
	local configItemLink = tD_Temp.Slot[slotID].itemLink
	local configItemCount = tD_Temp.Slot[slotID].itemCount
	
	if (configItemLink) then tradeDispenserVerbose(1,"tradeDispenserCompile: looking for: "..configItemLink) end
	tradeDispenserVerbose(2,"tradeDispenserCompile: first round")

	-- first we look for complete stacks
	for cID=4,0,-1 do
		tradeDispenserVerbose(3,"tradeDispenserCompile: "..GetContainerNumSlots(cID).." slots in bag "..cID)
		for sID=1,GetContainerNumSlots(cID) do
			local itemLink = GetContainerItemLink(cID, sID)
			local _, itemCount, itemLocked = GetContainerItemInfo(cID, sID)

			if (tradeDispenserLink(itemLink) == tradeDispenserLink(configItemLink) and not itemLocked) then
				if (itemCount) then tradeDispenserVerbose(2,"tradeDispenserCompile: found item: itemCount: "..itemCount) end
				if (itemCount == configItemCount) then
					tradeDispenserVerbose(3,"tradeDispenserCompile: found in first round in "..cID.."/"..sID)
					return cID, sID
				end
			end
		end
	end
	
	-- there is no complete stack, we have to compile one
	-- first we have to find a free bag slot
	local _cID, _sID = tradeDispenserFreeSlot()
	if (_cID == nil) then
		tradeDispenserVerbose(2,"tradeDispenserCompile: no free slots")
		return nil, nil
	end
	
	tradeDispenserVerbose(2,"tradeDispenserCompile: second round, tmp slot is :".._cID.."/".._sID)
	
	local stackCount = 0
	local stackFound = false
	for cID=4,0,-1 do
		for sID=1,GetContainerNumSlots(cID) do
			if (cID ~= _cID or sID ~= _sID) then
				local itemLink = GetContainerItemLink(cID, sID)
				local _, itemCount, itemLocked = GetContainerItemInfo(cID, sID)
			
				if (tradeDispenserLink(itemLink) == tradeDispenserLink(configItemLink) and not itemLocked) then
					stackFound = true
					local missingCount = configItemCount - stackCount
					local splitCount = math.min(missingCount, itemCount)
					tradeDispenserVerbose(3,"tradeDispenserCompile: second round found item: missingCount: "..missingCount..", itemCount: "..itemCount)
					SplitContainerItem(cID, sID, splitCount)
					PickupContainerItem(_cID, _sID)
					
					stackCount = stackCount + splitCount
					tradeDispenserVerbose(3,"tradeDispenserCompile: added "..splitCount.." items to temp stack, now we have "..stackCount)
				
					-- if we have compiled the stack... return
					if (stackCount == configItemCount) then
						tradeDispenserVerbose(2,"tradeDispenserCompile: finished second round")
						return _cID, _sID
					end
				end
			end	
		end
	end
	
	if (stackFound) then
		tradeDispenserVerbose(1,"tradeDispenserCompile: returning temp stack")
		return _cID, _sID
	else
		tradeDispenserVerbose(1,"tradeDispenserCompile: nothing found")
		return nil
	end
end




function tradeDispenserTradeControlChecker()
	local tradeDispenserClient = {};	-- used for saving the stats (guild, party, raid) of the Client;
	local targetClass, targetEnglishClass = UnitClass("NPC");
	tradeDispenserClient = {
		["Class"] 	= targetEnglishClass,
		["Level"] 	= UnitLevel("NPC"),
		["Name"] 	= UnitName("NPC")
	}
	if (UnitInRaid("player")) then
		if (UnitInRaid("NPC")) then			tradeDispenserClient.Raid = "IsMember";
		else								tradeDispenserClient.Raid = "NotMember";			end
	else 									
		if (UnitInParty("player")) then
			if (UnitInParty("NPC")) then	tradeDispenserClient.Raid = "IsMember";
			else							tradeDispenserClient.Raid = "NotMember";			end
		else 								tradeDispenserClient.Raid = "SinglePlayer"; 		end
	end
			
	local guildName,  guildRankName,  guildRankIndex = GetGuildInfo("player");
	local guildName2, guildRankName2, guildRankIndex2 = GetGuildInfo("NPC");
		
	if (guildName==guildName2) then
		 tradeDispenserClient.Guild = "IsMember";
	else tradeDispenserClient.Guild = "NotMember"; end
	
	if (tradeDispenserClient.Raid=="IsMember" or tradeDispenserClient.Guild=="IsMember") then tD_Temp.isInsider=true; end
	
	if (tD_CharDatas.ClientInfos) then
		local guildName3 = "";
		if (guildName2~=nil) then guildName3 = "<"..guildName2.."> ";	end
		if (not targetClass) then targetClass="Unknown" end
		DEFAULT_CHAT_FRAME:AddMessage(tD_Loc.Opposite.." "..tradeDispenserClient.Name.." "..guildName3.." -  "..targetClass.." Level "..tradeDispenserClient.Level,1,1,0);
	else
		tradeDispenserVerbose(1,"Clients Name = "..tradeDispenserClient.Name);
		tradeDispenserVerbose(1,"Clients Level = "..tradeDispenserClient.Level);
		tradeDispenserVerbose(1,"Clients Class = "..tradeDispenserClient.Class);
		tradeDispenserVerbose(1,"Group/Party = "..tradeDispenserClient.Raid);
		tradeDispenserVerbose(1,"your Guild = "..tradeDispenserClient.Guild);
	end
	
	if (tD_CharDatas.Raid and tradeDispenserClient.Raid=="NotMember") then 
		if (tD_CharDatas.Guild) then
			if (tradeDispenserClient.Guild=="NotMember") then
				tradeDispenserMessage("WHISPER",tD_GlobalDatas.whisper[8])
				return false;
			end
		else
			tradeDispenserMessage("WHISPER",tD_GlobalDatas.whisper[8])
			return false;
		end
	end
	
	if (tD_CharDatas.LevelCheck and tradeDispenserClient.Level<tD_CharDatas.LevelValue) then 
		tradeDispenserMessage("WHISPER",tD_GlobalDatas.whisper[6])
		return false; 
	end
	

	local trades=tradeDispenserClientTrades(tradeDispenserClient.Name);
	if (trades>=1 and trades+1>tD_CharDatas.RegisterValue) then 
		tradeDispenserMessage("WHISPER",tD_GlobalDatas.whisper[9])
		return false
	end
	
	if (tD_CharDatas.BanlistActive and tD_GlobalDatas.Bannlist and table.getn(tD_GlobalDatas.Bannlist)>0) then
		local found=false;
		table.foreach(tD_GlobalDatas.Bannlist, function(k,v) if (strlower(v)==strlower(tradeDispenserClient.Name)) then	found=true;	end; end)
		if (found) then
			tradeDispenserMessage("WHISPER",tD_GlobalDatas.whisper[10])
			return false;
		end
	end
	
	return true;
end



function tradeDispenserClientTrades(name)
	if (not tD_CharDatas.RegisterCheck) then return 0  end
	local i=0
	local index=nil;
	while (tD_Temp.RegUser[i]~=nil) do
		if (tD_Temp.RegUser[i].name == name) then
			tradeDispenserVerbose(2,"Registred Player found at index "..i.." is: "..tD_Temp.RegUser[i].name);
			index=i;
		end
		i=i+1;
	end
	
	if (index==nil) then 
		tradeDispenserVerbose(1,name.." not registrated!");
		return 0
	else	
		tradeDispenserVerbose(1,name.." found with "..tD_Temp.RegUser[index].trades.." trades");	
		return tD_Temp.RegUser[index].trades
	end
end




function tradeDispenserAccept()
	tradeDispenserVerbose(1,"tradeDispenserAccept: Triggered")
	if (tD_Temp.tradeCharge and tD_Temp.tradeCharge > 0) then
		local recipientMoney = GetTargetTradeMoney()
		if (recipientMoney >= tD_Temp.tradeCharge) then
			tD_Temp.tradeState = nil
			AcceptTrade()
			
			if (tD_Temp.tradeData) then
				tD_Temp.tradeData = nil
				tD_Temp.isEnabled = false
				tradeDispenserUpdate()
				tradeDispenser_OSD_buttons()
			end
		else
			local gold, silver, copper = tradeDispenserSplitMoney(tD_Temp.tradeCharge)
			tradeDispenserMessage("WHISPER",tD_GlobalDatas.whisper[5].." "..gold.."g "..silver.."s "..copper.."c")
		end
	else
		tD_Temp.tradeState = nil
		AcceptTrade()
		
		if (tD_Temp.tradeData) then
			tD_Temp.tradeData = nil
			tD_Temp.isEnabled = false
			tradeDispenserUpdate()
			tradeDispenser_OSD_buttons()
		end
	end
end


function tradeDispenserFreeSlot()
	for cID=0,4 do
		for sID=1,GetContainerNumSlots(cID) do
			local itemLink = GetContainerItemLink(cID, sID)
			if (itemLink == nil) then
				return cID, sID
			end
		end
	end
	return nil
end

function tradeDispenserLink(itemLink)
	if (itemLink) then
		local _, _, itemID, itemEnchant, randomProperty, uniqueID, itemName = string.find(itemLink, "|Hitem:(%d+):(%d+):(%d+):(%d+)|h[[]([^]]+)[]]|h")
		return tonumber(itemID or 0), tonumber(randomProperty or 0), tonumber(itemEnchant or 0), tonumber(uniqueID or 0), itemName
	else
		return nil
	end
end



function tradeDispenserCompileProfile()
	if (not tD_Temp.Target.Name) then return false end
	local actualID=1;
	local i;
	tD_Temp.tradeCharge = 0;
	local getprofile = {
		["WARRIOR"] = {	[1]=2, [2]=10},
		["ROGUE"]	= { [1]=3, [2]=10},
		["HUNTER"]	= { [1]=4, [2]=11},
		["WARLOCK"]	= { [1]=5, [2]=11},
		["MAGE"]	= { [1]=6, [2]=11},
		["DRUID"]	= { [1]=7, [2]=12},
		["PRIEST"]	= { [1]=8, [2]=12},
		["PALADIN"] = { [1]=9, [2]=12},
		["SHAMAN"]  = { [1]=9, [2]=12}
	};
	tD_Temp.Slot={
		[1]={}, [2]={}, [3]={}, [4]={}, [5]={}, [6]={} 
	};

	tD_Temp.Target.EnglishClass = strupper(tD_Temp.Target.EnglishClass);
	tradeDispenserVerbose(1,"Compile the TradeProfiles: All Classes + "..tD_Temp.Target.EnglishClass.." + "..tD_Loc.profile[ getprofile[tD_Temp.Target.EnglishClass][2] ]);
	
	tD_Temp.tradeCharge = tD_CharDatas.profile[tD_CharDatas.ActualRack][1].Charge;	
	for slotID=1,6 do
		if (tD_CharDatas.profile[tD_CharDatas.ActualRack][1][slotID] and tD_CharDatas.profile[tD_CharDatas.ActualRack][1][slotID].itemName) then
			tD_Temp.Slot[actualID] = tD_CharDatas.profile[tD_CharDatas.ActualRack][1][slotID];
			actualID=actualID+1;
		end
	end
	
	local act=getprofile[tD_Temp.Target.EnglishClass][1];
	tradeDispenserVerbose(2, "looking in Profile "..act.." for items")
	tD_Temp.tradeCharge = tD_Temp.tradeCharge + tD_CharDatas.profile[tD_CharDatas.ActualRack][act].Charge;
	for slotID=1,6 do
		if (actualID<=6) then	
			local profile = tD_CharDatas.profile[tD_CharDatas.ActualRack][act][slotID]
			if ( profile and profile.itemName) then
				tD_Temp.Slot[actualID] = profile;
				actualID=actualID+1;
			end
		end
	end
	
	local act=getprofile[tD_Temp.Target.EnglishClass][2];
	tradeDispenserVerbose(2, "looking in Profile "..act.." for items")
	
	tD_Temp.tradeCharge = tD_Temp.tradeCharge + tD_CharDatas.profile[tD_CharDatas.ActualRack][act].Charge;
	for slotID=1,6 do
		if (actualID<=6) then
			local profile = tD_CharDatas.profile[tD_CharDatas.ActualRack][act][slotID];
			if (profile and profile.itemName) then
				tD_Temp.Slot[actualID] = profile;
				actualID=actualID+1;
			end
		end
	end	
	
	if (tD_CharDatas.Free4Guild and tD_Temp.isInsider) then tD_Temp.tradeCharge=0 end;
	actualID=actualID-1;
	tradeDispenserVerbose(1,"Found "..actualID.." items to trade");
	return actualID;
end
