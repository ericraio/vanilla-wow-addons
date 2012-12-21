----------------------------------------------------------------------
-- TitanGuildPaging.lua
-- code for paging data in the right-click menus and tooltip
----------------------------------------------------------------------

----------------------------------------------------------------------
--  TitanPanelGuildButton_InitPaging()
--  init the paging vars when the guild status changes
----------------------------------------------------------------------
function TitanPanelGuildButton_InitPaging()
	currIndex = 1;
	maxIndex = TITAN_GUILD_LIST_THRESHOLD;
	numGuildOnline = 0;
	numGuildOnlineFiltered = 0;
	numPages = 0;
	currPage = 1;
	pagingRemainder = 0;
end

----------------------------------------------------------------------
--  TitanPanelGuildButton_ComputePages()
--  uses the global numGuildOnline count to determine paging
----------------------------------------------------------------------
function TitanPanelGuildButton_ComputePages()
	local counterToUse = numGuildOnline;
	-- if contents are filtered, then use the filtered count
	if (numGuildOnlineFiltered > 0) then
		counterToUse = numGuildOnlineFiltered;
	end
	-- determine the number of pages are required to render online members
	pagingRemainder = (math.mod(counterToUse,TITAN_GUILD_LIST_THRESHOLD));
	-- compute pages
	if (pagingRemainder ~= 0) then
		numPages = ((counterToUse-pagingRemainder) / TITAN_GUILD_LIST_THRESHOLD)+1;
	else
		numPages = counterToUse / TITAN_GUILD_LIST_THRESHOLD;
	end
	--guildPrintDebugMessage("numPages: "..numPages);
end

----------------------------------------------------------------------
--  TitanPanelGuildButton_ComputeAdvancedPages(numInRank)
--  uses the global numGuildOnline count to determine paging for adv menus
----------------------------------------------------------------------
function TitanPanelGuildButton_ComputeAdvancedPages(numInRank)
	-- note: contents of mastertable are pre-filtered
	-- determine the number of pages are required to render online members
	pagingRemainder = (math.mod(numInRank,TITAN_GUILD_LIST_THRESHOLD));
	-- compute pages
	if (pagingRemainder ~= 0) then
		numPages = ((numInRank-pagingRemainder) / TITAN_GUILD_LIST_THRESHOLD)+1;
	else
		numPages = numInRank / TITAN_GUILD_LIST_THRESHOLD;
	end
	--guildPrintDebugMessage("numPages (adv): "..numPages);
end



----------------------------------------------------------------------
--  TitanPanelGuildButton_ComputeOnlineGuildMembers()
--  used to number of online guild members
----------------------------------------------------------------------
function TitanPanelGuildButton_ComputeOnlineGuildMembers()
	local NumGuild = 0;
	if (IsInGuild()) then
		NumGuild = GetNumGuildMembers();
		for guildIndex=1, NumGuild do
			guild_name, guild_rank, guild_rankIndex, guild_level, guild_class, guild_zone, guild_note, guild_officernote, guild_online, guild_status = GetGuildRosterInfo(guildIndex);
			if ( guild_online == 1 ) then
				numGuildOnline = numGuildOnline + 1;
				if (TitanGetVar(TITAN_GUILD_ID, "FilterMyLevel") or TitanGetVar(TITAN_GUILD_ID, "FilterMyZone") or TitanGetVar(TITAN_GUILD_ID, "FilterClasses")) then
					if (TitanPanelGuildButton_IsPassFilter(guild_zone, guild_level, guild_class)) then
						numGuildOnlineFiltered = numGuildOnlineFiltered + 1;
					end
				end
			end
		end
	end
	--guildPrintDebugMessage("numGuildOnline: "..numGuildOnline);
	--guildPrintDebugMessage("numGuildOnlineFiltered: "..numGuildOnlineFiltered);
end

----------------------------------------------------------------------
--  TitanPanelGuildButton_PageForward()
--  move paging vars forward
----------------------------------------------------------------------
function TitanPanelGuildButton_PageForward()
	currPage = currPage + 1;
	currIndex = currIndex + TITAN_GUILD_LIST_THRESHOLD;
	maxIndex = maxIndex + TITAN_GUILD_LIST_THRESHOLD;
	--guildPrintDebugMessage("currIndex: "..currIndex);
	--guildPrintDebugMessage("maxIndex: "..maxIndex);
	--guildPrintDebugMessage("currPage: "..currPage);
end

----------------------------------------------------------------------
--  TitanPanelGuildButton_PageBackward()
--  moving paging vars backward
----------------------------------------------------------------------
function TitanPanelGuildButton_PageBackward()
	currPage = currPage - 1;
	currIndex = currIndex - TITAN_GUILD_LIST_THRESHOLD;
	maxIndex = maxIndex - TITAN_GUILD_LIST_THRESHOLD;
	--guildPrintDebugMessage("currIndex: "..currIndex);
	--guildPrintDebugMessage("maxIndex: "..maxIndex);
	--guildPrintDebugMessage("currPage: "..currPage);
end

----------------------------------------------------------------------
--  TitanPanelGuildButton_BuildForwardPageControl()
--  render menu control for forward
----------------------------------------------------------------------
function TitanPanelGuildButton_BuildForwardPageControl()
	-- examine current page
	-- are there additional pages?
	-- yes: render the control
	if (numPages > currPage) then
		-- on the last page?
		if (numPages ~= currPage) then
			local forwardText = TitanUtils_GetColoredText(TITAN_GUILD_MENU_FORWARD_TEXT, { r=.25,g=.5,b=.85 });
			TitanPanelRightClickMenu_AddCommand(forwardText, TITAN_GUILD_ID, TITAN_GUILD_BUTTON_FORWARDPAGE, UIDROPDOWNMENU_MENU_LEVEL);	
		end
	end
end

----------------------------------------------------------------------
--  TitanPanelGuildButton_BuildBackwardPageControl()
--  render menu control for backward
----------------------------------------------------------------------
function TitanPanelGuildButton_BuildBackwardPageControl()
	-- examine the current page
	-- on the first page?
	-- no: render the control
	if (currPage ~= 1) then
		local backwardText = TitanUtils_GetColoredText(TITAN_GUILD_MENU_BACKWARD_TEXT, { r=.25,g=.5,b=.85 });
		TitanPanelRightClickMenu_AddCommand(backwardText, TITAN_GUILD_ID, TITAN_GUILD_BUTTON_BACKWARDPAGE, UIDROPDOWNMENU_MENU_LEVEL);	
	end
end