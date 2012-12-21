IMBA_BLACKBOARD_MAX_TEXTBOXES	=	20

IMBA_Blackboard_Mode=2
IMBA_Blackboard_AddTextBox_Num=0;
IMBA_Blackboard_Colors={};
IMBA_Blackboard_Colors[1]={1,1,1,1};
IMBA_Blackboard_Colors[2]={0,0,0,1};

IMBA_Blackboard_Zone=IMBA_LOCATIONS_NAXX;

IMBA_MapsSorted=false;

function IMBA_Blackboard_MapImageSort(v1,v2)
	return v1.name<v2.name;
end

function IMBA_Blackboard_SortMaps()
	if not IMBA_MapsSorted then
		sort(IMBA_MapImages,IMBA_Blackboard_MapImageSort);
		sort(IMBA_MapZones);
		IMBA_MapsSorted=true;
	end
end

function IMBA_Blackboard_OnLoad()
	this:SetBackdropBorderColor(1, 1, 1, 1);
	this:SetBackdropColor(0.0,0.0,0.0,0.6);

	
	IMBA_Blackboard_Title:SetText("Blackboard");
	IMBA_AddAddon("Blackboard", "A board for interactive strategy designing ingame", IMBA_LOCATIONS_OTHER, nil, nil,nil,"IMBA_Blackboard");
	IMBA_Blackboard_NextUpdate=0;
	IMBA_Blackboard_LastTextbox=0;
	IMBA_Blackboard_SelectedImage=0;
	IMBA_Blackboard_Canvas_MouseDown=false;

	

	
	IMBA_Blackboard_Zone=IMBA_MapImages[1].zone;
	IMBA_Blackboard_SetMap(IMBA_MapImages[1].name);
	this:RegisterEvent("CHAT_MSG_ADDON");
end

function IMBA_Blackboard_SendMap(id)
	if IMBA_IsPlayerALeader() then
		if GetNumRaidMembers()>0 then
			IMBA_AddMsg("IMBA_BLACKBOARD","MAP "..IMBA_MapImages[id].name,"RAID");
		else
			IMBA_AddMsg("IMBA_BLACKBOARD","MAP "..IMBA_MapImages[id].name,"PARTY");
		end
	end
end

function IMBA_Blackboard_MapImageDropDown_OnLoad()
	IMBA_Blackboard_SortMaps();
	UIDropDownMenu_Initialize(this, IMBA_Blackboard_MapImageDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(IMBA_Blackboard_MapImageDropDown,1);
end

function IMBA_Blackboard_MapImageDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(IMBA_Blackboard_MapImageDropDown, this.value);
	--UIDropDownMenu_SetSelectedID(IMBA_Blackboard_MapImageDropDown,this.value);
	IMBA_Blackboard_Canvas_BG:SetTexture(IMBA_MapImages[this.value].image);

	IMBA_Blackboard_SendMap(this.value)
	
	IMBA_Blackboard_MapImageDropDownText:SetText(IMBA_MapImages[this.value].name);
	IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,10);
	if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
		IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,9);
		if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
			IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,8);
			if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
				IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,7.5);
			end
		end
	end
end

function IMBA_Blackboard_MapImageDropDown_Initialize()	
	for k,v in IMBA_MapImages do
		if v.zone==IMBA_Blackboard_Zone then
			info = {};
			info.text = v.name;
			info.value = k;
			info.func = IMBA_Blackboard_MapImageDropDown_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	end
end

function IMBA_Blackboard_MapZoneDropDown_OnLoad()
	IMBA_Blackboard_SortMaps();
	UIDropDownMenu_Initialize(this, IMBA_Blackboard_MapZoneDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(IMBA_Blackboard_MapZoneDropDown,1);

	--UIDropDownMenu_Initialize(IMBA_Blackboard_MapImageDropDown, IMBA_Blackboard_MapImageDropDown_Initialize);
	--UIDropDownMenu_SetSelectedID(IMBA_Blackboard_MapImageDropDown,1);

	IMBA_Blackboard_Zone=IMBA_MapZones[1];
	for k,v in IMBA_MapImages do
		if v.zone==IMBA_Blackboard_Zone then
			--IMBA_Blackboard_Canvas_BG:SetTexture(v.image);
			IMBA_Blackboard_SendMap(k)
			return;
		end
	end
end

function IMBA_Blackboard_MapZoneDropDown_OnClick()
	UIDropDownMenu_SetSelectedValue(IMBA_Blackboard_MapZoneDropDown, this.value);
	UIDropDownMenu_SetSelectedID(IMBA_Blackboard_MapZoneDropDown,this.value);

	IMBA_Blackboard_Zone=IMBA_MapZones[this.value]

	IMBA_Blackboard_MapZoneDropDownText:SetFont(STANDARD_TEXT_FONT,10);
	if IMBA_Blackboard_MapZoneDropDownText:GetStringWidth()>100 then
		IMBA_Blackboard_MapZoneDropDownText:SetFont(STANDARD_TEXT_FONT,9);
		if IMBA_Blackboard_MapZoneDropDownText:GetStringWidth()>100 then
			IMBA_Blackboard_MapZoneDropDownText:SetFont(STANDARD_TEXT_FONT,8);
			if IMBA_Blackboard_MapZoneDropDownText:GetStringWidth()>100 then
				IMBA_Blackboard_MapZoneDropDownText:SetFont(STANDARD_TEXT_FONT,7.5);
			end
		end
	end


	UIDropDownMenu_Initialize(IMBA_Blackboard_MapImageDropDown, IMBA_Blackboard_MapImageDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(IMBA_Blackboard_MapImageDropDown,1);

	for k,v in IMBA_MapImages do
		if v.zone==IMBA_Blackboard_Zone then
			IMBA_Blackboard_Canvas_BG:SetTexture(v.image);
			IMBA_Blackboard_SendMap(k)

			IMBA_Blackboard_MapImageDropDownText:SetText(v.name);
			IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,10);
			if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
				IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,9);
				if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
					IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,8);
					if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
						IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,7.5);
					end
				end
			end
			return;
		end
	end
	
	
end

function IMBA_Blackboard_MapZoneDropDown_Initialize()	

	for k,v in IMBA_MapZones do
		info = {};
		info.text = v;
		info.value = k;
		info.func = IMBA_Blackboard_MapZoneDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end


--Button Functions
function IMBA_Blackboard_NewImage()
	if IMBA_IsPlayerALeader() then
		if GetNumRaidMembers()>0 then
			IMBA_AddMsg("IMBA_LINES_IMBA_Blackboard","ERASEALL","RAID");
		else
			IMBA_AddMsg("IMBA_LINES_IMBA_Blackboard","ERASEALL","PARTY");
		end
	end

	for i=1, IMBA_BLACKBOARD_MAX_TEXTBOXES do
		getglobal("IMBA_Blackboard_Canvas_Text"..i):Hide();
	end

	for i=1, 8  do
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i):Hide();
	end

	IMBA_ClearLines(IMBA_Blackboard_Canvas);
end

function IMBA_Blackboard_ModeButton(i)
	if i==1 then
		return IMBA_Blackboard_ButtonCursor;
	elseif i==2 then
		return IMBA_Blackboard_ButtonPencil;
	elseif i==3 then
		return IMBA_Blackboard_ButtonType;
	elseif i==4 then
		return IMBA_Blackboard_ButtonEraser;
	elseif i<=12 then
		return getglobal("IMBA_Blackboard_ButtonRaidIcon"..i-4);
	end
	return nil
end

function IMBA_Blackboard_UnselectAll()
	for i=1,12 do
		getglobal(IMBA_Blackboard_ModeButton(i):GetName().."_Selected"):Hide()
	end
end

function IMBA_BlackboardColor1Changed()
	local color=IMBA_Blackboard_Color1.color;
	IMBA_Blackboard_Colors[1]={color.r,color.g,color.b,color.a};
	for i=1, IMBA_BLACKBOARD_MAX_TEXTBOXES,1 do
		if getglobal("IMBA_Blackboard_Canvas_Text"..i).editbox.hasFocus then
			getglobal("IMBA_Blackboard_Canvas_Text"..i):SetTextColor(IMBA_Blackboard_Colors[1])
		end
	end
end

function IMBA_BlackboardColor2Changed()
	local color=IMBA_Blackboard_Color2.color;
	IMBA_Blackboard_Colors[2]={color.r,color.g,color.b,color.a};
	for i=1, IMBA_BLACKBOARD_MAX_TEXTBOXES,1 do
		if getglobal("IMBA_Blackboard_Canvas_Text"..i).editbox.hasFocus then
			getglobal("IMBA_Blackboard_Canvas_Text"..i):SetBGColor(IMBA_Blackboard_Colors[2])
		end
	end
end

function IMBA_Blackboard_SwapColors()
	local temp=IMBA_Blackboard_Colors[1];
	IMBA_Blackboard_Colors[1]=IMBA_Blackboard_Colors[2];
	IMBA_Blackboard_Color1.color={r=IMBA_Blackboard_Colors[2][1];g=IMBA_Blackboard_Colors[2][2];b=IMBA_Blackboard_Colors[2][3];a=IMBA_Blackboard_Colors[2][4]};
	IMBA_Blackboard_Color1_BG:SetVertexColor(IMBA_Blackboard_Colors[2][1],IMBA_Blackboard_Colors[2][2],IMBA_Blackboard_Colors[2][3]);
	IMBA_Blackboard_Colors[2]=temp;
	IMBA_Blackboard_Color2.color={r=IMBA_Blackboard_Colors[2][1];g=IMBA_Blackboard_Colors[2][2];b=IMBA_Blackboard_Colors[2][3];a=IMBA_Blackboard_Colors[2][4]};
	IMBA_Blackboard_Color2_BG:SetVertexColor(IMBA_Blackboard_Colors[2][1],IMBA_Blackboard_Colors[2][2],IMBA_Blackboard_Colors[2][3]);
	for i=1, IMBA_BLACKBOARD_MAX_TEXTBOXES,1 do
		if getglobal("IMBA_Blackboard_Canvas_Text"..i).editbox.hasFocus then
			getglobal("IMBA_Blackboard_Canvas_Text"..i):SetTextColor(IMBA_Blackboard_Colors[1])
			getglobal("IMBA_Blackboard_Canvas_Text"..i):SetBGColor(IMBA_Blackboard_Colors[2])
		end
	end
end


--Canvas Functions
function IMBA_Blackboard_SetMap(map)
	local id=1;
	for k,v in IMBA_MapImages do
		if v.name==map then
			IMBA_Blackboard_SetZone(v.zone);
			UIDropDownMenu_SetSelectedID(IMBA_Blackboard_MapImageDropDown,IMBA_Blackboard_MapID(v.name,v.zone));
			IMBA_Blackboard_Canvas_BG:SetTexture(v.image);
	
			IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,10);
			if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
				IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,9);
				if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
					IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,8);
					if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
						IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,7.5);
					end
				end
			end
			return;
		end
	end
end

function IMBA_Blackboard_MapID(map,zone)
	local id=1;
	for k,v in IMBA_MapImages do
		if v.name==map then
			return id;
		end
		if v.zone==zone then
			id=id+1;
		end
	end
	return 1;
end

function IMBA_Blackboard_SetZone(zone)
	for k,v in IMBA_MapZones do
		if v==zone then
			UIDropDownMenu_SetSelectedID(IMBA_Blackboard_MapImageDropDown,k);
	
			IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,10);
			if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
				IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,9);
				if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
					IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,8);
					if IMBA_Blackboard_MapImageDropDownText:GetStringWidth()>100 then
						IMBA_Blackboard_MapImageDropDownText:SetFont(STANDARD_TEXT_FONT,7.5);
					end
				end
			end
			return;
		end
	end
end


function IMBA_Blackboard_OnCanvas(x,y)
	if (x>=(IMBA_Blackboard_Canvas:GetWidth())) or (x<0) or (y>=(IMBA_Blackboard_Canvas:GetHeight())) or (y<0) then
		return false
	end
	return true;
end

function IMBA_Blackboard_Canvas_AddTextBox()
	if IMBA_Blackboard_AddTextBox_Num>=IMBA_BLACKBOARD_MAX_TEXTBOXES then
		return
	end
	local Box
	for i=1,IMBA_BLACKBOARD_MAX_TEXTBOXES do 
		if not getglobal("IMBA_Blackboard_Canvas_Text"..i):IsShown() then
			Box=getglobal("IMBA_Blackboard_Canvas_Text"..i)
		end
	end
	IMBA_Blackboard_AddTextBox_Num=IMBA_Blackboard_AddTextBox_Num+1;
	
	local X,Y = GetCursorPosition();
	X=X/IMBA_Blackboard_Canvas:GetEffectiveScale()-IMBA_Blackboard_Canvas:GetLeft();
	Y=Y/IMBA_Blackboard_Canvas:GetEffectiveScale()-IMBA_Blackboard_Canvas:GetBottom();

	Box:ClearAllPoints();

	Box:SetPoint("BOTTOMLEFT",this,"BOTTOMLEFT",X,Y);

	Box:SetTextColor(IMBA_Blackboard_Colors[1]);
	Box:SetBGColor(IMBA_Blackboard_Colors[2]);
	Box.text:SetText("");
	Box.editbox:SetText("");

	Box:Show();
	getglobal(Box:GetName().."_Editbox"):SetFocus();
	IMBA_Blackboard_SendText(Box:GetID());
end

function IMBA_Blackboard_Canvas_OnUpdate()
	if IMBA_Blackboard_NextUpdate>GetTime() and not MouseIsOver(IMBA_Blackboard_Canvas) then
		return
	end

	IMBA_Blackboard_NextUpdate=GetTime()+0.05;

	if not IMBA_Blackboard_Canvas_MouseDown then
		IMBA_Blackboard_LastX=nil;
		IMBA_Blackboard_LastY=nil
		if IMBA_StrokeStarted(IMBA_Blackboard_Canvas) then
			IMBA_EndStroke(IMBA_Blackboard_Canvas);
		end
		return;
	end

	local X,Y = GetCursorPosition();
	X=X/IMBA_Blackboard_Canvas:GetEffectiveScale()-IMBA_Blackboard_Canvas:GetLeft();
	Y=Y/IMBA_Blackboard_Canvas:GetEffectiveScale()-IMBA_Blackboard_Canvas:GetBottom();
	
	if not IMBA_Blackboard_OnCanvas(X,Y) then
		IMBA_Blackboard_LastX=nil;
		IMBA_Blackboard_LastY=nil
		
		return;
	end
	
	if IMBA_Blackboard_Mode==2  then
		if IMBA_Blackboard_LastX and IMBA_Blackboard_LastY then				
			local Dist=math.abs(X-IMBA_Blackboard_LastX)+math.abs(X-IMBA_Blackboard_LastY)
			if Dist<=7 then
				return;
			end
			IMBA_DrawLine(IMBA_Blackboard_Canvas,IMBA_Blackboard_LastX,IMBA_Blackboard_LastY,X,Y,32,IMBA_Blackboard_Colors[1])

			if not IMBA_StrokeStarted(IMBA_Blackboard_Canvas) then
				IMBA_StartStroke(IMBA_Blackboard_Canvas,IMBA_Blackboard_Colors[1],32,IMBA_Blackboard_LastX,IMBA_Blackboard_LastY,X,Y);
			else
				IMBA_AddToStroke(IMBA_Blackboard_Canvas,X,Y)
			end
		end
		IMBA_Blackboard_LastX=X;
		IMBA_Blackboard_LastY=Y;
	elseif IMBA_Blackboard_Mode==3 and (IMBA_Blackboard_LastTextbox+0.2)<GetTime()then
		IMBA_Blackboard_Canvas_AddTextBox()
		IMBA_Blackboard_LastTextbox=GetTime();
		IMBA_Blackboard_Canvas_MouseDown=false;
	elseif IMBA_Blackboard_Mode==4 then
		if IMBA_StrokeStarted(IMBA_Blackboard_Canvas) then
			 IMBA_EndStroke(IMBA_Blackboard_Canvas)
		end
		
		IMBA_EraseLines(IMBA_Blackboard_Canvas,X,Y,12);
		IMBA_AddMsg("IMBA_LINES_IMBA_Blackboard_Canvas",string.format("ERASE %.1f %.1f",X,Y),"RAID");
		
		IMBA_Blackboard_LastX=nil;
		IMBA_Blackboard_LastY=nil
	elseif (IMBA_Blackboard_Mode>=5) and(IMBA_Blackboard_Mode<=12) then
		local X,Y = GetCursorPosition();
		X=X/IMBA_Blackboard_Canvas:GetEffectiveScale()-IMBA_Blackboard_Canvas:GetLeft();
		Y=Y/IMBA_Blackboard_Canvas:GetEffectiveScale()-IMBA_Blackboard_Canvas:GetBottom();

		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..IMBA_Blackboard_Mode-4):ClearAllPoints();

		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..IMBA_Blackboard_Mode-4):SetPoint("CENTER",this,"BOTTOMLEFT",X,Y);
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..IMBA_Blackboard_Mode-4):Update();
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..IMBA_Blackboard_Mode-4):Show();
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..IMBA_Blackboard_Mode-4):StartMoving();
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..IMBA_Blackboard_Mode-4).isMoving = true;

		IMBA_Blackboard_SendRaidIcon(IMBA_Blackboard_Mode-4);

		IMBA_Blackboard_Canvas_MouseDown=false;
		

		IMBA_Blackboard_LastX=nil;
		IMBA_Blackboard_LastY=nil
	else
		
		IMBA_Blackboard_LastX=nil;
		IMBA_Blackboard_LastY=nil
	end
end



--Text Templates
function IMBA_Blackboard_TextTemplate_OnLoad(b)
	this.text=getglobal(this:GetName().."_Text");
	this.editbox=getglobal(this:GetName().."_Editbox");
	this.bg=getglobal(this:GetName().."_BG");

	this.bg:SetVertexColor(0.5,0,0,0.5);
	this.text:Hide();

	function this:LockBox()
		b.text:Show();
		b.editbox:Hide();
		b.isLocked=false;
	end
	function this:UnlockBox()
		b.text:Hide();
		b.editbox:Show();
		b.isLocked=true;
	end
	function this:ShowBackground()
		b.bg:Show();
	end
	function this:HideBackground()
		b.bg:Hide();
	end
	function this:Update()
		local left=b:GetLeft()-b:GetParent():GetLeft();
		local mid=(b:GetBottom()+b:GetTop()-b:GetParent():GetBottom()-b:GetParent():GetTop())/2;

		if (left+b:GetWidth())>b:GetParent():GetWidth() then
			left=b:GetParent():GetWidth()-(b:GetWidth());
		end
		if left<0 then
			left=0;
		end

		if (mid+b:GetHeight()/2)>b:GetParent():GetHeight()/2 then
			mid=b:GetParent():GetHeight()/2-(b:GetHeight()/2);
		end
		if (mid-b:GetHeight()/2)<-b:GetParent():GetHeight()/2 then
			mid=(b:GetHeight()/2)-b:GetParent():GetHeight()/2;
		end

		b:ClearAllPoints();
		b:SetPoint("LEFT",b:GetParent(),"LEFT",left,mid);
	end

	function this:SetTextColor(color)
		b.text:SetTextColor(color[1],color[2],color[3],color[4]);
		b.editbox:SetTextColor(color[1],color[2],color[3],color[4]);
		b.TextColor=color;
	end

	function this:SetBGColor(color)
		b.BGColor=color;		
		b.bg:SetVertexColor(color[1],color[2],color[3],color[4]);
	end

	this.isLocked=true;
end

function IMBA_Blackboard_SaveText()
	local TextData={};

	for i=1,IMBA_BLACKBOARD_MAX_TEXTBOXES do
		local TextBox = getglobal("IMBA_Blackboard_Canvas_Text"..i);
		
		if TextBox:IsShown() then
			TextData[i]={}
			TextData[i].text=TextBox.editbox:GetText()
			TextData[i].x=TextBox:GetLeft()-TextBox:GetParent():GetLeft();
			TextData[i].y=TextBox:GetBottom()-TextBox:GetParent():GetBottom();
			TextData[i].TextColor=TextBox.TextColor
			TextData[i].BGColor=TextBox.BGColor
		end
	end
	return TextData;
end

function IMBA_Blackboard_LoadText(data)

	IMBA_SavedVariables.TestBlackboard2=data

	for i=1,IMBA_BLACKBOARD_MAX_TEXTBOXES do
		local TextBox = getglobal("IMBA_Blackboard_Canvas_Text"..i);
		
		if data[i] then
			TextBox.editbox:SetText(data[i].text);
			TextBox.editbox:SetFocus();
			TextBox.text:SetText(data[i].text);
			
			
			TextBox:SetTextColor(data[i].TextColor)
			TextBox:SetBGColor(data[i].BGColor)

			TextBox:ClearAllPoints();
			TextBox:SetPoint("BOTTOMLEFT",TextBox:GetParent(),"BOTTOMLEFT",data[i].x,data[i].y);

			TextBox:Show()
			--TextData[i].x=TextBox:GetLeft()-TextBox:GetParent():GetLeft();
			--TextData[i].y=TextBox:GetBottom()-TextBox:GetParent():GetBottom();
			IMBA_Blackboard_SendText(i);
		else
			IMBA_Blackboard_SendClearText(i);
			TextBox:Hide();
		end
	end
end

function IMBA_Blackboard_SetText(id,text,x,y,textcolor,bgcolor)
	local TextBox = getglobal("IMBA_Blackboard_Canvas_Text"..id);
	TextBox.editbox:SetText(text);
	TextBox.text:SetText(text);
	TextBox.editbox:SetFocus();
	TextBox:SetTextColor(textcolor);
	TextBox:SetBGColor(bgcolor);
	TextBox:ClearAllPoints();
	TextBox:SetPoint("BOTTOMLEFT",TextBox:GetParent(),"BOTTOMLEFT",x,y);
	TextBox:Show();
end

function IMBA_Blackboard_HideText(id)
	local TextBox = getglobal("IMBA_Blackboard_Canvas_Text"..id);
	TextBox:Hide();
end

function IMBA_Blackboard_FormatColor(color)
	return string.format("%.2f %.2f %.2f %.2f",color[1],color[2],color[3],color[4]);
end

function IMBA_Blackboard_FormatPos(x,y)
	return string.format("%.2f %.2f",x,y);
end

function IMBA_Blackboard_SendText(id)
	if IMBA_IsPlayerALeader() then
		local Text=getglobal("IMBA_Blackboard_Canvas_Text"..id);
		local x,y,t;
		x=Text:GetLeft()-Text:GetParent():GetLeft();
		y=Text:GetBottom()-Text:GetParent():GetBottom();
		t=Text.text:GetText();
		if not t then
			t=""
		end
		--Need to send colors as well
		--TextBox.TextColor
		--TextBox.BGColor
		if GetNumRaidMembers()>0 then
			IMBA_AddMsg("IMBA_BLACKBOARD","SETTEXT "..id.." "..IMBA_Blackboard_FormatPos(x,y).." "..IMBA_Blackboard_FormatColor(Text.TextColor).." "..IMBA_Blackboard_FormatColor(Text.BGColor).." "..t,"RAID");
		else
			IMBA_AddMsg("IMBA_BLACKBOARD","SETTEXT "..id.." "..IMBA_Blackboard_FormatPos(x,y).." "..IMBA_Blackboard_FormatColor(Text.TextColor).." "..IMBA_Blackboard_FormatColor(Text.BGColor).." "..t,"PARTY");
		end
	end
end

function IMBA_Blackboard_SendClearText(id)
	if IMBA_IsPlayerALeader() then
		if GetNumRaidMembers()>0 then
			IMBA_AddMsg("IMBA_BLACKBOARD","CLEARTEXT "..id,"RAID");
		else
			IMBA_AddMsg("IMBA_BLACKBOARD","CLEARTEXT "..id,"PARTY");
		end
	end
end

--Raid Icon Templates
function IMBA_Blackboard_RaidIconTemplate_OnLoad(b)
	this.icon=getglobal(this:GetName().."_Icon");
	
	if this:GetID() then
		local icon = UnitPopupButtons["RAID_TARGET_"..this:GetID()];
		this.icon:SetTexture(icon.icon);
		this.icon:SetTexCoord(icon.tCoordLeft,icon.tCoordRight,icon.tCoordTop,icon.tCoordBottom);
	end

	function this:Update()
		local left=b:GetLeft()-b:GetParent():GetLeft();
		local mid=(b:GetBottom()+b:GetTop()-b:GetParent():GetBottom()-b:GetParent():GetTop())/2;

		if (left+b:GetWidth())>b:GetParent():GetWidth() then
			left=b:GetParent():GetWidth()-(b:GetWidth());
		end
		if left<0 then
			left=0;
		end

		if (mid+b:GetHeight()/2)>b:GetParent():GetHeight()/2 then
			mid=b:GetParent():GetHeight()/2-(b:GetHeight()/2);
		end
		if (mid-b:GetHeight()/2)<-b:GetParent():GetHeight()/2 then
			mid=(b:GetHeight()/2)-b:GetParent():GetHeight()/2;
		end

		b:ClearAllPoints();
		b:SetPoint("LEFT",b:GetParent(),"LEFT",left,mid);
	end

	this.isLocked=false;
end

function IMBA_Blackboard_SaveRaidIcons()
	local RaidIconData={}
	local RaidIcon
	for i=1,8 do
		RaidIcon=getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i);
		
		if RaidIcon:IsShown() then
			RaidIconData[i]={}
			RaidIconData[i].x=RaidIcon:GetLeft()-RaidIcon:GetParent():GetLeft();
			RaidIconData[i].y=RaidIcon:GetBottom()-RaidIcon:GetParent():GetBottom();
		end
	end
	return RaidIconData
end

function IMBA_Blackboard_SendRaidIcon(id)
	if IMBA_IsPlayerALeader() or true then
		local RaidIcon=getglobal("IMBA_Blackboard_Canvas_RaidIcon"..id);
		local x,y;
		x=RaidIcon:GetLeft()-RaidIcon:GetParent():GetLeft();
		y=RaidIcon:GetBottom()-RaidIcon:GetParent():GetBottom();
		if GetNumRaidMembers()>0 then
			IMBA_AddMsg("IMBA_BLACKBOARD","SETRAIDICON "..id.." "..IMBA_Blackboard_FormatPos(x,y),"RAID");
		else
			IMBA_AddMsg("IMBA_BLACKBOARD","SETRAIDICON "..id.." "..IMBA_Blackboard_FormatPos(x,y),"PARTY");
		end
	end
end

function IMBA_Blackboard_LoadRaidIcons(data)
	local RaidIcon
	for i=1,8 do
		RaidIcon=getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i);
		if data[i] then
			RaidIcon:ClearAllPoints()
			RaidIcon:SetPoint("BOTTOMLEFT",RaidIcon:GetParent(),"BOTTOMLEFT",data[i].x,data[i].y)
			RaidIcon:Show()
			IMBA_Blackboard_SendRaidIcon(i);
		else
			IMBA_Blackboard_SendClearIcon(i);
			RaidIcon:Hide()
		end
	end
end

function IMBA_Blackboard_SetRaidIcon(num,x,y)
	local RaidIcon=getglobal("IMBA_Blackboard_Canvas_RaidIcon"..num);

	RaidIcon:ClearAllPoints()
	RaidIcon:SetPoint("BOTTOMLEFT",RaidIcon:GetParent(),"BOTTOMLEFT",x,y)
	RaidIcon:Show()
end

function IMBA_Blackboard_ClearRaidIcon(i)
	local RaidIcon=getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i);
	
	RaidIcon:Hide();
end

function IMBA_Blackboard_SendClearIcon(id)
	if IMBA_IsPlayerALeader() then
		if GetNumRaidMembers()>0 then
			IMBA_AddMsg("IMBA_BLACKBOARD","CLEARRAIDICON "..id,"RAID");
		else
			IMBA_AddMsg("IMBA_BLACKBOARD","CLEARRAIDICON "..id,"PARTY");
		end
	end
end

--Various Modes
function IMBA_Blackboard_CursorMode()
	for i=1, IMBA_BLACKBOARD_MAX_TEXTBOXES  do
		getglobal("IMBA_Blackboard_Canvas_Text"..i):LockBox();
		getglobal("IMBA_Blackboard_Canvas_Text"..i):EnableMouse(true);
	end

	for i=1, 8  do
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i):EnableMouse(true);
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i).isLocked=false;
	end
end

function IMBA_Blackboard_PencilMode()
	for i=1, IMBA_BLACKBOARD_MAX_TEXTBOXES do
		getglobal("IMBA_Blackboard_Canvas_Text"..i):LockBox();
		getglobal("IMBA_Blackboard_Canvas_Text"..i):EnableMouse(false);
		getglobal("IMBA_Blackboard_Canvas_Text"..i).isLocked=true;
	end

	for i=1, 8  do
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i):EnableMouse(false);
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i).isLocked=true;
	end
end

function IMBA_Blackboard_EraserMode()
	for i=1, IMBA_BLACKBOARD_MAX_TEXTBOXES do
		getglobal("IMBA_Blackboard_Canvas_Text"..i):LockBox();
		getglobal("IMBA_Blackboard_Canvas_Text"..i):EnableMouse(true);
		getglobal("IMBA_Blackboard_Canvas_Text"..i).isLocked=true;
	end

	for i=1, 8  do
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i):EnableMouse(true);
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i).isLocked=true;
	end
end

function IMBA_Blackboard_TextMode()
	for i=1, IMBA_BLACKBOARD_MAX_TEXTBOXES do
		getglobal("IMBA_Blackboard_Canvas_Text"..i):EnableMouse(false);
		getglobal("IMBA_Blackboard_Canvas_Text"..i):UnlockBox();
	end

	for i=1, 8  do
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i):EnableMouse(false);
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i).isLocked=true;
	end
end

function IMBA_Blackboard_RaidIconMode()
	for i=1, IMBA_BLACKBOARD_MAX_TEXTBOXES do
		getglobal("IMBA_Blackboard_Canvas_Text"..i):LockBox();
		getglobal("IMBA_Blackboard_Canvas_Text"..i):EnableMouse(false);
		getglobal("IMBA_Blackboard_Canvas_Text"..i).isLocked=true;
	end

	for i=1, 8  do
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i).isLocked=true;
		getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i):EnableMouse(false);
		if (i+4)==IMBA_Blackboard_Mode then
			getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i):EnableMouse(true);
			getglobal("IMBA_Blackboard_Canvas_RaidIcon"..i).isLocked=false;
		end
	end
end

--Save/Loading
function IMBA_Blackboard_SaveData()
	local Data={}
	Data.Map=IMBA_Blackboard_MapImageDropDownText:GetText();
	Data.Text=IMBA_Blackboard_SaveText()
	Data.RaidIcons=IMBA_Blackboard_SaveRaidIcons()
	Data.Lines=IMBA_CreateSaveImage(IMBA_Blackboard_Canvas);
	return Data;
end

function IMBA_Blackboard_LoadData(Data)	
	for k,v in IMBA_MapImages do 
		if v.name==Data.Map then
			IMBA_Blackboard_SendMap(k);
		end
	end
	if IMBA_IsPlayerALeader() then
		if GetNumRaidMembers()>0 then
			IMBA_AddMsg("IMBA_LINES_IMBA_Blackboard","ERASEALL","RAID");
		else
			IMBA_AddMsg("IMBA_LINES_IMBA_Blackboard","ERASEALL","PARTY");
		end
	end
	IMBA_Blackboard_SetMap(Data.Map)
	IMBA_Blackboard_LoadRaidIcons(Data.RaidIcons)
	if Data.Lines then
		IMBA_DrawSavedImage(IMBA_Blackboard_Canvas,Data.Lines)
		IMBA_SendSavedImage(IMBA_Blackboard_Canvas,Data.Lines)
	end
	IMBA_Blackboard_LoadText(Data.Text)
end

function IMBA_Blackboard_SortImages(v1,v2)
	return v1.name<v2.name
end

function IMBA_Blackboard_SaveImage()
	local Image,Name;
	if not IMBA_SavedVariables.Mods["Blackboard"].Images then
		IMBA_SavedVariables.Mods["Blackboard"].Images={};
	end

	Name=IMBA_BlackboardSave_ImageName:GetText()
	if Name=="" then
		Name="Unknown "..getn(IMBA_SavedVariables.Mods["Blackboard"].Images)+1;
	end
	Image=IMBA_Blackboard_SaveData()
	tinsert(IMBA_SavedVariables.Mods["Blackboard"].Images,{name=Name;data=Image});

	table.sort(IMBA_SavedVariables.Mods["Blackboard"].Images,IMBA_Blackboard_SortImages)
end

function IMBA_Blackboard_LoadImageClicked(num)
	for i=1,8 do
		if i==num then
			getglobal("IMBA_BlackboardLoad_Image"..i.."_Selected"):Show()
		else
			getglobal("IMBA_BlackboardLoad_Image"..i.."_Selected"):Hide()
		end
	end
	IMBA_Blackboard_SelectedImage=num+FauxScrollFrame_GetOffset(IMBA_BlackboardLoad_ScrollFrame);
end

function IMBA_Blackboard_DeleteImage()
	local numEntries;
	if IMBA_SavedVariables.Mods["Blackboard"].Images then
		numEntries=getn(IMBA_SavedVariables.Mods["Blackboard"].Images)
	else
		numEntries=0;
	end

	if IMBA_Blackboard_SelectedImage~=0 and IMBA_Blackboard_SelectedImage<=numEntries then
		tremove(IMBA_SavedVariables.Mods["Blackboard"].Images,IMBA_Blackboard_SelectedImage)
		IMBA_Blackboard_SelectedImage=0;
		IMBA_Blackboard_LoadImage_Update();
	end
end

function IMBA_Blackboard_LoadImage()
	local numEntries;
	if IMBA_SavedVariables.Mods["Blackboard"].Images then
		numEntries=getn(IMBA_SavedVariables.Mods["Blackboard"].Images)
	else
		numEntries=0;
	end

	if IMBA_Blackboard_SelectedImage~=0 and IMBA_Blackboard_SelectedImage<=numEntries then
		IMBA_Blackboard_NewImage();
		IMBA_Blackboard_LoadData(IMBA_SavedVariables.Mods["Blackboard"].Images[IMBA_Blackboard_SelectedImage].data);
		--IMBA_DrawSavedImage(Whiteboard,Whiteboard_Saved[Whiteboard_SelectedImage][2]);
		--IMBA_SendSavedImage(Whiteboard,Whiteboard_Saved[Whiteboard_SelectedImage][2]);
	end
end

function IMBA_Blackboard_LoadImage_Update()
	local numEntries;
	if IMBA_SavedVariables.Mods["Blackboard"].Images then
		numEntries=getn(IMBA_SavedVariables.Mods["Blackboard"].Images)
	else
		numEntries=0;
	end
	-- ScrollFrame update
	FauxScrollFrame_Update(IMBA_BlackboardLoad_ScrollFrame, numEntries, 8, 25 );
	for i=1, 8, 1 do
		local obj = getglobal("IMBA_BlackboardLoad_Image" .. i);
		local text = getglobal("IMBA_BlackboardLoad_Image" .. i .."_Text");
		local selected = getglobal("IMBA_BlackboardLoad_Image" .. i .. "_Selected");
		
		local index = i + FauxScrollFrame_GetOffset(IMBA_BlackboardLoad_ScrollFrame); 

		if ( index <= numEntries ) then
			obj:Show();
			text:SetText(IMBA_SavedVariables.Mods["Blackboard"].Images[index].name);
			if index==IMBA_Blackboard_SelectedImage then
				getglobal("IMBA_BlackboardLoad_Image"..i.."_Selected"):Show()
			else
				getglobal("IMBA_BlackboardLoad_Image"..i.."_Selected"):Hide()
			end
		else
			obj:Hide();
		end
	end
end


function IMBA_Blackboard_OnEvent(event)
	if event=="CHAT_MSG_ADDON" then
		
		IMBA_LineMsgHandler(IMBA_Blackboard_Canvas);
		if arg1=="IMBA_BLACKBOARD" and arg4~=UnitName("player") then
			if string.find(arg2,"MAP") then
				local _,_, NewMap = string.find(arg2, "MAP (.*)");
				IMBA_Blackboard_SetMap(NewMap);
			end

			if string.find(arg2,"CLEARRAIDICON") then
				local _,_, id =string.find(arg2,"CLEARRAIDICON (%d+)")
				IMBA_Blackboard_ClearRaidIcon(id);
			end
			
			if string.find(arg2,"SETRAIDICON") then
				local _,_, id, x, y = string.find(arg2,"SETRAIDICON (%d+) (%d+.?%d*) (%d+.?%d*)");
				IMBA_Blackboard_SetRaidIcon(id,tonumber(x),tonumber(y));
			end

			if string.find(arg2,"CLEARTEXT") then
				local _,_, id =string.find(arg2,"CLEARTEXT (%d+)")
				IMBA_Blackboard_HideText(id);
			end

			if string.find(arg2,"SETTEXT") then
				local _,_, id, x, y, r1, g1, b1, a1, r2, g2, b2, a2, t = string.find(arg2,"SETTEXT (%d+) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (%d+.?%d*) (.*)");
				IMBA_Blackboard_SetText(id,t,x,y,{tonumber(r1),tonumber(g1),tonumber(b1),tonumber(a1)},{tonumber(r2),tonumber(g2),tonumber(b2),tonumber(a2)});
			end
		end
	end
end