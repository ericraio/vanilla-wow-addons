-- Advanced Trade Skill Window v0.4.0
-- copyright 2006 by Rene Schneider (Slarti on EU-Blackhand)

-- main script file

ATSW_TRADE_SKILLS_DISPLAYED = 23;
ATSW_MAX_TRADE_SKILL_REAGENTS = 8;
ATSW_TRADE_SKILL_HEIGHT = 16;
ATSW_MAX_DELAY = 4.0;
ATSW_MAX_RETRIES = 5;

ATSWTypeColor = { };
ATSWTypeColor["optimal"] = { r = 1.00, g = 0.50, b = 0.25 };
ATSWTypeColor["medium"]	= { r = 1.00, g = 1.00, b = 0.00 };
ATSWTypeColor["easy"] = { r = 0.25, g = 0.75, b = 0.25 };
ATSWTypeColor["trivial"] = { r = 0.50, g = 0.50, b = 0.50 };
ATSWTypeColor["header"]	= { r = 1.00, g = 0.82, b = 0 };

ATSWRarityColor={};
ATSWRarityColor[5] = { r = 0.64, g = 0.21, b = 0.93 };
ATSWRarityColor[4] = { r = 0, g = 0.44, b = 0.87 };
ATSWRarityColor[3] = { r = 0.12, g = 1, b = 0 };
ATSWRarityColor[2] = { r = 1, g = 1, b = 1 };
ATSWRarityColor[1] = { r = 0.62, g = 0.62, b = 0.62 };

ATSWRarityNames={};
ATSWRarityNames["purple"]=5;
ATSWRarityNames["blue"]=4;
ATSWRarityNames["green"]=3;
ATSWRarityNames["white"]=2;
ATSWRarityNames["grey"]=1;


atsw_tradeskilllist={};
atsw_tradeskillheaders={};
atsw_skilllisting={};
atsw_tradeskillcounter={};
atsw_selectedskill="";
atsw_displayedgroup="";
atsw_retries=0;
atsw_retrydelay=0;
atsw_retry=false;
atsw_delay=0;
atsw_working=false;
atsw_processingtimeout=0;
atsw_scans=0;
atsw_updatedelay=0;
atsw_uncategorizedexpanded=true;
atsw_tradeskillid={};
atsw_orderby={};
atsw_updating=false;
atsw_incombat=false;
atsw_bankopened=false;
atsw_oldmode=false;
atsw_disabled={};

function ATSW_OnLoad()
	SLASH_ATSW1 = "/atsw";
	SlashCmdList["ATSW"] = ATSW_Command;
	ATSWFrame:RegisterEvent("TRADE_SKILL_UPDATE");
	ATSWFrame:RegisterEvent("TRADE_SKILL_CLOSE");
	ATSWFrame:RegisterEvent("TRADE_SKILL_SHOW");
	ATSWFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	ATSWFrame:RegisterEvent("UPDATE_TRADESKILL_RECAST");
	ATSWFrame:RegisterEvent("BANKFRAME_OPENED");
	ATSWFrame:RegisterEvent("BANKFRAME_CLOSED");
	ATSWFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	ATSWFrame:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED");
	ATSWFrame:RegisterEvent("MERCHANT_SHOW");
	ATSWFrame:RegisterEvent("MERCHANT_UPDATE");
	ATSWFrame:RegisterEvent("MERCHANT_CLOSED");
	ATSWFrame:RegisterEvent("BAG_UPDATE");
	ATSWFrame:RegisterEvent("TRAINER_CLOSED");
	ATSWFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
	ATSWFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
	ATSWFrame:RegisterEvent("AUCTION_HOUSE_CLOSED");
	ATSWFrame:RegisterEvent("AUCTION_HOUSE_SHOW");
	ATSWFrame:RegisterEvent("CRAFT_SHOW");
	ATSWFrame:RegisterEvent("CRAFT_CLOSE");
end

function ATSW_ShowWindow()
	if(type(atsw_orderby)~="table") then atsw_orderby={}; end
	if(not atsw_orderby[UnitName("player")]) then atsw_orderby[UnitName("player")]={}; end
	if(not atsw_orderby[UnitName("player")][atsw_selectedskill]) then atsw_orderby[UnitName("player")][atsw_selectedskill]="nothing"; end
	if(atsw_oldmode and atsw_orderby[UnitName("player")][atsw_selectedskill]=="nothing") then 
		atsw_orderby[UnitName("player")][atsw_selectedskill]="name";
	end
	atsw_oldtradeskillcount=0;
	ShowUIPanel(ATSWCheckerFrame);
	SetPortraitTexture(ATSWFramePortrait, "player");
	if(not atsw_oldmode) then
		ExpandTradeSkillSubClass(0);
		if(ATSW_GetTradeSkillSelectionIndex()>1) then
			ATSWFrame_SetSelection(ATSW_GetTradeSkillSelectionIndex());
		else
			if(ATSW_GetNumTradeSkills()>0) then
				ATSWFrame_SetSelection(ATSW_GetFirstTradeSkill());
				FauxScrollFrame_SetOffset(ATSWListScrollFrame, 0);
			end
			ATSWListScrollFrameScrollBar:SetValue(0);
		end
	end
	ATSWFrameTitleText:SetText(format(TEXT(TRADE_SKILL_TITLE), ATSW_GetTradeSkillLine()).." - "..ATSW_VERSION);
	ATSW_AdjustFrame();
	ATSW_ResetPossibleItemCounts();
	ATSW_CreateTradeSkillList();
	ATSW_CreateSkillListing();
	ATSWInv_UpdateItemList();
	ShowUIPanel(ATSWFrame);
	ATSWFrame_UpdateQueue();
	ATSWInv_UpdateQueuedItemList();
	ATSWFrame_Update();
	ATSWInputBox:SetText("1");
	atsw_updatedelay=0.5;
end

function ATSW_HideWindow()
	HideUIPanel(ATSWFrame);
end

function ATSW_GetSelectedSkill()
	atsw_selectedskill=ATSW_GetTradeSkillLine();
	if(not atsw_disabled[UnitName("player")]) then
		atsw_disabled[UnitName("player")]={};
	end
	if(not atsw_disabled[UnitName("player")][atsw_selectedskill]) then
		atsw_disabled[UnitName("player")][atsw_selectedskill]=0;
	end
end

function ATSW_CheckForRescan()
	atsw_scans=0;
	skillname=ATSW_GetTradeSkillLine();
	if(skillname) then
		if(skillname~=atsw_displayedgroup) then
			atsw_displayedgroup=skillname;
			atsw_selectedskill=skillname;
			ATSW_DeleteQueue();
			ATSW_CreateTradeSkillList();
			ATSW_NoteNecessaryItemsForQueue();
		end
	end
end

function ATSW_OnHide()
	if(not atsw_oldmode) then 
		TradeSkillFrame_Hide(); 
	else
		CraftFrame_Hide();
	end
	HideUIPanel(ATSWCheckerFrame);
	HideUIPanel(ATSWReagentFrame);
	HideUIPanel(ATSWCSFrame);
end

function ATSW_Command(cmd)
	if(cmd=="show") then
		ATSW_ShowWindow();
	elseif(cmd=="disable") then
		ATSW_DisableForActiveTradeskill();
	elseif(cmd=="enable") then
		ATSW_EnableForActiveTradeskill();
	end
end

function ATSW_DisableForActiveTradeskill()
	if(atsw_oldmode) then
		if(CraftFrame and CraftFrame:IsVisible()) then
			atsw_disabled[UnitName("player")][atsw_selectedskill]=1;
			HideUIPanel(ATSWFrame);
			CraftFrame:SetAlpha(1);
			CraftFrame:SetScale(1);
			ATSW_DisplayMessage(ATSW_ACTIVATIONMESSAGE.." "..ATSW_DEACTIVATED);
		end
	else
		if(TradeSkillFrame and TradeSkillFrame:IsVisible()) then
			atsw_disabled[UnitName("player")][atsw_selectedskill]=1;
			HideUIPanel(ATSWFrame);
			TradeSkillFrame:SetAlpha(1);
			TradeSkillFrame:SetScale(1);
			ATSW_DisplayMessage(ATSW_ACTIVATIONMESSAGE.." "..ATSW_DEACTIVATED);
		end
	end
end

function ATSW_EnableForActiveTradeskill()
	if(atsw_oldmode) then
		if(CraftFrame and CraftFrame:IsVisible()) then
			atsw_disabled[UnitName("player")][atsw_selectedskill]=0;
			ATSW_ShowWindow();
			CraftFrame:SetAlpha(0);
			CraftFrame:SetScale(0.001);
			ATSW_DisplayMessage(ATSW_ACTIVATIONMESSAGE.." "..ATSW_ACTIVATED);
		end
	else
		if(TradeSkillFrame and TradeSkillFrame:IsVisible()) then
			atsw_disabled[UnitName("player")][atsw_selectedskill]=0;
			ATSW_ShowWindow();
			TradeSkillFrame:SetAlpha(0);
			TradeSkillFrame:SetScale(0.001);
			ATSW_DisplayMessage(ATSW_ACTIVATIONMESSAGE.." "..ATSW_ACTIVATED);
		end
	end
end

function ATSWFrame_Show()
	ATSW_ShowWindow();
end

function ATSW_CheckForTradeSkillWindow(arg1)
	if(ATSWFrame:IsVisible()) then
		if(atsw_updatedelay>0) then
			atsw_updatedelay=atsw_updatedelay-arg1;
			if(atsw_updatedelay<=0) then
				ATSWFrame_Update();
				atsw_updatedelay=0;
			end
		end
		ATSW_CheckForRescan();
	end
	if(atsw_processnext==true) then 
		atsw_processnext=false;
		ATSW_ProcessNextQueueItem();
	end
	if(atsw_processing==true) then
		if(atsw_processingtimeout~=0) then
			if(atsw_processingtimeout>0) then
				atsw_processingtimeout=atsw_processingtimeout-arg1;
			else
				atsw_processingtimeout=0;
				ATSWQueueStartStopButton:SetText(ATSW_STARTQUEUE);
				atsw_processing=false;
				ATSWFrame:UnregisterEvent("SPELLCAST_STOP");
				ATSWFrame:UnregisterEvent("SPELLCAST_CHANNEL_STOP");
				ATSWFrame:UnregisterEvent("SPELLCAST_START");
				ATSWFrame:UnregisterEvent("SPELLCAST_INTERRUPTED");
			end
		end
		if(atsw_retry==true) then
			if(atsw_retrydelay<ATSW_MAX_DELAY) then
				atsw_retrydelay=atsw_retrydelay+arg1;
			else
				atsw_retrydelay=0;
				ATSW_ProcessNextQueueItem();
			end
		end		
	end
	if(TradeSkillFrame==nil) then return; end
end

function ATSWFrame_OnEvent()
	if(event=="TRADE_SKILL_SHOW") then
		if(CraftFrame and CraftFrame:IsVisible()) then ATSW_HideWindow(); end
		atsw_oldmode=false;
		ATSW_GetSelectedSkill();
		if(atsw_disabled[UnitName("player")][atsw_selectedskill]==0) then
			ATSW_ShowWindow();
		end
	elseif(event=="TRADE_SKILL_CLOSE") then
		ATSW_HideWindow();
	elseif(event=="CRAFT_SHOW") then
		if(TradeSkillFrame and TradeSkillFrame:IsVisible()) then ATSW_HideWindow(); end
		atsw_oldmode=true;
		local name=GetCraftDisplaySkillLine();
		if(name) then 
			ATSW_GetSelectedSkill();
			if(atsw_disabled[UnitName("player")][atsw_selectedskill]==0) then
				ATSW_ShowWindow();
			end
		end
	elseif(event=="CRAFT_CLOSE") then
		ATSW_HideWindow();
	elseif(event=="BANKFRAME_OPENED") then
		atsw_bankopened=true;
		ATSWBank_UpdateBankList();
	elseif(event=="BANKFRAME_CLOSED") then
		atsw_bankopened=false;
	elseif(event=="PLAYERBANKSLOTS_CHANGED") then
		ATSWBank_UpdateBankList();
	elseif(event=="PLAYERBANKBAGSLOTS_CHANGED") then
		ATSWBank_UpdateBankList();
	elseif(event=="MERCHANT_SHOW") then
		ATSWMerchant_InsertAutoBuyButton();
		ATSWMerchant_UpdateMerchantList();
		ATSWMerchant_AutoBuy();
	elseif(event=="MERCHANT_CLOSED") then
		ATSWMerchant_RemoveAutoBuyButton();
	elseif(event=="MERCHANT_UPDATE") then
		ATSWMerchant_UpdateMerchantList();
	elseif(event=="AUCTION_HOUSE_SHOW") then
		ATSWAuction_ShowShoppingList();
	elseif(event=="AUCTION_HOUSE_CLOSED") then
		ATSWAuction_HideShoppingList();
	elseif(event=="BAG_UPDATE") then
		if(ATSWFrame:IsVisible()) then
			if(atsw_processing==true) then
				if(table.getn(atsw_queue)==0) then
					atsw_processingtimeout=-1;
				end
			end
			atsw_retries=0;
			atsw_retrydelay=ATSW_MAX_DELAY;
		end
		ATSW_ResetPossibleItemCounts();
		ATSWInv_UpdateItemList();
		ATSWBank_UpdateBankList();
	end
	if(not ATSWFrame:IsVisible()) then
		return;
	end
	if(TradeSkillFrame and TradeSkillFrame:IsVisible() and atsw_disabled[UnitName("player")][atsw_selectedskill]==0) then
		TradeSkillFrame:SetAlpha(0);
		TradeSkillFrame:SetScale(0.001);
	end
	if(CraftFrame and CraftFrame:IsVisible() and atsw_disabled[UnitName("player")][atsw_selectedskill]==0 and GetCraftDisplaySkillLine()) then
		CraftFrame:SetAlpha(0);
		CraftFrame:SetScale(0.001);
	end
	if(event=="TRADE_SKILL_UPDATE") then
		if(atsw_scans<2) then
			atsw_scans=atsw_scans+1;
			ATSW_CreateTradeSkillList();
			ATSWCreateButton:Disable();
			ATSWQueueButton:Disable();
			ATSWCreateAllButton:Disable();
			ATSWQueueAllButton:Disable();
			ATSWHighlightFrame:Hide();
			if(ATSW_GetTradeSkillSelectionIndex()>1) then
				ATSWFrame_SetSelection(ATSW_GetTradeSkillSelectionIndex());
			else
				if(ATSW_GetNumTradeSkills()>0) then
					ATSWFrame_SetSelection(ATSW_GetFirstTradeSkill());
					FauxScrollFrame_SetOffset(ATSWListScrollFrame, 0);
				end
				ATSWListScrollFrameScrollBar:SetValue(0);
			end
			if(atsw_updating==false) then
				ATSW_ResetPossibleItemCounts();
				ATSW_CreateSkillListing();
				ATSWFrame_Update(); 
			end
		end
	elseif(event=="UNIT_PORTRAIT_UPDATE") then
		if(arg1=="player") then
			SetPortraitTexture(TradeSkillFramePortrait, "player");
		end
	elseif(event=="UPDATE_TRADESKILL_RECAST") then
		ATSWInputBox:SetNumber(GetTradeskillRepeatCount());
	elseif(event=="SPELLCAST_STOP" or event=="SPELLCAST_CHANNEL_STOP") then
		ATSW_SpellcastStop();
	elseif(event=="SPELLCAST_START") then
		ATSW_SpellcastStart();
	elseif(event=="SPELLCAST_INTERRUPTED") then
		ATSW_SpellcastInterrupted();
	elseif(event=="TRAINER_CLOSED") then
		ATSW_ResetPossibleItemCounts();
		ATSW_CreateSkillListing();
		if(ATSWFrame:IsVisible()) then ATSWFrame_Update(); end
	elseif(event=="PLAYER_REGEN_ENABLED") then
		atsw_incombat=false;
	elseif(event=="PLAYER_REGEN_DISABLED") then
		atsw_incombat=true;
	end
end

function ATSW_AdjustFrame()
	if(atsw_oldmode) then
		ATSWHeaderSortButton:Hide();
		ATSWInvSlotDropDown:Hide();
		ATSWSubClassDropDown:Hide();
		ATSWExpandButtonFrame:Hide();
		ATSWCreateButton:Hide();
		ATSWQueueButton:Hide();
		ATSWCreateAllButton:Hide();
		ATSWQueueAllButton:Hide();
		ATSWDecrementButton:Hide();
		ATSWInputBox:Hide();
		ATSWIncrementButton:Hide();
		ATSWQueueStartStopButton:Hide();
		ATSWQueueDeleteButton:Hide();
		ATSWReagentsButton:Hide();
		ATSWHorizontalBarLeft:Hide();
		ATSWHorizontalBarLeft2:Hide();
		ATSWHorizontalBarLeftAddon:Hide();
		ATSWHorizontalBarLeft2Addon:Hide();

		ATSWEnchantButton:Show();
		ATSWReagentLabel:SetPoint("TOPLEFT", "ATSWFrame", "TOPLEFT" , 380, -180);
		ATSWCraftDescription:Show();
	else
		ATSWHeaderSortButton:Show();
		ATSWInvSlotDropDown:Show();
		ATSWSubClassDropDown:Show();
		ATSWExpandButtonFrame:Show();
		ATSWCreateButton:Show();
		ATSWQueueButton:Show();
		ATSWCreateAllButton:Show();
		ATSWQueueAllButton:Show();
		ATSWDecrementButton:Show();
		ATSWInputBox:Show();
		ATSWIncrementButton:Show();
		ATSWQueueStartStopButton:Show();
		ATSWQueueDeleteButton:Show();
		ATSWReagentsButton:Show();
		ATSWHorizontalBarLeft:Show();
		ATSWHorizontalBarLeft2:Show();
		ATSWHorizontalBarLeftAddon:Show();
		ATSWHorizontalBarLeft2Addon:Show();

		ATSWEnchantButton:Hide();
		ATSWReagentLabel:SetPoint("TOPLEFT", "ATSWFrame", "TOPLEFT" , 380, -136);
		ATSWCraftDescription:Hide();
	end
end

function ATSW_SortTradeSkills()
	local tradeskills={};
	ExpandTradeSkillSubClass(0);
	local numTradeSkills=ATSW_GetNumTradeSkills();

	for i=1,numTradeSkills,1 do
		local skillName, skillType, numAvailable, isExpanded = ATSW_GetTradeSkillInfo(i);
		if(skillType~="header") then
			local skillTypeNumber=0;
			if(skillType=="easy") then skillTypeNumber=1; end
			if(skillType=="medium") then skillTypeNumber=2; end
			if(skillType=="optimal") then skillTypeNumber=3; end
			table.insert(tradeskills,{name=skillName,id=i,skilltype=skillTypeNumber});
		end
	end

	atsw_tradeskillid={};
	table.setn(atsw_tradeskillid,0);
	if(atsw_orderby[UnitName("player")][atsw_selectedskill]=="name") then
		table.sort(tradeskills,ATSW_CompareName);
		for i=1,table.getn(tradeskills),1 do
			table.insert(atsw_tradeskillid,tradeskills[i].id);
		end
	end
	if(atsw_orderby[UnitName("player")][atsw_selectedskill]=="difficulty") then
		table.sort(tradeskills,ATSW_CompareDifficulty);
		for i=1,table.getn(tradeskills),1 do
			table.insert(atsw_tradeskillid,tradeskills[i].id);
		end
	end
end

function ATSW_CompareName(i,j)
	return string.lower(i.name) < string.lower(j.name);
end

function ATSW_CompareDifficulty(i,j)
	return string.lower(i.skilltype) > string.lower(j.skilltype);
end

function ATSW_OrderBy(order)
	atsw_orderby[UnitName("player")][atsw_selectedskill]=order;
	ATSW_CreateSkillListing();
	ATSWFrame_Update();
end

function ATSWFrame_Update()
	if(type(atsw_orderby)~="table") then atsw_orderby={}; end
	if(not atsw_orderby[UnitName("player")]) then atsw_orderby[UnitName("player")]={}; end
	if(not atsw_orderby[UnitName("player")][atsw_selectedskill]) then atsw_orderby[UnitName("player")][atsw_selectedskill]="nothing"; end
	if(atsw_oldmode and atsw_orderby[UnitName("player")][atsw_selectedskill]=="nothing") then 
		atsw_orderby[UnitName("player")][atsw_selectedskill]="name";
	end
	if(atsw_orderby[UnitName("player")][atsw_selectedskill]=="name") then
		ATSWHeaderSortButton:SetChecked(false);
		ATSWNameSortButton:SetChecked(true);
		ATSWDifficultySortButton:SetChecked(false);
		ATSWCustomSortButton:SetChecked(false);
	elseif(atsw_orderby[UnitName("player")][atsw_selectedskill]=="difficulty") then
		ATSWHeaderSortButton:SetChecked(false);
		ATSWNameSortButton:SetChecked(false);
		ATSWDifficultySortButton:SetChecked(true);
		ATSWCustomSortButton:SetChecked(false);
	elseif(atsw_orderby[UnitName("player")][atsw_selectedskill]=="custom") then
		ATSWHeaderSortButton:SetChecked(false);
		ATSWNameSortButton:SetChecked(false);
		ATSWDifficultySortButton:SetChecked(false);
		ATSWCustomSortButton:SetChecked(true);
	else
		ATSWHeaderSortButton:SetChecked(true);
		ATSWNameSortButton:SetChecked(false);
		ATSWDifficultySortButton:SetChecked(false);
		ATSWCustomSortButton:SetChecked(false);
	end
	for i=1,ATSW_TRADE_SKILLS_DISPLAYED,1 do
		getglobal("ATSWSkill"..i):Hide();
	end
	if(atsw_orderby[UnitName("player")][atsw_selectedskill]=="nothing" or atsw_orderby[UnitName("player")][atsw_selectedskill]=="custom") then
		ATSWExpandButtonFrame:Show();
		local numTradeSkills=table.getn(atsw_skilllisting);
		local skillOffset=FauxScrollFrame_GetOffset(ATSWListScrollFrame);

		if(numTradeSkills==0) then
			ATSWFrameTitleText:SetText(format(TEXT(TRADE_SKILL_TITLE), ATSW_GetTradeSkillLine()).." - "..ATSW_VERSION);
			ATSWSkillName:Hide();
			ATSWSkillIcon:Hide();
			ATSWRequirementLabel:Hide();
			ATSWCollapseAllButton:Disable();
			for i=1, ATSW_MAX_TRADE_SKILL_REAGENTS, 1 do
				getglobal("ATSWReagent"..i):Hide();
			end
		else
			ATSWSkillName:Show();
			ATSWSkillIcon:Show();
			ATSWCollapseAllButton:Enable();
		end

		FauxScrollFrame_Update(ATSWListScrollFrame, numTradeSkills, ATSW_TRADE_SKILLS_DISPLAYED, ATSW_TRADE_SKILL_HEIGHT, nil, nil, nil, ATSWHighlightFrame, 293, 316);
		ATSWHighlightFrame:Hide();
		local jumped=1;
		for i=1,ATSW_TRADE_SKILLS_DISPLAYED,1 do
			local skillName, skillType, numAvailable, isExpanded;
			local skillIndex;
			repeat
				skillIndex=skillOffset+jumped;
				if(skillIndex>numTradeSkills) then
					skillName=nil;
				else
					skillName = atsw_skilllisting[skillIndex].name;
					skillType = atsw_skilllisting[skillIndex].type;
					isExpanded = atsw_skilllisting[skillIndex].expanded;
				end
				jumped=jumped+1;
			until ((skillName and ATSW_Filter(skillName)==true and ATSW_FilterInvSlot(skillName) and ATSW_FilterSubClass(skillName)) or skillIndex>numTradeSkills or skillType=="header");
			if(skillName) then numAvailable=ATSW_GetNumItemsPossible(skillName); end
			local skillButton=getglobal("ATSWSkill"..i);
			if(skillIndex<=numTradeSkills) then
				if(ATSWListScrollFrame:IsVisible()) then
					skillButton:SetWidth(293);
				else
					skillButton:SetWidth(323);
				end
				local color=ATSWTypeColor[skillType];
				if(color) then
					skillButton:SetTextColor(color.r, color.g, color.b);
				end
				
				if(atsw_skilllisting[skillIndex] and atsw_skilllisting[skillIndex].id) then
					skillButton:SetID(atsw_skilllisting[skillIndex].id);
				else
					return;
				end
				skillButton:Show();
				if(skillType=="header") then
					skillButton:SetText(skillName);
					if(isExpanded) then
						skillButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
					else
						skillButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					end
					getglobal("ATSWSkill"..i.."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
					getglobal("ATSWSkill"..i):UnlockHighlight();
				else
					if(not skillName)then
						return;
					end
					skillButton:SetNormalTexture("");
					getglobal("ATSWSkill"..i.."Highlight"):SetTexture("");
					if(atsw_multicount==true) then
						if ( numAvailable == 0 ) then
							skillButton:SetText(" "..skillName);
						else
							skillButton:SetText(" "..skillName.." ["..numAvailable.."]");
						end
					else
						local numAvailableString=ATSW_GetNumItemsPossibleWithInventory(skillName).."/"..numAvailable;
						if ( numAvailableString == "0/0" ) then
							skillButton:SetText(" "..skillName);
						else
							skillButton:SetText(" "..skillName.." ["..numAvailableString.."]");
						end
					end
					
					if(ATSW_GetTradeSkillSelectionIndex()==atsw_skilllisting[skillIndex].id) then
						ATSWHighlightFrame:SetPoint("TOPLEFT", "ATSWSkill"..i, "TOPLEFT", 0, 0);
						ATSWHighlightFrame:Show();
						ATSWFrame.numAvailable = numAvailable;
						getglobal("ATSWSkill"..i):LockHighlight();
					else
						getglobal("ATSWSkill"..i):UnlockHighlight();
					end
				end			
			else
				skillButton:Hide();
			end
		end
	end
	if(atsw_orderby[UnitName("player")][atsw_selectedskill]=="name" or atsw_orderby[UnitName("player")][atsw_selectedskill]=="difficulty") then
		ATSWExpandButtonFrame:Hide();
		atsw_updating=true;
		ATSW_SortTradeSkills();
		local numTradeSkills=table.getn(atsw_tradeskillid);
		local skillOffset=FauxScrollFrame_GetOffset(ATSWListScrollFrame);

		if(numTradeSkills==0) then
			ATSWFrameTitleText:SetText(format(TEXT(TRADE_SKILL_TITLE), ATSW_GetTradeSkillLine()).." - "..ATSW_VERSION);
			ATSWSkillName:Hide();
			ATSWSkillIcon:Hide();
			ATSWRequirementLabel:Hide();
			ATSWCollapseAllButton:Disable();
			for i=1, ATSW_MAX_TRADE_SKILL_REAGENTS, 1 do
				getglobal("ATSWReagent"..i):Hide();
			end
		else
			ATSWSkillName:Show();
			ATSWSkillIcon:Show();
			ATSWCollapseAllButton:Enable();
		end

		FauxScrollFrame_Update(ATSWListScrollFrame, numTradeSkills, ATSW_TRADE_SKILLS_DISPLAYED, ATSW_TRADE_SKILL_HEIGHT, nil, nil, nil, ATSWHighlightFrame, 293, 316);
		ATSWHighlightFrame:Hide();
		local jumped=1;
		for i=1,ATSW_TRADE_SKILLS_DISPLAYED,1 do
			local skillName, skillType, numAvailable, isExpanded, craftSubSpellName;
			local skillIndex;
			repeat
				skillIndex=atsw_tradeskillid[skillOffset+jumped];
				if(skillIndex==nil) then
					skillName=nil;
				else	
					skillName, skillType, numAvailable, isExpanded = ATSW_GetTradeSkillInfo(skillIndex);
				end
				jumped=jumped+1;
			until (((skillName and ATSW_Filter(skillName)==true and ATSW_FilterInvSlot(skillName) and ATSW_FilterSubClass(skillName)) or skillIndex==nil) and skillType~="header");
			if(skillIndex) then
				skillName, skillType, numAvailable, isExpanded = ATSW_GetTradeSkillInfo(skillIndex);
				if(skillName) then numAvailable=ATSW_GetNumItemsPossible(skillName); end
				local skillButton=getglobal("ATSWSkill"..i);
				if(ATSWListScrollFrame:IsVisible()) then
					skillButton:SetWidth(293);
				else
					skillButton:SetWidth(323);
				end
				local color=ATSWTypeColor[skillType];
				if(color) then
					skillButton:SetTextColor(color.r, color.g, color.b);
				end
				
				skillButton:SetID(skillIndex);
				skillButton:Show();
				if(skillType=="header") then
					skillButton:SetText(skillName);
					if(isExpanded) then
						skillButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
					else
						skillButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
					end
					getglobal("ATSWSkill"..i.."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
					getglobal("ATSWSkill"..i):UnlockHighlight();
				else
					if(not skillName)then
						return;
					end
					skillButton:SetNormalTexture("");
					getglobal("ATSWSkill"..i.."Highlight"):SetTexture("");
					if(atsw_multicount==true) then
						if ( numAvailable == 0 ) then
							skillButton:SetText(" "..skillName);
						else
							skillButton:SetText(" "..skillName.." ["..numAvailable.."]");
						end
					else
						local numAvailableString=ATSW_GetNumItemsPossibleWithInventory(skillName).."/"..numAvailable;
						if ( numAvailableString == "0/0" ) then
							skillButton:SetText(" "..skillName);
						else
							skillButton:SetText(" "..skillName.." ["..numAvailableString.."]");
						end
					end
					
					if(ATSW_GetTradeSkillSelectionIndex()==skillIndex) then
						ATSWHighlightFrame:SetPoint("TOPLEFT", "ATSWSkill"..i, "TOPLEFT", 0, 0);
						ATSWHighlightFrame:Show();
						ATSWFrame.numAvailable = numAvailable;
						getglobal("ATSWSkill"..i):LockHighlight();
					else
						getglobal("ATSWSkill"..i):UnlockHighlight();
					end
				end
			end
		end
		atsw_updating=false;
	end
end

function ATSWSkillButton_OnClick(button)
	if(button=="LeftButton") then
		ATSWFrame_SetSelection(this:GetID(),true);
		ATSWFrame_Update();
	end
end

function ATSWFrame_SetSelection(id,wasClicked)
	local skillName, skillType, numAvailable;
	local listpos=ATSW_GetSkillListingPos(id);
	if(atsw_skilllisting[listpos]) then
		skillName = atsw_skilllisting[listpos].name;
		skillType = atsw_skilllisting[listpos].type;
	else
		skillName=nil;
	end
	if(skillName) then numAvailable=ATSW_GetNumItemsPossible(skillName); end
	if(IsShiftKeyDown() and skillName~=nil and wasClicked~=nil) then
		if(arg1=="LeftButton" and ChatFrameEditBox:IsVisible()) then
			ATSW_AddTradeSkillReagentLinksToChatFrame(skillName);
		end
	end
	ATSWHighlightFrame:Show();
	if(skillType=="header") then
		ATSWHighlightFrame:Hide();
		if(atsw_skilllisting[listpos].expanded) then
			ATSW_SetHeaderExpanded(id,false);
		else
			ATSW_SetHeaderExpanded(id,true);
		end
		ATSWFrame_Update();
		return;
	end
	ATSWFrame.selectedSkillName=skillName;
	ATSWFrame.selectedSkill = id;
	ATSW_SelectTradeSkill(id);

	if(ATSW_GetTradeSkillSelectionIndex()>ATSW_GetNumTradeSkills())then
		return;
	end
	local color=ATSWTypeColor[skillType];
	if(color) then
		ATSWHighlight:SetVertexColor(color.r, color.g, color.b);
	end

	-- General Info
	local skillLineName, skillLineRank, skillLineMaxRank = ATSW_GetTradeSkillLine();
	ATSWFrameTitleText:SetText(format(TEXT(TRADE_SKILL_TITLE), skillLineName).." - "..ATSW_VERSION);
	-- Set statusbar info
	ATSWRankFrameSkillName:SetText(skillLineName);
	ATSWRankFrame:SetStatusBarColor(0.0, 0.0, 1.0, 0.5);
	ATSWRankFrameBackground:SetVertexColor(0.0, 0.0, 0.75, 0.5);
	ATSWRankFrame:SetMinMaxValues(0, skillLineMaxRank);
	ATSWRankFrame:SetValue(skillLineRank);
	ATSWRankFrameSkillRank:SetText(skillLineRank.."/"..skillLineMaxRank);

	ATSWSkillName:SetText(skillName);
	if(atsw_oldmode and GetCraftDescription(id)) then
		ATSWCraftDescription:SetText(GetCraftDescription(id));
	end
	if(ATSW_GetTradeSkillCooldown(id)) then
		ATSWSkillCooldown:SetText(COOLDOWN_REMAINING.." "..SecondsToTime(ATSW_GetTradeSkillCooldown(id)));
	else
		ATSWSkillCooldown:SetText("");
	end
	ATSWSkillIcon:SetNormalTexture(ATSW_GetTradeSkillIcon(id));
	local minMade,maxMade = ATSW_GetTradeSkillNumMade(id);
	if(maxMade>1) then
		if(minMade==maxMade) then
			ATSWSkillIconCount:SetText(minMade);
		else
			ATSWSkillIconCount:SetText(minMade.."-"..maxMade);
		end
		if(ATSWSkillIconCount:GetWidth()>39) then
			ATSWSkillIconCount:SetText("~"..floor((minMade + maxMade)/2));
		end
	else
		ATSWSkillIconCount:SetText("");
	end
	
	local creatable = 1;
	local numReagents = ATSW_GetTradeSkillNumReagents(id);
	for i=1, numReagents, 1 do
		local reagentName, reagentTexture, reagentCount, playerReagentCount = ATSW_GetTradeSkillReagentInfo(id, i);
		local reagent = getglobal("ATSWReagent"..i);
		local name = getglobal("ATSWReagent"..i.."Name");
		local count = getglobal("ATSWReagent"..i.."Count");
		if(not reagentName or not reagentTexture) then
			reagent:Hide();
		else
			reagent:Show();
			SetItemButtonTexture(reagent, reagentTexture);
			name:SetText(reagentName);
			-- Grayout items
			if(playerReagentCount<reagentCount) then
				SetItemButtonTextureVertexColor(reagent, 0.5, 0.5, 0.5);
				name:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
			else
				SetItemButtonTextureVertexColor(reagent, 1.0, 1.0, 1.0);
				name:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			end
			if(playerReagentCount>=100) then
				playerReagentCount = "*";
			end
			count:SetText(playerReagentCount.." /"..reagentCount);
		end
	end
	local reagentToAnchorTo = numReagents;
	if((numReagents > 0) and (mod(numReagents, 2)==0)) then
		reagentToAnchorTo = reagentToAnchorTo - 1;
	end
	
	for i=numReagents+1, ATSW_MAX_TRADE_SKILL_REAGENTS, 1 do
		getglobal("ATSWReagent"..i):Hide();
	end

	local spellFocus=BuildColoredListString(ATSW_GetTradeSkillTools(id));
	if(spellFocus) then
		ATSWRequirementLabel:Show();
		ATSWRequirementText:SetText(spellFocus);
	else
		ATSWRequirementLabel:Hide();
		ATSWRequirementText:SetText("");
	end

	if(creatable) then
		ATSWCreateButton:Enable();
		ATSWQueueButton:Enable();
		ATSWCreateAllButton:Enable();
		ATSWQueueAllButton:Enable();
	else
		ATSWCreateButton:Disable();
		ATSWQueueButton:Disable();
		ATSWCreateAllButton:Disable();
		ATSWQueueAllButton:Disable();
	end
end

function ATSWSubClassDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, ATSWSubClassDropDown_Initialize);
	UIDropDownMenu_SetWidth(120);
	UIDropDownMenu_SetSelectedID(ATSWSubClassDropDown, 1);
end

function ATSWSubClassDropDown_OnShow()
	UIDropDownMenu_Initialize(this, ATSWSubClassDropDown_Initialize);
	if(atsw_currentsubclassfilter==0) then
		UIDropDownMenu_SetSelectedID(ATSWSubClassDropDown, 1);
	end
end

function ATSWSubClassDropDown_Initialize()
	ATSWFilterFrame_LoadSubClasses(GetTradeSkillSubClasses());
end

function ATSWFilterFrame_LoadSubClasses(...)
	local info = {};
	if ( arg.n > 1 ) then
		info.text = TEXT(ALL_SUBCLASSES);
		info.func = ATSWSubClassDropDownButton_OnClick;
		info.checked = allChecked;
		if(atsw_currentsubclassfilter==0) then info.checked=true; end
		UIDropDownMenu_AddButton(info);
	end
	
	local checked;
	for i=1, arg.n, 1 do
		if (atsw_currentsubclassfilter==0 and arg.n > 1) then
			checked = nil;
			UIDropDownMenu_SetText(TEXT(ALL_SUBCLASSES), ATSWSubClassDropDown);
		else
			if(i==atsw_currentsubclassfilter) then
				checked=true;
				UIDropDownMenu_SetText(arg[i], ATSWSubClassDropDown);
			else
				checked=false;
			end
		end
		info = {};
		info.text = arg[i];
		info.func = ATSWSubClassDropDownButton_OnClick;
		info.checked = checked;
		UIDropDownMenu_AddButton(info);
	end
end

function ATSWInvSlotDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, ATSWInvSlotDropDown_Initialize);
	UIDropDownMenu_SetWidth(120);
	UIDropDownMenu_SetSelectedID(ATSWInvSlotDropDown, 1);
end

function ATSWInvSlotDropDown_OnShow()
	UIDropDownMenu_Initialize(this, ATSWInvSlotDropDown_Initialize);
	if(atsw_currentinvslotfilter==0) then
		UIDropDownMenu_SetSelectedID(ATSWInvSlotDropDown, 1);
	end
end

function ATSWInvSlotDropDown_Initialize()
	ATSWFilterFrame_LoadInvSlots(GetTradeSkillInvSlots());
end

function ATSWFilterFrame_LoadInvSlots(...)
	local info = {}
	if (arg.n > 1) then
		info.text = TEXT(ALL_INVENTORY_SLOTS);
		info.func = ATSWInvSlotDropDownButton_OnClick;
		info.checked = false;
		if(atsw_currentinvslotfilter==0) then info.checked=true; end
		UIDropDownMenu_AddButton(info);
	end
	
	local checked=false;
	for i=1, arg.n, 1 do
		if (atsw_currentinvslotfilter==0 and arg.n > 1) then
			checked = false;
			UIDropDownMenu_SetText(TEXT(ALL_INVENTORY_SLOTS), ATSWInvSlotDropDown);
		else
			if(i==atsw_currentinvslotfilter) then
				checked=true;
				UIDropDownMenu_SetText(arg[i], ATSWInvSlotDropDown);
			else
				checked=false;
			end
		end
		info = {};
		info.text = arg[i];
		info.func = ATSWInvSlotDropDownButton_OnClick;
		info.checked = checked;
		UIDropDownMenu_AddButton(info);
	end
end

function ATSWSubClassDropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(ATSWSubClassDropDown, this:GetID());
	if(this:GetID()==1) then
		atsw_subclassfilter=nil;
		atsw_subclassfiltered={};
		atsw_currentsubclassfilter=0;
		ATSW_CreateSkillListing();
		ATSWFrame_Update();
	else
		atsw_subclassfilter=this:GetID()-1;
		atsw_currentsubclassfilter=atsw_subclassfilter;
		SetTradeSkillSubClassFilter(this:GetID() - 1, 1, 1);
	end
end

atsw_currentinvslotfilter=0;
atsw_invslotfilter=nil;
atsw_invslotfiltered={};
atsw_currentsubclassfilter=0;
atsw_subclassfilter=nil;
atsw_subclassfiltered={};

function ATSWInvSlotDropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(ATSWInvSlotDropDown, this:GetID());
	if(this:GetID()==1) then
		atsw_invslotfilter=nil;
		atsw_invslotfiltered={};
		atsw_currentinvslotfilter=0;
		ATSW_CreateSkillListing();
		ATSWFrame_Update();
	else
		atsw_invslotfilter=this:GetID()-1;
		atsw_currentinvslotfilter=atsw_invslotfilter;
		SetTradeSkillInvSlotFilter(this:GetID() - 1, 1, 1);
	end
end

function ATSW_FilterInvSlot(skillName)
	if(table.getn(atsw_invslotfiltered)==0) then return true; end
	if(atsw_invslotfiltered[skillName]) then 
		return true;
	else
		return false;
	end	
end

function ATSW_FilterSubClass(skillName)
	if(table.getn(atsw_subclassfiltered)==0) then return true; end
	if(atsw_subclassfiltered[skillName]) then 
		return true;
	else
		return false;
	end	
end

function ATSWCollapseAllButton_OnClick()
	if (this.collapsed) then
		this.collapsed = nil;
		if(atsw_orderby[UnitName("player")][atsw_selectedskill]=="custom") then
			if(atsw_customheaders[UnitName("player")]) then
				if(atsw_customheaders[UnitName("player")][atsw_selectedskill]) then
					for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
						atsw_customheaders[UnitName("player")][atsw_selectedskill][i].expanded=true;
					end
				end
			end
			atsw_uncategorizedexpanded=true;
		else
			for i=1,table.getn(atsw_tradeskillheaders),1 do
				atsw_tradeskillheaders[i].expanded=true;
			end
		end
	else
		this.collapsed = 1;
		ATSWListScrollFrameScrollBar:SetValue(0);
		if(atsw_orderby[UnitName("player")][atsw_selectedskill]=="custom") then
			if(atsw_customheaders[UnitName("player")]) then
				if(atsw_customheaders[UnitName("player")][atsw_selectedskill]) then
					for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
						atsw_customheaders[UnitName("player")][atsw_selectedskill][i].expanded=false;
					end
				end
			end
			atsw_uncategorizedexpanded=false;
		else
			for i=1,table.getn(atsw_tradeskillheaders),1 do
				atsw_tradeskillheaders[i].expanded=false;
			end
		end
	end
	ATSW_CreateSkillListing();
	ATSWFrame_Update();
end

atsw_queue={};

function ATSWFrame_UpdateQueue()
	local jobs=table.getn(atsw_queue);
	local offset=FauxScrollFrame_GetOffset(ATSWQueueScrollFrame);

	for i=1,4,1 do
		local jobindex=i+offset;
		local queueCount=getglobal("ATSWQueueItem"..i.."Count");
		local queueName=getglobal("ATSWQueueItem"..i.."Name");
		local queueItem=getglobal("ATSWQueueItem"..i);
		local queueButton=getglobal("ATSWQueueItem"..i.."DeleteButton");
		if(atsw_queue[jobindex]) then
			queueCount:SetText(atsw_queue[jobindex].count.."x");
			queueName:SetText(atsw_queue[jobindex].name);
			queueItem.jobindex=jobindex;
			queueButton.jobindex=jobindex;
			queueItem:Show();
			queueButton:Show();
		else
			queueButton:Hide();
			queueItem:Hide();
		end
	end

	FauxScrollFrame_Update(ATSWQueueScrollFrame, jobs, 4, 22);
end

atsw_preventupdate=false;

function ATSW_DeleteQueue()
	atsw_queue={};
	ATSW_ResetPossibleItemCounts();
	ATSWInv_UpdateQueuedItemList();
	ATSWFrame_UpdateQueue();
	ATSWFrame_Update();
end

function ATSW_DeleteJob(jobindex)
	if(atsw_queue[jobindex]) then
		table.remove(atsw_queue,jobindex);
		if(FauxScrollFrame_GetOffset(ATSWQueueScrollFrame)>0 and FauxScrollFrame_GetOffset(ATSWQueueScrollFrame)+4>table.getn(atsw_queue)) then
			FauxScrollFrame_SetOffset(ATSWQueueScrollFrame,FauxScrollFrame_GetOffset(ATSWQueueScrollFrame)-1);
		end
		if(atsw_preventupdate==false) then
			ATSW_ResetPossibleItemCounts();
			ATSWInv_UpdateQueuedItemList();
			ATSWFrame_UpdateQueue();
			ATSWFrame_Update();
		end
	end
end

function ATSW_AddJobLL(skillname, num)
	for i=1,table.getn(atsw_queue),1 do
		if(atsw_queue[i].name==skillname) then
			atsw_queue[i].count=atsw_queue[i].count+num;
			if(atsw_preventupdate==false) then
				ATSW_ResetPossibleItemCounts();
				ATSWInv_UpdateQueuedItemList();
				ATSWFrame_UpdateQueue();
				ATSWFrame_Update();
			end
			return;
		end
	end
	table.insert(atsw_queue,{name=skillname,count=num});
	if(atsw_preventupdate==false) then
		ATSW_ResetPossibleItemCounts();
		ATSWInv_UpdateQueuedItemList();
		ATSWFrame_UpdateQueue();
		ATSWFrame_Update();
	end
end

function ATSW_AddJobFirst(skillname, num)
	for i=1,table.getn(atsw_queue),1 do
		if(atsw_queue[i].name==skillname) then
			atsw_queue[i].count=atsw_queue[i].count+num;
			if(atsw_preventupdate==false) then
				ATSW_ResetPossibleItemCounts();
				ATSWInv_UpdateQueuedItemList();
				ATSWFrame_UpdateQueue();
				ATSWFrame_Update();
			end
			return;
		end
	end
	table.insert(atsw_queue,1,{name=skillname,count=num});
	if(atsw_preventupdate==false) then
		ATSW_ResetPossibleItemCounts();
		ATSWInv_UpdateQueuedItemList();
		ATSWFrame_UpdateQueue();
		ATSWFrame_Update();
	end
end

function ATSW_DeleteJobPartial(skillname, num)
	for i=1,table.getn(atsw_queue),1 do
		if(atsw_queue[i].name==skillname) then
			atsw_queue[i].count=atsw_queue[i].count-num;
			if(atsw_queue[i].count<=0) then ATSW_DeleteJob(i); end
			if(atsw_preventupdate==false) then
				ATSW_ResetPossibleItemCounts();
				ATSWInv_UpdateQueuedItemList();
				ATSWFrame_UpdateQueue();
				ATSWFrame_Update();
			end
			return;
		end
	end
end

function ATSW_StartStopProcessing()
	if(atsw_processing==true) then
		atsw_processing=false;
		ATSWQueueStartStopButton:SetText(ATSW_STARTQUEUE);
	else
		atsw_processing=true;
		ATSWQueueStartStopButton:SetText(ATSW_STOPQUEUE);
		ATSW_StartProcessing();
	end
end

function ATSW_Enchant()
	DoCraft(GetCraftSelectionIndex());
end

function ATSW_SetColumnWidth(width, frame)
	if not frame then
    	frame = this;
	end
	frame:SetWidth(width);
  	getglobal(frame:GetName().."Middle"):SetWidth(width - 9);
	frame:Disable();
end

atsw_processingname="";
atsw_processing=false;
atsw_processnext=false;
atsw_lastremoved="";

function ATSW_StartProcessing()
	atsw_retries=0;
	atsw_retry=false;
	ATSWFrame:RegisterEvent("SPELLCAST_STOP");
	ATSWFrame:RegisterEvent("SPELLCAST_START");
	ATSWFrame:RegisterEvent("SPELLCAST_CHANNEL_STOP");
	ATSWFrame:RegisterEvent("SPELLCAST_INTERRUPTED");
	ATSW_ProcessNextQueueItem(true);	
end

function ATSW_ProcessNextQueueItem(directClick)
	if(table.getn(atsw_queue)>0 and atsw_retries<ATSW_MAX_RETRIES) then
--		atsw_processingname=atsw_queue[1].name;
--		atsw_working=true;
--		atsw_retries=atsw_retries+1;
--		atsw_retry=true;
--		atsw_retrydelay=0;
--		DoTradeSkill(ATSW_GetTradeSkillID(atsw_queue[1].name),1);
		if(directClick~=nil and directClick==true) then
			ATSW_ProcessIt();
		else
			ATSWCFItemName:SetText(ATSWCF_TITLE2.."\n"..atsw_queue[1].count.."x "..atsw_queue[1].name);
			ShowUIPanel(ATSWContinueFrame);
		end
	else
		atsw_processingtimeout=5;
	end
end

function ATSW_ProcessIt()
	atsw_processingname=atsw_queue[1].name;
	atsw_working=true;
	atsw_retries=atsw_retries+1;
	atsw_retry=true;
	atsw_processnext=false;
	atsw_retrydelay=0;
	DoTradeSkill(ATSW_GetTradeSkillID(atsw_queue[1].name),atsw_queue[1].count);	
end

function ATSW_SpellcastStop()
	atsw_working=false;
	if(atsw_queue[1]) then
		atsw_lastremoved=atsw_processingname;
		ATSW_DeleteJobPartial(atsw_processingname,1);
		ATSWFrame_UpdateQueue();
	end
	if(atsw_processing==true) then 
		if(atsw_queue[1]~=nil and atsw_queue[1].name~=atsw_processingname) then
			atsw_processnext=true;
		end
	else	
		ATSWQueueStartStopButton:SetText(ATSW_STARTQUEUE);
		ATSWFrame:UnregisterEvent("SPELLCAST_STOP");
		ATSWFrame:UnregisterEvent("SPELLCAST_START");
		ATSWFrame:UnregisterEvent("SPELLCAST_CHANNEL_STOP");
		ATSWFrame:UnregisterEvent("SPELLCAST_INTERRUPTED");
	end
end

function ATSW_SpellcastInterrupted()
	if(atsw_processing==true) then 
		atsw_working=false;
		ATSW_AddJobFirst(atsw_lastremoved,1);
		if(atsw_retries<ATSW_MAX_RETRIES) then
			atsw_retries=atsw_retries+1;
			atsw_retry=true;
			atsw_retrydelay=0;
			return;
		end
		ATSWQueueStartStopButton:SetText(ATSW_STARTQUEUE);
		atsw_processing=false;
		atsw_interrupted=true;
		ATSWFrame:UnregisterEvent("SPELLCAST_STOP");
		ATSWFrame:UnregisterEvent("SPELLCAST_START");
		ATSWFrame:UnregisterEvent("SPELLCAST_CHANNEL_STOP");
		ATSWFrame:UnregisterEvent("SPELLCAST_INTERRUPTED");
	end
end

function ATSW_SpellcastStart()
	atsw_retry=false;
	atsw_retrydelay=0;
	atsw_processingtimeout=0;
end

function ATSWDBF_OnOK()
	if(table.getn(atsw_queue)>0) then
		ATSW_ProcessIt();
	end
end

function ATSWDBF_OnAbort()
	ATSW_StartStopProcessing();	
end

function ATSW_GetTradeSkillID(skillName) 
	for i=1,table.getn(atsw_tradeskilllist),1 do
		if(atsw_tradeskilllist[i].name==skillName) then 
			return atsw_tradeskilllist[i].id;
		end
	end
	return 0;
end

function ATSW_GetTradeSkillListPos(id)
	for i=1,table.getn(atsw_tradeskilllist),1 do
		if(atsw_tradeskilllist[i].id==id) then 
			return i;
		end
	end
	return -1;	
end

function ATSW_GetTradeSkillListPosByName(name)
	for i=1,table.getn(atsw_tradeskilllist),1 do
		if(atsw_tradeskilllist[i].name==name) then 
			return i;
		end
	end
	return -1;	
end

function ATSW_CreateTradeSkillList()
	local numTradeSkills=ATSW_GetNumTradeSkills();
	local currentHeader=0;

	atsw_oldtradeskillheaders=atsw_tradeskillheaders;
	atsw_tradeskilllist={};
	atsw_tradeskillheaders={};

	if(atsw_oldmode) then 
		table.insert(atsw_tradeskillheaders,{name="invisibleheader",id=0,list={},expanded=true});
		currentHeader=1;
	end

	for i=1,numTradeSkills,1 do
		local skillName, skillType, numAvailable, isExpanded = ATSW_GetTradeSkillInfo(i);
		if(skillName~=nil) then
			if(skillType=="header") then
				local oldexpanded=true;
				for j=1,table.getn(atsw_oldtradeskillheaders),1 do
					if(atsw_oldtradeskillheaders[j].name==skillName) then
						oldexpanded=atsw_oldtradeskillheaders[j].expanded;
					end
				end
				table.insert(atsw_tradeskillheaders,{name=skillName,id=i,list={},expanded=oldexpanded});
				currentHeader=table.getn(atsw_tradeskillheaders);
			else
				if(currentHeader>0 or atsw_oldmode) then
					reagentlist={};
					local numReagents = ATSW_GetTradeSkillNumReagents(i);
					local skillLink = ATSW_GetTradeSkillItemLink(i);
					local numMade = ATSW_GetTradeSkillNumMade(i);
					for j=1, numReagents, 1 do
						local reagentName, reagentTexture, reagentCount, playerReagentCount = ATSW_GetTradeSkillReagentInfo(i, j);
						local reagentLink = ATSW_GetTradeSkillReagentItemLink(i,j);
						if(reagentName) then
							table.insert(reagentlist,{name=reagentName,count=reagentCount,link=reagentLink});
						end
					end
					table.insert(atsw_tradeskilllist,{name=skillName,id=i,reagents=reagentlist,link=skillLink,type=skillType,num=numMade});
					table.insert(atsw_tradeskillheaders[currentHeader].list,table.getn(atsw_tradeskilllist));
				end
			end
		end
	end

	local check=false;

	if(atsw_invslotfilter~=nil) then
		atsw_invslotfilter=nil;
		atsw_invslotfiltered={};
		for i=1,table.getn(atsw_tradeskilllist),1 do
			atsw_invslotfiltered[atsw_tradeskilllist[i].name]=1;
			table.setn(atsw_invslotfiltered,table.getn(atsw_invslotfiltered)+1);
		end
		for i=1,table.getn(atsw_tradeskillheaders),1 do
			atsw_invslotfiltered[atsw_tradeskillheaders[i].name]=1;
			table.setn(atsw_invslotfiltered,table.getn(atsw_invslotfiltered)+1);
		end
		SetTradeSkillInvSlotFilter(0, 1, 1);
		check=true;
	end

	if(atsw_subclassfilter~=nil) then
		atsw_subclassfilter=nil;
		atsw_subclassfiltered={};
		for i=1,table.getn(atsw_tradeskilllist),1 do
			atsw_subclassfiltered[atsw_tradeskilllist[i].name]=1;
			table.setn(atsw_subclassfiltered,table.getn(atsw_subclassfiltered)+1);
		end
		for i=1,table.getn(atsw_tradeskillheaders),1 do
			atsw_subclassfiltered[atsw_tradeskillheaders[i].name]=1;
			table.setn(atsw_subclassfiltered,table.getn(atsw_subclassfiltered)+1);
		end
		SetTradeSkillSubClassFilter(0, 1, 1);
		check=true;
	end

	if(check==false) then
		ATSW_CreateSkillListing();
	end
end

function ATSW_GetSkillListingPos(id)
	for i=1,table.getn(atsw_skilllisting),1 do
		if(atsw_skilllisting[i].id==id) then 
			return i;
		end
	end
	return -1;	
end

function ATSW_CreateSkillListing()
	atsw_skilllisting={};
	if(atsw_orderby[UnitName("player")][atsw_selectedskill]~="custom") then
		for i=1,table.getn(atsw_tradeskillheaders),1 do
			table.insert(atsw_skilllisting,{type="header",name=atsw_tradeskillheaders[i].name,expanded=atsw_tradeskillheaders[i].expanded,id=atsw_tradeskillheaders[i].id});
			if(atsw_tradeskillheaders[i].expanded==true) then
				for j=1,table.getn(atsw_tradeskillheaders[i].list),1 do
					local skillName=atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].name;
					local skillID=atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].id;
					local skillType=atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].type;
					local numMade=atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].num;
					local skillLink=atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].link;
					table.insert(atsw_skilllisting,{type=skillType,name=skillName,id=skillID,num=numMade,link=skillLink});
				end
			end
		end
	else
		local atsw_allskills={};
		for i=1,table.getn(atsw_tradeskillheaders),1 do
			for j=1,table.getn(atsw_tradeskillheaders[i].list),1 do
				table.insert(atsw_allskills,atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].name);
			end
		end
		if(atsw_customheaders[UnitName("player")]) then
			if(atsw_customheaders[UnitName("player")][atsw_selectedskill]) then
				for i=1,table.getn(atsw_customheaders[UnitName("player")][atsw_selectedskill]),1 do
					table.insert(atsw_skilllisting,{type="header",name=atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name,expanded=atsw_customheaders[UnitName("player")][atsw_selectedskill][i].expanded,id=i*1000});
					if(atsw_customsorting[UnitName("player")] and atsw_customsorting[UnitName("player")][atsw_selectedskill] and atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]) then
						for j=1,table.getn(atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name]),1 do
							local skillName=atsw_customsorting[UnitName("player")][atsw_selectedskill][atsw_customheaders[UnitName("player")][atsw_selectedskill][i].name][j].name;
							local skillID, skillType, numMade, skillLink=ATSW_GetSkillDataFromSkillList(skillName);
							if(atsw_customheaders[UnitName("player")][atsw_selectedskill][i].expanded==true) then table.insert(atsw_skilllisting,{type=skillType,name=skillName,id=skillID,num=numMade,link=skillLink}); end
							for k=1,table.getn(atsw_allskills),1 do
								if(atsw_allskills[k]==skillName) then
									table.remove(atsw_allskills,k);
								end
							end
						end
					end
				end
			end
		end
		if(table.getn(atsw_allskills)>0) then
			table.insert(atsw_skilllisting,{type="header",name=ATSWCS_UNCATEGORIZED,expanded=atsw_uncategorizedexpanded,id=1001});
			if(atsw_uncategorizedexpanded==true) then
				for i=1,table.getn(atsw_allskills),1 do
					local skillName=atsw_allskills[i];
					local skillID, skillType, numMade, skillLink=ATSW_GetSkillDataFromSkillList(skillName);
					table.insert(atsw_skilllisting,{type=skillType,name=skillName,id=skillID,num=numMade,link=skillLink});
				end
			end
		end
	end
end

function ATSW_GetSkillDataFromSkillList(skillName)
	for i=1,table.getn(atsw_tradeskillheaders),1 do
		for j=1,table.getn(atsw_tradeskillheaders[i].list),1 do
			if(skillName==atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].name) then
				local skillID=atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].id;
				local skillType=atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].type;
				local numMade=atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].num;
				local skillLink=atsw_tradeskilllist[atsw_tradeskillheaders[i].list[j]].link;
				return skillID, skillType, numMade, skillLink;
			end
		end
	end
	return nil,nil,nil,nil;
end

function ATSW_SetHeaderExpanded(id,value)
	if(atsw_orderby[UnitName("player")][atsw_selectedskill]~="custom") then
		for i=1,table.getn(atsw_tradeskillheaders),1 do
			if(atsw_tradeskillheaders[i].id==id) then
				atsw_tradeskillheaders[i].expanded=value;
			end
		end
	else
		if(id==1001) then
			atsw_uncategorizedexpanded=value;
		else
			atsw_customheaders[UnitName("player")][atsw_selectedskill][id/1000].expanded=value;
		end
	end
	ATSW_CreateSkillListing();
end

function ATSW_AddTradeSkillReagentLinksToChatFrame(skillName)
	local channel,chatnumber = ChatFrameEditBox.chatType;
	if channel=="WHISPER" then
		chatnumber = ChatFrameEditBox.tellTarget
	elseif channel=="CHANNEL" then
		chatnumber = ChatFrameEditBox.channelTarget
	end
	local chatline;
	for i=1,table.getn(atsw_tradeskilllist),1 do
		if(atsw_tradeskilllist[i]) then
			if(atsw_tradeskilllist[i].name==skillName) then
				SendChatMessage(ATSW_REAGENTLIST1..atsw_tradeskilllist[i].link..ATSW_REAGENTLIST2,channel,nil,chatnumber);
				for j=1,table.getn(atsw_tradeskilllist[i].reagents),1 do
					chatline=atsw_tradeskilllist[i].reagents[j].count.."x "..atsw_tradeskilllist[i].reagents[j].link;
					SendChatMessage(chatline,channel,nil,chatnumber);
				end
			end
		end
	end
end

function ATSWFrameIncrement_OnClick()
	if(ATSWInputBox:GetNumber()<100) then
		ATSWInputBox:SetNumber(ATSWInputBox:GetNumber()+1);
	end
end

function ATSWFrameDecrement_OnClick()
	if(ATSWInputBox:GetNumber()>0) then
		ATSWInputBox:SetNumber(ATSWInputBox:GetNumber()-1);
	end
end

function ATSW_GetNumItemsPossible(skillName)
	if(atsw_tradeskillcounter[skillName]) then
		return atsw_tradeskillcounter[skillName];
	end
	return ATSW_GetNumItemsPossibleNoCache(skillName,true);
end

function ATSW_GetNumItemsPossibleNoCache(skillName,writeCache)
	local atsw_considermerchants_backup=atsw_considermerchants;
	if(atsw_considermerchants==true and ATSW_CheckIfCreatedOnlyWithVendorStuff(skillName)==true) then
		atsw_considermerchants=false;
	end
	for i=1,500,1 do
		atsw_temporaryitemlist={};
		if(ATSW_CheckIfPossible(skillName,i)==false) then 
			atsw_temporaryitemlist={};
			if(writeCache==true) then atsw_tradeskillcounter[skillName]=(i-1); end
			atsw_considermerchants=atsw_considermerchants_backup;
			return (i-1);
		end
	end
	atsw_considermerchants=atsw_considermerchants_backup;
	return 0;
end

function ATSW_GetNumItemsPossibleWithInventory(skillName)
	local atsw_considerbank_backup=atsw_considerbank;
	local atsw_consideralts_backup=atsw_consideralts;
	local atsw_considermerchants_backup=atsw_considermerchants;
	atsw_considerbank=false;
	atsw_consideralts=false;
	atsw_considermerchants=false;
	local count=ATSW_GetNumItemsPossibleNoCache(skillName,false);
	atsw_considerbank=atsw_considerbank_backup;
	atsw_consideralts=atsw_consideralts_backup;
	atsw_considermerchants=atsw_considermerchants_backup;
	return count;
end

function ATSW_ToggleReagentFrame()
	if(ATSWReagentFrame:IsVisible()) then
		HideUIPanel(ATSWReagentFrame);
	else
		ATSW_ShowNecessaryReagents();
	end
end

function ATSW_ResetPossibleItemCounts()
	atsw_tradeskillcounter={};
end

function ATSW_AddJob(skillName,count)
	atsw_temporaryitemlist={};
	local numMade=1;
	for i=1,table.getn(atsw_tradeskilllist),1 do
		if(atsw_tradeskilllist[i].name==skillName) then
			numMade=atsw_tradeskilllist[i].num;
		end
	end
	ATSW_AddJobRecursive(skillName,count*numMade,true);	
end

function ATSW_AddJobRecursive(skillName,count,firstcall)
	if(ATSW_CheckBlacklist(skillName)==false or firstcall==true) then
		for i=1,table.getn(atsw_tradeskilllist),1 do
			if(atsw_tradeskilllist[i].name==skillName) then
				local usagecount=math.ceil(count/atsw_tradeskilllist[i].num);
				for j=1,table.getn(atsw_tradeskilllist[i].reagents),1 do
					local itemcount=ATSW_GetItemCountMinusQueued(atsw_tradeskilllist[i].reagents[j].name);
					if(itemcount<0) then itemcount=0; end
					local necessary=atsw_tradeskilllist[i].reagents[j].count*usagecount;
					if(itemcount<necessary) then
						local missing=necessary-itemcount;
						ATSW_AddJobRecursive(atsw_tradeskilllist[i].reagents[j].name,missing,false);
					end
				end
				ATSW_AddJobLL(skillName,usagecount);
			end
		end
	end
end

function ATSW_CheckIfPossible(skillName,count)
	for i=1,table.getn(atsw_tradeskilllist),1 do
		if(atsw_tradeskilllist[i].name==skillName) then
			for j=1,table.getn(atsw_tradeskilllist[i].reagents),1 do
				local usagecount=math.ceil(count/atsw_tradeskilllist[i].num);
				local itemcount=ATSW_GetItemCountMinusQueuedAndTemporary(atsw_tradeskilllist[i].reagents[j].name);
				local necessary=atsw_tradeskilllist[i].reagents[j].count*count;
				if(itemcount>=necessary) then
					ATSW_TemporaryUseItem(atsw_tradeskilllist[i].reagents[j].name,necessary);
				else
					local missing=necessary-itemcount;
					local response=ATSW_CheckIfPossible(atsw_tradeskilllist[i].reagents[j].name,missing);
					if(response==false) then return false; end
				end
			end
			return true;
		end
	end
	return false;
end

function ATSW_CheckIfCreatedOnlyWithVendorStuff(skillName)
	for i=1,table.getn(atsw_tradeskilllist),1 do
		if(atsw_tradeskilllist[i].name==skillName) then
			for j=1,table.getn(atsw_tradeskilllist[i].reagents),1 do
				local response=ATSW_CheckIfCreatedOnlyWithVendorStuff(atsw_tradeskilllist[i].reagents[j].name);
				if(response==false) then return false; end
			end
			return true;
		end
	end
	return ATSWMerchant_CheckIfAvailable(skillName);
end

atsw_missingitems={};

function ATSW_NoteMissingItems(skillName,count)
	if(ATSW_CheckBlacklist(skillName)==false) then
		for i=1,table.getn(atsw_tradeskilllist),1 do
			if(atsw_tradeskilllist[i].name==skillName) then
				for j=1,table.getn(atsw_tradeskilllist[i].reagents),1 do
					local itemcount=ATSW_GetItemCountMinusQueuedAndTemporary(atsw_tradeskilllist[i].reagents[j].name);
					local necessary=atsw_tradeskilllist[i].reagents[j].count*count;
					if(itemcount>=necessary) then
						ATSW_TemporaryUseItem(atsw_tradeskilllist[i].reagents[j].name,necessary);
					else
						local missing=necessary-itemcount;
						ATSW_NoteMissingItems(atsw_tradeskilllist[i].reagents[j].name,missing);
					end
				end
				return;
			end
		end
	end
	for i=1,table.getn(atsw_missingitems),1 do
		if(atsw_missingitems[i]) then
			if(atsw_missingitems[i].name==skillName) then
				atsw_missingitems[i].cnt=atsw_missingitems[i].cnt+count;
				return;
			end
		end
	end
	table.insert(atsw_missingitems,{name=skillName,cnt=count});
end

function ATSW_OutputMissingItems(skillName,count)
	ATSW_DisplayMessage(ATSW_ITEMSMISSING1..count.."x '"..skillName.."'"..ATSW_ITEMSMISSING2);
	for i=1,table.getn(atsw_missingitems),1 do
		ATSW_DisplayMessage(atsw_missingitems[i].cnt.."x '"..atsw_missingitems[i].name.."'");
	end	
end

atsw_necessaryitems={};

function ATSW_NoteNecessaryItems(skillName,count,itemLink)
	for i=1,table.getn(atsw_tradeskilllist),1 do
		if(atsw_tradeskilllist[i].name==skillName) then
			for j=1,table.getn(atsw_tradeskilllist[i].reagents),1 do
				local necessary=atsw_tradeskilllist[i].reagents[j].count*count;
				local found=false;
				for x=1,table.getn(atsw_necessaryitems),1 do
					if(atsw_necessaryitems[x]) then
						if(atsw_necessaryitems[x].name==atsw_tradeskilllist[i].reagents[j].name) then
							atsw_necessaryitems[x].cnt=atsw_necessaryitems[x].cnt+necessary;
							found=true;
							break;
						end
					end
				end
				if(found==false) then
					table.insert(atsw_necessaryitems,{name=atsw_tradeskilllist[i].reagents[j].name,cnt=necessary,link=atsw_tradeskilllist[i].reagents[j].link});
				end
			end
			return;
		end
	end
end

function ATSW_NoteNecessaryItemsForQueue()
	atsw_necessaryitems={};
	for i=1,table.getn(atsw_queue),1 do
		ATSW_NoteNecessaryItems(atsw_queue[i].name,atsw_queue[i].count,nil);
	end
	ATSW_FilterNecessaryItems();
end

function ATSW_FilterNecessaryItems()
	for i=1,table.getn(atsw_necessaryitems),1 do
		for k=1,table.getn(atsw_queue),1 do
			if(atsw_necessaryitems[i].name==atsw_queue[k].name) then
				atsw_necessaryitems[i].cnt=atsw_necessaryitems[i].cnt-atsw_queue[k].count;
			end
		end
	end
	for i=table.getn(atsw_necessaryitems),1,-1 do
		if(atsw_necessaryitems[i].cnt<=0) then
			table.remove(atsw_necessaryitems,i);
		end
	end
end

function ATSW_NoteNecessaryItemsForTradeskill(skillName,skillCount)
	local atsw_queue_backup=atsw_queue;
	atsw_preventupdate=true;
	atsw_queue={};
	ATSW_AddJob(skillName,skillCount);
	ATSW_NoteNecessaryItemsForQueue();
	atsw_queue=atsw_queue_backup;
	atsw_preventupdate=false;
end

function ATSW_ShowNecessaryReagents()
	ATSW_NoteNecessaryItemsForQueue();
	for i=1,20,1 do
		local count=getglobal("ATSWRFReagent"..i.."Count");
		local item=getglobal("ATSWRFReagent"..i.."Item");
		local inv=getglobal("ATSWRFReagent"..i.."Inventory");
		local bank=getglobal("ATSWRFReagent"..i.."Bank");
		local merchant=getglobal("ATSWRFReagent"..i.."Merchant");
		local alt=getglobal("ATSWRFReagent"..i.."Alt");
		local missing=getglobal("ATSWRFReagent"..i.."Missing");
		if(atsw_necessaryitems[i]) then
			local items_inventory=ATSWInv_GetItemCount(atsw_necessaryitems[i].name);
			local items_bank=ATSWBank_GetItemCount(atsw_necessaryitems[i].name);
			local items_alt=ATSWAlt_GetItemCount(atsw_necessaryitems[i].name);
			local items_missing=items_inventory+items_bank+items_alt-atsw_necessaryitems[i].cnt;
			local items_merchant=ATSWMerchant_CheckIfAvailable(atsw_necessaryitems[i].name);
			count:SetText(atsw_necessaryitems[i].cnt.."x");
			count:Disable();
			count:Show();
			item:SetText("["..atsw_necessaryitems[i].name.."]");
			item.link=atsw_necessaryitems[i].link;
			item:Show();
			inv:SetText(items_inventory);
			inv:Disable();
			inv:Show();
			if(items_inventory>=atsw_necessaryitems[i].cnt) then
				inv:SetTextColor(0,1,0);
			else
				inv:SetTextColor(1,0,0);
			end
			bank:SetText(items_bank);
			bank:Disable();
			bank:Show();
			if(items_bank>=atsw_necessaryitems[i].cnt) then
				bank:SetTextColor(0,1,0);
			else
				bank:SetTextColor(1,0,0);
			end
			merchant:SetText("X");
			merchant:Disable();
			if(items_merchant==true) then
				merchant:Show();
			else
				merchant:Hide();
			end
			alt:SetText(items_alt);
			if(items_alt>0) then
				alt:Enable();
				alt.itemname=atsw_necessaryitems[i].name;
			else
				alt:Disable();
			end
			alt:Show();
			if(items_alt>=atsw_necessaryitems[i].cnt) then
				alt:SetTextColor(0,1,0);
			else
				alt:SetTextColor(1,0,0);
			end
			if(items_missing>=0) then
				missing:SetText("+"..items_missing);
				missing:SetTextColor(0,1,0);
			else
				missing:SetText(items_missing);
				missing:SetTextColor(1,0,0);
			end
			missing:Disable();
			missing:Show();
		else
			count:Hide();
			item:Hide();
			inv:Hide();
			bank:Hide();
			merchant:Hide();
			alt:Hide();
			missing:Hide();
		end
	end
	ShowUIPanel(ATSWReagentFrame);
end

function ATSWItemButton_OnEnter()
    if(this.link) then
    	GameTooltip:SetOwner(this, "ANCHOR_NONE");
        GameTooltip:SetPoint("BOTTOMLEFT",this:GetName(),"TOPLEFT");
	GameTooltip:SetHyperlink(string.gsub(this.link, "|c(%x+)|H(item:%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r", "%2"));
        GameTooltip:Show();
    end
end

function ATSWItemButton_OnLeave()
	GameTooltip:Hide();
end

function ATSW_TemporaryUseItem(itemname,count)
	if(atsw_temporaryitemlist[itemname]) then
		atsw_temporaryitemlist[itemname]=atsw_temporaryitemlist[itemname]+count;
	else
		atsw_temporaryitemlist[itemname]=count;
	end	
end

function ATSW_CheckBlacklist(itemname)
	for i=1,table.getn(atsw_blacklist),1 do
		if(atsw_blacklist[i]) then
			if(atsw_blacklist[i]==itemname) then return true; end
		end
	end
	return false;	
end

atsw_filter="";

function ATSW_UpdateFilter(filtertext)
	atsw_filter=filtertext;
	ATSWFrame_Update();	
end

function ATSW_Filter(skillname)
	if(skillname==nil) then return false; end
	if(skillname=="") then return true; end
	local parameters={};
	for w in string.gfind(atsw_filter, ":[^:]*") do
		local _, _, param_name, param_value=string.find(w, ":(%a+)%s([^:]*)");
		if(param_name~=nil) then _, _, param_name=string.find(param_name,"^%s*(.-)%s*$"); end
		if(param_value~=nil) then _, _, param_value=string.find(param_value,"^%s*(.-)%s*$"); end
		if(param_name~=nil) then
			table.insert(parameters,{name=param_name,value=param_value});
		end
	end
	local _, _, searchstring=string.find(atsw_filter,"^([^:]*):?");
	if(searchstring~=nil) then
		_, _, searchstring=string.find(searchstring,"^%s*(.-)%s*$");
		table.insert(parameters,1,{name="name",value=searchstring});
	end
	for i=1,table.getn(parameters),1 do
		if(parameters[i].name=="name") then
			if(string.find(string.lower(skillname),".-"..string.lower(parameters[i].value)..".-")==nil) then
				return false;
			end
		end
		if(parameters[i].name=="reagent") then
			local index=ATSW_GetTradeSkillListPosByName(skillname);
			if(index~=-1) then
				local found=false;
				for j=1,table.getn(atsw_tradeskilllist[index].reagents),1 do
					if(string.find(string.lower(atsw_tradeskilllist[index].reagents[j].name),".-"..string.lower(parameters[i].value)..".-")~=nil) then
						found=true;
					end
				end
				if(found==false) then return false; end
			else
				return false;
			end
		end
		if(parameters[i].name=="minlevel") then
			local index=ATSW_GetTradeSkillListPosByName(skillname);
			if(index~=-1) then
				local level=ATSW_GetItemMinLevel(atsw_tradeskilllist[index].id);
				if(tonumber(parameters[i].value,10)==nil or level==0 or level<tonumber(parameters[i].value,10)) then
					return false;
				end
			else
				return false;
			end
		end
		if(parameters[i].name=="maxlevel") then
			local index=ATSW_GetTradeSkillListPosByName(skillname);
			if(index~=-1) then
				local level=ATSW_GetItemMinLevel(atsw_tradeskilllist[index].id);
				if(tonumber(parameters[i].value,10)==nil or level==0 or level>tonumber(parameters[i].value,10)) then
					return false;
				end
			else
				return false;
			end
		end
		if(parameters[i].name=="minrarity") then
			local index=ATSW_GetTradeSkillListPosByName(skillname);
			if(index~=-1) then
				local rarity=ATSW_GetItemRarity(atsw_tradeskilllist[index].id);
				local reference=ATSWRarityNames[parameters[i].value];
				if(reference==nil or rarity==0 or rarity<reference) then
					return false;
				end
			else
				return false;
			end
		end
		if(parameters[i].name=="maxrarity") then
			local index=ATSW_GetTradeSkillListPosByName(skillname);
			if(index~=-1) then
				local rarity=ATSW_GetItemRarity(atsw_tradeskilllist[index].id);
				local reference=ATSWRarityNames[parameters[i].value];
				if(reference==nil or rarity==0 or rarity>reference) then
					return false;
				end
			else
				return false;
			end
		end
		if(parameters[i].name=="minpossible") then
			local possible=ATSW_GetNumItemsPossibleWithInventory(skillname);
			if(tonumber(parameters[i].value,10)==nil or possible<tonumber(parameters[i].value,10)) then
				return false;
			end
		end
		if(parameters[i].name=="maxpossible") then
			local possible=ATSW_GetNumItemsPossibleWithInventory(skillname);
			if(tonumber(parameters[i].value,10)==nil or possible>tonumber(parameters[i].value,10)) then
				return false;
			end
		end
		if(parameters[i].name=="minpossibletotal") then
			local possible=ATSW_GetNumItemsPossible(skillname);
			if(tonumber(parameters[i].value,10)==nil or possible<tonumber(parameters[i].value,10)) then
				return false;
			end
		end
		if(parameters[i].name=="maxpossibletotal") then
			local possible=ATSW_GetNumItemsPossible(skillname);
			if(tonumber(parameters[i].value,10)==nil or possible>tonumber(parameters[i].value,10)) then
				return false;
			end
		end
	end
	return true;
end

function ATSW_GetItemMinLevel(tradeskillid)
	ATSWScanTooltip:SetOwner(ATSWFrame, "ANCHOR_TOPLEFT");
	ATSWScanTooltip:SetTradeSkillItem(tonumber(tradeskillid,10));
	local linecount=ATSWScanTooltip:NumLines();
	local k;
	for k=1,linecount,1 do
		local ttextLeft = getglobal("ATSWScanTooltipTextLeft"..k);
		if(ttextLeft) then
			local text=ttextLeft:GetText();
			if(text) then
				local _, _, level=string.find(text,ATSW_SCAN_MINLEVEL);
				if(level) then
					ATSWScanTooltip:Hide();
					return tonumber(level,10);
				end
			end
		end
	end
	ATSWScanTooltip:Hide();
	return 0;
end

function ATSW_GetItemRarity(tradeskillid)
	ATSWScanTooltip:SetOwner(ATSWFrame, "ANCHOR_TOPLEFT");
	ATSWScanTooltip:SetTradeSkillItem(tonumber(tradeskillid,10));
	local ttextLeft = getglobal("ATSWScanTooltipTextLeft1");
	if(ttextLeft) then
		local cr,cg,cb=ttextLeft:GetTextColor();
		if(cr) then
			cr=ATSW_Round(cr,2);
			cg=ATSW_Round(cg,2);
			cb=ATSW_Round(cb,2);
			local col;
			for col=1,5,1 do
				if(ATSWRarityColor[col].r==cr and ATSWRarityColor[col].g==cg and ATSWRarityColor[col].b==cb) then
					ATSWScanTooltip:Hide();
					return col;
				end
			end
		end
	end
	ATSWScanTooltip:Hide();
	return 0;
end

function ATSW_Test()
	local stats=GetTradeSkillItemStats(3);
	ATSW_DisplayMessage(stats);
end

function ATSW_ToggleOptionsFrame()
	if(ATSWOptionsFrame:IsVisible()) then
		HideUIPanel(ATSWOptionsFrame);
	else
		if(atsw_multicount==true) then
			ATSWOFUnifiedCounterButton:SetChecked(true);
			ATSWOFSeparateCounterButton:SetChecked(false);
		else
			ATSWOFUnifiedCounterButton:SetChecked(false);
			ATSWOFSeparateCounterButton:SetChecked(true);
		end
		if(atsw_considerbank==true) then
			ATSWOFIncludeBankButton:SetChecked(true);
		else	
			ATSWOFIncludeBankButton:SetChecked(false);
		end
		if(atsw_consideralts==true) then
			ATSWOFIncludeAltsButton:SetChecked(true);
		else	
			ATSWOFIncludeAltsButton:SetChecked(false);
		end
		if(atsw_considermerchants==true) then
			ATSWOFIncludeMerchantsButton:SetChecked(true);
		else	
			ATSWOFIncludeMerchantsButton:SetChecked(false);
		end
		if(atsw_autobuy==true) then
			ATSWOFAutoBuyButton:SetChecked(true);
		else	
			ATSWOFAutoBuyButton:SetChecked(false);
		end
		if(atsw_recipetooltip==true) then
			ATSWOFTooltipButton:SetChecked(true);
		else
			ATSWOFTooltipButton:SetChecked(false);
		end
		if(atsw_displayshoppinglist==true) then
			ATSWOFShoppingListButton:SetChecked(true);
		else
			ATSWOFShoppingListButton:SetChecked(false);
		end
		ShowUIPanel(ATSWOptionsFrame);
	end
end

function ATSW_ToggleCSFrame()
	ShowUIPanel(ATSWCSFrame);
end

-- tooltip functions

atsw_recipetooltip=true;

function ATSW_DisplayTradeskillTooltip()
	if(atsw_recipetooltip==false) then return; end
	ATSWTradeskillTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT",-300);
	ATSWTradeskillTooltip:SetBackdropColor(0,0,0,1);

	local tradeskillid=this:GetID();
	local skillName, skillType, numAvailable;
	local listpos=ATSW_GetSkillListingPos(tradeskillid);
	if(atsw_skilllisting[listpos]) then
		skillName = atsw_skilllisting[listpos].name;
		skillType = atsw_skilllisting[listpos].type;
	else
		skillName=nil;
		akillType=nil;
	end

	if(skillName and skillType ~= "header") then
		ATSWTradeskillTooltip:AddLine(skillName);
		local color=ATSWTypeColor[skillType];
		if(color) then
			ATSWTradeskillTooltipTextLeft1:SetVertexColor(color.r, color.g, color.b);
		end
		ATSWTradeskillTooltip:AddLine(ATSW_GetNumItemsPossibleWithInventory(skillName)..ATSW_TOOLTIP_PRODUCABLE);
		ATSWTradeskillTooltipTextLeft2:SetVertexColor(1, 1, 1);
		ATSWTradeskillTooltip:AddLine(" ");
		ATSWTradeskillTooltip:AddLine(ATSW_TOOLTIP_NECESSARY);

		ATSW_NoteNecessaryItemsForTradeskill(skillName,1);
		for i=1,20,1 do
			if(atsw_necessaryitems[i]) then
				local items_inventory=ATSWInv_GetItemCount(atsw_necessaryitems[i].name);
				local items_bank=ATSWBank_GetItemCount(atsw_necessaryitems[i].name);
				local items_alt=ATSWAlt_GetItemCount(atsw_necessaryitems[i].name);
				local items_missing=items_inventory+items_bank+items_alt-atsw_necessaryitems[i].cnt;
				local items_merchant="";
				if(ATSWMerchant_CheckIfAvailable(atsw_necessaryitems[i].name)==true) then
					items_merchant=ATSW_TOOLTIP_BUYABLE;
				end				
				ATSWTradeskillTooltip:AddLine(atsw_necessaryitems[i].cnt.."x "..atsw_necessaryitems[i].name.." ("..items_inventory.." / "..items_bank.." / "..items_alt..")"..items_merchant);
				local r,g,b=ATSW_GetLinkColorRGB(atsw_necessaryitems[i].link);
				getglobal("ATSWTradeskillTooltipTextLeft"..(4+i)):SetVertexColor(r/256, g/256, b/256);
			end
		end
		ATSWTradeskillTooltip:AddLine(ATSW_TOOLTIP_LEGEND);
		
		ATSWTradeskillTooltip:Show();
	end
end

function ATSW_GetLinkColor(link)
	if(link) then
    		local _,_,color = string.find(link, "^.*|cff(.-)|.*$");
	    	return color;
 	else
    		return nil;
	end
end

function ATSW_GetLinkColorRGB(link)
	if(link) then
		local color=ATSW_HexToDec(ATSW_GetLinkColor(link));
		local r=math.floor(color/65536);
		local g=math.floor((color-r*65536)/256);
		local b=math.floor((color-r*65536-g*256));
		return r,g,b;
	else
		return 0,0,0;
	end
end

-- item count functions

atsw_considerbank=false;
atsw_consideralts=false;
atsw_considermerchants=false;
atsw_multicount=true;

function ATSW_GetItemCountMinusQueuedAndTemporary(itemname)
	if(atsw_temporaryitemlist[itemname]) then
		return ATSW_GetItemCountMinusQueued(itemname)-atsw_temporaryitemlist[itemname];
	else
		return ATSW_GetItemCountMinusQueued(itemname);
	end
end

function ATSW_GetItemCountMinusQueued(itemname)
	local getitemcount=ATSWInv_GetItemCount(itemname);
	if(atsw_considerbank==true) then
		getitemcount=getitemcount+ATSWBank_GetItemCount(itemname);
	end
	if(atsw_considermerchants==true) then
		if(atsw_merchantlist[itemname]) then 
			getitemcount=getitemcount+99999;
		end
	end
	if(atsw_consideralts==true) then
		getitemcount=getitemcount+ATSWAlt_GetItemCount(itemname);
	end
	if(atsw_queueditemlist[itemname]) then
		return getitemcount-atsw_queueditemlist[itemname];
	else
		return getitemcount;
	end
end

-- inventory functions

function ATSWInv_GetItemName(bag, slot)
	local link = GetContainerItemLink(bag, slot);
	if(link) then
    	local _,_,name = string.find(link, "^.*%[(.*)%].*$");
    	return name;
 	else
    	return nil;
    end
end

atsw_itemlist={};
atsw_queueditemlist={};
atsw_temporaryitemlist={};

function ATSWInv_UpdateItemList()
	if(atsw_incombat==true) then return; end
	if(not atsw_itemlist[GetRealmName()]) then
		atsw_itemlist[GetRealmName()]={};
	end
	atsw_itemlist[GetRealmName()][UnitName("player")]={};
	for container=0, 4, 1 do
		for slot=1, GetContainerNumSlots(container), 1 do
			local itemname=ATSWInv_GetItemName(container,slot);
			if(itemname) then
				local _, itemcount=GetContainerItemInfo(container, slot);
				if(atsw_itemlist[GetRealmName()][UnitName("player")][itemname]) then
					atsw_itemlist[GetRealmName()][UnitName("player")][itemname]=atsw_itemlist[GetRealmName()][UnitName("player")][itemname]+itemcount;
				else
					atsw_itemlist[GetRealmName()][UnitName("player")][itemname]=itemcount;
					table.setn(atsw_itemlist[GetRealmName()][UnitName("player")],table.getn(atsw_itemlist[GetRealmName()][UnitName("player")])+1);
				end
			end
		end
	end
	if(ATSWFrame:IsVisible()) then ATSWFrame_Update(); end
end

function ATSWInv_GetItemCount(itemname)
	if(atsw_itemlist[GetRealmName()]) then
		if(atsw_itemlist[GetRealmName()][UnitName("player")]) then
			if(atsw_itemlist[GetRealmName()][UnitName("player")][itemname]) then
				return atsw_itemlist[GetRealmName()][UnitName("player")][itemname];
			end
		end
	end
	return 0;
end

function ATSWInv_UpdateQueuedItemList()
	atsw_queueditemlist={};
	for i=1,table.getn(atsw_queue),1 do
		for j=1,table.getn(atsw_tradeskilllist),1 do
			if(atsw_tradeskilllist[j].name==atsw_queue[i].name) then
				for k=1,table.getn(atsw_tradeskilllist[j].reagents),1 do
					if(atsw_tradeskilllist[j].reagents[k]) then
						if(atsw_queueditemlist[atsw_tradeskilllist[j].reagents[k].name]) then
							atsw_queueditemlist[atsw_tradeskilllist[j].reagents[k].name]=atsw_queueditemlist[atsw_tradeskilllist[j].reagents[k].name]+atsw_tradeskilllist[j].reagents[k].count*atsw_queue[i].count;
						else
							atsw_queueditemlist[atsw_tradeskilllist[j].reagents[k].name]=atsw_tradeskilllist[j].reagents[k].count*atsw_queue[i].count;
							table.setn(atsw_queueditemlist,table.getn(atsw_queueditemlist)+1);
						end
					end
				end
			end
		end
	end	
end

-- bank functions

atsw_bankitemlist={};

function ATSWBank_UpdateBankList()
	if(atsw_bankopened==true) then
		if(not atsw_bankitemlist[GetRealmName()]) then
			atsw_bankitemlist[GetRealmName()]={};
		end
		atsw_bankitemlist[GetRealmName()][UnitName("player")]={};
		for slot=1, 24, 1 do
			local name=ATSWInv_GetItemName(BANK_CONTAINER,slot);
			if(name) then
				local icon, count = GetContainerItemInfo(BANK_CONTAINER, slot);
				ATSWBank_AddToBankList(name,count);
			end
		end
		for container=5, 10, 1 do
			for slot=1, GetContainerNumSlots(container), 1 do
				local name=ATSWInv_GetItemName(container,slot);
				if(name) then
					local icon, count = GetContainerItemInfo(container, slot);
					ATSWBank_AddToBankList(name,count);
				end
			end
		end
	end
end

function ATSWBank_AddToBankList(name,count)
	if(not atsw_bankitemlist[GetRealmName()]) then
		atsw_bankitemlist[GetRealmName()]={};
	end
	if(not atsw_bankitemlist[GetRealmName()][UnitName("player")]) then
		atsw_bankitemlist[GetRealmName()][UnitName("player")]={};
	end
	if(atsw_bankitemlist[GetRealmName()][UnitName("player")][name]) then
		atsw_bankitemlist[GetRealmName()][UnitName("player")][name]=atsw_bankitemlist[GetRealmName()][UnitName("player")][name]+count;
	else
		atsw_bankitemlist[GetRealmName()][UnitName("player")][name]=count;
	end
end

function ATSWBank_GetItemCount(name)
	if(atsw_bankitemlist[GetRealmName()]) then
		if(atsw_bankitemlist[GetRealmName()][UnitName("player")]) then
			if(atsw_bankitemlist[GetRealmName()][UnitName("player")][name]) then
				return atsw_bankitemlist[GetRealmName()][UnitName("player")][name];
			end	
		end
	end
	return 0;
end

-- alternative character functions

atsw_playernames={};

function ATSWAlt_GetItemCount(name)
	return ATSWAlt_GetItemCountInInventory(name)+ATSWAlt_GetItemCountInBank(name);	
end

function ATSWAlt_GetItemCountInInventory(name)
	local itemcount=0;
	if(atsw_itemlist[GetRealmName()]) then
		atsw_playernames={};
		table.foreach(atsw_itemlist[GetRealmName()],ATSWAlt_TableIterator);
		for i=1,table.getn(atsw_playernames),1 do
			if(atsw_itemlist[GetRealmName()][atsw_playernames[i]]) then
				if(atsw_itemlist[GetRealmName()][atsw_playernames[i]][name]) then
					itemcount=itemcount+atsw_itemlist[GetRealmName()][atsw_playernames[i]][name];
				end
			end
		end
	end
	return itemcount;	
end

function ATSWAlt_GetItemCountInBank(name)
	local itemcount=0;
	if(atsw_bankitemlist[GetRealmName()]) then
		atsw_playernames={};
		table.foreach(atsw_bankitemlist[GetRealmName()],ATSWAlt_TableIterator);
		for i=1,table.getn(atsw_playernames),1 do
			if(atsw_bankitemlist[GetRealmName()][atsw_playernames[i]]) then
				if(atsw_bankitemlist[GetRealmName()][atsw_playernames[i]][name]) then
					itemcount=itemcount+atsw_bankitemlist[GetRealmName()][atsw_playernames[i]][name];
				end
			end
		end
	end
	return itemcount;	
end

function ATSWAlt_TableIterator(key,value)
	if(key~=UnitName("player")) then table.insert(atsw_playernames,key); end
end

function ATSWAlt_GetItemLocation(name)
	ATSW_DisplayMessage(ATSW_ALTLIST1..name..ATSW_ALTLIST2);
	if(atsw_itemlist[GetRealmName()]) then
		atsw_playernames={};
		table.foreach(atsw_itemlist[GetRealmName()],ATSWAlt_TableIterator);
		for i=1,table.getn(atsw_playernames),1 do
			if(atsw_itemlist[GetRealmName()][atsw_playernames[i]]) then
				if(atsw_itemlist[GetRealmName()][atsw_playernames[i]][name]) then
					ATSW_DisplayMessage(atsw_itemlist[GetRealmName()][atsw_playernames[i]][name].."x "..ATSW_ALTLIST3..atsw_playernames[i]);
				end
			end
		end
	end
	if(atsw_bankitemlist[GetRealmName()]) then
		atsw_playernames={};
		table.foreach(atsw_bankitemlist[GetRealmName()],ATSWAlt_TableIterator);
		for i=1,table.getn(atsw_playernames),1 do
			if(atsw_bankitemlist[GetRealmName()][atsw_playernames[i]]) then
				if(atsw_bankitemlist[GetRealmName()][atsw_playernames[i]][name]) then
					ATSW_DisplayMessage(atsw_bankitemlist[GetRealmName()][atsw_playernames[i]][name].."x "..ATSW_ALTLIST4..atsw_playernames[i]);
				end
			end
		end
	end
end

-- auction functions

atsw_displayshoppinglist=true;

function ATSWAuction_ShowShoppingList()
	if(AuctionFrame:IsVisible() and table.getn(atsw_queue)>0 and atsw_displayshoppinglist) then
		ATSWShoppingListFrame:Show();
		ATSWShoppingListFrame:SetPoint("TOPLEFT","AuctionFrame","TOPLEFT",353,-436);
		ATSW_NoteNecessaryItemsForQueue();
		ATSWAuction_UpdateReagentList();
	end
end

function ATSWAuction_HideShoppingList()
	ATSWShoppingListFrame:Hide();	
end

function ATSWAuction_UpdateReagentList()
	local reagents=table.getn(atsw_necessaryitems);
	local offset=FauxScrollFrame_GetOffset(ATSWSLScrollFrame);
	for i=1,5,1 do
		local count=getglobal("ATSWSLFReagent"..i.."Count");
		local item=getglobal("ATSWSLFReagent"..i.."Item");
		local inv=getglobal("ATSWSLFReagent"..i.."Inventory");
		local bank=getglobal("ATSWSLFReagent"..i.."Bank");
		local merchant=getglobal("ATSWSLFReagent"..i.."Merchant");
		local alt=getglobal("ATSWSLFReagent"..i.."Alt");
		local missing=getglobal("ATSWSLFReagent"..i.."Missing");
		if(atsw_necessaryitems[offset+i]) then
			local items_inventory=ATSWInv_GetItemCount(atsw_necessaryitems[offset+i].name);
			local items_bank=ATSWBank_GetItemCount(atsw_necessaryitems[offset+i].name);
			local items_alt=ATSWAlt_GetItemCount(atsw_necessaryitems[offset+i].name);
			local items_missing=items_inventory+items_bank+items_alt-atsw_necessaryitems[offset+i].cnt;
			local items_merchant=ATSWMerchant_CheckIfAvailable(atsw_necessaryitems[offset+i].name);
			count:SetText(atsw_necessaryitems[offset+i].cnt.."x");
			count:Disable();
			count:Show();
			item:SetText("["..atsw_necessaryitems[offset+i].name.."]");
			item.link=atsw_necessaryitems[offset+i].link;			
			item.itemname=atsw_necessaryitems[offset+i].name;
			item:Show();
			inv:SetText(items_inventory);
			inv:Disable();
			inv:Show();
			if(items_inventory>=atsw_necessaryitems[offset+i].cnt) then
				inv:SetTextColor(0,1,0);
			else
				inv:SetTextColor(1,0,0);
			end
			bank:SetText(items_bank);
			bank:Disable();
			bank:Show();
			if(items_bank>=atsw_necessaryitems[offset+i].cnt) then
				bank:SetTextColor(0,1,0);
			else
				bank:SetTextColor(1,0,0);
			end
			merchant:SetText("X");
			merchant:Disable();
			if(items_merchant==true) then
				merchant:Show();
			else
				merchant:Hide();
			end
			alt:SetText(items_alt);
			if(items_alt>0) then
				alt:Enable();
				alt.itemname=atsw_necessaryitems[offset+i].name;
			else
				alt:Disable();
			end
			alt:Show();
			if(items_alt>=atsw_necessaryitems[offset+i].cnt) then
				alt:SetTextColor(0,1,0);
			else
				alt:SetTextColor(1,0,0);
			end
			if(items_missing>=0) then
				missing:SetText("+"..items_missing);
				missing:SetTextColor(0,1,0);
			else
				missing:SetText(items_missing);
				missing:SetTextColor(1,0,0);
			end
			missing:Disable();
			missing:Show();
		else
			count:Hide();
			item:Hide();
			inv:Hide();
			bank:Hide();
			merchant:Hide();
			alt:Hide();
			missing:Hide();
		end
	end
	FauxScrollFrame_Update(ATSWSLScrollFrame, reagents, 5, 5);
end

function ATSWAuction_SearchForItem(itemname)
	if(CanSendAuctionQuery()) then
		BrowseName:SetText(itemname);
		AuctionFrameBrowse_Search();
		BrowseNoResultsText:SetText(BROWSE_NO_RESULTS);
	end
end

-- merchant functions

atsw_autobuy=false;
atsw_merchantlist={};

function ATSWMerchant_InsertAutoBuyButton()
	if(table.getn(atsw_queue)==0) then return; end
	if(ATSWMerchant_Buy(true)==false) then return; end
	ATSWAutoBuyButtonFrame:Show();
	ATSWAutoBuyButtonFrame:SetPoint("TOPLEFT", "MerchantFrame", "TOPLEFT" , 60, -28);
	ATSWAutoBuyButtonFrame:SetFrameStrata("HIGH");
end

function ATSWMerchant_RemoveAutoBuyButton()
	ATSWAutoBuyButtonFrame:Hide();
end

function ATSWMerchant_ExecuteAutoBuy()
	ATSWMerchant_RemoveAutoBuyButton();
	ATSWMerchant_Buy();
end

function ATSWMerchant_UpdateMerchantList()
	if(MerchantFrame:IsVisible()) then
		local numitems=GetMerchantNumItems();
		if(numitems==148) then numitems=0; end
		for i=1,numitems,1 do
			local itemname=ATSWMerchant_GetItemName(i);
			if(itemname) then
				local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(i);
				if(numAvailable==-1) then
					atsw_merchantlist[itemname]=true;
				end
			end
		end
	end
end

function ATSWMerchant_GetItemName(slot)
	local link = GetMerchantItemLink(slot);
	if(link) then
    	local _,_,name = string.find(link, "^.*%[(.*)%].*$");
    	return name;
 	else
    	return nil;
    end
end

function ATSWMerchant_CheckIfAvailable(itemname)
	if(atsw_merchantlist[itemname]) then
		return true;
	else
		return false;
	end
end

function ATSWMerchant_AutoBuy()
	if(atsw_autobuy==true) then
		ATSWMerchant_Buy();
	end
end

function ATSWMerchant_Buy(onlyCheck)
	local needtobuy=false;
	if(table.getn(atsw_queue)>0) then
		if(MerchantFrame:IsVisible()) then
			ATSW_NoteNecessaryItemsForQueue();
			autobuymessage=false;
			local numitems=GetMerchantNumItems();
			if(numitems==148) then numitems=0; end
			for i=1,numitems,1 do
				local itemname=ATSWMerchant_GetItemName(i);
				if(itemname) then
					for k=1,table.getn(atsw_necessaryitems),1 do
						if(atsw_necessaryitems[k]) then
							if(atsw_necessaryitems[k].name==itemname) then
								local stilltobuy=atsw_necessaryitems[k].cnt-ATSWInv_GetItemCount(itemname);
								if(stilltobuy>0) then
									local name, texture, price, quantity, numAvailable, isUsable = GetMerchantItemInfo(i);
									local itemid = ATSW_GetItemID(GetMerchantItemLink(i));
									local sName, sLink, iQuality, iLevel, sType, sSubType, iCount = GetItemInfo(itemid);
									local itemstobuy=math.ceil(stilltobuy/quantity);
									if(onlyCheck==nil or onlyCheck==false) then
										if(iCount==nil) then
											for l=1,itemstobuy,1 do
												BuyMerchantItem(i,1);
											end
										else
											local fullstackstobuy=math.floor(stilltobuy/iCount);
											local fullstackitemcount=math.floor(iCount/quantity);
											local resttobuy=math.ceil((stilltobuy-(fullstackstobuy*iCount))/quantity);
											if(fullstackstobuy>0) then
												for l=1,fullstackstobuy,1 do
													BuyMerchantItem(i,fullstackitemcount);
												end
											end
											if(resttobuy>0) then
												BuyMerchantItem(i,resttobuy);
											end
										end
										if(autobuymessage==false) then
											ATSW_DisplayMessage(ATSW_AUTOBUYMESSAGE);
											autobuymessage=true;
										end
										local totalprice=price*itemstobuy;
										local gold=math.floor(totalprice/10000);
										local silver=math.floor((totalprice-gold*10000)/100);
										local copper=math.mod(totalprice,100);
										local moneystring="";
										if(gold>0) then
											moneystring=gold.."g "..silver.."s "..copper.."c";
										elseif(silver>0) then
											moneystring=silver.."s "..copper.."c";
										else
											moneystring=copper.."c";
										end
										ATSW_DisplayMessage((itemstobuy*quantity).."x "..GetMerchantItemLink(i).." ("..moneystring..")");
									else
										needtobuy=true;
									end
								end
							end
						end
					end
				end
			end
		end
	end
	return needtobuy;
end

-- general utility functions

function ATSW_DisplayMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function ATSW_HexToDec(hex)
	hex=string.upper(hex);
	local total=0;
	for i=1,string.len(hex),1 do
		local char=string.byte(hex,i);
		local numeric;
		if(char>64) then
			numeric=char-55;
		else
			numeric=char-48;
		end
		total=total+numeric*math.pow(16,string.len(hex)-i);
	end
	return total;
end

function ATSW_GetItemID(link)
	if(link) then
		local _,_,id = string.find(link, "^.*|Hitem:(%d*):.*%[.*%].*$");
		return id;
	else
		return nil;
	end
end

function ATSW_Round(number,decimals)
	return math.floor((number*math.pow(10,decimals)+0.5))/math.pow(10,decimals);
end