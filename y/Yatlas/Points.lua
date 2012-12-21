
local sets = {};
local frames = {};

-- state function
local current_locx_xact, current_locy_xact;
local current_frame, current_viewframe;
local binsert;

local nilfunc = function () end
local emptylist = {};

function YAPoints_RegisterSet(set)
    sets[set.name] = set;
end

function YAPoints_RegisterFrame(...)
    frames[arg[1]] = 0;
end

function YAPoints_ForceUpdate(frame)
    if( not frame) then
        for h,v in pairs(frames) do
            YAPoints_OnMapChange(getglobal(h));
        end
    else
        YAPoints_OnMapChange(frame);
    end
end

function YAPoints_OnMapChange(frame)
    local lm = frame:GetName();

    -- clear all points
    local h = 1;
    while h > 0 do
        local point = getglobal(lm.."Point"..h);
        if(point) then
            point:Clear();
            h = h + 1;
        else
            h = 0;
        end
    end

    local pd_resetlist = getglobal(frame.YA_PD_ResetList);
    if(pd_resetlist) then pd_resetlist(); end

    -- store all points for this map
    frame.points = {};
    current_frame = frame;
    for h,v in pairs(sets) do
        if(v.getpoints) then
            v.getpoints(h, YatlasOptions.Frames[lm].Map);
        end
    end

    -- handle mobile points here to.
    -- Keep in mind, mobile points shouldn't be updated here specifically,
    -- but it gets the job done.
    frame.mobilepoints = {};
    frame.nextmobilepoint = 1;
    if(frame.mobilepointframes == nil) then frame.mobilepointframes = {} end
    for h,v in pairs(sets) do
        if(v.getmobilepoints) then
            v.getmobilepoints(h);
        end
    end

    for id,mp in pairs(frame.mobilepoints) do
        if(mp.locMap ~= map or not mp.locMap) then
            mp:Hide();
        end
    end

    -- force update
    frame.yap_lastx = nil;
    YAPoints_OnMove(frame, unpack(YatlasOptions.Frames[lm].Location));
end

function YAPoints_OnMove(frame, x, y)
    local lm = frame:GetName();
    
    if(frames[lm] == 0) then
        frames[lm] = 1;
        return YAPoints_OnMapChange(frame);
    end

    -- if we have run at this x, y coord recently, don't do it again
    if(frame.yap_lastx == x and frame.yap_lasty == y) then
        -- no change
        return;
    end

    -- update normal points and unit points
    YAPoints_Update(frame, x, y);
--    YAPoints_UpdateP(frame);

    -- hide/update mobile points as needed
    for id,mp in pairs(frame.mobilepoints) do
        if(mp:IsShown()) then
            mp:Update(frame);
        end
    end

    frame.yap_lasty = y;
    frame.yap_lastx = x;
end

function YAPoints_OnUpdate(frame, ela) 
    local lm = frame:GetName();

    for h,v in pairs(sets) do
        if(v.OnUpdate) then
            v.OnUpdate(h, frame, ela);
        end
    end
end

function YAPoints_Update(frame, x, y)
    local lm = frame:GetName();
    local flr,cei=math.floor,math.ceil;
    local z = frame:GetZoom();
    local hpoint = 1;
    local legend = {};
    
    if(x == nil) then
        x = YatlasOptions.Frames[lm].Location[1];
        y = YatlasOptions.Frames[lm].Location[2];
    end
    current_locx_xact = x;
    current_locy_xact = y;

    current_frame = frame;
    current_viewframe = getglobal(lm.."ViewFrame");

    -- ensure that we have loaded the points already
    if(frame.points == nil) then
        return YAPoints_OnMapChange(frame);
    end

    -- clear all points
    for h, point in ipairs(frame.pointframes) do
        if(point and point:IsShown()) then
            point:Clear();
        end
    end

    -- init vispoints
    frame.vispoints = {};
    for h,v in pairs(sets) do
        frame.vispoints[h] = {};
    end

    -- fill vispoints
    for xv = flr(x),cei(x+current_viewframe:GetWidth()/z),1 do
        if(frame.points[xv] ~= nil) then 
            for yv = flr(y),cei(y+current_viewframe:GetHeight()/z),1 do
                if(frame.points[xv][yv] ~= nil) then
                    for k,vv in pairs(frame.points[xv][yv]) do
                        if(vv.x > x and vv.y > y and
                                vv.x < x+current_viewframe:GetWidth()/z and 
                                vv.y < y+current_viewframe:GetHeight()/z) then
                            binsert(frame.vispoints[vv.setname], vv);
                        end
                    end
                end
            end
        end
    end

    local env = {
        current_lm = lm,
        current_frame = current_frame,
        zoom = z,
        iconsize = YatlasOptions.Frames[lm].IconSize
    };

    -- draw visible points
    frame._common_pd = {};
    local id = 1;
    for hset,set in pairs(frame.vispoints) do
        local showornotfunc = sets[hset].showme;
        local pointfunc = sets[hset].setuppoint;
        local legendfunc = sets[hset].setuplegend;

        for hval,val in pairs(set) do
            local point = YAPoints_GetPoint(frame, hpoint);
            local showmemaybe = 
                (not showornotfunc and not YatlasOptions.Frames[lm].PointCfg[val.setsubname]) or
                (showornotfunc and showornotfunc(val, lm) );
            

            if(point and showmemaybe) then

                if(not val.options.commonpd) then
                    val.id = id;
                    id = id + 1;
                end

                point:Clear();
                point:Show();

                -- this gets changed around a lot
                env.iconsize = YatlasOptions.Frames[lm].IconSize;

                -- call functions
                point.dat = val;
                if(pointfunc) then
                    pointfunc(point, env, val);
                end
            elseif(point) then
                hpoint = hpoint-1;
            end

            hpoint = hpoint + 1;
        end
    end
end

function YAPoints_GetPoint(frame, id)
    -- does point exist??
    if(frame.pointframes[id]) then
        return frame.pointframes[id];
    end

    if(id > 4096) then
        -- this is too big by far
        return;
    end

    -- create
    local viewframe = getglobal(frame:GetName().."ViewFrame");
    local f = CreateFrame("Button");

    f:SetHeight(16);
    f:SetWidth(16);
    f:SetParent(viewframe);
    f:EnableMouse(true);

    f.Icon = f:CreateTexture(nil, "OVERLAY");
    f.Icon:SetPoint("TOPLEFT", f);
    
    f.Foreground = f:CreateFontString(nil, "ARTWORK");
    f.Foreground:SetFontObject(GameFontHighlight);
    f.Foreground:SetTextColor(0, 0, 0);
    f.Foreground:SetShadowOffset(-1, 0);
    f.Foreground:SetPoint("TOPLEFT", f);

    f:SetFrameLevel(f:GetFrameLevel() + 4);
    f.Clear = YP_Clear;
    f.SetOffset = YP_SetOffset;

    f:SetScript("OnEnter", YP_OnEnter);

    frame.pointframes[id] = f;
    return f;
end

function YAPoints_AllocMobilePoint(frame, id)
    -- does point exist??
    if(frame.mobilepointframes[id]) then
        return frame.mobilepointframes[id];
    end

    if(id > 1024) then
        -- this is too big by far
        return;
    end

    -- create
    local viewframe = getglobal(frame:GetName().."ViewFrame");
    local f = CreateFrame("Button");

    f:SetHeight(16);
    f:SetWidth(16);
    f:SetParent(viewframe);
    f:EnableMouse(true);

    f.Icon = f:CreateTexture(nil, "OVERLAY");
    f.Icon:SetPoint("TOPLEFT", f);
    
    f.Foreground = f:CreateFontString(nil, "ARTWORK");
    f.Foreground:SetFontObject(GameFontHighlight);
    f.Foreground:SetTextColor(0, 0, 0);
    f.Foreground:SetShadowOffset(-1, 0);
    f.Foreground:SetPoint("TOPLEFT", f);

    f:SetFrameLevel(f:GetFrameLevel() + 4);
    f.Clear = YP_Clear;
    f.SetOffset = YP_SetOffset;
    f.Update = YMP_Update;

    f:SetScript("OnEnter", YP_OnEnter);

    frame.mobilepointframes[id] = f;
    return f;
end

function YAPoints_UpdateTooltip(frame, tooltip, point, op) 
    local dat = point.dat;
    local lm = frame:GetName();

    if(not tooltip.points) then
        tooltip.points = {};
    end

    if(op == "add") then
        if(point.intooltip == nil) then
            tinsert(tooltip.points, point);

            point.intooltip = 1;
        end
    elseif(op == "remove") then
        for h,v in ipairs(tooltip.points) do
            if(v == point) then
                tremove(tooltip.points, h);
                break;
            end
        end

        point.intooltip = nil;
    else
        -- ???
    end

    local env = {
        current_lm = lm,
        current_frame = frame,
        zoom = frame:GetZoom(),
 	iconsize = 14,
        islegend = true,
    };

    if(tooltip.points[1]) then
        local vf = getglobal(lm.."ViewFrame");
        tooltip:Clear();
        for h,point in ipairs(tooltip.points) do
            local legendfunc = sets[point.dat.setname].setuplegend;
            if(legendfunc) then
                local legend = tooltip:GetNext();
                legendfunc(legend, env, point.dat);
            end
            -- tooltip:AddDataPoint(point.dat.name);
        end
        tooltip:Show();
    else
        tooltip:Hide();
    end
end

function YAPoints_showmeornot(frame, val)
    local showornotfunc = sets[val.setname].showme;

    if(type(frame) ~= "string") then
        frame = frame:GetName();
    end

    return
        (not showornotfunc and not YatlasOptions.Frames[frame].PointCfg[val.setsubname]) or
         (showornotfunc and showornotfunc(val, frame) );
end

---
--- point OO implementation
---

function YP_Clear(point)
    point:Hide();
    point:ClearAllPoints();
    point:SetPoint("TOPLEFT", point:GetParent());
    point.Icon:SetTexture(nil);
    point.Icon:SetTexCoord(0, 1, 0, 1);
    point.Foreground:SetText("");
end

function YP_SetOffset(point, x, y) 
    local z = current_frame:GetZoom();
    local lm = current_frame:GetName();
    local iconsz = YatlasOptions.Frames[lm].IconSize;

    point:ClearAllPoints();
    point:SetPoint("TOPLEFT", current_viewframe, "TOPLEFT", 
           -(current_locx_xact - x)*z - iconsz/2,
           (current_locy_xact - y)*z + iconsz/2);
end

function YP_OnEnter()
    local vf = this:GetParent(); 
    local f = vf:GetParent();
    local tp = getglobal(f.hoverTooltip);
    
    vf.inpoint = true;
    if(tp and tp.knownshownlines == nil) then
        tp.knownshownlines = 0;
    end
    
end


function YatlasFrameViewFrame_UpdatePointTooltip() 
    local f = this:GetParent();
    local tp = getglobal(f.hoverTooltip);

    for h,v in pairs(f.pointframes) do
        if(v.intooltip and not MouseIsOver(v)) then
            YAPoints_UpdateTooltip(f, tp, v, "remove");
            tp.knownshownlines = tp.knownshownlines - 1;
        elseif(not v.intooltip and MouseIsOver(v)) then
            YAPoints_UpdateTooltip(f, tp, v, "add");
            tp.knownshownlines = tp.knownshownlines + 1;
        end
    end

    for h,v in pairs(f.mobilepointframes) do
        if(v.intooltip and not MouseIsOver(v)) then
            YAPoints_UpdateTooltip(f, tp, v, "remove");
            tp.knownshownlines = tp.knownshownlines - 1;
        elseif(not v.intooltip and MouseIsOver(v) and v:IsShown()) then
            YAPoints_UpdateTooltip(f, tp, v, "add");
            tp.knownshownlines = tp.knownshownlines + 1;
        end
    end

    if(tp.knownshownlines == 0) then
        this.inpoint = nil;
    end
end

---
---
---

function YAPoints_AddPoint(frame, setname, name, x, y, options, userdat)
    local tab = {
        setname = setname,
        name = name,
        x = x, y = y,
        options = options,
        userdat = userdat
    };

    if(tab.options == nil) then
        tab.options = emptylist;
    end

    if(options and options.setsubname) then
        tab.setsubname = options.setsubname;
    else
        tab.setsubname = tab.setname;
    end

    if(type(frame) ~= "table") then
        frame = current_frame;
    end

    local fx = math.floor(x);
    local fy = math.floor(y);

    if(frame.points[fx] == nil) then frame.points[fx] = {}; end
    if(frame.points[fx][fy] == nil) then frame.points[fx][fy] = {}; end

    tinsert(frame.points[fx][fy], tab);
end

function YAPoints_AddMobilePoint(frame, setname, name, opt, userdat) 
    local tab = {
        setname = setname,
        name = name,
        options = opt,
        userdat = userdat
    };

    if(tab.options == nil) then
        tab.options = emptylist;
    end

    if(options and options.setsubname) then
        tab.setsubname = options.setsubname;
    else
        tab.setsubname = tab.setname;
    end

    if(type(frame) ~= "table") then
        frame = current_frame;
    end

    point = YAPoints_AllocMobilePoint(frame, frame.nextmobilepoint);
    point.dat = tab; 
    frame.nextmobilepoint = frame.nextmobilepoint + 1;

    frame.mobilepoints[setname..":"..name] = point;
    return getn(frame.mobilepoints);
end

function YAPoints_Mobile_SetLocation(setname, name, map, x, y) 
    for framename,v in pairs(frames) do
        local frame = getglobal(framename);
        if(frame:IsVisible()) then
            local d = frame.mobilepoints[setname..":"..name];
            d.locx = x;
            d.locy = y;
            d.locmap = map;
            d:Update(frame);
        end
    end
end

function YAPoints_SetupMobilePoint(setname, name, itahm, prop, ...)
    local whut;
    
    for framename,v in pairs(frames) do
        local frame = getglobal(framename);
        whut = frame.mobilepoints[setname..":"..name][itahm];
        whut[prop](whut, unpack(arg));
    end
end

function YAPoints_SetupMobilePointF(frame, setname, name, itahm, prop, ...)
    local whut;

    if(type(frame) ~= "table") then
        frame = current_frame;
    end

    whut = frame.mobilepoints[setname..":"..name][itahm];
    whut[prop](whut, unpack(arg));
end

function YAPoints_HideMobile(setname, name) 
    for framename,v in pairs(frames) do
        local frame = getglobal(framename);
        if(frame:IsVisible()) then
            local d = frame.mobilepoints[setname..":"..name];
            d.locmap = nil;
            d:Update(frame);
        end
    end
end

function YMP_Update(point, frame)
    local zoom = frame:GetZoom();
    local vf = getglobal(frame:GetName().."ViewFrame")
    local map = frame:GetMap();
    local minx, miny = frame:GetLocation();
    local maxx, maxy = minx + vf:GetWidth()/zoom, miny + vf:GetHeight()/zoom;

    if(map == point.locmap and
            point.locx > minx and point.locx < maxx and
            point.locy > miny and point.locy < maxy) then
        point:SetOffset(point.locx, point.locy);
        point:Show();
    else
        point:Hide();
    end
end


---
--- YFOO: pulldown to control what points are shown.  name has some 
---       historical significance
---

function YFOO_Init(frame)
    if(not frame) then
        frame = this;
    end

    UIDropDownMenu_Initialize(frame, YFOODropDown_Initialize, "MENU");
    UIDropDownMenu_SetButtonWidth(50,frame);
    UIDropDownMenu_SetWidth(50,frame);
end

function YFOODropDown_Initialize()
    local func;

    if(current_frame == nil) then
        return;
    end

    local lm = current_frame:GetName();

    if(UIDROPDOWNMENU_MENU_LEVEL == 1) then
        local info = {};
        info.text = YATLAS_POINTS_SHOWPOINTS_TITLE;
        info.notClickable = 1;
        info.isTitle = 1;
        info.notCheckable = 1;
        UIDropDownMenu_AddButton(info);
    end

    if(YatlasOptions.Frames and YatlasOptions.Frames[lm]) then
        for h,v in pairs(sets) do
            func = v.configmenu;
            if(func) then
                func(h, lm);
            end
        end
    end
end

function YFOO_OnClick()
    current_frame = this;
    while(current_frame and not current_frame.SetLocation) do
        current_frame = current_frame:GetParent()
    end

    if(current_frame:GetName() == "BigYatlasFrame") then
        BigYatlasTooltip:Hide();
    end

    ToggleDropDownMenu(1, nil, getglobal(this:GetName().."DropDown"), this:GetName(), 0, 0);
end

function YFOODropDown_do_toggle_normal()
    YatlasOptions.Frames[current_frame:GetName()].PointCfg[this.value] = UIDropDownMenuButton_GetChecked()
    YAPoints_ForceUpdate(current_frame)
end

---
--- misc
---

-- based on code by ???
binsert = function( t, val)
    local iStart, iEnd, iMid, iState =  1, table.getn( t ), 1, 0

    -- Get Insertposition
    while iStart <= iEnd do
            
            -- calculate middle
            iMid = math.floor( ( iStart + iEnd )/2 )

            -- compare
            if val.name <= t[iMid].name then
                    iEnd = iMid - 1
                    iState = 0
            else
                    iStart = iMid + 1
                    iState = 1
            end
    end

    table.insert( t, ( iMid+iState ), val )
end
