--[[--------------------------------------------------------------------------------
  ItemSync Invalid Cleaner Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

local ISync_InvC_Count = 0;
local ISync_InvC_Count_Current = 0;
local ISync_InvClean_List = { };

---------------------------------------------------
-- ISync:InvCleaner_Load
---------------------------------------------------
function ISync:InvCleaner_Load()

	--initiate the timer variables
  	ISync_InvCleaner_Timer.Todo = {};
  	ISync_InvCleaner_Timer.Todo.n = 0;
  
end


---------------------------------------------------
-- ISync:InvCleaner_Update()
---------------------------------------------------
function ISync:InvCleaner_Update()

	while(ISync_InvCleaner_Timer.Todo[1] and 
	
		ISync_InvCleaner_Timer.Todo[1].time <= GetTime()) do
		
		--load the todo variable
		local todo = table.remove(ISync_InvCleaner_Timer.Todo,1);
		
		--check if there are arguments if so then load them
		if(todo.args) then
			todo.handler(unpack(todo.args));
		--otherwise run the function
		else
			todo.handler();
		end--if(todo.args) then
		
	end--end while
	
end


---------------------------------------------------
-- ISync:InvCleaner_Add()
---------------------------------------------------
function ISync:InvCleaner_Add(when,handler,...)

	--load the todo variable
	local todo = {};
	local i = 1;

	--set the time so that we can determine time passed later
	todo.time = when + GetTime();
	--save the handler for processing later
	todo.handler = handler;
	--save the arguements if there are any
	todo.args = arg;
	
	--start the while loop
	while(ISync_InvCleaner_Timer.Todo[i] and
	
		--syncronize the time
		ISync_InvCleaner_Timer.Todo[i].time < todo.time) do
		i = i + 1;
	end
	
	--insert the finished product into the frame's todo array
	table.insert(ISync_InvCleaner_Timer.Todo,i,todo);

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------
-- ISync:InvCleaner
---------------------------------------------------
function ISync:InvCleaner(sNum)
local upNum = 0;
local sParseLink;
local storeProcessedLink;

	if(sNum == 0) then
		ISync_InvCleaner_Timer.Todo = {};
  		ISync_InvCleaner_Timer.Todo.n = 0;
  		ISync_InvC_Count = 0;
  		ISync_InvC_Count_Current = 0;
  		ISync_InvClean_List = nil;
  		ISync_InvClean_List = { };
  		sNum = 1; --MAKE SURE TO SET THIS TO 1
  	end


	--check on database
	if(not ISyncDB) then return nil; end --the database should have been created
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end --don't even bother
	if(not sNum and ISync_InvC_Count_Current) then sNum = ISync_InvC_Count_Current; end
	if(not sNum and ISync_InvC_Count_Current == 0) then return nil; end
	if(not ISync_InvClean_List) then ISync_InvClean_List = { }; end
	
	--disable the button
	ISYNC_Options_CleanerButton:Disable();
	
	--get the itemcount only if it hasn't been done already
	if(ISync_InvC_Count == 0) then
	
		ISync_InvC_Count = ISync:InvClean_Randomize(); --randomize the information

		--check for errors
		if(not ISync_InvC_Count) then

			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: There were no items to process.");
			end
			
			--Enable the button
			ISYNC_Options_CleanerButton:Enable();

			return nil;

		elseif(ISync_InvC_Count == 0) then

			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: There were no items to process.");
			end

			--Enable the button
			ISYNC_Options_CleanerButton:Enable();
			
			return nil;

		else
			--set the status bar
			ISync_InvCleaner_Bar:SetAlpha(1);
			ISync_InvCleaner_BarFrameStatusBar:SetStatusBarColor(1, 0, 0);
			ISync_InvCleaner_BarFrameStatusBar:SetMinMaxValues(0, ISync_InvC_Count);
			ISync_InvCleaner_Bar:Show();
		end
		
		
	
	end

	--CHECK AGAIN
	--You cannot have an element of zero
	if(sNum == 0) then sNum = 1; end


	--check count
	if(ISync_InvClean_List[sNum]) then
	
		--lets do 30 of them
		for iCount=sNum , (sNum + 30) , 1 do
		
			--increment
			ISync_InvC_Count_Current = ISync_InvC_Count_Current + 1;
		
		
			--do a check
			if(ISync_InvClean_List[iCount]) then
				
				--check the data
				ISync:InvCleaner_ChkData(ISync_InvClean_List[iCount]);
			
			--it doesn't exist so lets break
			elseif(not ISync_InvClean_List[iCount]) then

				break; --break the for loop and end at the bottom
			
			end
		
		
			--check to repeat
			if(ISync_InvClean_List[iCount] and iCount >= (sNum + 30)) then
			
				--fix the count
				if(ISync_InvC_Count_Current > ISync_InvC_Count) then 
					ISync_InvCleaner_BarText:SetText( ISync_InvC_Count.."/"..ISync_InvC_Count );
				else
					ISync_InvCleaner_BarText:SetText( ISync_InvC_Count_Current.."/"..ISync_InvC_Count );
				end
			
				--do the value
				ISync_InvCleaner_BarFrameStatusBar:SetValue(ISync_InvC_Count_Current);
			
				ISync:InvCleaner_Add(7, ISync.InvCleaner, ISync_InvC_Count_Current);

				return nil;
				
			end
		
		
		
		
		end--for iCount=sNum , (sNum + 30) , 1 do
	
	end--if(ISync_InvClean_List[sNum]) then


	--clear out
	ISync_InvClean_List = nil;

	ISync_InvCleaner_BarText:SetText( ISync_InvC_Count_Current.."/"..ISync_InvC_Count );
	ISync_InvCleaner_BarFrameStatusBar:SetValue(ISync_InvC_Count_Current);
	ISync_InvCleaner_Bar:Hide(); --hide it

	DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: "..ISYNC_CLEANER_COMPLETE);

	--Enable the button
	ISYNC_Options_CleanerButton:Enable();

end



---------------------------------------------------
-- ISync:InvCleaner_ChkData()
---------------------------------------------------
function ISync:InvCleaner_ChkData(sIndex)


	if(not sIndex) then return nil; end
	
	--attach variable
	local sParseLink;
	local storeProcessedLink;
	local storeLink;
	
	---------------------------------------------------------------------------
	if(sIndex) then

		--check link
		local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..sIndex);

		if(not name_X or not link_X) then

			UIParent.TooltipButton = this:GetID();
			ISyncTooltip:SetOwner(this, "ANCHOR_RIGHT");
			ISyncTooltip:SetHyperlink("item:"..sIndex);
			ISyncTooltip:Show();

		end--if(name_X and link_X and ISYNC_REALM_NUM) then


	end
	------------------------------------------------------------------------------


end




--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------
-- ISync:InvClean_Randomize()
---------------------------------------------------
function ISync:InvClean_Randomize()

	ISync_InvClean_List = { }; --reset
	ISync_InvC_Count = 0;
	
	for index, value in ISyncDB[ISYNC_REALM_NUM] do

		--check for number
		if(tonumber(index)) then
		
			--it's pointless to do subitems since they share the same basic stats
			local sParseLink = ISync:FetchDB(index, "subitem");

			if(not sParseLink) then --this item has no subitems, cause it's subitem value = 0

				local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:0:0");

				if(not name_X or not link_X) then
					table.insert(ISync_InvClean_List, link_X);
					ISync_InvC_Count = ISync_InvC_Count + 1;
				end

			else

				---------------------------------------
				--make sure it's a table
				if(type(sParseLink) == "table") then

					for qindex, qvalue in sParseLink do

						--check
						local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index..":0:"..qvalue..":0");

						--do we have a valid item?
						if(not name_X or not link_X) then

							table.insert(ISync_InvClean_List, link_X);
							ISync_InvC_Count = ISync_InvC_Count + 1;
						end

					end--for qindex, qvalue in sParseLink do

				end--if(type(sParseLink) == "table") then
				---------------------------------------

			end--if(not sParseLink) then

		end

	end
	
	--check
	if(getn(ISync_InvClean_List) <= 0) then return nil; end
	
	
	--Now randomize the next table using the gathered one. This will prevent disconnections on the same item over and over.
	local iChk = 1;
	local sTempDB = { };
	local sNumRand = 0;
	
	--loop
	while iChk>0 do
		
		if(not ISync_InvClean_List or getn(ISync_InvClean_List) <= 0) then iChk = 0; end --reset
		
		--check
		if(iChk == 1) then
		
			sNumRand = math.random(1, getn(ISync_InvClean_List));

			--add it to the temp list
			table.insert(sTempDB, ISync_InvClean_List[sNumRand]);

			--remove it from old list
			table.remove(ISync_InvClean_List,sNumRand);
		
		end
	end

	
	--now replace the old with new
	ISync_InvClean_List = nil;
	ISync_InvClean_List = sTempDB;
	sTempDB = nil;
	
	
	return ISync_InvC_Count;
	
end