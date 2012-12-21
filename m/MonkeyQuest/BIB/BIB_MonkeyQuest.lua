BIB_MONKEYQUEST_ID =  "MonkeyQuest";
BIB_MONKEYQUEST_ICON_PATH = "Interface\\AddOns\\MonkeyLibrary\\Textures\\MonkeyBuddyIcon";
BIB_MONKEYQUEST_ICON_SIZE = 16;

function BIB_MonkeyQuestButton_OnLoad()
	-- register events
	this:RegisterEvent("VARIABLES_LOADED");

	BM_Plugin("BIB_MonkeyQuestButton", "MonkeyQuest", BIB_MONKEYQUEST_ICON_SIZE, "MonkeyQuest");
	
	DEFAULT_CHAT_FRAME:AddMessage("BIB_MonkeyQuestButton loaded");
end

function BIB_MonkeyQuestButton_OnEvent()
	if (event == "VARIABLES_LOADED") then
		BIB_MonkeyQuestButton_Initialize();
		--TitanPanelButtonBRL_SetIcon();
	end
end

function BIB_MonkeyQuestButton_GetButtonText()
	if (not IsAddOnLoaded("BhaldieInfoBar")) then
		return;
	end

	if (TitanGetVar(BIB_MONKEYQUEST_ID, "ShowLabelText")) then
		
		local iNumEntries, iNumQuests = GetNumQuestLogEntries();


		if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bShowNumQuests == true) then

			if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideTitle == false) then
				BIB_MonkeyQuestButtonText:SetText(MONKEYQUEST_TITLE .. " " .. iNumQuests .. "/" .. MAX_QUESTLOG_QUESTS);
			else
				BIB_MonkeyQuestButtonText:SetText(iNumQuests .. "/" .. MAX_QUESTLOG_QUESTS);
			end

		elseif (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bHideTitle == false) then
			BIB_MonkeyQuestButtonText:SetText(MONKEYQUEST_TITLE);
		else
			BIB_MonkeyQuestButtonText:SetText("");
		end


	else
		BIB_MonkeyQuestButtonText:SetText();
	end
end

function BIB_RightClickMenu_PrepareMonkeyQuestMenu()
	local info;

	TitanPanelRightClickMenu_AddTitle(MONKEYQUEST_TITLE);


	info = {};
	info.text = "Lock to BIB";
	info.func = BIB_MonkeyQuestButton_ToggleLockBIB;
	info.checked = MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();


	TitanPanelRightClickMenu_AddToggleLabelText(BIB_MONKEYQUEST_ID);
	TitanPanelRightClickMenu_AddToggleIcon(BIB_MONKEYQUEST_ID);

end

function BIB_MonkeyQuestButton_Initialize()
	-- This is the list of the saved vars used, values can be true, false, number, text whatever you want to save.
	savedVariables = {
		[1] = {name = "ShowIcon", value  = true},
		[2] = {name = "ShowLabelText", value  = true},
	}
	-- Function to Initialize the saved vars if they don't exisit create them if they do exisits SWEET!!
	for key, value in savedVariables do
		BM_Initialize_Variables(BIB_MONKEYQUEST_ID, value.name, value.value);
	end
	-- Creates the Dropdown menu
	UIDropDownMenu_Initialize(BIB_MonkeyQuestButtonRightClickMenu, BIB_RightClickMenu_PrepareMonkeyQuestMenu, "Menu");

	-- Initialize the icon
	BIB_MonkeyQuestButton_SetIcon();
	
	BIB_MonkeyQuestButtonText:SetFont("Interface\\AddOns\\MonkeyLibrary\\Fonts\\adventure.ttf", BHINFOBAR_CONFIG[BM_PLAYERNAME_REALM].plugin_fontsize);
	BIB_MonkeyQuestButtonText:SetTextColor(MONKEYLIB_TITLE_COLOUR.r, MONKEYLIB_TITLE_COLOUR.g, MONKEYLIB_TITLE_COLOUR.b);

	-- initial text
	BIB_MonkeyQuestButton_GetButtonText()
end

--Sets the icon to where its suppose to be if no icon skips this function
function BIB_MonkeyQuestButton_SetIcon()
	local icon1 = BIB_MonkeyQuestButtonIcon;

	if (TitanGetVar(BIB_MONKEYQUEST_ID, "ShowIcon")) then
		icon1:SetTexture(BIB_MONKEYQUEST_ICON_PATH);
		icon1:SetWidth(BIB_MONKEYQUEST_ICON_SIZE);
		icon1:SetHeight(BIB_MONKEYQUEST_ICON_SIZE);
	else
		icon1:SetTexture("");
		icon1:SetWidth(1);
	end
end

--This function is in every plugin always the same except for the 2 varables
function BIB_MonkeyQuestButton_OnEnter()


	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB == true) then
		-- testing
		MonkeyQuest_Show();

		-- todo: figure out where the button is...
		MonkeyQuestFrame:ClearAllPoints();

		if (BIB_MonkeyQuestButton:GetLeft() > 512) then
			-- on the right
			if (BIB_MonkeyQuestButton:GetTop() > 384) then
				-- on the top
				MonkeyQuestFrame:SetPoint("TOPRIGHT", "BIB_MonkeyQuestButton", "BOTTOMRIGHT", 0, 0);
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_BOTTOMLEFT";
			else
				MonkeyQuestFrame:SetPoint("BOTTOMRIGHT", "BIB_MonkeyQuestButton", "TOPRIGHT", 0, 0);
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_TOPLEFT";
			end
		else
			-- on the left
			if (BIB_MonkeyQuestButton:GetTop() > 384) then
				-- on the top
				MonkeyQuestFrame:SetPoint("TOPLEFT", "BIB_MonkeyQuestButton", "BOTTOMLEFT", 0, 0);
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_BOTTOMRIGHT";
			else
				MonkeyQuestFrame:SetPoint("BOTTOMLEFT", "BIB_MonkeyQuestButton", "TOPLEFT", 0, 0);
				MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_TOPRIGHT";
			end
		end
	end
end

--This function is in every plugin always the same
function BIB_MonkeyQuestButton_OnLeave()

end

--This function is in every plugin always the same
function BIB_MonkeyQuestButton_OnRightClick(button)
	if (button == "RightButton") then
		ToggleDropDownMenu(1, nil, getglobal(this:GetName().."RightClickMenu"), this:GetName(), 0, 0);
		GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
		GameTooltip:Hide();
	end
end

function BIB_MonkeyQuestButton_ToggleLockBIB()
	MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB = not MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB;
	BIB_MonkeyQuestButton_GetButtonText();

	if (MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_bLockBIB == true) then
		MonkeyQuest_Hide();
	else
		MonkeyQuestConfig[MonkeyQuest.m_strPlayer].m_strAnchor = "ANCHOR_TOPLEFT";
		MonkeyQuest_Show();
	end
end
