BO_Visible = 1;

--Functions

function BuffOrg_OnLoad()
	BO_MainFrame:RegisterForDrag("LeftButton");
	BO_MainFrame:RegisterEvent("RAID_ROSTER_UPDATE")
	BO_ClassName:SetText(UnitClass("player").."s");

end

function BuffOrd_OnEvent()
	if(event == "ADDON_LOADED" and arg1 == "BuffOrg") then
		BuffOrg_SetVisible(BO_Visible)
		BuffOrg_UpdateWindow();
	elseif(event == "RAID_ROSTER_UPDATE") then
		if(BO_Visible) then
			BuffOrg_UpdateWindow();
		end
	end		
end

function BuffOrg_OnDragStart()
	BO_MainFrame:StartMoving()
end

function BuffOrg_OnDragStop()
	BO_MainFrame:StopMovingOrSizing()
end

function BuffOrg_CheckBoxToggle(arg1)

end

function BuffOrg_SetVisible(state)
	
end

function BuffOrg_UpdateWindow()

end

function BuffOrg_GetClassList()
	local raidnum = GetNumRaidMembers();
	local myclass = UnitClass("player");
	local classarray ={ };
	local numofclass
	
	for c = 1, raidnum do
		local plrname,_,_,_,plrclass = GetRaidRosterInfo(i);
		if(plrclass == myclass) then
			table.insert(classarray, plrname);
			numofclass = numofclass + 1;
		end
	end	
	return numofclass, classarray;
end