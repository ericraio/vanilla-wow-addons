--[[
path: /PetFeeder/
filename: PetFeeder_FoodsFrame.lua
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
function PetFeeder_FoodsFrame_OnReceiveDrag()
	PetFeeder_DroptheItem( "foods",PETFEEDER_FL_UNKNOWN );	
	PetFeeder_Update_Frames();
end

function PetFeeder_FoodsFrame_OnShow()
	if ( PeetFeederPlayer_Config.Level ) then
		UIDropDownMenu_SetSelectedID(PetFeederFrameDropDown, PeetFeederPlayer_Config.Level, PETFEEDER_LEVELS_DROPDOWN);
		UIDropDownMenu_SetText(PETFEEDER_LEVELS_DROPDOWN[PeetFeederPlayer_Config.Level].name, PetFeederFrameDropDown);
	end
	PetFeeder_Update_Frames();
end


--[[
=============================================================================
Called when we want to display a list of foods
=============================================================================
]]

function PetFeeder_FoodsFrame_Update()
	PetFeeder_FoodsFrame_UpdateExt(PETFEEDER_FL_UNKNOWN)
end

--[[
=============================================================================
Called when Clear Foods button is clicked
=============================================================================
]]

function PetFeeder_FoodsFrameClearFoodsButton_Update()
	PetFeeder_ClearFoods(PETFEEDER_FL_UNKNOWN);
end



--[[
=============================================================================
Called when Clear Foods button is clicked
=============================================================================
]]

function PetFeeder_FoodsFrameUpdateFoodsButton_Update()
	if not ( UnitExists("pet") ) then
		UIErrorsFrame:AddMessage(PETFEEDER_NEED_PET, 0.8, 0, 0, 1.0, UIERRORS_HOLD_TIME);
		return;
	end
	PetFeeder_PetName = UnitName( "pet" );
	PetFeeder_PopulateFoods();
	PetFeeder_Update_Frames();
end

--[[
=============================================================================
Called when the button item is clicked
=============================================================================
]]

function PetFeeder_FoodsFrameItemButton_OnClick(button,name)
	if ( button == "LeftButton" ) then
		PetFeeder_ApproveFoodItem(name);
	end
end



