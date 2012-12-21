--[[  LS Chat 1.2
author : Aaike Van Roekeghem - a.k.a [LoSt]Madness

Enables you to remove the buttons next to the chatframes.
The buttons are still clickable eventhough they are invisible , the "Goto Bottom" button will still flash if you are not at the bottom as well. 
The mod also allows you to scroll in the chatframes with the mousewheel and timestamps chat messages as they come in (with or without seconds).

anything this addon does can be enabled/disabled in its options window. open it up with the 
slashcommand : /lschat

changes in 1.2 :
- added support for  MyAddons
- changed toc file for wow version 1600
- empty chat messages will not be displayed with timestamps

changes in 1.1 : 
- There is now an option to disable the chat buttons completely

]]--

--Default Configuration
LSChatConfig = {};
LSChatConfig.HideButtons = false;
LSChatConfig.DisableButtons = false;
LSChatConfig.HideEmote = false;
LSChatConfig.StampEnabled = false;
LSChatConfig.StampSeconds = false;
LSChatConfig.StampStyle = false;

LSChat = {
	
	--local vars
	chatbuttons = {"DownButton",
		"UpButton",
		"BottomButton"
		};

	chatFrames = 7;
	
	--Public Functions
	ToggleButtons = function()
		if(LSChatConfig.HideButtons) then
			LSChat.Show();
		else
			LSChat.Hide();
		end
	end;
	
	ToggleEnabled = function()
		if(LSChatConfig.DisableButtons) then
			LSChat.Enable();
		else
			LSChat.Disable();
		end
	end;
	
	ToggleEmote = function()
		if(ChatFrameMenuButton:IsVisible()) then
			ChatFrameMenuButton:Hide()
			LSChatConfig.HideEmote = true;
		else
			ChatFrameMenuButton:Show()
			LSChatConfig.HideEmote = false;
		end
	end;
	
	ToggleMousewheel = function() 
		if(LSChatConfig.Mousewheel) then
			LSChatConfig.Mousewheel = false;
		else
			LSChatConfig.Mousewheel = true
		end
	end;
	
	
	ToggleStamp = function()
		if(LSChatConfig.StampEnabled)then 
			LSChatConfig.StampEnabled = false;
		else
			LSChatConfig.StampEnabled = true;
		end
	end;
	
	ToggleStampSeconds = function()
		if(LSChatConfig.StampSeconds)then 
			LSChatConfig.StampSeconds = false;
		else
			LSChatConfig.StampSeconds = true;
		end
	end;
	
	ToggleStampStyle = function()
		if(LSChatConfig.StampStyle)then 
			LSChatConfig.StampStyle = false;
		else
			LSChatConfig.StampStyle = true;
		end
	end;

	
	--Private Functions
	OnLoad = function()
		
		
		-- Hook ChatFrame_OnEvent so we can hook AddMessage
		Original_ChatFrame_OnEvent = ChatFrame_OnEvent;
		ChatFrame_OnEvent = LSChat.OnEvent;
		
		SlashCmdList["LOST_CHAT"] = LSChat_ToggleOptions;
		SLASH_LOST_CHAT1 = "/lschat";
	
		
	end;
	
	OnEvent = function(event)
		
		if (event == "VARIABLES_LOADED") then
			
			if (myAddOnsFrame) then
			myAddOnsList.LS_Chat = {
			name = "LS_Chat",
			description = "Removes chat buttons, enables mousewheel scrolling and more",
			version = "1.2", category = MYADDONS_CATEGORY_CHAT,
			frame = "LSChat_Options",
			optionsframe = "LSChat_Options"
			};
			end

			if(LSChatConfig.HideButtons) then
				LSChat.Hide();
			else
				LSChat.Show();
			end
			
			if(LSChatConfig.HideEmote) then
				ChatFrameMenuButton:Hide()
			else
				ChatFrameMenuButton:Show()
			end
			
			
		end
		
		Original_ChatFrame_OnEvent(event); --call the real ChatFrame_OnEvent function
		--if we haven't already done so, hook the AddMessage function
		if(not this.Original_AddMessage) then
			this.Original_AddMessage = this.AddMessage;
			this.AddMessage = LSChat.AddMessage;
		end
	
	end;
	
	Disable = function()
		for i=1, LSChat.chatFrames, 1 do
			for button in LSChat.chatbuttons do
				b = getglobal("ChatFrame".. i .. LSChat.chatbuttons[button]);
				b:EnableMouse(0)
			end
		end
		LSChatConfig.DisableButtons = true;
	end;
	
	Enable = function()
		for i=1, LSChat.chatFrames, 1 do
			for button in LSChat.chatbuttons do
				b = getglobal("ChatFrame".. i .. LSChat.chatbuttons[button]);
				b:EnableMouse(1)
			end
		end
		LSChatConfig.DisableButtons = false;
	end;
	
	
			
	Hide = function()		
		for i=1, LSChat.chatFrames, 1 do
			for button in LSChat.chatbuttons do
				b = getglobal("ChatFrame".. i .. LSChat.chatbuttons[button]);
				b:DisableDrawLayer();
			end
		end
		LSChatConfig.HideButtons = true;
	end;
	
	Show = function()
		for i=1, LSChat.chatFrames, 1 do
			for button in LSChat.chatbuttons do
			b = getglobal("ChatFrame".. i .. LSChat.chatbuttons[button]);
				b:EnableDrawLayer();
			end
		end
		LSChatConfig.HideButtons = false;
	end;
	
	AddMessage = function(this, msg, r, g, b, id)
	
		if(LSChatConfig.StampEnabled) then
			local hour=string.sub(date(),  10, 11)
		
			local minute=string.sub(date(),  13, 14)
		
			local second =string.sub(date(),  16, 17)
			local AMPM
			local newmsg
					
			if LSChatConfig.StampStyle==false then
			
				if tonumber(hour) >12 then
					hour=hour-12
					AMPM="pm"
				else
					hour=string.sub(date(),  11, 11)
					if tonumber(hour)=="0" then
						hour=12
					end
					AMPM="am"
				end
			
			end 
			
			if msg == nil then
				msg="The value was nil"
			end
			newmsg = "["..hour..":"..minute
			
			if(LSChatConfig.StampSeconds) then
			newmsg = newmsg .. ":"..second
			end
			
			newmsg = newmsg .. "]".." "..msg
			
			if newmsg == "" then
				this:Original_AddMessage(msg, r, g, b, id); --call the real AddMessage function
			else
				this:Original_AddMessage(newmsg, r, g, b, id); --call the real AddMessage function
			end
		
		else
			this:Original_AddMessage(msg, r, g, b, id); --call the real AddMessage function
		end
		
	end;

}

