function DFM_Add_Frame(frameName, name, header, addChildren, override, changeHeaderOrName, custom)
	local frame = getglobal(frameName);

	if (not frame) and (not custom) then
		DL_Debug("A frame named "..frameName.." does not exist.  Double-check your spelling and capitalization.");
		return;
	end

	local oldHeader;
	for h,frames in DFM_Settings[DFM_INDEX] do
		for f in frames do
			if (f == frameName) then
				if (changeHeaderOrName) then
					oldHeader = h;
					break;
				else
					DL_Error(frameName.." is already listed as "..frames[f].name.." beneath the "..h.." header.");
					return;
				end
			end
		end
	end

	if (not header) then
		header = DFM_TEXT.UserAdded;
	end
	if (not DFM_Settings[DFM_INDEX][header]) then
		DFM_Settings[DFM_INDEX][header] = {};
	end
	if (not name or name == "") then
		name = frameName;
	end

	if (oldHeader) then
		if (oldHeader == header) then
			DFM_Settings[DFM_INDEX][header][frameName].name = name;
		else
			DFM_Settings[DFM_INDEX][header][frameName] = {};
			DL_Copy_Table(DFM_Settings[DFM_INDEX][oldHeader][frameName], DFM_Settings[DFM_INDEX][header][frameName]);
			DFM_Settings[DFM_INDEX][header][frameName].name = name;
			DFM_Settings[DFM_INDEX][oldHeader][frameName] = nil;
		end
	else
		DFM_Settings[DFM_INDEX][header][frameName] = {name=name};

		if (addChildren and frame.GetChildren) then
			local children = {frame:GetChildren()};
			if (children) then
				for _, child in children do
					if (child.GetName and child:GetName()) then
						DFM_Add_Frame(child:GetName(), child:GetName(), header, 1, 1);
					end
				end
			end
		end
	end

	if (DFM_Options and (not override)) then
		if (oldHeader) then
			DFM_SELECTED_INDEX = nil;
			DFM_OPTIONS_LIST = {};
		end
		DFM_Update_FrameList();
		DFM_FrameMenu_Update();
		DFM_OptionsMenu_Update();
	end
end

function DFM_Call_Method(header, frame, method)
	if (not DFM_Settings[DFM_INDEX][header][frame][method].use) then return; end
	local param = DFM_Settings[DFM_INDEX][header][frame][method];
	local prefix = "";
	if (DFM_Settings[DFM_INDEX][header][frame][method].lock) then
		prefix = "DFM_";
	end
	method = DFM_METHODS_LIST[method].method;
	frame = getglobal(frame);
	if (string.find(method, "Color")) then
		frame[prefix..method](frame, param[1].r, param[1].g, param[1].b, param[2]);
	elseif (method == "SetBackdrop") then
		frame[prefix.."SetBackdrop"](frame, {bgFile = param[1], edgeFile = param[2], tile = param[3], tileSize = param[4], edgeSize = param[5], insets = { left = param[6], right = param[7], top = param[8], bottom = param[9] }});
	elseif (method == "SetFont") then
		local mc = "false";
		if (param[4]) then
			mc = "true";
		end
		--local flags = "outline='"..param[3].."', monochrome='"..mc.."'";
		frame[prefix.."SetFont"](frame, param[1], param[2]);
	elseif (method == "SetParent") then
		local parent = param[1];
		if (not getglobal(parent)) then
			parent = UIParent;
		end
		frame:SetParent(parent);
	elseif (method == "EnableMouse" or method == "EnableMouseWheel") then
		local value;
		if (not param[1]) then
			value = 1;
		end
		frame[prefix..method](frame, value);
	else
		frame[prefix..method](frame, param[1], param[2], param[3], param[4], param[5], param[6], param[7], param[8]);
	end
end

function DFM_CastingBarFrame_UpdatePosition()
	if (not CastingBarFrame.dfmmoved) then
		DFM_Old_CastingBarFrame_UpdatePosition();
	end
end

function DFM_Create_Profile(index)
	if (not index) then
		if (DFM_Options) then
			index = DFM_Options_NewProfile:GetText();
			if (not index or index == "") then return; end
		else
			return;
		end
	end
	if (DFM_Settings[index]) then
		DL_Error("That profile name already exists.  If you wish to overwrite it, you must first delete it.");
		return;
	end
	DFM_Settings[index] = {};
	DL_Copy_Table(DFM_Settings[DFM_INDEX], DFM_Settings[index]);
	DFM_INDEX = index;
	DFM_Settings[DFM_PROFILE_INDEX] = index;
	if (DFM_Options) then
		DFM_Options_ProfileLabel:SetText(DFM_TEXT.CurrentProfile.."|cFFFFFFFF "..DFM_INDEX);
		DFM_Update_Profiles();
		DFM_Options_NewProfile:SetText("");
		DFM_Options_NewProfile:ClearFocus();
	end
end

function DFM_GameTooltip_SetDefaultAnchor(tooltip, parent)
	if (DFM_Settings.usetooltipanchor) then
		tooltip:SetOwner(parent, "ANCHOR_NONE");
		local prefix = "TOP";
		local suffix = "RIGHT";
		local x, y = UIParent:GetCenter();
		local x2, y2 = DFM_GameTooltipAnchor:GetCenter();
		if (x2 < x) then
			suffix = "LEFT";
		end
		if (y2 < y) then
			prefix = "BOTTOM";
		end
		tooltip:SetPoint(prefix..suffix, DFM_GameTooltipAnchor, prefix..suffix, 0, 0);
	else
		DFM_Old_GameTooltip_SetDefaultAnchor(tooltip, parent);
	end
end

function DFM_Initialize()
	if (DFM_INITIALIZED) then return; end

	if (not DFM_Settings) then
		DFM_Settings = {};
	elseif (not DFM_Settings["INITIALIZED1.0"]) then
		DFM_Settings = {};
	end
	DFM_Settings["INITIALIZED1.0"] = 1;

	DFM_PROFILE_INDEX = UnitName("player").." :: "..GetCVar("realmName");
	if (DFM_Settings[DFM_PROFILE_INDEX]) then
		DFM_INDEX = DFM_Settings[DFM_PROFILE_INDEX];
	else
		DFM_INDEX = DFM_TEXT.Default;
		DFM_Settings[DFM_PROFILE_INDEX] = DFM_TEXT.Default;
	end

	if (not DFM_Settings[DFM_INDEX]) then
		local err = DFM_Load_DefaultSettings();
		if (err) then
			DL_Debug("** Default settings not found for Discord Frame Modifier.  Unable to initialize. **");
			return;
		end
	end

	if (not DFM_Initialized) then
		DFM_Initialized = {};
	end

	if (DFM_CUSTOM_SETTINGS) then
		DFM_Settings.Custom = {};
		DL_Copy_Table(DFM_CUSTOM_SETTINGS, DFM_Settings.Custom);
		DFM_CUSTOM_SETTINGS = nil;
	end

	if (not DFM_Settings.LoadOnDemandFunctions) then
		DFM_Settings.LoadOnDemandFunctions = {
			"AuctionFrame_LoadUI",
			"BattlefieldMinimap_LoadUI",
			"ClassTrainerFrame_LoadUI",
			"CraftFrame_LoadUI",
			"InspectFrame_LoadUI",
			"KeyBindingFrame_LoadUI",
			"MacroFrame_LoadUI",
			"RaidFrame_LoadUI",
			"TalentFrame_LoadUI",
			"TradeSkillFrame_LoadUI"
		}
	end

	DFM_INITIALIZED = true;
	DL_Hook("CastingBarFrame_UpdatePosition", "DFM");
	DL_Hook("GameTooltip_SetDefaultAnchor", "DFM");

	for _,func in DFM_Settings.LoadOnDemandFunctions do
		RunScript(string.gsub(DFM_LODHOOKFUNC, "$f", func));
		DL_Hook(func, "DFM");
	end

	DFM_Initialize_AllFrames();
end

function DFM_Initialize_AllFrames(lod)
	if (not DFM_Initialized[DFM_INDEX]) then
		DFM_Initialized[DFM_INDEX] = {};
	end
	DFM_Initialized[DFM_INDEX]["1.2"] = 1;
	if (not DFM_Initialized[DFM_INDEX]["1.2"]) then
		DFM_Add_Frame("MasterFont", nil, "Fonts", nil, 1);
		DFM_Add_Frame("SystemFont", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontNormal", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontHighlight", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontDisable", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontGreen", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontRed", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontBlack", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontWhite", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontNormalSmall", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontHighlightSmall", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontDisableSmall", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontDarkGraySmall", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontGreenSmall", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontRedSmall", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontHighlightSmallOutline", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontNormalLarge", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontHighlightLarge", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontDisableLarge", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontGreenLarge", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameFontRedLarge", nil, "Fonts", nil, 1);
		DFM_Add_Frame("NumberFontNormal", nil, "Fonts", nil, 1);
		DFM_Add_Frame("NumberFontNormalSmall", nil, "Fonts", nil, 1);
		DFM_Add_Frame("NumberFontNormalLarge", nil, "Fonts", nil, 1);
		DFM_Add_Frame("NumberFontNormalYellow", nil, "Fonts", nil, 1);
		DFM_Add_Frame("NumberFontNormalSmallGray", nil, "Fonts", nil, 1);
		DFM_Add_Frame("NumberFontNormalHuge", nil, "Fonts", nil, 1);
		DFM_Add_Frame("ChatFontNormal", nil, "Fonts", nil, 1);
		DFM_Add_Frame("QuestTitleFont", nil, "Fonts", nil, 1);
		DFM_Add_Frame("QuestFont", nil, "Fonts", nil, 1);
		DFM_Add_Frame("QuestFontNormalSmall", nil, "Fonts", nil, 1);
		DFM_Add_Frame("QuestFontHighlight", nil, "Fonts", nil, 1);
		DFM_Add_Frame("ItemTextFontNormal", nil, "Fonts", nil, 1);
		DFM_Add_Frame("MailTextFontNormal", nil, "Fonts", nil, 1);
		DFM_Add_Frame("SubSpellFont", nil, "Fonts", nil, 1);
		DFM_Add_Frame("DialogButtonNormalText", nil, "Fonts", nil, 1);
		DFM_Add_Frame("DialogButtonHighlightText", nil, "Fonts", nil, 1);
		DFM_Add_Frame("ZoneTextFont", nil, "Fonts", nil, 1);
		DFM_Add_Frame("SubZoneTextFont", nil, "Fonts", nil, 1);
		DFM_Add_Frame("ErrorFont", nil, "Fonts", nil, 1);
		DFM_Add_Frame("TextStatusBarText", nil, "Fonts", nil, 1);
		DFM_Add_Frame("TextStatusBarTextSmall", nil, "Fonts", nil, 1);
		DFM_Add_Frame("CombatLogFont", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameTooltipText", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameTooltipTextSmall", nil, "Fonts", nil, 1);
		DFM_Add_Frame("GameTooltipHeaderText", nil, "Fonts", nil, 1);
		DFM_Add_Frame("WorldMapTextFont", nil, "Fonts", nil, 1);
		DFM_Add_Frame("InvoiceTextFontNormal", nil, "Fonts", nil, 1);
		DFM_Add_Frame("InvoiceTextFontSmall", nil, "Fonts", nil, 1);
		DFM_Initialized[DFM_INDEX]["1.2"] = 1;
	end
	for header in DFM_Settings[DFM_INDEX] do
		for frame in DFM_Settings[DFM_INDEX][header] do
			if (lod) then
				if (getglobal(frame) and (not getglobal(frame).dfminitialized)) then
					DFM_Initialize_Frame(header, frame);
				end
			else
				DFM_Initialize_Frame(header, frame);
			end
		end
	end
	if (DFM_Options and DFM_Options:IsVisible()) then
		DFM_Update_FrameList();
		DFM_OptionsMenu_Update();
	end
end

function DFM_Initialize_Frame(header, frame)
	if (DFM_Settings[DFM_INDEX][header][frame] and DFM_Settings[DFM_INDEX][header][frame].customFrame and (not getglobal(frame))) then
		if (DFM_Settings[DFM_INDEX][header][frame].frameType == "Texture") then
			UIParent:CreateTexture(frame, "ARTWORK");
		elseif (DFM_Settings[DFM_INDEX][header][frame].frameType == "FontString") then
			UIParent:CreateFontString(frame, "ARTWORK");
			getglobal(frame):SetFontObject(GameFontNormal);
		elseif (DFM_Settings[DFM_INDEX][header][frame].frameType == "Font") then
			CreateFont(frame);
		else
			CreateFrame(DFM_Settings[DFM_INDEX][header][frame].frameType, frame, UIParent);
		end
		local f = getglobal(frame);
		f:SetHeight(10);
		f:SetWidth(10);
		f:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
	end
	if (not getglobal(frame)) then return; end
	local f = getglobal(frame);
	f.dfminitialized = true;
	for method=1, table.getn(DFM_METHODS_LIST) do
		if (DFM_Settings[DFM_INDEX][header][frame][method]) then
			if (DFM_Settings[DFM_INDEX][header][frame][method].lock) then
				local methodName = DFM_METHODS_LIST[method].method;
				if (not f["DFM_"..methodName]) then
					f["DFM_"..methodName] = f[methodName];
					f[methodName] = function() end;
				end
			end
			DFM_Call_Method(header, frame, method);
		end
	end
	DFM_Initialize_FrameLocation(header, frame);
	if (DFM_Settings[DFM_INDEX][header][frame].forceHide) then
		f.DFMShow = f.Show;
		f.Show = function() end;
		f:Hide();
	elseif (f.DFMShow) then
		f:DFMShow();
	end
	for header in DFM_Settings[DFM_INDEX] do
		for frameName in DFM_Settings[DFM_INDEX][header] do
			local checkParent = getglobal(frameName);
			if (checkParent and checkParent.GetParent and checkParent:GetParent() and checkParent:GetParent().GetName and checkParent:GetParent():GetName() == frame) then
				DFM_Initialize_Frame(header, checkParent);
			end
		end
	end
end

function DFM_Initialize_FrameLocation(header, frame)
	local settings = DFM_Settings[DFM_INDEX][header][frame].Location;
	if (not settings or not settings.use) then
		getglobal(frame).dfmmoved = nil;
		return;
	end
	local anchorFrame = settings.frame;
	if (not getglobal(anchorFrame)) then
		anchorFrame = "UIParent";
	end
	local prefix = "";
	frame = getglobal(frame);
	frame.dfmmoved = true;
	if (settings.lock) then
		prefix = "DFM_";
		if (not frame.DFM_SetPoint) then
			frame.DFM_SetPoint = frame.SetPoint;
			frame.SetPoint = function() end;
		end
	elseif (frame.DFM_SetPoint) then
		frame.SetPoint = frame.DFM_SetPoint;
		frame.DFM_SetPoint = nil;
	end
	
	frame:ClearAllPoints();
	frame[prefix.."SetPoint"](frame, settings.point, anchorFrame, settings.to, settings.x, settings.y);
end

function DFM_Load_DefaultSettings()
	DFM_Settings[DFM_INDEX] = {};
	if (DFM_DEFAULT_SETTINGS) then
		DL_Copy_Table(DFM_DEFAULT_SETTINGS, DFM_Settings[DFM_INDEX]);
	else
		return true;
	end
end

function DFM_Load_Options(framefinder)
	if (DFM_Options) then return; end
	UIParentLoadAddOn("DiscordFrameModifierOptions");
	DL_Set_OptionsTitle("DFM_Options", "DiscordFrameModifierOptions\\title", DFM_VERSION);
	DL_Layout_Menu("DFM_DropMenu", DFM_DropMenu_OnClick);
	DL_Layout_ScrollButtons("DFM_ScrollMenu_Button", 10, DFM_ScrollMenu_OnClick);
	DL_Layout_ScrollButtons("DFM_Options_FrameMenu_Button", 14, DFM_FrameMenu_OnClick);
	DL_Layout_VerticalFrames("DFM_Options_OptionsMenu_Button", 7, DFM_OptionsMenu_OnClick);
	DL_Layout_VerticalFrames("DFM_LoDFrame_Menu_Button", 7);
	DFM_Options_ProfileLabel:SetText(DFM_TEXT.CurrentProfile.."|cFFFFFFFF "..DFM_INDEX);
	DFM_Update_FrameList();
	DFM_Update_Profiles();
	DFM_CreateFrameForm_FrameType_Setting:SetText("Frame");
	if (framefinder) then
		DFM_FrameFinder:Show();
	else
		DFM_Options:Show();
	end
	DFM_FrameMenu_Update();
end

function DFM_Load_Profile(index)
	if (not index) then
		if (DFM_Options) then
			index = DFM_Options_LoadProfile_Setting:GetText();
			if (not index or index == "") then return; end
		else
			return;
		end
	end
	DFM_Settings[DFM_PROFILE_INDEX] = index;
	ReloadUI();
end

function DFM_Main_OnLoad()
	DiscordLib_RegisterInitFunc(DFM_Initialize);

	SlashCmdList["DFM"] = DFM_Slash_Handler;
	SLASH_DFM1 = "/dfm";
	SLASH_DFM2 = "/discordframemodifier";
end

function DFM_Slash_Handler(msg)
	if (msg == "resetall") then
		DFM_Settings = nil;
		ReloadUI();
	elseif (msg == "usetooltipanchor") then
		if (DFM_Settings.usetooltipanchor) then
			DFM_Settings.usetooltipanchor = nil;
			DL_Feedback("Discord Frame Modifier will no longer use its tooltip anchor to position the tooltip.");
		else
			DFM_Settings.usetooltipanchor = 1;
			DL_Feedback("Discord Frame Modifier will now use its tooltip anchor to position the tooltip.");
		end
	elseif (msg == "usecontaineranchors") then
		if (DFM_Settings.usecontineranchors) then
			DFM_Settings.usecontineranchors = nil;
		else
			DFM_Settings.usecontineranchors = 1;
		end
	else
		DFM_Toggle_Options();
	end
end

function DFM_Toggle_FrameFinder()
	if (DFM_Options) then
		if (DFM_FrameFinder:IsVisible()) then
			DFM_FrameFinder:Hide();
		else
			DFM_FrameFinder:Show();
		end
	else
		DFM_Load_Options(1);
	end
end

function DFM_Toggle_Options()
	if (DFM_Options) then
		if (DFM_Options:IsVisible()) then
			DFM_Options:Hide();
		else
			DFM_Options:Show();
		end
	else
		DFM_Load_Options();
	end
end

DFM_Old_CastingBarFrame_OnUpdate = CastingBarFrame_OnUpdate;
function DFM_CastingBarFrame_OnUpdate()
	DFM_Old_CastingBarFrame_OnUpdate();
	if ( this.casting ) then
		local status = GetTime();
		local sparkPosition = ((status - this.startTime) / (this.maxValue - this.startTime)) * CastingBarFrame:GetWidth();
		if ( sparkPosition < 0 ) then
			sparkPosition = 0;
		end
		CastingBarSpark:SetPoint("CENTER", CastingBarFrame, "LEFT", sparkPosition, 2);
	elseif ( this.channeling ) then
		local time = GetTime();
		local barValue = this.startTime + (this.endTime - time);
		local sparkPosition = ((barValue - this.startTime) / (this.endTime - this.startTime)) * CastingBarFrame:GetWidth();
		CastingBarSpark:SetPoint("CENTER", CastingBarFrame, "LEFT", sparkPosition, 2);
	end
end
CastingBarFrame_OnUpdate = DFM_CastingBarFrame_OnUpdate;