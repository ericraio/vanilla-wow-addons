idChat2_Scroll = idChat2:NewModule('scroll')

function idChat2_Scroll:OnInitialize()
    local db = idChat2.db.profile

    if not db.Scroll then
        db.Scroll = {
            on = true
        }
    end

    idChat2.Options.args.scroll = {
        name = 'Scroll',
        desc = 'Scroll',
        type = 'group',
        args = {
            toggle = {
                name = 'Toggle',
                desc = 'Toggle the module on and off',
                type = 'toggle',
                get = function() return db.Scroll.on end,
                set = function(v)
                    if v then
                        self:OnEnable()
                    else
                        self:OnDisable()
                    end
                    db.Scroll.on = v
                end
            }
        }
    }
end

function idChat2_Scroll:OnEnable()
    for i = 1, 7 do
        local cf = getglobal('ChatFrame'..i)
        cf:SetScript('OnMouseWheel', function() self:Scroll() end)
        cf:EnableMouseWheel(true)
    end
end

function idChat2_Scroll:OnDisable()
    for i = 1, 7 do
        local cf = getglobal('ChatFrame'..i)
        cf:SetScript('OnMouseWheel', nil)
        cf:EnableMouseWheel(false)
    end
end

function idChat2_Scroll:Scroll()
    if arg1 > 0 then
        if IsShiftKeyDown() then
            this:ScrollToTop()
        else
            this:ScrollUp()
        end
    elseif arg1 < 0 then
        if IsShiftKeyDown() then
            this:ScrollToBottom()
        else
            this:ScrollDown()
        end
    end
end

