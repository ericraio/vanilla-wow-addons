
-- array holding bars
SW_Bars = {};

SW_BARSEPX = 5;
SW_BARSEPY = 3;

function SW_BarRegister(oB)

	local pName = oB:GetParent():GetName();
	
	if SW_Bars[pName] == nil then SW_Bars[pName] = {}; end
	
	table.insert(SW_Bars[pName], oB);
end

function SW_SelOpt(optButton)
	local wasShown = false;
	if SW_BarSettingsFrameV2:IsVisible() then
		wasShown= true;
		SW_BarSettingsFrameV2:Hide();
		if ColorPickerFrame:IsVisible() then 
			ColorPickerFrame:Hide();
		end
	end
	local cont = optButton:GetParent():GetParent():GetName();
	
	SW_Settings["BarFrames"][cont]["Selected"] = optButton.optID;
	SW_OptUpdateText(cont);
	SW_BarsLayout(cont, true);
	if wasShown then
		getglobal("SW_BarSettingsFrameV2"):Show();
	end
end
function SW_ToggleReport(frameP)
	local frame = getglobal("SW_BarReportFrame")
	if(  frame:IsVisible() ) then
		frame:Hide();
	else
		frame.caller = frameP;
		frame:Show();
	end
end
function SW_ToggleSync()
	local frame = getglobal("SW_BarSyncFrame")
	if(  frame:IsVisible() ) then
		frame:Hide();
	else
		frame:Show();
	end
end
function SW_UpdateSyncChanText(newChan)
	if tonumber(newChan) then
		StaticPopup_Show("SW_InvalidChan");
	end
end

function SW_OptUpdateText(pName)
	local selOpt =  SW_Settings["BarFrames"][pName]["Selected"];
	local bSet = SW_GetBarSettings(pName);
	local b = getglobal(pName.."_Selector_Opt"..selOpt);
	local txtOpt = "";
	local txtFrame = "";
	if bSet["OT"] == nil then
		txtOpt = selOpt;
	else
		txtOpt = bSet["OT"];
	end
	b.NormalText:SetText(txtOpt);
	b.HighlightText:SetText(txtOpt);
	if bSet["OTF"] == nil then
		txtFrame = selOpt;
	else
		txtFrame = bSet["OTF"];
	end
	getglobal(pName.."_Title_Text"):SetText(txtFrame);
end
function SW_SetOptTxt(opt)
	local bS = SW_Settings["InfoSettings"][opt.optID];
	if bS == nil then return; end
	local oc = bS["OC"];
	local txt = "";
	if bS == nil or bS["OT"] == nil then
		txt = opt.optID;
	else
		txt = bS["OT"];
	end
	opt.NormalText:SetText(txt);
	opt.HighlightText:SetText(txt);
	--old version check
	if oc == nil or (oc[1] == 1 and oc[2] == 0 and oc[3] == 0 and oc[4] == 1) then
		oc = SW_Settings["Colors"]["TitleBars"]
	end
	
	opt.NormalT:SetVertexColor(unpack(oc));
	opt.HighlightT:SetVertexColor(unpack(oc));
	
end

function SW_GetBarSettings(pName)
	if SW_Settings["BarFrames"] == nil then
		SW_Settings["BarFrames"] = {};
	end
	
	if SW_Settings["BarFrames"][pName] == nil then
		SW_Settings["BarFrames"][pName] = {};
		SW_Settings["BarFrames"][pName]["Selected"] = 1;
		SW_Settings["BarFrames"][pName]["Docked"] = {1};
	end
	-- older version stored other stuff here
	if SW_Settings["BarFrames"][pName]["Selected"] == nil then
		SW_Settings["BarFrames"][pName] = {};
		SW_Settings["BarFrames"][pName]["Selected"] = 1;
		SW_Settings["BarFrames"][pName]["Docked"] = {1};
	end
	return SW_GetInfoSettings(SW_Settings["BarFrames"][pName]["Selected"]);
end
function SW_UpdateOptVis(reset)
	local nShow = SW_Settings["QuickOptCount"];
	local pre = "SW_BarFrame1_Selector_Opt";
	local toSelect = 1;
	if reset ~= nil then
		if nShow > 0 then
			if SW_Settings["BarFrames"] ~= nil and SW_Settings["BarFrames"]["SW_BarFrame1"] ~= nil then
				toSelect = SW_Settings["BarFrames"]["SW_BarFrame1"]["Selected"];
				if toSelect == nil then
					toSelect = 1;
				end
			end
			if toSelect > nShow then
				SW_SelOpt(getglobal(pre..nShow));
			end
		else
			SW_SelOpt(getglobal(pre.."1"));
		end
	end
	for i= 1, SW_OPT_COUNT do
		if i <= nShow then
			getglobal(pre..i):Show();
		else
			getglobal(pre..i):Hide();
		end
	end
end
function SW_SelectFilter(fName)
	getglobal("SW_Filter_NPC"):SetChecked(0);
	getglobal("SW_Filter_PC"):SetChecked(0);
	getglobal("SW_Filter_Group"):SetChecked(0);
	getglobal("SW_Filter_EverGroup"):SetChecked(0);
	getglobal("SW_Filter_None"):SetChecked(0);
	getglobal(fName):SetChecked(1);
end
function SW_GetInfoSettings(infoNr)
	if SW_Settings["InfoSettings"] == nil then
		SW_Settings["InfoSettings"] = {}
	end
	local iS = SW_Settings["InfoSettings"][infoNr];
	
	
	if iS == nil then
		SW_Settings["InfoSettings"][infoNr] = {}
		iS = SW_Settings["InfoSettings"][infoNr];
		for k,v in pairs(SW_DefaultBar) do 
			if type(v) ~= "table" then
				iS[k] = v;
			else
				iS[k] = {};
				for si, sv in ipairs(v) do
					table.insert(iS[k], sv);
				end
			end
		end
	else
		-- 1.4.2 merging removed bar width and adden colum count
		if iS["COLC"] == nil then
			iS["BW"] = nil;
			iS["COLC"] = 1;
		end
	end
	return iS;
end
-- 1.5 added pausing of data collection
function SW_ToggleRunning(doCollection)
	if SW_Settings["SYNCLastChan"]~=nil and SW_SyncCheckInChan(SW_Settings["SYNCLastChan"]) then
		doCollection = true;
	end
	
	local chkRunnig = getglobal("SW_OptChk_Running");
	local stateChanged = (doCollection ~= SW_Settings["IsRunning"]);
	
	
	if doCollection then
		chkRunnig:SetChecked(1);
		SW_Settings["IsRunning"] = true;
	else
		chkRunnig:SetChecked(0);
		SW_Settings["IsRunning"] = false;
	end
	
	if stateChanged then
		if (doCollection) then
			-- turn on stuff
			SW_UnpauseEvents();
		else
			-- turn off stuff
			SW_PauseEvents();
			-- stop CastTrack Pending
			SW_Timed_Calls:StopPending();
			-- stop DPS timer
			SW_CombatTimeInfo.awaitingStart = false;
			SW_CombatTimeInfo.awaitingEnd = false;
		end
	end
end
function SW_UpdateColor(pName)
	local bs = SW_Bars[pName];
	local barSettings = SW_GetBarSettings(pName);
	local bc = barSettings["BC"];
	local bfc = barSettings["BFC"];
	local oc = barSettings["OC"];
	
	local selOpt =  SW_Settings["BarFrames"][pName]["Selected"];
	local b = getglobal(pName.."_Selector_Opt"..selOpt);
	-- old version check
	
	if oc == nil or (oc[1] == 1 and oc[2] == 0 and oc[3] == 0 and oc[4] == 1) then
		oc = SW_Settings["Colors"]["TitleBars"]
	end
	b.NormalT:SetVertexColor(unpack(oc));
	b.HighlightT:SetVertexColor(unpack(oc));
	
	for i,b in ipairs(bs) do
		getglobal(b:GetName().."_Texture"):SetVertexColor(bc[1],bc[2],bc[3],bc[4]);
		getglobal(b:GetName().."_Text"):SetVertexColor(bfc[1],bfc[2],bfc[3],bfc[4]);
		getglobal(b:GetName().."_TextVal"):SetVertexColor(bfc[1],bfc[2],bfc[3],bfc[4]);
	end
end
function SW_BarsLayout(pName, changeAll)
	local bs = SW_Bars[pName];
	if bs == nil then return; end
	
	local bSet = SW_GetBarSettings(pName);
	local startX, startY, fWidth, fHeight;
	local bHeight, bWidth, fontSize;
	local colPos=1; local rowPos=1;
	local colCount=bSet["COLC"];
	local oTmp;
	local posX = 0;
	local posY = 0;
	local oP = getglobal(pName);
	
	
	local changeWidth = false;
	local changeHeight = false;
	local changeFont = false;
	
	startX = oP.swoBarX;
	startY = oP.swoBarY;
	fWidth = oP:GetWidth();
	fHeight = oP:GetHeight();
	
	bAutoWidth = math.floor(((fWidth - 10 - ((colCount - 1) * SW_BARSEPX))  / colCount));
	for i,b in ipairs(bs) do
		if oP.lastTexture == nil or oP.lastTexture ~= bSet["BT"] or changeAll then
			b:SetStatusBarTexture("Interface\\AddOns\\SW_Stats\\images\\b"..bSet["BT"]);
		end
		if i == 1 then
			fontSize = b:GetFontSize();
			if fontSize ~= bSet["BFS"] or changeAll then
				fontSize = bSet["BFS"];
				b:SetFontSize(fontSize);
				changeFont = true;
			end
			bHeight = b:GetHeight();
			if bHeight ~= bSet["BH"] or changeAll then
				bHeight = bSet["BH"];
				b:SetHeight(bHeight);
				changeHeight = true;
			end
			bWidth = b:GetWidth();
			if bWidth ~= bAutoWidth or changeAll then
				bWidth = bAutoWidth;
				b:SetWidth(bWidth);
				changeWidth = true;
			end
			
			b:Show();
			b:SetPoint("TOPLEFT",pName,"TOPLEFT",startX,startY);
			--colCount = math.floor(((fWidth - 10)  / (SW_BARSEPX + bWidth)));
			rowCount = math.floor(((fHeight - 30) / (SW_BARSEPY + bHeight)));
			rowPos = rowPos + 1;
			b.canBeSeen = true;
		else
			if rowPos > rowCount then
				rowPos = 1;
				colPos = colPos + 1;	
			end
			posX =  ((colPos -1) * SW_BARSEPX) + startX + ((colPos -1) * bWidth);
			posY =  startY -(((rowPos -1) * SW_BARSEPY) + ((rowPos -1) * bHeight));
			-- update
			if changeWidth then
				b:SetWidth(bWidth);
			end
			if changeHeight then
				b:SetHeight(bHeight);
			end
			if changeFont then
				b:SetFontSize(fontSize);
			end
			b:SetPoint("TOPLEFT",pName,"TOPLEFT",posX,posY);
			
			rowPos = rowPos + 1;
			if posX + bWidth > fWidth then
				b:Hide();
				b.canBeSeen = false;
			else
				b:Show();
				b.canBeSeen = true;
			end
			
		end
	end
	
	if changeAll then
		SW_UpdateColor(pName);
	end
	--this forces the ui to create new font objects -> text is clear
	if changeFont then
		local tmpScale = oP:GetScale();
		oP:SetScale(tmpScale + 0.01);
		oP:SetScale(tmpScale);
	end
	
	oP.lastTexture = bSet["BT"];
	
end
function SW_OptKey(num)
	if not getglobal("SW_BarFrame1"):IsVisible() then
		getglobal("SW_BarFrame1"):Show()
	end
	SW_SelOpt(getglobal("SW_BarFrame1_Selector_Opt"..num));
end
function SW_BarLayoutRegisterd()
	for f,_ in pairs(SW_Bars) do
		SW_BarsLayout(f);
		SW_UpdateColor(f);
		SW_OptUpdateText(f);
	end
end
function SW_BarLayoutRegisterdOnResize()
	for f,_ in pairs(SW_Bars) do 
		if getglobal(f).isResizing then
			SW_BarsLayout(f);
		end
	end
end
function SW_InitBarFrameBar(b)
	local scTarget = b:GetName().."_Texture";
	getglobal(scTarget):SetVertexColor(0,0.8,0,1);
	b:SetMinMaxValues(0,100); 
	b:SetValue(100);
	SW_BarRegister(this);
	b.LText = getglobal(b:GetName().."_Text");
	b.RText = getglobal(b:GetName().."_TextVal");
	b.SelfBar = this;
	b.canBeSeen = false;
	function b:SetBarText(text)
		if text == nil then
			self.LText:SetText(" ");
			self.SelfBar:Hide();
		else
			self.LText:SetText(text);
			self.SelfBar:Show();
		end
	end
	function b:SetValText(text)
		self.RText:SetText(text);
	end
	function b:GetFontSize()
		return math.floor(self.LText:GetHeight() + 0.5);
	end
	function b:SetFontSize(h)
		-- this distorts text check SW_BarsLayout() for fix
		self.LText:SetTextHeight(h);
		self.RText:SetTextHeight(h);
	end
end

function SW_SetBarColor(what)
	local R,G,B = ColorPickerFrame:GetColorRGB();
	local A = 1 - OpacitySliderFrame:GetValue();
	local bfc;
	
	if what == "DIRECT" then
		bfc = ColorPickerFrame.SWColorTable
	else
		local barSettings = SW_GetBarSettings(ColorPickerFrame.SWBarFrame);
		bfc = barSettings[what];
	end 
	
	
	bfc[1] = R; bfc[2] = G; bfc[3] = B; bfc[4] = A;
	
	if what == "DIRECT" then
		if ColorPickerFrame.SWCallOnUpdate then
			ColorPickerFrame.SWCallOnUpdate(bfc);
		end
	else
		SW_UpdateColor(ColorPickerFrame.SWBarFrame);
	end
	if ColorPickerFrame.SWCSName ~= nil then
		getglobal(ColorPickerFrame.SWCSName):SetColor(bfc);
	end
end
function SW_CancelBarColor(oldVals, what)
	local bfc;
	
	if what == "DIRECT" then
		bfc = ColorPickerFrame.SWColorTable
	else
		local barSettings = SW_GetBarSettings(ColorPickerFrame.SWBarFrame);
		bfc = barSettings[what];
	end 
	
	bfc[1] = oldVals[1]; bfc[2] = oldVals[2];
	bfc[3] = oldVals[3]; bfc[4] = oldVals[4];
	if what == "DIRECT" then
		if ColorPickerFrame.SWCallOnUpdate then
			ColorPickerFrame.SWCallOnUpdate(bfc);
		end
	else
		SW_UpdateColor(ColorPickerFrame.SWBarFrame);
	end
	if ColorPickerFrame.SWCSName ~= nil then
		getglobal(ColorPickerFrame.SWCSName):SetColor(bfc);
	end
end
-- 1.5.3 TODO Low Prio I should redo this sometime the color picker thing is getting messy
-- probably could just reduce it to "DIRECT" color and callOnUpdate
function SW_DoColorPicker(targetFrame, what, csName, callOnUpdate)
	if ColorPickerFrame:IsVisible() then return; end
	local bfc;
	
	if what == "DIRECT" then
		bfc = targetFrame;
		ColorPickerFrame.SWBarFrame = "SW_BarFrame1";
		ColorPickerFrame.SWColorTable = targetFrame;
		ColorPickerFrame.SWCallOnUpdate = callOnUpdate;
		
	else
		
		local barSettings = SW_GetBarSettings(targetFrame);

		bfc = barSettings[what];
		if bfc == nil then
			barSettings[what] = {1,0,0,1};
			bfc = barSettings[what];
		end
		
		
		if bfc[1]==1 and bfc[2]==0 and bfc[3]==0 and bfc[4]==1 then
			bfc = SW_Settings["Colors"]["TitleBars"];
			
		end
		
		ColorPickerFrame.SWBarFrame = targetFrame;
		ColorPickerFrame.SWColorTable = nil;
	end
	
	ColorPickerFrame.SWCSName = csName;
	ColorPickerFrame.opacityFunc = function() SW_SetBarColor(what); end
	ColorPickerFrame.func = function() SW_SetBarColor(what); end
	ColorPickerFrame.cancelFunc = function(oldVals) SW_CancelBarColor(oldVals, what); end
	ColorPickerFrame.hasOpacity = true;
	ColorPickerFrame.opacity = 1 - bfc[4];
	ColorPickerFrame.previousValues = {bfc[1], bfc[2], bfc[3], bfc[4]};
	ColorPickerFrame:SetColorRGB(bfc[1], bfc[2], bfc[3]);
	ColorPickerFrame:Show();
end
function SW_UpdateClassColorAlpha(newColor)
	local alpha = newColor[4];
	SW_Settings["Colors"]["DRUID"][4] = alpha;
	SW_Settings["Colors"]["HUNTER"][4] = alpha;
	SW_Settings["Colors"]["MAGE"][4] = alpha;
	SW_Settings["Colors"]["PALADIN"][4] = alpha;
	SW_Settings["Colors"]["PRIEST"][4] = alpha;
	SW_Settings["Colors"]["ROGUE"][4] = alpha;
	SW_Settings["Colors"]["SHAMAN"][4] = alpha;
	SW_Settings["Colors"]["WARLOCK"][4] = alpha;
	SW_Settings["Colors"]["WARRIOR"][4] = alpha;
end
function SW_UpdateFrameBackdrops(newColor)
	local tmpTarget;
	for i, k in ipairs(SW_Registerd_BF_Titles) do
		tmpTarget = getglobal(k):GetParent();
		tmpTarget:SetBackdropBorderColor(unpack(newColor));
	end
	local tmpCol = {unpack(newColor)};
	tmpCol[4] = 1;
	
	--for SW_TabbedFrameInfo[pName][oTab:GetName()]
	for k, v in pairs(SW_TabbedFrameInfo) do
		for k2, v2 in pairs(v) do
			tmpTarget = getglobal(k2);
			if tmpTarget.IsSelectedTab then
				tmpTarget:SetBackdropBorderColor(unpack(tmpCol));
				getglobal(k2.."_Text"):SetTextColor(unpack(tmpCol));
			end
		end
	end	
end
function SW_LockFrames(isLocked)
	if isLocked then
		SW_Settings["BFLocked"] = true;
	else
		SW_Settings["BFLocked"] = nil;
	end
	for i, k in ipairs(SW_Registerd_BF_Titles) do
		getglobal(k):GetParent().isLocked = isLocked;
	end
end
function SW_UpdateMainWinBack(newColor)
	SW_BarFrame1:SetBackdropColor(unpack(SW_Settings["Colors"]["MainWinBack"])) 
end
function SW_UpdateTitleColor(newColor)
	local tmpTarget;
	local regEx = "SW_BarFrame1_Selector_Opt(%d+)"
	local oc;
	
	for i, k in ipairs(SW_Registerd_BF_Titles) do
		tmpTarget = getglobal(k .. "_Texture");
		tmpTarget:SetVertexColor(unpack(newColor));
	end
	
	for i, k in ipairs(SW_Registered_BF_TitleButtons) do
		s,e, id = string.find(k, regEx);
		oc = nil;
		if id ~= nil then
			id = tonumber(id);
			
			if SW_Settings["InfoSettings"] and SW_Settings["InfoSettings"][id] then
				oc = SW_Settings["InfoSettings"][id]["OC"];	
			end
			if not oc or (oc[1] == 1 and oc[2] == 0 and oc[3] == 0 and oc[4] == 1) then
				--oc = SW_Settings["Colors"]["TitleBars"]
				tmpTarget = getglobal(k);
				tmpTarget.NormalT:SetVertexColor(unpack(newColor));
				tmpTarget.HighlightT:SetVertexColor(unpack(newColor));
			end
		else
			tmpTarget = getglobal(k);
			tmpTarget.NormalT:SetVertexColor(unpack(newColor));
			tmpTarget.HighlightT:SetVertexColor(unpack(newColor));
		end
		
		
	end
	
	
end
function SW_UpdateTitleTextColor(newColor)
	local tmpTarget;
	local regEx = "SW_BarFrame1_Selector_Opt(%d+)"
	local id = 0;
	for i, k in ipairs(SW_Registerd_BF_Titles) do
		tmpTarget = getglobal(k .. "_Text");
		tmpTarget:SetVertexColor(unpack(newColor));
	end
	local barSettings = SW_GetBarSettings("SW_BarFrame1");
	
	for i, k in ipairs(SW_Registered_BF_TitleButtons) do
		s,e, id = string.find(k, regEx)
		if not id then
			tmpTarget = getglobal(k);
			tmpTarget.NormalText:SetVertexColor(unpack(newColor));
			tmpTarget.NormalText:SetVertexColor(unpack(newColor));
		end
	end

end

function SW_BarsCheckFilters(name, SF, CF, PF)
	local selFil = "";
	local charFil = "";
	local cType = nil;
	local petFil = nil;
	
	if PF == nil then
		petFil = getglobal("SW_PF_Inactive").petFil;
	else
		petFil = getglobal(PF).petFil;
	end
	
	-- only if the pet filters are set to inactive
	-- add pets here, else they are handeled after this
	if petFil.Inactive then
		petFil = true;
	else
		if SW_PetInfo["PET_OWNER"][name] == nil then
			-- this isn't, and never was a pet
			petFil = true;
		else
			if SW_S_Details[name] ~= nil and SW_S_Details[name]["UTYPE"] == "GPET" then
				petFil = false;
			else
				petFil = true;
			end
		end
	end
	
	if not petFil then return false; end
	
	if SW_S_Details[name] == nil then return false; end
	if SF == nil then
		selFil = getglobal("SW_Filter_None").SW_Filter;
	else
		selFil = getglobal(SF).SW_Filter;
	end
	if CF == nil then
		charFil = SW_ClassFilters[1]
	else
		charFil = SW_ClassFilters[ CF ]
	end
	if selFil == "NONE" and charFil == "NONE" then
		return true;
	end
	
	if selFil == "NONE" then
		selFil = true;
	else
		--1.5 filters added EGROUP types added GPET GPC
		if selFil == "GROUP" then
			if SW_Friends[name] == nil then
				 selFil = SW_PetHasOwner(name);
			else
				selFil = true;
			end
		elseif selFil == "EGROUP" then
			cType = SW_S_Details[name]["UTYPE"];
			selFil = (cType == "GPC" or cType == "GPET");
		elseif selFil == "PC" then
			cType = SW_S_Details[name]["UTYPE"];
			selFil = (cType == "GPC" or cType == "GPET" or cType == "PC");
		else
			selFil = (selFil == SW_S_Details[name]["UTYPE"]);
		end
	end
	if charFil == "NONE" then
		charFil = true;
	else
		charFil = (charFil == SW_S_Details[name]["CLASSE"]);
	end
	if selFil and charFil then
		return true;
	else
		return false;
	end
end
--SW_EntityBarColor
function SW_EBC(ent, bs)
	
	if bs["UCC"] then
		if SW_Friends[ent] == nil or SW_Friends[ent]["CLASSE"] == nil then
			if SW_S_Details[ent] == nil or SW_S_Details[ent]["CLASSE"] == nil then
				return bs["BC"];
			else
				return SW_Settings["Colors"][ SW_S_Details[ent]["CLASSE"] ];
			end
		else
			return SW_Settings["Colors"][ SW_S_Details[ent]["CLASSE"] ];
		end
	else
		return nil;
	end
end
function SW_AddLatePetInfo(vals, petFil, type, index, bSet)
	
	local SF = bSet["SF"];
	local CF = bSet["CF"];
	local PF = "SW_PF_Inactive";
	
	if petFil.Active then
		for k,v in pairs(SW_PetInfo["PET_OWNER"]) do
			if SW_BarsCheckFilters(k, SF, CF, PF) then
				tmpVal = v[type][index];
				if tmpVal >0 then
					table.insert(vals, {SW_STR_PET_PREFIX..k,tmpVal,SW_EBC(k,bSet)});
				end
			end
		end
	elseif petFil.Current then
		-- for EGROUP filter just do the same as active, it just makes more sense
		-- from a user perspective current pets in in ever group..oO nah
		local selFil;
		if SF ~= nil then
			selFil = getglobal(SF).SW_Filter;
		end
		if selFil == "EGROUP" then
			for k,v in pairs(SW_PetInfo["PET_OWNER"]) do
				if SW_BarsCheckFilters(k, SF, CF, PF) then
					tmpVal = v[type][index];
					if tmpVal >0 then
						table.insert(vals, {SW_STR_PET_PREFIX..k,tmpVal,SW_EBC(k,bSet)});
					end
				end
			end
		else
			for k,v in pairs(SW_PetInfo["PET_OWNER"]) do
				if SW_PetHasOwner(k) then
					tmpVal = v[type][index];
					if tmpVal > 0 then
						table.insert(vals, {SW_STR_PET_PREFIX..k,tmpVal,SW_EBC(k,bSet)});
					end
				end
			end
		end
	elseif petFil.VPP then
		for k,v in pairs(SW_PetInfo["OWNER_PET"]) do
			if SW_BarsCheckFilters(k, SF, CF, PF) then
				tmpVal = v[type][index];
				if tmpVal > 0 then
					table.insert(vals, {SW_STR_VPP_PREFIX..k,tmpVal,SW_EBC(k,bSet)});
				end
			end
		end
	elseif petFil.VPR then
		tmpVal = 0;
		for k,v in pairs(SW_PetInfo["PET_OWNER"]) do
			if SW_BarsCheckFilters(k, SF, CF, PF) then
				tmpVal = tmpVal + v[type][index];
			end
		end
		if tmpVal >0 then
			table.insert(vals, {SW_STR_VPR,tmpVal,SW_EBC(k,bSet)});
		end
	--elseif petFil.Ignore then -- well nothing to do here
	end
end
function SW_GetDeathInfo(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	
	-- ignore pet filter here
	for k,v in pairs(SW_S_Details) do
		tmpVal = v[SW_PRINT_ITEM_DEATHS];
		if tmpVal ~= nil then
			if SW_BarsCheckFilters(k, SF, CF, "SW_PF_Inactive") then
				table.insert(vals, {k,tmpVal,SW_EBC(k,bSet)});
			end
		end
	end

	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
			
	return vals;	
end

function SW_GetDmgInfo(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	local petFil = nil;
	if PF == nil then
		petFil = getglobal("SW_PF_Inactive").petFil;
	else
		petFil = getglobal(PF).petFil;
	end
	
	for k,v in pairs(SW_S_Details) do
		if v[SW_PRINT_ITEM_TOTAL_DONE] ~= nil then
			tmpVal = v[SW_PRINT_ITEM_TOTAL_DONE][1];
			if SW_BarsCheckFilters(k, SF, CF, PF) then
				if (petFil.MM or petFil.MB) and SW_PetInfo["OWNER_PET"][k] ~= nil then
					tmpVal = tmpVal + SW_PetInfo["OWNER_PET"][k][SW_PRINT_ITEM_TOTAL_DONE][1];
				end
				if tmpVal >0 then
					table.insert(vals, {k,tmpVal,SW_EBC(k,bSet)});
				end
			end
		end
	end
	
	if petFil.latePets then
		SW_AddLatePetInfo(vals, petFil, SW_PRINT_ITEM_TOTAL_DONE, 1, bSet);
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
	
	return vals;	
end
function SW_GetDmgInfoDPS(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	local petFil = nil;
	if PF == nil then
		petFil = getglobal("SW_PF_Inactive").petFil;
	else
		petFil = getglobal(PF).petFil;
	end
	
	for k,v in pairs(SW_S_Details) do
		if v[SW_PRINT_ITEM_TOTAL_DONE] ~= nil then
			tmpVal = v[SW_PRINT_ITEM_TOTAL_DONE][1];
			if SW_BarsCheckFilters(k, "SW_Filter_EverGroup", CF, PF) then
				if (petFil.MM or petFil.MB) and SW_PetInfo["OWNER_PET"][k] ~= nil then
					tmpVal = tmpVal + SW_PetInfo["OWNER_PET"][k][SW_PRINT_ITEM_TOTAL_DONE][1];
				end
				if tmpVal >0 then
					table.insert(vals, {k,tmpVal,SW_EBC(k,bSet)});
				end
			end
		end
	end
	
	if petFil.latePets then
		SW_AddLatePetInfo(vals, petFil, SW_PRINT_ITEM_TOTAL_DONE, 1, bSet);
	end
	local secs = SW_RPS.currentSecs + SW_RPS.totalSecs;
	for k, v in ipairs(vals) do
		--SW_printStr(v[2]..".."..secs);
		v[2] = math.floor( (v[2] / secs) * 100 + 0.5) / 100;
	end
	
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
	
	return vals;	
end
function SW_GetDmgGotInfo(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	local petFil = nil;
	if PF == nil then
		petFil = getglobal("SW_PF_Inactive").petFil;
	else
		petFil = getglobal(PF).petFil;
	end

	for k,v in pairs(SW_S_Details) do
		if v[SW_PRINT_ITEM_RECIEVED] ~= nil then
			tmpVal = v[SW_PRINT_ITEM_RECIEVED][1];
			if SW_BarsCheckFilters(k, SF, CF, PF) then
				if (petFil.MR or petFil.MB) and SW_PetInfo["OWNER_PET"][k] ~= nil then
					tmpVal = tmpVal + SW_PetInfo["OWNER_PET"][k][SW_PRINT_ITEM_RECIEVED][1];
				end
				if tmpVal >0 then
					table.insert(vals, {k,tmpVal,SW_EBC(k,bSet)});
				end
			end
		end
	end
	if petFil.latePets then
		SW_AddLatePetInfo(vals, petFil, SW_PRINT_ITEM_RECIEVED, 1, bSet);
	end
	
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);	
	return vals;	
end

function SW_GetHealGotInfo(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	local petFil = nil;
	if PF == nil then
		petFil = getglobal("SW_PF_Inactive").petFil;
	else
		petFil = getglobal(PF).petFil;
	end

	for k,v in pairs(SW_S_Details) do
		if v[SW_PRINT_ITEM_RECIEVED] ~= nil then
			tmpVal = v[SW_PRINT_ITEM_RECIEVED][2];
			if SW_BarsCheckFilters(k, SF, CF, PF) then
				if (petFil.MR or petFil.MB) and SW_PetInfo["OWNER_PET"][k] ~= nil then
					tmpVal = tmpVal + SW_PetInfo["OWNER_PET"][k][SW_PRINT_ITEM_RECIEVED][2];
				end
				if tmpVal >0 then
					table.insert(vals, {k,tmpVal,SW_EBC(k,bSet)});
				end
			end
		end
	end

	if petFil.latePets then
		SW_AddLatePetInfo(vals, petFil, SW_PRINT_ITEM_RECIEVED, 2, bSet);
	end
	
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
		
	return vals;	
end
function SW_GetDamageManaInfo(SF, CF, PF, bSet)
	local vals = {};
	local ratio;
	local dmg;
	
	for k,v in pairs(SW_S_Details) do
		if SW_S_ManaUsage[k] ~= nil and SW_S_ManaUsage[k][1] > 0 then
			if SW_BarsCheckFilters(k, SF, CF, "SW_PF_Inactive") then
				-- filter out hunters
				-- hm would have to filter out palas and shamans aswell
				--if v["CLASSE"] ~= "HUNTER" then
					if v[SW_PRINT_ITEM_TOTAL_DONE] ~= nil then
						dmg = v[SW_PRINT_ITEM_TOTAL_DONE][1];
						if dmg > 0 then
							ratio = math.floor( (dmg / SW_S_ManaUsage[k][1]) * 1000 + 0.5) / 1000;
							table.insert(vals, {k,ratio,SW_EBC(k,bSet)});
						end
					end
				--end
			end
		end
	end

	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
	return vals;
end
function SW_GetEffectiveHealManaInfo(SF, CF, PF, bSet)
	local vals = {};
	local eHeal;
	local ratio;
	
	for k,v in pairs(SW_S_Details) do
		if SW_S_ManaUsage[k] ~= nil and SW_S_ManaUsage[k][2] > 0 then
			if SW_BarsCheckFilters(k, SF, CF, "SW_PF_Inactive") then
			
				eHeal = SW_GetEffectiveHealInfoFor(k);
				if eHeal > 0 then
					ratio = math.floor( (eHeal / SW_S_ManaUsage[k][2]) * 1000 + 0.5) / 1000;
					table.insert(vals, {k,ratio,SW_EBC(k,bSet)});
				end
			end
		end
	end

	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);	
	return vals;
end
function SW_GetEffectiveHealInfoFor(name)
	local tmpVal;
	local eHeal;
	local k = name;
	
	local v = SW_S_Details[k];
	if v == nil then
		return 0;
	end

	tmpVal = v[SW_PRINT_ITEM_TOTAL_DONE][2];
	
	if tmpVal >0 then
		if SW_S_Healed[k] ~= nil and SW_S_Healed[k][SW_OVERHEAL] ~= nil then
			eHeal = tmpVal - SW_S_Healed[k][SW_OVERHEAL];
			if eHeal > 0 then
				return eHeal;
			end
		else
			return tmpVal;
		end
	end

	return 0;
	
end

function SW_GetEffectiveHealInfo(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	local eHeal;
	
	for k,v in pairs(SW_S_Details) do
		if v[SW_PRINT_ITEM_TOTAL_DONE] ~= nil then
			tmpVal = v[SW_PRINT_ITEM_TOTAL_DONE][2];
			if SW_BarsCheckFilters(k, SF, CF, "SW_PF_Inactive") then
				if tmpVal >0 then
					if SW_S_Healed[k] ~= nil and SW_S_Healed[k][SW_OVERHEAL] ~= nil then
						eHeal = tmpVal - SW_S_Healed[k][SW_OVERHEAL];
						if eHeal > 0 then
							table.insert(vals, {k,eHeal,SW_EBC(k,bSet)});
						end
					else
						table.insert(vals, {k,tmpVal,SW_EBC(k,bSet)});
					end
				end
			end
		end
	end

	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);		
	return vals;
end
function SW_GetHealInfo(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	local petFil = nil;
	if PF == nil then
		petFil = getglobal("SW_PF_Inactive").petFil;
	else
		petFil = getglobal(PF).petFil;
	end
	
	for k,v in pairs(SW_S_Details) do
		if v[SW_PRINT_ITEM_TOTAL_DONE] ~= nil then
			tmpVal = v[SW_PRINT_ITEM_TOTAL_DONE][2];
			if SW_BarsCheckFilters(k, SF, CF, PF) then
				if (petFil.MM or petFil.MB) and SW_PetInfo["OWNER_PET"][k] ~= nil then
					tmpVal = tmpVal + SW_PetInfo["OWNER_PET"][k][SW_PRINT_ITEM_TOTAL_DONE][2];
				end
				if tmpVal >0 then
					table.insert(vals, {k,tmpVal,SW_EBC(k,bSet)});
				end
			end
		end
	end

	if petFil.latePets then
		SW_AddLatePetInfo(vals, petFil, SW_PRINT_ITEM_TOTAL_DONE, 2, bSet);
	end
	
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);		
	return vals;	
end
function SW_GetOverHealInfo(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	local pOh;
	
	for k,v in pairs(SW_S_Details) do
		if v[SW_PRINT_ITEM_TOTAL_DONE] ~= nil then
			tmpVal = v[SW_PRINT_ITEM_TOTAL_DONE][2];
			if SW_BarsCheckFilters(k, SF, CF, "SW_PF_Inactive") then
				if tmpVal >0 then
					if SW_S_Healed[k] ~= nil and SW_S_Healed[k][SW_OVERHEAL] then
						pOh = math.floor((SW_S_Healed[k][SW_OVERHEAL]/ tmpVal) * 1000 +0.5)/10;
						table.insert(vals, {k.." ("..pOh.."%)",SW_S_Healed[k][SW_OVERHEAL], SW_EBC(k,bSet)});
					end
				end
			end
		end
	end

	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
			
	return vals;	
end
function SW_GetHealInfoHealer(whoName)
	local vals = {};
	local who = SW_S_Healed[ whoName ];
	
	if who == nil then return {}; end;
	local bSet = SW_GetBarSettings("SW_BarFrame1");
	
	for k,v in pairs(who) do
		if v > 0 and k ~= SW_OVERHEAL then
			table.insert(vals, {k,v,SW_EBC(k,bSet)});
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);	
	return vals;
end

function SW_GetDetailsPerTick(whoName)
local who = SW_S_Details[ whoName ];
	local val ="";
	local vMax = "";
	
	if who == nil then return {}; end;
	
	local vals = {};
	
	local dCol = SW_Settings["Colors"]["Damage"];
	local hCol = SW_Settings["Colors"]["Heal"];
	
	for k,v in pairs(who) do
		if k == SW_PRINT_ITEM_RECIEVED then
			
		elseif k == SW_PRINT_ITEM_TYPE then
			
		elseif k == SW_PRINT_ITEM_TOTAL_DONE then
			
		elseif k == "UTYPE" then
			
		elseif k == "CLASSE" then
		
		elseif k == SW_PRINT_ITEM_DEATHS then
		
		else
			if v[1] > 0 then
				table.insert(vals, {k.." "..SW_STR_EVENTCOUNT..v[4].." - "..(math.floor((v[6]/v[4]) *1000 + 0.5)/10).."%",math.floor((v[1]/v[4])*10)/10,dCol,1});
			end
			if v[2] > 0 then
				table.insert(vals, {k.." "..SW_STR_EVENTCOUNT..v[4].." - "..(math.floor((v[7]/v[4]) *1000 + 0.5)/10).."%",math.floor((v[2]/v[4])*10)/10,hCol,2});
			end
		end
		
	end
	table.sort(vals, 
		function(a,b)
			if a[4] == b[4] then
				return a[2] > b[2];
			else
				return a[4] < b[4];
			end
		end);
	return vals;
end
function SW_PowerGainInfo(whoName)
	local who = SW_S_Details[ whoName ];
	local val ="";
	local vMax = "";
	
	if who == nil then return {}; end;
	local bSet = SW_GetBarSettings("SW_BarFrame1");
	local vals = {};
	
	for k,v in pairs(who) do
		if k == SW_PRINT_ITEM_RECIEVED then
			-- SW_printStr(LIGHTYELLOW_FONT_COLOR_CODE..k..FONT_COLOR_CODE_CLOSE..":  "..string.format(SW_PRINT_INFO_RECIEVED, v[1], v[2]), 1);			
		elseif k == SW_PRINT_ITEM_TYPE then
			-- ignore in this printout
		elseif k == SW_PRINT_ITEM_TOTAL_DONE then
			--ignored for now
		elseif k == "UTYPE" then
			--PC or NPC ignore
		elseif k == "CLASSE" then
		
		elseif k == SW_PRINT_ITEM_DEATHS then
		
		else
			if v[1] == 0 and v[2] == 0 and v[4] ~= 0 then
				table.insert(vals, {k,v[4],SW_EBC(k,bSet)});
			end
		end
	end
	table.sort(vals, 
			function(a,b)
				if a[4] == b[4] then
					return a[2] > b[2];
				else
					return a[4] < b[4];
				end
			end);
	return vals;
end
function SW_DecurseCountInfo(SF, CF, PF, bSet)
	local vals = {};
	
	for k,v in pairs(SW_S_SpellInfo) do
		if v[SW_DECURSEDUMMY] ~= nil and v[SW_DECURSEDUMMY]["total"] ~= nil then
			
			if SW_BarsCheckFilters(k, SF, CF, "SW_PF_Inactive") then
				table.insert(vals, {k,v[SW_DECURSEDUMMY]["total"],SW_EBC(k,bSet)});
			end
		end
	end

	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);	
	return vals;
end
function SW_GetManaRatio(whoName)
	if SW_S_SpellInfo[SW_SELF_STRING] == nil or whoName ~= SW_SELF_STRING then
		return {};
	end
	
	local who = SW_S_Details[ whoName ];
	local val ="";
	local vMax = "";
	
	if who == nil then return {}; end;
	
	local vals = {};

	local dCol = SW_Settings["Colors"]["Damage"];
	local hCol = SW_Settings["Colors"]["Heal"];
	
	local manaUsed = 0;
	local ratio = 0;
	
	for k,v in pairs(who) do
		if k == SW_PRINT_ITEM_RECIEVED then
			-- SW_printStr(LIGHTYELLOW_FONT_COLOR_CODE..k..FONT_COLOR_CODE_CLOSE..":  "..string.format(SW_PRINT_INFO_RECIEVED, v[1], v[2]), 1);			
		elseif k == SW_PRINT_ITEM_TYPE then
			-- ignore in this printout
		elseif k == SW_PRINT_ITEM_TOTAL_DONE then
			-- ignored for now
		elseif k == "UTYPE" then
			--PC or NPC ignore
		elseif k == "CLASSE" then
		
		elseif k == SW_PRINT_ITEM_DEATHS then
		
		else
			if SW_S_SpellInfo[SW_SELF_STRING][k] ~= nil then
				manaUsed = SW_S_SpellInfo[SW_SELF_STRING][k][2];
				if manaUsed > 0 then
					
					if v[1] > 0 then
						ratio = math.floor( (v[1] / manaUsed) * 100 + 0.5) / 100;
						table.insert(vals, {k.." #"..SW_S_SpellInfo[SW_SELF_STRING][k][1],ratio,dCol,1});	
					end
						
					if v[2] > 0 then
						ratio = math.floor( (v[2] / manaUsed) * 100 + 0.5) / 100;
						table.insert(vals, {k.." #"..SW_S_SpellInfo[SW_SELF_STRING][k][1],ratio,hCol,2});
						--table.insert(vals, {k.." ("..v[3]..")",v[2],hCol,2});
					end
				end
			end
		end
	end
	table.sort(vals, 
		function(a,b)
			if a[4] == b[4] then
				return a[2] > b[2];
			else
				return a[4] < b[4];
			end
		end);
	
	return vals;
end

function SW_GetTopHealDelta()
	return SW_GetTopDelta("TOPDELTAH");
end
function SW_GetTopDmgDelta()
	return SW_GetTopDelta("TOPDELTAD");
end

function SW_GetTopDelta(what)
	local vals = {};
	for k, v in pairs (SW_Sync_MsgTrack) do
		if v[what] > 0 then
			table.insert(vals, {k, v[what]});
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);	
	return vals;
end
function SW_GetRaidPS()
	local vals = {};
	
	local dps = SW_RPS:getVals();
	
	if dps[1] > 0 then
		table.insert(vals, {SW_RDPS_STRS["CURR"], dps[1], nil});
	end
	if dps[2] > 0 then
		table.insert(vals, {SW_RDPS_STRS["ALL"], dps[2], nil});
	end
	if dps[3] > 0 then
		table.insert(vals, {SW_RDPS_STRS["LAST"], dps[3], nil});
	end
	if dps[4] and dps[4] > 0.1 then
		table.insert(vals, {SW_RDPS_STRS["TOTAL"], dps[4], nil});
	end
	
	if SW_RPS.maxDPS > 0 then
		table.insert(vals, {SW_RDPS_STRS["MAX"], SW_RPS.maxDPS, nil});
	end
	
	table.sort(vals, 
		function(a,b)
				return a[2] > b[2];
		end);
	
	return vals;
end

-- 1.5.3.beta.1 note to self make this more efficient for the next data model, a good number to use in cheat protection
function SW_GetMaxHit(whoName, checkHeal)
	local who = SW_S_Details[ whoName ];
	local vMax = 0;
	local tmpVal = 0;
	if who == nil then return 0; end;
	for k,v in pairs(who) do
		if k == SW_PRINT_ITEM_RECIEVED then
		elseif k == SW_PRINT_ITEM_TYPE then
		elseif k == SW_PRINT_ITEM_TOTAL_DONE then
		elseif k == "UTYPE" then
		elseif k == "CLASSE" then
		elseif k == SW_PRINT_ITEM_DEATHS then
		else
			if checkHeal then
				tmpVal = v[5];
			else
				tmpVal = v[3];
			end
			if tmpVal > vMax then
				vMax = tmpVal;
			end
		end
	end
	return vMax;
end
function SW_GetMaxHitList(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	
	for k,v in pairs(SW_S_Details) do
		if SW_BarsCheckFilters(k, SF, CF, "SW_PF_Inactive") then
			tmpVal = SW_GetMaxHit(k);
			if tmpVal > 0 then
				table.insert(vals, {k,tmpVal,SW_EBC(k,bSet)})
			end
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
			
	return vals;
end
function SW_GetMaxHealList(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	
	for k,v in pairs(SW_S_Details) do
		if SW_BarsCheckFilters(k, SF, CF, "SW_PF_Inactive") then
			tmpVal = SW_GetMaxHit(k, true);
			if tmpVal > 0 then
				table.insert(vals, {k,tmpVal,SW_EBC(k,bSet)})
			end
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
			
	return vals;
end
function SW_GetDetails(whoName)
	local who = SW_S_Details[ whoName ];
	local val ="";
	local vMax = "";
	
	if who == nil then return {}; end;
	
	local vals = {};

	local dCol = SW_Settings["Colors"]["Damage"];
	local hCol = SW_Settings["Colors"]["Heal"];
	
	for k,v in pairs(who) do
		if k == SW_PRINT_ITEM_RECIEVED then
			-- SW_printStr(LIGHTYELLOW_FONT_COLOR_CODE..k..FONT_COLOR_CODE_CLOSE..":  "..string.format(SW_PRINT_INFO_RECIEVED, v[1], v[2]), 1);			
		elseif k == SW_PRINT_ITEM_TYPE then
			-- ignore in this printout
		elseif k == SW_PRINT_ITEM_TOTAL_DONE then
			--ignored for now
		elseif k == "UTYPE" then
			--PC or NPC ignore
		elseif k == "CLASSE" then
		
		elseif k == SW_PRINT_ITEM_DEATHS then
		
		else
			if v[1] > 0 then
				table.insert(vals, {k.." ("..v[3].." - "..(math.floor((v[6]/v[4]) *1000 + 0.5)/10).."%)",v[1],dCol,1});
			end
			if v[2] > 0 then
				table.insert(vals, {k.." ("..v[5].." - "..(math.floor((v[7]/v[4]) *1000 + 0.5)/10).."%)",v[2],hCol,2});
			end
		end
	end
	-- 1.5 added pet details
	who = SW_PetInfo["OWNER_PET"][whoName];
	if who ~= nil then
		who = who["pets"];
		
		for k,v in pairs(who) do
			if v[SW_PRINT_ITEM_TOTAL_DONE][1] > 0 then
				table.insert(vals, {SW_STR_PET_PREFIX..k,v[SW_PRINT_ITEM_TOTAL_DONE][1],dCol,1});
			end
			if v[SW_PRINT_ITEM_TOTAL_DONE][2] > 0 then
				table.insert(vals, {SW_STR_PET_PREFIX..k,v[SW_PRINT_ITEM_TOTAL_DONE][2],hCol,2});
			end
		end
	end
	table.sort(vals, 
			function(a,b)
				if a[4] == b[4] then
					return a[2] > b[2];
				else
					return a[4] < b[4];
				end
			end);
	return vals;
end
function SW_GetHealInfoTarget(whoName)
	local vals = {};
	local tmpVal;
	local bSet = SW_GetBarSettings("SW_BarFrame1");
	
	for k,v in pairs(SW_S_Healed) do
		
		if v[whoName] ~= nil then
			table.insert(vals, {k,v[whoName], SW_EBC(k,bSet)});
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);		
	return vals;	
end
function SW_GetSchoolMadeSummary(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	local summVals = {};
	
	for k,v in pairs(SW_S_Details) do
		if SW_BarsCheckFilters(k, SF, CF, "SW_PF_Inactive") then
			if SW_S_Details[k][SW_PRINT_ITEM_TYPE] ~= nil then
				for t,nums in pairs(SW_S_Details[k][SW_PRINT_ITEM_TYPE]) do
					if summVals[t] == nil then
						summVals[t] = nums[1];
					else
						summVals[t] = summVals[t] + nums[1];
					end
				end
			end
		end
	end
	for k,v in pairs(summVals) do
		if v > 0 then
			table.insert(vals, {k,v});
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
			
	return vals;	
end
function SW_GetSchoolGotSummary(SF, CF, PF, bSet)
	local vals = {};
	local tmpVal;
	local summVals = {};
	
	for k,v in pairs(SW_S_Details) do
		if SW_BarsCheckFilters(k, SF, CF, "SW_PF_Inactive") then
			if SW_S_Details[k][SW_PRINT_ITEM_TYPE] ~= nil then
				for t,nums in pairs(SW_S_Details[k][SW_PRINT_ITEM_TYPE]) do
					if summVals[t] == nil then
						summVals[t] = nums[4];
					else
						summVals[t] = summVals[t] + nums[4];
					end
				end
			end
		end
	end
	for k,v in pairs(summVals) do
		if v > 0 then
			table.insert(vals, {k,v});
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
			
	return vals;
end
function SW_GetSchoolMade(whoName)
	local vals = {};
	local tmpVal;
	if SW_S_Details[whoName] == nil then return vals; end
	if SW_S_Details[whoName][SW_PRINT_ITEM_TYPE] == nil then return vals; end
	for k,v in pairs(SW_S_Details[whoName][SW_PRINT_ITEM_TYPE]) do
		if v[1] ~= 0 then
			table.insert(vals, {k,v[1]});
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
			
	return vals;	
end
function SW_GetSchoolGot(whoName)
	local vals = {};
	local tmpVal;
	if SW_S_Details[whoName] == nil then return vals; end
	if SW_S_Details[whoName][SW_PRINT_ITEM_TYPE] == nil then return vals; end
	for k,v in pairs(SW_S_Details[whoName][SW_PRINT_ITEM_TYPE]) do
		if v[4] ~= 0 then
			table.insert(vals, {k,v[4]});
		end
	end
	table.sort(vals, 
			function(a,b)
				return a[2] > b[2];
			end);
			
	return vals;	
end
function SW_UpdateBars()
	local f = getglobal("SW_BarFrame1");
	local bSet = SW_GetBarSettings("SW_BarFrame1");
	local last;
	local valText = "";
	
	--1.3.1 added DPS to Window title
	--1.3.2 changed this to extra counter and added an option
	--SW_OptUpdateText(pName)
	local selOpt =  SW_Settings["BarFrames"]["SW_BarFrame1"]["Selected"];
	if SW_Settings["OPT_ShowMainWinDPS"] ~= nil then
		local t = getglobal ("SW_BarFrame1_Title_Text");
		if SW_DPS_Dmg > 0 and SW_CombatTime > 5 then
			local dps = math.floor( (SW_DPS_Dmg / SW_CombatTime) * 10 + 0.5) / 10;
			local otf = bSet["OTF"];
			if  otf ~= nil then
				t:SetText(otf.." (DPS:"..dps..")");
			else
				t:SetText(selOpt.." (DPS:"..dps..")");
			end
		else
			local otf = bSet["OTF"];
			if  otf ~= nil then
				t:SetText(otf);
			else
				t:SetText(selOpt);
			end
		end
	else
		local otf = bSet["OTF"];
		local t = getglobal ("SW_BarFrame1_Title_Text");
		if  otf ~= nil then
			t:SetText(otf);
		else
			t:SetText(selOpt);
		end
	end
	--1.2.4 Added this to lessen the "funkyness" of filters
	-- also moved "class copy" here no need to check it in SW_BarsCheckFilters
	-- 1.5 added "GPC" and "GPET" pets and PCs ever in group
	-- do pets first, an MC'd party member will show up as pet
	-- will be overwritten when checking SW_Friends
	for k,v in pairs(SW_PetInfo["PET_OWNER"]) do
		if SW_S_Details[k] ~= nil then
			-- don't mark MC'd mobs as gpet
			if SW_S_Details[k]["UTYPE"] ~= "NPC" then
				SW_S_Details[k]["UTYPE"] = "GPET";
			end
			if SW_S_Details[k]["CLASSE"] == nil then
				SW_S_Details[k]["CLASSE"] = v["CLASSE"];
			end
		end
	end
	for k,v in pairs(SW_Friends) do
		--1.5.1 added Details init for filters to work even with 0 dmg/heal
		if SW_S_Details[k] == nil then
			SW_S_Details[k] = {};
			SW_S_Details[k][SW_PRINT_ITEM_TOTAL_DONE] = {0,0};  --first = dmg; sec = heal
			SW_S_Details[k][SW_PRINT_ITEM_RECIEVED] = {0,0};  --first = dmg; sec = heal
		end
		
		SW_S_Details[k]["UTYPE"] = "GPC";
		if SW_S_Details[k]["CLASSE"] == nil then
			SW_S_Details[k]["CLASSE"] = SW_Friends[k]["CLASSE"];
		end	
	end
	
	
	--vals[1] = text [2]= value [3]= reserved (colorBar) [4] sort order num 
	if f:IsVisible() then
		local vals;
		local total = {};
		
		if bSet["IN"] == nil then
			bSet["IN"] = 1;
		end
		local inf = SW_InfoTypes[ bSet["IN"] ];
		if inf["varType"] == "TEXT" then
			vals = inf["f"](bSet["TV"]);
		elseif inf["varType"] == "SELF" then
			vals = inf["f"](SW_SELF_STRING);
		elseif inf["varType"] == "PETONLY" then
			vals = inf["f"](nil, nil, bSet["PF"], bSet);
		else
			vals = inf["f"](bSet["SF"], bSet["CF"], bSet["PF"], bSet);
		end
	
		if bSet["ShowPercent"] ~= nil then
			for i, v in ipairs(vals) do
				if v[4] == nil then
					v[4] = 1;
				end
				
				if total[ v[4] ] == nil then total[ v[4] ] = 0; end
				total[ v[4] ] = total[ v[4] ] + v[2];
				
				
			end
		end
		
		if vals[1] == nil then 
			
			for i, v in ipairs(SW_Bars["SW_BarFrame1"]) do
				if not v.toWide and v.canBeSeen then
					v:SetValText(" ");
					v:SetValue(100);
					v:SetBarText();
				end
			end
			return; 
		end
		local p1 = vals[1][2] / 100; 
		local lastSortIndex = vals[1][4];
		for i, v in ipairs(SW_Bars["SW_BarFrame1"]) do
			
			if not v.toWide and v.canBeSeen then
				if vals[i] ~= nil then
					
					if bSet["ShowRank"] ~= nil then
						v:SetBarText(i.."   "..vals[i][1]);
					else
						v:SetBarText(vals[i][1]);
					end
					if bSet["ShowNumber"] ~= nil then
						valText = vals[i][2];
					else
						valText = "";
					end
					if bSet["ShowPercent"] ~= nil then
						v:SetValText(valText.." ("..(math.floor((vals[i][2]/total[ vals[i][4] ]) *1000 + 0.5)/10).."%)");
					else
						v:SetValText(valText);
					end
					if lastSortIndex ~= nil then
						if vals[i][4] ~= lastSortIndex then
							lastSortIndex = vals[i][4];
							p1 = vals[i][2] / 100;
						end
					end
					v:SetValue( vals[i][2] /p1);
					if vals[i][3] ~= nil then
						getglobal(v:GetName().."_Texture"):SetVertexColor(unpack(vals[i][3]));
						
					end
				else
					v:SetBarText();
				end
			end
			
		end
	end
end

function SW_SendRepLine(outStr, sVar)
	local sTarget = getglobal(SW_Settings["RepTarget"]).SW_TargetChat;
	if sTarget == "WHISPER" or sTarget == "CHANNEL" then
		if sVar == nil or sVar == "" then return; end
		if sTarget == "CHANNEL" then
			sVar = GetChannelName(sVar);
		end
		SendChatMessage(outStr, sTarget, nil, sVar);
	elseif sTarget == "CLIP" then
		local outWin = getglobal("SW_TextWindow");
		if outWin.txtBuffer == nil then
			outWin.txtBuffer = "";
		end
		outWin.txtBuffer = outWin.txtBuffer.."\r\n"..outStr;
	else
		SendChatMessage(outStr, sTarget);
	end
end


function SW_BuildTextReportData(caller)
	local bSet = SW_GetBarSettings(caller);
	local tw = getglobal("SW_TextWindow");
	tw.repMeta = {};
	tw.repData = {};
	
	local vals;
	local metaData = tw.repMeta;
	
	local inf = SW_InfoTypes[ bSet["IN"] ];
	if inf["varType"] == "TEXT" then
		vals = inf["f"](bSet["TV"]);
		metaData["InfoFor"] = bSet["TV"];
	elseif inf["varType"] == "SELF" then
		vals = inf["f"](SW_SELF_STRING);
		metaData["InfoFor"] = SW_SELF_STRING;
	else
		vals = inf["f"](bSet["SF"], bSet["CF"], bSet["PF"], bSet);
	end
	
	
	metaData["InfoTypeString"] = inf["t"];
	metaData["InfoTypeNum"] = bSet["IN"];
	
	if bSet["SF"] == nil then
		metaData["SelectedFilter"] = getglobal("SW_Filter_None").SW_Filter;
	else
		metaData["SelectedFilter"] = getglobal(bSet["SF"]).SW_Filter;
	end
	
	local classF;
	if bSet["CF"] == nil then
		classF = SW_ClassFilters[1];
	else
		classF = SW_ClassFilters[ bSet["CF"] ];
	end
	
	metaData["ClassFilter"] = classF;
	
	metaData["ClassFilterLocalized"] = SW_ClassNames[classF];
	if metaData["ClassFilterLocalized"] == "" then 
		metaData["ClassFilterLocalized"] = classF;
	end
	
	
	if bSet["ShowPercent"] == nil then
		metaData["ShowPercent"] = false;
	else
		metaData["ShowPercent"] = true;
	end
	if bSet["ShowRank"] == nil then
		metaData["ShowRank"] = false;
	else
		metaData["ShowRank"] = true;
	end
	if bSet["ShowNumber"] == nil then
		metaData["ShowNumber"] = false;
	else
		metaData["ShowNumber"] = true;
	end
	metaData["ReportAmount"] = SW_Settings["ReportAmount"];
	
	if vals[1] == nil then 
		return; 
	end
	
	local total = {};
	for i, v in ipairs(vals) do
		if v[4] == nil then
			v[4] = 1;
		end
		if total[ v[4] ] == nil then total[ v[4] ] = 0; end
		total[ v[4] ] = total[ v[4] ] + v[2];
	end
	for i, v in ipairs(vals) do
		
		v[5] = (math.floor((v[2]/total[ v[4] ]) *1000 + 0.5)/10);
		
	end	
	tw.repData = vals;
	
end

function SW_SendReportOld(caller, sVar)
	if SW_Settings["RepTarget"] == nil then return; end
	
	if getglobal(SW_Settings["RepTarget"]).SW_TargetChat == "CLIP" then 
		SW_BuildTextReportData(caller);
		getglobal("SW_TextWindow"):Show();
		return;
	end
	if not SW_PostCheck(getglobal(SW_Settings["RepTarget"]).SW_TargetChat) then
		StaticPopup_Show("SW_PostFail");
		return;
	end
	
	local bSet = SW_GetBarSettings(caller);
	local vals;
	local useMultiLines = false
	if SW_Settings["RE_Multiline"] ~= nil then
		useMultiLines = true;
	end
	if bSet["IN"] == nil then
		bSet["IN"] = 1;
	end
	local inf = SW_InfoTypes[ bSet["IN"] ];
	if inf["varType"] == "TEXT" then
		vals = inf["f"](bSet["TV"]);
	elseif inf["varType"] == "SELF" then
		vals = inf["f"](SW_SELF_STRING);
	else
		vals = inf["f"](bSet["SF"], bSet["CF"], bSet["PF"], bSet);
	end
	
	if vals[1] == nil then 
		return; 
	end
	
	local outStr=inf["t"].." ";
	if inf["varType"] == "TEXT" then
		outStr = outStr..bSet["TV"].." ";
	end
	if bSet["CF"]~= nil and bSet["CF"] ~= 1 then
		outStr = outStr..SW_ClassNames[ SW_ClassFilters[ bSet["CF"] ] ].." ";
	end
	local tmpLen =string.len(outStr);
	local tmpStr;
	local total = {};
	if bSet["ShowPercent"] ~= nil then
		for i, v in ipairs(vals) do
			if v[4] == nil then
				v[4] = 1;
			end
			
			if total[ v[4] ] == nil then total[ v[4] ] = 0; end
			total[ v[4] ] = total[ v[4] ] + v[2];
			
			
		end
	end
	if useMultiLines then
		SW_SendRepLine(outStr, sVar);
		outStr = "";
	end
	
	for i=1, SW_Settings["ReportAmount"] do
		if vals[i] ~= nil then
			
			if bSet["ShowRank"] ~= nil then
				tmpStr = "["..i..".";
			else
				tmpStr = "[";
			end
			tmpStr = tmpStr..vals[i][1];
			
			if bSet["ShowNumber"] ~= nil then
				tmpStr = tmpStr.." "..vals[i][2];
			end
			if bSet["ShowPercent"] ~= nil then
				tmpStr = tmpStr.." "..(math.floor((vals[i][2]/total[ vals[i][4] ]) *1000 + 0.5)/10).."%";
			end
			tmpStr = tmpStr.."]  ";
		else
			break;
		end
		if useMultiLines then
			SW_SendRepLine(tmpStr, sVar);
		else
			tmpLen = tmpLen + string.len(tmpStr);
			if tmpLen < 256 then
				outStr = outStr..tmpStr;
			else
				break;
			end
		end
	end
	
	if not useMultiLines then
		SW_SendRepLine(outStr, sVar);
	end
	
	--[[
	if getglobal(SW_Settings["RepTarget"]).SW_TargetChat == "CLIP" then 
		local outWin = getglobal("SW_TextWindow");
		local outBox = getglobal("SW_TextWindow_EditBox");
		outBox:SetText( outWin.txtBuffer );
		outWin.txtBuffer = "";
		outBox:HighlightText();
		outWin:Show();
		return; 
	end
	--]]
end
function SW_SendReport(caller, sVar)
	if SW_Settings["RepTarget"] == nil then return; end
	
	if getglobal(SW_Settings["RepTarget"]).SW_TargetChat == "CLIP" then 
		SW_BuildTextReportData(caller);
		getglobal("SW_TextWindow"):Show();
		return;
	end
	if not SW_PostCheck(getglobal(SW_Settings["RepTarget"]).SW_TargetChat) then
		StaticPopup_Show("SW_PostFail");
		return;
	end
	
	local bSet = SW_GetBarSettings(caller);
	local vals;
	local useMultiLines = false
	if SW_Settings["RE_Multiline"] ~= nil then
		useMultiLines = true;
	end
	if bSet["IN"] == nil then
		bSet["IN"] = 1;
	end
	local inf = SW_InfoTypes[ bSet["IN"] ];
	if inf["varType"] == "TEXT" then
		vals = inf["f"](bSet["TV"]);
	elseif inf["varType"] == "SELF" then
		vals = inf["f"](SW_SELF_STRING);
	else
		vals = inf["f"](bSet["SF"], bSet["CF"], bSet["PF"], bSet);
	end
	
	if vals[1] == nil then 
		return; 
	end
	
	local outStr=" -------- "..inf["t"].." ";
	if inf["varType"] == "TEXT" then
		outStr = outStr..":: "..bSet["TV"].." ";
	end
	if bSet["CF"]~= nil and bSet["CF"] ~= 1 then
		outStr = outStr..SW_ClassNames[ SW_ClassFilters[ bSet["CF"] ] ].." ";
	end
	local tmpLen =string.len(outStr);
	local tmpStr ="";
	local total = {};
	if bSet["ShowPercent"] ~= nil then
		for i, v in ipairs(vals) do
			if v[4] == nil then
				v[4] = 1;
			end
			
			if total[ v[4] ] == nil then total[ v[4] ] = 0; end
			total[ v[4] ] = total[ v[4] ] + v[2];
			
			
		end
	end
	outStr=outStr.." -------- ";
	if useMultiLines then
		SW_SendRepLine(outStr, sVar);
		outStr = "";
	end
	
	for i=1, SW_Settings["ReportAmount"] do
		if vals[i] ~= nil then
			
			if i < 10 then
				tmpStr = "  #0"..i..":  ";
			else
				tmpStr = "  #"..i..":  ";
			end

			tmpStr = tmpStr..vals[i][1];
			
			if bSet["ShowNumber"] ~= nil then
				tmpStr = tmpStr.."  -  "..vals[i][2];
			end
			if bSet["ShowPercent"] ~= nil then
				tmpStr = tmpStr.."  -  "..(math.floor((vals[i][2]/total[ vals[i][4] ]) *1000 + 0.5)/10).."%";
			end
		else
			break;
		end
		if useMultiLines then
			SW_SendRepLine(tmpStr, sVar);
		else
			tmpLen = tmpLen + string.len(tmpStr);
			if tmpLen < 256 then
				outStr = outStr..tmpStr;
			else
				break;
			end
		end
	end
	
	if not useMultiLines then
		SW_SendRepLine(outStr, sVar);
	end
	
	--[[
	if getglobal(SW_Settings["RepTarget"]).SW_TargetChat == "CLIP" then 
		local outWin = getglobal("SW_TextWindow");
		local outBox = getglobal("SW_TextWindow_EditBox");
		outBox:SetText( outWin.txtBuffer );
		outWin.txtBuffer = "";
		outBox:HighlightText();
		outWin:Show();
		return; 
	end
	--]]
end