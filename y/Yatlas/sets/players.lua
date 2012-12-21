
local set = {name="players", internal = {}};
local eventframe;
local unitlocations = {};

local addpoint = function(name, unit)
    YAPoints_AddMobilePoint(nil, name, unit, nil, nil);

    YAPoints_SetupMobilePointF(nil, name, unit, "Icon","SetTexture",
            "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-PartyUnit");
    if(string.find(unit,"party")) then
        YAPoints_SetupMobilePointF(nil, name, unit, "Icon","SetVertexColor",1,0.4,0.4,1);
    elseif(string.find(unit,"raid")) then
        YAPoints_SetupMobilePointF(nil, name, unit, "Icon","SetVertexColor",1,1,0.3,1);
    else
        YAPoints_SetupMobilePointF(nil, name, unit, "Icon","SetVertexColor",0.4,0.6,1,1);
    end
    YAPoints_SetupMobilePointF(nil, name, unit, "Icon","SetWidth",16);
    YAPoints_SetupMobilePointF(nil, name, unit, "Icon","SetHeight",16);
    YAPoints_SetupMobilePointF(nil, name, unit, "Icon","SetTexCoord",0,1,0,1);
    YAPoints_SetupMobilePointF(nil, name, unit, "Icon","Show");
end

function set.getmobilepoints(name)
    if(eventframe == nil) then
        set.internal.CreateEventFrame();
    end

    addpoint(name, "player");
    for h = 1,40 do
        addpoint(name, "raid"..h);
    end
    for h = 1,5 do
        addpoint(name, "party"..h);
    end
end

function set.OnUpdate(name, frame, elapsed)
    if(GetMapInfo() == frame.opt.Map) then
        set.internal.OnWorldMapUpdate()
    end
end

function set.internal.OnWorldMapUpdate()
    set.internal.OnWorldMapUpdateUnit("player");
    for h = 1,GetNumPartyMembers() do
        set.internal.OnWorldMapUpdateUnit("party"..h);
    end
    for h = 1,GetNumRaidMembers() do
        set.internal.OnWorldMapUpdateUnit("raid"..h);
    end
end

function set.internal.OnWorldMapUpdateUnit(u)
    local map = GetMapInfo();
    local x,y = GetPlayerMapPosition(u);
    local ux, uy;

    if(x == 0 and y == 0 and unitlocations[u] and map == unitlocations[u][1]) then
        -- assume we changed locations
        unitlocations[u] = nil;
        YAPoints_HideMobile("players", u);
        return;
    end

    if(UnitIsUnit(u, "player") and u ~= "player") or 
            (UnitInParty(u) and string.sub(u, 1, 4) == "raid") then
        -- hide other representations of units
        if(unitlocations[u]) then
            unitlocations[u] = nil;
            YAPoints_HideMobile("players", u);
        end
        return;
    end

    if(Yatlas_mapareas[map] == nil or (x == 0 and y == 0)) then  
        return;
    end

    local x1,x2,y1,y2;
    if(Yatlas_mapareas[map][0] ~= nil) then
        x1 = Yatlas_mapareas[map][0][1];
        x2 = Yatlas_mapareas[map][0][2];
        y1 = Yatlas_mapareas[map][0][3];
        y2 = Yatlas_mapareas[map][0][4];
    else
        local _,va = next(Yatlas_mapareas[map]);  
        x1 = va[1];
        x2 = va[2];
        y1 = va[3];
        y2 = va[4];
    end
    
    ux, uy = Yatlas_Big2Mini_Coord((-x*(x1-x2) + x1), (-y*(y1-y2) + y1))
    unitlocations[u] = { map, ux, uy};
    YAPoints_Mobile_SetLocation("players", u, map, ux, uy);
end

function set.internal.CreateEventFrame()
    if(eventframe ~= nil) then
        return;
    end

    eventframe = CreateFrame("frame");

    eventframe:SetScript("OnEvent", function()
        if(event == "WORLD_MAP_UPDATE") then
            set.internal.OnWorldMapUpdate();
        elseif(event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED") then
            local q = {};
            for h,v in pairs(unitlocations) do
                if(not UnitExists(h)) then
                    tinsert(q,h);
                end
            end

            for h,v in ipairs(q) do
                unitlocations[v] = nil;
                YAPoints_HideMobile("players", v);
            end
        end
    end)

    eventframe:RegisterEvent("WORLD_MAP_UPDATE");
    eventframe:RegisterEvent("RAID_ROSTER_UPDATE");
    eventframe:RegisterEvent("PARTY_MEMBERS_CHANGED");
end

function set.setuplegend(point, env, dat)
    point:Show();
    point.Text:SetText(UnitName(dat.name));
    point.Icon:SetTexture(nil);
    point.Text:Show();
    point.Icon:SetHeight(env.iconsize);
    point.Icon:SetWidth(env.iconsize);
end

YAPoints_RegisterSet(set);
