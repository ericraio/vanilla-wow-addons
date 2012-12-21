
local set = {name="ctmapmod"};

function set.getpoints(name, map)
    if(CT_UserMap_Notes) then
        for zid,zonename in pairs(Yatlas_PaperZoneNames[map]) do
            if(CT_UserMap_Notes[zonename]) then
                local real_zid;
                for h,v in pairs(Yatlas_areadb) do
                    if(v[2] == zonename) then
                        real_zid = h;
                        break;
                    end
                end

                local x1,x2,y1,y2,x,y,ops;
                x1 = Yatlas_mapareas[map][real_zid][1];
                x2 = Yatlas_mapareas[map][real_zid][2];
                y1 = Yatlas_mapareas[map][real_zid][3];
                y2 = Yatlas_mapareas[map][real_zid][4];

                for id,dat in ipairs(CT_UserMap_Notes[zonename]) do
                    ops = {};
                    
                    x,y = Yatlas_Big2Mini_Coord(-dat.x*(x1-x2) + x1, -dat.y*(y1-y2) + y1);

                    if(dat.set ~= 1 and dat.set ~= 6) then
                        ops = {commonpd="g"..dat.name};
                    end

                    YAPoints_AddPoint(nil, "ctmapmod", dat.name, x, y, ops, dat); 
                end
            end
        end
    end
end

function set.setuppoint(point, env, dat) 
    local text, bg = point.Foreground, point.Icon;

    local iconname = "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Square";
    local iconszw = env.iconsize/2+2;

    -- ctmapmod knows best...
    if ( dat.userdat.set == 7 or dat.userdat.set == 8 ) then
        local offset = 0;
        if ( dat.userdat.set == 8 ) then
                offset = 29;
        end
        if ( CT_UserMap_HerbIcons[dat.userdat.icon+offset] ) then
                iconname = "Interface\\AddOns\\CT_MapMod\\Resource\\" .. CT_UserMap_HerbIcons[dat.userdat.icon+offset];
        else
                iconname = "Interface\\AddOns\\CT_MapMod\\Resource\\Herb_Bruiseweed";
        end
    else
        iconname = "Interface\\AddOns\\CT_MapMod\\Skin\\" .. CT_UserMap_Icons[dat.userdat.set];
    end

    text:SetText("");
    point:Show();
    point:SetOffset(dat.x, dat.y);

    bg:Show();
    bg:SetHeight(iconszw*2);
    bg:SetWidth(iconszw*2);
    bg:SetTexture(iconname);
    bg:SetVertexColor(1,1,1,1);
end

function set.setuplegend(point, env, dat)
    env.iconsize = 15;
    set.setuppoint(point, env, dat);

    point.Text:SetText(dat.name);
end

function set.configmenu(name, lm)
    if(CT_MapMod_AddNote) then
        local info;
        if(UIDROPDOWNMENU_MENU_LEVEL == 1) then
            info = {};
            info.text = YATLAS_POINTS_CTMAPMOD;
            info.func = YFOODropDown_do_toggle_normal;
            info.checked = YatlasOptions.Frames[lm].PointCfg 
                and not YatlasOptions.Frames[lm].PointCfg[name];
            info.value = name;
            info.keepShownOnClick = 1;
            UIDropDownMenu_AddButton(info);
        end
    end
end

YAPoints_RegisterSet(set);
