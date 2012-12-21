MetaMapBLTData = {};
MetaMapBLT_ClassSet = "";
MetaMapBLT_ClassName = "";

local function MetaMapBLT_FixText(text)
    --Armour class
    text = gsub(text, "#a1#", ATLASLOOT_CLOTH);
    text = gsub(text, "#a2#", ATLASLOOT_LEATHER);
    text = gsub(text, "#a3#", ATLASLOOT_MAIL);
    text = gsub(text, "#a4#", ATLASLOOT_PLATE);
    
    --Body slot
    text = gsub(text, "#s1#", ATLASLOOT_HEAD);
    text = gsub(text, "#s2#", ATLASLOOT_NECK);
    text = gsub(text, "#s3#", ATLASLOOT_SHOULDER);
    text = gsub(text, "#s4#", ATLASLOOT_BACK);
    text = gsub(text, "#s5#", ATLASLOOT_CHEST);
    text = gsub(text, "#s6#", ATLASLOOT_SHIRT);
    text = gsub(text, "#s7#", ATLASLOOT_TABARD);
    text = gsub(text, "#s8#", ATLASLOOT_WRIST);
    text = gsub(text, "#s9#", ATLASLOOT_HANDS);
    text = gsub(text, "#s10#", ATLASLOOT_WAIST);
    text = gsub(text, "#s11#", ATLASLOOT_LEGS);
    text = gsub(text, "#s12#", ATLASLOOT_FEET);
    text = gsub(text, "#s13#", ATLASLOOT_RING);
    text = gsub(text, "#s14#", ATLASLOOT_TRINKET);
    text = gsub(text, "#s15#", ATLASLOOT_OFF_HAND);
    text = gsub(text, "#s16#", ATLASLOOT_RELIC);
    
    --Weapon Weilding
    text = gsub(text, "#h1#", ATLASLOOT_ONE_HAND);
    text = gsub(text, "#h2#", ATLASLOOT_TWO_HAND);
    text = gsub(text, "#h3#", ATLASLOOT_MAIN_HAND);
    text = gsub(text, "#h4#", ATLASLOOT_OFFHAND);
    
    --Weapon type
    text = gsub(text, "#w1#", ATLASLOOT_AXE);
    text = gsub(text, "#w2#", ATLASLOOT_BOW);
    text = gsub(text, "#w3#", ATLASLOOT_CROSSBOW);
    text = gsub(text, "#w4#", ATLASLOOT_DAGGER);
    text = gsub(text, "#w5#", ATLASLOOT_GUN);
    text = gsub(text, "#w6#", ATLASLOOT_MACE);
    text = gsub(text, "#w7#", ATLASLOOT_POLEARM);
    text = gsub(text, "#w8#", ATLASLOOT_SHIELD);
    text = gsub(text, "#w9#", ATLASLOOT_STAFF);
    text = gsub(text, "#w10#", ATLASLOOT_SWORD);
    text = gsub(text, "#w11#", ATLASLOOT_THROWN);
    text = gsub(text, "#w12#", ATLASLOOT_WAND);
    text = gsub(text, "#w13#", ATLASLOOT_FIST);
    
    -- Misc. Equipment
    text = gsub(text, "#e1#", ATLASLOOT_POTION);
    text = gsub(text, "#e2#", ATLASLOOT_FOOD);
    text = gsub(text, "#e3#", ATLASLOOT_DRINK);
    text = gsub(text, "#e4#", ATLASLOOT_BANDAGE);
    text = gsub(text, "#e5#", ATLASLOOT_ARROW);
    text = gsub(text, "#e6#", ATLASLOOT_BULLET);
    text = gsub(text, "#e7#", ATLASLOOT_MOUNT);
    text = gsub(text, "#e8#", ATLASLOOT_AMMO);
    text = gsub(text, "#e9#", ATLASLOOT_QUIVER);
    text = gsub(text, "#e10#", ATLASLOOT_BAG);
    text = gsub(text, "#e11#", ATLASLOOT_ENCHANT);
    text = gsub(text, "#e12#", ATLASLOOT_TRADE_GOODS);
    text = gsub(text, "#e13#", ATLASLOOT_SCOPE);
    text = gsub(text, "#e14#", ATLASLOOT_KEY);
    text = gsub(text, "#e15#", ATLASLOOT_PET);
    text = gsub(text, "#e16#", ATLASLOOT_IDOL);
    text = gsub(text, "#e17#", ATLASLOOT_TOTEM);
    text = gsub(text, "#e18#", ATLASLOOT_LIBRAM);
    text = gsub(text, "#e19#", ATLASLOOT_DARKMOON);
    text = gsub(text, "#e20#", ATLASLOOT_BOOK);
    text = gsub(text, "#e21#", ATLASLOOT_BANNER);
    
    -- Classes
    text = gsub(text, "#c1#", ATLASLOOT_DRUID);
    text = gsub(text, "#c2#", ATLASLOOT_HUNTER);
    text = gsub(text, "#c3#", ATLASLOOT_MAGE);
    text = gsub(text, "#c4#", ATLASLOOT_PALADIN);
    text = gsub(text, "#c5#", ATLASLOOT_PRIEST);
    text = gsub(text, "#c6#", ATLASLOOT_ROGUE);
    text = gsub(text, "#c7#", ATLASLOOT_SHAMAN);
    text = gsub(text, "#c8#", ATLASLOOT_WARLOCK);
    text = gsub(text, "#c9#", ATLASLOOT_WARRIOR);
    
    --Professions
    text = gsub(text, "#p1#", ATLASLOOT_ALCHEMY);
    text = gsub(text, "#p2#", ATLASLOOT_BLACKSMITHING);
    text = gsub(text, "#p3#", ATLASLOOT_COOKING);
    text = gsub(text, "#p4#", ATLASLOOT_ENCHANTING);
    text = gsub(text, "#p5#", ATLASLOOT_ENGINEERING);
    text = gsub(text, "#p6#", ATLASLOOT_FIRST_AID);
    text = gsub(text, "#p7#", ATLASLOOT_LEATHERWORKING);
    text = gsub(text, "#p8#", ATLASLOOT_TAILORING);
    text = gsub(text, "#p9#", ATLASLOOT_DRAGONSCALE);
    text = gsub(text, "#p10#", ATLASLOOT_TRIBAL);
    text = gsub(text, "#p11#", ATLASLOOT_ELEMENTAL);
    
    --Reputation
    text = gsub(text, "#r1#", ATLASLOOT_NEUTRAL);
    text = gsub(text, "#r2#", ATLASLOOT_FRIENDLY);
    text = gsub(text, "#r3#", ATLASLOOT_HONORED);
    text = gsub(text, "#r4#", ATLASLOOT_REVERED);
    text = gsub(text, "#r5#", ATLASLOOT_EXALTED);
    
    --Battleground Factions
    text = gsub(text, "#b1#", ATLASLOOT_BG_STORMPIKE);
    text = gsub(text, "#b2#", ATLASLOOT_BG_FROSTWOLF);
    text = gsub(text, "#b3#", ATLASLOOT_BG_SENTINELS);
    text = gsub(text, "#b4#", ATLASLOOT_BG_OUTRIDERS);
    text = gsub(text, "#b5#", ATLASLOOT_BG_ARATHOR);
    text = gsub(text, "#b6#", ATLASLOOT_BG_DEFILERS);
    
    -- Misc phrases and mod specific stuff
    text = gsub(text, "#m1#", ATLASLOOT_CLASSES);
    text = gsub(text, "#m2#", ATLASLOOT_QUEST1);
    text = gsub(text, "#m3#", ATLASLOOT_QUEST2);
    text = gsub(text, "#m4#", ATLASLOOT_QUEST3);
    text = gsub(text, "#m5#", ATLASLOOT_SHARED);
    text = gsub(text, "#m6#", ATLASLOOT_HORDE);
    text = gsub(text, "#m7#", ATLASLOOT_ALLIANCE);
    text = gsub(text, "#m8#", ATLASLOOT_UNIQUE);
    text = gsub(text, "#m9#", ATLASLOOT_RIGHTSIDE);
    text = gsub(text, "#m10#", ATLASLOOT_LEFTSIDE);
    text = gsub(text, "#m11#", ATLASLOOT_FELCOREBAG);
    text = gsub(text, "#m12#", ATLASLOOT_ONYBAG);
    text = gsub(text, "#m13#", ATLASLOOT_WCBAG);
    text = gsub(text, "#m14#", ATLASLOOT_FULLSKILL);
    text = gsub(text, "#m15#", ATLASLOOT_295);
    text = gsub(text, "#m16#", ATLASLOOT_275);
    text = gsub(text, "#m17#", ATLASLOOT_265);
    text = gsub(text, "#m18#", ATLASLOOT_290);
    text = gsub(text, "#m19#", ATLASLOOT_SET);
    text = gsub(text, "#m20#", ATLASLOOT_285);
    text = gsub(text, "#m21#", ATLASLOOT_16SLOT);
    
    text = gsub(text, "#x1#", ATLASLOOT_COBRAHN);
    text = gsub(text, "#x2#", ATLASLOOT_ANACONDRA);
    text = gsub(text, "#x3#", ATLASLOOT_SERPENTIS);
    text = gsub(text, "#x4#", ATLASLOOT_FANGDRUID);
    text = gsub(text, "#x5#", ATLASLOOT_PYTHAS);
    text = gsub(text, "#x6#", ATLASLOOT_VANCLEEF);
    text = gsub(text, "#x7#", ATLASLOOT_GREENSKIN);
    text = gsub(text, "#x8#", ATLASLOOT_DEFIASMINER);
    text = gsub(text, "#x9#", ATLASLOOT_DEFIASOVERSEER);
    text = gsub(text, "#x10#", ATLASLOOT_Primal_Hakkari_Kossack);
    text = gsub(text, "#x11#", ATLASLOOT_Primal_Hakkari_Shawl);
    text = gsub(text, "#x12#", ATLASLOOT_Primal_Hakkari_Bindings);
    text = gsub(text, "#x13#", ATLASLOOT_Primal_Hakkari_Sash);
    text = gsub(text, "#x14#", ATLASLOOT_Primal_Hakkari_Stanchion);
    text = gsub(text, "#x15#", ATLASLOOT_Primal_Hakkari_Aegis);
    text = gsub(text, "#x16#", ATLASLOOT_Primal_Hakkari_Girdle);
    text = gsub(text, "#x17#", ATLASLOOT_Primal_Hakkari_Armsplint);
    text = gsub(text, "#x18#", ATLASLOOT_Primal_Hakkari_Tabard);
    text = gsub(text, "#x19#", ATLASLOOT_Qiraji_Ornate_Hilt);
    text = gsub(text, "#x20#", ATLASLOOT_Qiraji_Martial_Drape);
    text = gsub(text, "#x21#", ATLASLOOT_Qiraji_Magisterial_Ring);
    text = gsub(text, "#x22#", ATLASLOOT_Qiraji_Ceremonial_Ring);
    text = gsub(text, "#x23#", ATLASLOOT_Qiraji_Regal_Drape);
    text = gsub(text, "#x24#", ATLASLOOT_Qiraji_Spiked_Hilt);
    text = gsub(text, "#x25#", ATLASLOOT_Qiraji_Bindings_of_Dominance);
    text = gsub(text, "#x26#", ATLASLOOT_Veknilashs_Circlet);
    text = gsub(text, "#x27#", ATLASLOOT_Ouros_Intact_Hide);
    text = gsub(text, "#x28#", ATLASLOOT_Husk_of_the_Old_God);
    text = gsub(text, "#x29#", ATLASLOOT_Qiraji_Bindings_of_Command);
    text = gsub(text, "#x30#", ATLASLOOT_Veklors_Diadem);
    text = gsub(text, "#x31#", ATLASLOOT_Skin_of_the_Great_Sandworm);
    text = gsub(text, "#x32#", ATLASLOOT_Carapace_of_the_Old_God);
    text = gsub(text, "#x33#", ATLASLOOT_SCARLETDEFENDER);
    text = gsub(text, "#x34#", ATLASLOOT_SCARLETTRASH);
    text = gsub(text, "#x35#", ATLASLOOT_SCARLETCHAMPION);
    text = gsub(text, "#x36#", ATLASLOOT_SCARLETCENTURION);
    text = gsub(text, "#x37#", ATLASLOOT_SCARLETHEROD);
    text = gsub(text, "#x38#", ATLASLOOT_SCARLETPROTECTOR);    
    
    --Text colouring
    text = gsub(text, "=q0=", "|cff9d9d9d");
    text = gsub(text, "=q1=", "|cffFFFFFF");
    text = gsub(text, "=q2=", "|cff1eff00");
    text = gsub(text, "=q3=", "|cff0070dd");
    text = gsub(text, "=q4=", "|cff9F3FFF");
    text = gsub(text, "=q5=", "|cffFF8400");
    text = gsub(text, "=q6=", "|cffFF0000");
    text = gsub(text, "=ds=", "|cffFFd200");
    return text;
end

function MetaMapBLT_OnSelect(lootID, name)
	if(lootID == nil) then return; end
	local info;
	if(lootID and lootID ~= "") then
		MetaMapBLT_ToggleDR(1);
		local itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, itemColor;
		local iconFrame, nameFrame, extraFrame;
		local text, extra;
		if(string.find(lootID, "CLASS_SET")) then
			MetaMapBLT_SetMenu(lootID, name);
			info = METAMAPBLT_CLASS_SELECT;
			lootID = nil;
		end
		for i = 1, 30, 1 do
			if(MetaMapBLTData[lootID] ~= nil and MetaMapBLTData[lootID][i] ~= nil and MetaMapBLTData[lootID][i][3] ~= "") then
				itemName, itemLink, itemQuality, itemLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture = GetItemInfo(MetaMapBLTData[lootID][i][1]);
				if(GetItemInfo(MetaMapBLTData[lootID][i][1])) then
					_, _, _, itemColor = GetItemQualityColor(itemQuality);
					text = itemColor..itemName;
				else
					text = MetaMapBLTData[lootID][i][3];
					text = MetaMapBLT_FixText(text);
				end
				
				extra = MetaMapBLTData[lootID][i][4];
                extra = MetaMapBLT_FixText(extra)
				if(not GetItemInfo(MetaMapBLTData[lootID][i][1]) and (MetaMapBLTData[lootID][i][1] ~= 0)) then
					extra = extra.." |cffff0000(no iteminfo)";
				end
			
				getglobal("MetaMapBLTItem_"..i.."_Icon"):SetTexture("Interface\\Icons\\"..MetaMapBLTData[lootID][i][2]);
				getglobal("MetaMapBLTItem_"..i.."_Extra"):SetText(extra);
				getglobal("MetaMapBLTItem_"..i.."_Name"):SetText(text);
				getglobal("MetaMapBLTItem_"..i).itemID = MetaMapBLTData[lootID][i][1];
				getglobal("MetaMapBLTItem_"..i).storeID = MetaMapBLTData[lootID][i][1];
				getglobal("MetaMapBLTItem_"..i).droprate = MetaMapBLTData[lootID][i][5];
				getglobal("MetaMapBLTItem_"..i).i = 1;
				getglobal("MetaMapBLTItem_"..i):Show();
				MetaMapContainer_InfoText:Hide();
			else
				getglobal("MetaMapBLTItem_"..i):Hide();
			end
			if(MetaMapBLTData[lootID] == nil and info == nil) then 
				info = METAMAPBLT_NO_DATA;
			end
		end
	else
		for i = 1, 30, 1 do
			getglobal("MetaMapBLTItem_"..i):Hide();
		end            
		info = METAMAPBLT_NO_INFO;
	end
	MetaMapContainer_ShowFrame(MetaMapBLT_SubFrame, name, METAMAPBLT_HINT, info);
end

function MetaMapBLTItem_OnEnter()
	if(this.itemID ~= nil) then
    if(IsAddOnLoaded("LootLink") and GetItemInfo(this.itemID) == nil) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT", -200, 0);
      LootLink_SetTooltip(GameTooltip, strsub(getglobal("MetaMapBLTItem_"..this:GetID().."_Name"):GetText(), 11), 1);
			if( this.droprate ~= nil) then
				GameTooltip:AddLine("Drop Rate: "..this.droprate, 1, 1, 0);
			end
			GameTooltip:Show();
    elseif(IsAddOnLoaded("ItemSync")) then
			ISync:ButtonEnter();
			if( this.droprate ~= nil) then
				GameTooltip:AddLine("Drop Rate: "..this.droprate, 1, 1, 0);
				GameTooltip:Show();
			end
		elseif(this.itemID ~= nil and  GetItemInfo(this.itemID) ~= nil) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT", -200, 0);
			GameTooltip:SetHyperlink("item:"..this.itemID..":0:0:0");
			if( this.droprate ~= nil) then
				GameTooltip:AddLine("Drop Rate: "..this.droprate, 1, 1, 0);
			end
			GameTooltip:Show();
		end
	end
end

function MetaMapBLTItem_OnClick()
	local iteminfo = GetItemInfo(this.itemID);
	local color = strsub(getglobal("MetaMapBLTItem_"..this:GetID().."_Name"):GetText(), 1, 10);
	local name = strsub(getglobal("MetaMapBLTItem_"..this:GetID().."_Name"):GetText(), 11);
	if(ChatFrameEditBox:IsVisible() and IsShiftKeyDown() and iteminfo) then
		ChatFrameEditBox:Insert(color.."|Hitem:"..this.itemID..":0:0:0|h["..name.."]|h|r");
	elseif(IsControlKeyDown() and iteminfo) then
		DressUpItemLink(this.itemID);
		DressUpFrame:Show();
		DressUpItemLink(this.itemID);
	elseif(IsAddOnLoaded("ItemSync")) then
		ISync:AddTooltipInfo(GameTooltip, "item:"..this.itemID..":0:0:0", 1);
	end
end
    
function MetaMapBLT_SetMenu(lootID, name)
	MetaMapBLT_ClassSet = string.gsub(lootID, "CLASS_SET", "")
	MetaMapBLT_ClassName = name;
	MetaMapContainer_ShowFrame(MetaMapBLT_SubFrame, name, METAMAPBLT_HINT, info);
	MetaMapBLT_ClassMenu:Show();
end

function MetaMapBLT_MenuOnClick()
	local className = MetaMapBLT_ClassSet..getglobal(this:GetName().."ClassName"):GetText();
	local header = MetaMapBLT_ClassName.." - "..this:GetText();
	MetaMapBLT_OnSelect(className, header);
end

function MetaMapBLT_ToggleDR(mode)
	if(mode == 1) then
		DressUpFrame:SetMovable(true);
		DressUpFrame:SetFrameStrata("FULLSCREEN");
		DressUpFrame:SetScript("OnMouseDown", X_Frame:GetScript("OnMouseDown"));
		DressUpFrame:SetScript("OnMouseUp", X_Frame:GetScript("OnMouseUp"));
	else
		DressUpFrame:SetMovable(false);
		DressUpFrame:SetFrameStrata("HIGH");
		DressUpFrame:SetScript("OnMouseDown", nil);
		DressUpFrame:SetScript("OnMouseUp", nil);
	end
end

function MetaMapBLTItem_OnLeave()
	GameTooltip:Hide();
end

function MetaMapBLT_SetClassColors()
	local color;
	color = RAID_CLASS_COLORS["DRUID"];
	MetaMapBLT_DruidButton:SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["HUNTER"];
	MetaMapBLT_HunterButton:SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["MAGE"];
	MetaMapBLT_MageButton:SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["PALADIN"];
	MetaMapBLT_PaladinButton:SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["PRIEST"];
	MetaMapBLT_PriestButton:SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["ROGUE"];
	MetaMapBLT_RogueButton:SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["SHAMAN"];
	MetaMapBLT_ShamanButton:SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["WARLOCK"];
	MetaMapBLT_WarlockButton:SetTextColor(color.r, color.g, color.b);
	color = RAID_CLASS_COLORS["WARRIOR"];
	MetaMapBLT_WarriorButton:SetTextColor(color.r, color.g, color.b);
end
