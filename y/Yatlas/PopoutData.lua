
YA_pd_nextfree_text = 1;

YA_pd_blinking = nil;

function yapd_raw_setoff(tx, px, py) 
     tx:SetPoint("TOPLEFT", "YatlasPopoutData",
             "TOPLEFT", px, -py);
end

function YA_PD_ResetList()
    -- Hide everything...
    for h = 1,32 do
        getglobal("YatlasPopoutDataIcon"..h):Hide();
        getglobal("YatlasPopoutDataBGIcon"..h):Hide();
        getglobal("YatlasPopoutDataText"..h):Hide();
        getglobal("YatlasPopoutDataText"..h).myOTextures = {};
        getglobal("YatlasPopoutDataIcon"..h):SetTexCoord(0, 1, 0, 1);
        getglobal("YatlasPopoutDataBGIcon"..h):SetTexCoord(0, 1, 0, 1);
    end

    YA_pd_nextfree_text = 1;
end

function YA_PD_allocText()
    local al = getglobal("YatlasPopoutDataText"..YA_pd_nextfree_text);
    local ali = getglobal("YatlasPopoutDataIcon"..YA_pd_nextfree_text);
    local bg = getglobal("YatlasPopoutDataBGIcon"..YA_pd_nextfree_text);

    if(al == nil) then return nil; end

    if(YA_pd_nextfree_text == 1) then
        al:SetPoint("TOPLEFT","YatlasPopoutData","TOPLEFT",32,-12);
    else
        al:SetPoint("TOPLEFT",
                "YatlasPopoutDataText"..(YA_pd_nextfree_text-1),
                "BOTTOMLEFT",0,-2);
    end
    ali:SetPoint("TOPLEFT",al,"TOPLEFT",-20,0);
    al:SetHeight(13);                           -- TODO: delete me??

    YA_pd_nextfree_text = YA_pd_nextfree_text + 1;

    return al,ali,bg;
end

local blink_state = 0;
function YatlasPopoutData_OnClick()
    local yz = 12;
    local x, y = GetCursorPosition();
    local top = this:GetTop();
    local hei = YatlasPopoutDataText1:GetHeight();

    x = x/this:GetEffectiveScale();
    y = y/this:GetEffectiveScale();

    for h = 1,YA_pd_nextfree_text-1 do
        -- FIXME: this next line is done SO wrong, and is extremely temporary
       --     yz = yz + getglobal("YatlasPopoutDataText"..h):GetHeight()/this:GetEffectiveScale();
        yz = yz + 15;
        -- getglobal("YatlasPopoutDataText"..h):GetHeight()/this:GetEffectiveScale();
        --((this:GetEffectiveScale()+1)/2)
        if(top-yz < y) then
            YatlasPopoutData_StopBlinking()
            YA_pd_blinking = h;
            blink_state = 0;
            break;
        end
    end
end

function YatlasPopoutData_StopBlinking()
    if(YA_pd_blinking == nil) then 
        return;
    end

    local text = getglobal("YatlasPopoutDataText"..YA_pd_blinking);
    local icon = getglobal("YatlasPopoutDataIcon"..YA_pd_blinking);
    local bgicon = getglobal("YatlasPopoutDataBGIcon"..YA_pd_blinking);

    if(text.origVisible) then
        text:Show();
    end
    if(icon.origVisible) then
        icon:Show();
    end
    if(bgicon.origVisible) then
        bgicon:Show();
    end
    for i,v in ipairs(text.myOTextures) do
        tx = getglobal("YatlasFrameOTexture"..v);
        if(tx.origVisible) then
            tx:Show();
        end
    end
    for i,v in ipairs(text.myOTextures) do
        tx = getglobal("YatlasFrameOBGTexture"..v);
        if(tx.origVisible) then
            tx:Show();
        end
    end

    YA_pd_blinking = nil;
end

function YatlasPopoutData_OnUpdate()
    
    if(YA_pd_blinking) then
        this.elapsedupdate = this.elapsedupdate + arg1;
        if(this.elapsedupdate > 0.3 or blink_state == 0) then
            local text = getglobal("YatlasPopoutDataText"..YA_pd_blinking);
            local icon = getglobal("YatlasPopoutDataIcon"..YA_pd_blinking);
            local bgicon = getglobal("YatlasPopoutDataBGIcon"..YA_pd_blinking);
            local tx;

            if(blink_state == 0) then
                text.origVisible = text:IsVisible();
                icon.origVisible = icon:IsVisible();
                bgicon.origVisible = bgicon:IsVisible();
                for i,v in ipairs(text.myOTextures) do
                    tx = getglobal("YatlasFrameOTexture"..v);
                    tx.origVisible = tx:IsVisible();
                end
                for i,v in ipairs(text.myOTextures) do
                    tx = getglobal("YatlasFrameOBGTexture"..v);
                    tx.origVisible = tx:IsVisible();
                end
            end

            blink_state = blink_state + 1;
            if(math.mod(blink_state, 2) == 1) then
                if(text.origVisible) then
                    text:Hide();
                end
                if(icon.origVisible) then
                    icon:Hide();
                end
                if(bgicon.origVisible) then
                    bgicon:Hide();
                end
                for i,v in ipairs(text.myOTextures) do
                    tx = getglobal("YatlasFrameOTexture"..v);
                    if(tx.origVisible) then
                        tx:Hide();
                    end
                end
                for i,v in ipairs(text.myOTextures) do
                    tx = getglobal("YatlasFrameOBGTexture"..v);
                    if(tx.origVisible) then
                        tx:Hide();
                    end
                end
            else
                if(text.origVisible) then
                    text:Show();
                end
                if(icon.origVisible) then
                    icon:Show();
                end
                if(bgicon.origVisible) then
                    bgicon:Show();
                end
                for i,v in ipairs(text.myOTextures) do
                    tx = getglobal("YatlasFrameOTexture"..v);
                    if(tx.origVisible) then
                        tx:Show();
                    end
                end
                for i,v in ipairs(text.myOTextures) do
                    tx = getglobal("YatlasFrameOBGTexture"..v);
                    if(tx.origVisible) then
                        tx:Show();
                    end
                end
            end

            if(blink_state == 7) then
                YatlasPopoutData_StopBlinking()
            end
            this.elapsedupdate = 0;
        end
    end
end
