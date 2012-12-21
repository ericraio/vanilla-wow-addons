--[[

BCUI Ammo Warning
=================

Description:
------------
Displays warning messages when the ammo type you have equiped in your ammo slot
reaches configurable levels.  Initial values are set to warn you when your ammo
reaches 200, and then every 50 shots after that until your ammo reaches the
critical limit.  Then, you recieve warnings every shot until you run out of ammo.

Credits:
--------
- Many thanks to CapnBry over at http://capnbry.net/wow/ for the regular expression to
  parse the item link string in bcAW_GetItemName().

Setup:
------
Change the BCAW_* variables below to set when the warning messages show.  For example, 
with the default values (BCAW_INITIAL_WARNING_COUNT = 200, BCAW_WARNING_INCREMENT = 50,
and BCAW_CRITICAL_WARNING_COUNT = 30), you'll recieve the first warning when you reach
an ammo count of 200.  The next will be at 150, then 100, then 50.  You then start to
recieve warnings at every shot once you reach 30 bullets/arrows left.

Revision History:
-----------------
04/05/2005 1.06
- New Interface number.

02/22/2005 1.05
- New Interface number.

02/15/2005 1.04
- Added version numbers.

- New Interface number.

01/15/2005 v1.02
- Updated to check the ranged slot for thrown weapon count if nothing is found in the
  ammo slot.

- Added more verbose comments throughout the code.

12/??/2004 v1.00
Initial release.

]]

BCAW_INITIAL_WARNING_COUNT = 200;
BCAW_WARNING_INCREMENT = 50;
BCAW_CRITICAL_WARNING_COUNT = 30;

function bcAW_OnLoad()
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");

	-- Let the user know the mod loaded.
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage("BC Ammo Warning loaded");
	end
end

function bcAW_GetItemName(id)
	local linktext = GetInventoryItemLink("player", id);

	if (linktext) then
		local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
		return name;
	end
end

function bcAW_OnEvent()
--	DEFAULT_CHAT_FRAME:AddMessage("bcAW_OnEvent(): called - "..event);
	if (event == "UNIT_INVENTORY_CHANGED") then
		
		-- By default, monitor the ammo slot.  But, if there is something in the ranged
		-- slot with a quantity > 1, assume it's a throwing weapon.
		this.ammoSlot = CharacterAmmoSlot:GetID();
		local rangedCount = GetInventoryItemCount("player", CharacterRangedSlot:GetID());
		if (rangedCount > 1) then
			this.ammoSlot = CharacterRangedSlot:GetID();
		end

		if (this.lastAmmoCount == nil) then
			this.lastAmmoCount = GetInventoryItemCount("player", this.ammoSlot);
		end
		
		this.currentAmmoCount = GetInventoryItemCount("player", this.ammoSlot);

		if (this.lastAmmoCount ~= this.currentAmmoCount) then
			if (this.currentAmmoCount == BCAW_INITIAL_WARNING_COUNT) then
				UIErrorsFrame:AddMessage("Low Ammo Warning! Shots left = "..this.currentAmmoCount, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
			elseif (math.mod(BCAW_INITIAL_WARNING_COUNT - this.currentAmmoCount, BCAW_WARNING_INCREMENT) == 0 and this.currentAmmoCount < BCAW_INITIAL_WARNING_COUNT) then
				UIErrorsFrame:AddMessage("Low Ammo Warning! Shots left = "..this.currentAmmoCount, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
			elseif (this.currentAmmoCount > 0 and this.currentAmmoCount < BCAW_CRITICAL_WARNING_COUNT) then
				UIErrorsFrame:AddMessage("Low Ammo Warning! Shots left = "..this.currentAmmoCount, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
			end
			this.lastAmmoCount = this.currentAmmoCount;
		end
	end
end
