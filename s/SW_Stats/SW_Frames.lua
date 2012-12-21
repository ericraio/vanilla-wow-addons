
SW_TabbedFrameInfo = {};
-- 1.5 added FrameOrder
SW_TabbedFrameOrder = {};

SW_ChkParentInfo = {};
SW_ChkInfo = {};
SW_ChkOptInfo = {};

-- tab colors
SW_COLOR_ACT = {["r"]=0.7, ["g"]=0.7, ["b"]=1};
SW_COLOR_DIS = {["r"]=1, ["g"]=1, ["b"]=1};

local function SW_FrameSetText(itemName, itemText, addWidth)
	local oItem = getglobal(itemName);
	local txtName = getglobal(itemName.."_Text");
	txtName:SetText(itemText);
	oItem:SetWidth(txtName:GetStringWidth() + addWidth);
end
function SW_TabSetText(tabName, tabText)
	SW_FrameSetText(tabName, tabText, 30);
end

function SW_TitleSetText(titleName, titleText)
	SW_FrameSetText(titleName, titleText, 100);
	local txtName = getglobal(titleName.."_Text");
	txtName:SetTextColor(1,1,1);
end
function SW_ChkClick(oChk, saveTarget, silent)

	if saveTarget == nil then
		saveTarget = SW_Settings;
	end
	
	if oChk.SW_optGroup ~= nil then
		if not silent then
			PlaySound("igMainMenuOptionCheckBoxOn");
		end
		for _,v in SW_ChkOptInfo[oChk.SW_optGroup] do
			getglobal(v):SetChecked(0);
		end
		oChk:SetChecked(1);
		saveTarget[oChk.SW_optGroup] = oChk:GetName();
	else
		if ( oChk:GetChecked() ) then
			if not silent then
				PlaySound("igMainMenuOptionCheckBoxOn");
			end
			saveTarget[ SW_ChkInfo[oChk:GetName()] ] = 1;
		else
			if not silent then
				PlaySound("igMainMenuOptionCheckBoxOff");
			end
			saveTarget[ SW_ChkInfo[oChk:GetName()] ] = nil;
		end
	end
		
	-- this really shouldn't be here.. but its easy..
	SW_EI_ALLOFF = not (SW_Settings["EI_ShowRegEx"] or  SW_Settings["EI_ShowMatch"]
					or SW_Settings["EI_ShowEvent"] or SW_Settings["EI_ShowOrigStr"]);
end

function SW_SetChkStates()
	if SW_Settings == nil then return; end
	for k,v in pairs(SW_ChkInfo) do
		if SW_Settings[v] == 1 then
			getglobal(k):SetChecked(1); 
		else
			-- if its not on, no need to save it
			SW_Settings[v] = nil; 
		end
	end	
	for k,v in pairs(SW_ChkOptInfo) do
		SW_printStr(v);
		for _,opt in ipairs(v) do
			if SW_Settings[k] == opt then
				getglobal(opt):SetChecked(1); 
			else
				getglobal(opt):SetChecked(0); 
			end
		end
	end	
end
function SetButtonText(bName, str)
	getglobal(bName):SetText(str);
end
function SW_ChkRegister(oChk, linkedSetting, isAnchor, optGroupName)
	local pName = oChk:GetParent():GetName();
	
	if SW_ChkParentInfo[pName] == nil then SW_ChkParentInfo[pName] = {}; end
	if isAnchor then
		SW_ChkParentInfo[pName][0] = oChk:GetName();
	end
	table.insert(SW_ChkParentInfo[pName], oChk:GetName());
	SW_ChkInfo[oChk:GetName()] = linkedSetting;
	
	if optGroupName ~= nil then
		if SW_ChkOptInfo[optGroupName] == nil then
			SW_ChkOptInfo[optGroupName] = {};
		end
		table.insert(SW_ChkOptInfo[optGroupName], oChk:GetName());
		oChk.SW_optGroup = optGroupName;
	end
end

function SW_ChkLayoutRegisterd()
	local oStart;
	local posX = 0;
	local currX = 0;
	local posY = 0;
	local incY = 0;
	local boxWidth = 0;
	local spacerX = 0;
	
	local chkPerRow =0;
	local oChkText;
	local oChk;
	
	local iCol=0;
	local colMax = {};
	for fName, children in pairs(SW_ChkParentInfo) do
		colMax = {};
		chkPerRow = getglobal(fName).chkPerRow;
		if chkPerRow == nil then chkPerRow = 2; end

		if children[0] == nil then
			oStart = getglobal(children[1]);
		else
			oStart = getglobal(children[0]);
		end
	
		
		posX = oStart.swoX;
		
		if posX == nil then posX=0; end
		posY = oStart.swoY;
		if posY == nil then posY=0; end
		
		incY = oStart:GetHeight();
		boxWidth = oStart:GetWidth();
		spacerX = boxWidth / 2;
		iCol = 0;
		-- first we need max text width per column
		for i,v in ipairs(children) do
			iCol = iCol + 1;
			oChkText = getglobal(v.."Text");
			if colMax[iCol] == nil then 
				colMax[iCol] = oChkText:GetStringWidth();
			else
				if oChkText:GetStringWidth() > colMax[iCol] then
					colMax[iCol] = oChkText:GetStringWidth();
				end
			end
			
			if floor (iCol / chkPerRow) == 1 then
				iCol = 0;
			end
		end
		iCol = 0;
		for i,v in ipairs(children) do
			iCol = iCol + 1;
			oChk = getglobal(v);
			if iCol == 1 then
				currX = posX;
			else 
				currX = currX + colMax[iCol-1] + spacerX + boxWidth;
			end
			oChk:SetPoint("TOPLEFT",fName,"TOPLEFT",currX,posY);
			
			if floor (iCol / chkPerRow) == 1 then
				iCol = 0;
				posY = posY - incY;
			end
		end
	end
end
function SW_TabRegister(oTab, linkedFrameName, activated)
	local pName = oTab:GetParent():GetName();
	if activated then
		oTab.IsSelectedTab = true;
		oTab:SetBackdropBorderColor(SW_COLOR_ACT["r"],SW_COLOR_ACT["g"],SW_COLOR_ACT["b"],1);
		getglobal(oTab:GetName().."_Text"):SetTextColor(SW_COLOR_ACT["r"],SW_COLOR_ACT["g"],SW_COLOR_ACT["b"]);
		oTab:SetFrameLevel(oTab:GetParent():GetFrameLevel() +1);
	else
		oTab.IsSelectedTab = nil;
		oTab:SetBackdropBorderColor(SW_COLOR_DIS["r"],SW_COLOR_DIS["g"],SW_COLOR_DIS["b"],1);
		getglobal(oTab:GetName().."_Text"):SetTextColor(SW_COLOR_DIS["r"],SW_COLOR_DIS["g"],SW_COLOR_DIS["b"]);
		oTab:SetFrameLevel(oTab:GetParent():GetFrameLevel() -1);
	end
	oTab:Show();
	if SW_TabbedFrameInfo[pName] == nil then SW_TabbedFrameInfo[pName] = {}; end
	SW_TabbedFrameInfo[pName][oTab:GetName()] = linkedFrameName;
	if SW_TabbedFrameOrder[pName] == nil then SW_TabbedFrameOrder[pName] = {}; end
	table.insert(SW_TabbedFrameOrder[pName], oTab:GetName());
end

--[[ this will space all registered tabs in relation to their parent,
	 if there are to many tabs or the parent frame ist to small
	 this can have odd visuals
	 don't forget - in one language it may work, in another not
	 the "original" width is set through SW_TabSetText and depends on the string displayed
]]--
local function SW_TabLayoutRegisterd()
	local pos=0;
	local oTab;
	for k,v in pairs(SW_TabbedFrameInfo) do
		pos=5;
		--[[
		for t,_ in pairs(v) do
			oTab = getglobal(t);
			oTab:SetPoint("BOTTOMLEFT",k,"BOTTOMLEFT",pos,-25) 
			pos = pos + oTab:GetWidth() - 2;
		end
		--]]
		for _,t in ipairs(SW_TabbedFrameOrder[k]) do
			oTab = getglobal(t);
			oTab:SetPoint("BOTTOMLEFT",k,"BOTTOMLEFT",pos,-25) 
			pos = pos + oTab:GetWidth() - 2;
		end
	end
end

function SW_TabClick(oTab)
	local pFrameL = oTab:GetParent():GetFrameLevel();
	local tabName = oTab:GetName();
	local tmpTab;
	
	for t,frameName in pairs(SW_TabbedFrameInfo[oTab:GetParent():GetName()]) do
		tmpTab = getglobal(t);
		if tmpTab:GetName() == tabName then
			oTab:SetFrameLevel(pFrameL +1);	
			local tmpCol = {unpack(SW_Settings["Colors"]["Backdrops"])};
			tmpCol[4] = 1;
			oTab:SetBackdropBorderColor(unpack(tmpCol));
			getglobal(tabName.."_Text"):SetTextColor(unpack(tmpCol));
			getglobal(frameName):Show();
			oTab.IsSelectedTab = true;
		else
			--[[
				0.96
				for some odd reason pFrameL can be 0 and a negative frame level raises an error
			--]]
			if pFrameL > 0 then
				tmpTab:SetFrameLevel(pFrameL -1);
			end
			oTab.IsSelectedTab = nil;
			tmpTab:SetBackdropBorderColor(SW_COLOR_DIS["r"],SW_COLOR_DIS["g"],SW_COLOR_DIS["b"],1);
			getglobal(tmpTab:GetName().."_Text"):SetTextColor(SW_COLOR_DIS["r"],SW_COLOR_DIS["g"],SW_COLOR_DIS["b"]);
			getglobal(frameName):Hide();
		end
	end
end
function SW_UpdateIconPos() 
	local ang = 20;
	local r = 80;
	if SW_Settings["SW_IconPos"] ~= nil then
		ang = SW_Settings["SW_IconPos"];
	end
	if SW_Settings["SW_IconPosR"] ~= nil then
		r = SW_Settings["SW_IconPosR"];
	end
	
	SW_IconFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 58 - (r * cos(ang)), (r * sin(ang)) - 58);
end
function SW_DoLayout()
	SW_TabLayoutRegisterd();
	SW_ChkLayoutRegisterd();
	SW_UpdateIconPos()
end

function SW_InitColorSwatch(cs)
	cs.lbl =  getglobal(cs:GetName().."_Text");
	cs.colTexture = getglobal(cs:GetName().."_Button_Color");
	function cs:SetText(txt)
		self.lbl:SetText(txt);
	end
	function cs:SetColor(color, what)
		if type(color) == "table" then
			self.colTexture:SetVertexColor(unpack(color));
		else
			
			local bfc = SW_GetBarSettings(color)[what];
			if bfc[1]==1 and bfc[2]==0 and bfc[3]==0 and bfc[4]==1 then
				self.colTexture:SetVertexColor(unpack(SW_Settings["Colors"]["TitleBars"]));
			else
				self.colTexture:SetVertexColor(unpack(bfc));
			end
			
		end
	end
end

function SW_UpdateTextSetting(newText, info)
	local barSettings = SW_GetBarSettings(info[1]);
	barSettings[ info[2] ] = newText;
	if info[2] == "OT" or info[2] == "OTF" then
		SW_OptUpdateText(info[1]);
	end
end

function SW_InitEditBox(ef)
	function ef:ChangeText()
		local info = SW_GS_EditBoxes[ef:GetName()];
		if info == nil then return; end
		getglobal(ef:GetName().."_Button"):SetText(info[1]);
		getglobal(ef:GetName().."_Text"):SetText(info[2]..self.CurrentVal);
		self.PopupText = info[3];
	end
end
function SW_SetSliderPreText(slname, str)
	local sl = getglobal(slname);
	if sl ~= nil then
		sl.preTxt = str;
	end
end
function SW_InitSlider(sl, min, max, setting)
	sl.linkedSetting = setting;
	getglobal(sl:GetName().."Low"):SetText(min);
	getglobal(sl:GetName().."High"):SetText(max);
	this:SetMinMaxValues(min, max);
	this:SetValueStep(1);
end
function SW_SetColorSwatchText(csname, str)
	local cs = getglobal(csname);
	if cs ~= nil then
		cs:SetText(str);
	end
end
function SW_InitRoundButton(b)
	b.NormalF = getglobal(b:GetName().."_Normal");
	b.HighlightF = getglobal(b:GetName().."_Highlight");
	b.NormalT = getglobal(b:GetName().."_Normal_Texture");
	b.HighlightT = getglobal(b:GetName().."_Highlight_Texture");
	b.NormalText = getglobal(b:GetName().."_Normal_Text");
	b.HighlightText = getglobal(b:GetName().."_Highlight_Text");
	b.NormalIcon = getglobal(b:GetName().."_Normal_TextureIcon");
	b.HighlightIcon = getglobal(b:GetName().."_Highlight_TextureIcon");
	b.NormalT:SetVertexColor(0,1,0,1);
	b.HighlightT:SetVertexColor(0,1,0,1);
	b.NormalIcon:Hide();
	b.HighlightIcon:Hide();
	
	b.SetIcons = function(self, normalTex, highlightTex)
		if normalTex == nil then return; end
		self.NormalIcon:SetTexture(normalTex);
		
		if highlightTex == nil then
			self.NormalIcon:SetTexture(normalTex);
		else
			self.HighlightIcon:SetTexture(highlightTex);
		end
		self.NormalIcon:Show();
		self.HighlightIcon:Show();
		self.NormalText:Hide();
		self.HighlightText:Hide();
	end
	
end
function SW_RoundButtonRegister(b, vColor, txt, fColor, fHeight, fForeColor)
	SW_InitRoundButton(b);
	if vColor ~= nil then
		b.NormalT:SetVertexColor(unpack(vColor));
		b.HighlightT:SetVertexColor(unpack(vColor));
	end
	if txt ~= nil then
		b.NormalText:SetText(txt);
		b.HighlightText:SetText(txt);
	end
	if fColor ~= nil then
		b.NormalText:SetVertexColor(unpack(fColor));
		b.HighlightText:SetVertexColor(unpack(fColor));
	end
	if fHeight ~= nil then
		b.NormalText:SetTextHeight(fHeight);
		b.HighlightText:SetTextHeight(fHeight);
	end
	if fForeColor == nil then
		b.NormalText:SetTextColor(1,1,1,1);
		b.HighlightText:SetTextColor(1,1,1,1);
	else
		b.NormalText:SetTextColor(unpack(fForeColor));
		b.HighlightText:SetTextColor(unpack(fForeColor));
	end
end

function SW_InitIconMenu()
	for k, v in ipairs(SW_MiniIconMenu) do
	
		if v["checkFrame"] ~= nil then
			if getglobal(v["checkFrame"]):IsVisible() then
				v["text"] = v["textHide"];
			else
				v["text"] = v["textShow"];
			end
		end
		UIDropDownMenu_AddButton(v);
		
	end
	--UIDropDownMenu_AddButton(SW_MiniIconMenu[1]);
end
function SW_ToggleIconMenu()
	SW_IconFrame_Menu.point = "TOPRIGHT";
	--SW_IconFrame_Menu.relativePoint = "BOTTOMLEFT";
	ToggleDropDownMenu(1, nil, SW_IconFrame_Menu);
end
function SW_IconMenuInit()
	UIDropDownMenu_Initialize(getglobal("SW_IconFrame_Menu"), SW_InitIconMenu, "MENU");  
end