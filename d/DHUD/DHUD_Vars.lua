DHUD_variables = {

    ["<spellname>"] = { 
        func    = function(text, unit)
                    local time = DHUD.spellname;
                    if time then
                        text = DHUD:gsub(text, '<spellname>', time);
                    else
                        text = DHUD:gsub(text, '<spellname>', "");
                    end
                    return text;
                  end,
        events  = { },
        hideval = "", 
    },
    
    ["<casttime>"] = { 
        func    = function(text, unit)
                    local time = DHUD.casting_time;
                    if time then
                        text = DHUD:gsub(text, '<casttime>', time);
                    else
                        text = DHUD:gsub(text, '<casttime>', "");
                    end
                    return text;
                  end,
        events  = { },
        hideval = "", 
    },
    
    ["<casttime_remain>"] = { 
        func    = function(text, unit)
                    local time = DHUD.casting_time_rev;
                    if time then
                        text = DHUD:gsub(text, '<casttime_remain>', time);
                    else
                        text = DHUD:gsub(text, '<casttime_remain>', "");
                    end
                    return text;
                  end,
        events  = { },
        hideval = "", 
    },
    
    ["<casttime_delay>"] = { 
        func    = function(text, unit)
                    local time = DHUD.casting_time_del;
                    if time then
                        if tonumber(time) == 0 then 
                            time = "";
                        end
                        text = DHUD:gsub(text, '<casttime_delay>', time);
                    else
                        text = DHUD:gsub(text, '<casttime_delay>', "");
                    end
                    return text;
                  end,
        events  = { },
        hideval = "", 
    },
    
    ["<name>"] = { 
        func    = function(text, unit)
                    if unit then
                        local unitname = UnitName(unit);
                        if unitname then
                            text = DHUD:gsub(text, '<name>', unitname);
                        else
                            text = DHUD:gsub(text, '<name>', "");
                        end
                    end
                    return text;
                  end,
        events  = { "UNIT_NAME_UPDATE" },
        hideval = "", 
    },
        
   ["<hp_percent>"] = { 
       func = function(text, unit)
                local percent = 0;
                local health = UnitHealth(unit);
                local healthmax = UnitHealthMax(unit);
                if (healthmax > 0) then
                    percent = math.floor(health/healthmax * 100);
                else
                    percent = 0;
                end
                text = DHUD:gsub(text, '<hp_percent>', percent.."%%");
                return text;
            end,
      events  = { "UNIT_HEALTH", "UNIT_MAXHEALTH" },
      hideval = "0%%", 
   },
   
   ["<hp_value>"] = { 
       func = function(text, unit)
                local h;
                
                if unit == "target" then
                    -- mobhealth2
                    if MobHealth_GetTargetCurHP then
                        h = MobHealth_GetTargetCurHP();
                    -- mobinfo
                    elseif MobHealth_PPP and UnitName(unit) and UnitLevel(unit) then
                        local mi = UnitName(unit)..":"..UnitLevel(unit);
                        local p = MobHealth_PPP(mi);
                        h = math.floor(UnitHealth(unit) * p + 0.5);
                    -- telos mobhealth
                    elseif MobHealthDB and UnitName(unit) and UnitLevel(unit) then
                        local mi = UnitName(unit)..":"..UnitLevel(unit);
                        local p = DHUD_MobHealth_PPP(mi);
                        h = math.floor(UnitHealth(unit) * p + 0.5);
                    -- blizz
                    else
                        h = UnitHealth(unit);
                    end
                else
                    h = UnitHealth(unit);
                end
                
                if ((not h) or h == 0) then 
                    h = UnitHealth(unit); 
                end                                
                
                text = DHUD:gsub(text, '<hp_value>', h);
                return text;
            end,
      events  = { "UNIT_HEALTH", "UNIT_MAXHEALTH" },
      hideval = "0", 
   },
   
   ["<hp_max>"] = { 
       func = function(text, unit)
                local h;
                
                if unit == "target" then
                    -- mobhealth2
                    if MobHealth_GetTargetMaxHP and UnitHealth(unit) > 0 then
                        h = MobHealth_GetTargetMaxHP();
                    -- mobinfo
                    elseif MobHealth_PPP and UnitName(unit) and UnitLevel(unit) then
                        local mi = UnitName(unit)..":"..UnitLevel(unit);
                        local p = MobHealth_PPP(mi);
                        h = math.floor(100 * p + 0.5);
                    -- telos mobhealth
                    elseif MobHealthDB and UnitName(unit) and UnitLevel(unit) then
                        local mi = UnitName(unit)..":"..UnitLevel(unit);
                        local p = DHUD_MobHealth_PPP(mi);
                        h = math.floor(100 * p + 0.5);
                    -- blizz
                    else
                        h = UnitHealthMax(unit);
                    end
                else
                    h = UnitHealthMax(unit);
                end
                
                if ((not h) or h == 0) then 
                    h = UnitHealthMax(unit); 
                end                                
                
                text = DHUD:gsub(text, '<hp_max>', h);
                return text;
            end,
      events  = { "UNIT_HEALTH", "UNIT_MAXHEALTH" },
      hideval = "0", 
   },
   
   ["<hp_diff>"] = { 
       func = function(text, unit)
                local m;
                
                if unit == "target" then
                    -- mobhealth2
                    if MobHealth_GetTargetMaxHP and UnitHealth(unit) > 0 then
                        m = MobHealth_GetTargetMaxHP();
                        h = MobHealth_GetTargetCurHP();
                    -- mobinfo
                    elseif MobHealth_PPP and UnitName(unit) and UnitLevel(unit) then
                        local mi = UnitName(unit)..":"..UnitLevel(unit);
                        local p = MobHealth_PPP(mi);
                        m = math.floor(100 * p + 0.5);
                        h = math.floor(UnitHealth(unit) * p + 0.5);
                    -- telos mobhealth
                    elseif MobHealthDB and UnitName(unit) and UnitLevel(unit) then
                        local mi = UnitName(unit)..":"..UnitLevel(unit);
                        local p = DHUD_MobHealth_PPP(mi);
                        m = math.floor(100 * p + 0.5);
                        h = math.floor(UnitHealth(unit) * p + 0.5);
                    -- blizz
                    else
                        m = UnitHealthMax(unit);
                        h = UnitHealth(unit);
                    end
                else
                    m = UnitHealthMax(unit);
                    h = UnitHealth(unit);
                end
                
                if ((not h) or h == 0) then 
                    m = UnitHealthMax(unit); 
                    h = UnitHealth(unit);
                end    
                
                local d = m - h;                            
                if d > 0 and d < m then
                    d = "-"..d;
                else
                    d = "";
                end
                
                text = DHUD:gsub(text, '<hp_diff>', d);
                return text;
            end,
      events  = { "UNIT_HEALTH", "UNIT_MAXHEALTH" },
      hideval = "", 
   },
   
   ["<mp_percent>"] = { 
       func = function(text, unit)
                local percent = 0;
                local mana = UnitMana(unit);
                local manamax = UnitManaMax(unit);
                if (manamax > 0) then
                    percent = math.floor(mana/manamax * 100);
                else
                    percent = 0;
                end
                text = DHUD:gsub(text, '<mp_percent>', percent.."%%");
                return text;
            end,
      events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER" },
      hideval = "0%%", 
  },
  
   ["<mp_value>"] = { 
       func = function(text, unit)
                local m = UnitMana(unit);
                text = DHUD:gsub(text, '<mp_value>', m);
                return text;
            end,
      events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER" },
      hideval = "0", 
  },
  
   ["<mp_value_druid>"] = { 
       func = function(text, unit)
                local dm;
                if UnitPowerType("player") ~= 0 and DruidBarKey then
                    dm = math.floor(DruidBarKey.keepthemana);
                else
                    dm = "";
                end
                text = DHUD:gsub(text, '<mp_value_druid>', dm);
                return text;
            end,
      events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER","UPDATE_SHAPESHIFT_FORMS" },
      hideval = "", 
  },  
  
   ["<mp_max_druid>"] = { 
       func = function(text, unit)
                local dm;
                if UnitPowerType("player") ~= 0 and DruidBarKey then
                    dm = math.floor(DruidBarKey.maxmana);
                else
                    dm = "";
                end
                text = DHUD:gsub(text, '<mp_max_druid>', dm);
                return text;
            end,
      events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER","UPDATE_SHAPESHIFT_FORMS" },
      hideval = "", 
  }, 

   ["<mp_percent_druid>"] = { 
       func = function(text, unit)
                local dm;
                if UnitPowerType("player") ~= 0 and DruidBarKey then
                    dm = math.floor(DruidBarKey.keepthemana / DruidBarKey.maxmana * 100);
                else
                    dm = "";
                end
                text = DHUD:gsub(text, '<mp_percent_druid>', dm);
                return text;
            end,
      events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER","UPDATE_SHAPESHIFT_FORMS" },
      hideval = "", 
  }, 
      
   ["<mp_max>"] = { 
       func = function(text, unit)
                local m = UnitManaMax(unit);
                text = DHUD:gsub(text, '<mp_max>', m);
                return text;
            end,
      events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER" },
      hideval = "0", 
  },
  
  
   ["<mp_diff>"] = { 
       func = function(text, unit)
                local m = UnitManaMax(unit) - UnitMana(unit);
                if m > 0 and m < UnitManaMax(unit) then
                    m = "-"..m;
                else
                    m = "";
                end
                text = DHUD:gsub(text, '<mp_diff>', m);
                return text;
            end,
      events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX","UNIT_DISPLAYPOWER" },
      hideval = "", 
  },
  
   ["<color>"] = { 
       func = function(text, unit)
                text = DHUD:gsub(text, '<color>', '|cff');
                return text;
            end,
      events  = { },
      hideval = "|cff", 
  },
   ["</color>"] = { 
       func = function(text, unit)
                text = DHUD:gsub(text, '</color>', '|r');
                return text;
            end,
      events  = { },
      hideval = "|r", 
  },
   ["<level>"] = { 
       func = function(text, unit)
                local level = UnitLevel(unit);
                if level > 90 or level < 0 then
                    level = "??";
                end
                text = DHUD:gsub(text, '<level>', level );
                return text;
            end,
      events  = { "UNIT_LEVEL" },
      hideval = "0", 
  },
   ["<color_level>"] = { 
       func = function(text, unit)
                local level = UnitLevel(unit);
                if level < 0 then
                    level = 99;
                end
                local color = GetDifficultyColor(level);
                if color and UnitExists(unit) then
                    text = DHUD:gsub(text, '<color_level>', "|cff"..DHUD_DecToHex(color.r,color.g,color.b) );
                else
                    text = DHUD:gsub(text, '<color_level>', "|cffffffff" );
                end
                return text;
            end,
      events  = { "UNIT_LEVEL" },
      hideval = "|cffffffff", 
  },
   ["<color_class>"] = { 
       func = function(text, unit)
                local targetclass, eclass = UnitClass(unit);
                local color = RAID_CLASS_COLORS[eclass or nil];
                if color and UnitExists(unit) then
                    text = DHUD:gsub(text, '<color_class>', "|cff"..DHUD_DecToHex(color.r,color.g,color.b) );
                else
                    text = DHUD:gsub(text, '<color_class>', "");
                end
                return text;
            end,
      events  = { "UNIT_NAME_UPDATE" },
      hideval = "", 
  },		          
   ["<elite>"] = { 
       func = function(text, unit)
                local elite = DHUD:CheckElite(unit)	
                text = DHUD:gsub(text, '<elite>', elite );
                return text;
            end,
      events  = { "UNIT_CLASSIFICATION_CHANGED" },
      hideval = "", 
  },
   ["<color_reaction>"] = { 
       func = function(text, unit)
                local color = DHUD:GetReactionColor(unit);
                if color and UnitExists(unit) then
                    text = DHUD:gsub(text, '<color_reaction>', "|cff"..color );
                else
                    text = DHUD:gsub(text, '<color_reaction>', "");
                end
                return text;
            end,
      events  = { "UNIT_CLASSIFICATION_CHANGED" },
      hideval = "", 
  },
   ["<type>"] = { 
       func = function(text, unit)
                local creatureType = UnitCreatureType(unit);	
                if (UnitIsPlayer(unit)) then creatureType = ""; end
                if DHUD:TargetIsNPC() then creatureType = ""; end
                if DHUD:TargetIsPet() then creatureType = ""; end
                text = DHUD:gsub(text, '<type>', creatureType );
                return text;
            end,
      events  = { "UNIT_CLASSIFICATION_CHANGED" },
      hideval = "", 
  },
   ["<class>"] = { 
       func = function(text, unit)
                local targetclass, eclass = UnitClass("target");
                if not UnitIsPlayer(unit) then targetclass = ""; end
                text = DHUD:gsub(text, '<class>', targetclass );
                return text;
            end,
      events  = { "UNIT_NAME_UPDATE" },
      hideval = "", 
  },
   ["<pet>"] = { 
       func = function(text, unit)
                if DHUD:TargetIsPet() then 
                    text = DHUD:gsub(text, '<pet>', "Pet" );
                else
                    text = DHUD:gsub(text, '<pet>', "" );
                end
                return text;
            end,
      events  = { "UNIT_NAME_UPDATE" },
      hideval = "", 
  },
   ["<npc>"] = { 
       func = function(text, unit)
                if DHUD:TargetIsNPC() then 
                    text = DHUD:gsub(text, '<npc>', "NPC" );
                else
                    text = DHUD:gsub(text, '<npc>', "" );
                end
                return text;
            end,
      events  = { "UNIT_NAME_UPDATE" },
      hideval = "", 
  },
  
	["<faction>"] = { 
        func = function(text, unit)
			local value = UnitFactionGroup(unit);
			if (not UnitName(unit)) then value = ""; end
			text = DHUD:gsub(text, '<faction>', value);
			return text;
		end,
		events = {"UNIT_FACTION"},
        hideval = "", 

  },  
  

    ["<combopoints>"] = { 
        func = function(text, unit)
            unit = target;
			local value = GetComboPoints();
			if value == 0 then value = ""; end;
			text = DHUD:gsub(text, '<combopoints>', value);
			return text;
		end,
		events = {"PLAYER_COMBO_POINTS"},
        hideval = "", 
 
    },
    

	["<pvp>"] = { 
	   func = function(text, unit)
			if (UnitIsPVPFreeForAll(unit) or UnitIsPVP(unit)) and not DHUD:TargetIsNPC() then
				text = DHUD:gsub(text, '<pvp>', "PVP");
            else
                text = DHUD:gsub(text, '<pvp>', "");
			end
			
			return text;
		end,
		events = {"UNIT_PVP_UPDATE"},
        hideval = "", 
 
    },
    
	["<pvp_rank>"] = { 
	
	   func = function(text, unit)
			local value = GetPVPRankInfo(UnitPVPRank(unit), unit);
			text = DHUD:gsub(text, '<pvp_rank>', value);
			return text;
		end,
		events = {"UNIT_PVP_UPDATE"} ,
        hideval = "", 

		
		},

	["<raidgroup>"] = { 
	       func = function(text, unit)
				local value;
				for i = 1, GetNumRaidMembers() do
					if (UnitIsUnit("raid"..i, unit)) then
						_, _, value = GetRaidRosterInfo(i);
						break;
					end
				end
				if value then
				    text = DHUD:gsub(text, '<raidgroup>', value);
				else
				    text = DHUD:gsub(text, '<raidgroup>', "");
				end
				return text;
			end,
			events = { "RAID_ROSTER_UPDATE" },
			hideval = "", 
    },  
  
  
   ["<color_hp>"] = { 
       func = function(text, unit)
                local percent;
                local health = UnitHealth(unit);
                local healthmax = UnitHealthMax(unit);
                if (healthmax > 0 and UnitExists(unit) ) then
                    percent = health/healthmax;
                    local typunit = DHUD:getTypUnit(unit,"health")
                    local color = DHUD_DecToHex(DHUD:Colorize(typunit,percent));
                    text = DHUD:gsub(text, '<color_hp>', "|cff"..color );
                else
                    text = DHUD:gsub(text, '<color_hp>', "|cffffffff" );
                end
                return text;
            end,
      events  = { "UNIT_HEALTH", "UNIT_MAXHEALTH" },
      hideval = "|cffffffff", 
  },
   ["<color_mp>"] = { 
       func = function(text, unit)
                local percent;
                local health    = UnitMana(unit);
                local healthmax = UnitManaMax(unit);
                local uc        = 0;
                
                if DruidBarKey and DHUD.player_class == "DRUID" and unit == "pet" then
                    healthmax = DruidBarKey.maxmana;
                    health    = DruidBarKey.keepthemana;
                    unit      = "player";
                    uc        =  1;
                end
                
                if (healthmax > 0 and UnitExists(unit)) then
                    percent = health/healthmax;
                    local typunit = DHUD:getTypUnit(unit,"mana");
                    
                    if DruidBarKey and DHUD.player_class == "DRUID" and uc == 1 then
                        typunit = "mana_player";
                    end
                    
                    local color = DHUD_DecToHex(DHUD:Colorize(typunit,percent));
                    if uc == 1 and UnitPowerType("player") == 0 then
                        color = "ffffff";
                    end
                    
                    text = DHUD:gsub(text, '<color_mp>', "|cff"..color);
                else
                    text = DHUD:gsub(text, '<color_mp>', "|cffffffff" );
                end
                return text;
            end,
      events  = { "UNIT_MANA","UNIT_MAXMANA","UNIT_FOCUS","UNIT_FOCUSMAX","UNIT_RAGE","UNIT_RAGEMAX","UNIT_ENERGY","UNIT_ENERGYMAX" },
      hideval = "|cffffffff", 
  },
    ["<guild>"] = { 
        func = function(text, unit)
			local v = GetGuildInfo(unit);
			text = DHUD:gsub(text, '<guild>', v);
			return text;
        end,
		events = { "UNIT_NAME_UPDATE" },
		hideval = "", 
    },    
}
