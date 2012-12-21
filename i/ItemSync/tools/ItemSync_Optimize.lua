--[[--------------------------------------------------------------------------------
  ItemSync Optimize Cleaner Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]

local ISync_OptCount = 0;
local ISync_OptCount_Current = 0;
local ISync_Opt_List = { };

---------------------------------------------------
-- ISync:Optimize_Load
---------------------------------------------------
function ISync:Optimize_Load()

	--initiate the timer variables
  	ISync_Optimize_Timer.Todo = {};
  	ISync_Optimize_Timer.Todo.n = 0;
  
end


---------------------------------------------------
-- ISync:Optimize_Update()
---------------------------------------------------
function ISync:Optimize_Update()

	while(ISync_Optimize_Timer.Todo[1] and 
	
		ISync_Optimize_Timer.Todo[1].time <= GetTime()) do
		
		--load the todo variable
		local todo = table.remove(ISync_Optimize_Timer.Todo,1);
		
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
-- ISync:Optimize_Add()
---------------------------------------------------
function ISync:Optimize_Add(when,handler,...)

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
	while(ISync_Optimize_Timer.Todo[i] and
	
		--syncronize the time
		ISync_Optimize_Timer.Todo[i].time < todo.time) do
		i = i + 1;
	end
	
	--insert the finished product into the frame's todo array
	table.insert(ISync_Optimize_Timer.Todo,i,todo);

end


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------
-- ISync:Optimize
---------------------------------------------------
function ISync:Optimize(sNum)
local upNum = 0;
local sParseLink;
local storeProcessedLink;

	if(sNum == 0) then
		ISync_Optimize_Timer.Todo = {};
  		ISync_Optimize_Timer.Todo.n = 0;
  		ISync_OptCount = 0;
  		ISync_OptCount_Current = 0;
  		ISync_Opt_List = nil;
  		ISync_Opt_List = { };
  		sNum = 1; --MAKE SURE TO SET THIS TO 1
  	end


	--check on database
	if(not ISyncDB) then return nil; end --the database should have been created
	if(not ISyncDB[ISYNC_REALM_NUM]) then return nil; end --don't even bother
	if(not sNum and ISync_OptCount_Current) then sNum = ISync_OptCount_Current; end
	if(not sNum and ISync_OptCount_Current == 0) then return nil; end
	if(not ISync_Opt_List) then ISync_Opt_List = { }; end
	
	--disable the button
	ISync_OptionsOptimizeButton:Disable();
	
	--get the itemcount only if it hasn't been done already
	if(ISync_OptCount == 0) then
	
		--loop through items
		for index, value in ISyncDB[ISYNC_REALM_NUM] do
		
			--it's pointless to do subitems since they share the same basic stats
			local sParseLink = ISync:FetchDB(index, "subitem");
			
			if(not sParseLink) then --this item has no subitems, cause it's subitem value = 0
			
				table.insert(ISync_Opt_List, index..":0:0:0");
				
				ISync_OptCount = ISync_OptCount + 1;
				
			end--if(not sParseLink) then
			
		end
	
		--check for errors
		if(not ISync_OptCount) then

			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: There were no items to process.");
			end
			
			--Enable the button
			ISync_OptionsOptimizeButton:Enable();

			return nil;

		elseif(ISync_OptCount == 0) then

			if( DEFAULT_CHAT_FRAME ) then
				DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: There were no items to process.");
			end

			--Enable the button
			ISync_OptionsOptimizeButton:Enable();
			
			return nil;

		else
			--set the status bar
			ISync_Optimize_Bar:SetAlpha(1);
			ISync_Optimize_BarFrameStatusBar:SetStatusBarColor(1, 1, 0);
			ISync_Optimize_BarFrameStatusBar:SetMinMaxValues(0, ISync_OptCount);
			ISync_Optimize_Bar:Show();
		end
		
		
	
	end

	--CHECK AGAIN
	--You cannot have an element of zero
	if(sNum == 0) then sNum = 1; end


	--check count
	if(ISync_Opt_List[sNum]) then
	
		--lets do 500 of them
		for iCount=sNum , (sNum + 500) , 1 do
		
			--increment
			ISync_OptCount_Current = ISync_OptCount_Current + 1;
		
		
			--do a check
			if(ISync_Opt_List[iCount]) then
				
				--check the data
				ISync:Optimize_ChkData(ISync_Opt_List[iCount]);
			
			--it doesn't exist so lets break
			elseif(not ISync_Opt_List[iCount]) then

				break; --break the for loop and end at the bottom
			
			end
		
		
			--check to repeat
			if(ISync_Opt_List[iCount] and iCount >= (sNum + 500)) then
			
				--fix the count
				if(ISync_OptCount_Current > ISync_OptCount) then 
					ISync_Optimize_BarText:SetText( ISync_OptCount.."/"..ISync_OptCount );
				else
					ISync_Optimize_BarText:SetText( ISync_OptCount_Current.."/"..ISync_OptCount );
				end
			
				--do the value
				ISync_Optimize_BarFrameStatusBar:SetValue(ISync_OptCount_Current);
			
				ISync:Optimize_Add(7, ISync.Optimize, ISync_OptCount_Current);

				return nil;
				
			end
		
		
		
		
		end--for iCount=sNum , (sNum + 500) , 1 do
	
	end--if(ISync_Opt_List[sNum]) then


	--clear out
	ISync_Opt_List = nil;

	ISync_Optimize_BarText:SetText( ISync_OptCount_Current.."/"..ISync_OptCount );
	ISync_Optimize_BarFrameStatusBar:SetValue(ISync_OptCount_Current);
	ISync_Optimize_Bar:Hide(); --hide it

	DEFAULT_CHAT_FRAME:AddMessage("|c0000FF00ItemSync: "..ISYNC_OPTIMIZE_COMPLETE.."!");

	--Enable the button
	ISync_OptionsOptimizeButton:Enable();

end



---------------------------------------------------
-- ISync:Optimize_ChkData()
---------------------------------------------------
function ISync:Optimize_ChkData(sName)

	if(not sName) then return nil; end
	
	--attach variable
	local index = sName;
	local sParseLink;
	local storeProcessedLink;
	local storeLink;
	
	---------------------------------------------------------------------------
	if(index) then

		--check link
		local name_X, link_X, quality_X, minLevel_X, class_X, subclass_X, maxStack_X = GetItemInfo("item:"..index);

		if(sName and link_X) then

			ISync:Do_Parse(UIParent, ISyncTooltip, ISync:GetCoreID(index), link_X);

		end--if(name_X and link_X and ISYNC_REALM_NUM) then


	end
	------------------------------------------------------------------------------


end

