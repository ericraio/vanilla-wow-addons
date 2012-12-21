-- -- 
BuddySync = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.0", "AceConsole-2.0", "AceDB-2.0", "AceModuleCore-2.0", "AceDebug-2.0")
-- -- 
local debugLevels = {"warn", "info", "notice", "off"}
-- -- 
BuddySync:RegisterDB("BuddySyncDB")
BuddySync:RegisterDefaults("profile", {Debug = nil})
-- -- 
function BuddySync:OnEnable()
	-- 
	this:RegisterEvent("CHAT_MSG_SYSTEM", "BS_onEVENT")
	this:RegisterEvent("VARIABLES_LOADED", "BS_onEVENT")
	this:RegisterEvent("FRIENDLIST_UPDATE", "BS_onEVENT")
	-- 
	self:HookScript(FriendsFrame, "OnShow", "BS_SET_SHOW")
	self:HookScript(FriendsFrameAddFriendButton, "OnClick", "BS_ADD_FRIEND")
	self:HookScript(FriendsFrameIgnorePlayerButton, "OnClick", "BS_ADD_IGNORE")
	self:HookScript(FriendsFrameRemoveFriendButton, "OnClick", "BS_DELETE_FRIEND")
	self:HookScript(FriendsFrameStopIgnoreButton, "OnClick", "BS_STOP_IGNORE")
	self:HookScript(SendMailNameEditBox, "OnChar", "SendMailFrame_SendeeAutocomplete_EXPANDED")
	-- 
end
-- -- 
function BuddySync:SendMailFrame_SendeeAutocomplete_EXPANDED()
	-- 
	local text = this:GetText();
	local textlen = strlen(text);
	local name;
	-- 
	if BuddySyncDB[BSR][TOON] then
		if ( table.getn(BuddySyncDB[BSR][TOON]) > 0 ) then
			for i=1, table.getn(BuddySyncDB[BSR][TOON]) do
				name = BuddySyncDB[BSR][TOON][i];
				if ( strfind(strupper(name), strupper(text), 1, 1) == 1 ) then
					SendMailNameEditBox:SetText(name);
					SendMailNameEditBox:HighlightText(textlen, -1);
					return;
				end
			end
		end
	end
	return self.hooks[SendMailNameEditBox]["OnChar"].orig()
--[[ the original part -- just to see how ... 
	local text = this:GetText();
	local textlen = strlen(text);
	local numFriends, name;

	-- First check your friends list
	numFriends = GetNumFriends();
	if ( numFriends > 0 ) then
		for i=1, numFriends do
			name = GetFriendInfo(i);
			if ( strfind(strupper(name), strupper(text), 1, 1) == 1 ) then
				this:SetText(name);
				this:HighlightText(textlen, -1);
				return;
			end
		end
	end

	-- No match, check your guild list
	numFriends = GetNumGuildMembers(true);	-- true to include offline members
	if ( numFriends > 0 ) then
		for i=1, numFriends do
			name = GetGuildRosterInfo(i);
			if ( strfind(strupper(name), strupper(text), 1, 1) == 1 ) then
				this:SetText(name);
				this:HighlightText(textlen, -1);
				return;
			end
		end
	end
--]]
end
-- -- 
BuddySync:RegisterChatCommand({"/buddysync", "/bs"}, {
	type = "group",
	name = "BuddySync",
	args = {
		config = {
			type		= "execute",
			name		= "chat",
			desc		= "ChatOutput on/off",
			func		= function()
				if (BuddySyncDB[BSR].OUTPUT == 0) then
					BuddySyncDB[BSR].OUTPUT = 1;
				else
					BuddySyncDB[BSR].OUTPUT = 0;
				end
			end,
		},
	},
}, "BUDDYSYNC")
-- -- 
function BuddySync:BS_onEVENT(event)
	-- 
	if (event == "VARIABLES_LOADED") then
		-- setting up some vars
		BS_VER = "2.2.1";
		BSR = GetRealmName();
		pNAME = UnitName("player");
		FRIEND = "FRIEND";
		IGNORE = "IGNORE";
		TOON = "TOON";
		-- 
		if (not BuddySyncDB[BSR].OUTPUT) then
			BuddySyncDB[BSR].OUTPUT = 1;
		end
		-- 
		if (not BuddySyncDB[BSR][TOON]) then
			BuddySyncDB[BSR][TOON] = {};
		end
		-- 
		for i=1, table.getn(BuddySyncDB[BSR][TOON]) do
			if (BuddySyncDB[BSR][TOON][i] == pNAME) then
				isIN = 1;
				break;
			else
				isIN = nil;
			end
		end
		-- 
		if not isIN then
			table.insert(BuddySyncDB[BSR][TOON], pNAME);
		end
		-- 
		syncBTN = 0;
		syncCOUNT = 0;
		inamey = nil;
		namey = nil;
		IILT = 0;
		BSFS = 0;
		BSL = {};
		iBSL = {};
		i2BSL = {};
		BSA = 0;
		BSC = 0;
		BSN = 0;
		XDA = 0;
		EFE = 0;
		-- 
		this:UnregisterEvent("VARIABLES_LOADED");
		-- 
	elseif (event == "FRIENDLIST_UPDATE" or event == "IGNORELIST_UPDATE") then
		BuddySync:BS_FRIENDS();
	elseif (event == "CHAT_MSG_SYSTEM") then
		local BSX = BSSPLIT(getglobal("ERR_FRIEND_ADDED_S"), " ");
		local BSY = BSSPLIT(getglobal("ERR_FRIEND_REMOVED_S"), " ");
		local iBSX = BSSPLIT(getglobal("ERR_IGNORE_ADDED_S"), " ");
		local iBSY = BSSPLIT(getglobal("ERR_IGNORE_REMOVED_S"), " ");
		-- 
		if (BSA == 0 and strfind(arg1, BSX[2]) and strfind(arg1, BSX[3]) and strfind(arg1, BSX[4]) or
			strfind(arg1, BSY[2]) and strfind(arg1, BSY[3]) and strfind(arg1, BSY[4])) then
			BuddySync:BS_CHECK(1);
		elseif (BSA == 0 and strfind(arg1, iBSX[2]) and strfind(arg1, iBSX[3]) and strfind(arg1, iBSX[4])) then
			local namex = BSSPLIT(arg1, " ");
			local name = namex[1];
			iBSL[name] = {}
			iBSL[name].inIgnoreList = 1;
			BuddySync:BS_onSYNC();
		elseif (BSA == 0 and strfind(arg1, iBSY[2]) and strfind(arg1, iBSY[3]) and strfind(arg1, iBSY[4])) then
			BuddySync:BS_onSYNC();
		elseif (BSA == 1 and strfind(arg1, BSX[2]) and strfind(arg1, BSX[3]) and strfind(arg1, BSX[4])) then
			local namex = BSSPLIT(arg1, " ");
			local name = namex[1];
			BSL[name] = {};
			BSL[name].inFriendList = 1;
			BuddySyncDB[BSR][FRIEND][name] = {};
			BuddySyncDB[BSR][FRIEND][name].inFriendList = 1;
			BuddySync:BS_CHECK(1);
		elseif (BSA == 1 and strfind(arg1, iBSX[2]) and strfind(arg1, iBSX[3]) and strfind(arg1, iBSX[4])) then
			local namex = BSSPLIT(arg1, " ");
			local name = namex[1];
			iBSL[name] = {};
			iBSL[name].inIgnoreList = 1;
			BuddySyncDB[BSR][IGNORE][name] = {};
			BuddySyncDB[BSR][IGNORE][name].inIgnoreList = 1;
			BuddySync:BS_onSYNC();
		elseif (arg1 == getglobal("ERR_FRIEND_ERROR")) then
			EFE = 1;
		elseif (arg1 == getglobal("ERR_FRIEND_NOT_FOUND") and EFE == 0) then
			BuddySync:BS_CHECK(0);
		end
	end
end
-- -- 
function BuddySync:BS_FRIENDS()
	--
	local numFriends = GetNumFriends();
	local numIgnores = GetNumIgnores();
	--
	if (not BuddySyncDB or not BuddySyncDB[BS_VER]) then
		BuddySyncDB = {};
		BuddySyncDB[BS_VER] = 1;
	end	
	--
	if (not BuddySyncDB[BSR]) then
		BuddySyncDB[BSR] = {};
		BuddySyncDB[BSR][FRIEND] = {};
		BuddySyncDB[BSR][IGNORE] = {};
	end	
	--
	for j = 1, numIgnores do
		local name = GetIgnoreName(j);
		if (name and name ~= getglobal("UNKNOWN")) then
			if (not iBSL[name]) then
				iBSL[name] = {};
				iBSL[name].inIgnoreList = 1;
			end
			if (not BuddySyncDB[BSR][IGNORE][name]) then
				BuddySyncDB[BSR][IGNORE][name] = {};
				BuddySyncDB[BSR][IGNORE][name].inIgnoreList = 1;
			end
		end
	end
	--
	for i = 1, numFriends do
		local name = GetFriendInfo(i);
		if (name and name ~= getglobal("UNKNOWN")) then
			if (not BSL[name]) then
				BSL[name] = {};
				BSL[name].inFriendList = 1;
			end
			if (not BuddySyncDB[BSR][FRIEND][name]) then
				BuddySyncDB[BSR][FRIEND][name] = {};
				BuddySyncDB[BSR][FRIEND][name].inFriendList = 1;
			end
		end
	end
	--
	if (XDA == 0) then
		XDA = 1;
		BuddySync:BS_onSYNC();
	end
	--
end
--
function BuddySync:BS_CHECK(BSN)
	--
	EFE = 0;
	--
	if (syncBTN == 0 and BSN == 0) then
		if (BuddySyncDB[BSR]) then
			if (BuddySyncDB[BSR][FRIEND]) then
				if (BuddySyncDB[BSR][FRIEND][namey]) then
					if (BuddySyncDB[BSR][FRIEND][namey].inFriendList == 1) then
						DEFAULT_CHAT_FRAME:AddMessage("AddBuddy: |c00bfffff" .. namey .. "|r"..BS_PLAYER_NOT_FOUND_A..BSR..".", 1.0, 0.25, 0.0, 1.0);
						DEFAULT_CHAT_FRAME:AddMessage("AddBuddy: "..BS_PLAYER_NOT_FOUND_B, 1.0, 0.25, 0.0, 1.0);
						BuddySyncDB[BSR][FRIEND][namey] = nil;
					end
				end
			end
		end
	elseif (syncBTN == 1 and BSN == 0) then
		if (BuddySyncDB[BSR]) then
			if (BuddySyncDB[BSR][IGNORE]) then
				if (BuddySyncDB[BSR][IGNORE][inamey]) then
					if (BuddySyncDB[BSR][IGNORE][inamey].inIgnoreList == 1 and i2BSL[inamey].Try == 0) then
						if (BuddySyncDB[BSR].OUTPUT == 1) then
							DEFAULT_CHAT_FRAME:AddMessage("AddIgnore: |c00bfffff" .. inamey .. "|r"..BS_PLAYER_NOT_FOUND_I..BSR..".", 1.0, 0.25, 0.0, 1.0);
						end
						syncCOUNT = 0;
						i2BSL[inamey].Try = 1;
						BuddySync:BS_onSYNC();
					end
				end
			end
		end
	end
	--
	if (BSN == 1 and BuddySyncDB[BSR][FRIEND]) then
		for i,j in BuddySyncDB[BSR][FRIEND] do
			if (not BSL[i] and BuddySyncDB[BSR][FRIEND][i].inFriendList == 0) then
				-- nothing
			elseif (not BSL[i] and BuddySyncDB[BSR][FRIEND][i].inFriendList == 1) then
				if (i ~= pNAME) then
					namey = i;
					BSL[i] = {};
					BSL[i].inFriendList = 1;
					AddFriend(i);
					return namey;
				end
			elseif (BSL[i].inFriendList == 1 and BuddySyncDB[BSR][FRIEND][i].inFriendList == 0) then
				namey = i;
				BSL[i] = {};
				BSL[i].inFriendList = 0;
				RemoveFriend(i);
				return namey;
			end
		end
	end
	--
end
--
function BuddySync:BS_onSYNC()
	--
	syncCOUNT = syncCOUNT + 1;
	syncBTN = 1;
	--
	if (BuddySyncDB[BSR][IGNORE]) then
		for ii,jj in BuddySyncDB[BSR][IGNORE] do
			if (not i2BSL[ii] and ii) then
				i2BSL[ii] = {};
				i2BSL[ii].Try = 0;
			elseif (syncCOUNT == 2 and ii) then
				i2BSL = {};
				i2BSL[ii] = {};
				i2BSL[ii].Try = 0;
				syncCOUNT = 0;
			end
				if (not iBSL[ii] and BuddySyncDB[BSR][IGNORE][ii].inIgnoreList == 0) then
					XDA = 0;
					syncCOUNT = 0;
					inamey = ii;
					iBSL[ii] = {};
					iBSL[ii].inIgnoreList = 3;
					BuddySync:BS_FRIENDS();
					return inamey;
				elseif (not iBSL[ii] and BuddySyncDB[BSR][IGNORE][ii].inIgnoreList == 1) then
					if (i2BSL[ii].Try == 0) then
						inamey = ii;
						AddIgnore(ii);
						return inamey;
					end
				elseif (iBSL[ii].inIgnoreList == 1 and BuddySyncDB[BSR][IGNORE][ii].inIgnoreList == 0) then
					inamey = ii;
					iBSL[ii] = {};
					iBSL[ii].inIgnoreList = 0;
					DelIgnore(ii);
					return inamey;
				end
		end
	end
	--
end
--
function BuddySync:BS_SET_SHOW()
	--
	if (XDA == 1) then
	syncBTN = 0;
	BuddySync:BS_CHECK(1);
	end
	--
	return self.hooks[FriendsFrame]["OnShow"].orig()
	--
end
--
function BuddySync:BS_ADD_FRIEND()
	--
	BSA = 1;
	--
	return self.hooks[FriendsFrameAddFriendButton]["OnClick"].orig()
	--
end
--
function BuddySync:BS_DELETE_FRIEND()
	--
	BSA = 0;
	--
	local BSS = GetSelectedFriend();
	local name = GetFriendInfo(BSS);
	--
	BSL[name].inFriendList = 0;
	BuddySyncDB[BSR][FRIEND][name].inFriendList = 0;
	--
	return self.hooks[FriendsFrameRemoveFriendButton]["OnClick"].orig()
	--
end
--
function BuddySync:BS_ADD_IGNORE()
	--
	BSA = 1;
	--
	return self.hooks[FriendsFrameIgnorePlayerButton]["OnClick"].orig()
	--
end
--
function BuddySync:BS_STOP_IGNORE()
	--
	BSA = 0;
	--
	local BSS = GetSelectedIgnore();
	local name = GetIgnoreName(BSS);
	--
	iBSL[name].inIgnoreList = 0;
	BuddySyncDB[BSR][IGNORE][name].inIgnoreList = 0;
	--
	return self.hooks[FriendsFrameStopIgnoreButton]["OnClick"].orig()
	--
end
-- -- 
function BSSPLIT(text, separator, t, noPurge)
	-- 
	local value;
	local mstart, mend = 1;
	local oldn, numMatches = 0, 0;
	local regexKey = "([^"..separator.."]+)";
	local sfind = strfind;
	-- 
	if ( not t ) then
		t = {};
	else
		oldn = table.getn(t);
	end
	-- 
	mstart, mend, value = sfind(text, regexKey, mstart);
	-- 
	while (value) do
		numMatches = numMatches + 1;
		t[numMatches] = value
		mstart = mend + 1;
		mstart, mend, value = sfind(text, regexKey, mstart);
	end
	-- 
	if ( not noPurge ) then
		for i = numMatches+1, oldn do
			t[i] = nil;
		end
	end
	-- 
	table.setn(t, numMatches);
	return t;
end