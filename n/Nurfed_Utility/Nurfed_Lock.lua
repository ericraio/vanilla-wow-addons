
local utility = Nurfed_Utility:New();
local framelib = Nurfed_Frames:New();
local optionslib = Nurfed_Options:New();
local saved = {};

local micromenu = {
	[1] = {text = NRF_MICROHEADER, isTitle = 1 },
	[2] = {text = NRF_PAPERDOLL, func = function() ToggleCharacter("PaperDollFrame"); end },
	[3] = {text = NRF_SPELLBOOK, func = function() ToggleSpellBook(BOOKTYPE_SPELL) end },
	[4] = {text = NRF_TALENTS, func = ToggleTalentFrame },
	[5] = {text = NRF_QUESTLOG, func = ToggleQuestLog },
	[6] = {text = NRF_FRIENDS, func = ToggleFriendsFrame },
	[7] = {text = NRF_HELPMENU, func = ToggleHelpFrame },
	[8] = { text = KEYRING, func = ToggleKeyRing },
};

local addons = {
	[1] = {text = NRF_ADDONHEADER, isTitle = 1, nurfed = true },
	[2] = {text = NRF_OTHERADDONS, isTitle = 1 },
};

local addonlist = {
	["Nurfed_ActionBars"] = { text = "Nurfed ActionBars", func = function() optionslib:GetMenu("Nurfed_ActionBars") end },
	["Nurfed_General"] = { text = "Nurfed General", func = function() optionslib:GetMenu("Nurfed_General") end },
	["Nurfed_Hud"] = { text = "Nurfed Hud", func = function() optionslib:GetMenu("Nurfed_Hud") end },
	["Nurfed_UnitFrames"] = { text = "Nurfed UnitFrames", func = function() optionslib:GetMenu("Nurfed_UnitFrames") end },
	["Nurfed_CombatLog"] = { text = "Nurfed CombatLog", func = function() optionslib:GetMenu("Nurfed_CombatLog") end },
	["Nurfed_Raids"] = { text = "Nurfed Raids", func = function() optionslib:GetMenu("Nurfed_Raids") end },
	["AutoBar"] = { text = "Autobar Config", func = function() AutoBar_ToggleConfig() end },
	["Sct"] = { text = "SCT Menu", func = function() SCT_showMenu() end },
	["AF_Tooltip"] = { text = "AF_Tooltip Menu", func = function() aftt_toggleFrames() end },
	["TipBuddy"] = { text = "TipBuddy Menu", func = function() TipBuddy_ToggleOptionsFrame() end },
};

local function AddItem(text, func, nurfed)
	local index = utility:GetTableIndex(addons, text);
	if (index == nil) then
		index = table.getn(addons) + 1;
		table.setn(addons, index);
		addons[index] = {};
		addons[index].text = text;
		addons[index].func = func;
		if (string.find(text, "^Nurfed")) then
			addons[index].nurfed = true;
		end
	end
end

local function Update_Lock_POS()
	Nurfed_LockButton:ClearAllPoints();
	Nurfed_LockButton:SetPoint("CENTER", "Minimap", "CENTER", saved.lockx, saved.locky);
end

local function Nurfed_Lock_OnEvent()
	Nurfed_LockButton:UnregisterEvent(event);
	Nurfed_LockButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");

	local player = UnitName("player").." - "..GetCVar("realmName");
	if (not NURFED_UTILITY_SAVED) then
		NURFED_UTILITY_SAVED = {};
	end
	if (not NURFED_UTILITY_SAVED[player]) then
		NURFED_UTILITY_SAVED[player] = {
			["lockx"] = 0;
			["locky"] = -75;
		};
	end

	for k, v in addonlist do
		if (string.find(k, "^Nurfed")) then
			if (IsAddOnLoaded(k)) then
				local tbl = string.upper(k).."_SAVED";
				if (not getglobal(tbl)) then
					setglobal(tbl, {});
				end
				if (not getglobal(tbl)[player]) then
					getglobal(tbl)[player] = utility:TableCopy(getglobal(string.upper(k).."_DEFAULT"));
				end
				local func = getglobal(k.."_Init");
				if (func) then
					func();
				end
			end
		end
	end

	saved = NURFED_UTILITY_SAVED[player];
	Update_Lock_POS();
end

local function GenerateMenu()
	local frame = getglobal(this:GetName().."DropDown");

	if (not frame.updated) then
		for k, v in addonlist do
			if (IsAddOnLoaded(k)) then
				AddItem(v.text, v.func);
			end
		end
		frame.updated = true;
		frame.displayMode = "MENU";
	end

	frame.initialize = function ()
		local info = {};

		if (UIDROPDOWNMENU_MENU_VALUE == "Micro Buttons") then
			for _, v in micromenu do
				info = {};
				info.text = v.text;
				info.func = v.func;
				info.isTitle = v.isTitle;
				info.notCheckable = 1;
				UIDropDownMenu_AddButton(info, 2);
			end
		elseif (UIDROPDOWNMENU_MENU_VALUE == "Other AddOns") then
			for _, v in addons do
				if (not v.nurfed) then
					info = {};
					info.text = v.text;
					info.func = v.func;
					info.isTitle = v.isTitle;
					info.notCheckable = 1;
					UIDropDownMenu_AddButton(info, 2);
				end
			end
		else
			for _, v in addons do
				if (v.nurfed) then
					info = {};
					info.text = v.text;
					info.func = v.func;
					info.isTitle = v.isTitle;
					info.notCheckable = 1;
					info.textR = 0;
					info.textG = 1;
					info.textB = 0;
					UIDropDownMenu_AddButton(info);
				end
			end

			info = {};
			info.text = NRF_OTHERADDONS;
			info.value = "Other AddOns";
			info.hasArrow = 1;
			info.notCheckable = 1;
			UIDropDownMenu_AddButton(info);

			info = {};
			info.text = NRF_MICROHEADER;
			info.value = "Micro Buttons";
			info.hasArrow = 1;
			info.notCheckable = 1;
			UIDropDownMenu_AddButton(info);
		end
	end
end

local function Nurfed_LockButton_OnClick(button)
	if (IsShiftKeyDown()) then
		this:SetChecked(NRF_LOCKED);
		return;
	end
	if (button == "LeftButton") then
		NRF_LOCKED = this:GetChecked();
		if (NRF_LOCKED) then
			this:SetNormalTexture(NRF_IMG.."nurfedlocked");
		else
			this:SetNormalTexture(NRF_IMG.."nurfedunlocked");
		end
		PlaySound("igMainMenuOption");
	elseif (button == "RightButton") then
		this:SetChecked(NRF_LOCKED);
		local dropdown = getglobal(this:GetName().."DropDown");
		GenerateMenu();
		ToggleDropDownMenu(1, nil, dropdown, this:GetName(), 0, 0);
		local offscreenX, offscreenY = utility:OffScreen(DropDownList1);
		local point;
		if (offscreenX == 1) then
			point = "TOPRIGHT";
		elseif (offscreenY == 1) then
			point = "BOTTOMRIGHT";
		else
			point = "TOPLEFT";
		end
		DropDownList1:ClearAllPoints();
		DropDownList1:SetPoint(point, this, "BOTTOMLEFT", 0, 0);
	end
end

local function Nurfed_LockButton_OnUpdate()
	if (this.isMoving) then
		if (not IsShiftKeyDown()) then
			this.isMoving = nil;
			return;
		end

		-- Credit to Alex Brazie for this calculation
		cursorX, cursorY = GetCursorPosition();
		centerX, centerY = Minimap:GetCenter();
		scale = Minimap:GetEffectiveScale();
		cursorX = cursorX / scale;
		cursorY = cursorY / scale;
		local radius = (Minimap:GetWidth()/2) + (this:GetWidth()/3);
		local x = math.abs(cursorX - centerX);
		local y = math.abs(cursorY - centerY);
		local xSign = 1;
		local ySign = 1;
		if (not (cursorX >= centerX)) then
			xSign = -1;
		end
		if (not (cursorY >= centerY)) then
			ySign = -1;
		end

		local angle = math.atan(x/y);
		x = math.sin(angle)*radius;
		y = math.cos(angle)*radius;
		saved.lockx = xSign*x;
		saved.locky = ySign*y;

		Update_Lock_POS();
	end
end

local function Init()
	local tbl = {
		type = "CheckButton",
		size = { 25, 25 },
		FrameStrata = "LOW",
		Checked = NRF_LOCKED,
		events = {
			"PLAYER_LOGIN",
		},
		NormalTexture = NRF_IMG.."nurfedlocked",
		children = {
			DropDown = { type = "Frame" },
			Border = {
				type = "Texture",
				size = { 57, 57 },
				layer = "OVERLAY",
				Texture = "Interface\\Minimap\\MiniMap-TrackingBorder",
				Anchor = { "CENTER", "$parent", "CENTER", 11, -11 },
			},
		},
		OnEvent = function() Nurfed_Lock_OnEvent() end,
		OnClick = function() Nurfed_LockButton_OnClick(arg1) end,
		OnMouseDown = function() if (IsShiftKeyDown()) then this.isMoving = true end end,
		OnMouseUp = function() this.isMoving = nil end,
		OnUpdate = function() Nurfed_LockButton_OnUpdate() end,
	};
	framelib:ObjectInit("Nurfed_LockButton", tbl, Minimap);
	tbl = nil;
end

Init();