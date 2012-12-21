
function tradeDispenserOnLoad()
	--math.randomseed(floor(GetTime()));			-- initialize the randomizer
	tradeDispenser:RegisterEvent("VARIABLES_LOADED")
	tradeDispenser:RegisterEvent("TRADE_SHOW")			-- used to activate the automated trade
	tD_Temp.timeSlice = 0
	tD_Temp.broadcastSlice = 0
	tD_Temp.Target = {
		["Name"]=nil,
		["EnglishClass"]=nil,
		["Class"]=nil,
		["Level"]=nil,
	};		
end


function tradeDispenser_Eventhandler()
	if (tD_Temp.isEnabled) then
		tradeDispenserVerbose(1,"Gonna activate some events");
		--tradeDispenser:RegisterEvent("TRADE_SHOW")			-- used to activate the automated trade
		tradeDispenser:RegisterEvent("TRADE_CLOSED")
		tradeDispenser:RegisterEvent("TRADE_ACCEPT_UPDATE")   -- used, if the opposite player changes the items -> re-accept
		tradeDispenser:RegisterEvent("UI_ERROR_MESSAGE")
		tradeDispenser:RegisterEvent("UI_INFO_MESSAGE")
		tD_Temp.InitiateTrade=nil;
		tD_Temp.Countdown=-1;		
	else
		tradeDispenserVerbose(1,"Gonna deactivate some events");
		--tradeDispenser:UnregisterEvent("TRADE_SHOW")			-- used to activate the automated trade
		tradeDispenser:UnregisterEvent("TRADE_CLOSED")
		tradeDispenser:UnregisterEvent("TRADE_ACCEPT_UPDATE")   -- used, if the opposite player changes the items -> re-accept
		tradeDispenser:UnregisterEvent("UI_ERROR_MESSAGE")
		tradeDispenser:UnregisterEvent("UI_INFO_MESSAGE")
		tradeDispenser:UnregisterEvent("PLAYER_TARGET_CHANGED")
	end
	tradeDispenserVerbose(2,"TRADE_SHOW, TRADE_CLOSED, TRADE_ACCEPT_UPDATE, UI_ERROR_MESSAGE, UI_INFO_MESSAGE");
end


function tradeDispenserSetFaction() 
	--tradeDispenserVerbose(0,"Players Faction is: "..UnitFactionGroup("player"));
	if (tradeDispenserProfileDDframe) then
		tradeDispenserProfileDDframeSub9:SetText(tD_Loc.profile[UnitFactionGroup("player")]);
	end
	if (tD_CharDatas.ActualProfile==9) then
		tradeDispenserProfileDDTitleLbL:SetText(tD_Loc.profile[UnitFactionGroup("player")]);
	end
	
end



function tradeDispenserOnEvent(event)
	if (event == "VARIABLES_LOADED") then
		tradeDispenserVerbose(0,tD_Loc.logon.welcome);
		tradeDispenser_OnVariablesLoaded()			-- found in tradeDispenser_initialize
	end
	if (event == "PLAYER_TARGET_CHANGED") then
		if (UnitIsPlayer("target") and UnitIsFriend("target", "player")) then
			tradeDispenserBanlistName:SetText(UnitName("target"));
		end
	end
	
	if (event=="TRADE_SHOW" and (tD_Temp.isEnabled or tD_CharDatas.ClientInfos) and WorldMapFrame:IsVisible()) then
		ToggleWorldMap();
		tradeDispenserVerbose(1, " Closed the Map to avoid bugs. Sorry");
	end
		
	if (event == "TRADE_SHOW" and (not tD_Temp.isEnabled) and tD_CharDatas.ClientInfos) then
		local targetClass, targetEnglishClass = UnitClass("NPC");
		local guildName2, guildRankName2, guildRankIndex2 = GetGuildInfo("NPC");		
		local guildName3 = "";
		if (guildName2~=nil) then guildName3 = "<"..guildName2.."> ";	end		
		DEFAULT_CHAT_FRAME:AddMessage(tD_Loc.Opposite.." "..UnitName("NPC").." "..guildName3.." -  "..targetClass.." Level "..UnitLevel("NPC"),1,1,0);
	end
	
	
	if (not tD_Temp.isEnabled) then
		return
	end
	
	if ((event=="UI_ERROR_MESSAGE" or event=="UI_INFO_MESSAGE") and tD_Temp.Target.Name and arg1) then
		if (strfind(arg1,tD_Loc.UImessages.cancelled)~=nil or strfind(arg1,tD_Loc.UImessages.failed)~=nil) then
			tradeDispenserVerbose(2,arg1);
			tD_Temp.Target.Name=nil;
		end
		if (strfind(arg1,tD_Loc.UImessages.complete)~=nil) then
			tradeDispenserVerbose(2,arg1);
			tradeDispenserVerbose(1,"Gonna Registrate the Player "..tD_Temp.Target.Name);
			tradeDispenserAddClient(tD_Temp.Target.Name);
		end
	end


	if (event == "TRADE_SHOW" and tD_Temp.isEnabled and tD_Temp.InitiateTrade==nil) then
		if (CursorHasItem()) then   PutItemInBackpack()  end	-- if the player's got an item on the cursor, tD's not running correctly
		if (UnitAffectingCombat("Player")==nil) then TargetUnit("NPC") end	-- target player, if you're not in combat
		tD_Temp.Target = {};
		tD_Temp.Target.Name 	= UnitName("NPC");
		tD_Temp.Target.Level	= UnitLevel("NPC");
		tD_Temp.Target.Class, tD_Temp.Target.EnglishClass = UnitClass("NPC");
		
		if (not tradeDispenserTradeControlChecker()) then
			tD_Temp.Target.Name=nil;
			CloseTrade();
		else
			local itemsToTrade = tradeDispenserCompileProfile();
			if (itemsToTrade) then
				if (itemsToTrade==0) then		-- no items to trade - tradeDispenser should be inactive
					tradeDispenserVerbose(0,tD_Loc.noItemsToTrade);
					tD_Temp.Target.Name=nil;
				else
					tD_Temp.timeSlice = 0
					tD_Temp.tradeState = "populate"
					tD_Temp.tradeData = {}
					tD_Temp.tradeData.slotID = 1
					tD_Temp.tradeData.numAttempts = 0
					tD_Temp.tradeData.containerLocation = nil
				end
			end
		end
	end
	if (event == "TRADE_ACCEPT_UPDATE") then
		tradeDispenserVerbose(1,"TRADE_ACCEPT_UPDATE: Player="..arg1.." - Target="..arg2);
		if (arg1==0 and arg2==1 and tD_CharDatas.AutoAccept) then 
			tradeDispenserAccept()
		end
		if (arg1==1 and arg2==0 and tD_CharDatas.TimelimitCheck) then
			tradeDispenserStartTimelimiter()
		end
	end
	if (event == "TRADE_CLOSED") then
		tD_Temp.tradeState = nil
		tD_Temp.tradeData = nil
		tD_Temp.InitiateTrade=nil;
		tD_Temp.Countdown=-1;
		tradeDispenserVerbose(1,"Trade Closed")

		--if (UnitIsPlayer("target")) then TargetLastEnemy() end
	end
end


function tradeDispenserAddClient(name)
	if (not name) then return end
	
	local i=0
	local index=nil;
	while (tD_Temp.RegUser[i]~=nil) do
		tradeDispenserVerbose(3,"Registred Player at index "..i.." is: "..tD_Temp.RegUser[i].name);
		if (tD_Temp.RegUser[i].name == name) then
			tradeDispenserVerbose(2,name.." found in the List at position "..i);
			index=i;
		end
		i=i+1;
	end
	
	if (index==nil) then
		tradeDispenserVerbose(2,name.." was unregistred!  New Registration-Index is: "..i);
		tD_Temp.RegUser[i]= {
			["name"] = name,  	["trades"] = 1
		}
	else
		tD_Temp.RegUser[index].trades = tD_Temp.RegUser[index].trades+1;
	end
end



function tradeDispenserClick(slotID)
	MoneyInputFrame_ClearFocus(tradeDispenserMoneyFrame)
		
	ClickTradeButton(slotID)
	local itemName, itemTexture, itemCount = GetTradePlayerItemInfo(slotID)
	local itemLink = GetTradePlayerItemLink(slotID)

	if ( itemName ) then
		ClickTradeButton(slotID)
		local i=tD_CharDatas.ActualProfile;		
		tD_CharDatas.profile[tD_CharDatas.ActualRack][i][slotID] = {}
		tD_CharDatas.profile[tD_CharDatas.ActualRack][i][slotID].itemLink = itemLink
		tD_CharDatas.profile[tD_CharDatas.ActualRack][i][slotID].itemName = itemName
		tD_CharDatas.profile[tD_CharDatas.ActualRack][i][slotID].itemTexture = itemTexture
		tD_CharDatas.profile[tD_CharDatas.ActualRack][i][slotID].itemCount = itemCount
	else
		tD_CharDatas.profile[tD_CharDatas.ActualRack][tD_CharDatas.ActualProfile][slotID]=nil
	end
	tradeDispenserVerbose(2, "Recieved Item on Slot "..slotID);
	tradeDispenserUpdate()
end


function tradeDispenserUpdate()
	local ActPro=tD_CharDatas.ActualProfile;

	MoneyInputFrame_ClearFocus(tradeDispenserMoneyFrame)
	if (tradeDispenserProfileDDframe) then tradeDispenserProfileDDframe:Hide(); end
	if (tradeDispenserRackDDframe) then tradeDispenserRackDDframe:Hide(); end
	
	
	if (tradeDispenserSettingsChannelDDframe) then tradeDispenserSettingsChannelDDframe:Hide(); end
	for slotID=1,6 do
		local buttonText = getglobal("tradeDispenserItem"..slotID.."Name")
		local itemButton = getglobal("tradeDispenserItem"..slotID.."ItemButton")
		
		if ( tD_CharDatas.profile and tD_CharDatas.profile[tD_CharDatas.ActualRack] and 
			 tD_CharDatas.profile[tD_CharDatas.ActualRack][ActPro] and
		     tD_CharDatas.profile[tD_CharDatas.ActualRack][ActPro][slotID] and 
			 tD_CharDatas.profile[tD_CharDatas.ActualRack][ActPro][slotID].itemName ) then
			local temp = tD_CharDatas.profile[tD_CharDatas.ActualRack][ActPro][slotID];
			tradeDispenserVerbose(3,"tradeDispenserUpdate: slotID '"..slotID.."' is used")
			buttonText:SetText(temp.itemName)
			SetItemButtonTexture(itemButton, temp.itemTexture)
			SetItemButtonCount(itemButton, temp.itemCount)
		else
			tradeDispenserVerbose(3,"tradeDispenserUpdate: slotID '"..slotID.."' is free")
			buttonText:SetText("")
			SetItemButtonTexture(itemButton, nil)
			SetItemButtonCount(itemButton, nil)
		end
	end
	
	if (tD_Temp.isVisible) then	tradeDispenser:Show()  
	else
		if (tradeDispenserTradeControl) then
			tradeDispenser:Hide()	
			if (not tradeDispenserMessages:IsShown()) then
				tradeDispenserSettings:Hide();
				tradeDispenserTradeControl:Hide()
				tradeDispenserSettingsBtn:UnlockHighlight();
				tradeDispenserTradeControlBtn:UnlockHighlight();
			end
		end
	end
	
	if (tD_Temp.isEnabled) then	
		tradeDispenserState:SetText(tD_Loc.buttons.enabled)
		tradeDispenserState:LockHighlight();
	else	
		tradeDispenserState:SetText(tD_Loc.buttons.disabled)
		tradeDispenserState:UnlockHighlight();
	end
		
	if (tD_CharDatas.broadcastSlice) then
		if (tD_CharDatas.broadcastSlice < 0) then
			tD_CharDatas.broadcastSlice = 0
		elseif (tD_CharDatas.broadcastSlice > tradeDispenser_MaxBroadcastLength*60) then
			tD_CharDatas.broadcastSlice = tradeDispenser_MaxBroadcastLength*60
		end
	else
		tD_CharDatas.broadcastSlice = math.floor(tradeDispenser_MaxBroadcastLength/2)
	end
	
	if (tD_CharDatas.AutoBroadcast) then
		tradeDispenserSettingsBroadcastTimer:Show();
		tradeDispenserSettingsBroadcastCheck:SetChecked(1);
	else
		tradeDispenserSettingsBroadcastTimer:Hide();
		tradeDispenserSettingsBroadcastCheck:SetChecked(0);
	end
	
	local tmp = tD_CharDatas.ActualProfile;
	if (tD_CharDatas.profile and tD_CharDatas.profile[tD_CharDatas.ActualRack] and tmp and tD_CharDatas.profile[tD_CharDatas.ActualRack][tmp].Charge) then
		MoneyInputFrame_SetCopper(tradeDispenserMoneyFrame, tD_CharDatas.profile[tD_CharDatas.ActualRack][tmp].Charge)
	end
	
	local s = 1
	if (tD_CharDatas.ActualRack) then
		s = tradeDispenserRackColor[tD_CharDatas.ActualRack]
	end
	local r,g,b = 0.8,0.8,0.8;
	if (tD_Temp.isEnabled) then
		r=s.r; g=s.g; b=s.b;
	end
			
	tradeDispenserBkg1:SetVertexColor(r,g,b,1);
	tradeDispenserBkg2:SetVertexColor(r,g,b,1);
	tradeDispenserBkg3:SetVertexColor(r,g,b,1);
end


function tradeDispenser_ResetFrames()
	tradeDispenser:ClearAllPoints()
	tradeDispenser:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
	tradeDispenserMessages:ClearAllPoints()
	tradeDispenserMessages:SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
	tradeDispenserOSD:ClearAllPoints()
	tradeDispenserOSD:SetPoint("LEFT", "UIParent", "LEFT", 15, 0)
	tradeDispenserVerbose(0,tD_Loc.resetframes)
end



SLASH_TRADE_DISPENSER1 = "/tradeDispenser"
SLASH_TRADE_DISPENSER2 = "/td"
SlashCmdList["TRADE_DISPENSER"] = function(msg)	
	tradeDispenser_SlashCommand(msg)
end


function tradeDispenser_SlashCommand(msg)
	if (not msg) then tradeDispenser_Print(tD_Loc.help) 
	else
		local command=string.lower(msg);
		if (command=="config") then
			tD_Temp.isVisible = not tD_Temp.isVisible;
			tradeDispenserMessages:Hide();
			tradeDispenserUpdate();
			tradeDispenserOSD_OnUpdate();
		elseif (command=="toggle") then
			tD_Temp.isEnabled = not tD_Temp.isEnabled;
			if (tD_Temp.isEnabled) then
				DEFAULT_CHAT_FRAME:AddMessage(tD_Loc.activated)
			else
				DEFAULT_CHAT_FRAME:AddMessage(tD_Loc.deactivated)
			end
			tradeDispenser_Eventhandler();
			tradeDispenserUpdate();
			tradeDispenserOSD_OnUpdate();
		elseif (command=="broadcast") then
			if (tD_Temp.isEnabled) then
				tradeDispenserBroadcastItems()
			else
				DEFAULT_CHAT_FRAME:AddMessage(tD_Loc.OSD.notenabled)
			end
		elseif (command=="osd") then
			tD_CharDatas.OSD.isEnabled = not tD_CharDatas.OSD.isEnabled;
			tradeDispenserUpdate();
			tradeDispenserSettings_OnUpdate();
			tradeDispenserOSD_OnUpdate();
		elseif (command=="about") then tradeDispenser_Print(tD_Loc.about)
		elseif (command=="resetpos") then tradeDispenser_ResetFrames()
		elseif (string.sub(command, 1,7)=="verbose") then
			local temp=tonumber(string.sub(command, 8,10));
			if (not temp) then
				tradeDispenserVerbose(0, tD_Loc.verbose.isset..tD_GlobalDatas.Verbose);
			else 
				tD_GlobalDatas.Verbose=temp;
				tradeDispenserVerbose(0,tD_Loc.verbose.setto..tD_GlobalDatas.Verbose);
			end
		else 	tradeDispenser_Print(tD_Loc.help);
		end		-- no correct command was found
	end
end
