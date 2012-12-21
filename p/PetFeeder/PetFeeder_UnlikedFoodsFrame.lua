--[[
path: /PetFeeder/
filename: PetFeeder_UnlikedFoodsFrame.lua
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

function PetFeeder_UnlikedFoodsFrame_OnReceiveDrag()
	
	PetFeeder_DroptheItem( "any" , PETFEEDER_FL_DISLIKED);
	PetFeeder_Update_Frames();
	
end

--[[
=============================================================================
Called when we want to display a list of foods
=============================================================================
]]

function PetFeeder_UnlikedFoodsFrame_Update()
	PetFeeder_FoodsFrame_UpdateExt( PETFEEDER_FL_DISLIKED );
end

--[[
=============================================================================
Called when Clear Foods button is clicked
=============================================================================
]]
function PetFeeder_UnlikedFoodsFrameClearFoodsButton_Update()
	PetFeeder_ClearFoods( PETFEEDER_FL_DISLIKED );
end

--[[
=============================================================================
Called when the button item is clicked
=============================================================================
]]
function PetFeeder_UnlikedFoodsFrameItemButton_OnClick(button,name)
	if ( button == "LeftButton" ) then
		PetFeeder_AddFood( name , PETFEEDER_FL_APPROVED);
		PetFeeder_Update_Frames();
	end
end

function PetFeeder_UnlikedFoodsFrame_OnShow()
	PetFeeder_Update_Frames();
	if ( PeetFeederPlayer_Config.SortOption ) then
		UIDropDownMenu_SetSelectedID(PetFeeder_UnlikedFoodsFrameSortOptionDropDown, PeetFeederPlayer_Config.SortOption, PETFEEDER_SORTOPTION_DROPDOWN);	
		UIDropDownMenu_SetText(PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption].name, PetFeeder_UnlikedFoodsFrameSortOptionDropDown);
	end
	if ( PeetFeederPlayer_Config.SortOption2 ) then
		UIDropDownMenu_SetSelectedID(PetFeeder_UnlikedFoodsFrameSortOption2DropDown, PeetFeederPlayer_Config.SortOption2, PETFEEDER_SORTOPTION_DROPDOWN);	
		UIDropDownMenu_SetText(PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption2].name, PetFeeder_UnlikedFoodsFrameSortOption2DropDown);
	end
end

------------------
-- Sort Option Dropdown
------------------

local function PetFeeder_UnlikedFoodsFrameSortOptionDropDown_Initialize()
	local info;
	for i = 1, getn(PETFEEDER_SORTOPTION_DROPDOWN), 1 do
		info = { };
		info.text = PETFEEDER_SORTOPTION_DROPDOWN[i].name;
		info.func = PetFeeder_UnlikedFoodsFrameSortOptionDropDownButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end
local function PetFeeder_UnlikedFoodsFrameSortOption2DropDown_Initialize()
	local info;
	for i = 1, getn(PETFEEDER_SORTOPTION_DROPDOWN), 1 do
		info = { };
		info.text = PETFEEDER_SORTOPTION_DROPDOWN[i].name;
		info.func = PetFeeder_UnlikedFoodsFrameSortOption2DropDownButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function PetFeeder_UnlikedFoodsFrameSortOptionDropDown_OnLoad()
	UIDropDownMenu_Initialize(PetFeeder_UnlikedFoodsFrameSortOptionDropDown, PetFeeder_UnlikedFoodsFrameSortOptionDropDown_Initialize);
	UIDropDownMenu_SetWidth(150);
	UIDropDownMenu_SetButtonWidth(48);
	UIDropDownMenu_JustifyText("LEFT", PetFeeder_UnlikedFoodsFrameSortOptionDropDown)
end

function PetFeeder_UnlikedFoodsFrameSortOptionDropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(PetFeeder_UnlikedFoodsFrameSortOptionDropDown, this:GetID());
	PeetFeederPlayer_Config.SortOption = UIDropDownMenu_GetSelectedID(PetFeeder_UnlikedFoodsFrameSortOptionDropDown);
	PetFeeder_Update_Frames();
end

function PetFeeder_UnlikedFoodsFrameSortOption2DropDown_OnLoad()
	UIDropDownMenu_Initialize(PetFeeder_UnlikedFoodsFrameSortOption2DropDown, PetFeeder_UnlikedFoodsFrameSortOption2DropDown_Initialize);
	UIDropDownMenu_SetWidth(150);
	UIDropDownMenu_SetButtonWidth(48);
	UIDropDownMenu_JustifyText("LEFT", PetFeeder_UnlikedFoodsFrameSortOption2DropDown)
end

function PetFeeder_UnlikedFoodsFrameSortOption2DropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(PetFeeder_UnlikedFoodsFrameSortOption2DropDown, this:GetID());
	PeetFeederPlayer_Config.SortOption2 = UIDropDownMenu_GetSelectedID(PetFeeder_UnlikedFoodsFrameSortOption2DropDown);
	PetFeeder_Update_Frames();
end
