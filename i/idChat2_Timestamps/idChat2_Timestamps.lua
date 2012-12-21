idChat2_Timestamps = idChat2:NewModule('timestamps')

function idChat2_Timestamps:OnInitialize()
    self.db = idChat2:AcquireDBNamespace('Timestamps')

    idChat2:RegisterDefaults('Timestamps', 'profile', {
        on = true,
        ChatFrame1 = true,
        ChatFrame2 = true,
        ChatFrame3 = true,
        ChatFrame4 = true,
        ChatFrame5 = true,
        ChatFrame6 = true,
        ChatFrame7 = true,
        Format = '%X',
        Color = {
            r = 1,
            g = 1,
            b = 1,
            On = true
        }
    })

    idChat2.Options.args.timestamps = {
        name = 'Timestamps',
        desc = 'Timestamps',
        type = 'group',
        args = {
            toggle = {
                name = 'Toggle',
                desc = 'Toggle the module on and off',
                type = 'toggle',
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
            format = {
                name = 'Format',
                desc = 'The format to print the timestamps in. This is strftime format.',
                type = 'text',
                usage = '<string>',
                get = function() return self.db.profile.Format end,
                set = function(v) self.db.profile.Format = v end
            },
            color = {
                name = 'Color',
                type = 'group',
                desc = 'Settings for the color of the timestamp.',
                args = {
                    color = {
                        name = 'Color',
                        type = 'color',
                        desc = "Change the color of the timestamp.",
                        get = function() return self.db.profile.Color.r, self.db.profile.Color.g, self.db.profile.Color.b end,
                        set = function(r, g, b, a) self.db.profile.Color.r, self.db.profile.Color.g, self.db.profile.Color.b = r, g, b end,
                    },
                    toggle = {
                        name = 'Toggle',
                        desc = 'Toggle the timestamp color on and off.',
                        type = 'toggle',
                        get = function() return self.db.profile.Color.On end,
                        set = function(v) self.db.profile.Color.On = v end
                    }
                }
            },
            chatframe1 = {
                name = 'Chatframe1 Toggle',
                desc = 'Toggle the timestamp for chatframe1 on and off',
                type = 'toggle',
                get = function() return self:GetChatFrameStatus(1) end,
                set = function(v) self:SetChatFrameStatus(1, v) end
            },
            chatframe2 = {
                name = 'Chatframe2 Toggle',
                desc = 'Toggle the timestamp for chatframe2 on and off',
                type = 'toggle',
                get = function() return self:GetChatFrameStatus(2) end,
                set = function(v) self:SetChatFrameStatus(2, v) end
            },
            chatframe3 = {
                name = 'Chatframe3 Toggle',
                desc = 'Toggle the timestamp for chatframe3 on and off',
                type = 'toggle',
                get = function() return self:GetChatFrameStatus(3) end,
                set = function(v) self:SetChatFrameStatus(3, v) end
            },
            chatframe4 = {
                name = 'Chatframe4 Toggle',
                desc = 'Toggle the timestamp for chatframe4 on and off',
                type = 'toggle',
                get = function() return self:GetChatFrameStatus(4) end,
                set = function(v) self:SetChatFrameStatus(4, v) end
            },
            chatframe5 = {
                name = 'Chatframe5 Toggle',
                desc = 'Toggle the timestamp for chatframe5 on and off',
                type = 'toggle',
                get = function() return self:GetChatFrameStatus(5) end,
                set = function(v) self:SetChatFrameStatus(5, v) end
            },
            chatframe6 = {
                name = 'Chatframe6 Toggle',
                desc = 'Toggle the timestamp for chatframe6 on and off',
                type = 'toggle',
                get = function() return self:GetChatFrameStatus(6) end,
                set = function(v) self:SetChatFrameStatus(6, v) end
            },
            chatframe7 = {
                name = 'Chatframe7 Toggle',
                desc = 'Toggle the timestamp for chatframe7 on and off',
                type = 'toggle',
                get = function() return self:GetChatFrameStatus(7) end,
                set = function(v) self:SetChatFrameStatus(7, v) end
            }
        }
    }
end

function idChat2_Timestamps:OnEnable()
    for i=1,7 do
        self:Hook(getglobal('ChatFrame'..i), 'AddMessage')
    end
end

function idChat2_Timestamps:OnDisable()
    for i=1,7 do
        self:Unhook(getglobal('ChatFrame'..i), 'AddMessage')
    end
end

function idChat2_Timestamps:GetChatFrameStatus(id)
    return self.db.profile['ChatFrame'..id]
end

function idChat2_Timestamps:SetChatFrameStatus(id, bool)
    self.db.profile['ChatFrame'..id] = bool
    if bool then
        self:Hook(getglobal('ChatFrame'..id), 'AddMessage')
    else
        self:Unhook(getglobal('ChatFrame'..id), 'AddMessage')
    end
end

function idChat2_Timestamps:AddMessage(frame, text, red, green, blue, id)
    if self.db.profile[frame:GetName()] then
        if self.db.profile.Color.On then
            local color = string.format("%02x%02x%02x", self.db.profile.Color.r*255, self.db.profile.Color.g*255, self.db.profile.Color.b*255)
            text = string.format('|cff'..color..'%s|r %s', date(self.db.profile.Format), text)
        else
            text = string.format('%s %s', date(self.db.profile.Format), text)
        end
    end

    self.hooks[frame].AddMessage.orig(frame, text, red, green, blue, id)
end

