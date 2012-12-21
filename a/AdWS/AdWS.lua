AdWSSettings = {DamageBonus = 1.3, ACPreset= "No Reduction", AClass=0, ACReduction=0, cAP=0};
AdWSWarrior = {Build = "arms", Crit = 2.2, OffHand = 0.5, THSpec = 1, Sspec = "on"};
AdWSRogue = {Lethality = 2.3, ImpEvi = 1.15, OffHand = 0.75, Aggression = 1.06, Opportunity = 1.20};


local AdWS_Hook = {
	AuctionFrame_LoadUI = AuctionFrame_LoadUI,

	SetItemRef = SetItemRef,
	ContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter,
	ContainerFrame_Update = ContainerFrame_Update,
	AuctionFrameItem_OnEnter = nil,

	SetInventoryItem = GameTooltip.SetInventoryItem,
	SetLootItem = GameTooltip.SetLootItem,
	
	SetMerchantItem = GameTooltip.SetMerchantItem,
	
	SetMerchantCompareItem1 = ShoppingTooltip1.SetMerchantCompareItem,
	SetAuctionCompareItem1 = ShoppingTooltip1.SetAuctionCompareItem,

	SetMerchantCompareItem2 = ShoppingTooltip2.SetMerchantCompareItem,
	SetAuctionCompareItem2 = ShoppingTooltip2.SetAuctionCompareItem,
};

--===================================================================================================================--

function AdWS_OnLoad()
	SlashCmdList[ "ADWS" ] = AdWS_SlashHandler;
	SLASH_ADWS1 = "/adws";
	ChatFrame1:AddMessage( "Advanced Weapon Stats loaded. Type /adws for more information." ); 
end

--===================================================================================================================--

function AdWS_GetCmd(msg)
 	if msg then
 		local a,b,c=strfind(msg, "(%S+)"); --contiguous string of non-space characters
 		if a then return c, strsub(msg, b+2); else	return ""; end
 	end
end

function AdWS_GetArgument(msg)
 	if msg then
 		local a,b=strfind(msg, "=");
 		if a then return strsub(msg,1,a-1), strsub(msg, b+1); else return ""; end
 	end
end

--============================================================================================ 

function AdWS_SlashHandler(msg)
 	local Cmd, SubCmd = AdWS_GetCmd(msg); --call to above function
 	
	if (Cmd == "settings") then AdWS_DisplaySettings();

	elseif (Cmd == "help") then AdWS_DisplayHelp();

 	elseif (Cmd == "damagebonus") then
 		if (SubCmd == "") then
 			ChatFrame1:AddMessage("[Help] Damage Bonus");
 			ChatFrame1:AddMessage( "Usage: /adws damagebonus 1.25 - which means 125 % Damage Bonus (ie. Enrage)" );
 		else
 			AdWSSettings.DamageBonus = SubCmd; 
 			ChatFrame1:AddMessage("Custom Damage bonus multiplier set to "..SubCmd);
 		end;

 	elseif (Cmd == "warrioroffhand") then
 		if (SubCmd == "") then
 			ChatFrame1:AddMessage("[Help] Warrior OffHand handicap");
 			ChatFrame1:AddMessage("0.500 - Default");
 			ChatFrame1:AddMessage("0.525 - DW Spec 1/5 (5 %)");
 			ChatFrame1:AddMessage("0.550 - DW Spec 2/5 (10 %)");
 			ChatFrame1:AddMessage("0.575 - DW Spec 3/5 (15 %)");
 			ChatFrame1:AddMessage("0.600 - DW Spec 4/5 (20 %)");
 			ChatFrame1:AddMessage("0.625 - DW Spec 5/5 (25 %)");
 			ChatFrame1:AddMessage( "Usage: /adws warrioroffhand 0.575" );
 		else
 			AdWSWarrior.OffHand = SubCmd; 
 			ChatFrame1:AddMessage("Warrior OffHand handicap set to "..SubCmd);
 		end; 

 	elseif (Cmd == "cap") then
 		if (SubCmd == "") then
 			ChatFrame1:AddMessage("[Help] Custom Attack Power Bonus");
 			ChatFrame1:AddMessage("25 - Elixir of Giants (Rogue)");
 			ChatFrame1:AddMessage("50 - Elixir of Giants (Warrior)");
 			ChatFrame1:AddMessage("40 - Juju Might");
 			ChatFrame1:AddMessage("140 - Onyxia Buff");
 			ChatFrame1:AddMessage("x - Your own Buff ;)");
 			ChatFrame1:AddMessage( "Usage: /adws cap 140" );
 		else
 			AdWSSettings.cAP = SubCmd; 
 			ChatFrame1:AddMessage("Custom +Attack Power bonus set to "..SubCmd);
 		end; 
 
 	elseif (Cmd == "rogueoffhand") then
 		if (SubCmd == "") then
 			ChatFrame1:AddMessage("[Help] Rogue OffHand handicap");
 			ChatFrame1:AddMessage("0.50 - Default");
 			ChatFrame1:AddMessage("0.55 - DW Spec 1/5 (10 %)");
 			ChatFrame1:AddMessage("0.60 - DW Spec 2/5 (20 %)");
 			ChatFrame1:AddMessage("0.65 - DW Spec 3/5 (30 %)");
 			ChatFrame1:AddMessage("0.70 - DW Spec 4/5 (40 %)");
 			ChatFrame1:AddMessage("0.75 - DW Spec 5/5 (50 %)");
 			ChatFrame1:AddMessage( "Usage: /adws rogueoffhand 0.60" );
 		else
 			AdWSRogue.OffHand = SubCmd; 
 			ChatFrame1:AddMessage("Rogue OffHand handicap set to "..SubCmd);
 		end; 		
 	
 	elseif (Cmd == "lethality") then
 		if (SubCmd == "") then
 			ChatFrame1:AddMessage("[Help] Rogue Lethality");
 			ChatFrame1:AddMessage("2.00 - Default (200 %)");
 			ChatFrame1:AddMessage("2.06 - Lethality 1/5 (206 %)");
 			ChatFrame1:AddMessage("2.12 - Lethality 2/5 (212 %)");
 			ChatFrame1:AddMessage("2.18 - Lethality 3/5 (218 %)");
 			ChatFrame1:AddMessage("2.24 - Lethality 4/5 (224 %)");
 			ChatFrame1:AddMessage("2.30 - Lethality 5/5 (230 %)");
 			ChatFrame1:AddMessage( "Usage: /adws lethality 2.30" );
 		else
 			AdWSRogue.Lethality = SubCmd; 
 			ChatFrame1:AddMessage("Rogue Lethality bonus set to "..SubCmd);
 		end; 			
 	
 	elseif (Cmd == "impevi") then
 		if (SubCmd == "") then
 			ChatFrame1:AddMessage("[Help] Rogue Improved Eviscerate");
 			ChatFrame1:AddMessage("1.00 - Default");
 			ChatFrame1:AddMessage("1.05 - Improved Eviscerate 1/3 (5 %)");
 			ChatFrame1:AddMessage("1.10 - Improved Eviscerate 2/3 (10 %)");
 			ChatFrame1:AddMessage("1.15 - Improved Eviscerate 3/3 (15 %)");
 			ChatFrame1:AddMessage( "Usage: /adws impevi 1.15" );
 		else
 			AdWSRogue.ImpEvi = SubCmd; 
 			ChatFrame1:AddMessage("Rogue Improved Eviscerate bonus set to "..SubCmd);
 		end; 

 	elseif (Cmd == "aggression") then
 		if (SubCmd == "") then
 			ChatFrame1:AddMessage("[Help] Rogue Improved Eviscerate");
 			ChatFrame1:AddMessage("1.00 - Default");
 			ChatFrame1:AddMessage("1.02 - Aggression 1/3 (2 %)");
 			ChatFrame1:AddMessage("1.04 - Aggression 2/3 (4 %)");
 			ChatFrame1:AddMessage("1.06 - Aggression 3/3 (6 %)");
 			ChatFrame1:AddMessage( "Usage: /adws aggression 1.06" );
 		else
 			AdWSRogue.Aggression = SubCmd; 
 			ChatFrame1:AddMessage("Rogue Aggression bonus set to "..SubCmd);
 		end;  

 	elseif (Cmd == "opportunity") then
 		if (SubCmd == "") then
 			ChatFrame1:AddMessage("[Help] Rogue Opportunity");
 			ChatFrame1:AddMessage("1.00 - Default");
 			ChatFrame1:AddMessage("1.02 - Opportunity 1/5 (4 %)");
 			ChatFrame1:AddMessage("1.04 - Opportunity 2/5 (8 %)");
 			ChatFrame1:AddMessage("1.06 - Opportunity 3/5 (12 %)");
 			ChatFrame1:AddMessage("1.06 - Opportunity 4/5 (16 %)");
 			ChatFrame1:AddMessage("1.06 - Opportunity 5/5 (20 %)");
 			ChatFrame1:AddMessage( "Usage: /adws opportunity 1.20" );
 		else
 			AdWSRogue.Opportunity = SubCmd; 
 			ChatFrame1:AddMessage("Rogue Opportunity bonus set to "..SubCmd);
 		end;  
 							 	
 	elseif (Cmd == "warriorcrit") then
 		if (SubCmd == "impale") then
 			AdWSWarrior.Crit = 2.2;
 			ChatFrame1:AddMessage("Warrior Critical Strike bonus set to 2.2 (220 %)"); 
 		elseif (SubCmd == "noimpale") then
 			AdWSWarrior.Crit = 2.0;
 			ChatFrame1:AddMessage("Warrior Critical Strike bonus set to 2.0 (200 %)");
 		else
 			ChatFrame1:AddMessage("[Help] Warrior Critical Strike");
 			ChatFrame1:AddMessage( "Usage: /adws warriorcrit impale - 220 % Crit Bonus" );
 			ChatFrame1:AddMessage( "Usage: /adws warriorcrit noimpale - 200 % Crit Bonus" );
 		end;	

 	elseif (Cmd == "swordspec") then
 		if (SubCmd == "on") then
 			AdWSWarrior.Sspec = "on";
 			ChatFrame1:AddMessage("Sword Specialization proc stats ON"); 
 		elseif (SubCmd == "off") then
 			AdWSWarrior.Sspec = "off";
 			ChatFrame1:AddMessage("Sword Specialization proc stats OFF");
 		else
 			ChatFrame1:AddMessage("[Help] Warrior Sword Spec Proc");
 			ChatFrame1:AddMessage( "Usage: /adws swordspec on - Enable Sword Spec stats" );
 			ChatFrame1:AddMessage( "Usage: /adws swordspec off - Disable Sword Spec stats" );
 		end;	
 		 	
	elseif (Cmd == "2hspec") then
 		if (SubCmd == "") then
 			ChatFrame1:AddMessage("[Help] Warrior 2H Spec");
 			ChatFrame1:AddMessage("1.00 - Default");
 			ChatFrame1:AddMessage("1.01 - 2H Specialisation 1/5 (1 %)");
 			ChatFrame1:AddMessage("1.02 - 2H Specialisation 2/5 (2 %)");
 			ChatFrame1:AddMessage("1.03 - 2H Specialisation 3/5 (3 %)");
 			ChatFrame1:AddMessage("1.04 - 2H Specialisation 4/5 (4 %)");
 			ChatFrame1:AddMessage("1.05 - 2H Specialisation 5/5 (5 %)");
 			ChatFrame1:AddMessage( "Usage: /adws 2hspec 1.05" );
 		else
 			AdWSWarrior.THSpec = SubCmd; 
 			ChatFrame1:AddMessage("Warrior 2H Specialisation bonus set to "..SubCmd);
 		end;  
 	
 	elseif (Cmd == "warriorbuild") then
 		if (SubCmd == "fury") then
 			AdWSWarrior.Build = SubCmd; 
 			ChatFrame1:AddMessage("Bloodthirst stats ON"); 
 		elseif (SubCmd == "arms") then
 			AdWSWarrior.Build = SubCmd; 
 			ChatFrame1:AddMessage("Mortal Strike stats ON"); 
 		else
 			ChatFrame1:AddMessage("[Help] Warrior Build");
 			ChatFrame1:AddMessage( "Usage: /adws warriorbuild arms - Show Mortal Strike" );
 			ChatFrame1:AddMessage( "Usage: /adws warriorcrit fury - Show Bloodthirst" );
 		end;

	elseif (Cmd == "ac") then
 		if (SubCmd == "mager14") then
 			AdWSSettings.AClass = 706;
 			AdWSSettings.ACReduction = 0.114; 
 			AdWSSettings.ACPreset= "Mage Rank 14";
 			ChatFrame1:AddMessage("AC Reduction set to: Mage Rank14 Preset"); 
 		elseif (SubCmd == "mager14b") then
 			AdWSSettings.AClass = 1266;
 			AdWSSettings.ACReduction = 0.187; 
 			AdWSSettings.ACPreset= "Mage Rank 14 B";
 			ChatFrame1:AddMessage("AC Reduction set to: Mage Rank14 Buffed Preset"); 
 		elseif (SubCmd == "tankt2prot") then
 			AdWSSettings.AClass = 9044;
 			AdWSSettings.ACReduction = 0.622; 
 			AdWSSettings.ACPreset= "Tank Tier2 Prot";
 			ChatFrame1:AddMessage("AC Reduction set to: Tank Tier2 Prot Preset");  	
 		elseif (SubCmd == "shamt1") then
 			AdWSSettings.AClass = 5401;
 			AdWSSettings.ACReduction = 0.495; 
 			AdWSSettings.ACPreset= "Shaman Tier1";
 			ChatFrame1:AddMessage("AC Reduction set to: Shaman Tier1 Preset");  

 		elseif (SubCmd == "roguet2") then
 			AdWSSettings.AClass = 2170;
 			AdWSSettings.ACReduction = 0.2829; 
 			AdWSSettings.ACPreset= "Rogue Tier2";
 			ChatFrame1:AddMessage("AC Reduction set to: Rogue Tier2 Preset");  

 		elseif (SubCmd == "huntert2") then
 			AdWSSettings.AClass = 4327;
 			AdWSSettings.ACReduction = 0.4403; 
 			AdWSSettings.ACPreset= "Hunter Tier2";
 			ChatFrame1:AddMessage("AC Reduction set to: Hunter Tier2 Preset");  
			 
 		elseif (SubCmd == "maget2") then
 			AdWSSettings.AClass = 787;
 			AdWSSettings.ACReduction = 0.1252; 
 			AdWSSettings.ACPreset= "Mage Tier2";
 			ChatFrame1:AddMessage("AC Reduction set to: Mage Tier2 Unbuff Preset");  

 		elseif (SubCmd == "priestt2") then
 			AdWSSettings.AClass = 790;
 			AdWSSettings.ACReduction = 0.1256; 
 			AdWSSettings.ACPreset= "Priest Tier2";
 			ChatFrame1:AddMessage("AC Reduction set to: Priest Tier2 Preset");  

 		elseif (SubCmd == "priestt2b") then
 			AdWSSettings.AClass = 2185;
 			AdWSSettings.ACReduction = 0.2843; 
 			AdWSSettings.ACPreset= "Priest Tier2 B";
 			ChatFrame1:AddMessage("AC Reduction set to: Priest Tier2 Inner Fire Preset");  
 			
 		elseif (SubCmd == "warrfury") then
 			AdWSSettings.AClass = 5017;
 			AdWSSettings.ACReduction = 0.477; 
 			AdWSSettings.ACPreset= "Warrior Fury";
 			ChatFrame1:AddMessage("AC Reduction set to: Warrior Fury (BWL level) Preset");  	 					 				 					
 		elseif (SubCmd == "nored") then
 			AdWSSettings.AClass = 0;
 			AdWSSettings.ACReduction = 0; 
 			AdWSSettings.ACPreset= "No Reduction";
 			ChatFrame1:AddMessage("AC Reduction set to: No Reduction Preset");  	
 		else
			ChatFrame1:AddMessage( "[Help] Damage Reductions");
			ChatFrame1:AddMessage( "Usage: /adws ac mager14 - Mage Rank 14" );
			ChatFrame1:AddMessage( "Usage: /adws ac mager14b - Mage Rank 14 Buffed" );
			ChatFrame1:AddMessage( "Usage: /adws ac shamt1 - Shaman Tier1 Set + Shield" );
			ChatFrame1:AddMessage( "Usage: /adws ac tankt2prot - Tank Tier II Prot" );
			ChatFrame1:AddMessage( "Usage: /adws ac warrfury - Warrior Fury (BWL level)" );
			
			ChatFrame1:AddMessage( "Usage: /adws ac roguet2 - Rogue Tier2 Set" );
			ChatFrame1:AddMessage( "Usage: /adws ac huntert2 - Hunter Tier2 Set" );
			ChatFrame1:AddMessage( "Usage: /adws ac maget2 - Mage Tier2 Set" );
			ChatFrame1:AddMessage( "Usage: /adws ac priestt2 - Priest Tier2 Set" );
			ChatFrame1:AddMessage( "Usage: /adws ac priestt2b - Priest Tier2 Set Buffed" );
			
 		end; 
 	else
 		AdWS_DisplayHelp();
 	end;
end;

--============================================================================================ 

function AdWS_DisplaySettings()
	ChatFrame1:AddMessage( "..:: Advanced Weapon Stats Settings ::..",1.0, 0.85, 0.33);
	ChatFrame1:AddMessage( "=== General Settings ===",1.0, 0.85, 0.33);
	
	ChatFrame1:AddMessage( "Damage bonus multiplier = "..AdWSSettings.DamageBonus,0.66,1,0.96 );
	ChatFrame1:AddMessage( "Custom Attack Power bonus = "..AdWSSettings.cAP,0.66,1,0.96 );
	ChatFrame1:AddMessage( "Armor Class reduction = "..AdWSSettings.ACPreset,0.66,1,0.96 );
	
	ChatFrame1:AddMessage( "=== Warrior Settings ===",1.0, 0.85, 0.33);
	
	if (AdWSWarrior.Build=="arms") then
		ChatFrame1:AddMessage( "Show Mortal Strike stats",0.66,1,0.96 );
	else
		ChatFrame1:AddMessage( "Show Bloodthirst stats",0.66,1,0.96 );
	end
	
	ChatFrame1:AddMessage( "Warrior Sword Spec proc display = "..AdWSWarrior.Sspec,0.66,1,0.96 );
	ChatFrame1:AddMessage( "Warrior Critical Strike bonus = "..AdWSWarrior.Crit,0.66,1,0.96 );
	ChatFrame1:AddMessage( "Warrior 2Hand Spec bonus = "..AdWSWarrior.THSpec,0.66,1,0.96 );
	ChatFrame1:AddMessage( "Warrior OffHand Weapon handicap = "..AdWSWarrior.OffHand,0.66,1,0.96 );
	
	ChatFrame1:AddMessage( "=== Rogue Settings ===",1.0, 0.85, 0.33);
	ChatFrame1:AddMessage( "Rogue Lethality bonus = "..AdWSRogue.Lethality,0.66,1,0.96 );
	ChatFrame1:AddMessage( "Rogue Opportunity bonus = "..AdWSRogue.Opportunity,0.66,1,0.96 );
	ChatFrame1:AddMessage( "Rogue Aggression bonus = "..AdWSRogue.Aggression,0.66,1,0.96 );
	ChatFrame1:AddMessage( "Rogue Eviscerate bonus = "..AdWSRogue.ImpEvi,0.66,1,0.96 );
	ChatFrame1:AddMessage( "Rogue OffHand Weapon handicap = "..AdWSRogue.OffHand,0.66,1,0.96 ); 
end

--============================================================================================ 

function AdWS_DisplayHelp()
	ChatFrame1:AddMessage( "..:: Advanced Weapon Stats - Help ::..",1.0, 0.85, 0.33);
	ChatFrame1:AddMessage( "=== General ===",1.0, 0.85, 0.33);

	ChatFrame1:AddMessage( "Show current settings",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws settings" );
	ChatFrame1:AddMessage( "Set Custom Damage bonus ie. 1.25 = Enrage",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws damagebonus" );
	ChatFrame1:AddMessage( "Set Custom Attack Power bonus",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws cap" );
	ChatFrame1:AddMessage( "Set AC Reduction Level",0.66,1,0.96);
	ChatFrame1:AddMessage( "Usage: /adws ac" );

	ChatFrame1:AddMessage( "=== Warrior ===",1.0, 0.85, 0.33);

	ChatFrame1:AddMessage( "Show Mortal Strike stats",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws warriorbuild" );
	ChatFrame1:AddMessage( "Set Warrior Critical Strike bonus",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws warriorcrit" );
	ChatFrame1:AddMessage( "Set Warrior 2Hand Spec bonus",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws 2hspec" );
	ChatFrame1:AddMessage( "Set Warrior OffHand handicap",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws warrioroffhand" );
	ChatFrame1:AddMessage( "Set Warrior Sword Spec proc display",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws swordspec" );

	ChatFrame1:AddMessage( "=== Rogue ===",1.0, 0.85, 0.33);

	ChatFrame1:AddMessage( "Set Rogue Lethality bonus",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws lethality" )
	ChatFrame1:AddMessage( "Set Rogue Opportunity bonus",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws opportunity" )
	ChatFrame1:AddMessage( "Set Rogue Aggression bonus",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws aggression" )
	ChatFrame1:AddMessage( "Set Rogue Eviscerate bonus",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws impevi" )
	ChatFrame1:AddMessage( "Set Rogue OffHand handicap",0.66,1,0.96 );
	ChatFrame1:AddMessage( "Usage: /adws rogueoffhand" )
end

--===================================================================================================================--

function AuctionFrame_LoadUI ()
	AdWS_Hook.AuctionFrame_LoadUI ();

	if (not AdWS_Hook.AuctionFrameItem_OnEnter) then
		AdWS_Hook.AuctionFrameItem_OnEnter = AuctionFrameItem_OnEnter;
		AuctionFrameItem_OnEnter = function (type, index)
			AdWS_Hook.AuctionFrameItem_OnEnter (type, index);
			AdWS_CheckTooltipInfo (GameTooltip);
		end;
	end
end

function SetItemRef (link, text, button)
	AdWS_Hook.SetItemRef (link, text, button);
	AdWS_CheckTooltipInfo (ItemRefTooltip);
end

function ContainerFrameItemButton_OnEnter ()
	AdWS_Hook.ContainerFrameItemButton_OnEnter ();
	AdWS_CheckTooltipInfo (GameTooltip);
end

function ContainerFrame_Update (frame)
	AdWS_Hook.ContainerFrame_Update (frame);
	AdWS_CheckTooltipInfo (GameTooltip);
end

function GameTooltip.SetInventoryItem (unit, slotID, name)
	local hasItem, hasCooldown, repairCost = AdWS_Hook.SetInventoryItem (unit, slotID, name);
	if (hasItem) and (name ~=17) then
		AdWS_CheckTooltipInfo (GameTooltip);
	end
	
	return hasItem, hasCooldown, repairCost;
end

function GameTooltip.SetLootItem (this, slot)
	AdWS_Hook.SetLootItem (this, slot);
	AdWS_CheckTooltipInfo (GameTooltip);
end

function GameTooltip.SetMerchantItem (unit, slotID)
	AdWS_Hook.SetMerchantItem (unit, slotID);
	AdWS_CheckTooltipInfo (GameTooltip);
end

function ShoppingTooltip1.SetMerchantCompareItem (this, id, num)
	local retval = AdWS_Hook.SetMerchantCompareItem1 (this, id, num);
	AdWS_CheckTooltipInfo (ShoppingTooltip1);
	return retval;
end

function ShoppingTooltip1.SetAuctionCompareItem (this, _type, index, num)
	local retval = AdWS_Hook.SetAuctionCompareItem1 (this, _type, index, num);
	AdWS_CheckTooltipInfo (ShoppingTooltip1);
	return retval;
end

function ShoppingTooltip2.SetMerchantCompareItem (this, id, num)
	local retval = AdWS_Hook.SetMerchantCompareItem2 (this, id, num);
	AdWS_CheckTooltipInfo (ShoppingTooltip2);
	return retval;
end

function ShoppingTooltip2.SetAuctionCompareItem (this, _type, index, num)
	local retval = AdWS_Hook.SetAuctionCompareItem2 (this, _type, index, num);
	AdWS_CheckTooltipInfo (ShoppingTooltip2);
	return retval;
end

--=====================================================================================

function AdWS_RemoveEquipEffect (AdWS, slotname)
	AdWSTooltip:Hide();
	AdWSTooltip:SetOwner(AdWSTooltip, "ANCHOR_NONE");
	
	if (AdWSTooltip:SetInventoryItem ("player", GetInventorySlotInfo(slotname)) == false) then return; end

	local index = 2;
	local ltext = getglobal(AdWSTooltip:GetName().."TextLeft"..index):GetText();
	while (ltext ~= nil) do
		if (string.find (ltext, AdWS_Locale.ID_Strength)) then
			local v;
			_, _, v = string.find (ltext, "%+(%d+)");
			if (v) then
				if (AdWS.playerclass == AdWS_Locale.ID_Warrior) then
					AdWS.power = AdWS.power - (v * 2);
				elseif (AdWS.playerclass == AdWS_Locale.ID_Shaman) then
					AdWS.power = AdWS.power - (v * 2);
				elseif (AdWS.playerclass == AdWS_Locale.ID_Paladin) then
					AdWS.power = AdWS.power - (v * 2);		
				elseif (AdWS.playerclass == AdWS_Locale.ID_Rogue) then
					AdWS.power = AdWS.power - v;
					
				end
			else
				_, _, v = string.find (ltext, "%-(%d+)");
				if (v) then
					if (AdWS.playerclass == AdWS_Locale.ID_Warrior) then
						AdWS.power = AdWS.power + (v * 2);
					elseif (AdWS.playerclass == AdWS_Locale.ID_Shaman) then
						AdWS.power = AdWS.power + (v * 2);
					elseif (AdWS.playerclass == AdWS_Locale.ID_Paladin) then
						AdWS.power = AdWS.power + (v * 2);		
					elseif (AdWS.playerclass == AdWS_Locale.ID_Rogue) then
						AdWS.power = AdWS.power + v;
					end
				end
			end
		elseif (string.find (ltext, AdWS_Locale.ID_Agility)) then
			local v;
			_, _, v = string.find (ltext, "%+(%d+)");
			if (v) then
				if (AdWS.playerclass == AdWS_Locale.ID_Rogue) then
					AdWS.power = AdWS.power - v;
				end
			else
				_, _, v = string.find (ltext, "%-(%d+)");
				if (v) then
					if (AdWS.playerclass == AdWS_Locale.ID_Rogue) then
						AdWS.power = AdWS.power + v;
					end
				end
			end
		elseif (string.find (ltext, AdWS_Locale.ID_Rockbiter)) then 
			local v;
			_, _, v = string.find (ltext, "(%d+)");
			if (v=="1") then AdWS.power = AdWS.power - 44; 	
			elseif (v=="2") then AdWS.power = AdWS.power - 72; 	
			elseif (v=="3") then AdWS.power = AdWS.power - 80; 	
			end
			
		elseif (string.find (ltext, AdWS_Locale.ID_Attack_Power)) then
			local v;
			_, _, v = string.find (ltext, "+(%d+)");
			AdWS.power = AdWS.power - v;
					
		end

		index = index + 1;
		ltext = getglobal(AdWSTooltip:GetName().."TextLeft"..index):GetText();
	end
	
	AdWSTooltip:ClearLines();
end

--===========================================================================

function AdWS_CheckTooltipInfo(frame)
	if (frame:IsVisible()) then
		local pclass = UnitClass("player");
		local field = getglobal(frame:GetName().."TextLeft1");
	
		if (pclass ~= AdWS_Locale.ID_Warrior and pclass ~= AdWS_Locale.ID_Rogue and pclass ~= AdWS_Locale.ID_Shaman and pclass ~= AdWS_Locale.ID_Paladin) then
		-- NOTE:  trying to stay out of this if you don't need it...
			return; 
		end		
		 
		if (field and field:IsVisible()) then
		-- NOTE:  trying to fix the quick roll in/out problem...            
			local fname = frame:GetName();
	
			if(field:GetText()) then
				local index = 2;
				local ltext = getglobal(fname.."TextLeft"..index):GetText();
				while(ltext) do
					if (string.find (ltext, AdWS_Locale.ID_Output_Normal)) then return; end
					index = index + 1;
					local glob = getglobal(fname.."TextLeft"..index);
					if (glob) then
                        			ltext = glob:GetText();
					else
						-- NOTE:  getting here means there's a problem...
						return;
					end
				end	
			return AdWS_AddTooltipInfo(frame);
			end
		end
	end
end

--=====================================================================

function AdWS_AddTooltipInfo(frame)
	local AdWS = {
		power = 0, weapondamage =0, sharpened = 0, rockbiter=0, windfury=0,
	};

	AdWS.playerclass = UnitClass("player");
	if (AdWS.playerclass ~= AdWS_Locale.ID_Warrior and AdWS.playerclass ~= AdWS_Locale.ID_Rogue and AdWS.playerclass ~= AdWS_Locale.ID_Shaman and AdWS.playerclass ~= AdWS_Locale.ID_Paladin) then return; end

	local index = 2;
	local ltext = getglobal(frame:GetName().."TextLeft"..index):GetText();
	local rtext = getglobal(frame:GetName().."TextRight"..index):GetText();
	while (ltext ~= nil) do
		if (not AdWS.weapon and ltext == AdWS_Locale.ID_Two_Hand) then
			if (AdWS.playerclass == AdWS_Locale.ID_Rogue) then return; end

			AdWS.weapon = ltext;
			if (rtext == AdWS_Locale.ID_Mace or rtext == AdWS_Locale.ID_Axe or rtext == AdWS_Locale.ID_Polearm or rtext == AdWS_Locale.ID_Staff) then
			elseif (rtext == AdWS_Locale.ID_Sword) then
				AdWS.issword = true;	 
			else
				return;
			end
		elseif (not AdWS.weapon and (ltext == AdWS_Locale.ID_Main_Hand or ltext == AdWS_Locale.ID_One_Hand)) then
			AdWS.weapon = ltext;
			if (rtext == AdWS_Locale.ID_Mace or rtext == AdWS_Locale.ID_Axe or rtext == AdWS_Locale.ID_Fist_Weapon) then
			elseif (rtext == AdWS_Locale.ID_Dagger) then
				AdWS.isdagger = true;
			elseif (rtext == AdWS_Locale.ID_Sword) then
				AdWS.issword = true;	
			else
				return;
			end
		elseif (not AdWS.damage and string.find (ltext, AdWS_Locale.ID_Damage)) then
			
			local low, high
			_, _, low, high = string.find (ltext, "(%d+) %- (%d+)");
			AdWS.damage = (low + high) / 2;
			_, _, AdWS.speed = string.find(rtext, "(%d+%.%d+)");
			if (not AdWS.speed) then
				AdWS.speed = string.find(rtext, "(%d+%,%d+)");
				AdWS.speed = string.gsub (AdWS.speed, "%,", "%.");
			end

			--=================== additional spell damage (like nature damage , thunderfury) 
 		elseif (string.find (ltext, AdWS_Locale.ID_Nature_Damage)) then	
			local slow, shigh
			_, _, slow, shigh = string.find (ltext, "(%d+) %- (%d+) Nature Damage");
			AdWS.damage = AdWS.damage + ((slow + shigh) / 2)
			
 		elseif (string.find (ltext, AdWS_Locale.ID_Frost_Damage)) then	
			local slow, shigh
			_, _, slow, shigh = string.find (ltext, "(%d+) %- (%d+) Frost Damage");
			AdWS.damage = AdWS.damage + ((slow + shigh) / 2)			
			
		elseif (string.find (ltext, AdWS_Locale.ID_Strength)) then
			local v;
			_, _, v = string.find (ltext, "%+(%d+)");
			if (v) then
				if (AdWS.playerclass == AdWS_Locale.ID_Warrior) then
					AdWS.power = AdWS.power + v * 2;
				elseif (AdWS.playerclass == AdWS_Locale.ID_Shaman) then
					AdWS.power = AdWS.power + v * 2;
				elseif (AdWS.playerclass == AdWS_Locale.ID_Paladin) then
					AdWS.power = AdWS.power + v * 2;										
				elseif (AdWS.playerclass == AdWS_Locale.ID_Rogue) then
					AdWS.power = AdWS.power + v;
				end
			else
				_, _, v = string.find (ltext, "%-(%d+)");
				if (v) then
					if (AdWS.playerclass == AdWS_Locale.ID_Warrior) then
						AdWS.power = AdWS.power - v * 2;
					elseif (AdWS.playerclass == AdWS_Locale.ID_Shaman) then
						AdWS.power = AdWS.power - v * 2;
					elseif (AdWS.playerclass == AdWS_Locale.ID_Paladin) then
						AdWS.power = AdWS.power - v * 2;										
					elseif (AdWS.playerclass == AdWS_Locale.ID_Rogue) then
						AdWS.power = AdWS.power - v;
					end
				end
			end

		elseif (string.find (ltext, AdWS_Locale.ID_Weapon_Damage)) then
			local v;
			_, _, v = string.find (ltext, "%+(%d+)");
			if (v) then
				AdWS.weapondamage = v;
			end

		elseif (string.find (ltext, AdWS_Locale.ID_Sharpened)) then
			local v;
			_, _, v = string.find (ltext, "%+(%d+)");
			if (v) then
				AdWS.sharpened = v;
			end						
		elseif (string.find (ltext, AdWS_Locale.ID_Agility)) then
			local v;
			_, _, v = string.find (ltext, "%+(%d+)");
			if (v) then
				if (AdWS.playerclass == AdWS_Locale.ID_Rogue) then
					AdWS.power = AdWS.power + v;
				end
			else
				_, _, v = string.find (ltext, "%-(%d+)");
				if (v) then
					if (AdWS.playerclass == AdWS_Locale.ID_Rogue) then
						AdWS.power = AdWS.power - v;
					end
				end
			end
		elseif (string.find (ltext, AdWS_Locale.ID_Rockbiter)) then 
			AdWS.isrockbiter = true;
			local v;
			_, _, v = string.find (ltext, "(%d+)");
			if (v=="1") then AdWS.power = AdWS.power + 44; 	
			elseif (v=="2") then AdWS.power = AdWS.power + 72; 	
			elseif (v=="3") then AdWS.power = AdWS.power + 80; 	
			end
			
			
		elseif (string.find (ltext, AdWS_Locale.ID_Attack_Power)) then
			local v;
			_, _, v = string.find (ltext, "+(%d+)");
			AdWS.power = AdWS.power + v;
			
			
		end

		index = index + 1;
		ltext = getglobal(frame:GetName().."TextLeft"..index):GetText();
		rtext = getglobal(frame:GetName().."TextRight"..index):GetText();
	end

	if (AdWS.weapon) then
		local base, posBuff, negBuff = UnitAttackPower("player");
		AdWS.power = AdWS.power + base + posBuff + negBuff + AdWSSettings.cAP;
		
		AdWS_RemoveEquipEffect (AdWS, "MainHandSlot");
		
		if (AdWS.weapon == AdWS_Locale.ID_Two_Hand) then AdWS_RemoveEquipEffect (AdWS, "SecondaryHandSlot"); end
		
		--=========================================
		--============== FORMULAS
		--=========================================
		
		local normal = (AdWS.damage + AdWS.weapondamage + AdWS.sharpened) + (AdWS.power * AdWS.speed / 14);
		local instant;
		
		local rockbiter = (AdWS.damage + AdWS.weapondamage + AdWS.sharpened) + ((AdWS.power + 504) * AdWS.speed / 14);
		local windfury = (AdWS.damage + AdWS.weapondamage + AdWS.sharpened) + ((AdWS.power + 665) * AdWS.speed / 14);
		
		local flurryspeed = AdWS.speed/1.3;
		local flurrydps = normal / flurryspeed;
		
		local roguespeed = AdWS.speed/1.56;
		local roguedps = normal / roguespeed;
		
		local bloodthirst = AdWS.power * 0.45;
		local dps = normal / AdWS.speed;
		local ten_dmg = 10/AdWS.speed*14;
		local ten_ap = 10/14*AdWS.speed;

		if (AdWS.issword) then spss = 100 * AdWS.speed / 5; else spss = 0; end;
		
		if (AdWS.isdagger) then 
			instant = (AdWS.damage + AdWS.weapondamage + AdWS.sharpened) + (AdWS.power * 1.7 / 14);
		elseif (AdWS.weapon == AdWS_Locale.ID_Two_Hand) then 
			instant = (AdWS.damage + AdWS.weapondamage + AdWS.sharpened) + (AdWS.power * 3.3 / 14);
		else 
			instant = (AdWS.damage + AdWS.weapondamage + AdWS.sharpened) + (AdWS.power * 2.4 / 14); 
		end

		local backstab = (AdWS.damage + AdWS.weapondamage + AdWS.sharpened) * 1.5 + (AdWS.power * 1.7 / 14) + 225;
		local ambush = (AdWS.damage + AdWS.weapondamage + AdWS.sharpened) * 2.5 + (AdWS.power * 1.7 / 14) + 290;
		local ghostlystrike = (AdWS.damage + AdWS.weapondamage + AdWS.sharpened) * 1.25 + (AdWS.power * 1.7 / 14);
		local riposte = (AdWS.damage + AdWS.weapondamage + AdWS.sharpened) * 1.5 + (AdWS.power * 1.7 / 14);
		
		frame:AddLine(" " , 1,1,1);
		
		--=================== GENERAL STATS (dps, 10ap, 10dmg, sword spec)
		
		if (AdWS.playerclass == AdWS_Locale.ID_Warrior) or (AdWS.playerclass == AdWS_Locale.ID_Shaman) then
			frame:AddDoubleLine (AdWS_Locale.ID_Output_DPS..string.format ("%.1f (%.1f)",dps, flurrydps), AdWS_Locale.ID_Output_FlurrySpeed..string.format ("%.2f", flurryspeed), 1.0, 0.85, 0.33, 1.0, 1.0, 1.0);
		elseif (AdWS.playerclass == AdWS_Locale.ID_Rogue) and (AdWS.weapon ~= AdWS_Locale.ID_Two_Hand) then
			frame:AddDoubleLine (AdWS_Locale.ID_Output_DPS..string.format ("%.1f (%.1f)",dps, roguedps), AdWS_Locale.ID_Output_RogueSpeed..string.format ("%.2f", roguespeed), 1.0, 0.85, 0.33, 1.0, 1.0, 1.0);
		end;
		
		frame:AddDoubleLine (AdWS_Locale.ID_Output_TenDmg..string.format ("%.0f AP", ten_dmg), AdWS_Locale.ID_Output_TenAp..string.format ("%.2f DMG", ten_ap), 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
		
		if (AdWS.issword) and (AdWS.playerclass == AdWS_Locale.ID_Warrior) and (AdWSWarrior.Sspec == "on") then 
			frame:AddLine("Sword Spec - per "..spss.." secs" , 1,1,1); 
		end;
		
		frame:AddLine(" " , 1,1,1);
		
		--=========================================
		--============== MAIN HAND STATS
		--=========================================
		
		frame:AddDoubleLine("Main hand stats", "Hit / Crit / x"..AdWSSettings.DamageBonus, 0.46,0.91,0.99,0.46,0.91,0.99);
		
		AdWSWarrior.THSpec = tonumber (AdWSWarrior.THSpec);
		
		--======= WARRIOR
		
		if (AdWS.playerclass == AdWS_Locale.ID_Warrior) then 
			if (AdWS.weapon == AdWS_Locale.ID_Two_Hand) and (AdWSWarrior.THSpec > 1) then
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Normal, string.format ("%.0f / %.0f / %.0f", normal*AdWSWarrior.THSpec*(1-AdWSSettings.ACReduction), normal * AdWSWarrior.THSpec * 2*(1-AdWSSettings.ACReduction), normal * AdWSWarrior.THSpec * 2 * AdWSSettings.DamageBonus*(1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
			else
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Normal, string.format ("%.0f / %.0f / %.0f", normal*(1-AdWSSettings.ACReduction), normal * 2*(1-AdWSSettings.ACReduction), normal * 2 * AdWSSettings.DamageBonus*(1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
			end	
		
		--======= OTHER CLASSES
			
		else
			frame:AddDoubleLine (AdWS_Locale.ID_Output_Normal, string.format ("%.0f / %.0f / %.0f", normal*(1-AdWSSettings.ACReduction), normal * 2*(1-AdWSSettings.ACReduction), normal * 2 * AdWSSettings.DamageBonus*(1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
		end
		
		--=========================================
		--============== WARRIOR PART DISPLAY
		--=========================================
		
		if (AdWS.playerclass == AdWS_Locale.ID_Warrior) then

			if (AdWSWarrior.Build=="fury") then
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Bloodthirst, string.format ("%.0f / %.0f / %.0f", bloodthirst*(1-AdWSSettings.ACReduction), bloodthirst * AdWSWarrior.Crit*(1-AdWSSettings.ACReduction), bloodthirst * AdWSWarrior.Crit * AdWSSettings.DamageBonus*(1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
			end
		
		--======= 2H SPEC
			
			if (AdWS.weapon == AdWS_Locale.ID_Two_Hand) and (AdWSWarrior.THSpec > 1) then
				
				if (AdWSWarrior.Build=="arms") then
					frame:AddDoubleLine (AdWS_Locale.ID_Output_MortalStrike, string.format ("%.0f / %.0f / %.0f", (instant + 160) * AdWSWarrior.THSpec * (1-AdWSSettings.ACReduction), (instant + 160) * AdWSWarrior.THSpec * AdWSWarrior.Crit * (1-AdWSSettings.ACReduction), (instant + 160) * AdWSWarrior.THSpec * AdWSWarrior.Crit * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
				end
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Whirlwind, string.format ("%.0f / %.0f / %.0f", instant * AdWSWarrior.THSpec * (1-AdWSSettings.ACReduction), instant * AdWSWarrior.THSpec * AdWSWarrior.Crit * (1-AdWSSettings.ACReduction), instant * AdWSWarrior.THSpec * AdWSWarrior.Crit * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);		
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Overpower, string.format ("%.0f / %.0f / %.0f", (instant + 35) * AdWSWarrior.THSpec * (1-AdWSSettings.ACReduction), (instant + 35) * AdWSWarrior.THSpec * AdWSWarrior.Crit * (1-AdWSSettings.ACReduction), (instant + 35) * AdWSWarrior.THSpec * AdWSWarrior.Crit * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
				frame:AddDoubleLine (AdWS_Locale.ID_Output_HeroicStrike, string.format ("%.0f / %.0f / %.0f", (normal + 157) * AdWSWarrior.THSpec * (1-AdWSSettings.ACReduction), (normal + 157) * AdWSWarrior.THSpec * AdWSWarrior.Crit * (1-AdWSSettings.ACReduction), (normal + 157) * AdWSWarrior.THSpec * AdWSWarrior.Crit * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
						
		--======= NO 2H SPEC
			else
				if (AdWSWarrior.Build=="arms") then
					frame:AddDoubleLine (AdWS_Locale.ID_Output_MortalStrike, string.format ("%.0f / %.0f / %.0f", (instant + 160) * (1-AdWSSettings.ACReduction), (instant + 160) * AdWSWarrior.Crit * (1-AdWSSettings.ACReduction), (instant + 160) * AdWSWarrior.Crit * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
				end
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Whirlwind, string.format ("%.0f / %.0f / %.0f", instant * (1-AdWSSettings.ACReduction), instant * AdWSWarrior.Crit * (1-AdWSSettings.ACReduction), instant * AdWSWarrior.Crit * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);		
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Overpower, string.format ("%.0f / %.0f / %.0f", (instant + 35) * (1-AdWSSettings.ACReduction), (instant + 35) * AdWSWarrior.Crit * (1-AdWSSettings.ACReduction), (instant + 35) * AdWSWarrior.Crit * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
				frame:AddDoubleLine (AdWS_Locale.ID_Output_HeroicStrike, string.format ("%.0f / %.0f / %.0f", (normal + 157) * (1-AdWSSettings.ACReduction), (normal + 157) * AdWSWarrior.Crit * (1-AdWSSettings.ACReduction), (normal + 157) * AdWSWarrior.Crit * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);			
			end
			
			if (AdWS.weapon == AdWS_Locale.ID_One_Hand) then
				frame:AddDoubleLine (AdWS_Locale.ID_Output_OffHand, string.format ("%.0f / %.0f / %.0f", normal * (1-AdWSSettings.ACReduction)*AdWSWarrior.OffHand, normal * 2 * (1-AdWSSettings.ACReduction)*AdWSWarrior.OffHand, normal * 2 * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)*AdWSWarrior.OffHand), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
			elseif (AdWS.weapon == AdWS_Locale.ID_Off_Hand) then
				frame:AddDoubleLine (AdWS_Locale.ID_Output_OffHand, string.format ("%.0f / %.0f / %.0f", normal * (1-AdWSSettings.ACReduction)*AdWSWarrior.OffHand, normal * 2 * (1-AdWSSettings.ACReduction)*AdWSWarrior.OffHand, normal * 2 * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)*AdWSWarrior.OffHand), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
			end

		end
		
		--=========================================
		--============== ROGUE PART DISPLAY
		--=========================================
		
		if (AdWS.playerclass == AdWS_Locale.ID_Rogue) then
		
			if (AdWS.weapon == AdWS_Locale.ID_One_Hand) or (AdWS.weapon == AdWS_Locale.ID_Main_Hand) then 
		
				if (AdWS.isdagger) then
					frame:AddDoubleLine (AdWS_Locale.ID_Output_Ambush, string.format ("%.0f / %.0f / %.0f", ambush * AdWSRogue.Opportunity * (1-AdWSSettings.ACReduction), ambush * AdWSRogue.Opportunity * 2 * (1-AdWSSettings.ACReduction), ambush * AdWSRogue.Opportunity * 2 * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
					frame:AddDoubleLine (AdWS_Locale.ID_Output_Backstab, string.format ("%.0f / %.0f / %.0f", backstab * AdWSRogue.Opportunity * (1-AdWSSettings.ACReduction), backstab * AdWSRogue.Opportunity * AdWSRogue.Lethality * (1-AdWSSettings.ACReduction), backstab * AdWSRogue.Opportunity * AdWSRogue.Lethality * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
				end
		
				frame:AddDoubleLine (AdWS_Locale.ID_Output_SinisterStrike, string.format ("%.0f / %.0f / %.0f", (instant + 68) * AdWSRogue.Aggression * (1-AdWSSettings.ACReduction), (instant + 68) * AdWSRogue.Aggression * AdWSRogue.Lethality * (1-AdWSSettings.ACReduction), (instant + 68) * AdWSRogue.Aggression * AdWSRogue.Lethality * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Eviscerate, string.format ("%.0f / %.0f / %.0f", 936 * AdWSRogue.ImpEvi * AdWSRogue.Aggression * (1-AdWSSettings.ACReduction), 936 * AdWSRogue.ImpEvi * AdWSRogue.Aggression * 2 * (1-AdWSSettings.ACReduction), 936 * AdWSRogue.ImpEvi * AdWSRogue.Aggression * 2 * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Ghostly_Strike, string.format ("%.0f / %.0f / %.0f", ghostlystrike * (1-AdWSSettings.ACReduction), ghostlystrike * AdWSRogue.Lethality * (1-AdWSSettings.ACReduction), ghostlystrike * AdWSRogue.Lethality * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Riposte, string.format ("%.0f / %.0f / %.0f", riposte * (1-AdWSSettings.ACReduction), riposte * 2 * (1-AdWSSettings.ACReduction), riposte * 2 * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Hemorrhage, string.format ("%.0f / %.0f / %.0f", normal * (1-AdWSSettings.ACReduction), normal * AdWSRogue.Lethality * (1-AdWSSettings.ACReduction), normal * AdWSRogue.Lethality * AdWSSettings.DamageBonus * (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
			end
	 		
	 		if (AdWS.weapon == AdWS_Locale.ID_One_Hand) then
	 			frame:AddDoubleLine (AdWS_Locale.ID_Output_OffHand, string.format ("%.0f / %.0f / %.0f", normal* (1-AdWSSettings.ACReduction)*AdWSRogue.OffHand, normal * 2* (1-AdWSSettings.ACReduction)*AdWSRogue.OffHand, normal * 2 * AdWSSettings.DamageBonus* (1-AdWSSettings.ACReduction)*AdWSRogue.OffHand), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
			elseif (AdWS.weapon == AdWS_Locale.ID_Off_Hand) then
				frame:AddDoubleLine (AdWS_Locale.ID_Output_OffHand, string.format ("%.0f / %.0f / %.0f", normal* (1-AdWSSettings.ACReduction)*AdWSRogue.OffHand, normal * 2* (1-AdWSSettings.ACReduction)*AdWSRogue.OffHand, normal * 2 * AdWSSettings.DamageBonus* (1-AdWSSettings.ACReduction)*AdWSRogue.OffHand), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);
			end

		end

		--=========================================
		--============== SHAMAN PART DISPLAY
		--=========================================

		if (AdWS.playerclass == AdWS_Locale.ID_Shaman) then
			if (AdWS.iswindfury~=true) and (AdWS.isrockbiter~=true) then
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Windfury.."(4) x2:", string.format ("%.0f / %.0f / %.0f", windfury* (1-AdWSSettings.ACReduction) *2, windfury * 2* (1-AdWSSettings.ACReduction) *2, windfury * 2 * AdWSSettings.DamageBonus* (1-AdWSSettings.ACReduction) *2), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);		
				frame:AddDoubleLine (AdWS_Locale.ID_Output_Rockbiter.."(7):", string.format ("%.0f / %.0f / %.0f", rockbiter* (1-AdWSSettings.ACReduction), rockbiter * 2* (1-AdWSSettings.ACReduction), rockbiter * 2 * AdWSSettings.DamageBonus* (1-AdWSSettings.ACReduction)), 0.99, 0.99, 0.65, 1.0, 1.0, 1.0);		
			end
		end
				 
		--=========================================
		--============== FOOTER - REDUCTION
		--=========================================
 
		frame:AddLine(" ", 1,1,1);
		frame:AddDoubleLine("Dmg Red:", AdWSSettings.ACPreset.." ("..AdWSSettings.AClass.." AC)", 1,1,1,0.66,1,0.96);
			
		frame:Show();
	end
end