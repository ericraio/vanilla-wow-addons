CooldownCountFlexBar_Saved_GenerateButtonUpdateList = nil;
CooldownCountFlexBar_BarName = "FlexBarButton";
CooldownCountFlexBar_ButtonNameFormat = "FlexBarButton%d";
CooldownCountFlexBar_NumberOfButtons = 120;
CooldownCountFlexBar_NormalBar = 0;

function CooldownCountFlexBar_OnLoad()
	if ( CooldownCountFlexBar_NormalBar == 1 ) then
		table.insert(CooldownCount_ButtonNames, CooldownCountFlexBar_BarName);
	else
		CooldownCountFlexBar_Saved_GenerateButtonUpdateList = CooldownCount_GenerateButtonUpdateList;
		CooldownCount_GenerateButtonUpdateList = CooldownCountFlexBar_GenerateButtonUpdateList;
	end
	CooldownCount_RegenerateList();
end


function CooldownCountFlexBar_GenerateButtonUpdateList()
	local updateList = CooldownCountFlexBar_Saved_GenerateButtonUpdateList();
	for i = 1, CooldownCountFlexBar_NumberOfButtons do
		name = format(CooldownCountFlexBar_ButtonNameFormat, i);
		if ( getglobal(name) ) then
			table.insert(updateList, name);
		end
	end
	return updateList;
end