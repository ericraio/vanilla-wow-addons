--[[
	LS Chat Options Window
	
	open up with /lschat
   ]]
  
function LSChat_ToggleOptions() 
	if(LSChat_Options:IsVisible()) then
		LSChat_Options:Hide();
	else
		LSChat_Options:Show();
	end;
end;


function LSChat_UpdateOptions()
	if(LSChatConfig.HideButtons) then
		LSChat_checkbox_Hide:SetChecked(1);
	else
		LSChat_checkbox_Hide:SetChecked(0);
	end;
	
	if(LSChatConfig.DisableButtons) then
		LSChat_checkbox_DisableButtons:SetChecked(1);
	else
		LSChat_checkbox_DisableButtons:SetChecked(0);
	end;
	
	if(LSChatConfig.HideEmote) then
		LSChat_checkbox_HideEmote:SetChecked(1);
	else
		LSChat_checkbox_HideEmote:SetChecked(0);
	end;
	
	if(LSChatConfig.Mousewheel) then
		LSChat_checkbox_Mousewheel:SetChecked(1);
	else
		LSChat_checkbox_Mousewheel:SetChecked(0);
	end;
	
	if(LSChatConfig.StampEnabled) then
		LSChat_checkbox_Enabled:SetChecked(1);
	else
		LSChat_checkbox_Enabled:SetChecked(0);
	end;
	
	if(LSChatConfig.StampSeconds) then
		LSChat_checkbox_Seconds:SetChecked(1);
	else
		LSChat_checkbox_Seconds:SetChecked(0);
	end;
	
	if(LSChatConfig.StampStyle) then
		LSChat_checkbox_Style:SetChecked(1);
	else
		LSChat_checkbox_Style:SetChecked(0);
	end;
	
end
