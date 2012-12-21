--[[--------------------------------------------------------------------------------
  ItemSyncCore Parse Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]
	

---------------------------------------------------
-- ISync:Do_Parse()
---------------------------------------------------
function ISync:Do_Parse(sFrame, sToolTip, sID, sLinkID)

	if(not ISyncDB) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end
	if(not ISyncDB[ISYNC_REALM_NUM][sID]) then return nil; end
	
	sFrame.TooltipButton = 1;
	sToolTip:ClearLines();
	sToolTip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
	sToolTip:SetHyperlink(sLinkID);
	ISync:ParseTooltip(sID, sLinkID);
	sToolTip:Hide();

end


---------------------------------------------------
-- ISync:ParseTooltip()
---------------------------------------------------
function ISync:ParseTooltip(sID, sLinkID)

	if(not sID) then return nil; end
	if(not tonumber(sID)) then return nil; end
	if(not ISync:FetchDB(tonumber(sID), "chk")) then return nil; end
	
	sID = tonumber(sID); --convert
		
	local sTipLeft;
	local sTipRight;
	local sParseLink;

	sTipLeft = "ISyncTooltipTextLeft";
	sTipRight = "ISyncTooltipTextRight";
	
	--make sure we have tooltip info to work with
	if(not sTipLeft or not sTipRight) then return; end

	
	--begin the loop with the amount of lines in the tooltip
	for index = 1, ISyncTooltip:NumLines(), 1 do
		
		--get the tooltip left information
		field = getglobal(sTipLeft..index);
		if( field and field:IsVisible() ) then
			left = field:GetText();
		else
			left = nil;
		end
			
		--get the tooltip right information
		field = getglobal(sTipRight..index);
		if( field and field:IsVisible() ) then
			right = field:GetText();
		else
			right = nil;
		end
				
		--do item locations / weapon locations
		if(left and ISYNC_WeaponLocation[left] ~= nil) then
			
			--when the weapon occasionally shows on the right
			--we need to compensate for this
			if(left == ISYNC_CROSSBOW_TEXT) then
			
				--store the special weapon type
				if(not ISync:FetchDB(sID, "wt")) then
				
					ISync:SetDB(sID, "wt", ISYNC_WeaponTypes[left]);
					
				--if it doesn't match the one stored then update it
				elseif(not ISync:FetchDB(sID, "wt", ISYNC_WeaponTypes[left])) then
				
					ISync:SetDB(sID, "wt", ISYNC_WeaponTypes[left]);
				end
				
				
			elseif(left == ISYNC_GUN_TEXT) then
			
			
				--store the special weapon type
				if(not ISync:FetchDB(sID, "wt")) then
				
					ISync:SetDB(sID, "wt", ISYNC_WeaponTypes[left]);
					
				--if it doesn't match the one stored then update it
				elseif(not ISync:FetchDB(sID, "wt", ISYNC_WeaponTypes[left])) then
				
					ISync:SetDB(sID, "wt", ISYNC_WeaponTypes[left]);
				end
				

			elseif(left == ISYNC_THROWN_TEXT) then
			
			
				--store the special weapon type
				if(not ISync:FetchDB(sID, "wt")) then
				
					ISync:SetDB(sID, "wt", ISYNC_WeaponTypes[left]);
					
				--if it doesn't match the one stored then update it
				elseif(not ISync:FetchDB(sID, "wt", ISYNC_WeaponTypes[left])) then
				
					ISync:SetDB(sID, "wt", ISYNC_WeaponTypes[left]);
				end
				

			elseif(left == ISYNC_WAND_TEXT) then
			
			
				--store the special weapon type
				if(not ISync:FetchDB(sID, "wt")) then
				
					ISync:SetDB(sID, "wt", ISYNC_WeaponTypes[left]);
					
				--if it doesn't match the one stored then update it
				elseif(not ISync:FetchDB(sID, "wt", ISYNC_WeaponTypes[left])) then
				
					ISync:SetDB(sID, "wt", ISYNC_WeaponTypes[left]);
				end
				
			
			else --it's not a special case
					
					
				--THIS IS WEAPON LOCATION NOT WEAPON TYPE!
				if(not ISync:FetchDB(sID, "wl")) then
				
					ISync:SetDB(sID, "wl", ISYNC_WeaponLocation[left]);
					
				--if it doesn't match the one stored then update it
				elseif(not ISync:FetchDB(sID, "wl", ISYNC_WeaponLocation[left])) then
				
					ISync:SetDB(sID, "wl", ISYNC_WeaponLocation[left]);
				end
				
			
			end

			
	
		end
	
		--do weapon types
		if(right and ISYNC_WeaponTypes[right] ~= nil) then
			
			
			if(not ISync:FetchDB(sID, "wt")) then

				ISync:SetDB(sID, "wt", ISYNC_WeaponTypes[right]);

			--if it doesn't match the one stored then update it
			elseif(not ISync:FetchDB(sID, "wt", ISYNC_WeaponTypes[right])) then

				ISync:SetDB(sID, "wt", ISYNC_WeaponTypes[right]);
			end
				
		end
		
		
		--grab the level requirement for items or tradeskills
		if(left) then
				_, _, sVariable1 = string.find(left, ISYNC_REQUIRE_FIND);
			
				if( sVariable1 and sLinkID) then
				
					local _, _, _, minLevel_X = GetItemInfo(sLinkID);
					
					_, _, sLVLVariable1 = string.find(sVariable1, ISYNC_REQUIRE_FIND2); --check for level requirement
					

					if( sLVLVariable1 ) then
					
							--NEW LVL GRAB (MAKE SURE IT ISN'T A PATTERN (we want to be able to find craftable items using lvlrange)
							if(minLevel_X and not ISync:FetchDB(sID, "level")) then
							
								ISync:SetDB(sID, "level", minLevel_X);
							
							--it doesn't match so store new one
							elseif(minLevel_X and not ISync:FetchDB(sID, "level", minLevel_X)) then
							
								ISync:SetDB(sID, "level", minLevel_X);
								
							elseif(minLevel_X and ISync:FetchDB(sID, "level", minLevel_X)) then
							
								--do nothing otherwise it will loop over and over again cause the bottom two elseif's will check
								--what we parsed, rather what we grabbed with getiteminfo
							
							--store the grabbed one
							elseif(sLVLVariable1 and not ISync:FetchDB(sID, "level")) then

								ISync:SetDB(sID, "level", sLVLVariable1);

							--if it doesn't match the one stored then update it
							elseif(sLVLVariable1 and not ISync:FetchDB(sID, "level", sLVLVariable1)) then

								ISync:SetDB(sID, "level", sLVLVariable1);
							end
				

					
					else

						--this is for tradeskill and number required
						
						_, _, sVariable2, sVariable3 = string.find(sVariable1, ISYNC_REQUIRE_FIND3);

						if( sVariable2 and sVariable3 and ISYNC_TradeSkills[sVariable2] ~= nil ) then
							
							
							if(not ISync:FetchDB(sID, "ts")) then

								ISync:SetDB(sID, "ts", ISYNC_TradeSkills[sVariable2]);

							--if it doesn't match the one stored then update it
							elseif(not ISync:FetchDB(sID, "ts", ISYNC_TradeSkills[sVariable2])) then

								ISync:SetDB(sID, "ts", ISYNC_TradeSkills[sVariable2]);
							end

						end
						
					

					end--end check for level requirement
		

				end--end variable 1 check
			
						
		end			
			

		
		--do armor types
		if(right and ISYNC_ArmorTypes[right] ~= nil) then
		
		
			if(not ISync:FetchDB(sID, "at")) then

				ISync:SetDB(sID, "at", ISYNC_ArmorTypes[right]);

			--if it doesn't match the one stored then update it
			elseif(not ISync:FetchDB(sID, "at", ISYNC_ArmorTypes[right])) then

				ISync:SetDB(sID, "at", ISYNC_ArmorTypes[right]);
			end

			
		end
		
		
		--do shield types
		if(right and ISYNC_ShieldTypes[right] ~= nil) then
		
		
			if(not ISync:FetchDB(sID, "st")) then

				ISync:SetDB(sID, "st", ISYNC_ShieldTypes[right]);

			--if it doesn't match the one stored then update it
			elseif(not ISync:FetchDB(sID, "st", ISYNC_ShieldTypes[right])) then

				ISync:SetDB(sID, "st", ISYNC_ShieldTypes[right]);
			end
			
			
		end
		
		
		
	--------------------------------------------------------	
	--------------------------------------------------------		
	end --end for
	--------------------------------------------------------	
	--------------------------------------------------------


end