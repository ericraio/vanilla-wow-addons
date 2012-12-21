--[[

BCUI Auto Mail Subject
======================

Description:
------------
Automatically populates the subject of a mail message with the name and quantity of
the item you drag into the attachment box.  Will only work if the subject line is
currently empty, so it won't erase what you've already typed there.

Revision History:
-----------------
02/15/2005 v1.04
- New Interface number.

02/02/2005 v1.03
- Added the number of items in the stack to the subject line.

- Added more verbose comments throughout the code.

- Added version numbers.

12/??/2004 v1.0
Initial release.

]]

function bcAMS_OnLoad()
	-- Register for the needed events.
	this:RegisterEvent("MAIL_SEND_INFO_UPDATE");

	-- Let the user know the mod loaded.
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage("BC Auto Mail Subject loaded");
	end
end

function bcAMS_OnEvent()
-- Debug code:  Used to tell when this function is called.
--	DEFAULT_CHAT_FRAME:AddMessage("bcAMS_OnEvent(): called");
	if (event == "MAIL_SEND_INFO_UPDATE") then
		-- Get the info about the item in the attachement box.
		local itemName, itemTexture, stackCount, quality = GetSendMailItem();

		-- If there's anything there...
		if (itemName) then
			-- ... check to see if the subject line is empty.
			local subject = SendMailSubjectEditBox:GetText();
			if (string.len(subject) == 0) then
				-- Subject is empty.  Append the number of items in the stack if needed.
				if (stackCount > 1) then
					itemName = itemName.." x "..stackCount;
				end

				-- Set the subject of the message.
				SendMailSubjectEditBox:SetText(itemName);
			end
		end
	end
end
