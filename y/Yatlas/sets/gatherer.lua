
local set = {name="gatherer"};

function set.getpoints(name, map)
    if(GatherItems and GatherItems[Yatlas_WorldMapIds[map]]) then
        for zid,zdat in pairs(GatherItems[Yatlas_WorldMapIds[map]]) do
            local zname = Yatlas_PaperZoneNames[map][zid];
            if(zname ~= nil) then
                local real_zid;
                for h,v in pairs(Yatlas_areadb) do
                    if(v[2] == zname) then
                        real_zid = h;
                        break;
                    end
                end

                local x1,x2,y1,y2,x,y;
                x1 = Yatlas_mapareas[map][real_zid][1];
                x2 = Yatlas_mapareas[map][real_zid][2];
                y1 = Yatlas_mapareas[map][real_zid][3];
                y2 = Yatlas_mapareas[map][real_zid][4];

                for typ,datz in pairs(zdat) do

                    for i,notes in ipairs(datz) do
                        x,y = Yatlas_Big2Mini_Coord(-notes.x*(x1-x2)/100 + x1, -notes.y*(y1-y2)/100 + y1);

                        local utyp = string.gsub(typ, ".", string.upper, 1)  
                        YAPoints_AddPoint(nil, "gatherer", utyp, x, y, {commonpd="ga"..utyp}, notes);
                    end
                end
            end
        end
    end
end

function set.setuppoint(point, env, dat) 
    local text, bg = point.Foreground, point.Icon;

    local iconname = "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Square";
    if(Gather_IconSet) then
        local gtype = dat.userdat.gtype;
        local gtype_str = gtype;
        if (type(gtype) == "number") then
            gtype_str = Gather_DB_TypeIndex[gtype];
        end

        -- map
        local namei = "default";
        if(type(Gather_DB_IconIndex[gtype]) == "table") then
            for h,v in pairs(Gather_DB_IconIndex[gtype]) do
                if(v == dat.userdat.icon) then namei = h; break; end
            end
        elseif(type(dat.userdat.icon) == "string") then
            namei = dat.userdat.icon;
        end

        local icons = Gather_IconSet["iconic"][gtype_str];
        if(icons[namei]) then
            iconname = icons[namei];
        elseif(icons["default"]) then
            iconname = icons["default"];
        end
    end

    text:SetText("");
    point:Show();
    point:SetOffset(dat.x, dat.y);

    bg:Show();
    bg:SetHeight(env.iconsize);
    bg:SetWidth(env.iconsize);
    bg:SetTexture(iconname);
    bg:SetVertexColor(1,1,1,1);
end

function set.setuplegend(point, env, dat)
    env.iconsize = 15;
    set.setuppoint(point, env, dat);

    point.Text:SetText(dat.name);
end

function set.configmenu(name, lm)
    if(Gatherer_AddGatherHere) then
        local info = {};
        if(UIDROPDOWNMENU_MENU_LEVEL == 1) then
            info.text = YATLAS_POINTS_GATHERER;
            info.func = YFOODropDown_do_toggle_normal;
            info.checked = YatlasOptions.Frames[lm].PointCfg and not YatlasOptions.Frames[lm].PointCfg[name];
            info.value = name;
            info.keepShownOnClick = 1;
            info.hasArrow = 1;
            UIDropDownMenu_AddButton(info);
        elseif(UIDROPDOWNMENU_MENU_LEVEL == 2) then
            info.text = YATLAS_POINTS_GATHERER_TREASURE;
            info.func = YFOODropDown_do_toggle_normal;
            info.value = name.."_Treasure";
            info.checked = YatlasOptions.Frames[lm].PointCfg and not YatlasOptions.Frames[lm].PointCfg[info.value];
            info.keepShownOnClick = 1;
            UIDropDownMenu_AddButton(info, 2);

            info = {};
            info.text = YATLAS_POINTS_GATHERER_ORES;
            info.func = YFOODropDown_do_toggle_normal;
            info.value = name.."_Ore";
            info.checked = YatlasOptions.Frames[lm].PointCfg and not YatlasOptions.Frames[lm].PointCfg[info.value];
            info.keepShownOnClick = 1;
            UIDropDownMenu_AddButton(info, 2);

            info = {};
            info.text = YATLAS_POINTS_GATHERER_HERBS;
            info.func = YFOODropDown_do_toggle_normal;
            info.value = name.."_Herb";
            info.checked = YatlasOptions.Frames[lm].PointCfg and not YatlasOptions.Frames[lm].PointCfg[info.value];
            info.keepShownOnClick = 1;
            UIDropDownMenu_AddButton(info, 2);
        end
    end
end

function set.showme(v, lm)
   if(lm == nil) then
        lm = current_frame:GetName();
   end

   if(YatlasOptions.Frames[lm].PointCfg and 
            YatlasOptions.Frames[lm].PointCfg["gatherer"]) then
        return false;
   end

   local gtype = v.userdat.gtype;
   if (type(gtype) == "number") then
        gtype = Gather_DB_TypeIndex[gtype];
   end

   return not YatlasOptions.Frames[lm].PointCfg["gatherer_"..gtype];
end

YAPoints_RegisterSet(set);
