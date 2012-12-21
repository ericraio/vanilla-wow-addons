SA_LIST_BOXES = {};

-- TODO: incombat interval ja outofcombat interval! performance++ =)

SA_REFRESHRATE = 1.5;

SA_BASERATE = 0.6;
SA_INCREASE = 0.1; -- how much to decrease refresh rate per mob
SA_LASTREFRESH = SA_BASERATE;

SA_SEMIALERT = "|cffffa303";
SA_ALERTCOL = "|cffff0000";
SA_TANKCOL = "|cff00ff00";

-- title modes

MODE_OOC = 1;
MODE_NORMAL = 2;
MODE_FILTERED = 3;
MODE_PAUSED = 4;
MODE_NEAREST = 5;
MODE_OVERLOADED = 10;

-- contains all data from last update

SA_PREV = {
	["aggro_count"] = 0,
	["mob_count"] = 0,
	["wb_count"] = 0,
	["title_mode"] = -1,
	["dirty"] = false
};

-- class icon texture coordinates

SA_TEXTCOORDS={};
SA_TEXTCOORDS["PRIEST"]	 = { left=0.50, right=0.75, top=0.25, bottom=0.50 };
SA_TEXTCOORDS["MAGE"]    = { left=0.25, right=0.50, top=0.00, bottom=0.25 };
SA_TEXTCOORDS["WARLOCK"] = { left=0.75, right=1.00, top=0.25, bottom=0.50 };
SA_TEXTCOORDS["DRUID"] 	 = { left=0.75, right=1.00, top=0.00, bottom=0.25 };
SA_TEXTCOORDS["HUNTER"]  = { left=0.00, right=0.25, top=0.25, bottom=0.50 };
SA_TEXTCOORDS["ROGUE"] 	 = { left=0.50, right=0.75, top=0.00, bottom=0.25 };
SA_TEXTCOORDS["WARRIOR"] = { left=0.00, right=0.25, top=0.00, bottom=0.25 };
SA_TEXTCOORDS["SHAMAN"]	 = { left=0.25, right=0.50, top=0.25, bottom=0.50 };
SA_TEXTCOORDS["PALADIN"] = { left=0.00, right=0.25, top=0.50, bottom=0.75 };

-- predefined icon locations

SA_ICONPOS={n=8};
SA_ICONPOS[1] = { name="Disabled", point="TOPLEFT", relativePoint="", x=-26, y=-28, width=25, height=25 };
SA_ICONPOS[2] = { name="Left bottom", point="TOPLEFT", relativePoint="", x=-26, y=-28, width=25, height=25 };
SA_ICONPOS[3] = { name="Left top", point="TOPLEFT", relativePoint="", x=-26, y=-3, width=25, height=25};
SA_ICONPOS[4] = { name="Inside box", point="BOTTOMRIGHT", relativePoint="", x=0, y=0, width=25, height=25};
SA_ICONPOS[5] = { name="Right bottom", point="TOPRIGHT", relativePoint="", x=26, y=-28, width=25, height=25 };
SA_ICONPOS[6] = { name="Right top", point="TOPRIGHT", relativePoint="", x=26, y=-3, width=25, height=25};
SA_ICONPOS[7] = { name="Left big", point="TOPLEFT", relativePoint="", x=-51, y=-3, width=50, height=50};
SA_ICONPOS[8] = { name="Right big", point="TOPRIGHT", relativePoint="", x=51, y=-3, width=50, height=50};


------------------------------------------------------------------------------

function SA_InitBar(bar, text)
	bar:SetMinMaxValues(0, 100);
	bar:SetValue(100);
	text:SetHeight(12);
	text:SetPoint("CENTER", bar:GetName(), "CENTER", 0, 0);
	SetTextStatusBarText(bar, text);
	ShowTextStatusBarText(bar);
end

function SA_List_OnLoad()
	-- initialize boxes
	for i=1, 10 do
		local box = {};
		box["frame"] = getglobal("Target"..i);
		box["mobText"] = getglobal("Target"..i.."MobText");
		box["targetText"] = getglobal("Target"..i.."TargetText");
		box["targetOf"] = getglobal("Target"..i.."TargetOf");
		box["mobBar"] = getglobal("Target"..i.."MobBar");
		box["targetBar"] = getglobal("Target"..i.."TargetBar");
		box["classIcon"] = getglobal("Target"..i.."ClassIcon");
		box["targetIcon"] = getglobal("Target"..i.."TargetIcon");
		box["huntersMarkIcon"] = getglobal("Target"..i.."HuntersMarkIcon");
		SA_LIST_BOXES[i] = box;
	end
end

function SA_List_OnShow()
	-- TODO: this should be done only if options altered from xml defaults
	SA_List_UpdateAppearance();
	
	if (SA_OPTIONS.ListScale ~= 1.0) then
		SAListFrameScaler:SetScale(SA_OPTIONS.ListScale);
	end
	
	-- set title button to correct mode
	SA_List_SetTitleButton(MODE_OOC);
end

------------------------------------------------------------------------------
-- initialize list dropdown menu
------------------------------------------------------------------------------

function SA_List_FrameDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, SA_List_FrameDropDown_Initialize, "MENU");
end

------------------------------------------------------------------------------
-- note: this is called always when dropdown is shown!
------------------------------------------------------------------------------

function SA_List_FrameDropDown_Initialize()
	if (not SA_OPTIONS) then 
		-- options not available yet (onload event) -> abort
		return;
	end

	item = {};
	item.text = "Filter targets";
	if (SA_OPTIONS.Filter) then
		item.checked = 1;
	end
	item.func = SA_List_Menu_Filter;
	UIDropDownMenu_AddButton(item);

	item = {};
	item.text = "Assist with pet";
	if (SA_OPTIONS.AutoPetAttack) then
		item.checked = 1;
	end
	item.keepShownOnClick = 1;
	item.func = SA_List_Menu_AssistWithPet;
	UIDropDownMenu_AddButton(item);
	
	item = {};
	item.text = "Assist only players nearby (28 yards)";
	if (SA_OPTIONS.AssistOnlyNearest) then
		item.checked = 1;
	end
	item.func = SA_List_Menu_AssistOnlyNearest;
	UIDropDownMenu_AddButton(item);

	item = {};
	item.text = "Display out of combat targets";
	item.checked = SA_OPTIONS.OutOfCombat;
	item.func = SA_List_Menu_ShowOOC;
	UIDropDownMenu_AddButton(item);

	item = {};
	item.text = "Lock list position";
	item.func = SA_List_Menu_Lock;
	item.checked = SA_OPTIONS.LockList;
	UIDropDownMenu_AddButton(item);
	
	item = {};
	item.text = "SmartAssist options";
	item.notCheckable = 1;
	item.func = SA_ShowOptions;
	UIDropDownMenu_AddButton(item);
end

function SA_List_Menu_Lock()
	SA_ToggleOption("LockList");
end

function SA_List_Menu_AssistWithPet()
	SA_ToggleOption("AutoPetAttack");
end

function SA_List_Menu_AssistOnlyNearest()
	SA_ToggleOption("AssistOnlyNearest");
	if (SA_OPTIONS.AssistOnlyNearest) then
		printInfo("Assisting only players nearby");
	end
end

function SA_List_Menu_ShowOOC()
	SA_ToggleOption("OutOfCombat");
end

function SA_List_Menu_Filter()
	if (SA_OPTIONS.Filter == nil) then
		SAFilterFrame:Show();
	else
		SA_OPTIONS.Filter = nil;
		printInfo("Filtering disabled");
		SA_List_SetTitleButton(MODE_OOC);
	end;
end

function SA_List_FilterButtonOK_OnClick()
	local text = SAFilterEditBox:GetText();
	if (string.len(text) > 0) then
		SA_OPTIONS.Filter = string.lower(text);
		printInfo("SmartAssist will now ignore targets which name doesn't contain text '"..text.."' until you disable filtering. Note that filtering applies only assisting, it doesn't include fallback to nearest.");
		SA_List_SetTitleButton(MODE_FILTERED);
	else
		SA_OPTIONS.Filter = nil;
		printInfo("Filtering disabled");
		SA_List_SetTitleButton(MODE_OOC);
	end
	SAFilterFrame:Hide();
end

------------------------------------------------------------------------------
-- Title button clicked (show menu) or drag
-- kudos goes for DamageMeters
------------------------------------------------------------------------------

function SA_List_TitleButton_OnClick()
	local button = arg1;
	if ( button  == "LeftButton" and not SA_OPTIONS.LockList) then
		-- drag frame
		if ( this:GetButtonState() == "PUSHED" ) then
			SAListFrame:StopMovingOrSizing();
		else
			SAListFrame:StartMoving();
		end
	elseif ( button == "RightButton" ) then
		-- show menu
		ToggleDropDownMenu(1, nil, SAListFrameDropDown, "SAListFrameDropDown", -33, 25);
	end
end

------------------------------------------------------------------------------
-- change outlook for the list depending options
------------------------------------------------------------------------------

function SA_List_HasSideIcons()
	if (SA_OPTIONS.ClassIconMode==2 or SA_OPTIONS.ClassIconMode==3 or
		SA_OPTIONS.TargetIconMode==2 or SA_OPTIONS.TargetIconMode==3 or
		SA_OPTIONS.HuntersMarkIconMode==2 or SA_OPTIONS.HuntersMarkIconMode==3) 
	then
		return true;
	end
end

function SA_List_UpdateAppearance()
	local width = SA_OPTIONS.ListWidth;
	
	local x = 0;
	local y = 0;
	if (SA_OPTIONS.ListHorizontal) then
		-- horizontal
		local gap = 10;
		if (SA_List_HasSideIcons()) then
			gap = gap - 30;
		end
		if (SA_OPTIONS.ListSpacing > 0) then
			x = width - gap + SA_OPTIONS.ListSpacing;
		else
			x = - (width - gap - SA_OPTIONS.ListSpacing);
		end
	else
		-- vertical
		local height = ceil(Target1:GetHeight()) - 8;
		if (SA_OPTIONS.ListSpacing > 0) then
			y = height + SA_OPTIONS.ListSpacing;
		else
			y = - (height-SA_OPTIONS.ListSpacing);
		end
	end
	
	SAListFrame:SetWidth(width);
	SAListTitleButton:SetWidth(width);
	
	local anchor="TOPLEFT";
	for i,box in SA_LIST_BOXES do
		if (i==1) then
			-- first box is ancored to title
			if (y<=0) then
				box.frame:SetPoint(anchor, "SAListFrame", anchor, 0, -17);
			else
				box.frame:SetPoint(anchor, "SAListFrame", anchor, 0, 54);
			end
		elseif (i==6 and SA_OPTIONS.ListTwoRow) then
			-- two rows
			if (SA_OPTIONS.ListHorizontal) then
				local gap = SA_OPTIONS.ListSpacing;
				if (gap>0) then
					gap = -gap;
				end
				gap = gap + 10;
				box.frame:SetPoint(anchor, "Target1", "BOTTOMLEFT", 0, gap);
			else
				local gap = SA_OPTIONS.ListSpacing;
				if (gap<0) then
					gap = -gap;
				end
				gap = gap - 8;
				-- if icons visible next to box
				if (SA_List_HasSideIcons()) then
					gap = gap + 30;
				end
				box.frame:ClearAllPoints();
				box.frame:SetPoint(anchor, "Target1", "TOPRIGHT", gap, 0);
			end
		else
			-- rest are anchored to previous box
			box.frame:ClearAllPoints();
			box.frame:SetPoint(anchor, "Target"..i-1, anchor, x, y);
		end
		
		box.frame:SetWidth(width);
		-- scale inside elements width
		box.mobBar:SetWidth(width-20);
		box.targetBar:SetWidth(width-20);
		box.mobText:SetWidth(width-30);
		box.targetText:SetWidth(width-30);

		-- update display targeted by stuff
		box.targetOf:SetWidth(width-20);
		
		-- set texts alpha
		box.mobText:SetAlpha(SA_OPTIONS.TextAlpha);
		box.targetText:SetAlpha(SA_OPTIONS.TextAlpha);
		
		-- set icon positions
		if (SA_OPTIONS.ClassIconMode>1) then
			local icon = SA_ICONPOS[SA_OPTIONS.ClassIconMode];
			SA_List_UpdateIconAppearance(box.classIcon, i, icon);
		else
			box.classIcon:Hide();
		end
		
		if (SA_OPTIONS.TargetIconMode>1) then
			local icon = SA_ICONPOS[SA_OPTIONS.TargetIconMode];
			SA_List_UpdateIconAppearance(box.targetIcon, i, icon);
		else
			box.targetIcon:Hide();
		end
		
		if (SA_OPTIONS.HuntersMarkIconMode>1) then
			local icon = SA_ICONPOS[SA_OPTIONS.HuntersMarkIconMode];
			SA_List_UpdateIconAppearance(box.huntersMarkIcon, i, icon);
		else
			box.huntersMarkIcon:Hide();
		end
		
	end
end

-- helper function, updates icon appearance
function SA_List_UpdateIconAppearance(frame, i, icon)
	frame:ClearAllPoints();
	frame:SetPoint(icon.point, "Target"..i, icon.point, icon.x, icon.y);
	frame:SetWidth(icon.width);
	frame:SetHeight(icon.height);
	frame:Show();
end

------------------------------------------------------------------------------
-- Refresh the list if enough time has passed since last refresh
------------------------------------------------------------------------------

function SA_List_OnUpdate(elapsed)
	SA_LASTREFRESH = SA_LASTREFRESH - elapsed;
	if (SA_LASTREFRESH > 0) then
		return;
	end
	SA_LASTREFRESH = SA_BASERATE + (SA_INCREASE * SA_PREV.mob_count);
	SA_List_Update();
end

local TARGET_CLICKED = time()
function SA_List_Target_OnClick(arg)
	SA_Debug("TargetClick");
	TARGET_CLICKED = time();
	local target = arg.obj;
	if (not target) then printInfo("SmartAssist: Unknown target?"); return; end;
    -- if ctrl+alt is down paste all targetters names (except tanks) to chat
    if (IsControlKeyDown() and IsAltKeyDown()) then
    	local names = "";
    	local i = 0;
    	for _,c in target.players do
    		if (not SA_IsTank(c.unitName)) then
    			names = names..c.unitName..", ";
    			i = i + 1;
    		end;
    	end
    	if (i>0) then 
    		names = string.sub(names, 0, -3);
	    	ChatFrameEditBox:SetText(names.." ");
			ChatFrameEditBox:Show();
    	end
    	return;
    end
	
	-- todo: problem is that target.players[1].unitName may have changed target between updating the list --> click
	-- however we could impove situation by assisting the player that has the MOST common target amon all targetters
	-- ie. iterate all targetters and check if UnitIsUnit(unit, others) the player who has most highest count is 
	-- most likelly the correct one! That would however do 40*39 (1590) checks at worst!
	-- additionally / alternatively we could check target name (if only one player for example) and disaply 
	-- error (+sound?) if it has been changed
	
	-- initial implementation (just verboses when debug on)
	--local counts = {};
	local hicount = 0;
	local unitId = "";
	for _,player in target.players do
		--counts[player.unitId] = SA_List_TargetShareCount(player, target.players);
		local count = SA_List_TargetShareCount(player, target.players);
		if (count > hicount) then
			hicount = count;
			unitId = player.unitId;
		end
	end
	--for unitId,count in counts do
		--SA_Debug(unitId.." shares target with "..tostring(count), 1);
	--end
	SA_Debug("Assisting "..unitId.." which has highest common count of "..hicount);
	AssistUnit(unitId);
	
	-- initiate assist
	--SA_Debug("assisting "..target.players[1].unitName);
	--AssistUnit(target.players[1].unitId);
	
	SA_PostAssist();
	-- update the list immediattely
	SA_PREV.title_mode = -1; -- resets title mode on next refresh
	SA_List_Refresh();
end

-- return number of players in list that have same target as player
function SA_List_TargetShareCount(player, list)
	local count = 0;
	for _,compare in list do
		if (UnitIsUnit(player.unitId.."target", compare.unitId.."target")) then
			count = count + 1;
		end
	end
	return count;
end

function SA_List_Target_OnEnter(arg)
	local text = SA_List_Target_GetTooltip(arg);
	GameTooltip:SetOwner(arg, "ANCHOR_LEFT");
	GameTooltip:SetText(text,1,1,1,1,1);
	
	-- prevent going to pausemode if target has just been clicked
	if (time() - TARGET_CLICKED > 3) then
		-- Add some "sleep" to refreshing the list. It's not good to update the list while user is trying to select something.
		SA_LASTREFRESH = SA_BASERATE * 3;
		SA_PREV.title_mode = -1; -- resets title mode on next refresh
		SA_List_SetTitleButton(MODE_PAUSED);
	end
end

function SA_List_Target_OnLeave(arg)
	GameTooltip:Hide();
end

function SA_List_Target_GetTooltip(arg)
	local target = arg.obj;
	if (not target) then return "Unknown?"; end;
	local text = target.fullName.."\nTargetted by:\n";
	for k,v in target.players do
		-- colorize text by class
		local cv = RAID_CLASS_COLORS[string.upper(v.class)];
		local color="";
		if (not cv) then
			color = "|cff888888";
		else
			color = SA_ToTextCol(cv.r, cv.g, cv.b);
		end
		text = text .. color..v.unitName .. "|r" .. "\n";
	end
	return text;
end

------------------------------------------------------------------------------
-- Request list to be refreshed immediattely
------------------------------------------------------------------------------

function SA_List_Refresh()
	--SA_Debug("Requesting refresh now, target="..tostring(UnitName("target")));
	SA_LASTREFRESH = 0;
end

------------------------------------------------------------------------------
-- get puller from candidate list
------------------------------------------------------------------------------

function SA_GetPuller(candidates)
	for _,v in candidates do
		if (v.unitName == SA_OPTIONS.puller) then
			return v;
		end
	end
end

------------------------------------------------------------------------------
-- check if candidates target is already targetted by someone
-- return the target if found and nil if not
------------------------------------------------------------------------------

function SA_GetExistingTarget(candidate, targets)
	for _,target in targets do
		if (UnitIsUnit(target.players[1].target, candidate.target)) then
			return target;
		end
	end
	return nil;
end

function SA_List_NameSplit(str)
  local t = {n=0}
  local function helper(word) table.insert(t, word) end
  if not string.find(string.gsub(str, "%w+", helper), "%S") then return t end
end

------------------------------------------------------------------------------
-- construct target from candidate
------------------------------------------------------------------------------

function SA_GetTarget(candidate, pullerId)
	target = {};
	target["players"] = { candidate };
	target["name"] = UnitName(candidate.target);
	target["fullName"] = target.name;
	-- intelligent name split
	if (SA_OPTIONS.IntelligentSplit and target.name) then
		local parts = SA_List_NameSplit(target.name);
		if (parts) then
			if (table.getn(parts)>2) then
				if (parts[2]~="of") then -- splitting "shade of naxxramas" -> "of naxxramas" is stupid, dont split if second word is "of"
					target.name = string.sub(target.name, string.len(parts[1])+1 );
				end
			end
		end
	end
	target["health"] = UnitHealth(candidate.target);
	target["targetName"] = UnitName(candidate.target.."target");
	-- test fix for "shang's problem"
	-- this seems to happend when unit is near edge of known area and it's target is outide of it. Hence my client doesn't know anything about this unit ..
	if (target.targetName=="Unknown Entity" or target.targetName=="Unknown") then
		target.targetName=nil;
	end
	-- target.self gives us a reference to mob, example: party<n>target
	target["self"] = candidate.target;
	target["targetHealth"] = ceil( UnitHealth( candidate.target.."target" ) / UnitHealthMax( candidate.target.."target" ) * 100 );
	local _,targetClass = UnitClass(target.self);
	target["targetClass"] = targetClass;
	
	target["playersCount"] = 1;
	if (SA_IsMarked(candidate.target)) then
		target["marked"] = true;
	else
		target["marked"] = false;
	end

	if (isUnitCC(candidate.target)) then
		target["cced"] = true;
	else
		target["cced"] = false;
	end
	
	-- todo: xxx, only if enabled
	target["icon"] = GetRaidTargetIndex(target.self);
	if (not target.icon) then
		target["icon"] = 0;
	end
	
	-- is world boss, elite etc
	target["classification"] = UnitClassification(candidate.target);
	
	-- set myTarget to true if this is my target
	target["myTarget"] = UnitIsUnit(target.self, "target");
	
	if (pullerId~="") then
		target["pullerTarget"] = UnitIsUnit(target.self, pullerId.."target");
	end
	-- is unit in combat, 20.6.2006 - if it has target, treat as in combat!
	target["inCombat"] = UnitAffectingCombat(target.self) or target.targetName;
	
	return target;
end

-- return true if this candidate target should be added to list
function SA_Add_To_List(candidate)
	if( UnitCanAssist("player", candidate.unitId) and 
	    UnitExists(candidate.target) and
	    ((UnitAffectingCombat(candidate.target) or SA_OPTIONS.OutOfCombat) and not UnitIsDead(candidate.target)) and 
	    UnitCanAttack("player", candidate.target)) 
	then
		return true;
	else
		return false;
	end
end

function SA_List_SortTarget(a,b)
	-- marked first
	if (a.marked and not b.marked) then return true; end;
	if (b.marked and not a.marked) then return false; end;

	-- puller target second
	--if (a.pullerTarget and not b.pullerTarget) then return true; end;
	--if (b.pullerTarget and not a.pullerTarget) then return false; end;

	-- ooc last
	if (a.inCombat and not b.inCombat) then return true; end;
	if (b.inCombat and not a.inCombat) then return false; end;
			
	-- cced second lastest
	if (a.cced and not b.cced) then return false; end;
	if (b.cced and not a.cced) then return true; end;
		
	-- if both unmarked, then sort by name
	if (a.name == b.name) then
		return a.playersCount > b.playersCount;
	else
		return a.name > b.name;
	end
end

------------------------------------------------------------------------------
-- updates the available assists list
------------------------------------------------------------------------------

-- this table contains all variables used in incoming detection & printing
local incoming = { prev_iter=0, currently=0, prev_time=0 };

function SA_List_Update()

	-- if disabled, stop immediattely
	if (not SA_OPTIONS.ShowAvailable) then return; end
	
	local candidates, members= SA_GetCandidates(false)
	table.sort(candidates, function(a,b) return SA_SortCandidate(a,b,members) end);
	
	-- filter out candidates out of range if assisting only members nearby
	-- TODO: might not be good since causes overheading AND we should still add those players outside range to target?
	if (SA_OPTIONS.AssistOnlyNearest) then
		candidates = SA_FilterCandidatesByDistance(candidates, false);
	end
	
	-- add player to candidates if enabled
	if (UnitExists("target") and SA_OPTIONS.AddMyTarget) then
		table.insert(candidates, SA_GetPlayerAsCandidate());
	end

	local aggro_count = 0;
	local wb_count = 0;
	
	local pullerId = "";
	if (SA_OPTIONS.puller) then
		local puller = SA_GetPuller(candidates);
		-- puller might be null if it doesn't exist in group
		if (puller) then
			pullerId = puller.unitId;
		end
	end
	
	-- construct list of available assists / targets
	local targets = {};
	for _,candidate in candidates do
		if (SA_Add_To_List(candidate)) then
			local target = SA_GetExistingTarget(candidate, targets);
			if (target) then
				-- append targetting candidate to target
				table.insert(target.players, candidate);
				target.playersCount = target.playersCount + 1;
			else
				-- this candidate target is not targetted by anyone else, construct new target to the list
				local target = SA_GetTarget(candidate, pullerId);
				
				-- filtering if enabled
				if (SA_OPTIONS.Filter) then
					if string.find(string.lower(target.fullName), SA_OPTIONS.Filter) then
						table.insert(targets, target);
					end
				else
					table.insert(targets, target);
				end
			end
		end
	end
	
	-- update non-aggro cache and mark cache, this is used when SORTING candidates (see SA_SortCandidate)
	SA_MARKEDCACHE = {};
	SA_PASSIVECACHE = {};
	local dirty = false;
	local i = 0;
	local mc = 0;
	local ooc_seen = false;
	for _,target in targets do
		i = i + 1;
		if (target.marked) then
			if (i ~= 1 and mc == 0) then
				-- marked target not in first place, list is tainted
				SA_Debug("mark dirty list "..target.name, 1);
				dirty = true;
			end
			mc = mc + 1;
			for _,c in target.players do
				SA_MARKEDCACHE[c.unitName] = true;
			end
		end
		if (not target.inCombat or target.cced) then
			ooc_seen = true;
			for _,c in target.players do
				SA_PASSIVECACHE[c.unitName] = true;
			end
		else
			-- incombat targets after ooc targets, list is tainted
			if (ooc_seen) then
				SA_Debug("ooc dirty list "..target.name, 1);
				dirty = true;
			end
		end
	end
	
	-- if list is dirty abort refresh and request new one with correct cache,
	-- update 22.4.2006   	cache is not correct on next refresh either, in fact it may pass long time it is okay. 
	-- 						hence added PREV_DIRTY flag until problem is investigated
	-- update 20.6.2006		sort does not seem to work correctly with buff (ie. hunters mark) priorization!
	-- update 09.7.2006		sorting seems to work fine now, cleanup this + futile flag?
	if (dirty and not SA_PREV.dirty) then
		-- try again soon
		SA_LASTREFRESH = 0.2;
		SA_PREV.dirty = true;
		return;
	end
	SA_PREV.dirty = false;
	
	-- sort targets depending options
	if (SA_OPTIONS.PreserveOrder) then
		table.sort(targets, function(a,b) return SA_List_SortTarget(a,b) end);
	end
	
	------------------------------------------------------------------------------
	
	local i = 0;
	local overloaded = false;
	
	for _,target in targets do
		i = i + 1;
		if (i>10) then 
			overloaded = true;
			break; 
		end
		
		local box = SA_LIST_BOXES[i];
		box.frame.obj = target; -- store the target data to box (used ie. in tooltips)
		box.frame:Show();
			
		-- set values & texts
		local targetText = target.players[1].unitName;
		if (not SA_OPTIONS.HideTBY) then
			targetText = "|cffffffffT.by |r"..targetText;
		end
		if (target.playersCount > 1) then
			targetText = targetText.." + "..tostring(target.playersCount-1); -- -1 for the one who targets (who + n)
		end
		-- append prefixes to mob name + for elite, WB+ for worldboss
		local mobText = target.name;
		if (target.classification == "elite") then
			mobText = SA_SEMIALERT.."+|r"..mobText;
		end
		if (target.classification == "worldboss") then
			mobText = SA_SEMIALERT.."WB+|r"..mobText;
			if (target.inCombat) then
				wb_count = wb_count + 1;
			end
		end
		box.mobBar:SetValue(target.health);
		box.mobText:SetText(mobText);
		
		-- colorize box
		if (not target.inCombat) then
			-- if this is out of combat and my target, apply only slight green efect
			if (target.myTarget) then
				box.frame:SetBackdropColor(0,0.65,0,0.65);
				box.frame:SetBackdropBorderColor(0,1,0,0.75);
			elseif (target.pullerTarget) then
				-- yellow background on puller target
				box.frame:SetBackdropColor(1,1,0,0.3);
				box.frame:SetBackdropBorderColor(0,0,0,0.4); -- regular grey
			else
				box.frame:SetBackdropColor(0,0,0,0.4);
				box.frame:SetBackdropBorderColor(0,0,0,0.4); -- regular grey
			end
		else
			local addinc = true;
			-- set border color
			if (target.marked) then
				box.frame:SetBackdropBorderColor(1,0,0,1);
			elseif (target.myTarget) then
				box.frame:SetBackdropBorderColor(0,1,0,1);
			elseif (target.cced) then
				box.frame:SetBackdropBorderColor(0,0,0,1);
				addinc = false;
			else
				box.frame:SetBackdropBorderColor(0.8,0.8,0.8,1);
			end
			-- add to incoming
			if (addinc) then
				incoming.currently = incoming.currently + 1;
			end
			
			-- set background color
			if (target.myTarget) then
				box.frame:SetBackdropColor(0,0.75,0,0.85);
			elseif (target.pullerTarget) then
				-- yellow background on puller target
				box.frame:SetBackdropColor(1,1,0,0.3);
			else
				box.frame:SetBackdropColor(0,0,0,0.5);
			end
		end
		
		-- colorize target target text in some situations
		if (target.targetName) then
			local col = "";
			local endcol = "";
			if (UnitName("player") == target.targetName) then
				-- targetting player
				aggro_count = aggro_count + 1;
				if (SA_OPTIONS.TankMode) then
					col = SA_SEMIALERT;
				else
					col = SA_ALERTCOL;
				end
			elseif (not SA_IsTank(target.targetName) and SA_OPTIONS.TankMode) then
				-- targeting non tank in tank mode
				col = SA_ALERTCOL;
			elseif (SA_IsTank(target.targetName)) then
				-- targeting tank always on tank color, regardless of tank mode
				col = SA_TANKCOL;
			end
			-- append end of color code marking
			if (col~="") then
				endcol = "|r";
			end
			box.targetBar:SetValue(target.targetHealth);
			box.targetText:SetText("T:"..col..target.targetName..endcol);
		else
			box.targetBar:SetValue(0);
			box.targetText:SetText("?");
		end
		
		-- colorize mob bar
		if (UnitIsTapped(target.self) and not UnitIsTappedByPlayer(target.self)) then
			-- target is "grey" to us
			box.mobBar:SetStatusBarColor(0.8, 0.8, 0.8);
		elseif (UnitPlayerControlled(target.self)) then
			-- pvp target
			box.mobBar:SetStatusBarColor(1, 0, 0);
		elseif (not target.inCombat) then
			-- out of combat target
			box.mobBar:SetStatusBarColor(0.38, 0.38, 0.38);
		else
			-- normal green
			box.mobBar:SetStatusBarColor(0, 1, 0);
		end
		
		-- make texts visible always (bugs on some systems)
		-- code peeked from TextStatusBar_UpdateTextString sources
		-- perhaps I should've called that method but it does some other unwanted things
		box.mobBar.TextString:Show();
		box.targetBar.TextString:Show();
		box.targetOf:SetText(targetText);
		
		-- set class icon (texture coordinates)
		local coords = SA_TEXTCOORDS[target.targetClass];
		box.classIcon:SetTexCoord(coords.left, coords.right, coords.top, coords.bottom);
		
		-- set target icon (texture coordinates)
		-- TODO: xxx, only if feature enabled
		if (target.icon>0) then
			local icon = UnitPopupButtons["RAID_TARGET_"..target.icon];
			box.targetIcon:SetTexCoord(icon.tCoordLeft, icon.tCoordRight, icon.tCoordTop, icon.tCoordBottom );
			box.targetIcon:Show();
		else
			box.targetIcon:Hide();
		end

		-- hunters mark icon
		if (target.marked and SA_OPTIONS.HuntersMarkIconMode>1) then
			box.huntersMarkIcon:Show();
		else
			box.huntersMarkIcon:Hide();
		end
		
	end
	
	------------------------------------------------------------------------------
	
	-- if count has been changed update visibility
	-- TODO: apparently there is no performance loss calling hide/show .. so this is partially futile now
	if (i ~= SA_PREV.mob_count) then
		for j = i + 1, SA_PREV.mob_count do
			if (j>10) then
				break;
			end
			SA_LIST_BOXES[j].frame:Hide();
		end
	end
	
	-- if player have a ACQUIRED aggro, play optional sound to alert player
	if (aggro_count > SA_PREV.aggro_count) then
		if (SA_OPTIONS.AudioWarning) then PlaySound(SA_OPTIONS.SoundGainAggro); end;
		if (SA_OPTIONS.VerboseAcquiredAggro) then
			SA_Verbose("Acquired aggro!", COLOR_ALERT); 
		end
	end
	-- if player have a LOST aggro, play optional sound to alert player
	if (aggro_count < SA_PREV.aggro_count and i >= SA_PREV.mob_count) then
		if (SA_OPTIONS.LostAudioWarning) then PlaySoundFile(SA_OPTIONS.SoundLoseAggro); end;
		if (SA_OPTIONS.VerboseLostAggro) then
			SA_Verbose("Lost aggro!", COLOR_ALERT);
		end
	end
	-- if incoming worldbosses, play optional sound to alert player, TODO: OPTION!
	if (wb_count > SA_PREV.wb_count) then
		SA_Verbose("Incoming worldboss!", COLOR_ALERT);
		PlaySoundFile(SA_OPTIONS.SoundIncomingWoldBoss);
	end
	
	-- if we have new mobs in combat
	-- TODO: on incoming worldboss level unit play alert sound!
	if (SA_OPTIONS.VerboseIncoming) then
		local now = time();
		if (incoming.currently > incoming.prev_iter and now - incoming.prev_time > 4) then
			
			local amount = incoming.currently - incoming.prev_iter;
			if (amount > 1) then
				SA_Verbose("Incoming x"..amount.."!", COLOR_ALERT); 
			else
				SA_Verbose("Incoming!", COLOR_ALERT); 
			end
			
			incoming.prev_time = now;
		end
		incoming.prev_iter = incoming.currently;
		incoming.currently = 0;
	end
	
	-- update title to correct mode
	if (i>0) then
		title_mode = MODE_NORMAL;
	else
		title_mode = MODE_OOC;
	end
	if (SA_OPTIONS.Filter) then
		title_mode = MODE_FILTERED;
	end
	if (SA_OPTIONS.AssistOnlyNearest) then
		title_mode = MODE_NEAREST;
	end
	if (overloaded) then
		title_mode = MODE_OVERLOADED;
	end
	
	-- update title button if mode has been changed
	if (title_mode ~= SA_PREV.title_mode) then
		SA_List_SetTitleButton(title_mode);
	end
	
	-- set prev data for next iteration
	SA_PREV.title_mode = title_mode;
	SA_PREV.mob_count = i;
	SA_PREV.wb_count = wb_count;
	SA_PREV.aggro_count = aggro_count;
end

------------------------------------------------------------------------------
-- Title button handling
------------------------------------------------------------------------------

function SA_List_SetTitleButton(mode)
	if (mode == MODE_NORMAL or mode == MODE_OOC) then
		if (mode == MODE_NORMAL) then
			SAListTitleButton:SetAlpha(1);
		else
			if (SA_OPTIONS.HideTitle) then
				SAListTitleButton:SetAlpha(0);
			else
				SAListTitleButton:SetAlpha(SA_OPTIONS.ListOOCAlpha);
			end
		end
		SAListTitleButton:SetBackdropColor(0, 0, 0, 0.3);
		SAListTitleButton:SetBackdropBorderColor(1,1,1,1)
		SAListTitle:SetText("Available assists");
	elseif (mode == MODE_FILTERED or mode == MODE_NEAREST) then
        SAListTitleButton:SetAlpha(1);
        SAListTitleButton:SetBackdropColor(0,0.6,0.8,1);
        SAListTitleButton:SetBackdropBorderColor(0,0.6,0.8,1);
        local text = "";
        if (mode == MODE_FILTERED) then
        	text = "Filtered";
        end
        if (mode == MODE_NEAREST) then
        	text = "Nearest";
        end
        SAListTitle:SetText(text);
    elseif (mode == MODE_PAUSED) then
        SAListTitleButton:SetAlpha(1);
        SAListTitleButton:SetBackdropColor(0.3,0.3,0.3,1);
        SAListTitleButton:SetBackdropBorderColor(0.6,0.6,0.6,1);
        SAListTitle:SetText("Paused");
	elseif (mode == MODE_OVERLOADED) then
		SAListTitleButton:SetAlpha(1);
		SAListTitleButton:SetBackdropColor(1,0,0,1);
		SAListTitleButton:SetBackdropBorderColor(1,0,0,1);
		SAListTitle:SetText("OVERLOADED");
	else
		printInfo("smartassist error: unknown title mode "..tostring(mode));
	end
end

SA_PREV_ALPHA = 1;
function SA_List_TitleButton_OnEnter()
	SA_PREV_ALPHA = SAListTitleButton:GetAlpha();
	SAListTitleButton:SetAlpha(1);
end

function SA_List_TitleButton_OnLeave()
	SAListTitleButton:SetAlpha(SA_PREV_ALPHA);
end