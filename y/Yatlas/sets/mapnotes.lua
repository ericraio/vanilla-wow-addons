
local set = {name="mapnotes"};

function set.getpoints(name, map)
    if(MapNotes_Data and MapNotes_Data[Yatlas_WorldMapIds[map]]) then
        for zid,zdat in ipairs(MapNotes_Data[Yatlas_WorldMapIds[map]]) do
            local zname = Yatlas_PaperZoneNames[map][zid];
            if(zname ~= nil) then
                local real_zid;
                for h,v in pairs(Yatlas_areadb) do
                    if(v[2] == zname) then
                        real_zid = h;
                        break;
                    end
                end

                if(real_zid ~= nil) then
                    local x1,x2,y1,y2,x,y;
                    x1 = Yatlas_mapareas[map][real_zid][1];
                    x2 = Yatlas_mapareas[map][real_zid][2];
                    y1 = Yatlas_mapareas[map][real_zid][3];
                    y2 = Yatlas_mapareas[map][real_zid][4];

                    for i,notes in ipairs(zdat) do
                        x,y = Yatlas_Big2Mini_Coord(-notes.xPos*(x1-x2) + x1, -notes.yPos*(y1-y2) + y1);

                        YAPoints_AddPoint(nil, "mapnotes", notes.name, x, y, nil, notes);
                    end
                end
            end
        end
    end
end

function set.setuppoint(point, env, dat) 
    local text, bg = point.Foreground, point.Icon;
    local icon = dat.userdat.icon;

    local color = {1,1,1,1};
    local iconname = "Icon-Square";
    if(icon) then
        if(icon >= 5) then 
            iconname = "Icon-Diamond";
            icon = icon - 5;
        end
        if(icon == 0) then
            color = {1,1,0,1};
        elseif(icon == 1) then
            color = {1,0.1,0.1,1};
        elseif(icon == 2) then
            color = {0.4,0.2,0.95,1};
        elseif(icon == 3) then
            color = {0.1, 1, 0.2,1};
        elseif(icon == 4) then
            color = {1,0.4,0.8,1};
        end
    end

    point:Show();
    point:SetOffset(dat.x, dat.y);

    bg:Show();
    bg:SetHeight(env.iconsize);
    bg:SetWidth(env.iconsize);
    bg:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\"..iconname);
    bg:SetVertexColor(unpack(color));

    if(dat.id > 32) then
        text:SetText("");
    else
        local tz = env.iconsize-2;
        text:SetText(dat.id);
        repeat
            text:SetTextHeight(tz);
            tz = tz - 1;
        until (text:GetStringWidth() < env.iconsize-1)
    end
end

function set.setuplegend(point, env, dat)
    env.iconsize = 15;
    set.setuppoint(point, env, dat);

    point.Text:SetText(dat.name);
end


function set.configmenu(name, lm)
    if(MapNotes_DeleteNote and UIDROPDOWNMENU_MENU_LEVEL == 1) then
        local info = {};
        info.text = YATLAS_POINTS_MAPNOTES;
        info.func = YFOODropDown_do_toggle_normal;
        info.checked = YatlasOptions.Frames[lm].PointCfg 
                and not YatlasOptions.Frames[lm].PointCfg[name];
        info.value = name;
        info.keepShownOnClick = 1;
        UIDropDownMenu_AddButton(info);
    end
end

YAPoints_RegisterSet(set);
