--[[   
Name: idChat2_Buttons
Developed by: Curney of Uther
Originally by: Industrial
Thanks to: Wubin for helping me understand hooking better
Website: http://wiki.wowace.com/idChat2_Buttons
SVN: http://svn.wowace.com/root/trunk/idChat2_Buttons
Description: Module for idChat2 that toggles the chat menu and chat window buttons on and off (default=off).
Dependencies: idChat2
]]

idChat2_Buttons = idChat2:NewModule('buttons')

function idChat2_Buttons:OnInitialize()

    self.db = idChat2:AcquireDBNamespace('Buttons')

    idChat2:RegisterDefaults('Buttons', 'profile', {
        on = true,
        default = true,
        menu = false,
        chatframe = {false, false, false, false, false, false, false}
    })

    idChat2.Options.args.buttons = {
        name = "Buttons",
        desc = "Toggle the chat menu and chat window buttons on and off (default=off)",
        type = "group",
        args = {
            toggle = {
                name = "Toggle",
                desc = "Toggle the module on and off",
                type = "toggle",
                get = function() return self.db.profile.on end,
                set = function(v)
                    if v then
                        self:OnEnable()
                    else
                        self:OnDisable()
                    end
                    self.db.profile.on = v
                end
            },
        		chatmenu = {
        			 name = "ChatMenu",
        	    	 type = "toggle",
        	    	 desc = "Toggles chat menu on and off",
        	    	 get = function() return self.db.profile.menu end,
                set = function(v)
                    self.db.profile.menu = v
                    self:Menu(v)
                end
        		},
        		chat1 = {
        			 name = "Chat1Buttons",
        	    	 type = "toggle",
        	    	 desc = "Toggles buttons on and off for chat window 1",
        	    	 get = function() return self.db.profile.chatframe[1] end,
                set = function(v)
                    self.db.profile.chatframe[1] = v
                    self:Buttons(1,v)
                end
        		},
        		chat2 = {
        			 name = "Chat2Buttons",
        	    	 type = "toggle",
        	    	 desc = "Toggles buttons on and off for chat window 2",
        	    	 get = function() return self.db.profile.chatframe[2] end,
                set = function(v)
                    self.db.profile.chatframe[2] = v
                    self:Buttons(2,v)
                end
        		},
        		chat3 = {
        			 name = "Chat3Buttons",
        	    	 type = "toggle",
        	    	 desc = "Toggles buttons on and off for chat window 3",
        	    	 get = function() return self.db.profile.chatframe[3] end,
                set = function(v)
                    self.db.profile.chatframe[3] = v
                    self:Buttons(3,v)
                end
        		},
        		chat4 = {
        			 name = "Chat4Buttons",
        	    	 type = "toggle",
        	    	 desc = "Toggles buttons on and off for chat window 4",
        	    	 get = function() return self.db.profile.chatframe[4] end,
                set = function(v)
                    self.db.profile.chatframe[4] = v
                    self:Buttons(4,v)
                end
        		},
        		chat5 = {
        			 name = "Chat5Buttons",
        	    	 type = "toggle",
        	    	 desc = "Toggles buttons on and off for chat window 5",
        	    	 get = function() return self.db.profile.chatframe[5] end,
                set = function(v)
                    self.db.profile.chatframe[5] = v
                    self:Buttons(5,v)
                end
        		},
        		chat6 = {
        			 name = "Chat6Buttons",
        	    	 type = "toggle",
        	    	 desc = "Toggles buttons on and off for chat window 6",
        	    	 get = function() return self.db.profile.chatframe[6] end,
                set = function(v)
                    self.db.profile.chatframe[6] = v
                    self:Buttons(6,v)
                end
        		},
        		chat7 = {
        		    name = "Chat7Buttons",
        	    	 type = "toggle",
        	    	 desc = "Toggles buttons on and off for chat window 7",
        	    	 get = function() return self.db.profile.chatframe[7] end,
                set = function(v)
                    self.db.profile.chatframe[7] = v
                    self:Buttons(7,v)
                end
        		}
        }
    }
end

function idChat2_Buttons:OnEnable()
    self:Hook("ChatFrame_OnUpdate")
end

function idChat2_Buttons:OnDisable()
    self:Unhook("ChatFrame_OnUpdate")
    self:Menu(self.db.profile.default)
    for i = 1, 7 do
        self:Buttons(i,self.db.profile.default)
    end
end

function idChat2_Buttons:ChatFrame_OnUpdate(elapsed)
    self.hooks["ChatFrame_OnUpdate"](elapsed)
    self:Control()
end

function idChat2_Buttons:Control()
    self:Menu(self.db.profile.menu)
    for i = 1, 7 do
        self:Buttons(i,self.db.profile.chatframe[i])
    end
end

function idChat2_Buttons:Menu(visible)
    if visible then
        ChatFrameMenuButton:Show()
    else
        ChatFrameMenuButton:Hide()
    end
end

function idChat2_Buttons:Buttons(frame,visible)
    if visible then
        getglobal('ChatFrame'..frame..'UpButton'):Show()
        getglobal('ChatFrame'..frame..'DownButton'):Show()
        getglobal('ChatFrame'..frame..'BottomButton'):Show()
    else
        getglobal('ChatFrame'..frame..'UpButton'):Hide()
        getglobal('ChatFrame'..frame..'DownButton'):Hide()
        getglobal('ChatFrame'..frame..'BottomButton'):Hide()
    end
end
