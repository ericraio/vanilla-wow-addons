--[[
	SimpleMail
			
		copyright 2005 by Charettejc
		
	- keeps the recipient's name in the name box, and auto fills the subject line when:
	  1.  you drop and item on the attachment slot, and
	  2.  the subject line is empty of letters and spaces.
		
	- version 1.13
	
	- Thanks goes out to Thott and Kugnar, they're the one's that developed this code in
	  their email addons.
	  
	- History
	
		2/27/05		v1.13
					- SimpleMail will remember recipient's name between sessions.
					
					v1.12
					- update toc file to v4222
	
		2/21/05		v1.1.1
					- updated toc file to v4211
]]

local SIMPLEMAIL_VERSION	= "1.13";

local TEXT_LOAD1	= "|cffffff00SimpleMail|r |cff00ff00v%.2f|r|cffffff00 loaded.|r";

local SimpleMail_SavedMailFrameReset;

function SimpleMail_OnLoad()
	--[[
		I'm replacing the SendMailFrame_Reset() used by Blizzard.  It's this function
		that empties all the boxes on the mail frame.  Now my SimpleMailFrame_Reset()
		will be called instead.
	]]
	SimpleMail_SavedMailFrameReset = SendMailFrame_Reset;
	SendMailFrame_Reset = SimpleMailFrame_Reset;
	
	--[[
		registering the MAIL_SEND_INFO_UPDATE event, so I can update the subject line
		whenever an item is attached.
	]]
	this:RegisterEvent( "MAIL_SEND_INFO_UPDATE" );
	this:RegisterEvent( "VARIABLES_LOADED" );
	this:RegisterEvent( "MAIL_SHOW" );
	this:RegisterEvent( "MAIL_SEND_SUCCESS" );
	
	--[[
		register saved variable and initialize it if this is first use of addon.
	]]
	-- RegisterForSave( "SimpleMailState" );
	
	--[[
		tell the user the mod is loaded.
	]]
	--SimpleMail_Print( format( TEXT_LOAD1, SIMPLEMAIL_VERSION ) );
end

function SimpleMailFrame_Reset()
	-- move the cursor to the subject box if we have text in the name box.
	if ( SendMailNameEditBox:GetText() and SendMailNameEditBox:GetText() ~= "" ) then
		SendMailSubjectEditBox:SetFocus();
	else
		SendMailNameEditBox:SetFocus();
	end
	
	-- do everything SendMailFrame_Reset() does except empty name box.
	SendMailSubjectEditBox:SetText("");
	SendMailBodyEditBox:SetText("");
	StationeryPopupFrame.selectedIndex = nil;
	SendMailFrame_Update();
	StationeryPopupButton_OnClick(1);
	MoneyInputFrame_ResetMoney(SendMailMoney);
	SendMailRadioButton_OnClick(1);	
end

function SimpleMail_OnEvent()
	if ( event == "MAIL_SEND_INFO_UPDATE" ) then		
		local itemName, itemTexture, stackCount, quality = GetSendMailItem();		
		if ( itemName ) then
			local subject = SendMailSubjectEditBox:GetText();
			if ( not(subject) or subject == "" ) then
				if (stackCount and stackCount > 1) then
					SendMailSubjectEditBox:SetText(stackCount.."x "..itemName);
				else
					SendMailSubjectEditBox:SetText(itemName);
				end
			end
		end
	elseif event == "VARIABLES_LOADED" then
		--[[
			initialize SimpleMailState if this is first use of SimpleMail
		]]
		if not SimpleMailState then
			SimpleMailState = { LastRecipient = nil };
		end
		--if SimpleMailState.LastRecipient then
			--SimpleMail_Print( "simplemail : onload : last recipient is "..SimpleMailState.LastRecipient );
		--end
	elseif event == "MAIL_SHOW" then
		--SimpleMail_Print( "simplemail : onevent : mail show called." );
		if SimpleMailState.LastRecipient then
			SendMailNameEditBox:SetText( SimpleMailState.LastRecipient );
		end
	elseif event == "MAIL_SEND_SUCCESS" then
		--SimpleMail_Print( "simplemail : onevent : mail send success called." );		
		SimpleMail_UpdateState();
	end
end

function SimpleMail_UpdateState ()
	local txt = SendMailNameEditBox:GetText();
	if txt == "" then
		-- don't do anything
	else
		--SimpleMail_Print( "simplemail : updatestate : name is "..txt.."." );
		SimpleMailState.LastRecipient = txt;
	end
end

function SimpleMail_Print( msg )
	if DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage( msg );
	end
end