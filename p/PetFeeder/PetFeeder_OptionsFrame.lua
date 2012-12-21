--[[
path: /PetFeeder/
filename: PetFeeder_OptionsFrame.lua
author: Jeff Parker <jeff3parker@gmail.com>
created: Tue, 22 Jan 2005 14:15:00 -0800
updated: Tue, 22 Jan 2005 21:39:00 -0800

Pet Feeder: a GUI interface allowing you configure happiness level for your pet & 
			drag/drop foods you wish your pet to eat.  When the pet happiness drops below
			the selected threshold will automatically feed your pet.
			To remove a food from the list, simply click on it.
]]


function PetFeeder_OptionsFrame_OnShow()
	if ( PeetFeederPlayer_Config.SortOption ) then
		UIDropDownMenu_SetSelectedID(PetFeeder_OptionsFrameSortOptionDropDown, PeetFeederPlayer_Config.SortOption, PETFEEDER_SORTOPTION_DROPDOWN);	
		UIDropDownMenu_SetText(PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption].name, PetFeeder_OptionsFrameSortOptionDropDown);
		sortMethod1 = PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption].func;
	end
	if ( PeetFeederPlayer_Config.SortOption2 ) then
		UIDropDownMenu_SetSelectedID(PetFeeder_OptionsFrameSortOption2DropDown, PeetFeederPlayer_Config.SortOption2, PETFEEDER_SORTOPTION_DROPDOWN);	
		UIDropDownMenu_SetText(PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption2].name, PetFeeder_OptionsFrameSortOption2DropDown);
		sortMethod2 = PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption2].func;
	end

	if ( PeetFeederPlayer_Config.Level ) then
		UIDropDownMenu_SetSelectedID(PetFeederFrameDropDown, PeetFeederPlayer_Config.Level, PETFEEDER_LEVELS_DROPDOWN);
		UIDropDownMenu_SetText(PETFEEDER_LEVELS_DROPDOWN[PeetFeederPlayer_Config.Level].name, PetFeederFrameDropDown);
	end

end


local function PetFeeder_OptionsFrameSortOptionDropDown_Initialize()
	local info;
	for i = 1, getn(PETFEEDER_SORTOPTION_DROPDOWN), 1 do
		info = { };
		info.text = PETFEEDER_SORTOPTION_DROPDOWN[i].name;
		info.func = PetFeeder_OptionsFrameSortOptionDropDownButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function PetFeeder_OptionsFrameSortOptionDropDown_OnLoad()
	UIDropDownMenu_Initialize(PetFeeder_OptionsFrameSortOptionDropDown, PetFeeder_OptionsFrameSortOptionDropDown_Initialize);
	UIDropDownMenu_SetWidth(150);
	UIDropDownMenu_SetButtonWidth(48);
	UIDropDownMenu_JustifyText("LEFT", PetFeeder_OptionsFrameSortOptionDropDown)
end

function PetFeeder_OptionsFrameSortOptionDropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(PetFeeder_OptionsFrameSortOptionDropDown, this:GetID());
	PeetFeederPlayer_Config.SortOption = UIDropDownMenu_GetSelectedID(PetFeeder_OptionsFrameSortOptionDropDown);
	sortMethod1 = PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption].func;
	sortTheFoods(PetFeeder_Foods[PetFeeder_PetName]);
	PetFeeder_FoodsFrame_Update();
end

local function PetFeeder_OptionsFrameSortOption2DropDown_Initialize()
	local info;
	for i = 1, getn(PETFEEDER_SORTOPTION_DROPDOWN), 1 do
		info = { };
		info.text = PETFEEDER_SORTOPTION_DROPDOWN[i].name;
		info.func = PetFeeder_OptionsFrameSortOption2DropDownButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end
function PetFeeder_OptionsFrameSortOption2DropDown_OnLoad()
	UIDropDownMenu_Initialize(PetFeeder_OptionsFrameSortOption2DropDown, PetFeeder_OptionsFrameSortOption2DropDown_Initialize);
	UIDropDownMenu_SetWidth(150);
	UIDropDownMenu_SetButtonWidth(48);
	UIDropDownMenu_JustifyText("LEFT", PetFeeder_OptionsFrameSortOption2DropDown)
end

function PetFeeder_OptionsFrameSortOption2DropDownButton_OnClick()
	UIDropDownMenu_SetSelectedID(PetFeeder_OptionsFrameSortOption2DropDown, this:GetID());
	PeetFeederPlayer_Config.SortOption2 = UIDropDownMenu_GetSelectedID(PetFeeder_OptionsFrameSortOption2DropDown);
	sortMethod2 = PETFEEDER_SORTOPTION_DROPDOWN[PeetFeederPlayer_Config.SortOption2].func;
	sortTheFoods(PetFeeder_Foods[PetFeeder_PetName]);
	PetFeeder_FoodsFrame_Update();
end
