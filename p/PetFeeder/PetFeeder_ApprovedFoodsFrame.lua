--[[
path: /PetFeeder/
filename: PetFeeder_ApprovedFoodsFrame.lua
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

function PetFeeder_ApprovedFoodsFrame_OnReceiveDrag()
	PetFeeder_DroptheItem( "foods" , PETFEEDER_FL_APPROVED);	
	PetFeeder_Update_Frames();
end

function PetFeeder_ApprovedFoodsFrame_OnShow()
	PetFeeder_Update_Frames();
end

--[[
=============================================================================
Called when we want to display a list of foods
=============================================================================
]]

function PetFeeder_ApprovedFoodsFrame_Update()
	PetFeeder_FoodsFrame_UpdateExt( PETFEEDER_FL_APPROVED );
end

--[[
=============================================================================
Called when Clear Foods button is clicked
=============================================================================
]]
function PetFeeder_ApprovedFoodsFrameClearFoodsButton_Update()
	PetFeeder_ClearFoods( PETFEEDER_FL_APPROVED );
end

--[[
=============================================================================
Called when the button item is clicked
=============================================================================
]]

function PetFeeder_ApprovedFoodsFrameItemButton_OnClick(button,name)
	if ( button == "LeftButton" ) then
		PetFeeder_AddFood( name, PETFEEDER_FL_DISLIKED );
		PetFeeder_Update_Frames();
	end
end

