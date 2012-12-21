function IMBA_AddAlert(text)
	if not IMBA_SavedVariables.UseSCTForAlerts then
		IMBA_Alert3:SetText(IMBA_Alert2.TheText,IMBA_Alert2.TextFade);
		IMBA_Alert2:SetText(IMBA_Alert1.TheText,IMBA_Alert1.TextFade);
		IMBA_Alert1:SetText(text,GetTime()+5);
	else
		SCT_MSG_FRAME:AddMessage(text,1,1,0,1);
	end
end

function IMBA_AddRaidAlert(text, normalalert, raidsend)
	if (raidsend) and (IsRaidLeader() or IsRaidOfficer()) and (not IMBA_SavedVariables.DontRaidBroadcast) then
		SendChatMessage(text,"RAID_WARNING");
	end
	if normalalert then
		IMBA_AddAlert(text);	
	end
end

function IMBA_SetScaleAlert(loading)
	if IMBA_SavedVariables.ScaleAlert==nil then
		IMBA_SavedVariables.ScaleAlert=1;
	end
	IMBA_Options_GraphicsFrame_Slider_ScaleAlertText:SetText(string.format("Alert Scale Size : %.2f",IMBA_SavedVariables.ScaleAlert));
	
	if not loading then
		local pointNum=IMBA_Alerts:GetNumPoints()
		local curScale=IMBA_Alerts:GetScale();
		local points={}
		for i=1,pointNum,1 do
			points[i]={};
			points[i][1], points[i][2], points[i][3], points[i][4], points[i][5]=IMBA_Alerts:GetPoint(i)
			points[i][4]=points[i][4]*curScale/IMBA_SavedVariables.ScaleAlert;
			points[i][5]=points[i][5]*curScale/IMBA_SavedVariables.ScaleAlert;
			--DEFAULT_CHAT_FRAME:AddMessage(points[i][1].." "..points[i][2].." "..points[i][3].." "..points[i][4].." "..points[i][5]);
		end
		IMBA_Alerts:ClearAllPoints()
		for i=1,pointNum,1 do
			IMBA_Alerts:SetPoint(points[i][1],points[i][2],points[i][3],points[i][4],points[i][5]);
		end
	end
	
	IMBA_Alerts:SetScale(IMBA_SavedVariables.ScaleAlert);
end