PetFeederPlayerButtonBar_Vars = {  FoodLink = nil, FoodText = "", LoyaltyLevel = 0, LoyaltyText = "", XPCurrent = 0, XPNextLevel = 0 }
PetFeederPlayerButtonBar_Config = {Show = 1,	Scale = 1}	
	
Orig_PetFeeder_UpdateQuantities = nil;
Orig_PetFeeder_PopulateFoods = nil
PetFeederButtonBar_PetName = nil;

local MAX_LEVEL = 60

function PetFeederButtonBar_OnLoad()
	if ( UnitClass("player") ~= PETFEEDER_HUNTER ) then
		
		return;
	end
	PetFeederButtonBar:RegisterEvent("UNIT_HAPPINESS");
	PetFeederButtonBar:RegisterEvent("PLAYER_ENTERING_WORLD");
	PetFeederButtonBar:RegisterEvent("BAG_UPDATE");
	PetFeederButtonBar:RegisterEvent("VARIABLES_LOADED");
	PetFeederButtonBar:RegisterEvent("PLAYER_PET_CHANGED");
	PetFeederButtonBar:RegisterEvent("PET_BAR_UPDATE");
	PetFeederButtonBar:RegisterEvent("LOCALPLAYER_PET_RENAMED");
	PetFeederButtonBar:RegisterEvent("UNIT_PET");
	PetFeederButtonBar:RegisterEvent("UNIT_NAME_UPDATE");
	PetFeederButtonBar:RegisterEvent("UNIT_PET_EXPERIENCE");
	if ( PeetFeederPlayer_Config.BarEnabled  ) then
		this:Show();
	end
	Orig_PetFeeder_UpdateQuantities = PetFeeder_UpdateQuantities;
	PetFeeder_UpdateQuantities = PetFeederButtonBar_UpdateQuan;
	Orig_PetFeeder_PopulateFoods = PetFeeder_PopulateFoods;
	PetFeeder_PopulateFoods = PetFeederButtonBar_PopulateFoods;
	
	
end


function PetFeederButtonBar_OnEvent()
	if (event == "PLAYER_ENTERING_WORLD" or event == "VARIABLES_LOADED" ) then
		local _ , playerClass = UnitClass("player");
		if ( playerClass ~= "HUNTER" ) then
			PetFeederButtonBar:Hide();
		else
			if ( PeetFeederPlayer_Config.BarEnabled and PeetFeederPlayer_Config.Enabled ) then
				PetFeederButtonBar:Show();
			end
			
		end
	elseif ( event == "BAG_UPDATE" ) then
			
		PetFeederButtonBar_GetNextFood();
	
	elseif ( event == "UNIT_HAPPINESS" ) then

		PetFeederButtonBar_SetHappiness();
	elseif ( event == "PET_BAR_UPDATE" or event == "PLAYER_PET_CHANGED" or event == "UNIT_PET"  ) then
		if (  not UnitExists("pet") ) then
			PetFeederButtonBar:Hide();
		else
			PetFeederButtonBar_ShowActions()
		end
	elseif ( event == "LOCALPLAYER_PET_RENAMED" or "UNIT_NAME_UPDATE" ) then
		
		if ( not PetFeeder_HasPet() ) then
			return;
		end
		if ( PetFeederButtonBar_PetName ~= UnitName("pet") ) then
			PetFeederButtonBar_PetName = UnitName("pet");
		else
			return;
		end
		PetFeederButtonBar_ShowActions()
	elseif ( event == "UNIT_PET_EXPERIENCE" ) then
		PetFeederButtonBar_SetXPBar();
	end
	
        
end

function PetFeederButtonBar_ShowActions()
	if ( PeetFeederPlayer_Config.BarEnabled ) then
		PetFeederButtonBar:Show();
		PetFeederButtonBar_SetHappiness();
		PetFeederButtonBar_GetNextFood();
	else
		PetFeederButtonBar:Hide();
		PetFeederButton_Food:Hide();
		PetFeederButton_Icon:Hide();
		PetFeederButton_Happiness:Hide();
		PetFeederButton_XPBar:Hide();
		PetFeederButton_LoyaltyBar:Hide();
	end
end

function PetFeederButtonBar_OnClick()
	if (arg1 == "LeftButton") then
		if ( IsShiftKeyDown() ) then
			PetFeeder_Feed();
		end
	else
		if (not IsControlKeyDown()) then
			togglePetFeeder(nil);
		end
		
	end
end

function PetFeederButtonBar_UpdateQuan()
	Orig_PetFeeder_UpdateQuantities();
	PetFeederButtonBar_GetNextFood();
end

function PetFeederButtonBar_PopulateFoods()
	Orig_PetFeeder_PopulateFoods();
	PetFeederButtonBar_GetNextFood();
end
function  PetFeederButtonBar_GetNextFood()
	if ( not PetFeeder_HasPet() or not PeetFeederPlayer_Config.BarEnabled  ) then
		PetFeederButton_Food:Hide();
		
		return;
	end
	if ( not PetFeederPlayer_Foods[PetFeeder_PetName] ) then return; end
	
	PetFeederButtonBar:Show();
	PetFeederButton_Food:Show();
	local count = 0;
	local found = false;
	for index, value in PetFeederPlayer_Foods[PetFeeder_PetName] do
		
		if ( value.quantity and value.quantity > 0 ) then
			if ( PeetFeederPlayer_Config.RequireApproval == 1 and value.foodlikedstate == PETFEEDER_FL_UNKNOWN ) or ( (PeetFeederPlayer_Config.FeedOnlyApproved == 1 and value.foodlikedstate == PETFEEDER_FL_APPROVED) or ( PeetFeederPlayer_Config.FeedOnlyApproved == 0 and value.foodlikedstate > 0 ) )then 
				if ( not found ) then
					local tex = getglobal("PetFeederButton_Food_NormalTexture");
					tex:SetTexture(value.texture);
					found = true;
					PetFeederPlayerButtonBar_Vars.FoodText = value.text;
					PetFeederPlayerButtonBar_Vars.FoodLink = value.id;
				end
				count = count + value.quantity;

			 end
		end
	end
	if ( count == 0 ) then
		PetFeederButton_Food_NormalTexture:SetTexture("");
		PetFeederPlayerButtonBar_Vars.FoodText = "";
		PetFeederPlayerButtonBar_Vars.FoodLink = nil;
		PetFeederButton_FoodText:SetText("");
	else
		PetFeederButton_FoodText:SetText(count);
	end

end



function PetFeederButtonBar_SetHappiness()
	local happiness, damagePercentage, loyaltyRate = GetPetHappiness();
	-- DEFAULT_CHAT_FRAME:AddMessage("PetFeederButtonBar_SetHappiness");
	local hasPetUI, isHunterPet = HasPetUI();
	if ( not happiness or not isHunterPet or not PeetFeederPlayer_Config.BarEnabled  ) then
		PetFeederButton_Happiness:Hide();
		PetFeederButton_XPBar:Hide();
		PetFeederButton_LoyaltyBar:Hide();
		return;	
	end
	-- DEFAULT_CHAT_FRAME:AddMessage("PetFeederButtonBar_SetHappiness Show");
	PetFeederButton_Happiness:Show();
	PetFeederButton_LoyaltyBar:Show();
	if ( happiness == 1 ) then
		PetFeederButton_Happiness_NormalTexture:SetTexCoord(0.375, 0.5625, 0, 0.359375);
	elseif ( happiness == 2 ) then
		PetFeederButton_Happiness_NormalTexture:SetTexCoord(0.1875, 0.375, 0, 0.359375);
	elseif ( happiness == 3 ) then
		PetFeederButton_Happiness_NormalTexture:SetTexCoord(0, 0.1875, 0, 0.359375);
	end
	PetFeederButton_Happiness.tooltip = getglobal("PET_HAPPINESS"..happiness);
	PetFeederButton_Happiness.tooltipDamage = format(PET_DAMAGE_PERCENTAGE, damagePercentage);
	if ( loyaltyRate < 0 ) then
		PetFeederButton_Happiness.tooltipLoyalty = getglobal("LOSING_LOYALTY");
	elseif ( loyaltyRate > 0 ) then
		PetFeederButton_Happiness.tooltipLoyalty = getglobal("GAINING_LOYALTY");
	else
		PetFeederButton_Happiness.tooltipLoyalty = nil;
		UIErrorsFrame:AddMessage(PETFEEDER_PETHUNGERY, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);	
	end
	
	
	PetFeederButton_Icon_NormalTexture:SetTexture(GetPetIcon());
	PetFeederButton_IconText:SetText(PetFeederButtonBar_GetLevel());
	PetFeederButton_Icon:Show();
	PetFeederButtonBar_SetXPBar();
	PetFeederButtonBar_SetLoyaltyBar();
end

function PetFeederButtonBar_GetLevel()
	local lvl = UnitLevel("pet");
	return ( lvl == MAX_LEVEL ) and "" or lvl;
end	

function PetFeederButtonBar_SetXPBar()
	if ( UnitLevel("pet") < MAX_LEVEL and PetFeederButton_Happiness:IsVisible() ) then
		local currXP, nextXP = GetPetExperience();
		PetFeederButton_XPBar:SetMinMaxValues(min(0, currXP),nextXP);
		PetFeederButton_XPBar:SetValue(currXP);
		PetFeederButton_XPBar:Show();
	else
		PetFeederButton_XPBar:Hide();
	end
	
end

function PetFeederButtonBar_SetLoyaltyBar()
	local loyalty = GetPetLoyalty();
	if ( loyalty ) then
		PetFeederPlayerButtonBar_Vars.LoyaltyText = loyalty;
		local _,_,llvl = string.find(loyalty, "(%d)");
		if ( tonumber(llvl) < 6 ) then
			local currXP, nextXP = GetPetExperience();
			PetFeederButton_LoyaltyBar:SetMinMaxValues(0,6);
			PetFeederButton_LoyaltyBar:SetValue(tonumber(llvl));
			PetFeederButton_LoyaltyBar:Show();
		else
		
			PetFeederButton_LoyaltyBar:Hide();
		end
	else
		PetFeederPlayerButtonBar_Vars.LoyaltyText = nil;
	end
	
end	

function PetFeederButtonBar_FoodToolTip()
	if ( PetFeederPlayerButtonBar_Vars.FoodLink ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetHyperlink("item:"..PetFeederPlayerButtonBar_Vars.FoodLink);
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine("("..PETFEEDER_CLICKFEEDPET..")",0,1,0);
		GameTooltip:Show();
	end
end

function PetFeederButtonBar_HappinessToolTip()
	if ( this.tooltip ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText(this.tooltip);
		if ( this.tooltipDamage ) then
			GameTooltip:AddLine(this.tooltipDamage, "", 1, 1, 1);
		end
		if ( this.tooltipLoyalty ) then
			GameTooltip:AddLine(this.tooltipLoyalty, "", 1, 1, 1);
		end
		GameTooltip:AddLine(PetFeederPlayerButtonBar_Vars.LoyaltyText,0,1,1)
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine("("..PETFEEDER_CLICKOPENOPTIONS..")",0,1,0);
		GameTooltip:Show();
	end
end

 
 
 function PetFeederButtonBar_IconToolTip()
 	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetUnit("pet");
	if ( UnitLevel("pet") < MAX_LEVEL ) then
		local currXP, nextXP = GetPetExperience();
		GameTooltip:AddDoubleLine("Current XP:",currXP,0,1,1,1,1,1)
		GameTooltip:AddDoubleLine("Next Level XP:",nextXP,0,1,1,1,1,1)
	end
	GameTooltip:AddLine(" ");
	GameTooltip:AddLine("("..PETFEEDER_CLICKMOVEBAR..")",0,1,0);
	GameTooltip:Show();
end

function PetFeeder_PFB_Enabled_CheckBt_Update(whatValue)
	PeetFeederPlayer_Config.BarEnabled = whatValue;
	PetFeederButtonBar_ShowActions();
end
