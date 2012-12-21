function DuelInspect_OnLoad()

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("DUEL_REQUESTED");

	DI_STATICPOPUP_HEIGHT = ceil(getglobal("StaticPopup1"):GetHeight());
	
	oldStaticPopupOnHide = StaticPopup_OnHide;
	StaticPopup_OnHide = DuelInspect_StaticPopup_OnHide;
	
	oldStartDuelUnit = StartDuelUnit;
	StartDuelUnit = DuelInspect_StartDuelUnit;

	if ( DI_SAVE == nil ) then
		DI_SAVE = {};
		DI_SAVE.ShowBuffs = true;
		DI_SAVE.ShowResistances = true;
		DI_SAVE.ShowItemsQuality = true;
		DI_SAVE.ShowUsableItems = true;
		DI_SAVE.OutboundDuels = true;
	end
	
end












function DuelInspect_OnEvent(event)
	
	local challengeFound = false;
	
	if (event == "DUEL_REQUESTED") then
		for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
			local frame = getglobal("StaticPopup"..index);
			if ( frame:IsVisible() and frame.which == "DUEL_CHALLENGE" ) then
				challengeFound = true;
				break;
			end
		end
		
		
		if ( challengeFound ) then
			StaticPopup_Hide("DUEL_CHALLENGE");
		end

		DuelInspect_UpdateStaticPopup();

	end

end











function DuelInspect_StartDuelUnit()
	
	local duelRequested = false;
	
	for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
		local frame = getglobal("StaticPopup"..index);
		if ( frame:IsVisible() and frame.which == "DUEL_REQUESTED") then
			duelRequested = true;
			break;
		end
	end	
		
	if ( IsShiftKeyDown() or not DI_SAVE.OutboundDuels ) then
		oldStartDuelUnit("target");
		
	elseif ( not duelRequested ) then
	
		StaticPopupDialogs["DUEL_CHALLENGE"] = {
			text = UnitName("target").." - "..DI_TEXT_CONFIRMDUEL,
			button1 = DUEL,
			button2 = TEXT(CANCEL),
			sound = "igPlayerInvite",
			OnAccept = function()
				DuelInspect_TargetOpponent();	oldStartDuelUnit("target");
			end,
			OnCancel = function()
				StaticPopup_Hide("DUEL_CHALLENGE");
			end,
			timeout = 0,
			hideOnEscape = 1
		};

		StaticPopup_Show("DUEL_CHALLENGE", "target");
		
		DuelInspect_UpdateStaticPopup();
		DuelInspect_TargetOpponent();
		
	else
		UIErrorsFrame:AddMessage(DI_TEXT_ALREADYCHALLENGED, 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
	end
	
end








function DuelInspect_StaticPopup_OnHide()
	
	local doHide = true;
	
	for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
		local frame = getglobal("StaticPopup"..index);
		if ( frame:IsVisible() and (frame.which == "DUEL_REQUESTED" or frame.which == "DUEL_CHALLENGE") ) then
			doHide = false;
			break;
		end
	end
	
	for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
		frame = getglobal("StaticPopup"..index);
		frame:SetFrameStrata("DIALOG");	
	end
		
	if ( doHide ) then
		getglobal("DuelInspect_TargetButton"):Hide();
		getglobal("DuelInspect_ResistanceFrame"):Hide();
		getglobal("DuelInspect_UnitBuffFrame"):Hide();
		getglobal("DuelInspect_ItemQualityFrame"):Hide();
		getglobal("DuelInspectFrame"):Hide();
		getglobal("DuelInspect_OptionsFrame"):Hide();
		for cnt = 1, 4 do
			getglobal("DuelInspect_UseItem"..cnt.."Frame"):Hide();
		end
	end
	
	oldStaticPopupOnHide();
	
end













function DuelInspect_ShowItemTooltip(itemlink)
	
	if (itemlink) then
		GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		GameTooltip:SetHyperlink(itemlink);
		GameTooltip:Show();
	end	
	
end












function DuelInspect_ShowBuffTooltip(buffId)
	
	oppFound, origTarget = DuelInspect_TargetOpponent();
	
	if ( oppFound ) then
		
		for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
			local frame = getglobal("StaticPopup"..index);
			if ( frame:IsVisible() and (frame.which == "DUEL_REQUESTED" or frame.which == "DUEL_CHALLENGE") ) then
				DuelInspect_UpdateBuffs(index);
				getglobal("DuelInspect_Buff"..buffId.."Texture"):SetTexture(UnitBuff("target", buffId));
			end
		end
		
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
		GameTooltip:SetUnitBuff("target", buffId);
		GameTooltip:Show();
		
		if ( origTarget ~= UnitName("target") ) then
			TargetLastTarget();
		end			
	end
end








function DuelInspect_UpdateOptionsFrame(this,index)

	if ( index > 1 ) then
		getglobal("StaticPopup"..index-1):SetFrameStrata("MEDIUM");	
	end

	local newWidth = getglobal("StaticPopup"..index.."Text"):GetStringWidth();
	getglobal("DuelInspect_OptionsFrame"):SetWidth(ceil(newWidth));

	if ( GetMouseFocus() and GetMouseFocus():GetName() ) then
	
		local kids = { this:GetChildren() };
	
		if ( string.sub(GetMouseFocus():GetName(), 0, 24 ) == this:GetName() ) then
			
 			if ( index > 1 ) then
				if ( getglobal("StaticPopup"..(index-1).."Button1") ) then getglobal("StaticPopup"..(index-1).."Button1"):SetFrameStrata("MEDIUM");	end
				if ( getglobal("StaticPopup"..(index-1).."Button2") ) then getglobal("StaticPopup"..(index-1).."Button2"):SetFrameStrata("MEDIUM"); end	
			end
			
			this:SetAlpha( this:GetAlpha() + 0.04 );
			
			local point, relativeTo, relativePoint, xofs, yofs = this:GetPoint();
		
			if ( yofs <= 68 ) then
				this:SetHeight( this:GetHeight() + 3.5 );
				this:SetPoint ( point, relativeTo, relativePoint, xofs, yofs + 3.5 );
			else
				for _,child in ipairs(kids) do
					child:Show();
				end
			end
		else
			
			if ( this:GetAlpha() >= 0.3 ) then
				this:SetAlpha( this:GetAlpha() - 0.04 );
				for _,child in ipairs(kids) do
					child:Hide();
				end
			else
	 			if ( index > 1 ) then
					if ( getglobal("StaticPopup"..(index-1).."Button1") ) then getglobal("StaticPopup"..(index-1).."Button1"):SetFrameStrata("DIALOG");	end
					if ( getglobal("StaticPopup"..(index-1).."Button2") ) then getglobal("StaticPopup"..(index-1).."Button2"):SetFrameStrata("DIALOG");	end
				end
			end
			
			local point, relativeTo, relativePoint, xofs, yofs = this:GetPoint();
			
			if ( yofs >= 23 ) then
				this:SetHeight( this:GetHeight() - 3.5 );
				this:SetPoint ( point, relativeTo, relativePoint, xofs, yofs - 3.5 );
			end
		end
		
	end
end








function DuelInspect_UpdateStaticPopupSize(index)

	local kids = { getglobal("StaticPopup"..index):GetChildren() };
	local kidsHeight = {};
	
	for _,child in ipairs(kids) do
		if ( ( strfind( child:GetName(), "DuelInspect") ) and ( child:GetBottom() ) and ( child:IsVisible() ) ) then
			table.insert ( kidsHeight, child:GetBottom() );
		end
	end
	  
	table.sort(kidsHeight, function(a,b) return a<b end)
	 
	for cnt = 2, table.getn(kidsHeight) do
		table.remove(kidsHeight, cnt);
	end

	for key,val in kidsHeight do
		if ( val < ( getglobal("StaticPopup"..index):GetTop() - DI_STATICPOPUP_HEIGHT ) ) then
		
			newHeight = ( getglobal("StaticPopup"..index):GetTop() - val ) + 20;
			newStringWidth = getglobal("StaticPopup"..index.."Text"):GetStringWidth() + 5;
			newWidth = newStringWidth + 120;
		
			if ( DI_SAVE.ShowBuffs ) then newWidth = newWidth + 40; end
			if ( DI_SAVE.ShowResistances ) then newWidth = newWidth + 40; end
		
			getglobal("StaticPopup"..index.."Text"):SetWidth(ceil(newStringWidth));
			getglobal("StaticPopup"..index):SetWidth(ceil(newWidth));
			getglobal("StaticPopup"..index):SetHeight(ceil(newHeight));
			
		end
	end    
end













function DuelInspect_ScanResist(line)
    local value, token, pos, tmpStr;

    while(string.len(line) > 0) do
        pos = string.find(line, "/", 1, true);
        if(pos) then
            tmpStr = string.sub(line,1,pos-1);
            line = string.sub(line,pos+1);
        else
            tmpStr = line;
            line = "";
        end

        tmpStr = string.gsub( tmpStr, "^%s+", "" );
           tmpStr = string.gsub( tmpStr, "%s+$", "" );
        tmpStr = string.gsub( tmpStr, "%.$", "" );

        _, _, value, token = string.find(tmpStr, "^%+(%d+)%%?(.+)$");
        if(not value) then
            _, _,  token, value = string.find(tmpStr, "^(.+)%+(%d+)%%?$");
        end


        if(token and value) then
            token = string.gsub( token, "^%s+", "" );
            token = string.gsub( token, "%s+$", "" );
            token = string.gsub( token, "%.$", "" );
						return token, value;
        end
    end
    return nil, nil;
end    












function DuelInspect_GetDifficultyColor(level)
	local levelDiff = level - UnitLevel("player");
	local color;
	if ( levelDiff >= 5 ) then
		color = "|cffff0000";
	elseif ( levelDiff >= 3 ) then
		color = "|cffff6600";
	elseif ( levelDiff >= -2 ) then
		color = "|cffffff00";
	elseif ( -levelDiff <= GetQuestGreenRange() ) then
		color = "|cff00ff00";
	else
		color = "|cff888888";
	end
	return color;
end













function DuelInspect_PrepareFrames(index,initOptions)
	
	getglobal("DuelInspect_TargetButton"):SetParent("StaticPopup"..index);
	getglobal("DuelInspect_TargetButton"):SetPoint("LEFT", "StaticPopup"..index.."Button1", "BOTTOMRIGHT" , -64, -13);
	getglobal("DuelInspect_TargetButton"):SetText(DI_TEXT_TARGET);
	getglobal("DuelInspect_TargetButton"):Show();		
	

	getglobal("DuelInspect_ResistanceFrame"):SetParent("StaticPopup"..index);
	getglobal("DuelInspect_ResistanceFrame"):SetPoint("TOP", "StaticPopup"..index, "TOPRIGHT" , -31, 75);
	if ( DI_SAVE.ShowResistances ) then
		getglobal("DuelInspect_ResistanceFrame"):Show();
	end

	getglobal("DuelInspect_UnitBuffFrame"):SetParent("StaticPopup"..index);
	getglobal("DuelInspect_UnitBuffFrame"):SetPoint("TOP", "StaticPopup"..index, "TOPLEFT" , 46, 75);
	getglobal("DuelInspect_Buff1Frame"):SetPoint("LEFT", "DuelInspect_UnitBuffFrame", "LEFT");			
	if ( DI_SAVE.ShowBuffs ) then
		getglobal("DuelInspect_UnitBuffFrame"):Show();
	end

	for cnt = 1, 4 do
		getglobal("DuelInspect_UseItem"..cnt.."Frame"):SetParent("StaticPopup"..index);
	end

	if ( DI_SAVE.ShowUsableItems ) then	
		for cnt = 1, 4 do
			getglobal("DuelInspect_UseItem"..cnt.."Frame"):Show();
		end
	end	

	getglobal("DuelInspect_ItemQualityFrame"):SetParent("StaticPopup"..index);
	getglobal("DuelInspect_ItemQualityFrame"):SetPoint("TOP", "StaticPopup"..index.."Text", "BOTTOM", 0, -13);	
	
	if ( DI_SAVE.ShowItemsQuality ) then
		getglobal("DuelInspect_ItemQualityFrame"):Show();
	end
	

	
	if ( initOptions ) then
		getglobal("DuelInspect_OptionsFrame"):SetHeight(39);
		getglobal("DuelInspect_OptionsFrame"):SetWidth(275);
		getglobal("DuelInspect_OptionsFrame"):SetAlpha(0.5);
		getglobal("DuelInspect_OptionsFrame"):SetPoint("TOP", "StaticPopup"..index, "TOP" , 0, 21.99);
		getglobal("DuelInspect_OptionsFrame"):Show();
	end
	
	getglobal("DuelInspectFrame"):Show();

	getglobal("DuelInspect_OptionsFrame_CheckButton1"):SetChecked(DI_SAVE.ShowBuffs);
	getglobal("DuelInspect_OptionsFrame_CheckButton2"):SetChecked(DI_SAVE.ShowResistances);
	getglobal("DuelInspect_OptionsFrame_CheckButton3"):SetChecked(DI_SAVE.ShowItemsQuality);
	getglobal("DuelInspect_OptionsFrame_CheckButton4"):SetChecked(DI_SAVE.ShowUsableItems);
	getglobal("DuelInspect_OptionsFrame_CheckButton5"):SetChecked(DI_SAVE.OutboundDuels);
	
	local point, relativeTo, relativePoint, xofs, yofs = getglobal("StaticPopup"..index.."Button1"):GetPoint();		
	
	if ( DI_SAVE.ShowUsableItems and getn(DI_ITEMUSES) > 0 ) then
		getglobal("StaticPopup"..index.."Button1"):SetPoint(point, "DuelInspect_UseItem"..getn(DI_ITEMUSES).."Text", relativePoint, xofs, yofs);	
		if ( not DI_SAVE.ShowItemsQuality ) then
			getglobal("DuelInspect_UseItem1Frame"):SetPoint("TOP", "StaticPopup"..index.."Text", "BOTTOM" , 0, -13);
			getglobal("DuelInspect_UseItem1Text"):SetPoint("TOP", "StaticPopup"..index.."Text", "BOTTOM" , 0, -13);
		else
			getglobal("DuelInspect_UseItem1Frame"):SetPoint("TOP", "DuelInspect_ItemQualityFrame", "BOTTOM" , 0, -13);
			getglobal("DuelInspect_UseItem1Text"):SetPoint("TOP", "DuelInspect_ItemQualityFrame", "BOTTOM" , 0, -13);
		end
	elseif ( DI_SAVE.ShowItemsQuality ) then
		getglobal("StaticPopup"..index.."Button1"):SetPoint(point, "DuelInspect_ItemQualityFrame", relativePoint, xofs, yofs)
	else
		getglobal("StaticPopup"..index.."Button1"):SetPoint(point, "StaticPopup"..index.."Text", relativePoint, xofs, yofs);	
	end
	
	
end













function DuelInspect_TargetOpponent()
	for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
	
		local frame = getglobal("StaticPopup"..index);
		
		if ( frame:IsVisible() and (frame.which == "DUEL_REQUESTED" or frame.which == "DUEL_CHALLENGE") ) then
			
			local orig_text = getglobal("StaticPopup"..index.."Text"):GetText();
			local textpos = string.find(orig_text, " ");
			name = string.sub(orig_text, 0, ( textpos - 1 ) );	
			
			
			origTarget = UnitName("target");
			TargetByName(name);
			
			if ( name ~= UnitName("target") ) then
				ClearTarget();
				return false, origTarget;
			else
				return true, origTarget;
			end
		end
	end
end











function DuelInspect_UpdateBuffs(index)
	i = 1;
	while (UnitBuff("target", i, 1)) do
		getglobal("DuelInspect_Buff"..i.."Texture"):SetTexture(UnitBuff("target", i));
		i = i + 1;
	end
	
	for cnt = i, 10 do
			
		if (UnitBuff("target", cnt)) then
			getglobal("DuelInspect_Buff"..cnt.."Texture"):SetTexture(UnitBuff("target", cnt));
		else
			getglobal("DuelInspect_Buff"..cnt.."Texture"):SetTexture(nil);
		end
	end
end












function DuelInspect_UpdateStaticPopup()

	for index = 1, STATICPOPUP_NUMDIALOGS, 1 do
		local frame = getglobal("StaticPopup"..index);
		if ( frame:IsVisible() and (frame.which == "DUEL_REQUESTED" or frame.which == "DUEL_CHALLENGE") ) then

			
			DuelInspect_TargetOpponent();
			DuelInspect_UpdateData(index,false);
			DuelInspect_PrepareFrames(index,true);
			
		end
	end
end







function DuelInspect_UpdateData(index,keepTarget)

	local orig_text = getglobal("StaticPopup"..index.."Text"):GetText();
	
	if ( strfind(orig_text,"\n") ) then
		orig_text = strsub(orig_text,0,(strfind(orig_text,"\n")-1));
	end
	
	local playerClass, class = UnitClass("target");
	local level = UnitLevel("target");
	local race = UnitRace("target");
	local rankName, rankNumber = GetPVPRankInfo(UnitPVPRank("target"), "target");
	local guildName, guildRankName, guildRankIndex = GetGuildInfo("target");
	
	if ( not rankName ) then
		rankName = DI_TEXT_NORANK;
		rankNumber = "";
	else
		rankNumber = rankNumber..".";
	end
	
	
	if ( not guildName )  then
		di_guildtext = "|cffffffff"..DI_TEXT_NOGUILD;
	else
		di_guildtext = "|cffffffff"..guildRankName.." of <"..guildName..">";
	end
		
	
	DuelInspect_UpdateBuffs(index);

  local quality_count = {
  		[0] = 0,
  		[1] = 0,
      [2] = 0,
      [3] = 0,
      [4] = 0,
      [5] = 0,
      [6] = 0 };
      
	local DI_RESISTANCES_COUNT = {
		["ARCRES"] = 0,
		["FIRERES"] = 0,
		["NATRES"] = 0,
		["FROSTRES"] = 0,
		["SHADRES"] = 0
	};
	
	local DI_OTHERS_COUNT = {
		["ARMOR"] = 0
	};
	
	useItemLink = {
		[1] = nil,
		[2] = nil,
		[3] = nil,
		[4] = nil
	};
    
	DI_ITEMUSES = {};  
  
  for cnt = 0, 18 do
  	if ( cnt ~= 4 ) then
			link = GetInventoryItemLink("target", cnt);
  		if ( link ) then
    		local _, _, itemCode = strfind(link, "(%d+):");
    		local __, itemLink, quality = GetItemInfo(itemCode);

        quality_count[quality] = quality_count[quality] + 1;
        
		    GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR");
				GameTooltip:SetHyperlink(itemLink);
				GameTooltip:Show();
				
				for i=1,GameTooltip:NumLines() do
					local itemtext = getglobal("GameTooltipTextLeft" .. i):GetText();
					local token, value = DuelInspect_ScanResist(itemtext); 
					
					if ( itemtext ) then
            local strpos = strfind(itemtext, " ");
            if ( strpos and strsub(itemtext,(strpos+1)) == DI_OTHERS["ARMOR"] ) then
            	if ( strfind(strsub(itemtext,0,strpos), '%d') ) then
            		DI_OTHERS_COUNT["ARMOR"] = DI_OTHERS_COUNT["ARMOR"] + strsub(itemtext,0,strpos);
             	end
			      elseif ( strpos and ( strsub(itemtext,0,(strpos-1)) == DI_OTHERS["USE"] ) ) then
			      	table.insert ( DI_ITEMUSES, cnt );
            end
          end
					
					if ( token and value ) then
									
						for key,val in DI_RESISTANCES do
			       		if ( val == token ) then
			       			DI_RESISTANCES_COUNT[key] = DI_RESISTANCES_COUNT[key] + value;
			       		end
			   		end						   					
					end						
				end
				
				GameTooltip:Hide(); 
        
    	end	
  	end
  end
  
  
	di_quality = "";
	
  for key,value in quality_count do
  	if ( value > 0 ) then
  		r, g, b, hex = GetItemQualityColor(key);
  		di_quality = di_quality.."|cffffffff"..value.."x"..hex..DI_TEXT_QUALITY[key].." ";
  	end
  end

	cnt = 1;
	

	
	for key,val in DI_ITEMUSES do
		useItem = GetInventoryItemLink("target", val);
		
		getglobal("DuelInspect_UseItem"..cnt.."Text"):SetText(DI_OTHERS["USE"]..cnt..": "..useItem);
		
		local _, _, itemCode = strfind(useItem, "(%d+):");
		__, useItemLinkTmp = GetItemInfo(itemCode);
		useItemLink[cnt] = useItemLinkTmp;		  		
		cnt = cnt + 1;
	end
		
	
	for cnt = cnt, 4 do
		getglobal("DuelInspect_UseItem"..cnt.."Text"):SetText("");
		useItemLink[cnt] = nil;
	end



	for key,val in DI_RESISTANCES_COUNT do
	 		if ( val > 0 ) then
	 			getglobal("DuelInspect_Res_"..key.."_Text"):SetText("|cff6ef028+"..val);
	 		else
	 			getglobal("DuelInspect_Res_"..key.."_Text"):SetText("");
	 		end
	end
	
	if ( not keepTarget ) then
		TargetLastTarget();
	end
				
	getglobal("DuelInspect_ItemQualityFrameText"):SetText(di_quality);
	
	local di_playertext = DuelInspect_GetDifficultyColor(level)..""..level.." |cffffffff"..race.." "..TEXT_CLASS_COLORS[class]..playerClass.." |cffffffff- |cffcccc00"..rankNumber.." "..rankName;
	local new_text = orig_text.."\n\n"..di_playertext.."\n"..di_guildtext;	
	getglobal("StaticPopup"..index.."Text"):SetText(new_text);

end


















