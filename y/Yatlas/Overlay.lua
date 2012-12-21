

local overlayers = {};

local current_locx;
local current_locy;
local current_locx_xact;
local current_locy_xact;
local current_frame;
local current_lm;
local current_viewframe;
local known_frames = {};

function YAOverlay_Register(...)
    overlayers[arg[1]] = arg;
end

function YAOverlay_ForceUpdate(self)
    if( not self) then
        for h,v in pairs(known_frames) do
            YAOverlay_OnMapChange(getglobal(h));
            YAOverlay_OnMove(getglobal(h), unpack(YatlasOptions.Frames[h].Location));
        end
    else
        YAOverlay_OnMapChange(self);
        YAOverlay_OnMove(self, unpack(YatlasOptions.Frames[self:GetName()].Location));
    end
end

function YAOverlay_OnMapChange(self)
    local lm = self:GetName();
    self.overlays = {};

    known_frames[lm] = 1;
    current_frame = self;

    local h = 1;
    while h > 0 do
        local kid = getglobal(lm.."OBGTexture"..h);
        local pa = getglobal(lm.."OTexture"..h);
        if(pa and kid) then
            kid:ClearAllPoints();
            kid:SetPoint("TOPLEFT", pa);
            kid:Hide();
            h = h + 1;
        else
            h = 0;
        end
    end

    local map = self:GetMap();
    YA_PD_ResetList()

    for h,v in pairs(overlayers) do 
        local gpf = v[2];
        if(gpf) then
            gpf(v[1], map);
        end
    end

    YAOverlay_UpdateP(self)
end

function YAOverlay_OnMove(self, x,y)
    local sx, sy;

    current_locx_xact = x;
    current_locy_xact = y;

    YAOverlay_Update(self);
    YAOverlay_UpdateP(self);
end

local keys = function(k)
    local r = {};

    for h,v in pairs(k) do
        tinsert(r,h);
    end
    return r;
end


function YAOverlay_Update(self)
    local i = 0;
    local x = current_locx_xact;
    local y = current_locy_xact;
    local z = self:GetZoom();
    local tex, bgtex;
    local plist = {};
    local num2 = 0;
    local lm = self:GetName();
    local common_pd = {};
    current_lm = lm;
    current_frame = self;
    current_viewframe = getglobal(lm.."ViewFrame");

    if(self.overlays == nil) then
        return YAOverlay_OnMapChange(self);
    end

    if(self.plist == nil) then
        self.plist = {};
    end

    known_frames[lm] = 1;

    -- hide everything
    for h = 1,self.overlays_allocd do
        getglobal(lm.."OTexture"..h):Hide();
        getglobal(lm.."OBGTexture"..h):Hide();
        getglobal(lm.."OTexture"..h):SetTexCoord(0, 1, 0, 1);
        getglobal(lm.."OBGTexture"..h):SetTexCoord(0, 1, 0, 1);
    end
    YA_PD_ResetList()

    for xv = math.floor(x),math.ceil(x+current_viewframe:GetWidth()/z),1 do
        if(self.overlays[xv] ~= nil) then 
            for yv = math.floor(y),math.ceil(y+current_viewframe:GetHeight()/z),1 do
                if(self.overlays[xv][yv] ~= nil) then
                    for k,vv in pairs(self.overlays[xv][yv]) do
                        if(vv[2] > x and vv[3] > y and
                                vv[2] < x+current_viewframe:GetWidth()/z and 
                                vv[3] < y+current_viewframe:GetHeight()/z) then
                            plist[vv[4]..vv[2]..vv[3]] = vv;
                        end
                    end
                end
            end
        end
    end

    local sorted = keys(plist);
    local pd_allocfunc = getglobal(self.YA_PD_allocText);
    if(not pd_allocfunc) then pd_allocfunc = function () end end

    table.sort(sorted)
    common_pd = {};
    self.overlays_allocd = 1;
    for hi,h in ipairs(sorted) do
        local v = plist[h];
        local modi = 0;
        local showornotfunc = overlayers[v[1]][5];

        if(YatlasOptions.Frames[lm].Overlays[v[1]] or (showornotfunc and not showornotfunc(v))) then
            tex = nil;
        else
            tex = getglobal(lm.."OTexture"..self.overlays_allocd);
            bgtex = getglobal(lm.."OBGTexture"..self.overlays_allocd);
        end

        if(tex ~= nil and bgtex ~= nil) then
            tex:Show();
    
            local otextures;
            if((not v[6]) or (not v[6].commonpd)) then
                i = i + 1;
                num2 = num2 + 1;
                otextures = {pd_allocfunc()};
            else
                if(not common_pd[v[6].commonpd]) then
                    common_pd[v[6].commonpd] = {pd_allocfunc()};
                    i = i + 1;
                else
                    modi = -1;
                end
                otextures = common_pd[v[6].commonpd];
            end
            if(otextures[1]) then
                tinsert(otextures[1].myOTextures, self.overlays_allocd);
            end

            local func = overlayers[v[1]][3];
            if(func ~= nil) then
                func({tex, bgtex}, otextures,  {v[2], v[3]}, v[4], num2, v[5]);
            end

            self.overlays_allocd = self.overlays_allocd + 1;
        end
    end
    -- count correctly!
    self.overlays_allocd = self.overlays_allocd - 1;
end

function YAOverlay_showmeornot(framename, v)
    local showornotfunc = overlayers[v[1]][5];

    if(YatlasOptions.Frames[framename].Overlays[v[1]] or (showornotfunc and not showornotfunc(v))) then
        return false;
    else
        return true;
    end
end

function YAOverlay_UpdateP(self)
    local z = self:GetZoom();
    local lm = self:GetName();
    local vf = getglobal(lm.."ViewFrame");
    local iconsize = YatlasOptions.Frames[lm].IconSize;

    if(self.unitlocations.player and self.unitlocations.player[1] == YatlasOptions.Frames[lm].Map) then
        local x,y = Yatlas_Big2Mini_Coord(self.unitlocations.player[2],
                        self.unitlocations.player[3]);

        if(x > current_locx_xact and y > current_locy_xact and 
                x < current_locx_xact+vf:GetWidth()/z and y < current_locy_xact+vf:GetHeight()/z) then

            getglobal(lm.."PTexture1"):SetTexture("Interface\\WorldMap\\WorldMapPlayerIcon");
            YAOverly_position_texture(getglobal(lm.."PTexture1"), {x, y}, {iconsize/2, iconsize/2} );
            getglobal(lm.."PTexture1"):Show();
            getglobal(lm.."PTexture1"):SetHeight(iconsize);
            getglobal(lm.."PTexture1"):SetWidth(iconsize);
        else
            getglobal(lm.."PTexture1"):Hide();
        end
    else
        getglobal(lm.."PTexture1"):Hide();
    end
end

function YAOverly_position_texture(tx, coord, off)
    local z = current_frame:GetZoom();
    tx:ClearAllPoints();
    tx:SetPoint("TOPLEFT", current_viewframe, "TOPLEFT", 
           -(current_locx_xact - coord[1])*z - off[1],
           (current_locy_xact - coord[2])*z + off[2]);
end

--

function YFOO_Init(frame)
    if(not frame) then
        frame = this;
    end

    UIDropDownMenu_Initialize(frame, YFOODropDown_Initialize, "MENU");
    UIDropDownMenu_SetButtonWidth(50,frame);
    UIDropDownMenu_SetWidth(50,frame);
end

function YFOODropDown_Initialize()
    if(UIDROPDOWNMENU_MENU_LEVEL == 1) then
        local info = {};
        info.text = YATLAS_OVERLAY_SHOWPOINTS_TITLE;
        info.notClickable = 1;
        info.isTitle = 1;
        info.notCheckable = 1;
        UIDropDownMenu_AddButton(info);
    end

    if(YatlasOptions.Frames and YatlasOptions.Frames[current_lm]) then
        for h,v in pairs(overlayers) do 
            local ddf = v[4];
            if(ddf) then
                ddf(v[1], map);
            end
        end
    end
end

function YFOO_OnClick()
    current_lm = this;
    while(current_lm and not current_lm.SetLocation) do
        current_lm = current_lm:GetParent()
    end
    current_lm = current_lm:GetName();

    if(current_lm == "BigYatlasFrame") then
        BigYatlasTooltip:Hide();
    end

    ToggleDropDownMenu(1, nil, getglobal(this:GetName().."DropDown"), this:GetName(), 0, 0);
end

function YFOODropDown_do_toggle_normal()
    YatlasOptions.Frames[current_lm].Overlays[this.value] = UIDropDownMenuButton_GetChecked()
    YAOverlay_ForceUpdate(getglobal(current_lm))
end

function YAOverlay_addpoint(frame, x, y, dat) 
    if(type(frame) ~= "table") then
        frame = current_frame;
    end

    local fx = math.floor(x);
    local fy = math.floor(y);

    if(frame.overlays[fx] == nil) then frame.overlays[fx] = {}; end
    if(frame.overlays[fx][fy] == nil) then frame.overlays[fx][fy] = {}; end

    tinsert(frame.overlays[fx][fy],dat);
end

---
---
---

function YAOverlay_getpoints_landmarks(name, map) 
    -- we got these from map api.  don't use if we see Megellan
    if(type(Yatlas_Landmarks[map]) == "table" and Magellan_Init == nil) then
        for h,v in ipairs(Yatlas_Landmarks[map]) do
            local x,y = Yatlas_Big2Mini_Coord(v[1],v[2]);

            YAOverlay_addpoint(nil, x, y, {"landmarks",x,y,v[3],Yatlas_Landmarks[map][h]});
        end
    end

    -- we got these...from OURSELVES!
    if(type(Yatlas_instances[map]) == "table") then
        for h,v in ipairs(Yatlas_instances[map]) do
            local x,y = Yatlas_Big2Mini_Coord(v[2],v[3]);

            YAOverlay_addpoint(nil, x, y,{"landmarks",x,y,v[1],{nil,nil,nil,nil,-1}});
        end
    end

     -- 'other towns' ...we got these...from OURSELVES!
    if(type(Yatlas_towns2[map]) == "table") then
        for h,v in ipairs(Yatlas_towns2[map]) do
            local x,y = Yatlas_Big2Mini_Coord(v[2],v[3]);

            YAOverlay_addpoint(nil, x, y,{"landmarks",x,y,v[1],{nil,nil,nil,nil,-4}});
        end
    end
end

function YAOverlay_setupicon_landmarks(maptextures, otextures, coord, name, id, dat)
    local texture, bg = unpack(maptextures);
    local x1, x2, y1, y2;
    local r, g, b;
    local bgtextname;

    if(dat[5] == 4 or dat[5] == 5 or dat[5] < 0) then
        x1 = 0; y1 = 0;
        x2 = 1; y2 = 1;

        r = 0.2;
        g = 0.6;
        b = 1;
        bgtextname = "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Circle";
        if(dat[5] == 5) then
            bgtextname = "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Circle2";
        elseif(dat[5] == -1) then
            r = 0.9;
            g = 0.1;
            b = 0.9;
        elseif(dat[5] == -4) then
            r = 0.3;
            g = 0.8;
            b = 1;
        end
    else
       x1, x2, y1, y2 = WorldMap_GetPOITextureCoords(dat[5]);
       r,g,b = 1,1,1;
       bgtextname  = "Interface\\Minimap\\POIIcons"
    end

    texture:Show();
    YAOverly_position_texture(texture, coord, {YatlasOptions.Frames[current_lm].IconSize/2, YatlasOptions.Frames[current_lm].IconSize/2});
    if(id > 32) then
        texture:Hide();
    else
        texture:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-N"..id);
        texture:SetHeight(YatlasOptions.Frames[current_lm].IconSize+1);
        texture:SetWidth(YatlasOptions.Frames[current_lm].IconSize+1);
    end

    bg:Show();
    bg:SetHeight(YatlasOptions.Frames[current_lm].IconSize);
    bg:SetWidth(YatlasOptions.Frames[current_lm].IconSize);
    bg:SetTexture(bgtextname);
    bg:SetTexCoord(x1, x2, y1, y2);
    bg:SetVertexColor(r, g, b, 1);
    
    local txt, icon, bgicon = unpack(otextures);

    if(icon) then
        icon:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-N"..id);
        icon:SetHeight(14);
        icon:SetWidth(14);
        icon:Show();

        bgicon:SetTexture(bgtextname);
        bgicon:SetTexCoord(x1, x2, y1, y2);
        bgicon:SetVertexColor(r, g, b, 1);
        bgicon:SetHeight(14);
        bgicon:SetWidth(14);
        bgicon:Show();
        
        txt:SetText(name);
        txt:Show();
    end
end

function YAOverlay_config_landmarks(name)
    if(UIDROPDOWNMENU_MENU_LEVEL == 1) then
        local info = {};
        info.text = YATLAS_OVERLAY_LANDMARKS;
        info.func = YFOODropDown_do_toggle_normal;
        info.checked = YatlasOptions.Frames[current_lm].Overlays and not YatlasOptions.Frames[current_lm].Overlays[name];
        info.value = name;
        info.keepShownOnClick = 1;
        UIDropDownMenu_AddButton(info);
    end
end

YAOverlay_Register("landmarks",YAOverlay_getpoints_landmarks,YAOverlay_setupicon_landmarks,
    YAOverlay_config_landmarks);

---

function YAOverlay_getpoints_graveyards(name, map)
    if(type(Yatlas_graveyards[map]) == "table") then
        for h,v in ipairs(Yatlas_graveyards[map]) do
            local x,y = Yatlas_Big2Mini_Coord(v[2],v[1]);

            YAOverlay_addpoint(nil, x, y, {"graveyards",x,y,"Graveyard",0,{commonpd="Gy"}});
        end
    end
end

function YAOverlay_setupicon_graveyards(maptextures, otextures, coord, name, id)
    local texture, bg = unpack(maptextures);

    texture:Hide();
    YAOverly_position_texture(texture, coord, {YatlasOptions.Frames[current_lm].IconSize/2, YatlasOptions.Frames[current_lm].IconSize/2});

    bg:Show();
    bg:SetHeight(YatlasOptions.Frames[current_lm].IconSize);
    bg:SetWidth(YatlasOptions.Frames[current_lm].IconSize);
    bg:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Graveyard");
    bg:SetVertexColor(1, 1, 1, 1);
    
    local txt, icon, bgicon = unpack(otextures);

    if(icon) then
        icon:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Blank");
        icon:SetHeight(16);
        icon:SetWidth(16);
        icon:Show()

        bgicon:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Graveyard");
        bgicon:SetVertexColor(1, 1, 1, 1);
        bgicon:SetHeight(16);
        bgicon:SetWidth(16);
        bgicon:Show();
        
        txt:SetText(name);
        txt:Show();
    end
end

function YAOverlay_config_graveyards(name)
    if(UIDROPDOWNMENU_MENU_LEVEL == 1) then
        local info = {};
        info.text = YATLAS_OVERLAY_GRAVEYARDS;
        info.func = YFOODropDown_do_toggle_normal;
        info.checked = YatlasOptions.Frames[current_lm].Overlays and not YatlasOptions.Frames[current_lm].Overlays[name];
        info.value = name;
        info.keepShownOnClick = 1;
        UIDropDownMenu_AddButton(info);
    end
end

YAOverlay_Register("graveyards",YAOverlay_getpoints_graveyards,
            YAOverlay_setupicon_graveyards,YAOverlay_config_graveyards);

---

function YAOverlay_getpoints_mapnotes(name, map)
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

                        YAOverlay_addpoint(nil, x, y, {"mapnotes",x,y,notes.name,notes.icon});                      
                    end
                end
            end
        end
    end
end

function YAOverlay_setupicon_mapnotes(maptextures, otextures, coord, name, id, dat)
    local texture, bg = unpack(maptextures);

    local color = {1,1,1,1};
    local iconname = "Icon-Square";
    if(dat) then
        if(dat >= 5) then 
            iconname = "Icon-Diamond";
            dat = dat - 5;
        end
        if(dat == 0) then
            color = {1,1,0,1};
        elseif(dat == 1) then
            color = {1,0.1,0.1,1};
        elseif(dat == 2) then
            color = {0.4,0.2,0.95,1};
        elseif(dat == 3) then
            color = {0.1, 1, 0.2,1};
        elseif(dat == 4) then
            color = {1,0.4,0.8,1};
        end
    end

    texture:Show();
    YAOverly_position_texture(texture, coord, {YatlasOptions.Frames[current_lm].IconSize/2, YatlasOptions.Frames[current_lm].IconSize/2});
    if(id > 32) then
        texture:Hide();
    else
        texture:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-N"..id);
        texture:SetHeight(YatlasOptions.Frames[current_lm].IconSize);
        texture:SetWidth(YatlasOptions.Frames[current_lm].IconSize);
    end

    bg:Show();
    bg:SetHeight(YatlasOptions.Frames[current_lm].IconSize);
    bg:SetWidth(YatlasOptions.Frames[current_lm].IconSize);
    bg:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\"..iconname);
    bg:SetVertexColor(unpack(color));
    
    local txt, icon, bgicon = unpack(otextures);

    if(icon) then
        icon:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-N"..id);
        icon:SetHeight(16);
        icon:SetWidth(16);
        icon:Show();

        bgicon:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\"..iconname);
        bgicon:SetVertexColor(unpack(color));
        bgicon:SetHeight(16);
        bgicon:SetWidth(16);
        bgicon:Show();
        
        txt:SetText(name);
        txt:Show();
    end
end

function YAOverlay_config_mapnotes(name)
    if(MapNotes_DeleteNote and UIDROPDOWNMENU_MENU_LEVEL == 1) then
        local info = {};
        info.text = YATLAS_OVERLAY_MAPNOTES;
        info.func = YFOODropDown_do_toggle_normal;
        info.checked = YatlasOptions.Frames[current_lm].Overlays 
                and not YatlasOptions.Frames[current_lm].Overlays[name];
        info.value = name;
        info.keepShownOnClick = 1;
        UIDropDownMenu_AddButton(info);
    end
end

YAOverlay_Register("mapnotes",YAOverlay_getpoints_mapnotes,YAOverlay_setupicon_mapnotes,
                    YAOverlay_config_mapnotes);

---
function YAOverlay_getpoints_gatherer(name, map)
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
                        YAOverlay_addpoint(nil, x, y, {"gatherer",x,y,utyp,notes,{commonpd="g"..typ}});                      
                    end
                end
            end
        end
    end
end

function YAOverlay_setupicon_gatherer(maptextures, otextures, coord, name, id, dat)
    local texture, bg = unpack(maptextures);

    local iconname = "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Square";
    if(Gather_IconSet) then
        local gtype = dat.gtype;
        local gtype_str = gtype;
        if (type(gtype) == "number") then
            gtype_str = Gather_DB_TypeIndex[gtype];
        end

        -- map
        local namei = "default";
        if(type(Gather_DB_IconIndex[gtype]) == "table") then
            for h,v in pairs(Gather_DB_IconIndex[gtype]) do
                if(v == dat.icon) then namei = h; break; end
            end
        elseif(type(dat.icon) == "string") then
            namei = dat.icon;
        end

        local icons = Gather_IconSet["iconic"][gtype_str];
        if(icons[namei]) then
            iconname = icons[namei];
        elseif(icons["default"]) then
            iconname = icons["default"];
        end
    end

    texture:Hide();
    YAOverly_position_texture(texture, coord, {YatlasOptions.Frames[current_lm].IconSize/2, YatlasOptions.Frames[current_lm].IconSize/2});

    bg:Show();
    bg:SetHeight(YatlasOptions.Frames[current_lm].IconSize);
    bg:SetWidth(YatlasOptions.Frames[current_lm].IconSize);
    bg:SetTexture(iconname);
    bg:SetVertexColor(1,1,1,1);
    
    local txt, icon, bgicon = unpack(otextures);

    if(icon) then
        icon:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Blank");
        icon:SetHeight(16);
        icon:SetWidth(16);
        icon:Show()

        bgicon:SetTexture(iconname);
        bgicon:SetVertexColor(1,1,1,1);
        bgicon:SetHeight(16);
        bgicon:SetWidth(16);
        bgicon:Show();
    
        txt:SetText(name);
        txt:Show();
    end
end

function YAOverlay_config_gatherer(name)
    if(Gatherer_AddGatherHere) then
        local info = {};
        if(UIDROPDOWNMENU_MENU_LEVEL == 1) then
            info.text = YATLAS_OVERLAY_GATHERER;
            info.func = YFOODropDown_do_toggle_normal;
            info.checked = YatlasOptions.Frames[current_lm].Overlays and not YatlasOptions.Frames[current_lm].Overlays[name];
            info.value = name;
            info.keepShownOnClick = 1;
            info.hasArrow = 1;
            UIDropDownMenu_AddButton(info);
        elseif(UIDROPDOWNMENU_MENU_LEVEL == 2) then
            info.text = YATLAS_OVERLAY_GATHERER_TREASURE;
            info.func = YFOODropDown_do_toggle_normal;
            info.checked = YatlasOptions.Frames[current_lm].Overlays and not YatlasOptions.Frames[current_lm].Overlays[name.."_Treasure"];
            info.value = name.."_Treasure";
            info.keepShownOnClick = 1;
            UIDropDownMenu_AddButton(info, 2);

            info = {};
            info.text = YATLAS_OVERLAY_GATHERER_ORES;
            info.func = YFOODropDown_do_toggle_normal;
            info.checked = YatlasOptions.Frames[current_lm].Overlays and not YatlasOptions.Frames[current_lm].Overlays[name.."_Ore"];
            info.value = name.."_Ore";
            info.keepShownOnClick = 1;
            UIDropDownMenu_AddButton(info, 2);

            info = {};
            info.text = YATLAS_OVERLAY_GATHERER_HERBS;
            info.func = YFOODropDown_do_toggle_normal;
            info.checked = YatlasOptions.Frames[current_lm].Overlays and not YatlasOptions.Frames[current_lm].Overlays[name.."_Herb"];
            info.value = name.."_Herb";
            info.keepShownOnClick = 1;
            UIDropDownMenu_AddButton(info, 2);
        end
    end
end

function YAOverlay_showme_gatherer(v)
   local gtype = v[5].gtype;
   if (type(gtype) == "number") then
        gtype = Gather_DB_TypeIndex[gtype];
   end

   return not YatlasOptions.Frames[current_lm].Overlays["gatherer_"..gtype];
end

YAOverlay_Register("gatherer",YAOverlay_getpoints_gatherer,
                YAOverlay_setupicon_gatherer, YAOverlay_config_gatherer,
                YAOverlay_showme_gatherer);

---
function YAOverlay_getpoints_ctmapmod(name, map)
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

                    YAOverlay_addpoint(nil, x, y, {"ctmapmod",x,y,dat.name,dat,ops});  
                end
            end
        end
    end
end

function YAOverlay_setupicon_ctmapmod(maptextures, otextures, coord, name, id, var)
    local texture, bg = unpack(maptextures);

    local iconname = "Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Square";
    local iconszw = YatlasOptions.Frames[current_lm].IconSize/2+2;

    -- ctmapmod knows best...
    if ( var.set == 7 or var.set == 8 ) then
        local offset = 0;
        if ( var.set == 8 ) then
                offset = 29;
        end
        if ( CT_UserMap_HerbIcons[var.icon+offset] ) then
                iconname = "Interface\\AddOns\\CT_MapMod\\Resource\\" .. CT_UserMap_HerbIcons[var.icon+offset];
        else
                iconname = "Interface\\AddOns\\CT_MapMod\\Resource\\Herb_Bruiseweed";
        end
    else
        iconname = "Interface\\AddOns\\CT_MapMod\\Skin\\" .. CT_UserMap_Icons[var.set];
    end

    texture:Hide();
    YAOverly_position_texture(texture, coord, {iconszw, iconszw});

    bg:Show();
    bg:SetHeight(iconszw*2);
    bg:SetWidth(iconszw*2);
    bg:SetTexture(iconname);
    bg:SetVertexColor(1,1,1,1);
    
    local txt, icon, bgicon = unpack(otextures);

    if(icon) then
        icon:SetTexture("Interface\\AddOns\\Yatlas\\images\\Icons\\Icon-Blank");
        icon:SetHeight(16);
        icon:SetWidth(16);
        icon:Show()

        bgicon:SetTexture(iconname);
        bgicon:SetVertexColor(1,1,1,1);
        bgicon:SetHeight(16);
        bgicon:SetWidth(16);
        bgicon:Show();
    
        txt:SetText(name);
        txt:Show();
    end
end

function YAOverlay_config_ctmapmod(name)
    if(CT_MapMod_AddNote) then
        local info = {};
        if(UIDROPDOWNMENU_MENU_LEVEL == 1) then
            info.text = YATLAS_OVERLAY_CTMAPMOD;
            info.func = YFOODropDown_do_toggle_normal;
            info.checked = YatlasOptions.Frames[current_lm].Overlays and not YatlasOptions.Frames[current_lm].Overlays[name];
            info.value = name;
            info.keepShownOnClick = 1;
            UIDropDownMenu_AddButton(info);
        end
    end
end

YAOverlay_Register("ctmapmod",YAOverlay_getpoints_ctmapmod,
                YAOverlay_setupicon_ctmapmod, YAOverlay_config_ctmapmod);
