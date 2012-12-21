function tradeDispenser_Banlist_OnShow()
	tradeDispenser_Banlist_Update()
	if (UnitIsPlayer("target") and UnitIsFriend("target", "player")) then
		tradeDispenserBanlistName:SetText(UnitName("target"));
	else
		tradeDispenserBanlistName:SetText("");
	end
	if (GetNumIgnores()>0) then
		local i;
		local New = false;
		for	i=1,GetNumIgnores() do
			local j;
			local found = false;
			for j=1,table.getn(tD_GlobalDatas.Bannlist) do
				if (strlower(tD_GlobalDatas.Bannlist[j])==strlower(GetIgnoreName(i))) then
					found=true;
				end
			end
			if (not found) then New=true end
		end
		if (New) then
			tradeDispenserBanlistImport:Enable();
		else
			tradeDispenserBanlistImport:Disable();
		end
	else
		tradeDispenserBanlistImport:Disable();
	end
	tradeDispenserBanlistAdd:Disable();
	tradeDispenserBanlistRemove:Disable();
	tradeDispenser_Banlist_Edit(tradeDispenserBanlistName);
end


function tradeDispenser_Banlist_Update()
	local H = 0;
	if (tradeDispenserSettings and tradeDispenserSettings:IsVisible()) then
		H = 2+tradeDispenserSettingsText:GetHeight()
	end
	tradeDispenserBanlist:SetHeight(346+H);
	tradeDispenserBanlistScrollBkg:SetHeight(206+H);
	tradeDispenserBanlistScrollBar:SetHeight(206+H);
	tD_Temp.Scroll.maxlines = math.floor((206+H)/12.25);
	if (tD_GlobalDatas.Bannlist) then table.sort(tD_GlobalDatas.Bannlist) end
	tradeDispenser_Banlist_Scroll()
end


function tradeDispenser_Banlist_Scroll()
	if (not tD_Temp.Scroll.maxlines) then return end
	if (not tD_GlobalDatas.Bannlist) then 
		tradeDispenserBanlistScrollText:SetText("");
		tradeDispenserBanlistScrollBar:Hide();
		return 
	end
	tD_Temp.Scroll.start = tradeDispenserBanlistScrollBar:GetValue();
	tD_Temp.Scroll.ende = table.getn(tD_GlobalDatas.Bannlist);
	if (tD_Temp.Scroll.ende > tD_Temp.Scroll.maxlines) then
		tradeDispenserBanlistScrollBar:Show();
		tradeDispenserBanlistScrollBar:SetMinMaxValues(1, table.getn(tD_GlobalDatas.Bannlist)-tD_Temp.Scroll.maxlines+1);		
		tD_Temp.Scroll.ende = tD_Temp.Scroll.start + tD_Temp.Scroll.maxlines-1;
	else
		tD_Temp.Scroll.start=1;
		tradeDispenserBanlistScrollBar:Hide();
	end
	
	local temp="";	
	local i;
	for i = tD_Temp.Scroll.start,tD_Temp.Scroll.ende do
		temp=temp.." \n "..tD_GlobalDatas.Bannlist[i];
	end
	tradeDispenserBanlistScrollText:SetText(temp);
	
end


function tradeDispenser_Banlist_Edit(Editbox)
	if (not Editbox) then return end
	if (not tD_Temp.BanListStatus) then tD_Temp.BanListStatus="inactive"; end
	local name = strlower( Editbox:GetText() );
	string.gsub(name," ","");
	if (strlen(name)<1) then
		tradeDispenserBanlistAdd:Disable();
		tradeDispenserBanlistRemove:Disable();
		tD_Temp.BanListStatus="inactive";
	else
		tradeDispenserBanlistAdd:Enable();
		tradeDispenserBanlistRemove:Disable();
		tD_Temp.BanListStatus="add";
		
		if (tD_GlobalDatas.Bannlist) then 
			local j;
			local found = false;
			for j=1,table.getn(tD_GlobalDatas.Bannlist) do
				if (strlower(tD_GlobalDatas.Bannlist[j])==name) then
					found=true;
				end
			end
			if (found) then
				tradeDispenserBanlistAdd:Disable();
				tradeDispenserBanlistRemove:Enable();
				tD_Temp.BanListStatus="remove";
			end
		end
	end
end


function tradeDispenser_Banlist_Remove(name)
	local j;
	local found = 0;
	for j=1,table.getn(tD_GlobalDatas.Bannlist) do
		if (strlower(tD_GlobalDatas.Bannlist[j])==strlower(name)) then
			found=j;
		end
	end
	if (found>0) then
		table.remove(tD_GlobalDatas.Bannlist,found);
		tradeDispenserVerbose(1,"remove index "..found..": Name="..name);
	else
		tradeDispenserVerbose(1,"Name "..name.."  not found");
	end
	tradeDispenserBanlistName:SetText("");
	tradeDispenserBanlistRemove:Disable();
	tradeDispenserBanlistAdd:Disable();
	tD_Temp.BanListStatus="inactive";
	tradeDispenser_Banlist_Scroll()
end

function tradeDispenser_Banlist_Add(name)
	--tradeDispenserVerbose(0,"Add");
	if (name) then
		table.insert(tD_GlobalDatas.Bannlist,name);
		tradeDispenserVerbose(1,"Added Name "..name.." to Banlist");
	end
	table.sort(tD_GlobalDatas.Bannlist)
	tradeDispenserBanlistRemove:Enable();
	tradeDispenserBanlistAdd:Disable();
	tD_Temp.BanListStatus="remove";
	tradeDispenser_Banlist_Scroll()
end


function tradeDispenser_Banlist_Import()
	if (GetNumIgnores()>0) then
		local i;
		for	i=1,GetNumIgnores() do
			local j;
			local found = false;
			for j=1,table.getn(tD_GlobalDatas.Bannlist) do
				if (strlower(tD_GlobalDatas.Bannlist[j])==strlower(GetIgnoreName(i))) then
					found=true;
				end
			end
			if (not found) then 
				table.insert(tD_GlobalDatas.Bannlist,GetIgnoreName(i));
				tradeDispenserVerbose(1,"Added Name "..GetIgnoreName(i).." to Banlist");
			end
		end
	end
	table.sort(tD_GlobalDatas.Bannlist)	
	tradeDispenserBanlistImport:Disable();
	tradeDispenser_Banlist_Scroll()
end
