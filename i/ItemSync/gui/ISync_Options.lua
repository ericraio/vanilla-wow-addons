--[[--------------------------------------------------------------------------------
  ItemSync Options GUI Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

ISYNCOPTIONS_SUBFRAMES = { "ISync_OptionsFrame_Tab", "ISync_OptionsFrameMods_Tab", "ISync_OptionsFrameGeneral_Tab", "ISync_OptionsCleanFrame_Tab"};


---------------------------------------------------
-- ISync:Options_ShowSubFrame
---------------------------------------------------
function ISync:Options_ShowSubFrame(frameName)

	for index, value in ISYNCOPTIONS_SUBFRAMES do
		if ( value == frameName ) then
			
			if(getglobal(value) and not getglobal(value):IsVisible()) then
				getglobal(value):Show()
			end
			
		else

			if(getglobal(value) and getglobal(value):IsVisible()) then
				getglobal(value):Hide();
			end
			
		end	
	end 
	
end


---------------------------------------------------
-- ISync:Options_OnLoad
---------------------------------------------------
function ISync:Options_OnLoad()

	PanelTemplates_SetNumTabs(ISync_OptionsFrame, 4);
	ISync_OptionsFrame.selectedTab = 1;
	PanelTemplates_UpdateTabs(ISync_OptionsFrame);
	
end



---------------------------------------------------
-- ISync:Options_OnUpdate
---------------------------------------------------
function ISync:Options_OnUpdate()

	--check the tabs
	if ( ISync_OptionsFrame.selectedTab == 1 ) then
	
		ISync_OptionsFrameHeaderText:SetText(ISYNC_MAIN_HEADER_OPTIONS);
		ISync:Options_ShowSubFrame("ISync_OptionsFrame_Tab");
		
	elseif ( ISync_OptionsFrame.selectedTab == 2 ) then
	
		ISync_OptionsFrameHeaderText:SetText(ISYNC_MAIN_HEADER_OPTIONSMOD);
		ISync:Options_ShowSubFrame("ISync_OptionsFrameMods_Tab");
		
	elseif ( ISync_OptionsFrame.selectedTab == 3 ) then
	
		ISync_OptionsFrameHeaderText:SetText(ISYNC_MAIN_HEADER_OPTIONSGENERAL);
		ISync:Options_ShowSubFrame("ISync_OptionsFrameGeneral_Tab");
		
	elseif ( ISync_OptionsFrame.selectedTab == 4 ) then
	
		ISync_OptionsFrameHeaderText:SetText(ISYNC_MAIN_HEADER_OPTIONSCLEAN);
		ISync:Options_ShowSubFrame("ISync_OptionsCleanFrame_Tab");
		
	end
	
	

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
