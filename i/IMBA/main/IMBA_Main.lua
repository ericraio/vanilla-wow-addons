local IMBA_SLASH_COMMAND = "/imba";
IMBA_Version="1.4";

IMBA_RaidVersions={};
IMBA_Addons = {};
IMBA_SavedVariables = {};
IMBA_SavedVariables.Mods = {};
-- Raid zones
IMBA_LOCATIONS_MC = "Molten Core";
IMBA_LOCATIONS_BWL = "Blackwing Lair";
IMBA_LOCATIONS_ZG = "Zul'Gurub";
IMBA_LOCATIONS_AQ20 = "Ruins of Ahn'Qiraj";
IMBA_LOCATIONS_AQ40 = "Temple of Ahn'Qiraj";
IMBA_LOCATIONS_NAXX = "Naxxramas";
IMBA_LOCATIONS_NAXX_ABOM = "Naxxramas - Abomination Wing";
IMBA_LOCATIONS_NAXX_DK = "Naxxramas - Deathknight Wing";
IMBA_LOCATIONS_NAXX_PLAGUE = "Naxxramas - Plague Wing";
IMBA_LOCATIONS_NAXX_SPIDER = "Naxxramas - Spider Wing";
IMBA_LOCATIONS_NAXX_LAIR = "Naxxramas - Frostwyrm Lair";

IMBA_LOCATIONS_OTHER = "Other";


IMBA_Locations = {{IMBA_LOCATIONS_MC,0}, {IMBA_LOCATIONS_BWL,0}, {IMBA_LOCATIONS_ZG,0}, {IMBA_LOCATIONS_AQ20,0}, {IMBA_LOCATIONS_AQ40,0}, { IMBA_LOCATIONS_NAXX_ABOM, 0 }, { IMBA_LOCATIONS_NAXX_DK, 0 }, { IMBA_LOCATIONS_NAXX_PLAGUE, 0 }, { IMBA_LOCATIONS_NAXX_SPIDER, 0 }, { IMBA_LOCATIONS_NAXX_LAIR, 0}, { IMBA_LOCATIONS_OTHER, 0}};

IMBA_DEATH_MSG = "(.+) dies."

if (GetLocale()=="frFR") then
	--Translation by A.su.K.A
	IMBA_DEATH_MSG = "(.+) meurt."
end

function IMBA_SetBackdrops(num)
	for k, v in IMBA_Addons do
		if v.MainFrame~=nil then				
			getglobal(v.MainFrame):SetBackdrop(IMBA_BG[num].table);				
			getglobal(v.MainFrame):SetBackdropBorderColor(IMBA_SavedVariables.Colors["FrameBorder"].r,IMBA_SavedVariables.Colors["FrameBorder"].g,IMBA_SavedVariables.Colors["FrameBorder"].b,IMBA_SavedVariables.Colors["FrameBorder"].a);	
			getglobal(v.MainFrame):SetBackdropColor(IMBA_SavedVariables.Colors["FrameBG"].r,IMBA_SavedVariables.Colors["FrameBG"].g,IMBA_SavedVariables.Colors["FrameBG"].b,IMBA_SavedVariables.Colors["FrameBG"].a);	
			if getglobal(v.MainFrame.."_Close_Image") then
				getglobal(v.MainFrame.."_Close_Image"):SetTexture(IMBA_BG[num].close);
				getglobal(v.MainFrame.."_Close_Image"):SetVertexColor(IMBA_SavedVariables.Colors["FrameBorder"].r,IMBA_SavedVariables.Colors["FrameBorder"].g,IMBA_SavedVariables.Colors["FrameBorder"].b,IMBA_SavedVariables.Colors["FrameBorder"].a);
			end
		end
	end

	IMBA_Alerts:SetBackdrop(IMBA_BG[num].table);
	if IMBA_SavedVariables.ShowAlertWindow then		
		IMBA_Alerts:SetBackdropBorderColor(IMBA_SavedVariables.Colors["FrameBorder"].r,IMBA_SavedVariables.Colors["FrameBorder"].g,IMBA_SavedVariables.Colors["FrameBorder"].b,IMBA_SavedVariables.Colors["FrameBorder"].a);	
		IMBA_Alerts:SetBackdropColor(IMBA_SavedVariables.Colors["FrameBG"].r,IMBA_SavedVariables.Colors["FrameBG"].g,IMBA_SavedVariables.Colors["FrameBG"].b,IMBA_SavedVariables.Colors["FrameBG"].a);	
	else
		IMBA_Alerts:SetBackdropBorderColor(IMBA_SavedVariables.Colors["FrameBorder"].r,IMBA_SavedVariables.Colors["FrameBorder"].g,IMBA_SavedVariables.Colors["FrameBorder"].b,0);	
		IMBA_Alerts:SetBackdropColor(IMBA_SavedVariables.Colors["FrameBG"].r,IMBA_SavedVariables.Colors["FrameBG"].g,IMBA_SavedVariables.Colors["FrameBG"].b,0);	

	end
end

function IMBA_HideCloseButtons()
	for k, v in IMBA_Addons do
		if v.MainFrame~=nil then
			if getglobal(v.MainFrame.."_Close") then
				getglobal(v.MainFrame.."_Close"):Hide();
			end
		end
	end
end

function IMBA_ShowCloseButtons()
	for k, v in IMBA_Addons do
		if v.MainFrame~=nil then
			if getglobal(v.MainFrame.."_Close") then
				getglobal(v.MainFrame.."_Close"):Show();
			end
		end
	end
end

function IMBA_ResetPositions()
	for k, v in IMBA_Addons do
		if v.MainFrame~=nil then
			getglobal(v.MainFrame):ClearAllPoints();
			getglobal(v.MainFrame):SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		end
	end
	IMBA_Alerts:ClearAllPoints();
	IMBA_Alerts:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
end

function IMBA_AddAddon(BossName, Description, Location, RegenActivator, YellActivator, TestYell, MainFrame)
	IMBA_Addons[BossName]={};
	IMBA_Addons[BossName].Active=true;
	IMBA_Addons[BossName].Running=false;
	IMBA_Addons[BossName].BossName=BossName;
	IMBA_Addons[BossName].Location=Location;
	IMBA_Addons[BossName].Description=Description;
	IMBA_Addons[BossName].RegenActivator=RegenActivator;
	IMBA_Addons[BossName].YellActivator=YellActivator;
	IMBA_Addons[BossName].TestYell=TestYell;
	IMBA_Addons[BossName].MainFrame=MainFrame;
	IMBA_Addons[BossName].MultiBoss=0;
	IMBA_Addons[BossName].BossNames={};

	IMBA_SavedVariables.Mods[BossName]={};
	IMBA_SavedVariables.Mods[BossName].Active=true;
	IMBA_SavedVariables.Mods[BossName].Visible=false;
	getglobal(MainFrame):Hide();

	--Sync Variables we track if the last change has been sent(delay by one cycle to allow for combat log variances),
	--then check the last value to see if its change update the last value and set Sent to false
	--The method determines how the variable gets sycned ("MAX" - whichever value is max gets chosen, "MIN" whatever value is minimum is chosen, "REPLACE" allows you to overwrite the value)
	IMBA_Addons[BossName].SyncVariableFunc=nil;
	IMBA_Addons[BossName].SyncVariablesSent={};
	IMBA_Addons[BossName].SyncVariablesLastVal={};	
	IMBA_Addons[BossName].SyncVariablesMethod={};

	--DEFAULT_CHAT_FRAME:AddMessage("IMBA - "..BossName.." Added", 1.0, 1.0, 0.0);
end

function IMBA_AddBossName(AddonName,BossName)
	IMBA_Addons[AddonName].MultiBoss=IMBA_Addons[AddonName].MultiBoss+1;
	IMBA_Addons[AddonName].BossNames[IMBA_Addons[AddonName].MultiBoss]=BossName;
	IMBA_Addons[AddonName].BossesAlive=IMBA_Addons[AddonName].MultiBoss;
end

function IMBA_AddOption(AddonName,OptionText,Func,ValueFunc)
	if IMBA_Addons[AddonName].Options==nil then
		IMBA_Addons[AddonName].Options={};
	end
	IMBA_Addons[AddonName].Options[OptionText]={};
	IMBA_Addons[AddonName].Options[OptionText].text=OptionText;
	IMBA_Addons[AddonName].Options[OptionText].valuefunc=ValueFunc;
	IMBA_Addons[AddonName].Options[OptionText].func=Func;

	if IMBA_Addons[AddonName].OptionsOrder==nil then
		IMBA_Addons[AddonName].OptionsOrder={};
	end
	tinsert(IMBA_Addons[AddonName].OptionsOrder,OptionText);
end

function IMBA_AddOption2(AddonName,VarName, OptionText)
	if IMBA_SavedVariables.Mods[AddonName].Var==nil then
		IMBA_SavedVariables.Mods[AddonName].Var={};
		IMBA_Addons[AddonName].VarText={};
	end
	IMBA_SavedVariables.Mods[AddonName].Var[VarName]=false;
	IMBA_Addons[AddonName].VarText[VarName]=OptionText;

	if IMBA_Addons[AddonName].OptionsOrder2==nil then
		IMBA_Addons[AddonName].OptionsOrder2={};
	end
	tinsert(IMBA_Addons[AddonName].OptionsOrder2,VarName);
end

function IMBA_CheckVar(AddonName,VarName)
	if IMBA_SavedVariables.Mods[AddonName]==nil then
		IMBA_SavedVariables.Mods[AddonName]={};
	end
	if IMBA_SavedVariables.Mods[AddonName].Var==nil then
		IMBA_SavedVariables.Mods[AddonName].Var={};
	end
	if IMBA_SavedVariables.Mods[AddonName].Var[VarName]==nil then
		IMBA_SavedVariables.Mods[AddonName].Var[VarName]=false;
	end
	return IMBA_SavedVariables.Mods[AddonName].Var[VarName]
end

function IMBA_CheckSyncVariables(Addon)
	for k, v in Addon.SyncVariablesLastVal do
		--First Checking to see if need to send a variable
		if Addon.SyncVariablesSent[k]==false then
			SendAddonMessage("IMBA", "VARSYNC "..k.." "..Addon.SyncVariablesLastVal[k].." "..Addon.SyncVariablesMethod[k],"RAID");
			Addon.SyncVariablesSent[k]=true;
		end

		--Only want to potentially send if the variable has changed
		if Addon.SyncVariablesLastVal[k]~=getglobal(k) then
			Addon.SyncVariablesLastVal[k]=getglobal(k);
			Addon.SyncVariablesSent[k]=false;
		end
	end
end


function IMBA_SyncVar(Addon,VarName,Value,Method)
	if Method=="MAX" then
		if Value>getglobal(VarName) then
			setglobal(VarName,Value);
			Addon.SyncVariablesLastVal[VarName]=Value;
			Addon.SyncVariablesSent[VarName]=true;
			if Addon.SyncVariableFunc~=nil then
				getglobal(Addon.SyncVariableFunc)();
			end
		end
	elseif Method=="MIN" then
		if Value<getglobal(VarName) then
			setglobal(VarName,Value);
			Addon.SyncVariablesLastVal[VarName]=Value;
			Addon.SyncVariablesSent[VarName]=true;
			if Addon.SyncVariableFunc~=nil then
				getglobal(Addon.SyncVariableFunc)();
			end
		end
	elseif Method=="REPLACE" then
		setglobal(VarName,Value);
		Addon.SyncVariablesLastVal[VarName]=Value;
		Addon.SyncVariablesSent[VarName]=true;
		if Addon.SyncVariableFunc~=nil then
			getglobal(Addon.SyncVariableFunc)();
		end
	end
end


function IMBA_AddSyncVar(Addon,VarName,Method)
	IMBA_Addons[Addon].SyncVariablesSent[VarName]=true;
	IMBA_Addons[Addon].SyncVariablesLastVal[VarName]=getglobal(VarName);	
	IMBA_Addons[Addon].SyncVariablesMethod[VarName]=Method;
end

function IMBA_SetSyncFunction(Addon,Func)
	IMBA_Addons[Addon].SyncVariableFunc=Func;
end

function IMBA_CheckIfRunning(Addon)
	return IMBA_Addons[Addon].Running;
end

function IMBA_OnUpdate()
	--First do we need to check for boss mod activations based on regen and is it time to?
	if IMBA_CheckRegen and (IMBA_CheckRegenTimer < GetTime()) then
		IMBA_CheckRegen=false;
		for k, v in IMBA_Addons do
			if v.Active and (v.RegenActivator ~= nil) and (v.Running==false) then
				if v.MultiBoss==0 then
					if IMBA_BossAggroed(v.BossName) then
						IMBA_CombatCheckTime=GetTime()+10;		--Next Time to Check in Combat
						IMBA_SyncTime=GetTime()+2+2*math.random();	--We add a random delay to the variable syncing
						IMBA_AddonRunning=true;
						
						v.Running=true;

						getglobal(v.RegenActivator)();
							
						SendAddonMessage("IMBA", "STARTADDON "..string.gsub(v.BossName," ","*"),"RAID");
					end
				else
					for i=1,v.MultiBoss do
						if IMBA_BossAggroed(v.BossNames[i]) then
							IMBA_CombatCheckTime=GetTime()+10;		--Next Time to Check in Combat
							IMBA_SyncTime=GetTime()+2+2*math.random();	--We add a random delay to the variable syncing
							IMBA_AddonRunning=true;
							
							v.Running=true;
								
							getglobal(v.RegenActivator)();

							v.BossesAlive=v.MultiBoss;

							SendAddonMessage("IMBA", "STARTADDON "..string.gsub(v.BossName," ","*"),"RAID");
						end
					end
				end
			end
		end
	end

	--Alright if Addons are running
	if IMBA_AddonRunning then
		if IMBA_CombatCheckTime<GetTime() then
			IMBA_AddonRunning=IMBA_RaidInCombat();
			if IMBA_AddonRunning==false then
				for k, v in IMBA_Addons do
					v.Running=false;
				end
			end
		end

		--If still running we can sync variables etc
		if IMBA_AddonRunning then
			if IMBA_SyncTime<GetTime() then
				for k, v in IMBA_Addons do
					if v.Running then
						IMBA_CheckSyncVariables(v);
					end
				end

				IMBA_SyncTime=GetTime()+7.5+2.5*math.random();
			end
		else--Otherwise deactivate all addons
			for k, v in IMBA_Addons do
				v.Running=false;
			end
		end
	end

	if IMBA_CheckVisibility<GetTime() then
		for k, v in IMBA_Addons do
			if v.MainFrame~=nil then				
				IMBA_SavedVariables.Mods[k].Visible=getglobal(v.MainFrame):IsShown();				
			end
		end
		IMBA_CheckVisibility=GetTime()+0.25;
	end
end

function IMBA_LoadColors()
	if IMBA_SavedVariables.Colors==nil then
		IMBA_SavedVariables.Colors={};
	end
	if IMBA_SavedVariables.Colors["FrameBG"]==nil then
		IMBA_SavedVariables.Colors["FrameBG"]={r=0,g=0,b=0,a=0.6};
	end
	if IMBA_SavedVariables.Colors["FrameBorder"]==nil then
		IMBA_SavedVariables.Colors["FrameBorder"]={r=1,g=1,b=1,a=1};
	end
	if IMBA_SavedVariables.Colors["BarStart"]==nil then
		IMBA_SavedVariables.Colors["BarStart"]={r=1,g=1,b=1};
	end
	if IMBA_SavedVariables.Colors["BarEnd"]==nil then
		IMBA_SavedVariables.Colors["BarEnd"]={r=1,g=1,b=1};
	end

	if IMBA_SavedVariables.Colors["BarInner"]==nil then
		IMBA_SavedVariables.Colors["BarInner"]={r=0.4,g=0.4,b=0.4,a=0.6};
	end
	if IMBA_SavedVariables.Colors["BarBorder"]==nil then
		IMBA_SavedVariables.Colors["BarBorder"]={r=0.9,g=0.9,b=0.9,a=0.6};
	end
end

function IMBA_OnEvent(event)
	if event=="PLAYER_REGEN_DISABLED" then
		IMBA_CheckRegen=true;
		IMBA_CheckRegenTimer=GetTime()+5;
	elseif event=="CHAT_MSG_MONSTER_YELL" then
		for k, v in IMBA_Addons do
			if v.Active and (v.YellActivator ~= nil) and (v.Running~=true) then
				if IMBA_AddonRunning==false then
					IMBA_CombatCheckTime=GetTime()+10;		--Next Time to Check in Combat
					IMBA_SyncTime=GetTime()+2+2*math.random();	--We add a random delay to the variable syncing
				end
				v.Running=v.Running or getglobal(v.YellActivator)(arg1);
				IMBA_AddonRunning=IMBA_AddonRunning or v.Running;
			end
		end
	elseif event=="CHAT_MSG_ADDON" then
		if arg1=="IMBA" then
			local commandName, params = IMBA_ExtractNextParam(arg2);
			if commandName=="VARSYNC" then
				local Addon, VarName, Value, Method;
				VarName, params = IMBA_ExtractNextParam(params);
				Value, params = IMBA_ExtractNextParam(params);
				Method, params = IMBA_ExtractNextParam(params);
				for k, v in IMBA_Addons do
					for k2, v2 in v.SyncVariablesLastVal do		
						if k2==VarName then
							IMBA_SyncVar(v,VarName,tonumber(Value),Method);
						end
					end
				end
			elseif commandName=="STARTADDON" then
				local Addon
				Addon,params=IMBA_ExtractNextParam(params);
				Addon=string.gsub(Addon,"*"," ");
				if IMBA_Addons[Addon] then
					if (not IMBA_CheckIfRunning(Addon)) and IMBA_Addons[Addon].Active and IMBA_Addons[Addon].RegenActivator then
						if getglobal(IMBA_Addons[Addon].RegenActivator) then
							getglobal(IMBA_Addons[Addon].RegenActivator)();
							IMBA_Addons[Addon].Running=true;
							IMBA_Addons[Addon].BossesAlive=IMBA_Addons[Addon].MultiBoss;
							IMBA_CombatCheckTime=GetTime()+10;		--Next Time to Check in Combat
							IMBA_SyncTime=GetTime()+2+2*math.random();	--We add a random delay to the variable syncing
							IMBA_AddonRunning=true;
						end
					end
				end
			elseif commandName=="VERSCHECK" then
				SendAddonMessage("IMBA", "VERSNUM "..IMBA_Version,"RAID");
			elseif commandName=="VERSNUM" then
				IMBA_RaidVersions[arg4]=params;
			end
		end
	elseif event=="PLAYER_LOGIN" then
		if IMBA_SavedVariables then
			for k2, v2 in IMBA_Addons do
				local FoundModSettings;
				FoundModSettings=false
				for k, v in IMBA_SavedVariables.Mods do		
					if k==k2 then
						v2.Active=v.Active;
						if v2.MainFrame then
							if v.Visible then
								getglobal(v2.MainFrame):Show();
							else
								getglobal(v2.MainFrame):Hide();
							end
						end
						FoundModSettings=true;
					end
				end
				if FoundModSettings==false then
					IMBA_SavedVariables.Mods[k2]={};
					IMBA_SavedVariables.Mods[k2].Visible=false;
					getglobal(v2.MainFrame):Hide();
					IMBA_SavedVariables.Mods[k2].Active=true;
				end
			end			
		else
			IMBA_SavedVariables={};
			IMBA_SavedVariables.Mods={};
			for k, v in IMBA_Addons do
				IMBA_SavedVariables.Mods[k]={};
				IMBA_SavedVariables.Mods[k].Visible=false;
				getglobal(v.MainFrame):Hide();
				IMBA_SavedVariables.Mods[k].Active=true;
			end
		end

		if IMBA_SavedVariables.Scale==nil then
			IMBA_SavedVariables.Scale=1;
		end
			
		if IMBA_SavedVariables.BarTextureNum==nil then
			IMBA_SavedVariables.BarTextureNum=1;
		end

		if IMBA_SavedVariables.FrameType==nil then
			IMBA_SavedVariables.FrameType=1;
		end
		IMBA_LoadColors();
		IMBA_SetBackdrops(IMBA_SavedVariables.FrameType);

		IMBA_SetScale(true);
		IMBA_Options_GraphicsFrame_Slider_Scale:SetValue(IMBA_SavedVariables.Scale);
		IMBA_Options_GraphicsFrame_Slider_ScaleText:SetText(string.format("Window Scale Size : %.2f",IMBA_SavedVariables.Scale));

		IMBA_SetScaleAlert(true);			
		IMBA_Options_GraphicsFrame_Slider_ScaleAlert:SetValue(IMBA_SavedVariables.ScaleAlert);
		IMBA_Alert1:SetText("",0);
		IMBA_Alert2:SetText("",0);
		IMBA_Alert3:SetText("",0);

		if IMBA_SavedVariables.ButtonPos==nil then
			IMBA_SavedVariables.ButtonPos=300;
		end
		IMBA_Options_GraphicsFrame_Slider_Icon:SetValue(IMBA_SavedVariables.ButtonPos);
		IMBA_Options_GraphicsFrame_Slider_IconText:SetText(string.format("Minimap Icon Position : %.0f",IMBA_SavedVariables.ButtonPos));

		if IMBA_SavedVariables.LockedWindows then
			IMBA_LockWindows();
		else
			IMBA_UnlockWindows()
		end
	
		if IMBA_SavedVariables.HideClose==nil then
			IMBA_SavedVariables.HideClose=false;
		end

		if IMBA_SavedVariables.HideClose then
			IMBA_HideCloseButtons()
		else
			IMBA_ShowCloseButtons()
		end
		if IMBA_SavedVariables.HideMinimapIcon then
			IMBA_OptionsButton:Hide();
		else
			IMBA_OptionsButton:Show();
		end

		if IMBA_SavedVariables.ShowAlertWindow then
			IMBA_Alerts.isLocked=false;	
			IMBA_Alerts:EnableMouse(true);
			IMBA_Alerts:SetMovable(true);
			IMBA_Alerts:SetBackdropBorderColor(IMBA_SavedVariables.Colors["FrameBorder"].r,IMBA_SavedVariables.Colors["FrameBorder"].g,IMBA_SavedVariables.Colors["FrameBorder"].b,IMBA_SavedVariables.Colors["FrameBorder"].a);	
			IMBA_Alerts:SetBackdropColor(IMBA_SavedVariables.Colors["FrameBG"].r,IMBA_SavedVariables.Colors["FrameBG"].g,IMBA_SavedVariables.Colors["FrameBG"].b,IMBA_SavedVariables.Colors["FrameBG"].a);	
		else
			IMBA_Alerts.isLocked=true;
			IMBA_Alerts:EnableMouse(false);
			IMBA_Alerts:SetMovable(false);
			IMBA_Alerts:SetBackdropBorderColor(IMBA_SavedVariables.Colors["FrameBorder"].r,IMBA_SavedVariables.Colors["FrameBorder"].g,IMBA_SavedVariables.Colors["FrameBorder"].b,0);	
			IMBA_Alerts:SetBackdropColor(IMBA_SavedVariables.Colors["FrameBG"].r,IMBA_SavedVariables.Colors["FrameBG"].g,IMBA_SavedVariables.Colors["FrameBG"].b,0);	
		end

		IMBA_CheckVisibility=GetTime()+2.5;

		if not IMBA_SavedVariables.CombatLogDist then
			IMBA_SavedVariables.CombatLogDist=200;
		end
		IMBA_Options_GraphicsFrame_Slider_CombatLogDist:SetValue(IMBA_SavedVariables.CombatLogDist);
		IMBA_Options_GraphicsFrame_Slider_CombatLogDistText:SetText(string.format("Combat Log Distance : %.0f",IMBA_SavedVariables.CombatLogDist));
		
		IMBA_SetLogDistance(IMBA_SavedVariables.CombatLogDist);

		if not SCT_MSG_FRAME then
			IMBA_Options_GraphicsFrame_UseSCTForAlerts:Hide();
		end
		if IMBA_SavedVariables.UseSCTForAlerts then
			IMBA_Options_GraphicsFrame_UseSCTForAlerts:SetChecked(IMBA_SavedVariables.UseSCTForAlerts)
		end

		IMBA_Loaded = true;
	elseif event=="CHAT_MSG_COMBAT_HOSTILE_DEATH" then
		local _,_, MobName = string.find(arg1,IMBA_DEATH_MSG);

		if MobName then
			for k, v in IMBA_Addons do
				if getglobal(v.MainFrame):IsShown() then						
					if not (v.MultiBoss>0) then
						if k==MobName then
							getglobal(v.MainFrame):Hide();
							v.Running=false;
						end
					else
						for i=1,v.MultiBoss do
							if MobName==v.BossNames[i] then
								v.BossesAlive=v.BossesAlive-1;
								if v.BossesAlive<=0 then
									getglobal(v.MainFrame):Hide();
									v.Running=false;
								end
							end
						end
					end
				end
			end
		end
	end
end

function IMBA_Command(msg)
	msg=strlower(msg);
	if msg=="lock" then
		IMBA_LockWindows();
	elseif msg=="unlock" then
		IMBA_UnlockWindows();
	elseif msg=="options" then
		IMBA_Options:Show();
	elseif msg=="minimap" then
		if IMBA_SavedVariables.HideMinimapIcon then
			IMBA_SavedVariables.HideMinimapIcon=false;
			IMBA_OptionsButton:Show();
		else
			IMBA_SavedVariables.HideMinimapIcon=true;
			IMBA_OptionsButton:Hide();
		end
		IMBA_Options_GraphicsFrame_HideMinimapIcon:SetChecked(IMBA_SavedVariables.HideMinimapIcon)
	else
		DEFAULT_CHAT_FRAME:AddMessage("IMBA Commands "..IMBA_Version, 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage(" lock - Locks all windows", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage(" minimap - Toggles Minimap Icon", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage(" options - Shows the options window", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage(" unlock - Unlocks all windows", 1.0, 1.0, 0.0);		
	end
	
end

function IMBA_SetScale(loading)
	for k, v in IMBA_Addons do
		if v.MainFrame then
			if getglobal(v.MainFrame) then
				if not loading then
					local pointNum=getglobal(v.MainFrame):GetNumPoints()
					local curScale=getglobal(v.MainFrame):GetScale();
					local pointsCleared=false
					local points={}
					for i=1,pointNum,1 do
						points[i]={};
						points[i][1], points[i][2], points[i][3], points[i][4], points[i][5]=getglobal(v.MainFrame):GetPoint(i)
						points[i][4]=points[i][4]*curScale/IMBA_SavedVariables.Scale;
						points[i][5]=points[i][5]*curScale/IMBA_SavedVariables.Scale;
					end
					pointsCleared=false
					for i=1,pointNum,1 do
						if points[i][1] and points[i][2] and points[i][3] and points[i][4] and points[i][5] then
							if not pointsCleared then
								getglobal(v.MainFrame):ClearAllPoints()
								pointsCleared=true;
							end
							getglobal(v.MainFrame):SetPoint(points[i][1],UIParent,points[i][3],points[i][4],points[i][5]);
						end
					end
				end
				getglobal(v.MainFrame):SetScale(IMBA_SavedVariables.Scale);
			end
		end
	end
end

function IMBA_LockWindows()
	for k, v in IMBA_Addons do
		if v.MainFrame then
			getglobal(v.MainFrame).isLocked=true;
		end
	end
	IMBA_SavedVariables.LockedWindows=true;
	DEFAULT_CHAT_FRAME:AddMessage("IMBA - Windows Locked", 1.0, 1.0, 0.0);
end
function IMBA_UnlockWindows()
	for k, v in IMBA_Addons do
		if v.MainFrame then
			getglobal(v.MainFrame).isLocked=false;
		end
	end
	IMBA_SavedVariables.LockedWindows=false;
	DEFAULT_CHAT_FRAME:AddMessage("IMBA - Windows Unlocked", 1.0, 1.0, 0.0);
end

function IMBA_RegisterEvents()
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	this:RegisterEvent("PLAYER_LOGIN");
end

function IMBA_UnregisterEvents()
	this:UnregisterEvent("CHAT_MSG_MONSTER_YELL");
	this:UnregisterEvent("PLAYER_REGEN_DISABLED");
	this:UnregisterEvent("CHAT_MSG_ADDON");
	this:UnregisterEvent("PLAYER_LOGIN");
	this:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
end

function IMBA_CloseAllWindows()
	for k, v in IMBA_Addons do
		if v.MainFrame then
			getglobal(v.MainFrame):Hide();
		end
	end
end

function IMBA_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage("IMBA (IMPervious Boss Addons) "..IMBA_Version.." is Loading", 1.0, 1.0, 0.0);
	
	
	IMBA_LoadColors();
	IMBA_RegisterEvents();


	--Register the slash commands
	SLASH_IMBA1= IMBA_SLASH_COMMAND;
	SlashCmdList["IMBA"] = function(msg)
		IMBA_Command(msg);
	end


	IMBA_AddonRunning=false;	--To check if an addon is currently doing something
	IMBA_CombatCheckTime=0;		--Last time checked if still in combat
	IMBA_SyncTime=0;		--Last Time synced
	IMBA_CheckVisibility=GetTime()+1000000000;	--Don't want it to start checking till variables are loaded
	IMBA_SavedVariables.Mods={};

	DEFAULT_CHAT_FRAME:AddMessage(" Access the command via /imba", 1.0, 1.0, 0.0);
end


