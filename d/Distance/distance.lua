--[[
distance
        Author:         dan
]]
---------------------------------------------------------------------------------------------------------------------------------
--range SCALE
local range41 = 41;	
local range40 = 40;
local range35 = 35;
local range30 = 30;
local range25 = 25;
local range21 = 21;
local range20 = 20;
local range10 = 10;
local range09 = 9;
local range08 = 8;
local range05 = 5;
local range00 = 0.1;
---------------------------------------------------------
--range text
local textooR = "ooR";
local text41 = "41";
local text40 = "40";
local text35 = "35";
local text30 = "30";
local text25 = "25";
local text21 = "21";
local text20 = "20";
local text10 = "10";
local text09 = "09";
local text08 = "08";
local text05 = "05";
local text00 = "00";
---------------------------------------------------------
--frame update
distance_frame_UpdateInterval = 0.01;

distance_color_tab1=false;
distance_color_tab2=false;
distance_color_tab3=false;
distance_color_tab4=false;
distance_color_tab5=false;

--textures
--distance_bar_texture_h = "Interface\\AddOns\\Distance\\texture\\bar_h";
--distance_bar_texture_w = "Interface\\AddOns\\Distance\\texture\\bar_w";

--[[barcolors
barcolor = {
b1_color_h_r = 1,
b1_color_h_g = 1,
b1_color_h_b = 1,
b1_color_h_a = 1,

b2_color_h_r = 1,
b2_color_h_g = 1,
b2_color_h_b = 0,
b2_color_h_a = 1,

b3_color_h_r = 1,
b3_color_h_g = 0,
b3_color_h_b = 0,
b3_color_h_a = 1,

b4_color_h_r = 0,
b4_color_h_g = 1,
b4_color_h_b = 0,
b4_color_h_a = 1,


b1_color_w_r = 1,
b1_color_w_g = 1,
b1_color_w_b = 1,
b1_color_w_a = 1,

b2_color_w_r = 1,
b2_color_w_g = 1,
b2_color_w_b = 0,
b2_color_w_a = 1,

b3_color_w_r = 1,
b3_color_w_g = 0,
b3_color_w_b = 0,
b3_color_w_a = 1,

b4_color_w_r = 0,
b4_color_w_g = 1,
b4_color_w_b = 0,
b4_color_w_a = 1
}]]
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--OnLoad
function distance_OnLoad()

--Slash Commands	
	SLASH_DISTANCE1 = "/distance";
	SLASH_DISTANCE2 = "/dist";
	SlashCmdList["DISTANCE"] = distance_Command;
---------------------------------------------------------
--Handlers
	this:RegisterEvent("ADDON_LOADED");
	distance_frame:RegisterEvent("PLAYER_TARGET_CHANGED"); 
	distance_frame:RegisterEvent("SPELLS_CHANGED");
	distance_frame:RegisterEvent("CHARACTER_POINTS_CHANGED");
	distance_frame:RegisterEvent("DUEL_FINISHED"); 
	distance_frame:RegisterEvent("PLAYER_REGEN_ENABLED");
	distance_frame:RegisterEvent("PLAYER_REGEN_DISABLED");
	
	distance_frame:RegisterEvent("PLAYER_ALIVE");		

	DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Addon: |cFFFF0000Loaded");
					
distance_frame.TimeSinceLastUpdate = 0;
end
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--OnEvent
function distance_Load_OnEvent()
if (event == "ADDON_LOADED") then
	distance_frame:EnableMouse(false);
end
--set bar colors
if (event == "ADDON_LOADED") then
	if barcolor == nil then 
barcolor = {
b1_color_h_r = 1,
b1_color_h_g = 1,
b1_color_h_b = 1,
b1_color_h_a = 1,

b2_color_h_r = 1,
b2_color_h_g = 1,
b2_color_h_b = 0,
b2_color_h_a = 1,

b3_color_h_r = 1,
b3_color_h_g = 0,
b3_color_h_b = 0,
b3_color_h_a = 1,

b4_color_h_r = 0,
b4_color_h_g = 1,
b4_color_h_b = 0,
b4_color_h_a = 1,


b1_color_w_r = 1,
b1_color_w_g = 1,
b1_color_w_b = 1,
b1_color_w_a = 1,

b2_color_w_r = 1,
b2_color_w_g = 1,
b2_color_w_b = 0,
b2_color_w_a = 1,

b3_color_w_r = 1,
b3_color_w_g = 0,
b3_color_w_b = 0,
b3_color_w_a = 1,

b4_color_w_r = 0,
b4_color_w_g = 1,
b4_color_w_b = 0,
b4_color_w_a = 1
}
end
end
--set bar width
if (event == "ADDON_LOADED") then
	if	distance_frame_width==nil then
		distance_frame_width=28
	end
end
--set bar height
if (event == "ADDON_LOADED") then
	if	height_value==nil then
		height_value=3
		distance_frame:SetHeight(41 * height_value +5);	
	end
end
--load texture 
if (event == "ADDON_LOADED") then
	if distance_bar_texture_h==nil then distance_bar_texture_h = "Interface\\AddOns\\Distance\\texture\\bar_h" 
	else distance_bar_height_texture_editbox:SetText(distance_bar_texture_h);
			distance_bar_height_texture_editbox:SetAutoFocus(false);
	end		
	
	if distance_bar_texture_w==nil then distance_bar_texture_w="Interface\\AddOns\\Distance\\texture\\bar_w"
	else distance_bar_width_texture_editbox:SetText(distance_bar_texture_w);
			distance_bar_width_texture_editbox:SetAutoFocus(false);
	end
end

--load frame position
if (event == "ADDON_LOADED") 
	then 
		if distance_frame_X==nil and distance_frame_Y==nil 
		then
				distance_frame:ClearAllPoints();
				distance_frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	else	
				distance_frame:ClearAllPoints();
				distance_frame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", distance_frame_X, distance_frame_Y);
	end

end
---------------------------------------------------------
--load bar layout
if (event == "ADDON_LOADED") then 
	if distance_layout==nil
	then distance_layout=false
			distance_options_frame_rotate_button:SetChecked(false)
	else 
		if distance_layout==false then 
			distance_options_frame_rotate_button:SetChecked(false)
			
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
			
	else  
		if distance_layout==true then 
			distance_options_frame_rotate_button:SetChecked(true)
			
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
			
	end
	end
	end
end
---------------------------------------------------------
--load bar values	
if (event == "ADDON_LOADED") then  
			
		if distance_frame_width == nil 
			then 	distance_frame_width = distance_frame:GetWidth();
						distance_frame:SetWidth(distance_frame_width)
						distance_range1:SetWidth(distance_frame:GetWidth()-5);
						distance_range2:SetWidth(distance_frame:GetWidth()-5);
						distance_range3:SetWidth(distance_frame:GetWidth()-5);
						distance_range4:SetWidth(distance_frame:GetWidth()-5);
								--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance width:" ..distance_frame_width);
			else  if (distance_layout==false) 
					then distance_frame:SetWidth(distance_frame_width)
							distance_range1:SetWidth(distance_frame:GetWidth()-5);
							distance_range2:SetWidth(distance_frame:GetWidth()-5);
							distance_range3:SetWidth(distance_frame:GetWidth()-5);
							distance_range4:SetWidth(distance_frame:GetWidth()-5);
								--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance width o:" ..distance_frame_width);
			else if (distance_layout==true)
					then	distance_frame:SetWidth(distance_frame_width);
			end
			end
		end
		
		if distance_frame_height == nil
			then		distance_frame_height = distance_frame:GetHeight();
						distance_frame:SetHeight(distance_frame_height)
									--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance height:" ..distance_frame_height);
			else  if (distance_layout==false) 
					then	distance_frame:SetHeight(distance_frame_height)
									--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance height o:" ..distance_frame_height);
			else  if (distance_layout==true) 
					then distance_frame:SetHeight(distance_frame_height)
							distance_range1:SetHeight(distance_frame:GetHeight()-5);
							distance_range2:SetHeight(distance_frame:GetHeight()-5);
							distance_range3:SetHeight(distance_frame:GetHeight()-5);
							distance_range4:SetHeight(distance_frame:GetHeight()-5);
			end
			end
		end	
				
		if distance_frame_alpha == nil 
			then 	distance_frame_alpha = distance_frame:GetAlpha()
						distance_frame:SetAlpha(distance_frame_alpha)
							--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance alpha:" ..distance_frame_alpha);
			else 	distance_frame:SetAlpha(distance_frame_alpha)
							--DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance alpha o:" ..distance_frame_alpha);
		end		
		
end
---------------------------------------------------------
--load text anchor
if (event == "ADDON_LOADED") then 
	if distance_text_position == nil 
			then distance_text_position = "BR" 
					distance_text_offset();
					distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", offset_X_1, -offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", offset_X_2, -offset_Y_2);
	else
	if (distance_layout==false) then 
		distance_text_offset();	
		if distance_text_position == "BR"
			then distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", offset_X_1, -offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", offset_X_2, -offset_Y_2);
		elseif distance_text_position == "BL"
			then	distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", -offset_X_1, -offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", -offset_X_2, -offset_Y_2);
		elseif distance_text_position == "TL"
			then	distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", -offset_X_1, offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", -offset_X_2, offset_Y_2);
		elseif distance_text_position == "TR"
			then	distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", offset_X_1, offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", offset_X_2, offset_Y_2);	
		elseif distance_text_position == "TC"
			then	distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", 0, offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", 0, offset_Y_2);
		elseif distance_text_position == "BC"						
			then distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "TOP", 0, -offset_Y_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "TOP", 0, -offset_Y_2);	
		end
else if(distance_layout==true) then 	
		distance_text_offset();	
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
			then	distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", -offset_Y_1, offset_X_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", -offset_Y_1, offset_X_1);
		elseif distance_text_position == "TR"
			then	distance_text:ClearAllPoints();
					distance_text1:ClearAllPoints();
					distance_text:SetPoint("CENTER", "distance_range2", "RIGHT", offset_Y_1, offset_X_1);
					distance_text1:SetPoint("CENTER", "distance_range4", "RIGHT", offset_Y_1, offset_X_1);
		elseif distance_text_position == "TC"
			then	distance_text:ClearAllPoints();
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
end

---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
function distance_Change_OnEvent()
--talent points
	if (event == "CHARACTER_POINTS_CHANGED")
		then 	DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Addon: |cFFFF0000Talents checked");	
					distance_talent_check();
	end
	

--change target
if (event == "PLAYER_TARGET_CHANGED") or (event == "DUEL_FINISHED") or (event == "PLAYER_ALIVE")
then	
	
--show/hide frame
	if (UnitIsFriend("player", "target")==1) 												--add classes for friendly ranges
		and (UnitClass("player")==DISTANCE_SHAMAN) 
		or (UnitClass("player")==DISTANCE_PALADIN) 
		or (UnitClass("player")==DISTANCE_PRIEST) 
		--or (UnitClass("player")==DISTANCE_MAGE) 
		--or (UnitClass("player")==DISTANCE_WARLOCK) 
		
			then distance_frame:Show(); 
		elseif (UnitIsFriend("player", "target")==nil)
			then distance_frame:Show(); 		
		else distance_frame:Hide(); 
	end

--show/hide range2/4
	if (UnitIsFriend("player", "target")==nil) 
		then distance_talent_check();
				distance_spell_check();
				distance_range4:Hide();
				distance_range2:Show();
	elseif  (UnitIsFriend("player", "target")==1)
		then distance_talent_check();
				distance_spell_check();	
				distance_range4:Show();
				distance_range2:Hide();
	end
	
--hide if enemy target is dead, show if friendly target is dead
	if (UnitIsDeadOrGhost("target")==1) 
		and (UnitIsFriend("player", "target")==nil)
			then	distance_frame:Hide(); 
	elseif (UnitIsDeadOrGhost("target")==1) 
		and (UnitIsFriend("player", "target")==1)
			and (UnitClass("player")==DISTANCE_SHAMAN) 			--show for classes with resurection spells else hide
				or (UnitClass("player")==DISTANCE_PALADIN) 
				or (UnitClass("player")==DISTANCE_PRIEST) 
			then	distance_frame:Show();
	end

--hide if no unit or disconnected
	if (UnitExists("target")==nil) or (UnitIsConnected("target")==nil)
			then	distance_frame:Hide();
	end

	--hide if player is dead
	if (UnitIsDeadOrGhost("player"))
		then	distance_frame:Hide(); 
	end
end

end
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
function distance_Command(cmd)

--display commands
if (cmd=="")
	then DEFAULT_CHAT_FRAME:AddMessage("Distance Commands:");
			DEFAULT_CHAT_FRAME:AddMessage("/distance menu");		
end
---------------------------------------------------------
  if (cmd=="menu") 
	then distance_options_frame:Show();
			distance_frame:Show();
		
		if (distance_layout==false) then 	
			distance_options_slider_width:SetMinMaxValues(14, 200);
			distance_options_slider_width:SetOrientation("HORIZONTAL"); 
			distance_options_slider_width:SetValue(distance_frame_width);
			distance_options_slider_width:SetValueStep(1);
			
			distance_options_slider_height:SetMinMaxValues(100, 1000);
			distance_options_slider_height:SetOrientation("HORIZONTAL"); 
			distance_options_slider_height:SetValue(height_value*100);
			distance_options_slider_height:SetValueStep(1);
			
			distance_options_slider_alpha:SetMinMaxValues(0, 100);
			distance_options_slider_alpha:SetOrientation("HORIZONTAL"); 
			distance_options_slider_alpha:SetValue(distance_frame_alpha*100);
			distance_options_slider_alpha:SetValueStep(1);
			
			distance_color_tab1=true
			distance_color_tab2=false
			distance_color_tab3=false
			distance_color_tab4=false
			distance_color_tab5=false

			--distance_color_bar1:SetTexture(distance_bar_texture_w) 
			--distance_color_bar1:SetVertexColor(barcolor.b1_color_w_r, barcolor.b1_color_w_g, barcolor.b1_color_w_b);
			
			distance_options_color_tab1:SetTextHeight(14);
			distance_options_color_bar1:SetHighlightTexture(distance_bar_texture_w);
										
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
			
			distance_options_slider_red:SetMinMaxValues(0, 100);
			distance_options_slider_red:SetOrientation("HORIZONTAL");
			distance_options_slider_red:SetValue(barcolor.b1_color_w_r*100);
			distance_options_slider_red:SetValueStep(1);
			
			distance_options_slider_green:SetMinMaxValues(0, 100);
			distance_options_slider_green:SetOrientation("HORIZONTAL");
			distance_options_slider_green:SetValue(barcolor.b1_color_w_g*100);
			distance_options_slider_green:SetValueStep(1);
			
			distance_options_slider_blue:SetMinMaxValues(0, 100);
			distance_options_slider_blue:SetOrientation("HORIZONTAL");
			distance_options_slider_blue:SetValue(barcolor.b1_color_w_b*100);
			distance_options_slider_blue:SetValueStep(1);
	else 
		if (distance_layout==true) then 
			distance_options_slider_width:SetMinMaxValues(14, 200);
			distance_options_slider_width:SetOrientation("HORIZONTAL"); 
			distance_options_slider_width:SetValue(distance_frame_height);
			distance_options_slider_width:SetValueStep(1);
			
			distance_options_slider_height:SetMinMaxValues(100, 1000);
			distance_options_slider_height:SetOrientation("HORIZONTAL"); 
			distance_options_slider_height:SetValue(height_value*100);
			distance_options_slider_height:SetValueStep(1);
			
			distance_options_slider_alpha:SetMinMaxValues(0, 100);
			distance_options_slider_alpha:SetOrientation("HORIZONTAL"); 
			distance_options_slider_alpha:SetValue(distance_frame_alpha*100);
			distance_options_slider_alpha:SetValueStep(1);
			
			distance_color_tab1=true
			distance_color_tab2=false
			distance_color_tab3=false
			distance_color_tab4=false
			distance_color_tab5=false
	
			distance_options_color_tab1:SetTextHeight(14);
			distance_options_color_bar1:SetHighlightTexture(distance_bar_texture_w);
										
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
			
			distance_options_slider_red:SetMinMaxValues(0, 100);
			distance_options_slider_red:SetOrientation("HORIZONTAL");
			distance_options_slider_red:SetValue(barcolor.b1_color_w_r*100);
			distance_options_slider_red:SetValueStep(1);
			
			distance_options_slider_green:SetMinMaxValues(0, 100);
			distance_options_slider_green:SetOrientation("HORIZONTAL");
			distance_options_slider_green:SetValue(barcolor.b1_color_w_g*100);
			distance_options_slider_green:SetValueStep(1);
			
			distance_options_slider_blue:SetMinMaxValues(0, 100);
			distance_options_slider_blue:SetOrientation("HORIZONTAL");
			distance_options_slider_blue:SetValue(barcolor.b1_color_w_b*100);
			distance_options_slider_blue:SetValueStep(1);
		end
	end
	if  distance_frame:IsMovable(true) 
		then distance_options_frame_lock_button:SetChecked(false) 
		else distance_options_frame_lock_button:SetChecked(true) 
	end
end
end
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--move frame
function distance_OnMouseUp()
	if (distance_frame.isMoving) then
		distance_frame:StopMovingOrSizing();
		distance_frame.isMoving = false;
				distance_frame_Y = distance_frame:GetBottom();
				distance_frame_X = distance_frame:GetLeft();	
				distance_frame:ClearAllPoints();
				distance_frame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", distance_frame_X, distance_frame_Y);
						--DEFAULT_CHAT_FRAME:AddMessage("X: " .. distance_frame_X );	
						--DEFAULT_CHAT_FRAME:AddMessage("Y: " .. distance_frame_Y );
	end
end
---------------------------------------------------------------------------------------------------------------------------------
function distance_OnMouseDown()
	if (distance_frame:IsMovable()) then	
	if  ( ( not distance_frame.isLocked ) or ( distance_frame.isLocked == 0 ) and ( arg1 == "LeftButton" ) ) then
		distance_frame:StartMoving();
		distance_frame.isMoving = true;
	end
	end
end
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--Spell check
function distance_spell_check()

--HUNTER SPELLS
if UnitClass("player")==DISTANCE_HUNTER
then

--HUNTER 
--41yard ENEMY 
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_ImpalingBolt"))					--Arcane Shot	
		or (t and string.find(t,"INV_Spear_07"))							--aimed shot
		or (t and string.find(t,"Ability_Hunter_Quickshot"))			--serpent sting
		or (t and string.find(t,"Ability_Hunter_CriticalShot"))			--scorpid sting	
		or (t and string.find(t,"Ability_Hunter_AimedShot"))			--viper sting	
		or (t and string.find(t,"Spell_Arcane_Blink"))					--distracting shot	
		or (t and string.find(t,"Ability_UpgradeMoonGlaive"))		--multi shot
		or (t and string.find(t,"Spell_Nature_Drowsy"))				--tranquilizing shot
		or (t and string.find(t,"Spell_Frost_Stun"))						--Concussive Shot	
		or (t and string.find(t,"INV_Spear_02"))							--Wyvern Sting	
			then yard41=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_41:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_41:"..t);
			break
		end
end

--HUNTER 
--30yard ENEMY 
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_Throw"))		--Throw
			then yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--HUNTER 
--21yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_GolemStormBolt"))		--Scatter Shot
			then yard21=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_21:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_21:"..t);
			break
		end
end

--HUNTER 
--05yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_Rogue_Trip"))					--Wing Clip	
		or (t and string.find(t,"Ability_Hunter_SwiftStrike"))		--mongoose bite
		or (t and string.find(t,"Ability_Warrior_Challange"))		--counterattack
		or (t and string.find(t,"Ability_Rogue_Feint"))				--disengage			
			then yard05=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_05:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_05:"..t);
			break
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--SHAMAN
if UnitClass("player")==DISTANCE_SHAMAN
then

--SHAMAN
--40yard FRIEND 
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Nature_HealingWaveLesser"))			--Lesser Healing Wave
		or (t and string.find(t,"Spell_Nature_HealingWaveGreater"))		--Chain Heal
		or (t and string.find(t,"Spell_Nature_MagicImmunity"))				--Healing Wave
			then friendyard40=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--SHAMAN
--30yard FRIEND
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Nature_NullifyPoison"))				--Cure Poison
		or (t and string.find(t,"Spell_Nature_RemoveDisease"))		--Cure Disease	
		or (t and string.find(t,"Spell_Frost_WindWalkOn"))				--Water Walking	
		or (t and string.find(t,"Spell_Shadow_DemonBreath"))			--Water Breathing	
		--or (t and string.find(t,"Spell_Nature_Regenerate"))				--Ancestral Spirit	
			then friendyard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--SHAMAN
--30yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Nature_ChainLightning"))		--Chain Lightning
		or (t and string.find(t,"Spell_Nature_Lightning"))				--Lightning Bolt	
		--or (t and string.find(t,"Spell_Nature_Purge"))					--Purge
			then yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--SHAMAN
--20yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Nature_EarthShock"))		--Earth Shock	
		or (t and string.find(t,"Spell_Fire_FlameShock"))		--Flame Shock	
		or (t and string.find(t,"Spell_Frost_FrostShock"))		--FrostShock	
			then yard21=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_20:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_20:"..t);
			break
		end
end

--SHAMAN
--05yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Holy_SealOfMight"))		--Stormstrike
			then yard05=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_05:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_05:"..t);
			break
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--MAGE SPELLS
if UnitClass("player")==DISTANCE_MAGE
then

--MAGE
--30yard FRIEND

--MAGE
--40yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Holy_Dizzy")) 		--Detect Magic
			then yard41=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_41_Detect Magic:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_41_Detect Magic:"..t);
			break
		end
end

--MAGE
--35yard  ENEMY rangeFlameThrowing35
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Fire_FlameBolt"))		 --Fireball
			then yard35=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_35_Fireball:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_35_Fireball:"..t);
			break
		end
end

--MAGE
--30yard ENEMY rangeFlameThrowing30
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Fire_SoulBurn"))		 --Scorch
			then fire_yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30_Fire_Scorch:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30_Fire_Scorch:"..t);
			break
		end
end

--MAGE
--30yard ENEMY rangeArcticReach30
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Frost_FrostBolt02"))		 --Frostbolt
			then frost_yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30_Frost_Frostbolt:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30_Frost_Frostbolt:"..t);
			break
		end
end

--MAGE
--20yard ENEMY rangeFlameThrowing20
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Fire_Fireball"))		--Fire Blast 
			then yard21=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_20_Fire Blast :"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_20_Fire Blast :"..t);
			break
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--DRUID SPELLS
if UnitClass("player")==DISTANCE_DRUID
then

--DRUID
--30yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Nature_AbolishMagic"))		--Warth
			then yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--PALADIN SPELLS
if UnitClass("player")==DISTANCE_PALADIN
then

--PALADIN 
-- 40yard FRIEND
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Holy_FlashHeal"))									--Flash of Light 	
		or (t and string.find(t,"Spell_Holy_HolyBolt"))									--Holy Light 	
		or (t and string.find(t,"Spell_Holy_LayOnHands"))								--Lay on Hands 	
		or (t and string.find(t,"Spell_Holy_GreaterBlessingofKings"))				--Greater Blessing of Might	
		or (t and string.find(t,"Spell_Holy_GreaterBlessingofWisdom"))			--Greater Blessing of Wisdom
		or (t and string.find(t,"Spell_Holy_GreaterBlessingofSalvation"))		--Greater Blessing of Salvation	
		or (t and string.find(t,"Spell_Holy_GreaterBlessingofLight"))				--Greater Blessing of Light 	
		or (t and string.find(t,"Spell_Magic_GreaterBlessingofKings"))			--Greater Blessing of Kings  	
		or (t and string.find(t,"Spell_Holy_GreaterBlessingofSanctuary"))		--Greater Blessing of Sanctuary
		or (t and string.find(t,"Spell_Nature_TimeStop"))								--Divine Intervention 
			then friendyard40=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_40:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_40:"..t);
			break
		end
end

--PALADIN 
-- 30yard FRIEND
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Holy_FistOfJustice"))						--Blessing of Might
		or (t and string.find(t,"Spell_Holy_SealOfWisdom"))					--Blessing of Wisdom 
		or (t and string.find(t,"Spell_Holy_SealOfSalvation"))				--Blessing of Salvation 	
		or (t and string.find(t,"Spell_Holy_PrayerOfHealing02"))			--Blessing of Light
		or (t and string.find(t,"Spell_Magic_MageArmor"))					--Blessing of Kings
		or (t and string.find(t,"Spell_Nature_LightningShield"))				--Blessing of Sanctuary 
		or (t and string.find(t,"Spell_Holy_SealOfValor"))						--Blessing of Freedom 
		or (t and string.find(t,"Spell_Holy_SealOfSacrifice"))					--Blessing of Sacrifice 
		or (t and string.find(t,"Spell_Holy_SealOfProtection"))				--Blessing of Protection
		or (t and string.find(t,"Spell_Holy_Renew"))								--Cleanse 
		--or (t and string.find(t,"Spell_Holy_Resurrection"))								--Redemption
			then friendyard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--PALADIN 
-- 20yard FRIEND
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Holy_SearingLight"))		 --Holy Shock 
			then friendyard20=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_20:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_20:"..t);
			break
		end
end

--PALADIN 
-- 30yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Holy_Exorcism_02"))		 --Exorcism
			then yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--PALADIN 
-- 20yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Holy_Exorcism"))				--Holy Wrath 
		or (t and string.find(t,"Spell_Holy_TurnUndead"))			--Turn Undead 
		or (t and string.find(t,"Spell_Holy_SearingLight"))			--Holy Shock 
			then yard20=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_20:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_20:"..t);
			break
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--PRIEST SPELLS
if UnitClass("player")==DISTANCE_PRIEST
then

--PRIEST 
-- 40yard FRIEND
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Holy_FlashHeal"))			 		--Flash Heal	
		or(t and string.find(t,"Spell_Holy_GreaterHeal"))		 		--Greater Heal
		or(t and string.find(t,"Spell_Holy_Heal02"))				 		--Heal
		or(t and string.find(t,"Spell_Holy_LesserHeal"))		 		--Lesser Heal
		or(t and string.find(t,"Spell_Holy_PowerWordShield"))		--Power Word:Shield
		or(t and string.find(t,"Spell_Holy_Renew"))		 				--Renew
			then friendyard40=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_40:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_40:"..t);
			break
		end
end

--PRIEST 
-- 30yard FRIEND
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Nature_NullifyDisease"))		 --Abolish Disease	
		or(t and string.find(t,"Spell_Holy_NullifyDisease"))			 --Cure Disease		
		or(t and string.find(t,"Spell_Holy_DispelMagic"))		 		--Dispell Magic
		or(t and string.find(t,"Spell_Holy_DivineSpirit"))			 	--Divine Spirit
		or(t and string.find(t,"Spell_Holy_WordFortitude"))		 	--Power Word: Fortitude
		--or(t and string.find(t,"Spell_Holy_Resurrection"))		 		--Resurrection	
		or(t and string.find(t,"Spell_Shadow_AntiShadow"))			--Shadow Protection	
			then friendyard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--PRIEST 
-- 40yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Holy_MindSooth"))		 --Mind Shoothe	
			then yard40=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_40:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_40:"..t);
			break
		end
end

--PRIEST 
-- 30yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Holy_DispelMagic"))		 			--Dispell Magic	
			then yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--PRIEST 
-- 30yard ENEMY HOLY
 for i = 1, 120 do t = GetActionTexture(i)
		if(t and string.find(t,"Spell_Holy_SearingLight"))		 			--Holy Fire
		or(t and string.find(t,"Spell_Holy_HolySmite"))		 				--Smite	
			then holy_yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--PRIEST 
-- 30yard ENEMY SHADOW
 for i = 1, 120 do t = GetActionTexture(i)
		if(t and string.find(t,"Spell_Shadow_ManaBurn"))		 				--Mana Burn	
		or(t and string.find(t,"Spell_Shadow_UnholyFrenzy"))			 	--Mind Blast
		or(t and string.find(t,"Spell_Shadow_ShadowWordPain"))		 	--Shadow Word: Pain
			then shadow_yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--PRIEST 
-- 20yard ENEMY
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Shadow_ShadowWordDominate"))		 	--Mind Control
		or (t and string.find(t,"Spell_Shadow_SiphonMana"))		 				--Mind Flay
	
			then yard20=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_20:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_20:"..t);
			break
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--WARLOCK SPELLS
if UnitClass("player")==DISTANCE_WARLOCK
then

--WARLOCK 
-- 30yard ENEMY 	Destructive Reach 
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Fire_Immolation"))		 		--Immolate
		or (t and string.find(t,"Spell_Fire_SoulBurn"))		 			--Searing Pain
		or (t and string.find(t,"Spell_Fire_Fireball02"))		 			--Soul Fire
		or (t and string.find(t,"Spell_Shadow_ShadowBolt"))		 	--Shadow Bolt		
		or (t and string.find(t,"Spell_Fire_Fireball"))						 --Conflagrate		
			then destruction_yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--WARLOCK 
-- 30yard ENEMY 	Grim Reach 
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Shadow_AbominationExplosion"))		 --Corruption
		or (t and string.find(t,"Spell_Shadow_CurseOfSargeras"))				 --Curse of Agony
		or (t and string.find(t,"Spell_Shadow_AuraOfDarkness"))				 --Curse of Doom	
		or (t and string.find(t,"Spell_Shadow_UnholyStrength"))		 		--Curse of Recklessness
		or (t and string.find(t,"Spell_Shadow_CurseOfAchimonde"))		 	--Curse of Shadow
		or (t and string.find(t,"Spell_Shadow_ChillTouch"))		 				--Curse of Elements
		or (t and string.find(t,"Spell_Shadow_CurseOfTounges"))				 --Curse of Tongues
		or (t and string.find(t,"Spell_Shadow_CurseOfMannoroth"))		 	--Curse of Weakness
		or (t and string.find(t,"Spell_Shadow_DeathCoil"))		 				--Death Coil	
		or (t and string.find(t,"Spell_Shadow_Haunting"))							 --Drain Soul	
			then grim_yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--WARLOCK 
-- 20yard ENEMY 	Grim Reach 
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Shadow_Possession"))		 		--Fear	
		or (t and string.find(t,"Spell_Shadow_SiphonMana"))			 --Drain Mana
		or (t and string.find(t,"Spell_Shadow_LifeDrain02"))				 --Drain Life
			then grim_yard20=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_20:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_20:"..t);
			break
		end
end

--WARLOCK 
-- 30yard FRIEND
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Shadow_DetectInvisibility"))					 --Detect Invisibility
		or (t and string.find(t,"Spell_Shadow_DetectLesserInvisibility"))		 --Detect Lesser Invisibility
		or (t and string.find(t,"Spell_Shadow_DemonBreath"))		 				--Unending Breath
			then friend_yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--WARRIORSPELLS
if UnitClass("player")==DISTANCE_WARRIOR
then

--30yard	WARRIOR
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_Marksmanship"))		 --Shoot 
		or (t and string.find(t,"Ability_Throw"))				--Throw
			then yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--25yard	WARRIOR
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_Warrior_Charge"))		 --Charge
		or (t and string.find(t,"Ability_Rogue_Sprint"))		 	--Intercept
			then yard25=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_25:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_25:"..t);
			break
		end
end

--10yard	WARRIOR
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_GolemThunderClap"))		 --Intimidating Shout 
			then yard10=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_10:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_10:"..t);
			break
		end
end

--08yard	WARRIOR
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_Marksmanship"))		 --Shoot
		or (t and string.find(t,"Ability_Throw"))				--Throw
			then yard08=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_08:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_08:"..t);
			break
		end
end

--05yard	WARRIOR
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_Warrior_Sunder"))		 			--Sunder Armor
		or (t and string.find(t,"Ability_Warrior_DecisiveStrike"))		--Slam
		or (t and string.find(t,"Ability_Warrior_Disarm"))		 			--Disarm
		or (t and string.find(t,"INV_Gauntlets_04"))							--Pummel
		or (t and string.find(t,"Ability_MeleeDamage"))		 			--Overpower
		or (t and string.find(t,"Ability_Warrior_PunishingBlow"))		--Mocking Blow 
		or (t and string.find(t,"Ability_Warrior_Revenge"))		 		--Revenge
		or (t and string.find(t,"Ability_Gouge"))		 						--Rend
		or (t and string.find(t,"INV_Sword_48"))		 						--Execute
		or (t and string.find(t,"Ability_ShockWave"))		 			--Hamstring
			then yard05=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_05:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_05:"..t);
			break
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--ROGUESPELLS
if UnitClass("player")==DISTANCE_ROGUE
then

--30yard ROGUE
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_Marksmanship"))				 			--Shoot
		or (t and string.find(t,"Ability_Throw"))									--Throw
		--or (t and string.find(t,"Ability_Rogue_Distract"))		 				--Distract
			then yard30=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_30:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_30:"..t);
			break
		end
end

--10yard ROGUE
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Spell_Shadow_MindSteal"))		 				--Blind
			then yard10=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_10:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_10:"..t);
			break
		end
end

--05yard ROGUE
 for i = 1, 120 do t = GetActionTexture(i)
		if (t and string.find(t,"Ability_Rogue_Ambush"))		 				--Ambush
		or (t and string.find(t,"Ability_BackStab"))		 						--Backstab
		or (t and string.find(t,"Ability_CheapShot"))		 						--Cheap Shot	
		or (t and string.find(t,"Ability_Rogue_Eviscerate"))		 			--Eviscerate
		or (t and string.find(t,"Ability_Warrior_Riposte"))		 				--Expose Armor
		or (t and string.find(t,"Ability_Rogue_Feint"))		 					--Feint
		or (t and string.find(t,"Ability_Rogue_Garrote"))		 				--Garrote
		or (t and string.find(t,"Ability_Gouge"))		 							--Gouge
		or (t and string.find(t,"Spell_Shadow_LifeDrain"))		 				--Hemorrage
		or (t and string.find(t,"Ability_Kick"))		 								--Kick
		or (t and string.find(t,"Ability_Rogue_KidneyShot"))		 			--Kidney Shot
		or (t and string.find(t,"Ability_Rogue_Rupture"))		 				--Rupture
		or (t and string.find(t,"Ability_Sap"))		 								--Sap
		or (t and string.find(t,"Spell_Shadow_RitualOfSacrifice"))		 	--Sinister Strike
			then yard05=i
						--DEFAULT_CHAT_FRAME:AddMessage("-Slot_05:"..i);
						--DEFAULT_CHAT_FRAME:AddMessage("-Texture_05:"..t);
			break
		end
end
end

end
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--Talent check  distance_talent_check
function distance_talent_check()

local numTabs = GetNumTalentTabs();
for t=1, numTabs do
local numTalents = GetNumTalents(t);
for i = 1, numTalents do nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(t,i);
---------------------------------------------------------	
--HUNTER 
	if UnitClass("player")==DISTANCE_HUNTER
		then if nameTalent==DISTANCE_HAWK_EYE
			then if currRank==0
				then  rangeHawkEye = 35; textHawkEye = 35;
								--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==1
					then rangeHawkEye = 37; textHawkEye = 37;
								--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==2
					then rangeHawkEye = 39; textHawkEye = 39;
								--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
					end
				if currRank==3
					then rangeHawkEye = 41; textHawkEye = 41;
								--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
		end
	end
---------------------------------------------------------
---------------------------------------------------------	
--SHAMAN	
	if UnitClass("player")==DISTANCE_SHAMAN
		then if nameTalent==DISTANCE_STORM_REACH 
			then if currRank==0
				then rangeStormReach = 30; textStormReach = 30;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==1
				then rangeStormReach = 33; textStormReach = 33;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==2
					then rangeStormReach = 36; textStormReach = 36;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);		
				end
		end
	end
---------------------------------------------------------
---------------------------------------------------------
--MAGE FIRE
	if UnitClass("player")==DISTANCE_MAGE
		then if nameTalent==DISTANCE_FLAME_THROWING
			then if currRank==0
				then rangeFlameThrowing35 = 35; textFlameThrowing35 = 35;
						rangeFlameThrowing30 = 30; textFlameThrowing30 = 30;
						rangeFlameThrowing20 = 20; textFlameThrowing20 = 20;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end 
				if currRank==1
				then rangeFlameThrowing35 = 38; textFlameThrowing35 = 38;
						rangeFlameThrowing30 = 33; textFlameThrowing30 = 33;
						rangeFlameThrowing20 = 23; textFlameThrowing20 = 23;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==2
				then rangeFlameThrowing35 = 41; textFlameThrowing35 = 41;
						rangeFlameThrowing30 = 36; textFlameThrowing30 = 36;
						rangeFlameThrowing20 = 26; textFlameThrowing20 = 26;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
		end
	end
---------------------------------------------------------	
--MAGE FROST 30
	if UnitClass("player")==DISTANCE_MAGE
		then if nameTalent==DISTANCE_ARCTIC_REACH 
			then if currRank==0
				then rangeArcticReach30 = 30; textArcticReach30 = 30;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==1
				then rangeArcticReach30 = 33; textArcticReach30 = 33;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==2
				then rangeArcticReach30 = 36; textArcticReach30 = 36;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
		end
	end
---------------------------------------------------------
---------------------------------------------------------		
--DRUID 30
	if UnitClass("player")==DISTANCE_DRUID
		then if nameTalent==DISTANCE_NATURES_REACH
			then if currRank==0
				then rangeNaturesReach30 = 30; textNaturesReach30 = 30;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==1
				then rangeNaturesReach30 = 33; textNaturesReach30 = 33;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==2
					then rangeNaturesReach30 = 36; textNaturesReach30 = 36;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);	
				end
		end
	end
---------------------------------------------------------
---------------------------------------------------------
--PRIEST HOLY
	if UnitClass("player")==DISTANCE_PRIEST
		then if nameTalent==DISTANCE_HOLY_REACH
			then if currRank==0
				then	rangeHolyReach30 = 30; textHolyReach30 = 30;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end 
				if currRank==1
				then rangeHolyReach30 = 33; textHolyReach30 = 33;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==2
				then rangeHolyReach30 = 36; textHolyReach30 = 36;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
		end
	end
---------------------------------------------------------
--PRIEST SHADOW
	if UnitClass("player")==DISTANCE_PRIEST
		then if nameTalent==DISTANCE_SHADOW_REACH
			then if currRank==0
				then	rangeShadowReach30 = 30; textShadowReach30 = 30;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end 
				if currRank==1
				then rangeShadowReach30 = 31.8; textShadowReach30 = 31.8;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==2
				then rangeShadowReach30 = 33.9; textShadowReach30 = 33.9;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==3
				then rangeShadowReach30 = 36; textShadowReach30 = 36;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
		end
	end
---------------------------------------------------------
---------------------------------------------------------
--WARLOCK Destruction
	if UnitClass("player")==DISTANCE_WARLOCK
		then if nameTalent==DISTANCE_DESTRUCTIVE_REACH
			then if currRank==0
				then	rangeDestructiveReach30 = 30; textDestructiveReach30 = 30;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end 
				if currRank==1
				then rangeDestructiveReach30 = 33; textDestructiveReach30 = 33;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==2
				then rangeDestructiveReach30 = 36; textDestructiveReach30 = 36;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
		end
	end

--WARLOCK Affliction
	if UnitClass("player")==DISTANCE_WARLOCK
		then if nameTalent==DISTANCE_GRIM_REACH
			then if currRank==0
				then	rangeGrimReach30 = 30; textGrimReach30 = 30;
						rangeGrimReach20 = 20; textGrimReach20 = 20;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end 
				if currRank==1
				then rangeGrimReach30 = 33; textGrimReach30 = 33;
						rangeGrimReach20 = 22; textGrimReach20 = 22;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
				if currRank==2
				then rangeGrimReach30 = 36; textGrimReach30 = 36;
						rangeGrimReach20 = 24; textGrimReach20 = 24;
							--DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
		end
	end
---------------------------------------------------------		
end
end
end
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--OnUpdate 	range WHITE 
function distance_range1_OnUpdate(arg1)

 if distance_layout==false
	then 
		distance_range_color1:SetTexture(distance_bar_texture_h) 
		distance_range_color1:SetVertexColor(barcolor.b1_color_h_r, barcolor.b1_color_h_g, barcolor.b1_color_h_b);
		distance_color_bar1:SetTexture(distance_bar_texture_w) 
		distance_color_bar1:SetVertexColor(barcolor.b1_color_w_r, barcolor.b1_color_w_g, barcolor.b1_color_w_b);
	else
		distance_range_color1:SetTexture(distance_bar_texture_w) 
		distance_range_color1:SetVertexColor(barcolor.b1_color_w_r, barcolor.b1_color_w_g, barcolor.b1_color_w_b);
		distance_color_bar1:SetTexture(distance_bar_texture_w) 
		distance_color_bar1:SetVertexColor(barcolor.b1_color_w_r, barcolor.b1_color_w_g, barcolor.b1_color_w_b);
end

distance_frame.TimeSinceLastUpdate = distance_frame.TimeSinceLastUpdate + arg1; 	
if (distance_frame.TimeSinceLastUpdate > distance_frame_UpdateInterval) then
---------------------------------------------------------------------------------------------------------------------------------
if (UnitClass("player")==DISTANCE_HUNTER)  then

--oor    HUNTER
if (IsActionInRange(yard41)==0) and (IsActionInRange(yard21)==0) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--41 	HUNTER
if  (IsActionInRange(yard41)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeHawkEye * height_value)
			else distance_range1:SetWidth(rangeHawkEye * height_value)
		end
end
---------------------------------------------------------
--30 	HUNTER
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeHawkEye * height_value)
			else distance_range1:SetWidth(rangeHawkEye * height_value)
		end
end
---------------------------------------------------------
--25 	HUNTER
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range30 * height_value)
			else distance_range1:SetWidth(range30 * height_value)
		end
end
---------------------------------------------------------
--21 	HUNTER
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then UIFrameFlash(distance_range1, .5, .5, .5, true, .5, .5)
					distance_range1:SetHeight(range25 * height_value)
			else UIFrameFlash(distance_range1, .5, .5, .5, true, .5, .5)
					distance_range1:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--08 	HUNTER
if (IsActionInRange(yard41)==0) and (IsActionInRange(yard21)==1)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range21 * height_value)
			else distance_range1:SetWidth(range21 * height_value)
		end
end
---------------------------------------------------------
--05 	HUNTER
if (IsActionInRange(yard05)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range08 * height_value)
			else distance_range1:SetWidth(range08 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
if (UnitClass("player")==DISTANCE_SHAMAN)  then

--oor  SHAMAN ENEMY
if (UnitIsVisible("target")==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--41 	SHAMAN  ENEMY
if  (IsActionInRange(yard41)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end

--41 	SHAMAN FRIEND
if  (IsActionInRange(friendyard40)==1) and (UnitIsFriend("player", "target")==1)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30 	SHAMAN ENEMY
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end	

--30   SHAMAN FRIEND
if  (IsActionInRange(friendyard30)==1) and (UnitIsFriend("player", "target")==1)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--25  SHAMAN ENEMY
if (CheckInteractDistance("target",4)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeStormReach * height_value)
			else distance_range1:SetWidth(rangeStormReach * height_value)
		end
end

--25 	 SHAMAN FRIEND
if (CheckInteractDistance("target",4)==1) and (UnitIsFriend("player", "target")==1)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range30 * height_value)
			else distance_range1:SetWidth(range30 * height_value)
		end
end
---------------------------------------------------------
--21 	SHAMAN ENEMY
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range25 * height_value)
			else distance_range1:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--10 	SHAMAN
if (CheckInteractDistance("target",3)==1) --and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range20 * height_value)
			else distance_range1:SetWidth(range20 * height_value)
		end
end
---------------------------------------------------------
--05 	SHAMAN ENEMY
if (IsActionInRange(yard05)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range10 * height_value)
			else distance_range1:SetWidth(range10 * height_value)
		end
end

--05 	SHAMAN
--if (CheckInteractDistance("target",1)==1) and (UnitIsFriend("player", "target")==1)
--			then distance_range1:SetHeight(range10)
--end
end
---------------------------------------------------------------------------------------------------------------------------------
--MAGE RANGE_1
if (UnitClass("player")==DISTANCE_MAGE) then
	
--ooR MAGE
if (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--41 	 MAGE
if  (IsActionInRange(yard41)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--35 	 MAGE FIRE
if  (IsActionInRange(yard35)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30  MAGE FIRE
if  (IsActionInRange(fire_yard30)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeFlameThrowing35 * height_value)	
			else distance_range1:SetWidth(rangeFlameThrowing35 * height_value)	
		end	
end

--30  MAGE FROST
if  (IsActionInRange(frost_yard30)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeFlameThrowing35 * height_value)
			else distance_range1:SetWidth(rangeFlameThrowing35 * height_value) 
		end
end
---------------------------------------------------------
--21 	MAGE
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil)		--FIRE*FROST??
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeFlameThrowing30 * height_value)	
			else distance_range1:SetWidth(rangeFlameThrowing30 * height_value)	 
		end	
end

--21 	MAGE
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil)		--FIRE*FROST??
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeArcticReach30 * height_value)	
			else distance_range1:SetWidth(rangeArcticReach30 * height_value)	
		end	
end
---------------------------------------------------------
--10 	MAGE
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then UIFrameFlash(distance_range1, .5, .5, .5, true, .5, .5)
					distance_range1:SetHeight(range20 * height_value)
			else UIFrameFlash(distance_range1, .5, .5, .5, true, .5, .5)
					distance_range1:SetWidth(range20 * height_value)
		end
end
---------------------------------------------------------
--05 	MAGE
--if (CheckInteractDistance("target",1)) and (UnitIsFriend("player", "target")==nil)
--			then distance_range1:SetHeight(range10)
--end
end
---------------------------------------------------------------------------------------------------------------------------------
--DRUID RANGE_1
if (UnitClass("player")==DISTANCE_DRUID) then

--oor	 DRUID
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then 	
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30  	DRUID
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--25 	 DRUID
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeNaturesReach30 * height_value)
			else distance_range1:SetWidth(rangeNaturesReach30 * height_value)
		end
end
---------------------------------------------------------
--10	 DRUID
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range25 * height_value)
			else distance_range1:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--05	DRUID
if (IsActionInRange(yard05)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range10 * height_value)
			else distance_range1:SetWidth(range10 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--PALADIN RANGE_1
if (UnitClass("player")==DISTANCE_PALADIN)  then

--oor	PALADIN
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------	
--40 PALADIN FRIEND
if  (IsActionInRange(friendyard40)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------				
--30   PALADIN ENEMY
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end

--30 PALADIN FRIEND
if  (IsActionInRange(friendyard30)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--25 	 PALADIN
if (CheckInteractDistance("target",4)) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range30 * height_value)
			else distance_range1:SetWidth(range30 * height_value)
		end
end
---------------------------------------------------------
--20 	 PALADIN ENEMY
if  (IsActionInRange(yard20)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range25 * height_value)
			else distance_range1:SetWidth(range25 * height_value)
		end
end

--20 	 PALADIN FRIEND
if  (IsActionInRange(friendyard20)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range25 * height_value)
			else distance_range1:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--10	PALADIN
if (CheckInteractDistance("target",3))
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range20 * height_value)
			else distance_range1:SetWidth(range20 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--PRIEST RANGE_1
if (UnitClass("player")==DISTANCE_PRIEST)  then

--oor	PRIEST
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------					
--40   PRIEST ENEMY
if  (IsActionInRange(yard40)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end

--40   PRIEST FRIEND
if  (IsActionInRange(friendyard40)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30   PRIEST ENEMY
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end

--30   PRIEST HOLY
if  (IsActionInRange(holy_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value) 
		end
end

--30   PRIEST SHADOW
if  (IsActionInRange(shadow_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end

--30   PRIEST FRIEND
if  (IsActionInRange(friendyard30)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--25 	 PRIEST 
if (CheckInteractDistance("target",4))
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range30 * height_value)
			else distance_range1:SetWidth(range30 * height_value)
		end
end

--25 	 PRIEST HOLY
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeHolyReach30 * height_value)
			else distance_range1:SetWidth(rangeHolyReach30 * height_value)
		end
end

--25 	 PRIEST SHADOW
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeShadowReach30 * height_value)
			else distance_range1:SetWidth(rangeShadowReach30 * height_value)
		end
end
---------------------------------------------------------
--20 	 PRIEST ENEMY
if  (IsActionInRange(yard20)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range25 * height_value)
			else distance_range1:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--10	PRIEST
if (CheckInteractDistance("target",3)) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range20 * height_value)
			else distance_range1:SetWidth(range20 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--WARLOCK RANGE_1
if (UnitClass("player")==DISTANCE_WARLOCK)  then

--oor	WARLOCK
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30   WARLOCK	GRIM
if  (IsActionInRange(grim_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end

--30   WARLOCK	DESTRUCTION
if  (IsActionInRange(destruction_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--25 	 WARLOCK GRIM
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeGrimReach30 * height_value)
			else distance_range1:SetWidth(rangeGrimReach30 * height_value)
		end
end

--25 	 WARLOCK DESTRUCTION
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeDestructiveReach30 * height_value)
			else distance_range1:SetWidth(rangeDestructiveReach30 * height_value)
		end
end
---------------------------------------------------------
--20 	 WARLOCK GRIM
if  (IsActionInRange(grim_yard20)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range25 * height_value)
			else distance_range1:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--10	WARLOCK 
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(rangeGrimReach20 * height_value)
			else distance_range1:SetWidth(rangeGrimReach20 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
-- WARRIOR RANGE_1
if (UnitClass("player")==DISTANCE_WARRIOR)  then

--oor WARRIOR
if (IsActionInRange(yard30)==0) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then	distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30 WARRIOR
if (IsActionInRange(yard30)==1) and (IsActionInRange(yard10)==0) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--25 WARRIOR
if (IsActionInRange(yard25)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range30 * height_value)
			else distance_range1:SetWidth(range30 * height_value) 
		end
end
---------------------------------------------------------
--10 WARRIOR
if (IsActionInRange(yard10)==1) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range25 * height_value)
			else distance_range1:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--08 WARRIOR
if (IsActionInRange(yard10)==1) and (IsActionInRange(yard30)==0) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range10 * height_value)
			else distance_range1:SetWidth(range10 * height_value)
		end
end
---------------------------------------------------------
--05 WARRIOR
if (IsActionInRange(yard05)==1)  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range08 * height_value)
			else distance_range1:SetWidth(range08 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--ROGUE RANGE_1
if (UnitClass("player")==DISTANCE_ROGUE)  then

--oor ROGUE
if (IsActionInRange(yard30)==0) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30 ROGUE
if (IsActionInRange(yard30)==1) 
and (IsActionInRange(yard10)==0) 
and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range41 * height_value)
			else distance_range1:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--25 ROGUE
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range30 * height_value)
			else distance_range1:SetWidth(range30 * height_value)
		end
end
---------------------------------------------------------
--10 ROGUE
if (IsActionInRange(yard10)==1) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range25 * height_value)
			else distance_range1:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--08 ROGUE
if (IsActionInRange(yard10)==1) 
and (IsActionInRange(yard30)==0) 
and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range10 * height_value)
			else distance_range1:SetWidth(range10 * height_value)
		end
end
---------------------------------------------------------
--05 ROGUE
if (IsActionInRange(yard05)==1)  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range1:SetHeight(range08 * height_value)
			else distance_range1:SetWidth(range08 * height_value)
		end
end
end

distance_frame.TimeSinceLastUpdate = 0;

end
end
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--OnUpdate 	range YELLOW
function distance_range2_OnUpdate(arg1)

 if distance_layout==false
	then 
		distance_range_color2:SetTexture(distance_bar_texture_h) 
		distance_range_color2:SetVertexColor(barcolor.b2_color_h_r, barcolor.b2_color_h_g, barcolor.b2_color_h_b);
		distance_color_bar2:SetTexture(distance_bar_texture_w) 
		distance_color_bar2:SetVertexColor(barcolor.b2_color_w_r, barcolor.b2_color_w_g, barcolor.b2_color_w_b);
	else
		distance_range_color2:SetTexture(distance_bar_texture_w) 
		distance_range_color2:SetVertexColor(barcolor.b2_color_w_r, barcolor.b2_color_w_g, barcolor.b2_color_w_b);
		distance_color_bar2:SetTexture(distance_bar_texture_w) 
		distance_color_bar2:SetVertexColor(barcolor.b2_color_w_r, barcolor.b2_color_w_g, barcolor.b2_color_w_b);
end

distance_frame.TimeSinceLastUpdate = distance_frame.TimeSinceLastUpdate + arg1; 	
if (distance_frame.TimeSinceLastUpdate > distance_frame_UpdateInterval) then
---------------------------------------------------------------------------------------------------------------------------------
--HUNTER RANGE_2
if (UnitClass("player")==DISTANCE_HUNTER)  then

--oor  HUNTER
if (IsActionInRange(yard41)==0) and (IsActionInRange(yard21)==0)  and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(textooR)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(textooR)
		end
end
---------------------------------------------------------
--41 	HUNTER
if  (IsActionInRange(yard41)==1)  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeHawkEye * height_value)
					distance_number:SetText(textHawkEye)
			else distance_range2:SetWidth(rangeHawkEye * height_value)
					distance_number:SetText(textHawkEye)
		end
end
---------------------------------------------------------
--30  HUNTER 
if  (IsActionInRange(yard30)==1)  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range30 * height_value)
					distance_number:SetText(text30)
			else distance_range2:SetWidth(range30 * height_value)
					distance_number:SetText(text30)
		end
end
---------------------------------------------------------
--25 	HUNTER 
if (CheckInteractDistance("target",4))  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range25 * height_value)
					distance_number:SetText(text25)
			else distance_range2:SetWidth(range25 * height_value)
					distance_number:SetText(text25)
		end
end
---------------------------------------------------------
--21 	HUNTER
if  (IsActionInRange(yard21)==1)  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range21 * height_value)
					distance_number:SetText(text21)
			else distance_range2:SetWidth(range21 * height_value)
					distance_number:SetText(text21)
		end
end
---------------------------------------------------------
--08 	HUNTER
if (IsActionInRange(yard41)==0) and (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range08 * height_value)
					distance_number:SetText(text08)
			else distance_range2:SetWidth(range08 * height_value)
					distance_number:SetText(text08)
		end
end
---------------------------------------------------------
--05	HUNTER 
if (IsActionInRange(yard05)==1)  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range05 * height_value)
					distance_number:SetText(text05)
			else distance_range2:SetWidth(range05 * height_value)
					distance_number:SetText(text05)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--SHAMAN RANGE_2
if (UnitClass("player")==DISTANCE_SHAMAN) then

--oor	SHAMAN
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then 	
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(textooR)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(textooR)
		end
					
end
---------------------------------------------------------
--41 	SHAMAN
if  (IsActionInRange(yard41)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(text41)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(text41)
		end
end
---------------------------------------------------------					
--30   SHAMAN
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeStormReach * height_value)
					distance_number:SetText(textStormReach)
			else distance_range2:SetWidth(rangeStormReach * height_value)
					distance_number:SetText(textStormReach)
		end
end
---------------------------------------------------------
--25 	 SHAMAN 
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range25 * height_value)
					distance_number:SetText(text25)
			else distance_range2:SetWidth(range25 * height_value)
					distance_number:SetText(text25)
		end
end
---------------------------------------------------------
--22 	 SHAMAN 
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range20 * height_value)
					distance_number:SetText(text20)
			else distance_range2:SetWidth(range20 * height_value)
					distance_number:SetText(text20)
		end
end
---------------------------------------------------------
--10	SHAMAN 
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range10 * height_value)
					distance_number:SetText(text10)
			else distance_range2:SetWidth(range10 * height_value)
					distance_number:SetText(text10)
		end
end
---------------------------------------------------------
--05	SHAMAN
if (IsActionInRange(yard05)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range05 * height_value)
					distance_number:SetText(text05)
			else distance_range2:SetWidth(range05 * height_value)
					distance_number:SetText(text05)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--MAGE RANGE_2
if (UnitClass("player")==DISTANCE_MAGE) then

--oor	 MAGE
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil)
	then 	
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(textooR)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(textooR)
		end
end
---------------------------------------------------------
--41 	MAGE
if  (IsActionInRange(yard41)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(text41)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(text41)
		end
end
---------------------------------------------------------
--35 	 MAGE FIRE
if  (IsActionInRange(yard35)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeFlameThrowing35 * height_value)
					distance_number:SetText(textFlameThrowing35)
			else distance_range2:SetWidth(rangeFlameThrowing35 * height_value)
					distance_number:SetText(textFlameThrowing35)
		end
end
---------------------------------------------------------
--30  MAGE FIRE
if  (IsActionInRange(fire_yard30)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeFlameThrowing30 * height_value)	
					distance_number:SetText(textFlameThrowing30)
			else distance_range2:SetWidth(rangeFlameThrowing30 * height_value)	
					distance_number:SetText(textFlameThrowing30)
		end
end

--30  MAGE FROST
if  (IsActionInRange(frost_yard30)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeArcticReach30 * height_value)
					distance_number:SetText(textArcticReach30)
			else distance_range2:SetWidth(rangeArcticReach30 * height_value)
					distance_number:SetText(textArcticReach30)
		end
end
---------------------------------------------------------
--21 	 MAGE
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeFlameThrowing20 * height_value)
					distance_number:SetText(textFlameThrowing20)
			else distance_range2:SetWidth(rangeFlameThrowing20 * height_value)
					distance_number:SetText(textFlameThrowing20)
		end
end
---------------------------------------------------------
--10	 MAGE
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range10 * height_value)
					distance_number:SetText(text10)
			else distance_range2:SetWidth(range10 * height_value)
					distance_number:SetText(text10)
		end
end
---------------------------------------------------------					
--05 	MAGE
--if (CheckInteractDistance("target",1)) and (UnitIsFriend("player", "target")==nil)
--			then distance_range2:SetHeight(range05)
--					distance_number:SetText(text05)
--end
end
---------------------------------------------------------------------------------------------------------------------------------
--DRUID RANGE_2
if (UnitClass("player")==DISTANCE_DRUID)  then

--oor	 DRUID
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil)
	then 	
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(textooR)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(textooR)
		end
end
---------------------------------------------------------
--30  	DRUID
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeNaturesReach30 * height_value)
					distance_number:SetText(textNaturesReach30)
			else distance_range2:SetWidth(rangeNaturesReach30 * height_value)
					distance_number:SetText(textNaturesReach30)
		end
end
---------------------------------------------------------
--25 	 DRUID
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range25 * height_value)
					distance_number:SetText(text25)
			else distance_range2:SetWidth(range25 * height_value)
					distance_number:SetText(text25)
		end
end
---------------------------------------------------------
--10	 DRUID
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range10 * height_value)
					distance_number:SetText(text10)
			else distance_range2:SetWidth(range10 * height_value)
					distance_number:SetText(text10)
		end
end
---------------------------------------------------------
--05	DRUID
if (IsActionInRange(yard05)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range05 * height_value)
					distance_number:SetText(text05)
			else distance_range2:SetWidth(range05 * height_value)
					distance_number:SetText(text05)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--PALADIN RANGE_2
if (UnitClass("player")==DISTANCE_PALADIN)  then

--oor	PALADIN
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(textooR)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(textooR)
		end
end
---------------------------------------------------------					
--30   PALADIN
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range30 * height_value)
					distance_number:SetText(text30)
			else distance_range2:SetWidth(range30 * height_value)
					distance_number:SetText(text30)
		end
end
---------------------------------------------------------
--25 	 PALADIN 
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range25 * height_value)
					distance_number:SetText(text25)
			else distance_range2:SetWidth(range25 * height_value)
					distance_number:SetText(text25)
		end
end
---------------------------------------------------------
--20 	 PALADIN 
if  (IsActionInRange(yard20)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range20 * height_value)
					distance_number:SetText(text20)
			else distance_range2:SetWidth(range20 * height_value)
					distance_number:SetText(text20)
		end
end
---------------------------------------------------------
--10	PALADIN 
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range10 * height_value)
					distance_number:SetText(text10)
			else distance_range2:SetWidth(range10 * height_value)
					distance_number:SetText(text10)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--PRIEST RANGE_2
if (UnitClass("player")==DISTANCE_PRIEST)  then

--oor	PRIEST
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(textooR)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(textooR)
		end
end
---------------------------------------------------------					
--40   PRIEST
if  (IsActionInRange(yard40)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(text40)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(text40)
		end
end
---------------------------------------------------------
--30   PRIEST
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range30 * height_value)
					distance_number:SetText(text30)
			else distance_range2:SetWidth(range30 * height_value)
					distance_number:SetText(text30)
		end
end

--30   PRIEST HOLY
if  (IsActionInRange(holy_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeHolyReach30 * height_value)
					distance_number:SetText(textHolyReach30)
			else distance_range2:SetWidth(rangeHolyReach30 * height_value)
					distance_number:SetText(textHolyReach30)
		end
end

--30   PRIEST SHADOW
if  (IsActionInRange(shadow_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeShadowReach30 * height_value)
					distance_number:SetText(textShadowReach30)
			else distance_range2:SetWidth(rangeShadowReach30 * height_value)
					distance_number:SetText(textShadowReach30)
		end
end
---------------------------------------------------------
--25 	 PRIEST 
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range25 * height_value)
					distance_number:SetText(text25)
			else distance_range2:SetWidth(range25 * height_value)
					distance_number:SetText(text25)
		end
end
---------------------------------------------------------
--20 	 PRIEST 
if  (IsActionInRange(yard20)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range20 * height_value)
					distance_number:SetText(text20)
			else distance_range2:SetWidth(range20 * height_value)
					distance_number:SetText(text20)
		end
end
---------------------------------------------------------
--10	PRIEST 
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range10 * height_value)
					distance_number:SetText(text10)
			else distance_range2:SetWidth(range10 * height_value)
					distance_number:SetText(text10)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--WARLOCK RANGE_2
if (UnitClass("player")==DISTANCE_WARLOCK)  then

--oor	WARLOCK
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(textooR)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(textooR)
		end
end
---------------------------------------------------------
--30   WARLOCK	GRIM
if  (IsActionInRange(grim_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeGrimReach30 * height_value)
					distance_number:SetText(textGrimReach30)
			else distance_range2:SetWidth(rangeGrimReach30 * height_value)
					distance_number:SetText(textGrimReach30)
		end
end

--30   WARLOCK	DESTRUCTION
if  (IsActionInRange(destruction_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeDestructiveReach30 * height_value)
					distance_number:SetText(textDestructiveReach30)
			else distance_range2:SetWidth(rangeDestructiveReach30 * height_value)
					distance_number:SetText(textDestructiveReach30)
		end
end
---------------------------------------------------------
--25 	 WARLOCK 
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range25 * height_value)
					distance_number:SetText(text25)
			else distance_range2:SetWidth(range25 * height_value)
					distance_number:SetText(text25)
		end
end
---------------------------------------------------------
--20 	 WARLOCK GRIM
if  (IsActionInRange(grim_yard20)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(rangeGrimReach20 * height_value)
					distance_number:SetText(textGrimReach20)
			else distance_range2:SetWidth(rangeGrimReach20 * height_value)
					distance_number:SetText(textGrimReach20)
		end
end
---------------------------------------------------------
--10	WARLOCK 
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range10 * height_value)
					distance_number:SetText(text10)
			else distance_range2:SetWidth(range10 * height_value)
					distance_number:SetText(text10)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
-- WARRIOR RANGE_2
if (UnitClass("player")==DISTANCE_WARRIOR)  then

--oor WARRIOR
if (IsActionInRange(yard30)==0) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(textooR)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(textooR)
		end
end
---------------------------------------------------------
--30 WARRIOR
if (IsActionInRange(yard30)==1) and (IsActionInRange(yard10)==0) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range30 * height_value)
					distance_number:SetText(text30)
			else distance_range2:SetWidth(range30 * height_value)
					distance_number:SetText(text30)
		end
end
---------------------------------------------------------
--25 WARRIOR
if (IsActionInRange(yard25)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range25 * height_value)
					distance_number:SetText(text25)
			else distance_range2:SetWidth(range25 * height_value)
					distance_number:SetText(text25)
		end
end
---------------------------------------------------------
--10 WARRIOR
if (IsActionInRange(yard10)==1) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range10 * height_value)
					distance_number:SetText(text10)
			else distance_range2:SetWidth(range10 * height_value)
					distance_number:SetText(text10)
		end
end
---------------------------------------------------------
--08 WARRIOR
if (IsActionInRange(yard10)==1) and (IsActionInRange(yard30)==0) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range08 * height_value)
					distance_number:SetText(text08)
			else distance_range2:SetWidth(range08 * height_value)
					distance_number:SetText(text08)
		end
end
---------------------------------------------------------
--05 WARRIOR
if (IsActionInRange(yard05)==1)  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range05 * height_value)
					distance_number:SetText(text05)
			else distance_range2:SetWidth(range05 * height_value)
					distance_number:SetText(text05)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--ROGUE RANGE_2
if (UnitClass("player")==DISTANCE_ROGUE)  then

--oor ROGUE
if (IsActionInRange(yard30)==0) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range41 * height_value)
					distance_number:SetText(textooR)
			else distance_range2:SetWidth(range41 * height_value)
					distance_number:SetText(textooR)
		end
end
---------------------------------------------------------
--30 ROGUE
if (IsActionInRange(yard30)==1) 
and (IsActionInRange(yard10)==0) 
and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range30 * height_value)
					distance_number:SetText(text30)
			else distance_range2:SetWidth(range30 * height_value)
					distance_number:SetText(text30)
		end
end
---------------------------------------------------------
--25 ROGUE
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range25 * height_value)
					distance_number:SetText(text25)
			else distance_range2:SetWidth(range25 * height_value)
					distance_number:SetText(text25)
		end
end
---------------------------------------------------------
--10 ROGUE
if (IsActionInRange(yard10)==1) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range10 * height_value)
					distance_number:SetText(text10)
			else distance_range2:SetWidth(range10 * height_value)
					distance_number:SetText(text10)
		end
end
---------------------------------------------------------
--08 ROGUE
if (IsActionInRange(yard10)==1) 
and (IsActionInRange(yard30)==0) 
and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range08 * height_value)
					distance_number:SetText(text08)
			else distance_range2:SetWidth(range08 * height_value)
					distance_number:SetText(text08)
		end
end
---------------------------------------------------------
--05 ROGUE
if (IsActionInRange(yard05)==1)  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range2:SetHeight(range05 * height_value)
					distance_number:SetText(text05)
			else distance_range2:SetWidth(range05 * height_value)
					distance_number:SetText(text05)
		end
end
end

distance_frame.TimeSinceLastUpdate = 0;

end
end
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--OnUpdate		range RED
function distance_range3_OnUpdate(arg1)

 if distance_layout==false 
	then 
		distance_range_color3:SetTexture(distance_bar_texture_h)
		distance_range_color3:SetVertexColor(barcolor.b3_color_h_r, barcolor.b3_color_h_g, barcolor.b3_color_h_b);
		distance_color_bar3:SetTexture(distance_bar_texture_w) 
		distance_color_bar3:SetVertexColor(barcolor.b3_color_w_r, barcolor.b3_color_w_g, barcolor.b3_color_w_b);
	else
		distance_range_color3:SetTexture(distance_bar_texture_w) 
		distance_range_color3:SetVertexColor(barcolor.b3_color_w_r, barcolor.b3_color_w_g, barcolor.b3_color_w_b);
		distance_color_bar3:SetTexture(distance_bar_texture_w) 
		distance_color_bar3:SetVertexColor(barcolor.b3_color_w_r, barcolor.b3_color_w_g, barcolor.b3_color_w_b);
end
 
distance_frame.TimeSinceLastUpdate = distance_frame.TimeSinceLastUpdate + arg1; 	
if (distance_frame.TimeSinceLastUpdate > distance_frame_UpdateInterval) then
---------------------------------------------------------------------------------------------------------------------------------
--HUNTER_RANGE_3
if (UnitClass("player")==DISTANCE_HUNTER) then
--oor	HUNTER
if (IsActionInRange(yard41)==0)  and  (IsActionInRange(yard21)==0) and (UnitIsFriend("player", "target")==nil) 
	then 
		if (distance_layout==false) 
			then distance_range3:SetHeight(rangeHawkEye * height_value)
			else distance_range3:SetWidth(rangeHawkEye * height_value)
		end
end
---------------------------------------------------------
--41	HUNTER 
if  (IsActionInRange(yard41)==1) and (UnitIsFriend("player", "target")==nil) 
	then
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range30 * height_value)
			else distance_range3:SetWidth(range30 * height_value)
		end
end
---------------------------------------------------------
--30 HUNTER
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--25	HUNTER
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range21 * height_value)
			else distance_range3:SetWidth(range21 * height_value)
		end
end
---------------------------------------------------------
--21 	HUNTER 
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range08 * height_value)
			else distance_range3:SetWidth(range08 * height_value)
		end
end
---------------------------------------------------------
--08	HUNTER
if (IsActionInRange(yard41)==0) and  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range05 * height_value)
			else distance_range3:SetWidth(range05 * height_value)
		end
end
---------------------------------------------------------
--05	HUNTER
if (IsActionInRange(yard05)==1) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range00 * height_value)
			else distance_range3:SetWidth(range00 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--SHAMAN RANGE_3	
if (UnitClass("player")==DISTANCE_SHAMAN) then

--oor SHAMAN 
if (UnitIsVisible("target"))
	then 
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range41 * height_value)
			else distance_range3:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--41	 SHAMAN ENEMY
if  (IsActionInRange(yard41)==1) and (UnitIsFriend("player", "target")==nil)
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(rangeStormReach * height_value)
			else distance_range3:SetWidth(rangeStormReach * height_value)
		end
end

--41 	SHAMAN  FRIEND
if  (IsActionInRange(friendyard40)==1) and (UnitIsFriend("player", "target")==1)
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range30 * height_value)
			else distance_range3:SetWidth(range30 * height_value)
		end
end

---------------------------------------------------------			
--30 SHAMAN  ENEMY
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil)
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end

--30   SHAMAN FRIEND
if  (IsActionInRange(friendyard30)==1) and (UnitIsFriend("player", "target")==1)
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--25	SHAMAN 
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil)
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range20 * height_value)
			else distance_range3:SetWidth(range20 * height_value)
		end
end	

--25	SHAMAN FRIEND
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==1)
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range10 * height_value)
			else distance_range3:SetWidth(range10 * height_value)
		end
end	
---------------------------------------------------------
--21 	SHAMAN
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil)
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range10 * height_value)
			else distance_range3:SetWidth(range10 * height_value)
		end
end	
---------------------------------------------------------			
--10	SHAMAN ENEMY
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil)
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range05 * height_value)
			else distance_range3:SetWidth(range05 * height_value)
		end
end	

--10	SHAMAN FRIEND
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==1)
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range00 * height_value)
			else distance_range3:SetWidth(range00 * height_value)
		end
end	
---------------------------------------------------------
--05	 SHAMAN	ENEMY
if (IsActionInRange(yard05)==1) and (UnitIsFriend("player", "target")==nil)
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range00 * height_value)
			else distance_range3:SetWidth(range00 * height_value)
		end
end	

--05 	SHAMAN	FRIEND
--if (CheckInteractDistance("target",1)) and (UnitIsFriend("player", "target")==1)
--			then distance_range3:SetHeight(range00)
--end
end
---------------------------------------------------------------------------------------------------------------------------------
--MAGE RANGE_3
if (UnitClass("player")==DISTANCE_MAGE)  then

--oor MAGE
if (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range41 * height_value)
			else distance_range3:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--41	 MAGE
if  (IsActionInRange(yard41)==1) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(rangeFlameThrowing35 * height_value)	
			else distance_range3:SetWidth(rangeFlameThrowing35 * height_value)	
		end
end
---------------------------------------------------------
--35 	 MAGE FIRE
if  (IsActionInRange(yard35)==1) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(rangeFlameThrowing30 * height_value)	
			else distance_range3:SetWidth(rangeFlameThrowing30 * height_value)	
		end
end

--35 	 MAGE FROST
if  (IsActionInRange(yard35)==1) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(rangeArcticReach30 * height_value)	
			else distance_range3:SetWidth(rangeArcticReach30 * height_value)	
		end	
end
---------------------------------------------------------
--30  MAGE FIRE
if  (IsActionInRange(fire_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(rangeFlameThrowing20 * height_value)
			else distance_range3:SetWidth(rangeFlameThrowing20 * height_value)
		end
end

--30  MAGE FROST
if  (IsActionInRange(frost_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(rangeFlameThrowing20 * height_value)
			else distance_range3:SetWidth(rangeFlameThrowing20 * height_value)
		end
end
---------------------------------------------------------
--21 	MAGE
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then	distance_range3:SetHeight(range10 * height_value)
			else distance_range3:SetWidth(range10 * height_value)
		end
end
---------------------------------------------------------
--10	 MAGE
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil) 
	then	
		if (distance_layout==false) 
			then distance_range3:SetHeight(range00 * height_value)
			else distance_range3:SetWidth(range00 * height_value)
		end
end
---------------------------------------------------------
--05 	MAGE
--if (CheckInteractDistance("target",1)) and (UnitIsFriend("player", "target")==nil) 
--			then distance_range3:SetHeight(range00)
--end
end
---------------------------------------------------------------------------------------------------------------------------------
--DRUID RANGE_3
if (UnitClass("player")==DISTANCE_DRUID) then

--oor	 DRUID
if  (UnitIsVisible("target"))  and (UnitIsFriend("player", "target")==nil)  
	then 
		if (distance_layout==false) 
			then distance_range3:SetHeight(range41 * height_value)
			else distance_range3:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30  	DRUID
if  (IsActionInRange(yard30)==1)  and (UnitIsFriend("player", "target")==nil)  
	then	
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--25 	 DRUID
if (CheckInteractDistance("target",4))  and (UnitIsFriend("player", "target")==nil)  
	then	
		if (distance_layout==false) 
			then distance_range3:SetHeight(range10 * height_value)
			else distance_range3:SetWidth(range10 * height_value)
		end
end
---------------------------------------------------------
--10	 DRUID
if (CheckInteractDistance("target",3))  and (UnitIsFriend("player", "target")==nil)  
	then	
		if (distance_layout==false) 
			then distance_range3:SetHeight(range05 * height_value)
			else distance_range3:SetWidth(range05 * height_value)
		end
end
---------------------------------------------------------
--05	DRUID
if (IsActionInRange(yard05)==1)  and (UnitIsFriend("player", "target")==nil)  
	then	
		if (distance_layout==false) 
			then distance_range3:SetHeight(range00 * height_value)
			else distance_range3:SetWidth(range00 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--PALADIN RANGE_3
if (UnitClass("player")==DISTANCE_PALADIN)  then

--oor	PALADIN
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range41 * height_value)
			else distance_range3:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------					
--40 PALADIN FRIEND
if  (IsActionInRange(friendyard40)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range30 * height_value)
			else distance_range3:SetWidth(range30 * height_value)
		end
end
---------------------------------------------------------
--30   PALADIN ENEMY
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end

--30   PALADIN FRIEND
if  (IsActionInRange(friendyard30)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--25 	 PALADIN
if (CheckInteractDistance("target",4))
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range20 * height_value)
			else distance_range3:SetWidth(range20 * height_value)
		end
end
---------------------------------------------------------
--20 	 PALADIN ENEMY
if  (IsActionInRange(yard20)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range10 * height_value)
			else distance_range3:SetWidth(range10 * height_value)
		end
end

--20 	 PALADIN FRIEND
if  (IsActionInRange(friendyard20)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range10 * height_value)
			else distance_range3:SetWidth(range10 * height_value)
		end
end
---------------------------------------------------------
--10	PALADIN ENEMY
if (CheckInteractDistance("target",3))
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range00 * height_value)
			else distance_range3:SetWidth(range00 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--PRIEST RANGE_3
if (UnitClass("player")==DISTANCE_PRIEST)  then

--oor	PRIEST
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range41 * height_value)
			else distance_range3:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------					
--40   PRIEST ENEMY
if  (IsActionInRange(yard40)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range30 * height_value)
			else distance_range3:SetWidth(range30 * height_value)
		end
end

--40   PRIEST ENEMY HOLY
if  (IsActionInRange(yard40)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(rangeHolyReach30 * height_value)
			else distance_range3:SetWidth(rangeHolyReach30 * height_value)
		end
end

--40   PRIEST ENEMY SHADOW
if  (IsActionInRange(yard40)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(rangeHolyReach30 * height_value)
			else distance_range3:SetWidth(rangeHolyReach30 * height_value)
		end
end

--40   PRIEST FRIEND
if  (IsActionInRange(friendyard40)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range30 * height_value)
			else distance_range3:SetWidth(range30 * height_value)
		end
end
---------------------------------------------------------
--30   PRIEST ENEMY
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end

--30   PRIEST HOLY
if  (IsActionInRange(holy_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end

--30   PRIEST SHADOW
if  (IsActionInRange(shadow_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end

--30   PRIEST FRIEND
if  (IsActionInRange(friendyard30)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--25 	 PRIEST
if (CheckInteractDistance("target",4))
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range20 * height_value)
			else distance_range3:SetWidth(range20 * height_value)
		end
end
---------------------------------------------------------
--20 	 PRIEST ENEMY
if  (IsActionInRange(yard20)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range10 * height_value)
			else distance_range3:SetWidth(range10 * height_value) 
		end
end
---------------------------------------------------------
--10	PRIEST
if (CheckInteractDistance("target",3))
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range00 * height_value)
			else distance_range3:SetWidth(range00 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--WARLOCK RANGE_3
if (UnitClass("player")==DISTANCE_WARLOCK)  then

--oor	WARLOCK
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range41 * height_value)
			else distance_range3:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30   WARLOCK	GRIM
if  (IsActionInRange(grim_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end

--30   WARLOCK	DESTRUCTION
if  (IsActionInRange(destruction_yard30)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--25 	 WARLOCK 
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(rangeGrimReach20 * height_value)
			else distance_range3:SetWidth(rangeGrimReach20 * height_value)
		end
end
---------------------------------------------------------
--20 	 WARLOCK GRIM
if  (IsActionInRange(grim_yard20)==1) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range10 * height_value)
			else distance_range3:SetWidth(range10 * height_value)
		end
end
---------------------------------------------------------
--10	WARLOCK 
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==nil) 
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range00 * height_value)
			else distance_range3:SetWidth(range00 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
-- WARRIOR RANGE_3
if (UnitClass("player")==DISTANCE_WARRIOR)  then

--oor WARRIOR
if (IsActionInRange(yard30)==0) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range41 * height_value)
			else distance_range3:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30 WARRIOR
if (IsActionInRange(yard30)==1) and (IsActionInRange(yard10)==0) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--25 WARRIOR
if (IsActionInRange(yard25)==1) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range10 * height_value)
			else distance_range3:SetWidth(range10 * height_value)
		end
end
---------------------------------------------------------
--10 WARRIOR
if (IsActionInRange(yard10)==1) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range08 * height_value)
			else distance_range3:SetWidth(range08 * height_value)
		end
end
---------------------------------------------------------
--08 WARRIOR
if (IsActionInRange(yard10)==1) and (IsActionInRange(yard30)==0) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range05 * height_value)
			else distance_range3:SetWidth(range05 * height_value)
		end
end
---------------------------------------------------------
--05 WARRIOR
if (IsActionInRange(yard05)==1)  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range00 * height_value)
			else distance_range3:SetWidth(range00 * height_value)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--ROGUE RANGE_3
if (UnitClass("player")==DISTANCE_ROGUE)  then

--oor ROGUE
if (IsActionInRange(yard30)==0) 
and (IsActionInRange(yard10)==0) or (IsActionInRange(yard10)==nil) 
and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range41 * height_value)
			else distance_range3:SetWidth(range41 * height_value)
		end
end
---------------------------------------------------------
--30 ROGUE
if (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range25 * height_value)
			else distance_range3:SetWidth(range25 * height_value)
		end
end
---------------------------------------------------------
--25 ROGUE
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range10 * height_value)
			else distance_range3:SetWidth(range10 * height_value)
		end
end
---------------------------------------------------------
--10 ROGUE
if (IsActionInRange(yard10)==1) and (UnitIsFriend("player", "target")==nil)
 	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range08 * height_value)
			else distance_range3:SetWidth(range08 * height_value)
		end
end
---------------------------------------------------------
--08 ROGUE
if (IsActionInRange(yard30)==0) 
and (IsActionInRange(yard10)==1) 
and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range05 * height_value)
			else distance_range3:SetWidth(range05 * height_value)
		end
end
---------------------------------------------------------
--05 ROGUE
if (IsActionInRange(yard05)==1)  and (UnitIsFriend("player", "target")==nil)
	then		
		if (distance_layout==false) 
			then distance_range3:SetHeight(range00 * height_value)
			else distance_range3:SetWidth(range00 * height_value)
		end
end
end

distance_frame.TimeSinceLastUpdate = 0;

end
end	
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
--OnUpdate 	range GREEN
function distance_range4_OnUpdate(arg1)

if distance_layout==false
	then 
		distance_range_color4:SetTexture(distance_bar_texture_h) 
		distance_range_color4:SetVertexColor(barcolor.b4_color_h_r, barcolor.b4_color_h_g, barcolor.b4_color_h_b);
		distance_color_bar4:SetTexture(distance_bar_texture_w) 
		distance_color_bar4:SetVertexColor(barcolor.b4_color_w_r, barcolor.b4_color_w_g, barcolor.b4_color_w_b);
	else
		distance_range_color4:SetTexture(distance_bar_texture_w) 
		distance_range_color4:SetVertexColor(barcolor.b4_color_w_r, barcolor.b4_color_w_g, barcolor.b4_color_w_b);
		distance_color_bar4:SetTexture(distance_bar_texture_w) 
		distance_color_bar4:SetVertexColor(barcolor.b4_color_w_r, barcolor.b4_color_w_g, barcolor.b4_color_w_b);
end

distance_frame.TimeSinceLastUpdate = distance_frame.TimeSinceLastUpdate + arg1; 	
if (distance_frame.TimeSinceLastUpdate > distance_frame_UpdateInterval) then
---------------------------------------------------------------------------------------------------------------------------------
--HUNTER RANGE_4
if (UnitClass("player")==DISTANCE_HUNTER) then

--oor  HUNTER
if (IsActionInRange(yard41)==0) and (IsActionInRange(yard21)==0) and (UnitIsFriend("player", "target")==1) 
 	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range41 * height_value)
					distance_number1:SetText(textooR)
			else distance_range4:SetWidth(range41 * height_value)
					distance_number1:SetText(textooR)
		end
end
---------------------------------------------------------
--41 	HUNTER
if  (IsActionInRange(yard41)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(rangeHawkEye * height_value)
					distance_number1:SetText(textHawkEye)
			else distance_range4:SetWidth(rangeHawkEye * height_value)
					distance_number1:SetText(textHawkEye)
		end
end
---------------------------------------------------------
--30  HUNTER 
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range30 * height_value)
					distance_number1:SetText(text30)
			else distance_range4:SetWidth(range30 * height_value)
					distance_number1:SetText(text30)
		end
end
---------------------------------------------------------
--25 	HUNTER 
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range25 * height_value)
					distance_number1:SetText(text25)
			else distance_range4:SetWidth(range25 * height_value)
					distance_number1:SetText(text25)
		end
end
---------------------------------------------------------
--21 	HUNTER
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range21 * height_value)
					distance_number1:SetText(text21)
			else distance_range4:SetWidth(range21 * height_value)
					distance_number1:SetText(text21)
		end
end
---------------------------------------------------------
--08 	HUNTER
if (IsActionInRange(yard41)==0) and (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range08 * height_value)
					distance_number1:SetText(text08)
			else distance_range4:SetWidth(range08 * height_value)
					distance_number1:SetText(text08) 
		end
end
---------------------------------------------------------
--05	HUNTER 
if (IsActionInRange(yard05)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range05 * height_value)
					distance_number1:SetText(text05)
			else distance_range4:SetWidth(range05 * height_value)
					distance_number1:SetText(text05)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--SHAMAN RANGE_4
if (UnitClass("player")==DISTANCE_SHAMAN) then

--oor	SHAMAN
if  (UnitIsVisible("target")==1)  and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range41 * height_value)
					distance_number1:SetText(textooR)
			else distance_range4:SetWidth(range41 * height_value)
					distance_number1:SetText(textooR)
		end
end
---------------------------------------------------------
--41 	SHAMAN
if  (IsActionInRange(friendyard40)==1)  and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range41 * height_value)
					distance_number1:SetText(text41)
			else distance_range4:SetWidth(range41 * height_value)
					distance_number1:SetText(text41)
		end
end
---------------------------------------------------------					
--30   SHAMAN
if  (IsActionInRange(friendyard30)==1)  and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range30 * height_value)
					distance_number1:SetText(text30)
			else distance_range4:SetWidth(range30 * height_value)
					distance_number1:SetText(text30)
		end
end
---------------------------------------------------------
--25 	 SHAMAN 
if (CheckInteractDistance("target",4)==1)  and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range25 * height_value)
					distance_number1:SetText(text25)
			else distance_range4:SetWidth(range25 * height_value)
					distance_number1:SetText(text25)
		end
end
---------------------------------------------------------
--10	SHAMAN 
if (CheckInteractDistance("target",3)==1)  and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range10 * height_value)
					distance_number1:SetText(text10)
			else distance_range4:SetWidth(range10 * height_value)
					distance_number1:SetText(text10)
		end
end
---------------------------------------------------------
--05 	SHAMAN
--if (CheckInteractDistance("target",1)==1)  and (UnitIsFriend("player", "target")==1) 
--			then distance_range4:SetHeight(range05)
--					distance_number1:SetText(text05)
--end
end
---------------------------------------------------------------------------------------------------------------------------------
--MAGE RANGE_4
if (UnitClass("player")==DISTANCE_MAGE) then

--oor	 MAGE
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==1)
	then 	
		if (distance_layout==false) 
			then distance_range4:SetHeight(range41 * height_value)
					distance_number1:SetText(textooR)
			else distance_range4:SetWidth(range41 * height_value)
					distance_number1:SetText(textooR)
		end
end
---------------------------------------------------------
--41 	MAGE
if  (IsActionInRange(yard41)==1) and (UnitIsFriend("player", "target")==1)
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range41 * height_value)
					distance_number1:SetText(text41)
			else distance_range4:SetWidth(range41 * height_value)
					distance_number1:SetText(text41)
		end
end
---------------------------------------------------------
--35 	 MAGE FIRE
if  (IsActionInRange(yard35)==1) and (UnitIsFriend("player", "target")==1)
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(rangeFlameThrowing35 * height_value)
					distance_number1:SetText(textFlameThrowing35)
			else distance_range4:SetWidth(rangeFlameThrowing35 * height_value)
					distance_number1:SetText(textFlameThrowing35)
		end
end
---------------------------------------------------------
--30  MAGE FIRE
if  (IsActionInRange(fire_yard30)==1) and (UnitIsFriend("player", "target")==1)
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(rangeFlameThrowing30 * height_value)	
					distance_number1:SetText(textFlameThrowing30)
			else distance_range4:SetWidth(rangeFlameThrowing30 * height_value)	
					distance_number1:SetText(textFlameThrowing30)
		end
end

--30  MAGE FROST
if  (IsActionInRange(frost_yard30)==1) and (UnitIsFriend("player", "target")==1)
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(rangeArcticReach30 * height_value)
					distance_number1:SetText(textArcticReach30)
			else distance_range4:SetWidth(rangeArcticReach30 * height_value)
					distance_number1:SetText(textArcticReach30) 
		end
end
---------------------------------------------------------
--21 	 MAGE
if  (IsActionInRange(yard21)==1) and (UnitIsFriend("player", "target")==1)
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(rangeFlameThrowing20 * height_value)
					distance_number1:SetText(textFlameThrowing20)
			else distance_range4:SetWidth(rangeFlameThrowing20 * height_value)
					distance_number1:SetText(textFlameThrowing20)
		end
end
---------------------------------------------------------
--10	 MAGE
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==1)
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range10 * height_value)
					distance_number1:SetText(text10)
			else distance_range4:SetWidth(range10 * height_value)
					distance_number1:SetText(text10)
		end
end
---------------------------------------------------------					
--05 	MAGE
--if (CheckInteractDistance("target",1)) and (UnitIsFriend("player", "target")==1)
--			then distance_range4:SetHeight(range05)
--					distance_number1:SetText(text05)
--end
end
---------------------------------------------------------------------------------------------------------------------------------
--DRUID RANGE_4
if (UnitClass("player")==DISTANCE_DRUID) then

--oor	 DRUID
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==1)  
	then 	
		if (distance_layout==false) 
			then distance_range4:SetHeight(range41 * height_value)
					distance_number1:SetText(textooR)
			else distance_range4:SetWidth(range41 * height_value)
					distance_number1:SetText(textooR)
		end
end
---------------------------------------------------------
--30  	DRUID
if  (IsActionInRange(yard30)==1) and (UnitIsFriend("player", "target")==1)  
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(rangeNaturesReach30 * height_value)
					distance_number1:SetText(textNaturesReach30)
			else distance_range4:SetWidth(rangeNaturesReach30 * height_value)
					distance_number1:SetText(textNaturesReach30)
		end
end
---------------------------------------------------------
--25 	 DRUID
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==1)  
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range25 * height_value)
					distance_number1:SetText(text25)
			else distance_range4:SetWidth(range25 * height_value)
					distance_number1:SetText(text25)
		end
end
---------------------------------------------------------
--10	 DRUID
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==1)  
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range10 * height_value)
					distance_number1:SetText(text10)
			else distance_range4:SetWidth(range10 * height_value)
					distance_number1:SetText(text10)
		end
end
---------------------------------------------------------
--05	DRUID
if (IsActionInRange(yard05)==1) and (UnitIsFriend("player", "target")==1)  
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range05 * height_value)
					distance_number1:SetText(text05)
			else distance_range4:SetWidth(range05 * height_value)
					distance_number1:SetText(text05)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--PALADIN RANGE_4
if (UnitClass("player")==DISTANCE_PALADIN)  then

--oor	PALADIN
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range41 * height_value)
					distance_number1:SetText(textooR)
			else distance_range4:SetWidth(range41 * height_value)
					distance_number1:SetText(textooR)
		end
end
---------------------------------------------------------					
--40 PALADIN
if  (IsActionInRange(friendyard40)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range41 * height_value)
					distance_number1:SetText(text40)
			else distance_range4:SetWidth(range41 * height_value)
					distance_number1:SetText(text40)
		end
end
---------------------------------------------------------	
--30   PALADIN
if  (IsActionInRange(friendyard30)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range30 * height_value)
					distance_number1:SetText(text30)
			else distance_range4:SetWidth(range30 * height_value)
					distance_number1:SetText(text30)
		end
end
---------------------------------------------------------
--25 	 PALADIN 
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range25 * height_value)
					distance_number1:SetText(text25)
			else distance_range4:SetWidth(range25 * height_value)
					distance_number1:SetText(text25)
		end
end
---------------------------------------------------------
--20 	 PALADIN 
if  (IsActionInRange(friendyard20)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range20 * height_value)
					distance_number1:SetText(text20)
			else distance_range4:SetWidth(range20 * height_value)
					distance_number1:SetText(text20)
		end
end
---------------------------------------------------------
--10	PALADIN 
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range10 * height_value)
					distance_number1:SetText(text10)
			else distance_range4:SetWidth(range10 * height_value)
					distance_number1:SetText(text10)
		end
end
end
---------------------------------------------------------------------------------------------------------------------------------
--PRIEST RANGE_4
if (UnitClass("player")==DISTANCE_PRIEST)  then

--oor	PRIEST
if  (UnitIsVisible("target")) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range41 * height_value)
					distance_number1:SetText(textooR)
			else distance_range4:SetWidth(range41 * height_value)
					distance_number1:SetText(textooR)
		end
end
---------------------------------------------------------					
--40   PRIEST
if  (IsActionInRange(friendyard40)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range41 * height_value)
					distance_number1:SetText(text40)
			else distance_range4:SetWidth(range41 * height_value)
					distance_number1:SetText(text40)
		end
end
---------------------------------------------------------
--30   PRIEST
if  (IsActionInRange(friendyard30)==1) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range30 * height_value)
					distance_number1:SetText(text30)
			else distance_range4:SetWidth(range30 * height_value)
					distance_number1:SetText(text30)
		end
end
---------------------------------------------------------
--25 	 PRIEST 
if (CheckInteractDistance("target",4)) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range25 * height_value)
					distance_number1:SetText(text25)
			else distance_range4:SetWidth(range25 * height_value)
					distance_number1:SetText(text25)
		end
end
---------------------------------------------------------
--20 	 PRIEST 
--if  (IsActionInRange(yard20)==1) and (UnitIsFriend("player", "target")==1) 
--			then	distance_range4:SetHeight(range20)
--					distance_number1:SetText(text20)
--end
---------------------------------------------------------
--10	PRIEST 
if (CheckInteractDistance("target",3)) and (UnitIsFriend("player", "target")==1) 
	then		
		if (distance_layout==false) 
			then distance_range4:SetHeight(range10 * height_value)
					distance_number1:SetText(text10)
			else distance_range4:SetWidth(range10 * height_value)
					distance_number1:SetText(text10)
		end
end
end

distance_frame.TimeSinceLastUpdate = 0;

end
end

---------------------------------------------------------------------------------------------------------------------------------
function actionspell()
local i=1
 for i=1,120 do t = GetActionTexture(i)
		break
		end 
		 DEFAULT_CHAT_FRAME:AddMessage( i .. '(' .. t.. ')' )
end

function gettalent()
local numTabs = GetNumTalentTabs();
for t=1, numTabs do
    DEFAULT_CHAT_FRAME:AddMessage(GetTalentTabInfo(t)..":");
    local numTalents = GetNumTalents(t);
    for i=1, numTalents do
        nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(t,i);
        DEFAULT_CHAT_FRAME:AddMessage("- "..nameTalent..": "..currRank.."/"..maxRank);
	 end
end
end

function getspells()
for i = 1, 250 do t=GetSpellTexture(i, BOOKTYPE_SPELL)
   if (t and string.find(t,"Ability_ImpalingBolt"))
   then yard41=i
      DEFAULT_CHAT_FRAME:AddMessage(i);
      DEFAULT_CHAT_FRAME:AddMessage(t);
		break 
   end
 end
end

function distance_check()
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Addon: |cFFFF0000Talents checked");	
					distance_talent_check();
					DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00Distance Addon: |cFFFF0000Spells checked");
					distance_spell_check();	
end
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
