CT_QuestLevels_ShowQuestLevels = 1;

function questlevelsfunction(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_QuestLevels_ShowQuestLevels = 1;
		CT_Print(CT_QUESTLEVELS_ON, 1, 1, 0);
	else
		CT_Print(CT_QUESTLEVELS_OFF, 1, 1, 0);
		CT_QuestLevels_ShowQuestLevels = 0;
	end
end

function questlevelsinitfunction(modId)
	local val = CT_Mods[modId]["modStatus"];
	if ( val == "on" ) then
		CT_QuestLevels_ShowQuestLevels = 1;
	else
		CT_QuestLevels_ShowQuestLevels = 0;
	end
end

CT_RegisterMod(CT_QUESTLEVELS_MODNAME, CT_QUESTLEVELS_SUBNAME, 5, "Interface\\Icons\\INV_Letter_13", CT_QUESTLEVELS_TOOLTIP, "on", nil, questlevelsfunction, questlevelsinitfunction);

CT_QuestLevels_oldGetQuestLogTitle = GetQuestLogTitle;
function CT_QuestLevels_newGetQuestLogTitle(questIndex)
	local questLogTitleText, oldLevel, questTag, isHeader, isCollapsed, isComplete = CT_QuestLevels_oldGetQuestLogTitle(questIndex);
	local level = oldLevel;
	if (CT_QuestLevels_ShowQuestLevels == 1 and not isHeader and level ) then
		if ( questTag == ELITE ) then
			level = oldLevel .. "+";
		elseif ( questTag == RAID ) then
			level = oldLevel .. "R";
		elseif ( questTag == "Dungeon" or questTag == "Donjon" ) then
			level = oldLevel .. "D";
		end
		if ( questLogTitleText ) then
			questLogTitleText = "[" .. level .. "] " .. questLogTitleText;
		end
	end
	return questLogTitleText, oldLevel, questTag, isHeader, isCollapsed, isComplete;
end
GetQuestLogTitle = CT_QuestLevels_newGetQuestLogTitle;