-- Global variables
CLASSICONS_VERSION = "1.0.2";

function ClassIcons_OnLoad()

	-- Set up slash commands
	SlashCmdList["CLASSICONS"] = ClassIcons_CmdHandler;
	SLASH_CLASSICONS1 = "/classicons";
	SLASH_CLASSICONS2 = "/ci";

	-- Register for events
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PARTY_MEMBER_ENABLE");

end

function ClassIcons_CmdHandler(msg)

	if ( msg == "on" ) then
		CLASSICONS_CONFIG.Active = true;
		DEFAULT_CHAT_FRAME:AddMessage("[ClassIcons] Activated.");
		
		ClassIcons_OnEvent["PLAYER_ENTERING_WORLD"]();
		ClassIcons_OnEvent["PLAYER_TARGET_CHANGED"]();
		ClassIcons_OnEvent["PARTY_MEMBERS_CHANGED"]();

		return;
	end

	if ( msg == "off" ) then
		CLASSICONS_CONFIG.Active = false;
		DEFAULT_CHAT_FRAME:AddMessage("[ClassIcons] Deactivated.");
		
		ClassIcons_OnEvent["PLAYER_ENTERING_WORLD"]();
		ClassIcons_OnEvent["PLAYER_TARGET_CHANGED"]();
		ClassIcons_OnEvent["PARTY_MEMBERS_CHANGED"]();

		return;
	end

	DEFAULT_CHAT_FRAME:AddMessage("[ClassIcons] Use on/off to control icon visibility.");

end

function ClassIcons_UpdateIcon(frame, unit)

	if ( not frame ) or ( not unit ) then
		return;
	end

	local icon = getglobal(frame.."ClassIcon");
	local texture = getglobal(frame.."ClassIconTexture");

	if ( not icon ) or ( not texture ) then
		return;
	end

	if ( CLASSICONS_CONFIG.Active == false ) then
		if ( icon:IsVisible() ) then icon:Hide(); end
		return;
	end

	local localizedClass, englishClass = UnitClass(unit);

	if ( not englishClass ) then
		return;
	end

	if ( not icon:IsVisible() ) then
		icon:Show();
	end

	texture:SetTexture("Interface\\AddOns\\ClassIcons\\Icons\\"..englishClass);

end

function ClassIcons_OnEvent(event)

	if ( event == "VARIABLES_LOADED" ) then

		if ( CLASSICONS_CONFIG == nil ) then
			CLASSICONS_CONFIG = { };
		end
	
		if ( CLASSICONS_CONFIG.Active == nil ) then
			CLASSICONS_CONFIG.Active = true;
		end
	
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then

		ClassIcons_UpdateIcon("PlayerFrame", "player");

	elseif ( event == "PLAYER_TARGET_CHANGED" ) then

		ClassIcons_UpdateIcon("TargetFrame", "target");
		
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) or
		   ( event == "PARTY_MEMBER_ENABLE"   ) then

		for i = 1, 4 do
	
			ClassIcons_UpdateIcon("PartyMemberFrame"..i, "party"..i);
	
		end
		
	end

end

function ClassIcons_Icon_OnLoad()
	this:SetFrameLevel(this:GetFrameLevel()+2);
end

