--[[
distance
        Author:         dan
]]
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------	OPTION	 FRAME	---------------------------------------------------------

function distance_options_OnClick()
		distance_options_frame:Hide(); 
		
		distance_frame_width = distance_frame:GetWidth();
				--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance width:" ..distance_frame_width);
		distance_frame_alpha = distance_frame:GetAlpha();
				--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance alpha:" ..distance_frame_alpha);
		distance_frame_height = distance_frame:GetHeight();
				--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance height:" ..distance_frame_height);
	

end

function distance_frame_lock_OnClick()

--lock frame
  if distance_options_frame_lock_button:GetChecked(false)
		
		then distance_options_frame_lock_button:SetChecked(true);
				distance_frame_Y = distance_frame:GetBottom();
				distance_frame_X = distance_frame:GetLeft();	
				distance_frame:SetMovable(false);
				distance_frame:EnableMouse(false);
				distance_frame:ClearAllPoints();
				distance_frame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", distance_frame_X, distance_frame_Y);
							DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance: |cFFFF0000locked");
							--DEFAULT_CHAT_FRAME:AddMessage("X: " .. distance_frame_X );	
							--DEFAULT_CHAT_FRAME:AddMessage("Y: " .. distance_frame_Y );
							
--unlock frame
 else 		distance_options_frame_lock_button:SetChecked(false);
				distance_frame_Y = distance_frame:GetBottom();
				distance_frame_X = distance_frame:GetLeft();	
				distance_frame:GetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", distance_frame_X, distance_frame_Y);
				distance_frame:SetMovable(true);
				distance_frame:EnableMouse(true);
				distance_frame:Show();
							DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance: |cFFFF0000unlocked");
							--DEFAULT_CHAT_FRAME:AddMessage("X: " .. distance_frame_X );	
							--DEFAULT_CHAT_FRAME:AddMessage("Y: " .. distance_frame_Y );
 
end
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_frame_rotate_OnClick()
--distance_options_frame_rotate_button
if distance_options_frame_rotate_button:GetChecked(false)
	then distance_options_frame_rotate_button:SetChecked(true)
			distance_layout=true
			distance_text_offset();
			distance_frame:SetWidth(41 * height_value +6);
			distance_frame:SetHeight(distance_options_slider_width:GetValue());
			
			distance_range1:SetHeight(distance_frame:GetHeight()-5);
			distance_range2:SetHeight(distance_frame:GetHeight()-5);
			distance_range3:SetHeight(distance_frame:GetHeight()-5);
			distance_range4:SetHeight(distance_frame:GetHeight()-5);
			
			distance_range1:ClearAllPoints()
			distance_range1:SetPoint("LEFT",distance_frame ,"LEFT",3,0)
			distance_range2:ClearAllPoints()
			distance_range2:SetPoint("LEFT",distance_frame ,"LEFT",3,0)
			distance_range3:ClearAllPoints()
			distance_range3:SetPoint("LEFT",distance_frame ,"LEFT",3,0)
			distance_range4:ClearAllPoints()
			distance_range4:SetPoint("LEFT",distance_frame ,"LEFT",3,0)
							
else  distance_options_frame_rotate_button:SetChecked(false)
			distance_layout=false
			distance_text_offset();			
			distance_frame:SetHeight(41 * height_value +5);
			distance_frame:SetWidth(distance_options_slider_width:GetValue());
			
			distance_range1:SetWidth(distance_frame:GetWidth()-5);
			distance_range2:SetWidth(distance_frame:GetWidth()-5);
			distance_range3:SetWidth(distance_frame:GetWidth()-5);
			distance_range4:SetWidth(distance_frame:GetWidth()-5);
			
			distance_range1:ClearAllPoints()
			distance_range1:SetPoint("BOTTOM",distance_frame ,"BOTTOM",0,2)
			distance_range2:ClearAllPoints()
			distance_range2:SetPoint("BOTTOM",distance_frame ,"BOTTOM",0,2)
			distance_range3:ClearAllPoints()
			distance_range3:SetPoint("BOTTOM",distance_frame ,"BOTTOM",0,2)
			distance_range4:ClearAllPoints()
			distance_range4:SetPoint("BOTTOM",distance_frame ,"BOTTOM",0,2)
			
end
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_frame_reset_OnClick()

--frame reset
				
				distance_text_position = "BR" 
				distance_frame_X = 0;
				distance_frame_Y = 0;
				distance_layout=false;
				
				distance_options_frame_rotate_button:SetChecked(false)
				
				distance_frame:ClearAllPoints();
				distance_frame:SetPoint("CENTER", "UIParent", "CENTER", distance_frame_X, distance_frame_Y);
								
				distance_options_slider_width:SetMinMaxValues(14, 200);
				distance_options_slider_width:SetOrientation("HORIZONTAL");
				distance_options_slider_width:SetValue(distance_frame_width);
				distance_options_slider_width:SetValueStep(1);
				
				distance_frame:SetWidth(28);
				distance_range1:SetWidth(distance_frame:GetWidth()-5);
				distance_range2:SetWidth(distance_frame:GetWidth()-5);
				distance_range3:SetWidth(distance_frame:GetWidth()-5);
				distance_range4:SetWidth(distance_frame:GetWidth()-5);
				
				distance_range1:ClearAllPoints()
				distance_range1:SetPoint("BOTTOM",distance_frame ,"BOTTOM",0,2)
				distance_range2:ClearAllPoints()
				distance_range2:SetPoint("BOTTOM",distance_frame ,"BOTTOM",0,2)
				distance_range3:ClearAllPoints()
				distance_range3:SetPoint("BOTTOM",distance_frame ,"BOTTOM",0,2)
				distance_range4:ClearAllPoints()
				distance_range4:SetPoint("BOTTOM",distance_frame ,"BOTTOM",0,2)
				
				distance_options_slider_height:SetMinMaxValues(100, 1000);
				distance_options_slider_height:SetOrientation("HORIZONTAL");
				distance_options_slider_height:SetValue(height_value*100);
				distance_options_slider_height:SetValueStep(1);			

				distance_frame:SetHeight(41 * height_value +5);		

				distance_options_slider_alpha:SetMinMaxValues(0, 100);
				distance_options_slider_alpha:SetOrientation("HORIZONTAL");
				distance_options_slider_alpha:SetValue(distance_frame_alpha*100);
				distance_options_slider_alpha:SetValueStep(1);

				distance_frame:SetAlpha(distance_frame_alpha);
					
				distance_frame_Y = distance_frame:GetBottom();
				distance_frame_X = distance_frame:GetLeft();	
				distance_frame:ClearAllPoints();
				distance_frame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", distance_frame_X, distance_frame_Y);
				
						--DEFAULT_CHAT_FRAME:AddMessage("X: " .. distance_frame_X );	
						--DEFAULT_CHAT_FRAME:AddMessage("Y: " .. distance_frame_Y );
						
				distance_text_offset();
				distance_text:ClearAllPoints();
				distance_text1:ClearAllPoints();
				distance_text:SetPoint("CENTER", "distance_range2", "TOP", offset_X_1, -offset_Y_1);
				distance_text1:SetPoint("CENTER", "distance_range4", "TOP", offset_X_2, -offset_Y_2);
					
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance: |cFFFF0000reseted");
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_frame_BR_OnClick()

		if 	distance_options_frame_BR_button:GetButtonState(PUSHED)
			then if (distance_layout==false) 
			then distance_text_position = "BR";
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", offset_X_1, -offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", offset_X_2, -offset_Y_2);
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000BottomRight");
			else distance_text_position = "BR";
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", offset_Y_1, -offset_X_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", offset_Y_1, -offset_X_1);
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000BottomRight");
			end
				
end
end

function distance_frame_BL_OnClick()	

		 if	distance_options_frame_BL_button:GetButtonState("PUSHED")
			then if (distance_layout==false) 
			then	distance_text_position = "BL";
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", -offset_X_1, -offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", -offset_X_2, -offset_Y_2);
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000BottomLeft");
			else	distance_text_position = "BL";
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", -offset_Y_1, -offset_X_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", -offset_Y_1, -offset_X_1);
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000BottomLeft");
			end
end
end

function distance_frame_TL_OnClick()	

		 if distance_options_frame_TL_button:GetButtonState("PUSHED")
			then if (distance_layout==false) 
			then	distance_text_position = "TL";
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", -offset_X_1, offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", -offset_X_2, offset_Y_2);
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000TopLeft");
			else distance_text_position = "TL";
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", -offset_Y_1, offset_X_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", -offset_Y_1, offset_X_1);
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000TopLeft");
			end
end
end

function distance_frame_TR_OnClick()	
				
		 if distance_options_frame_TR_button:GetButtonState("PUSHED")
			then if (distance_layout==false) 
			then distance_text_position = "TR";	
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", offset_X_1, offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", offset_X_2, offset_Y_2);
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000TopRight");
			else distance_text_position = "TR";	
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", offset_Y_1, offset_X_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", offset_Y_1, offset_X_1);
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000TopRight");
			end
end
end

function distance_frame_TC_OnClick()		

		 if distance_options_frame_TC_button:GetButtonState("PUSHED")	
			then if (distance_layout==false) 
			then distance_text_position = "TC";
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", 0, offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", 0, offset_Y_2);					
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000TopCenter");		
			else distance_text_position = "TC";
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", offset_Y_1, 0);
					distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", offset_Y_1, 0);					
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000TopCenter");	
			end
end
end

function distance_frame_BC_OnClick()		
				
		 if	distance_options_frame_BC_button:GetButtonState("PUSHED")
			then if (distance_layout==false) 
			then distance_text_position = "BC";
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", 0, -offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", 0, -offset_Y_2);
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000BottomCenter");
			else distance_text_position = "BC";
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", -offset_Y_1, 0);
					distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", -offset_Y_1, 0);
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Anchor: |cFFFF0000BottomCenter");
			end
end
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_text_offset()
 if (distance_layout==false) then 
		offset_X_1 = ((distance_frame_width/2)+(distance_text:GetWidth()/2));
		offset_Y_1 = ((distance_text:GetHeight()/2));
		offset_X_2 = ((distance_frame_width/2)+(distance_text1:GetWidth()/2));
		offset_Y_2 = ((distance_text1:GetHeight()/2));
elseif(distance_layout==true) then 
		offset_X_1 = ((distance_frame_height/2)+(distance_text:GetHeight()/2));
		offset_Y_1 = (distance_text:GetWidth()/2);
		offset_X_2 = ((distance_frame_height/2)+(distance_text1:GetHeight()/2));
		offset_Y_2 = (distance_text1:GetWidth()/2);
end
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_slider_width()

distance_options_slider_width:SetMinMaxValues(14, 200);
distance_options_slider_width:SetOrientation("HORIZONTAL"); 
distance_options_slider_width:SetValueStep(1);

if distance_options_slider_width:GetValue()
	then if (distance_layout==false) then 
			distance_options_slider_width:SetValue(distance_options_slider_width:GetValue());
			distance_frame:SetWidth(distance_options_slider_width:GetValue());
				distance_range1:SetWidth(distance_frame:GetWidth()-5);
				distance_range2:SetWidth(distance_frame:GetWidth()-5);
				distance_range3:SetWidth(distance_frame:GetWidth()-5);
				distance_range4:SetWidth(distance_frame:GetWidth()-5);
				distance_frame_width = distance_frame:GetWidth();
				
				offset_X_1 = ((distance_frame_width/2)+(distance_text:GetWidth()/2));
				offset_Y_1 = ((distance_text:GetHeight()/2));
				offset_X_2 = ((distance_frame_width/2)+(distance_text1:GetWidth()/2));
				offset_Y_2 = ((distance_text1:GetHeight()/2));
			
			
				if distance_text_position == "BR"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "TOP", offset_X_1, -offset_Y_1);
							distance_text1:SetPoint("CENTER", "distance_range4", "TOP", offset_X_2, -offset_Y_2);		

				elseif distance_text_position == "BL"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "TOP", -offset_X_1, -offset_Y_1);
							distance_text1:SetPoint("CENTER", "distance_range4", "TOP", -offset_X_2, -offset_Y_2);
					
				elseif distance_text_position == "TL"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "TOP", -offset_X_1, offset_Y_1);
							distance_text1:SetPoint("CENTER", "distance_range4", "TOP", -offset_X_2, offset_Y_2);
					
				elseif distance_text_position == "TR"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "TOP", offset_X_1, offset_Y_1);
							distance_text1:SetPoint("CENTER", "distance_range4", "TOP", offset_X_2, offset_Y_2);
					
				elseif distance_text_position == "TC"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "TOP", 0, offset_Y_1);
							distance_text1:SetPoint("CENTER", "distance_range4", "TOP", 0, offset_Y_2);	
					
				elseif distance_text_position == "BC"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "TOP", 0, -offset_Y_1);
							distance_text1:SetPoint("CENTER", "distance_range4", "TOP", 0, -offset_Y_2);
				end

			--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance width:" ..distance_options_slider_width:GetValue());
	else 
		if (distance_layout==true) then 
			distance_options_slider_width:SetValue(distance_options_slider_width:GetValue());
			distance_frame:SetHeight(distance_options_slider_width:GetValue());
				distance_range1:SetHeight(distance_frame:GetHeight()-5);
				distance_range2:SetHeight(distance_frame:GetHeight()-5);
				distance_range3:SetHeight(distance_frame:GetHeight()-5);
				distance_range4:SetHeight(distance_frame:GetHeight()-5);
				distance_frame_height = distance_frame:GetHeight();
				
				offset_X_1 = ((distance_frame_height/2)+(distance_text:GetHeight()/2));
				offset_Y_1 = (distance_text:GetWidth()/2);
				offset_X_2 = ((distance_frame_height/2)+(distance_text1:GetHeight()/2));
				offset_Y_2 = (distance_text1:GetWidth()/2);
				
				if distance_text_position == "BR"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", offset_Y_1, -offset_X_1);
							distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", offset_Y_1, -offset_X_1);
					
				elseif distance_text_position == "BL"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", -offset_Y_1, -offset_X_1);
							distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", -offset_Y_1, -offset_X_1);
					
				elseif distance_text_position == "TL"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", -offset_Y_1, offset_X_1);
							distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", -offset_Y_1, offset_X_1);
					
				elseif distance_text_position == "TR"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", offset_Y_1, offset_X_1);
							distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", offset_Y_1, offset_X_1);
					
				elseif distance_text_position == "TC"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", offset_Y_1, 0);
							distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", offset_Y_1, 0);
					
				elseif distance_text_position == "BC"
					then distance_text:ClearAllPoints();
							distance_text1:ClearAllPoints();
							distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", -offset_Y_1, 0);
							distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", -offset_Y_1, 0);
				end
		end
		end
	end

end
--------------------------------------------------------------------------------------------------------------------------------
function distance_slider_height()

distance_options_slider_height:SetMinMaxValues(100, 1000);
distance_options_slider_height:SetOrientation("HORIZONTAL");
distance_options_slider_height:SetValueStep(1);

if distance_options_slider_height:GetValue()
	then 
		if (distance_layout==false) then 
			distance_options_slider_height:SetValue(distance_options_slider_height:GetValue());
			height_value = (distance_options_slider_height:GetValue()/100);
			distance_frame:SetHeight(41 * height_value +5);
			distance_frame_height = distance_frame:GetHeight();
			
					--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance height:" ..distance_options_slider_height:GetValue());
					--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance multi:" ..height_value);
					--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance height:" ..distance_frame_height);
	else 
		if (distance_layout==true) then 
			distance_options_slider_height:SetValue(distance_options_slider_height:GetValue());
			height_value = (distance_options_slider_height:GetValue()/100);
			distance_frame:SetWidth(41 * height_value +6);
			distance_frame_width = distance_frame:GetWidth();
		end
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--alpha slider
function distance_slider_alpha()

distance_options_slider_alpha:SetMinMaxValues(0, 100);
distance_options_slider_alpha:SetOrientation("HORIZONTAL");
distance_options_slider_alpha:SetValueStep(1);

if distance_options_slider_alpha:GetValue()	
	then distance_options_slider_alpha:SetValue(distance_options_slider_alpha:GetValue());
			distance_frame:SetAlpha(distance_options_slider_alpha:GetValue()/100);
			distance_frame_alpha = distance_frame:GetAlpha();
			--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance alpha:" ..distance_options_slider_alpha:GetValue());
end

end
---------------------------------------------------------------------------------------------------------------------------------
--mouse up
function distance_options_OnMouseUp()
		if (distance_options_frame.isMoving) then
		distance_options_frame:StopMovingOrSizing();
		distance_options_frame.isMoving = false;
	end
end
---------------------------------------------------------------------------------------------------------------------------------
--mouse down
function distance_options_OnMouseDown()
	if (distance_options_frame:IsMovable()) then	
	if  (( not distance_options_frame.isLocked ) or ( distance_options_frame.isLocked == 0 ) and ( arg1 == "LeftButton" )) then
		distance_options_frame:StartMoving();
		distance_options_frame.isMoving = true;
	end
	end
end
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--textures onload
function distance_textures_OnLoad()
	distance_background_texture_editbox:SetText("Background");
	distance_background_texture_editbox:SetAutoFocus(false);
			
	distance_border_texture_editbox:SetText("Border");
	distance_border_texture_editbox:SetAutoFocus(false);
			
	--distance_bar_height_texture_editbox:SetText(distance_bar_texture_h);
	--distance_bar_height_texture_editbox:SetAutoFocus(false);
			
	--distance_bar_width_texture_editbox:SetText(distance_bar_texture_w);
	--distance_bar_width_texture_editbox:SetAutoFocus(false);
end
---------------------------------------------------------------------------------------------------------------------------------
--ok button background texture 
function distance_enter_background_texture()
	if 	distance_background_texture_ok:GetButtonState(PUSHED)
		then distance_background_texture_editbox:SetText("Background");
				distance_background_texture_editbox:ClearFocus(true);
	end
end
---------------------------------------------------------------------------------------------------------------------------------
--ok button border texture
function distance_enter_border_texture()
	if 	distance_border_texture_ok:GetButtonState(PUSHED)
		then distance_border_texture_editbox:SetText("Border");
				distance_border_texture_editbox:ClearFocus(true);
	end
end
---------------------------------------------------------------------------------------------------------------------------------
--ok button height texture
function distance_enter_bar_height_texture()
	if 	distance_bar_height_texture_ok:GetButtonState(PUSHED)
		then distance_bar_texture_h=distance_bar_height_texture_editbox:GetText();
				distance_bar_height_texture_editbox:SetText(distance_bar_texture_h);
				distance_bar_height_texture_editbox:ClearFocus(true);
	end
end
---------------------------------------------------------------------------------------------------------------------------------
--default button height texture
function distance_default_bar_height_texture()
	if distance_bar_height_texture_default:GetButtonState(PUSHED)
		then distance_bar_texture_h="Interface\\AddOns\\Distance\\texture\\bar_h";
				distance_bar_height_texture_editbox:SetText(distance_bar_texture_h);
				distance_bar_height_texture_editbox:ClearFocus(true);
	end
end
---------------------------------------------------------------------------------------------------------------------------------
--ok button width texture
function distance_enter_bar_width_texture()
	if 	distance_bar_width_texture_ok:GetButtonState(PUSHED)
		then distance_bar_texture_w=distance_bar_width_texture_editbox:GetText();
				distance_bar_width_texture_editbox:SetText(distance_bar_texture_w);
				distance_bar_width_texture_editbox:ClearFocus(true);
	end
end
---------------------------------------------------------------------------------------------------------------------------------
--default button width texture
function distance_default_bar_width_texture()
	if distance_bar_width_texture_default:GetButtonState(PUSHED)
		then distance_bar_texture_w="Interface\\AddOns\\Distance\\texture\\bar_w";
				distance_bar_width_texture_editbox:SetText(distance_bar_texture_w);
				distance_bar_width_texture_editbox:ClearFocus(true);
	end
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_options_color_bar1_OnClick()
	distance_options_color_tab1:SetTextHeight(14);
	distance_options_color_bar1:SetHeight(25);
	distance_options_color_bar1:SetWidth(60);
					
	distance_options_color_tab2:SetTextHeight(12);
	distance_options_color_bar2:SetHeight(20);
	distance_options_color_bar2:SetWidth(50);
					
	distance_options_color_tab3:SetTextHeight(12);
	distance_options_color_bar3:SetHeight(20);
	distance_options_color_bar3:SetWidth(50);
					
	distance_options_color_tab4:SetTextHeight(12);
	distance_options_color_bar4:SetHeight(20);
	distance_options_color_bar4:SetWidth(50);
					
	distance_options_color_tab5:SetTextHeight(12);
	distance_options_color_bar5:SetHeight(20);
	distance_options_color_bar5:SetWidth(50);
	
	distance_color_tab1=true
	distance_color_tab2=false
	distance_color_tab3=false
	distance_color_tab4=false
	distance_color_tab5=false
	
	distance_options_slider_red:SetValue(barcolor.b1_color_w_r*100);
	distance_options_slider_green:SetValue(barcolor.b1_color_w_g*100);
	distance_options_slider_blue:SetValue(barcolor.b1_color_w_b*100);

end
---------------------------------------------------------------------------------------------------------------------------------
function distance_options_color_bar2_OnClick()
	distance_options_color_tab1:SetTextHeight(12);
	distance_options_color_bar1:SetHeight(20);
	distance_options_color_bar1:SetWidth(50);
					
	distance_options_color_tab2:SetTextHeight(14);
	distance_options_color_bar2:SetHeight(25);
	distance_options_color_bar2:SetWidth(60);
					
	distance_options_color_tab3:SetTextHeight(12);
	distance_options_color_bar3:SetHeight(20);
	distance_options_color_bar3:SetWidth(50);
					
	distance_options_color_tab4:SetTextHeight(12);
	distance_options_color_bar4:SetHeight(20);
	distance_options_color_bar4:SetWidth(50);
					
	distance_options_color_tab5:SetTextHeight(12);
	distance_options_color_bar5:SetHeight(20);
	distance_options_color_bar5:SetWidth(50);
	
	distance_color_tab1=false
	distance_color_tab2=true
	distance_color_tab3=false
	distance_color_tab4=false
	distance_color_tab5=false
	
	distance_options_slider_red:SetValue(barcolor.b2_color_w_r*100);
	distance_options_slider_green:SetValue(barcolor.b2_color_w_g*100);
	distance_options_slider_blue:SetValue(barcolor.b2_color_w_b*100);
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_options_color_bar3_OnClick()
	distance_options_color_tab1:SetTextHeight(12);
	distance_options_color_bar1:SetHeight(20);
	distance_options_color_bar1:SetWidth(50);
					
	distance_options_color_tab2:SetTextHeight(12);
	distance_options_color_bar2:SetHeight(20);
	distance_options_color_bar2:SetWidth(50);
					
	distance_options_color_tab3:SetTextHeight(14);
	distance_options_color_bar3:SetHeight(25);
	distance_options_color_bar3:SetWidth(60);
					
	distance_options_color_tab4:SetTextHeight(12);
	distance_options_color_bar4:SetHeight(20);
	distance_options_color_bar4:SetWidth(50);
					
	distance_options_color_tab5:SetTextHeight(12);
	distance_options_color_bar5:SetHeight(20);
	distance_options_color_bar5:SetWidth(50);
	
	distance_color_tab1=false
	distance_color_tab2=false
	distance_color_tab3=true
	distance_color_tab4=false
	distance_color_tab5=false
	
	distance_options_slider_red:SetValue(barcolor.b3_color_w_r*100);
	distance_options_slider_green:SetValue(barcolor.b3_color_w_g*100);
	distance_options_slider_blue:SetValue(barcolor.b3_color_w_b*100);
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_options_color_bar4_OnClick()
	distance_options_color_tab1:SetTextHeight(12);
	distance_options_color_bar1:SetHeight(20);
	distance_options_color_bar1:SetWidth(50);
					
	distance_options_color_tab2:SetTextHeight(12);
	distance_options_color_bar2:SetHeight(20);
	distance_options_color_bar2:SetWidth(50);
					
	distance_options_color_tab3:SetTextHeight(12);
	distance_options_color_bar3:SetHeight(20);
	distance_options_color_bar3:SetWidth(50);
					
	distance_options_color_tab4:SetTextHeight(14);
	distance_options_color_bar4:SetHeight(25);
	distance_options_color_bar4:SetWidth(60);
					
	distance_options_color_tab5:SetTextHeight(12);
	distance_options_color_bar5:SetHeight(20);
	distance_options_color_bar5:SetWidth(50);
	
	distance_color_tab1=false
	distance_color_tab2=false
	distance_color_tab3=false
	distance_color_tab4=true
	distance_color_tab5=false
	
	distance_options_slider_red:SetValue(barcolor.b4_color_w_r*100);
	distance_options_slider_green:SetValue(barcolor.b4_color_w_g*100);
	distance_options_slider_blue:SetValue(barcolor.b4_color_w_b*100);
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_options_color_bar5_OnClick()
	distance_options_color_tab1:SetTextHeight(12);
	distance_options_color_bar1:SetHeight(20);
	distance_options_color_bar1:SetWidth(50);
	
	distance_options_color_tab2:SetTextHeight(12);
	distance_options_color_bar2:SetHeight(20);
	distance_options_color_bar2:SetWidth(50);
	
	distance_options_color_tab3:SetTextHeight(12);
	distance_options_color_bar3:SetHeight(20);
	distance_options_color_bar3:SetWidth(50);
					
	distance_options_color_tab4:SetTextHeight(12);
	distance_options_color_bar4:SetHeight(20);
	distance_options_color_bar4:SetWidth(50);
					
	distance_options_color_tab5:SetTextHeight(14);
	distance_options_color_bar5:SetHeight(25);
	distance_options_color_bar5:SetWidth(60);
	
	distance_color_tab1=false
	distance_color_tab2=false
	distance_color_tab3=false
	distance_color_tab4=false
	distance_color_tab5=true
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_slider_red()
distance_options_slider_red:SetMinMaxValues(0, 100);
distance_options_slider_red:SetOrientation("HORIZONTAL");
distance_options_slider_red:SetValueStep(1);

if distance_options_slider_red:GetValue()	
	then distance_options_slider_red:SetValue(distance_options_slider_red:GetValue());
					
			if distance_color_tab1==true 
				then distance_range_color1:SetVertexColor((distance_options_slider_red:GetValue()/100), 1,1);
						barcolor.b1_color_w_r = (distance_options_slider_red:GetValue()/100)
						barcolor.b1_color_h_r = (distance_options_slider_red:GetValue()/100)
			end
			if distance_color_tab2==true
				then distance_range_color2:SetVertexColor((distance_options_slider_red:GetValue()/100), 1,1);
						barcolor.b2_color_w_r = (distance_options_slider_red:GetValue()/100)
						barcolor.b2_color_h_r = (distance_options_slider_red:GetValue()/100)
			end
			if distance_color_tab3==true
				then distance_range_color3:SetVertexColor((distance_options_slider_red:GetValue()/100), 1,1);
						barcolor.b3_color_w_r = (distance_options_slider_red:GetValue()/100)
						barcolor.b3_color_h_r = (distance_options_slider_red:GetValue()/100)
			end
			if distance_color_tab4==true
				then distance_range_color4:SetVertexColor((distance_options_slider_red:GetValue()/100), 1,1);
						barcolor.b4_color_w_r = (distance_options_slider_red:GetValue()/100)
						barcolor.b4_color_h_r = (distance_options_slider_red:GetValue()/100)
			end
end
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_slider_green()
distance_options_slider_green:SetMinMaxValues(0, 100);
distance_options_slider_green:SetOrientation("HORIZONTAL");
distance_options_slider_green:SetValueStep(1);

if distance_options_slider_green:GetValue()	
	then distance_options_slider_green:SetValue(distance_options_slider_green:GetValue());
					
			if distance_color_tab1==true 
				then distance_range_color1:SetVertexColor(1, (distance_options_slider_green:GetValue()/100), 1);
						barcolor.b1_color_w_g = (distance_options_slider_green:GetValue()/100)
						barcolor.b1_color_h_g = (distance_options_slider_green:GetValue()/100)
			end
			if distance_color_tab2==true 
				then distance_range_color2:SetVertexColor(1, (distance_options_slider_green:GetValue()/100), 1);
						barcolor.b2_color_w_g = (distance_options_slider_green:GetValue()/100)
						barcolor.b2_color_h_g = (distance_options_slider_green:GetValue()/100)
			end
			if distance_color_tab3==true 
				then distance_range_color3:SetVertexColor(1, (distance_options_slider_green:GetValue()/100), 1);
						barcolor.b3_color_w_g = (distance_options_slider_green:GetValue()/100)
						barcolor.b3_color_h_g = (distance_options_slider_green:GetValue()/100)
			end
			if distance_color_tab4==true 
				then distance_range_color4:SetVertexColor(1, (distance_options_slider_green:GetValue()/100), 1);
						barcolor.b4_color_w_g = (distance_options_slider_green:GetValue()/100)
						barcolor.b4_color_h_g = (distance_options_slider_green:GetValue()/100)
			end
			
end
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_slider_blue()
distance_options_slider_blue:SetMinMaxValues(0, 100);
distance_options_slider_blue:SetOrientation("HORIZONTAL");
distance_options_slider_blue:SetValueStep(1);

if distance_options_slider_blue:GetValue()	
	then distance_options_slider_blue:SetValue(distance_options_slider_blue:GetValue());
					
			if distance_color_tab1==true 
				then distance_range_color1:SetVertexColor(1, 1, (distance_options_slider_blue:GetValue()/100));
						barcolor.b1_color_w_b = (distance_options_slider_blue:GetValue()/100)
						barcolor.b1_color_h_b = (distance_options_slider_blue:GetValue()/100)
			end
			if distance_color_tab2==true 
				then distance_range_color2:SetVertexColor(1, 1, (distance_options_slider_blue:GetValue()/100));
						barcolor.b2_color_w_b = (distance_options_slider_blue:GetValue()/100)
						barcolor.b2_color_h_b = (distance_options_slider_blue:GetValue()/100)
			end
			if distance_color_tab3==true 
				then distance_range_color3:SetVertexColor(1, 1, (distance_options_slider_blue:GetValue()/100));
						barcolor.b3_color_w_b = (distance_options_slider_blue:GetValue()/100)
						barcolor.b3_color_h_b = (distance_options_slider_blue:GetValue()/100)
			end
			if distance_color_tab4==true 
				then distance_range_color1:SetVertexColor(1, 1, (distance_options_slider_blue:GetValue()/100));
						barcolor.b4_color_w_b = (distance_options_slider_blue:GetValue()/100)
						barcolor.b4_color_h_b = (distance_options_slider_blue:GetValue()/100)
			end
end
end