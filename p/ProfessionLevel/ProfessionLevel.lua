MINING_NODE_LEVEL = {
    	["Copper Vein"] = 1,
    	["Tin Vein"] = 65,
    	["Incendicite"] = 65,
    	["Silver Vein"] = 75,
    	["Iron Deposit"] = 125,
    	["Indurium Deposit"] = 150,
    	["Lesser Bloodstone Deposit"] = 155,
    	["Gold Vein"] = 155,
    	["Mithril Vein"] = 175,
    	["Truesilver Vein"] = 230,
	    ["Small Thorium Vein"] = 245,
    	["Rich Thorium Vein"] = 275,
    	["Ooze Covered Rich Thorium Vein"] = 275,
    	["Hakkari Thorium Vein"] = 250,
    	["Dark Iron Deposit"] = 230,
    	["Small Obsidian Chunk"] = 305,
    	["Large Obsidian Chunk"] = 305
    }

HERBALISM_NODE_LEVEL = {
		["Peacebloom"] = 1,
		["Silverleaf"] = 1,
		["Earthroot"] = 15,
		["Mageroyal"] = 50,
		["Briarthorn"] = 70,
		["Stranglekelp"] = 85,
		["Bruiseweed"] = 100,
		["Wild Steelbloom"] = 115,
		["Grave Moss"] = 120,
		["Kingsblood"] = 125,
		["Liferoot"] = 150,
		["Fadeleaf"] = 160,
		["Goldthorn"] = 170,
		["Khadgar's Whisker"] = 185,
		["Wintersbite"] = 195,
		["Firebloom"] = 205,
		["Purple Lotus"] = 210,
		["Arthas' Tears"] = 220,
		["Sungrass"] = 230,
		["Blindweed"] = 235,
		["Ghost Mushroom"] = 245,
		["Gromsblood"] = 250,
		["Golden Sansam"] = 260,
		["Dreamfoil"] = 270,
		["Mountain Silversage"] = 280,
		["Plaguebloom"] = 285,
		["Icecap"] = 290,
		["Black Lotus"] = 300
	}

function ProfessionLevel_OnShow()
    local parentFrame = this:GetParent();
    local parentFrameName = parentFrame:GetName();
    local itemName = getglobal(parentFrameName.."TextLeft1"):GetText();
    
    if(MINING_NODE_LEVEL[itemName]) then
    	ProfessionLevel_AddMiningInfo(parentFrame, itemName);
    end
    
    if(HERBALISM_NODE_LEVEL[itemName]) then
    	ProfessionLevel_AddHerbalismInfo(parentFrame, itemName);
    end
    
    if(ProfessionLevel_IsSkinnable()) then
    	ProfessionLevel_AddSkinningInfo(parentFrame, itemName);
	end
end

function ProfessionLevel_GetProfessionLevel(skill)
    local numskills = GetNumSkillLines();
    for c = 1, numskills do
        local skillname, _, _, skillrank = GetSkillLineInfo(c);
        if(skillname == skill) then
            return skillrank;
        end     
    end
    return 0;
end

function ProfessionLevel_AddMiningInfo(frame, itemname)
    if(MINING_NODE_LEVEL[itemname]) then
        local levelreq = MINING_NODE_LEVEL[itemname];
        local MiningLevel = ProfessionLevel_GetProfessionLevel("Mining");
        if(levelreq <= MiningLevel) then
            -- High enough
            frame:AddLine("Mining("..levelreq..") needed",0,1,0); 
        else
            -- Not high enough
            frame:AddLine("Mining("..levelreq..") needed.",1,0,0);
        end
        frame:SetHeight(frame:GetHeight() + 14);
        frame:SetWidth(190);
    end
end    

function ProfessionLevel_AddHerbalismInfo(frame, itemname)
    if(HERBALISM_NODE_LEVEL[itemname]) then
        local levelreq = HERBALISM_NODE_LEVEL[itemname];
        local HerbalismLevel = ProfessionLevel_GetProfessionLevel("Herbalism");
        if(levelreq <= HerbalismLevel) then
            -- High enough
            frame:AddLine("Herbalism("..levelreq..") needed.",0,1,0);
        else
            -- Not high enough
            frame:AddLine("Herbalism("..levelreq..") needed.",1,0,0);
        end
        frame:SetHeight(frame:GetHeight() + 14);
        frame:SetWidth(190);
    end
end

function ProfessionLevel_AddSkinningInfo(frame, itemname)
    local levelreq = 5 * UnitLevel("Mouseover");
    if(levelreq < 100) then levelreq = 1; end
    if(levelreq > 0) then
    	local SkinningLevel= ProfessionLevel_GetProfessionLevel("Skinning");
    	if(levelreq <= SkinningLevel) then
            -- High enough
        	frame:AddLine("Skinning("..levelreq..") needed.",0,1,0);
    	else
            -- Not high enough
        	frame:AddLine("Skinning("..levelreq..") needed.",1,0,0);
    	end
    	frame:SetHeight(frame:GetHeight() + 14);
    	frame:SetWidth(190);
   end 	
end

function ProfessionLevel_IsSkinnable()
    for c = 1, GameTooltip:NumLines() do
        local line = getglobal("GameTooltipTextLeft"..c);
        if(line and line:GetText() == "Skinnable") then return true; end
    end
    return false;
end

