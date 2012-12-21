function DART_Compile_Scripts()
	for ti = 1, DART_Get_MaxTextureIndex() do
		for i=1,DART_NUMBER_OF_SCRIPTS do
			if (DART_Settings[DART_INDEX][ti].scripts[i]) then
				RunScript("function DART_Texture"..ti.."_Script_"..DART_SCRIPT_LABEL[i].."(param, ti)\n  "..DART_Settings[DART_INDEX][ti].scripts[i].." \nend");
			else
				RunScript("function DART_Texture"..ti.."_Script_"..DART_SCRIPT_LABEL[i].."()\nend");
			end
			if (i == 14) then
				this = getglobal("DART_Texture_"..ti);
				getglobal("DART_Texture"..ti.."_Script_"..DART_SCRIPT_LABEL[i])("", ti);
			end
		end
	end
end

function DART_Get_Offsets(element, baseframe, settings)
	baseframe = getglobal(baseframe);
	local xoffset, yoffset = DL_Get_Offsets(element, baseframe, DART_ATTACH_POINTS[settings.attachpoint[1]], DART_ATTACH_POINTS[settings.attachto[1]]);
	return xoffset, yoffset;
end

function DART_Get_Position(frame, attach, scale)
	local x, y;
	attach = DART_ATTACH_POINTS[attach];
	if (attach == "TOPLEFT") then
		x = frame:GetLeft();
		y = frame:GetTop();
	elseif (attach == "TOP") then
		x = frame:GetLeft() + (frame:GetRight() - frame:GetLeft()) / 2;
		y = frame:GetTop();
	elseif (attach == "TOPRIGHT") then
		x = frame:GetRight();
		y = frame:GetTop();
	elseif (attach == "LEFT") then
		x = frame:GetLeft();
		y = frame:GetBottom() + (frame:GetTop() - frame:GetBottom()) / 2;
	elseif (attach == "CENTER") then
		x = frame:GetLeft() + (frame:GetRight() - frame:GetLeft()) / 2;
		y = frame:GetBottom() + (frame:GetTop() - frame:GetBottom()) / 2;
	elseif (attach == "RIGHT") then
		x = frame:GetRight();
		y = frame:GetBottom() + (frame:GetTop() - frame:GetBottom()) / 2;
	elseif (attach == "BOTTOMLEFT") then
		x = frame:GetLeft();
		y = frame:GetBottom();
	elseif (attach == "BOTTOM") then
		x = frame:GetLeft() + (frame:GetRight() - frame:GetLeft()) / 2;
		y = frame:GetBottom();
	elseif (attach == "BOTTOMRIGHT") then
		x = frame:GetRight();
		y = frame:GetBottom();
	end
	x = DL_round(x, 2);
	y = DL_round(y, 2);
	return x, y;
end

function DART_Initialize(override)
	if (DART_INITIALIZED) then return; end

	if (DART_DL_VERSION > DL_VERSION) then
		ScriptErrors_Message:SetText("** You need to install the latest version of the Discord Library, v"..DART_DL_VERSION..", for Discord Art to work right.  It should be included in the same .zip file from which you extracted this mod. **");
		ScriptErrors:Show();
		return;
	end

	if (not DART_Settings) then
		DART_Settings = {};
		DART_Settings.CustomTextures = {};
	end

	if (not DART_Settings[DART_TEXT.Default]) then
		DART_Initialize_DefaultSettings();
	end

	DART_PROFILE_INDEX = UnitName("player").." : "..GetCVar("realmName");
	if (DART_Settings[DART_PROFILE_INDEX]) then
		DART_INDEX = DART_Settings[DART_PROFILE_INDEX];
	else
		DART_INDEX = DART_TEXT.Default;
		DART_Settings[DART_PROFILE_INDEX] = DART_TEXT.Default;
	end

	if (not override) then
		DART_INITIALIZED = true;
	end

	if (DART_CUSTOM_SETTINGS) then
		local index = DART_TEXT.Custom;
		DART_Settings[index] = {};
		DL_Copy_Table(DART_CUSTOM_SETTINGS, DART_Settings[index]);
	end

	if (not override) then
		DART_Initialize_NewSettings();
		DART_Initialize_Everything();
	end
end

function DART_Initialize_DefaultSettings()
	local index = DART_TEXT.Default;
	DART_Settings[index] = {};
	if (DART_DEFAULT_SETTINGS) then
		DL_Copy_Table(DART_DEFAULT_SETTINGS, DART_Settings[index]);
	else
		DART_Settings[index].updatespeed = 30;
		DART_Settings[index].optionsscale = 1;
		DART_Set_DefaultSettings(index, 1);
	end
end

function DART_CreateAllFrames()
	if (not DART_INITIALIZED) then
		DART_Initialize(1)
	end
	for ti in pairs(DART_Settings[DART_INDEX]) do
		if (type(ti) == "number") then
			local texture = getglobal("DART_Texture_"..ti);
			if (not texture) then
				DART_Create_Texture(ti, 1);
			end
		end
	end
end

function DART_Initialize_Everything()
	DART_Set_OnUpdateSpeed();
	DART_CreateAllFrames()
	for ti in pairs(DART_Settings[DART_INDEX]) do
		if (type(ti) == "number") then
			DART_Initialize_Texture(ti);
		end
	end
	local ti = 0;
	while (true) do
		ti = ti + 1;
		local texture = getglobal("DART_Texture_"..ti);
		if (texture) then
			if (not DART_Settings[DART_INDEX][ti]) then
				texture:Hide();
				texture:UnregisterAllEvents();
			end
		else
			break;
		end
	end
	if (DART_Options) then
		DART_Initialize_TextureList();
		DART_Set_OptionsScale();
		DART_Initialize_TextureOptions();
		DART_Initialize_MiscOptions();
	end
	DART_Compile_Scripts();
end

function DART_Get_MaxTextureIndex()
	local ti = 0;
	while (true) do
		ti = ti + 1;
		if (not DART_Settings[DART_INDEX][ti]) then
			return ti - 1;
		end
	end
end

function DART_Initialize_NewSettings()
	local maxIndex = DART_Get_MaxTextureIndex();
	if (not DART_Settings[DART_INDEX]["INITIALIZED1.0d"]) then
		for ti = 1, maxIndex do
			DART_Settings[DART_INDEX][ti].parent = "UIParent";
			DART_Settings[DART_INDEX][ti].strata = "BACKGROUND";
			DART_Settings[DART_INDEX][ti].bgtexture = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop";
			DART_Settings[DART_INDEX][ti].bordertexture = "Interface\\Tooltips\\UI-Tooltip-Border";
			DART_Settings[DART_INDEX][ti].Backdrop = { tile=true, tileSize=16, edgeSize=16, left=5, right=5, top=5, bottom=5};
		end
	end
	if (not DART_Settings[DART_INDEX]["INITIALIZED1.1"]) then
		for ti = 1, maxIndex do
			DART_Settings[DART_INDEX][ti].framelevel = 0;
		end
	end
	if (not DART_Settings[DART_INDEX]["INITIALIZED1.5"]) then
		for ti = 1, maxIndex do
			DART_Settings[DART_INDEX][ti].drawlayer = "ARTWORK";
			DART_Settings[DART_INDEX][ti].blendmode = "DISABLE";
			DART_Settings[DART_INDEX][ti].text.drawlayer = "OVERLAY";
		end
	end

	DART_Settings[DART_INDEX]["INITIALIZED1.5"] = true;
	DART_Settings[DART_INDEX]["INITIALIZED1.1"] = true;
	DART_Settings[DART_INDEX]["INITIALIZED1.0d"] = true;
end

function DART_Create_Texture(ti, override)
	if (not ti) then
		ti = DART_Get_MaxTextureIndex() + 1;
		DART_Set_DefaultSettings(DART_INDEX, ti);
	end

	CreateFrame("Button", "DART_Texture_"..ti, UIParent);

	local frame = getglobal("DART_Texture_"..ti);

	frame:CreateTexture("DART_Texture_"..ti.."_Texture", "ARTWORK");
	frame:CreateTexture("DART_Texture_"..ti.."_Highlight", "OVERLAY");
	frame:CreateFontString("DART_Texture_"..ti.."_Text", "OVERLAY");
	
	frame:SetID(ti);
	frame:SetMovable(1);
	frame:RegisterForDrag("LeftButton", "RightButton");
	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
	frame.baseframelevel = frame:GetFrameLevel();

	local texture = getglobal("DART_Texture_"..ti.."_Texture");
	texture:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
	texture:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0);

	local highlight = getglobal("DART_Texture_"..ti.."_Highlight");
	highlight:Hide();
	highlight:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
	highlight:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0);
	highlight:SetTexture("Interface\AddOns\DiscordLibrary\PlainBackdrop");
	highlight:SetBlendMode("ADD");

	local text = getglobal("DART_Texture_"..ti.."_Text");
	text:SetFontObject(GameFontNormal);
	text:SetPoint("CENTER", frame, "CENTER", 0, 0);

	frame:SetScript("OnClick", DART_Texture_OnClick);
	frame:SetScript("OnEvent", DART_Texture_OnEvent);
	frame:SetScript("OnEnter", DART_Texture_OnEnter);
	frame:SetScript("OnShow", DART_Texture_OnShow);
	frame:SetScript("OnHide", DART_Texture_OnHide);
	frame:SetScript("OnLeave", DART_Texture_OnLeave);
	frame:SetScript("OnMouseUp", DART_Texture_OnMouseUp);
	frame:SetScript("OnMouseDown", DART_Texture_OnMouseDown);
	frame:SetScript("OnMouseWheel", DART_Texture_OnMouseWheel);
	frame:SetScript("OnReceiveDrag", DART_Texture_OnReceiveDrag);
	frame:SetScript("OnDragStart", DART_Texture_OnDragStart);
	frame:SetScript("OnDragStop", DART_Texture_OnDragStop);
	frame:SetScript("OnUpdate", DART_Texture_OnUpdate);

	if (not override) then
		DART_Initialize_Texture(ti);
	end
	if (DART_Options) then
		DART_Initialize_TextureList();
	end
end

function DART_Initialize_Texture(textureIndex)
	local settings = DART_Settings[DART_INDEX][textureIndex];
	local texture = getglobal("DART_Texture_"..textureIndex);

	texture.activeConditions = {};
	texture.updatetimer = 0;
	texture.totalelapsed = 0;
	DART_FauxShow(textureIndex);

	texture:ClearAllPoints();
	for i=1,4 do
		if (settings.attachframe[i] and settings.attachframe[i] ~= "") then
			if (not getglobal(settings.attachframe[i])) then
				settings.attachframe[i] = "UIParent";
			end
			texture:SetPoint(DART_ATTACH_POINTS[settings.attachpoint[i]], settings.attachframe[i], DART_ATTACH_POINTS[settings.attachto[i]], settings.xoffset[i], settings.yoffset[i]);
			
		end
	end

	texture:SetBackdrop({bgFile = settings.bgtexture, edgeFile = settings.bordertexture, tile = settings.Backdrop.tile, tileSize = settings.Backdrop.tileSize, edgeSize = settings.Backdrop.edgeSize, insets = { left = settings.Backdrop.left, right = settings.Backdrop.right, top = settings.Backdrop.top, bottom = settings.Backdrop.bottom }});

	if (getglobal(settings.parent)) then
		texture:SetParent(settings.parent);
	else
		DART_Settings[DART_INDEX][textureIndex].parent = "UIParent";
		texture:SetParent(settings.parent);
	end
	texture:SetFrameStrata(settings.strata);
	getglobal(texture:GetName().."_Texture"):SetDrawLayer(settings.drawlayer);
	getglobal(texture:GetName().."_Texture"):SetBlendMode(settings.blendmode);

	DART_Texture(textureIndex, settings.texture, settings.coords);
	DART_Scale(textureIndex, settings.scale);
	DART_Height(textureIndex, settings.height);
	DART_Width(textureIndex, settings.width);
	DART_Color(textureIndex, settings.color.r, settings.color.g, settings.color.b, settings.alpha);
	DART_BackgroundColor(textureIndex, settings.bgcolor.r, settings.bgcolor.g, settings.bgcolor.b, settings.bgalpha);
	DART_BorderColor(textureIndex, settings.bordercolor.r, settings.bordercolor.g, settings.bordercolor.b, settings.borderalpha);
	if (settings.hide) then
		DART_Hide(textureIndex);
	else
		DART_Show(textureIndex);
	end
	if (settings.hidebg) then
		texture:SetBackdropColor(0, 0, 0, 0);
		texture:SetBackdropBorderColor(0, 0, 0, 0);
	end
	DART_Padding(textureIndex, settings.padding);
	if (settings.disablemouse) then
		texture:EnableMouse(false);
	else
		texture:EnableMouse(1);
	end
	if (settings.disableMousewheel) then
		texture:EnableMouseWheel(false);
	else
		texture:EnableMouseWheel(1);
	end

	local text = getglobal("DART_Texture_"..textureIndex.."_Text");
	if (settings.font) then
		local fontSet;
		if (string.find(settings.font, "\\")) then
			fontSet = text:SetFont(settings.font, settings.text.height);
		elseif (settings.font == "") then
			fontSet = text:SetFont("Fonts\\FRIZQT__.TTF", 12);
		else
			fontSet = text:SetFont("Interface\\AddOns\\DiscordArt\\CustomFonts\\"..settings.font, settings.text.height);
		end
		if (not fontSet) then
			DL_Error("Texture #"..textureIndex.." - Attempt to load a font that doesn't exist.");
		end
	end
	text:SetDrawLayer(settings.text.drawlayer);

	DART_Text(textureIndex, settings.text.text);
	DART_TextAlpha(textureIndex, settings.text.alpha);
	DART_TextColor(textureIndex, settings.text.color.r, settings.text.color.g, settings.text.color.b, settings.text.alpha);
	DART_TextHeight(textureIndex, settings.text.height);
	DART_TextWidth(textureIndex, settings.text.width);
	DART_TextFontSize(textureIndex, settings.text.fontsize);
	if (settings.text.hide) then
		DART_TextHide(textureIndex);
	else
		DART_TextShow(textureIndex);
	end

	text:ClearAllPoints();
	text:SetPoint(DART_ATTACH_POINTS[settings.text.attachpoint], texture:GetName(), DART_ATTACH_POINTS[settings.text.attachto], settings.text.xoffset, settings.text.yoffset);
	text:SetJustifyV(DART_ATTACH_POINTS[settings.text.justifyV]);
	text:SetJustifyH(DART_ATTACH_POINTS[settings.text.justifyH]);

	if (settings.highlighttexture) then
		if (string.find(settings.highlighttexture, "\\")) then
			getglobal("DART_Texture_"..textureIndex.."_Highlight"):SetTexture(settings.highlighttexture);
		else
			getglobal("DART_Texture_"..textureIndex.."_Highlight"):SetTexture("Interface\\AddOns\\DiscordArt\\CustomTextures\\"..settings.highlighttexture);
		end
	end
	DART_HighlightColor(textureIndex, settings.highlightcolor.r, settings.highlightcolor.g, settings.highlightcolor.b, settings.highlightalpha);

	setglobal("BINDING_NAME_DART_TEXTURE_"..textureIndex, settings.name);

	if (not settings.framelevel) then settings.framelevel = 0; end
	local frameLvl = texture.baseframelevel + settings.framelevel;
	frameLvl = DL_round(frameLvl, 0);
	if (frameLvl <= 0) then
		frameLvl = 1;
	end
	texture:SetFrameLevel(frameLvl);
end

function DART_Load_Options()
	if (DART_Options) then return; end
	UIParentLoadAddOn("DiscordArtOptions");
	DART_Initialize_TextureList();
	DART_Initialize_ProfileList();
	DL_Set_OptionsTitle("DART_Options", "DiscordArtOptions\\title", DART_VERSION);
	DL_Layout_Menu("DART_DropMenu");
	DL_Layout_ScrollButtons("DART_ScrollMenu_Button", 10, DART_Options_SelectTexture);
	DL_Init_MenuControl(DART_BaseOptions_SelectTexture, DART_TEXTURE_INDEX);
	DL_Init_MenuControl(DART_TextureOptions_NudgeIndex, DART_NUDGE_INDEX);
	DART_TextureOptions_FrameLevel_Label:ClearAllPoints();
	DART_TextureOptions_FrameLevel_Label:SetPoint("BOTTOM", DART_TextureOptions_FrameLevel, "TOP", 0, 0);
	DART_ControlOptions_ParamLabel:SetText(DART_TEXT.Parameters);
	DART_ControlOptions_ResponseLabel:SetText(DART_TEXT.Parameters);
	DL_Layout_ScrollButtons("DART_ControlOptions_ConditionMenu_Button", 7);
	DART_ControlOptions_Response_Label:ClearAllPoints();
	DART_ControlOptions_Response_Label:SetPoint("BOTTOM", DART_ControlOptions_Response, "TOP", 0, 0);
	DART_ControlOptions_Condition_Label:ClearAllPoints();
	DART_ControlOptions_Condition_Label:SetPoint("BOTTOM", DART_ControlOptions_Condition, "TOP", 0, 0);
	DART_Set_OptionsScale();
	DART_Initialize_TextureOptions();
	DART_Initialize_MiscOptions();
end

function DART_Main_OnLoad()
	DiscordLib_RegisterInitFunc(DART_Initialize);
	DiscordLib_RegisterFrameCreationFunc(DART_CreateAllFrames);

	SlashCmdList["DART"] = DART_Slash_Handler;
	SLASH_DART1 = "/dart";
	SLASH_DART2 = "/discordart";
end

function DART_Options_SetProfile(index)
	if (not index) and DART_Options then
		index = DART_MiscOptions_SetProfile_Setting:GetText();
	end
	if (index == "" or (not index)) then return; end
	DART_INDEX = index;
	DART_Settings[DART_PROFILE_INDEX] = index;
	DART_Initialize_NewSettings();
	DART_Initialize_Everything();
	DL_Feedback(DART_TEXT.ProfileLoaded..index);
end

function DART_Options_Toggle()
	if (not DART_Options) then
		DART_Load_Options();
	end
	if (DART_Options:IsVisible()) then
		DART_Options:Hide();
	else
		DART_Options:Show();
	end
end

function DART_Set_DefaultSettings(index, ti)
	DART_Settings[index][ti] = {};
	DART_Settings[index][ti].hide = true;
	DART_Settings[index][ti].hidebg = true;
	DART_Settings[index][ti].xoffset = {};
	DART_Settings[index][ti].yoffset = {};
	DART_Settings[index][ti].attachpoint = {};
	DART_Settings[index][ti].attachto = {};
	DART_Settings[index][ti].drawlayer = "ARTWORK";
	DART_Settings[index][ti].blendmode = "DISABLE";
	for i=1,4 do
		DART_Settings[index][ti].xoffset[i] = 0;
		DART_Settings[index][ti].yoffset[i] = 0;
		DART_Settings[index][ti].attachpoint[i] = 5;
		DART_Settings[index][ti].attachto[i] = 5;
	end
	DART_Settings[index][ti].attachframe = {};
	DART_Settings[index][ti].attachframe[1] = "UIParent";
	DART_Settings[index][ti].alpha = 1;
	DART_Settings[index][ti].height = 50;
	DART_Settings[index][ti].width = 50;
	DART_Settings[index][ti].scale = 1;
	DART_Settings[index][ti].color = {r=1, g=1, b=1};
	DART_Settings[index][ti].bgcolor = {r=0, g=0, b=0};
	DART_Settings[index][ti].bordercolor = {r=1, g=1, b=1};
	DART_Settings[index][ti].highlightcolor = {r=1, g=1, b=0};
	DART_Settings[index][ti].bgalpha = 1;
	DART_Settings[index][ti].borderalpha = 1;
	DART_Settings[index][ti].highlightalpha = .3;
	DART_Settings[index][ti].padding = 5;
	DART_Settings[index][ti].texture = "";
	DART_Settings[index][ti].coords = { 0, 1, 0, 1 };
	DART_Settings[index][ti].text = { text="", hide=true, color={r=1, g=1, b=1}, height=20, width=100, attachpoint=2, attachto=2, xoffset=0, yoffset=0, justifyH=5, justifyV=5, alpha=1, fontsize=16};
	DART_Settings[index][ti].text.drawlayer = "OVERLAY";
	DART_Settings[index][ti].name = DART_TEXT.Texture..ti;
	DART_Settings[index][ti].scripts = {};
	DART_Settings[index][ti].parent = "UIParent";
	DART_Settings[index][ti].strata = "BACKGROUND";
	DART_Settings[index][ti].bgtexture = "Interface\\AddOns\\DiscordLibrary\\PlainBackdrop";
	DART_Settings[index][ti].bordertexture = "Interface\\Tooltips\\UI-Tooltip-Border";
	DART_Settings[index][ti].Backdrop = { tile=true, tileSize=16, edgeSize=16, left=5, right=5, top=5, bottom=5};
	DART_Settings[index][ti].framelevel = 0;
end

function DART_Set_OnUpdateSpeed()
	if (not DART_Settings[DART_INDEX].updatespeed) then
		DART_Settings[DART_INDEX].updatespeed = 30;
	end
	DART_UPDATE_SPEED = 1 / DART_Settings[DART_INDEX].updatespeed;
end

function DART_Set_OptionsScale()
	DART_Options:SetScale(DART_Settings[DART_INDEX].optionsscale);
	DART_Options:ClearAllPoints();
	DART_Options:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
end

function DART_Slash_Handler(msg)
	local command, param;
	local index = string.find(msg, " ");

	if( index) then
		command = string.sub(msg, 1, (index - 1));
		param = string.sub(msg, (index + 1)  );
	else
		command = msg;
	end

	DART_Options_Toggle();
end

function DART_Texture_OnClick()
	this:StopMovingOrSizing()
	DART_Texture_Process(7, arg1);
end

function DART_Texture_OnDragStart()
	if (not DART_DRAGGING_UNLOCKED) then return; end
	if ((not DART_Settings[DART_INDEX][this:GetID()].attachframe[2]) or DART_Settings[DART_INDEX][this:GetID()].attachframe[2] == "") then
		this.moving = true;
		this:StartMoving();
	else
		DL_Debug(DART_TEXT.DragWarning);
	end
end

function DART_Texture_OnDragStop()
	if (this.moving) then
		this.moving = nil;
		this:StopMovingOrSizing();
		local settings = DART_Settings[DART_INDEX][this:GetID()];
		local xoffset, yoffset = DART_Get_Offsets(this, settings.attachframe[1], settings);
		this:ClearAllPoints();
		this:SetPoint(DART_ATTACH_POINTS[settings.attachpoint[1]], settings.attachframe[1], DART_ATTACH_POINTS[settings.attachto[1]], xoffset, yoffset);
		DART_Settings[DART_INDEX][this:GetID()].xoffset[1] = xoffset;
		DART_Settings[DART_INDEX][this:GetID()].yoffset[1] = yoffset;
		if (DART_Options and this:GetID() == DART_TEXTURE_INDEX) then
			DART_Initialize_TextureOptions();
		end
	end
end

function DART_Texture_OnEnter()
	if (DART_Settings[DART_INDEX][this:GetID()].highlight) then
		getglobal(this:GetName().."_Highlight"):Show();
	end
	DART_Texture_Process(3);
end

function DART_Texture_OnEvent()
	DART_Texture_Process(2, event);
end

function DART_Texture_OnHide()
	if (this.moving) then
		this.moving = nil;
		this:StopMovingOrSizing();
	end
	DART_Texture_Process(6);
end

function DART_Texture_OnLeave()
	if (DART_Settings[DART_INDEX][this:GetID()].highlight) then
		getglobal(this:GetName().."_Highlight"):Hide();
	end
	DART_Texture_Process(4);
end

function DART_Texture_OnLoad()
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up");
	this.baseframelevel = this:GetFrameLevel();
end

function DART_Texture_OnMouseDown()
	DART_Texture_Process(9, arg1);
end

function DART_Texture_OnMouseUp()
	DART_Texture_Process(8, arg1);
end

function DART_Texture_OnMouseWheel()
	DART_Texture_Process(12, arg1);
end

function DART_Texture_OnReceiveDrag()
	DART_Texture_Process(13);
end

function DART_Texture_OnShow()
	DART_Texture_Process(5);
end

function DART_Texture_OnUpdate()
	if (not DART_INITIALIZED) then return; end
	if (this.flashing) then
		this.flashtime = this.flashtime - arg1;
		if (this.flashtime < 0) then
			this.flashtime = .5;
			if (this.direction) then
				this.direction = nil;
			else
				this.direction = 1;
			end
		end
		if (this.direction) then
			this:SetAlpha(1 - this.flashtime);
		else
			this:SetAlpha(.5 + this.flashtime);
		end
	end
	this.updatetimer = this.updatetimer - arg1;
	this.totalelapsed = this.totalelapsed + arg1;
	if (this.updatetimer > 0) then return; end
	this.updatetimer = DART_UPDATE_SPEED;

	local id = this:GetID();
	local conditions = DART_Settings[DART_INDEX][id].Conditions;
	if (conditions) then
		local condition, response;
		for i = 1, #conditions do
			condition = conditions[i].condition;
			response = conditions[i].response;
			this = getglobal("DART_Texture_"..id);
			local active;
			if (condition == 0) then
				active = true;
				this.activeConditions[i] = nil;
			elseif (condition == 9 or condition == 10) then
				active = DL_CheckCondition[condition](this);
			else
				active = DL_CheckCondition[condition](conditions[i]);
			end
			for _,override in pairs(conditions[i].overrides) do
				if (this.activeConditions[override]) then
					active = nil;
					break;
				end
			end

			if (active and (not this.activeConditions[i]) and response ~= 0) then
				if (response == 1) then
					DART_FauxHide(id);
				elseif (response == 2) then
					DART_FauxShow(id);
				elseif (response == 3) then
					DART_FauxHide(conditions[i].texture);
				elseif (response == 4) then
					DART_FauxShow(conditions[i].texture);
				elseif (response == 5) then
					getglobal("DART_Texture_"..id.."_Text"):Hide();
				elseif (response == 6) then
					getglobal("DART_Texture_"..id.."_Text"):Show();
				elseif (response == 7) then
					this:ClearAllPoints();
					this:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][id].attachpoint[1]], DART_Settings[DART_INDEX][id].attachframe[1], DART_ATTACH_POINTS[DART_Settings[DART_INDEX][id].attachto[1]], DART_Settings[DART_INDEX][id].xoffset[1], DART_Settings[DART_INDEX][id].yoffset[1] - conditions[i].amount);
				elseif (response == 8) then
					this:ClearAllPoints();
					this:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][id].attachpoint[1]], DART_Settings[DART_INDEX][id].attachframe[1], DART_ATTACH_POINTS[DART_Settings[DART_INDEX][id].attachto[1]], DART_Settings[DART_INDEX][id].xoffset[1] - conditions[i].amount, DART_Settings[DART_INDEX][id].yoffset[1]);
				elseif (response == 9) then
					this:ClearAllPoints();
					this:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][id].attachpoint[1]], DART_Settings[DART_INDEX][id].attachframe[1], DART_ATTACH_POINTS[DART_Settings[DART_INDEX][id].attachto[1]], DART_Settings[DART_INDEX][id].xoffset[1] + conditions[i].amount, DART_Settings[DART_INDEX][id].yoffset[1]);
				elseif (response == 10) then
					this:ClearAllPoints();
					this:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][id].attachpoint[1]], DART_Settings[DART_INDEX][id].attachframe[1], DART_ATTACH_POINTS[DART_Settings[DART_INDEX][id].attachto[1]], conditions[i].rx, conditions[i].ry);
				elseif (response == 11) then
					this:ClearAllPoints();
					this:SetPoint(DART_ATTACH_POINTS[DART_Settings[DART_INDEX][id].attachpoint[1]], DART_Settings[DART_INDEX][id].attachframe[1], DART_ATTACH_POINTS[DART_Settings[DART_INDEX][id].attachto[1]], DART_Settings[DART_INDEX][id].xoffset[1], DART_Settings[DART_INDEX][id].yoffset[1] + conditions[i].amount);
				elseif (response == 12) then
					getglobal("DART_Texture_"..id.."_Texture"):SetAlpha(conditions[i].alpha);
				elseif (response == 13) then
					this:SetBackdropColor(DART_Settings[DART_INDEX][id].bgcolor.r, DART_Settings[DART_INDEX][id].bgcolor.g, DART_Settings[DART_INDEX][id].bgcolor.b, conditions[i].alpha);
				elseif (response == 14) then
					this:SetBackdropColor(conditions[i].color.r, conditions[i].color.g, conditions[i].color.b, DART_Settings[DART_INDEX][id].bgalpha);
				elseif (response == 15) then
					local texture = getglobal("DART_Texture_"..id.."_Texture");
					local padding = conditions[i].padding;
					texture:ClearAllPoints();
					texture:SetPoint("TOPLEFT", this, "TOPLEFT", padding, -padding);
					texture:SetPoint("BOTTOMRIGHT", this, "BOTTOMRIGHT", -padding, padding);
					texture = getglobal("DART_Texture_"..id.."_Highlight");
					texture:ClearAllPoints();
					texture:SetPoint("TOPLEFT", this, "TOPLEFT", padding, -padding);
					texture:SetPoint("BOTTOMRIGHT", this, "BOTTOMRIGHT", -padding, padding);
				elseif (response == 16) then
					this:SetBackdropBorderColor(DART_Settings[DART_INDEX][id].bordercolor.r, DART_Settings[DART_INDEX][id].bordercolor.g, DART_Settings[DART_INDEX][id].bordercolor.b, conditions[i].alpha);
				elseif (response == 17) then
					this:SetBackdropBorderColor(conditions[i].color.r, conditions[i].color.g, conditions[i].color.b, DART_Settings[DART_INDEX][id].borderalpha);
				elseif (response == 18) then
					getglobal("DART_Texture_"..id.."_Texture"):SetVertexColor(conditions[i].color.r, conditions[i].color.g, conditions[i].color.b, DART_Settings[DART_INDEX][id].alpha);
				elseif (response == 19) then
					local text = getglobal("DART_Texture_"..id.."_Text");
					if (string.find(DART_Settings[DART_INDEX][id].font, "\\")) then
						text:SetFont(DART_Settings[DART_INDEX][id].font, conditions[i].amount);
					elseif (DART_Settings[DART_INDEX][id].font == "") then
						text:SetFont("Fonts\\FRIZQT__.TTF", conditions[i].amount);
					else
						fontSet = text:SetFont("Interface\\AddOns\\DiscordArt\\CustomFonts\\"..DART_Settings[DART_INDEX][id].font, conditions[i].amount);
					end
				elseif (response == 20) then
					this:SetHeight(conditions[i].amount);
				elseif (response == 21) then
					getglobal("DART_Texture_"..id.."_Highlight"):SetAlpha(conditions[i].alpha);
				elseif (response == 22) then
					getglobal("DART_Texture_"..id.."_Highlight"):SetVertexColor(conditions[i].color.r, conditions[i].color.g, conditions[i].color.b, DART_Settings[DART_INDEX][id].highlightalpha);
				elseif (response == 23) then
					this:SetScale(conditions[i].amount);
				elseif (response == 24) then
					getglobal("DART_Texture_"..id.."_Text"):SetAlpha(conditions[i].alpha);
				elseif (response == 25) then
					getglobal("DART_Texture_"..id.."_Text"):SetTextColor(conditions[i].color.r, conditions[i].color.g, conditions[i].color.b, DART_Settings[DART_INDEX][id].text.alpha);
				elseif (response == 26) then
					getglobal("DART_Texture_"..id.."_Text"):SetText(conditions[i].rtext);
				elseif (response == 27) then
					getglobal("DART_Texture_"..id.."_Texture"):SetTexture(conditions[i].rtext);
				elseif (response == 28) then
					this:SetWidth(conditions[i].amount);
				elseif (response == 29) then
					DART_StartFlashing(id);
				elseif (response == 30) then
					DART_StopFlashing(id);
				end
			end

			getglobal("DART_Texture_"..id).activeConditions[i] = active;
		end
	end

	DART_Texture_Process(1, this.totalelapsed);
	this.totalelapsed = 0;
end

function DART_Texture_Process(script, param, textureIndex)
	if (not DART_INITIALIZED) then return; end
	if (not textureIndex) then
		textureIndex = this:GetID();
	end
	if (DART_Options and DART_ScriptOptions_ScrollFrame_Text:IsVisible()) then return; end
	if (script == 1) then
		if (not this.timer) then
			this.timer = DART_UPDATE_SPEED;
		end
		this.timer = this.timer - param;
		if (this.timer > 0) then
			return;
		else
			this.timer = DART_UPDATE_SPEED;
		end
	end
	if (getglobal("DART_Texture"..textureIndex.."_Script_"..DART_SCRIPT_LABEL[script])) then
		getglobal("DART_Texture"..textureIndex.."_Script_"..DART_SCRIPT_LABEL[script])(param, textureIndex);
	end
end

function DART_Toggle_Dragging()
	if (DART_DRAGGING_UNLOCKED) then
		DART_DRAGGING_UNLOCKED = nil;
		if (DART_Options) then
			DART_Options_DragToggle:SetText(DART_TEXT.UnlockDragging);
		end
	else
		DART_DRAGGING_UNLOCKED = true;
		if (DART_Options) then
			DART_Options_DragToggle:SetText(DART_TEXT.LockDragging);
		end
	end
end
