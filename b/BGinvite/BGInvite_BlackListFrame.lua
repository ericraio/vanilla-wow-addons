--[[
path: /BGInvite/
filename: BGInvite_BlacklistFrame.lua
author: Jeff Parker <jeff3parker@gmail.com>
created: Tue, 22 Jan 2005 14:15:00 -0800
updated: Tue, 22 Jan 2005 21:39:00 -0800

Pet Feeder: a GUI interface allowing you configure happiness level for your pet & 
			drag/drop foods you wish your pet to eat.  When the pet happiness drops below
			the selected threshold will automatically feed your pet.
			To remove a food from the list, simply click on it.
]]

--[[
=============================================================================
Called when we want to display a list of foods
=============================================================================
]]
function BGInvite_BlackListFrame_OnShow()
	BGInvite_BlackListFrame_Update();
end

--[[
=============================================================================
Called when we want to display a list of foods
=============================================================================
]]
function BGInvite_BlackListFrame_Update()

	table.sort( BGvar_BlackList, function(a,b) return a.name < b.name end );
	local numEntries = table.getn(BGvar_BlackList);

	--FauxScrollFrame_Update(BGInvite_BlackListFrameListScrollFrame, numEntries, BGInvite_ITEMS_SHOWN, nil, nil, nil, nil, nil, nil, BGInvite_ITEM_HEIGHT);
	FauxScrollFrame_Update(BGInvite_BlackListFrameListScrollFrame, numEntries, BGInvite_ITEMS_SHOWN, BGInvite_ITEM_HEIGHT, nil, nil, nil, nil, nil, BGInvite_ITEM_HEIGHT);
	
	local scrollFrameOffset = FauxScrollFrame_GetOffset(BGInvite_BlackListFrameListScrollFrame);

	local iItem;
	for iItem = 1, BGInvite_ITEMS_SHOWN, 1 do
		local itemIndex = iItem + scrollFrameOffset;
		local buttonItem = getglobal("BGInvite_BlackListFrameItem"..iItem);
		if ( itemIndex > numEntries ) then
		  buttonItem:Hide();
		else
			local value = BGvar_BlackList[itemIndex];
			local text = value.name..BGINVITE_RETRIES..":"..value.retries.." ("..value.reason..")";
			buttonItem:SetText(text);
			buttonItem:Show();
		end
	end	
end

--[[
=============================================================================
Called when Clear Foods button is clicked
=============================================================================
]]
function BGInvite_BlackListFrameClearBlackListButton_Update()
	BGInviteClearBlackList();
	BGInvite_BlackListFrame_Update();
end

function BGInvite_BlackList_Clear_Update()
	BGInviteClearBlackList();
	BGInvite_BlackListFrame_Update();
end

--[[
=============================================================================
Called when the button item is clicked
=============================================================================
]]
function BGInvite_BlackListFrameItemButton_OnClick(button,name)
	if ( button == "LeftButton" ) then
		playerName = string.sub(name, 1,string.find(name," ")-1);
		local index = findPlayerIndexInList(BGvar_BlackList, playerName);
		if ( index ) then
			table.remove(BGvar_BlackList, index);
		end
		BGInvite_BlackListFrame_Update();
	end
end




