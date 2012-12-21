TooltipsBase_ENABLE = 1;
TOOLTIP_IS_NEWBIE = nil;
TooltipsBase_Original_GameTooltip_ClearMoney = nil;
TooltipsBase_Original_GameTooltip_SetUnit = nil;

RealmPlayers = { };
RealmGuilds = { };

-- unithandle	= "player"	"target"
-- unittype		= "elite"	"rare" 	"raremob" 

function UniversalFrameHandler(unithandle,unittype)
	if( unithandle == "target" ) then
		if( unittype == "elite" ) then
			TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
			DUF_ChangeItNow_Elite();
		elseif( unittype == "rare" ) then
			TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
			DUF_ChangeItNow_Rare();
		elseif( unittype == "raremob" ) then
			TargetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-RareMob");
		end
	elseif( unithandle == "player" ) then
		if( unittype == "elite" ) then
			PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
		elseif( unittype == "rare" ) then
			PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
		elseif( unittype == "raremob" ) then
			PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-RareMob");
		end
	end
end

function DUF_ChangeItNow_Elite()
  if(DUF_Options) then
	local texture;
	if (DUF_Settings[DUF_INDEX].target.EliteTexture.elitetexture and DUF_Settings[DUF_INDEX].target.EliteTexture.elitetexture ~= "") then
		texture = "Interface\\AddOns\\DiscordUnitFrames\\CustomTextures\\"..DUF_Settings[DUF_INDEX].target.EliteTexture.elitetexture;
	elseif (DUF_Settings[DUF_INDEX].target.EliteTexture.faceleft) then
		texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\EliteLeft";
	else
		texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\Elite";
	end
	if (DUF_OPTIONS_VISIBLE and (not DUF_Settings[DUF_INDEX].target.EliteTexture.hide)) then
		DUF_TargetFrame_EliteTexture_Texture:SetTexture(texture);
		DUF_TargetFrame_EliteTexture:Show();
		return;
	end
	if (not DUF_Settings[DUF_INDEX].target.EliteTexture.hide) then
		if (DUF_Settings[DUF_INDEX].target.EliteTexture.raretexture and DUF_Settings[DUF_INDEX].target.EliteTexture.raretexture ~= "") then
			texture = "Interface\\AddOns\\DiscordUnitFrames\\CustomTextures\\"..DUF_Settings[DUF_INDEX].target.EliteTexture.raretexture;
		elseif (DUF_Settings[DUF_INDEX].target.EliteTexture.faceleft) then
			texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\RareLeft";
		else
			texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\Rare";
		end
		DUF_TargetFrame_EliteTexture_Texture:SetTexture(texture);
		DUF_TargetFrame_EliteTexture:Show();
	end
  end
end

function DUF_ChangeItNow_Rare()
  if(DUF_Options) then
	local texture;
	if (DUF_Settings[DUF_INDEX].target.EliteTexture.elitetexture and DUF_Settings[DUF_INDEX].target.EliteTexture.elitetexture ~= "") then
		texture = "Interface\\AddOns\\DiscordUnitFrames\\CustomTextures\\"..DUF_Settings[DUF_INDEX].target.EliteTexture.elitetexture;
	elseif (DUF_Settings[DUF_INDEX].target.EliteTexture.faceleft) then
		texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\EliteLeft";
	else
		texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\Elite";
	end
	if (DUF_OPTIONS_VISIBLE and (not DUF_Settings[DUF_INDEX].target.EliteTexture.hide)) then
		DUF_TargetFrame_EliteTexture_Texture:SetTexture(texture);
		DUF_TargetFrame_EliteTexture:Show();
		return;
	end
	if (not DUF_Settings[DUF_INDEX].target.EliteTexture.hide) then
		if (DUF_Settings[DUF_INDEX].target.EliteTexture.raretexture and DUF_Settings[DUF_INDEX].target.EliteTexture.raretexture ~= "") then
			texture = "Interface\\AddOns\\DiscordUnitFrames\\CustomTextures\\"..DUF_Settings[DUF_INDEX].target.EliteTexture.raretexture;
		elseif (DUF_Settings[DUF_INDEX].target.EliteTexture.faceleft) then
			texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\RareLeft";
		else
			texture = "Interface\\AddOns\\DiscordUnitFrames\\Icons\\Rare";
		end
		DUF_TargetFrame_EliteTexture_Texture:SetTexture(texture);
		DUF_TargetFrame_EliteTexture:Show();
	end
  end
end

-- ARTHAS
function Realm_Arthas()
	RealmPlayers = { 
		["Mobscene"] = "elite";
		["Faredegyn"] = "elite";
		["Damagius"] = "elite";
		["Sketchy"] = "elite";
		["Dakkon"] = "elite";
	};
	RealmGuilds = { };
end

-- NATHREZIM
function Realm_Nathrezim()
	RealmPlayers = { 
		["Dakkan"] = "elite";
		["Exodius"] = "elite";
		["Arch"] = "elite";
		["Kilah"] = "elite";
		["Nightcrawlor"] = "elite";
		["Archen"] = "elite";
		["Archera"] = "elite";
	};
	RealmGuilds = {	
		["Ab Igne Inferiori"] = "rare";
	};
end

-- ELDRAD THALAS
function Realm_Eldrad_Thalas()
	RealmPlayers = { 
		["Bikk"] = "elite";
	};
	RealmGuilds = { };
end

-- DUNEMAUL
function Realm_Dunemaul()
	RealmPlayers = { 
		["Melady"] = "elite";
		["Dardas"] = "elite";
		["Xandarous"] = "elite";
	};
	RealmGuilds = { };
end

-- STORMSCALE
function Realm_Stormscale()
	RealmPlayers = { 
		["Valec"] = "elite";
		["Vilandra"] = "elite";
	};
	RealmGuilds = { };
end

-- MAL'GANIS
function Realm_MalGanis()
	RealmPlayers = { 
		["Zariz"] = "elite";
	};
	RealmGuilds = { };
end

-- DRAGONBLIGHT
function Realm_Dragonblight()
	RealmPlayers = { 
		["Kellen"] = "elite";
		["Nossferratus"] = "elite";
	};
	RealmGuilds = { };
end

-- MEDIVH
function Realm_Medivh()
	RealmPlayers = { 
		["Wizbang"] = "rare";
	};
	RealmGuilds = { };
end

-- STORMRAGE
function Realm_Stormrage()
	RealmPlayers = { 
		["Breasal"] = "rare";
	};
	RealmGuilds = { };
end

-- ARCHIMONDE
function Realm_Archimonde()
	RealmPlayers = { 
		["UFLA"] = "rare";
	};
	RealmGuilds = { };
end

-- ICECROWN
function Realm_Icecrown()
	RealmPlayers = { 
		["Eludeveren"] = "elite";
	};
	RealmGuilds = { };
end

-- BLOODSCALP
function Realm_Bloodscalp()
	RealmPlayers = { 
		["Canibis"] = "elite";
	};
	RealmGuilds = { };
end

-- PERENOLDE
function Realm_Perenolde()
	RealmPlayers = { 
		["Nytebandit"] = "elite";
	};
	RealmGuilds = { };
end

-- AGGRAMAR
function Realm_Aggramar()
	RealmPlayers = { 
		["Showdon"] = "elite";
	};
	RealmGuilds = { };
end

-- DEATHWING
function Realm_Deathwing()
	RealmPlayers = { 
		["Narconis"] = "elite";
	};
	RealmGuilds = { };
end

-- DAGGERSPINE
function Realm_Daggerspine()
	RealmPlayers = { 
		["Dyami"] = "elite";
	};
	RealmGuilds = { };
end

-- LIGHTNING'S BLADE
function Realm_LightningsBlade()
	RealmPlayers = { 
		["Zeeg"] = "elite";
		["Dakkan"] = "elite";
	};
	RealmGuilds = { 
		["Descension"] = "rare";
	};
end

-- SKULLCRUSHER
function Realm_Skullcrusher()
	RealmPlayers = { 
		["Reaver"] = "elite";
		["Wizzy"] = "elite";
	};
	RealmGuilds = { };
end

-- KHAZ'GOROTH
function Realm_Khazgoroth()
	RealmPlayers = { 
		["Nightslayer"] = "rare";
	};
	RealmGuilds = { };
end

-- AZJOL-NERUB
function Realm_AzjolNerub()
	RealmPlayers = { 
		["Valentyne"] = "rare";
	};
	RealmGuilds = { };
end

-- CHROMAGGUS
function Realm_Chromaggus()
	RealmPlayers = {
		["Jezzy"] = "elite";
		["Chillakilla"] = "elite";
		["Dakken"] = "elite";
		["Dakkon"] = "elite";
		["Nathen"] = "elite";
		["Raxle"] = "elite";
		["Xenobia"] = "elite";
		["Crazyska"] = "elite";
		["Yulia"] = "elite";
	};
	RealmGuilds = { 
		["Mayhem"] = "rare";
	};
end

-- WILDHAMMER
function Realm_Wildhammer()
	RealmPlayers = { 
		["Archess"] = "elite";
		["Prizm"] = "elite";
		["Sen"] = "elite";
		["Cen"] = "elite";
		["Shikota"] = "elite";
		["Archiess"] = "elite";
		["Borealis"] = "elite";
	};
	RealmGuilds = { 
		["Atonement"] = "rare";
	};
end

-- SMOLDERTHORN
function Realm_Smolderthorn()
	RealmPlayers = { 
		["Blaen"] = "rare";
	};
	RealmGuilds = { };
end

-- CENARIUS
function Realm_Cenarius()
	RealmPlayers = { 
		["Nuurelin"] = "elite";
	};
	RealmGuilds = { };
end

function TooltipsBase_GameTooltip_SetUnit(this,unit)
	TooltipsBase_Original_GameTooltip_SetUnit(this,unit);
	TooltipsBase_UnitHandler(unit);
	TooltipsBase_MouseoverFixSize();
end

function TooltipsBase_GameTooltip_OnHide()
	TOOLTIP_IS_NEWBIE = nil;
	-- fix for clear money
	if (TooltipsBase_ENABLE == 1) then
		TooltipsBase_Original_GameTooltip_ClearMoney();
	end
end

function TooltipsBase_GameTooltip_ClearMoney()
	if (TooltipsBase_ENABLE == 1) then
	   -- do nothing, this is handled in the onHide now!
	else
		TooltipsBase_Original_GameTooltip_ClearMoney();
	end
end

-- Handler called when mouseing over a unit
-- Example usage:

function TooltipsBase_UnitHandler(type)
	TargetBorderType = RealmPlayers[UnitName("target")];
	if( TargetBorderType ) then
		UniversalFrameHandler("target", TargetBorderType);
	else
		TargetBorderType = RealmGuilds[GetGuildInfo("target")];
		if( TargetBorderType ) then
			UniversalFrameHandler("target", TargetBorderType);
		end
	end
end

-- fix the size and remove blank lines
-- note that blank lines can still be created by setting the string to ""
function TooltipsBase_MouseoverFixSize()
	local tooltipName = "GameTooltip";
	local newWidth = 0;
	local newHeight = 20;
	local lastValid = 0;
	for i = 1, 20 do
		local checkText = getglobal(tooltipName.."TextLeft"..i);
		if (checkText and checkText:IsVisible()) then
			local width = checkText:GetWidth() + 24;
			if (width > newWidth) then
				newWidth = width;
			end
			newHeight = newHeight + checkText:GetHeight() + 2;
			lastValid = lastValid + 1;
			if (lastValid ~= i) then
				local moveText = getglobal(tooltipName.."TextLeft"..lastValid);
				if (moveText ~= nil) then
					moveText:SetText(checkText:GetText());
					moveText:Show();
					checkText:SetText("");
					checkText:Hide();
				end
			end
		end
	end

	GameTooltip:SetWidth(newWidth);
	GameTooltip:SetHeight(newHeight);
end


function TooltipsBase_IsNewbieTip()
	return TOOLTIP_IS_NEWBIE ;
end

function TooltipsBase_GameTooltip_AddNewbieTip(normalText, r, g, b, newbieText, noNormalText)
	if ( SHOW_NEWBIE_TIPS == "1" ) then
		TOOLTIP_IS_NEWBIE = 1;
	else
		TOOLTIP_IS_NEWBIE = nil;
	end

end


function TooltipsBase_OnLoad()
--	Sea.util.hook("UnitFrame_OnEnter","TooltipsBase_UnitFrame_OnEnter","after");
--	Sea.util.hook("GameTooltip_OnHide","TooltipsBase_GameTooltip_OnHide","after");
--	Sea.util.hook("GameTooltip_AddNewbieTip","TooltipsBase_GameTooltip_AddNewbieTip","after");
--	Sea.util.hook("TooltipsBase_UnitHandler","TooltipsProps_UnitHandler","after");
	-- fix for clear money
	TooltipsBase_Original_GameTooltip_ClearMoney = GameTooltip_ClearMoney;
	GameTooltip_ClearMoney = TooltipsBase_GameTooltip_ClearMoney;
	-- Sea.util.hook doesnt handle GameTooltip:SetUnit
	-- however this doesnt seem to be working right?
	TooltipsBase_Original_GameTooltip_SetUnit	= GameTooltip.SetUnit;
	GameTooltip.SetUnit = TooltipsBase_GameTooltip_SetUnit;

	
	
	if(UltimateUI_RegisterConfiguration) then
		UltimateUI_RegisterConfiguration(
			"UUI_TOOLTIPSBASE",
			"SECTION",
			TOOLTIPSBASE_SEP,
			TOOLTIPSBASE_SEP_INFO
			);
		UltimateUI_RegisterConfiguration(
			"UUI_TOOLTIPSBASE_SEP",
			"SEPARATOR",
			TOOLTIPSBASE_SEP,
			TOOLTIPSBASE_SEP_INFO
			);
		UltimateUI_RegisterConfiguration(
			"UUI_TOOLTIPS_BASE_C",
			"CHECKBOX",
			TOOLTIPSBASE_ENABLE,
			TOOLTIPSBASE_ENABLE_INFO,
			TooltipsBase_Toggle,
			1
			);
	end
	
	ThisRealmName = GetCVar("realmName");
	-- Set correct props info according to realm
	if( ThisRealmName == "Arthas" ) then
		Realm_Arthas();
	elseif( ThisRealmName == "Nathrezim" ) then
		Realm_Nathrezim();
	elseif( ThisRealmName == "Chromaggus" ) then
		Realm_Chromaggus();
	elseif( ThisRealmName == "Eldrad Thalas" ) then
		Realm_Eldrad_Thalas();
	elseif( ThisRealmName == "Dunemaul" ) then
		Realm_Dunemaul();
	elseif( ThisRealmName == "Stormscale" ) then
		Realm_Stormscale();
	elseif( ThisRealmName == "Mal'Ganis" ) then
		Realm_MalGanis();
	elseif( ThisRealmName == "Dragonblight" ) then
		Realm_Dragonblight();
	elseif( ThisRealmName == "Medivh" ) then
		Realm_Medivh();
	elseif( ThisRealmName == "Stormrage" ) then
		Realm_Stormrage();
	elseif( ThisRealmName == "Archimonde" ) then
		Realm_Archimonde();
	elseif( ThisRealmName == "Icecrown" ) then
		Realm_Icecrown();
	elseif( ThisRealmName == "Bloodscalp" ) then
		Realm_Bloodscalp();
	elseif( ThisRealmName == "Perenolde" ) then
		Realm_Perenolde();
	elseif( ThisRealmName == "Aggramar" ) then
		Realm_Aggramar();
	elseif( ThisRealmName == "Deathwing" ) then
		Realm_Deathwing();
	elseif( ThisRealmName == "Daggerspine" ) then
		Realm_Daggerspine();
	elseif( ThisRealmName == "Lightning's Blade" ) then
		Realm_LightningsBlade();
	elseif( ThisRealmName == "Skullcrusher" ) then
		Realm_Skullcrusher();
	elseif( ThisRealmName == "Azjol-Nerub" ) then
		Realm_AzjolNerub();
	elseif( ThisRealmName == "Khaz'goroth" ) then
		Realm_Khazgoroth();
	elseif( ThisRealmName == "Wildhammer" ) then
		Realm_Wildhammer();
	elseif( ThisRealmName == "Smolderthorn" ) then
		Realm_Smolderthorn();
	elseif( ThisRealmName == "Cenarius" ) then
		Realm_Cenarius();
	end
	
--	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
end
function TooltipsBase_Toggle(toggle)
	if(toggle == 1) then
		TooltipsBase_ENABLE = 1;
	else
		TooltipsBase_ENABLE = nil;
	end
end
