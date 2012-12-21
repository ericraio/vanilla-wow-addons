function tradeDispenser_OSD_OnLoad(obj) 
	obj:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	obj:SetWidth(32*obj:GetParent():GetScale());
	obj:SetHeight(32*obj:GetParent():GetScale());
end

-- tradeDispenserGFX = path to artwork... defined in tradeDispenser_Initialize.lua

function tradeDispenser_OSD_buttons()
	local GFX = "Interface\\AddOns\\tradeDispenser\\artwork\\";		-- path to artwork, used for the buttons of the OSD
	if (tD_Temp.isEnabled) then
		tradeDispenserOSDActivateBtn:SetNormalTexture(GFX.."OSD_tdToggle_Active_1")
		tradeDispenserOSDActivateBtn:SetPushedTexture(GFX.."OSD_tdToggle_Active_2")
		
		tradeDispenserOSDConfigBtn:SetNormalTexture(GFX.."OSD_tdConfig_Normal_1")
		tradeDispenserOSDConfigBtn:SetPushedTexture(GFX.."OSD_tdConfig_Normal_2")		
				
		if (tD_CharDatas.AutoBroadcast) then
			tradeDispenserOSDBroadcastBtn:SetNormalTexture(GFX.."OSD_tdBroadcast_Active_1")
			tradeDispenserOSDBroadcastBtn:SetPushedTexture(GFX.."OSD_tdBroadcast_Active_2")
		else
			tradeDispenserOSDBroadcastBtn:SetNormalTexture(GFX.."OSD_tdBroadcast_Normal_1")
			tradeDispenserOSDBroadcastBtn:SetPushedTexture(GFX.."OSD_tdBroadcast_Normal_2")
		end
	else
		tradeDispenserOSDActivateBtn:SetNormalTexture(GFX.."OSD_tdToggle_Inactive_1")
		tradeDispenserOSDActivateBtn:SetPushedTexture(GFX.."OSD_tdToggle_Inactive_2")
		tradeDispenserOSDBroadcastBtn:SetNormalTexture(GFX.."OSD_tdBroadcast_Inactive_1")
		tradeDispenserOSDBroadcastBtn:SetPushedTexture(GFX.."OSD_tdBroadcast_Inactive_2")
		tradeDispenserOSDConfigBtn:SetNormalTexture(GFX.."OSD_tdConfig_Inactive_1")
		tradeDispenserOSDConfigBtn:SetPushedTexture(GFX.."OSD_tdConfig_Inactive_2")
	end

	if (tD_Temp.isVisible) then
		tradeDispenserOSDConfigBtn:SetNormalTexture(GFX.."OSD_tdConfig_Active_1")
		tradeDispenserOSDConfigBtn:SetPushedTexture(GFX.."OSD_tdConfig_Active_2")
	end	
end



function tradeDispenserOSD_OnUpdate()
	if (not tD_CharDatas.OSD) then return end
	tradeDispenserVerbose(2,"OSD_OnUpdate")
	if (not tD_CharDatas.OSD.isEnabled) then
		tradeDispenserOSD:Hide();
		return true;
	end
	
	tradeDispenserOSD:Show();
	
	if (tD_CharDatas.OSD.border) then
		tradeDispenserOSD:SetBackdropBorderColor(1, 1, 1, 1);
	else 
		tradeDispenserOSD:SetBackdropBorderColor(0,0,0,0);
	end
	
	local col = tD_CharDatas.OSD;
	tradeDispenserOSD:SetBackdropColor(col.r, col.g, col.b, col.alpha);
	tradeDispenser_OSD_buttons();
	
	local s=1;
	if (tD_CharDatas.OSD.scale) then
		s = tD_CharDatas.OSD.scale;
	end
	if (tD_CharDatas.OSD.horiz) then
		tradeDispenserOSD:SetWidth(28+3*32*s);
		tradeDispenserOSD:SetHeight(32*s+14);

		tradeDispenserOSDBroadcastBtn:ClearAllPoints();		
		tradeDispenserOSDBroadcastBtn:SetPoint("RIGHT", "tradeDispenserOSDActivateBtn", "LEFT", -5,0);	
		tradeDispenserOSDConfigBtn:ClearAllPoints();	
		tradeDispenserOSDConfigBtn:SetPoint("LEFT","tradeDispenserOSDActivateBtn","RIGHT",5,0);
	else
		tradeDispenserOSD:SetHeight(28+3*32*s);
		tradeDispenserOSD:SetWidth(32*s+14);
		tradeDispenserOSDBroadcastBtn:ClearAllPoints();		
		tradeDispenserOSDBroadcastBtn:SetPoint("BOTTOM", "tradeDispenserOSDActivateBtn", "TOP", 0,5);		
		tradeDispenserOSDConfigBtn:ClearAllPoints();	
		tradeDispenserOSDConfigBtn:SetPoint("TOP","tradeDispenserOSDActivateBtn","BOTTOM",0,-5);
	end
	tradeDispenserOSDBroadcastBtn:SetWidth(32*s);
	tradeDispenserOSDBroadcastBtn:SetHeight(32*s);
	tradeDispenserOSDActivateBtn:SetWidth(32*s);
	tradeDispenserOSDActivateBtn:SetHeight(32*s);
	tradeDispenserOSDConfigBtn:SetWidth(32*s);
	tradeDispenserOSDConfigBtn:SetHeight(32*s);	
end
