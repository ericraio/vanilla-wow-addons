CT_PlayerSpells = { };
CT_ModVersion = 1.854;
CT_Mods = { };
CT_Options = { };
CT_MovableFrames = { };
CT_KeyBindings = { };
CT_MF_ShowFrames = nil;
CT_MASTERMOD_CPTITLE = CT_MASTERMOD_CPTITLE .. " v" .. CT_ModVersion;

function CT_GetPlayerSpells()
	CT_PlayerSpells = { };
	for i = 1, GetNumSpellTabs(), 1 do
		local name, texture, offset, numSpells = GetSpellTabInfo(i);
		for y = 1, numSpells, 1 do
			local spellName, rankName = GetSpellName(offset+y, BOOKTYPE_SPELL);
			local useless, useless, rank = string.find(rankName, "(%d+)");
			if ( tonumber(rank) ) then
				if ( not CT_PlayerSpells[spellName] or CT_PlayerSpells[spellName]["rank"] < tonumber(rank) ) then
					CT_PlayerSpells[spellName] = { ["rank"] = tonumber(rank), ["tab"] = i, ["spell"] = y+offset };
				end
			end
		end
	end
end

function CT_AddMovable(frame, name, point, relpoint, relframe, xOffset, yOffset, lockfunc, resetfunc)
	if ( not frame or not name or not point or not relpoint or not relframe or not xOffset or not yOffset ) then
		return nil;
	end

	tinsert(CT_MovableFrames, {
		["frame"] = frame,
		["name"] = name,
		["point"] = point,
		["relpoint"] = relpoint,
		["relframe"] = relframe,
		["x"] = xOffset,
		["y"] = yOffset,
		["lockfunc"] = lockfunc,
		["resetfunc"] = resetfunc
	});
	return 1;
end

function CT_ResetMovables()
	for key, val in CT_MovableFrames do
		getglobal(val["frame"]):ClearAllPoints();
		getglobal(val["frame"]):SetPoint(val["point"], val["relframe"], val["relpoint"], val["x"], val["y"]);
		if ( val["resetfunc"] ) then
			val["resetfunc"]();
		end
	end
end

function CT_ResetFrameByName(name)
	for key, val in CT_MovableFrames do
			if ( val["frame"] == name ) then
			getglobal(val["frame"]):ClearAllPoints();
			getglobal(val["frame"]):SetPoint(val["point"], val["relframe"], val["relpoint"], val["x"], val["y"]);
			if ( val["resetfunc"] ) then
				val["resetfunc"]();
			end
		end
	end
end

function CT_LockMovables(status)
	CT_MF_ShowFrames = status;
	for key, val in CT_MovableFrames do
		if ( val["lockfunc"] ) then
			val["lockfunc"](status);
		end
	end
end

function CT_Replace(text, search, replace)
	if ( search == replace) then return text; end
	local searchedtext = "";
	local textleft = text;
	while ( strfind ( textleft, search, 1) ) do
		searchedtext = searchedtext .. strsub ( textleft, 1, strfind( textleft, search, 1)-1 ) .. replace;
		textleft = strsub ( textleft, strfind( textleft, search, 1)+strlen(search) );
	end
	if ( strlen(textleft) > 0 ) then
		searchedtext = searchedtext .. textleft;
	end
	return searchedtext;
end

function CT_Print(msg, r, g, b, frame) 
	if ( not r ) then r=1.0; end;
	if ( not g ) then g=1.0; end;
	if ( not b ) then b=1.0; end;
	if ( frame ) then 
		frame:AddMessage(msg,r,g,b);
	else
		DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
	end
end

function CT_RegisterMod(modName, modDescript, modType, modIcon, modTooltip, modStatus, modValue, modFunc, modInitFunction, modOrder, modOnDisplay)
	local temp = { };
	if ( modName and strlen(modName) > 0 ) then temp["modName"] = modName; else temp["modName"] = ""; end
	if ( modDescript and strlen(modDescript) > 0 ) then temp["modDescript"] = modDescript; else temp["modDescript"] = ""; end
	if ( modTooltip and strlen(modTooltip) > 0 ) then temp["modTooltip"] = modTooltip; else temp["modTooltip"] = ""; end
	if ( modIcon and strlen(modIcon) > 0 ) then temp["modIcon"] = modIcon; else temp["modIcon"] = "Interface\\Icons\\INV_Misc_QuestionMark"; end
	if ( modStatus )  then temp["modStatus"] = modStatus; else temp["modStatus"] = "off"; end
	if ( modValue ) then temp["modValue"] = modValue; end
	if ( modFunc ) then temp["modFunc"] = modFunc; end
	if ( modInitFunction ) then temp["modInitFunc"] = modInitFunction; end
	if ( modType ) then temp["modType"] = modType; else temp["modType"] = 1; end
	if ( modOnDisplay ) then temp["modOnDisplay"] = modOnDisplay; end
	if ( modOrder ) then
		temp["modOrder"] = modOrder;
	else
		local usedNum = { };
		local numInCategory = 0;
		for key, val in CT_Mods do
			if ( val["modType"] == temp["modType"] ) then
				usedNum[val["modOrder"]] = 1;
			end
		end
		local i = 1;
		while ( usedNum[i] ) do
			i = i + 1;
		end
		temp["modOrder"] = i;
	end
	CT_Mods[modName] = temp;
end

function CT_GetModStatus(modName)
	if ( CT_Mods[modName] ) then
		return CT_Mods[modName]["modStatus"];
	end
end

function CT_SetModStatus(modName, status)
	CT_Mods[modName]["modStatus"] = status;
	CT_SaveInfoName(modName);
end

function CT_GetModValue(modName)
	if ( CT_Mods[modName] ) then
		return CT_Mods[modName]["modValue"];
	end
end

function CT_SetModValue(modName, value)
	CT_Mods[modName]["modValue"] = value;
	CT_SaveInfoName(modName);
end

function CT_SaveInfoName(modName)
	if ( not CT_Options[UnitName("player")] ) then
		CT_Options[UnitName("player")] = { };
	end
	CT_Options[UnitName("player")][modName] = { };
	for key, val in CT_Mods[modName] do
		if ( key == "modStatus" or key == "modValue" or key == "hasBeenDisplayed" ) then
			CT_Options[UnitName("player")][modName][key] = val;
		end
	end
end

function CT_Master_OnEvent(event)
	if ( event == "VARIABLES_LOADED" ) then
		if ( not CT_Options["version"] ) then
			CT_Options = { };
			CT_Options["version"] = CT_ModVersion;
			CT_Print("<CTMod> " .. CT_MASTERMOD_FIRSTLOAD, 0.3, 1.0, 0.3);
		else
			CT_Options["version"] = CT_ModVersion;
			if ( CT_Options[UnitName("player")] ) then
				for key, val in CT_Options[UnitName("player")] do
					if ( key ~= "version" ) then
						if ( CT_Mods[key] ) then
							for k, v in val do
								CT_Mods[key][k] = v;
							end
						end
					end
				end
				for key, val in CT_Mods do
					if ( val["modInitFunc"] ) then
						val["modInitFunc"](key);
					end
				end
			end
		end
		--CT_SetKeyBindings(UnitName("player").."@"..GetCVar("realmName"));
		CT_LockMovables(CT_MF_ShowFrames);
	end

	if ( event == "SPELLS_CHANGED" ) then
		CT_GetPlayerSpells();
	end
end

function CT_Master_UnregisterMod(name)
	CT_Mods[name] = nil;
end

function CT_LinkFrameDrag(frame, drag, point, relative, x, y)
	frame:ClearAllPoints();
	frame:SetPoint(point, drag:GetName(), relative, x, y);
end

CT_oldToggleFramerate = ToggleFramerate;
function CT_newToggleFramerate()
	if ( CTFramerate:IsVisible() ) then
		CTFramerate:Hide();
	else
		CTFramerate:Show()

	end
	CT_Master_GlobalFrame.fpsTime = 0;
end
ToggleFramerate = CT_newToggleFramerate;

function CT_Master_GlobalFrame_OnUpdate(elapsed)
	if ( CTFramerate:IsVisible() ) then
		local timeLeft = this.fpsTime - elapsed
		if ( timeLeft <= 0 ) then
			this:SetScale(UIParent:GetScale());
			this.fpsTime = FRAMERATE_FREQUENCY;
			CTFramerateText:SetText(format("%.1f", GetFramerate()));
		else
			this.fpsTime = timeLeft;
		end
	end
end

SLASH_PRI1 = "/pri";
SlashCmdList["PRI"] = function(msg)
	RunScript("CT_Print(" .. msg .. ")");
end

SLASH_CTUNLOCK1 = "/ctunlock";
SlashCmdList["CTUNLOCK"] = function(msg)
	CT_Print("<CTMod> " .. CT_MASTERMOD_UNLOCKED, 1, 1, 0);
	CT_LockMovables(1);
	CT_SetModStatus(CT_MASTERMOD_MODNAME_UNLOCK, "on");
end

SLASH_CTUNLOCK1 = "/ctlock";
SlashCmdList["CTLOCK"] = function(msg)
	CT_Print("<CTMod> " .. CT_MASTERMOD_LOCKED, 1, 1, 0);
	CT_LockMovables(nil);
	CT_SetModStatus(CT_MASTERMOD_MODNAME_UNLOCK, "off");
end

function CT_SetKeyBindings(name, force )
	if ( CT_KeyBindings[name] and not force ) then
		for k, v in CT_KeyBindings[name] do
			SetBinding(v[1], v[2]);
		end
	else
		CT_KeyBindings[name] = { };
		for i = 1, GetNumBindings(), 1 do
			CT_SaveKeyBinding(name, GetBinding(i));
		end
	end
end

function CT_SaveKeyBinding(name, command, ...)
	for i = 1, arg.n, 1 do
		tinsert(CT_KeyBindings[name], { arg[i], command });
	end
end

CT_oldResetBindings = ResetBindings;
function CT_newResetBindings()
	CT_oldResetBindings();
	CT_SetKeyBindings(UnitName("player").."@"..GetCVar("realmName"), 1);
end
--ResetBindings = CT_newResetBindings;

CT_oldSaveBindings = SaveBindings;
function CT_newSaveBindings()
	CT_oldSaveBindings();
	CT_SetKeyBindings(UnitName("player").."@"..GetCVar("realmName"), 1);
end
--SaveBindings = CT_newSaveBindings;

CT_oldSetItemRef = SetItemRef;
function CT_newSetItemRef(link, text, button)
	if ( strsub(link, 1, 6) == "player" ) then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
			name = gsub(name, "([^%s]*)%s+([^%s]*)", "%2");
			if ( IsControlKeyDown() ) then
				for i = 1, GetNumRaidMembers(), 1 do
					if ( UnitName("raid" .. i) == name ) then
						TargetUnit("raid" .. i);
						return;
					end
				end
				for i = 1, GetNumPartyMembers(), 1 do
					if ( UnitName("party" .. i) == name ) then
						TargetUnit("party" .. i);
						return;
					end
				end
				TargetByName(name);
				return;
			end
		end
	end
	CT_oldSetItemRef(link, text, button);
end
SetItemRef = CT_newSetItemRef;

BINDING_HEADER_CT_TARGETLAST = "Target Last Target";
BINDING_NAME_CT_TARGETLASTTARGET = "Target Last Target";
BINDING_NAME_CT_TARGETLASTTARGET = "Target Last Target";