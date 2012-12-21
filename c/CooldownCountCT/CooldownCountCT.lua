CooldownCountCT_Saved_GenerateButtonUpdateList = nil;
CooldownCountCT_BarNames = {"CT_ActionButton", "CT2_ActionButton", "CT3_ActionButton", "CT4_ActionButton", "CT5_ActionButton"};
CooldownCountCT_ButtonNameFormat = "CT%s_ActionButton%d";
CooldownCountCT_NumberOfButtons = 12;
CooldownCountCT_NumberOfBars = 5;
CooldownCountCT_NormalBar = 1;

function CooldownCountCT_OnLoad()
	if ( CooldownCountCT_NormalBar == 1 ) then
		for k,v in CooldownCountCT_BarNames do
			if ( getglobal(v.."1") ) then
				table.insert(CooldownCount_ButtonNames, v);
			end
		end
	else
		CooldownCountCT_Saved_GenerateButtonUpdateList = CooldownCount_GenerateButtonUpdateList;
		CooldownCount_GenerateButtonUpdateList = CooldownCountCT_GenerateButtonUpdateList;
	end
	CooldownCount_RegenerateList();
end


function CooldownCountCT_GenerateButtonUpdateList()
	local updateList = CooldownCountCT_Saved_GenerateButtonUpdateList();
	local name = nil;
	local barString = "";
	for bar = 1, CooldownCountCT_NumberOfBars do
		if ( bar > 1 ) then
			barString = bar.."";
		end
		for i = 1, CooldownCountCT_NumberOfButtons do
			name = format(CooldownCountCT_ButtonNameFormat, barString, i);
			if ( getglobal(name) ) then
				table.insert(updateList, name);
			end
		end
	end
	return updateList;
end
