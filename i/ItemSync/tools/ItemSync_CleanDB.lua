--[[--------------------------------------------------------------------------------
  ItemSync CleanupDB Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]



---------------------------------------------------
-- ISync:CleanupDB()
---------------------------------------------------
function ISync:CleanupDB(sForce, sOpt)

	if( not ISyncDB ) then return nil; end
	if( not ISyncDB[ISYNC_REALM_NUM]) then return nil; end
	if( not ISyncOpt["REALMS"] or not ISyncOpt["REALMS"]["REALMCOUNT"]) then return nil; end

	--save the old realm
	local saveOld_Realm = ISYNC_REALM_NUM;
	
	--loop through all the databases
	for i = 0, ISyncOpt["REALMS"]["REALMCOUNT"] , 1 do
	---------------------------------
	
		ISYNC_REALM_NUM = i; --set the current realm
		
		--do the loop
		for qIndex, qValue in ISyncDB[ISYNC_REALM_NUM] do

			--avoid the extremely old database
			if(qIndex and tonumber(qIndex)) then
				--do nothing
			else

				local sParseLink = string.gsub(qIndex, "^(%d+):(%d+):(%d+):(%d+)$", "%1");

				if(sParseLink and tonumber(sParseLink)) then --numbered system so were okay				
				
					--do nothing
				else
					--================================================================
					--ITEMID
					--start the converting process
					local s1, s2, sParseInfo = string.find(qValue, "»(.-)»"); --ITEMID


					local sID1, sID2, sGrabLink;
					local sChk = 0;

					--store the ITEMID
					if(sParseInfo) then

						--fix the itemid and remove the second and last digit
						sGrabLink = string.gsub(sParseInfo, "^(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:0");

						if(sGrabLink) then

							sID1 = string.gsub(sGrabLink, "^(%d+):(%d+):(%d+):(%d+)$", "%1");
							sID2 = string.gsub(sGrabLink, "^(%d+):(%d+):(%d+):(%d+)$", "%3");

							--if we got both numbers then continue
							if(sID1 and sID2 and tonumber(sID1) and tonumber(sID2)) then sChk = 1; end

						end

					end
					--================================================================


					--only allow if we have something to work with
					if(sChk == 1) then

						sChk = 0; --reset
						sID1 = tonumber(sID1);
						sID2 = tonumber(sID2);


						--check to see if we already have it
						if(ISyncDB[ISYNC_REALM_NUM][sID1]) then

							--just add the subitem if we have one
							ISync:SetDB(sID1, "subitem", sID2);

							sChk = 0;

						else

							if(sID2 ~= 0 and not ISync:FetchDB(sID1, "subitem", sID2)) then

								--add it new if we have one
								ISync:SetDB(sID1, "subitem", sID2);

							end

							sChk = 1;
						end



						if(sChk == 1) then

							--================================================================
							--INFO
							--start the converting process
							local s1, s2, sParseInfo = string.find(qValue, "¤(.-)¤");

							if(sParseInfo) then

								local yArray = ISync:SplitData(sParseInfo, ":");

								if(yArray) then

									--loop through
									for sKey, sVar in yArray do

										if(sKey == 1) then ISync:SetDB(sID1, "quality", sVar); end
										if(sKey == 2) then ISync:SetDB(sID1, "price", sVar); end
										if(sKey == 3) then ISync:SetDB(sID1, "wl", sVar); end
										if(sKey == 4) then ISync:SetDB(sID1, "wt", sVar); end
										if(sKey == 5) then ISync:SetDB(sID1, "ts", sVar); end
										if(sKey == 6) then ISync:SetDB(sID1, "at", sVar); end
										if(sKey == 7) then ISync:SetDB(sID1, "st", sVar); end
										if(sKey == 8) then ISync:SetDB(sID1, "level", sVar); end
										if(sKey == 9) then ISync:SetDB(sID1, "vendor", sVar); end
										if(sKey == 10) then ISync:SetDB(sID1, "vendorqty", sVar); end

									end

								end




							end
							--================================================================

							--================================================================
							--IDCHK
							--start the converting process
							local s1, s2, sParseInfo = string.find(qValue, "§(.-)§");

							if(sParseInfo) then ISync:SetDB(sID1, "idchk", sParseInfo); end

							--================================================================


							--================================================================
							--SUBITEM
							--convert old subitems to independent items
							local s1, s2, sParseInfo = string.find(qValue, "®(.-)®");

							if(sParseInfo) then 

								local qArray = ISync:SplitData(sParseInfo, "º");

								if(qArray) then

									local qID1, qID2;

									for qKey, qVar in qArray do

										qID1 = string.gsub(qVar, "^(%d+):(%d+):(%d+):(%d+)$", "%1");
										qID2 = string.gsub(qVar, "^(%d+):(%d+):(%d+):(%d+)$", "%3");

										--check
										if(qID1 and qID2 and tonumber(qID1) and tonumber(qID2)) then

											--create new and copy from the parent item
											ISyncDB[ISYNC_REALM_NUM][tonumber(qID1)] = ISyncDB[ISYNC_REALM_NUM][tonumber(sID1)];

											--store the subitem if we have one
											ISync:SetDB(qID1, "subitem", qID2);
										end


									end--for sKey, sVar in yArray do

								end--if(yArray) then

							end

							--================================================================


						end--if(sChk == 1) then

					end--if(sChk == 1) then




					--========================================================================================
					--========================================================================================
					--========================================================================================
					--========================================================================================

					--NEW CLEANUP FUNCTIONS AFTER VERSION 12


					--========================================================================================
					--========================================================================================
					--========================================================================================
					--========================================================================================


				end--if(sParseLink and tonumber(sParseLink)) then


			end--if(qIndex and tonumber(qIndex)) then


		end--for qIndex, qValue in ISyncDB[ISYNC_REALM_NUM] do
	

		--check if we need to delete
		if(sForce and sForce == 1) then

			--delete the rows where the key isn't a number
			for qIndex, qValue in ISyncDB[ISYNC_REALM_NUM] do

				if(not tonumber(qIndex)) then
					ISyncDB[ISYNC_REALM_NUM][qIndex] = nil;
				end
			end
		end


		
		---------------------------------
		--check multiple subitems
		for qIndex, qValue in ISyncDB[ISYNC_REALM_NUM] do
		
			--make sure we have a numbered index
			if(tonumber(qIndex)) then
			
				local yArray = ISync:FetchDB(qIndex, "subitem");
				
				--only do if we have subitems to work with
				if(yArray) then
				
					local list = { }; --temp
					local chkReplace = 0;

					--loop and add to temp, same numbers will just be replaced, thus removing duplicates
					for sKey, sVar in yArray do
						
						if(list[sVar]) then chkReplace = 1; end --turn on replace if we detected one
						
						list[sVar] = 1; --add to temp array
					end
					
					if(chkReplace == 1) then
					
						local subItemStr; --temp

						--loop again to create the string
						for xKey, xVar in list do
						
							if(not subItemStr) then 
								subItemStr = xKey;
							elseif(subItemStr) then 
								subItemStr = subItemStr.."º"..xKey;
							end
						end
						
						--fix it
						ISync:SetDB(qIndex, "subitem", subItemStr, "REPLACE");
						
						subItemStr = nil;
					
					end--chkReplace
					
		
					list = nil;
		
				end--if(yArray) then
			
			end--if(tonumber(qIndex)) then
		
		end--for qIndex, qValue in ISyncDB[ISYNC_REALM_NUM] do
		---------------------------------
		
		
	---------------------------------
	end--for i = 0, ISyncOpt["REALMS"]["REALMCOUNT"] , 1 do
	
	
	--return the old realm number
	ISYNC_REALM_NUM = saveOld_Realm;
	
	--show message
	DEFAULT_CHAT_FRAME:AddMessage("|c00A2D96FItemSync: |cffffffff"..ISYNC_CLEAN_SUCCESS.."|r");


end

