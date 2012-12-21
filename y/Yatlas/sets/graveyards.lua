
local set = {name="graveyards"};

local commonopt = {commonpd="Gy"};
function set.getpoints(name, map) 
    if(type(Yatlas_graveyards[map]) == "table") then
        for h,v in ipairs(Yatlas_graveyards[map]) do
            local x,y = Yatlas_Big2Mini_Coord(v[2],v[1]);

            YAPoints_AddPoint(nil, "graveyards", "Graveyard", x, y, commonopt, nil);
        end
    end
end


function set.setuppoint(point, env, dat) 
    local text, bg = point.Foreground, point.Icon;

    text:SetText("");

    point:Show();
    point:SetOffset(dat.x, dat.y);

    bg:Show();
    bg:SetHeight(env.iconsize);
    bg:SetWidth(env.iconsize);
    bg:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Graveyard");
    bg:SetVertexColor(1, 1, 1, 1);
end

function set.setuplegend(point, env, dat)
    env.iconsize = 15;
    set.setuppoint(point, env, dat);

    point.Text:SetText(dat.name);
end

function set.configmenu(name, lm)
    if(UIDROPDOWNMENU_MENU_LEVEL == 1) then
        local info = {};
        info.text = YATLAS_POINTS_GRAVEYARDS;
        info.func = YFOODropDown_do_toggle_normal;
        info.checked = YatlasOptions.Frames[lm].PointCfg and not YatlasOptions.Frames[lm].PointCfg[name];
        info.value = name;
        info.keepShownOnClick = 1;
        UIDropDownMenu_AddButton(info);
    end
end
YAPoints_RegisterSet(set);

