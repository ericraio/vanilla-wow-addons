function DUF_Initialize()
	if (DUF_INITIALIZED) then return; end

	if (DUF_DL_VERSION > DL_VERSION) then
		DL_Debug("** You need to install the latest version of the Discord Library for this mod to work right.  It should be included in the same .zip file from which you extracted this mod. **");
		return;
	end

	if (not DUF_Settings) then
		DUF_Settings = {};
	elseif (not DUF_Settings["INITIALIZED2.3"]) then
		for index in DUF_Settings do
			if (index ~= "SavedSettings") then
				DUF_Settings[index] = nil;
			end
		end
		for profile in DUF_Settings.SavedSettings do
			DUF_Settings[profile] = {};
			DL_Copy_Table(DUF_Settings.SavedSettings[profile], DUF_Settings[profile]);
		end
		DUF_Settings.SavedSettings = nil;
	end
	DUF_Settings["INITIALIZED2.3"] = 1;

	DUF_PLAYER_INDEX = UnitName("player").." :: "..GetCVar("realmName");
	DUF_INDEX = DUF_Settings[DUF_PLAYER_INDEX];

	if (not DUF_INDEX) then
		DUF_INDEX = DUF_TEXT.Default;
		DUF_Settings[DUF_PLAYER_INDEX] = DUF_INDEX;
	end

	if (not DUF_Settings[DUF_INDEX]) then
		DUF_Options_LoadDefaultSettings(1);
	end

	if (DUF_CUSTOM_SETTINGS) then
		DUF_Settings.Custom = {};
		DL_Copy_Table(DUF_CUSTOM_SETTINGS, DUF_Settings.Custom);
		DUF_CUSTOM_SETTINGS = nil;
	end

	DUF_Initialize_NewSettings();
	DUF_Settings.CharacterSettings = nil;
	DUF_INITIALIZED = true;
	DUF_SetDefaultUIHooks();
	DUF_Initialize_AllFrames();
	DUF_Main_UpdatePartyMembers();
	DUF_Main_OnEvent("UNIT_PET");
	DUF_XPBar_Update();
	DUF_PetXPBar_Update();
	DUF_HonorBar_Update();

	if (MI2_MobHealthFrame) then
		MI2_MobHealthFrame:Hide();
	end
end

function DUF_Initialize_NewSettings()
	if (not DUF_Settings[DUF_INDEX]["INITIALIZED2.0"]) then
		DUF_Settings[DUF_INDEX].target.ComboPoints.xoffset = DUF_Settings[DUF_INDEX].ComboOffset.x;
		DUF_Settings[DUF_INDEX].target.ComboPoints.yoffset = DUF_Settings[DUF_INDEX].ComboOffset.y;
		DUF_Settings[DUF_INDEX].ComboOffset.y = nil;
		DUF_Settings[DUF_INDEX].ComboOffset.x = nil;
		DUF_Settings[DUF_INDEX].optionscale = 1;
		DUF_Settings[DUF_INDEX].updatespeed = 1 / 30;
		DUF_Settings[DUF_INDEX].updatespeedbase = 30;
		DUF_Settings[DUF_INDEX].flashthreshold = .1;
		DUF_Settings[DUF_INDEX].healththreshold1 = .6;
		DUF_Settings[DUF_INDEX].healththreshold2 = .3;
		DUF_Settings[DUF_INDEX].healthcolor1 = { r=1, g=1, b=0 };
		DUF_Settings[DUF_INDEX].healthcolor2 = { r=1, g=0, b=0 };
		DUF_Settings[DUF_INDEX].manathreshold1 = .6;
		DUF_Settings[DUF_INDEX].manathreshold2 = .3;
		DUF_Settings[DUF_INDEX].manacolor1 = { r=1, g=1, b=0 };
		DUF_Settings[DUF_INDEX].manacolor2 = { r=1, g=0, b=0 };
		DUF_Settings[DUF_INDEX].targettarget = {};
		DL_Copy_Table(DUF_Settings[DUF_INDEX].target, DUF_Settings[DUF_INDEX].targettarget);
		DUF_Settings[DUF_INDEX].targettarget.hide = true;
		DUF_Settings[DUF_INDEX].targettarget.ComboPoints = nil;
		DUF_Settings[DUF_INDEX].pet.StatusBar[3] = {};
		DL_Copy_Table(DUF_Settings[DUF_INDEX].player.StatusBar[3], DUF_Settings[DUF_INDEX].pet.StatusBar[3]);
		DUF_Settings[DUF_INDEX].pet.StatusBar[3].hide = true;
		DUF_Settings[DUF_INDEX].player.StatusBar[6] = {};
		DL_Copy_Table(DUF_Settings[DUF_INDEX].player.StatusBar[3], DUF_Settings[DUF_INDEX].player.StatusBar[6]);
		DUF_Settings[DUF_INDEX].player.StatusBar[6].hide = true;
		for _,unit in DUF_FRAME_INDICES do
			DUF_Settings[DUF_INDEX][unit].RaceIcon = {};
			DL_Copy_Table(DUF_Settings[DUF_INDEX][unit].ClassIcon, DUF_Settings[DUF_INDEX][unit].RaceIcon);
			DUF_Settings[DUF_INDEX][unit].RaceIcon.hide = true;
			DUF_Settings[DUF_INDEX][unit].RankIcon = {};
			DL_Copy_Table(DUF_Settings[DUF_INDEX][unit].ClassIcon, DUF_Settings[DUF_INDEX][unit].RankIcon);
			DUF_Settings[DUF_INDEX][unit].RankIcon.hide = true;
			DUF_Settings[DUF_INDEX][unit].backgroundstyle = 2;
			DUF_Settings[DUF_INDEX][unit].bgalpha = 1;
			DUF_Settings[DUF_INDEX][unit].bgcolor.a = nil;
			DUF_Settings[DUF_INDEX][unit].bordercolor.a = nil;
			DUF_Settings[DUF_INDEX][unit].bgpadding = 5;
			DUF_Settings[DUF_INDEX][unit].Buffs.spacing = 0;
			DUF_Settings[DUF_INDEX][unit].Debuffs.spacing = 0;
			DUF_Settings[DUF_INDEX][unit].Buffs.bordercolor = {r=1, g=1, b=1};
			DUF_Settings[DUF_INDEX][unit].Debuffs.bordercolor = {r=1, g=1, b=1};
			if (DUF_Settings[DUF_INDEX][unit].context == "Reaction") then
				DUF_Settings[DUF_INDEX][unit].context = 2;
			elseif (DUF_Settings[DUF_INDEX][unit].context == "Difficulty") then
				DUF_Settings[DUF_INDEX][unit].context = 1;
			elseif (DUF_Settings[DUF_INDEX][unit].context == "Class") then
				DUF_Settings[DUF_INDEX][unit].context = 3;
			else
				DUF_Settings[DUF_INDEX][unit].context = nil;
			end
			if (DUF_Settings[DUF_INDEX][unit].recolor) then
				DUF_Settings[DUF_INDEX][unit].bgcontext = 4;
			end
			DUF_Settings[DUF_INDEX][unit].StatusBar[4] = {};
			DUF_Settings[DUF_INDEX][unit].StatusBar[5] = {};
			DL_Copy_Table(DUF_Settings[DUF_INDEX][unit].StatusBar[1], DUF_Settings[DUF_INDEX][unit].StatusBar[4]);
			DL_Copy_Table(DUF_Settings[DUF_INDEX][unit].StatusBar[2], DUF_Settings[DUF_INDEX][unit].StatusBar[5]);
			DUF_Settings[DUF_INDEX][unit].StatusBar[4].hide = true;
			DUF_Settings[DUF_INDEX][unit].StatusBar[5].hide = true;
			DUF_Settings[DUF_INDEX][unit].leftclick = 1;
			DUF_Settings[DUF_INDEX][unit].rightclick = 3;
			DUF_Settings[DUF_INDEX][unit].middleclick = 2;
			DUF_Settings[DUF_INDEX][unit].connectmethod = 1;
			DUF_Settings[DUF_INDEX][unit].spacing = 0;
			for _,element in DUF_ELEMENT_INDICES do
				if (element == "TextBox") then
					for i=1,10 do
						DUF_Settings[DUF_INDEX][unit][element][i].backgroundstyle = 1;
						DUF_Settings[DUF_INDEX][unit][element][i].bgalpha = 1;
						if (not DUF_Settings[DUF_INDEX][unit][element][i].borderalpha) then
							DUF_Settings[DUF_INDEX][unit][element][i].borderalpha = 1;
						end
						DUF_Settings[DUF_INDEX][unit][element][i].bgcolor.a = nil;
						DUF_Settings[DUF_INDEX][unit][element][i].bordercolor.a = nil;
						DUF_Settings[DUF_INDEX][unit][element][i].bgpadding = 1;
						DUF_Settings[DUF_INDEX][unit][element][i].font = 1;
						DUF_Settings[DUF_INDEX][unit][element][i].justifyV = "CENTER";
						if (not DUF_Settings[DUF_INDEX][unit][element][i].showbg) then
							DUF_Settings[DUF_INDEX][unit][element][i].hidebg = true;
						end
						DUF_Settings[DUF_INDEX][unit][element][i].showbg = nil;
						if (DUF_Settings[DUF_INDEX][unit][element][i].context == "Reaction") then
							DUF_Settings[DUF_INDEX][unit][element][i].context = 2;
						elseif (DUF_Settings[DUF_INDEX][unit][element][i].context == "Difficulty") then
							DUF_Settings[DUF_INDEX][unit][element][i].context = 1;
						elseif (DUF_Settings[DUF_INDEX][unit][element][i].context == "Class") then
							DUF_Settings[DUF_INDEX][unit][element][i].context = 3;
						else
							DUF_Settings[DUF_INDEX][unit].context = nil;
						end
						if (not DUF_Settings[DUF_INDEX][unit][element][i].mouseovercolor) then
							DUF_Settings[DUF_INDEX][unit][element][i].mouseovercolor = {r=1, g=1, b=0};
						end
						DUF_Settings[DUF_INDEX][unit][element][i].attach = "Unit Frame";
						DUF_Settings[DUF_INDEX][unit][element][i].attachpoint = "TOPLEFT";
						DUF_Settings[DUF_INDEX][unit][element][i].attachto = "TOPLEFT";
						DUF_Settings[DUF_INDEX][unit][element][i].leftclick = 1;
						DUF_Settings[DUF_INDEX][unit][element][i].rightclick = 3;
						DUF_Settings[DUF_INDEX][unit][element][i].middleclick = 2;
					end
				elseif (element == "StatusBar") then
					for i=1,6 do
						if (DUF_Settings[DUF_INDEX][unit][element][i]) then
							DUF_Settings[DUF_INDEX][unit][element][i].backgroundstyle = 1;
							DUF_Settings[DUF_INDEX][unit][element][i].bgalpha = 1;
							DUF_Settings[DUF_INDEX][unit][element][i].bgcolor.a = nil;
							DUF_Settings[DUF_INDEX][unit][element][i].bordercolor.a = nil;
							DUF_Settings[DUF_INDEX][unit][element][i].bgpadding = 1;
							DUF_Settings[DUF_INDEX][unit][element][i].color2 = {r=1, g=1, b=0};
							DUF_Settings[DUF_INDEX][unit][element][i].attach = "Unit Frame";
							DUF_Settings[DUF_INDEX][unit][element][i].attachpoint = "TOPLEFT";
							DUF_Settings[DUF_INDEX][unit][element][i].attachto = "TOPLEFT";
							DUF_Settings[DUF_INDEX][unit][element][i].leftclick = 1;
							DUF_Settings[DUF_INDEX][unit][element][i].rightclick = 3;
							DUF_Settings[DUF_INDEX][unit][element][i].middleclick = 2;
							if (not DUF_Settings[DUF_INDEX][unit][element][i].mouseovercolor) then
								DUF_Settings[DUF_INDEX][unit][element][i].mouseovercolor = {r=1, g=1, b=0};
							end
							if (DUF_Settings[DUF_INDEX][unit][element][i].recolor) then
								if (i==1) then
									DUF_Settings[DUF_INDEX][unit][element][i].context = 4;
								else
									DUF_Settings[DUF_INDEX][unit][element][i].context = 5;
								end
								DUF_Settings[DUF_INDEX][unit][element][i].recolor = nil;
							end
						end
						if (i == 1 or i == 4) then
							DUF_Settings[DUF_INDEX][unit][element][i].context = 4;
						elseif (i == 2 or i == 5) then
							DUF_Settings[DUF_INDEX][unit][element][i].context = 5;
							DUF_Settings[DUF_INDEX][unit][element][i].hideifnomana = true;
						end
					end
				else
					DUF_Settings[DUF_INDEX][unit][element].backgroundstyle = 2;
					DUF_Settings[DUF_INDEX][unit][element].bgalpha = 1;
					DUF_Settings[DUF_INDEX][unit][element].bgcolor.a = nil;
					DUF_Settings[DUF_INDEX][unit][element].bgpadding = 5;
					DUF_Settings[DUF_INDEX][unit][element].context = nil;
					if (not DUF_Settings[DUF_INDEX][unit][element].mouseovercolor) then
						DUF_Settings[DUF_INDEX][unit][element].mouseovercolor = {r=1, g=1, b=0};
					end
					DUF_Settings[DUF_INDEX][unit][element].attach = "Unit Frame";
					DUF_Settings[DUF_INDEX][unit][element].attachpoint = "TOPLEFT";
					DUF_Settings[DUF_INDEX][unit][element].attachto = "TOPLEFT";
					DUF_Settings[DUF_INDEX][unit][element].leftclick = 1;
					DUF_Settings[DUF_INDEX][unit][element].rightclick = 3;
					DUF_Settings[DUF_INDEX][unit][element].middleclick = 2;
					if (not DUF_Settings[DUF_INDEX][unit][element].borderalpha) then
						DUF_Settings[DUF_INDEX][unit][element].borderalpha = 1;
					end
				end
			end
		end
		DUF_Settings[DUF_INDEX].target.ComboPoints.backgroundstyle = 2;
		DUF_Settings[DUF_INDEX].target.ComboPoints.bgalpha = 1;
		DUF_Settings[DUF_INDEX].target.ComboPoints.bgcolor.a = nil;
		DUF_Settings[DUF_INDEX].target.ComboPoints.bgpadding = 5;
		DUF_Settings[DUF_INDEX].target.ComboPoints.attach = "Unit Frame";
		DUF_Settings[DUF_INDEX].target.ComboPoints.attachpoint = "TOPLEFT";
		DUF_Settings[DUF_INDEX].target.ComboPoints.attachto = "TOPLEFT";
		DUF_Settings[DUF_INDEX].target.ComboPoints.mouseovercolor = { r=1, g=1, b=0 };
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.backgroundstyle = 2;
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.bgalpha = 1;
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.bgcolor.a = nil;
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.bgpadding = 5;
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.attach = "Unit Frame";
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.attachpoint = "TOPLEFT";
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.attachto = "TOPLEFT";
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.mouseovercolor = { r=1, g=1, b=0 };
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.leftclick = 1;
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.rightclick = 3;
		DUF_Settings[DUF_INDEX].pet.HappinessIcon.middleclick = 2;
		DUF_Settings[DUF_INDEX].target.EliteTexture = { size=128, alpha=1, bgcolor={0,0,0}, bordercolor={0,0,0}, mouseovercolor={1,1,0}, bgalpha=1, bgpadding=5, hidebg=true, backgroundstyle=2, borderalpha=1, xoffset=0, yoffset=0, attach="Unit Frame", attachto="TOPLEFT", attachpoint="TOPLEFT", hide=true};
	end
	DUF_Settings[DUF_INDEX].ComboOffset = nil;

	if (not DUF_Settings[DUF_INDEX]["INITIALIZED2.0f"]) then
		for _,unit in DUF_FRAME_INDICES do
			for i=1,10 do
				if (tonumber(DUF_Settings[DUF_INDEX][unit].TextBox[i].font)) then
					DUF_Settings[DUF_INDEX][unit].TextBox[i].font = "DUF_Font"..DUF_Settings[DUF_INDEX][unit].TextBox[i].font..".ttf";
				end
			end
		end
	end

	if (not DUF_Settings[DUF_INDEX]["INITIALIZED2.1"]) then
		for _,unit in DUF_FRAME_INDICES do
			DUF_Settings[DUF_INDEX][unit].Portrait.bordcolor = { r=1, g=1, b=1 };
			for _,element in DUF_ELEMENT_INDICES do
				if (element == "TextBox") then
					for i=1,10 do
						DUF_Settings[DUF_INDEX][unit][element][i].framelevel = 0;
						DUF_Settings[DUF_INDEX][unit][element][i].framestrata = "LOW";
						DUF_Settings[DUF_INDEX][unit][element][i].label = DUF_TEXT["TextBox"..i];
					end
				elseif (element == "StatusBar") then
					for i=1,6 do
						if (DUF_Settings[DUF_INDEX][unit][element][i]) then
							DUF_Settings[DUF_INDEX][unit][element][i].framelevel = 0;
							DUF_Settings[DUF_INDEX][unit][element][i].framestrata = "BACKGROUND";
						end
					end
				else
					DUF_Settings[DUF_INDEX][unit][element].framelevel = 0;
					DUF_Settings[DUF_INDEX][unit][element].framestrata = "LOW";
				end
			end
		end
	end

	if (not DUF_Settings[DUF_INDEX]["INITIALIZED2.2"]) then
		DUF_Settings[DUF_INDEX].player.Buffs.durationheight = 6;
		DUF_Settings[DUF_INDEX].player.Buffs.durationcolor = {r=1, g=1, b=1};
		DUF_Settings[DUF_INDEX].player.Buffs.durationfont = "DUF_Font1.ttf";
		DUF_Settings[DUF_INDEX].player.Buffs.durationalpha = 1;
		DUF_Settings[DUF_INDEX].player.Buffs.durationx = 0;
		DUF_Settings[DUF_INDEX].player.Buffs.durationy = -5;
		DUF_Settings[DUF_INDEX].player.Debuffs.durationheight = 6;
		DUF_Settings[DUF_INDEX].player.Debuffs.durationcolor = {r=1, g=1, b=1};
		DUF_Settings[DUF_INDEX].player.Debuffs.durationfont = "DUF_Font1.ttf";
		DUF_Settings[DUF_INDEX].player.Debuffs.durationalpha = 1;
		DUF_Settings[DUF_INDEX].player.Debuffs.durationx = 0;
		DUF_Settings[DUF_INDEX].player.Debuffs.durationy = -5;
		for i=0,3 do
			DUF_Settings[DUF_INDEX]["usefor"..i] = 1;
		end
	end
	if (not DUF_Settings[DUF_INDEX]["INITIALIZED2.2c"]) then
		for _,unit in DUF_FRAME_INDICES do
			DUF_Settings[DUF_INDEX][unit].Buffs.hspacing = DUF_Settings[DUF_INDEX][unit].Buffs.spacing;
			DUF_Settings[DUF_INDEX][unit].Buffs.vspacing = DUF_Settings[DUF_INDEX][unit].Buffs.spacing;
			DUF_Settings[DUF_INDEX][unit].Debuffs.hspacing = DUF_Settings[DUF_INDEX][unit].Debuffs.spacing;
			DUF_Settings[DUF_INDEX][unit].Debuffs.vspacing = DUF_Settings[DUF_INDEX][unit].Debuffs.spacing;
		end
	end
	if (not DUF_Settings[DUF_INDEX]["INITIALIZED2.3s"]) then
		for _,unit in DUF_FRAME_INDICES do
			for i=1,6 do
				if (DUF_Settings[DUF_INDEX][unit].StatusBar[i]) then
					DUF_Settings[DUF_INDEX][unit].StatusBar[i].direction = 1;
				end
			end
		end
	end

	DUF_Settings[DUF_INDEX]["INITIALIZED2.3s"] = true;
	DUF_Settings[DUF_INDEX]["INITIALIZED2.2c"] = true;
	DUF_Settings[DUF_INDEX]["INITIALIZED2.2"] = true;
	DUF_Settings[DUF_INDEX]["INITIALIZED2.1"] = true;
	DUF_Settings[DUF_INDEX]["INITIALIZED2.0f"] = true;
	DUF_Settings[DUF_INDEX]["INITIALIZED2.0"] = true;
end

function DUF_Initialize_AllFrames(debug)
	local unitFrame;
	for unit in DUF_FRAME_DATA do
		DUF_Initialize_Frame(unit);
		DUF_Initialize_Portrait(unit);
		DUF_Initialize_ClassIcon(unit);
		DUF_Initialize_RaceIcon(unit);
		DUF_Initialize_RankIcon(unit);
		for i=1,6 do
			DUF_Initialize_StatusBar(unit, i, debug);
		end
		for i=1,10 do
			DUF_Initialize_TextBox(unit, i);
		end
		DUF_Initialize_PVPIcon(unit);
		DUF_Initialize_StatusIcon(unit);
		DUF_Initialize_LootIcon(unit);
		DUF_Initialize_LeaderIcon(unit);
		DUF_Initialize_Buffs(unit);
		DUF_Initialize_Debuffs(unit);
	end
	DUF_Initialize_ComboPoints();
	DUF_Initialize_HappinessIcon();
	DUF_Initialize_EliteTexture();
	if (DUF_Options) then
		DUF_Options_SetScale();
		DUF_Init_ContextColors();
		DUF_Init_MiscOptions();
	end	
	DUF_Options_SetUpdateSpeed();
	DUF_Toggle_DefaultFrames();
	DUF_PlayerFrame:Hide();
	if (not DUF_Settings[DUF_INDEX].player.hide) then
		DUF_PlayerFrame:Show();
	end
	for i=1,16 do
		getglobal("DUF_PlayerFrame_Buffs_"..i).playerbuff = true;
		getglobal("DUF_PlayerFrame_Debuffs_"..i).playerbuff = true;
	end
	if (DUF_Settings[DUF_INDEX].hidebuffframe) then
		BuffFrame:Hide();
		BuffFrame.origShow = BuffFrame.Show;
		BuffFrame.Show = function() end;
	elseif (BuffFrame.origShow) then
		BuffFrame.Show = BuffFrame.origShow;
		BuffFrame.origShow = nil;
		BuffFrame:Show();
	end
end

function DUF_Initialize_BaseSettings(frame, settings, debug)
	local framename = frame:GetName();

	local bgframe = getglobal(framename.."_Background");
	local bgtexture = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop";
	if (settings.bgtexture and settings.bgtexture ~= "") then
		bgtexture = "Interface\\AddOns\\DiscordUnitFrames\\CustomTextures\\"..settings.bgtexture;
	end
	if (settings.backgroundstyle == 1) then
		bgframe:SetBackdrop({bgFile = bgtexture, edgeFile = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop", tile = nil, tileSize = 1, edgeSize = 1, insets = { left = 1, right = 1, top = 1, bottom = 1 }});
	elseif (settings.backgroundstyle == 2) then
		bgframe:SetBackdrop({bgFile = bgtexture, edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = nil, tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }});
	elseif (settings.backgroundstyle == 3) then
		bgframe:SetBackdrop({bgFile = bgtexture, edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = nil, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 }});
	elseif (settings.backgroundstyle == 4) then
		bgframe:SetBackdrop({bgFile = bgtexture, edgeFile = "Interface\\Buttons\\UI-SliderBar-Border", tile = nil, tileSize = 8, edgeSize = 8, insets = { left = 3, right = 3, top = 6, bottom = 6 }});
	end
	bgframe:SetBackdropColor(settings.bgcolor.r, settings.bgcolor.g, settings.bgcolor.b, settings.bgalpha);
	bgframe:SetBackdropBorderColor(settings.bordercolor.r, settings.bordercolor.g, settings.bordercolor.b, settings.borderalpha);
	if (settings.hidebg) then
		bgframe:Hide();
	else
		bgframe:Show();
	end

	frame:ClearAllPoints();
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0);

	if (settings.framelevel and settings.framestrata) then
		frame:SetFrameStrata(settings.framestrata);
		local framelevel = frame.baseframelevel + settings.framelevel;
		if (framelevel < 0) then framelevel = 0; end
		frame:SetFrameLevel(framelevel);
	end
	bgframe:SetFrameStrata("BACKGROUND");

	local height, width;
	if (settings.size) then
		height = settings.size;
		width = settings.size;
	else
		height = settings.height;
		width = settings.width;
	end
	if (frame.dynamicsize) then
		height = height * frame.dynamicsize;
		width = width * frame.dynamicsize;
	end

	frame:SetWidth(width);
	frame:SetHeight(height);
	frame:SetAlpha(settings.alpha);
	bgframe:SetWidth(width + settings.bgpadding * 2);
	bgframe:SetHeight(height + settings.bgpadding * 2);

	if (settings.hide or settings.mouseover) then
		frame:Hide();
	else
		frame:Show();
	end
	frame.flashing = nil;

	if (settings.disablemouse) then
		frame:EnableMouse(false);
	else
		frame:EnableMouse(1);
	end
end

function DUF_Initialize_Buffs(unit)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_Buffs");
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Buffs;

	DUF_Initialize_Element(unit, frame, settings);

	if (settings.reverse) then
		local button = getglobal(frame:GetName().."_16");
		local buttontexture = getglobal(frame:GetName().."_16_Texture");
		button:ClearAllPoints();
		button:SetPoint("BOTTOMRIGHT", frame:GetName(), "BOTTOMRIGHT", 0, 0);
		button:SetFrameLevel(frame:GetFrameLevel() + 1);
		button:SetWidth(settings.size);
		button:SetHeight(settings.size);
		buttontexture:SetWidth(settings.size);
		buttontexture:SetHeight(settings.size);
		local prevname;
		for i=15, 1, -1 do
			prevname = frame:GetName().."_"..(i+1);
			button = getglobal(frame:GetName().."_"..i);
			buttontexture = getglobal(frame:GetName().."_"..i.."_Texture");
			button:ClearAllPoints();
			if (settings.vertical) then
				button:SetPoint("BOTTOM", prevname, "TOP", 0, settings.vspacing);
			else
				button:SetPoint("RIGHT", prevname, "LEFT", -settings.hspacing, 0);
			end
			button:SetFrameLevel(frame:GetFrameLevel() + (17 - i));
			button:SetWidth(settings.size);
			button:SetHeight(settings.size);
			buttontexture:SetWidth(settings.size);
			buttontexture:SetHeight(settings.size);
		end
	else
		local button = getglobal(frame:GetName().."_1");
		local buttontexture = getglobal(frame:GetName().."_1_Texture");
		button:ClearAllPoints();
		button:SetPoint("TOPLEFT", frame:GetName(), "TOPLEFT", 0, 0);
		button:SetFrameLevel(frame:GetFrameLevel() + 1);
		button:SetWidth(settings.size);
		button:SetHeight(settings.size);
		buttontexture:SetWidth(settings.size);
		buttontexture:SetHeight(settings.size);
		local prevname;
		for i=2,16 do
			prevname = frame:GetName().."_"..(i-1);
			button = getglobal(frame:GetName().."_"..i);
			buttontexture = getglobal(frame:GetName().."_"..i.."_Texture");
			button:ClearAllPoints();
			if (settings.vertical) then
				button:SetPoint("TOP", prevname, "BOTTOM", 0, -settings.vspacing);
			else
				button:SetPoint("LEFT", prevname, "RIGHT", settings.hspacing, 0);
			end
			button:SetFrameLevel(frame:GetFrameLevel() + i);
			button:SetWidth(settings.size);
			button:SetHeight(settings.size);
			buttontexture:SetWidth(settings.size);
			buttontexture:SetHeight(settings.size);
		end
	end
	if (settings.tworows) then
		local row2start = math.ceil(settings.shown / 2) + 1;
		if (settings.reverse) then
			row2start = 16 - row2start + 1;
		end
		button = getglobal(frame:GetName().."_"..row2start);
		button:ClearAllPoints();
		if (settings.vertical) then
			if (settings.reverse) then
				button:SetPoint("RIGHT", frame:GetName().."_16", "LEFT", -settings.hspacing, 0);
			else
				button:SetPoint("LEFT", frame:GetName().."_1", "RIGHT", settings.hspacing, 0);
			end
		else
			if (settings.reverse) then
				button:SetPoint("BOTTOM", frame:GetName().."_16", "TOP", 0, settings.vspacing);
			else
				button:SetPoint("TOP", frame:GetName().."_1", "BOTTOM", 0, -settings.vspacing);
			end
		end
	end

	local stacksize = 9 * settings.size / 15;
	for i=1,16 do
		local button = getglobal(frame:GetName().."_"..i);
		local stack = getglobal(button:GetName().."_Stack");
		local scale = button:GetScale();
		stack:SetFont("Interface\\AddOns\\DiscordUnitFrames\\CustomFonts\\DUF_Font1.ttf", stacksize, "outline='THICK'");
		button:SetScale(scale + 1);
		button:SetScale(scale);
	end

	if (unit == "player") then
		for i=1,16 do
			local button = getglobal("DUF_PlayerFrame_Buffs_"..i);
			local duration = getglobal("DUF_PlayerFrame_Buffs_"..i.."_Text");
			duration:SetFont("Interface\\AddOns\\DiscordUnitFrames\\CustomFonts\\"..settings.durationfont, settings.durationheight);
			duration:SetTextColor(settings.durationcolor.r, settings.durationcolor.g, settings.durationcolor.b, settings.durationalpha);
			local scale = button:GetScale();
			button:SetScale(scale + 1);
			button:SetScale(scale);
			duration:ClearAllPoints();
			duration:SetPoint("TOP", button, "BOTTOM", settings.durationx, settings.durationy);
			if (settings.showduration) then
				duration:Show();
			else
				duration:Hide();
			end
			button.playerbuff = 1
		end
	end

	DUF_UnitFrame_UpdateBuffs(unit);
end

function DUF_Initialize_ClassIcon(unit)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_ClassIcon");
	local texture = getglobal(DUF_FRAME_DATA[unit].frame.."_ClassIcon_Texture");
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].ClassIcon;

	DUF_Initialize_Element(unit, frame, settings);

	texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
	DUF_Set_ClassIcon(unit);
end

function DUF_Initialize_ComboPoints()
	local settings = DUF_Settings[DUF_INDEX].target.ComboPoints;

	DUF_Initialize_Element("target", DUF_TargetFrame_ComboPoints, settings);

	local combopoint
	for i=1, 5 do
		combopoint = getglobal("DUF_TargetFrame_ComboPoints_"..i);
		combopoint:SetHeight(settings.size);
		combopoint:SetWidth(settings.size);
		getglobal("DUF_TargetFrame_ComboPoints_"..i.."_Texture"):SetVertexColor(settings.color.r, settings.color.g, settings.color.b);
		combopoint:ClearAllPoints();
		if (i > 1) then
			local prev = "DUF_TargetFrame_ComboPoints_"..(i - 1);
			if (settings.vertical) then
				combopoint:SetPoint("TOP", prev, "BOTTOM", 0, -settings.spacing);
			else
				combopoint:SetPoint("LEFT", prev, "RIGHT", settings.spacing, 0);
			end
		else
			combopoint:SetPoint("TOPLEFT", "DUF_TargetFrame_ComboPoints", "TOPLEFT", 0, 0);
		end
		local cptexture = getglobal("DUF_TargetFrame_ComboPoints_"..i.."_Texture");
		if (settings.customtexture and settings.customtexture ~= "") then
			cptexture:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\CustomTextures\\"..settings.customtexture);
			cptexture:SetTexCoord(0, 1, 0, 1);
		else
			cptexture:SetTexture("Interface\\ComboFrame\\ComboPoint");
			cptexture:SetTexCoord(0, .375, 0, .8);
		end
	end
	DUF_ComboPoints_Update();
end

function DUF_Initialize_Debuffs(unit)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_Debuffs");
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Debuffs;

	DUF_Initialize_Element(unit, frame, settings);

	if (settings.reverse) then
		local button = getglobal(frame:GetName().."_16");
		local buttontex = getglobal(frame:GetName().."_16_Texture");
		button:ClearAllPoints();
		button:SetPoint("BOTTOMRIGHT", frame:GetName(), "BOTTOMRIGHT", 0, 0);
		button:SetFrameLevel(frame:GetFrameLevel() + 1);
		button:SetWidth(settings.size);
		button:SetHeight(settings.size);
		buttontex:SetWidth(settings.size);
		buttontex:SetHeight(settings.size);
		local prevname;
		for i=15, 1, -1 do
			prevname = frame:GetName().."_"..(i+1);
			button = getglobal(frame:GetName().."_"..i);
			buttontex = getglobal(frame:GetName().."_"..i.."_Texture");
			button:ClearAllPoints();
			if (settings.vertical) then
				button:SetPoint("BOTTOM", prevname, "TOP", 0, settings.vspacing);
			else
				button:SetPoint("RIGHT", prevname, "LEFT", -settings.hspacing, 0);
			end
			button:SetFrameLevel(frame:GetFrameLevel() + (17 - i));
			button:SetWidth(settings.size);
			button:SetHeight(settings.size);
			buttontex:SetWidth(settings.size);
			buttontex:SetHeight(settings.size);
		end
	else
		local button = getglobal(frame:GetName().."_1");
		local buttontex = getglobal(frame:GetName().."_1_Texture");
		button:ClearAllPoints();
		button:SetPoint("TOPLEFT", frame:GetName(), "TOPLEFT", 0, 0);
		button:SetFrameLevel(frame:GetFrameLevel() + 1);
		button:SetWidth(settings.size);
		button:SetHeight(settings.size);
		buttontex:SetWidth(settings.size);
		buttontex:SetHeight(settings.size);
		local prevname;
		for i=2,16 do
			prevname = frame:GetName().."_"..(i-1);
			button = getglobal(frame:GetName().."_"..i);
			buttontex = getglobal(frame:GetName().."_"..i.."_Texture");
			button:ClearAllPoints();
			if (settings.vertical) then
				button:SetPoint("TOP", prevname, "BOTTOM", 0, -settings.vspacing);
			else
				button:SetPoint("LEFT", prevname, "RIGHT", settings.hspacing, 0);
			end
			button:SetFrameLevel(frame:GetFrameLevel() + i);
			button:SetWidth(settings.size);
			button:SetHeight(settings.size);
			buttontex:SetWidth(settings.size);
			buttontex:SetHeight(settings.size);
		end
	end
	
	if (settings.flash) then
		for i=1,16 do
			local button = getglobal(frame:GetName().."_"..i);
			button.flashing = true;
			button.timer = .5;
			button.direction = 1;
		end
	else
		for i=1,16 do
			local button = getglobal(frame:GetName().."_"..i);
			button:SetAlpha(1);
			button.flashing = nil;
		end
	end

	if (settings.tworows) then
		local row2start = math.ceil(settings.shown / 2) + 1;
		if (settings.reverse) then
			row2start = 16 - row2start + 1;
		end
		button = getglobal(frame:GetName().."_"..row2start);
		button:ClearAllPoints();
		if (settings.vertical) then
			if (settings.reverse) then
				button:SetPoint("RIGHT", frame:GetName().."_16", "LEFT", -settings.hspacing, 0);
			else
				button:SetPoint("LEFT", frame:GetName().."_1", "RIGHT", settings.hspacing, 0);
			end
		else
			if (settings.reverse) then
				button:SetPoint("BOTTOM", frame:GetName().."_16", "TOP", 0, settings.vspacing);
			else
				button:SetPoint("TOP", frame:GetName().."_1", "BOTTOM", 0, -settings.vspacing);
			end
		end
	end

	local stacksize = 12 * settings.size / 15;
	for i=1,16 do
		local button = getglobal(frame:GetName().."_"..i);
		local stack = getglobal(button:GetName().."_Stack");
		local scale = button:GetScale();
		stack:SetFont("Interface\\AddOns\\DiscordUnitFrames\\CustomFonts\\DUF_Font1.ttf", stacksize, "outline='THICK'");
		button:SetScale(scale + 1);
		button:SetScale(scale);
	end

	if (unit == "player") then
		for i=1,16 do
			local button = getglobal("DUF_PlayerFrame_Debuffs_"..i);
			local duration = getglobal("DUF_PlayerFrame_Debuffs_"..i.."_Text");
			duration:SetFont("Interface\\AddOns\\DiscordUnitFrames\\CustomFonts\\"..settings.durationfont, settings.durationheight);
			duration:SetTextColor(settings.durationcolor.r, settings.durationcolor.g, settings.durationcolor.b, settings.durationalpha);
			local scale = button:GetScale();
			button:SetScale(scale + 1);
			button:SetScale(scale);
			duration:ClearAllPoints();
			duration:SetPoint("TOP", button, "BOTTOM", settings.durationx, settings.durationy);
			if (settings.showduration) then
				duration:Show();
			else
				duration:Hide();
			end
			button.playerbuff = 1
		end
	end

	DUF_UnitFrame_UpdateDebuffs(unit);
end

function DUF_Initialize_Element(unit, frame, settings, debug)
	DUF_Initialize_BaseSettings(frame, settings, debug);
	DUF_Set_ElementPosition(frame, DUF_FRAME_DATA[unit].frame, settings);
end

function DUF_Initialize_EliteTexture()
	local frame = DUF_TargetFrame_EliteTexture;
	local settings = DUF_Settings[DUF_INDEX].target.EliteTexture;

	DUF_Initialize_Element("target", frame, settings);

	DUF_Set_EliteTexture();
end

function DUF_Initialize_Frame(unit)
	local unitFrame = getglobal(DUF_FRAME_DATA[unit].frame);
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index];

	DUF_Initialize_BaseSettings(unitFrame, settings);

	DUF_Initialize_FrameLoc(unit)

	unitFrame:SetScale(settings.scale);
	unitFrame.scale = settings.scale;
	unitFrame.basecolor = {};
	unitFrame.basecolor.r = settings.bgcolor.r;
	unitFrame.basecolor.g = settings.bgcolor.g;
	unitFrame.basecolor.b = settings.bgcolor.b;

	if ((not UnitName(unit)) and (not UnitExists(unit)) and (not DUF_OPTIONS_VISIBLE)) then
		unitFrame:Hide();
	end
end

function DUF_Initialize_FrameLoc(unit)
	local unitFrame = getglobal(DUF_FRAME_DATA[unit].frame);
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index];

	unitFrame:ClearAllPoints();
	if (settings.connect and unitFrame:GetID() > 1) then
		if (DUF_FRAME_DATA[unit].index == "party" or DUF_FRAME_DATA[unit].index == "partypet") then
			local connectframe = "DUF_PartyFrame"..(unitFrame:GetID() - 1);
			if (DUF_FRAME_DATA[unit].index == "partypet") then
				connectframe = "DUF_PartyPetFrame"..(unitFrame:GetID() - 1);
			end
			if (settings.connectmethod == 1) then
				unitFrame:SetPoint("TOP", connectframe, "BOTTOM", 0, -settings.spacing);
			elseif (settings.connectmethod == 2) then
				unitFrame:SetPoint("BOTTOM", connectframe, "TOP", 0, settings.spacing);
			elseif (settings.connectmethod == 3) then
				unitFrame:SetPoint("LEFT", connectframe, "RIGHT", settings.spacing, 0);
			elseif (settings.connectmethod == 4) then
				unitFrame:SetPoint("RIGHT", connectframe, "LEFT", -settings.spacing, 0);
			end
		else
			unitFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", settings.xos[unitFrame:GetID()], settings.yos[unitFrame:GetID()]);
		end
	else
		unitFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", settings.xos[unitFrame:GetID()], settings.yos[unitFrame:GetID()]);
	end
end

function DUF_Initialize_HappinessIcon()
	local settings = DUF_Settings[DUF_INDEX].pet.HappinessIcon;

	DUF_Initialize_Element("pet", DUF_PetFrame_HappinessIcon, settings);
	DUF_Initialize_IconBackground(DUF_PetFrame_HappinessIcon, settings);

	DUF_PetFrame_HappinessIcon_Texture:SetTexture("Interface\\PetPaperDollFrame\\UI-PetHappiness");

	DUF_HappinessIcon_Update();
end

function DUF_Initialize_IconBackground(frame, settings)
	frame = getglobal(frame:GetName().."_Circle");
	if (settings.circle) then
		frame:Show();
	else
		frame:Hide();
		return;
	end
	local background = getglobal(frame:GetName().."_Background");
	local border = getglobal(frame:GetName().."_Border");
	background:SetVertexColor(settings.bgcolor.r, settings.bgcolor.g, settings.bgcolor.b, settings.bgalpha);
	border:SetVertexColor(settings.bordercolor.r, settings.bordercolor.g, settings.bordercolor.b, settings.borderalpha);
end

function DUF_Initialize_LeaderIcon(unit)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_LeaderIcon");
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].LeaderIcon;

	DUF_Initialize_Element(unit, frame, settings);
	DUF_Initialize_IconBackground(frame, settings);
	getglobal(DUF_FRAME_DATA[unit].frame.."_LeaderIcon_Texture"):SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon");
	DUF_LeaderIcon_Update(unit);
end

function DUF_Initialize_LootIcon(unit)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_LootIcon");
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].LootIcon;

	DUF_Initialize_Element(unit, frame, settings);
	DUF_Initialize_IconBackground(frame, settings);
	getglobal(DUF_FRAME_DATA[unit].frame.."_LootIcon_Texture"):SetTexture("Interface\\GroupFrame\\UI-Group-MasterLooter");
	DUF_LootIcon_Update(unit);
end

function DUF_Initialize_Portrait(unit)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_Portrait");
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].Portrait;

	DUF_Initialize_Element(unit, frame, settings);

	if (settings.showborder) then
		getglobal(frame:GetName().."_Border"):Show();
	else
		getglobal(frame:GetName().."_Border"):Hide();
	end
	getglobal(frame:GetName().."_Border"):SetVertexColor(settings.bordcolor.r, settings.bordcolor.g, settings.bordcolor.b);
	DUF_Set_Portrait(unit);
end

function DUF_Initialize_PVPIcon(unit)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_PVPIcon");
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].PVPIcon;

	DUF_Initialize_Element(unit, frame, settings);
	DUF_Initialize_IconBackground(frame, settings);

	getglobal(DUF_FRAME_DATA[unit].frame.."_PVPIcon_Texture"):SetTexCoord(0, .6875, 0, .625);
	DUF_PVPIcon_Update(unit);
end

function DUF_Initialize_RaceIcon(unit)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_RaceIcon");
	local texture = getglobal(DUF_FRAME_DATA[unit].frame.."_RaceIcon_Texture");
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].RaceIcon;

	DUF_Initialize_Element(unit, frame, settings);

	texture.targetIcon = nil
	if (settings.targetIcon) then
		if (frame:GetParent().targetIcon == 1) then
			frame:GetParent().targetIcon = 3
		else
			frame:GetParent().targetIcon = 2
		end
		texture.targetIcon = 1
		frame:Hide()
		frame:GetParent().targetIndex = nil
		texture:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	end

	DUF_Set_RaceIcon(unit);
end

function DUF_Initialize_RankIcon(unit)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_RankIcon");
	local texture = getglobal(DUF_FRAME_DATA[unit].frame.."_RankIcon_Texture");
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].RankIcon;

	DUF_Initialize_Element(unit, frame, settings);

	texture.targetIcon = nil
	if (settings.targetIcon) then
		if (frame:GetParent().targetIcon == 2) then
			frame:GetParent().targetIcon = 3
		else
			frame:GetParent().targetIcon = 1
		end
		texture.targetIcon = 1
		frame:Hide()
		frame:GetParent().targetIndex = nil
		texture:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	end
	

	DUF_Set_RankIcon(unit);
end

function DUF_Initialize_StatusBar(unit, bar, debug)
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].StatusBar[bar];
	local frame = getglobal(DUF_FRAME_DATA[unit].frame..DUF_STATUSBARS[bar]);
	if ((not settings) or (not frame)) then return; end
	local statusbar = getglobal(DUF_FRAME_DATA[unit].frame..DUF_STATUSBARS[bar].."_Bar");
	local statusbarbg = getglobal(DUF_FRAME_DATA[unit].frame..DUF_STATUSBARS[bar].."_Bar2");

	if (not settings.resizemax) then
		frame.dynamicsize = nil;
	end

	DUF_Initialize_Element(unit, frame, settings, debug);

	if (settings.customtexture and settings.customtexture ~= "") then
		statusbar:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\CustomTextures\\"..settings.customtexture);
	else
		statusbar:SetTexture("Interface\\TargetingFrame\\UI-StatusBar");
	end
	if (settings.customtexture2 and settings.customtexture2 ~= "") then
		statusbarbg:SetTexture("Interface\\AddOns\\DiscordUnitFrames\\CustomTextures\\"..settings.customtexture2);
	else
		statusbarbg:SetTexture("Interface\\AddOns\\DiscordLibrary\\PlainBackdrop");
	end

	statusbar:SetWidth(settings.width);
	statusbarbg:SetWidth(settings.width);
	statusbar:SetHeight(settings.height);
	statusbarbg:SetHeight(settings.height);

	statusbar:ClearAllPoints();
	statusbarbg:ClearAllPoints();
	statusbar.direction = settings.direction;
	statusbarbg.direction = settings.direction;
	if (settings.direction == 1) then
		statusbar:SetPoint("LEFT", frame, "LEFT", 0, 0);
		statusbarbg:SetPoint("LEFT", frame, "LEFT", 0, 0);
		statusbar.length = settings.width;
		statusbarbg.length = settings.width;
	elseif (settings.direction == 2) then
		statusbar:SetPoint("RIGHT", frame, "RIGHT", 0, 0);
		statusbarbg:SetPoint("RIGHT", frame, "RIGHT", 0, 0);
		statusbar.length = settings.width;
		statusbarbg.length = settings.width;
	elseif (settings.direction == 3) then
		statusbar:SetPoint("BOTTOM", frame, "BOTTOM", 0, 0);
		statusbarbg:SetPoint("BOTTOM", frame, "BOTTOM", 0, 0);
		statusbar.length = settings.height;
		statusbarbg.length = settings.height;
	else
		statusbar:SetPoint("TOP", frame, "TOP", 0, 0);
		statusbarbg:SetPoint("TOP", frame, "TOP", 0, 0);
		statusbar.length = settings.height;
		statusbarbg.length = settings.height;
	end

	if (bar ~= 2 and bar ~= 5) then
		statusbar:SetVertexColor(settings.color.r, settings.color.g, settings.color.b);
	end
	statusbarbg:SetVertexColor(settings.color2.r, settings.color2.g, settings.color2.b);

	this = getglobal(DUF_FRAME_DATA[unit].frame);
	if (bar == 1) then
		this.lasthealth = UnitHealth(unit);
		this.lasthealthalpha = 0;
		DUF_HealthBar_Update();
	elseif (bar == 2) then
		this.lastmana = UnitMana(unit);
		this.lastmanaalpha = 0;
		DUF_ManaBar_Update();
		DUF_ManaBar_UpdateType();
	elseif (bar == 3) then
		if (unit == "player") then
			DUF_XPBar_Update();
		else
			DUF_PetXPBar_Update();
		end
	elseif (bar == 4) then
		DUF_TargetHealthBar_Update();
	elseif (bar == 5) then
		DUF_TargetManaBar_Update();
		DUF_TargetManaBar_UpdateType();
	elseif (bar == 6) then
		DUF_HonorBar_Update();
	end
end

function DUF_Initialize_StatusIcon(unit)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_StatusIcon");
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].StatusIcon;

	DUF_Initialize_Element(unit, frame, settings);
	DUF_Initialize_IconBackground(frame, settings);

	DUF_StatusIcon_Update(unit);
end

function DUF_Initialize_TextBox(unit, box)
	local frame = getglobal(DUF_FRAME_DATA[unit].frame.."_TextBox_"..box);
	local settings = DUF_Settings[DUF_INDEX][DUF_FRAME_DATA[unit].index].TextBox[box];
	local textbox = getglobal(DUF_FRAME_DATA[unit].frame.."_TextBox_"..box.."_Text");

	DUF_Initialize_Element(unit, frame, settings);

	local fontFlags = "";

	if (settings.outline) then
		fontFlags = "outline='"..settings.outline.."'";
	end

	textbox:SetFont("Interface\\AddOns\\DiscordUnitFrames\\CustomFonts\\"..settings.font, settings.textheight, fontFlags);
	frame:SetScale(2);
	frame:SetScale(1);
	textbox:SetJustifyH(settings.justify);
	textbox:SetJustifyV(settings.justifyV);
	textbox:SetTextColor(settings.textcolor.r, settings.textcolor.g, settings.textcolor.b);

	for variable, value in DUF_VARIABLE_FUNCTIONS do
		for _,event in value.events do
			frame:UnregisterEvent(event);			
		end
	end
	if (settings.text and settings.text ~= "") then
		frame.variables = {};
		for variable, value in DUF_VARIABLE_FUNCTIONS do
			if (string.find(settings.text, variable)) then
				frame.variables[variable] = true;
				for _,event in value.events do
					frame:RegisterEvent(event);			
				end			
			end
			if (DUF_UNIT_CHANGED_EVENTS[frame:GetParent().unit]) then
				frame:RegisterEvent(DUF_UNIT_CHANGED_EVENTS[frame:GetParent().unit])
			end
		end
		this = frame;
		DUF_TextBox_Update();
	else
		textbox:SetText("");
		frame:Hide();
	end

	frame.checkname = nil;
	frame.checkhealth = nil;
	frame.checkmana = nil;
	frame.checkhealthmax = nil;
	frame.checkmanamax = nil;
	frame.checklevel = nil;
	frame.checktype = nil;
	frame.checkoffline = nil;
	frame.checkreaction = nil;
	frame.checkcombat = nil;
	frame.checkpetxp = nil;
	frame.checkvisibility = nil;
	frame.checkcolor = nil;
	if (string.find(settings.text, '$t')) then
		frame.checkname= true;
		if ((not UnitName(unit.."target")) and (not DUF_OPTIONS_VISIBLE)) then
			frame:Hide();
		end
	end
	if (string.find(settings.text, '$th')) then
		frame.checkhealth = true;
	end
	if (string.find(settings.text, '$tm')) then
		frame.checkmana = true;
	end
	if (string.find(settings.text, '$tx')) then
		frame.checkhealthmax = true;
	end
	if (string.find(settings.text, '$ta')) then
		frame.checkhealth = true;
		frame.checkhealthmax = true;
	end
	if (string.find(settings.text, '$tb')) then
		frame.checkmana = true;
		frame.checkmanamax = true;
	end
	if (string.find(settings.text, '$ty')) then
		frame.checkmanamax = true;
	end
	if (string.find(settings.text, '$tl')) then
		frame.checklevel = true;
	end
	if (string.find(settings.text, '$tt')) then
		frame.checktype = true;
	end
	if (string.find(settings.text, '$re')) then
		frame.checkreaction = true;
	end
	if (string.find(settings.text, '$of')) then
		frame.checkoffline = true;
	end
	if (string.find(settings.text, '$ic')) then
		frame.checkcombat = true;
	end
	if (string.find(settings.text, '$iv')) then
		frame.checkvisibility = true;
	end
	if (string.find(settings.text, '$px') or string.find(settings.text, '$py') or string.find(settings.text, '$pc') or string.find(settings.text, '$pp') or string.find(settings.text, '$pg')) then
		frame.checkpetxp = true;
	end
	if (string.find(settings.text, '$cr') or string.find(settings.text, '$cw') or string.find(settings.text, '$cm') or string.find(settings.text, '$ch') or string.find(settings.text, '$cq')) then
		frame.checkcolor = true;
	end
end

function DUF_Initialize_VariablesFrame()
	DUF_TextVariablesFrame_Title:SetText(DUF_TEXT.VariablesTitle);
	local column1, column2 = "", "";
	local count = table.getn(DUF_TEXTVARIABLES);
	local halfway = math.ceil(count / 2);
	for i=1, halfway do
		column1 = column1..DUF_TEXTVARIABLES[i].."\n";
	end
	halfway = halfway + 1
	for i = halfway, count do
		column2 = column2..DUF_TEXTVARIABLES[i].."\n";
	end
	DUF_TextVariablesFrame_Column1:SetText(column1);
	DUF_TextVariablesFrame_Column2:SetText(column2);
	DUF_TextVariablesFrame:SetWidth(DUF_TextVariablesFrame_Column1:GetWidth() + DUF_TextVariablesFrame_Column1:GetWidth() + 20);
	DUF_TextVariablesFrame:SetHeight(DUF_TextVariablesFrame_Column1:GetHeight() + 85);
end