
local landmarkaltinstance = {nil,nil,nil,nil,-1};
local landmarkalttown = {nil,nil,nil,nil,-4};

local set = {name="landmarks"};

function set.getpoints(name, map) 
    -- we got these from map api.  don't use if we see Megellan
    if(type(Yatlas_Landmarks[map]) == "table" and Magellan_Init == nil) then
        for h,v in ipairs(Yatlas_Landmarks[map]) do
            local x,y = Yatlas_Big2Mini_Coord(v[1],v[2]);

            YAPoints_AddPoint(nil, "landmarks", v[3], x, y, nil, Yatlas_Landmarks[map][h]);
        end
    end

    -- we got these...from OURSELVES!
    if(type(Yatlas_instances[map]) == "table") then
        for h,v in ipairs(Yatlas_instances[map]) do
            local x,y = Yatlas_Big2Mini_Coord(v[2],v[3]);

            YAPoints_AddPoint(nil, "landmarks", v[1], x, y, nil, landmarkaltinstance);
        end
    end

     -- 'other towns' ...we got these...from OURSELVES!
    if(type(Yatlas_towns2[map]) == "table") then
        for h,v in ipairs(Yatlas_towns2[map]) do
            local x,y = Yatlas_Big2Mini_Coord(v[2],v[3]);

            YAPoints_AddPoint(nil, "landmarks", v[1], x, y, nil, landmarkalttown);
        end
    end
end

function set.setuppoint(point, env, dat) 
    local text, bg = point.Foreground, point.Icon;
    local x1, x2, y1, y2;
    local r, g, b;
    local bgtextname;
    local iconsize = env.iconsize;

    if(dat.userdat[5] == 4 or dat.userdat[5] == 5 or dat.userdat[5] < 0) then
        x1 = 0; y1 = 0;
        x2 = 1; y2 = 1;

        r = 0.2;
        g = 0.6;
        b = 1;
        bgtextname = "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Circle";
        if(dat.userdat[5] == 5) then
            bgtextname = "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Star";
            iconsize = iconsize+2;
        elseif(dat.userdat[5] == -1) then
            r = 0.9;
            g = 0.1;
            b = 0.9;
            bgtextname = "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Cave";
        elseif(dat.userdat[5] == -4) then
            r = 0.3;
            g = 0.8;
            b = 1;
            bgtextname = "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Exclaim";
        end
    else
       x1, x2, y1, y2 = WorldMap_GetPOITextureCoords(dat.userdat[5]);
       r,g,b = 1,1,1;
       bgtextname  = "Interface\\Minimap\\POIIcons"
    end

    point:Show();
    point:SetOffset(dat.x, dat.y);
    text:SetText("");

    bg:Show();
    bg:SetHeight(iconsize);
    bg:SetWidth(iconsize);
    bg:SetTexture(bgtextname);
    bg:SetTexCoord(x1, x2, y1, y2);
    bg:SetVertexColor(r, g, b, 1);
end

function set.setuplegend(point, env, dat)
    env.iconsize = 16;
    set.setuppoint(point, env, dat);

    point.Text:SetText(dat.name);
end

function set.configmenu(name, lm)
    if(UIDROPDOWNMENU_MENU_LEVEL == 1) then
        local info = {};
        info.text = YATLAS_POINTS_LANDMARKS;
        info.func = YFOODropDown_do_toggle_normal;
        info.checked = YatlasOptions.Frames[lm].PointCfg and not YatlasOptions.Frames[lm].PointCfg[name];
        info.value = name;
        info.keepShownOnClick = 1;
        UIDropDownMenu_AddButton(info);
    end
end

YAPoints_RegisterSet(set);

