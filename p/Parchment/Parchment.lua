--[[

Parchment

This is just a simple mod for writing notes. I often want to do things and forget as I get playing, so thought this to be a good way to write down notes to remember.
	
Author: Valnar (AKA: Thor)
Website: www.destroyersofhope.com
Email: thor@destroyersofhope.com
Patch Notes: Located in the PatchNotes.txt file

--]]

--------------------------------
-- Global Variables
--------------------------------
PARCHMENT_VERSION = "3.11";
PARCHMENT_DEFAULT_X = 0;
PARCHMENT_DEFAULT_Y = -104;
PARCHMENT_DEFAULT_TACK_X = 0;
PARCHMENT_DEFAULT_TACK_Y = -100;
PARCHMENT_CONFIG_LOADED = nil;
PARCHMENT_VARIABLES_LOADED = nil;
PARCHMENT_INITIAL_PLAYER = ""; -- First player that loads in
PARCHMENT_PLAYER = ""; -- The player we're viewing the Parchment for
PARCHMENT_TACK_HEIGHT = 27; -- Default height of the Tack window, 27 being the minimized size
PARCHMENT_DEFAULT_TACK_WIDTH = 300;
PARCHMENT_DEFAULT_BUTTONPOS = 320;
PARCHMENT_DEFAULT_ALPHA = 255;
PARCHMENT_CONFIRM_ACTION = "";
PARCHMENT_CONFIRM_ACTION_TEXT = "";
PARCHMENT_CONFIRM_ACTION_TITLE = "";
PARCHMENT_TACK_BUTTONS = 10;

--------------------------------
-- Bindings
--------------------------------
BINDING_HEADER_PARCHMENTHEADER = "Parchment";
SLASH_PARCHMENT1 = "/parchment";
SLASH_PARCHMENT2 = "/par";

--------------------------------
-- Startup Functions
--------------------------------
function Parchment_OnLoad()
	-- Register events
	this:RegisterForDrag("LeftButton");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_NAME_UPDATE");
	this:RegisterEvent("ADDON_LOADED");

	SlashCmdList["PARCHMENT"] = function(msg)
		Parchment_SlashCommandHandler(msg);
	end

	tinsert(UISpecialFrames,"ParchmentFrame");

	-- Register with ButtonHole
	if ButtonHole then
		ButtonHole.application.RegisterMod({id="Parchment032405", name="Parchment", tooltip="Easy Note Taking", buttonFrame="ParchmentButtonFrame", updateFunction="ParchmentButton_UpdatePosition"});
	end
end

ParchmentDetails = {
	name = "Parchment",
	version = PARCHMENT_VERSION,
	releaseDate = "Oct. 28, 2005",
	author = "Valnar",
	email = "thor@destroyersofhope.com",
	website = "http://www.destroyersofhope.com",
	category = MYADDONS_CATEGORY_OTHERS,
	frame = "ParchmentFrame",
	optionsFrame = "ParchmentOptionsFrame"
};

function Parchment_OnEvent(event)	
	if(event == "VARIABLES_LOADED") then
		PARCHMENT_VARIABLES_LOADED = 1;

		if(not PARCHMENT_CONFIG_LOADED) then
			-- Only want to continue if we haven't loaded our config
			PARCHMENT_INITIAL_PLAYER = UnitName("player");

			if (PARCHMENT_INITIAL_PLAYER ~= nil and PARCHMENT_INITIAL_PLAYER ~= UNKNOWNOBJECT) then
				-- We have a valid player so initialize
				Parchment_Init();
			end
		end
	elseif (event == "UNIT_NAME_UPDATE") then
		if(not PARCHMENT_CONFIG_LOADED) then
			-- Only want to continue if we haven't loaded our config
			PARCHMENT_INITIAL_PLAYER = UnitName("player");

			if (PARCHMENT_INITIAL_PLAYER ~= nil and PARCHMENT_INITIAL_PLAYER ~= UNKNOWNOBJECT) then
				-- We have a valid player so initialize
				Parchment_Init();
			end
		end
	elseif(event == "ADDON_LOADED" and arg1 == "Parchment") then
		-- Register the addon in myAddOns
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(ParchmentDetails);
		end
	end
end

function Parchment_Init()
	if(PARCHMENT_VARIABLES_LOADED) then
		-- Add the realm to the "player's name" for the config settings
		PARCHMENT_INITIAL_PLAYER = PARCHMENT_INITIAL_PLAYER.."|"..GetCVar("realmName");

		if(not Parchment_Data) then
			Parchment_Data = {};
		end

		if(not Parchment_Data["General"]) then
			Parchment_Data["General"] = {};
		end

		if(Parchment_Data["General"].text == nil) then
			Parchment_Data["General"].text = "";
		end

		if(Parchment_Data["General"].tacked == nil) then
			Parchment_Data["General"].tacked = false;
		end

		if(not Parchment_Data[PARCHMENT_INITIAL_PLAYER]) then
			Parchment_Data[PARCHMENT_INITIAL_PLAYER] = {};
		end	

		if(Parchment_Data[PARCHMENT_INITIAL_PLAYER].text == nil) then
			Parchment_Data[PARCHMENT_INITIAL_PLAYER].text = "";
		end

		if(Parchment_Data[PARCHMENT_INITIAL_PLAYER].tacked == nil) then
			Parchment_Data[PARCHMENT_INITIAL_PLAYER].tacked = false;
		end

		if(Parchment_Data[PARCHMENT_INITIAL_PLAYER].tack_expand == nil) then
			Parchment_Data[PARCHMENT_INITIAL_PLAYER].tack_expand = true;
		end

		if(Parchment_Data[PARCHMENT_INITIAL_PLAYER].tack_button == nil) then
			Parchment_Data[PARCHMENT_INITIAL_PLAYER].tack_button = 0;
		end

		if(not Parchment_Config) then
			Parchment_Config = {};
		end

		if(Parchment_Config.Locked == nil) then
			Parchment_Config.Locked = false;
		end

		if(Parchment_Config.AllRealms == nil) then
			Parchment_Config.AllRealms = false;
		end
		
		if(Parchment_Config.ButtonShow == nil) then
			Parchment_Config.ButtonShow = true;
		end

		if(Parchment_Config.ButtonPos == nil) then
			Parchment_Config.ButtonPos = PARCHMENT_DEFAULT_BUTTONPOS;
		end

		if(Parchment_Config.ShowTack == nil) then
			Parchment_Config.ShowTack = false;
		end

		if(Parchment_Config.LockTack == nil) then
			Parchment_Config.LockTack = false;
		end

		if(Parchment_Config.Minimized == nil) then
			Parchment_Config.Minimized = false;
		end

		if(Parchment_Config.Alpha == nil) then
			Parchment_Config.Alpha = PARCHMENT_DEFAULT_ALPHA;
		end

		if(Parchment_Config.TackBorder == nil) then
			Parchment_Config.TackBorder = true;
		end

		if(Parchment_Config.TackWidth == nil) then
			Parchment_Config.TackWidth = PARCHMENT_DEFAULT_TACK_WIDTH;
		end

		PARCHMENT_PLAYER = PARCHMENT_INITIAL_PLAYER;
		PARCHMENT_CONFIG_LOADED = true;
		ParchmentButton_UpdatePosition();
		ParchmentButton_Init();
		ParchmentTitleText:SetText("Parchment " .. PARCHMENT_VERSION);
		Parchment_Update();
	end
end

function Parchment_SlashCommandHandler(msg)
	if(not string.find(msg, "add ")) then
		msg = string.lower(msg);
	end

	if(msg == "") then
		ChatFrame1:AddMessage("|cffffff00/par toggle|r - This will toggle Parchment to be shown or hidden");
		ChatFrame1:AddMessage("|cffffff00/par defaults|r - Resets all Options to default values");
		ChatFrame1:AddMessage("|cffffff00/par lock /par unlock|r - Lock Parchment in place or unlock it");
		ChatFrame1:AddMessage("|cffffff00/par reset|r - Resets Parchment to its default screen position");
		ChatFrame1:AddMessage("|cffffff00/par allrealms /par thisrealm|r - View Chapters for all realms or just your current one");
		ChatFrame1:AddMessage("|cffffff00/par showbutton /par hidebutton|r - Show or hide the minimap button");
		ChatFrame1:AddMessage("|cffffff00/par tack /par untack|r - Tack the current Chapter to the Tack window");
		ChatFrame1:AddMessage("|cffffff00/par showtack /par hidetack|r - Show or hide the Tack window");
		ChatFrame1:AddMessage("|cffffff00/par locktack /par unlocktack|r - Lock or unlock the Tack window for movement");
		ChatFrame1:AddMessage("|cffffff00/par resettack - Resets the Tack|r window to its default screen position");
		ChatFrame1:AddMessage("|cffffff00/par showborder /par hideborder|r - Show or hide the Tack window border");
		ChatFrame1:AddMessage("|cffffff00/par add all/realm Name|r - This will add a Chapter to Parchment where 'all' indicates it will be seen from any Realm/Server, or 'realm' for it to be a Realm based Chapter, and Name is what you want to call that Chapter. Example, to add a Chapter called Engineering for all realms you'd do /par add all Engineering - |cffffff00NOTE:|r Use only single words for Chapter names");
		ChatFrame1:AddMessage("|cffffff00/par width size|r - Change the width of the Tack window, so /par width 200 would resize the Tack window to 200 pixels wide, the default being 300");
		ChatFrame1:AddMessage("|cffffff00Left clicking a Chapter|r in the Tack window will expand or collapse the text");
		ChatFrame1:AddMessage("|cffffff00Right clicking a Chapter|r in the Tack window will open Parchment to that Chapter");
		ChatFrame1:AddMessage("|cffffff00Shift + left clicking a Chapter|r in the Tack window will untack that Chapter");
	elseif(msg == "toggle") then
		ToggleParchment();
	elseif(msg == "defaults") then
		Parchment_Load_Defaults();
	elseif(msg == "lock") then
		Parchment_Config.Locked = true;
		Parchment_Update();
		ChatFrame1:AddMessage("Parchment is now locked in place");
	elseif(msg == "unlock") then
		Parchment_Config.Locked = false;
		Parchment_Update();
		ChatFrame1:AddMessage("Parchment is now unlocked for movement");
	elseif(msg == "reset") then
		Parchment_SetPosition("FORCED");
	elseif(msg == "resettack") then
		ParchmentTack_SetPosition();
	elseif(msg == "allrealms") then
		Parchment_Config.AllRealms = true;
		ChatFrame1:AddMessage("Viewing Chapters for all realms");
		Parchment_Update();
	elseif(msg == "thisrealm") then
		Parchment_Config.AllRealms = false;
		ChatFrame1:AddMessage("Viewing only Chapters from this realm");
		Parchment_Update();
	elseif(msg == "showbutton") then
		Parchment_Config.ButtonShow = true;
		ChatFrame1:AddMessage("Minimap button now being shown");
		Parchment_Update();
		ParchmentButtonFrame:Show();
	elseif(msg == "hidebutton") then
		Parchment_Config.ButtonShow = false;
		ChatFrame1:AddMessage("Minimap button show being hidden");
		Parchment_Update();
		ParchmentButtonFrame:Hide();
	elseif(msg == "tack") then
		Parchment_Data[PARCHMENT_PLAYER].tacked = true;
		ChatFrame1:AddMessage("This Chapter is now tacked");
		Parchment_Update();
	elseif(msg == "untack") then
		Parchment_Data[PARCHMENT_PLAYER].tacked = false;
		ChatFrame1:AddMessage("This Chapter is now untacked");
		Parchment_Update();
	elseif(msg == "hidetack") then
		Parchment_Config.ShowTack = false;
		ChatFrame1:AddMessage("The Tack window is now hidden");
		Parchment_Tack_Frame:Hide();
		Parchment_Update();
	elseif(msg == "showtack") then
		Parchment_Config.ShowTack = true;
		ChatFrame1:AddMessage("The Tack window is now shown");
		Parchment_Tack_Frame:Show();
		Parchment_Update();
	elseif(msg == "locktack") then
		Parchment_Config.LockTack = true;
		ChatFrame1:AddMessage("The Tack window is now locked");
		Parchment_Update();
	elseif(msg == "unlocktack") then
		Parchment_Config.LockTack = false;
		ChatFrame1:AddMessage("The Tack window is now unlocked");
		Parchment_Update(); -- Tack can be open while Parchment isn't so update it
	elseif(msg == "hideborder") then
		Parchment_Config.TackBorder = false;
		ChatFrame1:AddMessage("The Tack window border is now hidden");
		Parchment_Update();
	elseif(msg == "showborder") then
		Parchment_Config.TackBorder = true;
		ChatFrame1:AddMessage("The Tack window border is now shown");
		Parchment_Update();
	elseif(string.find(msg, "width ")) then
		local width = Parchment_Split(msg," ")[2];

		Parchment_Config.TackWidth = width;
		Parchment_Update();
	elseif(string.find(msg, "add ")) then
		 local where = Parchment_Split(msg," ")[2];
		 local new_parchment = Parchment_Split(msg, " ")[3];

		if(where) then
			if(where == "realm") then
				new_parchment = new_parchment.."|"..GetCVar("realmName");
			end
			if(not Parchment_Data[new_parchment]) then
				Parchment_Data[new_parchment] = {};
				Parchment_Data[new_parchment].text = "";
				Parchment_Data[new_parchment].tacked = false;
				Parchment_Data[new_parchment].tack_expand = true;
				Parchment_Data[new_parchment].tack_button = 0;

				ChatFrame1:AddMessage(new_parchment .. " has been added to Parchment");
				PARCHMENT_PLAYER = new_parchment;
				Parchment_Update();
			else
				ChatFrame1:AddMessage(new_parchment .. " already exists in Parchment");		
			end
		else
			ChatFrame1:AddMessage("You need to specify 'all' or 'realm' when adding a new Chapter");		
		end
	end
end

-------------------------------
-- Parchment Frame Functions
-------------------------------
function Parchment_OnDragStart()
	local par = getglobal("ParchmentFrame");

	if(Parchment_Config.Locked == false) then
		par:StartMoving();
	end
end

function Parchment_OnDragStop()
	local par = getglobal("ParchmentFrame");

	if(Parchment_Config.Locked == false) then
		par:StopMovingOrSizing();
	end
end

function ToggleParchment()
	if(ParchmentFrame:IsVisible()) then
		Parchment_OnHide();
	else
		Parchment_OnShow();
	end
end

function ToggleTack()
	if(Parchment_Tack_Frame:IsVisible()) then
		Parchment_SlashCommandHandler("hidetack");
	else
		Parchment_SlashCommandHandler("showtack");
	end
end

function Parchment_OnShow()
	PlaySound("igQuestListOpen");
	ShowUIPanel(ParchmentFrame);
	ParchmentDataFrame:Show();
end

function Parchment_OnHide()
	local par = getglobal("ParchmentFrame");

	if(par.isMoving) then
		par:StopMovingOrSizing();
	end
	
	ParchmentSaveText();
	PlaySound("igQuestListClose");
	ParchmentDataFrame:Hide();
	ParchmentOptionsFrame:Hide();
	ParchmentConfirmFrame:Hide();
	ParchmentAddChapterFrame:Hide();
	HideUIPanel(ParchmentFrame);
	Parchment_Update();
end

function ParchmentDataFrame_OnShow()
	-- Dropdown
	UIDropDownMenu_Initialize(Parchment_UserDropdown, Parchment_UserDropdown_Init);
	UIDropDownMenu_SetWidth(120, Parchment_UserDropdown);

	-- Tooltips
	Parchment_UserDropdown.tooltip = "You are viewing this player's Chapter";
	ParchmentDeleteButton.tooltip = "Click this to remove the selected character from Parchment";
	Parchment_Tack.tooltip = "Click to Tack this Chapter";

	-- Text
	ParchmentSetText();
	getglobal(Parchment_Tack:GetName().."Text"):SetText("Tack");
	Parchment_Update();
end

function ParchmentOptionsFrame_OnShow()
	-- Tooltips
	ParchmentResetButton.tooltip = "Moves Parchment to its default position";
	ParchmentLock_Check.tooltip = "Check to lock Parchment in place";
	ParchmentAllRealms.tooltip = "Check to view Chapters on all realms";
	ParchmentShowButton.tooltip = "Check to show the minimap icon";
	ParchmentShowTackButton.tooltip = "Check to show the Tack window";
	ParchmentLockTackButton.tooltip = "Check to lock the Tack window in place";
	ParchmentTackBorder.tooltip = "Check to show the border on the Tack window";
	ParchmentTackResetButton.tooltip = "Moves the Tack window to its default position";
	ParchmentAddChapterButton.tooltip = "Add a new Chapter to Parchment";

	-- Text
	getglobal(ParchmentLock_Check:GetName().."Text"):SetText("|cffcc0000Lock Parchment|r");
	getglobal(ParchmentAllRealms:GetName().."Text"):SetText("|cffcc0000View All Realms|r");
	getglobal(ParchmentShowButton:GetName().."Text"):SetText("|cffcc0000Show Minimap Icon|r");
	getglobal(ParchmentShowTackButton:GetName().."Text"):SetText("|cffcc0000Show Tack Window|r");
	getglobal(ParchmentLockTackButton:GetName().."Text"):SetText("|cffcc0000Lock Tack Window|r");
	getglobal(ParchmentTackBorder:GetName().."Text"):SetText("|cffcc0000Show Tack Window Border|r");

	getglobal(Parchment_Slider:GetName().."Text"):SetText("|cffcc0000Minimap Button Position");
	getglobal(Parchment_Slider:GetName().."High"):SetText();
	getglobal(Parchment_Slider:GetName().."Low"):SetText();

	getglobal(Parchment_Alpha:GetName().."Text"):SetText("|cffcc0000Transparency");
	getglobal(Parchment_Alpha:GetName().."High"):SetText();
	getglobal(Parchment_Alpha:GetName().."Low"):SetText();

	-- Set Sliders
	Parchment_Slider:SetValue(Parchment_Config.ButtonPos);
	Parchment_Alpha:SetValue(Parchment_Config.Alpha);

	Parchment_Update();
end

-------------------------------
-- Button Functions
-------------------------------
function Parchment_Cancel()
	ParchmentSetText();
	HideUIPanel(ParchmentFrame);
end

function Parchment_Clear()
	PARCHMENT_CONFIRM_ACTION_TEXT = "Are you sure you wish to clear all text from this Chapter?";
	PARCHMENT_CONFIRM_ACTION = "clear";
	PARCHMENT_CONFIRM_ACTION_TITLE = "Confirm Clear";
	getglobal("ParchmentConfirmFrameInfo"):SetText(PARCHMENT_CONFIRM_ACTION_TEXT);
	getglobal("ParchmentConfirmFrameTitle"):SetText(PARCHMENT_CONFIRM_ACTION_TITLE);
	ParchmentConfirmFrame:Show();
end

function Parchment_Load_Defaults()
	Parchment_Config.Locked = false;
	Parchment_Config.AllRealms = false;
	Parchment_Config.ButtonShow = true;
	ParchmentButton_UpdatePosition();
	Parchment_Config.ShowTack = false;
	Parchment_Config.ButtonPos = PARCHMENT_DEFAULT_BUTTONPOS;
	Parchment_Config.ShowTack = false;
	Parchment_Config.LockTack = false;
	Parchment_Config.Minimized = false;
	Parchment_Config.TackBorder = true;
	Parchment_Config.TackWidth = PARCHMENT_DEFAULT_TACK_WIDTH;
	Parchment_Config.Alpha = PARCHMENT_DEFAULT_ALPHA;

	Parchment_Slider:SetValue(Parchment_Config.ButtonPos);
	Parchment_Alpha:SetValue(Parchment_Config.Alpha);

	Parchment_SlashCommandHandler("reset");
	Parchment_SlashCommandHandler("resettack");

	Parchment_Update();
end

function Parchment_SetPosition(forced)
	local par = getglobal("ParchmentFrame");

	if(forced == "FORCED") then
		par:ClearAllPoints();
		par:SetPoint("TOPLEFT","UIParent","TOPLEFT", PARCHMENT_DEFAULT_X, PARCHMENT_DEFAULT_Y);
	end
end

function ParchmentTack_SetPosition()
	local tack = getglobal("Parchment_Tack_Frame");

	tack:ClearAllPoints();
	tack:SetPoint("TOPLEFT","UIParent","TOPLEFT", PARCHMENT_DEFAULT_TACK_X, PARCHMENT_DEFAULT_TACK_Y);
end

function Parchment_Delete_Character()
	PARCHMENT_CONFIRM_ACTION_TEXT = "Are you sure you wish to delete this Chapter?";
	PARCHMENT_CONFIRM_ACTION = "delete";
	PARCHMENT_CONFIRM_ACTION_TITLE = "Confirm Delete";
	getglobal("ParchmentConfirmFrameInfo"):SetText(PARCHMENT_CONFIRM_ACTION_TEXT);
	getglobal("ParchmentConfirmFrameTitle"):SetText(PARCHMENT_CONFIRM_ACTION_TITLE);
	ParchmentConfirmFrame:Show();
end

function ParchmentTab_OnClick(tab)
	if(not tab) then
		tab = this:GetID();
	end

	ParchmentConfirmFrame:Hide();

	if(tab == 1) then
		ParchmentOptionsFrame:Hide();
		ParchmentDataFrame:Show();
	else
		ParchmentDataFrame:Hide();
		ParchmentOptionsFrame:Show();
	end

	PlaySound("igCharacterInfoTab");
end

function ParchmentAddChapterButton_OnClick()
	if not(ParchmentAddChapterFrame:IsVisible()) then
		ParchmentAddChapterFrame:Show();
	end
end

-------------------------------
-- Checkbox Functions
-------------------------------
function ParchmentTackBorder_OnClick()
	local action;
	local checked = this:GetChecked();

	if(not checked) then
		action = "hideborder";
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		action = "showborder";
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

	Parchment_SlashCommandHandler(action);
end

function Parchment_Tack_Character()
	local action;
	local checked = this:GetChecked();

	if(not checked) then
		action = "untack";
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		action = "tack";
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

	Parchment_SlashCommandHandler(action);
end

function ParchmentTack_OnClick()
	local action;
	local checked = this:GetChecked();

	if(not checked) then
		action = "hidetack";
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		action = "showtack";
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

	Parchment_SlashCommandHandler(action);
end

function ParchmentLockTack_OnClick()
	local action;
	local checked = this:GetChecked();

	if(not checked) then
		action = "unlocktack";
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		action = "locktack";
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

	Parchment_SlashCommandHandler(action);
end

function ParchmentButton_Toggle()
	local action;
	local checked = this:GetChecked();

	if(not checked) then
		action = "hidebutton";
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		action = "showbutton";
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

	Parchment_SlashCommandHandler(action);
end

function ParchmentLock_CheckOnClick()
	local action;
	local checked = this:GetChecked();

	if(not checked) then
		action = "unlock";
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		action = "lock";
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

	Parchment_SlashCommandHandler(action);
end

function ParchmentAllRealms_CheckOnClick()
	local action;
	local checked = this:GetChecked();

	if(not checked) then
		action = "thisrealm";
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		action = "allrealms";
		PlaySound("igMainMenuOptionCheckBoxOn");
	end

	Parchment_SlashCommandHandler(action);
end

-------------------------------
-- Player Dropdown Functions
-------------------------------
function Parchment_UserDropdown_OnClick()
	ParchmentSaveText();
	PARCHMENT_PLAYER = this.value;
	ParchmentSetText();
	Parchment_Update();
end

function Parchment_UserDropdown_Init()
	local info;

	for key, value in Parchment_Data do
		local thisRealm = Parchment_Split(key, "|")[2];
		info = {};

		if(thisRealm) then
			if(Parchment_Config.AllRealms) then
				info.text = Parchment_Split(key,"|")[1].." of "..Parchment_Split(key,"|")[2];
			else
				if(thisRealm == GetCVar("realmName")) then
					info.text = Parchment_Split(key,"|")[1];
				end
			end
		else
			info.text = key; -- This is General or a created Chapter, not a player
		end

		if(info.text) then -- Should be the fix to the blank space showing from other realms when set to this realm
			info.value = key;
			info.func = Parchment_UserDropdown_OnClick;
			UIDropDownMenu_AddButton(info);
		end
	end
end

-------------------------------
-- Internal Functions
-------------------------------
function ParchmentSaveText()
	Parchment_Data[PARCHMENT_PLAYER].text = ParchmentEditBox:GetText();
end

function ParchmentSetText()
	ParchmentEditBox:SetText(Parchment_Data[PARCHMENT_PLAYER].text);
	Parchment_Text_Length:SetText(strlen(ParchmentEditBox:GetText()).." Characters");
end

function Parchment_UpdateTextLength()
	Parchment_Text_Length:SetText(strlen(ParchmentEditBox:GetText()).." Characters");
end

function Parchment_Update()
	if(ParchmentDataFrame:IsVisible()) then
		UIDropDownMenu_SetSelectedValue(Parchment_UserDropdown, PARCHMENT_PLAYER);

		local thisRealm = Parchment_Split(PARCHMENT_PLAYER, "|")[2];

		if(thisRealm) then
			if(Parchment_Config.AllRealms) then
				UIDropDownMenu_SetText(Parchment_Split(PARCHMENT_PLAYER,"|")[1].." of "..Parchment_Split(PARCHMENT_PLAYER,"|")[2], Parchment_UserDropdown);
			else
				UIDropDownMenu_SetText(Parchment_Split(PARCHMENT_PLAYER,"|")[1], Parchment_UserDropdown);
			end
		else
			UIDropDownMenu_SetText(PARCHMENT_PLAYER, Parchment_UserDropdown);
		end

		Parchment_Tack:SetChecked(Parchment_Data[PARCHMENT_PLAYER].tacked);
	elseif(ParchmentOptionsFrame:IsVisible()) then
		ParchmentLock_Check:SetChecked(Parchment_Config.Locked);
		ParchmentAllRealms:SetChecked(Parchment_Config.AllRealms);
		ParchmentShowButton:SetChecked(Parchment_Config.ButtonShow);
		ParchmentShowTackButton:SetChecked(Parchment_Config.ShowTack);
		ParchmentLockTackButton:SetChecked(Parchment_Config.LockTack);
		ParchmentTackBorder:SetChecked(Parchment_Config.TackBorder);
	end

	if(Parchment_Config.ShowTack == true) then
		Parchment_Update_Tack();
	end
end

function Parchment_Split(toCut, separator)
	local splitted = {};
	local i = 0;
	local regEx = "([^" .. separator .. "]*)" .. separator .. "?";

	for item in string.gfind(toCut .. separator, regEx) do
		i = i + 1;
		splitted[i] = Parchment_Trim(item) or '';
	end
	splitted[i] = nil;
	return splitted;
end

function Parchment_Trim (s)
	return (string.gsub(s, "^%s*(.-)%s*$", "%1"));
end

function Parchment_UpdateAlpha()
	Parchment_Tack_Frame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, Parchment_Config.Alpha);

end